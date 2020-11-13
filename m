Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A3C4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6208D2078B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPACR7f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6208D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E876E5AB;
	Fri, 13 Nov 2020 14:33:20 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6146E5AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 14:33:19 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r17so10172539wrw.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eCjIdHSV8J7q4M+Wh7Qcov1UCobWpoCZxxO55pfuv5c=;
 b=QPACR7f0zlEgtOO2MnrojufiWJmKCLJ29Lem4UowI7bkqJiS0CasUxs1Mz4+EdvE3C
 K/BJXS0EimRjn1Hl8eNg5E92HSvf4+LRVqm6kH06xKeHeb4B7TnCOq/xE+LDlfYqcAwE
 SYI+GA9BQ5uYfaIxeEtu8fepGfa8naMNgIRje/Saki61BJFXhdAAYdekufVnGwvLM+GX
 teeTlxLc50yPNrVTs5A+T7W/Yo4M8ps8dTM4FaZGG4Tzl1NjquBmLuQAu5sQ4Vb8FOBH
 rOTps3ofRgOpczMD7N6sTnm6B2z9Qhtw04tbWtuvZdyWEzgRy1WsxwFXbNLrswHLxnPa
 8POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eCjIdHSV8J7q4M+Wh7Qcov1UCobWpoCZxxO55pfuv5c=;
 b=OCDKNJJ/BHt73pE7p9aHL3FF1PBe8msMJsnpa87zWsyQhyeJSlSL9s68i9AvTi5z6N
 mZv0Z22mG0HDgFrNTLDHg8/q9J4EzFn4WAWP/8Pin+/xEJrd71K98jdoUCoaoFBhKtPw
 TzXUtrUbplm3aflB8YfMSqxyaqpgq+yPngnjwhcDcoJQSH3a4AcjwLifJ1u6N+qweFqC
 OOHMdFF/yCBR86OUW7Epr6AsTCB3o9Aqra5TMPJxOitEuQDF7XqxRGLj4zOlozMBLeZG
 4Pklvpyb2psgPCKXptYltGZ+/n2oGRs0C1QpwS5XjBFz0gwBs410RWxEH4VqWMf1kOBa
 1tew==
X-Gm-Message-State: AOAM530vnr/4ZkcbasBLLH73iAYJSlVzKnFnEc4sWHKFtyfYyjQ3uTr+
 4qcLiFkVqSpR7ituOCsRxhGc28fik/1jFGAKLg0=
X-Google-Smtp-Source: ABdhPJzzbN3wKc8IidJkTll48qGy9Cv7w0U7aHC6vNzana7B3QyR1n7Z0ME6RUO29U1KUJHF96yCaYnjx3n04rUlVbo=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr3804320wru.362.1605277997893; 
 Fri, 13 Nov 2020 06:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20201112220618.3610982-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20201112220618.3610982-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 09:33:06 -0500
Message-ID: <CADnq5_NqRm994n4Tgra0uxD0CL_D9VrfyWCfZxWi5pr3dm453A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix FP handling in DCN30
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 12, 2020 at 5:06 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Adjust the FP handling to avoid nested calls.
>
> The nested calls cause the warning below
> WARNING: CPU: 3 PID: 384 at arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin
>
> Fixes: 26803606c5d6 ("drm/amdgpu/display: FP fixes for DCN3.x (v4)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Looks good to me.  Thanks!

Alex

> ---
>  .../drm/amd/display/dc/dcn30/dcn30_resource.c | 43 +++----------------
>  1 file changed, 6 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index b379057e669c..d5c81ad55045 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1470,20 +1470,8 @@ int dcn30_populate_dml_pipes_from_context(
>         return pipe_cnt;
>  }
>
> -/*
> - * This must be noinline to ensure anything that deals with FP registers
> - * is contained within this call; previously our compiling with hard-float
> - * would result in fp instructions being emitted outside of the boundaries
> - * of the DC_FP_START/END macros, which makes sense as the compiler has no
> - * idea about what is wrapped and what is not
> - *
> - * This is largely just a workaround to avoid breakage introduced with 5.6,
> - * ideally all fp-using code should be moved into its own file, only that
> - * should be compiled with hard-float, and all code exported from there
> - * should be strictly wrapped with DC_FP_START/END
> - */
> -static noinline void dcn30_populate_dml_writeback_from_context_fp(
> -               struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
> +void dcn30_populate_dml_writeback_from_context(
> +       struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
>  {
>         int pipe_cnt, i, j;
>         double max_calc_writeback_dispclk;
> @@ -1571,14 +1559,6 @@ static noinline void dcn30_populate_dml_writeback_from_context_fp(
>
>  }
>
> -void dcn30_populate_dml_writeback_from_context(
> -               struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
> -{
> -       DC_FP_START();
> -       dcn30_populate_dml_writeback_from_context_fp(dc, res_ctx, pipes);
> -       DC_FP_END();
> -}
> -
>  unsigned int dcn30_calc_max_scaled_time(
>                 unsigned int time_per_pixel,
>                 enum mmhubbub_wbif_mode mode,
> @@ -1977,7 +1957,7 @@ static struct pipe_ctx *dcn30_find_split_pipe(
>         return pipe;
>  }
>
> -static bool dcn30_internal_validate_bw(
> +static noinline bool dcn30_internal_validate_bw(
>                 struct dc *dc,
>                 struct dc_state *context,
>                 display_e2e_pipe_params_st *pipes,
> @@ -1999,6 +1979,7 @@ static bool dcn30_internal_validate_bw(
>
>         pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
>
> +       DC_FP_START();
>         if (!pipe_cnt) {
>                 out = true;
>                 goto validate_out;
> @@ -2222,6 +2203,7 @@ static bool dcn30_internal_validate_bw(
>         out = false;
>
>  validate_out:
> +       DC_FP_END();
>         return out;
>  }
>
> @@ -2404,7 +2386,7 @@ void dcn30_calculate_wm_and_dlg(
>         DC_FP_END();
>  }
>
> -static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
> +bool dcn30_validate_bandwidth(struct dc *dc,
>                 struct dc_state *context,
>                 bool fast_validate)
>  {
> @@ -2455,19 +2437,6 @@ static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
>         return out;
>  }
>
> -bool dcn30_validate_bandwidth(struct dc *dc,
> -               struct dc_state *context,
> -               bool fast_validate)
> -{
> -       bool out;
> -
> -       DC_FP_START();
> -       out = dcn30_validate_bandwidth_fp(dc, context, fast_validate);
> -       DC_FP_END();
> -
> -       return out;
> -}
> -
>  static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
>                                                         unsigned int *optimal_dcfclk,
>                                                         unsigned int *optimal_fclk)
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
