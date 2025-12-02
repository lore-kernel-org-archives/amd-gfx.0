Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ADECFD376
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055D110E606;
	Tue,  2 Dec 2025 10:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHxpjjAv";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CAE89262
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPWfI55jjUUsvjXQAZt1Rqbr3AUSZFo0hPMAeEazgq0ePYvqT14/mFcpEr5THn3mEvOAdhnOuDxq9KCBD6e1ILpzHsKYVqfTMleZ9MRejoi70jkbgN7s0knuUsYr2Mv2Q3axsJfPgawES9x/d+tbXwALNZyl9OmIaAwkNOBczGqMukF0S9bUvKwnjVT8lBpcuGQLf0IEuMV2tuZt0SB3zs+VWYU+GrXldK1OhoI60VbcndCnLWsbUoSI3TqSB+27cI8G0is/y/FT1Bw5FjuYZpJEvmfoxt3Wyr7QXWR8lqil2AWWqzFDuOPmj+ViBHCayQhqGEEjeyYYpW+QPoFUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxY+DbLjWUbMtNiS64C89uwE1D3K3zDW2DUMvAtsbxo=;
 b=ratVK5jnvjj1zkMND8qNZY0b+CKSM0npo6/dnTM8kOSnMul8NQp0/bzJs7Zk3eGIygAJEdw95cWb7l49RslsGG3VyqhtmFJ8RBo/xPTSzyMAehLGzot2u1NL3v1xeseb5VurlNqN6u/QeNIRniI2zj5P2AgwroLG28yoVRG5ClA5aRS5sKVAxOw66Jti+ilKP8Tx/eqjbAhnijmhkRbmWoDATAzTc7nyLobZqC94L13H3zl7JTGip4ivTftG7OyuAds6tAiWCQsKs6sACrsbdGtVqvKhvlbA7snXFIAxZnz2Mcl5JlOr/8xZT68MQ0OV6LHzT/e4cgRGuDsKbVWEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxY+DbLjWUbMtNiS64C89uwE1D3K3zDW2DUMvAtsbxo=;
 b=pHxpjjAv4nfyJ4MvXjzKSxccbNmc5NYsfPkpfx+xfc/CUVWx3N9BPlJc380qxgmsh8A4cGnMi94fnZWOxbuXAAdpfaXOwGp/RkQp9gfyV3zqFbCbAbuHoFk77x/jU6kjU7DnTFQ1aOVnO8P4ydZQnj3tUdtl2wGjL3YOIGtAn10=
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:28:50 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::28) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 10:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 10:28:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:47 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 02:28:44 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 2/6] drm/amd/display: Remove periodic detection callbacks from
 dcn35+
Date: Tue, 2 Dec 2025 18:21:04 +0800
Message-ID: <20251202102437.3126523-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202102437.3126523-1-chen-yu.chen@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ccffc2-36d1-4432-6d15-08de318d9599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?szK5+qGU5e6Q3NWVM8YlZ7DEwZVfVe9wleI6iKmlr5XRiPDa1EkNzNKXje8l?=
 =?us-ascii?Q?Jj1wEUvG40E7oSgOetZnRNklHRq/6ykFS5m+qY2TLQaJdnGtoSpUNm9h+3Ld?=
 =?us-ascii?Q?WoK9MA4W26/dMq9zZq1q5xavYHvivjwDMpqG6CBQ5Z/F3J8US7LGuWeOIigZ?=
 =?us-ascii?Q?zC4ZhT3RoJ1/VI1d8ZJBPNji42X0l8AdVsNt7Kk5780t1KexUlCsXxvAsZny?=
 =?us-ascii?Q?Coer/o04JpSd9Z+qyO0QyxxDU/wmp/yHfHK2F5/wRg/iwUw55lOicfGT8oF5?=
 =?us-ascii?Q?SpFVucP9e3zR+DNK/MHotG2snNMMQs9pS+9PPvmOPm3u2PgHPvH1uE+kRkcO?=
 =?us-ascii?Q?867B+8DxLS2oST/02HnvzR5ZZ9YFmLy6kNuNXyCvojYhUYefu4w4Bs2UifHF?=
 =?us-ascii?Q?heacNZcOar7eYIPKiui2RXf7lFgGxAoZzyQX11ou/olIwuxIl9tRVRnbe1Bj?=
 =?us-ascii?Q?ibE+IJxDoAiGuRElMh+z1EsSOmssl7ax+bKQ7up6QzWnPMqsSeaLCBgbEqK3?=
 =?us-ascii?Q?pSSVV9z35ThLZ3bxdFORIlp8QwnL7hnhdnY9hk4tP0TSVr2SDG0P8AB7Nlc1?=
 =?us-ascii?Q?qFW+RKUc8WHisKRomq6rkcGg7ibnpSX/9ZM1zEiXotva1ES74M7FLyt29R4W?=
 =?us-ascii?Q?DbxO8wIqRc5PTEyA8Y99QZqdE17dluy9vvreLjfNyMwhQs/puLmjFuc8rScH?=
 =?us-ascii?Q?kn7xRH4ua7/O4VbUobBE6AH4dmVRKCIlzBiYqqh+2fteOTScsTgakG4vA0Ow?=
 =?us-ascii?Q?w6UlCWsp9Un3KJiHRK+8dHefEGxhfDNxYMQ0x2nBy24I15Cn1i/oc28pNLQ2?=
 =?us-ascii?Q?uXYkZPLpDPbnYQqVcDFIDtU83ci4ZX25Tg5fri1F9vJtTPhDXzBBrQNjYqFQ?=
 =?us-ascii?Q?slPLWMfdOqjkKLAvCitEA9YYWZyiyTS8/oYKOafBrP9R5WoY+6luf34XmilR?=
 =?us-ascii?Q?Wfsl0YkeVJmvO+U2CeM/wrQabQ53wAIE5hxcX8x8evRB7fcX1MbIihi38huh?=
 =?us-ascii?Q?L10yq7NVctnfYStPdvf2lTORr54SiOtFyKrwdDTS54gpmGFxtm8qtEg0+rNY?=
 =?us-ascii?Q?fKj3HQ9CXbHo8owvoRd0486qoo7xvUCKdW2SjAm7Ac9jp2Gj+4f4nxi+yivT?=
 =?us-ascii?Q?K54X2JvTcjW8oiWZ9O8E/REeDhxuRGg086/QQzza5drJWzivX8k4dscIFNpm?=
 =?us-ascii?Q?WYUOVEi0M56gD1EhU3aeTuqNMBvlQd+RKVghBc7+UL2GY/q5uuzUVFuYLjgL?=
 =?us-ascii?Q?N9ujLxl5x4NKu43XiFWbkCN7c6SzFMrI0tvXzRjNIuepb1hyifL4Xfz3jkgq?=
 =?us-ascii?Q?d8cGtzeobui8dHLbulJ/xEYNXfZv+YKK1nLXCYaezQwSpj6eAImE58GP5jOn?=
 =?us-ascii?Q?0ZwO4cPeZ/oPguMoKusfHctA/aV0znjSyuttqRkpeQ+3Ngeut4XUUxAze07y?=
 =?us-ascii?Q?b0L+fLAoRUKmgrCLezCD/U5v4DrwBO82vN4Qe/0vJTIqka4yHioehT+ScZY2?=
 =?us-ascii?Q?6OZ+eP4gYzk905vYDRuaND+399ivk9BJGX7Il3VRlu6zvRfpmajKvchPkLBl?=
 =?us-ascii?Q?X9FjA2S8GiLNSNkyC2U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:28:50.2766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ccffc2-36d1-4432-6d15-08de318d9599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
These will not be needed going forward as DMU will communicate to the
driver when detection may be needed after a power saving event.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index dfd0c9505af0..72558cc55a9a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -405,7 +405,6 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support != DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn35_smu_set_zstate_support(clk_mgr, new_clocks->zstate_support);
-			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, true);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
@@ -425,7 +424,6 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn35_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
-			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, false);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
-- 
2.43.0

