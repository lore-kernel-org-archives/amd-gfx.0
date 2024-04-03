Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE9CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D614112E98;
	Wed,  3 Apr 2024 19:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRYyFKZY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980A3112E90
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i70BFogqILW8L7pcm8ptf1CeC0j+hPvCYcNsGU4O8E2KJqMyG2GblSLF5t3nn/KGlNr5Azwcb4y/cGv3rIgUsa38FvrrqeC2thBBAlUbud1A7pOGcQIpQapy2DXk6LNjlSXlz3UZ42Qct+9s2EWGG0XRyZ59lUvIbUdHoBHOW3sjpW+SPc+O6leyj3IArYyjsySTRT1xSjqKlJIqdnHMr3BvdhZygdAZWSrpoqzArAFiGm/rukIhDcwV2RODWdJ8jFRoAWpRJdXYJQ1KEBJ9i33r5BTB7BH8xGJsF+hTDm2iUtqCRdvrpurDkoXH/Yz95LoOilyxjgUFnzM8IjYXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKJ2KqWRNDvGPICaTHhCDgT7epLQsg9OJ4FOuVIifZo=;
 b=Zx8pNaeCoqjdOw1yvCK1Y4kv+SKbLA+DMPwZQrAXitJaXsoj0x8Vo39FVftCiHhwKVV4nf4Qu/upsoS2G3T6gcGbbVaJi+gVfER0cN9brYM41hqPFF8Uroip2JSvugXBu7S9JBbd3BBvhaaAQS5wM0434TkDCqhQxQyYr/mqNDg29lCGDivOqO6SvCrQmBrRgDY2RQ3hrkbYMeK5Tl7KCA9yguXbPknvzAwkrmNWmUj3fUSZ7xHMyFcyInq1UF7OpFbr8AOpfofBnmmhmY5iAgisXkjaLV3WVDc89yoD9GL1CZjtCFA+FubAgBv6LeMeA9HEsN6qDM/MGBmyFpcBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKJ2KqWRNDvGPICaTHhCDgT7epLQsg9OJ4FOuVIifZo=;
 b=gRYyFKZY84bB8rnzczogJPJpSJnKBif1hG+GjVUsFN83Z5deUd/Bd7WwhICHTiOYTtRP1i/E+WsSHbm8DowDdL+wLCeJAQdfW0T/KYayLiqHZ6gir16oLR9S6BINkMkMCwDVxTd2dcqbXEkEdq82rp6l42m3ZvZfpvh+MMLzNxw=
Received: from CH2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:20::35)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:53 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::b2) by CH2PR07CA0022.outlook.office365.com
 (2603:10b6:610:20::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:53 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:49 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 21/28] drm/amd/display: Update resource capabilities and debug
 struct for DCN201
Date: Wed, 3 Apr 2024 15:49:11 -0400
Message-ID: <20240403195116.25221-22-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: b166d4ee-95a6-4f4d-535d-08dc5417828b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CyNdivpuPIGBqvdRk5eiX7KcU2+626GcR3FF8jfozKpHC29Ihc3Tbfo6dCk1JXxPCqm3yytrcwN2Ds2v1hnfkXRr4e74W5bJdPpNnClEVCb98zArabnukCI9TKOM+Fv9pFy6+Nemrp3S+Jeo3HosUFmu8B7QxETkfpgIg0Eu2UyoA8FOUqa1shpUVN821eSL27XjQd3v15sFODoZ3tuqabD7Xhe2QfwA3dPi6w31y8Qh8bH2YmwD3RBFp4s2ndCYjwP/xnEW3vUchxFn3eioLKSrcoQx05xfTfmUE0465expskeC1Z3p9+W4+upNgfAY/AcQOn1mRCzbCbRzAtsEAo12808HaZ0+25KUZ0zTEdkQk9Q1KzukYx5NaSFCA0WuPa+s+ai1A1vZ3cB14tpwPieV/sRerzTTAi4eYi4G1aXZe9flPVCeYibgAmZ6PjEPQXRoT+4GHt2qWtJ0dfxkYLpd52Qm+iTH/ud35e6HqpMMjmVnJnUC7kj3Js1MgNu6s2NnBqfhNx9C9hpz1WMtLGaczwKtfPJxtV8HBPxNr5Dcl+YK/9j018xSRRw2KVQs4VsGiHLs7ZZGoo1fPPHwSfKdARErIBlztB9JpOiZxssjDYj0I0K3bmADEcafZH4GXeumxvXjMpO6hfKuKoTmR+LrBgUNwUe5UGCE2YiW09d486F0vpk9+6+mylnLmj4CRdFW/0Q522SNvTX24lkgRKqX9aHajn1vFPcskiS7301K0mU9B1GknjRZRQQABOU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:53.0292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b166d4ee-95a6-4f4d-535d-08dc5417828b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Some of the resource capabilities for DCN201 and the debug default
option are outdated. This commit just set some of the missing
configurations for DCN201.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index bc65f82b111d..070a4efb308b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -566,6 +566,8 @@ static const struct resource_caps res_cap_dnc201 = {
 		.num_audio = 2,
 		.num_stream_encoder = 2,
 		.num_pll = 2,
+		.num_dwb = 0,
+		.num_dsc = 0,
 		.num_ddc = 2,
 };
 
@@ -612,7 +614,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.enable_tri_buf = false,
+		.enable_tri_buf = true,
 		.enable_legacy_fast_update = true,
 		.using_dml2 = false,
 };
-- 
2.44.0

