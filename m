From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if they were
 disabled by user
Date: Tue, 16 Oct 2018 17:28:43 +0000
Message-ID: <BYAPR12MB27755045315022D06DCC17EEFBFE0@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1539668026-4854-1-git-send-email-Rex.Zhu@amd.com>
 <BN6PR12MB1809AE48F3B1FD9CCB1DEFA0F7FE0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BLUPR12MB0452631CCD03B605244486CFF2FE0@BLUPR12MB0452.namprd12.prod.outlook.com>
 <BYAPR12MB27751B1475028EAE09DD4E84FBFE0@BYAPR12MB2775.namprd12.prod.outlook.com>
 <BLUPR12MB045259BF2DFB784D669B3189F2FE0@BLUPR12MB0452.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457296521=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB045259BF2DFB784D669B3189F2FE0-7LeqcoF/hwohIaQXubWUmgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1457296521==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB27755045315022D06DCC17EEFBFE0BYAPR12MB2775namp_"

--_000_BYAPR12MB27755045315022D06DCC17EEFBFE0BYAPR12MB2775namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The code base is different.
And do you set ip_block_mask =3D 0xeff to diable vce?

Best Regards
Rex

From: S, Shirish
Sent: Wednesday, October 17, 2018 1:25 AM
To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@amd.c=
om>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if they wer=
e disabled by user

Nope, I have just cherry-picked this patch.
Is there any dependency?

Regards,
Shirish S

From: Zhu, Rex
Sent: Tuesday, October 16, 2018 12:15 PM
To: S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org<mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org>>; Deucher, Alex=
ander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>; amd-gf=
x@lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if they wer=
e disabled by user

Do you test based on drm-next branch?

Best Regards
Rex

From: S, Shirish
Sent: Wednesday, October 17, 2018 1:12 AM
To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher@=
amd.com>>; Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if they wer=
e disabled by user

This patch fails on the very first resume as below:
[   53.632732] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   54.653212] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   55.673692] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   56.694203] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   57.714683] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   58.735164] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   59.755643] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   60.776124] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   61.796608] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   62.817092] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, trying to reset the ECPU!!!
[   62.837108] [drm:vce_v3_0_set_powergating_state] *ERROR* VCE not respond=
ing, giving up!!!
[   62.837112] Power gating vce_v3_0 failed
[   62.837118] [drm:amdgpu_device_ip_suspend_phase1] *ERROR* set_powergatin=
g_state(gate) of IP block <vce_v3_0> failed -110

I believe there is some more work left to be done with it.

Regards,
Shirish S

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Deucher, Alexander
Sent: Tuesday, October 16, 2018 9:44 AM
To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if they wer=
e disabled by user


Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org>>
Sent: Tuesday, October 16, 2018 1:33:46 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; De=
ucher, Alexander
Cc: Zhu, Rex
Subject: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if they were di=
sabled by user

If user disable uvd/vce/vcn/acp blocks via module
parameter ip_block_mask,
driver power off thoser blocks to save power.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1e4dd09..3ffee08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1774,6 +1774,24 @@ static int amdgpu_device_set_pg_state(struct amdgpu_=
device *adev, enum amd_power

         for (j =3D 0; j < adev->num_ip_blocks; j++) {
                 i =3D state =3D=3D AMD_PG_STATE_GATE ? j : adev->num_ip_bl=
ocks - j - 1;
+
+               /* try to power off VCE/UVD/VCN/ACP if they were disabled b=
y user */
+               if ((adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_UVD ||
+                   adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_VCE ||
+                   adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_VCN ||
+                   adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_ACP) &&
+                   adev->ip_blocks[i].version->funcs->set_powergating_stat=
e) {
+                       if (!adev->ip_blocks[i].status.valid) {
+                               r =3D adev->ip_blocks[i].version->funcs->se=
t_powergating_state((void *)adev,
+                                                                          =
             state);
+                               if (r) {
+                                       DRM_ERROR("set_powergating_state(ga=
te) of IP block <%s> failed %d\n",
+                                         adev->ip_blocks[i].version->funcs=
->name, r);
+                                       return r;
+                               }
+                       }
+               }
+
                 if (!adev->ip_blocks[i].status.late_initialized)
                         continue;
                 /* skip CG for VCE/UVD, it's handled specially */
@@ -1791,6 +1809,7 @@ static int amdgpu_device_set_pg_state(struct amdgpu_d=
evice *adev, enum amd_power
                         }
                 }
         }
+
         return 0;
 }

--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BYAPR12MB27755045315022D06DCC17EEFBFE0BYAPR12MB2775namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">The code base is different.<o:p></o:p></p>
<p class=3D"MsoNormal">And do you set ip_block_mask =3D 0xeff to diable vce=
?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Rex<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> S, Shirish <br>
<b>Sent:</b> Wednesday, October 17, 2018 1:25 AM<br>
<b>To:</b> Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &lt;Alexand=
er.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if t=
hey were disabled by user<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Nope, I have just cherry-picked this patch.<o:p></o:=
p></p>
<p class=3D"MsoNormal">Is there any dependency?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Shirish S<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, Rex <br>
<b>Sent:</b> Tuesday, October 16, 2018 12:15 PM<br>
<b>To:</b> S, Shirish &lt;<a href=3D"mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org">Shirish.S@am=
d.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@a=
md.com">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if t=
hey were disabled by user<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you test based on drm-next branch?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Rex<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> S, Shirish <br>
<b>Sent:</b> Wednesday, October 17, 2018 1:12 AM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Zhu, Rex &lt;<a href=3D"mailto:Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if t=
hey were disabled by user<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This patch fails on the very first resume as below:<=
o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 53.632732] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp; &nbsp;54.653212] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 55.673692] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 56.694203] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 57.714683] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 58.735164] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 59.755643] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 60.776124] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 61.796608] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 62.817092] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, trying to reset the ECPU!!!<o:p></o:p=
></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 62.837108] [drm:vce_v3_0_set_powergati=
ng_state] *ERROR* VCE not responding, giving up!!!<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 62.837112] Power gating vce_v3_0 faile=
d<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 62.837118] [drm:amdgpu_device_ip_suspe=
nd_phase1] *ERROR* set_powergating_state(gate) of IP block &lt;vce_v3_0&gt;=
 failed -110<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I believe there is some more work left to be done wi=
th it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Shirish S<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Tuesday, October 16, 2018 9:44 AM<br>
<b>To:</b> Zhu, Rex &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu-5C7GfCeVMHo@public.gmane.org<=
/a>&gt;; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if t=
hey were disabled by user<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Reviewed-by: Alex Deucher &=
lt;</span><a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"><span style=3D"font-=
size:12.0pt">alexander.deucher-5C7GfCeVMHo@public.gmane.org</span></a><span style=3D"font-size:1=
2.0pt;color:black">&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounce=
s@lists.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span sty=
le=3D"color:black">&gt; on behalf of Rex Zhu &lt;</span><a href=3D"mailto:R=
ex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Tuesday, October 16, 2018 1:33:46 AM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black">; Deucher, Alexander<b=
r>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Poweroff uvd/vce/vcn/acp block if they =
were disabled by user</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">If user disable uvd/vce/vcn/acp blocks via module<br=
>
parameter ip_block_mask,<br>
driver power off thoser blocks to save power.<br>
<br>
Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<=
br>
&nbsp;1 file changed, 19 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 1e4dd09..3ffee08 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1774,6 &#43;1774,24 @@ static int amdgpu_device_set_pg_state(struct amd=
gpu_device *adev, enum amd_power<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-=
&gt;num_ip_blocks; j&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; i =3D state =3D=3D AMD_PG_STATE_GATE ? j : adev-&gt;n=
um_ip_blocks - j - 1;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* try to power off VCE/UVD/VCN/ACP if they were disabled by=
 user */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if ((adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_IP_BL=
OCK_TYPE_UVD ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;ty=
pe =3D=3D AMD_IP_BLOCK_TYPE_VCE ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;ty=
pe =3D=3D AMD_IP_BLOCK_TYPE_VCN ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;ty=
pe =3D=3D AMD_IP_BLOCK_TYPE_ACP) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;fu=
ncs-&gt;set_powergating_state) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&g=
t;ip_blocks[i].status.valid) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;ip_blocks[i].version-&gt=
;funcs-&gt;set_powergating_state((void *)adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sta=
te);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; DRM_ERROR(&quot;set_powergating_state(gate) of IP block &lt;%s&gt;=
 failed %d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.late_initialized)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* skip CG for VCE/UVD, it's handled specially */<br>
@@ -1791,6 &#43;1809,7 @@ static int amdgpu_device_set_pg_state(struct amdg=
pu_device *adev, enum amd_power<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB27755045315022D06DCC17EEFBFE0BYAPR12MB2775namp_--

--===============1457296521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1457296521==--
