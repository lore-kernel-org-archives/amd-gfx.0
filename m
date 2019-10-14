From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] SWDEV-206718 drm/amdgpu: Fix tdr3 could hang with slow
 compute issue
Date: Mon, 14 Oct 2019 13:19:44 +0000
Message-ID: <BN6PR12MB1809828E95CEF9151F1C7180F7900@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1570618306-11560-1-git-send-email-Emily.Deng@amd.com>,
 <MN2PR12MB2975AFBB743A6C57493F96878F960@MN2PR12MB2975.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0948234385=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB2975AFBB743A6C57493F96878F960-rweVpJHSKToFlvJWC7EAqwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0948234385==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809828E95CEF9151F1C7180F7900BN6PR12MB1809namp_"

--_000_BN6PR12MB1809828E95CEF9151F1C7180F7900BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deng, Em=
ily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Sent: Saturday, October 12, 2019 1:36 AM
To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gf=
x@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-206718 drm/amdgpu: Fix tdr3 could hang with slow=
 compute issue

Ping....

Best wishes
Emily Deng



>-----Original Message-----
>From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>Sent: Wednesday, October 9, 2019 6:52 PM
>To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>Subject: [PATCH] SWDEV-206718 drm/amdgpu: Fix tdr3 could hang with slow
>compute issue
>
>When index is 1, need to set compute ring timeout for sriov and passthroug=
h.
>
>Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 6 ++++--
> 2 files changed, 8 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 53ce227..2f5a015 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2664,8 +2664,11 @@ static int
>amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>                 * There is only one value specified and
>                 * it should apply to all non-compute jobs.
>                 */
>-              if (index =3D=3D 1)
>+              if (index =3D=3D 1) {
>                        adev->sdma_timeout =3D adev->video_timeout =3D ade=
v-
>>gfx_timeout;
>+                      if (amdgpu_sriov_vf(adev) ||
>amdgpu_passthrough(adev))
>+                              adev->compute_timeout =3D adev->gfx_timeout=
;
>+              }
>        }
>
>        return ret;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>index a88ea74..311abc8 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>@@ -250,9 +250,11 @@ module_param_named(msi, amdgpu_msi, int, 0444);
>  * By default(with no lockup_timeout settings), the timeout for all non-
>compute(GFX, SDMA and Video)
>  * jobs is 10000. And there is no timeout enforced on compute jobs.
>  */
>-MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default:
>10000 for non-compute jobs and infinity timeout for compute jobs."
>+MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default:
>for bare metal 10000 for non-compute jobs and infinity timeout for compute
>jobs; "
>+              "for passthrough or sriov, 10000 for all jobs."
>                " 0: keep default value. negative: infinity timeout), "
>-              "format is [Non-Compute] or [GFX,Compute,SDMA,Video]");
>+              "format: for bare metal [Non-Compute] or
>[GFX,Compute,SDMA,Video]; "
>+              "for passthrough or sriov [all jobs] or
>[GFX,Compute,SDMA,Video].");
> module_param_string(lockup_timeout, amdgpu_lockup_timeout,
>sizeof(amdgpu_lockup_timeout), 0444);
>
> /**
>--
>2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809828E95CEF9151F1C7180F7900BN6PR12MB1809namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deng, Emily &lt;Emily.Deng@am=
d.com&gt;<br>
<b>Sent:</b> Saturday, October 12, 2019 1:36 AM<br>
<b>To:</b> Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] SWDEV-206718 drm/amdgpu: Fix tdr3 could hang wi=
th slow compute issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping....<br>
<br>
Best wishes<br>
Emily Deng<br>
<br>
<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;Sent: Wednesday, October 9, 2019 6:52 PM<br>
&gt;To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;Cc: Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;Subject: [PATCH] SWDEV-206718 drm/amdgpu: Fix tdr3 could hang with slow=
<br>
&gt;compute issue<br>
&gt;<br>
&gt;When index is 1, need to set compute ring timeout for sriov and passthr=
ough.<br>
&gt;<br>
&gt;Signed-off-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;---<br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 &#43;&#43;&#43;&#43;-<b=
r>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; | 6 &#43;&#4=
3;&#43;&#43;--<br>
&gt; 2 files changed, 8 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt;diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;index 53ce227..2f5a015 100644<br>
&gt;--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;@@ -2664,8 &#43;2664,11 @@ static int<br>
&gt;amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * There is only one value specified and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * it should apply to all non-compute jobs.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (index =3D=3D 1)<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (index =3D=3D 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;sdma_timeout =3D adev-&gt;video_timeout =3D adev-<br>
&gt;&gt;gfx_timeout;<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sri=
ov_vf(adev) ||<br>
&gt;amdgpu_passthrough(adev))<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;compute_timeout =3D adev-&gt;gfx=
_timeout;<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;index a88ea74..311abc8 100644<br>
&gt;--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;@@ -250,9 &#43;250,11 @@ module_param_named(msi, amdgpu_msi, int, 0444)=
;<br>
&gt;&nbsp; * By default(with no lockup_timeout settings), the timeout for a=
ll non-<br>
&gt;compute(GFX, SDMA and Video)<br>
&gt;&nbsp; * jobs is 10000. And there is no timeout enforced on compute job=
s.<br>
&gt;&nbsp; */<br>
&gt;-MODULE_PARM_DESC(lockup_timeout, &quot;GPU lockup timeout in ms (defau=
lt:<br>
&gt;10000 for non-compute jobs and infinity timeout for compute jobs.&quot;=
<br>
&gt;&#43;MODULE_PARM_DESC(lockup_timeout, &quot;GPU lockup timeout in ms (d=
efault:<br>
&gt;for bare metal 10000 for non-compute jobs and infinity timeout for comp=
ute<br>
&gt;jobs; &quot;<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;for passthrough or sriov, 10000 for all jobs.&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &quot; 0: keep default value. negative: infinity timeou=
t), &quot;<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &quot;format is [Non-Compute] or [GFX,Compute,SDMA,Video]&quot;);<=
br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;format: for bare metal [Non-Compute] or<br>
&gt;[GFX,Compute,SDMA,Video]; &quot;<br>
&gt;&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;for passthrough or sriov [all jobs] or<br>
&gt;[GFX,Compute,SDMA,Video].&quot;);<br>
&gt; module_param_string(lockup_timeout, amdgpu_lockup_timeout,<br>
&gt;sizeof(amdgpu_lockup_timeout), 0444);<br>
&gt;<br>
&gt; /**<br>
&gt;--<br>
&gt;2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809828E95CEF9151F1C7180F7900BN6PR12MB1809namp_--

--===============0948234385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0948234385==--
