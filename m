Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB156C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 21:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5163410FADF;
	Fri, 29 Apr 2022 21:54:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9619E10FAD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 21:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZj+m/CImOT9CrPrYtQR3FzICGvoXh7tMAGm5YIPAgZzcQI6yLS+RBHqA6FPpr5YW2oH0XKRLj7Q5onfYDKXBUnmox+JcV21Jlf0lvQyHxi0v+CSHr9jtJv81Nav9LN6mz0YLwxvD5fbVBKPLb47DVeu47GKgiRzqlJGStGAAnZ+EsYYknmHehBXX5OlfyT+21pv2Kslp+oBxomrebpabfmaLRVOD7XN95hUWT4EJC+/PYllq+bDyVz+ha+Fp/IspUoqVjuDdZ+chiMT7f7M5TUYRJSGrSJY2FGvzRwq4VclT3NezBdZJuGR1Zn7PekcQDek4QsXccNmLPa3IH57Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImzzgD8kQjJXamle/ftW6vgiO4yV9hA0V3Dcqv2y7zE=;
 b=hSpinj6z3f2MpjiAiADhPrndX1BQvjBuzL1A8kA72Qi22wsUHjwU9PbgLsj/FSwm4nUkbZRtgJqSilILPaUzP/1kgEMf/sLhu5x0klEe1H7iFkMNg+5ZssftAYtEnWPV2DcesgNY8fw1yGHFlbH5IDoEJ+p1EZD4XsiJPEq2XzniAKF+OMQUDkNfcRpO+tX2vXcC9Cv95BZN0LZGfXHooSuhhzXeHhddYZnf/baEcO0WjRKW+Hu2urWSvEWqv9AlBlxnhOn2eBFWF3bE41EN8FjfuhnHwLlM5GqkGxRB2q4DX1b+rVakMHfDOJ9YrOiUfuIqP2NfxUDjJ1yCwIozaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImzzgD8kQjJXamle/ftW6vgiO4yV9hA0V3Dcqv2y7zE=;
 b=y04PCKJtcDKXOW/NZOQ5FB+P/eoJLIdhFQ3eeqNsVIPHALlIceebH7sAlUgCEGz2URdfXLbpp0rfSPnFCxY9Dgv7g1b4L926CYe4bGe1Vg4RmhcrNe6VKK5nrDIDtRaccDsdflh9OZyGcjzmtJBWBR5u1A04NipvY78I21/R42M=
Received: from DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) by
 BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 21:54:14 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::8b) by DM5PR07CA0066.outlook.office365.com
 (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 21:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 21:54:14 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 16:54:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amd/display: Fix null pointer exception while load amdgpu
Date: Fri, 29 Apr 2022 17:53:54 -0400
Message-ID: <20220429215354.1132706-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe09359-b76b-4d28-c0c7-08da2a2acd17
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53012B4CCCFB6419E15B590C98FC9@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHclolv2gYzVEvbPg0GmaHrRoowm1dG5AuZXnlv22nHi+0MLzWDWYVefbFUWjp+Io+UeSD1Q2wdFmZ+/+iHoM9ifs7hl580dNHcVpoLUyACByCCva9Lt+4JRkDFcH9IXM7/a/y0l3zQ9lwKMyPowmqbO5llKRv9kIpBToscSIAUbraHKOzQ3DC5aZUO9szknqj7dMmetwiOdQxpfXNbWDOUQVMspfMTqA24XCfz7mVJ+AM5hH5oPsTEIyfziqt7cUFZK/IFDSgPiVDi80nhCMr6OT/TPjtKjZLo/QvW1IidhWs6oayAAZ4gUZe04DTnkf45RG5ES4g1ihqyBZkVr2wzn9PHEIiC/QYXMf/w02tQNqFDCfcMrohpuUfD4+jPlRat688F11AUm9LkcrzLxtv88zAwbqgZE8RcE9wVDiOqFzYMXQnzHG5rcIEavZlLBFq5oJCRZSRQLQWU0pSdV5BqokEnFedECEj5w2DQ3+htoGlIqiQmMiPX8ZQo7gqz3q1UyvMQd+lESy90nIAbpgT4RTFG9Y9z1GBdm/YrIJPcDaEFyI/T/4CgXoqaalj9G5+jTg032iphKoAgJsB0BDWEWbdbUGpzNF1lB3VFrM4YhQdHUkA5jSCnbSOHmGgTACvqhlZfRk0g7aumgx+d+OAtkNE4TDpN1W1PcoQ7fC3xABAz1vxdiUM/tUVklOYpVMDObM5nv/cXHjjh8YbHvRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(8676002)(36860700001)(1076003)(4326008)(6666004)(336012)(426003)(47076005)(5660300002)(2906002)(186003)(16526019)(356005)(508600001)(83380400001)(86362001)(7696005)(40460700003)(8936002)(316002)(6636002)(54906003)(110136005)(2616005)(82310400005)(70586007)(70206006)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 21:54:14.3288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe09359-b76b-4d28-c0c7-08da2a2acd17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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
Cc: Sung Joon Kim <sungkim@amd.com>, Agustin
 Gutierrez <agustin.gutierrez@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

Recently we got a hard hang during the boot on DCN 3.0.1, which caused
the below null pointer exception:

[ +0.000426] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ +0.000003] #PF: supervisor read access in kernel mode
[ +0.000003] #PF: error_code(0x0000) - not-present page
[ +0.000003] PGD 0 P4D 0
[ +0.000004] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ +0.000005] CPU: 6 PID: 874 Comm: Xorg Not tainted 5.16.0.asdn-apr28+ #15
[ +0.000004] Hardware name: AMD Chachani-VN/Chachani-VN, BIOS WCH2303N 03/03/2022
[ +0.000003] RIP: 0010:resource_map_pool_resources+0x431/0xa70 [amdgpu]
[ +0.000356] Code: c1 4d 89 c8 49 c1 e0 07 4d 01 c8 49 c1 e0 04 4d 01 f0 49 83 b8 f0 01 00 00 00 0f 85 16 02 00 00 49 8b b8 e0 02 00 00 89 45 c0 <48> 8b 17 4c 8b 92 a0 01 00 00 4d 85 d2 74 24 4c 89 4d 88 48 8d 4d
[ +0.000003] RSP: 0018:ffffa92a4142f718 EFLAGS: 00010246
[ +0.000003] RAX: 0000000000000000 RBX: ffff9a0b86d93000 RCX: 0000000000000000
[ +0.000002] RDX: 0000000000000000 RSI: 000000000000554b RDI: 0000000000000000
[ +0.000002] RBP: ffffa92a4142f798 R08: ffff9a0bdb3c0000 R09: 0000000000000000
[ +0.000002] R10: 0000000000000000 R11: 000000000000f000 R12: 0000000000000000
[ +0.000001] R13: ffff9a0b88360000 R14: ffff9a0bdb3c0000 R15: ffff9a0b86273000
[ +0.000003] FS: 00007f4b5641ca40(0000) GS:ffff9a0cb7f80000(0000) knlGS:0000000000000000
[ +0.000002] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ +0.000002] CR2: 0000000000000000 CR3: 0000000102cb2000 CR4: 00000000003506e0
[ +0.000003] Call Trace:
[ +0.000002] <TASK>
[ +0.000004] ? kvmalloc_node+0x5c/0x90
[ +0.000009] dcn20_add_stream_to_ctx+0x1c/0x90 [amdgpu]
[ +0.000330] dcn30_add_stream_to_ctx+0xe/0x10 [amdgpu]
[ +0.000313] dc_add_stream_to_ctx+0x67/0x80 [amdgpu]
[ +0.000300] dm_update_crtc_state+0x4dd/0x6e0 [amdgpu]
[ +0.000320] amdgpu_dm_atomic_check+0x63b/0x1270 [amdgpu]
[ +0.000311] ? __drm_mode_object_add+0x90/0xc0 [drm]
[ +0.000043] ? preempt_count_add+0x74/0xc0
[ +0.000005] ? _raw_spin_lock_irqsave+0x2a/0x60
[ +0.000006] ? _raw_spin_unlock_irqrestore+0x29/0x3d
[ +0.000003] ? drm_connector_list_iter_next+0x8e/0xb0 [drm]
[ +0.000038] drm_atomic_check_only+0x5dd/0xa20 [drm]
[ +0.000044] drm_atomic_commit+0x18/0x60 [drm]
[ +0.000046] drm_client_modeset_commit_atomic+0x1e5/0x220 [drm]
[ +0.000051] drm_client_modeset_commit_locked+0x57/0x160 [drm]
[ +0.000038] __drm_fb_helper_restore_fbdev_mode_unlocked+0x60/0xd0 [drm_kms_helper]
[ +0.000027] drm_fb_helper_set_par+0x40/0x50 [drm_kms_helper]
[ +0.000022] fb_set_var+0x1c8/0x3d0
[ +0.000007] ? __ext4_mark_inode_dirty+0x83/0x210
[ +0.000006] ? __ext4_journal_stop+0x3c/0xb0
[ +0.000008] fbcon_blank+0x228/0x290
[ +0.000007] do_unblank_screen+0xae/0x150
[ +0.000005] vt_ioctl+0xcf4/0x1360
[ +0.000005] ? get_max_files+0x20/0x20
[ +0.000005] ? get_max_files+0x20/0x20
[ +0.000004] ? debug_smp_processor_id+0x17/0x20
[ +0.000004] tty_ioctl+0x373/0x8a0
[ +0.000005] ? __fput+0x123/0x260
[ +0.000004] ? __fget_light+0xc5/0x100
[ +0.000005] __x64_sys_ioctl+0x91/0xc0
[ +0.000005] do_syscall_64+0x3b/0xc0
[ +0.000005] entry_SYSCALL_64_after_hwframe+0x44/0xae

This issue happens because "pipe_ctx->stream_res.tg" needs to be
initialized first before reading its members. This commit fixes this
issue by properly initializing the pointer before accessing the target
data.

Fixes: 9b98e01a28c6 ("drm/amd/display: Add odm seamless boot support")
Cc: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f292303b75a5..147c6a3c6312 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2150,12 +2150,18 @@ static int acquire_resource_from_hw_enabled_state(
 	if (!res_ctx->pipe_ctx[tg_inst].stream) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[tg_inst];
 
+		pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
 		id_src[0] = tg_inst;
 
 		if (pipe_ctx->stream_res.tg->funcs->get_optc_source)
 			pipe_ctx->stream_res.tg->funcs->get_optc_source(pipe_ctx->stream_res.tg,
 					&numPipes, &id_src[0], &id_src[1]);
 
+		if (id_src[0] == 0xf && id_src[1] == 0xf) {
+			id_src[0] = tg_inst;
+			numPipes = 1;
+		}
+
 		for (i = 0; i < numPipes; i++) {
 			//Check if src id invalid
 			if (id_src[i] == 0xf)
-- 
2.25.1

