Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C7C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5F310EAEF;
	Thu,  6 Jun 2024 21:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVvFNAmy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B3B10EB03
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kouQ8NPVUPzRYicbaGWy3Qdlv+YkA7beJCMEO2stXGiVsJzRTBZWnCFgg/pTmxZJaE0Gu/LASazTQIraFulqdfdNZcRhJpYTxJtmixhNY9VAv0TgyY7womciuLrk01pYzwPIsGMLidZIkc5q3JOmdiL9YsZ8QFMt/OIM1+FFrqvuCdB7AXiEoQQiphdEfQqwf7yJZ1WNOyETnf5WJxmaGkkN+8gKyGyFaDEjgpVnxP7FsU0TN/esgTPKnfc2BtVA7bDeN9nhfKrZuGaDwUZ/IWv4Bpy0MndcjH395cuQgiOr3izYp9MXPPzoy2YCxs/IVhyr0jW+JoZ5btQ5ruRChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLGlGGaMzMVcMN6t7IJSU0+xKb34YngdKrzbTSEkshk=;
 b=D3+H73qBWmLbfhfJdSbxydo0CXDbIPYWa/LNRRPi6YIoL92J61eO/RQQQk7wG47qCZUvDz6P4bkXyjr87TDtUsdQmUeC1HdY6wPBmxa20LM+oVo44weX1F0F0XQ3HA/VC+fz1NjzctfhMtz+wvYmaGgHDDK8VwjY8yqFHOj5kcZzuPuWca7JGSXJeEb0jQWGRgxLBY+257OjMpzn/x6GbgB0X5722izB+r1XgcdIMIBwvWKAcgSziOXvs0i8Id2/CXswibeG/7Ao20Obu1KdFvX7SFTbG3b066hDop5a8N2OJtOSJyY06wi0sgda6L18zVpINz8235RpRMLdFnoK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLGlGGaMzMVcMN6t7IJSU0+xKb34YngdKrzbTSEkshk=;
 b=zVvFNAmyV8blwMuqVow56HEBZWPdabN7tXhU6PZCt+Ed4CfbvzsP9zjMgTO5rV+R4NKucjw3ivvqGu8KYJDJiMkHS8FFo2TStJTgK0TfZ2el2jWR8FnPDaKRUbsQKazh3SeBDIeypQzmpTjEpQeke9swH8VGvai/qrf9RBpaLIU=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Thu, 6 Jun
 2024 21:57:59 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::1f) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:58 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:57 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 43/67] drm/amd/display: remove dpp pipes on failure to update
 pipe params
Date: Thu, 6 Jun 2024 17:56:08 -0400
Message-ID: <20240606215632.4061204-44-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c681992-a99a-410a-d610-08dc8673ba69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yxcNLfWtorPBkKfQ312oPK6VuKiOipQRn4e6gmZ1d42Ep5GiY6xDkb6FB8wH?=
 =?us-ascii?Q?2gF9VST8GmMLJx0HVaiHaLWnvjSsOpA2EpwFQpbwrkBwpBidhsLx1R5vw8Es?=
 =?us-ascii?Q?sAggs5e/rlbpRMj/QzvjiNd0yUHAFAbNlgmcSpUeMhGXzcKcWrXjXuqRVhUK?=
 =?us-ascii?Q?ZxhXYaT82oxD4OskMIQl83prfyTHv1IW8OAt3S1vm2Gmz2Sqso0tHRGJzsn/?=
 =?us-ascii?Q?xdqzAfDZ//vfkaa+8hD2ZdUEtHqHpi1qDAZilo3lqHA2YStpPZ4JIhiaGF1N?=
 =?us-ascii?Q?sS1rUXwmbTOfXmuXDFpsikiwn7ds9Knds999YKfxE8bv7yuuqrkof7u+5yvC?=
 =?us-ascii?Q?KCRTIbwpJ00nMjVOQ/UY1mKipcEKLq+xVGnnNwufbGF09CH11hwPf4Ixedh9?=
 =?us-ascii?Q?fndTGz1q1jkch94uSAz94L7FF0pQct28Hf5LP31QtBxRawqSq2F4m3gO7oD5?=
 =?us-ascii?Q?LBOb2ZwxE4US9xBKKbJmxD4a0Ks8pIVAzX8OAnHbznr6MwQ0KQ7g2YfYQO4P?=
 =?us-ascii?Q?qniN0l7+Be//LyHqm9AGYIWPkOzrbbQMQfYVeBZqVD/7SKL1PsN7gV/Cfp+Q?=
 =?us-ascii?Q?yMYuMMRgXydOCy95q+bpmc0syBP2SmTvVJEmSFB3Yeqyf6WuveGQ0QJtvTIh?=
 =?us-ascii?Q?Tuk20juXpFFWnNpWaO9jSh6MXRc7hB8x30IzbE40bsjsGT/8aQ0EIEtZrPaf?=
 =?us-ascii?Q?WhZ9a+tu0SQNtZmNvGPTBjuK83oLWAbzMyaZ1TPmzp2JDVNl6bS5PW0YYg/F?=
 =?us-ascii?Q?OSRrVJlS5Bqdea44Z8idAmY4TMPZsn+ZpFEd4oxb9kF50ioB2GksDQexrFJt?=
 =?us-ascii?Q?s/r1fVT3xPn+Smu3hd88jEtczg6Qn7giyhXu+9YckV8ahzHV/ii5KpIFGaH3?=
 =?us-ascii?Q?5Z5ku8UmxDH9HD8OEUblEJgrilCb7O+sbXv7Jrh2/5WWgqo0/iJ+Q5jOWQ6Q?=
 =?us-ascii?Q?CEz6frf4m0fF3nU+3d3TNpIxunJ0GiH/H5IG18axZrB2Wk4Dszmkc6WiuG/l?=
 =?us-ascii?Q?fxWz5BtgOg15g7LvBG0Va2pE6977JtObwgIF4NgESQpTGUqtHcOcE+WwOcdi?=
 =?us-ascii?Q?QGxjUpra9Wuqo0cxFl0+Lfc1gFjH7mz9FrQEyDBjYvH8BBZje8WVcdihcUSS?=
 =?us-ascii?Q?1j+oGRvwqhBeg1VaQO6KfFm6ljAN+rZkQW+ylHX9fIrLmnXPx1YZxyl9+XHx?=
 =?us-ascii?Q?OisftdbPpEpLU9atMFShy7Ol8rh43Deb1wXT/rl5mQKdcbl0VLcOb/0oUM90?=
 =?us-ascii?Q?E4lNGdYg0jtfGmQWS5JXOS/GQtiOFtHIQLDK0Tl67g7XXoJ7mxIZtWasNvtf?=
 =?us-ascii?Q?rPyDvc6rwNlSsKl3BZd/CNZ5zaWGuOpiqyZQE1tNGwPCiyVKB6FVbjH/SnLt?=
 =?us-ascii?Q?hXigfrLVeEJWdT7/RRxWIiCBEoyscm9H6XlO8ZGkrrwuifg1dQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:58.5845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c681992-a99a-410a-d610-08dc8673ba69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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
There are cases where update pipe params could fail but dpp pipes are already
added to the state. In this case, we should remove dpp pipes so dc state is
restored back. If it is not restored, dc state is corrupted after calling this
function, so if we call the same interface with the corrupted state again, we
may end up programming pipe topology based on a corrupted dc state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 6d4d4c95243f..7894d3e52a27 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2789,6 +2789,7 @@ bool resource_append_dpp_pipes_for_plane_composition(
 		struct dc_plane_state *plane_state)
 {
 	bool success;
+
 	if (otg_master_pipe->plane_state == NULL)
 		success = add_plane_to_opp_head_pipes(otg_master_pipe,
 				plane_state, new_ctx);
@@ -2796,10 +2797,15 @@ bool resource_append_dpp_pipes_for_plane_composition(
 		success = acquire_secondary_dpp_pipes_and_add_plane(
 				otg_master_pipe, plane_state, new_ctx,
 				cur_ctx, pool);
-	if (success)
+	if (success) {
 		/* when appending a plane mpc slice count changes from 0 to 1 */
 		success = update_pipe_params_after_mpc_slice_count_change(
 				plane_state, new_ctx, pool);
+		if (!success)
+			resource_remove_dpp_pipes_for_plane_composition(new_ctx,
+					pool, plane_state);
+	}
+
 	return success;
 }
 
@@ -2809,6 +2815,7 @@ void resource_remove_dpp_pipes_for_plane_composition(
 		const struct dc_plane_state *plane_state)
 {
 	int i;
+
 	for (i = pool->pipe_count - 1; i >= 0; i--) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-- 
2.34.1

