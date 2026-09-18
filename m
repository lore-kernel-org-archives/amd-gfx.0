Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48D8C982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F28C210F30D;
	Fri, 18 Sep 2026 12:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jO5PTWSg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC2F10F305
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=NzkModRJiifnSIrKDntVWz6cqDILh4V3pZOsHYgKxmI=; b=jO5PTWSgxySp0skq6VSujEec5a
 yQ/7FwI0yQkbto6vNpA7503HczBfib6oHCHrpJXPVC29Z/LpmayLNYRLczwji5wIWBn3SEGjMEF2a
 aSJgQAh751cSZlPMLzKXoceR/DVm37eV3iMCjRGYdKn4lYJdURMwMFBIBTZgS/DL7pC0RLy5/uObt
 /Zl9SWNdWyQ80dVxE7oeiCds+NI2pkgarLaM+t29UHYayM38cFsIEG9iPyz7tQZemGVlStELkve/5
 Hjl/d4y5SqEwHfWzQxom7mChzjoYBh1VTxgFrMkdvKd50XpfAzVhVBrI686JJVa2naTHzBnkiRf9W
 klvbsouQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7XLQ-003vO4-0t; Fri, 18 Sep 2026 14:05:31 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/18] drm/amdgpu: More compact GFX9 IB emission
Date: Fri, 18 Sep 2026 13:05:09 +0100
Message-ID: <20260918120518.96922-10-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 115 +++++++++++++-------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3ba2584e48c6..60f410ab1afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4703,6 +4703,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	int vgpr_init_shader_size;
 	const u32 *vgpr_init_shader_ptr;
 	const struct soc15_reg_entry *vgpr_init_regs_ptr;
+	u32 *ptr;
 
 	/* only support when RAS is enabled */
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
@@ -4746,98 +4747,98 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	ib = &job->ibs[0];
 
 	/* load the compute shaders */
-	for (i = 0; i < vgpr_init_shader_size/sizeof(u32); i++)
-		ib->ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
+	memcpy(&ib->ptr[vgpr_offset / sizeof(u32)], vgpr_init_shader_ptr,
+	       vgpr_init_shader_size);
+	memcpy(&ib->ptr[sgpr_offset / sizeof(u32)], sgpr_init_compute_shader,
+	       sizeof(sgpr_init_compute_shader));
 
-	for (i = 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
-		ib->ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
-
-	/* init the ib length to 0 */
-	ib->length_dw = 0;
+	ptr = ib->ptr;
 
 	/* VGPR */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
-								- PACKET3_SET_SH_REG_START;
-		ib->ptr[ib->length_dw++] = vgpr_init_regs_ptr[i].reg_value;
+		*ptr++ = PACKET3(PACKET3_SET_SH_REG, 1);
+		*ptr++ = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i]) -
+			 PACKET3_SET_SH_REG_START;
+		*ptr++ = vgpr_init_regs_ptr[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
 	gpu_addr = (ib->gpu_addr + (u64)vgpr_offset) >> 8;
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
-							- PACKET3_SET_SH_REG_START;
-	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
-	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
+	*ptr++ = PACKET3(PACKET3_SET_SH_REG, 2);
+	*ptr++ = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO) -
+		 PACKET3_SET_SH_REG_START;
+	*ptr++ = lower_32_bits(gpu_addr);
+	*ptr++ = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib->ptr[ib->length_dw++] = compute_dim_x * 2; /* x */
-	ib->ptr[ib->length_dw++] = 1; /* y */
-	ib->ptr[ib->length_dw++] = 1; /* z */
-	ib->ptr[ib->length_dw++] =
-		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
+	*ptr++ = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	*ptr++ = compute_dim_x * 2; /* x */
+	*ptr++ = 1; /* y */
+	*ptr++ = 1; /* z */
+	*ptr++ = REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN,
+			       1);
 
 	/* write CS partial flush packet */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	*ptr++ = PACKET3(PACKET3_EVENT_WRITE, 0);
+	*ptr++ = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR1 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i])
-								- PACKET3_SET_SH_REG_START;
-		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i].reg_value;
+		*ptr++ = PACKET3(PACKET3_SET_SH_REG, 1);
+		*ptr++ = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i]) -
+			 PACKET3_SET_SH_REG_START;
+		*ptr++ = sgpr1_init_regs[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
 	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
-							- PACKET3_SET_SH_REG_START;
-	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
-	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
+	*ptr++ = PACKET3(PACKET3_SET_SH_REG, 2);
+	*ptr++ = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO) -
+		 PACKET3_SET_SH_REG_START;
+	*ptr++ = lower_32_bits(gpu_addr);
+	*ptr++ = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
-	ib->ptr[ib->length_dw++] = 1; /* y */
-	ib->ptr[ib->length_dw++] = 1; /* z */
-	ib->ptr[ib->length_dw++] =
-		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
+	*ptr++ = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	*ptr++ = compute_dim_x / 2 * sgpr_work_group_size; /* x */
+	*ptr++ = 1; /* y */
+	*ptr++ = 1; /* z */
+	*ptr++ = REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN,
+			       1);
 
 	/* write CS partial flush packet */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	*ptr++ = PACKET3(PACKET3_EVENT_WRITE, 0);
+	*ptr++ = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR2 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i])
-								- PACKET3_SET_SH_REG_START;
-		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i].reg_value;
+		*ptr++ = PACKET3(PACKET3_SET_SH_REG, 1);
+		*ptr++ = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i]) -
+			 PACKET3_SET_SH_REG_START;
+		*ptr++ = sgpr2_init_regs[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
 	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
+	*ptr++ = PACKET3(PACKET3_SET_SH_REG, 2);
+	*ptr++ = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
-	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
+	*ptr++ = lower_32_bits(gpu_addr);
+	*ptr++ = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
-	ib->ptr[ib->length_dw++] = 1; /* y */
-	ib->ptr[ib->length_dw++] = 1; /* z */
-	ib->ptr[ib->length_dw++] =
-		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
+	*ptr++ = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	*ptr++ = compute_dim_x / 2 * sgpr_work_group_size; /* x */
+	*ptr++ = 1; /* y */
+	*ptr++ = 1; /* z */
+	*ptr++ = REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN,
+			       1);
 
 	/* write CS partial flush packet */
-	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	*ptr++ = PACKET3(PACKET3_EVENT_WRITE, 0);
+	*ptr++ = EVENT_TYPE(7) | EVENT_INDEX(4);
+
+	ib->length_dw = ptr - ib->ptr;
 
 	/* schedule the ib on the ring */
 	r = amdgpu_job_submit_direct(job, ring, &f);
-- 
2.55.0

