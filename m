Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30ECCAC58D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 11:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA2A10EACB;
	Thu, 11 Sep 2025 11:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TUW9R0WG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CB710EACB
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=69ea89IoULdWLTIf9maMrWZvV+iO8c1+3flljZXC0Lw=; b=TUW9R0WG8X2ARiib0GDdaRokSS
 BJvKVldhJCxF1mSGhNIH/IMUFr5XWihWVcWD8+9iZqWQaf8En0EcSXlJseJb1rNmnpCDtFpVoXCZ6
 +Z+D+zOgXWUa2CS9xZAXflOl+87YfEO79AaaTLsnHJ6PARbn04XMtESANpvEccDMCGycHipIw+FCk
 Kdu5F5ofMATqgVxt++fdfgFavFqN27eua8o/lxv9EzLNKdHRIeVnxdk/EmnYoSVnBVKBhhBmG8naa
 5JcaOyduNvqIwPzDvQYmxMVI3q6Jfy3I1FoGtbq7+sYC9TSRReL8nUUMPQvCKpRibg5ZIxmBrg3lr
 DKaYY85A==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwfh2-009n3c-FG; Thu, 11 Sep 2025 13:42:25 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 08/16] drm/amdgpu: More compact GFX 9.4.2 IB emission
Date: Thu, 11 Sep 2025 12:41:47 +0100
Message-ID: <20250911114155.24786-9-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
References: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 46 +++++++++++++------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8058ea91ecaf..830887964645 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -354,6 +354,7 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	int r, i;
 	uint32_t total_size, shader_offset;
 	u64 gpu_addr;
+	u32 *ptr;
 
 	total_size = (regs_size * 3 + 4 + 5 + 5) * 4;
 	total_size = ALIGN(total_size, 256);
@@ -373,40 +374,41 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	for (i = 0; i < shader_size/sizeof(u32); i++)
 		ib->ptr[i + (shader_offset / 4)] = shader_ptr[i];
 
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
+	*ptr++ = PACKET3(PACKET3_SET_SH_REG, 2);
+	*ptr++ = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
-	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
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

