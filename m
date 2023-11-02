Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2804C4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0E810E8E1;
	Thu,  2 Nov 2023 15:04:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5491D10E8E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 15:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwrQuul4d+MA7jAfjvdZdNWs3jTB/bGFW/3x69UUEopUzUL+xF8V5eRBNGLUMVewl/KQeHXw0n+Hha0VBF6RZGQtT6ra+3xQoK2BiTsg73nmqIR8cCPo8W9DrVpNfMpKIAZZtoXWk3c8MCW5bx5OUFbhVCE/u1GAxR7pK2O9B4Rd32SAvF8udLEMoL4tmCmqiig4+ahk28muUB66sB6KVFxc+lPJFAstGmv+r6cFrNFL9PAIz8yif0uWFLnQEoDyRxXd0KYiWW21hrkUzfN475mIdMjftxObWc6/4ESVchVCL10CgajgN7jKHZh0xO8nsok5ElpgrZySksPOBJXFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBqhRSOnWUvEiaH2swllYKHfDmH7QK8ho1rQYz8Qe84=;
 b=UZXaSJPZ+RAXKpq3BPbEkm53iArKDZUq/u0sw95SPOeKccT11LjzO0C5wMjT4JqTDbNViYIIVxnSGY+MMyU9zbCsFnAMhbNKz47vkNDim/Q4BzR7HRwnWm4/ApPuYqQoM5Hh5q0EW3vftkhKKMfyUpgFKqmfK9Bvq1nVYJK4vZABliSrv2qwDQGsFk6vIbODMB5v85bQah9cihaR2243rVfVPGrpkWhk7lv7QwcUXfS4wJw59827iEOWyDYfdNHFr6VOM5WibN7XYjmLFcCJXXMh+SDw3sLK+7otZnsfUkGdl7UgsLK6RwDtgJLZ0xkOCSBMBoLMi4CpzLcRhcnwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBqhRSOnWUvEiaH2swllYKHfDmH7QK8ho1rQYz8Qe84=;
 b=j5P2pmhY8EJSumxifkBV24Gs6B1KtdJRkdYiyMeJOVC5cTAKN/TSMRMpx5D0XvO0b7TC8pTZ4j7Lukbph50MzpOy87e0BoxJwOKbaJXf6luIqCcg5t8kZ/WudW2OscXZc1Y9FiamsZrFAPIuorINevpynOo5vck86qHM625hdtQ=
Received: from BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 15:04:48 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::f1) by BL0PR05CA0026.outlook.office365.com
 (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Thu, 2 Nov 2023 15:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 15:04:47 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 10:04:46 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add xcc param to SRIOV kiq write and
 WREG32_SOC15_IP_NO_KIQ (v4)
Date: Thu, 2 Nov 2023 11:04:25 -0400
Message-ID: <20231102150427.12978-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102150427.12978-1-victorchengchi.lu@amd.com>
References: <a69f99f0-881a-1b52-1e29-4cb6b2bc1994@amd.com>
 <20231102150427.12978-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: e9121ec7-a49c-430f-c31b-08dbdbb50e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebhIpHl/n7pSzpvKZKcAbGCwEfSQHjESDJ95YikrPfE7DMIHrHkEWw+iKuwPDvc5Le+VR5YPBtTkbGgpfBM020Llm1MAe0Qr+2ql+aazZQT55O0B2ypxjxxAN+UyLgDEnWJfBYjVMRZPgujZT4gN1BDe/qY1E7YoSZj0deFm452EMy3kMkUeUJLfLoV5WD6y4+daIZhh/hlRCQ/cBiUmM5nr1CwZIcUKDlsAEikkaeqOLUOGwDzlF6Ls3M+Kdu4Vg4Hq4iDcEqxuIntmcSq3MV4qyCQP9R6iAG+LMQjcnj4fXX41f5e+BlDZb1ID4426YEEG8qs5sDtNLBrmFLTUSuFBhDnug3Ovs1JyKVXj4xg0YSXZRVZqMDPBxmokS6EYQZnoupv8jtieSGE6ZTg3lNcCRQ/im9/XSzUxvlsgkUVCXHi6Oxj+OPtGd1lKpCKft2go6B1/c3FUWRG++F8N7rs1cIYmbMBPbNRSDSvmIa2/8Rwf1Qf58wWqAii1cMTxzpDMR1QO1JBOut6+SONx1QJB9EKFhgxJXzWC8SYcoUzdhhwB50NMP/rSa4TjF/vmpG4xpC4qU0KbrEDnB2Yv3jeonOJhD5KU2zrVLPmRtVVtLTUIytagNRJubTKVOZJcfwnmEHQX+HhvEBDJ1/8UfqjnUyjGCGmk5adUfQD0MI71lDEhHihXyh5F+PTB6TKbUvmE3jN96tybnZ28kdhhZI/L3Q5q+d56i/IsrODxTD6utFoSyMWuBdDDqxzpR2ol9L+BXe7JuwDQFJjtyLrqGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(26005)(41300700001)(7696005)(16526019)(40460700003)(1076003)(2616005)(47076005)(81166007)(356005)(86362001)(36756003)(82740400003)(36860700001)(83380400001)(426003)(336012)(8936002)(6916009)(316002)(8676002)(54906003)(70586007)(5660300002)(70206006)(4326008)(2906002)(40480700001)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:04:47.6319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9121ec7-a49c-430f-c31b-08dbdbb50e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WREG32/RREG32_SOC15_IP_NO_KIQ and amdgpu_virt_kiq_reg_write_reg_wait
are not using the correct rlcg interface or mec engine, respectively.

Add xcc instance parameter to them.

v4: Use GET_INST and squash commit with:
"drm/amdgpu: Add xcc_inst param to amdgpu_virt_kiq_reg_write_reg_wait"

v3: xcc not needed for MMMHUB

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 26 +++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  6 +++---
 6 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a0aa624f5a92..e179f022c428 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -73,9 +73,10 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t reg1,
-					uint32_t ref, uint32_t mask)
+					uint32_t ref, uint32_t mask,
+					uint32_t xcc_inst)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
 	struct amdgpu_ring *ring = &kiq->ring;
 	signed long r, cnt = 0;
 	unsigned long flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 858ef21ae515..bb436d41b4ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -334,7 +334,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t rreg1,
-					uint32_t ref, uint32_t mask);
+					uint32_t ref, uint32_t mask,
+					uint32_t xcc_inst);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d8a4fddab9c1..a43d1aa42e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -268,7 +268,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, GET_INST(GC, 0));
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 19eaada35ede..93f100dd5d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -228,7 +228,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, GET_INST(GC, 0));
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3a1050344b59..35ef7529cc8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -817,7 +817,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
-	u32 j, inv_req, tmp, sem, req, ack;
+	u32 j, inv_req, tmp, sem, req, ack, inst;
 	const unsigned int eng = 17;
 	struct amdgpu_vmhub *hub;
 
@@ -832,13 +832,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
 	 */
-	if (adev->gfx.kiq[0].ring.sched.ready &&
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = GET_INST(GC, 0);
+	else
+		inst = vmhub;
+	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-						   1 << vmid);
+						   1 << vmid, inst);
 		return;
 	}
 
@@ -856,9 +860,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -869,9 +873,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -884,9 +888,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -899,9 +903,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index da683afa0222..c75e9cd5c98b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -69,7 +69,7 @@
 
 #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP, 0)
 
-#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg, inst) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
@@ -86,8 +86,8 @@
 #define WREG32_SOC15_IP(ip, reg, value) \
 	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)
 
-#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
-	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
+#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value, inst) \
+	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-- 
2.34.1

