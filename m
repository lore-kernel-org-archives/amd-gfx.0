Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC86C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F9C10E71E;
	Mon, 27 Mar 2023 19:36:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3401910E71E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7OW8XFJyAzq52sqJvLJRfCdRARCiG4NArjn6ICY94cvsZI+fR4gtFyJ13+kUD/5MIIw8WQUWEzS97+uDiMZwC2Pg+JQcHi0SUf0KahoxPFS8DlSBQQj82brtrqpinKI+pSpv3lXyVQm7HrE0N1Gs6B57kg71uCLuu+iEd/QMVFj6J/tBXV5gdiq59/CKDyQJhP4flJQC054jmdz40tw3UxCbjkOmxFy0DG4jqoZS2IzZMkq4N+AL3yXVzrb5u3TiC2A8DJVl/gYqZHD1pMWdu6sL9QnMk7d1M5k6zG5hYuP6pEfHJ18xW85hzx+Z+QOuMluHvpcFybFpbcRSUwcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqyhgyAT54xxa1JFc8O8foWgA+dOUtEzTXQkJFj6Qb4=;
 b=UomEaQoT46OlnIXQjcG+rik9c14ra25vJrrZAI1ObFg+hUKxq9brfqb2FYWlj0qZ+nlHckmIWxL8T6bmhUpgC2SyFeYSAg1xZ90DaB59ScRZAU8MZFT158JZ8/YsVsJGtMW4BGYjuE/Kg3lN0ZIo13KdspmSMaYSU9yhxxCx4NOfce2AZEaWDHkChfrb4t+g+eHlcK9VlFXVARkcbfxQKiofT9lwEs3Y0XGEiPossNWFyskcg99g0EF95ObTDP5PAfM4r4RpdeeP6TuY97o2/gaYohi7lMXRa1L0s4xNxWI+n4D5lhs7N+jzJbv7ZI4Sumn0007u0ERNanUDLJYqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqyhgyAT54xxa1JFc8O8foWgA+dOUtEzTXQkJFj6Qb4=;
 b=0ueEG9XSpxgyhFRigD3L4hTJ4yRcCdqTFfFT5D+irHDS8nm8JZ2FBdiHr55VSoViFbLVT2WC67U+CAwI+CZKieGhs/lNTaHheFxLHFdoyhAsyr6QbfbMPyaa1CBkJHrjr9XRiD9x7cCsgkqdG5nsAYhV0ntPsgyUGftBRNWaLjE=
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:26 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::6e) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/28] drm/amdgpu: add xcc index argument to soc15_grbm_select
Date: Mon, 27 Mar 2023 15:35:42 -0400
Message-ID: <20230327193602.7901-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d53c680-3eb9-48e7-0b51-08db2efa8e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqDyV1A5QpBAaqy9UPvKbetnUYj2ECnk5SZB75czELD82MbY9teYMRVkRrqrHat3IH/mLqfnFmnHHKW8UD2TiS1OiA3ThZn6EvSuyC79+FPEPWv0RVEBKQ9fUvqUJiTVvcWfj6Boxj+pyZxTTPFUzo2z7pfxKscJ5zuCw4W1mUrgsMAP6eSou5LaY0gfI8PPCkTu2DiIDHtPG079LfVaBGBpnYZ6e1qPFBcyd1ko3pScYZcUjEGcZ7rVrqwA7LKDB0+erHP5ZCtO2jIvzl2+C6QvWP5fPUo+aRg4RzNjZHAI4fy2lyMTYzw2eMIyoYdKAQbeA54adVjWak9LGD2KK6rtWzDWM9eETUoGTNx6D1Z4iz3M+oTQCtqRLM3dTsCHTzlR4dRXzvdHpSRa86XIxeP/Aph719LTJ2XR3Klfnb487ps9iniQFqnuiQrpYd0m/9Mxg/AydFzqOhsJ5s3KRxKmBiYc6h2yl/5HW03QbXrexCtbF+PLQQ9z5NY3+/66o2c9orFnwQAaPJX6uVc3tEkA7Ve/e6HQHO+u9OiK2deaFvPZ+PI52B/GxBcTLxa3vDL8C2aqOJ9/DW+wjtCuBnY3eBcZvnU/PeFG8slz685EghgxJJdUUsUEf+pLWl0n9VHINe+9f2HSwQu5sw0R4f5q7hBN36FqjoTgncLiGkcxliGi/Uavg1L8bRNtwXxeYU+qIVMoIuxTZ5Q+Is2pZjfbHNr+u18sf8eiyhoYisg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(356005)(426003)(47076005)(478600001)(7696005)(40480700001)(186003)(16526019)(40460700003)(86362001)(81166007)(36860700001)(41300700001)(82310400005)(82740400003)(1076003)(8936002)(36756003)(26005)(30864003)(83380400001)(316002)(5660300002)(336012)(6666004)(70586007)(8676002)(4326008)(6916009)(70206006)(54906003)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:26.4279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d53c680-3eb9-48e7-0b51-08db2efa8e28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

To support grbm select for multiple XCD case.

v2: unify naming style

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 10 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 26 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 26 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  4 +--
 drivers/gpu/drm/amd/amdgpu/soc15.h            |  2 +-
 6 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 03875b971ba6..ebb35633058c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -50,12 +50,12 @@ static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
 	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, mec, pipe, queue, vmid);
+	soc15_grbm_select(adev, mec, pipe, queue, vmid, 0);
 }
 
 static void unlock_srbm(struct amdgpu_device *adev)
 {
-	soc15_grbm_select(adev, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 }
 
@@ -700,7 +700,7 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
 	*wave_cnt = 0;
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
-	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, 0);
 	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
 			 queue_slot);
 	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
@@ -772,7 +772,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
-	soc15_grbm_select(adev, 1, 0, 0, 0);
+	soc15_grbm_select(adev, 1, 0, 0, 0, 0);
 
 	/*
 	 * Iterate through the shader engines and arrays of the device
@@ -821,7 +821,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	}
 
 	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-	soc15_grbm_select(adev, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	unlock_spi_csq_mutexes(adev);
 
 	/* Update the output parameters and return */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ba1fd6178cc9..36d4a59cdf64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1821,7 +1821,7 @@ static void gfx_v9_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
 				  u32 me, u32 pipe, u32 q, u32 vm)
 {
-	soc15_grbm_select(adev, me, pipe, q, vm);
+	soc15_grbm_select(adev, me, pipe, q, vm, 0);
 }
 
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
@@ -2314,12 +2314,12 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->srbm_mutex);
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
-		soc15_grbm_select(adev, 0, 0, 0, i);
+		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
 	}
-	soc15_grbm_select(adev, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
@@ -2384,7 +2384,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
-		soc15_grbm_select(adev, 0, 0, 0, i);
+		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		if (i == 0) {
 			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
@@ -2406,7 +2406,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, tmp);
 		}
 	}
-	soc15_grbm_select(adev, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 
 	mutex_unlock(&adev->srbm_mutex);
 
@@ -3530,9 +3530,9 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 		amdgpu_ring_clear_ring(ring);
 
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
 		gfx_v9_0_kiq_init_register(ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
@@ -3541,10 +3541,10 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 		if (amdgpu_sriov_vf(adev) && adev->in_suspend)
 			amdgpu_ring_clear_ring(ring);
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
 		gfx_v9_0_mqd_init(ring);
 		gfx_v9_0_kiq_init_register(ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.kiq[0].mqd_backup)
@@ -3572,9 +3572,9 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
 		gfx_v9_0_mqd_init(ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
@@ -3781,9 +3781,9 @@ static int gfx_v9_0_hw_fini(void *handle)
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, adev->gfx.kiq[0].ring.me,
 				adev->gfx.kiq[0].ring.pipe,
-				adev->gfx.kiq[0].ring.queue, 0);
+				adev->gfx.kiq[0].ring.queue, 0, 0);
 		gfx_v9_0_kiq_fini_register(&adev->gfx.kiq[0].ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 3a797424579c..93438770ca1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -761,7 +761,7 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 
 	for (i = first_vmid; i < last_vmid; i++) {
 		data = 0;
-		soc15_grbm_select(adev, 0, 0, 0, i);
+		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE,
@@ -769,7 +769,7 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 		WREG32(SOC15_REG_OFFSET(GC, 0, regSPI_GDBG_PER_VMID_CNTL), data);
 	}
 
-	soc15_grbm_select(adev, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 03ef36f2e892..da6a457b830f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -659,7 +659,7 @@ static void gfx_v9_4_3_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd
 static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 					u32 me, u32 pipe, u32 q, u32 vm)
 {
-	soc15_grbm_select(adev, me, pipe, q, vm);
+	soc15_grbm_select(adev, me, pipe, q, vm, 0);
 }
 
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
@@ -927,12 +927,12 @@ static void gfx_v9_4_3_init_compute_vmid(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->srbm_mutex);
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
-		soc15_grbm_select(adev, 0, 0, 0, i);
+		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, regSH_MEM_CONFIG, sh_mem_config);
 		WREG32_SOC15_RLC(GC, 0, regSH_MEM_BASES, sh_mem_bases);
 	}
-	soc15_grbm_select(adev, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
@@ -978,7 +978,7 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
-		soc15_grbm_select(adev, 0, 0, 0, i);
+		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		if (i == 0) {
 			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
@@ -1000,7 +1000,7 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 			WREG32_SOC15_RLC(GC, 0, regSH_MEM_BASES, tmp);
 		}
 	}
-	soc15_grbm_select(adev, 0, 0, 0, 0);
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 
 	mutex_unlock(&adev->srbm_mutex);
 
@@ -1707,19 +1707,19 @@ static int gfx_v9_4_3_kiq_init_queue(struct amdgpu_ring *ring)
 		amdgpu_ring_clear_ring(ring);
 
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
 		gfx_v9_4_3_kiq_init_register(ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
 		gfx_v9_4_3_mqd_init(ring);
 		gfx_v9_4_3_kiq_init_register(ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.kiq[0].mqd_backup)
@@ -1747,9 +1747,9 @@ static int gfx_v9_4_3_kcq_init_queue(struct amdgpu_ring *ring)
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
 		gfx_v9_4_3_mqd_init(ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
@@ -1897,9 +1897,9 @@ static int gfx_v9_4_3_hw_fini(void *handle)
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, adev->gfx.kiq[0].ring.me,
 				adev->gfx.kiq[0].ring.pipe,
-				adev->gfx.kiq[0].ring.queue, 0);
+				adev->gfx.kiq[0].ring.queue, 0, 0);
 		gfx_v9_4_3_kiq_fini_register(&adev->gfx.kiq[0].ring);
-		soc15_grbm_select(adev, 0, 0, 0, 0);
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d760ef57e421..2683de4a5b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -312,7 +312,7 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 
 
 void soc15_grbm_select(struct amdgpu_device *adev,
-		     u32 me, u32 pipe, u32 queue, u32 vmid)
+		     u32 me, u32 pipe, u32 queue, u32 vmid, int xcc_id)
 {
 	u32 grbm_gfx_cntl = 0;
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, PIPEID, pipe);
@@ -320,7 +320,7 @@ void soc15_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
+	WREG32_SOC15_RLC_SHADOW(GC, xcc_id, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void soc15_vga_set_state(struct amdgpu_device *adev, bool state)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index efc2a253e8db..2b41ee968dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -100,7 +100,7 @@ struct soc15_ras_field_entry {
 #define SOC15_RAS_REG_FIELD_VAL(val, entry, field) SOC15_REG_FIELD_VAL((val), (entry).field##_count_mask, (entry).field##_count_shift)
 
 void soc15_grbm_select(struct amdgpu_device *adev,
-		    u32 me, u32 pipe, u32 queue, u32 vmid);
+		    u32 me, u32 pipe, u32 queue, u32 vmid, int xcc_id);
 void soc15_set_virt_ops(struct amdgpu_device *adev);
 
 void soc15_program_register_sequence(struct amdgpu_device *adev,
-- 
2.39.2

