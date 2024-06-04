Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BF7C27C52
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 17:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986D310E1F3;
	Tue,  4 Jun 2024 17:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="344CbiUr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E1F10E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 17:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lACBRlg7jDgp7Xa3bd3yZB9r73HGc3yLAv+fOWKudhsFE7uGixCitovwiUnIuncagIJQ9ODtPp3Mt6hkyovmma76F+QNHrPppitkwFcBOwy3+9QQgnywOSVz38rV34dg1UhghLkxCJGaBwZtUBjJUlumMKjcrStyG+Q4UYgh7kjcvpAZBmN3wMhhk++gBnZcyuCVQpNKFgfzVxJdS5RkCP3d3J77YcgcxhJDP3alwLVl9bSMkFx5CO/zr+EFh4NctIexjM7icpG/i395OXAPC9U3b9KIxmmuj//Fo+AMYAku/AcBtlfNM0gzWOCKRgq8TX3gxIXjMnAZn7wICMolRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efwyyiOLYVEGGYrHCWg81tPk/9SbEbPX7p11qBukeHU=;
 b=YLxWGOEMnxLBCG3lykxB/5ucs/Z9iCw8kJk5tq9kWGkFMMN6m/H2KeqLILi96Tyw2rdel/+iE/YCLmMAcpsK65dxbn8idRutNGHR1c8/4oARrjUJJdHJkpRQ6uXTLMrYWbLg+n+J7JtDrbY7W5zZ6VykRQQYtCLoFAm/QYERdJ9A86VWfqVoQjXEXwj7CBfI3swHsVN+t11IhDp6f/MnX4uBVn214aeADzI5uzW08GxlNTn9gEuJw2Unu5BomREO/4YoUrjCNeNoq1LJN4ve6RtZzQ4IjciaFRwy5fZI8DzMjDsVBl8xltHqaQPu/l9cv1JA0IPXtJFBgGU+JAPIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efwyyiOLYVEGGYrHCWg81tPk/9SbEbPX7p11qBukeHU=;
 b=344CbiUrzmbi1M20CGi2MLoz4Wx3A8qRUXxBUlHCWOVVfNq4LfgsEK8Ozt9oiYZBZ5UKS2P58zSGUoWfzchmMSFoIOCC9TeUMslSSJvKksuh3u0WITzaeYGUUDo4XUdmwL5MfcXhes0Q7v2lsTOpdnSLb5MDQ8wCEuULUQdn7V4=
Received: from DM6PR06CA0085.namprd06.prod.outlook.com (2603:10b6:5:336::18)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 4 Jun
 2024 17:45:06 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::fc) by DM6PR06CA0085.outlook.office365.com
 (2603:10b6:5:336::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 17:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 17:45:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 12:45:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 12:45:05 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Jun 2024 12:45:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <arnd@arndb.de>, <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <rodrigo.siqueira@amd.com>, <jerry.zuo@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] Revert "drm/amd/display: avoid large on-stack structures"
Date: Tue, 4 Jun 2024 13:45:04 -0400
Message-ID: <20240604174504.725893-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e4bc54-29fb-429f-ba28-08dc84be123b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DLBRtPaH4Jwpk7qFKPDVi4UbfE1aVDPIps176EwwfwPljXmqVROGkB/ye3Ik?=
 =?us-ascii?Q?XXyV9BvRThUDLTO4Q80nLMptUuDh+8KBXrDXuLIK666dQvvxxoaiEn3IQWvP?=
 =?us-ascii?Q?LNfz0ceJIWyBwWsePdMY8L0yBYQNmcCcVELeBsBtp3ZmouoGdG0GV7x5Q/cr?=
 =?us-ascii?Q?pUOwHwUHFmaXJGo5ZhTNU9fDAs8Yor916eI+WrUYmm7pQPZZp07PO/Z6LrjT?=
 =?us-ascii?Q?Yv9D7+PPk/68sPRNKPk90XJglzn/mpKk3WQCXBbnjHgiuhiZzumfz07tJ+Ag?=
 =?us-ascii?Q?p7eqrLa7LnLgrNGm2AMffVmLbOyssjxCzrnM0j7nKlYnqsz/xC1DidmNwegJ?=
 =?us-ascii?Q?b8paV+B5Os3I/qo5lvQ/VsQX2uUiFDBJvbClL26zbN9gDYLw/Vj5Ge3dUGU1?=
 =?us-ascii?Q?G/q22UDDM988BuWTolIWf4bVpr+mzon9uI5ABn37YI8r4X+A1dPGxC27XuQO?=
 =?us-ascii?Q?lKepTjcF+GxMgEPcLWwn/15Q7xivk5VulK2yooVVyAMr9QeV2XehM810vA8/?=
 =?us-ascii?Q?XtdTDoosOIP9wJd/hcN+6CGai43Vx7lXaH0XVFhX63kd0dfgqCa3nwVmX8GH?=
 =?us-ascii?Q?s3Wy/843n7dxf01tUU24YDk1o8h47o8f3hlzDeymoFtSlmTfOgZguVr936tc?=
 =?us-ascii?Q?GNIlqmKbVjPbxivRcjUVUZC8PsgVG0ZkGeAxt9SeJXQ94akJzDcn2smA6arp?=
 =?us-ascii?Q?ur7KLv2/84ZwtZy05lx8BjJnSeFw45IE4cyp0Z7zs9g0rldQJ7CR/UcUOeHj?=
 =?us-ascii?Q?ZHNS19FG9kBpqvQFnknd+kdLJHe8+1e5M5FKjb1Pr8OaE9P34Zy7f7VjoukO?=
 =?us-ascii?Q?RTr/D8kNJT4IzuNXtIxLkiqpP0w2n2gY5Ww2XnPkujT/wa+Vwu0rZKPVGB57?=
 =?us-ascii?Q?OBoGwWRlFVbN1a3yZXfWP6aJ5z0uDj1uNzewuspJ2cMw/4LSdNIGolmooszh?=
 =?us-ascii?Q?3pj5Er2Lj1Gd161DFB07dzQap6VxXLWfll9e8omlUCq7Y96Bd9fA5Mb+Yeqs?=
 =?us-ascii?Q?jC+qDdYjjjlNE/Nn3rRSULdkxmz/1q8JZS562PWMNHyqgtPDxg9hBVZdMim7?=
 =?us-ascii?Q?VlNDM81RCvY2Pe7O+XsAEV8E6uZxWE8/yP4ONhzR2pa+3/JehELGLwp4J21f?=
 =?us-ascii?Q?a/mu1qBHUdMCwidpeWpQLlapY41AHvFiYnOkKpukHCQEjYyUviyAz5qC0ViD?=
 =?us-ascii?Q?vQEDX9FVJkI9oggvNEwnneHqX4mVcE48teyEESE6bnHr9cCQpqv7isBOFoiS?=
 =?us-ascii?Q?ozCES/wPjmjWr9wndhxyRGyv8o15US10MD1l8EnDutVhL2VCpIKAkuoktAQ3?=
 =?us-ascii?Q?1HEtNi7z2i7nGkkE1hYLbyFewRSNuNb79GHTI7g8H9wDRT2JBIFEiCICud0n?=
 =?us-ascii?Q?vJw5t3ZAOQ/iNiCApNfWS4u26KGI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:45:06.2918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e4bc54-29fb-429f-ba28-08dc84be123b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

This reverts commit 44069f0f9b1fe577c5d4f05fa9eb02db8c618adc since
the code path is called from FPU context, and triggers error like:

[   26.924055] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[   26.924060] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1022, name: modprobe
[   26.924063] preempt_count: 2, expected: 0
[   26.924064] RCU nest depth: 0, expected: 0
[   26.924066] Preemption disabled at:
[   26.924067] [<ffffffffc089e5e0>] dc_fpu_begin+0x30/0xd0 [amdgpu]
[   26.924322] CPU: 9 PID: 1022 Comm: modprobe Not tainted 6.8.0+ #20
[   26.924325] Hardware name: System manufacturer System Product Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018
[   26.924326] Call Trace:
[   26.924327]  <TASK>
[   26.924329]  dump_stack_lvl+0x37/0x50
[   26.924333]  ? dc_fpu_begin+0x30/0xd0 [amdgpu]
[   26.924589]  dump_stack+0x10/0x20
[   26.924592]  __might_resched+0x16a/0x1c0
[   26.924596]  __might_sleep+0x42/0x70
[   26.924598]  __kmalloc_node_track_caller+0x2ad/0x4b0
[   26.924601]  ? dm_helpers_allocate_gpu_mem+0x12/0x20 [amdgpu]
[   26.924855]  ? dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
[   26.925122]  kmemdup+0x20/0x50
[   26.925124]  ? kernel_fpu_begin_mask+0x6b/0xe0
[   26.925127]  ? kmemdup+0x20/0x50
[   26.925129]  dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
[   26.925393]  dc_create+0x311/0x670 [amdgpu]
[   26.925649]  amdgpu_dm_init+0x2aa/0x1fa0 [amdgpu]
[   26.925903]  ? irq_work_queue+0x38/0x50
[   26.925907]  ? vprintk_emit+0x1e7/0x270
[   26.925910]  ? dev_printk_emit+0x83/0xb0
[   26.925914]  ? amdgpu_device_rreg+0x17/0x20 [amdgpu]
[   26.926133]  dm_hw_init+0x14/0x30 [amdgpu]
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c   | 16 +++++-----------
 .../display/dc/resource/dcn401/dcn401_resource.c | 16 +++++-----------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 8ea9391c60b7..70928223b642 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -193,11 +193,7 @@ static void init_state(struct dc *dc, struct dc_state *state)
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
 {
 #ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_configuration_options *dml2_opt;
-
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
-	if (!dml2_opt)
-		return NULL;
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
 #endif
 	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
 			GFP_KERNEL);
@@ -211,14 +207,12 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (dc->debug.using_dml2) {
-		dml2_opt->use_clock_dc_limits = false;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
+		dml2_opt.use_clock_dc_limits = false;
+		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2);
 
-		dml2_opt->use_clock_dc_limits = true;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
+		dml2_opt.use_clock_dc_limits = true;
+		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2_dc_power_source);
 	}
-
-	kfree(dml2_opt);
 #endif
 
 	kref_init(&state->refcount);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 8dfb0a3d21cb..247bac177d1b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1581,27 +1581,21 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
-
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
 
 	DC_FP_START();
 
 	dcn401_update_bw_bounding_box_fpu(dc, bw_params);
 
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
 
 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)
-- 
2.45.1

