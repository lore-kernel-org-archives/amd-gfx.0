Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF66AD39016
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BB110E687;
	Wed, 14 Jan 2026 20:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1nQeB/ic";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADDE10E67A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN/Wa+v60zxZt9uKulvzYoR+0rXwxugvz1zWuHUPsuqGhIhvMwn1U6hxFXnitpdEyAOKxEi8vfEbYmcV5CQPc4VhN8MtWJhPsU4rdj9oTq46YFFVnaobbOaIfKHy5Cj1Skez+eupTWnw+iVIEJrfG56AAaEBXwInOvDXe7xCN42D41PJBCybe0RD4jdBxjBN+p0+t9XpYIW46chhJ5The90Slb81UgRiPwS/Nc5Y8q3XjRJpKszEPEWQvQfRtcSMoyslvW9OoPWRFDK1UT1BeiK7BWN0IT06PdfanIknz9pVKkxWq+fCIPR0+Xph68WJ4bRfI8/NsaPHt2NqYgocGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcJjlJO6UOTUrjj3IWaY5lY7oLyRPYsbjqithuOBrpU=;
 b=A5VGJa8S8TWa7JOvBiPDLuKgVd1fimPBbsNJqSExteOtMA0djJNt4NfBiQw6AqAixVNNfZXea2Vj3aLS3kSQ1mK86/to/OrNnDkHgVzI/K8pmMz/z2Zhd6w1jJ22pHDMdso6S1Qf4a/Kpb5iBBXHf8kGBC4AJfPGOZaAFcBpW7jXzze8ljqRgOG0QvB4W27XjfpBPTyWkrj2ZiQYFE09JbFV9hu17fGWsg41QRC1ZkVZuStCbqUjqLygD4o7sCJ4YQxbHMWsZprA+U/7tNyBhH2S4gsBG//h9N3GFjulyjpYK/kg7iNtv1Q/jqaXUvDb5Vi8uohK6X+Oluwe1+0bVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcJjlJO6UOTUrjj3IWaY5lY7oLyRPYsbjqithuOBrpU=;
 b=1nQeB/ic2dKuzXV40e0eU5GguMCG4habHaCW/DI1gnb994yUhu2O1TppI+Bn1SERRn4TKHilC3hWwk8uxPMyXUA/rlX82Sam4GG4ebQnxbxmhbMBOXhNZt+WSgiS+ZK8z398bDOnROidMBXz5HgsQheoroUOeTQBVi4AoLqWuTM=
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 20:24:14 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::99) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 20:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:13 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:12 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chris Park
 <chris.park@amd.com>, Dillon Varone <dillon.varone@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 11/14] drm/amd/display: Remove unused code
Date: Wed, 14 Jan 2026 15:21:52 -0500
Message-ID: <20260114202421.3654137-12-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: b0faebff-7089-41c9-37fd-08de53aae260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UoV45So2gEY0sLqVY/e7IdbgPI7LMaRfSn4qBUVUwtU+AidgQwfNjeybt21/?=
 =?us-ascii?Q?LL0WDQB8SdG4YeExa4W4zdRA8YnKBxjvebGMstRHCrRtIqVisnjmC7AEy33m?=
 =?us-ascii?Q?T2qdaI6cUXk02eQZ/+K+Vqp79WmHuJUGpWZ4WyKVJWurGN9FDrJylCjVYHsf?=
 =?us-ascii?Q?P8M8C+PdG2KlMrAS1c6uP50VMb2nqh8n7lv8XFx63Ei7fO7Dgr0Gp92UMujQ?=
 =?us-ascii?Q?0UhSeLdVVDdL3onXqLWijfULtZHmb9q46M7dPsopvj6s1L+zDPbCDy6BikyN?=
 =?us-ascii?Q?fDAO1UPLkmckqoxzjOYBYQ0cOQYUznskpSQaNkBUdQmWyVZuReqv1yb+co5c?=
 =?us-ascii?Q?w14qNbwZyUikkWIV3sAMnNubsbvwIAJwCe4t2xDzhk5YEe/kasnKnWWMyhMG?=
 =?us-ascii?Q?s3bNi5XjoDd0v7VyZXNEIBCOKbFoZKzHyq1SdejXvEUdTdmAAa34Yn3l4LRG?=
 =?us-ascii?Q?IzvpI+8ZGUd0uWXlWYWV/sBKfQb4+V9IoUbRdoKPZAdNnUPdqG78AFIW7nGJ?=
 =?us-ascii?Q?AZ+aGAMl/DdVQassnGHJEhM1gg7xzmWSMjZj1RM5u8zi1IiW9gxMdknXxC4N?=
 =?us-ascii?Q?J9FOfgdtjIW/l1X+oEu/kT13yNvDeyz/uUjKmeuHTPV3aOwyuOJwSOYWnn5T?=
 =?us-ascii?Q?tW3Jeg71dZN0hDF22QNZvTsxDyiWoalxCFCPhlANz8bhVdNqSQudZL7+tHZa?=
 =?us-ascii?Q?errOSGqtf/fupzO3oJoE+vp9udPiRsCye6+fhdexLPsYY6gQfcBZLjCBThqS?=
 =?us-ascii?Q?B0ejuhj5j1lq6koI6tJN3JwtvYxG/AJmD1i1n3bfgtBNEx6mjzPjXxa9dayk?=
 =?us-ascii?Q?6hQ977choTs4X5z1iJKzdsoHaiTjPKGZ+8M6bII9yOX6FwF9brxg2UBysaDG?=
 =?us-ascii?Q?kOESGGIii4UIEji/hxAbOHZ5ua5w/8g1/dMJ0Svv2XiKGHu2PR2X9JhMuSkR?=
 =?us-ascii?Q?ruG20/7yfIaFbag3NCgMAM5HwJSxG7T3c52Dk9S9hjZqRceESz50BrB+fMHl?=
 =?us-ascii?Q?Du3DEJwK0ZfX4ltpx3/tuEX4OSpxOpZz3UwW0QrohvdQeQP4SdSKwggnzYsV?=
 =?us-ascii?Q?gdocQiEYrsrvXL34NcPBbp5HEwJHCLDSooTIeY+bYfdFPqVHJBJlhEcOoSyD?=
 =?us-ascii?Q?P//uqNPiopbo5FI0RKKaRUaTHzx/CvGgEve63+qTVxfEhcwF1qtigGTLm9AN?=
 =?us-ascii?Q?F6KCn0mvDChhmDh8jPsOkuelmr3jsoGL1lN8/tZms3OIKB4YeoTLkUfK2IjK?=
 =?us-ascii?Q?SxEwtZA9bI/ybPse2CIYygLLyD6vC0KuBv8oyoj4KXomhN+4S8V6jsWrWemQ?=
 =?us-ascii?Q?meEMrx2AY7oKcwIEtpBT7QQI9bjHDzCqw3Mf9hvfERLeN8ltOLq3JlLSW8c8?=
 =?us-ascii?Q?IYW5EWKJP9skB5PVQ1NSwcTd8+MpCIgrmYnl7CnFpkxMyBOo23zH0bPUhGRn?=
 =?us-ascii?Q?AEYqZn8Xr7vrO5ZiiXRLHPKt4MS4p3PhWBVc1jPwbrepkbkcN0iinpTaun9f?=
 =?us-ascii?Q?xYZgDnLGcbmC0UGcROfHvx/s9tQA4q41C+upAOMHO3Hx72+UrOKo+L28/KIQ?=
 =?us-ascii?Q?rBPz9hSKmTxqanzqOGCz0+Cn2LjdtziTtR6N6aeKVpm6ESxRaXiB1fKz3W7r?=
 =?us-ascii?Q?kQUfZfpLj6E3tZZ/FXYXgOQR3XTXXd/IOVy1xTyaT8jV1hmB6n2bn5cxWRr7?=
 =?us-ascii?Q?9V9P4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:14.0362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0faebff-7089-41c9-37fd-08de53aae260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
two sets of dccg_init:
one in dc/dccg, one in dc/hwss.
remove hwss's dccg_init for asics not use it.

Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c  | 2 --
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c   | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c   | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c   | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c   | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c | 1 -
 9 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c8ff8ae85a03..77ac7b22b8dc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3145,8 +3145,6 @@ void dcn20_fpga_init_hw(struct dc *dc)
 	REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
 	REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
 
-	hws->funcs.dccg_init(hws);
-
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
 	if (REG(REFCLK_CNTL))
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index d7ff55669bac..5cbae0cdda96 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -143,7 +143,6 @@ static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 8d7ceb7b32b8..33cc48cd0196 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -140,7 +140,6 @@ static const struct hwseq_private_funcs dcn301_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 5a6a459da224..e56b9a46aecf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -144,7 +144,6 @@ static const struct hwseq_private_funcs dcn31_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 79faab1125d4..9900c87b4567 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -149,7 +149,6 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index c19ef075c882..849dae18b738 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -154,7 +154,6 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_mcm_luts = dcn32_set_mcm_luts,
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.update_force_pstate = dcn32_update_force_pstate,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 81bd36f3381d..6ac8ad97cf13 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -164,7 +164,6 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_mcm_luts = dcn32_set_mcm_luts,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 09e60158f0b5..04c260015eec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -153,7 +153,6 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_mcm_luts = dcn32_set_mcm_luts,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 162096ce0bdf..5d0dfb36f3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -156,7 +156,6 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.verify_allow_pstate_change_high_sequence = dcn401_verify_allow_pstate_change_high_sequence,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-	.dccg_init = dcn20_dccg_init,
 	.set_mcm_luts = dcn401_set_mcm_luts,
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.program_mall_pipe_config_sequence = dcn401_program_mall_pipe_config_sequence,
-- 
2.52.0

