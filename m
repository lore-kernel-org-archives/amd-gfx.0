Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9D1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 18:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715BA89F85;
	Mon, 14 Mar 2022 18:54:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F17589F85
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 18:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxvlRrkVTXF1wHF+pvbrAmTH/9CItYO2kN2fY89ICRU7zyb2R8mcodpzca++VgRqvW+C6xEMGRcz3BkQ3LOfBC8hZ25ed59ePsQb5CJBmqMmLgPzkNazs9sA5gTpCQbVmz69p8eiNlHgeEjRKrb94q1k6+dFuAGHfovmdgE8jOjt3gIZjo4QM7Tq+U5H4y1SLBI+tdck3+7yvcX5PBENJJ8O7gzceh814Sny4/9I9RUXugGVhVoQze/V9JbES4pWU6Uz3BTwoo0hEPlB48UXiMKDgu8ozwqnAwZeJKnLVAu6DgBQc8q12O255XMJN4KR9gwSUn+VahWe7vMzbpByDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zndgSY4EmP43iuHpKNIG/bMHv6Whe9fy8A7A+q+AN/8=;
 b=LlpvqMEs1SesQpBi2a+0rVgmig/EZDNfhSVppzl4PSXpBg0QsQqE9Ouqht/Xvv9zoxp935IpBOre6y7H5pUZuxVj9dOf2xPEGO+yMU0MNkfCn6mlpbF2W+JFvg3FODr9EFLXTLM0UeISFTFs7xu/Y0k4Jeve9shbpx//Bw4AJp2PVgyHTwnIz1cdYfDZ4ApH4G1F6p6fgxNhFs9CLLHynUWCFlaIAwvNwxtpg1nvsvWmvrY75jjmFEkDXce6ucSdrHHTZ9/NUj8uJkUVn7FJ3JZjI4cEgCSs1LvuJpvRK/Z8J5Ts6BbjrmLI+1Il6/tGgrmdEQk1KVlOc4Av3la7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zndgSY4EmP43iuHpKNIG/bMHv6Whe9fy8A7A+q+AN/8=;
 b=kHhpzxyjuwb2xoUdLM3OCAYVASBF7B3cy/nKRx5VlmGdWgyjJukxLxGiV8VPuBK+RqMeRDUd+Rcj51kvVRxPOWsqNmnCdk3y+34NNIKibH0QdGZd9tOOXOhK2stUbWYp7rOqogy0jOq+95N3fFraDOQT/KZEwSe2IJSXFDqyDMc=
Received: from DM6PR02CA0108.namprd02.prod.outlook.com (2603:10b6:5:1f4::49)
 by CY4PR12MB1141.namprd12.prod.outlook.com (2603:10b6:903:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 18:54:25 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::79) by DM6PR02CA0108.outlook.office365.com
 (2603:10b6:5:1f4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Mon, 14 Mar 2022 18:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 18:54:24 +0000
Received: from yonsun-linux-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 13:54:23 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.
Date: Mon, 14 Mar 2022 14:54:03 -0400
Message-ID: <20220314185403.137623-2-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314185403.137623-1-yongqiang.sun@amd.com>
References: <20220314185403.137623-1-yongqiang.sun@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90dd832d-17c4-4655-d254-08da05ec0ef0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB11418CEA857FF8D4B67ECAFDF40F9@CY4PR12MB1141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dSDcnL54TsQ6kgYan04FRMZiwKTKxga+U+FV9pUvZDT2TVuQMt3qXuy+pBoEqV+TjuS2nB6TEhvTfvY3GcfIl3864N7L6jcpiBDWdfNnwWZWa0FKa93h7OeaYlCv6XY2zDpL8fbQX0gwjaMI0u4sHfxBB/P5N4NuyAmJ7g1ZTPUi2Q+/jHaHsy7YxoJPK6VAaD8epgmPPlLdbsxswBfo/0e/W6+uO887COzy0MSQw/b0+A2ZwJ5efhnQ1PXQLoSappqy8nzxzjtIMquii9/Kci9whRfdoWcUeavHJE7GYqU6k9PXyj+5wALhxt2u2c7qRrMm3jA7972iheAkrVeWM/OE8kSDjPkCE1E2sctjVfPsa7n5QvK3FzYmz62XcfQ2/SWDFnBPt3+VNfeYYJptM/nsw3OvWF3U7XHv3XSK1F6P3lgRoiCAsPxMWx13sP9XQ4rONk4IKx3hVt+06x1js+IapljTwe7/xCwSFCLV9Vt7lde1RNPWFzYv2fVOVnCoVNpXGj85y3vOD02KGbMIe2wdhu9LYkG7A4GRbEFZ9tfaHY0IesUtoYo0eFw9ZbDrQzWwNKWGJa8j2VN4PzmMt/2sLrvcL/283GqfuMm5IgmCHuD6pBjpz7Wv9hvf0ne7SJcrp3s5CeQxgHhOjEOyjNoAhxpHCDM62eEeciBp4jtO2JVbhRU4Ys/URQmwcUEeNhwfAlW3J/Vgfwu7RgbMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(5660300002)(426003)(336012)(2906002)(508600001)(70206006)(8936002)(36756003)(47076005)(7696005)(36860700001)(2616005)(26005)(83380400001)(186003)(316002)(8676002)(54906003)(40460700003)(86362001)(44832011)(6666004)(82310400004)(356005)(4326008)(16526019)(81166007)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 18:54:24.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dd832d-17c4-4655-d254-08da05ec0ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
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
Cc: alexander.deucher@amd.com, nikola.veljkovic@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
MI25 SRIOV guest driver loading failed due to allocate
memory overlaps with private memory area.

[How]
1. Allocate stolen reserved memory for MI25 SRIOV specifically to avoid
the memory overlap.
2. Move allocate reserve allocation to vbios allocation since both the
two functions are doing similar asic type check and no need to have
seperate functions.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Change-Id: I142127513047a3e81573eb983c510d763b548a24
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 37 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 -
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c2a9555b7cc..f7f4f00dd2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -626,6 +626,11 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 {
 	unsigned size;
 
+	/* Some ASICs need to reserve a region of video memory to avoid access
+	 * from driver */
+	adev->mman.stolen_reserved_offset = 0;
+	adev->mman.stolen_reserved_size = 0;
+
 	/*
 	 * TODO:
 	 * Currently there is a bug where some memory client outside
@@ -635,11 +640,24 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	 * Keep the stolen memory reservation until the while this is not solved.
 	 */
 	switch (adev->asic_type) {
+
 	case CHIP_VEGA10:
+		adev->mman.keep_stolen_vga_memory = true;
+		if (amdgpu_sriov_vf(adev)) {
+			adev->mman.stolen_reserved_offset = 0x100000;
+			adev->mman.stolen_reserved_size = 0x600000;
+		}
+		break;
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
+	case CHIP_YELLOW_CARP:
+		if (amdgpu_discovery == 0) {
+			adev->mman.stolen_reserved_offset = 0x1ffb0000;
+			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
+		}
+		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
@@ -760,25 +778,6 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo
 	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
 }
 
-void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
-{
-	/* Some ASICs need to reserve a region of video memory to avoid access
-	 * from driver */
-	adev->mman.stolen_reserved_offset = 0;
-	adev->mman.stolen_reserved_size = 0;
-
-	switch (adev->asic_type) {
-	case CHIP_YELLOW_CARP:
-		if (amdgpu_discovery == 0) {
-			adev->mman.stolen_reserved_offset = 0x1ffb0000;
-			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
-		}
-		break;
-	default:
-		break;
-	}
-}
-
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 {
 	struct amdgpu_bo *vram_bo = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 93505bb0a36c..032b0313f277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -331,7 +331,6 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 			      bool enable);
 
 void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
-void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
 
 void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f60b7bd4dbf5..3c1d440824a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -948,7 +948,6 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 
 	amdgpu_gmc_get_vbios_allocations(adev);
-	amdgpu_gmc_get_reserved_allocation(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
-- 
2.25.1

