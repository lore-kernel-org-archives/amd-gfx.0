From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: amdgpu_pm_info small nit
Date: Tue, 10 Jan 2017 19:01:12 +0000
Message-ID: <CY4PR12MB1768A1C2762C6946CD818D20F7670@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0571636871=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0571636871==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768A1C2762C6946CD818D20F7670CY4PR12MB1768namp_"

--_000_CY4PR12MB1768A1C2762C6946CD818D20F7670CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Ray,


Small nit but I saw this in the output


+       {AMD_CG_SUPPORT_GFX_CGTS, "Graphics Coarse Grain Tree Shader Light =
Sleep"},
+       {AMD_CG_SUPPORT_GFX_CGTS_LS, "Graphics Coarse Grain Tree Shader Lig=
ht Sleep"},

The first you probably want to remove "Light Sleep" from otherwise the outp=
ut has a duplicate line for different bits.


Cheers,

Tom

--_000_CY4PR12MB1768A1C2762C6946CD818D20F7670CY4PR12MB1768namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Ray,</p>
<p><br>
</p>
<p>Small nit but I saw this in the output&nbsp;</p>
<p><br>
</p>
<p></p>
<div>&#43; &nbsp; &nbsp; &nbsp; {AMD_CG_SUPPORT_GFX_CGTS, &quot;Graphics Co=
arse Grain Tree Shader Light Sleep&quot;}, &nbsp;&nbsp;</div>
<div>&#43; &nbsp; &nbsp; &nbsp; {AMD_CG_SUPPORT_GFX_CGTS_LS, &quot;Graphics=
 Coarse Grain Tree Shader Light Sleep&quot;},</div>
<div><br>
</div>
The first you probably want to remove &quot;Light Sleep&quot; from otherwis=
e the output has a duplicate line for different bits.
<p></p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
</div>
</body>
</html>

--_000_CY4PR12MB1768A1C2762C6946CD818D20F7670CY4PR12MB1768namp_--

--===============0571636871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0571636871==--
