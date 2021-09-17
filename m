Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D50BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CDD61212
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00CDD61212
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3396EDE1;
	Fri, 17 Sep 2021 15:41:01 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C076EDE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 15:41:00 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id c10so18671434qko.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G/b3XiXy0Sb8x2PtTRvVL/40239eORGz1ZL98EY1EC8=;
 b=fzPGLaz85DNSjT8BpuMHmKOqlTmjcQ0qE3xixhpENWlDBqA/2YO/GHW63weTUvqukt
 /hTvkY+SrTcPo885plyDeFM72/dI9tOCbng/4AcduL2xIMkCXnVtu7q+T7+a/dD51gTH
 L7gwVnqTw/HxFpzCGCbsHv4pnw4VgWgPaHdZVIoNesVklyEarxWWcfWZeFjT4RjtbAt0
 zKMyHOGfRmRVSf82T/XUmWcFRHrKWywI2DYIEWYrkh+TpOc6k/7I+sqzH4nT9t/FGY5F
 hAHLlOmKX+HDxFDYattoDa8cZNtr6c5DAixr6gOGgaZ9CCc1QkEkWDxuavEl/4geEn+l
 1U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G/b3XiXy0Sb8x2PtTRvVL/40239eORGz1ZL98EY1EC8=;
 b=bJuPVz9bK8bTCXRE7ZnDQE1Zdgzb3kIghC/fhJlgHs7sTaQJw1IpFMui2mbbWYtqAw
 XFPPACxrtn+iuAsEwPOSzvcv2OqDi95s35i6qZlFdP5jmYfX3K1ES5rmqhcvBTnVj70M
 9+5pXH1jRrVvgIylTAlbxm7sMFahRTH1Z8GDUnNi0PIVa1fx+lHCiePovMizhBx0jwnD
 WK3T0frBWagyRV7qZ71/gs5SMDEuZVSEyY/zni1FO0haU3z+aEmbQvnGbAZqvMQoIDq3
 rEtLWifFFRu545hWQz3gKkm2Vu+O+znmQXPr3WllK9j8EH6NTHXehI3byVrqeOa8yVav
 0llw==
X-Gm-Message-State: AOAM532XH9NbaDTAPDqab6g50Er9FX1k3Qb5Um4rFNem0ZoHCfq6GAjW
 YNo7OzZEzN++Gi/jeBaPKtnvEg==
X-Google-Smtp-Source: ABdhPJwEOXquIsSStFswyl2f30Mm94RU8fNeBCXsfk8xn7q1LDa0ztl6hhBn29sVtbQXy6Bzc6IuSA==
X-Received: by 2002:a37:9b93:: with SMTP id
 d141mr10910675qke.236.1631893259801; 
 Fri, 17 Sep 2021 08:40:59 -0700 (PDT)
Received: from localhost ([167.100.64.199])
 by smtp.gmail.com with ESMTPSA id l195sm3821941qke.98.2021.09.17.08.40.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Sep 2021 08:40:59 -0700 (PDT)
Date: Fri, 17 Sep 2021 11:40:57 -0400
From: Sean Paul <sean@poorly.run>
To: Fernando Ramos <greenfoo@u92.eu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sean@poorly.run, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH 09/15] drm/omapdrm: cleanup: drm_modeset_lock_all() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <20210917154057.GI2515@art_vandelay>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-10-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916211552.33490-10-greenfoo@u92.eu>
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

On Thu, Sep 16, 2021 at 11:15:46PM +0200, Fernando Ramos wrote:
> As requested in Documentation/gpu/todo.rst, replace driver calls to
> drm_modeset_lock_all() with DRM_MODESET_LOCK_ALL_BEGIN() and
> DRM_MODESET_LOCK_ALL_END()
> 
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  drivers/gpu/drm/omapdrm/omap_fb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
> index 190afc564914..56013c3ef701 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fb.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fb.c
> @@ -62,13 +62,15 @@ static int omap_framebuffer_dirty(struct drm_framebuffer *fb,
>  				  unsigned num_clips)
>  {
>  	struct drm_crtc *crtc;
> +	struct drm_modeset_acquire_ctx ctx;
> +	int ret;
>  
> -	drm_modeset_lock_all(fb->dev);
> +	DRM_MODESET_LOCK_ALL_BEGIN(fb->dev, ctx, 0, ret);
>  
>  	drm_for_each_crtc(crtc, fb->dev)
>  		omap_crtc_flush(crtc);
>  
> -	drm_modeset_unlock_all(fb->dev);
> +	DRM_MODESET_LOCK_ALL_END(fb->dev, ctx, ret);
>  
>  	return 0;

Return ret here

>  }
> -- 
> 2.33.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
