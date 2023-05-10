Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144AEC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FE110E54C;
	Wed, 10 May 2023 21:24:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C7910E53E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8hS8sv/6494kQLlCeSMmSqdsf0Xr4qgCdxZXevwPgMTYopXiKeuHdR+u28zpjYooCIM9ZgzMruwTeiA7q03kf9ofsecNinwvdCZnzfwNu7xa6HnuImzr7IkMrOxmU46fpzU60/c9gVY7sUJ4vR9Bjq3yLE5agl+i+buw7csdOi0oNOMqfK4NMmWHjzs1d80CBBPCdxw3ruTM8W0DpJbC4Iq/yVw4m5iYGjI2AVDnvB45vMY/w+lEuPfg0FKVuhmAb2cZDrA6YgUq9gf8zudepT4oRXc3fRfp/3fHYK7Crz8ZnroUysX4qvXXPBmRvjWBvSxxQA6ZT1TP8s8HNvthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMvY6+kkbOOaoSSSfFB5iyCqaoT1q2rtiAjxZAcEVxg=;
 b=huWfjLqXJqUE1FhYbwleF329u7AzjhQuVqJNYxcqdBp4m3ERBDZ64Nty7dieMmpeJ2V3gtj8RYNMKBST8cX3i5M6QcNMHjDd5vRLFz8PBKDpAh+UdpimiYeyfxnHnpHe5h+kfDMWqVdTaEpnhVLOrff9lGQCTpeIUFxqDocXLaWHUolI1VKNxHSI1XbU/iKQ9/ihtkEyKVNNqiCPMmIAnJqb+JU9snf5jGftte4+IehLLPARlSCKZ6Ntq/XSHj9hBJzWK7oTrEtUczIJrTkCWfMxKWIGXdBwswWP5FULIUHsVuRY3+lLff3a/vqMLCnoxT6yyZ6g56xMtmhYN5VPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMvY6+kkbOOaoSSSfFB5iyCqaoT1q2rtiAjxZAcEVxg=;
 b=xOonr4M8uBomZNWvn7u9PGPjz3RgBu7xnrOq++vYIA0VgrHAZqnGql9aVzjG/P/uQ9LZl5H13y7yHzKs8J/1N9IcDMQxmTPfRXivJcC7pNu7C7SEvqLCUaPGfrt41hHTW8EeX0N4m1Hvo2/baVCUnQMTeD3s8Jc+l5DwOH1Fw+0=
Received: from MW4PR03CA0313.namprd03.prod.outlook.com (2603:10b6:303:dd::18)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:24:03 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::f) by MW4PR03CA0313.outlook.office365.com
 (2603:10b6:303:dd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 21:24:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:24:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/29] drm/amdkfd: Move local_mem_info to kfd_node
Date: Wed, 10 May 2023 17:23:28 -0400
Message-ID: <20230510212333.2071373-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c39abd-507a-4f7b-28f9-08db519ce0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABdFE9MFNgSo1AauP0BZeSlzLbxe28KoHvKi1gsQftsLyT8r+vUf4WSTIedsWxCQ12k2F8CtxSuBILZokAgz5d21h9Rs8HPKc/uu7I6v9+ChoSyKHS8vCaIZohH17R84VNTlldIKC1VKPkfUBrFE4VRc4iZ3oVenPfp+Kb0xGv+rIb+yKlG17sanjr74SDeWfMAnIUFovH/DgKUNN0g7LjyvoofgXbf0hAp3vXbm5brYJzfKd7M1w+4IGjOWnmvkRg+phj/KKzzLgnEjatsdZLtx7PsoaPDrUYNttzGtK9Fly3nzPzcdfr79JhxEnfF2b1JNqm0NjhDav7iGe+ryLropfmotW8nSGKp/SJRSbkMgbn508urWO8U0f9YzduZI5Z00/i8XPWR3egPVVo2Dm/vWMRwoqUjFEMcxKwwAePza9Mphiv2xiYZpsEq3eMKQmgJ2ZgMgg1g1ylkqhYPnoE8vd/pDrVoSgVDf4Wj/gTEjA+ZaDLv5y2I2y8FfpvEZJpQMLpV2Lsjt0QcZHtXOGlowYfwij0G7q44AuatB0FF02kAk+Z1c7PMGqS1FRl7tHTY9XWKzz05PyaKc1daLfos05l0VbpegLGLWzg45eXfBWz0USfW3BYLs+Q8tyxKCZ73amr92Dn1jE/ZG47sAXBEHrQyyckd8DvOoQVrqsdSp1mPTx0lzmG3K1wkMRBU29tVwhR7rB+ugCKQuk0dx3MT54TEwdiYogSC5eas6ywY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(26005)(40480700001)(7696005)(336012)(36860700001)(426003)(2616005)(81166007)(86362001)(356005)(36756003)(82310400005)(186003)(82740400003)(40460700003)(47076005)(83380400001)(54906003)(5660300002)(16526019)(8676002)(6916009)(70206006)(2906002)(478600001)(8936002)(4326008)(6666004)(41300700001)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:03.1841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c39abd-507a-4f7b-28f9-08db519ce0ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

We need to track memory usage on a per partition basis. To do
that, store the local memory information in KFD node instead
of kfd device.

v2: squash in fix ("amdkfd: Use mem_id to access mem_partition info")

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 12 +++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  |  7 ++++---
 7 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 00edb13d2124..85df73f2c85e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -428,14 +428,23 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 }
 
 void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
-				      struct kfd_local_mem_info *mem_info)
+				      struct kfd_local_mem_info *mem_info,
+				      uint8_t xcp_id)
 {
 	memset(mem_info, 0, sizeof(*mem_info));
 
-	mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
-	mem_info->local_mem_size_private = adev->gmc.real_vram_size -
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+		if (adev->gmc.real_vram_size == adev->gmc.visible_vram_size)
+			mem_info->local_mem_size_public =
+					KFD_XCP_MEMORY_SIZE(adev, xcp_id);
+		else
+			mem_info->local_mem_size_private =
+					KFD_XCP_MEMORY_SIZE(adev, xcp_id);
+	} else {
+		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
+		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
 						adev->gmc.visible_vram_size;
-
+	}
 	mem_info->vram_width = adev->gmc.vram_width;
 
 	pr_debug("Address base: %pap public 0x%llx private 0x%llx\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4e6221bccffe..4bf6f5659568 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -231,7 +231,8 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
 uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 				      enum kgd_engine_type type);
 void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
-				      struct kfd_local_mem_info *mem_info);
+				      struct kfd_local_mem_info *mem_info,
+				      uint8_t xcp_id);
 uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
 
 uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
@@ -334,10 +335,11 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		((adev)->xcp_mgr && (xcp_id) >= 0 ?\
 		(adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)
 
-#define KFD_XCP_MEMORY_SIZE(n) ((n)->adev->gmc.num_mem_partitions ?\
-		(n)->adev->gmc.mem_partitions[(n)->xcp->mem_id].size /\
-		(n)->adev->xcp_mgr->num_xcp_per_mem_partition :\
-		(n)->adev->gmc.real_vram_size)
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\
+		((adev)->gmc.num_mem_partitions && (xcp_id) >= 0 ?\
+		(adev)->gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))].size /\
+		(adev)->xcp_mgr->num_xcp_per_mem_partition :\
+		(adev)->gmc.real_vram_size)
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 344b238d6771..089e1d498670 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1023,11 +1023,12 @@ bool kfd_dev_is_large_bar(struct kfd_node *dev)
 	if (dev->kfd->use_iommu_v2)
 		return false;
 
-	if (dev->kfd->local_mem_info.local_mem_size_private == 0 &&
-	    dev->kfd->local_mem_info.local_mem_size_public > 0)
+	if (dev->local_mem_info.local_mem_size_private == 0 &&
+	    dev->local_mem_info.local_mem_size_public > 0)
 		return true;
 
-	if (dev->kfd->local_mem_info.local_mem_size_public == 0 && dev->kfd->adev->gmc.is_app_apu) {
+	if (dev->local_mem_info.local_mem_size_public == 0 &&
+	    dev->kfd->adev->gmc.is_app_apu) {
 		pr_debug("APP APU, Consider like a large bar system\n");
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 1aaf933f9f48..950af6820153 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2191,7 +2191,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	 * report the total FB size (public+private) as a single
 	 * private heap.
 	 */
-	local_mem_info = kdev->kfd->local_mem_info;
+	local_mem_info = kdev->local_mem_info;
 	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
 			sub_type_hdr->length);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index db5b53fcdf11..d41da964d2f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -726,7 +726,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init(kfd->adev);
 
-	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
 
 	dev_info(kfd_device, "Total number of KFD nodes to be created: %d\n",
 				kfd->num_nodes);
@@ -756,7 +755,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		if (node->xcp) {
 			dev_info(kfd_device, "KFD node %d partition %d size %lldM\n",
 				node->node_id, node->xcp->mem_id,
-				KFD_XCP_MEMORY_SIZE(node) >> 20);
+				KFD_XCP_MEMORY_SIZE(node->adev, node->node_id) >> 20);
 		}
 
 		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
@@ -783,6 +782,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		}
 		node->max_proc_per_quantum = max_proc_per_quantum;
 		atomic_set(&node->sram_ecc_flag, 0);
+
+		amdgpu_amdkfd_get_local_mem_info(kfd->adev,
+					&node->local_mem_info, node->xcp->id);
+
 		/* Initialize the KFD node */
 		if (kfd_init_node(node)) {
 			dev_err(kfd_device, "Error initializing KFD node\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 44f4d5509db6..3bd222e8f6c3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -313,6 +313,8 @@ struct kfd_node {
 
 	unsigned int compute_vmid_bitmap;
 
+	struct kfd_local_mem_info local_mem_info;
+
 	struct kfd_dev *kfd;
 };
 
@@ -335,7 +337,6 @@ struct kfd_dev {
 					   */
 
 	struct kgd2kfd_shared_resources shared_resources;
-	struct kfd_local_mem_info local_mem_info;
 
 	const struct kfd2kgd_calls *kfd2kgd;
 	struct mutex doorbell_mutex;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index dbb6159344b3..e0bacf017a40 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1152,8 +1152,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	if (!gpu)
 		return 0;
 
-	local_mem_size = gpu->kfd->local_mem_info.local_mem_size_private +
-			gpu->kfd->local_mem_info.local_mem_size_public;
+	local_mem_size = gpu->local_mem_info.local_mem_size_private +
+			gpu->local_mem_info.local_mem_size_public;
 	buf[0] = gpu->adev->pdev->devfn;
 	buf[1] = gpu->adev->pdev->subsystem_vendor |
 		(gpu->adev->pdev->subsystem_device << 16);
@@ -1234,7 +1234,8 @@ static void kfd_fill_mem_clk_max_info(struct kfd_topology_device *dev)
 	 * for APUs - If CRAT from ACPI reports more than one bank, then
 	 *	all the banks will report the same mem_clk_max information
 	 */
-	amdgpu_amdkfd_get_local_mem_info(dev->gpu->adev, &local_mem_info);
+	amdgpu_amdkfd_get_local_mem_info(dev->gpu->adev, &local_mem_info,
+					 dev->gpu->xcp->id);
 
 	list_for_each_entry(mem, &dev->mem_props, list)
 		mem->mem_clk_max = local_mem_info.mem_clk_max;
-- 
2.40.1

