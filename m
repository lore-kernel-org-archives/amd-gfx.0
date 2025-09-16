Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE170CAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA3810E563;
	Tue, 16 Sep 2025 19:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmXv5QKX";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E1D10E563
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIpM75nIzxzBrtIRQ3FYPXCkx4YQ9Z4dWGQxLCbebCWJI5wpOPusg83HytdgVx+70ZXu+tGnsBz0fjbGpFrxzHveB0h2TkWjEfxM5PkOScRPIf/fu2Dj2px9i9/hWCaJaT3rTwua1LlplOUE4Z7LRlipvH6a1qWniIIkTQMkzQ+OEXyYoF19pCzzZOgTFq8RchRT6PXoXKHpG+4O3ZC1wiB9Ef50CNDJRCvbwXJsMN4/UO+rI4MsClkun930T2SlplbTdb6pI3/Bg7TV1yYOoQzyXmm6UmQBhSULAx74dSDrHSyS1x0KjEa8gzPVFiZyI/iw+xhkvQOxyqoOb02ZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h0LNsBOnJBseqFrwjxw2xiSxtdW3O33hQejLdHmiSQ=;
 b=cz8C5pSxdJlSIRhqlFU16XEwLSwjFgESKWAPv+1ULBHPYgo/yMZdJ7A/yqDaaGbKMaVkvcx/9dgth40aEBTe6iHfluiu2HBdbW+bsNUG/PZMnDUGBcNwla/XSsEUymrGFx08t1HOTv65GlBH1/X1o/je29ZGcxVGyQivCX3li/QuW0A6mAye6fk+tGeVOblpK9ElxQSc6w2pC9GG6pnHOSBAdcPiTOlmBIZ5E65NOTvxLHqCFyn/X/AFSVwCaTe1MP3m0GMhH/mB1DsXpGG2geQ1yrvQaD/t1nIaqqYOERnixHP0bIVsbsUMLJurSGHyc5dlCZhGXBE0h7bO/TbnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h0LNsBOnJBseqFrwjxw2xiSxtdW3O33hQejLdHmiSQ=;
 b=XmXv5QKXYNwxT+wfgExTUbx505yXkQztd5DTVuKzHsCYYFdjxH9Nl/oaYvxQUdTWQk1udf8slakuPNkYKSH7FE25WBlGTv7IdJ29iO4ycRehSf8gGulqf+4oh23KsdxrZknajSqpYJXgJfMBJLuWcRZyuiJ1pmoATtnAEZY1I6M=
Received: from DSZP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::15) by
 SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:18 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::6d) by DSZP220CA0001.outlook.office365.com
 (2603:10b6:5:280::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 14:12:13 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:13 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 11/20] drm/amd/display: Isolate dcn401 SMU functions
Date: Tue, 16 Sep 2025 15:09:31 -0400
Message-ID: <20250916191142.3504643-12-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: de065a8c-88d9-42d4-5148-08ddf554f494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NzOI6DZKWzjUb5KfsCGpQCkbs52T4hL5Nxw8ynZIUGL3AgqGzMpSF9vpJwXa?=
 =?us-ascii?Q?rWvdod+Pfo4kt/pk24SxZQXzguobgRI8UNqjACK5+pbEI3pJx1KoVxVMSONK?=
 =?us-ascii?Q?GV7CEEj/N4/hmKdX37yPwn7P9UFe10FZjjUir5nKYMk9G6eNXMrOun61Z2TK?=
 =?us-ascii?Q?9F8Y5lJH7ApmWEbfPZ6r9epHlZAPkZLsuglx3/51ntARJT3pGvSuEtDCd0Hs?=
 =?us-ascii?Q?a/JERMozachYJE/lGZXY0pL/YrkGvFopbJaJmcjRKZ3Y46odr8s2OIa/xRNj?=
 =?us-ascii?Q?DcsUqJAd4VpYq0jtCzaP68btGlQ24qytvFbKiWqz1h4pjX4TcNDIY0kYol3I?=
 =?us-ascii?Q?4Izax523QRdOdPZyg1Vy8elhRpIXlSnF6sfn289W7XoOq2pXbWB5IJct5wC0?=
 =?us-ascii?Q?CU/bJgYrcl6Cm8Ur1v9o9FDJpHY3Wyn6bmCptVJPEQuZUdKykJ3TgwEo9nA0?=
 =?us-ascii?Q?jXfEulzzqdNx1kpF7Ndlo17xtgqCwtpb7rShSsZZ1IDpytKnUZWF7dcVA3va?=
 =?us-ascii?Q?iWwqNyVRZ8H/STa7dIBck0gHQmpw0bDP2lY248254P7hxE3q2P+BWfcPpiYN?=
 =?us-ascii?Q?HmFwYcD18mBFzbrYMAYxG4m4ENiWklmjL9yTrzqrHQxfeYfVNYELvKDKO2tQ?=
 =?us-ascii?Q?NBNBQmCAoVp3ZhGeBkm6YQaIHaP7Oq0zzw+fikVgLfkZPND8PISYFkIRl3By?=
 =?us-ascii?Q?U2ffXZmdK/iq+umdDgXCnAcffbcEw7KyCIRNTj/cIU3lXXmrSLum3IPUpo0i?=
 =?us-ascii?Q?sk0kYDllGVWG2ZuJD9okL3TKmdZYy2zl0Tc4TgJtxPtgtk/kJoiDInBbgUje?=
 =?us-ascii?Q?9F3XE1cAB9vsq7dMpaeOT9BZhKRPHHRl3WSVzc1ln3aLk4DOVX07IRMslmsL?=
 =?us-ascii?Q?q783TGKZd4AvBNaK5hK5dEIheWs3sqC+xNzOSIBxfO5KPlfTld5Na7KOr16j?=
 =?us-ascii?Q?JJXJK4/reGqlTdR/INRu+HCO8h8MSIPmgCsLGClQVx+jpIaPpXO6hQSt9gsa?=
 =?us-ascii?Q?O/3YY+14Vzqp+iM8kJrGtUxEG+wvUkXU/MZb3mX6r6U2vDQpuDjLi+TMQVIZ?=
 =?us-ascii?Q?2ATzJdSGy9ESzTc47kaXSg21JvTm8gF+yibK2qvgZUrsHZa6jTYROPTpafTn?=
 =?us-ascii?Q?AdPeGo7hjuKfYrAz6sw2tMyjlYzclKkaQ/OozdLT3+b+gSxu2xE7A1iDD77O?=
 =?us-ascii?Q?5PNl0dVOsL+0hkK/Q1yXB74pzxxHxihtx0s1dmkYyRPeRV29T+Pr5c33oc8k?=
 =?us-ascii?Q?x5E9jhNjkZ4byNmqdw5ayXL1Qskv6yS+jYxYemCvoIPMbvRzUjmPIXoIt9Sf?=
 =?us-ascii?Q?b+yT5Q3StFHO6+5wNId+y3XzLvoF6Q9upN1/tyvAdjDR2CjzATr2L50XUBpW?=
 =?us-ascii?Q?62oMIz8Fp4lEGPxhyqY58CD6xP31bQ6yAk19laCNGfjx6KSoayh5dYK//VUk?=
 =?us-ascii?Q?+ijsI5R+VzTeXTEAafOGsOPEoAfzHaylvtJgvbcrietpXCVtbzCx2wpr7sZy?=
 =?us-ascii?Q?ugMzbexH1MtVkGszlQZqtMtxSdEGboICWZ+D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:18.5088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de065a8c-88d9-42d4-5148-08ddf554f494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
SMU interfaces are not backwards and forwards compatible, so they should
be isolated per version.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  26 ++--
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   | 118 ++++++++++++++++++
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |  10 +-
 3 files changed, 140 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 47461f249e83..306016c1f109 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -162,7 +162,7 @@ static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e c
 	unsigned int i;
 	char *entry_i = (char *)entry_0;
 
-	uint32_t ret = dcn30_smu_get_dpm_freq_by_index(clk_mgr, clk, 0xFF);
+	uint32_t ret = dcn401_smu_get_dpm_freq_by_index(clk_mgr, clk, 0xFF);
 
 	if (ret & (1 << 31))
 		/* fine-grained, only min and max */
@@ -174,7 +174,7 @@ static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e c
 
 	/* if the initial message failed, num_levels will be 0 */
 	for (i = 0; i < *num_levels && i < ARRAY_SIZE(clk_mgr->base.bw_params->clk_table.entries); i++) {
-		*((unsigned int *)entry_i) = (dcn30_smu_get_dpm_freq_by_index(clk_mgr, clk, i) & 0xFFFF);
+		*((unsigned int *)entry_i) = (dcn401_smu_get_dpm_freq_by_index(clk_mgr, clk, i) & 0xFFFF);
 		entry_i += sizeof(clk_mgr->base.bw_params->clk_table.entries[0]);
 	}
 }
@@ -231,20 +231,20 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	clk_mgr->smu_present = false;
 	clk_mgr->dpm_present = false;
 
-	if (!clk_mgr_base->force_smu_not_present && dcn30_smu_get_smu_version(clk_mgr, &clk_mgr->smu_ver))
+	if (!clk_mgr_base->force_smu_not_present && dcn401_smu_get_smu_version(clk_mgr, &clk_mgr->smu_ver))
 		clk_mgr->smu_present = true;
 
 	if (!clk_mgr->smu_present)
 		return;
 
-	dcn30_smu_check_driver_if_version(clk_mgr);
-	dcn30_smu_check_msg_header_version(clk_mgr);
+	dcn401_smu_check_driver_if_version(clk_mgr);
+	dcn401_smu_check_msg_header_version(clk_mgr);
 
 	/* DCFCLK */
 	dcn401_init_single_clock(clk_mgr, PPCLK_DCFCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
 			&num_entries_per_clk->num_dcfclk_levels);
-	clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DCFCLK);
+	clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz = dcn401_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DCFCLK);
 	if (num_entries_per_clk->num_dcfclk_levels && clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz ==
 			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_dcfclk_levels - 1].dcfclk_mhz)
 		clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz = 0;
@@ -253,7 +253,7 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn401_init_single_clock(clk_mgr, PPCLK_SOCCLK,
 					&clk_mgr_base->bw_params->clk_table.entries[0].socclk_mhz,
 					&num_entries_per_clk->num_socclk_levels);
-	clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_SOCCLK);
+	clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz = dcn401_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_SOCCLK);
 	if (num_entries_per_clk->num_socclk_levels && clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz ==
 			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_socclk_levels - 1].socclk_mhz)
 		clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz = 0;
@@ -263,7 +263,7 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 		dcn401_init_single_clock(clk_mgr, PPCLK_DTBCLK,
 				&clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz,
 				&num_entries_per_clk->num_dtbclk_levels);
-		clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DTBCLK);
+		clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz = dcn401_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DTBCLK);
 		if (num_entries_per_clk->num_dtbclk_levels && clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz ==
 				clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_dtbclk_levels - 1].dtbclk_mhz)
 			clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz = 0;
@@ -273,7 +273,7 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn401_init_single_clock(clk_mgr, PPCLK_DISPCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
 			&num_entries_per_clk->num_dispclk_levels);
-	clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DISPCLK);
+	clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = dcn401_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DISPCLK);
 	if (num_entries_per_clk->num_dispclk_levels && clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz ==
 			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_dispclk_levels - 1].dispclk_mhz)
 		clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = 0;
@@ -1318,8 +1318,8 @@ static void dcn401_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 			table->Watermarks.WatermarkRow[i].WmSetting = i;
 			table->Watermarks.WatermarkRow[i].Flags = clk_mgr->base.bw_params->wm_table.nv_entries[i].pmfw_breakdown.wm_type;
 		}
-	dcn30_smu_set_dram_addr_high(clk_mgr, clk_mgr->wm_range_table_addr >> 32);
-	dcn30_smu_set_dram_addr_low(clk_mgr, clk_mgr->wm_range_table_addr & 0xFFFFFFFF);
+	dcn401_smu_set_dram_addr_high(clk_mgr, clk_mgr->wm_range_table_addr >> 32);
+	dcn401_smu_set_dram_addr_low(clk_mgr, clk_mgr->wm_range_table_addr & 0xFFFFFFFF);
 	dcn401_smu_transfer_wm_table_dram_2_smu(clk_mgr);
 }
 
@@ -1390,7 +1390,7 @@ static void dcn401_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 				clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_memclk_levels - 1].memclk_mhz;
 	}
 
-	clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
+	clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz = dcn401_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
 	if (num_entries_per_clk->num_memclk_levels && clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz ==
 			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_memclk_levels - 1].memclk_mhz)
 		clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz = 0;
@@ -1399,7 +1399,7 @@ static void dcn401_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	dcn401_init_single_clock(clk_mgr, PPCLK_FCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].fclk_mhz,
 			&num_entries_per_clk->num_fclk_levels);
-	clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_FCLK);
+	clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz = dcn401_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_FCLK);
 	if (num_entries_per_clk->num_fclk_levels && clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz ==
 			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_fclk_levels - 1].fclk_mhz)
 		clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index 21c35528f61f..347a0d66d653 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -139,6 +139,59 @@ static bool dcn401_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mg
 	return false;
 }
 
+bool dcn401_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, unsigned int *version)
+{
+	smu_print("SMU Get SMU version\n");
+
+	if (dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_GetSmuVersion, 0, version)) {
+
+		smu_print("SMU version: %d\n", *version);
+
+		return true;
+	}
+
+	return false;
+}
+
+/* Message output should match SMU11_DRIVER_IF_VERSION in smu11_driver_if.h */
+bool dcn401_smu_check_driver_if_version(struct clk_mgr_internal *clk_mgr)
+{
+	uint32_t response = 0;
+
+	smu_print("SMU Check driver if version\n");
+
+	if (dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_GetDriverIfVersion, 0, &response)) {
+
+		smu_print("SMU driver if version: %d\n", response);
+
+		if (response == SMU14_DRIVER_IF_VERSION)
+			return true;
+	}
+
+	return false;
+}
+
+/* Message output should match DALSMC_VERSION in dalsmc.h */
+bool dcn401_smu_check_msg_header_version(struct clk_mgr_internal *clk_mgr)
+{
+	uint32_t response = 0;
+
+	smu_print("SMU Check msg header version\n");
+
+	if (dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_GetMsgHeaderVersion, 0, &response)) {
+
+		smu_print("SMU msg header version: %d\n", response);
+
+		if (response == DALSMC_VERSION)
+			return true;
+	}
+
+	return false;
+}
+
 void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support)
 {
 	smu_print("FCLK P-state support value is : %d\n", support);
@@ -163,6 +216,22 @@ void dcn401_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsi
 	smu_print("Numways for SubVP : %d\n", num_ways);
 }
 
+void dcn401_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high)
+{
+	smu_print("SMU Set DRAM addr high: %d\n", addr_high);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_SetDalDramAddrHigh, addr_high, NULL);
+}
+
+void dcn401_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr_low)
+{
+	smu_print("SMU Set DRAM addr low: %d\n", addr_low);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_SetDalDramAddrLow, addr_low, NULL);
+}
+
 void dcn401_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 {
 	smu_print("SMU Transfer WM table DRAM 2 SMU\n");
@@ -348,3 +417,52 @@ unsigned int dcn401_smu_get_num_of_umc_channels(struct clk_mgr_internal *clk_mgr
 
 	return response;
 }
+
+/*
+ * Frequency in MHz returned in lower 16 bits for valid DPM level
+ *
+ * Call with dpm_level = 0xFF to query features, return value will be:
+ *     Bits 7:0 - number of DPM levels
+ *     Bit   28 - 1 = auto DPM on
+ *     Bit   29 - 1 = sweep DPM on
+ *     Bit   30 - 1 = forced DPM on
+ *     Bit   31 - 0 = discrete, 1 = fine-grained
+ *
+ * With fine-grained DPM, only min and max frequencies will be reported
+ *
+ * Returns 0 on failure
+ */
+unsigned int dcn401_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint8_t dpm_level)
+{
+	uint32_t response = 0;
+
+	/* bits 23:16 for clock type, lower 8 bits for DPM level */
+	uint32_t param = (clk << 16) | dpm_level;
+
+	smu_print("SMU Get dpm freq by index: clk = %d, dpm_level = %d\n", clk, dpm_level);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_GetDpmFreqByIndex, param, &response);
+
+	smu_print("SMU dpm freq: %d MHz\n", response);
+
+	return response;
+}
+
+/* Returns the max DPM frequency in DC mode in MHz, 0 on failure */
+unsigned int dcn401_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk)
+{
+	uint32_t response = 0;
+
+	/* bits 23:16 for clock type */
+	uint32_t param = clk << 16;
+
+	smu_print("SMU Get DC mode max DPM freq: clk = %d\n", clk);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_GetDcModeMaxDpmFreq, param, &response);
+
+	smu_print("SMU DC mode max DMP freq: %d MHz\n", response);
+
+	return response;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
index e02eb1294b37..4f5ac603e822 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
@@ -7,11 +7,17 @@
 
 #include "os_types.h"
 #include "core_types.h"
-#include "dcn32/dcn32_clk_mgr_smu_msg.h"
 
+struct clk_mgr_internal;
+
+bool dcn401_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, unsigned int *version);
+bool dcn401_smu_check_driver_if_version(struct clk_mgr_internal *clk_mgr);
+bool dcn401_smu_check_msg_header_version(struct clk_mgr_internal *clk_mgr);
 void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support);
 void dcn401_smu_send_uclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support);
 void dcn401_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
+void dcn401_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high);
+void dcn401_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr_low);
 void dcn401_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 void dcn401_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
 unsigned int dcn401_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
@@ -29,5 +35,7 @@ bool dcn401_smu_set_subvp_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
 void dcn401_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz);
 void dcn401_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays);
 unsigned int dcn401_smu_get_num_of_umc_channels(struct clk_mgr_internal *clk_mgr);
+unsigned int dcn401_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk);
+unsigned int dcn401_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint8_t dpm_level);
 
 #endif /* __DCN401_CLK_MGR_SMU_MSG_H_ */
-- 
2.43.0

