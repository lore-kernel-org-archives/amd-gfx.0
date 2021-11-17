Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566DFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 10:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190E361002
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 10:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 190E361002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800BB6E430;
	Wed, 17 Nov 2021 10:11:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169676E425
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 10:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAm5rw4yE1t1adnGxN+6Nr03exINdEvNlVZv1RoLZ9Qrqbf2WjnO5STVUteAZhnTPNw8EB/11LppO7vqNxdKZ+qTa+MDKz3dXpJT63HH38Z6yYTTDsc5SiJNrN4pj/BiPtGykRpFUy4guTXAdxHMoteSjNqtHaSeqNAEC3+o+hB5j5AcknfUEbDanhg1Umgk9ylankWdczuByxZyu7Hc19fwZJw/D/u7KxgSfSMalIO0dfZsuXhFJ+5DB5tysf7mxkcwRR9AWyDE5cDEdcXr4jKjR+5qYPhtq8ld3GBkBysuV8eJ1UNC6pdi/YA27SN8stQ8Ivri+vbZ245Rh67aoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpxkxnrRSHaAcX3FU+Pe9U30Mg+C7vQ1peETRVVRmdU=;
 b=H1FEQqssQ71vnFpzpsqPlBqCi4vXtsGGxKrrt2/6aIZOZPm4KechuK4eAjxNkW0N2P+hWAroiA1qYVkgKz3B5O/Jz3r9D3e0iyIc2YWFKOYoRXZrZWWpaSAlU0ZCIu0JDQjqAxDX4Idtu59xN8kASpG2NXrl8g0AOYpCP7APaRgOZ2gZnjT71b+JD5jIRbSupWhg8yqSkPVo9/P9G6oS5NN7xxnZ+rqjCOtfSBq418N1yn/UQdSn9usJTN153/l5LPA95888FKk8gjQJJN0j3ECKvCUP+W+R+4aMQTF4SeKoPfkGFbjiYUiiF32JMpkgTUUP8nz+kWTbQPxNT6GCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpxkxnrRSHaAcX3FU+Pe9U30Mg+C7vQ1peETRVVRmdU=;
 b=RrUQy3n+d3OAxRJWe/HUSC01hUirPc9mbDXcnbYnsp0s6l++Kd6y6J32YCDLLi8okKJfQrPgc2w1wxF/BFlJZNrb2wgpsl4OGt09bGU/PbybJRy86ACgtpi/0KTkUuTyrF6wRQ80VSU0m1IuZAsz/HYSM8tClFq3szoBuVWYbNE=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 10:11:46 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::ca) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Wed, 17 Nov 2021 10:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 17 Nov 2021 10:11:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 04:11:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 04:11:45 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 17 Nov 2021 04:11:43 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH Review 3/4] drm/amdgpu: add message smu to get ecc_table
Date: Wed, 17 Nov 2021 18:11:31 +0800
Message-ID: <20211117101132.6568-3-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117101132.6568-1-Stanley.Yang@amd.com>
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e7dca3-ab90-497c-d538-08d9a9b2a944
X-MS-TrafficTypeDiagnostic: PH0PR12MB5435:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5435B3A5237CF257214486759A9A9@PH0PR12MB5435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izI4ovlYKuJQhE+b4M52no0E00TcxBCC6pQCp+ull7JII0WanZM00qm7uud7048CfH8giIgK+YILgAmipSCSvM6Rn2P5u+s2cA3qfl4giMnxyH7r2HcdnPWizpsna4jM/4BEErQo4ktdxNfHNc544gQwLG5yaq1ENd4AXzYeKPY33+DFn794f5XmMn9ZIPH4X3HcBF8S2w95SprKpOyy2jFgq/QXMce+Mrl/UMgWvHjwGMTfawnfMlNoInNwnIK/WiskZg7xyJ7BB++RX1d7Z2qr0wEhvDVU2dObJEdTBOZG236iiQR9DxvvlP6HmUVg8rmLd9NMp0y6c/k92ZlPe50SoRtPr8YS3nvSgpb7KosJesSuaSnKVv1K5nWoCv2nnGLU5A+bTFnsMbZ7fBClTpPi9hqWvYkv/1mBOSfzamhc19ROwE3IZnNNyBpUgkle+2RgUS6PqeyomsvrL/UE9r5/Tai00vaecb0ufn43UONlXgL5MgiqVOZTd7uEPtCX4qGB3LCVwFWkJR3jP2ibP27ijzv6/12PZbTrSgLM76jxJI3Be9m1R/nD2tX37zQVxus1P1ecCw9fK3jMkEUkFdCtBF0+ux3VGWJ0jVaoRV8ekU70tajqAjYsnh045iM8oFWf17BI3KKmJ2uUwwDhS/RpPfaFhXBSx3/9wDw6kIhTeFpNvcghusTQH1HnXdAsUEmS5RXp/Pqmkvpu5toQ1/l+HSLxKou3v95YVZGULzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(82310400003)(15650500001)(86362001)(47076005)(6666004)(1076003)(70206006)(426003)(36860700001)(26005)(2616005)(110136005)(508600001)(5660300002)(8936002)(81166007)(6636002)(70586007)(336012)(356005)(36756003)(83380400001)(8676002)(4326008)(2906002)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 10:11:45.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e7dca3-ab90-497c-d538-08d9a9b2a944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
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

support ECC TABLE message, this table include unc ras error count
and error address

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  7 ++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 38 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 24 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
 5 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3557f4e7fc30..ea65de0160c3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -324,6 +324,7 @@ enum smu_table_id
 	SMU_TABLE_OVERDRIVE,
 	SMU_TABLE_I2C_COMMANDS,
 	SMU_TABLE_PACE,
+	SMU_TABLE_ECCINFO,
 	SMU_TABLE_COUNT,
 };
 
@@ -340,6 +341,7 @@ struct smu_table_context
 	void				*max_sustainable_clocks;
 	struct smu_bios_boot_up_values	boot_values;
 	void                            *driver_pptable;
+	void                            *ecc_table;
 	struct smu_table		tables[SMU_TABLE_COUNT];
 	/*
 	 * The driver table is just a staging buffer for
@@ -1261,6 +1263,11 @@ struct pptable_funcs {
 	 *										of SMUBUS table.
 	 */
 	int (*send_hbm_bad_pages_num)(struct smu_context *smu, uint32_t size);
+
+	/**
+	 * @get_ecc_table:  message SMU to get ECC INFO table.
+	 */
+	ssize_t (*get_ecc_info)(struct smu_context *smu, void *table);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f835d86cc2f5..5e4ba0e14a91 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -190,6 +190,7 @@ static const struct cmn2asic_mapping aldebaran_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(SMU_METRICS),
 	TAB_MAP(DRIVER_SMU_CONFIG),
 	TAB_MAP(I2C_COMMANDS),
+	TAB_MAP(ECCINFO),
 };
 
 static const uint8_t aldebaran_throttler_map[] = {
@@ -223,6 +224,9 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
+	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
@@ -235,6 +239,10 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	}
 
+	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
+	if (!smu_table->ecc_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1765,6 +1773,35 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
+					 void *table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	EccInfoTable_t ecc_table;
+	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
+	int i, ret = 0;
+	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
+
+	ret = smu_cmn_get_ecc_info_table(smu,
+					&ecc_table);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
+		ecc_info_per_channel = &(eccinfo->ecc[i]);
+		ecc_info_per_channel->ce_count_lo_chip =
+			ecc_table.EccInfo[i].ce_count_lo_chip;
+		ecc_info_per_channel->ce_count_hi_chip =
+			ecc_table.EccInfo[i].ce_count_hi_chip;
+		ecc_info_per_channel->mca_umc_status =
+			ecc_table.EccInfo[i].mca_umc_status;
+		ecc_info_per_channel->mca_umc_addr =
+			ecc_table.EccInfo[i].mca_umc_addr;
+	}
+
+	return ret;
+}
+
 static int aldebaran_mode1_reset(struct smu_context *smu)
 {
 	u32 smu_version, fatal_err, param;
@@ -1967,6 +2004,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.i2c_init = aldebaran_i2c_control_init,
 	.i2c_fini = aldebaran_i2c_control_fini,
 	.send_hbm_bad_pages_num = aldebaran_smu_send_hbm_bad_page_num,
+	.get_ecc_info = aldebaran_get_ecc_info,
 };
 
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4d96099a9bb1..55421ea622fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -428,8 +428,10 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->hardcode_pptable);
 	smu_table->hardcode_pptable = NULL;
 
+	kfree(smu_table->ecc_table);
 	kfree(smu_table->metrics_table);
 	kfree(smu_table->watermarks_table);
+	smu_table->ecc_table = NULL;
 	smu_table->metrics_table = NULL;
 	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 843d2cbfc71d..e229c9b09d80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -983,6 +983,30 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 	return ret;
 }
 
+int smu_cmn_get_ecc_info_table(struct smu_context *smu,
+				     void *ecc_table)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	uint32_t table_size =
+		smu_table->tables[SMU_TABLE_ECCINFO].size;
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+			       SMU_TABLE_ECCINFO,
+			       0,
+			       smu_table->ecc_table,
+			       false);
+	if (ret) {
+		dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n");
+		return ret;
+	}
+
+	if (ecc_table)
+		memcpy(ecc_table, smu_table->ecc_table, table_size);
+
+	return 0;
+}
+
 void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 {
 	struct metrics_table_header *header = (struct metrics_table_header *)table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index beea03810bca..0adc5451373b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -105,6 +105,9 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 			      void *metrics_table,
 			      bool bypass_cache);
 
+int smu_cmn_get_ecc_info_table(struct smu_context *smu,
+			      void *table);
+
 void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 
 int smu_cmn_set_mp1_state(struct smu_context *smu,
-- 
2.17.1

