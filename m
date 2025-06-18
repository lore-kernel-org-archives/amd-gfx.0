Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D09C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B850310E8D1;
	Wed, 18 Jun 2025 15:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LMV/ApdQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CB510E8D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtgsh8u8paLSJHZ+DXG0SWZsn+CHLDqf//n10S1/DkjWibKgke+lOPKrpnLEAp+5mwlzCM+S0vIYliwaayrAQYLDzD1L2NOqTkD+89iebL5TqVYG2Wc7Sh1c9xWPCkoK7J3C3Ld62G6sHxM/tgTpWxsTLuKPp85uCarZn3hgIg8vV0VBxbUX+cl4rn8FEaXXQIetXE/pB2MUaGC4x2889RRpvW2mII8Oi2TyO7SB45I5J2dQ+lUHg7o47Blr9WIS81I5p2L8txrVUveKYV4S+YpVfWoIvh7MIj+YhdGOpN3fJbiEzbKy1aYbF68Y0mX5iDAxHpr3t4scOHcBBzNCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmdPMOiGfC40+zhak8pICfCLogHiosQOHGHoRSjq/nI=;
 b=i0m60mz+JA3wyyhqSRwbdbBQjL5lBPLlFvPKZpaB8KygaFcwmrvmh24MkqcTTHjUB4bBckcHwgcxrQZt9x03bK4HUHD596GSkH553dilf5mBJAC+y+tCG6iBN0wNszMw8g6LKdbKn4kt6B07mOUZpiTXC1qOJqMcypoDoVqofrPA9/PfEXm+RxOn6bnC7BYwkEVuHNVEGniZ4gDFbKopJHLvldWQ6D6izFVUPy3DIvcYmnLB5ZO817TEMK+yePamewgyamzBu7kv/ZnXki5wt+WypRY+exnhAurAG3pF0LCUU0dp44MTXVfdE6HZnmDDCJwJdsS6aStrSi6QLzVPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmdPMOiGfC40+zhak8pICfCLogHiosQOHGHoRSjq/nI=;
 b=LMV/ApdQCAcSiX8f/uH+ZPDeF1P9gVEU57d4rHHSPtL+F9Hcrj9CA97Rx+CWMr/ojWsyAHs+FD1k3ewP0RcEH9ooRNFzLSL9FkcHvlcv1DN60uAIaQo1dyJOnexx02yBmp78kSr4rqU9CRYhMKCNcykzCHFmygN52V9PuVNUcg8=
Received: from BN0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:141::19)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 15:55:17 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::67) by BN0PR07CA0013.outlook.office365.com
 (2603:10b6:408:141::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 18 Jun 2025 15:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:55:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:55:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:55:01 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:55:01 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 12/13] drm/amd/display: [FW Promotion] Release 0.1.16.0
Date: Wed, 18 Jun 2025 11:34:00 -0400
Message-ID: <20250618153936.6472-13-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ea1706-7d1f-4182-4f4d-08ddae808566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?paPWwKNhwIueTDy2AEhuF3K5Tk2+Tx6dcydA9HgeCuyT3lH0um2VnXrsXeqS?=
 =?us-ascii?Q?Mx0SZnB2u1qQSDwspaGeeRV27lW5c8sU4687DuP4iIY0j89JR9ubQ8jQZbPY?=
 =?us-ascii?Q?FKizfO3fNAWeC7TwV98objdrmv+6R1okuS+BcH9B+LZsGQiaFydKzqzP8Eov?=
 =?us-ascii?Q?KM8OMPSHbpszQ/96RqAI/X4ofLPPlFkr1dxg8f4tzhgHBJ3hpVPkKgxQLfPJ?=
 =?us-ascii?Q?HF5wnNt5xSI0ul8QvXK+2ndqI4WCUs/snrIiwR1cV8Wfru1iFKs4ey4arce8?=
 =?us-ascii?Q?2Czdj/a0MrFeECiTSh0PxbV5zWvmLM7ezHmsFlUv64hTt9hti2IDcKo89ZkG?=
 =?us-ascii?Q?9TZID+M5Ikm3rc3qy+N+1vQ4M6fmdoaGBvcApomsU5YOZkyK75N1d417EVJ2?=
 =?us-ascii?Q?HIEbEmhYb+tKZvsUnUhHm4lL5YtPa4Zi0CTSbq0wNasnjlOgKOVdRMhPBOa0?=
 =?us-ascii?Q?Z+6HvqJWbF5g1m2IOBE4mKrYQDf4Ztrb+WP0aSJH9noxsl9coEmKs/ZvVfQb?=
 =?us-ascii?Q?RTd8/0Cj101HXdj/+wZ3PzIfsdBpucCai7r3PYh5Lf7UmWRyG7AFpANnCUrn?=
 =?us-ascii?Q?78ToNazPSyD8pkQr6R55sy8DGy2PQhqqkOCLXsU49lUOyTGOvAkpL5irfuMC?=
 =?us-ascii?Q?SywqfcjNhNk/21sAd/cMoWh1/K/QHwh2zOlH6wTgLSVpzvfqrytFl3PGm8ab?=
 =?us-ascii?Q?oiMk0xNWpVVVz02WQQoizVYeeC1F9i8R25zCikEZF+urGW0B1rACh/F32FlE?=
 =?us-ascii?Q?nVCcIhAW91iM9QWbxtP4wFtCbRM08d5ELrVDa3aAZjBhxy8BH5L35E7/3jvJ?=
 =?us-ascii?Q?dwzlwqN8tPR3u4SqpN8ROKB/DGE7PzQsMuPf4s28CNqNcOk73mjLPyp2NRmp?=
 =?us-ascii?Q?2rTUMEqsSnr2l8mliuoPtHTvzyWTo1Jdtxom3OSz2Q4XKp5PwgnEB1vW7AEz?=
 =?us-ascii?Q?1wVIEcw/EHlkO1yQSksTAXBEBVYol+VqQ9StrUWM4ek127yZDNomdM2jGsSA?=
 =?us-ascii?Q?c9Lek+EfUkWrtE650rq+PbYNl7Ea7KXoNj/Mwu7W+CDlOSs+oTEhEuGt7bbx?=
 =?us-ascii?Q?U/7tx8JY+qm9qL5m/cD4tklP+O1eZBPRmz1pStV+vOXXziYPZu9C4R1L0+Vx?=
 =?us-ascii?Q?rbUEpM14iJlxdAb5zokONu+SiL/mJsl74UQBfpKGhvEsmYDnGvRfVEKzN4dr?=
 =?us-ascii?Q?SyhbyUyQ5SaTShYlfMGv1YUCGf/E6U0uRYEl09TCUtO6nXNjoOIU2DKvxdgL?=
 =?us-ascii?Q?2mZdXcme3FhDjJzUHdcPtutT1IoPrFh0oGo2pWfZLq/yutFMo5bwUG4o2ZdN?=
 =?us-ascii?Q?0GBKXVzbKHVsTNLBclOWtaUK2VFagLjVW27Cs89aMBvjCpgKe96o/00pFzkL?=
 =?us-ascii?Q?hCwiqTgsdLw2ErMpMXC490U/FIrsL///Un4lrSdJlWhb/leCijStlB7qrfvV?=
 =?us-ascii?Q?UC7AMbNUCwMEgei4A71yT8RUu6przAEX4kNc0LsJqAorPg9WDFKokR1O2QuZ?=
 =?us-ascii?Q?4wY4DRwfkE46CjGh+FuAPsS1DPlZvPexDLKY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:55:17.3166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ea1706-7d1f-4182-4f4d-08ddae808566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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

Summary for changes in firmware:

* Add DMCUB IPS commands and command parser support
* use OTG count to disable interrupts
* Fix dmub_cmd header data boundary issue
* remove the HW register override

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e6730e59d987..93f35ac7f5b9 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -5909,6 +5909,9 @@ struct dmub_rb_cmd_ips_residency_cntl {
 	struct dmub_cmd_ips_residency_cntl_data cntl_data;
 };
 
+/**
+ * Data passed from FW to driver in a DMUB_CMD__IPS_QUERY_RESIDENCY_INFO command.
+ */
 struct dmub_cmd_ips_query_residency_info_data {
 	union dmub_addr dest;
 	uint32_t size;
-- 
2.43.0

