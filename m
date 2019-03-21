From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix double unlock bug in
 smu_sys_set_pp_table()
Date: Thu, 21 Mar 2019 07:06:07 +0000
Message-ID: <MN2PR12MB3296E3B4F40A53AA743CF69DA2420@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190321062822.GD21489@kadam>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1385492889=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190321062822.GD21489@kadam>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Gao,
 Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1385492889==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296E3B4F40A53AA743CF69DA2420MN2PR12MB3296namp_"

--_000_MN2PR12MB3296E3B4F40A53AA743CF69DA2420MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Dan,


Thank you for your careful attention to the problem.
I made the mistake of this patch, when we do code rebase internally.
and your patch is looks fine for me.

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
Thanks.

Best Regards,
Kevin


________________________________
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sent: Thursday, March 21, 2019 2:28:22 PM
To: Deucher, Alexander; Wang, Kevin(Yang)
Cc: Koenig, Christian; Zhou, David(ChunMing); David Airlie; Daniel Vetter; =
Huang, Ray; Gao, Likun; Gui, Jack; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; kernel-ja=
nitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amd/powerplay: Fix double unlock bug in smu_sys_set_pp=
_table()

We already unlocked a few lines earlier so this code unlocks twice on
the success path.

Fixes: 5809d7420f97 ("drm/amd/powerplay: implement sysfs of pp_table for sm=
u11 (v2)")
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
I'm not sure what this bug looks like at runtime, but it's slightly
weird that no one noticed.  This is from static analysis and I haven't
tested it myself.

 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 00b7c885772b..7e8c74da6a74 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -187,6 +187,8 @@ int smu_sys_set_pp_table(struct smu_context *smu,  void=
 *buf, size_t size)
         if (ret)
                 pr_info("smu reset failed, ret =3D %d\n", ret);

+       return ret;
+
 failed:
         mutex_unlock(&smu->mutex);
         return ret;
--
2.17.1


--_000_MN2PR12MB3296E3B4F40A53AA743CF69DA2420MN2PR12MB3296namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Dan,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>Thank you for your careful attention to the problem.</div>
<div>
<div></div>
<div>I made the mistake of this patch, when we do code&nbsp;rebase internal=
ly.</div>
<div><span style=3D"font-size: 12pt;">and&nbsp;your patch is looks fine for=
 me.</span><br>
</div>
<div><span style=3D"font-size: 12pt;"><br>
</span></div>
<div>Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div>Thanks.</div>
<div><br>
</div>
<div>Best Regards,</div>
<div>Kevin</div>
<div><br>
</div>
</div>
<p></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 21, 2019 2:28:22 PM<br>
<b>To:</b> Deucher, Alexander; Wang, Kevin(Yang)<br>
<b>Cc:</b> Koenig, Christian; Zhou, David(ChunMing); David Airlie; Daniel V=
etter; Huang, Ray; Gao, Likun; Gui, Jack; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; ke=
rnel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Fix double unlock bug in smu_sys=
_set_pp_table()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We already unlocked a few lines earlier so this co=
de unlocks twice on<br>
the success path.<br>
<br>
Fixes: 5809d7420f97 (&quot;drm/amd/powerplay: implement sysfs of pp_table f=
or smu11 (v2)&quot;)<br>
Signed-off-by: Dan Carpenter &lt;dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
---<br>
I'm not sure what this bug looks like at runtime, but it's slightly<br>
weird that no one noticed.&nbsp; This is from static analysis and I haven't=
<br>
tested it myself.<br>
<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 00b7c885772b..7e8c74da6a74 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -187,6 &#43;187,8 @@ int smu_sys_set_pp_table(struct smu_context *smu,&n=
bsp; void *buf, size_t size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info(&quot;smu reset failed, ret =3D %d\n&quot;, r=
et);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&nbsp;failed:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;=
mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296E3B4F40A53AA743CF69DA2420MN2PR12MB3296namp_--

--===============1385492889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1385492889==--
