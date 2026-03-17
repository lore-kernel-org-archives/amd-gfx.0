Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C40FD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A3510E5FC;
	Tue, 17 Mar 2026 20:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BhEBIyfG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D9D10E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFaxirouBK9KYecVdn0AVcGNRDGRHF3IBNygHqZi6FbC0LIMDAHB4UhQIQg9pT52PUozLDeEu9bo3xSAnUaxab38ZL9GEh5wcOK4+HlYB8DkqPTQ25Ujv8Lgy6EvEth8GShq0NKwGRJAStr7Hhc4WZZ+tXAlqDhMSK8oXKKXUhUZlquxjQPQci8HQx7VMblH7rpCLlpZzvT2hv8Uc1XAyQxSmoInNbrClidsjt6FpsxTygd1oZHZYjV9asKu1wCLsW0sN9zrrmkCAres52NLBl5YC0LrOngTJQHymu4HsCUXwGjevN9MHtNg0PBp+yh2zl/88EL34HqS5VtNBIkyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5ANJegJrxJpoAdfCenxW5HB2aCBidSx1WvuNefu/Yw=;
 b=F6z18120LO7qiLv9VzddCaLW7sSZ0G1e5gLdTbDWGQ0wpMSdruVbeLgExtXEn0xeWYtbQBlVI+0Mu/Y7jSi70WI+bGM+BQGC+4lWM54bn/J8YF527WZ41VVRLdH9pRFupDjDacAGIgPCCUZM+qIHatuXaxO243ZDDo0ifrz5Qqq8Pi0YXuwKdbw1WjnBL6/PGN/2E4eAz/QxUeahbN8t/o3xkSMlmeiH22gJuHu2l1hmUeD93ZRFAUvNodumBuOZybWp+6GJSxulBrMkimp8MWAORo9D1awIWzu/S7DHEkMUjHstalFv6J4MIgXsd3YCqL5yqHTpxll6ZjjbYu3rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5ANJegJrxJpoAdfCenxW5HB2aCBidSx1WvuNefu/Yw=;
 b=BhEBIyfGrBla9UanRvwWvK/AeEMYChUXmlF/e8fVObC/VW297ChuArut+ax+1Xkb/MM5HjxGatV3l8pdVr2WVFKgZSqBkoZ6OJG9T2RjZKdlUGQZiwmwplI2NE/Q6ywiTyRX6/fd1mUBYmqoP8Klg0iGHKkaA7SDhaxzE39Kc3k=
Received: from PH2PEPF00003856.namprd17.prod.outlook.com (2603:10b6:518:1::78)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:02 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH2PEPF00003856.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 20:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 15:12:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:12:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Asad Kamal <asad.kamal@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/25] drm/amd/pm: Setup driver pptable for smu 15.0.8
Date: Tue, 17 Mar 2026 16:12:23 -0400
Message-ID: <20260317201242.3808136-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e3ce85-d5e3-4721-9570-08de846197af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 42WI8txlPuxQV4nhW4xL7Av44qA9YNPVydW5xYFzo3WKwoqLLU8F5dgu7Y+qMJCNwQWCjOtsHokbjXn2IQpLI7kfFSDdVUNnJ13GO9bg0s+KBSpXSdkxy7FfI20IkkTZPU+Tt7DUA2nnDOJLZmy8EX3CVXbEr3d5FcbwgC3AEdlxRhQIXMXxmCWYYePQwXmaLhxMc/lEmhg/ilJitlsrtqAFaMedms2Ik4Qzg1AxPnq5U74u971o5qsONYLZ8nOPsgPsH41s6FWfODYdpuqP8mnSsIc7dmBrskeHppAO1KKMXAOYcXMAlURCiQN86JlpEfolSn5C/k5M/c4+pRoKTRqo9TNUe73kZS5p8Cab4NsTWqKUTBtnPywSrn+fqvddjhSHOudkrDJGl2VlUyRG8XiWp64tSft5BHhtlN0RWNCm6uvc8nyxUIilMLXEB8wPLHcXDEGCBjo1ofu5feeiMZJOmyF7Z4WGgKyGwkKRP35pbcLksm+gjV6FFRImRr0adciDH3MFNUYU1gScOntl44jNMPZKXCwcFPI0/nvysQ+VeS73CfAqIYQSc+8/P7uu+cPC9im7YKlsDphBAH4f9ViXebsxdufEc1AtPJubNgfwhKQpvD4pdHSPfeXlMUeajhF8GDmBde+7DQlWsSFHGodeWDLI3tD2mk2t/dM6DyEV2sAm3z4ofUuguMxqRE5JTuE6aJYWyk/AZc9LcrUn5nQV36/+vLZEtVgcr2/E88v+c7qXvoZ5OQ8hc+ePVQMvBs/zNgLmJh+cQkvnA2QlPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bGKuJPMTzJ93/1j6gsmDNEXcB5zImKQNwsbUkZohDaL8hrc6vEE/PU6I5/bxi62n74e0dQ9en3t8KML2hHHiirXukdXokr3xeIVaQGeqXWzUT3ETTr4oMz8l0ibcquevbVAUN78SYbcNwMMM0r1zvlEfdyK4JLInoi10OznqPVpZlu0ufxlyuXDfO/88aeqhpZnuC52cBBzel0NEoGt5BHmw5oCauV0Fd2O2uuS+Nh4lZZh+7oerdpuJrSh942TlLR5oBRRfP7q059E8eroo3RyHgdoBIBs0/ayS9wLg/3N+uC7sOVHjk3FhaQ0QPSGBE/wfGcOL4x5bCqrqOwy/HdAK5RB5BBnwhn/RzL1PnJxS42hwcIOgX2d3+jGG6vI93o/2eCRIUMIvREVSh1xxm4SklmrZYik4I5dm84YC5YG9UOZuaSaAVdRBxx4jxOZq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:02.3353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e3ce85-d5e3-4721-9570-08de846197af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <kevinyang.wang@amd.com>

Setup driver pptable and initialize data from static metrics table for
smu_v15_0_8

v2: Remove unrelated changes and update description (Lijo)

v3: Use ARRAY_SIZE (Lijo)

v4: Move structure to header file

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   1 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 210 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  |  30 +++
 4 files changed, 237 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 892c90b8d063b..49e7881750fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -690,6 +690,7 @@ enum amdgpu_uid_type {
 	AMDGPU_UID_TYPE_XCD,
 	AMDGPU_UID_TYPE_AID,
 	AMDGPU_UID_TYPE_SOC,
+	AMDGPU_UID_TYPE_MID,
 	AMDGPU_UID_TYPE_MAX
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 95c77e926e1fe..06842d38c92bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -109,6 +109,7 @@ struct smu_15_0_dpm_context {
 	uint32_t                    workload_policy_mask;
 	uint32_t                    dcef_min_ds_clk;
 	uint64_t                    caps;
+	uint32_t		    board_volt;
 };
 
 enum smu_15_0_power_state {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index ae2e0d44b1da1..82b09fe7fccd5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -35,6 +35,7 @@
 #include "mp/mp_15_0_8_offset.h"
 #include "mp/mp_15_0_8_sh_mask.h"
 #include "smu_v15_0.h"
+#include "amdgpu_fru_eeprom.h"
 
 #undef MP1_Public
 
@@ -51,6 +52,10 @@
 #undef pr_info
 #undef pr_debug
 
+#define SMUQ10_TO_UINT(x) ((x) >> 10)
+#define SMUQ10_FRAC(x) ((x) & 0x3ff)
+#define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 #define SMU_15_0_8_FEA_MAP(smu_feature, smu_15_0_8_feature)                    \
@@ -161,6 +166,35 @@ static const struct cmn2asic_mapping smu_v15_0_8_table_map[SMU_TABLE_COUNT] = {
 
 static int smu_v15_0_8_tables_init(struct smu_context *smu)
 {
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	int gpu_metrcs_size = sizeof(MetricsTable_t);
+	void *driver_pptable __free(kfree) = NULL;
+	void *metrics_table __free(kfree) = NULL;
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU15_TOOL_SIZE,
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
+		       gpu_metrcs_size,
+		       PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
+
+	metrics_table = kzalloc(gpu_metrcs_size, GFP_KERNEL);
+	if (!metrics_table)
+		return -ENOMEM;
+
+	smu_table->metrics_time = 0;
+
+	driver_pptable = kzalloc(sizeof(PPTable_t), GFP_KERNEL);
+	if (!driver_pptable)
+		return -ENOMEM;
+
+	smu_table->metrics_table = no_free_ptr(metrics_table);
+	smu_table->driver_pptable = no_free_ptr(driver_pptable);
+
+	mutex_init(&smu_table->metrics_lock);
+
 	return 0;
 }
 
@@ -197,16 +231,35 @@ static int smu_v15_0_8_init_smc_tables(struct smu_context *smu)
 	return ret;
 }
 
-static int smu_v15_0_8_init_allowed_features(struct smu_context *smu)
+static int smu_v15_0_8_tables_fini(struct smu_context *smu)
 {
-	/* pptable will handle the features to enable */
-	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	mutex_destroy(&smu_table->metrics_lock);
 
 	return 0;
 }
 
-static int smu_v15_0_8_set_default_dpm_table(struct smu_context *smu)
+static int smu_v15_0_8_fini_smc_tables(struct smu_context *smu)
 {
+	int ret;
+
+	ret = smu_v15_0_8_tables_fini(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_v15_0_fini_smc_tables(smu);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int smu_v15_0_8_init_allowed_features(struct smu_context *smu)
+{
+	/* pptable will handle the features to enable */
+	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
+
 	return 0;
 }
 
@@ -258,6 +311,153 @@ static int smu_v15_0_8_get_static_metrics_table(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v15_0_8_fru_get_product_info(struct smu_context *smu,
+					    StaticMetricsTable_t *static_metrics)
+{
+	struct amdgpu_fru_info *fru_info;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!adev->fru_info) {
+		adev->fru_info = kzalloc(sizeof(*adev->fru_info), GFP_KERNEL);
+		if (!adev->fru_info)
+			return -ENOMEM;
+	}
+
+	fru_info = adev->fru_info;
+	strscpy(fru_info->product_number, static_metrics->ProductInfo.ModelNumber,
+		sizeof(fru_info->product_number));
+	strscpy(fru_info->product_name, static_metrics->ProductInfo.Name,
+		sizeof(fru_info->product_name));
+	strscpy(fru_info->serial, static_metrics->ProductInfo.Serial,
+		sizeof(fru_info->serial));
+	strscpy(fru_info->manufacturer_name, static_metrics->ProductInfo.ManufacturerName,
+		sizeof(fru_info->manufacturer_name));
+	strscpy(fru_info->fru_id, static_metrics->ProductInfo.FruId,
+		sizeof(fru_info->fru_id));
+
+	return 0;
+}
+
+static void smu_v15_0_8_init_xgmi_data(struct smu_context *smu,
+				       StaticMetricsTable_t *static_metrics)
+{
+	uint16_t max_speed;
+	uint8_t max_width;
+
+	max_width = (uint8_t)static_metrics->MaxXgmiWidth;
+	max_speed = (uint16_t)static_metrics->MaxXgmiBitrate;
+	amgpu_xgmi_set_max_speed_width(smu->adev, max_speed, max_width);
+}
+
+static int smu_v15_0_8_set_driver_pptable(struct smu_context *smu)
+{
+	struct smu_15_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+	int ret, i, n;
+	uint32_t table_version;
+
+	if (!pptable->init) {
+		ret = smu_v15_0_8_get_static_metrics_table(smu);
+		if (ret)
+			return ret;
+
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
+					   &table_version);
+		if (ret)
+			return ret;
+		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
+			table_version;
+
+		pptable->MaxSocketPowerLimit =
+			SMUQ10_ROUND(static_metrics->MaxSocketPowerLimit);
+		pptable->MaxGfxclkFrequency =
+			SMUQ10_ROUND(static_metrics->MaxGfxclkFrequency);
+		pptable->MinGfxclkFrequency =
+			SMUQ10_ROUND(static_metrics->MinGfxclkFrequency);
+		pptable->MaxFclkFrequency =
+			SMUQ10_ROUND(static_metrics->MaxFclkFrequency);
+		pptable->MinFclkFrequency =
+			SMUQ10_ROUND(static_metrics->MinFclkFrequency);
+		pptable->MaxGl2clkFrequency =
+			SMUQ10_ROUND(static_metrics->MaxGl2clkFrequency);
+		pptable->MinGl2clkFrequency =
+			SMUQ10_ROUND(static_metrics->MinGl2clkFrequency);
+
+		for (i = 0; i < ARRAY_SIZE(static_metrics->UclkFrequencyTable); ++i)
+			pptable->UclkFrequencyTable[i] =
+				SMUQ10_ROUND(static_metrics->UclkFrequencyTable[i]);
+
+		pptable->SocclkFrequency = SMUQ10_ROUND(static_metrics->SocclkFrequency);
+		pptable->LclkFrequency = SMUQ10_ROUND(static_metrics->LclkFrequency);
+		pptable->VclkFrequency = SMUQ10_ROUND(static_metrics->VclkFrequency);
+		pptable->DclkFrequency = SMUQ10_ROUND(static_metrics->DclkFrequency);
+
+		pptable->CTFLimitMID = SMUQ10_ROUND(static_metrics->CTFLimit_MID);
+		pptable->CTFLimitAID = SMUQ10_ROUND(static_metrics->CTFLimit_AID);
+		pptable->CTFLimitXCD = SMUQ10_ROUND(static_metrics->CTFLimit_XCD);
+		pptable->CTFLimitHBM = SMUQ10_ROUND(static_metrics->CTFLimit_HBM);
+		pptable->ThermalLimitMID = SMUQ10_ROUND(static_metrics->ThermalLimit_MID);
+		pptable->ThermalLimitAID = SMUQ10_ROUND(static_metrics->ThermalLimit_AID);
+		pptable->ThermalLimitXCD = SMUQ10_ROUND(static_metrics->ThermalLimit_XCD);
+		pptable->ThermalLimitHBM = SMUQ10_ROUND(static_metrics->ThermalLimit_HBM);
+
+		/* use MID0 serial number by default */
+		pptable->PublicSerialNumberMID =
+			static_metrics->PublicSerialNumber_MID[0];
+
+		amdgpu_device_set_uid(smu->adev->uid_info, AMDGPU_UID_TYPE_SOC,
+				      0, pptable->PublicSerialNumberMID);
+		pptable->PublicSerialNumberAID =
+			static_metrics->PublicSerialNumber_AID[0];
+		pptable->PublicSerialNumberXCD =
+			static_metrics->PublicSerialNumber_XCD[0];
+		n = ARRAY_SIZE(static_metrics->PublicSerialNumber_MID);
+		for (i = 0; i < n; i++) {
+			amdgpu_device_set_uid(smu->adev->uid_info, AMDGPU_UID_TYPE_MID, i,
+					      static_metrics->PublicSerialNumber_MID[i]);
+		}
+		n = ARRAY_SIZE(static_metrics->PublicSerialNumber_AID);
+		for (i = 0; i < n; i++) {
+			amdgpu_device_set_uid(smu->adev->uid_info, AMDGPU_UID_TYPE_AID, i,
+					      static_metrics->PublicSerialNumber_AID[i]);
+		}
+		n = ARRAY_SIZE(static_metrics->PublicSerialNumber_XCD);
+		for (i = 0; i < n; i++) {
+			amdgpu_device_set_uid(smu->adev->uid_info, AMDGPU_UID_TYPE_XCD, i,
+					      static_metrics->PublicSerialNumber_XCD[i]);
+		}
+
+		ret = smu_v15_0_8_fru_get_product_info(smu, static_metrics);
+		if (ret)
+			return ret;
+		pptable->PPT1Max = static_metrics->PPT1Max;
+		pptable->PPT1Min = static_metrics->PPT1Min;
+		pptable->PPT1Default = static_metrics->PPT1Default;
+
+		if (static_metrics->pldmVersion[0] != 0xFFFFFFFF)
+			smu->adev->firmware.pldm_version =
+				static_metrics->pldmVersion[0];
+		dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
+		smu_v15_0_8_init_xgmi_data(smu, static_metrics);
+		pptable->init = true;
+	}
+
+	return 0;
+}
+
+static int smu_v15_0_8_set_default_dpm_table(struct smu_context *smu)
+{
+	int ret;
+
+	ret = smu_v15_0_8_set_driver_pptable(smu);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int smu_v15_0_8_irq_process(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
@@ -498,7 +698,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
 	.is_dpm_running = smu_v15_0_8_is_dpm_running,
 	.init_smc_tables = smu_v15_0_8_init_smc_tables,
-	.fini_smc_tables = smu_v15_0_fini_smc_tables,
+	.fini_smc_tables = smu_v15_0_8_fini_smc_tables,
 	.init_power = smu_v15_0_init_power,
 	.fini_power = smu_v15_0_fini_power,
 	.check_fw_status = smu_v15_0_8_check_fw_status,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 40c410928c966..6c85f23d31116 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -25,4 +25,34 @@
 
 extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
 
+typedef struct {
+	uint32_t MaxSocketPowerLimit;
+	uint32_t MaxGfxclkFrequency;
+	uint32_t MinGfxclkFrequency;
+	uint32_t MaxFclkFrequency;
+	uint32_t MinFclkFrequency;
+	uint32_t MaxGl2clkFrequency;
+	uint32_t MinGl2clkFrequency;
+	uint32_t UclkFrequencyTable[4];
+	uint32_t SocclkFrequency;
+	uint32_t LclkFrequency;
+	uint32_t VclkFrequency;
+	uint32_t DclkFrequency;
+	uint32_t CTFLimitMID;
+	uint32_t CTFLimitAID;
+	uint32_t CTFLimitXCD;
+	uint32_t CTFLimitHBM;
+	uint32_t ThermalLimitMID;
+	uint32_t ThermalLimitAID;
+	uint32_t ThermalLimitXCD;
+	uint32_t ThermalLimitHBM;
+	uint64_t PublicSerialNumberMID;
+	uint64_t PublicSerialNumberAID;
+	uint64_t PublicSerialNumberXCD;
+	uint32_t PPT1Max;
+	uint32_t PPT1Min;
+	uint32_t PPT1Default;
+	bool init;
+} PPTable_t;
+
 #endif
-- 
2.53.0

