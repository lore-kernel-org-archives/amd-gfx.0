From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: avoid sleeping in atomic context while
 creating new state (V2)
Date: Thu, 31 May 2018 12:50:30 +0000
Message-ID: <DM5PR12MB18203A602B51F3D4171468B8F7630@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1527760764-17760-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1900145842=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527760764-17760-1-git-send-email-shirish.s-5C7GfCeVMHo@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============1900145842==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18203A602B51F3D4171468B8F7630DM5PR12MB1820namp_"

--_000_DM5PR12MB18203A602B51F3D4171468B8F7630DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All of the V2 patches are:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Shirish =
S <shirish.s-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, May 31, 2018 5:59:24 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry
Cc: S, Shirish
Subject: [PATCH] drm/amd/display: avoid sleeping in atomic context while cr=
eating new state (V2)

This patch fixes the warning messages that are caused due to calling
sleep in atomic context as below:

BUG: sleeping function called from invalid context at mm/slab.h:419
in_atomic(): 1, irqs_disabled(): 1, pid: 5, name: kworker/u4:0
CPU: 1 PID: 5 Comm: kworker/u4:0 Tainted: G        W       4.14.35 #941
Workqueue: events_unbound commit_work
Call Trace:
 dump_stack+0x4d/0x63
 ___might_sleep+0x11f/0x12e
 kmem_cache_alloc_trace+0x41/0xea
 dc_create_state+0x1f/0x30
 dc_commit_updates_for_stream+0x73/0x4cf
 ? amdgpu_get_crtc_scanoutpos+0x82/0x16b
 amdgpu_dm_do_flip+0x239/0x298
 amdgpu_dm_commit_planes.isra.23+0x379/0x54b
 ? dc_commit_state+0x3da/0x404
 amdgpu_dm_atomic_commit_tail+0x4fc/0x5d2
 ? wait_for_common+0x5b/0x69
 commit_tail+0x42/0x64
 process_one_work+0x1b0/0x314
 worker_thread+0x1cb/0x2c1
 ? create_worker+0x1da/0x1da
 kthread+0x156/0x15e
 ? kthread_flush_work+0xea/0xea
 ret_from_fork+0x22/0x40

V2: fix applicable only to dc_create_state() and not dc_create().

Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index c88f661..839e3f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -953,7 +953,7 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 struct dc_state *dc_create_state(void)
 {
         struct dc_state *context =3D kzalloc(sizeof(struct dc_state),
-                                          GFP_KERNEL);
+                                          GFP_ATOMIC);

         if (!context)
                 return NULL;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18203A602B51F3D4171468B8F7630DM5PR12MB1820namp_
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
<p style=3D"margin-top:0;margin-bottom:0">All of the V2 patches are:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Shirish S &lt;shirish.s@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, May 31, 2018 5:59:24 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry<br>
<b>Cc:</b> S, Shirish<br>
<b>Subject:</b> [PATCH] drm/amd/display: avoid sleeping in atomic context w=
hile creating new state (V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch fixes the warning messages that are cau=
sed due to calling<br>
sleep in atomic context as below:<br>
<br>
BUG: sleeping function called from invalid context at mm/slab.h:419<br>
in_atomic(): 1, irqs_disabled(): 1, pid: 5, name: kworker/u4:0<br>
CPU: 1 PID: 5 Comm: kworker/u4:0 Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.14.35 #941<br>
Workqueue: events_unbound commit_work<br>
Call Trace:<br>
&nbsp;dump_stack&#43;0x4d/0x63<br>
&nbsp;___might_sleep&#43;0x11f/0x12e<br>
&nbsp;kmem_cache_alloc_trace&#43;0x41/0xea<br>
&nbsp;dc_create_state&#43;0x1f/0x30<br>
&nbsp;dc_commit_updates_for_stream&#43;0x73/0x4cf<br>
&nbsp;? amdgpu_get_crtc_scanoutpos&#43;0x82/0x16b<br>
&nbsp;amdgpu_dm_do_flip&#43;0x239/0x298<br>
&nbsp;amdgpu_dm_commit_planes.isra.23&#43;0x379/0x54b<br>
&nbsp;? dc_commit_state&#43;0x3da/0x404<br>
&nbsp;amdgpu_dm_atomic_commit_tail&#43;0x4fc/0x5d2<br>
&nbsp;? wait_for_common&#43;0x5b/0x69<br>
&nbsp;commit_tail&#43;0x42/0x64<br>
&nbsp;process_one_work&#43;0x1b0/0x314<br>
&nbsp;worker_thread&#43;0x1cb/0x2c1<br>
&nbsp;? create_worker&#43;0x1da/0x1da<br>
&nbsp;kthread&#43;0x156/0x15e<br>
&nbsp;? kthread_flush_work&#43;0xea/0xea<br>
&nbsp;ret_from_fork&#43;0x22/0x40<br>
<br>
V2: fix applicable only to dc_create_state() and not dc_create().<br>
<br>
Signed-off-by: Shirish S &lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index c88f661..839e3f6 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -953,7 &#43;953,7 @@ bool dc_post_update_surfaces_to_stream(struct dc *d=
c)<br>
&nbsp;struct dc_state *dc_create_state(void)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *context =
=3D kzalloc(sizeof(struct dc_state),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
-- <br>
2.7.4<br>
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

--_000_DM5PR12MB18203A602B51F3D4171468B8F7630DM5PR12MB1820namp_--

--===============1900145842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1900145842==--
