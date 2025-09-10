Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DDECA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 13:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF1610E0CD;
	Wed, 10 Sep 2025 13:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q44jtvSP";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A9310E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 13:05:39 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b4f18ddd8c3so469667a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757509539; x=1758114339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbWCPu4qj+Ez5hY2m1l0xPd325FdnwRlGKMtDPLhEHU=;
 b=Q44jtvSPsBeY3sV5X+t3STTVq5GBfP92G7XdWWGqkQg5bx0U1QpCTc3yBSoRWB/23d
 O3Oh4mxn5zdD2H8yRZAZf9bETTwpL7v5G62d6V30InsRuh+eF+KTC99EhwOmjMvv/Tjg
 TxtuihBoHG7e3beJZd1KnbF+zUVzIZw6OibCRLHTCJKb1ZyrlJklB6XuhmFvtjJJXsIp
 pNguAqwk+G97b7AFfMUBUDhAJ/NEpLu5Wt/RrpIf04mDFWfGeiW3NzNjemBgC1msX8+W
 eQJTdILCFyCc4w2J3gkSo2E44ONN+ArAOwR/CAxyKkhdzhLjTueKF+LTGIHIBsoPIcu/
 AzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757509539; x=1758114339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QbWCPu4qj+Ez5hY2m1l0xPd325FdnwRlGKMtDPLhEHU=;
 b=L50dtSgGCFHtYNpRUgYOOUkpXJWdknFuTecL0OQgrpoIOaWTq/uIklXjx5hB1XdWUD
 Oq/+KJNX6UrpauU4NY6qIJEhUqmJ9POVGHKt5MKLlrQzrWAx13yK4n9MRQhv+svIZNuf
 cBb+8qsXgJy/SgZ6wiWKAdP9U0SNQAj5+aHC3A7Ifu9Enef2fS/P6oJ6BBWrVVlnvTpa
 HQeZR5J9fvqcDcAQQejtVn/zJNJEM+jZauYPZzk/39J8dYd8AVUEH/qcokrIXtOtUOrS
 sWJCnR+hdSQLgzf3wWewEa2oIvTUfr8ri5+hmXnH6BgR2KipN+W/MMy/Y9ZFMXy9rb45
 CvBA==
X-Gm-Message-State: AOJu0YyWf+8GX5QGeWyuDpGQW5zEhR1w7fw0weIkKTh/Sr2OTVhKnLbK
 vclfZaMsktnJFkbMtO/0RM+VHqVdw9LzonE1ogAtXTn0N4Q2r060uM3KzVyLJZ651USt5tRaccg
 qvuiYb+jHm4R3aZB1YJ92MRt/EfXVmQo=
X-Gm-Gg: ASbGncsEvYsaiZSBdT6DxBGd3AzAHTEB1pXBqhv7byJjDvUwOZ/Yzt7d0Pz3rWDVPex
 /xxt64LZ7EFvdDxMsAgqg086hoeSafnrIZ14JkyCV32nL4kjcNFy1gSO4DSqDVlJy+8ygUw7Y7V
 djf79HYjh+CiKtx7PBOvEPDtfoM1bmMn1PwZC6u3zWZwCIayHNeYV0ARHOXhXCy3qeE3rv9EySF
 g+w7ZQ=
X-Google-Smtp-Source: AGHT+IFTp8I2cSy1a+AbsI86Um9Jnies9hX6J+PM17kB5MukE2OV6aDQtSHvzHNUOEIYdGysIN9aEDRTnM00JLbZg80=
X-Received: by 2002:a17:902:e952:b0:252:3606:ce05 with SMTP id
 d9443c01a7336-2523606d0d3mr113010245ad.6.1757509538807; Wed, 10 Sep 2025
 06:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250910081633.2940220-1-lijo.lazar@amd.com>
In-Reply-To: <20250910081633.2940220-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Sep 2025 09:05:26 -0400
X-Gm-Features: Ac12FXwZIbCD-C4eKZJgSntu6Sh5-ELXiEJpSpANurKF_ZRjU5wOvaJxAoofhIQ
Message-ID: <CADnq5_Nte+52TCMygZvhkDuq7w0pZXuMCxKYu=PFDAtOLKv_Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Read memory vendor information
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Wed, Sep 10, 2025 at 4:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Read VRAM vendor information from scratch register for GC v9.4.3 and
> GC v9.5.0 SOCs.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 8404695eb13f..0d1dd587db5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1834,11 +1834,19 @@ static void gmc_v9_0_save_registers(struct amdgpu=
_device *adev)
>
>  static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
>  {
> +       static const u32 regBIF_BIOS_SCRATCH_4 =3D 0x50;
> +       u32 vram_info;
> +
>         adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
>         adev->gmc.vram_width =3D 128 * 64;
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0=
))
>                 adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
> +
> +       if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> +               vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);
> +               adev->gmc.vram_vendor =3D vram_info & 0xF;
> +       }
>  }
>
>  static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
> --
> 2.49.0
>
