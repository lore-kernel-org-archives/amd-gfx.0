Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F33CCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 06:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D676110E6B2;
	Wed, 22 Oct 2025 06:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YkMrQaZ7";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CEC10E6B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 06:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAiJjNcJwOMHMZboat29QC5VqTsJECu+qOrtquthU2NZo/9lXI6Z7eLpbzlVSbZj6IjG1nZSaCGXFCXB33mbO8FKVrZ0WhVoo2g1O9NZp8KTsgQwfrwnfpL8nDPqEUCoR/IdplplkJqetSn2s3Xxjwy90pVJQDn/1X9IPTma/2RiH+7m8HKALQ4Nopm7kPAvPFITa6eECjW1TuCEtJENKX16T5xHkkljPamPedtoR7IvtD7LoJxCeTz2nT/tCTx/U15HVwevZH3caB/yNhW/y/99LLJvBB6B+V1x5+5wo9orrTf6ft+7RBWzWEPXQGDM1AcunjG4YTQ6dpEGWmM5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6p8wje19I9g5HZcUiabwhOk2aaSEFf79crBOcF5dzc=;
 b=D4m8HQ7VyojIdln8Z89Q6VuZ8WaR7y4HfOG/4ZUJDCxyk6Sxm8EfquKHhab6XjDXe9sE+4GE8xedYWF8DsCFrqAtmr7mtWYNGneKAa3QJFhgtGIZyATdVOGgE+VKohYyZgFSKaU8UDkTo2vCZyKd53myn+RCGqDC5XCFP9EMlm/QXFqsgwVXfyfx/BNdmZcA8E+Q8IzwEFlqRlurLX033zDBxvBvQQwc6ex98HgqEnQ0wRYcFfAJE9kwbf6VU2xJ6kLxg5IbjvMMyhwj7DeYjIFhqaiEfv8n6PStAl6WDSTaUzGAp5q5gU3AXMkzKJMmdyT6UfTdBj7Y2dSBYb7zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6p8wje19I9g5HZcUiabwhOk2aaSEFf79crBOcF5dzc=;
 b=YkMrQaZ7Q8SLFOv3Y4g/Sgp0ubKXGbHriXetf36apEpfEShsF/r665SmEpMiCHsy55A6MEmjBDwNOesZdhhQjxYvrfM2TBOVE7iqzEziPOva+9ZJZgxlKSSzDEdzISz7EiROYsGTtgJ4lfaEiMFDJGS2S5za0urptASZglWQZK4=
Received: from BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::25)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:29:00 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::1c) by BLAP220CA0020.outlook.office365.com
 (2603:10b6:208:32c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 06:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 06:29:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 23:28:58 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu table id bound check issue in
 smu_cmn_update_table()
Date: Wed, 22 Oct 2025 14:28:48 +0800
Message-ID: <20251022062848.3526151-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db79b2b-4fac-4748-7ca5-08de11344964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L+/mO7E1iTLN6msmT6IEl9bgcE7tzIyprA75bvmWOfOxcsZNLse8IdQAitNV?=
 =?us-ascii?Q?PKsqYvWTHlJYnQ40aB0x2ipSekbP+Q5RAlImuY8XiPkLbqD3Z555iujHortP?=
 =?us-ascii?Q?bP9NvGs7pyOnrPUBpitiNHPiQRCX0fH/R2btBflNX9/rMWvEEZ2UyF2Dfrgr?=
 =?us-ascii?Q?hZBhEY0c6QwUxMLo56+6FFeHNMrU3ZgnY8tdd3OtUfvm9jx3N/pinQBIEZvM?=
 =?us-ascii?Q?aiaNtwv8pvg8laI4I1GMX3wVL0KkC2GxX8iGZG02uyfm5/tKzjnPDq/wGcUa?=
 =?us-ascii?Q?i7Zj5XMxIVR+q2OakLirFgpcW6PNgDnhgq5bqeCa0UsWq3zi397Z+6RKfxmI?=
 =?us-ascii?Q?OSV9eBBQDdJw3DVUdsk1iWDmgjSsJ4qLCzYj7IJwxuuPUinnYIYFWRKlRYSF?=
 =?us-ascii?Q?/uUbfTXCKFSuMr5oTy+GmUfSNidVZml2aMsbg8o7s5xyMVVzduewoRM5hl7q?=
 =?us-ascii?Q?kW5zpAl97UOzFmXrKcfmMNzyWB7iejrHqsK3rTQVvQa7khrDPHwHgZTt4Thq?=
 =?us-ascii?Q?K75kJpvF8iPIjk16HuxO/9IyA35oksnbjI1Niy2UeySAoAs+fNjASddHGiJJ?=
 =?us-ascii?Q?G0xkDJb2x1G/kG5BOsc3LwIp8Op+v2X6+g0FmMEVy8PgAm7U9tLcyiIBtx3V?=
 =?us-ascii?Q?VAwCJLt/zsS8Tx7rTQ0oQsnTFr7jTIucEwsX1k2uU4zij/NlHH3DlwxdSVY2?=
 =?us-ascii?Q?uJxS47WekQ/jc4j4v0xWHlaetmmUdNOBddKvnAj5b3REz8cokHOpbOJbIJjF?=
 =?us-ascii?Q?1Rf6Slaawvgc7J3cxBuvmqwCJeXwDnRjDKir8e+b+vLLIjKzRFQ09VsaTru8?=
 =?us-ascii?Q?QSisL29GA13BBcEimLb55OEWbSLjJhFSiYtF9saZMy/zySZFcbzCYVO+y99V?=
 =?us-ascii?Q?bK6MefhnJG2xQzKiJwNvsOKuJJ1yS3irXyOhpNXR4nSlMzQufsxN6yNoXdro?=
 =?us-ascii?Q?iqQ09ZpE1jELAeRUyE3oFu+YzKyVuuW5R2feHHrIyENtUi2KuRX8/wAS7a5h?=
 =?us-ascii?Q?8ccNdnvMwaXw66WnjcNIMVy9JYj+eefet9DJ7r+X/DRYGrQ4tlFI9NOaSXeS?=
 =?us-ascii?Q?JDuJypY3fwtlAnJTWTYnj3ZELcg63txoje7Lzj00rdljzQq0K6o/GYr5TREY?=
 =?us-ascii?Q?TsEp7JXmwtT1+7pyblbgyajMjVvcoZDxKDVvnyNAq0unGOwiMQIaTxyVAYzp?=
 =?us-ascii?Q?bzGn9iSOGGYgbJhJIP+hQV8En3ixp6/JH8dMuz5zXS6ubVLoUMfQ+mwZG9Lb?=
 =?us-ascii?Q?fmN2ggk02PG7OoPjIH5joJb6DXxAy2TKzibqDTKGULgCdScztR5qf6N/LphO?=
 =?us-ascii?Q?j9pwQT9QMvBi4veJ6yIvm/3rvZiCZhyfwbRw/tXbd9JzWgbZniHmq22W8eNo?=
 =?us-ascii?Q?4ZAmqf/mTtCucYWb4Z7CgWmsj4EBmoyOXaP07sDAoPCdfQT+/RhI9LVPa94h?=
 =?us-ascii?Q?n4VU0D/0zTAtcgQWpz2XHmSuE7Ze1NwNNhpabWEbSbJhGugWaw7rz/Na4KdG?=
 =?us-ascii?Q?84KJwMtUliwWmPa44sCP3gnCLI7p4pl/VMCCoGNqG++LSf7u+VK7XxkzdUDC?=
 =?us-ascii?Q?kCRRkgYPwrJVCz2exkA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:29:00.0034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db79b2b-4fac-4748-7ca5-08de11344964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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

'table_index' is a variable defined by the smu driver (kmd)
'table_id' is a variable defined by the hw smu (pmfw)

This code should use table_index as a bounds check.

Fixes: caad2613dc4bd ("drm/amd/powerplay: move table setting common code to smu_cmn.c")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f532f7c69259..a8961a8f5c42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -969,7 +969,7 @@ int smu_cmn_update_table(struct smu_context *smu,
 						      table_index);
 	uint32_t table_size;
 	int ret = 0;
-	if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
+	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
 		return -EINVAL;
 
 	table_size = smu_table->tables[table_index].size;
-- 
2.34.1

