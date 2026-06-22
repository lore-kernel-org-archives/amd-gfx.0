Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC1CCD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 12:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAB110E677;
	Mon, 22 Jun 2026 12:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EDM0ZgHh";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4613510E67C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X6hJqId12D8j04FmgX1a0gemg7Zsx4matxHzxktFPsA=; b=EDM0ZgHh7J5PE9hV87s9/0YxiT
 p9nSyh6MpvhAgyup2e9gINbhZcp+sStCK5wb90Q7d1z9ajGz50YfALEA+zv8/Rg0JLMFgjoZ1grfj
 BKnlIlbx6IdsdG5dLhowUBEx73tx/X/k9UbPBH7l/bFr9gF6AMjg9M4Lwhn7/GhU5V80ybSrvIoFR
 ol/DlNZeRfD4qsK/4GTTUiEvnCWJN9Cr/ZIzXREwu06QoWt0HPXQvuSca96eBwdsKveMkQKRsaji5
 oYHZpEc+eJj6TMs8hYACGLr8LACguySyd2zD2+XJstctku77UiK432ZLkw0rhG3gCcKOCa5OSeSGG
 F5MFfzCA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbdUe-003j5t-0Z; Mon, 22 Jun 2026 14:11:12 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH] drm/amdgpu: More compact reading of wave data
Date: Mon, 22 Jun 2026 13:11:09 +0100
Message-ID: <20260622121109.52781-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

Trivial compaction of some repetitive code:

add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-2326 (-2326)
Function                                     old     new   delta
gfx_v11_0_read_wave_data                     548     345    -203
gfx_v9_0_read_wave_data                      583     379    -204
gfx_v10_0_read_wave_data                     580     364    -216
gfx_v8_0_read_wave_data                     1098     843    -255
gfx_v7_0_read_wave_data                     1098     843    -255
gfx_v6_0_read_wave_data                     1098     843    -255
gfx_v12_0_read_wave_data                     804     497    -307
gfx_v12_1_read_wave_data                     880     572    -308
gfx_v9_4_3_read_wave_data                    760     437    -323
Total: Before=9992345, After=9990019, chg -0.02%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 38 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 36 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 52 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 44 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 44 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 44 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 36 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 36 +++++++++--------
 9 files changed, 209 insertions(+), 173 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 76d4c33a6e65..272968b82dee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4497,6 +4497,8 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t wave,
 
 static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* in gfx10 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
 	 * zero here
@@ -4504,23 +4506,25 @@ static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id
 	WARN_ON(simd != 0);
 
 	/* type 2 wave data */
-	dst[(*no_fields)++] = 2;
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+	*dst++ = 2;
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_INST_DW0);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6346f16c4e61..849724dca980 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1006,28 +1006,32 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t wave,
 
 static void gfx_v11_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* in gfx11 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
 	 * zero here */
 	WARN_ON(simd != 0);
 
 	/* type 3 wave data */
-	dst[(*no_fields)++] = 3;
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+	*dst++ = 3;
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v11_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f8280cc81a66..f646b93da2c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -846,36 +846,40 @@ static void gfx_v12_0_read_wave_data(struct amdgpu_device *adev,
 				     uint32_t simd, uint32_t wave,
 				     uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* in gfx12 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
 	 * zero here */
 	WARN_ON(simd != 0);
 
 	/* type 4 wave data */
-	dst[(*no_fields)++] = 4;
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATE_PRIV);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_PRIV);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_USER);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_TRAP_CTRL);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_ACTIVE);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_VALID_AND_IDLE);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_SCHED_MODE);
+	*dst++ = 4;
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_STATE_PRIV);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_PRIV);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_USER);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_TRAP_CTRL);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_ACTIVE);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_VALID_AND_IDLE);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_SCHED_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v12_0_read_wave_sgprs(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 30a38190f98a..af5a20475182 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -657,36 +657,40 @@ static void gfx_v12_1_read_wave_data(struct amdgpu_device *adev,
 				     uint32_t simd, uint32_t wave,
 				     uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* in gfx12 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
 	 * zero here */
 	WARN_ON(simd != 0);
 
 	/* type 4 wave data */
-	dst[(*no_fields)++] = 4;
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_HW_ID1);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_HW_ID2);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_IB_STS2);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_IB_DBG1);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_MODE);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_STATE_PRIV);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXCP_FLAG_PRIV);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXCP_FLAG_USER);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_TRAP_CTRL);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_ACTIVE);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_VALID_AND_IDLE);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_DVGPR_ALLOC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_DVGPR_ALLOC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_SCHED_MODE);
+	*dst++ = 4;
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_HW_ID1);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_HW_ID2);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_IB_STS2);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_IB_DBG1);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_MODE);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_STATE_PRIV);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXCP_FLAG_PRIV);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_EXCP_FLAG_USER);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_TRAP_CTRL);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_ACTIVE);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_VALID_AND_IDLE);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_DVGPR_ALLOC_LO);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_DVGPR_ALLOC_HI);
+	*dst++ = wave_read_ind(adev, xcc_id, wave, ixSQ_WAVE_SCHED_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v12_1_read_wave_sgprs(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ac90d8e9d86a..01ec83896a25 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3033,27 +3033,31 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 
 static void gfx_v6_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* type 0 wave data */
-	dst[(*no_fields)++] = 0;
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+	*dst++ = 0;
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f0..e30bec91b3a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4034,27 +4034,31 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 
 static void gfx_v7_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* type 0 wave data */
-	dst[(*no_fields)++] = 0;
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+	*dst++ = 0;
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 130196859ff3..f92c9c696d78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5183,27 +5183,31 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 
 static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* type 0 wave data */
-	dst[(*no_fields)++] = 0;
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+	*dst++ = 0;
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TBA_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f836621c46eb..95c93131ebe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1954,23 +1954,27 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 
 static void gfx_v9_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* type 1 wave data */
-	dst[(*no_fields)++] = 1;
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+	*dst++ = 1;
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_HW_ID);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 71a2558acef8..16d9a4b1f091 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -742,23 +742,27 @@ static void gfx_v9_4_3_read_wave_data(struct amdgpu_device *adev,
 				      uint32_t xcc_id, uint32_t simd, uint32_t wave,
 				      uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* type 1 wave data */
-	dst[(*no_fields)++] = 1;
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_HW_ID);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW1);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_IB_DBG0);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_MODE);
+	*dst++ = 1;
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_HW_ID);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW0);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_INST_DW1);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_IB_DBG0);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, xcc_id, simd, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v9_4_3_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
-- 
2.54.0

