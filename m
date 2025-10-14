Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DBECCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 16:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1C410E661;
	Tue, 14 Oct 2025 16:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DmAAdv1c";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46AF10E661
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 16:37:48 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b47174b335bso389501a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760459868; x=1761064668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2TF+Ou1+KEkzlkSnvpboqq2zxQBAAxfUfk31uPY5P0=;
 b=DmAAdv1cZByV6S95GXidlaqY+eXVqUUb71NYTZHGjWt8zA7IriPIbgnnAQrZSaZpw3
 h8viMk75ntlnX0cyL4GbA7USvG0LNeQF5F1BDpd29tqJ1667voal0xnxaiZDCHsH3S8q
 2R4ofSjfPC80yNdGiCV54MCu2vPDIzr2Qzx/EyXTtMUxj1PECseoMmJNJ0NlNvrM5pqa
 9sE7ZHTx4wVhZoboAq9EdFN3EYjFXIpSxDrPMz9bASTUaXe34D+79jzIGqtfdBOLM3Hv
 O0cUkvsEysIxXrSB8ajzozH3YsctrBdijHS1J+C/kSpnSJa1/DLr9Rs3pHn3MQwgTWrg
 jSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760459868; x=1761064668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2TF+Ou1+KEkzlkSnvpboqq2zxQBAAxfUfk31uPY5P0=;
 b=VJ2TayzSXQ/NGPvYOmVDn/8msj2Kbg41ipXjaK7jMQTyIE2Q6nv852f3d9g8wEMXt2
 LBzJFKpeBJC7Z0CiFLiI6IzC2/BEUyYsS4UlUAUThznLZR67JAYHN89lfIvSfwC5M7mZ
 Gsk3u1H+hX+fKwSduVS1MDL2hiueUh/9aOYs/wkxEUkRxSe1VM+lDwcA5XQOP1LNEbYz
 R73UmwLjngKmiaOS7fFYawBA6MBR5M8qW9T/BZmKcAlXX0rSCaIfdj85fgku2U0vu3K9
 TQvttoEewQSBLhQqPIihNOG27VcK3pf/wUfivRXgLwwp8L/56v0itwe5+7XMM9PA/WPf
 8KQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL4BAvp2spwJCoTw+rxOgjbpWlOwtDBTL+sgz/v9bO54/h3ib44rl/E0+kOAuBUvgt+HJCe4WL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBZ3tjvoqTe7RsGNxk8MZXNfqPaWacZzWNqEvrOYY2cdZWR/gd
 +dTRuXPxaBRcHdr5c+1V+clbK6Z0aVT1hHn0CoPJXJR5pDL+YhSAsPZwj9XX2WJP21OuWVAFsfb
 xy2gFt5/iy+b1JIa1088mfq7s4WI4Z8g=
X-Gm-Gg: ASbGncsS/fx/8WhqY/8OdQ6/eiue1elklKgIsMwacKtK3Ij59xz1eVc6Qgv1FLnMEmg
 +7CnktM/HbMflJLmXPmn837UCyYGJcocrZfV0d+rAzhfTUGI+kmOH+TxK5MdZfymgZ+aopnpkJS
 SadSL9UMdV3diVqWBugtk8Mj7iNaiLvA9PmhVb4s5vX2DAqQ+/xAtoq5v1nHPGojDMUbDidSkEG
 VOZRpGganSTiI222+vyR0q0l3/fPPDpB/0u
X-Google-Smtp-Source: AGHT+IFp6002t7+81+prTQOSt4tqjBcPq/Vid6tl7+/XWpEhTLhDIsxiKhmsI+ABPyZ2ByT5phJslF324Wz6bWzZ3vE=
X-Received: by 2002:a17:902:c94c:b0:28e:aacb:e6f7 with SMTP id
 d9443c01a7336-2902723ca5dmr183143715ad.3.1760459868311; Tue, 14 Oct 2025
 09:37:48 -0700 (PDT)
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
In-Reply-To: <CAAxE2A7oQfw79nUgAFo9r=6q28-9RPUJa3Lr2OA2VXWcAKG8wA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Oct 2025 12:37:36 -0400
X-Gm-Features: AS18NWByDrBWzasfkUwr3vHB6orA72AijFy-igHhni8PuRuVPainKeq0vNHmTnY
Message-ID: <CADnq5_PAEcKdCTiBz4aOAD7492KSCC+GcKgj_ZbsAC2yrs0LJw@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Oct 14, 2025 at 11:11=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com> wrote:
>
> On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex Deucher <alexdeucher@gmail.=
com> wrote:
>>
>> On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
>> >
>> > On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
>> >>
>> >> On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <Prike.Liang@am=
d.com> wrote:
>> >> >
>> >> > [Public]
>> >> >
>> >> > Regards,
>> >> >       Prike
>> >> >
>> >> > > -----Original Message-----
>> >> > > From: Alex Deucher <alexdeucher@gmail.com>
>> >> > > Sent: Monday, October 13, 2025 9:44 PM
>> >> > > To: Liang, Prike <Prike.Liang@amd.com>
>> >> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> >> > > gfx@lists.freedesktop.org
>> >> > > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignme=
nt to shadow
>> >> > > info
>> >> > >
>> >> > > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <Prike.Liang=
@amd.com> wrote:
>> >> > > >
>> >> > > > [Public]
>> >> > > >
>> >> > > > We may need to update the userspace EOP buffer request; otherwi=
se, the EOP
>> >> > > buffer validation may fail.
>> >> > >
>> >> > > Existing userspace should be ok.  It currently uses PAGE_SIZE whi=
ch is larger than
>> >> > > 2048.
>> >> > The mesa uses the EOP size as max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE=
_SIZE) which is sees larger than 2048, so the kernel validates the eop buff=
er can be successful at this point.
>> >> >
>> >> > But the mesa may need to use the shadow_info->eop_size as well in t=
he future?
>> >>
>> >> Ideally mesa would query the kernel to get the proper minimum size.
>> >> Yogesh will be looking at this.
>> >>
>> >> Alex
>> >
>> >
>> > Does the EOP buffer store privileged information? What is its content?
>>
>> It stores end of pipe events for the compute queue generated from
>> things like RELEASE_MEM or AQL packets.  They are specific to each
>> user queue.  In theory corrupting or messing with the data in the
>> buffer should only affect that queue.
>
>
> RELEASE_MEM has a hidden implicit VMID parameter. That's why it's importa=
nt to know whether it's stored in the EOP buffer that can be overwritten by=
 userspace.

My understanding is that that is only relevant for kernel queues where
the vmid comes from the IB for each job.  For user queues, the vmid is
determined by the HQD so that is unused in the user queue case.

Alex
