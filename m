Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9444C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 11:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EAA510E23F;
	Thu,  9 May 2024 11:19:37 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8957310E23F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 11:19:33 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 449BJSvC4058401; Thu, 9 May 2024 16:49:28 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 449BJSFq4058400;
 Thu, 9 May 2024 16:49:28 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 3/4] drm/amdgpu: add support to dump gfx10 queue registers
Date: Thu,  9 May 2024 16:49:03 +0530
Message-Id: <20240509111904.4058197-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509111904.4058197-1-sunil.khatri@amd.com>
References: <20240509111904.4058197-1-sunil.khatri@amd.com>
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

Add gfx queue register for all instances in ip dump
for gfx10.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 83 +++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d6e341b389fb..3495f117b527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -437,6 +437,7 @@ struct amdgpu_gfx {
 	/* IP reg dump */
 	uint32_t			*ipdump_core;
 	uint32_t			*ipdump_cp;
+	uint32_t			*ipdump_gfx_queue;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index daf9a3571183..b0f38e877c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -424,6 +424,33 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_10[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)
 };
 
+static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_10[] = {
+	/* gfx queue registers */
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_ACTIVE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CSMD_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_MAPPED),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_QUE_MGR_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_HQ_CONTROL0),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_HQ_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR_POLL_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_CSMD_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI)
+};
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
@@ -4664,6 +4691,19 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 	} else {
 		adev->gfx.ipdump_cp = ptr;
 	}
+
+	/* Allocate memory for gfx cp queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_10);
+	inst = adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
+		adev->gfx.me.num_queue_per_pipe;
+
+	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	if (ptr == NULL) {
+		DRM_ERROR("Failed to allocate memory for GFX CP IP Dump\n");
+		adev->gfx.ipdump_gfx_queue = NULL;
+	} else {
+		adev->gfx.ipdump_gfx_queue = ptr;
+	}
 }
 
 static int gfx_v10_0_sw_init(void *handle)
@@ -4874,6 +4914,7 @@ static int gfx_v10_0_sw_fini(void *handle)
 
 	kfree(adev->gfx.ipdump_core);
 	kfree(adev->gfx.ipdump_cp);
+	kfree(adev->gfx.ipdump_gfx_queue);
 
 	return 0;
 }
@@ -9368,6 +9409,26 @@ static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
 			}
 		}
 	}
+
+	/* print gfx queue registers for all instances */
+	if (!adev->gfx.ipdump_gfx_queue)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_10);
+
+	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+				drm_printf(p, "me %d, pipe %d, queue %d\n", i, j, k);
+				for (reg = 0; reg < reg_count; reg++) {
+					drm_printf(p, "%-50s \t 0x%08x\n",
+						   gc_gfx_queue_reg_list_10[reg].reg_name,
+						   adev->gfx.ipdump_gfx_queue[index + reg]);
+				}
+				index += reg_count;
+			}
+		}
+	}
 }
 
 static void gfx_v10_ip_dump(void *handle)
@@ -9414,6 +9475,28 @@ static void gfx_v10_ip_dump(void *handle)
 	nv_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* dump gfx queue registers for all instances */
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_10);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
+				nv_grbm_select(adev, i, j, k, 0);
+
+				for (reg = 0; reg < reg_count; reg++) {
+					adev->gfx.ipdump_gfx_queue[index + reg] =
+						RREG32(SOC15_REG_ENTRY_OFFSET(
+							gc_gfx_queue_reg_list_10[reg]));
+				}
+				index += reg_count;
+			}
+		}
+	}
+	nv_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
-- 
2.34.1

