Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922ECE81BD3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 15:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323AE10E05E;
	Mon,  9 Feb 2026 15:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dbCbiMHT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4218D10E05E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=frNbsOUBsLPiv2atUTI14oxNp4HTk1WgMQsW8AsjRn0=; b=dbCbiMHTANH9HgMbcvaLTKWHEJ
 5oVifvt5dENkkz7XimJhAWT6hmaYts6UdkCeo9JSTObDI58MXV7wIXu97fOPY5u16MS6nv7ryCo2L
 TDF814BDW/ULyCy7DS/3kGlOop71ZYQr014OXKNpeHFcOcdmkCf0veoRocoBnRqfSAu1tROl1EtYF
 HDb/Sdkebq7l2feLy4IuiKlBZKUvvyeaEvHKPh+VN+PffhrEtl9ovB6FopjwQjBXo6CpckBdYmhwj
 F3DeAtjFWx1TsfZFErUgQO3k6JsTTTA0WvSAF6EcWuTR17+C0X7mc4J41+zm/lFEwKG47vmcNCJaJ
 Vz/pIqlg==;
Received: from d198-53-218-11.abhsia.telus.net ([198.53.218.11] helo=atmagalia)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vpTIh-00G2Vp-Bn; Mon, 09 Feb 2026 16:35:47 +0100
Date: Mon, 9 Feb 2026 08:35:41 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: "ChiaHsuan Chung (Tom)" <ChiaHsuan.Chung@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: Re: [PATCH 00/14] drm/amd/display: Add support for external DP
 bridge encoders in DC
Message-ID: <aYn9dPS0R5lh7hQO@atmagalia>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
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

On 01/26, Timur Kristóf wrote:
> Some GPUs use external DP bridge encoders NUTMEG and TRAVIS
> to implement analog and/or LVDS connections. Typically found in
> CIK APU based laptops or on FM2 motherboards that have analog
> connectors. These were necessary at the time because Kaveri
> didn't have a built-in DAC nor LVDS support.
> 
> These devices sadly don't work transparently and need to be
> controlled by the driver. This series implements that.
> 
> The first half of the series contains some minor fixes and
> refactoring necessary for these external encoders to work.
> The second half then adds the actual external encoder support.
> 
> When we query connector information from the VBIOS and
> discover a connector using such an encoder, let's find the
> real DisplayPort encoder and use that. Set the connector
> signal type to DP, so the pre-existing DP code paths can
> work with it without refactoring every signal type check
> in the DC code base.
> 
> With that, we can now enable DC by default on CIK APUs too.
> DC brings proper support for DP/HDMI audio, DP MST, VRR,
> 10-bit colors, some HDR features, atomic modesetting, etc.
> without any loss of functionality.
> 
> Timur Kristóf (14):
>   drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
>   drm/amd/display: Only use analog link encoder with analog engine
>   drm/amd/display: Only use analog stream encoder with analog engine
>   drm/amd/display: Add color depth helper function to BIOS parser
>   drm/amd/display: Refactor DAC load detection, move to HWSS
>   drm/amd/display: Implement BIOS parser external encoder control
>   drm/amd/display: Implement DDC probe over AUX channel
>   drm/amd/display: Add ability for HWSS to prepare the DDC before use
>   drm/amd/display: Use preferred DP link rate if specified
>   drm/amd/display: Add DCE HWSS support for external DP bridge encoders
>   drm/amd/display: Link detection for external DP bridge encoders
>   drm/amd/display: Use external DP bridge encoders
>   drm/amd/display: Implement DAC load detection on external DP bridge
>     encoders
>   drm/amdgpu: Use DC by default on CIK APUs
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  11 --
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   3 +
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  46 +++++--
>  .../drm/amd/display/dc/bios/command_table.c   | 124 ++++++------------
>  drivers/gpu/drm/amd/display/dc/dc.h           |   4 +
>  .../gpu/drm/amd/display/dc/dc_bios_types.h    |   6 +-
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  67 ++++++++++
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +
>  .../drm/amd/display/dc/link/link_detection.c  |  56 ++++----
>  .../drm/amd/display/dc/link/link_factory.c    |  29 +++-
>  .../dc/link/protocols/link_dp_capability.c    |   2 +
>  .../link/protocols/link_edp_panel_control.c   |   8 +-
>  .../dc/resource/dce100/dce100_resource.c      |   8 +-
>  .../dc/resource/dce60/dce60_resource.c        |   5 +-
>  .../dc/resource/dce80/dce80_resource.c        |   3 +-
>  .../amd/display/include/bios_parser_types.h   |   2 +
>  17 files changed, 228 insertions(+), 157 deletions(-)
> 
> -- 
> 2.52.0
>

Hi Alex, Dan, Tom,

This series is the last to enable amdgpu as the default for all GFX7
GPUs. In this sense, could you include this series in the weekly
promotion to check whether everything looks ok from a feature
perspective?

Thanks

-- 
Rodrigo Siqueira
