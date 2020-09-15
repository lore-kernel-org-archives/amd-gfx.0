Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B3C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5B0205F4
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXwC/1hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77A96E8D7;
	Tue, 15 Sep 2020 18:24:20 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C456E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:24:19 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id v54so3943726qtj.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0kZev1dsZ7gGeWUjgEKPYHM5vQxDwXYa5cDYxXBHVsU=;
 b=OXwC/1hDCGuxVuxt2jPp5rtU8urvFntsHoH0V2xtDe+ohMF+cNWQIQaHC/flYlhcfl
 X2NcdM+7XsUIdz/TaW49zjivUr4NFODUWSU7MNBXiJSXw8+8k6pPWdvGe3FyMTDeuVHh
 5vaLGeTd3YI4NdhpsrIOJsfuRNI6NKEC5A2vcGJfKP29SLrvMW7bxcSB1y7pe1kSOyZI
 CoVSpaDotP1upPOFhybRlvBRygI7JbemUtJ8mf5cPkzWsKZVu14Upr+wgGEEJexzVkfv
 kLm8nkLnAhmKxgI9dKsczds+lmpHxRDtAcKrIGOgcBZb8Uv8TTLQ8ePdjL0hRm7x7TeD
 X2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0kZev1dsZ7gGeWUjgEKPYHM5vQxDwXYa5cDYxXBHVsU=;
 b=lb7QjuFJwwHur1lnerhN75EbWQDOXANQQYV1z673ezkNf7iIJ0yktS+ePf9J8qjWuN
 To0Tpn2hYfimzMZZfqhsmwIB79CNnHIuxLPrRC7EsgEAW/l5jPLML6z6nky7TPuYphGQ
 jXPitnqFQ7L7lNWDuGsBluCw3PzkVDr6QSUcdEkrZQ4nAo9jYqCZx2T7YBzu6EY6FJrB
 4BYD1p19HvGj3QpSbtghzbo1SW0ORaEiqwIeqkbURTWYitw5HLDeKTu1UqOmvmJH2RO4
 tjpWC9R3Lf7qdjURZIZJ9hU/4zs5KTL6XborWQmqUhoj+U2LIuukMjREpq23hOQ4i2fk
 Jt/A==
X-Gm-Message-State: AOAM530KkGfkltIjtR6xhhTUsrBRAZ8UKf9iWUzcCtLPMQ8ien71+1FX
 fqa748wFTVRq1OM6jH9j607I35y5bcM=
X-Google-Smtp-Source: ABdhPJwpDVaKdvBaYpTcIl53tGxV8K1BNN4GpZftgpHX0KpJ0cBiJo24I4m3cNg5jsfOAVn549m7tg==
X-Received: by 2002:ac8:6e89:: with SMTP id c9mr18882312qtv.3.1600194258144;
 Tue, 15 Sep 2020 11:24:18 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id x126sm17318009qkb.101.2020.09.15.11.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 11:24:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: add VCN 3.0 AV1 registers
Date: Tue, 15 Sep 2020 14:24:07 -0400
Message-Id: <20200915182409.68727-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915182409.68727-1-alexander.deucher@amd.com>
References: <20200915182409.68727-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds the AV1 registers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/vcn/vcn_3_0_0_sh_mask.h  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h
index c0efd90808f2..58cf7adb9d54 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h
@@ -2393,6 +2393,7 @@
 #define VCN_FEATURES__HAS_MJPEG2_IDCT_DEC__SHIFT                                                              0x7
 #define VCN_FEATURES__HAS_SCLR_DEC__SHIFT                                                                     0x8
 #define VCN_FEATURES__HAS_VP9_DEC__SHIFT                                                                      0x9
+#define VCN_FEATURES__HAS_AV1_DEC__SHIFT                                                                      0xa
 #define VCN_FEATURES__HAS_EFC_ENC__SHIFT                                                                      0xb
 #define VCN_FEATURES__HAS_EFC_HDR2SDR_ENC__SHIFT                                                              0xc
 #define VCN_FEATURES__HAS_DUAL_MJPEG_DEC__SHIFT                                                               0xd
@@ -2407,6 +2408,7 @@
 #define VCN_FEATURES__HAS_MJPEG2_IDCT_DEC_MASK                                                                0x00000080L
 #define VCN_FEATURES__HAS_SCLR_DEC_MASK                                                                       0x00000100L
 #define VCN_FEATURES__HAS_VP9_DEC_MASK                                                                        0x00000200L
+#define VCN_FEATURES__HAS_AV1_DEC_MASK                                                                        0x00000400L
 #define VCN_FEATURES__HAS_EFC_ENC_MASK                                                                        0x00000800L
 #define VCN_FEATURES__HAS_EFC_HDR2SDR_ENC_MASK                                                                0x00001000L
 #define VCN_FEATURES__HAS_DUAL_MJPEG_DEC_MASK                                                                 0x00002000L
@@ -2809,8 +2811,10 @@
 #define UVD_SUVD_CGC_GATE__IME_HEVC__SHIFT                                                                    0x18
 #define UVD_SUVD_CGC_GATE__EFC__SHIFT                                                                         0x19
 #define UVD_SUVD_CGC_GATE__SAOE__SHIFT                                                                        0x1a
+#define UVD_SUVD_CGC_GATE__SRE_AV1__SHIFT                                                                     0x1b
 #define UVD_SUVD_CGC_GATE__FBC_PCLK__SHIFT                                                                    0x1c
 #define UVD_SUVD_CGC_GATE__FBC_CCLK__SHIFT                                                                    0x1d
+#define UVD_SUVD_CGC_GATE__SCM_AV1__SHIFT                                                                     0x1e
 #define UVD_SUVD_CGC_GATE__SMPA__SHIFT                                                                        0x1f
 #define UVD_SUVD_CGC_GATE__SRE_MASK                                                                           0x00000001L
 #define UVD_SUVD_CGC_GATE__SIT_MASK                                                                           0x00000002L
@@ -2839,8 +2843,10 @@
 #define UVD_SUVD_CGC_GATE__IME_HEVC_MASK                                                                      0x01000000L
 #define UVD_SUVD_CGC_GATE__EFC_MASK                                                                           0x02000000L
 #define UVD_SUVD_CGC_GATE__SAOE_MASK                                                                          0x04000000L
+#define UVD_SUVD_CGC_GATE__SRE_AV1_MASK                                                                       0x08000000L
 #define UVD_SUVD_CGC_GATE__FBC_PCLK_MASK                                                                      0x10000000L
 #define UVD_SUVD_CGC_GATE__FBC_CCLK_MASK                                                                      0x20000000L
+#define UVD_SUVD_CGC_GATE__SCM_AV1_MASK                                                                       0x40000000L
 #define UVD_SUVD_CGC_GATE__SMPA_MASK                                                                          0x80000000L
 //UVD_SUVD_CGC_STATUS
 #define UVD_SUVD_CGC_STATUS__SRE_VCLK__SHIFT                                                                  0x0
@@ -2873,6 +2879,8 @@
 #define UVD_SUVD_CGC_STATUS__IME_HEVC_DCLK__SHIFT                                                             0x1b
 #define UVD_SUVD_CGC_STATUS__EFC_DCLK__SHIFT                                                                  0x1c
 #define UVD_SUVD_CGC_STATUS__SAOE_DCLK__SHIFT                                                                 0x1d
+#define UVD_SUVD_CGC_STATUS__SRE_AV1_VCLK__SHIFT                                                              0x1e
+#define UVD_SUVD_CGC_STATUS__SCM_AV1_DCLK__SHIFT                                                              0x1f
 #define UVD_SUVD_CGC_STATUS__SRE_VCLK_MASK                                                                    0x00000001L
 #define UVD_SUVD_CGC_STATUS__SRE_DCLK_MASK                                                                    0x00000002L
 #define UVD_SUVD_CGC_STATUS__SIT_DCLK_MASK                                                                    0x00000004L
@@ -2903,6 +2911,8 @@
 #define UVD_SUVD_CGC_STATUS__IME_HEVC_DCLK_MASK                                                               0x08000000L
 #define UVD_SUVD_CGC_STATUS__EFC_DCLK_MASK                                                                    0x10000000L
 #define UVD_SUVD_CGC_STATUS__SAOE_DCLK_MASK                                                                   0x20000000L
+#define UVD_SUVD_CGC_STATUS__SRE_AV1_VCLK_MASK                                                                0x40000000L
+#define UVD_SUVD_CGC_STATUS__SCM_AV1_DCLK_MASK                                                                0x80000000L
 //UVD_SUVD_CGC_CTRL
 #define UVD_SUVD_CGC_CTRL__SRE_MODE__SHIFT                                                                    0x0
 #define UVD_SUVD_CGC_CTRL__SIT_MODE__SHIFT                                                                    0x1
@@ -2919,6 +2929,8 @@
 #define UVD_SUVD_CGC_CTRL__SMPA_MODE__SHIFT                                                                   0xc
 #define UVD_SUVD_CGC_CTRL__MPBE0_MODE__SHIFT                                                                  0xd
 #define UVD_SUVD_CGC_CTRL__MPBE1_MODE__SHIFT                                                                  0xe
+#define UVD_SUVD_CGC_CTRL__SIT_AV1_MODE__SHIFT                                                                0xf
+#define UVD_SUVD_CGC_CTRL__SDB_AV1_MODE__SHIFT                                                                0x10
 #define UVD_SUVD_CGC_CTRL__MPC1_MODE__SHIFT                                                                   0x11
 #define UVD_SUVD_CGC_CTRL__FBC_PCLK__SHIFT                                                                    0x1c
 #define UVD_SUVD_CGC_CTRL__FBC_CCLK__SHIFT                                                                    0x1d
@@ -2937,6 +2949,8 @@
 #define UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK                                                                     0x00001000L
 #define UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK                                                                    0x00002000L
 #define UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK                                                                    0x00004000L
+#define UVD_SUVD_CGC_CTRL__SIT_AV1_MODE_MASK                                                                  0x00008000L
+#define UVD_SUVD_CGC_CTRL__SDB_AV1_MODE_MASK                                                                  0x00010000L
 #define UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK                                                                     0x00020000L
 #define UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK                                                                      0x10000000L
 #define UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK                                                                      0x20000000L
@@ -3658,6 +3672,8 @@
 #define UVD_SUVD_CGC_STATUS2__SMPA_VCLK__SHIFT                                                                0x0
 #define UVD_SUVD_CGC_STATUS2__SMPA_DCLK__SHIFT                                                                0x1
 #define UVD_SUVD_CGC_STATUS2__MPBE1_DCLK__SHIFT                                                               0x3
+#define UVD_SUVD_CGC_STATUS2__SIT_AV1_DCLK__SHIFT                                                             0x4
+#define UVD_SUVD_CGC_STATUS2__SDB_AV1_DCLK__SHIFT                                                             0x5
 #define UVD_SUVD_CGC_STATUS2__MPC1_DCLK__SHIFT                                                                0x6
 #define UVD_SUVD_CGC_STATUS2__MPC1_SCLK__SHIFT                                                                0x7
 #define UVD_SUVD_CGC_STATUS2__MPC1_VCLK__SHIFT                                                                0x8
@@ -3666,6 +3682,8 @@
 #define UVD_SUVD_CGC_STATUS2__SMPA_VCLK_MASK                                                                  0x00000001L
 #define UVD_SUVD_CGC_STATUS2__SMPA_DCLK_MASK                                                                  0x00000002L
 #define UVD_SUVD_CGC_STATUS2__MPBE1_DCLK_MASK                                                                 0x00000008L
+#define UVD_SUVD_CGC_STATUS2__SIT_AV1_DCLK_MASK                                                               0x00000010L
+#define UVD_SUVD_CGC_STATUS2__SDB_AV1_DCLK_MASK                                                               0x00000020L
 #define UVD_SUVD_CGC_STATUS2__MPC1_DCLK_MASK                                                                  0x00000040L
 #define UVD_SUVD_CGC_STATUS2__MPC1_SCLK_MASK                                                                  0x00000080L
 #define UVD_SUVD_CGC_STATUS2__MPC1_VCLK_MASK                                                                  0x00000100L
@@ -3674,25 +3692,41 @@
 //UVD_SUVD_CGC_GATE2
 #define UVD_SUVD_CGC_GATE2__MPBE0__SHIFT                                                                      0x0
 #define UVD_SUVD_CGC_GATE2__MPBE1__SHIFT                                                                      0x1
+#define UVD_SUVD_CGC_GATE2__SIT_AV1__SHIFT                                                                    0x2
+#define UVD_SUVD_CGC_GATE2__SDB_AV1__SHIFT                                                                    0x3
 #define UVD_SUVD_CGC_GATE2__MPC1__SHIFT                                                                       0x4
 #define UVD_SUVD_CGC_GATE2__MPBE0_MASK                                                                        0x00000001L
 #define UVD_SUVD_CGC_GATE2__MPBE1_MASK                                                                        0x00000002L
+#define UVD_SUVD_CGC_GATE2__SIT_AV1_MASK                                                                      0x00000004L
+#define UVD_SUVD_CGC_GATE2__SDB_AV1_MASK                                                                      0x00000008L
 #define UVD_SUVD_CGC_GATE2__MPC1_MASK                                                                         0x00000010L
 //UVD_SUVD_INT_STATUS2
 #define UVD_SUVD_INT_STATUS2__SMPA_FUNC_INT__SHIFT                                                            0x0
 #define UVD_SUVD_INT_STATUS2__SMPA_ERR_INT__SHIFT                                                             0x5
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_FUNC_INT__SHIFT                                                         0x6
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_ERR_INT__SHIFT                                                          0xb
 #define UVD_SUVD_INT_STATUS2__SMPA_FUNC_INT_MASK                                                              0x0000001FL
 #define UVD_SUVD_INT_STATUS2__SMPA_ERR_INT_MASK                                                               0x00000020L
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_FUNC_INT_MASK                                                           0x000007C0L
+#define UVD_SUVD_INT_STATUS2__SDB_AV1_ERR_INT_MASK                                                            0x00000800L
 //UVD_SUVD_INT_EN2
 #define UVD_SUVD_INT_EN2__SMPA_FUNC_INT_EN__SHIFT                                                             0x0
 #define UVD_SUVD_INT_EN2__SMPA_ERR_INT_EN__SHIFT                                                              0x5
+#define UVD_SUVD_INT_EN2__SDB_AV1_FUNC_INT_EN__SHIFT                                                          0x6
+#define UVD_SUVD_INT_EN2__SDB_AV1_ERR_INT_EN__SHIFT                                                           0xb
 #define UVD_SUVD_INT_EN2__SMPA_FUNC_INT_EN_MASK                                                               0x0000001FL
 #define UVD_SUVD_INT_EN2__SMPA_ERR_INT_EN_MASK                                                                0x00000020L
+#define UVD_SUVD_INT_EN2__SDB_AV1_FUNC_INT_EN_MASK                                                            0x000007C0L
+#define UVD_SUVD_INT_EN2__SDB_AV1_ERR_INT_EN_MASK                                                             0x00000800L
 //UVD_SUVD_INT_ACK2
 #define UVD_SUVD_INT_ACK2__SMPA_FUNC_INT_ACK__SHIFT                                                           0x0
 #define UVD_SUVD_INT_ACK2__SMPA_ERR_INT_ACK__SHIFT                                                            0x5
+#define UVD_SUVD_INT_ACK2__SDB_AV1_FUNC_INT_ACK__SHIFT                                                        0x6
+#define UVD_SUVD_INT_ACK2__SDB_AV1_ERR_INT_ACK__SHIFT                                                         0xb
 #define UVD_SUVD_INT_ACK2__SMPA_FUNC_INT_ACK_MASK                                                             0x0000001FL
 #define UVD_SUVD_INT_ACK2__SMPA_ERR_INT_ACK_MASK                                                              0x00000020L
+#define UVD_SUVD_INT_ACK2__SDB_AV1_FUNC_INT_ACK_MASK                                                          0x000007C0L
+#define UVD_SUVD_INT_ACK2__SDB_AV1_ERR_INT_ACK_MASK                                                           0x00000800L
 
 
 // addressBlock: uvd0_ecpudec
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
