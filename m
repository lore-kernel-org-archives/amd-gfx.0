Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1C8EA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FB210E58A;
	Tue, 10 Feb 2026 13:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ka812jig";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB6210E58A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUdcxs6hmUxqcJjSWWrScuw/XpJgCrWnY1olZdeI6YEZg3TRLWPAxogTKrt+3pBMp7iOtUluxCAZqNQ2XJxVq7veDhk1Fobl5AyY5K7p1d88Mll7vB2qES1GbXy6r+h43UYXwCeJsH8LlAkgfdPwL21hgfZaZjeSk5pohZQDYJzj3UchSHaV+koB1EwtSlh4D6S1Zb65uiueC1L98BBonOMqWZkPfDgK5ODisi9/drXK5w5Ak/JCpSNYUTNzEEtm0GQYER4VdMhTHzPAe8lJK1yIwl6IpLk3mF+odandJDWSsIi2d2U7Z5saD2Oa1t5FpCgM0KJ3e9XzgtUuXH801Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+veLS+YXsSdTzOmj9tmd6cMwkoU57FMnJjnOgrderN0=;
 b=qTsVsaK+k171Bz3Ymla8/rCSMArqSkxQ7SULzuBHfcpHQsyMYT84RbSFrCHTBWmbnxkoxA1K8pTiBko7ufU/qGSzkywlZizWo0CABK0oh467A03cljgFJWpXLO5xXbjFUeytNLmadZ6tKcUoioJn2seJSOMxhCHDEwxj+gbtLwNR2pgqL5McWcQQlyWootSre8pu7xYia8T8iz7xc0U17CDdoR5vTyUMIR0pxgoMY/Ymq1xZnfdN6cavVfPavCoRopU8D4IU8nTKUWi+Z0cYwRlheg+fpn8vJeSePW3EQY5z3P/vuFLaauXvnEf9bfwgaIVBFzuVoi3k2XIlar4/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+veLS+YXsSdTzOmj9tmd6cMwkoU57FMnJjnOgrderN0=;
 b=ka812jigeq69RIG98rT3UyjzuQ1H5TB67k8W8Lz+9ykXE49QervLndNzF8w523fShO+/xmUh1oUYwK7MqCT3wLdgCAWtJTX6AdgENOntTx3AEPkr7C9W1D9gPe0Y8II+tNzU6OLNkVXDD25j3EQb33kGIFgF76QrMxm5v61j3cY=
Received: from PH8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:2cd::21)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:56:44 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::1) by PH8PR07CA0022.outlook.office365.com
 (2603:10b6:510:2cd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:56:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:56:43 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:56:35 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 17/18] drm/amd/display: Remove conditional for shaper 3DLUT
 power-on
Date: Tue, 10 Feb 2026 21:50:10 +0800
Message-ID: <20260210135353.848421-18-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a489da0-facb-4477-522b-08de68ac398f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?anoOGuqyEciiY4y+DXZuxeIKkZ8XP+pnJxgomoMXV4IywiodiPg2Xj5k+k6G?=
 =?us-ascii?Q?mgMwPF4wF+ZNSLxmPp2IO1lM8AXFhq4i5enk9DhYuv2VeU9cBunpJuliscxv?=
 =?us-ascii?Q?1qEhVHKy6f1Ghf7WtX761oOY/Ne5kzxvbdWDE34FzWXhUlW5KcjXU2dehDog?=
 =?us-ascii?Q?iCPCxRe6tDCxuQeV9r59Y5PWesAXxcrqMYX9/HoceunqDGVdTHNX5w4TvQh8?=
 =?us-ascii?Q?nfX/y2bXp7HCwSVJjYZYB/w71aefwyafgT8f1+PE3iVoN+dG0nTpk+O17E5q?=
 =?us-ascii?Q?1MfO8YJUM64YZQdlNAxidFf5tS9lTq7HbHFXqhVZQHzWmTZtEKxSCCaGwks3?=
 =?us-ascii?Q?FX+beCdwmJquSWNpIHtlB3Y1zIr2hI99TUEnThZLRgfRWabNnwkKTEDxhyeZ?=
 =?us-ascii?Q?O3pqQUdp0n9BER3fh3SIxHvWJMkNk4fFR5AWJfpHiw8/wPfuqt1QhgAMwAgW?=
 =?us-ascii?Q?MMcv1CmgwT+Rl9yzxTJQQPG49JILtwjNKJDJe7uYstjF/biLmA4CMug9zNZH?=
 =?us-ascii?Q?EZqrrbnVlalGO+O0sezA01xE/bE1ybvXgFQDp8qz6Y7gbo3lK6Q68wKl6/Le?=
 =?us-ascii?Q?+pfjqsEx6XzKzu/NZz/hqzPmn1SbL6l7i6w3cmRSIQW1gVLSp0fJl93hKOUJ?=
 =?us-ascii?Q?qVWVDVz7DuWTuI5cNR/AAoH3qHeuqxGg1TCZ7ONdrTBeGqh0F19WS32ZDqhT?=
 =?us-ascii?Q?7viU0MPNr3Fhzd2A3uG81tGsgulO2HdslJsCpoTDPh9rqzGG0BjjDEsktJAi?=
 =?us-ascii?Q?C0LkQj9BF7ptjqeJYvyqzjLjmfucO2tu6DglcBuyKCr73AXSSplTMzXpPaTE?=
 =?us-ascii?Q?ZebwRDF6YCf1iFe2AQSpqnfkECHAVw/CW3xEhcDsWVU/w+LSGf8eJHfRfous?=
 =?us-ascii?Q?jmCTbCM6T9Qm0z6lY23v8bGypq9gxwe5imZF2kpBez6bZ0yYbs56VuVcAhmU?=
 =?us-ascii?Q?mmAxPQ4LcJl1M0Yq6hoPNyDoh13MlmTAxDia6tdQAfsjcKKaSbmQzLxvvx/c?=
 =?us-ascii?Q?TNpE4/lxzVVBASKXPq7DeFELC81D+Y59JqyaU6NmI2Tt3QmbjcAL3WKauA86?=
 =?us-ascii?Q?uytheC1Je22qU01OPDZr4O0iEu1pRYzX9ygah9kJL1GQoc0u+5O0op5Q9gav?=
 =?us-ascii?Q?0CQLgRemJhlDedjc6TAcOYq+YoUen6cBypT8VctDJe0y1QKz2gScdCHAIQjn?=
 =?us-ascii?Q?RRCxecqJwnpWkYdUCsc+dFAMNZlDF/DMn7ejUBk8AyVrm+4RPJ4KZkhk2zCK?=
 =?us-ascii?Q?oJX+X0wWNBPvESfn+pwBO0uVZu7MneYTXEx/Gs541CczmBMSjph27y4QasAF?=
 =?us-ascii?Q?8FtINbiAeUUi8lsfT2OCrudK/Au/qZPejDZC/PQl8+VKXGrdgG9s51iB7y1i?=
 =?us-ascii?Q?LRz4iSjM0qTlrOA74BGOSC3Dc8b8AXio1YzeIigorNfrBuRg/IPpj2MGRTQa?=
 =?us-ascii?Q?kLriknUNkvsKZ+txcPEs80lAvjj2dZ5LTqBE3sKlNJOLw1NGuAi/yUKjTtYY?=
 =?us-ascii?Q?R4y38zQQYFfb2g/HjGNExCBbNNvLfyFa9/yHodB4sw54G9gAmiDwDoypCNrW?=
 =?us-ascii?Q?bVc4C8PjKQh/Gamm0CVrKIAqkRSpc8CCIbgkbGcdU7o7EIGgQNFJOjYHI7bd?=
 =?us-ascii?Q?dC/n9aGXDbRPfYiqnEji3SerkHfh1jsO9l04SRw3d3saJusdMsyDlAZ/sjJ6?=
 =?us-ascii?Q?YHed1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9cbA5PZ6IW0bGv/zbRwHysa8fvq8Gs+7yXX1DWpgxa7CWe8tPUoNychHFs6+t8leP45Q3P7txKaZDwU+kdS/E683h+liQUWXH2Fi7S08bR5/esALk9o/cqYtP0PwZ7WBbluefZN33ndZWh3Rs9k4z+sHH9p9cXJBgTVGd0a3hJ2rTMUQsO00RZAGtzwNa82qaobCf6lcHoOwnOkgmrEKQaRQLkRY9bTuI79oU7t70X0nDQyzu/xlbAW4Lm03bkfnKy2W8szb2cDZP1emC6ObUPnpkJKMzueANz+zHJ5SioxqHdtSIQQjGmDtZziXbDoVxtl7Jxcow9Lv6iCYXi19MrgH1IkYBBTJ6zj5futnz8v1QFfrJv/LEfZIGMKKoE+LY9eRscAz+XDvc98E3OWsl7vKYJFCvLKkRoy3PHgz0Amne2Wx23EkBz/fiH93dDYR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:56:44.1734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a489da0-facb-4477-522b-08de68ac398f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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

[Why]
Shaper programming has high chance to fail on first time after
power-on or reboot. This can be verified by running IGT's kms_colorop.

[How]
Always power on the shaper and 3DLUT before programming by
removing the debug flag of low power mode.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index 83bbbf34bcac..badcef027b84 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -724,8 +724,7 @@ bool mpc32_program_shaper(
 		return false;
 	}
 
-	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
-		mpc32_power_on_shaper_3dlut(mpc, mpcc_id, true);
+	mpc32_power_on_shaper_3dlut(mpc, mpcc_id, true);
 
 	current_mode = mpc32_get_shaper_current(mpc, mpcc_id);
 
-- 
2.43.0

