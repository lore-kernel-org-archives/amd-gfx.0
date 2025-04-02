Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B799C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 05:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77D910E6BA;
	Wed,  2 Apr 2025 05:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pNDUiDxL";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E21110E6BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 05:13:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7CD91A437F9;
 Wed,  2 Apr 2025 05:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF036C4CEDD;
 Wed,  2 Apr 2025 05:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743570836;
 bh=RspGyqImb4L7cq6NyzI1yYaLvZ75MuMNMHYVzCkxHHo=;
 h=From:To:Cc:Subject:Date:From;
 b=pNDUiDxLCD8SNxLX4g1KZWHG6Jn7Us9lyiLultd3EzqmNxnR7+nak0cJ5o33XiGFY
 ICpPSJ5WevQTr7p+g351f1buOqi6Yy/GKR3HOHAwhkc0aOOskYIq1CceuZ/VclYZLP
 JgwJLlU0MgzJ84V3hdUTXkI3+RH37XoyAJ6zUC1UShCl2Lf+IE8xRpxUjgrqkjigB3
 cgaCxAdU7zcyTh71s+divXT3a3FI0JLaDCCliBPIlzMrP/hJfikxOkFZIAjHcEswbo
 xjthqk2egds6ke9aPZshv7kxBDJZ0R8Y548xZ831zA/Hp6j7TfpyqK7CO+BL++52tr
 GHoHPG2DDwxew==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Add AMD Phenom 2 to pcie dynamic switching exclusions
Date: Wed,  2 Apr 2025 00:13:49 -0500
Message-ID: <20250402051349.3206659-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

AMD RX580 when added AMD Phenom 2 has problems with overheating. This is
due to changes with PCIe dynamic switching introduced by commit
466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW limits")

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4098
Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW limits")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6ebf6179064b7..22a0a0bbb4bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1854,6 +1854,9 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
  *
  * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
  * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ *
+ * AMD Phenom II X6 1090T has a similar issue
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/4098
  */
 static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
 {
@@ -1866,6 +1869,8 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 
 	if (c->x86_vendor == X86_VENDOR_INTEL)
 		return false;
+	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 0x10 && c->x86_model == 0x0A)
+		return false;
 #endif
 	return true;
 }
-- 
2.43.0

