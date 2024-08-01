Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8956C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 06:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C6E10E89C;
	Thu,  1 Aug 2024 06:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KKKXhpZd";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB97710E89B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 06:53:37 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-a7ab76558a9so306432266b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722495216; x=1723100016; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/6m65GPDLtMFGHEXDcCZg0mZMFkkB7i45AjDnpLp5mQ=;
 b=KKKXhpZd2u6gkp7M06TCBS0g0V750GgNXHKpmyLHchw4+Mu+0Kr24zVp9hTNDr9hTI
 ojeTgMwGRw5JIgUK3SC1ZfW3RWFTwCkOkHiwDa8plQCaZrISaZl2enjVRtIcw+LqLava
 1YbD+QiGlPLPS3x5x3ly4dAu13/kAnXxsqNrXy0M1aBwmWSIlKMxFw0k2assZrjPHZFf
 +RZMJ/2UtpjWeyfvRbV/9jB+ljVQP1DfR5FNbRU+2DdPDLyaTir6dvCfS6qYDW1fbXO4
 UoNYPtJ9g0/XaVNgia+OX4Q5EP1eJvUBODtR6og83M6ND9j0T+2bKWcnlWfHXmHBz5rT
 Erig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722495216; x=1723100016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/6m65GPDLtMFGHEXDcCZg0mZMFkkB7i45AjDnpLp5mQ=;
 b=OYLe8MTnT0vC37/zvcuR/JWRey+FkxqVm2DqJOgupjT3PKeZm9J3qcZ+FHshjQDfGI
 2Cad8MHhEXfbGIq9THblDoD8BpnUf2KBkRqSBU9LK+QgyFc7K+cOT5ml9U9iLtZgxabg
 7N6OOS8f74VZdJObzTYkLN27i7XYUaMvHIqny1KtybNzo+nhzPkX3KBYgEZgpzTJBke2
 mwGRV+1jd7cAnmQSDRx+0Sn98E5xToFlVYThNFspzAOH9dBDzx1EVrkC7DHtoj8CEI+O
 PJMlatmwVs3XUqESNX57rqzKdKtHXtHp9pFdn0Dm9GJ6C4i2nsqv+bQiWe2oinWKE6E2
 mIBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiQ+NpUh8xMB9CFKdtonpp87ZmSg1ZOT6kYug3B07ja472dDDV5ykV7yXHPqhZyBNjR9YXhOVrvVe8N62SmDnIHIfyebk5NxxhysEQIg==
X-Gm-Message-State: AOJu0YypK9FGc9UA59OjlllAyRA8c37Krwm1xPJAZJbEptQIiO4jjPDc
 tpLrORVnlnmmTk970aGIhxusgRkDWR+J/6kDfhFqPKi/IpwZQb5IeDXQJArdRxr8r8ow/5+mNnY
 T51rECsXGE068gTPxN++8N9ZE4E4=
X-Google-Smtp-Source: AGHT+IFFj1PCufFTEU4v/D9qGaMvkVbai9x4215ydKaU8RFQXKRIoDfBfby3SlPeNkwTJ+129V4xkwsiJFx6ubkhGcE=
X-Received: by 2002:a17:907:2cc5:b0:a6f:996f:23ea with SMTP id
 a640c23a62f3a-a7dbcc28146mr34106666b.15.1722495215365; Wed, 31 Jul 2024
 23:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
In-Reply-To: <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 1 Aug 2024 02:53:23 -0400
Message-ID: <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
Content-Type: multipart/alternative; boundary="00000000000070757c061e99ab15"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000070757c061e99ab15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com> wrote:

>
> On 8/1/2024 8:49 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > On Tue, Jul 30, 2024 at 8:43=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.=
com>
> wrote:
> >> Adding NOP packets one by one in the ring
> >> does not use the CP efficiently.
> >>
> >> Solution:
> >> Use CP optimization while adding NOP packet's so PFP
> >> can discard NOP packets based on information of count
> >> from the Header instead of fetching all NOP packets
> >> one by one.
> >>
> >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> >> Cc: Tvrtko Ursulin <tursulin@igalia.com>
> >> Cc: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> >> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
> >>   1 file changed, 21 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> index 853084a2ce7f..edf5b5c4d185 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct
> amdgpu_ring *ring)
> >>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> >>   }
> >>
> >> +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring,
> uint32_t num_nop)
> >> +{
> >> +       int i;
> >> +
> >> +       /* Header itself is a NOP packet */
> >> +       if (num_nop =3D=3D 1) {
> >> +               amdgpu_ring_write(ring, ring->funcs->nop);
> >> +               return;
> >> +       }
> >> +
> >> +       /* Max HW optimization till 0x3ffe, followed by remaining one
> NOP at a time*/
> >> +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2,
> 0x3ffe)));
> >> +
> >> +       /* Header is at index 0, followed by num_nops - 1 NOP packet's
> */
> >> +       for (i =3D 1; i < num_nop; i++)
> >> +               amdgpu_ring_write(ring, ring->funcs->nop);
> > This loop should be removed. It's unnecessary CPU overhead and we
> > should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the
> > whole packet body uninitialized is the fastest option.
> That was the original intent to just move the WPTR for the no of nops
> and tried too. Based on Christian inputs we should not let the nops packe=
t
>
> as garbage or whatever was there originally as a threat/safety measure.


It doesn't help safety. It can only be read by the GPU with kernel-level
permissions.

Initializing the packet body is useless and adds CPU overhead, especially
with the 256 NOPs or so that we use for no reason.

Marek


> So CPU side there isnt any optimization but just CP will skip all these
> so GPU side should see the benefit.
>
> Regards
> Sunil Khatri
>
> >
> > Marek
> >
> >> +}
> >> +
> >>   static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
> >>   {
> >>          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
> >> @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs
> gfx_v10_0_ring_funcs_gfx =3D {
> >>          .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
> >>          .test_ring =3D gfx_v10_0_ring_test_ring,
> >>          .test_ib =3D gfx_v10_0_ring_test_ib,
> >> -       .insert_nop =3D amdgpu_ring_insert_nop,
> >> +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
> >>          .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >>          .emit_switch_buffer =3D gfx_v10_0_ring_emit_sb,
> >>          .emit_cntxcntl =3D gfx_v10_0_ring_emit_cntxcntl,
> >> @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs
> gfx_v10_0_ring_funcs_compute =3D {
> >>          .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
> >>          .test_ring =3D gfx_v10_0_ring_test_ring,
> >>          .test_ib =3D gfx_v10_0_ring_test_ib,
> >> -       .insert_nop =3D amdgpu_ring_insert_nop,
> >> +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
> >>          .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >>          .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> >>          .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> >> @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs
> gfx_v10_0_ring_funcs_kiq =3D {
> >>          .emit_fence =3D gfx_v10_0_ring_emit_fence_kiq,
> >>          .test_ring =3D gfx_v10_0_ring_test_ring,
> >>          .test_ib =3D gfx_v10_0_ring_test_ib,
> >> -       .insert_nop =3D amdgpu_ring_insert_nop,
> >> +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
> >>          .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >>          .emit_rreg =3D gfx_v10_0_ring_emit_rreg,
> >>          .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> >> --
> >> 2.34.1
> >>
>

--00000000000070757c061e99ab15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, Aug 1, 2024, 00:28 Khatri, Sunil &lt;<a href=3D"mailto=
:sukhatri@amd.com">sukhatri@amd.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><br>
On 8/1/2024 8:49 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On Tue, Jul 30, 2024 at 8:43=E2=80=AFAM Sunil Khatri &lt;<a href=3D"ma=
ilto:sunil.khatri@amd.com" target=3D"_blank" rel=3D"noreferrer">sunil.khatr=
i@amd.com</a>&gt; wrote:<br>
&gt;&gt; Adding NOP packets one by one in the ring<br>
&gt;&gt; does not use the CP efficiently.<br>
&gt;&gt;<br>
&gt;&gt; Solution:<br>
&gt;&gt; Use CP optimization while adding NOP packet&#39;s so PFP<br>
&gt;&gt; can discard NOP packets based on information of count<br>
&gt;&gt; from the Header instead of fetching all NOP packets<br>
&gt;&gt; one by one.<br>
&gt;&gt;<br>
&gt;&gt; Cc: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank" rel=3D"noreferrer">christian.koenig@amd.com</a>&gt=
;<br>
&gt;&gt; Cc: Pierre-Eric Pelloux-Prayer &lt;<a href=3D"mailto:pierre-eric.p=
elloux-prayer@amd.com" target=3D"_blank" rel=3D"noreferrer">pierre-eric.pel=
loux-prayer@amd.com</a>&gt;<br>
&gt;&gt; Cc: Tvrtko Ursulin &lt;<a href=3D"mailto:tursulin@igalia.com" targ=
et=3D"_blank" rel=3D"noreferrer">tursulin@igalia.com</a>&gt;<br>
&gt;&gt; Cc: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.co=
m" target=3D"_blank" rel=3D"noreferrer">marek.olsak@amd.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Sunil Khatri &lt;<a href=3D"mailto:sunil.khatri@amd=
.com" target=3D"_blank" rel=3D"noreferrer">sunil.khatri@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 ++++++++++=
+++++++++++---<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 21 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/=
drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; index 853084a2ce7f..edf5b5c4d185 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct =
amdgpu_ring *ring)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(ring, gcr_cntl=
); /* GCR_CNTL */<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring=
, uint32_t num_nop)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Header itself is a NOP packet */<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_nop =3D=3D 1) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_rin=
g_write(ring, ring-&gt;funcs-&gt;nop);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Max HW optimization till 0x3ffe, fo=
llowed by remaining one NOP at a time*/<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(ring, PACKET3(PACKET=
3_NOP, min(num_nop - 2, 0x3ffe)));<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Header is at index 0, followed by n=
um_nops - 1 NOP packet&#39;s */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 1; i &lt; num_nop; i++)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_rin=
g_write(ring, ring-&gt;funcs-&gt;nop);<br>
&gt; This loop should be removed. It&#39;s unnecessary CPU overhead and we<=
br>
&gt; should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the=
<br>
&gt; whole packet body uninitialized is the fastest option.<br>
That was the original intent to just move the WPTR for the no of nops <br>
and tried too. Based on Christian inputs we should not let the nops packet<=
br>
<br>
as garbage or whatever was there originally as a threat/safety measure.</bl=
ockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It doesn=
&#39;t help safety. It can only be read by the GPU with kernel-level permis=
sions.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Initializing the =
packet body is useless and adds CPU overhead, especially with the 256 NOPs =
or so that we use for no reason.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"> <br>
So CPU side there isnt any optimization but just CP will skip all these <br=
>
so GPU side should see the benefit.<br>
<br>
Regards<br>
Sunil Khatri<br>
<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0static void gfx_v10_ip_print(void *handle, struct drm_=
printer *p)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D (=
struct amdgpu_device *)handle;<br>
&gt;&gt; @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v1=
0_0_ring_funcs_gfx =3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_hdp_flush =3D gfx_v10_0_ri=
ng_emit_hdp_flush,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_ring =3D gfx_v10_0_ring_te=
st_ring,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_ib =3D gfx_v10_0_ring_test=
_ib,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0.insert_nop =3D amdgpu_ring_insert_nop=
,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.insert_nop =3D amdgpu_gfx10_ring_inse=
rt_nop,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pad_ib =3D amdgpu_ring_generic_=
pad_ib,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_switch_buffer =3D gfx_v10_=
0_ring_emit_sb,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_cntxcntl =3D gfx_v10_0_rin=
g_emit_cntxcntl,<br>
&gt;&gt; @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v1=
0_0_ring_funcs_compute =3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_hdp_flush =3D gfx_v10_0_ri=
ng_emit_hdp_flush,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_ring =3D gfx_v10_0_ring_te=
st_ring,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_ib =3D gfx_v10_0_ring_test=
_ib,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0.insert_nop =3D amdgpu_ring_insert_nop=
,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.insert_nop =3D amdgpu_gfx10_ring_inse=
rt_nop,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pad_ib =3D amdgpu_ring_generic_=
pad_ib,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_wreg =3D gfx_v10_0_ring_em=
it_wreg,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_reg_wait =3D gfx_v10_0_rin=
g_emit_reg_wait,<br>
&gt;&gt; @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v1=
0_0_ring_funcs_kiq =3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_fence =3D gfx_v10_0_ring_e=
mit_fence_kiq,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_ring =3D gfx_v10_0_ring_te=
st_ring,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_ib =3D gfx_v10_0_ring_test=
_ib,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0.insert_nop =3D amdgpu_ring_insert_nop=
,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.insert_nop =3D amdgpu_gfx10_ring_inse=
rt_nop,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pad_ib =3D amdgpu_ring_generic_=
pad_ib,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_rreg =3D gfx_v10_0_ring_em=
it_rreg,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_wreg =3D gfx_v10_0_ring_em=
it_wreg,<br>
&gt;&gt; --<br>
&gt;&gt; 2.34.1<br>
&gt;&gt;<br>
</blockquote></div></div></div>

--00000000000070757c061e99ab15--
