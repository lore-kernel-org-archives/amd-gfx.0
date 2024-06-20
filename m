Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1863C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9278210EB10;
	Thu, 20 Jun 2024 16:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuKOWy1P";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB55D10EB10
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f45b576Z2+kJToU/HHlDOpT2dYqLNKnYD4U6aDdpA4gtXxUlztjavzOaAXluyeo0KciOn7Bafz5IKVyjFTSZrVb9rWMJP3r/AQO9jfOqDS3tynhQwTbxCGDeNYFWHxNS0ujdDmg4LmPykQkcfu2Reu75Qy9tEitJv4VX3+HoN7sKh79UFhmcnzZl+4ybhr93LXd1MGNF886fepuOBlBDS1ubIZCanMisv2OSGyp4qbex3+Ls0CQWjcDeFX+PvrgWF42sf+FqO/ay7OXFPZsxWccD2A9eIiCPoXQ8c6s536iGCITZ/SwnR/v54O6bgMfvytct7NDM8nGi7aHm+j70yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JQ/3zv+jG7PN+CbBG4/SLSx0I74OLcJn0T/BHD5Vh8=;
 b=Y/jNMDQDxlXNslFy82Gl7htnBbFJY2X9Yaam6SYaRi3ydjRniUYmdrB0MWd9Ir176ctmfK1VkCGoI+RLakUeM8EHm7cFMJ+wYCo8N1pKDJYzNZa2ApphwnHp9i3SbsESFaDgPFdswyoFBLJP5XGO51VqwY+lVdfDLWrZlwa66ZW5EHjOm33CGZe2/c8DSVQclORb1oC70t3XxlfrfGgXG+/8hqRhd3nYiBnVNt0nUa1X06ZfxAPnYiA4vVc3cBuoi6vY9mB9wmHF0+bBBRWlFzLFtIigpEKlOtIZ3nmLy9trlBFFKQILv4pjSJIyqOv4+hADws7wrw/1vQfHNhPvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JQ/3zv+jG7PN+CbBG4/SLSx0I74OLcJn0T/BHD5Vh8=;
 b=ZuKOWy1PeOtGUw2Apm3b4Eo67YC7BhN6hl4fqjeTLq8bqqAOMVccwfjld4PSj+B9or4xy5ZTJX92tW/Gph82/trM756P1xbdJrsMIdHnnp0RC+FRgPviVL/wo4qeUddEReqxuy61ugXqq0hgGEZ57pPTdqiQcc2NMG82nSCgKpU=
Received: from CH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:32::17)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:17:51 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::e4) by CH0PR07CA0012.outlook.office365.com
 (2603:10b6:610:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:17:49 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:17:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex
 Hung <alex.hung@amd.com>
Subject: [PATCH 24/39] drm/amd/display: Program CURSOR_DST_X_OFFSET in
 viewport space
Date: Thu, 20 Jun 2024 10:11:30 -0600
Message-ID: <20240620161145.2489774-25-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3ddcf5-cef0-474e-95eb-08dc914487b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|376011|1800799021|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jvg33CEzIZAP3iY7aKjk5+ftn0fHRvVQTfo5yOu3zBB1EO+JAUUse8xRIk6s?=
 =?us-ascii?Q?LR5VEZyDiGOqLSaMLn/krfnswFbEU40Nualw0pdBGSrd/9B2ZigH/1dbpucr?=
 =?us-ascii?Q?ruZe/0aVeoNJcBjeJ6KEqh2ysJOB0iBK2jhMlz1V5ntqpZKjSXKJNrGBnFZZ?=
 =?us-ascii?Q?Lnda8BqG+ESdQh1Zge/3mbyKYiiXXjs2pweDGymF0xO5+GV1Kp5VfPzvCDV3?=
 =?us-ascii?Q?o4AaOomJIqNREXGBeNCb6PKEFEUu42hdFufNLp9ipwE6u6vGkkvYQPzScxZ2?=
 =?us-ascii?Q?2hQxkMJe7ETEBZ9zv34RY1Ewe34zr7+1c8eZD0xj4kX6GFGz7XaW4IhbXaoX?=
 =?us-ascii?Q?hyBRG2liNdXnfL/uYql5we1sXFI8dycpXSG9ESrZ8SOjzRqlxcOklHBE2SDE?=
 =?us-ascii?Q?NICQGqWe2Wlv73kq4MZFwgeYDioZcbZnSK8SbU+Yw5n7R27zEzF+xZGjOCD6?=
 =?us-ascii?Q?PAjrYL4R2qrQOqucNFHbT+5WG8S2BvtkDmB2SGIFk2WyNSHYaWgZuFawPqsE?=
 =?us-ascii?Q?sqjxt/eevOIWzxBGV1qeVCP01cA2THj8PPUBMfA6aYGPbQdaaQP6YJSNHw5p?=
 =?us-ascii?Q?4F1x8LB9yLvsi5jtEwFLQVeTZss5YuPRsCi4Hdl/Qih/Y3EXuYIwulRVjM9I?=
 =?us-ascii?Q?70PVmP8/PNJd/tJWfCGj3fvLVolSrz/S+s7VajMsMgkotYP2dJEcZBKE2pf1?=
 =?us-ascii?Q?tLJk8GY4NqCSPQiupQ2hXEbNU/W3sZR6RTOv5aJONtqyeZrIbU4Ct9+qeSvL?=
 =?us-ascii?Q?qnL3r9HnJ6ldfa2NiXsrHdoXwdazMI9HtiYOHCRYwExVnOM30nKR7Z2Pw7cl?=
 =?us-ascii?Q?BcmCN5Yyq+Fq+L4ZLqjXTRL7/4aNgSktzSQ0SVfHhnrMWpnSPdat+BWWQDuM?=
 =?us-ascii?Q?kx+32xCe7j4JnQW/n2oS/Jot32fdrHgg44ElsZ08+MQ01MCQs2qfQQiL0BXY?=
 =?us-ascii?Q?BdumHj53Oh4chN//o6LxGcfN7OwlgsutSYEMRP+0xPciYPYFGpLncC9zZF3G?=
 =?us-ascii?Q?lmUKMtc9SYaaJM9WMrnFQZ3an0lGvTFuO5jrbWCICwv0Q8srIAx/yDSqp0ra?=
 =?us-ascii?Q?sFZmkV9YZsPkecZUMNHA/rs3odD8EfD0oLeogBh3/tMzs1/lT7Y7lHifsh35?=
 =?us-ascii?Q?hoCj4BU4Q0flNb9R54fzMpOYV7+X50qAvlZnLJw7wRNYslGowE4948VNpbvA?=
 =?us-ascii?Q?7mTlNk/c4DogOggWhA0zCw7biVrZ/mshz5HMZ0oB0io8NrPaTR/CaS0upHKa?=
 =?us-ascii?Q?vJ5Bt34w/KroI5hUfci7VQj6F0cuxDng9fQ7FwWx4NFZ7BISJENLkxoSar9G?=
 =?us-ascii?Q?YZnWCvYIdI0cS9CWftNDrtNj1Hga2xdv3cZWVx3I16tykjqPwkNfBKn8W8GS?=
 =?us-ascii?Q?MYWNMPCHHa93t0M3fxSXWTE9MplfOvMGuUCz2mOj3gFQQmMTbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(376011)(1800799021)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:17:49.9146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3ddcf5-cef0-474e-95eb-08dc914487b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
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

From: Alvin Lee <alvin.lee2@amd.com>

[WHAT & HOW]
According to register specifications, the CURSOR_DST_X_OFFSET
is relative to the start of the data viewport, not RECOUT space.
In this case we must transform the cursor coordinates passed to
hubp401_cursor_set_position into viewport space to program this
register. This fixes an underflow issue that occurs in scaled
mode with low refresh rate.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index a893160ae775..3f9ca9b40949 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -656,7 +656,9 @@ void hubp401_cursor_set_position(
 	int y_pos = pos->y - param->recout.y;
 	int rec_x_offset = x_pos - pos->x_hotspot;
 	int rec_y_offset = y_pos - pos->y_hotspot;
-	uint32_t dst_x_offset;
+	int dst_x_offset;
+	int x_pos_viewport = x_pos * param->viewport.width / param->recout.width;
+	int x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
 	hubp->curs_pos = *pos;
@@ -668,7 +670,13 @@ void hubp401_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
-	dst_x_offset = (rec_x_offset >= 0) ? rec_x_offset : 0;
+	/* Translate the x position of the cursor from rect
+	 * space into viewport space. CURSOR_DST_X_OFFSET
+	 * is the offset relative to viewport start position.
+	 */
+	dst_x_offset = x_pos_viewport - x_hot_viewport *
+			(1 + hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION);
+	dst_x_offset = (dst_x_offset >= 0) ? dst_x_offset : 0;
 	dst_x_offset *= param->ref_clk_khz;
 	dst_x_offset /= param->pixel_clk_khz;
 
-- 
2.34.1

