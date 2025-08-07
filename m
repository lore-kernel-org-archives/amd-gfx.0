Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EBCC87FD3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 00:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB7910E7D3;
	Thu,  7 Aug 2025 00:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iWaxpYhU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF6510E320
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 00:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS/zYA4b7ysDkl2/yyWrpg3IHSlAalvMAWV8WH3G3Cbsp3TDq5va08d2ulsXCugU++DBrNas13o9tZbFRAssDpW0t4IfHnCJSJncCEnHue2vkBJ/UFaM0Hkq4OqVCbvS6dpx348vv8Nf9acNzSHcHOIOSgEZxs4SV67urAsUAllBj8QHxDPrCT99W6YqisG3vVtO/Kqd+kbmLa01w9kGL1HnET8zEH1xUiVp/A4Np3zh8TV7fut2Mj9+/eUoIcr3KP1XslViWTFLqZETvz1A201lezbCFVFcmgThSwXtkUEFIsGyfQZGwB/dH+3WOpoorGRDz/onOuZ2s1sJNbu92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBQdOdcUT22lEHM0TO100JVYkrup2lC+FuaYU42yH8k=;
 b=f+5iI7jnkLauZlVE1oKTch4arbaQjTe8IGQTqnQk4l9Qv+AM7Ioq9libwfiHHF58z7dGh/kI+GKSp64paeTB3zkrnOCxUDPx5xQBMZ3Y3AOL2+4hzqBQIHa7OXlIVhPB+bXS9s/AOu7nelqKmZjKM6+LITRsJZP3ldGMcp1JhkjJ+Fv2jHklwlnWY+QvDdQ8+/XnVMYTZVLEOM7mr6J1wE7QfmR1YREGRZymsbAbTWwt6RJMuUJ45P56fpyZmBLJu9KRtxpKLPPnrCy+mq9ZOqj/YK801KECa5zJhA/fogS2d4NYt2zab54LjSBsi6HvuN3hThzKON4wQp4I+dWGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBQdOdcUT22lEHM0TO100JVYkrup2lC+FuaYU42yH8k=;
 b=iWaxpYhUc9BMqlTtYjh8KFF1XOCoMQ77sNMEE3GVhfQeTaXhiEmWlQ09/TmqSdt4GNrBpt/jWJJ+h+/zb8jIsK1ddqQIZjV6Dx4srOLQr+Jj8Dmhmnaz5rtV6mB6ZfGySC4jJuNnc9gI9SzYgtjvnd6tB/2Rm6VRqv+m9kXw9pk=
Received: from BYAPR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:40::16)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 00:02:13 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:40:cafe::29) by BYAPR04CA0003.outlook.office365.com
 (2603:10b6:a03:40::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Thu,
 7 Aug 2025 00:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Thu, 7 Aug 2025 00:02:12 +0000
Received: from sriov-AS-4125GS-TNRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Aug 2025 19:02:11 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shravankumar.Gande@amd.com>, <Zhigang.Luo@amd.com>, Ellen Pan
 <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Introduce dynamic pf-vf critical region handling
 in SRIOV
Date: Wed, 6 Aug 2025 20:01:56 -0400
Message-ID: <20250807000156.196220-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd12786-3be3-4efb-e047-08ddd545a948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d/WuG0cgh/DPSIUNdgYnnRHjaFIZkoTPYfKSlUlmAXz4FRerAKb6ytfr+0HT?=
 =?us-ascii?Q?T/MbE/FevSakOHdoLenZks7akprhHdPcTpk/dPU9GLJ0PVnR2ORDl5aIfNkK?=
 =?us-ascii?Q?xPkHO0Z2uPe6dMFGAYqnnkFCLtOIsElcELIMF2Vp9ovviEZv1ByTHuibJrYF?=
 =?us-ascii?Q?vv6LEJNZ5Jf8U8IBABvbrHPB2w3lahY6EIYzzpgS6zJuTneImnToaWp/a2fL?=
 =?us-ascii?Q?S+UIU9qaSk6/pSZJjz/IVya4RwxJYc4yotnONxiVxpNBrOolYVJG0dR2byWP?=
 =?us-ascii?Q?QbtKw/WCMyMsx14laNIn78ZZ/U7oijPdBHBKdCRaNXdqifECBGH4xJVsxI4o?=
 =?us-ascii?Q?+v2No4TFpnNSBci+AxI4jLtZYN5EcRlzw5UB1HeviKo5tslechWHwpJeiYjC?=
 =?us-ascii?Q?qpT2ksnERFsD0pi3xezMq5gBOvvMdotQb203Bf+VXyWEUiiPqSKIzD13G1S+?=
 =?us-ascii?Q?T7VwInHsHd5gC7VKYE8e3gMCCvgueSU5kRIFPhemEydA1MNqoa+Rdh8oyR/a?=
 =?us-ascii?Q?T8XSgdq0MA0zuS1PAsE/xpnjd3zv9fxR97P+k3HxJlXPRCZ6JoXV1OpFgui+?=
 =?us-ascii?Q?PUMMUgH9ZJpUBG460I5J7VaM9G240FelRLDnFJM+vKvckh6e0+XB9gSc9vaR?=
 =?us-ascii?Q?k0m46zaNkAr0op1gj7OB+YJs0Qec7kw/XLuU2YJWqBwYQJBCHSFWPXI2KuBB?=
 =?us-ascii?Q?2Y4SNHB2vKdEavKWZ+Ld7ksVlSln4izq/MR/FhG4emnLPGlvwiXvxWQO2TVb?=
 =?us-ascii?Q?Lx8OBb/d46vEV7p17ncJut1dIkhAsfuCQeL7WRxqwhDiMDAquUkBRT7WQhfi?=
 =?us-ascii?Q?N0LP0I47/qIHIqHyMqudMVA3B9zSLGPeZQpi7IbkXvnfzsMVdfSdi58ZopWn?=
 =?us-ascii?Q?7n6oNnPMh4mCQKspll3iACoQue4kYmUETNAJQ2FVRQzEqHLUYe41vthBfTxX?=
 =?us-ascii?Q?Zm0GvQJXwpi86bhQJgCA9LBX0jTo4Bd8QPFaEDu4VflCCIKFwLlDCS839KNz?=
 =?us-ascii?Q?W/c+ZLahNAYvsZJIUc9hokA4p/pEBufjkz/xlOQYXSxJbAPyf2KmqKyUuu0Q?=
 =?us-ascii?Q?1KX3gaIbXBNpMOU9zHnv5qmllUZiwUC+VUrqOt4x3VGHGaxJKV8VFAtYqk90?=
 =?us-ascii?Q?05fPytVdPlZQsdP75jz2QjrI1s/01KjxizGEhlulcYqvhIM/DtZPL8da+wX+?=
 =?us-ascii?Q?Gnx7p5uV6i+ZZpNH7NRK3CuIDZmNqZU569mIW4n+hRjOKGPIGM1mfXrfq1E5?=
 =?us-ascii?Q?d/RVWXb1IGdIh1nNnZJFL3Ssab1AgjGvSBl0L8j5w0+wqtDSFHMpRjSz/W2Z?=
 =?us-ascii?Q?O+hMY5KTKQww7lcQ1SCUfNs/G3ek0GnA3J91N6kVRcoN8a7oC4Mfd0UvQIAi?=
 =?us-ascii?Q?KJzzs04N7O8hLHGVhKXfhhDUkntPhA4VKw/0hH/4rqLFtUv68VQKZFkOiimK?=
 =?us-ascii?Q?GwLXX3UVYnkL06AP+3UCtKUVNQEZ++UG0MHrU8fmv6zW5cE0zqPq6BEYBbWD?=
 =?us-ascii?Q?BjcohB2MHQAvYNDmVJMOWDEV+tH9NFx2m2wx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 00:02:12.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd12786-3be3-4efb-e047-08ddd545a948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Updated previous layout offsets and sizes to _V1.
2. Added v2 layout offset enums for dynamic pf-vf critical region handling.
3. Added crit_region version in VF's msg[2] during REQ_INIT_DATA.
4. Added support to init critical region v2 during device init.
 - After VF sends out supported crit_region version during
REQ_INIT_DATA, PF would confirm back with provided crit_region_header
offset and size.
 - VF uses the offset and size to fetch critical regions' offsets in VRAM and
save to local struct.
5. Added support for critical region handling:
 - Init IP discovery table from dynamic offset from init_data_table.
 - Init VF BIOS.
 - Init DATA exchange region for VFs.
 - Introduced ttm to manage critical region data in a 5MB chunk.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  90 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 354 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  15 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  93 ++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  23 +-
 9 files changed, 506 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 00e96419fcda..2cbb24ede86e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -114,7 +114,17 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 
 	adev->bios = NULL;
 	vram_base = pci_resource_start(adev->pdev, 0);
-	bios = ioremap_wc(vram_base, size);
+
+	if (amdgpu_sriov_vf(adev) && adev->virt.init_data_done) {
+		resource_size_t bios_offset;
+
+		if (amdgpu_virt_get_bios_info(adev, &bios_offset, &size))
+			return false;
+
+		bios = ioremap_wc(vram_base + bios_offset, size);
+	} else
+		bios = ioremap_wc(vram_base, size);
+
 	if (!bios)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f7d7e4748197..51157143135a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2716,6 +2716,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+
+		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+			r = amdgpu_virt_init_critical_region(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index efe0058b48ca..76d5e13aa837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -292,6 +292,11 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		}
 	}
 
+	if ((adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) && adev->virt.init_data_done) {
+		ret = amdgpu_virt_init_ip_discovery(adev, binary);
+		return ret;
+	}
+
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
 	if (!vram_size || vram_size == U32_MAX)
 		sz_valid = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..6a77d63d224b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1644,6 +1644,20 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
 						  &adev->mman.drv_vram_usage_va);
 }
 
+/**
+ * amdgpu_ttm_crit_regions_reserve_vram_fini - free crit regions reserved vram
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * free crit regions reserved vram if it has been reserved.
+ */
+static void amdgpu_ttm_crit_regions_reserve_vram_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->mman.crit_regions_vram_usage_reserved_bo,
+						  NULL,
+						  &adev->mman.crit_regions_vram_usage_va);
+}
+
 /**
  * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
  *
@@ -1694,6 +1708,31 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 					  &adev->mman.drv_vram_usage_va);
 }
 
+/**
+ * amdgpu_ttm_crit_regions_reserve_vram_init - create bo vram reservation for critical regions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * create bo vram reservation for critical regions.
+ */
+static int amdgpu_ttm_crit_regions_reserve_vram_init(struct amdgpu_device *adev)
+{
+	u64 vram_size = adev->gmc.visible_vram_size;
+
+	adev->mman.crit_regions_vram_usage_va = NULL;
+	adev->mman.crit_regions_vram_usage_reserved_bo = NULL;
+
+	if (adev->mman.crit_regions_vram_usage_size == 0 ||
+	    adev->mman.crit_regions_vram_usage_size > vram_size)
+		return 0;
+
+	return amdgpu_bo_create_kernel_at(adev,
+					  adev->mman.crit_regions_vram_usage_start_offset,
+					  adev->mman.crit_regions_vram_usage_size,
+					  &adev->mman.crit_regions_vram_usage_reserved_bo,
+					  &adev->mman.crit_regions_vram_usage_va);
+}
+
 /*
  * Memoy training reservation functions
  */
@@ -1901,31 +1940,37 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				adev->gmc.visible_vram_size);
 #endif
 
-	/*
-	 *The reserved vram for firmware must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
-	 */
-	r = amdgpu_ttm_fw_reserve_vram_init(adev);
-	if (r)
-		return r;
-
-	/*
-	 *The reserved vram for driver must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
-	 */
-	r = amdgpu_ttm_drv_reserve_vram_init(adev);
-	if (r)
-		return r;
+	if (amdgpu_sriov_vf(adev) && (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2)) {
+		r = amdgpu_ttm_crit_regions_reserve_vram_init(adev);
+		if (r)
+			return r;
+	} else {
+		/*
+		 *The reserved vram for firmware must be pinned to the specified
+		 *place on the VRAM, so reserve it early.
+		 */
+		r = amdgpu_ttm_fw_reserve_vram_init(adev);
+		if (r)
+			return r;
 
-	/*
-	 * only NAVI10 and onwards ASIC support for IP discovery.
-	 * If IP discovery enabled, a block of memory should be
-	 * reserved for IP discovey.
-	 */
-	if (adev->mman.discovery_bin) {
-		r = amdgpu_ttm_reserve_tmr(adev);
+		/*
+		 *The reserved vram for driver must be pinned to the specified
+		 *place on the VRAM, so reserve it early.
+		 */
+		r = amdgpu_ttm_drv_reserve_vram_init(adev);
 		if (r)
 			return r;
+
+		/*
+		 * only NAVI10 and onwards ASIC support for IP discovery.
+		 * If IP discovery enabled, a block of memory should be
+		 * reserved for IP discovey.
+		 */
+		if (adev->mman.discovery_bin) {
+			r = amdgpu_ttm_reserve_tmr(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	/* allocate memory as required for VGA
@@ -2072,6 +2117,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
+	amdgpu_ttm_crit_regions_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2309df3f68a9..aa8ed6524386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -100,6 +100,12 @@ struct amdgpu_mman {
 	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
 	void		*drv_vram_usage_va;
 
+	/* critical region VRAM reservation */
+	u64		crit_regions_vram_usage_start_offset;
+	u64		crit_regions_vram_usage_size;
+	struct amdgpu_bo	*crit_regions_vram_usage_reserved_bo;
+	void		*crit_regions_vram_usage_va;
+
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
 	void			*sdma_access_ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 13f0cdeb59c4..24d25e4ed1b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		virt->ops->req_init_data(adev);
 
 	if (adev->virt.req_init_data_ver > 0)
-		DRM_INFO("host supports REQ_INIT_DATA handshake\n");
+		DRM_INFO("host supports REQ_INIT_DATA handshake of critical_region_version %d\n",
+				adev->virt.req_init_data_ver);
 	else
 		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
 }
@@ -423,10 +424,14 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	uint32_t bp_idx, bp_cnt;
 	void *vram_usage_va = NULL;
 
-	if (adev->mman.fw_vram_usage_va)
-		vram_usage_va = adev->mman.fw_vram_usage_va;
-	else
-		vram_usage_va = adev->mman.drv_vram_usage_va;
+	if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+		vram_usage_va = adev->mman.crit_regions_vram_usage_va;
+	} else {
+		if (adev->mman.fw_vram_usage_va)
+			vram_usage_va = adev->mman.fw_vram_usage_va;
+		else
+			vram_usage_va = adev->mman.drv_vram_usage_va;
+	}
 
 	memset(&bp, 0, sizeof(bp));
 
@@ -669,74 +674,137 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
+	uint32_t *pfvf_data = NULL;
+
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 	adev->virt.vf2pf_update_retry_cnt = 0;
 
-	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
-		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
-	} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
-		/* go through this logic in ip_init and reset to init workqueue*/
-		amdgpu_virt_exchange_data(adev);
-
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
-		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
-	} else if (adev->bios != NULL) {
-		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-
-		amdgpu_virt_read_pf2vf_data(adev);
+	if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+		if (adev->mman.crit_regions_vram_usage_va) {
+			/* go through this logic in ip_init and reset to init workqueue*/
+			amdgpu_virt_exchange_data(adev);
+
+			INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
+					amdgpu_virt_update_vf2pf_work_item);
+			schedule_delayed_work(&(adev->virt.vf2pf_work),
+					msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
+		} else if (adev->bios != NULL) {
+			/* got through this logic in early init stage to get necessary flags,
+			 * e.g. rlcg_acc related */
+			pfvf_data =
+				kzalloc(adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10,
+					GFP_KERNEL);
+			if (!pfvf_data) {
+				DRM_ERROR("Failed to allocate memory for pfvf_data\n");
+				return;
+			}
+
+			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
+				goto free_pfvf_data;
+
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
+
+			amdgpu_virt_read_pf2vf_data(adev);
+
+free_pfvf_data:
+			kfree(pfvf_data);
+			pfvf_data = NULL;
+			adev->virt.fw_reserve.p_pf2vf = NULL;
+		}
+	} else {
+		if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
+			DRM_WARN("Currently fw_vram and drv_vram should not have values "
+					"at the same time!");
+		} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
+			/* go through this logic in ip_init and reset to init workqueue*/
+			amdgpu_virt_exchange_data(adev);
+
+			INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
+				amdgpu_virt_update_vf2pf_work_item);
+			schedule_delayed_work(&(adev->virt.vf2pf_work),
+					msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
+		} else if (adev->bios != NULL) {
+			/* got through this logic in early init stage to get necessary flags,
+			 * e.g. rlcg_acc related*/
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+
+			amdgpu_virt_read_pf2vf_data(adev);
+		}
 	}
 }
 
-
 void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 {
 	uint64_t bp_block_offset = 0;
 	uint32_t bp_block_size = 0;
 	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
 
-	if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
-		if (adev->mman.fw_vram_usage_va) {
+	if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+		if (adev->mman.crit_regions_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+				(adev->mman.crit_regions_vram_usage_va +
+				adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID]);
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+				(adev->mman.crit_regions_vram_usage_va +
+				adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] +
+				(AMD_SRIOV_MSG_SIZE_KB_V1 << 10));
 			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
-		} else if (adev->mman.drv_vram_usage_va) {
-			adev->virt.fw_reserve.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-			adev->virt.fw_reserve.p_vf2pf =
-				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
-			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
+				(adev->mman.crit_regions_vram_usage_va +
+				adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID]);
+		}
+	} else {
+		if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
+			if (adev->mman.fw_vram_usage_va) {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(adev->mman.fw_vram_usage_va +
+					(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(adev->mman.fw_vram_usage_va +
+					(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(adev->mman.fw_vram_usage_va +
+					 (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+			} else if (adev->mman.drv_vram_usage_va) {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(adev->mman.drv_vram_usage_va +
+					(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(adev->mman.drv_vram_usage_va +
+					(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(adev->mman.drv_vram_usage_va +
+					 (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+			}
 		}
+	}
 
-		amdgpu_virt_read_pf2vf_data(adev);
-		amdgpu_virt_write_vf2pf_data(adev);
+	amdgpu_virt_read_pf2vf_data(adev);
+	amdgpu_virt_write_vf2pf_data(adev);
 
-		/* bad page handling for version 2 */
-		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
-			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+	/* bad page handling for version 2 */
+	if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
+		pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
 
-			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
-				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
-			bp_block_size = pf2vf_v2->bp_block_size;
+		bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
+			((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
+		bp_block_size = pf2vf_v2->bp_block_size;
 
-			if (bp_block_size && !adev->virt.ras_init_done)
-				amdgpu_virt_init_ras_err_handler_data(adev);
+		if (bp_block_size && !adev->virt.ras_init_done)
+			amdgpu_virt_init_ras_err_handler_data(adev);
 
-			if (adev->virt.ras_init_done)
-				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
-		}
+		if (adev->virt.ras_init_done)
+			amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
 	}
 }
 
@@ -839,6 +907,192 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
 	adev->virt.ras.cper_rptr = 0;
 }
 
+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
+{
+	uint32_t sum = 0;
+
+	if (buf_start >= buf_end)
+		return 0;
+
+	for (; buf_start < buf_end; buf_start++)
+		sum += buf_start[0];
+
+	return 0xffffffff - sum;
+}
+
+#define mmRCC_CONFIG_MEMSIZE	0xde3
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
+	uint32_t init_hdr_offset = adev->virt.init_data_header_offset;
+	uint32_t init_hdr_size = adev->virt.init_data_header_size_kb << 10;
+	uint64_t pos = 0;
+	uint64_t vram_size;
+	int r = 0;
+	uint8_t checksum = 0;
+
+	if (init_hdr_offset < 0) {
+		DRM_ERROR("Invalid init header offset\n");
+		return -EINVAL;
+	}
+
+	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+	if ((init_hdr_offset + init_hdr_size) > vram_size) {
+		DRM_ERROR("init_data_header exceeds VRAM size, exiting\n");
+		return -EINVAL;
+	}
+
+	/* Allocate for init_data_hdr */
+	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
+	if (!init_data_hdr)
+		return -ENOMEM;
+
+	pos = (uint64_t)init_hdr_offset;
+	amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
+					sizeof(struct amd_sriov_msg_init_data_header), false);
+
+	switch (init_data_hdr->version) {
+	case GPU_CRIT_REGION_V2:
+		if (strncmp(init_data_hdr->signature, "INDA", 4) != 0) {
+			DRM_ERROR("Invalid init data signature: %.4s\n", init_data_hdr->signature);
+			r = -EINVAL;
+			goto out;
+		}
+
+		checksum =
+			amdgpu_virt_crit_region_calc_checksum((uint8_t *)&init_data_hdr->initdata_offset,
+				(uint8_t *)init_data_hdr + sizeof(struct amd_sriov_msg_init_data_header));
+		if (checksum != init_data_hdr->checksum) {
+			DRM_ERROR("Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
+						checksum, init_data_hdr->checksum);
+			r = -EINVAL;
+			goto out;
+		}
+
+		/* Initialize critical region offsets */
+		adev->virt.crit_region_base_offset = init_data_hdr->initdata_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID] =
+			init_data_hdr->ip_discovery_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
+			init_data_hdr->vbios_img_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
+			init_data_hdr->ras_tele_info_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
+			init_data_hdr->dataexchange_offset;
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
+			init_data_hdr->bad_page_info_offset;
+
+		/* Initialize critical region sizes */
+		adev->virt.crit_region_size_in_kb = init_data_hdr->initdata_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] =
+			init_data_hdr->ip_discovery_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
+			init_data_hdr->vbios_img_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
+			init_data_hdr->ras_tele_info_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
+			init_data_hdr->dataexchange_size_in_kb;
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
+			init_data_hdr->bad_page_size_in_kb;
+
+		/* reserved memory starts from crit region base offset  with the size of 5MB */
+		adev->mman.crit_regions_vram_usage_start_offset = adev->virt.crit_region_base_offset;
+		adev->mman.crit_regions_vram_usage_size = adev->virt.crit_region_size_in_kb << 10;
+		DRM_INFO("critical region v%d requested to reserve memory start at %08x with %d KB.\n",
+			  init_data_hdr->version,
+			  adev->mman.crit_regions_vram_usage_start_offset,
+			  adev->mman.crit_regions_vram_usage_size >> 10);
+
+		adev->virt.init_data_done = true;
+		break;
+	default:
+		DRM_ERROR("Invalid init header version: 0x%x\n", init_data_hdr->version);
+		r = -EINVAL;
+		goto out;
+	}
+
+out:
+	kfree(init_data_hdr);
+	init_data_hdr = NULL;
+
+	return r;
+}
+
+int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary)
+{
+	uint32_t ip_discovery_offset =
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID];
+	uint32_t ip_discovery_size =
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] << 10;
+	uint64_t pos = 0;
+
+	dev_info(adev->dev, "use ip discovery information copied from dynamic "
+		"crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			ip_discovery_offset, ip_discovery_size);
+
+	if (!IS_ALIGNED(ip_discovery_offset, 4) || !IS_ALIGNED(ip_discovery_size, 4)) {
+		DRM_ERROR("IP discovery data not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+
+	if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
+		DRM_ERROR("Invalid IP discovery size: 0x%x\n", ip_discovery_size);
+		return -EINVAL;
+	}
+
+	pos = (uint64_t)ip_discovery_offset;
+	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+					  ip_discovery_size, false);
+
+	return 0;
+}
+
+int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
+		resource_size_t *bios_offset, resource_size_t *bios_size)
+{
+	uint32_t vbios_offset = adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID];
+	uint32_t vbios_size =
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] << 10;
+
+	dev_info(adev->dev, "use bios information copied from dynamic "
+		"crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			vbios_offset, vbios_size);
+
+	if (vbios_size > *bios_size) {
+		DRM_ERROR("Invalid vbios size: 0x%x\n", vbios_size);
+		return -EINVAL;
+	}
+
+	*bios_offset = vbios_offset;
+	*bios_size = vbios_size;
+
+	return 0;
+}
+
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
+{
+	uint32_t dataexchange_offset =
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID];
+	uint32_t dataexchange_size =
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10;
+	uint64_t pos = 0;
+
+	dev_info(adev->dev, "use data exchange information copied from dynamic "
+		"crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			dataexchange_offset, dataexchange_size);
+
+	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
+		DRM_ERROR("Data exchange data not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+
+	pos = (uint64_t)dataexchange_offset;
+	amdgpu_device_vram_access(adev, pos, pfvf_data,
+					dataexchange_size, false);
+
+	return 0;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
@@ -1301,7 +1555,7 @@ static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return 0;
 
 	tmp = kmemdup(&host_telemetry->body.error_count, used_size, GFP_KERNEL);
@@ -1380,7 +1634,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return -EINVAL;
 
 	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3da3ebb1d9a1..f1498671e8a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -281,6 +281,15 @@ struct amdgpu_virt {
 	bool ras_init_done;
 	uint32_t reg_access;
 
+	/* critical regions v2 */
+	uint32_t init_data_header_offset;
+	uint32_t init_data_header_size_kb;
+	uint32_t crit_region_base_offset;
+	uint32_t crit_region_size_in_kb;
+	uint64_t crit_region_offsets[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	uint64_t crit_region_sizes_kb[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	bool init_data_done;
+
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
 	uint32_t vf2pf_update_interval_ms;
@@ -416,6 +425,12 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary);
+int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
+					  resource_size_t *bios_offset, resource_size_t *bios_size);
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data);
+
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 33edad1f9dcd..130f188ebb84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -23,26 +23,83 @@
 #ifndef AMDGV_SRIOV_MSG__H_
 #define AMDGV_SRIOV_MSG__H_
 
-/* unit in kilobytes */
-#define AMD_SRIOV_MSG_VBIOS_OFFSET	     0
-#define AMD_SRIOV_MSG_VBIOS_SIZE_KB	     64
-#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
-#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
-#define AMD_SRIOV_MSG_TMR_OFFSET_KB	     2048
-#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB	     2
-#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB	     64
 /*
- * layout
+ * layout v1
  * 0           64KB        65KB        66KB           68KB                   132KB
  * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
  * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
  */
 
-#define AMD_SRIOV_MSG_SIZE_KB                   1
-#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB
-#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
+/*
+ * layout v2 (offsets are dynamically allocated and the offsets below are examples)
+ * 0           1KB         64KB        65KB        66KB           68KB                   132KB
+ * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
+ * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
+ *
+ * Note: PF2VF + VF2PF + Bad Page = DataExchange region (allocated contiguously)
+ */
+
+/* v1 layout sizes */
+#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1			64
+#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1		2
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1		64
+#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1		\
+	(AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 + \
+	 AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+
+/* v1 offsets */
+#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1			0
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1		AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1
+#define AMD_SRIOV_MSG_TMR_OFFSET_KB			2048
+#define AMD_SRIOV_MSG_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1		AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1
+#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1	\
+	(AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1		\
+	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
+	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
+
+/* v2 layout offset enum (in order of allocation) */
+enum amd_sriov_msg_table_id_enum {
+	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
+	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
+	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
+	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
+	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
+	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
+	AMD_SRIOV_MSG_MAX_TABLE_ID,
+};
+
+enum amd_sriov_crit_region_version {
+	GPU_CRIT_REGION_V1 = 1,
+	GPU_CRIT_REGION_V2 = 2,
+};
+
+struct amd_sriov_msg_init_data_header {
+	char     signature[4];  /* "INDA"  */
+	uint32_t version;
+	uint32_t checksum;
+	uint32_t initdata_offset; /* 0 */
+	uint32_t initdata_size_in_kb; /* 5MB */
+	uint32_t valid_tables;
+	uint32_t vbios_img_offset;
+	uint32_t vbios_img_size_in_kb;
+	uint32_t dataexchange_offset;
+	uint32_t dataexchange_size_in_kb;
+	uint32_t ras_tele_info_offset;
+	uint32_t ras_tele_info_size_in_kb;
+	uint32_t ip_discovery_offset;
+	uint32_t ip_discovery_size_in_kb;
+	uint32_t bad_page_info_offset;
+	uint32_t bad_page_size_in_kb;
+	uint32_t reserved[8];
+};
 
 /*
  * PF2VF history log:
@@ -431,12 +488,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned
 #define _stringification(s) #s
 
 _Static_assert(
-	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
-	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
+	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
 
 _Static_assert(
-	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
-	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
+	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
 
 _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
 	       "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index f6d8597452ed..e1244cbee1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -222,12 +222,20 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 				adev->virt.req_init_data_ver = 0;
 		} else {
 			if (req == IDH_REQ_GPU_INIT_DATA) {
-				adev->virt.req_init_data_ver =
-					RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1);
-
-				/* assume V1 in case host doesn't set version number */
-				if (adev->virt.req_init_data_ver < 1)
-					adev->virt.req_init_data_ver = 1;
+				switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1)) {
+				case GPU_CRIT_REGION_V2:
+					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V2;
+					adev->virt.init_data_header_offset =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
+					adev->virt.init_data_header_size_kb =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
+					break;
+				default:
+					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
+					adev->virt.init_data_header_offset = -1;
+					adev->virt.init_data_header_size_kb = 0;
+					break;
+				}
 			}
 		}
 
@@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct amdgpu_device *adev,
 
 static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
 {
-	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
+	return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_INIT_DATA,
+			0, GPU_CRIT_REGION_V2, 0);
 }
 
 static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
-- 
2.17.1

