Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1082C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4B3611BF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C4B3611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75426E917;
	Thu, 18 Nov 2021 09:33:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310536E90F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 09:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVEX/MbzARu1Bf8TT9AnYklN0Oi8I4Ga2Jy9EmJn4vJ9LVHOEFg37G+cRQKHA3WRT8ev4BJcMCwfqbAdgfxV5PZki4EEXuOr5UytEh32drk1hRJ95fhHxxYb6V5peQKCG/AtUSs9RTyWGTZQtqSI+20OWsQoa/JmQm13hmzbOgqqToOcAUmIsgm8SwtOTPRZDwFhN58cq+mh8NNsL2NeQi9RrMrK4Bvp1RuGKY178OlQyvFLO/s0jNLpjmyb/AV33JhDSg9xEZ8CUUQvHoOIb2oKQi9f7zx/f7h06vyYM65uiQdwcU1NKqCTfN0igTw0TS35W6A9RBJ9oq7zOYFJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ev1J2ozc6ZDA0CyoFWfJO2d6063MarxoD96gQnOqOs=;
 b=cu0qe2HnpT2jMXcsDOeIOh9zzjQ+IBqt3gVLO+Vxov7WhaHwVkHQNbj8h8Pqk7wy+ca1XLyJ8IokVrNw6TRuJyO4nsiOTYNhm8yJyMDReyZIjiWE2JFkoLEMwTLAlgfsLlqgkmido5tFckaERoaU6Z2FNv+DtD1Hx7P/byuP6mKHCLj1/xs5QHYh624jsr73/qbSAY/2rDdjm1LtEtwOUua3JKJLrd7trbAvlkGB6fE7FUExb7/V1CyQLBKX/EVBWhNDqq+MejBBOfl7pZAeQ2rVMhU8QN9VMiD8PwvAAuWp8ZMMEvFF3WwmZU+wv/9qK8IDyteln2dhyyfd+lh+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ev1J2ozc6ZDA0CyoFWfJO2d6063MarxoD96gQnOqOs=;
 b=3AxulDbcx5zR8q3JpozQk2O8TBiX/XlkDPPegbHWIGkpTaY5IICPknCTIiPy0D0jlyVfzfUQPx/732l1aUxDFdVYk2c/3LKDL/I/wopAterWs5MS/Fom8/nXfxHaCuF9FgBhkjOtRkIrk8Ih0xBd9MVZV00JPxoqzIx7fLCz8OY=
Received: from DM6PR13CA0007.namprd13.prod.outlook.com (2603:10b6:5:bc::20) by
 BYAPR12MB2709.namprd12.prod.outlook.com (2603:10b6:a03:6d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Thu, 18 Nov 2021 09:33:54 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::c3) by DM6PR13CA0007.outlook.office365.com
 (2603:10b6:5:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend
 Transport; Thu, 18 Nov 2021 09:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 09:33:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 03:33:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 03:33:52 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 18 Nov 2021 03:33:50 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH Review 3/4] drm/amdgpu: add message smu to get ecc_table v2
Date: Thu, 18 Nov 2021 17:33:43 +0800
Message-ID: <20211118093344.4361-3-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211118093344.4361-1-Stanley.Yang@amd.com>
References: <20211118093344.4361-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72c840bd-3c8c-4a0a-27dd-08d9aa7689a9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2709:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2709423DC530A91F6CF571529A9B9@BYAPR12MB2709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtUyCN9LZCfZmd2dMb/f9iA2L52+0ckQ6WH+PLYranckPcyZ4aEmk13HhAINNzE/H00tHvOYWcXsL1UbQEwe0XVQn6wUIpgm5PZzUiUKpormWjFbKY6pz09CGs4ZQLnOodv3NypAbZ2vWEZ0ldthMIFomXvu6IiT9CIT57D+iQn+jeMa3XIy9j+cbkCP6H1T/78T7it3EJSnvJV5Gry5wmV4ySrgRySHey2ZAbTYDAQgWYSAfC4X2wn2a8Jb/d9p5MowcGlvOqsQiLyIB/i49y9eFiChx9zuparz+Z9nBXOBU4voKF00mdgBmXWE8YIYY97lfGyakniRl7Mqovl2DBS4m0GamJWT0Zw2H5HUqDlyc7idwRqxGbGdCLBzifBckGpt5UZjqhdkXglJ07Vwqtba4Yyrf1WlafWJFs7BSvii9Y+Yb3lcMNlF+sgSdd9OiuUCCl7oWHOGwQGj/i+VuIcVqSZoIKjLXAdoi0rsHI/kjKm6qprIjIf6jFywyzifgIiJLF/wn37bz3P1Ukqo2YAmmRHkj650jXexc8Fh3ddmKY6PSdmgd6FIexw4RqwcqyQYFfQOgqJGsnaQtu4yxkXvrkTrWd3JSNUC9WShWceok/ucl0W8ctatl+WKr8y6peGRFV3D/iLdQnpv1artry6YSv/AQB+J2DBRI7Wg1yd0HXnyoGVxCTS0TToqAlRq68cZXVpCMSdVdWGBtxMGvq0JuzWVOC3eAh8FyjWELXs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(356005)(8676002)(316002)(4326008)(81166007)(110136005)(5660300002)(1076003)(82310400003)(6666004)(36860700001)(15650500001)(83380400001)(47076005)(508600001)(426003)(2906002)(70586007)(36756003)(70206006)(86362001)(26005)(7696005)(186003)(6636002)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 09:33:54.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c840bd-3c8c-4a0a-27dd-08d9aa7689a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2709
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

support ECC TABLE message, this table include umc ras error count
and error address

v2:
    add smu version check to query whether support ecctable
    call smu_cmn_update_table to get ecctable directly

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 70 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
 4 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3557f4e7fc30..7a06021a58f0 100644
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
@@ -1397,6 +1404,7 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
+int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 01168b8955bf..fd3b6b460b12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3072,6 +3072,20 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable)
 	return ret;
 }
 
+int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
+{
+	int ret = -EOPNOTSUPP;
+
+	mutex_lock(&smu->mutex);
+	if (smu->ppt_funcs &&
+		smu->ppt_funcs->get_ecc_info)
+		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+
+}
+
 static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f835d86cc2f5..4c21609ccea5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -78,6 +78,12 @@
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
+/*
+ * SMU support ECCTABLE since version 68.42.0,
+ * use this to check ECCTALE feature whether support
+ */
+#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
+
 static const struct smu_temperature_range smu13_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
@@ -190,6 +196,7 @@ static const struct cmn2asic_mapping aldebaran_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(SMU_METRICS),
 	TAB_MAP(DRIVER_SMU_CONFIG),
 	TAB_MAP(I2C_COMMANDS),
+	TAB_MAP(ECCINFO),
 };
 
 static const uint8_t aldebaran_throttler_map[] = {
@@ -223,6 +230,9 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
+	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
@@ -235,6 +245,10 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	}
 
+	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
+	if (!smu_table->ecc_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1765,6 +1779,61 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static int aldebaran_check_ecc_table_support(struct smu_context *smu)
+{
+	uint32_t if_version = 0xff, smu_version = 0xff;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret)
+		ret = -EOPNOTSUPP;	// return not support if failed get smu_version
+
+	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
+		ret = -EOPNOTSUPP;
+
+	return ret;
+}
+
+static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
+					 void *table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	EccInfoTable_t *ecc_table = NULL;
+	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
+	int i, ret = 0;
+	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
+
+	ret = aldebaran_check_ecc_table_support(smu);
+	if (ret)
+		return ret;
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
+	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
+
+	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
+		ecc_info_per_channel = &(eccinfo->ecc[i]);
+		ecc_info_per_channel->ce_count_lo_chip =
+			ecc_table->EccInfo[i].ce_count_lo_chip;
+		ecc_info_per_channel->ce_count_hi_chip =
+			ecc_table->EccInfo[i].ce_count_hi_chip;
+		ecc_info_per_channel->mca_umc_status =
+			ecc_table->EccInfo[i].mca_umc_status;
+		ecc_info_per_channel->mca_umc_addr =
+			ecc_table->EccInfo[i].mca_umc_addr;
+	}
+
+	return ret;
+}
+
 static int aldebaran_mode1_reset(struct smu_context *smu)
 {
 	u32 smu_version, fatal_err, param;
@@ -1967,6 +2036,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
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
-- 
2.17.1

