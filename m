Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC60E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2024 11:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3BE10E44A;
	Tue, 24 Dec 2024 11:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X/LNGgWq";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B00610E44A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2024 11:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gh0YwurC8P4ePkiOmbsH+RZ5fM5zWqHjYUhEmkW1aD2SaLfLy5OkwjtahaQkmqga8gVZaFedpL1Q4uZtuiT2dLVXyJM3ySta5o0HXpX4orAULMGs+yQNLnYe2YtXjvQOWyGw8nh2jn/OAy9Wez48I0/+uHm3JFYKO1JRY3BN+jwgKLPZTqNT2wDzE7sl3C6E/tdL0djhUPsKThJJEpQrQmYFeh1SvCXWj1kkcl50Xbe0iqsrQuSpz3Ae+6PQM6OUsLgkDun1LbpxiQ9Ys9ETSTj+N/D8p8V1gZ4zRB+pxOSx1Ia5HlhEDWdjPDOF3YeKLG0i43PIGrDwMLvi09pXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwfjtAaPE90Zn+TMX/cSWtyAq5dLsQKDnQsnxexkOGM=;
 b=lUNBoJQtMWNywhcnyeZLHpylcvJTHN/3mkSnTweKxqK5Kar+HZZkm7JfJN08tugEgFMc2Yisv4SAb+miUDOw4dXnFh91Mjl2Z38D3VusJqWHyWMx2R4lwhMe65LeWTJ/hPboK//8HTXoQRFlySXWByu7O0erfZ38ald1MtrnMe8D4lS8hQH71noKEn+PQruIEJEQAKQOE7PbzvAl7xIakHUYyoMQlxWrEYAht8hoDEF81QPVmNtc9FOSCErVlDNbCK5pHhuWwuGyFCFAyJg7E2EnUBXkS8LQx31Nr6JBC6OL9CsxXjnou0sIyGZbhIzG4ADTYfxSnaGVotRUk3R/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwfjtAaPE90Zn+TMX/cSWtyAq5dLsQKDnQsnxexkOGM=;
 b=X/LNGgWqbZ7/Kf0EFGzH8L+S8m30AlZ3ttQm0E7bGU/rvC4+HQAtiK/RVhLgRnu2pRZK6wQyzXc1CQ+Nyo546lcKvzvn4GvDsrvoRoqdngDXMkRAtQsy/EUWGh3k2fQpmIyNoxFX9rv7NGZ5ipOY/5noTWRPocoyR1eBWNFfgao=
Received: from CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Tue, 24 Dec
 2024 11:33:14 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::5e) by CH0PR03CA0065.outlook.office365.com
 (2603:10b6:610:cc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.13 via Frontend Transport; Tue,
 24 Dec 2024 11:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Tue, 24 Dec 2024 11:33:14 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Dec 2024 05:33:12 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Add a lock when accessing the buddy trim function
Date: Tue, 24 Dec 2024 17:02:29 +0530
Message-ID: <20241224113229.141170-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: da2447d1-01a1-4363-d929-08dd240ec146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hdj8xkYR2y2Rz0iEN/BgXeu7ia20VQ3pI0XIcxEWfNU2WdGhCJirlQVOBJkI?=
 =?us-ascii?Q?cwgv1je/c3Oirab136G0QzQZzDqjg0N7/DSZ6a37H81YlmymaWy8niCZGuG7?=
 =?us-ascii?Q?koGMhd41uofa9+eRHKTHmayDtuRy88g0owYw/jRMbi+u9rB9MkYAj1B0P6IH?=
 =?us-ascii?Q?zjktvQ6L6n7mQ6b75lktWcauo/JFwvSCc/P8my2Cb/DnNeSvEIZc/8FgsIy6?=
 =?us-ascii?Q?idiO81nTqsIXFqzRLq9WJ2u4DzZAROoe4gR+3os76xFJhlM811L8fJ8o5UcP?=
 =?us-ascii?Q?MTQDwIbRVAOHSO5xwuqTf2pUkVfP8VANsjisKKQo0wqk8XTsirGOIA8eOM6e?=
 =?us-ascii?Q?rocSPBaVMRwAMIKqSfdEsRUdgxv473Don2YOSNp9vJ5JT6nr1SxQkBRqJ+VI?=
 =?us-ascii?Q?pyBHvLzX4XYQZKYcMhIqVdvBA3CpZiysk9c6jCA87yfqy1NhHjtf1lmIN7kC?=
 =?us-ascii?Q?00K+294B5D/9XBcHlHIv/e/Jb1uJRvuktUzy5yJp2832sG6D3EwvbkJEggaR?=
 =?us-ascii?Q?Y84yGfkBymQvEYBIJG/ZljtKtcJ8rjzt2ENxNXrgnO7DMDtM/HFec2M3biNv?=
 =?us-ascii?Q?8Hs1fp4Uhs4wXye2MeyicK3qYkBA2TOKeR8i4hgTqq6FMmTKEEe8ip3ny30R?=
 =?us-ascii?Q?SI38/hTLtszEsxfivGihXvQal2wVy5x6Srat3V+lMXkIyQ8Xmr2mg6+S5Jm3?=
 =?us-ascii?Q?H8v0XB2YLCyGoy+OrQteYAmJ9Btmbvhdyyv0lLLRvtO50nWpbgpuDWkW9AX0?=
 =?us-ascii?Q?OSvCTiSRTLThFt2022wRIOLbIG6AJqJNiZgCbu6h11QV9hQvLSahGaUbi1pL?=
 =?us-ascii?Q?9nMV6NgATs40NbWcsfT9Sp9uXp3ZBo/Be7K60gyOfKBpv7i6uUIvzLscpMlW?=
 =?us-ascii?Q?WpH0igE1JKLUcO9yoxXVBkV5PCaqJnRg0xhwe7hhU6SSOxKeMSW13azBN1+M?=
 =?us-ascii?Q?t6rZLiTLwYBG1ttI8xO5bNqKLCiMdCOG/Sr7DPsnQLZ1itgb9HGxcr3K4/9h?=
 =?us-ascii?Q?WkRWOQ0RHnYXaQdPzb1JTPRCSTuoYclofHie4PByBj5ND9Zge5SYvSCHigCM?=
 =?us-ascii?Q?ub3DRdjSNJx4J93EWeNlRBCQfXedY1EDKdpBc+6SrAXtEfrWD95YnV4IM8J4?=
 =?us-ascii?Q?GAtuwC4qe4ZsH6iqeri7bsmGopnfR19KUe6LiFg1uyolRexlERJg/4FKZgvL?=
 =?us-ascii?Q?pBqR71DLw8y9h+v02hFX67pehYuVvFXup3MD7R+ISHdHNhMtDzoKBw34dCqj?=
 =?us-ascii?Q?QJEGR3qA/Lbu2EQdgdrb2NzD6uaoB4Uel5qnAgdFivnLWzz10LfnDV2qaZ9B?=
 =?us-ascii?Q?vf3TB54x+ICjdwv2PGUlfu1y6QheBJtfEKNCkyylb/b2N4v1Q/Q51vBw3pc/?=
 =?us-ascii?Q?4lk+RVqEkbFE5ksyaMlD51tUW6zHjmllVP584V5xh5tat13RsOjgWEwnMvDl?=
 =?us-ascii?Q?Pxj1chT77PV6pj6oSYMffWXGpLljVJFu4tJK5NN8tVW03cW1HqTaTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 11:33:14.6328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2447d1-01a1-4363-d929-08dd240ec146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

When running YouTube videos and Steam games simultaneously,
the tester found a system hang / race condition issue with
the multi-display configuration setting. Adding a lock to
the buddy allocator's trim function would be the solution.

<log snip>
[ 7197.250436] general protection fault, probably for non-canonical address 0xdead000000000108
[ 7197.250447] RIP: 0010:__alloc_range+0x8b/0x340 [amddrm_buddy]
[ 7197.250470] Call Trace:
[ 7197.250472]  <TASK>
[ 7197.250475]  ? show_regs+0x6d/0x80
[ 7197.250481]  ? die_addr+0x37/0xa0
[ 7197.250483]  ? exc_general_protection+0x1db/0x480
[ 7197.250488]  ? drm_suballoc_new+0x13c/0x93d [drm_suballoc_helper]
[ 7197.250493]  ? asm_exc_general_protection+0x27/0x30
[ 7197.250498]  ? __alloc_range+0x8b/0x340 [amddrm_buddy]
[ 7197.250501]  ? __alloc_range+0x109/0x340 [amddrm_buddy]
[ 7197.250506]  amddrm_buddy_block_trim+0x1b5/0x260 [amddrm_buddy]
[ 7197.250511]  amdgpu_vram_mgr_new+0x4f5/0x590 [amdgpu]
[ 7197.250682]  amdttm_resource_alloc+0x46/0xb0 [amdttm]
[ 7197.250689]  ttm_bo_alloc_resource+0xe4/0x370 [amdttm]
[ 7197.250696]  amdttm_bo_validate+0x9d/0x180 [amdttm]
[ 7197.250701]  amdgpu_bo_pin+0x15a/0x2f0 [amdgpu]
[ 7197.250831]  amdgpu_dm_plane_helper_prepare_fb+0xb2/0x360 [amdgpu]
[ 7197.251025]  ? try_wait_for_completion+0x59/0x70
[ 7197.251030]  drm_atomic_helper_prepare_planes.part.0+0x2f/0x1e0
[ 7197.251035]  drm_atomic_helper_prepare_planes+0x5d/0x70
[ 7197.251037]  drm_atomic_helper_commit+0x84/0x160
[ 7197.251040]  drm_atomic_nonblocking_commit+0x59/0x70
[ 7197.251043]  drm_mode_atomic_ioctl+0x720/0x850
[ 7197.251047]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[ 7197.251049]  drm_ioctl_kernel+0xb9/0x120
[ 7197.251053]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 7197.251056]  drm_ioctl+0x2d4/0x550
[ 7197.251058]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[ 7197.251063]  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
[ 7197.251186]  __x64_sys_ioctl+0xa0/0xf0
[ 7197.251190]  x64_sys_call+0x143b/0x25c0
[ 7197.251193]  do_syscall_64+0x7f/0x180
[ 7197.251197]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 7197.251199]  ? amdgpu_display_user_framebuffer_create+0x215/0x320 [amdgpu]
[ 7197.251329]  ? drm_internal_framebuffer_create+0xb7/0x1a0
[ 7197.251332]  ? srso_alias_return_thunk+0x5/0xfbef5

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Fixes: 4a5ad08f5377 ("drm/amdgpu: Add address alignment support to DCC buffers")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7d26a962f811..ff5e52025266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -567,7 +567,6 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 		else
 			remaining_size -= size;
 	}
-	mutex_unlock(&mgr->lock);
 
 	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_size) {
 		struct drm_buddy_block *dcc_block;
@@ -584,6 +583,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 				     (u64)vres->base.size,
 				     &vres->blocks);
 	}
+	mutex_unlock(&mgr->lock);
 
 	vres->base.start = 0;
 	size = max_t(u64, amdgpu_vram_mgr_blocks_size(&vres->blocks),
-- 
2.25.1

