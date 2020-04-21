Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC24FC54FCC
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 06:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE086206F4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 06:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE086206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D216E8D1;
	Tue, 21 Apr 2020 06:59:31 +0000 (UTC)
Received: from m176115.mail.qiye.163.com (m176115.mail.qiye.163.com
 [59.111.176.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCAE6E889
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 06:48:36 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [157.0.31.122])
 by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 7E79D665C28;
 Tue, 21 Apr 2020 14:48:26 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3] amdgpu:optimization-- reduce no need mutex_lock area
Date: Mon, 20 Apr 2020 23:48:18 -0700
Message-Id: <20200421064818.129158-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VNSktLS0tKSEhOSk9PWVdZKFlBSE
 83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6Dhw*MDg5OAMJI04WVj4*
 ShoKCgJVSlVKTkNMT05KTEtCQ0JPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSUlZV1kIAVlBSEtCSzcG
X-HM-Tid: 0a719b7ebdb29373kuws7e79d665c28
X-Mailman-Approved-At: Tue, 21 Apr 2020 06:59:30 +0000
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
Reply-To: 1587181464-114215-1-git-send-email-bernard@vivo.com
Cc: opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Maybe we could reduce the mutex_lock(&mem->lock)`s protected code area,
and no need to protect pr_debug.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*commit message improve

Changes since V2:
*move comment along with the mutex_unlock

Link for V1:
*https://lore.kernel.org/patchwork/patch/1226588/
Link for V2:
*https://lore.kernel.org/patchwork/patch/1227907/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 327317c54f7c..f03d9843d723 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1285,21 +1285,21 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	struct bo_vm_reservation_context ctx;
 	struct ttm_validate_buffer *bo_list_entry;
 	int ret;
+	unsigned int mapped_to_gpu_memory;
 
 	mutex_lock(&mem->lock);
+	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
+	mutex_unlock(&mem->lock);
+	/* lock is not needed after this, since mem is unused and will
+	 * be freed anyway
+	 */
 
-	if (mem->mapped_to_gpu_memory > 0) {
+	if (mapped_to_gpu_memory > 0) {
 		pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
 				mem->va, bo_size);
-		mutex_unlock(&mem->lock);
 		return -EBUSY;
 	}
 
-	mutex_unlock(&mem->lock);
-	/* lock is not needed after this, since mem is unused and will
-	 * be freed anyway
-	 */
-
 	/* No more MMU notifiers */
 	amdgpu_mn_unregister(mem->bo);
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
