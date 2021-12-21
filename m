Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7F2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 20:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA1ED10F0B0;
	Tue, 21 Dec 2021 20:40:59 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DED110F0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 20:40:57 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 35-20020a9d08a6000000b00579cd5e605eso58093otf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rGoBJKSO8Y2r6NZ0KD+/k/BxYOmwq4PD5I5F1i0OQPc=;
 b=Q858qVZ7xvt6TbzMuuBIFus1sSdMIb4Vi4rPs+HCFwQllEWVrvZl/YihJlZNKsz0kY
 FtXefsJ78TPf/lEOXQX9sgJdrljeUyxFSAA/RWynGMI8WHAbT8G4Wir6rHQx+79cMDLb
 UMNW7nF3Oyvqu/KqfW2BefNtCfLhTTohzu20KxA0Oo0T+31GaAy0i3z1r9UjDAJxCsWz
 jQIM7tcP/d4P/Qe1RYMfsxJmECIydkgGw4Q2fCy1LzNdMXGQlMIR8N7rNldYTmTUtIgE
 thTBkdFJqJlTtvqhrh++8+7qAKEqyt4CdB7LeV3BEECC9z/RyiKYUWgX+NjdFyX3OvY+
 LXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rGoBJKSO8Y2r6NZ0KD+/k/BxYOmwq4PD5I5F1i0OQPc=;
 b=E7W3QTBoVq/TCVVhH3FX9/BUrSUQcNCecupTEWJvJdQYIFZylc9P4zhkyPRW9+rxNp
 h7BDk/0al1g/gUQ++i6c4cOT9DZ00VJsLJuU/uzjFWEFvXNxgfCGz8X8NnpY8SCUsB2g
 P5QB84MwMv+CaXdFuLIowyKv2SbRtupc5xPMiiBhZHmZ+KioY+q6SoPJZrr8NeAcl1B8
 4na8xeppp20ChFWB7gjjZpSzTrYZ7nndXPp4pSOFq10w10Nk1qNxtD0LX14Lf5jCuST/
 he1IjCQoG6Ue6W+5XZtw5Ww9/sa297i//40MoOJTEit6khNJ4t5YnJIq3dH++5hXtNEC
 XIxQ==
X-Gm-Message-State: AOAM533T7HwY+3Kv730+aKeS8fMGtZWaaAyyXcGWRCC2Psxqk/w6daWR
 EVJ9yN2Vjva/OprDdMKEQRCNsvwxbojhocO0cADV19KkJz8=
X-Google-Smtp-Source: ABdhPJynryFO6e+p04FRs1ONqtHwS3HrQjvs7b0da2rdOYqZdB60GOYFcR7/bkJwx+vk8wstNqr50ul6EUZkBcnTLEI=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr74305ota.200.1640119256905; 
 Tue, 21 Dec 2021 12:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
 <20211217212407.3583190-11-Rodrigo.Siqueira@amd.com>
 <BL1PR12MB5144269CBE04ED1053012CEBF7789@BL1PR12MB5144.namprd12.prod.outlook.com>
 <0e7cdf85-c330-ccf0-0401-0fee61faa621@amd.com>
In-Reply-To: <0e7cdf85-c330-ccf0-0401-0fee61faa621@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Dec 2021 15:40:45 -0500
Message-ID: <CADnq5_Ns=TnYAq4sU86pOQRna=y45kd9P=OSEveSpX0kd-Afjg@mail.gmail.com>
Subject: Re: [PATCH 10/19] drm/amd/display: Changed pipe split policy to allow
 for multi-display pipe split
To: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr,
 Aric" <Aric.Cyr@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wang, Angus" <Angus.Wang@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Lipski,
 Mikita" <Mikita.Lipski@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 17, 2021 at 4:51 PM Rodrigo Siqueira Jordao
<rjordrigo@amd.com> wrote:
>
>
>
> On 2021-12-17 4:36 p.m., Deucher, Alexander wrote:
> > [AMD Official Use Only]
> >
> >
> > Maybe add Bug links for:
> > https://gitlab.freedesktop.org/drm/amd/-/issues/1522
> > <https://gitlab.freedesktop.org/drm/amd/-/issues/1522>
> > https://gitlab.freedesktop.org/drm/amd/-/issues/1709
> > <https://gitlab.freedesktop.org/drm/amd/-/issues/1709>
> > https://gitlab.freedesktop.org/drm/amd/-/issues/1655
> > <https://gitlab.freedesktop.org/drm/amd/-/issues/1655>
> > https://gitlab.freedesktop.org/drm/amd/-/issues/1403
> > <https://gitlab.freedesktop.org/drm/amd/-/issues/1403>
>
> Sure, I'll update the commit message before apply this patch.
>
> Thanks.
>
> >
> >
> >
> > ------------------------------------------------------------------------
> > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > *Sent:* Friday, December 17, 2021 4:23 PM
> > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > *Cc:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Cyr, Aric
> > <Aric.Cyr@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland,
> > Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian)
> > <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
> > Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>;
> > Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wang, Angus
> > <Angus.Wang@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita
> > <Mikita.Lipski@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>;
> > Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle
> > <Pavle.Kotarac@amd.com>
> > *Subject:* [PATCH 10/19] drm/amd/display: Changed pipe split policy to
> > allow for multi-display pipe split
> > From: Angus Wang <angus.wang@amd.com>
> >
> > [WHY]
> > Current implementation of pipe split policy prevents pipe split with
> > multiple displays connected, which caused the MCLK speed to be stuck at
> > max
> >
> > [HOW]
> > Changed the pipe split policies so that pipe split is allowed for
> > multi-display configurations
> >
> > Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Signed-off-by: Angus Wang <angus.wang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
> >   drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-
> >   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 +-
> >   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
> >   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
> >   drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
> >   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
> >   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-

Also, it looks like dcn10_resource.c was missed.  Was that intentional?

Alex


> >   8 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > index 2a72517e2b28..2bc93df023ad 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > @@ -1069,7 +1069,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >                   .timing_trace = false,
> >                   .clock_trace = true,
> >                   .disable_pplib_clock_request = true,
> > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >                   .force_single_disp_pipe_split = false,
> >                   .disable_dcc = DCC_ENABLE,
> >                   .vsr_support = true,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > index d6acf9a8590a..0bb7d3dd53fa 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > @@ -603,7 +603,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >                   .timing_trace = false,
> >                   .clock_trace = true,
> >                   .disable_pplib_clock_request = true,
> > -               .pipe_split_policy = MPC_SPLIT_AVOID,
> > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >                   .force_single_disp_pipe_split = false,
> >                   .disable_dcc = DCC_ENABLE,
> >                   .vsr_support = true,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > index ca1bbc942fd4..e5cc6bf45743 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > @@ -873,7 +873,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >                   .clock_trace = true,
> >                   .disable_pplib_clock_request = true,
> >                   .min_disp_clk_khz = 100000,
> > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >                   .force_single_disp_pipe_split = false,
> >                   .disable_dcc = DCC_ENABLE,
> >                   .vsr_support = true,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > index 369ceeeddc7e..e12660c609ee 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > @@ -840,7 +840,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >           .timing_trace = false,
> >           .clock_trace = true,
> >           .disable_pplib_clock_request = true,
> > -       .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >           .force_single_disp_pipe_split = false,
> >           .disable_dcc = DCC_ENABLE,
> >           .vsr_support = true,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > index b4001233867c..c1c6e602b06c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > @@ -686,7 +686,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >           .disable_clock_gate = true,
> >           .disable_pplib_clock_request = true,
> >           .disable_pplib_wm_range = true,
> > -       .pipe_split_policy = MPC_SPLIT_AVOID,
> > +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >           .force_single_disp_pipe_split = false,
> >           .disable_dcc = DCC_ENABLE,
> >           .vsr_support = true,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > index 003e95368672..2e9cbfa7663b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > @@ -211,7 +211,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >                   .timing_trace = false,
> >                   .clock_trace = true,
> >                   .disable_pplib_clock_request = true,
> > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >                   .force_single_disp_pipe_split = false,
> >                   .disable_dcc = DCC_ENABLE,
> >                   .vsr_support = true,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > index 01ba9d656c72..2de687f64cf6 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > @@ -193,7 +193,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >                   .timing_trace = false,
> >                   .clock_trace = true,
> >                   .disable_pplib_clock_request = true,
> > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >                   .force_single_disp_pipe_split = false,
> >                   .disable_dcc = DCC_ENABLE,
> >                   .vsr_support = true,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > index 6d07dcecc953..7c64317a56f7 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > @@ -1003,7 +1003,7 @@ static const struct dc_debug_options
> > debug_defaults_drv = {
> >           .timing_trace = false,
> >           .clock_trace = true,
> >           .disable_pplib_clock_request = false,
> > -       .pipe_split_policy = MPC_SPLIT_AVOID,
> > +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> >           .force_single_disp_pipe_split = false,
> >           .disable_dcc = DCC_ENABLE,
> >           .vsr_support = true,
> > --
> > 2.25.1
> >
>
