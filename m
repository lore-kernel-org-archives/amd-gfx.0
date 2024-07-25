Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7914C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACB310E73E;
	Thu, 25 Jul 2024 18:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XFytJDWU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7734110E313
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jlqdc4w0YWSsnNtKKQ/JwQHYnGZFoo6aPbqaT8PTz3zz9fHOY5/IX1baEKSjM7i6HBalnL+jHC/a5qY8Yv1VP8wftz9jrL+Wua8zKRgfHL/XoOKpMvNqhhF4L8ZshR9M0eCVBF04lGdwyxd5KGDHAR3qAZzKyzHqbCgTiYhIbhwgRZYy28iEAhYgX04Hypc+J+qS8B9oBXdJRF2cUIIwmYPgLvJlhGdL3JsslhPzqcuq3J0ijqn8j4Cxj3hlOCQoNBgokOwGah8dFxChoUs4EBT6BJwyAtu2xFSX3FCxc0nNEqrf0ugKzI4pb5Ers66V7hNR3TqjoOehyAwSdEBBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o56B8mKOgex86ZUXYCWLYE3zgez4f/tEFhlnpi/V+aY=;
 b=F+FWj3HIr6n0OXN0Px69pvUMDFQ7dkIBB6OG/rn8jQZem17hq5j02yJSkRMNoSzNHt3Ufh91IyZH+rDizLHphJBvxCaSlruSAal9wcWcl2Web6PAlroAOXozF0teKD4kY7lvXL4ORi96FAGdZcMQJ9Dhb5XAmi0odKpK4PZ3Ndo+pOseK/sJmSpMFAxNesd1RbnFjBajdF6/wLz03hELKEOStS4ie97pJti37WRGSC2H0rInzSlCW7SnqBgD5NGBylDuv+KATcO9x6KgCmJa6BP3F5RXkTRMK7nID3mi5fW14+pzQMTzU5Mt03IsodFJHSC0dDMY/7X6XaxclMcOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o56B8mKOgex86ZUXYCWLYE3zgez4f/tEFhlnpi/V+aY=;
 b=XFytJDWUGNSuQ2ru3i23cDCvAnROwqCady/Y2zFyk8hMgbR3HkX5QXc/WPRCtEeL+dieICio0TLC2RTE5+CtAP+8JX/mIEq4CLDBl+WfxhHv7rzEr5Ur0Z5HgIyzLG/YJGH96SAevnP+04o8jSZiPZZApfUhcxdF7Rv5DeMTUwc=
Received: from CH0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:610:e4::33)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:03:44 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::41) by CH0PR03CA0208.outlook.office365.com
 (2603:10b6:610:e4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:44 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:42 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 05/39] drm/amd/display: Request 0MHz dispclk for zero display
 case
Date: Thu, 25 Jul 2024 12:00:49 -0600
Message-ID: <20240725180309.105968-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee58f66-da1a-43c5-ad81-08dcacd41fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ugtWysuzDjLT1B2RaP0we1Va5l8I01h4qf5S+XM94VRwxOndzqaeu2dOkWUQ?=
 =?us-ascii?Q?K6auHCBemRl5aGGdntdbo6poHGbZ3hgxYqKGaCVgMwY6t9xOkE87hacV3NBh?=
 =?us-ascii?Q?RGBf6pyS+httiO692cYpQHNaS53PIIbkN2qXvygZDvJR5ADfq6eei0IYbFJM?=
 =?us-ascii?Q?TsbYNbafJ4yMzbQPTFXB9tzatC+/tj1tgXg6BLMbvEcNVlx7jOrXq5+Tojfm?=
 =?us-ascii?Q?yh4Q9OMW5y2d2yh9kkfWwiPQfdfKDrD2uYgw7RbPCMaWdelRYaMBZe3ga7sy?=
 =?us-ascii?Q?JbF73NEtnL8tfAOmXwi3Fj2CTvl6tNm2lU2nJ/MUk4+FouRzw/x5z/zv/ULZ?=
 =?us-ascii?Q?g8ianU6tGfMGlllLaaMVFnByjgR5/g1XKNJdmr0JfM37BaDZ+dOr4J5vzxNI?=
 =?us-ascii?Q?A6nL4WXixYXQ80Wqla10PZowFCCYYx2XIHwEU3Hmi4eYm1VlbjKxhgdHApGe?=
 =?us-ascii?Q?f6HQ1F2wpYaHgiwdvUBndRvKG0igIVAdhHt9Ni07nT1rTLwRY0F76Hz+IHYF?=
 =?us-ascii?Q?QuKWfejnhBbFbKw6SxL1fNYr110tFOmkcuSGILLIJH7eXr8MnNZgXo+AVzd+?=
 =?us-ascii?Q?65lsZdmEQlgVtQwMyJqy0X2FlO4f5ve3Th2/giQh45tCki2/kIr5KooNX37g?=
 =?us-ascii?Q?QNGQOAcQm6uuLncxaby10SZJPDs+m2envfjSwTTRfZcfvoWijwtqatP6KUO9?=
 =?us-ascii?Q?HCW36g6oYfPElO1kzI1d+EcGcap0LZrspBBL49Qk0SxY9NZyFqWtFaWVPndM?=
 =?us-ascii?Q?S2+7lnVn2Pf53zuejYo3OQSSCv3vl21EuEg5l5xEVcnfJHoLc92nkWRNzMDf?=
 =?us-ascii?Q?Fp1EHvDoXZndUlm6wAJO5UkDVFXXfPJ22XELNt9+jRbwMeyO2KNmS6x42Izl?=
 =?us-ascii?Q?A9UxE5wMc5WQ4K9TjgxY7hILgZBZ2aaRSev/vRxy7bguL87moFairYeNKZNZ?=
 =?us-ascii?Q?JGYm3JI6AStsoveSYfnJFdyk5zoPIIXvOFHoPKoyACBaKdP8dP2dPF9sZ1Ke?=
 =?us-ascii?Q?xpP3VPm4gXp2k77qBnkOX/P9y8U/vNt7NHFGYFyjNSBuxhGgIU/GCyScw7Nz?=
 =?us-ascii?Q?CuNfd2MhiwSljNx1Mdw4XMiRDqXaTAnoZTwaRVJghkS0nIMYDJ0GyaDUtXWK?=
 =?us-ascii?Q?J14r/DbN+gejJsBFu4WcpJCK5NzN6iIkf/NUdcQF2K1FfdcXDY6VWEcW2wFD?=
 =?us-ascii?Q?U+oY5xacYtu+Fe62P/xPJSiUtlEVae581pPnNhH1s+oQyU2TpBEmlPJ6AHHr?=
 =?us-ascii?Q?pUBYigxlRnRHb5SrNubZ/KPNjmcKB20VvHZw9XSjdCPwC4MPbuLComaMKJmM?=
 =?us-ascii?Q?8w8Q00IAf3VwOUJf7ZQ9g7QXKHQHZvdExFJGfbBxQ3he7ZAh/8WWb8mWa3P+?=
 =?us-ascii?Q?UFjtBxSJcM55gJo7oj5ElaEUMyXdexngjxaxz/AlVmm0drp79KTRXx2OIbg2?=
 =?us-ascii?Q?W74H9QJMYgb5fSm4r5PAjcClEVCvNCxb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:44.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee58f66-da1a-43c5-ad81-08dcacd41fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If we aren't entering RCG/IPS2 or CLKSTOP is not supported by PMFW then
we should be requesting a dispclk value of 0MHz to PMFW.

Currenly we run at max clock since there's an assumption in APU clock
table formulation where we can run at any DISPCLK at any state so the
real clock value ends up as 1200Mhz - the maximum.

[How]
Set to 0 instead of the minimum value in the state array.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index d5dcc8b77281..866b0abcff1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -575,7 +575,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 		unsigned int lowest_state_idx = 0;
 
 		out_clks.p_state_supported = true;
-		out_clks.dispclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].dispclk_mhz * 1000;
+		out_clks.dispclk_khz = 0; /* No requirement, and lowest index will generally be maximum dispclk. */
 		out_clks.dcfclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].dcfclk_mhz * 1000;
 		out_clks.fclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].fabricclk_mhz * 1000;
 		out_clks.uclk_mts = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].dram_speed_mts;
-- 
2.43.0

