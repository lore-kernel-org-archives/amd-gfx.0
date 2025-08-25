Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0AACA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3DC10E4E4;
	Mon, 25 Aug 2025 14:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jtu7xSvB";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5570210E4E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:58:12 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-24617d3f077so6272325ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756133892; x=1756738692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cQj0wS9QM3FgkY0/Mcdhhxt3BYy1BKOOpyv5z8WyeM=;
 b=jtu7xSvBHSRBdm4fuwj4bO9r5on+LCG5pDf3lHGjSoFwv14OEDdsYBLH1n//KO5cAS
 ffr4V85pwlVCP/z5BATJYOJcCS5b7DcoMoJweu8YF52SwIgrOBSIiN3bUWM/OH4mXoBO
 vZkCHPSl5fwI8xjHJXoj6z7RTrKPFqkpmH537XSQxCj3VMjGFVwq10nehI9lX+FVYkaM
 l5IXd/pQJgmBcqo/Rcfy2aphrluN2ozwjSE/JL+C3fX6sZXcSj3hWizpbRg5shaU+fJf
 kNJwhSNijEoSaaYHcb0LtbERpHiMaJzAPBflq3smXGFm9yEFceZ99lhQNgG+HI1MfMwh
 AvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756133892; x=1756738692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cQj0wS9QM3FgkY0/Mcdhhxt3BYy1BKOOpyv5z8WyeM=;
 b=JcKzlf0GnAxUbXB1jVkSVeIHpGVin12K/QHEFdAVZsIhigumMg0MrBwgTHxGAlXQGH
 vJ7OcaMAUivImTYQmKlA1FqnYZK0Yob+SsGBip1L3StZDBbXFiDT5LLkUTuIZX9i2LQs
 ZyjP4Lx+knruUAEZAtmkcBIArWrUgJAL2P06//8dm2Y2GCrmXdgT8i0XdP3g+9vfui8Z
 RAP9vK8AD8o/2e0C4mTFgLJINvPootOnVhUmaelfkOxlJBiiPAJPrUctMdAGE0WOjBZu
 ig3hPZ0adPKBsx1sWWomGrddSSJ16v+qhnhx3F8TL5MpOX7+L6MZKd4hbzbiuwfmxlEC
 lrRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiakbMQFt7EKdU+BLhOAVeVaHzA0HSYPjK8pmxfdJlaiNFyzKluMraZDA8Hw9hg5V/xCCXdKuC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcEzYcLFMlthF6+baNdNPfSNLAX11YY/4LzdYEcqNkcp6yQosc
 Pufepw46LcTsGbEE2cAsEQ1zAYP+R8vd1Oid7yHSAJqdQ9MXcIMjtN+hflpmgiFOQgjvJET/trJ
 W2ZLt25t9zmL/2TAoYXUQVjPinMzH5fNLiMBX
X-Gm-Gg: ASbGncvtRUPMEgLorFN6Y6UXc2kAcGDXEtXLgECxdeqA4aBuT/SNoIWYjFvRFfWZgmG
 7XP48XrIKLG9ezYRcRfcOA8TlGc4TDvdUJzX9A5dLXHzIgOdJ8ucT9VyzR5BqPZgWHgc1kHCJoW
 IwL57hi7Z11cBaq7WV95RsaXYsjysTfowtwWh4K9rgatfs7egv36KLk/pgvKqrob8+FUF51jGAG
 9JrujY=
X-Google-Smtp-Source: AGHT+IFF8yMuR/wPjmi2w7KvNeoyjequQ02JcLIgf/s8tbmrrc5WpJSCjX6vL5NgYh2YVO/0c7je8MGEUhuvBr1uuME=
X-Received: by 2002:a17:902:ecd0:b0:246:d736:cc2c with SMTP id
 d9443c01a7336-246d736d20cmr25150795ad.9.1756133891697; Mon, 25 Aug 2025
 07:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-8-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250823072016.1272328-8-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 10:57:59 -0400
X-Gm-Features: Ac12FXxIxwu7lq-0IsgbYDerQT16G4YTORzDah5RSOUY8QaTBTQbZtio_dDXO58
Message-ID: <CADnq5_PCZ2M-Q9bEdoAqk0nUEPdofLS43twxjP+wt4roPujBJw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton BO
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

On Sat, Aug 23, 2025 at 3:20=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Add amdgpu_ttm_mmio_remap_bo_init()/fini() to manage the kernel-owned
> one-page(4K) MMIO_REMAP BO. The allocator runs during TTM init when the
> hardware exposes a remap base (adev->rmmio_base) and the host
> PAGE_SIZE is <=3D AMDGPU_GPU_PAGE_SIZE (4K).
>
> The helper is idempotent (returns 0 if already allocated) and only
> returns an error when the actual allocation fails.
>
> This keeps MMIO_REMAP lifetime handling localized and prepares for the
> subsequent patch that exposes a userspace handle.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 69 +++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 58b6ab1be4c1..c76c41a312b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1853,6 +1853,68 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_de=
vice *adev)
>         adev->mman.ttm_pools =3D NULL;
>  }
>
> +/**
> + * amdgpu_ttm_mmio_remap_bo_init - allocate the singleton 4K MMIO_REMAP =
BO
> + * @adev: amdgpu device
> + *
> + * Allocates the kernel-owned one-page buffer in AMDGPU_GEM_DOMAIN_MMIO_=
REMAP
> + * when the hardware exposes a remap base (adev->rmmio_remap.base) and t=
he host
> + * PAGE_SIZE is <=3D AMDGPU_GPU_PAGE_SIZE (4K). If either condition is n=
ot met, the
> + * function returns 0 and leaves adev->rmmio_remap.bo as NULL.
> + *
> + * If the BO is already allocated, the function does nothing and returns=
 0.
> + * Only errors during actual allocation (e.g., amdgpu_bo_create_kernel()=
) are
> + * propagated as negative returns.
> + *
> + * Return:
> + *  * 0 on success or intentional skip (feature not present/unsupported)
> + *  * negative errno on allocation failure
> + */
> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
> +{
> +       int r;
> +
> +       if (!adev->rmmio_base)

Check for adev->rmmio_remap.bus_addr here.

> +               return 0;
> +
> +       /* Hardware remap page is fixed 4K; skip on larger PAGE_SIZE. */
> +       if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE) {
> +               dev_warn(adev->dev, "MMIO_REMAP disabled: PAGE_SIZE=3D%lu=
 > 4K\n", PAGE_SIZE);

No need to warn here.

> +               return 0;
> +       }
> +
> +       if (adev->rmmio_remap.bo)
> +               return 0;

Why is this here?

> +
> +       /* Create exactly ONE kernel-owned BO in the MMIO_REMAP domain */
> +       r =3D amdgpu_bo_create_kernel(adev,
> +                                   AMDGPU_GPU_PAGE_SIZE, AMDGPU_GPU_PAGE=
_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_MMIO_REMAP,
> +                                   &adev->rmmio_remap.bo,
> +                                   NULL, NULL);
> +       if (r) {
> +               dev_err(adev->dev, "MMIO_REMAP: BO create failed (%d)\n",=
 r);
> +               return r;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * amdgpu_ttm_mmio_remap_bo_fini - free the singleton MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
> + * amdgpu_ttm_mmio_remap_bo_init().
> + */
> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +{
> +       if (adev->rmmio_remap.bo) {
> +               amdgpu_bo_free_kernel(&adev->rmmio_remap.bo, NULL, NULL);
> +               adev->rmmio_remap.bo =3D NULL;
> +       }
> +}
> +
>  /*
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -2027,6 +2089,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>         }
>
> +       /* Allocate the singleton MMIO_REMAP BO (4K) if supported */
> +       r =3D amdgpu_ttm_mmio_remap_bo_init(adev);
> +       if (r)
> +               return r;
> +
>         /* Initialize preemptible memory pool */
>         r =3D amdgpu_preempt_mgr_init(adev);
>         if (r) {
> @@ -2090,6 +2157,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>                                         &adev->mman.sdma_access_ptr);
>
> +       /* Drop the singleton MMIO_REMAP BO (if allocated) */
> +       amdgpu_ttm_mmio_remap_bo_fini(adev);
>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>         amdgpu_ttm_drv_reserve_vram_fini(adev);
>
> --
> 2.34.1
>
