Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2FEC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107E02064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9dRe1A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107E02064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923596E964;
	Wed,  7 Oct 2020 16:32:31 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CA36E23D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:30 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id ev17so1489484qvb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sgzHw1sIjB9q7OEC6p9VnDsqUJgxjZhqo1qcG2TbRwA=;
 b=Q9dRe1A5c/JEQOQMipu0lore7jbBEQDXSPTcnL7TGgP3QlaNrviWMQ5DddCgXsku+X
 5RCfLHhvGAz9Ol+aXY7C7Mm8M7bVKjkgk7g43SVjDLUcN2nZlkwoRkNlAbkk4WOHkbqi
 x1Pyx5+2C9PdrF5kXGSX22dMLthq9OfrhBMVl+/9M4YpWoR8txsjFUxU5xxTtrxjEaLb
 ICFgf93+oLDmvVqkuO7xf5NayQHfrB0lCiadia2/6B5bpsJ2hVIfV2/DSccjch3VkuNB
 GIJKfbKGUhgN2NWuGi1Ol3Q4SfCPA7xKFWP5mpAkE/Yi9/yxMu1qb959RCUbigr1MeM3
 tT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sgzHw1sIjB9q7OEC6p9VnDsqUJgxjZhqo1qcG2TbRwA=;
 b=Tu5QeFT1AM+czQ5TV9iaPmH+Ks5SRld6jSaXugGoai8nVaVBSSmMz3l9vbcaFRDPrA
 NehB5uk0VXZM2UCck/9Kil6QmwQBRKfi2Lu5YzD+Pp2ihO8luFztuRNam0C7S1aBxgiJ
 1B/LoNPLT/KSWlOaNDy1LdM4oWnIKq62Oxfvl25g3XLA7+g9XLs8/0udHqqeDL1oEE1n
 dCdL6lBLrEIGIkXYFSF28iO4V89HMjKorLmylfsncX75TV5YGtc7VWXzH09GRyRvURh1
 XsHmAQu5ixCotwtHGlPT7hrqI4TZSCvDf2zVDvM0OLh95t8Zvf+usWkj2muBKsmF1SfN
 Hp/Q==
X-Gm-Message-State: AOAM5312dQ/FeTIy01ZW3O/WFfVBdhc8QlIiYiSHgGLnj7TB3r1oUo/p
 EadBOXss7z2/sdFM5mFlVS2Dnb5WMHQ=
X-Google-Smtp-Source: ABdhPJzDDSyVg/AZMVpgRa2m728nttONK8aGeqMi2KuyQ82/mTTeFyRcaGB+nDl0niazym2S73tDIQ==
X-Received: by 2002:a0c:abc7:: with SMTP id k7mr3836993qvb.45.1602088348664;
 Wed, 07 Oct 2020 09:32:28 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:28 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/50] drm/amdgpu: add gc golden setting for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:13 -0400
Message-Id: <20201007163135.1944186-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add gc golden setting for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Tested-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d4da6c647059..8256e135fff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3221,6 +3221,43 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000000ff),
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0x30000000, 0x30000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0x7e000000, 0x7e000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0x00000280, 0x00000280),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0x07800000, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x00001d00, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003c0000, 0x00280400),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0x40000000, 0x580f1008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0x00040000, 0x00f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0x01000000, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_CONFIG, 0x0000001f, 0x00180070),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER0_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER1_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER10_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER11_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER12_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER13_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER14_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER15_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER2_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER3_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER4_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER5_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER6_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x01030000, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -3433,6 +3470,11 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_10_3_vangogh,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_vangogh));
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		soc15_program_register_sequence(adev,
+                                                golden_settings_gc_10_3_4,
+                                                (const u32)ARRAY_SIZE(golden_settings_gc_10_3_4));
+		break;
 	default:
 		break;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
