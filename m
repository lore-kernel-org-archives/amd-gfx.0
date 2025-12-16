Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5C3D5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEC610E831;
	Tue, 16 Dec 2025 09:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSoNnrvr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F6810E831
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b96E752oOs4ehlaD4tFL+TmvGYut6Q9U/kFvncwtz2ceUVts1+LlxWot2gZr9YMi6yrMKI9JJFeYXzcKUBuKEUFJ+jZ9Mx1mrPmJ6M4I4U583cOt1xNdqHj2OcG3JAiJSfaW4UBdaQo76ygmtL4msKf008ZHE4EtnoSXZxibGrD2YLezfoIDW3RruBvEEtaSgjDdD16MKw4lM2D0dcWOHCJLJQNBcgvj2PsMPqKxXksKeH1OtXrDbHBGN5fZgVexA7QZZKe9pWmrQ4uWiP0HRknSEInU3CRdQSpQapKhREWZwraT/Zw4/X1ZG6ZDpZ7G8lRwjKfz4mxSYeUv0e+n0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzwwRKttOtc869IW4GC9eO3XB6R0jVCPwXo4RHcWaII=;
 b=RC+5m7r1h/+SMuG1aHIo4nWncdv5VXjWGu/qOUHApPIOApKFy38w/lT2vQC7XAhSphFpj2Y1/GldgWh5oNzCfErtOdffRVWxFxPYar8qYZSY2wYNd+SvE5GwhcVBuvLAW06nH2//IEZee9VLbMW8JR6pzdUvSp8RvHR0lIQJCcsa9iT4u93hBHKCQlNdSAEGsF0lIfE4XwDbUPIgoUcGlO+GilkUvezrd1p4SExZRCaNHFGuRO1e7bMER1D68eigIyQosE6cdDttiSg2q2s8TB7iG70rcBA2Sr2k6YSr3clxx/8Q8OW8c3MP3GnW3jtg9fSmv++GQip5uRb+8L5Beg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzwwRKttOtc869IW4GC9eO3XB6R0jVCPwXo4RHcWaII=;
 b=LSoNnrvrERTFKTSz1Tm6Ag6BL7EB1n/GFxxgdNAqakIRAZGSP6YHK9mYsQDdsu4ac8qaUgdthlTWIEUx3NGqc1F0a3p2TwxkDec37vlUFrMisxKprofUvSInoiL1pra3NYEvfi5Eb26TaBFF7CBhmzZTvWGh+FI2aN//U7FLUS4=
Received: from DM6PR02CA0094.namprd02.prod.outlook.com (2603:10b6:5:1f4::35)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:58:24 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:1f4:cafe::df) by DM6PR02CA0094.outlook.office365.com
 (2603:10b6:5:1f4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 09:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:58:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:23 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 01:58:23 -0800
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:58:20 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 15/16] drm/amd/display: Replace log macro for analog display
 detection
Date: Tue, 16 Dec 2025 17:56:15 +0800
Message-ID: <20251216095723.39018-16-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afe81ed-a3c5-4bd9-3540-08de3c89a703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/0GdjYTXUjHalfpv4FZ8a3cCBcUsDTLV1uRYDJJFZb6DeVpL0YS+Pqk37oUx?=
 =?us-ascii?Q?kGHYJ8eSBSvfLmYrBa/IWtT8glny2WoflOpxQdnvTLHO5mBOgdeYUXJENAbD?=
 =?us-ascii?Q?AiQguRWs07zmZILnSxVYxW21Yk0ndl0xhznNWt4Pr0y9Vvgc6V5sw8Y+nXZL?=
 =?us-ascii?Q?hfLZ/Uh9gWLRBpMBIQVGwkYZhA9OBZ1YnfMhUcb7cOtinKgmfBsvkQbsHu/Y?=
 =?us-ascii?Q?PbURCgWJr4EJZBmIPYx9HxK/tPrM3EHIpo+QPZwI4kUWRxDEKC8MBTGedTM0?=
 =?us-ascii?Q?LzuzlVwBn2EY32aqj6It/0bjcoLeR4ETPuFqOqkUlnwmbLcxJIez1UfsvJ0w?=
 =?us-ascii?Q?70bh6zhBveiz0YfHGB8meXatBHWJiEL3Op7hwMaTJNtcVgyVcX1GF4i8++T9?=
 =?us-ascii?Q?dELGgZX04L44CwUnhzzsoOwQyBBmH7Upw2cZ+wSyvd3GjkuNwmALAmmrYdCA?=
 =?us-ascii?Q?o9kcHqcaG9ZfwdVkIgqj7a+HbSf4IUCgdyu9YgBuFyXUwcgHAgswufE8oCiY?=
 =?us-ascii?Q?lst5Xc5o4C7076rVBM+NXmnfu/UA/PDw/KTcyk+/RGZDwvLnzYDVufLgfP15?=
 =?us-ascii?Q?MCDHcMFpycNXScSYfMxwFNtxAmRuHxCVBWgysbA3sX+Frfwdgby9rqcdSY9o?=
 =?us-ascii?Q?4k49LK/zGrRGGi6fyzEDcAqKRuemR94zHm8lm3vnr7aqkAVewYpeHFJA4cqj?=
 =?us-ascii?Q?koZy7efa1Gbw5dqcEz6UXqy9ABV7YAxQ0n2TFPiFzWdASWV8BPb8kjtH5Ciw?=
 =?us-ascii?Q?hyd5Ct2bpPGCIO4oRH5ATIeOf7VvalXh2/YclmVaNAY19oqi7uiiPEVMmlTm?=
 =?us-ascii?Q?xw2BUyF4ZO95I1ADOBLHr/vVEOORLPATdf0V+K/PoLqNYEfaoBBiDBlQySIg?=
 =?us-ascii?Q?9PpVA4rDW/si9porQx71BC6dFudrcqvA1tzrguMG3XoySlgJGxU0IykrwY6Z?=
 =?us-ascii?Q?V2T9dpbOLxmb8L94m+qSY9q2DcHFJ6wYiClBdHOHI0+ZUAdBMIyAJFAQFudD?=
 =?us-ascii?Q?I8whILbrVyzh8MNiiogw3fz0jRmACmXc6l5D10LWnT7W1JqITKo84d14dZyK?=
 =?us-ascii?Q?RQ8jI8CBKNydCWCVC0wzkA+z75sT9QwSG3x5aWXicUDn+S0okiBwMAuEXhCe?=
 =?us-ascii?Q?uHrg3SjRytDiGrDo0jSQdhdpE/njV6e5edqhcjIyt8C5jkfyr9i3XOQIUfXm?=
 =?us-ascii?Q?+SU2tcpa3qp8wDE2VLqdUj7X7tic5KJ4QjqtDbGR9kJQiaEvFZfo4RxhfeoK?=
 =?us-ascii?Q?Fz3hgktkNKI9g1CRKHMOwXiuZNOxGf7NTYuV7Riv9zNDHX/f9X8vbaUX8luc?=
 =?us-ascii?Q?h6/mskR1yIJOUAA6yu+F/B24xtS0OgKMIjDrP8GamOcZdRnLM3pvKjbaaSit?=
 =?us-ascii?Q?sMr1ebA8vbZN1udaoynb36eTeqoUwXWvbCyr0u0vwGSrN7bKSIgTx53CMcT6?=
 =?us-ascii?Q?C8ZzcQt+Dp2mUdBIZnH4r3+NMjGP2UAN5Gq+ZYZTKnIWs1HP2V5nrwKei8wV?=
 =?us-ascii?Q?JBW7UjqiCXQMTumNCdkpnRGpzzgiIygDUvYocdoa8usjS9scZwLs4GvC7Stq?=
 =?us-ascii?Q?FOnMLE5rMHdvf33ZEp8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:24.2855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afe81ed-a3c5-4bd9-3540-08de3c89a703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

link detection should use LINK_INFO() macro.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 56f27a6d2874..03db7116cf09 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1184,7 +1184,9 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 					return false;
 				}
 
-				DC_LOG_INFO("%s detected analog display without EDID\n", __func__);
+				LINK_INFO("link=%d, analog display detected without EDID\n",
+					   link->link_index);
+
 				link->type = dc_connection_analog_load;
 				sink->edid_caps.analog = true;
 				break;
-- 
2.43.0

