Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF950C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BABC10E610;
	Tue, 10 Jan 2023 16:57:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7CD10E610
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npOyg20LisQPvoRLTybJ29O73z9lKeH1uFoE9uTsBO4vVwWZe0kzdYFyNcjruS47BKw6OUrBa93YA/nRIZO/gr1g+SlnRYuUr2BMilowB4mXdjkhD5g4zzZKJw8Lnp2hMCU4vuoRMEy8X6XpVbnqHoqaDawpdHeeza8zHoSwer4ESwwv+4ylrPngbweQxg3jG8FV6nI5snMHJTeqC3L2OPTo1WiYeL41fCfH7QnYSU5KO0bPou8dMpRNtnwaxjVsc87NkgobPL85b/jq9lMYnugpSszyCejCgCFC9hAxatdd56zhyMAA6u+FmVqDjTsiXorTgAUYQSaDtMsqEY+Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOWR73w1+5JB4w5wzp4wtsGm5QjtGQUoqXMWt1e9N9M=;
 b=JYSGVxB0D6dYwgLSFNNskP7VsaiZNyaS7OQCEqOX3+27ARGU+SXjc73sw7SewJea6CMQGvwHu9jvs9TRJlsZfwtLDSG3V6MTzlPxZu2WoCrQCBdr0OUwZOkGg1pV6PJDj0ch7J4ARODOufy7dGkRA7/0bAXXDAz7B+c0PQAovqf/z/CCmf9BpSr+M475S4jurqtM/wYOdF5y1ReaNuSFqngXohBoL+53lOTf6Et8r+WBjKy9LNvY/ALmaiBsu+Gf6y1M0thJwW5hNLGtpAmnXaVWPeDp1YSfcG0jnt4ZfeEq9ptqIPaJX4hW42gMzDe+e2tZTXRdwh8saX5gMjMH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOWR73w1+5JB4w5wzp4wtsGm5QjtGQUoqXMWt1e9N9M=;
 b=Q9G5hEa17LSo4gEQB+oUCyaaLmt/9GgOVbSE4fBKvl8H1PTuWyHXg/9m3+Y3jJvp/rAbD+uuau35erY47xGLSZ8JMTIX9oY7iyNi15nQzhKD8dsFpnjmK4arEjRJweRr8Z6qxQ6jSjpQnibgiWTi3cwq/umhInyDVYFZINwODuQ=
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:20 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::10) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:19 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:16 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/37] drm/amd/display: Account for Subvp Phantoms in DML MALL
 surface calculations
Date: Tue, 10 Jan 2023 11:55:12 -0500
Message-ID: <20230110165535.3358492-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd9bd61-1483-4981-05f1-08daf32bbcaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywC7QtBSGuDj0YNTQRCwD4UWKGJT50a4pfk3wZWte8wFSxtDcX44gGaWomTyX2MrGurCYJwQBDSyTXI0RX+te7t9Xf4YufpdKVSSe75SortoeQNb9bE9kVLLRQWAMlCcCCcDmjWOO0yeeqoQ7QUcDvPT3lnzLnAZi21JkPEYMvfftf3Yy3yoWv5C/ad6CEW8DFivPQ/7GBf1tWOt13SrkXfndTRTHQNM4bQeBcqFauoFKLFJpXJD+hNL60oW368X9192FTbxVy1qe0MoDI4ddo81XVq6p4IcFgleprllpr/nxLKzFw+LPXUscJPV077gi0wBzbdOHqRnkTNAJKr1NgfMj9Gn+o83840U+8NUWD9dGFv3J147iksKgxGfIpwEcU2rlF1tz4cHdDXz6+VzqysbR6uJ/iDnQTcB1kz6ZA/gD3WYGXP1GKdyQeUQGr23eDN/mD+4NVs2+MeQ0TOgPuAEQj9xYvcZ7giSds8/BKGtMME4mTRgHLhzZPo83JlFd4rrPNYyd2UuGSzJpy/FbA5i7sZq/JbUaox7dMknN9EEIql+RiueWrQc3HmHLZ88iJLxl8OdE++reO0Nd84C8cxDGVnjICBUcPlSz08o2sX5u2+tyf5Dnsd/M6wma0GhA2Ox5uA2RRIyHSI4I1I3gN8CEL0I+JPEgMJqgLA4Ey5zDNrE2XUsWBmqs/Rj4qIyf/+3tDzeYdaKP1tz5exIVt/Ee4pkZJrbNblrdRV1tyQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(186003)(16526019)(40460700003)(26005)(41300700001)(8936002)(82740400003)(2616005)(1076003)(2906002)(316002)(36860700001)(356005)(7696005)(6916009)(40480700001)(86362001)(8676002)(54906003)(82310400005)(70586007)(6666004)(70206006)(4326008)(81166007)(5660300002)(426003)(83380400001)(478600001)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:19.9186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd9bd61-1483-4981-05f1-08daf32bbcaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

DML does not explicitly consider support for space in MALL required for
subvp phantom pipes. This adds a check to make sure portion of phantom
surface can fit in MALL.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../display/dc/dml/dcn32/display_mode_vba_32.c    |  2 ++
 .../dc/dml/dcn32/display_mode_vba_util_32.c       | 15 +++++++++++----
 .../dc/dml/dcn32/display_mode_vba_util_32.h       |  1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 83765008dd5f..6c5ab5c26b38 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -387,6 +387,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				mode_lib->vba.NumberOfActiveSurfaces,
 				mode_lib->vba.MALLAllocatedForDCNFinal,
 				mode_lib->vba.UseMALLForStaticScreen,
+				mode_lib->vba.UsesMALLForPStateChange,
 				mode_lib->vba.DCCEnable,
 				mode_lib->vba.ViewportStationary,
 				mode_lib->vba.ViewportXStartY,
@@ -2628,6 +2629,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.NumberOfActiveSurfaces,
 			mode_lib->vba.MALLAllocatedForDCNFinal,
 			mode_lib->vba.UseMALLForStaticScreen,
+			mode_lib->vba.UsesMALLForPStateChange,
 			mode_lib->vba.DCCEnable,
 			mode_lib->vba.ViewportStationary,
 			mode_lib->vba.ViewportXStartY,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 4279cd481de1..ba23b199afa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1772,6 +1772,7 @@ void dml32_CalculateSurfaceSizeInMall(
 		unsigned int NumberOfActiveSurfaces,
 		unsigned int MALLAllocatedForDCN,
 		enum dm_use_mall_for_static_screen_mode UseMALLForStaticScreen[],
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[],
 		bool DCCEnable[],
 		bool ViewportStationary[],
 		unsigned int ViewportXStartY[],
@@ -1803,8 +1804,10 @@ void dml32_CalculateSurfaceSizeInMall(
 		unsigned int    SurfaceSizeInMALL[],
 		bool *ExceededMALLSize)
 {
-	unsigned int TotalSurfaceSizeInMALL  = 0;
 	unsigned int k;
+	unsigned int TotalSurfaceSizeInMALLForSS = 0;
+	unsigned int TotalSurfaceSizeInMALLForSubVP = 0;
+	unsigned int MALLAllocatedForDCNInBytes = MALLAllocatedForDCN * 1024 * 1024;
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if (ViewportStationary[k]) {
@@ -1896,10 +1899,14 @@ void dml32_CalculateSurfaceSizeInMall(
 	}
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
-		if (UseMALLForStaticScreen[k] == dm_use_mall_static_screen_enable)
-			TotalSurfaceSizeInMALL = TotalSurfaceSizeInMALL + SurfaceSizeInMALL[k];
+		/* SS and Subvp counted separate as they are never used at the same time */
+		if (UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe)
+			TotalSurfaceSizeInMALLForSubVP = TotalSurfaceSizeInMALLForSubVP + SurfaceSizeInMALL[k];
+		else if (UseMALLForStaticScreen[k] == dm_use_mall_static_screen_enable)
+			TotalSurfaceSizeInMALLForSS = TotalSurfaceSizeInMALLForSS + SurfaceSizeInMALL[k];
 	}
-	*ExceededMALLSize =  (TotalSurfaceSizeInMALL > MALLAllocatedForDCN * 1024 * 1024);
+	*ExceededMALLSize =  (TotalSurfaceSizeInMALLForSS > MALLAllocatedForDCNInBytes) ||
+							(TotalSurfaceSizeInMALLForSubVP > MALLAllocatedForDCNInBytes);
 } // CalculateSurfaceSizeInMall
 
 void dml32_CalculateVMRowAndSwath(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 83edfcee8851..5c7196d1ddef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -334,6 +334,7 @@ void dml32_CalculateSurfaceSizeInMall(
 		unsigned int NumberOfActiveSurfaces,
 		unsigned int MALLAllocatedForDCN,
 		enum dm_use_mall_for_static_screen_mode UseMALLForStaticScreen[],
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[],
 		bool DCCEnable[],
 		bool ViewportStationary[],
 		unsigned int ViewportXStartY[],
-- 
2.39.0

