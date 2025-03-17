Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BEEC35FF6
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1655010E097;
	Mon, 17 Mar 2025 06:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="li/E7xBM";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA5E10E097
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:27 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-6e8fd49b85eso62953616d6.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191646; x=1742796446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6uCWP9LDrnufVfYJN2pn96GHSM4N3Hz1AD8gey4PkbM=;
 b=li/E7xBMFcidlkauTD7EZPLZDUCOtWBEzntc2F1BXQQg3PUyYc6ok1dUgumgEMomaN
 pqEmMuFKBuEjmICOGPfr2DnWnSeuVQ2zhPoaEN/zIypddfz2DcW75O7AKtmOKh112iaa
 v0BEDCuGGBqMHwIY7Q+9bYdK/Rr8cFllXA7r1uw52miXIrXD0UrkL4lgcmCluVWepUnH
 G151PBOEOsLGVJqTceJsI1pOXQQCje62Oi+ANllbDarB9uE1fhVCoCM28ehb8w7aUwTk
 +aa7DeCAueOVPxxig4Hfcj6d6Iwfl8F0vqoIZDYMrnUnDZ+3JeJ4pZXP7kv/+8YM6MCO
 Rl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191646; x=1742796446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6uCWP9LDrnufVfYJN2pn96GHSM4N3Hz1AD8gey4PkbM=;
 b=D2vBHB3a579g4Aa3/tGWSdcEBtuooNCx1LsUu1oekaeRWY3j7CYD64z3KVtYCSgZSY
 xeKwTMqjcI0tC0JysAtLIlORCJfvUCfb5WSThkpmvR1bI/Hw3z2hIRk/eNfBxK5185ur
 vLHnAV28LmhRWjdfQW0N4UvWzmZ5Q6NkYzlrmJzQEbHg6H1srLV2BfvVReGirczTMtNV
 DZLrUyn8gW24OukX60ADhyOrDKHDwU5hLnVARCnHKbIWHNmVaqZGoaocJgsnNXYUz2K+
 LUwkvgKl3ZSCltJwPMnhbUghmKt6qZhYQ0XsbFqk+qUbXgW1xu3riHOMyp6WbQJomFVO
 3sSA==
X-Gm-Message-State: AOJu0Yww9mNEeCC2C9wqWZvqr8ph+M12Yl33+4dpdOJV555y3QyIH4Op
 A7QBaYktg4dOcxW/R5xn91EMH6WT0YwyEoe4YeGX3I52FVR/pkeS2WkPkA==
X-Gm-Gg: ASbGncvQicLlaDtKz4BSDgbV15bzMZG/Uepmmj+4TMLJ7CJ5Xnm9D8awG157o4wBgLX
 OhFBk5EWQizWp/+uhlkmpGwi+y06wLKleJnSb5JPBVQRncSkhm2tY4v+R02faUutCB6QpH7Zmzw
 Uc+BXfzZZqWHei4hpzyJVBelK7XKOeGvpYBJVFjbF2zPX1b6DFY5xw7DOKYKQuyU8uFcxY3+HfW
 Eh4Te24Hw/KoEFm74SCh6qd+NxE/oPznfyZLegxbewX+NC5NmqnkATvg3VMttXwQmw19MHgDThG
 tWz2+Pa3/GV1st4gFgNiELfYXKBmnFFRYk48aIQ/sXSmI0SIcO4ze92/8n2Y/FpM8QY=
X-Google-Smtp-Source: AGHT+IHziI1XYedGXoPbmMg1wjIn+RMuGR+1bT+KOYXTrEYugsaEe8TD91VPsbqjkN4xsdnbTB6QEA==
X-Received: by 2002:a05:6214:cc1:b0:6e8:fee2:aae4 with SMTP id
 6a1803df08f44-6eaeaacdc34mr197962056d6.28.1742191646226; 
 Sun, 16 Mar 2025 23:07:26 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.25
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:25 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/18] drm/amdgpu: remove PACKET3 duplicated defines from
 si_enums.h
Date: Mon, 17 Mar 2025 02:06:48 -0400
Message-ID: <20250317060702.5297-5-alexandre.f.demers@gmail.com>
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

PACKET3 is already in sid.h, as it is done under cikd.h for CIK

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_enums.h | 123 --------------------------
 1 file changed, 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index f6804c9b7a27..7c4dc9c5373e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -146,127 +146,4 @@
 #define RLC_SAVE_AND_RESTORE_STARTING_OFFSET 0x90
 #define RLC_CLEAR_STATE_DESCRIPTOR_OFFSET    0x3D
 
-#define PACKET3(op, n)  ((RADEON_PACKET_TYPE3 << 30) |                  \
-                         (((op) & 0xFF) << 8) |                         \
-                         ((n) & 0x3FFF) << 16)
-#define PACKET3_COMPUTE(op, n) (PACKET3(op, n) | 1 << 1)
-#define	PACKET3_NOP					0x10
-#define	PACKET3_SET_BASE				0x11
-#define		PACKET3_BASE_INDEX(x)                  ((x) << 0)
-#define	PACKET3_CLEAR_STATE				0x12
-#define	PACKET3_INDEX_BUFFER_SIZE			0x13
-#define	PACKET3_DISPATCH_DIRECT				0x15
-#define	PACKET3_DISPATCH_INDIRECT			0x16
-#define	PACKET3_ALLOC_GDS				0x1B
-#define	PACKET3_WRITE_GDS_RAM				0x1C
-#define	PACKET3_ATOMIC_GDS				0x1D
-#define	PACKET3_ATOMIC					0x1E
-#define	PACKET3_OCCLUSION_QUERY				0x1F
-#define	PACKET3_SET_PREDICATION				0x20
-#define	PACKET3_REG_RMW					0x21
-#define	PACKET3_COND_EXEC				0x22
-#define	PACKET3_PRED_EXEC				0x23
-#define	PACKET3_DRAW_INDIRECT				0x24
-#define	PACKET3_DRAW_INDEX_INDIRECT			0x25
-#define	PACKET3_INDEX_BASE				0x26
-#define	PACKET3_DRAW_INDEX_2				0x27
-#define	PACKET3_CONTEXT_CONTROL				0x28
-#define	PACKET3_INDEX_TYPE				0x2A
-#define	PACKET3_DRAW_INDIRECT_MULTI			0x2C
-#define	PACKET3_DRAW_INDEX_AUTO				0x2D
-#define	PACKET3_DRAW_INDEX_IMMD				0x2E
-#define	PACKET3_NUM_INSTANCES				0x2F
-#define	PACKET3_DRAW_INDEX_MULTI_AUTO			0x30
-#define	PACKET3_INDIRECT_BUFFER_CONST			0x31
-#define	PACKET3_INDIRECT_BUFFER				0x3F
-#define	PACKET3_STRMOUT_BUFFER_UPDATE			0x34
-#define	PACKET3_DRAW_INDEX_OFFSET_2			0x35
-#define	PACKET3_DRAW_INDEX_MULTI_ELEMENT		0x36
-#define	PACKET3_WRITE_DATA				0x37
-#define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
-#define	PACKET3_MEM_SEMAPHORE				0x39
-#define	PACKET3_MPEG_INDEX				0x3A
-#define	PACKET3_COPY_DW					0x3B
-#define	PACKET3_WAIT_REG_MEM				0x3C
-#define	PACKET3_MEM_WRITE				0x3D
-#define	PACKET3_COPY_DATA				0x40
-#define	PACKET3_CP_DMA					0x41
-#              define PACKET3_CP_DMA_DST_SEL(x)    ((x) << 20)
-#              define PACKET3_CP_DMA_ENGINE(x)     ((x) << 27)
-#              define PACKET3_CP_DMA_SRC_SEL(x)    ((x) << 29)
-#              define PACKET3_CP_DMA_CP_SYNC       (1 << 31)
-#              define PACKET3_CP_DMA_DIS_WC        (1 << 21)
-#              define PACKET3_CP_DMA_CMD_SRC_SWAP(x) ((x) << 22)
-#              define PACKET3_CP_DMA_CMD_DST_SWAP(x) ((x) << 24)
-#              define PACKET3_CP_DMA_CMD_SAS       (1 << 26)
-#              define PACKET3_CP_DMA_CMD_DAS       (1 << 27)
-#              define PACKET3_CP_DMA_CMD_SAIC      (1 << 28)
-#              define PACKET3_CP_DMA_CMD_DAIC      (1 << 29)
-#              define PACKET3_CP_DMA_CMD_RAW_WAIT  (1 << 30)
-#define	PACKET3_PFP_SYNC_ME				0x42
-#define	PACKET3_SURFACE_SYNC				0x43
-#              define PACKET3_DEST_BASE_0_ENA      (1 << 0)
-#              define PACKET3_DEST_BASE_1_ENA      (1 << 1)
-#              define PACKET3_CB0_DEST_BASE_ENA    (1 << 6)
-#              define PACKET3_CB1_DEST_BASE_ENA    (1 << 7)
-#              define PACKET3_CB2_DEST_BASE_ENA    (1 << 8)
-#              define PACKET3_CB3_DEST_BASE_ENA    (1 << 9)
-#              define PACKET3_CB4_DEST_BASE_ENA    (1 << 10)
-#              define PACKET3_CB5_DEST_BASE_ENA    (1 << 11)
-#              define PACKET3_CB6_DEST_BASE_ENA    (1 << 12)
-#              define PACKET3_CB7_DEST_BASE_ENA    (1 << 13)
-#              define PACKET3_DB_DEST_BASE_ENA     (1 << 14)
-#              define PACKET3_DEST_BASE_2_ENA      (1 << 19)
-#              define PACKET3_DEST_BASE_3_ENA      (1 << 21)
-#              define PACKET3_TCL1_ACTION_ENA      (1 << 22)
-#              define PACKET3_TC_ACTION_ENA        (1 << 23)
-#              define PACKET3_CB_ACTION_ENA        (1 << 25)
-#              define PACKET3_DB_ACTION_ENA        (1 << 26)
-#              define PACKET3_SH_KCACHE_ACTION_ENA (1 << 27)
-#              define PACKET3_SH_ICACHE_ACTION_ENA (1 << 29)
-#define	PACKET3_ME_INITIALIZE				0x44
-#define		PACKET3_ME_INITIALIZE_DEVICE_ID(x) ((x) << 16)
-#define	PACKET3_COND_WRITE				0x45
-#define	PACKET3_EVENT_WRITE				0x46
-#define	PACKET3_EVENT_WRITE_EOP				0x47
-#define	PACKET3_EVENT_WRITE_EOS				0x48
-#define	PACKET3_PREAMBLE_CNTL				0x4A
-#              define PACKET3_PREAMBLE_BEGIN_CLEAR_STATE     (2 << 28)
-#              define PACKET3_PREAMBLE_END_CLEAR_STATE       (3 << 28)
-#define	PACKET3_ONE_REG_WRITE				0x57
-#define	PACKET3_LOAD_CONFIG_REG				0x5F
-#define	PACKET3_LOAD_CONTEXT_REG			0x60
-#define	PACKET3_LOAD_SH_REG				0x61
-#define	PACKET3_SET_CONFIG_REG				0x68
-#define		PACKET3_SET_CONFIG_REG_START			0x00002000
-#define		PACKET3_SET_CONFIG_REG_END			0x00002c00
-#define	PACKET3_SET_CONTEXT_REG				0x69
-#define		PACKET3_SET_CONTEXT_REG_START			0x000a000
-#define		PACKET3_SET_CONTEXT_REG_END			0x000a400
-#define	PACKET3_SET_CONTEXT_REG_INDIRECT		0x73
-#define	PACKET3_SET_RESOURCE_INDIRECT			0x74
-#define	PACKET3_SET_SH_REG				0x76
-#define		PACKET3_SET_SH_REG_START			0x00002c00
-#define		PACKET3_SET_SH_REG_END				0x00003000
-#define	PACKET3_SET_SH_REG_OFFSET			0x77
-#define	PACKET3_ME_WRITE				0x7A
-#define	PACKET3_SCRATCH_RAM_WRITE			0x7D
-#define	PACKET3_SCRATCH_RAM_READ			0x7E
-#define	PACKET3_CE_WRITE				0x7F
-#define	PACKET3_LOAD_CONST_RAM				0x80
-#define	PACKET3_WRITE_CONST_RAM				0x81
-#define	PACKET3_WRITE_CONST_RAM_OFFSET			0x82
-#define	PACKET3_DUMP_CONST_RAM				0x83
-#define	PACKET3_INCREMENT_CE_COUNTER			0x84
-#define	PACKET3_INCREMENT_DE_COUNTER			0x85
-#define	PACKET3_WAIT_ON_CE_COUNTER			0x86
-#define	PACKET3_WAIT_ON_DE_COUNTER			0x87
-#define	PACKET3_WAIT_ON_DE_COUNTER_DIFF			0x88
-#define	PACKET3_SET_CE_DE_COUNTERS			0x89
-#define	PACKET3_WAIT_ON_AVAIL_BUFFER			0x8A
-#define	PACKET3_SWITCH_BUFFER				0x8B
-#define PACKET3_SEM_WAIT_ON_SIGNAL    (0x1 << 12)
-#define PACKET3_SEM_SEL_SIGNAL	    (0x6 << 29)
-#define PACKET3_SEM_SEL_WAIT	    (0x7 << 29)
-
 #endif
-- 
2.48.1

