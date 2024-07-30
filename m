Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31881C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 04:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F00710E12B;
	Tue, 30 Jul 2024 04:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuwa/beC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B129B10E107
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 04:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUzPcCtLRw9Ro8feVNT/HYp/iUL5IyU/XGDwGXDdyPLWoFa3U9J1f/UtSFmTyuKVG4ur8dzBr7nEWYCTIzQYwWSBDbr1mjqGWWCCvREGGTmpI8QyVdaG7ZPl1E4SXH6tvhEjmL9S0fMRATfUbuY/s5ZOohKGt+84RUfM2yFU4xJOaTNYJu3ZlEyLN0FLM7TgLRWPEkkAPg6M8+JmPnRPEkkPjHsLp6wAJDQJsGR/AuOUlHRZSsDqd70POdS1UDe3SiAUiq6fi5mD9CBqzwmlhNAEyXQDv/8K6imE1WBhsTaoLd0NQz4ogrfidcwY7jZozng9rMCaVaZxMg8MoUiHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qPwK2x3M4MWAcUpW43rAY1ldjbWYB2/9s0HsCkv0+Y=;
 b=Z8jRF9R9YSbgaoHTn5PWXLKQc0+In5nLuVdYq3yFGKP3rcfYB5iBdeBsfSrE8lD5LLJ75A0NwaDKbuAPbG+Ty2iPmtaut3ERIPuQWYcMggTEbdl9OmDfgP6tHLxy0u8VXL7fPcG/nthHkM5iwjnu4faw9XO8teQdj0DD3b8aXoLPpLd3cRkbXL0xwZZgGrfD9WJLqtd5lKvpWpJkFGHLV3dkaEhjAuFHYJe7+CZN7N6SzS2lJ4MiXnXLhHVsktjApRFMH2D4rgSC4K9y6RMieyQBYQ+Q/Pow/CibMYauaKkgzGz7g9mvwlX2rMm0xjvSwg0ynhKN85n4HVXC/oY8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qPwK2x3M4MWAcUpW43rAY1ldjbWYB2/9s0HsCkv0+Y=;
 b=fuwa/beCDMzbeZV4ogIKVAbWnl6YfIearhmdC42jV8nr5S18GhZd05acUSkUctoSbm1r4ZlF73xnVAaD/kxd6JSIoOXSFFV5dzB7AxgPJ2GMwDNf0mn/QMXjZIcE/hwRb6wSwKHwOqnRifdtMbOxcp6sMtNp1bB+HvFEg06BhHA=
Received: from BYAPR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:e0::39)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 04:11:55 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::15) by BYAPR05CA0098.outlook.office365.com
 (2603:10b6:a03:e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 04:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 04:11:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 23:11:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Align 'dpp401_dscl_program_isharp' with
 actual function parameters
Date: Tue, 30 Jul 2024 09:41:37 +0530
Message-ID: <20240730041137.200169-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 84979a0b-ecf2-4d84-a2e7-08dcb04dbf87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?33jVfatw3ttaMnjunuLEJoynJHwLNm0Tb4qQv47SF8mO5dQQzN9i2oeQ4cgd?=
 =?us-ascii?Q?Oy+3X3Zw6fSUXKpeV2d8SZirSXDVMeJcq9J6tqVlQ8ei5SD/36hqj26qWiWB?=
 =?us-ascii?Q?UpSHwBur0loaDrYbC2PzuUIOwwDImeyweGJgns/RB4RBRrALtyXKxtgUFDzY?=
 =?us-ascii?Q?DREF6Fc/BpbQFJFGZbXc7tzgzN+bzom1kXI2DS9tl40wp43NUMmqJt3OvBY8?=
 =?us-ascii?Q?SD6BIrfpFrhhmCr9z62sg3+NLMC7dv2g+pP21pYwCkLPoCnCrFZoH7lqzBfY?=
 =?us-ascii?Q?0sDLPp11520cMIl08Qg8Iw4nisU6gGK9f29lw6yszYge2qXuQHlMEa+4sbdH?=
 =?us-ascii?Q?zQipa69xh1fpvMHw0h4juuFDWu3TyjGadpuUV7/f+W4PqTQN0cZ9pkziX/HG?=
 =?us-ascii?Q?IG8xHtySzENvgyHw1hwnuPQWLrk+TYfkO5+JCzGj+M71G6vOg/f7YfP/v5EW?=
 =?us-ascii?Q?W/+L7400tDDQRHX0K+AdTez8xFKBThcEtRlvMuwyGkv3eYbNc2wIcXfAENau?=
 =?us-ascii?Q?YYMZg/P/SAWgycMXAKe2vB1kQycORVd7NkRSdE9qgB++4m3XgVXuEr56p1EV?=
 =?us-ascii?Q?gFgssxQ7gTyOM+9/Dmmi/Wmr0zaNc8HVYvcDgXPvltheGloC0k8+JPzvpfWZ?=
 =?us-ascii?Q?zvy5yRdoD6GPjMw9G4lIGbboFPeNZ6BlwtmvKXOPvIiDHLijz0+1Ur2MTEIR?=
 =?us-ascii?Q?lbnZwlLjjALoNsB8dOrF69F5R1Qjk1Bsmui7qceacbrn4nd4DEZ9/Wn+rqxx?=
 =?us-ascii?Q?4J9c4a/ZmkqbRmyYidT09KRiRzAZBfINgwhYRNQ2rVrv15wiKB8c+F8/jQMJ?=
 =?us-ascii?Q?lPLjVn/Z40b0eMSfNvLb5wfnI05sdqoITBmvfct8VYWw2+nfUNVbStp+XFdq?=
 =?us-ascii?Q?ZMLRr/vhhtP8f5N7yc9vv+93JlaWsw0AOFHIcpkQm/mWejx/8rQ4W6F8iRn+?=
 =?us-ascii?Q?kAdu1456gVzFZC9RGvRi9UZLKkrQWSCSUCMNeEWdnF2SU6qgBlEQA8T/mt1C?=
 =?us-ascii?Q?jCejvDMxnrL0CUAqYljYRqs+QBu6xsWlELWSOawt1OmYC7C+WMRsg58zDJfb?=
 =?us-ascii?Q?zX2boJI4noISOD/lo9536XE7HOoLH6wfhcSBl84JHUjsUSWlUn9wG2fxGym9?=
 =?us-ascii?Q?q7IshHaTqV32SEyCH+MST/8IJEPB0weWtnjZN6l0IMNNdrK6NQgpknXsso4h?=
 =?us-ascii?Q?/7+G2wHtAOk4xbH4mrQ80pJNh/kiZ7wlmdvSS5LovsDhNH4fx3oEuXpjt7s8?=
 =?us-ascii?Q?HNa6Tu9VYgcW16BXkFlmQ//lfORGDNoK/kLngrKk2LLRuE7X4+21xXdqNehT?=
 =?us-ascii?Q?SJu8LbYCdBn0bblWDIEP9X//5HSyiT7w5ClMpd6PJk5oXomwP0uY5hRiw+NM?=
 =?us-ascii?Q?6gAX53n4p7mgIUwg/HXezv+4eJB2tE6uF0FSZ7PjGc88icWdmXZdlN5naivI?=
 =?us-ascii?Q?g7kmWim6pZGJm71Z25+l7bgTkBRDmbl6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 04:11:55.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84979a0b-ecf2-4d84-a2e7-08dcb04dbf87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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

This commit corrects the function comment for
'dpp401_dscl_program_isharp' in 'dcn401_dpp_dscl.c'. The comment
previously included a description for a  non-existent parameter
'bs_coeffs_updated'. This parameter description has been removed to
reflect the function's actual parameters.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:981: warning: Excess function parameter 'bs_coeffs_updated' description in 'dpp401_dscl_program_isharp'

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 88d24e36fe00..505929800426 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -971,7 +971,6 @@ static void dpp401_dscl_set_isharp_filter(
  *
  * @dpp_base: High level DPP struct
  * @scl_data: scalaer_data info
- * @bs_coeffs_updated: coeffs update flag
  *
  * This is the primary function to program isharp
  *
-- 
2.34.1

