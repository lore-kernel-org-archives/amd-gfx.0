Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA602C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814A6610CB
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814A6610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5536EE09;
	Fri,  2 Apr 2021 06:44:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7001E6EE09
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJG1wLOr+73IBQxEFURJo4jOZFh2nNWTK5shCQ+wfXeMhCKMMU/t2Hrgvb9nPq1Yh+sqPrZOX/L8i2N8y4kuGWg+YPdwWue0v+vcn1gwHS8uW+s1KcEHMIvbtxlpjJMpe1pAoZTshIsYx2TSJovT94E3YVgJCC/WU5HUgaAdJzxnNyv6iuOPy+24Enf3Fxy7KVJ7qSC55uCENAuUrj2EKQifs33bGZefaofksqYr6/0quE61I5PRXZ6crpYV0yHoprAd9jY25O8CvWhA9eXRIfcR9LqJLLlyioNgRz7av97fMa+xqmrqdIlfG/01OYOU1qyxaZrYMI86m1+2CdiM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSv29jQ4A3sx35Lm/Ek5E6y2EBeKc3x5g4VUGZ+ET7w=;
 b=dAJy6wqc2grExUynUpQ/9eQAwsCrpCvYd0THyfbXNDU8UBqTWDt8ArOWL8c1zcqGgvXJVmkUhwu206aeDNXztf52C6gJH2pIPqhgo6UfpOpPBKe8GORXcuarEu5nPUoCyvXDGcPO6gk5SK749mhFzPlhAKTlzk/qLKBx8z5wjPomrJfmwVRgytCKc8oD8quwp2RZFStGBfYznhv7GCL8M+mWvXjexarX+/ZziMgL3kN8xNfjnL0FszLRNcoTVc5asz8eAOU0QK0/1OEYk4dRBUZuMEOfc1SUxcFJr6b9gxan85q8yj0pynGZ30Vy2UmQjqs1V2jBcMO3jMLdtwDa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSv29jQ4A3sx35Lm/Ek5E6y2EBeKc3x5g4VUGZ+ET7w=;
 b=K/4kQSw8mYNkqiHQ/D3Mfl3wI4jFnUIfiqjpiljUKD4Pa2OFC+Gw3mgOMupB1+rm/aqK3XT/ypB4bdBqnIiaB+0avYKfRl4Wu4cCbzbXsU/wUx2YQJQspAAKHEIGzqpl0rH4vTzvkIUP6U6hFyrG8LLYEcUeTB7BWsOuF46oTEA=
Received: from DM5PR19CA0036.namprd19.prod.outlook.com (2603:10b6:3:9a::22) by
 BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.33; Fri, 2 Apr 2021 06:43:58 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::d8) by DM5PR19CA0036.outlook.office365.com
 (2603:10b6:3:9a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Fri, 2 Apr 2021 06:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:43:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:43:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:43:57 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:43:56 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu: add helper funtion to query umc ras error
Date: Fri, 2 Apr 2021 14:43:37 +0800
Message-ID: <20210402064345.14093-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95ee9c8-74a1-47d5-4dbf-08d8f5a2b193
X-MS-TrafficTypeDiagnostic: BYAPR12MB3014:
X-Microsoft-Antispam-PRVS: <BYAPR12MB301424C289C931B3C5AE4BE7FC7A9@BYAPR12MB3014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daY95l0op+EO3/tp3k8ZEK8mCBY6yklWE6p2+ti0cBnnEiYlfHD53tsnrZlmG0yHLHx2s/QB33nA3Xdm7yNHl9nmAr85SKnscll91bQXOI+i5fsfjYNKeDsxDdzGYWTxt05viXbLXvAM/eSMeAD3ZIOPbfJ0vcLPopP5MBjG8vWP0yOab/gSFinAlffMDYVYw0woK9oFBDRUByzyYbwaFXSsCtUqK63NEmUFDGdJ2U7wH04O/CiO0LnjVQLMCl7ZsZole+wofPHQZo4Cv1Zy5NRs/zaDdg8nG79LtLiU1NuuVgTPChCKxObpl6kXBR1Uzzpi2+gzntUUG0ee3FN2zjmbMkV+CuD0iM1FUphcCDuZ6wKbNer1R54Cm0Z+8JOR4s03CKPjxjwxvR9dMnCrqgUxWqwZZAEQgHEtRFbbl4ZqZe0hApyXsu/tFYFaDY5/zRulNgTpr1PVvmfp2JFq/E+QIX+o0vFWlYlNM6vFu3f+ES2R/Q6qVzN5DRAHPaSzwSUEoabc4JEfeRrJ7hLMQ45kfw1dbiwMvB/uyUj7LWgpgVCkp2fLWGJy55DqYu1VC3WVN5kgEcH0i7ddgJlcY/e61KnTQb7v1kKscbZZprE6hWPUmNLx62q9cwFV/qbL27SnpvMNAhbbzXhqjUj/p2u3MDFm19GcxgRJprBVFc9sC/4oQeyWQYU59d5W7l45
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(8676002)(81166007)(82740400003)(356005)(186003)(316002)(1076003)(478600001)(7696005)(6636002)(426003)(83380400001)(47076005)(8936002)(5660300002)(36756003)(4326008)(70586007)(86362001)(70206006)(110136005)(82310400003)(26005)(336012)(2906002)(2616005)(36860700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:43:58.4723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95ee9c8-74a1-47d5-4dbf-08d8f5a2b193
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3014
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add helper functions to query correctable and
uncorrectable umc ras error.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 70 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |  7 +++
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 37aa1cf6b2ef..05fec10b1ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -24,6 +24,76 @@
 #include "amdgpu_ras.h"
 #include "amdgpu.h"
 
+#include "umc/umc_6_7_0_offset.h"
+#include "umc/umc_6_7_0_sh_mask.h"
+
+static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
+						   uint32_t umc_reg_offset,
+						   unsigned long *error_count)
+{
+	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
+	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
+	uint64_t mc_umc_status;
+	uint32_t mc_umc_status_addr;
+
+	/* UMC 6_1_1 registers */
+	ecc_err_cnt_sel_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_EccErrCntSel);
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_EccErrCnt);
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+
+	/* select the lower chip and check the error count */
+	ecc_err_cnt_sel = RREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4);
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel, UMCCH0_0_EccErrCntSel,
+					EccErrCntCsSel, 0);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4, ecc_err_cnt_sel);
+
+	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
+	*error_count +=
+		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_EccErrCnt, EccErrCnt) -
+		 UMC_V6_7_CE_CNT_INIT);
+
+	/* select the higher chip and check the err counter */
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel, UMCCH0_0_EccErrCntSel,
+					EccErrCntCsSel, 1);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4, ecc_err_cnt_sel);
+
+	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
+	*error_count +=
+		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_EccErrCnt, EccErrCnt) -
+		 UMC_V6_7_CE_CNT_INIT);
+
+	/* check for SRAM correctable error
+	  MCUMC_STATUS is a 64 bit register */
+	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+		*error_count += 1;
+}
+
+static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev,
+						      uint32_t umc_reg_offset,
+						      unsigned long *error_count)
+{
+	uint64_t mc_umc_status;
+	uint32_t mc_umc_status_addr;
+
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+
+	/* check the MCUMC_STATUS */
+	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
+		*error_count += 1;
+}
+
 const struct amdgpu_umc_funcs umc_v6_7_funcs = {
 	.ras_late_init = amdgpu_umc_ras_late_init,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 8c2ce694ec89..6b881226b4f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -23,6 +23,13 @@
 #ifndef __UMC_V6_7_H__
 #define __UMC_V6_7_H__
 
+/* EccErrCnt max value */
+#define UMC_V6_7_CE_CNT_MAX		0xffff
+/* umc ce interrupt threshold */
+#define UMC_V6_7_CE_INT_THRESHOLD	0xffff
+/* umc ce count initial value */
+#define UMC_V6_7_CE_CNT_INIT	(UMC_V6_7_CE_CNT_MAX - UMC_V6_7_CE_INT_THRESHOLD)
+
 extern const struct amdgpu_umc_funcs umc_v6_7_funcs;
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
