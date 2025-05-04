Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA5BC369DC
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 22:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6DA10E08F;
	Sun,  4 May 2025 22:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VvVrdiVK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA0B10E08F
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BibYhU3oYAQothkFh4EXJ4Y2drcGPqG7XV3953MZ0pI=; b=VvVrdiVKvOFQMm/fMrulJr78pj
 tBLZT6Oc3tB2VwjLt5MI3mkxV9/lDQnInqR2GXGuOxRlk7pc5SdnGpeDcVng2NpYTf4zOVWdR9v+0
 GLlXNtZwKUVgpQwOY3cb58ZVrV4LzdkXvBp5jiQDdT00kBKEn1D7NqgqSOK6KemQQRPZG39G8jkap
 maCIG/hxsMpxSHGg/RiGYn+pwvWEmmMn8T6Ys0HAsDpeF4xwGUy2CZZtHD89kxgi5NreTVeBRpIJO
 t0LUUunnXuu99iwulYv44+XmN0PIFQE1g8Q0RjR4ukEeuY6Y1746slLIE7UuPTaKtF30tbkl4Czbu
 mSDrqdNw==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBhWP-003Pr1-VF; Mon, 05 May 2025 00:12:13 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/4] Reuse some functions from the previous DCN in the newest
 DCNs
Date: Sun,  4 May 2025 16:11:27 -0600
Message-ID: <20250504221154.409695-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

DCN has multiple callbacks, some of which can be replaced with specific
operations for a particular ASIC. Sometimes, the implementation of the
previous ASIC can be used in a new one; traditionally, the display
approach for those cases has been to use the old function implementation
in the new ASICs if nothing changes. For example, if function Y
implemented in DCN 10 did not change anything in the DCN 30, the DCN 10
implementation is used in the DCN 30 callback. Sometimes, this approach
is not followed, which may lead to code duplication. This series
addresses some of those cases by promoting the reuse of old ASIC
implementation in new ASICs.

Thanks

Rodrigo Siqueira (4):
  drm/amd/display: Use optc31_enable_crtc implementation for new DCNs
  drm/amd/display: Use optc31_disable_crtc for DCN 31 and 401
  drm/amd/display: Uses optc31_disable_crtc for DCN35
  drm/amd/display: Replace dcn35_update_odm with dcn314_update_odm

 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 52 --------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  3 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 15 ++--
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  4 ++
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  | 27 +-------
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 33 +--------
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 62 +----------------
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 68 +------------------
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  2 -
 11 files changed, 24 insertions(+), 246 deletions(-)

-- 
2.47.2

