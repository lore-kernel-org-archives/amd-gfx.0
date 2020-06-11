Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D0C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 13:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3ED20760
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpgYyzNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3ED20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403116E90B;
	Thu, 11 Jun 2020 13:37:49 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D46E6E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 13:37:47 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q25so5104723wmj.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZYC7LGxjkxAr3bct/h1JVuxHmfjsNtKsGz6zKMf0DiI=;
 b=NpgYyzNPaVjw2S4O9uYOjwZWueA3i+PyPMCnJaON2dUiXVMnKXXRNhuhvRFYgSWGI1
 EpW0fV9enPOdHSx8WkXjKcJrrEVh5WiF7zLLdvHF3RVqXZkNj9yAWkX3YKjgS9gRZJHn
 RaTce3g5+V2o3jEgaxjNEx+55PrWcmZ/n1Faq4XUblBVXVECQeDq1lL07YGMv26oLgib
 yLZ34fT8+2JuR9ozoKK3zmppBET/wrMv0wyr5+KussKT10g2owE7vfqd64GrMdB8ugfa
 LMIsPH9CNukeYxAhg1o5M+DJq6/6Db+6finu8TYwsqrKQmfydV3G7idlqpj5evcu2siT
 m6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZYC7LGxjkxAr3bct/h1JVuxHmfjsNtKsGz6zKMf0DiI=;
 b=YQ5nTkMTJ8xLjVY8ST11E9jGNgx93Iy2lGRUlvqSZNXYCHZqTgUEuO+myLpnFh4SSl
 S+cDDNYf72bboS9gHdj2K3UoFr2sTRKs9S1eH7jfJsfoMoyum1bx2hhiEDvp5DEgc6cq
 Smyyro0Pq/kE30yaow7QeRFO6rkqcv7Ch1gYGqZv7Kj+0WeD3LUlp+vRd0c64d/6uAFw
 XgSBunkXx0I2102HT7SY7MB2gb0geDhuNmvh1e406DNU92SK+yfjwO08NPb3p/rEEcRh
 WnpzLGOvZmrBPm3ftQkQZ6xl6gMXhafhFiIlkVeIuKbKuL0+uluHB27bY62EuohcCaNs
 IDTQ==
X-Gm-Message-State: AOAM530DYpwqX4g36UCvFksG2Wt3kPzxeSOmTdwf+r2YyYpQupQcW8WL
 t/GJz5ro54r61PIURIanFKhPhghOzwyXUnc6/CA=
X-Google-Smtp-Source: ABdhPJxYAcqRMsDS9AqmZ6aKKQDzxWxuCXoSC/PB8wZbZ3/VysvaG4jH8NyjHd2c9u0M/L1gg4v/mxGUDn9jwdxasJg=
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr8199468wml.70.1591882665625; 
 Thu, 11 Jun 2020 06:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200611115833.2546277-1-tom.stdenis@amd.com>
In-Reply-To: <20200611115833.2546277-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Jun 2020 09:37:34 -0400
Message-ID: <CADnq5_Oh791aNvVNHTu68+YqMkLpgdsg-xZ8wQSD3s9_U5ZPgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add SQ_DEBUG_STS_GLOBAL* registers/bits
To: Tom St Denis <tom.stdenis@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 11, 2020 at 7:58 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Even though they are technically MMIO registers I put the bits with the sqind block
> for organizational purposes.
>
> Requested for UMR debugging.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../include/asic_reg/gc/gc_10_1_0_offset.h    |  3 ++-
>  .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 16 ++++++++++++++
>  .../include/asic_reg/gc/gc_10_3_0_offset.h    |  3 ++-
>  .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 16 ++++++++++++++
>  .../amd/include/asic_reg/gc/gc_9_0_offset.h   |  4 +++-
>  .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  | 22 +++++++++++++++++++
>  .../amd/include/asic_reg/gc/gc_9_1_offset.h   |  4 +++-
>  .../amd/include/asic_reg/gc/gc_9_1_sh_mask.h  | 21 ++++++++++++++++++
>  .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |  4 +++-
>  .../include/asic_reg/gc/gc_9_2_1_sh_mask.h    | 21 ++++++++++++++++++
>  10 files changed, 109 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> index 791dc2b3d74a..aab3d22c3b0f 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> @@ -21,7 +21,8 @@
>  #ifndef _gc_10_1_0_OFFSET_HEADER
>  #define _gc_10_1_0_OFFSET_HEADER
>
> -
> +#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
> +#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
>
>  // addressBlock: gc_sdma0_sdma0dec
>  // base address: 0x4980
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> index 355e61bed291..4127896ffcdf 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> @@ -42546,6 +42546,22 @@
>
>
>  // addressBlock: sqind
> +//SQ_DEBUG_STS_GLOBAL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE_MASK 0xff0000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE__SHIFT 0x00000010
> +#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
> +#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0_MASK 0x0000fff0L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1_MASK 0x0fff0000L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1__SHIFT 0x00000010
> +
>  //SQ_DEBUG_STS_LOCAL
>  #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
>  #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> index a9a66371b75e..16c7f6f2467e 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> @@ -22,7 +22,8 @@
>  #ifndef _gc_10_3_0_OFFSET_HEADER
>  #define _gc_10_3_0_OFFSET_HEADER
>
> -
> +#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
> +#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
>
>  // addressBlock: gc_sdma0_sdma0dec
>  // base address: 0x4980
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> index 499a8c3c2693..aac57f714cf1 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> @@ -46269,6 +46269,22 @@
>
>
>  // addressBlock: sqind
> +//SQ_DEBUG_STS_GLOBAL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE_MASK 0xff0000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE__SHIFT 0x00000010
> +#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
> +#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0_MASK 0x0000fff0L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1_MASK 0x0fff0000L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1__SHIFT 0x00000010
> +
>  //SQ_DEBUG_STS_LOCAL
>  #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
>  #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
> index fc39795acfda..e3e1a9c1153b 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
> @@ -21,7 +21,9 @@
>  #ifndef _gc_9_0_OFFSET_HEADER
>  #define _gc_9_0_OFFSET_HEADER
>
> -
> +#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
> +#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
> +#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
>
>  // addressBlock: gc_grbmdec
>  // base address: 0x8000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> index d7964c2bd950..efc16ddf274a 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> @@ -28350,6 +28350,28 @@
>
>
>  // addressBlock: sqind
> +//SQ_DEBUG_STS_GLOBAL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST_MASK 0xff000000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST__SHIFT 0x00000018
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED_MASK 0x00ff0000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED__SHIFT 0x00000010
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD_MASK 0x0000000fL
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG_MASK 0x000000f0L
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
> +#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0_MASK 0x0000fff0L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1_MASK 0x0fff0000L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1__SHIFT 0x00000010
> +
>  //SQ_DEBUG_STS_LOCAL
>  #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
>  #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
> index 2223d4b77dcb..6b1ad9082a2c 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
> @@ -21,7 +21,9 @@
>  #ifndef _gc_9_1_OFFSET_HEADER
>  #define _gc_9_1_OFFSET_HEADER
>
> -
> +#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
> +#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
> +#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
>
>  // addressBlock: gc_grbmdec
>  // base address: 0x8000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
> index 4acf640b1893..b84bd0fa3015 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
> @@ -29571,6 +29571,27 @@
>
>
>  // addressBlock: sqind
> +//SQ_DEBUG_STS_GLOBAL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST_MASK 0xff000000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST__SHIFT 0x00000018
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED_MASK 0x00ff0000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED__SHIFT 0x00000010
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD_MASK 0x0000000fL
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG_MASK 0x000000f0L
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
> +#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0_MASK 0x0000fff0L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1_MASK 0x0fff0000L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1__SHIFT 0x00000010
>  //SQ_DEBUG_STS_LOCAL
>  #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
>  #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
> index 1c5ef8e8a341..f377354e850e 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
> @@ -21,7 +21,9 @@
>  #ifndef _gc_9_2_1_OFFSET_HEADER
>  #define _gc_9_2_1_OFFSET_HEADER
>
> -
> +#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
> +#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
> +#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
>
>  // addressBlock: gc_grbmdec
>  // base address: 0x8000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h
> index 088f59cc2197..6199fce51e20 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h
> @@ -29893,6 +29893,27 @@
>
>
>  // addressBlock: sqind
> +//SQ_DEBUG_STS_GLOBAL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST_MASK 0xff000000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST__SHIFT 0x00000018
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED_MASK 0x00ff0000L
> +#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED__SHIFT 0x00000010
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD_MASK 0x0000000fL
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG_MASK 0x000000f0L
> +#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
> +#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
> +#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0_MASK 0x0000fff0L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0__SHIFT 0x00000004
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1_MASK 0x0fff0000L
> +#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1__SHIFT 0x00000010
>  //SQ_DEBUG_STS_LOCAL
>  #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
>  #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
