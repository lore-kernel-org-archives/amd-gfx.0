Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB3FC2D0E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 18:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85832206F8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 18:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqCKERO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85832206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504FD6E1A7;
	Wed, 25 Mar 2020 18:22:48 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2C46E1A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 18:22:47 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w10so4471512wrm.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5/K/B7cyC2ddjo5j7tXla5iI9zv79V+jZxuesUUMn44=;
 b=aqCKERO6Uud6ADBPZkig4/qeXIQTTizsli3pvHlWTfoptUUGnSwAj0cBCA7ZAVizCY
 nSX9W7yYfyHuXqQx+9nCZaYOzaqCMfZ3O+qsiNcJIPRizoniE7dw8dDMBk+aiNeqEYDj
 9/RPx1W9rrMzBaYMuWGXN72iZNasOoHlbsx7YIE7hXUj3KJII8/wiEwvUgRruoROVt9H
 ZHkvdMeOlqgSYCibpJf6BsbbmUcUlYN07vukvVncsM7H/DcGi+iBW9d0eWN/cHMgC5IL
 H9vJwZgvr8zMWsZvJaSdPQIqyc/ocLDIkJjCH+d84RAEnYMmqz6olqD6S5Pn5tnMA2E9
 AXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5/K/B7cyC2ddjo5j7tXla5iI9zv79V+jZxuesUUMn44=;
 b=g3ESt/zyczhWLiquiCc49IDHmSknLiOJoe5WhTgAlDvgAJpLO3AqPfHkBc4UxTOtSI
 IbZYjE0lkIrb+XjT+HvUaRfjpAr9EXAmCUFWUKcJUahfKekShLUklQFK8u0FVEGEXzf+
 fOrPRYvXBlNHQjRgD20puIqANCtWTsI6To7gBo6ZHcAyX+5hkbZDij+31hUZr9NVcrYw
 vqRldnfd46JZh+pLOYxGe7dxjLbO6zUtNmkzBuJ4iwa0k2ULB0DWfsjWaySUMXaDuYE3
 jaH0+BCD99eX93k8ZKT9o4c9k+p0kVpdEXBvVzM0NIm1uX/XITFZbcKMuZjrWUhxKvUy
 aGEA==
X-Gm-Message-State: ANhLgQ1OrmIc8rALg9vldkfbZCczhIQBqyreom7Qt/5lG219BSyMoV4l
 3e7h5QIpwKTChyUu3v1M419KCRh4guyPPdqzDglYDg==
X-Google-Smtp-Source: ADFU+vuLAGYtEcaruZw8maH9RUt5CutGpR6IMfhoIKXwhXtX0Alhx+Xb9eiejPrJoJ9BN7DkX7BC37SL7m+HJO3DKNs=
X-Received: by 2002:adf:b35e:: with SMTP id k30mr4724452wrd.362.1585160565933; 
 Wed, 25 Mar 2020 11:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200325180839.469615-1-tom.stdenis@amd.com>
 <20200325180839.469615-2-tom.stdenis@amd.com>
In-Reply-To: <20200325180839.469615-2-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2020 14:22:34 -0400
Message-ID: <CADnq5_MF4uwgPkyYAwFyK6HWyCuYsGyeqsKiyc=mOoS3wrfPjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: Move PWR_MISC_CNTL_STATUS to its own
 header
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

On Wed, Mar 25, 2020 at 2:08 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> The register is part of the PWR block not the GC block.  Move to
> its own header.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/include/asic_reg/gc/gc_9_1_offset.h   |  2 --
>  .../amd/include/asic_reg/gc/gc_9_1_sh_mask.h  |  5 ----
>  .../include/asic_reg/pwr/pwr_10_0_offset.h    | 27 +++++++++++++++++
>  .../include/asic_reg/pwr/pwr_10_0_sh_mask.h   | 30 +++++++++++++++++++
>  4 files changed, 57 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
> index ad61ffb0fd97..030e0020902b 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
> @@ -159,8 +159,6 @@
>  #define mmCP_DE_LAST_INVAL_COUNT_BASE_IDX                                                              0
>  #define mmCP_DE_DE_COUNT                                                                               0x00c4
>  #define mmCP_DE_DE_COUNT_BASE_IDX                                                                      0
> -#define mmPWR_MISC_CNTL_STATUS                                                                         0x0183
> -#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                                                0
>  #define mmCP_STALLED_STAT3                                                                             0x019c
>  #define mmCP_STALLED_STAT3_BASE_IDX                                                                    0
>  #define mmCP_STALLED_STAT1                                                                             0x019d
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
> index 6cc63562fd55..13bfc2e6e16f 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
> @@ -801,11 +801,6 @@
>  //CP_DE_DE_COUNT
>  #define CP_DE_DE_COUNT__DRAW_ENGINE_COUNT__SHIFT                                                              0x0
>  #define CP_DE_DE_COUNT__DRAW_ENGINE_COUNT_MASK                                                                0xFFFFFFFFL
> -//PWR_MISC_CNTL_STATUS
> -#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                                                      0x0
> -#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                                                        0x1
> -#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                                                        0x00000001L
> -#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                                                          0x00000006L
>  //CP_STALLED_STAT3
>  #define CP_STALLED_STAT3__CE_TO_CSF_NOT_RDY_TO_RCV__SHIFT                                                     0x0
>  #define CP_STALLED_STAT3__CE_TO_RAM_INIT_FETCHER_NOT_RDY_TO_RCV__SHIFT                                        0x1
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h
> new file mode 100644
> index 000000000000..e87c359ea1fe
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2020  Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included
> + * in all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
> + * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> + */
> +#ifndef _pwr_10_0_OFFSET_HEADER
> +#define _pwr_10_0_OFFSET_HEADER
> +
> +#define mmPWR_MISC_CNTL_STATUS                                                                         0x0183
> +#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                                                0
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h
> new file mode 100644
> index 000000000000..8a000c21651c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright (C) 2020  Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included
> + * in all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
> + * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> + */
> +#ifndef _pwr_10_0_SH_MASK_HEADER
> +#define _pwr_10_0_SH_MASK_HEADER
> +
> +//PWR_MISC_CNTL_STATUS
> +#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                                                      0x0
> +#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                                                        0x1
> +#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                                                        0x00000001L
> +#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                                                          0x00000006L
> +
> +#endif
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
