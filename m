Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BDFD10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFC210E600;
	Wed, 26 Nov 2025 13:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bw2WLQRu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A35C10E603
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfa0PdB7CzpvsKFUUDC3mvArca0oIx4a+HajeEPnn78fKwqN5/SUCD2qNRgyVGP5LpIfB+C2Ys2K8yzpc73kaWM7ccyPFnTPF3Qq++ehWQdwBIWJAFjlxaGdg2zX38A2esZV/NJ0yaSq+rmSDb9Trwj2Fit1tqYVAhl+VhzPxXF/tHLR3qkckYwHHBepXdkKiGL9FHLwNcwYV4aDBgOn4ctweSNkNbkwHqlT1xvPxCM3Ynk++lblJyyJ8/PuEbcq40KdzPuGM3ODC2FYj3fiFLZQKyGsjdwnldxRP8pd5+f6RXlCwiLPgc9Ucho8j/aZ96a+EaO0bbCmZGXM8BZ1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIeTpEpI8w2DWK6VOAH4hJtsbe57URpCf7FzhvPEZes=;
 b=Nr789i2wpjzU9CBRL/E5vEQ9qUsQgiD7lhh/P0i8mr9pHm3+o92yYF+63gT4KT2nYRl385qzW5CBGiMOEU3ovJB7kQ7W604H9xHuGBRZ0fOEKAvebPRwiZCMKy7ygl4Yx9NvV4mozKMvTcBsxNTYl0iDnSSDi4+2h7pIyTEO6aiQeFktmQkYrx74kUoiORc3uBk9j1E9/d7La0YFo6ABOZ74hrEy9510yvuU0sRoZ0Pw8ZJErUoO3j3S/zezHJBeD5BizYkAYx8Cc8T2fiuyLZXuSF2po2ilhUxRfM+Qknjv4Y1cWmPtAHiRgN+/bwiPS5bml64WXQxWigBofiOCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIeTpEpI8w2DWK6VOAH4hJtsbe57URpCf7FzhvPEZes=;
 b=bw2WLQRuAJABYVF2FzBeYIQHd9bK/gIIKIEkPHAOredpllVd0vrH5xTUFvJHTrpRSEBmvY0Z99hTookDznZbxy2hdsbH7ICafG4HBCXh3BJF2EN6EMJLuhecS/QKvAtQ9q6zl8oUuPJcHnanC4DRsCu1hi1mUfeVReoADkscU5Y=
Received: from BY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:180::16)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 13:29:11 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::21) by BY5PR13CA0003.outlook.office365.com
 (2603:10b6:a03:180::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:08 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 17/20] drm/amd/pm: Use emit_clock_levels in vega10
Date: Wed, 26 Nov 2025 18:54:04 +0530
Message-ID: <20251126132822.3266730-18-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b0f2d6-caac-41b2-2fee-08de2cefc8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VKkJcZ+6mVVOf2TAJTQtt2wUlNwYqX1gbfOsauKUTgTubU1/GYXR1nydBq3D?=
 =?us-ascii?Q?73bqrnotl3Ys8z3uUAUe86J+pYJMNlFUsZHc/0sYZf+CWvWOwbLc4EvArIVj?=
 =?us-ascii?Q?+AfKOIIINXobAvQZNu122bB3hLOewSY/KhhJUmkMz0n8RBk0T8q10FKAOmEs?=
 =?us-ascii?Q?H97m8Z5LLSsEo5wViDvIFcOjO2qrYCoYfGMCwuiGunTmCqfqjl4Rj7t1wiYG?=
 =?us-ascii?Q?59sVRfB1sq0oPKpCZ+qtIerw5rZYyjbNHcrLpeC+uw5bEvRkUlTExPCtLrV8?=
 =?us-ascii?Q?KX/v0FaZN4wdUM7BrXauOb2/sQyiOgClDxDJH2F65SWip0rFRj2//IY/C6Ko?=
 =?us-ascii?Q?KLv7F2rphIvCwClppwQjT6jQ8mtYW3VUb84dC7O0fT4uv9YwCkZE4gFJd0nD?=
 =?us-ascii?Q?BbeL60z/xl9tuUIOQT6/GRAzuXsackRPLoyI/HI0ApW6Ws6AgW+wMfEFP6EP?=
 =?us-ascii?Q?jmTxLTK81flrTKevafnmy+TWk3jt1+CBzv4ZCD+l3PSXPh5VHB+UsSjiv4df?=
 =?us-ascii?Q?bMqC1ev4GbnbJlhVJmvil/T3szgvY2XXCDR3gF4UfyfkizpX1t0y9F1B35YA?=
 =?us-ascii?Q?ZBsUfFrH2NH01t+uNq1ChVkcX19FncwxrsH3F8A4JS9hxiF+M/8S3KB9tHlW?=
 =?us-ascii?Q?utu5Qz1f67tzAeWKPmeMcp/cgOLU89v0+1+QbuzQIKfgrYGVX0iiAeqzki5N?=
 =?us-ascii?Q?wxhGuOPt+K3KZs1SvC5kbhseZpymeSsGmx41lVLC5/dhxuwcIJ8sQ3EJiAEl?=
 =?us-ascii?Q?M/CZ0Os7PrLLt+jn61NyntVNNmU7PNAUHVoNlbjZlNT/s2Fiw/i04242KscC?=
 =?us-ascii?Q?0GejPVGAVi/iIBsKJHdsGc9hKhWLuHPYwCgzwcNYHMO65p4Oqp8N5STkGacg?=
 =?us-ascii?Q?DqQIwLcMYpbCmLtpTdIPKoGnMVCb5BLwsACEQHNAgCQNHpKVlYZtGu4mm+Bf?=
 =?us-ascii?Q?7NmbGQDAXubBtUgHxAGgj63C/ThCMuRVk5C7wjbRpVktGi66w/Rh6Ev+rPK0?=
 =?us-ascii?Q?CT2xkA69dQQNoGBYafL82jp73NUEENoRV/XDJ1K38Va2qLG2yD96WatkcPZR?=
 =?us-ascii?Q?Yb/xWWKk0Gfib5vPMZ62jEI7hQwhGydS4GIoYQ26mJwqmyzc7Rdy1DvsazJh?=
 =?us-ascii?Q?kdlKKUJUuOimoPwaPM+xGviyUcdLYw2MkQNJ5vpUZ04/MQar/4oIcl5r3VD0?=
 =?us-ascii?Q?xEQwY7WhfjSdO0Gm1WzH3rhefaS7t3xZ5vyanfjraGVfpctvQPCv90Nx0w3o?=
 =?us-ascii?Q?nCS31RMow32R7pIir4cSfNj8eHT5+329wnQWj5AyQYRvBKkjqkFS34IL2jq2?=
 =?us-ascii?Q?FlZn/NUzFpsd5X7t8r/xrbD5Zzxxlt7EvamrXHpxFAO6Qe+fIds5Jt10sfsA?=
 =?us-ascii?Q?eLI5uEn9GD+YhoJ+YHxlkFJQafoCO0MifrorJzoDFvUDzwIKlbh2owMnzTeb?=
 =?us-ascii?Q?Ks5ygR0YYBDNH3Rk6lt/cXmz7P/C0zgXYMh0UyUnjI9DXOMkz2EP8tOVDFTb?=
 =?us-ascii?Q?rQXpt/Kuh3tkpPqbpKVRF0myzOHfIO2ciP5M3guCSO+QJq590xOvf7dgwF7w?=
 =?us-ascii?Q?eahv/1T2rYXIEazXUYM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:11.0234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b0f2d6-caac-41b2-2fee-08de2cefc8d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

Keep only emit_clock_levels, and remove print_clock_levels.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 141 ------------------
 1 file changed, 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 9ace863792d4..1b8a57d98759 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4825,146 +4825,6 @@ static int vega10_emit_clock_levels(struct pp_hwmgr *hwmgr,
 	return ret;
 }
 
-static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
-		enum pp_clock_type type, char *buf)
-{
-	struct vega10_hwmgr *data = hwmgr->backend;
-	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
-	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
-	struct vega10_single_dpm_table *soc_table = &(data->dpm_table.soc_table);
-	struct vega10_single_dpm_table *dcef_table = &(data->dpm_table.dcef_table);
-	struct vega10_odn_clock_voltage_dependency_table *podn_vdd_dep = NULL;
-	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
-	PPTable_t *pptable = &(data->smc_state_table.pp_table);
-
-	int i, ret, now,  size = 0, count = 0;
-
-	switch (type) {
-	case PP_SCLK:
-		if (data->registry_data.sclk_dpm_key_disabled)
-			break;
-
-		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
-		if (ret)
-			break;
-
-		if (hwmgr->pp_one_vf &&
-		    (hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK))
-			count = 5;
-		else
-			count = sclk_table->count;
-		for (i = 0; i < count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i, sclk_table->dpm_levels[i].value / 100,
-					(i == now) ? "*" : "");
-		break;
-	case PP_MCLK:
-		if (data->registry_data.mclk_dpm_key_disabled)
-			break;
-
-		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
-		if (ret)
-			break;
-
-		for (i = 0; i < mclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i, mclk_table->dpm_levels[i].value / 100,
-					(i == now) ? "*" : "");
-		break;
-	case PP_SOCCLK:
-		if (data->registry_data.socclk_dpm_key_disabled)
-			break;
-
-		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
-		if (ret)
-			break;
-
-		for (i = 0; i < soc_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i, soc_table->dpm_levels[i].value / 100,
-					(i == now) ? "*" : "");
-		break;
-	case PP_DCEFCLK:
-		if (data->registry_data.dcefclk_dpm_key_disabled)
-			break;
-
-		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
-				PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK, &now);
-		if (ret)
-			break;
-
-		for (i = 0; i < dcef_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i, dcef_table->dpm_levels[i].value / 100,
-					(dcef_table->dpm_levels[i].value / 100 == now) ?
-					"*" : "");
-		break;
-	case PP_PCIE:
-		current_gen_speed =
-			vega10_get_current_pcie_link_speed_level(hwmgr);
-		current_lane_width =
-			vega10_get_current_pcie_link_width_level(hwmgr);
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			gen_speed = pptable->PcieGenSpeed[i];
-			lane_width = pptable->PcieLaneCount[i];
-
-			size += sprintf(buf + size, "%d: %s %s %s\n", i,
-					(gen_speed == 0) ? "2.5GT/s," :
-					(gen_speed == 1) ? "5.0GT/s," :
-					(gen_speed == 2) ? "8.0GT/s," :
-					(gen_speed == 3) ? "16.0GT/s," : "",
-					(lane_width == 1) ? "x1" :
-					(lane_width == 2) ? "x2" :
-					(lane_width == 3) ? "x4" :
-					(lane_width == 4) ? "x8" :
-					(lane_width == 5) ? "x12" :
-					(lane_width == 6) ? "x16" : "",
-					(current_gen_speed == gen_speed) &&
-					(current_lane_width == lane_width) ?
-					"*" : "");
-		}
-		break;
-
-	case OD_SCLK:
-		if (hwmgr->od_enabled) {
-			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
-			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_sclk;
-			for (i = 0; i < podn_vdd_dep->count; i++)
-				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
-					i, podn_vdd_dep->entries[i].clk / 100,
-						podn_vdd_dep->entries[i].vddc);
-		}
-		break;
-	case OD_MCLK:
-		if (hwmgr->od_enabled) {
-			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
-			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_mclk;
-			for (i = 0; i < podn_vdd_dep->count; i++)
-				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
-					i, podn_vdd_dep->entries[i].clk/100,
-						podn_vdd_dep->entries[i].vddc);
-		}
-		break;
-	case OD_RANGE:
-		if (hwmgr->od_enabled) {
-			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
-				data->golden_dpm_table.gfx_table.dpm_levels[0].value/100,
-				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
-			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
-				data->golden_dpm_table.mem_table.dpm_levels[0].value/100,
-				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
-			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
-				data->odn_dpm_table.min_vddc,
-				data->odn_dpm_table.max_vddc);
-		}
-		break;
-	default:
-		break;
-	}
-	return size;
-}
-
 static int vega10_display_configuration_changed_task(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
@@ -5792,7 +5652,6 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
 	.display_clock_voltage_request = vega10_display_clock_voltage_request,
 	.force_clock_level = vega10_force_clock_level,
 	.emit_clock_levels = vega10_emit_clock_levels,
-	.print_clock_levels = vega10_print_clock_levels,
 	.display_config_changed = vega10_display_configuration_changed_task,
 	.powergate_uvd = vega10_power_gate_uvd,
 	.powergate_vce = vega10_power_gate_vce,
-- 
2.49.0

