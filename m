Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941D0CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C4C10E8CE;
	Wed,  8 Oct 2025 18:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YopfEUR5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169A310E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzLoe9jy3fz/ZploMGYd/YIsFKg5UT9tyFE4SxYBGEDXp2hRNxuxXV4gCG7cdMtPRfW8LPOxkN9BD/1nkjgqeYUDz2VoA0XHqW/Th2g9aIoyEKyn+LepA8edmfSPrNNw2GDJzEz8Wo+5vwE1uFQBmHIYBlOGE10vWBaq2oDe7j9o9xwlnWCFDYQlol63vLYV0zwczdXDg8IY73QpXlDAzyHqWUOiwrcOqHKq8P/iyOxndUfyUarlmvzQknjKFV2I+/5fBTmmFM3T1cqdRYnQj6YbenZc2utXsRBC2FDQHVrXjvuEWmkn6wub6F4lvQYBzFRbtCE0qOP1kgdSDVh1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9Mo/fv/f9tI+r5RgUCLtkugtFLrh+QmeJcOzxQ2tvk=;
 b=ebYybGz3lnq09WE4fIhTUc/WiqINfI3z6UJeyR6boll+plis/Lhzb45mwkO/LSC6k202sHB/JXTTwUm4VWpeFL4qo6Rklf/hBtAwY9n9ah141nOH1WnQ+zfSZGNjvYgbIAvO+YhInzvlxZ0SjGsnD+yFBVe+nrsnEGeNWZbVJ7jocnz9eATGYtGL/H+N8Xip8ho5oT4gRrbOidT2RSM+wArD8FwAVwnl53tNEFRtpArb2YujGu2cNFGVthwg2qLAouIcpvM+Ew2ZAyFIfpneVGMsoFxeZZgxp5/0XqiPqKt2hsVQfWjJrLmM1iyPTpB+KVEm1gp3oWSjgLxSaBdmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9Mo/fv/f9tI+r5RgUCLtkugtFLrh+QmeJcOzxQ2tvk=;
 b=YopfEUR5BU+sDh781rccj+nycGwDbxxOK3G+dQLGF1kK89bve/292zxUY6gANRDHAYWe+CSlKmosTuI8c2rjTVTp4Txh4Kc7kunHfLRKJTrQ/QZWeM5GQrN97xiTeVqV9BlbyCz6GXhEmczh1anFnZUHnHowOKeYZUFoPINSLnw=
Received: from SJ0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:a03:33e::12)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:22 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::9f) by SJ0PR03CA0037.outlook.office365.com
 (2603:10b6:a03:33e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:53 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:53 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:52 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Fix performance regression from full
 updates
Date: Wed, 8 Oct 2025 14:47:13 -0400
Message-ID: <20251008184839.78916-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d921e9-736c-441d-abb7-08de069b6578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E2ZuBVI1hI7NQTTjuXDPkvh/6jWwU9qgImniikneAM35WprYh7G1iPjdoChJ?=
 =?us-ascii?Q?r06UdaBbUAdBOde+CDZA++trYuiBlqQmWLn7egR4FTB2dDSXdXNqhCyvHmS+?=
 =?us-ascii?Q?BvEu9gyjYC7vOayJmY2g5LetNw2m4dNhz/UI/4mbTXeShp9Y+uT782WhErEu?=
 =?us-ascii?Q?zLra1CCzzIBHtBEw2pWbdeVnes+HVhWBw8WwHGFWwSSPGm/jsEukeB8Eo3Uv?=
 =?us-ascii?Q?j7W5byPHQhB0w6gExuznlkVIXb963WBLzsWJQ/5RRNKFJMhoMsmJAxMVxKTv?=
 =?us-ascii?Q?DQCwcyUbDOl3SGlPhR88nSSkfoxQM0iQfDjNCoWu2SuyjE6CqJBRVDBKmNop?=
 =?us-ascii?Q?l44Omztk/MCgENRQhpjhrpIsIroFD77KdL8zldLjNtGqAwYbOYZ3XJi06yJ4?=
 =?us-ascii?Q?oFUn8TEWK+i+4tKfES4TiSvRRwymxLM93IOoV9Xb1qw8zLlsVbWdEXeRES5K?=
 =?us-ascii?Q?do6Ob1maBzoRHBpmYhjYiCZc7OZb2bEj02gL6PigpOYHNMpW6n3HZeg+Z967?=
 =?us-ascii?Q?0zaAEgxUBpqeboV7SZ9dp9eeBzcL3npK9kQrNFxZ2wW6xIeNdd8K9ltZ2NRJ?=
 =?us-ascii?Q?jBIF/xAbar0iABw8Ppkh1FNEARyann4aCIozKu0xAsUPlp65vdxykw9r79Cd?=
 =?us-ascii?Q?1/9rtO7KOOlFE9smNMCFzL6v0l7bv4nAI7r0X07U7TtNnKuCZM8uLtSWm+Kt?=
 =?us-ascii?Q?S97s6ylp7z/bhyTV0MiOkyVCbmxJrZWfM4mKt1ivYrjVNfEZP9bEjDHxqoMS?=
 =?us-ascii?Q?V6pHTweXtQA+7gK7NX5JjS/rW3LdLG9PJ8YE/wpNnqSUoIhzf8exlZtnGifD?=
 =?us-ascii?Q?35JwESJJdOB60nNkB7WXr+zERYvO5PpfONdeohL3rcUbAO+F/7CmNWPCbCB7?=
 =?us-ascii?Q?nC/5x5DJeEajPPojWWkarCT72TrboXKpjJd8RnyRe+7xYNNiuxa9BBCGRGba?=
 =?us-ascii?Q?4lrFUoTLuU8J0ZOKDIfqPUAkywia6uTM905YWft76+h732yT5L4TfUsi7QaQ?=
 =?us-ascii?Q?YMipoUble4VWdcMzXeLtTayFTREgmtVbW10skCuYP/GgAjay2rrOhH0NN1Qk?=
 =?us-ascii?Q?5lezOwYpksHqFVhJ7fwtY8BhRLQfv/KR/8hhsVkZinTyXvwBZA6bKUndmC2T?=
 =?us-ascii?Q?F7VaJ5FDcL3buJpTbm5ZSF/QH//eLeP0sWBDqTuVUNgimRVULQx05ZPzeC4J?=
 =?us-ascii?Q?jm4O0lB2xSWGj+s9OPAn3AiX41Wfis9Yyopnjdfw7QRFgClcHidipxeB2ewg?=
 =?us-ascii?Q?wlaMWCrmYW3t7MPDFpRbOXE+iI0Y8kdJXBPru1Q1JPl/j+c2dj1/8R3Vu03f?=
 =?us-ascii?Q?/fs4+vqMXyjZzOQXaBbbV5h9YGhyZXOdgiojD/1j/XTgla/BRzwxFGVQqvx7?=
 =?us-ascii?Q?FZR05JVBgb7na1SM62ZwXAum8T9t+K3xH2+vQvYMaG9ftljf1sPt+JhluXr/?=
 =?us-ascii?Q?1VdRyt2TplQl6o3NM20F+XvD/aoCSSKUYs78oTZdVHjdlkeHqO2d5v7g8mrl?=
 =?us-ascii?Q?BdJ+hq4BVCzt+FJUZkeWfH+fQoTMSQ420SeQAx3gkx7SwA1YECqfY6asrGyy?=
 =?us-ascii?Q?l1gFMyAtKIaxyMfZ1iI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:22.3959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d921e9-736c-441d-abb7-08de069b6578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507
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
full_update_required is too strict at update_planes_and_stream_state,
causing a performance regression due to too many updates being full.

[How]
* Carve out weak version of full_update_required for use inside
update_planes_and_stream_state.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 54 +++++++++++++++---------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 34e417a12304..36b046611d02 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3419,7 +3419,7 @@ static void update_seamless_boot_flags(struct dc *dc,
 	}
 }
 
-static bool full_update_required(struct dc *dc,
+static bool full_update_required_weak(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_update *stream_update,
@@ -3472,8 +3472,10 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	context = dc->current_state;
 	update_type = dc_check_update_surfaces_for_stream(
 			dc, srf_updates, surface_count, stream_update, stream_status);
-	if (full_update_required(dc, srf_updates, surface_count, stream_update, stream))
+
+	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
 		update_type = UPDATE_TYPE_FULL;
+
 	/* It is possible to receive a flip for one plane while there are multiple flip_immediate planes in the same stream.
 	 * E.g. Desktop and MPO plane are flip_immediate but only the MPO plane received a flip
 	 * Force the other flip_immediate planes to flip so GSL doesn't wait for a flip that won't come.
@@ -5047,18 +5049,42 @@ bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_
 	return false;
 }
 
-static bool full_update_required(struct dc *dc,
+static bool full_update_required_weak(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_update *stream_update,
 		struct dc_stream_state *stream)
 {
-
-	int i;
-	struct dc_stream_status *stream_status;
 	const struct dc_state *context = dc->current_state;
+	if (srf_updates)
+		for (int i = 0; i < surface_count; i++)
+			if (!is_surface_in_context(context, srf_updates[i].surface))
+				return true;
 
-	for (i = 0; i < surface_count; i++) {
+	if (stream) {
+		const struct dc_stream_status *stream_status = dc_stream_get_status(stream);
+		if (stream_status == NULL || stream_status->plane_count != surface_count)
+			return true;
+	}
+	if (dc->idle_optimizations_allowed)
+		return true;
+
+	if (dc_can_clear_cursor_limit(dc))
+		return true;
+
+	return false;
+}
+
+static bool full_update_required(struct dc *dc,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_update *stream_update,
+		struct dc_stream_state *stream)
+{
+	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
+		return true;
+
+	for (int i = 0; i < surface_count; i++) {
 		if (srf_updates &&
 				(srf_updates[i].plane_info ||
 				srf_updates[i].scaling_info ||
@@ -5074,8 +5100,7 @@ static bool full_update_required(struct dc *dc,
 				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
 				(srf_updates[i].cm2_params &&
 				 (srf_updates[i].cm2_params->component_settings.shaper_3dlut_setting != srf_updates[i].surface->mcm_shaper_3dlut_setting ||
-				  srf_updates[i].cm2_params->component_settings.lut1d_enable != srf_updates[i].surface->mcm_lut1d_enable)) ||
-				!is_surface_in_context(context, srf_updates[i].surface)))
+				  srf_updates[i].cm2_params->component_settings.lut1d_enable != srf_updates[i].surface->mcm_lut1d_enable))))
 			return true;
 	}
 
@@ -5111,17 +5136,6 @@ static bool full_update_required(struct dc *dc,
 			stream_update->hw_cursor_req))
 		return true;
 
-	if (stream) {
-		stream_status = dc_stream_get_status(stream);
-		if (stream_status == NULL || stream_status->plane_count != surface_count)
-			return true;
-	}
-	if (dc->idle_optimizations_allowed)
-		return true;
-
-	if (dc_can_clear_cursor_limit(dc))
-		return true;
-
 	return false;
 }
 
-- 
2.51.0

