Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5329BC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 14:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7F410E341;
	Mon, 22 May 2023 14:48:00 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B3D10E341
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 14:47:57 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5523bd97c64so2281530eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684766876; x=1687358876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7rtNmiHsyyXrQ3QkojnE5hWKROssSE9mW2ZnkoeMuE=;
 b=WBm9hyjjKB8M9WV/wpp1nc2rTOg/84OGMNdyT9wjTXZ9lQJ8Qr/UvducLRuDuRQ59B
 GSjyeKN5XdS6PXzB7Rqeb3XgHP7GfjV28xojTENmaEwGVSlVLvhh+1Nrijg8pOJzBe8X
 1WFwJGa6unDDzhqFAd0fuaTUTkDZloFvOv2Y0fzebD4vjQw/DleTCsoI368+XRtoUBy7
 YOaJf+KoHCI4fFEctaptwBjR/HHDeg547ftHAk/TRrYfovECEE4H53677t0BIe5ezrgm
 SkDhQoOOmeWbb4vYLArk4W03NKWvfpNGLx8zU4BSB8zD2J2xZemOObG/gNgNddAEEqpP
 L16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684766876; x=1687358876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7rtNmiHsyyXrQ3QkojnE5hWKROssSE9mW2ZnkoeMuE=;
 b=lIDxzn1i/lFJJhkmRf1ubIsOX0gMpLfe4cczFhVWPz3l1ihHOMUgVHpoMDT3t7bYLQ
 w8kSupoGeHGeZqe47uD9KGwLNK+VKSCOa6dXtBCMT/mb4HfMP8SBTRdcpbDBdYui1jw9
 cHOcmnY3vsBSnYshwu8HoDeein2yYsFPF3ZbhEuzgkDRrkCwQF85ZcJHerJhJVkSgp+b
 Z+baCOok5N9UWGbB4RPuWC6tpn1W7pnmDXsZAKpq1QYUDKAr/ccbvTJTg/N2pG/F1AMr
 a+fIRkhZibQxEk1+UjF0Mcj+H5f9kAx02aPXA8tc8ChaoGBMSd7+1vguszmdEF+FjsoX
 mtxQ==
X-Gm-Message-State: AC+VfDzB72GfFTOAEMD4GA9GWcKRb5r1kq3o9/Qxez3Sj9kMdkce3UOj
 YpfdBo86nFITTaVPI7t9zx4pOGNUMTECzQ3imak=
X-Google-Smtp-Source: ACHHUZ48BKu+o/65a+EUNZV7ZpRJPh/A/S1uZ0dSL72oNkboIt0FpPv5mhTLYP/XppoloT+mxFYRXFH9xL/x+AUasxI=
X-Received: by 2002:aca:de57:0:b0:395:fa04:f39 with SMTP id
 v84-20020acade57000000b00395fa040f39mr6778130oig.20.1684766876535; Mon, 22
 May 2023 07:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230518070215.3556653-1-guchun.chen@amd.com>
 <20230518070215.3556653-2-guchun.chen@amd.com>
In-Reply-To: <20230518070215.3556653-2-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 May 2023 10:47:45 -0400
Message-ID: <CADnq5_Mp4k+0rjsAP2Fe75MFkf8HzThrHsqdHxWpqBVStSot1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/sdma: set sched.ready status after ring/IB
 test in sdma
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: alexander.deucher@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 18, 2023 at 3:04=E2=80=AFAM Guchun Chen <guchun.chen@amd.com> w=
rote:
>
> sched.ready is nothing with ring initialization, it needs to set
> to be true after ring/IB test in amdgpu_ring_test_helper to tell
> the ring is ready for submission.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 2 --
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 2 --
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 2 --
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ----
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ----
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 2 --
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 6 +-----
>  drivers/gpu/drm/amd/amdgpu/si_dma.c      | 2 --
>  9 files changed, 3 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/=
amdgpu/cik_sdma.c
> index 67d16236b216..52598fbc9b39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -489,8 +489,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *=
adev)
>  #endif
>                 /* enable DMA IBs */
>                 WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
> -
> -               ring->sched.ready =3D true;
>         }
>
>         cik_sdma_enable(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index fd2a7b66ac56..51afc92994a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -466,8 +466,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device =
*adev)
>  #endif
>                 /* enable DMA IBs */
>                 WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
> -
> -               ring->sched.ready =3D true;
>         }
>
>         sdma_v2_4_enable(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index e572389089d2..344202870aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -734,8 +734,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device =
*adev)
>  #endif
>                 /* enable DMA IBs */
>                 WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
> -
> -               ring->sched.ready =3D true;
>         }
>
>         /* unhalt the MEs */
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 9295ac7edd56..e3581852ed9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1114,8 +1114,6 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_devi=
ce *adev, unsigned int i)
>  #endif
>         /* enable DMA IBs */
>         WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);
> -
> -       ring->sched.ready =3D true;
>  }
>
>  /**
> @@ -1202,8 +1200,6 @@ static void sdma_v4_0_page_resume(struct amdgpu_dev=
ice *adev, unsigned int i)
>  #endif
>         /* enable DMA IBs */
>         WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
> -
> -       ring->sched.ready =3D true;
>  }
>
>  static void
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 64dcaa2670dd..c3517d9fc38c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -659,8 +659,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_devi=
ce *adev, unsigned int i)
>  #endif
>         /* enable DMA IBs */
>         WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
> -
> -       ring->sched.ready =3D true;
>  }
>
>  /**
> @@ -750,8 +748,6 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_dev=
ice *adev, unsigned int i)
>  #endif
>         /* enable DMA IBs */
>         WREG32_SDMA(i, regSDMA_PAGE_IB_CNTL, ib_cntl);
> -
> -       ring->sched.ready =3D true;
>  }
>
>  static void sdma_v4_4_2_init_pg(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 92e1299be021..e2fe539ff3ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -819,8 +819,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device =
*adev)
>                 /* enable DMA IBs */
>                 WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_IB_CNTL), ib_cntl);
>
> -               ring->sched.ready =3D true;
> -
>                 if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn=
't need below to lines */
>                         sdma_v5_0_ctx_switch_enable(adev, true);
>                         sdma_v5_0_enable(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index ca7e8757d78e..23667605c372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -617,8 +617,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device =
*adev)
>                 /* enable DMA IBs */
>                 WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_IB_CNTL), ib_cntl);
>
> -               ring->sched.ready =3D true;
> -
>                 if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn=
't need below to lines */
>                         sdma_v5_2_ctx_switch_enable(adev, true);
>                         sdma_v5_2_enable(adev, true);
> @@ -630,6 +628,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device =
*adev)
>                         return r;
>                 }
>
> +               ring->sched.ready =3D true;
> +
>                 if (adev->mman.buffer_funcs_ring =3D=3D ring)
>                         amdgpu_ttm_set_buffer_funcs_status(adev, true);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 3d9a80511a45..280a878cad68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -585,16 +585,12 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_devic=
e *adev)
>                 /* enable DMA IBs */
>                 WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_IB_CNTL), ib_cntl);
>
> -               ring->sched.ready =3D true;
> -
>                 if (amdgpu_sriov_vf(adev))
>                         sdma_v6_0_enable(adev, true);
>
>                 r =3D amdgpu_ring_test_helper(ring);
> -               if (r) {
> -                       ring->sched.ready =3D false;
> +               if (r)
>                         return r;
> -               }
>
>                 if (adev->mman.buffer_funcs_ring =3D=3D ring)
>                         amdgpu_ttm_set_buffer_funcs_status(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/am=
dgpu/si_dma.c
> index abca8b529721..42c4547f32ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -174,8 +174,6 @@ static int si_dma_start(struct amdgpu_device *adev)
>                 WREG32(DMA_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
>                 WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_EN=
ABLE);
>
> -               ring->sched.ready =3D true;
> -
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
>                         return r;
> --
> 2.25.1
>
