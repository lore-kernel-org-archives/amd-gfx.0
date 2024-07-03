Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC648C30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 07:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680F210E030;
	Wed,  3 Jul 2024 07:39:11 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D87010E11F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 07:39:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4637d5nt914414; Wed, 3 Jul 2024 13:09:05 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4637d5d9914413;
 Wed, 3 Jul 2024 13:09:05 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 4/4] drm/amdgpu: add gfx queue support for gfx12 ipdump
Date: Wed,  3 Jul 2024 13:09:01 +0530
Message-Id: <20240703073901.914348-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703073901.914348-1-sunil.khatri@amd.com>
References: <20240703073901.914348-1-sunil.khatri@amd.com>
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

Add support of all the CP GFX queues for gfx12 ipdump
to be used by devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 94 ++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 21b8167f39bd..cf7209b93617 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -173,6 +173,35 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS)
 };
 
+static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_12[] = {
+	/* gfx queue registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_ACTIVE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_VMID),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUANTUM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_CSMD_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_MAPPED),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUE_MGR_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_HQ_CONTROL0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_HQ_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_MQD_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_MQD_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -1265,6 +1294,19 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	} else {
 		adev->gfx.ip_dump_compute_queues = ptr;
 	}
+
+	/* Allocate memory for gfx queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_12);
+	inst = adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
+		adev->gfx.me.num_queue_per_pipe;
+
+	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	if (ptr == NULL) {
+		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
+		adev->gfx.ip_dump_gfx_queues = NULL;
+	} else {
+		adev->gfx.ip_dump_gfx_queues = ptr;
+	}
 }
 
 static int gfx_v12_0_sw_init(void *handle)
@@ -1462,6 +1504,7 @@ static int gfx_v12_0_sw_fini(void *handle)
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
+	kfree(adev->gfx.ip_dump_gfx_queues);
 
 	return 0;
 }
@@ -4853,6 +4896,31 @@ static void gfx_v12_ip_print(void *handle, struct drm_printer *p)
 			}
 		}
 	}
+
+	/* print gfx queue registers for all instances */
+	if (!adev->gfx.ip_dump_gfx_queues)
+		return;
+
+	index = 0;
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_12);
+	drm_printf(p, "\nnum_me: %d num_pipe: %d num_queue: %d\n",
+		   adev->gfx.me.num_me,
+		   adev->gfx.me.num_pipe_per_me,
+		   adev->gfx.me.num_queue_per_pipe);
+
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
+				drm_printf(p, "\nme %d, pipe %d, queue %d\n", i, j, k);
+				for (reg = 0; reg < reg_count; reg++) {
+					drm_printf(p, "%-50s \t 0x%08x\n",
+						   gc_gfx_queue_reg_list_12[reg].reg_name,
+						   adev->gfx.ip_dump_gfx_queues[index + reg]);
+				}
+				index += reg_count;
+			}
+		}
+	}
 }
 
 static void gfx_v12_ip_dump(void *handle)
@@ -4893,6 +4961,32 @@ static void gfx_v12_ip_dump(void *handle)
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* dump gfx queue registers for all instances */
+	if (!adev->gfx.ip_dump_gfx_queues)
+		return;
+
+	index = 0;
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_12);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
+				soc24_grbm_select(adev, i, j, k, 0);
+
+				for (reg = 0; reg < reg_count; reg++) {
+					adev->gfx.ip_dump_gfx_queues[index + reg] =
+						RREG32(SOC15_REG_ENTRY_OFFSET(
+							gc_gfx_queue_reg_list_12[reg]));
+				}
+				index += reg_count;
+			}
+		}
+	}
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
-- 
2.34.1

