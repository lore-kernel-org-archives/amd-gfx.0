Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24559C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 20:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8756710E112;
	Fri, 21 Apr 2023 20:39:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC5010E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 20:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prrb1NoxGZGNuhhPwUZKB8nW7AhtlEo6U0rf6FF8AICGtmryR6Gz5WKGcHdXjb2/de6cd1Kq0I5aE40hz0gCXtAOg9JcGa4C6w1DJkPgKdzPAt3gv6XyAyjq0Yh2RsJvA0PJhDfbb7FyaKbBledI2WIl+cINWC2JHY/ZO+GfJaSr2e5beE/vYiaIEFO3svb+b0z5NqV1wE+3OQAywUS5wbO9RhPzdgn0+L7qybZJbbc25WXKrBKg1bHmYnMu7NkjlMcOivf/q+a3BS+dMnM4K/VwUfRR2KcQvEMw2GURRIfOFmXVjFGAqwOUko3T4CptKSxsMEu+FPvAFZXRA02PAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J+iVJscbaxovC7C3FJqVb6ILUbyRz+vZ4XMSSlbVqE=;
 b=WDgnfpnUZ5NqZK5KjYI5niq28NmsKzcpsfJtMNiOqvKzcRi8ofv49qEb9PdhD+k7cCbDcG4e39DVvkT3WFDEmeFdMW2DM5Dr1vCAKlubrpB2PECm8vnO2Q5Q1VhvI9t3nifQzIim7CrYy+L0b0R2VIDOY6AuU+DZcHOAgCcRVLjCm2CFfsIMy3UTZN4Wd7l7PucnzFIGejXErVIuAyfzVcjhnFvtYE454lCWtdMbByNR0Y+hV2alBuM57pjGEm/4F3Od59mFhVaTpGPKArGnxlfOS/uA3T2J3pTArlatgbH7DlYNqJkUjOBX0VbLaxh1BsE2ozr/g8oHj8masTlLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J+iVJscbaxovC7C3FJqVb6ILUbyRz+vZ4XMSSlbVqE=;
 b=a2+4T0aVBXrXmCAgHG0SIDFbW7AfWPsoeKRAegVWx9fLmgcHU4ckuf10gBorBsdfheziLc664sur39iXWsMDkisebTaraoVJ55nyXMJ5+VWA4YU5ZLPPIsz6zyQ98OChMZZJ/gIVkcnMjZn86nh2xaVx1mTZ12E+nWJaFGFEQj0=
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 20:39:39 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::db) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.27 via Frontend
 Transport; Fri, 21 Apr 2023 20:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Fri, 21 Apr 2023 20:39:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 15:39:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 15:39:38 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 21 Apr 2023 15:39:38 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amd/display: disable SubVP + DRR to prevent
 underflow"
Date: Fri, 21 Apr 2023 16:39:32 -0400
Message-ID: <20230421203933.1085320-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa7af93-8841-4084-d651-08db42a8877e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wozFfg36AIDewjupGMGzpMmAQ8KzYLBGTXjNvYlj+l0kHwOgh556SN3QZB4yABox4oXgsvzwg66vEFhajrLcYhVr0EHHhW2AusP5xnP7LOfpPThTQEtVoCObsmhBwFJgb3itJ68TcWe+7m5o7fSmCumW+xJj9P+wgQ5YuDdvYra5+jltTzjagBC11nPfx/Wh+num2uuMlTFgJFmS6cInlKE/+V2IsWikWZKXg3xmB1N8zluU22whTvwUyEqXBzlMxEOxa/fIAHzuFPJ0EanjMnpEG0KM/TQ/QTxcxrXsopUlLtAkvCwVw1Y1MR0J/R94H43Fd6A8XLpje4glzxXJ6lXUUU22vnrYQ3mUK+XaSCSPXXowKQ7QfAK78uu06rtwing2U50Wo9fBT5Xd9eBkWSssKVyqVbccNt5OZP5f3x+Ke4P90EEQ9a6mQej34Je0kjkja5vMyidxi4jmGeVKWD8weU9iHk+FB1BeemN4u8S/j2U5ACJ8G1eGnm3Dcb1VAGmcnBv8Af0+mAJ2niuxtyYa7ofsoa4oOG6Zs9N19kI80dQ6OFDLgBFmly2KcmKTSh7FP9Oaqn/DgK88AvJvfB1CP42KywvR/1cIUX9eshlRNBah3s2nvDy/lDuJtpM/VmM2WNb6Albk/J3fQIzYtX6WxOeri9iHpJrbXVK0nmEBLpesXqrUk1uP1kGTitlB139CdDdJ9ClSqA8Bfvxleh4EPTqBvkrxfou9l9eScw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(478600001)(356005)(81166007)(6666004)(1076003)(82740400003)(82310400005)(2616005)(186003)(26005)(7696005)(426003)(83380400001)(336012)(36860700001)(47076005)(86362001)(4326008)(54906003)(36756003)(40480700001)(70586007)(41300700001)(8676002)(8936002)(70206006)(6916009)(316002)(2906002)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 20:39:39.7295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa7af93-8841-4084-d651-08db42a8877e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Cc: harry.wentland@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 541908cc2cca427fc3ae3bd4c9b82797a78e63a9.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 5 -----
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ----
 drivers/gpu/drm/amd/include/amd_shared.h             | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1565126ad2a..81206f67b993 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1645,11 +1645,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
 
-	/* Disable SubVP + DRR config by default */
-	init_data.flags.disable_subvp_drr = true;
-	if (amdgpu_dc_feature_mask & DC_ENABLE_SUBVP_DRR)
-		init_data.flags.disable_subvp_drr = false;
-
 	init_data.flags.seamless_boot_edp_requested = false;
 
 	if (check_seamless_boot_capability(adev)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b8a2518faecc..d7749260e1d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -880,10 +880,6 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 	int16_t stretched_drr_us = 0;
 	int16_t drr_stretched_vblank_us = 0;
 	int16_t max_vblank_mallregion = 0;
-	const struct dc_config *config = &dc->config;
-
-	if (config->disable_subvp_drr)
-		return false;
 
 	// Find SubVP pipe
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e4a22c68517d..f175e65b853a 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -240,7 +240,6 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
-	DC_ENABLE_SUBVP_DRR = (1 << 9), // 0x200, disabled by default
 };
 
 enum DC_DEBUG_MASK {
-- 
2.39.2

