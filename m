Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADF6C021AD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8564010E604;
	Tue, 18 Feb 2025 04:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fuTxiu/7";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5B210E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:58:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6B16DA41D04;
 Tue, 18 Feb 2025 04:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96886C4CEE6;
 Tue, 18 Feb 2025 04:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854738;
 bh=tM5Qa+LktYeX7o2FZADjMCNNSHIMRiw3V8x+OXmX2K4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fuTxiu/7Rd3gQGckjfiPVH1DNtFkVMCpTfdeJDONKmbgdyG2j9W91s9opmdricBzl
 2cKKgDmwgkyguvM5HtkMmOY/u1AqsROW9xYyRTMNwjh9LaI+3aoqUIOg4t3m+S0EA/
 8DJABDBkoD2fRNXHITi9BOn3vwve0RiQ8tIBCbNSaVimO9qSnaKaVeURXHAtyG3hZY
 vA8C8YvrOIBWzJIRQ9dZdngw9JN3VtUQXADoO2+HG58WZoC7Z7kkfPeheWxQ+32Qe2
 LVjWJ6T9FECMVsM2VNYevhte7526c6+v2naoSPfai6/J4gWCR773+7+eYrer1AuFzs
 L0hy/pCg6rBXA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Catch failures for
 amdgpu_dm_commit_zero_streams()
Date: Mon, 17 Feb 2025 22:58:30 -0600
Message-ID: <20250218045840.2469890-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218045840.2469890-1-superm1@kernel.org>
References: <20250218045840.2469890-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

amdgpu_dm_commit_zero_streams() returns a DC error code that isn't
checked. Add an explicit check to this and fail dm_suspend() if it
is not DC_OK.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d78cabeece70..afd2cd71c373e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3089,6 +3089,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	if (amdgpu_in_reset(adev)) {
+		enum dc_status res;
+
 		mutex_lock(&dm->dc_lock);
 
 		dc_allow_idle_optimizations(adev->dm.dc, false);
@@ -3098,7 +3100,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		if (dm->cached_dc_state)
 			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
-		amdgpu_dm_commit_zero_streams(dm->dc);
+		res = amdgpu_dm_commit_zero_streams(dm->dc);
+		if (res != DC_OK) {
+			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
+			return -EINVAL;
+		}
 
 		amdgpu_dm_irq_suspend(adev);
 
-- 
2.43.0

