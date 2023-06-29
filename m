Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C16EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79B110E3B3;
	Thu, 29 Jun 2023 04:47:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2CD10E3B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZsz0Xj0c2UbhcCutKB5owLBxEi4V9+LRHt7bCR/HvMVn2O/5t4/SgZCfkOTssySbx4VBFaVtm5eshz3ENKn5anwYpUFsmZCd6zn//lfk6VSSCf0ZSz0peNbqr9ySp/QxcyDc6OdZLh2QjAprr54c9f+j++teRwMM7UfYXhLYDYd7hi/ko1kuIpkRp5PDIyaJUIdoPUju+erZWaMrnXTrmgc0Kqj6dBHjJA6WvZG2WpaqprkZuKuiA4rEXe6wEiXvFML4Q7iwqCmrdyFGMepZepEs/i8BR6E4+64S4GWuEqM3bN3pFe6OavCtcabXRLiICzNedBzWJuVGhgYJvTpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZDeo1+zLSCPKpfrwKfEHuFNTLpJdhBw1FUSnnh63/Y=;
 b=BTaygyOLNwHxgJnRmTQd833wuoaCNQnvK1EqHbJQkE1Hs5P+AMaBm0CFYBIvw87iiYpk/S/zBSwpNJXZKHwHiFk/YLoxuJOmAmjS1bYWXKaFxNjgNdzf7+hIk8Qt+D/NQj5OBRvBru86THRzbOzIjBKgJwwC1QuktJistaRvKntEZcnq9Ebcw1oY4S8Qy46Lrau0b2ILWmt7O2vnWSBLijF2mK1uHUrDexclwts1YiPb313G+tfmUI1e8xcDRj63iMnBEKn9sZu6cragJ7DB+fppKi4JPE5zihkvwmeThMnHf57nI+8IJopDSeU8oCf9tAHhZsEe363fzLmT5Nf8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZDeo1+zLSCPKpfrwKfEHuFNTLpJdhBw1FUSnnh63/Y=;
 b=PThdI3WNYG8qLTY9VUfLgtZg76AdN/9mMgTE0Bsjz0DkX4G3q2S3Sy63CWm9WdpSiRqTI6BfIsKxTeRYrv60aft0APVxTlHZbGiW7CbZsWAFGuj255sC84YhCX8g0XQ3YhE6BFeOpPZN+IsP1vToNf420JLjBy+UA+dSHoZ3Z98=
Received: from BN9PR03CA0462.namprd03.prod.outlook.com (2603:10b6:408:139::17)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 04:47:03 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::13) by BN9PR03CA0462.outlook.office365.com
 (2603:10b6:408:139::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 04:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 04:47:02 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:47:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 3/6] drm/amd/display: Clean up warnings in amdgpu_dm_pp_smu.c
Date: Thu, 29 Jun 2023 10:16:32 +0530
Message-ID: <20230629044635.2266729-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: f61b8dd3-8c20-4416-4283-08db785be1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pLtq45XWEvSSpUvMeR0RKV8nC2Ks73HgkQjCXqWDswq9t+bHKL/Dy9DBE2/6JP4/Et4e484aIoEQ6Gmh9apxHJr01gwfI4Of7qbpFzR3mseWG065+kBIMUEPugA5rF+F5MIDkPvlwShbF4blzwGj+1VeKrimuZCWqOXFocy7GwDmNMxKycSL68M3Xtrpul7X4XDB2/I9hOUUrCJX2i35eKNc/iXTMoRbkn6RM374MR9cpiAZdU3BYMJKTxeKTsmZcS4PWld5Z5xgg32TRVRWyniiONYyz/RaHgr12+HCdQeyBZ58TNTYSrtV+q1xCejsY/cUNCyKOIoXgazj9eLpc9oHZ7fqUdiUcYhDeWcgz1rs4ZKdzVnVHmgfB3/MYs7vsxUx14Wfjj+iq43/PL7GBoeo8noQlzwFOW0KOFKrxfx+vSU4tgJTEW1QDo5OlxEMhMZXeVLlddf3eJKsGFaymCzaRNEvkNUJEl7kbOFxrKu9Bs+yzSU2hWvwIt8lw2NmpqSMeNzzOHsF3+LTxEEN70+MN4O+ilCu/RRij1j7Leu5uwCd15YKXed75I8h+FMGKQOibray1rPnik+0yuSgJym0hReNuFT8DzV8AQdLm4wIvzcXJtnQS7+41xi75p16rPwAMZ1SQqijgulEGVVetMpGJHwvmLLgQrCSFOyiwjRWtgIABG21T0jk2SRyHNCnVd0mFtytp5TnzknpTHOOtqY7RVcpd1rxcRlI2NolK/i0bAUz85goOFz3oMNFm5X1N4oBgzwY/RnQUMTiTL84Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(4326008)(70206006)(478600001)(36756003)(316002)(6636002)(70586007)(8936002)(8676002)(2906002)(16526019)(40460700003)(110136005)(36860700001)(54906003)(41300700001)(82310400005)(7696005)(40480700001)(186003)(86362001)(47076005)(6666004)(426003)(26005)(336012)(356005)(1076003)(81166007)(2616005)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:47:02.6935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61b8dd3-8c20-4416-4283-08db785be1bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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

