Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA9BC3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1538D10E738;
	Wed,  7 May 2025 02:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qPOe458w";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A0A10E738
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TucRf5xh2WURU0C86t2e90W2OcGjk30Q/RMtEBZXVNzr3oBubfQKzw37wu9qYa5dOcdeiftocP15UTRxmj/mO8CCz4p55+1+GpLfTSnCw0GpE6dxQstEe/sUPZ6ct8G5/KkK0Z7g0D2Lw655pGLHQIScxX/RsxQ211MMEyLzzTXhQ9AQq1SD5mRNg1/d74NShBzuabtyFyf20QpuorJEt5uDhtfpjwJyv1HtNAfLs2HK8TcCkD9hcuwvVos948PXrmjfLxvzSk0ALFagcoWRMXu+oOr0kO96KszLo1zAZUd9YLIPPST/W4P0Zv5Ms4OtxurWum/v+p0IX9+wD6HrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FupULx2bWVzEFRNsvCaVQR3gqv0oMdbAE0gy0eylR+U=;
 b=MlOF13g3t6YdT0y40Ch8DW061ZqYMWkUSDT5J57TGimrMWYUolL+PtXHZV0FUpHQfU9KJAwlQXHyZP9D54SaVN+WlVC5wWzcNnGyZXty7bfcHPGNrKrvuny3MwQ+cpZZ1ofSPCAC3vcV2mkfJ2wqS5PjOaDMdKFQor79LU0cc/cX5lIeChPLhIVgCXHKqRMomWSV8la6tSIYGHeGNMujT31bnYVN1Gdhv3X8UvR2MftYBSAKo2VsvGNyYTZMykbf4otpqZdwKWZ6tbJJPXlO0UXJwggic6p+O/1wsTagXGi49UguI9ClnAUilxjFt2RP8OrG7ekvl/rjLsNT7AWTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FupULx2bWVzEFRNsvCaVQR3gqv0oMdbAE0gy0eylR+U=;
 b=qPOe458wLIxHKNBEF82FLJr5XVaLHgtfJfBnIB3Hi8eOkArz7D5L6AJeHpEUX9yasTqfHK9EXqg1Nql/ip0YIqRcTd3M1CIwZl1MiorkfvliskzmIorT0CrQF/QPAkj1RVOPL5XFw+HhSQT1VyBexkdXvfH59HyksvzkTH7oLOU=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 7 May
 2025 02:43:31 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::de) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Wed,
 7 May 2025 02:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:28 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:24 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Gabe Teeger
 <Gabe.Teeger@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 "Ray Wu" <ray.wu@amd.com>
Subject: [PATCH 04/14] Revert: "drm/amd/display: Enable urgent latency
 adjustment on DCN35"
Date: Wed, 7 May 2025 10:34:48 +0800
Message-ID: <20250507024242.1928299-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: ed14df32-4ba0-4367-cce5-08dd8d10f458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|30052699003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M26sB2tgLpVRhvpxdeJjxzHYox5cdeTR+wXzZ8LiUgwZn5ZPYbi4uAtP2WGr?=
 =?us-ascii?Q?1ULxHcbZbH+FV2B9fz05DTS1/TJMIHCWMRd/GDvD/0Cw/X/4mN9KkdilbEPT?=
 =?us-ascii?Q?LXhM1RXMxrsoyBZD+dHJhn4ca3y8An0DSVHESrfrivoBlMftdTN4ESoXlBRb?=
 =?us-ascii?Q?qS+T/Zj+Iyef0LefnMftsoiu8YqcaEA9V1fxz7NnAet1OPoKHexw637HnpbU?=
 =?us-ascii?Q?z24p7FPqvlCANo41Xd7XbySrs4D2AkhNfp4DWVljfX6BC4m0fjleO2VXEUNX?=
 =?us-ascii?Q?P1+I6tqCacY59yg5+Lgn9YelxfhFwM1BR7iruwgYgjMnXG0+CZ0ynuHwj7pi?=
 =?us-ascii?Q?T2HNjOyRL3LpcpIEQsQOKDfJZKm+/1YTTajqkSuHTnI9nKHRf1prxzZdACyW?=
 =?us-ascii?Q?mr2m1vKmiqjUPPV9+SoBSgKK+atAHyU7DLqm21tXgvw9TfNW9WFy2S+TDkd9?=
 =?us-ascii?Q?K/Ytqjn7vRlnH81OTq5w7EJLKxF68XI0ZwGSkAwJGRlTy+ijF7mpAxwWd7Jx?=
 =?us-ascii?Q?UgKrijLMiQSJoPmHPSnGM6rBFT7yzDCGmvZaJdiormcC2BPipx7ZUJZEqm4+?=
 =?us-ascii?Q?QTSKegxDZd+e4fu19CX0J/il8Tluk35j8oqyiF0ONLdtSsQ59lhmLwUyDGZT?=
 =?us-ascii?Q?BYepHjyKSTx/f74NqvneTYl9OfYrnIf/RnFvw5oIT95muev43dOepmDnFpcl?=
 =?us-ascii?Q?XVRkBEt9wy8ZhaNkUUl0tR4igm9BYXSz3caFxslUVgdsUY3o3R56sY3Tvg4F?=
 =?us-ascii?Q?hpI+Vd1KI9fZBKjbqtX+AWNpIWnAMr/x/Wmue/5+El52dj9envLd6JvK7v7d?=
 =?us-ascii?Q?Iq8WLrHb+U74PesQmaug5bEoA+ksZ1x6/3wHPtDElQHIX2NGsuOnzOFy6XBv?=
 =?us-ascii?Q?cYFMvwgPFmojfNOxN3PW3pBZhjMGDgjzUG7YWYvomaucd8rB82Zylfff+6r9?=
 =?us-ascii?Q?oPdVYHqP6mbzbhYAQlpt7qJqOa74faH8Sr8cRo1QHTeOndVtig63oXF5pHnx?=
 =?us-ascii?Q?aO5K7IRQhaKClK35JMddFUFN6ODul6yRtCS3S43inPs7jOYdeP0H226Q5RY/?=
 =?us-ascii?Q?BHRZkR8wmJsYvPHWN/dMkWzKsGvTXVr6Nl8R2XC8pm7fuhQq18wH255mxD0V?=
 =?us-ascii?Q?AT4ckz6DYG5suPOXsA/k+NmdI1RoMwJPXIDkdQkLBezhZBYmEPnLwjsUeXSO?=
 =?us-ascii?Q?zG9LLZ6iXMpJPPSyib31N3IcDv25G+QTRqU2/yJ65+3wicbgo4ZelJVJc6sk?=
 =?us-ascii?Q?f3uM/ycZAsbutIpSD4xduaHuH95Nv488W649G0VnlqF4ABMWbgBzQC7xh87a?=
 =?us-ascii?Q?zofchBfK1W7GpdZs7R8EYc6/+Utwag/ECOWKY34ettrVKdF0OhzZWzOEEP3u?=
 =?us-ascii?Q?b+RO8Enj74HirQ/OKXfLgok6VbNQC3LzMro8+bzkfZXSNxzAaztkc2gwXSOj?=
 =?us-ascii?Q?q8fjTz02uszJwFMYgq2uesbmoimR9l+ovHEq1jR5OwR7WFWO1xaiYLYlFldl?=
 =?us-ascii?Q?1ZhLZTSt1erKghL4xiIkTwkxxIXA2bFxd+Av?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(30052699003)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:31.3031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed14df32-4ba0-4367-cce5-08dd8d10f458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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

From: Gabe Teeger <Gabe.Teeger@amd.com>

This reverts commit 2b2e690fcb12("drm/amd/display: Enable urgent latency adjustment on DCN35")

Reason for revert: Negative power impact.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Gabe Teeger <Gabe.Teeger@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index d9159ca55412..92f0a099d089 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -195,9 +195,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.dcn_downspread_percent = 0.5,
 	.gpuvm_min_page_size_bytes = 4096,
 	.hostvm_min_page_size_bytes = 4096,
-	.do_urgent_latency_adjustment = 1,
+	.do_urgent_latency_adjustment = 0,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 };
 
 void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
-- 
2.43.0

