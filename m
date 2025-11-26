Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1131D10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A487E10E5F5;
	Wed, 26 Nov 2025 13:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BfLwmO8M";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2E010E2B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5pBWLj6mV0JOtHbFUXtHrjeqMM3kArR6VqFtKe3NiKzDBwVzZuXHIQtab/FkSePJMQPngaqn5tN/zLgakpVmOotsfgz6YArF+QZOfVOwwQDCdb/EznQxwV0JcHTn2eUL+YpjqI6fk1vNzaYEJ+xpOnPuVFLVW+y8+5SV1xDFBNJSo20QzVfcL+P7CQ22+bwdqoZr06QGBvGU3ei7OHJxhgO1TP5SjhY/jTFQQnHxPj7Tratf0LWzt2OHVgD03J0Xu8snR1dE4QUGE3t+rQzJgaCLFALwaJqMwDCsdNgv+FVFODWrNc7WQMfQA9fQxxgak9wJLtEXNPYKhgsRpAJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah64jJ6o3DxHmDlX2yiRcT6gDhhWQOWEArhmkFAvkEs=;
 b=RnwAAawD0ZCNxnSndAr44n39X0zbgcRyUXB/Vubzh2hbBKqMLXwGcQAzc4FAtQL6TO/oKb6vBa6sL4Pc4ABWdUMEDrJ9+l0rud7sP98Vfvdp0ycNaVcHZ6DhnY+WYSG9HTPvv6Nr7ibDGBpnNMG46/aH+n15IS5t5BtJkizP5hrxLDjFKXT0lTAbi/O6WbfCy5dgRtyb8o/+kmWbF5kEBJvJzUKHdjYUjXurkolYU9PjWKoI9fIJCOT4w0kuNwXaPRcK8XFvEIGicW/1qqZeuF1QZSKaCDQ8yLuSJazdMHVJfxr9In679U5ivvg/pDueSCY75kHmxRN9GaOHc+DVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah64jJ6o3DxHmDlX2yiRcT6gDhhWQOWEArhmkFAvkEs=;
 b=BfLwmO8MEF38abJjkphlw3ynjAeIHZuLmKdGFIxvfGrs/cqkiPwWN+0VYwbjfCCFFxSuYRMuMWMpiJaNyCvVk2QdPfWd/wlZUYo85czTZ+d4pqyg3OZo8rPDvcuOrzQdntrQnrVX33GT+ysJKagkVeCY5Kgb9er/nRWR+eWgXDw=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 13:28:44 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e8) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Wed,
 26 Nov 2025 13:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:41 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 01/20] drm/amd/pm: Remove print_clk_levels from navi10
Date: Wed, 26 Nov 2025 18:53:48 +0530
Message-ID: <20251126132822.3266730-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 2446ea17-439b-4d6b-491a-08de2cefb894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AyZgJbbECfcLknyoLrJJ/53AluWO7r2P/cIj6s1yAr5RMrzDUWG3o9bF+Fdk?=
 =?us-ascii?Q?krzqcnTbVBUtK1K1oVnVr636SCVON1J2keh4i1odB75Nr9oSHr+mkZHmtfv8?=
 =?us-ascii?Q?+o5uD1CodrWSpJtxhcgi7u8JK72r6+yQ5/nw/lf/YYQAzGGSinWrL5ykOlK7?=
 =?us-ascii?Q?z0RqtVRuC5r6UxPGZeaeZg38Wph25AvalgN7h6qRPkHnXAvAKnLj5FNV3sik?=
 =?us-ascii?Q?AAYkHN/04hpMjNq8eBUHAFqVvNLQ+SC2Uv4Mnl/xcNPb5+jBOiWqdknQEKC8?=
 =?us-ascii?Q?eEtwxraOomaD9llyyFSzU09yGtA8hMK2SZwf/bytPdqBWz7G3tgr0ZMr34Gx?=
 =?us-ascii?Q?MUTkDu4bHWymTKawTuvvNe4gWijhHmKOY+jBEdxmtT/Jfr2eWCkT5j0TBfcy?=
 =?us-ascii?Q?mjGp9Vp6a7+NP9klHRZNtH0Xdd83HSw6GYGqf83r6XuibhKYwuySwyPPHp7r?=
 =?us-ascii?Q?K/qbR/LK0pWZWISzs+sFe7OSq3hp0DhwTcn1BHWT4ioZIiIQ+vKayYEPdGvq?=
 =?us-ascii?Q?4DdDAuWBh8uYcEG1gNqpEWv70Rs1D6TwvKcYJ0koErLJWkucmjhmwdueAOzB?=
 =?us-ascii?Q?ZjJJ8Nloow2aoRjCuZTcRqQOOm43ElplxuKIqNOueGxhWlC5aLZthuaJhko2?=
 =?us-ascii?Q?ebTwegsCZ2QRQ8MgNUVtrUo8Q3/P7G1t53fL7l0Pa70Ds3ReJtvXm3MehsLW?=
 =?us-ascii?Q?d8+qXAC/y0PsqDg0eYCYM++MOinWzzOK8dCzhIwjlhd3jczaF1oJKSmYiGe8?=
 =?us-ascii?Q?+72kaZ4sEum6tSwBFkxo1kDB0nw+tQZkI3ilDWnVs+R5cD1jckyUMG7qKdHQ?=
 =?us-ascii?Q?gh6hvpj1ySIbYgFfzHnMhOrnMU8y3LdCgqW/iLAcG6MQ7iE+EwtXDOJ+LSw5?=
 =?us-ascii?Q?Fr67TlrJwmZVB4e3ic+Lg5NvzcwCZNbM59s5V3emlBSF4WeYmKSWiRRhPbWJ?=
 =?us-ascii?Q?cqqgdpl2lWIZNVewqjIEIHlMh6zxWaPUkS2GoQEJsM89SO3CpsVy4oBeJK5r?=
 =?us-ascii?Q?aWPfeiPpkiOL9gGd4gZ0xZaeQ/Susyw2en82MNU2HRrXy2TWXWfV3Tx5CYaC?=
 =?us-ascii?Q?cTJHPrItrsjgeNMTFNTVLBKPZMYnFBJSShTfq9vDTcyPyEswSOxCGIdRoFRy?=
 =?us-ascii?Q?reEhUGkCyV1O5h8SKfZiX6nIDy7H6msrHlVNfxwsnWOfP4NSsVFFMb03YCUd?=
 =?us-ascii?Q?joNIrztUXlP1MUGMDcmNtVCvGWxn3nmRGeKHIPDej/O/1RNWMeIZVMgap6DK?=
 =?us-ascii?Q?mwI1q6fSI4Sga0GhviPwR1Cml/Q4p1DhcnCQlvoeYDM3RH6ppt/WOA4wxsra?=
 =?us-ascii?Q?R1T4c99sOT71a/ikqRQ2oRjgP3Q7bnj8ya0jaFmXimb65vDv9kqWjERhJ4ev?=
 =?us-ascii?Q?m4fGVJwQn84UY+OlN3LV+f+R8RVlFd8oEU7R7eKZHHYy6BzyDOMAlkJ6+dpu?=
 =?us-ascii?Q?lD3Rz0jkp+gtHCzk/dfwKeG4ujDf16TwVIE2P+nhVrW21av0X2e16yHNnNLU?=
 =?us-ascii?Q?5NT02Tb+BmKk8lCUQR5y53a+/SkRfqZI+YN2O+Leww3+5jGE0VXEi7eosGbR?=
 =?us-ascii?Q?v3Zp/ZgnUcNGoTc+jeU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:43.7351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2446ea17-439b-4d6b-491a-08de2cefb894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

Keep only emit_clk_levels as it covers print_clk_levels functionality

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 193 ------------------
 1 file changed, 193 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7c9f77124ab2..2ea33c41aadb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1465,198 +1465,6 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 	return 0;
 }
 
-static int navi10_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
-{
-	uint16_t *curve_settings;
-	int i, levels, size = 0, ret = 0, start_offset = 0;
-	uint32_t cur_value = 0, value = 0, count = 0;
-	uint32_t freq_values[3] = {0};
-	uint32_t mark_index = 0;
-	struct smu_table_context *table_context = &smu->smu_table;
-	uint32_t gen_speed, lane_width;
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
-	OverDriveTable_t *od_table =
-		(OverDriveTable_t *)table_context->overdrive_table;
-	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
-	uint32_t min_value, max_value;
-
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
-	switch (clk_type) {
-	case SMU_GFXCLK:
-	case SMU_SCLK:
-	case SMU_SOCCLK:
-	case SMU_MCLK:
-	case SMU_UCLK:
-	case SMU_FCLK:
-	case SMU_VCLK:
-	case SMU_DCLK:
-	case SMU_DCEFCLK:
-		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
-		if (ret)
-			return size - start_offset;
-
-		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
-		if (ret)
-			return size - start_offset;
-
-		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
-		if (ret < 0)
-			return ret;
-
-		if (!ret) {
-			for (i = 0; i < count; i++) {
-				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
-				if (ret)
-					return size - start_offset;
-
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-						cur_value == value ? "*" : "");
-			}
-		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
-			if (ret)
-				return size - start_offset;
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
-			if (ret)
-				return size - start_offset;
-
-			freq_values[1] = cur_value;
-			mark_index = cur_value == freq_values[0] ? 0 :
-				     cur_value == freq_values[2] ? 2 : 1;
-
-			levels = 3;
-			if (mark_index != 1) {
-				levels = 2;
-				freq_values[1] = freq_values[2];
-			}
-
-			for (i = 0; i < levels; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
-						i == mark_index ? "*" : "");
-			}
-		}
-		break;
-	case SMU_PCIE:
-		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
-		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
-		for (i = 0; i < NUM_LINK_LEVELS; i++)
-			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 3) ? "16.0GT/s," : "",
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 1) ? "x1" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 2) ? "x2" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 3) ? "x4" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 4) ? "x8" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 5) ? "x12" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 6) ? "x16" : "",
-					pptable->LclkFreq[i],
-					(gen_speed == dpm_context->dpm_tables.pcie_table.pcie_gen[i]) &&
-					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
-					"*" : "");
-		break;
-	case SMU_OD_SCLK:
-		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS))
-			break;
-		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-				      od_table->GfxclkFmin, od_table->GfxclkFmax);
-		break;
-	case SMU_OD_MCLK:
-		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX))
-			break;
-		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
-		size += sysfs_emit_at(buf, size, "1: %uMHz\n", od_table->UclkFmax);
-		break;
-	case SMU_OD_VDDC_CURVE:
-		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
-		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE))
-			break;
-		size += sysfs_emit_at(buf, size, "OD_VDDC_CURVE:\n");
-		for (i = 0; i < 3; i++) {
-			switch (i) {
-			case 0:
-				curve_settings = &od_table->GfxclkFreq1;
-				break;
-			case 1:
-				curve_settings = &od_table->GfxclkFreq2;
-				break;
-			case 2:
-				curve_settings = &od_table->GfxclkFreq3;
-				break;
-			}
-			size += sysfs_emit_at(buf, size, "%d: %uMHz %umV\n",
-					      i, curve_settings[0],
-					curve_settings[1] / NAVI10_VOLTAGE_SCALE);
-		}
-		break;
-	case SMU_OD_RANGE:
-		if (!smu->od_enabled || !od_table || !od_settings)
-			break;
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-
-		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
-						    &min_value, NULL);
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMAX,
-						    NULL, &max_value);
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-					min_value, max_value);
-		}
-
-		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_UCLKFMAX,
-						    &min_value, &max_value);
-			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
-					min_value, max_value);
-		}
-
-		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
-						    &min_value, &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
-					      min_value, max_value);
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
-						    &min_value, &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
-					      min_value, max_value);
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
-						    &min_value, &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
-					      min_value, max_value);
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
-						    &min_value, &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
-					      min_value, max_value);
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
-						    &min_value, &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
-					      min_value, max_value);
-			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
-						    &min_value, &max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
-					      min_value, max_value);
-		}
-
-		break;
-	default:
-		break;
-	}
-
-	return size - start_offset;
-}
-
 static int navi10_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
@@ -3521,7 +3329,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
 	.i2c_init = navi10_i2c_control_init,
 	.i2c_fini = navi10_i2c_control_fini,
-	.print_clk_levels = navi10_print_clk_levels,
 	.emit_clk_levels = navi10_emit_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,
-- 
2.49.0

