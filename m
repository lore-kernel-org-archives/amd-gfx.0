Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD66C3600C
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780A810E85D;
	Sat, 22 Mar 2025 01:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MBE1cqoo";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEC710E857
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:19 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-477282401b3so7251351cf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608038; x=1743212838; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+hz04Pz+WcBLCy8syGMY7fTVfIrJEqPTcLezOKJxesI=;
 b=MBE1cqoobTiHB0k+LeHJEfFdX+2EEYvqaMznxj6JfelGed3WTit+kYi7eg0iaGKg0F
 TW5ftvNmThg29JEdgtr6GrfH6HHhjV45pdT9HYCy2tUnPOZnrxUNBi8VajLS6FH5eSS8
 Qlt864Yo9Ukw0TR33JQ2V5Z1sUjJAnVzf9OjkeElZ/Y7K76lE41ZmhTlyWeAhlKwkGDT
 sf3F4sMMF/H54R7enUcGewYcMlJE6mEadiGwxM+5IR9MjdAmtlhu6dgreL2DOWqWtNic
 PjkVrePzyasJ+Bp9AUSWbw0IMmehtAQ8us+YWamum5kGzRq+xpyOrTVKiZFglxuGmluF
 PLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608038; x=1743212838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hz04Pz+WcBLCy8syGMY7fTVfIrJEqPTcLezOKJxesI=;
 b=SkEy8z6Ff+Z6ZPRkUL2m5ZyXhYdWoxuWVpFsLJCNK8rIEQ4EebMj4HeKrukuVSlSdt
 hYFRzWNsmW7BQMyTLFzhnFM2dunPpn/xxtqp61AFq6b6BgqGLdCafFbLHKzEI1Y3er8I
 DU82pGt/xDs53HvZdDsSjT/QwLCCt4/mYLsFHSLnkvPMueTF0pBiFMOf3Os6A1eCv7TJ
 mFOTxu5J0qgZJru3yF65ePFVGuhHb/kRabdKtygMbIKp2l7fHJEU1M1ShJeoosv5NOsY
 RLMdN9V6qF/3TqpFTJaQbdBqZhfApQqBiQ8039cK+b2P0Ykh7GIQ0VLi5TN7ypsjhc2W
 XLfQ==
X-Gm-Message-State: AOJu0Yw+5Xbrma2T0nj4aF94iMuADxBLgG1XK75FOR1OyKCVoOZxfsQF
 pUFyd2g1NUfQnLbtYDCSbDuWB/O5LxwaV5Vm3JMPQrZQ6GbFewF9EokuZQ==
X-Gm-Gg: ASbGncupqQtwT7TNmBuUtROpdf+TzOm4lBnQFx69g39HXN8O61nEzMoKR/ejFUBo51y
 KaphQrPEUEKG4rBBuuhSumTjcDT6Ry5DIfjUkzWOt5qdVZVIGZtGZHbuNoHkvQzNHvdSGDk3sZA
 El4RYx9sd+nx0aFAx+J41JqavBnZGCWYIn1cpMrfAEukxohgUCs4XwQ/6t5EchKCUAYMCRxZw1i
 aURPU8dwkTEhJPpTJcjW23H4WkL7D4+mttuQOa7BJ6rN54A2m7m79XwHriQ9xGmjwRyr3njyszH
 VfndVsfpYeJhUlFvqbxrLG+TtUMmvsnpjMm7StkFCS0WsW+SOQmNaVZiHUQg3MvFnQU=
X-Google-Smtp-Source: AGHT+IH2DIMtVxP/+g3P9sxv4qYNslrEXn0EgKqmmOPsYzqWZudjzOUfcHoatczySRiSYiwoFnNnOw==
X-Received: by 2002:a05:622a:260f:b0:476:91d8:230e with SMTP id
 d75a77b69052e-4771de62880mr103980891cf.52.1742608038190; 
 Fri, 21 Mar 2025 18:47:18 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.17
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:17 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/18] drm/amdgpu: add missing DMA defines, shifts and masks
Date: Fri, 21 Mar 2025 21:46:50 -0400
Message-ID: <20250322014700.62356-9-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
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

They will be used later when switching away from sid.h/si_enums.h.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 .../drm/amd/include/asic_reg/oss/oss_1_0_d.h  | 21 +++++++--
 .../include/asic_reg/oss/oss_1_0_sh_mask.h    | 43 +++++++++++++++++++
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h
index edc8a793a95d..8edd6c871e1b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_d.h
@@ -234,6 +234,24 @@
 #define mmIH_RB_WPTR_ADDR_HI 0x0F84
 #define mmIH_RB_WPTR_ADDR_LO 0x0F85
 #define mmIH_STATUS 0x0F88
+
+#define mmDMA_GFX_RB_CNTL                                       0x3400
+#define mmDMA_GFX_RB_BASE                                       0x3401
+#define mmDMA_GFX_RB_RPTR                                       0x3402
+#define mmDMA_GFX_RB_WPTR                                       0x3403
+#define mmDMA_GFX_RB_RPTR_ADDR_HI                               0x3407
+#define mmDMA_GFX_RB_RPTR_ADDR_LO                               0x3408
+#define mmDMA_GFX_IB_CNTL                                       0x3409
+#define mmDMA_GFX_IB_RPTR                                       0x340a
+#define mmDMA_CNTL                                          0x340b
+#define mmDMA_STATUS_REG                                    0x340D
+#define mmDMA_TILING_CONFIG  				  0x342E
+#define	mmDMA_POWER_CNTL					0x342F
+#define	mmDMA_CLK_CTRL					0x3430
+#define	mmDMA_PG						0x3435
+#define	mmDMA_PGFSM_CONFIG				0x3436
+#define	mmDMA_PGFSM_WRITE					0x3437
+
 #define mmSEM_MAILBOX 0x0F9B
 #define mmSEM_MAILBOX_CLIENTCONFIG 0x0F9A
 #define mmSEM_MAILBOX_CONTROL 0x0F9C
@@ -269,7 +287,4 @@
 #define mmVCE_CONFIG 0x0F94
 #define mmXDMA_MSTR_MEM_OVERFLOW_CNTL 0x03F8
 
-/* from the old sid.h */
-#define mmDMA_TILING_CONFIG 0x342E
-
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_sh_mask.h
index 1c540fe136cb..12c6c39d93d0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_1_0_sh_mask.h
@@ -823,6 +823,45 @@
 #define LX3__RESERVED__SHIFT 0x00000000
 #define RINGOSC_MASK__MASK_MASK 0x0000ffffL
 #define RINGOSC_MASK__MASK__SHIFT 0x00000000
+
+#define DMA_CNTL__TRAP_ENABLE_MASK 0x00000001L	// (1 << 0)
+#define DMA_CNTL__TRAP_ENABLE__SHIFT 0x00000000
+#define DMA_CNTL__SEM_INCOMPLETE_INT_ENABLE_MASK 0x00000002L	// (1 << 1)
+#define DMA_CNTL__SEM_INCOMPLETE_INT_ENABLE__SHIFT 0x00000001
+#define DMA_CNTL__SEM_WAIT_INT_ENABLE_MASK 0x00000004L	// (1 << 2)
+#define DMA_CNTL__SEM_WAIT_INT_ENABLE__SHIFT 0x00000002
+#define DMA_CNTL__DATA_SWAP_ENABLE_MASK 0x00000008L	// (1 << 3)
+#define DMA_CNTL__DATA_SWAP_ENABLE__SHIFT 0x00000003
+#define DMA_CNTL__FENCE_SWAP_ENABLE_MASK 0x00000010L	// (1 << 4)
+#define DMA_CNTL__FENCE_SWAP_ENABLE__SHIFT 0x00000004
+#define DMA_CNTL__CTXEMPTY_INT_ENABLE_MASK 0x10000000L	// (1 << 28)
+#define DMA_CNTL__CTXEMPTY_INT_ENABLE__SHIFT 0x0000001C
+#define DMA_GFX_RB_CNTL__RB_ENABLE_MASK 0x00000001L	// (1 << 0)
+#define DMA_GFX_RB_CNTL__RB_ENABLE__SHIFT 0x00000000
+// #define DMA_GFX_RB_CNTL__RB_SIZE_MASK 0x00000001L	// undefined
+#define DMA_GFX_RB_CNTL__RB_SIZE__SHIFT 0x00000001	// ((x) << 1) /* log2 */
+#define DMA_GFX_RB_CNTL__RB_SWAP_ENABLE_MASK 0x00000200L	// (1 << 9) /* 8IN32 */
+#define DMA_GFX_RB_CNTL__RB_SWAP_ENABLE__SHIFT 0x00000009
+#define DMA_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK 0x00001000L	// (1 << 12)
+#define DMA_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT 0x0000000C
+#define DMA_GFX_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK 0x00002000L	// (1 << 13)  /* 8IN32 */
+#define DMA_GFX_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT 0x0000000D
+// #define DMA_GFX_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK 0x00000001L	// undefined
+#define DMA_GFX_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT 0x00000010	// ((x) << 16) /* log2 */
+#define DMA_GFX_IB_CNTL__IB_ENABLE_MASK 0x00000001L	// (1 << 0)
+#define DMA_GFX_IB_CNTL__IB_ENABLE__SHIFT 0x00000000
+#define DMA_GFX_IB_CNTL__IB_SWAP_ENABLE_MASK 0x00000010L	// (1 << 4)
+#define DMA_GFX_IB_CNTL__IB_SWAP_ENABLE__SHIFT 0x00000004
+#define DMA_GFX_IB_CNTL__CMD_VMID_FORCE_MASK 0x80000000L	// (1 << 31)
+#define DMA_GFX_IB_CNTL__CMD_VMID_FORCE__SHIFT 0x0000001F
+
+#define DMA_STATUS_REG__IDLE_MASK 0x00000001L	// (1 << 0)
+#define DMA_STATUS_REG__IDLE__SHIFT 0x00000000
+#define DMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK 0x00000100L	// (1 << 8)
+#define DMA_POWER_CNTL__MEM_POWER_OVERRIDE__SHIFT 0x00000008
+#define DMA_PG__PG_CNTL_ENABLE_MASK 0x00000001L	// (1 << 0)
+#define DMA_PG__PG_CNTL_ENABLE__SHIFT 0x00000000
+
 #define SEM_MAILBOX_CLIENTCONFIG__CP_CLIENT0_MASK 0x00000007L
 #define SEM_MAILBOX_CLIENTCONFIG__CP_CLIENT0__SHIFT 0x00000000
 #define SEM_MAILBOX_CLIENTCONFIG__CP_CLIENT1_MASK 0x00000038L
@@ -1015,6 +1054,10 @@
 #define SRBM_STATUS2__VCE_BUSY__SHIFT 0x00000007
 #define SRBM_STATUS2__VCE_RQ_PENDING_MASK 0x00000008L
 #define SRBM_STATUS2__VCE_RQ_PENDING__SHIFT 0x00000003
+#define SRBM_STATUS2__DMA_BUSY_MASK 0x00000020L
+#define SRBM_STATUS2__DMA_BUSY__SHIFT 0x00000005
+#define SRBM_STATUS2__DMA1_BUSY_MASK 0x00000040L
+#define SRBM_STATUS2__DMA1_BUSY__SHIFT 0x00000006
 #define SRBM_STATUS2__XDMA_BUSY_MASK 0x00000100L
 #define SRBM_STATUS2__XDMA_BUSY__SHIFT 0x00000008
 #define SRBM_STATUS2__XSP_BUSY_MASK 0x00000010L
-- 
2.48.1

