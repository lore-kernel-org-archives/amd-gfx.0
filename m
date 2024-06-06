Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61680C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C686410EAF9;
	Thu,  6 Jun 2024 21:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T9gjKALc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839C210EAF9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIB0+Ne8gipMvUQkSPpCAdVxiFXohSTvsb4hYdYCnBmffy/C6sNJI2xZ4N+H+sGgZOis5x1J8rCtGovchgJDVdoIanaH67u2XEkr+U2CSOzyBkA150DO6c6KsB4tFr+7U7qlcy/6i5+gcTgrJb/60byqe/rLcOW0IjJrgvn+BpANdwLrOyi9sjEnq5ethWIjYgBHU/4K3LQzO2gHDi8J/Of5UiCsfo9cfvRD64wU9gWMRiB0x2W4YJ/CoC+V/jNQZcHFGR19qXb2bdV6JSUMqzGYrnErtlotQE8zCysnvrgQKwnAJgjqmb1ehJmqr7VEbxjJT0VFE5DNF1QOhwoXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwlzJkj+7stNk4btFyQF8L+ppZkUOeddbEgb1LaP2hE=;
 b=Xxf0KoXugqR1ADGYdGNhQXLdASHDMFh7tmVnRj3mAN4eGmD4ep5TgFh7PCSE42rL95K3ajyvDU/4bBYxs65L72pUmI6Gh0pnl2ajQt1nBgfU3fSHRl21zQPuBl5mzkCFezeuA42M4LeAobRXFP5Tm6U4QRXD9XZ+mndshixvrJvSfZ0Hkl1tXg4fyBPDTLgYh3nnBhkO4Mt1o9wpgAUcFo+ydCZ6/15JC/Av5RYPPCdFpTH+AW5AUmYhsULBxDfhhcaYQS+EhSHkXyhcPgMi+imhMc+f0G/IChrCU++rTkmZMDgQNwPcvl6Rxv7DOUbCYTSdyrzP9vwsrHQD58XAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwlzJkj+7stNk4btFyQF8L+ppZkUOeddbEgb1LaP2hE=;
 b=T9gjKALcb+x4nUOoWaZ83+FQfMlzbdXr5TXkEBPR9kEd9ZPDm4OCMqU5iEji8/CAu6tOTT7/aL+i7hjjXZuCu+Y9ZZ+d6E2USlzfXh/MljJpGfJahx1NNaVwbvV08xhuSaVJ2low7S0BwLre7HJSUL9PgzyMIi60/iRkWXPsmU4=
Received: from BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 21:58:57 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::22) by BL1PR13CA0258.outlook.office365.com
 (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:58:56 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:58:55 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sridevi Arvindekar <sarvinde@amd.com>,
 <ilya.bakoulin@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 48/67] drm/amd/display: Minor cleanup for DCN401 cursor
 related code
Date: Thu, 6 Jun 2024 17:56:13 -0400
Message-ID: <20240606215632.4061204-49-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 334847b5-1350-4f5e-4962-08dc8673dd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vONYf3guQHoQDAQ0NK8GJ6znCIR4bWANXKBNltW3F4BzUSkpmop1z3uCVCMu?=
 =?us-ascii?Q?xmJVf5uKFPdxoTj+Dqea2+sFfbjDxH0Rmc2/oQ8p6gP2pjqQ9zMAa+TPt1Vc?=
 =?us-ascii?Q?RnCsA8y5UqMhWEzGeW8f4Hk7YflLR4Nm2KFwTXw43GzzsoLEBHv6G0m0Q04h?=
 =?us-ascii?Q?VJCgM5EVHD7DyEV1sGdhpysFZ8SHKe0hKbzskMB+0HMdm5U9DtWaueNk16sV?=
 =?us-ascii?Q?h7mWCY2GXE0wu/2KrWAemnjUlSn51TB63ZTfRQl7Pr6xkjWOAjuxerNyn7tl?=
 =?us-ascii?Q?YTJWcAQCiwOiVS/4UXXazvBPT+hSQWvocBln40YdIB2uM6CSNHvNpHtZpudl?=
 =?us-ascii?Q?uTfHOv+T2YMxTM6dK4F6ognEuqdbjm7onPerQrPneB0TZqyBBnKPwY2u27oB?=
 =?us-ascii?Q?6xYhxvqCwCv7dth/R5+Teq2ctd+iCJ/ZMS+ZGVxyyO0XLn3JAxH+5S4iGkgg?=
 =?us-ascii?Q?se6I4HskLRhXjPE3mIfLQVUaG6ckJUvCKEcX/RHBeGVM3q5u54Lk8BZUkrR5?=
 =?us-ascii?Q?2Kpu+NfdOGqgoCfAQpIOXrGimIw8SDGYOrcWPvxaC5t7XmzcRXtdv1Y5S9h2?=
 =?us-ascii?Q?yRLO1KteA2ojp00o56qv8ds+qFemtrJSAfa9sg48DP/kLnnoGAvMwXrKExBd?=
 =?us-ascii?Q?mlafWpUz+z4gGfdzjAfWFbNeT5FkyuaFLK9TbjXIucPZrOtBEPaK0uS0OeHy?=
 =?us-ascii?Q?d6FEDYl9MAboA5riNFJMYmf1zMULGuLTl1C0aLipWxASwK+ziyixWBweTacT?=
 =?us-ascii?Q?spzLGCwkKVEQmEWCfsW52xLjFhCUljtp5HWRVlEiPgPvhxPu0i1/TXyPuzlL?=
 =?us-ascii?Q?BZrLu1QjQe8ksss9IEzNxnMEBM44iktSQDhEanO/PCmzofIc1ub1RKVH0RYM?=
 =?us-ascii?Q?Er7vq1qcSLc1eIALIvcal/w7MFQ2m6pai81diCIUr4+J+Yc9rHkxxZd7XTy5?=
 =?us-ascii?Q?OjBniuZG1AqLKheJxtBY3jhdKDzJd1b9XlHTEm1gm+g/IUanBmyR1yM7s1bz?=
 =?us-ascii?Q?zX5ml4jVh+a/PfRWRtso4ODaqEmkSe1kR4kDKvoD+XKgnUcHtfmlJLd0RTQI?=
 =?us-ascii?Q?X7pJi+BIMXieEvwNsMRAzHnBE2962q/8MHlhSp3ODgwyL1xMuJ5JBIcHPy2Y?=
 =?us-ascii?Q?GxoFBHezN9V2tdicksx0YfgM4f1q5zqZMl8X5w0KZOZRAYqAcgxxtXArt7ef?=
 =?us-ascii?Q?Q0iGSZzRE6OAz07fd/fczDbOokxZ2Ia2tvNe3fwh3GNZqZBE1aqt6iYork3S?=
 =?us-ascii?Q?EZyQuTGFXMRzcOXFZbC+RTZJka5DiVZ0Wrqa1ayHKke041PhnLRvEn4dMxuu?=
 =?us-ascii?Q?+sarDT+bqhZYW6RQr5EGZvAVxcxkXdeysKt4TZGAMGTBj42dMZnbdZphx+EN?=
 =?us-ascii?Q?rxeaWkfMGM9VDnutAxNWu/R+7bNEobpGfAfsCFOXbyit1GF+Pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:58:56.6131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334847b5-1350-4f5e-4962-08dc8673dd00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

From: Sridevi Arvindekar <sarvinde@amd.com>

Move pipe_ctx variables to start of the function and add a helpful comment

Co-authored-by: Sridevi Arvindekar <sarvinde@amd.com>
Reviewed-by: Ilya Bakoulin <user did not set an email>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Sridevi Arvindekar <sarvinde@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 5 +++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 0d58c9d439c6..d60941495fd3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2800,6 +2800,11 @@ void dcn20_reset_back_end_for_pipe(
 	if (i == dc->res_pool->pipe_count)
 		return;
 
+/*
+ * In case of a dangling plane, setting this to NULL unconditionally
+ * causes failures during reset hw ctx where, if stream is NULL,
+ * it is expected that the pipe_ctx pointers to pipes and plane are NULL.
+ */
 	pipe_ctx->stream = NULL;
 	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
 					pipe_ctx->pipe_idx, pipe_ctx->stream_res.tg->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 776ec8963cab..fe0bb6147e36 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1099,6 +1099,8 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	int prev_odm_offset = 0;
 	int next_odm_width = 0;
 	int next_odm_offset = 0;
+	struct pipe_ctx *next_odm_pipe = NULL;
+	struct pipe_ctx *prev_odm_pipe = NULL;
 
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
@@ -1110,6 +1112,7 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
+
 	/**
 	 * DCN4 moved cursor composition after Scaler, so in HW it is in
 	 * recout space and for HW Cursor position programming need to
@@ -1157,8 +1160,8 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 * next/prev_odm_offset is to account for scaled modes that have underscan
 	 */
 	if (odm_combine_on) {
-		struct pipe_ctx *next_odm_pipe = pipe_ctx->next_odm_pipe;
-		struct pipe_ctx *prev_odm_pipe = pipe_ctx->prev_odm_pipe;
+		next_odm_pipe = pipe_ctx->next_odm_pipe;
+		prev_odm_pipe = pipe_ctx->prev_odm_pipe;
 
 		while (next_odm_pipe != NULL) {
 			next_odm_width += next_odm_pipe->plane_res.scl_data.recout.width;
-- 
2.34.1

