Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500D8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 18:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164B66023D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 18:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 164B66023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900506ECB1;
	Fri,  5 Nov 2021 18:44:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D546ECB1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 18:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRqLWABxvv+QgQZlq2LxxyQ2Vgr9eiLIA90RahDiMVPanOkI9MwKGQc67FCWLe0FRjBe/QfwdWdihA12BHPv8Uu5j8UzQNg10qGKsEdBtajKYhnIe5PghFbwUHnsps/9D0/FLhOypL3IDvn/THYBbXQ5xfi0uosz0pKwCxoJP+ipRRSw8voHlYQDgQc9J5r1USdYb0tx4pmc3bSvF+73TJS0S7tIkpRliYWjikfCEf6HBWr4zF/bxoAnZMJK7UkjA8httUph84bHSwQIv9w9AyCZ3ZTeziyAJCS/wH/u4cS5ssJsCZqij75X6zPGgdXTVoZ+VXxOWNs01X8/cKTkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D68eI/M3ZZrBdRcb6ICGJF/HnU9oZl/bbDCe3rZjvkc=;
 b=ImCN6QUPZ/0YlwLeoOY52f2aJwj6M/DZwsvPbFa7N+yBz/iNLj7urfID8pfS+i4Kfm8OdDzA4+BNszQt9rPl60T324AXoCwJTHbEkppFwHBG9FnarC+L/YdTPSfcO83vM/j2lnZqr+wNbOZC4UPND5q+qikFLCM/M2NCfSyaiP70cBeWKuZFAeGb0jo3QE7RrvpxujQyq5Z36C1hS7VxD4qEcW2PecbUDn1bxhus7UrEA1pnZciVBm4Wi2BD6RtkcCZVrSFYItsRR/azQe8DgESIhBqAZYsIKNjRVSFYas06GWcupCUeWq0q3E5xCkUrF9ROrBgAUzkYkPVe+za5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D68eI/M3ZZrBdRcb6ICGJF/HnU9oZl/bbDCe3rZjvkc=;
 b=ff+S+lV4VkgkRHPY2d+GM2+NNELGUGPNx5MD7gLC1AU6elh21PpCNro/+go2uBxTG+8bZTU5ENcDD8qDAZafpO1R5+++wlFJl2CQDQRQz85mt6eLUGNbOaN5xU9F0NCv8bYWrtKW8hZIkQJNT5pM6KgpVW8CbDvLa1HEmQV+epk=
Received: from BN8PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:60::43)
 by DM6PR12MB4635.namprd12.prod.outlook.com (2603:10b6:5:16b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Fri, 5 Nov
 2021 18:44:39 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::7) by BN8PR12CA0030.outlook.office365.com
 (2603:10b6:408:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 18:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 18:44:37 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 13:44:36 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: replace trivial funcs with direct access
Date: Fri, 5 Nov 2021 14:43:48 -0400
Message-ID: <20211105184348.2155143-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345af054-f4da-4199-0bde-08d9a08c51bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4635:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46354DB5192EA45A9D798FB88A8E9@DM6PR12MB4635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiS/a+Qp4w0+kOQBd2FLM+GWdk5OxfZKA5y5T3WG1w2rp7uXHNYyDkX4TY7F1rAcfLqsInhGPHp6CvGcZ9lE8neDBXkpKoLQg+kiGy1Ofld012GgMaDvxMzyXq6EnPHr8wzqsy9Joi+rs2Pu/SWuEcTgp/ILCOSFg6lsbDD9dul5GWDPltq5KO13wZfpAS+PTb8RLo3Hc8m2DHz7jdwcFe5xU3fvgnEC8+4PDj/zp6p2ZLtP3Piyo5LDaZWo2QimlnVotFjX5SvQtrOXxcv3VwoMtoHGIocMON0BxnmC8hC8hHbtaEB36yh69S9Y3g3Qus6CpHiBUqmNMF2c/lXrz2K+1R+8ko6Vk45vDIf0WoLxQiSpFjuMyrTJSdprfsM+tVP5tHB9l4mBUMZyLQAChss/UtG61KM7oQuETwIAx8Vom6X7oNAyk9kJJYeGH61tKVIiQF3e3rwTJPEHooXohYjOFoMWJj2BKYEP8bz2XK3wxwp2FbTv2WKhTw2grmPdGc9HmEm7lXFYnn6tsCAFA972odBTAbaf+3bkqr/TMJqlPGMo64PyWPALmWVbxpXwsJhmSkud+61jri359GxR1ql+jogAcvSR12Ap97PsoiVH+aExcgBnEpt+19wsDME4SOHGuGRlIwVT7B7dAyGKiA4UXAgUDDRuEc6FN100HJUKA3F1LQdpsUtfZ2lvVsNN3PULz6ue4LOHqo50vNyLHh6XVaXcfN0UOQulyzvAFIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(70586007)(356005)(2906002)(81166007)(426003)(47076005)(316002)(36756003)(6666004)(54906003)(36860700001)(336012)(1076003)(86362001)(70206006)(82310400003)(83380400001)(4326008)(508600001)(8936002)(2616005)(7696005)(8676002)(6916009)(186003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 18:44:37.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345af054-f4da-4199-0bde-08d9a08c51bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4635
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These get funcs simply return an adev field. Replace funcs/calls with
direct field accesses instead.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 30 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  8 ++---
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  7 ++---
 6 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 83f863dca7af..46cf48b3904a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -521,16 +521,6 @@ uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
 	return amdgpu_vram_mgr_usage(vram_man);
 }
 
-uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev)
-{
-	return adev->gmc.xgmi.hive_id;
-}
-
-uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev)
-{
-	return adev->unique_id;
-}
-
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
 					  struct amdgpu_device *src)
 {
@@ -630,26 +620,6 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
 	return (num_lanes_factor * gen_speed_mbits_factor)/BITS_PER_BYTE;
 }
 
-uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev)
-{
-	return adev->rmmio_remap.bus_addr;
-}
-
-uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev)
-{
-	return adev->gds.gws_size;
-}
-
-uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev)
-{
-	return adev->rev_id;
-}
-
-int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev)
-{
-	return adev->gmc.noretry;
-}
-
 int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 				enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5f658823a637..d00de575c541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -224,12 +224,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags);
 uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev);
-uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev);
-uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev);
-uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev);
-uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev);
-uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev);
-int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
 					  struct amdgpu_device *src);
 int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 8d5021e8c714..2e3d74f7fbfb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1313,7 +1313,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			err = -EINVAL;
 			goto err_unlock;
 		}
-		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
+		offset = dev->adev->rmmio_remap.bus_addr;
 		if (!offset) {
 			err = -ENOMEM;
 			goto err_unlock;
@@ -2066,7 +2066,7 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
-	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
+	address = dev->adev->rmmio_remap.bus_addr;
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
 				VM_DONTDUMP | VM_PFNMAP;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c8aade17efef..b752dc36a2cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -892,7 +892,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
 			&& kfd->mec2_fw_version >= 0x28))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
-				amdgpu_amdkfd_get_num_gws(kfd->adev), &kfd->gws);
+				kfd->adev->gds.gws_size, &kfd->gws);
 
 	return ret;
 }
@@ -994,9 +994,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto kfd_doorbell_error;
 	}
 
-	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->adev);
+	kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
 
-	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->adev);
+	kfd->noretry = kfd->adev->gmc.noretry;
 
 	if (kfd_interrupt_init(kfd)) {
 		dev_err(kfd_device, "Error initializing interrupts\n");
@@ -1014,7 +1014,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 */
 	if (kfd_gws_init(kfd)) {
 		dev_err(kfd_device, "Could not allocate %d gws\n",
-			amdgpu_amdkfd_get_num_gws(kfd->adev));
+			kfd->adev->gds.gws_size);
 		goto gws_error;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 62dc41cf2cb9..4f8464658daf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -118,7 +118,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 		return ret;
 
 	pqn->q->gws = mem;
-	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->adev) : 0;
+	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
 							pqn->q, NULL);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 2e0006e22006..ae7c9944dc4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -531,7 +531,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
-				      amdgpu_amdkfd_get_unique_id(dev->gpu->adev));
+				      dev->gpu->adev->unique_id);
 
 	}
 
@@ -1381,8 +1381,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
 	dev->node_props.capability |=
-		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->adev) <<
-			HSA_CAP_ASIC_REVISION_SHIFT) &
+		((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
 			HSA_CAP_ASIC_REVISION_MASK);
 	dev->node_props.location_id = pci_dev_id(gpu->pdev);
 	dev->node_props.domain = pci_domain_nr(gpu->pdev->bus);
@@ -1401,7 +1400,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 				gpu->device_info->num_sdma_queues_per_engine;
 	dev->node_props.num_gws = (dev->gpu->gws &&
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
-		amdgpu_amdkfd_get_num_gws(dev->gpu->adev) : 0;
+		dev->gpu->adev->gds.gws_size : 0;
 	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
 
 	kfd_fill_mem_clk_max_info(dev);
-- 
2.25.1

