From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amdgpu/pp/smu7: use a local variable for toc
 indexing
Date: Mon, 16 Jul 2018 16:13:50 +0000
Message-ID: <CY4PR12MB16879C60745F32270D64ABE7FB5D0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180712143941.28977-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1003027138=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180712143941.28977-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1003027138==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16879C60745F32270D64ABE7FB5D0CY4PR12MB1687namp_"

--_000_CY4PR12MB16879C60745F32270D64ABE7FB5D0CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org<mailto:rezhu-5C7GfCeVMHo@public.gmane.org>>



Best Regards

Rex


?? Outlook for Android<https://aka.ms/ghei36>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, July 12, 2018 10:39:38 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH 1/4] drm/amdgpu/pp/smu7: use a local variable for toc index=
ing

Rather than using the index variable stored in vram.  If
the device fails to come back online after a resume cycle,
reads from vram will return all 1s which will cause a
segfault. Based on a patch from Thomas Martitz <kugel-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org>.
This avoids the segfault, but we still need to sort out
why the GPU does not come back online after a resume.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D105760
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 23 +++++++++++-------=
----
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index d644a9bb9078..9f407c48d4f0 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -381,6 +381,7 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
         uint32_t fw_to_load;
         int result =3D 0;
         struct SMU_DRAMData_TOC *toc;
+       uint32_t num_entries =3D 0;

         if (!hwmgr->reload_fw) {
                 pr_info("skip reloading...\n");
@@ -422,41 +423,41 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
         }

         toc =3D (struct SMU_DRAMData_TOC *)smu_data->header;
-       toc->num_entries =3D 0;
         toc->structure_version =3D 1;

         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_RLC_G, &toc->entry[toc->num_entrie=
s++]),
+                               UCODE_ID_RLC_G, &toc->entry[num_entries++])=
,
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_CP_CE, &toc->entry[toc->num_entrie=
s++]),
+                               UCODE_ID_CP_CE, &toc->entry[num_entries++])=
,
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_CP_PFP, &toc->entry[toc->num_entri=
es++]),
+                               UCODE_ID_CP_PFP, &toc->entry[num_entries++]=
),
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_CP_ME, &toc->entry[toc->num_entrie=
s++]),
+                               UCODE_ID_CP_ME, &toc->entry[num_entries++])=
,
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_CP_MEC, &toc->entry[toc->num_entri=
es++]),
+                               UCODE_ID_CP_MEC, &toc->entry[num_entries++]=
),
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_CP_MEC_JT1, &toc->entry[toc->num_e=
ntries++]),
+                               UCODE_ID_CP_MEC_JT1, &toc->entry[num_entrie=
s++]),
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_CP_MEC_JT2, &toc->entry[toc->num_e=
ntries++]),
+                               UCODE_ID_CP_MEC_JT2, &toc->entry[num_entrie=
s++]),
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_SDMA0, &toc->entry[toc->num_entrie=
s++]),
+                               UCODE_ID_SDMA0, &toc->entry[num_entries++])=
,
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware_entry(h=
wmgr,
-                               UCODE_ID_SDMA1, &toc->entry[toc->num_entrie=
s++]),
+                               UCODE_ID_SDMA1, &toc->entry[num_entries++])=
,
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);
         if (!hwmgr->not_vf)
                 PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_firmware=
_entry(hwmgr,
-                               UCODE_ID_MEC_STORAGE, &toc->entry[toc->num_=
entries++]),
+                               UCODE_ID_MEC_STORAGE, &toc->entry[num_entri=
es++]),
                                 "Failed to Get Firmware Entry.", return -E=
INVAL);

+       toc->num_entries =3D num_entries;
         smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR=
_HI, upper_32_bits(smu_data->header_buffer.mc_addr));
         smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR=
_LO, lower_32_bits(smu_data->header_buffer.mc_addr));

--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB16879C60745F32270D64ABE7FB5D0CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Series is:<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Reviewed-by: Rex Zhu&lt;<a href=3D"mailto:rezhu-5C7GfCeVMHo@public.gmane.org">rezhu-5C7GfCeVMHo@public.gmane.org</a>&=
gt;&nbsp;<br>
<br>
<br>
<br>
</div>
<div align=3D"left">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<font color=3D"#000000">Best Regards</font><br>
</div>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
</div>
<div align=3D"left">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<font color=3D"#000000">Rex</font><br>
</div>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
&#33719;&#21462; <a href=3D"https://aka.ms/ghei36">Outlook for Android</a><=
/div>
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Thursday, July 12, 2018 10:39:38 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH 1/4] drm/amdgpu/pp/smu7: use a local variable for to=
c indexing</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Rather than using the index variable stored in vra=
m.&nbsp; If<br>
the device fails to come back online after a resume cycle,<br>
reads from vram will return all 1s which will cause a<br>
segfault. Based on a patch from Thomas Martitz &lt;kugel-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org&gt;.<b=
r>
This avoids the segfault, but we still need to sort out<br>
why the GPU does not come back online after a resume.<br>
<br>
Bug: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D105760">http=
s://bugs.freedesktop.org/show_bug.cgi?id=3D105760</a><br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 23 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----------<br>
&nbsp;1 file changed, 12 insertions(&#43;), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
index d644a9bb9078..9f407c48d4f0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
@@ -381,6 &#43;381,7 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw_to_load;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU_DRAMData_TOC *t=
oc;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_entries =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;reload_fw) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info(&quot;skip reloading...\n&quot;);<br>
@@ -422,41 &#43;423,41 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwm=
gr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toc =3D (struct SMU_DRAMDa=
ta_TOC *)smu_data-&gt;header;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toc-&gt;num_entries =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toc-&gt;structure_version =
=3D 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_RLC_G, &amp;toc-&gt;entry[toc-&gt;=
num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_RLC_G, &amp;toc-&gt;entry[num_=
entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_CE, &amp;toc-&gt;entry[toc-&gt;=
num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_CE, &amp;toc-&gt;entry[num_=
entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_PFP, &amp;toc-&gt;entry[toc-&gt=
;num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_PFP, &amp;toc-&gt;entry[num=
_entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_ME, &amp;toc-&gt;entry[toc-&gt;=
num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_ME, &amp;toc-&gt;entry[num_=
entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_MEC, &amp;toc-&gt;entry[toc-&gt=
;num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_MEC, &amp;toc-&gt;entry[num=
_entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_MEC_JT1, &amp;toc-&gt;entry[toc=
-&gt;num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_MEC_JT1, &amp;toc-&gt;entry=
[num_entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_MEC_JT2, &amp;toc-&gt;entry[toc=
-&gt;num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_CP_MEC_JT2, &amp;toc-&gt;entry=
[num_entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_SDMA0, &amp;toc-&gt;entry[toc-&gt;=
num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_SDMA0, &amp;toc-&gt;entry[num_=
entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D smu7_populate_single_firmware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_SDMA1, &amp;toc-&gt;entry[toc-&gt;=
num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_SDMA1, &amp;toc-&gt;entry[num_=
entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;not_vf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=3D smu7_populate_single_fir=
mware_entry(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_MEC_STORAGE, &amp;toc-&gt;entry[to=
c-&gt;num_entries&#43;&#43;]),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE_ID_MEC_STORAGE, &amp;toc-&gt;entr=
y[num_entries&#43;&#43;]),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to Get Firmware Ent=
ry.&quot;, return -EINVAL);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toc-&gt;num_entries =3D num_entri=
es;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_send_msg_to_smc_with_=
parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_HI, upper_32_bits(smu_data-&gt;hea=
der_buffer.mc_addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_send_msg_to_smc_with_=
parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_LO, lower_32_bits(smu_data-&gt;hea=
der_buffer.mc_addr));<br>
&nbsp;<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB16879C60745F32270D64ABE7FB5D0CY4PR12MB1687namp_--

--===============1003027138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1003027138==--
