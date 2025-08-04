Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB3C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B636F10E363;
	Mon,  4 Aug 2025 14:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eeKCfq/2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A2D10E53D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLnhJIFB+/kux7s/iUGjNF9BgoaoJWDQfea8fJReOLFpYkfE47xAYSZi9XKYbWdlE4UPYJda1NhehkstoV004W/oP+vxMwRokz4I18eTp8b+m5rN0MAbNCCh/ACk8YDHPl25UPINRjtBmT7pyhcrMEzTPxT6KAct+rLDsy1AYXkpwYWWJOhQ1tQonmVVACHhQARJ8zOmLO0KJeWrZLi/dsj5YsdyjqyPHU7n8FXFTrrrrRFMxgXGzirmmihmEpuJbAzw6QtlAwV1/G+/wFhJ/b/cAVgfNOqXiFFYJfsmRet2omztYSL7Enl0VSXWwo1Fiyi1htcFAO1pZVDXdbkH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uxlRckHKBLAHJlg/vditQF2L7mS5PHZJuEWXcyYWqs=;
 b=wtfBeNNmx/4nOwAVlUrXS2cxgYcCm4mF1ki/s+0pUjw1KyTRepxnsmtKfOYQMT56TVJ3cn2XcybIG6JV9LaVwmHvI3R7Ek0+Op581NeMAWoNro4grBbpbhQLvrvteckmUHG2D1IkLZ606cbo5dbJMxXYpRmX2VhppeDaB3BerfAiQ/fUa1WyvmXqIL/Mi2DsDS8fDNC7NiRr70T8S39qRR+JtTVBYsxCqH/xD1inHGYE7SZKvL3REgtWSDiyV0e1zg7uGIUbG7ehwzhluPkvNbuMnBBL23P0hxLDwiJ4gqCGoyXL7TLMwXbTmOJOB7HoYdgxVXiy8xhtiNB4yNgGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uxlRckHKBLAHJlg/vditQF2L7mS5PHZJuEWXcyYWqs=;
 b=eeKCfq/27f85SeX/Wo2ATrHno07Pgcuv9eKr3BsUzJYYx/oFdHnvx6ALOXuyxsZNkK5UYpx2fUDVWYzmO5+zLGGqYcjZh8jWcqtXte9v4MFWeZCt9N91eUTvz6/jfbj/cZdTvv5bP/ijBaeprkLyopZWZf2y8nkG91ePL7UTEuw=
Received: from BN8PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:94::16)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 14:18:19 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::21) by BN8PR03CA0003.outlook.office365.com
 (2603:10b6:408:94::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 14:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 14:18:19 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 09:18:15 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v3 4/6] drm/amd/pm: Fetch and fill temperature metrics
Date: Mon, 4 Aug 2025 22:17:55 +0800
Message-ID: <20250804141757.643501-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804141757.643501-1-asad.kamal@amd.com>
References: <20250804141757.643501-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 456745bd-e55e-4c05-48bb-08ddd361c33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rFHM5q+n8Mns75yuZKrcIOSkAZpKnHekrWEuwDgtg5+7O+b9bZBmKTMKidu7?=
 =?us-ascii?Q?8Ylefe2s5Hwr0g438/xdV0DUBeDsdhTJ3jld04D+eDuIDr5ViLMSF0VbyiOB?=
 =?us-ascii?Q?7XgOlhSekKnwQQytsO2VXTatr9kzbTzZnXftIYC31GhqBZOF6zS96ZsTnc+D?=
 =?us-ascii?Q?hPDJzv5xltPVfrXc/Kfi1+R0LooX8ePbcMQwZwddPBR++t98haXOQVzqxXQ8?=
 =?us-ascii?Q?4zcsppJ/EGLHjWER++GC6cDegc+lIKsa5yLT6lUaAb3lQgRqxqlMH+xUNnjW?=
 =?us-ascii?Q?WQ+1eeWGg246fC3kfZPysTbShf8O8vymOhVUMqTNVw4lU9b3AnN/yW8+rlVU?=
 =?us-ascii?Q?crsrl6waShTi4ZXzYoJsd2osNqbiPYaH4OVGmd+1+RzO0gw8E2E7Ezvkr+bn?=
 =?us-ascii?Q?rRsYifFx/qbMQn6ZctTYBNAW0OJ5I30MkJF1Cz73mAt3BdugYqnKi8Xu9m5m?=
 =?us-ascii?Q?gs7Ywb8FIqOWEM4MPLnkueancNzPUk2o4Bm/DtYwGqqiki10wcUtBYnW9qN0?=
 =?us-ascii?Q?GTjVJhj+TcDTjLwaSkDL3FOlGDi9TDHV7OoT6lXTjTJn0c7L+LaASHOd0rDD?=
 =?us-ascii?Q?i5J2WqeNUqWMj2P1rJhzDcZ6SznRVD1EbCNlTb6m4QOpKaWg+9M1DTkHkPmF?=
 =?us-ascii?Q?ip7RIDeyLhsT3gYEV/MxQUGlYfOQfbYK9jFWenzfPtT8B9RpAlzvLdy7VtIN?=
 =?us-ascii?Q?e68HUGUyHA88t7vV0faqrujW1lYtymra0tTCvNkQMybBf4B2GIO0dtZkWQYk?=
 =?us-ascii?Q?QyfE3GarFYNaGEpUXg4oeTJN5ot0vxesDvyIiidcLzT6Z8FBtiepJwNBW5m5?=
 =?us-ascii?Q?zL1v63jS7ncvWVbA0CV4oiYUIwPnvdbAhiaXG3/e4tv5EjSXKs7t5yyqOjbb?=
 =?us-ascii?Q?Q7mDXbtfpSLNOfaUYxLxYpspeVWxYoWSOFyKUEqFxkSddoAU4bkmz/G9yRWb?=
 =?us-ascii?Q?QvTrUYluZMhzdHcwn5+AcUdrs5C64XIMFNXWJk52xI4zmrA9OoPgRRVLMLTh?=
 =?us-ascii?Q?op6fYQcDZiOcz2wWc8Qdi0PuXvwx06E3L3okj60q7+s1fJgCG7uyjbprLBfe?=
 =?us-ascii?Q?vMOOT/0V40MbNJSoieD4trXFGBj/Fy1P6ziohFbny41yg6TYKSsl0islqZdY?=
 =?us-ascii?Q?1avHUx1uZwN2W+V6fztwaqPCpRcDVS1hT2Vi8VWcCFI1vgSfZEUsgBhsZXuL?=
 =?us-ascii?Q?Ih59MJlPNbKu97/z0hwm2XKuWzGLKegkEKxEiPH0OF5P4HoGrfdYFmdvLlXu?=
 =?us-ascii?Q?4oY7/5qFbx8Xzhr8rOkO6apwfLAqitM8xj3UIZFCXC4E2Ef36ZkEMNv5XWGS?=
 =?us-ascii?Q?gzyQC0+1CpS1c3zV75GSOgyMgDrwmyLGw0xH3Z1lrPSIvohC0kB8/By9RAsb?=
 =?us-ascii?Q?HXQGYrB/Ncrwk0HCPINiFTm7rLu5jZYt88Fo6lVv0Qky3g6nbsdhjB8dPMCq?=
 =?us-ascii?Q?mjbqA1pLB+7huDUR1fR+Z6DTX+5fqZSvqT0uhgGg3KOSZs5wIjr/AUyJRcM2?=
 =?us-ascii?Q?Qm09G+iHJIvx9V0+OiJxh4FfvLTKcxXWF99O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:18:19.6962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456745bd-e55e-4c05-48bb-08ddd361c33e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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

Fetch system metrics table to fill gpuboard/baseboard temperature
metrics data for smu_v13_0_12

v2: Remove unnecessary checks, used separate metrics time for
temperature metrics table(Lijo)

v3: Use cached values for back to back system metrics query(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 248 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   6 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  26 ++
 7 files changed, 287 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8b015107f761..dc48a1dd8be4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -766,6 +766,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
 		smu_v13_0_6_set_ppt_funcs(smu);
+		smu_v13_0_6_set_temp_funcs(smu);
 		/* Enable pp_od_clk_voltage node */
 		smu->od_enabled = true;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b490c39e313e..611b381b9147 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -257,6 +257,7 @@ struct smu_table {
 	void *cpu_addr;
 	struct amdgpu_bo *bo;
 	uint32_t version;
+	unsigned long  metrics_time;
 };
 
 enum smu_perf_level_designation {
@@ -322,6 +323,7 @@ enum smu_table_id {
 	SMU_TABLE_ECCINFO,
 	SMU_TABLE_COMBO_PPTABLE,
 	SMU_TABLE_WIFIBAND,
+	SMU_TABLE_TEMP_METRICS,
 	SMU_TABLE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index d7a9e41820fa..458c4ac2dfbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -278,7 +278,8 @@
 	__SMU_DUMMY_MAP(MALLPowerState), \
 	__SMU_DUMMY_MAP(ResetSDMA), \
 	__SMU_DUMMY_MAP(ResetVCN), \
-	__SMU_DUMMY_MAP(GetStaticMetricsTable),
+	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
+	__SMU_DUMMY_MAP(GetSystemMetricsTable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 02a455a31c25..f1121d79dc35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -138,6 +138,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
+	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
 };
 
 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
@@ -184,7 +185,8 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
 
 int smu_v13_0_12_get_max_metrics_size(void)
 {
-	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
+	return max3(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t),
+		   sizeof(SystemMetricsTable_t));
 }
 
 static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
@@ -359,6 +361,245 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table,
+						 bool bypass_cache)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	int ret;
+
+	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
+	    time_after(jiffies,
+		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
+		       msecs_to_jiffies(1))) {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
+		if (ret) {
+			dev_info(smu->adev->dev,
+				 "Failed to export system metrics table!\n");
+			return ret;
+		}
+
+		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+		smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time = jiffies;
+	}
+
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, sizeof(SystemMetricsTable_t));
+
+	return 0;
+}
+
+static enum amdgpu_node_temp smu_v13_0_12_get_node_sensor_type(NODE_TEMP_e type)
+{
+	switch (type) {
+	case NODE_TEMP_RETIMER:
+		return AMDGPU_RETIMER_X_TEMP;
+	case NODE_TEMP_IBC_TEMP:
+		return AMDGPU_OAM_X_IBC_TEMP;
+	case NODE_TEMP_IBC_2_TEMP:
+		return AMDGPU_OAM_X_IBC_2_TEMP;
+	case NODE_TEMP_VDD18_VR_TEMP:
+		return AMDGPU_OAM_X_VDD18_VR_TEMP;
+	case NODE_TEMP_04_HBM_B_VR_TEMP:
+		return AMDGPU_OAM_X_04_HBM_B_VR_TEMP;
+	case NODE_TEMP_04_HBM_D_VR_TEMP:
+		return AMDGPU_OAM_X_04_HBM_D_VR_TEMP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum amdgpu_vr_temp smu_v13_0_12_get_vr_sensor_type(SVI_TEMP_e type)
+{
+	switch (type) {
+	case SVI_VDDCR_VDD0_TEMP:
+		return AMDGPU_VDDCR_VDD0_TEMP;
+	case SVI_VDDCR_VDD1_TEMP:
+		return AMDGPU_VDDCR_VDD1_TEMP;
+	case SVI_VDDCR_VDD2_TEMP:
+		return AMDGPU_VDDCR_VDD2_TEMP;
+	case SVI_VDDCR_VDD3_TEMP:
+		return AMDGPU_VDDCR_VDD3_TEMP;
+	case SVI_VDDCR_SOC_A_TEMP:
+		return AMDGPU_VDDCR_SOC_A_TEMP;
+	case SVI_VDDCR_SOC_C_TEMP:
+		return AMDGPU_VDDCR_SOC_C_TEMP;
+	case SVI_VDDCR_SOCIO_A_TEMP:
+		return AMDGPU_VDDCR_SOCIO_A_TEMP;
+	case SVI_VDDCR_SOCIO_C_TEMP:
+		return AMDGPU_VDDCR_SOCIO_C_TEMP;
+	case SVI_VDD_085_HBM_TEMP:
+		return AMDGPU_VDD_085_HBM_TEMP;
+	case SVI_VDDCR_11_HBM_B_TEMP:
+		return AMDGPU_VDDCR_11_HBM_B_TEMP;
+	case SVI_VDDCR_11_HBM_D_TEMP:
+		return AMDGPU_VDDCR_11_HBM_D_TEMP;
+	case SVI_VDD_USR_TEMP:
+		return AMDGPU_VDD_USR_TEMP;
+	case SVI_VDDIO_11_E32_TEMP:
+		return AMDGPU_VDDIO_11_E32_TEMP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum amdgpu_system_temp smu_v13_0_12_get_system_sensor_type(SYSTEM_TEMP_e type)
+{
+	switch (type) {
+	case SYSTEM_TEMP_UBB_FPGA:
+		return AMDGPU_UBB_FPGA_TEMP;
+	case SYSTEM_TEMP_UBB_FRONT:
+		return AMDGPU_UBB_FRONT_TEMP;
+	case SYSTEM_TEMP_UBB_BACK:
+		return AMDGPU_UBB_BACK_TEMP;
+	case SYSTEM_TEMP_UBB_OAM7:
+		return AMDGPU_UBB_OAM7_TEMP;
+	case SYSTEM_TEMP_UBB_IBC:
+		return AMDGPU_UBB_IBC_TEMP;
+	case SYSTEM_TEMP_UBB_UFPGA:
+		return AMDGPU_UBB_UFPGA_TEMP;
+	case SYSTEM_TEMP_UBB_OAM1:
+		return AMDGPU_UBB_OAM1_TEMP;
+	case SYSTEM_TEMP_OAM_0_1_HSC:
+		return AMDGPU_OAM_0_1_HSC_TEMP;
+	case SYSTEM_TEMP_OAM_2_3_HSC:
+		return AMDGPU_OAM_2_3_HSC_TEMP;
+	case SYSTEM_TEMP_OAM_4_5_HSC:
+		return AMDGPU_OAM_4_5_HSC_TEMP;
+	case SYSTEM_TEMP_OAM_6_7_HSC:
+		return AMDGPU_OAM_6_7_HSC_TEMP;
+	case SYSTEM_TEMP_UBB_FPGA_0V72_VR:
+		return AMDGPU_UBB_FPGA_0V72_VR_TEMP;
+	case SYSTEM_TEMP_UBB_FPGA_3V3_VR:
+		return AMDGPU_UBB_FPGA_3V3_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR:
+		return AMDGPU_RETIMER_0_1_2_3_1V2_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR:
+		return AMDGPU_RETIMER_4_5_6_7_1V2_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_0_1_0V9_VR:
+		return AMDGPU_RETIMER_0_1_0V9_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_4_5_0V9_VR:
+		return AMDGPU_RETIMER_4_5_0V9_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_2_3_0V9_VR:
+		return AMDGPU_RETIMER_2_3_0V9_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_6_7_0V9_VR:
+		return AMDGPU_RETIMER_6_7_0V9_VR_TEMP;
+	case SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR:
+		return AMDGPU_OAM_0_1_2_3_3V3_VR_TEMP;
+	case SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR:
+		return AMDGPU_OAM_4_5_6_7_3V3_VR_TEMP;
+	case SYSTEM_TEMP_IBC_HSC:
+		return AMDGPU_IBC_HSC_TEMP;
+	case SYSTEM_TEMP_IBC:
+		return AMDGPU_IBC_TEMP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
+						   enum smu_temp_metric_type type)
+{
+	switch (type) {
+	case SMU_TEMP_METRIC_BASEBOARD:
+		if (smu->adev->gmc.xgmi.physical_node_id == 0 &&
+		    smu->adev->gmc.xgmi.num_physical_nodes > 1 &&
+		    smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS)))
+			return true;
+		break;
+	case SMU_TEMP_METRIC_GPUBOARD:
+		return smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS));
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
+					     enum smu_temp_metric_type type, void *table)
+{
+	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
+	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
+	SystemMetricsTable_t *metrics;
+	u32 idx, sensors;
+	int ret, sensor_type;
+	ssize_t size = 0;
+
+	size = (type == SMU_TEMP_METRIC_GPUBOARD) ?
+		sizeof(*gpuboard_temp_metrics) : sizeof(*baseboard_temp_metrics);
+
+	if (!table)
+		goto out;
+	metrics = kzalloc(sizeof(SystemMetricsTable_t), GFP_KERNEL);
+	if (!metrics)
+		return -ENOMEM;
+	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)table;
+	baseboard_temp_metrics = (struct amdgpu_baseboard_temp_metrics_v1_0 *)table;
+	if (type  == SMU_TEMP_METRIC_GPUBOARD)
+		smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
+	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
+		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
+
+	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics, false);
+	if (ret) {
+		kfree(metrics);
+		return ret;
+	}
+
+	if (type == SMU_TEMP_METRIC_GPUBOARD) {
+		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
+		gpuboard_temp_metrics->label_version = metrics->LabelVersion;
+		gpuboard_temp_metrics->node_id = metrics->NodeIdentifier;
+
+		idx = 0;
+		for (sensors = 0; sensors < NODE_TEMP_MAX_TEMP_ENTRIES; sensors++) {
+			if (metrics->NodeTemperatures[sensors] != -1) {
+				sensor_type = smu_v13_0_12_get_node_sensor_type(sensors);
+				gpuboard_temp_metrics->node_temp[idx] =
+					((int)metrics->NodeTemperatures[sensors])  & 0xFFFFFF;
+				gpuboard_temp_metrics->node_temp[idx] |= (sensor_type << 24);
+				idx++;
+			}
+		}
+
+		idx = 0;
+
+		for (sensors = 0; sensors < SVI_MAX_TEMP_ENTRIES; sensors++) {
+			if (metrics->VrTemperatures[sensors] != -1) {
+				sensor_type = smu_v13_0_12_get_vr_sensor_type(sensors);
+				gpuboard_temp_metrics->vr_temp[idx] =
+					((int)metrics->VrTemperatures[sensors])  & 0xFFFFFF;
+				gpuboard_temp_metrics->vr_temp[idx] |= (sensor_type << 24);
+				idx++;
+			}
+		}
+	} else if (type == SMU_TEMP_METRIC_BASEBOARD) {
+		baseboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
+		baseboard_temp_metrics->label_version = metrics->LabelVersion;
+		baseboard_temp_metrics->node_id = metrics->NodeIdentifier;
+
+		idx = 0;
+		for (sensors = 0; sensors < SYSTEM_TEMP_MAX_ENTRIES; sensors++) {
+			if (metrics->SystemTemperatures[sensors] != -1) {
+				sensor_type = smu_v13_0_12_get_system_sensor_type(sensors);
+				baseboard_temp_metrics->system_temp[idx] =
+					((int)metrics->SystemTemperatures[sensors])  & 0xFFFFFF;
+				baseboard_temp_metrics->system_temp[idx] |= (sensor_type << 24);
+				idx++;
+			}
+		}
+	}
+
+	kfree(metrics);
+
+out:
+	return size;
+}
+
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
 {
 	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
@@ -572,3 +813,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void
 
 	return sizeof(*gpu_metrics);
 }
+
+const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
+	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
+	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
+};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..c777c0e4ea11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3857,3 +3857,9 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }
+
+void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
+{
+	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
+			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 67b30674fd31..ece04ad724fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -68,10 +68,12 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(BOARD_VOLTAGE),
 	SMU_CAP(PLDM_VERSION),
+	SMU_CAP(TEMP_METRICS),
 	SMU_CAP(ALL),
 };
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
+extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
@@ -88,4 +90,5 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
 				     void *smu_metrics);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
+extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index a608cdbdada4..d588f74b98de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -65,6 +65,32 @@
 		header->structure_size = sizeof(*tmp);                     \
 	} while (0)
 
+#define smu_cmn_init_baseboard_temp_metrics(ptr, fr, cr)                        \
+	do {                                                                    \
+		typecheck(struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *,  \
+			  (ptr));                                               \
+		struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *tmp = (ptr); \
+		struct metrics_table_header *header =                           \
+			(struct metrics_table_header *)tmp;                     \
+		memset(header, 0xFF, sizeof(*tmp));                             \
+		header->format_revision = fr;                                   \
+		header->content_revision = cr;                                  \
+		header->structure_size = sizeof(*tmp);                          \
+	} while (0)
+
+#define smu_cmn_init_gpuboard_temp_metrics(ptr, fr, cr)                         \
+	do {                                                                    \
+		typecheck(struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *,   \
+			  (ptr));                                               \
+		struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *tmp = (ptr);  \
+		struct metrics_table_header *header =                           \
+			(struct metrics_table_header *)tmp;                     \
+		memset(header, 0xFF, sizeof(*tmp));                             \
+		header->format_revision = fr;                                   \
+		header->content_revision = cr;                                  \
+		header->structure_size = sizeof(*tmp);                          \
+	} while (0)
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
-- 
2.46.0

