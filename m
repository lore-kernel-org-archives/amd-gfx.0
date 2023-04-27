Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091F3C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B5310E2F5;
	Thu, 27 Apr 2023 15:27:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A6710E22A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9IWqMNhhumpf1lx7hlJ+RJH+vwni0aiiI1oCRQXVs8u9A47ySeYDgvuua6eV7PTdtKLdOdG72tnaqmsSV2YhBcDrHnOlcNlfQ8STYc8UxHkaQboffxY92OWJc58UnTtZJfy9hDaA2/T3aDq9L2QMNR+xWysMamEhMiy3UCZB9Fpj9+Yf9LWqwLg9fyLW9jvnYQ5Ua4g8KXDff2CjeDCsOCKKm3phu6YoZw23fx5MVdF7iXCoUw9xWoM4+z7EWX0s0/UlsrLGz3b0r6DWUm3jzvpr5GYUCxYxQ3392REXUOF9yE7ymtrVebSr+WXllXMxyxcUOwYtUqZqXjvlUxQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUpYRom15tCjlAiHCobe+vYI9krGkphgDxiLaqCbrPY=;
 b=YLsfDxElIDSrMXNjygbbhKci+aRFWIuc3o5aO3wMJoOkr1z2lpc1xStzsvEj3JwW+LFGZ2CXZZJ3H6uoH0xp3cyN+yLwSIojAYEcfYFeO5wldYmWAW9ht04xlBL0LcX6QY7y5zuzjQZoaxRxQB1fHmlxuBV9QmpxyKuTUcTWEEsi4qYhsToPeJiz1BOYpBVcuNYKklfNC2irZUl/omLo1E5MVpdfhDy987I2uukvn1HlNK4pDGWzX2dwlVPTmFAjb9l5VlsgunNyl9ce560VU4WHJ4Iqkr+QhG50w7edeIWgMU21f9jIAUGBV50Iet+PjeaMIQCxERW7xk93k/r6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUpYRom15tCjlAiHCobe+vYI9krGkphgDxiLaqCbrPY=;
 b=sRhBa27BW5sOItF/2xnhKBgqxSl3SYk2aqsueHZ6JXNhUFJq59E/0EtgglSgtj2ANJlbdkRhzh8RuydcflWURueiC3fyeTYfayjzdAIySyr6eP0jnjJBfJ5Sy9/DGtj1n5DXvNKF83JAXIugfEgDhtj/pQPGbIsyzj4UwTqqXvQ=
Received: from BN9PR03CA0461.namprd03.prod.outlook.com (2603:10b6:408:139::16)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 15:27:32 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::f7) by BN9PR03CA0461.outlook.office365.com
 (2603:10b6:408:139::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:27:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amdgpu/gfx11: drop old bring up code
Date: Thu, 27 Apr 2023 11:26:58 -0400
Message-ID: <20230427152709.7612-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ab7ef5-7699-4cc4-6647-08db4733eb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUaInmfTIsnTd/BEgHTs4DiDemEUnwyvdvnOCWx8sg9t0HSBpZ7/4rwZV7akymyeXXnbTuB1DClADGX82n6Q2X5SP8UZJEYkedF8poH1dLPdFm8a19VCri6C7RV4ruzQHB+k5ahkRvyONqaniVoDyY9fjUd6LxJZxVg8am8SF5VDmT7GxzolhsdrdNaskBF4HU4sir6t2Kih/XKQQArA5Wx98B31yoVO2SydR+4F6vhi0UCYTceo/oM+uXcxLl8C1S3jRkb/b4V6FIFWZX8SJmAoJyKYLlRiQjJUDixtlxgTJwULMwwxZinZ6jP0eFKtxokg0pigCct+oIVM9dUuwqD0oPWw7/1Da8WtRKxGURlOBK8lP3K1+RWp35CG66T7Ie75JQSvFfyqkjjxKFwFbInCjuBGWMApPzbMP9uWr+BTvQFQyRl2KdJ8KJ6UBJ0UBSLfLxzod4+LnY9xmL24MMZ46bjvIM/p+CNxOlyJKoVzp7h9VaLx2SxhCK1IqdD255KX7H7rl+ea2eAYkP4wnx9u+flWO/IU/yk+famFa1ZAP91VmuyHJP0i5A6MZRSURnlWwBlLryg9RhZSRWRTDq6TTLZOtkc4Irj21ZW9dt4RWegOBb6+HWJVilE8BqFFq+qRfKDmAYtnXfjLJzlvw4s5xpuE4RPmm6EgEgxMWKhB4xkoiXmX6e2fsIDlIfRQ1uPrN/SU3LbOD5F9EG5O3HKvjErk7+qOtYV/0Zu5Wj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(426003)(336012)(83380400001)(36860700001)(47076005)(40460700003)(16526019)(7696005)(186003)(40480700001)(70206006)(4326008)(70586007)(81166007)(2906002)(41300700001)(8936002)(8676002)(6916009)(5660300002)(82740400003)(26005)(1076003)(356005)(86362001)(478600001)(54906003)(6666004)(316002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:31.6392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ab7ef5-7699-4cc4-6647-08db4733eb22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

