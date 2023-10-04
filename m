Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDC5E8FDC3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 00:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1E510E329;
	Wed,  4 Oct 2023 00:56:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D08F10E32B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 00:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTaerik3S3f+8uz9td19qmAGWC6KXotFMH56Zkp6WsbP1T08dqerNYBhl1IZJBNrv1NepI5avcLnJNr2jPBC4jYX5KZRWOtfqrK7pPJ1mAFj5JLQPFgHDEuMWfyPz5dIoxEgwyLKUxgL8qNzOujZVkpasXtRmp87B8wfR7m+ktWy2o1TdUZv0J1JAu9ACdodxvvcxcBIqo0YJ2ogGPfPFR2Ft2kF12n9S0Shpm3UKcV1eKdMi4dfEXro0ULrIvhy49NTljUaHBjwyaulhicw919FJ5+n90Yscdc/tmDMx6AHIYPRPQvE1ZtD/vcTT0Ez858ehOLgJyXXs8VfkElXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRXPLfhRmQ41O3uq3RGenj+OJEPWYwSTI2O2u0QCtfw=;
 b=Irzn/jDA7MN76yL7SWlLARkMbA9A9gIpdzi7VcugcCSSwUPPtZPmBvJSnH16kxXU+1/9uOlv0Pz6kQ/MsdCPcl9QhHrMj1rfvSrMffWCStNXFCs1XmP5kmeXmtCkdtvFpKx1S1lq5uoGdz1ta+cX5G3UX9u1mum71SEfbE/iuROfwHVhwMGfjmBx8yDHKh/vRA0RXMHJJ9owjrzb6badtgbbUzv54d7R8B2X5hXFX1rR+JNIx3hRrYFKbmTcHHl2//oZFk/w4zDrA9hp+AYe6WKMoEVG2ASOwa3kgHpXQ7QL/Kz1fuU6LHdNd5vMf2iu/COaym2o2O2Oybt0kafzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRXPLfhRmQ41O3uq3RGenj+OJEPWYwSTI2O2u0QCtfw=;
 b=bbj2avxLj6pVHq/stBIYKf1RY829YPuE6yW3XgOxfs0SWOuGXfn8crD1XS0NqQkvenR2UO7v9/BWliPBfc1Ajv6VP41JLCobLrLQrpnwfrZAHDXo5GxRPBiH8bFMXBkvHxN8pMgHrVcoqn46VovgdywZDtXrZJ9arFj/Pg1at20=
Received: from MN2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:c0::28)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 00:56:45 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::37) by MN2PR05CA0015.outlook.office365.com
 (2603:10b6:208:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Wed, 4 Oct 2023 00:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 00:56:45 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 19:56:43 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: Add xcc_inst param to
 amdgpu_virt_kiq_reg_write_reg_wait (v2)
Date: Tue, 3 Oct 2023 20:56:14 -0400
Message-ID: <20231004005616.108476-4-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004005616.108476-1-victorchengchi.lu@amd.com>
References: <20231004005616.108476-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd63ef8-f4ca-4bba-fb9b-08dbc474c803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etqzeJiIAQjQK8VWTiRFPdELvR8rJQmsMczk4edHRq2Mfitz8YO44fHswnNuUfsYmvSnSxKH53EckVJRZ6RsBEDwwjdbVpxipu/wRuLYHPM93JhlxYc8DO3h2QDtYUPgNxkzCrukUqou2mXZ0kW53gvcd1Dd/IFkJThjywOpU5b0+eGgE9dvFU6TaOLVGgp9C9ZdIjAEndttQez3xJdUjQYb22fP47v3k9bDj0b70UGq7JzPorLpyZoDKXbwuJX7F7ZWkFkwx4EdRnNEPgVozj60htx1xUSw92tcvXyU4p9PfThizC0UWDXLLhPDWYuHBggwp5idOFFkmQpewgwqV3Z5jp9ZLa6GikwQp6zKZuEU+8YFhNIFJ3EecggkZrHQYryBtLaa2zwHtdZI9db9eDNvolXxLohsshi3td5cRiyXJuilAlkM9SN9egildr1IKTfXfMlwHpqR2QJg+Ds5BWjDsjKtiOhOf0Yh/S2hlbP9Sw6CyNXFu8+qkXyVrRARHnA82n+eAH4oWJ9oILtb6t2Cn46u85eUWsgTB0+t664YUKaqFBdt/XQ3S9T+7UxL6c7qPVnJtw+ADNCc/aMEqKY9Bk8KSxh84Ri/RjrHVhUxdnC/dYuRqGodgeIF6md96FVimt5V0gShfi5KPZ5AqXNCyFfrOWyFGXRxHVSaHFAsZzggQMpuDO6WE6+lcGf9feoAVISHDGT4s3zRV/aLgSEbl6Xb1HFkyXh0rAp77VRFpgt4hRpdX1m4kXu2dROGDSExZPIkStwbhFJU7gnvMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(7696005)(6666004)(478600001)(47076005)(81166007)(86362001)(36860700001)(356005)(82740400003)(2906002)(41300700001)(2616005)(426003)(336012)(83380400001)(1076003)(16526019)(26005)(36756003)(5660300002)(70206006)(70586007)(316002)(54906003)(6916009)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:56:45.3699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd63ef8-f4ca-4bba-fb9b-08dbc474c803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_virt_kiq_reg_write_reg_wait is hardcoded to use MEC engine 0.
Add xcc_inst as a parameter to allow it to use different MEC engines.

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 26 ++++++++++++++----------
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 786ce1eb75b6..5007cd4c2262 100644
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
index fabb83e9d9ae..e9eb64e11c9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -330,7 +330,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t rreg1,
-					uint32_t ref, uint32_t mask);
+					uint32_t ref, uint32_t mask,
+					uint32_t xcc_id);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 70370b412d24..fc93ef4341f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -265,7 +265,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d0a9ee2f12d3..30bdd1966561 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -225,7 +225,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 24f6e070603e..930cc32b885b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -814,7 +814,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
-	u32 j, inv_req, tmp, sem, req, ack;
+	u32 j, inv_req, tmp, sem, req, ack, inst;
 	const unsigned int eng = 17;
 	struct amdgpu_vmhub *hub;
 
@@ -829,13 +829,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
 	 */
-	if (adev->gfx.kiq[0].ring.sched.ready &&
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = vmhub - AMDGPU_MMHUB0(0);
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
 
@@ -853,9 +857,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, vmhub - AMDGPU_MMHUB(0));
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -866,9 +870,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, vmhub - AMDGPU_MMHUB(0));
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -881,9 +885,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, vmhub - AMDGPU_MMHUB(0));
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -896,9 +900,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, vmhub - AMDGPU_MMHUB(0));
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, vmhub);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
-- 
2.34.1

