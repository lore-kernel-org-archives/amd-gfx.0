Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C94CFD65A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6A510E62E;
	Wed,  7 Jan 2026 15:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ml0Pc/uY";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB9C10E635
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymoYRODlB5U7qBfa57H4UmziEqeWmQgznQ8ssMLsqoGNS5P7wtvcoQBn0QZ9ZBKNHjWOIIquFAjWi2RZWSCpIQjb+Pxcpx2bXPzkoEaGDgZ/mmDISwQ4Sef3EBH4e/MyFXxYqD0Utgaqm0ZiyBOaVX4NibbmsuF/SmVXwMqRCiuVTg0/DXDLe8nFtqx0C2OlHPO64CtcaB5K+c4iIgEi5DrSxZWOZKJTNi7ha0xiGzFMrSGFv/p1c1zw/cNv2wLKiuCqiCBh41Q0ZfzyICQtGi4uda8JktYXwTJtcptbF/aQUCOkrK9cUK2HAsX7fMhOTDX106n0dAsRitD+IQlK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUouEzcHYNrVvDFNut/MVGYrQ+g6m2CMjaST68/tr9s=;
 b=M6WKZvkdgg4ZB6o5uePf8OylPOm9h1mRbCP1XhTwppnd1fEBD9nsOM0VLwc7ELl9/wcvsizMx3ZWjT6yaafdvaTnwSMgTnjK21Bc4V3u83Vz/9oz5SgGYiuabsCzQv5bWfhGUaLN+fs+Kghx2ct+tUjN6IsgC3py48xTFHFl8lNIFleHlo0ZuAe3zx00wf17N3GSx+WFbiqWs6kZP13Zdb9JiqJ2yOhDIz8jPOaKNTuTgunc7Gallt2CXc2VuZ5fG8h8BaX9CH4oa51uld6YQJCkcgaMrWobuZrx9syiwYfzb+plw82QW/o2N5d7GZbsOuTQjhymdIdr0hXnPXDjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUouEzcHYNrVvDFNut/MVGYrQ+g6m2CMjaST68/tr9s=;
 b=Ml0Pc/uYq5gF0F/J4vHlAKe/HgdDm3sDV0CgDX5BDnCC/T/XIj/naKxNK7kGklfUt7Q98QvaagCquRP4fNSUVRV5xBhljOdD6IufX+KpRIKi3R0mNWWLZ4kBKc8WPh/NisUgMzKSpaDVe9YEKjWadocYBNmYMlBhw2oHJyvA4g4=
Received: from SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:57:55 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7b) by SJ0PR03CA0185.outlook.office365.com
 (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:57:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:54 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:53 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 02/21] drm/amd/display: Re-implement minimal transition
 deferral
Date: Wed, 7 Jan 2026 10:47:54 -0500
Message-ID: <20260107155421.1999951-3-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f3dfdb-d660-4576-8dc7-08de4e05859c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zw/zm12M6ZMSMjkQAry+dRDdDkvWmbgVi/7PeXwWo5cGPvi+r2WAvAhqqWXz?=
 =?us-ascii?Q?jealYoghvIL2dktx3a+H4ouHLBEyuhJnm4mX7jGEPvpgHiSLWRpSiHnyjdCM?=
 =?us-ascii?Q?2c46B8GuW6pOMpcdIO1CwXIzmQ8/fJZzfBaVWFbnGA0CnFP6UaX/QkYY3tz7?=
 =?us-ascii?Q?7Uog6bjs3ifGUSwGiAHmkeglCZn8qFG5SYN9xCeUBASE3DaDIsXgwxhvkRvE?=
 =?us-ascii?Q?lfC52RqWqTfIOKXWcf+FrW3fV9rnM3/dSgSThWCsbP33wWKkm2VVjFReDTMX?=
 =?us-ascii?Q?Is+v/LKnywZRdQS1ZXFxMja8zX3E7w2dBcV+Kcqpkorg52qFQ1tF9EbOiam9?=
 =?us-ascii?Q?KyffOU9OP1u4Unh/D78J8U6MkSjtTORmjJ//4AWDGDZT5r1RhzcPqpl58H/8?=
 =?us-ascii?Q?n2/TyedwdjQwXvaC1xAC9Sn+ejSKu8OI4wCgzohtHXEqSzPdzPnaqAG2gE/C?=
 =?us-ascii?Q?t8gwH79yqXGltt0f4C4ZWHOkc4V8yHrUhw81GV/Qfp4E56SzXxOdPaklfd4e?=
 =?us-ascii?Q?sM7BhmPXqBVSAw9ozdPK7Lz8kuGExhpOkvSSJM++m1yMDIt6nyVrX3xN6y6U?=
 =?us-ascii?Q?WSDD4QmSdd/RVduZdvqOZTChvY/ukeJ4/1jqvmTf1hnm92NH36TFpBS3SxgY?=
 =?us-ascii?Q?SeFkkLemJZc9VrTQztRqimgyNuv9C5KC1i+1N7XWcNsNE1cYBXb14/jEjanV?=
 =?us-ascii?Q?FVILorRP9VO66iLJviIXZ/fAHc2ojtukFzGNndTvRNrg80gr0Sch2vommwTT?=
 =?us-ascii?Q?w1EItZj5tB3X56RoRUC2n+Ehl70r8LiAOl1fVhIW7o8tZ6A4bnVfxs3F9xRa?=
 =?us-ascii?Q?A2s8Qa0Z/lVD/qopk27vISm/+GOg9/QfI9bPGZnkeymxtM4tqlBraXTsk8u9?=
 =?us-ascii?Q?6cnLz+ctE2VSDoB9T+xMcYNZeituOWR5j2R3ZutXjGnQdCwpfTDkbqHtpphq?=
 =?us-ascii?Q?ByJekn5BbEOQzeRsp/TLOnh32ey6VJ2pXuZnPcQu3oW4Vfh8ItIQTK2CpAU3?=
 =?us-ascii?Q?jKXcDcrHjUy5+QcquUIGmARn/A55EWyGncVwygFYCqy4qf7vDsknyNF38rhZ?=
 =?us-ascii?Q?jBjK3SiMMYy0YsOk6Mpaesetle4ZJhs1AbrxsoKwKNBmBbgc8ZTBOjmdv36+?=
 =?us-ascii?Q?GcVkdftuONNWLyZblPGGSIA1GfTxoZ79zi+BlNgB6kWhode/ERXoV3rqSsaQ?=
 =?us-ascii?Q?/wes9BCdOf4V270VdUe6YHt6706bwqCJrOBZ22qF9ItHKiVaPJEumSRNhIyD?=
 =?us-ascii?Q?/sgkP/a9WotoDzQNUKFnp6OX/6wgjdWp/lkmUXYoASiqBMQKh/09Qh9Uc68v?=
 =?us-ascii?Q?Zb18/+U7g6H3QnDHMnJ65MgZj0gWzGOgMmM+sqWCgiBcRDDvyLuxPFgwRcdc?=
 =?us-ascii?Q?upealVPV7Bl9IxCpJlHc6bJQIuxCxTuLO5tQla9+MzUdpwWXGv/ILpIuGpsm?=
 =?us-ascii?Q?z8ECqP+x0oG9UP1oORvh1m9MfQONymwU55tJUIAgUzewuHmr/kjoK6x7JeWB?=
 =?us-ascii?Q?zucP2fcv5W8jhl3ComOTJvyAEE0eGBWBs61l9wE2CQE1joR8wqW6V0VIH3Np?=
 =?us-ascii?Q?JSbSD0K3iXkyMGt/Cgk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:57:55.5247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f3dfdb-d660-4576-8dc7-08de4e05859c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
The update v3 path got refactored into new functions, which happened just
before the previous implementation was submitted, which resulted in the
optimizations not executing. This commit re-implements the same logic in
the new codepath.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 49 ++++++++++++++++--------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 57f6a4c8afff..aba5ad2a7a33 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7246,6 +7246,14 @@ static bool update_planes_and_stream_prepare_v3_intermediate_seamless(
 	);
 }
 
+static void transition_countdown_init(struct dc *dc)
+{
+	dc->check_config.transition_countdown_to_steady_state =
+			dc->debug.num_fast_flips_to_steady_state_override ?
+			dc->debug.num_fast_flips_to_steady_state_override :
+			NUM_FAST_FLIPS_TO_STEADY_STATE;
+}
+
 static bool update_planes_and_stream_prepare_v3(
 		struct dc_update_scratch_space *scratch
 )
@@ -7305,9 +7313,17 @@ static bool update_planes_and_stream_prepare_v3(
 	);
 	if (seamless) {
 		scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
+		if (scratch->dc->check_config.deferred_transition_state)
+			/* reset countdown as steady state not reached */
+			transition_countdown_init(scratch->dc);
 		return true;
 	}
 
+	if (!scratch->dc->debug.disable_deferred_minimal_transitions) {
+		scratch->dc->check_config.deferred_transition_state = true;
+		transition_countdown_init(scratch->dc);
+	}
+
 	scratch->intermediate_context = create_minimal_transition_state(
 		scratch->dc,
 		scratch->new_context,
@@ -7351,7 +7367,8 @@ static bool update_planes_and_stream_prepare_v3(
 static void update_planes_and_stream_execute_v3_commit(
 		const struct dc_update_scratch_space *scratch,
 		bool intermediate_update,
-		bool intermediate_context
+		bool intermediate_context,
+		bool use_stream_update
 )
 {
 	commit_planes_for_stream(
@@ -7359,7 +7376,7 @@ static void update_planes_and_stream_execute_v3_commit(
 			intermediate_update ? scratch->intermediate_updates : scratch->surface_updates,
 			intermediate_update ? scratch->intermediate_count : scratch->surface_count,
 			scratch->stream,
-			intermediate_context ? NULL : scratch->stream_update,
+			use_stream_update ? scratch->stream_update : NULL,
 			intermediate_context ? UPDATE_TYPE_FULL : scratch->update_type,
 			// `dc->current_state` only used in `NO_NEW_CONTEXT`, where it is equal to `new_context`
 			intermediate_context ? scratch->intermediate_context : scratch->new_context
@@ -7385,15 +7402,16 @@ static void update_planes_and_stream_execute_v3(
 
 	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL:
 	case UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS:
-		update_planes_and_stream_execute_v3_commit(scratch, false, false);
+		update_planes_and_stream_execute_v3_commit(scratch, false, false, true);
 		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
-		update_planes_and_stream_execute_v3_commit(scratch, false, true);
+		update_planes_and_stream_execute_v3_commit(scratch, false, true,
+				scratch->dc->check_config.deferred_transition_state);
 		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
-		update_planes_and_stream_execute_v3_commit(scratch, true, true);
+		update_planes_and_stream_execute_v3_commit(scratch, true, true, false);
 		break;
 
 	case UPDATE_V3_FLOW_INVALID:
@@ -7402,13 +7420,6 @@ static void update_planes_and_stream_execute_v3(
 	}
 }
 
-static void update_planes_and_stream_cleanup_v3_new_context(
-		struct dc_update_scratch_space *scratch
-)
-{
-	swap_and_release_current_context(scratch->dc, scratch->new_context, scratch->stream);
-}
-
 static void update_planes_and_stream_cleanup_v3_release_minimal(
 		struct dc_update_scratch_space *scratch,
 		bool backup
@@ -7439,17 +7450,23 @@ static bool update_planes_and_stream_cleanup_v3(
 	switch (scratch->flow) {
 	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST:
 	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL:
-		// No cleanup required
+		if (scratch->dc->check_config.transition_countdown_to_steady_state)
+			scratch->dc->check_config.transition_countdown_to_steady_state--;
 		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS:
-		update_planes_and_stream_cleanup_v3_new_context(scratch);
+		swap_and_release_current_context(scratch->dc, scratch->new_context, scratch->stream);
 		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
 		update_planes_and_stream_cleanup_v3_intermediate(scratch, false);
-		scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
-		return true;
+		if (scratch->dc->check_config.deferred_transition_state) {
+			dc_state_release(scratch->new_context);
+		} else {
+			scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
+			return true;
+		}
+		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
 		update_planes_and_stream_cleanup_v3_intermediate(scratch, true);
-- 
2.52.0

