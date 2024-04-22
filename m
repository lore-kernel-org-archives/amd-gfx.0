Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B797C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79790112BF8;
	Mon, 22 Apr 2024 15:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TKeBned+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C4D112BF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flF9CFtDMuRLGngru5xyozriQGkAxSVAHIcAaQKuM6dQw3285Mx8k5oN41qJnn+lPaKW/n6dARnVFU9s71AwNzPveXAVnq0WIceFDbhos55ZtWXSFFhKtjM/EYDjfYLPefq+dt+DzN5h1Uoc9xyUgwnK0axUAmArPenvwU4H5rGjg+Njk77XYReYbrk8/9QCPakJNIfDK/b9GGRreqAvn31gEN8p2rh9KMRpqizUaYdmCJxoHEY2qHBrnSKlpxSmSQlSUYvKgLrnhgCHYD0LFnsghQYdblF0cafU8RmoTjjxDBJqPloOAhnr6AqEyoK1tyjZidZiqETSDNNiZ6ZUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wYhEARk5HhQ6cdBSVUAhqaHTg8eOdpy6uC67QkXnwM=;
 b=FU/6QFsvAAP5Dp+IhEjaCmSGXr2iLtd+XBaid9Za8D2WhWE9Fe9QbUokfe6bXuwt4CAgnwYpCPqRwZ3KQXVQzbpwxllLkkL0+m2p+yiEgEFWe/J0d3iR0fcPushxg2dLyH0NL2+/BV4V3E8Xu9XWkqdg2Cs1KmLmdXi+vTTsWZsDBHg/lhhRjy/qVmiIbg47wy90qi3hZnFXI1uap87RCLikJYpHibHOX44E94WTP+Cx6dGwVnrE8hlB0+Tkb3I3KXUeuEk/eiBS+t6G7fM8J6RhNjiJ7AWrSwknWJyvHk6Slv7L1Nw/D7KQ94Z6NeAyOSRDkoRgxB2miHGqocudIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wYhEARk5HhQ6cdBSVUAhqaHTg8eOdpy6uC67QkXnwM=;
 b=TKeBned+cme1XFkddxUDT924p2c0WTwwq6UyiZP0asa0XHfupuVYfN2rOthjC9TeHx7sB0yu8eK4ubLnof4z0m7ckBaT7c31oQYfD5ISnNx8CvFTDYDJNXBWgdAJZHohbmSuaV5oniWrGO0G9wYrOwrjH6XiCGTgp4N0arc/EKo=
Received: from SA9PR03CA0026.namprd03.prod.outlook.com (2603:10b6:806:20::31)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:30:01 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::6b) by SA9PR03CA0026.outlook.office365.com
 (2603:10b6:806:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:00 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 18/37] drm/amd/display: Reuse the modified power sequence
Date: Mon, 22 Apr 2024 11:27:27 -0400
Message-ID: <20240422152817.2765349-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 242dd83a-ac96-4459-af48-08dc62e11393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a/2mb6lA/Ws6aLfblFxNaFOuzIzDkMZnjBGzYAXj7oAHlS4G9OWVVgjtPHsE?=
 =?us-ascii?Q?moBPVGVi35Fa3RsvrH5xwPpztFC1M24JFxaaFIykoK1gBXi+RzYSNUdzk+sY?=
 =?us-ascii?Q?I/hj63xUQelTqrdtvNMdpVG3ANjPd5qGm2TrxWeXWnPN3lDk9gMYYcf2qFoI?=
 =?us-ascii?Q?agt8kAK/zxQiF6KigFh3UvRtwrlmKpjRtNAumZEi2u6lTBSDXC50Vv5aXH99?=
 =?us-ascii?Q?TgVdbY7sSv5r9BOAPpYlkIJLOBzVD1uijj12S6u4XaU6LkuYiW9RLh69bK2m?=
 =?us-ascii?Q?yjp2au7VE1aoqHy6cF20L3FmmPgENkgBWbYcO2tucfcVNUcG+oPWjoaY/QNb?=
 =?us-ascii?Q?3HPnMXpFmikEtk/dYTjRJ0e3HFMTMcj56jjWX7yA7N22vtfcJxZggcJfL0lB?=
 =?us-ascii?Q?6S3PWQeFVVcun/WUhGE2bvH9SWvtiky0jUTeyUhE1H22MIUy+8ev9T72szXC?=
 =?us-ascii?Q?4/lUTOEmQ3rSfPcbxcTf5BfYp1dIPfUF6FlKCuFI1naTbIjH+LrJc3f9la6w?=
 =?us-ascii?Q?CUgApLSAStS50eqHTohztzeAKQ+asOP1sgeTqdLaEH60/J50UbePjx5VuyM3?=
 =?us-ascii?Q?PPUzA9foBU0BQhB1fXJ41abW+db1QW3UngBSottTS1W7IlUahuBcpcN4arzq?=
 =?us-ascii?Q?pcUHEm0+mM3fwlLmNQZ8OaYuCVPlH+C9Me5HUkQmpAFEISHjO6z0/bmpn86L?=
 =?us-ascii?Q?55j4fVkGz/z2v2jyiRn7w3W6RX1eAdlnVClc4TnPC2OkXVQAB+cE25gAMkAu?=
 =?us-ascii?Q?Wcf/J2wmIhQOmPBH/Yc4UJyAeiZUOdxJytodWEEdfSnHX78h4Aj05PsuvjXB?=
 =?us-ascii?Q?APTdGz2CJyaMNBnEszVPCQVYL7bJNgPxT7ki99HUJRPLP6lVTh9HuhRmLiMD?=
 =?us-ascii?Q?nQEZlULvGnI3B7Hr+XgwbpVEGsiGwG+8I9FFTHBbZD5c/ZuHHyqncXjZ8epg?=
 =?us-ascii?Q?IPILB7TtErxx5KkZaH89AkpECIam+8nC4v9fCVVD4hKFct21RVDEX68dO96t?=
 =?us-ascii?Q?u2SBj0zWV4GFx5dVxwdsYF7AHtWGwDYyQ9zxruGLAbezAImMvcweiIvYm2dT?=
 =?us-ascii?Q?geyp9ragVSHk7tqpi2viXXtlGogVN73/krb+8rqeLYV8N7bSfiwr8oUIUOAv?=
 =?us-ascii?Q?Ww70pb+OMGDjNoJojaOFZ5RrNHCuJY27JjRV3ISMzU2tgtibVF+eC+PD4Qsy?=
 =?us-ascii?Q?E90WUk3mKOMNhUTFcV7iTz8kF0XBvAhGdZogqWIAgE9sPQnlzU495+Li7IHw?=
 =?us-ascii?Q?RiXcZ3eBoZexDH5b42YKLnbhy4rJbenlHhg0/QqZG9N+gwiksFk4XYcBWYtY?=
 =?us-ascii?Q?4XMM9L6hG6x2pWsRMyNavO+Rcmjs/rCLiE/+8d42yiBvB2cEWl5p5qOuHvEY?=
 =?us-ascii?Q?n5VRLwdg26pjkR+K+k/KKwO0qAdB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:01.4752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 242dd83a-ac96-4459-af48-08dc62e11393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why & how]
Need to update the function pointers that
perform the power up and down sequence
to reuse the modified sequence as a requirement.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index a53092cd619b..c4944478ed91 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -116,10 +116,10 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
 	.update_dsc_pg = dcn32_update_dsc_pg,
-	.calc_blocks_to_gate = dcn35_calc_blocks_to_gate,
-	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
-	.hw_block_power_up = dcn35_hw_block_power_up,
-	.hw_block_power_down = dcn35_hw_block_power_down,
+	.calc_blocks_to_gate = dcn351_calc_blocks_to_gate,
+	.calc_blocks_to_ungate = dcn351_calc_blocks_to_ungate,
+	.hw_block_power_up = dcn351_hw_block_power_up,
+	.hw_block_power_down = dcn351_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
 };
 
-- 
2.44.0

