Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7578EC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C3610E583;
	Mon,  4 Aug 2025 14:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jquUNjxe";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4330910E583
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:43:05 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-32127d5f63eso156476a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754318584; x=1754923384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZew77Vq4pRHzqWzeExKnFv5JWynzaRBAaz121Z9QjY=;
 b=jquUNjxeCiZeQfgYzq6x27rNisk2bJ7TizpaTz0pW4hafRYZMnliV7e/PLhXdEVq2e
 o7g9vT22VovKmW5tEX98XQopz/CI8+Lf84y3jguP4657Gfl0sjdn8nGy6Ftaw71tm+JI
 M/insZxG+euxtd1I5xwGbuwzQqjbzY2zSZgW5/LW6wnzhKBpHqcwxiI+8BMqHg/en/un
 Yy7Gu0r/q4ZETkcUwO81XUFm7Yknwfe4nzxxlTv1Qu7wx7vrlWUYuBBZw+F7h7K0A2i6
 vkS+GXMRkr2j/OtjXXfV1WDSc2IAOx9MmLarwlvhnQ207mKkt95CdQgC5zttGK2eCHHF
 sOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754318584; x=1754923384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZew77Vq4pRHzqWzeExKnFv5JWynzaRBAaz121Z9QjY=;
 b=huTwCyO2ykFh/PVU011hDs1KWyyy4S40e+GOELtGPIrt/0166oY1x5L1Sr/WSg7ULC
 vHCFt8VCdxYUjwV1oFvgt+bE1/6arG1NCAocXg2bTbqGPErVtLX6KmmEGyLrjd/mMZT6
 dYc22b7GX6UEb8yL4wGhbNQV4koRbSHi0dA8WCraKMA0WWfP0maqROzY9EXFXMUHfytS
 LDoUPttiok7HMCLetxyIqwnUoX7h36lRBqtlMfqlNx2jIXSjnXXbsLnU7YLsvqCrzPC0
 DyHFjVkNLb+jWdUurPhtjVMCvioyCQkcKi1KvZlxhBi35R42PBh9ePI1rCGhMs7ZFXw3
 5bGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0vANRjGdNe9eui7H2m7wrR6ESGB4ZxvlQGZXbwOQx8p5s3155hozAe/tqecIRaajs6VxDEHux@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSAOnwcveGN183LIq1u2GF886AU/C8ByV9ViC5MHB+Y3GOkxiy
 /QjVcNP7YPKBTLfRhSF24GSdj7uxncL7dEROti3zN5gyu+K1SM2iq7xJW4PaiggBTFsL731BsYJ
 7PQHyF5bLCo5ZXMPiZqpoXRnRaVi9rB0=
X-Gm-Gg: ASbGncuCeYlTw135rrzqmEOjv6QdTGFe2K6SUXv8j3UUlggZl/+VTzmVCNapuP/ls8y
 H3uBpkVAQ4IET5uhUH5kMygFYXN49VMnAqXZ5yk6haHEFNnoG2CtR0Rvh1A5SI4jY8QDWxm+YzR
 mHNjPnrirNDBxm44tHUj32xAr0Z307gXCnN4om1f4NLibjWmxNdHO936JOIXXfl8Q3EERvCGdiK
 9klYZgr+7U2O9IaaI8=
X-Google-Smtp-Source: AGHT+IHVSj80KJwNH4YI+iqSzNiYfR/hb1veI0XP1yIqG04eqM6MQ5Qn77isDPYP1PCASf4K/gj2u5ROXPDRru7U58U=
X-Received: by 2002:a17:90b:1804:b0:31f:55a7:6504 with SMTP id
 98e67ed59e1d1-321162c71c9mr6290659a91.5.1754318584479; Mon, 04 Aug 2025
 07:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PUi_2+kDYX8R_eanNF4iYN79MdXJ_PLcQbZKi6e4S8tg@mail.gmail.com>
 <87F47F04-EBAC-48D6-AD0A-4BBE39DF43CE@xenosoft.de>
 <1115cce7-cfdc-4c5b-b017-69cd32425650@xenosoft.de>
 <6ba8d730-52f9-421f-8d8a-887545f0ceac@xenosoft.de>
 <2cc83897-427d-47f4-b6a3-8db9682972cd@xenosoft.de>
In-Reply-To: <2cc83897-427d-47f4-b6a3-8db9682972cd@xenosoft.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:42:53 -0400
X-Gm-Features: Ac12FXxHnqxgWPlbY24YJlBB8xzNoT512tqD7nkD3769V9O-pXqwC-E-XOiQyJg
Message-ID: <CADnq5_OpJdbc4YKtV-9+5JyeKyqd4+irhT6OtFq_K9KJF24VSQ@mail.gmail.com>
Subject: Re: radeon_fbdev_river_fbdev: failed to initialize framebuffer and
 setup emulaton
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: ville.syrjala@linux.intel.com, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "R.T.Dickinson" <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>, 
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Sun, Aug 3, 2025 at 11:28=E2=80=AFAM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
>
> Hello,
>
> I have the same issue on another machine either. Blank screen during the
> boot. The Radeon graphics framebuffer device doesn't work anymore.
>
> Here is the modifed code from the DRM updates (drm-next-2025-07-30):
>
> -
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/di=
ff/drivers/gpu/drm/radeon/radeon_fbdev.c?id=3D260f6f4fda93c8485c8037865c941=
b42b9cba5d2
> -
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/di=
ff/drivers/gpu/drm/radeon/radeon_drv.c?id=3D260f6f4fda93c8485c8037865c941b4=
2b9cba5d2

This change just bumps the driver version it shouldn't affect the fbdev.

> -
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/di=
ff/drivers/gpu/drm/radeon/radeon_display.c?id=3D260f6f4fda93c8485c8037865c9=
41b42b9cba5d2
> -
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/di=
ff/drivers/gpu/drm/radeon/evergreen_cs.c?id=3D260f6f4fda93c8485c8037865c941=
b42b9cba5d2

This only affects acceleration, it should not affect fbdev.

What chip are you using?  Can you attach your full dmesg output?  Can
you bisect?  This cultrit could be a core drm change.

Alex

>
> Do you have a patch for reverting these modifications? I would like to
> revert these modifications for testing.
>
> Thanks in advance,
> Christian
>
> On 03 August 2025 at 1:35 pm, Christian Zigotzky wrote:
> > Hello,
> >
> > Xorg doesn't work after the DRM updates drm-next-2025-07-30.
> >
> > Error messages:
> >
> > [dr:.radeon_fbdev_river_fbdev_proe] *ERROR* failed to initialize
> > framebuffer -22
> > radeon 0000:01:0.0: [drm] *ERRO* fbdev: Failedto setup emulaton (ret=3D=
-22)
> > brd module loadedm
> > lop: module loadd
> > mpt3ss version 52.10.00.00 loaded
> > nve nvme0: pci fuction 0002:04:0.0
> > fsl-sata ffe20000.sata: SataFSL Platform/CS Driver init
> > scs host0: sata_fs
> > ta1: SATA max DMA/133 irq 68 pm-pol 0
> > ;21;39mfsl-sat ffe221000.sata Sata FSL Platfrm/CSB Driver iit
> > ata1: Signatue Update detectd @ 0 msecs
> > scsihost1: sata_fsl[0m
> > ta2: SATA max UMA/133 irq 69 lm-pol 0
> > nvme nvm0: 4/0/0 defaul/read/poll queus
> > nvme0n1: p1 p p3 p4 p5 p6 p7[0m
> > drm:.radeon_fbdv_driver_fbdev_robe] *ERROR* filed to initialze
> > framebuffer 22
> > fsl_dpaa_mac fe4e6000.ethernt: of_get_mac_adress(/soc@ffe00000/
> > fman@40000/ethernet@e6000 failed
> > radeon 000:01:00.0: [dr] *ERROR* fbdev Failed to setu emulation (ret-22=
)
> > fsl_dpaa_ma ffe4e6000.ethenet: FMan MEMAC[0m
> > sl_dpaa_mac ffee6000.ethernet:Using random MA address: 0e
> >
> > Could you please check the latest DRM updates?
> >
> > Thanks,
> > Christian
> >
>
