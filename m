Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA386C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jan 2022 21:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0380010E13F;
	Sat,  8 Jan 2022 21:17:42 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C10A10E13F
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jan 2022 21:17:40 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 g79-20020a9d12d5000000b0058f08f31338so10872840otg.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Jan 2022 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gjk09K9pnAzRY4DF+EYkRUU9ktl6EtmSnOGC3XcZHu4=;
 b=FysEP6brxLonUc9IgKK5SgIhAXoA8xMUpgoN0BB65pGn2yvwba80A/F/ECSWFcCkR+
 3yBEUWI2uhyhkZlMBlNj7CN7iE35TyAE2UnUFPGha1DyMzPTcA3y455fXSowyFncQphy
 5TBrA2anXg1164do66erqnsO0Vp74/TGGwA0VbY7r3SUDkjdZZes1dFcFiDiBXB91h8a
 QLHyOwGG3dV7LrYee5xK/OAa3i4HjI8rv9cC7oCevI8A/mz5+1ud190AmL2TlmHO4yXG
 1TvSjpiBODxJ0jH7+5VM+baTQ7+q8Uo/ICGv4xqYUkmhCwhM7ixTjxiw/JosdcguefwH
 88XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gjk09K9pnAzRY4DF+EYkRUU9ktl6EtmSnOGC3XcZHu4=;
 b=IAsMP+t9ajWntr8sLLSzuNiFvcNPon/OllzDpen81HXFVkGky5OnY+/Xlxo8FZRsCw
 XoddtZPbpm7MkNFpYJIha5zTU4zY0x/UaKgRS3BubkwSTukwtj3psYESc2LnEslwFeNE
 K9faPI/nd2uL3zXMMuKOq5AbnDSg2oEgR6LkUVTj0DbUYh/5uqmcxnCAIdgZznjTleV/
 /NJZe580w1Kzy/Njdu4z3WFw40efnKEBIemm9ygSnfaVcROLOvSDZKyr/XLNdH2kZ4kH
 kHxKqL0kpU7r/FSsBFBUhlxjJ7RtEunJ/1xlJiRuluDVKEpmv6KdS88+glVmxH+IGSSF
 zJFQ==
X-Gm-Message-State: AOAM533WguZPOskvHZKnx4P2RO4fq1MgLP6izdFAwkmLDFJo39NuxtZu
 FTBWDltyGNFuYhNjVdHHay6FsWPeGFC+nUjWkbjz2FzEjI0=
X-Google-Smtp-Source: ABdhPJyX28fseYLpJ4TaEbCSpyaprrZWZrcR1Oxx2/ksulv3lqIoIn/blXSLYl2lw9CulFI7KiKsBjC269gm8NQ9494=
X-Received: by 2002:a9d:f09:: with SMTP id 9mr5321663ott.299.1641676659915;
 Sat, 08 Jan 2022 13:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
 <20211217212407.3583190-11-Rodrigo.Siqueira@amd.com>
 <BL1PR12MB5144269CBE04ED1053012CEBF7789@BL1PR12MB5144.namprd12.prod.outlook.com>
 <0e7cdf85-c330-ccf0-0401-0fee61faa621@amd.com>
 <CADnq5_Ns=TnYAq4sU86pOQRna=y45kd9P=OSEveSpX0kd-Afjg@mail.gmail.com>
In-Reply-To: <CADnq5_Ns=TnYAq4sU86pOQRna=y45kd9P=OSEveSpX0kd-Afjg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 8 Jan 2022 16:17:28 -0500
Message-ID: <CADnq5_My_Uvf0-AWJsPTm7mDSSBaLnWzq11GFdnDJo4Sg5BVAQ@mail.gmail.com>
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

On Tue, Dec 21, 2021 at 3:40 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Dec 17, 2021 at 4:51 PM Rodrigo Siqueira Jordao
> <rjordrigo@amd.com> wrote:
> >
> >
> >
> > On 2021-12-17 4:36 p.m., Deucher, Alexander wrote:
> > > [AMD Official Use Only]
> > >
> > >
> > > Maybe add Bug links for:
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/1522
> > > <https://gitlab.freedesktop.org/drm/amd/-/issues/1522>
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/1709
> > > <https://gitlab.freedesktop.org/drm/amd/-/issues/1709>
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/1655
> > > <https://gitlab.freedesktop.org/drm/amd/-/issues/1655>
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/1403
> > > <https://gitlab.freedesktop.org/drm/amd/-/issues/1403>
> >
> > Sure, I'll update the commit message before apply this patch.
> >
> > Thanks.
> >
> > >
> > >
> > >
> > > ------------------------------------------------------------------------
> > > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > > Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > *Sent:* Friday, December 17, 2021 4:23 PM
> > > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > *Cc:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Cyr, Aric
> > > <Aric.Cyr@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland,
> > > Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian)
> > > <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
> > > Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>;
> > > Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wang, Angus
> > > <Angus.Wang@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita
> > > <Mikita.Lipski@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>;
> > > Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle
> > > <Pavle.Kotarac@amd.com>
> > > *Subject:* [PATCH 10/19] drm/amd/display: Changed pipe split policy to
> > > allow for multi-display pipe split
> > > From: Angus Wang <angus.wang@amd.com>
> > >
> > > [WHY]
> > > Current implementation of pipe split policy prevents pipe split with
> > > multiple displays connected, which caused the MCLK speed to be stuck at
> > > max
> > >
> > > [HOW]
> > > Changed the pipe split policies so that pipe split is allowed for
> > > multi-display configurations
> > >
> > > Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> > > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > Signed-off-by: Angus Wang <angus.wang@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
>
> Also, it looks like dcn10_resource.c was missed.  Was that intentional?

Ping on this.  Changing dcn10_resource.c as well fixes:
https://gitlab.freedesktop.org/drm/amd/-/issues/1522

Alex


>
> Alex
>
>
> > >   8 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > index 2a72517e2b28..2bc93df023ad 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > @@ -1069,7 +1069,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >                   .timing_trace = false,
> > >                   .clock_trace = true,
> > >                   .disable_pplib_clock_request = true,
> > > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >                   .force_single_disp_pipe_split = false,
> > >                   .disable_dcc = DCC_ENABLE,
> > >                   .vsr_support = true,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > > index d6acf9a8590a..0bb7d3dd53fa 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> > > @@ -603,7 +603,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >                   .timing_trace = false,
> > >                   .clock_trace = true,
> > >                   .disable_pplib_clock_request = true,
> > > -               .pipe_split_policy = MPC_SPLIT_AVOID,
> > > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >                   .force_single_disp_pipe_split = false,
> > >                   .disable_dcc = DCC_ENABLE,
> > >                   .vsr_support = true,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > > index ca1bbc942fd4..e5cc6bf45743 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > > @@ -873,7 +873,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >                   .clock_trace = true,
> > >                   .disable_pplib_clock_request = true,
> > >                   .min_disp_clk_khz = 100000,
> > > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >                   .force_single_disp_pipe_split = false,
> > >                   .disable_dcc = DCC_ENABLE,
> > >                   .vsr_support = true,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > > index 369ceeeddc7e..e12660c609ee 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > > @@ -840,7 +840,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >           .timing_trace = false,
> > >           .clock_trace = true,
> > >           .disable_pplib_clock_request = true,
> > > -       .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > > +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >           .force_single_disp_pipe_split = false,
> > >           .disable_dcc = DCC_ENABLE,
> > >           .vsr_support = true,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > > index b4001233867c..c1c6e602b06c 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> > > @@ -686,7 +686,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >           .disable_clock_gate = true,
> > >           .disable_pplib_clock_request = true,
> > >           .disable_pplib_wm_range = true,
> > > -       .pipe_split_policy = MPC_SPLIT_AVOID,
> > > +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >           .force_single_disp_pipe_split = false,
> > >           .disable_dcc = DCC_ENABLE,
> > >           .vsr_support = true,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > > index 003e95368672..2e9cbfa7663b 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> > > @@ -211,7 +211,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >                   .timing_trace = false,
> > >                   .clock_trace = true,
> > >                   .disable_pplib_clock_request = true,
> > > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >                   .force_single_disp_pipe_split = false,
> > >                   .disable_dcc = DCC_ENABLE,
> > >                   .vsr_support = true,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > > index 01ba9d656c72..2de687f64cf6 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> > > @@ -193,7 +193,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >                   .timing_trace = false,
> > >                   .clock_trace = true,
> > >                   .disable_pplib_clock_request = true,
> > > -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> > > +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >                   .force_single_disp_pipe_split = false,
> > >                   .disable_dcc = DCC_ENABLE,
> > >                   .vsr_support = true,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > > index 6d07dcecc953..7c64317a56f7 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > > @@ -1003,7 +1003,7 @@ static const struct dc_debug_options
> > > debug_defaults_drv = {
> > >           .timing_trace = false,
> > >           .clock_trace = true,
> > >           .disable_pplib_clock_request = false,
> > > -       .pipe_split_policy = MPC_SPLIT_AVOID,
> > > +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> > >           .force_single_disp_pipe_split = false,
> > >           .disable_dcc = DCC_ENABLE,
> > >           .vsr_support = true,
> > > --
> > > 2.25.1
> > >
> >
