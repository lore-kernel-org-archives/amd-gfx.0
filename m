Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URG_BIZ,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08129C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83ED20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBiUYJ6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83ED20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9549B6E069;
	Thu, 16 Jul 2020 21:23:11 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B55BB6E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:09 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j4so8601762wrp.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VXqwqE7Zo5JLpQgFKTzr3chggYFs3dKeOMtv8JxFwWg=;
 b=BBiUYJ6zmTZ6NXywDOaukxGt2DABwmOqVGRQUKOTDOsSBaVgOaJm+GE5VnJWssZlnP
 rRnB//Tv/ZNpUnB2LzJLR01U7G/2qkCD78tQvJ6d8r3+810zfIw8QMqllhcOmQR+9z4Q
 5nlCc3d1Z4cM9jwgiErtQvcdZQcWY5ey2TfjX3XU5I6hk5guXPxZNfdZml8XEvEmJ90k
 VTNfHXr8jWrj8PYLtXveyQCdvErNoPneU36Iz5RUtdKuDnfjKztoubjADOgl1TA48Hbi
 Qfz9B8aUblmXD9UvJn5ZxdRqMcoyxNibA5tLzjemdMPOSR6V+tZMVjHYGOnE4Euf1lAZ
 pARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VXqwqE7Zo5JLpQgFKTzr3chggYFs3dKeOMtv8JxFwWg=;
 b=rWxbyX6CZwYAYImZw1gXW2YPP3uU8uYwbAgJz2bM5ySl1ur30V+Nu933kqN9+Nv+R2
 xZkR9hx9unC0CoqdcoAfMk0OYDrAHU2q6j1/0lzPrMoo+PLEB//gIAIt0Lm4k0uWcey0
 92O5P8B1hDaMVu5RRki+YxDmprhFVl5tUHhaHaJpCJaAghHwnWuGKE/++bXdqATA2fhC
 lxiY++6ZZGY1elmDUH7YssGiPcdPbWPNGiLKpRapY91fjqn6Yi8mT3mS/L4B7oV8mRI4
 c+o22d1TJqHiQLZwJXVYG76pK0vyr1hYYfCc7MRJ/Q00Xrjwa3ha4NSAb6JP1CAOxOIk
 WH0w==
X-Gm-Message-State: AOAM530SpV6+p3mTiPA5d3JP6fL161gMZpLfHp6g0vL5cKTwqcWFEJdS
 ZQDaawHI2I+KIVG0mrAwIsXejRXNKUs=
X-Google-Smtp-Source: ABdhPJwHUPS4DwkMGowisLPGyBxZPbe8KEoPJ3v56etkeKg3TIXXkVmBR2Lm6vDmaTWJHJqT2QiyqA==
X-Received: by 2002:a5d:628b:: with SMTP id k11mr6901728wru.107.1594934587790; 
 Thu, 16 Jul 2020 14:23:07 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:07 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 01/27] drm/amdgpu: add some required DCE6 registers (v6)
Date: Thu, 16 Jul 2020 23:22:25 +0200
Message-Id: <20200716212251.1539094-2-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

To help with the DC port.

v2: add missing masks, add additional registers
v3: more updates
v4: fix accidently dropped changes
v5: add missing nb pstate mask
v6: add vblank, vline masks

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/include/asic_reg/dce/dce_6_0_d.h  | 62 ++++++++++++-
 .../include/asic_reg/dce/dce_6_0_sh_mask.h    | 92 +++++++++++++++++++
 2 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
index ae798f768853..74897b046006 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h
@@ -4444,14 +4444,74 @@
 
 /* Registers that spilled out of sid.h */
 #define mmDATA_FORMAT                              0x1AC0
+#define mmLB0_DATA_FORMAT                               0x1AC0
+#define mmLB1_DATA_FORMAT                               0x1DC0
+#define mmLB2_DATA_FORMAT                               0x40C0
+#define mmLB3_DATA_FORMAT                               0x43C0
+#define mmLB4_DATA_FORMAT                               0x46C0
+#define mmLB5_DATA_FORMAT                               0x49C0
 #define mmDESKTOP_HEIGHT                           0x1AC1
+#define mmLB0_DESKTOP_HEIGHT                            0x1AC1
+#define mmLB1_DESKTOP_HEIGHT                            0x1DC1
+#define mmLB2_DESKTOP_HEIGHT                            0x40C1
+#define mmLB3_DESKTOP_HEIGHT                            0x43C1
+#define mmLB4_DESKTOP_HEIGHT                            0x46C1
+#define mmLB5_DESKTOP_HEIGHT                            0x49C1
 #define mmDC_LB_MEMORY_SPLIT                       0x1AC3
+#define mmLB0_DC_LB_MEMORY_SPLIT                        0x1AC3
+#define mmLB1_DC_LB_MEMORY_SPLIT                        0x1DC3
+#define mmLB2_DC_LB_MEMORY_SPLIT                        0x40C3
+#define mmLB3_DC_LB_MEMORY_SPLIT                        0x43C3
+#define mmLB4_DC_LB_MEMORY_SPLIT                        0x46C3
+#define mmLB5_DC_LB_MEMORY_SPLIT                        0x49C3
+#define mmDC_LB_MEM_SIZE                                0x1AC4
+#define mmLB0_DC_LB_MEM_SIZE                            0x1AC4
+#define mmLB1_DC_LB_MEM_SIZE                            0x1DC4
+#define mmLB2_DC_LB_MEM_SIZE                            0x40C4
+#define mmLB3_DC_LB_MEM_SIZE                            0x43C4
+#define mmLB4_DC_LB_MEM_SIZE                            0x46C4
+#define mmLB5_DC_LB_MEM_SIZE                            0x49C4
 #define mmPRIORITY_A_CNT                           0x1AC6
+#define mmLB0_PRIORITY_A_CNT                            0x1AC6
+#define mmLB1_PRIORITY_A_CNT                            0x1DC6
+#define mmLB2_PRIORITY_A_CNT                            0x40C6
+#define mmLB3_PRIORITY_A_CNT                            0x43C6
+#define mmLB4_PRIORITY_A_CNT                            0x46C6
+#define mmLB5_PRIORITY_A_CNT                            0x49C6
 #define mmPRIORITY_B_CNT                           0x1AC7
+#define mmLB0_PRIORITY_B_CNT                            0x1AC7
+#define mmLB1_PRIORITY_B_CNT                            0x1DC7
+#define mmLB2_PRIORITY_B_CNT                            0x40C7
+#define mmLB3_PRIORITY_B_CNT                            0x43C7
+#define mmLB4_PRIORITY_B_CNT                            0x46C7
+#define mmLB5_PRIORITY_B_CNT                            0x49C7
 #define mmDPG_PIPE_ARBITRATION_CONTROL3            0x1B32
+#define mmDMIF_PG0_DPG_PIPE_ARBITRATION_CONTROL3        0x1B32
+#define mmDMIF_PG1_DPG_PIPE_ARBITRATION_CONTROL3        0x1E32
+#define mmDMIF_PG2_DPG_PIPE_ARBITRATION_CONTROL3        0x4132
+#define mmDMIF_PG3_DPG_PIPE_ARBITRATION_CONTROL3        0x4432
+#define mmDMIF_PG4_DPG_PIPE_ARBITRATION_CONTROL3        0x4732
+#define mmDMIF_PG5_DPG_PIPE_ARBITRATION_CONTROL3        0x4A32
 #define mmINT_MASK                                 0x1AD0
+#define mmLB0_INT_MASK                                  0x1AD0
+#define mmLB1_INT_MASK                                  0x1DD0
+#define mmLB2_INT_MASK                                  0x40D0
+#define mmLB3_INT_MASK                                  0x43D0
+#define mmLB4_INT_MASK                                  0x46D0
+#define mmLB5_INT_MASK                                  0x49D0
 #define mmVLINE_STATUS                             0x1AEE
+#define mmLB0_VLINE_STATUS                              0x1AEE
+#define mmLB1_VLINE_STATUS                              0x1DEE
+#define mmLB2_VLINE_STATUS                              0x40EE
+#define mmLB3_VLINE_STATUS                              0x43EE
+#define mmLB4_VLINE_STATUS                              0x46EE
+#define mmLB5_VLINE_STATUS                              0x49EE
 #define mmVBLANK_STATUS                            0x1AEF
-
+#define mmLB0_VBLANK_STATUS                             0x1AEF
+#define mmLB1_VBLANK_STATUS                             0x1DEF
+#define mmLB2_VBLANK_STATUS                             0x40EF
+#define mmLB3_VBLANK_STATUS                             0x43EF
+#define mmLB4_VBLANK_STATUS                             0x46EF
+#define mmLB5_VBLANK_STATUS                             0x49EF
 
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
index abe05bc80752..bf262460b0b9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
@@ -2076,6 +2076,8 @@
 #define CRTC_CONTROL__CRTC_START_POINT_CNTL__SHIFT 0x0000000c
 #define CRTC_CONTROL__CRTC_SYNC_RESET_SEL_MASK 0x00000010L
 #define CRTC_CONTROL__CRTC_SYNC_RESET_SEL__SHIFT 0x00000004
+#define CRTC_CONTROL__CRTC_PREFETCH_EN_MASK                0x10000000L
+#define	CRTC_CONTROL__CRTC_PREFETCH_EN__SHIFT              0x0000001c
 #define CRTC_COUNT_CONTROL__CRTC_HORZ_COUNT_BY2_EN_MASK 0x00000001L
 #define CRTC_COUNT_CONTROL__CRTC_HORZ_COUNT_BY2_EN__SHIFT 0x00000000
 #define CRTC_COUNT_CONTROL__CRTC_HORZ_REPETITION_COUNT_MASK 0x0000001eL
@@ -6364,6 +6366,8 @@
 #define DPG_PIPE_ARBITRATION_CONTROL2__TIME_WEIGHT__SHIFT 0x00000000
 #define DPG_PIPE_ARBITRATION_CONTROL2__URGENCY_WEIGHT_MASK 0xffff0000L
 #define DPG_PIPE_ARBITRATION_CONTROL2__URGENCY_WEIGHT__SHIFT 0x00000010
+#define DPG_PIPE_ARBITRATION_CONTROL3__URGENCY_WATERMARK_MASK_MASK 0x00030000L
+#define	DPG_PIPE_ARBITRATION_CONTROL3__URGENCY_WATERMARK_MASK__SHIFT 0x00000010
 #define DPG_PIPE_DPM_CONTROL__DPM_ENABLE_MASK 0x00000001L
 #define DPG_PIPE_DPM_CONTROL__DPM_ENABLE__SHIFT 0x00000000
 #define DPG_PIPE_DPM_CONTROL__MCLK_CHANGE_ENABLE_MASK 0x00000010L
@@ -6384,6 +6388,8 @@
 #define DPG_PIPE_NB_PSTATE_CHANGE_CONTROL__NB_PSTATE_CHANGE_NOT_SELF_REFRESH_DURING_REQUEST__SHIFT 0x00000008
 #define DPG_PIPE_NB_PSTATE_CHANGE_CONTROL__NB_PSTATE_CHANGE_URGENT_DURING_REQUEST_MASK 0x00000010L
 #define DPG_PIPE_NB_PSTATE_CHANGE_CONTROL__NB_PSTATE_CHANGE_URGENT_DURING_REQUEST__SHIFT 0x00000004
+#define DPG_PIPE_NB_PSTATE_CHANGE_CONTROL__NB_PSTATE_CHANGE_WATERMARK_MASK_MASK 0x00003000L
+#define	DPG_PIPE_NB_PSTATE_CHANGE_CONTROL__NB_PSTATE_CHANGE_WATERMARK_MASK__SHIFT 0x0000000c
 #define DPG_PIPE_NB_PSTATE_CHANGE_CONTROL__NB_PSTATE_CHANGE_WATERMARK_MASK 0xffff0000L
 #define DPG_PIPE_NB_PSTATE_CHANGE_CONTROL__NB_PSTATE_CHANGE_WATERMARK__SHIFT 0x00000010
 #define DPG_PIPE_STUTTER_CONTROL_NONLPTCH__STUTTER_ENABLE_NONLPTCH_MASK 0x00000001L
@@ -6406,6 +6412,8 @@
 #define DPG_PIPE_STUTTER_CONTROL_NONLPTCH__STUTTER_WM_HIGH_FORCE_ON_NONLPTCH__SHIFT 0x00000008
 #define DPG_PIPE_STUTTER_CONTROL__STUTTER_ENABLE_MASK 0x00000001L
 #define DPG_PIPE_STUTTER_CONTROL__STUTTER_ENABLE__SHIFT 0x00000000
+#define DPG_PIPE_STUTTER_CONTROL__STUTTER_EXIT_SELF_REFRESH_WATERMARK_MASK_MASK 0x00003000L
+#define	DPG_PIPE_STUTTER_CONTROL__STUTTER_EXIT_SELF_REFRESH_WATERMARK_MASK__SHIFT 0x0000000c
 #define DPG_PIPE_STUTTER_CONTROL__STUTTER_EXIT_SELF_REFRESH_WATERMARK_MASK 0xffff0000L
 #define DPG_PIPE_STUTTER_CONTROL__STUTTER_EXIT_SELF_REFRESH_WATERMARK__SHIFT 0x00000010
 #define DPG_PIPE_STUTTER_CONTROL__STUTTER_IGNORE_CURSOR_MASK 0x00000010L
@@ -7256,6 +7264,8 @@
 #define GRPH_CONTROL__GRPH_FORMAT__SHIFT 0x00000008
 #define GRPH_CONTROL__GRPH_MACRO_TILE_ASPECT_MASK 0x000c0000L
 #define GRPH_CONTROL__GRPH_MACRO_TILE_ASPECT__SHIFT 0x00000012
+#define GRPH_CONTROL__GRPH_ARRAY_MODE_MASK                 0x00f00000L
+#define	GRPH_CONTROL__GRPH_ARRAY_MODE__SHIFT               0x00000014
 #define GRPH_CONTROL__GRPH_NUM_BANKS_MASK 0x0000000cL
 #define GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT 0x00000002
 #define GRPH_CONTROL__GRPH_PIPE_CONFIG_MASK 0x1f000000L
@@ -9835,4 +9845,86 @@
 #define XDMA_TEST_DEBUG_INDEX__XDMA_TEST_DEBUG_WRITE_EN_MASK 0x00000100L
 #define XDMA_TEST_DEBUG_INDEX__XDMA_TEST_DEBUG_WRITE_EN__SHIFT 0x00000008
 
+// DATA_FORMAT
+#define DATA_FORMAT__INTERLEAVE_EN_MASK                    0x00000001L
+#define	DATA_FORMAT__INTERLEAVE_EN__SHIFT                  0x00000000
+#define DATA_FORMAT__RESET_REQ_AT_EOL_MASK                 0x00000010L
+#define	DATA_FORMAT__RESET_REQ_AT_EOL__SHIFT               0x00000004
+#define DATA_FORMAT__PREFETCH_MASK                         0x00001000L
+#define	DATA_FORMAT__PREFETCH__SHIFT                       0x0000000c
+#define DATA_FORMAT__SOF_READ_PT_MASK                      0x001f0000L
+#define	DATA_FORMAT__SOF_READ_PT__SHIFT                    0x00000010
+#define DATA_FORMAT__REQUEST_MODE_MASK                     0x03000000L
+#define	DATA_FORMAT__REQUEST_MODE__SHIFT                   0x00000018
+#define DATA_FORMAT__ALLOW_REQ_MODE_1_2_MASK               0x10000000L
+#define	DATA_FORMAT__ALLOW_REQ_MODE_1_2__SHIFT             0x0000001c
+
+
+// DC_LB_MEMORY_SPLIT
+#define DC_LB_MEMORY_SPLIT__LB_NUM_PARTITIONS_MASK         0x000f0000L
+#define	DC_LB_MEMORY_SPLIT__LB_NUM_PARTITIONS__SHIFT       0x00000010
+#define DC_LB_MEMORY_SPLIT__DC_LB_MEMORY_CONFIG_MASK       0x00300000L
+#define	DC_LB_MEMORY_SPLIT__DC_LB_MEMORY_CONFIG__SHIFT     0x00000014
+
+// DC_LB_MEM_SIZE
+#define DC_LB_MEM_SIZE__DC_LB_MEM_SIZE_MASK                0x000007ffL
+#define	DC_LB_MEM_SIZE__DC_LB_MEM_SIZE__SHIFT              0x00000000
+
+// SCL_TAP_CONTROL
+#define SCL_TAP_CONTROL__SCL_V_NUM_OF_TAPS_MASK            0x00000007L
+#define	SCL_TAP_CONTROL__SCL_V_NUM_OF_TAPS__SHIFT          0x00000000
+#define SCL_TAP_CONTROL__SCL_H_NUM_OF_TAPS_MASK            0x00000f00L
+#define	SCL_TAP_CONTROL__SCL_H_NUM_OF_TAPS__SHIFT          0x00000008
+
+// INT_MASK
+#define INT_MASK__VBLANK_INT_MASK                          0x00000001L
+#define	INT_MASK__VBLANK_INT__SHIFT                        0x00000000
+#define INT_MASK__VLINE_INT_MASK                           0x00000010L
+#define	INT_MASK__VLINE_INT__SHIFT                         0x00000004
+
+// PRIORITY_A_CNT
+#define PRIORITY_A_CNT__PRIORITY_MARK_A_MASK               0x00007fffL
+#define	PRIORITY_A_CNT__PRIORITY_MARK_A__SHIFT             0x00000000
+#define PRIORITY_A_CNT__PRIORITY_A_OFF_MASK                0x00010000L
+#define	PRIORITY_A_CNT__PRIORITY_A_OFF__SHIFT              0x00000010
+#define PRIORITY_A_CNT__PRIORITY_A_ALWAYS_ON_MASK          0x00100000L
+#define	PRIORITY_A_CNT__PRIORITY_A_ALWAYS_ON__SHIFT        0x00000014
+#define PRIORITY_A_CNT__PRIORITY_A_FORCE_MASK_MASK         0x01000000L
+#define	PRIORITY_A_CNT__PRIORITY_A_FORCE_MASK__SHIFT       0x00000018
+
+// PRIORITY_B_CNT
+#define PRIORITY_B_CNT__PRIORITY_MARK_B_MASK               0x00007fffL
+#define	PRIORITY_B_CNT__PRIORITY_MARK_B__SHIFT             0x00000000
+#define PRIORITY_B_CNT__PRIORITY_B_OFF_MASK                0x00010000L
+#define	PRIORITY_B_CNT__PRIORITY_B_OFF__SHIFT              0x00000010
+#define PRIORITY_B_CNT__PRIORITY_B_ALWAYS_ON_MASK          0x00100000L
+#define	PRIORITY_B_CNT__PRIORITY_B_ALWAYS_ON__SHIFT        0x00000014
+#define PRIORITY_B_CNT__PRIORITY_B_FORCE_MASK_MASK         0x01000000L
+#define	PRIORITY_B_CNT__PRIORITY_B_FORCE_MASK__SHIFT       0x00000018
+
+// VLINE_STATUS
+#define VLINE_STATUS__VLINE_OCCURRED_MASK                  0x00000001L
+#define	VLINE_STATUS__VLINE_OCCURRED__SHIFT                0x00000000
+#define VLINE_STATUS__VLINE_ACK_MASK                       0x00000010L
+#define	VLINE_STATUS__VLINE_ACK__SHIFT                     0x00000004
+#define VLINE_STATUS__VLINE_STAT_MASK                      0x00001000L
+#define	VLINE_STATUS__VLINE_STAT__SHIFT                    0x0000000c
+#define VLINE_STATUS__VLINE_INTERRUPT_MASK                 0x00010000L
+#define	VLINE_STATUS__VLINE_INTERRUPT__SHIFT               0x00000010
+#define VLINE_STATUS__VLINE_INTERRUPT_TYPE_MASK            0x00020000L
+#define	VLINE_STATUS__VLINE_INTERRUPT_TYPE__SHIFT          0x00000011
+
+// VBLANK_STATUS
+#define VBLANK_STATUS__VBLANK_OCCURRED_MASK                0x00000001L
+#define	VBLANK_STATUS__VBLANK_OCCURRED__SHIFT              0x00000000
+#define VBLANK_STATUS__VBLANK_ACK_MASK                     0x00000010L
+#define	VBLANK_STATUS__VBLANK_ACK__SHIFT                   0x00000004
+#define VBLANK_STATUS__VBLANK_STAT_MASK                    0x00001000L
+#define	VBLANK_STATUS__VBLANK_STAT__SHIFT                  0x0000000c
+#define VBLANK_STATUS__VBLANK_INTERRUPT_MASK               0x00010000L
+#define	VBLANK_STATUS__VBLANK_INTERRUPT__SHIFT             0x00000010
+#define VBLANK_STATUS__VBLANK_INTERRUPT_TYPE_MASK          0x00020000L
+#define	VBLANK_STATUS__VBLANK_INTERRUPT_TYPE__SHIFT        0x00000011
+
+
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
