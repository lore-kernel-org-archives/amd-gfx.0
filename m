Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5A8EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1A910E087;
	Thu, 29 Jun 2023 04:42:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C1C10E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS5NEXHuTHRW+sIdgNNsn15I2swCcyHXlXfePuh/DZQ0rwYYFBDMs/97OpwQ8VyVkcxeh6a8g4cLdGCSdAxBpsd15mzXlScYSomK0vcaQbzZWk6D/Pbl4D9rZPdJ2uHIGlE52WkPzScN/Wu4HbtqSQkcQ3UkS3pijLvx3bsK4dY3vNsiWl3i4Vv4ddTkEyX96fqAR4sgExMxCq6aHx/CckcePQUzvo2M5BnTSTrTyEnYKdK36Cecx0/FkDHpm/bGcQTSYjBmYcE28NGy1ksPzhS+UINxLgxgwYbCheJ1DfTt9sQSdtihcJRMMo/lNg1cDZ7A92pzf/em61M8jB3DFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZDeo1+zLSCPKpfrwKfEHuFNTLpJdhBw1FUSnnh63/Y=;
 b=VFJwiAyFUgVFAr4Fn2ERAva5NgivFMvAbkTjxr9cEwSdHu65vSgmB8kpdKwN2Ggc0BOeoG+S6oiEkTn0oZR/Pjd49h8GLJHW8RjL+P9jCNzh+E1WCYxN4/5GtbSEfc4t/i913Nhukh5gIO6/m5wtRWobJnSKFeFGEmHdLGYbul4qfrv+LF/4YvluP60G3TdTqlgg1YlJmhQXb9onFusIgvkxWtcGqsTXiki/rjGTppGfcR3Qq3ik+nPZTSsJkuUSfX7pxDx7OiZuFPTI5Rj0IPqnIllWMyKu65RTddm/4PIbyCJT0ixTaPLhnoViRG7v9Kz70hBqKcPJBEP1h3Aexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZDeo1+zLSCPKpfrwKfEHuFNTLpJdhBw1FUSnnh63/Y=;
 b=3poKg/tBPyNPXa2SUT20IdR4YI/4zbBMOfSfmG52p0yGSWuSTTz73NcBYlqEvvpCdIZ4EbZHBLaalvYn7UBQG9u4rTPaIcRcAgMWIkeBR6dTEw1yTVPYkmnHMUbxPfp/j5bP4Mx5xuMxqIelpEHd1wguLN62qnDof2MukoXtYws=
Received: from BN9PR03CA0274.namprd03.prod.outlook.com (2603:10b6:408:f5::9)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 04:42:37 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::9c) by BN9PR03CA0274.outlook.office365.com
 (2603:10b6:408:f5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Thu, 29 Jun 2023 04:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:42:37 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:42:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 3/6] drm/amd/display: Clean up warnings in amdgpu_dm_pp_smu.c
Date: Thu, 29 Jun 2023 10:12:05 +0530
Message-ID: <20230629044208.2266584-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
References: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b6b788-07ad-4ee5-54da-08db785b43b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6YekPCZE5tSnfNVHhP+kEUftx50PEjijgvIRcjABiunM7I/7ABB4xmzfn4TGgJ4c+rafvl8w6sArN0UAeg9JQD6yO9MqwE/PBCOr159RfE4MUmailzoCLb7ETsJ2gWTcyYaO6cuDwmyyKcrB6BUuAGfnMrk386UfUTpfgaHiO2V1EfKm/iV8lIzvySBqzaCNykJEDU5KlY8mZCnSmndqsIT+7txIyi0ZZ5Ms/oBiFgPfBaaY3nfyvIo6K76fcGxn94VDwY6cPTx9RxR3vKkQNQEt9l5Fjg2ri28rOuhs78cAAhagGbHkGBIs21rjsgl+m98In2TwelwOIPPtTlY7ELkXBwEq9hrhq4+aWYVFeLYIkAZ29HZRgRwscDW3PmXAqzoiNy15ahK/Y0Y8yvpqpy6m4SwSsHrDP70XE8kqgYghR8wvWATXIs7nze2Mg8AKU5cPNZWvRj6a6lAS11XdzcuMf2z2obz6pHe4GAmBLT9iDtdnaNlnKq4FGkDMZl0Q2z+UkZzvB/87EdPEWokWESZDvYqNVO0r4iNG34xRefkedX8RfG436pHCp5N3yZjf77lta1bhwVfy1tL/7Y1yuWvg9wEqgUAZX9NSi8MW+r0zD4Ow3ZMdl8QpfuRq5LkEqfjtqJSPpUPNHTJt8NZRjBsCIUGnH/PtdqkTc+McbjxgBWSC/h2m+WIiZ9dIGvwT1iKAGal2KVe1MkN8H/RSKMQO74ITgoqWxu5av+4BTS45CjDRQAg2T0v74LBUH8rOSQgk710iEWuVH/+oJJLHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(36756003)(47076005)(83380400001)(36860700001)(86362001)(54906003)(8936002)(110136005)(7696005)(40460700003)(6666004)(41300700001)(70206006)(316002)(8676002)(70586007)(1076003)(336012)(426003)(26005)(16526019)(6636002)(186003)(4326008)(44832011)(82310400005)(40480700001)(2616005)(478600001)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:42:37.5615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b6b788-07ad-4ee5-54da-08db785b43b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
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

