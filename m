Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A747CCD19A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 18:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306B510E327;
	Thu, 16 Oct 2025 18:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7BpgxL0";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA8210E325
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 18:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCy3GiuIkxV6OkuOvBgmkqUNLEowkOIF4Qa2w73iUKZWH9BoXfOV01Sgxl1h5wkc1QxNwDi6dq21UnE80pC/BAjDyJjRWtSo751cA6p7+R647i/BeW6bZQBpTj/+GkQ875/Gok4GmT3+2v/VrlRk/WFZ4Pw62yROT6bS67pCbnygGm+I9cjdK0CFU5z4UGWmdSlzAKgkxAZeaXdwOg8OyDE5Hn2eq6cJXKuNK6i0FiIMptbWPLtIjRD1kSrCo7QeYuWSHhy4CZ3/u2wtZRTFxkrLXyOL5D3FLdYr7xzlT7cN45rRzM8ZuNn+vWihZEXomtRIgLgG3Q+TQjLKf5p2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP/uBaHBUICnGAmgJJRFuJk5IoXLNFCTnDpwZfoIixI=;
 b=nXOoef2NW/16LpTtu6i5R4TbrydmdinO2EJ9e8/ZYFwjYznA8fIVzVBs4ldoCcM1ymjVkWv0wHTiQSLxKvNE7fC+2v8XxCO2/hs61FMzlpd816EZ7EjW4PQDSqI7Lrxk3sh+Wr16qdObRwZvmhIY/6BBVOl2P2p3JXecKQ1SRqKEgoMMswkZNlPlVCiavqsWykqmOqv4kcdtjyusgUcckAJE5G9m+XfDKbk+JJaavpDympqsPXeG5Jz4YCLaYGT1wNmo21fvbKWFCp4Rd133/XIRqSlvccwInFxWa0zbFbnbpGjo9HfPNYDDlpMNtK9onvpJnrAmsA6Uc+lwVk5hjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP/uBaHBUICnGAmgJJRFuJk5IoXLNFCTnDpwZfoIixI=;
 b=b7BpgxL0/aiPYnRgjtMv/njcSBsYZQNoakLIkYy7qN9Q+e2TR9UnxVQFKO2wCDmZr1WC/nhqN9W748njPVJNGsjTrg3ZT1Tm/YHA1eWUOoYJx/1P1NfTP5KQUJd1nHljIosf8K1JyIOrsxd0kGvzv+HY2uebnHXdevJqmqMSeXo=
Received: from SA0PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:d3::18)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 18:02:37 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::f2) by SA0PR11CA0013.outlook.office365.com
 (2603:10b6:806:d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 18:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 18:02:37 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Oct 2025 11:02:37 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v6 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Date: Thu, 16 Oct 2025 13:02:19 -0500
Message-ID: <20251016180219.15879-2-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016180219.15879-1-yunru.pan@amd.com>
References: <20251016180219.15879-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 906193ab-c501-406d-3eb1-08de0cde3102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4rkYL/XkaS2izev4kt3DMRijRanYaPEJMcynlvMxbEo78onHzoeAmPVNqZQa?=
 =?us-ascii?Q?V0pWzVcGM1UsdYZexO5ZJvc4OdmOt4g3iA1rJ3UKzXTZUBLn+59+4vLA0FV7?=
 =?us-ascii?Q?E1O7iH9u1tljdamYb4Vbg8HZfa6hf1xK9ffEBLi/EzP2JiUd9FwA+ilolP3L?=
 =?us-ascii?Q?DML+Z0lrbb41VdDBnFH5OEQdLnmDjJB9NIaZE/KgTvUMBmW+gRrLHwULNbqt?=
 =?us-ascii?Q?ZMqglHqJx6a/Jx8ksKwkEIrqClHMNhlHgObcrxGdBQzNiO0ojcIKfLfj6S96?=
 =?us-ascii?Q?PQ0jkvoOQ79HQTy7w33h+rNmZbM9jzMGlX6XVKmJUv3ql1IOU/noN6IV2yA+?=
 =?us-ascii?Q?nmVEhvxi+nF8W0m3MiiU3nZEHtrIf2am+2bGHcVvvZMqrS5apME0i/XCQWZp?=
 =?us-ascii?Q?db6K8I+PnruvBDcYZVWiSQ6tZXhyBkg0g/TAgX6boWqBrMCs+vudSvPAr6Yf?=
 =?us-ascii?Q?aQTg+S2E+4NaG7s4QWH/uXFabCILpoYXKsNLcG1AYlQsjT/z1X2zzPFkcyN9?=
 =?us-ascii?Q?3M1sr0svE+QtCqfmf8ev9+MGA8GcYumnh3lcrJ1xiXhhOisiqsBr1pNgGeWr?=
 =?us-ascii?Q?DJapwd2QQxIpsBzxrqmFhUSgrNseIy/Y/kWw2U8zBGk0/y9YtQleiyanatJX?=
 =?us-ascii?Q?rU054JdlKSsDazckGFvWRqFeNMiseGYJ1C6A2HrRlxEKNRmNc4EUFwwu1goI?=
 =?us-ascii?Q?q0R5R97uDD5FsLUK0mPYuW5MpHZiNxM9UEb02jEr9uROnX5HHbz9qyBDkemC?=
 =?us-ascii?Q?hPJAzt7TYy1C0NGPI0dbXnTMrtZqKx1V5bMuMDMJEz53VuBpfZha/kUwtVkX?=
 =?us-ascii?Q?LjjQgOS6UIi+wZclRGgWYTxBxY6livj2c425Tf/JAY9NB01T1k3Uv7xPCX44?=
 =?us-ascii?Q?ggjPB5Mdkzt2u050Otv6/vTvyXLUXg258ejrvWCwLtj9xtqEs0xMoWdA1f6R?=
 =?us-ascii?Q?Sa+pnpop/58nDo2ks7hgb7Sy/KWtDc7vilYGmEKkAtgc/PPIOF392btd3Ryn?=
 =?us-ascii?Q?MYdvXDYsFe7/l5UbhTmoOcX6qI9R50UzMuWF5eEst7gPmy7BkNd6ekiu4lYC?=
 =?us-ascii?Q?3O/TKrmQKdq4F/0BTj586eFd1KnEyEhGC590JSV8w6RREZX60SgmJ25wPjJn?=
 =?us-ascii?Q?ZWx6h1hxqt/BgwhSdTGjGa4j8CWmlix8QZ5TuV0qaP29dwfC/JhPSXF1YtBI?=
 =?us-ascii?Q?uLvkzin+tK8OyYBJyaBXcZgUGw0GOPMOreokC734TS0dW6XoMCuEIrvmAALh?=
 =?us-ascii?Q?ILA15d7aVVtG0YRChWOpP7V1BAXRs0HibAp2g+DfS1B648XJWwFa2x645Cnq?=
 =?us-ascii?Q?8BE0VM8TPCykJlk1ICmQ8lJvWcqoVGcoH0hJCzo1DzCCciaAGPNW+x1GhFvq?=
 =?us-ascii?Q?14kQpQpxHlwGpKCjwdmSJX+ukKs7UIiKSnLBq5EWDIFFlELYIAH2W1M3OnLZ?=
 =?us-ascii?Q?h0f65KT+ij0OoP5b6/ptbi/P+6wcDKnh1XmI/QFhu/m5kF/3RDVg3I/Ail2w?=
 =?us-ascii?Q?N40PMST1hUzbmUjSyE3f2bUPq1rMyK4ofiUK2vCm3EoKa3qEMiifwx12bgQ7?=
 =?us-ascii?Q?KjpLgcsaom4yJRg/sx0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:02:37.7024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906193ab-c501-406d-3eb1-08de0cde3102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 34 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 26 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 37 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
 4 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 00e96419fcda..070fd61f8463 100644
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
 
@@ -114,18 +115,33 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 
 	adev->bios = NULL;
 	vram_base = pci_resource_start(adev->pdev, 0);
-	bios = ioremap_wc(vram_base, size);
-	if (!bios)
-		return false;
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
-	if (!adev->bios) {
-		iounmap(bios);
+	if (!adev->bios)
 		return false;
+
+	/* For SRIOV with dynamic critical region is enabled,
+	 * the vbios image is put at a dynamic offset of VRAM in the VF.
+	 * If dynamic critical region is disabled, follow the existing logic as on baremetal.
+	 */
+	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+		if (amdgpu_virt_get_dynamic_data_info(adev,
+				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size)) {
+			amdgpu_bios_release(adev);
+			return false;
+		}
+	} else {
+		bios = ioremap_wc(vram_base, size);
+		if (!bios) {
+			amdgpu_bios_release(adev);
+			return false;
+		}
+
+		memcpy_fromio(adev->bios, bios, size);
+		iounmap(bios);
 	}
+
 	adev->bios_size = size;
-	memcpy_fromio(adev->bios, bios, size);
-	iounmap(bios);
 
 	if (!check_atom_bios(adev, size)) {
 		amdgpu_bios_release(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e75334f3b3a..863ceaad8c21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -303,10 +303,26 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	 * then it is not required to be reserved.
 	 */
 	if (sz_valid) {
-		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
-		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
-					  adev->discovery.size, false);
-		adev->discovery.reserve_tmr = true;
+		if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+			/* For SRIOV VFs with dynamic critical region enabled,
+			 * we will get the IPD binary via below call.
+			 * If dynamic critical is disabled, fall through to normal seq.
+			 */
+			if (amdgpu_virt_get_dynamic_data_info(adev,
+						AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
+						(uint64_t *)&adev->discovery.size)) {
+				dev_err(adev->dev,
+						"failed to read discovery info from dynamic critical region.");
+				ret = -EINVAL;
+				goto exit;
+			}
+		} else {
+			uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
+
+			amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+					adev->discovery.size, false);
+			adev->discovery.reserve_tmr = true;
+		}
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
@@ -315,7 +331,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		dev_err(adev->dev,
 			"failed to read discovery info from memory, vram size read: %llx",
 			vram_size);
-
+exit:
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 083823f58c15..5c846798f4e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1008,6 +1008,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 			init_data_hdr->bad_page_size_in_kb;
 	}
 
+	/* Validation for critical region info */
+	if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb > DISCOVERY_TMR_SIZE) {
+		dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
+				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb);
+		r = -EINVAL;
+		goto out;
+	}
+
 	/* reserved memory starts from crit region base offset with the size of 5MB */
 	adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
 	adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
@@ -1026,6 +1034,35 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	return r;
 }
 
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
+	int data_id, uint8_t *binary, uint64_t *size)
+{
+	uint32_t data_offset = 0;
+	uint32_t data_size = 0;
+	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
+
+	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
+		return -EINVAL;
+
+	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
+	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
+
+	/* Validate on input params */
+	if (!binary || !size || *size < (uint64_t)data_size)
+		return -EINVAL;
+
+	/* Proceed to copy the dynamic content */
+	amdgpu_device_vram_access(adev,
+			(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
+	*size = (uint64_t)data_size; // update the size as out param.
+
+	dev_dbg(adev->dev,
+		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+		amdgpu_virt_dynamic_crit_table_name[data_id], data_offset, data_size);
+
+	return 0;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8d03a8620de9..2a13cc892a13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -442,6 +442,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
+	int data_id, uint8_t *binary, uint64_t *size);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

