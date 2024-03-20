Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B178C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED9310EE23;
	Wed, 20 Mar 2024 06:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f3guPYWC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0746710EE45
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0Sfze/D1/yGnnXMIeZNgCRmz7EUNb+lmEHwCVs9aB0S4ypR3bL5E1PwcIHUeggnXBAS+q0eHFiUWz4GFu/f1k7kVBb63NqhsVQRb8jCkbLSHdndJIfEwT3omusSO64gDdi+7fU7PmL/6wvbTNnzdVAYzrhLCf173LCiy/DZO/JaxrXPs6mAZCw7RN9d0MDBZFd0h/FDrk6VjU0SjtIrsyJ8Y437Qakqp2jsFuD1Kb4Wadgschb6yyV0ExLfm6y1ZheN9dQop/X+zxd6pvHpYbSoE83pyvTRXKvVPMqUjNe7GmbGFAnk0N0Hm+Stb0YmT39JN6KjfC2rM5Qs9Cx/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WlpooGzTkNcEPJQsLxmoL0cGCHoIGjX97/lDldhN5s=;
 b=RWkbbB3z8oLgHr8kt6647Y3iGO4Uwv8udxYbTabdt41NUQSBvwA6pVJSXR92HGVmSgG7TFBLmi5aHiGKcfob5v6sXla7+eMPXfqRba98Qr6DUtMO1rTThwc0JaI9KrWc5xJOvnrhkTDxNzJCbPffveXRnsKfSVbdoyyhA1YLRBx6x8Hg2b4wJUMfND8OlsAHjy1RKdi0LpBAJXu+nNvDhLYiUZEnp4DfXBgG5egKwKlBWgUWbIq6PhJw9xa5AeS60Jn+I2tj3lrHBZmqAR4iGnTpiqb2Lc761sjLqO7Yp3aPkFZBGiHhWk7oucP6fWt9jnCdxdI27FZYpQ0B0iuwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WlpooGzTkNcEPJQsLxmoL0cGCHoIGjX97/lDldhN5s=;
 b=f3guPYWCwZMuxOxV4wHIRh0ueWJnB+AQV3RqtyFFDgvRLHhVLOoFeCnNm+xNGhG7OaIXJmxvPjzDdoPMHItuKKI0HHE8NC8hLHURXWHj4u2LiZJF83hCcAtwsI5fpAbdjEMRtklRVZh7MVVTDMlHnSh8oorLS+tIdhhloNIUJSA=
Received: from BN8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:408:c0::36)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 06:36:40 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::3c) by BN8PR15CA0023.outlook.office365.com
 (2603:10b6:408:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:39 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 23:36:39 -0700
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:36 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 09/22] drm/amd/display: fix nonseamless transition from ODM +
 MPO to ODM + subvp
Date: Wed, 20 Mar 2024 14:35:43 +0800
Message-ID: <20240320063556.1326615-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: ab87f590-5fea-4e04-0ac7-08dc48a8198f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZumSpPVCbdryUs/nF2d6iisPZDvwEQaB3j01O98hoVBFQXqbGBHmXGNFPLr0t5cGOAPpTKcQoOJ+RfN6iAqWPvvqNeybbFF3KY6ezTHNWbFycFaMJSbnvjCvqlChVGULzuBVGvopmDh0g4MI6EyHNJ6qRFYSvrRfuyb/YLEyabvDhf2UE1X5XcLF3nALKNPozi+3k1SDc1z/80D0WojX0bVaPppZY4pPLN0UMxQExKpR38e/Hk+nb9+FbodcZxMgrJuMjTaQu2Z8Nd/NxCb6P4Yqj/RfIvsRvOAoG7QdXEVmVLaUbypOrAfbFvyLmZaVbC1PGlglsvX1ehaP4rTNj11/PfdBYpdJzcKp1OgzRqUzdxqHgEizexVmuymN/VrM3wIUOT4XevtcnKVSti0l7wR4kxT1KlY9v/ELuJJOQ8vDFTieTTjfGijQWIvN2SnPCssbael7FPvf9CNWv6fVaYYIZzweGNaeeobwxHQcjt526ZnnVL7plGLNa8N7psWCrW1xe4JPBz+2YwEsYRN0mqYKeqpD4xgttnqPjWHsQ57yWykQKkkeDROn88zkGPgNofHUd6WI5A2R1eDCw9gNnXNr4EzC7f/e154zkedYA+f60uHe1RZqcTawS1Lz0Bj96AbxIMi8v0fg3X0s+hcwWERgmvE2O73qUiohkApsKqkLZvrdclHBL2p4pKWXMeGcpgfDF8ypZZF8djhk/LWb47kVT/tVC/KSy0/ianW9Xu+723IQOqij2lelnpvpUdDB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:39.9809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab87f590-5fea-4e04-0ac7-08dc48a8198f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
 when ODM + MPO is used for all 4 available pipes. Pipe transition will
 be nonseamless. Phantom OTG master pipe reuses the secondary OPP head
 pipe. There is no possible seamless path to transit to the new
 state. The correct logic would be to reuse a secondary DPP pipe as the
 phantom OTG master pipe. This way we are able to first transit the
 minimal transtion state of new and then transit to new state seamlessly.

 current                      New (nonseamless)
 ________________________     ________________________
 | plane0  slice0  stream0|   | plane0  slice0  stream0|
 |DPP0----OPP0----OTG0----|   |DPP0----OPP0----OTG0----|
 | plane1 |       |       |   | plane0  slice1 |       |
 |DPP2----|       |       |   |DPP2----OPP2----|       |
 | plane0  slice1 |       |   | plane0  slice0  stream1|
 |DPP1----OPP1----|       |   |DPP1----OPP1----OTG1----|
 | plane1 |               |   | plane0  slice1 |       |
 |DPP3----|               |   |DPP3----OPP3----|       |
 |________________________|   |________________________|

 New (seamless)               New (minimal transition)
 ________________________     ________________________
 | plane0  slice0  stream0|   | plane0  slice0  stream0|
 |DPP0----OPP0----OTG0----|   |DPP0----OPP0----OTG0----|
 | plane0  slice1 |       |   | plane0  slice1 |       |
 |DPP1----OPP1----|       |   |DPP1----OPP1----|       |
 | plane0  slice0  stream1|   |________________________|
 |DPP2----OPP2----OTG2----|
 | plane0  slice1 |       |
 |DPP3----OPP3----|       |
 |________________________|

[how]
Try to acquire free pipes used as secondary DPP pipes from current state
before try to acquire any free pipes for new OTG master pipe.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 11 +++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ce56e47cfd0a..fa6e6184c437 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1795,6 +1795,30 @@ int recource_find_free_pipe_used_as_otg_master_in_cur_res_ctx(
 	return free_pipe_idx;
 }
 
+int resource_find_free_pipe_used_as_cur_sec_dpp(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool)
+{
+	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
+	const struct pipe_ctx *new_pipe, *cur_pipe;
+	int i;
+
+	for (i = 0; i < pool->pipe_count; i++) {
+		cur_pipe = &cur_res_ctx->pipe_ctx[i];
+		new_pipe = &new_res_ctx->pipe_ctx[i];
+
+		if (resource_is_pipe_type(cur_pipe, DPP_PIPE) &&
+				!resource_is_pipe_type(cur_pipe, OPP_HEAD) &&
+				resource_is_pipe_type(new_pipe, FREE_PIPE)) {
+			free_pipe_idx = i;
+			break;
+		}
+	}
+
+	return free_pipe_idx;
+}
+
 int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
@@ -3372,11 +3396,31 @@ static bool acquire_otg_master_pipe_for_stream(
 	 * any free pipes already used in current context as this could tear
 	 * down exiting ODM/MPC/MPO configuration unnecessarily.
 	 */
+
+	/*
+	 * Try to acquire the same OTG master already in use. This is not
+	 * optimal because resetting an enabled OTG master pipe for a new stream
+	 * requires an extra frame of wait. However there are test automation
+	 * and eDP assumptions that rely on reusing the same OTG master pipe
+	 * during mode change. We have to keep this logic as is for now.
+	 */
 	pipe_idx = recource_find_free_pipe_used_as_otg_master_in_cur_res_ctx(
 			&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
+	/*
+	 * Try to acquire a pipe not used in current resource context to avoid
+	 * pipe swapping.
+	 */
 	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
 		pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
 				&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
+	/*
+	 * If pipe swapping is unavoidable, try to acquire pipe used as
+	 * secondary DPP pipe in current state as we prioritize to support more
+	 * streams over supporting MPO planes.
+	 */
+	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		pipe_idx = resource_find_free_pipe_used_as_cur_sec_dpp(
+				&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
 	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
 		pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
 	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index d17fa73d72a3..7cb0ed612716 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -508,6 +508,17 @@ int recource_find_free_pipe_used_as_otg_master_in_cur_res_ctx(
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
+/*
+ * Look for a free pipe in new resource context that is used as a secondary DPP
+ * pipe in current resource context.
+ * return - FREE_PIPE_INDEX_NOT_FOUND if free pipe is not found, otherwise
+ * pipe idx of the free pipe
+ */
+int resource_find_free_pipe_used_as_cur_sec_dpp(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool);
+
 /*
  * Look for a free pipe in new resource context that is used as a secondary DPP
  * pipe in any MPCC combine in current resource context.
-- 
2.34.1

