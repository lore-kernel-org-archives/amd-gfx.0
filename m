Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A31C7EE2E
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Jun 2023 14:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561DF10E02B;
	Sun, 11 Jun 2023 14:21:28 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F38F10E02B
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Jun 2023 14:21:26 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30e56fc9fd2so3289286f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Jun 2023 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1686493282; x=1689085282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gt81LkxSRKwqN5GsntJNctdmadeZwJBlj1zAtRHC19k=;
 b=gFHLKAdgOa2ayQfewlYuAfmwtcgxlqGX4UStauA4fpQwrcS3NxsoLATrWeUYCfpEH/
 5hfsNQfxEc66MJlSnhDYl2lGAPNZdlYXB0dgW3uEQzVh6rmzumD3X6PxNPmnU9Y1G7EV
 k+mGk3Gk3dTEOJBpr1M5tW9DZjHVu0d3K6euEYd5FuVuA9M/ZwASDX8cSAlvGTi2+dS5
 KvL6Q20o+qr1kMwqXNC7rLDROkghY5FkVQ98trFFrj5V7YCcI8wh4ttOZbOrxJnoPNhu
 NNtKvM6imh9bSyDR8nIPo98/Z/NglT95pFwcy8bOD5HYYue4YJuBYqOrkNIdTPTr8Zkz
 TBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686493282; x=1689085282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gt81LkxSRKwqN5GsntJNctdmadeZwJBlj1zAtRHC19k=;
 b=WowSFesIivriDeejnxFywsV3xbrjWuX7wil+vX9mevQJOdTWMkSJ4SrihaLybkEV42
 z4PwRoWib2gnFkGmjmlqaBzv33HkpnrJRP8+QTKRB+x2P+bFGgLD/QRMk3evxGwq0hgw
 m4ZpQNDIclqsS8Md1uBbVGWe8aCJxwKEc/70/dyfkcAGUoRidt3cDUFtupZ6ypf2KqIL
 /ZdxT7FBKhrnE50SM5ZcS3k2uY4ukCJtskuaUvP7Tf9GgFVhaH0J/uS2gku9ExCbm1sl
 wNMOIgQ2QV/DeA2XkGfxpgZszC+SmVicv615WBDhmBkfwq9QVTgvLcckkYQaYglahvvV
 +VVA==
X-Gm-Message-State: AC+VfDyXJ2UeYL7ndQcdytal9EvN81V7O35QA3DY0J2N8cbBdqrkw4WI
 tYk6PXzuVXM4JqOxlQdeg7NlktQ5aoaJ3UT8oFCyBw==
X-Google-Smtp-Source: ACHHUZ4ycK5xRTS/iTMNiWMOcLor/1ax6OIlWvJngtYU2WUAuExBI+NL47T4MZtfhClZ3jUuV+o/SSA4u4mFsTGAofY=
X-Received: by 2002:adf:f701:0:b0:30a:ea8a:7a6d with SMTP id
 r1-20020adff701000000b0030aea8a7a6dmr3177500wrp.16.1686493281684; Sun, 11 Jun
 2023 07:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
 <20230414155330.5215-62-Qingqing.Zhuo@amd.com>
In-Reply-To: <20230414155330.5215-62-Qingqing.Zhuo@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sun, 11 Jun 2023 15:21:10 +0100
Message-ID: <CAHbf0-EpMiJQtZ=LWKA=2G9YxiVfhaij8aAxMnJW11Gj6VY_kg@mail.gmail.com>
Subject: Re: [PATCH 61/66] drm/amd/display: fix dpms_off issue when disabling
 bios mode
To: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 Zhongwei <Zhongwei.Zhang@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

This gives me a blank screen when booting on my Ryzen 9 5900HX Laptop

03:00.0 Display controller [0380]: Advanced Micro Devices, Inc.
[AMD/ATI] Navi 22 [Radeon RX 6700/6700 XT/6750 XT / 6800M/6850M XT]
[1002:73df] (rev c3)
08:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series]
[1002:1638] (rev c4)

This is the second time this has been changed - the last time was back
in November, I'll happily help debug why this is breaking on my laptop
but I'd appreciate if this would be reverted and not reattempted until
the underlying issue is fixed

Cheers

Mike

On Fri, 14 Apr 2023 at 16:55, Qingqing Zhuo <Qingqing.Zhuo@amd.com> wrote:
>
> From: Zhongwei <Zhongwei.Zhang@amd.com>
>
> [Why]
> disable_vbios_mode_if_required() will set dpms_off to false during boot
> when pixel clk dismatches with driver requires. This will cause extra
> backlight on and off if OS call 2 times setmode.
>
> [How]
> Set dpms_off to true to keep power_off and let OS control backlight by
> display's powerState.
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 9304eb66a1af..238a13266ad8 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1268,7 +1268,7 @@ static void disable_vbios_mode_if_required(
>
>                                         if (pix_clk_100hz != requested_pix_clk_100hz) {
>                                                 dc->link_srv->set_dpms_off(pipe);
> -                                               pipe->stream->dpms_off = false;
> +                                               pipe->stream->dpms_off = true;
>                                         }
>                                 }
>                         }
> --
> 2.34.1
>
