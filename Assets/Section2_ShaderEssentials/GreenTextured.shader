Shader "Holistic/GreenTextured"
{
    Properties //input values coming in from the editor
    {
        _myTex("Example Texture", 2D) = "white" {}
    }
    SubShader //the shader app doing the things
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myTex; //note that this matches, but check out the input below!

        struct Input {
            float2 uv_myTex; //note this name is myTex which matches above, but we have to prefix it with uv also
        };

        void surf(Input IN, inout SurfaceOutput o) {
            //create a shader that takes in a texture, but always cranks green to max
            /*
            o.Albedo = (tex2D(_myTex, IN.uv_myTex)).rgb; //by multiplying this by the range, it makes the model brighter and brighter, the higher a color value, the brighter it gets
            o.Albedo.g = 1;
            */

            //create a shader that takes in a texture.  To this texture before applying it to the albedo, apply color green
            float4 green = float4(0, 1, 0, 1); //creating a color on the fly with code
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * green).rgb;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
