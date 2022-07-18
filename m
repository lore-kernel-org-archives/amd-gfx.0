Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB73C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E59510EA1F;
	Mon, 18 Jul 2022 18:53:43 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB39210EA1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:53:42 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id y8so16608185eda.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QQCeFWAFeeYdE8AjB15uv+68TOpyaBwb6vwqnHcmGmg=;
 b=OrKeVKLURvey9dO5WC2LaIReRqt7JeYxJsb/rxtAYnzaWF/YswmZK+RmgID5pk5hJ+
 kwlW7xQy+/+uWXFRS9wo4msdp85Hp6C34wrtXKeRwWMqUr2My1sj8+3e3bEjU7jVOQI1
 xktxra0gDL4AEWJ1Mdug6zemBkkhvI9b4OxuaHgQ36ncjSDTjolCYNKJJrsqyYmbuVQG
 fZFtl8bNT1l/QlkNJ4uo65jqgfe+NYJP34lF0uZ2bse8xDLKSOEkBBwhiWWd5f3qIVz7
 l8Ch2Ij6oDNz9+AFTY0Dqd851oN1jQu836XjaboYL3eT0qqK54oz20rGTXwlPP8zMCA7
 /IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QQCeFWAFeeYdE8AjB15uv+68TOpyaBwb6vwqnHcmGmg=;
 b=Moj/VZwoScGZ+ULxJPkj9JohZzOCjVz2pSRl16jWCNL2cPwsuJ9HMg6PTQ3iyBvoj7
 LDgprxt5o0/QrbKmlj71P+Q7InNmuZyUgSkASWU8TLx8mWLYzDIWfrj2I0y+vX+LXLR2
 i7M0EgA57BTVrHg2foR/fYUk6bv+gplHGchFan20H07ScDR9gVU+6LEtcDI/s5WqFvjE
 4dz6EsUMsPk5McB9HMDASJYmES3gwZaot4wyc+OsWXHBCI1lqzsUNBjBuexDwvT6g8hB
 W7urL2JppMB/0ZSz8G5yJIOepdBtju+vWRsGIfrVC0+Ol5GymUDa30X2Wk1Tk402hUXW
 TbXA==
X-Gm-Message-State: AJIora//QqnrVrVqriKhADEAHYsVnAGbOHsNVGapTY6oAoCxnYkxjrqJ
 QXY2nSIoqmmvtl6qhAH7zVC/K58YSMyuJ1wTaY8=
X-Google-Smtp-Source: AGRyM1vFm/q16yDnNmxPJrCn+CGhjdvi5dklwjRveBxeTxdUBq2J0ybUbYU2ZNuqC3neB0Opwn5rrTn1N/7NR2hhiTg=
X-Received: by 2002:a05:6402:2895:b0:43b:1e47:c132 with SMTP id
 eg21-20020a056402289500b0043b1e47c132mr32853099edb.425.1658170421073; Mon, 18
 Jul 2022 11:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-3-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-3-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 14:53:29 -0400
Message-ID: <CADnq5_NzUdMWL2Am6hPkZsthMu=ONPvb1Lu85v0f2PoqA5uWNw@mail.gmail.com>
Subject: Re: [PATCH 03/12] drm/amd/display: Remove unused clk_src variable
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Magali Lemes <magalilemes00@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove the variable clk_src from the function dcn3_get_pix_clk_dividers.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1279:25: =
warning:
> variable 'clk_src' set but not used [-Wunused-but-set-variable]
>         struct dce110_clk_src *clk_src;
>                                ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 5cc7cc0b2f2d..d55da1ab1ac2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1276,9 +1276,7 @@ static uint32_t dcn3_get_pix_clk_dividers(
>                 struct pll_settings *pll_settings)
>  {
>         unsigned long long actual_pix_clk_100Hz =3D pix_clk_params ? pix_=
clk_params->requested_pix_clk_100hz : 0;
> -       struct dce110_clk_src *clk_src;
>
> -       clk_src =3D TO_DCE110_CLK_SRC(cs);
>         DC_LOGGER_INIT();
>
>         if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
> --
> 2.36.1
>
