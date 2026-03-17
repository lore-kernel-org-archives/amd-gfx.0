Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B052FD708D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E9710E65F;
	Tue, 17 Mar 2026 20:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IoHI4JMp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E036410E6A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlNoWyLobfE6ZVMe8gY+xoSQ6ueBQtAem7FZiIwnOnlCgbaa1jP5FDeRXgiPbgiAZTSRk3Gtzzwio/r9nzWUkOoZXZ9hxfchi0Q80Zt5R5oR5r1bXer5lnncOvVfOBPo7hSTbhBVrqlMkdogvj5JKD3E7LcD3ATJbNy0FDY6Tw2VGDPDw1wqp/Vbl86cdFqkRUQfDQevZ6YEyX+/PuL/vsWWCvWXosG2mrknEGtzfrYABbkwqKN2JMaecKYzqQ+Wf6EBektdB1mDQRPBc+dZhNsg+wZi4KHVEbIco/tN5z1Pp6fofYX9/1CB69fBe0M8AVlLCe/tNlLsNf/u/ntBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UghX6k/pIvm86IsqLI6LojYixDywFjPhW1spSUxUZ8E=;
 b=WzbAOZfycstnnU+ADSWUbfc2qw1vEWod5WnCAGB5Ocks21rIhafhsZF/Wt+LB+gBq9+XPIDfxut3IHT9WzNwglQc3+QEti6Ts7NUzkuG/Vd6vGEOcY8MsO8D4Bo1LKGB9Lpx0UdR+fQ1L3UbWr5AOEFYRXJTEFV7DqempiFYFB0hwVbpoVNp5qckL3spHrvZZGzHVYfk6SDy0/vM+9yDkn4nJFEPSFWxNZjfQriUZfZliN76GLsuH49/HtBahIsw5UoNa1dOCDap/YKd/ZtN3ZXP0g1oCsVpSR1rWA8ROsRRvgH6NKDCPldrCt9hEIFWW6hL8lOYVfMKTCZYy3iaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UghX6k/pIvm86IsqLI6LojYixDywFjPhW1spSUxUZ8E=;
 b=IoHI4JMp91lWhjhcEqSiRb+SH4+xhcMr+5UvmdIBxgrgPi4onI0rrpxYfqABYeOP2ASn6S4dsFVraqBlBXzRo51gYGC8z6NM6kWPdaPD+NpZISCIQCcEfzs7qB4plyWZp71OjFeAxs3dTz8P2RDLeIWzBDdDjNMYCOcFtWLSvbs=
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 20:13:25 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::e2) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 20:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 21/25] drm/amd/pm: Add gpuboard temperature metrics support
Date: Tue, 17 Mar 2026 16:12:37 -0400
Message-ID: <20260317201242.3808136-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e2d953-c770-4dd2-2a0d-08de8461a56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ofzvh7h7lOQHCQYuBeP3zZW3sAan6yySnFJ9sfLtLnwK8wZ1N3L4UfeSnUiUIfwS+QTkNOfHDz5d5i5USwJJlhBHoj8jqoHjZCRmEcDPLWeFMQPg4gPdT3JJqq8MntnM3vaOPwxYlisfMX8aUBM3PwLZDd3Id/kj26tNgI97uzkkkKkKfuKCt0XpC8yXVPKdWSowkln+ULuPhiVonFJnUwXvNKLSIi854nSZ5fE8sWWtufA9gNvJSahiiWuTCkoKag7V85bIc8qWkgZDPNRBRle1LkTJb0h9Yu8uSQV3Cb5kEX2AesZEZNW+3k9eoTz1kjfOBiyjDtrveByNdmBJPauz+Sdw88Saw+NSdru8+FflBtrVE9511nzJg0TPnoJFSWYjGf2t0eLb205OeNUFatV9zNjxlFe+n4AipdAGqMgww3ZUaDoFR4HlMgGYz5SJhNTwQeazN5WqdeREG22S/H3TxiqKUx8y3Rh+a68/AwBTTYqN4QXhy9kr5JTEYAV+a2XKBfyqwdFMVMwfWrzUJDaRoAmdcYqVsKMfkMR8BWmSiqvMaiuuqkvSY8QT8fmqtNXd7WV4zhkFX0SJPuXv4kkQ1NYF78RSg0EOpto0ITJ9X1zLC0bh4+mtimArjvdCWolGOyZS6WM2uZ2ZJfFQVBH8GvzdijIcaOeUVIgfiMW5cQnASkwdUaYpUuRxyyLp1gxFT4/hPq5eF8dfwF2iOUMY9aWjcwmjsuTsMHtBnjnBlaY46f/R3AdCXwZx/xSBSrd7OX3xayU879jjzys+8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b5sOg4KTh8/i3+uhD1CrH9LgerbRn8FX86NHlIILphrO1UMhgb/AUUwifZR7yXgv2tS6BqZo/WuByx2kff0JRhhjMyt0xmF0mFyIOki8FvVIhp9t+lj5Fd4J9NS9Xipudi/Uu5f8fV5SCsM2hmMXRgI8b/sAn5FbY0rO7Krf4icyp3FrQjt0a+62tQa10ucEp7RG/OL8u++szNfTG9TT7cAAUgbDMm5/UyPHYSW8B5doCpgp4TgKSiBNfG0n4Aha0t/A3rFhZ6Z2rz3u3EXRxBGkP9SplFbOIYS3TKl/yOOn9oufNV7aDoKhyo1vbNhz99VzI6oNYoRKs0s9/15BUd52TQEMPDpqbBeTQOpI9tEDeU9KDrqco796tir8VKMp9DPVFt0gB1Y+9FxYshkrzFu8OeU1pG2w4DShkMknZ2njb7D4cAMm91cpJ1P2PwjM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:25.3979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e2d953-c770-4dd2-2a0d-08de8461a56c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

Add gpuboard temperature metrics support via system metrics table for
smu_v15_0_8

v3: Use per sensor attr id (Lijo)

v4: Use s16 for temp, remove cast, use separate function to fill
gpuboard temperature metrics data (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  35 ++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 172 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  |  71 ++++++++
 3 files changed, 278 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 22ee30f514c0a..04efa127a3dd9 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -588,6 +588,35 @@ enum amdgpu_metrics_attr_id {
 	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_MID,
 	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_AID,
 	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_XCD,
+	AMDGPU_METRICS_ATTR_ID_LABEL_VERSION,
+	AMDGPU_METRICS_ATTR_ID_NODE_ID,
+	AMDGPU_METRICS_ATTR_ID_NODE_TEMP_RETIMER,
+	AMDGPU_METRICS_ATTR_ID_NODE_TEMP_IBC,
+	AMDGPU_METRICS_ATTR_ID_NODE_TEMP_IBC_2,
+	AMDGPU_METRICS_ATTR_ID_NODE_TEMP_VDD18_VR,
+	AMDGPU_METRICS_ATTR_ID_NODE_TEMP_04_HBM_B_VR,
+	AMDGPU_METRICS_ATTR_ID_NODE_TEMP_04_HBM_D_VR,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_SOCIO_A,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_SOCIO_C,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_X0,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_X1,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_HBM_B,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_HBM_D,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_04_HBM_B,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_04_HBM_D,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_HBM_B,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_HBM_D,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_075_HBM_B,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_075_HBM_D,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_11_GTA_A,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_11_GTA_C,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDAN_075_GTA_A,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDAN_075_GTA_C,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDCR_075_UCIE,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_065_UCIEAA,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_065_UCIEAM_A,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDIO_065_UCIEAM_C,
+	AMDGPU_METRICS_ATTR_ID_VR_TEMP_VDDAN_075,
 	AMDGPU_METRICS_ATTR_ID_MAX,
 };
 
@@ -1840,4 +1869,10 @@ enum amdgpu_xgmi_link_status {
 	AMDGPU_XGMI_LINK_NA = 2,
 };
 
+struct amdgpu_gpuboard_temp_metrics_v1_1 {
+	struct metrics_table_header common_header;
+	int attr_count;
+	struct gpu_metrics_attr metrics_attrs[];
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index a2a640aaa0775..e6895e03aa3a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -171,8 +171,14 @@ static const struct cmn2asic_mapping smu_v15_0_8_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(I2C_COMMANDS),
 };
 
+static size_t smu_v15_0_8_get_system_metrics_size(void)
+{
+	return sizeof(SystemMetricsTable_t);
+}
+
 static int smu_v15_0_8_tables_init(struct smu_context *smu)
 {
+	struct smu_v15_0_8_gpuboard_temp_metrics *gpuboard_temp_metrics;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	int ret, gpu_metrcs_size = sizeof(MetricsTable_t);
 	struct smu_table *tables = smu_table->tables;
@@ -187,6 +193,9 @@ static int smu_v15_0_8_tables_init(struct smu_context *smu)
 		       gpu_metrcs_size,
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
+	SMU_TABLE_INIT(tables, SMU_TABLE_PMFW_SYSTEM_METRICS,
+		       smu_v15_0_8_get_system_metrics_size(), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
 	metrics_table = kzalloc(gpu_metrcs_size, GFP_KERNEL);
 	if (!metrics_table)
@@ -207,6 +216,25 @@ static int smu_v15_0_8_tables_init(struct smu_context *smu)
 	gpu_metrics = (struct smu_v15_0_8_gpu_metrics *)smu_driver_table_ptr(smu,
 		       SMU_DRIVER_TABLE_GPU_METRICS);
 	smu_v15_0_8_gpu_metrics_init(gpu_metrics, 1, 9);
+
+	ret = smu_table_cache_init(smu, SMU_TABLE_PMFW_SYSTEM_METRICS,
+				   smu_v15_0_8_get_system_metrics_size(), 5);
+
+	if (ret)
+		return ret;
+
+	/* Initialize GPU board temperature metrics */
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS,
+				    sizeof(*gpuboard_temp_metrics), 50);
+	if (ret) {
+		smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
+		return ret;
+	}
+	gpuboard_temp_metrics = (struct smu_v15_0_8_gpuboard_temp_metrics *)
+		smu_driver_table_ptr(smu,
+				     SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS);
+	smu_v15_0_8_gpuboard_temp_metrics_init(gpuboard_temp_metrics, 1, 1);
+
 	smu_table->metrics_table = no_free_ptr(metrics_table);
 	smu_table->driver_pptable = no_free_ptr(driver_pptable);
 
@@ -252,6 +280,8 @@ static int smu_v15_0_8_tables_fini(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS);
+	smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
 	mutex_destroy(&smu_table->metrics_lock);
 
 	return 0;
@@ -487,6 +517,33 @@ static int smu_v15_0_8_thermal_get_temperature(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_8_get_system_metrics_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *table = &smu_table->driver_table;
+	struct smu_table *tables = smu_table->tables;
+	struct smu_table *sys_table;
+	int ret;
+
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	if (smu_table_cache_is_valid(sys_table))
+		return 0;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
+	if (ret) {
+		dev_info(smu->adev->dev,
+			 "Failed to export system metrics table!\n");
+		return ret;
+	}
+
+	amdgpu_hdp_invalidate(smu->adev, NULL);
+	smu_table_cache_update_time(sys_table, jiffies);
+	memcpy(sys_table->cache.buffer, table->cpu_addr,
+	       sizeof(SystemMetricsTable_t));
+
+	return 0;
+}
+
 static int smu_v15_0_8_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor, void *data,
 				   uint32_t *size)
@@ -1292,6 +1349,115 @@ static int smu_v15_0_8_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static bool smu_v15_0_8_is_temp_metrics_supported(struct smu_context *smu,
+						  enum smu_temp_metric_type type)
+{
+	switch (type) {
+	case SMU_TEMP_METRIC_GPUBOARD:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void smu_v15_0_8_fill_gpuboard_temp_metrics(
+	struct smu_v15_0_8_gpuboard_temp_metrics *gpuboard_temp_metrics,
+	const SystemMetricsTable_t *metrics)
+{
+	gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
+	gpuboard_temp_metrics->label_version = metrics->LabelVersion;
+	gpuboard_temp_metrics->node_id = metrics->NodeIdentifier;
+
+	gpuboard_temp_metrics->node_temp_retimer =
+		metrics->NodeTemperatures[NODE_TEMP_RETIMER];
+	gpuboard_temp_metrics->node_temp_ibc =
+		metrics->NodeTemperatures[NODE_TEMP_IBC_TEMP];
+	gpuboard_temp_metrics->node_temp_ibc_2 =
+		metrics->NodeTemperatures[NODE_TEMP_IBC_2_TEMP];
+	gpuboard_temp_metrics->node_temp_vdd18_vr =
+		metrics->NodeTemperatures[NODE_TEMP_VDD18_VR_TEMP];
+	gpuboard_temp_metrics->node_temp_04_hbm_b_vr =
+		metrics->NodeTemperatures[NODE_TEMP_04_HBM_B_VR_TEMP];
+	gpuboard_temp_metrics->node_temp_04_hbm_d_vr =
+		metrics->NodeTemperatures[NODE_TEMP_04_HBM_D_VR_TEMP];
+
+	gpuboard_temp_metrics->vr_temp_vddcr_socio_a =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_SOCIO_A_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_socio_c =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_SOCIO_C_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_x0 =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_X0_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_x1 =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_X1_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_hbm_b =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_HBM_B_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_hbm_d =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_HBM_D_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_04_hbm_b =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_04_HBM_B_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_04_hbm_d =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_04_HBM_D_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_hbm_b =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_HBM_B_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_hbm_d =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_HBM_D_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_075_hbm_b =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_075_HBM_B_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_075_hbm_d =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_075_HBM_D_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_11_gta_a =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_11_GTA_A_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_11_gta_c =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_11_GTA_C_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddan_075_gta_a =
+		metrics->VrTemperatures[SVI_PLANE_VDDAN_075_GTA_A_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddan_075_gta_c =
+		metrics->VrTemperatures[SVI_PLANE_VDDAN_075_GTA_C_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddcr_075_ucie =
+		metrics->VrTemperatures[SVI_PLANE_VDDCR_075_UCIE_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_065_ucieaa =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_065_UCIEAA_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_065_ucieam_a =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_065_UCIEAM_A_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddio_065_ucieam_c =
+		metrics->VrTemperatures[SVI_PLANE_VDDIO_065_UCIEAM_C_TEMP];
+	gpuboard_temp_metrics->vr_temp_vddan_075 =
+		metrics->VrTemperatures[SVI_PLANE_VDDAN_075_TEMP];
+}
+
+static ssize_t smu_v15_0_8_get_temp_metrics(struct smu_context *smu,
+					    enum smu_temp_metric_type type,
+					    void *table)
+{
+	struct smu_v15_0_8_gpuboard_temp_metrics *gpuboard_temp_metrics;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	enum smu_driver_table_id table_id;
+	SystemMetricsTable_t *metrics;
+	struct smu_table *sys_table;
+	ssize_t size;
+	int ret;
+
+	table_id = SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
+	gpuboard_temp_metrics =
+		(struct smu_v15_0_8_gpuboard_temp_metrics *)
+		smu_driver_table_ptr(smu, table_id);
+	size = sizeof(*gpuboard_temp_metrics);
+
+	ret = smu_v15_0_8_get_system_metrics_table(smu);
+	if (ret)
+		return ret;
+
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
+	smu_driver_table_update_cache_time(smu, table_id);
+
+	smu_v15_0_8_fill_gpuboard_temp_metrics(gpuboard_temp_metrics,
+						      metrics);
+	memcpy(table, gpuboard_temp_metrics, size);
+	return size;
+}
+
 static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -1954,6 +2120,11 @@ static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
 	ctl->message_map = message_map;
 }
 
+static const struct smu_temp_funcs smu_v15_0_8_temp_funcs = {
+	.temp_metrics_is_supported = smu_v15_0_8_is_temp_metrics_supported,
+	.get_temp_metrics = smu_v15_0_8_get_temp_metrics,
+};
+
 void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &smu_v15_0_8_ppt_funcs;
@@ -1961,5 +2132,6 @@ void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = smu_v15_0_8_feature_mask_map;
 	smu->table_map = smu_v15_0_8_table_map;
 	smu_v15_0_8_init_msg_ctl(smu, smu_v15_0_8_message_map);
+	smu->smu_temp.temp_funcs = &smu_v15_0_8_temp_funcs;
 	smu->smc_driver_if_version = SMU15_DRIVER_IF_VERSION_SMU_V15_0_8;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 8fc16796788b5..0856d11d8e55e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -180,5 +180,76 @@ typedef struct {
 		  SMU_15_0_8_MAX_XCC);
 
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
+
+/* Maximum temperature sensor counts for system metrics */
+#define SMU_15_0_8_MAX_NODE_TEMP_ENTRIES	12
+#define SMU_15_0_8_MAX_VR_TEMP_ENTRIES		22
+
+/* SMUv 15.0.8 GPU board temperature metrics */
+#define SMU_15_0_8_GPUBOARD_TEMP_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)         \
+	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U64), accumulation_counter);                      \
+	SMU_SCALAR(SMU_MATTR(LABEL_VERSION), SMU_MUNIT(NONE),                  \
+		   SMU_MTYPE(U16), label_version);                             \
+	SMU_SCALAR(SMU_MATTR(NODE_ID), SMU_MUNIT(NONE),                        \
+		   SMU_MTYPE(U16), node_id);                                   \
+	SMU_SCALAR(SMU_MATTR(NODE_TEMP_RETIMER), SMU_MUNIT(TEMP_1),            \
+		   SMU_MTYPE(S16), node_temp_retimer);                         \
+	SMU_SCALAR(SMU_MATTR(NODE_TEMP_IBC), SMU_MUNIT(TEMP_1),                \
+		   SMU_MTYPE(S16), node_temp_ibc);                             \
+	SMU_SCALAR(SMU_MATTR(NODE_TEMP_IBC_2), SMU_MUNIT(TEMP_1),              \
+		   SMU_MTYPE(S16), node_temp_ibc_2);                           \
+	SMU_SCALAR(SMU_MATTR(NODE_TEMP_VDD18_VR), SMU_MUNIT(TEMP_1),           \
+		   SMU_MTYPE(S16), node_temp_vdd18_vr);                        \
+	SMU_SCALAR(SMU_MATTR(NODE_TEMP_04_HBM_B_VR), SMU_MUNIT(TEMP_1),        \
+		   SMU_MTYPE(S16), node_temp_04_hbm_b_vr);                     \
+	SMU_SCALAR(SMU_MATTR(NODE_TEMP_04_HBM_D_VR), SMU_MUNIT(TEMP_1),        \
+		   SMU_MTYPE(S16), node_temp_04_hbm_d_vr);                     \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_SOCIO_A), SMU_MUNIT(TEMP_1),        \
+		   SMU_MTYPE(S16), vr_temp_vddcr_socio_a);                     \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_SOCIO_C), SMU_MUNIT(TEMP_1),        \
+		   SMU_MTYPE(S16), vr_temp_vddcr_socio_c);                     \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_X0), SMU_MUNIT(TEMP_1),             \
+		   SMU_MTYPE(S16), vr_temp_vddcr_x0);                          \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_X1), SMU_MUNIT(TEMP_1),             \
+		   SMU_MTYPE(S16), vr_temp_vddcr_x1);                          \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_HBM_B), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(S16), vr_temp_vddio_hbm_b);                       \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_HBM_D), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(S16), vr_temp_vddio_hbm_d);                       \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_04_HBM_B), SMU_MUNIT(TEMP_1),       \
+		   SMU_MTYPE(S16), vr_temp_vddio_04_hbm_b);                    \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_04_HBM_D), SMU_MUNIT(TEMP_1),       \
+		   SMU_MTYPE(S16), vr_temp_vddio_04_hbm_d);                    \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_HBM_B), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(S16), vr_temp_vddcr_hbm_b);                       \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_HBM_D), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(S16), vr_temp_vddcr_hbm_d);                       \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_075_HBM_B), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), vr_temp_vddcr_075_hbm_b);                   \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_075_HBM_D), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), vr_temp_vddcr_075_hbm_d);                   \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_11_GTA_A), SMU_MUNIT(TEMP_1),       \
+		   SMU_MTYPE(S16), vr_temp_vddio_11_gta_a);                    \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_11_GTA_C), SMU_MUNIT(TEMP_1),       \
+		   SMU_MTYPE(S16), vr_temp_vddio_11_gta_c);                    \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDAN_075_GTA_A), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), vr_temp_vddan_075_gta_a);                   \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDAN_075_GTA_C), SMU_MUNIT(TEMP_1),      \
+		   SMU_MTYPE(S16), vr_temp_vddan_075_gta_c);                   \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDCR_075_UCIE), SMU_MUNIT(TEMP_1),       \
+		   SMU_MTYPE(S16), vr_temp_vddcr_075_ucie);                    \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_065_UCIEAA), SMU_MUNIT(TEMP_1),     \
+		   SMU_MTYPE(S16), vr_temp_vddio_065_ucieaa);                  \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_065_UCIEAM_A), SMU_MUNIT(TEMP_1),   \
+		   SMU_MTYPE(S16), vr_temp_vddio_065_ucieam_a);                \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_065_UCIEAM_C), SMU_MUNIT(TEMP_1),   \
+		   SMU_MTYPE(S16), vr_temp_vddio_065_ucieam_c);                \
+	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDAN_075), SMU_MUNIT(TEMP_1),            \
+		   SMU_MTYPE(S16), vr_temp_vddan_075);
+
+DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpuboard_temp_metrics,
+			  SMU_15_0_8_GPUBOARD_TEMP_METRICS_FIELDS);
+
 #endif
 #endif
-- 
2.53.0

