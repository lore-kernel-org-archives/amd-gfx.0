Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C8BC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 10:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6216160C51
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 10:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6216160C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133546ED1A;
	Thu, 29 Jul 2021 10:50:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEDD6ED1A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 10:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz2ToPU8EcaL815JjwjFxWw3Vq0XmrLYCpMeWP+Jqt+wK4pMvgxhFlRHz9buKLHHV4sZENRhib+YVaDNzZfzz27AkV76P9FpibeXhpqvMaTJyCnr6HA1sTRKI4pN8KHFV0HHSlKsK3hTeqenD0Azh2uXiJ1dp0JP8jGvQ5yJUGaBDgtp8ouWb6RsJ7jXxHWx2abPLXEBUwk/cAgY2trMohN81FyRgTDUxnYwKvWMtEHQERFHt2zYFktioJQpx9OcLBpeK0Wn0eCVnqu0huXYesKJ3ow/tAXRmdRd48pcvq5QqiiokuDRnfpLUtczJfvFTdctib5NYZi2S5Y2GYBujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkN/ATcbO4+OgFTOS0E6OqK+1W3Rt8y+EiB/3eUwg8o=;
 b=cgSAr2r8r5Cy2LvdJ/jgTnsIF5C8DK1Moxzi18U1oVFrbnDLGunFeCgOz7oaz/cZB63QY5QUwXaghw02GH/p8p0HfGoXR2AT6ibc1oM0kkGxrn36YRbrvfLx0+bKeRlJ1wmIy+RyuPH8p04eO2ub0Zd9SdRkHhagLx2SkLjX9sDf8fDSnyuHA04fzul6Y0Dx7SEo2d7PnrQsnzq2J/eXnxR2pClcxJrsqQ+psxKEH8mhkVoBZLSPTBtmPEjUNGc/J+2CBtBnO/pmqWayJQ8lc/hh/yYPVcf3FL5Z1xTLb/M+ctZDLz46JlR/kMikVaWO9R6wBbqqVG25dXQcs284qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkN/ATcbO4+OgFTOS0E6OqK+1W3Rt8y+EiB/3eUwg8o=;
 b=PPghfjhcoha2kAjt8KGybhCOcCz2tmge27/5CeSeb7tMehrng6dpqSlaK6pGPV/kZAWtRPrsBlTK/oPGv+Xi0Xl19t7vYqGhRJ1PQ+LJWI8lDYChyrW+81bmmtrAw+TGw017z/8VNQsiUfmPjaGvvHymy1liIm151PDX39gIDW8=
Received: from DM5PR15CA0026.namprd15.prod.outlook.com (2603:10b6:4:4b::12) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Thu, 29 Jul 2021 10:50:07 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::19) by DM5PR15CA0026.outlook.office365.com
 (2603:10b6:4:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Thu, 29 Jul 2021 10:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 10:50:07 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 29 Jul 2021 05:50:05 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Likun.Gao@amd.com>,
 <christian.koenig@amd.com>, <Hawking.Zhang@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3 test
Date: Thu, 29 Jul 2021 18:49:45 +0800
Message-ID: <20210729104945.25312-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61d9f597-467b-4c7c-1cd9-08d9527ea15c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4958D77CB50F5EC57FD6E2EFF1EB9@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsnAwst1lKTloKnbTapAHRN4jNJ00hI6MRy7AingR3PDb9Xe4bwtjt366eBb+yE+SdmKyaRWcgOA8CdspGa6TDvstPXOIWrje5EHVMFMFKYrcTt0XxTm+ddwlbeepq4+jAEKzpCY/BBPLTB+AzARVvXpiS/kFBd7ka6u6ucdhEU+yStfzYI0cMlKqh1y9iZeN34jwyHRmyScXB9eauwGCCSLrx2l1rMHLU5g1NdRcLtyBgnRq3FnV3RF+8bN6pYssTK1ze25Op1SJJGoqiWUXRHVwtMs0U0cVCnUXngG0lvAj6ZTEXAyOK+34am6U/fVl6qm8S5OG3qifQeIDZs5WCzBvaYnPBhE+V6lusrLzRmfDOL+V3myVu9+e8BGg4BdK3/4YiNtUGHhUu8kVkUvj76nIy3scU+CdrmipHXUddy6zajwZT0GeQpl+PPKMSoMUxrioCnDv048m1iCPlUgMgz9U5sI6NW/8XdZz5pHmA0CRFoKh4qCda7i21S93SZDFzyVXlRpgsSB+JtIW3I9ZAewvAwJ83qQFvdenPPjfEMqeMmLCIEvfQYROKzQ4Ye0MUrWdMix7AuJ/IY7bSJwD+aUKMPvslwYAviUCckvaGy9cPuotIuJfnxx8HrPey1Fh+N+RmRWN3Mmq3Gzc5y6h40+Thyi7c3VjEnyxrrCFJS4fn3Ji615Yt8cMrKES3K1OjF4KIDzmDs/aeWi0Xz/0fhv0hzq/R6/8klS7vsBPOo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(44832011)(81166007)(6666004)(86362001)(16526019)(5660300002)(26005)(47076005)(83380400001)(356005)(7696005)(336012)(186003)(82310400003)(316002)(110136005)(2616005)(2906002)(8676002)(36756003)(1076003)(4326008)(36860700001)(70206006)(6636002)(8936002)(82740400003)(426003)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 10:50:07.5231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d9f597-467b-4c7c-1cd9-08d9527ea15c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
scheduler in s3 test, otherwise, fence errors will occur after resume.
So introduce a new parameter to distingiush the case in this API.

Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b1d2dc39e8be..aaff8ebbb7dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3844,7 +3844,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		else
 			drm_atomic_helper_shutdown(adev_to_drm(adev));
 	}
-	amdgpu_fence_driver_hw_fini(adev);
+	amdgpu_fence_driver_hw_fini(adev, false);
 
 	if (adev->pm_sysfs_en)
 		amdgpu_pm_sysfs_fini(adev);
@@ -3941,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
 
-	amdgpu_fence_driver_hw_fini(adev);
+	amdgpu_fence_driver_hw_fini(adev, adev->in_suspend);
 
 	amdgpu_device_ip_suspend_phase2(adev);
 	/* evict remaining vram memory
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 49c5c7331c53..7e6a73c2919d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -515,14 +515,15 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_fence_driver_fini - tear down the fence driver
+ * amdgpu_fence_driver_hw_fini - tear down the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
+ * @in_reset: indicator to distingiush device removal case or s3 case
  *
  * Tear down the fence driver for all possible rings (all asics).
  */
-void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool in_reset)
 {
 	int i, r;
 
@@ -531,8 +532,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
-		if (!ring->no_scheduler)
+		if (!ring->no_scheduler && !in_reset)
 			drm_sched_fini(&ring->sched);
+
 		/* You can't wait for HW to signal if it's gone */
 		if (!drm_dev_is_unplugged(&adev->ddev))
 			r = amdgpu_fence_wait_empty(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 27adffa7658d..42cbecfc26a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -115,7 +115,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   struct amdgpu_irq_src *irq_src,
 				   unsigned irq_type);
-void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool in_reset);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
