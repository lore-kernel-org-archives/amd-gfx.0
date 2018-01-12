From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: only allow scatter/gather display with DC
Date: Fri, 12 Jan 2018 21:39:51 +0000
Message-ID: <CY4PR12MB1653DBF1627D5B4FA9F2F2BFF7170@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <20180112195811.15372-1-alexander.deucher@amd.com>
 <c10fed9d-fdd0-ff5e-7b3b-8cc9ffe809d2@gmail.com>,
 <BY1PR12MB0504B7C3435FCA8BD2887570F5170@BY1PR12MB0504.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0196126675=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY1PR12MB0504B7C3435FCA8BD2887570F5170-PicGAnIBOoZIlHzfMOeg3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0196126675==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1653DBF1627D5B4FA9F2F2BFF7170CY4PR12MB1653namp_"

--_000_CY4PR12MB1653DBF1627D5B4FA9F2F2BFF7170CY4PR12MB1653namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I think you are getting lucky with the pageflip buffers always ending up in=
 vram.  Also, the legacy dce code (e.g., dce_v11_0.c) always pins in vram f=
or modesets.


Alex


________________________________
From: Li, Samuel
Sent: Friday, January 12, 2018 4:35 PM
To: Koenig, Christian; Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: RE: [PATCH] drm/amdgpu: only allow scatter/gather display with DC

Somehow my test case seems working although DC not enabled?


Regards,
Samuel Li


> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Christian K=F6nig
> Sent: Friday, January 12, 2018 4:03 PM
> To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-
> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: [PATCH] drm/amdgpu: only allow scatter/gather display with D=
C
>
> Am 12.01.2018 um 20:58 schrieb Alex Deucher:
> > Check if DC is enabled before allowing scanout buffers to be pinned in
> > system memory.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 8ede2645a06c..859942552e9f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -507,9 +507,12 @@ uint32_t
> amdgpu_display_framebuffer_domains(struct amdgpu_device *adev)
> >   {
> >      uint32_t domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >
> > +#if defined(CONFIG_DRM_AMD_DC)
> >      if (adev->asic_type >=3D CHIP_CARRIZO && adev->asic_type <
> CHIP_RAVEN &&
> > -       adev->flags & AMD_IS_APU)
> > +       adev->flags & AMD_IS_APU &&
> > +       amdgpu_device_asic_has_dc_support(adev->asic_type))
> >              domain |=3D AMDGPU_GEM_DOMAIN_GTT;
> > +#endif
> >
> >      return domain;
> >   }
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1653DBF1627D5B4FA9F2F2BFF7170CY4PR12MB1653namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I think you are getting lucky wit=
h the pageflip buffers always ending up in vram.&nbsp; Also, the legacy dce=
 code (e.g., dce_v11_0.c) always pins in vram for modesets.<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Li, Samuel<br>
<b>Sent:</b> Friday, January 12, 2018 4:35 PM<br>
<b>To:</b> Koenig, Christian; Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<b=
r>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: only allow scatter/gather display w=
ith DC</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Somehow my test case seems working although DC not=
 enabled?<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><br>
Regards,<br>
Samuel Li<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Christian K=F6nig<br>
&gt; Sent: Friday, January 12, 2018 4:03 PM<br>
&gt; To: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; amd-<br>
&gt; gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: only allow scatter/gather display wit=
h DC<br>
&gt; <br>
&gt; Am 12.01.2018 um 20:58 schrieb Alex Deucher:<br>
&gt; &gt; Check if DC is enabled before allowing scanout buffers to be pinn=
ed in<br>
&gt; &gt; system memory.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 &#43;=
&#43;&#43;&#43;-<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 4 insertions(&#43;), 1 deletion(-)<br=
>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; &gt; index 8ede2645a06c..859942552e9f 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; &gt; @@ -507,9 &#43;507,12 @@ uint32_t<br>
&gt; amdgpu_display_framebuffer_domains(struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t domain =3D AMDGPU_GEM_DOMA=
IN_VRAM;<br>
&gt; &gt;<br>
&gt; &gt; &#43;#if defined(CONFIG_DRM_AMD_DC)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP=
_CARRIZO &amp;&amp; adev-&gt;asic_type &lt;<br>
&gt; CHIP_RAVEN &amp;&amp;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;flags &amp; AMD_IS=
_APU)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;flags &amp; AM=
D_IS_APU &amp;&amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_asic_has_=
dc_support(adev-&gt;asic_type))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; domain |=3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt; &gt; &#43;#endif<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return domain;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1653DBF1627D5B4FA9F2F2BFF7170CY4PR12MB1653namp_--

--===============0196126675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0196126675==--
