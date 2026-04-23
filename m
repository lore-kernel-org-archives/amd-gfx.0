Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4838CF99355
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 08:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57E410EFF0;
	Thu, 23 Apr 2026 08:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YK/wdg6a";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0187D10EA59
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 05:20:15 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7baee75f874so40335147b3.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 22:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776921615; x=1777526415; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CKkkHL/8l1d68NjGtJB0lC7kW7ZwMKC813R/A4iR9Bk=;
 b=YK/wdg6atSRnjUzafLTYZ0mAEmGaKkH8hnh5BtEZzMFigPAAy0FzLg7yNEvMENS2Vx
 DjelSLB7fG0AmNh7pgLqL+cxJz1bBgC7P7Btk3/G5bOPDAUrBwgAoZ4G16hnTKMeFmDO
 1jX/LBC7JHRPvpKoUKrU7DH+zEfFYNL98oI/8X24wdTKjqdi62EpqzONBmvCOlwhZOow
 UTkhpk5qeNPt7EuGRiSjRbnxFfTiqABKSLnDpfkyRwZx5sfGuiYCsY+vjpNW2c+yPYto
 CmgOSbW+e1Bi0oC4Sgj6XFtdN7IhVLgiBN8LIkZQKXUvKTwLd1BFc0hOfXnUL42vWVhs
 UZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776921615; x=1777526415;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CKkkHL/8l1d68NjGtJB0lC7kW7ZwMKC813R/A4iR9Bk=;
 b=rhEi/4a9Ug8fQudZEhvuQMq+bTVoXjynkrCDmzKcjwlY7jYb3rW+YaWgg9bD4ZFWXm
 WhmSTXpANhWNhKy0+SGiO+IZzO/eEpobe8yo+EtoABFkkHcmyK1awvPPEQD13H9G0y+K
 ywjd4084OfT6W++Je/2CQ5KMfo8dFn+0SheOj8JwYCAec1id2Wgf7sQff/Rb0VwMMQc1
 PKaYyx3JQ13/hZRIRcn0/3jNXoV/UOywI53gufRjlFowMN+EjWXDZXDLn7gvRH4iuS9E
 HYZgiDa0kDV6NGzKF1pwtS8mUWKFKimxsmm/RcuyaHiq5k6VAoEu81qCSVhOSdkWVnLi
 qw8Q==
X-Gm-Message-State: AOJu0Yzyh8ykrVwL6pFCMvzAnX6K00ZOcdRXZMR+7Gf+urd5sAvk3lUx
 5p0DvND3CS6jN9RfcpCo+vlWFZBsYylIIgVLAM2h+pjwvjfbAzCJAP1P
X-Gm-Gg: AeBDieucNwSriLnGbDwbal2gpQrJ9TNcgat/ZC44KxQWpEcGKH/w69Hm3cSA0hBYgaK
 AE0X8TUzWsKimJAEkNqWyYcTJpoKnginxTnscM3p0PFo000heGPvMFAdHxwFxLWxtcFhfTQ5aax
 1oWFxP1wA/3Ur7alJDvvhf46HyG3jJIC/NTXoF237yS6CJUsOC6uis0L8qf4JPQGB9qkbcbpXs9
 5DzW0as67STkgWVGFL0xENDyQlrsLgjG2PaEdEpBfqB0NeNTcDhGd+swKE2KaTxz+OtDm0yNQRC
 2l+JpmnARXD25M3FoHus00aFGO/Jql94FnHxgPuTspWyEBdowcxNz3CjaleXKd8w45ZaT+alKPp
 bf5YyXv6yKaVZD/7OZ8pZnywtlq5l+IBf7eywYss2g30dxOk5IJxt5U3IrIRd5Epe5aSVD626BR
 sGO4LfW0cYjye4J7wpQP+JpZK4wzpf
X-Received: by 2002:a05:690c:6612:b0:7ba:f0ed:c5ea with SMTP id
 00721157ae682-7baf0edf39cmr162817197b3.39.1776921614995; 
 Wed, 22 Apr 2026 22:20:14 -0700 (PDT)
Received: from localhost ([172.216.252.33]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b9ee99bd34sm75680347b3.26.2026.04.22.22.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 22:20:13 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:20:07 +0300
From: Dan Carpenter <error27@gmail.com>
To: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Fix dml2_0 narrowing boundaries
Message-ID: <aemsBzdb8aMwFSQi@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:52:16 +0000
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

Hello Gaghik Khachatrian,

Commit 11236ac905e7 ("drm/amd/display: Fix dml2_0 narrowing
boundaries") from Apr 9, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml2_mall_phantom.c:601 subvp_vblank_schedulable()
	warn: unsigned subtraction: 'subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion' use '!='

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml2_mall_phantom.c
    521 static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *context)
    522 {
    523         struct pipe_ctx *pipe = NULL;
    524         struct pipe_ctx *subvp_pipe = NULL;
    525         bool found = false;
    526         bool schedulable = false;
    527         uint32_t i = 0;
    528         uint8_t vblank_index = 0;
    529         uint32_t prefetch_us = 0;
    530         uint32_t mall_region_us = 0;
    531         uint32_t vblank_frame_us = 0;
    532         uint32_t subvp_active_us = 0;
    533         uint32_t vblank_blank_us = 0;

Originally these were u16 but the commit changed them to u32.

    534         uint32_t max_vblank_mallregion = 0;
    535         struct dc_crtc_timing *main_timing = NULL;
    536         struct dc_crtc_timing *phantom_timing = NULL;
    537         struct dc_crtc_timing *vblank_timing = NULL;
    538         struct dc_stream_state *phantom_stream;
    539         enum mall_stream_type pipe_mall_type;
    540 
    541         /* For SubVP + VBLANK/DRR cases, we assume there can only be
    542          * a single VBLANK/DRR display. If DML outputs SubVP + VBLANK
    543          * is supported, it is either a single VBLANK case or two VBLANK

[ snip ]

    573         // Use ignore_msa_timing_param flag to identify as DRR
    574         if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param) {
    575                 // SUBVP + DRR case
    576                 schedulable = dml2_svp_drr_schedulable(ctx, context, &context->res_ctx.pipe_ctx[vblank_index].stream->timing);
    577         } else if (found) {
    578                 phantom_stream = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, subvp_pipe->stream);
    579                 main_timing = &subvp_pipe->stream->timing;
    580                 phantom_timing = &phantom_stream->timing;
    581                 vblank_timing = &context->res_ctx.pipe_ctx[vblank_index].stream->timing;
    582                 // Prefetch time is equal to VACTIVE + BP + VSYNC of the phantom pipe
    583                 // Also include the prefetch end to mallstart delay time
    584                 prefetch_us = (uint32_t)((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
    585                                 (double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
    586                                 ctx->config.svp_pstate.subvp_prefetch_end_to_mall_start_us);
    587                 // P-State allow width and FW delays already included phantom_timing->v_addressable
    588                 mall_region_us = (uint32_t)(phantom_timing->v_addressable * phantom_timing->h_total /
    589                                 (double)(phantom_timing->pix_clk_100hz * 100) * 1000000);
    590                 vblank_frame_us = (uint32_t)(vblank_timing->v_total * vblank_timing->h_total /
    591                                 (double)(vblank_timing->pix_clk_100hz * 100) * 1000000);
    592                 vblank_blank_us = (uint32_t)((vblank_timing->v_total - vblank_timing->v_addressable) * vblank_timing->h_total /
    593                                 (double)(vblank_timing->pix_clk_100hz * 100) * 1000000);
    594                 subvp_active_us = (uint32_t)(main_timing->v_addressable * main_timing->h_total /
    595                                 (double)(main_timing->pix_clk_100hz * 100) * 1000000);
    596                 max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
    597 
    598                 // Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
    599                 // and the max of (VBLANK blanking time, MALL region)
    600                 // TODO: Possibly add some margin (i.e. the below conditions should be [...] > X instead of [...] > 0)
--> 601                 if (subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion > 0)

With u16 types this was type promoted to int so the result could be
negative, but now it's u32 and the result can never be negative.


    602                         schedulable = true;
    603         }
    604         return schedulable;
    605 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
