Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA91C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3922A64F4D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3922A64F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0331D6EA3A;
	Fri, 19 Mar 2021 14:47:17 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A20C6EA32
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 14:44:45 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id u19so3825686pgh.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iGtWWRPtYaesVII9xVuarQ74BpkCKYVsirQYS4eH+kw=;
 b=VQopFqQ7Oi/j1u/8XxsX/Ys7cEFxGEox7f1bx6NoTv7BEvoz2YuGPDmss5cNrpjOzy
 VAEKj4MFXAwl6WPpkX+M+hI1Hu7VonNAkypLrCqWQSz2YlE6bFVZrX+y7MYzhM61hIBF
 hMAVmp/+eBnAWvLEUGT385c0lLIE3zNjKg3yEbrxcspNhbT85xP1rQObj/i7c8C1DsTJ
 RuyzGHHLesk4ojCDSC8eApoQe9iKz0uFKGjxbFcDZGqjP1i/Qc/4i9fpNqpKjlA8WYdG
 V7Lj9zoGrF4wQEB5h/JkCwP+fOh8CXDTsErgXHi2Lk46AUjB3sux/6XHCsHuo2j0YsyK
 KJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iGtWWRPtYaesVII9xVuarQ74BpkCKYVsirQYS4eH+kw=;
 b=DTE2lfk+B+e26gBOVDF/Bnqbiu5wVkvX+Dsa9ALi9vgjdXNWt6Ek6+fDycjkSJjPN1
 2/1iatd5a3SxSnAw5kvEsaFnBYtMsl5cxr37xEdpl9HBb1JxqrVLeYFxp7iHrPUdv8Hf
 LRgUPMc0v3zUr76i/m2TXQvTh6BkmX/gYpUy4FWUliNkZ0FCbr4QO2fQ98lu5IT3J8hN
 9HeROuLkbcIk59rWAUPfOV2czboB7wkM4U1gl0qrz8NSvP9vqyOtEIQaboRmx0ZQ68Hu
 LIEOee8TIeKhKHOKP6HI/0T3+2NqQnZCdMK/yYRTuiccXgxwfIR+7BG9bDFnWOjydNic
 E6GA==
X-Gm-Message-State: AOAM533uM6VXEORGP6zclmb5YONjNa6kCnKi8RdPipMecS5tSldOpm2f
 wPHrPdPTBpr8CgMxEM/TppHXqcAGgBt2qdCmtbA3GrjYA2hW6hQI
X-Google-Smtp-Source: ABdhPJzrBJishtLlW1vLHQuX3g9moCjtqg8gvKyfKMXQAVynNrWk794TQB88/EgV8doHLowCXDYIwqS+scDaYBD2Ma4=
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr11862551pgk.265.1616165084661; 
 Fri, 19 Mar 2021 07:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-13-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-13-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Fri, 19 Mar 2021 15:44:33 +0100
Message-ID: <CAG3jFysehSDHFFXAAc5VexAjyVhCq6hUyD8yWFsE6V3hv_9iPA@mail.gmail.com>
Subject: Re: [PATCH 12/30] drm/bridge/analogix/anx6345: Cleanup on errors in
 anx6345_bridge_attach()
To: Lyude Paul <lyude@redhat.com>
X-Mailman-Approved-At: Fri, 19 Mar 2021 14:47:10 +0000
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Jonas Karlman <jonas@kwiboo.se>, open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>,
 Torsten Duwe <duwe@lst.de>, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joe Perches <joe@perches.com>, Daniel Vetter <daniel@ffwll.ch>,
 Icenowy Zheng <icenowy@aosc.io>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:58, Lyude Paul <lyude@redhat.com> wrote:
>
> Another drive-by fix I found when fixing DP AUX adapter across the kernel
> tree - make sure we don't leak resources (and by proxy-AUX adapters) on
> failures in anx6345_bridge_attach() by unrolling on errors.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index 6258f16da0e8..aa6cda458eb9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -550,7 +550,7 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>                                  DRM_MODE_CONNECTOR_eDP);
>         if (err) {
>                 DRM_ERROR("Failed to initialize connector: %d\n", err);
> -               return err;
> +               goto aux_unregister;
>         }
>
>         drm_connector_helper_add(&anx6345->connector,
> @@ -562,16 +562,21 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>                                            bridge->encoder);
>         if (err) {
>                 DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
> -               return err;
> +               goto connector_cleanup;
>         }
>
>         err = drm_connector_register(&anx6345->connector);
>         if (err) {
>                 DRM_ERROR("Failed to register connector: %d\n", err);
> -               return err;
> +               goto connector_cleanup;
>         }
>
>         return 0;
> +connector_cleanup:
> +       drm_connector_cleanup(&anx6345->connector);
> +aux_unregister:
> +       drm_dp_aux_unregister(&anx6345->aux);
> +       return err;
>  }
>
>  static void anx6345_bridge_detach(struct drm_bridge *bridge)
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
