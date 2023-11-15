Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0874C2BB3F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 21:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8936A10E26B;
	Wed, 15 Nov 2023 21:41:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CD210E26B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 21:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCSE9mOErdoZxXOUM9j+dJCAUz0SCp+zuXPZQFGxJi1CMagEP3Mh9jTZzMmnud92y7LVR6cpNCMv7wbXmKsqM6epuffj3Vpew61nVeNdrGdzCEMJx7M0DoYY1xvfww5BrlJ0M/mRiyCvkOwWybAjLURfsBakb7nZTLRUInaMBWwlGbYiOMWQQ3nFq4sVmUXd+UxSD5mAPdjQPJueAjyZWmlrO7qcNFHNgm0rrkO2GqJlJxkhpWRB8L+/eg7tf1q7ZYWKonW6ZTZUnSRnXK85DOx+vpAuC11egTvTV+efW6L1z9mPdLmezgiOqQip6YTWjU2lEsSjXNajijFk/eBt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqQHHn7eHE3rz5I4wjR5g1WU/AaqXlcEbwQ3lgsliNc=;
 b=TwHyyHL+E3GXV6XiiKxcDlViUenSS4+N+KDrs9TARp6TGm/F3j93nb8i78ef1RjhiSxxTQsXSof3OHw/ZkcbqUREEYBHuP9aRvxIIRx5Cb5//AgJCIrTgZb7OPffscHvoR3hAMnVxnuy+MUTCO2LBUWPyZjCUQadwwc7O12KhKbIG1kSdnfhCrh+LW635l47lvGXa88u3sZ4PWMQetorleSOMrt9Vm7XqStVZz1qw3kAH6zyVgS1yGdLxYA/3eQ81RiHQC8JF6oS15rxT8QP6paqBBIGFKcGJ2orCWO8ScQ969UKc0347Qs5ks3lU3FCM7sdCsz8bqBuJ7f7tWI0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqQHHn7eHE3rz5I4wjR5g1WU/AaqXlcEbwQ3lgsliNc=;
 b=tylYlaLiAPOivhKEaaSLGYXE4n0/6x0+hB81ZhPI4uhJJ0VSdz9Y8dKI5a7mkQjfSnY9S4M71TQwEhqCyRy3lgw2igP4HwRo28WJC4q74u+K/3HckhoP+L399s43fBPncwdp0NAAoHV0nI1BNW33x4JgKSTnf4RriW8i6dRCfos=
Received: from SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 21:41:53 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::69) by SN7PR04CA0057.outlook.office365.com
 (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 21:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 21:41:52 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 15:41:51 -0600
From: <ivlipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: fix AGP init order"
Date: Wed, 15 Nov 2023 16:40:29 -0500
Message-ID: <20231115214029.960838-1-ivlipski@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a8c042-6a9c-4bde-7e32-08dbe623ae96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qbW04DyhD+mdrSnXC8ZLM36eCGAG51x5UbVIYqmTCTEGG/noRenmDlRtRb8dGVnROWNc/UgvT1jQh71JHrp83YojgbHgqo8Z3ASqplVnlJhREGkD61jczqMLFkJsr8OYJlqzrUm4+JVtBN/H9RGwAEu0seazVW5DYDKf1hnh9S5dU5GvnWmBn0t4qj+MuzUSsCR/zfE+AdJLqIRSvUWRL+QFlLi9N+ufqVblzStUFWVDb66FpcI4aK4Z262kksbNRPc/Akw+nC7poX8sf1Yotnxrb4TWQ6kH4PQEbwWzDRyt4MviAosRjHtHPNnILKOQVLe2ruAu8uTHh07YrNurCeb/YTFBbJuH2EjbUv7pFrWPf3pRYHKLx8XZBt+7WRn+CI5VRMfAQJEvPX46v5ydib7os56EK1KOVVLcm/J9xqTVIwLgqqqdUgnxJFLw98m6lRBMnwftC59qFLZKyQ4Fy4HF2pEA5j9lzBlg6DqNMqwvSwSXCx8pQgx3FAi8BuRmq/FS+gcsDqaKIiQJwcHUIUpsdUBv1Mzp4/bmCYwumibqXJCPwpNklNAGQcjQ/jbvH8bF8y5IF+LiJzp8QbKjFsSOZApnZGZxVSe8v6YE/j6X2+jvmfa0cM9YJE7dYMud1d0d5aKlJtQbfr/tcc6MIQZj2d6jamkoZ3rwBJDlnkUdwAdR8nHg/06mvtVrPpI9VTB7Sl4o0m84Ped8wvY2wV8Zel4zHP24QNlMuUg3dGVFk6SO6W3TK+hDYShjeJOEG+g5w91J7u43tRZ3jvh2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(82740400003)(47076005)(81166007)(41300700001)(16526019)(8676002)(4326008)(8936002)(26005)(336012)(426003)(40480700001)(1076003)(83380400001)(356005)(36756003)(36860700001)(2616005)(40460700003)(2876002)(478600001)(2906002)(6916009)(316002)(54906003)(70206006)(70586007)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 21:41:52.9618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a8c042-6a9c-4bde-7e32-08dbe623ae96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
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
Cc: Ivan Lipski <ivlipski@amd.com>, kenny.ho@amd.com, rodrigo.siqueira@amd.com,
 aurabindo.pillai@amd.com, nicholas.choi@amd.com, hamza.mahfooz@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ivan Lipski <ivlipski@amd.com>

This commit caused a page fault issue on RX7000 series GPU.
It would occur when running different IGT tests, including
kms_properties*
kms_cursor_legacy*
kms_prop_blob@blob*

It would also occur on desttop after some time of idling.

The easiest fix for it seems to revert it.

This reverts commit b93ed51c32caad2b96cbc8e4754802078ede87ab.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 --
 7 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cef920a93924..0dcb6c36b02c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1062,6 +1062,9 @@ static const char * const amdgpu_vram_names[] = {
  */
 int amdgpu_bo_init(struct amdgpu_device *adev)
 {
+	/* set the default AGP aperture state */
+	amdgpu_gmc_set_agp_default(adev, &adev->gmc);
+
 	/* On A+A platform, VRAM can be mapped as WB */
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 		/* reserve PAT memory space to WC for VRAM */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0ec7b061d7c2..a43d1aa42e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -672,7 +672,6 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 
-	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 	if (!amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index ba4c82f5e617..ee7f3f8c1b4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -637,7 +637,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	base = adev->mmhub.funcs->get_fb_location(adev);
 
-	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
 	if (!amdgpu_sriov_vf(adev) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 42e103d7077d..7f66954fd302 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -211,7 +211,6 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	base <<= 24;
 
-	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index efc16e580f1e..61ca1a82b651 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -239,7 +239,6 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	base <<= 24;
 
-	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ff4ae73d27ec..fa59749c2aef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -413,7 +413,6 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
 		base = RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
 	base <<= 24;
 
-	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c1f2f166f064..83733156ee53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1621,8 +1621,6 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 {
 	u64 base = adev->mmhub.funcs->get_fb_location(adev);
 
-	amdgpu_gmc_set_agp_default(adev, mc);
-
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	if (adev->gmc.xgmi.connected_to_cpu) {
-- 
2.34.1

