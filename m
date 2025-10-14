Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98214CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 14:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BE610E1AA;
	Tue, 14 Oct 2025 14:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCeBVp9V";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE3510E147
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 14:12:08 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-783ad9c784cso357920b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760451128; x=1761055928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG5WoSoXj6KA9NYGKT21wJW26cvufIdbLWGe+6U0sjc=;
 b=TCeBVp9Va6RXLqnDK3aZDbJgWO7E+mIGSp0bIpSFntf6YQG7uY0kkZ5IERL7Fsiq7g
 AjWq/ahYw7SWTjYhyuDRuAAZCeN96c9xkan5BGtOvlf688hIcu+OYwgHKLx/HO/zD3el
 NlsFG2NxXqgR50TcbKqajVGx7mCapYYJqza/8uDeIGvFJbpUw0mjb7Cn0pc9inOM0GC1
 53V+vcqeSAJUh+kWiPLwyvXDmqpK6eKjpK7XKAg7AMQIV6CmbE/xfpvy5aYupCYf6W+g
 LMH4oEGB7g4SkHeGe9XZMMAri/gQ/9jxzSqG3KH5JHHrLZFV3ny+RKV+ai+wfE+kXuCs
 eLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451128; x=1761055928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG5WoSoXj6KA9NYGKT21wJW26cvufIdbLWGe+6U0sjc=;
 b=mhaqKBhaFiLwrl8CwPHX281tZAWtRsS+7bDdMG91jWZLjWh+35p7+0dBLs4E+Xav7q
 2GN85kGbWyjXgXraxQhHtmMqdvMxK1nhtlMFd3jaxSWG9tR4sh26KWzqp6zQFzYD1ZFi
 LIBqoaHZyPHA3jLZ+UaW3OfiZmzZrJvKhNBbOaNzAKGcbYLh9BtiwpZnW42X1bnaNmib
 CSnj/4P27q5c1xU2CBIvQqq3AQdSzt2d/RVlKS9/9Iup7tAq3J3nL0XR7iX/JIkR1hWd
 a8o+z3hBNIJA4J3YcWnrJIe19CTIEYvq23SLczVQXy3lt2W4WmQU77NBqZdvMWXiyXRQ
 QHhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8IgEprvkV+LDNGtxcuuYAmVHnpvtvASpqQs49IZEwUPg3OG6hxSdpgQRtWbAzQeh6uPxAf+ak@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZEVsk5yBfseghy+WB21yT8wzlJP3IUhZz60BtYZbSA9pfsXyX
 mzelj0Et2KqCA/4BYf4rx5ewR3Edb6odGdmmTjGms3HOOGfpOX6EPJNbFTD3ese+BzW6JYzRhg8
 +C7eK03i1CXCkYNxj7Qx7cvpciLQBmQA=
X-Gm-Gg: ASbGnctFh5Xzi6cPewlGT/uuTwWI+2qUHm1rj4ubpsCZIsLV7pBRlkNbgWjJCeSZCkb
 MPpFSyG/zw9CHVxSveqMdpSBKA8e7jDMEMTz/XMnrJZELgK5xKrGtt/i57S8WyLJtDUs7aWHOsG
 U7oi6+fbGcJ3/bjofud8Jh/L+Ne2Hf8L4vsU2rVvf9MgxLP4R6gT0wDBMDyiXeVtFW1e1VKVuuz
 Rykh6Qs3HBcUarYwCPt/RPIP3PfNHZgTcL0
X-Google-Smtp-Source: AGHT+IFNs/UACUDiRlrdAdGMY2/YmBhl8J7lK47t78iV39LSQrjryTkmz6rUa77EfaDyIHG0/fZBO/FBMokxpHIZmkw=
X-Received: by 2002:a17:902:c947:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-290270fbf6fmr204713625ad.0.1760451128036; Tue, 14 Oct 2025
 07:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
 <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
In-Reply-To: <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Oct 2025 10:11:56 -0400
X-Gm-Features: AS18NWD4pSs7zZZc7FcnZbBXG4DbSpg_xsYFbeBzU4UL-tjN3qYOjyvtXoN11Yo
Message-ID: <CADnq5_OTK_sVzANY0-aRzxXpiU77Q6Hrpo5i_h1k1S6yK9eXSw@mail.gmail.com>
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

On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
>>
>> On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <Prike.Liang@amd.c=
om> wrote:
>> >
>> > [Public]
>> >
>> > Regards,
>> >       Prike
>> >
>> > > -----Original Message-----
>> > > From: Alex Deucher <alexdeucher@gmail.com>
>> > > Sent: Monday, October 13, 2025 9:44 PM
>> > > To: Liang, Prike <Prike.Liang@amd.com>
>> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> > > gfx@lists.freedesktop.org
>> > > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment =
to shadow
>> > > info
>> > >
>> > > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <Prike.Liang@am=
d.com> wrote:
>> > > >
>> > > > [Public]
>> > > >
>> > > > We may need to update the userspace EOP buffer request; otherwise,=
 the EOP
>> > > buffer validation may fail.
>> > >
>> > > Existing userspace should be ok.  It currently uses PAGE_SIZE which =
is larger than
>> > > 2048.
>> > The mesa uses the EOP size as max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SI=
ZE) which is sees larger than 2048, so the kernel validates the eop buffer =
can be successful at this point.
>> >
>> > But the mesa may need to use the shadow_info->eop_size as well in the =
future?
>>
>> Ideally mesa would query the kernel to get the proper minimum size.
>> Yogesh will be looking at this.
>>
>> Alex
>
>
> Does the EOP buffer store privileged information? What is its content?

It stores end of pipe events for the compute queue generated from
things like RELEASE_MEM or AQL packets.  They are specific to each
user queue.  In theory corrupting or messing with the data in the
buffer should only affect that queue.

Alex


Alex
