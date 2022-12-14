Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA585C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F30A10E48A;
	Wed, 14 Dec 2022 20:48:48 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D3010E48A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:48:45 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1445ca00781so18296491fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 12:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uFqpz9/r62pDaqe48RgHZjPmYHC/JxDwIPnHKMBe/EE=;
 b=mX0cB5lGGTGZZhkLFbU6a20mxrQ7O5F5G6VTHPgpdon+4lqbK/fcFBmSFaht0OOyMC
 Ok6XMWApsQVCTm4D6jMKXK4Xyq7gQr+VcFY5FOF0dSciLihxJzC9FyvDcF4pURO7aQwt
 n9VnuSNssVJEbtsTDlXYCHu1k2ZoDu0ejRZInmA1ZS8H1vy8axaohXea2Y15+Z/sl2+U
 WIlRbrhSrNuUBCnwrIfx3Q3vifKUMfAa3Ezy7ypdFTyKyvnkFPe/ifnSQaBR6++epYjR
 wAd3sioox0x383wKu5Z7kPUTdY94ThSrpOLIP0DUxGn5JDZm3KX8jRX+9QsAfttEgjPF
 nMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFqpz9/r62pDaqe48RgHZjPmYHC/JxDwIPnHKMBe/EE=;
 b=X5Sq9Z8SKuhJPCiTYTZwc0fGXW2ohh94PIokx2lp+FFrW1llXmDF9qFYk+0Zpyg6WV
 yhJWd5pQff0MLJd1cUAI7LoMNtf1qZYA/wO5H4kw6V4XL4VUzlKzswuS+dLBUIGdsmiw
 Qs1hNdO3EgAuo1/DfqTOoaKtPWmWtITK+iLaRuBCOIefwdYbW72/7t7MdTXP6b93WN2p
 MJzeNp74sKVoI4N0EkhbGGUASkd/LKQbV7AnOsEL+PusnjNqy+eroHBMvzJx1tJnvXVI
 zUhuJMrygFvO8h+bUhD6ORG8oojJZk+6pnoB3alktRIt8lPVEACnETmvBIAzGs4SxQHN
 0dCQ==
X-Gm-Message-State: AFqh2krS9gjCzqxoMsYnktr3TIbOtgRyZtyz4F54pvVT+belzCE5XQIO
 7Dv9m11A27WQ6B116hHnTtsmE7bRIXf35j4PLJk=
X-Google-Smtp-Source: AMrXdXsx/YCHVAyUMcs1iSYd2HJWu8BXTiLk/3txdX52eU9tbkOLwZl/cg4ZEV8v+VVczHBC61zHOF2zTaEhM1KqSUA=
X-Received: by 2002:a05:6870:4687:b0:143:8a81:116c with SMTP id
 a7-20020a056870468700b001438a81116cmr405527oap.96.1671050925151; Wed, 14 Dec
 2022 12:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
In-Reply-To: <20221214202141.1721178-6-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Dec 2022 15:48:33 -0500
Message-ID: <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> From: Alex Hung <alex.hung@amd.com>
>
> [Why]
> When running IGT kms_bw test with DP monitor, some systems crash from
> msleep no matter how long or short the time is.
>
> [How]
> To replace msleep with mdelay.

Can you provide a bit more info about the crash?  A lot of platforms
don't support delay larger than 2-4ms so this change will generate
errors on ARM and possibly other platforms.

Alex

>
> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 913a1fe6b3da..e6251ccadb70 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
>                          * After output is idle pattern some sinks need time to recognize the stream
>                          * has changed or they enter protection state and hang.
>                          */
> -                       msleep(60);
> +                       mdelay(60);
>                 } else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
>                         if (!link->dc->config.edp_no_power_sequencing) {
>                                 /*
> --
> 2.39.0
>
