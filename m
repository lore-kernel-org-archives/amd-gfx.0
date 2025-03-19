Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89591C36000
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5189A10E569;
	Wed, 19 Mar 2025 17:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yFD2mkAK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD2810E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrXjpYoE7KA8k7484TCZ5riEoioN9l0iVF3arUhvIJb+cu0g1gvELVRPI2WDLezfmUs801RPsxRNP24cfSJg2t/XzIy7riyEidlBrMaQCJv+WJ6G/bnH8S629x/YUC9osrmJewYenFLfWQb3g8/p4dWLaU7o7pKhP4/F5WrB8KjU6FFAaEz3mJEN6BbFBga4Vv/ztS8cNKzjLbHE05e8L+TmAh/h0zonBGJTUqe7XuOcV8gpIq9fVZl0rgywXPJ9eQj67sO8BIhbBERK/tG7viBFL7O1x667EOE0KGiVvZWq4x1z6mkL4GHROTIthELlVYKTTCeHSD8szR8Mrb7p8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUmJeH4ryG6FFBiOAOpXUrYB04xK0Hc0cro/VMHzxWk=;
 b=VAixyzL6OrVUsOlS/7Nrrs6Rz3wfYqNnjg1PMx2foE00B21Ul8yadcGNxOaqaMw/xe+oqnwZIdqEBDhrcOlYN77Q5zt5lWVuQaS3CO4s5ukJOeRXzm/DAUx+2c39yrbi2KbLT/TlC0tgxx4svgS2Cq1dCQoJikTIOcBUZMFHND5DM/Qi5lfcqLTfiPbn/UINMpkhH/6kz3Jj5dXf2Qj21SEMyikzvbVft5RwWQqyiP5uvuskGegFY7hoeV1pNnSOSZGURtthpj4TwDLPgmyao/PsuNPuRid2Zp8AsXBRtV0m4WbBX33XagUnReV2Mv5UQvSNwxVXcOlt47tMqxj8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUmJeH4ryG6FFBiOAOpXUrYB04xK0Hc0cro/VMHzxWk=;
 b=yFD2mkAKItioRJBya8T4PWT5+h+nKOceJa0cX86PKNkcZSPgSrhcGS3+HvVBEF13VkElsbP5SpNt0F3LL2QSbfgj2jsu9tTs+KszPLsdWj2JoWUsJ1fGem0ZkleomwQy1id/sCLq10Ns2XyZtSJNGyhClW164ltfbyCXqIbi5Uo=
Received: from BY5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:a03:1a0::15)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:31 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::7a) by BY5PR16CA0002.outlook.office365.com
 (2603:10b6:a03:1a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 17:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 17:57:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:29 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Brendan Tam <Brendan.Tam@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 15/16] drm/amd/display: prevent hang on link training fail
Date: Wed, 19 Mar 2025 13:55:20 -0400
Message-ID: <20250319175718.2578234-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f92344a-d9ac-42c4-05fc-08dd670f84dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jH5EgGgszavkvv8wGzDd6fZfmSwi/dgKTlwfjXDZ9bug/7iR23/A7osUxL2R?=
 =?us-ascii?Q?ZTPGm30yHHwXfFlJGGM5oR1SID8jwydT+lDYGs2PhayHf+mmkMeLDW81AnVk?=
 =?us-ascii?Q?EzZcYhRSu4R+dgxKkgOWxHhtSqSjCb7nnuNVF8boG6DBKFcsobeKb0KXnaca?=
 =?us-ascii?Q?XvKhiDZ3BOKL6PGDTRwabE3k5k7zRLRdBPoT2vs8uTSWxyjM+c6D2ACnMFYI?=
 =?us-ascii?Q?ZkioAONw+3n+PYj8Wqnf+3bL79+zQv/MqWHRTfOB45Mkf1fMfV65YOZOk6lN?=
 =?us-ascii?Q?vvl5lprRm3zZgib5Ps5an/cVeXJv7y66DVWwAmrAHBr6KdGGDSMOPKwSs1Cl?=
 =?us-ascii?Q?KY538L9DEjucIE4oqI2m9pvU6pi/KAmHUISGLv6mEC3MViIr/OhjKHA/YBmC?=
 =?us-ascii?Q?VgRajub9YKQE/hxP2ewNsIvJd5PeVxZPbW0xOspEqmENJnkzyIlZyIbX9pjm?=
 =?us-ascii?Q?PYELK5F9dRcKqqSQSAV5Ak8TGOwBQxRirNgmFrFEUuND+xlWw6qHXwc2+0UT?=
 =?us-ascii?Q?RMhUq7ekOV+jG5t6HBDIm6K64QyZD6pDuwcVQPKjLT6gQpS5QY2nkj/rDudR?=
 =?us-ascii?Q?5nrjKuWova+Slmhqs550k0Tpt0isfED6sFRLnU9YCUom11l1oanCdlbCkaJK?=
 =?us-ascii?Q?WK9GvpHYDTATJnU4mMhPOAMZ803xd2OgL6VvmXLa4jRb39xoqVpm94z+MfT2?=
 =?us-ascii?Q?yfLifs+l4sWOySZOGD0rfJpcQFRyrwjPMDLY7dCjyH0YZOj+AMSrlwWMurZb?=
 =?us-ascii?Q?OLh2xi5jrX/ewCaMSTIk3Wu/9BuQJNPkAZ3UkgMq4Mil56hUMCG7RCyamPvG?=
 =?us-ascii?Q?lSgAYhLTYouri7ZQp/Z5DZy7/7KlKzWc9HvUgFEuWITU0w38gDgqZGXg2Uqg?=
 =?us-ascii?Q?gY4x0qTMXW9vhhoD9cVIKrsxnouvZmOOsreabGkzy2NLknbHsVNCYXVrgFDi?=
 =?us-ascii?Q?ttBS21AToazSzirrbBXG6OC4kBjJ+YXMZcdIM23IjQkqXD4Fih1Fa0hyA+08?=
 =?us-ascii?Q?IA9dpLpvWqDZu583TeKI0R8lXwIZ8RMR3T6wZBBAG5216kSKgePXiKGdAFN7?=
 =?us-ascii?Q?YVQGN6WkMfdpSRcWuvCpufZpt1dkT93bjtf3vySCJu+7q4JgnlKA+20safim?=
 =?us-ascii?Q?kmVD9hhTdx6N3DFTTafCitaD9OxL51LbJ6kO83ejcqq+lWAoK1pj6N9wr8tM?=
 =?us-ascii?Q?aXgNw8tJRO4RGlN8CFlbT2NVaiUP8mHNOAaynibc+yhukoOVCZNIdCPQbcNk?=
 =?us-ascii?Q?rG89LLCBZgE+4+a3kW7ircZq8yLwQv+fqp/d7OHIbMsrqLzHAhPdqNE2oTZV?=
 =?us-ascii?Q?GFGORtfAPE3votQqooiwOxs9bGuh1EmZ6aBhn7UypnTInuN5cgdjgJpqETjX?=
 =?us-ascii?Q?pwnu3mAdyeVB6tCJByuYthNVzeJaMi1CcrrqkVcIsoBomOW8FlOY3KPs2sUA?=
 =?us-ascii?Q?berVwztZcnYL8tFSHL3GiWLE1A1wov//OPajDNDSzgz1qR4AbjDy9zlKCUVB?=
 =?us-ascii?Q?bu+/smmmBd4wfFc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:30.6163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f92344a-d9ac-42c4-05fc-08dd670f84dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

From: Brendan Tam <Brendan.Tam@amd.com>

[Why]
When link training fails, the phy clock will be disabled. However, in
enable_streams, it is assumed that link training succeeded and the
mux selects the phy clock, causing a hang when a register write is made.

[How]
When enable_stream is hit, check if link training failed. If it did, fall
back to the ref clock to avoid a hang and keep the system in a recoverable
state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Brendan Tam <Brendan.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 6 +++++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 7 +++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index b2d915924a78..959cd2fbb250 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3041,7 +3041,11 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, dp_hpo_inst);
 
 		phyd32clk = get_phyd32clk_src(link);
-		dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
+		if (link->cur_link_settings.link_rate == LINK_RATE_UNKNOWN) {
+			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
+		} else {
+			dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
+		}
 	} else {
 		if (dccg->funcs->enable_symclk_se)
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8f5da0ded850..5489f3d431f6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -936,8 +936,11 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 	if (dc_is_dp_signal(pipe_ctx->stream->signal) || dc_is_virtual_signal(pipe_ctx->stream->signal)) {
 		if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 			dccg->funcs->set_dpstreamclk(dccg, DPREFCLK, tg->inst, dp_hpo_inst);
-
-			dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
+			if (link->cur_link_settings.link_rate == LINK_RATE_UNKNOWN) {
+				dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
+			} else {
+				dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
+			}
 		} else {
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					link_enc->transmitter - TRANSMITTER_UNIPHY_A);
-- 
2.49.0

