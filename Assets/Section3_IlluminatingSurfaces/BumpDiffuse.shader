Shader "Holistic/BumpDiffuse"
{
	Properties{
		_myDiffuse("Diffuse Texture", 2D) = "white" {}
		_myBump("Bump Texture", 2D) = "bump" {} //dont want to use it as colors, want to use it as a bump map
		_mySlider ("Bump Amount", Range(0,10)) = 1 //objective: darken the dark areas even more by this amount
		_myScale("Texture Bump Scale", Range(0.5, 2)) = 1 //objective: scale the texture down even more and make it smaller and smaller
	}
		SubShader{
			CGPROGRAM
				#pragma surface surf Lambert
				sampler2D _myDiffuse;
				sampler2D _myBump;
				half _mySlider;
				half _myScale;
				
				struct Input {
					float2 uv_myDiffuse;
					float2 uv_myBump;
				};

				void surf(Input IN, inout SurfaceOutput o) {
					//note you have to make sure that your texture for the normal map has its Texture Type property changed to Normal Map in Unity (it defaults to Default)
					o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse * _myScale).rgb;
					o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump * _myScale));  //convert them into a normal vertex value
					o.Normal *= float3(_mySlider, _mySlider, 1);  //multiply x & y by the slider value... this will angle that normal even more and make it darker.  Keeping Z 1 
				}
		ENDCG
	}
	Fallback "Diffuse"
}