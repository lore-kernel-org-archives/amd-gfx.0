Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEDAC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630662076E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqlbr0Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630662076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027D289F2E;
	Tue, 23 Jun 2020 16:51:17 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF30689E65;
 Tue, 23 Jun 2020 16:51:15 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g21so4013376wmg.0;
 Tue, 23 Jun 2020 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bg1C/maXc1yHDgyZ8N7KDhwmSTHqJRAHyYrqsJclewo=;
 b=mqlbr0HtalRaLV/mTAHk1BaZYRLajtzzuqOA2+xIlE7AFpAXzv6NUeqUeqKEUQlwLX
 l5zgIuas0ANzK8c/p/RVzTC8TwzZoJjhGuECNWqjYzxw2eUIHeaX19dSA6JsOFE7pzCd
 bZgOU/3pXAshIfBoutWFqGiniMWEyegzk+QZUs0G3s22hBkrCE0JIGhU8lmWLZh3mpMb
 TCJzyR+rCR7xtKssZCUDO1iE8cvoTbSTu12OfaEeVSGaQe5LilnfEZ9X2bAACBMwShMa
 K+KszQp30zSwChCOwZUwT1wzgpqRgLnHnd5PeO+xeLbJxAhePjlwb9yXjzsXOhL8SlPS
 g7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bg1C/maXc1yHDgyZ8N7KDhwmSTHqJRAHyYrqsJclewo=;
 b=DSJTGwDDAGD3Nen6VFoIBQC5ezo6PHWQC7CBLB091KdgiT0l09EK6SGisVnofJ7+4n
 YbZyVFE6RHDgNCtErX7wxPQRSnv3D7eBXZqemh5iKnDzpGRxpvNbGTVdZWXnAq1lOqmj
 EcXBlXh0oDB/JvdLKGnjPkGfDJJ9OS0ercS/pzK/cZEcvghhKoJlpCs7CfPY7pVuxIma
 BoqG5Wu/hY2KfZUdsik2d78V6e/PGSleg3wJ7Ok6Et4JUixjyrxyAHfOgCOu0Ix2M06z
 PYwiTDOphP3CBPYoVXYlf7/jugHv5dpi3u1lKYC3xCwgeX8Uuu5EzDr5paZ3Jw1P3k/+
 7H5g==
X-Gm-Message-State: AOAM532CHThja1OHmV6/K/ALbuqaaTNwrhKEuy/eFUbN5fKgs0DBColt
 bCS5Vv4kwf7zkl57O0YhoUF6mkb/oeuPijwqo2M=
X-Google-Smtp-Source: ABdhPJzXWe6A3dDxn3bWQEVxIsTa+qlEbGIxqOQmoCTQoQfdJpqdMBYbeYGxrWp7QJDkL5X7Bvoa+gqY9oAeDztKizQ=
X-Received: by 2002:a1c:3954:: with SMTP id g81mr11521140wma.73.1592931074567; 
 Tue, 23 Jun 2020 09:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200622203122.25749-1-efremov@linux.com>
In-Reply-To: <20200622203122.25749-1-efremov@linux.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Jun 2020 12:51:03 -0400
Message-ID: <CADnq5_MK=DmiP4Y_AkEX3RL6dLDdoMOkyEYfrSu6H3OCE9jh+w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix fb_div check in ni_init_smc_spll_table()
To: Denis Efremov <efremov@linux.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 22, 2020 at 5:56 PM Denis Efremov <efremov@linux.com> wrote:
>
> clk_s is checked twice in a row in ni_init_smc_spll_table().
> fb_div should be checked instead.
>
> Fixes: 69e0b57a91ad ("drm/radeon/kms: add dpm support for cayman (v5)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/ni_dpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
> index b57c37ddd164..c7fbb7932f37 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.c
> +++ b/drivers/gpu/drm/radeon/ni_dpm.c
> @@ -2127,7 +2127,7 @@ static int ni_init_smc_spll_table(struct radeon_device *rdev)
>                 if (clk_s & ~(SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_SHIFT))
>                         ret = -EINVAL;
>
> -               if (clk_s & ~(SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_SHIFT))
> +               if (fb_div & ~(SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_SHIFT))
>                         ret = -EINVAL;
>
>                 if (clk_v & ~(SMC_NISLANDS_SPLL_DIV_TABLE_CLKV_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_CLKV_SHIFT))
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
