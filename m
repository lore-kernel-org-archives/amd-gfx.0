From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix deadlock around smu_handle_task V2
Date: Tue, 16 Jul 2019 03:21:15 +0000
Message-ID: <MN2PR12MB329686636B30CD79D946BD55A2CE0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190712055054.22119-1-evan.quan@amd.com>,
 <MN2PR12MB3344074D151A9DF09836BFEDE4CE0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1880664927=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344074D151A9DF09836BFEDE4CE0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1880664927==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329686636B30CD79D946BD55A2CE0MN2PR12MB3296namp_"

--_000_MN2PR12MB329686636B30CD79D946BD55A2CE0MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>


Best Regards,

Kevin

________________________________
From: Quan, Evan
Sent: Tuesday, July 16, 2019 11:01:43 AM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wang, Kevin(Yang)
Subject: RE: [PATCH] drm/amd/powerplay: fix deadlock around smu_handle_task=
 V2

Ping..

> -----Original Message-----
> From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> Sent: Friday, July 12, 2019 1:51 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; Quan, Evan
> <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: fix deadlock around
> smu_handle_task V2
>
> As the lock was already held on the entrance to smu_handle_task.
>
> - V2: lock in small granularity
>
> Change-Id: I5388aa917ef0e330974e26c59db42d1354b6a865
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 961f4e54ed18..eb255a6bd3a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -3049,11 +3049,9 @@ void amdgpu_pm_compute_clocks(struct
> amdgpu_device *adev)
>        if (is_support_sw_smu(adev)) {
>                struct smu_context *smu =3D &adev->smu;
>                struct smu_dpm_context *smu_dpm =3D &adev-
> >smu.smu_dpm;
> -             mutex_lock(&(smu->mutex));
>                smu_handle_task(&adev->smu,
>                                smu_dpm->dpm_level,
>                                AMD_PP_TASK_DISPLAY_CONFIG_CHANGE);
> -             mutex_unlock(&(smu->mutex));
>        } else {
>                if (adev->powerplay.pp_funcs->dispatch_tasks) {
>                        if (!amdgpu_device_has_dc_support(adev)) {
> --
> 2.21.0


--_000_MN2PR12MB329686636B30CD79D946BD55A2CE0MN2PR12MB3296namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Kevin Wang &lt;kevin=
1.wang-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Kevin</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Tuesday, July 16, 2019 11:01:43 AM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wang, Kevin(Yang)<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: fix deadlock around smu_hand=
le_task V2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping..<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Friday, July 12, 2019 1:51 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan<br>
&gt; &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH] drm/amd/powerplay: fix deadlock around<br>
&gt; smu_handle_task V2<br>
&gt; <br>
&gt; As the lock was already held on the entrance to smu_handle_task.<br>
&gt; <br>
&gt; - V2: lock in small granularity<br>
&gt; <br>
&gt; Change-Id: I5388aa917ef0e330974e26c59db42d1354b6a865<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 --<br>
&gt;&nbsp; 1 file changed, 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; index 961f4e54ed18..eb255a6bd3a9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -3049,11 &#43;3049,9 @@ void amdgpu_pm_compute_clocks(struct<br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;adev-&gt;smu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;adev-<br>
&gt; &gt;smu.smu_dpm;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mutex_lock(&amp;(smu-&gt;mutex));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu_handle_task(&amp;adev-&gt;smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_level,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PP_TASK_DISPLAY_CONFIG_CHANGE)=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mutex_unlock(&amp;(smu-&gt;mutex));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;dispatch_tasks) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!am=
dgpu_device_has_dc_support(adev)) {<br>
&gt; --<br>
&gt; 2.21.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329686636B30CD79D946BD55A2CE0MN2PR12MB3296namp_--

--===============1880664927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1880664927==--
