From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Set VM_L2_CNTL.PDE_FAULT_CLASSIFICATION to 0
Date: Wed, 27 Feb 2019 16:52:06 +0000
Message-ID: <SN1PR12MB23650C66AACF7D0DB1822955F0740@SN1PR12MB2365.namprd12.prod.outlook.com>
References: <20190225230257.18676-1-Yong.Zhao@amd.com>
 <0f3d8a85-e01b-625d-b591-205f7f28af8e@gmail.com>
 <d107229a-062b-8535-87c8-17110d2223ea@amd.com>,
 <CADnq5_O55w2btKnNK7TWvgRmOuE3wC0rGXUXg+u06SdJeOSZ4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1127536778=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O55w2btKnNK7TWvgRmOuE3wC0rGXUXg+u06SdJeOSZ4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1127536778==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB23650C66AACF7D0DB1822955F0740SN1PR12MB2365namp_"

--_000_SN1PR12MB23650C66AACF7D0DB1822955F0740SN1PR12MB2365namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Pushed. Thanks.

Yong
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, February 26, 2019 10:53 PM
To: Zhao, Yong
Cc: Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Set VM_L2_CNTL.PDE_FAULT_CLASSIFICATION to=
 0

yes, go ahead.

Alex

On Tue, Feb 26, 2019 at 6:18 PM Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org> wrote:
>
> So can I submit it only with the ACKs?
>
> Yong
>
> On 2019-02-26 5:29 a.m., Christian K=F6nig wrote:
> > Am 26.02.19 um 00:03 schrieb Zhao, Yong:
> >> This is recommended by HW designers. Previously when it was set to 1,
> >> the PDE walk error in VM fault will be treated as
> >> PERMISSION_OR_INVALID_PAGE_FAULT rather than usually expected
> >> OTHER_FAULT.
> >> As a result, the retry control in VM_CONTEXT*_CNTL will change
> >> accordingly.
> >>
> >> The above behavior is kind of abnormal. Furthermore, the
> >> PDE_FAULT_CLASSIFICATION =3D=3D 1 feature was targeted for very old AS=
ICs
> >> and it never made it way to production. Therefore, we should set it
> >> to 0.
> >>
> >> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> >
> > Acked-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 2 +-
> >>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> >> index f5edddf3b29d..c10ed568ca6c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> >> @@ -143,7 +143,7 @@ static void gfxhub_v1_0_init_cache_regs(struct
> >> amdgpu_device *adev)
> >>       /* XXX for emulation, Refer to closed source code.*/
> >>       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL,
> >> L2_PDE0_CACHE_TAG_GENERATION_MODE,
> >>                   0);
> >> -    tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, =
1);
> >> +    tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, =
0);
> >>       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL,
> >> CONTEXT1_IDENTITY_ACCESS_MODE, 1);
> >>       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL,
> >> IDENTITY_MODE_FRAGMENT_SIZE, 0);
> >>       WREG32_SOC15(GC, 0, mmVM_L2_CNTL, tmp);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> >> index d0d966d6080a..2a039946a549 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> >> @@ -163,7 +163,7 @@ static void mmhub_v1_0_init_cache_regs(struct
> >> amdgpu_device *adev)
> >>       /* XXX for emulation, Refer to closed source code.*/
> >>       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL,
> >> L2_PDE0_CACHE_TAG_GENERATION_MODE,
> >>                   0);
> >> -    tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, =
1);
> >> +    tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, =
0);
> >>       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL,
> >> CONTEXT1_IDENTITY_ACCESS_MODE, 1);
> >>       tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL,
> >> IDENTITY_MODE_FRAGMENT_SIZE, 0);
> >>       WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL, tmp);
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN1PR12MB23650C66AACF7D0DB1822955F0740SN1PR12MB2365namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Pushed. Thanks.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, February 26, 2019 10:53 PM<br>
<b>To:</b> Zhao, Yong<br>
<b>Cc:</b> Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Set VM_L2_CNTL.PDE_FAULT_CLASSIFICA=
TION to 0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">yes, go ahead.<br>
<br>
Alex<br>
<br>
On Tue, Feb 26, 2019 at 6:18 PM Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt; wrote:=
<br>
&gt;<br>
&gt; So can I submit it only with the ACKs?<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; On 2019-02-26 5:29 a.m., Christian K=F6nig wrote:<br>
&gt; &gt; Am 26.02.19 um 00:03 schrieb Zhao, Yong:<br>
&gt; &gt;&gt; This is recommended by HW designers. Previously when it was s=
et to 1,<br>
&gt; &gt;&gt; the PDE walk error in VM fault will be treated as<br>
&gt; &gt;&gt; PERMISSION_OR_INVALID_PAGE_FAULT rather than usually expected=
<br>
&gt; &gt;&gt; OTHER_FAULT.<br>
&gt; &gt;&gt; As a result, the retry control in VM_CONTEXT*_CNTL will chang=
e<br>
&gt; &gt;&gt; accordingly.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The above behavior is kind of abnormal. Furthermore, the<br>
&gt; &gt;&gt; PDE_FAULT_CLASSIFICATION =3D=3D 1 feature was targeted for ve=
ry old ASICs<br>
&gt; &gt;&gt; and it never made it way to production. Therefore, we should =
set it<br>
&gt; &gt;&gt; to 0.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;<br>
&gt; &gt; Acked-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 2 &#43=
;-<br>
&gt; &gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c&nbsp; | 2=
 &#43;-<br>
&gt; &gt;&gt;&nbsp;&nbsp; 2 files changed, 2 insertions(&#43;), 2 deletions=
(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt; &gt;&gt; index f5edddf3b29d..c10ed568ca6c 100644<br>
&gt; &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt; &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br=
>
&gt; &gt;&gt; @@ -143,7 &#43;143,7 @@ static void gfxhub_v1_0_init_cache_re=
gs(struct<br>
&gt; &gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XXX for emulation, Ref=
er to closed source code.*/<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp=
, VM_L2_CNTL,<br>
&gt; &gt;&gt; L2_PDE0_CACHE_TAG_GENERATION_MODE,<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&gt; &gt;&gt; -&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, PD=
E_FAULT_CLASSIFICATION, 1);<br>
&gt; &gt;&gt; &#43;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL=
, PDE_FAULT_CLASSIFICATION, 0);<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp=
, VM_L2_CNTL,<br>
&gt; &gt;&gt; CONTEXT1_IDENTITY_ACCESS_MODE, 1);<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp=
, VM_L2_CNTL,<br>
&gt; &gt;&gt; IDENTITY_MODE_FRAGMENT_SIZE, 0);<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmVM_=
L2_CNTL, tmp);<br>
&gt; &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt; &gt;&gt; index d0d966d6080a..2a039946a549 100644<br>
&gt; &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt; &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt; &gt;&gt; @@ -163,7 &#43;163,7 @@ static void mmhub_v1_0_init_cache_reg=
s(struct<br>
&gt; &gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XXX for emulation, Ref=
er to closed source code.*/<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp=
, VM_L2_CNTL,<br>
&gt; &gt;&gt; L2_PDE0_CACHE_TAG_GENERATION_MODE,<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&gt; &gt;&gt; -&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL, PD=
E_FAULT_CLASSIFICATION, 1);<br>
&gt; &gt;&gt; &#43;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_L2_CNTL=
, PDE_FAULT_CLASSIFICATION, 0);<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp=
, VM_L2_CNTL,<br>
&gt; &gt;&gt; CONTEXT1_IDENTITY_ACCESS_MODE, 1);<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp=
, VM_L2_CNTL,<br>
&gt; &gt;&gt; IDENTITY_MODE_FRAGMENT_SIZE, 0);<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mm=
VM_L2_CNTL, tmp);<br>
&gt; &gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB23650C66AACF7D0DB1822955F0740SN1PR12MB2365namp_--

--===============1127536778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1127536778==--
