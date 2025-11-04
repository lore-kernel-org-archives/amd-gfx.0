Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51076CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E193F10E5E9;
	Tue,  4 Nov 2025 14:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ieCjGZGt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9510C10E5F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LXPvlPqgI6ttbrg+INAMePjb/FpODronJXY+rGQAHF8=; b=ieCjGZGtGDpbVgk/LZkAGLqO/R
 23pgJteu5Y2ryQ1Iwa8NRunhuA7jNX+CkSwz82wHKit1itquRfSu9e2M9q8rbmSY2nPivZ/dH/g6W
 DbMr3Z518j+Ou+0SAh0GAGMnUabEYtcavtAVnmF5Y3aybnkxtB7wSAEwcCXFNj2nNqZNbh80uk+wG
 repc0FjOhokctju21YncIgcKA3Ai9MKJAYoqz1XeVQWYPIs0s5RZd2oIXJGLaWvIGOF1HaB9aNcTC
 XphFiTCARdDTfBnoh8AZbLlQMk2biC2YJdHztKLDT43EmLUZ8SUuWNFsaf0lzRMEjkJVizAVy7oXu
 d+FYaffg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHg8-001OEV-Ry; Tue, 04 Nov 2025 15:06:32 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 04/25] drm/amdgpu: Only calculate register offset once in SOC15
 RLC
Date: Tue,  4 Nov 2025 14:04:00 +0000
Message-ID: <20251104140421.88520-5-tvrtko.ursulin@igalia.com>
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

We can save some text by only calculating the register offset once
in a few of the SOC15 RLC register read/write macros.

add/remove: 0/0 grow/shrink: 2/65 up/down: 32/-1078 (-1046)
Total: Before=9079703, After=9078657, chg -0.01%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 47 +++++++++++++----------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index b7f928521f39..5ee5867fe794 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -43,21 +43,25 @@
 #define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
 	adev->gfx.rlc.reg_funcs->rreg32(adev, reg, flag, hwip, inst)
 
-#define WREG32_FIELD15(ip, idx, reg, field, val)	\
-	 __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
-				(__RREG32_SOC15_RLC__( \
-					adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
-					0, ip##_HWIP, idx) & \
-				~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
-			      0, ip##_HWIP, idx)
+#define WREG32_FIELD15(ip, idx, reg_name, field, val) \
+do { \
+	u32 reg__ = adev->reg_offset[ip##_HWIP][idx][mm##reg_name##_BASE_IDX] + mm##reg_name; \
+	u32 val__ = __RREG32_SOC15_RLC__(reg__, 0, ip##_HWIP, idx); \
+\
+	val__ &= ~REG_FIELD_MASK(reg_name, field); \
+	val__ |= (val) << REG_FIELD_SHIFT(reg_name, field); \
+	__WREG32_SOC15_RLC__(reg__, val__, 0, ip##_HWIP, idx); \
+} while (0)
 
-#define WREG32_FIELD15_PREREG(ip, idx, reg_name, field, val)        \
-	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name,   \
-			(__RREG32_SOC15_RLC__( \
-					adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name, \
-					0, ip##_HWIP, idx) & \
-					~REG_FIELD_MASK(reg_name, field)) | (val) << REG_FIELD_SHIFT(reg_name, field), \
-			0, ip##_HWIP, idx)
+#define WREG32_FIELD15_PREREG(ip, idx, reg_name, field, val) \
+do { \
+	u32 reg__ = adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name; \
+	u32 val__ = __RREG32_SOC15_RLC__(reg__, 0, ip##_HWIP, idx); \
+\
+	val__ &= ~REG_FIELD_MASK(reg_name, field); \
+	val__ |= (val) << REG_FIELD_SHIFT(reg_name, field); \
+	__WREG32_SOC15_RLC__(reg__, val__, 0, ip##_HWIP, idx); \
+} while (0)
 
 #define RREG32_SOC15(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
@@ -177,12 +181,15 @@
 			WREG32_RLC_EX(prefix, target_reg, value, inst); \
 	} while (0)
 
-#define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
-	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
-			     (__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
-						   AMDGPU_REGS_RLC, ip##_HWIP, idx) & \
-			      ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
-			     AMDGPU_REGS_RLC, ip##_HWIP, idx)
+#define WREG32_FIELD15_RLC(ip, idx, reg_name, field, val) \
+do { \
+	u32 reg__ = adev->reg_offset[ip##_HWIP][idx][mm##reg_name##_BASE_IDX] + mm##reg_name; \
+	u32 val__ = __RREG32_SOC15_RLC__(reg__, AMDGPU_REGS_RLC, ip##_HWIP, idx); \
+\
+	val__ &= ~REG_FIELD_MASK(reg_name, field); \
+	val__ |= (val) << REG_FIELD_SHIFT(reg_name, field); \
+	__WREG32_SOC15_RLC__(reg__, val__, AMDGPU_REGS_RLC, ip##_HWIP, idx); \
+} while (0)
 
 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
 	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP, inst)
-- 
2.48.0

