Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5FBC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 20:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A404311388F;
	Thu, 28 Jul 2022 20:35:49 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BCF11A439
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 20:35:45 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id m8so3566934edd.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GnztsVvodD3v3FsFAWPiLvOPGVpqWzlBz5EYako/dVQ=;
 b=ZVozs1ZSnTSmBfJNJ4Dcp0j25ZbPg5N0+ca65FJpE7549khYQ0LXp7W/KF63zE9fda
 AyNfrqGdjhH4DLsWfZxV9xmJo2RwDFdCOHnuUlA2Jaco7iHcYHxOtTgpgQxJMctQiVnl
 kGRsHOPtGyeuHwZiXMuGarwdrdm6t2x19iFDlKC63r21fgIIZkqAhp2XR5MGlDhOPJhh
 xaxRGTsGRbdJwFkeoysRllBSmanNWrDvz3TcBOuIiZla24ianAPsbNdlrfhrD+8D0ZW2
 71949bmNbpcjX72ho3EhyO8VXGfqIx2PZ6tzHsA33VAx4FhW54Bq1rXYPDRzEzGDolXn
 3KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GnztsVvodD3v3FsFAWPiLvOPGVpqWzlBz5EYako/dVQ=;
 b=zhsbUElJXoy2YnvXukieWUC2o7bUhUeXRzFQ0wxS7tY9BK3JA2rYydY9MuiUggOk9z
 1ypmrx/GuKFS5wHfZc+sPjbwA1z9VIlF17/C5E4IDZrxVj3UtBoyS2ErKw6I5eEQyQBV
 AgPNZPocT8Qrc2LXOBkzY0H/m3D11y44qG4PAaRw3FpRIE8g6fwhns3UthDkjMECz0O6
 UqOI6Qk97jryOeKIuS7UiUU1s/Fj5rO+I1t5zgSagBdioEhcxBJIJUfoHefE+IbuwupV
 vXBUk+e+jUWOzwPaO24vi+MRu3d0SxqMb/625MdPdyg4xbpBndMaRiffp0mCPS2/bt/K
 THcQ==
X-Gm-Message-State: AJIora90iu40+IXVj/j1VPJX5GMn7Ksq4Og7Tzh3ckuQbQdgS78gy/r5
 sg6DLYnLc6E01T8hjt2RKsjKVx58I5v40aIUATcMvMiC
X-Google-Smtp-Source: AGRyM1uDXYJUw6U7HLVAgXNMKC5s6q0JjHQgy92/bmsR2RzxIez8YAN/7VxmEQDhpPp+WRv/q7G+NqyN5pZLEZA5c6Y=
X-Received: by 2002:a05:6402:34d2:b0:43c:216:a56c with SMTP id
 w18-20020a05640234d200b0043c0216a56cmr690062edc.40.1659040544268; Thu, 28 Jul
 2022 13:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220728203347.2019728-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220728203347.2019728-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Jul 2022 16:35:32 -0400
Message-ID: <CADnq5_OTMMaXPuSfq-gBkpPRv9Q7-07iqZ6sdGc7hdWr43pPcg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix a compilation failure on PowerPC
 caused by FPU code
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, amd-gfx@lists.freedesktop.org,
 Michael Ellerman <mpe@ellerman.id.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 28, 2022 at 4:34 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> We got a report from Stephen/Michael that the PowerPC build was failing
> with the following error:
>
> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o
>
> This error happened because of the function optc3_set_vrr_m_const. This
> function expects a double as a parameter in a code that is not allowed
> to have FPU operations. After further investigation, it became clear
> that optc3_set_vrr_m_const was never invoked, so we can safely drop this
> function and fix the ld issue.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c        | 8 --------
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h        | 3 ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c        | 1 -
>  drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 --
>  4 files changed, 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> index d072997477dd..1782b9c26cf4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> @@ -184,14 +184,6 @@ void optc3_set_dsc_config(struct timing_generator *optc,
>         REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
>  }
>
> -void optc3_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg)
> -{
> -       DC_FP_START();
> -       optc3_fpu_set_vrr_m_const(optc, vtotal_avg);
> -       DC_FP_END();
> -}
> -
>  void optc3_set_odm_bypass(struct timing_generator *optc,
>                 const struct dc_crtc_timing *dc_crtc_timing)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> index 33bd12f5dc17..dd45a5499b07 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> @@ -329,9 +329,6 @@ void optc3_lock_doublebuffer_enable(struct timing_generator *optc);
>
>  void optc3_lock_doublebuffer_disable(struct timing_generator *optc);
>
> -void optc3_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg);
> -
>  void optc3_set_drr_trigger_window(struct timing_generator *optc,
>                 uint32_t window_start, uint32_t window_end);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 992e56c6907e..eff1f4e17689 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -281,7 +281,6 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
>                 .lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
>                 .lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
>                 .enable_optc_clock = optc1_enable_optc_clock,
> -               .set_vrr_m_const = optc3_set_vrr_m_const,
>                 .set_drr = optc31_set_drr, // TODO: Update to optc32_set_drr once FW headers are promoted
>                 .get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
>                 .set_vtotal_min_max = optc3_set_vtotal_min_max,
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index 62d4683f17a2..4cfa733cf96f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -302,8 +302,6 @@ struct timing_generator_funcs {
>                         int group_idx,
>                         uint32_t gsl_ready_signal);
>         void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux_dest dest);
> -       void (*set_vrr_m_const)(struct timing_generator *optc,
> -                       double vtotal_avg);
>         void (*set_drr_trigger_window)(struct timing_generator *optc,
>                         uint32_t window_start, uint32_t window_end);
>         void (*set_vtotal_change_limit)(struct timing_generator *optc,
> --
> 2.35.1
>
