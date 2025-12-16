Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122FAD5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC46110E58C;
	Tue, 16 Dec 2025 09:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="40KlFMXZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039AF10E58C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXDnGmyuj9+6eaPfJEd8/3mJHgtL+E4z13vp+vPB72FoySMV4HBggm2TnBVpcxOfirYmr5Jxv/LMSlFKDtZMKYAZd2/4flilPv3uUSeJlVy4PMC/NoFt9/QdVOkGhuDcjfXANcr4BHS5YmoYEeMAEWH83lUIsx3kJBjXGxsyj4l8+Hwgrd87OGBqEIMkRO4IzCagaJbddBYhW3psrA4b4fvcv1IqcisexdxyyYUaNPDo0eClztmw07Pfp/AFlct0CPHpN/I/5CKiVhYED6WvsqYM0qnZgyGmAS2Xgv2Y2L//X2yuWO3Ez/aGy4a4LJMun0uiFTAgMtFY1VR9TX9+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUTR8wdsM1PQyLlYVWlGhanQP7nRFe+zXrv2zO2iGio=;
 b=Yqrv8mwtU6FA8ycx/j1c8Yo60l4rePx2AgxmG7kCZricXwjcsSkFq1dvXY9Fm646FHdnnDM+/igfth8UNFFLaS3zOwr1TqQIS81D8LFtQ4CTVWPM17uExCMr9An7f1Yn8L0JqhZnrRntNEpB6reVaxB0OJU1kEo7rJqGQQwtMpGU55ED4Rfm2nVGW1Ox+ZNiXmsqbM1GS0T2byBGU+exnG2OZ+octIGSLOaQH/AzljmwG81eYhESZwbQrF6gzfTKecYVuiTJpnswtX+XKyCcvUf++76Vgr1s2p2MM7qoR3eVUmE91QfNDHL/ojhUupWGNvcZRUytmc3NEFToEeCI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUTR8wdsM1PQyLlYVWlGhanQP7nRFe+zXrv2zO2iGio=;
 b=40KlFMXZhu3pv1m3+7Vt4GvuhIf9lHJCSxmzttpVz9HT6gKax6UjkFt5IK90yXrsoKH/BENuW2+y9rJVgCPhZ8/adgjxZ2NX7ewcTerR8Lq3aI+svtfY4qhIcx6pZjFO4XVjoqqLpKn5399X2H7huku/cEzCLra0M6VM8NI7GRQ=
Received: from DM6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:5:1f4::29)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:57:58 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:1f4:cafe::3f) by DM6PR02CA0088.outlook.office365.com
 (2603:10b6:5:1f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:57:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:51 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:51 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:48 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Fix and reenable
 UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL
Date: Tue, 16 Dec 2025 17:56:06 +0800
Message-ID: <20251216095723.39018-7-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 505ff3fd-bd4d-4464-1e65-08de3c899747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hXjysdQvSMy2X87enRd+SxKD2dTFFFv28ckEhb7VNy1cU06Zz1S5Olt3TKK2?=
 =?us-ascii?Q?pG0EQOD/mmAQoTtsN9j6UiLwwDCKc2QSds75q622QpnvFAiFZIHyfB2mYGKt?=
 =?us-ascii?Q?X+aKKscc82UKRDQMnkEzTZ8xD3498Ct7TtKcsgpvxBc4YBD/RbVO/9ffYKMB?=
 =?us-ascii?Q?hlfcLhcs72PwwtpnywdZBK/VPpRXdAAk6wWD9XguQLC1ZtL5NH9bwDoiDR1S?=
 =?us-ascii?Q?M4+4PlcDVd/Z5vUteM3+D3s6I5/dF5A6GlrIzayhz2OPkppEAxE4PEBf/Jr1?=
 =?us-ascii?Q?E+ZZfi/+1kmuTx9M+VHNbRfABNF6COfdzICw6zaUaA4Aos86SBw2ry5ILnUi?=
 =?us-ascii?Q?NZbSetn/wRm66hE8DoSjJLQh7s98AErE5H399HyfnAC32as0uMwuhiG7MMGn?=
 =?us-ascii?Q?T86M71rJhcpXz/XOfixlELp7Uckjh66x7ZwwWGnXUnVlsYIbgmKFyaCL/yM3?=
 =?us-ascii?Q?hqgajGithc+9vhG66VxK7qFasw3RvS+l0h7N7Gov1CK63iq7XCj9K3GMCcY4?=
 =?us-ascii?Q?vFDdkKOj61tXmVK80YR3Q/bfQsvIYI5ChMP8Q4+b68wcaq8ZVuEQQs8O7jLs?=
 =?us-ascii?Q?Rn8yhbaYLhtjHdNgQGiU+SrQteq8OBCHqzZSYwNGqk6/eWCWCNw9khMkeFlU?=
 =?us-ascii?Q?/VkyYsXPno0kxq9FwR1hPgYsIFGlIgt4xXWqcQeADxbEZyvUUXwrR8ofj1Je?=
 =?us-ascii?Q?4X9CvamPgw0aM88kkKHI/ngxnpgiZSaBbN92hXKSff91k9mNy9JEwxeYl8/e?=
 =?us-ascii?Q?rATdOuA02jC1WHOqSGUedsOw4bmEPcUxzDhsoNn6uX8LWNHWVmg6i62J9Olw?=
 =?us-ascii?Q?QQ5IVBIG9FuXmEwKVfSZG4YIXblMWBuoc5GR4ecTaPVjNTbOVwxuFSD1duY2?=
 =?us-ascii?Q?Pf+xV0SFBQMLFgZjcDk9uf0rQAF2awHVnMSKyAi1ddM/OJVKuy5rOoK1kU2a?=
 =?us-ascii?Q?24FHJs4d1jhOqwAhNIo3qYFxJuXsikEPyO7WPTjRvPHx3edff77Aw3hjjeSC?=
 =?us-ascii?Q?8oJbDtuWHx8/lkL7fXxeWqdNaZd/zHtRk9I2zKLklxI7wtfvj9S0hq5iK1WT?=
 =?us-ascii?Q?nBQYl5UQZ/J7ncCM8AXPE+3lhlq8E27wRXO+bkCgQ4sKsLpMZuyy+Y3d7R92?=
 =?us-ascii?Q?TCsNRQKLYpHno+Vwc4iaZDTLiQ0WtbncxhXl8vTYz71YR0+PB5gU38kzP6pT?=
 =?us-ascii?Q?EvQoH5isYXtE+nosY77Yb28qG6aS+OIm6WY+uosM6qSHr31FtZjeV0pqCnBK?=
 =?us-ascii?Q?eIPDBIikbND45OWYeEtQl/zhfR4809GB3N5nxoxSMBt6+4WdSLTKMlqEK1b8?=
 =?us-ascii?Q?11gZp8ZYm2Zhi4pCt29CmM9kZ2MXW9qpQ1Dt7YcesTb0WD8K5QKFR0f7hkFA?=
 =?us-ascii?Q?/DdV4mmLuCW4Tdry9wKdq/ieezvmV/+gBKXJed0F2pPeCDgE2aPlWtKes7qG?=
 =?us-ascii?Q?1HymGq0pbVFmxK7s2hZDXOmsO72ifqOMd+BB0qjddnMYcf94RGzhbvRjVTCP?=
 =?us-ascii?Q?lW0AWPivW8nb/N5mSGZLj6LulkJkvFDob4oEZqYIaSe63EcajAsE18NJrHIQ?=
 =?us-ascii?Q?IUsxqUtCko/b4SjF2RM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:57.9079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505ff3fd-bd4d-4464-1e65-08de3c899747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
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
Reenable new split implementation, previously partially reverted due
to issues with ODM on high-bandwidth displays 4k144Hz, resulting
in a corrupted gray screen.

Minimal flows require two separate commits, with extra intermediate
commit to enable seamless transitions, each followed by a swap. Since
new design requires commit to be run in execute and swap in cleanup
stage, an attempt was made to reorder them from CSCS (Commit-Swap-Commit-Swap)
to CCSS (Commit-Commit-Swap-Swap). Not only is this not viable, but
was implemented incorrectly as CCS, one swap missing.

[How]
* Change UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW/CURRENT to execute
and cleanup one commit, then run UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS,
which closely matches old implementation where minimal flows fall back
to seamless.
* Fix uninitialized variable error.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 80 ++++++++++++------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1be5c1c15798..57f6a4c8afff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -784,7 +784,7 @@ bool dc_stream_get_crc(struct dc *dc, struct dc_stream_state *stream, uint8_t id
 		       uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
 {
 	int i;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = NULL;
 	struct timing_generator *tg;
 
 	dc_exit_ips_for_hw_access(dc);
@@ -5437,35 +5437,23 @@ bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update)
 {
-	bool ret = false;
+	struct dc_update_scratch_space *scratch = dc_update_planes_and_stream_init(
+			dc,
+			srf_updates,
+			surface_count,
+			stream,
+			stream_update
+	);
+	bool more = true;
 
-	dc_exit_ips_for_hw_access(dc);
-	/*
-	 * update planes and stream version 3 separates FULL and FAST updates
-	 * to their own sequences. It aims to clean up frequent checks for
-	 * update type resulting unnecessary branching in logic flow. It also
-	 * adds a new commit minimal transition sequence, which detects the need
-	 * for minimal transition based on the actual comparison of current and
-	 * new states instead of "predicting" it based on per feature software
-	 * policy.i.e could_mpcc_tree_change_for_active_pipes. The new commit
-	 * minimal transition sequence is made universal to any power saving
-	 * features that would use extra free pipes such as Dynamic ODM/MPC
-	 * Combine, MPO or SubVp. Therefore there is no longer a need to
-	 * specially handle compatibility problems with transitions among those
-	 * features as they are now transparent to the new sequence.
-	 */
-	if (dc->ctx->dce_version >= DCN_VERSION_4_01 || dc->ctx->dce_version == DCN_VERSION_3_2 ||
-			dc->ctx->dce_version == DCN_VERSION_3_21)
-		ret = update_planes_and_stream_v3(dc, srf_updates,
-				surface_count, stream, stream_update);
-	else
-		ret = update_planes_and_stream_v2(dc, srf_updates,
-			surface_count, stream, stream_update);
-	if (ret && (dc->ctx->dce_version >= DCN_VERSION_3_2 ||
-		dc->ctx->dce_version == DCN_VERSION_3_01))
-		clear_update_flags(srf_updates, surface_count, stream);
+	while (more) {
+		if (!dc_update_planes_and_stream_prepare(scratch))
+			return false;
 
-	return ret;
+		dc_update_planes_and_stream_execute(scratch);
+		more = dc_update_planes_and_stream_cleanup(scratch);
+	}
+	return true;
 }
 
 void dc_commit_updates_for_stream(struct dc *dc,
@@ -7241,7 +7229,7 @@ static bool update_planes_and_stream_cleanup_v2(
 	return false;
 }
 
-static void update_planes_and_stream_cleanup_v3_intermediate(
+static void update_planes_and_stream_cleanup_v3_release_minimal(
 		struct dc_update_scratch_space *scratch,
 		bool backup
 );
@@ -7262,6 +7250,10 @@ static bool update_planes_and_stream_prepare_v3(
 		struct dc_update_scratch_space *scratch
 )
 {
+	if (scratch->flow == UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS) {
+		return true;
+	}
+	ASSERT(scratch->flow == UPDATE_V3_FLOW_INVALID);
 	dc_exit_ips_for_hw_access(scratch->dc);
 
 	if (!update_planes_and_stream_state(
@@ -7327,11 +7319,11 @@ static bool update_planes_and_stream_prepare_v3(
 			return true;
 		}
 
-		update_planes_and_stream_cleanup_v3_intermediate(scratch, false);
+		update_planes_and_stream_cleanup_v3_release_minimal(scratch, false);
 	}
 
-	restore_planes_and_stream_state(&scratch->dc->scratch.current_state, scratch->stream);
 	scratch->backup_context = scratch->dc->current_state;
+	restore_planes_and_stream_state(&scratch->dc->scratch.current_state, scratch->stream);
 	dc_state_retain(scratch->backup_context);
 	scratch->intermediate_context = create_minimal_transition_state(
 			scratch->dc,
@@ -7347,7 +7339,7 @@ static bool update_planes_and_stream_prepare_v3(
 			return true;
 		}
 
-		update_planes_and_stream_cleanup_v3_intermediate(scratch, true);
+		update_planes_and_stream_cleanup_v3_release_minimal(scratch, true);
 	}
 
 	scratch->flow = UPDATE_V3_FLOW_INVALID;
@@ -7398,12 +7390,10 @@ static void update_planes_and_stream_execute_v3(
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
 		update_planes_and_stream_execute_v3_commit(scratch, false, true);
-		update_planes_and_stream_execute_v3_commit(scratch, false, false);
 		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
 		update_planes_and_stream_execute_v3_commit(scratch, true, true);
-		update_planes_and_stream_execute_v3_commit(scratch, false, false);
 		break;
 
 	case UPDATE_V3_FLOW_INVALID:
@@ -7419,7 +7409,7 @@ static void update_planes_and_stream_cleanup_v3_new_context(
 	swap_and_release_current_context(scratch->dc, scratch->new_context, scratch->stream);
 }
 
-static void update_planes_and_stream_cleanup_v3_intermediate(
+static void update_planes_and_stream_cleanup_v3_release_minimal(
 		struct dc_update_scratch_space *scratch,
 		bool backup
 )
@@ -7432,6 +7422,16 @@ static void update_planes_and_stream_cleanup_v3_intermediate(
 	);
 }
 
+static void update_planes_and_stream_cleanup_v3_intermediate(
+		struct dc_update_scratch_space *scratch,
+		bool backup
+)
+{
+	swap_and_release_current_context(scratch->dc, scratch->intermediate_context, scratch->stream);
+	dc_state_retain(scratch->dc->current_state);
+	update_planes_and_stream_cleanup_v3_release_minimal(scratch, backup);
+}
+
 static bool update_planes_and_stream_cleanup_v3(
 		struct dc_update_scratch_space *scratch
 )
@@ -7448,17 +7448,15 @@ static bool update_planes_and_stream_cleanup_v3(
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
 		update_planes_and_stream_cleanup_v3_intermediate(scratch, false);
-		update_planes_and_stream_cleanup_v3_new_context(scratch);
-		break;
+		scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
+		return true;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
-		swap_and_release_current_context(scratch->dc, scratch->intermediate_context, scratch->stream);
-		dc_state_retain(scratch->dc->current_state);
 		update_planes_and_stream_cleanup_v3_intermediate(scratch, true);
 		dc_state_release(scratch->backup_context);
 		restore_planes_and_stream_state(&scratch->dc->scratch.new_state, scratch->stream);
-		update_planes_and_stream_cleanup_v3_new_context(scratch);
-		break;
+		scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
+		return true;
 
 	case UPDATE_V3_FLOW_INVALID:
 	default:
-- 
2.43.0

