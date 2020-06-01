Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA7FC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676852073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy8vxRfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676852073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275966E342;
	Mon,  1 Jun 2020 18:22:20 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6926E343
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:18 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id z9so467740qvi.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aB3FfBqv3uxgXrwo46MMvasVsWssW6wDhihl8qXEWLk=;
 b=cy8vxRfzWk+YOHvJw3sQrt0kjaK4ib7iOt8UvmR/5uDe7pOixDVt1TqlC9rD8v227y
 YlbPaJLxqAuUFslL2kngUXqZGVw85fxIsV/CXpOiAS7Mer46cG6n1aNGhIkZC607IHls
 JRg4HZOQX+Z9ia7fuCIq++CFo8ds69Yq8ux6M4N2vDj8lFCh8OIWYQtxJZPEFgYdKudH
 CscQRs1iCO0SmLpyzwtgKbjqGcyH64xcUkzQk1X2A2AfxuzXFDdKYx7ZMDa8LSve0gin
 8nQjvp9RVOcbh+wPGNSZMCmIIyh4C2bB9EX/INJCGU9UbkwrnaNLXbyfEtmshjoW82tF
 3STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aB3FfBqv3uxgXrwo46MMvasVsWssW6wDhihl8qXEWLk=;
 b=WRzm1oZp+Rzvfu6AsgvfOqnzBi4hgXPD+m9Iyn9yhD6fbS4qe6HnLhGvlWVsi/HEFB
 JN8fvwQfF2GIWJaItgN2u5V4HxR21RdmtHzBYv1GOgYGy5fGzZVrKxxD2q7oTy4+RrQL
 zx8U+ZPQ0ua7uKtD7wFMYWQ5ZsTr9kyQIl3ca2TIO1wzEEeoE5T1pFZ8d57HxFSptVoI
 2bhX41URQf8MyToQFlhr+dAeQetwqDJ0n+oswo+mR5xfxAiL2Fr6Xo7tUSQs0+4akSrd
 J7sPCVnxlVO1HsEXW8XQflT2AEoPDBggQBO6Bc109NPW4OY/DiTYsTy198srVz6ME5WT
 nQfg==
X-Gm-Message-State: AOAM530Jnwm8tLbqEZSpxq8Tic/rRsIW5irb7ZxFySkUiSiNoEH6WtOw
 MMC1EsFJEdVLjMBdLDtAM4dNJbsN
X-Google-Smtp-Source: ABdhPJwhyA+e9qQOqpJzuXgcmJk/pwEv3Cbql/ljdBUrpA5QalZ2oVZf9FRa9sCeoqatR8GmpXxlaA==
X-Received: by 2002:a0c:c2c2:: with SMTP id c2mr21031527qvi.150.1591035737550; 
 Mon, 01 Jun 2020 11:22:17 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 146/207] drm/amdgpu: add internal reg offset translation for
 VCN inst 1
Date: Mon,  1 Jun 2020 14:19:53 -0400
Message-Id: <20200601182054.1267858-57-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, James Zhu <james.zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add range for vcn instance 1 for translation for internal register offset, which
is needed for VCN3.0

V2: update description.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 7a2d5f8d1247..25a07704cf75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -53,7 +53,9 @@
 #define VCN_ENC_CMD_REG_WAIT		0x0000000c
 
 #define VCN_VID_SOC_ADDRESS_2_0 	0x1fa00
+#define VCN1_VID_SOC_ADDRESS_3_0 	0x48200
 #define VCN_AON_SOC_ADDRESS_2_0 	0x1f800
+#define VCN1_AON_SOC_ADDRESS_3_0 	0x48000
 #define VCN_VID_IP_ADDRESS_2_0		0x0
 #define VCN_AON_IP_ADDRESS_2_0		0x30000
 
@@ -89,20 +91,30 @@
 #define SOC15_DPG_MODE_OFFSET_2_0(ip, inst_idx, reg) 						\
 	({											\
 		uint32_t internal_reg_offset, addr;						\
-		bool video_range, aon_range;							\
+		bool video_range, video1_range, aon_range, aon1_range;				\
 												\
 		addr = (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg);		\
 		addr <<= 2; 									\
 		video_range = ((((0xFFFFF & addr) >= (VCN_VID_SOC_ADDRESS_2_0)) && 		\
 				((0xFFFFF & addr) < ((VCN_VID_SOC_ADDRESS_2_0 + 0x2600)))));	\
+		video1_range = ((((0xFFFFF & addr) >= (VCN1_VID_SOC_ADDRESS_3_0)) && 		\
+				((0xFFFFF & addr) < ((VCN1_VID_SOC_ADDRESS_3_0 + 0x2600)))));	\
 		aon_range   = ((((0xFFFFF & addr) >= (VCN_AON_SOC_ADDRESS_2_0)) && 		\
 				((0xFFFFF & addr) < ((VCN_AON_SOC_ADDRESS_2_0 + 0x600)))));	\
+		aon1_range   = ((((0xFFFFF & addr) >= (VCN1_AON_SOC_ADDRESS_3_0)) && 		\
+				((0xFFFFF & addr) < ((VCN1_AON_SOC_ADDRESS_3_0 + 0x600)))));	\
 		if (video_range) 								\
 			internal_reg_offset = ((0xFFFFF & addr) - (VCN_VID_SOC_ADDRESS_2_0) + 	\
 				(VCN_VID_IP_ADDRESS_2_0));					\
 		else if (aon_range)								\
 			internal_reg_offset = ((0xFFFFF & addr) - (VCN_AON_SOC_ADDRESS_2_0) + 	\
 				(VCN_AON_IP_ADDRESS_2_0));					\
+		else if (video1_range) 								\
+			internal_reg_offset = ((0xFFFFF & addr) - (VCN1_VID_SOC_ADDRESS_3_0) + 	\
+				(VCN_VID_IP_ADDRESS_2_0));					\
+		else if (aon1_range)								\
+			internal_reg_offset = ((0xFFFFF & addr) - (VCN1_AON_SOC_ADDRESS_3_0) + 	\
+				(VCN_AON_IP_ADDRESS_2_0));					\
 		else										\
 			internal_reg_offset = (0xFFFFF & addr);					\
 												\
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
