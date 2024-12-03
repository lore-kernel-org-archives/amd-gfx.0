Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37863E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC95910E111;
	Tue,  3 Dec 2024 21:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sn41iu3x";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191A910E111
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sptYw5Colq5GyIHGIBl1KppVuoNesXNNUVmvPWz7jzVvX4ZHCDzfGaSxdqyZiS4fheeFppAZh/0mYpNrzhn/X6ZV5Kds2JUK+vUp0PePjykbNN1mx5J9dhKVYniNC0hppVK1uLObojCdwyCB2u10fAu73MJFhKmF+M6p+gcEExTwOgDuv5/yrGtt5MkIS4F+uifY66WK2/2jqJ105Nm6Lkk6XOCG6AKYqbfeFsFWAkKWNhKp6AXjzag0i7iPQ00duGmFreUkh848I8EfVYvKzcLovckIsWUthWIE44NisvqEmwYbWBoBoXk1z6GKrpmbaq46WmKMRQhVWHCuwEuMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGPXz1sn8kL4NnJh/df+JTpQ8kPyiyAmE1MpJbADuVQ=;
 b=ppFY86IFvE4Br1XJpIZh9d8l4XeQGKVF9s4vjMRyqRSes9JNL+WDgCzk+v5kH+Fuz8dRBZ2TnPP8lVMNmFP2igh2e1Y8lpq7hbDQskU1WAmFJZIDfaSBO3FZufzwhKKkzN5ZSBfU/ZzlriP/mJci2z/vm/7lrOfExjdXMyTFScZ+onr/BOqmo3Gy8eTGoc2A6CC4ZTOG8AgxOmf1wKQe+ebC9REt12pykMmFzn9D+Pji9oRZ290iEPuJo2BPoNfiUqw1qiGqwlcP9g4W3LkU28V/mCMKxIk9/9x8pAgwU91hzrZngC02K7TjKL44+z8buxKNE393Ahsykx/yrvFM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGPXz1sn8kL4NnJh/df+JTpQ8kPyiyAmE1MpJbADuVQ=;
 b=Sn41iu3xte7NEcWyUJwLSQOd1S2daYH5xs75eGZmi0dqL4Z3bh+3zCdhZRZxPgUIAAPhMiYEBtLZhDX4PPL1nXuuaDOiywEfy1lM0bm1RgaGZk2HbjO3xAHaj7MuIWXUKjPCEqKCokc5CNVHyt3FMoXG4RkH8AMO/dCn3eRIslA=
Received: from MN2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:208:178::28)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:22 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::5c) by MN2PR19CA0015.outlook.office365.com
 (2603:10b6:208:178::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:21 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:20 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Harry
 VanZyllDeJong" <hvanzyll@amd.com>, Aric Cyr <aric.cyr@amd.com>, "Iswara
 Nagulendran" <iswara.nagulendran@amd.com>
Subject: [PATCH 01/19] drm/amd/display: populate VABC support in DMCUB
Date: Tue, 3 Dec 2024 16:39:39 -0500
Message-ID: <20241203214120.1161810-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 43725383-7dee-49bf-7f35-08dd13e33ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V1ICKYqXbK+xgjM3ms/CwxKlFYYlNs3wW8yqVME1gqGfVZF7eESu7ahcV8Vn?=
 =?us-ascii?Q?Dvs3GiD04dFEU3UwL/U+4jBPW5+OAePF/4GMyse/Uu3Hbb0clQ9cUfeD0w5l?=
 =?us-ascii?Q?vwdpYy3udoN0Vr1D/IluJ92i32T/xG9OCRlmiYPyHwimS8g0yTBm8XAhZ2JR?=
 =?us-ascii?Q?y4LVKHR4uazQ/3uBWyWekchw9l/mcoACxHu9y9TLTFjMEgxsmfNfAwQMS31C?=
 =?us-ascii?Q?Qu8gyNn+r60m0noGBGlkDpoO3OSrEpYQv0+lhjaAoSnH3ToZQxAaPQxcpLyj?=
 =?us-ascii?Q?/mgOB5JVA4wDjvBToF1S3eGLb0f2Ry+SHsEXjlldV0n/jMcV1OmbrGQ1LFRF?=
 =?us-ascii?Q?Y877LWkJg4pJrQh5qvAroYJS8VkXnsupuDjJWEoVbIv7kBti6XWNVZ3HCyWb?=
 =?us-ascii?Q?/EQtxzJobNw1sGKV4DJbKkJv7JBbcQ9ivskZqLnkW1tMooDeiUb3FwAHzIgh?=
 =?us-ascii?Q?dXNr46E4Ty8si/drzE6VvWHV5R4aHYJyB5x74IK7p7haTSthyh5XHx20iCH6?=
 =?us-ascii?Q?IXMgs6IBvpI/ArQXGMCToRPWmzxHqZp85LB+9GM3adRpUhz5OMySHxxTzW1Z?=
 =?us-ascii?Q?5S9H3EOyDyIGQRJc03Lqy7X04J/3qVeQqptu9Sj4Uc/9Gh86LAk0r5OK1YLA?=
 =?us-ascii?Q?kveri5I7xboTdvaG5sBuVZv0CEZWnuXK7apShF2oVTOFn4AnxAvihf/GjjSm?=
 =?us-ascii?Q?DBPw5lqe2b4W4FDXvYk0t+mdqXEf93Niwujz0jdHZxBThxI6KKR2+d3msp+Q?=
 =?us-ascii?Q?aBGKQ6NnVAXLTHhWvk86S6HpNkFKxb9uDL4vqPA3EY4egxUxL2etMFjidBkf?=
 =?us-ascii?Q?dyTb4dzoTxk8nQCgWCFRlUz3FxJ8XvKjYUNswfLknkuwODYlx6bdjAv+7AWa?=
 =?us-ascii?Q?dpKtNGwt7BLCcFu7jAoYmBap9PZf2sojaFod21+OZXJdp+WXWzC5JR2hNHzP?=
 =?us-ascii?Q?wWouDIs2j8FgHf5cu+1br7Jys54xCSwqFvV0zcDWSTyz3cJmpENPYgMRGtv9?=
 =?us-ascii?Q?u11/doigy4KLEujODvDTIJL/FF9rdLK9j27ghx6BhmzpiaF2BGwycyNoMaCj?=
 =?us-ascii?Q?dEny/Z8UKVVlJK4G3wsVrx74CLybwFZJsnuveY+JtqvgU6FH54obQtt8OdMs?=
 =?us-ascii?Q?fEzywnEP2VEIyYG4FhHKI2Zk/sg3uVNuyuDaox5bqaVShucY9brl2IhQTrkv?=
 =?us-ascii?Q?1M3gxAv1f59/9d+BPx1gqYspLkWa6qMM5lR/mbkWplL98dAIlrwAtMyhrIU2?=
 =?us-ascii?Q?gmTaSrF7p7H7+O8aaKuotSYrQRKuWM2ywNzfrpKU8RwkHf2v2jviZLDEPUeF?=
 =?us-ascii?Q?FfXLwF7oAKOm81M/p2jTpDZ0Zm3yBGot8r+PghTijDVPJx/YsLqMhSSBpcdm?=
 =?us-ascii?Q?bxS3/Egw74HEcaDK4i4dLXOovtOEED5+00s6pDdHSBliwPzMuAas9ekRYr7t?=
 =?us-ascii?Q?6UjtSpPwdJrfBiNbySh5sCQB7s4gUCwf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:22.1336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43725383-7dee-49bf-7f35-08dd13e33ad6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[HOW&WHY]
Stores DMUB support for enablement of Varibright over VABC in DCN32

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index fa11f075d1f9..2e6ecf939fbd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -985,6 +985,7 @@ void dcn32_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
 		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
+		dc->caps.dmub_caps.aux_backlight_support = dc->ctx->dmub_srv->dmub->feature_caps.abm_aux_backlight_support;
 
 		/* for DCN401 testing only */
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
-- 
2.47.1

