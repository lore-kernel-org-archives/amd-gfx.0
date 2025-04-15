Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EBFC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D3310E7C8;
	Tue, 15 Apr 2025 15:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VE2Uzvx5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99C910E7C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrcBw16o1iBrh+sns7xcgvTmVh2FGDNpO3vqXhulSiabYN9+uNnUVqmLVTbU9iinAM6OZ10L9cvVm/GQgn7hPgsv5n7W01WTNvgl3k9Cyh0I8bsxsbUOLD9iHzCkWKZRUzkgHJagODRD7k51DRQOUCUGcO9TyMoGSgaOjokZVWF5A4JgmZFgnj5Cn3KsDEEhSgQiex+Nf9XnksKc0Q5ygdJalKZyYcwZVoN7lV4Pw1HlnGjVGP+I+fmy6yd2ZH25dTgF/HLw4dsmDrpibcdKwRyXo6M7MKdn5MFjFfPtY2EYcpENzHNtP7pd8PKzOCCOPm+KSZBQvGWWdFGG1gPuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2pCs20ff6zO/fIMDD3HnUfBCynu/DxoaLI63yywGxA=;
 b=bkvnkoatE437cHlNeK5+Y9cpfMTNJcFGP5Co8+38AFLk62sxV0XCqy0suhHOj0a7AbZ+/x0BWg7TkimhlWyzv4kS1NEizNUD0roL8fqGuGxBcs8SxrCJ/DV0sPlaqKjpngdBvDO5QTLGjN8w447Lp2fQLWA8FJ+UgkGMHVXsw+qY+6CaBASaDUzy85OXqX1tSJAdo14T2XWG2yi0E02GDnXk7f9ID7clmZ562El1hSIJvP3OL40dex4MK2UrkwA7FEZQ8EfD+vaz6osJuyjd6AqsKvxg5flOwU9q0d8bGa0GO0mqdXDzLFxB2YuYqhHq0lvq7Hroy/1iCrrXbTGfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2pCs20ff6zO/fIMDD3HnUfBCynu/DxoaLI63yywGxA=;
 b=VE2Uzvx5uADtWixjWI8OBk8esbd3vWzcjoi+fdDMtBZcH+KWhI/I7qkurnta+FQAbEu2jrJun/tegYkPooLg5PhGO3PHu9IKpW3yaVZhWtEP3gPhK2GBv775CMU5Qv47O6X5Z36U0RFH/03J2dNMh7nTn1Fg2/wCBalrt790TRw=
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 15:00:14 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d6) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 15:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 15:00:12 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 10:00:04 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 20/22] drm/amd/display: Refactor SubVP cursor limiting logic
Date: Tue, 15 Apr 2025 10:59:06 -0400
Message-ID: <20250415145908.3790253-21-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4e1620-2a5e-4d50-73df-08dd7c2e3935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nmkSuqCdvtx7DOOt4TUqo1lY0w6f/RhENUtedxIclcsMSfRHLLlbRDfKIN2m?=
 =?us-ascii?Q?CWOqWJon+gbxLwz4AXLQpJVMsdSddZpe07t66p+ZFZMmnPzaslcGa1WQuc1s?=
 =?us-ascii?Q?VjXCjE/uviWgeC6PVhE0zQXheRwPNS5yGKGUSGoeejLX9mqOpokArYCSf64K?=
 =?us-ascii?Q?yD/JKARSftZredrSWKHXKuhgEwjJeM7mcfpEZG1CBsWxkvjIuSBjZvI+XEET?=
 =?us-ascii?Q?6Vw9plSafqCa6X1zKZDzQlVxXU8HB7rzCQMXGfBKwuY1YcmOqigPLtTwX8uW?=
 =?us-ascii?Q?ESXs6YOAnhJW0uNuMj9SmyZEM7X0Ae+bY+P7jUhxLcjcwbGT7LOZzEtazxUk?=
 =?us-ascii?Q?0mz8dcvTEccTmOtEB8GxgIE+LDHGQ/HCMRgrhou3QHvGxk3WmYVUIDBq/d4h?=
 =?us-ascii?Q?U2SmYvmCdF8ih35QbX+SwtNX3J7o5liyqHXYq2bwu12FM0YPV+6EA5U+OHX9?=
 =?us-ascii?Q?WWXICO7vMElNIbxPoe2+FRPaRSGIx5ExGEOkcYFY0/imBcjrEjlgV22t1c6J?=
 =?us-ascii?Q?MLmaNK7KxFW4SPxFvKCvsWPaSIdvTsE1IRYARZJn/uxYttfsD9nqu3un2518?=
 =?us-ascii?Q?wWTaim9vI8Mzm2sqpd87c34WpxS8Ew2tSh52ueu8Xy9XPHccUhCphMoVIOXD?=
 =?us-ascii?Q?uCRk1SsGX01MrGuSkpdatOiPDKkA0OnBy/8G79cbE3p5sCRIHP0M49pPrcNP?=
 =?us-ascii?Q?aKLEaqhls8e5ty6ASSc+8h6EtNUGSFQyOYvOvxbntuRGiXvy4DEEt4M+yGEw?=
 =?us-ascii?Q?UDjWJrdFYgMDLc5l+XG4qxhhqSRuB+sFbY/ip/CKO1n97bBJc4BeEO/tcujT?=
 =?us-ascii?Q?+kz6L9lnOEHPp6vM0bmcFhDnhtoClqZiHIMPWIiev0hfvQrCGySYx9NCBuIP?=
 =?us-ascii?Q?Gnl79BS19EFd7X6CDRACJjAUNQ4oMpNZK6T0lmluYOD7CAd9U0pVnRejPuFq?=
 =?us-ascii?Q?JCbEE0xBKvgGpVlTDVctLQ8FJik0jIMm1DBaF2M+ReHzOL/Yt40puPNKg08Q?=
 =?us-ascii?Q?DzFf70QPj4kxOxgyoWnkYq60LqWeQxcwU1f+3L6FO/fHOSytaZDq40vBzB3M?=
 =?us-ascii?Q?JPWMjILzNiLJSefex/fElIFaopAcavn/ldz5ouNxBZkvsF9OS7GaDAUHkrBA?=
 =?us-ascii?Q?a/Xz8mlQ1iHXfDckZqMFxiyhYKnwwSJvMPA8BV+KJ4JbrcjQEYMvKJd5Ler7?=
 =?us-ascii?Q?O/u5/FqKGxob7xHfFdOcV+6wVWLJJ8POfIMt29NOCsaOcP6h3uM5ne4OxOtU?=
 =?us-ascii?Q?oSOMsCBfQJn5jDRABDUOvyQpUfm1wRqvLDDxLKeGpFRl/aHbxeBwh9Qe68D+?=
 =?us-ascii?Q?W58XSr4N47XH1FAUleN1f7XiX3ZeAfLypIYkJvbuSvV8LI3NiaMldtZxsd7t?=
 =?us-ascii?Q?j+5EWOFe8nMsubiImihYuu66p9eUxavFm4Za+99eOMJHk5G1lZtUvHIP8oXt?=
 =?us-ascii?Q?BTyxDuS50/wn0Y8Ho23ALTJUqy3TVcJP1Tit/8LKvSb85btDjTsuXL9XDIwp?=
 =?us-ascii?Q?bgV2/X07wyQgdMS67qahjOrMqdIpttKr4Uwh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:00:12.5997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4e1620-2a5e-4d50-73df-08dd7c2e3935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
There are several gaps that can result in SubVP being enabled with
incompatible HW cursor sizes, and unjust restrictions to cursor size due
to wrong predictions on future usage of SubVP.

[HOW]
- remove "prediction" logic in favor of tagging based on previous SubVP
  usage
- block SubVP if current HW cursor settings are incompatible
- provide interface for DM to determine if HW cursor should be disabled
  due to an attempt to enable SubVP

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 52 ++++++++--
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 48 ++--------
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 96 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 70 +++++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +
 .../gpu/drm/amd/display/dc/dc_state_priv.h    | 20 ++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 +++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |  9 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 -
 .../dc/resource/dce100/dce100_resource.c      |  4 +-
 .../dc/resource/dce110/dce110_resource.c      |  4 +-
 .../dc/resource/dce112/dce112_resource.c      |  4 +-
 .../dc/resource/dce112/dce112_resource.h      |  2 +-
 .../dc/resource/dce80/dce80_resource.c        |  4 +-
 .../dc/resource/dcn10/dcn10_resource.c        |  5 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  6 +-
 .../dc/resource/dcn20/dcn20_resource.h        |  2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  4 +-
 .../dc/resource/dcn30/dcn30_resource.h        |  2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  4 +-
 .../dc/resource/dcn31/dcn31_resource.h        |  2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  4 +-
 .../dc/resource/dcn314/dcn314_resource.h      |  2 +-
 .../dc/resource/dcn32/dcn32_resource.c        | 65 +++++++++++--
 .../dc/resource/dcn32/dcn32_resource.h        |  6 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  3 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  6 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  6 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  6 +-
 .../dc/resource/dcn401/dcn401_resource.c      | 49 ++++++++--
 .../dc/resource/dcn401/dcn401_resource.h      |  2 +-
 38 files changed, 398 insertions(+), 127 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 66e23507eb82..3f56f9a1250c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -37,6 +37,7 @@
 #include "dc_state.h"
 #include "dc_state_priv.h"
 #include "dc_plane_priv.h"
+#include "dc_stream_priv.h"
 
 #include "gpio_service_interface.h"
 #include "clk_mgr.h"
@@ -2886,7 +2887,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	int i;
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 
-	if (dc->idle_optimizations_allowed)
+	if (dc->idle_optimizations_allowed || dc_can_clear_cursor_limit(dc))
 		overall_type = UPDATE_TYPE_FULL;
 
 	if (stream_status == NULL || stream_status->plane_count != surface_count)
@@ -3290,7 +3291,7 @@ static void copy_stream_update_to_stream(struct dc *dc,
 		if (dsc_validate_context) {
 			stream->timing.dsc_cfg = *update->dsc_config;
 			stream->timing.flags.DSC = enable_dsc;
-			if (!dc->res_pool->funcs->validate_bandwidth(dc, dsc_validate_context, true)) {
+			if (dc->res_pool->funcs->validate_bandwidth(dc, dsc_validate_context, true) != DC_OK) {
 				stream->timing.dsc_cfg = old_dsc_cfg;
 				stream->timing.flags.DSC = old_dsc_enabled;
 				update->dsc_config = NULL;
@@ -4608,7 +4609,7 @@ static struct dc_state *create_minimal_transition_state(struct dc *dc,
 
 	backup_and_set_minimal_pipe_split_policy(dc, base_context, policy);
 	/* commit minimal state */
-	if (dc->res_pool->funcs->validate_bandwidth(dc, minimal_transition_context, false)) {
+	if (dc->res_pool->funcs->validate_bandwidth(dc, minimal_transition_context, false) == DC_OK) {
 		/* prevent underflow and corruption when reconfiguring pipes */
 		force_vsync_flip_in_minimal_transition_context(minimal_transition_context);
 	} else {
@@ -5128,7 +5129,7 @@ static bool update_planes_and_stream_v1(struct dc *dc,
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
 	if (update_type >= UPDATE_TYPE_FULL) {
-		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+		if (dc->res_pool->funcs->validate_bandwidth(dc, context, false) != DC_OK) {
 			DC_ERROR("Mode validation failed for stream update!\n");
 			dc_state_release(context);
 			return false;
@@ -6272,15 +6273,22 @@ bool dc_abm_save_restore(
 void dc_query_current_properties(struct dc *dc, struct dc_current_properties *properties)
 {
 	unsigned int i;
-	bool subvp_sw_cursor_req = false;
+	unsigned int max_cursor_size = dc->caps.max_cursor_size;
+	unsigned int stream_cursor_size;
 
-	for (i = 0; i < dc->current_state->stream_count; i++) {
-		if (check_subvp_sw_cursor_fallback_req(dc, dc->current_state->streams[i]) && !dc->current_state->streams[i]->hw_cursor_req) {
-			subvp_sw_cursor_req = true;
-			break;
+	if (dc->debug.allow_sw_cursor_fallback && dc->res_pool->funcs->get_max_hw_cursor_size) {
+		for (i = 0; i < dc->current_state->stream_count; i++) {
+			stream_cursor_size = dc->res_pool->funcs->get_max_hw_cursor_size(dc,
+					dc->current_state,
+					dc->current_state->streams[i]);
+
+			if (stream_cursor_size < max_cursor_size) {
+				max_cursor_size = stream_cursor_size;
+			}
 		}
 	}
-	properties->cursor_size_limit = subvp_sw_cursor_req ? 64 : dc->caps.max_cursor_size;
+
+	properties->cursor_size_limit = max_cursor_size;
 }
 
 /**
@@ -6346,3 +6354,27 @@ unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context)
 	else
 		return 0;
 }
+
+bool dc_is_cursor_limit_pending(struct dc *dc)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		if (dc_stream_is_cursor_limit_pending(dc, dc->current_state->streams[i]))
+			return true;
+	}
+
+	return false;
+}
+
+bool dc_can_clear_cursor_limit(struct dc *dc)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		if (dc_state_can_clear_stream_cursor_subvp_limit(dc->current_state->streams[i], dc->current_state))
+			return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 650e89825968..7551d0a3fe82 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -266,6 +266,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "Fail dp payload allocation";
 	case DC_FAIL_DP_LINK_BANDWIDTH:
 		return "Insufficient DP link bandwidth";
+	case DC_FAIL_HW_CURSOR_SUPPORT:
+		return "HW Cursor not supported";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 313a32248cd7..13559fe56062 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1342,32 +1342,6 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 	data->viewport_c.y += src.y / vpc_div;
 }
 
-static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
-{
-	uint32_t refresh_rate;
-	struct dc *dc = stream->ctx->dc;
-
-	refresh_rate = (stream->timing.pix_clk_100hz * (uint64_t)100 +
-		stream->timing.v_total * stream->timing.h_total - (uint64_t)1);
-	refresh_rate = div_u64(refresh_rate, stream->timing.v_total);
-	refresh_rate = div_u64(refresh_rate, stream->timing.h_total);
-
-	/* If there's any stream that fits the SubVP high refresh criteria,
-	 * we must return true. This is because cursor updates are asynchronous
-	 * with full updates, so we could transition into a SubVP config and
-	 * remain in HW cursor mode if there's no cursor update which will
-	 * then cause corruption.
-	 */
-	if ((refresh_rate >= 120 && refresh_rate <= 175 &&
-			stream->timing.v_addressable >= 1080 &&
-			stream->timing.v_addressable <= 2160) &&
-			(dc->current_state->stream_count > 1 ||
-			(dc->current_state->stream_count == 1 && !stream->allow_freesync)))
-		return true;
-
-	return false;
-}
-
 static enum controller_dp_test_pattern convert_dp_to_controller_test_pattern(
 				enum dp_test_pattern test_pattern)
 {
@@ -4259,6 +4233,11 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 		}
 	}
 
+	/* clear subvp cursor limitations */
+	for (i = 0; i < context->stream_count; i++) {
+		dc_state_set_stream_subvp_cursor_limit(context->streams[i], context, false);
+	}
+
 	res = dc_validate_global_state(dc, context, fast_validate);
 
 	/* calculate pixel rate divider after deciding pxiel clock & odm combine  */
@@ -4385,8 +4364,7 @@ enum dc_status dc_validate_global_state(
 	result = resource_build_scaling_params_for_context(dc, new_ctx);
 
 	if (result == DC_OK)
-		if (!dc->res_pool->funcs->validate_bandwidth(dc, new_ctx, fast_validate))
-			result = DC_FAIL_BANDWIDTH_VALIDATE;
+		result = dc->res_pool->funcs->validate_bandwidth(dc, new_ctx, fast_validate);
 
 	return result;
 }
@@ -5538,20 +5516,6 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 	return DC_OK;
 }
 
-bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream)
-{
-	if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
-		return true;
-	if (dc->current_state->stream_count == 1 && stream->timing.v_addressable >= 2880 &&
-			((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
-		return true;
-	else if (dc->current_state->stream_count > 1 && stream->timing.v_addressable >= 1080 &&
-			((stream->timing.pix_clk_100hz * 100) / stream->timing.v_total / stream->timing.h_total) < 120)
-		return true;
-
-	return false;
-}
-
 struct dscl_prog_data *resource_get_dscl_prog_data(struct pipe_ctx *pipe_ctx)
 {
 	return &pipe_ctx->plane_res.scl_data.dscl_prog_data;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 1b2cce127981..8800ea512a21 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -22,6 +22,7 @@
  * Authors: AMD
  *
  */
+#include "dc_types.h"
 #include "core_types.h"
 #include "core_status.h"
 #include "dc_state.h"
@@ -812,8 +813,12 @@ enum dc_status dc_state_add_phantom_stream(const struct dc *dc,
 	if (phantom_stream_status) {
 		phantom_stream_status->mall_stream_config.type = SUBVP_PHANTOM;
 		phantom_stream_status->mall_stream_config.paired_stream = main_stream;
+		phantom_stream_status->mall_stream_config.subvp_limit_cursor_size = false;
+		phantom_stream_status->mall_stream_config.cursor_size_limit_subvp = false;
 	}
 
+	dc_state_set_stream_subvp_cursor_limit(main_stream, state, true);
+
 	return res;
 }
 
@@ -977,3 +982,94 @@ bool dc_state_is_fams2_in_use(
 
 	return is_fams2_in_use;
 }
+
+void dc_state_set_stream_subvp_cursor_limit(const struct dc_stream_state *stream,
+		struct dc_state *state,
+		bool limit)
+{
+	struct dc_stream_status *stream_status;
+
+	stream_status = dc_state_get_stream_status(state, stream);
+
+	if (stream_status) {
+		stream_status->mall_stream_config.subvp_limit_cursor_size = limit;
+	}
+}
+
+bool dc_state_get_stream_subvp_cursor_limit(const struct dc_stream_state *stream,
+		struct dc_state *state)
+{
+	bool limit = false;
+
+	struct dc_stream_status *stream_status;
+
+	stream_status = dc_state_get_stream_status(state, stream);
+
+	if (stream_status) {
+		limit = stream_status->mall_stream_config.subvp_limit_cursor_size;
+	}
+
+	return limit;
+}
+
+void dc_state_set_stream_cursor_subvp_limit(const struct dc_stream_state *stream,
+		struct dc_state *state,
+		bool limit)
+{
+	struct dc_stream_status *stream_status;
+
+	stream_status = dc_state_get_stream_status(state, stream);
+
+	if (stream_status) {
+		stream_status->mall_stream_config.cursor_size_limit_subvp = limit;
+	}
+}
+
+bool dc_state_get_stream_cursor_subvp_limit(const struct dc_stream_state *stream,
+		struct dc_state *state)
+{
+	bool limit = false;
+
+	struct dc_stream_status *stream_status;
+
+	stream_status = dc_state_get_stream_status(state, stream);
+
+	if (stream_status) {
+		limit = stream_status->mall_stream_config.cursor_size_limit_subvp;
+	}
+
+	return limit;
+}
+
+bool dc_state_can_clear_stream_cursor_subvp_limit(const struct dc_stream_state *stream,
+		struct dc_state *state)
+{
+	bool can_clear_limit = false;
+
+	struct dc_stream_status *stream_status;
+
+	stream_status = dc_state_get_stream_status(state, stream);
+
+	if (stream_status) {
+		can_clear_limit = dc_state_get_stream_cursor_subvp_limit(stream, state) &&
+				(stream_status->mall_stream_config.type == SUBVP_PHANTOM ||
+				stream->hw_cursor_req ||
+				!stream_status->mall_stream_config.subvp_limit_cursor_size ||
+				!stream->cursor_position.enable ||
+				dc_stream_check_cursor_attributes(stream, state, &stream->cursor_attributes));
+	}
+
+	return can_clear_limit;
+}
+
+bool dc_state_is_subvp_in_use(struct dc_state *state)
+{
+	uint32_t i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		if (dc_state_get_stream_subvp_type(state, state->streams[i]) != SUBVP_NONE)
+			return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 0478dd856d8c..e6e41678525f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -265,13 +265,16 @@ void program_cursor_attributes(
 }
 
 /*
- * dc_stream_set_cursor_attributes() - Update cursor attributes and set cursor surface address
+ * dc_stream_check_cursor_attributes() - Check validitity of cursor attributes and surface address
  */
-bool dc_stream_set_cursor_attributes(
-	struct dc_stream_state *stream,
+bool dc_stream_check_cursor_attributes(
+	const struct dc_stream_state *stream,
+	struct dc_state *state,
 	const struct dc_cursor_attributes *attributes)
 {
-	struct dc  *dc;
+	const struct dc *dc;
+
+	unsigned int max_cursor_size;
 
 	if (NULL == stream) {
 		dm_error("DC: dc_stream is NULL!\n");
@@ -289,24 +292,38 @@ bool dc_stream_set_cursor_attributes(
 
 	dc = stream->ctx->dc;
 
-	/* SubVP is not compatible with HW cursor larger than 64 x 64 x 4.
-	 * Therefore, if cursor is greater than 64 x 64 x 4, fallback to SW cursor in the following case:
-	 * 1. If the config is a candidate for SubVP high refresh (both single an dual display configs)
-	 * 2. If not subvp high refresh, for single display cases, if resolution is >= 5K and refresh rate < 120hz
-	 * 3. If not subvp high refresh, for multi display cases, if resolution is >= 4K and refresh rate < 120hz
+	/* SubVP is not compatible with HW cursor larger than what can fit in cursor SRAM.
+	 * Therefore, if cursor is greater than this, fallback to SW cursor.
 	 */
-	if (dc->debug.allow_sw_cursor_fallback &&
-		attributes->height * attributes->width * 4 > 16384 &&
-		!stream->hw_cursor_req) {
-		if (check_subvp_sw_cursor_fallback_req(dc, stream))
+	if (dc->debug.allow_sw_cursor_fallback && dc->res_pool->funcs->get_max_hw_cursor_size) {
+		max_cursor_size = dc->res_pool->funcs->get_max_hw_cursor_size(dc, state, stream);
+		max_cursor_size = max_cursor_size * max_cursor_size * 4;
+
+		if (attributes->height * attributes->width * 4 > max_cursor_size) {
 			return false;
+		}
 	}
 
-	stream->cursor_attributes = *attributes;
-
 	return true;
 }
 
+/*
+ * dc_stream_set_cursor_attributes() - Update cursor attributes and set cursor surface address
+ */
+bool dc_stream_set_cursor_attributes(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_attributes *attributes)
+{
+	bool result = false;
+
+	if (dc_stream_check_cursor_attributes(stream, stream->ctx->dc->current_state, attributes)) {
+		stream->cursor_attributes = *attributes;
+		result = true;
+	}
+
+	return result;
+}
+
 bool dc_stream_program_cursor_attributes(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_attributes *attributes)
@@ -1109,3 +1126,26 @@ unsigned int dc_stream_get_max_flickerless_instant_vtotal_increase(struct dc_str
 
 	return dc_stream_get_max_flickerless_instant_vtotal_delta(stream, is_gaming, false);
 }
+
+bool dc_stream_is_cursor_limit_pending(struct dc *dc, struct dc_stream_state *stream)
+{
+	bool is_limit_pending = false;
+
+	if (dc->current_state)
+		is_limit_pending = dc_state_get_stream_cursor_subvp_limit(stream, dc->current_state);
+
+	return is_limit_pending;
+}
+
+bool dc_stream_can_clear_cursor_limit(struct dc *dc, struct dc_stream_state *stream)
+{
+	bool can_clear_limit = false;
+
+	if (dc->current_state)
+		can_clear_limit = dc_state_get_stream_cursor_subvp_limit(stream, dc->current_state) &&
+				(stream->hw_cursor_req ||
+				!stream->cursor_position.enable ||
+				dc_stream_check_cursor_attributes(stream, dc->current_state, &stream->cursor_attributes));
+
+	return can_clear_limit;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a5592558fa7e..4e7423cfe799 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -249,6 +249,7 @@ struct dc_caps {
 	uint32_t i2c_speed_in_khz_hdcp;
 	uint32_t dmdata_alloc_size;
 	unsigned int max_cursor_size;
+	unsigned int max_buffered_cursor_size;
 	unsigned int max_video_width;
 	/*
 	 * max video plane width that can be safely assumed to be always
@@ -2607,4 +2608,7 @@ void dc_disable_accelerated_mode(struct dc *dc);
 bool dc_is_timing_changed(struct dc_stream_state *cur_stream,
 		       struct dc_stream_state *new_stream);
 
+bool dc_is_cursor_limit_pending(struct dc *dc);
+bool dc_can_clear_cursor_limit(struct dc *dc);
+
 #endif /* DC_INTERFACE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
index 1a12ef579ff4..1d9bae56ff6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
@@ -105,4 +105,24 @@ bool dc_state_is_fams2_in_use(
 		const struct dc *dc,
 		const struct dc_state *state);
 
+
+void dc_state_set_stream_subvp_cursor_limit(const struct dc_stream_state *stream,
+		struct dc_state *state,
+		bool limit);
+
+bool dc_state_get_stream_subvp_cursor_limit(const struct dc_stream_state *stream,
+		struct dc_state *state);
+
+void dc_state_set_stream_cursor_subvp_limit(const struct dc_stream_state *stream,
+		struct dc_state *state,
+		bool limit);
+
+bool dc_state_get_stream_cursor_subvp_limit(const struct dc_stream_state *stream,
+		struct dc_state *state);
+
+bool dc_state_can_clear_stream_cursor_subvp_limit(const struct dc_stream_state *stream,
+		struct dc_state *state);
+
+bool dc_state_is_subvp_in_use(struct dc_state *state);
+
 #endif /* _DC_STATE_PRIV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e0bfddaa23e3..341d2ffb64b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -44,6 +44,8 @@ struct mall_stream_config {
 	 */
 	enum mall_stream_type type;
 	struct dc_stream_state *paired_stream;	// master / slave stream
+	bool subvp_limit_cursor_size; /* stream has/is using subvp limiting hw cursor support */
+	bool cursor_size_limit_subvp; /* stream is using hw cursor config preventing subvp */
 };
 
 struct dc_stream_status {
@@ -503,6 +505,11 @@ void program_cursor_position(
 	struct dc *dc,
 	struct dc_stream_state *stream);
 
+bool dc_stream_check_cursor_attributes(
+	const struct dc_stream_state *stream,
+	struct dc_state *state,
+	const struct dc_cursor_attributes *attributes);
+
 bool dc_stream_set_cursor_attributes(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_attributes *attributes);
@@ -579,4 +586,8 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 			       struct dc_stream_state *stream,
 			       struct dc_surface_update *srf_updates,
 			       struct dc_state *context);
+
+bool dc_stream_is_cursor_limit_pending(struct dc *dc, struct dc_stream_state *stream);
+bool dc_stream_can_clear_cursor_limit(struct dc *dc, struct dc_stream_state *stream);
+
 #endif /* DC_STREAM_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 56dda686e299..b0fc1fd20208 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -627,6 +627,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe && !dcn32_is_center_timing(pipe) &&
 				!pipe->stream->hw_cursor_req &&
+				!dc_state_get_stream_cursor_subvp_limit(pipe->stream, context) &&
 				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index f721aabdd470..ed75319a07d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -526,7 +526,8 @@ static void populate_dml21_output_config_from_stream_state(struct dml2_link_outp
 
 static void populate_dml21_stream_overrides_from_stream_state(
 		struct dml2_stream_parameters *stream_desc,
-		struct dc_stream_state *stream)
+		struct dc_stream_state *stream,
+		struct dc_stream_status *stream_status)
 {
 	switch (stream->debug.force_odm_combine_segments) {
 	case 0:
@@ -551,7 +552,9 @@ static void populate_dml21_stream_overrides_from_stream_state(
 	if (!stream->ctx->dc->debug.enable_single_display_2to1_odm_policy ||
 			stream->debug.force_odm_combine_segments > 0)
 		stream_desc->overrides.disable_dynamic_odm = true;
-	stream_desc->overrides.disable_subvp = stream->ctx->dc->debug.force_disable_subvp || stream->hw_cursor_req;
+	stream_desc->overrides.disable_subvp = stream->ctx->dc->debug.force_disable_subvp ||
+			stream->hw_cursor_req ||
+			stream_status->mall_stream_config.cursor_size_limit_subvp;
 }
 
 static enum dml2_swizzle_mode gfx_addr3_to_dml2_swizzle_mode(enum swizzle_mode_addr3_values addr3_mode)
@@ -1024,7 +1027,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], dml_ctx);
 		adjust_dml21_hblank_timing_config_from_pipe_ctx(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
-		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index]);
+		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index], &context->stream_status[stream_index]);
 
 		dml_dispcfg->stream_descriptors[disp_cfg_stream_location].overrides.hw.twait_budgeting.fclk_pstate = dml2_twait_budgeting_setting_if_needed;
 		dml_dispcfg->stream_descriptors[disp_cfg_stream_location].overrides.hw.twait_budgeting.uclk_pstate = dml2_twait_budgeting_setting_if_needed;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 846c9c51f2d9..5e78b553adbd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2482,7 +2482,7 @@ bool dcn20_update_bandwidth(
 	struct dce_hwseq *hws = dc->hwseq;
 
 	/* recalculate DML parameters */
-	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false))
+	if (dc->res_pool->funcs->validate_bandwidth(dc, context, false) != DC_OK)
 		return false;
 
 	/* apply updated bandwidth parameters */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 423c0d28218b..8611eb9607df 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2650,7 +2650,7 @@ bool dcn401_update_bandwidth(
 	struct dce_hwseq *hws = dc->hwseq;
 
 	/* recalculate DML parameters */
-	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false))
+	if (dc->res_pool->funcs->validate_bandwidth(dc, context, false) != DC_OK)
 		return false;
 
 	/* apply updated bandwidth parameters */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index b5afd8c3103d..f3696143590c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -26,6 +26,8 @@
 #ifndef _CORE_STATUS_H_
 #define _CORE_STATUS_H_
 
+#include "dc_hw_types.h"
+
 enum dc_status {
 	DC_OK = 1,
 
@@ -56,6 +58,7 @@ enum dc_status {
 	DC_NO_LINK_ENC_RESOURCE = 26,
 	DC_FAIL_DP_PAYLOAD_ALLOCATION = 27,
 	DC_FAIL_DP_LINK_BANDWIDTH = 28,
+	DC_FAIL_HW_CURSOR_SUPPORT = 29,
 	DC_ERROR_UNEXPECTED = -1
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 1ed3461440aa..bae98d994275 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -79,7 +79,7 @@ struct resource_funcs {
 	 * associated with it. */
 	struct link_encoder *(*link_enc_create_minimal)(struct dc_context *ctx, enum engine_id eng_id);
 
-	bool (*validate_bandwidth)(
+	enum dc_status (*validate_bandwidth)(
 					struct dc *dc,
 					struct dc_state *context,
 					bool fast_validate);
@@ -218,6 +218,9 @@ struct resource_funcs {
 	int (*get_power_profile)(const struct dc_state *context);
 	unsigned int (*get_det_buffer_size)(const struct dc_state *context);
 	unsigned int (*get_vstartup_for_pipe)(struct pipe_ctx *pipe_ctx);
+	unsigned int (*get_max_hw_cursor_size)(const struct dc *dc,
+			struct dc_state *state,
+			const struct dc_stream_state *stream);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 9458187b834d..7a87a7c07c1b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -628,8 +628,6 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 		struct dc_state *context,
 		struct pipe_ctx *pipe_ctx);
 
-bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream);
-
 /* Get hw programming parameters container from pipe context
  * @pipe_ctx: pipe context
  * @dscl_prog_data: struct to hold programmable hw reg values
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index e0c64861eff3..84f73fdb0f95 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -836,7 +836,7 @@ static enum dc_status build_mapped_resource(
 	return DC_OK;
 }
 
-static bool dce100_validate_bandwidth(
+static enum dc_status dce100_validate_bandwidth(
 	struct dc  *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -858,7 +858,7 @@ static bool dce100_validate_bandwidth(
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
-	return true;
+	return DC_OK;
 }
 
 static bool dce100_validate_surface_sets(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index 035c6cfdaee5..f3d5baac11bf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -960,7 +960,7 @@ static enum dc_status build_mapped_resource(
 	return DC_OK;
 }
 
-static bool dce110_validate_bandwidth(
+static enum dc_status dce110_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -1031,7 +1031,7 @@ static bool dce110_validate_bandwidth(
 			context->bw_ctx.bw.dce.yclk_khz,
 			context->bw_ctx.bw.dce.blackout_recovery_time_us);
 	}
-	return result;
+	return result ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 static enum dc_status dce110_validate_plane(const struct dc_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 480a50967385..4225cae68c10 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -883,7 +883,7 @@ static enum dc_status build_mapped_resource(
 	return DC_OK;
 }
 
-bool dce112_validate_bandwidth(
+enum dc_status dce112_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -952,7 +952,7 @@ bool dce112_validate_bandwidth(
 			context->bw_ctx.bw.dce.yclk_khz,
 			context->bw_ctx.bw.dce.blackout_recovery_time_us);
 	}
-	return result;
+	return result ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 enum dc_status resource_map_phy_clock_resources(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
index 1f57ebc6f9b4..6221d749246d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
@@ -42,7 +42,7 @@ enum dc_status dce112_validate_with_context(
 		struct dc_state *context,
 		struct dc_state *old_context);
 
-bool dce112_validate_bandwidth(
+enum dc_status dce112_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
 	bool fast_validate);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 3d5113f010bb..bd5811f97531 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -869,7 +869,7 @@ static void dce80_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-static bool dce80_validate_bandwidth(
+static enum dc_status dce80_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -891,7 +891,7 @@ static bool dce80_validate_bandwidth(
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
-	return true;
+	return DC_OK;
 }
 
 static bool dce80_validate_surface_sets(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index e92f14d50adb..9d8ecc6229d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include "core_status.h"
 #include "dm_services.h"
 #include "dc.h"
 
@@ -1125,7 +1126,7 @@ static void dcn10_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
-static bool dcn10_validate_bandwidth(
+static enum dc_status dcn10_validate_bandwidth(
 		struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -1136,7 +1137,7 @@ static bool dcn10_validate_bandwidth(
 	voltage_supported = dcn_validate_bandwidth(dc, context, fast_validate);
 	DC_FP_END();
 
-	return voltage_supported;
+	return voltage_supported ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 static enum dc_status dcn10_validate_plane(const struct dc_plane_state *plane_state, struct dc_caps *caps)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index e4eca3e32c1b..3405be07f5e3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2124,7 +2124,7 @@ bool dcn20_fast_validate_bw(
 	return out;
 }
 
-bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
+enum dc_status dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate)
 {
 	bool voltage_supported;
@@ -2132,14 +2132,14 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 
 	pipes = kcalloc(dc->res_pool->pipe_count, sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
 	if (!pipes)
-		return false;
+		return DC_FAIL_BANDWIDTH_VALIDATE;
 
 	DC_FP_START();
 	voltage_supported = dcn20_validate_bandwidth_fp(dc, context, fast_validate, pipes);
 	DC_FP_END();
 
 	kfree(pipes);
-	return voltage_supported;
+	return voltage_supported ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
index 4cee3fa11a7f..c0e062c7407d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
@@ -119,7 +119,7 @@ void dcn20_set_mcif_arb_params(
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt);
-bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context, bool fast_validate);
+enum dc_status dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context, bool fast_validate);
 void dcn20_merge_pipes_for_validate(
 		struct dc *dc,
 		struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 4bd5c2278596..9ab01b65b177 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -923,7 +923,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
  * with DC_FP_START()/DC_FP_END(). Use the same approach as for
  * dcn20_validate_bandwidth in dcn20_resource.c.
  */
-static bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
+static enum dc_status dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate)
 {
 	bool voltage_supported;
@@ -931,14 +931,14 @@ static bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 
 	pipes = kcalloc(dc->res_pool->pipe_count, sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
 	if (!pipes)
-		return false;
+		return DC_FAIL_BANDWIDTH_VALIDATE;
 
 	DC_FP_START();
 	voltage_supported = dcn21_validate_bandwidth_fp(dc, context, fast_validate, pipes);
 	DC_FP_END();
 
 	kfree(pipes);
-	return voltage_supported;
+	return voltage_supported ? DC_OK : DC_NOT_SUPPORTED;
 }
 
 static void dcn21_destroy_resource_pool(struct resource_pool **pool)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index f040c22db59b..f631ae34e320 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2035,7 +2035,7 @@ void dcn30_calculate_wm_and_dlg(
 	DC_FP_END();
 }
 
-bool dcn30_validate_bandwidth(struct dc *dc,
+enum dc_status dcn30_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -2092,7 +2092,7 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_FINISH();
 
-	return out;
+	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.h
index 8e6b8b7368fd..689d9bdace81 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.h
@@ -56,7 +56,7 @@ unsigned int dcn30_calc_max_scaled_time(
 		enum mmhubbub_wbif_mode mode,
 		unsigned int urgent_watermark);
 
-bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
+enum dc_status dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate);
 bool dcn30_internal_validate_bw(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index dddddbfef85f..7e0af5297dc4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1758,7 +1758,7 @@ dcn31_set_mcif_arb_params(struct dc *dc,
 	DC_FP_END();
 }
 
-bool dcn31_validate_bandwidth(struct dc *dc,
+enum dc_status dcn31_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -1813,7 +1813,7 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_FINISH();
 
-	return out;
+	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 static void dcn31_get_panel_config_defaults(struct dc_panel_config *panel_config)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index 551ad912f7be..dd82815d7efe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -37,7 +37,7 @@ struct dcn31_resource_pool {
 	struct resource_pool base;
 };
 
-bool dcn31_validate_bandwidth(struct dc *dc,
+enum dc_status dcn31_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate);
 void dcn31_calculate_wm_and_dlg(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 26becc4cb804..d96bc6cb73ad 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1694,7 +1694,7 @@ static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
-bool dcn314_validate_bandwidth(struct dc *dc,
+enum dc_status dcn314_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -1750,7 +1750,7 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_FINISH();
 
-	return out;
+	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 static struct resource_funcs dcn314_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.h
index 49ffe71018df..f8ba531d6342 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.h
@@ -39,7 +39,7 @@ struct dcn314_resource_pool {
 	struct resource_pool base;
 };
 
-bool dcn314_validate_bandwidth(struct dc *dc,
+enum dc_status dcn314_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 2a59cc61ed8c..6dda862b47e3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include "dc_types.h"
 #include "dm_services.h"
 #include "dc.h"
 
@@ -1806,19 +1807,56 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
 	return out;
 }
 
-bool dcn32_validate_bandwidth(struct dc *dc,
+enum dc_status dcn32_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
-	bool out = false;
+	unsigned int i;
+	enum dc_status status;
+	const struct dc_stream_state *stream;
+
+	/* reset cursor limitations on subvp */
+	for (i = 0; i < context->stream_count; i++) {
+		stream = context->streams[i];
+
+		if (dc_state_can_clear_stream_cursor_subvp_limit(stream, context)) {
+			dc_state_set_stream_cursor_subvp_limit(stream, context, false);
+		}
+	}
 
 	if (dc->debug.using_dml2)
-		out = dml2_validate(dc, context,
+		status = dml2_validate(dc, context,
 				context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
-				fast_validate);
+				fast_validate) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 	else
-		out = dml1_validate(dc, context, fast_validate);
-	return out;
+		status = dml1_validate(dc, context, fast_validate) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+
+	if (!fast_validate && status == DC_OK && dc_state_is_subvp_in_use(context)) {
+		/* check new stream configuration still supports cursor if subvp used */
+		for (i = 0; i < context->stream_count; i++) {
+			stream = context->streams[i];
+
+			if (dc_state_get_stream_subvp_type(context, stream) != SUBVP_PHANTOM &&
+					stream->cursor_position.enable &&
+					!dc_stream_check_cursor_attributes(stream, context, &stream->cursor_attributes)) {
+				/* hw cursor cannot be supported with subvp active, so disable subvp for now */
+				dc_state_set_stream_cursor_subvp_limit(stream, context, true);
+				status = DC_FAIL_HW_CURSOR_SUPPORT;
+			}
+		};
+	}
+
+	if (!fast_validate && status == DC_FAIL_HW_CURSOR_SUPPORT) {
+		/* attempt to validate again with subvp disabled due to cursor */
+		if (dc->debug.using_dml2)
+			status = dml2_validate(dc, context,
+					context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
+					fast_validate) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+		else
+			status = dml1_validate(dc, context, fast_validate) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+	}
+
+	return status;
 }
 
 int dcn32_populate_dml_pipes_from_context(
@@ -2042,6 +2080,18 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 	DC_FP_END();
 }
 
+unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
+			struct dc_state *state,
+			const struct dc_stream_state *stream)
+{
+	bool limit_cur_to_buf;
+
+	limit_cur_to_buf = dc_state_get_stream_subvp_cursor_limit(stream, state) &&
+			!stream->hw_cursor_req;
+
+	return limit_cur_to_buf ? dc->caps.max_buffered_cursor_size : dc->caps.max_cursor_size;
+}
+
 static struct resource_funcs dcn32_res_pool_funcs = {
 	.destroy = dcn32_destroy_resource_pool,
 	.link_enc_create = dcn32_link_encoder_create,
@@ -2067,7 +2117,8 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_max_hw_cursor_size = dcn32_get_max_hw_cursor_size,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 1aa4ced29291..d60ed77eda80 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -98,7 +98,7 @@ void dcn32_add_phantom_pipes(struct dc *dc,
 		unsigned int pipe_cnt,
 		unsigned int index);
 
-bool dcn32_validate_bandwidth(struct dc *dc,
+enum dc_status dcn32_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate);
 
@@ -188,6 +188,10 @@ void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context);
 
 unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned int total_size_in_mall_bytes);
 
+unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
+			struct dc_state *state,
+			const struct dc_stream_state *stream);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 38d76434683e..3b91b7379cf3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1624,7 +1624,8 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_max_hw_cursor_size = dcn32_get_max_hw_cursor_size,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index ffd2b816cd02..fb91209a06e8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1732,7 +1732,7 @@ static void dcn35_get_panel_config_defaults(struct dc_panel_config *panel_config
 }
 
 
-static bool dcn35_validate_bandwidth(struct dc *dc,
+static enum dc_status dcn35_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -1743,13 +1743,13 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 			fast_validate);
 
 	if (fast_validate)
-		return out;
+		return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 
 	DC_FP_START();
 	dcn35_decide_zstate_support(dc, context);
 	DC_FP_END();
 
-	return out;
+	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 enum dc_status dcn35_patch_unknown_plane_state(struct dc_plane_state *plane_state)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 98f5bc1b929e..989a270f7dea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1712,7 +1712,7 @@ static void dcn35_get_panel_config_defaults(struct dc_panel_config *panel_config
 }
 
 
-static bool dcn351_validate_bandwidth(struct dc *dc,
+static enum dc_status dcn351_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -1723,13 +1723,13 @@ static bool dcn351_validate_bandwidth(struct dc *dc,
 			fast_validate);
 
 	if (fast_validate)
-		return out;
+		return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 
 	DC_FP_START();
 	dcn35_decide_zstate_support(dc, context);
 	DC_FP_END();
 
-	return out;
+	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 static struct resource_funcs dcn351_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index b6468573dc33..96c8288fb7fa 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1713,7 +1713,7 @@ static void dcn35_get_panel_config_defaults(struct dc_panel_config *panel_config
 }
 
 
-static bool dcn35_validate_bandwidth(struct dc *dc,
+static enum dc_status dcn35_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -1724,13 +1724,13 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 			fast_validate);
 
 	if (fast_validate)
-		return out;
+		return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 
 	DC_FP_START();
 	dcn35_decide_zstate_support(dc, context);
 	DC_FP_END();
 
-	return out;
+	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 7436dfbdf927..5b7148bb1701 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1642,16 +1642,52 @@ enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_sta
 	return DC_OK;
 }
 
-bool dcn401_validate_bandwidth(struct dc *dc,
+enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
-	bool out = false;
+	unsigned int i;
+	enum dc_status status = DC_OK;
+	const struct dc_stream_state *stream;
+
+	/* reset cursor limitations on subvp */
+	for (i = 0; i < context->stream_count; i++) {
+		stream = context->streams[i];
+
+		if (dc_state_can_clear_stream_cursor_subvp_limit(stream, context)) {
+			dc_state_set_stream_cursor_subvp_limit(stream, context, false);
+		}
+	}
+
 	if (dc->debug.using_dml2)
-		out = dml2_validate(dc, context,
+		status = dml2_validate(dc, context,
 				context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
-				fast_validate);
-	return out;
+				fast_validate) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+
+	if (!fast_validate && status == DC_OK && dc_state_is_subvp_in_use(context)) {
+		/* check new stream configuration still supports cursor if subvp used */
+		for (i = 0; i < context->stream_count; i++) {
+			stream = context->streams[i];
+
+			if (dc_state_get_stream_subvp_type(context, stream) != SUBVP_PHANTOM &&
+					stream->cursor_position.enable &&
+					!dc_stream_check_cursor_attributes(stream, context, &stream->cursor_attributes))	{
+				/* hw cursor cannot be supported with subvp active, so disable subvp for now */
+				dc_state_set_stream_cursor_subvp_limit(stream, context, true);
+				status = DC_FAIL_HW_CURSOR_SUPPORT;
+			}
+		};
+	}
+
+	if (!fast_validate && status == DC_FAIL_HW_CURSOR_SUPPORT) {
+		/* attempt to validate again with subvp disabled due to cursor */
+		if (dc->debug.using_dml2)
+			status = dml2_validate(dc, context,
+					context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
+					fast_validate) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+	}
+
+	return status;
 }
 
 void dcn401_prepare_mcache_programming(struct dc *dc,
@@ -1770,7 +1806,8 @@ static struct resource_funcs dcn401_res_pool_funcs = {
 	.build_pipe_pix_clk_params = dcn401_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 	.get_power_profile = dcn401_get_power_profile,
-	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe,
+	.get_max_hw_cursor_size = dcn32_get_max_hw_cursor_size
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 4c259745d519..dc52a30991af 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -22,7 +22,7 @@ struct resource_pool *dcn401_create_resource_pool(
 
 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state);
 
-bool dcn401_validate_bandwidth(struct dc *dc,
+enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate);
 
-- 
2.34.1

