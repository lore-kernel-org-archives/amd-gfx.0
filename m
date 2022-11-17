Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD67C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 15:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3354E10E645;
	Thu, 17 Nov 2022 15:32:00 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502F410E635
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 15:31:56 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 ja4-20020a05600c556400b003cf6e77f89cso4852655wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OyeYfYnLgxx3kOgCrXxCQ6nAlhNev+KzqUOQFuLaihA=;
 b=Vomak3yoYEIqj/BRzdItHTLE8lusoSfucWuZEwYxgkSa9YfTHRbbkdqLdqRv3naB9G
 dxXwZhf/AfoA6atar1xzkd7VVO0dnfafZC+shfrCtkMEKZA9PiCurseFhvSKyy9oo3DZ
 +sQFy2rkKDyYFvUwjns74MNGsIu91ECCOrFB+U4b4V8HNAqB1Gg4KyNv4B+1iT3s04A8
 K2U3/3LE3ihp1Dm09tPRUcfzj68ApJcVzelWqpF8dGOlbW+JWuZ/So44PjvGHyOmipsz
 CCwuSatqTMer6r0Ll+F+fPVHySuiS1pP74iPqRop5FPLhoRfOR8zpQ4gzTKECs/u4Fgr
 6kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OyeYfYnLgxx3kOgCrXxCQ6nAlhNev+KzqUOQFuLaihA=;
 b=lXxSs6+MlOdByZfudV4HhdG76YfqVSUkSjz+RbTuzjxGaZI2wyHORPPsC62O0q8fgK
 QgXw+ZoW9ZQHYBI2WR+u3VIra+J1gPMpCxUdrc0rfu+U55k5A/uvpeyfEPvi8TZuEe8M
 IGDMVDOMxjrm2E5p8JHu8EIEK1116Lr4MMhqIxXaT3u48leUy5o3Du9YA6/tBN2Ku/z2
 4ok0uayDjdyjlK08LE/TwyLJyd2VoBS2+Mz5j5cPvDkfAsD2bxIHUffj9hmel2HKFP/U
 W9GmWHn+4IMmfLLEf7kn275UiixC8G/AboGrEXD8SOkS/ToiaWhZqQg/wxQjcs8ndn5D
 bsWA==
X-Gm-Message-State: ANoB5pnHNdTBuLivQ30my6J/vMdhm9Wtl5zzOMff4Y0N7pY3GV+quhm1
 dgW2HVKDrexhJKm5TGG/5v0oafbVyd+959NSjOwZihun+PLurw==
X-Google-Smtp-Source: AA0mqf5UAZrYugJ++1IfD9NhSplTuStumOYuhFNg36h7CyqCm0v8fcJE7aYG++dOsmYW1Pgopt0Hrb6+e8MXCs4q+K4=
X-Received: by 2002:a05:600c:47cf:b0:3cf:8051:47ae with SMTP id
 l15-20020a05600c47cf00b003cf805147aemr5709159wmo.24.1668699114667; Thu, 17
 Nov 2022 07:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20221117144933.1218097-1-alexander.deucher@amd.com>
In-Reply-To: <20221117144933.1218097-1-alexander.deucher@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 17 Nov 2022 14:31:44 +0000
Message-ID: <CAHbf0-GhMBLq=m7=cQHpGL=F6R680Sfx7THV7t8jYXCZwxyX1A@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: fix dpms_off issue when
 disabling bios mode"
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Zhongwei Zhang <Zhongwei.Zhang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 17 Nov 2022 at 14:49, Alex Deucher <alexander.deucher@amd.com> wrote:
>
> This reverts commit 5aa663752ff6f844c6bfc97d89231e98884ae769.
>
> This causes a blank screen on boot on an Asus G513QY / 6800M laptop.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2259
> Cc: Aric Cyr <Aric.Cyr@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 1c3de3a1671e..049ef31ebf69 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1192,7 +1192,7 @@ static void disable_vbios_mode_if_required(
>
>                                         if (pix_clk_100hz != requested_pix_clk_100hz) {
>                                                 core_link_disable_stream(pipe);
> -                                               pipe->stream->dpms_off = true;
> +                                               pipe->stream->dpms_off = false;
>                                         }
>                                 }
>                         }
> --
> 2.38.1
>

Thanks for the quick turn around. Feel free to add:

Tested-by: Mike Lothian <mike@fireburn.co.uk>
