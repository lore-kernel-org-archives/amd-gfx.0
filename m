From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] amdgpu: don't track handles for non-memory
 allocations
Date: Mon, 29 Oct 2018 17:16:44 -0400
Message-ID: <CAAxE2A69cRxHKgNEvCt3WJEcKAuunNSubc_aSNpuH_otpVd2vA@mail.gmail.com>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <20181023190733.15251-2-maraeo@gmail.com>
 <ea6c7b39-82e6-cbe0-15b3-071f0e8964d2@daenzer.net>
 <5d944204-e524-7ada-0188-f68cedbedf1c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1616509695=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5d944204-e524-7ada-0188-f68cedbedf1c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1616509695==
Content-Type: multipart/alternative; boundary="000000000000332c4b0579649870"

--000000000000332c4b0579649870
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK. I'll drop this patch.

Marek

On Wed, Oct 24, 2018 at 4:14 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 24.10.18 um 10:04 schrieb Michel D=C3=A4nzer:
> > On 2018-10-23 9:07 p.m., Marek Ol=C5=A1=C3=A1k wrote:
> >> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >>
> >> ---
> >>   amdgpu/amdgpu_bo.c | 15 +++++++++------
> >>   1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
> >> index 81f8a5f7..00b9b54a 100644
> >> --- a/amdgpu/amdgpu_bo.c
> >> +++ b/amdgpu/amdgpu_bo.c
> >> @@ -91,26 +91,29 @@ drm_public int amdgpu_bo_alloc(amdgpu_device_handl=
e
> dev,
> >>      if (r)
> >>              goto out;
> >>
> >>      r =3D amdgpu_bo_create(dev, alloc_buffer->alloc_size,
> args.out.handle,
> >>                           buf_handle);
> >>      if (r) {
> >>              amdgpu_close_kms_handle(dev, args.out.handle);
> >>              goto out;
> >>      }
> >>
> >> -    pthread_mutex_lock(&dev->bo_table_mutex);
> >> -    r =3D handle_table_insert(&dev->bo_handles, (*buf_handle)->handle=
,
> >> -                            *buf_handle);
> >> -    pthread_mutex_unlock(&dev->bo_table_mutex);
> >> -    if (r)
> >> -            amdgpu_bo_free(*buf_handle);
> >> +    if (alloc_buffer->preferred_heap &
> >> +        (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> > What about AMDGPU_GEM_DOMAIN_CPU? I mean, that's unlikely to actually b=
e
> > used here, but if it were, exporting and importing the resulting BO
> > should work fine?
> >
> > Instead of white-listing the domains which can be shared, it might be
> > better to black-list those which can't, i.e. GDS/GWS/OA.
>
> Well first of all GDS can be shared between applications.
>
> Then adding a BO to the tracking doesn't add much overhead (only 8 bytes
> and only if it was the last allocated).
>
> So I don't really see a reason why we should do this?
>
> Christian.
>

--000000000000332c4b0579649870
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>OK. I&#39;ll drop this patch.</div><div><br></div><di=
v>Marek<br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On We=
d, Oct 24, 2018 at 4:14 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoen=
ig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Am 24.10.18 um 10:04 schrieb Mich=
el D=C3=A4nzer:<br>
&gt; On 2018-10-23 9:07 p.m., Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt;&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.=
com" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0amdgpu/amdgpu_bo.c | 15 +++++++++------<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 9 insertions(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c<br>
&gt;&gt; index 81f8a5f7..00b9b54a 100644<br>
&gt;&gt; --- a/amdgpu/amdgpu_bo.c<br>
&gt;&gt; +++ b/amdgpu/amdgpu_bo.c<br>
&gt;&gt; @@ -91,26 +91,29 @@ drm_public int amdgpu_bo_alloc(amdgpu_device_h=
andle dev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_bo_create(dev, alloc_buffer-&gt;a=
lloc_size, args.out.handle,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_handle);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (r) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_close_kms_h=
andle(dev, args.out.handle);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt; -=C2=A0 =C2=A0 pthread_mutex_lock(&amp;dev-&gt;bo_table_mutex);<br=
>
&gt;&gt; -=C2=A0 =C2=A0 r =3D handle_table_insert(&amp;dev-&gt;bo_handles, =
(*buf_handle)-&gt;handle,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *buf_handle);<br>
&gt;&gt; -=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;dev-&gt;bo_table_mutex);<=
br>
&gt;&gt; -=C2=A0 =C2=A0 if (r)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_free(*buf_han=
dle);<br>
&gt;&gt; +=C2=A0 =C2=A0 if (alloc_buffer-&gt;preferred_heap &amp;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_=
DOMAIN_GTT)) {<br>
&gt; What about AMDGPU_GEM_DOMAIN_CPU? I mean, that&#39;s unlikely to actua=
lly be<br>
&gt; used here, but if it were, exporting and importing the resulting BO<br=
>
&gt; should work fine?<br>
&gt;<br>
&gt; Instead of white-listing the domains which can be shared, it might be<=
br>
&gt; better to black-list those which can&#39;t, i.e. GDS/GWS/OA.<br>
<br>
Well first of all GDS can be shared between applications.<br>
<br>
Then adding a BO to the tracking doesn&#39;t add much overhead (only 8 byte=
s <br>
and only if it was the last allocated).<br>
<br>
So I don&#39;t really see a reason why we should do this?<br>
<br>
Christian.<br>
</blockquote></div></div></div>

--000000000000332c4b0579649870--

--===============1616509695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1616509695==--
