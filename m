Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D928C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F018964F18
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F018964F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40B96EA23;
	Fri, 19 Mar 2021 14:28:57 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0B06EA23
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 14:28:26 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id x26so6012742pfn.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wB7XW1expiEEiA0z4q1J+zFtd6n/h701jYh9DH52x/g=;
 b=rfMY38MqhnK5WXT7hN0NFVNWJw09ySqEl6rahFHBok2eKiGSQ2SNtxC0jMRggFiFlp
 YNwZt7MGTpigDLIAQKlPZmqoBKtAhhEZfliE5yoKKwNqonCgvMFh7k/B/fMmSMvqGIKr
 5o8ELS87A24SQYN48yn1Kk4x38DeIrzUpQ1vxEuFDiJufMUpYAWSvdq2f2AhwA7AksfV
 bzKZSInC5qkZPpyyM0fxBaDgRizOcLYb/NaHoS9F2+0iegoTshz2yU6lxf5+VEoO5kuz
 hLBfKtTo5O9LWVFySPV8SYcnOJrIxqA1hBYp3/kGnJNXZaR/mMgvqz0ywTpGOA39Y6hJ
 Z+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wB7XW1expiEEiA0z4q1J+zFtd6n/h701jYh9DH52x/g=;
 b=iBQe3qgbSr+AMXwOINumL+gwdI8iZPEI2ioL5AWeg1eun2VsFbn+qdx/+mrDmgcXmI
 AYTpOeFqyDgiwXKOHL3sTi1ONCaQTuxhAdnziXL6J97veEbmhtxK5/Yav0kwgsL7jH1b
 IpDubHlKKnRpNHqgIW1U2uz8Fu3Y4IrCfI9ojkG+nqAA3RVT0zlDYcIyf+T/j3TJ2LY2
 gLjy/Oi/Nxl0DQFToE2NdxoeuDkaC/N1XI9QBia31JWqCGg01aBVaEZXAliGD3/yViz3
 BYKmaddGC1bowKg+GdL1wHWjln62ruwi6bNv7HfHn+RUeHPosRAPIv3yMzWoD6a6Tve/
 /3AQ==
X-Gm-Message-State: AOAM532T9ui3Ggzvn23I2pqaKh5PHt0SjFG1Lge3Dl8iEHtMzndNKwBD
 HH4XPBeKvOeXFgb+LRLekZ4vGyC2D71u4kRlJ34xGg==
X-Google-Smtp-Source: ABdhPJyE0Wk9tAliN/2sKNin+z7nx+NeyBf7s/4rymph1mvk13Artsko/VpzzorcMg+3DPqfuz4cf4SD2HeAcfTrsYc=
X-Received: by 2002:a63:2321:: with SMTP id j33mr11536620pgj.120.1616164106191; 
 Fri, 19 Mar 2021 07:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-8-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-8-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Fri, 19 Mar 2021 15:28:15 +0100
Message-ID: <CAG3jFyt10Z_MVvvXyBfYFrN7_FQCOUywfLNXZbei2c=1DxvqhA@mail.gmail.com>
Subject: Re: [PATCH 07/30] drm/bridge/analogix/anx78xx: Add missing
 drm_dp_aux_unregister() call
To: Lyude Paul <lyude@redhat.com>
X-Mailman-Approved-At: Fri, 19 Mar 2021 14:28:56 +0000
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
Cc: Torsten Duwe <duwe@lst.de>, Jernej Skrabec <jernej.skrabec@siol.net>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Jonas Karlman <jonas@kwiboo.se>, open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, Andrzej Hajda <a.hajda@samsung.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:56, Lyude Paul <lyude@redhat.com> wrote:
>
> Surprisingly, this bridge actually registers it's AUX adapter at the
> correct time already. Nice job! However, it does forget to actually
> unregister the AUX adapter, so let's add a bridge function to handle that.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index 81debd02c169..ec4607dc01eb 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -942,6 +942,11 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
>         return 0;
>  }
>
> +static void anx78xx_bridge_detach(struct drm_bridge *bridge)
> +{
> +       drm_dp_aux_unregister(&bridge_to_anx78xx(bridge)->aux);
> +}
> +
>  static enum drm_mode_status
>  anx78xx_bridge_mode_valid(struct drm_bridge *bridge,
>                           const struct drm_display_info *info,
> @@ -1013,6 +1018,7 @@ static void anx78xx_bridge_enable(struct drm_bridge *bridge)
>
>  static const struct drm_bridge_funcs anx78xx_bridge_funcs = {
>         .attach = anx78xx_bridge_attach,
> +       .detach = anx78xx_bridge_detach,
>         .mode_valid = anx78xx_bridge_mode_valid,
>         .disable = anx78xx_bridge_disable,
>         .mode_set = anx78xx_bridge_mode_set,
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
