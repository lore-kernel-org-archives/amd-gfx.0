Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8C3C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0327A10E59D;
	Mon,  4 Aug 2025 15:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RLLoKKZx";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A022910E59D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:58:04 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-76bde8901f6so158156b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323084; x=1754927884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPnu3FRuLnuhZrVJ9OgqlRYeDMVNU1xe0Ubi1sOanYI=;
 b=RLLoKKZxd0Mlduiatv9k3P006Ug3kCdUeW0mq04heXYaB+VOjDtfckCtdyZaFThSu5
 V1O9ZKyx9lBboo8zEjEKx4FJUmSEHolP7rwZ8mM2eV1ehwgdiwrElat0g1Yv5C2d8box
 wjdTJtUqZqTkvrC8zak69/kLOdals2qPXths75OPEYtOaGJ5AnzAMISb+Rf6t6N+wCL7
 6ZoF3sbM5STa3eGoBbRK+gjm4WYdVel/r6vBeJA3eUUCfdoAOtRqafd4xwi/+cHwxA61
 3kph6UibBmKB/IBoEauvM23VHQNjGBF5jI5/jyLjjTKZ4dL/PHLMuhuMjE669C9CibEr
 28nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323084; x=1754927884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPnu3FRuLnuhZrVJ9OgqlRYeDMVNU1xe0Ubi1sOanYI=;
 b=nHdtFwpHvIskNWGTJbvuikR7HSdkHU8akKAfmpF1nHo7YHrk6BFGQAIVfXSM4jHemx
 cCRD/LCcNOtWHEvH2bfJKzwYntHxGfUL3GT0HEIehbXdWZfHnkrjuWWZnxC5Or2//feC
 zVVa4xnbJ+jlsJxKkK5+srR2B64S/ZEGvhF2gCWVPiHtjBPMgpmAI775QCbOIVlsOC36
 E1z0UTOdmc41YoTx0pjwHPfvUde4gLmdCrlcF8nkLX+P26IwpgsxtgKOizUOdICjiqCq
 G98Hzt02A3VVLB+1GYgtmFnsrhME01T+t4A/NtAL2XBnaXHfJlMK0gRnlT9Km2YE/2KL
 NFIg==
X-Gm-Message-State: AOJu0Yybggbv+lwtweGqqII9HJmU53HvdIU3WvzHtboaHI8jSchfx2WY
 yMgfaL1afJPvWeOM84Z+wq/QiL2rfkttlkUU5S/ZkrMT6fGYZlHHLAjTSmkg6rmUZBjYdq1MgC5
 UXQa7+9DzPw4XdfPkk364QjTe2tE9t3w=
X-Gm-Gg: ASbGncu1kzebwLbeCA6QmSeQ5AWz/NlK3tYROGpt1J5Oa/vZ0sbfQAcEd9rwqzIzTBj
 yO0t/58DSPtuRrF4hhqogP4Wo4pyzrlBbYfzGwt4l2SoOddqwBC6ARQxIMwUSJjQL+F+ZplJmUN
 W8Zy54i3QA4ya5RfhNaZbCocJw4mh2N0fo9al4jiQun/M63MXQA6WeDJNEtswARGgxmbaNuuvx9
 a0UPCt6
X-Google-Smtp-Source: AGHT+IEIxOpmXEYNljXJkzU7wS1t5DUxXPouBgB3p/aOx1Bl95kZCnvc0RnOftdq+p3NWG/+P2d2E/8HvgGq+6LJSOg=
X-Received: by 2002:a05:6a21:3d89:b0:240:28e:c333 with SMTP id
 adf61e73a8af0-240028ec620mr2491995637.2.1754323083973; Mon, 04 Aug 2025
 08:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-4-timur.kristof@gmail.com>
In-Reply-To: <20250731094352.29528-4-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:57:52 -0400
X-Gm-Features: Ac12FXzRKVwbQSRyqY8bX3c8NueYMCOo1iajte3Oa-lORJnbc84LWWdwx1ceQsg
Message-ID: <CADnq5_NFX4H9EvDUG5VOXqWvvF7c1V37t5r-LKC1BT_XCQ9U3g@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Find first CRTC and its line time in
 dce110_fill_display_configs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jul 31, 2025 at 6:03=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> dce110_fill_display_configs is shared between DCE 6-11, and
> finding the first CRTC and its line time is relevant to DCE 6 too.
> Move the code to find it from DCE 11 specific code.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 30 ++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> index f8409453434c..baeac8f1c04f 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> @@ -120,9 +120,12 @@ void dce110_fill_display_configs(
>         const struct dc_state *context,
>         struct dm_pp_display_configuration *pp_display_cfg)
>  {
> +       struct dc *dc =3D context->clk_mgr->ctx->dc;
>         int j;
>         int num_cfgs =3D 0;
>
> +       pp_display_cfg->crtc_index =3D dc->res_pool->res_cap->num_timing_=
generator;
> +
>         for (j =3D 0; j < context->stream_count; j++) {
>                 int k;
>
> @@ -164,6 +167,23 @@ void dce110_fill_display_configs(
>                 cfg->v_refresh /=3D stream->timing.h_total;
>                 cfg->v_refresh =3D (cfg->v_refresh + stream->timing.v_tot=
al / 2)
>                                                         / stream->timing.=
v_total;
> +
> +               /* Find first CRTC index and calculate its line time.
> +                * This is necessary for DPM on SI GPUs.
> +                */
> +               if (cfg->pipe_idx < pp_display_cfg->crtc_index) {
> +                       const struct dc_crtc_timing *timing =3D
> +                               &context->streams[0]->timing;
> +
> +                       pp_display_cfg->crtc_index =3D cfg->pipe_idx;
> +                       pp_display_cfg->line_time_in_us =3D
> +                               timing->h_total * 10000 / timing->pix_clk=
_100hz;
> +               }
> +       }
> +
> +       if (!num_cfgs) {
> +               pp_display_cfg->crtc_index =3D 0;
> +               pp_display_cfg->line_time_in_us =3D 0;
>         }
>
>         pp_display_cfg->display_count =3D num_cfgs;
> @@ -232,16 +252,6 @@ void dce11_pplib_apply_display_requirements(
>
>         dce110_fill_display_configs(context, pp_display_cfg);
>
> -       /* TODO: is this still applicable?*/
> -       if (pp_display_cfg->display_count =3D=3D 1) {
> -               const struct dc_crtc_timing *timing =3D
> -                       &context->streams[0]->timing;
> -
> -               pp_display_cfg->crtc_index =3D
> -                       pp_display_cfg->disp_configs[0].pipe_idx;
> -               pp_display_cfg->line_time_in_us =3D timing->h_total * 100=
00 / timing->pix_clk_100hz;
> -       }
> -
>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, si=
zeof(*pp_display_cfg)) !=3D  0)
>                 dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg)=
;
>  }
> --
> 2.50.1
>
