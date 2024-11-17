Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1B1D10F25
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Nov 2024 17:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8335310E13D;
	Sun, 17 Nov 2024 17:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oMuUwbqM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD94710E13D
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Nov 2024 17:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfUoWKBJNRl0rLr6EX70EtQBW7vgAVY0+XgFFIFj+5R0RkfbkT31rMZFSAktjupi6f2rYPqJ3e/cM9vE9cehKE7rL860thYg4Pe8GnXWEiAEpAdR8dcdU0S45Qb/ejJFhEF7d6suK6ZuBlnJbTyMeyIP/xsIUnk1vSutrp7J1TNXbu12kksEyMiqIg3xDXd6vilcDX8jLyrJQq/mjgXr+8qVD+nAzOuR/gxEoeBSc/VDNwNSOrR5p21ry+q2oKp+XTTFb8nJZZneinlMkrSPyhQSAQVWEXRekCV4P1LDRmaJYIbb7yS+V+Fb18R/VDkN3Oqodqcks+fdnVwFIll9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsa+qUJzeEokZ4EbuHL8Ccgb2CK36s7kjjrI89rhRZg=;
 b=XukzIQn2QhLVfq2AxcSmBU1m5pP+FodQN88l3PZtKBl/uc1VqpmnJ+jWaIPEHelJt/mAtxaO59lAOOO1UpD1My+EX+mortydLnKYfl1bkPTIe3IEDURFMMeRVq3e851mB9uqmBsJKGXurVaTmSPTIiuPYWAid0nyy9Mkluecv1F8/n1/ZTTbRTOSRABlBtM0PENR4KxXGkODuvCqrNfN284xa3B6lBZRnjWEGPjae5qQVf7nii/Khdqe8nqQAcVVfbKKKfTn/USMZ1m6ULcIb792sf+e29qlzcxfp4Dc/5xRKt0YvFhEbdrGP6b9bCjzWhoOHFPU1aaL0/FtwpSRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsa+qUJzeEokZ4EbuHL8Ccgb2CK36s7kjjrI89rhRZg=;
 b=oMuUwbqMjholwzbxZpjp4QyvkBbPSDguU1X5Co+d2rWIjgAHbyJB7Tm1clu+f1Uvqq5mUfRuRSwK8B46SwVVyLpw/bksziU1Z+BoA0DChzP1ZVZk17SImmOydpoW0Q/ZgI2Pg3T9un5zUwcCVFCmNrjZ3mmMH77thOsjlYU6bKw=
Received: from PH8PR21CA0002.namprd21.prod.outlook.com (2603:10b6:510:2ce::16)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Sun, 17 Nov 2024 17:54:26 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::8) by PH8PR21CA0002.outlook.office365.com
 (2603:10b6:510:2ce::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12 via Frontend
 Transport; Sun, 17 Nov 2024 17:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sun, 17 Nov 2024 17:54:25 +0000
Received: from mkm-d10-yfeng11.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 11:53:06 -0600
From: Yuan Feng <yfeng1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aric Cyr <aric.cyr@amd.com>, Alex Hung <alex.hung@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH] drm/amd/display: 3.2.310
Date: Sun, 17 Nov 2024 12:52:43 -0500
Message-ID: <20241117175243.2239-1-yfeng1@amd.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ccf624-da72-44bf-aa8f-08dd0730e00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oFRtQ28PDuQk+PCpuV7D/7jDULPY1FLtOvNNAnQvdr7SXT+ttbQzT8/Z294J?=
 =?us-ascii?Q?aqJ4kyi/36R9biEivzubSID/l/lVF0fBBgv2NSUjq7v+KGaWum73QV3bnxOx?=
 =?us-ascii?Q?pokSlDupilqs+hNSK3BpVDt54zkRBIIMph3MXhPgfZaAK5RP6d8vG+D+uLl4?=
 =?us-ascii?Q?RarikdgUbkOKwz7xoGwaWKSAhZpC/e0iIwAss9RY2Qn8QNEEJ/CIiUM0VSaI?=
 =?us-ascii?Q?VqDjpJGc6gGj9llFdU88PEcnVj2X1PnquekVj4V5iYPy8eJdaVF+TmJxRWcM?=
 =?us-ascii?Q?yQdJZ8Mc7e4btg4PVMbgQPEKEYA+n30JjDfhSVO3Spk1xaQpxYf3xxa79PpE?=
 =?us-ascii?Q?vswN5ZonAtHj1sKY2XzDb+fuXuaex0E4G1XYX4eeV94gtCIUfYaCvHCmhDaA?=
 =?us-ascii?Q?3g8u+93WMjYeItktAzZMm08/tpKOj2MdNKKHVPqiWVu9+YcXGCgDMrgqxdio?=
 =?us-ascii?Q?GC14Y2uT/YLOzS06hNcDRz4Tl/RL1etrzyPyzE8KzE9BM6/xTidiOE3hKGRM?=
 =?us-ascii?Q?+SU46q3zURrOV95d+x/TCwDF3yYQqrSPegJzGFMcTJchn/Xbj4GNFT0y6fbJ?=
 =?us-ascii?Q?pKyhFagQZsA/2CNXumNdDF9xqn9XgHGq2kvmptcGbnSUgepw5c0Z4ieJaM0F?=
 =?us-ascii?Q?invQVRI3SYKS8Qv3kCaVbP6YYJHUBYbm2z4KEqAmSoM453zljM7t/RrCGAWG?=
 =?us-ascii?Q?07xoeTYUHyspn2mxwgI4t9TgXpInUxXsa/OY4Kv6WxHvjSZCVSjlzH6QlEf8?=
 =?us-ascii?Q?z29FZY/0C3fOJMnaLuzQ3htMzuA6fmaSbZWTLFbl6EzRwxa6iAOii+PIbIdk?=
 =?us-ascii?Q?2M9tj3ZaEHiW0YHs/oDkrLHu3o3T0SntWbdhoumZi/nEceaI9tP2fOfwOjdg?=
 =?us-ascii?Q?Bsxn+U4JsWe08a6BSmdbsEwP1bKC1hR121exwc+O+/gDLoQlPRB7jTkgg1yd?=
 =?us-ascii?Q?AeSy0EFSOU2ERTJDJ309FFmu6YRo6U3zOUujimVITb8h9LCST7xwtAmSdjGf?=
 =?us-ascii?Q?spyaiDM8I4sDFF5LHvadoXoYh+sEJAdXaUJHxGdJ0HS8ASmlZTcEYJCDtA3y?=
 =?us-ascii?Q?IX3uL/zO99QUKTTwPx96wq3ntnfQ3hPX3q5/ai7rnFqHHQpw7ttrupRBif6B?=
 =?us-ascii?Q?t968Foyj9X/3BZTr5kwUryO0dAgCvKwoM95vRHPDnBZlEgN+b/oDEwZPnMQN?=
 =?us-ascii?Q?hgsqKOJfOPpNa4K9jv2l/Qi2XBJUh58irSdwUeX/nansVN83KC6UK+NiwNN4?=
 =?us-ascii?Q?gC+uF7QTEI2JsW5gBycGAJNG4CiInq91GHn+EPPumRAcQkk4BFcAVfqNmOEV?=
 =?us-ascii?Q?QDQWI/YR55CTZzbhII9P+a2joPzY4WYVbZkpVBRRsxjoDaVLf4MU4qEIXRCG?=
 =?us-ascii?Q?ydyUlVd51KlbV1xgVsNm4elel87hzF7R0HZPo7A2iYOgbxamWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 17:54:25.3707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ccf624-da72-44bf-aa8f-08dd0730e00f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- DC core fixes
- DCN35 fix
- DCN4+ fixes
- DML2 fix
- New SPL features

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e143fab00a86..104051935884 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.309"
+#define DC_VER "3.2.310"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.1.windows.1

