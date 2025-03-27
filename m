Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13778C36016
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB9310E941;
	Thu, 27 Mar 2025 20:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mz05FxE5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6978C10E173
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8983B61134;
 Thu, 27 Mar 2025 20:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CEEC4CEEB;
 Thu, 27 Mar 2025 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107950;
 bh=VbK2eNfu/KqrDxBt0jz/GJ0IjaopK5HkNTFllu+dlEk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mz05FxE5KVZl8I/vQ/L3TG8K1zLmqEVq0naErqHzBLu2gohPcOQ9bxSfLpgnmzXda
 LWRcT4FAJlWRMZdrn/mJNQi4vk99CSTIreiJlMnSEbqzrigjNccJZn6ZvkbKykYppA
 gb0O8xjFgPhjBvCJ5VWWgMcIiwqyX76iaUdpNObYy/mxqxTMpdemuNxZTcEUJHl/VD
 FCdeC1rliqUzk05fH/qStD47yVk/e509tG9VrT+UKsfCzg/NkUkcIpYGSWaUhkMHMo
 NMcdPT1qsySUjS70kHxZiMFwcfUAQOHcDDn6ltGHbrs0J5Hwf3bqaN0jiVjgMCgiAD
 tOyM1zJCfgumg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 03/14] drm/amd: Convert dev_err_once() messages to
 drm_err_once()
Date: Thu, 27 Mar 2025 15:38:47 -0500
Message-ID: <20250327203858.3796086-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

The errors for power consumption in amdgpu_acpi_is_s0ix_active() are
under device scope. As they're drm errors, adjust to drm scope.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 840901d65fed7..4372738bf2c9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1518,14 +1518,14 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	 * in that case.
 	 */
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
-		dev_err_once(adev->dev,
+		drm_err_once(adev_to_drm(adev),
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
 			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
 		return false;
 	}
 
 #if !IS_ENABLED(CONFIG_AMD_PMC)
-	dev_err_once(adev->dev,
+	drm_err_once(adev_to_drm(adev),
 		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
 	return false;
 #else
-- 
2.43.0

