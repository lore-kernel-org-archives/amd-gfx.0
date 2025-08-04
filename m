Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C06C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6E610E366;
	Mon,  4 Aug 2025 14:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BSzJ2Ixh";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1BF10E518
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laG4aoWH5Gd+pq6b9jz1rSXpvVlruw5ox3UUpZxI/9683/vU38F8QSC4Zolca4MentbWmyE4j3EDxAB4A0phteSQcs+qeI6JchiojwgX7PUKJsLOIWCNPxtKWmnaHQWlI9GUJ2bi1CiDTgtn6uE9ff0QFRInagS4WzXevhuxVDVvJGve0Qs1gC29sACsTKbprLLR0JwSBm1apKZs05TB9OKeMqArzPC0s4bS0HlSDstuBaxiE5Kb2zO9CcCERFfAttnOANlXPWfQ4t3Agku3hmOr0+4Xa4qgg6w1mEeNRe/79nZcQgHxaU92OKTLjw0UJWZMpeQqoPTp4ppa6yM2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPdADyhgVrkcX1TadMl7Rdm1yAxNsXtuEerI7P1jbcs=;
 b=HyJOnGpJkgkjs0gi4/FYGUJQPXPvPaKLHCoVCo/rBTSHaEBYe7dvRu06WH+v7nsI72u+HpiFFzXIx2Wt8N7QGLU19SKMYCt0TugFkdQcVKKNY869sWdfCH06wGbSyoDL9yNLAzUgLgTQd4TcIFT04xEPYveRKy3bZNCub1MeRh2m75DtaqgnsrX4lZq15Sn+WbQ2aut0TSye8QEWX3d/fWpO0LUR3oeDx04tfrYaG71oFlBnrHWWS4KhDeraZ4kojZqwUiRaFQLtP+52shRrFcaPv4BYFLubTFbCdDjJ7GWG0XY/Axz/+pKIN5F6pIhXpv0NavptuCnLIEAHmm3pHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPdADyhgVrkcX1TadMl7Rdm1yAxNsXtuEerI7P1jbcs=;
 b=BSzJ2IxhgRGk4hpaZCbe2f3n+OK7WawJze9OFW1SwNGk7Tczmz7+FmerNLaN/lTzUkEYBUUGaX+oxbRg66JOi7kbOYXg7EniG0AyVRg3Z0fGxDldEoXiHEcQIqfFbTcjrRB5PFdrBIQN4rum9z/qeHUTQT1qala3MbTqridM39E=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 14:18:12 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::ec) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 14:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 14:18:11 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 09:18:09 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v3 1/6] drm/amd/pm: Add dpm interface for temp metrics
Date: Mon, 4 Aug 2025 22:17:52 +0800
Message-ID: <20250804141757.643501-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: a77b1b4d-a7b8-43a0-8ab9-08ddd361be5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?glkt+EH5oM88S5ud0zynE+vXaiwIgQDhPg7V7BRb01waSjWGbYvLQ8mPOgWi?=
 =?us-ascii?Q?zAjz150KBGxj3hwC7k7BoKBP1PM/ujomZfgLppaw2IaTp9rd936iF+p8XahV?=
 =?us-ascii?Q?2HslVE6jqaz6RexqpN27pocF2xIcLF3lAIQeiM4tHyK48BT+wawSsvtCa8zb?=
 =?us-ascii?Q?7rLQ6TUiItajgIJxR8V9vxBF41ozOf9m0UN6vXi0AzbppRIvOGV5VrXgbFtj?=
 =?us-ascii?Q?4oJA4D4yeQdof6pJhjNL++bDb1cyfQZpSYO0DzSznfGpFjrKR6J6hfI0DD7M?=
 =?us-ascii?Q?hbloBTKpsHsH59QZzD6quBxT6DDeMD22h2JtkNavlY4qgkuVcy/fbjbS6nGB?=
 =?us-ascii?Q?JpNgV+++Tzs3ABENoHKX8JxrDYKtJUDuuZcgBoMU2uMxNldeC/fERHhzMsn/?=
 =?us-ascii?Q?0bjJvP8vzHEC8U6XknZWuOrNFfqCPkXQmerrMDNkME5Qu+vLdY33xf6hgSKs?=
 =?us-ascii?Q?2ozRJi7FMPNAi9kKXgC7uVSkNoD5Cz6lqj3sQZ+10Sgjjx1L6eXDF0KRe9h4?=
 =?us-ascii?Q?GbmBhGbByoKyrZhpPBMjUsREbal7TWj1Mwg6m7PKCwpnzaCLE2XFYdON3YqP?=
 =?us-ascii?Q?S+LE8RBPSeAg+A1Ep6/gUu0nTVU9xZNXp3U4fibFp7zhAUohfre3q4Rgq2Zr?=
 =?us-ascii?Q?wQbsVeoOa9JazSPb9diwpy0Af2ncvwJx/NFgCA0NAIJ7WG3gU+QLFjl68MMW?=
 =?us-ascii?Q?gE4Myh0lKbeKdxXSrL/tNuOG2YwAm8BBKbdsHCwQSG/82YlS5C5UIL9XiS1X?=
 =?us-ascii?Q?L+LH2TZGQOVTR04WsiSSQoD6wBi2UeR8BrVpVWDvnDt43Ybl5o6FP5+fZw4J?=
 =?us-ascii?Q?Sh4JkF9NJ84IKalbFALJV9iibphWeJ/FfKB/USCLWtYetX+XGIPmH/BlZOSA?=
 =?us-ascii?Q?qwKcegfeQOHmC7ZNtpz9F3wImZsN3pTKrOjAnA5bdvYzXb+AD1zxSlF9H4dZ?=
 =?us-ascii?Q?bhY0un4+gsjQ7LK3MPJ1LICDLlHrMQg9L90/oDlwUDwYOhRcKZ4YkhUjaJmr?=
 =?us-ascii?Q?72QK+7taEBXoa/Jr4kvIXhr5OvWEeQ/sdM5RjTgNzD4mIImdeJVCDLYW82Xs?=
 =?us-ascii?Q?Sy9lLD4TGYfsNvch4ZP015E2utUrmo1PPqLSbvkvgY7ZKzghKB5LRXrUSRyW?=
 =?us-ascii?Q?uQUT7FxextqNKPqrIIXHtrAPqu88BSC2FNlLOud6gSBZT6SHSrApYiXzAVKS?=
 =?us-ascii?Q?Xd22VJg3FAw5woffjeG/pK/uQaudgBirgpyWgLoxBE9mLbeHI+GqHXdGDXYT?=
 =?us-ascii?Q?kF2N15nC1zrMqbOp3OC1cPnhPyVvCtRNasaeuNYeqzRoD2XCdi5A4Mg40JHk?=
 =?us-ascii?Q?GgV7GoPsHBObSqqXfrmqUayVMOML+IKAFYuM55t5PqYNOmOxKYngk/V5AQTB?=
 =?us-ascii?Q?sfOmcFSJ5EmllY0HGad1KefXvL6rwO2zNmdOWXHdeuCiWL4BKZyNolHfgmgG?=
 =?us-ascii?Q?SFpwGuSFWyUZqrEmH3ov3LXE3GBH8AG/8tW/y/314TgMTh25tMpaKJbvSyOP?=
 =?us-ascii?Q?lU3xHvQ84eaRqeG4iByndBV9UKZI4ubSUhRs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:18:11.4936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77b1b4d-a7b8-43a0-8ab9-08ddd361be5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
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

v3: Return error code in case of operation not supported(Lijo)

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
index 71d986dd7a6e..8e19054578f7 100644
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
+	int ret;
+
+	if (!pp_funcs->get_temp_metrics ||
+	    !amdgpu_dpm_is_temp_metrics_supported(adev, type))
+		return -EOPNOTSUPP;
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

