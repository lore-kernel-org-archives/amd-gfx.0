Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74096C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 14:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB6810E101;
	Tue, 24 May 2022 14:31:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A366610E21D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 14:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKKcDb4yYT1MShdX20b/NFCVJoyODIW58eaTSDoyVFlSqeot+9G6XnQRKG6W0SioI6u4psXogVj7pDpybnDsVnsHhOyY2PwhC2Hm2zAqeYlU2Hbar7Sw4ojkyKsOVmiozEogUtIajVxmrlMTzs8fGiijXEv/9nHYeYhaZ231cVtfCMgDwkojcd/D289XPMgu1PnlVC3f399unqqdL6dsR8CkRr07NdmSlgNL0gHTC1arUm+dQJ1yDU8BOvvgsiLrTah/VENrhKEBtTMpoyqCpeXkdNFIM9IF164yJyAwnmn34m7L96jvSwTRNyZatNPSIK9x9iKPkqqumgQfxH78Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhBN0fZ6vYXIbVef/L+mO2Wp48FnkF1D5Aq/hdTAfPM=;
 b=FOXuVJiTYc9EyTXNp0U/OPVmiwcXcwe77XA6cZfyYSrhETG9/udpJeU7gnxbgJAux+Lq5Q8Jz3EsOlo6qp9FpYXFn6P8D3tfa9rPsLu6iKllsgNZ8eHLHoTswr7CyFFkw+/BATZz9V1f1AU5MYEQp8p9QmGDCKs7Oyawt4E1lzB3KetHTukJBe2skXdBra6o7+zTsQnoAJ6/oyL6PyDeaPCLSxGMpL4na0rA0Cg6Ky3a+wtgH0wMh3galdcnT9fSbsgNHOm07jm27N8LwZoIgDjpdp77qZxZGiQ5oa+fCTK0yUUgHJkxEGv0wxzQ5j53DGBqJMedUQZCVrjpbCT6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhBN0fZ6vYXIbVef/L+mO2Wp48FnkF1D5Aq/hdTAfPM=;
 b=XaZp+Z0fXX3aWI/Lu1elnKz7pHATHCpCUhktryla72x3zU2X6q8wsnwNJvzp8EJpI9gQj9BeligkWXQOAsffpeQuiXdhMD/DQz5GzKoU26SjCqrq+0NPlQp8srE4haxFBcic73DTo7sPCFQMHUKq/YZSf8hMMVA8kBhAegmLsxU=
Received: from DM6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:5:190::18)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 14:30:59 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::b4) by DM6PR11CA0005.outlook.office365.com
 (2603:10b6:5:190::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Tue, 24 May 2022 14:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 14:30:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 09:30:58 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 24 May 2022 09:30:56 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>, <evan.quan@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH Review v2 1/2] drm/amdgpu/pm: support mca_ceumc_addr in
 ecctable
Date: Tue, 24 May 2022 22:30:54 +0800
Message-ID: <20220524143055.11723-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e79992-3754-4f99-df6b-08da3d920590
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597CEB19EC3CC4DD6BD6BC19AD79@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thmu4YuiQvhSjIShrAHzwMYFfehi15tNP1kB7ihVPnKSZ/vbTL/hVmONt+DCweRNJZJ+2D891nt3xDSuiSgC7AnJubIc4j5xr989+oFSs3wtLtVnNWLSP+yom0ilFQwBhtW6ln8g0TNNL9Dp/QQPYAymlJ8By40Y7eDYGoHXD4OBwJNwqT4Hzc5hzmu7Uy/ozAy9htqU53LegPWfNeiIqLan240R0IWIy3NMD7BfgnLaZ+CnHPnSDrhtmlKV0/YSbBZN3MuzmQa2tCFg9uPqNluYTv3OpJNiPq/87wfRjeODSQ+/YcxzeLZsKeiIU+lOFJus6aiV3i3Vfsz2L3etfbxukOvIx8gu66lkMzMmE+0yiVfpA8svh5Uy1qIXDr7A+DtBQzEVrKBYOBKKH+R+PfOY1r4RalvW4rvxdmHDUcVTy3em1nuPDKrLo+sKNk+5sPVKFz6Q4QrMcWbDwZG4KL8kNHYwWRC6DCInTM3E8+SpT1quHxPYtX8btAyhi+VFc7z4EE2DhX1pEOYLQUwtfc+m3w0oHGzQ90ZH0uO1dD1tBPX+zMtQHidtACIcI0Wqby8EYQugGLvlcr8gkVX2Q7CWLxKzeJWE6YMaurcAEeL5wJpUDYvjAZXuXjLCtQCrnLqvpB2MZjEvFUgt8rc4Ec/g/tXCFXioE7PVXro8ro4SK4PtUrCUn/F3xABGORla7VFWiaTc74TzL1BuzunAxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(508600001)(81166007)(26005)(5660300002)(8936002)(36756003)(86362001)(2906002)(40460700003)(356005)(83380400001)(7696005)(47076005)(336012)(426003)(186003)(1076003)(82310400005)(2616005)(8676002)(70206006)(4326008)(70586007)(6636002)(316002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 14:30:59.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e79992-3754-4f99-df6b-08da3d920590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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

