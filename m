Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67928EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0437510E4A0;
	Fri, 30 Jun 2023 15:56:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C4610E49F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIC1D/A1zyhW+q6PlAlpavlAGVc5mUDQOftJJiYfb80+sUVVLpgNw7lJu22u2Qko2Ffub1M1egsXDtvueg6X2RVDmmP89iHIAJ0w0uw99f7hzQfR+YSO08rDBGSH94Q9x63PJtbiocU/6worQfQvFir8NnYXjDO+PuzTcShva5G1GgNIsGh0t87jwU8tMxxIA2GA8+Wp+nSCAwOAJs5kO5uiF8OPGDvt4A4xZlcA0sJdKAiD8j5mG4985WYTje9QV2CwmhfNBB91B6idiMUBdjQ+75/2xOU5ry5ULifaJ6kvdsUMuRkS8Z1adxPZHqox61+OeHbEHirCv2hAePxIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bfz7cKwy3tE1OM2ySWVZ95/YEstpeRQZz9XUHDkl4aQ=;
 b=Upho++aqbnhDaA7Rl8RxbfM5oEyEHx7GNIJkgNEufDOA4XinpUFKM31/iLFd5O6kbg0hneBZxdlUGDUBPLdyxLw7VifG9PhvzmHXk2EdZ2BPbuUC6EPFkYeZt5+qfaDR/EbYBBAT/w6kgbk00L9TQVHmigO2sLCgzAGvobwnqguIxa7x9VLDAI+vB9svJjxSVAI3f8Plmkm1f/58VXKya1R3hmhq1ahY8jg5PCw+iafGvw55rySI7tb9ZvQ1NNsC+Uj1ASpNANb7i0TymnL3yzWVPXX3IQ1j4rmM8pQA/9poTLBT0tXWV6mzd8f2hZuIGxQyqmmXfMZ+eywCvxsGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bfz7cKwy3tE1OM2ySWVZ95/YEstpeRQZz9XUHDkl4aQ=;
 b=O8Xd1b2cenKdVFXDyw1rgxAXX7R8ku8UDBZJbrm5wRDhCwhi7L+hwgX6wSuGeX1s/8yXKP4NtFrEyY1knliPH9zVRPNsJ5uEwPvrYPaHJMSaJrZI7776EEhOMjIIe/pm1sPJG2hZiOmVOsb9pvu5//TaYVLUtbf40evegaUCBto=
Received: from BN9PR03CA0525.namprd03.prod.outlook.com (2603:10b6:408:131::20)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:56:22 +0000
Received: from BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::62) by BN9PR03CA0525.outlook.office365.com
 (2603:10b6:408:131::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT103.mail.protection.outlook.com (10.13.176.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 15:56:22 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:56:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: Fix warnings in gmc_v10_0.c
Date: Fri, 30 Jun 2023 21:25:58 +0530
Message-ID: <20230630155603.3388617-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
References: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT103:EE_|BN9PR12MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e76e31b-49d2-4c84-877b-08db79828d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xxx4rpfc6gMlMAx8N0PnIqI3Q2Kue28e7NW599TInvJQex42kU1v9C/IbMA7HtLafpQia20ocSzp2VZdmB4BgRc70PuCX0YIOtfsJRH/U24VDunyLOQCJiEVjniAEUjWXx+OgcS+llY8YpYTakRGq9mDcnOwT3FRxzd/8MRDV12alW+5iCaPnJgK0RZNuBPeQLgYC0S5OuWRZpTvIZP5LBegWQQ1ObcPbwkxCf7UJaP+8gkZY5GOfTaDU35TKYbz+uUJ3QyF7Zi6ZxJelywijEIO1/NF6AQvmvfh6k3/1RWO01tUli/aCUVm7H1JW3IEpgJk2QdIRiD6IqVWm1GDGJa70lKzTWRmA2QNI9AMQilAJLNJ6P6r1CoXEyKMwQ7Mg5WOk0SW05hLWKpb0gS4K/G1zv+sVrIb52H/Js/8JYdFX0r4dwWSR9YxIyif46Gq+0enaI6XaD+xUfunfIuwiMye2lsXsCQDVoMSqC1J2IEJxJe+Zq0tuc3WbMv9jixKEDwgRt1OuEVvjnG4zVqVNpmXUnyHZ1II76u4tm0fazKfMF0Vl3Owl6sGbmrpnTLDMMvoa83zPnZllkYOjWPQKO2z0JMyqGPqyfEvsJedMlXbHjClybq2ZnCtA0GfPDOGkZwkushGiYRCkB5ss1d8TEfzWZp43x2b1cSWH+dGJbp6Q9qCIldhDc9t0sMC4LUtG/DZjr1VGpJAKxjLVUBZsIEDQhzSBYql6JiI+PCFi8WFkXDn82l8DMxg0Axl+VAgw9wSYsZTbawYtKKVNfwxNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(26005)(1076003)(44832011)(7696005)(478600001)(6636002)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(16526019)(186003)(2616005)(2906002)(47076005)(40460700003)(83380400001)(336012)(426003)(66574015)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:22.7433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e76e31b-49d2-4c84-877b-08db79828d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch warnings:

WARNING: Consider removing the code enclosed by this #if 0 and its #endif
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: quoted string split across lines

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 35 ++++++++++----------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 13b89f78d07d..58f6c53bab3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -53,16 +53,9 @@
 
 #include "amdgpu_reset.h"
 
-#if 0
-static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
-{
-	/* TODO add golden setting for hdp */
-};
-#endif
-
 static int gmc_v10_0_ecc_interrupt_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *src,
-					 unsigned type,
+					 unsigned int type,
 					 enum amdgpu_interrupt_state state)
 {
 	return 0;
@@ -70,7 +63,7 @@ static int gmc_v10_0_ecc_interrupt_state(struct amdgpu_device *adev,
 
 static int
 gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
-				   struct amdgpu_irq_src *src, unsigned type,
+				   struct amdgpu_irq_src *src, unsigned int type,
 				   enum amdgpu_interrupt_state state)
 {
 	switch (state) {
@@ -164,8 +157,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
 	dev_err(adev->dev,
-		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, "
-		"for process %s pid %d thread %s pid %d)\n",
+		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
 		entry->vmid_src ? "mmhub" : "gfxhub",
 		entry->src_id, entry->ring_id, entry->vmid,
 		entry->pasid, task_info.process_name, task_info.tgid,
@@ -244,7 +236,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 	u32 tmp;
 	/* Use register 17 for GART */
-	const unsigned eng = 17;
+	const unsigned int eng = 17;
 	unsigned int i;
 	unsigned char hub_ip = 0;
 
@@ -346,7 +338,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
 	    down_read_trylock(&adev->reset_domain->sem)) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-		const unsigned eng = 17;
+		const unsigned int eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
@@ -477,12 +469,12 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 }
 
 static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned vmid, uint64_t pd_addr)
+					     unsigned int vmid, uint64_t pd_addr)
 {
 	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned eng = ring->vm_inv_eng;
+	unsigned int eng = ring->vm_inv_eng;
 
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -524,8 +516,8 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	return pd_addr;
 }
 
-static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
-					 unsigned pasid)
+static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
+					 unsigned int pasid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t reg;
@@ -645,10 +637,10 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
 }
 
-static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
+static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
-	unsigned size;
+	unsigned int size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
 		size = AMDGPU_VBIOS_VGA_ALLOCATION;
@@ -1082,7 +1074,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
-		 (unsigned)(adev->gmc.gart_size >> 20),
+		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
 	return 0;
@@ -1256,8 +1248,7 @@ const struct amd_ip_funcs gmc_v10_0_ip_funcs = {
 	.get_clockgating_state = gmc_v10_0_get_clockgating_state,
 };
 
-const struct amdgpu_ip_block_version gmc_v10_0_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v10_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 10,
 	.minor = 0,
-- 
2.25.1

