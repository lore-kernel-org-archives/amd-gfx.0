Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D9AC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13EB10EAB9;
	Fri, 21 Feb 2025 15:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KvX2h1DB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0299110EAA6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4IohahZo0gQcwBv/hq5VV3XRboUdEqxVni3uzQKJf1azp6gh9RIxnUNEKC4qVz2lj2fHyjfdT3u1WbukS35zuJimaX69XZTPuKmLPhRXd0u1CCc+LiRuOrCM9XCNjgA+GLCefZg8awF33KAd03A9VDz2c+zKPRWN938Jdt9MUvQGBhwMZQz24yCJWZVSQDE5uH4mPijSt4X/yBVDHQiX0FfQbw8scnm7T6tzTfya7UORb4EYMx1H1lZu3OBg4JX0or+cNYCvlUY9g6gNI15sXGDosMW8VHM7xsH91C4Zq46Ri7qQIO6C18+QJw8dhe4jKuT0Ki9H+qSB8ZcOIjGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu2NRjYx9y6uo5lKV0++H7EH6NjE7yALKnxVhwz0cCg=;
 b=JBLv5Yp2kamVSrzyGKLmHQNpff4bpceWm86f8ZXUgZA++TDUquk9AgqTGhqcGOuosj0/mBaakKlKm4cySzZCosvqZXXznsLLm9cznfkKqk3zKLBWdWZ0SUwdnz67JRfdXIveicinfaYCf6S5D5lsWRGp07yZfrEO1MbgcUPdT0653eAsRh/nq1N5CkcX2yT7/sk5QFKemrBKsD+iKnSMFndoq6XhWDKhsT65WGYPcfnZGAtuae719x1z1m/B7b+sA48gl2M84lu2dP+o30wgQ7v/otRotcm5QAQyV3eqKqewsP9xZGpl1U3R22ZHQbWLHKYXSnMtwqTpNVdHjZNseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu2NRjYx9y6uo5lKV0++H7EH6NjE7yALKnxVhwz0cCg=;
 b=KvX2h1DBpkxX5zPLfUVHxqgMtbqTZakwuAbaFBnXZrji4ZLDl0vOEk97BPj7vqH/a0m2nn/lNLtgxZfc9dzXEvITleD7NA+RVynXasNySzjq1BcKlw8vxX2so1nA3qfgeBzOHme+EZhDwD+gKJLQYP/cq/U4v5RuKdPCTSs7aPM=
Received: from MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Fri, 21 Feb
 2025 15:43:46 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::f6) by MW4PR04CA0092.outlook.office365.com
 (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:45 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:41 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Assadian, Navid" <navid.assadian@amd.com>, "Joshua
 Aberback" <joshua.aberback@amd.com>
Subject: [PATCH 07/24] drm/amd/display: Fix mismatch type comparison
Date: Fri, 21 Feb 2025 10:42:55 -0500
Message-ID: <20250221154312.1720736-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ea263c-b334-42e6-bc9b-08dd528e86e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xWPgJW3BJsf19z52Jm+2y9X3j4+OPkaE3gWaoBMmFUlpKrEidntapyBezzXa?=
 =?us-ascii?Q?Ff40DG1UZhlOQbKxfnH2ptOEcqvvC25TaaFb8DRbjMfbDZDENjhZ774FKvpJ?=
 =?us-ascii?Q?atIrbPLyMkO6IjOA0svA1YYjv8tAjFDF9zn7s2lt6EySqW7PW3aiE1f4yJ1L?=
 =?us-ascii?Q?v6p1FkUGWovEFx3aBBCHEalu9+i/0Uzz0DgLYbtt6KQWvVPWI+d9WLvh3T0s?=
 =?us-ascii?Q?ZwpVSN6BGAqWql7SGMR1sXoo+oSW8SpXc7qpSibytkvkf5QBW8+/jOMAw2V+?=
 =?us-ascii?Q?9TRrexy2ZUVXijCsKQ+ijgsces2fO4cwmOwcAKOj9LNG0xGGu9bWOZBBUog/?=
 =?us-ascii?Q?chtr3rigmOI5xXAV6nlb9L/yuu1dQ28M5OKt6vC2qx8PnD3UGf0QEFjXJRzs?=
 =?us-ascii?Q?CN3uvwEEnlo6G6ZiZaBe98dDSBuuAgEE+J07xAK70OBoWwdaCF9/kbv3NY1v?=
 =?us-ascii?Q?0rmmLN9DHCY2JlJUYwry2NK+1IczGuF/8zuJvlObIgr/DJQNADoa7pLGBoO8?=
 =?us-ascii?Q?OHp0ltmYoQXfZgigTmXAVgJQXshJr8a4vziBKngKZHH6FUDQvVmw+o1Znpkj?=
 =?us-ascii?Q?zi+ItHR0BWpLhXbsK/Fe5wO6UlO5pHu3gy4YU3kQEtiewJN5e4KfKIP5fWc2?=
 =?us-ascii?Q?8n+napU3eXoBlM4c86xcHjg7p4tQXoAEctlsxpQBoduWlIcZKE8DkCDpI8La?=
 =?us-ascii?Q?I0r8b0p9J6ksxir15O6eRVdz7XZ1Yeztr2DsY6xpzzK83LFzxGB2ykf9uqZC?=
 =?us-ascii?Q?hdLrytDEnppjlG02BbpG80nIVThm8fe+1hEW7w0ZLIyndezOy6VCKtpH71CB?=
 =?us-ascii?Q?HgPhP74mu95J9hnY4hM6gazyayzD65y8GegIuEA+wj5QUiVA4K9enfrPbFrZ?=
 =?us-ascii?Q?5oGWOpPhLWwK5DHHK1cNe6Y5jV34nULwo7fAO4jfDYL7XimzL8Dm28eS6rdE?=
 =?us-ascii?Q?Dcr6O4mLhCZXTF4pOy9E6ko1cHIl4McWcSU9wVOa2DlRvFWEL4m0voWiA9mF?=
 =?us-ascii?Q?5qsC7vD20QIxCdsIEa910OtVbNBbI6prhvZ754G4BZRWiga0qy9WyD1fscfx?=
 =?us-ascii?Q?+BM6CpmzA4QEfCT+/XNl61ckkdtUMvK2a6/aFPzLmzEGYYR0rAv6rd2jbaMl?=
 =?us-ascii?Q?NPOsXQx5b0SwjVdyhFcjydOujpL7O7v4tUgZA4m6mxYuHAEduXseLQXkcbJb?=
 =?us-ascii?Q?cM5UJ9gqiwMUaVuR76tRIO95b7G8m+kR8WJQ+qF98411D3rj5XJiJt5Ygq/U?=
 =?us-ascii?Q?HQ7EOK2YCtzmHcrcgmXx+00tNilIfo3TdwaijSkOnjPMj2JoY4PkZu6kdRUG?=
 =?us-ascii?Q?PtceS8gYsZJEaP/vMUNPKUcvoDVT0g54/lxm4LaqieUkmBijtzqRe9LeiXvl?=
 =?us-ascii?Q?fIymotQw1eh4K/ICIhTRt/HEWwuhoVJ4oLslbuVPmXUtpHztCe830Ro5lG4n?=
 =?us-ascii?Q?1NE02R+13UtkqZ1Tojs3XECEVEOr6/h01fX0H/LXiuS27GnPi74f5g37ax3r?=
 =?us-ascii?Q?dRnnFpVd+2aOW/o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:45.7018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ea263c-b334-42e6-bc9b-08dd528e86e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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

From: "Assadian, Navid" <navid.assadian@amd.com>

The mismatch type comparison/assignment may cause data loss. Since the
values are always non-negative, it is safe to use unsigned variables to
resolve the mismatch.

Signed-off-by: Navid Assadian <navid.assadian@amd.com>
Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 72a79288ab79..3d85732cc0f5 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -944,8 +944,8 @@ static bool spl_get_optimal_number_of_taps(
 	  bool *enable_isharp)
 {
 	int num_part_y, num_part_c;
-	int max_taps_y, max_taps_c;
-	int min_taps_y, min_taps_c;
+	unsigned int max_taps_y, max_taps_c;
+	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf = false;
 	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 0130673ceee6..1c3949b24611 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -493,7 +493,7 @@ struct spl_sharpness_range {
 };
 struct adaptive_sharpness {
 	bool enable;
-	int sharpness_level;
+	unsigned int sharpness_level;
 	struct spl_sharpness_range sharpness_range;
 };
 enum linear_light_scaling	{	// convert it in translation logic
-- 
2.34.1

