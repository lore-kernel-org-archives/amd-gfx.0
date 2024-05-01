Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B3DC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E5A2112E45;
	Wed,  1 May 2024 07:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aWForxth";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEE2112E45
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7B62syc6OZTWJy4H1vZppXf2kv+UMc+l+rxHshHGadzWoJ7IUBLA/LLCSkZrky7PV2Bs/eIA/JBEB88RDRteJyvNiC7HoYDDEa1fPmlzaEbpW3a4FHQlApYFRyk5f/t/KOQ+XNWFTcTUayazUx9D88w3dP1btcJjgm6l5E7LLswuUfuq//6tYuAM2OT4I7oj6Snzs9P3AzKdXqr2CkZMQpzNvWkrY7VSFrY2XLuMd4cr2IoabWskQqEvt6kzuyEvEVs033qg+SxJIZhWDgIypmHuBzs6DssUsp9tBodJ1PxYImYwqbl831dI15VA2PzO/ARE9RpHeXBY1HD/x8mTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/55WgEss1OPnRnZHWjz88b5634vhbJ74vtK08QyMl0=;
 b=f7H79kPtE8RMgeDfenf9tJoyMFEvZ+onpD6dxiJ3d7XWbidyZ9AsEGvFc+8QHj3y5dudllEe5GlKwMGKJi0wsN0GVcUdLToxgUtsGvZEDwwxBcCAhZGfDB1MKGUERBVbzNRkOxy1t1D3Y/HHbqehajq9UAS8srfunR5RZMUeE7W5lVKjm+XAcK18u5oeNpQ1bw73Re3ZULYshehWmXNdOYl5fWWfSIgWSwedt7ycYEI/TOD5CAq2VqkH+bo+AFuvRNTA1HEno2ic3CsQ335o7Pip5lAE2pJHrI1zFM67VwPxy3Rex4s9Cph+NqP/QZVWIXm4uXOTzC+m6kgV0Ac8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/55WgEss1OPnRnZHWjz88b5634vhbJ74vtK08QyMl0=;
 b=aWForxthN7ttIIgQ8AJl/kdHEIIfBToRmJsZmQs9HiA0PV1fvz1gZnn8BRoBtiFQpOZldWFTLjCks7XdS4AC4vJsPZQYNIHRdjllvzpdVFlGIVoeg7AOthq2wq6f57vO3D10mBhQu+XdMcRwRRkSXdttEkmHF2tKlGBGzNGi8bI=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:17:10 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::24) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Wed, 1 May 2024 07:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:03 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:00 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Xi Liu <xi.liu@amd.com>,
 "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 02/45] drm/amd/display: add support for force ODM override
Date: Wed, 1 May 2024 15:16:08 +0800
Message-ID: <20240501071651.3541919-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 806724a9-1d9b-49b0-556a-08dc69aeb74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hz+O0cliI3zOqQsdNmSrYibVQv58/7jAu6PvcVNVi2o07vn8UWXCKON3gyby?=
 =?us-ascii?Q?lvctLAU1+ORyXw3Up+1V/vrlULIpMA8gYUB7gn1/IiladhY/o8Mf8X+Ho4UD?=
 =?us-ascii?Q?M3ngaKXYIxUb6ctI6OlieEmxiwiJYLwGcRgohHvfoAe1x1kox6rshxnzzacm?=
 =?us-ascii?Q?/mFEBl5xXPpRG7KonjRYni6J7LIjQC9fMjpM9t+HWERHCwIoJMYdZpodRC1l?=
 =?us-ascii?Q?0MGTPzBUrvmqBVQmV/cLW4kA3WIcMOPzdUe4HV3MvtZxp97hSwAelVGNUJ5+?=
 =?us-ascii?Q?zaiBMuWSI26ThYFgtnAwiFC5aXlK7xkuF/Ny3jvSGV/1XVWKTaDtL9gmToM+?=
 =?us-ascii?Q?aOPHDisZRVwe5JDQ+wzmn/AHbMfA8esOkeZtUG76pGOkNQ21JLYvUKlqIR1K?=
 =?us-ascii?Q?jJsQ2m+z6hzz+G3+GHIL9VzAszIQh4W7+Yi23TeL56EY6egB86r566j89zOf?=
 =?us-ascii?Q?5ObqUTWoPwqE/uSwIaVFdyNzZoBDGx/2+TW0YFO59o2CAMF1nbASNqiRSRhB?=
 =?us-ascii?Q?1MNH1A/cvLj1uWAehuI5AEvvlgGM8HfIRKD0FuEkWsISUhrF8LPu/zUW+Onc?=
 =?us-ascii?Q?ENJ4ugbqNrIPXr9wWUIyU1iDcVFh4mPde/D8YDd6u0bvFLetYMPnMg+TkVnf?=
 =?us-ascii?Q?FwTnuKUtycAa/8lnsTKey59rerEwnl7azA5Gvj9KfIXjlsfa3n+1rJBUuqDm?=
 =?us-ascii?Q?O2lSTcYCJ1ibAiFFzLpI2aepm8fBk9D49vPNMqZBnm+kkfuAfUmrPyspL/Dd?=
 =?us-ascii?Q?4qTbBi7FuqsdCT+lyEYpAlFn1NoeUYlyb1/eVgM3dQ8v/O13Fd4KBikfVMwi?=
 =?us-ascii?Q?tbC2Md0MJ/nYCKuz3F7Q5m5oOWvlZEGLUoDZgPtyOKU3VbVKDi4G0mpZOxfH?=
 =?us-ascii?Q?fJ8RUCiEhF+wNKgTRIDmUGBwxiYAmdy9v9CLQpIWacgmlHtTE7iRHaLDnWal?=
 =?us-ascii?Q?W8s09O3uphaaEp15ZrZTVQSbW+S3K6FCPl9Z9Fyya0hn9P9rQ9BO46fLJAp9?=
 =?us-ascii?Q?a3gr1rasRqA6O1m45akBacnW4wJlrUqzOCWsLtZSNTbvXD8Oz3Wu4NNm1bso?=
 =?us-ascii?Q?utkiRssYM9f1y6I0sbFGQgpF9AoqvHVgtxKLyTtIucBcYwtmmTnmCXszD7f2?=
 =?us-ascii?Q?aEokIx9C5/XMDdAAV3K9EMMrkSUby0tAieyXAOP6e5MCtH+g44yFjvuHhLHx?=
 =?us-ascii?Q?b52FLoskCHhtmS2GZMtvnSz3fx/fkr0fTSs10/OO25CkbAHrc0igIsoymlwZ?=
 =?us-ascii?Q?yCLmpqfYZAmPQlX47p4UjByuxKozg+t8vnXcSbImGJG4EyunM0c2Te3JL5td?=
 =?us-ascii?Q?yJI9+TDCk3gjN2brqLy06OmaoRPk4Q8K1O06NfzkNJ7ZyaQQ4oxZ5l1kUR52?=
 =?us-ascii?Q?HpkSRAQI21PihONXi2Xf5+SlVR8+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:09.9470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806724a9-1d9b-49b0-556a-08dc69aeb74a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

From: Xi Liu <xi.liu@amd.com>

[Why and how]

Current 420 ODM combine will override debug settings.
Add support if debug settings is set for 420 ODM combine.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Xi Liu <xi.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 3e919f5c00ca..c054c22cf305 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -5538,7 +5538,7 @@ static void CalculateODMMode(
 			*TotalAvailablePipesSupport = false;
 		else if (HActive > 2 * DML2_MAX_FMT_420_BUFFER_WIDTH)
 			ODMUse = dml_odm_use_policy_combine_4to1;
-		else if (HActive > DML2_MAX_FMT_420_BUFFER_WIDTH)
+		else if (HActive > DML2_MAX_FMT_420_BUFFER_WIDTH && ODMUse != dml_odm_use_policy_combine_4to1)
 			ODMUse = dml_odm_use_policy_combine_2to1;
 		if (Output == dml_hdmi && ODMUse == dml_odm_use_policy_combine_2to1)
 			*TotalAvailablePipesSupport = false;
-- 
2.34.1

