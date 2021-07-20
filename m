Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACAFC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 13:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90222610D2
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 13:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90222610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D126E069;
	Tue, 20 Jul 2021 13:34:22 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92D86E069
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 13:34:20 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id r80so10738943oie.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RJyxclES43ElcjUdkXlGtDKBfmQc2t69hoGHk1FefN4=;
 b=SCqGY7X5jVwTrkAi/KLlL8DIAGebKALBGQ8gKzWPzZuFpkWRHs0G/+noCp66ymsO97
 jKhEF1n48vFRKFZNlyJDgTLcCto5yCqc6XU8z/ue9PIlbvho8kw96FHeueksb6MZkgQ2
 Rpk6WI6Ex4445T1+i92EPMTkRD8gT+lexw//lEZ/t+aXRN/lUjzsPMPY8fd8HXisyIIw
 LK0/pnVcn4DLTVob+PKfkNUM4HEsHEXDO9Mtyo5OV3Sy++NzD+FcU3TRdP8tViAR5Xi8
 7prstGIpGpe75QPqCy60JcXcplpXX6pY+iqkXbsc7ULZsjeiTzTgvA48rRZvuUIkmUPL
 mwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RJyxclES43ElcjUdkXlGtDKBfmQc2t69hoGHk1FefN4=;
 b=qI364AolvjvtrnkqVBfJ7KiRUpkxFsvAhSXkDrdpKhwCeHhvw9tejModD3XPIZN/2q
 zvu+9u7G38C1km5MpRDNVrdWZ3ri/2zQZrrpMmCNSBqlXZnLV5B/RuoNtY8JyIGtLa+I
 XOvr487eo5FJa1ohwL7e/MeNz3XmsFx36hsggkjPc38XIC2nOLgVaDOxGwD333rUAxfp
 LmxCWKeS82e1q9iDHmMroPTuUvPttuErxaXxHKSt2gxO83NJozBmDktVdbV43dn02ptc
 WAzDcKXviU5Yr6zHRnwg0pGBj6SUWwdN2JNwzecDYYe+yEKjigOw7QVfQZtzqVGhI05r
 cURg==
X-Gm-Message-State: AOAM533bh1CxFMIj3d/ZgijD06ARqwtX0i7Ki9gjm5R14jlOCK8QJsuG
 hj6v2mOOrVVEoHM0PWJ6t2igN9wfzqoX5jRgIVU=
X-Google-Smtp-Source: ABdhPJwMnSDn6B/Jt2lWiRrY6pfoSfwK7suMzXuMwTR9ak6Fq0zkMYSIKgTKrI5ZiA5Kji6eHE/IVD3+SzxZzkCibLU=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr5178171oiw.123.1626788060101; 
 Tue, 20 Jul 2021 06:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210720033317.686726-1-stylon.wang@amd.com>
 <20210720033317.686726-3-stylon.wang@amd.com>
In-Reply-To: <20210720033317.686726-3-stylon.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Jul 2021 09:34:07 -0400
Message-ID: <CADnq5_Pp4eriLdjT=1Bk=b1H22czzxcsSY1S=xHg_Axhnj_aVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix ASSR regression on embedded
 panels
To: Stylon Wang <stylon.wang@amd.com>
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
Cc: Eryk Brol <Eryk.Brol@amd.com>, "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Anson Jacob <Anson.Jacob@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 19, 2021 at 11:34 PM Stylon Wang <stylon.wang@amd.com> wrote:
>
> [Why]
> Regression found in some embedded panels traces back to the earliest
> upstreamed ASSR patch. The changed code flow are causing problems
> with some panels.
>
> [How]
> - Change ASSR enabling code while preserving original code flow
>   as much as possible
> - Simplify the code on guarding with internal display flag
>
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index cc62124b0b82..f56e061d35bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1811,8 +1811,7 @@ bool perform_link_training_with_retries(
>                                          */
>                                         panel_mode = DP_PANEL_MODE_DEFAULT;
>                                 }
> -                       } else
> -                               panel_mode = DP_PANEL_MODE_DEFAULT;
> +                       }
>                 }
>  #endif
>
> @@ -4643,7 +4642,10 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
>                 }
>         }
>
> -       if (link->dpcd_caps.panel_mode_edp) {
> +       if (link->dpcd_caps.panel_mode_edp &&
> +               (link->connector_signal == SIGNAL_TYPE_EDP ||
> +                (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
> +                 link->is_internal_display))) {
>                 return DP_PANEL_MODE_EDP;
>         }
>
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
