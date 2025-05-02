Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEDAC3ABB0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7377510E944;
	Fri,  2 May 2025 16:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jc/vHv1H";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D9310E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:17:24 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so349959566b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746202643; x=1746807443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vipgPco85339tvtGSj2sz3XBd1vrUIpd0G3hX9mKi6o=;
 b=Jc/vHv1HYwcSkmzGs/+IYfGijxlwksJ97TWJNlSzcjJSSRwv4g6V0OcKr3+N+Rx4Tj
 IbnBs3Pls1U2/1nqqpRyO8iVRIi8lcTAyntJWemYD2k26Wh9chLLhEumkDWztRPvzNmh
 HFiq491Mxu5Mz5DObH/SK2CcAyGq8oYY9X9IxqcdIaZwDWOhlRc/J9sMMREUls6lUkxN
 jJ4izPJNS4+285k4Ll8PH8V9qHHbip37eij+TPIiPJYN17XgWZuyjpalrT77+l9v4ZlG
 KoEXInc4jE2mwCO1aQiO6BNNtSs4IP32K1tXqBZrWMqjkANF58M18Qb6HZXm5T1K/U1b
 aH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202643; x=1746807443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vipgPco85339tvtGSj2sz3XBd1vrUIpd0G3hX9mKi6o=;
 b=rLTsPzRik5/74poQaHi4dEzlkn70dRWd53s0vNtsjiXHTfq8hOunWyGx6PT6Ywcgta
 /iktwhJZI6WhpqowTsWKkuKDejmKha5/vaprpZQsVNDGl5hhjdwRgHE8WLJE6AevUUke
 Xb5t9xsDnWSCbYK1Att0kWVWdr1Q67/ra4HR82FrbQhkx/t+A6sSo5P3AAi9xffuUgMX
 T6H79wZBma+UsK2r9nI8KriKgqyoUlFl2Rvs5DKjN9BW10jzt1srjvNOutRZcIASXaMc
 CXGGn360ycDVnPzQ7UzAO0YDL6NvPQ2RWNbeffKkfkwZClgPRj7kmb6uTIPouY9xr6KZ
 IaPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxhMZYZTi52n8v5VhiVSdx5FS48fW7ZnyIJCA2rIhH3JgzUHJcKPnqLw6gU50w8wREQtYEgEUK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAh+lpHocS3WKMyAYm1QYBHNjJN50BEQzh1wKa189y/5mOvT/6
 /HGGP2L85KK0os1IxfUNstRMPHJI0FLm1kOXAUvE5kXbEVcRh8GdtPnQM+MgZCs=
X-Gm-Gg: ASbGncvLnErDLutqItTVEjVoXBwHLn47gOtgdJ7atyHF3F8un/C+NEKQolRE581HS6V
 +GW8HrLvnd4XDgh/QWisDbKcT9OW4hdyOFrXOaU0c/JBKLR+q3Z2yorYogOHaQ+ibsh3ozYp/So
 hMrjrszS3Et6ZuwR4WzI86oqys2rLfQ7r1oOphFBBLTDGHOg2wpxtKU7AeMM2iOXWMUngUZ5WSu
 QnqE3zNHY5py8a8z6cwGr2Bsb5XHY2sutoWkZRM5XeDfaT6XkHOW8xyK99++jp1ILo4FITPiF0Y
 Ua86Xo09cLWZUx3ttsO+HByJvp3K8Vn1EcCz1lxeE49Ln/2in2AECUjZRUfDe4Si
X-Google-Smtp-Source: AGHT+IFufSzzSN6g4p/G1ANqAgrsnCZPjzNTXOJUKx8x9LPCBAOpK/YGEYGkla24rhVF4aWtQxbWLQ==
X-Received: by 2002:a17:907:3e0d:b0:ace:9d3d:2ad5 with SMTP id
 a640c23a62f3a-ad17adaebb2mr353575866b.32.1746202642446; 
 Fri, 02 May 2025 09:17:22 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b1:4a00:5585:4c76:3645:c6fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189509088sm68748766b.146.2025.05.02.09.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:17:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: rework gfx9 queue reset
Date: Fri,  2 May 2025 18:17:17 +0200
Message-Id: <20250502161720.1704-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502161720.1704-1-christian.koenig@amd.com>
References: <20250502161720.1704-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Testing this feature turned out that it was a bit unstable. The
CP_VMID_RESET register takes the VMID which all submissions from should
be canceled.

Unlike Windows Linux uses per process VMIDs instead of per engine VMIDs
for the simple reason that we don't have enough. So resetting one VMID
only killed the submissions of one specific process.

Fortunately that turned out to be exactly what we want to have.

So clear the CP_VMID_RESET register between every context switch between
applications when we do the pipeline sync to avoid trouble if multiple
VMIDs are used on the ring right behind each other.

Use the same pipeline sync function in the reset handler and issue an IB
test instead of a ring test after the queue reset to provide a longer
timeout and additional fence value should there be additional work on
the ring after the one aborted.

Also drop the soft recovery since that pretty much does the same thing as
CP_VMID_RESET, just on a lower level and with less chance of succeeding.

This now survives a stress test running over night sending a broken
submission ever 45 seconds and recovering fine from each of them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 ++++++++++-----------------
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843..c39fe784419b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
 #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
+#define AMDGPU_QUEUE_RESET_TIMEOUT		(HZ / 10)
 #define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e..92d9a28c62d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5565,7 +5565,17 @@ static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
+	struct amdgpu_device *adev = ring->adev;
 
+	amdgpu_ring_emit_reg_wait(ring,
+				  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+				  0, 0xffff);
+	amdgpu_ring_emit_wreg(ring,
+			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+			      0);
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq,
+			       AMDGPU_FENCE_FLAG_EXEC);
 	gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
 			      lower_32_bits(addr), upper_32_bits(addr),
 			      seq, 0xffffffff, 4);
@@ -5896,20 +5906,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 						 enum amdgpu_interrupt_state state)
 {
@@ -7185,16 +7181,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
 		return -ENOMEM;
-	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v9_0_ring_emit_reg_wait(ring,
-				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
-	gfx_v9_0_ring_emit_wreg(ring,
-				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
+	gfx_v9_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
@@ -7437,7 +7429,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7475,7 +7467,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.reset = gfx_v9_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
@@ -7494,7 +7485,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7533,7 +7524,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.patch_cntl = gfx_v9_0_ring_patch_cntl,
 	.patch_de = gfx_v9_0_ring_patch_de_meta,
@@ -7555,7 +7545,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
@@ -7577,7 +7567,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
@@ -7598,7 +7587,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
-- 
2.34.1

