Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61F2C35FFB
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FEF10E31A;
	Mon, 17 Mar 2025 06:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eUhL6kSC";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709DE10E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:30 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-46c8474d8f6so35955511cf.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191649; x=1742796449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YH6F5xaBrlOCjnCQkoSviLs0smusq8V/+55twMI1TPQ=;
 b=eUhL6kSCjGnJgNAwgDgvlUBzvvyVXi3TrrPQEBaQnLyiyNQ0KQL2lLl4YTGw2fr/vT
 Nb9vjfkABnLXjOlcf3R6esRzk7BD0/Uq6Y1elXUE3OjLcKEoKgjwVZ49BSxeuWbAgfha
 FfbWhdfz+9tqmgNw4eJN6L+F+IEE93lOTLS4ZAsqtqXlcWATbatiRmpze7wndZS/ImVU
 y64+ssBmGPUJ/P+5yaA0ZkyU7KTApLC4NgjHCWpJ+oPU/6zk+Ts/8W+ONsOC7SliOkfC
 ILyEbf2PB7Ww/t+mgIIjZ4/zko9k6GQJV6saPJ5a9YL9ZQHYAoBR0JVy66fvzuz+qRJH
 PHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191649; x=1742796449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YH6F5xaBrlOCjnCQkoSviLs0smusq8V/+55twMI1TPQ=;
 b=Yg6y5RdjU11v7h5i1owbcoch9hKLTSoO7jbzZPiSqNtNyn3e22eOaKOXKxELvz+1Bz
 8kfelE5xRbZ7zJ38bjJrRcO9wZWLujX0Zkd5wa+b0b7lZBn9iYORg/X4NMJRfpdkx0Ba
 4wMHA7RnIzZKOuLFKhsLx40jMYSA5Zg7o0MrMUQCAcdNK4dMdbx+q2ammaIfyI/W6C84
 SJYWc1UdpVYviO3AGsWJgunUXzCh3CjwX+4yzxQe69sLXtqGk9mPrRD5kfghREANf9Ls
 hiWPRFfst5ijLO1INVOvbYBok1EiRVDKC+iYUTucaDKexC2ifnTEk9wASbZDyIkHZv58
 Vn7g==
X-Gm-Message-State: AOJu0YzKw/oMngiB3V2ytEmiAgawZHIH2B8ROt93ZSZTLNz4jMuSiWbV
 U+iKXs5Ipr9pC0OKhrTqL6JeiRCmWb1Y9ucmckYrpjmJS/DmbpVFrng2IA==
X-Gm-Gg: ASbGncti4PI3lIVuEMYA8fZkyIzzsRyQP4Rvjzgx7EndI5d+I3aH9m3Pw9cAkX8QRA+
 9YIl2OB1r+fPFX//ex3pZ0qAHg2AFiDYHRF6Xodm2dxqEKGQrgSPJydB/HJv8t/Voan8AEwxlxn
 3LwFKr2D6MM+6XnslNKQ8bS33F/75MLWd2t1blxQy8Uv4wVTrijsrnrHeaLPzzyyIRvOtYV4ZJg
 8BvGkT4M/WS0pCWCyS2kdQuBn2Nf/iiAk21qci6XlKC57knDTKJ0NzYYYo1FfvnAWw2zxaGx3gr
 MQ7eNJlgMQMCrATvW3ISk957WAHMMuFkg2zMX0Ea5/8nzbUY15/Cypctyr9ZEkM0Kbo=
X-Google-Smtp-Source: AGHT+IE3NyVxB3sMDI1GcoRqzGWEncy1iwAqYZgVvOKgq3ksRANMJqcYMlK134Q4IFeM7ITFAcGnng==
X-Received: by 2002:ac8:7d50:0:b0:471:fdf5:3cd7 with SMTP id
 d75a77b69052e-476c81c3a7dmr175128541cf.37.1742191649371; 
 Sun, 16 Mar 2025 23:07:29 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.28
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:29 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/18] drm/amdgpu: add missing DMA defines, shifts and masks
Date: Mon, 17 Mar 2025 02:06:52 -0400
Message-ID: <20250317060702.5297-9-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
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

