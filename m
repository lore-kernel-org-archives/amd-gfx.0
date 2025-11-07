Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442E5CCFA1E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB2310EB05;
	Fri,  7 Nov 2025 15:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BO/A+ViT";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9737710EB00
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:58:00 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4774f41628bso4355325e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531079; x=1763135879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6428wiNB3XLXNIBO0dba1O6z2SpFs3rqHaYtuo9LNko=;
 b=BO/A+ViTI3zIvygdmqeYmYCvswz4FOVJ7eN+z+uIh1e4i+sJVDPKlsmLji9zVYNQWv
 SJl8L3qa/9qn/FA1gg6OF4wdZK2K9uR1RpZ8+jtfMRhNvr00ykUyDgxJstU5ZL0cZgVB
 1+TehVj+qb5bnLY8CRX2tGdPRry/NWL7foSbGr124lesA0O+QZrWLbPVp9CQDX+jpT8z
 XEWMVyJAmA6obtjbzr2Nm4Tlcrv7DVRvJX9Yds1H/BMRKjz4c8/1vemaQ26zmRsggO6Y
 AIwKiVQnkkjhl8C553Gux3AceSminp3IJCbT3KP4Wj2YNaHEx11r8zPhMsMCsvGGY5s2
 euVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531079; x=1763135879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6428wiNB3XLXNIBO0dba1O6z2SpFs3rqHaYtuo9LNko=;
 b=oYFKVdudZa+eWU7eSMQwZZqbc9shPaI/UWFzg4vyNeCh/OhtwF1Iu8WZN0Kpar41oM
 kiJj3R2bQKj2/gEp9EjfeumynB05KLiFcGsi0WKmE1RT8KOYY82gCT8/CfRt6MII5Kat
 oFkHVlKNf79GWnPAxie+uHYdf9Q080ebZDD5/5asnik6FKJdvjFvi5JhjOnEcf5dyKMs
 eRcmL8xcIrzwuRSO4zhr3otgUaN+bNPFclMrN4thajEKJTq3uc08swvOWOjFliTfMbnG
 7H55luvMK3YKWYvIxI9gsr6HvsIRHBpJYef7xOpx1UdWzifR9MzVeCBPslmXsYsG2wfg
 yIRQ==
X-Gm-Message-State: AOJu0YxkrOu52H0cgLBKlRr4gdSpojXq+84O9bebXB6EqqrmZOPCKF9W
 ifbyFWz3rkvtNfbE+m5dK5Hu2wU1vskrA28rKsUqzN5KHish/5LnBqwfjgNszQ==
X-Gm-Gg: ASbGncskS60fqF+ITfiJRS2I0XrPEZMCKQ/ljlahdDi4CoXKhLdlDDDkozoEz9w2J5/
 bUpMkCOkbwxqtC22pUwXBiSvXJfd2mHPCRcGSxcNP1y296xV4uPaYUrF9Bo7rP61ECPBU8uVuTu
 OiBFvR6eJMY9o8y71AY9Ma+kOycbzniVyv1FhSwp+8JzBPWRh9JYtWkptShGFYg3aow2Lq2hPWn
 XyQrZ3UHO5tZMdteppwR66qnVstMUorWcl7rz4LOTTJ5pYNUuhLY7KD3rJa5K66O9M2ljYkCLPH
 fA1MY1QgfbKSNMXzgQ70kIWB7ymhBx7S9B/yfZs2fQVf/cYUz7rY273sFFMU+ZxLX9PS9vGP4Vo
 NASq2VWyw8PA2FmZh2IGRcWeiDW4kTW39sXIforvKqsjvC/cB9t8fi/YxGeKnCiOtjzyzxDcn4U
 TeAXG6hrEjzIhM3C/198w=
X-Google-Smtp-Source: AGHT+IFepf6QJThO9fT2xbc8jiYIaYxxLbb1HHTqZCfhSYaKt0HD6vxnUvkRg6T1PCzt9PTXi3C22w==
X-Received: by 2002:a05:600c:1f8f:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-4776dc621c9mr21740405e9.16.1762531078812; 
 Fri, 07 Nov 2025 07:57:58 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:58 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 06/12] drm/amdgpu/vce1: Clean up register definitions
Date: Fri,  7 Nov 2025 16:57:39 +0100
Message-ID: <20251107155745.8334-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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

