Shader "Holistic/BumpedEnvironment"
{
	Properties{
		_myDiffuse("Diffuse Texture", 2D) = "white" {}
		_myBump("Bump Texture", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0,10)) = 1
		_myBright("Brightness", Range(0,10)) = 1
		_myCube("Cube Map", CUBE) = "white" {}
	}
		SubShader{
		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myDiffuse;
			sampler2D _myBump;
			half _mySlider;
			half _myBright;
			samplerCUBE _myCube;

			struct Input {
				float2 uv_myDiffuse; //using 2d UV
				float2 uv_myBump; //using 2d UV
				float3 worldRefl;  INTERNAL_DATA //using vectors 3d, uses INTERNAL_DATA to use an i nternal data set and not the one passed in so that we can modify the normals without it freaking out when setting emissions
			};

			void surf(Input IN, inout SurfaceOutput o) {
				//note you have to make sure that your texture for the normal map has its Texture Type property changed to Normal Map in Unity (it defaults to Default)
				o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
				o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * _myBright; //convert them into a normal vertex value
				o.Normal *= float3(_mySlider, _mySlider, 1); //multiply x & y by the slider value... this will angle that normal even more and make it darker.  Keeping Z 1
				o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb; //given the normals of the model itself (IN) calculate the world reflection vector to set the color of the emission

				//we need to be able to modify the normals but not affect WorldReflectionVector - otherwise it errors out.  We add INTERNAL_DATA to the worldRefl variablea bove for this
				//we get a reflection in all of the little creases now, and there is none of this in geography - its all done in code
			}
		ENDCG
	}
	Fallback "Diffuse"
}