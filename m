Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610C2C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 07:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E823110E5AE;
	Fri, 16 Aug 2024 07:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQWEkSjH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7FB10E5AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 07:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKz5kWz5LZwzn62j1MN5oioI6wc+/KD8GnjYLrlzc3u0A+DShV36HbnPusOge9N1ps9mK1ftDUn/1tBJFRIlBgOmVYiB6UAFPMcwUfTNfoiLW4zL/hHp2ErodnDajgq7lXWmPd/ovD83NlVs6cKnzRjdkd4Tv8jkjVgdb7GKRUcvp5SQMmDM2ggq3+lUeCDctxKU7EJSm4QgYlT9z5C3E/bXNWAZCHU+P6tF9Ilipda3Q4XFcJi8nEEZ5yPA7mP75+A/peQxQI8FYMFBwKWcU59rpVcJeyQB5bZXT5NW3aP264xJQc3ysGxCRrKTL80Xpa0Y6YBHcBRo4LeCOB+LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AShl6tcvoc4GQhZVKMTu610Oxbhu3kXLqJEQFAUAiGg=;
 b=mYD54SZUHcO4hajhq6QVGt0CSLhOsrGSygfZ+w4YjojKvVkaJcSjj4BRKCFaTv1RPBWxYM511+15aXob1b+v0z+7HLQ+X1UhsEpKBo6EypeANozCb3rwXj4ShxzhHeBa/5tKxGlXz84T0WkKIXdVY9iDPwzlcKq0+8gsfAwrUNlUZL2TiMS8sfaVpYpDg0U/GTC3hW3EDJ181VgZlIagu2gdoUyChE6qGueOAXbzonVK/OihhYed/0jkxEi2rPvvyVK0KM3uE15H8YDRusyhHFmbja6fH0uF1V9LSu3CTVtoHo4qb2l1VlhHF8NwUzazyvpw499LAtkwVzSnd7xFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AShl6tcvoc4GQhZVKMTu610Oxbhu3kXLqJEQFAUAiGg=;
 b=uQWEkSjHfpVx67Az2o8Jj7lgK3j4WxE5vCazr6S2ur3tCDhc6R/HQVho1S5SQ4+gMv4G0QKbPcWzS8QsPkZ4OltXTk1XDwVQMaIbBcOFPNBdz/jGRSnGMda/8j0wruH9tUTE5ZCAjH5SrpHAEPA/bE/6PyDOiUvJh5yoRQ1wjbU=
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 07:30:00 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::f4) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 07:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Fri, 16 Aug 2024 07:30:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 02:29:59 -0500
Received: from poc-rocm-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 16 Aug 2024 02:29:57 -0500
From: Rahul Jain <Rahul.Jain@amd.com>
To: <felix.kuehling@amd.com>, <ramesh.errabolu@amd.com>,
 <alexdeucher@gmail.com>
CC: <amd-gfx@lists.freedesktop.org>, Rahul Jain <Rahul.Jain@amd.com>
Subject: [PATCH v5] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
Date: Fri, 16 Aug 2024 12:59:51 +0530
Message-ID: <20240816072951.87089-1-Rahul.Jain@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Rahul.Jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdce6ed-ac80-471f-b4c6-08dcbdc53cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S6phazWLv+HFYBenuI0C3fED08BzC3WRtHEJq7H2b7CchQ7XrDdIJyOl+w3h?=
 =?us-ascii?Q?QMIr4wYL5519WB65UJwLfk4JbtF2W4ZVv/ji32w2GZ6BvAbVx5PxCeVTcFyG?=
 =?us-ascii?Q?kuEOnJiM6MLJRwvO1jVBHC5pTv4Te8M/VL75iR9urQRN+3PycHSqaYupjxA/?=
 =?us-ascii?Q?XSQISicYYJmVXjJ7p0/itpKf3TCGvz2KHXwS/Vj8CRTTjXO13tHe/KlvzdjJ?=
 =?us-ascii?Q?noP1LFURQ7oWpPNKvyShsbjGeCsEWfoCBckifduZKredS+URUIZJujYNw+ML?=
 =?us-ascii?Q?xNwXH1Gi9I2xu3yiAHaEW6/WHSEhGhRryORCSPbSRXyFJsafga5SCtAFQcUH?=
 =?us-ascii?Q?qsrOpFic2bK9/wQVIkhEw8QW43o7QSfzd95NZDj6ScYpWv1DMpvpnGRBYB2P?=
 =?us-ascii?Q?ftoNIKi8k3A51BCz+xIqzRzlc5Cq/dRrtjky4RoJF7NBrloOwweylwPRbdRV?=
 =?us-ascii?Q?7F9R05pTXUIgmsDEptaWm9ZsIjv92pihPaklm1It36LOUvS57jTpmGmf75Iz?=
 =?us-ascii?Q?abJjCAL6H+CACwRObMOKJRPCJg2iIu1+7zSdgnpTW9dpMpJiAIyLTogxdz+5?=
 =?us-ascii?Q?YJL71VWIJYwsg19xcu5ybYfZi5mhgAfVyRfKnOHb8rRdzTLaLTjs/p4Hn0LI?=
 =?us-ascii?Q?H3ul4DwznVfhCRjrNiy8VYeY5rIDbs4nu5XCG8H5HDAf2eG9VX0WAGuCCa2i?=
 =?us-ascii?Q?4Jv6OfjTRm4oJE7pbaPd7aNNY9y6g382/XhitgS5wSm0oWX4MK+ygXQEhYvM?=
 =?us-ascii?Q?/MZA+rgqu6w3FS2xjeS69yPGEfX6Wb7aGURaqvMsBvJSXo41oL5o5vNSgZvO?=
 =?us-ascii?Q?uZOyRSSfsQU800ZVeNIHSzB7npZImWWd0KPZLFS6vRvlnsGAHsvt1+ES2CLC?=
 =?us-ascii?Q?RSGD1mN0jmb4eFaOgkA5SOqZa7jd5Eo9+91MM9nXEWSv1QovT4EowEO5JPPp?=
 =?us-ascii?Q?Z+jq4wLWnhhwqQ5kwx1zW39eJB98wr/Uif9HDVyTpT3gBfc+lJNJkrFglQIi?=
 =?us-ascii?Q?yULGsYeKEihSiwUOa+tXG7qhjc7YOmqbKFBOOlpvVrPtVDb4VFHJqUQDSuZ7?=
 =?us-ascii?Q?dRquWn+XQDVo2io8diB290lBlieNESZdNzkmwQUgwlKTdjKKxwRr0e2s4rCF?=
 =?us-ascii?Q?4SmwcwHSa3+XCiMpiZzwp2C4VL+JhG8Zu4BBNpf2J1fh/i7xAu8Fy9QXLtx7?=
 =?us-ascii?Q?HZzDpxO8lem+iJTxTyjI9Goy8DuEIUDKn2c7flgX7fWxZ5vDgeTv7ybAPqO4?=
 =?us-ascii?Q?fsK2lTGD801L6GeC/bLxYghHHYSnnBIxx2nz1m01+DAbLkVi3WUjjJnUNt7A?=
 =?us-ascii?Q?+sv4wlPXpX667PuTYm7tT4wmK6k369Y9Xs87Q98EwsIecLTTSK5Nrct92EX9?=
 =?us-ascii?Q?1vBPoC8EMBtXgf0ggexu1B0mr4pnYlRO/inKIf+aG/G/tspbtBvVUyMz3bWA?=
 =?us-ascii?Q?xcLJ5l/gXpMr+R6ROo/TYOj6LT3gpdFm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 07:30:00.5131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdce6ed-ac80-471f-b4c6-08dcbdc53cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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

v5: (Felix, Alex)
- fixing comment as per Alex feedback
- refactor code as per Felix

v4: (Alex)
- fix the comment and description

v3:
- remove iommu_remap variable

v2: (Alex)
- Fix as per review comments
- add new function amdgpu_device_check_iommu_remap to check if iommu
  remap

Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++++++++-----
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a6b8d0ba4758..e03b3357ae09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3952,6 +3952,25 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
 		adev->ram_is_direct_mapped = true;
 }
 
+/**
+ * amdgpu_device_check_iommu_remap - Check if DMA remapping is enabled.
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
@@ -6127,21 +6146,26 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev)
 {
 #ifdef CONFIG_HSA_AMD_P2P
-	uint64_t address_mask = peer_adev->dev->dma_mask ?
-		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
-	resource_size_t aper_limit =
-		adev->gmc.aper_base + adev->gmc.aper_size - 1;
 	bool p2p_access =
 		!adev->gmc.xgmi.connected_to_cpu &&
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 
-	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
-		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
-		!(adev->gmc.aper_base & address_mask ||
-		  aper_limit & address_mask));
-#else
-	return false;
+	bool is_large_bar = adev->gmc.visible_vram_size &&
+		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;
+	bool p2p_addressable = amdgpu_device_check_iommu_remap(peer_adev);
+
+	if (!p2p_addressable) {
+		uint64_t address_mask = peer_adev->dev->dma_mask ?
+			~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
+		resource_size_t aper_limit =
+			adev->gmc.aper_base + adev->gmc.aper_size - 1;
+
+		p2p_addressable = !(adev->gmc.aper_base & address_mask ||
+				     aper_limit & address_mask);
+	}
+	return is_large_bar && p2p_access && p2p_addressable;
 #endif
+	return false;
 }
 
 int amdgpu_device_baco_enter(struct drm_device *dev)
-- 
2.34.1

