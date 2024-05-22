Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8E3C25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 07:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A607E10EE15;
	Wed, 22 May 2024 07:30:32 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE64A10F3C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 07:30:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44M7UJv4009419; Wed, 22 May 2024 13:00:19 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44M7UJqf009418;
 Wed, 22 May 2024 13:00:19 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 06/10] drm/amdgpu: Add missing offsets in gc_11_0_0_offset.h
Date: Wed, 22 May 2024 12:59:46 +0530
Message-Id: <20240522072950.9162-7-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522072950.9162-1-sunil.khatri@amd.com>
References: <20240522072950.9162-1-sunil.khatri@amd.com>
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

IB1 registers:
regCP_IB1_CMD_BUFSZ
regCP_IB1_BASE_LO
regCP_IB1_BASE_HI
regCP_IB1_BUFSZ
regCP_MES_DEBUG_INTERRUPT_INSTR_PNTR

Above registers are part of the asic but not of
the offset file for gc_11_0_0_offset.h and hence
adding them.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
index 4bff1ef8a9a6..a3bcdf632066 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
@@ -7085,10 +7085,18 @@
 #define regCP_GE_MSINVOC_COUNT_LO_BASE_IDX                                                              1
 #define regCP_GE_MSINVOC_COUNT_HI                                                                       0x20a7
 #define regCP_GE_MSINVOC_COUNT_HI_BASE_IDX                                                              1
+#define regCP_IB1_CMD_BUFSZ                                                                             0x20c0
+#define regCP_IB1_CMD_BUFSZ_BASE_IDX                                                                    1
 #define regCP_IB2_CMD_BUFSZ                                                                             0x20c1
 #define regCP_IB2_CMD_BUFSZ_BASE_IDX                                                                    1
 #define regCP_ST_CMD_BUFSZ                                                                              0x20c2
 #define regCP_ST_CMD_BUFSZ_BASE_IDX                                                                     1
+#define regCP_IB1_BASE_LO                                                                               0x20cc
+#define regCP_IB1_BASE_LO_BASE_IDX                                                                      1
+#define regCP_IB1_BASE_HI                                                                               0x20cd
+#define regCP_IB1_BASE_HI_BASE_IDX                                                                      1
+#define regCP_IB1_BUFSZ                                                                                 0x20ce
+#define regCP_IB1_BUFSZ_BASE_IDX                                                                        1
 #define regCP_IB2_BASE_LO                                                                               0x20cf
 #define regCP_IB2_BASE_LO_BASE_IDX                                                                      1
 #define regCP_IB2_BASE_HI                                                                               0x20d0
@@ -7541,6 +7549,8 @@
 #define regCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
 #define regCP_MES_DOORBELL_CONTROL6                                                                     0x2841
 #define regCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
+#define regCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
+#define regCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
 #define regCP_MES_GP0_LO                                                                                0x2843
 #define regCP_MES_GP0_LO_BASE_IDX                                                                       1
 #define regCP_MES_GP0_HI                                                                                0x2844
-- 
2.34.1

