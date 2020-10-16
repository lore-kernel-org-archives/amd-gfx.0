Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6C4C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876B5206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nu7V8l1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876B5206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 226496E9B8;
	Fri, 16 Oct 2020 03:27:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717F96E9B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFF249DYJ1xddU2JaiupWSWsoKv7erEVEtjkBRKs8W6n1p6JkSBcO69fw/75Bqi3oxdYsRQYtrffHVbQI5A960Y4Ucl58VLWoCKaSMs0mlEu3PG6EFHO8HEq2NnUiLhhTz3Gr6VOtlnOS/uD6ttxSUKJvb29CeDucV8WGHvfJMPrdMu4CXrRQwuzLaPboXChWnzEWC1Wfam8077Gq4sjLNojXTydEth/OL2uEOuKAOOKT8iwmhfEFX7hoUKzkHtWGMsxkCYpFPJ0gioeVJNCvUBd9kTePe+YuH17ELteSDnW480dnqDJ9sVKhT7aszoYtHLPN25R6FXMICzO3MiKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj1aqBz9hXc6VoUS5r3FD1PGIAnRuFlw0UqotUgGKGo=;
 b=iU/O4ke88y2fwgwImFko4BuPC0xYpB7dOTz11qAjNJoEpMiPuKbC+HNrR+pyWgR0+LYxWUVEAPOWfwuWxbchWTaGkdPC6tIzACryvUcQ3TKZgb+mB1CcCaY5FzraT3+PLRUbI7NFv6qZd/5OJ2i0C3pEcCKQW02x7UDd9q24OdRl5lR0odz4m+RKYrxWuG7CW9rAoIJShYT6FpAodsdx3z/xpgx2OFzBL0J0IcWFsKpRNOfvnxIwCMjNOmAwoW9orR6nXozfaM9bndSrdQXv6U20Zb8YG+4xB/CcY5zpvxFXY4zNa2wy/qSqwyjD/Rm1T3KqR6tke2bBW5fhnQzcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj1aqBz9hXc6VoUS5r3FD1PGIAnRuFlw0UqotUgGKGo=;
 b=Nu7V8l1XefDnDeLqxKQG36hOqSvi6oMvjNzOWG5qfPauny93g4LLp+JhIiYY3G8J3pB0ur5xMBkb0VVOxA/aAfGHCHpOaOxJvL1z+UxGg0+M6JTeavJAXZBl79wNoBVLcd7DQemTnd3QrneY8ttsmTUrWS+ODwiJApnwcwPMpfw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amd/pm: correct mclk table setup
Date: Fri, 16 Oct 2020 11:26:18 +0800
Message-Id: <20201016032652.507-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29f73f8c-8c7d-463b-e289-08d87183711e
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB46807777BFCFF0E06709CD6AE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRBnVZDUlKpg1NqA3OGJBOnF3B1w/ORbrNBKWzv+uDjyXCj2BcDQfMCH71PLA3ZPkHJWq0RcOcutbB1aKKfkyYwolTQJ2iAmvZmkgsv6KKlUjL4DeHH8wzrC4TZbdsCUCuOwLxCS3sW1E+fl4k4ehNm3kiibISr35tZPjVOAvAFZUovyXKwaQG7L4Vm7xkbV3KB4IxiNZ+fxlEZAiNj3HVyrWrw/wvv96T+x5txGqwwWnHvBk3vqPf/QSlwq4zXsPIR8uz3bXLpSv99Ss2A/Ftr2CxPDtdIToq5FjY9A6atRPsRwG8APh7L16JECMG6YjvBGt1s63LI7fT5QznupcfZoHd8JGp+hYkLrIty5jD4CH6uW6HYT4/nyeDKnR7jV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZQx5pO7EGrQ0l07NPY/BC4PMAVFlOwCFYJ/UdJ93AZJbJtBItOFiMcZWizuTjGtDKgQjbUYAOX87Tf7dxXwJFTtOjGUN6GxDHMYG8KDlBnFKiDjU39R3oZT08LJYSbqDPDJx7rp99Fz3vLE61jEw5lVWhD5hHZDwjQEFgE0IeVOM6xBqtfB2rj3YBMVlGR6qHhj/lX/84O0kxV8Hkpi1lO7PoRQkanQyXVbp/mKjee8FCUEsuhRk3BFz1NC+v8jDmoSSmXLWiToahJOYh5lgkcpmmBwV8WL+kqFX9EcYAv46wxRppQPPMqRfVz6wNK1E4j4kk68SZnvHnkUNpVMpgaICSEjPRBMibCCMQ8XTVSW+aoOVUOTXwGoH3aQ2o1t8mhe5LVYfRsYFIkv+krFW16yYc+TetmreYc7o3pE+GZjBbi6bJ30pdZclt/AM7yt6jn/pI0HvHYsCS9LHXwhUcxC/+NIlm55LnjNOtwHorfuILHrQ3k1IfPvxwJAJ0TFMAg35O2uTysSejH0CCDsHTMEF4pqIw1QHodYxOUCHZuC+5Evdne/mIPIKVJDE7fkFxtuxdYp+XVLkrP3AVuzXvCmQ3yty/MOoncIUtIcLxFs7ODC1+VrbUkpEKotJbSQuFHC+P+RRb4QrnVS2Ntx/Ng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f73f8c-8c7d-463b-e289-08d87183711e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:42.6648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT6IMCz8+UkskSUZ7Y3/WgTYEI9BvD8dpUYPeKIOlZPCBwL+ZZucQs+nVeEMjOEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the settings for "StutterEnable" and "EnabledForActivity".

Change-Id: Iad8c825d524497ece4e6234575db01ce1af1abb4
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index b2f2fb9da4e9..260c95cae3ec 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1155,7 +1155,9 @@ static int polaris10_populate_single_memory_level(struct pp_hwmgr *hwmgr,
 	if (mclk_stutter_mode_threshold &&
 		(clock <= mclk_stutter_mode_threshold) &&
 		(PHM_READ_FIELD(hwmgr->device, DPG_PIPE_STUTTER_CONTROL,
-				STUTTER_ENABLE) & 0x1))
+				STUTTER_ENABLE) & 0x1) &&
+		(data->display_timing.num_existing_displays <= 2) &&
+		data->display_timing.num_existing_displays)
 		mem_level->StutterEnable = true;
 
 	if (!result) {
@@ -1189,27 +1191,21 @@ static int polaris10_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
 		result = polaris10_populate_single_memory_level(hwmgr,
 				dpm_table->mclk_table.dpm_levels[i].value,
 				&levels[i]);
-		if (i == dpm_table->mclk_table.count - 1) {
+		if (i == dpm_table->mclk_table.count - 1)
 			levels[i].DisplayWatermark = PPSMC_DISPLAY_WATERMARK_HIGH;
-			levels[i].EnabledForActivity = 1;
-		}
 		if (result)
 			return result;
 	}
 
-	/* In order to prevent MC activity from stutter mode to push DPM up,
-	 * the UVD change complements this by putting the MCLK in
-	 * a higher state by default such that we are not affected by
-	 * up threshold or and MCLK DPM latency.
-	 */
-	levels[0].ActivityLevel = 0x1f;
-	CONVERT_FROM_HOST_TO_SMC_US(levels[0].ActivityLevel);
-
 	smu_data->smc_state_table.MemoryDpmLevelCount =
 			(uint8_t)dpm_table->mclk_table.count;
 	hw_data->dpm_level_enable_mask.mclk_dpm_enable_mask =
 			phm_get_dpm_level_enable_mask_value(&dpm_table->mclk_table);
 
+	for (i = 0; i < smu_data->smc_state_table.MemoryDpmLevelCount; i++)
+		smu_data->smc_state_table.MemoryLevel[i].EnabledForActivity =
+			(hw_data->dpm_level_enable_mask.mclk_dpm_enable_mask & (1 << i)) >> i;
+
 	/* level count will send to smc once at init smc table and never change */
 	result = smu7_copy_bytes_to_smc(hwmgr, array, (uint8_t *)levels,
 			(uint32_t)array_size, SMC_RAM_END);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
