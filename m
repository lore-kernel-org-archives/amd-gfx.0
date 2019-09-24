From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Add NAVI12 support from kfd side
Date: Tue, 24 Sep 2019 22:33:01 +0000
Message-ID: <DM6PR12MB2778C3828D2FA626FEA1FB22F0840@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <1569363372-18620-1-git-send-email-shaoyun.liu@amd.com>
 <DM6PR12MB27788F751A7E9247F1BC1EF1F0840@DM6PR12MB2778.namprd12.prod.outlook.com>,
 <f2cb588a-f799-894b-6348-3bbdb9bf5cf0@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2132419053=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f2cb588a-f799-894b-6348-3bbdb9bf5cf0-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2132419053==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778C3828D2FA626FEA1FB22F0840DM6PR12MB2778namp_"

--_000_DM6PR12MB2778C3828D2FA626FEA1FB22F0840DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If Navi12 is the same as Navi10, then you can easily add the KFD support fi=
rst, as it only involves a couple of lines because of recent simplification=
. Then have this patch next.

Regards,
Yong
________________________________
From: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, September 24, 2019 6:28 PM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Add NAVI12 support from kfd side


I will push to drm-next branch . After check the code again , this change w=
ill cause  issue in the  kfd since CHIP_NAVI12  not added  in other place w=
here check the device_info->asic_family  in kfd code .  I think it's better=
 just set the  family ID as CHIP_NAVI10  since there is no difference from =
the kfd side for NAVI10, NAVI12 and    NAVI14.  I will send  another review=
 .


Regards

shaoyun.liu


On 2019-09-24 6:17 p.m., Zhao, Yong wrote:
Reviewed-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org><mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org>

Make sure to push to the new 5.3 branch.

Yong

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org><ma=
ilto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, September 24, 2019 6:16 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org><mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: Add NAVI12 support from kfd side

Add device info for both navi12 PF and VF

Change-Id: Ifb4035e65c12d153fc30e593fe109f9c7e0541f4
Signed-off-by: shaoyunl <shaoyun.liu-5C7GfCeVMHo@public.gmane.org><mailto:shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index f329b82..edfbae5c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -387,6 +387,24 @@ static const struct kfd_device_info navi10_device_info=
 =3D {
         .num_sdma_queues_per_engine =3D 8,
 };

+static const struct kfd_device_info navi12_device_info =3D {
+       .asic_family =3D CHIP_NAVI12,
+       .asic_name =3D "navi12",
+       .max_pasid_bits =3D 16,
+       .max_no_of_hqd  =3D 24,
+       .doorbell_size  =3D 8,
+       .ih_ring_entry_size =3D 8 * sizeof(uint32_t),
+       .event_interrupt_class =3D &event_interrupt_class_v9,
+       .num_of_watch_points =3D 4,
+       .mqd_size_aligned =3D MQD_SIZE_ALIGNED,
+       .needs_iommu_device =3D false,
+       .supports_cwsr =3D true,
+       .needs_pci_atomics =3D false,
+       .num_sdma_engines =3D 2,
+       .num_xgmi_sdma_engines =3D 0,
+       .num_sdma_queues_per_engine =3D 8,
+};
+
 static const struct kfd_device_info navi14_device_info =3D {
         .asic_family =3D CHIP_NAVI14,
         .asic_name =3D "navi14",
@@ -425,6 +443,7 @@ static const struct kfd_device_info *kfd_supported_devi=
ces[][2] =3D {
         [CHIP_RENOIR] =3D {&renoir_device_info, NULL},
         [CHIP_ARCTURUS] =3D {&arcturus_device_info, &arcturus_device_info}=
,
         [CHIP_NAVI10] =3D {&navi10_device_info, NULL},
+       [CHIP_NAVI12] =3D {&navi12_device_info, &navi12_device_info},
         [CHIP_NAVI14] =3D {&navi14_device_info, NULL},
 };

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB2778C3828D2FA626FEA1FB22F0840DM6PR12MB2778namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If Navi12 is the same as Navi10, then you can easily add the KFD support fi=
rst, as it only involves a couple of lines because of recent simplification=
. Then have this patch next.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun &lt;Shao=
yun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, September 24, 2019 6:28 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Add NAVI12 support from kfd side</f=
ont>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<p>I will push to drm-next branch . After check the code again , this chang=
e will cause&nbsp; issue in the&nbsp; kfd since CHIP_NAVI12&nbsp; not added=
&nbsp; in other place where check the device_info-&gt;asic_family&nbsp; in =
kfd code .&nbsp; I think it's better just set the&nbsp; family ID as CHIP_N=
AVI10&nbsp;
 since there is no difference from the kfd side for NAVI10, NAVI12 and&nbsp=
;&nbsp;&nbsp; NAVI14.&nbsp; I will send&nbsp; another review .
<br>
</p>
<p><br>
</p>
<p>Regards</p>
<p>shaoyun.liu&nbsp; <br>
</p>
<p><br>
</p>
<div class=3D"x_moz-cite-prefix">On 2019-09-24 6:17 p.m., Zhao, Yong wrote:=
<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<div style=3D"margin:0px; font-size:12pt; font-family:Calibri,Arial,Helveti=
ca,sans-serif">
Reviewed-by: Yong Zhao <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:=
Yong.Zhao-5C7GfCeVMHo@public.gmane.org">
&lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;</a></div>
<div style=3D"margin:0px; font-size:12pt; font-family:Calibri,Arial,Helveti=
ca,sans-serif">
<br>
</div>
<div style=3D"margin:0px; font-size:12pt; font-family:Calibri,Arial,Helveti=
ca,sans-serif">
Make sure to push to the new 5.3 branch.</div>
<div style=3D"margin:0px; font-size:12pt; font-family:Calibri,Arial,Helveti=
ca,sans-serif">
<br>
</div>
<div style=3D"margin:0px; font-size:12pt; font-family:Calibri,Arial,Helveti=
ca,sans-serif">
Yong</div>
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Liu, Shaoyun=
 <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org">
&lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Tuesday, September 24, 2019 6:16 PM<br>
<b>To:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@l=
ists.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
<b>Cc:</b> Liu, Shaoyun <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto=
:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org">
&lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add NAVI12 support from kfd side</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Add device info for both navi12 PF and VF<br>
<br>
Change-Id: Ifb4035e65c12d153fc30e593fe109f9c7e0541f4<br>
Signed-off-by: shaoyunl <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto=
:shaoyun.liu-5C7GfCeVMHo@public.gmane.org">
&lt;shaoyun.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c | 19 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 19 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index f329b82..edfbae5c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -387,6 &#43;387,24 @@ static const struct kfd_device_info navi10_device_=
info =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_sdma_queues_per_engin=
e =3D 8,<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static const struct kfd_device_info navi12_device_info =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_family =3D CHIP_NAVI12,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_name =3D &quot;navi12&quot;=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_pasid_bits =3D 16,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_no_of_hqd&nbsp; =3D 24,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .doorbell_size&nbsp; =3D 8,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ih_ring_entry_size =3D 8 * sizeo=
f(uint32_t),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .event_interrupt_class =3D &amp;e=
vent_interrupt_class_v9,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_of_watch_points =3D 4,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mqd_size_aligned =3D MQD_SIZE_AL=
IGNED,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .needs_iommu_device =3D false,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .supports_cwsr =3D true,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .needs_pci_atomics =3D false,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_sdma_engines =3D 2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_xgmi_sdma_engines =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_sdma_queues_per_engine =3D 8=
,<br>
&#43;};<br>
&#43;<br>
&nbsp;static const struct kfd_device_info navi14_device_info =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_family =3D CHIP_NAVI=
14,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_name =3D &quot;navi1=
4&quot;,<br>
@@ -425,6 &#43;443,7 @@ static const struct kfd_device_info *kfd_supported_=
devices[][2] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_RENOIR] =3D {&amp;re=
noir_device_info, NULL},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_ARCTURUS] =3D {&amp;=
arcturus_device_info, &amp;arcturus_device_info},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_NAVI10] =3D {&amp;na=
vi10_device_info, NULL},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_NAVI12] =3D {&amp;navi12_de=
vice_info, &amp;navi12_device_info},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_NAVI14] =3D {&amp;na=
vi14_device_info, NULL},<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</blockquote>
</div>
</body>
</html>

--_000_DM6PR12MB2778C3828D2FA626FEA1FB22F0840DM6PR12MB2778namp_--

--===============2132419053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2132419053==--
