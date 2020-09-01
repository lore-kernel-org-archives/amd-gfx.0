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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF05C433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 21:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859A206FA
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 21:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+D2so40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0AC6E2D7;
	Tue,  1 Sep 2020 21:51:43 +0000 (UTC)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A5B6E2D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 21:51:41 +0000 (UTC)
Received: by mail-il1-x141.google.com with SMTP id y2so3071075ilp.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2020 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uiD5MudFz2YakdULVMcdmEnqj0aP9LMUriCX0TXFFjo=;
 b=S+D2so40vyQM99zKM8FIm2emp1ATYZJaSpYnGUzD7XilRB6imEGFz8WLWs+8fOsrgT
 s7bqGHNGS5KnuXeHcs69iatM4J8YoQvjvXBOaedsAoIGzbU87ExfC6Cler3sFJq3RoHE
 ZUrkMWhLl7cqgirojbzE9BQ8C2Ky93e4UJmCH02SUkrGWXlwaheTYDEtZnSb2KW8e+gH
 d09Q1R/i5R4RfKuAB1FQn+HFqJEru07lbzWNCdeWeMu+7dpJ5S8heaRYt//ul5KLWpVj
 j4Z7O7aomOIdPMyxkVW8bpvGQdrfUSBOuJnflmRj24gxte4KPYZmorCdryABAIl9GPal
 WzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uiD5MudFz2YakdULVMcdmEnqj0aP9LMUriCX0TXFFjo=;
 b=JcpDTvYSOpMuGNiEh6kBqnGDrs5UAbcrEKL4CyAmZRLS9P79mhDYn5poDHAIuzqNVc
 z2VJd105gh4bOMCOOelm4cidwlo8wJuzXGFgNlPqTiSngbk2/7R4LsVBRqkfWHQePY1n
 eECxuo1Rz7ol04erC+YL9kp5Zny8KU5vJldM0qt2SP7gWVu1cYhsCB8rFb9gDb88+hWH
 f7FS69Y7KLTeO8P7bo8Sy6+5G1wHTtSDFQtxL5ffEfeC5CasWsv9I6UDtU41KtlQHbCE
 3FLfWjFLda2Qa2ikTjYsQXuciFNlBMXJIlWO3ydSPuBNqumJXnCr0RX0UFRKj9OmU4Q+
 jeRg==
X-Gm-Message-State: AOAM532+nRKI5AwDoSkI18Srk91XCW+rBXp6BzBouGnSK+7wYRtW/Eei
 nrH7zSUsT8Rz4ufZlRATwvmnC5Bkj4I=
X-Google-Smtp-Source: ABdhPJw99grqJd7ZG/dqItidgmYeeT33mxAOtEIEbERRZOMZCw7O4ELB+BK4tXzCXgf8txv0vOkz+g==
X-Received: by 2002:a92:cbc1:: with SMTP id s1mr952579ilq.248.1598997100574;
 Tue, 01 Sep 2020 14:51:40 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id w26sm1196711ili.34.2020.09.01.14.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 14:51:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gmc9: print client id string for gfxhub
Date: Tue,  1 Sep 2020 17:51:24 -0400
Message-Id: <20200901215125.1402033-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 30 +++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1ca79030e95e..7e86aee60c64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -71,6 +71,22 @@
 #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX                                                         2
 
 
+static const char *gfxhub_client_ids[] = {
+	"CB",
+	"DB",
+	"IA",
+	"WD",
+	"CPF",
+	"CPC",
+	"CPG",
+	"RLC",
+	"TCP",
+	"SQC (inst)",
+	"SQC (data)",
+	"SQG",
+	"PA",
+};
+
 static const u32 golden_settings_vega10_hdp[] =
 {
 	0xf64, 0x0fffffff, 0x00000000,
@@ -303,7 +319,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 {
 	struct amdgpu_vmhub *hub;
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
-	uint32_t status = 0;
+	uint32_t status = 0, cid = 0;
 	u64 addr;
 	char hub_name[10];
 
@@ -340,6 +356,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			RREG32(hub->vm_l2_pro_fault_status);
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
+		cid = REG_GET_FIELD(status,
+				    VM_L2_PROTECTION_FAULT_STATUS, CID);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 	}
 
@@ -362,9 +380,13 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			dev_err(adev->dev,
 				"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 				status);
-			dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
-				REG_GET_FIELD(status,
-				VM_L2_PROTECTION_FAULT_STATUS, CID));
+			if (hub == &adev->vmhub[AMDGPU_GFXHUB_0])
+				dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+					cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
+					cid);
+			else
+				dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%x\n",
+					cid);
 			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 				REG_GET_FIELD(status,
 				VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
