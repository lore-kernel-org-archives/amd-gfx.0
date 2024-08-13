Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAEBC52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 13:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1A410E354;
	Tue, 13 Aug 2024 13:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0+VaKIfs";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A5D10E354
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 13:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnB0A3ycgOs+V9dAZAXAY36I3VhKt+cZ8AvlUZwBtdMUxPj92BiC3E4b1cl8xS3axmpvbhswdBO+uTfoCZpaFyTjKRIwHQllBJrpFJgp/z1EkvBtQnscOoxqoo0dT7RRtMrjvip0devngIUbXwCyqQ8fnOvf4IkIiHmnGhKk17ITCFhMRtfpZQBFSzkaGJ6/pS0bUNN92nua7sU1DmiTl25ahl9aIZFGMrvGOB4pFEwK5WX57Vq6pSH/9AG12qFADzwb3RvnTIn2g+qukjPJ2Z5tDkAe9yBnKOCCPOsZUDe5ThsOcBsAOBSeXdLnYk3plrHa0X82SAnXNHQyrFwOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdv68Z3UQ1EH3nn0Wt9RvygH7SEeIYb0PgDWvJvZA8k=;
 b=Ho70Q8Rd/bOjYTZBzpMAwijtJOTeZGDcBXxMC90kr3u3/55cfqTi1Q7j20kfqSS1JALdTHDSNwLpohK2BhrQ04C7kG2wvW08oo9VbyezzYew8XY+BeIPOT2JvBYMLcZkRN/Xu+veM1F9V7rSSNTail8ap5Zc0Do6jodOPced185lrbDa+IxvXS7cYbl6MejttfAU9ywCdj9umM0kEaVg6JsuIupSOud2ROvr55K2JVnkSuzNXPCSDtJvG70ixzPsnKtHMYX+xewxTZFVSWWMilRBBqOlnbHWguVHIvECsJ9x6zokDPi0gcHhfDjTfPBvAjF7jVZOZEEY7FaF9D542w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdv68Z3UQ1EH3nn0Wt9RvygH7SEeIYb0PgDWvJvZA8k=;
 b=0+VaKIfs3ziAafmkPpDokmY5agSikkqotoC36QVFpJ/QZwZwZKNb3gT5nxDn4UEEbyxn3HPm70XjzBAWqlQMaf+UBTI/x6uJKVwTBpYFPnR4RbfKXKuM1V87DrN/deEm6MgprulXJnzHroOLKS4Q4vcVJmqD1CpJcC+GSKn8/0U=
Received: from BN0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:e8::32)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 13:39:02 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::3b) by BN0PR04CA0057.outlook.office365.com
 (2603:10b6:408:e8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Tue, 13 Aug 2024 13:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Tue, 13 Aug 2024 13:39:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 08:39:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 08:39:01 -0500
Received: from poc-rocm-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 13 Aug 2024 08:39:00 -0500
From: Rahul Jain <Rahul.Jain@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rahul Jain <Rahul.Jain@amd.com>
Subject: [PATCH v1] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
Date: Tue, 13 Aug 2024 19:08:54 +0530
Message-ID: <20240813133854.21144-1-Rahul.Jain@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a86a09-4502-4c5b-f425-08dcbb9d4b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qp0/u83Ih7t3DypXgzuOjVY5P8gpj7AhDorWCMYQeilaNvAmsZ7a7yE+wYyG?=
 =?us-ascii?Q?Abo77jcPDzweT0UM8hdDBeo9efWBOYZwziYcSDlSGIjHpD7nKuL74KLOCfIR?=
 =?us-ascii?Q?Tmdm37Y2klUpy8NnRz/seSFv7YvIJ94CFZ9I7RjCcBkYw6P0syxIPi6F8lT4?=
 =?us-ascii?Q?ZuIwdDtNAELafQd3POzparzVt1dDie0tjyg5BPAvYyEDjWutWNKY/VRm+03U?=
 =?us-ascii?Q?HzP/dmVbsY1/tsVWko2F6mAqeGQTKH8Fkn7nLTmePVdV7fI5BTyy2L4tPUi+?=
 =?us-ascii?Q?dIicDDbInA7L557Ts7zDSQbJo5f1AtiU0VcKWkz9DXauILFsIQ6E3sPpUZoN?=
 =?us-ascii?Q?Tk9dMNSDf+qZXN5AOaVB9Lpxz8EhWmvDfBIcqzyB9VTyDJKzyWBdtYjClX++?=
 =?us-ascii?Q?Gi22PIgerrZxEtwBCMhuDWlaR9FDESrvonT8P9OGAjHjzvxowza+VqSg7NGQ?=
 =?us-ascii?Q?pjZZAuCFlz6qaicYZ7niNX2tsg0LkGoUyxGQD8+jcFbCDdyJtkhZ/EUbJSzq?=
 =?us-ascii?Q?Laim4ro5z6irY6Qq/mcFE1L2TydfavfATGRpp3bRROZVjtcy3i7YJueS5R9N?=
 =?us-ascii?Q?GTblrRayfLu/6B8qkqS4HtpHm8/0Rw2Y4pDg31hC0/xU8CIqfQnPHQ4zXqQB?=
 =?us-ascii?Q?u6ZXR7YmTjm/QPN9a6NLEKMY2yrYzczUoK90i+wZJ7QpdL1kEWMuWpfO6i0z?=
 =?us-ascii?Q?Z0GY/JZuiSnLyMn+eZsCgamlSP8jbJRbZiO70KaNvu9A3+FuWPwbDD5or42+?=
 =?us-ascii?Q?CY3pZG5S/avfG7x1IaFiEMM2Ti6bTDg/lxvbnFFQqzUXPg5+M0BcenXs5ohD?=
 =?us-ascii?Q?sHcyYYhrxZHDaZftFEEXmQgFKY1pEoeBNiD94AMVZTVKsPpF1n8aQS0O+e1w?=
 =?us-ascii?Q?RJ2X0frj9sQ2JN8Y9aUuqz0ugpJD9cQNJz5l/vmKxduxrkVPVeUf5SxLUYwn?=
 =?us-ascii?Q?31reebRxIAHMdElVuyVGFk8hDx405mJuuINdP+kzmW9ADzDodqN3HFVcINmW?=
 =?us-ascii?Q?7tzmCgHKgtwUYfgJzS37f5DtT6n+LHB1YFJ3MwSkQPOGeCoIUD5ZxYgZg1SH?=
 =?us-ascii?Q?YtOJEtEflHgkM///7E4a9YVhY59/cLVUiZioCt+jvLwGoFMN+1eaHhYjeEMd?=
 =?us-ascii?Q?tBDYYx8NxegaimP8kKnb94Ywrc+tX5RPxQr7BhOd2Y9EwGdceya7MWfBgIM/?=
 =?us-ascii?Q?cBsLofmaxQBsIOpu0BDviQqitM0emOsP+9AOU5SdLvqI4NcUhGd5Tt7SRaDZ?=
 =?us-ascii?Q?T9N2HM26O78jSCdushDUqkPfF0pv6sVQzSCF98O5YHMKwJzYMf/4kFR9Kx+u?=
 =?us-ascii?Q?NiQmGalnnJBUOGT89BsnqOq9+kV8Q436NBNddQt7hbb2Rx+8XQ+6KQQ+mwj7?=
 =?us-ascii?Q?KzSsQJcsmqTuL2QJNrxyJXhQ5og4Qc9uwzGBWlcFwN50+bSWlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 13:39:02.3132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a86a09-4502-4c5b-f425-08dcbb9d4b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
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

Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

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
index a6b8d0ba4758..927b076aa952 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3950,6 +3950,9 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
 	domain = iommu_get_domain_for_dev(adev->dev);
 	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
 		adev->ram_is_direct_mapped = true;
+
+	if (!domain || domain->type != IOMMU_DOMAIN_IDENTITY)
+		adev->iommu_remap = true;
 }
 
 static const struct attribute *amdgpu_dev_attributes[] = {
@@ -6127,6 +6130,19 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev)
 {
 #ifdef CONFIG_HSA_AMD_P2P
+	/**
+	 * There are chances when we are in amdgpu_device_init
+	 * and either of adev have not called amdgpu_device_check_iommu_direct_map,
+	 * Hence check if iommu_remap is available or not.
+	 */
+	if (!adev->iommu_remap)
+		amdgpu_device_check_iommu_direct_map(adev);
+	if (!peer_adev->iommu_remap)
+		amdgpu_device_check_iommu_direct_map(peer_adev);
+
+	bool remap = adev->iommu_remap;
+	bool peer_remap = peer_adev->iommu_remap;
+
 	uint64_t address_mask = peer_adev->dev->dma_mask ?
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =
@@ -6135,13 +6151,15 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		!adev->gmc.xgmi.connected_to_cpu &&
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 
-	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
-		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
-		!(adev->gmc.aper_base & address_mask ||
-		  aper_limit & address_mask));
-#else
-	return false;
+	if (remap && peer_remap)
+		return pcie_p2p && p2p_access;
+	else
+		return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
+			adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
+			!(adev->gmc.aper_base & address_mask ||
+			aper_limit & address_mask));
 #endif
+	return false;
 }
 
 int amdgpu_device_baco_enter(struct drm_device *dev)
-- 
2.34.1

