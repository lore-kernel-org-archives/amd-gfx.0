Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE20C982DC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08BC10F307;
	Fri, 18 Sep 2026 12:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aYaFFil7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B0610F305
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=kR0QlM5dQ0lO37xJO3dTe//hFnbcuwchVl5Pa/EYBpk=; b=aYaFFil7KgYyL7vSPdC28lwdaM
 2VCvHFaM3HSU93sGPZePNttdQ4umckWw3VIS9pKtZgwlJfxVcsFAbAW8jgghOEZcNb2ohdU7gh3X9
 jF2Rehaao2L/yP3SEC9L1kTVmq1kQgdB5HcohN3hZEfmKZRcRXEg/scdiFpo5zgQjBNvOGywa+UMJ
 ZJdIxKCJ4WxhCM1Mnh6Gw//0xNFZfTjQS2DulNQDenCCVLw4NFNn1yYvqx5nQ+dZ6Id5vRsLGCTWU
 lgeAwwgGtIWnWdOQmjqeCjGRpehvyBcy21QfFqozW99OKIMmsFftV9wV4CTvgHK9DcyIRCMzewgAd
 Se3vxAjQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7XLP-003vNp-9F; Fri, 18 Sep 2026 14:05:31 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/18] drm/amdgpu: More compact GFX 9.4.2 IB emission
Date: Fri, 18 Sep 2026 13:05:08 +0100
Message-ID: <20260918120518.96922-9-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
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

Avoid constant register reloads while emitting IBs by using a local write
pointer and only updating the size at the end of each helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 51 +++++++++++++------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 344156bf20ca..3c33772591d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -377,6 +377,7 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	int r, i;
 	uint32_t total_size, shader_offset;
 	u64 gpu_addr;
+	u32 *ptr;
 
 	total_size = (regs_size * 3 + 4 + 5 + 5) * 4;
 	total_size = ALIGN(total_size, 256);
@@ -394,43 +395,43 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	ib = &job->ibs[0];
 
 	/* load the compute shaders */
-	for (i = 0; i < shader_size/sizeof(u32); i++)
-		ib->ptr[i + (shader_offset / 4)] = shader_ptr[i];
+	memcpy(&ib->ptr[shader_offset / sizeof(u32)], shader_ptr, shader_size);
 
-	/* init the ib length to 0 */
-	ib->length_dw = 0;
+	ptr = ib->ptr;
 
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < regs_size; i++) {
-		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(init_regs[i])
-								- PACKET3_SET_SH_REG_START;
-		ib->ptr[ib->length_dw++] = init_regs[i].reg_value;
+		*ptr++ = PACKET3(PACKET3_SET_SH_REG, 1);
+		*ptr++ = SOC15_REG_ENTRY_OFFSET(init_regs[i]) -
+			 PACKET3_SET_SH_REG_START;
+		*ptr++ = init_regs[i].reg_value;
 	}
 
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
 	gpu_addr = (ib->gpu_addr + (u64)shader_offset) >> 8;
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_PGM_LO)
-							- PACKET3_SET_SH_REG_START;
-	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
-	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
+	*ptr++ = PACKET3(PACKET3_SET_SH_REG, 2);
+	*ptr++ = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_PGM_LO)
+		 - PACKET3_SET_SH_REG_START;
+	*ptr++ = lower_32_bits(gpu_addr);
+	*ptr++ = upper_32_bits(gpu_addr);
 
 	/* write the wb buffer address */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 3);
-	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_USER_DATA_0)
-							- PACKET3_SET_SH_REG_START;
-	ib->ptr[ib->length_dw++] = lower_32_bits(wb_gpu_addr);
-	ib->ptr[ib->length_dw++] = upper_32_bits(wb_gpu_addr);
-	ib->ptr[ib->length_dw++] = pattern;
+	*ptr++ = PACKET3(PACKET3_SET_SH_REG, 3);
+	*ptr++ = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_USER_DATA_0) -
+		 PACKET3_SET_SH_REG_START;
+	*ptr++ = lower_32_bits(wb_gpu_addr);
+	*ptr++ = upper_32_bits(wb_gpu_addr);
+	*ptr++ = pattern;
 
 	/* write dispatch packet */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib->ptr[ib->length_dw++] = compute_dim_x; /* x */
-	ib->ptr[ib->length_dw++] = 1; /* y */
-	ib->ptr[ib->length_dw++] = 1; /* z */
-	ib->ptr[ib->length_dw++] =
-		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
+	*ptr++ = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	*ptr++ = compute_dim_x; /* x */
+	*ptr++ = 1; /* y */
+	*ptr++ = 1; /* z */
+	*ptr++ = REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN,
+			       1);
+
+	ib->length_dw = ptr - ib->ptr;
 
 	/* schedule the ib on the ring */
 	r = amdgpu_job_submit_direct(job, ring, fence_ptr);
-- 
2.55.0

