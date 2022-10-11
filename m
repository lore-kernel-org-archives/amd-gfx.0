Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0037CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 17:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4698D10E98A;
	Tue, 11 Oct 2022 17:37:51 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C1210E981
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 17:37:48 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id l5so16634429oif.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SwegHwqxbAThJG6XWfVepnm6pt7rZUYTNuZ6kky35wk=;
 b=O9Mn2x2aRTltALQ1pOjn3xE9WqflEkVyQ9vS2lZSp74uZY61lhQ8yT2cxR2R4KYpv5
 rA8n4iz4/AaBPPhK1nPJESphYE78S7El8o+IYtLK25gkz81bNsrzYRMgAJ1oT0v3tIiI
 OIxOJnARDb0mNsT5Yffdp+Rs6jkqec1VHRJiFzFvqifm/hTjqsm/ufxLVVVBuNpAPxQW
 YMOGk3zlqbRNKaPCF2taLg72080tYCHFhYyrtm4OhZmewU4B0M8fAg5CxMxlm83kZ/Cf
 45QqzKhwaAKDyf2thipcP4NjssJfZfXY/pgertxlSEr4hV6xU6saz2A6dAPTF8NpG59I
 6Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SwegHwqxbAThJG6XWfVepnm6pt7rZUYTNuZ6kky35wk=;
 b=qD/6opl9AAyHI3f6Zbe6PkEuIfMoTdZNQl2Z2LBuDzhy/HVT3SOVmFRUeb5j8xtAo1
 POViD4s2ElHXKJy6ORhB2w5FY0Z98mZGiKD3Ghg07h/E0PudEFZlkY4LN3vWz6eUOp26
 CGwvC4Q7NUSf6idtyc98xy7+GV6gVINLPzbzXEnY6fr70TzRcJgU8vaxh12n4QkjTkvJ
 /RvrMwd6eMzgPJV8HNM+Hbxfde/SDZtr9CInWgoGD0/cCUhM+/Infk6Y0pm47l1H2KE6
 0ZH4zuZi/diLhJyhm7bD7WYlZ21Cend730epaZubbFOB4rK6/Er6ln7pc3QOGquAkqw/
 dftw==
X-Gm-Message-State: ACrzQf2rEgwGfZUT6n31Z9ShjRDD6jNF/+Sde//lQ6I/yV9DP4DlJDBq
 AkTOamFyFUQ/DK5X5wVApwea+zIIZxuv/PLu0njdC7Gc
X-Google-Smtp-Source: AMsMyM77EmvqJtJMxV53dT1OGryLI4kdKSvPoSaIKfUoWJy3BaSM1ao4HfAQIUqRYnzpRffjTKviPu3SgK4+DLESl/Q=
X-Received: by 2002:a05:6808:2194:b0:350:cb3d:ecd2 with SMTP id
 be20-20020a056808219400b00350cb3decd2mr146962oib.46.1665509867519; Tue, 11
 Oct 2022 10:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221011173124.89534-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221011173124.89534-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Oct 2022 13:37:36 -0400
Message-ID: <CADnq5_NwBAgFkqRqV6ECC3DeGbeCztYDG1=B=VUdme7x+iWbJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add HUBP surface flip interrupt handler
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 11, 2022 at 1:32 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
>
> Add the hubp surface flip handler. This fixes some flip timeout issues.
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
> index f4b901d393eb..ac1c6458dd55 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
> @@ -181,6 +181,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
>         .hubp_init = hubp3_init,
>         .set_unbounded_requesting = hubp31_set_unbounded_requesting,
>         .hubp_soft_reset = hubp31_soft_reset,
> +       .hubp_set_flip_int = hubp1_set_flip_int,
>         .hubp_in_blank = hubp1_in_blank,
>         .hubp_update_force_pstate_disallow = hubp32_update_force_pstate_disallow,
>         .phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
> --
> 2.35.1
>
