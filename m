Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E764DCF9C71
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 03:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E8510E2C9;
	Wed, 25 Sep 2024 03:52:30 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDB210E782
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 03:52:27 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48P3pYR01887447; Wed, 25 Sep 2024 09:21:34 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48P3pYsp1887446;
 Wed, 25 Sep 2024 09:21:34 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update the handle ptr in print_ip_state
Date: Wed, 25 Sep 2024 09:21:32 +0530
Message-Id: <20240925035132.1887405-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925035132.1887405-1-sunil.khatri@amd.com>
References: <20240925035132.1887405-1-sunil.khatri@amd.com>
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

Update the ptr handle to amdgpu_ip_block ptr in all
the functions affected.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c         |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c          |  4 ++--
 drivers/gpu/drm/amd/include/amd_shared.h         |  2 +-
 21 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 5ac59b62020c..ecd4e8ea2de4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -203,6 +203,7 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	struct amdgpu_coredump_info *coredump = data;
 	struct drm_print_iterator iter;
 	struct amdgpu_vm_fault_info *fault_info;
+	struct amdgpu_ip_block *ip_block;
 	int ver;
 
 	iter.data = buffer;
@@ -282,13 +283,10 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	/* dump the ip state for each ip */
 	drm_printf(&p, "IP Dump\n");
 	for (int i = 0; i < coredump->adev->num_ip_blocks; i++) {
-		if (coredump->adev->ip_blocks[i].version->funcs->print_ip_state) {
-			drm_printf(&p, "IP: %s\n",
-				   coredump->adev->ip_blocks[i]
-					   .version->funcs->name);
-			coredump->adev->ip_blocks[i]
-				.version->funcs->print_ip_state(
-					(void *)coredump->adev, &p);
+		ip_block = &(coredump->adev->ip_blocks[i]);
+		if (ip_block->version->funcs->print_ip_state) {
+			drm_printf(&p, "IP: %s\n", ip_block->version->funcs->name);
+			ip_block->version->funcs->print_ip_state(ip_block, &p);
 			drm_printf(&p, "\n");
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 61300eb88ab4..4b889a2acb10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9568,9 +9568,9 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	return amdgpu_ring_test_ring(ring);
 }
 
-static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
+static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 36dc6af70330..7a6fc9a88d65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6639,9 +6639,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	return amdgpu_ring_test_ring(ring);
 }
 
-static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
+static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_11_0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 13baa6868a78..3044436436c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5038,9 +5038,9 @@ static void gfx_v12_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 		amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
-static void gfx_v12_ip_print(void *handle, struct drm_printer *p)
+static void gfx_v12_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4d8db3dd3f37..8f4f167cfd73 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7316,9 +7316,9 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	return amdgpu_ring_test_ring(ring);
 }
 
-static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
+static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f973d922e6b3..3757a5b88762 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4583,9 +4583,9 @@ static void gfx_v9_4_3_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_no
 		amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
-static void gfx_v9_4_3_ip_print(void *handle, struct drm_printer *p)
+static void gfx_v9_4_3_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k;
 	uint32_t xcc_id, xcc_offset, inst_offset;
 	uint32_t num_xcc, reg, num_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 50ad06f06c62..f17ce2d53b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2350,9 +2350,9 @@ static void sdma_v4_0_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
-static void sdma_v4_0_print_ip_state(void *handle, struct drm_printer *p)
+static void sdma_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_0);
 	uint32_t instance_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 487cc0992263..d577b973d0a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1857,9 +1857,9 @@ static void sdma_v4_4_2_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
-static void sdma_v4_4_2_print_ip_state(void *handle, struct drm_printer *p)
+static void sdma_v4_4_2_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_4_2);
 	uint32_t instance_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 3ecf77ce2f1a..b44d7d17d137 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1778,9 +1778,9 @@ static void sdma_v5_0_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
-static void sdma_v5_0_print_ip_state(void *handle, struct drm_printer *p)
+static void sdma_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_0);
 	uint32_t instance_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index d19dde1d6fc5..8761b54050ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1736,9 +1736,9 @@ static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-static void sdma_v5_2_print_ip_state(void *handle, struct drm_printer *p)
+static void sdma_v5_2_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_2);
 	uint32_t instance_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index ed7413c1954c..5eafc81e82f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1603,9 +1603,9 @@ static void sdma_v6_0_get_clockgating_state(void *handle, u64 *flags)
 {
 }
 
-static void sdma_v6_0_print_ip_state(void *handle, struct drm_printer *p)
+static void sdma_v6_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_6_0);
 	uint32_t instance_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index a69b6cf7106c..fe4b7b758afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1535,9 +1535,9 @@ static void sdma_v7_0_get_clockgating_state(void *handle, u64 *flags)
 {
 }
 
-static void sdma_v7_0_print_ip_state(void *handle, struct drm_printer *p)
+static void sdma_v7_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_7_0);
 	uint32_t instance_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 78dfcd02d8da..21e0962e53c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1925,9 +1925,9 @@ void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
 }
 
-static void vcn_v1_0_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t inst_off, is_powered;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 5d6accdba480..b6d41d531ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2034,9 +2034,9 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 	return vcn_v2_0_start_mmsch(adev, &adev->virt.mm_table);
 }
 
-static void vcn_v2_0_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t inst_off, is_powered;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8896c25fd1d4..6be770a060ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1926,9 +1926,9 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v2_5_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t inst_off, is_powered;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3009f52f62d7..0c2d698ca046 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2251,9 +2251,9 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v3_0_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 17ea10c14e29..d3aa1a5b2529 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2158,9 +2158,9 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v4_0_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t inst_off, is_powered;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 742bf09ae195..ca5ac917f07d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1733,9 +1733,9 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
 }
 
-static void vcn_v4_0_3_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t inst_off, is_powered;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 3fb8b218e278..0d8aa5a0904b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1616,9 +1616,9 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v4_0_5_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t inst_off, is_powered;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 25ae338df346..8a2e217ae5c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1343,9 +1343,9 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v5_0_print_ip_state(void *handle, struct drm_printer *p)
+static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t inst_off, is_powered;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index cbb19895ddaf..9b02ab1c2048 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -402,7 +402,7 @@ struct amd_ip_funcs {
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u64 *flags);
 	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
-	void (*print_ip_state)(void *handle, struct drm_printer *p);
+	void (*print_ip_state)(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 };
 
 
-- 
2.34.1

