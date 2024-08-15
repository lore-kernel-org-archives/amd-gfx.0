Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017FFC5320D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA7910E54B;
	Thu, 15 Aug 2024 22:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M9en2p3v";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D799610E541
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMCJzJwCQiYoA0ODXdpE/wldK2DzjjYarrspmpNYudI+sT+YPxwMysTJ5ScJRB+mTZIVKPI21KfDriwmQcYr8TFU5FDleTtyUuQFM2L01mY68huGP770hyE4drDNtnxgjEx20EyyzH/fvUaGdj45j6KC4d6c8y6PQemylhSx+Lf24BP70kCyeGyX6QTrOnLomrgc2TdbyJRUTQytIh0wY5qo6N3836w0jXax5pJTHASTtRWn8qvfvhSmEt6aBbySWlzs8+k5xh47/wJYaACZhM7U7slXsVJeWkz3i8U0hIy8cut947/D1ouBgmI2QvAOEnEe1u4mvFHk/WFjLBmyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFtsozQCDo1YjZf0TNF6m3Dz9y2OMt1eEBfkAPZQeYc=;
 b=q82PI9ju/r3qRZm2yGlE9FJ6DGZUy/a2DB5BovAKISpybwSv6PwEoPCqqsfPu88IJM9ejjGx4XFHlV7lkAUP4FJvmYFebFlMIjSe9Q+0GtkaJ92ghwjB7ID3hiz6583w6ZJFkmzC44gwdE0Pxy84ifsJJqoGPvdGPghyf3sZaPrt0cZGPQ4g2wb5Jd1PaNBFpLrAVhK5rZS4kmfcKYBtrroiw0opKM1lb73a5hBSHYREmhHmQaF5irwmQEb2UE/45kkhYSWzwrdbhNBckyj6RY3hTQ2DuRyk3tIV8kKDeVVg+MdMlg3ZafXfh63IDFLMvtpnQOnBprLT3ANzQ0Yp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFtsozQCDo1YjZf0TNF6m3Dz9y2OMt1eEBfkAPZQeYc=;
 b=M9en2p3vfenxIF1cTraPqygb5Inx9egK73PAHNm0DGfRA4D7kZ8OX7dXNtqdDWZ+mIrFaZK2JUS9IZiHS0IKnjGp45HJsmfPxAvPXvdUBZCza2LHamX7gXHjHFM5LPV9j6X2jYNmvHtmPTZ+TxBK/OaVtU3mr+FWlprZYbUQiW0=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 22:45:44 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::5c) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:43 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nicholas Susanto
 <Nicholas.Susanto@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 09/13] drm/amd/display: DCN35 set min dispclk to 50Mhz
Date: Thu, 15 Aug 2024 18:45:21 -0400
Message-ID: <20240815224525.3077505-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 739dc064-d1a9-4a79-c312-08dcbd7bff43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rzsZm2UuL1dMuZSAcZhr0Vj9dc6oUSeT+ikjzi8/i5PjyIoEUkjB0079P/JR?=
 =?us-ascii?Q?1HFJ3GVXpSwNpRhlN2Mse5LTIU/190rG3bXZ0DxdGT3dUl7Uuu6dip6txp4j?=
 =?us-ascii?Q?GiiTgZj/KbjzdNkKzF7mQ8PRZQuHTa33f5AqIhibJJeWQL9fWDJmF/EhIJ7i?=
 =?us-ascii?Q?Ba/0/l68Jt3itNqRHSAgy9VS56pjbIVKud7FUL6nAPpdz40FQnezxOc1B9gb?=
 =?us-ascii?Q?QMCKjsBFrcoPeaG3VLD1+WCycPd6dvNNVljdAsnj4kEAokUcP45dtSpdJI+T?=
 =?us-ascii?Q?m0+ZsPOWOkwlI3csxU8gANVB5jFyay0TdZQ2Xh2SRbe4r9gF0H+xCbt0R3lI?=
 =?us-ascii?Q?XOWsE4m/QLOctYNfuTnsRv8CWjLB9c08bc7RmPJ82UAO8Bbmy5HuJ1vSbept?=
 =?us-ascii?Q?sUCB86miTjtKWWjsPioJbg/xP52L6uABQZxWYb2WUj8Mx17ibnEnar+t7y8b?=
 =?us-ascii?Q?3oLkaoBzV3tUUAfw0daKk/MpAD5Ci+mGBAPKTlMo6SbI0WfMbyGjSO1oYStM?=
 =?us-ascii?Q?BKGOSZfugLsON2wC96Rhp0j8bu9mMrgsy8+nXFZ4tdQJkjPElH239/11PfZl?=
 =?us-ascii?Q?CaBHytwBvMddpsE1HTmv7lqtUNKVyzwhgJ2bfdWGTNTtrzrgP5t6rVGfehpH?=
 =?us-ascii?Q?B8b5EzLaBn0EzrpRIuHFs6VCfOEr2Q1lTEt7DvpCfI2OKluhKIMbZrEX6Qfu?=
 =?us-ascii?Q?+5+bw4Rh6mwZx4pBfFqpZ4K+d2Dnxf5ejY5mak7733Le8uvkLe7ksVq5Hb6o?=
 =?us-ascii?Q?yrCB4Xm/VnawcIxweFP2Rz8k2kgaSXZ4ewJHko1WNG9mLiVrAIfCOx4yGIzD?=
 =?us-ascii?Q?nVpeER8gM9vZxkBalzi0WozOLEBlDHG8/aaJdpngz/cdaDYUd8XgOrLTpIei?=
 =?us-ascii?Q?m9ASwIT7CtcQ347suW0UJcwPVsnzMDjrHVz1iWarAOiMYwIF6FjZuqimSz+G?=
 =?us-ascii?Q?91wwDcGAbhej13JPrg81dRtPaFB0t6vvAM9Hag3/T3srYynfwUpfnQqdkmBA?=
 =?us-ascii?Q?aheJeSGCrgI1e1duzfrKd1+M5qrnq4RfjM4+6Xz6R4f5J3S2UtYEMB1ydg47?=
 =?us-ascii?Q?uhNtV1dwjTJgX/jf8/BGA8iJ+hZQ82uc661grXL8IPinKqk2Hat02Js5iDxD?=
 =?us-ascii?Q?O5GkgGKh8JcoI9w6k91iP6PYev/aSVXQ5CsMD+won5LqgZDPlC6dTmDJ6IU1?=
 =?us-ascii?Q?JcNkNGpKcWY/6pAlWHpFzB/Sa+it7LROWoSvRfHhKeTfks9WcHT+tkWfreTC?=
 =?us-ascii?Q?PTWPtYntGl0WLrru5AZjVPU7i17Ag6myZS1pUOHxau3Xs5blT/wv9exfQTr4?=
 =?us-ascii?Q?7q8mH5wfcZ+dOhFB9oltlsXdrGYYT4yc+pi7hWs4i9EfSoMKuu6EvoK4AsUC?=
 =?us-ascii?Q?D3IFODMKLX/2vuZuHDIWNMwGrR0gSCcrg2YETcbTWig0wo4btPWMHxWIDWFq?=
 =?us-ascii?Q?uJAIBXhFtnQPY/JcwYWar+hjzapOIo7+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:44.0400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739dc064-d1a9-4a79-c312-08dcbd7bff43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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

From: Nicholas Susanto <Nicholas.Susanto@amd.com>

[Why]

Causes hard hangs when resuming after display off on extended/duplicate
modes

[How]

Set the min dispclk to 50Mhz for DCN35

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Nicholas Susanto <Nicholas.Susanto@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index e2d906327e2e..0ce9b40dfc68 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -305,6 +305,9 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
 		new_clocks->ref_dtbclk_khz = 600000;
 
+	if (dc->debug.min_disp_clk_khz > 0 && new_clocks->dispclk_khz < dc->debug.min_disp_clk_khz)
+		new_clocks->dispclk_khz = dc->debug.min_disp_clk_khz;
+
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5f3705f97bd7..46ad684fe192 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -786,6 +786,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dmub_reallow_idle = false,
 	.static_screen_wait_frames = 2,
 	.disable_timeout = true,
+	.min_disp_clk_khz = 50000,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.34.1

