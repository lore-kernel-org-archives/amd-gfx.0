Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2664AC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0A510E3ED;
	Tue,  9 May 2023 22:14:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5CC10E3F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANnrshWvMIe0PyCvSo/yOMzt6Wg/0yN+XqsecpZdfI5q0ZOpAZWqARr0qhO6c/Thq1y6VB9C148xsl2iVmabfCNJiV7uGCc2XTxFdVwUQgKAbdkOW0KP8nP8gr0I+A4dOvaLefEWqKwumy0R2R3Ne/SyfQQCWlAOEShCPCXonJf5Qs1L3KGn0EGy3vvob8tqYO4YKc/ggZvT03A4IlBEvdj95GjgeAmLRoq892kAYo1QE85VCltuQr1SgLJgmwnTOJ2spJ5AVfLJGMS4jCvbLDxwSm517mn29iQu2YEYHMKaU/3Sfrho7M4ME9DNhBMuqgxhlpATgeCxLGREROQcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5aW+L/pS+mcaBUTj2h2GUdOlmEGUHqgo4tdunCJMIw=;
 b=Qb2QmkLVLHi+9TmFg8tMwVTqJpzPmknfXimv5ZRrktqquEbUPFPUcldFcu7tpb5S/+wsBAKiU9djv/04GzPTotC4Ix/qGXzRd33DiBrPhk1qpcHZOWM9Q4x+gj7Ls1lY9sJ/qbWMhk53Sv9Hi2ztPv2PYq86uF95sbaGIz/H7KRIQQJGgm7HQVN7EEiyMNgoA4nbF7Ya8FggM6Hq6nCLf8HZvLrIlPmdhkDkQjTxvsQWnag0D6DNSIR82UYdGoNGnHTM7fdkXyhYBFnYFu68a4RKvsMTfTZ37/qp1MXaqzPBACLCWF0Va3XJVvZUjVlxBHPLOtGh8aJb5IujUPuK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5aW+L/pS+mcaBUTj2h2GUdOlmEGUHqgo4tdunCJMIw=;
 b=G3R2VtJaIVZRNXv1b6TuZRY0lPZ/0z6dLCpGM9aaNPuJAhE8FOoG2i2lv1uCINjC0CJz/yW5VeDuZJNFCzomRCqnBFwXd7XylP4RRmQSvbnNGWUKWmI+F/tyFAt0gxR9wsRgosaxu1PTyfUilRrBMZEjetvf5umJfmiHPNsoXAU=
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:14:30 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::95) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amdkfd: Use xcc mask for identifying xcc
Date: Tue, 9 May 2023 18:14:06 -0400
Message-ID: <20230509221408.476829-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a12ad3e-45ee-4106-5fcf-08db50dac25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ce12zan2LJhc+6Mbfy+YL1IkVWv3atK+/pIgFllrut8BdN4pMvIE2alSAbQp+mHZJ3idEXcnHmBiNykH9Hq41F7O1xSL9Tqc2B27J9iqVIpnzaTr72ZL+XFiO6Z9ZroNcHLnWVERtv0MsCnCqt0jkb9Xd/TI4Fedc91RbZLCM4JKxcclJxKKVCn+8NDPPfBnP4GnrcmnO6t5p85BXuQhfzarwZOKTzOUhPJj+l/VT0ZbrWnxJtupHd8Ni4kklPLVJQNNBXjki36SMEtmVZpF0ehRtCztSSjwudXlqHYlOTDNq5gkLLW0/GXx9GwOSiVbkb2YpDC+SAAbr1SFAls/vnIFVEhjuO7Yu+Jnu/U/nP0Q6HV/nRvZuYjzHRfSuoRo5wDffSvamSdnZ9XE7QrQ6rNT7yQosHme5ssCh/Qx4fbQt8oj/UPO+hQddSB11gyzf46U/CQorfhyi3gQ3W9qDpLx6/qaHKRZyZo7pGHIPYbd89xjsKp6bhGAgoEEnBDnOXqhq53KTetTMeXjWz+GVMRKPPXobgTpoXL+1qwutglNc7AnhrPAFML9GAVIfS2/woNAXH09ndkAL5n43uTtT+qXznBi61nlYyjN9c/+sdyAhJ3FqO7vt4PwUaoLODGxFaVy/YQT/5AP1uezQ1bpbsrQStavNtNopWZZe/us0zCJ5hidnhXY+NgmTUhzJay7tszmB08AwecuvfkBFgpK9rmDyr6ZGwNihsN0S5vzfw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(336012)(426003)(47076005)(16526019)(186003)(2616005)(2906002)(30864003)(83380400001)(36756003)(86362001)(82310400005)(81166007)(82740400003)(356005)(36860700001)(40480700001)(5660300002)(8676002)(8936002)(70586007)(70206006)(4326008)(6916009)(41300700001)(6666004)(7696005)(478600001)(316002)(54906003)(26005)(66899021)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:29.6580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a12ad3e-45ee-4106-5fcf-08db50dac25d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Instead of start xcc id and number of xcc per node, use the xcc mask
which is the mask of logical ids of xccs belonging to a parition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  9 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 86 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 71 +++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  8 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  8 +-
 8 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 647c3313c27e..b5497d2ee984 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -745,15 +745,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		node->vm_info.vmid_num_kfd = vmid_num_kfd;
 		node->xcp = amdgpu_get_next_xcp(kfd->adev->xcp_mgr, &xcp_idx);
 		/* TODO : Check if error handling is needed */
-		if (node->xcp)
+		if (node->xcp) {
 			amdgpu_xcp_get_inst_details(node->xcp, AMDGPU_XCP_GFX,
 						    &node->xcc_mask);
-		else
+			++xcp_idx;
+		} else {
 			node->xcc_mask =
 				(1U << NUM_XCC(kfd->adev->gfx.xcc_mask)) - 1;
-
-		node->num_xcc_per_node = max(1U, kfd->adev->gfx.num_xcc_per_xcp);
-		node->start_xcc_id = node->num_xcc_per_node * i;
+		}
 
 		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
 		    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2b5c4b2dd242..493b4b66f180 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -136,16 +136,14 @@ static void init_sdma_bitmaps(struct device_queue_manager *dqm)
 void program_sh_mem_settings(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
-	int xcc = 0;
+	uint32_t xcc_mask = dqm->dev->xcc_mask;
+	int xcc_id;
 
-	for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++)
+	for_each_inst(xcc_id, xcc_mask)
 		dqm->dev->kfd2kgd->program_sh_mem_settings(
-						dqm->dev->adev, qpd->vmid,
-						qpd->sh_mem_config,
-						qpd->sh_mem_ape1_base,
-						qpd->sh_mem_ape1_limit,
-						qpd->sh_mem_bases,
-						dqm->dev->start_xcc_id + xcc);
+			dqm->dev->adev, qpd->vmid, qpd->sh_mem_config,
+			qpd->sh_mem_ape1_base, qpd->sh_mem_ape1_limit,
+			qpd->sh_mem_bases, xcc_id);
 }
 
 static void kfd_hws_hang(struct device_queue_manager *dqm)
@@ -427,14 +425,14 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 static void program_trap_handler_settings(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd)
 {
-	int xcc = 0;
+	uint32_t xcc_mask = dqm->dev->xcc_mask;
+	int xcc_id;
 
 	if (dqm->dev->kfd2kgd->program_trap_handler_settings)
-		for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++)
+		for_each_inst(xcc_id, xcc_mask)
 			dqm->dev->kfd2kgd->program_trap_handler_settings(
-						dqm->dev->adev, qpd->vmid,
-						qpd->tba_addr, qpd->tma_addr,
-						dqm->dev->start_xcc_id + xcc);
+				dqm->dev->adev, qpd->vmid, qpd->tba_addr,
+				qpd->tma_addr, xcc_id);
 }
 
 static int allocate_vmid(struct device_queue_manager *dqm,
@@ -697,7 +695,8 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 	struct kfd_process_device *pdd;
 	int first_vmid_to_scan = dev->vm_info.first_vmid_kfd;
 	int last_vmid_to_scan = dev->vm_info.last_vmid_kfd;
-	int xcc = 0;
+	uint32_t xcc_mask = dev->xcc_mask;
+	int xcc_id;
 
 	reg_sq_cmd.u32All = 0;
 	reg_gfx_index.u32All = 0;
@@ -742,11 +741,10 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 	reg_sq_cmd.bits.cmd = SQ_IND_CMD_CMD_KILL;
 	reg_sq_cmd.bits.vm_id = vmid;
 
-	for (xcc = 0; xcc < dev->num_xcc_per_node; xcc++)
-		dev->kfd2kgd->wave_control_execute(dev->adev,
-					reg_gfx_index.u32All,
-					reg_sq_cmd.u32All,
-					dev->start_xcc_id + xcc);
+	for_each_inst(xcc_id, xcc_mask)
+		dev->kfd2kgd->wave_control_execute(
+			dev->adev, reg_gfx_index.u32All,
+			reg_sq_cmd.u32All, xcc_id);
 
 	return 0;
 }
@@ -1258,12 +1256,12 @@ static int
 set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
 			unsigned int vmid)
 {
-	int xcc = 0, ret;
+	uint32_t xcc_mask = dqm->dev->xcc_mask;
+	int xcc_id, ret;
 
-	for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++) {
+	for_each_inst(xcc_id, xcc_mask) {
 		ret = dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
-						dqm->dev->adev, pasid, vmid,
-						dqm->dev->start_xcc_id + xcc);
+			dqm->dev->adev, pasid, vmid, xcc_id);
 		if (ret)
 			break;
 	}
@@ -1273,15 +1271,14 @@ set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
 
 static void init_interrupts(struct device_queue_manager *dqm)
 {
-	unsigned int i, xcc;
+	uint32_t xcc_mask = dqm->dev->xcc_mask;
+	unsigned int i, xcc_id;
 
 	for (i = 0 ; i < get_pipes_per_mec(dqm) ; i++) {
 		if (is_pipe_enabled(dqm, 0, i)) {
-			for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++)
+			for_each_inst(xcc_id, xcc_mask)
 				dqm->dev->kfd2kgd->init_interrupts(
-							dqm->dev->adev, i,
-							dqm->dev->start_xcc_id +
-							xcc);
+					dqm->dev->adev, i, xcc_id);
 		}
 	}
 }
@@ -2283,7 +2280,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 		get_num_all_sdma_engines(dqm) *
 		dev->kfd->device_info.num_sdma_queues_per_engine +
 		(dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
-		dqm->dev->num_xcc_per_node);
+		NUM_XCC(dqm->dev->xcc_mask));
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
@@ -2489,10 +2486,10 @@ static void seq_reg_dump(struct seq_file *m,
 int dqm_debugfs_hqds(struct seq_file *m, void *data)
 {
 	struct device_queue_manager *dqm = data;
+	uint32_t xcc_mask = dqm->dev->xcc_mask;
 	uint32_t (*dump)[2], n_regs;
 	int pipe, queue;
-	int r = 0, xcc;
-	uint32_t inst;
+	int r = 0, xcc_id;
 	uint32_t sdma_engine_start;
 
 	if (!dqm->sched_running) {
@@ -2500,16 +2497,18 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 		return 0;
 	}
 
-	for (xcc = 0; xcc < dqm->dev->num_xcc_per_node; xcc++) {
-		inst = dqm->dev->start_xcc_id + xcc;
+	for_each_inst(xcc_id, xcc_mask) {
 		r = dqm->dev->kfd2kgd->hqd_dump(dqm->dev->adev,
-					KFD_CIK_HIQ_PIPE, KFD_CIK_HIQ_QUEUE,
-					&dump, &n_regs, inst);
+						KFD_CIK_HIQ_PIPE,
+						KFD_CIK_HIQ_QUEUE, &dump,
+						&n_regs, xcc_id);
 		if (!r) {
-			seq_printf(m,
+			seq_printf(
+				m,
 				"   Inst %d, HIQ on MEC %d Pipe %d Queue %d\n",
-				inst, KFD_CIK_HIQ_PIPE/get_pipes_per_mec(dqm)+1,
-				KFD_CIK_HIQ_PIPE%get_pipes_per_mec(dqm),
+				xcc_id,
+				KFD_CIK_HIQ_PIPE / get_pipes_per_mec(dqm) + 1,
+				KFD_CIK_HIQ_PIPE % get_pipes_per_mec(dqm),
 				KFD_CIK_HIQ_QUEUE);
 			seq_reg_dump(m, dump, n_regs);
 
@@ -2524,13 +2523,16 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 				      dqm->dev->kfd->shared_resources.cp_queue_bitmap))
 					continue;
 
-				r = dqm->dev->kfd2kgd->hqd_dump(
-					dqm->dev->adev, pipe, queue, &dump, &n_regs, inst);
+				r = dqm->dev->kfd2kgd->hqd_dump(dqm->dev->adev,
+								pipe, queue,
+								&dump, &n_regs,
+								xcc_id);
 				if (r)
 					break;
 
-				seq_printf(m, " Inst %d,  CP Pipe %d, Queue %d\n",
-					  inst, pipe, queue);
+				seq_printf(m,
+					   " Inst %d,  CP Pipe %d, Queue %d\n",
+					   xcc_id, pipe, queue);
 				seq_reg_dump(m, dump, n_regs);
 
 				kfree(dump);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index d81125421aaf..863cf060af48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -77,7 +77,7 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
 		dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
 
 	offset += dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
-		  dev->num_xcc_per_node;
+		  NUM_XCC(dev->xcc_mask);
 
 	mqd_mem_obj->gtt_mem = (void *)((uint64_t)dev->dqm->hiq_sdma_mqd.gtt_mem
 				+ offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ac978141ebea..224da5783724 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -128,7 +128,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 		retval = amdgpu_amdkfd_alloc_gtt_mem(node->adev,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
-			node->num_xcc_per_node,
+			NUM_XCC(node->xcc_mask),
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
@@ -481,7 +481,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
 
 	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
 
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
 		kfd_get_hiq_xcc_mqd(mm->dev, &xcc_mqd_mem_obj, xcc);
 
 		init_mqd(mm, (void **)&m, &xcc_mqd_mem_obj, &xcc_gart_addr, q);
@@ -505,21 +505,21 @@ static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager *mm, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id,
 			struct queue_properties *p, struct mm_struct *mms)
 {
-	int xcc, err;
+	uint32_t xcc_mask = mm->dev->xcc_mask;
+	int xcc_id, err, inst = 0;
 	void *xcc_mqd;
-	uint32_t start_inst = mm->dev->start_xcc_id;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
-		xcc_mqd = mqd + hiq_mqd_size * xcc;
+	for_each_inst(xcc_id, xcc_mask) {
+		xcc_mqd = mqd + hiq_mqd_size * inst;
 		err = mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, xcc_mqd,
 						     pipe_id, queue_id,
-						     p->doorbell_off,
-						     start_inst+xcc);
+						     p->doorbell_off, xcc_id);
 		if (err) {
-			pr_debug("Failed to load HIQ MQD for XCC: %d\n", xcc);
+			pr_debug("Failed to load HIQ MQD for XCC: %d\n", inst);
 			break;
 		}
+		++inst;
 	}
 
 	return err;
@@ -529,20 +529,21 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 			enum kfd_preempt_type type, unsigned int timeout,
 			uint32_t pipe_id, uint32_t queue_id)
 {
-	int xcc = 0, err;
+	uint32_t xcc_mask = mm->dev->xcc_mask;
+	int xcc_id, err, inst = 0;
 	void *xcc_mqd;
-	uint32_t start_inst = mm->dev->start_xcc_id;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
-		xcc_mqd = mqd + hiq_mqd_size * xcc;
+	for_each_inst(xcc_id, xcc_mask) {
+		xcc_mqd = mqd + hiq_mqd_size * inst;
 		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
 						    type, timeout, pipe_id,
-						    queue_id, start_inst+xcc);
+						    queue_id, xcc_id);
 		if (err) {
-			pr_debug("Destroy MQD failed for xcc: %d\n", xcc);
+			pr_debug("Destroy MQD failed for xcc: %d\n", inst);
 			break;
 		}
+		++inst;
 	}
 
 	return err;
@@ -572,7 +573,7 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 	uint32_t local_xcc_start = mm->dev->dqm->current_logical_xcc_start++;
 
 	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
 		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset*xcc);
 
 		init_mqd(mm, (void **)&m, &xcc_mqd_mem_obj, &xcc_gart_addr, q);
@@ -599,7 +600,7 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 			m->compute_tg_chunk_size = 1;
 			m->compute_current_logic_xcc_id =
 					(local_xcc_start + xcc) %
-					mm->dev->num_xcc_per_node;
+					NUM_XCC(mm->dev->xcc_mask);
 
 			switch (xcc) {
 			case 0:
@@ -632,7 +633,7 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	int xcc = 0;
 	uint64_t size = mm->mqd_stride(mm, q);
 
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
 		m = get_mqd(mqd + size * xcc);
 		update_mqd(mm, m, q, minfo);
 
@@ -660,24 +661,25 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   enum kfd_preempt_type type, unsigned int timeout,
 		   uint32_t pipe_id, uint32_t queue_id)
 {
-	int xcc = 0, err;
+	uint32_t xcc_mask = mm->dev->xcc_mask;
+	int xcc_id, err, inst = 0;
 	void *xcc_mqd;
 	struct v9_mqd *m;
 	uint64_t mqd_offset;
-	uint32_t start_inst = mm->dev->start_xcc_id;
 
 	m = get_mqd(mqd);
 	mqd_offset = m->cp_mqd_stride_size;
 
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
-		xcc_mqd = mqd + mqd_offset * xcc;
+	for_each_inst(xcc_id, xcc_mask) {
+		xcc_mqd = mqd + mqd_offset * inst;
 		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
 						    type, timeout, pipe_id,
-						    queue_id, start_inst+xcc);
+						    queue_id, xcc_id);
 		if (err) {
-			pr_debug("Destroy MQD failed for xcc: %d\n", xcc);
+			pr_debug("Destroy MQD failed for xcc: %d\n", inst);
 			break;
 		}
+		++inst;
 	}
 
 	return err;
@@ -689,21 +691,22 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 {
 	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
-	int xcc = 0, err;
+	uint32_t xcc_mask = mm->dev->xcc_mask;
+	int xcc_id, err, inst = 0;
 	void *xcc_mqd;
-	uint32_t start_inst = mm->dev->start_xcc_id;
 	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
 
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
-		xcc_mqd = mqd + mqd_stride_size * xcc;
-		err = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, xcc_mqd,
-					 pipe_id, queue_id,
-					(uint32_t __user *)p->write_ptr,
-					wptr_shift, 0, mms, start_inst+xcc);
+	for_each_inst(xcc_id, xcc_mask) {
+		xcc_mqd = mqd + mqd_stride_size * inst;
+		err = mm->dev->kfd2kgd->hqd_load(
+			mm->dev->adev, xcc_mqd, pipe_id, queue_id,
+			(uint32_t __user *)p->write_ptr, wptr_shift, 0, mms,
+			xcc_id);
 		if (err) {
-			pr_debug("Load MQD failed for xcc: %d\n", xcc);
+			pr_debug("Load MQD failed for xcc: %d\n", inst);
 			break;
 		}
+		++inst;
 	}
 
 	return err;
@@ -721,7 +724,7 @@ static int get_wave_state_v9_4_3(struct mqd_manager *mm, void *mqd,
 	uint64_t mqd_stride_size = mm->mqd_stride(mm, q);
 	u32 tmp_ctl_stack_used_size = 0, tmp_save_area_used_size = 0;
 
-	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
 		xcc_mqd = mqd + mqd_stride_size * xcc;
 		xcc_ctl_stack = (void __user *)((uintptr_t)ctl_stack +
 					q->ctx_save_restore_area_size * xcc);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 559ac5efdc26..02a90fd7f646 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -274,10 +274,6 @@ struct kfd_node {
 					      */
 	struct kfd_vmid_info vm_info;
 	unsigned int id;                /* topology stub index */
-	unsigned int num_xcc_per_node;
-	unsigned int start_xcc_id;	/* Starting XCC instance
-					 * number for the node
-					 */
 	uint32_t xcc_mask; /* Instance mask of XCCs present */
 	struct amdgpu_xcp *xcp;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a9103326157..c2c7d34fd46d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2058,6 +2058,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
 	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	struct kfd_node *dev = pdd->dev;
+	uint32_t xcc_mask = dev->xcc_mask;
 	int xcc = 0;
 
 	/*
@@ -2076,10 +2077,9 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->adev,
 							pdd->qpd.vmid);
 	} else {
-		for (xcc = 0; xcc < dev->num_xcc_per_node; xcc++)
-			amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
-					pdd->process->pasid, type,
-					dev->start_xcc_id + xcc);
+		for_each_inst(xcc, xcc_mask)
+			amdgpu_amdkfd_flush_gpu_tlb_pasid(
+				dev->adev, pdd->process->pasid, type, xcc);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 2b2ae0c9902b..a3c23d07c7df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -946,7 +946,7 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 				seq_printf(m, "  Compute queue on device %x\n",
 					   q->device->id);
 				mqd_type = KFD_MQD_TYPE_CP;
-				num_xccs = q->device->num_xcc_per_node;
+				num_xccs = NUM_XCC(q->device->xcc_mask);
 				break;
 			default:
 				seq_printf(m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c7072fff778e..d2a42b6b1fa8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -469,7 +469,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.cpu_cores_count);
 	sysfs_show_32bit_prop(buffer, offs, "simd_count",
 			      dev->gpu ? (dev->node_props.simd_count *
-					  dev->gpu->num_xcc_per_node) : 0);
+					  NUM_XCC(dev->gpu->xcc_mask)) : 0);
 	sysfs_show_32bit_prop(buffer, offs, "mem_banks_count",
 			      dev->node_props.mem_banks_count);
 	sysfs_show_32bit_prop(buffer, offs, "caches_count",
@@ -494,7 +494,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.wave_front_size);
 	sysfs_show_32bit_prop(buffer, offs, "array_count",
 			      dev->gpu ? (dev->node_props.array_count *
-					  dev->gpu->num_xcc_per_node) : 0);
+					  NUM_XCC(dev->gpu->xcc_mask)) : 0);
 	sysfs_show_32bit_prop(buffer, offs, "simd_arrays_per_engine",
 			      dev->node_props.simd_arrays_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "cu_per_simd_array",
@@ -558,7 +558,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
 				      dev->gpu->adev->unique_id);
 		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
-				      dev->gpu->num_xcc_per_node);
+				      NUM_XCC(dev->gpu->xcc_mask));
 	}
 
 	return sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_ccompute",
@@ -1180,7 +1180,7 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	buf[4] = gpu->adev->pdev->bus->number;
 	buf[5] = lower_32_bits(local_mem_size);
 	buf[6] = upper_32_bits(local_mem_size);
-	buf[7] = gpu->start_xcc_id | (gpu->num_xcc_per_node << 16);
+	buf[7] = (ffs(gpu->xcc_mask) - 1) | (NUM_XCC(gpu->xcc_mask) << 16);
 
 	for (i = 0, hashout = 0; i < 8; i++)
 		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
-- 
2.40.1

