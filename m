Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E9FC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FC920936
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX9KxJmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FC920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EEB6EB18;
	Wed, 16 Sep 2020 19:58:36 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CE66EB18
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:58:36 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id y15so4292289wmi.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DfA6+xRS6Nq0n8p9CQ9hN/w7hL9OWCmZOuirF19p7YU=;
 b=eX9KxJmQXk34gPW15ogEcW2MO7ICw8F85oKVDechB68LJEwXkikXAYYraJOZxw2DcF
 wMJtucBpj7nGAqLuAfFa9fRhZeJjhU4T9VPM7z076Bt5IhwxIHQ4qsMC5H8+GNsn/TM7
 9MOJbhJ7cJDGy38xybTz+YWXZZRukvbRJ7RW1VxdMCWeFy2AMsQF95CheSxaSUwuQ1VX
 wKxlxQm0PBtG5iCYnXMe6CJR6CYxhQdGNjrbWkS6J9lm3u35MG+gr0CS1KHmSGPDgskY
 y0fc0FWl53gGZlNJHxmDAwWx3QwIPwunwAfoMBl9YFG8jaZcDMnTTOV8lC5GKArZaOoK
 +uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfA6+xRS6Nq0n8p9CQ9hN/w7hL9OWCmZOuirF19p7YU=;
 b=i/9yv65RXc8qdz24zuaWJ7YB2Wv96agzWShtVyt+TiEgb55HnBkDyQe1iI3EOfThaV
 y1Hzv1JjOWc2TpuEHVs8F4Z3hRRLvYt3psio+vHbPos1idHR3lKzWFkguX6NSW7rC7x9
 0vI6xkg8tL0LzknHJaThmBJFNu/YQwsDtSDQNNaeRzfNN/HYeQuScz6v1x3EeenGDFSg
 qzDacaVdyt91zblaonbXzl3a7lSA8cV8BqjC3lc6wVeFGGX+0mYCeBA/MM+oBUcu9Dsb
 ygIvmnokGXvk3G2mGG5l5rvyY4b3gW+xrQiT3j3icweRatmdlJKUAHE3rXiph2BrYdys
 5rHg==
X-Gm-Message-State: AOAM533hbdQsmB497/4EGE6vAkCq8VcfP2ceiFJLetfLb1s60n/OVIBg
 i19T3psh6VIOMy+Wa+dlQJeZs/bqlh7GHh1LXHnv5fw1
X-Google-Smtp-Source: ABdhPJzfaisBnHsunDQBfZXSkRgkLwEjiD+g1akR3X6Q8dyPPDlF5qOkbvHXG0uciBf2Brv5HpTx8LXgHwaVc7b8Z4A=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr6361326wmc.73.1600286314982; 
 Wed, 16 Sep 2020 12:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200916162130.1562572-1-tom.stdenis@amd.com>
In-Reply-To: <20200916162130.1562572-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2020 15:58:24 -0400
Message-ID: <CADnq5_OM1dJEB8tbMfxu8CzjhR_niww4DLq8pi4aDYj05Pbfjw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add mmUVD_FW_STATUS register to uvd700
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

On Wed, Sep 16, 2020 at 12:21 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> This register was requested for umr debugging support.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/include/asic_reg/uvd/uvd_7_0_offset.h |  3 +++
>  .../include/asic_reg/uvd/uvd_7_0_sh_mask.h    | 20 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h
> index 07aceffb108a..524ba4421c17 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h
> @@ -151,6 +151,8 @@
>  #define mmUVD_LMI_CTRL2_BASE_IDX                                                                       1
>  #define mmUVD_MASTINT_EN                                                                               0x0540
>  #define mmUVD_MASTINT_EN_BASE_IDX                                                                      1
> +#define mmUVD_FW_STATUS                                                                                0x0557
> +#define mmUVD_FW_STATUS_BASE_IDX                                                                       1
>  #define mmJPEG_CGC_CTRL                                                                                0x0565
>  #define mmJPEG_CGC_CTRL_BASE_IDX                                                                       1
>  #define mmUVD_LMI_CTRL                                                                                 0x0566
> @@ -219,4 +221,5 @@
>  #define mmUVD_CONTEXT_ID2_BASE_IDX                                                                     1
>
>
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h
> index b427f73bd536..919be1842bd5 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h
> @@ -807,5 +807,25 @@
>  #define UVD_CONTEXT_ID2__CONTEXT_ID2__SHIFT                                                                   0x0
>  #define UVD_CONTEXT_ID2__CONTEXT_ID2_MASK                                                                     0xFFFFFFFFL
>
> +//UVD_FW_STATUS
> +#define UVD_FW_STATUS__BUSY__SHIFT                                                                            0x0
> +#define UVD_FW_STATUS__ACTIVE__SHIFT                                                                          0x1
> +#define UVD_FW_STATUS__SEND_EFUSE_REQ__SHIFT                                                                  0x2
> +#define UVD_FW_STATUS__DONE__SHIFT                                                                            0x8
> +#define UVD_FW_STATUS__PASS__SHIFT                                                                            0x10
> +#define UVD_FW_STATUS__FAIL__SHIFT                                                                            0x11
> +#define UVD_FW_STATUS__INVALID_LEN__SHIFT                                                                     0x12
> +#define UVD_FW_STATUS__INVALID_0_PADDING__SHIFT                                                               0x13
> +#define UVD_FW_STATUS__INVALID_NONCE__SHIFT                                                                   0x14
> +#define UVD_FW_STATUS__BUSY_MASK                                                                              0x00000001L
> +#define UVD_FW_STATUS__ACTIVE_MASK                                                                            0x00000002L
> +#define UVD_FW_STATUS__SEND_EFUSE_REQ_MASK                                                                    0x00000004L
> +#define UVD_FW_STATUS__DONE_MASK                                                                              0x00000100L
> +#define UVD_FW_STATUS__PASS_MASK                                                                              0x00010000L
> +#define UVD_FW_STATUS__FAIL_MASK                                                                              0x00020000L
> +#define UVD_FW_STATUS__INVALID_LEN_MASK                                                                       0x00040000L
> +#define UVD_FW_STATUS__INVALID_0_PADDING_MASK                                                                 0x00080000L
> +#define UVD_FW_STATUS__INVALID_NONCE_MASK                                                                     0x00100000L
> +
>
>  #endif
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
