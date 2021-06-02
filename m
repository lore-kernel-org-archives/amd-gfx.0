Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F8C47080
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE1B610C9
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE1B610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508AE6EB53;
	Wed,  2 Jun 2021 02:09:18 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8183A6EB51;
 Wed,  2 Jun 2021 02:09:17 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 36-20020a9d0ba70000b02902e0a0a8fe36so1136126oth.8; 
 Tue, 01 Jun 2021 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YPBYvPlS0K1zlhnzHZtyafJWkRJauflA9nW2uiGpd1c=;
 b=LwttXAwFxPamIN3ybe5PExKaFx+iTEj0k814aFbA8BkTwE5PAnTlajOEaknKl/aA+8
 yee5FvDsp1o2lf4ncU89MhI3kehAq6aSj2KpMnNU0QtBIkZkhah1Kmi31JjU4ZPsh8Bm
 jyTZs2j0lQ0XnbvL1EaYCvIu9dQpFVeE9vSMXFqPzUzYiIjak67cu3WwDoyq6g+nY0X6
 eWe/F3zW2h47vigLnjb5uKEudJMC1MIuUtZFcIwURcn+jVsdlYiztExhqN8L8GAruWXc
 ibyLW+uPwMMKqlJhFDdtJ8nBU13u4wsJ1zmo5mY/P4MHv/oi3VNAGPPwoiTt5DqTJGYV
 97fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YPBYvPlS0K1zlhnzHZtyafJWkRJauflA9nW2uiGpd1c=;
 b=FMWhM+Sx7DdQmWDDEK7+DlfvqAaFY1LPAux5HMVJsXzHTEgUfG1WNKvxAuHOKPmkiN
 c6Io8tw8rvjm7AuEWTlGXyE1AWTnYXopfb3ayRudfgz2ZheXwezbqwkoC+ONpHaCTnV9
 2qtECytd3x1nrH5CusJXYcYi9X0qj8g9NBeQ/Hglw8U+yVdXEWK63iwjPYlQ0IAhS/ZN
 FbGtfErqeFaRuliqAk5Fi1MdI5TJ06mqdw04sn1BInHmiqiE3SL6DQChJtvKviT8hvdR
 wj8hiiQeuZ05sQK7w1s8t0+2STSvVokZHUBhaBZuqeP94mTK2860rHHz/v63QBgfrBMx
 oQ8A==
X-Gm-Message-State: AOAM531QYxddPy2hcw0KPLc2x1cWxXgMBcHMmvzw8oiJJM6fs6SXds+J
 uN8UyyIIb+cINBzbyi2z22umqa31tGuOKOLLy09TuflT
X-Google-Smtp-Source: ABdhPJyah/aLlIeg5qBASYFezB7EkSuhr9yCyEIhk2VbI36rcmTm8tf7w9++WXYWSRbHJEbh6D1TRWxRXAiRiVYNDIc=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr24139206oti.23.1622599756908; 
 Tue, 01 Jun 2021 19:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <1622453406-50092-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1622453406-50092-1-git-send-email-zhangshaokun@hisilicon.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 22:09:05 -0400
Message-ID: <CADnq5_MG3=KRa-5EBEKbixaz9LHWZjhmbPD5yQ9bKDky0RwOcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove the redundant initialization of
 local variable
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, May 31, 2021 at 5:30 AM Shaokun Zhang
<zhangshaokun@hisilicon.com> wrote:
>
> Local variable 'i' and 'j' will be initialized in the for loop, so
> remove the redundant initialization.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 4713f09bcbf1..e4f2a2d3a819 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -304,7 +304,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
>                 struct dc_stream_state *stream,
>                 struct dc_crtc_timing_adjust *adjust)
>  {
> -       int i = 0;
> +       int i;
>         bool ret = false;
>
>         stream->adjust.v_total_max = adjust->v_total_max;
> @@ -332,7 +332,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
>  {
>         /* TODO: Support multiple streams */
>         const struct dc_stream_state *stream = streams[0];
> -       int i = 0;
> +       int i;
>         bool ret = false;
>         struct crtc_position position;
>
> @@ -539,7 +539,7 @@ void dc_stream_set_dyn_expansion(struct dc *dc, struct dc_stream_state *stream,
>                 enum dc_dynamic_expansion option)
>  {
>         /* OPP FMT dyn expansion updates*/
> -       int i = 0;
> +       int i;
>         struct pipe_ctx *pipe_ctx;
>
>         for (i = 0; i < MAX_PIPES; i++) {
> @@ -597,7 +597,7 @@ void dc_stream_set_dither_option(struct dc_stream_state *stream,
>
>  bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_state *stream)
>  {
> -       int i = 0;
> +       int i;
>         bool ret = false;
>         struct pipe_ctx *pipes;
>
> @@ -614,7 +614,7 @@ bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_state *stre
>
>  bool dc_stream_program_csc_matrix(struct dc *dc, struct dc_stream_state *stream)
>  {
> -       int i = 0;
> +       int i;
>         bool ret = false;
>         struct pipe_ctx *pipes;
>
> @@ -640,8 +640,7 @@ void dc_stream_set_static_screen_params(struct dc *dc,
>                 int num_streams,
>                 const struct dc_static_screen_params *params)
>  {
> -       int i = 0;
> -       int j = 0;
> +       int i, j;
>         struct pipe_ctx *pipes_affected[MAX_PIPES];
>         int num_pipes_affected = 0;
>
> @@ -896,7 +895,7 @@ static void disable_all_writeback_pipes_for_stream(
>  static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context,
>                                           struct dc_stream_state *stream, bool lock)
>  {
> -       int i = 0;
> +       int i;
>
>         /* Checks if interdependent update function pointer is NULL or not, takes care of DCE110 case */
>         if (dc->hwss.interdependent_update_lock)
> @@ -1156,7 +1155,7 @@ static void enable_timing_multisync(
>                 struct dc *dc,
>                 struct dc_state *ctx)
>  {
> -       int i = 0, multisync_count = 0;
> +       int i, multisync_count = 0;
>         int pipe_count = dc->res_pool->pipe_count;
>         struct pipe_ctx *multisync_pipes[MAX_PIPES] = { NULL };
>
> --
> 2.7.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
