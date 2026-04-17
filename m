Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73257F8E49F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 17:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082ED10E2CD;
	Fri, 17 Apr 2026 17:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Js6Sqpwl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F4210E2CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 17:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9W9is8xjXaba/MnctbcJYZM4y2kC1ayewQpEB1ei6AXzXIRqliv4G7fiT38+bSCOFmeXZI40g5O0vq2fkaRUBz+0TdncrsfsALp+z0IHUX37yztLwZ6NwR5hvNuY1R0DPyr8PKaQ1W9Hn1c86E7Z9pOXKIpM2V6kKwBiRa9sn5sSQo/gHXW/cYsP2hEDTJhjs65rwQ31Zt0RKzlp3MX70tuP4MPKsAUxqnC/qOeRD81Hj9LPYzTxb5kSXM2W8oLARqjcleBvFNZXzU0yW+f98dIJgpHTwXbgnjMRdr0Wawo1hDAqyXPgYgYstkE+bbn9Bp+EXIxQPfeiqFszvJHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLITEeWbSqXemnkz3Uqmbw3/QadvypJ7NratyuihySM=;
 b=JjpQlt8E7UTLEz/NcFGvwL+Sltpp/tj7DoVhH7CyhKEyCtFyad9jorE+IuOCTFfqHwiFfxWancES3jQiZj7SqUFBQWHwpRkftEvqRtJhaekQK+63xYBJxVxPeip3xv1k8utnP/y2JHeQhAbV9kyR1KTnRAYoaioa721xiXpdXACrtHrTJXNN2ylNGEQ9LjXVSykTku8FALx9E0mFQNdcogstI+AfxlWA5PVksz7kRhPIQp498WRzC8Fe0h5JjPbPRhnuryVgKClBD2du07td+07UNLq9PdYfnMipSGgpESo9p/A8OJ/rbUC56gXHfms0sFSVkSLh/+yNedOut50zdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLITEeWbSqXemnkz3Uqmbw3/QadvypJ7NratyuihySM=;
 b=Js6SqpwlGBgbeqdTLcIdrFdx09gSYsuw0/MCrrQ6GEKZIFJwBnPPlb7przG2JZCi2eDadY5Eoc00q+lLMkHxmsFVfWkIwpKs4G11SZLqn1p0tVFeyZ+ut0lKBRXXuBQJVTb3YgVdyaBMDS/oJZDh7U6vz44mwUZJLCmmE+Ph2Iw=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 17:54:55 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::95) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 17:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 17:54:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 12:54:54 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Fri, 17 Apr 2026 12:54:53 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <superm1@kernel.org>, <Ray.Wu@amd.com>, Leo Li
 <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Undo accidental fix revert in amdgpu_dm_ism.c
Date: Fri, 17 Apr 2026 13:54:30 -0400
Message-ID: <20260417175430.47434-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fd54af-4b31-49f2-7d27-08de9caa6ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: QO/y5Bd0JCc+dXd8qsaWHkfYiJMfQw0mi7/Er2cyI6hRknOJJV852kfyhEAypxPXEDhuQrAI/Nicwiphfagnzo4OYVNPsYHt+KWpq+QrAxRwWsCAgnEB/Y7ldECmHRPGjhBWcsqpNUWSR6QBdkkJrNeV1WIZaB1cQxhUo2mR0nGRRFvmaUhak43vMxg/CQfqLhFyRbHRj7r7vj20lYTrgAKp1Nl7dbAXW1U34IKG9J5In/sG9o4rElFmnP+HIJ9oL6vco4cLmr5RePVS0/eSwuL9qc/uA2xKRRDAcNTRtg1zVMnve9BwaDQpEZkktz3aHL/eLLJVpinaBEkXLIMyT3j7tRO2ZOI7wJoMXhrOMCztnYVEhmSlGjrJlZ9B47+NHBwLVdd3MiiBwbHn+cFTBGB/7y/d0fWzMg7kdfgH3iG5dA4F9jmuEkIVHJm7CdKdlZxjhQI/s5vtT5JMeBGqpYiQ/wn4ASmdr2g1wdULSd8UzYZzDJ1HnQaLHXedTR4zoJ9X0+t0k+0pyl6llc9tcIU6LztFu6O/CVOR3YgxjY6zvcjImSCsPJVFOxXHgSC7GcCMK5qSlfY8Jg1NpVh15w5/E0FR505vtUS22ZKKti3458XgsglecHleX/8M6FCKhQcX9PFLly0ewXTL38Gq3sywA/bT0xMhJ7MBENXpPHmQFhQFvZrt+Nt7RLDQnr9iwKDb3yzPVRegtCh5wQEqoXeG3ISU10cw8Val9osUkJ5mOX9Aonp/I5jDNVshnp22ko8PHKQVxic+7fIb/+aq2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y8z9uVIIU2e2/osai5wBX9A4HNHTrfPNM685FN2WhyO7F/G/0VfMZ7EkCs/ws5s0gjDoC/4ormTUrRN61Ey7Uq4zqKiWwxfJxercC7JTRCDDAOQdtxtUNSKJykoEbs77KjqW6Unlpa3wreGW6ZiFJA60yk9n7XsKRbwd3UmzbZHXmJFBFh9hI2tEOayJb8tpdNN3sEYrfrJZ8gkGHZnjXbd10vkvN7CiK23Qth1enfXWe7OAMgNH7XQE+hy0WLHHX9NlHpOHKhBxAhT6TxhiT3fySrT3AcxkZlXy1h8CnyCcJa8BxmHWYVItLC1VuRQn21HQmK2RNpGI+HmfIFQh9ufYREhCS0O+q0RsKzYx+hHG9zzj5mxJU2sEJCi43jiUhnGaWicdFHeALXk7IZJuYPS3T4m33vjmy+mhZ65lJivL6sJ6D4fX6qyJbaMjbORN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:54:54.9960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fd54af-4b31-49f2-7d27-08de9caa6ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

Pausing DPM power profiles during static screen caused a bunch of
audio/performance/clock issues that were addressed in this fix:
1412482b7143 ("Revert "drm/amd/display: pause the workload setting in dm"")

This logic in function amdgpu_dm_crtc_vblank_control_worker() was moved
to amdgpu_dm_ism.c, but the fix was lost in the process.

[How]

Reapply the fix to amdgpu_dm_ism.c

Fixes: 0b572a6bf04a ("drm/amd/display: Add Idle state manager(ISM)")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index d2f47c69921d4..d03ea3bafd469 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -270,7 +270,6 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
 	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
-	int r;
 
 	trace_amdgpu_dm_ism_commit(dm->active_vblank_irq_count,
 				   vblank_enabled,
@@ -315,16 +314,7 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	 */
 	if (!vblank_enabled && dm->active_vblank_irq_count == 0) {
 		dc_post_update_surfaces_to_stream(dm->dc);
-
-		r = amdgpu_dpm_pause_power_profile(adev, true);
-		if (r)
-			dev_warn(adev->dev, "failed to set default power profile mode\n");
-
 		dc_allow_idle_optimizations(dm->dc, true);
-
-		r = amdgpu_dpm_pause_power_profile(adev, false);
-		if (r)
-			dev_warn(adev->dev, "failed to restore the power profile mode\n");
 	}
 }
 
-- 
2.53.0

