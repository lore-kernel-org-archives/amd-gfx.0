Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03492ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9997D10E9FF;
	Thu, 22 Sep 2022 00:19:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED5410E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQZEYKwgBW6x8N5lkohgRHvm3fBA3Em3a8of+64S3q2YeJpp8Gj2jVdl3DEq0AtFXSrnYah8uv/QCp2RPnkHJZmA1z80sPrB68pIpk3GcGAF6+Ff7W8xVdFsE/5lB3IYHM6AkCpon23/Tl+Xs/XmljcC9B3KTEUT076N+rzJUYPh9ojTOBV7cZmJKxEvBSd+j2ybJUGtDwltE1coSKCNnTbmRgrmDBPpMD/5X3Px1LZXUD4RZizVI9vwqZEVqNgG8KF8f4LJ572lT3yvhFDTvs0sjz35Shf3R/dNn8M0UHERJGpdrJgEnWGiwLimOUSqa33RBS2dkMyeTIt7/8Unmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usx0QtUuoxAk92fXbltzOCM81TmP1JzScGy5tKZha/w=;
 b=B6J3d5XOF5kvKespxZCJY+MEpjyPFY1W/UM/meAXW6F0vqQHFmmIRzXCp5RJHo0uK4fkSheWX9GXhZTSGt30C3io4fsST4fmZIKFYKqKfVPlIbQDoahySgO8x/ufWUMmh1XtaK/bY1Xc2Nr2dAJFVMS9/LXX1eJyNr8b1OY/xCm9mxNm3neSc69VDKrRztGJtsAWixlU4xS7UKn9PjWOHe193Zyw8LqJFxC3nDENtTWP7QC1JbaS/0DZVBC7oodAOY/Z3RX3aJopFWbL9LZ6puICRBeVzs+GvjNNEuVvkHOl4Eqb16pxSOp1KL8TwaY7KIV2xyW/4J2vxM6Wgt3ZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usx0QtUuoxAk92fXbltzOCM81TmP1JzScGy5tKZha/w=;
 b=ePePXpXKPYti+CHaYX9ss4vj7Y8/MnDNSmEFFpu9Kk1cOVGu4Fr93xRl+uvZkaDLzlXy0+0euh9zqXyESUFq8CwL7GIUWmtt1CTpM4Hb93Rsqad32M8YoF5+k0/SId5PhiEOtWsclk6LFd8Qm4Fw/Fc9JNFg1P2EOqrB/f6xS8U=
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:18 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::79) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:18 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:12 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/31] drm/amd/display: Fix CAB allocation calculation
Date: Wed, 21 Sep 2022 20:18:08 -0400
Message-ID: <20220922001821.320255-19-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9cb46d-c88f-4f4b-a1f3-08da9c301710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1n5jHi4w5CaJEChr0ckbh9M8qTlbI8me8Yrxja4E5SJMx3WkbtAH+0Dydf3SFY0+Oez0F8ZkTxdE24E/Z+PW8TqfVUwn+vRrN+I3dXor2wDi1DQ//MM5ULREs11x/Hxh+Ypxi7x9l6fWl6bdEZb6xBixZJEh6Y7Q64ESH1vi8BS3aihESKTr6F5oRWJMkgeT6vR1/fMMDrttKTOrVFhquS5uuiV3wE2skspJRA8R5bO8W126UXElbbkChOgchkGWxz7huxCgVysCem5m/R4Jttcd96KVzqjGSZozW0v3+eeIIBLut9bDyiWMoefPT9csGcHNIUauSz2cIklEeUS/4aIXWv8D+nQM+OD70vf2nP3cyWLtd4PzLRnwx1h9u82jLKmcrSv25E9mr5cTKx8ID8k+02CjtxmlnTTI1M4yzFfZXEoOMK4Mwuj9ExqQ86iqCZ14lFCWAjh0L3c5xCs5AxMiROf5blcZ6EqKyABiyhDfayWy2aluM8uCB2vo+czK8RMYI5NckfETsEHVl2vJtYIdEKaQDUeptUGkWyBHTHPEav8jW2j5HYsA/N1NRpJye42EmLB0a87Uf3xu3ZVobDd6AjpUnv/ar3j7m9TndG6BWZ00P36ymDdukP+VDuk/lr6RZ2WUEwYsax4rwvQZyvZ8cabZuqmFbq+nClbnRSzqNORZiPpAfaHAs721irLuiszbx68s0NcD5ajmE9kvAcjvqE7a+1KncUpr4Y0tt7+WqMfkCEE1xedaecGTYP/bmwy9adRCD8AWIE6Nh8mLJleLqlqJhbb93ssOQHMQig=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(2906002)(70206006)(70586007)(6916009)(8936002)(54906003)(8676002)(36860700001)(81166007)(356005)(316002)(82310400005)(478600001)(5660300002)(4326008)(41300700001)(36756003)(6666004)(40460700003)(2616005)(336012)(16526019)(426003)(1076003)(83380400001)(186003)(40480700001)(82740400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:18.5050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9cb46d-c88f-4f4b-a1f3-08da9c301710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Accidentally added when should have subtracted
in calculation

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 6497246692cf..85fa17185ccb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -242,7 +242,7 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 		 * mall_alloc_width_blk_aligned_l/c = full_vp_width_blk_aligned_l/c
 		 */
 		mall_alloc_width_blk_aligned = ((pipe->plane_res.scl_data.viewport.x +
-				pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) +
+				pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) -
 						(pipe->plane_res.scl_data.viewport.x / mblk_width * mblk_width);
 
 		/* full_vp_height_blk_aligned = FLOOR(vp_y_start + full_vp_height + blk_height - 1, blk_height) -
@@ -251,7 +251,7 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 		 * mall_alloc_height_blk_aligned_l/c = full_vp_height_blk_aligned_l/c
 		 */
 		mall_alloc_height_blk_aligned = ((pipe->plane_res.scl_data.viewport.y +
-				pipe->plane_res.scl_data.viewport.height + mblk_height - 1) / mblk_height * mblk_height) +
+				pipe->plane_res.scl_data.viewport.height + mblk_height - 1) / mblk_height * mblk_height) -
 						(pipe->plane_res.scl_data.viewport.y / mblk_height * mblk_height);
 
 		num_mblks = ((mall_alloc_width_blk_aligned + mblk_width - 1) / mblk_width) *
-- 
2.25.1

