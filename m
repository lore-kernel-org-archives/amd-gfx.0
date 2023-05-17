Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872DDC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F322C10E3FE;
	Wed, 17 May 2023 11:40:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBAF10E3FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGyv1VPMr5lfR++De5WSqhE4Sw8sIC13/05+GNeLAnOO8p4Vk1vNYHnuj20gxkupZEGVMnvdkyF2jkzr4DdWrB1PZl6LRn8xYdTTwicvPatiIM2TSPIVLc7ldmohs7bbw0toUiXZboy6Hw9i9Pc5PxDcbq+1Dv6CVojXiswwc3Da0BjupxfcvqE56GjPOx89Y/MFbYDfe4+ogyKpkYRfwVoV1U0cT/RSo4MHJLcIpOt2CQ+TWN1aXdtQNfrysxGV9UaMcx/b1c2HlyXWtZPMYUG481FsnAy25a+AI4/oD0FyA1AaJKEKretWD7iF8mnGcKDm8xJTL1l2zf5dxmKjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV4SodxdUJR6ZRmeY65vadivsyUZ1EaLL3IEajT8M70=;
 b=KjPvWWinWpw3rJKDOeYmFkO8gclLrYQ8tW6GdZ8tDXmM8h9ronA6azdYsE2s0D8V/coZa3aBoCFErXe2Rf4jKrRlujMD19lg3uIOjYfHmlQhSplkGWzR1ju/ajKrF5UJPR01dg8n9BcHdJ6gF9pi74Nal/Iwr4mLlMRZJ4saNIuvRa0icDXCdlni0hoK/aQYW2ImevdmTGLIu3tSh0/JdeDN+/OHtXSmvQKjhuP+d+KpczkDB1TUkZcqS5pdhxHGL+y4GXkDt8NFhoYpSheRBKJqWtRd1U/RiOKqx9PSx+LiCm1QS2crhkVgF6KUsdSVii2/fY7xnYBNFuEqm+e7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV4SodxdUJR6ZRmeY65vadivsyUZ1EaLL3IEajT8M70=;
 b=HjelO55ncozHGck/xynoMfI2UKZ3RZDBql85BDlwlWSE3y3F3eSRswIVSmX82z2g4SrlXqs/FvondVD8AH2IWXZvv06xPjSDN8JBzdhavXh0ws0avzIPloFkEGpicnXBFqjcG1Hqo8zJwROFdrspZ3cI+QMrg0zZLJxZY8fMlqY=
Received: from MW2PR16CA0047.namprd16.prod.outlook.com (2603:10b6:907:1::24)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 11:40:00 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::4e) by MW2PR16CA0047.outlook.office365.com
 (2603:10b6:907:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:40:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:59 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:39:53 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/18] drm/amd/display: Apply 60us prefetch for DCFCLK <=
 300Mhz
Date: Wed, 17 May 2023 19:37:17 +0800
Message-ID: <20230517113723.1757259-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb84017-803a-4dc6-76ae-08db56cb7290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/Fi7GppB0Rkma2MJux/QUE63hDKK+hZlj9so1c2zQqNWA5DOHz47wmD2nzAplrhjREJRheb8UxnPKbunGHlYvANMuEfCjn90DMvjREgeWejtOTzPsxFW6ssWVBaLR15rCLA+If3A0Fy6ACEsjFq6UmkxJYht3qBBw3VQOGgDyBAUFF+1R9EyqocpcaW7JUnx6aualMYxq9tKm1zy9TbrvBJJIrSVUAj+boB6BZOlqCIpFs2/kfHAhplWhetHBMuDtCralzfMXH1NICJYJoZy4EpwhqJAMGaAfh3DByWdvzhDdMI+8ToerpnA5e8rHag2gAvt3s3+vSmI+f0wYOH5assB7Xqaagkr9+aSZMvUs12wxGCu34BOJ97zaSVPAR3GWXZHBeI4CxVsqbaRj3PA2+EOkOB1md6BI/IsSmVlsfTr4fGlbM2nDiLKkhCr3FxmNTOPfnHH1/NDmnR4+npTN17x+e3dKIh+rt8R+gfxUeSgugvaJRPomdDmFmJixiclm3tpgHvOX1zeTupnqmEWgmiiP+81IMXYCTiOfKuTjuQdDdZOUatR5zIfkaS9eZisGxydRSZYzhhxw/Bdz1/5ROrItQ0vYH7893VHJ/PZKwSoamPEvHSKV+ygyZ7NOLc2t9cj7/B+X4OXwYySQxlodeHoDwLMYAmMKRNaruWTCzRR6auVOh8/ssFB+xcvaB1msyDMAjp7vDgr7050DDw1aVJ4NzEIKgSgXEx6aPwz5f9XhdEBJ21GUb9J0tL5+4POmdUMcoDtrnLGmSSA2Ie/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(2906002)(8936002)(5660300002)(8676002)(41300700001)(82310400005)(6916009)(70206006)(70586007)(4326008)(54906003)(478600001)(6666004)(7696005)(81166007)(83380400001)(336012)(426003)(36756003)(47076005)(2616005)(316002)(40460700003)(36860700001)(26005)(1076003)(186003)(82740400003)(356005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:40:00.1914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb84017-803a-4dc6-76ae-08db56cb7290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <nevenko.stupar@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Previously we wanted to apply extra 60us of prefetch for min DCFCLK
  (200Mhz), but DCFCLK can be calculated to be 201Mhz which underflows
  also without the extra prefetch
- Instead, apply the the extra 60us prefetch for any DCFCLK freq <=
  300Mhz

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 ++--
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 958d27224f64..cbdfb762c10c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -811,7 +811,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->SwathHeightC[k],
 					TWait,
 					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
-						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= MIN_DCFCLK_FREQ_MHZ) ?
+						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
@@ -3315,7 +3315,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
-							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= MIN_DCFCLK_FREQ_MHZ) ?
+							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index d98e36a9a09c..c4745d63039b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -53,7 +53,7 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 
 #define MEM_STROBE_FREQ_MHZ 1600
-#define MIN_DCFCLK_FREQ_MHZ 200
+#define DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ 300
 #define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
 
 struct display_mode_lib;
-- 
2.25.1

