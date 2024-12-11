Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567D1E77180
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 15:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11FB10E1C8;
	Wed, 11 Dec 2024 15:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NrbPUB4/";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CDA10E1C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 15:18:20 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2ee9b1a2116so776930a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733930300; x=1734535100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsdsMPWLUBRLXc06zYL/XnwU/J64Ct6Gz68b1tQ8zzg=;
 b=NrbPUB4/0aIrLmuTFqXOln+ZXrUM8nzGSluOqbqzKt9rSFPJhFDpe+r+vW2LdYRevo
 xBjvaF/rCnT5d4lrWHQ8c68f3rMFLoWhioXkpQku0bA2Iussbi6X1sKNb/cB+CwHvr50
 wI6pdSOZAkeaTMPzit5242oxjlAA1L7d0JZEoMRVXZYHkF9E2X0eUf2Q4r2qRqw6r5Ad
 C2cPag3P3/lsj7vUse5dLDgqWGLOSM5GYULcu8GNuY5Ci6kWp2C5NfpNzSEMrrFA4lFY
 ekUn4wySSjviQE5ELunb1Jtxxh+XRf4SzAAUIOOqDDeY2D4RsmjVQA83RckCGDh11zVV
 23zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930300; x=1734535100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsdsMPWLUBRLXc06zYL/XnwU/J64Ct6Gz68b1tQ8zzg=;
 b=n6xDeHZKENHTR4SWSY7BJaRh8wnOrK6aL8v45nX5Ty83opoXWqoa97tadIoXpc1nm7
 Oeaqrm3sKZUMR3p0volZHAAfXLeDpKx+6LFZm8doTdQ14leVE3wxRGbIOKZX9sA56RUC
 OulMnpq+8wtLiaBlwejq2EHbKqBYntBLySSRGIotrie5dXd9QDkXOztG2RhxnKDrKwcR
 gE39wTqVfFeAO0vRm+rLhihpjJWajE2PxqMzoPPcDI5kbednYktrDFiqzJSY2DBrQ8j+
 kDjI2RFOZrhxR8vPEiR+6IiEuSibjq2l7j5Bn6BTYpsfGHtFNqDeGuF86RGjif5G2OVY
 JRKQ==
X-Gm-Message-State: AOJu0Yx+lRiNEA9aMKPv2TVLagYzdaFFNpRt5WREUFBTTVEjNd7JDdw6
 Qf0O3G3gvHR+LdMFP46bOnPLddAjtDI2zAqI+lmBJXHk85yEzdcrC8RUthWpMKslzK2LmiQfPTI
 Zcv73THnd2PUebIBF0ZyMRUhGv5I=
X-Gm-Gg: ASbGncuydzaFoJU3iTCf7RJMsTRxM4/76QJWxQ2dQaaE3oa6BL/QPCHc+o/viotoplQ
 NTS9kmGw6/o5dMsbd9TjHYRh8E6VxCVgRbmY=
X-Google-Smtp-Source: AGHT+IGD46Uk4h7j1ZW3T3MgxIkmvZ/aStz53l1QpSuNz5lehnjBN+5lso5IWYQCSt2E/WadlhGrYpLwaiHUyVo5Cig=
X-Received: by 2002:a17:90b:1a92:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2f127fc732dmr1901185a91.3.1733930299354; Wed, 11 Dec 2024
 07:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20241211024414.7840-1-mario.limonciello@amd.com>
In-Reply-To: <20241211024414.7840-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2024 10:18:07 -0500
Message-ID: <CADnq5_OT1zfcs3t5OZy9Ohb-1nOoaHe3dzPC57pH-B8JKiTebQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Update strapping for NBIO 2.5.0
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 ionut_n2001@yahoo.com, Gabriel Marcano <gabemarcano@yahoo.com>
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

On Tue, Dec 10, 2024 at 9:45=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This helps to avoid a spurious PME event on hotplug to Azalia.
>
> Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Reported-by: ionut_n2001@yahoo.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D215884
> Tested-by: Gabriel Marcano <gabemarcano@yahoo.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/nbio_v7_0.c
> index b1b57dcc5a73..616b290c9381 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> @@ -271,8 +271,20 @@ const struct nbio_hdp_flush_reg nbio_v7_0_hdp_flush_=
reg =3D {
>         .ref_and_mask_sdma1 =3D GPU_HDP_FLUSH_DONE__SDMA1_MASK,
>  };
>
> +#define regRCC_DEV0_EPF6_STRAP4                                         =
                                0xd304
> +#define regRCC_DEV0_EPF6_STRAP4_BASE_IDX                                =
                                5
> +
>  static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
>  {
> +       uint32_t data;
> +
> +       switch (adev->ip_versions[NBIO_HWIP][0]) {
> +       case IP_VERSION(2, 5, 0):
> +               data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4) &=
 ~BIT(23);
> +               WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4, data);
> +               break;
> +       }
> +
>  }
>
>  #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
> --
> 2.34.1
>
