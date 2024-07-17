Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8C7C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EBA10E3C1;
	Wed, 17 Jul 2024 19:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mfo4B6jd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809E310E3C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nf62XCggL5rqGOrj2jISP31R5zTtUhkJS09zQHPdHlLpmHFgbEhVUWSgduOatPKrsEoKYEyVzBEcniHK0YnhUL6JbtwaHd2uAxs6XD/wYKgHryAQ2phDwUuMOVqVMaVCNbJV8anq4wpeSrAp/HDdZIhfCQcgU28cHnD5bSREOx5Izw2uC0zB6QrrEKZBRKV2A5I9GbOHEc/8NHnSyuISz8cz/LJemUAoPAzuIYbNEdzglvkrpQL0rgZebeok8Mi8I/mUbh9MdCWJzQ/3hQWRZbTvRyTSR8AuxwUxubZeIjYgIOwvHJ1uaxFFnztqodvzqLAKz/YbNA9mshlapRUXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2z6rUmhZzT2ZX+gve4KZPndH6WqLA+Im5pgTXzcEeI=;
 b=GC7t/t2VekxIIJbkWPi1K3uNZA3iklq3kkBhtPe77TYAac4qQvHfW1vTe2Bie/cYA3pYfCd2CVZfpttEsp6ERzQcd1ECs/xn66k8pIZGD4cvDMqNw3+Woq9uJ6gunb6AaLwuyba1kTjWO2FQPpIiH+dAHY/simXf2vyNSU3erm+2YaTeKzIJc6ELbA1j8/N/9b6biO7R+O9gbgdI80vKR8Pwq0hFI0CUM0zsn4kUKpLMVdTMo/jVfGcfpXrIqxLETGK3CsmK9Jzdsajtpjjg8HCGAdCFKh7MJJr3WV6ngXqTCHz55WxwlIQn0e5S/W0mzJ1auxhgrFHermQ/xNIpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2z6rUmhZzT2ZX+gve4KZPndH6WqLA+Im5pgTXzcEeI=;
 b=Mfo4B6jdXBq5nHQL1b3YJEyhV8TYDiQ/yup6u/bdIhR8VdWPP+LyieLpv31gR52iL34Na704321RXfrk01BvKH07PuhH0bTIyql3DpFASz9b17A5pMtTQntbZpL1ALh+tdIkgXDqbalnCdyFBXK2YTi9gAoZi8l+odD+p9adJmo=
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:41:13 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::69) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 19:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:41:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:12 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:41:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 18/22] drm/amd/display: Remove old comments
Date: Wed, 17 Jul 2024 19:38:57 +0000
Message-ID: <20240717193901.8821-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c036c6-9ad1-47ec-f72f-08dca6986aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gRuappXSMqvsDaEDUiR3d4pnvSzmRQIcVxCP22Cso99zPC++5dAf7H3JWu9i?=
 =?us-ascii?Q?LyrByy7MiWpmXdaouvCIi0KzRj0YP8Z70PqgBfo7LIZ/n6uGvYu7Dg/d4Ukv?=
 =?us-ascii?Q?SF9f5d5UYu2rgs4Gu9nxK+h1YjdIC5R7I70FBJrQ1bPjPg+pJ55qkgvzV6Lr?=
 =?us-ascii?Q?a38BfVPM9VnkjPInvPZDvb7X/SLGrHqcMfKe/UfhIWe7DN03B32LlG+Vf8Rn?=
 =?us-ascii?Q?ID1Pb8RrJmJDTqrIvnrXxYQXg+p6Rb6NO7fiRKVd5TbbUkHqglFlwOEvQOxJ?=
 =?us-ascii?Q?MnA9JIDX+RimOp3iXojh/dUOzsg40upFXMuSWu6dmLgTGFuqN9C/INWgxEUi?=
 =?us-ascii?Q?9O6o/zKRYn2+y51lJKbPg5suvopwvkVHtngg4oSm2RQW3hX2Xr6yyMh6iNlV?=
 =?us-ascii?Q?FBTA47wfODlnxcjLdd8CszsU+1aUW8TvLMoSMOiAZlznilNZEVSc9pbKvPa/?=
 =?us-ascii?Q?a4ssudVAMtlEULvdHUynlyr4Nkpoq/lNtgG14NX4c1HIfuTHHLLx5IZZuLjA?=
 =?us-ascii?Q?UGnI12PJ352H/UMwUzqdPZ5DIuDNnfyZjZN1WVjdNE1chBdJHJUH+CdjKwqL?=
 =?us-ascii?Q?2Dcq6GKHohfowijAfsj8JuRz0cTHGtJlC4Qowhs8uGwCcH3K56DNOqyqmZeO?=
 =?us-ascii?Q?oC8TdkIPIB4qsJsRgV/GCZ+xq8dKKAdpE/UT4gviuYdqPA10+g68ojauntA0?=
 =?us-ascii?Q?2RDkguxD6m8LFYn+LFWBG8uw3Eke4QzdYDf+sKPfReYcGPS5J3dnOHCtFLpR?=
 =?us-ascii?Q?zjvCOnHQyeVyMTglKoptgZKNnEkr4KBZNt4RO8XKEhA1T+anvhZl+0KA33mw?=
 =?us-ascii?Q?kSsecArBgPcgLhVDHoXGIuNKreKvQ/a57hC8+M2HHHxGgVivytTwCSxh3po9?=
 =?us-ascii?Q?/oh07nh+MxDOq+tC1LRjn5BLYTyUuXUa4y41MSB0qrc8MzeYyRF1tC0/jzdG?=
 =?us-ascii?Q?UyqvKLm6oiFQ+ykc3piLkF7dbuCMhnU5d21r/9zuSt8LHnNUNtoOcCsFj9rg?=
 =?us-ascii?Q?JXAOFUs12mlYg6FkVM+14vw3K1DF7xg9LndS4lLh00s28wvcOnrpFemYIMpL?=
 =?us-ascii?Q?WXzDx6QI0maELpcE/uNjoBCc3B3Qsw74nxLW8Jr+wl1Ibw38G4hwY5QZN68V?=
 =?us-ascii?Q?qR8WlzAmnEohSS4KZmncumLCJMQ49jHcD4h5sgzCOWvh9WMdaN/2b+1TWFyy?=
 =?us-ascii?Q?hjtHaHDCHCzVhnMd91Ez/tUBGeRpoesQ45jiKa3mxnHwlImcuglFRcUOwtjP?=
 =?us-ascii?Q?hZWx0uuFYre/QgC3VE1k8AKwBVh19EqFq6scZ7KMpTesO2YbtyTFWO4rRYCp?=
 =?us-ascii?Q?LwXfWJYIbKY7aplcPI3LkPe+ftegHSjw8Zm/WYGDqhspq559gioO9ZJ3ziXz?=
 =?us-ascii?Q?DDVOq2UOW5zhEI/9N09mmvw8ihai2DFnuB5XtrnoUNYb1tJ3EEJchdWLWAVk?=
 =?us-ascii?Q?jEhcIk+iQoJFBEMlfnICyOimkukhHyY9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:13.7228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c036c6-9ad1-47ec-f72f-08dca6986aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Remove some old comments from DCN32/321.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 4cb0227bdd27..6f490d8d7038 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -160,8 +160,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 	.pct_ideal_sdp_bw_after_urgent = 90.0,
 	.pct_ideal_fabric_bw_after_urgent = 67.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 20.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0, // N/A, for now keep as is until DML implemented
-	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0, // N/A, for now keep as is until DML implemented
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0,
 	.pct_ideal_dram_bw_after_urgent_strobe = 67.0,
 	.max_avg_sdp_bw_use_normal_percent = 80.0,
 	.max_avg_fabric_bw_use_normal_percent = 60.0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 4297402bdab3..8839faf42207 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -139,8 +139,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.pct_ideal_sdp_bw_after_urgent = 90.0,
 	.pct_ideal_fabric_bw_after_urgent = 67.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 20.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0, // N/A, for now keep as is until DML implemented
-	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0, // N/A, for now keep as is until DML implemented
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0,
 	.pct_ideal_dram_bw_after_urgent_strobe = 67.0,
 	.max_avg_sdp_bw_use_normal_percent = 80.0,
 	.max_avg_fabric_bw_use_normal_percent = 60.0,
-- 
2.39.2

