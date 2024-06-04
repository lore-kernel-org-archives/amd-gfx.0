Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACA7C27C53
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 20:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52A110E5EF;
	Tue,  4 Jun 2024 20:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xn2je9na";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0C210E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 20:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4Eg1UrXeRxLgkpAc50OZQWh2E/p6ri4L9jOnJXviqJpGHCkX5w2bEHx/eqS72TqPThRJRtdneOGfCQMAQ++YgAySffVubKwKOVvoIsoW4/0pz+F6ixYpu2x8QcQWfkB8B+tuXCcHRBOAq7pU6Xm5z9MLbmyKmjKaSz258FqHHyzzvtRnIcIPfym7kO0sYteEeU/Ts5nmhXVT9hKbF4y6Nwg0VaaA1j9t1ubPbTs+d3SgfbFVKoGne2tthtgtWy5x0G0HQLyLxbsAm7iptdXm74oS9R/+CKwgOJYq5YO60YFOnYdC1uwty65g/XAknERPC3tj9ZAk8/aq+UHbs3HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdxfDpUF+DI+b41gk4PqL3auiyPam81ZybSrfApQYkg=;
 b=SccrG4Eqo6QrFQ+4F9d7t70yB0nPS4zDAatq/QHbrThaVF5h5mHBFTHm3dOQJMGLAjcfMjb07B/sMyrgzSaOWbQc9IaK1J+e+fuNN1Hisz6pd4GN1E2FizCAVDnM5LY9BTOrNDvAoSeggb3FjFcx/x2HaKCTgiKSYckYcz/ffEkVc3MPnysejOWgZ5u4W/YimwNAusTUp/Tw6qXe8XZYy8ZqEIzcDTTxb7/RvBuLG6ZMArLUw1gK5RuadrBgsMj/PejwdygdGypM7m5t5UEvNbmZy9pr1tArXK3FBDdqts9/3EgEEBbJXPjdT1ds3kSgse0NNxi0WHI3bVEVy3Fjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdxfDpUF+DI+b41gk4PqL3auiyPam81ZybSrfApQYkg=;
 b=xn2je9naKramG8szEOJqJG1NYM+qwVqBIu+sf3i3YsQ2VRatOvXfEZZLjCjoz0X1O4onzqk35h342YAoh5mAUrCesGxbjZB+3CHHknjwtf90aNpV3xZGVQqxNMjORVIHjfwM3sfujhKd55Jszg+cB9WDxzIqJRTwmw4am3xcODM=
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 20:26:24 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::63) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
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
 2024 15:26:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, George Zhang <george.zhang@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH V2 2/2] drm/amd/display/dcn401: use pre-allocated temp
 structure for bounding box
Date: Tue, 4 Jun 2024 16:26:06 -0400
Message-ID: <20240604202606.697979-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604202606.697979-1-alexander.deucher@amd.com>
References: <20240604202606.697979-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: fa09b2c1-1413-4e21-b0f2-08dc84d49a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DH6BVBP5QwI/wadqbbRMIHDEtjyeMjViZL8coWNporYGA1EUXuypreh8m+6O?=
 =?us-ascii?Q?Wd6ILJ9Of/PK8y1lXnXiasl8hXcjRxxQDEYh784BF4uTCJ7npx0PSdeVziym?=
 =?us-ascii?Q?EnxUaic4LKG0BsIL38boEnMxOu1HlkUBj8RuTp3rJMfunlzAfwhn6Oh/VJMG?=
 =?us-ascii?Q?tgs+hj99jG/0xY3ORbm7XEOAe46LZyee4TrwHDzrvTbn0kGea5x5hMz3MGYx?=
 =?us-ascii?Q?liRbgpdSqnboij6qjYq7PPnL+3EbmYGa4tyeT4nfAAZ8S4OekzThvK2W5hQ8?=
 =?us-ascii?Q?Phf8KwK7a7qAvrA4xcYjtYaDeDEj8hMEMOiBo/vAiL3+NJspHiiEazw83c2v?=
 =?us-ascii?Q?Sflpu7ZTiOi/dTNfRopDmXywpspRWa0vLyKX9cZ4gPN4Vs6xgl4pp7TdBNU7?=
 =?us-ascii?Q?Et1t2N0n/RmECJQrM2eT1sGEb0KwRZtr9GMnLzW0cMLn4x4PQ4k744RPQ8eM?=
 =?us-ascii?Q?y5dl6sWxIIcbuDUse6Fr3soKW+yBiAVPK3vSHzvwfHzl0MFFeX5YktWvNZ6r?=
 =?us-ascii?Q?ldvU1Od2KPm49moflFxuy4RkghQ1oWuUj1HoDVSjtE4W0Uwq1HDRQIBueW2F?=
 =?us-ascii?Q?n+TJVqAyIn9dzYSyxWU7dnRSYxquqb9YGkm6fvuukobN1uWoEz2Zn1xZwGge?=
 =?us-ascii?Q?tTXzQGE0fe5EHkQjvzyEdb4zpGRcV3puxy4ahn/sfS8aJ0zX3nhbYXp46U+o?=
 =?us-ascii?Q?geZ2uBGSRecDpaPX5S5qOZ9U/zIMvY2DVCznkpG6TljLRXkw8e62l+uSk7VQ?=
 =?us-ascii?Q?5SjQklku4hVwAJmD75gCD4BMldBTzMAu5YVeZv43CJf5sQ0B/WBvNzOSmIj6?=
 =?us-ascii?Q?Za5dMp76UMmKYrYqT+PUJEgzvgSyRxkev6mWj/20mhib6O18JNT5D8C+a9y4?=
 =?us-ascii?Q?3EE639v+HsON/6y4X3qJsUSYc5h5tL2tZtzflrBUwtzrrZqs0wCn8K74Eqqw?=
 =?us-ascii?Q?5mvTUE7KrldQwjJUbPcjbfAZpHnrjOe/4l5n/lUE83ecAOj7+UwVl3cpZutU?=
 =?us-ascii?Q?tKqImFNTCe2qEUzxY0fpuU2x8kweahOALkmOtZQIkNyExPX2KaNjr1Z8qqir?=
 =?us-ascii?Q?jC1kT1pctoDnS8u6bU5CVRVB6lI8sLbIXz8xDgtCkb97dCxk/q1jp3Yy1/C2?=
 =?us-ascii?Q?lL0dhbFxNPC4SkSb0TnOpBSEKnhG/9eJdUEd7l1JBBeIKNLdHkeenvPPKp7u?=
 =?us-ascii?Q?Gc/Z6JRMzjsLJX8z0nXRVCcOhLgznexKCTPXvHl9ptYB67+bqBwuGp7olVDA?=
 =?us-ascii?Q?w2c4oTOV9md5/NFnDpF05VAzy9rEdpz0EhDCUr1nZ50JHLHnFXoakN6l1Ucn?=
 =?us-ascii?Q?TzBcHTuYn77FG5hk0Tcjn9mgKQUljCf10mjJOiNrQmJ+6otnKVRTdzRYVvdN?=
 =?us-ascii?Q?bU67o4bcGqfCbRV5x0G74Tf0ReA8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 20:26:23.7219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa09b2c1-1413-4e21-b0f2-08dc84d49a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

v2: drop extra memcpy

Fixes: 669d6b078ed8 ("drm/amd/display: avoid large on-stack structures")
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c      | 13 +++++--------
 .../display/dc/resource/dcn401/dcn401_resource.c    |  8 ++------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 8ea9391c60b7..06b22897137e 100644
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
@@ -217,8 +216,6 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 		dml2_opt->use_clock_dc_limits = true;
 		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
 	}
-
-	kfree(dml2_opt);
 #endif
 
 	kref_init(&state->refcount);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 8dfb0a3d21cb..029ad7bd7b5b 100644
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
 
@@ -1600,8 +1598,6 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
 
 	DC_FP_END();
-
-	kfree(dml2_opt);
 }
 
 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)
-- 
2.45.1

