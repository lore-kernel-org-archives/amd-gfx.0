Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2368C4321E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B5B611C4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70B5B611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46CB6EDA3;
	Fri, 17 Sep 2021 15:31:06 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E2E6ED9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 15:31:05 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id 2so9094496qtw.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7X1afZ73VKSyODOmfKxOaEasFjcfN4b6MQLd6Hy3k8E=;
 b=Er3xcMkHW0Vd5RfakskLkNxvu6I+CSGw4v7JtnwtV+IUFBr19q+6slAsRatI7PbFTk
 9VT0CMP4hPoWeZ4JgRzCV0XT7vaF8r3bSRZpgo4kIx8hyzfrvkC5Z/s2W8EOpwNmpDgS
 qEzdPEH8KT1m1/62h3M4j1Zc05hlau/qAgt2dIQqae+jvCXHdW+u2wR5hKU2lTgc1ZvP
 3zYIBGcvDAN/C9kDi+ykBi/zazwH7XO9UxyVj3zG33fT06KJelUzUlO+R2WacTqIYyB0
 aL3EkSwp5VDt6wJ7COgzOzgrGhpDskS57wTQ38WZouFAtyJtEdQf78lov2eDmfFmFhZV
 HwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7X1afZ73VKSyODOmfKxOaEasFjcfN4b6MQLd6Hy3k8E=;
 b=A6NwbAlpsUYC2frkJXw1RQsoDml6WqtiIk4CbQ3+2WRJ2yrehGPWUl/UjavIdjfnA9
 RnqEx1Zl5akNKgqenLOQXvIYeIADPDMBMwr9yBgFkBvDjB71hRQ8OiXap2vu6dD8QSJM
 MSBJSowkwr3oRvjs5BmtbhJZ/ZvyaTo/9fsXU8JjcsPPOZsawCpNCxJ+ZeKUo9vs8u7F
 XGSSRxPx4SKSvvqKcF1Y6Xmh6zujFEAOtDrBaiIHhNNEOsBrWeb1V69qA48W4vU97+qV
 eedSNMlfFHiQNJxuWET1TK8y/sowUu06svdeuqFX768Yvt+nu/EXOmQtX2NguiSemM1m
 DEJw==
X-Gm-Message-State: AOAM530/+pjla/DJMFztgUxjjNM9j27Hh727BLNuOSkP1LK9LosvaNlN
 WvOSY9vyXV1jgvtaBGc1ykwU7g==
X-Google-Smtp-Source: ABdhPJwjahZ1TqeH62g039cRCxfBYrWcC+lhlSDSdnE4I9J7ju+z6wB1QZ8H/+6isc91rxEeD3ZpcQ==
X-Received: by 2002:ac8:7cb:: with SMTP id m11mr11330316qth.72.1631892664440; 
 Fri, 17 Sep 2021 08:31:04 -0700 (PDT)
Received: from localhost ([167.100.64.199])
 by smtp.gmail.com with ESMTPSA id 69sm5573766qke.55.2021.09.17.08.31.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Sep 2021 08:31:04 -0700 (PDT)
Date: Fri, 17 Sep 2021 11:31:02 -0400
From: Sean Paul <sean@poorly.run>
To: Fernando Ramos <greenfoo@u92.eu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sean@poorly.run, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH 02/15] dmr/i915: cleanup: drm_modeset_lock_all_ctx() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <20210917153102.GC2515@art_vandelay>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-3-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916211552.33490-3-greenfoo@u92.eu>
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

On Thu, Sep 16, 2021 at 11:15:39PM +0200, Fernando Ramos wrote:
> As requested in Documentation/gpu/todo.rst, replace the boilerplate code
> surrounding drm_modeset_lock_all_ctx() with DRM_MODESET_LOCK_ALL_BEGIN()
> and DRM_MODESET_LOCK_ALL_END()
> 

With the subject fixed (s/dmr/drm),

Reviewed-by: Sean Paul <sean@poorly.run>

> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 134a6acbd8fb..997a16e85c85 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -13476,22 +13476,13 @@ void intel_display_resume(struct drm_device *dev)
>  	if (state)
>  		state->acquire_ctx = &ctx;
>  
> -	drm_modeset_acquire_init(&ctx, 0);
> -
> -	while (1) {
> -		ret = drm_modeset_lock_all_ctx(dev, &ctx);
> -		if (ret != -EDEADLK)
> -			break;
> -
> -		drm_modeset_backoff(&ctx);
> -	}
> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>  
> -	if (!ret)
> -		ret = __intel_display_resume(dev, state, &ctx);
> +	ret = __intel_display_resume(dev, state, &ctx);
>  
>  	intel_enable_ipc(dev_priv);
> -	drm_modeset_drop_locks(&ctx);
> -	drm_modeset_acquire_fini(&ctx);
> +
> +	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
>  
>  	if (ret)
>  		drm_err(&dev_priv->drm,
> -- 
> 2.33.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
