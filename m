Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B0C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEFE10EAE2;
	Fri, 21 Feb 2025 16:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RPKTfJ7I";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830D510EAEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9M3rcyoKrD6oi9Y4p20BAcGsJ+73rqNb4MtjZAdlzd0ftPQn+H/Ybv3PD7/Ztx2Vvd36pmm7JkiBWrmeGRSyidsGxzOA4XTR/BczXccKTcJTSwhTopeJ8Ah0A6ihyPEEuXytbSoDSaERlhMMaCExJK5tc+0/Pa1urrOPl8zvZrT9pmqU91eKL5oiY+VL+K4QaEhZG8ltJsduPWq6vDUMrO/hNoP5fukliaibfrOvhQLlhsWh0do7TiUP82d3KDOxiH+X8zijtd4Xf4aHnZvMC1CA4FHG92Gl3nO2AiY5/lROj7Du6JeW1yakakYvSXVCOnbpIMtegBxkqcrPDnCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wzn+GUmhjvAbWy9bv4ZBIwJEay5MVwgRVJ+c2rcVKI=;
 b=sUa8YIFBvcykZI0JMWvzB26oXcXyNUc8ZL0bIzYnujGL8/sFVyK99vDVekuD/DS/0Vte4/Z0MGlC9dVYsPpz3NWpOh6x7+WGZ/zbs1B41h1252ng6g/YaGwy4OFW5z0SR29JwL43f9wLAkcIIvX6a+n1BAC2ttVlLVJ8b2Vd3fwNl3GTq38WmNhy4egH2p4W94JHraeowE7XSk9VkDfVyxYB8gcFhnHLKf5cw0HOC5GOw9nCPlpFzd8mmsfSSR2aho5VqCYJLD9dkv51oUZV070JKd+Hildhr6iOansN3tNLOcM551igkNyqxx8b01zbcb45ROwO3B/7xqotzJgS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wzn+GUmhjvAbWy9bv4ZBIwJEay5MVwgRVJ+c2rcVKI=;
 b=RPKTfJ7IGRplkSi1KTJ93Nq4zxWbuZM8yfyLG65ej9nDruEZ55UsVuDsLZf2m8ty+LrNVPFL14H0M+1KpQCdl/x85WjC/UOYhW+z4RmrKQ+m/EbCF7BZ71L83XetLE0B4GWBhoY9J5ktrWU3Ff1iC5eKKOicCOrtMkN1trbkfU8=
Received: from PH7PR17CA0058.namprd17.prod.outlook.com (2603:10b6:510:325::7)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:34 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::23) by PH7PR17CA0058.outlook.office365.com
 (2603:10b6:510:325::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 16:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:34 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:25 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>, Samson Tam
 <samson.tam@amd.com>
Subject: [PATCH 18/24] drm/amd/display: handle max_downscale_src_width fail
 check
Date: Fri, 21 Feb 2025 11:01:39 -0500
Message-ID: <20250221160145.1730752-19-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: e0827592-b52c-40a6-ee4e-08dd52912794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6UvqLQZQQoOpvqMUHmHQEhr4w0weEJ49Tzc1f9NqmR5OY9TtBpdd5Hithg6?=
 =?us-ascii?Q?yNGXPNexlLq+MKzc5EVZnj3PznATGaaglfrUJDOkGIzioVOdkdD2s4kpZSZ6?=
 =?us-ascii?Q?L9qZkwkC7KQzr7O6YoWf6kwMeWrwqU1TzQXY+S9SEOAIqnn6DdZGJM9vFDmz?=
 =?us-ascii?Q?mjDqsVqIvIS5zXrlwKao3v29PYKYYSs2Xxg5vquIqHkfylRnbvywInsW+xqu?=
 =?us-ascii?Q?s8O7U/M4FZstcQut+qNMh6jVzgwwBDgX6ZbT64gMSl5zKWiwHUha1zRCeDVh?=
 =?us-ascii?Q?8wCTykhpj1marUnJKmfrfJc3Qmdr10aQ58ZYTMgO2EiYlzMz4kvcVoIjtZw8?=
 =?us-ascii?Q?NbuxFn5Gm29q9tE5VQ0xmZf8hnWLAlrTBBGSzHz2DOsNpXMQhPktcq4xdwou?=
 =?us-ascii?Q?tBbp075MIQjMlJckDV5oDZAYHbiR5rLepTgAzKXfyhDJWw8oHuH6ElAzvgEP?=
 =?us-ascii?Q?jXC24NvsQDz/JvpJoWv5Stnck0Y13VWi7Xy0l3zC2xRLBSvLI/kcAgcF/ifx?=
 =?us-ascii?Q?orMG1p5meL2NcwoMyiezS1Aw8J7pjOIyWuKgKoybIGG/44CsYOAJTC1uh/rL?=
 =?us-ascii?Q?+IT4+Mqv5PUix7hUBaACK7Y9+KxnXczc8SXR+4yyhm3WS04Z3E3pCadgsml4?=
 =?us-ascii?Q?DbP32+i2H/Ko3YjjxddT5VsrlGjAAzmzDSVTIOVrH0WGRcXNZaAnr37gAy4F?=
 =?us-ascii?Q?LmWHqj523g3bl3uvXMo9orGEG4tf6IJdQdcoQqFTsnOWdSiSB6t5AL1h0Jz7?=
 =?us-ascii?Q?4T9utBTDuqaRLFqGl8IyAR9Rh33ZJcqg/vDh33588vxOXRJgcHThdB+szxLq?=
 =?us-ascii?Q?3E/JH18Zwi8+G82DTuLz9+h1yfUT32K+x/tPNaZ36Cka0eG3e+lUv6J3U/6x?=
 =?us-ascii?Q?aPQDGyzhG1rayljBAdgVLL3YQ8qBca5CJ35bNU/8Yx5FFYzkhAFYLlAizk20?=
 =?us-ascii?Q?22ouZ2iqnNrwwPv2JuJzCRfbnCaxDxHELy2gSZVLYw4+myRJQmcND+GOv9T3?=
 =?us-ascii?Q?mTJusqDuP9QdN8jxrPmxLFCDu1gGZv4e8PpA2I0ndm5ZNbVxJPZsQBYRqAZY?=
 =?us-ascii?Q?NSiSQFQ2z4ZpQG3/a53cfFBGQyCEtu07JZKGU+iKPlRTLrmQKMjtQV1Q/CCe?=
 =?us-ascii?Q?RUn3Go5UkjbJWaNu9tNHPsRHIPGk51M0/RNlw1yydxqV4AGrYWLogc7tmzMx?=
 =?us-ascii?Q?89pJn2/lX0zHZ0+nqUcqIZilU4Xug19pE9xJ+KZpZdC4YneOVze+KGJGbt/T?=
 =?us-ascii?Q?6rDo//kL33QIETXfyPRiXOYd1dcm7HQ0hVn9AxYF5r57drPvWMaGF/nENWmf?=
 =?us-ascii?Q?J6QPE8gArz/3QRfZo7XJv7AzfPCxKEvx0u8rFEIim5BX/S17A93ylQu/PaBn?=
 =?us-ascii?Q?2aYwB3Q4gEgNhMxJApk7wdbTE/xjhJhZ3IreIW9QKADaWjAWJPb3pwbo4/NQ?=
 =?us-ascii?Q?Hk1J8gfePyYAdP/efASON83peEqqbZ7xExIO9rYmQapV3vDnSR73Ype6VUDR?=
 =?us-ascii?Q?/jrAm+HJzboFn7U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:34.2723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0827592-b52c-40a6-ee4e-08dd52912794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY]
If max_downscale_src_width check fails, we exit early from TAP calculation and left a NULL
value to the scaling data structure to cause the zero divide in the DML validation.

[HOW]
Call set default TAP calculation before early exit in get_optimal_number_of_taps due to
max downscale limit exceed.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 40acebd13e46..abf439e743f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -425,11 +425,6 @@ bool dpp3_get_optimal_number_of_taps(
 	int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 
-	if (scl_data->viewport.width > scl_data->h_active &&
-		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
-		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
-		return false;
-
 	/*
 	 * Set default taps if none are provided
 	 * From programming guide: taps = min{ ceil(2*H_RATIO,1), 8} for downscaling
@@ -467,6 +462,12 @@ bool dpp3_get_optimal_number_of_taps(
 	else
 		scl_data->taps.h_taps_c = in_taps->h_taps_c;
 
+	// Avoid null data in the scl data with this early return, proceed non-adaptive calcualtion first
+	if (scl_data->viewport.width > scl_data->h_active &&
+		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
+		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
+		return false;
+
 	/*Ensure we can support the requested number of vtaps*/
 	min_taps_y = dc_fixpt_ceil(scl_data->ratios.vert);
 	min_taps_c = dc_fixpt_ceil(scl_data->ratios.vert_c);
-- 
2.34.1

