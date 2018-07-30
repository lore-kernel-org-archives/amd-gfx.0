From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdgpu: Put enable gfx off feature to a delay
 thread
Date: Mon, 30 Jul 2018 03:52:41 +0000
Message-ID: <CY4PR12MB168726A840EE78ECCA4D9005FB2F0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1532864150-32370-1-git-send-email-rex.zhu@amd.com>,
 <1532864150-32370-2-git-send-email-rex.zhu@amd.com>,
 <SN6PR12MB2656A6C34BE374E0DF5FD125E42F0@SN6PR12MB2656.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0639968442=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB2656A6C34BE374E0DF5FD125E42F0-kxOKjb6HO/FeL/N0e1LXkAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0639968442==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168726A840EE78ECCA4D9005FB2F0CY4PR12MB1687namp_"

--_000_CY4PR12MB168726A840EE78ECCA4D9005FB2F0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


>I think for disable gfxoff case, you need to use cancle_delayed_work_sync(=
(&adev->gfx.delay_gfx_off_enable). E.g.


This makes code a bit complex.

we don't need to cancel the delay work.


In delay work thread, we also need to get the mutex. and check the request =
count value.

if Other clients have new disable requests before the delay work ran, the c=
ount will be added by 1.

so in the delay thread, gfx off will not be enabled.


Best Regards

Rex



________________________________
From: Quan, Evan
Sent: Monday, July 30, 2018 10:26 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/4] drm/amdgpu: Put enable gfx off feature to a delay =
thread


-               if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_T=
YPE_GFX, true))
-                       adev->gfx.bin_off =3D true;
+               schedule_delayed_work(&adev->gfx.delay_gfx_off_enable, GFX_=
OFF_DELAY_ENABLE);
         } else if (!enable && adev->gfx.bin_off) {
                 if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_=
TYPE_GFX, false))
                         adev->gfx.bin_off =3D false;


I think for disable gfxoff case, you need to use cancle_delayed_work_sync((=
&adev->gfx.delay_gfx_off_enable). E.g.


if (!cancle_delayed_work_sync((&adev->gfx.delay_gfx_off_enable) && !amdgpu_=
dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false))

                         adev->gfx.bin_off =3D false;


Regards,

Evan

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<rex.zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Sunday, July 29, 2018 7:35:48 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 2/4] drm/amdgpu: Put enable gfx off feature to a delay thre=
ad

delay to enable gfx off feature to avoid gfx on/off frequently

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 ++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 318961d..b59ac02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -993,6 +993,7 @@ struct amdgpu_gfx {
         bool                            bin_off;
         struct mutex                    gfx_off_ctrl_mutex;
         uint32_t                        disable_gfx_off_request;
+       struct delayed_work             delay_gfx_off_enable;
         /* pipe reservation */
         struct mutex                    pipe_reserve_mutex;
         DECLARE_BITMAP                  (pipe_reserve_bitmap, AMDGPU_MAX_C=
OMPUTE_QUEUES);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b40ce6f..9f8e267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1925,6 +1925,20 @@ static void amdgpu_device_ip_late_init_func_handler(=
struct work_struct *work)
                 DRM_ERROR("ib ring test failed (%d).\n", r);
 }

+static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
+{
+       struct amdgpu_device *adev =3D
+               container_of(work, struct amdgpu_device, gfx.delay_gfx_off_=
enable.work);
+
+       mutex_lock(&adev->gfx.gfx_off_ctrl_mutex);
+       if (adev->gfx.bready_for_off && !adev->gfx.bin_off
+                               && adev->gfx.disable_gfx_off_request) {
+               if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_T=
YPE_GFX, true))
+                       adev->gfx.bin_off =3D true;
+       }
+       mutex_unlock(&adev->gfx.gfx_off_ctrl_mutex);
+}
+
 /**
  * amdgpu_device_ip_suspend_phase1 - run suspend for hardware IPs (phase 1=
)
  *
@@ -2394,6 +2408,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,

         INIT_DELAYED_WORK(&adev->late_init_work,
                           amdgpu_device_ip_late_init_func_handler);
+       INIT_DELAYED_WORK(&adev->gfx.delay_gfx_off_enable,
+                         amdgpu_device_delay_enable_gfx_off);

         adev->pm.ac_power =3D power_supply_is_system_supplied() > 0 ? true=
 : false;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 68fe9c8..1ea1e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -26,6 +26,9 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"

+/* 0.5 second timeout */
+#define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(500)
+
 /*
  * GPU scratch registers helpers function.
  */
@@ -384,8 +387,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, en=
um amd_ip_block_type clie
  */
         if (adev->gfx.bready_for_off && !adev->gfx.bin_off
                                 && !adev->gfx.disable_gfx_off_request) {
-               if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_T=
YPE_GFX, true))
-                       adev->gfx.bin_off =3D true;
+               schedule_delayed_work(&adev->gfx.delay_gfx_off_enable, GFX_=
OFF_DELAY_ENABLE);
         } else if (!enable && adev->gfx.bin_off) {
                 if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_=
TYPE_GFX, false))
                         adev->gfx.bin_off =3D false;
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



--_000_CY4PR12MB168726A840EE78ECCA4D9005FB2F0CY4PR12MB1687namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px">&gt;I think for disable gfxof=
f case, you need to use cancle_delayed_work_sync(<span style=3D"color:rgb(3=
3,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe W=
P&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">(&amp=
;adev-&gt;gfx.delay_gfx_off_enable).
 E.g.</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><br>
</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span>Th=
is
 makes code a bit complex.</span></span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span>we
 don't need to cancel the delay work.</span></span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span></=
span><br>
</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">In
 delay work thread, we also need to get the mutex. and check the request co=
unt value.</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">if
 Other clients have new disable requests before the delay work ran, the cou=
nt will be added by 1.</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">so
 in the delay thread, gfx off will not be enabled.</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><br>
</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">Best
 Regards</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">Rex<br>
</span></span></font></p>
<br>
<p></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Monday, July 30, 2018 10:26 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/4] drm/amdgpu: Put enable gfx off feature to a=
 delay thread</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Dus-ascii">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">-&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX,
 true))</span><br style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_nor=
mal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif=
,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;gfx.bin_off =3D true;</span><br style=3D"color:rgb(33,33,33);=
 font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,T=
ahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;adev-&gt;gfx=
.delay_gfx_off_enable, GFX_OFF_DELAY_ENABLE);</span><br style=3D"color:rgb(=
33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe =
WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e if (!enable &amp;&amp; adev-&gt;gfx.bin_off) {</span><br style=3D"color:r=
gb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Seg=
oe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_set_powergating_=
by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false))</span><br style=3D"color:rgb(33=
,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP=
&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.bin_off =3D false;</span><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px">I think for disable gfxoff ca=
se, you need to use cancle_delayed_work_sync(<span style=3D"color:rgb(33,33=
,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&qu=
ot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">(&amp;ade=
v-&gt;gfx.delay_gfx_off_enable).
 E.g.</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><br>
</span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">if
 (!<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:14.6667px">cancle_delayed_work_sync(</span><span style=3D"colo=
r:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;=
Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px=
">(&amp;adev-&gt;gfx.delay_gfx_off_enable)
 &amp;&amp;&nbsp;<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-u=
i_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,=
serif,EmojiFont; font-size:14.6667px">!amdgpu_dpm_set_powergating_by_smu(ad=
ev, AMD_IP_BLOCK_TYPE_GFX, false)</span>)</span></span></span></font></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span st=
yle=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&q=
uot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-siz=
e:14.6667px"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_no=
rmal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,seri=
f,EmojiFont; font-size:14.6667px">&nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;adev-&gt;gfx.bin_off =3D false;</span></span></span></span></font>=
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span st=
yle=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&q=
uot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-siz=
e:14.6667px"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_no=
rmal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,seri=
f,EmojiFont; font-size:14.6667px">Regards,</span></span></span></span></fon=
t></p>
<p style=3D"margin-top:0; margin-bottom:0"><font color=3D"#212121" face=3D"=
wf_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, E=
mojiFont"><span style=3D"font-size:14.6667px"><span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><span st=
yle=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&q=
uot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-siz=
e:14.6667px"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_no=
rmal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,seri=
f,EmojiFont; font-size:14.6667px">Evan</span></span></span></span></font></=
p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;rex.zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Sunday, July 29, 2018 7:35:48 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 2/4] drm/amdgpu: Put enable gfx off feature to a del=
ay thread</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">delay to enable gfx off feature to avoid gfx on/=
off frequently<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 &=
#43;&#43;&#43;&#43;--<br>
&nbsp;3 files changed, 21 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 318961d..b59ac02 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -993,6 &#43;993,7 @@ struct amdgpu_gfx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bin_off;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_ctrl_mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_gfx_off_request;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; delay_gfx_off_en=
able;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pipe reservation */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; pipe_reserve_mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b40ce6f..9f8e267 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1925,6 &#43;1925,20 @@ static void amdgpu_device_ip_late_init_func_hand=
ler(struct work_struct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;ib ring test failed (%d).\n&quot;, r)=
;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void amdgpu_device_delay_enable_gfx_off(struct work_struct *wor=
k)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; container_of(work, struct amdgpu_device, gfx.delay_gfx_off_e=
nable.work);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.gfx_=
off_ctrl_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.bready_for_off &=
amp;&amp; !adev-&gt;gfx.bin_off<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; adev-&gt;gfx.disable_gfx_off=
_request) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TY=
PE_GFX, true))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.bin_off =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.gf=
x_off_ctrl_mutex);<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_device_ip_suspend_phase1 - run suspend for hardware IPs (ph=
ase 1)<br>
&nbsp; *<br>
@@ -2394,6 &#43;2408,8 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;ade=
v-&gt;late_init_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_device_ip_late_init_func_handler);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;adev-&gt;g=
fx.delay_gfx_off_enable,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
amdgpu_device_delay_enable_gfx_off);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.ac_power =3D p=
ower_supply_is_system_supplied() &gt; 0 ? true : false;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index 68fe9c8..1ea1e8b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -26,6 &#43;26,9 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_gfx.h&quot;<br>
&nbsp;<br>
&#43;/* 0.5 second timeout */<br>
&#43;#define GFX_OFF_DELAY_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; msecs_to_jiffies(500)<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * GPU scratch registers helpers function.<br>
&nbsp; */<br>
@@ -384,8 &#43;387,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev=
, enum amd_ip_block_type clie<br>
&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.bready_fo=
r_off &amp;&amp; !adev-&gt;gfx.bin_off<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; !adev-&gt;gfx.disable=
_gfx_off_request) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_G=
FX, true))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bin=
_off =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; schedule_delayed_work(&amp;adev-&gt;gfx.delay_gfx_off_enable=
, GFX_OFF_DELAY_ENABLE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!enable &amp;&a=
mp; adev-&gt;gfx.bin_off) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_B=
LOCK_TYPE_GFX, false))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;gfx.bin_off =3D false;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk897227" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15329224396520.26197459492441044" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15329224396500.5350990373484694" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15329224396520.4354856831495105" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15329224396520.9682570373686812"></div>
<div id=3D"LPTitle_15329224396520.24095448919397833" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot=
;wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&=
quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-seri=
f; line-height: 21px;">
<a id=3D"LPUrlAnchor_15329224396520.9769367041399757" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15329224396520.4909119338550957" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15329224396520.4596581094017099" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB168726A840EE78ECCA4D9005FB2F0CY4PR12MB1687namp_--

--===============0639968442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0639968442==--
