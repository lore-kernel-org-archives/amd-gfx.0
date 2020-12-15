Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5403C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624EE2078B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624EE2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA6B89A5D;
	Tue, 15 Dec 2020 16:24:54 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D2E89A5D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 16:24:52 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id d189so23915046oig.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eZA98qM4LA+REqsJd4W5mtcGO9Sf84DDmOhcLUlEJm0=;
 b=UBTLekXH466G1Ywn0xDpqq8Yg9CUEsZnMF0hzyrov1Bbs7ScbRQtzi4iNRfEBcCQzx
 Zjz4q6TnvRiS/IBk+gb7siGPU6RoUCcBHBfRamQwdjw97/JeR1yLIwgS3UiYJMjzbLkD
 XS1rWF/glehPzKSewY0K1lT8dYyv5PYs7S9r2yrP/eBWhc4bVG/aSyEes9Q3CqNRt/PG
 IDLlsVyOowRPxAIDikmUciW7E0cLBRt69cxfMPs/9UEbTWf+LT4L+2dRfteXZCx/GNph
 g667iI0bPyov7RzWgGPc6Yjxcn7883NvKamtzeMxmCoGxcGtSop3Y3JkBl0Hpx0YVKQi
 N96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZA98qM4LA+REqsJd4W5mtcGO9Sf84DDmOhcLUlEJm0=;
 b=dEyeZbktDoAmj+BQpGeFRkMiB90mDnYWLr2x4jFdqeaIqcpQ+rTTa50n0ZNMG0qbuj
 Dv/Bx0bBQogNC1Mw5oj035K3hFDHWS8UhKDIPAde4poKj2MmKfraMVsch8uTWB6ck4Dm
 lQJW5NfzLoRMlm+ReTn+zYfhuEzUM6BbwjeKClN+1mWxaJNRxA9W4wZzDpRcaO9Pdx3N
 Dq7tSZwOaT1/HGf1WERUGLqaiDcO78TIsCmKBYEDICwuvnPLYSe/+IFLYMP9GqhL1GZx
 rAoTFV6mL1ZgfXWHEMFjE8Zem5UOgPgPShNocksrHz7Ny4PBiJlTR8f7IFOZcSBXAg2r
 v1/w==
X-Gm-Message-State: AOAM531JwN4V9IIPSXopYBriGcXoIVdvk6FrddHqZ0vgBcZTVVIVcPx4
 MyFXWxQoQ7M0lFT0d3ntEfPNsyt7ZqNkXYHcfmM=
X-Google-Smtp-Source: ABdhPJzKHR1Jwj0xeeoztomjiQrthHOOwKv1i9ImhKYOi9zU7NqAtsaPv+UiqZKPJbMabrSYzgP4v3Q4ETWND+0iLwA=
X-Received: by 2002:aca:4f97:: with SMTP id
 d145mr21833982oib.123.1608049491900; 
 Tue, 15 Dec 2020 08:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20201215154505.1321860-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20201215154505.1321860-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Dec 2020 11:24:40 -0500
Message-ID: <CADnq5_PAgSNLO2zfALLXm_1PkBp5uCz=nGCNaPLV-cVP+m_t5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add get_dig_frontend implementation for
 DCEx
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Chiawen Huang <chiawen.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Borislav Petkov <bp@alien8.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 15, 2020 at 10:45 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> Some old ASICs might not implement/require get_dig_frontend helper; in
> this scenario, we can have a NULL pointer exception when we try to call
> it inside vbios disable operation. For example, this situation might
> happen when using Polaris12 with an eDP panel. This commit avoids this
> situation by adding a specific get_dig_frontend implementation for DCEx.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Chiawen Huang <chiawen.huang@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/display/dc/dce/dce_link_encoder.c | 43 ++++++++++++++++++-
>  .../drm/amd/display/dc/dce/dce_link_encoder.h |  2 +
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> index 4592ccdfa9b0..f355cd1e9090 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> @@ -120,6 +120,7 @@ static const struct link_encoder_funcs dce110_lnk_enc_funcs = {
>         .is_dig_enabled = dce110_is_dig_enabled,
>         .destroy = dce110_link_encoder_destroy,
>         .get_max_link_cap = dce110_link_encoder_get_max_link_cap,
> +       .get_dig_frontend = dce110_get_dig_frontend,
>  };
>
>  static enum bp_result link_transmitter_control(
> @@ -235,6 +236,45 @@ static void set_link_training_complete(
>
>  }
>
> +unsigned int dce110_get_dig_frontend(struct link_encoder *enc)
> +{
> +       struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
> +       u32 value;
> +       enum engine_id result;
> +
> +       REG_GET(DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, &value);
> +
> +       switch (value) {
> +       case DCE110_DIG_FE_SOURCE_SELECT_DIGA:
> +               result = ENGINE_ID_DIGA;
> +               break;
> +       case DCE110_DIG_FE_SOURCE_SELECT_DIGB:
> +               result = ENGINE_ID_DIGB;
> +               break;
> +       case DCE110_DIG_FE_SOURCE_SELECT_DIGC:
> +               result = ENGINE_ID_DIGC;
> +               break;
> +       case DCE110_DIG_FE_SOURCE_SELECT_DIGD:
> +               result = ENGINE_ID_DIGD;
> +               break;
> +       case DCE110_DIG_FE_SOURCE_SELECT_DIGE:
> +               result = ENGINE_ID_DIGE;
> +               break;
> +       case DCE110_DIG_FE_SOURCE_SELECT_DIGF:
> +               result = ENGINE_ID_DIGF;
> +               break;
> +       case DCE110_DIG_FE_SOURCE_SELECT_DIGG:
> +               result = ENGINE_ID_DIGG;
> +               break;
> +       default:
> +               // invalid source select DIG
> +               ASSERT(false);
> +               result = ENGINE_ID_UNKNOWN;
> +       }
> +
> +       return result;
> +}
> +
>  void dce110_link_encoder_set_dp_phy_pattern_training_pattern(
>         struct link_encoder *enc,
>         uint32_t index)
> @@ -1665,7 +1705,8 @@ static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
>         .disable_hpd = dce110_link_encoder_disable_hpd,
>         .is_dig_enabled = dce110_is_dig_enabled,
>         .destroy = dce110_link_encoder_destroy,
> -       .get_max_link_cap = dce110_link_encoder_get_max_link_cap
> +       .get_max_link_cap = dce110_link_encoder_get_max_link_cap,
> +       .get_dig_frontend = dce110_get_dig_frontend
>  };
>
>  void dce60_link_encoder_construct(
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
> index cb714a48b171..fc6ade824c23 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
> @@ -295,6 +295,8 @@ void dce110_link_encoder_connect_dig_be_to_fe(
>         enum engine_id engine,
>         bool connect);
>
> +unsigned int dce110_get_dig_frontend(struct link_encoder *enc);
> +
>  void dce110_link_encoder_set_dp_phy_pattern_training_pattern(
>         struct link_encoder *enc,
>         uint32_t index);
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
