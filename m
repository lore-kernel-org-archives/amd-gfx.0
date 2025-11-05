Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26084CCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985AC10E2D0;
	Wed,  5 Nov 2025 15:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F7otXlqd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A8410E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYaYLl8y10ynm9fZxyOuRe1E+HIoVEWdvj4btw4Ib/83opO3YqTXnQXqCnKG8UWKPizBN/FNh7PEWVPDb4JhJ0JRxO5esirrj9juDyOZgtbkAhJBOhF50Kewtlx8qsZ25kEDifJBXF6nhpUTwzpnqGOXdobf3yj3Ym9lYZeaZxrz+i6f5EAcNlhx5ptiTEneokIfAyS6btNWzI88muFqZyA/fF0GbujLD1p4TN/kiTDnzuuHJny2LK+f9AGhdDXfjnjgpXm06N+uwNq53cbXrvdfGnHMu55GUmWl6Z3jhS7TzJso6ge7vJHfowOoQcr1TPivVBppIy6I5JmskLe5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z1hfYH/KUgiVVjF4RwSf7qc7j6aKQx+dcECktG7QVY=;
 b=GYrfOCB91gQgMLqqT/oQobNFvuj/NVMDAuA2iiSIevXXCAPhKZp3mT7Xx+HnWwNbVk6GFRyYSwQKAn0iMKUDAjx36GRS7MLw7DqpptwoOMI6uaA7pE2DSm4YC2QN2+tox5K5507r/ThPYByR/WmjlaXgfCAQJClonswUfteIvGn5FZsJnaGA57leFlHTGijbvzsi23Bjr9lrgKn6Oa/a049zsTQQM5AHLSd1U3iB9N6xag/PqB67J7CPQWqNUWf9gozCOD4smdS3iM8ZbCRYAh1ZmeucWqdzcbCgE9gQY8+nKEgrLRdw+n5O87+f3s+FYBBWJtsSDZQ6lrR8CJLqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z1hfYH/KUgiVVjF4RwSf7qc7j6aKQx+dcECktG7QVY=;
 b=F7otXlqdO6aDRPf8C5yNjFEjIiLkdm6s/HxP17c7rseEJKrEb0/qHudyPjyQWr+mkCFs5R0Dsam0FjTGr4schCg6Ckk9YUR3n9Pvol5K7XcXpCpDd8nrfpXTZ9VLziCpb9SfSKc2fA7QCytkDHz7IzwE4AJ0KomEgIOY9UVU75U=
Received: from BN1PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:e0::11)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:41:04 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::38) by BN1PR10CA0006.outlook.office365.com
 (2603:10b6:408:e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:55 -0800
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:54 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Change lock descriptor values
Date: Wed, 5 Nov 2025 10:36:22 -0500
Message-ID: <20251105154035.883188-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: e813afa6-adc7-47e7-71cb-08de1c81bac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJFeyVs9VTegXb1zD4MfJ5DgOuLcrzornE9msnpuD6Us0rKZOOeMj14A28S2?=
 =?us-ascii?Q?eq9odXJf7WqaVNjtIL09k9veEkIMzv/3RZSuOpuXYNfSGf9wRNbK3wAYC2aC?=
 =?us-ascii?Q?C3OsdLkEw5hXso/5CxF8a0uRMsiV0xMaKgKtYb27+C4MU8tJiVsGuPKWO+E+?=
 =?us-ascii?Q?Rz5MjC5JrUReein46Nnfv0YcSl88E33OyPLY9tys/hZPR4gPl9vPobO+VA2p?=
 =?us-ascii?Q?EgVgU8Me+pWLCEoauO6Er6nbs6vPL1xWiyayY0peaOyfi+115bvO7wUNJ4kz?=
 =?us-ascii?Q?nG8+xjv6OiP+Rj3qlDfZsVxv8WWyz5h1oSRn15oqXvaWS4DXJwYq6Ho/ljRn?=
 =?us-ascii?Q?nSE7bou0IO9Wo4a0RotO4FrE8jkiNI5D+kGRF27rz4myrRxTiTDMpnO7CtZg?=
 =?us-ascii?Q?X/1xAs/3jrrxWeV53UMXoZ+PkJWUY54gFD9W/2iX/BC9vE29O8KisQOAki4F?=
 =?us-ascii?Q?0CfGJoNMIlbJYVpNXme89FqEDcIR1eeUO+hRUfeHagZ/R40cz4xBmpP31Sah?=
 =?us-ascii?Q?QByQ+No2J18QfluhPJdnaj+PoT4Mo2I8rjiKp7GwGkE2ogItrXRAKEHUEAJh?=
 =?us-ascii?Q?pS4vsMch/1okyvKi1YfdVpCxAR9YkFyiTlsMdJXp6h2FppLhLlOG81/7QKKo?=
 =?us-ascii?Q?kMJKXgVSAAtXCScAFXtZrj7qVAjPgJexAb0YD7UIy0p54GCCMAEQU4Bog9xW?=
 =?us-ascii?Q?9Evbp7n9FS8mHZuvqguF4gYw2+5Rk8L1BcARdoLy7GkDR2fi/6vILvlMUCzq?=
 =?us-ascii?Q?XXtT7yAuB0eXEviaJxnbJh90jyP92jfY7I9+SZcnosLned4vjSsZayEU6b/G?=
 =?us-ascii?Q?ZCr00uKQD1tD/BJgQFq1z81zrxYpPw62uzMch5xtXzwLQnFbm2kll41iOB4D?=
 =?us-ascii?Q?sLgi6CZ2xQtnnCb3eA68EqUMG+P2PTsz8TWh8FH1Zhhd7GHqaWyeeC+x+e9j?=
 =?us-ascii?Q?8tGlyjGvT6A8pHcjSt2pdMBjBg87Fq6dJKoCQlSuEZrMLzvt9lK7jGE1wjKq?=
 =?us-ascii?Q?pvZZZvMSK8XnyvkUJArLqO+TCfGyJRZCKOd9XqqomDW6L7H6yOeEWl4n2Kfw?=
 =?us-ascii?Q?9JH4kVQPiuXgTP5ETkNcTP/UGWGHH8LGo1Jde2jkVh/1XRctXDt0J1YDwYtE?=
 =?us-ascii?Q?j+IxMe0ezeh0KuwwbR8GLWJxM7v3lFBIC8ZGQXUYDr6J/HYrvPZbcfHP3U72?=
 =?us-ascii?Q?yPGe9buRPkmaxTUjob7OD6uS6JjsuZevMagR1FayylOp/aMj4b9EbocA6a8w?=
 =?us-ascii?Q?r4PTb1mz88uL1FqRSenjuFBhkZAIx/nwQl3MFaYnq7+8ZQIvj2zGMnYrxbf3?=
 =?us-ascii?Q?ImnyQWo2pSYOy2N8R3mNEIMOQRmBp0reNW6dyfTyZ+Ntx5U/eb86X/Ag40dg?=
 =?us-ascii?Q?6HZXbmVX9YT4IO/9G4kFDYsC1BBK4eulxPizau3G90s4M/8bKImoDEoOuQkR?=
 =?us-ascii?Q?SEBAQe7fmp6jbMG3CXuVgjLTiVto45ZkJOiLGr9infTiI7n1FqX8z1lC9kKI?=
 =?us-ascii?Q?YIY4jGfGGXjSRjcYkJzWkLddw9I+DGdmmJdXo9xOUGV9osj4v3Env7tKGCDo?=
 =?us-ascii?Q?xXnzIdaxKogbqsBKpP8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:04.2758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e813afa6-adc7-47e7-71cb-08de1c81bac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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
Review of usage scenarios requires dc_lock_descriptor modification.

[How]
Replace STATE/LINK/STREAM/PLANE with GLOBAL/STREAM/LINK, where
the first means all streams to be locked.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 146 +++++++++++------------
 drivers/gpu/drm/amd/display/dc/dc.h      |   5 +-
 2 files changed, 72 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3999b5835066..819c08b59d4e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2670,41 +2670,42 @@ static struct surface_update_descriptor get_plane_info_update_type(const struct
 	if (!u->plane_info)
 		return update_type;
 
-	elevate_update_type(&update_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_PLANE);
+	// `plane_info` present means at least `STREAM` lock is required
+	elevate_update_type(&update_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 
 	if (u->plane_info->color_space != u->surface->color_space) {
 		update_flags->bits.color_space_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->plane_info->horizontal_mirror != u->surface->horizontal_mirror) {
 		update_flags->bits.horizontal_mirror_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->plane_info->rotation != u->surface->rotation) {
 		update_flags->bits.rotation_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (u->plane_info->format != u->surface->format) {
 		update_flags->bits.pixel_format_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (u->plane_info->stereo_format != u->surface->stereo_format) {
 		update_flags->bits.stereo_format_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (u->plane_info->per_pixel_alpha != u->surface->per_pixel_alpha) {
 		update_flags->bits.per_pixel_alpha_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->plane_info->global_alpha_value != u->surface->global_alpha_value) {
 		update_flags->bits.global_alpha_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->plane_info->dcc.enable != u->surface->dcc.enable
@@ -2716,7 +2717,7 @@ static struct surface_update_descriptor get_plane_info_update_type(const struct
 		 * recalculate stutter period.
 		 */
 		update_flags->bits.dcc_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (resource_pixel_format_to_bpp(u->plane_info->format) !=
@@ -2725,34 +2726,34 @@ static struct surface_update_descriptor get_plane_info_update_type(const struct
 		 * and DML calculation
 		 */
 		update_flags->bits.bpp_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (u->plane_info->plane_size.surface_pitch != u->surface->plane_size.surface_pitch
 			|| u->plane_info->plane_size.chroma_pitch != u->surface->plane_size.chroma_pitch) {
 		update_flags->bits.plane_size_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	const struct dc_tiling_info *tiling = &u->plane_info->tiling_info;
 
 	if (memcmp(tiling, &u->surface->tiling_info, sizeof(*tiling)) != 0) {
 		update_flags->bits.swizzle_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 
 		switch (tiling->gfxversion) {
 		case DcGfxVersion9:
 		case DcGfxVersion10:
 		case DcGfxVersion11:
 			if (tiling->gfx9.swizzle != DC_SW_LINEAR) {
-				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 				update_flags->bits.bandwidth_change = 1;
+				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 			}
 			break;
 		case DcGfxAddr3:
 			if (tiling->gfx_addr3.swizzle != DC_ADDR3_SW_LINEAR) {
-				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
 				update_flags->bits.bandwidth_change = 1;
+				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 			}
 			break;
 		case DcGfxVersion7:
@@ -2777,7 +2778,8 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 	if (!u->scaling_info)
 		return update_type;
 
-	elevate_update_type(&update_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_PLANE);
+	// `scaling_info` present means at least `STREAM` lock is required
+	elevate_update_type(&update_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 
 	if (u->scaling_info->src_rect.width != u->surface->src_rect.width
 			|| u->scaling_info->src_rect.height != u->surface->src_rect.height
@@ -2788,6 +2790,7 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 			|| u->scaling_info->scaling_quality.integer_scaling !=
 					u->surface->scaling_quality.integer_scaling) {
 		update_flags->bits.scaling_change = 1;
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 
 		if (u->scaling_info->src_rect.width > u->surface->src_rect.width
 				|| u->scaling_info->src_rect.height > u->surface->src_rect.height)
@@ -2813,17 +2816,10 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 			|| u->scaling_info->clip_rect.x != u->surface->clip_rect.x
 			|| u->scaling_info->clip_rect.y != u->surface->clip_rect.y
 			|| u->scaling_info->dst_rect.x != u->surface->dst_rect.x
-			|| u->scaling_info->dst_rect.y != u->surface->dst_rect.y)
+			|| u->scaling_info->dst_rect.y != u->surface->dst_rect.y) {
+		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 		update_flags->bits.position_change = 1;
-
-	/* process every update flag before returning */
-	if (update_flags->bits.clock_change
-			|| update_flags->bits.bandwidth_change
-			|| update_flags->bits.scaling_change)
-		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
-
-	if (update_flags->bits.position_change)
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+	}
 
 	return update_type;
 }
@@ -2837,7 +2833,7 @@ static struct surface_update_descriptor det_surface_update(
 
 	if (u->surface->force_full_update) {
 		update_flags->raw = 0xFFFFFFFF;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 		return overall_type;
 	}
 
@@ -2852,76 +2848,69 @@ static struct surface_update_descriptor det_surface_update(
 
 	if (u->flip_addr) {
 		update_flags->bits.addr_update = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+
 		if (u->flip_addr->address.tmz_surface != u->surface->address.tmz_surface) {
 			update_flags->bits.tmz_changed = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 		}
 	}
-	if (u->in_transfer_func)
+	if (u->in_transfer_func) {
 		update_flags->bits.in_transfer_func_change = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+	}
 
-	if (u->input_csc_color_matrix)
+	if (u->input_csc_color_matrix) {
 		update_flags->bits.input_csc_change = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+	}
 
-	if (u->coeff_reduction_factor)
+	if (u->coeff_reduction_factor) {
 		update_flags->bits.coeff_reduction_change = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+	}
 
-	if (u->gamut_remap_matrix)
+	if (u->gamut_remap_matrix) {
 		update_flags->bits.gamut_remap_change = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+	}
 
-	if (u->blend_tf)
+	if (u->blend_tf || (u->gamma && dce_use_lut(u->plane_info ? u->plane_info->format : u->surface->format))) {
 		update_flags->bits.gamma_change = 1;
-
-	if (u->gamma) {
-		enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_BEGIN;
-
-		if (u->plane_info)
-			format = u->plane_info->format;
-		else
-			format = u->surface->format;
-
-		if (dce_use_lut(format))
-			update_flags->bits.gamma_change = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
-	if (u->lut3d_func || u->func_shaper)
+	if (u->lut3d_func || u->func_shaper) {
 		update_flags->bits.lut_3d = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+	}
 
 	if (u->hdr_mult.value)
 		if (u->hdr_mult.value != u->surface->hdr_mult.value) {
-			update_flags->bits.hdr_mult = 1;
 			// TODO: Should be fast?
-			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+			update_flags->bits.hdr_mult = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 		}
 
 	if (u->sdr_white_level_nits)
 		if (u->sdr_white_level_nits != u->surface->sdr_white_level_nits) {
-			update_flags->bits.sdr_white_level_nits = 1;
 			// TODO: Should be fast?
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+			update_flags->bits.sdr_white_level_nits = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 		}
 
 	if (u->cm2_params) {
-		if ((u->cm2_params->component_settings.shaper_3dlut_setting
-					!= u->surface->mcm_shaper_3dlut_setting)
-				|| (u->cm2_params->component_settings.lut1d_enable
-					!= u->surface->mcm_lut1d_enable))
-			update_flags->bits.mcm_transfer_function_enable_change = 1;
-		if (u->cm2_params->cm2_luts.lut3d_data.lut3d_src
-				!= u->surface->mcm_luts.lut3d_data.lut3d_src)
+		if (u->cm2_params->component_settings.shaper_3dlut_setting != u->surface->mcm_shaper_3dlut_setting
+				|| u->cm2_params->component_settings.lut1d_enable != u->surface->mcm_lut1d_enable
+				|| u->cm2_params->cm2_luts.lut3d_data.lut3d_src != u->surface->mcm_luts.lut3d_data.lut3d_src) {
 			update_flags->bits.mcm_transfer_function_enable_change = 1;
-	}
-	if (update_flags->bits.in_transfer_func_change) {
-		// TODO: Fast?
-		elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STATE);
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+		}
 	}
 
 	if (update_flags->bits.lut_3d &&
 			u->surface->mcm_luts.lut3d_data.lut3d_src != DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
-	}
-	if (update_flags->bits.mcm_transfer_function_enable_change) {
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (check_config->enable_legacy_fast_update &&
@@ -2929,7 +2918,7 @@ static struct surface_update_descriptor det_surface_update(
 			update_flags->bits.gamut_remap_change ||
 			update_flags->bits.input_csc_change ||
 			update_flags->bits.coeff_reduction_change)) {
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 	return overall_type;
 }
@@ -2966,19 +2955,19 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
 	if (stream_update && stream_update->pending_test_pattern) {
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (stream_update && stream_update->hw_cursor_req) {
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	/* some stream updates require passive update */
 	if (stream_update) {
-		union stream_update_flags *su_flags = &stream_update->stream->update_flags;
-
 		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 
+		union stream_update_flags *su_flags = &stream_update->stream->update_flags;
+
 		if ((stream_update->src.height != 0 && stream_update->src.width != 0) ||
 			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
 			stream_update->integer_scaling_update)
@@ -2990,8 +2979,10 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 		if (stream_update->abm_level)
 			su_flags->bits.abm_level = 1;
 
-		if (stream_update->dpms_off)
+		if (stream_update->dpms_off) {
 			su_flags->bits.dpms_off = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL | LOCK_DESCRIPTOR_LINK);
+		}
 
 		if (stream_update->gamut_remap)
 			su_flags->bits.gamut_remap = 1;
@@ -3019,17 +3010,20 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 		if (stream_update->output_color_space)
 			su_flags->bits.out_csc = 1;
 
-		if (su_flags->raw != 0)
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STATE);
+		// TODO: Make each elevation explicit, as to not override fast stream in crct_timing_adjust
+		if (su_flags->raw)
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 
-		if (stream_update->output_csc_transform)
+		// Non-global cases
+		if (stream_update->output_csc_transform) {
 			su_flags->bits.out_csc = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
 
-		/* Output transfer function changes do not require bandwidth recalculation,
-		 * so don't trigger a full update
-		 */
-		if (!check_config->enable_legacy_fast_update && stream_update->out_transfer_func)
+		if (!check_config->enable_legacy_fast_update && stream_update->out_transfer_func) {
 			su_flags->bits.out_tf = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c501e12706d..db43e6975675 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -469,10 +469,9 @@ enum surface_update_type {
 
 enum dc_lock_descriptor {
 	LOCK_DESCRIPTOR_NONE = 0x0,
-	LOCK_DESCRIPTOR_STATE = 0x1,
+	LOCK_DESCRIPTOR_STREAM = 0x1,
 	LOCK_DESCRIPTOR_LINK = 0x2,
-	LOCK_DESCRIPTOR_STREAM = 0x4,
-	LOCK_DESCRIPTOR_PLANE = 0x8,
+	LOCK_DESCRIPTOR_GLOBAL = 0x4,
 };
 
 struct surface_update_descriptor {
-- 
2.43.0

