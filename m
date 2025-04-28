Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2F8C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2A510E577;
	Mon, 28 Apr 2025 13:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gL/5FFuO";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED2C10E577
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdwCpkSdNRuZvMV8M9tt1NrDf7vRRhanW2exQrPau95RGe35b7dcd13SEIuin6E76IyxxW9gq6puCy/DZlV8/mdikwGPYTiSBlISVrfXQTWiBPVwvaKzRMZjcTSjm9ltBfXQ+BngMFsAvuVboiRzkGfhMfoddED6aDNRD4IhDcjO6IV78dyRo3xtJRk5r7a/mXHfKsYlHak3cd/70bid+TCQturuxIqfJENz2vb82+hCHGBtk0QSooRWKilZIVrkHnW8CCfxavJCWjiGBb5jVeY/8SAxFbec/b35L2km1V7YSjp3SCv9XB1E+9RxaC/BFH66JDtYhKkxf9EeePso2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2L91GQNvTCM865/T0ObMXjxqkkULpQNZGf5G0JjN5A=;
 b=ej6PTOQOtiUWROmN7S+rI20VT1i7WLT7JUrie6yZFL7P5s9dEuKYoqyCfXDFauxCDFhia1GaTwlPkBmNJH5ygwMbkroLpkxgDhdzFjY/mXZ8yVz4aZu0DMysonbh/XFLINWTCQNBNx9L68YxtA1SETFsThIoogT3is7aWOPpHAkq+yd+5IUMGTqLc1N8ZC+hI5P4SAMNPX57T0Pi+zd+4xllIfQlwz2Fy3zXw7tMAYkYPBv+Tkc12jthMz98TSn3CUGMN179R5oQBtrARDM7ZcPtzVpZVYJPJlZulBuH3Se+UgDoM/AhRSBNeVGKo6pryHN/6V+AGKmZjVAGWCWqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2L91GQNvTCM865/T0ObMXjxqkkULpQNZGf5G0JjN5A=;
 b=gL/5FFuOvnVSPHpSBtGZlb/otStM+RCYZ6/rvCsbWiaHt5GX8w3lLK9gn0fQ2JhNx7/W0Hi9thFWqcZok8RmVorCJttMk2novPJDSrBxQtUUZWXPo0ixa5b5tBhcnyQ1G4/rJHUvahuWMzoVAV2QDFsrsANvx2kGZHdc70qMde4=
Received: from CH0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:610:e6::26)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 13:57:53 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::5e) by CH0PR03CA0291.outlook.office365.com
 (2603:10b6:610:e6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.39 via Frontend Transport; Mon,
 28 Apr 2025 13:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:52 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:57:49 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>, "PeiChen
 Huang" <peichen.huang@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 27/28] drm/amd/display: Assign preferred stream encoder
 instance to dpia
Date: Mon, 28 Apr 2025 21:50:57 +0800
Message-ID: <20250428135514.20775-28-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: f7335078-a87d-4a8b-8850-08dd865cab98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Vh+Ln5dSJps6+Ggvt4L/xJOURTQ/O/ywVWltOCPy3oSpENSpHvQmB95d5Mp?=
 =?us-ascii?Q?ybkQwY4p5ipeSeHmW6iKUlmwlxlFLw+nXqmR9yDKXU2k0fKej2+gx310sk8Z?=
 =?us-ascii?Q?2KViStkHhwvxyYPTUv6q7ieOf1XR5ht5/qVXjzmaG07UqxxMdyCoO57bjutd?=
 =?us-ascii?Q?f1zMSqLo3vzGALLk7BF5qiNaXxq+yUWSciwGtss3cG3OaGEwOYXjWEjP6BC5?=
 =?us-ascii?Q?fdbudmZTRiavV4wToktvwrEbYNu4YPOkyCl4765Czo5Swu+1zuNQMtNF6eNQ?=
 =?us-ascii?Q?jDWE507vjs0ZxMFBXj5trc/ooKGy5ksKce4mT9eYPyzle0HC5cr2LaPT0//3?=
 =?us-ascii?Q?OcizK+m/UWpB0MY55nJk0Jr2+KG/hfBqmcXvgwYg9n5h9QVRf1C9Vnkgzyrn?=
 =?us-ascii?Q?z6Zpe7ocAAUCRUd5EeSG1zZER/+K9FfWE0kXDZEOwQkBV9Nt5cJPmb9uViyV?=
 =?us-ascii?Q?BOIUyI5/h1OsGgSLgnvEH9pWmNRzy0aJb+MozRwz+XKLzRiSM9C5s0DdB34o?=
 =?us-ascii?Q?OBwHKjn+cDlfOXtu0HX0Vn+6ZSGppLdxqTRAHltwhRROVAR2P61Ryw2CZ0EH?=
 =?us-ascii?Q?yfkrDkznD+JYYUmIWxpDdI1kxwIaCZMlenvrS0K6mJAu9aSJbN0GPFJ5ZHkk?=
 =?us-ascii?Q?aFloEx6iGbKbrjxbfVBNPaNW3gRyLJMXIcxPzUFo6WXYXVWNVebVappMgyJn?=
 =?us-ascii?Q?VWMpaSAgY3E1Z4GbohrOx3/CnvViz4KjE14iUAQZ+4t6v9luzDUgRU8uO5Bm?=
 =?us-ascii?Q?1rOYb1obEsxDhN/GIR4FYs3GTFN3qEgPt1YD3/eYpCNHsvTxieMQlAVpM32X?=
 =?us-ascii?Q?uSnCp0kY7X8Mb+4/kdfnH2TUSc33lItU20s/Afjj/PbmL6zvCENULa1N213w?=
 =?us-ascii?Q?R68eH7jj89PD1IiiAHnDRAglt6kJliOCMZuhUSAdsxrLTj3qU9RqheSb2vXr?=
 =?us-ascii?Q?51kB1PW+wXpMc89F0cTumNW5y1T6wygQc0c/WckYqPPAMwAYiR/0c+ZLfNH7?=
 =?us-ascii?Q?QMfbE8NZEBRdIJhWawhmsU985clOsPf8K59sl8d86xJ1VJclut3+skXRHpTw?=
 =?us-ascii?Q?rjKWEctPdU3ld7dw75tj6J2apAgtzR7mIsDo5KEaQLNBE37CPw0gkJ83FfFs?=
 =?us-ascii?Q?bqVd0a7oaJpuUnMEsq0JgrWQ7izumStbd5KwglXPGQtXBk6Ekock6gxiUJ02?=
 =?us-ascii?Q?QkC1ik8emiJAVQJNodykYc9Y+uCuPjsvueTRiULSLw4K2hWxxeW1nY60TDrb?=
 =?us-ascii?Q?I+TyB3qMAfJ3ZWwP/E9IUzquBNJmaDE4n0/GzWSlTObsoElzHcIDXp36LDcn?=
 =?us-ascii?Q?6rj/cyiGvz+3M3cdrzAxUWP4i5jvF0tPXzd8Q8EqSqRgWvGHM7pV66CGfv+Y?=
 =?us-ascii?Q?5o6V6G26SVG8oa22oMJ98DmDD8sLYiZ1KHVbbhA7XLzk80+G13CA0jq6sQ3G?=
 =?us-ascii?Q?U7HKnHEWDDAxi9enFvjfLIc/Wkrtog3XhGzrnDIwJXOPqn41bRFfCwAb1eTC?=
 =?us-ascii?Q?skHv5TTK729pYkEJB95mI8CVBFg28xuyL2xW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:52.9844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7335078-a87d-4a8b-8850-08dd865cab98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
For dpia, preferred engine instance availability is not checked
when assigning stream encoder instance.

[How]
Check for dpia preferred engine id and assign the same stream
encoder instance for the stream if available.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 9d8ecc6229d9..be4ade0853e9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -1246,6 +1246,10 @@ struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
 			if (link->ep_type == DISPLAY_ENDPOINT_PHY && pool->stream_enc[i]->id ==
 					link->link_enc->preferred_engine)
 				return pool->stream_enc[i];
+
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && pool->stream_enc[i]->id ==
+					link->dpia_preferred_eng_id)
+				return pool->stream_enc[i];
 		}
 	}
 
-- 
2.43.0

