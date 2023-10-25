Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEF9C25B6B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 20:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3244A10E71D;
	Wed, 25 Oct 2023 20:54:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE1010E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 20:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/U93j4Hc3fJPcVEXwtKNd8tF2lVxaL3SaMsMLpClyJ6IXf2GrouDpO4l+629UH2l4+5Au0vlqolwAC5LzWMrZMcdTw9wcIB7Jy09KZY1ls+dzgIcnR0u4ilKM3q1MTJyAUngGa2/Z/iL21R7BWhxso48TRybRo1E3ItdS8G1GM7fUiUusbsQAwNpZ9Y4a3Uxc4z3n6XDgsxza4WysXjgKNFiXS1t1TxxUBCP1wr9EzbLFyCvwRoNzZdlb3dn/7P+yoV/V2PjNhbJcSDzTyxnuyIVkqPOq14ZDhwIReQfD0rv9k23FNQnrXz62k7eiwZnn2gy03YQhbniqcuwTqXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOVDichjzOZM0E6aQps16YDC/lmev0CL3v8nNrNlJX4=;
 b=gsXeGLD5qGW8btyYfwhTrdZ0vR0GjA5ykWeYFv0smON9Pis4FkzxQs/PP4yTArLkHP9yzvNiaHdlky223Z+QfnDjDBT7zE8o4eG3MY3v8XcppLVVrQnsaKmtqBkRQaFN9WRCowbYYkknPO8RbTVZ0ChGFLhEMYcWDQZOT88RMd8U3+vYMvf+l3iiz+CO3iRnD3B4coBiNVvz3KjbQdG2MnYFzqrFIWtDZBKKavMkG6Ua1JQEVvvRUj+UDRX6IJFE2mBT3B8zX17EDLaXbM+JieqdbBTwZfA/W9sLY5K3BwtP/xeNqgO99x3epDVoHlb5taYuG1A7Z6GNjv7I+XxGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOVDichjzOZM0E6aQps16YDC/lmev0CL3v8nNrNlJX4=;
 b=bqIMK3aMqDAm3QtbRkXnIBN9pINY97wsIGf2ZliJTg/PzQuZoNv0ttuHk3prIrwS2o2B57b76XxMXMfCZBh19K7zaBJHEWgiO1P8lQ+tV28SF+nFMk/jyfObzYrRDARetEEpsO358FSbDxTneJs7bIOs67gWXW3RArN12nX0zGc=
Received: from CH2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:610:4f::34)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 20:54:02 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::7f) by CH2PR18CA0024.outlook.office365.com
 (2603:10b6:610:4f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 20:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 20:54:02 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 15:54:01 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: Add xcc_inst param to
 amdgpu_virt_kiq_reg_write_reg_wait (v2)
Date: Wed, 25 Oct 2023 16:52:41 -0400
Message-ID: <20231025205242.40490-4-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025205242.40490-1-victorchengchi.lu@amd.com>
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d01eb5-f52e-454b-c480-08dbd59c84be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2RagZN0rWkNpYzP5n90T5xAIqxI0hc1NOkTMjK4xwX0Zi0UdG5TCI/PqAMSUZ6Eo2KsP1VWa3aoyZ9SHWnIcBz+uNuwwrQ/w+kOwNROPQcOEOE9zktnWZ6YaNzKxDSs/SLMvqFw8/VBf5c0u8GITAeB5sRmGkVf5t82RFxltxi/1icu8NJW1s3HcDocWeEPKnXQGC3Ux7JUMr0JliMQ21T10cphEcvlgz/UYFhhua5dPNhN/MHrRqM15YS610lzb9pFuWe9LsfVN6NBEGEz229DCfI74B0rFlFxx6UJ5aLOaiPeKYx5hTh98/gYWAk6kX9IFf+8jKw0huw1qdWF08h21GV2DGHRBLfWkPFDw9vqvNm+Z9k2b8HV8objC9WGDndhQXzOkMH4S54hns3GrP7HdlCNxuBnQzDnIFhXpI+7o1t2Ph9jyCUq3WaDFadoSk6SfrPeoro8PR9TR6jlFqUcxQIILJRC+pwdBDEsm27MXeiMRi17WcPq7GiARkwxgXNKSmwkkKemGrKxn0EMmrkVT83jkrIx4vQIHkqcX/+hwf/WoMF0V7Ln9Ry9SvrDBsNDiXTKXS9SuN57HgNbyrrp4X9ZNOLH3mpZKlKnuDUulgaw2RvRlSXWRuKY9XeEWi2blvmL0gJthYW0+M7rj1Ru1uGkvFaWGbQmu+tLP59NdauERu+6P64NASc4CzeowuTbOT0meFNfGZIOpH84k8I+FotNPwakO1oRMBSka2uuukk77yiqdM6oGisypNYFFJRjrZo4mxAa00uSXf9Cjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(8676002)(2906002)(8936002)(41300700001)(4326008)(40460700003)(5660300002)(6666004)(7696005)(81166007)(36756003)(2616005)(1076003)(426003)(26005)(356005)(336012)(82740400003)(36860700001)(47076005)(83380400001)(54906003)(70586007)(6916009)(86362001)(70206006)(16526019)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:54:02.0985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d01eb5-f52e-454b-c480-08dbd59c84be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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
index c6c8f4fed0c1..f1a05053155e 100644
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
index 858ef21ae515..345b30972213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -334,7 +334,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
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
index d8a4fddab9c1..173237e99882 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -268,7 +268,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 19eaada35ede..2e4abb356e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -228,7 +228,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b7b1b04b66cb..00ef35b72213 100644
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
 
@@ -856,9 +860,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
@@ -869,9 +873,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, vmhub - AMDGPU_MMHUB(0));
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -884,9 +888,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
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
@@ -899,9 +903,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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

