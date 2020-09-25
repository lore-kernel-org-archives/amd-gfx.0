Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3144BC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EE123A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbRD46It"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EE123A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734B56ED53;
	Fri, 25 Sep 2020 20:11:55 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83C76ED7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:51 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id g72so4096607qke.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nv4TGwIQfWN7FY0Edm+YyPsB6XDO7SBYGm4hURGHzHg=;
 b=lbRD46Its12WTx8QMSeZu6h1MDkY9a/99CyONrJdmcbMBtWUIkGBcgdlxwxlcYmPs2
 1DCzlcxymBxfTGWE2RhBpUAoR+MtlCc1C/br8bI+UWLui2kopaJhFcmt/rMEVBBbsJZr
 jbctzmUi3TiMODhfG6Vm4D0QIQJcEDSLPhsYepiovuAe332zEnWKszzg8LzgiNejLDbz
 I47GqqiHZJWlb4g2wv7SxNxfGJG2E7wzNlokaHbMdM2XoON3Xt5K13DDGTO/A/gPVe8s
 p3OHlIDuecrF/aMIOpLnJrMhDbDbPAXbsECTjKmiXBNU0RU+RBLCPxbW4Zzs0nTXJduy
 RPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nv4TGwIQfWN7FY0Edm+YyPsB6XDO7SBYGm4hURGHzHg=;
 b=gZY4Yt8KCugEQQLd9ytTBW9WfvQDAzDE29a6Z8IjfcUCvREeQ0p1ctVvaxAb7IBPjV
 sQfQn0s080IPr3JtQNU8bbi4HpSBpkbu6xWTrO5KeQiZ3yaWuEu5fLOoa0Vx4yx3594A
 tGfrIbNqA/mg+DcMU/+p0nvxs8W9xvFoeNF3ZIRWlR9zzxYD+gt1ZSqdiiCPz364Gm+I
 fT4CcXdw91K/9AaRhBYpxBj6Q6v0KQmOliHFFq9Yk8czRgwIjsq3zRejn7tIkMctswDo
 B6QbHntf8sv6IglsJfh3t1I1tuTAsa5mvkBFvsDFYxeWjelhgebzglKj6jx/lnnjiP/l
 tcYQ==
X-Gm-Message-State: AOAM533v5RpbSDEFh2d8+HZogK0J8DJF5uW/qsOXp8xRDyNlTbxrrGCL
 8iGdx9GosBGPNPPiuqSbKs32GazEmHM=
X-Google-Smtp-Source: ABdhPJzdfOGTZrV9k6/WSccCnHJKdQybPUWGzJiSG7pO6u+XGepxRyBLLdGtr0U9ppyGy8fzgkpcVA==
X-Received: by 2002:a37:9f95:: with SMTP id i143mr1572419qke.121.1601064710828; 
 Fri, 25 Sep 2020 13:11:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/45] drm/amdgpu/mmhub2.3: print client id string for mmhub
Date: Fri, 25 Sep 2020 16:10:24 -0400
Message-Id: <20200925201029.1738724-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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

Print the name of the client rather than the number.  This
makes it easier to debug what block is causing the fault.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 49 ++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index b39dc2023b5f..3a248c8cd0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -31,6 +31,30 @@
 
 #include "soc15_common.h"
 
+static const char *mmhub_client_ids_vangogh[][2] = {
+	[0][0] = "MP0",
+	[1][0] = "MP1",
+	[2][0] = "DCEDMC",
+	[3][0] = "DCEVGA",
+	[13][0] = "UTCL2",
+	[26][0] = "OSS",
+	[27][0] = "HDP",
+	[28][0] = "VCN",
+	[29][0] = "VCNU",
+	[30][0] = "JPEG",
+	[0][1] = "MP0",
+	[1][1] = "MP1",
+	[2][1] = "DCEDMC",
+	[3][1] = "DCEVGA",
+	[4][1] = "DCEDWB",
+	[5][1] = "XDP",
+	[26][1] = "OSS",
+	[27][1] = "HDP",
+	[28][1] = "VCN",
+	[29][1] = "VCNU",
+	[30][1] = "JPEG",
+};
+
 static uint32_t mmhub_v2_3_get_invalidate_req(unsigned int vmid,
 					      uint32_t flush_type)
 {
@@ -55,12 +79,27 @@ static void
 mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
 {
+	uint32_t cid, rw;
+	const char *mmhub_cid = NULL;
+
+	cid = REG_GET_FIELD(status,
+			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
+	rw = REG_GET_FIELD(status,
+			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
+
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
-		REG_GET_FIELD(status,
-		MMVM_L2_PROTECTION_FAULT_STATUS, CID));
+	switch (adev->asic_type) {
+	case CHIP_VANGOGH:
+		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
+		break;
+	default:
+		mmhub_cid = NULL;
+		break;
+	}
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
@@ -73,9 +112,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
-		REG_GET_FIELD(status,
-		MMVM_L2_PROTECTION_FAULT_STATUS, RW));
+	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v2_3_setup_vm_pt_regs(struct amdgpu_device *adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
