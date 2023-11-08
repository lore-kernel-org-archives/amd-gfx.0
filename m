Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF34C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 18:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD7510E188;
	Wed,  8 Nov 2023 18:42:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC3C10E188
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 18:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdIxFUauLioP7fDt/GcmAQcf7lPxlXVkFcISwH08ch8fIheR8hCZfBUud2pw+S79YyfVkl1VbeRDWiqv7RwRubFzj1CtRufX223BwxHDUfmuZFdCVMyPtBZxNo0/0U3VrGwRCOMgl2ZVB/QxzS54V92SbXpAxLpRml4MIJAsq5qArThOMQQ3dNEY74BnXTbNaPi3J949aSMqVLkoVPNlSiZG8kWsdd6wMnXo4mq/cjp2K/qK78j0tAd8u3gcaEcudbQaG/KhcCL7WOu6ltkAAhznhy5XpSBL1kO5Y1IZQMotIsqOT1L+/GlIMoBABetKvBj3StXTKxU4aa1B9649ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ1A6R13R9AAxsLag1XnGB+HiT6gCXWVhEqmLEKokIg=;
 b=Y3nCzMqVvSDrDOyIeBgoLKmYZmMxPmr4DbdT1L59ihnX5xaCl0/QijF7zE2rVVJeqWa2VqVnpEsO0p2E34gMD7XYxOcUkVCPjszACaHdqPqsBz3rrZisoCFTcdFF5wVFDM03O+h9gwFiOlIlOE1v0RyIu2Z50lX3WCgkIgxfZrudqZbKcWhnjfRlWU+OU3aDc5FQwMORi69mAkDmRIEN8EpFKEwwJchcJvYednHW+6myPbJ9wf2rz7/o4vKHbYnFzpbpoCTEAn0KCGet0IHjAoKvdBNwKJO/9I9ux6hdOk2O1ZyjRHMQpdXtNcmdLpvg2O2xoSSrNkg/mp1SfIZhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ1A6R13R9AAxsLag1XnGB+HiT6gCXWVhEqmLEKokIg=;
 b=zE0MHS6H5mp1YvVSXb9RwuMLwrwf5tWy+Ky42KnfWyNIsFry2G1JeomxXX7CdaOitWvXxRsweaLM5R+6Z9kh9iylQpn0asDAi2NTWaSEQg0WUwTb3CSM70hug/LC1EfT+pBoT/56nCX6zRz/nsNL+7CEVe0EFWiBfIk7oF2XCJ0=
Received: from SA1P222CA0130.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::21)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Wed, 8 Nov
 2023 18:42:21 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::66) by SA1P222CA0130.outlook.office365.com
 (2603:10b6:806:3c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 18:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 18:42:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 12:42:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move UVD and VCE sched entity init after sched
 init
Date: Wed, 8 Nov 2023 13:41:51 -0500
Message-ID: <20231108184152.4755-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4983af-6855-4b72-c783-08dbe08a7121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYMh27LpGIBhpTMnmOgLU66VedRapMv0kswoj6+MwBDGaVwQdlmUeRyaWAHnrGTLxv12I9Kd1hl3T1FDGsyPfkrbD/yMjhS3+zrGxQjv6iHxFBHppMJIMU+A6CTMY4OtsSbERsNZtuR6HkLH0quBzUfx6eAvV0ZRTr+vUYLZG57GWIcpUlyUdjUr9GM2b/WWl0Ikm1cRXEMAC5u0+ku1JGW37VuqPCriYDy4Qbmue1BubyWOKOVvfAVQoZEO2q30MWtZijOcPwAGUKzG9+TNjpQlVLLOJvGlNt/2wqnx9pC9f37unxMoMfANElJkjwjSo6aXskZPqM8FrdRdAFwYTjIg4OuY0Vmg6Y6RYCDw0dg0ICpU7sL9iRZEPkUS+0cuAhZPwtlYvi/PFNUu2p0Vl+cUpFNojHjzKrJfLpQgH5A4YAWFA3mbeKFGN1Dpp3mbKJ6XUbvsqQDP/Mdi+2WjhJ/uyz+BkGy1RVGTJgIQckylQCoO4nQM5lGvZfJulmkmOgvoK8uP3Xc26js1gnAfFdWADWFr/QulrggCZjrfzr7oL+nlikUM1CpzKgw1OFnNApTdhryTNXTlN1Mhgb8G4KbwWkyXlPYmqqa0Bnzwiy4a1hasXcdHLo7mF7TUo1ZfDqX7kia4297gEvKYBDxT0PFbRVCkRd77zqSGEhppbKNNh1u4muwEx0E9K3uTbakzlG/BcF7ifX9Tjk7ZYRqrv2eJg8M8g+TXKP4ucrlsh7bszHkuvUmgmYXrU6NjXE1fA4EdgPs0k/0Nwb/ydFzs3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(66899024)(36860700001)(40460700003)(5660300002)(7696005)(36756003)(2906002)(82740400003)(86362001)(356005)(81166007)(41300700001)(83380400001)(8676002)(8936002)(4326008)(2616005)(1076003)(478600001)(316002)(54906003)(70586007)(26005)(6916009)(426003)(16526019)(70206006)(47076005)(336012)(6666004)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 18:42:21.0579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4983af-6855-4b72-c783-08dbe08a7121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
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
Cc: Alex Deucher <alexander.deucher@amd.com>, ltuikov89@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need kernel scheduling entities to deal with handle clean up
if apps are not cleaned up properly.  With commit 56e449603f0ac5
("drm/sched: Convert the GPU scheduler to variable number of run-queues")
the scheduler entities have to be created after scheduler init, so
change the ordering to fix this.

v2: Leave logic in UVD and VCE code

Fixes: 56e449603f0ac5 ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: ltuikov89@gmail.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 22 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 24 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |  4 ----
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |  2 --
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  5 -----
 13 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 43a95feba884..03e669c34033 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2499,6 +2499,18 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 				  ring->name);
 			return r;
 		}
+		r = amdgpu_uvd_entity_init(adev, ring);
+		if (r) {
+			DRM_ERROR("Failed to create UVD scheduling entity on ring %s.\n",
+				  ring->name);
+			return r;
+		}
+		r = amdgpu_vce_entity_init(adev, ring);
+		if (r) {
+			DRM_ERROR("Failed to create VCE scheduling entity on ring %s.\n",
+				  ring->name);
+			return r;
+		}
 	}
 
 	amdgpu_xcp_update_partition_sched_list(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 815b7c34ed33..65949cc7abb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -399,20 +399,20 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
+ * Initialize the entity used for handle management in the kernel driver.
  */
-int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
+int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
-	struct amdgpu_ring *ring;
-	struct drm_gpu_scheduler *sched;
-	int r;
+	if (ring == &adev->uvd.inst[0].ring) {
+		struct drm_gpu_scheduler *sched = &ring->sched;
+		int r;
 
-	ring = &adev->uvd.inst[0].ring;
-	sched = &ring->sched;
-	r = drm_sched_entity_init(&adev->uvd.entity, DRM_SCHED_PRIORITY_NORMAL,
-				  &sched, 1, NULL);
-	if (r) {
-		DRM_ERROR("Failed setting up UVD kernel entity.\n");
-		return r;
+		r = drm_sched_entity_init(&adev->uvd.entity, DRM_SCHED_PRIORITY_NORMAL,
+					  &sched, 1, NULL);
+		if (r) {
+			DRM_ERROR("Failed setting up UVD kernel entity.\n");
+			return r;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index a9f342537c68..9dfad2f48ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -73,7 +73,7 @@ struct amdgpu_uvd {
 
 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
 int amdgpu_uvd_sw_fini(struct amdgpu_device *adev);
-int amdgpu_uvd_entity_init(struct amdgpu_device *adev);
+int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev);
 int amdgpu_uvd_suspend(struct amdgpu_device *adev);
 int amdgpu_uvd_resume(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1904edf68407..0954447f689d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -231,20 +231,20 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
+ * Initialize the entity used for handle management in the kernel driver.
  */
-int amdgpu_vce_entity_init(struct amdgpu_device *adev)
+int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
-	struct amdgpu_ring *ring;
-	struct drm_gpu_scheduler *sched;
-	int r;
-
-	ring = &adev->vce.ring[0];
-	sched = &ring->sched;
-	r = drm_sched_entity_init(&adev->vce.entity, DRM_SCHED_PRIORITY_NORMAL,
-				  &sched, 1, NULL);
-	if (r != 0) {
-		DRM_ERROR("Failed setting up VCE run queue.\n");
-		return r;
+	if (ring == &adev->vce.ring[0]) {
+		struct drm_gpu_scheduler *sched = &ring->sched;
+		int r;
+
+		r = drm_sched_entity_init(&adev->vce.entity, DRM_SCHED_PRIORITY_NORMAL,
+					  &sched, 1, NULL);
+		if (r != 0) {
+			DRM_ERROR("Failed setting up VCE run queue.\n");
+			return r;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index ea680fc9a6c3..6e53f872d084 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -55,7 +55,7 @@ struct amdgpu_vce {
 
 int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size);
 int amdgpu_vce_sw_fini(struct amdgpu_device *adev);
-int amdgpu_vce_entity_init(struct amdgpu_device *adev);
+int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 int amdgpu_vce_suspend(struct amdgpu_device *adev);
 int amdgpu_vce_resume(struct amdgpu_device *adev);
 void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 58a8f78c003c..a6006f231c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -577,8 +577,6 @@ static int uvd_v3_1_sw_init(void *handle)
 	ptr += ucode_len;
 	memcpy(&adev->uvd.keyselect, ptr, 4);
 
-	r = amdgpu_uvd_entity_init(adev);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index d3b1e31f5450..1aa09ad7bbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -127,8 +127,6 @@ static int uvd_v4_2_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_entity_init(adev);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 5a8116437abf..f8b229b75435 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -125,8 +125,6 @@ static int uvd_v5_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_entity_init(adev);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 74c09230aeb3..a9a6880f44e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -432,8 +432,6 @@ static int uvd_v6_0_sw_init(void *handle)
 		}
 	}
 
-	r = amdgpu_uvd_entity_init(adev);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 1c42cf10cc29..6068b784dc69 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -480,10 +480,6 @@ static int uvd_v7_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_entity_init(adev);
-	if (r)
-		return r;
-
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 67eb01fef789..a08e7abca423 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -441,8 +441,6 @@ static int vce_v2_0_sw_init(void *handle)
 			return r;
 	}
 
-	r = amdgpu_vce_entity_init(adev);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 18f6e62af339..f4760748d349 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -450,8 +450,6 @@ static int vce_v3_0_sw_init(void *handle)
 			return r;
 	}
 
-	r = amdgpu_vce_entity_init(adev);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index e0b70cd3b697..06d787385ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -486,11 +486,6 @@ static int vce_v4_0_sw_init(void *handle)
 			return r;
 	}
 
-
-	r = amdgpu_vce_entity_init(adev);
-	if (r)
-		return r;
-
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
 		return r;
-- 
2.41.0

