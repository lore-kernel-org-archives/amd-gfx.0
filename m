Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA72CF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28C910E75C;
	Thu, 19 Sep 2024 18:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cYtkuApN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA14C10E75C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXi9g5PswOXhFZukQZQOswcXefAqCsQ8Lyf2+OYhffl+3rFzBS5gWDufVPrfFz09oqAqQGjxF/0cqwlBbQLWiPXx6J5NF/MwptdZlUV/G+PmfqSPMLFJ03D5vQH/YJva2vS9pC7GO84AZHVjHL2R0DEQhh+r0zqugxGyCz5btPbJrJLmfMKIZGyQllzCw73vdIlmr6XikOdIfy5t3K0LurqLCSfDO+aa98bCQfCmEqn4d9s/qH3kd2FQ8D0XDtHNIu7pOlK6oGBFgKUT6fg0Hy4AfKvtQHrvAtXFP6NS7UC4utA3ltv1aHVBxZh0okm285DjSrIdm057tRGsWlzJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGJuUu9D+sxWGRDY2nrr+hhllMbT8Pamylx55QZdjNY=;
 b=I1jcV877w8XgFxurWqgAKjCnDv2nv9sNHldgw54WBKgL2nrgi4geew6PyQvKj77xC23SwgE5B+O8Khci+o44HeRwTTxVyDzO35efxVthTeyMeJUzSOdPRyJyfuUVC0kJq/mmm0AaIZ75PDceKrcNRVIu90Tqu9//BiW1Pn/JkRhOpSAi6Ow16N/z/Wrio9SnfnIuQGKT/aKdWTBm92zssgOXPtPx7nf1SigEYbVJKJHvkTRkkvIB68nZDT2tiCSKZxfcVQKcEbbLnq2fusk4QW0a0bxaVKoG92sVKi1Y+6QWKEOB3Nqry7njneViUfckLLdGqQIc2psnku45LMoxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGJuUu9D+sxWGRDY2nrr+hhllMbT8Pamylx55QZdjNY=;
 b=cYtkuApNbDXhkhMN3iW3KCR9YF5/hzKlmg4+PpMtk0DJDNuTT5jTWw+YHDEx9ox8O9IUms3ezy+Hqi/Ex6ojqITciqWKTO2VlnKAgT4jiOR1uOQCVSdl4vMMpwCU9bE+R+vDqYNH+rJnFai30IgV0Xnlty/+l1+21VjW38uztqg=
Received: from MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::33)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 18:34:57 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::6e) by MN0P220CA0025.outlook.office365.com
 (2603:10b6:208:52e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:54 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Sung Lee <sunglee@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 08/21] drm/amd/display: Clean up triple buffer enablement code
Date: Thu, 19 Sep 2024 14:33:26 -0400
Message-ID: <20240919183435.1896209-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb9de8c-462e-4198-cf01-08dcd8d9c301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tCQ89TRNrH10jsTeiq8wabSNBCy0Zghll4cJLL8euAg4xvXdYNj8BQ5sjIAX?=
 =?us-ascii?Q?rt0c7pTMOODZOipf/wMFesNvdh9uyLDaw+LKiqEQemJTe+Q5MttQvCp3b1cv?=
 =?us-ascii?Q?7C6PXeVDvRO5zHzcnhBmEBSNjR5Y8JsrcK5poyIZmnBO18EGtr9dMRXWuRrt?=
 =?us-ascii?Q?dI3LFMZ5noq4Q7Wxv8HYQOksnL0f4HlEawAdzNI58uTVKCftQTQ60wOspqfW?=
 =?us-ascii?Q?GX8Ac/KyVFKpI6pw7WU+nnKN6goNKo2AD4zyH100gcV5UMtez/58pufm4w0i?=
 =?us-ascii?Q?uW1+gcmqWrwM4o3SL+IV4dQ2eiN6kLVtDxS53qIs7dCJzM+CHlrXYEI2a4zL?=
 =?us-ascii?Q?Eq5dsVtwpB5Fi5HcVci4VEIt+JxlE8E3iax5GsBykHOYFnbK94da23277QHy?=
 =?us-ascii?Q?JanEKkEfOEo5hw6kOxfKLi/pm0IFO/aOHGJY86xBqaCgRbzCwWARLgR0Zj7x?=
 =?us-ascii?Q?rymTeI0/vmkBikLWkl5uPMYUJO9oL6APL5wPsfUXrOZU/v68MWl6Mis7jWmJ?=
 =?us-ascii?Q?o2YpgNODwwgLYnljr1iL6EddQmy6k6Vy0CVE0TctAsQAbDI6wmATBpd/tneG?=
 =?us-ascii?Q?aKugZcLL+aqc3MNg7QLJHMC1152/ouuxDtT61wo7IxLsv3WDAvnJyMNLkzuZ?=
 =?us-ascii?Q?v4ULJrYbGBwIwXgU/kZcOtD8ypVviFyQdfsQEHt8CgghxB8BsB/L8uwbPqoQ?=
 =?us-ascii?Q?cJzoFSPV0qTpTawsRxgk4f/JVwqUBV4Lm3q/DrmJ/FnfNjUIXl6r8AoksU6c?=
 =?us-ascii?Q?kjQKDdPv+7ufTq8Oero3jAvd7pyDxtlqK66E2vsh3n5cYdplG5Hmv2H/OoWX?=
 =?us-ascii?Q?kLaHXXbmDpurEogPmwCpb/6JDsf5umlPjtSPtOFeahLTOZ6uHdRPpQzc+GOL?=
 =?us-ascii?Q?NT3Zdg0BudtbJAJ4ejZ+T1P4uonZrdqGeFlZ0rzBEVOyzDbVTM5gufM7+Ohf?=
 =?us-ascii?Q?pUKTwiduc/FHkZ4W4iM5n35XYnJiuajhrhSI/Jtu476VGTDA4y96scF8gYVJ?=
 =?us-ascii?Q?zP6O94CQNSj54WtzhR9a9Ckx3uBC1BcI8XB+xXUIhf76AEzi6Wa09i9tjXu8?=
 =?us-ascii?Q?WUzWLTfVCCnXo8qqBEywLdMZzjscdM7nmzYF1uvcSenkJZ/qWsC2E7QnAHMt?=
 =?us-ascii?Q?GuhF8RK/b+CbPlrj719n8X2tuLU8vKQLn0oCKgFQtA+3YuOXfm/8jMxVWDLn?=
 =?us-ascii?Q?KlHadfBVzbuC/Qm+2C1aAnTJn8ya8iF8Y7kTMGAAM6asrti7GU9goHA9eYjy?=
 =?us-ascii?Q?sIfjQymgwahy5AtvHTdS4opAYz0reFrPCO1gzfg+VDa4SKu3XUD7Wy1dtF4O?=
 =?us-ascii?Q?tTqYW3S3zbJFjMOFV6oRjiA8gQSj3DRY5cu8drbOoAN3tXoNIhdZVGOM/sfj?=
 =?us-ascii?Q?LHbPmIZP+Px8GPBTBEf4Mfl4BRY4eIQYunW5j5v3oGTKl113VIIKkOikuJv8?=
 =?us-ascii?Q?IEHIxp637Vv2pAaEClcJlcs6XGHiGEmi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:57.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb9de8c-462e-4198-cf01-08dcd8d9c301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
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

From: Sung Lee <sunglee@amd.com>

[WHY]
Triple buffer enablement currently does not work properly

[HOW]
Allow triple buffer enablement to happen properly on
fast updates

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Sung Lee <sunglee@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a1652130e4be..09fb04231250 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3677,13 +3677,14 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 
 			if (!pipe_ctx->plane_state)
 				continue;
-			if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
+			if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 				continue;
+
 			pipe_ctx->plane_state->triplebuffer_flips = false;
 			if (update_type == UPDATE_TYPE_FAST &&
-			    dc->hwss.program_triplebuffer != NULL &&
-			    !pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
-				/*triple buffer for VUpdate  only*/
+					dc->hwss.program_triplebuffer != NULL &&
+					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
+				/*triple buffer for VUpdate only*/
 				pipe_ctx->plane_state->triplebuffer_flips = true;
 			}
 		}
@@ -3920,19 +3921,20 @@ static void commit_planes_for_stream(struct dc *dc,
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 			if (!pipe_ctx->plane_state)
 				continue;
-			if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
+			if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 				continue;
 			pipe_ctx->plane_state->triplebuffer_flips = false;
 			if (update_type == UPDATE_TYPE_FAST &&
-				dc->hwss.program_triplebuffer != NULL &&
-				!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
-					/*triple buffer for VUpdate  only*/
-					pipe_ctx->plane_state->triplebuffer_flips = true;
+					dc->hwss.program_triplebuffer != NULL &&
+					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
+				/*triple buffer for VUpdate only*/
+				pipe_ctx->plane_state->triplebuffer_flips = true;
 			}
 		}
 		if (update_type == UPDATE_TYPE_FULL) {
 			/* force vsync flip when reconfiguring pipes to prevent underflow */
 			plane_state->flip_immediate = false;
+			plane_state->triplebuffer_flips = false;
 		}
 	}
 
@@ -3953,7 +3955,6 @@ static void commit_planes_for_stream(struct dc *dc,
 				continue;
 
 			ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
-
 			if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
@@ -4028,7 +4029,7 @@ static void commit_planes_for_stream(struct dc *dc,
 
 				/*program triple buffer after lock based on flip type*/
 				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
-					/*only enable triplebuffer for  fast_update*/
+					/*only enable triplebuffer for fast_update*/
 					dc->hwss.program_triplebuffer(
 						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
 				}
-- 
2.46.0

