Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E252EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 20:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75A710E0CC;
	Mon, 10 Jul 2023 20:17:56 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3134110E0CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 20:17:55 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1b0606bee45so4506059fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689020274; x=1691612274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWffbqsc4MWBQ071aWdYNn46dcZh+dWZ87ChTEjds8A=;
 b=CQEfhO4QT+UHrQ8l2DRwzXi1e3P53AtxYp+41gjgENBAUrAAg3FyA3rltYVUEGTj0t
 ofjBT2iK+YwsoPY9cerTsVajDWho9zo+IVhkHUkScnDPq+SN3wNOlAVpmaOJUPJqjZjU
 HlkRcLYzGruF7HpeFW5EauJXvnRTg57byNiY6PZcgzqEssoSbz0GRBnXmhsm943NJnAf
 MYeUPh+njiNh90TPD/8Io+StQFPGodIvMM9zcLiPYYHbCSttYe3U6o1Ah6CiyIrvWujL
 0Thj7+9RjN4L8MrtHaOCvJf9ufvtLV72R6n0M8CUDXvHhWG7fQX0R2nvrUlayfaDZ4oM
 2P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689020274; x=1691612274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWffbqsc4MWBQ071aWdYNn46dcZh+dWZ87ChTEjds8A=;
 b=TEEC0WScR0eH8lnOLcEquvJ9eWOxY+S7Q+zC/DO44JD0gUSj/69q7u0Zw/gpOs7U8S
 zQbM79woiaoFlPvAajtnNjHNDQq07BPApOfmpLUnAe0YoU7xVczphJDzsLHu5Bv6WF/L
 mvHXq/wPSIOpgy9qTDgN2tP9WCC0I+NklDr8AE3FYrE3fqR+KEBb8FbM0Vab8q42Sw7x
 5qDUvCmndJZ/fwp5FVL4SgVFgF/K4/frLX93ZoI4n24q/ogzyqdYNNj5XMYAqcPCM4s1
 N02m2Ft68DnxMpM5e4OpqbVJnfzekrILz+nMERu0QZxep1h2mKt+/uMJ2L+OCVruPzu8
 BUqw==
X-Gm-Message-State: ABy/qLaaVZlULVu8IcuxKOVB/W68aHUQ5R4sjvEvXKtFy/W9DYnral7S
 l+ah/LxtHaCjVMnW+Krumuk8a2bnw+Wd8oEMBE0WncgD
X-Google-Smtp-Source: APBJJlGYGCys21la1USoXbq/lXedt2o+kVIuTho4Kgg76T2N1yYxIv7hhBBQVtbO95+znJUT93dckyTwjKY4EdVLMEw=
X-Received: by 2002:a05:6870:c081:b0:1b0:b15:245 with SMTP id
 c1-20020a056870c08100b001b00b150245mr15042205oad.16.1689020273658; Mon, 10
 Jul 2023 13:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Jul 2023 16:17:42 -0400
Message-ID: <CADnq5_MAhTwsCsmMps7XqEzSAEQ1TV=nf+rnHQs0Amidn4s8KA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Freesync Panel Replay V2
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 10, 2023 at 3:27=E2=80=AFPM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> This patch set introduces Freesync Panel Replay capability on DCN 3.1.4
> and newer. Replay has been verified to be working with these patches (in
> house)
>
> These patches are enabling panel replay in static screen use-cases.
> Other use cases will be added as they are ready
>
>
> The importance of Replay
> ************************
>
> In some instances, the GPU is transmitting repeated frames to the sink
> without any updates or changes in the content. These repeat transmission
> are wasteful, resulting in power draw in different aspects of the system
>
> 1. DCN is fetching the frame of data from DF/UMC/DRAM. This memory traffi=
c
> prevents power down of parts of this HW path.
>
> 2. GPU is transmitting pixel data to the display through the main link of
> the DisplayPort interface. This prevents power down of both the Source
> transmitter (TX) and the Sink receiver (RX)
>
>
>
> How it improves on PSR
> ************************
>
> The concepts of utilizing replay is similar to PSR, but there is a benefi=
t of:
>         Source and Sink remaining synchronized which allows for
>                 - lower latency when switching from replay to live frames
>                 - enable the possibility of more use cases
>                 - easy control of the sink's refresh rate during replay
>
> Due to Source and Sink remaining timing synchronized, Replay can be activ=
ated
> in more UI scenarios.
>
>
> V2: Bug fixes, V1 had some issues which have all been fixed.
>         - Invisible Cursor
>         - Random Hang
>         - Laggy System
>

Are there minimum DMCUB firmware versions required for this?  If so,
we should check before enabling this.

Alex

> Regards,
> Bhawan
>
> Bhawanpreet Lakha (10):
>   drm/amd/display: Add structs for Freesync Panel Replay
>   drm/amd/display: Add Functions to enable Freesync Panel Replay
>   drm/amd/display: Add Freesync Panel DM code
>   drm/amd/display: Read replay data from sink
>   drm/amd/display: Get replay info from VSDB
>   drm/amd/display: Add Replay supported/enabled checks
>   drm/amd/display: Update replay for clk_mgr optimizations
>   drm/amd/display: Update adaptive sync infopackets for replay
>   drm/amd/display: Handle Replay related hpd irq
>   drm/amd/display: Enable Replay for static screen use cases
>
>  .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  71 ++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   9 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 183 ++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  46 ++
>  .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
>  .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  29 ++
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  41 ++
>  drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
>  .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 303 +++++++++++++
>  .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  58 +++
>  .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +
>  .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
>  .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
>  .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
>  .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  13 +
>  .../amd/display/dc/dcn314/dcn314_resource.c   |  14 +
>  .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
>  .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  19 +
>  drivers/gpu/drm/amd/display/dc/inc/link.h     |  14 +
>  .../drm/amd/display/dc/link/link_factory.c    |   7 +
>  .../dc/link/protocols/link_dp_capability.c    |  10 +
>  .../dc/link/protocols/link_dp_irq_handler.c   |  66 +++
>  .../link/protocols/link_edp_panel_control.c   | 165 +++++++
>  .../link/protocols/link_edp_panel_control.h   |   8 +
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 412 ++++++++++++++++++
>  .../gpu/drm/amd/display/include/dpcd_defs.h   |   5 +-
>  .../display/modules/info_packet/info_packet.c |   4 +
>  .../amd/display/modules/power/power_helpers.c |   5 +
>  .../amd/display/modules/power/power_helpers.h |   2 +
>  drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
>  38 files changed, 1533 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_repla=
y.c
>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_repla=
y.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
>
> --
> 2.25.1
>
