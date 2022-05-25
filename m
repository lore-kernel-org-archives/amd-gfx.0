Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAD2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 06:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7428110F536;
	Wed, 25 May 2022 06:11:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290D210F536
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 06:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGGpHlNvT4lxEot6VU63p5hdJIbLnpqjFnEVuZOzZEyxoArinXr2ikhuUUq1qj7Kk0eZKn3uu64SC7fA0gqQ2iQpVAATAmZvQZatdX2GBCOLenio5n1o2JVyVw0BdJWkV3F7Z/X4xZEk3KhlzAx4o/IHF7y5vXIsfe+1jIJeqI+HKzcA696nCY/wrXNGNp22mFEczkEywiIqKhms7zIAtLl+ZjHZhpd+Dp1d2dXGpypiq6GMC1p0hHJNCq+tyZVdZEX6xL09a0U4Mt7B8O4lEGjvrFkiULEevPjYdJ1CcKww+IoiDTU5GwyWMKU8be1QVV5d/Ky3a903vaXfzkBSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8c2nWUk9pCj/xF5T9xIPBEs3wO+ASspra49ZZYeO7w=;
 b=RXIw2RFrTKk9vKgXyHzijUzIrD1P2rJLA2wvUOzAVlRe6XVeAjeRSXrf1tj6KQeDHcxUOGqQiapFUeBgzrSrhF6wDszNOJ2YRCIZuN+NiVOsQM+z5ICu9aREf9dcuF/5lL2hev4lQKbJwhH9lO/Q9FjXxBg6W3NLDjWvSiuMWqxef5lA1jvE5ZR9ux6QpO+17aCcC6k4m2vzbMlpQmj7KnDR6jlPmm8q2cIX9PSflMV3+eQccCtDSivwnoEArxFME4Nl/27S9sLTcYMGqtKyEEaMLcnR1w63j3g3BdLc1NtgOenC5OprYjSoSLlCg0WJYDX7WGxfKgoy4/T0QXF5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8c2nWUk9pCj/xF5T9xIPBEs3wO+ASspra49ZZYeO7w=;
 b=teQDRg5Qf+iNfE1xL3XfN/CDk21c1swzM1WfRwO7qn6+q96DiSzV89pIWdLFWjrs27QsfS/2wNyRFHFp5u2l5z+ooElOtjvIhgoQaHrxZEh277iwZBbbKLfB1FsURQG07eRX4TOlHdOSKutPSPDOA5RAvxuVj3TkNQB82bvjcSQ=
Received: from BN9P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::11)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 06:10:56 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::19) by BN9P221CA0023.outlook.office365.com
 (2603:10b6:408:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 06:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 06:10:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 01:10:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 01:10:55 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 25 May 2022 01:10:53 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>, <evan.quan@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH Review v3 1/2] drm/amdgpu/pm: support mca_ceumc_addr in
 ecctable
Date: Wed, 25 May 2022 14:10:46 +0800
Message-ID: <20220525061047.26529-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c4d559a-325a-4204-0d13-08da3e1554e3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41166CE8ED271C82804D0D4B9AD69@BY5PR12MB4116.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0bkSoAaaENuDp1JnZAyBirYMXib1+meY+aZJaa4grCa7txcAZfV15LtVWDR0cqq3FB7LHlS6bZRAEgWLrtaYwLSROZoLeYkuFIHzwezcSrisnzmssZw7Ur4VgH46G1nHdv4+wDb+hx4b0+5uzoR+XYCXCXyjzV6dtcvpwVGrNaYXMCTcUKCvkGlWA/4HvebFxOkbVyaEBN5QZrTQU2sxW/nLkEUwbSkWIz9XgGNgAouAhfzlgNRs4rNaQ0qnwk2dxEM+fYLZUmJQ3WTfSy1301QOM8PVFT+63t/hRIlRGEoF8FDg3U5AGGjvvpIg22+CD1e8uR5csvWKsQkdtd29PvNDh3yXItlFa7fYdX3rynWwxY6FMAD8i78k902KlM6wNZ3ApIsnudlt+uXvc6u62exHiy8wGVXoUV2CQ2Y+LaHuVgZqCaYYNZHgiRCunYUu1wfS3NZBpOkihF2Tp+my1qmnQe+IQIvFUCGlB+Tqdr9zbz5QDOetjgoLw9n1lKj433ylNINjGu6dj2fpuyI9pwRx80MFCPUemnKEnYPrFkcU3WNgtJI+2tyz4/A0gbpFIlFGjaM/oLQXEcoQW4K1IzBsi8H7kwYHcRruj2Zf3UkICnC/lGuiLBeqW8uejNAgOXG/51wPqSSYJ60SupGqzL1ojEKp7vHB2zgyI9+nfCptNj81Wfa9TMeh/t2lRE8wYQJRccGnn25KSC9p/wocA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(36756003)(2906002)(7696005)(86362001)(316002)(8936002)(70206006)(70586007)(4326008)(6666004)(8676002)(26005)(508600001)(82310400005)(47076005)(5660300002)(426003)(336012)(356005)(110136005)(2616005)(36860700001)(1076003)(83380400001)(6636002)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 06:10:56.5123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4d559a-325a-4204-0d13-08da3e1554e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU add a new variable mca_ceumc_addr to record
umc correctable error address in EccInfo table,
driver side add EccInfo_V2_t to support this feature

Changed from V1:
	remove ecc_table_v2 and unnecessary table id, define union struct include
	EccInfo_t and EccInfo_V2_t.

Changed from V2:
	sync patch verion

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
 .../inc/pmfw_if/smu13_driver_if_aldebaran.h   | 16 +++++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 53 ++++++++++++++-----
 3 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index b9a6fac2b8b2..28e603243b67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -328,6 +328,7 @@ struct ecc_info_per_ch {
 	uint16_t ce_count_hi_chip;
 	uint64_t mca_umc_status;
 	uint64_t mca_umc_addr;
+	uint64_t mca_ceumc_addr;
 };
 
 struct umc_ecc_info {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
index 0f67c56c2863..6f92038470ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
@@ -519,7 +519,21 @@ typedef struct {
 } EccInfo_t;
 
 typedef struct {
-	EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
+	uint64_t mca_umc_status;
+	uint64_t mca_umc_addr;
+	uint64_t mca_ceumc_addr;
+
+	uint16_t ce_count_lo_chip;
+	uint16_t ce_count_hi_chip;
+
+	uint32_t eccPadding;
+} EccInfo_V2_t;
+
+typedef struct {
+	union {
+		EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
+		EccInfo_V2_t EccInfo_V2[ALDEBARAN_UMC_CHANNEL_NUM];
+	};
 } EccInfoTable_t;
 
 // These defines are used with the following messages:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 38af648cb857..9cdfeea58085 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -82,6 +82,12 @@
  */
 #define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
 
+/*
+ * SMU support mca_ceumc_addr in ECCTABLE since version 68.55.0,
+ * use this to check mca_ceumc_addr record whether support
+ */
+#define SUPPORT_ECCTABLE_V2_SMU_VERSION 0x00443700
+
 /*
  * SMU support BAD CHENNEL info MSG since version 68.51.00,
  * use this to check ECCTALE feature whether support
@@ -1802,7 +1808,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
-static int aldebaran_check_ecc_table_support(struct smu_context *smu)
+static int aldebaran_check_ecc_table_support(struct smu_context *smu,
+		int *ecctable_version)
 {
 	uint32_t if_version = 0xff, smu_version = 0xff;
 	int ret = 0;
@@ -1815,6 +1822,11 @@ static int aldebaran_check_ecc_table_support(struct smu_context *smu)
 
 	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
 		ret = -EOPNOTSUPP;
+	else if (smu_version >= SUPPORT_ECCTABLE_SMU_VERSION &&
+			smu_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
+		*ecctable_version = 1;
+	else
+		*ecctable_version = 2;
 
 	return ret;
 }
@@ -1826,9 +1838,10 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 	EccInfoTable_t *ecc_table = NULL;
 	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
 	int i, ret = 0;
+	int table_version = 0;
 	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
 
-	ret = aldebaran_check_ecc_table_support(smu);
+	ret = aldebaran_check_ecc_table_support(smu, &table_version);
 	if (ret)
 		return ret;
 
@@ -1844,16 +1857,32 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 
 	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
 
-	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
-		ecc_info_per_channel = &(eccinfo->ecc[i]);
-		ecc_info_per_channel->ce_count_lo_chip =
-			ecc_table->EccInfo[i].ce_count_lo_chip;
-		ecc_info_per_channel->ce_count_hi_chip =
-			ecc_table->EccInfo[i].ce_count_hi_chip;
-		ecc_info_per_channel->mca_umc_status =
-			ecc_table->EccInfo[i].mca_umc_status;
-		ecc_info_per_channel->mca_umc_addr =
-			ecc_table->EccInfo[i].mca_umc_addr;
+	if (table_version == 1) {
+		for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
+			ecc_info_per_channel = &(eccinfo->ecc[i]);
+			ecc_info_per_channel->ce_count_lo_chip =
+				ecc_table->EccInfo[i].ce_count_lo_chip;
+			ecc_info_per_channel->ce_count_hi_chip =
+				ecc_table->EccInfo[i].ce_count_hi_chip;
+			ecc_info_per_channel->mca_umc_status =
+				ecc_table->EccInfo[i].mca_umc_status;
+			ecc_info_per_channel->mca_umc_addr =
+				ecc_table->EccInfo[i].mca_umc_addr;
+		}
+	} else if (table_version == 2) {
+		for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
+			ecc_info_per_channel = &(eccinfo->ecc[i]);
+			ecc_info_per_channel->ce_count_lo_chip =
+				ecc_table->EccInfo_V2[i].ce_count_lo_chip;
+			ecc_info_per_channel->ce_count_hi_chip =
+				ecc_table->EccInfo_V2[i].ce_count_hi_chip;
+			ecc_info_per_channel->mca_umc_status =
+				ecc_table->EccInfo_V2[i].mca_umc_status;
+			ecc_info_per_channel->mca_umc_addr =
+				ecc_table->EccInfo_V2[i].mca_umc_addr;
+			ecc_info_per_channel->mca_ceumc_addr =
+				ecc_table->EccInfo_V2[i].mca_ceumc_addr;
+		}
 	}
 
 	return ret;
-- 
2.17.1

