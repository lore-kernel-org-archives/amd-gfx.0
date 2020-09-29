Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D0FC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 21:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605F220757
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 21:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7weGNEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605F220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FCC6E1E8;
	Tue, 29 Sep 2020 21:11:40 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA1C6E28B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 21:11:40 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z4so7020529wrr.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u6BQmae2NwLceMK4A/8Cp3OA8QhIycD9syWKSDrPK9Y=;
 b=n7weGNErbMJghlGu22zUhW2Ur4O3/nR7sB+VHj4R/pg+uogzCJMWk3SgS9L51xqLkz
 fgUz0FeMV7m2EIxqY0hcVHFR/hInY87PiZqbVOoPugRBwPF97b6yJYAkf5MP7YJpfrjw
 SnZ+NyHYP1Wy65Hc/fyl3vU9o5rskPWVFOVMiVV0EdE5o1yL4MKxn1NdCF5qxeFVc7Gl
 rS82/M7JJHjKcpe997d66homfkJPKqcNJ0dFi0/miwpw2Q3eDO2p9I2r/ml15JqDVuwa
 qoft3vjcI6caIRs/p2qlciv2vXCE6Vtq+Ea+lSTp6HaJdjbEXigfb61xB0Vg+uwvc6LR
 rdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u6BQmae2NwLceMK4A/8Cp3OA8QhIycD9syWKSDrPK9Y=;
 b=GXXTowxi89VWr/ZeoJzak81blS69ypKtMMF5wohZDSocwiMFfIwg4wru97jAFysOyT
 TCU5epYNSiWlgSctk+dvPSMfY7qJJWFgyIOf+DmNJTy6qi49/tpRmk4aRMEx/8VSkAe9
 A3WG3eR4BRZ/RhwHXJNQF6/q/7PPFI0x7cKaWkiK1L3qhQPYQ3DsxEMggbtecfX8GA1b
 1rGf/XauXeRHr/LT7hl27YjBG0RkFxyaaWSd6xadfjXYFsQ6VMqxuBAD5A7BUf9xqrLw
 O9wMVp6ZMkLbB04b7mQVGjp0PufDkk6XHkC4GCWluPllJ5OngioX7MZl7xIJ6B2swFNJ
 BiAQ==
X-Gm-Message-State: AOAM531Ai5vo8UwhLrhmbFAUVlTupWv72RaawZYiCSpicGBpJJj8JNZw
 xzq9rX6kJ0cp3dhto7reoahbxacGc3TR9In3UCw=
X-Google-Smtp-Source: ABdhPJxk0XYYTOi2wgs4sKYWE827evPJN0G+ToSfHbYRI4L6aKcPoSftmRh1n8rNLgsjzjWA/iEaULJ8lPTKdip+N6k=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr6413466wro.362.1601413898942; 
 Tue, 29 Sep 2020 14:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200929204313.2050455-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200929204313.2050455-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 17:11:27 -0400
Message-ID: <CADnq5_Nfq0FF+6TYAMsVbx15VcphTUy6+PdNXCbw_LxEuGH2iQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add pipe reassignment prevention code to
 dcn3
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, "Siqueira,
 Rodrigo" <rodrigo.siqueira@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 29, 2020 at 4:43 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
>
> Add code to gracefuly handle any pipe reassignment
> occuring on dcn3 hardware. This should only happen when new
> surfaces are used for an update rather than old ones updated.
>
> Fixes: f64d8ebe9ed2 ("amd/drm/display: avoid dcn3 on flip opp change for slave pipes")
>
> Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
> Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/display/dc/dcn30/dcn30_resource.c | 61 +++++++++++++++----
>  1 file changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index c223f8af2084..24fb39a11e5d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1901,21 +1901,28 @@ static bool dcn30_split_stream_for_mpc_or_odm(
>
>  static struct pipe_ctx *dcn30_find_split_pipe(
>                 struct dc *dc,
> -               struct dc_state *context)
> +               struct dc_state *context,
> +               int old_index)
>  {
>         struct pipe_ctx *pipe = NULL;
>         int i;
>
> -       for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
> -               if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe == NULL
> -                               && dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
> -                       if (context->res_ctx.pipe_ctx[i].stream == NULL) {
> -                               pipe = &context->res_ctx.pipe_ctx[i];
> -                               pipe->pipe_idx = i;
> -                               break;
> +       if (old_index >= 0 && context->res_ctx.pipe_ctx[old_index].stream == NULL) {
> +               pipe = &context->res_ctx.pipe_ctx[old_index];
> +               pipe->pipe_idx = old_index;
> +       }
> +
> +       if (!pipe)
> +               for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
> +                       if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe == NULL
> +                                       && dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
> +                               if (context->res_ctx.pipe_ctx[i].stream == NULL) {
> +                                       pipe = &context->res_ctx.pipe_ctx[i];
> +                                       pipe->pipe_idx = i;
> +                                       break;
> +                               }
>                         }
>                 }
> -       }
>
>         /*
>          * May need to fix pipes getting tossed from 1 opp to another on flip
> @@ -2082,8 +2089,10 @@ static bool dcn30_internal_validate_bw(
>
>         for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
>                 struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
> +               struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
>                 struct pipe_ctx *hsplit_pipe = NULL;
>                 bool odm;
> +               int old_index = -1;
>
>                 if (!pipe->stream || newly_split[i])
>                         continue;
> @@ -2095,7 +2104,20 @@ static bool dcn30_internal_validate_bw(
>                         continue;
>
>                 if (split[i]) {
> -                       hsplit_pipe = dcn30_find_split_pipe(dc, context);
> +                       if (odm) {
> +                               if (split[i] == 4 && old_pipe->next_odm_pipe->next_odm_pipe)
> +                                       old_index = old_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
> +                               else if (old_pipe->next_odm_pipe)
> +                                       old_index = old_pipe->next_odm_pipe->pipe_idx;
> +                       } else {
> +                               if (split[i] == 4 && old_pipe->bottom_pipe->bottom_pipe &&
> +                                               old_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
> +                                       old_index = old_pipe->bottom_pipe->bottom_pipe->pipe_idx;
> +                               else if (old_pipe->bottom_pipe &&
> +                                               old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
> +                                       old_index = old_pipe->bottom_pipe->pipe_idx;
> +                       }
> +                       hsplit_pipe = dcn30_find_split_pipe(dc, context, old_index);
>                         ASSERT(hsplit_pipe);
>                         if (!hsplit_pipe)
>                                 goto validate_fail;
> @@ -2109,8 +2131,16 @@ static bool dcn30_internal_validate_bw(
>                         repopulate_pipes = true;
>                 }
>                 if (split[i] == 4) {
> -                       struct pipe_ctx *pipe_4to1 = dcn30_find_split_pipe(dc, context);
> +                       struct pipe_ctx *pipe_4to1;
>
> +                       if (odm && old_pipe->next_odm_pipe)
> +                               old_index = old_pipe->next_odm_pipe->pipe_idx;
> +                       else if (!odm && old_pipe->bottom_pipe &&
> +                                               old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
> +                               old_index = old_pipe->bottom_pipe->pipe_idx;
> +                       else
> +                               old_index = -1;
> +                       pipe_4to1 = dcn30_find_split_pipe(dc, context, old_index);
>                         ASSERT(pipe_4to1);
>                         if (!pipe_4to1)
>                                 goto validate_fail;
> @@ -2120,7 +2150,14 @@ static bool dcn30_internal_validate_bw(
>                                 goto validate_fail;
>                         newly_split[pipe_4to1->pipe_idx] = true;
>
> -                       pipe_4to1 = dcn30_find_split_pipe(dc, context);
> +                       if (odm && old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
> +                               old_index = old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
> +                       else if (!odm && old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
> +                                               old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
> +                               old_index = old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx;
> +                       else
> +                               old_index = -1;
> +                       pipe_4to1 = dcn30_find_split_pipe(dc, context, old_index);
>                         ASSERT(pipe_4to1);
>                         if (!pipe_4to1)
>                                 goto validate_fail;
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
