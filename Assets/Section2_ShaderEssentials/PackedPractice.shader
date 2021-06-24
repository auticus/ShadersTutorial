Shader "Holistic/ShaderProperties"
{
    Properties //input values coming in from the editor
    {
        _myColour ("Example Colour", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(0,5)) = 1
        _myTex("Example Texture", 2D) = "white" {}
        _myCube("Example Cube", CUBE) = "" {}
        _myFloat ("Example Float", Float) = 0.5
        _myVector ("Example Vector", Vector) = (0.5,1,1,1)
    }
    SubShader //the shader app doing the things
    {
        CGPROGRAM
        #pragma surface surf Lambert

        fixed4 _myColour;
        half _myRange;
        sampler2D _myTex; //note that this matches, but check out the input below!
        samplerCUBE _myCube;
        float _myFloat;
        float4 _myVector;

        struct Input {
            float2 uv_myTex; //note this name is myTex which matches above, but we have to prefix it with uv also
            float3 worldRefl;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            //o.Albedo = _myColour.rgb; //Albedo has 3 elements, we can't use all 4 elements in color so we just use rgb (element 0, 1, and 2)
            //o.Albedo.r = _myColor.r //only take the red channel, could also have used x instead of r because we can use x,y,z and w - you CANNOT say xy = xg because you cant mix x and g
            //o.Albedo = tex2D(_myTex, IN.uv_myTex).rgb; //slapping a texture onto the model - thats how the colors on the texture become the colors on the albedo property of the model
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange * _myColour).rgb; //by multiplying this by the range, it makes the model brighter and brighter, the higher a color value, the brighter it gets
            //challenge 1 - added _myColour to also include the color

            //setting the emission to the cubebox rgb, if you turn the range down you'll see the bunny shinier with the galaxy showing
            //rotating bunny around it appears as if it is reflecting where the galaxy would be if it was in the skybox
            //adding the sky to the skybox of the camera will show this to its full effect, zombunny will be in space
            o.Emission = texCUBE(_myCube, IN.worldRefl).rgb; 
        }

        ENDCG
    }
    FallBack "Diffuse"
}
