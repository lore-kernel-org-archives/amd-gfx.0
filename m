Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB45C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B0D61090
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1B0D61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A402A6E081;
	Tue,  7 Sep 2021 17:07:58 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AAF6E07B;
 Tue,  7 Sep 2021 17:07:57 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id c79so13607972oib.11;
 Tue, 07 Sep 2021 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j29s6jGrbvtqdrpQkBZYVbTtCf9huBsKw7LAbvekqDc=;
 b=nDMbNZ9NrJI9JSLW4JBrEP3rhrTxiskApiLwhzzTBbw5bocGu3rATpSH8lOsAtCzDt
 W/yn8TNRiS/m2IlUqXDwnBFLGQNjqQsN0ff+91/df3BdpAD3K4X7YOdGM7jflgceOraf
 BFbs2tPYxzpM659Jv0vfxdHIpknDE1S70pQLxltO1wBUipwGBJ8RUjuILAfeZBqOZx7O
 HZHfkrp/QDtLwuztS84UXn+fNKToFEYfHNNUeKQgt9UrdFHqFT8TFBauVzEbe8hzTbCi
 ScEFd0qnqeBrirpapDinhjvUm9oQNA3Jk9U2mlMZyl5jHIdyjrQTwbYD+U+4OungicxA
 UXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j29s6jGrbvtqdrpQkBZYVbTtCf9huBsKw7LAbvekqDc=;
 b=LTpHeB3e1kGekDCQU5WIS/CQ0IxlIwbRrYrv19aZrn/BU0tUfGShIguiGoqrAfFYS/
 G53O5eJfFPA867tWmxtknlB8ohpU8ShNGYgkTucQDbKNsz/83gaO2wWSnNEGL/QvjHnL
 eEfS38/EHraO3qxPtZ785+MEFzN6Fu7bmbm7g6UFAZx4oDxJ0ppRku8O2C9rvj4pjKjH
 YSZnlP2Fb4ovBw58sREwfvG+a8dPzQjGQ/1xld6ydHCphYZZqZGU5/lhW0vBZTUMTgZr
 BML2xU2emFPpolj1IM2T6duTZfZ2DFDn0vif3xsxFcEfHeIziDw9NUQbmnJkbaLoDgYJ
 xfyg==
X-Gm-Message-State: AOAM5318SWXR0TxNsq0eEJD6Z672um3ovyndBVUXsRhd9GAj/DnYLxvj
 LNJAg3pa0MorJS3y2AZruKDdipi2/cH4fWC9/YejpGil
X-Google-Smtp-Source: ABdhPJyQD705JieHy8nmaQuvlsZIWn9W+PazsyLzS41xNVIzxnVtMdvH/weyFa3QYZ0PrVCTGvsf9XM9fY9Sh0UpMUI=
X-Received: by 2002:a05:6808:1310:: with SMTP id
 y16mr3749150oiv.123.1631034476551; 
 Tue, 07 Sep 2021 10:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <1630920208-37789-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1630920208-37789-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Sep 2021 13:07:45 -0400
Message-ID: <CADnq5_NNTmyPs4KL1LgaZntAurjm1vx_m9UH95tMOkojCAtLxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix warning comparing pointer to 0
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, Dave Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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

On Mon, Sep 6, 2021 at 5:23 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>
> Fix the following coccicheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:643:35-36:
> WARNING comparing pointer to 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> index 4a4894e..15491e3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> @@ -640,7 +640,7 @@ void dcn31_clk_mgr_construct(
>                                 sizeof(struct dcn31_watermarks),
>                                 &clk_mgr->smu_wm_set.mc_address.quad_part);
>
> -       if (clk_mgr->smu_wm_set.wm_set == 0) {
> +       if (!clk_mgr->smu_wm_set.wm_set) {
>                 clk_mgr->smu_wm_set.wm_set = &dummy_wms;
>                 clk_mgr->smu_wm_set.mc_address.quad_part = 0;
>         }
> --
> 1.8.3.1
>
