Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07E5C88E6D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 07:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8379C10EBAA;
	Mon, 14 Sep 2026 07:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cVeq8Qww";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741F810F6AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 18:13:28 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso10380515e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789150407; x=1789755207; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9kb9hg0vDAZCyLL3SnYWE98WmY27gRY1OBC3sr+XKDA=;
 b=cVeq8Qwwkw/9htiXVSpdOX9JdTnwvAIkDYt83yOgvI9gOSq3MlcGXACUFJSkDCGkul
 rgFoaJ4jXeXMwNVw3Mq1Wkde03s50IJmF01AVaU3ZXMjdMKZt5bWp8kQvPWWW2M1gHSm
 XO+GQPQwVO0s8obAlrkkmHvzQVHRlsCKyENQwSCwygQ3uNMhAWdtpBCgqkoX8PoNXLmu
 FmwiOntGzY1Lf0BGAR6mHTy+cZf+b8zEQbG0jTInTdlmlPepsNTceYxIPt1SbCCOvPmd
 nUxZf9C3W8FCormCb/lrzpBWp29ZZu2k6Qe6jwOeRdCBu3KoRsRJ5WgxZnk5hDZV8pR4
 zUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789150407; x=1789755207;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9kb9hg0vDAZCyLL3SnYWE98WmY27gRY1OBC3sr+XKDA=;
 b=njOR9iWh07E0P+58nH+E8xvyLhPTHvM6iYM6GSRIosOWxf9d5zzSWaFIywrW9HnhV3
 pGvLNYNCfgQKlMpceIxkORiwg7fx0wjz2wca7IEmGeR8wzWTjZoQLIQjrQJ5oNLENvip
 gKUe1vA+G4kstfn9yD3paAXVVeKJwxaJjgRUJYpR9jSjLsLX7wM+Gg5qJsKgzyz+qOgL
 4eLbINUl2X6nqLm0TWQ4j92eQzxr/fBheqdF+UCP2bDlyiQ63MY+KB8CKYqXxQvmEfu3
 AlISl9f0VZM1ldc3iCUIoq9HqiHyz+W1A+K2c1w5J6djwLt/qj/NEnRaP3DF0+c9CvHN
 1HzQ==
X-Gm-Message-State: AFuF++mqjS7e97L5V6z2HkukwKFttOJXnwQjhhKwSB8zD5uHiqIRLS/t
 T/U79GC+E6c7CGBBL2TmfE8QSZmamMpUywgSEuGdIB1TH7KINrn8aHlZ
X-Gm-Gg: AYBFou1V2dAJIDxF5Pb8jQpINx08sJZ2gnHboU06a7XTl50uGoWii3sqe7cnyzutKgB
 uCyQw0t5NRP52hL7N7LP+CsUOT+par/A3B/OzRpPBDtSHzlFdYJ+JYFsgSN1OgQAdEzqRNxdvE0
 im9NPXKQ+S5wdW6bYbhDUS+455gSxlNXjxy8u3rypLJAA2ZTZNqia8b8mmy5tgIXCpihLn4yczJ
 ee5T08DVrmlE+nxl71euW5uYXptOPagylkozkoKSgGzNewi9BgP9juTWYD4uhDG6JnZW/sIxDJ8
 ui52n3hSE8bJh5Uw6iwNztNhXiKeRWh4kND0LmRBTjoVIeLdFdPuf6+ljyXgZm3KiXa35RU1u4J
 yCmfJv/BhEBm8Na4yeOMtrIN3RRtWyfQetWwSrnuwu4PejZ2rop1ZiVklmcg+3niaSPWgnJFywB
 9gPHsgabSYQH8qUGluKQsX7PvAfI0ktoqvlEtt2pH3ypPKnl/w6cPW4KLxYzzClys7DUs=
X-Received: by 2002:a05:600c:3b1f:b0:49c:fc89:59cb with SMTP id
 5b1f17b1804b1-49e61983468mr68821155e9.5.1789150406490; 
 Fri, 11 Sep 2026 11:13:26 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6aac22bbsm10883165e9.0.2026.09.11.11.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 11:13:25 -0700 (PDT)
Date: Fri, 11 Sep 2026 21:13:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: Austin Zheng <Austin.Zheng@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Move DML Wrapper into its own Component
Message-ID: <aqREwdWO0lq34dHZ@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 14 Sep 2026 07:29:45 +0000
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

Hello Austin Zheng,

Commit 2fb66192d389 ("drm/amd/display: Move DML Wrapper into its own
Component") from Aug 6, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_wrapper/dml2_mall_phantom.c:613 subvp_vblank_schedulable()
	warn: unsigned subtraction: 'subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion' use '!='

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_wrapper/dml2_mall_phantom.c
    533 static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *context)
    534 {
    535         struct pipe_ctx *pipe = NULL;
    536         struct pipe_ctx *subvp_pipe = NULL;
    537         bool found = false;
    538         bool schedulable = false;
    539         int i = 0;
    540         uint8_t vblank_index = 0;
    541         uint32_t prefetch_us = 0;
    542         uint32_t mall_region_us = 0;
    543         uint32_t vblank_frame_us = 0;
    544         uint32_t subvp_active_us = 0;
    545         uint32_t vblank_blank_us = 0;
    546         uint32_t max_vblank_mallregion = 0;
    547         struct dc_crtc_timing *main_timing = NULL;
    548         struct dc_crtc_timing *phantom_timing = NULL;
    549         struct dc_crtc_timing *vblank_timing = NULL;
    550         struct dc_stream_state *phantom_stream;
    551         enum mall_stream_type pipe_mall_type;
    552 
    553         /* For SubVP + VBLANK/DRR cases, we assume there can only be
    554          * a single VBLANK/DRR display. If DML outputs SubVP + VBLANK
    555          * is supported, it is either a single VBLANK case or two VBLANK
    556          * displays which are synchronized (in which case they have identical
    557          * timings).
    558          */
    559         for (i = 0; i < ctx->config.dcn_pipe_count && i < MAX_PIPES ; i++) {
    560                 pipe = &context->res_ctx.pipe_ctx[i];
    561                 pipe_mall_type = ctx->config.svp_pstate.callbacks.get_pipe_subvp_type(context, pipe);
    562 
    563                 // We check for master pipe, but it shouldn't matter since we only need
    564                 // the pipe for timing info (stream should be same for any pipe splits)
    565                 if (!pipe->stream || !pipe->plane_state || pipe->top_pipe || pipe->prev_odm_pipe)
    566                         continue;
    567 
    568                 if (!found && pipe_mall_type == SUBVP_NONE) {
    569                         // Found pipe which is not SubVP or Phantom (i.e. the VBLANK pipe).
    570                         ASSERT(i <= 0xFF);
    571                         vblank_index = (uint8_t)i;
    572                         found = true;
    573                 }
    574 
    575                 if (!subvp_pipe && pipe_mall_type == SUBVP_MAIN)
    576                         subvp_pipe = pipe;
    577         }
    578 
    579         if (subvp_pipe == NULL) {
    580                 // Defensive: should never happen, catch in debug
    581                 ASSERT(0);
    582                 return false;
    583         }
    584 
    585         // Use ignore_msa_timing_param flag to identify as DRR
    586         if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param) {
    587                 // SUBVP + DRR case
    588                 schedulable = dml2_svp_drr_schedulable(ctx, context, &context->res_ctx.pipe_ctx[vblank_index].stream->timing);
    589         } else if (found) {
    590                 phantom_stream = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, subvp_pipe->stream);
    591                 main_timing = &subvp_pipe->stream->timing;
    592                 phantom_timing = &phantom_stream->timing;
    593                 vblank_timing = &context->res_ctx.pipe_ctx[vblank_index].stream->timing;
    594                 // Prefetch time is equal to VACTIVE + BP + VSYNC of the phantom pipe
    595                 // Also include the prefetch end to mallstart delay time
    596                 prefetch_us = (uint32_t)((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
    597                                 (double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
    598                                 ctx->config.svp_pstate.subvp_prefetch_end_to_mall_start_us);
    599                 // P-State allow width and FW delays already included phantom_timing->v_addressable
    600                 mall_region_us = (uint32_t)(phantom_timing->v_addressable * phantom_timing->h_total /
    601                                 (double)(phantom_timing->pix_clk_100hz * 100) * 1000000);
    602                 vblank_frame_us = (uint32_t)(vblank_timing->v_total * vblank_timing->h_total /
    603                                 (double)(vblank_timing->pix_clk_100hz * 100) * 1000000);
    604                 vblank_blank_us = (uint32_t)((vblank_timing->v_total - vblank_timing->v_addressable) * vblank_timing->h_total /
    605                                 (double)(vblank_timing->pix_clk_100hz * 100) * 1000000);
    606                 subvp_active_us = (uint32_t)(main_timing->v_addressable * main_timing->h_total /
    607                                 (double)(main_timing->pix_clk_100hz * 100) * 1000000);
    608                 max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
    609 
    610                 // Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
    611                 // and the max of (VBLANK blanking time, MALL region)
    612                 // TODO: Possibly add some margin (i.e. the below conditions should be [...] > X instead of [...] > 0)
--> 613                 if (subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion > 0)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
These variables are unsigned so this is testing if != 0 instead of > 0.

Claude went a bit crazy and made a bunch of unrelated changes and no one
reviewed it.  HashtagSadFace.  There is similar math in
dml2_svp_drr_schedulable() where the math is signed.  I asked ChatGPT's
cheapest model to review this and it said this was a bug.  AI Fight!

    614                         schedulable = true;
    615         }
    616         return schedulable;
    617 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
