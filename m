From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Standardizing the info message for unimplemented functions
Date: Mon, 08 Aug 2016 14:34:21 +0000
Message-ID: <CAPEhTTHdJCjFAArZYZM+1zTw3GBw92PeUb=5m02k8L82_-o3rg@mail.gmail.com>
References: <20160807211741.5485-1-alexandre.f.demers@gmail.com>
 <20160808052223.GA10970@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1062007328=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160808052223.GA10970@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1062007328==
Content-Type: multipart/alternative; boundary=001a1146ff907f51480539905045

--001a1146ff907f51480539905045
Content-Type: text/plain; charset=UTF-8

On Mon, 8 Aug 2016 at 01:22 Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org> wrote:

> On Sun, Aug 07, 2016 at 05:17:41PM -0400, Alexandre Demers wrote:
> > Signed-off-by: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > index 07e0475..9e327be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > @@ -106,14 +106,14 @@ static const uint32_t hpd_int_control_offsets[6] =
> {
> >  static u32 dce_v6_0_audio_endpt_rreg(struct amdgpu_device *adev,
> >                                    u32 block_offset, u32 reg)
> >  {
> > -     DRM_INFO("xxxx: dce_v6_0_audio_endpt_rreg ----no impl!!!!\n");
> > +     DRM_INFO("xxxx: dce_v6_0_audio_endpt_rreg --- not implemented!\n");
> >       return 0;
>
> We can make the code more simple like below:
>
> DRM_INFO("xxxx: %s --- not implemented!\n", __func__);
>
> Thanks,
> Rui
>

I like your suggestion. I'll send a v2 later, I also saw that I had missed
one or two of them.

That being said, I have other work that I'll send in the next few days for
review.

Cheers,
Alexandre Demers

--001a1146ff907f51480539905045
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, 8 Aug =
2016 at 01:22 Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.huang@=
amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sun, Aug =
07, 2016 at 05:17:41PM -0400, Alexandre Demers wrote:<br>
&gt; Signed-off-by: Alexandre Demers &lt;<a href=3D"mailto:alexandre.f.deme=
rs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 22 +++++++++++----------=
-<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v6_0.c<br>
&gt; index 07e0475..9e327be 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
&gt; @@ -106,14 +106,14 @@ static const uint32_t hpd_int_control_offsets[6]=
 =3D {<br>
&gt;=C2=A0 static u32 dce_v6_0_audio_endpt_rreg(struct amdgpu_device *adev,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 block_offset, u=
32 reg)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;xxxx: dce_v6_0_audio_endpt_rreg --=
--no impl!!!!\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;xxxx: dce_v6_0_audio_endpt_rreg --=
- not implemented!\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
We can make the code more simple like below:<br>
<br>
DRM_INFO(&quot;xxxx: %s --- not implemented!\n&quot;, __func__);<br>
<br>
Thanks,<br>
Rui<br></blockquote><div><br></div><div>I like your suggestion. I&#39;ll se=
nd a v2 later, I also saw that I had missed one or two of them.</div><div><=
br></div><div>That being said, I have other work that I&#39;ll send in the =
next few days for review.=C2=A0</div><div><br></div><div>Cheers,</div><div>=
Alexandre Demers</div></div></div>

--001a1146ff907f51480539905045--

--===============1062007328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1062007328==--
