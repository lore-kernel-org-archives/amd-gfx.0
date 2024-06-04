Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E38AC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 20:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB10B10E5EC;
	Tue,  4 Jun 2024 20:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RolOqv7o";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B674C10E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 20:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUh3PUP34xp8rVxLOE7hWQP/0+PYfa5vlEXFdlEw6/oPEzUVxheQnimAyknnNr3BI9Fz9/043Q4HkLg/GrHxXGIw26Fc2gqQKSy/8JuOE7eXdVZGCkcaIVoQpG/cwTk9TgJFAAj5e0Qu5daH6a9Wbq9GOQhsHpMHvT+iDuU/w1YogrdE2YkM5A0Y55bj45DkpMVOdRZ439LACr0/Y7hLBxYy9szShaZhnqgc0SUVqrasceF6nh4STNTFM3Yz4BmH9cXYwpAFiWdoVuWnh7ZJnypnt9pQLDLSUtVAp5mq8A8E8UIp9ygXZpiZLK0JbFUngAiqZpLVtpQagsJn4IE0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW4P911oic+1o1x1+faG5jJwwCBbJ5WqdFecgBokkqs=;
 b=Nd43uJxCLmZlyh1h1I/dGKa+2RyJ9+u6VGNNLBs/rBoqUxqy792PW/E+0gOV6rHyzAvkPqemScGeN6auhz1psE25YgXY3erTt5MlPSLh0M3J4VlJ0Z+qI7GqxnvEHe1UUd3uegf8URhAIVaGLA4toBTmItoyijO6mOggqvr9dVKY2hg+og5h4DL6EsHUMgfUxU+qpCUSLGliR14U12H4g5p57GR0aYXqhBoFjg5WXzH9JfF3JqXl/SCHgMmh2Qgu8KE5KrV3sTt0hVVtJDoLExvEdwHTmr0tbX4U/n+LvlxCuPeBiNn9TEVqUdWOx7rUX0bJHxzOvEz9HQCRdR7itA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW4P911oic+1o1x1+faG5jJwwCBbJ5WqdFecgBokkqs=;
 b=RolOqv7onsCFxynjAj7cgtoNaa1Ju69xvYN8V6iP58reUAwGtasIJ0vJ2Ez5AtspMnsimJrwjotNnnqHkXNgjw4ghXwukz0ZfIzGitDR6nFxZ0e9YfL6nBSVVdCE4WXR44LgxAAAeX+eE1wFSnaE+JJESs/Srga10IsPT8jknlg=
Received: from BN9PR03CA0624.namprd03.prod.outlook.com (2603:10b6:408:106::29)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 20:26:23 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::1b) by BN9PR03CA0624.outlook.office365.com
 (2603:10b6:408:106::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 20:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 20:26:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 15:26:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, George Zhang
 <George.zhang@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, George Zhang
 <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>
Subject: [PATCH V2 1/2] drm/amd/display: use pre-allocated temp structure for
 bounding box
Date: Tue, 4 Jun 2024 16:26:05 -0400
Message-ID: <20240604202606.697979-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6865d3-52d6-4742-f044-08dc84d499fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZNg6wRISsj5cocY08NlXnNIjv/aIBMWuazSbxt8ITH5R2rsBMgblMciD3dWN?=
 =?us-ascii?Q?OQkP1xy/g2fSQ+aN8xYzq8ytTVnulkPhHbSIhw6xMUx1icqJOk6HytrDyfSh?=
 =?us-ascii?Q?nPt9OTBwobfILXhm3Yu6YIR6PYKf5kqdoaDB4faJi5qI0ZA/qNvRBIC8k2o4?=
 =?us-ascii?Q?2zLsDl+b2Kd6tTxw1/Gxb/l6N49OMT86D4kCKPHXumJ8TAB1bhSDafBZH1Dm?=
 =?us-ascii?Q?OPPeRsIUVGe/bzyDHtw/OJxt7q3RUmRRR11ZwwX+z1do8NAlosLocBTnizn6?=
 =?us-ascii?Q?TDTl/HVFoBRxX1Sxvtcg4mywKvr8eyKsKOsEZbeKNeBoEUUhPpIScnHdHMC7?=
 =?us-ascii?Q?jlVgXzHHyvGRSp4blbakbUhfqlz9WZ8YbnRDFrLhYZBFqYhuH9btqk6vF1Kx?=
 =?us-ascii?Q?E+Uul2nIDggCk+ctgQQN4IuBg9Ym1BqpKWfYpOdrE9n3xu2W4V59BtjXy9at?=
 =?us-ascii?Q?SKUOdV+kxxtJ2QHDJWTBzZn7VSin7vONjSaCMtz89TNusxNPHfUJQiA54fl0?=
 =?us-ascii?Q?fG5N2Fmul6TJ2jpGmpo3V209MmnH6FuyRrpul+HNMoYF1sIApyr9VCz4v7Ux?=
 =?us-ascii?Q?3Wh26umO+eCrSTTHbcHNQpNlPHGAPUFa1GqpwGt/NtlY8kdte13iSHSXE38u?=
 =?us-ascii?Q?DHB5+mqwGxgC4L1AQN+vpa46qshCrcGJE0Maxns1OLuP4/2tlizSSNwnsQXr?=
 =?us-ascii?Q?afSq9FjopLHCY2eBtiz9J0YqHzui5Qx+N1V3Av5Pr7t9Y2UqecPZnTtO0p6w?=
 =?us-ascii?Q?iuP/zQAXojwUXd9XbhW0ZVOJanmgKa66ic3mkSpAcIaK20PGL9ZE8akJo8CC?=
 =?us-ascii?Q?LR9V2xTggOafm4dFfBMy03+9JxhkDQazLAeNtrKZNcIQSkmWOD1IP29xtgQR?=
 =?us-ascii?Q?JjMOJfQ/t3J0SDV+59aq2GnGtuxR60qWVIHlPDmX51ZFEqGPvSztaD6J/5K8?=
 =?us-ascii?Q?PZKiFq8gJI6HULE6ewOfF/LzZ+zD5NnZ/rVx/Rq//KOHJDJQpEWVPrU4w0jZ?=
 =?us-ascii?Q?ptPtTYjLmbSS5XADU34+IZ5IXV8Xe9P70z+7r3zgH5FYj0we3T0uTt9v63Bu?=
 =?us-ascii?Q?Y2SuinTXC8HJr6K8b7IgI7Ohcmb7t5XJ2ppCDxq1Uz9ozHn6dpNxsz0lapuV?=
 =?us-ascii?Q?XHyMwWG7bdYhhTWCmbJT136XDDZaZrfcmBV0i97AItZAIMQPL0QAYqpvaUKH?=
 =?us-ascii?Q?2C55UxWxOM4R7Kr/ulNefkvG3C0hS1jaz29m04nU15royFRAk1qmqhbTApww?=
 =?us-ascii?Q?lqVqW6dlrAwcAowRWvssDkqmJkm3Odx62P0olyNBW3Xxvg9UmfiUf0m27ypt?=
 =?us-ascii?Q?liMr2BwvR/oSbSl78YecHdkjO4w8SGZ5BDvXR+zKTpqW4KqSlE7ypArHtm0z?=
 =?us-ascii?Q?FjPCSevzSUKhw3vqQVM0KbOrw1fuPTSUUI0/JHeuHFK7xJ550w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 20:26:23.0344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6865d3-52d6-4742-f044-08dc84d499fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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

This mirrors what the driver does for older DCN generations.

Should fix:

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
Workqueue: events_unbound async_run_entry_fn

v2: drop extra memcpy

Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configuration_options structures")
Tested-by: George Zhang <George.zhang@amd.com> (v1)
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 ++------
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 ++------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0ed01ac460d..d843933ad731 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1444,6 +1444,7 @@ struct dc {
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
+	struct dml2_configuration_options dml2_tmp;
 	enum dc_acpi_cm_power_state power_state;
 
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0f11d7c8791c..e33e2597847e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
 	DC_FP_START();
 
@@ -2026,8 +2024,6 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
-
-	kfree(dml2_opt);
 }
 
 static struct resource_funcs dcn32_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 07ca6f58447d..9a3cc0514a36 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
 	DC_FP_START();
 
@@ -1600,8 +1598,6 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
-
-	kfree(dml2_opt);
 }
 
 static struct resource_funcs dcn321_res_pool_funcs = {
-- 
2.45.1

