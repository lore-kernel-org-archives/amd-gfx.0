Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09DAD6AAEC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D40B10F308;
	Thu,  2 Apr 2026 18:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3TPcfxs";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A18F10F2F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsPCv7SC44/IdXTxlCkPx8UvgCa1ioo1FKoBqVZyXQ1PzadXHOLEfuQFcpp1CDcBovOgF+sGpU+9c8reYo1gfPVOO2e2NcLtdo00YYPvx7GbZGWREbuhfX2x4e7tEoNxiWntcc/SCSl21L5DSbmJgRvBO9aCbP0pk7N8gkLSd5QB9pmE6hSkvYs/8SbSNQOVRHU2AVFVFGBKIWwLrcbroWa7zktBoVIgIkK9fLaZF1vx03Ax9U1fsWCEK16+VeiWGi/QyRx+Deg8393J7BfKkEJuUVeR9ZvKbUiva+08O/fHxIRtWL8XJlZV4hrXo1BAB0xNQ+Eee/M864lZPvMjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wljuPj5LwOpUpbwzYjPwyFaE3/68EYxKoabIiPj9dzY=;
 b=oAuC8kv6s0aUuw4bMa2W4T8xGUatz90XsWtFXxfydQYxXhsg8L65EcEdJXNboSOrwm7KKQFDYKb/AUUEN01zxihrTkQB0OX5s96EmZ0hPdqehsk5VAGUmbyCPkP1+MYQCVP3gD3T7Pb7Cs9UShTbx5HBxkV4rT/vK3lnF4KaBrN3+bh4SKJX3gj/zSIbYdidTe7IESiQAkTSCookuVg+gALfhKhuxmPX6galN3+1G1MWI70xoYFP86L0oK2dvTOoM+pnEU1dKMvVmcD+P4/RugCz1U/UY3iM+2nql5451/HBygpxXiZxyvPIVEl0w0YhG9UwxFBjBjIGHbXRUpfFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wljuPj5LwOpUpbwzYjPwyFaE3/68EYxKoabIiPj9dzY=;
 b=v3TPcfxs4tWlpVxNgTTLo6dd4UMN6mNlwuT5voPOxZJkevILMrcQcQBVCpWV1J/f+h7PSE50i2P79mexVe6WmHywgUxDslaBVojdo49ClfptZRhcDED4TU8vXSjeT/PYH27oxpF1DmipSQgvc9l7Fi08i9lz+F8/+4U4Q43P9v4=
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:34:11 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::d8) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 18:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 13:34:07 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 11/22] drm/amd/display: Fix HostVMMinPageSize unit mismatch in
 DML2.1
Date: Thu, 2 Apr 2026 14:33:03 -0400
Message-ID: <20260402183314.1388755-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 39622ac3-d062-4ec3-5142-08de90e66f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: tGcrZLEdx6uYqNy5EpUwracU8L9j/m2ED9hJhZRJKkivSkYSr+v3EFCCKYUL8GUPXt3KyvPLpR1E4xARAOeXkZErK4K+3ZXHrEKuiVlDKbPMX//36l9GMiR7N3vcOTU+lZ4xJa8uBVVlMZFa9U7ws0vAdw9QWKdYM1sPdU0OMj/6AiqRCB/joU8+6dboMHdJuKA9N1QMsN1jMfSdnvOhsB+kW8bpk8p11nKbiYqKmDs1OTSGNeYOsTg7e98N+xTTqU6+4g4Hhv9Z3LxX//4OYQMxT6JO5N79Niyvv/SaGraCzDiWtXVzdSZD4D8v+DaiF9zclBmrHu8IxFjJHfnw5fxiv0pKMznn9xakE/P4PcrL8mlEESKDHQGXCAgRMVf1yaaFbnZzWEDhkMYRT/Y65VnnRuCXigZMs19fcR+WdzY9IpXEMnoZTLqMvV7N3qTl2k8v8dJMmV8E63MEWc2vjV21sFhRnbXnWwPoRc3b3I8Mbq3URLgKxXC2NNANp58SOM91NySxrp34ksVpxf1UIizMq2a4bCR6syUYWg6xn5DwLK3Qve9ratxefBRSHxQIld6jREkYd3jnY7den300yPMnqXBmLp7yHv31Adsoa6zpPbaS2mVEjFpQTE/S2uixOfd9wZwudOZuv+xPRboBTbgNkm5Uh+dOcXCvLSVbfJrebYfWezB8iN6K13AyO1zpX1ycsfqfjw4YDh98XEJcFC/PFQusMapzt+K7cC7BkFpKNxhH9lE3GvIi6NhT6ZBFkQ9JvKA07Uj9nYMv4z2CzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wMqMqDNGETkUZpY1hWsgjvxwMOafr1pzMWQmpNi44gjUHXdQ/5L8M8dKsU6WPTiblcN6PyJAt+8tGDSc3+KrSV5DA0EfKsaxiemxwnd/yWoYHqF7XnBRrhUgZOjJtREIVip0rNAQCIrAJ5M9HAHfPn0yCqxoK3UdISk23tVEyypDslMxMcUkBwZJpDnfjD/cr/qaOgKL3z+GpvqCRxC8wl3Qho1HlyplPwIbiZGDAeyRze8GSJ2YDva7hiiy+YgM0Xbpxvu8Ks+ertICi9jeh6HIpV3yxnpd9qr3MpnSNMp7fNEvwYre4V9AIQXrH1wWtv6k9UVDYmTtzuePQxAPoreiesw7FhFrDGMvxIenu5L0Cnv/sCx1Vx+BOW8gLxy+Id4j0ZCtcZ9JYSRNVevAUBVyYV04sUNCuzEjwJLrf3TGELhIpNEdcN0U88rWeXfc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:11.6280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39622ac3-d062-4ec3-5142-08de90e66f41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
This was found back on DML2 but was missed when creating DML2.1.

The bottom layer calculation (CalculateHostVMDynamicLevels) expects
a value in bytes, not KB, but we pass in the value in KB (eg. 4).

This causes an extra page table level to be required in the prefetch
bytes which can be significant overhead - preventing some modes
from being supported that should otherwise be.

[How]
Correct the units by multiplying the input and override values by 1024.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c       | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 80813159bffd..c4628801f729 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7402,7 +7402,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 		s->tdlut_bytes_per_group,
 		s->HostVMInefficiencyFactor,
 		s->HostVMInefficiencyFactorPrefetch,
-		mode_lib->soc.hostvm_min_page_size_kbytes,
+		mode_lib->soc.hostvm_min_page_size_kbytes * 1024,
 		mode_lib->soc.qos_parameters.qos_type,
 		!(display_cfg->overrides.max_outstanding_when_urgent_expected_disable),
 		mode_lib->soc.max_outstanding_reqs,
@@ -7498,7 +7498,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 			CalculatePrefetchSchedule_params->OutputFormat = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_format;
 			CalculatePrefetchSchedule_params->MaxInterDCNTileRepeaters = mode_lib->ip.max_inter_dcn_tile_repeaters;
 			CalculatePrefetchSchedule_params->VStartup = s->MaximumVStartup[k];
-			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes;
+			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes * 1024;
 			CalculatePrefetchSchedule_params->DynamicMetadataEnable = display_cfg->plane_descriptors[k].dynamic_meta_data.enable;
 			CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ip.dynamic_metadata_vm_enabled;
 			CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = display_cfg->plane_descriptors[k].dynamic_meta_data.lines_before_active_required;
@@ -8986,7 +8986,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib->soc.mall_allocated_for_dcn_mbytes;
 	CalculateVMRowAndSwath_params->SwathWidthY = mode_lib->ms.SwathWidthY;
 	CalculateVMRowAndSwath_params->SwathWidthC = mode_lib->ms.SwathWidthC;
-	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes;
+	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes * 1024;
 	CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib->ip.dcc_meta_buffer_size_bytes;
 	CalculateVMRowAndSwath_params->mrq_present = mode_lib->ip.dcn_mrq_present;
 
@@ -10778,7 +10778,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 	CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib->soc.mall_allocated_for_dcn_mbytes;
 	CalculateVMRowAndSwath_params->SwathWidthY = mode_lib->mp.SwathWidthY;
 	CalculateVMRowAndSwath_params->SwathWidthC = mode_lib->mp.SwathWidthC;
-	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes;
+	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes * 1024;
 	CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib->ip.dcc_meta_buffer_size_bytes;
 	CalculateVMRowAndSwath_params->mrq_present = mode_lib->ip.dcn_mrq_present;
 
@@ -10994,7 +10994,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		s->tdlut_bytes_per_group,
 		s->HostVMInefficiencyFactor,
 		s->HostVMInefficiencyFactorPrefetch,
-		mode_lib->soc.hostvm_min_page_size_kbytes,
+		mode_lib->soc.hostvm_min_page_size_kbytes * 1024,
 		mode_lib->soc.qos_parameters.qos_type,
 		!(display_cfg->overrides.max_outstanding_when_urgent_expected_disable),
 		mode_lib->soc.max_outstanding_reqs,
@@ -11287,7 +11287,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			CalculatePrefetchSchedule_params->OutputFormat = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_format;
 			CalculatePrefetchSchedule_params->MaxInterDCNTileRepeaters = mode_lib->ip.max_inter_dcn_tile_repeaters;
 			CalculatePrefetchSchedule_params->VStartup = s->MaxVStartupLines[k];
-			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes;
+			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes * 1024;
 			CalculatePrefetchSchedule_params->DynamicMetadataEnable = display_cfg->plane_descriptors[k].dynamic_meta_data.enable;
 			CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ip.dynamic_metadata_vm_enabled;
 			CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = display_cfg->plane_descriptors[k].dynamic_meta_data.lines_before_active_required;
-- 
2.34.1

