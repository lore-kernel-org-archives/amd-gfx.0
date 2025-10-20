Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41D6CCD1AF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 07:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40BA10E2D0;
	Tue, 21 Oct 2025 07:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="SNQ/HC59";
	dkim-atps=neutral
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [91.218.175.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DB310E546
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 23:10:18 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1761001816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZHy4AWrt+NUl0LwBuvIQCbQtTogfHk8+6iKBV+Xh/Jc=;
 b=SNQ/HC59cdHjeOY7bhCMoDl7xwI/1gtMU1vJB1bW88WN5ct+86WS8fLCcwWBeiGE6qBNuJ
 fhjlwTMQBlkiYKol7XIumnP0awdX9YUM/vmZuuiUN3ep9h8YN08JlAKC06BIrx6Dt0Ztzp
 zo+d4XsxOfUjNfYeE3bV7/BCBKBmW/s=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 alexander.deucher@amd.com, alex.hung@amd.com, daniel.wheeler@amd.com,
 roman.li@amd.com, misyl@froggi.es,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] drm/amd/display: Don't program BLNDGAM_MEM_PWR_FORCE when CM
 low-power is disabled on DCN30
Date: Mon, 20 Oct 2025 16:09:34 -0700
Message-ID: <20251020230934.387745-1-matthew.schwartz@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 21 Oct 2025 07:12:08 +0000
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

Before commit 33056a97ae5e ("drm/amd/display: Remove double checks for
`debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
checked the low-power debug flag before calling
dpp3_power_on_blnd_lut(false).

After commit 33056a97ae5e ("drm/amd/display: Remove double checks for
`debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
unconditionally calls dpp3_power_on_blnd_lut(false). The BLNDGAM power
helper writes BLNDGAM_MEM_PWR_FORCE when CM low-power is disabled, causing
immediate SRAM power toggles instead of deferring at vupdate. This can
disrupt atomic color/LUT sequencing during transitions between
direct scanout and composition within gamescope's DRM backend on
Steam Deck OLED.

To fix this, leave the BLNDGAM power state unchanged when low-power is
disabled, matching dpp3_power_on_hdr3dlut and dpp3_power_on_shaper.

Fixes: 33056a97ae5e ("drm/amd/display: Remove double checks for `debug.enable_mem_low_power.bits.cm`")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 09be2a90cc79d..4f569cd8a5d61 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -578,9 +578,6 @@ static void dpp3_power_on_blnd_lut(
 			dpp_base->ctx->dc->optimized_required = true;
 			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
 		}
-	} else {
-		REG_SET(CM_MEM_PWR_CTRL, 0,
-				BLNDGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
 	}
 }
 
-- 
2.51.1.dirty

