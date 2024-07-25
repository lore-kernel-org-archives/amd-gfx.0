Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0913C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E2D10E8B9;
	Thu, 25 Jul 2024 18:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zlqUPNP+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B51A10E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5TY96Z5OO+77qkntVVwqk7FZnqIvOmZ5PxAXn7Vx9V7/0V/s0R6cGbVsFHPOMBxnCNZtDu99zNyASj7LOjsVcDFP9OE14iY/vvWmJQgX5WSH60smdVEv6upvp/WmtOucUA+J9YBpscRsNKA5W3czX3MZ4mgEwlTaApUqIMwSkmAPdIf0lsI31YFS3KmuiMPz2yu9h7+X9qbcSYtcljjJHYneVA26xLgbrUKQLqSkVhzrC4DmvU/f9LF018Xc6hSzqQVFccBlN/gfBIzaHCatOwnYaHpEhtpspk6TLE6bQbjUsY7vMYiilGbYNpzsJ1t8suwszuPIdO+v+3sZeZtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBaEjNTh8yKA9wKS+wcoKKlXNnUiYg4su0FGj7pDCMQ=;
 b=d1xV0NWrDGO47gf1Uuci2h4H68EUW2je9LAifGalpcyVeeY7s9Jiew2y7TuPOlwjcvOg+7x96+8/UTLnsxeFH/OzWwNclwIGTTNERqZrfa82jVfeLJHNd+lzzflZ+Jop1n9W2T43KE9Vprp+kyfCTgC1fadsCtf8cE3C7YEWyL1IzAb8PrUmflLh9pBg+JkbmLoTvqztbrQm4y6VUGsFISR6kasrmlvxmc+v+9t9i3wT6kZryf8BJAXL1tOXVaB2BjMETWbLKZ5cEQ7/7jpFlRbLrIYRwSGek7CgdkCnCGLG54hmPFFNhtbafitzdyP4tsQsCdQIv24NZxfox2iAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBaEjNTh8yKA9wKS+wcoKKlXNnUiYg4su0FGj7pDCMQ=;
 b=zlqUPNP+lDRRLPTR91j9xbZ6Y4T+K05F0LfbFUf8fF+6njQ3CpzvLgSgpwQLOiZNsyrfBGuKc7tlViKeDY5MENCiknOiugwSR/cxuZs2qdORHmvECB5QsBLqLe7VA6o/uIAq/L/EL7YcieNSuEcUD7jxagJyhsPpodU5xOwHUcI=
Received: from CH2PR14CA0033.namprd14.prod.outlook.com (2603:10b6:610:56::13)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 18:04:33 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::80) by CH2PR14CA0033.outlook.office365.com
 (2603:10b6:610:56::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Sung Lee <sunglee@amd.com>
Subject: [PATCH 31/39] drm/amd/display: Fix Cursor Offset in Scaled Scenarios
Date: Thu, 25 Jul 2024 12:01:15 -0600
Message-ID: <20240725180309.105968-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f3acd6-5e2e-4cd7-2768-08dcacd43ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m3uX/loHWOfQiIJZUWXiu4wGZplXOSry5oW5bEsC1nXfNlyE75i6TQievLb/?=
 =?us-ascii?Q?JskKEb0K7EKhypk+SiOVj6NN2HAtnF+k7vTz0UFkeuaVEyOlPD3doq2PmeOc?=
 =?us-ascii?Q?cfpdSDWtX2XjdFD8EW5vuUV8R5N8PuqAtf74zvpErXULZ/8RiE5vRbsfL+v7?=
 =?us-ascii?Q?8lqWUErnVrPEVAdGGyfg+9Av9ry51PqZnMbnbG1fuvp5kwdjK04zKh99wdOZ?=
 =?us-ascii?Q?j3GDUkAx2YA65E4Oz79IZJaBdUrmhwe9RlPu3+ZmCKphxG7xj8RvEVS9dlks?=
 =?us-ascii?Q?XU6zgFOFABJSTB/VpxDQzZARucGri1cWpy8kGtV1ptygJnQaNmGf60pDR0Tq?=
 =?us-ascii?Q?/qEUri8akXz5O4n4FWVHQyGXoEAYYgcxrC5cZEsqXcqITvryoLATA4aD/10B?=
 =?us-ascii?Q?YyDRGBGJ6N1L1/7QqZUfYCAdGHeKlYYaQQ0WL8o4AhbUtwLtdwolHG6QwWwO?=
 =?us-ascii?Q?SHCfH+ZVlhIlwj4nVpD5SkTeIVPLD5DBuxC0dcnq5r8lMsu17JHosrDwutcH?=
 =?us-ascii?Q?mbYpYPeS0y/EVfrDW2WhSmI7A79QE27gslcyhBEyI4mRzlkM11NMq+z7GNVF?=
 =?us-ascii?Q?8z4T+nvCAqA9w/ZDttc/Xif6ckhBUPo6UFQpvo0uUMXXlbROBQ3JdmR/2LAh?=
 =?us-ascii?Q?JAsGP3xS8R2r1F+boK4BUEsyAwXRVC3vZ+NtWuIEPEgtX0YbR0zOhEd0iG7I?=
 =?us-ascii?Q?9McxFr/DhZEAn/zN0AqtRTX9qkFkBNCH85QZCA0CG3Mzkj8nnaNG5xVl+M6C?=
 =?us-ascii?Q?kMVzI2M6l0mDGJc+U04ig94YEvmyeVc30KMHmdZxYFIdcORLfUj9SwdecTHu?=
 =?us-ascii?Q?80X1ifU0TqGQ6db8iCcGamgVnXMnQsOTJVntAbmK86CH2VNO3Nm1uZ1EpCEw?=
 =?us-ascii?Q?HwFsCndZoXYMfHQZ6u/BqVMOZZ8kjezJ5RCRipqatzkwbGHhWyS+2at3f181?=
 =?us-ascii?Q?3K+Idg1sOCaGcM8XKyhf0wAuAW9sgU7riLiOCDdZ1Pf77KqkBs02rOWzsCtG?=
 =?us-ascii?Q?JikwVrTWZwL6bxSh+H5pAfKeyYstCKxjbez9cj8ln+my6ZPbsq+P34+PzBaX?=
 =?us-ascii?Q?XdVqZhNR472ve5FFJEgn5g+tvfcpI2HSQLY4gdCXZfsFurOxdoXs0jaKWHOi?=
 =?us-ascii?Q?e/5tLtpMuVEV8oNcal/vEsHOxPOG8QkbspXTwme7m6meummobPIzyzti7gLx?=
 =?us-ascii?Q?o7F9zqNew/Y1GjKleloyyyxDDwZJ6kt8xP6famAKKorEAzuy4KFe0MZk+gq4?=
 =?us-ascii?Q?0bBcLmS2BQ7u7qGEN4IOBkTE/q9HCzUtqOyqVuLT6kDaPw81RrXQckvRIfqq?=
 =?us-ascii?Q?cY9yzvwwNBOuLsqx/L1thgqmYLHSdk7M4W9CN3wqP0iZEoirOmn9rElMWHl8?=
 =?us-ascii?Q?gwhPMxDohTFm/5RzNtOChu4FNw0FJqXbX2U0PC18QG3ZPtDKSGTD/gGH+l/M?=
 =?us-ascii?Q?4oxtwL56Hlcc6Mktt+Ar/uRxntZ0sB/x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:33.1519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f3acd6-5e2e-4cd7-2768-08dcacd43ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

From: Sung Lee <sunglee@amd.com>

[WHY]
Cursor position code had improper offsets in scaled modes.

[HOW]
Adjust cursor scaling to account for cursor offsets properly.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Sung Lee <sunglee@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index eb0da6c6b87c..846c183fe3a8 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -725,8 +725,8 @@ void hubp401_cursor_set_position(
 		CURSOR_ENABLE, cur_en);
 
 	REG_SET_2(CURSOR_POSITION, 0,
-		CURSOR_X_POSITION, pos->x,
-		CURSOR_Y_POSITION, pos->y);
+		CURSOR_X_POSITION, x_pos,
+		CURSOR_Y_POSITION, y_pos);
 
 	REG_SET_2(CURSOR_HOT_SPOT, 0,
 		CURSOR_HOT_SPOT_X, pos->x_hotspot,
-- 
2.43.0

