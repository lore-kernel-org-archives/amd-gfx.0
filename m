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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BEFC2D0E7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 20:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192092074D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 20:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/BCdkQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192092074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12E16E1E0;
	Wed, 25 Mar 2020 20:10:41 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7276E1E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 20:10:39 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j17so4841982wru.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r40K8/qvpAbBIDURI/n3F0G3VBNjw42JQstdcDpwPhs=;
 b=g/BCdkQ/rFtWJkTiSK6qaWc92XWF3fTW+JqiRcI/evSOjU2bOiyaTxRcJTd+Bltepp
 p0L8mQ43BUztQenNM0QeH9liMdqikgQSnp9ipTKcERqEcU0h7h6oZE9AhRSaX+bFbzTX
 oNrMNw0mWK/nuLnmfNRiCaSRwTo10S+vH/7v/YzNwp4t4NmST8QOVApS9VJBLzvyyHPb
 XyFTd9z3pNraTXQl4pKctY8e8jbTPnXqzQ+puFK2A/T4G/hIWPmq7fx+XwEDveNsgi/I
 9RWds9Ag58ZplhEDpOH3UXhkDTSt4vsGg+dsuSDxHTczUv8k30F88v0KN2eAluOyankr
 tXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r40K8/qvpAbBIDURI/n3F0G3VBNjw42JQstdcDpwPhs=;
 b=ladjNvAMdqJj4YvIm/kk++SLCOdgoWULMefQrp5nwSvUbEE+r/dq6PcBc1KUPQ+c5q
 /KAQdTP9hsVNyKDs9WB2o7rXNajMXNT0/wRt3ejiPfL0ouLrnG2ntOF8MIlX8Ol2C69H
 NATTK8POYGNGAkPqjSHx6q0AZI254MRQVFxr38GuT3W/UxOl7Vvbz/GgJduXYyPYEY0u
 S5eyylR7HxWVkI+zlecLmQ6OV8LICChybyytSBZnLV/SVRSejmbdKD03Qovr9iH8hIEz
 IWaDhN9TsARUrxcoNsnL72fMpKjBV3kEjK/rT5n6UZ7NChZ2Gum+QPpwIJxcE7B6Xh5J
 AksA==
X-Gm-Message-State: ANhLgQ2lh2142JyHscynGdTKmbxmfZ/r0/D3AbSU2Y+drl8YuVbJLbuk
 TKnkdWj9jx/vPyHq1XaynwJahC1rJROzC3SYk+lDvw==
X-Google-Smtp-Source: ADFU+vtVGCMV7IDOfgnOoWqxRlQk02rif3FDDW+YoZz0rJ4IexYPQES1r6CrAg3C25BCvIt0AE5vNDl+PXKO0eRWoyA=
X-Received: by 2002:a05:6000:111:: with SMTP id
 o17mr5183815wrx.111.1585167038312; 
 Wed, 25 Mar 2020 13:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200325192221.717578-1-tom.stdenis@amd.com>
In-Reply-To: <20200325192221.717578-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2020 16:10:26 -0400
Message-ID: <CADnq5_O6tv-V5iOKwjEVDJo6hU4i_=Y3O0fzju0XqTBb+hAT3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)
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

On Wed, Mar 25, 2020 at 3:22 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> The PWR block was merged into the SMUIO block by revision 12 so we add
> that to the smuio_12_0_0 headers.
>
> (v2): Drop nonsensical smuio_10_0_0 header
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h | 3 +++
>  .../drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h    | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
> index 327b4d09f66d..9bf73284ad73 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
> @@ -24,4 +24,7 @@
>  #define mmSMUIO_GFX_MISC_CNTL                                                                          0x00c8
>  #define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                                                 0
>
> +#define mmPWR_MISC_CNTL_STATUS                                                                         0x0183
> +#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                                                1
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
> index d815452cfd15..26556fa3d054 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
> @@ -24,5 +24,10 @@
>  //SMUIO_GFX_MISC_CNTL
>  #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                                                           0x00000006L
>  #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                                                         0x1
> +//PWR_MISC_CNTL_STATUS
> +#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                                                      0x0
> +#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                                                        0x1
> +#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                                                        0x00000001L
> +#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                                                          0x00000006L
>
>  #endif
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
