Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82604CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3651610E9A9;
	Thu,  3 Oct 2024 23:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7kbjx5E";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC1110E9A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdc72m9LBUo4GlhBuMysO26y8sA9EWxdMxyjU5M47lAUGEXQFNMdny+CiAOJbr5UfRUodjN/vcbdmhQBNm8WkOsP7hxwy/tbIN+tzANx9wtDsgKn4D2ap2IWy/zUyQOYP4pbc761bHY6buKo4bSiJnSyvOnr3VECicl/KakdQOK0CwgIbdd4JSAssrd+lKvqlUln5SZrEJaOTFqPza45ajHP29UraV129VOmYJYOicSXygHzquEsUkOLLOB3atoUWs3adTcrBCh2m4Xw13LpX1rkwQd0F3Rc3rhBaQa8dmYRM5eNjcqhGrTD+jfcd26wzIWReQfkXU3Rt1vGikP6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4nGuBq2WVVbdhpugmic3EGXoRyXutWNgsonD+LW2A4=;
 b=lmjr7bol0Qk/lhVsZ8EZEBssp3HudQ9vwwHbM0pLlqilQ5IYdSxo52cqsFa3qFVFzhT//iufJi00rlZ020wUrh3qguRZd/cnoKE0BReG4vlP3qDTSqIYzAGeDttoQ/nfMzGTBM5czrpCF3quNiEwrVIjfaBkiMgracCN7Re1gzWOV9J4bQSal2GXZS0qlMK/YFxuIY8U/ZyNR/wUc+sWIMrcZWqjjZktJy7Ci8hmw+/CN8Njfj2SNENjxwMinKqD8Bgs6lmxFnWnubLLydZUGbsD4+MGh0qYjuO8XnUeCj3uVlqzU22P4q6JG/aJEtY/JknHblB9rEQEU1pTPwtfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4nGuBq2WVVbdhpugmic3EGXoRyXutWNgsonD+LW2A4=;
 b=k7kbjx5EgX/IK2Nf38wg66UH3abTuvySRlMmDTvkquwKGAqGvuSbi3JFHTUhU2dGM5qiE88FpCzNtvbPqW4di925S4BoXkWWX9oXmLLgfpsdaha0pve/hQDJBzPJxnzrBpXM1cxwWzIt+gfPmzOEKDLFTatSLr7ok/S28urbyn8=
Received: from PH3PEPF000040A3.namprd05.prod.outlook.com (2603:10b6:518:1::57)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:36:00 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A3.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.10 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:59 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Josip Pavic <Josip.Pavic@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 13/26] drm/amd/display: Clear update flags after update has
 been applied
Date: Thu, 3 Oct 2024 17:33:31 -0600
Message-ID: <20241003233509.210919-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0eced6-87dd-4e73-ffc4-08dce40422f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bE3t+sXxlOvRpB28IDej80PrbA6S95VqQsbPvcJYlxui0WX3TpWiEWs6JZ85?=
 =?us-ascii?Q?mdaRhSPrZ7xJRo15RlGk5g1Da/NcbBwZwoyOi9cuonxLW4J8N644kaSLAe1L?=
 =?us-ascii?Q?/7yQi3nmpr6dqvYVQfqLJb78LAG2M1Hn336cshTjyYXysBMt1K6W0J6tHZL8?=
 =?us-ascii?Q?0ReEuQdHcKEBvA48yrD0Nqaqzq0tH4rQSySnl+Vpts9B8IoBqBDCQg1WNzsW?=
 =?us-ascii?Q?iIU9+atrkO1QYjbIiEqbfIb23jcXCLNKtPHzJeMZUxfGmJHMg+/mHIABn941?=
 =?us-ascii?Q?015FCwimgmJU9Uz9Xivl3UBRk0rhTTpMvxSpwGx6Qi/dvvru7xfrfLkWXjnd?=
 =?us-ascii?Q?rnxL7MfhA1tyQaVMM89BezfGgCcPLHmkeJng+VUxQYWEadYUSd6cT55b8Sg1?=
 =?us-ascii?Q?p7J2RFilkQlGCXMyauyIkcCqcY/ry1xmeNStt7sFeSU7Ph5dprs5wLrLDb8Y?=
 =?us-ascii?Q?YBk6e/UJF1T0CzydEmyV5H8PDfRR1F6A3WoPBzjyR7kIaikkgxlWV6SdivOm?=
 =?us-ascii?Q?UbGlKwoIhplQ7HqFsO24j0mxnbEmhOVG3vWMln77rw0pUYVUWmxZsVcOKFv/?=
 =?us-ascii?Q?ENivSzW0jnCBkUdn7EdzHBfWPclo9nkZUBw1iMRZ0WLRGGYTqhDivMfUjg88?=
 =?us-ascii?Q?XZ2+O1bn3kaeSlWIAB3WphXB0qXaYlHZANER8jSd5L+SL2OiWO4eSvl6PRt+?=
 =?us-ascii?Q?w/P5LAZoDL2tmZGVSVKnB4E7gIGSlUax9NdF8BqF4PL2N4FWAjvcFTJJlEfz?=
 =?us-ascii?Q?cfxdeFgub2YNWYjmDY1djsmLPTdOcmSmzf1x0UbhKbT8T3wBw29ChBwmMSvY?=
 =?us-ascii?Q?bkfiKESA7KnChzeWgYOCdTd8/AGGbPSjx0ReQvmfe6uXrsYuSomKUvF8rj9L?=
 =?us-ascii?Q?W/XmL9MbKEPitf9nozeVtoxzv8r+14wIfNGbxtNRY0BMNRQmyCWmDgIvcm89?=
 =?us-ascii?Q?GXh3MwNSbdPmAHLuOo/oBSAq9PAvzDobuQZc+05dXiTHHfusaOPS+jxf3LQW?=
 =?us-ascii?Q?TuIgXvMRkeiUX1MOwPIXMs+W1ZjmwYL9lf1YnwQyRurGJBrDl8zuWTylQlQF?=
 =?us-ascii?Q?ZyhagJNtFSIz3/Wselg24FKcTuv93EjWNP56AEEZedk0BZ3uwdfRDJbvbMR7?=
 =?us-ascii?Q?BFsI8G/lb5Cj9kKEKOoOQJyuCOban1ObxBI5EJF0H6Ie0JuvIIbbvxSfcIgD?=
 =?us-ascii?Q?XDfA4XNghNn6etxXBb9xgH0ExVjDNrZsSwEX7RGUkVzrjTB57auHnx4YFjMa?=
 =?us-ascii?Q?Xfm/mKirmnlf9VXfJFt5h+M3rAzzklt3yj20a1lxzJtZS2rr3g8ZztXAwzvP?=
 =?us-ascii?Q?KhvWCKuzx+Y9uiodm9ZXl1pQV2DMrXRkuTabjmnkNBpz9FFyK28WNVNTwHIo?=
 =?us-ascii?Q?8y5CCkHNDAtLwrqXApXj/6MdXCXh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:59.5507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0eced6-87dd-4e73-ffc4-08dce40422f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
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

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
Since the surface/stream update flags aren't cleared after applying
updates, those same updates may be applied again in a future call to
update surfaces/streams for surfaces/streams that aren't actually part
of that update (i.e. applying an update for one surface/stream can
trigger unintended programming on a different surface/stream).

For example, when an update results in a call to
program_front_end_for_ctx, that function may call program_pipe on all
pipes. If there are surface update flags that were never cleared on the
surface some pipe is attached to, then the same update will be
programmed again.

[How]
Clear the surface and stream update flags after applying the updates.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 45 ++++++++++++++++++------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 981d9a327daf..7b239cbfbb4a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5129,11 +5129,26 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 	return true;
 }
 
+static void clear_update_flags(struct dc_surface_update *srf_updates,
+	int surface_count, struct dc_stream_state *stream)
+{
+	int i;
+
+	if (stream)
+		stream->update_flags.raw = 0;
+
+	for (i = 0; i < surface_count; i++)
+		if (srf_updates[i].surface)
+			srf_updates[i].surface->update_flags.raw = 0;
+}
+
 bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update)
 {
+	bool ret = false;
+
 	dc_exit_ips_for_hw_access(dc);
 	/*
 	 * update planes and stream version 3 separates FULL and FAST updates
@@ -5150,10 +5165,16 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	 * features as they are now transparent to the new sequence.
 	 */
 	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
-		return update_planes_and_stream_v3(dc, srf_updates,
+		ret = update_planes_and_stream_v3(dc, srf_updates,
 				surface_count, stream, stream_update);
-	return update_planes_and_stream_v2(dc, srf_updates,
+	else
+		ret = update_planes_and_stream_v2(dc, srf_updates,
 			surface_count, stream, stream_update);
+
+	if (ret)
+		clear_update_flags(srf_updates, surface_count, stream);
+
+	return ret;
 }
 
 void dc_commit_updates_for_stream(struct dc *dc,
@@ -5163,6 +5184,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_stream_update *stream_update,
 		struct dc_state *state)
 {
+	bool ret = false;
+
 	dc_exit_ips_for_hw_access(dc);
 	/* TODO: Since change commit sequence can have a huge impact,
 	 * we decided to only enable it for DCN3x. However, as soon as
@@ -5170,17 +5193,17 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	 * the new sequence for all ASICs.
 	 */
 	if (dc->ctx->dce_version >= DCN_VERSION_4_01) {
-		update_planes_and_stream_v3(dc, srf_updates, surface_count,
+		ret = update_planes_and_stream_v3(dc, srf_updates, surface_count,
 				stream, stream_update);
-		return;
-	}
-	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
-		update_planes_and_stream_v2(dc, srf_updates, surface_count,
+	} else if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		ret = update_planes_and_stream_v2(dc, srf_updates, surface_count,
 				stream, stream_update);
-		return;
-	}
-	update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
-			stream_update, state);
+	} else
+		ret = update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
+				stream_update, state);
+
+	if (ret)
+		clear_update_flags(srf_updates, surface_count, stream);
 }
 
 uint8_t dc_get_current_stream_count(struct dc *dc)
-- 
2.45.2

