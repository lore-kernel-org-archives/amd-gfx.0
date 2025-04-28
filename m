Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761FBC369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEA210E529;
	Mon, 28 Apr 2025 13:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPGMmNA9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8EC10E529
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szfnLZePM6hA1C7oNYxB9YdSI3QMtZ4EB/57ILtEjlOWdG2kXGeFMXzwHilqKTlmoqcxi/oVq4AqnVDMFOPYHoQDf1yZDtF3EGgHaI9OgVvd5H6IFTGASbWyo+NpU0o2DKvcd/Iox6lCcCHpyCCyltfeaDLwKRjYjvzNA+cFUFDc/X8WdP90th5Yo+0K41wH+85QMT+lrrqbWb8d7x/OTQWHbVCpcmCWCGN6tpcVoaToUAkgqetwfz/9IFEUFBROgj1p7C+Y2R1IzH2o5o4LBCYCKAQtlY8Sdjy7xayTayo7AnyclTq7sYxP17IOMuukNTdCZAAwiOA7HqmtjRIdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkvkcTmTVEXM0vQgrfOgq+ovzuyp/PuginhcFQ6Qmvo=;
 b=JQqaJy5URxLn0DxmCZCVUMacTgSMf5N6a0F5AP4m8jA/FqiwUv5po1b/VRDv5URP+BQ32YbMxRBBa5xx6AEUcqLiwpSZEzeUQ81gDN7c8/ajvGFrJPcaXHGOyk+Sqlsisu/Pyp52e6Nez2qhnOAUy3xtw9jY4k4YMNn8Jt64r/ia2uFJEa3yYr3IqLrxR6GX2bP3OhycRzUUTK+rZAzqWcI3Iy3cRR2bsnnyOYJlAC37HT56t75btO9WqmSrpWWfZCoGrPYbAoThTJAJAmxTlgjr+Ap77vqxnf9FDAG6lITuvwEzkfBQYdygl5+6t3CX5COpZYRMwlrGzNiFvi/GMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkvkcTmTVEXM0vQgrfOgq+ovzuyp/PuginhcFQ6Qmvo=;
 b=TPGMmNA9jkrc0xwdpQMiCIek9jyh0QqMJfRcjull0N1NKeTa2snfEnXqjKlPnsGRHAvaJa7PcLvr96xW9i5rTKT3xe/Zc25+ngJI395T63RQjxv9t6Xv2wkDjP8rnQb0QSyOO+8umO/Ab2QCMlX8tkvWbRmqS7iU91JeCJHwgAM=
Received: from CH0PR03CA0358.namprd03.prod.outlook.com (2603:10b6:610:11a::20)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 13:55:48 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::df) by CH0PR03CA0358.outlook.office365.com
 (2603:10b6:610:11a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 13:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:55:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:47 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:55:43 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>,
 Bhuvanachandra Pinninti <bpinnint@amd.com>, Mounika Adhuri
 <Mounika.Adhuri@amd.com>, Martin Leung <martin.leung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 02/28] drm/amd/display: Refactoring DSC enum dsc_bits_per_comp.
Date: Mon, 28 Apr 2025 21:50:32 +0800
Message-ID: <20250428135514.20775-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c81f101-8206-4208-b592-08dd865c6107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GYogiGZb2iLSK14TvwtHI91KZK1Dc48ABxoLxeXZEhDZWLVNV1wMjhYYzfeR?=
 =?us-ascii?Q?JvCAIwuFHtpXxXB4EWLDDlr2rx+DFh0QtDPCFtHZ0Qzz1SDR+BnRzUh3HiLJ?=
 =?us-ascii?Q?Gx5VbZA23QEa7tnqOpVMiNv+t25HSic66NMdAZnzdOzAjPipFjAZfCb15liH?=
 =?us-ascii?Q?gqin4OPG06kOr6TSonTbsZsiZuhPWkD6gd0yeDPQaQYXcf9h1+tYAV5nv+W3?=
 =?us-ascii?Q?IWwICyvx0y+ekOUTLMgXIO7uDykhRzJBiEjocTeAtkS1/gAgi4oSoJrZGYC2?=
 =?us-ascii?Q?LzG18L+4mf71reQzVk0zuLupA9Peic3gM28iKROijaT/Z53HD7niXRrRzv6x?=
 =?us-ascii?Q?YGRqaSdvJzrbCerMBvyKeoytV9gCK0Cjqom80nhlL6S9+aDxCp8yv4yuJysb?=
 =?us-ascii?Q?1PuGJe15y+qvSbIoI9a4SKl5K6gDdJPpmeAPcpecUL8h8hlbHAM4q/g87qNa?=
 =?us-ascii?Q?XScSFSn4PXiwfxKx1z0haIeNdc8PmNhlCAJgjmzlnS5hP/TPuN1qvKkujYrn?=
 =?us-ascii?Q?ZNx46nGYzwVwRvj/XQt4Xg+KPa4qxvaeO7/dR2be+0bI18GGkaRSJMEbz2/r?=
 =?us-ascii?Q?hicheypNgXCl8SO9vG3vp7u/1AAsGeQrBW2pk5IZOGPc+i2L4VEhvY55G/l0?=
 =?us-ascii?Q?phM/8SewFOIVr4z5vnJs3NaaxB5KYYpTv+hzpWD7LayumhztfE+gRby/JQOm?=
 =?us-ascii?Q?mNZwCrlqBIUcpwD1FJdwH26JGf0Y8lQN3zOWdzz506oHRMxaxnF/61tdO1MM?=
 =?us-ascii?Q?Jw1tvxB2BuWsITJi9wvpqM2q2igLACMBGWzC+WmSz1fuf1PFZefHy4hjCVju?=
 =?us-ascii?Q?T587k7vdp6u4jMGyFCIVLSwgZrUQqgRJZfhR5XaJKukTEYgTzQoWbn3D1Uo3?=
 =?us-ascii?Q?Svdebb3Vs8X8JYZNQNzWNZghqjmzCHYXhnXMB5Xmo6BP9AXJIJqkCEDnO2kx?=
 =?us-ascii?Q?ZDJZmLzm9KItP9bPYXvF0pzi9RrKn6CQjiadD6skgwAfkC00gbXzPze80WRU?=
 =?us-ascii?Q?5H1P4SPT19ns5syCc8BFVCjm59EzjVw39vltQ+rbGCoRbQQL6FyViUnG3u6h?=
 =?us-ascii?Q?LMqZbk16ULiWl7BSTPI4NTLdV/dpbXYdQmwTeuTgzYwSnkJWgEb/AjDE0Emr?=
 =?us-ascii?Q?gWgoE9968JrFsgB3fLb+ePTxPN7/R1gDwSFs4xqbcOWAj+y/zo8icSS666GL?=
 =?us-ascii?Q?5fwS0Bt+HljIw/HSGCn2BYfUZlFJ/qOVeNDQ8I6FeKfZf5efGntN4j31Abbo?=
 =?us-ascii?Q?bJYrwyU3cn1y01N3VriKq7vPAY+JzWKYDYbmF5iuCusiB22CHKpRQLB+PI7g?=
 =?us-ascii?Q?3J+eO8KCHg5j9kSjgg0bwObx7BfqQDMn/xjbBVmNdvVCOtbWD2nQdVkIfU++?=
 =?us-ascii?Q?ecg+Da7x/NzJaPlKFibZCG+/u1EvDfQQ3BZMwEVljA4MBQwSy/p6fcEGWQ68?=
 =?us-ascii?Q?5Lse6QCiTqCyHdq3rytEpe55OYlHM4COxhT/yoBrAr4iEEy9gvWxgmbOKgMf?=
 =?us-ascii?Q?t24NErhTm3RB/DRnDAHWT7ACCNXKv6r2j4gK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:55:47.8839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c81f101-8206-4208-b592-08dd865c6107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[Why]
Previously the 'dsc_bits_per_comp' enumeration was defined in individual
.c files, making it unavailable for other files that may need it.

[How]
The 'dsc_bits_per_comp' enumeration has been relocated to a common header
file.

Reviewed-by: Mounika Adhuri <Mounika.Adhuri@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   | 7 -------
 drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h   | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c | 6 ------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 75128fd34306..bd1b9aef6d5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -57,13 +57,6 @@ static const struct dsc_funcs dcn20_dsc_funcs = {
 #define DC_LOGGER \
 	dsc->ctx->logger
 
-enum dsc_bits_per_comp {
-	DSC_BPC_8 = 8,
-	DSC_BPC_10 = 10,
-	DSC_BPC_12 = 12,
-	DSC_BPC_UNKNOWN
-};
-
 /* API functions (external or via structure->function_pointer) */
 
 void dsc2_construct(struct dcn20_dsc *dsc,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
index 1fb90b52b814..a9c04fc95bd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
@@ -457,6 +457,12 @@
 	type DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING; \
 	type DSCRM_DSC_FORWARD_EN_STATUS
 
+enum dsc_bits_per_comp {
+	DSC_BPC_8 = 8,
+	DSC_BPC_10 = 10,
+	DSC_BPC_12 = 12,
+	DSC_BPC_UNKNOWN
+};
 
 struct dcn20_dsc_registers {
 	uint32_t DSC_TOP_CONTROL;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 4893b793fec0..4222679fd4c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -45,12 +45,6 @@ static const struct dsc_funcs dcn401_dsc_funcs = {
 #define DC_LOGGER \
 	dsc->ctx->logger
 
-enum dsc_bits_per_comp {
-	DSC_BPC_8 = 8,
-	DSC_BPC_10 = 10,
-	DSC_BPC_12 = 12,
-	DSC_BPC_UNKNOWN
-};
 
 /* API functions (external or via structure->function_pointer) */
 
-- 
2.43.0

