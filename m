Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E25C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 20:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05B610E04E;
	Mon,  3 Jun 2024 20:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q586frtQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B2510E04E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 20:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhx63xI5PaiDHAeouTfZa+TxyBoiR25U7ZgyjdSVAc8Aek9MDfZlT449+e8wcLBXYiypFyL/LRb5MAT+XmrbhUf6ZlouMiMyVFmAHye4empYfPt7jZoUZVBnberqVcoSm2JtbojlGZ9t0OM4qtkSzC9HC3HOBUoZJhR5xWZUbtlyU4w7nnRjJrFSvD1O0fIrZ/QERvjM9NW0plJEGyk0H/YP5Ex14GTO5mNeGCVV8sCDsAmN82gnCBpGX95d9RYkt5xn/V2UNXOf1YGTDmG9pKtIMW8FcpBWqbpMbojlQsWmH7e0hFoOqIeLSuYKM+KOFCl6fknJetWvE2EU0suGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of+nfp9cOl3TAjOaruAe+VkzG05JrWuUwSwmI8XQpTw=;
 b=Lvss4HvNJbHTYOwFSxyIo6gxF9Wn4i5IMDk4aBq9GE80Ir297H2vvtqrqwfRROHArxQvKi0BjFWdSvRzEg2qloQJUSs6T6sTCPoB4TtbwOHeu+s1DSklLsqEKOrJKtOTuwp9/iASvqem16cvsMM1b0Kd140OnfnNEsS65lw9cBJyCGsPMc3qIlH3OVoyq6CbrVm1X4K6kVLpJBkx4TInoXFANOBgjg1V0jwbEFmIdJv//WnslKqT7BucLxbWnmkotzkV+RHsuECmGkRaYe7SmBqi3Dl+ezjFaC21bVgIRKPYfv2e654JVUEL2crTUUWSXVJ4mKnEeFCrTW/9ftygTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of+nfp9cOl3TAjOaruAe+VkzG05JrWuUwSwmI8XQpTw=;
 b=Q586frtQGmORGsKVryViewqZp8CfruoQyZ0SL8TRelgkU527FjzKEQtQ+WDyQ4pI+AC7Hy6/NW/U5ErZPtaNSRYoGZhI+L20Jgq7ToBkq03fnk5/Nhy/Rr62QMlW7Kn9GQ79vINniIUfaCaLZD9Mzn23ej/sxQybg7rPrBzIuUs=
Received: from SN7PR04CA0216.namprd04.prod.outlook.com (2603:10b6:806:127::11)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 3 Jun
 2024 20:59:34 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::4e) by SN7PR04CA0216.outlook.office365.com
 (2603:10b6:806:127::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 20:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 20:59:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 15:59:33 -0500
Received: from MKMMARLEUNG02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 15:59:33 -0500
From: George Zhang <george.zhang@amd.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>, <arnd@arndb.de>
CC: <amd-gfx@lists.freedesktop.org>, George Zhang <george.zhang@amd.com>
Subject: [PATCH] Revert "drm/amd/display: dynamically allocate
 dml2_configuration_options structures"
Date: Mon, 3 Jun 2024 16:59:18 -0400
Message-ID: <20240603205918.28435-1-george.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: george.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: cea46363-a680-475c-bb08-08dc8410123f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KtPPD+JswXJ35G+hzuIuqNNZyToIA16BwhgolwkZ3FAUUN2igEmoC+T1vFFL?=
 =?us-ascii?Q?soOn6MySdh6qjsU5F2c/1RufOVYklP8WONzAUqa21XiyD1DlFxgBZu3JT5Kh?=
 =?us-ascii?Q?ch6h5StC0YMIwa9t/axhrhc9vfRZHjekt44nAtSmV3NGhlJLwsTW9F/V5AIA?=
 =?us-ascii?Q?MWQXHMdIshxLfZIpz0qBp0sCBxi3z/7Wip3jgHu+XuP2ML/Md+VZLnBnSjUF?=
 =?us-ascii?Q?eSm+r2DtddUo4M/zqLvvJiWWJb9vr0sUoHJ+vNQ7EWFTbZFJHQEkoSYguM3Q?=
 =?us-ascii?Q?dJs97SHQjw43gPc9QagyHQCn57NndBDjJj0jHf3DBi4MVK6GfU1rFZtuVQPP?=
 =?us-ascii?Q?YdhcI9nwyPLUcg0T5vRERep3Gav91nTKjXFVmWFqXIziYD3xdkdsVLAzUV1d?=
 =?us-ascii?Q?y45f8XAHPbrgf5PxTUn1QezqLaCi8dcsb3mabYRYHgOdxUuJLNOzrvr8/uOE?=
 =?us-ascii?Q?FoGvMQFLcZ7iZQP/j+KdPjuPwmDqTVm3r38KMRcNoGOhqbGAmjhx3jFKmJHG?=
 =?us-ascii?Q?Zya2QiRO5vXdLamkHcrwD20nfWFOTSUjiIELg4lin6uN/pQzW2h4loi5ilno?=
 =?us-ascii?Q?clqFdNLEwRKaSxTbcJViQ1qg7MbtASH86M/ysuulFJOqCb5KcfmpV7Nzj6Zv?=
 =?us-ascii?Q?vNFrlmq6typQvm+0ATp0UlOPQS5vP3e+kTfl/voxn/4cgNzv10aaNbXNjTKd?=
 =?us-ascii?Q?vboWohydyijGYjXYv9E592wgO1aOH3DIKigVctpGrHOahvMZapItXV8TXlri?=
 =?us-ascii?Q?UXi8QtT3Hm9ZjQSESGWOxe3uwRwaZsQMca1V24I5Sq9JBWA+x6ipiLysaYBr?=
 =?us-ascii?Q?8mJ6dDRa4GQ6xlZiHW5AZtHb0iGftl0nxrbTQq5hg9/rzzqiX8+twLLI2ltq?=
 =?us-ascii?Q?UM6cuJvvGsZgETOp8D786sSYQWcrxoOH3DgOSQ84Jq/kp4MDeDYqAL1zBdrV?=
 =?us-ascii?Q?dHMQKjpiTmiT+7dLA6l1F7EXBhViZyi+LqO6PWuEVBIdmoD1rAzGrAhCLeP2?=
 =?us-ascii?Q?PRbAjCBZXZz+1ED/+LDVukS8dtA38+tAoFFWMnp1u0Qdm5NMcMa/3aPQ4SU0?=
 =?us-ascii?Q?80L9OzL6YJHs2gUzZZdARXJVJJU6OPQXengesoNMnE5T3vpUV62wKns/TuU3?=
 =?us-ascii?Q?l4lENjEyij/fdSxTkvKZaDAy0XElKkjntF0MYj4YwTt6KbSyP8gCrLk4F7pU?=
 =?us-ascii?Q?1ip07s+mKieVKJ3Eu66Ru213herpq4UUHlt0tpbQ+IbhUnauO+XljmHu3iuk?=
 =?us-ascii?Q?3+G/rr261Pk9ubpQl0dSL+qaMAOuz+3UsuJza+W7R06OYuKFYfyppX4dY7aW?=
 =?us-ascii?Q?2YkyM6+9XlAXc34kF41JFV2nKAjJhk9mBcqLo6+RbA/VnxMO366LCdH6VxM6?=
 =?us-ascii?Q?TbKdhR1By8qCwn6EauwXTthKfUkm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 20:59:33.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea46363-a680-475c-bb08-08dc8410123f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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

This reverts commit 416b5c5eec9e708b31c68f00cb79130f2cfaf7ed.

This patch caused a regression on DCN 3.2 on the IGT test assr-links-suspend, with
the dmesg warning:

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
Workqueue: events_unbound async_run_entry_fn

Reverting this patch will re-introduce stack size warnings.

Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/dc/resource/dcn32/dcn32_resource.c   | 16 +++++-----------
 .../display/dc/resource/dcn321/dcn321_resource.c | 16 +++++-----------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0f11d7c8791c..022d320be1d5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2007,27 +2007,21 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
-
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
 
 	DC_FP_START();
 
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
 
-	dml2_opt->use_clock_dc_limits = false;
+	dml2_opt.use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt->use_clock_dc_limits = true;
+	dml2_opt.use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
-
-	kfree(dml2_opt);
 }
 
 static struct resource_funcs dcn32_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 07ca6f58447d..e4b360d89b3b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,27 +1581,21 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
-
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
 
 	DC_FP_START();
 
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
 
-	dml2_opt->use_clock_dc_limits = false;
+	dml2_opt.use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
 
-	dml2_opt->use_clock_dc_limits = true;
+	dml2_opt.use_clock_dc_limits = true;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
-		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
+		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
-
-	kfree(dml2_opt);
 }
 
 static struct resource_funcs dcn321_res_pool_funcs = {
-- 
2.34.1

