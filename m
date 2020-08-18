Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E2DC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 14:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960E6207D3
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 14:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JySWOkpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960E6207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CEF89A61;
	Tue, 18 Aug 2020 14:56:23 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5255D89A4A;
 Tue, 18 Aug 2020 14:56:22 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id g75so17280122wme.4;
 Tue, 18 Aug 2020 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RWwP4svyK47rE8PCHksIuxk8Iq2Ls/f4vWTfeoUX+J4=;
 b=JySWOkpbUlLKowOfNb8wv6q1aSw/t9gx/zd1VYIBfPLtCeYSn+VZISq2Yc4mi7zpPb
 c3Q+SmSFJo6o3338jpOrkTZ/xbluylZO1n7mg0c4tc27Poj5OmPn5EUamoKwqiwQGudq
 w9CTHkPI1uRWbaJmfpJOObiJylAKEf9z2mjxKTTQawUfhHNagQoaaANsCM1CmZl2cSTb
 DC+5x1I1ZVNvEmOQTg6gdPRWwwm0JL1qKdbedXmdz4xftWid0/rV7S5BzULEfvj85DY7
 yCRlhl6TolGtXHw41liC0j3x5EPRDDj8lD3I62yDIUiz7igOhRJRInUHagTljSjFERGX
 +qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RWwP4svyK47rE8PCHksIuxk8Iq2Ls/f4vWTfeoUX+J4=;
 b=bvjRwPzc9rU+LnmR0a5mYhwv03HTfmNF3a5tovQ6iuOtA+zOxktyPzmGVVlFM0THVf
 HfmZPlBs/bZstUY8xx0ugge8aoimmYlDBHxwPlD10C5MxoqlFE5iNLtBaHvPrSHX0bcU
 PDavpxO7ZFaIawdZcx/RJfOCrWJ9Hel42VAiYnaOY1ajbQ4k7ATdIDyIf1yoe6TTFnnN
 BAqWKWrwNh9AcHSymMw15iSo5EnaxwX5US5cFFNCKMjJToguEI3V9Zqz0U6jAtJs6oH8
 bRDH/Loxggjzs1mEo+O1SxcJ1QWYzYo2iXAJ88i3kwx+Skhe0iKHQz3TBXJtsP5Js/2J
 ZYJQ==
X-Gm-Message-State: AOAM532rEssDinzEmzOzXdNBOJOLut/3TdaspWcn/gu14blVpmXLkJY1
 2GBa9IgEZcLfDgpQ2pa4OyRptmmSO0vOYrWI75Y=
X-Google-Smtp-Source: ABdhPJx2BPjSzPsR+9yU5xMlkhANUSgJE+ae7RrbiOpMjEikTMSCnVPx67UHT2OU/yTw+hz96u0OPwoafanw2XCb5Fg=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr333641wmj.56.1597762580993; 
 Tue, 18 Aug 2020 07:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200816073214.980424-1-ztong0001@gmail.com>
In-Reply-To: <20200816073214.980424-1-ztong0001@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2020 10:56:10 -0400
Message-ID: <CADnq5_NDMZp9-1vVZ_CuxPJmxF8c1ULNbVmuMD6V9C3QT=OsmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: should check error using DC_OK
To: Tong Zhang <ztong0001@gmail.com>
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
Cc: "Cyr, Aric" <aric.cyr@amd.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Dave Airlie <airlied@linux.ie>,
 Hersen Wu <hersenxs.wu@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, abdoulaye.berthe@amd.com, "Deucher,
 Alexander" <alexander.deucher@amd.com>, jinlong.zhang@amd.com, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 17, 2020 at 3:08 AM Tong Zhang <ztong0001@gmail.com> wrote:
>
> core_link_read_dpcd returns only DC_OK(1) and DC_ERROR_UNEXPECTED(-1),
> the caller should check error using DC_OK instead of checking against 0
>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 5cb7b834e459..a60a457fcc8f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4376,9 +4376,9 @@ bool dc_link_get_backlight_level_nits(struct dc_link *link,
>                         link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
>                 return false;
>
> -       if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
> +       if (core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
>                         dpcd_backlight_get.raw,
> -                       sizeof(union dpcd_source_backlight_get)))
> +                       sizeof(union dpcd_source_backlight_get)) != DC_OK)
>                 return false;
>
>         *backlight_millinits_avg =
> @@ -4417,9 +4417,9 @@ bool dc_link_read_default_bl_aux(struct dc_link *link, uint32_t *backlight_milli
>                 link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
>                 return false;
>
> -       if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
> +       if (core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
>                 (uint8_t *) backlight_millinits,
> -               sizeof(uint32_t)))
> +               sizeof(uint32_t)) != DC_OK)
>                 return false;
>
>         return true;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
