From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 17/22] drm/amdgpu: disable GFX ring and disable PQ wptr in
 hw_fini
Date: Tue, 27 Feb 2018 14:28:56 +0000
Message-ID: <BN6PR12MB1652350D8779D98B8CC3E502F7C00@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1519622300-8990-1-git-send-email-Monk.Liu@amd.com>
 <1519622300-8990-18-git-send-email-Monk.Liu@amd.com>
 <CADnq5_M1BkpZzNURswAh1fTpm1rZbspkZ4qq+g2pbdVjWyR2eQ@mail.gmail.com>,
 <BLUPR12MB044966DA7194FE030265D15D84C00@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1959412962=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB044966DA7194FE030265D15D84C00-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1959412962==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652350D8779D98B8CC3E502F7C00BN6PR12MB1652namp_"

--_000_BN6PR12MB1652350D8779D98B8CC3E502F7C00BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Please add a comment above the CP_PQ_WPTR_POLL_CNTL write to explain that i=
t's to disable the polling.  WIth that fixed:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liu, Mon=
k <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, February 27, 2018 12:31:35 AM
To: Alex Deucher
Cc: amd-gfx list
Subject: RE: [PATCH 17/22] drm/amdgpu: disable GFX ring and disable PQ wptr=
 in hw_fini

This is only for virtualization, for bare-metal it go another path

-----Original Message-----
From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: 2018=1B$BG/=1B(B2=1B$B7n=1B(B27=1B$BF|=1B(B 1:40
To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 17/22] drm/amdgpu: disable GFX ring and disable PQ wptr=
 in hw_fini

On Mon, Feb 26, 2018 at 12:18 AM, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org> wrote:
> otherwise there will be DMAR reading error comes out from CP since GFX
> is still alive and CPC's WPTR_POLL is still enabled, which would lead
> to DMAR read error.
>
> fix:
> we can hault CPG after hw_fini, but cannot halt CPC becaues KIQ stil
> need to be alive to let RLCV invoke, but its WPTR_POLL could be
> disabled.
>
> Change-Id: Ia60ee54901531f737d09063bf2037630e7c94771
> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Is this handled properly for bare metal as well?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e9cc03e..793db9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2961,7 +2961,8 @@ static int gfx_v9_0_hw_fini(void *handle)
>                 gfx_v9_0_kcq_disable(&adev->gfx.kiq.ring,
> &adev->gfx.compute_ring[i]);
>
>         if (amdgpu_sriov_vf(adev)) {
> -               pr_debug("For SRIOV client, shouldn't do anything.\n");
> +               gfx_v9_0_cp_gfx_enable(adev, false);
> +               WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>                 return 0;
>         }
>         gfx_v9_0_cp_enable(adev, false);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652350D8779D98B8CC3E502F7C00BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Please add a comment above the <f=
ont size=3D"2">
<span style=3D"font-size:11pt;">CP_PQ_WPTR_POLL_CNTL write to explain that =
it's to disable the polling.&nbsp; WIth that fixed:</span></font><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Liu, Monk &lt;Monk.Liu-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<b>Sent:</b> Tuesday, February 27, 2018 12:31:35 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 17/22] drm/amdgpu: disable GFX ring and disable =
PQ wptr in hw_fini</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is only for virtualization, for bare-metal it=
 go another path<br>
<br>
-----Original Message-----<br>
From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:alexdeu=
cher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
Sent: 2018=1B$BG/=1B(B2=1B$B7n=1B(B27=1B$BF|=1B(B 1:40<br>
To: Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
Subject: Re: [PATCH 17/22] drm/amdgpu: disable GFX ring and disable PQ wptr=
 in hw_fini<br>
<br>
On Mon, Feb 26, 2018 at 12:18 AM, Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<=
br>
&gt; otherwise there will be DMAR reading error comes out from CP since GFX=
 <br>
&gt; is still alive and CPC's WPTR_POLL is still enabled, which would lead =
<br>
&gt; to DMAR read error.<br>
&gt;<br>
&gt; fix:<br>
&gt; we can hault CPG after hw_fini, but cannot halt CPC becaues KIQ stil <=
br>
&gt; need to be alive to let RLCV invoke, but its WPTR_POLL could be <br>
&gt; disabled.<br>
&gt;<br>
&gt; Change-Id: Ia60ee54901531f737d09063bf2037630e7c94771<br>
&gt; Signed-off-by: Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Is this handled properly for bare metal as well?<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 &#43;&#43;-<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; index e9cc03e..793db9f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -2961,7 &#43;2961,8 @@ static int gfx_v9_0_hw_fini(void *handle)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_kcq_disable(&amp;adev-&gt;gfx.kiq.ring, =
<br>
&gt; &amp;adev-&gt;gfx.compute_ring[i]);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(ad=
ev)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;For SRIOV client, shouldn't do anything.\n&q=
uot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gfx_v9_0_cp_gfx_enable(adev, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_cp_enable(ade=
v, false);<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1652350D8779D98B8CC3E502F7C00BN6PR12MB1652namp_--

--===============1959412962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1959412962==--
