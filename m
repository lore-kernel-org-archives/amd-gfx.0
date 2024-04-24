Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CFFC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DB610FE13;
	Wed, 24 Apr 2024 08:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O5HnwmzJ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81A610FE13
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWQ7HS8okisNXOytyFlQwI3xIhoh9i/JjqvWGmIhI3F4dyK78231yC6e2H2g9qnQcySMMgTqY1YZIhSuqCY5zx10e3Ypu0foChmfzLC59yVFT8y8SuT8RzplbZQwbT1AOczwqa9Jyer1sEsCUPZ1Mg9vOdp+tr98zYp96Wn1q7mPCFDfCpL2jSfSCNzndq8gSfCJrXC7uSxB7daY499v0KYqyqqqtQX1WAGOtzbwBeb8716XlnoafEA6GOVbf02Wtsmcz6ZTmcBx+rXiwOFAAb58WUrKwlaELHsFgOOBt6vyy72ifc8WXOzFuiIARKQ0nuVekFm6qV1gplhbm75yAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFdYpVwQnNCClD4qOceLInUiVvF/8pzwUVlc7rxrxcc=;
 b=frL5ZgsgmK2dI0ndozGj4WXwkbj8Bf66iQa9TlbVD21qKbCJPIifnFN/YEoilVjstEIlzUgEjAd/q7w9/Eml3U2mQ0YtCmE1yLhkB4ymLUwKuvhVdr3gHl5FtndDKuAttIW/cPPL/f/w9/dFTicCi2EV09ghuQHwX0jKQb7apbjPWNty/t2VVFWolSuKmnTWS66/WXnUoXwHbQrKQPi9KwiPp0riNSLBM8/T9cAFUZryONf4Vl8Vm4LoAPVw7FUNEeg37M93VD6fBXxR6ya0sQiaqaCcLKOk7yIcFpI/7m4GxMSBGv6Fb/43lI2ENi3ZZwGE6SJo9Z52ECW4sHI96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFdYpVwQnNCClD4qOceLInUiVvF/8pzwUVlc7rxrxcc=;
 b=O5HnwmzJ7c6/Nz8JzPh+EwKGfKkhtG6dDEXwXWcU5IpgE4bLddssNXYHWZxCgbxZQzyZOh8cpKylmA12ce3l/ab1wm8NhKl3At+b+T9oOPG9oSAtmVfyQyowuVJsvuMez0v73ayjFw9GHD3z+upShTrLY3avlH6sIjXAs/QxV7o=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:42 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::e1) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.36 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:52:41 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>
Subject: [PATCH 25/46] drm/amd/display: take ODM slice count into account when
 deciding DSC slice
Date: Wed, 24 Apr 2024 16:49:10 +0800
Message-ID: <20240424084931.2656128-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 82463db5-b911-41d1-f953-08dc643be722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JVywHH/G1pbyy986EC3VeYyfCubr5f1+crnZhFwy3PFYwAycCgGbFO94o0Yj?=
 =?us-ascii?Q?QEExBCkxIyVIzelQ4yssz0+82MTL0Qcj5o6OaiAZIKxyKEACe4d962o6zVnT?=
 =?us-ascii?Q?aBFskkeI+HV/WIqAA1S++N/phCfTtzl07oOrEB4RMzs/cjRD7A33KQ+0h7IQ?=
 =?us-ascii?Q?yqRiTRRZdeBFyHTRO7XiNlLMa4NJ4cxtubcD1OSC/zwzQr4bD3xzRNLBZDyq?=
 =?us-ascii?Q?l0heGeuhvDZNRBnRLeeoIWj+27q/3d6IBZAtOiC/9wPvNqICdrtXrI30K5by?=
 =?us-ascii?Q?AzTE/ZqNjzK7QqhZ5xvTpm7eL631YTV17GM+XMtdZ5LNw3NzyWWhbHQ6u/rW?=
 =?us-ascii?Q?vY2dGNs+Moerky1VVLyrthuEkh0MYJ+HCxb1dt1xVUMlc/8OJxqAGPvi90O0?=
 =?us-ascii?Q?8UhbykW+euvoG38Y7NrDfEbuOHrum4mWIIuq4xfZQXhC2tFVmXEuT2VSc9RS?=
 =?us-ascii?Q?+7AcKUZyRYse3OBAH8ZA0pMEcMxrx+66NqZgzfm+InonOHMG/moUNW5YNQK/?=
 =?us-ascii?Q?Ue4ndfv4Y1UTQ07KEydCKYnCjtL92H/FqvA0sPKXLx+xBmm5u2RoJMqXsILW?=
 =?us-ascii?Q?zyejv6R4uNKqq5PXkw7FGqGYpUFgKpYdiQ2pX0UDCwAu7VhN2AQvyi8rFdv/?=
 =?us-ascii?Q?VjWIl0FeckG3rfCQZFzbZjZup/iugriA8t2KwL9uzwNBM2xx90MUAKPR3hKY?=
 =?us-ascii?Q?SBgYFYmg5aaefQ+MhHmdtAsGBkwu30LKFo9p42leKQvYmpYVEGCin4t7AQX6?=
 =?us-ascii?Q?8G2C8WiRXYsDmUQWONEO8EZgpPZtx+L/zEUvITiJOhV7XXN5qWnTbkzrmjyM?=
 =?us-ascii?Q?bgDhDx1q7emAJ9S3RzJiAhRv+fDEA9BnPE4Wl0y+bALLVv4zVZo8pyv9ZCUL?=
 =?us-ascii?Q?xwEWli5ZWbww7Hio6TmSlFNJtx2f2HQdsizy/ME4lVflHoIh2ReIwL+8Zqc8?=
 =?us-ascii?Q?nyzW5i5J+deGp6c8EGC1I9+EFauTw76+S3q7EO+Afov8ZB7tZ/fUt0Otdbx6?=
 =?us-ascii?Q?7QCHcLMAnaDF2J+6o8xLiuwrsQN76p4c513zStE89m4TketIJiXOxtBo32rX?=
 =?us-ascii?Q?sUEuxHUP9X3tCJFoOJq0kJk/n8Xb1QJoNCpgz5yXK5C8PMljHFKxyOxjLBOq?=
 =?us-ascii?Q?Nh2PyN48NOdbittSimcbv8Kf8wy5X5LxMfBiBLgFZjXkgTj5mz6Gfb+SUMiv?=
 =?us-ascii?Q?+WVQehI0YS8zEsFzCfozKUtF296x9t9XLOfXFJeaLTCGVb5lbzMUL9t5WFq2?=
 =?us-ascii?Q?1bo5I4zLYadamjlIZxqpNsjZdVk9eswktR+hSXKJjq5N/b9E3Hi2sA6e/+Nx?=
 =?us-ascii?Q?4vtwj/zGi+XdudxedmZVGWONT02HfRRuOltKG6qtzBoNCL0Er347sckU70Vj?=
 =?us-ascii?Q?+kKLjMA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:42.2976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82463db5-b911-41d1-f953-08dc643be722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DSC slice must be divisible by ODM slice count.

[how]
If DSC slice count is not a multiple of ODM slice count, increase DSC
slice until it is. Otherwise fail to compute DSC configuration.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 30 ++++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 7c2d74f4efd8..db795b1a94f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -922,14 +922,30 @@ static bool setup_dsc_config(
 		else
 			is_dsc_possible = false;
 	}
-	// When we force 2:1 ODM, we can't have 1 slice to divide amongst 2 separate DSC instances
-	// need to enforce at minimum 2 horizontal slices
-	if (options->dsc_force_odm_hslice_override) {
-		num_slices_h = fit_num_slices_up(dsc_common_caps.slice_caps, 2);
-		if (num_slices_h == 0)
-			is_dsc_possible = false;
+	// When we force ODM, num dsc h slices must be divisible by num odm h slices
+	switch (options->dsc_force_odm_hslice_override) {
+	case 0:
+	case 1:
+		break;
+	case 2:
+		if (num_slices_h < 2)
+			num_slices_h = fit_num_slices_up(dsc_common_caps.slice_caps, 2);
+		break;
+	case 3:
+		if (dsc_common_caps.slice_caps.bits.NUM_SLICES_12)
+			num_slices_h = 12;
+		else
+			num_slices_h = 0;
+		break;
+	case 4:
+		if (num_slices_h < 4)
+			num_slices_h = fit_num_slices_up(dsc_common_caps.slice_caps, 4);
+		break;
+	default:
+		break;
 	}
-
+	if (num_slices_h == 0)
+		is_dsc_possible = false;
 	if (!is_dsc_possible)
 		goto done;
 
-- 
2.37.3

