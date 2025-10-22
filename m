Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED293CCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928D010E703;
	Wed, 22 Oct 2025 07:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KRkFivw3";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBC110E6FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUzSNvD1itPznDmP8Bf09ZfvB+C37Ihwb6Z2PVj88BbcajoUv6dpFET9Yxdf9/m54ZhTUXYbYK3Fdj4HHKx2n3XNC2k8pJh/lYguo6HvPVvK5kQ6o6YJfjiLIYoO4TZcY8p2Tn0IY+83hjY4QXSDKRsvYsjbnzFT63Bk1HIbgkLWB79L/isUmJqoFlkgLLmimc73U0gxH2BEekhmLv3LHzkzCoafGPr4CfOXj6eV9WvqNDF5DJYTJC49bJBKRrlnrUiGxgJC8ptQ0V9q0fi/2QbXZsaGsQ2bNwrcRjLa9U+yLh5k3CXbCgz/tmZn9bitASM85/wthPeqrujS8PYcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzPqb04XLrkGUGlPhKPUaCrBKIsKqJADh99juWp8ex0=;
 b=uC4Ly3DUylObk2ojVEmJd1z4TFw0fNM/mxtAKi/yIRouZjz9HWNYCeagLfqbsA0L0yWnqXAkMNLRgkxOkFrYrBwkOL62Y+vtxaAP55kY5MinVd+3fvMtXDQHH2iN1EdimB1IwZ1+2aChLS222BiVo1sZGLOS5vRuhWTrQQVptaGIwsd/CUNhE5j9JSIEP9j8+GZIa8MxI326Gg0PQ1sexT8yPlewOxSP8zM8/7ahJGexTAzBWEoyWBwylZYNXrzDGi0L5YEN/wCA/ro+OHmQhVzXyrBwVOe6m7ri3xBKgxlo6y7vEEXCzfPdtfGV5L96vIvczJ6oJGUCTQ8RTLeZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzPqb04XLrkGUGlPhKPUaCrBKIsKqJADh99juWp8ex0=;
 b=KRkFivw3HvKue+XdLurlLVyNuT0WWlEXR7g5HwpOcfHj9TXiUsWRWd90URmCe+6DCvU3AJOP7s3WuJb20ERmJGx/j4koIdB1zDjSB6XMLIeQQTL4VHgwcHE2rcUsYKcZt4dqbCwU3S+2mK6aKP20b/OWD2EkvISOhoa3T1sK5Os=
Received: from DM6PR04CA0029.namprd04.prod.outlook.com (2603:10b6:5:334::34)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:35:18 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::de) by DM6PR04CA0029.outlook.office365.com
 (2603:10b6:5:334::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:35:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:04 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:35:01 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 15/20] drm/amd/display: Add lock descriptor to check_update
Date: Wed, 22 Oct 2025 15:30:27 +0800
Message-ID: <20251022073332.666119-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c52273-6439-4a9f-ac01-08de113d8bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYKLcrYw5GA67Ms+EO62COb6N6uKK5aIfxYQBTcxMIaJrciMyX3HQKlAR/JK?=
 =?us-ascii?Q?iPE0bnknImQuSg9yeHFumtrX9f7AF87qydo5V/SeWFoA59T4EfXAS8xFbz5C?=
 =?us-ascii?Q?Ko/NCLhcekc5efk8W1bJONj91djcs7MtqLulb1nIKDT9KcWB5PMOhuZzVXFJ?=
 =?us-ascii?Q?9uBsEJED/N/C86ud/IU/IKFtwpReX90BGZcWE1N6QgANlM8p3BPP4Br3e6cr?=
 =?us-ascii?Q?JzTVSIgLi+Uhuw6r5v6gGBW8xQhxzyW18ABIE0OglgIDgKiTGZsXIA/KUrEo?=
 =?us-ascii?Q?X998s4nfLKmEdUui7iYaWy4gd3p2oD2+SpmwKTQLEl/p60EB8UMfp1CwIWwa?=
 =?us-ascii?Q?8+9nzwGTk6qGUFJWidC//6Syf2AuBytYcqCqGWJvlcY3m479zD6HYlyiuxIO?=
 =?us-ascii?Q?IU5uqMFAKx2/CFi6gVNJenAVu9uBXgqnZuaxrck53w84EbvQu34vsF3eOa1w?=
 =?us-ascii?Q?R9rLSNsWaXJ/q2nCITJ5ewWX4MOHrcsE43d5WwXrdsht0Ps/kDz2jhOkx7uP?=
 =?us-ascii?Q?cPmX9xAY8kn0JGGDZ/8Ig64OCJ55AS1uxXeUgfQ+2kzkdDo9pHqwKWwmkplK?=
 =?us-ascii?Q?lxIYNt5EnmYcWmlsCGt13EGhrxmLnQ6ZA6ZsZZlVHJQ0ibiNnUsgVMAt857l?=
 =?us-ascii?Q?6EYZjDkkxafc4kB218UqW10cxitdqj7EfHqd/I54UoYPpzmh2OFprBmhPN4h?=
 =?us-ascii?Q?oVTwWUJSOhe0w87wepkywS98+YHxaIH/0THS9/haxkAgdCidMnjqtHw7XpKF?=
 =?us-ascii?Q?g2ZsufJSUkbFm3hbL1YaAch7QD5VjoihMkorpiX7/u0JX6zrXJVWmdEgO2ii?=
 =?us-ascii?Q?1+GC5l9lirz0WUpoldRIqrJUvoILYynn1lcREXmoZy2dffggNhzM7+j6fEnj?=
 =?us-ascii?Q?lCFDaRPoD3smryy7fP3v+Xtb9cJDnz3I3ZSsRTgHVo19xZYtf3JOKD7jv6u9?=
 =?us-ascii?Q?BbMc/5PGPoEDOvO24VSEaPXE/NlhVqhIDMu4G3rYJlckaYTE8h4CgLY1sFrc?=
 =?us-ascii?Q?hw77p0mECLKs+4r2qwn66fbfESvoLxO7saetLFfvTybO0p/6wP/nbhDGlReh?=
 =?us-ascii?Q?1m1upcChdYE46bQaIz5r1MPgeaKyM8mjx1XBvejQ5+rm2LxWwfX3+/PUkPdN?=
 =?us-ascii?Q?EjSJub/18GKqY4Lp7oLO5uilXXg0v+7M+7BjFcyoBO4EhH4JoqlZMxIvsmw5?=
 =?us-ascii?Q?gsG8WwmPMYiMKclPn6tb3V6Rub8FyGryPgRRdM+1Yrstr5JaaPwoqc/PekE9?=
 =?us-ascii?Q?p+YGW/EKp8kLvRYk4v7sdnolOklwQmjOMt6L2AD7ZHGiZpURqG+EU0dj6wZ6?=
 =?us-ascii?Q?gT13PS9psW40zq0yL7HN7wGrGlzrFFG8FvJlwK+7OwBTAGeoy3UPvMb2Dhiy?=
 =?us-ascii?Q?QzIrUBKZSeag7KzkN2FYLdzdGmPn+VP50KAgVUFKHFjirwCmNJ3m7e373++b?=
 =?us-ascii?Q?3eav6ZfPu1ogvhlwEVolJZvzc7z8in2kmRqqMG1MtcTe56d3ZKoK0dVEiIgd?=
 =?us-ascii?Q?ekdMCbC/Y8EO/PGnQsNf/r5NYo7U7/PTTh5fWXz2tOaCOhRRuSONtrYYLzyR?=
 =?us-ascii?Q?mmU57J1Y2Fe/hv6dPsH5QuVsA7tUPran05B6Y9gk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:35:17.0612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c52273-6439-4a9f-ac01-08de113d8bec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
DM locks the global DC lock during all updates, even if multiple
updates touch different resources and could be run in parallel.

[How]
Add extra enum specifying which kind of resources should be locked.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 125 +++++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h        |  13 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h |   2 +-
 3 files changed, 82 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6ef9dd9ab7a3..1851a35f629f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -148,10 +148,16 @@ static const char DC_BUILD_ID[] = "production-build";
 
 /* Private functions */
 
-static inline void elevate_update_type(enum surface_update_type *original, enum surface_update_type new)
+static inline void elevate_update_type(
+		struct surface_update_descriptor *descriptor,
+		enum surface_update_type new_type,
+		enum dc_lock_descriptor new_locks
+)
 {
-	if (new > *original)
-		*original = new;
+	if (new_type > descriptor->update_type)
+		descriptor->update_type = new_type;
+
+	descriptor->lock_descriptor |= new_locks;
 }
 
 static void destroy_links(struct dc *dc)
@@ -2656,47 +2662,49 @@ static bool is_surface_in_context(
 	return false;
 }
 
-static enum surface_update_type get_plane_info_update_type(const struct dc_surface_update *u)
+static struct surface_update_descriptor get_plane_info_update_type(const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
-	enum surface_update_type update_type = UPDATE_TYPE_FAST;
+	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->plane_info)
-		return UPDATE_TYPE_FAST;
+		return update_type;
+
+	elevate_update_type(&update_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_PLANE);
 
 	if (u->plane_info->color_space != u->surface->color_space) {
 		update_flags->bits.color_space_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->horizontal_mirror != u->surface->horizontal_mirror) {
 		update_flags->bits.horizontal_mirror_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->rotation != u->surface->rotation) {
 		update_flags->bits.rotation_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->format != u->surface->format) {
 		update_flags->bits.pixel_format_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->stereo_format != u->surface->stereo_format) {
 		update_flags->bits.stereo_format_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->per_pixel_alpha != u->surface->per_pixel_alpha) {
 		update_flags->bits.per_pixel_alpha_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->global_alpha_value != u->surface->global_alpha_value) {
 		update_flags->bits.global_alpha_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->dcc.enable != u->surface->dcc.enable
@@ -2708,7 +2716,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 		 * recalculate stutter period.
 		 */
 		update_flags->bits.dcc_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (resource_pixel_format_to_bpp(u->plane_info->format) !=
@@ -2717,33 +2725,33 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 		 * and DML calculation
 		 */
 		update_flags->bits.bpp_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
 			|| u->plane_info->plane_size.chroma_pitch != u->surface->plane_size.chroma_pitch) {
 		update_flags->bits.plane_size_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 	}
 
 	const struct dc_tiling_info *tiling = &u->plane_info->tiling_info;
 
 	if (memcmp(tiling, &u->surface->tiling_info, sizeof(*tiling)) != 0) {
 		update_flags->bits.swizzle_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 
 		switch (tiling->gfxversion) {
 		case DcGfxVersion9:
 		case DcGfxVersion10:
 		case DcGfxVersion11:
 			if (tiling->gfx9.swizzle != DC_SW_LINEAR) {
-				elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 				update_flags->bits.bandwidth_change = 1;
 			}
 			break;
 		case DcGfxAddr3:
 			if (tiling->gfx_addr3.swizzle != DC_ADDR3_SW_LINEAR) {
-				elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 				update_flags->bits.bandwidth_change = 1;
 			}
 			break;
@@ -2759,14 +2767,17 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 	return update_type;
 }
 
-static enum surface_update_type get_scaling_info_update_type(
+static struct surface_update_descriptor get_scaling_info_update_type(
 		const struct dc_check_config *check_config,
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
+	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->scaling_info)
-		return UPDATE_TYPE_FAST;
+		return update_type;
+
+	elevate_update_type(&update_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_PLANE);
 
 	if (u->scaling_info->src_rect.width != u->surface->src_rect.width
 			|| u->scaling_info->src_rect.height != u->surface->src_rect.height
@@ -2809,40 +2820,41 @@ static enum surface_update_type get_scaling_info_update_type(
 	if (update_flags->bits.clock_change
 			|| update_flags->bits.bandwidth_change
 			|| update_flags->bits.scaling_change)
-		return UPDATE_TYPE_FULL;
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 
 	if (update_flags->bits.position_change)
-		return UPDATE_TYPE_MED;
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 
-	return UPDATE_TYPE_FAST;
+	return update_type;
 }
 
-static enum surface_update_type det_surface_update(
+static struct surface_update_descriptor det_surface_update(
 		const struct dc_check_config *check_config,
-		const struct dc_surface_update *u)
+		struct dc_surface_update *u)
 {
-	enum surface_update_type type;
-	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
+	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 
 	if (u->surface->force_full_update) {
 		update_flags->raw = 0xFFFFFFFF;
-		return UPDATE_TYPE_FULL;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		return overall_type;
 	}
 
 	update_flags->raw = 0; // Reset all flags
 
-	type = get_plane_info_update_type(u);
-	elevate_update_type(&overall_type, type);
+	struct surface_update_descriptor inner_type = get_plane_info_update_type(u);
 
-	type = get_scaling_info_update_type(check_config, u);
-	elevate_update_type(&overall_type, type);
+	elevate_update_type(&overall_type, inner_type.update_type, inner_type.lock_descriptor);
+
+	inner_type = get_scaling_info_update_type(check_config, u);
+	elevate_update_type(&overall_type, inner_type.update_type, inner_type.lock_descriptor);
 
 	if (u->flip_addr) {
 		update_flags->bits.addr_update = 1;
 		if (u->flip_addr->address.tmz_surface != u->surface->address.tmz_surface) {
 			update_flags->bits.tmz_changed = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 		}
 	}
 	if (u->in_transfer_func)
@@ -2878,13 +2890,15 @@ static enum surface_update_type det_surface_update(
 	if (u->hdr_mult.value)
 		if (u->hdr_mult.value != u->surface->hdr_mult.value) {
 			update_flags->bits.hdr_mult = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_MED);
+			// TODO: Should be fast?
+			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 		}
 
 	if (u->sdr_white_level_nits)
 		if (u->sdr_white_level_nits != u->surface->sdr_white_level_nits) {
 			update_flags->bits.sdr_white_level_nits = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
+			// TODO: Should be fast?
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 		}
 
 	if (u->cm2_params) {
@@ -2898,18 +2912,16 @@ static enum surface_update_type det_surface_update(
 			update_flags->bits.mcm_transfer_function_enable_change = 1;
 	}
 	if (update_flags->bits.in_transfer_func_change) {
-		type = UPDATE_TYPE_MED;
-		elevate_update_type(&overall_type, type);
+		// TODO: Fast?
+		elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (update_flags->bits.lut_3d &&
 			u->surface->mcm_luts.lut3d_data.lut3d_src != DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
-		type = UPDATE_TYPE_FULL;
-		elevate_update_type(&overall_type, type);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 	if (update_flags->bits.mcm_transfer_function_enable_change) {
-		type = UPDATE_TYPE_FULL;
-		elevate_update_type(&overall_type, type);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (check_config->enable_legacy_fast_update &&
@@ -2917,8 +2929,7 @@ static enum surface_update_type det_surface_update(
 			update_flags->bits.gamut_remap_change ||
 			update_flags->bits.input_csc_change ||
 			update_flags->bits.coeff_reduction_change)) {
-		type = UPDATE_TYPE_FULL;
-		elevate_update_type(&overall_type, type);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 	return overall_type;
 }
@@ -2946,28 +2957,28 @@ static void force_immediate_gsl_plane_flip(struct dc *dc, struct dc_surface_upda
 	}
 }
 
-static enum surface_update_type check_update_surfaces_for_stream(
+static struct surface_update_descriptor check_update_surfaces_for_stream(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
-		struct dc_stream_update *stream_update
-)
+		struct dc_stream_update *stream_update)
 {
-	int i;
-	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
+	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (stream_update && stream_update->pending_test_pattern) {
-		overall_type = UPDATE_TYPE_FULL;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	if (stream_update && stream_update->hw_cursor_req) {
-		overall_type = UPDATE_TYPE_FULL;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 	}
 
 	/* some stream updates require passive update */
 	if (stream_update) {
 		union stream_update_flags *su_flags = &stream_update->stream->update_flags;
 
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+
 		if ((stream_update->src.height != 0 && stream_update->src.width != 0) ||
 			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
 			stream_update->integer_scaling_update)
@@ -3009,7 +3020,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 			su_flags->bits.out_csc = 1;
 
 		if (su_flags->raw != 0)
-			overall_type = UPDATE_TYPE_FULL;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 
 		if (stream_update->output_csc_transform)
 			su_flags->bits.out_csc = 1;
@@ -3021,11 +3032,11 @@ static enum surface_update_type check_update_surfaces_for_stream(
 			su_flags->bits.out_tf = 1;
 	}
 
-	for (i = 0 ; i < surface_count; i++) {
-		enum surface_update_type type =
+	for (int i = 0 ; i < surface_count; i++) {
+		struct surface_update_descriptor inner_type =
 				det_surface_update(check_config, &updates[i]);
 
-		elevate_update_type(&overall_type, type);
+		elevate_update_type(&overall_type, inner_type.update_type, inner_type.lock_descriptor);
 	}
 
 	return overall_type;
@@ -3036,7 +3047,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
  *
  * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
  */
-enum surface_update_type dc_check_update_surfaces_for_stream(
+struct surface_update_descriptor dc_check_update_surfaces_for_stream(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
@@ -3468,7 +3479,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 	context = dc->current_state;
 	update_type = dc_check_update_surfaces_for_stream(
-			&dc->check_config, srf_updates, surface_count, stream_update);
+			&dc->check_config, srf_updates, surface_count, stream_update).update_type;
 	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
 		update_type = UPDATE_TYPE_FULL;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 82ce1fbec7d8..f302d57f7ba8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -467,6 +467,19 @@ enum surface_update_type {
 	UPDATE_TYPE_FULL, /* may need to shuffle resources */
 };
 
+enum dc_lock_descriptor {
+	LOCK_DESCRIPTOR_NONE = 0x0,
+	LOCK_DESCRIPTOR_STATE = 0x1,
+	LOCK_DESCRIPTOR_LINK = 0x2,
+	LOCK_DESCRIPTOR_STREAM = 0x4,
+	LOCK_DESCRIPTOR_PLANE = 0x8,
+};
+
+struct surface_update_descriptor {
+	enum surface_update_type update_type;
+	enum dc_lock_descriptor lock_descriptor;
+};
+
 /* Forward declaration*/
 struct dc;
 struct dc_plane_state;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index c68153c77972..75869eed1d3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -473,7 +473,7 @@ void dc_enable_stereo(
 /* Triggers multi-stream synchronization. */
 void dc_trigger_sync(struct dc *dc, struct dc_state *context);
 
-enum surface_update_type dc_check_update_surfaces_for_stream(
+struct surface_update_descriptor dc_check_update_surfaces_for_stream(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
-- 
2.43.0

