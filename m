Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D500BC5518F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6287010E6D9;
	Mon,  3 Aug 2026 13:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eInkss+R";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C0F10E6D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:22 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so398971666b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763401; x=1786368201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JtBh4VwBEeFtkj1ukOrc72j8kvbCmhFrvzFagMXBQ3w=;
 b=eInkss+RQfygi3sVqiVyJPsQkt3gRpXxg5AatfFQu5t5ce6R3eN1GbmiR+xA9dQpTY
 1VR9/31M3AmG8xeNcqgPVCKHECpO0/PZzhU0kniswFrEt2cNhrSJf9qLdD08NxuJAsUk
 KgjrAeeNHVAGLFm17WZ0C6mUcr1pkF3UdKxkaZhIggpSF8yKxvC2tRhJ034dzHaCmy8h
 h5qtGsN2mflSzOZWsgAF0KTcwU1E9nqxCA+a+ed4VkRsDxNxLbAi7YXZmw32YuVX7HFB
 8hYve1qlSPtLN6Pf5Z8DMcGvCzYl5Ax3Oqw7kRx/SAeP0FMAoprriudFLfKS5tkIjjOn
 320Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763401; x=1786368201;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JtBh4VwBEeFtkj1ukOrc72j8kvbCmhFrvzFagMXBQ3w=;
 b=B1GpviYUeRVRp8+rwfVl86EhmJtvDSK1qyYCmISGRA9L/jBe0/NO8xU9vCVy9OUR2W
 TU5e/9lgSjYITueXTB8XX+eEsVFlfIli71CSu5G6dAl9yFUs85SaBc/9P58zM+lJCGya
 LYS0cBDlLIyTJ+vh4QbLLpDVGHo+GanGw4yfBHBHSal1Ya7seH/6JAumkcyAMMzZhUI7
 SeC2iHMgrBkQgD32xWmviOsHx9knErVl7NNlu85iDf6/6qy5dCAi1FMXaxxeNkim8ROB
 LNWF2eTTeXFcL6TaHLHSDU1m69Vx03CTGwvzut0+Yd1mOKpbgBUNfcbk/AgXb7dLHkXi
 M+sg==
X-Gm-Message-State: AOJu0Yy1Mxk6xSHX+RI75faB+T4xfFSP8KyFYxjd8Kyvs/vcd733RacY
 ZWtEZS3eiX097bgcCd87+JW2/qk2UftxVmfoN/NsVrbATmBxAFCk3DTmdIR8rC/A
X-Gm-Gg: AR+sD11TqdncsSyZsMlxT29UoKp+t9Y7Uy5KzztouunU+ZGy/ii3qtp6JupSuafDS8G
 ANK+caPWRlCcOWPeCNV2I6i4368ylYlwVAOf0QytWVRP192XnaTi7nMx/VW/1DX3QBVZkvFRfzK
 2NDxAziSNkJRAZJDz01mnxqhyXexRQ3XTLeRxO3sSoIh3PgJ6S9pMnMfYEXtrdcQuC0X4+9oapi
 G6OuFuhMrjehgWq6jE8cYz7C/VtGHTopcsvqZddhWU2tRNBAoXQLfS+YC4AWkOFvbdfD72/vRX9
 99pjSw5vVmCBepJ2DLuZaMQy/XXRXDLNHSdwwu+rhYXj+4DcX2CFtxStIyEf/w6QsLuSZ4Rybhz
 pJrcgLYgbrYn+2xvylseOo7/koCDKUqY/HZY0XS+7mKPM605hB0Sdk0iMHLduEqhoLLflDOHtfJ
 R18eNvlC4JikZ1WDOeLynUL+9W0zeRFFYhr/OtVM8akK964dStXI51DvdjNZX3l/6SBxo78ggFS
 cN6Z/GDCIl85/Gm8rOhzM/iadEfFAM=
X-Received: by 2002:a17:907:bd91:b0:c16:9ca5:e551 with SMTP id
 a640c23a62f3a-c1fe7eec7bamr749665866b.14.1785763400547; 
 Mon, 03 Aug 2026 06:23:20 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/10] drm/amdgpu/gfx6: Use COND_EXEC
Date: Mon,  3 Aug 2026 15:23:07 +0200
Message-ID: <20260803132309.36326-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
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

COND_EXEC tells the CP to discard the dwords following it
when its condition is zero (false).

This is useful for GPU recovery because it can help reduce
collateral damage during GFX IP block soft reset, meaning
that it reduces the likelyhood that we fail some jobs which
are not guilty of the hang as the IP block soft reset
mechanism clears the condition before doing the reset.

Note that this packet is only 4 DW on GFX6 (as opposed
to GFX7 and newer where it's 5 DW).

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index a51403caa342..2fcd2d70c0ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2420,6 +2420,24 @@ static void gfx_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	}
 }
 
+static unsigned int gfx_v6_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						  uint64_t gpu_addr)
+{
+	unsigned int ret;
+
+	/*
+	 * Discard following DWs after this packet when gpu_addr==0
+	 * The packet is only 4 DW on GFX6 (as opposed to GFX7+).
+	 */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 2));
+	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
+	ret = ring->wptr & ring->buf_mask;
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
+	return ret;
+}
+
 static void gfx_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
 				    uint32_t reg, uint32_t val)
 {
@@ -3558,6 +3576,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.get_wptr = gfx_v6_0_ring_get_wptr,
 	.set_wptr = gfx_v6_0_ring_set_wptr_gfx,
 	.emit_frame_size =
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		5 + 5 + /* hdp flush / invalidate */
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
@@ -3575,6 +3595,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.emit_switch_buffer = gfx_v6_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v6_ring_emit_cntxcntl,
+	.init_cond_exec = gfx_v6_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v6_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v6_0_emit_mem_sync,
 };
@@ -3587,6 +3608,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 	.get_wptr = gfx_v6_0_ring_get_wptr,
 	.set_wptr = gfx_v6_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		4 + /* gfx_v6_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		5 + 5 + /* hdp flush / invalidate */
 		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* gfx_v6_0_ring_emit_vm_flush */
@@ -3602,6 +3625,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 	.test_ib = gfx_v6_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.emit_switch_buffer = gfx_v6_0_ring_emit_sb,
+	.init_cond_exec = gfx_v6_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v6_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v6_0_emit_mem_sync,
 };
-- 
2.55.0

