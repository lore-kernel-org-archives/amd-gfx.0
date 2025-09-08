Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75D8CAC583
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 23:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C3510E2AE;
	Mon,  8 Sep 2025 23:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="clR5pmgD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E449910E215
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 23:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9pIy0xt5cH3RKTJGX+kspJAXtOm+h0TcC397eL0ppEw=; b=clR5pmgD998by0YXzwBhSIFFJA
 vPAxiMiMpcSSnIPC3hP8ccAXP6TbMYlwj0hzb4pew+J/xOdgchinF158lAa7ixqSlZknSqIqFjRLM
 dYFqIkQqMkKlf2ogUM1pTqhqgW0jX65aZ1JPJ6iBUI/VC8s/6hGaFtSZsFSybFQBu7o7mLzrBLLzx
 9fLeVdYM664fDWw2yH4YfMfZHijKoER0GDzCdGM+32fNfAEQ0pdbeAgEUzLUF5Tg2aJJEtD+I+hCh
 Sqp3WECVyMx5SKT5ZPr69Unccxl3oGCoz90FRX69o8x8CXvOaGi2+KvHyzLORtgA5cqPJH5FP5nOn
 ZbbsZlag==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvlBb-008iqD-RV; Tue, 09 Sep 2025 01:22:12 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/5] drm/amdgpu: Remove volatile from CSB functions
Date: Mon,  8 Sep 2025 17:15:36 -0600
Message-ID: <20250908232134.2223198-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908232134.2223198-1-siqueira@igalia.com>
References: <20250908232134.2223198-1-siqueira@igalia.com>
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

The CSB buffer manipulation occurs in memory where the BO is mapped
during initialization, and some references to this buffer are handled
with volatile, which is incorrect in this scenario. There are a few
cases where the use of volatile is accepted, but none of them align with
CSB operations. Therefore, this commit removes all the volatile
variables associated with the CSB code.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 7 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 3 +--
 10 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c80c8f543532..89fc1015d3a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2279,7 +2279,7 @@ void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
  * Return:
  * return the latest index.
  */
-u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer)
+u32 amdgpu_gfx_csb_preamble_start(u32 *buffer)
 {
 	u32 count = 0;
 
@@ -2303,7 +2303,7 @@ u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer)
  * Return:
  * return the latest index.
  */
-u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer, u32 count)
+u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, u32 count)
 {
 	const struct cs_section_def *sect = NULL;
 	const struct cs_extent_def *ext = NULL;
@@ -2330,7 +2330,7 @@ u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer,
  * @buffer: This is an output variable that gets the PACKET3 preamble end.
  * @count: Index to start set the preemble end.
  */
-void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count)
+void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count)
 {
 	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
 	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 08f268dab8f5..fb5f7a0ee029 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -642,9 +642,9 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
 void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
-u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer);
-u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer, u32 count);
-void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count);
+u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
+u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, u32 count);
+void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
 
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index c210625be220..0f2647d099b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -251,7 +251,7 @@ struct amdgpu_rlc_funcs {
 	 * and it also provides a pointer to it which is used by the firmware
 	 * to load the clear state in some cases.
 	 */
-	void (*get_csb_buffer)(struct amdgpu_device *adev, volatile u32 *buffer);
+	void (*get_csb_buffer)(struct amdgpu_device *adev, u32 *buffer);
 	int  (*get_cp_table_num)(struct amdgpu_device *adev);
 	int  (*resume)(struct amdgpu_device *adev);
 	void (*stop)(struct amdgpu_device *adev);
@@ -281,7 +281,7 @@ struct amdgpu_rlc {
 	/* for clear state */
 	struct amdgpu_bo        *clear_state_obj;
 	uint64_t                clear_state_gpu_addr;
-	volatile uint32_t       *cs_ptr;
+	uint32_t		*cs_ptr;
 	const struct cs_section_def   *cs_data;
 	u32                     clear_state_size;
 	/* for cp tables */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 264183ab24ec..f6ac6a36bc44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4322,8 +4322,7 @@ static u32 gfx_v10_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v10_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
+static void gfx_v10_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
 {
 	u32 count = 0;
 	int ctx_reg_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3d9c045a8a64..ff600a6c80ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -850,8 +850,7 @@ static u32 gfx_v11_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v11_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
+static void gfx_v11_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
 {
 	u32 count = 0;
 	int ctx_reg_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 5dbc5dbc694a..a14fd94af90d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -685,8 +685,7 @@ static u32 gfx_v12_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v12_0_get_csb_buffer(struct amdgpu_device *adev,
-				     volatile u32 *buffer)
+static void gfx_v12_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
 {
 	u32 count = 0, clustercount = 0, i;
 	const struct cs_section_def *sect = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 70d7a1f434c4..7693b7953426 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -86,7 +86,7 @@ MODULE_FIRMWARE("amdgpu/hainan_ce.bin");
 MODULE_FIRMWARE("amdgpu/hainan_rlc.bin");
 
 static u32 gfx_v6_0_get_csb_size(struct amdgpu_device *adev);
-static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer);
+static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer);
 //static void gfx_v6_0_init_cp_pg_table(struct amdgpu_device *adev);
 static void gfx_v6_0_init_pg(struct amdgpu_device *adev);
 
@@ -2354,7 +2354,7 @@ static void gfx_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
 static int gfx_v6_0_rlc_init(struct amdgpu_device *adev)
 {
 	const u32 *src_ptr;
-	volatile u32 *dst_ptr;
+	u32 *dst_ptr;
 	u32 dws;
 	u64 reg_list_mc_addr;
 	const struct cs_section_def *cs_data;
@@ -2855,8 +2855,7 @@ static u32 gfx_v6_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
+static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
 {
 	u32 count = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2aa323dab34e..5976ed55d9db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -883,7 +883,7 @@ static const u32 kalindi_rlc_save_restore_register_list[] = {
 };
 
 static u32 gfx_v7_0_get_csb_size(struct amdgpu_device *adev);
-static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer);
+static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer);
 static void gfx_v7_0_init_pg(struct amdgpu_device *adev);
 static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev);
 
@@ -3882,8 +3882,7 @@ static u32 gfx_v7_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
+static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
 {
 	u32 count = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 367449d8061b..0856ff65288c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1220,8 +1220,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	return err;
 }
 
-static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
+static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
 {
 	u32 count = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a6ff9a137a83..dd19a97436db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1648,8 +1648,7 @@ static u32 gfx_v9_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v9_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
+static void gfx_v9_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
 {
 	u32 count = 0;
 
-- 
2.50.1

