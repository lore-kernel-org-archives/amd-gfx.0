Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EDFD37491
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 14:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4988110E036;
	Thu, 17 Oct 2024 14:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hCuf8mMO";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7E010E036
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 14:05:35 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso123987a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729173935; x=1729778735; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZACUlvsKmqoNyR9Ki+QrxtUFwl0TKT/vsH6HuJkNEq4=;
 b=hCuf8mMOn1FyAbb4K5euMJe0ye2J/fh7bUWRH0GFMLcHSisVM5H+nOeMuBKCZSawiB
 sfQ8DdyDbOvp0rNZmvtPnKQ3JcOPs5JvFlOCV5pPhmm6rdhq2DkMaBX+kFEJKdozA21S
 MpGR4+1ERY05LqaytkFwvMk7Hcr3+hr+fqpw587dY6LSFzMrzx9PDzwoU/L6RzU4MVvn
 RIYmpz7Y3CB9+Mp79xWQM/dKxjx2RfF8sX0Cch7JrXEERZo+DPtu+HRjZncQry3+RTS8
 Zyes8ka939SSRYsDblIZ+IO0xkXX0JFX0PZ1sGgX9nkuTebx9etHvXEooUSoR15np6ao
 xUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729173935; x=1729778735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZACUlvsKmqoNyR9Ki+QrxtUFwl0TKT/vsH6HuJkNEq4=;
 b=K4Agj/hQit7vGF2h1Vr9OYvUNoieyXwMCdF0JhlcoTq2Y5CCW4i72q9x64TfMWKwMS
 HMsjKBzvD2JSB/0jjCNkVBzKbQP9HDHbx9EcfJmnRiB8zUjX7pcbp2UqqqNutMO1RDaU
 wFjbv789IeM6GB/2738KjfYMU7682t59MBQmN7jC/B1SNGy9WAWu3sWPILDOnpx/9tFv
 nbVYX2Iy/4trNnwnJIANLT/Pthog1QfuyBc3tqYC6077vaSE2BY32JtUN18PkCGtsKrS
 FsSuQz7+ad9Kr/v7KaNDzabNBJmbwMPUxi3g2pXShr4pqEi+X+YKbnod5DW2DLHATCSY
 hgtw==
X-Gm-Message-State: AOJu0Yzd8DOx6OW//1sv2o8M64hVJHpJJtFz+yv3yiB0LNvKbLl5M2FN
 fqhRrSDEQDgmyxpR04DDFB5MVDAf5smlvfhH40xJeV4hZO1KWnNccabDhGOxWffkDSqCSXbl2FT
 c3sp4hd7jikZTfLp0AKulDJxLoWtMsA==
X-Google-Smtp-Source: AGHT+IFPZUuG2CXzZc2rGMrPl69y44VG85esgASS4297WC6Zp7HnBZMAMe2fV5UrVUKczWp38Wc2bVZjQPvowbPfmQw=
X-Received: by 2002:a17:90b:4a8c:b0:2e2:a70a:f107 with SMTP id
 98e67ed59e1d1-2e3dc12a4f8mr1778350a91.1.1729173935215; Thu, 17 Oct 2024
 07:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241017072316.1888172-1-Prike.Liang@amd.com>
In-Reply-To: <20241017072316.1888172-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Oct 2024 10:05:22 -0400
Message-ID: <CADnq5_Mq10Xykyim_P82jb7DEd7JfzD7RADCW1zFKK_ihmFzow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Dereference the ATCS ACPI buffer
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Thu, Oct 17, 2024 at 3:23=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Need to dereference the atcs acpi buffer after
> the method is executed, otherwise it will result in
> a memory leak.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 1f5a296f5ed2..cce85389427f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -800,6 +800,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_dev=
ice *adev,
>                 return -EIO;
>         }
>
> +       kfree(info);
>         return 0;
>  }
>
> --
> 2.34.1
>
