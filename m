Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B261CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EE610E699;
	Tue, 14 Oct 2025 20:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Toca2K0P";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BA410E698
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 20:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2bPJ8cJAlPJxzyCDdMTc/3lEGQFQgkoIsQV1aMiS8VPvhQnPQwiZDM2x2W+zRPZhLsKjPFyo6GiPam5yh2jzDjJQVmcfDVUedGmG7j1ygMY7zfF21H9ShNGHkGab2JYiEmr/qqhFXdfElT183pat3qFgOSR1ZBHRRTkSXv2lCNsf0QodISEaX5gm/PAfV5c/wzJWibum8OQUtoMaQ84UqPA+alZJ6k00S0oUjS49KpbMt/bi8ClOk2btsK9VRXDxNyMr1XghyDa/5Md4TRwJq9xlJ/ba9o3vjNklomthIRwq2qV+BkVNVIjGwELilIW1dHd9ZTjfAOQLwLaYTXpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdi20GvChZrFKoHcCbSPnBK2fcE0WUdqW7kVCwQsL8M=;
 b=uCmNcX2UH8GSmAwfaAI2chEJviSYGSxGWrT9Zh7XzaxeZxDbS70Sb2Va9Xf3PVaAPPXQaKqrsLCgtJw1msy4EfT2/U/WNDDTKzcydl3mJKO7TLSH6h+jvdLEif6ZdoPT4Jb3ossadw0OqG0mW0KKY98kxXsH8tal66QJbibbhxYhxdC9DhIRVbE96qmM2ZAzLVLsL3+XL0B0aWHcM0v20cTpVJVEH66LGmvgxAVzDVE7n9QCp5HYDBDV82HKswAsBsj+S0pDc59k9jvj1Sw/7c4NavE3QuBPs9YMwIbA63xlTikCFAEzGpUJfmQx//Aalb1RiMl3juzguEsUr5AsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdi20GvChZrFKoHcCbSPnBK2fcE0WUdqW7kVCwQsL8M=;
 b=Toca2K0PH4UF84NcevXgJdKnw3rmWqutL/RS4u4P/YYegqL1ENLuJoeOHzjZ8IXvQ4ETyBNpyMZYUgPAY+8zvdbXWYQPvElyXPjpo+DErvz9XWRw8iy46LxnakcG968VmY7qTKZ4I+kfw5XDR3Q7DLozhNDc7OeA82pWHhzTVdQ=
Received: from SA9PR11CA0020.namprd11.prod.outlook.com (2603:10b6:806:6e::25)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 20:14:06 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::39) by SA9PR11CA0020.outlook.office365.com
 (2603:10b6:806:6e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 20:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 20:14:05 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 13:14:02 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v4 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Date: Tue, 14 Oct 2025 15:13:45 -0500
Message-ID: <20251014201346.9422-5-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014201346.9422-1-yunru.pan@amd.com>
References: <20251014201346.9422-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0d9339-43e4-4e1b-a13f-08de0b5e39c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d61IlsyRyUmvK1PwjIJXCVC17tL3KgHNb0mJvMGMAqKZXWcUhTCVLnRNle+U?=
 =?us-ascii?Q?rbqYosF+jj5LQ49DiOuAIbfcAMDP4qnzo1lvR4NgqD6ECnnU4uGLvQtbnNeH?=
 =?us-ascii?Q?P7NnA+5K+nOFViwIDMZCgJsGZ8Pcl+9CiiD4RGinNDN016rXXqG5aZfFFsZD?=
 =?us-ascii?Q?jEF9cgMYNukD2H+dqiZFBSUgSRxqdgsXgbqRArhURf7gfXcTinQFdOG4rtfx?=
 =?us-ascii?Q?eyGxvjToRkaDUykNtYEs9Vr5vsuD9kB034XEzDMTCw1lomhSi8wc6X3Clnwl?=
 =?us-ascii?Q?qW46wL0uYAJfjTEuysh3JsFjhqqqCKv4ALoDWccOj3RjLCAJe8DUi10BEvY6?=
 =?us-ascii?Q?5QOFNeFmls59sKG/s5ZgxRYaqOuS+H3Yyc3GiMArXR3qG3jZeF+4O2q+Ocvy?=
 =?us-ascii?Q?j8UmClbcQgqsU4C3oQhu3LYaw1kQY3mRb9fsnowIrWv/LKKrSpCpSJkQEFNM?=
 =?us-ascii?Q?5uZwKtBilLpMiUNMap9Q1HOngkctBtQ18dJLZGz2YUCGV9tINKEy6Ahr3o76?=
 =?us-ascii?Q?2Ro1qXGdkl+n+u3YDh3yGpG+VG9Bntl22f2RWuLyc1EcSqSydg12tqt5FS29?=
 =?us-ascii?Q?lkWwe/z0URK4anJGv4DMQaks1KR0Ft5KpHFpcsavVluF0D3hFLJ0pVWFm/Sw?=
 =?us-ascii?Q?V9bynKANvowHt5Z4gq/X97QcKof7Vakq+zDCn72fNFsoV+SVauq2txP5Qset?=
 =?us-ascii?Q?55eolvQILLZkzjGXbJyxQGh1XnxGAvXXUlOxaURwUftj97Uy8D/BSG0KuboH?=
 =?us-ascii?Q?qp9vLrR+m2Xs2TRqS4n/g6uXIsPgsjZ52091SkYFRw0L3COqB17WiEodxllZ?=
 =?us-ascii?Q?ajcZ0Un4gtV3i8Tpuh50MubD23banctyOwmF4uxl/MiZ5DqvOgzB3SP9n21j?=
 =?us-ascii?Q?1asjF10MtuvP3nGjrDnVr7gPK7wHd53KaERPRJ7TkW8iv2fOaqfmHwZ2peZ1?=
 =?us-ascii?Q?RmTytcTqn5VKKM9kyLEbIvHYiTJtAktcV4/FnyMQ4SK8c5+eHUlAuTL3GdeY?=
 =?us-ascii?Q?gV1G7hFkXDl0YJhg7Ad5gsPUre4GeWDIXwVM3gE+RKTh1dzXWjixU/dSD1Xq?=
 =?us-ascii?Q?9O+I5YmC9/S/Thpx3BRyLLdAm8iuGgzp7o9XAMHl+1b0SMQCL6/WInOJY/iW?=
 =?us-ascii?Q?LfhGpbhmKxLqMxlf/61iCIqBgR6PP59gdy7lhcbdtiAWsL16lPpaov/BjGp5?=
 =?us-ascii?Q?eb/SqtuiK49YjMitfzQszYFv1NgEwsv1j7PC6fPs2o9D3WzFeL+mah2eGYv6?=
 =?us-ascii?Q?Z/XU6Enm+SbvWaXZOomtBFycN6RXLfTCjgEGfLHucs7cX6Yi5n4raMkOxazE?=
 =?us-ascii?Q?3jqX0JgqBEcR0kwX7RpAcKc9vSSfN4PhEfaf0WQeqY9F5GeGqDbPhWolSF2U?=
 =?us-ascii?Q?PzGlykiS8rp9UjW1bXsNSU2lOaamV4r5j8GkQk3McZbgP3zfI5u6mvezrTHi?=
 =?us-ascii?Q?M7rljGD5YjV3zogXVVZjoy0gqJDgOOxXmV/gjuVYRgI1zdTCciMR3U8ZPOyp?=
 =?us-ascii?Q?Y4IMDhaHnxDqFNNYr7HZaDWc4elA3HV76QaaCB/R3V5XRMPIrtrqxIo57++5?=
 =?us-ascii?Q?gBJxKNkUOAU3etbTQlo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:14:05.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0d9339-43e4-4e1b-a13f-08de0b5e39c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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

1. Added VF logic in amdgpu_virt to init IP discovery using the offsets from dynamic(v2) critical regions;
2. Added VF logic in amdgpu_virt to init bios image using the offsets from dynamic(v2) critical regions;

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 36 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 63 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
 4 files changed, 111 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 00e96419fcda..5960ab1be4d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -96,11 +96,12 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
  * part of the system bios.  On boot, the system bios puts a
  * copy of the igp rom at the start of vram if a discrete card is
  * present.
- * For SR-IOV, the vbios image is also put in VRAM in the VF.
+ * For SR-IOV, if dynamic critical region is not enabled,
+ * the vbios image is also put at the start of VRAM in the VF.
  */
 static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 {
-	uint8_t __iomem *bios;
+	uint8_t __iomem *bios = NULL;
 	resource_size_t vram_base;
 	resource_size_t size = 256 * 1024; /* ??? */
 
@@ -114,18 +115,35 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 
 	adev->bios = NULL;
 	vram_base = pci_resource_start(adev->pdev, 0);
-	bios = ioremap_wc(vram_base, size);
-	if (!bios)
-		return false;
+
+	/* For SR-IOV, if dynamic critical region is enabled,
+	* the vbios image is put at a dynamic offset of VRAM in the VF.
+	* If dynamic critical region is disabled, follow the same seq as on baremetal.
+	*/
+	if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled)) {
+		bios = ioremap_wc(vram_base, size);
+		if (!bios)
+				return false;
+	}
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios) {
-		iounmap(bios);
-		return false;
+			if (bios)
+				iounmap(bios);
+			return false;
 	}
+
+	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+		if (amdgpu_virt_get_dynamic_data_info(adev,
+					AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size))
+			return false;
+	}
+
 	adev->bios_size = size;
-	memcpy_fromio(adev->bios, bios, size);
-	iounmap(bios);
+	if (bios) {
+		memcpy_fromio(adev->bios, bios, size);
+		iounmap(bios);
+	}
 
 	if (!check_atom_bios(adev, size)) {
 		amdgpu_bios_release(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb34..e035dba96790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -283,7 +283,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		 * wait for this to complete.  Once the C2PMSG is updated, we can
 		 * continue.
 		 */
-
+		
 		for (i = 0; i < 2000; i++) {
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
@@ -299,13 +299,28 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		vram_size <<= 20;
 
 	if (sz_valid) {
-		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
-		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
-					  adev->mman.discovery_tmr_size, false);
+		if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+			/* For SRIOV VFs with dynamic critical region enabled,
+			 * we will get the IPD binary via below call.
+			 * If dynamic critical is disabled, fall through to normal seq.
+			 */
+			valid_size = vram_size;
+			if (amdgpu_virt_get_dynamic_data_info(adev,
+						AMD_SRIOV_MSG_IPD_TABLE_ID, binary, &valid_size)) {
+				ret = -EINVAL;
+				goto exit;
+			}
+		} else {
+			uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
+
+			amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+					adev->mman.discovery_tmr_size, false);
+		}
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
 
+exit:
 	if (ret)
 		dev_err(adev->dev,
 			"failed to read discovery info from memory, vram size read: %llx",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 820dab538164..fef4ebb0f879 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -940,6 +940,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
 		init_data_hdr->bad_page_size_in_kb;
 
+	/* Validation for critical region info */
+	 if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb > DISCOVERY_TMR_SIZE) {
+		dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
+				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb);
+		r = -EINVAL;
+		goto out;
+	}
+
 	/* reserved memory starts from crit region base offset with the size of 5MB */
 	adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
 	adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
@@ -958,6 +966,61 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	return r;
 }
 
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
+	int data_id, uint8_t *binary, uint64_t *size)
+{
+	uint32_t data_offset = 0;
+	uint32_t data_size = 0;
+	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
+	char *data_name;
+
+	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
+		return -EINVAL;
+
+	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
+	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
+
+	switch (data_id) {
+	case AMD_SRIOV_MSG_IPD_TABLE_ID:
+		data_name = "IPD";
+		if (!IS_ALIGNED(data_offset, 4) || !IS_ALIGNED(data_size, 4)) {
+			dev_err(adev->dev, "IP discovery data not aligned to 4 bytes\n");
+			return -EINVAL;
+		}
+
+		amdgpu_device_vram_access(adev,
+				(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
+		if (!binary)
+			return -EINVAL;
+
+		if (((uint64_t)data_offset + (uint64_t)data_size) > *size)
+			return -EINVAL;
+
+		*size = (uint64_t)data_size;
+
+		break;
+
+	case AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID:
+		data_name = "BIOS";
+		if (data_size > *size) {
+			dev_err(adev->dev, "Invalid vbios size: 0x%x\n", data_size);
+			return -EINVAL;
+		}
+
+		amdgpu_device_vram_access(adev,
+				(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
+
+		*size = (uint64_t)data_size;
+		break;
+	}
+
+	dev_info(adev->dev,
+		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+		data_name, data_offset, data_size);
+
+	return 0;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 5c1dce9731e1..a3ae1ff40e84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -440,6 +440,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
+	int data_id, uint8_t *binary, uint64_t *size);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

