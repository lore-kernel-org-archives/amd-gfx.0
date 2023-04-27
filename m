Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D9DC7EE21
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC0810E6BA;
	Thu, 27 Apr 2023 15:27:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8029D10E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7cyqXR1R16QS2ToK+RundGUB2/MehGGo5TWI78oxwRYgQBzb2cTjKn8rcRGDyGTV2hM5CfPdqVRsBp56hTwOsLRtcSUK54TU7uzPF0rDuRAE/MCEpg5ql9+S/CM0x3cTDIGddI0COHo4eBqx+giLg0jb3zFFDD+dyoOEfilfNvkqBYMnMYqAPptuvF2uD8mORQS0tNd5OWK3F4zZ7nNN2fYtU3MJ3qSnT23h5X0f+ipaAkeWzrsKQW0eqOsaHX6LiNH7yLwcqS8L66LPG9Z5dMBVedO97gpziur30ed51PO4qQCM+lpZELMjgJPGozphk6ViuMJ+Hz91EQ5t29Qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmopS3Y+8/9OxiDUFue1GbVuyWnPBki+kZPkMugOH44=;
 b=W8YWeNhwscnAHEw0iCFBe55iDMBH/RHHruIGqPfBjMu61yc6Q16EeFs0+iwNrMos0fKQtvtX82w+6VFuAO2dBDQ2Y3KbC+hOI+sh8GGMLYtnwqIeUp3bPvgQPwRN+2qZZLxL8gKec28Ui2e0RBlW+IlY1XOFMXTyKu/tpnjV5lpQWr10wvYFN189DlzfI4lj1ked+W8qxrV8oJfw/D7x8TTPzkqZcKZ6lP/LuWOUGqV8PgjkAL20rmDAi8BNYomK/37v1V/wBV3zZmt+WTx6cD0c8XC50LnNrZ3h5egoL8Wvfh8+y701mVnMHd/aKiNflhRchkVejk3qPu08DbdgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmopS3Y+8/9OxiDUFue1GbVuyWnPBki+kZPkMugOH44=;
 b=OYs4mMX0OdN0mIc99OEG8znGcrj8IJUG3d93ScU6swX3G+kna7t5JkCdWTR6p6+nokD1x+ewvadqY8dzOf5poBgvPgmsAc190m2iUcVz1jP+m1lgCG4HuCBUVCBxplVxM4EmsEARieANEjMyxonhCpCKfVQ39RRyPdUNerV5S7I=
Received: from BN9PR03CA0471.namprd03.prod.outlook.com (2603:10b6:408:139::26)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:27:32 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::29) by BN9PR03CA0471.outlook.office365.com
 (2603:10b6:408:139::26) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:27:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amdgpu/gfx10: drop old bring up code
Date: Thu, 27 Apr 2023 11:26:59 -0400
Message-ID: <20230427152709.7612-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaae6bf-4513-4b9b-c252-08db4733eba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/0pkWUgPV+et7MriWBJnyfaks1MlgnNObP7K0VQ/+NyG7dNvjHADQt/W+bRxw3Q8CzDdER1t6huVNW1hT8PgTNCyz+Q0/jndPvPLN426JuVdCG1ONfwBpWpmcp6wZAHm5FLoix2b7K8680ew3RCFGxSZT78aFJpxGX0AuF1rtiaLVPXqZxxht1Tt3EGciTwJqs9kJmK4co6xoJ0vi0NWZdhrxZ+wnkohvRoYmJ/KxIm3/BWNdjPCgUF4K8hmzfJAlsLwZPGzjQ8FL23ZY353Pai78lZsme8M0qk5H+Mkt0PcAfxc6Fp66LlRLaxyMmQbQ5KufsNY5a134UGKD1vUY/8xKhXq3qPkPvPot2vbJSQfsVTf0XEijfogDVFgcdlT+boH3ufEqm4j0LNUE0IIiq6ZV/I/FPxmForHklTjEl6g5YqtL6HAvStSfRjfHHjDkTL0Xw67HXtPSJolTgcSFc8HgidOkZENqzK9kyR0fWu6aaUUeDLebaV7O/FXSFJAXoIuhR91UJeAjoMaYFBXWn4ZrCYAVnMDWjElWkfdp+MvYLnMY+6C/3AV2i//NgfStdJe3v2/1lNgrNREpiTssSsNXVoHXBhjhJ+gs1LMgLlKu67TKOkBslQiftvgZwrlzXmqHYZpAF0m5uYl65JHFxXZzt1m6JDe19rQ5fOrTZ8NHhgyOFcT4awKauOnzktvLB5xDVk0/EYZecShXj1cDZfa6hA5/A0MRBp5ovjiNc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(316002)(8936002)(8676002)(478600001)(47076005)(41300700001)(81166007)(82740400003)(356005)(426003)(336012)(2906002)(54906003)(82310400005)(7696005)(6666004)(86362001)(83380400001)(36860700001)(70206006)(70586007)(5660300002)(4326008)(6916009)(26005)(2616005)(36756003)(1076003)(40460700003)(186003)(16526019)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:32.4673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaae6bf-4513-4b9b-c252-08db4733eba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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

