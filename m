Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DC1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7994961164
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7994961164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF1F6EDE0;
	Fri, 17 Sep 2021 15:38:28 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879506EDD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 15:38:26 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id b64so18765754qkg.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eYZWVg2Fo/lgTFAWwDOCdDsCtgn1QSeKcFBATt6HycE=;
 b=RZLdBWyS1zzwyQ8AWr+TO8IbeXMrv4GkD9yrNwWLkEQyOyCXnDQ5fSKQPUD/s0MhKg
 xPGzOeolgoxijwXPYafTXoIFsWJ9ZH5uTwiUOZtfmRRxJKeuYfHYRs1uljQBg7frLMPl
 hB2KoXeC7zy3aDwmTGMjYb7uwpHrgGCEhCUQ/7gSX9y0P86eoYQ0TI2zxNcUCG+42qfH
 CtKDkpmjAilFtakfPBxyf9AXRN+ZAnLX1wMYZX67q6M6bZu0FdgAYrAwrrnr63xoZJHl
 LYjs5GJ8k/UC4yxHxh5Zup/joyt2tOBuMeI9RbWPPU2MQCpcRDe0jZNAiziMVYTANnTP
 cA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eYZWVg2Fo/lgTFAWwDOCdDsCtgn1QSeKcFBATt6HycE=;
 b=lo5xC9xOsxGRWtN3/FTBaYtvPifNZRWn15dkwd7bRwMZuADOhpZuG54N4EVTPSCxVk
 HhC3asybZSNNc2rGBL/GPkDpxY2hRMcP70fHH3NNimocNj51R15puzV3yV/JzMv/6dPB
 tWdC963V3pZPnVuf9gEJPiX9Wywb2cyi7/KXRP7rQg7xg4CrDDzmXrnsbeOEg81Qdq8z
 d/FJSagt1V2Vs1U3YJQZoRiimgoqqPBxyMQR334FXGuJtGNk3mKnLvXDH71shSm1SNsS
 Esa+da70WCKYguaWTHrJlxve0STldSmxZAfhEUrnpfhTFPQ0Bzmg/cLnvj7XjPSQcK0o
 Yeyw==
X-Gm-Message-State: AOAM532AL6cnAy6Zbw/deAlRMprFeg5rYgyEx9RxcyblVS/wavt0kFO8
 VORmdwzxKNnuXF+RtGJ53cls7w==
X-Google-Smtp-Source: ABdhPJy+sgrVHk4mPzMJ5HeDnAsFrNLkiNzTwH7QjEt5wPfTDeXlC4CDkLSMrSghu4zxd6CNGrA38A==
X-Received: by 2002:a05:620a:1397:: with SMTP id
 k23mr11014086qki.380.1631893105758; 
 Fri, 17 Sep 2021 08:38:25 -0700 (PDT)
Received: from localhost ([167.100.64.199])
 by smtp.gmail.com with ESMTPSA id t194sm5357503qka.72.2021.09.17.08.38.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Sep 2021 08:38:25 -0700 (PDT)
Date: Fri, 17 Sep 2021 11:38:24 -0400
From: Sean Paul <sean@poorly.run>
To: Fernando Ramos <greenfoo@u92.eu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sean@poorly.run, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH 07/15] drm/shmobile: cleanup: drm_modeset_lock_all() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <20210917153824.GG2515@art_vandelay>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-8-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916211552.33490-8-greenfoo@u92.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 16, 2021 at 11:15:44PM +0200, Fernando Ramos wrote:
> As requested in Documentation/gpu/todo.rst, replace driver calls to
> drm_modeset_lock_all() with DRM_MODESET_LOCK_ALL_BEGIN() and
> DRM_MODESET_LOCK_ALL_END()
> 
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> index 7db01904d18d..8ee215ab614e 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -156,10 +156,12 @@ static int shmob_drm_pm_suspend(struct device *dev)
>  static int shmob_drm_pm_resume(struct device *dev)
>  {
>  	struct shmob_drm_device *sdev = dev_get_drvdata(dev);
> +	struct drm_modeset_acquire_ctx ctx;
> +	int ret;
>  
> -	drm_modeset_lock_all(sdev->ddev);
> +	DRM_MODESET_LOCK_ALL_BEGIN(sdev->ddev, ctx, 0, ret);
>  	shmob_drm_crtc_resume(&sdev->crtc);
> -	drm_modeset_unlock_all(sdev->ddev);
> +	DRM_MODESET_LOCK_ALL_END(sdev->ddev, ctx, ret);
>  
>  	drm_kms_helper_poll_enable(sdev->ddev);
>  	return 0;
> -- 
> 2.33.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
