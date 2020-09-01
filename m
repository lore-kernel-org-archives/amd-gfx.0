Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D47C433E7
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 21:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD52206FA
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 21:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He5Mes8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD52206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8446E2D8;
	Tue,  1 Sep 2020 21:51:43 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669B26E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 21:51:42 +0000 (UTC)
Received: by mail-il1-x12f.google.com with SMTP id c6so3055219ilo.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2020 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j3Jkb0ObNA7JngbzE05gdORXOw/3zumKnZ+u95KWMts=;
 b=He5Mes8IPjOMiLTMyFpSgs20S47KI3uXZMyr/0tFCSjOSgpPnHu/dhItDotC9dnTz4
 n08IZi8Ih/bUwe2jfY68Oak5hlUFd6kjiwmFdbzoKeldqCQ8YW4V81B6AWJtPzgOpL5v
 RMRzcXVvRsF96/2fcGVsNsSDc/DJ48MzAvb8Fs+2MnNx2+WofiRVSqjKcE24FZ217FM4
 pQW8sXpfrgrQpjQm4agqTn2vNqdOGYt8iSDGgGGpDLlK/T9MFj/pUkVpNn/EIIZ8eIgJ
 QpEF8zEf6lKa3N9Cf9yjY/uPFSvevsAwpjB1iHAfu+HpiSxaRlk1E/S+gKqxq0uuiGlL
 IP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j3Jkb0ObNA7JngbzE05gdORXOw/3zumKnZ+u95KWMts=;
 b=Hscj4/aPw7+SZlSqFwS2MfWXC4hJhhQ5pTLbTNZ/gvrU4Xlacgpo3eq77SWentaD+W
 ru+fI72+7sMbU5Gts7V19OYAqB5WzzsAFRRAk4c15IqF83g5T9y4DwG7J6WVJj94uUBx
 3S2JRG1ZGFKtbrLbtBiCY9ifEYkLRuQaPHwf9AdbWj2qc+QZ1yQYIu0zPFiEFNhjV3I/
 pCkVMvgSM41HtGy7XrlUd/8LkrUGCxyTXjVn3ZYs+FLrCF8MobDHfhQv6/GXP7kYn7kF
 HY20R8s4euURwYx1aA3tLDCiO946Wnf6UQexDTGo2UCPf2nvCsF2GfymB1VicqdGdYbK
 9+UQ==
X-Gm-Message-State: AOAM5338styrYsQB6lDJ4gg0SdPfeYd2avyBZVCj1mz0lNYTY1JFT3UD
 Umya3XkruNccmn+MnUq9AWoUVi425wA=
X-Google-Smtp-Source: ABdhPJzEtAROhbTIMBXsuAZbrUiiyG++ctpqNAVSCde6yFMI8nprtirfrV/K3lQiDpJ4NQyvx5X2mA==
X-Received: by 2002:a92:894a:: with SMTP id n71mr849816ild.253.1598997101564; 
 Tue, 01 Sep 2020 14:51:41 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id w26sm1196711ili.34.2020.09.01.14.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 14:51:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gmc10: print client id string for gfxhub
Date: Tue,  1 Sep 2020 17:51:25 -0400
Message-Id: <20200901215125.1402033-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200901215125.1402033-1-alexander.deucher@amd.com>
References: <20200901215125.1402033-1-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 30 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 30 +++++++++++++++++++++---
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 76acd7f7723e..b882ac59879a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -31,6 +31,27 @@
 
 #include "soc15_common.h"
 
+static const char *gfxhub_client_ids[] = {
+	"CB/DB",
+	"Reserved",
+	"GE1",
+	"GE2",
+	"CPF",
+	"CPC",
+	"CPG",
+	"RLC",
+	"TCP",
+	"SQC (inst)",
+	"SQC (data)",
+	"SQG",
+	"Reserved",
+	"SDMA0",
+	"SDMA1",
+	"GCR",
+	"SDMA2",
+	"SDMA3",
+};
+
 static uint32_t gfxhub_v2_0_get_invalidate_req(unsigned int vmid,
 					       uint32_t flush_type)
 {
@@ -55,12 +76,15 @@ static void
 gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
 {
+	u32 cid = REG_GET_FIELD(status,
+				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
+
 	dev_err(adev->dev,
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
-		REG_GET_FIELD(status,
-		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
+		cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 80c906a0383f..237a9ff5afa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -31,6 +31,27 @@
 
 #include "soc15_common.h"
 
+static const char *gfxhub_client_ids[] = {
+	"CB/DB",
+	"Reserved",
+	"GE1",
+	"GE2",
+	"CPF",
+	"CPC",
+	"CPG",
+	"RLC",
+	"TCP",
+	"SQC (inst)",
+	"SQC (data)",
+	"SQG",
+	"Reserved",
+	"SDMA0",
+	"SDMA1",
+	"GCR",
+	"SDMA2",
+	"SDMA3",
+};
+
 static uint32_t gfxhub_v2_1_get_invalidate_req(unsigned int vmid,
 					       uint32_t flush_type)
 {
@@ -55,12 +76,15 @@ static void
 gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
 {
+	u32 cid = REG_GET_FIELD(status,
+				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
+
 	dev_err(adev->dev,
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
-		REG_GET_FIELD(status,
-		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
+		cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
