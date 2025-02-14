Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A91C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F2010E484;
	Fri, 14 Feb 2025 15:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fMkLGdkP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879D710ECB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEBzPk7cLJB9yfNb8YGq5rag38vPKK2b7c98Xf8z7nap0aUp6Y7Y6XqgU+SOEm742OCM+ysOomva6sjCMYW1lWN4I3uW8nu4okYqmYUhC+jER4EFhh2zTIkgEaiNCpGhJwCkihik17SMjKJdKK7p6Otw1/o7MoifZ4uLck4PT9KNFZn8ULfjg/x6kg76npFNnASAYeQ/dt382oKx36BKec4wg7wL1acKmjcKbwTg0uD7oslBei17kx4xXWr1MEnUlWFlB6VnjI+Z1cpqdJWrO4xX+LYV0N550M/cAYv6xu+gEngs9IC0SDm+veTyapJeBh466mtZpSLgyQAPAnEotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cub/7i1Eb9eDf3Qd9iNtUeqnH533ObKqvXNWCzYtw7M=;
 b=TqNr2WJvLmWobnDCIFwvKzwPhX2jAHepeS4iTGHquktm0bCZ0G9irLlb5Cu/mVoGVVAtQ3804HSbSsRiDsO7CMTODE0Fx4Foi4OKPMdQd/x2Gc+fnpFunkKpGd44UVDhT54/6CRJnv23o8OfKvWmX/ewEFvCRoHxBJTVL5z1WZYvn6BUG8nve86u8ABHPngaAwAtFbAgTbBWTXE8gRXqpNJqaXcKUXvytih0Zci3MhjgUUGw1wAT0wcJycUTjtjSJcgF1TEgMd7F7EGX2dBoEUScceVlA2KVGM9LXmLVU9D+rJyfd/iX/2cutXzNmt07qVkJgeQbvWE+HgO9ESLoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cub/7i1Eb9eDf3Qd9iNtUeqnH533ObKqvXNWCzYtw7M=;
 b=fMkLGdkPIo8ycUQeqBHeAEp/U8jroA3zHbZAcV2XtcFdhJCL/s6Zub8zkuLawKtWxb6lXicokdF+P21yLJ0t0y6GyHaxwfxiWtsKhMrWJowPLRyh308X6E4qsw5HNvk219FMbylleQM390WARz4NrAsz0bmFG4mQensAnz0YlYI=
Received: from SJ0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:a03:39c::35)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 15:01:38 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f8) by SJ0PR03CA0360.outlook.office365.com
 (2603:10b6:a03:39c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:36 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:35 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/16] drm/amd/display: Print seamless boot message in
 mark_seamless_boot_stream
Date: Fri, 14 Feb 2025 10:00:25 -0500
Message-ID: <20250214150033.767978-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 5216769b-3cc8-4cbd-bec3-08dd4d087ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LvWnuLCu8l8mKWkZiejS5jYXkws92VbkruiUiLvkvE1QtlEhiCoGw38ZwVsZ?=
 =?us-ascii?Q?4G0A2HAZZOCWQkdzpSG1GaJeGY9f5Q8jO5ZsVnpC5snCEE0gaRGjNJVRXojc?=
 =?us-ascii?Q?9hINmtUZJbhhJKbhv5vc4eeLbGR8hWccu4A3TzdARkS5fi3ZC1jfRgEtSa8B?=
 =?us-ascii?Q?BvDUm4GObdgbD9jkJZcl+WEGv40WkpEqRymjXzaFy+be34PoM3Qw+ZUqAgK7?=
 =?us-ascii?Q?ADC9RfXRc4WxzQqjVnDQ6KiVprQ7MYddPs2KYvpRlw+5J25NFFz8315+0HCE?=
 =?us-ascii?Q?R3pDH4+bFUhw2p6QMI7PhIaqNzSn/JRCmNyppQ6uncCN13G580MFHhIunqX6?=
 =?us-ascii?Q?50tnj8m28IZFwBGPMubWpoO54b6cw5ChCPjH528Pzjx+0I3MmtyqZKmK14c2?=
 =?us-ascii?Q?amn8beKjUAPI9PfXFccAtd6Vxsg3Y4Qsa2afObtiifPMg75u12yRISysD7Qg?=
 =?us-ascii?Q?KRtWnDdCW3tBm03nMCDVKdbx+wPYDPNITHam6nHTsVyN4nkumxo82e3z5jxN?=
 =?us-ascii?Q?PMMz1N5gTuK2O2DOJSiGnhdxtiNNzNes2RKEu9IFh83tQHJg/rDft5vqZlDU?=
 =?us-ascii?Q?dFM6kKeZCA1//h1jO6sED2Hab79keeUNQ+W6Pxtlw/JPkh5/pnm7xunAAzoI?=
 =?us-ascii?Q?dQlEutSyl36ZtrNg1ud/RPUUhN616OJcqRoTF9Jo5iFcIfZjdKoeJMA5xwjB?=
 =?us-ascii?Q?z1Fv/qfTbgaFAzOoMJ19ZCOESOyVWQFC/OZf+0ySv5RjJW/bGOoddJvN6lUa?=
 =?us-ascii?Q?s1We/gsCuMlAcH1t+H9oQF/cJSMzfpU8nke/xndUY1H/CtugFyNE9cCuSXB0?=
 =?us-ascii?Q?kHhWIWFrVur3nai0UNCmB/lyuM2DWdFDiG4BT3gXw07IFplHHtwe7MNk7odN?=
 =?us-ascii?Q?4FmqkBzTvBrVRiAAYvRlcOYzdLf0vradFtbvFHKl4CQBNJZVnARrCgEiSD77?=
 =?us-ascii?Q?/TM7ViFQ3jnLBP7Kr7mYaoasIgYbCwPXxVc3veHpCbuH/O7ECptPrtHwHTsE?=
 =?us-ascii?Q?oHFe7Yej0RUhPm+PBKNwgtlkOEF2YkzkWWCg46s9cvY3aucUDWMGi7UJwnxM?=
 =?us-ascii?Q?JRQ/khQ6ZxNeBqAG6Qi5yE2k2NKyWx0f5jEto2IN9dqQxN0UTqaTuq/MzEk9?=
 =?us-ascii?Q?n9hpFGSv0ZBUtrQM3C2jFdYZpiMY5X7blpYgEtDZ+K+cwMrSzozaEnvDNu5E?=
 =?us-ascii?Q?4BE2jKTesZno01gE3ztSiJvfizhpWrmHobVSHqQQGfIB2QZOz0NrLcsg7oHa?=
 =?us-ascii?Q?m9xaUqB5QcNx6K85mOaJN9BQbv4fypZWG6BqNp/r/Ax9ksFzkZnpgRhJ4zSq?=
 =?us-ascii?Q?rZmn6hMFB80NgQvcMwj4rcEu2Ib8/IvyYwov5oQvtvfHVeV5k6yvdXtfcuoI?=
 =?us-ascii?Q?1yX4+4h3HK1YV/RwQU+nzngREB5f2ydofJcb9pofJ8rcj00u4XcXVx0pptp1?=
 =?us-ascii?Q?c6rFwkopt2I2BNuaNO9lV1VTl7p4hqm0WbcIZ1uY5TVVWGkESpwFiO0qBkvQ?=
 =?us-ascii?Q?DVIUTSpaXYQalIU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:37.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5216769b-3cc8-4cbd-bec3-08dd4d087ac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703
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

[WHAT & HOW]
Add a message so users know the stream will be used for seamless boot.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bf14fa1e3771..e6bc479497e8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3764,6 +3764,8 @@ static void mark_seamless_boot_stream(const struct dc  *dc,
 {
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 
+	DC_LOGGER_INIT(dc->ctx->logger);
+
 	if (stream->apply_seamless_boot_optimization)
 		return;
 	if (!dc->config.allow_seamless_boot_optimization)
@@ -3772,7 +3774,7 @@ static void mark_seamless_boot_stream(const struct dc  *dc,
 		return;
 	if (dc_validate_boot_timing(dc, stream->sink, &stream->timing)) {
 		stream->apply_seamless_boot_optimization = true;
-		DC_LOG_INFO("Marked stream for seamless boot optimization\n");
+		DC_LOG_DC("Marked stream for seamless boot optimization\n");
 	}
 }
 
-- 
2.34.1

