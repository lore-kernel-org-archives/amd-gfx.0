Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8CAC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D629C10EAEB;
	Thu, 20 Jun 2024 16:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkNT05Zc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA08910EAF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS7RBYK0l0kmzUB+2xQw/LIGSbISb2LtG094y+lcnQj1U/WDnqSskyxHokcOQsyeTS7Fy0zW4XzV3eZcM4kPuyAqCvJ8OIMejRx7BPb/fTd9eGtIXdQ90M4g/6bLllV6z4Qv6wQS5G2OTw3Qxmtcde6CZYeURJRomZQ1xOPHl1WjSGJhY7HS9vb4XTTx0E2h/z8qOWrd8Gm33bd6vrpAaxG825iDApC7xrggYfHKG8KQx685LnAXzOa40o5ETxq0AV3/vGDbYDyAKJR6fWOjGptQ+IBnQzt5cUvrZ5WPEk3mpbJdbJE9W0Uw4TWE6n4NuEleQbP0tjDtd+IPpXrDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTJrURClQde2UHXZAVLGTSYNyaOJmri0iJ5IqxLke/0=;
 b=Q2PTRAc0xLybxxagMPZrsVQpKgwxkQSw/uErx0vO2UrX0ZoznLv/4Mj/IU3wQb67VTQ8zQwR5xb7Pv2OvfyNTMag/qc+URb2Z6AZmNfDbGLg8Dl8qgu6ZpP/FXxRMxeUlEgtQVQVXrNXjBtqvGLeT5UoO2/3sBaQjZ0na5Dtv7Pmu7z50EUDNUES2qxKDoIdP8bR1lLqm55tKPeK8RVtfKUQqfFuZoNDj1ol95JJd4vuuYdOoMHgnigVtBYwGEzzcaGnNO1pgfa7/4nO/cze90x0I58ZooBUj7MPFagh0muAEmy07BAN3AFGUn/AJlB7DT185fX3hmJLLj9tHvI5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTJrURClQde2UHXZAVLGTSYNyaOJmri0iJ5IqxLke/0=;
 b=MkNT05Zc1U2X8QS/9nR69/Hscp5pRQjKkQAxIFRriZBfiYMjsJzqWYXOYboH9pPj43ptekkSiIKHYOw2x0WA28FHc2OVMa9SdXVEQMIZINSAIAiRe+2FxxxZEy0V4LQ0Kqom3h+Lc9zI22vhASgeOweTKTvFQITZbbi7KtTy7AM=
Received: from PH7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:510:339::27)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:13:41 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::3a) by PH7PR03CA0010.outlook.office365.com
 (2603:10b6:510:339::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:13:40 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:13:38 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 07/39] drm/amd/display: Remove redundant checks for
 pipe_ctx->stream
Date: Thu, 20 Jun 2024 10:11:13 -0600
Message-ID: <20240620161145.2489774-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: f5805219-ab14-487f-f0de-08dc9143f357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pdwE0rAT/r1LVpyuyjrarxWHvEjQqOFF2M4XMF9X+/6DQd/6bqxo+sM26s6k?=
 =?us-ascii?Q?On3Z4fVm+ez9vDWE7aw69TgkqzbBkZbTEkJVFJZOFHVrLKd7nLYxtVqiFJSR?=
 =?us-ascii?Q?Y4El/Le06KZDn3nu3yEGvh0Fp3SO9nDLehnbUBy57sHJl+64RsSQv12xquJg?=
 =?us-ascii?Q?aBZVfAWZCioxvgDUmMEr6bg1YDkAFXXTLFd+41qCfy/8pc2/ihj6LUUyj8Ze?=
 =?us-ascii?Q?gba0ZR7C/V/1vxn9E2RztjhRd+QRB6s6Qlcl5Aa0jN0uGJ0TIIP+lk6LL/Ub?=
 =?us-ascii?Q?lXbqr9NUgSyw0eczOR9IW0m73rsf+F517YbzTXIvIVVmHKpDOdzsjhZwWGUY?=
 =?us-ascii?Q?IhwsDO2UQLCrR4jfIUV5TuFFNPdCAFuCij/bW91/mKfOIkU9WO4LqRESFctk?=
 =?us-ascii?Q?nT4shSFcLcfCqYc8YULMZQva1d1A+1hj7OpEmawsPPg9j2X7JEFlo984esBF?=
 =?us-ascii?Q?jeQ2vWn52ROSxE8ptm2txjoDgUiyL66I3AIVpM8Yo1GhXwwfw4li4HetXOJA?=
 =?us-ascii?Q?85UpwI1njvJZPDW0CQoTEK6PQ5jyyGdqoo9eUOi+mlr0MccDG9fmehQMSQJp?=
 =?us-ascii?Q?c37YRGBU3/y4AyH4RPDyQH0G80TFiIfatb25s8jmETZW3aAKrkADa7EXkN1p?=
 =?us-ascii?Q?jbPYGe3WL3Qd1ABGZ43LCEXWGU3lZ8LUk0nHfNCw/8TnlcyW8KHry69XWxfB?=
 =?us-ascii?Q?viN6Iqz0pEV0yEE6FFiI/raDWwL+jV2J3aJ3c/aJloA+UiPGJMyjs0gLMUNI?=
 =?us-ascii?Q?/szMHtbgZMUrGzn7Lsa0Wz9vLg292ZxEhd7o4qM4XX9+4Ec3UAq3pSZy1m1v?=
 =?us-ascii?Q?6wSy5BAaUbADrsHWISV1QlJ7SXgNlMHX1yKMO6eoLlxJXV7iorNTDbmd2mbY?=
 =?us-ascii?Q?LlpPC3jkTjoeDQhXxxJxhxDwVS3LtXJ2jgysLE84YjzcBifxljqj2SwKAwnX?=
 =?us-ascii?Q?m9bD44SHw+KCa2Ncs1n87V7Syb1P//wwoDHlvqZ2dAcrrNUy2F7DopdzJlX3?=
 =?us-ascii?Q?HfYsqGaWYqWo2ec2tFpQAQk9HJSf3RD21nbsTlifvJasmWK5BmgDqTh7Jw4T?=
 =?us-ascii?Q?PuJbkM5QyeO8IpDC6icQ0Jc7dMRfIJCenLLkmsq3v3+vQIx7A+z+voHqsu1m?=
 =?us-ascii?Q?yQS7wS4TGedHldFVjKRzf6yizy5BK/mtj2959B94KyLnHsqPcFvoz4/jVs70?=
 =?us-ascii?Q?ppMS/IQJ1Y9Vf2M9utTLwrgJ4AMG0X3ThSq9lQjAehciMIbgA2XUnv2HJZ1w?=
 =?us-ascii?Q?XMxuqZg6C8Afz2Zbuhn2e0JzjFdUBBElPeKUwc18PmCpTy9eUb3DX80nFn/E?=
 =?us-ascii?Q?NE6D8DosG1ULwjvyS4dF5Wc7alSITRZiaj8wHiDO/7g8B1N3GRmq+uBSiepN?=
 =?us-ascii?Q?nt5BPxmXdUy/HlgAn76aRD6Gc9CCqoxUajjnViJUgNzaDzpe2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:13:40.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5805219-ab14-487f-f0de-08dc9143f357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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

[WHAT & HOW]
The null checks for pipe_ctx->stream and pipe_ctx->stream_res.tg
are redundant as they were already dereferenced previously, as
reported by Coverity; therefore the null checks are removed.

This fixes 6 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    | 7 +++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 4 ++--
 .../gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c  | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 82d1ded09561..4d359bb9b1ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -974,8 +974,8 @@ enum dc_status dcn20_enable_stream_timing(
 	/* TODO enable stream if timing changed */
 	/* TODO unblank stream if DP */
 
-	if (pipe_ctx->stream && dc_state_get_pipe_subvp_type(context, pipe_ctx) == SUBVP_PHANTOM) {
-		if (pipe_ctx->stream_res.tg && pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable)
+	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) == SUBVP_PHANTOM) {
+		if (pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable)
 			pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable(pipe_ctx->stream_res.tg);
 	}
 
@@ -1827,8 +1827,7 @@ static void dcn20_update_dchubp_dpp(
 	if (pipe_ctx->update_flags.bits.enable)
 		hubp->funcs->set_blank(hubp, false);
 	/* If the stream paired with this plane is phantom, the plane is also phantom */
-	if (pipe_ctx->stream && pipe_mall_type == SUBVP_PHANTOM
-			&& hubp->funcs->phantom_hubp_post_enable)
+	if (pipe_mall_type == SUBVP_PHANTOM && hubp->funcs->phantom_hubp_post_enable)
 		hubp->funcs->phantom_hubp_post_enable(hubp);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8d0da56e4cc5..0cf55f557c3c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -916,8 +916,8 @@ enum dc_status dcn401_enable_stream_timing(
 	/* TODO enable stream if timing changed */
 	/* TODO unblank stream if DP */
 
-	if (pipe_ctx->stream && dc_state_get_pipe_subvp_type(context, pipe_ctx) == SUBVP_PHANTOM) {
-		if (pipe_ctx->stream_res.tg && pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable)
+	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) == SUBVP_PHANTOM) {
+		if (pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable)
 			pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable(pipe_ctx->stream_res.tg);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 8d1a1cc94a8b..555c1c484cfd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -853,7 +853,7 @@ bool dp_set_test_pattern(
 				CRTC_STATE_VACTIVE);
 
 		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable) {
-			if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
+			if (should_use_dmub_lock(pipe_ctx->stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
-- 
2.34.1

