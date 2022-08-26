Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817DFECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B5310EB3D;
	Sat, 27 Aug 2022 02:26:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FCD10EB3D
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVADsg5PO6rg31flZaXDDOprma2jTgz3Dm+rCbSgFsAvnqhPzm2GG7ssexI1gGvdlhI/NOKRkzIKLBTCSoVlqubIzm0NN0AQ3PYzvmm36ImPwQ4uwETXtSDnvO9ayU5+PqPCPlq7bRvraqIaSZAaTzN7pH/xCvTxrXjBn+wGjAo0vIEUEr+mCv8y95YJa4R+rypIpVgd14CYHD8P3GAdqcoK1fqPQGyZnLVLqyK40kObkaeA/AByW4SZ2IBYuxuejnjFACKQUWm3qWDsbEKXWxFfBBcon0P8cxKiq2A1gsgF5ZJ36bXWxPXODrrRjhgUY9AfKM28Sp/IS7gEakG65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7SZpYLShHfaise23ft6cm089es4md2GoyDC8ltV188=;
 b=F1LhNhB7LUQdDBD8e89/3aSGcZHKk51cULjO33OLqmD0CV4BoyuKZsGVmgY0w9shoUOrgx8m7mis0dodfhDsDt0ehkX0NXCk85BqM3C5/WC27TBcholucQ3QksqJL3crDm9yWhmED+jJc7GE8bZUFG4xQojPrc/ZwmuAWzqlwh8Oz5XFnabZntnfjoH/mHKILYFy79qQYwuZzVBYgON4hF2K/OgNi6b0JFgjBr1GKkqtmZIVPM96cI9FoQ9cm2LDoGCkj5w/zcTcoQlgLP2kK2vIXAAHgZux0NzwTkmyIk30ips3jeQxJB4MvQH+DNRBY3gRglvNvFll+SoD5tGprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7SZpYLShHfaise23ft6cm089es4md2GoyDC8ltV188=;
 b=DYhKh8rnr0Q7ER3EM6O0+TmB/O9X56CrqW+vhD/3h0gkAga4WET/sJyVKEnRTh8fSnp952y+LtRxizKIzz1inPVG4yWlAzGbShBMji4v00eLnUjyvlovIdaVpocyb6gwpQ1QgUdlZNsUQcKW2S9zB34oIPJDmvJVI5NIZ3y/psE=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:26:43 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::e5) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Sat, 27 Aug 2022 02:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.25 via Frontend Transport; Sat, 27 Aug 2022 02:26:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:41 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:26:37
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/33] drm/amd/display: Set ODM policy based on number of DSC
 slices
Date: Sat, 27 Aug 2022 06:26:50 +0800
Message-ID: <20220826222722.1428063-2-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c51becff-a019-4d9e-3860-08da87d394bd
X-MS-TrafficTypeDiagnostic: MW3PR12MB4443:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/YcjDM53DbU9HKT9aYs/HRsq7w55CePuQshtAr6YUiMJ0lan4sEoKgLJj10WVdNjhZ9GEophwZr9dp/1nE7Ra1rHuo4zknO6zChdY0wp3TtdiVv1O8bPRTIvdl7ImVE7IdqXHQWzxXv8YwCoGX2xdlyC+jEf+h8Amjl92i7KiOP0RlYaKzzXV94kskypYtugBq6sTlcX8J6M/aG6G2AFwOhcpomEQ4uWTaB2SJPtIhvXee5pevF42TKPZgc0zJLHGZOZzoypF3hftbfLGMMa54fRKGaQ9diCuWDH2LmTELrtiJ3hIXikd69Ra2OHEXtDjTPfn4la30J+G3HqclqWIOPEjVw55EYCmZawyY89q6+j3RVoN0ZOFMn6jPjkORkkeCM9GL+vNccHbQO6+zANs2H2gb5PZS7qVhUunIRM1K+j24ujjWNgcO7TAUEaCeAod11FxqFEPQBjIjgDSrsvPbEsoiXkT6Rzk9Qf8B78O2163cpt41UC1H587FCeBVnvbzzjvPzaTygzoK2FiyusSqrJ1nr8IqxyGQa5RBW/D8BEDu7dDud8DKQJ2kX+biQDvHSmpWHbJIV7V7kt77e4qDyMlzvYYc1YiU4YJkVzfKz9uZmHXxG70Dgg5lcQw0F39FrAwRXOJ9AA9ThAkJSdmjPHghsH5you+W7c83ndkW9rm4mK6QRRjxLBDgzFkGe36Qrvh+G57SOiepr4gYG+1suoJnvxz+4ntLyTOSBLpKbYjcMbqEb+19NOt8rkQOKs0YeYSIWW7hCsb7v0GcjmUCldJoAYhknKbBzJQ7nTtp5Hwrl0RWowHdMWjLm5fB9ue1m0KnVv1GTb01C+8P3uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(40470700004)(36840700001)(46966006)(5660300002)(316002)(54906003)(6666004)(7696005)(40480700001)(36860700001)(8676002)(4326008)(82740400003)(478600001)(6916009)(41300700001)(26005)(36756003)(2906002)(40460700003)(426003)(47076005)(8936002)(83380400001)(82310400005)(86362001)(70206006)(1076003)(356005)(70586007)(336012)(186003)(2616005)(81166007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:26:42.7124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51becff-a019-4d9e-3860-08da87d394bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Add addtional check in CalculateODMMode for cases where the ODM combine
is needed due to number of DSC slices.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 ++
 .../amd/display/dc/dml/dcn32/display_mode_vba_util_32.c    | 7 +++++--
 .../amd/display/dc/dml/dcn32/display_mode_vba_util_32.h    | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index cb2025771646..f831855db022 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2045,6 +2045,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
 						mode_lib->vba.DISPCLKRampingMargin,
 						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
+						mode_lib->vba.NumberOfDSCSlices[k],
 
 						/* Output */
 						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC,
@@ -2066,6 +2067,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
 						mode_lib->vba.DISPCLKRampingMargin,
 						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
+						mode_lib->vba.NumberOfDSCSlices[k],
 
 						/* Output */
 						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 05fc14a47fba..6b3c4dbb140b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1193,6 +1193,7 @@ void dml32_CalculateODMMode(
 		double DISPCLKDPPCLKDSCCLKDownSpreading,
 		double DISPCLKRampingMargin,
 		double DISPCLKDPPCLKVCOSpeed,
+		unsigned int NumberOfDSCSlices,
 
 		/* Output */
 		bool *TotalAvailablePipesSupport,
@@ -1228,7 +1229,8 @@ void dml32_CalculateODMMode(
 
 	if (!(Output == dm_hdmi || Output == dm_dp || Output == dm_edp) && (ODMUse == dm_odm_combine_policy_4to1 ||
 			((SurfaceRequiredDISPCLKWithODMCombineTwoToOne > StateDispclk ||
-					(DSCEnable && (HActive > 2 * MaximumPixelsPerLinePerDSCUnit)))))) {
+					(DSCEnable && (HActive > 2 * MaximumPixelsPerLinePerDSCUnit))
+					|| NumberOfDSCSlices > 8)))) {
 		if (TotalNumberOfActiveDPP + 4 <= MaxNumDPP) {
 			*ODMMode = dm_odm_combine_mode_4to1;
 			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineFourToOne;
@@ -1239,7 +1241,8 @@ void dml32_CalculateODMMode(
 	} else if (Output != dm_hdmi && (ODMUse == dm_odm_combine_policy_2to1 ||
 			(((SurfaceRequiredDISPCLKWithoutODMCombine > StateDispclk &&
 					SurfaceRequiredDISPCLKWithODMCombineTwoToOne <= StateDispclk) ||
-					(DSCEnable && (HActive > MaximumPixelsPerLinePerDSCUnit)))))) {
+					(DSCEnable && (HActive > MaximumPixelsPerLinePerDSCUnit))
+					|| (NumberOfDSCSlices <= 8 && NumberOfDSCSlices > 4))))) {
 		if (TotalNumberOfActiveDPP + 2 <= MaxNumDPP) {
 			*ODMMode = dm_odm_combine_mode_2to1;
 			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineTwoToOne;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index d293856ba906..626f6605e2d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -226,6 +226,7 @@ void dml32_CalculateODMMode(
 		double DISPCLKDPPCLKDSCCLKDownSpreading,
 		double DISPCLKRampingMargin,
 		double DISPCLKDPPCLKVCOSpeed,
+		unsigned int NumberOfDSCSlices,
 
 		/* Output */
 		bool *TotalAvailablePipesSupport,
-- 
2.25.1

