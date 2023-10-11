Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BABCDB475
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 18:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3693610E089;
	Wed, 11 Oct 2023 18:22:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD7B10E089
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 18:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSAspWMt1FIF/THWXLFg3JfwrJw/jxH5Ysn/XAElVUXOIr1qfKkcp/TI+jO+RKfzPF1oqCbJ/g6DvHvQffB/EF3CBPrso8mJxKgBVwdZpxnxXEXR2j7lSccJBTWvn0GHYgVG3VNrLDwghlOdTULHwjdtWId3ju/B3xedqkosArm+P0+YIpsTdoS1EJtx9mxfB/pX/Zm7XfQJQDnZp3nbkAs+yhk1LiDRdWapgEXOFPjZC9/DylO01d8eS5IzzM7Ct0TwrS+B6dCaO6/BOEJ92+CcDRxS2SUQ9dpk7YP5VZdKDVZIlU/keT+Yzp6lmL6yIeNVK8PhCWLMsucu01YAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9veA2WWSCQcp+r39h8Izjse4j/wYZJ8W1aeyOSfm1s=;
 b=i0pH+FZ4D5UINKmldlOjR0tWyrQ5kRLnKRuiTEnlZ6dnAXUwn9Q/+juYH+DoebFbfC5n7PVxnpGaU8kSY/pHHBERSvJNE+ybQ99s/9ft5anuYg1ou1tpFCtrqkqU0P+cg3hv/jJD+cheQSGZBlP5qF0EHK/JYDlnORKOBfKvI+yCX9yckRtusqKqrjug9178zdC7ztcvro29kAbExSekG1tLB6a4ALe0qoBHA1JA/lSo71U6ZIJHVWCKqzEmVCDfgj0n2v9MtHY0lB1gduMpc9i7JlsfvcCt1mL+Eu5WUs5Ujk9HfnclpJU+LWQXmDGaPVIPMcJDYhHSbPlBoPpedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9veA2WWSCQcp+r39h8Izjse4j/wYZJ8W1aeyOSfm1s=;
 b=Skr8t7xEO05xUtV1KhnqbK9vuaiszD8PpQFdNS9GQd0cN+9iaBtxpLzjIyRU3BukTH+o2HPpr/L7atJNoFToRcWgWuE14PGTsssxRJA8V4Cj+2jOsUkfyUsNVgHqEQ8WwdkpoPhuM1NGy/mmhPZktxnkA17f1hnPgYX8exg6MB8=
Received: from BL1PR13CA0294.namprd13.prod.outlook.com (2603:10b6:208:2bc::29)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 18:22:53 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::f9) by BL1PR13CA0294.outlook.office365.com
 (2603:10b6:208:2bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Wed, 11 Oct 2023 18:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 18:22:52 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 13:22:50 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Permit PCIe transfer over links with XGMI
Date: Wed, 11 Oct 2023 14:22:35 -0400
Message-ID: <20231011182235.569096-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011182235.569096-1-David.Francis@amd.com>
References: <20231011182235.569096-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcbdebe-7713-4f36-4bb2-08dbca87153f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNNdnYhTV+Qq/BzQdWxGyn7mPJs2xGbHRsxgJqI2itGV56hILpq+zGG3VZGTOQF3JYBakg6TutLad/IY77l4FM2ijllxv7BWBD6oFN5gI/ppCIBZe/JkwSKObODZQd85YcV3YjTSWdCVxg9LxcaPHMIcEmwNNUCvVrku24+O6GYX0BZs5jb7Y/xM7a8zM8n2VfaIAiOdaOq9V23jFkJMFEfjBg5RDRBg65GZcravLcyIfU9I4MbOdQRSs7AdIcTwABhaCgA/rOhK8vWrv2x7YeUqe6qr8fUFrwvhmMWQ8vY5s/p+gNT4uJ38k2Ox+yUwTUzlO1p6cvTVgbUVSynlYAGXNXByw4j9Q9og5Py6sF3s+WN6Piq3Z1Xw2E48frjhsQa2g0YBbHI9tdqqwz2gEPUuCYADqtF2LiIDgkj4wqg/V5P6KLHHGhQVAuhjRw/ijiAi2cgYEhYsR8UlHhDAtLPjAR6aSyu05Z0blCVI9aFei0VXADqwkoTGuwn32oqhLtyTLVk8MlKXyJ8ol/KWP3ayeNkIed+oNongWxOxtboTR/Ly4DHlRUaiP2WzbkkkzBGiliPFjeooo9qGyxQhed39UrWzzP3ubeUuGQu+PGiZMjQGNdWt9xJDEZdcqYOcCN9bgx9chxzTI8tcIcsShRaGIPQtDrvQsjCEGtGmACBMU7C1s2Hv3/0CV8+XfuBVH96WSkTlSWxMioKVkDvTQqv7K9AZ4IBw3mvbypt9WCigU12XU7TZujE8ljh6sgboWYbvK7iicsIUiysg0lX8eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(47076005)(7696005)(6666004)(26005)(36756003)(36860700001)(478600001)(336012)(426003)(16526019)(1076003)(2616005)(83380400001)(316002)(6916009)(70586007)(70206006)(40480700001)(356005)(41300700001)(81166007)(8676002)(8936002)(4326008)(40460700003)(5660300002)(82740400003)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:22:52.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcbdebe-7713-4f36-4bb2-08dbca87153f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU is XGMI connected, the PCIe links should
not be enumerated for topology purposes. However, PCIe
transfer should still be a valid option for memory attachment
that requires it.

Move the XGMI connection check out of the shared helper
function amdgpu_device_is_peer_accessible and into the
topology path.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bad2b5577e96..b47cb7f8cfbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5753,9 +5753,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =
 		adev->gmc.aper_base + adev->gmc.aper_size - 1;
-	bool p2p_access =
-		!adev->gmc.xgmi.connected_to_cpu &&
-		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
+	bool p2p_access = !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4e530791507e..f0cff5072736 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1423,6 +1423,9 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 				peer->gpu->adev))
 		return ret;
 
+	if (kdev->gpu->adev->gmc.xgmi.connected_to_cpu)
+		return ret;
+
 	iolink1 = list_first_entry(&kdev->io_link_props,
 							struct kfd_iolink_properties, list);
 	if (!iolink1)
-- 
2.34.1

