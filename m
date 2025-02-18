Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A67C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04F910E60E;
	Tue, 18 Feb 2025 04:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q0oS+W2p";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAFF10E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7BF475C5AAC;
 Tue, 18 Feb 2025 04:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D32C4CEE2;
 Tue, 18 Feb 2025 04:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854740;
 bh=PrWwiDUHS73NCV5kW7RzneUjnY5FxhY8SB4LnH9eOgk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q0oS+W2pVefOdUaM2wXG91lNUPmgqCLiJh6qpEg2Jc5MQuAMu2DAxWrkNlt5bCUJ6
 kMYlYoV3HWT7VJQOKTrrgUT9R9h+hDi5Fipgte0HKWxiDvOYlG2OcZb4+Q5EQuQ8Z6
 g6x2Fd77OJCReN+WTfbe63ETscy+CRk1aKmDq4G23EbH6M4eXIOmqcohohHhy5pMLm
 kSRNVc3qZTatHuL/V6Xmholr5qte5Vlw0MYyBBltmWSygoq8+5o0tALfAPsTQLMb+w
 M1lMuRAUaFChZeklgezbN0UCfCHJDXGnTyn2rcSJjw7k74ACIdrLRZJ4MxGn471Tr2
 6WZf9K01hl2ug==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Change amdgpu_dm_irq_resume_*() to use
 drm_dbg()
Date: Mon, 17 Feb 2025 22:58:34 -0600
Message-ID: <20250218045840.2469890-8-superm1@kernel.org>
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

drm_dbg() is helpful to show which device had the debug statement.
Adjust to using this instead for debug messages.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 058a94345245f..3224eae295eb4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -521,7 +521,7 @@ int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 
 	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
-	DRM_DEBUG_KMS("DM_IRQ: early resume\n");
+	drm_dbg(adev_to_drm(adev), "DM_IRQ: early resume\n");
 
 	/* re-enable short pulse interrupts HW interrupt */
 	for (src = DC_IRQ_SOURCE_HPD1RX; src <= DC_IRQ_SOURCE_HPD6RX; src++) {
@@ -544,7 +544,7 @@ int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 
 	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
-	DRM_DEBUG_KMS("DM_IRQ: resume\n");
+	drm_dbg(adev_to_drm(adev), "DM_IRQ: resume\n");
 
 	/**
 	 * Renable HW interrupt  for HPD and only since FLIP and VBLANK
-- 
2.43.0

