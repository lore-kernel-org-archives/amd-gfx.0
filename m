Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B6ECF9C71
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 03:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A9310E2C5;
	Wed, 25 Sep 2024 03:51:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96B210E2C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 03:51:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48P3pYoa1887442; Wed, 25 Sep 2024 09:21:34 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48P3pY6B1887441;
 Wed, 25 Sep 2024 09:21:34 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update the handle ptr in dump_ip_state
Date: Wed, 25 Sep 2024 09:21:31 +0530
Message-Id: <20240925035132.1887405-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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
the functions.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    | 4 ++--
 drivers/gpu/drm/amd/include/amd_shared.h   | 4 +++-
 22 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c4d4fbcfca7a..c5827171b596 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5380,7 +5380,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			for (i = 0; i < tmp_adev->num_ip_blocks; i++)
 				if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
 					tmp_adev->ip_blocks[i].version->funcs
-						->dump_ip_state((void *)tmp_adev);
+						->dump_ip_state((void *)&tmp_adev->ip_blocks[i]);
 			dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 13a3604cf107..fdadbe49c913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -42,7 +42,7 @@ static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
 	for (i = 0; i < adev->num_ip_blocks; i++)
 		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
 			adev->ip_blocks[i].version->funcs
-				->dump_ip_state((void *)adev);
+				->dump_ip_state((void *)&adev->ip_blocks[i]);
 	dev_info(adev->dev, "Dumping IP State Completed\n");
 
 	amdgpu_coredump(adev, true, false, job);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 45ed97038df0..61300eb88ab4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9632,9 +9632,9 @@ static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
 	}
 }
 
-static void gfx_v10_ip_dump(void *handle)
+static void gfx_v10_ip_dump(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d3e8be82a172..36dc6af70330 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6703,9 +6703,9 @@ static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
 	}
 }
 
-static void gfx_v11_ip_dump(void *handle)
+static void gfx_v11_ip_dump(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_11_0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 47b47d21f464..13baa6868a78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5102,9 +5102,9 @@ static void gfx_v12_ip_print(void *handle, struct drm_printer *p)
 	}
 }
 
-static void gfx_v12_ip_dump(void *handle)
+static void gfx_v12_ip_dump(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 23f0573ae47b..4d8db3dd3f37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7356,9 +7356,9 @@ static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
 
 }
 
-static void gfx_v9_ip_dump(void *handle)
+static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c100845409f7..f973d922e6b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4643,9 +4643,9 @@ static void gfx_v9_4_3_ip_print(void *handle, struct drm_printer *p)
 	}
 }
 
-static void gfx_v9_4_3_ip_dump(void *handle)
+static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t i, j, k;
 	uint32_t num_xcc, reg, num_inst;
 	uint32_t xcc_id, xcc_offset, inst_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 23ef4eb36b40..50ad06f06c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2371,9 +2371,9 @@ static void sdma_v4_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void sdma_v4_0_dump_ip_state(void *handle)
+static void sdma_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t instance_offset;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_0);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760..487cc0992263 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1878,9 +1878,9 @@ static void sdma_v4_4_2_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void sdma_v4_4_2_dump_ip_state(void *handle)
+static void sdma_v4_4_2_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t instance_offset;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_4_2);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 3e48ea38385d..3ecf77ce2f1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1799,9 +1799,9 @@ static void sdma_v5_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void sdma_v5_0_dump_ip_state(void *handle)
+static void sdma_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t instance_offset;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_0);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bc9b240a3488..d19dde1d6fc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1757,9 +1757,9 @@ static void sdma_v5_2_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void sdma_v5_2_dump_ip_state(void *handle)
+static void sdma_v5_2_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t instance_offset;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_2);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 581fa550ef29..ed7413c1954c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1624,9 +1624,9 @@ static void sdma_v6_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void sdma_v6_0_dump_ip_state(void *handle)
+static void sdma_v6_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t instance_offset;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_6_0);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index cfd8e183ad50..a69b6cf7106c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1556,9 +1556,9 @@ static void sdma_v7_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void sdma_v7_0_dump_ip_state(void *handle)
+static void sdma_v7_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	uint32_t instance_offset;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_7_0);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index ecdfbfefd66a..78dfcd02d8da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1957,9 +1957,9 @@ static void vcn_v1_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v1_0_dump_ip_state(void *handle)
+static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index bfd067e2d2f1..5d6accdba480 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2066,9 +2066,9 @@ static void vcn_v2_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v2_0_dump_ip_state(void *handle)
+static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 04e9e806e318..8896c25fd1d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1958,9 +1958,9 @@ static void vcn_v2_5_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v2_5_dump_ip_state(void *handle)
+static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 65dd68b32280..3009f52f62d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2284,9 +2284,9 @@ static void vcn_v3_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v3_0_dump_ip_state(void *handle)
+static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 26c6f10a8c8f..17ea10c14e29 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2190,9 +2190,9 @@ static void vcn_v4_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v4_0_dump_ip_state(void *handle)
+static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0fda70336300..742bf09ae195 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1765,9 +1765,9 @@ static void vcn_v4_0_3_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v4_0_3_dump_ip_state(void *handle)
+static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off, inst_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9d4f5352a62c..3fb8b218e278 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1648,9 +1648,9 @@ static void vcn_v4_0_5_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v4_0_5_dump_ip_state(void *handle)
+static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c305386358b4..25ae338df346 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1375,9 +1375,9 @@ static void vcn_v5_0_print_ip_state(void *handle, struct drm_printer *p)
 	}
 }
 
-static void vcn_v5_0_dump_ip_state(void *handle)
+static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
 	bool is_powered;
 	uint32_t inst_off;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 3f91926a50e9..cbb19895ddaf 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -375,6 +375,8 @@ enum amd_dpm_forced_level;
  * making calls to hooks from each IP block. This list is ordered to ensure
  * that the driver initializes the IP blocks in a safe sequence.
  */
+struct amdgpu_ip_block;
+
 struct amd_ip_funcs {
 	char *name;
 	int (*early_init)(void *handle);
@@ -399,7 +401,7 @@ struct amd_ip_funcs {
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u64 *flags);
-	void (*dump_ip_state)(void *handle);
+	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
 	void (*print_ip_state)(void *handle, struct drm_printer *p);
 };
 
-- 
2.34.1

