Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BE7C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650E510E920;
	Tue, 28 Mar 2023 15:15:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAF410E91B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZFZOGQ80FsK9k4tXeejqwk3h6LYnB4dqONAphW1YsZGbcgUa+TPzfXfeGKVFVdWxwcVyqew3hKZxR+/bTKUaf7m/uH6WRPLPhP+8ooYIuFvHOt7SzoKwdbGQbe6VHHwtzCdYZIGX/4gfKmVGx2dbDfxF6jye9CyXLPNpnjoXPjgTz+nYNhmu+miPhhIm7SmgEi6uOkavh8sOCryPBEyxCwLYPhLecL19ccN9K+Np8Ga3aa51eJwL1Fd95mgbnEm/EUL/+6ozWajtNyCxQtElTnc4f/MM8GhxnnCIK8XBFFOUMKLXSsQhUs+XfScu0r2z6H5SxI8EwWZnFESmAYJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/slm5R2FZOHhfXwtMIFMUgeovCa5UOvyeG8Klv1k6Y=;
 b=BwzremH+sFMoArWfnuWR8Ev7nptnwRnMxhg8U9BHME9E33OXEmGF+7/HmxprkIteFwPWzjwyTFEhsF/TZY+TX5Cdr2do9Urt+zWT0F5+CJNSy7vKdVbRyrSCTJmY2OHUG3gvMH7EmrJP1S5d+0BuKy9BfsaOT3fM1LoS+gfs8FcgdSQHp4ZtB3n1LZi5DOt2V9NlD4f6M46QYcuF8xwiqkE77slALr7M1Z00agAYCEvgh9p0Zht03mADIwTwIKLZVFxnBj6tPU0XR6XQzFozci4AO5iESTAzEDdvrZsPEDkqVMSWznQ+11Ty1sw6n3ISztwN00U5r0wxtM9JdMmcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/slm5R2FZOHhfXwtMIFMUgeovCa5UOvyeG8Klv1k6Y=;
 b=qZ/wUAnyYV/XThgthO5Um3Jd77TAidMvtJmJtV9fHbpZeJrzm36LmtGrFJZxQBUaIaoHR/q/7RQyGFwJ54cIJXDwbY9YUGOFkR1CpcsidO5hT9ID3UYulE8RbT33ilk0uSf/w3mEK151nZPtKymhKzkBoYlslPj90u1l8uUR9I0=
Received: from BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::35)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:54 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::91) by BLAP220CA0030.outlook.office365.com
 (2603:10b6:208:32c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/32] drm/amdkfd: add gpu compute cores io links for gfx9.4.3
Date: Tue, 28 Mar 2023 11:13:44 -0400
Message-ID: <20230328151344.1934291-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 71baed4b-19e3-4e44-4e13-08db2f9f2fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/96nI+OxacuZ8HY+G0DaDbr+tW3aY8GaOu4uNGrrdyI9NeNWvJ6g9UEPHWGwiJs5E5vdcb2spTIL0ADodhJkHprEPyz/eczMofWngNvEYVLM7ZqDo6opuYocgnKGN96SgMN2l2n7Zio/K72OvXazLhT1lwOLexv/LnbKdpyX7RIFpFSOQB3HGabifCMWF+44/QaxEAGt6GGwKrZ3ofRDBOSALn4A7bdUkncOGXH0PHdi+YdtDty2Uc0+oI1LJPTGdkBY6e964urW+4mGzywQAc3AK76JCXEh0DrVdrtuWDyUTCI4OhSZxboXlXIpFZt341rRb2CB4vO3mgLL/tiWuyHHLtkfieBS7/b1+9mzbgg2+cRhWP4RUGluDbmCd07isyqQT+hnVFv3IjKUybxJCG0D4pXSFMf6GNI/OURCxHAIJR09wtkyhFCh/azozkCoagdjFoHpOQFirjxx2AX2k2e79HlxUzFdXyQ8sRE6Cj4BBLGnhmAz11lmTNURYOmJE6Hy6q8SkPT73Vd72oW0USHSoTgSIyE0O6YO4bQ5NIneWEqH/HhO1/uuQU2UQKbGXdjut14B9L6H/Q4G/pL0cS/jyFOzP/xULOVH21aQjvNK1gcXCxzXWHGpj+SXIukiV0LxkkWeYZ6/iLAuiUTV0xio2HOBMv7RmhIywsQYOwHcsqD8gjr8LRYW7mRNxci9UY10tccVKskLwGKhJmzAM25I14IPsprL2ny60o+roA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(7696005)(40480700001)(4326008)(6916009)(41300700001)(36860700001)(40460700003)(70586007)(70206006)(316002)(478600001)(8676002)(54906003)(2906002)(83380400001)(16526019)(5660300002)(2616005)(82310400005)(186003)(336012)(426003)(86362001)(47076005)(36756003)(82740400003)(6666004)(1076003)(26005)(81166007)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:54.8125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71baed4b-19e3-4e44-4e13-08db2f9f2fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

The PSP TA will only provide xGMI topology info for links between GPU
sockets so links between partitions from different sockets will be
hardcoded as 3 xGMI hops with 1 hops weighted as xGMI and 2 hops
weighted with a new intra-socket weight to indicate the longest
possible distance.

If the link between a partition and the CPU is non-PCIe, then assume
the CPU (CCDs) is located within the same socket as the partition
and represent the link as an intra-socket weighted single hop XGMI link
with memory bandwidth.

Links between partitions within a single socket will be abstracted as
single hop xGMI links weighted with the new intra-socket weight and
will have memory bandwidth.

Finally, use the unused function bits in the location ID to represent the
coordinates of the compute partition within its socket.

A follow on patch will resolve the requirement for GPU socket xGMI
link representation sometime later.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 49 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  8 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  4 ++
 4 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index f5aebba31e88..dc93a67257e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1166,7 +1166,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			if (props->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS)
 				props->weight = 20;
 			else if (props->iolink_type == CRAT_IOLINK_TYPE_XGMI)
-				props->weight = 15 * iolink->num_hops_xgmi;
+				props->weight = iolink->weight_xgmi;
 			else
 				props->weight = node_distance(id_from, id_to);
 
@@ -1972,6 +1972,9 @@ static void kfd_find_numa_node_in_srat(struct kfd_node *kdev)
 }
 #endif
 
+#define KFD_CRAT_INTRA_SOCKET_WEIGHT	13
+#define KFD_CRAT_XGMI_WEIGHT		15
+
 /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
  * to its NUMA node
  *	@avail_size: Available size in the memory
@@ -2003,6 +2006,12 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	 * TODO: Fill-in other fields of iolink subtype
 	 */
 	if (kdev->adev->gmc.xgmi.connected_to_cpu) {
+		bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
+		int mem_bw = 819200, weight = ext_cpu ? KFD_CRAT_XGMI_WEIGHT :
+							KFD_CRAT_INTRA_SOCKET_WEIGHT;
+		uint32_t bandwidth = ext_cpu ? amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
+							kdev->adev, NULL, true) : mem_bw;
+
 		/*
 		 * with host gpu xgmi link, host can access gpu memory whether
 		 * or not pcie bar type is large, so always create bidirectional
@@ -2010,14 +2019,9 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		 */
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
-		sub_type_hdr->num_hops_xgmi = 1;
-		if (KFD_GC_VERSION(kdev) == IP_VERSION(9, 4, 2)) {
-			sub_type_hdr->minimum_bandwidth_mbs =
-					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
-							kdev->adev, NULL, true);
-			sub_type_hdr->maximum_bandwidth_mbs =
-					sub_type_hdr->minimum_bandwidth_mbs;
-		}
+		sub_type_hdr->weight_xgmi = weight;
+		sub_type_hdr->minimum_bandwidth_mbs = bandwidth;
+		sub_type_hdr->maximum_bandwidth_mbs = bandwidth;
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
 		sub_type_hdr->minimum_bandwidth_mbs =
@@ -2050,6 +2054,8 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 			uint32_t proximity_domain_from,
 			uint32_t proximity_domain_to)
 {
+	bool use_ta_info = kdev->kfd->num_nodes == 1;
+
 	*avail_size -= sizeof(struct crat_subtype_iolink);
 	if (*avail_size < 0)
 		return -ENOMEM;
@@ -2064,12 +2070,25 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 	sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
 	sub_type_hdr->proximity_domain_from = proximity_domain_from;
 	sub_type_hdr->proximity_domain_to = proximity_domain_to;
-	sub_type_hdr->num_hops_xgmi =
-		amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
-	sub_type_hdr->maximum_bandwidth_mbs =
-		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, peer_kdev->adev, false);
-	sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
-		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
+
+	if (use_ta_info) {
+		sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
+			amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
+		sub_type_hdr->maximum_bandwidth_mbs =
+			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
+							peer_kdev->adev, false);
+		sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
+			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
+	} else {
+		bool is_single_hop = kdev->kfd == peer_kdev->kfd;
+		int weight = is_single_hop ? KFD_CRAT_INTRA_SOCKET_WEIGHT :
+			(2 * KFD_CRAT_INTRA_SOCKET_WEIGHT) + KFD_CRAT_XGMI_WEIGHT;
+		int mem_bw = 819200;
+
+		sub_type_hdr->weight_xgmi = weight;
+		sub_type_hdr->maximum_bandwidth_mbs = is_single_hop ? mem_bw : 0;
+		sub_type_hdr->minimum_bandwidth_mbs = is_single_hop ? mem_bw : 0;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 3d0e533b93b9..fc719389b5d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -275,7 +275,7 @@ struct crat_subtype_iolink {
 	uint32_t	maximum_bandwidth_mbs;
 	uint32_t	recommended_transfer_size;
 	uint8_t		reserved2[CRAT_IOLINK_RESERVED_LENGTH - 1];
-	uint8_t		num_hops_xgmi;
+	uint8_t		weight_xgmi;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 1b5a4928eb74..9ed32c1b2f5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -694,6 +694,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	if (amdgpu_use_xgmi_p2p)
 		kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
 
+	/*
+	 * For GFX9.4.3, the KFD abstracts all partitions within a socket as
+	 * xGMI connected in the topology so assign a unique hive id per
+	 * device based on the pci device location if device is in PCIe mode.
+	 */
+	if (!kfd->hive_id && (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3)) && kfd->num_nodes > 1)
+		kfd->hive_id = pci_dev_id(kfd->adev->pdev);
+
 	kfd->noretry = kfd->adev->gmc.noretry;
 
 	/* If CRAT is broken, won't set iommu enabled */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6d958bf0fe90..d3e70341dfad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1926,7 +1926,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	dev->node_props.capability |=
 		((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
 			HSA_CAP_ASIC_REVISION_MASK);
+
 	dev->node_props.location_id = pci_dev_id(gpu->adev->pdev);
+	if (KFD_GC_VERSION(dev->gpu->kfd) == IP_VERSION(9, 4, 3))
+		dev->node_props.location_id |= dev->gpu->node_id;
+
 	dev->node_props.domain = pci_domain_nr(gpu->adev->pdev->bus);
 	dev->node_props.max_engine_clk_fcompute =
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->adev);
-- 
2.39.2

