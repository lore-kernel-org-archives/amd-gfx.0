Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF4C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 14:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BCE22518
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 14:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BCE22518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B096E342;
	Tue, 15 Dec 2020 14:51:23 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C376E342;
 Tue, 15 Dec 2020 14:51:23 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id o11so19562973ote.4;
 Tue, 15 Dec 2020 06:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H0DMv/St3NqIUqqEhzUW0JjVVj9cnrE4Jv/Mn3i8+BQ=;
 b=Y1uPN1EWWchDXLF16HwOYZllLm+z8b8kgPh247aP1bEKMr0lzTVSD1Kawq3VWpTfik
 86oyL2c7ebaxTZM+bPv3dYlR5SM9sZXNougTWPTL5l1CIYrZrhCkCd5h8HVBV2WcTvFY
 4iZ9SwaGz1x1qUU9UZrbV/0mzCfgLqqwO3sONr0FURw1vrDardYkHIU5/DabijTMwFrO
 qmoZlMT6pihTdUWbBFMoxxA3L+Dql10+jgKDjQWkMBnj6APhr1JFamISwPAilVSmY9t2
 IVRCB1kUQHnm/KFX8iAu6rZA5jziQZeP5jgCq9AbjnxehxLqL2eYdVr6ej+qnH0PWN4x
 KDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H0DMv/St3NqIUqqEhzUW0JjVVj9cnrE4Jv/Mn3i8+BQ=;
 b=muhf0slJdylXj3Y0sx7QYGUvv83rDWS6Ne5oedN7U7xOdaH4j0khA6kteTIwZ8z2ki
 K9XOfSMoeXy987ol32I9CQ6kincNKgB97D8CSa97jbAQiRg6wVqISlaogd2iS1kGUjCA
 ZVa4ttYcPyLqpZvN2gh0N739Orybj+AvyOU1smmX/ME0UGiG8hKYPmKyMcYimVpuIrfb
 +fo4+h62Di1SApSq8EDGpsy2sEYXlvzDvH3L1bC7wg5xKTOpqHIHtMC5Dth6Bgq2M/9A
 aaQqriVXm8Odxt++cfXCYrZAw5bP2WWzoo0qPmhPagIbbqtHCzjrHvCVoQxVWKoaMyqv
 uKug==
X-Gm-Message-State: AOAM532nAqHvhf9fLatwDwu1aGE6lBDxOWHmvl3jNk/E6/hHfaSzSEXy
 Prw24613IxRhJUBq/aY5OKsW6hL8HIJpTKlDuls=
X-Google-Smtp-Source: ABdhPJwLVsjfgzc+RExdBVI/+RYvWYtptZozVV3ppwiUhcjKkD9kx1KH9rRorpvj1NtS6mo7tcQEss3dO6Q8jlOOlHQ=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr23521172otg.311.1608043882328; 
 Tue, 15 Dec 2020 06:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20201215105651.138391-1-colin.king@canonical.com>
In-Reply-To: <20201215105651.138391-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Dec 2020 09:51:11 -0500
Message-ID: <CADnq5_MtLo6SiWOSADwmTEr46gEfqC5Oj15Tj4TypGx8tsAoAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix spelling mistake "Heterogenous" ->
 "Heterogeneous"
To: Colin King <colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 15, 2020 at 5:56 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a comment in the Kconfig. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdkfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index b3672d10ea54..e8fb10c41f16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: MIT
>  #
> -# Heterogenous system architecture configuration
> +# Heterogeneous system architecture configuration
>  #
>
>  config HSA_AMD
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
