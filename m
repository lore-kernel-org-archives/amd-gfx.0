Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B742C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 20:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C78610E3FF;
	Mon, 24 Jan 2022 20:04:20 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE08010E3FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 20:04:18 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id g205so27269931oif.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FY3ybORuPx/bi6G+4wzdBWM586AxVF8SB3NsHEe/o+o=;
 b=Lv/BMBl/sYkF+UWcWao1Udsoc+xApRvvckKO80iHOD3KdIK31uwe89m+dYEnMtBuRD
 wEAWMcUYD+fGbER+pWx9M7p8wMNqpFPi6fLlMkb4P18I5vzm0rwmKZ71pFnS4RyZlRlv
 UcuQra9k46BXlI6OrehudZG7osYrnfow5gflkpjr4fgVLqYJ0QSdPmc2gqc2uEoXCDWm
 GkZ5GMP1Zlj229HqgjMDVkz7eFkVIZ+1rRaC2pDxEjFM5xvL0KBCzFtoxe73gqeHFr2o
 kRuwHIAvYzSaJsNZsAs7JiUV9oM/yzRnVCR9YBjqqKhVYW7z/r0QKIgmcBJIenQTf/V6
 toWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FY3ybORuPx/bi6G+4wzdBWM586AxVF8SB3NsHEe/o+o=;
 b=ya4IsckTxHdDo7Ho42WFyMuu9OP9FvQ9xt5a1rKEmDtZuvXIYVwLDhelGtPHNZemDG
 0R1ELqvmQqbMFwFk3uBTCBkQooeV6VT6uRTI/XTiS+44+zWuHUXuCQNbqBwNn0ofczyT
 VAa2qhLmc186j00jCJ2Z+wlfx1p5J8b4gAzZqnau/0BN89HMTmSiustRUAXphWF1Ls8W
 8BRdAVwISHh05RyDgXIAS4XObCrCBfzuTlHQZBB61AKc7YoKphgYhkC/0ojjaR5tgtXP
 XiKXrfKzQhNeiNJRLqWiKgUOhfarxfBmn308HoinupJuVUsmH4r+6e1C8sgUk5Pa2vZQ
 1hlg==
X-Gm-Message-State: AOAM530wO4QEg4PYYTcBgGm3uxSAMmDqRe4f3eId76vF5mMFrWzM78Sx
 yVO5/jzuatBD7LrrslawBe7p01Dv5MP2R7AtHdM=
X-Google-Smtp-Source: ABdhPJwmQ0ALL3egj7ujhs0CN6wjC+qoyudaOSB5p+jPdpVakEAMgsH6gvd46T712LgPJO6PJRwlSMEO17mLkKAl6F8=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr2886814oib.120.1643054658246; 
 Mon, 24 Jan 2022 12:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20220124002336.3455326-1-bas@basnieuwenhuizen.nl>
 <20220124002336.3455326-2-bas@basnieuwenhuizen.nl>
In-Reply-To: <20220124002336.3455326-2-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jan 2022 15:04:07 -0500
Message-ID: <CADnq5_Mj9KTxUi5ki6bg8u81aEOhPHvwrZMU68q-K4za33Y-=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Wrap dcn301_calculate_wm_and_dlg for
 FPU.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, Zhan Liu <Zhan.Liu@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <harry.wentland@amd.com>,
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied the series.  Thanks!

Alex

On Sun, Jan 23, 2022 at 7:23 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> Mirrors the logic for dcn30. Cue lots of WARNs and some
> kernel panics without this fix.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  .../gpu/drm/amd/display/dc/dcn301/dcn301_resource.c   | 11 +++++++++++
>  .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c    |  2 +-
>  .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h    |  2 +-
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index b4001233867c..5d9637b07429 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1380,6 +1380,17 @@ static void set_wm_ranges(
>         pp_smu->nv_funcs.set_wm_ranges(&pp_smu->nv_funcs.pp_smu, &ranges);
>  }
>
> +static void dcn301_calculate_wm_and_dlg(
> +               struct dc *dc, struct dc_state *context,
> +               display_e2e_pipe_params_st *pipes,
> +               int pipe_cnt,
> +               int vlevel)
> +{
> +       DC_FP_START();
> +       dcn301_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
> +       DC_FP_END();
> +}
> +
>  static struct resource_funcs dcn301_res_pool_funcs = {
>         .destroy = dcn301_destroy_resource_pool,
>         .link_enc_create = dcn301_link_encoder_create,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> index 94c32832a0e7..0a7a33864973 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> @@ -327,7 +327,7 @@ void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
>                 dcn3_01_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
>  }
>
> -void dcn301_calculate_wm_and_dlg(struct dc *dc,
> +void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
>                 struct dc_state *context,
>                 display_e2e_pipe_params_st *pipes,
>                 int pipe_cnt,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
> index fc7065d17842..774b0fdfc80b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
> @@ -34,7 +34,7 @@ void dcn301_fpu_set_wm_ranges(int i,
>
>  void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
>
> -void dcn301_calculate_wm_and_dlg(struct dc *dc,
> +void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
>                 struct dc_state *context,
>                 display_e2e_pipe_params_st *pipes,
>                 int pipe_cnt,
> --
> 2.34.1
>
