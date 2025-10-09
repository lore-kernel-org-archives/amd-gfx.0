Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2973CAC5BB
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 03:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E22710E908;
	Thu,  9 Oct 2025 03:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cUrCf43N";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF2D10E908
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 03:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF4D66xy7X8OZwAnsU/VAUWUfcW0Ja+i8RslJ8y9XZhISp2l3emUndDWArbHAfEc18EWAqnNNkEH+hrBZ0u3bjm8rIIBjEdnudT2oiGfXwB4SHnzJxM0CPJ7ouaNWTTlN9fTDhrMaJ3wFoaCgl5zjNOSWoqHJgVA+4SNqg3ZVOPtaHf7DnKPwGq6LIXkRmCbPrrLeYd6APPMrqNYl9JYzWIAWg2lJrUMmIcyZXDgShPl2lLNrNo+XZW8nc+VaMIHjZI/SMLhhf34WfyMIhIXohr1watyLfgvroFU1N2ubsizU9Ju1TWzfOdPf4A7Uuz0gOQYTbHVHzMSOfPZrFyNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W/MmYS6v73BovaBpixUlYlE5fgqBjRmru8Bfr00rCA=;
 b=fZBb8MgI/iJJ8tKXya28bb04xKpgqbkG/JJ7AV0NhMnYphKyjcW3jUdRMVq/3US289218rgfwRb38wfb2xr76+lnSNF2vWGIGxV5Ifv7ebhCe/Kn9cZJPDpHkuGDqn19m8R8xdE6/8Uytw231w0OtdVQ3kSxvBmpWWpZsaV6h3H7QmuswoQRI/hoUOTMgPuena/WDZ3ROy/+1iGlFjt1y/h7+U9CgIgQH3xMdRt5JY3JV2Cc1zpz6KxTzgZpPMIxeyq8O3RJlX8tY7FFZ/AxYgbxfYUXZJ5XZwExxTeGFgSpKky1K2aGJGz4POgKG1F2YcyWmWjNzd976yaksBguEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W/MmYS6v73BovaBpixUlYlE5fgqBjRmru8Bfr00rCA=;
 b=cUrCf43NGj3BgWvKaevgaapcP1SnbqjRvsqoCQXzNxXATJbDwzyUdTRrGiByqocTMVaRxC3CBU3O+IGMhbmr+ftqi3fNjBP+9v/7TPyAJPF+sHX4ZnsaGNfHNCsKfixzZhEZBgKa2KlI9frvmP/Iw8IuOnvufiAalkP+WOyHcRo=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:31:24 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::4) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 03:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 03:31:23 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 20:31:22 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init from
 dynamic crit_region offsets
Date: Wed, 8 Oct 2025 22:31:06 -0500
Message-ID: <20251009033106.25022-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd613af-c49e-4b77-9b8c-08de06e45247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hBiG8G0JvEFXHxYerYuKo0q+KC8re1lbVqQkHP+JnUbMhDhQJG7oKk3T/kDL?=
 =?us-ascii?Q?1W2Ii7yYIScoQVf92cEeTJ6fWqmaxhHtm/Qg7WcxR1uh7a8kvINixSI3PsfR?=
 =?us-ascii?Q?j2kvXHe6TtRrX8BzjASKLUqfiFdxFX2/KqKBmqS4sFT6udHkVuVqJbpqFnHR?=
 =?us-ascii?Q?+wpSpSrekxTjwhAEmz3J20ENFXinEmqTeRskj9/DeVN+kOBe7K9ZWAoAc5Yr?=
 =?us-ascii?Q?f1oo3gSrH2hvIwWqlMOluD3wVxONn9yZim7/Su7VUIYaSG+/fsejAGIdpDjY?=
 =?us-ascii?Q?osQEFjF3FFvivphjHKtbgINfBJzl9M02CH/lv0VyXiJH0FgVe99h++k5baEq?=
 =?us-ascii?Q?O7kSA6cGr/cfqrkEyy8CoI0z6/HohCrlOIYDNVTFUNION6KT57UJMm8Uq7Dc?=
 =?us-ascii?Q?sUVxLQFpcYzbrFEvCe0q43qnB02FhgxI3zVB0tWrSit8YNOyXCMp9m1+cBqC?=
 =?us-ascii?Q?f+3vLPCbQL0WR53TZKeD2QpKFwiuG2PL0eq73NW+uGFFa8m7X5NwxuUt9orM?=
 =?us-ascii?Q?w3r+FRTM+FjHcbV2A//KWqHdD2wm5UgMyRVKHjuQFZVTN7JWWiYvBbDAE9yS?=
 =?us-ascii?Q?s6PATvI99b0BYhon4QjuiwVJ6+S2IaYmNwkKhAhFe3TbEyNndfa939N/X8nM?=
 =?us-ascii?Q?e4G4Fpa2XS/crYLTOnDDbrkx5gDadmO43euuExjTfVvsCEEG+Xnyyu2bLKQ/?=
 =?us-ascii?Q?qx/vqSXnTGNdMVso1i7h0jE+SKhVNZVwNSq43jIbYAjCprLRNey7x3sHnhfc?=
 =?us-ascii?Q?cim+RXipkhDvf9IShjsk7i4FnH2VsKTAJB//Ho5fFZGfEGNYi5EKI7tqWdQa?=
 =?us-ascii?Q?xpo2gAaBGcPvc4bst4GGg0DahzQk031o9YeTj7Fb+bEcSIuQZ3367W+fi+Mm?=
 =?us-ascii?Q?lrOXUJw6sH5qCxGe+qGfWwYjubcGIlLEWQ5fTtbSDMl+C5/Xn6lYksjpSxXP?=
 =?us-ascii?Q?dPiHfLIYtm1xQJfeafc+6UNJLYEOSOPQXu/AxwTYlhASZqG2jQs3y9Dwk3Yl?=
 =?us-ascii?Q?4P2EkN/nSo7UuHX9mGA54SgSyTLDfnpHVFMqolz26ijeOax63i2INhxJGj6d?=
 =?us-ascii?Q?aDNFa5veI5/eMSeft73VfbOIN7uaCSq/o4LMdgaV4u/x97REC/YHQt3R6eny?=
 =?us-ascii?Q?Hq4+43PUPkC77T0tU9tsyOB79yGrZhYvbePrNGIDhj2pbsBVSQP6Quu0vodA?=
 =?us-ascii?Q?N1qD9h/psx0d4g5AfSlas/mQ1+qjmyHe3AZZLh9+RoL65gGd+meI2v1Tk567?=
 =?us-ascii?Q?1+xFzX+3raMwQPH6Jr95Q2XSI7yMJCjAL1aFc1t2UId+4KjwuH5tVT09NX2Q?=
 =?us-ascii?Q?nVEbY0yKezdXgK6xKXW++8l3SDA+ENgAK8g7prFNvJmC8etx0hJVvhL4ok65?=
 =?us-ascii?Q?gC8dhkkktPZj9ih/i8aTUD5TNphJb1Rm3ZHzLDnIrRMjVuZTkX4j+hoYlsq+?=
 =?us-ascii?Q?ppFHM+M5RDEKfaLgik4c0Oegyit885pEMelXvuKUhGK2Av/FkwD5yWT9l2sR?=
 =?us-ascii?Q?n7ZF/9Z5eLIJKiIyMxbKVNkNNCqdG5ekwF+jKcL3f8+72N11XBvJuHwHMKCj?=
 =?us-ascii?Q?m8SUearhR8kaaJZ1a7E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:31:23.5047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd613af-c49e-4b77-9b8c-08de06e45247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

1. Added VF logic to init IP discovery using the offsets from dynamic(v2) critical regions;
2. Added VF logic to init bios image using the offsets from dynamic(v2) critical regions;

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 12 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 47 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  3 ++
 4 files changed, 66 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb34..0dd9ff576cdc 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e9dbab53cb06..9181acef4e9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -954,6 +954,53 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	return r;
 }
 
+int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary)
+{
+	uint32_t ip_discovery_offset =
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID];
+	uint32_t ip_discovery_size =
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] << 10;
+	uint64_t pos = 0;
+
+	dev_info(adev->dev, "use ip discovery information copied from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n", ip_discovery_offset, ip_discovery_size);
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
+	dev_info(adev->dev, "use bios information copied from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n", vbios_offset, vbios_size);
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
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 5f6014b2f349..d122347ff666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -434,6 +434,9 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary);
+int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
+					  resource_size_t *bios_offset, resource_size_t *bios_size);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

