Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97243C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 15:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012F810E2E1;
	Mon,  5 Jun 2023 15:31:37 +0000 (UTC)
X-Greylist: delayed 488 seconds by postgrey-1.36 at gabe;
 Mon, 05 Jun 2023 15:31:35 UTC
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE95810E2E1;
 Mon,  5 Jun 2023 15:31:35 +0000 (UTC)
Received: from ersatz.molgen.mpg.de (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 21DC861EA1BFF;
 Mon,  5 Jun 2023 17:23:09 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amdgpu: Log if device is unsupported
Date: Mon,  5 Jun 2023 17:22:59 +0200
Message-Id: <20230605152300.171794-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.40.1
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since there is overlap in supported devices, both modules load, but only
one will bind to a particular device depending on the model and user's
configuration.

amdgpu binds to all display class devices with VID 0x1002 and then
determines whether or not to bind to a device based on whether the
individual device is supported by the driver or not. Log that case, so
users looking at the logs know what is going on.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2608
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 86fbb4138285..410ff918c350 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2062,8 +2062,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	/* skip devices which are owned by radeon */
 	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
-		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
+		if (amdgpu_unsupported_pciidlist[i] == pdev->device) {
+			DRM_INFO("This hardware is only supported by radeon.");
 			return -ENODEV;
+		}
 	}
 
 	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
-- 
2.40.1

