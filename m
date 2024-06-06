Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE74DC27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401EE10EB08;
	Thu,  6 Jun 2024 21:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X6E9AFtX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E923510EAFE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKpMT9w7/21Gtnopbzu5q+4arWlICvTV5htg1g1C41KXuPl7yaQ2swmmA8sySsaRNLPAFWeTugKXMGDJPFPpUCVU+38aJ4xz9DNIcDKuDufQ8ZCGqyiHaTbFf04C7XKYmGpi6JUYah5m8LADRckwsGXkUnJ89qoiA1fAAmBzbstwCi74+1ziayWA+ONKu1BqXnrR94Rn2aw/XhsLqm4OAFlVhb56O94972M8UxNn4RIeWPtY0mpVl3tJxYTRNfdQJXSb7YZuVxsUUL2lh7bUtFSAxulBq9vUtdzLrfxyOMLRI8EMKbZpTOg7qSJhhySZ2fQ+WJWl2hDRXOIOIMF76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkdtMzMVAtCDwrkovAV4Yt2BvKZEP6bUkJkj82a48ek=;
 b=FkVfQlKKz30hABJrPJQPJk52WY7DiazSw1fOypNkIKlNpkzim1Q1PD3C27CuPs2I8C2AorIGy/Hs9FaroZil4QjzAFWL76C8pqMNZFrvsoRRsZF87SqQMExwy2hpn4O5pVCK2ZQ4rI0oDLRM7hYWTodgENaBHrKhiT5lveZyx4acExbrPkJGmA1KlRlI0gpGaPINocqxQjrycU77QwUkVR3MdzKuTBviDa4f9Fn4F91jRtKpDm/9+/1ZM6aSihFwV2ZTdnoIKTZ8KH3o4j/mXgyqMSaWeU+f+8+XEzw6qzJIZOoSrJjLXlwvsNJVQxQsGDgoXlIndq5aSVkwUP5YTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkdtMzMVAtCDwrkovAV4Yt2BvKZEP6bUkJkj82a48ek=;
 b=X6E9AFtX2yhCNI44kt8F/5ReO+KYOHeiZb8RM6f8zxiaGD6g9v4JjpIHzIqrc9DADQ4/zjOKwa+OK3TSe0F5GWJZWmWOSk0bsqkAIAmfWbgekUHyTIhMaKECfsxA8yfF9yLWOVWxLELyHGBXVwsSjnp6RMJFkvgf8bMK4Ispd/s=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:59:06 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::f3) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:04 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:02 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Sun peng Li
 <sunpeng.li@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 56/67] drm/amd/display: Remove reduntant comparisons by
 Coverity
Date: Thu, 6 Jun 2024 17:56:21 -0400
Message-ID: <20240606215632.4061204-57-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 467a95d8-97e2-422c-0d8b-08dc8673e185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W32xcBzNSmAEkr9jR9ukhPvODcRKq8nDPmwmLdh90DXgMskruxwD7PFDUk84?=
 =?us-ascii?Q?Gxmj5laqEyaMZdCNwDCoPAIKo35OflI1SMRRtbOFNqFrnirWpZXREGW/qok7?=
 =?us-ascii?Q?oq43Aw98zTKjQX4BfTYnMNQfYr1Pq+Rua9mCzcU/ho5SgPGnBVi4ghFMkB/K?=
 =?us-ascii?Q?ur7YTO2I4S/ZHXHlmrDicu7+pX4bJjlkt1FsrnnN/8uc2UoqoR3JXbrcLWJK?=
 =?us-ascii?Q?ERMhzSEHglOGREJ/5xwHa4FSnpsg5UStKV97Nfu7HUQ6SAKpwMi40cbLEmxz?=
 =?us-ascii?Q?bpcd/gGYeJ9H3+wM6Egx2ZRbtRl3MUYer5S48GIQQOcJWQRAIme/XTgorCHX?=
 =?us-ascii?Q?2TxLSCWbjNNTIIleYIPtEnmJXYsvqVePlsCceWQn8nKOmTeZwK0XbXo+vXJ7?=
 =?us-ascii?Q?n3332FX1osygQjg+tEqfykDnxiEHeTUobugOqz6gEN24lr8LtRgU/ROsCWpK?=
 =?us-ascii?Q?2hFYb96+kx/U2TgptA3j3osxRAZie0vDe7aD061A8WsDYMiUDz7oLptysqN4?=
 =?us-ascii?Q?+4gt8QbUbAQpZIf18gUts4JfN5CG1E3ucIFYLXghA54gg2giXIRSwWO1aVog?=
 =?us-ascii?Q?NoAiUT8QqHAbz3JTUsNEJrAewYxZsXBkMTQDwMH68AdQieJjonEHpYGAHDEq?=
 =?us-ascii?Q?9T4qu5U7x/PSDO2vJHApsAM7Vz9bDqZWSHVWMoX5sk70vgH4cRg+dfRjrztk?=
 =?us-ascii?Q?XWiZgXvA2EjKPx2Xx9OlJoII7NOD81owu2nIvx+o+wuMAtJ4UQRGH+dXtaSP?=
 =?us-ascii?Q?my/YidjeC9vbNuPigDlCZ04zvIZNeONRaTaC1V3y89YjSHiouKT5BwlfSHUS?=
 =?us-ascii?Q?s6R7hbwcb44nsHzEBkjdF3KKtua/4JZMqRR7m/fXx10pU+N9X9Fky05PHcse?=
 =?us-ascii?Q?YKJryZaBsIg8zyZNC5H92O5E7ZvOeYxWubSxWfTfG7gM5ICHxpaYdB+0tsCb?=
 =?us-ascii?Q?7GTWegbGvd/JuEZGcaQuV9ETzEbc5vlAoPvLT9kmxjgHHAg5dVCh/WNKwxT0?=
 =?us-ascii?Q?WG+NofKrz0mjBTET8eeiiDWs5fd1fC7F5NtYBpN6G3dO9rkG9kyl5DBoMv6b?=
 =?us-ascii?Q?snBEzwM+jrj7ak3ey9TmzcCDBf9pnqUBLtyGBExSDqgY6tITJLa/04ZcA4DW?=
 =?us-ascii?Q?ox8Cen9C0w8nsYN9JuE45SYHklfTq7l0Lp7Pb0kf74CFYlDoL54LKSdJYK07?=
 =?us-ascii?Q?+yaItR5+2tLnKCJv8nhxa1nOmNw87OoF8ziGIeJIaF07eW+7TEYc0twXsp9N?=
 =?us-ascii?Q?bM+l+zg9ymjYiCUQSlHTDJbCjq+iqeoGDjUazBR6ejwqwrEppAvdsJoemtT4?=
 =?us-ascii?Q?y37VRIT4WyIM5kLvVSNdPKv6UM+115tQ+ObXHfgquKp2J6AjqUr5pJwMfPaV?=
 =?us-ascii?Q?SjgDUoemh2szzOpVny1ttb53CST1DM3GXgVdfpmG7iojqaEvow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:04.1940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467a95d8-97e2-422c-0d8b-08dc8673e185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis of the Upstream display driver code
(amd-staging-drm-next) flagged these three functions as
containing 'CONSTANT_EXPRESSION_RESULT' errors, i. e. the
conditionals are reduntant since their result is predetermined.

fixpt31_32.c:
The two flagged 'ASSERT' lines redundant since they are always true:
- LONG_MAX equals to the largest 'signed long long' number
- res.value is type 'signed long long',

So, the condition inside the 'ASSERTS's is always

link_dp_training.c:
The flagged conditional statement is always false:
- 'max_requested.FFE_PRESET.settings.level' is 4 bits, so its max
  possible value is 15
- 'DP_FFE_PRESET_MAX_LEVEL' equals to 15.

So, the conditional statement is always false and the wrapped code
never executes.

[HOW]
Removed lines flagged by Coverity analysis.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c        | 4 ----
 .../drm/amd/display/dc/link/protocols/link_dp_training.c  | 8 ++++++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 1726bdf89bae..506f82cd5cc6 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -140,8 +140,6 @@ struct fixed31_32 dc_fixpt_mul(struct fixed31_32 arg1, struct fixed31_32 arg2)
 
 	res.value = arg1_int * arg2_int;
 
-	ASSERT(res.value <= LONG_MAX);
-
 	res.value <<= FIXED31_32_BITS_PER_FRACTIONAL_PART;
 
 	tmp = arg1_int * arg2_fra;
@@ -185,8 +183,6 @@ struct fixed31_32 dc_fixpt_sqr(struct fixed31_32 arg)
 
 	res.value = arg_int * arg_int;
 
-	ASSERT(res.value <= LONG_MAX);
-
 	res.value <<= FIXED31_32_BITS_PER_FRACTIONAL_PART;
 
 	tmp = arg_int * arg_fra;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index a93dd83cd8c0..5a0f574056d4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -329,8 +329,12 @@ static void maximize_lane_settings(const struct link_training_settings *lt_setti
 
 	if (max_requested.PRE_EMPHASIS > PRE_EMPHASIS_MAX_LEVEL)
 		max_requested.PRE_EMPHASIS = PRE_EMPHASIS_MAX_LEVEL;
-	if (max_requested.FFE_PRESET.settings.level > DP_FFE_PRESET_MAX_LEVEL)
-		max_requested.FFE_PRESET.settings.level = DP_FFE_PRESET_MAX_LEVEL;
+
+	/* Note, we are not checking
+	 * if max_requested.FFE_PRESET.settings.level >  DP_FFE_PRESET_MAX_LEVEL,
+	 * since FFE_PRESET.settings.level is 4 bits and DP_FFE_PRESET_MAX_LEVEL equals 15,
+	 * so FFE_PRESET.settings.level will never be greater than 15.
+	 */
 
 	/* make sure the pre-emphasis matches the voltage swing*/
 	if (max_requested.PRE_EMPHASIS >
-- 
2.34.1

