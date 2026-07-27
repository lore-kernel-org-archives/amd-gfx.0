Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3EEC531C9
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB4D510E47B;
	Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sn85PcyF";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B856610E20B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so302024a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169203; cv=none;
 d=google.com; s=arc-20260327;
 b=nUbNoSQWy0uamYmLEMBOSfykI8H+f3CCbpi8r92KpHpb10I4NVcWi1X4lMNMpEyWkf
 Nfq166YiYx6DHtPFmIn1c+ggqUvZXp/Z8HeufwWPSAXJC6yWkrZqrrDb6i+45bIrOGkh
 Z/I9jq0l8FY0vDTx7Yy03nqkuD0GPJ8DojVmy6PFWPVN1c6bEdWLWF7shCgWivSkZMTC
 vFzWjGF5ujlPAt6MHcIX9wqz+z9HGKiIRddYeklSSP3YuZ40DTtDBqNcT49gPXC3H0Dx
 YmuULkM9d5dRAFFj4KWCnEbspUD1KMdrDALLwFrhDHNipNuwJNESKpnn6AWmRfnsPqww
 AU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/ksM5PQny+NdDsJAGpJTSCPU1EsruCSQEucz5vSK3KE=;
 fh=CxX+yxhedp3orSBPi6h74IExlXtxOU80WJTHS3LSuoo=;
 b=cmLa0innfz9COMygYC/EopxhxN3YsQtcPnqu5MrGSao+OLj9idn9i99YieKGiMXoud
 IZZ28/g8WkTqV4gk9FPY7PoiCf14dtb2UESLUtmyeaVmpfQ8cfVQwuKz6HpAY1EQ9LM2
 U10VyxU5JoGmI2TZL69CpclmeAcI64b/VN9ACBxQUg44Xkng7VIQVocforW8YNrE2HZ7
 qYMxH4wYjgv2ZYn1bJ+mzBWVy2rCGtTNw8XjAZfCmveDlDZmsNyP9EDFsREYFo7LKMc/
 cWdemIjXUlyv3A8xIdSAZnEa7lO2rLSGrR/r9VyakxH5YtRKfMU2dzbqz9qG+j9TXhjH
 hgqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169203; x=1785774003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ksM5PQny+NdDsJAGpJTSCPU1EsruCSQEucz5vSK3KE=;
 b=sn85PcyF6LVTB69GRwF4ymmSwtG+6CrJaFwiP5mu6yIEDiWSGADjDxvtswUlyEzEnR
 VuOTvI8SoPlD7WIfNW5nSMP/QwGM7Tkz6m/+2fkmWB+jxI2tfWb6zpyK3l61J1GSGqZt
 CicBl+0tjzrUjdPacX+5Hn09ZcPa4e6+ix7gbXPrVNHqviCrFD3016X0lRYhxnYJ8VS5
 kBRU6BTNUATMYFpY4BU805yH6Bb8OxAhdNPOZR49eoqgNZb+NEwUqEojzya+vB9nLvye
 d/ohP2Xs0xBWHNs8CXi++vVHx3lRcrcDO8wsgIDEHyU4kxZndJYBPAUaglhq3Pjk87dj
 +fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169203; x=1785774003;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ksM5PQny+NdDsJAGpJTSCPU1EsruCSQEucz5vSK3KE=;
 b=AkM2Qfj2CHq+6mFaOlQpmYpDLNi37XQKxNg2ee0w9F6w2VkhoS1zzeYjUyWe9FNLD0
 4ndRIjTJn3KOhf2xlPYPkxF5IuzL3a+ZC4GtIAzBmtMgDmMTZBlDdmw6un8y+05Ymxhh
 2Ru/qOtFnZvcrvUOhkSBU/0NYg+rHloBGWdXeFGlNjBn48Y4WelX8aHOGkna511g8eqC
 T12+Bcdgf+ZEkUWJjgNcSU1GFrf7MfTtsWIjPxDAPLjcpOlbE362ME0eEXnFXvW9cXvl
 sw4lj50mA4v3Sws0CuoIUduWYRGd8to38YUtel1tA0OT6xgbq1yh1KBf1kjeWi/zpRWC
 PNmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBhSX7Eh2tFqjYLKiUvnmhQezgRyGlWYDeOiuNti0kg8pA9poVcYeiEOgYc1QDgx2zW6pJlvsK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf5O4s6Nu+CqQl6sAx65leUL/MxlquTwOM1LNDaV/QGrXcqk/p
 mMFECGh3cXhxB6lt/JbgfBKRGo658QVNgevpS+LvrSF4yectNXBTdK/gqjg1TcHHOW+a/SDQ48M
 stwVp8AXAbK9fHljQUsxX6/Oqvz67ETs=
X-Gm-Gg: AR+sD11FwnkAC8G7MQ8gZieYfuDqCiV0KbmgKTLZ1bwNOzFl6CpfaaBsKnQZroDt9dJ
 46o2+vXj6eZJLn+MUoOV1hAxOOjZkhsdUtzHoaon5YTNIyw09jPNLx2GR5q+NeDSfMZyEN1GsAG
 z5zH0H52weJfwnPlfhQdwWMxGYp2bN/T41WKHfhXXS93l6I2SQVgv3sQh4cc+vRCnIxgZ1YgGJD
 +34DuOL3Ss84u5vUmhWlSQBtJtw99vGnjADA8MqQ34M06dgxlVvt84IqPXQQvjTxBxyR33rhppr
 1PDMn4lQbp1WceHP5wJaDWVuO92E1N66qf7saCQ+el9Q724V7ixF12v91glEtQtJGJBCAqImQxE
 J85P+2wYHckgfS6cAb3Etm49vVjPG7As=
X-Received: by 2002:a17:90a:c796:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-38f57f023e2mr2547790a91.0.1785169203100; Mon, 27 Jul 2026
 09:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260723042548.1225691-1-jirislaby@kernel.org>
 <PH8PR12MB7279B4E7FAA1899E488AB356F9C02@PH8PR12MB7279.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB7279B4E7FAA1899E488AB356F9C02@PH8PR12MB7279.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:19:50 -0400
X-Gm-Features: AUfX_myjQVzTaejoUa5qrWpmqSUuZkXKPZhJudMXjLu_KoDlhAdYzYkpxhIhf-A
Message-ID: <CADnq5_PK84e0Rx94=U+J8a5GHFgyqhQzDTTpiCD10CheKt+Cwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: use proper context for logging
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bhawan, I assume you already committed this?

Thanks,

Alex

On Thu, Jul 23, 2026 at 1:10=E2=80=AFPM Lakha, Bhawanpreet
<Bhawanpreet.Lakha@amd.com> wrote:
>
> looks good, thank you
>
> Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>
>
> Bhawan
>
> ________________________________________
> From: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Sent: July 23, 2026 12:25 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jiri Sla=
by (SUSE) <jirislaby@kernel.org>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd=
.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpen=
g.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <=
simona@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.=
org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
> Subject: [PATCH v2] drm/amd/display: use proper context for logging
>
> The same as the rest of the code, get_ss_info_from_atombios() uses
> calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is
> initialized only later in calc_pll_max_vco_construct(). Therefore, any
> output using DC_LOG_SYNC() leads to a NULL pointer deference in
> get_ss_info_from_atombios().
>
> According to Sashiko, the very same problem exists in
> dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers() too.
>
> To avoid accessing the NULL context, use clk_src->base.ctx->logger
> everywhere. That context in base is initialized earlier in
> dce110_clk_src_construct() and dce112_clk_src_construct(). Before
> get_ss_info_from_atombios() or Sashiko's get_pix_clk_dividers functions
> above are actually called. This is done by redefining DC_LOGGER to
> CTX->logger.
>
> Before:
> dce110_clk_src_construct() did:
>  -> sets clk_src->base.ctx =3D ctx;
>  -> ss_info_from_atombios_create()
>    -> get_ss_info_from_atombios()   <- uses calc_pll_cs->ctx  # BOOM
>  -> calc_pll_max_vco_construct()    <- sets calc_pll_cs->ctx
>
> After:
> dce110_clk_src_construct() does:
>  -> sets clk_src->base.ctx =3D ctx;
>  -> ss_info_from_atombios_create()
>    -> get_ss_info_from_atombios()   <- uses clk_src->base.ctx
>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=3D1271175
> Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@=
kernel.org/
> Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> ---
> Cc: dri-devel@lists.freedesktop.org
>
> [v2] Set DC_LOGGER to CTX->logger unconditionally (Bhawanpreet).
> [v1] https://lore.kernel.org/all/20260722063210.1144266-1-jirislaby@kerne=
l.org/
> ---
>  .../drm/amd/display/dc/dce/dce_clock_source.c | 20 +++++++++----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index ecb8493ec523..8e3862f6dac2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -45,9 +45,7 @@
>          clk_src->base.ctx
>
>  #define DC_LOGGER \
> -       calc_pll_cs->ctx->logger
> -#define DC_LOGGER_INIT() \
> -       struct calc_pll_clock_source *calc_pll_cs =3D &clk_src->calc_pll
> +       CTX->logger
>
>  #undef FN
>  #define FN(reg_name, field_name) \
> @@ -287,6 +285,7 @@ static bool calc_pll_dividers_in_range(
>  }
>
>  static uint32_t calculate_pixel_clock_pll_dividers(
> +               struct dce110_clk_src *clk_src,
>                  struct calc_pll_clock_source *calc_pll_cs,
>                  struct pll_settings *pll_settings)
>  {
> @@ -474,7 +473,7 @@ static uint32_t dce110_get_pix_clk_dividers_helper (
>  {
>          uint32_t field =3D 0;
>          uint32_t pll_calc_error =3D MAX_PLL_CALC_ERROR;
> -       DC_LOGGER_INIT();
> +
>          /* Check if reference clock is external (not pcie/xtalin)
>          * HW Dce80 spec:
>          * 00 - PCIE_REFCLK, 01 - XTALIN,    02 - GENERICA,    03 - GENER=
ICB
> @@ -517,12 +516,14 @@ static uint32_t dce110_get_pix_clk_dividers_helper =
(
>                  /*Calculate Dividers by HDMI object, no SS case or SS ca=
se */
>                  pll_calc_error =3D
>                          calculate_pixel_clock_pll_dividers(
> +                                       clk_src,
>                                          &clk_src->calc_pll_hdmi,
>                                          pll_settings);
>          else
>                  /*Calculate Dividers by default object, no SS case or SS=
 case */
>                  pll_calc_error =3D
>                          calculate_pixel_clock_pll_dividers(
> +                                       clk_src,
>                                          &clk_src->calc_pll,
>                                          pll_settings);
>
> @@ -568,7 +569,6 @@ static uint32_t dce110_get_pix_clk_dividers(
>  {
>          struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(cs);
>          uint32_t pll_calc_error =3D MAX_PLL_CALC_ERROR;
> -       DC_LOGGER_INIT();
>
>          if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
>                          || pix_clk_params->requested_pix_clk_100hz =3D=
=3D 0) {
> @@ -600,7 +600,6 @@ static uint32_t dce112_get_pix_clk_dividers(
>                  struct pll_settings *pll_settings)
>  {
>          struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(cs);
> -       DC_LOGGER_INIT();
>
>          if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
>                          || pix_clk_params->requested_pix_clk_100hz =3D=
=3D 0) {
> @@ -1442,8 +1441,6 @@ static uint32_t dcn3_get_pix_clk_dividers(
>          unsigned long long actual_pix_clk_100Hz =3D pix_clk_params ? pix=
_clk_params->requested_pix_clk_100hz : 0;
>          struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(cs);
>
> -       DC_LOGGER_INIT();
> -
>          if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
>                          || pix_clk_params->requested_pix_clk_100hz =3D=
=3D 0) {
>                  DC_LOG_ERROR(
> @@ -1513,7 +1510,6 @@ static const struct clock_source_funcs dce110_clk_s=
rc_funcs =3D {
>          .get_dp_dto_frequency_100hz =3D get_dp_dto_frequency_100hz
>  };
>
> -
>  static void get_ss_info_from_atombios(
>                  struct dce110_clk_src *clk_src,
>                  enum as_signal_type as_signal,
> @@ -1526,7 +1522,7 @@ static void get_ss_info_from_atombios(
>          struct spread_spectrum_info *ss_info_cur;
>          struct spread_spectrum_data *ss_data_cur;
>          uint32_t i;
> -       DC_LOGGER_INIT();
> +
>          if (ss_entries_num =3D=3D NULL) {
>                  DC_LOG_SYNC(
>                          "Invalid entry !!!\n");
> @@ -1657,6 +1653,7 @@ static void ss_info_from_atombios_create(
>  }
>
>  static bool calc_pll_max_vco_construct(
> +                       struct dce110_clk_src *clk_src,
>                          struct calc_pll_clock_source *calc_pll_cs,
>                          struct calc_pll_clock_source_init_data *init_dat=
a)
>  {
> @@ -1808,6 +1805,7 @@ bool dce110_clk_src_construct(
>          ss_info_from_atombios_create(clk_src);
>
>          if (!calc_pll_max_vco_construct(
> +                       clk_src,
>                          &clk_src->calc_pll,
>                          &calc_pll_cs_init_data)) {
>                  ASSERT_CRITICAL(false);
> @@ -1822,7 +1820,7 @@ bool dce110_clk_src_construct(
>
>
>          if (!calc_pll_max_vco_construct(
> -                       &clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_h=
dmi)) {
> +                       clk_src, &clk_src->calc_pll_hdmi, &calc_pll_cs_in=
it_data_hdmi)) {
>                  ASSERT_CRITICAL(false);
>                  goto unexpected_failure;
>          }
> --
> 2.55.0
