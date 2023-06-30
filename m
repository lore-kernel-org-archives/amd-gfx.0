Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85266EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083F010E4A2;
	Fri, 30 Jun 2023 15:56:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDAB10E4A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsiPC3zVBVBy5gOzOEyWtd3FPiIU/UEp5tOLErx27DsI5NykTQtu4X70lY+qiDA1uP90Akfv6wQ3xKghxV2YbG96rudgy0uMzGwwNGDlvzJ7yMIhQfOLeItS1czIs+c7ur9eJ1OCud7FmeZiJ1W7dOkLF3r2V9v58u/JrcuLY/x7KpoUgHz8CFyTKxWues2HtM0soVTYVER8sB9eO31pkdfeO0wanX0JFcldgWaJW5An3f9j9YGo5NtS/uncvi6vth71lSp/4ZvxtNEtiHClmgX/iJ+WoLoFGh9TkP6ztF6A5dTXSPDG6PMhft2zzJpCkEigJ+O4yDximFlA3Ummmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WsLzsYsmRm4FCAH/Sd3iNZ6O9mXne9B+jpyLU9QapE=;
 b=FovFg5Q6deGQPOgP4R5bzUwe2bBjd/ONVoN7YJDwITbX4Bb4WgPBRwf74+kMRBUeumrtddp4RCxyCXoyS6bZpppnROa7t30RdYWWfFy+WPR5hMcUFFA2IgNTMVIbKY19HX9cZev8PheISLJvBXFZiwiP5tJzG0pZpglXv3jfBpJVS326WTzad1FPfUTCaJeYUgCTC9O8+61YwaWjo/pcw+LFUQSUrbZe8l32suUf36nGYq+ERIgi4iesZxhFKkMazRYYgWrQ1ik8v5RoD8ZRArwUgm5dnDwdxpefZmKhfEGo0/Ys/k8SprwXQhWqLgYxbievtCPWy0TuOhWupfcgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WsLzsYsmRm4FCAH/Sd3iNZ6O9mXne9B+jpyLU9QapE=;
 b=juT16vM2JVyHe3JxGDUCKF0cavnKIxhKSZRbGhgIn+ZiISznqHdid4T8nlZgKumBf3GGIM7oj/yEiSOYamNzjclFCSn2LirFUlsJjM47Q/CAmUhk4E3GNMHRZ4N/m64FfCLEm8YP8yjnqmXiP1WYOs8PNCvzSlwVnwlqIMBXME4=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:56:24 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::d4) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 15:56:24 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:56:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: Fix warnings in gmc_v11_0.c
Date: Fri, 30 Jun 2023 21:25:59 +0530
Message-ID: <20230630155603.3388617-3-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: a0837c6d-f7db-4e94-1458-08db79828e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gQLtMeonPy7W8Y20eMu+Cy0GSOvpTG5HrB/nPyOeZ/e19vs/cq3p8geZAYKOgiGEip61ONSBAzezVIzbdmPvXAo3F9o+40JqK9XQ1ktvf45a6VjEiC/RHvHxF9oqat+qTqYajojpjdQbY2TlFzQ5vEzX89rwHMEGzkhphw7b35ndYVTWPN/pm3ZY9RnyHJOTXYW3XIoqRgMu5iaPyGsY02/2/PdKY/jh6lUwYF2lSG6yxnFxmPzjNxw4iwJShbGX0iUnueT3BSV+OVAaTGJWwTPy8zY54BMcT6+Q24PHM0sZyc2syttUrP1h+odql3iRHhrXJt0Na+4NMeH9hjHnGiezGD7OENViwqLH4jA5nX9LQyVVca57IDsZh2MwhBUbN+AsmarfWuawYT5BU96KJDJhefGzcp6OkpURFarpfZ4HpfepJNvLtmQSAIDXwh6zl21Hx0YiIibYY1oqV9YQepuxIXfVSq+YVJK75tM5QYfVImIMclQ/Y9J8dGuoAx0IcmNhHkjFPZzsK9svzDvBGwr65IPrKPNYYWR/ZzUAsRVfHo+gNWx164eA3n6PztKoKj6SlysNTA8BR5URbj21dx60guZ5ySW9jEu8H8K8ibfL2D8ifKXWX2sA7Cqu8+KZAXI3YIDLiuoRB6N81QD8Eh6ukQQ6eTM0xVbK/EjId1k92C5/X9iQ0CGsIQk8KVtgk0I6HbA2gnEwdZKM/gri4lUILmKv0jCGDjTWpfjL1R8U04u7GFxEKYYk/dvhbMqrLamj1t/l6b4JUi3JVUrsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(26005)(1076003)(44832011)(7696005)(478600001)(6636002)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(16526019)(186003)(2616005)(2906002)(47076005)(40460700003)(83380400001)(336012)(426003)(66574015)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:24.3565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0837c6d-f7db-4e94-1458-08db79828e5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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

WARNING: quoted string split across lines
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: void function return statements are not generally useful
WARNING: braces {} are not necessary for any arm of this statement

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 30 ++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c68ecb7dfa39..4856820d7baf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -50,7 +50,7 @@
 
 static int gmc_v11_0_ecc_interrupt_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *src,
-					 unsigned type,
+					 unsigned int type,
 					 enum amdgpu_interrupt_state state)
 {
 	return 0;
@@ -58,7 +58,7 @@ static int gmc_v11_0_ecc_interrupt_state(struct amdgpu_device *adev,
 
 static int
 gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
-				   struct amdgpu_irq_src *src, unsigned type,
+				   struct amdgpu_irq_src *src, unsigned int type,
 				   enum amdgpu_interrupt_state state)
 {
 	switch (state) {
@@ -124,8 +124,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
 		dev_err(adev->dev,
-			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, "
-			"for process %s pid %d thread %s pid %d)\n",
+			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
 			entry->vmid_src ? "mmhub" : "gfxhub",
 			entry->src_id, entry->ring_id, entry->vmid,
 			entry->pasid, task_info.process_name, task_info.tgid,
@@ -198,7 +197,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 	u32 tmp;
 	/* Use register 17 for GART */
-	const unsigned eng = 17;
+	const unsigned int eng = 17;
 	unsigned int i;
 	unsigned char hub_ip = 0;
 
@@ -296,7 +295,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-		const unsigned eng = 17;
+		const unsigned int eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
@@ -309,7 +308,6 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	mutex_lock(&adev->mman.gtt_window_lock);
 	gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
 	mutex_unlock(&adev->mman.gtt_window_lock);
-	return;
 }
 
 /**
@@ -379,12 +377,12 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 }
 
 static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned vmid, uint64_t pd_addr)
+					     unsigned int vmid, uint64_t pd_addr)
 {
 	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned eng = ring->vm_inv_eng;
+	unsigned int eng = ring->vm_inv_eng;
 
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -426,8 +424,8 @@ static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	return pd_addr;
 }
 
-static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
-					 unsigned pasid)
+static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
+					 unsigned int pasid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t reg;
@@ -547,10 +545,10 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
 }
 
-static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
+static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
-	unsigned size;
+	unsigned int size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
 		size = AMDGPU_VBIOS_VGA_ALLOCATION;
@@ -728,9 +726,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
+	if (amdgpu_gart_size == -1)
 		adev->gmc.gart_size = 512ULL << 20;
-	} else
+	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
@@ -927,7 +925,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
-		 (unsigned)(adev->gmc.gart_size >> 20),
+		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
 	return 0;
-- 
2.25.1

