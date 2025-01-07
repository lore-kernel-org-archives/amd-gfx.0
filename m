Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AF1E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65FE10EB02;
	Tue,  7 Jan 2025 15:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tVGU/qMc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE9B10EB02
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIFGb1Fzyw0Vn3fRAiANxpN/8XGOacQJ63ZN7rKfLlw7yYvUZngRWSBmpRATAWGrCaLeJm2pT3cmjJAEDIu7Oqks0xgsjipTo0HWPRmTCLToESWf3Y/4MxPw/AUoJtuXoIga6BdXgzP9kxfr7kpT6fT3B5CIIFEJ5H2WRS7CSbRIrcC3ZwgtLSA2JeI0J37MxUeWM/hiyiRucOWMd5cKzjJgsc8v5LXb0CLy5t8gs0W9/P5EcyWSsnXTMZ05g4qrA+6Dv6CSuRLgYD/Fsf9t8CUlFRI2VZnduyEryx+jsl2jp0b2JPgk/olNBJm5KFf0gq0E8SEEArwX3FuO+Zxs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnfFz3eE7gNx8Z4bQTUt9qDlPjxq4t3J6OqR1xYX5jw=;
 b=NXkA8fQohtmTmKrBT0N4Wmwm6JyEuvTLPSoMtxJUYeXLOYcOVk0jdWGxn7K2J3CQ2FzSG9oBKDpErZ8YnGG/gGQNanR1LyhXbOoz2qxcKo3CNcbrlIrJGUHHfw1w4iY7muHmtqJz8N0S05QDo2Dt3tHzKt32Jl6MNAPrKjbVr/cyRckNeCTV4qWU8RmALZ4IFr7NxYfDO4w3tSe6C8tDn+tvl0B0O3gZ7MNNGskZBbPm7IQ2BCjU+X7Q7zajEXQE8gdB9jCGWMdl2VrMi26vAq8vnHDUv/ZbPNwX6MYJDp26l+ulR2jHi0o80F9XpVe48AaogWKjyFEiu6VgCL+qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnfFz3eE7gNx8Z4bQTUt9qDlPjxq4t3J6OqR1xYX5jw=;
 b=tVGU/qMccrVRxb7/P6OOG/F+CVqYoECewlSwFfMW65DLdXqTUeBRfa6YE/aiNuXm1UvJU419bIjRGDuw9b96s6y7j7ydr7yQH0f+U6CoBGpQdiYYfMqT5l9lFXimMncZz35UHBLX2E5sRxKvkhE8teOkDvy3f4XNeni0nU1GVo0=
Received: from DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7) by
 PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:08 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::ac) by DS7PR05CA0086.outlook.office365.com
 (2603:10b6:8:56::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:06 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:03 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 11/24] drm/amd/display: Initialize denominator defaults to 1
Date: Tue, 7 Jan 2025 23:28:42 +0800
Message-ID: <20250107152855.2953302-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: e00b1556-dfa2-49b8-c045-08dd2f302ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yQpFmTSGbcE2CaTXPeHAG/UpNLf6N4oRTMRqH5Z9toIcR1AQ4HQNLomyrvRY?=
 =?us-ascii?Q?J7siQoiHAtTXhB+5oI2FqxNfnDO4NdSxBzvuzX0+IzhX34I+5qp680sOqTCN?=
 =?us-ascii?Q?P7kWx/ei3Tv14xtif0EfjwxaN5n6FZbzgsvbELjzGlFGQz+WlYKk9L+HAjQq?=
 =?us-ascii?Q?43gvPs6fXRBvI3B/xVEaQiszH3bbxK1E5mpOviC2poImSZ6dIKEC0y3AvKus?=
 =?us-ascii?Q?9F2/NFCx5z/RJk1RJ2AO1elxpslSYAGQUdI8vUvsLTyJsXCQfyBEQ2s1QTqi?=
 =?us-ascii?Q?KbItmVkkQIRF0Tp4E4Ydjz0TT0TtIFHMrv6Nz4uwVKy42UY+r3YLE3jAmCNN?=
 =?us-ascii?Q?MH5v9p0hseKzWv5DYvwRbv4QCisu4hfxuBmdUmd7A0tlkzo8dMqnOmk+of/L?=
 =?us-ascii?Q?hcShUwFHLOlIlzk/FZMXvtV1Xzip+m4G8YictFvVD2f/i/ALRcaWA4iCKKtQ?=
 =?us-ascii?Q?oz6k/u7iUL5u3TiVlV+yHWHP6TPQjoNfSavGiWg3VEujxuN2hgEaLUT47raT?=
 =?us-ascii?Q?35jVnQZiyGqyNpJM+P9Wt34qxpUpeJqYsaj0IQUoK7LjtObPOelFBas8E6MP?=
 =?us-ascii?Q?A6LO3wMSRySYYPZ17m/VodOLDvng57SKeCFb9OtTD+7wo+JUG/zwjBZqOWcO?=
 =?us-ascii?Q?sBz1FSI1FZYTqc3ZhPdE6dqOz5rOfDC3QpiqSSdUkWM6EvASQQhlIEYjS7pI?=
 =?us-ascii?Q?4zz9TINE3Ye+PPTUKx4xbjQqRU1W94erSBKMZWweNLEwL0/Yp5J5L+p+shV5?=
 =?us-ascii?Q?iRgIdLuLi62WtHlm5xD7RX9KMRu6a1sJZv/aUaV9Wf2b1qzwkAg/GySRPiGe?=
 =?us-ascii?Q?m2fSTZ6dPZOLvrJJ624Px8wJnmo4kMAEMCzFvzlgRaaxyVros4ix0ryosNrT?=
 =?us-ascii?Q?AH5MGbD+zDZ0FoHK7VFelVMdDl8yGTBJ0SgnM++84TXTp3BOur4hGnqpg8m1?=
 =?us-ascii?Q?1boPZnr7dC7Wnnl1FG5cwKMyxgdyUClc6JJsc+yyR0KP5iLOXUeGsoMFt46F?=
 =?us-ascii?Q?SfBFcnGciSN/blhvSqRnshX8GKUCMH0Lm9eXBJ2C4OOotP8KcEG3oToLXqt8?=
 =?us-ascii?Q?nlt7smY4M9nFqUNGfc95SpMBTWnuE3Q5e9x49/b2qp7jUen5iBskgivTvwt9?=
 =?us-ascii?Q?FHKuX+b/xEcArAA0ApRgUabXTfTVFAEgk34dRrwMpMIkc8bFN9gDky3zdj9d?=
 =?us-ascii?Q?N+eRTHdMy+T0AmJZW6gR6IdI1r2LWWPjygnc1LdRFUvQQLCAcH04UozDD/kA?=
 =?us-ascii?Q?WljNLAaLvjtw2XiOUmLbXgy2vE1gNDQyww6LJ1p1pp1o2YPmvdTP7Wpw+p+Z?=
 =?us-ascii?Q?DWM9QVvkDG7zJwKs7uz7br8f4FMVdp1ivHfIUedOvo0cuUoTNMPmGLGrM3+i?=
 =?us-ascii?Q?jO/RT9ldFKHBdaLcAgBLdzlo4AmkqltZ74/4KZRuoL6xY2IdAxvzUJ9PkHA+?=
 =?us-ascii?Q?j+TAx++gV8MPSoUGc+/Et0a9iF1FMW47Pr9LbUcwNilmKkgxzwyRUzIJQLtj?=
 =?us-ascii?Q?u3E+5j2yThODkXo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:08.0267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00b1556-dfa2-49b8-c045-08dd2f302ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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
Variables, used as denominators and maybe not assigned to other values,
should be initialized to non-zero to avoid DIVIDE_BY_ZERO, as reported
by Coverity.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index b9ec243cf9ba..a3ffb8c95d25 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -600,8 +600,8 @@ static void CalculateBytePerPixelAndBlockSizes(
 {
 	*BytePerPixelDETY = 0;
 	*BytePerPixelDETC = 0;
-	*BytePerPixelY = 0;
-	*BytePerPixelC = 0;
+	*BytePerPixelY = 1;
+	*BytePerPixelC = 1;
 
 	if (SourcePixelFormat == dml2_444_64) {
 		*BytePerPixelDETY = 8;
-- 
2.34.1

