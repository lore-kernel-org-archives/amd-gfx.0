Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB1CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 18:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B7D10ECBB;
	Fri, 12 Sep 2025 18:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jFTPtq7Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBBD10ECBB
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 17:59:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D61FF43512
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 17:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63885C4CEF1;
 Fri, 12 Sep 2025 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757699998;
 bh=7eucXCf0U+bCnJSvNvq0qtH2YSq9R2o0ARgVUQ7WD5E=;
 h=From:To:Cc:Subject:Date:From;
 b=jFTPtq7YLOcrTvCoSyzRQcIdF6GMQj2PMUX2RthBpWSuEmZ2cvCi6pRej6HVP+R8B
 v2YISM9V5R9k6yc+9xUk424Dkadc4F3QeO+zPPevsmrZ1wi96usSpa2xm7pFVs2Hw1
 Un3qx3/v9SD2X7OfuftZDTidQhiYSMvyBDFaH7fRaKHZkAwiEUr7+kZM0RlG1sLXma
 1+azrHmkRvi+53Es1PHnvGNGvDegU6behs9Dq3pa3SVN8NRsXUrO4LpP/pfqYcBnBh
 DrbnDhflbCkXSozNTFPdJ0kbghAucK1PRvq3LehPpht3Uc3j+0NdIh4qbExE2KmC7s
 2XhS6FuANzltg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] drm/amd: Suspend drm clients during shutdown()
Date: Fri, 12 Sep 2025 12:59:51 -0500
Message-ID: <20250912175951.918354-1-superm1@kernel.org>
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

If the drm device is used for displaying the console then writing
to the console could potentially cause a hang on the system if DCN
is in IPS. This is more likely to happen after commit 6ea9a1781c70a
("Flush console log from kernel_power_off()") which has caused the
console to get flushed at shutdown.

As part of the amdgpu shutdown callback drm clients must be suspended to
prevent this. Add an explicit call for the shutdown sequence.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 985ab240e4bb0..5d8254d5ee1c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -24,6 +24,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_client_event.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_ttm.h>
 #include <drm/drm_gem.h>
@@ -2551,6 +2552,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	 */
 	if (!amdgpu_passthrough(adev))
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
+	drm_client_dev_suspend(dev, false);
 	amdgpu_device_ip_suspend(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
-- 
2.43.0

