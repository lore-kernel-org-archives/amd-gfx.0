Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A37C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C152082F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM9mKazj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C152082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC266E081;
	Wed, 12 Feb 2020 15:59:40 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF04B6E081
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 15:59:39 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c9so3009254wrw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 07:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QHMtCEoNUshqc/vb/DwAnyDU39prC7fsVBfLZjFikUA=;
 b=JM9mKazjLB0DD2tQT0ssPpN4whCte4GVTJ4ysfXKlbu9sumyxh2VVVQPXafkNYBMvu
 md7wAHznhV0yhq0jR9zQZOdnvRlh3srtsAB1yBOzVWy5q6KSFqkVxIqhsyVwLcEXnoPQ
 DjQhdcekyHi76nIGS9zRC6VyllrU9zIEQbWNTifzi6Ks18JAQndvWy04/BRbQoqNqViJ
 lPlGpZtUoEC++2pPeJM/JFCV4UqvYrEJLWIzGbOe0O26hVaT0NaNTb9mOfAtkluPQfgk
 cn4pMXzcQv5+U3qYvL74nRdhqsXLZOY+abI+ri1c05bWRioWFpjy3LNRPA8WK2WX0c8y
 WTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QHMtCEoNUshqc/vb/DwAnyDU39prC7fsVBfLZjFikUA=;
 b=dRM57cpWOR1Rf2oExYEgZ4NY3br6RtV2hCe75dCCKu81MT6kVrJSBwEvvkNot9bW+K
 CC9eDFmCqARzGRt787sD2+y2SqdDEFqt1K0e9zvpdVqyMmnAOlg3RoD9NGs2PTGdIbdF
 a9tNxYo5AiIGHu4GvPbwdfjnYPwb/Jcfdqz9p5XqYqGzQRkx2sXw4VCy3Bmfz3UvjZfw
 Mii8wsvGtFQoGNuyeHTlGj78jTXLD9pxD6qtbzDOmgbUp6dxVO5bRvLCAqu9E5wppKVE
 xwBT2cDTg/Acbgc7tiVp1UaAKZFp4JFG3OETBXdawQ1LU2+Nd9B08/K4BOQgH1TP5qAh
 C0lQ==
X-Gm-Message-State: APjAAAWY1Og8bptGOzDWqOYk3Mtb7shosq/fPooQefc22aHqH8Ha+Iro
 humWuHvP8/HpPJ5m43xWW6xJwIRL460aneMXG0HE6g==
X-Google-Smtp-Source: APXvYqzMkU2STXMKzkl1WODkGBL5NaIFDGB0tnnXpsltzwxW0vOC4qSW4oJzMkvJwNGUETsgYYWeNfYtbUugxSbzTcA=
X-Received: by 2002:adf:8b59:: with SMTP id v25mr16593172wra.419.1581523178595; 
 Wed, 12 Feb 2020 07:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20200212143928.6308-1-kent.russell@amd.com>
In-Reply-To: <20200212143928.6308-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2020 10:59:27 -0500
Message-ID: <CADnq5_PsCoLhdurYderUZsbTz+zBMVSq5Lh97RcpE0xZuXwuBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/powerplay: Ratelimit PP_ASSERT warnings
To: Kent Russell <kent.russell@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 12, 2020 at 9:39 AM Kent Russell <kent.russell@amd.com> wrote:
>
> In certain situations the message could be reported dozens-to-hundreds of
> times, based on how often the function is called.
> E.g. If MCLK DPM, any calls to get/set MCLK will result in a failure
> message, potentially flooding dmesg. Ratelimit the warnings to avoid
> this flood.
>
> Change-Id: Ib817fd9227e9ffec8f1ed18c5441cbb135bc413b
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/inc/pp_debug.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> index 822cd8b5bf90..cea65093b6ad 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> @@ -37,7 +37,7 @@
>  #define PP_ASSERT_WITH_CODE(cond, msg, code)   \
>         do {                                    \
>                 if (!(cond)) {                  \
> -                       pr_warn("%s\n", msg);   \
> +                       pr_warn_ratelimited("%s\n", msg);       \
>                         code;                   \
>                 }                               \
>         } while (0)
> @@ -45,7 +45,7 @@
>  #define PP_ASSERT(cond, msg)   \
>         do {                                    \
>                 if (!(cond)) {                  \
> -                       pr_warn("%s\n", msg);   \
> +                       pr_warn_ratelimited("%s\n", msg);       \
>                 }                               \
>         } while (0)
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
