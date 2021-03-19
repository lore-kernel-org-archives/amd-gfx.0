Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF619C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD26664F4D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD26664F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7EF6EA31;
	Fri, 19 Mar 2021 14:47:10 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9358D6EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 14:43:55 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id gb6so4786041pjb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=86LC+1JkNbbYNnfKum5G/BlJ9HpQquJ6GZDdITyjMEY=;
 b=ESqHg/Y6nunNSt2A+n9NWRNhz9fMlfBI4MSa8ZUCLsFHV6hBHTbyKTb5LvtUBy3sDl
 tZ3TZCOfAxuslM6hVBzvZBG+WDWr6+KKfr45IXsC++3CgBLssBEmOYJPoltIUCj5Ab5r
 Ps5BzO93U4v5ATBIff4UXI55yoi3tueb3M2Mxsxr8AalFKT0qmZjt0ytDLMrSuh+Xjv2
 nn1qSIhjlu63a0/GM1HyDQ0gsQjhbyl0d2JTYfEuiD0xDFDASfbE81sV/e6NUMEG69T/
 p4rrhKaWnvLHgogq2P8lT5x0kwhxjSmRELfZbJfWCaMnzgbK6aqmocai87gZbkTlRmnh
 tqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=86LC+1JkNbbYNnfKum5G/BlJ9HpQquJ6GZDdITyjMEY=;
 b=SunshIr08gEWljL+JbStmwx1mZFDnkuEKV8a9wpBkLU/NIHzd/J78eP441Mug7uPoj
 LfEdoUvcZZMVGyS1sfE8H9tgbaTqZHyPwrQf7Ti4NkN+FK0KF+FNM/LEBHMdLMoEWX49
 U0rNE8XCqXbzXrlzK8htFzaQTaafuwEpXyj2R8AURmst/VCvy2/5VY3oohMoSQsJn7Mp
 BrAhf1cJlsemMtKcgZJM89UcqwAkIPppvPiIo8alCtD1n29FZviajvti0Q1962Brz8nW
 hARWuKX1caZ3QiPXToUtKa00Zdtd3ELS75v3+8Uw0WkpSZdKQxUw2R4ZSJY3xSCKrdRc
 2sJQ==
X-Gm-Message-State: AOAM530jUBlQzq8XstUlVBmO6cgX5nV1v+IrUOwQLUTonVdYKR6x9DZX
 g3IR8pLyv78V4h9oK3RENAod1JFE4kLN1BQwpLXW/Q==
X-Google-Smtp-Source: ABdhPJxMIHdTlGCXNCULSxlRJJagvj2AatBYPGQF37Ua2ikdmUUVJ4WnoNWSgNo0fgfSZ+4tH2iCCodydlKkCHKtvhM=
X-Received: by 2002:a17:90a:be07:: with SMTP id
 a7mr10386254pjs.75.1616165035134; 
 Fri, 19 Mar 2021 07:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-12-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-12-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Fri, 19 Mar 2021 15:43:44 +0100
Message-ID: <CAG3jFyvMb+ENOnM4Ug8Vkfk1uGThQj=+M96mf3ef0e9jzapoCw@mail.gmail.com>
Subject: Re: [PATCH 11/30] drm/bridge/analogix/anx6345: Don't link encoder
 until after connector registration
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, Vasily Khoruzhick <anarsoul@gmail.com>,
 Icenowy Zheng <icenowy@aosc.io>, Daniel Vetter <daniel@ffwll.ch>,
 Jonas Karlman <jonas@kwiboo.se>, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 open list <linux-kernel@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>, Torsten Duwe <duwe@lst.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:58, Lyude Paul <lyude@redhat.com> wrote:
>
> Another case of linking an encoder to a connector after the connector's
> been registered. The proper place to do this is before connector
> registration, so let's fix that.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index 8e016ba7c54a..6258f16da0e8 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -556,12 +556,6 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>         drm_connector_helper_add(&anx6345->connector,
>                                  &anx6345_connector_helper_funcs);
>
> -       err = drm_connector_register(&anx6345->connector);
> -       if (err) {
> -               DRM_ERROR("Failed to register connector: %d\n", err);
> -               return err;
> -       }
> -
>         anx6345->connector.polled = DRM_CONNECTOR_POLL_HPD;
>
>         err = drm_connector_attach_encoder(&anx6345->connector,
> @@ -571,6 +565,12 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>                 return err;
>         }
>
> +       err = drm_connector_register(&anx6345->connector);
> +       if (err) {
> +               DRM_ERROR("Failed to register connector: %d\n", err);
> +               return err;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
