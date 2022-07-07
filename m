Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9293C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 18:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6167711B33C;
	Thu,  7 Jul 2022 18:12:58 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A096711B33C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 18:12:57 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id ez10so3664156ejc.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jul 2022 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lVJ2b9hrUzHAMkEf76b78kD6vwGZLBYrJ7OTz0kWMCI=;
 b=adM4D8yoeZ7pj9I6hFP32IEd3yVuhg3FwzKMecDxqaE+R+vxTL2RovtCjjPVh2bE9H
 g2kHVYlLRgkoy18vjYaSySIMLBHiuvFC7ZO/PrsDoa1/FUyD/psmnNA4UajYwk/TkMUg
 dWabSalMGoGqz2Y87iZ8aSxWC+Chm7vIGnagGCD6b3D15PhX2vSuTCDLfzJYiehU60fk
 Uw1g4XDLW2a8nuRDqNzvb7cH7aIMu+0vflkEmqc4tYKQGWYpn8DeqwKcYOzZpvaR9lML
 EkQGik2NY7EWqKzcJ2OaVG09ieJgh27Zh2vmrJKwIdOaKMCxSJaK8P7xjE5P2FekfCGB
 TqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lVJ2b9hrUzHAMkEf76b78kD6vwGZLBYrJ7OTz0kWMCI=;
 b=dZQkA1gnA2bvtjL1CgAsLRnSWkZupLV5a5Zi1krRFZLfHoH32loJewrA14QCfE2eab
 1xtwdEqK3a47i0x4mCB44rPx4IkBkyGGGnjfKoBjE6vQ91gL6SaiRwhrJCaVIpmoVBQ6
 rvOgRbV1OdeeE+esbxSwXF/i/3x9f+qgJSbdEfV5HczUoTp/z6fKLT5YJeRZ+0RynZF+
 Q7QFHcubK1PRRzytRLY4+6rvPkaOLJjQm0ONPJDpjBrf3Rqcr/bLSrmdvdlEbokB5+dy
 DSPc2rnRs3OFQ8rtA5OuXIqBe5S9DJASP4dFlU9qEmFrVLAllRL6WDc+y/lg1cxczA2/
 y9Yw==
X-Gm-Message-State: AJIora9kI/AU0+u7z6I3iUjw/UOo2iNY5OoAThsDoM3bGW1P7u40m3e8
 7WkS9pTxoBNT+RUkci7vGuvoT+ZpbIets5K4jZRHyhuH
X-Google-Smtp-Source: AGRyM1tSUk6MZude6pt6QBafET5IAopYyD5IJeAm+T1GlZ6+5p98HJNNUN4COpBsup5mCpRRolkne42lmnbVaQQcoFQ=
X-Received: by 2002:a17:907:75e1:b0:72a:ebee:5f61 with SMTP id
 jz1-20020a17090775e100b0072aebee5f61mr13922861ejc.171.1657217576107; Thu, 07
 Jul 2022 11:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220707180254.1592836-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220707180254.1592836-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Jul 2022 14:12:43 -0400
Message-ID: <CADnq5_Ps7zSrTtKxdmE4J5j3ov-7GY5iFH3E1wiL6Ptn51=-vw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add callback to set dig mode
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 7, 2022 at 2:03 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> Add a missing callback to set DIG FIFO output pixel mode. This is used
> when ODM combine is activated.
>
> Fixes: e40fcd4afb3f ("drm/amd/display: add DCN32/321 specific files for Display Core")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../amd/display/dc/dcn32/dcn32_dio_stream_encoder.c  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
> index da7d2243664f..26648ce772da 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
> @@ -391,6 +391,16 @@ static void enc32_stream_encoder_reset_fifo(struct stream_encoder *enc)
>         }
>  }
>
> +static void enc32_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
> +{
> +       struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
> +
> +       /* The naming of this field is confusing, what it means is the output mode of otg, which
> +        * is the input mode of the dig
> +        */
> +       REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, pix_per_container == 2 ? 0x1 : 0x0);
> +}
> +
>  static const struct stream_encoder_funcs dcn32_str_enc_funcs = {
>         .dp_set_odm_combine =
>                 enc32_dp_set_odm_combine,
> @@ -436,6 +446,8 @@ static const struct stream_encoder_funcs dcn32_str_enc_funcs = {
>         .dp_set_dsc_pps_info_packet = enc3_dp_set_dsc_pps_info_packet,
>         .set_dynamic_metadata = enc2_set_dynamic_metadata,
>         .hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
> +
> +       .set_input_mode = enc32_set_dig_input_mode,
>  };
>
>  void dcn32_dio_stream_encoder_construct(
> --
> 2.37.0
>
