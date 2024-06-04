Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F475C27C52
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 18:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B18010E00E;
	Tue,  4 Jun 2024 18:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DIvBV/+k";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2083010E077
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 18:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7XCNGE1aoFH1pRdW1LZEmg7q8bLuYKkc/1dMGlj/jCRmu9A1xwgoSjsN+5W/fqeEpGMhlTKXrr6DuBxx7EEjUUw638WF245X8ZKq2XUx2JlddngOijEEQmupm07EcNi8jVvgTmwej0mxRT0KM/3UrGr2fmWtFg6pZpQFMsGhUNQ9pW408dO8TftVpwITP3f2MhN3lhQJjo+LJI0RtPDoTbcSWItU/AazZBaVBLrCcfOVKK+luAtBKm1s2CV7UsF5KtAiQV1SJF+O8RujXx+QIf4WUMdJWk1VuzQpanneSrrra2BUW3Ct7oPqcbTWmkIET8kvLsuLJao0VNbGGeIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PzlLN+umgG7tYeJUGlTXpw44CjIVkTgYH5zi767mdk=;
 b=YVj/BKGUYHjbN970UmyJCYN2NXWuhDRODxgS+6Rn4zIsLL9BEqNVhjGEPqlnXgzkfUS2S82W71L3/Nyx7CAfw8P38zJ7k/VtBBXClXYPG/bj64ua9OXNl4tayqDgBVwQvo2nRP1PzQfMLBtJfeVvsK2wGox3Qgc2wNO3W/4tNkajKuRpY7T55ppd7AV/UOWT9G3kDfAGwAQcdXEUDoqaK4fC1B1C49fC8lklcDgg374PSwdNTvYJQ8UutNVSPK+L5bgfjwAKZhaN1Qgc2soIMx8ps5Bp3taf4BfFoyPXtGs4UzgK8xWaFQGnwyzcCZ0mcHB6MXVMk993HMMZ3u+HMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PzlLN+umgG7tYeJUGlTXpw44CjIVkTgYH5zi767mdk=;
 b=DIvBV/+k2orFrQq7ubUXsIOUsFYwE2xQCLs3iOs7199GvP1lhlc9WPIGHAcP8nniU+LRUwStVQJtQ6OcKH0pUb8u1upxuIMSVD3pudKI+AGb+mRGEj9pqNmrFJI0Kc8vptumR+0uKac4YalLT4czHypCAx30SqWU8VRyter3DSs=
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 18:06:35 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b8) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 18:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 18:06:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 13:06:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, George Zhang <george.zhang@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 2/2] drm/amd/display/dcn401: use pre-allocated temp structure
 for bounding box
Date: Tue, 4 Jun 2024 14:06:19 -0400
Message-ID: <20240604180619.600760-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604180619.600760-1-alexander.deucher@amd.com>
References: <20240604180619.600760-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f49f1e-cf6e-4981-119a-08dc84c1127e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?febjrGntf/IhqAklp22qgmz9Wtf5JqdnS5HdGptz8tiPMbkV1xZ9yvPFmMLW?=
 =?us-ascii?Q?zR7Hn2IfIMHNo1N+E606VSDaeZCjK7Wsk6wwI2AtJEytk9oJJy04YXmbxE1E?=
 =?us-ascii?Q?yi80Hje7kiHerBBl6uU75aqts1v1m22IwNf8leqUxkjdZghCslUWBX+H0SdR?=
 =?us-ascii?Q?0rKJnffgI9UZtkveDoZN5y+IvS7st1FIaTysaWuaYHHcvPEZghJhnU3ykGKQ?=
 =?us-ascii?Q?BM590V8aUaOAeiYSJEOOk0DPCz6SC939wgGYS6Qg4VawljTR0uu41wxwLxXl?=
 =?us-ascii?Q?GjI4JzQv8wzfare+eUp2a6rQX5yvSIjGq4fqAg7sSkHGJoxPJfb2PygaTo0J?=
 =?us-ascii?Q?L0UJ9n1GFK3/pUdhSGzUb0VmtqTgVp0pLzJ6uLh/9pHQq7kVJMW107J3dCaI?=
 =?us-ascii?Q?rS1JosAHHAqMUD1d/yHTrOYMIUgsceaPp2Rh0ecr72POrVXtrGP5fc/2MMVT?=
 =?us-ascii?Q?oCeCXy6tJkJH79U8z7PWb8E1M3VVUTsU6c+CXqHoNPO1rB063g0dPULvml1+?=
 =?us-ascii?Q?HKEImyhxs0v3f1taGGLNrpuQs/W2pugVmcEmvaL/VRZohYXP6j+aTsvYYybN?=
 =?us-ascii?Q?1hV14V2nJdBgAXVcpRjg0QPK0pclYsDiPpZRbGsRJIkkDwbQjqBcx4Ir0x9V?=
 =?us-ascii?Q?ZqCnZBrnCsfCTYknuuy+tznbkynnuOO6EUGRfp9Rl8GtpwS8Q2t1OxwJSZy1?=
 =?us-ascii?Q?If5IVSmWHvlTMNGhDvU8mwkB8YrasZtZ7ngdrYndMywBfvIGffhHSdkyQXZL?=
 =?us-ascii?Q?sF/FiN5t/+H4lQOvqAuaf5kNmVhBOwWt3hMzD3snb8ju9TXZONWKgkS6OuP7?=
 =?us-ascii?Q?a/qZST4YTcNfdu2sZYuw7c70mGeykU37TWL6V7XUlr8vdkrYJh0agKd0NqXW?=
 =?us-ascii?Q?DPBL0/wEXqebOKOhpuU/l9Fkxxq/ZWnRdZRNvqbfUxKRvv7lJGYip9hF/9gs?=
 =?us-ascii?Q?cuGUM+7L0wuVmO8GK6yn3+zNqUiMxZRj7JslNUZPrOaLmfa//7MFFOu5IGSs?=
 =?us-ascii?Q?sfzRpfFYi/KoXpsABPgVE3IbEae3QCGVfkCNN4SkbPuhHwfWCsanV/b7Rh8/?=
 =?us-ascii?Q?B/tocAvmgSXNwUeIdyLjt7wqdzhwm07Q55IRAUUyTdB/ivA2CXU5WfFpYNHk?=
 =?us-ascii?Q?aln+QY5/Ke3GbioUn4+4AYuZe43l1qf0xm1RRtXDYwzypm4DYkYgdtd3ysRb?=
 =?us-ascii?Q?ZjZaafcyECWcH01hbBGgojkZdn1DVCNDAzEFoihpl03EbYQgcezAWJ6m2O8E?=
 =?us-ascii?Q?G3MyG0Al+TeBd2i+3Yw8Zpo03aFyb8ewN6N+Jgxixfue+p8NCFLc8qdMOIck?=
 =?us-ascii?Q?CdMZm4qDoz3m0ZZKcQjd6P4yX2Y++QqSsmvgjMZefQAhSUg9UXRLC208scXN?=
 =?us-ascii?Q?/UOV7nHlKL05tWVhbAoiiBB/5V4z/uZGaR725sAfnAn9sZhYKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:06:35.0761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f49f1e-cf6e-4981-119a-08dc84c1127e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
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

Fixes: 669d6b078ed8 ("drm/amd/display: avoid large on-stack structures")
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c      | 13 ++++++-------
 .../display/dc/resource/dcn401/dcn401_resource.c    |  8 +++-----
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 8ea9391c60b7..aaf6817aaf43 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -192,15 +192,14 @@ static void init_state(struct dc *dc, struct dc_state *state)
 /* Public dc_state functions */
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
 {
+	struct dc_state *state;
 #ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
-	if (!dml2_opt)
-		return NULL;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 #endif
-	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
-			GFP_KERNEL);
+
+	state = kvzalloc(sizeof(struct dc_state), GFP_KERNEL);
 
 	if (!state)
 		return NULL;
@@ -218,7 +217,7 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
 	}
 
-	kfree(dml2_opt);
+	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 #endif
 
 	kref_init(&state->refcount);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 8dfb0a3d21cb..7a61dc83b423 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
 	DC_FP_START();
 
@@ -1601,7 +1599,7 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 	DC_FP_END();
 
-	kfree(dml2_opt);
+	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }
 
 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)
-- 
2.45.1

