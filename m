From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Thu, 12 Jul 2018 13:03:24 -0400
Message-ID: <CAAxE2A6Vz08sWXiaB6B-F4_P7Fy6uDuJ7aF2gHLXZ4N3zj9sXw@mail.gmail.com>
References: <20180712004750.2024-1-maraeo@gmail.com>
 <9a8d8f7f-a468-fd5b-dec5-472ce9c88483@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0276532107=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9a8d8f7f-a468-fd5b-dec5-472ce9c88483-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0276532107==
Content-Type: multipart/alternative; boundary="0000000000000473110570d0581a"

--0000000000000473110570d0581a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018, 3:31 AM Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote=
:

> On 2018-07-12 02:47 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >
> > ---
> >  amdgpu/amdgpu.h    | 7 ++++++-
> >  amdgpu/amdgpu_bo.c | 4 ++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
> > index 36f91058..be83b457 100644
> > --- a/amdgpu/amdgpu.h
> > +++ b/amdgpu/amdgpu.h
> > @@ -77,21 +77,26 @@ struct drm_amdgpu_info_hw_ip;
> >   *
> >  */
> >  enum amdgpu_bo_handle_type {
> >       /** GEM flink name (needs DRM authentication, used by DRI2) */
> >       amdgpu_bo_handle_type_gem_flink_name =3D 0,
> >
> >       /** KMS handle which is used by all driver ioctls */
> >       amdgpu_bo_handle_type_kms =3D 1,
> >
> >       /** DMA-buf fd handle */
> > -     amdgpu_bo_handle_type_dma_buf_fd =3D 2
> > +     amdgpu_bo_handle_type_dma_buf_fd =3D 2,
> > +
> > +     /** KMS handle, but re-importing as a DMABUF handle through
> > +      *  drmPrimeHandleToFD is forbidden. (Glamor does that)
> > +      */
> > +     amdgpu_bo_handle_type_kms_noimport =3D 3,
> >  };
> >
> >  /** Define known types of GPU VM VA ranges */
> >  enum amdgpu_gpu_va_range
> >  {
> >       /** Allocate from "normal"/general range */
> >       amdgpu_gpu_va_range_general =3D 0
> >  };
> >
> >  enum amdgpu_sw_info {
> > diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
> > index 9e37b149..d29be244 100644
> > --- a/amdgpu/amdgpu_bo.c
> > +++ b/amdgpu/amdgpu_bo.c
> > @@ -234,20 +234,22 @@ int amdgpu_bo_export(amdgpu_bo_handle bo,
> >       case amdgpu_bo_handle_type_gem_flink_name:
> >               r =3D amdgpu_bo_export_flink(bo);
> >               if (r)
> >                       return r;
> >
> >               *shared_handle =3D bo->flink_name;
> >               return 0;
> >
> >       case amdgpu_bo_handle_type_kms:
> >               amdgpu_add_handle_to_table(bo);
> > +             /* fall through */
> > +     case amdgpu_bo_handle_type_kms_noimport:
> >               *shared_handle =3D bo->handle;
> >               return 0;
>
> What is the rationale for this? I.e. why do you want to not store some
> handles in the hash table?


Because I have the option.

And how can code using
> amdgpu_bo_handle_type_kms_noimport be sure that the BO will never be
> re-imported via dma-buf?
>

That's for the user to decide and prove when it's safe.


> The experience with the previous patch has shown that it's hard to keep
> track of all possible ways in which BOs are imported, and that if we
> miss one, this breaks pretty spectacularly.
>

You are assuming that it will be used incorrectly based on your previous
bad experience. All I need to do is not to hand the handle to components
that would misuse it.

Marek


>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--0000000000000473110570d0581a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, =
Jul 12, 2018, 3:31 AM Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel@daenz=
er.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On 2018-07-12 02:47 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank" rel=3D"noreferrer">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt;=C2=A0 amdgpu/amdgpu.h=C2=A0 =C2=A0 | 7 ++++++-<br>
&gt;=C2=A0 amdgpu/amdgpu_bo.c | 4 ++++<br>
&gt;=C2=A0 2 files changed, 10 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h<br>
&gt; index 36f91058..be83b457 100644<br>
&gt; --- a/amdgpu/amdgpu.h<br>
&gt; +++ b/amdgpu/amdgpu.h<br>
&gt; @@ -77,21 +77,26 @@ struct drm_amdgpu_info_hw_ip;<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 */<br>
&gt;=C2=A0 enum amdgpu_bo_handle_type {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** GEM flink name (needs DRM authentication=
, used by DRI2) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_handle_type_gem_flink_name =3D 0,<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** KMS handle which is used by all driver i=
octls */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_handle_type_kms =3D 1,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** DMA-buf fd handle */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_handle_type_dma_buf_fd =3D 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0amdgpu_bo_handle_type_dma_buf_fd =3D 2,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/** KMS handle, but re-importing as a DMABUF hand=
le through<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 drmPrimeHandleToFD is forbidden. (Glamor=
 does that)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0amdgpu_bo_handle_type_kms_noimport =3D 3,<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /** Define known types of GPU VM VA ranges */<br>
&gt;=C2=A0 enum amdgpu_gpu_va_range<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Allocate from &quot;normal&quot;/general=
 range */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gpu_va_range_general =3D 0<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 enum amdgpu_sw_info {<br>
&gt; diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c<br>
&gt; index 9e37b149..d29be244 100644<br>
&gt; --- a/amdgpu/amdgpu_bo.c<br>
&gt; +++ b/amdgpu/amdgpu_bo.c<br>
&gt; @@ -234,20 +234,22 @@ int amdgpu_bo_export(amdgpu_bo_handle bo,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case amdgpu_bo_handle_type_gem_flink_name:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_=
export_flink(bo);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*shared_handle =
=3D bo-&gt;flink_name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case amdgpu_bo_handle_type_kms:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_add_handl=
e_to_table(bo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0case amdgpu_bo_handle_type_kms_noimport:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*shared_handle =
=3D bo-&gt;handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
What is the rationale for this? I.e. why do you want to not store some<br>
handles in the hash table?</blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Because I have the option.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"> And how can code using<br>
amdgpu_bo_handle_type_kms_noimport be sure that the BO will never be<br>
re-imported via dma-buf?<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">That&#39;s for the user to decide and prove when it=
&#39;s safe.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
The experience with the previous patch has shown that it&#39;s hard to keep=
<br>
track of all possible ways in which BOs are imported, and that if we<br>
miss one, this breaks pretty spectacularly.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">You are assuming that it will be=
 used incorrectly based on your previous bad experience. All I need to do i=
s not to hand the handle to components that would misuse it.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Marek</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
p://www.amd.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div></div></div>

--0000000000000473110570d0581a--

--===============0276532107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0276532107==--
