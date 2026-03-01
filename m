Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213FEFD0048
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 01:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B974010E2F9;
	Sun,  1 Mar 2026 01:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PODTfkjK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAD510E2F9;
 Sun,  1 Mar 2026 01:25:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0493540118;
 Sun,  1 Mar 2026 01:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6DBC19421;
 Sun,  1 Mar 2026 01:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772328358;
 bh=MAY2Y6F5m9+mJiOoiE+RzdsjpFQkLme7ZUvPkVDBvKM=;
 h=From:To:Cc:Subject:Date:From;
 b=PODTfkjKhJOXsNb2rvkfSqE/0qSzUXqp2LCX5Zwpm7CnFXRlw+IdEGNCqqIMUAmyY
 wJm8e02AkHXtGO6Xa3LuvtbmYQklPApYTOpyeA03IlN1Yk2hIwvvqZHVa/PMR3gQ9D
 X/kgY3oCGUO0/xPnaljYVY8JVGoaTr5ABpcgWTmMb/WSmZOKlOCdozbP+qaNeGpDw2
 /YibNBa0r5iOImaIjnv+3fAIBbQ58ThqbwSMlK8vxX1XOK+2ke72PxkaadN69bssAR
 OLpAgSxjk9M6ZyxD6yONhG+SMS8wBW1StDHG00pyIyusWpmjw0PD/WeyYSW5+oe8+8
 eyIP1mHq02v8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mario.limonciello@amd.com
Cc: Cal Peake <cp@absolutedigital.net>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amd: Fix hang on amdgpu unload by using
 pci_dev_is_disconnected()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:56 -0500
Message-ID: <20260301012557.1683222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f7afda7fcd169a9168695247d07ad94cf7b9798f Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 5 Feb 2026 10:42:54 -0600
Subject: [PATCH] drm/amd: Fix hang on amdgpu unload by using
 pci_dev_is_disconnected()

The commit 6a23e7b4332c ("drm/amd: Clean up kfd node on surprise
disconnect") introduced early KFD cleanup when drm_dev_is_unplugged()
returns true. However, this causes hangs during normal module unload
(rmmod amdgpu).

The issue occurs because drm_dev_unplug() is called in amdgpu_pci_remove()
for all removal scenarios, not just surprise disconnects. This was done
intentionally in commit 39934d3ed572 ("Revert "drm/amdgpu: TA unload
messages are not actually sent to psp when amdgpu is uninstalled"") to
fix IGT PCI software unplug test failures. As a result,
drm_dev_is_unplugged() returns true even during normal module unload,
triggering the early KFD cleanup inappropriately.

The correct check should distinguish between:
- Actual surprise disconnect (eGPU unplugged): pci_dev_is_disconnected()
  returns true
- Normal module unload (rmmod): pci_dev_is_disconnected() returns false

Replace drm_dev_is_unplugged() with pci_dev_is_disconnected() to ensure
the early cleanup only happens during true hardware disconnect events.

Cc: stable@vger.kernel.org
Reported-by: Cal Peake <cp@absolutedigital.net>
Closes: https://lore.kernel.org/all/b0c22deb-c0fa-3343-33cf-fd9a77d7db99@absolutedigital.net/
Fixes: 6a23e7b4332c ("drm/amd: Clean up kfd node on surprise disconnect")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 528990a595ec9..9758221413814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4924,7 +4924,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_amdkfd_device_fini_sw(adev);
 
 	amdgpu_device_ip_fini_early(adev);
@@ -4936,7 +4936,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
 }
-- 
2.51.0




