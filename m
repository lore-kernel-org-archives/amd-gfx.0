Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8367DD3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149E210E4D0;
	Tue,  9 Dec 2025 08:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F4Z6iMfl";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F1610E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=el/KVM8WAEwhJs+aQKbbimIddsa0vt5geK3Oyw4ej79m8Jhz1yhe0WvOP855LO1GJXVBhOUMmRE1pr4HasSFj7rJMTqqxElxmnG7Wlaqox4WwN9oZei3gQSYAnFQp2NF5DNXdUFFHxzxv2ZIKKwrVB89LshO9A+L4Tgr3wN2WjAwTpbiLBgz3UCsnIazU+UjueGg02BlcoINupYqVeIAuwvblZ+v20fDWA69/VbpnR4yxNqdTFlECfclihP7FXuTLkW3IvtjgBOjEQiHu3QTKAgbBGvvl+jgmT8sZmDzFEVf9WLgwxkNvK8jo3vxSHyuhGL4X4oZdiAG+MlDKWJezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMocYMJX5tRUnC7fXqPUvec4Lh4gpXsvutYJrb0eJdU=;
 b=s3zrT98NQyKAo9BARBqye4+ew0/3owCZLayK2Def58B5+Lf/JRZaDYxLBqGIzhhjONZ83X+yv8V55LEVhCFk8voo518vOl6IhgcO8QJC5jUPSAuk9p82Ifiew1eNtTkZA3rLGcqTZQapMT8HGJ2HdTUaZZQIOW2KgH9dYQsOxufBdaAmM2603W3y6n0eHbn12fdgXSO5fKJRVdggqzHmlVQHdcLcGvxOupaZioDxEFH/TfToqsRQqcBO2BQdlhFkT2z+yr66SrCq3irBvHcI7+Ccfqk0bOIF2YZd7fmCGDojcyUrQpnXuaCL8nOyRyzpgQeG9ITLR2wT0RhMV0Q1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMocYMJX5tRUnC7fXqPUvec4Lh4gpXsvutYJrb0eJdU=;
 b=F4Z6iMflo+hM9R6fZ+AxKb1rDLs3Fl+Scqoy+j9MCZc6LSoy+mn0evp4OokUvMFvfK2drykrDvWaEE8QC40eNeLg+YxC1VNXj9McrPuOgredFRPx267vGBmIZjWQtfutH+crGNI2/5Wn2U4PiIAO+N2y3lwobOBc1GHKY6xgjmU=
Received: from SN6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:805:66::46)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.13; Tue, 9 Dec 2025 08:58:05 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::38) by SN6PR08CA0033.outlook.office365.com
 (2603:10b6:805:66::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:03 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:55 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, hewitt <LinCheng.Ku@amd.com>, PeiChen Huang
 <peichen.huang@amd.com>, LinCheng Ku <lincheng.ku@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 07/15] drm/amd/display: Add USB-C DP Alt Mode lane limitation
 in DCN32
Date: Tue, 9 Dec 2025 16:55:10 +0800
Message-ID: <20251209085702.293682-8-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: d3afc06e-8410-4a80-af04-08de37011082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A6C2AuP4DJRQebblRoQ90BNs0n7oJredSwmoHohmz15UrAxL9KqRCzqYsKU0?=
 =?us-ascii?Q?XJ0CeXvnwJZfb1hv5PXo9bGZ9w3JRnF9CCBPFBvNQeGQVSe5+MaN42Mxb/no?=
 =?us-ascii?Q?NVzpBi6chBg9fXJSb2t1SsWzwGalxUFHq7oN8Cvnoj2dqvlKshs6pCF1wvJM?=
 =?us-ascii?Q?hj7WoDEkhyNdG9kF+t7GuIkcVAimbJu8Ro/sJJGevxElDNc9EkfSwtrwZfKQ?=
 =?us-ascii?Q?LFh86Hd/ryftQ5zhfHndIS+QfR72p8hXxqZmqDGpyGKEBwcQxQbT8703AKLl?=
 =?us-ascii?Q?QpunIfSVaAo5vIRMQ0ZdD5bSuiUb77WP+Z1mgmXgdAirM/9hCsBw902XQ/Nw?=
 =?us-ascii?Q?YRiolRVYlDU5Bxw6D+59kHY/u0Kk46QW8CspZGfZZeGpQYa8CohNWhjCwXgR?=
 =?us-ascii?Q?uZP+xH/5WCwI1+fylh6xVrFrWMF9xUBapCvZ7Esz/CB5XPtn9ErH6DGj5fGL?=
 =?us-ascii?Q?NXzjlgCoBCoLK3m9sR6n8dtsnu4ildbE6Y9ZYdQnqcJL5d3EBQ/nrEcuAsUx?=
 =?us-ascii?Q?2BLNvArEmRptlGTHuMPzspMsPpy00eGAS1+ERDRDltqPtVV9VWpcPRPMmpbX?=
 =?us-ascii?Q?isJFu3kh20VWiMhatkYJZqACU4tmKKnYn0gW3XzgQXlXoaOtb1xnxnk1aGRg?=
 =?us-ascii?Q?CaXbu7RXRXMJZiv7t65iLuQd68F9roAIXWBySRYKqmI6BmrzuSWc2Jrxc0CL?=
 =?us-ascii?Q?Ry3q+qvbBbhG7A38uA87R9GqJAcsYxKCDEs4aguVTrTfwCwUx/lDVpfLb/Hd?=
 =?us-ascii?Q?TLk6aDgEJ8ixi5ILFNHiH13EBaqJUqKbExVkmyRxx1pdaNo4VSeOvGB/dNmS?=
 =?us-ascii?Q?tMdqG0u3mTo9Vr8VLrmTQZbuMeJYAc5YtLfXXfMggjwSaX2KG2KBZqnuZkPj?=
 =?us-ascii?Q?yf+qTeRR1Y2Cl/tHS6jUFnXXPhLjhbZj0vsrBIyqwKMkx6kEg+cAQhG47eK4?=
 =?us-ascii?Q?RfNkq33NaeJzDPJEDHnV93mtqxELA18q83ejPqpr4A0EdB/d7brhIsHDqJW7?=
 =?us-ascii?Q?P0Com8dbs+4cuxHoX0C02SBbz39Vo14CtaDN+4+pDyusyccCf/lGZ9TQ4fHF?=
 =?us-ascii?Q?W2DbOaJNiyG5DSkmUS0G3UJYLNHYoel28++4ZPWm2crY+6zRATGTDs2hRoss?=
 =?us-ascii?Q?+ksTsAdx5lgDr4Xt4jZo11Tz0KoXUKSykU1fLK9XHWJe2G5l0ieo4Cpb5Vkp?=
 =?us-ascii?Q?I1SfQ4pgWjffJzSrV7OzL/ujRKbiegHk/TbM37HrmS1+9uF0JiQ30uRKA1x6?=
 =?us-ascii?Q?6djcHatvzlQTGguwyW8OGF+KAzQolmWIK+0zjYM5to1WoFALQYkQmrn+MNFp?=
 =?us-ascii?Q?NdnNRRtnhdpFX+/eB+3w8Ht6ubcODt+aHL17YkHnN5zrJpJvPvtM2sMu664D?=
 =?us-ascii?Q?n3p3THF89W+wuTwrL4ZXWhKdGFC+9fc7y+OTthPdUuV3XREYkokwBtP3iL8H?=
 =?us-ascii?Q?W6MOdgtuf9iyb5XXwNBavc9VF7YrE9F2maxNyz4jT6qBnhiemVSrZ+PdBHzm?=
 =?us-ascii?Q?MlCqndxS9iIuZasFmF8ov/JcNtRNMI9m0N020Qqp5t77z1M4PBL9DAAjyX6f?=
 =?us-ascii?Q?mYrLSg1DE6O6oO/BuQw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:04.4073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3afc06e-8410-4a80-af04-08de37011082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

From: hewitt <LinCheng.Ku@amd.com>

[Why]
USB-C DisplayPort Alt Mode with concurrent USB data needs lane count
limitation to prevent incorrect 4-lane DP configuration when only 2 lanes
are available due to hardware lane sharing between DP and USB3.

[How]
Query DMUB for Alt Mode status (is_dp_alt_disable, is_usb, is_dp4) in
dcn32_link_encoder_get_max_link_cap() and cap DP to 2 lanes when USB is
active on USB-C port. Added inline documentation explaining the USB-C
lane sharing constraint.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Signed-off-by: LinCheng Ku <lincheng.ku@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/dc/dio/dcn32/dcn32_dio_link_encoder.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
index 44a4e3c4efb9..65d28cb07b04 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
@@ -188,9 +188,18 @@ void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	if (!query_dp_alt_from_dmub(enc, &cmd))
 		return;
 
-	if (cmd.query_dp_alt.data.is_usb &&
-			cmd.query_dp_alt.data.is_dp4 == 0)
-		link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
+	/*
+	 * USB-C DisplayPort Alt Mode lane count limitation logic:
+	 * When USB and DP share the same USB-C connector, hardware must allocate
+	 * some lanes for USB data, limiting DP to maximum 2 lanes instead of 4.
+	 * This ensures USB functionality remains available while DP is active.
+	 */
+	if (cmd.query_dp_alt.data.is_dp_alt_disable == 0 &&
+		cmd.query_dp_alt.data.is_usb &&
+		cmd.query_dp_alt.data.is_dp4 == 0) {
+		link_settings->lane_count =
+			MIN(LANE_COUNT_TWO, link_settings->lane_count);
+	}
 }
 
 
-- 
2.43.0

