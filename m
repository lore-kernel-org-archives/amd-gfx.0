Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58644D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BBB10E720;
	Wed, 23 Oct 2024 04:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wc8AjnnL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648C710E720
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh3SlV2sURo4+hoa3HdxptCN7MnUiUeZY1hAR5e0ss9LkLEQ30Hfvm/NjZUztCohKwsfHYe445yw8gmUxYcnA5E8fQ9p16A3JsWtTT7MbyFh2XEcshyqpbn7QuXV0zsCD3NrH7RB0PKaDPhuvXxAcIpgWIZn2JRf9+r0Fz+Jk9nO8DSsgb0fmnCiVhCHt7EeYzjQlL0hXe9cFV/s5VtenjUVISqnZPSKqjmvyRnnbj0rMEhkO4GrqeW6mKGSroCc2FJHdkurg8phPtNpPkRFuXsesVKvXym82wMzgvHrqCVHxEXJCFh5eWd4rChq5Iyw14WQAYbIPJmAZRm0qgPrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFp+dYbz0xKnJUgVQ3pzzoJM30j0eAeNXxb4U/II07s=;
 b=b5z9lmR3Iad0OOvWMyJAN7M6USqbH6yIlK2qpPiqz0cKjrlfDmXZBBEAiTShNUpcECg6pPGutoJU871cPRfg3B4YLFb2EdG3DirUyfIBPYkqhJDvpVgxruRLIA5+4wg/PuhT0O1JavntzzglTxJl0iUyG6nL+87dGv2cNOx5vj9LE3vUca6McU3vi04+FPpFvTcKSbbxF3I8o4vCn2ey2L+7OZDwBbW/FdaUK22UorovjUrdbfZsKhekylD1erePPJZTMwZaMW4KyWrcKjCME7cUA91K6zJB9HiJmBDJEL5lQV+ZcFCuIEU+PtsCQ9kRw1fY52txOdba+mTF4X1fjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFp+dYbz0xKnJUgVQ3pzzoJM30j0eAeNXxb4U/II07s=;
 b=Wc8AjnnLSC6yQC0V4m70zQVwlhOTCuK/elS0voKy3xyaZMAGCkYWOzwE4JdXZ2BkzESBz060y7J4DdJAi50Pkhc6YhqI6WIKX1JkmMsOqpsX7rmFQPvkUr+oIazujlQDG2kYVojpbm13LwLFekF1NdHN9qOANEtO++kfnK4zWCc=
Received: from DS2PEPF00004561.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::505) by LV3PR12MB9267.namprd12.prod.outlook.com
 (2603:10b6:408:211::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 04:54:33 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:92f::1003:0:7) by DS2PEPF00004561.outlook.office365.com
 (2603:10b6:f:fc00::505) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.13 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:32 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:28 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Simplify dcn35_is_ips_supported()
Date: Wed, 23 Oct 2024 12:53:30 +0800
Message-ID: <20241023045336.1557443-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 593264e6-5357-4b6b-9cca-08dcf31ec968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jaZFmw+mQvF15/3iXY6g4p6VW7wsUsghoD3LiF04/mDZRQEBkQM24HtStJmY?=
 =?us-ascii?Q?00fCk5AkCwQIuUK09w0guThm/BSRPNnKI5lfExb3umJBOu1H4lr5EIKA4Rnm?=
 =?us-ascii?Q?b0movr01/zwp2R/DvMQqPpg7LVtJEy7zAHTAbd2xsDI8e/aLfGWwQLWn5j5s?=
 =?us-ascii?Q?uLmuvA2hDmaWYHAqnNLsmU2RwIEYJPKd/dG94Vy8YVn4GQXkHVtJy0aNcW+H?=
 =?us-ascii?Q?Ffe+Il5iDd64eyThQRWRRttYET0R9AacdxYYcks0y95ylGU7mqh7Sfxy2NaD?=
 =?us-ascii?Q?bSKqporEGrq4qTUIkM4TV0WUtGOwLKU4bG5WAE6HGry40p86vrgSPxU/y1WY?=
 =?us-ascii?Q?kzVXXElrYbV78iKXZAMkR8uwgm8zdcfgUnPXnUAXgPHAZ1k3+1hRMC57Af3u?=
 =?us-ascii?Q?pIBNKCkzKs8m7Ebo6mlDBye8u/k/Uh4h6jI2wb+FmVFNQJLxw7HYswLwb1L1?=
 =?us-ascii?Q?VBC2Sqw3XP/At1Ol+mNgquEvxu5/FwB6Ark4fE0iuyo4BQ2t3N4AqADItgsE?=
 =?us-ascii?Q?qlSz4Gk3tg13wi59GERTzyzZcXBx/1DzB0km5Uo4pYrnZHIOarlpkI6sY13M?=
 =?us-ascii?Q?z0+BKOEROuHeEAhB0qh2GRH8SSoX7DUZPt+j4XuqOBj6eMDp2jYXH4SxI/lL?=
 =?us-ascii?Q?gWiii8QPRtLZmz+kfospgiczcX2tokgTUCQY80EoxfID8gqksnzfRMN/dWp5?=
 =?us-ascii?Q?MREbw7GrO7/ZuVZs5i3WuYtCIWacPS9McNA0imT5Pb4ZbwE+eR9UeM+ZFC3w?=
 =?us-ascii?Q?LFdxg1Y7kyI0ZKQm6oGTrBibChZob3dGgzyTphXA7CHVk/AeVUPZiIT8JSgM?=
 =?us-ascii?Q?AD7dkiYwzApMhAyXlSREk32qNI9+v/gv+y+hZUnb4JnLS0Z2vlmt+/vgec0W?=
 =?us-ascii?Q?/tkjA1tFdU+Iv91nYxQBSiA2TZAgMN3tPJGHpeiXGu96K+Zd7o456wMO06/9?=
 =?us-ascii?Q?qNXFlXWZ2nLITGir4jmO+RB5JyVwNaOgyvmQfJiSybjpaf168bAEAXvqnwVw?=
 =?us-ascii?Q?NM89TB+nwe9x/tEK1TUCLHtQCdSs7oryS2JbV8UmOyy/kXMMPcmPlRAZZy7H?=
 =?us-ascii?Q?37GPnniNtJwLdvepLHYYLS+vFYadP918AUgMSxEmJOzguBDYSlCU6VSO9Aui?=
 =?us-ascii?Q?QI8z8zWvCi/DCiY4IZ3A8zo5z+BsfPchykJNOHw5qK4fynM/irhi48mT6Ara?=
 =?us-ascii?Q?qynWQJ+tmC2GVE8gSR+QWm1Oxe3SZC0XgFedx0nVapWQZq5ZIPCNs+8QIbia?=
 =?us-ascii?Q?v4qg81yaK/+4JAhUqWGP796R8Lau86Mv0YV8QCZXSCNivTPtx9S11+bZtyol?=
 =?us-ascii?Q?m4/UnGzBterKqXewa7HaG9voLrI/4Ii+n6xTm8rBVpCfRGtpUk4Jkd98CT2C?=
 =?us-ascii?Q?+6Dq/WssvFz+JVB+wtNIszL4kSUieI9gjwsmC6gZkV/J6aHPgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:33.1850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 593264e6-5357-4b6b-9cca-08dcf31ec968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267
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
The variable "ips_supported" is redundant and we can return from
dcn35_smu_get_ips_supported directly.

This fixes 1 UNUSED_VALUE issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 90208a5096c0..1d4fe0de0f67 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -978,11 +978,8 @@ static void dcn35_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 static bool dcn35_is_ips_supported(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	bool ips_supported = true;
 
-	ips_supported = dcn35_smu_get_ips_supported(clk_mgr) ? true : false;
-
-	return ips_supported;
+	return dcn35_smu_get_ips_supported(clk_mgr) ? true : false;
 }
 
 static void dcn35_init_clocks_fpga(struct clk_mgr *clk_mgr)
-- 
2.34.1

