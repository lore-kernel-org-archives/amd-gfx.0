Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA561C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBFD207EA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF2YHZZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBFD207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B0A6E489;
	Wed,  2 Sep 2020 18:16:52 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D876E489
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:16:51 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id f2so620424qkh.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sLe8CXok0eUAosB2JJjXFIdRUcmoyLkaa2DBF+c/3bs=;
 b=AF2YHZZqsC3WLwdWJXpQU2W5OEXULrhwsJ9ffDcQ9sESvdbGsXCAppn6EJwB+dULSi
 6lSKGitNpid46o+uzhj+KTrgRCCrteTpDs3sKVf+MZgycim4gEXc6tBpXTjM0Cli2522
 wzIwFtnUeUnNOlr/07k39qWYgsUSPn9IkI/xE11EewwVqWiyqcQk/h7wUDCCJqKjBnbk
 o6JYpZ6syakB8QEz8P3NcTqF4QQfrP+7Fuz6QI92EiGuvhAQQCzw/Sb8hu0DLPloil7x
 acwHctgGaHWyHm3Q3nvFzooe6S9pt0XOkZlpUuRGt4gHqB9eEKXZXcnbBseUlKQXB61L
 KztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sLe8CXok0eUAosB2JJjXFIdRUcmoyLkaa2DBF+c/3bs=;
 b=BQ5Rc7XjbnavIOeLwyfCk2mE8NCsj43L4pjswyBkk6VlvCnxXFyUYQF/XZVWQmyYob
 cTpXL2WmEL6pFbc++MnEIBex/ztXy/+Z0QrVKW2oci7n+2sg+cLwG5n2hdF3HU4LNXp4
 Lz1bhQgTPpLe0YBPQN7u+lxuYEarxTlHas7HTOWwojsn3fQVGhC+Pi+tX3mHfa8IiIWe
 IfRfrorziOife+gQc5Dwpl6+3nioVDJNK9hetD1BIjbeW/Gw/DG3yzzPjjqEfpDCt950
 oJe0eqRlXtsgsfBM36fwklkfNdga1l8NYbSfrY57FxMGOpVeE498QRn7qHQeyv0hiKs+
 j9bQ==
X-Gm-Message-State: AOAM5316mjscTziqzDWUy0iyzThwrJsfNjOE7wp9XqZdb9YG6C5KCZYI
 u0/iYcqvQpCupIAMoz+Ny2jFL91CRnU=
X-Google-Smtp-Source: ABdhPJwrp2aQaHok9B+TsCUobmDvum86fKouE3tL9n4X+zOP/pBi1H652r/ObgaVSJOZBsTk4BRDMw==
X-Received: by 2002:a05:620a:128c:: with SMTP id
 w12mr2887344qki.355.1599070610442; 
 Wed, 02 Sep 2020 11:16:50 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id l19sm160569qtu.16.2020.09.02.11.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 11:16:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/mmhub2.0: print client id string for mmhub
Date: Wed,  2 Sep 2020 14:16:40 -0400
Message-Id: <20200902181640.1559269-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200902181640.1559269-1-alexander.deucher@amd.com>
References: <20200902181640.1559269-1-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 88 +++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 5baf899417d8..2d88278c50bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -36,6 +36,63 @@
 #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid                       0x0070
 #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid_BASE_IDX              0
 
+static const char *mmhub_client_ids_navi1x[][2] = {
+	[3][0] = "DCEDMC",
+	[4][0] = "DCEVGA",
+	[5][0] = "MP0",
+	[6][0] = "MP1",
+	[13][0] = "VMC",
+	[14][0] = "HDP",
+	[15][0] = "OSS",
+	[16][0] = "VCNU",
+	[17][0] = "JPEG",
+	[18][0] = "VCN",
+	[3][1] = "DCEDMC",
+	[4][1] = "DCEXFC",
+	[5][1] = "DCEVGA",
+	[6][1] = "DCEDWB",
+	[7][1] = "MP0",
+	[8][1] = "MP1",
+	[9][1] = "DBGU1",
+	[10][1] = "DBGU0",
+	[11][1] = "XDP",
+	[14][1] = "HDP",
+	[15][1] = "OSS",
+	[16][1] = "VCNU",
+	[17][1] = "JPEG",
+	[18][1] = "VCN",
+};
+
+static const char *mmhub_client_ids_sienna_cichlid[][2] = {
+	[3][0] = "DCEDMC",
+	[4][0] = "DCEVGA",
+	[5][0] = "MP0",
+	[6][0] = "MP1",
+	[8][0] = "VMC",
+	[9][0] = "VCNU0",
+	[10][0] = "JPEG",
+	[12][0] = "VCNU1",
+	[13][0] = "VCN1",
+	[14][0] = "HDP",
+	[15][0] = "OSS",
+	[32+11][0] = "VCN0",
+	[0][1] = "DBGU0",
+	[1][1] = "DBGU1",
+	[2][1] = "DCEDWB",
+	[3][1] = "DCEDMC",
+	[4][1] = "DCEVGA",
+	[5][1] = "MP0",
+	[6][1] = "MP1",
+	[7][1] = "XDP",
+	[9][1] = "VCNU0",
+	[10][1] = "JPEG",
+	[11][1] = "VCN0",
+	[12][1] = "VCNU1",
+	[13][1] = "VCN1",
+	[14][1] = "HDP",
+	[15][1] = "OSS",
+};
+
 static uint32_t mmhub_v2_0_get_invalidate_req(unsigned int vmid,
 					      uint32_t flush_type)
 {
@@ -60,12 +117,33 @@ static void
 mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
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
+	case CHIP_NAVI10:
+	case CHIP_NAVI12:
+	case CHIP_NAVI14:
+		mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
+		break;
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
+		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
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
@@ -78,9 +156,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
-		REG_GET_FIELD(status,
-		MMVM_L2_PROTECTION_FAULT_STATUS, RW));
+	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
