Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F23EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 15:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2002210E563;
	Thu, 16 Dec 2021 15:25:38 +0000 (UTC)
Received: from ubuntu2004-NV21-clean.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD45A10E563
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 15:25:36 +0000 (UTC)
Received: by ubuntu2004-NV21-clean.amd.com (Postfix, from userid 0)
 id 49963161E0B; Thu, 16 Dec 2021 10:25:35 -0500 (EST)
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
To: amd-gfx@lists.freedesktop.org, Bokun.Zhang@amd.com, HaiJun.Chang@amd.com,
 Monk.Liu@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: Check the memory can be accesssed by
 ttm_device_clear_dma_mappings.
Date: Thu, 16 Dec 2021 10:25:33 -0500
Message-Id: <20211216152533.2131-1-surbhi.kakarya@amd.com>
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
Cc: skakarya <Surbhi.Kakarya@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the event guard is enabled and VF doesn't receive an ack from PF for full access,
the guest driver load crashes.
This is caused due to the call to ttm_device_clear_dma_mappings with non-initialized
mman during driver tear down.

This patch adds the necessary condition to check if the mman initialization passed or not
and takes the path based on the condition output.

Signed-off-by: skakarya <Surbhi.Kakarya@amd.com>
Change-Id: I1c18c7eb3500687c8b6e7fc414503dcf2a20b94c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 598250a380f5..226110be7a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3984,7 +3984,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_irq_fini_hw(adev);
 
-	ttm_device_clear_dma_mappings(&adev->mman.bdev);
+	if (adev->mman.initialized)
+		ttm_device_clear_dma_mappings(&adev->mman.bdev);
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-- 
2.25.1

