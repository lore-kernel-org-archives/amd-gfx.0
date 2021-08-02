Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D56C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 05:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2103F60555
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 05:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2103F60555
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1FC6E40D;
	Mon,  2 Aug 2021 05:16:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761856E40D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 05:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5f/PV00MSaDXwpXp3Z3743YxHYveM69bc6+zIqzKeOeHAvuT0nHt7PP6EYZosgIerLg6b799nl5WDY7XjF2ZO/2DWdFjLnGPnAdpFqRmdAClRZrcJP/CF/QHiMFsxOreOXlt65FJTNIbgVkDnxFsd5pNQlOQ9husbSWgcJAhw5iFvMiPdW46s4SjkUUuqeC4F9uZVSPRaV9hPUvOGc2xxHT+Lp38wUByIsx7gPhPFVbtG2XxP1jMciEj4crJ/IWEtT5As0YZlelOVYe2zX2muP362y6kov38v3gbl8VvhocUsPkU/KesMxAjIwoXY7iVm1Wb+LYOM+TytUFPtUkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQwl7u5xk16wsz5jLWc5ErrGUG6Ft7FKkkNMe1GgcYc=;
 b=E8Dz7J2hkzEitLrqsBA0DTO+2zW8VnpEcN2CxW1ZKSrpLJUgDDsB1wvTplPXWQiSpt1wZXGIaYSNB3Rd1HOKtbHnkULiqvFpCCcNPYbQ1rao5oJLOl4inVvAWs6MYPjD3p6D53wpq8PbU9P23bwD3E418SVHnRcI08gyaKbsH1wthtKT7aHtXqb42zdvuSG8/rF1noSxIujmcOjg5MqqKlHYjFSJPOnV9wfNtPtME0YMU5UqViCo4Dpx0U2nB1ErZZq6/jeDnbLcGtiqBNlXq4QJiqSqfLc5+nanVRhstZWGQNi/KBcaL5gjIIY48wFmCwPxFGEngE67B70gJPOBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQwl7u5xk16wsz5jLWc5ErrGUG6Ft7FKkkNMe1GgcYc=;
 b=JXNDhXtEkgsa7ZW4MMlTcWvpE7Heonge69yWax2kYG24AuFYTxmlu7bIRvSsKWbd/ZL3JCUSU4cLSVsVbfN8S/XtQQjNhUZcSSGOi2tqkbhWLzpRvArIkP++l7o7fY/mgDyNsSWE3cHc3kMRoerCVH5Yam84Zgeai5pSJer+2cU=
Received: from MWHPR03CA0024.namprd03.prod.outlook.com (2603:10b6:300:117::34)
 by BN8PR12MB3412.namprd12.prod.outlook.com (2603:10b6:408:65::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Mon, 2 Aug
 2021 05:16:19 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::2b) by MWHPR03CA0024.outlook.office365.com
 (2603:10b6:300:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Mon, 2 Aug 2021 05:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 05:16:18 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 2 Aug 2021 00:16:15 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Likun.Gao@amd.com>,
 <christian.koenig@amd.com>, <Hawking.Zhang@amd.com>,
 <alexander.deucher@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3 test
 (v2)
Date: Mon, 2 Aug 2021 13:16:02 +0800
Message-ID: <20210802051602.23822-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0328bed3-2944-4c5d-10f5-08d95574a8c7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3412:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34125597390C96B99AB55AC1F1EF9@BN8PR12MB3412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: doos3UC32wefAcDUSz/ZHjKjn+i2UZMkVYeB5pmsjkkv1Ecctzb9nh2jVmv5wY47ASR05RTXOZr+btrIQpP8S/03gDoQ2QIkseJ23AvcXPiVc/cKwRFAImmwBNKXPO9+M8ni0WMyuX0UnOWYNn8FdqHoBONvW2Iw3X4OYzwcMV+TqVp9lcH7N4GHc8iojuZjAojD2KRRxW8B4WOcmyNxUfe8r2DVGdg+vU7kQoiUkVgfyFVcssMZjSVYVD2AxGIh07BM5ibxGpwpX+6ZUq5+yKYpt+vpOyyR7Gcpp/dcFJNgYZXAq+2YDYGnMrLd1QPYgjrvm+rxIQ5Jx/Pe6grhr8k8ePq1AUZDGaFwNfPuyZrz6/84uSCk70wvsVhQPCXFuwcBPlnu4YKLP68SBsogWl8SL/H/iLwLPGmUbN4rnEXKaG8m5NzV6Ycn2sMYbVrsH7vLIrAEM69XCvoZMc1CYDxS36nqMGHi4AevjOWS4GRCZ3u4/Yw5M4whYUMP5L66jKBYnGUitrL/fJ8aqrHgi8ZRPPxv1Gv2vY3DjC62MuiuxC5jYd0ZJqchH7Z0bklmJ3Ov8XvEh7nvNYratw3kej3+l53cIhnZFysMFRF4/3IgKGBSm5Jo/s+cBvGCsI1G4KU6T2LHRqo2sx7hiD3FkoDTF/9hjOEgBgfBfqjZCjaOGyBpSaKkOFV1z5DCnI12zNLtmTAHVWFoJMM+JEoyUWnk8sX1uJcEFRG7OZjhjkY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(82310400003)(6636002)(4326008)(8676002)(8936002)(1076003)(7696005)(478600001)(110136005)(6666004)(316002)(26005)(36756003)(2906002)(356005)(5660300002)(70206006)(70586007)(83380400001)(44832011)(66574015)(47076005)(16526019)(86362001)(336012)(82740400003)(81166007)(426003)(2616005)(36860700001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 05:16:18.4202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0328bed3-2944-4c5d-10f5-08d95574a8c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3412
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

In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
scheduler in s3 test, otherwise, fence related failure will arrive
after resume. To fix this and for a better clean up, move drm_sched_fini
from fence_hw_fini to fence_sw_fini, as it's part of driver shutdown, and
should never be called in hw_fini.

v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,
to keep sw_init and sw_fini paired.

Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b1d2dc39e8be..9e53ff851496 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 fence_driver_init:
 	/* Fence driver */
-	r = amdgpu_fence_driver_init(adev);
+	r = amdgpu_fence_driver_sw_init(adev);
 	if (r) {
-		dev_err(adev->dev, "amdgpu_fence_driver_init failed\n");
+		dev_err(adev->dev, "amdgpu_fence_driver_sw_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
 		goto failed;
 	}
@@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 	amdgpu_fence_driver_hw_init(adev);
 
-
 	r = amdgpu_device_ip_late_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 49c5c7331c53..7495911516c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 }
 
 /**
- * amdgpu_fence_driver_init - init the fence driver
+ * amdgpu_fence_driver_sw_init - init the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
@@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
  * amdgpu_fence_driver_start_ring().
  * Returns 0 for success.
  */
-int amdgpu_fence_driver_init(struct amdgpu_device *adev)
+int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
 {
 	return 0;
 }
 
 /**
- * amdgpu_fence_driver_fini - tear down the fence driver
+ * amdgpu_fence_driver_hw_fini - tear down the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
@@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
-		if (!ring->no_scheduler)
-			drm_sched_fini(&ring->sched);
+
 		/* You can't wait for HW to signal if it's gone */
 		if (!drm_dev_is_unplugged(&adev->ddev))
 			r = amdgpu_fence_wait_empty(ring);
@@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
+		if (!ring->no_scheduler)
+			drm_sched_fini(&ring->sched);
+
 		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
 			dma_fence_put(ring->fence_drv.fences[j]);
 		kfree(ring->fence_drv.fences);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 27adffa7658d..9c11ced4312c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
 	struct dma_fence		**fences;
 };
 
-int amdgpu_fence_driver_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
@@ -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   struct amdgpu_irq_src *irq_src,
 				   unsigned irq_type);
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
+int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
 		      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
-- 
2.17.1

