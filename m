Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C7C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 20:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5192E6101E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 20:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5192E6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F936E1B3;
	Wed, 11 Aug 2021 20:22:57 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FD06E1B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 20:22:55 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id bj40so6472884oib.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a3m2MbIg4sEtXv9avuG1e6MFNGV4pylFXHp2blr5HGs=;
 b=mvBcFhwE4msJxyvh+Lpg/MzkzHEniqhpMktGxuvh2PqdfUNoNChTOAUB+Do6FMFa9o
 nvonslaOXNTDNLnjxaNVflUfJyiCp5ANkqJxbQhUjtZcwKfg0PkxFRJG1PcpsaCoRcqU
 qrXhymtefLERQPKEY1QHSYWwW6TR+29zQBIpQM9Jsb5L3JIcD9OkASZQ0bb4xHBdekh/
 ZbLfS0+qOreUzUcVtUQf7DLZ2MyQQtctb7O25GNJeX2La46w4yyfwgVT6DGqBvHb0qJL
 /QDZFZrTKbrG8aMXURKMbxsHxyYMaW3o/9Gp1uKiWWQmfs6yT8Pe/7Er94RXeD+/ilN0
 BajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a3m2MbIg4sEtXv9avuG1e6MFNGV4pylFXHp2blr5HGs=;
 b=edYd3eRdAXpxtf8C/GETXoIxen7IfaGDcxVfCFeLrJVPO2rs/SjXFL+HKZfnfiEKac
 G8CdL2BcR5/gQPSOrzrD9dH0/lUdlP11wWQtUDI44TCXCVtew8vH3bSrVYVQkmkI7TIX
 dDanIzrMjgF3oDzXFVhOjkTcC7IXV54p910T/COakEesakpuTZ4D+SnV0mZT6Qm8evta
 KlJpBrz0laXw0aPsI4fjE+/8fUVWvAFtk9RsdUh4LXo/WaKcdHRuG2gr9mdYvHto1xii
 3bMeNRP9pmwkRww58CML4Tk2BNQYGiR6o0gPg1CXigy3Bf69FaQWDdCjvN9hn8z2eiKJ
 5aWA==
X-Gm-Message-State: AOAM5306Qq+6cqZcGcKTSIz3Q6X4dMH0BxucekoBdNxgkS9ix/Rd4T6X
 y0euGsdh7ITyTvfIHtq4e02x/IPdMQPRaLwTzfI=
X-Google-Smtp-Source: ABdhPJxFYzZ8ErMHCygZtk1YftmNqV0Q/q1318TX8HlLsGnqmJ9cb1kzJZoSWL2MuAFN6878piIrIbOHERHrZek5QnM=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr514189oiw.123.1628713374507; 
 Wed, 11 Aug 2021 13:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210811040703.4770-1-islituo@gmail.com>
In-Reply-To: <20210811040703.4770-1-islituo@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Aug 2021 16:22:43 -0400
Message-ID: <CADnq5_PrtAn88+Yq2UcpTu7B6N_rxQJDeLSLD+KxT3mr_AZL0w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/display: fix possible null-pointer dereference in
 dcn10_set_clock()
To: Tuo Li <islituo@gmail.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, Dave Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 Jun Lei <Jun.Lei@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, 
 Eryk Brol <eryk.brol@amd.com>, "Cyr, Aric" <aric.cyr@amd.com>, 
 Vladimir Stempen <vladimir.stempen@amd.com>, Alvin Lee <alvin.lee2@amd.com>, 
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Isabel Zhang <isabel.zhang@amd.com>, 
 Sung Lee <sung.lee@amd.com>, Samson Tam <Samson.Tam@amd.com>,
 Paul Hsieh <paul.hsieh@amd.com>, 
 Wyatt Wood <wyatt.wood@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Jia-Ju Bai <baijiaju1990@gmail.com>, TOTE Robot <oslab@tsinghua.edu.cn>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Aug 11, 2021 at 9:46 AM Tuo Li <islituo@gmail.com> wrote:
>
> The variable dc->clk_mgr is checked in:
>   if (dc->clk_mgr && dc->clk_mgr->funcs->get_clock)
>
> This indicates dc->clk_mgr can be NULL.
> However, it is dereferenced in:
>     if (!dc->clk_mgr->funcs->get_clock)
>
> To fix this null-pointer dereference, check dc->clk_mgr and the function
> pointer dc->clk_mgr->funcs->get_clock earlier, and return if one of them
> is NULL.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v2:
> * Move the check of function pointer dc->clk_mgr->funcs->get_clock earlier
> and return if it is NULL.
>   Thank Chen, Guchun for helpful advice.
> ---
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index c545eddabdcc..03e1c643502e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -3631,13 +3631,12 @@ enum dc_status dcn10_set_clock(struct dc *dc,
>         struct dc_clock_config clock_cfg = {0};
>         struct dc_clocks *current_clocks = &context->bw_ctx.bw.dcn.clk;
>
> -       if (dc->clk_mgr && dc->clk_mgr->funcs->get_clock)
> -                               dc->clk_mgr->funcs->get_clock(dc->clk_mgr,
> -                                               context, clock_type, &clock_cfg);
> -
> -       if (!dc->clk_mgr->funcs->get_clock)
> +       if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_clock)
>                 return DC_FAIL_UNSUPPORTED_1;
>
> +       dc->clk_mgr->funcs->get_clock(dc->clk_mgr,
> +               context, clock_type, &clock_cfg);
> +
>         if (clk_khz > clock_cfg.max_clock_khz)
>                 return DC_FAIL_CLK_EXCEED_MAX;
>
> @@ -3655,7 +3654,7 @@ enum dc_status dcn10_set_clock(struct dc *dc,
>         else
>                 return DC_ERROR_UNEXPECTED;
>
> -       if (dc->clk_mgr && dc->clk_mgr->funcs->update_clocks)
> +       if (dc->clk_mgr->funcs->update_clocks)
>                                 dc->clk_mgr->funcs->update_clocks(dc->clk_mgr,
>                                 context, true);
>         return DC_OK;
> --
> 2.25.1
>
