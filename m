Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E679C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 09:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4F110F505;
	Wed, 17 Apr 2024 09:38:18 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47B410F541
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 09:38:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43H9cBnP168044; Wed, 17 Apr 2024 15:08:11 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43H9cBbk168043;
 Wed, 17 Apr 2024 15:08:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v5 1/6] drm/amdgpu: add prototype for ip dump
Date: Wed, 17 Apr 2024 15:08:04 +0530
Message-Id: <20240417093809.168002-1-sunil.khatri@amd.com>
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

Add the prototype to dump ip registers
for all ips of different asics and set
them to NULL for now. Based on the
requirement add a function pointer for
each of them.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/cik.c                  | 1 +
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              | 1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              | 1 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c                   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/si.c                   | 1 +
 drivers/gpu/drm/amd/amdgpu/si_dma.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c                | 1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                | 1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                | 1 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/vi.c                   | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        | 1 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        | 1 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 1 +
 64 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 6d72355ac492..34a62033a388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -637,6 +637,7 @@ static const struct amd_ip_funcs acp_ip_funcs = {
 	.soft_reset = acp_soft_reset,
 	.set_clockgating_state = acp_set_clockgating_state,
 	.set_powergating_state = acp_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version acp_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 95f80b9131a8..5bb9e0dacbf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -875,6 +875,7 @@ static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs = {
 	.hw_fini = umsch_mm_hw_fini,
 	.suspend = umsch_mm_suspend,
 	.resume = umsch_mm_resume,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 8baa2e0935cc..d1dc91009c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -658,6 +658,7 @@ static const struct amd_ip_funcs amdgpu_vkms_ip_funcs = {
 	.soft_reset = amdgpu_vkms_soft_reset,
 	.set_clockgating_state = amdgpu_vkms_set_clockgating_state,
 	.set_powergating_state = amdgpu_vkms_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version amdgpu_vkms_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fdbc26346b54..884de42553a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2210,6 +2210,7 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
 	.soft_reset = cik_common_soft_reset,
 	.set_clockgating_state = cik_common_set_clockgating_state,
 	.set_powergating_state = cik_common_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ip_block_version cik_common_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index f24e34dc33d1..676f3f612fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -435,6 +435,7 @@ static const struct amd_ip_funcs cik_ih_ip_funcs = {
 	.soft_reset = cik_ih_soft_reset,
 	.set_clockgating_state = cik_ih_set_clockgating_state,
 	.set_powergating_state = cik_ih_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs cik_ih_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index a3fccc4c1f43..d797b1fbbffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1228,6 +1228,7 @@ static const struct amd_ip_funcs cik_sdma_ip_funcs = {
 	.soft_reset = cik_sdma_soft_reset,
 	.set_clockgating_state = cik_sdma_set_clockgating_state,
 	.set_powergating_state = cik_sdma_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs cik_sdma_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index c19681492efa..958c84a6af7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -433,6 +433,7 @@ static const struct amd_ip_funcs cz_ih_ip_funcs = {
 	.soft_reset = cz_ih_soft_reset,
 	.set_clockgating_state = cz_ih_set_clockgating_state,
 	.set_powergating_state = cz_ih_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs cz_ih_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 221af054d874..7a32ca7d6fc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3333,6 +3333,7 @@ static const struct amd_ip_funcs dce_v10_0_ip_funcs = {
 	.soft_reset = dce_v10_0_soft_reset,
 	.set_clockgating_state = dce_v10_0_set_clockgating_state,
 	.set_powergating_state = dce_v10_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 69e8b0db6cf7..67c01e137fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3464,6 +3464,7 @@ static const struct amd_ip_funcs dce_v11_0_ip_funcs = {
 	.soft_reset = dce_v11_0_soft_reset,
 	.set_clockgating_state = dce_v11_0_set_clockgating_state,
 	.set_powergating_state = dce_v11_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 60d40201fdd1..209cd44bbcec 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -3154,6 +3154,7 @@ static const struct amd_ip_funcs dce_v6_0_ip_funcs = {
 	.soft_reset = dce_v6_0_soft_reset,
 	.set_clockgating_state = dce_v6_0_set_clockgating_state,
 	.set_powergating_state = dce_v6_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 5a5fcc45e452..fff7f4f766b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3242,6 +3242,7 @@ static const struct amd_ip_funcs dce_v8_0_ip_funcs = {
 	.soft_reset = dce_v8_0_soft_reset,
 	.set_clockgating_state = dce_v8_0_set_clockgating_state,
 	.set_powergating_state = dce_v8_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d5b924222903..a0bc4196ff8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9170,6 +9170,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
 	.set_powergating_state = gfx_v10_0_set_powergating_state,
 	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5dbfef49dd5d..fec076c90fd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6169,6 +6169,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
 	.set_powergating_state = gfx_v11_0_set_powergating_state,
 	.get_clockgating_state = gfx_v11_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 34f9211b2679..559250c8a147 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3457,6 +3457,7 @@ static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 	.soft_reset = gfx_v6_0_soft_reset,
 	.set_clockgating_state = gfx_v6_0_set_clockgating_state,
 	.set_powergating_state = gfx_v6_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 86a4865b1ae5..81f7ab0dc135 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4977,6 +4977,7 @@ static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
 	.soft_reset = gfx_v7_0_soft_reset,
 	.set_clockgating_state = gfx_v7_0_set_clockgating_state,
 	.set_powergating_state = gfx_v7_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 202ddda57f98..522cbd45dd46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6878,6 +6878,7 @@ static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.set_clockgating_state = gfx_v8_0_set_clockgating_state,
 	.set_powergating_state = gfx_v8_0_set_powergating_state,
 	.get_clockgating_state = gfx_v8_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 71b555993b7a..ff4229b005dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6856,6 +6856,7 @@ static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.set_clockgating_state = gfx_v9_0_set_clockgating_state,
 	.set_powergating_state = gfx_v9_0_set_powergating_state,
 	.get_clockgating_state = gfx_v9_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fc33354f1d3d..16881e9345c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4016,6 +4016,7 @@ static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.set_clockgating_state = gfx_v9_4_3_set_clockgating_state,
 	.set_powergating_state = gfx_v9_4_3_set_powergating_state,
 	.get_clockgating_state = gfx_v9_4_3_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 23b478639921..060e54b8ffff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1115,6 +1115,7 @@ static const struct amd_ip_funcs gmc_v6_0_ip_funcs = {
 	.soft_reset = gmc_v6_0_soft_reset,
 	.set_clockgating_state = gmc_v6_0_set_clockgating_state,
 	.set_powergating_state = gmc_v6_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_gmc_funcs gmc_v6_0_gmc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 3da7b6a2b00d..534825022ddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1354,6 +1354,7 @@ static const struct amd_ip_funcs gmc_v7_0_ip_funcs = {
 	.soft_reset = gmc_v7_0_soft_reset,
 	.set_clockgating_state = gmc_v7_0_set_clockgating_state,
 	.set_powergating_state = gmc_v7_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_gmc_funcs gmc_v7_0_gmc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index d20e5f20ee31..aba787e1386a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1717,6 +1717,7 @@ static const struct amd_ip_funcs gmc_v8_0_ip_funcs = {
 	.set_clockgating_state = gmc_v8_0_set_clockgating_state,
 	.set_powergating_state = gmc_v8_0_set_powergating_state,
 	.get_clockgating_state = gmc_v8_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_gmc_funcs gmc_v8_0_gmc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 2c02ae69883d..2d6f969266b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -425,6 +425,7 @@ static const struct amd_ip_funcs iceland_ih_ip_funcs = {
 	.soft_reset = iceland_ih_soft_reset,
 	.set_clockgating_state = iceland_ih_set_clockgating_state,
 	.set_powergating_state = iceland_ih_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs iceland_ih_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index c757ef99e3c5..77b5068b7be5 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -770,6 +770,7 @@ static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
 	.set_clockgating_state = ih_v6_0_set_clockgating_state,
 	.set_powergating_state = ih_v6_0_set_powergating_state,
 	.get_clockgating_state = ih_v6_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 29ed78798070..fc2c27a199c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -775,6 +775,7 @@ static const struct amd_ip_funcs ih_v6_1_ip_funcs = {
 	.set_clockgating_state = ih_v6_1_set_clockgating_state,
 	.set_powergating_state = ih_v6_1_set_powergating_state,
 	.get_clockgating_state = ih_v6_1_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs ih_v6_1_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 7aed96fa10a9..31ed5030169b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -749,6 +749,7 @@ static const struct amd_ip_funcs ih_v7_0_ip_funcs = {
 	.set_clockgating_state = ih_v7_0_set_clockgating_state,
 	.set_powergating_state = ih_v7_0_set_powergating_state,
 	.get_clockgating_state = ih_v7_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs ih_v7_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 1c8116d75f63..698c5d4b7484 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -759,6 +759,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v2_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 99cd49ee8ef6..0a9a2d58e3ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -632,6 +632,7 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
@@ -652,6 +653,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a92481da60cd..e03d46151ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -557,6 +557,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v3_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v3_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 88ea58d5c4ab..f142cb200552 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -719,6 +719,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v4_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 32caeb37cef9..bc3a6f16f4bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1053,6 +1053,7 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index edf5bcdd2bc9..ee29c97721ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -762,6 +762,7 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v4_0_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_5_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index e70200f97555..f5664c92d10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -513,6 +513,7 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1e5ad1e08d2a..4ed0429cf4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1176,6 +1176,7 @@ static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
 	.hw_fini = mes_v10_1_hw_fini,
 	.suspend = mes_v10_1_suspend,
 	.resume = mes_v10_1_resume,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version mes_v10_1_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 81833395324a..57f17c699d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1334,6 +1334,7 @@ static const struct amd_ip_funcs mes_v11_0_ip_funcs = {
 	.hw_fini = mes_v11_0_hw_fini,
 	.suspend = mes_v11_0_suspend,
 	.resume = mes_v11_0_resume,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version mes_v11_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 4178f4e5dad7..550c5ca4ea03 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -713,6 +713,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
 	.set_clockgating_state = navi10_ih_set_clockgating_state,
 	.set_powergating_state = navi10_ih_set_powergating_state,
 	.get_clockgating_state = navi10_ih_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs navi10_ih_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4d7976b77767..d7d3b972392b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1131,4 +1131,5 @@ static const struct amd_ip_funcs nv_common_ip_funcs = {
 	.set_clockgating_state = nv_common_set_clockgating_state,
 	.set_powergating_state = nv_common_set_powergating_state,
 	.get_clockgating_state = nv_common_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 07e19caf2bc1..5c67c8a5c35f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1113,6 +1113,7 @@ static const struct amd_ip_funcs sdma_v2_4_ip_funcs = {
 	.soft_reset = sdma_v2_4_soft_reset,
 	.set_clockgating_state = sdma_v2_4_set_clockgating_state,
 	.set_powergating_state = sdma_v2_4_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs sdma_v2_4_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 2ad615be4bb3..4fad06daa9c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1553,6 +1553,7 @@ static const struct amd_ip_funcs sdma_v3_0_ip_funcs = {
 	.set_clockgating_state = sdma_v3_0_set_clockgating_state,
 	.set_powergating_state = sdma_v3_0_set_powergating_state,
 	.get_clockgating_state = sdma_v3_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 67e179c7e347..b5b15dba9a76 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2706,6 +2706,7 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
 	.soft_reset = si_common_soft_reset,
 	.set_clockgating_state = si_common_set_clockgating_state,
 	.set_powergating_state = si_common_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ip_block_version si_common_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 9aa0e11ee673..f969e5cc2a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -708,6 +708,7 @@ static const struct amd_ip_funcs si_dma_ip_funcs = {
 	.soft_reset = si_dma_soft_reset,
 	.set_clockgating_state = si_dma_set_clockgating_state,
 	.set_powergating_state = si_dma_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs si_dma_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index cada9f300a7f..3b7427f5a6c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -296,6 +296,7 @@ static const struct amd_ip_funcs si_ih_ip_funcs = {
 	.soft_reset = si_ih_soft_reset,
 	.set_clockgating_state = si_ih_set_clockgating_state,
 	.set_powergating_state = si_ih_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs si_ih_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c8abbf5da736..6ba6c96c91c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1501,4 +1501,5 @@ static const struct amd_ip_funcs soc15_common_ip_funcs = {
 	.set_clockgating_state = soc15_common_set_clockgating_state,
 	.set_powergating_state = soc15_common_set_powergating_state,
 	.get_clockgating_state= soc15_common_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 43ca63fe85ac..40e7ab0716cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -985,4 +985,5 @@ static const struct amd_ip_funcs soc21_common_ip_funcs = {
 	.set_clockgating_state = soc21_common_set_clockgating_state,
 	.set_powergating_state = soc21_common_set_powergating_state,
 	.get_clockgating_state = soc21_common_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 450b6e831509..794a1f7bc2ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -486,6 +486,7 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
 	.post_soft_reset = tonga_ih_post_soft_reset,
 	.set_clockgating_state = tonga_ih_set_clockgating_state,
 	.set_powergating_state = tonga_ih_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ih_funcs tonga_ih_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index a6006f231c65..1e232ed23102 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -819,6 +819,7 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs = {
 	.soft_reset = uvd_v3_1_soft_reset,
 	.set_clockgating_state = uvd_v3_1_set_clockgating_state,
 	.set_powergating_state = uvd_v3_1_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version uvd_v3_1_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 1aa09ad7bbe3..48bcf41e5558 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -769,6 +769,7 @@ static const struct amd_ip_funcs uvd_v4_2_ip_funcs = {
 	.soft_reset = uvd_v4_2_soft_reset,
 	.set_clockgating_state = uvd_v4_2_set_clockgating_state,
 	.set_powergating_state = uvd_v4_2_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs uvd_v4_2_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index f8b229b75435..838b7d720c52 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -877,6 +877,7 @@ static const struct amd_ip_funcs uvd_v5_0_ip_funcs = {
 	.set_clockgating_state = uvd_v5_0_set_clockgating_state,
 	.set_powergating_state = uvd_v5_0_set_powergating_state,
 	.get_clockgating_state = uvd_v5_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs uvd_v5_0_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index a9a6880f44e3..036378f5f53f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1545,6 +1545,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
 	.set_clockgating_state = uvd_v6_0_set_clockgating_state,
 	.set_powergating_state = uvd_v6_0_set_powergating_state,
 	.get_clockgating_state = uvd_v6_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs uvd_v6_0_ring_phys_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index a08e7abca423..2178cf5a27b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -626,6 +626,7 @@ static const struct amd_ip_funcs vce_v2_0_ip_funcs = {
 	.soft_reset = vce_v2_0_soft_reset,
 	.set_clockgating_state = vce_v2_0_set_clockgating_state,
 	.set_powergating_state = vce_v2_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs vce_v2_0_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index f4760748d349..0f0d4b0d50cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -913,6 +913,7 @@ static const struct amd_ip_funcs vce_v3_0_ip_funcs = {
 	.set_clockgating_state = vce_v3_0_set_clockgating_state,
 	.set_powergating_state = vce_v3_0_set_powergating_state,
 	.get_clockgating_state = vce_v3_0_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs vce_v3_0_ring_phys_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index aaceecd558cf..7ff5d0574454 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1902,6 +1902,7 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.post_soft_reset = NULL /* vcn_v1_0_post_soft_reset */,
 	.set_clockgating_state = vcn_v1_0_set_clockgating_state,
 	.set_powergating_state = vcn_v1_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e357d8cf0c01..4df1b75f971a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2008,6 +2008,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v2_0_set_clockgating_state,
 	.set_powergating_state = vcn_v2_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 1cd8a94b0fbc..d91c3154641b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1901,6 +1901,7 @@ static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v2_5_set_clockgating_state,
 	.set_powergating_state = vcn_v2_5_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
@@ -1921,6 +1922,7 @@ static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
         .post_soft_reset = NULL,
         .set_clockgating_state = vcn_v2_5_set_clockgating_state,
         .set_powergating_state = vcn_v2_5_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version vcn_v2_5_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 8f82fb887e9c..e64af339e924 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2230,6 +2230,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v3_0_set_clockgating_state,
 	.set_powergating_state = vcn_v3_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version vcn_v3_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 832d15f7b5f6..efaad53e2ffe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2130,6 +2130,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v4_0_set_clockgating_state,
 	.set_powergating_state = vcn_v4_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version vcn_v4_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 203fa988322b..599b6466183e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1660,6 +1660,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
 	.set_powergating_state = vcn_v4_0_3_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 501e53e69f2a..c649fa2c19e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1752,6 +1752,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v4_0_5_set_clockgating_state,
 	.set_powergating_state = vcn_v4_0_5_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version vcn_v4_0_5_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index bc60c554eb32..9d0d1efd1acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1328,6 +1328,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
 	.set_powergating_state = vcn_v5_0_0_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 2415355b037c..a04aa6833fc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -2058,6 +2058,7 @@ static const struct amd_ip_funcs vi_common_ip_funcs = {
 	.set_clockgating_state = vi_common_set_clockgating_state,
 	.set_powergating_state = vi_common_set_powergating_state,
 	.get_clockgating_state = vi_common_get_clockgating_state,
+	.dump_ip_state = NULL,
 };
 
 static const struct amdgpu_ip_block_version vi_common_ip_block =
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2c06f2bee4a5..8bd8bd77b9be 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3120,6 +3120,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.soft_reset = dm_soft_reset,
 	.set_clockgating_state = dm_set_clockgating_state,
 	.set_powergating_state = dm_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version dm_ip_block = {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index b0a6256e89f4..9884f6c48a7d 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -321,6 +321,7 @@ struct amd_ip_funcs {
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u64 *flags);
+	void (*dump_ip_state)(void *handle);
 };
 
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 5cb4725c773f..8c07f8c7f3ab 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3316,6 +3316,7 @@ static const struct amd_ip_funcs kv_dpm_ip_funcs = {
 	.soft_reset = kv_dpm_soft_reset,
 	.set_clockgating_state = kv_dpm_set_clockgating_state,
 	.set_powergating_state = kv_dpm_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version kv_smu_ip_block = {
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index eb4da3666e05..c312b9332326 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -8060,6 +8060,7 @@ static const struct amd_ip_funcs si_dpm_ip_funcs = {
 	.soft_reset = si_dpm_soft_reset,
 	.set_clockgating_state = si_dpm_set_clockgating_state,
 	.set_powergating_state = si_dpm_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version si_smu_ip_block =
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 133d1ee6e67c..c63474ee17a7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -302,6 +302,7 @@ static const struct amd_ip_funcs pp_ip_funcs = {
 	.soft_reset = pp_sw_reset,
 	.set_clockgating_state = pp_set_clockgating_state,
 	.set_powergating_state = pp_set_powergating_state,
+	.dump_ip_state = NULL,
 };
 
 const struct amdgpu_ip_block_version pp_smu_ip_block =
-- 
2.34.1

