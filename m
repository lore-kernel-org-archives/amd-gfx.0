Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E91C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF50E60F12
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF50E60F12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7A36EDDA;
	Fri, 17 Sep 2021 15:38:10 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F42C6EDD1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 15:38:08 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id y144so18690814qkb.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KGhh0FxAoXjZdT5id36puiM73Gpg6jiXPwlF6zyy+Sg=;
 b=WrdgPsCUaWeuwU1TkqYTtCQ2quYqXDaRjcmSfqsp6Vr2Ck3PrOIhPEfWlXA4RwwUQY
 LRrutmaNF63Ao+cfgmIYcVXLKpElilm+P2wdcvGcQLCBJmDJdxK5rYiaw4x+Tvjvdmc1
 4WEvA2cfDVgExeoJCAq/aMXa31ooix2kinFj9+6K9IjpkNVXJPlIH4SV2rhCORJj1u8l
 eI0dxfKQuwrwYbLNCtrLiFnm2IQuWjt+YKtOefdKwg/ipfk1nY2MMiVhllPToyeJVWEq
 hHywQWPHCMO1TvfSvV/lDP4n5dOqmqG+5rkdLmdQ/Y831IebnOWlWM4Y1/CVwwOWUtb6
 GRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KGhh0FxAoXjZdT5id36puiM73Gpg6jiXPwlF6zyy+Sg=;
 b=g7b85U8zSn4uqdb3/j7cJzfDMK5IlfqJruih3062lQdVdVpBfTE115qbphXw/mkP3l
 GHzKd8EzzWxOLLanusQjghTYzIuvgoaBlyKnz+Nrb1Id58GiadskzxR1YsvmOeBhbhaU
 y5ztT/3+MKuwi8bAB9GrKFCQpo9xVVjSmLAArq0MRTFM7qhoPH7oNxUF+OVK5HKCQ9vC
 Hjo63pXFbA+Z869W1PSsgEHbFO0ucr/35OWKf69DXkE0FcXc1hUMOuExFm7WO+tadcG2
 MGutvNGhVid8XSGdqffKJYrsHyUhxA0iVUMMN1WTU5Irg37Udua3TzonZpBOZ8jqwW82
 Htog==
X-Gm-Message-State: AOAM532xs0oFMcDLRx0mMfEhUDv+tll+nLhy40VRO/epC9INUbryDGA1
 Do8Cu2lnEMKxW5D1KSryoaMJ3Q==
X-Google-Smtp-Source: ABdhPJysyvGPa6axoOXBjG+j3Zq3CD8qoUtDCoNNwElUnRWgOTHeKEEVgJN6wYvegrigeSb75I+8WA==
X-Received: by 2002:a05:620a:789:: with SMTP id
 9mr11259370qka.400.1631893087092; 
 Fri, 17 Sep 2021 08:38:07 -0700 (PDT)
Received: from localhost ([167.100.64.199])
 by smtp.gmail.com with ESMTPSA id z6sm4991917qke.24.2021.09.17.08.38.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Sep 2021 08:38:06 -0700 (PDT)
Date: Fri, 17 Sep 2021 11:38:05 -0400
From: Sean Paul <sean@poorly.run>
To: Fernando Ramos <greenfoo@u92.eu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sean@poorly.run, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH 06/15] drm/tegra: cleanup: drm_modeset_lock_all() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <20210917153805.GF2515@art_vandelay>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-7-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916211552.33490-7-greenfoo@u92.eu>
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

On Thu, Sep 16, 2021 at 11:15:43PM +0200, Fernando Ramos wrote:
> As requested in Documentation/gpu/todo.rst, replace driver calls to
> drm_modeset_lock_all() with DRM_MODESET_LOCK_ALL_BEGIN() and
> DRM_MODESET_LOCK_ALL_END()
> 
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  drivers/gpu/drm/tegra/dsi.c  |  6 ++++--
>  drivers/gpu/drm/tegra/hdmi.c |  5 +++--
>  drivers/gpu/drm/tegra/sor.c  | 10 ++++++----
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
> index f46d377f0c30..77a496f6a2e9 100644
> --- a/drivers/gpu/drm/tegra/dsi.c
> +++ b/drivers/gpu/drm/tegra/dsi.c
> @@ -202,10 +202,12 @@ static int tegra_dsi_show_regs(struct seq_file *s, void *data)
>  	struct tegra_dsi *dsi = node->info_ent->data;
>  	struct drm_crtc *crtc = dsi->output.encoder.crtc;
>  	struct drm_device *drm = node->minor->dev;
> +	struct drm_modeset_acquire_ctx ctx;
>  	unsigned int i;
>  	int err = 0;
> +	int ret;

You can use err here instead. With that fixed,

Reviewed-by: Sean Paul <sean@poorly.run>


>  
> -	drm_modeset_lock_all(drm);
> +	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, ret);
>  
>  	if (!crtc || !crtc->state->active) {
>  		err = -EBUSY;
> @@ -220,7 +222,7 @@ static int tegra_dsi_show_regs(struct seq_file *s, void *data)
>  	}
>  
>  unlock:
> -	drm_modeset_unlock_all(drm);
> +	DRM_MODESET_LOCK_ALL_END(drm, ctx, ret);
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> index e5d2a4026028..669a2ebb55ae 100644
> --- a/drivers/gpu/drm/tegra/hdmi.c
> +++ b/drivers/gpu/drm/tegra/hdmi.c
> @@ -1031,10 +1031,11 @@ static int tegra_hdmi_show_regs(struct seq_file *s, void *data)
>  	struct tegra_hdmi *hdmi = node->info_ent->data;
>  	struct drm_crtc *crtc = hdmi->output.encoder.crtc;
>  	struct drm_device *drm = node->minor->dev;
> +	struct drm_modeset_acquire_ctx ctx;
>  	unsigned int i;
>  	int err = 0;
>  
> -	drm_modeset_lock_all(drm);
> +	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, err);
>  
>  	if (!crtc || !crtc->state->active) {
>  		err = -EBUSY;
> @@ -1049,7 +1050,7 @@ static int tegra_hdmi_show_regs(struct seq_file *s, void *data)
>  	}
>  
>  unlock:
> -	drm_modeset_unlock_all(drm);
> +	DRM_MODESET_LOCK_ALL_END(drm, ctx, err);
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index 0ea320c1092b..323d95eb0cac 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -1490,10 +1490,11 @@ static int tegra_sor_show_crc(struct seq_file *s, void *data)
>  	struct tegra_sor *sor = node->info_ent->data;
>  	struct drm_crtc *crtc = sor->output.encoder.crtc;
>  	struct drm_device *drm = node->minor->dev;
> +	struct drm_modeset_acquire_ctx ctx;
>  	int err = 0;
>  	u32 value;
>  
> -	drm_modeset_lock_all(drm);
> +	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, err);
>  
>  	if (!crtc || !crtc->state->active) {
>  		err = -EBUSY;
> @@ -1522,7 +1523,7 @@ static int tegra_sor_show_crc(struct seq_file *s, void *data)
>  	seq_printf(s, "%08x\n", value);
>  
>  unlock:
> -	drm_modeset_unlock_all(drm);
> +	DRM_MODESET_LOCK_ALL_END(drm, ctx, err);
>  	return err;
>  }
>  
> @@ -1652,10 +1653,11 @@ static int tegra_sor_show_regs(struct seq_file *s, void *data)
>  	struct tegra_sor *sor = node->info_ent->data;
>  	struct drm_crtc *crtc = sor->output.encoder.crtc;
>  	struct drm_device *drm = node->minor->dev;
> +	struct drm_modeset_acquire_ctx ctx;
>  	unsigned int i;
>  	int err = 0;
>  
> -	drm_modeset_lock_all(drm);
> +	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, err);
>  
>  	if (!crtc || !crtc->state->active) {
>  		err = -EBUSY;
> @@ -1670,7 +1672,7 @@ static int tegra_sor_show_regs(struct seq_file *s, void *data)
>  	}
>  
>  unlock:
> -	drm_modeset_unlock_all(drm);
> +	DRM_MODESET_LOCK_ALL_END(drm, ctx, err);
>  	return err;
>  }
>  
> -- 
> 2.33.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
