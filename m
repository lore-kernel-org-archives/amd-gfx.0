Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562F0EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C619810E420;
	Wed,  9 Aug 2023 12:07:47 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1343310E407
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 09:09:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3FE706307A;
 Wed,  9 Aug 2023 09:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD38C433C8;
 Wed,  9 Aug 2023 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1691572195;
 bh=vfMI07lbwQqzPWUEbcLGTfTZhAGUNzN/8h37gCFR36c=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=thCQIQzVsvetqrTqD/aWxpwy8h3bHqj9+qC0nJMkh/mQT5V54/XJaA8Bk7OY3uZhE
 R9V6e802fhQMSECvldfvxOgCtV2sxx/JlAaXRK2Eck8NMCXACQzxDmLAg9SrPTd8TF
 sBhu8Wah9sYvDj1YMLnoW4xEYwOf/dMOGKvs0n94=
Subject: Patch "drm/amdgpu: Remove unnecessary domain argument" has been added
 to the 6.1-stable tree
To: Alexander.Deucher@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 gregkh@linuxfoundation.org, luben.tuikov@amd.com, mario.limonciello@amd.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Aug 2023 11:09:44 +0200
In-Reply-To: <20230808175055.3761-3-mario.limonciello@amd.com>
Message-ID: <2023080944-unfounded-outgrow-03c6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Wed, 09 Aug 2023 12:07:46 +0000
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
Cc: stable-commits@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This is a note to let you know that I've just added the patch titled

    drm/amdgpu: Remove unnecessary domain argument

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amdgpu-remove-unnecessary-domain-argument.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Tue Aug  8 20:31:33 2023
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 8 Aug 2023 12:50:54 -0500
Subject: drm/amdgpu: Remove unnecessary domain argument
To: <stable@vger.kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Message-ID: <20230808175055.3761-3-mario.limonciello@amd.com>

From: Luben Tuikov <luben.tuikov@amd.com>

commit 3273f11675ef11959d25a56df3279f712bcd41b7 upstream

Remove the "domain" argument to amdgpu_bo_create_kernel_at() since this
function takes an "offset" argument which is the offset off of VRAM, and as
such allocation always takes place in VRAM. Thus, the "domain" argument is
unnecessary.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |    7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |    1 -
 4 files changed, 6 insertions(+), 14 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -347,17 +347,16 @@ int amdgpu_bo_create_kernel(struct amdgp
  * @adev: amdgpu device object
  * @offset: offset of the BO
  * @size: size of the BO
- * @domain: where to place it
  * @bo_ptr:  used to initialize BOs in structures
  * @cpu_addr: optional CPU address mapping
  *
- * Creates a kernel BO at a specific offset in the address space of the domain.
+ * Creates a kernel BO at a specific offset in VRAM.
  *
  * Returns:
  * 0 on success, negative error code otherwise.
  */
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size, uint32_t domain,
+			       uint64_t offset, uint64_t size,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
@@ -367,8 +366,9 @@ int amdgpu_bo_create_kernel_at(struct am
 	offset &= PAGE_MASK;
 	size = ALIGN(size, PAGE_SIZE);
 
-	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE, domain, bo_ptr,
-				      NULL, cpu_addr);
+	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
+				      cpu_addr);
 	if (r)
 		return r;
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgp
 			    u32 domain, struct amdgpu_bo **bo_ptr,
 			    u64 *gpu_addr, void **cpu_addr);
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size, uint32_t domain,
+			       uint64_t offset, uint64_t size,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
 int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_param *bp,
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1575,7 +1575,6 @@ static int amdgpu_ttm_fw_reserve_vram_in
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.fw_vram_usage_start_offset,
 					  adev->mman.fw_vram_usage_size,
-					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.fw_vram_usage_reserved_bo,
 					  &adev->mman.fw_vram_usage_va);
 }
@@ -1600,7 +1599,6 @@ static int amdgpu_ttm_drv_reserve_vram_i
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.drv_vram_usage_start_offset,
 					  adev->mman.drv_vram_usage_size,
-					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.drv_vram_usage_reserved_bo,
 					  NULL);
 }
@@ -1681,7 +1679,6 @@ static int amdgpu_ttm_reserve_tmr(struct
 		ret = amdgpu_bo_create_kernel_at(adev,
 					 ctx->c2p_train_data_offset,
 					 ctx->train_data_size,
-					 AMDGPU_GEM_DOMAIN_VRAM,
 					 &ctx->c2p_bo,
 					 NULL);
 		if (ret) {
@@ -1695,7 +1692,6 @@ static int amdgpu_ttm_reserve_tmr(struct
 	ret = amdgpu_bo_create_kernel_at(adev,
 				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
 				adev->mman.discovery_tmr_size,
-				AMDGPU_GEM_DOMAIN_VRAM,
 				&adev->mman.discovery_memory,
 				NULL);
 	if (ret) {
@@ -1796,21 +1792,18 @@ int amdgpu_ttm_init(struct amdgpu_device
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
 	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_vga_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
 				       adev->mman.stolen_extended_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_extended_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
 				       adev->mman.stolen_reserved_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_reserved_memory,
 				       NULL);
 	if (r)
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -391,7 +391,6 @@ static void amdgpu_virt_ras_reserve_bps(
 		 */
 		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
 					       AMDGPU_GPU_PAGE_SIZE,
-					       AMDGPU_GEM_DOMAIN_VRAM,
 					       &bo, NULL))
 			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
 


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-6.1/iommu-arm-smmu-v3-add-explicit-feature-for-nesting.patch
queue-6.1/drm-amdgpu-remove-unnecessary-domain-argument.patch
queue-6.1/iommu-arm-smmu-v3-document-mmu-700-erratum-2812531.patch
queue-6.1/iommu-arm-smmu-v3-document-nesting-related-errata.patch
queue-6.1/drm-amdgpu-use-apt-name-for-fw-reserved-region.patch
queue-6.1/drm-amdgpu-add-vram-reservation-based-on-vram_usagebyfirmware_v2_2.patch
queue-6.1/iommu-arm-smmu-v3-work-around-mmu-600-erratum-1076982.patch
