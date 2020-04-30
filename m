Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D7C4724C
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332402076D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 14:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCDB63gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332402076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DCF6E1B9;
	Thu, 30 Apr 2020 14:58:23 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA85D6E1B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 14:58:22 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id j2so7321035wrs.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6PDW2T0KOF7yQvjtCbV0Ddlxf3NDjQ+71LbzMrj76ZA=;
 b=mCDB63gTWoLMmt1CTdrWQjo7n6p9TZ2xrPpElyZPWcAn/jCxvyoHDsyUPy87YHii5s
 ulS+Wmdtb/E0lw1h5qbOeocxaQ+6YvFlXYcnrEEcQAxPYIDo+LDguATcw5A37o74cevG
 AwpErIPWgzzBTRXjknIyIyeJZLR61ystMQ18lexAv05kbDG/sqoUmeJl5NB/vvL6K6eR
 kH5eQu3A5YTWXHTZdeCR+mbdkP5FaEaxSZhWn4ZmVlhUWXeLTTHMgmjyI4JUiKDKjy6D
 DpJOCwZHpSfl4pQTHd311VBdMUFKBJ5xntwwrztg1M4rlcEBtes8C7k2PwvmhBvBUOkN
 0TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6PDW2T0KOF7yQvjtCbV0Ddlxf3NDjQ+71LbzMrj76ZA=;
 b=tok7sXAmNS/2Sp50M6j0eHr2TmiTakByXS4AHyPFUZhPIBMHjC6UEm/IvbioLIeHOt
 f0jHJRyz1ekju/sPnyLlqHxdt2vEsYgRyjDjtJZSVv54vN1fFMGWKeiNq6vOw8uGWrkD
 HFI1AB4WH5ACBtQ0rwUDcDkx/PatWTnBMPzNDJn3PnNZpFILKIh1x6Z+GZDPnXoFqobT
 ZaMpVjH5L9tOo6oxvqFjA5o1ezUt6yu89XiH/sOas59s+jTeMiVT8SbA2JgD16+xg30J
 b4weqxXmxuzIsOvnOzrA/ADDZzXM/OLug3KqO8zByN7bENM8v5Q2/uL2B4Pe7B3B3F4c
 F/oQ==
X-Gm-Message-State: AGi0PuYhCNV03tTesPzjkdSpGeraKCDSFXMv4i+NwUQMvhpjKbVNlL/f
 Fxzq3sxTQITmbXcdFNezy6tUbxQP/854iRhuY9c8UQ==
X-Google-Smtp-Source: APiQypJw9eKkoqF6qgP1FvDm/mKGzived4wstUqhUud9Fau1WRXUp28EY+yV3/B4vrlHQc0bNB7MDBTOBh89FYojj/A=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr4547758wrq.374.1588258701182; 
 Thu, 30 Apr 2020 07:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200429150236.4626-1-daniel@octaforge.org>
 <20200429150236.4626-2-daniel@octaforge.org>
In-Reply-To: <20200429150236.4626-2-daniel@octaforge.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2020 10:58:09 -0400
Message-ID: <CADnq5_NaxwbhvBGB7x1vCGRohx8_1q0go8czJCPA=bLcWAOCTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: work around fp code being emitted
 outside of DC_FP_START/END
To: Daniel Kolesa <daniel@octaforge.org>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 29, 2020 at 11:08 AM Daniel Kolesa <daniel@octaforge.org> wrote:
>
> The dcn20_validate_bandwidth function would have code touching the
> incorrect registers emitted outside of the boundaries of the
> DC_FP_START/END macros, at least on ppc64le. Work around the
> problem by wrapping the whole function instead.
>
> Signed-off-by: Daniel Kolesa <daniel@octaforge.org>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c | 31 ++++++++++++++-----
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index e310d67..1b0bca9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3034,25 +3034,32 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
>         return out;
>  }
>
> -
> -bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
> -               bool fast_validate)
> +/*
> + * This must be noinline to ensure anything that deals with FP registers
> + * is contained within this call; previously our compiling with hard-float
> + * would result in fp instructions being emitted outside of the boundaries
> + * of the DC_FP_START/END macros, which makes sense as the compiler has no
> + * idea about what is wrapped and what is not
> + *
> + * This is largely just a workaround to avoid breakage introduced with 5.6,
> + * ideally all fp-using code should be moved into its own file, only that
> + * should be compiled with hard-float, and all code exported from there
> + * should be strictly wrapped with DC_FP_START/END
> + */
> +static noinline bool dcn20_validate_bandwidth_fp(struct dc *dc,
> +               struct dc_state *context, bool fast_validate)
>  {
>         bool voltage_supported = false;
>         bool full_pstate_supported = false;
>         bool dummy_pstate_supported = false;
>         double p_state_latency_us;
>
> -       DC_FP_START();
>         p_state_latency_us = context->bw_ctx.dml.soc.dram_clock_change_latency_us;
>         context->bw_ctx.dml.soc.disable_dram_clock_change_vactive_support =
>                 dc->debug.disable_dram_clock_change_vactive_support;
>
>         if (fast_validate) {
> -               voltage_supported = dcn20_validate_bandwidth_internal(dc, context, true);
> -
> -               DC_FP_END();
> -               return voltage_supported;
> +               return dcn20_validate_bandwidth_internal(dc, context, true);
>         }
>
>         // Best case, we support full UCLK switch latency
> @@ -3081,7 +3088,15 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
>
>  restore_dml_state:
>         context->bw_ctx.dml.soc.dram_clock_change_latency_us = p_state_latency_us;
> +       return voltage_supported;
> +}
>
> +bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
> +               bool fast_validate)
> +{
> +       bool voltage_supported = false;
> +       DC_FP_START();
> +       voltage_supported = dcn20_validate_bandwidth_fp(dc, context, fast_validate);
>         DC_FP_END();
>         return voltage_supported;
>  }
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
