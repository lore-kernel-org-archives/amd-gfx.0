Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA92BFEDA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC1110E646;
	Tue, 17 Mar 2026 20:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G4jgpFnu";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1396910E65F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrIR7xen+ndE/c9l9PFVeJgk9nn/3LlJV0gDXOXPXNFJjdQH50TUgpWmdk1FlP+/EPmYXKNy92BMb+yCvI/FhbjsHfCH4sQJmCcvNiutdsEN4zXGsEaMO3LriBkA9PSA5YfNAEk+at4l3TBnXDaUC8ajZy6I7KmfGucVWoZIPSKsST+OHReUoiLs6hlMitxExgFsEhD2LorJ2zzM6ao2bQPIThSd77vOTRoNAWXagToIGBJcjCkByA3r935MG6+S7HsUpUo7QP/g/sauYQr4a+no6KOGk+ZYeyKSryvc8UMBbetvPCTcvlpk07+bcHPD8BkSbTLSS4d40b/IfLH8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqDIBuJs/QHBezbi4+HG+VSSKhwMsWzHkydJqyaA3tE=;
 b=NQLh6QJdC86TV/A6CZO90Qwk79M9AdAzBESloplGi0WDr0DjBT/TH0jkp9n6TvjB3v/36kOELwlgqGz96OzV4L4guOV+v560F79bYjgzeDxW51W27+QT0v3KJEb7n0lc84nBTPy/jY+dsY0vei849ld4rKOLHPUUK2kbYIFslJMQsP0UfnVL/unJ1cDIqFeYJIrqbOQUxP4vIsSRFOVp4REEjzJhGXuM9CsAmXrM5tS+nE3CdwqIHeB1mk4iVTYmWqK9PbIzDn0XZfKHkLhk97/YlOp27RD9+Ljup0Fw6yKKxkeFwH7dDjp+56OWlCdlDQ0OgK879eVaIGXTXlIZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqDIBuJs/QHBezbi4+HG+VSSKhwMsWzHkydJqyaA3tE=;
 b=G4jgpFnuE10Ap4ETzevwf9bAdG7FbVvje16HPLVXl7V89l1QjOckL90OXQ0ZDbd2QMwQf9RS9HMGgkSHoji86Z/ItLgo/3lclROcbNHoX7X4Rf4h3LrI+aYeo7JJyjAURyU/n3wPF/qJFtfbQLi4BrgEQFs2WUvM4zA0sIij3Q4=
Received: from PH7PR17CA0004.namprd17.prod.outlook.com (2603:10b6:510:324::15)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 20:13:22 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::1b) by PH7PR17CA0004.outlook.office365.com
 (2603:10b6:510:324::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:13:09 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 22/25] drm/amd/pm: Add baseboard temperature metrics support
Date: Tue, 17 Mar 2026 16:12:38 -0400
Message-ID: <20260317201242.3808136-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a5844e-dd2e-43fe-fdbe-08de8461a352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: D0bL//2+2l0nWg4kFCeg4PhnvgVywvsBJB3lawW+zCOHhugx2LHzeY96fe3YMWVBPiCg1FFJBmcTQVfK+hwDi8wkoke1HqkDI0y3zwUmpbF3PHCF3SjEzXKpFJjSn4k9zRL+laN4JiN7D3GnqsrwmP34LaL7SEvEsf3NukXWznvuC2juAHUYOnz1tLgjfGoa2EF/eaAbB0XxxD8AW3rhAt2HqPjl+UYIU9MLhfqU1nhigHS/ETF/RT4oy7ZnMZCKO7ARBTYJNLbK/GYB/WTBnL3omQELsnr4jHatv77sw6RgOWnZ6FeUWh8gMvFr7k5IAzQp02H5DlgIhkFTwj9ezf3zGPsCZ2wxHmRCdm/4gP3DqZuOpPKF6cRRS8lUKwSOXG9phsX3VFgoD5S2GMoPP5X2ytnIT6ABrxaWV9xynMXlS0r3cfmVDIBp/3PCY28Klk4EgLcO0et8e3JONrOndf/5QNzGnK/3OTk5rOP7LEvLWWTyO7jzDiCSe8ScsvcsRj9zv0SOKGa2A7ThDdmAcoiH0dULNiEQdbRwlX5bl6nwEG6zPVoILkIQtNo/Oh/R/8u9nN8lAcxL8TGzv1eKKzj4bg50RmMNkZW1R16qQSatY9OjKNKrwE1LtGVOclqc3NMrnlazRFLe8mOE7P12utClHGQpYVBUd38TZKyV7sGgEDXUpKDX1TdMtWaJQiCyb6NKPjCA1Vf5KO+wI404X7HlmaoZPKM8WRnIsu8KA3EQRqcw7YBDZo2rZDCGoIsRsF6zCv0N6JzRThZIB9vY/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zkuzz8Wq5n7TdHRhu+42L13jZTQNiHNYAtgZfuI6LDHM59puBorF/LZk86RlHLf0AKueHQX7Q5mzAlzSC7JOYfEzWlJnUJSnfjRynHPhXRy38bM8YiPidd95/iRHE62ZNs+iNEXB1NK9nBbkWwnxdWToTdyiogmCwaQfBAqP85FvpqPEzwNUOHbVCP5SxL4BVS7ElflJdJLZZfyqY3/bFM1u7auQQ3+ZD89JnNAyAOD8t19MzbkqyU88yXwsA+tNCAF3n4ZNtYdgVYMU7BcNuhhDg+VqoDJXu8IC7BaVsaeSqxDmYMuBgv9LfQciuTA9GAqJWUJc3Oc2Oy3nyWqFo2t921nWGd75eVGQQF5+tI6vO+7ojYouGH+Z6eBEujTnBFEa5KrCepxrcRmffWyRVCaSS/yhbmQqlUw80nEtQp7kaSXsm4kNsuiFlfyLLP7X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:21.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a5844e-dd2e-43fe-fdbe-08de8461a352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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

From: Asad Kamal <asad.kamal@amd.com>

Add baseboard temperature metrics support via system metrics table for
smu_v15_0_8

v4: Add separate function to fill baseboard temperature, use 16, remove
casting

v5: Optimize to use single switch case (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  29 +++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 110 +++++++++++++++---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  |  58 +++++++++
 3 files changed, 184 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 04efa127a3dd9..83bd621691829 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -617,6 +617,29 @@ enum amdgpu_metrics_attr_id {
 	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_065_UCIEAM_A,
 	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_065_UCIEAM_C,
 	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDAN_075,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_FPGA,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_FRONT,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_BACK,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_OAM7,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_IBC,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_UFPGA,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_OAM1,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_0_1_HSC,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_2_3_HSC,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_4_5_HSC,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_6_7_HSC,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_FPGA_0V72_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_UBB_FPGA_3V3_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_RETIMER_0_1_0V9_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_RETIMER_4_5_0V9_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_RETIMER_2_3_0V9_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_RETIMER_6_7_0V9_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC_HSC,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC,
 	AMDGPU_METRICS_ATTR_ID_MAX,
 };
 
@@ -1875,4 +1898,10 @@ struct amdgpu_gpuboard_temp_metrics_v1_1 {
 	struct gpu_metrics_attr metrics_attrs[];
 };
 
+struct amdgpu_baseboard_temp_metrics_v1_1 {
+	struct metrics_table_header common_header;
+	int attr_count;
+	struct gpu_metrics_attr metrics_attrs[];
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index e6895e03aa3a8..aec0b6872f924 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -178,6 +178,7 @@ static size_t smu_v15_0_8_get_system_metrics_size(void)
 
 static int smu_v15_0_8_tables_init(struct smu_context *smu)
 {
+	struct smu_v15_0_8_baseboard_temp_metrics *baseboard_temp_metrics;
 	struct smu_v15_0_8_gpuboard_temp_metrics *gpuboard_temp_metrics;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	int ret, gpu_metrcs_size = sizeof(MetricsTable_t);
@@ -223,11 +224,23 @@ static int smu_v15_0_8_tables_init(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	/* Initialize base board temperature metrics */
+	ret = smu_driver_table_init(smu,
+				    SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS,
+				    sizeof(*baseboard_temp_metrics), 50);
+	if (ret)
+		return ret;
+	baseboard_temp_metrics = (struct smu_v15_0_8_baseboard_temp_metrics *)
+		smu_driver_table_ptr(smu,
+				     SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
+	smu_v15_0_8_baseboard_temp_metrics_init(baseboard_temp_metrics, 1, 1);
 	/* Initialize GPU board temperature metrics */
 	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS,
 				    sizeof(*gpuboard_temp_metrics), 50);
 	if (ret) {
 		smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
+		smu_driver_table_fini(smu,
+				      SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
 		return ret;
 	}
 	gpuboard_temp_metrics = (struct smu_v15_0_8_gpuboard_temp_metrics *)
@@ -280,6 +293,7 @@ static int smu_v15_0_8_tables_fini(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
 	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS);
 	smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
 	mutex_destroy(&smu_table->metrics_lock);
@@ -1353,6 +1367,10 @@ static bool smu_v15_0_8_is_temp_metrics_supported(struct smu_context *smu,
 						  enum smu_temp_metric_type type)
 {
 	switch (type) {
+	case SMU_TEMP_METRIC_BASEBOARD:
+		if (smu->adev->gmc.xgmi.physical_node_id == 0)
+			return true;
+		return false;
 	case SMU_TEMP_METRIC_GPUBOARD:
 		return true;
 	default:
@@ -1360,6 +1378,62 @@ static bool smu_v15_0_8_is_temp_metrics_supported(struct smu_context *smu,
 	}
 }
 
+static void smu_v15_0_8_fill_baseboard_temp_metrics(
+	struct smu_v15_0_8_baseboard_temp_metrics *baseboard_temp_metrics,
+	const SystemMetricsTable_t *metrics)
+{
+	baseboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
+	baseboard_temp_metrics->label_version = metrics->LabelVersion;
+	baseboard_temp_metrics->node_id = metrics->NodeIdentifier;
+
+	baseboard_temp_metrics->system_temp_ubb_fpga =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_FPGA];
+	baseboard_temp_metrics->system_temp_ubb_front =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_FRONT];
+	baseboard_temp_metrics->system_temp_ubb_back =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_BACK];
+	baseboard_temp_metrics->system_temp_ubb_oam7 =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_OAM7];
+	baseboard_temp_metrics->system_temp_ubb_ibc =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_IBC];
+	baseboard_temp_metrics->system_temp_ubb_ufpga =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_UFPGA];
+	baseboard_temp_metrics->system_temp_ubb_oam1 =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_OAM1];
+	baseboard_temp_metrics->system_temp_oam_0_1_hsc =
+		metrics->SystemTemperatures[SYSTEM_TEMP_OAM_0_1_HSC];
+	baseboard_temp_metrics->system_temp_oam_2_3_hsc =
+		metrics->SystemTemperatures[SYSTEM_TEMP_OAM_2_3_HSC];
+	baseboard_temp_metrics->system_temp_oam_4_5_hsc =
+		metrics->SystemTemperatures[SYSTEM_TEMP_OAM_4_5_HSC];
+	baseboard_temp_metrics->system_temp_oam_6_7_hsc =
+		metrics->SystemTemperatures[SYSTEM_TEMP_OAM_6_7_HSC];
+	baseboard_temp_metrics->system_temp_ubb_fpga_0v72_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_FPGA_0V72_VR];
+	baseboard_temp_metrics->system_temp_ubb_fpga_3v3_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_UBB_FPGA_3V3_VR];
+	baseboard_temp_metrics->system_temp_retimer_0_1_2_3_1v2_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR];
+	baseboard_temp_metrics->system_temp_retimer_4_5_6_7_1v2_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR];
+	baseboard_temp_metrics->system_temp_retimer_0_1_0v9_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_RETIMER_0_1_0V9_VR];
+	baseboard_temp_metrics->system_temp_retimer_4_5_0v9_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_RETIMER_4_5_0V9_VR];
+	baseboard_temp_metrics->system_temp_retimer_2_3_0v9_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_RETIMER_2_3_0V9_VR];
+	baseboard_temp_metrics->system_temp_retimer_6_7_0v9_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_RETIMER_6_7_0V9_VR];
+	baseboard_temp_metrics->system_temp_oam_0_1_2_3_3v3_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR];
+	baseboard_temp_metrics->system_temp_oam_4_5_6_7_3v3_vr =
+		metrics->SystemTemperatures[SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR];
+	baseboard_temp_metrics->system_temp_ibc_hsc =
+		metrics->SystemTemperatures[SYSTEM_TEMP_IBC_HSC];
+	baseboard_temp_metrics->system_temp_ibc =
+		metrics->SystemTemperatures[SYSTEM_TEMP_IBC];
+}
+
 static void smu_v15_0_8_fill_gpuboard_temp_metrics(
 	struct smu_v15_0_8_gpuboard_temp_metrics *gpuboard_temp_metrics,
 	const SystemMetricsTable_t *metrics)
@@ -1429,33 +1503,43 @@ static ssize_t smu_v15_0_8_get_temp_metrics(struct smu_context *smu,
 					    enum smu_temp_metric_type type,
 					    void *table)
 {
+	struct smu_v15_0_8_baseboard_temp_metrics *baseboard_temp_metrics;
 	struct smu_v15_0_8_gpuboard_temp_metrics *gpuboard_temp_metrics;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	enum smu_driver_table_id table_id;
 	SystemMetricsTable_t *metrics;
 	struct smu_table *sys_table;
-	ssize_t size;
 	int ret;
 
-	table_id = SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
-	gpuboard_temp_metrics =
-		(struct smu_v15_0_8_gpuboard_temp_metrics *)
-		smu_driver_table_ptr(smu, table_id);
-	size = sizeof(*gpuboard_temp_metrics);
-
 	ret = smu_v15_0_8_get_system_metrics_table(smu);
 	if (ret)
 		return ret;
 
 	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
 	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
-	smu_driver_table_update_cache_time(smu, table_id);
 
-	smu_v15_0_8_fill_gpuboard_temp_metrics(gpuboard_temp_metrics,
-						      metrics);
-	memcpy(table, gpuboard_temp_metrics, size);
-	return size;
+	switch (type) {
+	case SMU_TEMP_METRIC_GPUBOARD:
+		gpuboard_temp_metrics =
+			(struct smu_v15_0_8_gpuboard_temp_metrics *)
+			smu_driver_table_ptr(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS);
+		smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS);
+		smu_v15_0_8_fill_gpuboard_temp_metrics(gpuboard_temp_metrics,
+						       metrics);
+		memcpy(table, gpuboard_temp_metrics, sizeof(*gpuboard_temp_metrics));
+		return sizeof(*gpuboard_temp_metrics);
+	case SMU_TEMP_METRIC_BASEBOARD:
+		baseboard_temp_metrics =
+			(struct smu_v15_0_8_baseboard_temp_metrics *)
+			smu_driver_table_ptr(smu, SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
+		smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
+		smu_v15_0_8_fill_baseboard_temp_metrics(baseboard_temp_metrics,
+							metrics);
+		memcpy(table, baseboard_temp_metrics, sizeof(*baseboard_temp_metrics));
+		return sizeof(*baseboard_temp_metrics);
+	default:
+		return -EINVAL;
+	}
 }
 
 static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 0856d11d8e55e..398ce44821741 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -182,6 +182,7 @@ typedef struct {
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
 
 /* Maximum temperature sensor counts for system metrics */
+#define SMU_15_0_8_MAX_SYSTEM_TEMP_ENTRIES	32
 #define SMU_15_0_8_MAX_NODE_TEMP_ENTRIES	12
 #define SMU_15_0_8_MAX_VR_TEMP_ENTRIES		22
 
@@ -251,5 +252,62 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpuboard_temp_metrics,
 			  SMU_15_0_8_GPUBOARD_TEMP_METRICS_FIELDS);
 
+/* SMUv 15.0.8 Baseboard temperature metrics - ID-based approach */
+#define SMU_15_0_8_BASEBOARD_TEMP_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)        \
+	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U64), accumulation_counter);                      \
+	SMU_SCALAR(SMU_MATTR(LABEL_VERSION), SMU_MUNIT(NONE),                  \
+		   SMU_MTYPE(U16), label_version);                             \
+	SMU_SCALAR(SMU_MATTR(NODE_ID), SMU_MUNIT(NONE),                        \
+		   SMU_MTYPE(U16), node_id);                                   \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_FPGA), SMU_MUNIT(TEMP_1),         \
+		   SMU_MTYPE(S16), system_temp_ubb_fpga);                      \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_FRONT), SMU_MUNIT(TEMP_1),        \
+		   SMU_MTYPE(S16), system_temp_ubb_front);                     \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_BACK), SMU_MUNIT(TEMP_1),         \
+		   SMU_MTYPE(S16), system_temp_ubb_back);                      \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_OAM7), SMU_MUNIT(TEMP_1),         \
+		   SMU_MTYPE(S16), system_temp_ubb_oam7);                      \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_IBC), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(S16), system_temp_ubb_ibc);                       \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_UFPGA), SMU_MUNIT(TEMP_1),        \
+		   SMU_MTYPE(S16), system_temp_ubb_ufpga);                     \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_OAM1), SMU_MUNIT(TEMP_1),         \
+		   SMU_MTYPE(S16), system_temp_ubb_oam1);                      \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_OAM_0_1_HSC), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), system_temp_oam_0_1_hsc);                   \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_OAM_2_3_HSC), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), system_temp_oam_2_3_hsc);                   \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_OAM_4_5_HSC), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), system_temp_oam_4_5_hsc);                   \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_OAM_6_7_HSC), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), system_temp_oam_6_7_hsc);                   \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_FPGA_0V72_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_ubb_fpga_0v72_vr);              \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_UBB_FPGA_3V3_VR), SMU_MUNIT(TEMP_1),  \
+		   SMU_MTYPE(S16), system_temp_ubb_fpga_3v3_vr);               \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_retimer_0_1_2_3_1v2_vr);        \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_retimer_4_5_6_7_1v2_vr);        \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_RETIMER_0_1_0V9_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_retimer_0_1_0v9_vr);            \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_RETIMER_4_5_0V9_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_retimer_4_5_0v9_vr);            \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_RETIMER_2_3_0V9_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_retimer_2_3_0v9_vr);            \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_RETIMER_6_7_0V9_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_retimer_6_7_0v9_vr);            \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_oam_0_1_2_3_3v3_vr);            \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR), SMU_MUNIT(TEMP_1), \
+		   SMU_MTYPE(S16), system_temp_oam_4_5_6_7_3v3_vr);            \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_IBC_HSC), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(S16), system_temp_ibc_hsc);                       \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_IBC), SMU_MUNIT(TEMP_1),              \
+		   SMU_MTYPE(S16), system_temp_ibc);
+
+DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_baseboard_temp_metrics,
+			  SMU_15_0_8_BASEBOARD_TEMP_METRICS_FIELDS);
 #endif
 #endif
-- 
2.53.0

