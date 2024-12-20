Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3490BE7718C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2D210F078;
	Fri, 20 Dec 2024 21:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NukDbgRC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032E410F084
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/Sca/lRNFiygUPzW50QdTpwBDehmNKwKWo1oFOYqq/2fOHJIUJkHjWI7IapwYOpZgm9QzhorS14dI++kqtQMvUswY4uo8vSrv7RCKaGGjBtPAQgqDYBuITxLZXzUcwhtpZsYQfWiBsimEBq/6q7OyNdsTcSJxT/vfz5y2auxfnmlheVOMHMUeDxm07BJHu3N+2raQEZcn+m1pNLW2yICWC0yPUF1M97TpdvjiS3KnD5ilk62XQEO88iQa2Vsykmz6ZQwhRqJYh1GqfBknk4sRNxiRVH0uxWJJ3BO6uqrdj98X6PPyo2jdQdlqlskObaRMN+xO/AhBJ/NAcPHcT2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGNxI5tL3nEprbBrSABLU8grV/vdWsJ8h9A/BH4cPjw=;
 b=YpNP3GQldy0kyRMeEQqEXQDwGlXgWKOW+ix5uHA1+LB+eKXLN5S2WixDNSqC+Wp7zOns9LL6WiOY+F3TGH1vv46zm/ggXKZSzjtWSw87T+bRmtmBMWgCZaYnGOrdo2KowXtN74fDMdjMC7iIHXHpajT9gZs5dZNIjz8+/oLyMH4rMMsP14rs88v6Ww86yymZB2JY3WBYWQfc+7z6EuO/DbYXWWh/Ye3trZlSSf4TePBXa8YKQl9h7RbqqNd05RKIYKaPX7AfAoILq6BAVLM1XVEriz1waHwFNdGbHlH+Xbh3+zRXDSVuj4IxR5lqFoTDZ7tXduVTDd4LxNbXe7oNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGNxI5tL3nEprbBrSABLU8grV/vdWsJ8h9A/BH4cPjw=;
 b=NukDbgRC4f+5zhHOJqGHyqxlKPyd3cw/maU5+pMFtCv1WHWlEDdujs6pQIqXu8FY3k0ACEA0xC6QGEkoa4tzlEkFrrYbyG8AoBy4iyuyhm+9BlWRs5nP5BMDPS5vjYLoKVqqlPEUfUGIu+ztwI9cVEO1xZd0P+22EaEkzuubqe0=
Received: from MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:23 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::65) by MW4PR03CA0161.outlook.office365.com
 (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 21:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:21 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:21 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 23/28] drm/amd/display: Add 6bpc RGB case for dcn32 output bpp
 calculations
Date: Fri, 20 Dec 2024 16:48:50 -0500
Message-ID: <20241220214855.2608618-24-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8fd23c-9637-49f0-73c4-08dd21407242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dIUfnUJcFE3z6lb67T49+XmptCOcgXU+8RcwmPr4cpsvq83SxkpxKuSEQBzX?=
 =?us-ascii?Q?KL4V6ItZjTUr9oyTQLFS5CO7BRgtbpxIjV1hMX9JXsMOGT7O1QZ4KlXxsn1u?=
 =?us-ascii?Q?5jeu/+YR7ztAk4t2s+2F6p2pTN5CpElVFAUSJi6FGGS5Y2Q7OTyjtBxp+KFL?=
 =?us-ascii?Q?VWpjaH6lYgsRobYDa870Vy+1Jrj1Ju7ppJTpv/6anLPULNLKVWnuOckMaONT?=
 =?us-ascii?Q?MAmWsFcL6xYgqVBwEILNyS7NgUKVlU7w9kBR2iHX/OTDkRn65lpRGAIUVS10?=
 =?us-ascii?Q?B8WbkD8xzsqR6dhV1NJTcA1b9HCN4ISkNPQH9HVW8q5jcb8FshslerRwhOzS?=
 =?us-ascii?Q?bvRLJxsJmjSyYBAexg1nsYVpR10a4RT4DcqpE/lbfdjIySRo1td9e+5LC9hl?=
 =?us-ascii?Q?/LzwP1dqkHj/RDGbi3qfAYxjwTsfABEIVl1u1qWz1hMH6vygdSiKn94Sib6A?=
 =?us-ascii?Q?8fDm8dpLV8mXAWQjm16FSbIkeRX+jvtnz+cwX+ISOqUA8JkxFWofHe2L8TET?=
 =?us-ascii?Q?JlDzHV3w6wcBciXTeXF1wukXA7fXRhXDEqUDJxyMQAtlk3EsG+Ph3p5OvyZp?=
 =?us-ascii?Q?F3riofx75fIE/HCdTJmUKt/WZU62xgqeQy6dqIPHQTj8h7o8N9Zc005Zm8UJ?=
 =?us-ascii?Q?fSjOJiPYJh9IQ0VlWuDIEbds3pQOZzbywGAXvgfNL33S8GJPivClSpKfQBhZ?=
 =?us-ascii?Q?bOZiewqqnMzRELME7QHKWIekJOWA31hQ58QfKjO0eqH6Hkaalpg7W+1iTK4c?=
 =?us-ascii?Q?QTglDdmlqLfQrzE6YBuGVaTUfQlrdMKTAtWXzuAMdt4oUWr2iz8FGPm2gIra?=
 =?us-ascii?Q?UkbTl6WvcgmT9/ohBW7b8Y+n4im1Rsjy/ITCgjuM6fTMNM36Vfe1BoqPNgsD?=
 =?us-ascii?Q?fV85v644qygo66EMPSr6aeZ179uXRgAt2E7c3DzCq4WbXHzihqQCX3JLzP8r?=
 =?us-ascii?Q?5oFwhd2P7YmdosLhL8naGakZDpBci+dieZp2KXrTFbHOL3jK/GbHoqTGfgk9?=
 =?us-ascii?Q?p/ligCCQHu5Zb7JYEJt6Yx6L3UdzNe2pfzMqXjzMKByZ5g5AZF0Se5v6yJte?=
 =?us-ascii?Q?G8oPF4lnWR153QFE1fqkBs7YOj2O6QheEmmJu9b4DiwMV4iId4ZwDUi9/836?=
 =?us-ascii?Q?84DhaYOkPt92W7ju6oQalyKaaXlrQebgIcHB0+mIWUi5b4hsE5Rx766K9KF5?=
 =?us-ascii?Q?gMz6tlvC+uC4wVNYTpsy+IHwu61gRoMq95n/uRELy2DB6qXOwPP+bOCOAf/H?=
 =?us-ascii?Q?BHrEqjd8nvzMOHmyq6HoxXwDKxux7u3qfmQQk39Mwr7DRSypsmDTJBECMeY5?=
 =?us-ascii?Q?yFr+MVZ5CKt2CTw9stHG5x6b85yIzBIJt58Pn1zPIcisGmoe2s2Vy3NkKJ6+?=
 =?us-ascii?Q?krdnNTBqKZ5ZNooJxaqluBRfJR3nKOJqdDQfaGc26z+lOBJeBHc1goG2nA9X?=
 =?us-ascii?Q?nKpJh6oKafoxPkD5SyXNEJouaJm3+bdEEt99z8M8/i1Z2eE35q21BXsu7uzL?=
 =?us-ascii?Q?gF+LVW60Mrtj6BM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:23.3497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8fd23c-9637-49f0-73c4-08dd21407242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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

From: George Shen <george.shen@amd.com>

[Why]
Current DCN32 calculation doesn't consider RGB 6bpc for the DP case.
This results in an invalid output bpp being calculated when DSC is not
enabled in the configuration, failing the mode validation.

[How]
Add special case to handle 6bpc RGB in the output bpp calculation.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 86ac7d59fd32..0748ef36a16a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1595,6 +1595,7 @@ double dml32_TruncToValidBPP(
 	unsigned int   NonDSCBPP0;
 	unsigned int   NonDSCBPP1;
 	unsigned int   NonDSCBPP2;
+	unsigned int   NonDSCBPP3 = BPP_INVALID;
 
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
@@ -1603,6 +1604,7 @@ double dml32_TruncToValidBPP(
 		MinDSCBPP = 6;
 		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
 	} else if (Format == dm_444) {
+		NonDSCBPP3 = 18;
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
 		NonDSCBPP2 = 36;
@@ -1667,6 +1669,8 @@ double dml32_TruncToValidBPP(
 				return NonDSCBPP1;
 			else if (MaxLinkBPP >= NonDSCBPP0)
 				return 16.0;
+			else if ((Output == dm_dp2p0 || Output == dm_dp) && NonDSCBPP3 != BPP_INVALID &&  MaxLinkBPP >= NonDSCBPP3)
+				return NonDSCBPP3; // Special case to allow 6bpc RGB for DP connections.
 			else
 				return BPP_INVALID;
 		}
-- 
2.34.1

