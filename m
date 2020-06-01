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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6457C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855022073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwjdONHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855022073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4211A6E2E5;
	Mon,  1 Jun 2020 18:21:11 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7296E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:10 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id i68so8489395qtb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ho2OcPr7ZOg4w3VnDEAcfrKo42YucR5wRJQ/zPRlKZY=;
 b=QwjdONHMWR3VZQpaOUdw3ZKdjzJ0wwa6xET8rqsu/UnnSvbjgjNNjqywFQOTZksOuq
 AETdhZ8IY46xxACUhJVlQin4UA3/s6bqWZkFPRGCQKJkqie2lyffJOmiPCzB0rKf1Z+O
 kEfHha2IHJ3x9RwMorY27pkxHsTFubtb63USVk0c95PcDTbyks4/gVil4TlzLZbG8ODQ
 u2Uk6x5yIRUn++Ri9rpYQuW5Ksa3IRWb/OtwLpWqXIIBt9ymPKkE6bpBPBMHaBZIF+wD
 jupaYnNvqn97YnKJ+Ytb5EL4RIQt592MGAaF3SXYHpDz7MvGSAWL6ikXoCggv1AGGHwB
 GoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ho2OcPr7ZOg4w3VnDEAcfrKo42YucR5wRJQ/zPRlKZY=;
 b=P2zHn9jxGEtLOasUBiEHKYHVaUbFEATmFDXFh7ONA+cMe9Li/QdU8D9x9iCF4QgM23
 B0a5nxF4uAqDuDfwYGjXDwB6CZ7exJFexsnxd4Ka5R+sxwDVn1L1gYleYbHe8Hpy9w3V
 Kij0DPe25mdvtOv1/qiHvnCyoRFfVBMaKGBUen4WeNR64yaiJND8EIG5TZED4JR7wTZD
 AuWTmEqmBcZhJ2En5pmZtAHsDeD/lAAjOv5kEMiMg6hQWCnlKbHqWAyOz0XksKcTybl3
 z8vFHqSAqnovALxaZg0oQHb8svUZoLL7vl3vDNAa/18uO0H+m6b44MWlGy6F1NMXxCOv
 qXwQ==
X-Gm-Message-State: AOAM530+NMNu6snJhcdNgOkRQ0vFsLOR3q76PR3StMCr87mCDfM/LGCH
 87MuceTOwTifN0c8/FiI8FtzEvyN
X-Google-Smtp-Source: ABdhPJw2IlxZ0XCsbsUE1zh4wDdQRtDOo/xDGvI3Ki0PrHHajfsDuteETHl4Cipp0jZD8VKiTW7Gdw==
X-Received: by 2002:a37:845:: with SMTP id 66mr20757838qki.67.1591035668286;
 Mon, 01 Jun 2020 11:21:08 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:07 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 093/207] drm/amdgpu: add cp firmware backdoor loading triger
Date: Mon,  1 Jun 2020 14:19:00 -0400
Message-Id: <20200601182054.1267858-4-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Triger CP ucode addr and data to backdoor load CP firmware.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 66d7ae456768..b62c755dff21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -98,6 +98,19 @@
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid			0x1580
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid_BASE_IDX	0
 
+#define mmCP_HYP_PFP_UCODE_ADDR			0x5814
+#define mmCP_HYP_PFP_UCODE_ADDR_BASE_IDX	1
+#define mmCP_HYP_PFP_UCODE_DATA			0x5815
+#define mmCP_HYP_PFP_UCODE_DATA_BASE_IDX	1
+#define mmCP_HYP_CE_UCODE_ADDR			0x5818
+#define mmCP_HYP_CE_UCODE_ADDR_BASE_IDX		1
+#define mmCP_HYP_CE_UCODE_DATA			0x5819
+#define mmCP_HYP_CE_UCODE_DATA_BASE_IDX		1
+#define mmCP_HYP_ME_UCODE_ADDR			0x5816
+#define mmCP_HYP_ME_UCODE_ADDR_BASE_IDX		1
+#define mmCP_HYP_ME_UCODE_DATA			0x5817
+#define mmCP_HYP_ME_UCODE_DATA_BASE_IDX		1
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -5393,6 +5406,14 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_HI,
 		upper_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
 
+	WREG32_SOC15(GC, 0, mmCP_HYP_PFP_UCODE_ADDR, 0);
+
+	for (i = 0; i < pfp_hdr->jt_size; i++)
+		WREG32_SOC15(GC, 0, mmCP_HYP_PFP_UCODE_DATA,
+			     le32_to_cpup(fw_data + pfp_hdr->jt_offset + i));
+
+	WREG32_SOC15(GC, 0, mmCP_HYP_PFP_UCODE_ADDR, adev->gfx.pfp_fw_version);
+
 	return 0;
 }
 
@@ -5462,6 +5483,14 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_HI,
 		upper_32_bits(adev->gfx.ce.ce_fw_gpu_addr));
 
+	WREG32_SOC15(GC, 0, mmCP_HYP_CE_UCODE_ADDR, 0);
+
+	for (i = 0; i < ce_hdr->jt_size; i++)
+		WREG32_SOC15(GC, 0, mmCP_HYP_CE_UCODE_DATA,
+			     le32_to_cpup(fw_data + ce_hdr->jt_offset + i));
+
+	WREG32_SOC15(GC, 0, mmCP_HYP_CE_UCODE_ADDR, adev->gfx.ce_fw_version);
+
 	return 0;
 }
 
@@ -5531,6 +5560,14 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_HI,
 		upper_32_bits(adev->gfx.me.me_fw_gpu_addr));
 
+	WREG32_SOC15(GC, 0, mmCP_HYP_ME_UCODE_ADDR, 0);
+
+	for (i = 0; i < me_hdr->jt_size; i++)
+		WREG32_SOC15(GC, 0, mmCP_HYP_ME_UCODE_DATA,
+			     le32_to_cpup(fw_data + me_hdr->jt_offset + i));
+
+	WREG32_SOC15(GC, 0, mmCP_HYP_ME_UCODE_ADDR, adev->gfx.me_fw_version);
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
