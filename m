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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403DCC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 17:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACC622475
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 17:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACC622475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8CA89A77;
	Tue, 15 Dec 2020 17:15:14 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB13E89A77
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 17:15:13 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id b24so2600883otj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XJnyeuBMf6i2HiyTPfpAFffnEBRO4XeDz556Qb4jjDc=;
 b=tOK0RzVrAmotCfof7UlII35in8G/j95EkVd1codZ7UhRnG11E1nDOC6BQ5gfxUhKAN
 iilgNbHAbEkPjIvYZi4OEw1f4Q463TW+BfUCD/07IV1lUW0KUPi7r6hnLZE7cE7nVWEM
 UbLOCR+PC3MUY1vMWnpO1ZxT74xJart+g2ZjHHvGIVOijMdURA0fuYwvdYGan+xW1lVc
 OKtq9tpp8eWaMBJjpfNoWkRZ5aea7XDZSH8bH63ImS9XwZ1xV1TD7MqJdqjG63rT1BV5
 Xkn5Mb8FMV9f4T2b2lFuN2laxrc/BxRTe2XdYC4o7DG1pJyEcBPtkcv0yQv7oXK1EWIM
 +lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XJnyeuBMf6i2HiyTPfpAFffnEBRO4XeDz556Qb4jjDc=;
 b=a3ASokPW9vLPZVV+59OaBVbA0acXC4IUONhueAO+xO3PtZcWOb4nYeoL+p+Q6sic/d
 9SdZGFoSz779Q9hBayP8nhbxdWK1cHuv2sueVYzo87lD/HS6c0kdleM4ZaHN9O5Pjerb
 tksfOGV6o5eZaHhO401XSduTqXPyKrsHYSJqyMV42KYy86CJ3+sNo86vnUWuYpXWEMwZ
 T7gDMCH8b3Ac54RMFitKplaqw75vS0eCE/DLmJaDS3L6tAC/d6b34ZhSH4P3DCLdMIDF
 yU631/raWa532J4C+iP7eCntbUnwpSmgpb1r0w293AdOhJZqrGTOyNXmAp1cpUqJBC5/
 gsOw==
X-Gm-Message-State: AOAM533TuzdeCX2CgUrERtCDqZlq4R0t/e5slvm2CqqRDQzjFA1kInG6
 T8afbcW7oyz+dS/4uu402GJ1o9qI/eaqieOcWPE=
X-Google-Smtp-Source: ABdhPJwOOrGZKs1K7Mz7sWf1VgTZ9Qft6zculzrONxhsT/JFZUmHk2bFWkTRDQijib9XnzmgZTH/bC5i4wR3WXhoSqA=
X-Received: by 2002:a05:6830:1d66:: with SMTP id
 l6mr7318843oti.23.1608052513164; 
 Tue, 15 Dec 2020 09:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20201215154505.1321860-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20201215154505.1321860-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Dec 2020 12:15:02 -0500
Message-ID: <CADnq5_N5tiECQ9XFU8fD=OaRwnH_Xsivcv7+-oHepsdmrpiG4w@mail.gmail.com>
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

Do we really want the ASSERT?  The same function for DCN asserts all
the time on newer APUs if the register has it's default value (e.g.,
if a particular output was not used by the vbios).  IMHO, we should
remove the assert both here and for DCN.

Alex


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
