From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: GRBM lock in  vce_v3_0_check_soft_reset(void *handle)
Date: Thu, 11 Aug 2016 13:42:08 +0000
Message-ID: <DM5PR12MB1132C484EBCA91DDF9FEA44CF71E0@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1201991962=="
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1201991962==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132C484EBCA91DDF9FEA44CF71E0DM5PR12MB1132namp_"

--_000_DM5PR12MB1132C484EBCA91DDF9FEA44CF71E0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm working on tidying up vce v3 and came across the function


static int vce_v3_0_check_soft_reset(void *handle)


Which writes to the GRBM_GFX_INDEX but doesn't take the mutex around it.  N=
or does the parent function in amdgpu_device.c which calls all of the check=
_soft_reset callbacks.


Is this a bug?


Tom

--_000_DM5PR12MB1132C484EBCA91DDF9FEA44CF71E0DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>I'm working on tidying up vce v3 and came across the function</p>
<p><br>
</p>
<p></p>
<div>static int vce_v3_0_check_soft_reset(void *handle)</div>
<div><br>
</div>
<p></p>
<p>Which writes to the GRBM_GFX_INDEX but doesn't take the mutex around it.=
 &nbsp;Nor does the parent function in amdgpu_device.c which calls all of t=
he check_soft_reset callbacks.</p>
<p><br>
</p>
<p>Is this a bug? &nbsp;</p>
<p><br>
</p>
<p>Tom</p>
</div>
</body>
</html>

--_000_DM5PR12MB1132C484EBCA91DDF9FEA44CF71E0DM5PR12MB1132namp_--

--===============1201991962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1201991962==--
