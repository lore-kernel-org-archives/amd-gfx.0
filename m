Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0627C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 17:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702C410E23E;
	Mon, 14 Feb 2022 17:53:40 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B996310E267
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 17:53:38 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 s6-20020a0568301e0600b0059ea5472c98so12074811otr.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YkAymclSJFAMZRqYY8ohNwit8Ona1sT8MPkkfXD2QQ8=;
 b=qR66O0SkVDvLqyoYNSiRdI9iy6ZYNDcrrfsl6uO6N/tAZEsP4MRrN5PIRy6mEUHFSO
 YLDK+rs6q/tIpPGR/VcnOGl6Ia46hvMQ7yclw8NAsdlismEKcClsEGm4yw3UgXZMv4LA
 Jn6a3hDu2aDWssgwBOBlH4Qqrke3pq3+fQ1p+r20vObWq0jOsbapT4iqztxfJ69d+VkE
 xVKfJvYQHG7ez5SrdhT/35a9iDz79PVDJYwoprlHL6HJ3JwU162zo1lYDE3AJpOwnRwe
 QEoZsj2LzO53B7WhWn4VX8THLZRbInPKOHPsFtVMgA/VyOwZdUISz3Mn+HAIBmihemRI
 YKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YkAymclSJFAMZRqYY8ohNwit8Ona1sT8MPkkfXD2QQ8=;
 b=uJQVtCCImCGbroVQ+Ipi3uzFU8oPml5/nJRkrRaGQ1/60fQcso58Mi//rBfTF5f8SN
 GJwfCOj+FtQCnrWLfXxF532eelLGvcNa5crXBP2Q6dxDUAWoriA4C7Ag/MrcDeJVX1Ze
 l+qnXdGBBdgcFAB06dsKwn/WoCMLYWFTUvwcvUopzJv5FOWJrPtQE36YgEpdFMu9HIau
 vqD7PyOG0B5YzSiUN7kxlCHadYgoyQ/nBVJkuIxcmewozk5nBsft9dhmnmm2iRPlrEf0
 9DV0JL6sYTcobr2C674tIFKAl3Rls32F0ZfHtn6mTUKpSeFY8w31UsdxjCW6VshBEOZB
 /qjA==
X-Gm-Message-State: AOAM531HgMM1CtA0uSN7hnPdXnFg/JuZnGKlN96d+ZQUgmYuWWyciwdd
 LnFyg1ilt7xp7W/mxOVEUtYRo/4jPcP9hnlnwhOktXmN
X-Google-Smtp-Source: ABdhPJyKRsEcJGTTJHWv2sRO46JbCt5Azw4ipcKouQudfS/w89LKsUIFVVHPjbqObDD/r9WBWm2IrjDHUvMdI2S3Yw8=
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr11676oth.357.1644861218038;
 Mon, 14 Feb 2022 09:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20220212154000.2102141-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20220212154000.2102141-1-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Feb 2022 12:53:27 -0500
Message-ID: <CADnq5_PxGFVVJdaYE1UF4jR+rjM2FhK1BKxkaH_dcGffrOk1rw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Protect update_bw_bounding_box FPU code.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sat, Feb 12, 2022 at 10:40 AM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> For DCN3/3.01/3.02 at least these use the fpu.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c | 2 ++
>  drivers/gpu/drm/amd/display/dc/core/dc.c                     | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> index 589131d415fd..220682e45b8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> @@ -474,8 +474,10 @@ static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
>         clk_mgr_base->bw_params->dc_mode_softmax_memclk = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
>
>         /* Refresh bounding box */
> +       DC_FP_START();
>         clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
>                         clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
> +       DC_FP_END();
>  }
>
>  static bool dcn3_is_smu_present(struct clk_mgr *clk_mgr_base)
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 467f606ba2c7..e46ec8cc2d0a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -987,8 +987,11 @@ static bool dc_construct(struct dc *dc,
>         dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
>  #endif
>
> -       if (dc->res_pool->funcs->update_bw_bounding_box)
> +       if (dc->res_pool->funcs->update_bw_bounding_box) {
> +               DC_FP_START();
>                 dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
> +               DC_FP_END();
> +       }
>
>         /* Creation of current_state must occur after dc->dml
>          * is initialized in dc_create_resource_pool because
> --
> 2.35.1
>
