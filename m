Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F021C432BE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C4960041
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7C4960041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF34A6EB93;
	Fri,  6 Aug 2021 16:36:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E3F6EBD0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH9a5qiQ9wwcDrY/LU3hATZAb5e8zL7BVVuSO6qtXDMtnFeU6OPXorkj5OzqbnrLUD5PDe5YhOxEXfU8VH0PYAEnACAcKOcTAYA9+DwVGYPy9LtvmPIryDfMjJ7LyWniEQYs4O7GUZfNOGllWC+KZ3akMLqVDGABk2fUf7xTWXc4Gz98+3KHBCNU1COxd7d1m9kqYmbrr3O7t6cpatZ8y/YpjXsHI9qbKLFa1VLQaAxcWnIBFM5WS1mPvOye5f0Csz79eyOMqfvcYT3OmWEaitHq9/04Q7nqQb2ZTHY11/4NbpDmHeiITx/D91ZED/cSqmSKG5X5YwvihdvSOm0diA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l33VWLrV4DillFMR98RmEr+5o4Eo4n0RJofZJxXnfZo=;
 b=Nkq6t4XTevq6GmO7r21FoR7UpMfKFQ2xMMcnAWygSwj7xoRhX/+kVBw5NVKpwcHTdjFzYBzQ+CzIGMWjQqRlIq71x6h3jU3tZjzIwT14SwAzZn32N9O1Ta6ijRzcvJPk1s9XOpfzdxrGy9HzxjC80tu6OuLrJrk7FIHVVaBl7Y5nA0y5n4jZ+6QH7P6rjzpnc0NAdz2FDNerY36cl598A9knb2G0ZxMjXq9tNoNI0m5V07bKJli0AUi7/T2GCyzb5i20k4LecR1jdo+xuRoaTS0TXXaqBsJxEsolHM0/RtOP5uFLGWatO8plnFk3oQaFxr14WihA6IbT4LyIxb0XMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l33VWLrV4DillFMR98RmEr+5o4Eo4n0RJofZJxXnfZo=;
 b=f1jdk1Gmlu1n4zo2S7Z6EScef5ho9dS0m5OPq+CuspgjmUC2j7Hf+kRKnigPjFxWypjltik5hy4sApqeuyLnWsf02pE79VWHRuRx4Qc7L6WX2FNq3AixNDVMeW8Ef41w7HyrbXZKJo4Lp4+F3CxGgRGt4tzyuhStnCSqNWoEXbw=
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by DM6PR12MB4652.namprd12.prod.outlook.com (2603:10b6:5:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 16:35:38 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::17) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 09:35:36 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:34 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Roy Chan <roy.chan@amd.com>
Subject: [PATCH 03/13] drm/amd/display: refactor the codes to centralize the
 stream/pipe checking logic
Date: Fri, 6 Aug 2021 12:34:39 -0400
Message-ID: <20210806163449.349757-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cf22048-c142-4243-7b6d-08d958f8390d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4652:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4652332C3CA1C5E13F9D6D7FEBF39@DM6PR12MB4652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0tDWyPgAH8ZWspsO8mFKHmHqu5M+xp7BUwx/fSNxdMQb+a6+YeYj/ernEti9KcPUad9AOPNS6ot0jJl7xRJJyv4AbrDLXABJ1wz8+9pkGBtopeAVVVUTupDVNlUnNkSeMWAl9nybJZHq78bLdElx3dKaEBgpNHs1OqXz+Ji9sNiXBI2xyIkD1iqbsjlohQRSnNXoaUWVmVFSm93Z93NrZhPdDyGqG7oGCX4bjpCEKCp3MddJTu1kHatYvc/gDAWDPgdCauztWXdTmvpD77WkR0pQ00AIA4DPxy6UxYg99yInveRkQLAtSZEJBXFeo8YeHSzTPKQDBW0RnrDMJ1slmIJEwkNjAAKgebmxbSba6uEsXKxDYUbibPhfmwF/Zk370d8CMFeolyowDkXV2u4qwwQsEOCH+9UUWzb0TLtLgUJzI7rg8AeJJEia+EuskoSfIUmPw1BjGWQQEb7+SJm4sKkr2sq5tm6O6vk4xBue5tzOjlh8nV3Vs52tXhaZO6X9Hb8vB+stXOCMjZBoYTcKYn/vgaS4s1J+KOjx3D4I1/GKxOLv2Rzkz9Uvnkrc8IR0L/PNmSzatoC3uAaIMmE2031gxDemGqrGLEc7WD6HHHSGhs8MVsDW+OHdcQpIcotefP8eHfdwgtt9e3ekJYrAbvYyuOOk1VKDh2pDtrCmKc4mSu5pzPyNImOpPGoNizMbadILmTUzkY70SzuFoCpYo01mxxaWB5mAmfQkA5Gc9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(336012)(82740400003)(82310400003)(5660300002)(356005)(36860700001)(54906003)(2906002)(478600001)(4326008)(47076005)(426003)(81166007)(6916009)(316002)(86362001)(70586007)(7696005)(70206006)(8936002)(26005)(2616005)(186003)(8676002)(1076003)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:38.1514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf22048-c142-4243-7b6d-08d958f8390d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4652
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

From: Roy Chan <roy.chan@amd.com>

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Roy Chan <roy.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 62 ++++++++++++++++--------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 605e297b7a59..7a442fcfa6ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1481,6 +1481,22 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 	return true;
 }
 
+static inline bool should_update_pipe_for_stream(
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	return (pipe_ctx->stream && pipe_ctx->stream == stream);
+}
+
+static inline bool should_update_pipe_for_plane(
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_plane_state *plane_state)
+{
+	return (pipe_ctx->plane_state == plane_state);
+}
+
 void dc_enable_stereo(
 	struct dc *dc,
 	struct dc_state *context,
@@ -1491,12 +1507,15 @@ void dc_enable_stereo(
 	struct pipe_ctx *pipe;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		if (context != NULL)
+		if (context != NULL) {
 			pipe = &context->res_ctx.pipe_ctx[i];
-		else
+		} else {
+			context = dc->current_state;
 			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-		for (j = 0 ; pipe && j < stream_count; j++)  {
-			if (streams[j] && streams[j] == pipe->stream &&
+		}
+
+		for (j = 0; pipe && j < stream_count; j++)  {
+			if (should_update_pipe_for_stream(context, pipe, streams[j]) &&
 				dc->hwss.setup_stereo)
 				dc->hwss.setup_stereo(pipe, dc);
 		}
@@ -2623,6 +2642,7 @@ static void commit_planes_for_stream(struct dc *dc,
 {
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
+	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
@@ -2694,7 +2714,7 @@ static void commit_planes_for_stream(struct dc *dc,
 						top_pipe_to_program->stream_res.tg);
 		}
 
-	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
 		dc->hwss.interdependent_update_lock(dc, context, true);
 	else
 		/* Lock the top pipe while updating plane addrs, since freesync requires
@@ -2717,7 +2737,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
-		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
 			dc->hwss.interdependent_update_lock(dc, context, false);
 		else
 			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
@@ -2733,14 +2753,14 @@ static void commit_planes_for_stream(struct dc *dc,
 				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 				if (!pipe_ctx->plane_state)
 					continue;
-				if (pipe_ctx->plane_state != plane_state)
+				if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 					continue;
-				plane_state->triplebuffer_flips = false;
+				pipe_ctx->plane_state->triplebuffer_flips = false;
 				if (update_type == UPDATE_TYPE_FAST &&
 					dc->hwss.program_triplebuffer != NULL &&
-					!plane_state->flip_immediate && dc->debug.enable_tri_buf) {
+					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
 						/*triple buffer for VUpdate  only*/
-						plane_state->triplebuffer_flips = true;
+						pipe_ctx->plane_state->triplebuffer_flips = true;
 				}
 			}
 			if (update_type == UPDATE_TYPE_FULL) {
@@ -2756,8 +2776,7 @@ static void commit_planes_for_stream(struct dc *dc,
 
 		if (!pipe_ctx->top_pipe &&
 			!pipe_ctx->prev_odm_pipe &&
-			pipe_ctx->stream &&
-			pipe_ctx->stream == stream) {
+			should_update_pipe_for_stream(context, pipe_ctx, stream)) {
 			struct dc_stream_status *stream_status = NULL;
 
 			if (!pipe_ctx->plane_state)
@@ -2810,15 +2829,15 @@ static void commit_planes_for_stream(struct dc *dc,
 				for (j = 0; j < dc->res_pool->pipe_count; j++) {
 					struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
-					if (pipe_ctx->stream != stream)
+					if (!should_update_pipe_for_stream(context, pipe_ctx, stream))
 						continue;
 
-					if (pipe_ctx->plane_state != plane_state)
+					if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 						continue;
 
 					// GSL has to be used for flip immediate
 					dc->hwss.set_flip_control_gsl(pipe_ctx,
-							plane_state->flip_immediate);
+							pipe_ctx->plane_state->flip_immediate);
 				}
 			}
 
@@ -2829,25 +2848,26 @@ static void commit_planes_for_stream(struct dc *dc,
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
 				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
-				if (pipe_ctx->stream != stream)
+				if (!should_update_pipe_for_stream(context, pipe_ctx, stream))
 					continue;
 
-				if (pipe_ctx->plane_state != plane_state)
+				if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 					continue;
+
 				/*program triple buffer after lock based on flip type*/
 				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 					/*only enable triplebuffer for  fast_update*/
 					dc->hwss.program_triplebuffer(
-						dc, pipe_ctx, plane_state->triplebuffer_flips);
+						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
 				}
-				if (srf_updates[i].flip_addr)
+				if (pipe_ctx->plane_state->update_flags.bits.addr_update)
 					dc->hwss.update_plane_addr(dc, pipe_ctx);
 			}
 		}
 
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
 		dc->hwss.interdependent_update_lock(dc, context, false);
 	else
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
@@ -2891,7 +2911,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			continue;
 
 		if (pipe_ctx->bottom_pipe || pipe_ctx->next_odm_pipe ||
-				!pipe_ctx->stream || pipe_ctx->stream != stream ||
+				!pipe_ctx->stream || !should_update_pipe_for_stream(context, pipe_ctx, stream) ||
 				!pipe_ctx->plane_state->update_flags.bits.addr_update ||
 				pipe_ctx->plane_state->skip_manual_trigger)
 			continue;
-- 
2.25.1

