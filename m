From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add NAVI12 support from kfd side
Date: Wed, 25 Sep 2019 13:00:11 +0000
Message-ID: <BN6PR12MB1809F0717D9D94EBC3ED1E9FF7870@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1569363225-18469-1-git-send-email-shaoyun.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1469947970=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569363225-18469-1-git-send-email-shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
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

--===============1469947970==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F0717D9D94EBC3ED1E9FF7870BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F0717D9D94EBC3ED1E9FF7870BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, September 24, 2019 6:13 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Add NAVI12 support from kfd side

Add device info for both navi12 PF and VF

Change-Id: Ifb4035e65c12d153fc30e593fe109f9c7e0541f4
Signed-off-by: shaoyunl <shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809F0717D9D94EBC3ED1E9FF7870BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 24, 2019 6:13 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add NAVI12 support from kfd side</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add device info for both navi12 PF and VF<br>
<br>
Change-Id: Ifb4035e65c12d153fc30e593fe109f9c7e0541f4<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F0717D9D94EBC3ED1E9FF7870BN6PR12MB1809namp_--

--===============1469947970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1469947970==--
