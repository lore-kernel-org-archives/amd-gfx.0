Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C37C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 19:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71AA10E44B;
	Tue, 25 Jan 2022 19:16:19 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6072210E44B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 19:16:19 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id u129so6903776oib.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5QnJ7Q9MQbhehcIC1XkJF+6Vkp2+lkLWGRX6Bu0cQ3g=;
 b=cOFmaBjljgPk4vnkgKnllfoGbbWxIN88emVsMqUrDHDpZt/DxzO4U0dfRXxeqi96JU
 YBUUl9Yna0JjQhZIoMN5+d4tifkVjaFH21Z9v/fh8N1rKV/gcxw4bF1cnL046EQ2b5O7
 UqQnMAL4Fh5USl1mi3hSUYkijqFYcbfm0BnTx/7NWmLDkYO8n1pT9zfAc3AaYLkffYFU
 IM5c7uwCySU/zXWh/2QJO1DTySnPZwPSN9eqXt6hqm8lsWWB9wg/YJ6MzGAgV9xx1xDo
 YaTSC77q/UWcMqGf8ZOXBm757+1u6kXyYsq4I0zybERSpf51/fyBsE+Wd6UWgK96tRlf
 nnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5QnJ7Q9MQbhehcIC1XkJF+6Vkp2+lkLWGRX6Bu0cQ3g=;
 b=ix9wO+0Sho/rT3u2EiM9mD/XAn9b/8HlhdRX6Khz1CTQRBie33lPhNMbcxbNuKgbhH
 ur6JIojomEsQMIWpm5Kwe7tMewC3LzOtFVxMq+oWVNPiowu4jxZWlQnEbDjL//MoHy0j
 9L+QNsNplMrMVMvsqEHNGEhfU/4MeeEJTfnIJ/RDCudFGaF5wjK40+6BpkUwTF72jNnc
 xzJXBL6nKpq0yA6rs3QJIzKPfN6LUcBSnHknDyQPGfwYM3xq/yU2noRNYt3LcTAmanyn
 IomC8Pg1fArdPInXZx6OxceqLriu/HMWFJMjIGWqD8oQ1Vs3MNJPhumzo4rjEbz5ogCs
 YQzg==
X-Gm-Message-State: AOAM533gYE0CsZOrCUcsfKd3Sa5pP/osPg/QW5HYFswzewvSqiuZBfY7
 8WPfCkUXqYvgNeaUXUkPtxJ0HZ9lKoOGpglMRBFNX//0
X-Google-Smtp-Source: ABdhPJx/PeTqVWkmiQMPhBXEzWOEhoZ+Db7VfDYwhT4z03qsR//VGyZQNCwY0/1t1WGMEQdlVz9tk1yYbdqkwe48PsY=
X-Received: by 2002:a05:6808:2097:: with SMTP id
 s23mr1600929oiw.132.1643138178591; 
 Tue, 25 Jan 2022 11:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20220123023828.1443906-1-bas@basnieuwenhuizen.nl>
 <91db873b-ed16-54a7-70cc-062f943d2df7@amd.com>
In-Reply-To: <91db873b-ed16-54a7-70cc-062f943d2df7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 14:16:07 -0500
Message-ID: <CADnq5_MhEs=JgboSsyHsPkOJje-svsTQmkyz0uO0RUjaYj0jeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: Remove t_srx_delay_us.
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, Zhan Liu <Zhan.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Jan 25, 2022 at 12:53 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-01-22 21:38, Bas Nieuwenhuizen wrote:
> > Unused. Convert the divisions into asserts on the divisor, to
> > debug why it is zero. The divide by zero is suspected of causing
> > kernel panics.
> >
> > While I have no idea where the zero is coming from I think this
> > patch is a positive either way.
> >
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c          | 1 -
> >  .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 2 --
> >  .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 2 --
> >  .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c | 2 --
> >  .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c | 2 --
> >  drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h     | 1 -
> >  drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c   | 3 ---
> >  drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 4 ----
> >  8 files changed, 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> > index ec19678a0702..e447c74be713 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> > @@ -503,7 +503,6 @@ static void dcn_bw_calc_rq_dlg_ttu(
> >       //input[in_idx].dout.output_standard;
> >
> >       /*todo: soc->sr_enter_plus_exit_time??*/
> > -     dlg_sys_param->t_srx_delay_us = dc->dcn_ip->dcfclk_cstate_latency / v->dcf_clk_deep_sleep;
> >
> >       dml1_rq_dlg_get_rq_params(dml, rq_param, &input->pipe.src);
> >       dml1_extract_rq_regs(dml, rq_regs, rq_param);
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> > index 246071c72f6b..548cdef8a8ad 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> > @@ -1576,8 +1576,6 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
> >       dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
> >                       e2e_pipe_param,
> >                       num_pipes);
> > -     dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> > -                     / dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
> >
> >       print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> > index 015e7f2c0b16..0fc9f3e3ffae 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> > @@ -1577,8 +1577,6 @@ void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
> >       dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
> >                       e2e_pipe_param,
> >                       num_pipes);
> > -     dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> > -                     / dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
> >
> >       print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> > index 8bc27de4c104..618f4b682ab1 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> > @@ -1688,8 +1688,6 @@ void dml21_rq_dlg_get_dlg_reg(
> >                       mode_lib,
> >                       e2e_pipe_param,
> >                       num_pipes);
> > -     dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> > -                     / dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
> >
> >       print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > index aef854270054..747167083dea 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > @@ -1858,8 +1858,6 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
> >       dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
> >               e2e_pipe_param,
> >               num_pipes);
> > -     dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> > -             / dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
> >
> >       print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> > index d46a2733024c..8f9f1d607f7c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> > @@ -546,7 +546,6 @@ struct _vcs_dpi_display_dlg_sys_params_st {
> >       double t_sr_wm_us;
> >       double t_extra_us;
> >       double mem_trip_us;
> > -     double t_srx_delay_us;
> >       double deepsleep_dcfclk_mhz;
> >       double total_flip_bw;
> >       unsigned int total_flip_bytes;
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> > index 71ea503cb32f..412e75eb4704 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> > @@ -141,9 +141,6 @@ void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _v
> >       dml_print("DML_RQ_DLG_CALC:    t_urg_wm_us          = %3.2f\n", dlg_sys_param->t_urg_wm_us);
> >       dml_print("DML_RQ_DLG_CALC:    t_sr_wm_us           = %3.2f\n", dlg_sys_param->t_sr_wm_us);
> >       dml_print("DML_RQ_DLG_CALC:    t_extra_us           = %3.2f\n", dlg_sys_param->t_extra_us);
> > -     dml_print(
> > -                     "DML_RQ_DLG_CALC:    t_srx_delay_us       = %3.2f\n",
> > -                     dlg_sys_param->t_srx_delay_us);
> >       dml_print(
> >                       "DML_RQ_DLG_CALC:    deepsleep_dcfclk_mhz = %3.2f\n",
> >                       dlg_sys_param->deepsleep_dcfclk_mhz);
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
> > index 59dc2c5b58dd..3df559c591f8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
> > @@ -1331,10 +1331,6 @@ void dml1_rq_dlg_get_dlg_params(
> >       if (dual_plane)
> >               DTRACE("DLG: %s: swath_height_c     = %d", __func__, swath_height_c);
> >
> > -     DTRACE(
> > -                     "DLG: %s: t_srx_delay_us     = %3.2f",
> > -                     __func__,
> > -                     (double) dlg_sys_param->t_srx_delay_us);
> >       DTRACE("DLG: %s: line_time_in_us    = %3.2f", __func__, (double) line_time_in_us);
> >       DTRACE("DLG: %s: vupdate_offset     = %d", __func__, vupdate_offset);
> >       DTRACE("DLG: %s: vupdate_width      = %d", __func__, vupdate_width);
>
