Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484E9CD4F21
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 19:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB9810E5B2;
	Tue, 12 May 2026 19:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mtsIPDAp";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D6510E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt2TFfjq11yjb4GQCyLVZgBm69K22AtIq+EeMTe0iigUykC1o/n+wXjDXNLmKME3z6nFZen8I93Czh8b4AEWtg9i0leX3MYL0j5YUOZXCgXF+y+oGL7SShEP/ifTaWqngElExfG+mBtMRI0nbw4iFT0e2t5EnKt7DOE8D1eCAIQM7YZ+AE9TUWWcg2BuXOwPBJGWeLY9nK/4oj6p6477NtSY3AbEOka63MfgjN07U7nj32BBAkBeIwCfdrmw76x+3iUe1TgWKQ71gm2hSaaIl5N9/V7jBTnhUSWqCpILbieeXeQUPrl0XzYcbygFEBpEqfcz9cjPqjNI9jvISv1GNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oURqfOylrgZtI0ISErUXuSa7uhNwFmHHywz3VD6mUHo=;
 b=KsQBLWuCAvh5urti6wd1olPVw7S5/CgkkwPTkbghVFnhYcCj4fV0i/vzYrX34f55dJsjg1yU4rWqsqv7/J9jwrRA5L8fefZKpfN+uLLreGi33qauakZTJHghLD2JyhU+JMqLOdnK3gg06cpSKIoW3veDHurpMn6ovYr0IHOLAMmudxENHw7RYn6gJrJv63lJVv1vTNpCsGKr9fFhccd1jct3ekmvgww7+Bq70jgHU0ipB66PmImthQY6AVspM5a38gwxUQMf8m05hImonZmi9g7KyhSlnTAR942+hAr2SfGm8Vgf6ftlZAS4ch4cR5MYowzR3S7tyiSatN5uRmrKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oURqfOylrgZtI0ISErUXuSa7uhNwFmHHywz3VD6mUHo=;
 b=mtsIPDApvX1qoKIHmkg09Y5v9CYoRY2WIakQ1vsE9RlAwBMJNzL88n2ZqMN71SpGwwo+QHebLR5K5GcnKXHwbWPo1t9pStbf3x9B54NIP4i8v6cSepDnt9dtt3jJe/m8doZXSXvdVm2Uj5yX5WfaAEIkAM/rsy5TcQxPqCrXxnE=
Received: from DM6PR06CA0068.namprd06.prod.outlook.com (2603:10b6:5:54::45) by
 BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 19:01:01 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::c6) by DM6PR06CA0068.outlook.office365.com
 (2603:10b6:5:54::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Tue,
 12 May 2026 19:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 19:01:00 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 12 May 2026 14:00:59 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use asic specific pa mask
Date: Tue, 12 May 2026 15:00:46 -0400
Message-ID: <20260512190047.655578-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea905d5-70b8-4a97-827d-08deb058ceb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: taXEp5RNt8h/a0gBfetqlXVRsVDqFFC/7WT1cQ2AqDviZbZ2YJMXS5Q2J9dC+KMv3e9W7+dOvFX7twH0xzo3ZrSPGdBI13WEWzhDI7tWoIobigrYCToGYWq/WR+1yKjF9EGfCLopYUcTm5lhlbPzjai8M9bxRKDrMIJnsMZOQ03FuMriGlw/y1JRVGER41ZMFhHhpPdZicefs9bQbA8pdamh+EdqHknFIAL1teGHtCgq1QWgaKEXmikAkdNEtTP+UbqPUYoc5Rr3yCrUFPyL6uSM8v3PGkVMLN/Bmav0j3YPGBTLGoN8soBf7SyGvYW83OEZPbuJfCDKK3M/xDSpn5cAUdZ8IHUj1435OPv/1JOe3i6WVcNZLcC6dvlePsMVvVj4vcrsysXsW1l+DPKn6jXdbDEUJDKxlX8Wguokcm5LKwfWXh66sDTZw5hHW+B16UgJOhTEUK+jyRJG8VzD8FzjakoQwLU4Ii+WoOtRVEqUikuS95/Tx68am6482MixvOvLO1yTo5JnIVFxnIfBGWQd3bJc0TU9c9bp6sC7ufTNygvxSQQmFhyUTflS2+HQzLkChHGCsANpffhn6YK90Tcw7TsHHeg5lNv0Lv+7Vk1WBSP7QnkM6xMKv9ckD/hYrvctlavT54ik3vk+YhFORdff6NEDkbZHmPYX3NDqqjj8VfxfL0hMsKzKofQkp54yjQeanTYWwiouHvhTTU0qTWEiPfnZRKNx2xlu+d7cQoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2uWPRoNkcVYW2xJT8X0szn36Su4DXxA6gRuw7KKh9KryvVgSankl9dh8P+5pamQzy6JxyKEKSGbZDeyI2lHEYUPgS2MsHfX2cGwxMgVOPTerr3OjUS1zXINyd+dyXlhD2NAZw3D5umS0RJgMbZIuCzuCBsb6LYYyATc+bmE/PDoRmcpXEYNWOReEpxyDktqR9xkTZPLNJBRXpHo/1iHbQOZAltuplbj9JrJV65+1oHtw/m4SDLZY2MT4NNLKrKRjjy59f29OQlhsUvY3soji4HwAoABIYG6tBe8U3ha/1hagM5sBL9QKER0vrsos7Hj2z7R7+aKfXmDBPcGA13qXNrd5HXRfg0ci7tTpN64k3T/i6JsmQhA8bH18yz+4z+o6E5UgYDH791Pe33XcEDDTB8ITqXzi78zRTGuRvopZm7Zp950foSxnjqb4pPWFGco5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:01:00.3970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea905d5-70b8-4a97-827d-08deb058ceb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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

For PTE creation use asic specific physical page address mask

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 1 +
 9 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..631c8a7cc99a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -170,7 +170,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 	/*
 	 * The following is for PTE only. GART does not have PDEs.
 	*/
-	value = addr & 0x0000FFFFFFFFF000ULL;
+	value = addr & adev->gmc.pa_mask;
 	value |= flags;
 	writeq(value, ptr + (gpu_page_idx * 8));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 676e3aaa1f27..886311fbc2d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -280,6 +280,7 @@ struct amdgpu_gmc {
 	u64			real_vram_size;
 	int			vram_mtrr;
 	u64                     mc_mask;
+	uint64_t		pa_mask;
 	const struct firmware   *fw;	/* MC firmware */
 	uint32_t                fw_version;
 	struct amdgpu_irq_src	vm_fault;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f2ccf30da324..1e98a9eb8e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -843,6 +843,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+	adev->gmc.pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 93b1912e28c8..4b93afe7ac8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -818,6 +818,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+	adev->gmc.pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 8bea8d0d16b4..a921e4c007ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -813,6 +813,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	uint64_t pa_mask = 0;
 	int i;
 
 	adev->mmhub.funcs->init(adev);
@@ -842,6 +843,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 * block size 512 (9bit)
 		 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 		break;
 	case IP_VERSION(12, 1, 0):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
@@ -854,6 +856,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 * block size 512 (9bit)
 		 */
 		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
+		pa_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
 		break;
 	default:
 		break;
@@ -910,6 +913,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
+	adev->gmc.pa_mask = pa_mask;
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b39f37597429..675e0fbec8cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -830,6 +830,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_vm_adjust_size(adev, 64, 9, 1, 40);
 
 	adev->gmc.mc_mask = 0xffffffffffULL;
+	adev->gmc.pa_mask = 0x000000FFFFFFF000ULL;
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index eedd2006bec3..3eedd2b630c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1010,6 +1010,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
+	adev->gmc.pa_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 347259700dce..a281abb810f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1125,6 +1125,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
+	adev->gmc.pa_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4cc3f2434677..0e485da0db8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1983,6 +1983,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * internal address space.
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+	adev->gmc.pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
 
 	dma_addr_bits = amdgpu_ip_version(adev, GC_HWIP, 0) >=
 					IP_VERSION(9, 4, 2) ?
-- 
2.43.0

