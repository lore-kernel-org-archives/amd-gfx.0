Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CFCC56201
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 16:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABD122253
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 16:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URGXJbmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABD122253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6C66E939;
	Fri, 20 Nov 2020 16:06:44 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E446E939
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 16:06:43 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p8so10568925wrx.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 08:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/O+G2SluDRwSSbsPYW6ZL4PSWRxzPFHwd23SXQ6Uqn0=;
 b=URGXJbmLtZjMGTFfTSLv7faLZDhgkGFCIHqY/QMovqaYBidWJjW/tAjzE5ueEoVnwL
 UFKLY2F79LCYWwRfzI/98h267yF/TOSyuLedNwbUAqv+xrbZOCBLEYcyVuUhHbhg/U7v
 HA1INvWyHn007lG4BNHMu8vK3MbRpaeSl8axGPuhoMibh4e1VedeXWAaHSq0KLUNqT9j
 qpYQxQ2JZ2BZSvYN4ajnfgKk7CV6XLobb5kLbQFpE1yAsa1cmz15XYksZxWFB/kBT3RA
 GOno4K6nR7t9UuMejswJDEJ7w6WE2/YW82HqsIFp/Rjqq1GB4N+DXCvvWfcLzkiCc1Sz
 WcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/O+G2SluDRwSSbsPYW6ZL4PSWRxzPFHwd23SXQ6Uqn0=;
 b=G6BWJpvN8w7WoeHCDQmnc4SPF1y/GDo7hL7aVmtwkG0R1YHGkuEf62RqjY3XHjx9N5
 3Z2TWHkNIBaW0CwnJh2tI/lbuyVr7iCKUW5pr0yeYMcHaZQOkl2F/xT3b9BMnxg5F6vw
 whoRuUpcm/wE2YJjaAIiSaLN7frOc/CoIye/tNTe79TA449DXfNF3L3V1+8iNEVB7Fll
 deEwsqQLB1I+zaoUufGpBEHAK2UWCvQUX5UlWE+yI/06rymIqq8KcscXZcWpggs4T4To
 0JESuQHrYeyFrGWj24p47DYYqNBG8+z3/Ge/TKy1alS36ZXT5UztYZrinY7OTjdhItzY
 +X6g==
X-Gm-Message-State: AOAM530Dl5vKKS53DSMPQPmUUpiJWf/KBfDLvmRxW6uWJvMqEm4nEN7p
 tZJxuHsPh9wyNO/i6bhxqEqpjA0kEhOPNmpsRBU=
X-Google-Smtp-Source: ABdhPJxUaPTOP21I6PC3TsAO0LdMnQWPPpsJMJ+sYCFlaMnZsXh/jeO3xSnCTsgBBzukm0qJ5PZJOuGAODfi58+JY9A=
X-Received: by 2002:adf:8028:: with SMTP id 37mr16593963wrk.111.1605888402248; 
 Fri, 20 Nov 2020 08:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20201120160412.48148-1-nirmoy.das@amd.com>
 <20201120160412.48148-2-nirmoy.das@amd.com>
In-Reply-To: <20201120160412.48148-2-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Nov 2020 11:06:30 -0500
Message-ID: <CADnq5_PPJTaJb4Xeg4KYsm5=ZRbbkSp1fRRMwS_QZezgi0viLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: use generic DMA API
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Nov 20, 2020 at 11:04 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> Use generic DMA api instead of bus-specific API.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 7f384ffe848a..a5588b0a454c 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -784,9 +784,9 @@ int radeon_dummy_page_init(struct radeon_device *rdev)
>         rdev->dummy_page.page = alloc_page(GFP_DMA32 | GFP_KERNEL | __GFP_ZERO);
>         if (rdev->dummy_page.page == NULL)
>                 return -ENOMEM;
> -       rdev->dummy_page.addr = pci_map_page(rdev->pdev, rdev->dummy_page.page,
> +       rdev->dummy_page.addr = dma_map_page(&rdev->pdev->dev, rdev->dummy_page.page,
>                                         0, PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> -       if (pci_dma_mapping_error(rdev->pdev, rdev->dummy_page.addr)) {
> +       if (dma_mapping_error(&rdev->pdev->dev, rdev->dummy_page.addr)) {
>                 dev_err(&rdev->pdev->dev, "Failed to DMA MAP the dummy page\n");
>                 __free_page(rdev->dummy_page.page);
>                 rdev->dummy_page.page = NULL;
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
