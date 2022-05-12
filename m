Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F528C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 11:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48EA10FAA5;
	Thu, 12 May 2022 11:22:31 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A6510FAA5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 11:22:30 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 c22-20020a4ad216000000b0035f13ae7646so2069743oos.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dv5cws9I6L4dqavuuDJsPqg6WpTLxZDB4D2nu5IxzyE=;
 b=GSY9rNoebI9qR0kRXR7xuCxKcw6ws9lV02Z41pm0lvzMuZ55kjC5fGtYHd/Rn9tipt
 n7T0oFWTUebnWiceGRPavVWRgLqDYKKKpthUs+NFr+kkSokH7og5VbwXSCefLlTZqc18
 mF2gi5ycitBghByVB1inG5P+tqagSu3EOLJDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dv5cws9I6L4dqavuuDJsPqg6WpTLxZDB4D2nu5IxzyE=;
 b=EEtENO5xgNXqbiN1LROejPr67SHcF4zykY5b5ZeWTO9HD/35eWKaUX17NB+zbUzsIA
 y4Bgm2OSreNV9DEfaQSlwMmvxfsauO6n3sP38QWlOwuN+IHrH6l3KxWY6U8Lr8l2+w94
 c2skycxAI/ZPZ53B1POaVU501Fe3QIzPuARrzLFcZouACbe379zEfGl8YUcdKTDS8Jvp
 PeTk2QzNCIbL7qZNgElHVWk4RHRxJkz+ZJoDlZBzxx1XTavoLf3EPVb/piwCnVGmFLZS
 KHLBLnOMi/y8KU4S4sTfUs2L2aY/LnRjzne0je1k91h6RKEPFpZ1qGNVNSJj9LKi2Qkg
 H8Bw==
X-Gm-Message-State: AOAM533Fyn+SbJYLp8DF/C6xlM2paakmHK8zx7+8q8A7eLWbrz51QCJV
 uOU/5bStXBnJTNi/y3jnU/C4hsWeHOFhFnLSp3JVEw==
X-Google-Smtp-Source: ABdhPJzY6UqYkg2jp7Lr3+B5TeIYLpufdzm81NQrNq8g6493QLALS+HgbB7Jw6pRVlrtjfl7H8IcvqabmSEDtMkNrfs=
X-Received: by 2002:a4a:870d:0:b0:35f:7c65:1340 with SMTP id
 z13-20020a4a870d000000b0035f7c651340mr7799462ooh.46.1652354549827; Thu, 12
 May 2022 04:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
 <CADnq5_PZVo0GkkLqnhDA8THxQ2wgqx7zt1cARx+tTnsYo5gAOg@mail.gmail.com>
In-Reply-To: <CADnq5_PZVo0GkkLqnhDA8THxQ2wgqx7zt1cARx+tTnsYo5gAOg@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 12 May 2022 13:22:18 +0200
Message-ID: <CAKMK7uGMsxAJGaPbPR9fhmdwKgV=hOG73H=Ju0hYU9G=8hfa7A@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: Stylon Wang <stylon.wang@amd.com>, David Zhang <dingchen.zhang@amd.com>,
 "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Solomon Chiu <solomon.chiu@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <agustin.gutierrez@amd.com>, "Kotarac, Pavle" <pavle.kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 11 May 2022 at 17:35, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, May 10, 2022 at 4:45 PM David Zhang <dingchen.zhang@amd.com> wrote:
> >
> > changes in v2:
> > -----------------------
> > - set vsc_packet_rev2 for PSR1 which is safer
> > - add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control)
> > - add DC/DM change related to amdgpu PSR-SU-RC
> >
> >
> > David Zhang (18):
> >   drm/amd/display: align dmub cmd header to latest dmub FW to support
> >     PSR-SU
> >   drm/amd/display: feed PSR-SU as psr version to dmub FW
> >   drm/amd/display: combine dirty rectangles in DMUB FW
> >   drm/amd/display: update GSP1 generic info packet for PSRSU
> >   drm/amd/display: revise Start/End SDP data
> >   drm/amd/display: program PSR2 DPCD Configuration
> >   drm/amd/display: Passing Y-granularity to dmub fw
> >   drm/amd/display: Set default value of line_capture_indication
> >   drm/amd/display: add vline time in micro sec to PSR context
> >   drm/amd/display: fix system hang when PSR exits
> >   drm/amd/display: Set PSR level to enable ALPM by default
> >   drm/amd/display: use HW lock mgr for PSR-SU
> >   drm/amd/display: PSRSU+DSC WA for specific TCON
> >   drm/amd/display: add shared helpers to update psr config fields to
> >     power module
> >   drm/amd/display: calculate psr config settings in runtime in DM
> >   drm/amd/display: update cursor position to DMUB FW
> >   drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
> >     support
> >   drm/amd/display: PSR-SU rate control support in DC
> >
> > Leo Li (1):
> >   drm/amd/display: Implement MPO PSR SU
>
> A couple of suggestions from Daniel on IRC:
> 1.  Might be good to extract the "calculate total crtc damage" code
> from i915 in intel_psr2_sel_fetch_update, stuff that into damage
> helpers and reuse for i915 and amdgpu

To expand a bit on this. There is currently a helper for total damage,
but it's at the fb/plane level for drivers which need to upload
buffers (usb/spi or virtual) drm_atomic_helper_damage_merged(). That
one probably needs to be renamed to signify it's about the plane, and
then we need a new drm_atomic_helper_crtc_damage_merged() which
(extract from i915 code ideally) which computes total crtc damage for
stuff like psr2/su or the command mode dsi panels (unfortunately none
of the drivers for android for these panels have been upstreamed yet).

I also think that the split between dc and kms is a bit funny, I'd put
only the resulting damage rect into dc_pipe and do the computation of
that in the drm/kms linux code outside of dc functions (or in the glue
code for dc), since I'm assuming on windows it's completely different
approach in how you compute damage. Especially once we have the crtc
damage helper on linux.

> 2.  The commit message on "drm/amd/display: Implement MPO PSR SU" is a
> bit funny, since if you use the helpers right you always get damage
> information, just when it's from userspace that doesn't set explicit
> damage it's just always the entire plane.

Yeah so that one was just another reason to use the helpers more in
amdgpu for this.
-Daniel

>
> Alex
>
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
> >  drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
> >  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
> >  drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
> >  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
> >  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
> >  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
> >  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
> >  .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
> >  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
> >  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
> >  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
> >  .../amd/display/include/ddc_service_types.h   |   1 +
> >  .../display/modules/info_packet/info_packet.c |  29 +-
> >  .../amd/display/modules/power/power_helpers.c |  84 ++++++
> >  .../amd/display/modules/power/power_helpers.h |   6 +
> >  21 files changed, 887 insertions(+), 19 deletions(-)
> >
> > --
> > 2.25.1
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
