Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFE4C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22F510E55F;
	Mon,  7 Jul 2025 19:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRoP19a5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D65F10E33C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koYuOKO97HDzn1amtHXjn16dpoITdpbZ7+JJgVlRQjRMoLZJYw32wvjPadvUF6cNq5FuDvHgkipmlW7C0jgciEYSvoVIFs2Pzuvlz3TCe+mblqYZtWzok7zW0Pn/EkUO8XsahwXkT/lomgznVJBQxhIfNZR2ZAOOMwbrS2PxkbEbXrU3kO7zNUWPIWR48vftbCMkutGqmgD/cGWJ+MibNvTmFHq4OWn7/vFAi7vC8ccrCXYaTmpGov6g+XipWzEXHeQ2CE79Eo0uvfC5vChwkh0EMKuJu76fnKw5XvN3IABIBTwIuH1HT6uf/rV3ZhzQ/dU6QVeyBM4YWZ4fQdjgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR7tIUPhwO88n/93x22LlUSUCzQt2bWG9RCgyJH16sE=;
 b=GabCiIuUeFtn9Mr3SdjUjkL3JlnXTqAm1lHeEJParT0J7QHRtQbqYCcRGKmROZPPVu6jGJYQk3fcUur6dkwI3eYo9R/OeLs1QS99zKTjXNKaHzcTANfgx7HBnNyF714yGSCyGkMWha0jGAGqgrI44s1jd89G2WH5dLmzyMQXCPOujM1AtttwwCOfYYUXywi3/eNMu6YwkbQo55dNjQnKyiuJEMdgury6UP6Z9bnJl0NhtK5uAyX+SD0V4lmkPK7eWBnAwtQ2lkvw2tTSfP6XQsM5gUU8Jnfm47gkb1azJvsRucpb3mnLDj24vMwHGaZNLW3TPP3pTcR7VzCfysZ7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR7tIUPhwO88n/93x22LlUSUCzQt2bWG9RCgyJH16sE=;
 b=PRoP19a5gCdORriNrUAr2Z6mcfI9TQ95txO3aO8xsGAChxGZ4zzRXOIbtPpXVYwr03hvcQNyXRfg59kWH929foKJmjxu9t1xz3I071akJURWYhvIG9/zEVPeiRroDQUgk87ynFMfMzkzOsjTgFgsmppGhZz1dArclZM8ru9KiaQ=
Received: from CH0PR03CA0441.namprd03.prod.outlook.com (2603:10b6:610:10e::34)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 19:44:48 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::e4) by CH0PR03CA0441.outlook.office365.com
 (2603:10b6:610:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:44:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:47 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 14:44:46 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Aric Cyr <aric.cyr@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 04/17] drm/amd/display: Add definitions to support DID Type5
 descriptors
Date: Mon, 7 Jul 2025 15:41:24 -0400
Message-ID: <20250707194358.1185190-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
References: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5fa0ef-3ba1-4cc1-02f5-08ddbd8ebb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GsphUv5E2viS35XuYyCG0XnfkTYSgGOVzOcrfpExiKK2oInzXEBukHP+GQcr?=
 =?us-ascii?Q?f0teD0mITPcJ+6StgKrSre/4DXpUUWCZg94+IiVLTY3m/M5KMZ393DIGXczh?=
 =?us-ascii?Q?IZw0B/vBsyz4OFLqehCOYpDTNwlhxUi4cRDBp9zflUjpIpKtizxNAVKsjcKa?=
 =?us-ascii?Q?fSzQwx2887nuwHKnljuKceiNjPSGtvqf7i0kvRidZetjABhExHfXKxbS9IpK?=
 =?us-ascii?Q?2nHWs5kCpjZsIDLWqk6mk1s4tPWppM5z4yzTLw/b0N0LwmKUdgquA+dcH8aX?=
 =?us-ascii?Q?NkOU5gEFHo1i36HS9vN5gShuI8Z+BEkYf9gty1G4aZ6PibjbuNPv4GX6cV7C?=
 =?us-ascii?Q?x89uw1IJuXW/MG+mk4GEde9g76wU2CmuWJ1IUz6stjKLhyoCYYR1j3QzCtEw?=
 =?us-ascii?Q?5awBy4yuIWMAhsUOkxOVEeZNh+V/14VhfRnO6mIlYi0V+SQYTHx01PnNHnXH?=
 =?us-ascii?Q?A8v14B3tPEWDAQEJltHUMc+qSfPxLtgDTvJgw4A27FeEseR4hUmJeyYjWqKb?=
 =?us-ascii?Q?xR/VKq1Y5vo6ptQtr10dyYx+cBkM7M3wxbzCrrn1qMUZ3++yRd14EB67N4Qz?=
 =?us-ascii?Q?2rVDPRhh9ot6fh71lMoVALHuOwVgMZZ1+pamPFtlbSBB5J6bTN2p/zTx5e6Q?=
 =?us-ascii?Q?JBhj1fuYsbEYitahg4SxSbxQHuYYHGWJgeIGURQrDFiGkucpljBidTJfduAC?=
 =?us-ascii?Q?Bna5kvS9nRCaoxLPnEFSs6qSTZC5C95F5FPQFXNxhSFEm6UceZJHUq8ryurF?=
 =?us-ascii?Q?COH52DlmsPTFdYcl6eStLaQorv4fvVeV8emYAxYXeBbi3e8tMr5nYWQyj3Eq?=
 =?us-ascii?Q?VZ7Ds1vjNE1ISYk18D2HbppxNGm2njXzTutuQqhl3/ZrQqhrav2wsdcGh/Ha?=
 =?us-ascii?Q?UInrBXB/R1e+wy84F+YCbTVVwcD0YSLUBHVyaefy9jqOnshQzjJSoM2ksCDH?=
 =?us-ascii?Q?lDRvQzlB7IMXQnL01cSSeecnmAR2o94RCZJRyVhG/yo5AXjLHpvhNljf7yI9?=
 =?us-ascii?Q?LXnE4dwHfU7lQBilyk7eGEpiungXPp32SG057b6QfAxO8LzhBL/aS3iHleAM?=
 =?us-ascii?Q?iqWmpo9pCF+5I9ozWvS/4LKe5cezm2woDxiwcE9p0v6co+bLGaKbORy2S0L3?=
 =?us-ascii?Q?MfXXzRnOq/tZBYPo3SZCbG3e2hzfEGjEOh8N4zEw1TbMgK+u8H/RlFJkTUKt?=
 =?us-ascii?Q?bw54QjF6nEQXSpNhiOAyVCyq82Gv2HGTIMCHblYztntwsu11bamWJuQVkgzg?=
 =?us-ascii?Q?YgiE1U3EBb6cFmDm1kLjuSktVIUnEMv1W49XEFmWv3qbsrq9yHNhwL8VLI+o?=
 =?us-ascii?Q?aM6YmB9hMgVtGpztlhAC+gsQhI/cmiqRvvlIy1cY4FplGSOY464qgYO6BRjV?=
 =?us-ascii?Q?M6Vow1W8jzc8032kHQsZTERzrQGAXEwq0HQcjs9HtTpP6tECk6nvNWSirAMG?=
 =?us-ascii?Q?V2kdcAeRiQ1mzWUNtHRMM2lw6Cfp8PAlCI0BO4TCVz9NhsmxhckEPQj0FFYp?=
 =?us-ascii?Q?6gNIwesgOPsSX3TTppL0LDRCUar1GWeESlIA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:44:47.8098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5fa0ef-3ba1-4cc1-02f5-08ddbd8ebb20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Add the timing source needed to support DID Type5.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index a0829bc0708a..229a754b7b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -263,6 +263,7 @@ enum dc_timing_source {
 	TIMING_SOURCE_EDID_4BYTE,
 	TIMING_SOURCE_EDID_CEA_DISPLAYID_VTDB,
 	TIMING_SOURCE_EDID_CEA_RID,
+	TIMING_SOURCE_EDID_DISPLAYID_TYPE5,
 	TIMING_SOURCE_VBIOS,
 	TIMING_SOURCE_CV,
 	TIMING_SOURCE_TV,
-- 
2.43.0

