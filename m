Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6918FD63954
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 14:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C7810E76B;
	Wed, 20 Nov 2024 14:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j4tN9TTF";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C433510E76B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 14:30:31 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-71e49d5deeeso234384b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732113031; x=1732717831; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogxM0D82TRv6bQt4cFiFjpKBRxVah3s50+cMqpgxaSA=;
 b=j4tN9TTFXdmTYeRjuZtJaKLIL+IdKmsNavELcNYMrIZ6DIXxeDDlvzvlB+U9jNIkMs
 Ld+R/MD51w8QrEFdvieCe1hLNruPykGkb7s/T+aX5sHRPGa/qs5rHGgP2uas8Qm/NSaM
 9sjAzwVgQq5B+gf1lWbJUcai17i5mKDJ6ULl9Uw4fiE4UAqtdjDGTcaogCpo9i41LqhI
 GBrSYME6AHKIgvWVCp7kqc3q73oiM+pGb7E2PaSMFgbhLzi+ZtR2axdGulfXK3FYlAb5
 K9ieNyNWWWlKv6pd9JjvJj4OxH0K/PtcAbH+/ndIjVMkUZCJcNY1SoyaCDtiR1ksdq/L
 hRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732113031; x=1732717831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogxM0D82TRv6bQt4cFiFjpKBRxVah3s50+cMqpgxaSA=;
 b=l40niRIT6LUlSbmz4KhN/ydripabzsbn1DC5o3bqbi2I0ItRk15KQWVEfVKuHwiClW
 I3IpXlh0Na2K1O1gXgp24GDSbpcatR6nAuqxv8ha8VAAMikp4caaJ7SrzXeNPLQFg6oL
 /hssDMeex9/E2AoHI+7WLQXfmAa3XN7kjp5w3oH+xtrdDpP0WeZQtEJwiP4Y65v5cctT
 5LyddS99T0lEN26dXXpXo68RuG1cAKUcDdLkWIBOgOwoRP6UnCQ9f3H2fsb2TH7i73Al
 UTfR99fpDVchy7QetKyc5oreW0/xp2U+G7Uchzxm0gkDmPa3pCzBEY8HEReWZ54QxZyJ
 11lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK28mD2C9B1nu9lcUsp7OlPpZpCKgFDk4NXvDh5ImL078qWo8EmXV2Y59lhxsDtMcnlPpgBqRb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7TUjpQBwFMY12VhHvcKbBulWDJahXmzEiCeA/MMNpXMPUyr2B
 WT8RnplTat3QggzNM5zF4ISDKTCQOQkjAupGuRiyenSY18Z/+RA/BzKeeTYHHrObW6h3+0e3srQ
 5WbXnve9DRAikCBA2+FWb0vTzZ+lSHQ==
X-Gm-Gg: ASbGnctHCcCMwLdcKMyshlY+RYy5DW+JyAK+yUQAb4SzsjMs0Q5YmcMaiS4BiuZJyHB
 uoZexiLjOrP0orcYuBQhep2oIY6LoXHU=
X-Google-Smtp-Source: AGHT+IH+iLQW1tKyved7HLu/72Y0yJFJKSN3/7LcL45u8I8xxWNzdj6UNEhKQQEctOqqIeXDTBIDDnyZOJ/75KOnfeU=
X-Received: by 2002:a05:6a00:3d0f:b0:71e:596a:a392 with SMTP id
 d2e1a72fcca58-724bec884bdmr1876697b3a.2.1732113031072; Wed, 20 Nov 2024
 06:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20241119192304.72501-1-alexander.deucher@amd.com>
 <44246f11-33d1-4922-adfe-3a46ec5211c9@daenzer.net>
In-Reply-To: <44246f11-33d1-4922-adfe-3a46ec5211c9@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Nov 2024 09:30:19 -0500
Message-ID: <CADnq5_Oz7Mxd9mFgSmvzqEjhGEy4gV-FGAJtagGr3tLcUpeZ-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc7: fix wait_for_idle callers
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Sunil Khatri <sunil.khatri@amd.com>
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

On Wed, Nov 20, 2024 at 4:21=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
>
> On 2024-11-19 20:23, Alex Deucher wrote:
> > The wait_for_idle signature was changed, but the callers
> > were not.
> >
> > Reported-by: Michel D=C3=A4nzer <michel@daenzer.net>
> > Fixes: 82ae6619a450 ("drm/amdgpu: update the handle ptr in wait_for_idl=
e")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v7_0.c
> > index 8f6f2f067641..347bccd92696 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > @@ -87,9 +87,14 @@ static void gmc_v7_0_init_golden_registers(struct am=
dgpu_device *adev)
> >
> >  static void gmc_v7_0_mc_stop(struct amdgpu_device *adev)
> >  {
> > +     struct amdgpu_ip_block *ip_block;
> >       u32 blackout;
> >
> > -     gmc_v7_0_wait_for_idle((void *)adev);
> > +     ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYP=
E_GMC);
> > +     if (!ip_block)
> > +             return;
> > +
> > +     gmc_v7_0_wait_for_idle(ip_block);
> >
> >       blackout =3D RREG32(mmMC_SHARED_BLACKOUT_CNTL);
> >       if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MOD=
E) !=3D 1) {
> > @@ -251,9 +256,14 @@ static void gmc_v7_0_vram_gtt_location(struct amdg=
pu_device *adev,
> >   */
> >  static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
> >  {
> > +     struct amdgpu_ip_block *ip_block;
> >       u32 tmp;
> >       int i, j;
> >
> > +     ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYP=
E_GMC);
> > +     if (!ip_block)
> > +             return;
> > +
> >       /* Initialize HDP */
> >       for (i =3D 0, j =3D 0; i < 32; i++, j +=3D 0x6) {
> >               WREG32((0xb05 + j), 0x00000000);
>
> Seems simpler to make gmc_v7_0_mc_stop & gmc_v7_0_mc_program take ip_bloc=
k instead of adev as well (and fix up the comment before gmc_v7_0_mc_progra=
m).

I thought about that, but this keeps it consistent with the other gmc
files and I'd like to keep the ip_block to the IP level functions.

Alex

>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
