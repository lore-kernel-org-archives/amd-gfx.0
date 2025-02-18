Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347D0C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C7D10E608;
	Tue, 18 Feb 2025 04:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dYk6si+n";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4580510E60F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 92E68A41C0F;
 Tue, 18 Feb 2025 04:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE0C4CEE6;
 Tue, 18 Feb 2025 04:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854744;
 bh=zm3LIve414rOCtCuHMkze1TAB48BPIpLjh2V2gY9NYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dYk6si+nLIKU1YLR/te4TrIov5zvxPpasjTmoT+zwG0jOeTxiUUXh0rMs3YAFrRw5
 9wpexYKbh2OOoFkYz7U7hN5211Mij76RJIsMBySPBjFzSmDBi512iEfaXv3iSUz9m5
 +F4hRWBfZQOqmzDs8ChP4bv4HxwNTpsNBSXvA3sL5lnu3bEA9hu8fA3HM+kGLxv65f
 GXG6bKkvQ3eqa5rJ0LtMpO+i+u4wTovte3+ZK421U1FRU+kQIw6Lt9rHCGMZUdBrE0
 d4jGTAY73JTAf9Chpqh8PfPQRMkhovFSA7e5enlcd9MptF+iqfQckG9Ii3SJXhmysV
 UCP4PfgQPRAxg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 13/13] drm/amd/display: Use drm_err() for
 handle_hpd_irq_helper()
Date: Mon, 17 Feb 2025 22:58:40 -0600
Message-ID: <20250218045840.2469890-14-superm1@kernel.org>
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

drm_err() will show which device has the error.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a469b5fd43a7a..84c8673421f6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3762,7 +3762,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	aconnector->timing_changed = false;
 
 	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-		DRM_ERROR("KMS: Failed to detect connector\n");
+		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 	if (aconnector->base.force && new_connection_type == dc_connection_none) {
 		emulated_link_detect(aconnector->dc_link);
-- 
2.43.0

