Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E555C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2663E10EA39;
	Wed, 26 Apr 2023 21:22:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E4610E329
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYyZiJ4xjDbOmXyn2STJH0Wtrdx9BigmP459LYQKhfQrN+LD8yKcqz816NXsB/DfEy1H64m8khmRjyIdezMNDMHrY1xFH8CLI3C6LdLD8dsRO6XDf/UdeR+D1egtsUlu4gHVd87nXIXW5ml4hhwqW8KV4RxO1Fffxp6MLKFX43EPXSrYRzItBdhbhC0iJBC2X4LGx9/SxrGVz5jca97xiT+w7GrBEFrAOhLFz2S70lGMNfOfRtH35hNFiCUiqvlYZhZ4ef4GgCR6TXP626OxzrcmH1K2999ztGF9Q4pHA2kWcCis6d+Ue2H7CD5fcOPVCVSsouTbV6l9f/uBuECN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmopS3Y+8/9OxiDUFue1GbVuyWnPBki+kZPkMugOH44=;
 b=ZC1Nhay5e0Kpu8UOkQmfLYAdb3NLuWusfZslg6IDG5z1jwm5c/0QjfKHc4ajQB1vs8e+gC3PTbHTd5eSQ0QZMfAWDRt+4SVcQtj1pEe76EDlx15K3T+nvPbdwRfqTM4IMIvXCf8QqbNniOx10Bru7TdfPm4Dz2M9zYPd8bo81Df2kRVhGQAaZHeEaf+wHab6fo28kg28lnmLKiI6C4Gc55xrPii59/zVVqCiqELn2ab7FLU47x8fyn5BGKyPMF6dq9BCnT3Wo8covbpRgSFqFmlyqEauQRIFxniQ5JXE1ktHzwniQLxB9LxWwr09OcSdn27o6tBAVm97OnmQWqLutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmopS3Y+8/9OxiDUFue1GbVuyWnPBki+kZPkMugOH44=;
 b=Ji4XMeZ45ZZtVYMg1KcGNoxeXwSsRh474CjK+X1IMNUq2X+AyRuR91xBvSHIIKDpswaEOw8giMGmNMAQaWCKJ/KaGx3UbhtUv35qbCDfJ/05IEQ9wjH79tHjYNH/cnjljQ3H2OX080ZL9TwmmB4bPtiwWdsOic6ejiGKgczZCsI=
Received: from DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22) by
 SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 21:22:00 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::5c) by DS7P222CA0013.outlook.office365.com
 (2603:10b6:8:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
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
Subject: [PATCH 02/12] drm/amdgpu/gfx10: drop old bring up code
Date: Wed, 26 Apr 2023 17:21:33 -0400
Message-ID: <20230426212143.7696-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd215d9-e333-4622-5886-08db469c4609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCRT4Pw6YwCydoqPv0Z5uC66m6cz+yqN52soRleLb5EyseBX7tFZsGsCPAV9Nu69WV4fZSEC4QWRwFIWlCZsh2kW1Q9CAj3jNIZQkSFRbBpPZf+FoQQIa2X8EtiJoSfUTo4V4iuordXfOFKT8MO+qI7wAieWlLLIhipacja3DX7BY9VJ8uIBFmFX7yLUS9D68OJUyzO02C92sSVylsrZaYcvkZe0VZkAOkU0u0OqsL4BhP9ekRQN/W0fLMUd96C1WbN9Q/pIwePA3mqdURdam4K/EeOXj4Cz3Se4WwQFxXl9Cxcbw5FqZFG862prySXU26CQea86UYOC3e+4xZEvy0xdH8gE4gM15IckfeeIMHFvIHQQLyJRFBmZveKYtQmly4akNWl/vNfFV8ShcX5ZUaQvIV/d2oSRRfnOkKT9eR80CVxrWxhw0A9AHCQZWKe2dxvz/R5h0EsSLoxL6PWRrt6IeopeYpIB0uy6FGOSb/jiSrDjYF9FdwRN0o/dj9J+OZnMd72sKEAwANM4Xees/4OBwQv+0it3LbB7Pl6rs9ir7XbDSYSd65lEPAcqrgfcYhjsKXKe9BQnHpqLUKzzhYW/7egfPKmOUOdPze6cle1pU9qb8tkUanSXDrbCKfMMZsjlTtTvmNpf4jJAvkhdGnYcngjV4Lc0nMza7DkOqaM/UQtTHavrkfX4rIJBqiNnsW1hkAWmX7hqcBJ8cvMZjTDtzSFq3H91VB34cVkm/P0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(26005)(86362001)(47076005)(82740400003)(81166007)(356005)(83380400001)(336012)(426003)(82310400005)(16526019)(2906002)(2616005)(186003)(8936002)(8676002)(1076003)(6666004)(40480700001)(316002)(5660300002)(36860700001)(6916009)(36756003)(70586007)(54906003)(4326008)(70206006)(7696005)(41300700001)(478600001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:00.6136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd215d9-e333-4622-5886-08db469c4609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 70 ++------------------------
 1 file changed, 3 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8bd07ff59671..25be4485dcd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6423,55 +6423,6 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-#ifdef BRING_UP_DEBUG
-static int gfx_v10_0_gfx_queue_init_register(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct v10_gfx_mqd *mqd = ring->mqd_ptr;
-
-	/* set mmCP_GFX_HQD_WPTR/_HI to 0 */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_WPTR, mqd->cp_gfx_hqd_wptr);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_WPTR_HI, mqd->cp_gfx_hqd_wptr_hi);
-
-	/* set GFX_MQD_BASE */
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr);
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
-
-	/* set GFX_MQD_CONTROL */
-	WREG32_SOC15(GC, 0, mmCP_GFX_MQD_CONTROL, mqd->cp_gfx_mqd_control);
-
-	/* set GFX_HQD_VMID to 0 */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_VMID, mqd->cp_gfx_hqd_vmid);
-
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY,
-			mqd->cp_gfx_hqd_queue_priority);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUANTUM, mqd->cp_gfx_hqd_quantum);
-
-	/* set GFX_HQD_BASE, similar as CP_RB_BASE */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_BASE, mqd->cp_gfx_hqd_base);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_BASE_HI, mqd->cp_gfx_hqd_base_hi);
-
-	/* set GFX_HQD_RPTR_ADDR, similar as CP_RB_RPTR */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR_ADDR, mqd->cp_gfx_hqd_rptr_addr);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR_ADDR_HI, mqd->cp_gfx_hqd_rptr_addr_hi);
-
-	/* set GFX_HQD_CNTL, similar as CP_RB_CNTL */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_CNTL, mqd->cp_gfx_hqd_cntl);
-
-	/* set RB_WPTR_POLL_ADDR */
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO, mqd->cp_rb_wptr_poll_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI, mqd->cp_rb_wptr_poll_addr_hi);
-
-	/* set RB_DOORBELL_CONTROL */
-	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, mqd->cp_rb_doorbell_control);
-
-	/* active the queue */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_ACTIVE, mqd->cp_gfx_hqd_active);
-
-	return 0;
-}
-#endif
-
 static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6492,9 +6443,6 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)
 			gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
 
-#ifdef BRING_UP_DEBUG
-		gfx_v10_0_gfx_queue_init_register(ring);
-#endif
 		nv_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
@@ -6507,13 +6455,6 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
 		amdgpu_ring_clear_ring(ring);
-#ifdef BRING_UP_DEBUG
-		mutex_lock(&adev->srbm_mutex);
-		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-		gfx_v10_0_gfx_queue_init_register(ring);
-		nv_grbm_select(adev, 0, 0, 0, 0);
-		mutex_unlock(&adev->srbm_mutex);
-#endif
 	} else {
 		amdgpu_ring_clear_ring(ring);
 	}
@@ -6521,7 +6462,6 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-#ifndef BRING_UP_DEBUG
 static int gfx_v10_0_kiq_enable_kgq(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -6543,7 +6483,6 @@ static int gfx_v10_0_kiq_enable_kgq(struct amdgpu_device *adev)
 
 	return amdgpu_ring_test_helper(kiq_ring);
 }
-#endif
 
 static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
@@ -6567,11 +6506,11 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 		if (r)
 			goto done;
 	}
-#ifndef BRING_UP_DEBUG
+
 	r = gfx_v10_0_kiq_enable_kgq(adev);
 	if (r)
 		goto done;
-#endif
+
 	r = gfx_v10_0_cp_gfx_start(adev);
 	if (r)
 		goto done;
@@ -7239,7 +7178,6 @@ static int gfx_v10_0_hw_init(void *handle)
 	return r;
 }
 
-#ifndef BRING_UP_DEBUG
 static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -7261,7 +7199,6 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
 	else
 		return 0;
 }
-#endif
 
 static int gfx_v10_0_hw_fini(void *handle)
 {
@@ -7272,13 +7209,12 @@ static int gfx_v10_0_hw_fini(void *handle)
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
 	if (!adev->no_hw_access) {
-#ifndef BRING_UP_DEBUG
 		if (amdgpu_async_gfx_ring) {
 			r = gfx_v10_0_kiq_disable_kgq(adev);
 			if (r)
 				DRM_ERROR("KGQ disable failed\n");
 		}
-#endif
+
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
 	}
-- 
2.40.0

