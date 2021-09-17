Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55B7610C7
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C55B7610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E8A6EDA6;
	Fri, 17 Sep 2021 15:30:03 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1014E6ED95
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 15:30:01 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id 93so6630623qva.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KHwshkfOobpUiyWJGT/sc1wahk7nb4ZeHc0Yrl5d/XE=;
 b=POwr8Ra8WFfBSIMITD2RubEZl7eQfdxtM2iafMf/fkRw/O+0FXSaT37UzJjFF6WEfY
 r/ZBrJdjRnRpamNC9aRJ1AE5ZJoSZE9Obu1M9D22mRc3d3BpvR/jtVTFwXIisu23LpFJ
 XEp9DzMqgBGkEUNDJVJE+6YIG7tSVb73g5w5svj0+P+FLbCtLlpMctxdT0U/eNwgyXnb
 2mgatcLE6eh+reSYTc3tuviRvzBcIVL1EiSNkOtKAdGurf/Y8jyfmW5/isZj5/RHXrfL
 ZbD/JWXYuzDApDVyj9fuAE+huZIcVgoKOl335Rq4RQYhkcxZ5YO7qEOulnJhbrJKy8Ri
 jVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KHwshkfOobpUiyWJGT/sc1wahk7nb4ZeHc0Yrl5d/XE=;
 b=dNz9ISA/qPikkv/R8KMxeOcDxamlofw7/xtbQXjD90FCgPdjmup1gwS4CC0dhvypYo
 mkGmrl6iU1/c94pDTCDo1BCqhJe2LGOvyvhVtvAh0/RBitGJx4zo2JwIR8cW5v2VoQmA
 TbBYlj0Pk9RSYleh1Vym1IUAsVHKnHUhCgDkWCWNo5BD8K05zIGr2iwFODqqbLN3HXGS
 1rHq+tCBcAgwhrKBHnih9ofVZxmQpJaIbcRdYqEdpgFrgiucsjsemw2Y0k3K5ZHKy0HF
 oxSPDK4KDTyWg+VuQ5zeg5u0wacAlidepVGsJ/Rv+F2GXbiqoqBcNrRGVeRLb0/yYFo3
 efog==
X-Gm-Message-State: AOAM531aKwb/6pUIBsdlXPH74auhqIAWLASCMq6CcE8rl6YgBuDq6DDe
 4s9NtizxOMKkQ6mO+/noUnlAmQ==
X-Google-Smtp-Source: ABdhPJxcvW7W0tARlYdMMJe31mvKvNKzlAuHtXTRLEKdzmQR28z2qSx8xt0LJQWOFiPpYF3QvOWqdw==
X-Received: by 2002:a0c:dc12:: with SMTP id s18mr11664646qvk.67.1631892600201; 
 Fri, 17 Sep 2021 08:30:00 -0700 (PDT)
Received: from localhost ([167.100.64.199])
 by smtp.gmail.com with ESMTPSA id s10sm4855841qko.134.2021.09.17.08.29.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Sep 2021 08:29:59 -0700 (PDT)
Date: Fri, 17 Sep 2021 11:29:58 -0400
From: Sean Paul <sean@poorly.run>
To: Fernando Ramos <greenfoo@u92.eu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sean@poorly.run, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH 03/15] dmr/msm: cleanup: drm_modeset_lock_all_ctx() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <20210917152958.GB2515@art_vandelay>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-4-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916211552.33490-4-greenfoo@u92.eu>
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

On Thu, Sep 16, 2021 at 11:15:40PM +0200, Fernando Ramos wrote:
> As requested in Documentation/gpu/todo.rst, replace the boilerplate code
> surrounding drm_modeset_lock_all_ctx() with DRM_MODESET_LOCK_ALL_BEGIN()
> and DRM_MODESET_LOCK_ALL_END()
> 

With the subject fixed (s/dmr/drm/),

Reviewed-by: Sean Paul <sean@poorly.run>

> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> index cabe15190ec1..c83db90b0e02 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> @@ -99,20 +99,18 @@ static void msm_disp_capture_atomic_state(struct msm_disp_state *disp_state)
>  {
>  	struct drm_device *ddev;
>  	struct drm_modeset_acquire_ctx ctx;
> +	int ret;
>  
>  	disp_state->timestamp = ktime_get();
>  
>  	ddev = disp_state->drm_dev;
>  
> -	drm_modeset_acquire_init(&ctx, 0);
> -
> -	while (drm_modeset_lock_all_ctx(ddev, &ctx) != 0)
> -		drm_modeset_backoff(&ctx);
> +	DRM_MODESET_LOCK_ALL_BEGIN(ddev, ctx, 0, ret);
>  
>  	disp_state->atomic_state = drm_atomic_helper_duplicate_state(ddev,
>  			&ctx);
> -	drm_modeset_drop_locks(&ctx);
> -	drm_modeset_acquire_fini(&ctx);
> +
> +	DRM_MODESET_LOCK_ALL_END(ddev, ctx, ret);
>  }
>  
>  void msm_disp_snapshot_capture_state(struct msm_disp_state *disp_state)
> -- 
> 2.33.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
