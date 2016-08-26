From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Errant return in Carrizo SMU code
Date: Fri, 26 Aug 2016 13:07:28 +0000
Message-ID: <DM5PR12MB113206AD5B953EDDB8A1A215F7EC0@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1865316521=="
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

--===============1865316521==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB113206AD5B953EDDB8A1A215F7EC0DM5PR12MB1132namp_"

--_000_DM5PR12MB113206AD5B953EDDB8A1A215F7EC0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In the function


static int cz_check_fw_load_finish(struct pp_smumgr *smumgr,
  uint32_t firmware);

On line 198 of powerplay/smumgr/cz_smumgr.c there is an unconditional retur=
n in the middle of the function.  Is that an error or is the code after it =
truly dead code?

Tom

--_000_DM5PR12MB113206AD5B953EDDB8A1A215F7EC0DM5PR12MB1132namp_
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
<p>In the function</p>
<p><br>
</p>
<p></p>
<div>static int cz_check_fw_load_finish(struct pp_smumgr *smumgr,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>&nbsp;=
 uint32_t firmware);</div>
<div><br>
</div>
<div>On line 198 of powerplay/smumgr/cz_smumgr.c there is an unconditional =
return in the middle of the function. &nbsp;Is that an error or is the code=
 after it truly dead code?</div>
<div><br>
</div>
<div>Tom</div>
<p></p>
</div>
</body>
</html>

--_000_DM5PR12MB113206AD5B953EDDB8A1A215F7EC0DM5PR12MB1132namp_--

--===============1865316521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1865316521==--
