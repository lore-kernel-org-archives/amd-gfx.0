Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABCAFD708D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF84D10E5E2;
	Tue, 17 Mar 2026 20:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NAA4sivT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4376410E63D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6QwTsmZk2zMocNgbvDNrs2/yxo/ByVmq0c5r1g0oyk/qE6e5i8dLpD0qFsEGhin9tAsmi3KZz+xxtrizfkbnh1726g6nueKjM3seiLzPOSQ+9IVGR9P0OKsuZgRUkiqTEByPnuxTqNQdPw52o3XwsdO8xip/vn1Q9MVf72WoIlwSr7SmcP6X0DQReP36RqusJXlGgGNvZv7byodwHbPmH22HnOMpHhlnvw+KNVuy7geMngRkVz3Bu1qv0ybH7Axx4oX6Vs2cScMWUtaLI8jssHqeP8j25YnNphnkt1g1fT2U5lEzsrIXbPfrheOA2YBmrLTBSNmBs1axUHW5/DSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5EyDL5EOF7EsB5yr95IbRWBPXOWKYGIl4WK+sggFFg=;
 b=JOiFSmNTdhYT8D4sJ5GmBmMeYXLFxrE9R9ng/VQbgifQzuuebOXTzLFX0++J9khmsHwWFB8+0SE7c/BTVtMT7ZPOe3rc/ILjslMRVzVisTYew4PWWjSAgcrAZuepTZQ5y4cyeib6ov0ztgPjXDholTuAz0udey5EDqndasnWmufGZ7JkePevs/PTkg7JbMLPUiv/8y57VN7RT6y3/2gglZVZeG//WV86PQopeowDI1x6KGbDwNpGIBK2Z6KbCE5vDIXoAyZ+wgOTqLGEJ4meSWV/l+2s+qHJntaqoLl1qNU/gUbYBLcC3hPkD6Auzpt8/tFOnuW8xOfBsi5NE8Eg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5EyDL5EOF7EsB5yr95IbRWBPXOWKYGIl4WK+sggFFg=;
 b=NAA4sivTlFkS2OtEQdLvwnODV0cYdklb3PoPkduWssTlVEldEagPtV5TdNp+MgLc30WqpIKGEddR9xnqXE8jPhYJ4Y0Vs+pSd+q3KrNIb00BdMIAboF0SMaQcrBt4z7AS5UzPuyCimHTlFcYUeTor0hWH+OooUkuY/qE1TkyuWk=
Received: from PH7PR17CA0017.namprd17.prod.outlook.com (2603:10b6:510:324::13)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 20:13:13 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::e2) by PH7PR17CA0017.outlook.office365.com
 (2603:10b6:510:324::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 15:13:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 14/25] drm/amd/pm: Add emit clock support
Date: Tue, 17 Mar 2026 16:12:30 -0400
Message-ID: <20260317201242.3808136-14-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc3aecc-af93-48e2-728a-08de84619dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LXLG8bZdj2sW/ox/B2ykL1VUTOqh9FxoLAKzkCsm2+KQM3XeGrIc8te1bfMYPp567t/xdjNv8FqlJ5PmibVdsb7gssBvrfAjjEmzaQdj9De80zPaxhYMuoq09CzYIN4oz3BdzZ9sJn5Rd/h4nJfgeC2qqg2P4URsKpeVc2MW7Rp3U/Qt3Wxmmq2quaYYGgS+7UZGGaLuHZP8hrU2ShYET0j5fpilCgUEJ0Ea50mp3xU6WEGzQ1jiUY/M9+LAIgM21sIeHSnIjl8GF1hFPGlJRSwhZYMQ35F0c9a2Yp8ob9kZIMV5DFaMRcxl+iwiQ+BaB2Qa5vBjw3zP2W7HIfrLWwu4D3Bk+zQGgAlEbVot29RKm3JaoDmwEfGCY/04PU/p83wzXkeC8ryD7e//BE7vhM3otpEUWB0Zi7FgHjR1+0ESmeSH+nhOBu6fih+0ykshH59K+yXUhv8Vd8TaBs40Z/Lpg2v/SdydKA5/WwzPn+EMLYhya0tm2R2UoYiVNSO3lfunnXzisvH/lRVpETA+ddvvHnEEnX7yvzPFzO+KdEWhHhhKfsuuq/3VsOSdYbKcifxkea5aIZAIRnltuIRUUAoySz3Ix9lllDYn4Pg9Ey/xg/yGyHqQY+msZKrUe8Id38vvrYZlLZplOqVT6gLJM6XMOrl63tvUP16ST442soRxV9dwJyWdx/qS2H56p3iPRQrb2/CxEGdXVkjq6gRpA1peE7YN5FE7FvP5FbXQuTkcWjBnGzd8YKDgRfjU7a+xPg+halpK9HcLtfIxbBU5DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xdbBdaJKjj+GC84kskVykyvjb1EcYgLm59PxkY8f216u+9doPdiQxKzyNZFQsSyZRBdjAsCoc/N9yKPSKq2OKXtSLRD46Fh26e9jSLzPDD0NCWozlNDfG19Xy0M99z4Dzw386M414jZpBFTE1aniIlL4KUpbzCj/rIMg9HujiKYi+svLO/iBsjUQxA4TZHZIBttN4j1EJX8knaz5X0VyWRErQ1IXipp+7Eexa58NXfcGjARoPDHxD6VkelNozn7LokmFIF+K8X8zPam/HqPtBeLDihFbSBMa+YxdZLlZ9GmaLyFDu0wfClyQyJr/ggY5gSnCU+dTLHUzgAsUrZH4o6Tl4OF3dDsQJjzJ1RAWupusJ7tNu6I/zEz1EHJXTrvaVX2MKjglvLk0Wzt82pRjcl/soIw47PlJZB3QDThi8fYeX1JR1AdfwOHvyHetAveH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:12.7863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc3aecc-af93-48e2-728a-08de84619dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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

Add emit clock support and fetching other metrics data like temperature,
clock for smu_v15_0_8

v2: Use umc count for hbm stack temperature (Lijo)

v3: Use correct logic for hbm stacks (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index d7d40985b0b71..9b48c258b1f20 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -311,6 +311,203 @@ static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint3
 	return ret;
 }
 
+static int smu_v15_0_8_get_smu_metrics_data(struct smu_context *smu,
+					    MetricsMember_t member, uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	int ret, xcc_id;
+
+	ret = smu_v15_0_8_get_metrics_table_internal(smu, 10, NULL);
+	if (ret)
+		return ret;
+
+	switch (member) {
+	case METRICS_CURR_GFXCLK:
+	case METRICS_AVERAGE_GFXCLK:
+			xcc_id = GET_INST(GC, 0);
+			*value = SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+		break;
+	case METRICS_CURR_SOCCLK:
+	case METRICS_AVERAGE_SOCCLK:
+		*value = SMUQ10_ROUND(metrics->SocclkFrequency[0]);
+		break;
+	case METRICS_CURR_UCLK:
+	case METRICS_AVERAGE_UCLK:
+		*value = SMUQ10_ROUND(metrics->UclkFrequency[0]);
+		break;
+	case METRICS_CURR_VCLK:
+		*value = SMUQ10_ROUND(metrics->VclkFrequency[0]);
+		break;
+	case METRICS_CURR_DCLK:
+		*value = SMUQ10_ROUND(metrics->DclkFrequency[0]);
+		break;
+	case METRICS_CURR_FCLK:
+		*value = SMUQ10_ROUND(metrics->FclkFrequency[0]);
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = SMUQ10_ROUND(metrics->SocketGfxBusy);
+		break;
+	case METRICS_AVERAGE_MEMACTIVITY:
+		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+		break;
+	case METRICS_CURR_SOCKETPOWER:
+		*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_MEM:
+	{
+		struct amdgpu_device *adev = smu->adev;
+		u32 max_hbm_temp = 0;
+
+		/* Find max temperature across all HBM stacks */
+		if (adev->umc.active_mask) {
+			u64 mask = adev->umc.active_mask;
+			int stack_idx;
+
+			for_each_hbm_stack(stack_idx, mask) {
+				u32 temp;
+
+				if (!hbm_stack_mask_valid(mask))
+					continue;
+
+				temp = SMUQ10_ROUND(metrics->HbmTemperature[stack_idx]);
+				if (temp > max_hbm_temp)
+					max_hbm_temp = temp;
+			}
+		}
+		*value = max_hbm_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	}
+	/* This is the max of all VRs and not just SOC VR.
+	 */
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return 0;
+}
+
+static int smu_v15_0_8_get_current_clk_freq_by_table(struct smu_context *smu,
+						     enum smu_clk_type clk_type,
+						     uint32_t *value)
+{
+	MetricsMember_t member_type;
+
+	if (!value)
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		member_type = METRICS_CURR_GFXCLK;
+		break;
+	case SMU_UCLK:
+	case SMU_MCLK:
+		member_type = METRICS_CURR_UCLK;
+		break;
+	case SMU_SOCCLK:
+		member_type = METRICS_CURR_SOCCLK;
+		break;
+	case SMU_VCLK:
+		member_type = METRICS_CURR_VCLK;
+		break;
+	case SMU_DCLK:
+		member_type = METRICS_CURR_DCLK;
+		break;
+	case SMU_FCLK:
+		member_type = METRICS_CURR_FCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return smu_v15_0_8_get_smu_metrics_data(smu, member_type, value);
+}
+
+static int smu_v15_0_8_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type type, char *buf,
+				       int *offset)
+{
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+	struct smu_15_0_dpm_context *dpm_context;
+	struct smu_dpm_table *single_dpm_table = NULL;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	int ret, now, size = *offset;
+
+	if (amdgpu_ras_intr_triggered()) {
+		sysfs_emit_at(buf, size, "unavailable\n");
+		return -EBUSY;
+	}
+
+	dpm_context = smu_dpm->dpm_context;
+
+	switch (type) {
+	case SMU_OD_SCLK:
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->gfxclk_pstate.curr.min,
+				      pstate_table->gfxclk_pstate.curr.max);
+		break;
+	case SMU_OD_MCLK:
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->uclk_pstate.curr.min,
+				      pstate_table->uclk_pstate.curr.max);
+		break;
+	case SMU_SCLK:
+	case SMU_GFXCLK:
+		single_dpm_table = &dpm_context->dpm_tables.gfx_table;
+		break;
+	case SMU_MCLK:
+	case SMU_UCLK:
+		single_dpm_table = &dpm_context->dpm_tables.uclk_table;
+		break;
+	case SMU_SOCCLK:
+		single_dpm_table = &dpm_context->dpm_tables.soc_table;
+		break;
+	case SMU_FCLK:
+		single_dpm_table = &dpm_context->dpm_tables.fclk_table;
+		break;
+	case SMU_VCLK:
+		single_dpm_table = &dpm_context->dpm_tables.vclk_table;
+		break;
+	case SMU_DCLK:
+		single_dpm_table = &dpm_context->dpm_tables.dclk_table;
+		break;
+	default:
+		break;
+	}
+
+	if (single_dpm_table) {
+		ret = smu_v15_0_8_get_current_clk_freq_by_table(smu, type, &now);
+		if (ret) {
+			dev_err(smu->adev->dev,
+				"Attempt to get current clk Failed!");
+			return ret;
+		}
+		ret = smu_cmn_print_dpm_clk_levels(smu, single_dpm_table, now,
+						   buf, offset);
+		if (ret < 0)
+			return ret;
+
+		return 0;
+	}
+
+	*offset = size;
+
+	return 0;
+}
+
 static int smu_v15_0_8_get_dpm_ultimate_freq(struct smu_context *smu,
 					     enum smu_clk_type clk_type,
 					     uint32_t *min, uint32_t *max)
@@ -1206,6 +1403,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_unique_id = smu_v15_0_8_get_unique_id,
 	.get_power_limit = smu_v15_0_8_get_power_limit,
 	.set_power_limit = smu_v15_0_set_power_limit,
+	.emit_clk_levels = smu_v15_0_8_emit_clk_levels,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
-- 
2.53.0

