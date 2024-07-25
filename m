Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A716C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B2110E8B5;
	Thu, 25 Jul 2024 18:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/A6kFPp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D081810E8B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojb1idv3mrQKzDph9vrDlZOAi9PZNNdjHCHIGE3KokGq5+bDcWc78GqbRErIBAgHRIfgWt+7fXDsMHe76FvBH17Jim5pBhl5teylqVef7nWcmuGMyc9lvUYocBgRnr3L4SgM0u6lgQlWW9HLJtafab1HNGDeQbEC5cEzr+PuUYeCQo2oxQyXUxReRuqc/PTLXKHxmm6bi1DoTI08IRr8mz6TMU0/eDfSI7qJDjOlrL9UHBd8wnANCwkvXFiIYoijrNCFe/onggNZ7C4ucL5pkjmhGsUbTIMLT2cvcxnc4Eu1qWFmcZA1z/a4CBrgSsh27gb8vGa+xs4lGEktRSks4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+qZwbTuWjrfqSRWCfol3ZVhAlyBnvuhRl45bg7plWE=;
 b=gXZfccCuX+P8QSW0dCUjy6sKQqB+6ZR7gqEumhkl/ADvkAD24oO4MIPO+/SVOl7OombtMFpGUBBcBz3dD+AfATUnGKrIzuQ8JZC8n/6YppaQNxywR6NzzirbWd+M2S3+Lp1tfFIow3iQu9YPQMoFr5/OwKTMkIw4XI3CoTcZShJxzHhZY3zcEHiUxLESJfGyrHfnu/bz/ZvlrCY6Jt0PqxuJOpm236Zk89FB670Fx1xjKgdgVN6OFHvjTHflBw0D0AmR9F02kQB4YQ53molI+WF0EIeGOEvb9z6dNghvUdMRf2Gt3rFK7aQn914ta66tfxRgvuSAkCAR/Kt+whdcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+qZwbTuWjrfqSRWCfol3ZVhAlyBnvuhRl45bg7plWE=;
 b=d/A6kFPpi6685olQlgLcX60WfsynG/IOK4JvIbqRZlf9yrxZeY6PLXTdLjKy4WZzpvdScm+HlW3ojvMqy+exvcwKPTdYiCIE8nCP7oZQmXMakq7i+fdVnGdlbPUynuEvY1vuo3OKlROiKh3IHxwoXUrv3z3OivhLE7D/rL8+PQY=
Received: from CH0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:610:e4::9)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 18:04:21 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::b9) by CH0PR03CA0184.outlook.office365.com
 (2603:10b6:610:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <Hansen.Dsouza@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 23/39] drm/amd/display: Add new enable and disable functions
 for DCN35
Date: Thu, 25 Jul 2024 12:01:07 -0600
Message-ID: <20240725180309.105968-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b9ef51-1346-4e16-6fbb-08dcacd435e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiVwdzfe8YooujrJVRojJ4TpbTSuF35eKy5AcAWVWr/NC8lWNdqwyPf5TOZz?=
 =?us-ascii?Q?KxVzU0c12n1101xl5pFbUQJTlOWwMvS7v2+i7XeOiVpeuiGRNW/obmU84wST?=
 =?us-ascii?Q?h9CdygCHvWq1DIvEdghp9R+f8DVvNJPeeWIteFF11KuxJIKMOk1uSMoy0CsU?=
 =?us-ascii?Q?OV3WBvfuJaRQQsY/cXaL9Yei2SpT8VsZytQiyvzbzLhG8YGH5oz5b1XrwISq?=
 =?us-ascii?Q?IgmXOD+Yu/Mz4uE2nSeL7rxTJo0pP2UGO9BW812KeTi4wjd+7G6qmaQOsuJM?=
 =?us-ascii?Q?i1L3vIo46oU5t3KzixvnAa2JksPLN9nT7eT85QXVCQI10eiSi0/FG7dlO3S4?=
 =?us-ascii?Q?hmoGlGKBQIOxLl+ezrwiPdXSKfGraSoTaMHNwGVdh91QMmKyy8t3y260n3lZ?=
 =?us-ascii?Q?LdR59Zyen5C3fweVxa2UAa9EzgHIpqLHKgSsOi7oaVAbBvV1ac/M8Oj8ArM0?=
 =?us-ascii?Q?Ag546/41bpcL/YKany7bcEv7N2qvbCysIEcrlIB/0yIFfErdlSE2e+eNO7UD?=
 =?us-ascii?Q?FqPWxMRMw8Z7U4B/pj4RONgocZbHmf/3OtdtX6zwvx4RUJlXaTYMhaeQ8D8s?=
 =?us-ascii?Q?4jj5WJqF1t3QM7kd42whbw0XyAaUf57dimqof9ZuDPMDslHaiyf8eiGA2Kbt?=
 =?us-ascii?Q?IT8OT3RljPr4RpnIfraZd1wTknegmN2Uu3hNoHZyTyxFyBdbYAiJYuJP+571?=
 =?us-ascii?Q?BoVRzK/qYcbyMf5Lrr0QiLSCWOnQriSX6hOljNXwrunqsntQYLrOruhiYiWS?=
 =?us-ascii?Q?dndd1PI9hKaolHsovoG5KENMhTMno4DtB0nHetJ9suhHLhYh0Hh0Dm/Na9Lq?=
 =?us-ascii?Q?L8N0ll+y6L7AT06sBQxH6I5U8FeNjdQRhXN7sMH2RXv8rx9QvAHon5XCJODq?=
 =?us-ascii?Q?dwItvxSoYckNmI84J7kqaa09WZkrO5Qb3W2a6pdWzdvT2snLPaM3mzFb+S/z?=
 =?us-ascii?Q?pIDiUYLSlXuUeCH6Dz/InDP4uElqRiCFk8ver7ZtNuPLKBWeiRaIkuFfqjzn?=
 =?us-ascii?Q?ThwU3SKoTJLmTb6BKUOIP6tDnz79mlsLsXJbOTiYtCIGykzuJ3UdaUJ8JIg3?=
 =?us-ascii?Q?PyT02aLojHnaPK0omEV7O3GPzd3uYC6ku4EjHDPWCYjbIJOQhgbNWawnsRuz?=
 =?us-ascii?Q?XXxIu4FoBHStEm2CkAcg7TFVUNxygWKGRjq9Qkx6WAoDqiuH8nWeh/92qrCR?=
 =?us-ascii?Q?2Trm+7BjukHCxUmtpLVJ2gi/bEHMTyVs52RaTB1D8TrA5Qyw1yWLg49pW56k?=
 =?us-ascii?Q?nUGKhO+1ebZAscWCVsQMcyRoID/+tBCrH5R0MUOOh6i7vHn9Sv7pw8rGCUQB?=
 =?us-ascii?Q?U2gMP7432h/UThcBPEJoN9D6Eh7IAWzUjsK9PngyrbqcZvNL1Tpc24eZ4oAi?=
 =?us-ascii?Q?gIcH7QK6KzWeMEg+9UtDsK63uz7vaYsxDiMDs01LEF9/bqAnFe5Xkdr2P5KO?=
 =?us-ascii?Q?GsFF/tzjCq1r7Y9JbJzJUykmM27hTh17?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:21.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b9ef51-1346-4e16-6fbb-08dcacd435e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

Add new enable and disable functions based on DCCG spec.

Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 7d88b0ae241c..bd3757de51c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -932,6 +932,53 @@ static void dccg35_disable_dpp_new(
 	dccg35_set_dppclk_rcg(dccg, inst, true);
 }
 
+static void dccg35_disable_dscclk_new(struct dccg *dccg,
+									  int inst)
+{
+	dccg35_set_dsc_clk_src_new(dccg, inst, DSC_CLK_REF_CLK);
+	dccg35_set_dsc_clk_rcg(dccg, inst, true);
+}
+
+static void dccg35_enable_dscclk_new(struct dccg *dccg,
+									 int inst,
+									 enum dsc_clk_source src)
+{
+	dccg35_set_dsc_clk_rcg(dccg, inst, false);
+	dccg35_set_dsc_clk_src_new(dccg, inst, src);
+}
+
+static void dccg35_enable_dtbclk_p_new(struct dccg *dccg,
+									   enum dtbclk_source src,
+									   int inst)
+{
+	dccg35_set_dtbclk_p_rcg(dccg, inst, false);
+	dccg35_set_dtbclk_p_src_new(dccg, src, inst);
+}
+
+static void dccg35_disable_dtbclk_p_new(struct dccg *dccg,
+										enum dtbclk_source src,
+										int inst)
+{
+	dccg35_set_dtbclk_p_src_new(dccg, DTBCLK_REFCLK, inst);
+	dccg35_set_dtbclk_p_rcg(dccg, inst, true);
+}
+
+static void dccg35_enable_dpstreamclk_new(struct dccg *dccg,
+										  enum dtbclk_source src,
+										  int inst)
+{
+	dccg35_set_dpstreamclk_src_new(dccg, DP_STREAM_REFCLK, inst);
+	dccg35_set_dpstreamclk_rcg(dccg, inst, true);
+}
+
+static void dccg35_disable_dpstreamclk_new(struct dccg *dccg,
+										   enum dtbclk_source src,
+										   int inst)
+{
+	dccg35_set_dpstreamclk_rcg(dccg, inst, false);
+	dccg35_set_dtbclk_p_src_new(dccg, src, inst);
+}
+
 static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -1965,7 +2012,12 @@ struct dccg *dccg35_create(
 	(void)&dccg35_disable_symclk32_le_new;
 	(void)&dccg35_enable_dpp_new;
 	(void)&dccg35_disable_dpp_new;
-
+	(void)&dccg35_disable_dscclk_new;
+	(void)&dccg35_enable_dscclk_new;
+	(void)&dccg35_enable_dtbclk_p_new;
+	(void)&dccg35_disable_dtbclk_p_new;
+	(void)&dccg35_enable_dpstreamclk_new;
+	(void)&dccg35_disable_dpstreamclk_new;
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
 	base->funcs = &dccg35_funcs;
-- 
2.43.0

