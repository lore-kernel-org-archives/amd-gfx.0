Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB4EC4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92C364F18
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92C364F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524A36EA36;
	Fri, 19 Mar 2021 14:47:11 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD1B6EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 14:45:57 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 ot17-20020a17090b3b51b0290109c9ac3c34so4557462pjb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TDOGGWm21psnrXGlHEe6HvlgMdBE2hycDbnwOwrR0qU=;
 b=UlA8BUn9E5sUqHuUQiDVI3TjSNEzIgglN6StA4KCyVdX76E7TgzijdMXlwYNtcOU0U
 oK0YUt9NaUKh9OYWeJPjOkj4C5gutCsoHgMAvOd4Co8G5QdGHna9dHm7ddeuPGYGq/UU
 Si3mf/vcqt4SyjTxw+ErupnhAHbv7gJlYCmf1cF8qg82nbjZAt3Z/IIoFUghJvvgtcHU
 +FleiDUKLNV1+6e/kdi2/1LZ5WlwKchV5dNwMhB4LJ5WQEEREoixVpYSoLkG/fUbcn/z
 iqEMWMaGTVyjVI457AtXUukS3iu0mLK0n5p3e4aIfbfoRaFuJj8XAwJkM4jRv0vRhq69
 yzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TDOGGWm21psnrXGlHEe6HvlgMdBE2hycDbnwOwrR0qU=;
 b=sWczhudnDmTM3o9eOIm/RNEPPSmE9ngqeOpMe1MgRqckuRiQfFIXUrck23Qj2tnYEF
 mXr9bps/tbAO7KTjWuoWxdEVLjGIdBhc6uuYtIe34Jf7/AfExRhGCKyAIXs17s+J1R1B
 FOR9UUJKFetUc844RvGnfGc7Nj5cw2bzT1SGgvX/H+0+UmdGQND2ATDUE/pMULuwqx/9
 Xu5s3/WOI9GVC1YWQ0VkwfG8eq4sAkKTKBYhnL8JKwVlW5w6GbzLo7nSm+7WgMMKHkDZ
 E9tJdlp+IZqPIRjs3dm4bgtgvZKy/WkUIHST2l2jjlp8qxIxfJIVXyIoA5dQqqcL2E3a
 69hg==
X-Gm-Message-State: AOAM531cB+E+5Ya3hoVfrV+xKiuP8XTdD+mEMjbeoBZXBgA9QQjYBVk1
 rV76uHEdCbXDpkKGff0I8uGD50D3RCJT5ZYiOx5Ceg==
X-Google-Smtp-Source: ABdhPJxweZfNiCPg9C7NrDu3mAB+yl61lfkYpCt6KNMgXUL5b8ziQQV9oK2kr7DsR12MgPe9uLa2ifDL7vrvhQ8WUh4=
X-Received: by 2002:a17:902:e752:b029:e6:822c:355c with SMTP id
 p18-20020a170902e752b02900e6822c355cmr14735796plf.69.1616165156604; Fri, 19
 Mar 2021 07:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-14-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-14-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Fri, 19 Mar 2021 15:45:45 +0100
Message-ID: <CAG3jFyuJ=_Ab_LXNANs7VQAkgB16KC47zmibK1fXUKGvrGNUEw@mail.gmail.com>
Subject: Re: [PATCH 13/30] drm/bridge/analogix/dp_core: Unregister DP AUX
 channel on error in analogix_dp_probe()
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Joe Perches <joe@perches.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Jonas Karlman <jonas@kwiboo.se>, open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, Andrzej Hajda <a.hajda@samsung.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>,
 Andy Yan <andy.yan@rock-chips.com>, Sam Ravnborg <sam@ravnborg.org>,
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
> Just another drive-by fix I noticed while going through the tree to cleanup
> DP aux adapter registration - make sure we unregister the DP AUX dev if
> analogix_dp_probe() fails.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index aa1bb86293fd..f115233b1cb9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1782,6 +1782,7 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
>
>  err_disable_pm_runtime:
>         pm_runtime_disable(dp->dev);
> +       drm_dp_aux_unregister(&dp->aux);
>
>         return ret;
>  }
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
