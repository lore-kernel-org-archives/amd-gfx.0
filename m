Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A686BC00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 12:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF0F10E12D;
	Fri, 29 Jul 2022 12:17:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34C210E12D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 12:17:42 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LvRNW2YgTzDqKt;
 Fri, 29 Jul 2022 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659097062; bh=pp65p+/zS7uADvstFNlMi6lVaJsnGFP3vPfiDCqMees=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NP/xRsWSvy94QdVTe1A2GC7pJrvTv03eV2yWtTx2mQjqFOvUmpSN3uieO+30njGaY
 jBgbDse22JAdj8Fr2yR/uFINPskQMHIVESqwk5x3GlYjqs+clI0dTW4U2rij6g17Bc
 gPLyVDIbHepZMTDiJFyuJ/fRO66rntxfeGKYU/t0=
X-Riseup-User-ID: EB3B9FD82D340378ADD74313AFCA125A0789963E5563F28268B38CE384DDB106
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LvRNS3lZWz5wWd;
 Fri, 29 Jul 2022 12:17:28 +0000 (UTC)
Message-ID: <a70d6888-5f89-9533-0756-b36c85f9bf9f@riseup.net>
Date: Fri, 29 Jul 2022 09:17:25 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Fix a compilation failure on PowerPC
 caused by FPU code
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220728203347.2019728-1-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220728203347.2019728-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Siqueira

On 7/28/22 17:33, Rodrigo Siqueira wrote:
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
>  	REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
>  }
>  
> -void optc3_set_vrr_m_const(struct timing_generator *optc,
> -		double vtotal_avg)
> -{
> -	DC_FP_START();
> -	optc3_fpu_set_vrr_m_const(optc, vtotal_avg);

The function optc3_fpu_set_vrr_m_const is only used here, so by deleting 
it, the function optc3_fpu_set_vrr_m_const is declared but not used.
Couldn't it be dropped also?

Best Regards,
- Maíra Canal

> -	DC_FP_END();
> -}
> -
>  void optc3_set_odm_bypass(struct timing_generator *optc,
>  		const struct dc_crtc_timing *dc_crtc_timing)
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
> -		double vtotal_avg);
> -
>  void optc3_set_drr_trigger_window(struct timing_generator *optc,
>  		uint32_t window_start, uint32_t window_end);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 992e56c6907e..eff1f4e17689 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -281,7 +281,6 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
>  		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
>  		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
>  		.enable_optc_clock = optc1_enable_optc_clock,
> -		.set_vrr_m_const = optc3_set_vrr_m_const,
>  		.set_drr = optc31_set_drr, // TODO: Update to optc32_set_drr once FW headers are promoted
>  		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
>  		.set_vtotal_min_max = optc3_set_vtotal_min_max,
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index 62d4683f17a2..4cfa733cf96f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -302,8 +302,6 @@ struct timing_generator_funcs {
>  			int group_idx,
>  			uint32_t gsl_ready_signal);
>  	void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux_dest dest);
> -	void (*set_vrr_m_const)(struct timing_generator *optc,
> -			double vtotal_avg);
>  	void (*set_drr_trigger_window)(struct timing_generator *optc,
>  			uint32_t window_start, uint32_t window_end);
>  	void (*set_vtotal_change_limit)(struct timing_generator *optc,
