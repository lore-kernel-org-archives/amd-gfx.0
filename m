Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF99DCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B94D10E7B7;
	Thu, 20 Nov 2025 18:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="znDQUjRn";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82A810E7B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1zcGhisNDZiCa9RpindjOQ4oJbczBUOsBUmGalwRyBun4tEcFtk4dFpywSKGQpBpUjcUywfBcUqiUeJTDaXzFOjbBIobBJPHxXM+6qCxuFQKAZW0hbK0XLRh7FVVJHeQb1lpgKlMvHme3j2eLtlG9iluuAAd0z2eRElVxT27uZcNBOKbMLyRvzHb0pdz2kh7pPapCWKujI/hX2l3Zo1MRpcyeeSrGQXjhdVG6lNrcYxJXnD+Zvvc+cAh1cM9juI8AdjkEbqohjZcEfM56hZfScf7ZFYKRtvPRBcqdaQBxyiLgKMYmH7Ds6HWowhqstgRSppwXj6wpiyIC6uIXDlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnaZmOuWibMiciI44dWsT1gGzhCbpk4zIvsfJNYcEZA=;
 b=a2hPXDlFs5URNCFxIjIgbwnHgn6FIQLC9LGb7ZtnibyVj820QBRxB4lW7t2J4hUd4mir7O2u6U0bRE0wUpjS9nqIr0elYWW5KU8hWROlfQCEiFgj7Dsw+AymGngbvr4wMft8abaHDgbAfJueZFCXsRDyEx4kL/Oz06t8dw2VjWTirWXlkjQMEV919n3CPXA412JOS81NWQeDjwthG7b2nUb3UkHVPu51pr0uEmUrlm42Bbc68z1h0uOZyotJk7ZVzzD82jSvi58mb+ntBfU2PGL1q+KLFBe/qcSZbXlJwq1uUbVR2zIbT9jDA2vWZ9aNavVeENL1/ROZlYMhHKeNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnaZmOuWibMiciI44dWsT1gGzhCbpk4zIvsfJNYcEZA=;
 b=znDQUjRnByWPUM+DVSGeztuX6jUlPRK72IAI5We+s7X/pDFvKPHB78RBe+7VFbQdXyrUf5pTp0hA1Ur4m0LnBptPvHXFcz8S1tT7r8SXtjS8LbA27KQHelNOcmSujYaolvAAZpoKjh+lVUev2Ufn+79LSIS/eYJCyP17L372pC4=
Received: from DS7PR03CA0120.namprd03.prod.outlook.com (2603:10b6:5:3b7::35)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:20:03 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::52) by DS7PR03CA0120.outlook.office365.com
 (2603:10b6:5:3b7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 18:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:20:03 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:20:01 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 13/26] drm/amd/display: Move CONNECTOR_ID_PCIE into switch/case
Date: Thu, 20 Nov 2025 11:03:09 -0700
Message-ID: <20251120181527.317107-14-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: faf5407c-d02d-48f7-7126-08de28616cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VM7R1aZvYFGkov1ww9POuF+zhHl1VsO2XEzrDNzEbBWZ5w/7PHQs/6ln0uzi?=
 =?us-ascii?Q?f0PxdmazS0+1jMttOUM0jNkCxw8jHNyJhraoXmKT6azp7eK5MEQs5rtrk27D?=
 =?us-ascii?Q?86LvvMBjCv2kkeWLe9P/6n7Ag4ZjVusZG8EldWvFwpv3SCyPiJATrN2fEwzF?=
 =?us-ascii?Q?PO+LrNljOYFa7bH06ATfAbFWMKURho1RtvM6wvYDl7Z50jhQjgKGtUT020wO?=
 =?us-ascii?Q?R4V7WnbGt64wex5rJWlT5hwL2gxvk+WpnPZMgzzLRYKLf55yECRK/khb4Er5?=
 =?us-ascii?Q?4vZUVY0fAXeUiZQe5/oyGuwTvwUxzkHY0yJ3vwbOUF8rGD7oYXJBYMHZuzzP?=
 =?us-ascii?Q?GcBOu+n4ymyKyeX0WBMQItvdW3jndq/NOW5dH5lwDg7ry+rilzOUyI8HUaJL?=
 =?us-ascii?Q?df+sTunS6eaxEjVDcCI0gdpOm23WO3otkbXVDFhC3d2kRK4LBslgGa7ibj7H?=
 =?us-ascii?Q?98bK8EE5tRro7+hlE1Gcc47kpwnWeCGNMNFldI43pYlIo0fKKjkt6ar+zsC3?=
 =?us-ascii?Q?sEujaS0mjTw4zQcNg52wcEJ4OhKiSDNT+16/wGZ45CFYRHpKwZGTvFRGvcxp?=
 =?us-ascii?Q?G/VE6dXCVXAtkbuvBIOArR+Q1zcxoJ6dq5z1aPtHM1P3T6POAD2khkG+vylY?=
 =?us-ascii?Q?UttcyAj6UVIcT0Q6i2gXnwbReOrOdzN7pateJ1k+ZrkIwRLAXH6c7Qlslwz0?=
 =?us-ascii?Q?YHne6XtG4upPkD63a6Zp+I5EfV/iqh+Kl+LlTr+/dyWM5zKQngUyBkWcje74?=
 =?us-ascii?Q?0XKmYgBoJh2rfDSwkxa1Ohn6h1i858Jlipm3KuI3UqPNoX1yBYDuQ+FDkx4w?=
 =?us-ascii?Q?nYngOwLI5tX6QdF5cOphMCLFS9e5yxb1JKr2vq7GXNKJdTDvihO6tHIzsECI?=
 =?us-ascii?Q?JSkvANSt/Ey1/VnLmWJwa5TmJBwJtNVNjFVbAVcC/NKW3NnwS/g5Ygzf6K4t?=
 =?us-ascii?Q?OYPOfXAYe8wzKz6Z+RkprYukA2bjOfnRF15g/GJPJFn+URu6dLELV6C34QBF?=
 =?us-ascii?Q?gSe3Eo3vhrFd9V3BQiKoEiPXbCBTN0AQBlThM1d6XPwUvjjJGu9W0WMGra1I?=
 =?us-ascii?Q?+Y38OJ1C9Gp1ZFPMXPHJOW2k8bUSXTfjR1FZY0pLQmDPMGv9JSZD8eaz47Ja?=
 =?us-ascii?Q?Iln04892/WPfveLWbAMemePLyZ3teBRBeYfhfNnyR7cLG0XcoA7rcTlzP1zW?=
 =?us-ascii?Q?bnO7pqHas9CRdugYbNBi/BxMJroP1ObL/AgY+xWCC5lKARoUYfLvtJoavIes?=
 =?us-ascii?Q?Qod2o0CHZX97p3Nd+/1QcTQ+7pKMaRiqUbqqQBTMx3My4nUp88mp29XR4DuG?=
 =?us-ascii?Q?N++9vSdD23MaHnq0QLZbb4IMnlswzAGqZ1jLTDPeXwaPS4hK/+WN/V6nk+We?=
 =?us-ascii?Q?squMH163AIsZfikua8j1TkQE7aTTt8n6ehGvT1UHTOmBuTV2G5GEugiatM8d?=
 =?us-ascii?Q?bBtZpAWowMBB66d4Yoz4aJ+khjQFlFJDU2Nd3e/po5RG+hrKeXXbZHSZEMj1?=
 =?us-ascii?Q?SwxYcyWlt3f5ZrfFVKim6g0Vlx+P0HbNMUDCbAPeySKfAcxQdx8bTlxNRBlz?=
 =?us-ascii?Q?1o4oNx1Doe4V2eUG1NQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:20:03.4076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf5407c-d02d-48f7-7126-08de28616cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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

[WHY]
There is already a switch/case looking at link->link_id.id.

[How]
Move the case of `CONNECTOR_ID_PCIE` into switch case.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index e0402a04f25f..778049b45c8f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -195,12 +195,6 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 	 * eDP connector supports only eDP signal;
 	 * HDMI should check straps for audio
 	 */
-
-	/* PCIE detects the actual connector on add-on board */
-	if (link->link_id.id == CONNECTOR_ID_PCIE) {
-		/* ZAZTODO implement PCIE add-on card detection */
-	}
-
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A:
 		/* check audio support:
@@ -225,6 +219,9 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		}
 		break;
+	case CONNECTOR_ID_PCIE:
+		/* ZAZTODO implement PCIE add-on card detection */
+		break;
 	default:
 		break;
 	}
-- 
2.43.0

