Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8CAC54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CAD10E8C7;
	Thu, 26 Jan 2023 00:35:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAD710E8C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctZfDWcFkePQJNF+t0PBPCluabk9Lzh0iEIiq1OsKTK4qkunwCzcibS1cPmGSR7PdlSALE4mHAXHw96oL1TdVPWuLpWFxQBWLHp6TPjiN4oxaO0z7Hf6O9xxQVRRM5qxCXyhYFEcOVtp8UwHrILsY1uzs9xXscH1NnoNHPp9ivI0DkhearweSkgf1qmejJe4LurHsbGvkx0xrDIIDnNJKBJpKwDMthA3DZo0LRjRH9FAQAg76j2b65wxSd++DTmADQBquYtemo/rtTRAwn3vIihqPN78EQ4sBdtkoDzvX/FdtZ/bK9WyO5lbKZPt7Z6oeZn7U8cE/uOZg81t0IMKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtzF2IRP7kNZp0qyFObSY46eXZjz+OnYDqF0DnSfaiY=;
 b=iTIoaa5+eQiKtSx9c21AXpOIlqYDEAFiSy9GV7PfU7nEwTIRyfwzqxEIrKfAZgN45OCaexR/oFgxn+aEqUsEVsM36D6HPIcz/4X0DfOZUuqHeSNzyH6yAPI2XopobN7H4gKlEyGrpsUbuNZRYr5DTz8XwVVVsIBxrhUAC+Jkw11bCQZNVCBJ1RbAH1VbtnEt+QjHLnN8Dz1ymp8Ij8ACD1Q57kiocm6hG8qiW5D9zDAbNg+swUWrD2XFrGtzZRF1BNZzKR+DlLjHtKkx6uX+lkh7sHy5XBCQSK5z0F5MRElzr6lKhw1rZdMD2c9rkHe6dyixJBIpX31+QR/DuK3t4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtzF2IRP7kNZp0qyFObSY46eXZjz+OnYDqF0DnSfaiY=;
 b=uzY5S0EyfJJm5enb8yXnpRVlUqKdBEZnUz4zVNA+zO0ggJPYqBWNRslzELe4J8QpS+gZlOINfVP8wRd3ZLm2ibsIdhnHk3l92PcyRBVrQr2ydfwGOEJXHYkDkzW3DF6d8bAWgSaeFvOejQthn8241rLFFbpOeGLmJrJHz3XxQ4A=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Thu, 26 Jan 2023 00:35:45 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::1c) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Thu, 26 Jan 2023 00:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 00:35:45 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:35:43 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Adjust downscaling limits for dcn314
Date: Wed, 25 Jan 2023 17:32:24 -0700
Message-ID: <20230126003230.4178466-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: bed2d2a2-627b-47f3-9fe5-08daff354393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Te+laXXJISm9J1ZkOnMqQ/LEX2tlznnodMwPHmg9pn2MPadqomHT8Vh7BUvml5C2sURgotZMIY4AO58CdtM1mevMVLv3ur9kb98jEuzxlBaWI42tKmU9gVP1F/PyTSaPIBOgslgIXJwATXerwIsunED5yvKEOn+lGII8LlK4rkuFzucB18HFnZ2a8yLKF3jbTT+g+g2M0fJnse8t00kYMWBSzgge0NXo7oS1u564129G76jM6yuBeOarX5qY3rtCQn0EUZlgWObCitmFOOwbORqgkn5pZFjmfyFW+kcmHzwDn1/yV8zo6Qstk85hhrU/W/aCh5UGw66htSIOyFGUPikmPmg6WAOm636b1naj4f/s8GCM6NPpMyAZk346I9y6m5CjPH2rJDfmbqCXjg6JsvbUmzsZ9aZnRBgqzA0ENZeOCGolRxgWxro0LdwTGSLrzECyRp/rYpprBby4DMdzFaUm6t0T3uDUo7a9y6dUBzNSu2Pxj50cnk+B6EX/qMvg0h27IzyBEXGlPnoFamd5o5F3KhXN5QBrJJaESRo64rEvhwiG4cO9i9LmsjjzJ7u02TVGwi7Nm0QSIIkJST/Gx8vZpC9/2fBTURSYYDb0ZhJ8bSZhBKyLNvzzNsgv17LdsLgGGKw9XQVOtzLvyuNPwMgl468YiHV6+H4NRLz1eySYlGxZ9g5C06s4+T3LwzxvxhkgQyDc6NXViIOGB+6AYI2SYqHuy2f9bTwO3m1yzqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(40480700001)(83380400001)(70586007)(6916009)(70206006)(8676002)(316002)(4326008)(16526019)(36756003)(54906003)(426003)(6666004)(186003)(7696005)(336012)(81166007)(478600001)(356005)(2616005)(26005)(1076003)(44832011)(8936002)(40460700003)(82740400003)(82310400005)(5660300002)(47076005)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:35:45.7663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed2d2a2-627b-47f3-9fe5-08daff354393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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
Cc: stylon.wang@amd.com, Daniel Miess <Daniel.Miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

[Why]
Lower max_downscale_ratio and ARGB888 downscale factor
to prevent cases where underflow may occur on dcn314

[How]
Set max_downscale_ratio to 400 and ARGB downscale factor
to 250 for dcn314

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index f9ea1e86707f..79850a68f62a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -874,8 +874,9 @@ static const struct dc_plane_cap plane_cap = {
 	},
 
 	// 6:1 downscaling ratio: 1000/6 = 166.666
+	// 4:1 downscaling ratio for ARGB888 to prevent underflow during P010 playback: 1000/4 = 250
 	.max_downscale_factor = {
-			.argb8888 = 167,
+			.argb8888 = 250,
 			.nv12 = 167,
 			.fp16 = 167
 	},
@@ -1763,7 +1764,7 @@ static bool dcn314_resource_construct(
 	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
-	dc->caps.max_downscale_ratio = 600;
+	dc->caps.max_downscale_ratio = 400;
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100;
 	dc->caps.max_cursor_size = 256;
-- 
2.39.1

