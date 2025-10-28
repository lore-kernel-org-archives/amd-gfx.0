Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB21CCF9F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AEAE10E676;
	Tue, 28 Oct 2025 22:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUq0kzU/";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD03D10E683
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:50 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-63c2d72581fso9511998a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689209; x=1762294009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ywu9SCF+ZuSyHtfSGdOBnT1PjyHsW1z4PudyLZ+Y+LM=;
 b=JUq0kzU/zx46SNYaOBMoPRRbKLWfheJAN6XULEHSHCpZc8iaGwH3hOVFFSMMJiJ8T5
 3J7GJMZXQcCVFaJUb/VE8TcXeEF0V1xohYK7LLN4lHPmtTssOoFVv1GKGWNHKr0UJrmO
 tttf7zSIsaKvkHUrvLRqXCrlM8wpMvtL0Qy+YabsortwJZ1pSMLe30rZpT28rkMZQVsK
 mDXY/kndjLlvESRL5lnwzJyHFeDGTcVCm0sua+JevjtebAgiShxnmQR00KWBlUac4pK3
 aFTQGiRcz3+sYbQmo429bv1DCcSqNnAoshWRk7TD6W3WzUHiiHLZ5/GQUzNONcczAu6g
 qi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689209; x=1762294009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywu9SCF+ZuSyHtfSGdOBnT1PjyHsW1z4PudyLZ+Y+LM=;
 b=gqwKrXYPW+aN6qLUFR5zQUmHuZfnMOUU1LrL9fnhiB/LHCJUDRJxaKo0OmUENpo4FZ
 xXEXQFvUlOlqJkPHd3QRdsjoq1n9NhKp0enwsRSNQ/KUAm9BCqYop+E5qRYcd7dzzcb+
 fnvGIHSWmEt0xw8aB/fMpTKUB+NIXkQi81h097YrTP5fx3XPlYxZ/I/ajCo5XouxDG6x
 JlWIeakPsgwuj5Eqwx4us4fgSHovrEYGL9uEAY21/5skNhfAYAkNsldVK3/h1hXD0jG9
 YVTaIlQIfDQDM53pR3PhqSB67lpKAH8pq1l1xIRY1dWRDETbj/rQAMicNAuug/DotxeX
 evzg==
X-Gm-Message-State: AOJu0YwozyUE/nXwqe8Zzj4d+MTOKCE0rjNzthXCwPtKBOzVOyjpiqLP
 UDmlkbJ4F/Nm5hLHgS3IkDaOGgtIdje9GaR21fH8zIhYYYKMmvvtXmKWv0RclA==
X-Gm-Gg: ASbGncsuBFmpC4KFAneZQekN9bVZmVWcTlXobSGESajkoLJoOht+03aNRWyQ/9/N7k8
 TjRPgro8Hbn/sZv9zlKfYUUjlyC0d8nlhp6roZaNV4UrkcEff4iqEid6os+Kdlw4kQUQmHdpdiJ
 jQd5lVCusxDbivb10hZUuEx/E7bcC0I+qW4y9G+k9CADuTudlZQDs0TygUAH75BA1y0cVSZm1i7
 scB5zmfL00cNTWDB6rvsOfVsJf9Zwu6X2rMC/omz15ev68wetIjiFWxcSGmTWZWnmnZRBBHVtbC
 SfntWLjXDit5AGaFvdCYm91F1d09a0fFuAUTJZIkY4B0cI/Z/iRxSI+qqnJiA0YnBDAQ+BMqVp0
 mNvnNLGqLzYuKJSpqovvmjC4zF/Tp/jrqzzuQAAfUaxp9/pFaBkzpKtDqRReMZNQjVjI0QcIIWv
 pw5O6/OuiY1iOGJrvnCIbYDoJSEKkQKlRu7WkYLP318l24cAO4PBq6YIkQ4xNWRuoICHHlxPXFj
 HUoxQYj
X-Google-Smtp-Source: AGHT+IF31ZRGlcrqpD2u7Zr4qr5/G3xWVWYq+/+gIOgvXp/PmtBLCJTKyeENPKjrgYkIgNsul7og7g==
X-Received: by 2002:a05:6402:26d5:b0:63b:f909:df50 with SMTP id
 4fb4d7f45d1cf-640441bc6d3mr471467a12.14.1761689209090; 
 Tue, 28 Oct 2025 15:06:49 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:47 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 08/14] drm/amdgpu/vce1: Clean up register definitions
Date: Tue, 28 Oct 2025 23:06:22 +0100
Message-ID: <20251028220628.8371-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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
driver). Move all of these to the proper VCE1 headers.

Also add the register definitions that we need for the
firmware validation mechanism in VCE1.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Co-developed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
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

