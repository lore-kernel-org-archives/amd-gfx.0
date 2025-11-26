Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B463D111B6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4615910E739;
	Wed, 26 Nov 2025 23:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MYIf6ivN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004FF10E736
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDfdmIjpJX/g1lK2aB6IsIUzlnAmK98ZWk1i7/no9x1Y0vbAb0BDM1KKnUei0vUIbZ2FpqMi5V53XSRfWg3StVPp7ZFrW/lGBikY7RWSz8NMVvWbdK04F/MiGA1bfjLgsn1ezX75TtpMc5Z/1vLkV6UvW2mnfSU+mx+ncAFviIkUPMQhRmw5F7fGIu0mcptaaYleiip7fYlCv3UOttYKMZa8CYfoLLikFHRnuW7m8XmADcyrj/c6Tsl8+4qYyRhPCDtPfhVIKiC4U2Mk/bvGrXG63goh70jJGQ9kYFBW/3BOPInvE54nsO3UfFRdqHYIg4hH9dZSSvQtO8T1i0SoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aESvlOvInjegKnv6LOfYYQ31U4oatGYCGyghwzkaiiA=;
 b=lckRjpI5iuqSraxlekuAwRgrIcEcrifb+srI9UP22JaiG7vz+yfQX+uD5qyEFn3R5RDsEh4lbO6gwPAvcYtszAsVS6TWUZlnh+gk5+UMmvOlA+lv1MxZeB2T9R2GvJt8ZZzCoUYHLrslR82hP17g2bEIwyTBUzMOpYag57eYS4DdxeseY30iKcQZHMW30Imf38gqRiAF5Ay8EoUz0VUJtga9Xwrp8aOOYdH3lX2mf4lUSSoin0tKWnHDpA1XEzkA7UThbHg0COWY1UDe30TS5PhEYHQr6TPgryayc6YczBENBKGd1R6wPEkZ9sAxqeqkv4U/m5S4w/7HZ5ZaZCyskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aESvlOvInjegKnv6LOfYYQ31U4oatGYCGyghwzkaiiA=;
 b=MYIf6ivNjeFz3LTWJqw9pY2W5x85IT4NOeRwnKLm0aE/Xpnciy47pKsbJZbp+qQCCMvQ744dKLAXD+L4pJyzYizC1AAdOLXZrUdacHbNsW3LepNSS2o0zfPiA6nwtfO7KSacnugmaGx+L7AM9y3+oTPuDm9dfjHZQ+pEBgN1kKM=
Received: from BL1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::31)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 23:06:38 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::5a) by BL1P222CA0026.outlook.office365.com
 (2603:10b6:208:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 23:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:36 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:06:35 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:35 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ian Chen <ian.chen@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 04/14] drm/amd/display: fix Smart Power OLED not working after
 S4
Date: Wed, 26 Nov 2025 18:06:04 -0500
Message-ID: <20251126230614.13409-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b60f42-f456-41b6-8136-08de2d40741c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NdDplBXYObijr0uj1mJMH59MXKUm5PF6TK8bNW7HfOUMGXqnSloEh8Qgl7nj?=
 =?us-ascii?Q?P6+JYHBX6mAw2eiKYIY/LL0RB1jjbxtYXGspfjEA5RK2mGaE/DsjWvZ4YSak?=
 =?us-ascii?Q?10M6gcGaG4sasQeaXtlUGXhBH0ptlZULmURjmOuRIskSWnJ2FVhjnr/KOtiz?=
 =?us-ascii?Q?bCVsSGoF1vxwVWEyY9vBrWMDHHsIFyQ/F+/WDh2CS+bA7xEdpWSc5q1yFyCI?=
 =?us-ascii?Q?mel2Iic7xAG4ECpo8EThEiG3Ej1LzeG8Xz9Tk1JN2jeTpqpQ6tkhn46++uiB?=
 =?us-ascii?Q?EeE/itI5XvCuAzmlFYZsI9Vf/TTQ0IZB5t4OYsmYUW1v6TsFsk0epasgox7m?=
 =?us-ascii?Q?Y/UAqHTMpRNG6+KIUGDkKFB8w4jv11R0Gr0PfF7aCYQ8VmugPPWKZIzzP79Q?=
 =?us-ascii?Q?xwWCgM2BFkwQMZWdMeC8DopSnWvyX1fkG/9y1fV/edhsWOKVSEjlk1rBkSX9?=
 =?us-ascii?Q?CJKcNoRb2atuswAB3WfyccoqxDuZVFuB879VGjkSI4DrQ3O//e4ZyDFuq70r?=
 =?us-ascii?Q?MWDJlaNTodJm6dvi06I5J0GZkX/3Qfsa8r+XITB07zt0lkIxmwBgeqi2SLZA?=
 =?us-ascii?Q?zY80qRwJb7kr8SKwTjyLLuDC9xf7BGpmUbk/OpitDvGYCrYn7dU1TCPojPVG?=
 =?us-ascii?Q?wOL6IDJ85MfbXlfuNuPYMaq3Q1uadhWadjZcIrNC0+Rtd7GI8QhQvEOvfyQe?=
 =?us-ascii?Q?kkseLptKp/LoInQEj9kucJHN5YpGmC/+Uc9l1cUVUyk4SNG+ReXlb6SQ0IZW?=
 =?us-ascii?Q?l/ki5peQ8lPLOdaXPjvkEPfEQt4FN2BJc8CePYrXhsMVAr+GVjRJG0edEcMa?=
 =?us-ascii?Q?Rg/35xZCDvJuigxqlsq3S6k37Uvz9j0gJ/v/B1CZxW43WmNESKbINaAoXdBm?=
 =?us-ascii?Q?WKNraAsmpVoNjJNxWoQeemNodGc2PTo1r1FrG+7lvYqkFI+5R3nlTsoVdzFP?=
 =?us-ascii?Q?JeH4oPXrzmjm5ZpJgMSWsRP7MbjB2rvH63iTWoOoYLkvLbVa7UxIJXGcQXBW?=
 =?us-ascii?Q?6dmN88VE9s86zY5Q3Gy8OnfUF3BZW2ipFL/7/6BwBwD3qFyGF38HhqHwrKbQ?=
 =?us-ascii?Q?38g6EJ3Ze9GA9i/PKdTM5nQuc/oUrirn5FlJMqSOXM0qzLGsSEQcvS1xQtQ/?=
 =?us-ascii?Q?vGRbvjjSrGBS91ZPj43x/7tfCwZNSFZFVemUyaib6CgqFEffMuq507WfDoYY?=
 =?us-ascii?Q?oALEH8VA708akpXKBszp6UD0dQtgv2T7ovGcxiGY7iSFGb1zw5m1J5RR3A4F?=
 =?us-ascii?Q?I/6fgXQJk2p9pEO8rcomcg880tOWirDS1sGmy2qY8Y8Rz7idQA2ptEF+UMU4?=
 =?us-ascii?Q?dC++F5dT3kAWwsHe9rpky8Q3VpznNWZUMy0ScVKDf7gNzl++OhMZHFuClH5C?=
 =?us-ascii?Q?hNuLOKj4SXfZ/E708kwfEUXxctC4yed7OHzgzG7mdm2Kbyp2eM9+xvIKIbhI?=
 =?us-ascii?Q?TnWmgmDEJlVkmn09UgaeUwLZpHCLhPNLhKAxlbEuRfw1iTR/H3fDggFCMb8T?=
 =?us-ascii?Q?YCuSnivmOGADzLCu8ewfT5Df2ucA1NP2mbQPm9AiVpSJ7C17WGESCbtS7UWy?=
 =?us-ascii?Q?hO+taZsz7mV5MBrzj5g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:38.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b60f42-f456-41b6-8136-08de2d40741c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802
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

From: Ian Chen <ian.chen@amd.com>

[HOW]
Before enable smart power OLED, we need to call set pipe to let
DMUB get correct ABM config.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5b8b55c1dc68..8be9cbd43e18 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6012,6 +6012,12 @@ bool dc_smart_power_oled_enable(const struct dc_link *link, bool enable, uint16_
 	if (pipe_ctx)
 		otg_inst = pipe_ctx->stream_res.tg->inst;
 
+	// before enable smart power OLED, we need to call set pipe for DMUB to set ABM config
+	if (enable) {
+		if (dc->hwss.set_pipe && pipe_ctx)
+			dc->hwss.set_pipe(pipe_ctx);
+	}
+
 	// fill in cmd
 	memset(&cmd, 0, sizeof(cmd));
 
-- 
2.34.1

