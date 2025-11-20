Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D8BCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE9F10E7B8;
	Thu, 20 Nov 2025 18:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bankKPNE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E8010E7B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffjl4R6Qy3TOB5dcyfH3YmtPU8XZMRQsc47RYufJAuT5mW2em/6tuYY2yXnqIOmbvoVw2nbRH96Khh2Ys//aOsojc8sDeDAn5XavgX3+F7UqKGmy4Cuy+61ADa+SEqvBGpuXMS9cxE1XCZ+0TK4PENU7DrnJnL7pfDVjiiQx+Chh20G6qWx364BWU5LwTJKgUxjGZfUT10RTiTE3+r0WHbrsJiRCEC3U2bgHcDp54TEKVIVefzJHyvqK71PpCAD7NdD2zvPWXfX4LSBmp+Z1+9XwLR1iABuWnHF+FIUgUHFYwoKi/MkN5CPqzWZGFlm/jdsrV0moomlRb+SIvfsHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwKd2a6VI3o2EAvRMoOp8o32nx5Vc/bEdYpCtGgsHeA=;
 b=y1qZm8yxyV2qjA10jCv6x2Z+GrpaPTvcyDYxijnWm5hZ4QSeiRiC5+RP2pS7ZEf/1Ppk98Ag71rhBRGOf2CgKffwQaI+nqxPplrpMjiq0g9wmCkm+pRMrA9tA3FYPmi0u7WxWrivlF5XoDB9gpeCu1VDsQIJSEVBz6139IE//3m3TrzsCaBB46KJWMx1t70BZiLZ5DGu4xx6SHUzLNDGrm6aZ41SPfU/wr2yw/dQzZIuEfnAl/l7b8vslWYNquid2yUMzaFpSIWxpd4Sq0rFbOyseZvu1kfcbJZq/odCUQuSMfEM/115Dh708qh3PjKTjVoOENnu/T5NnRUWEMDLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwKd2a6VI3o2EAvRMoOp8o32nx5Vc/bEdYpCtGgsHeA=;
 b=bankKPNEV1EoRsFREecax31Z7bSgLaO+q2I1bzXOZFlnI9niB9VrPlawVsKmNzkjoP/DmI+rSmeWBEtgwNQXubV/j0cq5V3e4CXQLnYI6qChk9Qsy3qb2jWpc37JWnSmtbHxaegQ6UiPcXYBpRCuU0rVam5gOR56Eag2Hh2mn2E=
Received: from CH0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:610:e6::30)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:20:23 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::c0) by CH0PR03CA0295.outlook.office365.com
 (2603:10b6:610:e6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:20:21 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:20:19 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 14/26] drm/amd/display: Correct comment style
Date: Thu, 20 Nov 2025 11:03:10 -0700
Message-ID: <20251120181527.317107-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: db6c40f7-1e4d-4112-602b-08de28617794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P9LHLt64q9+stSC2kFyllozPbulor4RgwwwmaSPGAU9NM4TzEsL6u1tnHpFU?=
 =?us-ascii?Q?kFvxrk8j7CtoaycX+f4nZBUWKKzxezgYE4h1VNeyK7HrS0uDCNUf8STsHABB?=
 =?us-ascii?Q?yzzHp85g4Mx8VmBi2TJ7R08NQJPzBElmfQnT+diwi39Cjn3BCMfpEQcr2IyK?=
 =?us-ascii?Q?AHWE41cYT5ORsBvWS3A2jusSzstPfIhnrXGT9WYE6/cc2Z/2iJw9YXdzkT5m?=
 =?us-ascii?Q?HsN7STP0cyldJdnlubJYlKXsyfj16KknqK8fmaMt63PVM9Eq8CUT//LDNk0a?=
 =?us-ascii?Q?6ldO6J1HmLxq+w05Ahiq5NmgY3yrhWvOYv2oAe/hbdp8lwzc8Nh+LeKmKOI7?=
 =?us-ascii?Q?d5H+nYBlJl0p5o8f3Wf7exr9cy173yAWsxPItBrL5SaPCEjgdj7QbaDPLv6w?=
 =?us-ascii?Q?LhetZwX+S38qxJw+7McjvolURYtQSACNC9pkz+hsDhH4msxx+HhTpY9H9VGZ?=
 =?us-ascii?Q?bVvDj+Q5fiXKvlkn7+pqFwwkWyBebtKZRZCWQIl6stEOJpF5KA3hnM473Fzz?=
 =?us-ascii?Q?ffNmW7z+lyNyGKbMmCBsbmYXVEVbZh7Wa/Ipa5c22isSxbl0G8X99Hb+NjT1?=
 =?us-ascii?Q?gbGtLqLzqdfpjCPQn22Ml12kssh1p+lyqHSFkiZ6CHdqen3LgpTB7rNeQxK/?=
 =?us-ascii?Q?BBKRvosmkiN/kYp8yN4PSecqofADCMm3bhS1XRM5Pirj0vh5YtcdGulBvbXg?=
 =?us-ascii?Q?RNJOJ1DbvLfjkwz87CiTqlEUHlhBtexW0d3spBMu2nJOSXcYFdGLWNnyfIeN?=
 =?us-ascii?Q?iKs+0Td8mA5f/tF0zkqpVp4FNo/S3ES4GraKAw/qnfdI5egy8WN6zXHvPiyY?=
 =?us-ascii?Q?WandrBTiK0YTv8ZJL9941X1Dxr3jAr8C6quMCUApew/cwz+EKSHiirBqRN6v?=
 =?us-ascii?Q?0EvHE6V3TYJgH1oNGycVL/7XyuP7V/XZyXhGcgEYi/y3sTl7C5HL8656QniS?=
 =?us-ascii?Q?VPvQBPZKDUY3LYkFzDvDI0/A6CPFBlja3Zvc7lqDBJsGPRY/L+cF76Q5J3Hv?=
 =?us-ascii?Q?zeNbk9kdWJTa4EgoCcv3fvEOizSfoeXxUnK57IJqBalrjiPISV+AyexkWd9t?=
 =?us-ascii?Q?n/yCezSpI7fsyJDIr8TaXOzRLJ1AdTnvjQdEAmBEHZcCalIx1OC4BXvDBVY3?=
 =?us-ascii?Q?c6z1oLDvMBFB7+aEQfYAqmLlrvWS8MLpMYHt6ZHfOR2RiH6/qgxW+ItjtyXN?=
 =?us-ascii?Q?ydXMfsSZSsmoigUxcekv/fEDSHMdFKzz4Xt0B2wuRNZ3Oze+NDKltLXXRirs?=
 =?us-ascii?Q?I2kCAIWq8REE9rPu/KQszlGo/0xXhbOZLbsvwpz0GWNipH8mBvmQ5JIbTVlu?=
 =?us-ascii?Q?GUSZ+Fh9eMWwhMWlDUonNR3ZiLT7Mwwlw/UsNm6m7G7Gx6Z9iz9wbkvkhqGC?=
 =?us-ascii?Q?h4h3VK+pBDNr7xFmPj8uWktQqMq1YIUq3IB4NZ7gDROrp7JuO8J3l16ayDxP?=
 =?us-ascii?Q?1Ru/DvzEV2OQlJGfYQKhL67AZ2shJfOYyTQ9R3Cz2PRpNRxnfaBYJ0Y/qUK+?=
 =?us-ascii?Q?Q2WIiisiocdWABRM7Sj8ZQrvUs16msHMwmJAXQPCknf6JSPIzmEydXPUg01j?=
 =?us-ascii?Q?+9m114Y/suLWLxb6NWk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:20:21.5588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6c40f7-1e4d-4112-602b-08de28617794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[WHAT]
Comments should have /* and */ on their own lines.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_detection.c  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 778049b45c8f..f9258d71b68e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -184,11 +184,13 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 	if (link->ep_type != DISPLAY_ENDPOINT_PHY)
 		return result;
 
-	/* Internal digital encoder will detect only dongles
+	/*
+	 * Internal digital encoder will detect only dongles
 	 * that require digital signal
 	 */
 
-	/* Detection mechanism is different
+	/*
+	 * Detection mechanism is different
 	 * for different native connectors.
 	 * LVDS connector supports only LVDS signal;
 	 * PCIE is a bus slot, the actual connector needs to be detected first;
@@ -197,7 +199,8 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 	 */
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A:
-		/* check audio support:
+		/*
+		 * check audio support:
 		 * if native HDMI is not supported, switch to DVI
 		 */
 		aud_support = &link->dc->res_pool->audio_support;
@@ -207,11 +210,13 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 		break;
 	case CONNECTOR_ID_DISPLAY_PORT:
 	case CONNECTOR_ID_USBC:
-		/* DP HPD short pulse. Passive DP dongle will not
+		/*
+		 * DP HPD short pulse. Passive DP dongle will not
 		 * have short pulse
 		 */
 		if (reason != DETECT_REASON_HPDRX) {
-			/* Check whether DP signal detected: if not -
+			/*
+			 * Check whether DP signal detected: if not -
 			 * we assume signal is DVI; it could be corrected
 			 * to HDMI after dongle detection
 			 */
-- 
2.43.0

