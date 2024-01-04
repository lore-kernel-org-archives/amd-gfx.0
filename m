Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783CDC47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 05:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2EF10E385;
	Thu,  4 Jan 2024 05:39:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67E810E385
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 05:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqfbbcNI5pfGlysoLo37h2P8yUpKRe1jofVZX7P/cwIAKVWwqd32yUf3O8TrAoJ0J/PsJAcz8ZQYfAxEm+KlURhoWRhdfFeeR18VXu+rCMhEbenj6WXDCouTA/W00JTnMSYm2KF/C1iOnkSywYbAnT8udPAjUcWwawNX4XKpjLVhennBWWT1V2DcIk1wEskxoz990Ea/CiGx3MJPyYoShhHm2fEHvZL/VGMnbL+uuMeT81Nfcz8Ycc7XCdty4egkA7A0ScF6Kmvvc9sbUokNpHo1trU/4aw/ZmuUQinWnstqxO27/7RJghTL0bG9VFi37hlgmvNoAKvMCkkQeigP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HIXXmsRzqVY2IEjq90++aRp690VtX42oaPund5FIEI=;
 b=U5tK9Ho6D2DvQXu6ow9YlyaqoZbcGKhYwsANNDJrqh2A/nKXD9L4GUz48sH55luHmnCxe89S1r8O3XcYaDNI9aRjKzMQt70rUsukAQ/7xrXs7Rc7xyh7XTviuMxQTCPp6H/rnyU4jTGKWX4K8UO8bI7kT9/UynkygGf67U709hi+x4IT9fPw9+tqHh+oRENUH9uBvXBLrEGGLIZtPASLUOULp7WP0KAQ8fuw9KnEjZdM5qOd/bP+8prB0J41sbDS/LVYxpTOReecvHGX8AXc+P7y9/MV+jw0imnmjbElJ1NbWQ/p4gfCF1eMxUCzNmKKbRg1NEygQyWAHB2lVxVsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HIXXmsRzqVY2IEjq90++aRp690VtX42oaPund5FIEI=;
 b=2RHQmq9zrhxJWV7nosx07ytRgkY6PZIvkILLrio8uWYKyjn7MKIrpS9v94WAdBSB/Hek/NJC6jnTSwO1ML/epmiRmj862YCjy5Bb5DPVj2MOQNqVsz7nCXLBRCG5H0dkGoGhc6deoEBIqVpfiJuQei3/4eist6UfTNy9MRPOMYM=
Received: from DS7PR06CA0032.namprd06.prod.outlook.com (2603:10b6:8:54::17) by
 PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Thu, 4 Jan 2024 05:39:20 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::25) by DS7PR06CA0032.outlook.office365.com
 (2603:10b6:8:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 05:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 05:39:20 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 23:39:17 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the warning info in mode1 reset
Date: Thu, 4 Jan 2024 13:39:02 +0800
Message-ID: <20240104053902.546605-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: b002cda6-e313-4725-2046-08dc0ce77ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtukFgjFFwKuRq4AdfhxzaPqUASNX+uMbrVRjuuXdr+C85zOsTHa1r1UE0+18jhuDlD+OkWZPlC0S+1p7rOreluaxV+WJ0FIUWzDRLg8+9I4VGxrWZjHY96v/QpVfdYamMUUO2M4NW4EHVS+8dFkqR+1u8UnLKfBxpYbg4lXotzOcKJ0/LANhxeyAPlxckv/zYkxlpAcSTAbTfTYrEObtsoPzi1hNGm7P7yYxeLrFPdznCMiP4pjtQ32dkF8LiS/WdX3Vh9/B6nFQS2+TNBH4EhrbRnCzYU9dkCp3kMHj+Ct1IBZnr5RkC6P1VzSYwPVWmUzeXoIM4qd808hAysgsPdT96K+FwTOdZUxEJDySaBBl7vvsa2VU3MXqZlfDCjfYFDC8ws53tpKP1I2V6t/wyCzehKgOapRr8Ob47SZuf3WcFmPvwJRZ5JNxmoN5D23nSljYqS4jR7Hhrd++Vqo9n8dOVrGSajqYCgB1T2YBFFqcMn2bF0o5j6ThA6W5ur3KwL1aHZtKH57BpHWsg/4AX5ZWN69juxlpHHM4hcPEc+WY11A6GBrrNMXt2KV9j3eAXAiXeXxKDR360VYkmWZRsQ9RL0U4rMEaZ6eGgCGE/ufrX/24pr3EJ84begevujw+0cvfshMvNeFDjXVKe6fk/t4vUFTDWFed9uq1+dkf2xaKZs28RXtcCOhHTUXmd9YcRmVSECeRNzoWUIsTRrxGacvuQltKDIaHptRmi40s88FyAbarwFUj+EZg0BbqxGnhFiGo8G8ZZEFq8QusatpCfsRgDOQ0hygU6OGWeI05G8WzhJSX7yBPcjUsbeIMeUt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(70586007)(6636002)(110136005)(70206006)(54906003)(16526019)(426003)(2616005)(336012)(26005)(1076003)(83380400001)(40480700001)(40460700003)(47076005)(41300700001)(36860700001)(82740400003)(81166007)(356005)(36756003)(86362001)(7696005)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:39:20.2661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b002cda6-e313-4725-2046-08dc0ce77ffb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning info below during mode1 reset.
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000006]  ? show_regs+0x6e/0x80
[  +0.000011]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000005]  ? __warn+0x91/0x150
[  +0.000009]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000006]  ? report_bug+0x19d/0x1b0
[  +0.000013]  ? handle_bug+0x46/0x80
[  +0.000012]  ? exc_invalid_op+0x1d/0x80
[  +0.000011]  ? asm_exc_invalid_op+0x1f/0x30
[  +0.000014]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000007]  ? __flush_work.isra.0+0x208/0x390
[  +0.000007]  ? _prb_read_valid+0x216/0x290
[  +0.000008]  __cancel_work_timer+0x11d/0x1a0
[  +0.000007]  ? try_to_grab_pending+0xe8/0x190
[  +0.000012]  cancel_work_sync+0x14/0x20
[  +0.000008]  amddrm_sched_stop+0x3c/0x1d0 [amd_sched]
[  +0.000032]  amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]

This warning info was printed after applying the patch
"drm/sched: Convert drm scheduler to use a work queue rather than kthread".
The root cause is that amdgpu driver tries to use the uninitialized
work_struct in the struct drm_gpu_scheduler

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  3 ++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b1d5f42249f..7bac3019aa0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5575,6 +5575,16 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 
 }
 
+static bool amdgpu_is_ring_sched_ready(struct amdgpu_ring *ring)
+{
+	if (!ring)
+		return false;
+
+	if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
+		return false;
+
+	return true;
+}
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -5700,7 +5710,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!amdgpu_is_ring_sched_ready(ring))
 				continue;
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
@@ -5776,7 +5786,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
-			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+			if (!amdgpu_is_ring_sched_ready(ring))
 				continue;
 
 			drm_sched_start(&ring->sched, true);
@@ -6265,7 +6275,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+		if (!amdgpu_is_ring_sched_ready(ring))
 			continue;
 
 		drm_sched_start(&ring->sched, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 41266bc99345..3650e4d06e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -636,7 +636,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
 		DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
 			      ring->name);
 
-	ring->sched.ready = !r;
+	if (!ring->no_scheduler)
+		ring->sched.ready = !r;
 	return r;
 }
 
-- 
2.34.1

