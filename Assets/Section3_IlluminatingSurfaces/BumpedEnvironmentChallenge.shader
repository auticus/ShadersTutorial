/*
Create a shader that takes a normal map and a cube map.  The normal map is to be unwrapped onto the surface normals and then multiplied by 0.3.
The cube map should be used to set the Albedo.  This will give a metallic reflective bump mapped surface.
*/
Shader "Holistic/BumpedEnvChallenge"
{
    Properties{
        _myBump("Bump Texture", 2D) = "bump" {}
        _myCube("Cube Map", CUBE) = "white" {}
    }
        SubShader{

          CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myBump;
            samplerCUBE _myCube;

            struct Input {
                float2 uv_myBump;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf(Input IN, inout SurfaceOutput o) {
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * 0.3;
                o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
            }

          ENDCG
    }
        Fallback "Diffuse"
}