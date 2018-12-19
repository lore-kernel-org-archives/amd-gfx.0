From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix MST dp_blank REG_WAIT timeout
Date: Wed, 19 Dec 2018 19:50:21 +0000
Message-ID: <BN6PR12MB18093984FD02D15B5912CB54F7BE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181219191411.27899-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0847915784=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181219191411.27899-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zuo, Jerry" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>

--===============0847915784==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18093984FD02D15B5912CB54F7BE0BN6PR12MB1809namp_"

--_000_BN6PR12MB18093984FD02D15B5912CB54F7BE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, December 19, 2018 2:14:11 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zuo, Jerry
Subject: [PATCH] drm/amd/display: Fix MST dp_blank REG_WAIT timeout

From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>

Need to blank stream before deallocate MST payload.

[drm:generic_reg_wait [amdgpu]] *ERROR* REG_WAIT timeout 10us * 3000 tries =
- dce110_stream_encoder_dp_blank line:944
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2201 at /var/lib/dkms/amdgpu/18.50-690240/build/amd/am=
dgpu/../display/dc/dc_helper.c:249 generic_reg_wait+0xe7/0x160 [amdgpu]
Call Trace:
 dce110_stream_encoder_dp_blank+0x11c/0x180 [amdgpu]
 core_link_disable_stream+0x40/0x230 [amdgpu]
 ? generic_reg_update_ex+0xdb/0x130 [amdgpu]
 dce110_reset_hw_ctx_wrap+0xb7/0x1f0 [amdgpu]
 dce110_apply_ctx_to_hw+0x30/0x430 [amdgpu]
 ? dce110_apply_ctx_for_surface+0x206/0x260 [amdgpu]
 dc_commit_state+0x2ba/0x4d0 [amdgpu]
 amdgpu_dm_atomic_commit_tail+0x297/0xd70 [amdgpu]
 ? amdgpu_bo_pin_restricted+0x58/0x260 [amdgpu]
 ? wait_for_completion_timeout+0x1f/0x120
 ? wait_for_completion_interruptible+0x1c/0x160
 commit_tail+0x3d/0x60 [drm_kms_helper]
 drm_atomic_helper_commit+0xf6/0x100 [drm_kms_helper]
 drm_atomic_connector_commit_dpms+0xe5/0xf0 [drm]
 drm_mode_obj_set_property_ioctl+0x14f/0x250 [drm]
 drm_mode_connector_property_set_ioctl+0x2e/0x40 [drm]
 drm_ioctl+0x1e0/0x430 [drm]
 ? drm_mode_connector_set_obj_prop+0x70/0x70 [drm]
 ? ep_read_events_proc+0xb0/0xb0
 ? ep_scan_ready_list.constprop.18+0x1e6/0x1f0
 ? timerqueue_add+0x52/0x80
 amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
 do_vfs_ioctl+0x90/0x5f0
 SyS_ioctl+0x74/0x80
 do_syscall_64+0x74/0x140
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
---[ end trace 3ed7b77a97d60f72 ]---

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Acked-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Tested-by: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index a87db7ac2e46..3dd5f2717b53 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2636,11 +2636,11 @@ void core_link_disable_stream(struct pipe_ctx *pipe=
_ctx, int option)
 {
         struct dc  *core_dc =3D pipe_ctx->stream->ctx->dc;

+       core_dc->hwss.blank_stream(pipe_ctx);
+
         if (pipe_ctx->stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST)
                 deallocate_mst_payload(pipe_ctx);

-       core_dc->hwss.blank_stream(pipe_ctx);
-
         core_dc->hwss.disable_stream(pipe_ctx, option);

         disable_link(pipe_ctx->stream->link, pipe_ctx->stream->signal);
--
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18093984FD02D15B5912CB54F7BE0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.went=
land-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, December 19, 2018 2:14:11 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zuo, Jerry<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix MST dp_blank REG_WAIT timeout<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: &quot;Jerry (Fangzhi) Zuo&quot; &lt;Jerry.Zu=
o@amd.com&gt;<br>
<br>
Need to blank stream before deallocate MST payload.<br>
<br>
[drm:generic_reg_wait [amdgpu]] *ERROR* REG_WAIT timeout 10us * 3000 tries =
- dce110_stream_encoder_dp_blank line:944<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 2201 at /var/lib/dkms/amdgpu/18.50-690240/build/amd/am=
dgpu/../display/dc/dc_helper.c:249 generic_reg_wait&#43;0xe7/0x160 [amdgpu]=
<br>
Call Trace:<br>
&nbsp;dce110_stream_encoder_dp_blank&#43;0x11c/0x180 [amdgpu]<br>
&nbsp;core_link_disable_stream&#43;0x40/0x230 [amdgpu]<br>
&nbsp;? generic_reg_update_ex&#43;0xdb/0x130 [amdgpu]<br>
&nbsp;dce110_reset_hw_ctx_wrap&#43;0xb7/0x1f0 [amdgpu]<br>
&nbsp;dce110_apply_ctx_to_hw&#43;0x30/0x430 [amdgpu]<br>
&nbsp;? dce110_apply_ctx_for_surface&#43;0x206/0x260 [amdgpu]<br>
&nbsp;dc_commit_state&#43;0x2ba/0x4d0 [amdgpu]<br>
&nbsp;amdgpu_dm_atomic_commit_tail&#43;0x297/0xd70 [amdgpu]<br>
&nbsp;? amdgpu_bo_pin_restricted&#43;0x58/0x260 [amdgpu]<br>
&nbsp;? wait_for_completion_timeout&#43;0x1f/0x120<br>
&nbsp;? wait_for_completion_interruptible&#43;0x1c/0x160<br>
&nbsp;commit_tail&#43;0x3d/0x60 [drm_kms_helper]<br>
&nbsp;drm_atomic_helper_commit&#43;0xf6/0x100 [drm_kms_helper]<br>
&nbsp;drm_atomic_connector_commit_dpms&#43;0xe5/0xf0 [drm]<br>
&nbsp;drm_mode_obj_set_property_ioctl&#43;0x14f/0x250 [drm]<br>
&nbsp;drm_mode_connector_property_set_ioctl&#43;0x2e/0x40 [drm]<br>
&nbsp;drm_ioctl&#43;0x1e0/0x430 [drm]<br>
&nbsp;? drm_mode_connector_set_obj_prop&#43;0x70/0x70 [drm]<br>
&nbsp;? ep_read_events_proc&#43;0xb0/0xb0<br>
&nbsp;? ep_scan_ready_list.constprop.18&#43;0x1e6/0x1f0<br>
&nbsp;? timerqueue_add&#43;0x52/0x80<br>
&nbsp;amdgpu_drm_ioctl&#43;0x49/0x80 [amdgpu]<br>
&nbsp;do_vfs_ioctl&#43;0x90/0x5f0<br>
&nbsp;SyS_ioctl&#43;0x74/0x80<br>
&nbsp;do_syscall_64&#43;0x74/0x140<br>
&nbsp;entry_SYSCALL_64_after_hwframe&#43;0x3d/0xa2<br>
---[ end trace 3ed7b77a97d60f72 ]---<br>
<br>
Signed-off-by: Jerry (Fangzhi) Zuo &lt;Jerry.Zuo-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Hersen Wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
Tested-by: Lyude Paul &lt;lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 &#43;&#43;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c<br>
index a87db7ac2e46..3dd5f2717b53 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
@@ -2636,11 &#43;2636,11 @@ void core_link_disable_stream(struct pipe_ctx *=
pipe_ctx, int option)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc&nbsp; *core_dc =
=3D pipe_ctx-&gt;stream-&gt;ctx-&gt;dc;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; core_dc-&gt;hwss.blank_stream(pip=
e_ctx);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream-&g=
t;signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; deallocate_mst_payload(pipe_ctx);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; core_dc-&gt;hwss.blank_stream(pipe_ct=
x);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; core_dc-&gt;hwss.disable_s=
tream(pipe_ctx, option);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_link(pipe_ctx-&gt;=
stream-&gt;link, pipe_ctx-&gt;stream-&gt;signal);<br>
-- <br>
2.19.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18093984FD02D15B5912CB54F7BE0BN6PR12MB1809namp_--

--===============0847915784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0847915784==--
