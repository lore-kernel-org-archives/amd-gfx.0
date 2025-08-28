Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D859ECA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F53310EA2E;
	Thu, 28 Aug 2025 15:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ne+8lsZG";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07A910EA2E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:31:37 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2489b7f3d5fso1878855ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756395097; x=1756999897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ECy4pojiqQxn0u9b573JeaTjXRLnsav75fp32S/2tM=;
 b=ne+8lsZGlhSqyrClEbzVM7s+1WslbyXUJcYR89EpZXzDSpA3/4+U5D6LLAHb707Rjb
 37lrgbjJwHragvW6ysqLJbRwZSXvMQ9WT8XRNPxHz225cMfLSQPhWM5ObGgpANleev9L
 e/oxd0EiIvZNVL2C35TcadUh4H8R81AWQPa6UQJAtSyuhtRPqOynjyTeFYQnH+Joq9Tw
 b8npHqzA7pc6wwWeETQhzFB/Tdaq/EbJurLMEJAF7UosoFXAWWUu+lzxaI1uVck07z/V
 meU9S3y8mtDBrhBR6FKbMkh3+dp7DhOdIOHfgyOPgzYMO+pl3BH+uwnFVbjnPWkfqpCX
 YYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756395097; x=1756999897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ECy4pojiqQxn0u9b573JeaTjXRLnsav75fp32S/2tM=;
 b=f5Ihot0q4hOG+L7erVF0UieNXH9FoCEUD9ONbJbp+B83MP2JaLMTiRubZcPs/D+EzM
 kmLVl7D7H3XDvD6enbOHJNwbreJQ5xdf6ITRK6KET1etCTAMaGj5CROtXDAYZQ9Sr+xe
 R51Fno2PhBs9evvBooQnJvnJrdumKH0SpsUntHjSCc4tMKZ9DCPPx24riqm4L4GQHdz6
 PP3fTxKkYiZiL1FVXZBJF5S/S7mOPm5OMiDnFlM/dobZlbToPIgEpYNpRbfCi4r7RMlh
 O3KP+Lhcc++5fMbhZ0AXhwMZ7JdAVbegIkmN9kXGy6cd4kX7DxHQjfboi1pw6E04769t
 PCUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjv/nFOgCwUDjXvO4ZsSpKrJT/NuX3LtzFo84E3nvaCkbMZFgWINJ8uDUu9uLc1iXtQp8Xa3UY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzlw9pfRUeSmRczHKBGhvTY/B7JQcJRGREEYNBrPX5VY0ip2AJp
 q1sPT3+Ui/5TLTMf5C4Nm3+hJCAOyzWtUISaT3NicZ0le0Y+VO5Z4zIklR48LGmWe206KYobBhn
 taQL5Slyo7t0Yc54afuXnkCdFPyBKUwAm5BEz
X-Gm-Gg: ASbGncuxiF/ckBrYHqaVJP/BjuCZ2gRLUPMbt7oOa0A+5WkAAIcNAwsVS1zum17adDx
 6Knif88F7T464E3jlgV9tTqzhURw2I6ejeXkrQuMlIBVNl0HnmYFDHBjC9yTrFRwAmGNanpnugR
 IU+4SADLfBdlaNqCtCdAA0So16TLynTs03A58PMVRhc6ByZ2QMX/GeUZX12COQBHhQ+6FShZgvN
 J4M2BL1mWF1Xekm9Q==
X-Google-Smtp-Source: AGHT+IEfgzShEwk8QX6j4ZD8YShBVT2brMbu1+4xwhDsuFMWEeW2qrS57wSEM+iarimbr3IEozJWhe4IWTNR9mL4YBU=
X-Received: by 2002:a17:903:22c8:b0:246:a93c:aa0d with SMTP id
 d9443c01a7336-246a93cacc7mr136863255ad.11.1756395097027; Thu, 28 Aug 2025
 08:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
 <20250828071335.3948819-8-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828071335.3948819-8-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:31:25 -0400
X-Gm-Features: Ac12FXwDe-iMBWObP4S079tN8H8tKz7efBw_Oy91zqba3N1J9sJEPyg7Gp-GWco
Message-ID: <CADnq5_NCnTXVqscj_ZBvBboCmrjWpEk+joGZfRMPA+4hDeEE-Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP
 Heap
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Aug 28, 2025 at 5:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Add a one-page TTM range manager for AMDGPU_PL_MMIO_REMAP via
> amdgpu_ttm_init_on_chip(). This only registers the placement with TTM;
> no BO is allocated in this patch.
>
> The singleton 4K remap BO is created and freed in the following patch.
>
> This split follows to separate heap bring-up from BO allocation.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 9211d250fcfb..7822d8969c9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2020,6 +2020,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>         }
>
> +       /* Initialize MMIO-remap pool (single page 4K) */
> +       r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
> +       if (r) {
> +               dev_err(adev->dev, "Failed initializing MMIO-remap heap.\=
n");
> +               return r;
> +       }
> +
>         /* Initialize preemptible memory pool */
>         r =3D amdgpu_preempt_mgr_init(adev);
>         if (r) {
> @@ -2082,6 +2089,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         }
>         amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>                                         &adev->mman.sdma_access_ptr);
> +
>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>         amdgpu_ttm_drv_reserve_vram_fini(adev);
>
> @@ -2103,6 +2111,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
>         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
> +       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
>         ttm_device_fini(&adev->mman.bdev);
>         adev->mman.initialized =3D false;
>         dev_info(adev->dev, "amdgpu: ttm finalized\n");
> --
> 2.34.1
>
