Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE14C678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 20:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7EA10E288;
	Tue,  7 Mar 2023 20:22:34 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E09310E288;
 Tue,  7 Mar 2023 20:22:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB4661573;
 Tue,  7 Mar 2023 20:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53CFC4339C;
 Tue,  7 Mar 2023 20:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678220552;
 bh=PqER2sDTG8VKpv708LoHbOx4iqEG6thQKcBSNi0LE2E=;
 h=From:To:Cc:Subject:Date:From;
 b=lbDHl8duTqlScOCaUxL+MFLThmWnR8hF6VYFeHADoj4hhevwxsRgC2ZOyDv8cpgxe
 f/a4AgwVjNk6mUUL+ucRq36tXtRbHXk9KOjp/0D2ZdJE1367uXLcoSL1LVsIiFh6QV
 3MCcaQwEhwI1Vqm8vffhthx7Ldp5xQm+3a3HUhbwuqR8Hk0rYrYFIUSU5NQKS4epFL
 eL2I80mfF2YA0lVRnTpUiLYIFJCOTDVke56GQW1ADaJF4hWEUkn1ZrVKfRuLRszgZG
 EvjRiuQcsfr5Cx/IBbZXo9AIi4yNpAjHjS2veeFZ372oTt4sNAmOUBnArlhKHBD8sg
 bB3+TN+aH4qgg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amdgpu: Drop redundant pci_enable_pcie_error_reporting()
Date: Tue,  7 Mar 2023 14:22:21 -0600
Message-Id: <20230307202221.880489-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 164141bc8b4a..208cebb40232 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -50,7 +50,6 @@
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
 #include <linux/pci.h>
-#include <linux/aer.h>
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_placement.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c4a4e2fe6681..a5151e83a3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3773,8 +3773,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
-	pci_enable_pcie_error_reporting(adev->pdev);
-
 	/* Post card if necessary */
 	if (amdgpu_device_need_post(adev)) {
 		if (!adev->bios) {
-- 
2.25.1

