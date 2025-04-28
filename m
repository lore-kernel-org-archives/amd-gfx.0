Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75951C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF15310E566;
	Mon, 28 Apr 2025 13:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FUn79Ux4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DE910E561
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPWNAIE7OpA0uzLoxYWH4n1ZHq5hfjzjSLBQet0C6am5rwO7sjGBwr3sZXi0GgL6wcJMYxpW8fGoCqzVkw/fSPAiXKOottBGkAb3sTVWcO6Rm1CiAqMnbwGMItsx0NIAF4Gona9NUT7Nxhzn3hBCQxUYGexILWZD+mG/UK4wFeFHFJpycPVQHUjuQJ5943g3juUBNYOTE5UA0+J4CsSCSbkdhN9U13mfc67m5YKOIh9ND7LA5rIiR3wum0PemjhibRZDghYdhugjoerUyHP96xpGDqwqmLfJtwfnEVFv4brtSHvwFDK6aipFor5LXt0jz5umKMJE5j9I5HLtQtRW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp7w71cQCBNBSFxDDyhL7LtdpqnvHHLKgPz2Gry/RKU=;
 b=aCWM7bLrr5GrHr9zL0jV2bBEK9u9Ix/1PCawEtHuaS3ldwWICRou5S6tW3pRTCkewh0D2kAbTL244zxxn6zsGCGOMgFDb9GI+gPlFzHTp7spfCMtB8S+itSvZk0OMYjQjofWtlM+4OKE+QsjZIwEFRQzadDfQW4IjWmcrjZJPIL3hC3oiHFfyhQHY4Ey/eb+zxn0r7iQPbmbENuLQU1OmyEBJtWC84zDwiKK+wcI4UstXTZxpx8fFib3aUDwsYaIef2nzZUqh8FpMTgjaGmOJXGOi5OumPUH5StmUlkyFQNW4G0gqMkmX1aypMLdGojaRAjPNhGmxW4eWCFQp0Ns/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp7w71cQCBNBSFxDDyhL7LtdpqnvHHLKgPz2Gry/RKU=;
 b=FUn79Ux4cUly8VED+JWoUxwIymI1jRblMkH4ZDzX+SfElStMtFYSuEtidA7MHKceQAVqsgvlMEIY6hXJuitDKZx35/F/6NHeeBTf3hqZiuMnqkghR1m2HRp9JiUdUTADJFgyzWOgLg6q7a2O4OpS6/FvMrV0KdzKNbaXQd2xZGo=
Received: from BL1PR13CA0108.namprd13.prod.outlook.com (2603:10b6:208:2b9::23)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 13:56:36 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::ab) by BL1PR13CA0108.outlook.office365.com
 (2603:10b6:208:2b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.13 via Frontend Transport; Mon,
 28 Apr 2025 13:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:34 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:31 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 12/28] drm/amd/display: [FW Promotion] Release 0.1.8.0
Date: Mon, 28 Apr 2025 21:50:42 +0800
Message-ID: <20250428135514.20775-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d44555-5135-40a8-2df4-08dd865c7d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j5HXtuQHFvpyR6QZJjds4gOthfjjj3HfnQilNzy3TUsvc2lRsfYm6iAnYSSE?=
 =?us-ascii?Q?MnDq6xGbWuYRT+m+ya3zKtAsBWzzNbviSCU5ABiydaI45xxXY0xzqHG6aWbu?=
 =?us-ascii?Q?uxFDSnPSA1O+p9+Jl8MNfJH4ysYIOVadFPj+ErUtq/QV+GR6Yu1laOg6E1ak?=
 =?us-ascii?Q?ILOHQWL1TnR1MAeqx0oIf053kY8H19ePDkwojbGx/jSzzSfI8T3JDf3m7la0?=
 =?us-ascii?Q?+kjY2XmW6cQtX8iVi3BDMpctbvZSTFXQXSdudWL2IFqPaPlZL04aEz/6EdwO?=
 =?us-ascii?Q?Wm8Jb1YGgWLrCMl380dZBfEDUPgNu4vLY2oYFbncUQAOcsFhIgff2iPK0V7y?=
 =?us-ascii?Q?S4Pf8Hi/HM27Ib0e3bFnLvxXdtSmzVPa+7a/84CYKqvfL80WkWDcXIoyIRt6?=
 =?us-ascii?Q?IYpjg8MHDnOCarylqty7gG0bsiGu/lktkIcufsAHAKLUW/TjdZ6fsNkdBbWP?=
 =?us-ascii?Q?r1z5tgIMCwaUopUu99r8i+IollCAaPJaUCAVTMhUKs5+hCGKj8kf15XPbUNg?=
 =?us-ascii?Q?ixRtQ9AV5XkBFYmW1sV7Gggt2q7tXWeWOOVfPD/CsxTvBQJ1KzFmBWKwJEXq?=
 =?us-ascii?Q?lYB08OCYaXnBgEZW8zmrzfBKVm9ch5fvTIDL2UUiJr522SigoOyUgOOh78Zj?=
 =?us-ascii?Q?oe0ZDGRQnzfWXgjFy+ycgIPlCgwr8pBucIk0cWnZBU7BVsdSb5U5tg3hHz+r?=
 =?us-ascii?Q?XCJ3lMfrI48ti5ZPA1B9YPX+jdajtd2b4Wrk+8xpa9+YEiRGXrsFVMDHamfs?=
 =?us-ascii?Q?PpQz/UO6WuaBtTwBxImFRWNttHr0NWQAHg2GWp0SAJlvncsDEDSYrgF0ObDW?=
 =?us-ascii?Q?uTtzeUp7xrep8C6oUZzsdPYexDizJYzWf1k4OvAU8zxk09RVX4w0f2plAPMV?=
 =?us-ascii?Q?rQY1R6skfcQZLpuWSjIuGzPhh6ccQdizBvniRO8dkWI2PWb4TKtzUVXPtlPU?=
 =?us-ascii?Q?FQY+VELc0FU1NN7lPHJRdFVACV0DpRJ6jGg2GWd1/QWECA7YPPA8UlRxkjW9?=
 =?us-ascii?Q?KrrdbT9RwsyiSvFf73Z85XsY9icD14QfA3XFmK54AMzGrmqoVKntNd6DUb/1?=
 =?us-ascii?Q?HLs3lV5F6edYFG2m1gpkIHKVqolPqERzS9yNaNdt2v2XTFnMkXAiAQnlGtyg?=
 =?us-ascii?Q?ekWSp+1E3sbsc9f6LBEOYKCt9i8dGRBekmAwnbIXJdf6uGJBVeDS5UUpfhN/?=
 =?us-ascii?Q?3pHwLqtCSEP/ItyPl6nrxnwSBlnHbv8P+iJ1Whlmx18TJ9RSkg1kw6U4beUD?=
 =?us-ascii?Q?xxoBsEMxatE9YrlJf+EJ8SPyTkjyXdaDB69z8JTAMN5WnQIudgXX2NAPa9JN?=
 =?us-ascii?Q?al1N9ht5kb9pXtFOq2frvtnFLStzlPU0pkXTrM4XEDOTO4j4HUSDcVH3vjpU?=
 =?us-ascii?Q?L6uzc6thQ2MZELF+alcheK5HaTyf1waJXRyGis4vwNApTCjLmIQuDMYbC1ls?=
 =?us-ascii?Q?sYyO41BIkDdSZF0FDO/BcSbMPqJwbq/TE8tNQ2t3VHe/yXfva9pWE7+Abeoz?=
 =?us-ascii?Q?/0QSrIPexqBjBxT+XxMcRInBfqSUDnQeFoX/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:35.2311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d44555-5135-40a8-2df4-08dd865c7d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Undefined unnecessary definition to avoid wrong referring

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3ae31449983a..76e9dcc15466 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,6 +36,9 @@
 //<DMUB_TYPES>==================================================================
 /* Basic type definitions. */
 
+#ifdef __forceinline
+#undef __forceinline
+#endif
 #define __forceinline inline
 
 /**
-- 
2.43.0

