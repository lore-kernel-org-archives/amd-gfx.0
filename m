Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35FCCCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 21:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754B210E49A;
	Mon,  3 Nov 2025 21:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ID3+poKC";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC0E10E49A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 21:24:10 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7a9fb70f7a9so387168b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 13:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762205050; x=1762809850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Nht7Ga7UbT7S0pgUmdGlaMkNSqWf/hA/x/jfjEhJNY=;
 b=ID3+poKCg0wvdZiyLXQ7L1puUy+vHGux6WoVZtlzjc99qn5g760sp7cbgRaaF6Z7iu
 iv6sQqT/JInkkgx6chcAZSSsGtdLBN6hOKzORR4LSh84kV53uERMlFZcwIuvLoAqUfkO
 1DH1+6tfSp22NLi14D/vRJ3w7AzJ3W34DwZqC6rFNgsmO9L9tR3KTV97cV2NUUxRaU/6
 2UcHB4sj+xGbcgErbszez1pAGjNWGOCQ/fkvTRiKSIZJFpKmjYF+9RonkdL1O8Z4o6KC
 BgQELXoiMS1EDnsB7/6ESCrHu81cR8MC1jeQqCQMpr42lWS5wwpcYPoX1FQzH0+ssCcc
 Z5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762205050; x=1762809850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Nht7Ga7UbT7S0pgUmdGlaMkNSqWf/hA/x/jfjEhJNY=;
 b=rCsQx/vFm9aNsWQ9qAsOSyAtmNv4GCqPKHwVYx1Vj1rqeX+mbtJse6hs0JHhZLEGat
 +GDiytdsb9Zmdl5zS9/mgebGJ5n0zwHJobGq+G4BblsrRzbmo71z3Dt9mIFeIpPuIVaJ
 K6rCN54qbLqB4962prdBH8lhM/Pxz9b/de9qwgDS6hh0M7oP9ZDjjc5D/KMc9mbthrGv
 ayfeBJYetOi4biPisuGdW97o1quKmrigIKxsS/ylcfjoDU/4DtuB9ja+cL+iF5QD/coC
 WXJTDkwvoDyFlz0dX4lRI1DF+//9Lw607iwBCr5r1PfmRh/FqcoRI2IdERb9uRJ3sHs1
 Xw0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtkkkMu3P1Nzk+HvGJAdGPZj+zoieTtY0tHqeG8TQnt7B9nosmykVUmaszh8own6TBFfRb4SRW@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxs/ZYTYlb6jwwiDTdpzU7XaZEsdQUaWepmGKySX5BIrkLF9VO/
 rs6iL57rKK5QDyrl/xzWHcinvSjJodBHaJo4GsBiojTMZ1J158YBz9InT9cKaWWVTBx7cvMYUq/
 SN2Uhz+sVqq0vqrZw2mIUTpncyVe/Vbw=
X-Gm-Gg: ASbGncu2SkFUcfbP1fzij+VYL6r7ZCOKMHniaXZ6S2ZFL7XUMMccOmzywpk3XdC492e
 YNeioRu9FKkkwKRLkeCrQjkqxKLVUZChBaiQvm2RtSOko3/XELdeDAzNIamFW3NcPicxTyz0H4W
 gXrEyu9RoQ15pY+F/BMyTuV7qKqwHuoyErRAhFWekYE2QRUCOMrw1DhJNH7kUpTeGEs3n5Hziqv
 bF3h7FebD+R84qLnenRHP2lNQ2oLqdQWbwvw5k85zyBpkLGByxp6bcMNG4M
X-Google-Smtp-Source: AGHT+IFY8+2qFA1oiKosDS/rAbxdW43gmN+fJej+sar+4puyVhhm5/G83MSiXSxR/0mkFd6qHx0UbRoOd1MS3ZSWVwo=
X-Received: by 2002:a17:902:d481:b0:295:558d:a464 with SMTP id
 d9443c01a7336-295558da62emr77743435ad.7.1762205050142; Mon, 03 Nov 2025
 13:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20251103-vram-carveout-tuning-for-upstream-v1-0-17e2a72639c5@amd.com>
 <20251103-vram-carveout-tuning-for-upstream-v1-1-17e2a72639c5@amd.com>
In-Reply-To: <20251103-vram-carveout-tuning-for-upstream-v1-1-17e2a72639c5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 16:23:58 -0500
X-Gm-Features: AWmQ_blvBwcjDFk_MBDYqriTXRTTpOTzumlZhYcWa0hA4X0Y7q8ncHOD5PHapVI
Message-ID: <CADnq5_P66LndOd5aJs=BN8btde1XNumCRZL2TZ1yfFfUwyGJOA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: parse UMA size-getting/setting bits in
 ATCS mask
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, anson.tsao@amd.com, superm1@kernel.org
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

On Mon, Nov 3, 2025 at 3:01=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.c=
om> wrote:
>
> The capabilities of getting and setting VRAM carveout size are exposed
> in the ATCS mask. Parse and store these capabilities for future use.
>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>

This patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++++
>  drivers/gpu/drm/amd/include/amd_acpi.h   | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 6c62e27b9800..0743fd8620e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -116,7 +116,9 @@ struct amdgpu_atcs_functions {
>         bool pcie_perf_req;
>         bool pcie_dev_rdy;
>         bool pcie_bus_width;
> +       bool get_uma_size;
>         bool power_shift_control;
> +       bool set_uma_allocation_size;
>  };
>
>  struct amdgpu_atcs {
> @@ -588,7 +590,9 @@ static void amdgpu_atcs_parse_functions(struct amdgpu=
_atcs_functions *f, u32 mas
>         f->pcie_perf_req =3D mask & ATCS_PCIE_PERFORMANCE_REQUEST_SUPPORT=
ED;
>         f->pcie_dev_rdy =3D mask & ATCS_PCIE_DEVICE_READY_NOTIFICATION_SU=
PPORTED;
>         f->pcie_bus_width =3D mask & ATCS_SET_PCIE_BUS_WIDTH_SUPPORTED;
> +       f->get_uma_size =3D mask & ACPI_ATCS_GET_UMA_SIZE_SUPPORTED;
>         f->power_shift_control =3D mask & ATCS_SET_POWER_SHIFT_CONTROL_SU=
PPORTED;
> +       f->set_uma_allocation_size =3D mask & ACPI_ATCS_SET_UMA_ALLOCATIO=
N_SIZE_SUPPORTED;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h b/drivers/gpu/drm/amd=
/include/amd_acpi.h
> index 06badbf0c5b9..e582339e8e8e 100644
> --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> @@ -427,7 +427,9 @@ struct atcs_pwr_shift_input {
>  #       define ATCS_PCIE_PERFORMANCE_REQUEST_SUPPORTED             (1 <<=
 1)
>  #       define ATCS_PCIE_DEVICE_READY_NOTIFICATION_SUPPORTED       (1 <<=
 2)
>  #       define ATCS_SET_PCIE_BUS_WIDTH_SUPPORTED                   (1 <<=
 3)
> -#       define ATCS_SET_POWER_SHIFT_CONTROL_SUPPORTED             (1 << =
7)
> +#       define ACPI_ATCS_GET_UMA_SIZE_SUPPORTED                    (1 <<=
 5)
> +#       define ATCS_SET_POWER_SHIFT_CONTROL_SUPPORTED              (1 <<=
 7)
> +#       define ACPI_ATCS_SET_UMA_ALLOCATION_SIZE_SUPPORTED         (1 <<=
 9)
>  #define ATCS_FUNCTION_GET_EXTERNAL_STATE                           0x1
>  /* ARG0: ATCS_FUNCTION_GET_EXTERNAL_STATE
>   * ARG1: none
>
> --
> 2.43.0
>
