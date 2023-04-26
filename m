Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F336C7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280F810E340;
	Wed, 26 Apr 2023 21:22:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AA010E329
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk21PbEM+RfpKYGpGZ3XmlVvsnA1uO/EYlcI+Qrvz9T9BBGM8e0chdBay28Ji9IYJtH+b3K36/2b4ZU3IAf6tbaxWuK+GadoYcoYGdPETpcs33rasYbqYP4JTE91l3woDaCXduv83k4JezCfEx7UdsITFbmAzIGlsBHhsP1/PkY+gpKgmvhixjqTFwgqP26ZJcUHxI8egXid3drkQyDQK+m6R+E4mUv9Ets0ezHhncYEFQPsbeVBhE+pWyod39Pphf2shHzC+hwU2g1ooG7FQsb/gJE2YIL8wQ1FGcAwxbE9b17pCct3ayOk7KfgkE+9jfaMHBwpHO+EuFz4jRWlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUpYRom15tCjlAiHCobe+vYI9krGkphgDxiLaqCbrPY=;
 b=nGO15WgSxtY5EogsAENH2E6Cnhh7qwU4Wi84R+R+tZ+VC03+/Ky0kMX14P4hWvDYfayKUOITpiWymQeEPddb6VASFb109oBZLw7NBkEO7pnhJckprfSlbhXuLZ7FDK0KPVvjyLsLcyATNwTX2mLCZUWahm7otasCCPDS2s5b5oreNbhSJSevLnhOrC1txvKEvUwGAr3NAjpc4ik+osvOJ7yAWvEyrBYUKZqocmUCkvJBj16mFeFS8MGbLOnUKIoRfNpKgJD3eJZ8rjF9ebxm6rYNOrulA+gAWbLSvOCOCAtQgmJMyMnYxs9QbuP+IVDXhJX/FeFbOuhZN5NucA/JZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUpYRom15tCjlAiHCobe+vYI9krGkphgDxiLaqCbrPY=;
 b=wpxBHfJscnO8XHvygy52O8hel36Fct01sXnGHo0OSaUiPa7+fqWYNZ8XG/x1XfsAIg7t7wrCP7+opIFGnnthIgHpHcHxKstNoU03d6Kc+L135vtUORJoLjdosRS1aDriKGppsAZCUHwJ6hibgpIYu3GiXAJC+uZPk/2CxrKNJOs=
Received: from DS7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::26) by
 PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 21:22:00 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::77) by DS7P222CA0017.outlook.office365.com
 (2603:10b6:8:2e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:21:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amdgpu/gfx11: drop old bring up code
Date: Wed, 26 Apr 2023 17:21:32 -0400
Message-ID: <20230426212143.7696-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2a72a8-34be-48c0-4a33-08db469c45b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6ohCAs5TE8cgslQMXwMDOYZmrP62nrsbzUq0PXYQoLXIUHOOc017G4EzGKGMYpZqBublSNny3dv6G+pqnI32XW/Rgy9vLhYWsb+G/QKDEU8qKalB9zAZQV+w2Y0RpE5Dv5REhV4jUvLCFGpgTtCBU82u6u/yxu3iwBd5Vag3KzPmaW7V/KxFybW/kDECfhFPr71Duyd8ozOUyy3VV3a4qIigUs0GiQDmKr+m+G7cUJhYJOXrwcHUGLmNEyK6FNS+P9y7MD+731pqpkficI0B4cfXruKFW+q05c1OfUAeW8qPo11Psn2L1nh/fHGaANGzbTmToN4y44QfY694V0cRm6OTVzh/29kDmMRfEvpC6wW2oDu6HgGAtRcJzR1iGBCqv+0qlFfX0MeLUPblkgTyqZ8Nb4CwDYd6RwgPIvEcxG1+xsZmkp+XyqnzcCQI1EIS4rzyYES2TMsHsVG6NAle7PcVkehgqXfXcVwKsOCSA8s93EXZf7RDCMPUf3MyF9InvvCk/3Fy2IkUAp/1JDvAs2S+k6w3BXda35x6SbSHkTZDzIM0ea7RZyt6U4+TK97unuMxcHM4pIoLUDg+XsLaax0js9cD8ri/OvyYETr3yDQj/gwkVaCCzJFyc1Z0CuiViZXoRseNag9Q/4vfwKFztJZ/9YxyrtLYJAbHMWtarNolUsRU+0crzc2DdRknSLjB5ZlauPrLYi0qN6WAYZplzwwsPXq7WkXRlCSz7On618=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(7696005)(36860700001)(336012)(47076005)(83380400001)(86362001)(36756003)(40460700003)(426003)(82310400005)(70586007)(316002)(478600001)(40480700001)(6666004)(8936002)(26005)(186003)(2616005)(16526019)(6916009)(70206006)(41300700001)(4326008)(1076003)(82740400003)(81166007)(356005)(54906003)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:00.0823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2a72a8-34be-48c0-4a33-08db469c45b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No longer used.  Remove it.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 70 ++------------------------
 1 file changed, 3 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a4c4769e607..646003b2faf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3680,55 +3680,6 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-#ifdef BRING_UP_DEBUG
-static int gfx_v11_0_gfx_queue_init_register(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct v11_gfx_mqd *mqd = ring->mqd_ptr;
-
-	/* set mmCP_GFX_HQD_WPTR/_HI to 0 */
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR, mqd->cp_gfx_hqd_wptr);
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR_HI, mqd->cp_gfx_hqd_wptr_hi);
-
-	/* set GFX_MQD_BASE */
-	WREG32_SOC15(GC, 0, regCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr);
-	WREG32_SOC15(GC, 0, regCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
-
-	/* set GFX_MQD_CONTROL */
-	WREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL, mqd->cp_gfx_mqd_control);
-
-	/* set GFX_HQD_VMID to 0 */
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID, mqd->cp_gfx_hqd_vmid);
-
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY,
-			mqd->cp_gfx_hqd_queue_priority);
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM, mqd->cp_gfx_hqd_quantum);
-
-	/* set GFX_HQD_BASE, similar as CP_RB_BASE */
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE, mqd->cp_gfx_hqd_base);
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE_HI, mqd->cp_gfx_hqd_base_hi);
-
-	/* set GFX_HQD_RPTR_ADDR, similar as CP_RB_RPTR */
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR_ADDR, mqd->cp_gfx_hqd_rptr_addr);
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR_ADDR_HI, mqd->cp_gfx_hqd_rptr_addr_hi);
-
-	/* set GFX_HQD_CNTL, similar as CP_RB_CNTL */
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL, mqd->cp_gfx_hqd_cntl);
-
-	/* set RB_WPTR_POLL_ADDR */
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO, mqd->cp_rb_wptr_poll_addr_lo);
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI, mqd->cp_rb_wptr_poll_addr_hi);
-
-	/* set RB_DOORBELL_CONTROL */
-	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL, mqd->cp_rb_doorbell_control);
-
-	/* active the queue */
-	WREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE, mqd->cp_gfx_hqd_active);
-
-	return 0;
-}
-#endif
-
 static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -3740,9 +3691,6 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 		amdgpu_ring_init_mqd(ring);
-#ifdef BRING_UP_DEBUG
-		gfx_v11_0_gfx_queue_init_register(ring);
-#endif
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
@@ -3755,13 +3703,6 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
 		amdgpu_ring_clear_ring(ring);
-#ifdef BRING_UP_DEBUG
-		mutex_lock(&adev->srbm_mutex);
-		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-		gfx_v11_0_gfx_queue_init_register(ring);
-		soc21_grbm_select(adev, 0, 0, 0, 0);
-		mutex_unlock(&adev->srbm_mutex);
-#endif
 	} else {
 		amdgpu_ring_clear_ring(ring);
 	}
@@ -3769,7 +3710,6 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-#ifndef BRING_UP_DEBUG
 static int gfx_v11_0_kiq_enable_kgq(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -3791,7 +3731,6 @@ static int gfx_v11_0_kiq_enable_kgq(struct amdgpu_device *adev)
 
 	return amdgpu_ring_test_helper(kiq_ring);
 }
-#endif
 
 static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
@@ -3815,11 +3754,11 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 		if (r)
 			goto done;
 	}
-#ifndef BRING_UP_DEBUG
+
 	r = gfx_v11_0_kiq_enable_kgq(adev);
 	if (r)
 		goto done;
-#endif
+
 	r = gfx_v11_0_cp_gfx_start(adev);
 	if (r)
 		goto done;
@@ -4453,7 +4392,6 @@ static int gfx_v11_0_hw_init(void *handle)
 	return r;
 }
 
-#ifndef BRING_UP_DEBUG
 static int gfx_v11_0_kiq_disable_kgq(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -4476,7 +4414,6 @@ static int gfx_v11_0_kiq_disable_kgq(struct amdgpu_device *adev)
 
 	return r;
 }
-#endif
 
 static int gfx_v11_0_hw_fini(void *handle)
 {
@@ -4488,13 +4425,12 @@ static int gfx_v11_0_hw_fini(void *handle)
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
 	if (!adev->no_hw_access) {
-#ifndef BRING_UP_DEBUG
 		if (amdgpu_async_gfx_ring) {
 			r = gfx_v11_0_kiq_disable_kgq(adev);
 			if (r)
 				DRM_ERROR("KGQ disable failed\n");
 		}
-#endif
+
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
 
-- 
2.40.0

