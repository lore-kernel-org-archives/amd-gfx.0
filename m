Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1454ACCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CC810E4C5;
	Mon,  3 Nov 2025 22:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DVYzN7lm";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2F810E4C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:13 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-640bd9039fbso2571552a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208651; x=1762813451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6428wiNB3XLXNIBO0dba1O6z2SpFs3rqHaYtuo9LNko=;
 b=DVYzN7lmgWTy0l4q0QUokKVHu34aRhBgHNyYuqlnFLxR0KP9mlSk3PNAI0qSzNw2IG
 f75LOdKbje7vNz0Qa8Z5zo9AEnt16gzx94KTTIaRB9Y+mgOSn7C3beOmzergKrj/RoN/
 PMQ4JKDsyv2v7zjztya76B6plDTSBhVpCH2+BYIJ8Iy84cXWKlhui7AwpZTWCzuCJk/F
 Ryv1wWb6/aXwfuu9KsS3iJx8qHK0mkdIzgMTUMHe/oreXgSdT14LHrZNLfltQhOOKmOF
 JeM120mpUqpeMGQdQlWOrhH3WZk/H+WADnabw44pIUeVJXKPf2wZCiyBuY+sDWfs3pz/
 02mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208651; x=1762813451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6428wiNB3XLXNIBO0dba1O6z2SpFs3rqHaYtuo9LNko=;
 b=MPRLMkflwf/jMjwslSfDClGYsqfHpl234r3NkDQ9/1qXJEYy0LtFgP7ozEXF+IMcB+
 ccmY6SeZRLPcCMiCfzoHAwy6fyBDjYCRBsuKetd22uaGym0SA8/Umb0O2wHNU8axNWym
 H9Uw3F6h7CQLw7NsN+cJA6gyjC9V/OzKQf5lpU+D2buPT00w4XvZxdbM9TEfCcRSGX6D
 mFkQyP+pQNn6q1qdYMN0kEri5IaN7ec+kqC8Qt2Sm5eBmfDqJar78qEyFoBlU4NV0H8q
 WB+EVQytp5HiV/n9/F7si3rH8cBJZtmrgZTAHKcWvxqxX46qGIzZlV7M0orw46gs6YAm
 BIVA==
X-Gm-Message-State: AOJu0Yxh8dDhEHiw30ClnUHAgpgeSEy1U+U+k96LgBls5JZmJUJ2xe/J
 qup3Mwwz09w/nzcIzXm2+gmS2QX6XTEB4RTvJi6VG0tiOoktnqcNaNtXAj8Yyovl
X-Gm-Gg: ASbGnctyIS2rlkZw5uJXPjM4nHc3d3SXCGh2sWuFdafCURGKbAUMnTBKr2mH8aUB9wy
 1VIgd6tvQ8flcVBxwSSqOYhMr2BL0qCA+eYeRTphjG+s9TnpB7paFpdNq4XJMhitdF4khN/NVn2
 dTPUAGJS5nOpMNI9jU0CKj4UMSsmNuOIDG0BJwDBWtj8CIBa1SrFPNJKYKhSGg08a93Ys6bXNG8
 iTcBuvCXEPnbyPFC8pVIuyT3SSSkBStSRYLEcwVHHVGnjrJGVkWXFYs9y1hYtRl15LdmnPtzNVS
 KL/HQED0cyMRQjN5bJXTIpTGvWyaJjJCQH3p/n0ILz7DQRJ08InmAJ9obSnFQNfJtCHDYM+kQvl
 zqQCyATxNe7XoPEhkQ9+x+6GXkhV+MpC+JeZfUUk6ECtR6W12zLrcCutn9hgs2Rsj9vqJWO6bNl
 t5ffdSUT4kBCRZQhYzIOyyctAjc4BbcA==
X-Google-Smtp-Source: AGHT+IHyd+1kK5FzVcrQg1RMCsw1PWd+cl/XPCcuSVqGpFe6ll/+7+YNCepeU9f+EqcE/fHYhq1iKQ==
X-Received: by 2002:a05:6402:42d2:b0:63e:6d38:865 with SMTP id
 4fb4d7f45d1cf-64077044ef9mr10667212a12.36.1762208651504; 
 Mon, 03 Nov 2025 14:24:11 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:10 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 10/16] drm/amdgpu/vce1: Clean up register definitions
Date: Mon,  3 Nov 2025 23:23:27 +0100
Message-ID: <20251103222333.37817-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

The sid.h header contained some VCE1 register definitions, but
they were using byte offsets (probably copied from the old radeon
driver). Move all of these to the proper VCE1 headers and ensure
they are in dword offsets.

Also add the register definitions that we need for the
firmware validation mechanism in VCE1.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sid.h              | 40 -------------------
 .../drm/amd/include/asic_reg/vce/vce_1_0_d.h  |  5 +++
 .../include/asic_reg/vce/vce_1_0_sh_mask.h    | 10 +++++
 3 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index cbd4f8951cfa..561462a8332e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -582,45 +582,6 @@
 #define	DMA_PACKET_NOP					  0xf
 
 /* VCE */
-#define VCE_STATUS					0x20004
-#define VCE_VCPU_CNTL					0x20014
-#define		VCE_CLK_EN				(1 << 0)
-#define VCE_VCPU_CACHE_OFFSET0				0x20024
-#define VCE_VCPU_CACHE_SIZE0				0x20028
-#define VCE_VCPU_CACHE_OFFSET1				0x2002c
-#define VCE_VCPU_CACHE_SIZE1				0x20030
-#define VCE_VCPU_CACHE_OFFSET2				0x20034
-#define VCE_VCPU_CACHE_SIZE2				0x20038
-#define VCE_SOFT_RESET					0x20120
-#define 	VCE_ECPU_SOFT_RESET			(1 << 0)
-#define 	VCE_FME_SOFT_RESET			(1 << 2)
-#define VCE_RB_BASE_LO2					0x2016c
-#define VCE_RB_BASE_HI2					0x20170
-#define VCE_RB_SIZE2					0x20174
-#define VCE_RB_RPTR2					0x20178
-#define VCE_RB_WPTR2					0x2017c
-#define VCE_RB_BASE_LO					0x20180
-#define VCE_RB_BASE_HI					0x20184
-#define VCE_RB_SIZE					0x20188
-#define VCE_RB_RPTR					0x2018c
-#define VCE_RB_WPTR					0x20190
-#define VCE_CLOCK_GATING_A				0x202f8
-#define VCE_CLOCK_GATING_B				0x202fc
-#define VCE_UENC_CLOCK_GATING				0x205bc
-#define VCE_UENC_REG_CLOCK_GATING			0x205c0
-#define VCE_FW_REG_STATUS				0x20e10
-#	define VCE_FW_REG_STATUS_BUSY			(1 << 0)
-#	define VCE_FW_REG_STATUS_PASS			(1 << 3)
-#	define VCE_FW_REG_STATUS_DONE			(1 << 11)
-#define VCE_LMI_FW_START_KEYSEL				0x20e18
-#define VCE_LMI_FW_PERIODIC_CTRL			0x20e20
-#define VCE_LMI_CTRL2					0x20e74
-#define VCE_LMI_CTRL					0x20e98
-#define VCE_LMI_VM_CTRL					0x20ea0
-#define VCE_LMI_SWAP_CNTL				0x20eb4
-#define VCE_LMI_SWAP_CNTL1				0x20eb8
-#define VCE_LMI_CACHE_CTRL				0x20ef4
-
 #define VCE_CMD_NO_OP					0x00000000
 #define VCE_CMD_END					0x00000001
 #define VCE_CMD_IB					0x00000002
@@ -629,7 +590,6 @@
 #define VCE_CMD_IB_AUTO					0x00000005
 #define VCE_CMD_SEMAPHORE				0x00000006
 
-
 //#dce stupp
 /* display controller offsets used for crtc/cur/lut/grph/viewport/etc. */
 #define CRTC0_REGISTER_OFFSET                 (0x1b7c - 0x1b7c) //(0x6df0 - 0x6df0)/4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
index 2176548e9203..9778822dd2a0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
@@ -60,5 +60,10 @@
 #define mmVCE_VCPU_CACHE_SIZE1 0x800C
 #define mmVCE_VCPU_CACHE_SIZE2 0x800E
 #define mmVCE_VCPU_CNTL 0x8005
+#define mmVCE_VCPU_SCRATCH7 0x8037
+#define mmVCE_FW_REG_STATUS 0x8384
+#define mmVCE_LMI_FW_PERIODIC_CTRL 0x8388
+#define mmVCE_LMI_FW_START_KEYSEL 0x8386
+
 
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
index ea5b26b11cb1..1f82d6f5abde 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
@@ -61,6 +61,8 @@
 #define VCE_RB_WPTR__RB_WPTR__SHIFT 0x00000004
 #define VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK 0x00000001L
 #define VCE_SOFT_RESET__ECPU_SOFT_RESET__SHIFT 0x00000000
+#define VCE_SOFT_RESET__FME_SOFT_RESET_MASK 0x00000004L
+#define VCE_SOFT_RESET__FME_SOFT_RESET__SHIFT 0x00000002
 #define VCE_STATUS__JOB_BUSY_MASK 0x00000001L
 #define VCE_STATUS__JOB_BUSY__SHIFT 0x00000000
 #define VCE_STATUS__UENC_BUSY_MASK 0x00000100L
@@ -95,5 +97,13 @@
 #define VCE_VCPU_CNTL__CLK_EN__SHIFT 0x00000000
 #define VCE_VCPU_CNTL__RBBM_SOFT_RESET_MASK 0x00040000L
 #define VCE_VCPU_CNTL__RBBM_SOFT_RESET__SHIFT 0x00000012
+#define VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK 0x00010000
+#define VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_SHIFT 0x00000010
+#define VCE_FW_REG_STATUS__BUSY_MASK 0x0000001
+#define VCE_FW_REG_STATUS__BUSY__SHIFT 0x0000001
+#define VCE_FW_REG_STATUS__PASS_MASK 0x0000008
+#define VCE_FW_REG_STATUS__PASS__SHIFT 0x0000003
+#define VCE_FW_REG_STATUS__DONE_MASK 0x0000800
+#define VCE_FW_REG_STATUS__DONE__SHIFT 0x000000b
 
 #endif
-- 
2.51.0

