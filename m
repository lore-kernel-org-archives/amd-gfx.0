Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693F1C36016
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A3410E77A;
	Wed, 26 Mar 2025 19:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUsvjcoQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512DE10E1E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp2BBDv/2MvNGNKhgYuDuC+YRttxUUosdRMbtiShj5KLCQfdYr7ZAcPY/RoaaAyoU+pHRyy/Wb/K1abEYcu9I94XXNL5B32RykI8MGWoL1vPMaQFZVG1T2noB6ehR8bSQkwlRniQdw0w4Vt+MrHugr8v7C1aCHkqIlBFnqZnI2HL0L69LYszE6CusGqZ2puDPTr7z5dUfXHUD7DqIwL82B0CjDri8MQA8x7JqiYwDtmUjeONIwWeV8/ELku2V28tp/208pztBBxaZxErQb4OgWEwus9hKJ+NXVv+qQTIAVP12aOix08nO4JoNQ/4f55oTCYZpXoFkzRxDeCmV1IBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jn/Khv8engvxKIcBCmvNAtXyp22DLzmK0BkzKVZb60=;
 b=PAIvE1cFKqAF1dGfZIuNRj8D/AaJ9H9fwRip2Em1VOiXV/7YptHa+9cDqstTfKXjCO8GpPB1FgUrLh/oL0x/7W48VVSTtMe2k5El6Q4r4Zy3gUXqAr74FMcVo7C3TXYQ95M6avIRjECAq1VJ9nlVbPUnxbj0/TTqqXhpFovFS2ymE0BDXzT8GxtI+km0FHxLgZnTNpYDRuovrcMobbdZYiZWJtU/lVdRiMyu67ZSgb9cbHu6R5ss5FogAKLALBDJU6qFuKvua3aaKQdRP+k8xlWqAKwpBphKylqH97RmtafWEURy0wCxTwjbnhLp4OGI4HXE4pPbI+ik4Gxs567w0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jn/Khv8engvxKIcBCmvNAtXyp22DLzmK0BkzKVZb60=;
 b=XUsvjcoQgcH+P0/s2zJ6FPKrb9IgjYOhSlrT5uO+kzwmUW42iu00bVHD4NuDkC3+78f9Faq9KRzDZ7fNxXzVnv8BXxmtS0OmzFHEKAUlpuSKbfuVOJo3ygXcKTGlBq7jBp4M24YNXbGwaaw8R34nF/dH+hl5KrR05jzs0Z7OIhE=
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:15 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e4) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 19:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:11 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:10 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Robin Chen <robin.chen@amd.com>, ChunTao Tso
 <chuntao.tso@amd.com>
Subject: [PATCH 07/17] drm/amd/display: Enable Replay Low Hz feature flag
Date: Wed, 26 Mar 2025 15:49:04 -0400
Message-ID: <20250326195202.17343-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: dc06ae88-7aaa-4c56-e89c-08dd6c9fd8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YShBvzfJ5iQIfDpzZkuF8mAiliTHssVV1sogARBjTuKQB6ONY72oacmB8dO+?=
 =?us-ascii?Q?xNOqtX5SjyeuJMnC087l8TxTFHn/ciZpg6IJCf4msCJIwnRBLIUCW6tt55ye?=
 =?us-ascii?Q?/VK/9QwcojOctpJvGG6VLfk/NM8JU9R231hxL8AlZNjMmoNJF6cSXx+7b4yG?=
 =?us-ascii?Q?rFU2m0GsJieAyhfPiP/d4A7wx88q41DH4wpn9jddhdzqR/pKiOjyVH8VlFka?=
 =?us-ascii?Q?/NDjjwGPHnZyHxw0eSqhkgjfzxze0o1orTJNg/PFJOcfvWHz2kK+iNNY731W?=
 =?us-ascii?Q?ccnZH76sYzjnvBdpTljahkQ4lokZ84mcUK3Xgf7Nh+AVDFmt3lLfhYCDICHb?=
 =?us-ascii?Q?3wsVo3uwdPbX43Ur5qN5r4ptdgU6d/M9jRlguDPRZudFZCpwLRXS4Mq7OJ3G?=
 =?us-ascii?Q?2uiJPVKUYSXvPYDeRF62LnueyoEt/mTw9vUpaKPr6GATQAAufR8XzIPd7Jt4?=
 =?us-ascii?Q?+BJdrvwHVSogkjfkQepuTvOsD39CZUV6rn+qbREGEEQRtYyGXtjTHP6mma48?=
 =?us-ascii?Q?DJAVRrvYzxrbl+SrHgT9HxJCIVOzwCbWjFWuv4KSQYZ05powdm4huB5dWbmf?=
 =?us-ascii?Q?5qgQnVSvOUNwRU40TLdACc/ig3cW57/HwIjj4fmDxA+RkSY/v27OtjrEOk+f?=
 =?us-ascii?Q?SwGWQNYzQkD+/vWNnF9usAy/Qs273Q1fuwJjYQndJ+WO9vY+Dqa+Ro6ujSBi?=
 =?us-ascii?Q?uT/hH2+AbCxgC5pdQmzccMxEFHvwqCRbwNM1Dd8w7JEF3BPTtLLsFdaFiQtT?=
 =?us-ascii?Q?DXW9LJhx96vffazBPxJdwsgukhb/g5JeXyjq87Ojt3WrJSnPBKL7vlN70voq?=
 =?us-ascii?Q?eHQo56Ul+z71ivu89MROL2FBb6tfD2u48gXtm7uyAeYoxJ5oE0U25D5ZFWlm?=
 =?us-ascii?Q?VPzC5C0FttyIj4F1qJ5QMhgSRFZ1RE5Mbk1S0mRjmsvzwQnELxJr0CuVsU9L?=
 =?us-ascii?Q?OO5zP6wNF8aRfgudt3q7v23Ykk3M9qO8ynv78MDTPcrZGytH7kuBBtnyahYp?=
 =?us-ascii?Q?BwmMnQ4vAqlrLjdrWq9nWKb0jcjaj4wtScMamkTRlonpvJXR9Xeym/Arpnjt?=
 =?us-ascii?Q?6WM+15JRKuUT8yxv5ObxgdoIS1dTi0i1bZyig4FjtDUQ3j01da0Mfkd6iCuC?=
 =?us-ascii?Q?XCy9k8p5tCqgIvnqxhr2zlsQRcMAD+WpCg0ZhyvCDXLwLvpcH1yj2CJZynh8?=
 =?us-ascii?Q?DyNc2t2awTqOFncpy+tHx/PXKoKrr2dWE1nq9H5tP8Xxfb4sohnvPX7JrY2K?=
 =?us-ascii?Q?5VN5YCJK0XG43EKFzxH15k7WLleq1QdmsnhZ9DUKHPyjDI2azJ+Y+Kas57J3?=
 =?us-ascii?Q?ZmChTySmpRt3Cfqrf2rPY1oXsIvA5k2SnvGXH6JPrler7hUq7PL6FEJNThEF?=
 =?us-ascii?Q?PH7gt4A+0wPiNsqarsSShuhS6z6xNyYj9w9DQNAL+oWe7j6mpWVCpqPqoxjR?=
 =?us-ascii?Q?Qs5bqEnSEqEANE4lsDI2uAHZnKBMcWwsaYNGPwPsmY04nQY1Jksubw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:14.7253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc06ae88-7aaa-4c56-e89c-08dd6c9fd8b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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

From: Robin Chen <robin.chen@amd.com>

Enable replay low refresh rate support.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 83ffaae9f439..1f8382db8599 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1089,7 +1089,8 @@ union replay_low_refresh_rate_enable_options {
 	struct {
 	//BIT[0-3]: Replay Low Hz Support control
 		unsigned int ENABLE_LOW_RR_SUPPORT          :1;
-		unsigned int RESERVED_1_3                   :3;
+		unsigned int SKIP_ASIC_CHECK                :1;
+		unsigned int RESERVED_2_3                   :2;
 	//BIT[4-15]: Replay Low Hz Enable Scenarios
 		unsigned int ENABLE_STATIC_SCREEN           :1;
 		unsigned int ENABLE_FULL_SCREEN_VIDEO       :1;
@@ -1129,6 +1130,8 @@ struct replay_config {
 	union replay_low_refresh_rate_enable_options low_rr_enable_options;
 	/* Replay coasting vtotal is within low refresh rate range. */
 	bool low_rr_activated;
+	/* Replay low refresh rate supported*/
+	bool low_rr_supported;
 };
 
 /* Replay feature flags*/
-- 
2.43.0

