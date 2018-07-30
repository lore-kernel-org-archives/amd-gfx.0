From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: Add amdgpu_gfx_off_ctrl function
Date: Mon, 30 Jul 2018 04:32:36 +0000
Message-ID: <SN6PR12MB26567850D8ABB9D9ED9694D0E42F0@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <1532864150-32370-1-git-send-email-rex.zhu@amd.com>,
 <SN6PR12MB26564CB34A8FD6AFA46AACD4E42F0@SN6PR12MB2656.namprd12.prod.outlook.com>,
 <CY4PR12MB1687D0B723AB027047CEF32FFB2F0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0056424114=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687D0B723AB027047CEF32FFB2F0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0056424114==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB26567850D8ABB9D9ED9694D0E42F0SN6PR12MB2656namp_"

--_000_SN6PR12MB26567850D8ABB9D9ED9694D0E42F0SN6PR12MB2656namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>This flag should only be set by gfx ip after gfx cg/pg feature enabled.
>Other clients can't enable gfx off feature before this flag is set.


Maybe other clients should also not disable gfx off feature if this flag is=
 not set.


Regards,

Evan

________________________________
From: Zhu, Rex
Sent: Monday, July 30, 2018 11:46:00 AM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/4] drm/amdgpu: Add amdgpu_gfx_off_ctrl function


>"adev->gfx.bready_for_off" used for ?


This flag should only be set by gfx ip after gfx cg/pg feature enabled.

Other clients can't enable gfx off feature before this flag is set.


>"adev->gfx.bready_for_off =3D=3D 0"

For disable gfx off feature, we don't need to care this flag.



Best Regards

Rex

________________________________
From: Quan, Evan
Sent: Monday, July 30, 2018 11:12 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/4] drm/amdgpu: Add amdgpu_gfx_off_ctrl function



+       if (adev->gfx.bready_for_off && !adev->gfx.bin_off
+                               && !adev->gfx.disable_gfx_off_request) {

+               if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_T=
YPE_GFX, true))
+                       adev->gfx.bin_off =3D true;
+       } else if (!enable && adev->gfx.bin_off) {

What is "adev->gfx.bready_for_off" used for ? Do we need to consider "adev-=
>gfx.bready_for_off =3D=3D 0" case here?
+               if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_T=
YPE_GFX, false))
+                       adev->gfx.bin_off =3D false;
+       }


Regards,

Evan

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<rex.zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Sunday, July 29, 2018 7:35:47 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 1/4] drm/amdgpu: Add amdgpu_gfx_off_ctrl function

This funciton as the entry of gfx off ctrl feature.
we arbitrat gfx off feature enable/disable in this
function.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 52 ++++++++++++++++++++++++++=
++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 5b7bb58..318961d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -988,6 +988,11 @@ struct amdgpu_gfx {
         /* NGG */
         struct amdgpu_ngg               ngg;

+       /* gfx off */
+       bool                            bready_for_off;
+       bool                            bin_off;
+       struct mutex                    gfx_off_ctrl_mutex;
+       uint32_t                        disable_gfx_off_request;
         /* pipe reservation */
         struct mutex                    pipe_reserve_mutex;
         DECLARE_BITMAP                  (pipe_reserve_bitmap, AMDGPU_MAX_C=
OMPUTE_QUEUES);
@@ -1815,6 +1820,8 @@ void amdgpu_device_program_register_sequence(struct a=
mdgpu_device *adev,
                                              const u32 array_size);

 bool amdgpu_device_is_px(struct drm_device *dev);
+void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev,
+                               enum amd_ip_block_type client, bool enable)=
;
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
 void amdgpu_register_atpx_handler(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 745f760..b40ce6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2367,6 +2367,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         mutex_init(&adev->gfx.gpu_clock_mutex);
         mutex_init(&adev->srbm_mutex);
         mutex_init(&adev->gfx.pipe_reserve_mutex);
+       mutex_init(&adev->gfx.gfx_off_ctrl_mutex);
         mutex_init(&adev->grbm_idx_mutex);
         mutex_init(&adev->mn_lock);
         mutex_init(&adev->virt.vf_errors.lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 239bf2a..68fe9c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -340,3 +340,55 @@ void amdgpu_gfx_compute_mqd_sw_fini(struct amdgpu_devi=
ce *adev)
                               &ring->mqd_gpu_addr,
                               &ring->mqd_ptr);
 }
+
+/* amdgpu_gfx_off_ctrl - Handle gfx off feature enable/disable
+ *
+ * @adev: amdgpu_device pointer
+ * @enum amd_ip_block_type gfx ip decide when to set ready for gfx off fea=
ture
+ * other clients send disable gfx off feature request
+ * @bool enable
+ *
+ * if gfx ip is ready for power off gfx ip, and no other clients's request=
 for
+ * disable gfx off feature, driver will call smu to enable gfx off immedia=
tely.
+ * otherwise, driver will wait until the clients cancel the requests.
+ */
+
+void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, enum amd_ip_block_typ=
e client, bool enable)
+{
+       if (!(adev->powerplay.pp_feature & PP_GFXOFF_MASK))
+               return; /* gfx off feature is not supported or disabled by =
user via module parameter */
+
+       if (!adev->powerplay.pp_funcs->set_powergating_by_smu)
+               return; /* currently gfx off feature need smu support*/
+
+       mutex_lock(&adev->gfx.gfx_off_ctrl_mutex);
+       if (client =3D=3D AMD_IP_BLOCK_TYPE_GFX) {
+               adev->gfx.bready_for_off =3D enable ? true : false; /*true,=
 gfx ip is ready to enable gfx off feature */
+       } else {
+               if (!enable) /* false : reveive one disable gfx off request=
s from other clients*/
+                       adev->gfx.disable_gfx_off_request++;
+               else if (adev->gfx.disable_gfx_off_request > 0)
+                       adev->gfx.disable_gfx_off_request--;
+       }
+
+/* *
+ * we can enable gfx off feature when meet the following conditions:
+ * 1. gfx off feature is supported by hw
+ * 2. gfx ip is ready to enable gfx off feature
+ * 3. no other clients have requests to disable gfx off
+ * 4. gfx off feature is not enabled
+ * For disable gfx off feature
+ * 1. gfx off feature is supported by hw
+ * 2. receive disable gfx off requests
+ * 3. gfx off feature is enabled
+ */
+       if (adev->gfx.bready_for_off && !adev->gfx.bin_off
+                               && !adev->gfx.disable_gfx_off_request) {
+               if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_T=
YPE_GFX, true))
+                       adev->gfx.bin_off =3D true;
+       } else if (!enable && adev->gfx.bin_off) {
+               if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_T=
YPE_GFX, false))
+                       adev->gfx.bin_off =3D false;
+       }
+       mutex_unlock(&adev->gfx.gfx_off_ctrl_mutex);
+}
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.




--_000_SN6PR12MB26567850D8ABB9D9ED9694D0E42F0SN6PR12MB2656namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 16px; margin-top: 0px; margin-bottom: 0px;">
&gt;This flag should only be set by gfx ip after gfx cg/pg feature enabled.=
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot=
;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot=
;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size:=
 16px; margin-top: 0px; margin-bottom: 0px;">
&gt;Other clients can't enable gfx off feature&nbsp;before this flag is set=
.</div>
<br>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0">Maybe other clients should also n=
ot disable gfx off feature if this flag is not set.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Evan</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, Rex<br>
<b>Sent:</b> Monday, July 30, 2018 11:46:00 AM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amdgpu: Add amdgpu_gfx_off_ctrl functio=
n</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Diso-8859-1">
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quo=
t;,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,=
&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">&gt;&quot;<=
span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Seg=
oe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; f=
ont-size:14.6667px">adev-&gt;gfx.bready_for_off&quot;
 used for ?</span></span><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">This flag should only be set by =
gfx ip after gfx cg/pg feature enabled.</p>
<p style=3D"margin-top:0; margin-bottom:0">Other clients can't enable gfx o=
ff feature&nbsp;<span>before this flag is set.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_norma=
l,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,E=
mojiFont; font-size:14.6667px">&gt;&quot;adev-&gt;gfx.bready_for_off
 =3D=3D 0&quot;</span></span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_norma=
l,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,E=
mojiFont; font-size:14.6667px">For
 disable gfx off feature, we don't need to care this flag.</span></span></s=
pan></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_norma=
l,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,E=
mojiFont; font-size:14.6667px"><br>
</span></span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_norma=
l,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,E=
mojiFont; font-size:14.6667px"></span></span></span><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri, sans-serif" style=3D"font-size:11pt"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Monday, July 30, 2018 11:12 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amdgpu: Add amdgpu_gfx_off_ctrl functio=
n</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Diso-8859-1">
<div dir=3D"ltr">
<div id=3D"x_x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; c=
olor:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&q=
uot;,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoj=
i,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<div id=3D"x_x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; c=
olor:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;A=
pple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Sego=
e UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 if (adev-&gt;gfx.bready_for_off &amp;&amp; !adev-&gt;gfx.bin_off</span><br=
 style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe U=
I&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-=
size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; !adev-&=
gt;gfx.disable_gfx_off_request) {</span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
 if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))=
</span><br style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&qu=
ot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiF=
ont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adev-&gt;gfx.bin_off =3D true;</span><br style=3D"color:rgb(33,33,=
33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quo=
t;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!=
enable &amp;&amp; adev-&gt;gfx.bin_off) {</span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">What is &qu=
ot;<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:14.6667px">adev-&gt;gfx.bready_for_off&quot;
 used for ? Do we need to consider &quot;<span style=3D"color:rgb(33,33,33)=
; font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,=
Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">adev-&gt;gfx.=
bready_for_off =3D=3D 0&quot; case here?</span></span><br style=3D"color:rg=
b(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_set_powergating_by_smu(=
adev, AMD_IP_BLOCK_TYPE_GFX, false))</span><br style=3D"color:rgb(33,33,33)=
; font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,=
Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adev-&gt;gfx.bin_off =3D false;</span><br style=3D"color:rgb(33,33=
,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&qu=
ot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px"><br>
</span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px">Regards,</span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span style=
=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot=
;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:1=
4.6667px">Evan</span></span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"C=
alibri, sans-serif" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-g=
fx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;rex.zhu@amd.c=
om&gt;<br>
<b>Sent:</b> Sunday, July 29, 2018 7:35:47 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 1/4] drm/amdgpu: Add amdgpu_gfx_off_ctrl function</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">This funciton as the entry of gfx off ctrl fea=
ture.<br>
we arbitrat gfx off feature enable/disable in this<br>
function.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nbsp; | 52 &#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;3 files changed, 60 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 5b7bb58..318961d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -988,6 &#43;988,11 @@ struct amdgpu_gfx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NGG */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ngg&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ngg;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfx off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bready_for_off;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bin_off;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; gfx_off_ctrl_mutex;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_gfx_off_request;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pipe reservation */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; pipe_reserve_mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);<br>
@@ -1815,6 &#43;1820,8 @@ void amdgpu_device_program_register_sequence(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 array_size);<br>
&nbsp;<br>
&nbsp;bool amdgpu_device_is_px(struct drm_device *dev);<br>
&#43;void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type client, bool ena=
ble);<br>
&nbsp;/* atpx handler */<br>
&nbsp;#if defined(CONFIG_VGA_SWITCHEROO)<br>
&nbsp;void amdgpu_register_atpx_handler(void);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 745f760..b40ce6f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2367,6 &#43;2367,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;g=
fx.gpu_clock_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;s=
rbm_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;g=
fx.pipe_reserve_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx.gfx_=
off_ctrl_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;m=
n_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;v=
irt.vf_errors.lock);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index 239bf2a..68fe9c8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -340,3 &#43;340,55 @@ void amdgpu_gfx_compute_mqd_sw_fini(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ring-&gt;mqd_gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ring-&gt;mqd_ptr);<br>
&nbsp;}<br>
&#43;<br>
&#43;/* amdgpu_gfx_off_ctrl - Handle gfx off feature enable/disable<br>
&#43; *<br>
&#43; * @adev: amdgpu_device pointer<br>
&#43; * @enum amd_ip_block_type gfx ip decide when to set ready for gfx off=
 feature<br>
&#43; * other clients send disable gfx off feature request<br>
&#43; * @bool enable<br>
&#43; *<br>
&#43; * if gfx ip is ready for power off gfx ip, and no other clients's req=
uest for<br>
&#43; * disable gfx off feature, driver will call smu to enable gfx off imm=
ediately.<br>
&#43; * otherwise, driver will wait until the clients cancel the requests.<=
br>
&#43; */<br>
&#43;<br>
&#43;void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, enum amd_ip_block=
_type client, bool enable)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;powerplay.pp_featu=
re &amp; PP_GFXOFF_MASK))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return; /* gfx off feature is not supported or disabled by u=
ser via module parameter */<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;powerplay.pp_funcs-=
&gt;set_powergating_by_smu)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return; /* currently gfx off feature need smu support*/<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.gfx_=
off_ctrl_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (client =3D=3D AMD_IP_BLOCK_TY=
PE_GFX) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;gfx.bready_for_off =3D enable ? true : false; /*tru=
e, gfx ip is ready to enable gfx off feature */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!enable) /* false : reveive one disable gfx off requests=
 from other clients*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.disable_gfx_off_request&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else if (adev-&gt;gfx.disable_gfx_off_request &gt; 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.disable_gfx_off_request--;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;/* *<br>
&#43; * we can enable gfx off feature when meet the following conditions:<b=
r>
&#43; * 1. gfx off feature is supported by hw<br>
&#43; * 2. gfx ip is ready to enable gfx off feature<br>
&#43; * 3. no other clients have requests to disable gfx off<br>
&#43; * 4. gfx off feature is not enabled<br>
&#43; * For disable gfx off feature<br>
&#43; * 1. gfx off feature is supported by hw<br>
&#43; * 2. receive disable gfx off requests<br>
&#43; * 3. gfx off feature is enabled<br>
&#43; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.bready_for_off &=
amp;&amp; !adev-&gt;gfx.bin_off<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; !adev-&gt;gfx.disable_gfx_of=
f_request) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TY=
PE_GFX, true))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.bin_off =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!enable &amp;&amp; ade=
v-&gt;gfx.bin_off) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TY=
PE_GFX, false))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.bin_off =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.gf=
x_off_ctrl_mutex);<br>
&#43;}<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk886781" class=3D"x_x_OWAAutoLink">https://lists.freedesktop.org/mailman/=
listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15329201729380.3302477536537516" style=3D"margin-bot=
tom:20px; overflow:auto; width:100%; text-indent:0px">
<table id=3D"LPContainer_15329201729290.557243803333892" cellspacing=3D"0" =
style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto; paddi=
ng-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dotted rg=
b(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"x_x_TextCell_15329201729320.5856508556754785" colspan=3D"2" style=
=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPRemovePreviewContainer_15329201729320.8037375547458883"></div>
<div id=3D"LPTitle_15329201729330.8257753121147637" style=3D"top:0px; color=
:rgb(0,120,215); font-weight:400; font-size:21px; font-family:wf_segoe-ui_l=
ight,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&q=
uot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-height:21px">
<a id=3D"LPUrlAnchor_15329201729340.18268190718998456" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration:none">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15329201729350.9576148436869616" style=3D"margin:10px=
 0px 16px; color:rgb(102,102,102); font-weight:400; font-family:wf_segoe-ui=
_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; =
font-size:14px; line-height:14px">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15329201729360.08722428468077426" style=3D"display=
:block; color:rgb(102,102,102); font-weight:400; font-family:wf_segoe-ui_no=
rmal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; fon=
t-size:14px; line-height:20px; max-height:100px; overflow:hidden">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SN6PR12MB26567850D8ABB9D9ED9694D0E42F0SN6PR12MB2656namp_--

--===============0056424114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0056424114==--
