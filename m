Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0138C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 09:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C9110E0C2;
	Wed, 14 Aug 2024 09:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxtptLYR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C633C10E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 09:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW1kduQ7UpY7JG6pgkPxVFKTbSVbVI1/VgGBfAmZxvTqjhNCsoV857L4E7xA5YCRvHrI6zN5zdaR+8lbgWFztrVNRBKt4cqcQ1T7x3+XcZ09moJlr0s/rS6sjw0j8P44vknTwAoA65EQTX2rJ5jGOyUKQkEzrTWB789GpDCfxXsexAauPgdpbiCb1oUf731qFpLBtHhK37alfxS3SrapLYcEgnZs1FH/G1RcLrNLmb1wP8rspwKtABdg/mwm8KlXogWlsdO0mMhR6xWP8b6zOPvYHoSxsFUUvvNJtTGnzZaW/BpKJEGrnnnpT4MRv7qqYCAh2CIBaFPyFPb6NhWqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG4I8EiH9FMsirc+1LhPy27WhZKQExXrCbRLriHgqNg=;
 b=xMTO9mpaB0mDXuqDf+xR+dMCyYP5r21IRez+lvz4/1a4qPaApj5b8Ma6V45aJbYgU3C+I2E/QGmGkAUrZTwU+icB3ojCy/o6+kRUeDWjiPrXWBYiWnFe+WfMdOek9yp6ZbYS/aEdh+d2mTGCXDhsjL4+EukA+qd8199v9Ow/n8j0KLBW5eOHZofqzbkzbIdicIezvY8W+dloXieW+VmxxnJyBkhWi30oY1fBiqNlyzih5tHkSJ1rC2Dn+Xv1iTnG2gBDqTkKl+oU0PesXEa1dDGgdREYD6Ro3gllx9rcYdC56iNcHvmVBedbU1x+RHdo4l9ThXA5XE1huBhhNoN+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG4I8EiH9FMsirc+1LhPy27WhZKQExXrCbRLriHgqNg=;
 b=NxtptLYRumy50u1dQhJnJkRNlHV/lsTkw5R1di5unrF5+oSBSf0nvq9v3qcNZEfcWdkVfX4ppkmczdK+iBUJ4wPegbFfQpEaXvo2Q8L1WfFd/vWkjj5MdDnIx7DaJOKIZfrRImdHDWWEjW7pHi07iw/+JQ8ukhvjBCwOObPQD2Y=
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 09:08:52 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::3f) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 09:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 09:08:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 04:08:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 04:08:50 -0500
Received: from poc-rocm-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 14 Aug 2024 04:08:50 -0500
From: Rahul Jain <Rahul.Jain@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rahul Jain <Rahul.Jain@amd.com>
Subject: [PATCH v3] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
Date: Wed, 14 Aug 2024 14:38:49 +0530
Message-ID: <20240814090849.36891-1-Rahul.Jain@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Rahul.Jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddee0d2-5010-44ba-c6ea-08dcbc40b747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yRcdYNdu0b+NWGTAlfFKBpjcv1gTr5I2rbxSEpvasSdm5dnPmtc3pANS4Bl5?=
 =?us-ascii?Q?ynh6Bo3YDM/GA/SXF8ZwrFRIU9UTb3uV/xp6svJ6KUkS/NV8DYlJ1R7rbE8e?=
 =?us-ascii?Q?hSzpMd0+Idlv0M7XiHpkZ+5V80m/b+Ag+fF+SHRVg7FBtIfqWOTxC1+YN+O2?=
 =?us-ascii?Q?iHN1oa5bIv5MPDtBEJVcT19/9qXfrejcYpYf9N8IZD0MWJ+Y7KR5GbRP/1wh?=
 =?us-ascii?Q?v32eajqlN+H4eWR2Rd2T//ZrPOnPaexrHCIUbchO5PEvzK8eyiSM0i9IQxgO?=
 =?us-ascii?Q?CaqwPY0QZ9wMZIrACeELtDQXRILRIuM9WeNqpIwx98ylK5wzJLdBCarN3W9W?=
 =?us-ascii?Q?h7HanKT2t0BGlbJAtJaauFXaoF0T49LcP7K6Y37vNFisKXDYniddKEGSZXJT?=
 =?us-ascii?Q?dK9qm/YeMqMLx+qI4A2lbXylFvPjDIVDHi44geFPuFAgaEjFtK3Rzew2aBxd?=
 =?us-ascii?Q?HrH64W17p9l5BjMNhr4k6e/RmNSxNDTa1dLwPOlac6nBcBS0rvIaD+MuEVrm?=
 =?us-ascii?Q?pKIHnYZI2kEiSKJjo9eFrYvnfBG8ZajrotI4yJUA14JXEh8joe4M4RRUcUhD?=
 =?us-ascii?Q?cb48XTnMh+Q8chXZ7flkyhyj2jnMVVdACbt7hDe4IJwOD2vL7QUyHUzI4F1I?=
 =?us-ascii?Q?wWgux+MbzxfCNPJFOAoQ0ckgywd1pmLsFBpIkdbndPTXomGpFTNhwkr1VRO5?=
 =?us-ascii?Q?5eWPqtvBKf9O2uEQn+ck5t/kpIT6ovFKQ/rMnwakHUfe7PjS1ArA0uU84ZoG?=
 =?us-ascii?Q?KzyesrSOWXXBBmXfqNixqxFu/zhG4s6X2ojUHmyUuNJPT44v/JPhZlFJUcgT?=
 =?us-ascii?Q?Ojtjo4nkk3xZpSdS8ZaTMGCaXZBgzFHR2wbvDFrcoqYnlzmQgbJz3nuAweRz?=
 =?us-ascii?Q?cdXi4TzOC8HFMGllA1qAtMOrN39P9SDxh9mrDsRRVxhIm25u2DtsmVlzLO1p?=
 =?us-ascii?Q?HAPUhdN6eigV/zZd3KW7mZXb12xkY6yLFZnSyMdvlu4xlb9YZ76zWM4bFkZk?=
 =?us-ascii?Q?bFMYcF9ppzgqvN+qBfb7EwMFJJPhF/5jxvNNr6RNAUeHfH65/P/K53d7AEgh?=
 =?us-ascii?Q?FfvbFQbxolliHwYgB9WaPEDGJKKZ1OtYUhdf7t7+3BHU1dw8G31YBOBMxFCZ?=
 =?us-ascii?Q?FyqFpRBm5Qj4muXeRzkrZdyVY9XGaavqhjGUYJJwlmC2ZkBYhvAIK1XBjEyY?=
 =?us-ascii?Q?zP984LFgX2IT2Aievg/ultujmZY+SXJX80wUpfa7oOTTRvZ+whvUEGCdPoFW?=
 =?us-ascii?Q?+cn46puNfH9EJNne/wdhQQDAKCCPl9BPOZ5cuHT1yycKlvHMYlK16I2GSjvt?=
 =?us-ascii?Q?o1ww7H0WnsKP+ZgEm6N1GBbpyt9XOehPEyVlgKerdrbVoFW1DnKn7h7Yuvqz?=
 =?us-ascii?Q?kG+yzWBBIS+Vn5Bx6i2p0d7mKYzDtjSxXN9cYF2yV1kMY0USba9+jMhXjc4c?=
 =?us-ascii?Q?vtqNsj1g/ll28AURdpCqbUz2VHyezBQ/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 09:08:51.8006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddee0d2-5010-44ba-c6ea-08dcbc40b747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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
them. Hence check if peer_adev is remapping DMA

v3:
- remove iommu_remap variable

v2: (Alex)
- Fix as per review comments
- add new function amdgpu_device_check_iommu_remap to check if iommu
  remap

Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 +++++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

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

