Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC55AC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFC110EFE3;
	Wed,  2 Sep 2026 05:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCFEcdNq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E0010EFE3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuuStJY12uxwWrJ635NsDz/MCP0AaaZWWppCd+Jbh5craqm7JSkGi5ceqDuKzpYd+MwRJVz6ZBwdaB18vOTpsEDUpcZFRMIIMqgwXz67AD6KkuWUs1pH3rXsG1PbxfmDqQ6PLTZcABeADqIsxEtaeucFB7o5zviNdwn0C3UVJegnKUNw9rzjp1AgixMn8V1fLokogsOefqgbWMr9VpUjUDOVHd8luJloK2zvqHpb7uWN95083AanBxjOkVdd8WCaIqfBVXE220EBpxALMk+1Z4bMH5p/pUMSz5zo5YstmbGRh+gGfvEdxV6aAt3dhdDb/MFUI2yVIiRnbxfSWpaRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9QHD4/43V6+YjYUPkwJ7coFT8T2Y2RE0gFwxEIb0hs=;
 b=zPnxxjk8Rm2WwQ5u1LLxd5LPbpn3oiM9z43IE5RfgyQrlsIo0KF7yLlr1SwqhbEcd2OTrOThyaomDiip+xXdBhw3R/t+CCBWFatg7+KrSgqnOQN0hmluZ6TkAi7pKr8Ih49Hj4dN+rvRd/17M1gr7dgK6ZTw8vFRsAG2hTc4oScWu9SU1rKZDS7K/e+rqRRz+ZVqCbAzUFqj4vhR5FPLmK5+GK2YnhpOGmIDfQoBhQD+kWCflirL2VIPfxb1uU4TMp2kY4vbGRTte6Ejm5jHjlnOIR2FjDsj0yybI7w/Z/yl/THhj7KKlXblytgKnFeKg6ryMso/bEimMozmZ7aifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9QHD4/43V6+YjYUPkwJ7coFT8T2Y2RE0gFwxEIb0hs=;
 b=WCFEcdNqPwqEgIQPj/Sqwvs82WQJJkP3TmJq94F1DfAXxXhn67+9MMgwFe1vxRaggngHlt9Kceb5Grb1e2gLf7DE4DXMPY+oSkOrLj70amFhClaZ97+pJbnO4vBHFj8dk3QVgEDwDNuusUZAevQ9na8Wo1tEnquDFEZ/1SUR4h0=
Received: from BN9PR03CA0475.namprd03.prod.outlook.com (2603:10b6:408:139::30)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:10:10 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::d) by BN9PR03CA0475.outlook.office365.com
 (2603:10b6:408:139::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:10:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:10:09 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:10:01 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 38/40] drm/amd/display: Fix signedness mismatches in cm3
Date: Wed, 2 Sep 2026 12:59:00 +0800
Message-ID: <20260902050411.3473916-39-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 839eabad-f607-4b06-c9f7-08df08b07636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: i1izCW5Y4LKsVjm+rYf81Y9TmHlVTk6KsX5r6dBb+AdDp5kbjITTgAnnNRyDUHrZOkjn64/VkAVUN1j9p30Oefb/ptm62jpR3UI/c6D1f2GL4WGi78LQluj9jIw3OplkexpcDlP8t8YimR1XbWI+D+bAoY/Ro8sBrSkcVrZADo556Pc+xUN4CI6psd6BFrOv2gqfTUzQJ5zNOiW3hPz0hJVWrSTbrO2yoLfrc503PTqsslCVgew+jxWz8vDK8cQ9QMB25nP+v+O95n/0MIU7fQCtgK4c9B6+IiNhu6kEHQXN3uADo5xTuRO5z7CXap79SN1OhqHsjuiO0t1OJPNN2lYWdKgdnRf9fxRb2r6gUxa6qz2JX2FCi+gJi0ZPV9RD5ccJQwgxApwyJD1xhtw2878cL+wQ+v/DERGpOT+hV+AV70sOyxfy64okqm6s3KTXj6BlklyotFGY0DwlGO9e904QHksLRr6+pehjLlwq0smD4dayD7nKNlarC42FIU8uMGGkxtBR/dNvqxFwNUc/0rVQgjF4DyOPE15GgvNKB5tdd3LSRbupQimfhVFnK7YigPCGUQcq9FddrM3IBvbLebZHT2mQuMiOmDFRDneMe3vwGWymQQR6/08Yi/Ia6oDUKg2rPwiA0jLpiRmPsPNvSAcYM7c5nYd0UWXsO6WlKNzUyHp6KcpsPn6TgAM+9NFqG3tQMpc2TZkHVWBl/ynQgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wZGVO6k7dKADFLuZjA99PwPH1yoy+kjf+zTEdCzjvBgxmhgQU01mdPudtbx7g5qALKOdlgLO+KQraF5FHO0ao2tFFZRuPL2eV6hLlnwdPFt0xCvNKkAjiFMexceU+kxJ1b7X7DbGJDrd1sNQwHhUK0QXtO24B7gVpV3cgB0p9OqIz+8xO2ZQSa6TNocB+rCOvf59UYqttHC403VovhcgdaDMi0icsJ2xuVaMzEagdw7GsMBf4pnQBImOq3DdPFdh6Q1nUe0k0G1xkGuhvmrHCY35Up+JaOvmeM5l/V1I6UI6kn1xMOSl8UOqJFNTx5UlzLMtmNVCYBKiN122snszO29XZZXFJyTecF2aneiA5Xnjx62Q5RJh506YFgTxKiTVOBRrzgYmbZxRbwJBljS0XvH9X9xoR3rlLevSjCzXkRDQxStyrGbMQtHIUNrhOZGs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:10:10.0080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839eabad-f607-4b06-c9f7-08df08b07636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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

From: Alex Hung <alex.hung@amd.com>

[Why]
In cm3_helper_translate_curve_to_degamma_hw_format(), seg_distr[] and
the loop counter k are uint32_t, while -1, region_start/region_end and
i are signed. Comparing them relies on implicit integer conversions,
which some compilers diagnose and which obscures the intent of the
comparisons.

[How]
Add explicit casts so the signedness of each comparison is stated in
the code. No functional change.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 62ca235cd649..eb299f7f9c41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -356,20 +356,20 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 	region_end = 0;
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
-		seg_distr[i] = -1;
+		seg_distr[i] = (uint32_t)-1;
 
 	for (k = 0; k < MAX_REGIONS_NUMBER; k++) {
-		if (seg_distr[k] != -1)
+		if (seg_distr[k] != (uint32_t)-1)
 			hw_points += (1 << seg_distr[k]);
 	}
 
 	j = 0;
-	for (k = 0; k < (region_end - region_start); k++) {
+	for (k = 0; k < (uint32_t)(region_end - region_start); k++) {
 		increment = (NUMBER_SW_SEGMENTS << 4) / (1 << seg_distr[k]);
 		start_index = (region_start + k + MAX_LOW_POINT) *
 				NUMBER_SW_SEGMENTS;
 		for (i = (start_index << 4);
-		     i < (start_index << 4) + (NUMBER_SW_SEGMENTS << 4);
+		     i < (int32_t)(start_index << 4) + (NUMBER_SW_SEGMENTS << 4);
 		     i += increment) {
 			if (j == hw_points - 1)
 				break;
-- 
2.43.0

