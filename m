Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB973C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53DA010EACC;
	Fri, 21 Feb 2025 15:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WuW3B4GQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5911C10EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tluo1J6NMgdQDEXx2dPp84xb3rAQxInRMIjvrJwbEM0xjH3Ms3xoHOoxMk6L5PnN4tuXkwt8wy6d01k7FGAVt1Rg5VMbgooOS4D1FUrhB0pjX+bAUxL8+aNb95ZQkqo7+M347PzbGNhjUuZr8e3khdU9dw2N+ctCTYmYWul8rJodcUEA3QQVIVVJwu0BlR1UsLEliZPyg6rrm1KzxRB5vow8PGe8469XADYaWyXjseHkwlh+N1xcaSgCiby/Rk+QQpJaDZO+doWTtM7QoWqZqtDgJqj3fFS+yiL0uMP4rZ8Bpbm+yCNZc99or+x/crzpIgd7FC+hB/4aQPJRw9FWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlm9Ji92P0mOSurXHseoOAGLeVWWIgw0pJ1LR88rhTc=;
 b=gAfZzkP15yvIqoJ3t5iVVQadfPAmkK0o+R0YwUTrOLXeB6CNct3piAIROAIRgywXh9tJ9mBhOdLe87tM70hXHxrM9EDvTbBp8ZpeXzR5S1CdtX5ngsHE/L1CyZJUGOeUnvZL3Nvp9u4k/lSq2CUhJXZSw/w0CIwxemF/s/yhrBnBmlGdVVd5GWl2JP7mloPsHLvHKljxO/qpXfQgTC/KT/KHwB+7sm0qFOxhNu8scbMiqzi5Dm9EhL2CBnnO5//1KTz1MLj/7dLm1L5r2yYNVOviLnpMkvLawHOujVjwOl+23O5aiq1wuRFvLg7dUt32EOkNcyVW4qDbxjv0CumPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlm9Ji92P0mOSurXHseoOAGLeVWWIgw0pJ1LR88rhTc=;
 b=WuW3B4GQyYPWF8UhZh0XRmtzO5SryGakO9Q3YweMd3cCsHEp7CB44eF/qokEWIZxACI1dlL69HzA/7/JXbI+JWB4K62LYtJKt2wV9DCxOpJfaNHG/DO6kSEHvJherFIrjM3k3xvaSCCNg8n/ELc2Ts/EqnvGwvV0d9yAAT8TdD4=
Received: from BL1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:208:256::29)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 15:57:50 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::98) by BL1PR13CA0024.outlook.office365.com
 (2603:10b6:208:256::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:49 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:46 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/24] drm/amd/display: update incorrect cursor buffer size
Date: Fri, 21 Feb 2025 10:57:00 -0500
Message-ID: <20250221155721.1727682-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a83d0b-0234-4d96-0bdf-08dd52907dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5xpEAvLowFhItVlIqGs0XG/4R0v1q25r7EO3QydxwP1xLDBNxge2lksa9KNh?=
 =?us-ascii?Q?m40yTmnjzme4/XeRvFX6+Vc1nOU5l+xjIlAIzRQVqlQjlpaWmNGUmtyReljr?=
 =?us-ascii?Q?KMFa7H5lFujzcVU+z2HKIB9U59sBNVZbIk5DzK/qHDPPy8AY4CcKbRmEIR9S?=
 =?us-ascii?Q?+rzLTjIZfbyKfN0Aduq/BD31TYKX2GAT86QcAYFic3cUNuUhw/c5djzM6rxd?=
 =?us-ascii?Q?B+AqJSiYwTzsulbofjItxHQjEv+kRipynxpGOPOIOyH26JeTgbCfmOoWv1U1?=
 =?us-ascii?Q?VqT99E5L1SX7g1Cx5A8Fu1658abH1+/pzTPS92QrXGSvKaCxk7JvIObMX4UX?=
 =?us-ascii?Q?bfWcqiHKXBFoudi9AulxUDbgFfP3sCQS2+aJiAGBfCBNBW5XFtKxmiMOyMvy?=
 =?us-ascii?Q?g73SkzQMe0bR/HJhYJsosgqnqLLs/uGG78VBxtOSI16kF6sr7VpY/ga/fFpJ?=
 =?us-ascii?Q?PBI/aT9tiR1HohlB2fc5wwZ+BdNqAVIsU9NjJX7Mle/tFdC1ovb5Kuspma/Q?=
 =?us-ascii?Q?FRZsZdEIvLwnWVEsUDGW4IB3oXSqycqm6tBy8I9X/LwmzhIzCt/YHHKkFpbj?=
 =?us-ascii?Q?BGKt6MPqqsLg3YOqvwco1teQsx06hsMl/x3q7ccujgcF1k1QB5E28Z/Ko0Y5?=
 =?us-ascii?Q?/n0PWLh1ouEsLyEJUjCRYBbd0nnLZC2dHs/h0ZwNs/p0OzE+9EF6Pim+zfld?=
 =?us-ascii?Q?BaKuSYhe+h0hkLnF++4p2s9l07UQPw59zsq3x0WGI/cjzIqMy8OO3JLi8qMC?=
 =?us-ascii?Q?DSudlLxkQDGKt4e+sJqgozwvr17s96OKg2Bq+ECjgi7Jm+RanXysLaUQBSuw?=
 =?us-ascii?Q?GkCCAFxNK6YYdcUW9U3iY01z1PxD9eSkVdwadMPwA0t7nS6FBCzTMtF+3Zk4?=
 =?us-ascii?Q?kVQNqbQWo3Ddq00RyNPoS1OCg9BQayrv8niIiZn++ZGCMvCOpPr+Pyaje0DW?=
 =?us-ascii?Q?AXTU6Bgd1+38iBVyTqLGIhb0Pb2RchBfbXkDV3JU6pxO90lyHa6Z7aIMwsY7?=
 =?us-ascii?Q?OzU0W/sHVKvlYhCMAed2aDSyOG/ACqYHelfZSX/kLIHsT5S7Nw7ywPzsLutV?=
 =?us-ascii?Q?IGYwhN5GpD3Vhqa32lGJEYGe14dY9yPvRu4JmqNQhur5k1dUv/3AQr+HgqHF?=
 =?us-ascii?Q?fB2FN9zx1KG1fVXk3Lm+rfJyZdn8X6V770ufH3Jjm0ZRUDOcpc7I5wkmBxAM?=
 =?us-ascii?Q?noW/vnEFzM/2A+0jqTvsMczi3If5Jo3y1Fc15MOOk5WJrfDcccXhKPq9MDNR?=
 =?us-ascii?Q?a0pHtH0Es9Z65HBnnVG5ADu8YDiWp+zXkk4v7jivIBWMt9NK+m6iwRJwwUDl?=
 =?us-ascii?Q?Gwoc1mLph0QtI9qKfAu8qSErLJ7cjF7JBRnk9U/tX3iIw2wCrFJvf7l2ZQcl?=
 =?us-ascii?Q?gYI4PsHRmUfz6mCWHCa/mDzEA7PO9gmSSb3arQHDHYr9zf+8K3kTbFMKjffD?=
 =?us-ascii?Q?gX4HpbJqDzTz7wAD98BG2MZMpnmNlawo7mT+ZZsX632T2J3lMUOIJalOUdUM?=
 =?us-ascii?Q?E5SOQGo2/qUZFMU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:49.4374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a83d0b-0234-4d96-0bdf-08dd52907dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799
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
Fix the incorrect value of the cursor_buffer_size.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 3664980d1574..1020799a72ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -44,7 +44,7 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	.dppclk_delay_scl_lb_only = 16,
 	.dppclk_delay_cnvc_formatter = 28,
 	.dppclk_delay_cnvc_cursor = 6,
-	.cursor_buffer_size = 42,
+	.cursor_buffer_size = 24,
 	.cursor_chunk_size = 2,
 	.dispclk_delay_subtotal = 125,
 	.max_inter_dcn_tile_repeaters = 8,
-- 
2.34.1

