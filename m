Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D2AC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 19:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7131620774
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 19:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvLGdkze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7131620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A156E045;
	Tue, 29 Sep 2020 19:58:09 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223CD6E045
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 19:58:08 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id m6so6837779wrn.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a1xUGOfulvA7a98/3C2Ez761iaVaWSVg9v2Igw6k8gI=;
 b=BvLGdkzeLvwG7k4yC/gVg7+KeCzs8BfVXkYSmdR7IzWm5Eom6xx2nCbQRpLBYrdDn7
 ekclDkw5cSN/+EshnSLjuINdPkrY6V3Sn0vDDW0t9HPj8UO50vzyN+3hKKNVZlfs4k6j
 F4LKuk1qeyXKlB3kZST3Li3Tu0ZF+VhmGnYccyN/uDHbYCwPrcCaTy6bPS5EJdWH1Qi9
 UPVlBghDNyxfvaBd/PWfLoKiIv6S7/5FftBYqQa804NYcbRj+e+H+FnTjVU/5kxPAH/O
 XncW1cTzrn5S3WvNAuQftEUBP3eCxkk+QZl4rfC3SHoTU4HHB8vKHWba+ZtniLpsh5Wc
 wyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a1xUGOfulvA7a98/3C2Ez761iaVaWSVg9v2Igw6k8gI=;
 b=VEumMV7o/pHlIgVtoN3YJTmr+1E/DjAn2wK46g4DVRnCUwK/Mal5qoZLgKFMA0oP6q
 4HDtQGTVPaUjjnrLRmC45SQ3n6uuMENVlR5csO3fWJZRTiulZHot1jSaNrrOwoD4M6wj
 HIFJq6JUhV2FdMBPUUaS+gxUwG+pgkGh6QfJBYx5CSGMMfr2d9zR9Iyfapj3YgnzKHBq
 HmQUKe1IUsgv5udzQ3AXrtdLvbCtf/l23QO64mENgePazglRvpOvxLS9vAyGzUBYpNfs
 FGWUd2IEhT6jFavSreProgb51cVRuWwouthc/t1PvMYzF7qcwl02SSe6zPXkdyBDuN8N
 0ncA==
X-Gm-Message-State: AOAM532Wd3a/z0Nki95uOlKWKZIkNH116ziCgjvQOX5gHnMjCOFfZyhi
 GuT6xlmsvfdiFrs2YxkG1FUfQ5kszox+VmUlEj4=
X-Google-Smtp-Source: ABdhPJyVEcI3VWPDA8/gXnqmLzXaeGlW7b473j8qWqWUvovwph9TKbCZ+b0vr/qv0rg1hDFt1fkobNaZkoNkbH8UNt4=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr6350156wru.374.1601409486769; 
 Tue, 29 Sep 2020 12:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200929175957.25855-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200929175957.25855-1-Ramesh.Errabolu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 15:57:55 -0400
Message-ID: <CADnq5_MGZqeW0sGnPBcihLZkqZfbRK-RPyfnAwtfEWtvr6mdZA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
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

On Tue, Sep 29, 2020 at 2:00 PM Ramesh Errabolu <Ramesh.Errabolu@amd.com> wrote:
>
> [Why]
> Allow user to know number of compute units (CU) that are in use at any
> given moment.
>
> [How]
> Read registers of SQ that give number of waves that are in flight
> of various queues. Use this information to determine number of CU's
> in use.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h | 3 +++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 346d8288f6ab..6959aebae6d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -49,6 +49,7 @@
>  #include "amdgpu_ras.h"
>
>  #include "gfx_v9_4.h"
> +#include "gfx_v9_0.h"
>
>  #include "asic_reg/pwr/pwr_10_0_offset.h"
>  #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
> @@ -788,7 +789,6 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>                                   struct amdgpu_cu_info *cu_info);
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
>  static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
>  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>  static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> @@ -2397,7 +2397,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
>         /* TODO */
>  }
>
> -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance)
> +void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
> +                          u32 instance)
>  {
>         u32 data;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> index 407472031daa..dfe8d4841f58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> @@ -26,4 +26,7 @@
>
>  extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
>
> +void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
> +                          u32 instance);
> +
>  #endif
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
