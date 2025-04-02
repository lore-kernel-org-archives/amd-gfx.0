Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EC0C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C758C10E81D;
	Wed,  2 Apr 2025 16:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jBXLmnqR";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F6110E824
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEgSC0ZoIMn9JIguzxzvFBgmAoNgntqo5v4sx8r5CgPfIbqos35b8SaAHZgS6TO+5sEyL4H8WFTpfrel8n5r17n6lMhRyvD2Mi2w8gsHrW9ZmOsz6rC71nMvASiWK97oL2AMRfcbRM2YSu3v0ymo9DQK+YUaIPfgCiwv+7MKAdqI5f+gkI5XqYD8OhFeNq4A1J9TMAweEJJaT512E15LWAtVDF9230qgSM+SnsBBTucHEp12q4kdrNQ/6YEQQh53vMUpNJmOthF+R7dDqo48sOmDJT7YhJX4RmmBVw6TAi3Yw7QpkWRj9UMoFwA27o81c5iJ3wxqSWZ3t0dz/hHrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elbzy3idJnRCzdHbx9e6dIJEQAlVd6rbPUu+zuMBQ0Y=;
 b=RY5/AOLfsVVdLzNPJX94XQ3KD9KxSw9ogjzO42qcXlJ86SLkb1J0TCHaqYWLG8TGMc2YJy0vhy7xP6iolz5s0jvTDFrJNEiDEYl7ih1Hr49i88rpOjnq2/w9HWfSg1Dl55iOO+mNOeVo6Kbl28qZOf9/2VONp0yGJKJcyrH+Oj2nmwq1i22XehoTOZYOijUyfglrR+4GYKrxlv5vZTD8MgmuYcTzkxBvM/rSyTtq174JvElepkBvzmo1Sc7LNrAaX/y/hOdhNPVfyNhGEJtMyjppu1im5BPZ9R3udHMDwDLN9TmzcqzSgpJAB3UHZFbEHgjbI2OCSn4/sLazfPnlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elbzy3idJnRCzdHbx9e6dIJEQAlVd6rbPUu+zuMBQ0Y=;
 b=jBXLmnqRvrfUJa0cAlac4+nY1PzQj917EqqocPQoFNkP7odYaSsseiWcC2LJhzEy0QK15OEk8JYxBe0H7EHTHN0fbRuYSP4h3kJA8unDQu1TY+t7mvJUBzJBtmlFOC1hqE6cWVBIdYm32ryxtQLWNiu6VWuazYMOlc9R7U+UzXs=
Received: from CH0PR03CA0401.namprd03.prod.outlook.com (2603:10b6:610:11b::35)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 16:13:42 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::fb) by CH0PR03CA0401.outlook.office365.com
 (2603:10b6:610:11b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:40 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Remove double checks for
 `debug.enable_mem_low_power.bits.cm`
Date: Wed, 2 Apr 2025 12:13:10 -0400
Message-ID: <20250402161320.983072-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c022de-ab71-4c69-8c13-08dd7201560d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9kY0026bdJSNWGyekHNUi6oWosge/bWgFlAT4lr+jp+qkrRhBZkobgiQFbI2?=
 =?us-ascii?Q?1q21imIVWcb2FigmMb3i3wbjXznJ4edH0f2zjQyuxbV1cqz2uGqO6/CfN4zS?=
 =?us-ascii?Q?Pqnc3AzM7hRw3RJurk6UX8e6+/yyPe7ViK9FwkHoA69IcXHEpnWzYsjZ11KK?=
 =?us-ascii?Q?sONxvQkaNKjUkfSCUzI5ZYXaoM4ZB3NWOMoN37I8QippJO+LGkA+3kKu7f2v?=
 =?us-ascii?Q?X9ec3ghSUZQZhY+Z089mXGEzIGsaVOr0xYnI2AzXAO3s1rvRlRkyaUrcy/8d?=
 =?us-ascii?Q?fLs+LrLUn5UyLdjFAdjc4U8aQStT2lxQm5dnBK89HeEKom1obw4q0HHF2T6D?=
 =?us-ascii?Q?USlo6srPda6wZvr9gQtkaRoKtuarg+x+OFReqMgDVewWALx1nwvKqZ9kLPid?=
 =?us-ascii?Q?Bcj+sG702e8fyk9EQ+pp9GXqe+usGpHO0L6NWYcoZ3R9Aew0mzPxeN9hel5r?=
 =?us-ascii?Q?RUEwniKZ0zr1lXwK3x3bC3A+8m/ew9H7GzSBD8htBbbWc5LF89GNzpbR+UUz?=
 =?us-ascii?Q?PXvEMQC+TIz8b3g5QOVqlrO6eiv2OS4whpeaJxpXLAiIsdA46VOMoJqvnLat?=
 =?us-ascii?Q?1+URqR+HTBlLmwopJHh8i7S2zLoRbwvCsNVXIbCR09Mv8CgI4/75Qilr1O0h?=
 =?us-ascii?Q?izyel+s8IMs0VEt93oUVUWYu5/Ok2oX5Fm7aFoxJYab6tNp8zvBStRqn5g6Y?=
 =?us-ascii?Q?JwPSrBzm1fahOAeo9luJl5jFHXe71Smr0pMMAPtrhA9TQtfu4Kcc5e7F3gnm?=
 =?us-ascii?Q?CKylsGFc9mzYeaoK9tPUExToeqhwG38DYbgNVWecgcFr6POomMOsNM8sbD6Z?=
 =?us-ascii?Q?4p/Te9w99/wvG3UvSMeyGvWugmar4uHA6yM/DpX34MGVSflk4oE+3nN74QG4?=
 =?us-ascii?Q?vFm5TeKcFAAjrYDCgoiivjQueRrVFz+uPgCQns6buMeyqAJAYAeH5H56FVqW?=
 =?us-ascii?Q?YdhoP5d+tQMxSpeBsbqDUJd/Q3x8lL2GVnMircih+15t+2/OEr6euqPFoRjl?=
 =?us-ascii?Q?ohkywSkdTdWKD/5cvs8pYe2pkrBV2JY0KPv8iC7z9S0q4KjGSrDkf7aIPQT1?=
 =?us-ascii?Q?vTClhb7GyZUOMtnEhOPvl6fJ/03j3Uhd0EYap+szgMiwiFYUP//C/0ySZjJd?=
 =?us-ascii?Q?L3vApt1K5DW/DwrByLv2C2u+h9hzDhAC4YxbZXEFcOSk4jSMxVm4M1zVdv6C?=
 =?us-ascii?Q?uGBHTij2vX84UgJufxB9sHIHvUAP6VE7eqMBu2eHrD/jaPYsJ17JfF7+7fLj?=
 =?us-ascii?Q?JKjKR2uqayf2deZa9AoFjqF7XXc2oYcAQx+fVKFbeEPUBUL5DeNO+Ha0hNHN?=
 =?us-ascii?Q?CKwRCvaGc/Wj0HeFBEBsCLbNbxW95IN9Ntm0WolRxs4d+o4Xnxoeb5brScss?=
 =?us-ascii?Q?3ESDYnf+Thl+nm4MwDbpGgCH4FBnYwiLKXXYRs0cmekpnL/YlDk/PhbMXyhP?=
 =?us-ascii?Q?J1BWYejFHDWrpc0N4ZF/NaLzaRa59sCrHWvBbhdQiLZvK4RZvZnvNLcjQIO+?=
 =?us-ascii?Q?QR5KyeJJbfI6qos=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:41.9959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c022de-ab71-4c69-8c13-08dd7201560d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
A variety of the 3DLUT handling functions check
`debug.enable_mem_low_power.bits.cm` both in the caller and function.
This is unnecessary overhead.

[How]
For each of them reduce to just checking just in caller or function.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index abf439e743f2..2d70586cef40 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -790,8 +790,7 @@ static bool dpp3_program_blnd_lut(struct dpp *dpp_base,
 
 	if (params == NULL) {
 		REG_SET(CM_BLNDGAM_CONTROL, 0, CM_BLNDGAM_MODE, 0);
-		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
-			dpp3_power_on_blnd_lut(dpp_base, false);
+		dpp3_power_on_blnd_lut(dpp_base, false);
 		return false;
 	}
 
@@ -1204,8 +1203,7 @@ static bool dpp3_program_shaper(struct dpp *dpp_base,
 
 	if (params == NULL) {
 		REG_SET(CM_SHAPER_CONTROL, 0, CM_SHAPER_LUT_MODE, 0);
-		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
-			dpp3_power_on_shaper(dpp_base, false);
+		dpp3_power_on_shaper(dpp_base, false);
 		return false;
 	}
 
@@ -1399,8 +1397,7 @@ static bool dpp3_program_3dlut(struct dpp *dpp_base,
 
 	if (params == NULL) {
 		dpp3_set_3dlut_mode(dpp_base, LUT_BYPASS, false, false);
-		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
-			dpp3_power_on_hdr3dlut(dpp_base, false);
+		dpp3_power_on_hdr3dlut(dpp_base, false);
 		return false;
 	}
 
-- 
2.34.1

