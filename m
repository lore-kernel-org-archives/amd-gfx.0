Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DC0EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 02:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F380110E3A3;
	Wed, 21 Jun 2023 02:39:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B900010E3A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 02:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUWppsEWlofhEFjqQT+Qc1hjF37sAOWd/f9TOLm2WVReaXHrUbz/yBAfDje8YraIcaBerSDn4Bxm0FX0FSRQfz9gNstIsngLx9pgQbRQAAwJW2abAVPrCjhmSlEycctQzPCFtlzARkvEKpNPQGhNAUzD8cvyPi2BdoOIi8XalZh1+TNiul3EGVhlzWZuMyukkov37uYbLq5Hx95ttPIOYsNBfPHCbA3udQCycrg/Ps/etyVOs81VFhCvGiZFjSfMctIgQkApqPhqu002rGY0pwCl8RCNm/ERcjz0LoOJ/KDHd7gzm8zWIr2E3CDrb3cgQfE9IYkO41HTn+b+o4nd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9UMSQ4A1XuaA5epbbF4rE+2140Y9OEOc0mKnab6I5Q=;
 b=oQCOzSg2Q8ODXDEdTvfg/lF+PXtZQ70RwpZG2uYoPoPAlQ1O7i4zmNoY0ER/qGU4nMZdp/A+huixePcnqa/6OsHefBg5EkXzNTQQfevZoab2C4trPXaE1uQ2v9yfOIcvknhpEHxNINSFbnbJ3MbbPxK9pzTNtyyn3u6JbdUchAf+tibE4imhRUAt16cvKY2ytAaOFmJpjnrtQiUtszmtEd9RfBDdGLBYFx5ty+6eImyL/Gwli3mU+dWEVkYHP5/tDZIA3EyinU21ZozKqdPDK5mhU4GW8TDuByzigI2zkNfuE5ZQUIk/ZenoFBjlnKG3N9zA95RHNO0rGcdpVgGSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9UMSQ4A1XuaA5epbbF4rE+2140Y9OEOc0mKnab6I5Q=;
 b=1NjKMCVZt9YKItKnflISavMem1rLJxswLVeVFAuA0+WS1KHdUMnnNS7PQ0C4yIn+FMDe2wQ4Oxa5WHFqw3OdJIin2B+6WyUJXwjYqKipe/FgZLYqoqzzwE1HEuteDBfqrbbcVug8qxeINYm+hqRLJClnviJrBBqfujhjCmaUmUk=
Received: from BYAPR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:c0::45)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 02:39:53 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::42) by BYAPR05CA0032.outlook.office365.com
 (2603:10b6:a03:c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 02:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.21 via Frontend Transport; Wed, 21 Jun 2023 02:39:52 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 21:39:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Remove else after return in
 'dm_crtc_get_scanoutpos()'
Date: Wed, 21 Jun 2023 08:09:26 +0530
Message-ID: <20230621023926.362858-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1484171f-0f33-4f96-27b1-08db7200ca88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARBOsGnq9aMxKrzZ7j+Gag/NQa3OMsFhvsJ7PI4fOlep+r0wn2s9Nbpw1wHK4aTEDW3YDvvDaqpWqB8fbQmZo5E8kyDZHkeh/q98Gjp1yia6jvTs+l0mRKMzqpiMe9Ql4Ci8JEaT/vCk73diFw19E+XZZCbKQwUK9a7zvwp23Dy+uJK9ZbpA/lqyBe4wESK/uUYWoTm7IjaTugMsw5GeDKGV933or8G91ge0H0Se+pr9jrcJbihogd0/Jn8CmUiXU5nz3Y/ja5gbIzwVc162PaGQ84Y863leOG/6h10BeaJa8WBIe4x9cnylQpixy1NzNcR6thyeSZxURkRQngT+Kie/iRa6OUMSl7K2wvf+F+OjkQlGfir3/c5Yj0PyyVwNvCDwxIruzkdtwHGSSYX7eQM0+z9CqEbnURpe34/GvAOJp3iZ0PpTp+uCXo/697D20s62xma7RDFaM890vAeZYR6NpTMuX/PnZ6KmsvUZ7yCKJPcbRNIMMWHCRgiBRYeidGQhLA7xEWhxnPFfP5F+WvTN9oMQILBxGv0+oyknEilPc8JckbMwX9xAH1LKZ5oFj4AAKSHJygzcq2iwSVElIHx3OeVbPrj8gen18Zac42JvglzANhhd4Yip2Zrg1rRxxXkNb1vI0UHyg0CxN/oYUvvLFp2u4JAObchfwypOzETyTW854UCNu6/NVKR0FW3aBRRWgtX4GemrqTLCuOi8J0qWDpd06WaZa2SVzsihyrjiQvAtQOdmMqcLf780C0oTETe9LO0yuqsR99nBInlqBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(86362001)(82740400003)(356005)(81166007)(8936002)(47076005)(426003)(83380400001)(186003)(16526019)(26005)(336012)(41300700001)(1076003)(316002)(54906003)(2616005)(6666004)(6636002)(70586007)(7696005)(478600001)(4326008)(110136005)(70206006)(8676002)(44832011)(2906002)(5660300002)(40460700003)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 02:39:52.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1484171f-0f33-4f96-27b1-08db7200ca88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
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

Conform to Linux kernel coding style.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Expressions under 'else' branch in function 'dm_crtc_get_scanoutpos' are
executed whenever the expression in 'if' is False. Otherwise, return
from function occurs. Therefore, there is no need in 'else', and it has
been removed.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2446529c329a..76c42f4340c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -264,32 +264,32 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 				  u32 *vbl, u32 *position)
 {
 	u32 v_blank_start, v_blank_end, h_position, v_position;
+	struct amdgpu_crtc *acrtc = NULL;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
-	else {
-		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
-
-		if (acrtc->dm_irq_params.stream ==  NULL) {
-			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
-				  crtc);
-			return 0;
-		}
 
-		/*
-		 * TODO rework base driver to use values directly.
-		 * for now parse it back into reg-format
-		 */
-		dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
-					 &v_blank_start,
-					 &v_blank_end,
-					 &h_position,
-					 &v_position);
+	*acrtc = adev->mode_info.crtcs[crtc];
 
-		*position = v_position | (h_position << 16);
-		*vbl = v_blank_start | (v_blank_end << 16);
+	if (!acrtc->dm_irq_params.stream) {
+		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
+			  crtc);
+		return 0;
 	}
 
+	/*
+	 * TODO rework base driver to use values directly.
+	 * for now parse it back into reg-format
+	 */
+	dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
+				 &v_blank_start,
+				 &v_blank_end,
+				 &h_position,
+				 &v_position);
+
+	*position = v_position | (h_position << 16);
+	*vbl = v_blank_start | (v_blank_end << 16);
+
 	return 0;
 }
 
-- 
2.25.1

