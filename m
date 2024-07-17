Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CB6C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A7410E3BE;
	Wed, 17 Jul 2024 19:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HGH5rDeg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CAB10E3BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6IJGwpV+w7proo6snmuFDTlXr2s2IcNmxeFya+mDuBBVUu0/0jIN6u1DhOYgEOilpH7HpKNsUWSopj1vKBFXZq8nRsxdPkc7Y2QtUwpGnavrlq0tuhiTDaSHVZNFtiNxv3R0TnoGt6ezUxUUHi130PY1UDqM+1WOCLemt0NeK0LpTYwVQNJQNLbLJ9gN14AwF+adU2H1YAPo9TzaUjXQqeSszVvdESGNPSDsuMDAlDavFV+gUai0ZY/ci8em5IHNQw0r62t3WG25t7X8rRn3BvQXYxDIkREccx8vGH3LrrqZnUiZDbmO6lyc8XMHKO+/9f+38SpFxt8P/6j4SpIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAHHuktykEj+kK2Gv2bq4UZgFSdDkCuiHmwBrX2zRuk=;
 b=Loipo6F27e++6eLWK91VGDtOAyuyty48Vt/A2nV98yo61RPkX5eOecZN+P739ORmcKK9QiY/GB+kNhEPTaxi/HDzhkB//K3nNs/2U/i26Ya0p+jFA7CQjNPZv+QSfoUXjLt4VJ+0aiw/d0qUKG3qR6fyoHTj6LwpsXhsvo9utm3SYjslIH/s7TOqRLtgcrMAjqh3zuTiFMV39XdDhM6fNNwKqT/gyfab6Tas999iCjRylp+fD0Ef1ouxMS0Cw4YsX+bh7FIE74suAVOeljh27xYenBzVLhaTVeRZI72NIEZrRB5LvKBQkJPWtKzfoihKkLhR+R9aqbENhrGhijc71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAHHuktykEj+kK2Gv2bq4UZgFSdDkCuiHmwBrX2zRuk=;
 b=HGH5rDegT3gJTzxEBxMHXinwPeLcI2/0GdilkZGHTAeyG8TEeIfOeVOcJAFqDmOBRFpXrf89ub/nSCw/XOdQ39tHgUdt2IcwnsfjbW6c6mPK9EXDAoisBHFqEeH3BKs46akvhKvzEQrCZDmL7xp8v+rI506PInNGj9xyTDTlD9A=
Received: from BYAPR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:e0::21)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 19:41:08 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::2e) by BYAPR05CA0080.outlook.office365.com
 (2603:10b6:a03:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 19:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:41:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:06 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:41:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 17/22] drm/amd/display: Check link_res->hpo_dp_link_enc before
 using it
Date: Wed, 17 Jul 2024 19:38:56 +0000
Message-ID: <20240717193901.8821-18-aurabindo.pillai@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ae70a0-a38b-41e6-2d10-08dca698672f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ap22OVp+wgO0SYYOi6LTMZ/GIG+dObJiRlWzR0n6H9pBCej+Y1FeijOFqym8?=
 =?us-ascii?Q?gLZgmrHU+15IxzdmBfOOvaAcGp2GhAHKWWnDRrXy2XIg8F9VoksthIuv8bOP?=
 =?us-ascii?Q?deoorXnSPjDBe9iHCvX6dtHheT/wPGeFGJRFv+deHV/Q1MQdWAB8qL1QNh8o?=
 =?us-ascii?Q?c/n7ZbDJ2NGymKb9bDaIT2ltEiUy46axafyOLfA0hoI/nQ03+1deGjn5FRu/?=
 =?us-ascii?Q?ZVtZiXNW4p0r1H5wpC4p2k67gL0alHoQggRUKZmD4EF/ARATk+NBCUbi1s9N?=
 =?us-ascii?Q?8QM1k9kKs1BiTETVrFQG1x67CcMfQUYEbn6FyRP82xmOmwW5/j+FjLvAoWJv?=
 =?us-ascii?Q?B/3NJIUp+JCZoGdaldpC/TRF2SQD3n37Lt80OV/C3X2yDrwed9ub3wbUiiVe?=
 =?us-ascii?Q?RNfJspe6tvQ8znnQPdIovO7jZIMRf3fEwesXUaImuJlwtfhAG4Gb9eaE9ix1?=
 =?us-ascii?Q?okq/bE3qQLMxLSxyhJy4ifB+vgXAcT7s1Cqes2z32kucxOBx/5ZQOnVUBXeh?=
 =?us-ascii?Q?TvPlkwauNSQ/eBltgXPbjML3BpOokuCSL+yST+4o771bMBQuy6F2B8j02yJd?=
 =?us-ascii?Q?jCWfmrpdxhI/BC6BTrsd+T9RJGJ30/I1lCaLKkm4wGPdugTL4UR4yRgx351j?=
 =?us-ascii?Q?GpeTi+evMAiVEHt9pqz9WWZiY0tuw0kPDUCep9T5n6gAX7BYliCYzgWX22iL?=
 =?us-ascii?Q?Gh0aBKPLFhxoAgJuvQJFzqX3XnbkFU1CMB9pQjfpqAJoi712sO3XHAr6zBig?=
 =?us-ascii?Q?orSWUpb5VsLQy5tjNzvVLKuXYuSMUIbSgqXTQlOITNCJrTSvqJS2ptw4oVy6?=
 =?us-ascii?Q?W3+Z2hM23MJqdYnrNedvIig3zZKCymVpfs9m5kv1s71PmXlNyUAR2Tss+emV?=
 =?us-ascii?Q?pb23Of2y4VMj+3n9IIK1PVzuvsZn9cgFuCY7OkJxloTvYC+PMw9hbSwrAD9Z?=
 =?us-ascii?Q?TIEhzFP9buFGhNOzsOhimkQnSd6CQPfEW30olIQ5kyVDA6vrwN8/f952ToOB?=
 =?us-ascii?Q?sUdgetp2QGCcxaOP7JC2V1RMEqho6LMISigBP1vHFNUH0114nRN7oUNUdj5J?=
 =?us-ascii?Q?lUntKvhVLSn/SCifyajLiMyJUkQJeDcZUAQaxmNd1/7zcnVg38SK9cMG9LYk?=
 =?us-ascii?Q?GWH/fSo2j98xsykWosLldBc/tvEOiwbavbFT1LsDhRZt7EPCIe+P7I6R9P7d?=
 =?us-ascii?Q?jK7lHxTwHmHYZFNrk+5Lr7PIjPI+KfJPiR4/3ekxA3jiGYJWwC1pB+MUW7Qf?=
 =?us-ascii?Q?QZdA16/FEGObSxuRimA+5cgHGeALASnL/xZjEykfl7bb+CKx7lXX4A8IVY9T?=
 =?us-ascii?Q?9rsYr1aO5PpqshAof7G9B1197OOAIsEPWvUveeJ9i2I76MJoMYX+jP38WdPw?=
 =?us-ascii?Q?b6tzgEBqgY4n8ung4N+pMPipLrThq/4yPZYVke5P/FHXGAuL5rJq6N3bu77m?=
 =?us-ascii?Q?ItDpGyUeZvok+X++rvoIRc3VTJABT2U9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:07.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ae70a0-a38b-41e6-2d10-08dca698672f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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

[WHAT & HOW]
Functions dp_enable_link_phy and dp_disable_link_phy can pass link_res
without initializing hpo_dp_link_enc and it is necessary to check for
null before dereferencing.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Fixes: abdcd93214 ("drm/amd/display: Check link_res->hpo_dp_link_enc before using it")
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index d0148f10dfc0..cec68c5dba13 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -110,6 +110,11 @@ void enable_hpo_dp_link_output(struct dc_link *link,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings)
 {
+	if (!link_res->hpo_dp_link_enc) {
+		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
+		return;
+	}
+
 	if (link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating)
 		link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating(
 				link->dc->res_pool->dccg,
-- 
2.39.2

