Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79636CCD187
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 06:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060C710E0F8;
	Tue, 14 Oct 2025 06:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zgw1u9Bc";
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C7410E0F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 06:49:08 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-37339e99b5bso464837fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760424547; x=1761029347; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jH70VICTd79G02LUK94GDbgL/G/rnwylzHSYETg6H2s=;
 b=Zgw1u9BcFrVFIKOl+xGNnY2YZi26oStYlrUcvAGni473fhht3fGTNHudVDEQbvZI2D
 3SYDwFXflcTfMec50Tz5+/ap4m/hW7FTKQj7GNmIacs3rywzifsM0fpZqgxE151Ms7K1
 ZPgJR9egefUlec/SR5qpfb60R2vOn//k8mhRgGNgXJAw7/GC18qq96xA7p/B2Ty91KvJ
 4YKwURVfSAskGpfpinE8mnHKLosI+Ciy3YKKeMkFpro/Z11FEH6uuS9x42TErYY/fYse
 RUfjXrXVPYs8w1POEI+yqs1slbtokOHDKtbNflj8vLuuVZi/hJ+Z9GLAFDnBIcoxz9Cr
 Nz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760424547; x=1761029347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jH70VICTd79G02LUK94GDbgL/G/rnwylzHSYETg6H2s=;
 b=d+OFZJynEuDPZGCpuROWzFd2HAhteF4WkksBBaJbRjEgFZhV4rUYcRpmNj0/73atyd
 nWycDQE64uoHiieQm3El6RMw2tIAgdZwvI6BALG3z1pQNQ28thrmr4qSscgVc935lYHQ
 NzyYnQM23YTZTS8PcEAu2TklVU6EWOOveEMQbq7DHl28qvqoHl31IdHgq3ImwGVX3x1V
 vtPk0iP0vG99m0gSp1+n/Kqykzho9nkDmmxKH6fjlEqwqao42dDTk6t5SXZUSj0BbR/K
 q3ejortWuWJraNsX6IVFmBCXYolM5igt0HSIpKVwNQ81vvYXJvYvKBaaVj3e6Y65zE26
 FSOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdA3lJrPaFhMIq5zSLuCmhwcDW56rs21Th86iqHe0jGT9vuJPgC3iFR3K5rH9hu9ILUtBGBK7Z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycwQsLNBp9kVJzegXQL7x4XobAL0qBMNj6RYLXwGidnmiPw5hB
 hfXHTF3rU0qV756se5/nopfndmF+FpgnY2ODWjj003HqvFYiLeFxv+cn/Zhv5acXTir/97Nn/Yh
 WJl61mqVOrgXBLj6ihe0ydQso0CNSfGQ=
X-Gm-Gg: ASbGncuA3YS5XVKMSgR7C/W0r/qQQkbJ6FEVc4zg20ZgiIbz7rZrGis2g7XaNXpLOUo
 bEhvXrzejGUM/ePKr06s98A4qgTQz1nl0mAteJmfI9tfERddq/B76+QAwjn7tXim0Kruzflsryf
 fjxdLp0Y2Q90GEBhdk1P27FnplLUa6WfG7OqIq6wZpqRjoqP/sC7egVROyO9PAavtB1IB1AyMqr
 pdv5oVZc0uP7wIkLeSu041SqVBB
X-Google-Smtp-Source: AGHT+IEqUSd5oSg4QwUucK1Y/ChbhcOLg9+koOvjdqmtNpcNUewAYJ57iG7FVqyBMS8cPLbHfbDSGBc4qyklHQFK9/k=
X-Received: by 2002:a05:6808:5283:b0:438:33fd:317c with SMTP id
 5614622812f47-4417b400babmr5504786b6e.3.1760424547065; Mon, 13 Oct 2025
 23:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
In-Reply-To: <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 14 Oct 2025 02:48:31 -0400
X-Gm-Features: AS18NWBvTAPXzz7ldc65eOiTYlBLOCDuWn8-4ctAEUPBvrtbto-ry3tsN6hw7Cc
Message-ID: <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Content-Type: multipart/alternative; boundary="000000000000c8246b064118c7a1"
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

--000000000000c8246b064118c7a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <Prike.Liang@amd.co=
m> wrote:
> >
> > [Public]
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Monday, October 13, 2025 9:44 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > > gfx@lists.freedesktop.org
> > > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment t=
o
> shadow
> > > info
> > >
> > > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <Prike.Liang@amd=
.com>
> wrote:
> > > >
> > > > [Public]
> > > >
> > > > We may need to update the userspace EOP buffer request; otherwise,
> the EOP
> > > buffer validation may fail.
> > >
> > > Existing userspace should be ok.  It currently uses PAGE_SIZE which i=
s
> larger than
> > > 2048.
> > The mesa uses the EOP size as max_t(u32, PAGE_SIZE,
> AMDGPU_GPU_PAGE_SIZE) which is sees larger than 2048, so the kernel
> validates the eop buffer can be successful at this point.
> >
> > But the mesa may need to use the shadow_info->eop_size as well in the
> future?
>
> Ideally mesa would query the kernel to get the proper minimum size.
> Yogesh will be looking at this.
>
> Alex
>

Does the EOP buffer store privileged information? What is its content?

Marek

--000000000000c8246b064118c7a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex =
Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike &lt;<a href=3D"mailto:=
Prike.Liang@amd.com" target=3D"_blank">Prike.Liang@amd.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; [Public]<br>
&gt;<br>
&gt; Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Prike<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" t=
arget=3D"_blank">alexdeucher@gmail.com</a>&gt;<br>
&gt; &gt; Sent: Monday, October 13, 2025 9:44 PM<br>
&gt; &gt; To: Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com" targe=
t=3D"_blank">Prike.Liang@amd.com</a>&gt;<br>
&gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; amd-<br>
&gt; &gt; <a href=3D"mailto:gfx@lists.freedesktop.org" target=3D"_blank">gf=
x@lists.freedesktop.org</a><br>
&gt; &gt; Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignme=
nt to shadow<br>
&gt; &gt; info<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike &lt;<a href=
=3D"mailto:Prike.Liang@amd.com" target=3D"_blank">Prike.Liang@amd.com</a>&g=
t; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [Public]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We may need to update the userspace EOP buffer request; othe=
rwise, the EOP<br>
&gt; &gt; buffer validation may fail.<br>
&gt; &gt;<br>
&gt; &gt; Existing userspace should be ok.=C2=A0 It currently uses PAGE_SIZ=
E which is larger than<br>
&gt; &gt; 2048.<br>
&gt; The mesa uses the EOP size as max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SI=
ZE) which is sees larger than 2048, so the kernel validates the eop buffer =
can be successful at this point.<br>
&gt;<br>
&gt; But the mesa may need to use the shadow_info-&gt;eop_size as well in t=
he future?<br>
<br>
Ideally mesa would query the kernel to get the proper minimum size.<br>
Yogesh will be looking at this.<br>
<br>
Alex<br></blockquote><div><br></div>Does the EOP buffer store privileged in=
formation? What is its content?</div><div class=3D"gmail_quote gmail_quote_=
container"><br></div><div class=3D"gmail_quote gmail_quote_container">Marek=
</div></div>

--000000000000c8246b064118c7a1--
