Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF1CC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 22:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B47E10EA1F;
	Thu, 16 Jan 2025 22:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lNHVdJqf";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28ED10EA15
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 22:00:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BD38AA4288F;
 Thu, 16 Jan 2025 21:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AE2C4CEDD;
 Thu, 16 Jan 2025 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737064830;
 bh=Sg5SgdHslga+bIvQ/uYrynyEqN1GzjdBFSMvW2tUB8w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lNHVdJqfxRVfn3c0ay4I4ZBoIsuD+y1qtOHI10+6H1BvHubbmnPSnRAEWYqelSGSs
 C1RyOY/+pgcTAfFkuRJma07ivGKNtMlv/wKADIfWjJNDmwQV3pJCD0fCdhign8PXkt
 mEItLnjfNWMCqZHR2hTTY+2R+a+3N6sEZccUE1dcDGX2ax5AZCvkxM9DFMLGlMFhGd
 P/MM7V2kIxBD126LtK9MsNpAYyGDdX0W6eVhVr0Dw3O7fjI06fvqYHd4kJa0WEaRCi
 7Hy2bf0QHRCogFj4ZGFSRNuTRN/8ajn4xZXUhHPvnshpGk3k50t+EVa5SoHR43dZgP
 7GT//vXcuSEyg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] drm/amd: Mark amdgpu.gttsize parameter as deprecated
 and show warnings on use
Date: Thu, 16 Jan 2025 16:00:19 -0600
Message-ID: <20250116220020.2425025-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116220020.2425025-1-superm1@kernel.org>
References: <20250116220020.2425025-1-superm1@kernel.org>
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

When not set `gttsize` module parameter by default will get the
value to use for the GTT pool from the TTM page limit, which is
set by a separate module parameter.

This inevitably leads to people not sure which one to set when they
want more addressable memory for the GPU, and you'll end up seeing
instructions online saying to set both.

Add some messages to try to guide people both who are using or misusing
the parameters and mark the parameter as deprecated with the plan to
drop it after the next LTS kernel release.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 680b272a83c9..31d4b6aebca5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -283,6 +283,7 @@ module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
  * DOC: gttsize (int)
  * Restrict the size of GTT domain (for userspace use) in MiB for testing.
  * The default is -1 (Use value specified by TTM).
+ * This parameter is deprecated and will be removed in the future.
  */
 MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes (-1 = auto)");
 module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e6fc89440210..becdeab369c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1960,10 +1960,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Compute GTT size, either based on TTM limit
 	 * or whatever the user passed on module init.
 	 */
-	if (amdgpu_gtt_size == -1)
-		gtt_size = ttm_tt_pages_limit() << PAGE_SHIFT;
-	else
-		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
+	gtt_size = ttm_tt_pages_limit() << PAGE_SHIFT;
+	if (amdgpu_gtt_size != -1) {
+		uint64_t configured_size = (uint64_t)amdgpu_gtt_size << 20;
+
+		drm_warn(&adev->ddev,
+			"Configuring gttsize via module parameter is deprecated, please use ttm.pages_limit");
+		if (gtt_size != configured_size)
+			drm_warn(&adev->ddev,
+				"GTT size has been set as %llu but TTM size has been set as %llu, this is unusual",
+				configured_size, gtt_size);
+
+		gtt_size = configured_size;
+	}
 
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
-- 
2.48.0

