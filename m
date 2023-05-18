Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75058C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 15:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE8810E0ED;
	Thu, 18 May 2023 15:45:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25AC310E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 15:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afJywykAp4iOzmcgiGVY8nL7T3WBcY5NAGphI6Nd2msoc8FiSwfTg+p/yC/QXXO/VqW9iBufHWqE7YGT1ReSAhkWut09O9Y+dqARw3HagSSEPRdeUkFr358L7WIpOEYLj/r0cUIhJ+vMZn20N0AoFjR4thUSQh+xyjMLQY/4npR4gu2Va2bfR4k/1dcW5qXjnsYjVkKh40+WfCyYn/NcIjnReeO1Q1qPAW0hEM7mzVVkDxd79MQPFQ4xgTH2YdF3U4PoPvzaJDka+4HB/1toJighxvujmi01n12oDEj6iCKl+RRd6LKTF901J2ME2rFXnhGABMGZ0LYPzqtG/r6ByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez3l/3Mc3B5ew2B9soxw11E65reFTBFUqkV6rnDKnmI=;
 b=FwjILGQ1sSMEQV9TkXXeAHAQd4lrRrygpeNsh/StXePqZbBc++saiRR3Knzj6CxwnuzwIoqbWfWGByv4AOVygA8eB52yqz9Ybsz3isJ3D8OcC82YLz7h2Y+W7A7zXjo6WERPbO4wmv6KoW0UcWeJunmBc21mZrM2s6pgjVCqXT/Hfo2/RVseIL/l+wureIQ8R8hphSQhmxQdC/EugFNindhX6dVJozFAhMi7hURIpG+OSikkoDarY2kAqO0f+HUXerqO5dPsiLRLKWPUmLYDz4isqrgll9HZK1AEJzxx9ZHFB+Gy/xz9TS6lcF+QVN3t75keTgiRlDKRFzE9hUIk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez3l/3Mc3B5ew2B9soxw11E65reFTBFUqkV6rnDKnmI=;
 b=vn7YjwiZd44xVVMi8cQ1TSEp2lqwEiLOaOfhs6LWVAl73VSDlpa9HogEDBObIAonf+SIHxA0jZQV4x5OHLirzOhrfOW2uOdMS/p+o0/azfrM0OE4vnzzxOz0E09jhOQSd5XKkrYqWhMl59z7W12bcOBQ3fiSA0z++UYu/h7Duqk=
Received: from BN9PR03CA0571.namprd03.prod.outlook.com (2603:10b6:408:10d::6)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 15:45:30 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::1b) by BN9PR03CA0571.outlook.office365.com
 (2603:10b6:408:10d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 15:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 15:45:29 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 10:45:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 08:45:28 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 18 May 2023 10:45:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Fix artifacting on eDP panels when
 engaging freesync video mode
Date: Thu, 18 May 2023 11:45:28 -0400
Message-ID: <20230518154528.345112-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: abbd3f8d-24ec-4867-81a9-08db57b6e810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbNKty3VLkG3sMBmnK1A+/wJq0WzOYKxf2lpzf88VxmSxwSKyxcHlMRTe/1mJFfxjO0JlNpAstlb40Ny8pZ+KU0oAeGf3z9gDgfvqMxEWqzOl/OI0XfxyhkZ2FISF2TOqQSGd/t1C5E7kGCGhUfht+etSgly0g0XGOUMAe/AKbCNQiI2YLZYYjEKPronWsP5tu2Mw71PphKuJHXc5SADRtIKxPBh9aDAjydc7L6lXXJOBHGVs1h4SCsQhzai60kGVYO1fO7fLsH145X/QhZxf/zhoOYsUEGXRmbg9Sq8qPBX1ls31LK5sARZc/rjCy2gvSQ1rqwP+ZG9CAC0ARssSHECIedu7xePl4Bkrx2c3MQJkk8RYRLS78Lrwp1e+DiqNR2LCNSXuYZRpAnb+hBjZ7LEM4uKXpo9SF1DagwSt2NSseNuDUiFHX99umw2xHqku3A0FUzr/EqK9rCKs5DNrFHSCjq0etcZJiJmiDOckENkgKjK2zndQo1RiPnEqOAsafAJWUHZm4BLD96Ajrawuge3JjszDVpa5lxpPvOHrcfKTwtiMn4oTKIp5fUfFiX7FWh4B2q5XP1G5HOoH53eSe5f54f0UELg9Tb38cNdZQH65H3y5+XeuCYDV7hkQiqpfnqqf7930JMGEU8fmG5NDqgAEU9Lbl7S8qhD1KJI9dNyuNG9WGv6d413IVboxGxF/qqh8Yz7NFsXOaQeOgK4rRtV9ESkNDRDCuiuJk6UCZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(26005)(40460700003)(1076003)(966005)(36756003)(36860700001)(47076005)(83380400001)(426003)(40480700001)(336012)(2616005)(81166007)(86362001)(82310400005)(82740400003)(356005)(186003)(54906003)(44832011)(478600001)(2906002)(8676002)(316002)(8936002)(41300700001)(5660300002)(70586007)(70206006)(4326008)(6916009)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:45:29.1648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abbd3f8d-24ec-4867-81a9-08db57b6e810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
When freesync video mode is enabled, switching resolution from native
mode to one of the freesync video compatible modes can trigger continous
artifacts on some eDP panels when running under KDE. The articating can be seen in the
attached bug report.

[How]
Fix this by restricting updates that does not require full commit by using the
same checks for stream and scaling changes in the the enable pass of dm_update_crtc_state()
along with the check for compatible timings for freesync vide mode.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2162
Fixes: 541d54055b75 ("drm/amd/display: Fix hang when skipping modeset")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 14b296e1d0f6..7f322b18eda6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9285,6 +9285,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 		/* Now check if we should set freesync video mode */
 		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
+		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
+		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
-- 
2.40.1

