Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD4C369CF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 08:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44F710EB78;
	Fri, 18 Apr 2025 08:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="fsv79n4F";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFE410E3DD;
 Fri, 18 Apr 2025 00:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=UnK+b2h8bTb3F6LGdc9yAFnsyCBDaFV8sHyN61KNjQE=; b=fsv79n4FJ88zyjZZ
 rKnyLBWkJ0QItC9HraNWrxWRXFNfyr/3nJD+NEf+vET+m54oNA/1DsC0Bfp+gAdpDfDaOAuKA0X0q
 cfsjZIbB3adre7+jaZKfTs2foTuvtTEKXV+djSd3xhGSqT4bkxjxp07haSHcrlF9bghK+mOtz5EbN
 DksRyrQzBOe9c8K3WiBAQBaKGsuyVBUsUO74BpAlA+9nQ0h/2lTgX8TEXKAhOIxpnzvr34fDRHiYs
 wN14YGHxPOtcR5dSzJePjblipHSU9wGOaD2iKKHbqIlDCL/f3e6APLradmrG6SYgCXPdKvX/FNYk9
 b2xlWcf1IrHqTlTzJw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1u5ZTq-00CPl8-1p;
 Fri, 18 Apr 2025 00:21:18 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/4] drm/amd & radeon deadcoding
Date: Fri, 18 Apr 2025 01:21:13 +0100
Message-ID: <20250418002117.130612-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Apr 2025 08:14:36 +0000
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  Another set of deadcoding around amd/radeon GPU stuff.

Dave
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (4):
  drm/radeon/radeon_audio: Remove unused r600_hdmi_audio_workaround
  drm/radeon: Remove unused radeon_doorbell_free
  drm/radeon: Remove unused radeon_fence_wait_any
  drm/amd/display: Remove unused *vbios_smu_set_dprefclk

 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  | 14 -------
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.h  |  1 -
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 14 -------
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h   |  1 -
 drivers/gpu/drm/radeon/r600_hdmi.c            | 22 ----------
 drivers/gpu/drm/radeon/radeon.h               |  4 --
 drivers/gpu/drm/radeon/radeon_asic.h          |  1 -
 drivers/gpu/drm/radeon/radeon_device.c        | 14 -------
 drivers/gpu/drm/radeon/radeon_fence.c         | 42 -------------------
 9 files changed, 113 deletions(-)

-- 
2.49.0

