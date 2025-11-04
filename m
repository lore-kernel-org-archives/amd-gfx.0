Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C6DCCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7055110E5FC;
	Tue,  4 Nov 2025 14:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YfqCffSS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A82C10E604
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lL7iEPVly/e9dk+e7HQO3x8zGUuN38O+soaJP6F8pik=; b=YfqCffSSJNl5gp5ymRvSUuBaqM
 IuGxV+NR9DIOv9SZZ/F9nQF0P+P/hULQL3nccTMir/SCGGqtlPLv3EZes42xrQUwYxm76Igdsr54X
 g022bvHBfyJYCiK8z1lWp3JBjXrWV5E3gdCt5MQBG1QTaKWiyy5Olm/V1wfsEMQUT3NBx5t06llgJ
 JoAlr21aQWacQPxNCH9pWlyjpatN6Esue7GA0QN6+/sO/gj4Ea3XvnvjYdFeEk6ZTwHmm02xABoCB
 70rozV1/OUOKuMHwx1ngocNmwQ48SxMkefDBB6RI6Dj7Iwl78uHLbW0Q4Zce1G4MxdNYEz96jY4T1
 nA04jXuA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgI-001OH6-LA; Tue, 04 Nov 2025 15:06:42 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 17/25] drm/amdgpu: More compact GFX 9.4.2 IB emission
Date: Tue,  4 Nov 2025 14:04:13 +0000
Message-ID: <20251104140421.88520-18-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
References: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
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

Avoid constant register reloads while emitting IBs by using a local write
pointer and only updating the size at the end of each helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 51 +++++++++++++------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8058ea91ecaf..884c091f40ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -354,6 +354,7 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	int r, i;
 	uint32_t total_size, shader_offset;
 	u64 gpu_addr;
+	u32 *ptr;
 
 	total_size = (regs_size * 3 + 4 + 5 + 5) * 4;
 	total_size = ALIGN(total_size, 256);
@@ -370,43 +371,43 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	}
 
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
 
 	/* shedule the ib on the ring */
 	r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
-- 
2.48.0

