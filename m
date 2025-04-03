Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB1BC36014
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 03:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE2310E8F2;
	Thu,  3 Apr 2025 03:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d2ubLxUr";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D6210E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 03:12:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5D96EA41F4B;
 Thu,  3 Apr 2025 03:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2DAC4CEDD;
 Thu,  3 Apr 2025 03:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743649916;
 bh=Q+HIS4Yr9ldBGryVOgM8SrwPGw/c+DTfAmFBiG4Eueo=;
 h=From:To:Cc:Subject:Date:From;
 b=d2ubLxUrm63ZO7pG5UxOlZ+NKPcom3Hm7rDVOfXVL4TRt2uCdz5p5FQwdSPhlwByu
 +1p0WA3oYqni4DPsvU/Z6WdIOuoqzUIMcf5gpQukChCPiAPzpGIH0s8JjCIDcu7psz
 WD4PW3NlAOeglDeMPKTnwrUii4qYdYxvUp5EYnOGOSkcqF/agj/iFLxidTFQUq2LGP
 Efe3R99Jb7GMYdMffAh/LpEc12c/cW/YdPY4eEa5Epr9jRChjMpYp2Hn4Hvm2cNpXv
 UXq/LU8taeJ5sF7t3QzM/9Af6ZTNeSIFfiBH1oFZRX3t6Xw69n+AXCcI3hPWrFpww8
 HrJe20JCw6NVg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amd: Add pre-zen AMD hardware to PCIe dynamic
 switching exclusions
Date: Wed,  2 Apr 2025 22:11:48 -0500
Message-ID: <20250403031148.1266785-1-superm1@kernel.org>
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

AMD RX580 when added AMD Phenom 2 has problems with overheating. This is due to
changes with PCIe dynamic switching introduced by commit 466a7d115326e
("drm/amd: Use the first non-dGPU PCI device for BW limits").

To avoid risks of other issues with old hardware require at least Zen hardware
for AMD side to enable PCIe dynamic switching.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4098
Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW limits")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Cover more hardware
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a30111d2c3ea0..caa44ee788c8f 100644
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
+	if (c->x86_vendor == X86_VENDOR_AMD && !cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
 #endif
 	return true;
 }
-- 
2.43.0

