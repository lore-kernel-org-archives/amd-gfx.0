Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4C9C3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744C010E741;
	Wed,  7 May 2025 02:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2uzitA5";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B3710E741
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbkjvVTXgUq02bhooCNdkImAMIvlx7KWmO8our8vdkDJMGs1ElEgf2WDupl9L4XlPtQ0/qlltiaJrvUHJzUA8JMDlSg45471nsbZJe7XEkLZdIfxZi0g3LxaKCRf3hfp/VwjWvdDmwzilx/U7KXHVzjn/kdb3trV+GXR4/DB24hX8Bnfy3EMYmy1oWuHKkKGVV55lLYckGXJ5rdoRN2h82ppSM3Ku5gFH2jppaqHCFOX9CCxUi7Sx/7G5zUJLv5Vh8FUuoTzR3Aay+tnEMh5pntAGo5aOw0R1OO2G0+NOo2hnxJ/Rnd4E44CUz5ac9K8t4gk2ScVOLzJvglipNb5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi8Fk9cKw6DmKrcqr/xbmd0ZVCteUAbApjpvfZ2rwiw=;
 b=hA5KYImxo/3nq90wja7Nk1mXgQU3N+Gy1yQMMZ11asmIYtCHuCV1rvkDT6wbid9WzUuSnk/7/XFwbVFAzya7xD5pi/FLA47VNue7ctOpOOhQgHJftXggGCJW1px5VVBulP9N9vccZL+LecvedSUv76I1f8wJv9XJ9CBBL40hJXruERp9jJUCcEQJfy25elHH2WPmoIQPR7R0i/1HapweYBw2zYN0+agTOPzpQQDsJMX+tfbveg0gKRc12FYimYZ9QyR99tInsCIWVfOWwWg2XDvP5fNjOsUf10t3Oq3Ty0t9NtdEfpKbVbm0gNPj4boJVFNm2dHUAkqDHqr5NituGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi8Fk9cKw6DmKrcqr/xbmd0ZVCteUAbApjpvfZ2rwiw=;
 b=P2uzitA5DG33LBfqYa6tEXcqcKUEtURu1Uon8GENkM0ysXugV5fpr7tDZtHKYSl6b40saFLagE5ANPe5xGCkQMJqI2POaxDAuawNF71e4KfuBDCbJxN13Gsr7vlq2jhWqf+WU6Wl1KebTrcTFCYf33QODu4fhj4vwr3fdz9/rQ0=
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 02:44:03 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f0) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 02:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:44:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:44:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:44:01 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:57 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Sung Lee
 <Sung.Lee@amd.com>, Dillon Varone <dillon.varone@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 12/14] drm/amd/display: Program triplebuffer on all pipes
Date: Wed, 7 May 2025 10:34:56 +0800
Message-ID: <20250507024242.1928299-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 029f6c73-1ce0-4c5a-79e7-08dd8d11070e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rWYYl9Kq8AmZIJfHkxAis/VkeBBJTf8++rzjDDn1se/TO7COLqtxdTdeoHtm?=
 =?us-ascii?Q?chSLboe68Fy0EvwSB3IjrJHzsHVqMtbJYx7le8KGnRir0+Vn4lC1MvQb9SQp?=
 =?us-ascii?Q?qk/NqwEnTEs1kGLsd7KqQVXw6RVTzrg3I+oBioOL2gmok9YK3/YOJamoQXNf?=
 =?us-ascii?Q?OqjnJ2M1fBxPyIjt2o88Eo+iCs128InA3lKLW0jyV89K2hGrskYPrT4gAFLg?=
 =?us-ascii?Q?pLIfwsTtEQmcOH6geYhr3It6X+BcT9HyKa7jyDuTdk/b/n1PV/21wrrcTgGn?=
 =?us-ascii?Q?unpJTwudUREyQLd0SFhpOY80qMhy4nX0oYvF0l1dpGRJTNxXaD9XJ7lifXa2?=
 =?us-ascii?Q?F7jsaZa4GoGzegvcqD8lUUWjhbDBE/RC4wObLqAO22Or6izZ4lXU5EFul2Eo?=
 =?us-ascii?Q?IilitCOfl/Cq7aR+IjOaLjzTitH5fuSBE5aDkP9HaIBKboWfHw9c36x5Kk98?=
 =?us-ascii?Q?LdYAJypXu969Ls8us6jF++uNBujNCqP4/jfiTvgaiXspt9QXJeRJXJRp59DO?=
 =?us-ascii?Q?AErC/efJyZ0H/GpR43SWLIEcYLLJNAwUq8UcWVJO8k+cxychmLIaMnPPLvkV?=
 =?us-ascii?Q?s/DHoVU0cJO5eEN4LMcbvNRKqZI3gceYPH2WbeFW1xDIgYB+MSIjlzWzeOM9?=
 =?us-ascii?Q?lgPVxYy2vWuwHjoHj5KoSUJfJwj1582LbwcFYfkDx08ezhkH0wCXDiUtp3Po?=
 =?us-ascii?Q?Q5SfY2w3eAJciG0+6AqDqu2keExce7T2j2L74f/tknyJVDhbjymkwITW3zYp?=
 =?us-ascii?Q?dEIvDDzf4Ms0N4Cq/HliRqACvds8C1FfPkZG1ArjDS9UDanZ74N6z5AnpjqJ?=
 =?us-ascii?Q?uJoUiQwctN+rTlITmxkIGN/Q93U7ahyv+NIuTcGmngVuIKQmL/PZFWqz84tO?=
 =?us-ascii?Q?mf5ecVVrVmJiXPs55uJPR4FZh/StQpIbOO3ANZeEuwEFa2GRo+iWSAqGpwwr?=
 =?us-ascii?Q?Qz7+aywZbXwUr46UGX0uSRp/+PE4FXYv1QuKnDqYljC6KITtDQGAnSVACdhw?=
 =?us-ascii?Q?aXtxKfOBCgM6Ghu3ZKLzuyLSuOvEkAAe7D7uLJcNn4uMQVRdwyd5DGNH33xr?=
 =?us-ascii?Q?ZY4yg/Txh9g2fg1kl5p/Kk+YEKgVTt9G5n3zQ1DwetrTLnf67Nqh/ZETdnIL?=
 =?us-ascii?Q?bKqpPr0QHlB/O2oCxo239mQlO3KKWDV8o2IXAJrizLWi9yvTXkm/fzoIJ9wT?=
 =?us-ascii?Q?H4CuXFMalZXTJvSf2riQ/FihfNIP4xUwhJyKN7hlBUA7hCxSGIvr7Pf73Hwn?=
 =?us-ascii?Q?3nOE3cMTmVFNF8yGKNzYVV9PIiLwlFLi/65ur6JFBb9oWq0yCBYt7m2GbyXu?=
 =?us-ascii?Q?EXI+WYd6EgTT1RlSzN9P0ry+kdyCl2tD1dw85LqjZKkYFsBgD3nfKlL3+3+h?=
 =?us-ascii?Q?CjGHvNk66KULI3VWk5leaw7U4eZbO1b3Sb1a4S65yJs81BiTXs/iOyLEOV6D?=
 =?us-ascii?Q?47y9wMQ8lnD/O0PcKKPVdhq7BBzo3RKSMrVkCMqUJVwhLhLmK5ExAQiRyPQp?=
 =?us-ascii?Q?FrWGu7dZaT76YaMyDTJc+9vUiI53ByB1JDkj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:44:02.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 029f6c73-1ce0-4c5a-79e7-08dd8d11070e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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

From: Sung Lee <Sung.Lee@amd.com>

[WHY]
Triplebuffer should be programmed on all pipes.
Some code assumed it only needed to be called on top
pipe, but as the HWSS function does not account
for that, it must be called on every pipe.

[HOW]
Remove condition to not program triplebuffer
on non-top/next pipe. Call the function
unconditionally on all pipes.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Sung Lee <Sung.Lee@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 25 ++++++++++++++-----
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  2 +-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6ec22c0d5b97..6867837f01d7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4249,12 +4249,6 @@ static void commit_planes_for_stream(struct dc *dc,
 			if (update_type == UPDATE_TYPE_FAST)
 				continue;
 
-			ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
-			if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
-				/*turn off triple buffer for full update*/
-				dc->hwss.program_triplebuffer(
-					dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
-			}
 			stream_status =
 				stream_get_status(context, pipe_ctx->stream);
 
@@ -4263,6 +4257,25 @@ static void commit_planes_for_stream(struct dc *dc,
 					dc, pipe_ctx->stream, stream_status->plane_count, context);
 		}
 	}
+
+	for (j = 0; j < dc->res_pool->pipe_count; j++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+		if (!pipe_ctx->plane_state)
+			continue;
+
+		/* Full fe update*/
+		if (update_type == UPDATE_TYPE_FAST)
+			continue;
+
+		ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
+		if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
+			/*turn off triple buffer for full update*/
+			dc->hwss.program_triplebuffer(
+				dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+		}
+	}
+
 	if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
 		dc->hwss.program_front_end_for_ctx(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 5e78b553adbd..858288c3b1ac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2053,7 +2053,7 @@ void dcn20_program_front_end_for_ctx(
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &context->res_ctx.pipe_ctx[i];
 
-			if (!pipe->top_pipe && !pipe->prev_odm_pipe && pipe->plane_state) {
+			if (pipe->plane_state) {
 				ASSERT(!pipe->plane_state->triplebuffer_flips);
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ae7194da5987..e61ed07fdc62 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2361,7 +2361,7 @@ void dcn401_program_front_end_for_ctx(
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &context->res_ctx.pipe_ctx[i];
 
-			if (!pipe->top_pipe && !pipe->prev_odm_pipe && pipe->plane_state) {
+			if (pipe->plane_state) {
 				if (pipe->plane_state->triplebuffer_flips)
 					BREAK_TO_DEBUGGER();
 
-- 
2.43.0

