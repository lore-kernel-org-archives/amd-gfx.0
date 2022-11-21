Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3189FC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 17:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872E910E319;
	Mon, 21 Nov 2022 17:26:50 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23F910E318
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 17:26:44 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-142612a5454so13822472fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQ/hCjkJQKqu4Xd8zX23UuIjYEWTks5LiyE7cTZ9IHw=;
 b=QpIC9S7KOBrNI2T6mK25PflWSNKlQcYKX9hj7skjf9EwNM4RFL7Wt1MDTq+8uPKlEc
 N6QgYqfJI930+82kHfaqqcpEGEAUHCRyHuBJmu5t5p7l6v++iWyc40VGLeGfSxCMoQlc
 YAX3kNmJl6cHLZzrMyxzAJwBFeIlmUIR0MPyIH0WA203WH2PE4JVY1Z0Idumz9Mq2Drq
 DfiJmlH4TilDgX/M31uqSDpGa3H+GE8xyuaHzIt/NpcwhuL93uc1IcPBA7yJM11QucVD
 1aLuybjUifAhW5e8ckpyQV8/FW4TmZ4D/ofAoiwttfFq9bruzfEGUbqCR1Ylas24nUhJ
 BYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQ/hCjkJQKqu4Xd8zX23UuIjYEWTks5LiyE7cTZ9IHw=;
 b=pe1q56tgR0mmFV6hi/aEMqPIg6PI1+y/vvR2/dlKjG/HV0iCWknH1o67uQdBk4WsmD
 9rXDCvzjFRYDfA52MiavM9VgGbAVoTDZ79moeeXytRgcVCMoaXyw8THNvccnXIGN7VOA
 ZiJNg5ELRc//UjXUynw34SSBzz7iiHu6q0yHotfiD6H52+GfAL3CJv5pfiF+Xst6ECOR
 SglRPEjQ7/b017MZO+fgPMiIDPw2m8zcvnDU48pYiyR9yLOzP2aK/yjVShqEHGJvMxuH
 O/2M3zMUKxXXZXTzDgLBlWkorD1HQPbvz75h+qn3zzmFOY43J1lIInRQhCzYhItnIFM/
 95sA==
X-Gm-Message-State: ANoB5pl3QyZP81DQloGNi1C4gjs9BmPps1CTN5pQiUltNE9pmxJjQQyh
 0j8vG38E7tbmSjPW55nfOXUkjithvRCcfcoXaw8=
X-Google-Smtp-Source: AA0mqf5orC5CEZl4gJt+jLOowOapB4F12FMLkBPdVi1QFo7ivMtwrkaxwzhdCOOqAyCldlu4I0z25Dqwz0ChMt1hJuc=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr1048679oab.46.1669051604133; Mon, 21
 Nov 2022 09:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20221117144933.1218097-1-alexander.deucher@amd.com>
In-Reply-To: <20221117144933.1218097-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Nov 2022 12:26:32 -0500
Message-ID: <CADnq5_Pcvp2Ftt6kGXuCbub6_kraxURV_WkpJN53_wuVFPeDMw@mail.gmail.com>
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

Ping?

On Thu, Nov 17, 2022 at 9:49 AM Alex Deucher <alexander.deucher@amd.com> wrote:
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
