Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4753EC02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 09:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4EF10E04F;
	Tue, 14 Jan 2025 09:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VZ9sGBPr";
	dkim-atps=neutral
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A7910E0D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736848509; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=pEL79gYDv6eEyt+74qmQJ6bqueydfC/b771aK+cwGsg=;
 b=VZ9sGBPrSo20ZLTHsWP4oeM+GF300UHJbVe5wSRbVDChmXtdWtKK/9ptRSlHcC94GqNR/46eV9Y785XrazLSemDu6NQlfPHO4VYbJXzFvtnnrbjqbHv4Jk374UNO4Ok68IjzYTInAwcAreyUlkSmkKfpTSN6NomU4ifLvNUe7iE=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNera--_1736848506 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 14 Jan 2025 17:55:08 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v1 2/2] drm/amdgpu: introduce helper
 amdgpu_bo_get_pinned_gpu_addr()
Date: Tue, 14 Jan 2025 17:54:58 +0800
Message-ID: <5e08e4133ee13d172d6d313af5fe1e1fcfe80331.1736847835.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736847835.git.gerry@linux.alibaba.com>
References: <cover.1736847835.git.gerry@linux.alibaba.com>
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

Introduce helper amdgpu_bo_get_pinned_gpu_addr(), which will be
used to update GPU address of pinned kernel BO during resume.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4f057996ef35..bce939a63a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1555,6 +1555,15 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 	return amdgpu_gmc_sign_extend(offset);
 }
 
+/**
+ * amdgpu_bo_get_kernel_gpu_addr - get GPU address of pinned kernel BO
+ */
+void amdgpu_bo_get_pinned_gpu_addr(struct amdgpu_bo *bo, u64 *gpu_addr)
+{
+	if (bo && bo->tbo.pin_count && gpu_addr)
+		*gpu_addr = amdgpu_bo_gpu_offset(bo);
+}
+
 /**
  * amdgpu_bo_get_preferred_domain - get preferred domain
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ab3fe7b42da7..9022592291a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -305,6 +305,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
+void amdgpu_bo_get_pinned_gpu_addr(struct amdgpu_bo *bo, u64 *gpu_addr);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats,
 			  unsigned int size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index dde15c6a96e1..40605749b5d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -881,6 +881,15 @@ static int umsch_mm_suspend(struct amdgpu_ip_block *ip_block)
 
 static int umsch_mm_resume(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->umsch_mm.sch_ctx_gpu_addr = adev->wb.gpu_addr +
+					  (adev->umsch_mm.wb_index * 4);
+	amdgpu_bo_get_pinned_gpu_addr(adev->umsch_mm.cmd_buf_obj,
+				      &adev->umsch_mm.cmd_buf_gpu_addr);
+	amdgpu_bo_get_pinned_gpu_addr(adev->umsch_mm.dbglog_bo,
+				      &adev->umsch_mm.log_gpu_addr);
+
 	return umsch_mm_hw_init(ip_block);
 }
 
-- 
2.43.5

