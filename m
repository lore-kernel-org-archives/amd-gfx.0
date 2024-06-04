Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C91C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 14:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F9710E49A;
	Tue,  4 Jun 2024 14:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hsx47X7L";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865C810E4A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 14:46:13 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1f6134df05fso51463745ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717512373; x=1718117173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVaxK+HQ4xLYPVP2WKiRiiy6OfDnYI35UAAtqv252FI=;
 b=Hsx47X7LPper4Sh9PyDqYBgqfWHfwHAkaNG/JaMXWaoU5z7ZPfO6rTB+VTsy4toEdw
 FkYBUFKeXqp01bD9Br1BNUNUVYr4RnKDl6Q2MwK88WGbE/bKNezMBLRhTYCAHlauXnKn
 MnmmomZGvD+gmZKcefpOUBbrQ6KlQrttzXeaD98SKJLkJBS/JWHs84yC1ufD/rQR3jI2
 fx2MSBbZUQE2um/svcv+ad/GAEJPOx2AQqPbZlMUgapPMmhCeL58AqNXM5P1IiQeo8Uz
 etdTI/rcdTH/TbqndDGSmWbG2mf/j3MdK1Vn8uLkjuzHhTSmaBsYgmIfblcx60wt+MfX
 UQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717512373; x=1718117173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVaxK+HQ4xLYPVP2WKiRiiy6OfDnYI35UAAtqv252FI=;
 b=pdjhJHzGzB7WSrqGD0W1jPi/fDZAzEGNfvd3pOwCF7HIdVCT34EVdwkAHRF0QpWS8g
 l9KvYMpa4NI/wAtO9R1tzf3ty5HV9CTuNXnE8ZYa/xYQ5IkyopuucXBy00DocYHI1+vk
 Ar6wqSbepM1YkQFUUG6mueqL6r3TswjdUBvLuqBTVQTTRUP/Roj9tRW5uVD4uNb4IFhl
 BD0eJjKsy31XqIpUKl3snbChixha+ySDIKmVkWIep2NvPMFPTxgpm8wdsNRUbM1S8bHD
 e6rx53xXZQHDu+L5OG3JI5k009am0PPrCX3vcIM2ZR0qu+3EpIAjJ1L0rVQm6/BDiB3/
 uU1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKniZ0u1vA8D7Ytcj7o5knyAVpWhmRkjAOCPvauJg7zWBNM1F8V5G25UL7CFcCdc6jM92DBCf0CFfQzumWyIOqrja34hUuJS2hLlEp6Q==
X-Gm-Message-State: AOJu0YwEFg/M44tYEmhW+xs/AwGKm04IB+znuNHeApfJ4rXb2qYShdE1
 G3r8sIzxiG0rmOJfjy45csmsg0ub4t2qOQ0Mc8TLQ+NDnakin0HzbPBJO3dceIz+DUis5UEEdjw
 xrxgpuHq/GTCv3mzh96V8PpKEezQ=
X-Google-Smtp-Source: AGHT+IEIFoC7RZJbMwKg3zxnsLXloCm2Otn01G7lPekaGcQ7ayNVRKYSoeTaEjgejdO8ceYyyJFPP0IKwkE+3ePrdiQ=
X-Received: by 2002:a17:90b:f0e:b0:2c1:a06b:978d with SMTP id
 98e67ed59e1d1-2c1dc57dd20mr10446266a91.12.1717512372582; Tue, 04 Jun 2024
 07:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240604135015.479910-1-alexander.deucher@amd.com>
 <9830fdd9-c738-4b9f-9ecb-2ed83a855243@gmail.com>
In-Reply-To: <9830fdd9-c738-4b9f-9ecb-2ed83a855243@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Jun 2024 10:45:59 -0400
Message-ID: <CADnq5_PtXnCNd3j+rRghtQ0POc-skydA3UqpEPrA7=wexvM0iA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use GFP_ATOMIC for bounding box
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 George Zhang <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com
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

On Tue, Jun 4, 2024 at 10:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 04.06.24 um 15:50 schrieb Alex Deucher:
> > This can be called in atomic context.  Should fix:
> >
> > BUG: sleeping function called from invalid context at include/linux/sch=
ed/mm.h:306
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kwork=
er/u64:8
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > Preemption disabled at:
> > ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> > CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+=
 #35
> > Hardware name: System manufacturer System Product Name/ROG STRIX X570-E=
 GAMING WIFI II, BIOS 4204 02/24/2022
> > Workqueue: events_unbound async_run_entry_fn
>
> That most likely only papers over the real problem and is not a valid fix=
.
>
> The question is why is that an atomic context?  If the function is used
> under a spinlock then this might indeed be the right fix.
>
> If it's because of floating point operation then that here won't work
> either.
>
> In that case the only real fix is to avoid the allocation altogether.

Reverting the patch will bring back the stack size warning.  I guess
the display folks will need to look more closely at this.

Alex

>
> Regards,
> Christian.
>
> >
> > Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_config=
uration_options structures")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: George Zhang <george.zhang@amd.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: harry.wentland@amd.com
> > Cc: sunpeng.li@amd.com
> > Cc: Rodrigo.Siqueira@amd.com
> > ---
> >   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +=
-
> >   .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +=
-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > index 0f11d7c8791c..3fe0d5334145 100644
> > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > @@ -2009,7 +2009,7 @@ static void dcn32_update_bw_bounding_box(struct d=
c *dc, struct clk_bw_params *bw
> >   {
> >       struct dml2_configuration_options *dml2_opt;
> >
> > -     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> > +     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_ATOMIC);
> >       if (!dml2_opt)
> >               return;
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_reso=
urce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> > index 07ca6f58447d..a61cf5741275 100644
> > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> > @@ -1583,7 +1583,7 @@ static void dcn321_update_bw_bounding_box(struct =
dc *dc, struct clk_bw_params *b
> >   {
> >       struct dml2_configuration_options *dml2_opt;
> >
> > -     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_KERNEL);
> > +     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options),=
 GFP_ATOMIC);
> >       if (!dml2_opt)
> >               return;
> >
>
