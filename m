Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3380FC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D31B610E8AC;
	Thu, 25 Jul 2024 18:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZExAIZZ";
	dkim-atps=neutral
Received: from outbound.mail.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635E710E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e23cKjqpAYWLHlxK8c/NfbO9IWz+YUiMLH8X0/svVlxWt88EThZbg5O9SFeWk3UIthM5uWtao/OQn2PNwBcS3VeUAmUi4j/3TtoSH0rRPTdicPauDYE9En9Wtz1P/mKEgpDNyfKvNezOMgc3JUshsWWweELQ652IqSbLYCUSTSYk2aZm8uhw8VfMnkQxBwAR0epNhPD67vGFQLxuJKMSy8j1mB5tr3xU+Pp1VVsmN8hXdlN7rdA+NDKNTNs13FVwJ/eX88GQVW8VshSrilmvDRJ5dJ+KusGThnYTmMxQWVWt4G+XCuLxgPV5l4nbOtqVmSIyGk4RAXRaUXOjEIgtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acS53DxSGakRALvfCUW7duAyIdcebfp1g1cX4m2EvTU=;
 b=tgaXx+cS+oOFfwKIInYa1EQNyoKz6iZEh+afFGMmrh1rxBiMH9pDMSh6YkvXQTGjIeE08jC2bLkHog27yQ7ARWSXigXQsQTzcDPHRv+NUKYQXfnjYTfs+efS6J1xl3DeY+uodoaP136fGf7bnhatTDWuOyWe1oC8YF/RNuhbqz22B716fSWv7NKTxvEiuCgP6XALd5TQFegJqVtvFt2f4h7kc5PD1TsogdJtZuoVlTqtNUVRyr6gye6NvyIzrnhT3ocKcRpah5eBs3iG3ZbYuvCAOlEhgvc8oAFqIUd/YrJHNOfDDO/xODzqfJlM0kOEG1HVCmrs4YF61j1xou4YnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acS53DxSGakRALvfCUW7duAyIdcebfp1g1cX4m2EvTU=;
 b=mZExAIZZwHMNAdGTDW8PJ/AzsZFQXtpu5izWruvdnbaCXGGzLct+Dp8yE6buod/3Bu7g7m8Cs0GJRHUjWX6NPEzT7HToCirbLVh2Vcy1bjCimvtlTFZ9+VuF/xBaN2mge7AYzJXk/HtM8ZoarEpsBusblQAZhyDjVNSXVZR6tZk=
Received: from CH0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:610:119::31)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.27; Thu, 25 Jul
 2024 18:04:19 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::7) by CH0PR03CA0377.outlook.office365.com
 (2603:10b6:610:119::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 20/39] drm/amd/display: Check null values from functions
Date: Thu, 25 Jul 2024 12:01:04 -0600
Message-ID: <20240725180309.105968-21-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5048fadc-7e95-4c01-c8ac-08dcacd430bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8QZTDVGSAmrRv8bLCWEZLty79f//eZXXhRrUIpOfjq1Bx48FjsDkPr9T0Nfn?=
 =?us-ascii?Q?k4hBgKa+FRItIE2trS0+0EzgLHVjzpJDKCxmXdeRWjKqeyGv84The3ur6lv4?=
 =?us-ascii?Q?dkpvo9q+gILdXutE4A0cFB7k4zo5AzuOjDfuW0v6F9hxxpY5QTF8e0t2kILS?=
 =?us-ascii?Q?yZl9tN/5EVC2v3e4c4MG5Aky1sgiNweYCnqxykRL315K4JJ2tVYkXAFxgjaN?=
 =?us-ascii?Q?a9417ELA47ix99vQNg3+VP17BZa3rc3bkXpagKPtmY+PR9yV+g30I3Shnieu?=
 =?us-ascii?Q?ZYWMwlQR1xkIH0IuR3ta1TmE9Hlqc9iM/hox7Mfc9v2CB+iok/wpvgQowJMF?=
 =?us-ascii?Q?IkSJq7ctL6nygk4CKv7/Y1QyacrOu8VbnTDsDwaYc3ALp80y3K48xRvxwH8N?=
 =?us-ascii?Q?Cf4KLdUWHOWeYPVeCJ4J5tCrmFEJ9oACaDz+AvaNLJuonogcZbEMFU3k6sRI?=
 =?us-ascii?Q?dGC9DtwFt5uwK+enr+ZR5QFCw7mF9xS8/KE7dC52VYpEn9yvY3qrPZLeS2nJ?=
 =?us-ascii?Q?3yJj/hzx0BNqPyLfMwISZjh2WiGUDd/QiyWDRZ1WGqTN4+WUX+kz4Rf0GC8A?=
 =?us-ascii?Q?urk9Db9SOvj8e775JwXcasIxpqPJUim/tADOFcnhcMe2FxcBbKMGFKvc6WDs?=
 =?us-ascii?Q?WpwTr9xnmGg0W0V76xGC2qxMqFYZk8lKVIbZpp3tbObPC1ZqLhOC0ZvCcj3F?=
 =?us-ascii?Q?Gi8ybZ26/U99mheK2kHDW6cW6tW0S1o1WI60qbDsryQiopDQGBVSehNfWE+X?=
 =?us-ascii?Q?GXnJpXWAhbH6eGx6cEzCiDlNdDlEk2UGdgyOdir4zaoGN+HqOMJLOM0XXDWM?=
 =?us-ascii?Q?1dm0Y/62uMy3UNGxxeEck1vRLEooD0o737n741XtHYOIVLWtMw/5qqvmD5wb?=
 =?us-ascii?Q?/+u8bfSQHOJVA73T7gKPBmzjTCjo9ZEGLEKR21LjKw2jtPsPJWUpUfYY5GYd?=
 =?us-ascii?Q?kZEiJ6fTXrZ/3GYWPB4yBatUhI889W6L8eDcDCbCy6fp2qyqxRrg4a7jQoWe?=
 =?us-ascii?Q?FL4i3nj2YT28BEtXzVG15zHUlr3aROyl/G7/UVIbyhGn6U7iMo/VqigH29Xk?=
 =?us-ascii?Q?3oNzdyqzML0l0uKcM0WQ63ZxtbBxdo9IZrAWNzhuWwtPzP9XuAXSIz2GVvqP?=
 =?us-ascii?Q?OZbNWJQk14Dk5p7KKtVOil2FGxbvsuKK4PcbponeCBmNb7jc1H/rG7Z8Y/k9?=
 =?us-ascii?Q?OcgYep8Yk5OtjfNOmvn1xSHRMbnfDsz+Zw8U0N608iSGuSHZHtvRjE0sLy0D?=
 =?us-ascii?Q?49ylRLUs3CdbxfFLUTcI6UeBbUYO2rS1Hx0QJZoXLFGUcMPjimgolUnFMhXU?=
 =?us-ascii?Q?KsEOQoLp82fsMm6WWPAgbuut9fPB6z3J0UrlY2fNCuGLE6z4zi73omJk0Emv?=
 =?us-ascii?Q?fMX/6xO/3vmZMYd5kzRNhYvbKh4fNrgFGq9glyQqh8ExKQgvf4vw6RYItQ86?=
 =?us-ascii?Q?8Lhtbhu+pu0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:12.8368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5048fadc-7e95-4c01-c8ac-08dcacd430bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

From: Alex Hung <alex.hung@amd.com>

Functions get_per_method_common_meta and get_expanded_strategy_list can
return null and thus it is necessary to check their returned values
before dereferencing.

This fixes 3 NULL_RETURNS issues reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index dddb21818f8a..9331a8fe77c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1199,12 +1199,17 @@ static bool is_timing_group_schedulable(
 
 	/* init allow start and end lines for timing group */
 	stream_method_fams2_meta = get_per_method_common_meta(pmo, pstate_strategy->per_stream_pstate_method[base_stream_idx], base_stream_idx);
+	if (!stream_method_fams2_meta)
+		return false;
+
 	group_fams2_meta->allow_start_otg_vline = stream_method_fams2_meta->allow_start_otg_vline;
 	group_fams2_meta->allow_end_otg_vline = stream_method_fams2_meta->allow_end_otg_vline;
 	group_fams2_meta->period_us = stream_method_fams2_meta->period_us;
 	for (i = base_stream_idx + 1; i < display_cfg->display_config.num_streams; i++) {
 		if (is_bit_set_in_bitfield(pmo->scratch.pmo_dcn4.synchronized_timing_group_masks[timing_group_idx], i)) {
 			stream_method_fams2_meta = get_per_method_common_meta(pmo, pstate_strategy->per_stream_pstate_method[i], i);
+			if (!stream_method_fams2_meta)
+				return false;
 
 			if (group_fams2_meta->allow_start_otg_vline < stream_method_fams2_meta->allow_start_otg_vline) {
 				/* set group allow start to larger otg vline */
@@ -1768,6 +1773,9 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 	build_synchronized_timing_groups(pmo, display_config);
 
 	strategy_list = get_expanded_strategy_list(&pmo->init_data, display_config->display_config.num_streams);
+	if (!strategy_list)
+		return false;
+
 	strategy_list_size = get_num_expanded_strategies(&pmo->init_data, display_config->display_config.num_streams);
 
 	if (strategy_list_size == 0)
-- 
2.43.0

