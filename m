Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F80C0219F
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E095F10E3BD;
	Wed,  5 Feb 2025 18:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B0drI1ck";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C0E10E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQOKRfFH2TC0y0zMOvcbUxMHBFeXzGT7WD8BPeP2nZ6O5Plgj7qxITMQvOAeQkpi8A5Jr8mIGfdsxdxBDlB81iDXPbfrJMuScUymyEncTUYOdyTLuTnTD20fdoywQ7+ouY512/fp7dyl+C4jLAbVSmCy9uQzaHMZTHtrOePGOKpRm2FUSN1Vl4xXdH1VtBMj+qmwq7DWBnB1iLJG/+iX3rUxWQdynfmwWCHe3c8dzOcjQQm2CY9T2GVUJPP2JsHmV1m2Wd53qR+MsTgara3yPWcurAoMmScTgqf08eCqD7vbpttqoMunAeSH2MRbKIUsZcWosQVPvikrgRh03dlGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsSnwOMr+iCeYbGS+MJDZ50bIrCyk03QIdisAsW8Bgs=;
 b=U3mEq4tZ20gVloKRmrz5aWnUkqFet9OUJjDOVufHmHMiuIFa619jwwlE7kw/jonpw3ynKHWI3jeakMG9Pult08DeMhj41HdQ3P/q+3nMZsiV3Y2ShBJSCiOedZkheUCDJBxe+XETB2wnwnrP2QsQ5hpXFTsZ0bmT/alMcgFvAOS+ltpE40Oxf+onjaHYJftnU3uHB5evLwbDpq2cGYJVjFCUdVHWSMNqg4JSGGvFIfR0Dusg4hqRlQZDnc/OdfiKqwOBdZKhbOFkq2prupOTIP3w8gXZfqzmJmwJ0f86gm88e5MZvIh5fXLDBUr2EtoNXdXATRBJPDvIVpJ8yIrQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsSnwOMr+iCeYbGS+MJDZ50bIrCyk03QIdisAsW8Bgs=;
 b=B0drI1ckuOwWmmtm2Qf9NLYTZqOpwSWb5iDlfIQroI5/EgwXyB83WzmZRytu9tsBRpnC86PjWg9Til1t7tMGkptI5egzfh7Pl+x9yX+dW0K51oim/gOPgaRaaTI1yx3lbJPVougQWSVgZJifivchAhGJ6HO1eA0za/k9P8A1GQk=
Received: from PH7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::28)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 18:41:03 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::c5) by PH7P222CA0015.outlook.office365.com
 (2603:10b6:510:33a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 18:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:02 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:41:01 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ausef Yousof
 <Ausef.Yousof@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 08/14] drm/amd/display: limit coverage of optimization skip
Date: Wed, 5 Feb 2025 13:39:23 -0500
Message-ID: <20250205184036.2371098-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8be0da-58df-4ef8-0c5a-08dd4614a494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRcW3zFOb4N/9Vmk+qidQDZf6SqtEpt9+Cq7C4amakD5rPT8FyqE04VQXJ5T?=
 =?us-ascii?Q?+2jOpEOv6+ZIbZy78mO8V8sw7RscNmfzhWoT24w05D4QMoqosES6gKM8EqP2?=
 =?us-ascii?Q?nj9FHwTGop0al6Boj7dNthLSxg4v4S+kHTpwr7hlZboHhM5ImHWHFroo5d8G?=
 =?us-ascii?Q?zjRFxDBdHX2Xrb40Xntd7UBLQo20E3DyAfQ4Q5vTDarhl665tps+lN3+z3Vw?=
 =?us-ascii?Q?7yXEpxGZC8jgEGKpFDSerWCaFy7/ZkPNm42q9g7vw3K/CFL3oB9vx05cRzOZ?=
 =?us-ascii?Q?5zkIUdZ/O0ppc0wMpipwi5k4jsOhpCrxIhPz1Q8Ip/XMUVABRzoERgoLolKg?=
 =?us-ascii?Q?MQ323h44omIrez5hDQrzkus7FfMeJRQCu0Uztc3S3aqOFSBU2rkeN9HrprRX?=
 =?us-ascii?Q?95DJ+dYZTnfNQBH3TkA8a3pMHxscYi44A/gJxmk66EYyKPo8ucECAVufTSXL?=
 =?us-ascii?Q?4wAPHTsdKIsVgEBnWlWcRp/+9LTApGQSI4FmgWttABUUjXdjwqpn//qssFGt?=
 =?us-ascii?Q?smlpUK1/acB5OXBTjz5BXjg7+qCeHyQ+vuYXt1Yu/MPeaYoCKCFRtVoxikeN?=
 =?us-ascii?Q?88XuJiPnzc32vzkZN0+lwFDKrql5or89H8+P5X42zIXnxJmj+t0/yHGpFjHk?=
 =?us-ascii?Q?25roARfc/sWT2D7u00iYwsVN+1yYbOwBmVNvhnO3aTTWycVFIqJZ4jrJ8Mxz?=
 =?us-ascii?Q?o13CJ2EpvpK83SjqiF6EEtoESbSw6v69LJfQl5XbJ2up2tR8uZVtA0znlKPA?=
 =?us-ascii?Q?T0ElwA/rkVw+K4//JuzQ2yARRj9HEIAKSFmA2L28ZOHEuHrB/WMhPvzToVcX?=
 =?us-ascii?Q?Gs9Jyf5deEyIMrjBnOTR3ZazPMMVsSZXaFk/2ReIJQvxVA5yfS1K5tGl4sNL?=
 =?us-ascii?Q?yWb2Fuw9JRQNtbQI0FOlANSgyOymL1ZMZExpOkJ2dL6i/b/ADby/mSRuv2Kw?=
 =?us-ascii?Q?6ZvvwhdEdo9vkAM9OZ00RBHpEMuJFSiU0gm2MDG1zIf0c3hnZzvR3RYclSX1?=
 =?us-ascii?Q?e2zeaGoUDB4sptkvK9oSLV5yZdJd/Yp+WudkPbl3H4qjqe1f7DSXG0tfUBYd?=
 =?us-ascii?Q?n+m0fo/g6OQN+7yoFazCIp6SiAUAiWW4gjX74GvX4y2RMoOBw5aqPF9D+Fl6?=
 =?us-ascii?Q?I6wNYilvV5CQ8JYiED4bAKKInr6iAOZutT6fC8BdtqT+IYyT121DISzMdjgy?=
 =?us-ascii?Q?YrSUnE3IyDxloRPzezI8J2ZigeBH/GSgmCIPmG7i/oK9Hq5VpUXUzj+70+3T?=
 =?us-ascii?Q?1qDSri/77xWfaQEsw5Mt1cSKDUYW8gQOUT6phkC2Zegdz2VDlEJVEx3DD1/v?=
 =?us-ascii?Q?FhRYE4+YGYD1SnxWFukrVgodA9EpOGyPE+81mxBbdD2CtqgCWwWFr1+0rkCT?=
 =?us-ascii?Q?o9yNWpOsNsfogxKnYGz51b2ACdaUUpdbJPPNHec/opAXp+WJjiRog9oV3D89?=
 =?us-ascii?Q?NXBZ25Mjw5U42loX9NmOF8DW1mpeXyfhdGjHklRVK4rrelROhUAPRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:02.9997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8be0da-58df-4ef8-0c5a-08dd4614a494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
causing some regression on dgpu which still needs the
pre-emptive return, limit this to reporter asic version
it is simple to include
different dcn versions from this point forward, each dcn
resource is initialized with the flag and can be enabled
at will

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 6d163dcecde6..ffd2b816cd02 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1909,6 +1909,7 @@ static bool dcn35_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
+
 	dc->config.disable_hbr_audio_dp2 = true;
 	/* read VBIOS LTTPR caps */
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 4a03df5d760f..98f5bc1b929e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1877,6 +1877,7 @@ static bool dcn351_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
+
 	/* Use psp mailbox to enable assr */
 	dc->config.use_assr_psp_message = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 64f2153310df..4e842f29d4c4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1923,6 +1923,7 @@ static bool dcn401_resource_construct(
 	dc->config.dc_mode_clk_limit_support = true;
 	dc->config.enable_windowed_mpo_odm = true;
 	dc->config.set_pipe_unlock_order = true; /* Need to ensure DET gets freed before allocating */
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.48.1

