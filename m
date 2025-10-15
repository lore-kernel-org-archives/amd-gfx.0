Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76510CCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C6910E8FC;
	Wed, 15 Oct 2025 21:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nk12bhn+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF1210E8FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTTZgEFOJ/ffyXiaFs2HsReT08lMqAoIm0b+TI8ONaurPgOkyGg+As8ogNlSUI2sRxiVnSGdEFwJEDqDkdDXRAKtqOz6CGrDwEO7UDDIHJhO5hmNjIgeg3U4AvgZByV3vh3rZd6MB9OuHQDWEaXga9MTfLEINaoPcERyYwdgzdF86xQIGsauIgQIbYWLGYtKvaIUe/09QgvKyi11BGOmlfpta1ovrHrxJ/ZY62QAm6mY9XFT/GlwNDDW1XLTwZRQWWpmDAeuGrLWPqc8KlTZI4Ss2J4x5WrbmDj53SODNdyibuCr0I4vFsy6tf4Ccsax261ZaNVwQ5GlVyAbDXPDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XtQM5QwD2fkKCadjsZ/OuCkYolB1UK3danJBeaNtFk=;
 b=QbVsJFe0qDPcv+rYA0xCqXrPSnwC1L1kC9IDad680jlGXUYKSQ5Vq2IiliWpCZUOPIHSHIS+TQhpmrF7Xy/LiggN9kCKDgyXqrliRxQgebBm9i6ijNyQrMGXQZkO1rLtwYcIaQ1/4cc3RJ7WL5JdSwPo6vyFV0mckSJ8JIBjj7cbNhUQK94D9oX4shM/VNNmmVLBPOqvKXInYpeUHKvrDTo0s1F8V+ZTzrvy1scWlDHGTK/zMHgrToBujS7hjBDAvsr6a8uHJQ8XsP63XRNHnpobzSpSI6gJKbM5ZgznYmwmGKCJsMX1BL5hf9iQyywUWiZ8QoefEliVGLvpSLUAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XtQM5QwD2fkKCadjsZ/OuCkYolB1UK3danJBeaNtFk=;
 b=nk12bhn+ChizFd65of5wsvic0NQliQjZgtKPFAno++oeQAQHLUtMhjBvDzL1/LWK/WVtIjJda5vPM7A4zUNspsceK6ECHGlHD+ZhWugOxq3rG9N5qAzSLnvlIqBCRiBhKYvqt9ztGEfieQbq9KqpxZGYqx7olP06sA5+5aIP/W8=
Received: from BN0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:141::9)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 21:49:08 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::2) by BN0PR07CA0019.outlook.office365.com
 (2603:10b6:408:141::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 21:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 21:49:08 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Oct 2025 14:49:02 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v5 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Date: Wed, 15 Oct 2025 16:48:47 -0500
Message-ID: <20251015214848.11580-4-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015214848.11580-1-yunru.pan@amd.com>
References: <20251015214848.11580-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 0642b9a4-901f-4e8d-2369-08de0c34ab4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2uIBqQgrDykee4CbGHUOj7t8JMSAifNCf9F5wPatDGnBQ4plVGHqKQt4tT7A?=
 =?us-ascii?Q?+y5EaA4Hd5IVnz/QoXHuwLPvAzP0bdacC+FCK8cuYU5jY373cK7uFbLuQXmV?=
 =?us-ascii?Q?nSQ5PO8m9Efy7HZJVfuBZPP+jn+LaX44T6YNNFvxFdReYjjK5X04G/jnFvuh?=
 =?us-ascii?Q?fsdaxSraQRdZYxsfe1yW9ECcQqYOUeQga1N2TSSnO0wTj7rBu2waGy078Rf5?=
 =?us-ascii?Q?BIkVgDh2OL1zVpS1zwP10L6KrZFrKYeiYGLUrRQ0Q/bun244otKd8F5goHoQ?=
 =?us-ascii?Q?pfKTBl8xFl56QzUvG/OEjEtoUZ9HN+bt4Ths0IqpjPYt0n4+ovJeM+YO9wn6?=
 =?us-ascii?Q?pnMVdYjexfJoZGB/SWddVgc9ojZy5Gx9KXr5osnH+TKkl0Z+FxKm4OuxWBqJ?=
 =?us-ascii?Q?H2o1tBYCTf2/0OmmV1wezL4e4O2IvS/+s0LfxpQ4oiKbbnN3OEFluy92AWLX?=
 =?us-ascii?Q?zHwwTQQmt7s+co9DQwE94smJtdKCjcHZlES74u6GVXMkBKp0QjlRo8Zuu/+d?=
 =?us-ascii?Q?NDKjqsNMz/Hb+lVAdQh7MkgK3289JvYdPOLRxkYtdEm21vm3B6vuK8V5cJU7?=
 =?us-ascii?Q?FwnIHOoobZjQ8XTK3Un8RWn0FeiMZw12K++HLgwq4u7U4McevJX7bwXkR9ag?=
 =?us-ascii?Q?i9LNg6D/iaKS3W6piyTEP5dMqhhiYrIYAMzr3Gr1KIZ3WDGbWI8NUZepda/y?=
 =?us-ascii?Q?rZZwlm8U43QZjY9/Knt+nMAI5qsZEZ78EPTiKnYgx+19lbI89CEQV5cD6B32?=
 =?us-ascii?Q?jjGNn/OMhQybT991VeSbkPoNKH5hEX0UZsWvr/YoFT8RFhaO9hGM+cFztJ99?=
 =?us-ascii?Q?lSCcf89oPaHJLtW1LXqnfwaqGnjnehDwP9nsRTKGIzvwNoRA6j+qLSyVT58d?=
 =?us-ascii?Q?I8z99U/iaGPc8e9Dbc4csGphiNqh4C7Oa2IcIgDWH9J52yQ62El5+ELs4fSp?=
 =?us-ascii?Q?gNcLvTELOx3j2Y1t8KE5bNyWR82vF836w2VoeoLzwyGFZF+VAJmkbA8un130?=
 =?us-ascii?Q?GExt34btyzwoZna+qzjW9Oat+WLDrjftXDmItd6Ggm3aYynkkcAfBOrMTiUz?=
 =?us-ascii?Q?MyyA7uFZi/gx9uTSrWbCxf54phjagZ5uF3zfKlyJV9Dlq1rgJyIzQTsG6WOb?=
 =?us-ascii?Q?Dtv3EC4hym+gYFrT9XO/OHyYe/Ln4s9M+YINfo4wKcDD8csXUdSmmfnv5x3Y?=
 =?us-ascii?Q?OeyPw7fE9F7NhYeKBX1Tjr2UqYiFJE4nExKaG8CBdGtKD3bEIpRWGAebiNrD?=
 =?us-ascii?Q?sMpbJ/mIkGnYj+U9HDmiWVQmaIPRiPf74C9TIzffaXNNwKoWfMd0SyvTloGj?=
 =?us-ascii?Q?G/74UZ7mM9V8WVmTWmachyJUyYJWPJbsjZTaRT8ov2q9pg3p8X6uC3/44oyR?=
 =?us-ascii?Q?KWnEZb3uF6/jL4frA9toOwbd6+WmKCJMRclDMWs+Ircu8s7lhszrJMqGq6fz?=
 =?us-ascii?Q?BwKqudm43Wix5ZCc5f4sdJ4Rzns/CB5B4UuKbKeSRspN+08noaaaIV5KyY5M?=
 =?us-ascii?Q?BHVmSp+SnczLJdoeMuUNfuibdQMAQhrNW/amDTdUPkcvqUizFuzsEUKF6on8?=
 =?us-ascii?Q?v0p+3loasPYoupwzO4Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:49:08.4679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0642b9a4-901f-4e8d-2369-08de0c34ab4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 37 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
 4 files changed, 83 insertions(+), 13 deletions(-)

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
index 4e75334f3b3a..1809deb86797 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -303,14 +303,29 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
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
+						(uint64_t *)&adev->mman.discovery_tmr_size)) {
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
 
+exit:
 	if (ret)
 		dev_err(adev->dev,
 			"failed to read discovery info from memory, vram size read: %llx",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 12659990abe0..15157ed5df29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -999,6 +999,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		goto out;
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
@@ -1017,6 +1025,35 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
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

