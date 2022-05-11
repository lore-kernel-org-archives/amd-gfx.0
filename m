Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359A4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 15:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D978210FB71;
	Wed, 11 May 2022 15:35:47 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FDF10FB71
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 15:35:46 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-ed9a75c453so3214593fac.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HtgzsgpjLWHpoH55Q6hpRW6WZQsnNhRS46vTFPNSZqU=;
 b=gagxTvsAFaMGsPZIRjyHX+8xPUCsD1c4gspeaKMpVgrTs4xB7mD2iH5fCFJLFtN8Ej
 X97y7Dds5jKSlHSV0Q5mi2B+TscPOEVDifmdAJGXFWgGYVdUKtlRS5XvBGB0rDOXxk88
 ch7wVoA5iUlCLnDXTF1mPc7WQCZQ+yJhOF1AmgJmnFa/G7c7cUfb1PlxkQB4Vxx7Nydg
 YhcVdvGjgLxyu9ftZ5ZqnKPD289XAtWGc6wOsBXvzDADaNBHEZ0ODbPKNMC2K+XM5xdY
 4U1DFhqySVnkVxLe+as0VqakrzBREFtCc0mmNcQpJou5EWUSoaebuRTI0PTjEJP33LzP
 8iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HtgzsgpjLWHpoH55Q6hpRW6WZQsnNhRS46vTFPNSZqU=;
 b=ZlMCFDVKP9iAoTUq2hwNhOuK8zYcZhGGe4XTxfLVfETobPWCd0BgaMqH4rMjWrbJoe
 NV/VN1QW83ENG+vAPgbz/5bu9XsXC1Yp4MwAHs7ZPG4za+yn+EQ1wdK4Y4dSLsZiGdCw
 uZSJIdgIVwiccJHZGg8W77cy8ro++Adq3q+DWBUODZKjMUb8QbuoFH0hAuSOwwi3QZej
 cetvT38LA9dsSML/i4AzMAPEarpSlteh3I1W9420trnBeBhag6Xa5qtkftrd7MxOkl7y
 rnR4+ra/RnN3+JTNGkCTxgsEBuYS74jDmSlf9/pSlPfFjfLx9rqXChFY7aoeuJlxtiNZ
 4t1g==
X-Gm-Message-State: AOAM532wLFhovIdtobjmCoFY+1wqwaqHFkPxAmPKvnpfw8xJl/nhKYIE
 N/9pWfC5Cupu4x7W0VajlVZ9pP2E0JWwHQOCYqCfjBPsHek=
X-Google-Smtp-Source: ABdhPJyZS8cMKKoKWJfEGFFw4ZFQzsAJSz5ImJlg0dNAi/W2G6q1A2DA4xf5My3A7Sg/7Okr7lCeLWrMC3zldNf8TFM=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr2851690oaa.200.1652283345944; Wed, 11
 May 2022 08:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 May 2022 11:35:34 -0400
Message-ID: <CADnq5_PZVo0GkkLqnhDA8THxQ2wgqx7zt1cARx+tTnsYo5gAOg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
To: David Zhang <dingchen.zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
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
Cc: Stylon Wang <stylon.wang@amd.com>,
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

On Tue, May 10, 2022 at 4:45 PM David Zhang <dingchen.zhang@amd.com> wrote:
>
> changes in v2:
> -----------------------
> - set vsc_packet_rev2 for PSR1 which is safer
> - add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control)
> - add DC/DM change related to amdgpu PSR-SU-RC
>
>
> David Zhang (18):
>   drm/amd/display: align dmub cmd header to latest dmub FW to support
>     PSR-SU
>   drm/amd/display: feed PSR-SU as psr version to dmub FW
>   drm/amd/display: combine dirty rectangles in DMUB FW
>   drm/amd/display: update GSP1 generic info packet for PSRSU
>   drm/amd/display: revise Start/End SDP data
>   drm/amd/display: program PSR2 DPCD Configuration
>   drm/amd/display: Passing Y-granularity to dmub fw
>   drm/amd/display: Set default value of line_capture_indication
>   drm/amd/display: add vline time in micro sec to PSR context
>   drm/amd/display: fix system hang when PSR exits
>   drm/amd/display: Set PSR level to enable ALPM by default
>   drm/amd/display: use HW lock mgr for PSR-SU
>   drm/amd/display: PSRSU+DSC WA for specific TCON
>   drm/amd/display: add shared helpers to update psr config fields to
>     power module
>   drm/amd/display: calculate psr config settings in runtime in DM
>   drm/amd/display: update cursor position to DMUB FW
>   drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
>     support
>   drm/amd/display: PSR-SU rate control support in DC
>
> Leo Li (1):
>   drm/amd/display: Implement MPO PSR SU

A couple of suggestions from Daniel on IRC:
1.  Might be good to extract the "calculate total crtc damage" code
from i915 in intel_psr2_sel_fetch_update, stuff that into damage
helpers and reuse for i915 and amdgpu
2.  The commit message on "drm/amd/display: Implement MPO PSR SU" is a
bit funny, since if you use the helpers right you always get damage
information, just when it's from userspace that doesn't set explicit
damage it's just always the entire plane.

Alex

>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
>  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
>  .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
>  .../amd/display/include/ddc_service_types.h   |   1 +
>  .../display/modules/info_packet/info_packet.c |  29 +-
>  .../amd/display/modules/power/power_helpers.c |  84 ++++++
>  .../amd/display/modules/power/power_helpers.h |   6 +
>  21 files changed, 887 insertions(+), 19 deletions(-)
>
> --
> 2.25.1
>
