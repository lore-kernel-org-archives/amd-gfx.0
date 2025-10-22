Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51026CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E720F10E702;
	Wed, 22 Oct 2025 07:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0Y49QUx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3244210E702
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBSoz1mjL0AwiauQnQTEWdClCut77Z2QANsYPOH6rAeG+nDWad52nz30EjyArqYTe9ErPzr9+SZ0meep6PibZMgegJeZp8LTswE+Aee1UueIGnP96mCaki1d0ZMqwB/bWqxB3orFkdf0Pb/SHY/dpLMCRLfxka4BN5yYzuURpY3UCn9KH/YIhn6hzcyg2MLVdC3o+U/HjTk73LL8hCPNjgECQDNjxeuSADEjHPMPjSgjPenTMNV2AdIsp8t1SheOF4ue3T2y3x+HN7G0kxUFYtdVmvAMrAc+0sEg+fFlIA4Uk7E83Ipxi3/aCmrIy9zY8NUz/AGxLrZsJSizIQfXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndoTQms8hKb8oJVs9AEeMyixFuBlL3dTUPkiS4XfbmU=;
 b=wz0vmKrELSnpimQoD8CJWwxMRkrJkOtLiKjjjYtOvgI3kl3pr5FfOJnylVyCArqJ4JsOXCLKFYp5qpNQ7FqddQu9qlcb1Xvf5Kcy7RvltYWwWnCp+d+2s7KKWEEtztSVqVrp/a/Dhl+SKZMwz0IKMRnmX9j/aK2+n5H1umgFcJC1W3ABkXaNHVbq0p2KdS9lT8kK3lMxa6Ips4PbV2QmvKtcdcOra+bu1mKcqo+ksqW/OOtgxXp+b233JO4aOyURXEMWJPixiV2MvTNAHFTQrVsNPKDuR+ynHMdjzw+gI7VW6PXm6e1ViFJc/2WQDi/53EujkXZR7RyKf7YPP4jI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndoTQms8hKb8oJVs9AEeMyixFuBlL3dTUPkiS4XfbmU=;
 b=b0Y49QUxUpAeed8GL15q5nXn85eEgfk2vfg/lccrWPqpsDi9PaD7plWmRqLSwD3BUIJ5dcXd7SDR4Ldxjxg/2jsr7hBshfXEZyrI+7ITkOuT9WOgd4/l/uAFlE1wFYrtkyf8kGKVE61532xssdyCLC/IWQIhDYiUtY9XERrdk2w=
Received: from DM6PR13CA0020.namprd13.prod.outlook.com (2603:10b6:5:bc::33) by
 DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 07:35:30 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::57) by DM6PR13CA0020.outlook.office365.com
 (2603:10b6:5:bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:35:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:07 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:35:04 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 16/20] drm/amd/display: Make observers const-correct
Date: Wed, 22 Oct 2025 15:30:28 +0800
Message-ID: <20251022073332.666119-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 41239cf5-1bb6-4724-e226-08de113d93e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WwHXHpmeXB5kUq32tFVSC3WJVKUrsmKbaKmqSJFFAxRxbzVEU+umqz+PxWI7?=
 =?us-ascii?Q?kj9EKbxEcWZn83TvEjsAvlY7eW4mCRanuH8z2dQjXfj+YcjPRIAX53Cvp+Te?=
 =?us-ascii?Q?1dDjr/c3727coPcG1wO9q8PF0lnU0o11/Rh9GsmzFOMNXISakzHY7z9mgXcF?=
 =?us-ascii?Q?3Ate0s8Sk+gr2OufK96IQlLWq5rVlanTZdJjnur1Hl6JDeMalxTtPmJeZuGh?=
 =?us-ascii?Q?1nEtr3HbgOBBL+vcPjz03SJW0n9HfEpyQax3vz/pdCU2NMAH+aOFsjZma0K/?=
 =?us-ascii?Q?F3L/FGqb9Tk/VyBouV/fz9FcJPLxbQ+qmQ1+4GcEnS8DdwRUeDSvqPGH9RIk?=
 =?us-ascii?Q?yPJkXk1fMQcft/z0SwO30LkUlpN+ai/a/OHUb5FmY1PY1ap+4v6msFUCKGUM?=
 =?us-ascii?Q?hm4nIaIAI9OrpH6WuyWzHg52mou5Qw/VKHW1MdLR+68XGhfVu4rQxRI/fBua?=
 =?us-ascii?Q?v4cQglZhJxarNItGi1x9VODpNGToUDq55d0AvMUxwNEPNYl2kitPYtlTa+UN?=
 =?us-ascii?Q?4sx+aiOIU7n5aR+LYky94hPMVnt8rVez+gdVD7fI5cJF13bKft/b8NEVwXvE?=
 =?us-ascii?Q?NGLBh/4k/iEaUZL7kXS139abPjkWJIfSygSKpyNvaSnW6Hx9IvYWdaQZeNkh?=
 =?us-ascii?Q?sDSY88hejzODB5wKNgzLPz+WHPz9jFk3MU6r4GO7lRX0lKNes/rMrqY4XT56?=
 =?us-ascii?Q?Jeul2DrqsMox7PO+b2INS+cLau75bZJfwMo489JF3+9HtrFHBurOJCxbmnHs?=
 =?us-ascii?Q?bepHyR/fmXUOcQ9hwy3WqfTN4953cglqbVc+tuaATd+HFp6UpaTCwWQES68P?=
 =?us-ascii?Q?VMhS41aghuprMn3DDQq//uWiInMpWbXVxE7uU498hqztj2+5BO8dGUCRVedK?=
 =?us-ascii?Q?owDu4S3sU1iK1ICmqJXIREK5E1qigYJVxsGp1QqMvKbApvvYpkBUOYm9vHyK?=
 =?us-ascii?Q?4PRsXA26kJozbqOBrL+sC7BzUiMv6mpXgyTKJFHUtws75an3ByJ0VvKwKWDm?=
 =?us-ascii?Q?58EgDnu+JdG7D2WXKOtRq/kiEWKMW0L2opyRb7IeZNcM1aM1Sjk+x7MS7n7V?=
 =?us-ascii?Q?3GBQ8ZfAK9gbpbVPqaL/8g6PlOPpnXHzgariJMCK3iKkTEZNZACOYHi8FWA2?=
 =?us-ascii?Q?1ZPUcFfAWgXgf8tM8fiESyKLbiD+dCKS8ED/uxADrQt/W9L9RE/3t0hzcDjt?=
 =?us-ascii?Q?jrNO0xBSkFeTeQ0wttRU9QjkZtIYevlptbFRjqtAOyFo/ih+LGjjHxCaoIAZ?=
 =?us-ascii?Q?1M2kgTvlgOnxreX/Y2mwERNuSfneJUeWTHA32m72zjWYBpwU+0pf/HwSEmog?=
 =?us-ascii?Q?flfLkVHKpn17Abdtih6GdfTaPzUuScnJAhjTRz1HK2blGCMqHMSLpzW0ZVsm?=
 =?us-ascii?Q?R1P6svSSjl6o6JzTRv0LHn/dTcDMlG3d0zj0hBzEMq6zl7pTznD7m6CuOH29?=
 =?us-ascii?Q?MpDm1lNdKqpk44A8mfNlXm/OtlgcEPGTaVsHEZphw7ZvoEAj71d+FlBAtDZX?=
 =?us-ascii?Q?PazORtdQaovJhMSsykcGID48qXk888V9dOp47gkH0n9MpSXZnex0RhPs0M6I?=
 =?us-ascii?Q?zsxWfw8nk4oafdHRmQt4NxEEoeoVDIeLsUm15ezr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:35:30.4702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41239cf5-1bb6-4724-e226-08de113d93e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
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
Observers which do not modify their pointer arguments should take
them as const. This clearly signals their intent to the caller,
making it clear that the function is safe to call multiple times,
or remove the call if the result is no longer necessary.

[How]
Made const-correct all of the functions below:
* full_update_required[_weak]
* fast_updates_exist
* fast_update_only
* dc_can_clear_cursor_limit
* dc_stream_get_status (added const named overload)

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 44 ++++++++++---------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  8 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 +-
 4 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1851a35f629f..b720e007c654 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3427,11 +3427,12 @@ static void update_seamless_boot_flags(struct dc *dc,
 	}
 }
 
-static bool full_update_required_weak(struct dc *dc,
-		struct dc_surface_update *srf_updates,
+static bool full_update_required_weak(
+		const struct dc *dc,
+		const struct dc_surface_update *srf_updates,
 		int surface_count,
-		struct dc_stream_update *stream_update,
-		struct dc_stream_state *stream);
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream);
 
 /**
  * update_planes_and_stream_state() - The function takes planes and stream
@@ -5015,7 +5016,7 @@ void populate_fast_updates(struct dc_fast_update *fast_update,
 	}
 }
 
-static bool fast_updates_exist(struct dc_fast_update *fast_update, int surface_count)
+static bool fast_updates_exist(const struct dc_fast_update *fast_update, int surface_count)
 {
 	int i;
 
@@ -5056,11 +5057,12 @@ bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_
 	return false;
 }
 
-static bool full_update_required_weak(struct dc *dc,
-		struct dc_surface_update *srf_updates,
+static bool full_update_required_weak(
+		const struct dc *dc,
+		const struct dc_surface_update *srf_updates,
 		int surface_count,
-		struct dc_stream_update *stream_update,
-		struct dc_stream_state *stream)
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
 {
 	const struct dc_state *context = dc->current_state;
 	if (srf_updates)
@@ -5069,7 +5071,7 @@ static bool full_update_required_weak(struct dc *dc,
 				return true;
 
 	if (stream) {
-		const struct dc_stream_status *stream_status = dc_stream_get_status(stream);
+		const struct dc_stream_status *stream_status = dc_stream_get_status_const(stream);
 		if (stream_status == NULL || stream_status->plane_count != surface_count)
 			return true;
 	}
@@ -5082,11 +5084,12 @@ static bool full_update_required_weak(struct dc *dc,
 	return false;
 }
 
-static bool full_update_required(struct dc *dc,
-		struct dc_surface_update *srf_updates,
+static bool full_update_required(
+		const struct dc *dc,
+		const struct dc_surface_update *srf_updates,
 		int surface_count,
-		struct dc_stream_update *stream_update,
-		struct dc_stream_state *stream)
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
 {
 	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
 		return true;
@@ -5146,12 +5149,13 @@ static bool full_update_required(struct dc *dc,
 	return false;
 }
 
-static bool fast_update_only(struct dc *dc,
-		struct dc_fast_update *fast_update,
-		struct dc_surface_update *srf_updates,
+static bool fast_update_only(
+		const struct dc *dc,
+		const struct dc_fast_update *fast_update,
+		const struct dc_surface_update *srf_updates,
 		int surface_count,
-		struct dc_stream_update *stream_update,
-		struct dc_stream_state *stream)
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
 {
 	return fast_updates_exist(fast_update, surface_count)
 			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
@@ -6383,7 +6387,7 @@ bool dc_is_cursor_limit_pending(struct dc *dc)
 	return false;
 }
 
-bool dc_can_clear_cursor_limit(struct dc *dc)
+bool dc_can_clear_cursor_limit(const struct dc *dc)
 {
 	uint32_t i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 096fbb8ad24c..6d309c320253 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -224,6 +224,14 @@ struct dc_stream_status *dc_stream_get_status(
 	return dc_state_get_stream_status(dc->current_state, stream);
 }
 
+const struct dc_stream_status *dc_stream_get_status_const(
+	const struct dc_stream_state *stream)
+{
+	struct dc *dc = stream->ctx->dc;
+
+	return dc_state_get_stream_status(dc->current_state, stream);
+}
+
 void program_cursor_attributes(
 	struct dc *dc,
 	struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f302d57f7ba8..811098b5d7e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2757,7 +2757,7 @@ bool dc_is_timing_changed(struct dc_stream_state *cur_stream,
 		       struct dc_stream_state *new_stream);
 
 bool dc_is_cursor_limit_pending(struct dc *dc);
-bool dc_can_clear_cursor_limit(struct dc *dc);
+bool dc_can_clear_cursor_limit(const struct dc *dc);
 
 /**
  * dc_get_underflow_debug_data_for_otg() - Retrieve underflow debug data.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 75869eed1d3a..321cfe92d799 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -491,8 +491,8 @@ void update_stream_signal(struct dc_stream_state *stream, struct dc_sink *sink);
 void dc_stream_retain(struct dc_stream_state *dc_stream);
 void dc_stream_release(struct dc_stream_state *dc_stream);
 
-struct dc_stream_status *dc_stream_get_status(
-	struct dc_stream_state *dc_stream);
+struct dc_stream_status *dc_stream_get_status(struct dc_stream_state *dc_stream);
+const struct dc_stream_status *dc_stream_get_status_const(const struct dc_stream_state *dc_stream);
 
 /*******************************************************************************
  * Cursor interfaces - To manages the cursor within a stream
-- 
2.43.0

