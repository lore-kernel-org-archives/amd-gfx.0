Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A317EB64DC
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 05:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2068110E10C;
	Sat, 24 Jun 2023 05:00:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EE210E10C
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jun 2023 05:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1A3aLsa78vPobWAY13ORb0TNEg/yrJWPlO5SC0rncO22uOBGNGNbMEq8VC7fpKuSIDH+XiqqEhkeSL9JVP5WHZqcaLnSvrG8e23jZKtL4qA89k3ZHVsC5RAzGElr9bUmHMfft9kgKfSjBjugOwZ7XazLHI8pJ3ssOLzss1AvWOnz+jYG3pEwbNMP/F2zqj9+INTUIeOvDCKXfw1NUDTUEMbFcYo1rvCVfFiKQIn/5sNgJM5dlzP8IM/dzo3eOwsl92a9SRivZ8Xjq0yjvfjy5tkcr6WtykJz5qI1NuWH8YK9etDzHjyPsdr/5v7+slZOclS7UUemMXDWOi0CEYHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaTD9JZNrf36oTeNRZhrfPge5PLIwXl/u1MR4oKuzUw=;
 b=mRnyp/vtR736mZoOX/gFdJ5/eeJsJCxqwMUN3U++zjdb8SVqhLdXrxZGgD6kgTWNYGL3HWKrxf9v7LIkRmYmG///iYGuACt4lHDYUVMiVdKjuRfaWYYt4qVL39ztj6eHde01EyfCeTZ3BFS53YaNg5s/VA463RKq2BzEi1wFGycnj8gXCwZWmDsqs4oEnMS4XhwbBrss9YeIdNSHDKgOqA+81jllHJXychWQB4/gJMJGStHVO3vPj4lX2caJLW8WnBOxp/7P2u0UU6LBp/5pD3ZDqQl87ZR7HqHNvlZcXnDlSq/iefNC2tHT3hi1Nx2q1o5IcTo2/GyrrpoRtxQgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaTD9JZNrf36oTeNRZhrfPge5PLIwXl/u1MR4oKuzUw=;
 b=loDOCs6yGQZ9syggaRAzrB5n9p/E/DGBF6+Fv4mic0fvFc4buOZaKNE1KF4LIBi0YcCVgaB/OMr6bopWBlpiwbXqLnn039N6bN0IKXe1kT9619XwAXh3JSV6HqcQwU7XboxBJveUi08kF8rdsJ1iv844ra8RS4ZuN3V53hmexC4=
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 05:00:35 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::e5) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Sat, 24 Jun 2023 05:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.44 via Frontend Transport; Sat, 24 Jun 2023 05:00:35 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 24 Jun
 2023 00:00:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Clean up warnings in amdgpu_dm_pp_smu.c
Date: Sat, 24 Jun 2023 10:30:18 +0530
Message-ID: <20230624050018.1236773-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: a89e9e83-a79f-44a7-8135-08db746ff213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EARoGP3GKwtZi+u+etbHYDIWxKyANwTG0ORCmxM/Xc5PmPN7eUl/BOl1Qkdh6bCPgCQooEbvNOeTEXEvEOfrqVD79kldq8CFV/qGFKqMT7s8xqOihtYE+HKLtRqMopZD1C4gtNkmHhNNGKt/3PlXt+GU3cXT3uPKzcelDizgEaNaBqHzPAlia1jXNQd4V3tcyO0VPxuQk/nc1HvJKvYnfWRp2PCz4CqcaDC2LGR+mPdE471M4JeVGDUnNjWZs/JOqF2SVzije9cEk9QqrpJcz/IAwzfKWazm3lLYEQhgxb+VuCyN5Ak+g1RRYqKtulj9JzUxQutS9rTSL2Rb+/liDgaWx6o1Xr2wB4zNW0mdwpILzkNm492NsLvBCV55Vbf0aeKW/h7APEzkP6C9dkhYF2RnnH/i00XWSO+4MhgU4XRsWI8+HZSnCcIknAPLIzq8AhyjJrku2iN+L47Eto3fXeLqc/PPULLOg+CkcA1dt6PStTjIeS/ydrJNOSr5DIAzO4WdZgu6+Ib+9ptB5D1Apucl1IEedx9cVHDd+riQUpTmmePTTNaDy7qITRJ6wbPHV2eLCnMz58OsTZqHy1BHvYTEst5P6Uu22j2TypRhDlaFLFR04GSaPjjjn8l98JZKLy49QUtZX2mNEZTQ7bx3yA0CgCbv5Q5d5Tr3sUdlgkZGoNMLYYoFpN5AxbBFoX5Ha7/qNUtQVSjehhHKXQSUUZWbaj+GpZS8+mrnZycGWBY3cp8JeFUn6crzc1u6C5wyYg3yi37sLmpwM1BB03H4yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(2906002)(40460700003)(82310400005)(356005)(82740400003)(8676002)(81166007)(316002)(6636002)(4326008)(2616005)(8936002)(336012)(41300700001)(426003)(70586007)(70206006)(86362001)(83380400001)(1076003)(478600001)(7696005)(44832011)(54906003)(110136005)(16526019)(6666004)(36756003)(26005)(5660300002)(186003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 05:00:35.3051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89e9e83-a79f-44a7-8135-08db746ff213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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
index 75284e2cec74..7c4331313697 100644
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
+		(adev->asic_type <= CHIP_VEGAM) &&
+		!amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
+							     (void *)wm_with_clock_ranges))
+		return true;
 
 	return false;
 }
-- 
2.25.1

