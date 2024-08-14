Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E18C52D7F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 06:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7E710E40C;
	Wed, 14 Aug 2024 06:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GNPKgA9z";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B5D10E40C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 06:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMHjVD4UPKHGF+sY6lqdUgQMJUypapF8saWijDMt7DTiJjhPO2a3Q5P7OETpw9yOvMkAMjuqSUsq154jzmRvZyPWYnbFf26Fsa6d8vpiqoSvBwd52s645GpfbYbAQempHRSe0vYw6FEjcV9aQIdalyu0FLn7E2uvJ7/Y8UuLVxPWzf8ma5YhzTH8NAs9uR0FJ5PcexoBgHrIP3+0K20FYawP7KMjgyiPzrgJE7BHUePT9S+7fRz+e7IcQhBFjdPp7KcaCtyFtpEuRFUf7vwEksE3xhiE9DvxnbRuLj86CJA+5wHDOIBtv2bVxZgO9LzF5sfX/P51aXQCfW1bPSN6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGIhx0Bhdlb6CzuMSIXVudD9mEQCPW6ExIuYfxqMGt4=;
 b=Cgz7fCDnLPJ6GJChiZP7G8lPzMo3MLDXluTTI4Z9dLjsVwmbj+3NZh3VBVjj/tx3S9sopw/P/p78RKat1jmDw7mfMhY+duEupSN8W00CLvgLyTLpjkMEvIP50s2U1M67tybMrZ9EFz9RZ7D82SBKnACPTlBizp2hMxsK083NJBYXZ9XRqOTBcAoz8b5rQXPr547j18fEyETQIBnoa9SMuDPbP+vg70nsFnnQCwEj1CUa5ZglHoSLtEQKDJGy+hMBayhPw9j+1oGLl8MEC5xpEggG2zZuT/gROlpU2omUvZaPTB+3WL4gqdGijsfY/sXt5APiot7011x3URBeS2NdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGIhx0Bhdlb6CzuMSIXVudD9mEQCPW6ExIuYfxqMGt4=;
 b=GNPKgA9zjqDBsLVzUsSOMhnLCv/p2KmMOD+LBLh3XRSiW9s043dOx6mguXZ7y8Onsf+LMpquOqNbL/n3mahIcran+FVRqs6QMBDatCWcItszU5GchrBCgovJH6vG6MeiKkwKedNLMrKbWwtjBXss1T8wQriGW5xQAdEib8yU4EU=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Wed, 14 Aug
 2024 06:48:52 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b4) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 06:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 14 Aug 2024 06:48:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 01:48:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 01:47:21 -0500
Received: from poc-rocm-server.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 14 Aug 2024 01:47:20 -0500
From: Rahul Jain <Rahul.Jain@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rahul Jain <Rahul.Jain@amd.com>
Subject: [PATCH v2] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
Date: Wed, 14 Aug 2024 12:17:14 +0530
Message-ID: <20240814064714.30455-1-Rahul.Jain@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Rahul.Jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: c66e704c-4358-4169-eaa6-08dcbc2d28a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yTzRwKTq+0ujT97AeJRlxg9+CiuaknO1IGR5D10RKIHye10Q3P/ZsURQi0+k?=
 =?us-ascii?Q?6++DjwGXM504jQiRZ18NVj0RA+sEF7wvAx9+Db/Pe6ZSnbjt6JC/LyQjeeT1?=
 =?us-ascii?Q?w7FvEvlUgDdmXMIRapCvqX9ottGbmYIAP8XSJXzlG0cSezBPgRhKnaQzokHg?=
 =?us-ascii?Q?XU3FwbD4sTsxn45l4FOmOftxiYzQskkuNEQz5M0yd9AldfjSOyaLQjJFvFxv?=
 =?us-ascii?Q?UALgInBkj7HgYQKZol44IE2Y07gqMrcz4VScCJpaNAhSeSEx9fl3rY482XJd?=
 =?us-ascii?Q?8Rn51FdL3DBPMMQ8kwQ+egeZgndJZFv0jULt+s4+Ntkd9BvtlKf6RHuDqwwp?=
 =?us-ascii?Q?Ka9HV/bOwMXlMEQs3x0IHJDJ3C7VSDXA5OAQVV2seRxaNMxK1QUr9HVNwF5s?=
 =?us-ascii?Q?heczHp/ixNDnuzwK6aMH5osnDV9j7c+5GBMmE8BoXdWUotbA0lVbuiFoNdxJ?=
 =?us-ascii?Q?MsYVJ6MoF/ya4+/BXUFxre2RhDIZ/XlCcVaOYOmZmepKAQMdU+P3HQ9XIbz5?=
 =?us-ascii?Q?PdDlt7lzppqLKMzflm0T6qUB1B5Afcx32GIWCz1JBWoHy43+mhM8HZKOwwnz?=
 =?us-ascii?Q?6lRxU5n3ghVRPzCfWnRnaK63qLNgQvvVUXe9WE2FtRW69uVSlcfxQpTwgmSX?=
 =?us-ascii?Q?jVwtsXuWOeFRs0OZXPaPXRgqYBr9twv//mvwOmAA0iOBEfccd18Ob+s/JAtu?=
 =?us-ascii?Q?p4e7Dz8hJTeqNRr2mdno4EXzTfiUKCq+aVleZVDBDoydI5nLqwG4j4nk45Ko?=
 =?us-ascii?Q?yuAjmlqb9LP5Jiv/Dd2XXEWCdkFFcyAc87/EvomwPP2dL53BgRiunz4fDFp+?=
 =?us-ascii?Q?TfkmJ2T3Yb8SA4Wt3cpH/iqbgxGQo48rWvxoXNRRgzfwQ0vxhdaTBCJ3DpSw?=
 =?us-ascii?Q?aVnQ7xtKzl3Ozpdb6MUL/zrtLM/tkXMkqUpqm3VChywWiAz22Jp+yIMxVCz6?=
 =?us-ascii?Q?spEGUFsGx8s1wNbaGyE2au9dk9D0sQGLDZP4GwjkTfjA131jphxQR0wgIQ40?=
 =?us-ascii?Q?po0lDZNMAnUQkGpQWV5OcdN+HMT9vgF9R7C4eHVqTGnqPCOgoW031EWJMyJW?=
 =?us-ascii?Q?KlUkhDvnq5QVCIwVhSxs57AcgPA+o762gPlRuOrhazzCVUYq3V+hGsTVTk1Z?=
 =?us-ascii?Q?wWMb4Zc3xUUd2UnkkQ0BDnkxNKrWZr+0XsmJe6hjk7bTQvL0D2IH9sdb4yjJ?=
 =?us-ascii?Q?zvwefKbbblqEGtb5B1Z6bjtcB6S3RVldhnLQuMBANcsPKkY+fGyNRrDZ5w4O?=
 =?us-ascii?Q?VYNA09eyt2I7M2E8TjteD2tIlpozIgbNVaPoq8cRifHAwIW9JkMro7g/p9ut?=
 =?us-ascii?Q?cm9ZJLnO9/6QYqGwpm42UP/Ddc2IxJpQx2hHPyC8DHHAdlaeOWR/I6Mjb2MJ?=
 =?us-ascii?Q?mNtJF3xDFSlTgx7DOCs6sgxIafw2ZN2MP73+ow0VuYw5+4aSiygtO7+9rwm5?=
 =?us-ascii?Q?JiltKKK3Auyry7yZJ/p6nla+ytIZMH0z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 06:48:51.9546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66e704c-4358-4169-eaa6-08dcbc2d28a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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

when trying to enable p2p the amdgpu_device_is_peer_accessible()
checks the condition where address_mask overlaps the aper_base
and hence returns 0, due to which the p2p disables for this platform

IOMMU should remap the BAR addresses so the device can access
them. Hence check if iommu_remap and return true.

v2: (Alex)
- Fix as per review comments
- add new function amdgpu_device_check_iommu_remap to check if iommu
  remap

Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 +++++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f3980b40f2ce..618b44f5df85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1138,6 +1138,8 @@ struct amdgpu_device {
 
 	bool				ram_is_direct_mapped;
 
+	bool                            iommu_remap;
+
 	struct list_head                ras_list;
 
 	struct ip_discovery_top         *ip_top;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a6b8d0ba4758..040c75c491cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3952,6 +3952,25 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
 		adev->ram_is_direct_mapped = true;
 }
 
+/**
+ * amdgpu_device_check_iommu_remap - check if iommu remaped BAR
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * return if IOMMU remapping bar address
+ */
+static bool amdgpu_device_check_iommu_remap(struct amdgpu_device *adev)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(adev->dev);
+	if (domain && (domain->type == IOMMU_DOMAIN_DMA ||
+		domain->type ==	IOMMU_DOMAIN_DMA_FQ))
+		return true;
+
+	return false;
+}
+
 static const struct attribute *amdgpu_dev_attributes[] = {
 	&dev_attr_pcie_replay_count.attr,
 	NULL
@@ -6127,6 +6146,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev)
 {
 #ifdef CONFIG_HSA_AMD_P2P
+	bool peer_remap = amdgpu_device_check_iommu_remap(peer_adev);
+
 	uint64_t address_mask = peer_adev->dev->dma_mask ?
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =
@@ -6135,13 +6156,26 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		!adev->gmc.xgmi.connected_to_cpu &&
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 
-	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
-		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
-		!(adev->gmc.aper_base & address_mask ||
-		  aper_limit & address_mask));
-#else
-	return false;
+	if (peer_remap)
+		/**
+		 * IOMMU is remapping DMA for peer_adev so all accesses
+		 * should be within peer_adev's DMA mask
+		 */
+		return pcie_p2p && p2p_access &&
+			(adev->gmc.visible_vram_size &&
+			 adev->gmc.real_vram_size == adev->gmc.visible_vram_size);
+	else
+		/**
+		 * No IOMMU remapping so make sure the adev's aperture
+		 * fits into peer_adev's dma mask
+		 */
+		return pcie_p2p && p2p_access &&
+			(adev->gmc.visible_vram_size &&
+			adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
+			!(adev->gmc.aper_base & address_mask ||
+			aper_limit & address_mask));
 #endif
+	return false;
 }
 
 int amdgpu_device_baco_enter(struct drm_device *dev)
-- 
2.34.1

