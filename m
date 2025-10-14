Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F63DCCD192
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 15:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53C810E63D;
	Tue, 14 Oct 2025 15:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTuZTAbK";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87B910E63D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 15:11:29 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-43f83f719ceso120678b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760454689; x=1761059489; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4rZWwKBGHJC1A0M3iZR0E2gojOx9j2e/4r6eIkFG064=;
 b=gTuZTAbKW+bMhFbrHYxU1k5Vvw9QSAmJB4iwrlSTEID+76yYaB85k7WbgQLKZj2HST
 kmLkmjIdSzhdGCK/qqHD044LRQXcplHM3lPspTf8uEdSFWyHhGKlCTh4U8aqVjPjj16P
 C9pIph5+7bLQ2XOrew2dwTyeIy3e92OeSZ6elxHex8iTOribPcWft5F+ZlW7shX4z+OU
 /hARudiVXbCbpgglrNa7inL6hHIAimrfWQN0S63ngyxs27XctJVz72w91EVN4nFBeAFf
 dj/xZBr7MIi1r2RRiH3yKIWOR+cc0D9gket8wzxmR9xfJoCBe/VAyuvQ3S6d8JMYAR2A
 6Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760454689; x=1761059489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rZWwKBGHJC1A0M3iZR0E2gojOx9j2e/4r6eIkFG064=;
 b=mSoSylQRFMx9B9OO0mg80qNK9nIRrl6iYdyp6mgUOarNHdrhmu5Yw4P5sK1qAGvoZ6
 2tnEk2rfqk48Hb9Zjl0w/nCA1ivMAzb5QSo9eP0c+vrDLJTxSd5T26hlQ1rOeiBgmWzV
 SMpNUhpbjyeYkSO1qV+4PnXFBN3lreep3mw28W4T5VnkyfLHKxNlMBfu7rNQjVYVMN8q
 0tkEI3n0HOzFnAmxA120j2j6ebq/NfRsWtK3TJKFAmI3KNvsHozVqLsHmkUOe3SOkdXm
 Awdh4bz8hviVs2ARgxemuQRhM9jv9cuUQBZ//G2pjIZlirH7MdVguffJAkt3pInr7Mq4
 EmXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx6psNHkrxpTYKviIEB9Fm593i1M0tzP+1J72Yhzhia8VXA/f50uHeDRafP5aEnEvuo3NRQU3s@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz65tRpr5z5zi7LIghLLOOVkxtzF5JyFxS2rjSkO8DpGqeIhyyg
 SGPoN6d2knnYTbBNf2AJPzcxAqdt/26oA4y1HEXgnyFDI9zDh8FOCDHCtlEuwS5Of10XcMQH0LN
 HwvuEFG+Qjgh64yWKwkx5vugrdsDrthU=
X-Gm-Gg: ASbGncviHDocJz5ey9gidOf1c4qNmtgUOtCtulQHocXrpUOoYN9LtZCQV+JGMeolPdn
 0DPLwVl80Ou70sH0uha9nONR0OX1ckndxiEE3ojFbMZRfPdUhCHvT/oL4qc9MteWLg9jnvfPn6Q
 GebfUdxJx9s8F/ZZg2HxOnlwNwF/Y4xvIs+Qt1BwUEIVuVf1vA6AScU/hNsu28TxyDDTV3nJQgv
 qEe+xutZdib4yzHpgPMux2fzF4izWhuiRq2590=
X-Google-Smtp-Source: AGHT+IE394fD43AQeNH5GIoJVOTDRVH6gvX4OadYgRQgorPS8AM075cIgKLSj00EZhF4eMr7zQLEVOvXcZEKcSETuhg=
X-Received: by 2002:a05:6808:1382:b0:43f:2cab:548d with SMTP id
 5614622812f47-4417b2c4888mr6283549b6e.2.1760454688936; Tue, 14 Oct 2025
 08:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
 <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
 <CADnq5_OTK_sVzANY0-aRzxXpiU77Q6Hrpo5i_h1k1S6yK9eXSw@mail.gmail.com>
In-Reply-To: <CADnq5_OTK_sVzANY0-aRzxXpiU77Q6Hrpo5i_h1k1S6yK9eXSw@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 14 Oct 2025 11:10:52 -0400
X-Gm-Features: AS18NWBpGEeCHmLCedjAKX8DBfUnSDrWuJBzfC-QzPhk8Ds1wR2Q97nYGco29pU
Message-ID: <CAAxE2A7oQfw79nUgAFo9r=6q28-9RPUJa3Lr2OA2VXWcAKG8wA@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Content-Type: multipart/alternative; boundary="00000000000060993106411fcc29"
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

--00000000000060993106411fcc29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:

> On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com>
> wrote:
> >>
> >> On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <Prike.Liang@amd=
.com>
> wrote:
> >> >
> >> > [Public]
> >> >
> >> > Regards,
> >> >       Prike
> >> >
> >> > > -----Original Message-----
> >> > > From: Alex Deucher <alexdeucher@gmail.com>
> >> > > Sent: Monday, October 13, 2025 9:44 PM
> >> > > To: Liang, Prike <Prike.Liang@amd.com>
> >> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> >> > > gfx@lists.freedesktop.org
> >> > > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignmen=
t
> to shadow
> >> > > info
> >> > >
> >> > > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <Prike.Liang@=
amd.com>
> wrote:
> >> > > >
> >> > > > [Public]
> >> > > >
> >> > > > We may need to update the userspace EOP buffer request;
> otherwise, the EOP
> >> > > buffer validation may fail.
> >> > >
> >> > > Existing userspace should be ok.  It currently uses PAGE_SIZE whic=
h
> is larger than
> >> > > 2048.
> >> > The mesa uses the EOP size as max_t(u32, PAGE_SIZE,
> AMDGPU_GPU_PAGE_SIZE) which is sees larger than 2048, so the kernel
> validates the eop buffer can be successful at this point.
> >> >
> >> > But the mesa may need to use the shadow_info->eop_size as well in th=
e
> future?
> >>
> >> Ideally mesa would query the kernel to get the proper minimum size.
> >> Yogesh will be looking at this.
> >>
> >> Alex
> >
> >
> > Does the EOP buffer store privileged information? What is its content?
>
> It stores end of pipe events for the compute queue generated from
> things like RELEASE_MEM or AQL packets.  They are specific to each
> user queue.  In theory corrupting or messing with the data in the
> buffer should only affect that queue.
>

RELEASE_MEM has a hidden implicit VMID parameter. That's why it's important
to know whether it's stored in the EOP buffer that can be overwritten by
userspace.

Marek

--00000000000060993106411fcc29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex=
 Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k &lt;<a href=
=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher &lt;<a href=3D"ma=
ilto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt;=
 wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike &lt;<a href=
=3D"mailto:Prike.Liang@amd.com" target=3D"_blank">Prike.Liang@amd.com</a>&g=
t; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; [Public]<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Prike<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &gt; -----Original Message-----<br>
&gt;&gt; &gt; &gt; From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gma=
il.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt;<br>
&gt;&gt; &gt; &gt; Sent: Monday, October 13, 2025 9:44 PM<br>
&gt;&gt; &gt; &gt; To: Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.c=
om" target=3D"_blank">Prike.Liang@amd.com</a>&gt;<br>
&gt;&gt; &gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.D=
eucher@amd.com" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; amd-<b=
r>
&gt;&gt; &gt; &gt; <a href=3D"mailto:gfx@lists.freedesktop.org" target=3D"_=
blank">gfx@lists.freedesktop.org</a><br>
&gt;&gt; &gt; &gt; Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size an=
d alignment to shadow<br>
&gt;&gt; &gt; &gt; info<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike &lt=
;<a href=3D"mailto:Prike.Liang@amd.com" target=3D"_blank">Prike.Liang@amd.c=
om</a>&gt; wrote:<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; [Public]<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; We may need to update the userspace EOP buffer requ=
est; otherwise, the EOP<br>
&gt;&gt; &gt; &gt; buffer validation may fail.<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Existing userspace should be ok.=C2=A0 It currently uses=
 PAGE_SIZE which is larger than<br>
&gt;&gt; &gt; &gt; 2048.<br>
&gt;&gt; &gt; The mesa uses the EOP size as max_t(u32, PAGE_SIZE, AMDGPU_GP=
U_PAGE_SIZE) which is sees larger than 2048, so the kernel validates the eo=
p buffer can be successful at this point.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; But the mesa may need to use the shadow_info-&gt;eop_size as =
well in the future?<br>
&gt;&gt;<br>
&gt;&gt; Ideally mesa would query the kernel to get the proper minimum size=
.<br>
&gt;&gt; Yogesh will be looking at this.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt; Does the EOP buffer store privileged information? What is its content?=
<br>
<br>
It stores end of pipe events for the compute queue generated from<br>
things like RELEASE_MEM or AQL packets.=C2=A0 They are specific to each<br>
user queue.=C2=A0 In theory corrupting or messing with the data in the<br>
buffer should only affect that queue.<br></blockquote><div><br></div>RELEAS=
E_MEM has a hidden implicit VMID parameter. That&#39;s why it&#39;s importa=
nt to know whether it&#39;s stored in the EOP buffer that can be overwritte=
n by userspace.</div><div class=3D"gmail_quote gmail_quote_container"><br><=
/div><div class=3D"gmail_quote gmail_quote_container">Marek</div></div>

--00000000000060993106411fcc29--
