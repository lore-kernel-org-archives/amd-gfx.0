Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41745C02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02E310EA29;
	Fri,  7 Feb 2025 06:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UAhNaigs";
	dkim-atps=neutral
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF9E10EA27
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738909737; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Oz8/YdwZRlWlks0mcl4+bokya7NyzlCED9TshUlJl+Y=;
 b=UAhNaigsjRVDF1cGq0+7fpd5yuvnPAu9oSNSvUnRbUcsxpMGRYHf4CuK2lLb1GbDvgZmjtamMLqHFh5+cZpTLG9wBYQYzY7jSPURcB+dHTmxEoFd31TUrhrBxiBL1Ls3ateI0DryU47Zj7p+sFraHKiCm8WYi2ey2/v6OEd6Xik=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyT2p-_1738909736 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:28:56 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 2/4] drm/amdgpu: enhance error handling of psp_sw_init()
Date: Fri,  7 Feb 2025 14:28:50 +0800
Message-ID: <c09fde05278ef6d8344194247ec536347ceb583f.1738909308.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738909308.git.gerry@linux.alibaba.com>
References: <cover.1738909308.git.gerry@linux.alibaba.com>
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

Enhance error handling in function psp_sw_init() by:
1) bail out when failed to allocate memory
2) release allocated resource on error
3) introduce helper function psp_bo_init()

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 84 ++++++++++++++++---------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4e9766a1d421..0d1eb7b8e59b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -423,6 +423,50 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int psp_bo_init(struct amdgpu_device *adev, struct psp_context *psp)
+{
+	int ret;
+
+	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
+				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
+				      &psp->fw_pri_bo,
+				      &psp->fw_pri_mc_addr,
+				      &psp->fw_pri_buf);
+	if (ret)
+		goto failed1;
+
+	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      &psp->fence_buf_bo,
+				      &psp->fence_buf_mc_addr,
+				      &psp->fence_buf);
+	if (ret)
+		goto failed2;
+
+	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+				      (void **)&psp->cmd_buf_mem);
+	if (ret)
+		goto failed3;
+
+	return 0;
+
+failed3:
+	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
+			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+	psp->fence_buf_bo = NULL;
+failed2:
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
+	psp->fw_pri_bo = NULL;
+failed1:
+	return ret;
+}
+
 static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -435,7 +479,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
 		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
-		ret = -ENOMEM;
+		return -ENOMEM;
 	}
 
 	adev->psp.xgmi_context.supports_extended_data =
@@ -482,50 +526,27 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 		ret = psp_memory_training_init(psp);
 		if (ret) {
 			dev_err(adev->dev, "Failed to initialize memory training!\n");
-			return ret;
+			goto failed1;
 		}
 
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
 		if (ret) {
 			dev_err(adev->dev, "Failed to process memory training!\n");
-			return ret;
+			goto failed2;
 		}
 	}
 
-	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
-				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
-				      &psp->fw_pri_bo,
-				      &psp->fw_pri_mc_addr,
-				      &psp->fw_pri_buf);
-	if (ret)
-		return ret;
-
-	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM |
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &psp->fence_buf_bo,
-				      &psp->fence_buf_mc_addr,
-				      &psp->fence_buf);
-	if (ret)
-		goto failed1;
-
-	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM |
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
-				      (void **)&psp->cmd_buf_mem);
+	ret = psp_bo_init(adev, psp);
 	if (ret)
 		goto failed2;
 
 	return 0;
 
 failed2:
-	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
-			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+	psp_memory_training_fini(psp);
 failed1:
-	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
-			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
+	kfree(psp->cmd);
+	psp->cmd = NULL;
 	return ret;
 }
 
@@ -554,10 +575,13 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
+	psp->fw_pri_bo = NULL;
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+	psp->fence_buf_bo = NULL;
 	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
 			      (void **)&psp->cmd_buf_mem);
+	psp->cmd_buf_bo = NULL;
 
 	return 0;
 }
-- 
2.43.5

