Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5553CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C2810E9AD;
	Thu,  3 Oct 2024 23:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pwv2qSNM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF02410E9AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsnGbgYwkPpZKqYb908IG7qU3ILUdIR03RhS70Z1cJIS9fZmDNO5esJdbnEMFHL6uyCOfebPCR+d/dmIyRte89IXAxt11wAgvApa19ulkwkPJViweyf7ySUQQ30I24eJpp+2ZzYxiDoo+2UJGgyvTq1VRj5K6wbqD8P7MGAW+p2c9WWWvjaZw5Ye+E0VhDwl4siLvZES6FQd7sKvii697GdIy4DtFhul4rGolcrA0gXPh23Yuom7X+vMDGWGfwhkN9V5orW/PozGZMN7ZY90odNrtZIxw7cXyHQR+rYrMe8G5ZKpVLx2IkgbUEOr6x1boPKiN4+XE4k4UwkzRrkoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85vgbcGX3e+3LqWiBKkC2OgG0Wphr0fvgtvO2lJyHmM=;
 b=PYqeGvW5pedOCDPCwGQ4VYUdTuJ6LYo2RisJgD6y5244frAWEAJ73d2us9WwTXHcpP9GKn9vwh25zXbkccp0I4WyYVTrpbVJyVAIgK1uqaA7v1PyGDWBt+pMexY0C+tvdJCAkGaeWLmWhW3C91PxWHFIN8eVYnVyQ4RSQ/63E8sCVxHGiQ2C29KIa1qwerHCcf/YSTCW3zOBPNUz6AbRypbP4IDnRSSEQQccZw32ncl/CLp4wQKlHpre7oKRLPgse5+rw/jx1X2DXpEZBcpZXSsK4+OP+8rVuNg9t2qLnO0vxTVG/b2cCjumcPpnhBEg7kOnrlGpK4VW95/z9qGHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85vgbcGX3e+3LqWiBKkC2OgG0Wphr0fvgtvO2lJyHmM=;
 b=pwv2qSNMIBzeaM36N6YYuOzmWzueVZcKp5OKnAP5SZe4eNPCpNLd2TOc+fDFAEHSRbvANhJ4Tzjf0wu75+zxFiRy0R/0l9ia4A8vD2CewyOjRmjC5ZpPRyv3SeMzuul0OnbUMUqVo+xSbCfDxSr7N4zgvha6RiANK/38ZAPkArg=
Received: from PH3PEPF000040A4.namprd05.prod.outlook.com (2603:10b6:518:1::53)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:35:57 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A4.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:56 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 11/26] drm/amd/display: Remove programming outstanding updates
 for dcn35
Date: Thu, 3 Oct 2024 17:33:29 -0600
Message-ID: <20241003233509.210919-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f88f8ea-f6c8-41c0-4f4e-08dce4042140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TcLTSHUlLP3P/sqmx7w4Rq+bDpJig0AvL2WlVT1/QZdG6KmPB4Cy2WsZGnrQ?=
 =?us-ascii?Q?qi5Cp/5kZNS906nrSREDbOEDU6JAd6dqtqjD/ZxLVPnrAbDxCS8QBXftaFob?=
 =?us-ascii?Q?zLG+qbfSN1w/aT2MOsjjVu7sUavMUVl5jtZcYV43sFu2etIYygRuB4Bhwu/r?=
 =?us-ascii?Q?jBF5xmuQpNQ/r9ohODda88emAAVKiwFxCguScp/XCQ7PpIDu0m9fUKa+qc7A?=
 =?us-ascii?Q?eY3UBe4MRkICEqxlLBBuD+OXFzM+bcKC/1Cl05MUEWtJLE/J9SqEbE150uxD?=
 =?us-ascii?Q?3sWIkzn92MRTqYn3uk2BMVSlF3yaiiQNsDWV7rZycl0hPl6EY1KZAoWblG+9?=
 =?us-ascii?Q?kpShJB5M3rOagsjyxLSQ9lHC20QiAKUw/Ngd0l8irrstxvOXRz0pabRNlJSo?=
 =?us-ascii?Q?5N3DB7IOrfji9LBjz5+a0CaEIw0FZkQefKwYUOvHnWTxA7rBUjoi0p648wB/?=
 =?us-ascii?Q?IsEexd72ZOY/7n2mhBcrd9oZTmYE3fYxFQHbuxWa6IvHxIYoG5DoWHjh6Yit?=
 =?us-ascii?Q?2t0XYwMKZ/8Omun9xhn9NT+9ojfZqvErreojoBLoJRJ8W0+NPb9EcJIVPsUe?=
 =?us-ascii?Q?/ZVOZ3dMBtnBUZIUlSfXlQNjqYGLHRMPGKdSY90zOouOEwhs/yNUHx89/oZZ?=
 =?us-ascii?Q?InezXF1Ctoe/I7K6lEaMdasraqLXBDK0CJwsE/8Pn9d955WeF9ggB9H/EYGK?=
 =?us-ascii?Q?vnoGgct199zexgIbfNDMd8Nz6EAzXWEjRn2Bm+/nuolQE9wofDgz5hpCVfRC?=
 =?us-ascii?Q?HGeoms4zcLw/UEazwrfsG6ry+RS3z3Am9k0BLG+JupUQHiD5+pk1YKp5HgZv?=
 =?us-ascii?Q?0aB8xKjPINZr0zcxnM7czoXJFwHwbhv+gj5xMuUize/9JE0jB3Vngukw+Hr3?=
 =?us-ascii?Q?PXzZV4xE6JN2Q5Fd+XeXBujWBrFJiInYqthFT47ZdE5g7Y9PCePBMwOFtWz0?=
 =?us-ascii?Q?/3h8CUK/RhEQL2gbOuIyI9y/qwq3GNWcipCWr3zCUn9tznIO8xhDFWSoAZUA?=
 =?us-ascii?Q?mEmq+PwBTmzaDxbVQKJ45HPYIM4qUvxkz9HR1IckR7ynGxN67iOAoVo3Q3Wa?=
 =?us-ascii?Q?hntTc3OIZ2sCjAULgYCWcPFDshuZiKHw44VecCEYwU+mHonIgT+qwJw4Yy8N?=
 =?us-ascii?Q?e49JZM9MtDLoF1aGcQ+hPzm6WRNzLREyCszjWKgw3SgCYKObQrOqps3l1NpB?=
 =?us-ascii?Q?VaILP8XPzyD+a3LAhlA4fV54EYhBTsmrEu6IM592kgE2NQe9928bxWJSoN6k?=
 =?us-ascii?Q?FxDZPMBrGkz/7mDrBpOgzGB7hPoHoov3wk66xdSXWT8nbOP/4VveFlteLhFr?=
 =?us-ascii?Q?lHn23St2dnU4hB+GNHIgRvCcjoOE+YnLZ6YFfMLpQMsWYyxkwI6Q7xMLfDkb?=
 =?us-ascii?Q?0jk/8OHtlT3gcT8ATCGcPiNoklFg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:56.6601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f88f8ea-f6c8-41c0-4f4e-08dce4042140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Programming outstanding updates is causing hangs on dcn35, so remove
for now.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c   | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 2bbf1fef94fd..55dc5799e725 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -123,7 +123,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.root_clock_control = dcn35_root_clock_control,
 	.set_long_vtotal = dcn35_set_long_vblank,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
-	.program_outstanding_updates = dcn32_program_outstanding_updates,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index d00822e8daa5..a93864b63d48 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -122,7 +122,6 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.root_clock_control = dcn35_root_clock_control,
 	.set_long_vtotal = dcn35_set_long_vblank,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
-	.program_outstanding_updates = dcn32_program_outstanding_updates,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 };
 
-- 
2.45.2

