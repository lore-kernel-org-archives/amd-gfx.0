Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F619CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 18:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F4010E235;
	Tue, 14 Oct 2025 18:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dq5UIyJD";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC67410E235
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 18:10:29 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-43f48e107cdso128980b6e.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760465429; x=1761070229; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ifBuN0EX8ej5DBrjd14xpfaiIaaf+nKg8naL+js57Xk=;
 b=Dq5UIyJDdWrXYG/KEpBWf8ZzSi3nB0L8kPSJjjIsJqwHvxHSTEN2s6F+qQ3gW8jA9G
 9kGs1su5Kw5FoqifjV95Oul0PqeXgHshnP5cNgRvw8cd5pLeYcDq/92PYsB2PUZ4eihs
 bA9osLCKYHCarMpfH8Lb07rryrPWMNhitaTG39GEEEsG1eDbsO3fUSvcOU0ykhdlH0pb
 iNU/BBZTFREwWCxD5vE4IifPpBU5WPmHBe4wDH0pa/uJlFHDEN1fhfkyZXjRebKmYMqi
 c/1eWVuchYMwEbO1+24c3Kly7BoLsylGI5+txUF2REqMFkXsaRIomvC5g+dUKCXOSjSy
 RgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760465429; x=1761070229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifBuN0EX8ej5DBrjd14xpfaiIaaf+nKg8naL+js57Xk=;
 b=jUH5mNPpPJH1OH05hZN6P9jCWFrMwIpVm6CC/pLauBJucd9hN2TEG+dYvGjXDN4SoP
 lDWp29LuC1+2+OQyI2sBrs6TAiLV6fVNLCDJJPpa6nBeCno4XsxPs4TpsyINzv9oIuU2
 Rb8i6x8rYi7Aczk2Q2T2/TqPZP8iZLYAOttALC4eZeiOqYpuiyy2jZxjgFSiClK8jaM+
 sGrbjQ8YTQQETuIMEj650y0t3XAdph8abOz3kIDwlUitpyhBpGDPoIAecr25oHRnhSnA
 Ja72+h70aa2w3gzCZMW1fmm2SVBuFEsXOpLxhmvqp+A4ocsGuhQ1rnOAYiMNpKiTnTYt
 cQ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5HQJQII+8t9OLjxkNGW4eoAIHsAbVcqRVG4UlPiXth8Bzy3mDyIrlNSQpmoz2ungoWbDJkjpi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywzc+8gktbBvK9zxiS2IdeUyMx7i7a3c4nYLTy4BpIV6apDFify
 ve4BGz0NCFEoHwqfjwsejlwwlcZfmpTO4OZ7J9trJLSg1sK90I9Yp8TzBVEc7+q9Jm7ygJT6USF
 P9PHeOeRnPBdi4MwjtallC4/VxthkHoA=
X-Gm-Gg: ASbGnctbTaTtJbTrNq49IgyqwKztks9zLjX8k1NqXwd9T5Vxl58aUodAFHLhRYmxCil
 qXdqcZSCcuRsoqT9ork+vqacqlmEHnWMZ1fmSpTDD7ctimPyHv7R96MJukroHcCS9GnB247xy+v
 8eaVGHCmrfDWQ4I82Etsq1rQ3rNvCIqZ8SiJMHwL5hWnm163rvOeOKU6/2ui8ZKCrmWUVHWeikR
 +zQFcJvRiSq6mjD2anp0YjZGorGyqnnvns9vi8=
X-Google-Smtp-Source: AGHT+IGzxGjj3f0vbFKIRE4GgSzRwPkQ/WwssEa5P4UTQJQpD2R16d0QCX7XP21BkOXH7dQ/tlgum6Z3idSIQLd96rc=
X-Received: by 2002:a05:6808:250a:b0:439:afa6:276b with SMTP id
 5614622812f47-441f14005d7mr153080b6e.3.1760465428672; Tue, 14 Oct 2025
 11:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
 <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
 <CADnq5_OTK_sVzANY0-aRzxXpiU77Q6Hrpo5i_h1k1S6yK9eXSw@mail.gmail.com>
 <CAAxE2A7oQfw79nUgAFo9r=6q28-9RPUJa3Lr2OA2VXWcAKG8wA@mail.gmail.com>
 <CADnq5_PAEcKdCTiBz4aOAD7492KSCC+GcKgj_ZbsAC2yrs0LJw@mail.gmail.com>
In-Reply-To: <CADnq5_PAEcKdCTiBz4aOAD7492KSCC+GcKgj_ZbsAC2yrs0LJw@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 14 Oct 2025 14:10:16 -0400
X-Gm-Features: AS18NWCtsZ_cYrkJFy8Ofa_S8NwQifqJHpN9mOrhqcuFLYemZZRVAsVoQ3fiqpo
Message-ID: <CAAxE2A6G2uB=S8FQ7-cEO0vYc+bppa=fjEG0BHyzHivEG8FCBA@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Content-Type: multipart/alternative; boundary="00000000000083f5db0641224c37"
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

--00000000000083f5db0641224c37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025, 12:37 Alex Deucher <alexdeucher@gmail.com> wrote:

> On Tue, Oct 14, 2025 at 11:11=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
> >
> > On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex Deucher <alexdeucher@gmai=
l.com>
> wrote:
> >>
> >> On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@=
gmail.com> wrote:
> >> >
> >> > On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher <alexdeucher@gm=
ail.com>
> wrote:
> >> >>
> >> >> On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <Prike.Liang@=
amd.com>
> wrote:
> >> >> >
> >> >> > [Public]
> >> >> >
> >> >> > Regards,
> >> >> >       Prike
> >> >> >
> >> >> > > -----Original Message-----
> >> >> > > From: Alex Deucher <alexdeucher@gmail.com>
> >> >> > > Sent: Monday, October 13, 2025 9:44 PM
> >> >> > > To: Liang, Prike <Prike.Liang@amd.com>
> >> >> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> >> >> > > gfx@lists.freedesktop.org
> >> >> > > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and
> alignment to shadow
> >> >> > > info
> >> >> > >
> >> >> > > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <
> Prike.Liang@amd.com> wrote:
> >> >> > > >
> >> >> > > > [Public]
> >> >> > > >
> >> >> > > > We may need to update the userspace EOP buffer request;
> otherwise, the EOP
> >> >> > > buffer validation may fail.
> >> >> > >
> >> >> > > Existing userspace should be ok.  It currently uses PAGE_SIZE
> which is larger than
> >> >> > > 2048.
> >> >> > The mesa uses the EOP size as max_t(u32, PAGE_SIZE,
> AMDGPU_GPU_PAGE_SIZE) which is sees larger than 2048, so the kernel
> validates the eop buffer can be successful at this point.
> >> >> >
> >> >> > But the mesa may need to use the shadow_info->eop_size as well in
> the future?
> >> >>
> >> >> Ideally mesa would query the kernel to get the proper minimum size.
> >> >> Yogesh will be looking at this.
> >> >>
> >> >> Alex
> >> >
> >> >
> >> > Does the EOP buffer store privileged information? What is its conten=
t?
> >>
> >> It stores end of pipe events for the compute queue generated from
> >> things like RELEASE_MEM or AQL packets.  They are specific to each
> >> user queue.  In theory corrupting or messing with the data in the
> >> buffer should only affect that queue.
> >
> >
> > RELEASE_MEM has a hidden implicit VMID parameter. That's why it's
> important to know whether it's stored in the EOP buffer that can be
> overwritten by userspace.
>
> My understanding is that that is only relevant for kernel queues where
> the vmid comes from the IB for each job.  For user queues, the vmid is
> determined by the HQD so that is unused in the user queue case.


This is NAK'd until a proof is given that the EOP buffer can't be used to
change the VMID of EOP fence writes.

Marek

--00000000000083f5db0641224c37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 14, 2025, 12:37 Alex Deucher=
 &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Oct 14, 2025 at 11:=
11=E2=80=AFAM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex Deucher &lt;<a href=3D"m=
ailto:alexdeucher@gmail.com" target=3D"_blank" rel=3D"noreferrer">alexdeuch=
er@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k &lt;=
<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">ma=
raeo@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher &lt;<a h=
ref=3D"mailto:alexdeucher@gmail.com" target=3D"_blank" rel=3D"noreferrer">a=
lexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike &lt=
;<a href=3D"mailto:Prike.Liang@amd.com" target=3D"_blank" rel=3D"noreferrer=
">Prike.Liang@amd.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; [Public]<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Prike<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; -----Original Message-----<br>
&gt;&gt; &gt;&gt; &gt; &gt; From: Alex Deucher &lt;<a href=3D"mailto:alexde=
ucher@gmail.com" target=3D"_blank" rel=3D"noreferrer">alexdeucher@gmail.com=
</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; Sent: Monday, October 13, 2025 9:44 PM<br>
&gt;&gt; &gt;&gt; &gt; &gt; To: Liang, Prike &lt;<a href=3D"mailto:Prike.Li=
ang@amd.com" target=3D"_blank" rel=3D"noreferrer">Prike.Liang@amd.com</a>&g=
t;<br>
&gt;&gt; &gt;&gt; &gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Al=
exander.Deucher@amd.com" target=3D"_blank" rel=3D"noreferrer">Alexander.Deu=
cher@amd.com</a>&gt;; amd-<br>
&gt;&gt; &gt;&gt; &gt; &gt; <a href=3D"mailto:gfx@lists.freedesktop.org" ta=
rget=3D"_blank" rel=3D"noreferrer">gfx@lists.freedesktop.org</a><br>
&gt;&gt; &gt;&gt; &gt; &gt; Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eo=
p size and alignment to shadow<br>
&gt;&gt; &gt;&gt; &gt; &gt; info<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, =
Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com" target=3D"_blank" rel=3D"n=
oreferrer">Prike.Liang@amd.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [Public]<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; We may need to update the userspace EOP bu=
ffer request; otherwise, the EOP<br>
&gt;&gt; &gt;&gt; &gt; &gt; buffer validation may fail.<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; Existing userspace should be ok.=C2=A0 It curre=
ntly uses PAGE_SIZE which is larger than<br>
&gt;&gt; &gt;&gt; &gt; &gt; 2048.<br>
&gt;&gt; &gt;&gt; &gt; The mesa uses the EOP size as max_t(u32, PAGE_SIZE, =
AMDGPU_GPU_PAGE_SIZE) which is sees larger than 2048, so the kernel validat=
es the eop buffer can be successful at this point.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; But the mesa may need to use the shadow_info-&gt;eop=
_size as well in the future?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Ideally mesa would query the kernel to get the proper min=
imum size.<br>
&gt;&gt; &gt;&gt; Yogesh will be looking at this.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Alex<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Does the EOP buffer store privileged information? What is its=
 content?<br>
&gt;&gt;<br>
&gt;&gt; It stores end of pipe events for the compute queue generated from<=
br>
&gt;&gt; things like RELEASE_MEM or AQL packets.=C2=A0 They are specific to=
 each<br>
&gt;&gt; user queue.=C2=A0 In theory corrupting or messing with the data in=
 the<br>
&gt;&gt; buffer should only affect that queue.<br>
&gt;<br>
&gt;<br>
&gt; RELEASE_MEM has a hidden implicit VMID parameter. That&#39;s why it&#3=
9;s important to know whether it&#39;s stored in the EOP buffer that can be=
 overwritten by userspace.<br>
<br>
My understanding is that that is only relevant for kernel queues where<br>
the vmid comes from the IB for each job.=C2=A0 For user queues, the vmid is=
<br>
determined by the HQD so that is unused in the user queue case.</blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">This is NAK&#39;=
d until a proof is given that the EOP buffer can&#39;t be used to change th=
e VMID of EOP fence writes.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Marek</div><div dir=3D"auto"></div></div>

--00000000000083f5db0641224c37--
