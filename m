Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E8C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D73D64F18
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D73D64F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6196EA20;
	Fri, 19 Mar 2021 14:27:56 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCB36EA19
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 14:27:26 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 k23-20020a17090a5917b02901043e35ad4aso6769867pji.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c7mV4Rbx11jSwGIO7RFWexEM9wuc954Tc7xoZGSC8RY=;
 b=GLXyAn0MdFT42J6cb6YnfW63npT81/n7lhBa96/JtS7CxrjrH72B6rJtFaiqBzHLrA
 mTY3t6/8/oM5MxseEQRivmzslOGqSbjil+9paVlcpPb/o1mPG5c4EbQAun0rLLKbshdE
 HkXG7+PmRkqhA2NmGafsaYCjf5SYcu10XCFH8aDuYUbs7vv/CZv9ePX1VyOwWLjuba24
 sSyJ3g/wXIECiOK+bH4Ih8BIxlgkkhYn9ivIbEd2929m/OFYb/Z0XHf7gAMtdOPlU+lx
 VHucChxDfHeZCh5Wt0c5DLVlHmNJIwEg3VCmmYzXscKFmj5eJ71iM/WbtM1xz4oQApfz
 Orgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c7mV4Rbx11jSwGIO7RFWexEM9wuc954Tc7xoZGSC8RY=;
 b=fYwViRnM1XBwg4iKbfb7/7fXeqSEVyjm/JchvauZtBuNsYvO/arVYk50WST9ZSzmlL
 KWaya1b2Qc4Idb+WYeoJDyjC3aMkiStYmdpzO4hBZvmmHkbC5Q1eYRxpdnjGKN8rHSom
 DNp6IrsPTICzIMj3zJwOr782SGQrR9gFkI9k4ByhGDbnBOuAzI4F2CgU7EQsW5tRSvOY
 bajZYxeQ/SMRCDcku7Kujeogyq3lPAwAuLD02Oo+qCBfpxoXPEnH/FqWDhceps0x1lJJ
 XEXTR0TYnhWnW1f7pdonF68tsRDJtspTA6Vw+xZJGrVNjsegq58GiaRmS6wkeoFz1RHv
 Rr4Q==
X-Gm-Message-State: AOAM530W+qCVk4cRl2vsB3LjWF6RBCmXt3oYgz5VkQ+BajsTTc7aaHjr
 Z7gDdnyttPoFaxsDj8Sgl11D9Q+smNXVEwB5LsmzDQ==
X-Google-Smtp-Source: ABdhPJwnvR9UG2Yo3M+kYPqi3jAuQjulo9vJWylVtTTAmghGEpuzrJcoACdzlFVSdwttecpo72YGBTDHorwXzt+5IKQ=
X-Received: by 2002:a17:902:f68a:b029:e5:b17f:9154 with SMTP id
 l10-20020a170902f68ab02900e5b17f9154mr14411080plg.28.1616164046035; Fri, 19
 Mar 2021 07:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-5-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-5-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Fri, 19 Mar 2021 15:27:15 +0100
Message-ID: <CAG3jFyuR6yH9bWzbmcZVRoyRUvu0qvEirVtxtcUmVEyVpeW_JQ@mail.gmail.com>
Subject: Re: [PATCH 04/30] drm/bridge/tc358767: Don't register DP AUX channel
 until bridge is attached
To: Lyude Paul <lyude@redhat.com>
X-Mailman-Approved-At: Fri, 19 Mar 2021 14:27:54 +0000
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
 Jani Nikula <jani.nikula@linux.intel.com>, Andrzej Hajda <a.hajda@samsung.com>,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

This patch looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:56, Lyude Paul <lyude@redhat.com> wrote:
>
> Since this is a bridge, we don't start out with a respective DRM device.
> Likewise this means we don't have a connector, which also means that we
> should be following drm_dp_aux_register()'s documentation advice and not
> call drm_dp_aux_register() until we have a matching connector. Instead,
> call drm_dp_aux_init() in tc_probe() and wait until tc_bridge_attach() to
> register our AUX channel. We also add tc_bridge_detach() to handle
> unregistering the AUX adapter once the bridge has been disconnected.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 34a3e4e9f717..da89922721ed 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -1414,11 +1414,15 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
>         if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>                 return 0;
>
> +       ret = drm_dp_aux_register(&tc->aux);
> +       if (ret < 0)
> +               return ret;
> +
>         /* Create DP/eDP connector */
>         drm_connector_helper_add(&tc->connector, &tc_connector_helper_funcs);
>         ret = drm_connector_init(drm, &tc->connector, &tc_connector_funcs, tc->bridge.type);
>         if (ret)
> -               return ret;
> +               goto aux_unregister;
>
>         /* Don't poll if don't have HPD connected */
>         if (tc->hpd_pin >= 0) {
> @@ -1438,10 +1442,19 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
>         drm_connector_attach_encoder(&tc->connector, tc->bridge.encoder);
>
>         return 0;
> +aux_unregister:
> +       drm_dp_aux_unregister(&tc->aux);
> +       return ret;
> +}
> +
> +static void tc_bridge_detach(struct drm_bridge *bridge)
> +{
> +       drm_dp_aux_unregister(&bridge_to_tc(bridge)->aux);
>  }
>
>  static const struct drm_bridge_funcs tc_bridge_funcs = {
>         .attach = tc_bridge_attach,
> +       .detach = tc_bridge_detach,
>         .mode_valid = tc_mode_valid,
>         .mode_set = tc_bridge_mode_set,
>         .enable = tc_bridge_enable,
> @@ -1680,9 +1693,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         tc->aux.name = "TC358767 AUX i2c adapter";
>         tc->aux.dev = tc->dev;
>         tc->aux.transfer = tc_aux_transfer;
> -       ret = drm_dp_aux_register(&tc->aux);
> -       if (ret)
> -               return ret;
> +       drm_dp_aux_init(&tc->aux);
>
>         tc->bridge.funcs = &tc_bridge_funcs;
>         if (tc->hpd_pin >= 0)
> @@ -1702,7 +1713,6 @@ static int tc_remove(struct i2c_client *client)
>         struct tc_data *tc = i2c_get_clientdata(client);
>
>         drm_bridge_remove(&tc->bridge);
> -       drm_dp_aux_unregister(&tc->aux);
>
>         return 0;
>  }
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
