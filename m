Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1C4C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 18:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255AF10E164;
	Mon, 24 Mar 2025 18:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="McnhuZOA";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6ACC10E164
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 18:23:31 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ff53b26af2so1347335a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742840610; x=1743445410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpBs/YBZn93IJCAepiN+++5hOYfEpkEk8/pIqiMC1Yc=;
 b=McnhuZOA6dniYJgWthULJV8T3Wgzx7xxw1Ili9dv2OCn3TLb8Bp5aF2wxgvXUrYamK
 +TUDsPfsrighIvibr5ayaHG4FtvrrdqncvAB0g9PYOdvTRJDQbbW7eEvdOLT7S1RUACU
 LOMdCaSJb3YVnoAL4R7jxeJnsQxtIJjDtXRcZ7odT9F7UcUSC3NvVoWtFNuUUx7qXPka
 BHpintgDMZXP7xB7iX1xFdDGhy8PXvvjSXpHFj8pBuf0psMdpI/wMfvEv1wswk+Xwz04
 rL0Az6v9RzwG1Gz/WrZgkFzlaI2sN51CLD00jUpQdrn+bQ9OXbhgEgBMu466useGV0Hv
 0XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840610; x=1743445410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpBs/YBZn93IJCAepiN+++5hOYfEpkEk8/pIqiMC1Yc=;
 b=LdmfrcLFn7pbw6qt+OT8c48ZBbGkuhOhsHPOwXfz2rYKbTXrQHw45ncHWj+BKxWubA
 u9Aj5l8rRbnFGLnYT/hJlJkYn3CCEZ1nWPBAB83XpCSL0YxuFZkHSrRQ/GsbQq82suu4
 Tl1UYLk1kOtYBpgspwRaCbH0HAVau5qUZk3oMuF7RTaCYo1RrApEOx2qf5N8RNtlc9x2
 XG/NMkhSh4uRdqXqLXKdi+lQNjvhRlYJqyKti+q0RH54yAbR4Z5CzmPNG3q9vPdyKg31
 s058TzJvgvacPuUDO7onb6YyLpx0z+AUx7xAqeRKVyR8OEGXJNyJsB5JDWqVauES0k8j
 dZ5w==
X-Gm-Message-State: AOJu0YwRkyZHEBCrQjXBGGj5UoI8QuWirSB+QcWDgp7KIb0ce8ccV5Y8
 9jOWCMIyysntkjMdRhAB5x53DFkAJ12N1KEZa99pwzoNmueQdw2msPybWUDZvAMN/vBCtpD1UXg
 hE7kqmfTzSv3Ljq+oDAGNLmxeGuJGFg==
X-Gm-Gg: ASbGnct8omQCZ1Fl0Sn/T+dHDueLiO3uTvJtTCI/l3dPqE/ywzlgUmm+aBYiNEKrtBK
 BZJPONNSEjqe8DKzC7ZRRtYK1vBVmdqDyq9FEw1V1B7XnwGPousMqGxcYWx+J7DS/PMawTiEe2I
 j2fvELivB8LISqynsCBK4/c7nH0g==
X-Google-Smtp-Source: AGHT+IE3uGCi8/lDQx4ReTnsStZqEzdpunzYvpvwUNj2OSISFNk2sIrptYBc+LoCYs46H0K7jiMEAiIMhK0jHL5K90g=
X-Received: by 2002:a17:90b:3b51:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-3030ff15738mr8456813a91.7.1742840610392; Mon, 24 Mar 2025
 11:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
 <20250322183746.86002-2-alexandre.f.demers@gmail.com>
In-Reply-To: <20250322183746.86002-2-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 14:23:18 -0400
X-Gm-Features: AQ5f1JpDz8iFJFS7ylmBv4HFOU8K7WEb2BqntmLTimYGm87ssF0YpzO35aTiTiw
Message-ID: <CADnq5_MzcVSzYYo2nEx+OLNw39ZkMaM9pXKO3ZnAJ2uV+rr+2A@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: use gmc_v7_0_is_idle() since it is
 available under GMC7
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

Applied 1-4 with some minor fixes.

Alex

On Sat, Mar 22, 2025 at 3:03=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> gmc_v7_0_is_idle() does exactly what we need, so use it.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index b6016f11956e..1a8df3caedb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1156,17 +1156,10 @@ static bool gmc_v7_0_is_idle(void *handle)
>  static int gmc_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  {
>         unsigned int i;
> -       u32 tmp;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               /* read MC_STATUS */
> -               tmp =3D RREG32(mmSRBM_STATUS) & (SRBM_STATUS__MCB_BUSY_MA=
SK |
> -                                              SRBM_STATUS__MCB_NON_DISPL=
AY_BUSY_MASK |
> -                                              SRBM_STATUS__MCC_BUSY_MASK=
 |
> -                                              SRBM_STATUS__MCD_BUSY_MASK=
 |
> -                                              SRBM_STATUS__VMC_BUSY_MASK=
);
> -               if (!tmp)
> +               if (gmc_v7_0_is_idle(adev))
>                         return 0;
>                 udelay(1);
>         }
> --
> 2.49.0
>
