Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF7EEB64DC
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Jun 2023 03:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D75F10E0FC;
	Sun, 25 Jun 2023 03:57:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA5610E0FC
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jun 2023 03:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii3ZJaKzsqbxz/QxLMqsTVA6+xo8P29533U7nOKqBSP1xuDYlTvuQNIETH8MktchCsjy8g4WLmU5KaZjv1sbW8/BOCVjWkhR0HLk+b5wWka3DoLo44kMgVbs+CIUuQWEtnycCZcIyME9Vc8oykScqbVuLG9lrP6LiIwfVILGepobpqlSURJyZmPQ1OS+X57EWJ98RvQyRFc80LgwfQSpwlhwv27hTNMtuldz63hJ2cDOJQMiuzFXO0YfdmVSZakDIt/Miq9Xgnk11LeWJNUnOtbGVbNKpNL5eBz+Uszah3ubiXAyKPZNopqcgES4yK18q4i9eh8LHr3wY1hFZp17DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltzXz1D1ZwYmZMJ/g0CMrze2HtHC74o2pzqufw5rvf0=;
 b=Ie8o0KGAbobr2dW6iHJZuHroSa4RQ1fpkfBMec61J3diClxyJ4ZS3R26g8BUed70gIfSHbVv4S703TXekLsxpTYqmyawEou/W6tSuDEekkvlOI60CtisGliJ6Z/qIkM4xtzO7IR3o7D4kX9rKb7auoAWzfEiAxh8YTIttbbaL1gz6cvdaNCk7Sz5wtZTxusGBfqr9IQxeOYIPQGiU2w5+65DlGNIVSjzf0U2xkLUQ/OUH+bhvmhfR+Qxl4slmiLWGjOM/g0CsQP3kdsZgpR49osKLybpGAb6vVtimznzvFso0sok+oyMQkN1O90UV7ah1FVcmOsTRnUTByOfvue0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltzXz1D1ZwYmZMJ/g0CMrze2HtHC74o2pzqufw5rvf0=;
 b=4Qvmo/xIrnaxMjj6x4lM3ymnkRcTbKmveXzcLQAKBttm6tIxZoWrtVtOPQ68OCVHQU1wHl0X6K9vhdKMb8rvvezusysllBRcfbU4G6hRTANEYzBIQRfgcJBMyDwOHbUNV3l4sgsiEjTZsonwhJXXWoEOo2pJI6RHxfbo0VdLkRM=
Received: from BN7PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:20::44)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 03:57:38 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::96) by BN7PR02CA0031.outlook.office365.com
 (2603:10b6:408:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.32 via Frontend
 Transport; Sun, 25 Jun 2023 03:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Sun, 25 Jun 2023 03:57:38 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 24 Jun
 2023 22:57:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2] drm/amd/display: Clean up warnings in amdgpu_dm_pp_smu.c
Date: Sun, 25 Jun 2023 09:27:17 +0530
Message-ID: <20230625035717.1271436-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|CH2PR12MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: a1aa5262-f5f0-49ae-e14e-08db75305140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxHUf6aRsE8bUAGkVyjutEkxSQ68G0kb9joGsbmxXq/zZsPqoAmyG4EXKVY5rwxQFJ1GnyHLiMMHu3u7wLQ6zKu8vDjer7kBhO9FG/PfLPi9sq+AImg5cclkMcS5UC3h7L2yrG32M74mM/cIsxxXzjh3G2M602BSFLjBpLPCdZZrm1f49Hzy2nIX8tCMu4uW7Dap84QZ0CyQkrOY5YzV59M4CX/iatcfTd1xgpNg7CojXrQ13/h2lEfNMYergsuL9EjYa8i6HntWAWRSamsJqW8F40PJfOyQ8Y4GfFpX4uekx2ED6euVMoYsx0JYqZPH14GdJfGPFWtFbGloMojgYsI6MHrnlP0CCT+mqNwWcEwpX7fgcp7aR9teg1WXoljkpjIbWjO81ZftKFmkSEF84jYepWygWmMCKYmGX/CRhtS2EeO3Zxo0OMwtwE2Xqjp6hKyKmWHv6D0QwzR65VaYxmjCiXUH0T0rIDXr7SdqpRF7AN+GVDUsyDPHShYySgnIX+CXS44ZoBxl88rb7CbwyUI2rj5vbB8dlQN3a7Z4uZIrs/PxV6FnqdqyEAEjlYMsPQIo7S7BVGk8+LHzv6k5ps0/0fLmSJWtUWSd5/oFmNzBQ1jHToV/41+yn4ON/zp68qs+DWJ31p+zVriZRH+liL5m4lpx7V5vaDTC/9I76/0/10iCNkDs2UzJghtW96h9yEuUiX07dB+whLNGUp6gOVjMwly3bq/qyGn8NT1nkZYa9r61KgJw+f1+C3NV+OOWYxTAYicD50gaD7g6amlshQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(47076005)(478600001)(7696005)(6666004)(54906003)(2616005)(110136005)(426003)(83380400001)(336012)(1076003)(26005)(186003)(16526019)(2906002)(5660300002)(44832011)(40460700003)(36756003)(70206006)(356005)(81166007)(4326008)(6636002)(70586007)(82740400003)(40480700001)(8936002)(8676002)(41300700001)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 03:57:38.4674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aa5262-f5f0-49ae-e14e-08db75305140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following category of checkpatch warning:

WARNING: Block comments use a trailing */ on a separate line
+                                * non-boosted one. */

WARNING: suspect code indent for conditional statements (8, 24)
+       if ((adev->asic_type >= CHIP_POLARIS10) &&
[...]
+                       return true;

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Corrected the indentdation for if statement.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 75284e2cec74..848c5b4bb301 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -334,7 +334,8 @@ bool dm_pp_get_clock_levels_by_type(
 			if (dc_clks->clocks_in_khz[i] > validation_clks.engine_max_clock) {
 				/* This clock is higher the validation clock.
 				 * Than means the previous one is the highest
-				 * non-boosted one. */
+				 * non-boosted one.
+				 */
 				DRM_INFO("DM_PPLIB: reducing engine clock level from %d to %d\n",
 						dc_clks->num_levels, i);
 				dc_clks->num_levels = i > 0 ? i : 1;
@@ -406,10 +407,10 @@ bool dm_pp_notify_wm_clock_changes(
 	 * TODO: expand this to other ASICs
 	 */
 	if ((adev->asic_type >= CHIP_POLARIS10) &&
-	     (adev->asic_type <= CHIP_VEGAM) &&
-	     !amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
-						(void *)wm_with_clock_ranges))
-			return true;
+	    (adev->asic_type <= CHIP_VEGAM) &&
+	    !amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
+							 (void *)wm_with_clock_ranges))
+		return true;
 
 	return false;
 }
-- 
2.25.1

