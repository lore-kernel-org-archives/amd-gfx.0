Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D90FC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 15:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F37DDA6B0;
	Tue,  9 Aug 2022 15:10:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817EDDA627
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 15:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaYELLp/eBvcV2EzViESBHs8WzSoLQ8QJDZSMBi781REamoGEjQSytkJ5lvFpkML2xpUijA74I/zbcHwy/aTDNdXGpRteosGr1t8a0pC35uF4jLLfJ1+tXFlEIZhF0SIhCNw5uqF/74Acoe/mrN2opC4p2Xg7Zb/WbNTTbGAY5pHHfFZNbNlTa7Scw4H91z+/Zfch39fYfAOGsHTAzGuD+LBT9HogVtHkPaxJsRlbRAGemMCy1PME5r/yf4MgyUnjeorHPDyCy5taCnddHKit8JK0FxQgVHUELS9aEYmCfZ3BKvVg2JWdGCOKAfw9NNiwEX4ovHNjjiG55ZTH323dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s00BKydvHQ1b+SjaVFI23h8s0LubJyFOwFMAJ9GrcsM=;
 b=kNrVEt/ArI2jN24suOFtUluYFJ6ut72EJ0nzH+jB869TPjaYcw6NtQpSSCTvSsrv5LRU0kOQrMRe6VWttEt9OvBqPmhCMp0kNddCA98jI71ptybC69dRCju/Z+6oxeDLdOeHa27sMWMV4xUf+l1iXvr3u8bOvH3itJ3CT+YhXCR+ANYTOvKHpOpyxnP8Eb9Cm7qK6J62jfdqdEaTe3EenfvJk7AaiiNzPJw30PIl40of+TdR/t0H6M8gcZPcZIbMOvs7298I114RblVByXJ/gszPqs5JD4PCZ2/uAPwZZ+xnlC8epuC5Tlgb0VotQGUOe5YPF5RL3b3zwqvTtZOqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s00BKydvHQ1b+SjaVFI23h8s0LubJyFOwFMAJ9GrcsM=;
 b=0eqDnSv5lHE3kHZYOb9/34jq+68y76BqKsSEHx3I2ysjQf1Pow1z85fQiQrk8TfKpfIzBJNzH0LrclY7pYyWIFYMtB2XjL6oglfV4vNwJwT8qUnNM1V+UTopMDufR5/F1V0fsxL46aumC6v7+j3/FlSK65xyoHLh7bPuZiN1zyg=
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 BL0PR12MB2481.namprd12.prod.outlook.com (2603:10b6:207:40::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Tue, 9 Aug 2022 15:10:07 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::30) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Tue, 9 Aug 2022 15:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:10:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 10:10:05 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] Revert "drm/amdgpu: keep fbdev buffers pinned during
 suspend"
Date: Tue, 9 Aug 2022 10:10:06 -0500
Message-ID: <20220809151008.20376-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809151008.20376-1-mario.limonciello@amd.com>
References: <20220809151008.20376-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dabb2ddf-73ba-457b-ace6-08da7a193ec3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2481:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3ws7CdWiWafXoHQ0fhjuAe+afzYbBvlm5iWjG+Ewi/tEBi04+SELsEdZ5lpAXQJNxGzaehAOosLn2I3r10kc6Pwi4QnDVzqplqEc1BPdihLovchckeszErdCYe2mFP88dAb5zd8GmP0TxTgZdPvCmwOq+LIUqcguS6o5D/94ZwyXkpKJysN7do3KEssjtBVFbKF27xZHSH1OE76JhqsFjUMg7P1xNW0velYhfHq7tn6shZl707Vrri2l4J7z0ZCSqDV383N+ToOO7CF8bUTsi+lMEedPLTADc4p75/M7JE2LKSDGqaJW/gRc8dYxFYWdewahxXLBqMfCYn3/oKADThfLluUJXkXUH1wdODqEbek28SKNxiGUwlrUbYnGOsHDHi9a5SBGkliLbcgUVx5Kn7Lif/+eYjhzg/mM+M36P89jpC87KbZWjA4+g90NFdlZRsqmYepp9DHW4ks76x2yTTHwDaJpTl6pl7/NX0yxLTHig4J1JIzBgpXcv+c2Ymrk+1VnqRNdVeoD4W7bmhFoFJb1hfYZANZEoGOmPFI5tna4j/mdZ2egyF4ud179DhyYbSz+/dg/niZtTnWdxYfm8XJZwXW0ESGA9FSWZ29TjxXEuCqIChn9oNPA37tk2R0amFqtKNgLfBO+scmXWvukuKY3LIkDf7KoPqAMn3OzfeTxCgtKq5AmSGRKmbn6+zrY5B4YNG52kBMbk+2r0TsP0nhd0ZOq/hjDu4arzLd2WGT1mI+DCJQrvU9rZPt62A4tr6jWSRrj6EeT/iZ9ke3mbTCm2sq7LrsoH9ki1cS7StjHLdLh02gnt3nPgfrBTHhPgeoeQRbn1b3ocuCbY/++hll6OZkaoYOdc0a5r1tbsA5WqHKPCftSD5g581eX5wy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(16526019)(8936002)(4326008)(70586007)(70206006)(36756003)(336012)(1076003)(478600001)(186003)(40460700003)(966005)(8676002)(316002)(6916009)(5660300002)(86362001)(54906003)(426003)(83380400001)(44832011)(7696005)(26005)(356005)(2906002)(81166007)(2616005)(82310400005)(41300700001)(47076005)(82740400003)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:10:07.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabb2ddf-73ba-457b-ace6-08da7a193ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
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
Cc: Alexander.Deucher@amd.com, h.judt@gmx.at, Renjith.Pananchikkal@amd.com,
 Evan.Quan@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit da427a501e9b5e2cac8c8042df12eb203726903c.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216119
Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 25 ++++-----------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index c20922a5af9f..97fff4727724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1559,21 +1559,6 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 						  stime, etime, mode);
 }
 
-static bool
-amdgpu_display_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_fb_helper *fb_helper = dev->fb_helper;
-
-	if (!fb_helper || !fb_helper->buffer)
-		return false;
-
-	if (gem_to_amdgpu_bo(fb_helper->buffer->gem) != robj)
-		return false;
-
-	return true;
-}
-
 int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
@@ -1609,12 +1594,10 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			continue;
 		}
 		robj = gem_to_amdgpu_bo(fb->obj[0]);
-		if (!amdgpu_display_robj_is_fb(adev, robj)) {
-			r = amdgpu_bo_reserve(robj, true);
-			if (r == 0) {
-				amdgpu_bo_unpin(robj);
-				amdgpu_bo_unreserve(robj);
-			}
+		r = amdgpu_bo_reserve(robj, true);
+		if (r == 0) {
+			amdgpu_bo_unpin(robj);
+			amdgpu_bo_unreserve(robj);
 		}
 	}
 	return 0;
-- 
2.34.1

