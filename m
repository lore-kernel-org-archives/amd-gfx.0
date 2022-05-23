Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB87C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 08:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7081A10E81C;
	Mon, 23 May 2022 08:17:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE7610E81C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 08:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3gjJeYy2N59YzVaipuCE2GQak4aAkSja8WRiO8FxkbInWTQx7whL+NvwtVgYJCrdiMRbhkk3oI8F9QW9dAmi/HtiC56obLJT6qjwHLuVID2Wa9XHXhQbNFcxJ4kTwXHZamC//VikEkDVtx7bruDikP7Y44Nq3JtLQq+wOb5XqPTByxlLBmVBE8Qjuub2JBZiYwsQBiukJOdI5qqBf1xFaoM5CvIqxPQKDuBz77MZJ2zdHl46Mz/6l0RBJrooRoMUCVqm0akp2gZ1uH5+ohb6KP25mJf3c1ywyZ12JQ3hPky8HN7PyyFbnieIfhRZy3/eokr1dMbiJlTU7Z27fWEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0MpAziWCktHAv5uwi5KrS/zLm+ovYIqs9Ifsn+f2ZY=;
 b=b6oMf+YUMuYOaLcQCo1rgbYsB5ZoHUYuQ8wc3ShgQUy9ulKEokpd/jNkI64lUneruXUEqhg9DKKpUsERspVFSconQeLIGOjlhEu79vr8rPuX5kveSShyxIIYsgf+M/0kxYO8HXqQqwndGBNJb5HzoRF6eg38DHvyoozoSE6oX664y7Y+CuNfy+MLChr1eBF0PcaKhw+ufoB23OX5lYZ99O/GavXg21fCiMOWEt/gbkLklQhlqdOhjqhS6ey0IAaiZ0zXf4bReYxhszN1baNj6Yco1kKTG1SaUUSYXUgfrpEtBRAFx9ipQIe4+ZeW9/ZrMi3S/BlB58LgqLqTBebTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0MpAziWCktHAv5uwi5KrS/zLm+ovYIqs9Ifsn+f2ZY=;
 b=ZPuMxxnvGpMIaFR1Ef2dcnUpM2x5zMMeds+NSF2EOXzCZfFXNEsonjsa9kvMvFMj9pUQBgX7d7JJUmb3JjI4OHWFJ5ljw05Uoa7Cm8LDgjJv0hDkI5RfHNxaLsHBNCrmM+wo6G/5hDxnE9pDA/lVnk2uKHjK/jSe/TbX4DORYv0=
Received: from MWHPR04CA0027.namprd04.prod.outlook.com (2603:10b6:300:ee::13)
 by BN6PR12MB1188.namprd12.prod.outlook.com (2603:10b6:404:19::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 08:17:06 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::ed) by MWHPR04CA0027.outlook.office365.com
 (2603:10b6:300:ee::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Mon, 23 May 2022 08:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 08:17:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 03:17:04 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 23 May 2022 03:17:03 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>, <evan.quan@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in ecctable
Date: Mon, 23 May 2022 16:17:00 +0800
Message-ID: <20220523081701.32456-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30c2eb34-cf92-4dd7-d933-08da3c949fcf
X-MS-TrafficTypeDiagnostic: BN6PR12MB1188:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB11880261CCD96AE07D3D7E839AD49@BN6PR12MB1188.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9fVzOFbo1+r8PMCUe4gUYEF0rf0N9FxCQ2qWbS/wedJwd8B0LgV78D26Ds9RsSEqT0RqgSUg0PKjepOkvEfrjgTkp5TvHlcRDxfy/yt5ZOXWkUBg5kxVbretSGIa2ANAvlrWaIrXR1/2exnoMLUvoKlnLaMkIo6Dq+vhqMmI96JV7O1mxc6D9VqeSm2cJ2EgGHRCuDP2/XXAJlwx5Lw3fGXHa0NQu41Qt7/G3MzNsQXS92XVfgkEa3JzLCQmh9wZzhilI6ePJCGaeNRAKQRwNi/sXpc6MUxeeZrC0D8zO97D0rfS5cH4U92YhdRdn/+moloyQzheTSBLVmf7gUqZ+qCJIuuyVIN4B24wqbm1I4mH9eCeiAapAmF5Q+5Te2KIorSXpvAwRQV2+KL+a2aC/GfnHR74qg+umB7RDh/5TteBGWNVsFKJ3Nf6zmwoDM0XUxK9VdurNtAE6LvjkvyftHSu5ewPgBmnz+QIo7b/sjEz+9qoGENwy58+CxBjhcF85WMmmPhMMkOBKIyltu5ORJRUCn7mSK+Coj9gkq9Fru9HxS1zbdPvv8mbClOGqkV5GzaghQASBZD3x90Jr/h/v1/GWAHIpvfUL4LDAFhyuJwyNt1hoNYrcZmm0Hwy4uAcPI7vY20W6BC8RxSJfUm5itwx6QRodS6OKK5NllScwbjeeDtsqhV5ZOW9Owo9/ZdMhVAIgLRCjGUGO2clFOJJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(6636002)(316002)(8936002)(5660300002)(70206006)(70586007)(2906002)(110136005)(86362001)(19627235002)(8676002)(4326008)(81166007)(356005)(508600001)(26005)(1076003)(2616005)(47076005)(7696005)(40460700003)(36860700001)(186003)(426003)(83380400001)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 08:17:05.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c2eb34-cf92-4dd7-d933-08da3c949fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
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
driver side add ecctable_v2 to support this feature

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
 .../inc/pmfw_if/smu13_driver_if_aldebaran.h   |  15 +++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 101 ++++++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
 5 files changed, 98 insertions(+), 23 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a6a7b6c33683..9f7257ada437 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -322,6 +322,7 @@ enum smu_table_id
 	SMU_TABLE_PACE,
 	SMU_TABLE_ECCINFO,
 	SMU_TABLE_COMBO_PPTABLE,
+	SMU_TABLE_ECCINFO_V2,
 	SMU_TABLE_COUNT,
 };
 
@@ -340,6 +341,7 @@ struct smu_table_context
 	void				*driver_pptable;
 	void				*combo_pptable;
 	void                            *ecc_table;
+	void                            *ecc_table_v2;	// adapt to smu support record mca_ceumc_addr
 	void				*driver_smu_config_table;
 	struct smu_table		tables[SMU_TABLE_COUNT];
 	/*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
index 0f67c56c2863..2868604eff49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
@@ -522,6 +522,21 @@ typedef struct {
 	EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
 } EccInfoTable_t;
 
+typedef struct {
+	uint64_t mca_umc_status;
+	uint64_t mca_umc_addr;
+	uint64_t mca_ceumc_addr;
+
+	uint16_t ce_count_lo_chip;
+	uint16_t ce_count_hi_chip;
+
+	uint32_t eccPadding;
+} EccInfo_t_v2;
+
+typedef struct {
+	EccInfo_t_v2  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
+} EccInfoTable_t_v2;
+
 // These defines are used with the following messages:
 // SMC_MSG_TransferTableDram2Smu
 // SMC_MSG_TransferTableSmu2Dram
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 38af648cb857..e58df9490cec 100644
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
@@ -239,6 +245,9 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
+	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO_V2, sizeof(EccInfoTable_t_v2),
+			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
@@ -255,6 +264,10 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	if (!smu_table->ecc_table)
 		return -ENOMEM;
 
+	smu_table->ecc_table_v2 = kzalloc(tables[SMU_TABLE_ECCINFO_V2].size, GFP_KERNEL);
+	if (!smu_table->ecc_table_v2)
+		return -ENOMEM;;
+
 	return 0;
 }
 
@@ -1802,7 +1815,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
-static int aldebaran_check_ecc_table_support(struct smu_context *smu)
+static int aldebaran_check_ecc_table_support(struct smu_context *smu,
+		int *ecctable_version)
 {
 	uint32_t if_version = 0xff, smu_version = 0xff;
 	int ret = 0;
@@ -1815,6 +1829,11 @@ static int aldebaran_check_ecc_table_support(struct smu_context *smu)
 
 	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
 		ret = -EOPNOTSUPP;
+	else if (smu_version >= SUPPORT_ECCTABLE_SMU_VERSION &&
+			smu_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
+		*ecctable_version = 1;
+	else
+		*ecctable_version = 2;
 
 	return ret;
 }
@@ -1824,36 +1843,72 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	EccInfoTable_t *ecc_table = NULL;
+	EccInfoTable_t_v2 *ecc_table_v2 = NULL;
 	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
 	int i, ret = 0;
+	int table_version = 0;
 	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
 
-	ret = aldebaran_check_ecc_table_support(smu);
+	ret = aldebaran_check_ecc_table_support(smu, &table_version);
 	if (ret)
 		return ret;
 
-	ret = smu_cmn_update_table(smu,
-			       SMU_TABLE_ECCINFO,
-			       0,
-			       smu_table->ecc_table,
-			       false);
-	if (ret) {
-		dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n");
-		return ret;
-	}
+	if (table_version == 1) {
+		ret = smu_cmn_update_table(smu,
+				       SMU_TABLE_ECCINFO,
+				       0,
+				       smu_table->ecc_table,
+				       false);
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n");
+			return ret;
+		}
+
+		ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
+
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
+		/* still use SMU_TABLE_ECC_INFO index,
+		 * smu 68.55.0 add mca_ceumc_addr variable
+		 * in EccInfo_t struct to report correctable
+		 * error address and the table_id is not changed
+		 */
+		ret = smu_cmn_update_table(smu,
+				       SMU_TABLE_ECCINFO,
+				       0,
+				       smu_table->ecc_table_v2,
+					   false);
 
-	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
-
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
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU ecc table_v2!\n");
+			return ret;
+		}
+
+		ecc_table_v2 = (EccInfoTable_t_v2 *)smu_table->ecc_table_v2;
+
+		for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
+			ecc_info_per_channel = &(eccinfo->ecc[i]);
+			ecc_info_per_channel->ce_count_lo_chip =
+				ecc_table_v2->EccInfo[i].ce_count_lo_chip;
+			ecc_info_per_channel->ce_count_hi_chip =
+				ecc_table_v2->EccInfo[i].ce_count_hi_chip;
+			ecc_info_per_channel->mca_umc_status =
+				ecc_table_v2->EccInfo[i].mca_umc_status;
+			ecc_info_per_channel->mca_umc_addr =
+				ecc_table_v2->EccInfo[i].mca_umc_addr;
+			ecc_info_per_channel->mca_ceumc_addr =
+				ecc_table_v2->EccInfo[i].mca_ceumc_addr;
+		}
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ae6321af9d88..af2d84a16f3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -552,9 +552,11 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->hardcode_pptable);
 	smu_table->hardcode_pptable = NULL;
 
+	kfree(smu_table->ecc_table_v2);
 	kfree(smu_table->ecc_table);
 	kfree(smu_table->metrics_table);
 	kfree(smu_table->watermarks_table);
+	smu_table->ecc_table_v2 = NULL;
 	smu_table->ecc_table = NULL;
 	smu_table->metrics_table = NULL;
 	smu_table->watermarks_table = NULL;
-- 
2.17.1

