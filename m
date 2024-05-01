Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8322C19F53
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EB51130DA;
	Wed,  1 May 2024 07:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdpZOOs9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A841130DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cheAeZ+lbgU9qohmwQw8wYL6UOdyzzcGX3yz2otQS2mGhAVNc3E1Y9+qypWe79EY07TshK76bPmNtrN7pPztXyXSYPCmRNsunVF3FdmaNy+HtnQGNfnTxfEucTVOAWwHFXPrILY5cfRw9/JZyV9V4QeGfKIk2b4V+q1ve59jDt1NpaH2kJfsKQAJe82pYz8HgfMiC+sAELWtlySFyJEWnUpMwVWipRMT3xfrC4MuI48Yt+52r6vNIooVExKC8l0HK3fowhpoErd0b+9lmN3uxuha4Nf7TN2WPpJvQa8ggeEZ6ncvZE+9LdHiW+/C4qunYt+e1MyJiL+6zd50hR2zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfa/FF1DDWMtxXUtLCx3uqyEzGar1RcyznlwO+D+E2A=;
 b=hsdWOubnQrehsKTAEM9Nef17/8gh6rSA4di3tP5OBUW3C1xoIr29uh3hvI/GSxOCXowvdKIE0rt6ANQONcRzAgAbbAOf2Jo6/ZqqW7CM9BrQ2b1lKISgGNOH91cTaluke6FbuFQ/rzjp7kWxCw9OAo1L8O+TkY0AKPL6/58YjdClAr1jRfAr9vlbXUugliPNaA/hEmB0QzDe5zIdQ9qjUnE3dn2wcfkbLK0INcsfoK1QTA7wAzVaA2j+GTNdnQaE7/WVoFsM33d9azfGZ5U7NbYkOVK7YcdUHwvTuVHw5rTOcSjWHKtlvjU0RzTTCvyy2Zf7J4XSSF02K4kvKSlOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfa/FF1DDWMtxXUtLCx3uqyEzGar1RcyznlwO+D+E2A=;
 b=zdpZOOs9RZBLHH2bGLy9X+nqp70LD1XbaRGRZEisDlqt/erUrD+wjGifUbkt+uE6EN9iT94TUG+5k8xE0TDzUFBnVjnC4wP1wOHhv0c3ta/52wsOb2Raezis98zFPxmBqnGbQnU+hsdRa9/MNhY44ebrpRbMtwSMkMzhioqYDDM=
Received: from PR3P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::26)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:21:38 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::30) by PR3P192CA0021.outlook.office365.com
 (2603:10a6:102:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 1 May 2024 07:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:21:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:36 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:21:28 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 43/45] drm/amd/display: Skip plane when not found by stream id
Date: Wed, 1 May 2024 15:16:49 +0800
Message-ID: <20240501071651.3541919-44-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: a4391113-0a93-47ce-dbc7-08dc69af565d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hQrVUf341hjamEz1IvJcMn+0HU0Jn+wVcL346gTzgyINfKaOFFf6S0n9RWgA?=
 =?us-ascii?Q?zvZPhOzRYwO7JgoMR6xn7+BsX9ZYDo/AvzBLjngogZRJMMQ0NbC2YLgPiGGI?=
 =?us-ascii?Q?dheu1daKTHbs3oeTeEsv8JNZw8Cx3cVGy4Oq6Chuc6ZvylJA/YMvAQWCyw6K?=
 =?us-ascii?Q?uObpTq3CfOYf1qWeT+OQIwvPtFfm4IY78nqillP0MxyGiWsd2gKyyiGzBf0M?=
 =?us-ascii?Q?ixcYJCQXnPtWxlPCLbw9OvwfZWPb1wsP0TkebSm84evdoC9w6eUSoRPCODIH?=
 =?us-ascii?Q?2knzAkZ+vzko4KkFdKoNYqc9U6tp8Z9elKRSmJQWAapWWo4TP5vdPzqGnm21?=
 =?us-ascii?Q?4Bpqnb+maUGN+5wVqA5XEDoYW1cSbbfyJfWSBD2corPp3ySpQVfYRmYWFtWA?=
 =?us-ascii?Q?APsHwfkceIjwrXyyzToGBy/fvGxTTyA14VXnhBD1x/ngKI4Nn+gyLsRy67Wo?=
 =?us-ascii?Q?CpSi0sZafSJkoMFKW5bRNp4fc9ttLK0QtFrFipu/0LEtaGQ1g45uoZ+UfLQK?=
 =?us-ascii?Q?6jLtVF0+sibZzSRKFMtjUt4+VMNHxczkk27YJu4KAts4Ml4SCUUf4zpdDRKB?=
 =?us-ascii?Q?6E9f1Jqhzw4T5nDJXrL63BOi94NGr9PoJ3YF26hmV3sjyOauGQAeXISER7em?=
 =?us-ascii?Q?AmySp/zwdzPnUpd41EkMd6mY6j5uNt2DstE11OY8s5iA1jcVyUZA67x4b9uE?=
 =?us-ascii?Q?tY1wJqTsQeewAOxnwrh6kYu4czsVbzwyFLNPe5GJPjJw3WvCNWIrxN+Wy3Sm?=
 =?us-ascii?Q?8IC4/+hUFXO9a7cjgymd6GChmtspKrZxIwndr9vvPlEsy0ZJ1qsOIgEo00ih?=
 =?us-ascii?Q?VuyVYXC+lh8gaOcsMxaMLVxh95yxzEtBoKos8cAlGMw2HzoWqOsNTf2snip9?=
 =?us-ascii?Q?YR7/C6yPH6XRI3I9azPJem3aC9K9RxKbCLNU1aVvXPlfGAR/FhREI4PTfV5X?=
 =?us-ascii?Q?gPRACDaMXG8FOrjw5lJRRCSYJKeKZTFODLi8cGmx+ntOmTlAU/nEwAIac5SE?=
 =?us-ascii?Q?BZ+k/PyqwZ6nD2rnOtooBykz/el/XMlRorJfxyHfxvsYeV5BQ185UaaHXh4q?=
 =?us-ascii?Q?fRobmigYuN1L6KBWMhH80NSax8sUKjyBB8gtARXFWPHd79Zfn+HHZ1nqAGz7?=
 =?us-ascii?Q?IyJAlmakpS9aEzQJhfgOBcdMuORJsjiVbxcf1DmJb6KvJBz4kVmPTY8KEgx5?=
 =?us-ascii?Q?WP6pIIFG9GgnEMSq6awaKXGIhVU53eOVCDa7fkhaBnjVJu9O2Gc8oz0Cp757?=
 =?us-ascii?Q?8tlHcvDYOx/+WH0Uh1mkZadWSnBzMEHUYw/VhhxeXIVL3oZPeHjuMcVFrZxu?=
 =?us-ascii?Q?X3/XCi9dbe1l+O7HuwcTJpNrALrf98gyAElt85RNpdjnL8Xlnyxu/nx2a8pc?=
 =?us-ascii?Q?1Kla/rA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:21:36.8484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4391113-0a93-47ce-dbc7-08dc69af565d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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

[Why & How]
dml_stream_idx will be -1 when it is not found. Check and skip in such a
case as -1 is not a valid array index.

This fixes a NEGATIVE_RETURNS issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index aa0cc4bb2b47..8c9e95b25eb3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -465,7 +465,10 @@ void dml21_build_fams2_programming(const struct dc *dc,
 		}
 
 		dml_stream_idx = dml21_helper_find_dml_pipe_idx_by_stream_id(dml_ctx, stream->stream_id);
-		ASSERT(dml_stream_idx >= 0);
+		if (dml_stream_idx < 0) {
+			ASSERT(dml_stream_idx >= 0);
+			continue;
+		}
 
 		/* copy static state from PMO */
 		memcpy(static_state,
-- 
2.34.1

