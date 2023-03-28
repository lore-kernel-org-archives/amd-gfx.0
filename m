Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE5C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCC910E909;
	Tue, 28 Mar 2023 15:14:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F1510E8FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSH0AuqIrizmPi9fQNsm8gROpU9zwrkaOIhRsS//q4j8gVj7mx9Zon73NbV9abBOCWD9JRLKIqqxyBp2dMzwZ609dfRoiUok5jVBOwfuHAvPKXNPfXOuxp0wfxnxK2Z46O+nUr3+VxjMK/iW01bE45x4XKCGC7GMfrDzTrmWlcfot9AfcPwUJ24inJrqWCgt3+8YxeOEicJ2RZNC3H5go8/urqnrsc10liRe8JpuXXkyM97wmeHI4HjUbxOI0Z+ICgQjVUbYWfkF2VAhGcHBak8/F18lN3zCx39z3F9eIJmPhLehMCLjgpMUB+6njaLFnLmpJ4zESYEF+icAfkrf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D8LzhfoxvvAE9nQNvLIRdhgKDOgugQOtMx05h8c+/I=;
 b=ABHbiVidIeicAURZuX9kmj3hHvd8lJNitonFtK++MWhRqvVm+szgjyO3qOXc2NdZU7uM+Vw+/B1kHY29cOZH9fSvBvw25zMqlaCvkeA34mVrazkt5SUp326LQUgSLW+1rk8F61sszIqG27MKXF6alzmHGfSvDfUHYtt7rH54VbYTaCV2JteyzkS4t2Vk0GcGPckDAs1LV0+LvLoIClGUMWLXmJruaOFJRMU9Eno+uaRA4baj3WlD/5Ss9AzapzL66TBXA3AGKBZiK3kSRLHAgjGKrd3SMSy9411pz3afrMQywJBzJYCeZ89r9JL/THHy6LazcdD3GY4UWl4MD9dI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D8LzhfoxvvAE9nQNvLIRdhgKDOgugQOtMx05h8c+/I=;
 b=EQJKtwF6jWD68mZ52hclqwzGIW9Kquxx10LhOJ/LvxaKMorzbYdzvuKfgYQI5EaDq1u1mO4vxUHX5yTPSG4bea75vXwhfQubqzQkh4/CcoMPOXS5UhT62HMHnFYQO3tSoUVr59wDlTxs1ZOalc2Ti+VvKvhHbDB9Hpc68f7UCCU=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Tue, 28 Mar
 2023 15:14:12 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::2e) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.19 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/32] drm/amdkfd: Add spatial partitioning support in KFD
Date: Tue, 28 Mar 2023 11:13:19 -0400
Message-ID: <20230328151344.1934291-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 53837d43-7c1f-4f5f-4687-08db2f9f1668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1DC5gwH7uK2Fhgk4Lnhn3OPXAuci39BUdF3XxBXUWcJMlTSwPg1PrfDJ3sGDFMCX7EZ27XN/UB0Rp9A1V8F2jqpNelTMuKGHmsnLx5QA723jZeuRws68EqE/XIYDS9RtYvgCKoZg4jcJkMAAyZK4CBh/sOSSPzwUAyB1kcdptEDhNqWsS2tFFTg1WSj6R/72jbzTmhU45UkCKVui3TFN9i3VpICno0lriKYnvLHMUZQDUAoBbpxXlmPtBJVqOrBUPFpXChBaneW1Mwp4yh9Yc3yaHbOEDaBAGZwdtscLbYep97FjD9KaNvtvz468y7JPMudSkF+H3hrBQSitwEJKQ2gOeWXIdEa+zc/aNHeS0inrlwTHRPItaFEOxibrct2K2GCE4e2Uer+tWVQCe3XVeRYufqD4TCqgQ9j3cT9/UoXcZ/X1TiCQ5lKaCtyohujJnn5uZYOIi3MnxLWLHjgVbNOFSvsv4uU4OJdWsIaepNxYhh+cYjQuI1QJ/yidKOb9WjvhR7ewEijttbSNOmRNGa09l1B6gTnANLEXhDvs4sCVJvIFMT7CqCuhje1Uuhw2oN9rpbL7NwaIgKiaEGMsa99HAGMtA5qxqsVxqZUkoRtUgNZVT6CjZQt39PB0LgvpLK1v3fZggzSXOlAa2om5vdWkhH1KLyYa2hTFDObfVteZu9/d2YKTp2UI46DBEZDjL6yMKFNxmjkg6fqdr6rrGqp3UA1m2ZIZ4SQLdOT8hg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(82740400003)(6916009)(70206006)(4326008)(36860700001)(8676002)(316002)(70586007)(8936002)(356005)(81166007)(41300700001)(30864003)(1076003)(5660300002)(26005)(186003)(16526019)(7696005)(2616005)(83380400001)(47076005)(426003)(478600001)(336012)(6666004)(54906003)(40480700001)(86362001)(2906002)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:12.4826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53837d43-7c1f-4f5f-4687-08db2f9f1668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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

This patch introduces multi-partition support in KFD.
This patch includes:
- Support for maximum 8 spatial partitions in KFD.
- Initialize one HIQ per partition.
- Management of VMID range depending on partition mode.
- Management of doorbell aperture space between all
  partitions.
- Each partition does its own queue management, interrupt
  handling, SMI event reporting.
- IOMMU, if enabled with multiple partitions, will only work
  on first partition.
- SPM is only supported on the first partition.
- Currently, there is no support for resetting individual
  partitions. All partitions will reset together.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 214 +++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |  13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  24 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   8 +-
 7 files changed, 208 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b0231ee08ea3..363114edb3c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -559,23 +559,27 @@ static int kfd_init_node(struct kfd_node *node)
 	return err;
 }
 
-static void kfd_cleanup_node(struct kfd_dev *kfd)
+static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 {
-	struct kfd_node *knode = kfd->node;
-
-	device_queue_manager_uninit(knode->dqm);
-	kfd_interrupt_exit(knode);
-	kfd_topology_remove_device(knode);
-	if (knode->gws)
-		amdgpu_amdkfd_free_gws(knode->adev, knode->gws);
-	kfree(knode);
-	kfd->node = NULL;
+	struct kfd_node *knode;
+	unsigned int i;
+
+	for (i = 0; i < num_nodes; i++) {
+		knode = kfd->nodes[i];
+		device_queue_manager_uninit(knode->dqm);
+		kfd_interrupt_exit(knode);
+		kfd_topology_remove_device(knode);
+		if (knode->gws)
+			amdgpu_amdkfd_free_gws(knode->adev, knode->gws);
+		kfree(knode);
+		kfd->nodes[i] = NULL;
+	}
 }
 
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
 {
-	unsigned int size, map_process_packet_size;
+	unsigned int size, map_process_packet_size, i;
 	struct kfd_node *node;
 	uint32_t first_vmid_kfd, last_vmid_kfd, vmid_num_kfd;
 	unsigned int max_proc_per_quantum;
@@ -588,9 +592,18 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			KGD_ENGINE_SDMA1);
 	kfd->shared_resources = *gpu_resources;
 
-	first_vmid_kfd = ffs(gpu_resources->compute_vmid_bitmap)-1;
-	last_vmid_kfd = fls(gpu_resources->compute_vmid_bitmap)-1;
-	vmid_num_kfd = last_vmid_kfd - first_vmid_kfd + 1;
+	if (kfd->adev->gfx.num_xcd == 0 || kfd->adev->gfx.num_xcd == 1 ||
+	    kfd->adev->gfx.num_xcc_per_xcp == 0)
+		kfd->num_nodes = 1;
+	else
+		kfd->num_nodes =
+			kfd->adev->gfx.num_xcd/kfd->adev->gfx.num_xcc_per_xcp;
+	if (kfd->num_nodes == 0) {
+		dev_err(kfd_device,
+			"KFD num nodes cannot be 0, GC inst: %d, num_xcc_in_node: %d\n",
+			kfd->adev->gfx.num_xcd, kfd->adev->gfx.num_xcc_per_xcp);
+		goto out;
+	}
 
 	/* Allow BIF to recode atomics to PCIe 3.0 AtomicOps.
 	 * 32 and 64-bit requests are possible and must be
@@ -609,6 +622,26 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		return false;
 	}
 
+	first_vmid_kfd = ffs(gpu_resources->compute_vmid_bitmap)-1;
+	last_vmid_kfd = fls(gpu_resources->compute_vmid_bitmap)-1;
+	vmid_num_kfd = last_vmid_kfd - first_vmid_kfd + 1;
+
+	/* For GFX9.4.3, we need special handling for VMIDs depending on
+	 * partition mode.
+	 * In CPX mode, the VMID range needs to be shared between XCDs.
+	 * Additionally, there are 13 VMIDs (3-15) available for KFD. To
+	 * divide them equally, we change starting VMID to 4 and not use
+	 * VMID 3.
+	 * If the VMID range changes for GFX9.4.3, then this code MUST be
+	 * revisited.
+	 */
+	if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
+	    kfd->adev->gfx.partition_mode == AMDGPU_CPX_PARTITION_MODE &&
+	    kfd->num_nodes != 1) {
+		vmid_num_kfd /= 2;
+		first_vmid_kfd = last_vmid_kfd + 1 - vmid_num_kfd*2;
+	}
+
 	/* Verify module parameters regarding mapped process number*/
 	if (hws_max_conc_proc >= 0)
 		max_proc_per_quantum = min((u32)hws_max_conc_proc, vmid_num_kfd);
@@ -674,6 +707,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd_cwsr_init(kfd);
 
+	/* TODO: Needs to be updated for memory partitioning */
 	svm_migrate_init(kfd->adev);
 
 	/* Allocate the KFD node */
@@ -692,12 +726,51 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	node->max_proc_per_quantum = max_proc_per_quantum;
 	atomic_set(&node->sram_ecc_flag, 0);
 
-	/* Initialize the KFD node */
-	if (kfd_init_node(node)) {
-		dev_err(kfd_device, "Error initializing KFD node\n");
-		goto node_init_error;
+	dev_info(kfd_device, "Total number of KFD nodes to be created: %d\n",
+				kfd->num_nodes);
+	for (i = 0; i < kfd->num_nodes; i++) {
+		node = kzalloc(sizeof(struct kfd_node), GFP_KERNEL);
+		if (!node)
+			goto node_alloc_error;
+
+		node->adev = kfd->adev;
+		node->kfd = kfd;
+		node->kfd2kgd = kfd->kfd2kgd;
+		node->vm_info.vmid_num_kfd = vmid_num_kfd;
+		node->num_xcc_per_node = max(1U, kfd->adev->gfx.num_xcc_per_xcp);
+		node->start_xcc_id = node->num_xcc_per_node * i;
+
+		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
+		    kfd->adev->gfx.partition_mode == AMDGPU_CPX_PARTITION_MODE &&
+		    kfd->num_nodes != 1) {
+			/* For GFX9.4.3 and CPX mode, first XCD gets VMID range
+			 * 4-9 and second XCD gets VMID range 10-15.
+			 */
+
+			node->vm_info.first_vmid_kfd = (i%2 == 0) ?
+						first_vmid_kfd :
+						first_vmid_kfd+vmid_num_kfd;
+			node->vm_info.last_vmid_kfd = (i%2 == 0) ?
+						last_vmid_kfd-vmid_num_kfd :
+						last_vmid_kfd;
+			node->compute_vmid_bitmap =
+				((0x1 << (node->vm_info.last_vmid_kfd + 1)) - 1) -
+				((0x1 << (node->vm_info.first_vmid_kfd)) - 1);
+		} else {
+			node->vm_info.first_vmid_kfd = first_vmid_kfd;
+			node->vm_info.last_vmid_kfd = last_vmid_kfd;
+			node->compute_vmid_bitmap =
+				gpu_resources->compute_vmid_bitmap;
+		}
+		node->max_proc_per_quantum = max_proc_per_quantum;
+		atomic_set(&node->sram_ecc_flag, 0);
+		/* Initialize the KFD node */
+		if (kfd_init_node(node)) {
+			dev_err(kfd_device, "Error initializing KFD node\n");
+			goto node_init_error;
+		}
+		kfd->nodes[i] = node;
 	}
-	kfd->node = node;
 
 	if (kfd_resume_iommu(kfd))
 		goto kfd_resume_iommu_error;
@@ -714,9 +787,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	goto out;
 
 kfd_resume_iommu_error:
-	kfd_cleanup_node(kfd);
 node_init_error:
 node_alloc_error:
+	kfd_cleanup_nodes(kfd, i);
 device_iommu_error:
 	kfd_doorbell_fini(kfd);
 kfd_doorbell_error:
@@ -734,7 +807,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 	if (kfd->init_complete) {
-		kfd_cleanup_node(kfd);
+		/* Cleanup KFD nodes */
+		kfd_cleanup_nodes(kfd, kfd->num_nodes);
+		/* Cleanup common/shared resources */
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
@@ -746,18 +821,23 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 
 int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 {
-	struct kfd_node *node = kfd->node;
+	struct kfd_node *node;
+	int i;
 
 	if (!kfd->init_complete)
 		return 0;
 
-	kfd_smi_event_update_gpu_reset(node, false);
-
-	node->dqm->ops.pre_reset(node->dqm);
+	for (i = 0; i < kfd->num_nodes; i++) {
+		node = kfd->nodes[i];
+		kfd_smi_event_update_gpu_reset(node, false);
+		node->dqm->ops.pre_reset(node->dqm);
+	}
 
 	kgd2kfd_suspend(kfd, false);
 
-	kfd_signal_reset_event(node);
+	for (i = 0; i < kfd->num_nodes; i++)
+		kfd_signal_reset_event(kfd->nodes[i]);
+
 	return 0;
 }
 
@@ -770,19 +850,25 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 int kgd2kfd_post_reset(struct kfd_dev *kfd)
 {
 	int ret;
-	struct kfd_node *node = kfd->node;
+	struct kfd_node *node;
+	int i;
 
 	if (!kfd->init_complete)
 		return 0;
 
-	ret = kfd_resume(node);
-	if (ret)
-		return ret;
-	atomic_dec(&kfd_locked);
+	for (i = 0; i < kfd->num_nodes; i++) {
+		ret = kfd_resume(kfd->nodes[i]);
+		if (ret)
+			return ret;
+	}
 
-	atomic_set(&node->sram_ecc_flag, 0);
+	atomic_dec(&kfd_locked);
 
-	kfd_smi_event_update_gpu_reset(node, true);
+	for (i = 0; i < kfd->num_nodes; i++) {
+		node = kfd->nodes[i];
+		atomic_set(&node->sram_ecc_flag, 0);
+		kfd_smi_event_update_gpu_reset(node, true);
+	}
 
 	return 0;
 }
@@ -794,7 +880,8 @@ bool kfd_is_locked(void)
 
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
-	struct kfd_node *node = kfd->node;
+	struct kfd_node *node;
+	int i;
 
 	if (!kfd->init_complete)
 		return;
@@ -806,21 +893,25 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 			kfd_suspend_all_processes();
 	}
 
-	node->dqm->ops.stop(node->dqm);
+	for (i = 0; i < kfd->num_nodes; i++) {
+		node = kfd->nodes[i];
+		node->dqm->ops.stop(node->dqm);
+	}
 	kfd_iommu_suspend(kfd);
 }
 
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
-	int ret, count;
-	struct kfd_node *node = kfd->node;
+	int ret, count, i;
 
 	if (!kfd->init_complete)
 		return 0;
 
-	ret = kfd_resume(node);
-	if (ret)
-		return ret;
+	for (i = 0; i < kfd->num_nodes; i++) {
+		ret = kfd_resume(kfd->nodes[i]);
+		if (ret)
+			return ret;
+	}
 
 	/* for runtime resume, skip unlocking kfd */
 	if (!run_pm) {
@@ -884,10 +975,10 @@ static inline void kfd_queue_work(struct workqueue_struct *wq,
 /* This is called directly from KGD at ISR. */
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 {
-	uint32_t patched_ihre[KFD_MAX_RING_ENTRY_SIZE];
+	uint32_t patched_ihre[KFD_MAX_RING_ENTRY_SIZE], i;
 	bool is_patched = false;
 	unsigned long flags;
-	struct kfd_node *node = kfd->node;
+	struct kfd_node *node;
 
 	if (!kfd->init_complete)
 		return;
@@ -897,16 +988,22 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 		return;
 	}
 
-	spin_lock_irqsave(&node->interrupt_lock, flags);
-
-	if (node->interrupts_active
-	    && interrupt_is_wanted(node, ih_ring_entry,
-				   patched_ihre, &is_patched)
-	    && enqueue_ih_ring_entry(node,
-				     is_patched ? patched_ihre : ih_ring_entry))
-		kfd_queue_work(node->ih_wq, &node->interrupt_work);
+	for (i = 0; i < kfd->num_nodes; i++) {
+		node = kfd->nodes[i];
+		spin_lock_irqsave(&node->interrupt_lock, flags);
+
+		if (node->interrupts_active
+		    && interrupt_is_wanted(node, ih_ring_entry,
+			    	patched_ihre, &is_patched)
+		    && enqueue_ih_ring_entry(node,
+			    	is_patched ? patched_ihre : ih_ring_entry)) {
+			kfd_queue_work(node->ih_wq, &node->interrupt_work);
+			spin_unlock_irqrestore(&node->interrupt_lock, flags);
+				return;
+		}
+		spin_unlock_irqrestore(&node->interrupt_lock, flags);
+	}
 
-	spin_unlock_irqrestore(&node->interrupt_lock, flags);
 }
 
 int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger)
@@ -1173,8 +1270,13 @@ int kfd_gtt_sa_free(struct kfd_node *node, struct kfd_mem_obj *mem_obj)
 
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
 {
+	/*
+	 * TODO: Currently update SRAM ECC flag for first node.
+	 * This needs to be updated later when we can
+	 * identify SRAM ECC error on other nodes also.
+	 */
 	if (kfd)
-		atomic_inc(&kfd->node->sram_ecc_flag);
+		atomic_inc(&kfd->nodes[0]->sram_ecc_flag);
 }
 
 void kfd_inc_compute_active(struct kfd_node *node)
@@ -1194,8 +1296,14 @@ void kfd_dec_compute_active(struct kfd_node *node)
 
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
+	/*
+	 * TODO: For now, raise the throttling event only on first node.
+	 * This will need to change after we are able to determine
+	 * which node raised the throttling event.
+	 */
 	if (kfd && kfd->init_complete)
-		kfd_smi_event_update_thermal_throttling(kfd->node, throttle_bitmask);
+		kfd_smi_event_update_thermal_throttling(kfd->nodes[0],
+							throttle_bitmask);
 }
 
 /* kfd_get_num_sdma_engines returns the number of PCIe optimized SDMA and
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 34977d89f01c..6ee17100c333 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1426,7 +1426,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 	int i, mec;
 	struct scheduling_resources res;
 
-	res.vmid_mask = dqm->dev->kfd->shared_resources.compute_vmid_bitmap;
+	res.vmid_mask = dqm->dev->compute_vmid_bitmap;
 
 	res.queue_mask = 0;
 	for (i = 0; i < KGD_MAX_QUEUES; ++i) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 6eee9a0944f3..808ee010520a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -121,6 +121,12 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
 		return -EINVAL;
 	}
 
+	if (!kfd_is_first_node(dev)) {
+		dev_warn_once(kfd_device,
+				"IOMMU supported only on first node\n");
+		return 0;
+	}
+
 	err = amd_iommu_bind_pasid(dev->adev->pdev, p->pasid, p->lead_thread);
 	if (!err)
 		pdd->bound = PDD_BOUND;
@@ -138,7 +144,8 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
 	int i;
 
 	for (i = 0; i < p->n_pdds; i++)
-		if (p->pdds[i]->bound == PDD_BOUND)
+		if ((p->pdds[i]->bound == PDD_BOUND) &&
+		    (kfd_is_first_node((p->pdds[i]->dev))))
 			amd_iommu_unbind_pasid(p->pdds[i]->dev->adev->pdev,
 					       p->pasid);
 }
@@ -281,7 +288,7 @@ void kfd_iommu_suspend(struct kfd_dev *kfd)
 	if (!kfd->use_iommu_v2)
 		return;
 
-	kfd_unbind_processes_from_device(kfd->node);
+	kfd_unbind_processes_from_device(kfd->nodes[0]);
 
 	amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
 	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
@@ -312,7 +319,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
 	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev,
 				     iommu_invalid_ppr_cb);
 
-	err = kfd_bind_processes_to_device(kfd->node);
+	err = kfd_bind_processes_to_device(kfd->nodes[0]);
 	if (err) {
 		amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
 		amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 1e187677c90a..5f4dc2a45bd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -423,7 +423,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				      0, adev->kfd.dev->node->id, prange->prefetch_loc,
+				      0, adev->kfd.dev->nodes[0]->id, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
 
 	r = migrate_vma_setup(&migrate);
@@ -456,7 +456,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    0, adev->kfd.dev->node->id, trigger);
+				    0, adev->kfd.dev->nodes[0]->id, trigger);
 
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 	svm_range_free_dma_mappings(prange);
@@ -701,7 +701,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
 				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				      adev->kfd.dev->node->id, 0, prange->prefetch_loc,
+				      adev->kfd.dev->nodes[0]->id, 0, prange->prefetch_loc,
 				      prange->preferred_loc, trigger);
 
 	r = migrate_vma_setup(&migrate);
@@ -737,7 +737,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-				    adev->kfd.dev->node->id, 0, trigger);
+				    adev->kfd.dev->nodes[0]->id, 0, trigger);
 
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index fdb97e5d0c01..873b49238dc1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -255,6 +255,8 @@ struct kfd_vmid_info {
 	uint32_t vmid_num_kfd;
 };
 
+#define MAX_KFD_NODES	8
+
 struct kfd_dev;
 
 struct kfd_node {
@@ -267,6 +269,10 @@ struct kfd_node {
 					      */
 	struct kfd_vmid_info vm_info;
 	unsigned int id;                /* topology stub index */
+	unsigned int num_xcc_per_node;
+	unsigned int start_xcc_id;	/* Starting XCC instance
+					 * number for the node
+					 */
 	/* Interrupts */
 	struct kfifo ih_fifo;
 	struct workqueue_struct *ih_wq;
@@ -300,6 +306,8 @@ struct kfd_node {
 	/* Maximum process number mapped to HW scheduler */
 	unsigned int max_proc_per_quantum;
 
+	unsigned int compute_vmid_bitmap;
+
 	struct kfd_dev *kfd;
 };
 
@@ -368,7 +376,8 @@ struct kfd_dev {
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
 
-	struct kfd_node *node;
+	struct kfd_node *nodes[MAX_KFD_NODES];
+	unsigned int num_nodes;
 };
 
 enum kfd_mempool {
@@ -1397,6 +1406,11 @@ static inline int kfd_devcgroup_check_permission(struct kfd_node *kfd)
 #endif
 }
 
+static inline bool kfd_is_first_node(struct kfd_node *node)
+{
+	return (node == node->kfd->nodes[0]);
+}
+
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index a0bf6558f4ac..b703da59e067 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -254,17 +254,17 @@ void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts)
 {
-	kfd_smi_event_add(pid, dev->node, KFD_SMI_EVENT_PAGE_FAULT_START,
+	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_PAGE_FAULT_START,
 			  "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
-			  address, dev->node->id, write_fault ? 'W' : 'R');
+			  address, dev->nodes[0]->id, write_fault ? 'W' : 'R');
 }
 
 void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
 				  unsigned long address, bool migration)
 {
-	kfd_smi_event_add(pid, dev->node, KFD_SMI_EVENT_PAGE_FAULT_END,
+	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_PAGE_FAULT_END,
 			  "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
-			  pid, address, dev->node->id, migration ? 'M' : 'U');
+			  pid, address, dev->nodes[0]->id, migration ? 'M' : 'U');
 }
 
 void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
@@ -273,7 +273,7 @@ void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
 				   uint32_t prefetch_loc, uint32_t preferred_loc,
 				   uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->node, KFD_SMI_EVENT_MIGRATE_START,
+	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_MIGRATE_START,
 			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
 			  ktime_get_boottime_ns(), pid, start, end - start,
 			  from, to, prefetch_loc, preferred_loc, trigger);
@@ -283,7 +283,7 @@ void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
 				 unsigned long start, unsigned long end,
 				 uint32_t from, uint32_t to, uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->node, KFD_SMI_EVENT_MIGRATE_END,
+	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_MIGRATE_END,
 			  "%lld -%d @%lx(%lx) %x->%x %d\n",
 			  ktime_get_boottime_ns(), pid, start, end - start,
 			  from, to, trigger);
@@ -292,16 +292,16 @@ void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
 void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->node, KFD_SMI_EVENT_QUEUE_EVICTION,
+	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_QUEUE_EVICTION,
 			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
-			  dev->node->id, trigger);
+			  dev->nodes[0]->id, trigger);
 }
 
 void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid)
 {
-	kfd_smi_event_add(pid, dev->node, KFD_SMI_EVENT_QUEUE_RESTORE,
+	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_QUEUE_RESTORE,
 			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
-			  dev->node->id);
+			  dev->nodes[0]->id);
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -328,9 +328,9 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
 				  unsigned long address, unsigned long last,
 				  uint32_t trigger)
 {
-	kfd_smi_event_add(pid, dev->node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
+	kfd_smi_event_add(pid, dev->nodes[0], KFD_SMI_EVENT_UNMAP_FROM_GPU,
 			  "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
-			  pid, address, last - address + 1, dev->node->id, trigger);
+			  pid, address, last - address + 1, dev->nodes[0]->id, trigger);
 }
 
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 06a11186d947..94af37df3ed2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -555,7 +555,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->gpu->kfd->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
 				      dev->gpu->adev->unique_id);
-
+		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
+				      dev->gpu->num_xcc_per_node);
 	}
 
 	return sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_ccompute",
@@ -1160,7 +1161,7 @@ void kfd_topology_shutdown(void)
 static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 {
 	uint32_t hashout;
-	uint32_t buf[7];
+	uint32_t buf[8];
 	uint64_t local_mem_size;
 	int i;
 
@@ -1177,8 +1178,9 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	buf[4] = gpu->adev->pdev->bus->number;
 	buf[5] = lower_32_bits(local_mem_size);
 	buf[6] = upper_32_bits(local_mem_size);
+	buf[7] = gpu->start_xcc_id | (gpu->num_xcc_per_node << 16);
 
-	for (i = 0, hashout = 0; i < 7; i++)
+	for (i = 0, hashout = 0; i < 8; i++)
 		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
 
 	return hashout;
-- 
2.39.2

