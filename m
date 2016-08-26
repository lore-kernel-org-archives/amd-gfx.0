From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: cz smu cleanups
Date: Fri, 26 Aug 2016 16:38:15 +0000
Message-ID: <DM5PR12MB113282467501A9274460B5A2F7EC0@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0343957313=="
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

--===============0343957313==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB113282467501A9274460B5A2F7EC0DM5PR12MB1132namp_"

--_000_DM5PR12MB113282467501A9274460B5A2F7EC0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Still on the topic of the smu code I see (in cz_smu_construct_toc_for_bootu=
p())


cz_smu_populate_single_ucode_load_task(smumgr,
CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false);
if (smumgr->chip_id =3D=3D CHIP_STONEY)
cz_smu_populate_single_ucode_load_task(smumgr,
CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false);
else
cz_smu_populate_single_ucode_load_task(smumgr,
CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT2, false);


Which seems odd that it is loading twice for STONEY.  Shouldn't it just be =
!=3D CHIP_STONEY and omit the first path?


Tom

--_000_DM5PR12MB113282467501A9274460B5A2F7EC0DM5PR12MB1132namp_
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
<p>Still on the topic of the smu code I see (in&nbsp;<span>cz_smu_construct=
_toc_for_bootup())</span></p>
<p><br>
</p>
<p></p>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>cz_smu=
_populate_single_ucode_load_task(smumgr,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>CZ_SCR=
ATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>if (sm=
umgr-&gt;chip_id =3D=3D CHIP_STONEY)</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>cz_smu=
_populate_single_ucode_load_task(smumgr,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>CZ_SCR=
ATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>else</=
div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>cz_smu=
_populate_single_ucode_load_task(smumgr,</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>CZ_SCR=
ATCH_ENTRY_UCODE_ID_CP_MEC_JT2, false);</div>
<div><br>
</div>
<p></p>
<p>Which seems odd that it is loading twice for STONEY. &nbsp;Shouldn't it =
just be !=3D CHIP_STONEY and omit the first path?</p>
<p><br>
</p>
<p>Tom</p>
</div>
</body>
</html>

--_000_DM5PR12MB113282467501A9274460B5A2F7EC0DM5PR12MB1132namp_--

--===============0343957313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0343957313==--
