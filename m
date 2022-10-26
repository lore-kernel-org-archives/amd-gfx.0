Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE88C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 19:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA29510E786;
	Wed, 26 Oct 2022 19:37:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFA510E0F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 19:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYJ1X1e7kJxu3T+ppmHjUNnZC4iMzTEgwnMXlvi0PGCaLApAc7Ecp1w3PGfTjte+ztIX3ufT1VNVX1QYmp9Q0iay10E/1b6sfE41SsoRGm5RVc3tT8HrRnixHhrXxqON1oHEnZzqOWhzHnCPIHawho7LE5f6eT3/B5Q/WxGTmFN4c+yZgr0O1SIAvt3+yqBVWgrrYLFZqb+iWgPre7bKa2kOjzd3HKwA2aBgvjz5/Oz+tcRLYAfW8kZpDpt6ai4Bc/Ua9V2Xiv9yweLrEURfP39FEx4LlVj6lL3KZfJDxW1sycNoB6X52ta2YmwoYyRQ/kiZdi9ghMFKSnV5WW6Mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIHQu7sixOPv3wVrzZ81xoGfdv+fyZUAEdQB9qhv/uI=;
 b=Lb58Z47Fxx8jj9C2x+KxiY5j1U72A+EyBgqC2Uk6bhMWkI+GF3gfcmhTdnNEQASnCrZo8QYpFeT8aRlEnkA8FWWjtY9EFHkszxoDH5dcWJot5iAmRaDwLp0S7KyYn4PKOEgjfEwN0lt3Gxl1+u6m/aPTZ0pjuMBzDyrBaozXGhgpOf6L7y0T95/9GjjfJs4kYd6fNBruX/yZwIDgVybnq4DJBGZBZN2YpCNI/h5+EeurOtQyoh3B2/4c1nwbve4G6eS2yjw9daZ5Q5ZVl5oLz3+hbcePRJdEHVGNrFtXPl+Ls1yBP99sVeHhveUwNNWHID2oRq5iqlUg+IoIN8Znyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIHQu7sixOPv3wVrzZ81xoGfdv+fyZUAEdQB9qhv/uI=;
 b=f5kbVkaPDzjPoGSi9hC4L4IrNJiG6YaaWlyUbgEOG/ovsFI/K6JCE3woLKHpPFgsGYYmozaKhBH3uGYhCApnqio1iQyAsFTDzkwF6iLyv4DevKLLgOipsRJY3Sqr1fldEI0kHz3NpjSAB1hQ2UU07u1Vj6ekVdXmhhJUff1utig=
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 19:37:00 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a3) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 19:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 19:36:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 14:36:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Cleanup kfd_dev struct
Date: Wed, 26 Oct 2022 15:36:45 -0400
Message-ID: <20221026193645.4132096-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0b3983-55f0-45d5-385b-08dab7897336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBfUcubtkcbnf0/yUrgazYtJ8UzqJbBJYOGBX/5FoShfQTYSlOYi08+fhWOgMbuSU5k5FvaKh+J/U3gUk3UAKqqylOK6eH3TfJgX8cOpnuxqdO5MxCgS9JbGK3bR5boD1fdgwfQn0RLnHD3/DGJLyTIGc/ut7AqmXWogjasPBjbc6rUqL8LhxWLiCEw/NtIOAYG1v9jorI+WhzYnkfcwO5CiL2BE5UQu3SmgquFc9HPvgp0p9Iie87nXoSw5tYRZ8RCq2Ia/yI2o5EHPqY3OrEOxn68fs/ZyLbwhsufxW1WAHK1b/b55O41dxXZNbDn1j3EIiCEzA+YKNGw1qfHp12N8iSxpA8s8jXuz/NTHPpQpJ3As/yC6Rh9bOa9iKMwNw5QdATk15NtuAzWPyGOAQheQ6FtR4BTECUXKtGPBy88wSPJLygCSkZ3yYZqXt68A+CX++QYTA0VVKf0Mkay6vWnSvAltuq790UFRxPo4FPNPnGsZOT/0GSL+NQ2jbH6h3VUuLdLsP4sPUo96y2zK/TdsNv6AgRG4Sw3eh+3i7gbT1A57BdCcm+cINWUz09ypTN3CVsTT8HeKHQzsUc3VJbujo3NCKW4jkSDAWviwm9od1fsIsKe8U1UH9eXBTJExWKgoG9SBC2HXSc4tAvKhb6hyyJKuQ1eF2b+qWj0N96sWIj+e8eFSkG3/wMqwz+NEsE5w6DelVKfSIw9dpMlx7NCVVt/0NWIHwt/w1/+L+bH8+ZyCExpcL6MTcEmO0kUQ//ghKe0SeQJ5ZmARz/26Lf7jSksEyt/UaE3YRpMNXxu+GwljSYlNhSBblrPaJ+Kf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(36860700001)(186003)(36756003)(81166007)(336012)(478600001)(7696005)(83380400001)(6666004)(356005)(1076003)(426003)(2616005)(16526019)(40460700003)(47076005)(5660300002)(40480700001)(316002)(8936002)(6916009)(30864003)(54906003)(4326008)(26005)(82310400005)(41300700001)(70586007)(2906002)(8676002)(70206006)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:36:59.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0b3983-55f0-45d5-385b-08dab7897336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Cleanup kfd_dev struct by removing ddev and pdev as both
drm_device and pci_dev can be fetched from amdgpu_device.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 12 ++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 16 +++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     | 29 +++++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 12 ++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 25 +++++++++----------
 9 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0561812aa0a4..e2b0f8049b9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -195,7 +195,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 		}
 
 		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
-						adev_to_drm(adev), &gpu_resources);
+							&gpu_resources);
 
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 647220a8762d..f50e3ba4d7a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -353,7 +353,6 @@ int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
 struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
-			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
@@ -381,7 +380,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 }
 
 static inline
-bool kgd2kfd_device_init(struct kfd_dev *kfd, struct drm_device *ddev,
+bool kgd2kfd_device_init(struct kfd_dev *kfd,
 				const struct kgd2kfd_shared_resources *gpu_resources)
 {
 	return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3c771d580098..acb8bc29218b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2115,8 +2115,8 @@ static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
 	struct acpi_table_header *table_header = NULL;
 	struct acpi_subtable_header *sub_header = NULL;
 	unsigned long table_end, subtable_len;
-	u32 pci_id = pci_domain_nr(kdev->pdev->bus) << 16 |
-			pci_dev_id(kdev->pdev);
+	u32 pci_id = pci_domain_nr(kdev->adev->pdev->bus) << 16 |
+			pci_dev_id(kdev->adev->pdev);
 	u32 bdf;
 	acpi_status status;
 	struct acpi_srat_cpu_affinity *cpu;
@@ -2191,7 +2191,7 @@ static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
 		numa_node = 0;
 
 	if (numa_node != NUMA_NO_NODE)
-		set_dev_node(&kdev->pdev->dev, numa_node);
+		set_dev_node(&kdev->adev->pdev->dev, numa_node);
 }
 #endif
 
@@ -2252,14 +2252,14 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	sub_type_hdr->proximity_domain_from = proximity_domain;
 
 #ifdef CONFIG_ACPI_NUMA
-	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
+	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
 		kfd_find_numa_node_in_srat(kdev);
 #endif
 #ifdef CONFIG_NUMA
-	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
+	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
 		sub_type_hdr->proximity_domain_to = 0;
 	else
-		sub_type_hdr->proximity_domain_to = kdev->pdev->dev.numa_node;
+		sub_type_hdr->proximity_domain_to = kdev->adev->pdev->dev.numa_node;
 #else
 	sub_type_hdr->proximity_domain_to = 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index be7a0b5a2dbc..909397fdb7d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -228,7 +228,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 {
 	struct kfd_dev *kfd = NULL;
 	const struct kfd2kgd_calls *f2g = NULL;
-	struct pci_dev *pdev = adev->pdev;
 	uint32_t gfx_target_version = 0;
 
 	switch (adev->asic_type) {
@@ -430,7 +429,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 
 	kfd->adev = adev;
 	kfd_device_info_init(kfd, vf, gfx_target_version);
-	kfd->pdev = pdev;
 	kfd->init_complete = false;
 	kfd->kfd2kgd = f2g;
 	atomic_set(&kfd->compute_profile, 0);
@@ -512,12 +510,10 @@ static void kfd_smi_init(struct kfd_dev *dev)
 }
 
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
-			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
 {
 	unsigned int size, map_process_packet_size;
 
-	kfd->ddev = ddev;
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC1);
 	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
@@ -542,7 +538,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	     kfd->mec_fw_version < kfd->device_info.no_atomic_fw_version)) {
 		dev_info(kfd_device,
 			 "skipped device %x:%x, PCI rejects atomics %d<%d\n",
-			 kfd->pdev->vendor, kfd->pdev->device,
+			 kfd->adev->pdev->vendor, kfd->adev->pdev->device,
 			 kfd->mec_fw_version,
 			 kfd->device_info.no_atomic_fw_version);
 		return false;
@@ -651,8 +647,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	kfd_smi_init(kfd);
 
 	kfd->init_complete = true;
-	dev_info(kfd_device, "added device %x:%x\n", kfd->pdev->vendor,
-		 kfd->pdev->device);
+	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
+		 kfd->adev->pdev->device);
 
 	pr_debug("Starting kfd with the following scheduling policy %d\n",
 		kfd->dqm->sched_policy);
@@ -677,7 +673,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
-		kfd->pdev->vendor, kfd->pdev->device);
+		kfd->adev->pdev->vendor, kfd->adev->pdev->device);
 out:
 	return kfd->init_complete;
 }
@@ -790,7 +786,7 @@ int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
 	if (err)
 		dev_err(kfd_device,
 			"Failed to resume IOMMU for device %x:%x\n",
-			kfd->pdev->vendor, kfd->pdev->device);
+			kfd->adev->pdev->vendor, kfd->adev->pdev->device);
 	return err;
 }
 
@@ -802,7 +798,7 @@ static int kfd_resume(struct kfd_dev *kfd)
 	if (err)
 		dev_err(kfd_device,
 			"Error starting queue manager for device %x:%x\n",
-			kfd->pdev->vendor, kfd->pdev->device);
+			kfd->adev->pdev->vendor, kfd->adev->pdev->device);
 
 	return err;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index fbd0afe4da42..ec1bf611624e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -49,7 +49,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
 		return -ENODEV;
 
 	iommu_info.flags = 0;
-	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
+	err = amd_iommu_device_info(kfd->adev->pdev, &iommu_info);
 	if (err)
 		return err;
 
@@ -71,7 +71,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 		return 0;
 
 	iommu_info.flags = 0;
-	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
+	err = amd_iommu_device_info(kfd->adev->pdev, &iommu_info);
 	if (err < 0) {
 		dev_err(kfd_device,
 			"error getting iommu info. is the iommu enabled?\n");
@@ -121,7 +121,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
 		return -EINVAL;
 	}
 
-	err = amd_iommu_bind_pasid(dev->pdev, p->pasid, p->lead_thread);
+	err = amd_iommu_bind_pasid(dev->adev->pdev, p->pasid, p->lead_thread);
 	if (!err)
 		pdd->bound = PDD_BOUND;
 
@@ -139,7 +139,8 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
 
 	for (i = 0; i < p->n_pdds; i++)
 		if (p->pdds[i]->bound == PDD_BOUND)
-			amd_iommu_unbind_pasid(p->pdds[i]->dev->pdev, p->pasid);
+			amd_iommu_unbind_pasid(p->pdds[i]->dev->adev->pdev,
+					       p->pasid);
 }
 
 /* Callback for process shutdown invoked by the IOMMU driver */
@@ -222,7 +223,7 @@ static int kfd_bind_processes_to_device(struct kfd_dev *kfd)
 			continue;
 		}
 
-		err = amd_iommu_bind_pasid(kfd->pdev, p->pasid,
+		err = amd_iommu_bind_pasid(kfd->adev->pdev, p->pasid,
 				p->lead_thread);
 		if (err < 0) {
 			pr_err("Unexpected pasid 0x%x binding failure\n",
@@ -282,9 +283,9 @@ void kfd_iommu_suspend(struct kfd_dev *kfd)
 
 	kfd_unbind_processes_from_device(kfd);
 
-	amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
-	amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
-	amd_iommu_free_device(kfd->pdev);
+	amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
+	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
+	amd_iommu_free_device(kfd->adev->pdev);
 }
 
 /** kfd_iommu_resume - Restore IOMMU after resume
@@ -302,20 +303,20 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
 
 	pasid_limit = kfd_get_pasid_limit();
 
-	err = amd_iommu_init_device(kfd->pdev, pasid_limit);
+	err = amd_iommu_init_device(kfd->adev->pdev, pasid_limit);
 	if (err)
 		return -ENXIO;
 
-	amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
+	amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev,
 					iommu_pasid_shutdown_callback);
-	amd_iommu_set_invalid_ppr_cb(kfd->pdev,
+	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev,
 				     iommu_invalid_ppr_cb);
 
 	err = kfd_bind_processes_to_device(kfd);
 	if (err) {
-		amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
-		amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
-		amd_iommu_free_device(kfd->pdev);
+		amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
+		amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
+		amd_iommu_free_device(kfd->adev->pdev);
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bf610e3b683b..552c3ac85a13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -254,8 +254,6 @@ struct kfd_dev {
 	struct amdgpu_device *adev;
 
 	struct kfd_device_info device_info;
-	struct pci_dev *pdev;
-	struct drm_device *ddev;
 
 	unsigned int id;		/* topology stub index */
 
@@ -1365,7 +1363,7 @@ void kfd_dec_compute_active(struct kfd_dev *dev);
 static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
 {
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
-	struct drm_device *ddev = kfd->ddev;
+	struct drm_device *ddev = adev_to_drm(kfd->adev);
 
 	return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
 					  ddev->render->index,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 951b63677248..a26257171ab7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1050,8 +1050,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		 * for auto suspend
 		 */
 		if (pdd->runtime_inuse) {
-			pm_runtime_mark_last_busy(pdd->dev->ddev->dev);
-			pm_runtime_put_autosuspend(pdd->dev->ddev->dev);
+			pm_runtime_mark_last_busy(adev_to_drm(pdd->dev->adev)->dev);
+			pm_runtime_put_autosuspend(adev_to_drm(pdd->dev->adev)->dev);
 			pdd->runtime_inuse = false;
 		}
 
@@ -1633,9 +1633,9 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 	 * pdd is destroyed.
 	 */
 	if (!pdd->runtime_inuse) {
-		err = pm_runtime_get_sync(dev->ddev->dev);
+		err = pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
 		if (err < 0) {
-			pm_runtime_put_autosuspend(dev->ddev->dev);
+			pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
 			return ERR_PTR(err);
 		}
 	}
@@ -1655,8 +1655,8 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 out:
 	/* balance runpm reference count and exit with error */
 	if (!pdd->runtime_inuse) {
-		pm_runtime_mark_last_busy(dev->ddev->dev);
-		pm_runtime_put_autosuspend(dev->ddev->dev);
+		pm_runtime_mark_last_busy(adev_to_drm(dev->adev)->dev);
+		pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
 	}
 
 	return ERR_PTR(err);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index af4140685bf3..39fbe19b978a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -259,7 +259,7 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 			pr_debug("failed to find device idx %d\n", gpuidx);
 			continue;
 		}
-		dev = &pdd->dev->pdev->dev;
+		dev = &pdd->dev->adev->pdev->dev;
 		svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
 		kvfree(dma_addr);
 		prange->dma_addr[gpuidx] = NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3f0a4a415907..ec8c9c10d348 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -115,7 +115,7 @@ struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev)
 	down_read(&topology_lock);
 
 	list_for_each_entry(top_dev, &topology_device_list, list)
-		if (top_dev->gpu && top_dev->gpu->pdev == pdev) {
+		if (top_dev->gpu && top_dev->gpu->adev->pdev == pdev) {
 			device = top_dev->gpu;
 			break;
 		}
@@ -1169,13 +1169,12 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
 
 	local_mem_size = gpu->local_mem_info.local_mem_size_private +
 			gpu->local_mem_info.local_mem_size_public;
-
-	buf[0] = gpu->pdev->devfn;
-	buf[1] = gpu->pdev->subsystem_vendor |
-		(gpu->pdev->subsystem_device << 16);
-	buf[2] = pci_domain_nr(gpu->pdev->bus);
-	buf[3] = gpu->pdev->device;
-	buf[4] = gpu->pdev->bus->number;
+	buf[0] = gpu->adev->pdev->devfn;
+	buf[1] = gpu->adev->pdev->subsystem_vendor |
+		(gpu->adev->pdev->subsystem_device << 16);
+	buf[2] = pci_domain_nr(gpu->adev->pdev->bus);
+	buf[3] = gpu->adev->pdev->device;
+	buf[4] = gpu->adev->pdev->bus->number;
 	buf[5] = lower_32_bits(local_mem_size);
 	buf[6] = upper_32_bits(local_mem_size);
 
@@ -1269,7 +1268,7 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
 	if (target_gpu_dev) {
 		uint32_t cap;
 
-		pcie_capability_read_dword(target_gpu_dev->gpu->pdev,
+		pcie_capability_read_dword(target_gpu_dev->gpu->adev->pdev,
 				PCI_EXP_DEVCAP2, &cap);
 
 		if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
@@ -1688,13 +1687,13 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		cu_info.num_shader_arrays_per_engine;
 
 	dev->node_props.gfx_target_version = gpu->device_info.gfx_target_version;
-	dev->node_props.vendor_id = gpu->pdev->vendor;
-	dev->node_props.device_id = gpu->pdev->device;
+	dev->node_props.vendor_id = gpu->adev->pdev->vendor;
+	dev->node_props.device_id = gpu->adev->pdev->device;
 	dev->node_props.capability |=
 		((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
 			HSA_CAP_ASIC_REVISION_MASK);
-	dev->node_props.location_id = pci_dev_id(gpu->pdev);
-	dev->node_props.domain = pci_domain_nr(gpu->pdev->bus);
+	dev->node_props.location_id = pci_dev_id(gpu->adev->pdev);
+	dev->node_props.domain = pci_domain_nr(gpu->adev->pdev->bus);
 	dev->node_props.max_engine_clk_fcompute =
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->adev);
 	dev->node_props.max_engine_clk_ccompute =
-- 
2.37.3

