Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE70AC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D32B10E14E;
	Mon,  4 Aug 2025 11:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yxuf8+YT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3621D10E14E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcs3noZkzsR4r/g/TlgpptErchTNPKeqmHCGyYorNyzi4/wooHXgN22Nc/i4DWqqkFnPBoOhWZ4MxsupdWTbUIRiBnEw7zOqmiSoI17kCoEJEdYGhvsDvWR759KEe1Hk3N1W3hu2s9e5Lx4i0I4cMb7tzw8Oif0nKfdSHQSVJFYeNmLTUItff+FY03OA2oMNOSUQ5UIT/xhmd4UTY5KXjDOkCTFDY9FpCEv0k7I/7jbWaHJh/ZKk3haMNH/8AhOuc7NY86bMUmwr9d45bfiNO5urSLFEalkNdpmdX5OBqzWaWit7UXvw3ZMOE22PjxKmnALC4Jey9fhGLyGlCkqdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg+eODIQFc5MuR1SetU7qTdyWCZV6NFTrUzaiqZIUXU=;
 b=j6SLFFP1xSJWuufAfTcst0WkbKU56UcwC38rV6eMnbkqTUUo1nhHZSTJseOFbN4qJrp8zrq50sZvcmCu/lITQBJg1qsK+3Ee7y1Q19jA1HYZnA/3MpfGSrX3MhHlk5bKwBq8AooAdoKIQU+NYZbdr0bcGjt+lBW2/RDtw0vsIi+OrnwKr4IUA5oUK463I0LQVO8eNGvT0Fz4L8eM80RMtomDCSOLwWgAIaaoCj5wPBy/UHEld27yDAyTNefmsxNUYfl90q4YSsSU3euG39do72A5CmIZfAlluCPIeADoJs/OFl7xuBlVpUmjQKaZA0bCeYFlAQfquj+omh918XU7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg+eODIQFc5MuR1SetU7qTdyWCZV6NFTrUzaiqZIUXU=;
 b=Yxuf8+YTCgq/E4UIFvuzoa2rXAnj4Hx7A+gnhg684Wn+I8zOeMqmr++7tiI/T9e+WYsSABfWqROCf4R1BplTAHIaMnqJJBm+JDDtbV2Xg/ine0EnE7O1c92PdsI8Jv0+2uEXkxpbAenTn62xHtNiplJsskQNX8DYbeN2xnd7+fE=
Received: from BN0PR04CA0201.namprd04.prod.outlook.com (2603:10b6:408:e9::26)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 11:05:55 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::f4) by BN0PR04CA0201.outlook.office365.com
 (2603:10b6:408:e9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:05:54 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:05:52 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 1/6] drm/amd/pm: Add dpm interface for temp metrics
Date: Mon, 4 Aug 2025 19:05:34 +0800
Message-ID: <20250804110539.637463-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 69153552-8e04-4736-e344-08ddd346e1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0CrBSUo3Ev2vyVH2fNg7WV8B6ENKy7KlYoLuQuo8Y2eTtwWJtOvtnufFi89G?=
 =?us-ascii?Q?w0jdK0C/eTLp7COn1EKMgTjAVPeAU315v1IvQKwYPzjvnB2l6bmY5lZbQSEF?=
 =?us-ascii?Q?y89fJFR6eCa6cS+SojkfhSqv6oQYOZavicFkmGnGO7qtae67eZzFf+G8Srce?=
 =?us-ascii?Q?MwLDmtIuUp1Gh2vJmj3QWgvRpewzqeIFVI27mIH1WRV94SX1DxX3fP579wwm?=
 =?us-ascii?Q?v44YfqxpM9ii2JnthiFW3HdqWxvXtgxkNvZ7jgUPnSaVDinEjHEkeygCJixV?=
 =?us-ascii?Q?HEtX17WcGnrDU7mj8GQYpwUxqJ0BId7DPTjbaCWFiimBPTscTGY8zJ+gsN8h?=
 =?us-ascii?Q?dN60xVS7h7Q/qHHMysXfBjf+DB5hdELOJuZbvwJfzrfjR6x0CPNO7EK0+Ogr?=
 =?us-ascii?Q?3k1ayFGuGysv5HXsaHxmK5LiV0wGe/zwRpgSMYej0IXzxnfpEMwxev8lSs5k?=
 =?us-ascii?Q?44qALz0Z13XDFNeFlZoeHPveBPubQ3BvyPoam6iYfCvsrPFMil6boCeUqZ9V?=
 =?us-ascii?Q?UCex7uj8Yw1NQGRMoMD7vbFRAYkec03u8EIxRs1uzUnkaaSjgWRisO1QHfl0?=
 =?us-ascii?Q?+u3KYxAS+djL88TmRbVzu5/nnb+FLNHXUxUPUQqF+UKokrWUm4eNM2eXNigk?=
 =?us-ascii?Q?M+a00X+pbXnZMqzeSiy9SzkPg4U4cyhuFHRyxE8vM/6ZyLJLJKZ67PcnpIpZ?=
 =?us-ascii?Q?JDGVfWyaKI3CSlNhkjdAeOsQBequpEN/Jp7ROVDayL/wZSSV4TPw9T+9hE43?=
 =?us-ascii?Q?C7dDMdHSZWR51G7V9Kdk/lf4jJDnX/idwE0JuVX/oG5A5T2Ge1v7SeIGw7cA?=
 =?us-ascii?Q?uUHDsHLKRRpZLcYB4Pt637ex+ErOVLyCeXyQ2gQUenu79Iq6uF7RB6Uaj6kE?=
 =?us-ascii?Q?fxXLxVPSIiqtOgIRH8CCoYO3onlYpkZVO4Fe+AtvNr5/KEEUPzaF5jEz2Lyw?=
 =?us-ascii?Q?Y8SXLIYJwZ3PMCX4qiNulw3yBUNRCCln77vF4SmkhBXyCtwoRtriT/h0Wr/7?=
 =?us-ascii?Q?xqZ/U5tmyRxPLIHcRjphiwipE58FPWQ6xRA6yM4QOEIz/eTFwWF7bq6VN1UK?=
 =?us-ascii?Q?g1aJ/RIvPvtLKGpGW08PUyLR2ekP/OgdgWN/g6UCAOboUKC6NfwHRUxpWhZN?=
 =?us-ascii?Q?zjIkYbrO8WRlkgI3NZnuHh7VVOBGJIjfh2D+XIcQVSUJQzjq7+02LjdAP3ef?=
 =?us-ascii?Q?judlvIuEGU5FzP2dyKCfSM0XB0gg+5+oXt7cAxzXm0XpojzHxX3nOONumgvf?=
 =?us-ascii?Q?B36OPmFc3eFvCZdww+Ehim6f7VbJgzjxoC1ePRemNRunLRUQ0CWwhI/eQ4r0?=
 =?us-ascii?Q?4ky1w+FJROP8kqcE+rdQb/pQGZdDT62771BbzeYvK6XTqtFx6kSl3lbFwhgF?=
 =?us-ascii?Q?vk4D2RtspjEn7HmUmzcIaut7IHwh/R/p7gErvEfq808T0WEQcNTYf5QTUZX8?=
 =?us-ascii?Q?wnXRQNX/ObZFMoulHHUyW4n4sPLRp+chDJC9OBjCk+Dx5cW3LEzkkmLbg88/?=
 =?us-ascii?Q?t4OxZiaIgS+xivlfEMuWPmAL073cjaGRIMq2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:05:54.5704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69153552-8e04-4736-e344-08ddd346e1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

Add dpm interface to get gpuboard/baseboard temperature metrics

v2: Add temperature metrics support check(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 81 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 60 ++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 3 files changed, 145 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e2b1ea7467b0..2f7e4b5bebf3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -30,6 +30,12 @@ extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v14_0_ip_block;
 
+enum smu_temp_metric_type {
+	SMU_TEMP_METRIC_BASEBOARD,
+	SMU_TEMP_METRIC_GPUBOARD,
+	SMU_TEMP_METRIC_MAX,
+};
+
 enum smu_event_type {
 	SMU_EVENT_RESET_COMPLETE = 0,
 };
@@ -496,6 +502,8 @@ struct amd_pm_funcs {
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
+	ssize_t (*get_temp_metrics)(void *handle, enum smu_temp_metric_type type, void *table);
+	bool (*temp_metrics_is_supported)(void *handle, enum smu_temp_metric_type type);
 	ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
 	ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t size);
 	int (*set_watermarks_for_clock_ranges)(void *handle,
@@ -1595,6 +1603,79 @@ struct amdgpu_pm_metrics {
 	uint8_t data[];
 };
 
+enum amdgpu_vr_temp {
+	AMDGPU_VDDCR_VDD0_TEMP,
+	AMDGPU_VDDCR_VDD1_TEMP,
+	AMDGPU_VDDCR_VDD2_TEMP,
+	AMDGPU_VDDCR_VDD3_TEMP,
+	AMDGPU_VDDCR_SOC_A_TEMP,
+	AMDGPU_VDDCR_SOC_C_TEMP,
+	AMDGPU_VDDCR_SOCIO_A_TEMP,
+	AMDGPU_VDDCR_SOCIO_C_TEMP,
+	AMDGPU_VDD_085_HBM_TEMP,
+	AMDGPU_VDDCR_11_HBM_B_TEMP,
+	AMDGPU_VDDCR_11_HBM_D_TEMP,
+	AMDGPU_VDD_USR_TEMP,
+	AMDGPU_VDDIO_11_E32_TEMP,
+	AMDGPU_VR_MAX_TEMP_ENTRIES,
+};
+
+enum amdgpu_system_temp {
+	AMDGPU_UBB_FPGA_TEMP,
+	AMDGPU_UBB_FRONT_TEMP,
+	AMDGPU_UBB_BACK_TEMP,
+	AMDGPU_UBB_OAM7_TEMP,
+	AMDGPU_UBB_IBC_TEMP,
+	AMDGPU_UBB_UFPGA_TEMP,
+	AMDGPU_UBB_OAM1_TEMP,
+	AMDGPU_OAM_0_1_HSC_TEMP,
+	AMDGPU_OAM_2_3_HSC_TEMP,
+	AMDGPU_OAM_4_5_HSC_TEMP,
+	AMDGPU_OAM_6_7_HSC_TEMP,
+	AMDGPU_UBB_FPGA_0V72_VR_TEMP,
+	AMDGPU_UBB_FPGA_3V3_VR_TEMP,
+	AMDGPU_RETIMER_0_1_2_3_1V2_VR_TEMP,
+	AMDGPU_RETIMER_4_5_6_7_1V2_VR_TEMP,
+	AMDGPU_RETIMER_0_1_0V9_VR_TEMP,
+	AMDGPU_RETIMER_4_5_0V9_VR_TEMP,
+	AMDGPU_RETIMER_2_3_0V9_VR_TEMP,
+	AMDGPU_RETIMER_6_7_0V9_VR_TEMP,
+	AMDGPU_OAM_0_1_2_3_3V3_VR_TEMP,
+	AMDGPU_OAM_4_5_6_7_3V3_VR_TEMP,
+	AMDGPU_IBC_HSC_TEMP,
+	AMDGPU_IBC_TEMP,
+	AMDGPU_SYSTEM_MAX_TEMP_ENTRIES = 32,
+};
+
+enum amdgpu_node_temp {
+	AMDGPU_RETIMER_X_TEMP,
+	AMDGPU_OAM_X_IBC_TEMP,
+	AMDGPU_OAM_X_IBC_2_TEMP,
+	AMDGPU_OAM_X_VDD18_VR_TEMP,
+	AMDGPU_OAM_X_04_HBM_B_VR_TEMP,
+	AMDGPU_OAM_X_04_HBM_D_VR_TEMP,
+	AMDGPU_NODE_MAX_TEMP_ENTRIES = 12,
+};
+
+struct amdgpu_gpuboard_temp_metrics_v1_0 {
+	struct metrics_table_header common_header;
+	uint16_t label_version;
+	uint16_t node_id;
+	uint64_t accumulation_counter;
+	/* Encoded temperature in Celcius, 24:31 is sensor id 0:23 is temp value */
+	uint32_t node_temp[AMDGPU_NODE_MAX_TEMP_ENTRIES];
+	uint32_t vr_temp[AMDGPU_VR_MAX_TEMP_ENTRIES];
+};
+
+struct amdgpu_baseboard_temp_metrics_v1_0 {
+	struct metrics_table_header common_header;
+	uint16_t label_version;
+	uint16_t node_id;
+	uint64_t accumulation_counter;
+	/* Encoded temperature in Celcius, 24:31 is sensor id 0:23 is temp value */
+	uint32_t system_temp[AMDGPU_SYSTEM_MAX_TEMP_ENTRIES];
+};
+
 struct amdgpu_partition_metrics_v1_0 {
 	struct metrics_table_header common_header;
 	/* Current clocks (Mhz) */
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 71d986dd7a6e..a5e97582d853 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2037,6 +2037,66 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 	return ret;
 }
 
+/**
+ * amdgpu_dpm_get_temp_metrics - Retrieve metrics for a specific compute
+ * partition
+ * @adev: Pointer to the device.
+ * @type: Identifier for the temperature type metrics to be fetched.
+ * @table: Pointer to a buffer where the metrics will be stored. If NULL, the
+ * function returns the size of the metrics structure.
+ *
+ * This function retrieves metrics for a specific temperature type, If the
+ * table parameter is NULL, the function returns the size of the metrics
+ * structure without populating it.
+ *
+ * Return: Size of the metrics structure on success, or a negative error code on failure.
+ */
+ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
+				    enum smu_temp_metric_type type, void *table)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->get_temp_metrics ||
+	    !amdgpu_dpm_is_temp_metrics_supported(adev, type))
+		return 0;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_temp_metrics(adev->powerplay.pp_handle, type, table);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
+/**
+ * amdgpu_dpm_is_temp_metrics_supported - Return if specific temperature metrics support
+ * is available
+ * @adev: Pointer to the device.
+ * @type: Identifier for the temperature type metrics to be fetched.
+ *
+ * This function returns metrics if specific temperature metrics type is supported or not.
+ *
+ * Return: True in case of metrics type supported else false.
+ */
+bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
+					  enum smu_temp_metric_type type)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	bool support_temp_metrics = false;
+
+	if (!pp_funcs->temp_metrics_is_supported)
+		return support_temp_metrics;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		support_temp_metrics =
+			pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return support_temp_metrics;
+}
+
 /**
  * amdgpu_dpm_get_xcp_metrics - Retrieve metrics for a specific compute
  * partition
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 768317ee1486..09962db988d6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -526,6 +526,8 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
 ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 				   void *table);
+ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
+				    enum smu_temp_metric_type type, void *table);
 
 /**
  * @get_pm_metrics: Get one snapshot of power management metrics from PMFW. The
@@ -613,5 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
+bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
+					  enum smu_temp_metric_type type);
 
 #endif
-- 
2.46.0

