Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4B8C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4922310E90A;
	Tue, 28 Mar 2023 15:14:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2DB10E908
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0FsMB9fVkMgQb7+VH0UU0kVmPtWcMuKYFYtFgDyR8V9FhxafwYWKvovygx8OhZovQ9pOMq/xguEHS9caHhdMXW0hD1tvIleRGHSsIV950WdBPC5RCIkqufIVdsQ+n5icxEgOQl3FtqxoRmMhXuKA8aLJqCYdGDM56iTaAcFQ/SRkg+fD0PaOV1ruFwblGiY3LkXwDFpjrjhcjgJM25F5aX/IkFZMxAkXSV06DBR+Auu0d5fmH6Sz3+FQWS1M9IdQfDfXECYcNtfpjZPKIwiWM2NKJXu2OkahbSDqTnCFy4nDGDO+ru0wzpqKlaC+eEnu00i+A28JFI1grEr3N8R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdOzfPGsdt5APsnYkzqv+b6s0JQe2mgSMDYNYBus/Oo=;
 b=jJdASRVlzHMbSiV3KM/h21c5ESXMN0jqKb8K2VqV0+ju59R6BIZJdL8R+7km8gCnwVTUmjRuzA+QbMZ3zEIXxJPNLnjE2es2BDvR26oSVGZdAcV/dfH8MaYDz/Q3iNT2Q4zCw2EFn74Ub3nct8iadZrhqv8GjDive2nexHteBvTA0tBmzBpNFXD2VtKDo6cllrLPnBpZDL7o08s3fsu8WH4lGdfVQbuPSbxmtdUysUB9Ky4GPBkT3IVImad64kHdxYFrDNdt1Fo+hdxn/eij0oqLB+i4xKDktEbreo0suhi9Ur8kP2DFa0UCRY1vgPRJBnCw7Gl3O7h+b9CC4W2BsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdOzfPGsdt5APsnYkzqv+b6s0JQe2mgSMDYNYBus/Oo=;
 b=xK9lKBFvv56P173GTBLrP5vSm/LfskDRLbwausdV6yIuPBLIkr5PhWjggKkIK40aBnp5wqZOO6feptHfJa/rWc2AU9I2oWakyACC4W0ue65gjfCJ2bJpjoycAk806WRmuV0QYGOXqNqDxWPYEJQjYXUbkzZGpiPF7tKKULaU9Os=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 15:14:36 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::4d) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 15:14:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/32] drm/amdkfd: Update MQD management on multi XCC setup
Date: Tue, 28 Mar 2023 11:13:20 -0400
Message-ID: <20230328151344.1934291-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 51faf9d2-ddc7-40a6-4889-08db2f9f248a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPFTHKMnoz8fJxi84Ra/ELkr7mO3KZspyUFNLqWouk5itmvSXpmSn0D9Ik0ExM+R99hvdTrVQrCxqeeB22FysCtukOlfVxQ7PPGbaeRHi3V0tlLgWso4bBhm27n+jtrggMpufjnwiMVa2MPhK5xRkoeNSYvNYrV5hP35bF8PiV9JsagV6YRD9yMtf8h6mZV66DXeRDsjqPQsdw2MhEGX6xQna+yL1Dil+5APcsSfLCZUJ3f2enIuLWMa8h8nhJ/yThgXfo1Q+HLhOQThZX6e7rJ0UYl61UwQFZqJKmZeINK5+1aOPjENQl+GyoGFySmF5tkplrJWDsTmFyKmYFFLQcgtTPs9hUV6Bf+maUS5oNRv7UgAwpx92F492swjEPrTGFQF5XSfOdbhspKl6RsqK8JatNt/JJLjPI6mAnaNluech7Y2//daUDf7TGzCCi4lZmvLUTV6x7t9uZ9XM1DxTxL9mo/3gBiBJEFwKUt8gC86tcm7/cwU6eccQF5g1SvVFCnYPHv8coIbkfUQBp/cV0OCYtHQGy478pNKCUJ9gXug8FDa4Bc3LzKwfTifdSv162DXbdlCKwFjzkkXU0FSiqlb1aRwTGXRnq7IfOgBoO0OK7JIwCOc0ufwsU5MZcxO262txpF9O7RnA3MOlz69XaTPhYqFedXRn/DXvff6mCijz1Zf5W3MHbPB2fskOuhoIXBErTMNQs0zrgX+kGbZAJrSydzl3I08xKNNJ5IhbCQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(70206006)(70586007)(86362001)(40480700001)(2906002)(6916009)(83380400001)(316002)(478600001)(36756003)(15650500001)(54906003)(82740400003)(40460700003)(16526019)(36860700001)(41300700001)(8676002)(26005)(82310400005)(2616005)(81166007)(5660300002)(30864003)(47076005)(4326008)(426003)(8936002)(1076003)(356005)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:36.2092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51faf9d2-ddc7-40a6-4889-08db2f9f248a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
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

Update MQD management for both HIQ and user-mode compute
queues on a multi XCC setup. MQDs needs to be allocated,
initialized, loaded and destroyed for each XCC in the KFD
node.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  51 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  28 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |   3 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |   3 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 292 ++++++++++++++++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |   3 +
 .../amd/amdkfd/kfd_process_queue_manager.c    |  16 +-
 drivers/gpu/drm/amd/include/v9_structs.h      |  30 +-
 10 files changed, 380 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ce34b73d05bc..a26e9009d4e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -804,6 +804,41 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
 	sg_free_table(ttm->sg);
 }
 
+/*
+ * total_pages is constructed as MQD0+CtrlStack0 + MQD1+CtrlStack1 + ...
+ * MQDn+CtrlStackn where n is the number of XCCs per partition.
+ * pages_per_xcc is the size of one MQD+CtrlStack. The first page is MQD
+ * and uses memory type default, UC. The rest of pages_per_xcc are
+ * Ctrl stack and modify their memory type to NC.
+ */
+static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
+				struct ttm_tt *ttm, uint64_t flags)
+{
+	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	uint64_t total_pages = ttm->num_pages;
+	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
+	uint64_t page_idx, pages_per_xcc = total_pages / num_xcc;
+	int i;
+	uint64_t ctrl_flags = (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
+			AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
+
+	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
+		/* MQD page: use default flags */
+		amdgpu_gart_bind(adev,
+				gtt->offset + (page_idx << PAGE_SHIFT),
+				1, &gtt->ttm.dma_address[page_idx], flags);
+		/*
+		 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
+		 * the second page of the BO onward.
+		 */
+		amdgpu_gart_bind(adev,
+				gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
+				pages_per_xcc - 1,
+				&gtt->ttm.dma_address[page_idx + 1],
+				ctrl_flags);
+	}
+}
+
 static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				 struct ttm_buffer_object *tbo,
 				 uint64_t flags)
@@ -816,21 +851,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		flags |= AMDGPU_PTE_TMZ;
 
 	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
-		uint64_t page_idx = 1;
-
-		amdgpu_gart_bind(adev, gtt->offset, page_idx,
-				 gtt->ttm.dma_address, flags);
-
-		/* The memory type of the first page defaults to UC. Now
-		 * modify the memory type to NC from the second page of
-		 * the BO onward.
-		 */
-		flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
-		flags |= AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
-
-		amdgpu_gart_bind(adev, gtt->offset + (page_idx << PAGE_SHIFT),
-				 ttm->num_pages - page_idx,
-				 &(gtt->ttm.dma_address[page_idx]), flags);
+		amdgpu_ttm_gart_bind_gfx9_mqd(adev, ttm, flags);
 	} else {
 		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
 				 gtt->ttm.dma_address, flags);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6ee17100c333..0f0a7d73fad3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2247,7 +2247,8 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
 		get_num_all_sdma_engines(dqm) *
 		dev->kfd->device_info.num_sdma_queues_per_engine +
-		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
+		(dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size +
+		dqm->dev->num_xcc_per_node);
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 61f6dd68c84b..074f6075ccc7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -76,7 +76,8 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
 		q->sdma_queue_id) *
 		dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
 
-	offset += dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
+	offset += dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
+		  dev->num_xcc_per_node;
 
 	mqd_mem_obj->gtt_mem = (void *)((uint64_t)dev->dqm->hiq_sdma_mqd.gtt_mem
 				+ offset);
@@ -246,3 +247,28 @@ bool kfd_is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 {
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
 }
+
+uint64_t kfd_hiq_mqd_stride(struct kfd_node *dev)
+{
+	return dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
+}
+
+void kfd_get_hiq_xcc_mqd(struct kfd_node *dev, struct kfd_mem_obj *mqd_mem_obj,
+		     uint32_t virtual_xcc_id)
+{
+	uint64_t offset;
+
+	offset = kfd_hiq_mqd_stride(dev) * virtual_xcc_id;
+
+	mqd_mem_obj->gtt_mem = (virtual_xcc_id == 0) ?
+			dev->dqm->hiq_sdma_mqd.gtt_mem : NULL;
+	mqd_mem_obj->gpu_addr = dev->dqm->hiq_sdma_mqd.gpu_addr + offset;
+	mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)
+				dev->dqm->hiq_sdma_mqd.cpu_ptr + offset);
+}
+
+uint64_t kfd_mqd_stride(struct mqd_manager *mm,
+			struct queue_properties *q)
+{
+	return mm->mqd_size;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 46fc3f273d0d..eb18be74f559 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -119,6 +119,8 @@ struct mqd_manager {
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
 	uint32_t (*read_doorbell_id)(void *mqd);
+	uint64_t (*mqd_stride)(struct mqd_manager *mm,
+				struct queue_properties *p);
 
 	struct mutex	mqd_mutex;
 	struct kfd_node	*dev;
@@ -164,4 +166,10 @@ bool kfd_is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 		uint64_t queue_address, uint32_t pipe_id,
 		uint32_t queue_id);
 
+void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
+		struct kfd_mem_obj *mqd_mem_obj, uint32_t virtual_xcc_id);
+
+uint64_t kfd_hiq_mqd_stride(struct kfd_node *dev);
+uint64_t kfd_mqd_stride(struct mqd_manager *mm,
+			struct queue_properties *q);
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 03e04d5e5a11..ca1966466759 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -428,6 +428,7 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct cik_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -442,6 +443,7 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct cik_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -457,6 +459,7 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
 		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct cik_sdma_rlc_registers);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 7a93be0ebb19..c9565ea99df5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -432,6 +432,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->get_wave_state = get_wave_state;
 		mqd->checkpoint_mqd = checkpoint_mqd;
 		mqd->restore_mqd = restore_mqd;
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -447,6 +448,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v10_compute_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -478,6 +480,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
 		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v10_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 007453e271d9..fa89606099b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -33,6 +33,21 @@
 #include "sdma0/sdma0_4_0_sh_mask.h"
 #include "amdgpu_amdkfd.h"
 
+static void update_mqd(struct mqd_manager *mm, void *mqd,
+		       struct queue_properties *q,
+		       struct mqd_update_info *minfo);
+
+static uint64_t mqd_stride_v9(struct mqd_manager *mm,
+				struct queue_properties *q)
+{
+	if (mm->dev->kfd->cwsr_enabled &&
+	    q->type == KFD_QUEUE_TYPE_COMPUTE)
+		return ALIGN(q->ctl_stack_size, PAGE_SIZE) +
+			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE);
+
+	return mm->mqd_size;
+}
+
 static inline struct v9_mqd *get_mqd(void *mqd)
 {
 	return (struct v9_mqd *)mqd;
@@ -110,8 +125,9 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 		if (!mqd_mem_obj)
 			return NULL;
 		retval = amdgpu_amdkfd_alloc_gtt_mem(node->adev,
-			ALIGN(q->ctl_stack_size, PAGE_SIZE) +
-				ALIGN(sizeof(struct v9_mqd), PAGE_SIZE),
+			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
+			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
+			node->num_xcc_per_node,
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
@@ -164,24 +180,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
 			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
 
-	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+	if (q->format == KFD_QUEUE_FORMAT_AQL)
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
-		if (KFD_GC_VERSION(mm->dev) == IP_VERSION(9, 4, 3)) {
-			/* On GC 9.4.3, DW 41 is re-purposed as
-			 * compute_tg_chunk_size.
-			 * TODO: review this setting when active CUs in the
-			 * partition play a role
-			 */
-			m->compute_static_thread_mgmt_se6 = 1;
-		}
-	} else {
-		/* PM4 queue */
-		if (KFD_GC_VERSION(mm->dev) == IP_VERSION(9, 4, 3)) {
-			m->compute_static_thread_mgmt_se6 = 0;
-			/* TODO: program pm4_target_xcc */
-		}
-	}
 
 	if (q->tba_addr) {
 		m->compute_pgm_rsrc2 |=
@@ -204,7 +205,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q, NULL);
+	update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
@@ -268,13 +269,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_vmid = q->vmid;
 
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
-		m->cp_hqd_pq_control |=
+		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
 				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT |
 				1 << CP_HQD_PQ_CONTROL__WPP_CLAMP_EN__SHIFT;
-		if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3))
-			m->cp_hqd_pq_control |=
-				CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK;
 		m->cp_hqd_pq_doorbell_control |= 1 <<
 			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
 	}
@@ -465,6 +463,224 @@ static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	qp->is_active = 0;
 }
 
+static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *q)
+{
+	struct v9_mqd *m;
+	int xcc = 0;
+	struct kfd_mem_obj xcc_mqd_mem_obj;
+	uint64_t xcc_gart_addr = 0;
+
+	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
+
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		kfd_get_hiq_xcc_mqd(mm->dev, &xcc_mqd_mem_obj, xcc);
+
+		init_mqd(mm, (void **)&m, &xcc_mqd_mem_obj, &xcc_gart_addr, q);
+
+		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
+					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
+					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
+		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
+		if (xcc == 0) {
+			/* Set no_update_rptr = 0 in Master XCC */
+			m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK;
+
+			/* Set the MQD pointer and gart address to XCC0 MQD */
+			*mqd = m;
+			*gart_addr = xcc_gart_addr;
+		}
+	}
+}
+
+static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager *mm, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			struct queue_properties *p, struct mm_struct *mms)
+{
+	int xcc, err;
+	void *xcc_mqd;
+	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
+
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		xcc_mqd = mqd + hiq_mqd_size * xcc;
+		err = mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, xcc_mqd,
+						     pipe_id, queue_id,
+						     p->doorbell_off);
+		if (err) {
+			pr_debug("Failed to load HIQ MQD for XCC: %d\n", xcc);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
+			enum kfd_preempt_type type, unsigned int timeout,
+			uint32_t pipe_id, uint32_t queue_id)
+{
+	int xcc = 0, err;
+	void *xcc_mqd;
+	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
+
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		xcc_mqd = mqd + hiq_mqd_size * xcc;
+		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
+						    type, timeout, pipe_id,
+						    queue_id);
+		if (err) {
+			pr_debug("Destroy MQD failed for xcc: %d\n", xcc);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
+			       struct kfd_mem_obj *xcc_mqd_mem_obj,
+			       uint64_t offset)
+{
+	xcc_mqd_mem_obj->gtt_mem = (offset == 0) ?
+					mqd_mem_obj->gtt_mem : NULL;
+	xcc_mqd_mem_obj->gpu_addr = mqd_mem_obj->gpu_addr + offset;
+	xcc_mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)mqd_mem_obj->cpu_ptr
+						+ offset);
+}
+
+static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *q)
+{
+	struct v9_mqd *m;
+	int xcc = 0;
+	struct kfd_mem_obj xcc_mqd_mem_obj;
+	uint64_t xcc_gart_addr = 0;
+	uint64_t offset = mm->mqd_stride(mm, q);
+
+	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset*xcc);
+
+		init_mqd(mm, (void **)&m, &xcc_mqd_mem_obj, &xcc_gart_addr, q);
+
+		m->cp_mqd_stride_size = offset;
+		if (q->format == KFD_QUEUE_FORMAT_AQL) {
+			m->compute_tg_chunk_size = 1;
+
+			switch (xcc) {
+			case 0:
+				/* Master XCC */
+				m->cp_hqd_pq_control &=
+					~CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK;
+				m->compute_current_logic_xcc_id =
+					mm->dev->num_xcc_per_node - 1;
+				break;
+			default:
+				m->compute_current_logic_xcc_id =
+					xcc - 1;
+				break;
+			}
+		} else {
+			/* PM4 Queue */
+			m->compute_current_logic_xcc_id = 0;
+			m->compute_tg_chunk_size = 0;
+		}
+
+		if (xcc == 0) {
+			/* Set the MQD pointer and gart address to XCC0 MQD */
+			*mqd = m;
+			*gart_addr = xcc_gart_addr;
+		}
+	}
+}
+
+static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
+		      struct queue_properties *q, struct mqd_update_info *minfo)
+{
+	struct v9_mqd *m;
+	int xcc = 0;
+	uint64_t size = mm->mqd_stride(mm, q);
+
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		m = get_mqd(mqd + size * xcc);
+		update_mqd(mm, m, q, minfo);
+
+		if (q->format == KFD_QUEUE_FORMAT_AQL) {
+			switch (xcc) {
+			case 0:
+				/* Master XCC */
+				m->cp_hqd_pq_control &=
+					~CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK;
+				m->compute_current_logic_xcc_id =
+					mm->dev->num_xcc_per_node - 1;
+				break;
+			default:
+				m->compute_current_logic_xcc_id =
+					xcc - 1;
+				break;
+			}
+			m->compute_tg_chunk_size = 1;
+		} else {
+			/* PM4 Queue */
+			m->compute_current_logic_xcc_id = 0;
+			m->compute_tg_chunk_size = 0;
+		}
+	}
+}
+
+static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
+		   enum kfd_preempt_type type, unsigned int timeout,
+		   uint32_t pipe_id, uint32_t queue_id)
+{
+	int xcc = 0, err;
+	void *xcc_mqd;
+	struct v9_mqd *m;
+	uint64_t mqd_offset;
+
+	m = get_mqd(mqd);
+	mqd_offset = m->cp_mqd_stride_size;
+
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		xcc_mqd = mqd + mqd_offset * xcc;
+		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
+						    type, timeout, pipe_id,
+						    queue_id);
+		if (err) {
+			pr_debug("Destroy MQD failed for xcc: %d\n", xcc);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			struct queue_properties *p, struct mm_struct *mms)
+{
+	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
+	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
+	int xcc = 0, err;
+	void *xcc_mqd;
+	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
+
+	for (xcc = 0; xcc < mm->dev->num_xcc_per_node; xcc++) {
+		xcc_mqd = mqd + mqd_stride_size * xcc;
+		err = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, xcc_mqd,
+					 pipe_id, queue_id,
+					(uint32_t __user *)p->write_ptr,
+					wptr_shift, 0, mms);
+		if (err) {
+			pr_debug("Load MQD failed for xcc: %d\n", xcc);
+			break;
+		}
+	}
+
+	return err;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -500,34 +716,49 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 	switch (type) {
 	case KFD_MQD_TYPE_CP:
 		mqd->allocate_mqd = allocate_mqd;
-		mqd->init_mqd = init_mqd;
 		mqd->free_mqd = kfd_free_mqd_cp;
-		mqd->load_mqd = load_mqd;
-		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->get_wave_state = get_wave_state;
 		mqd->get_checkpoint_info = get_checkpoint_info;
 		mqd->checkpoint_mqd = checkpoint_mqd;
 		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
+		mqd->mqd_stride = mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
+		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
+			mqd->init_mqd = init_mqd_v9_4_3;
+			mqd->load_mqd = load_mqd_v9_4_3;
+			mqd->update_mqd = update_mqd_v9_4_3;
+			mqd->destroy_mqd = destroy_mqd_v9_4_3;
+		} else {
+			mqd->init_mqd = init_mqd;
+			mqd->load_mqd = load_mqd;
+			mqd->update_mqd = update_mqd;
+			mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		}
 		break;
 	case KFD_MQD_TYPE_HIQ:
 		mqd->allocate_mqd = allocate_hiq_mqd;
-		mqd->init_mqd = init_mqd_hiq;
 		mqd->free_mqd = free_mqd_hiq_sdma;
-		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v9_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
 		mqd->read_doorbell_id = read_doorbell_id;
+		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
+			mqd->init_mqd = init_mqd_hiq_v9_4_3;
+			mqd->load_mqd = hiq_load_mqd_kiq_v9_4_3;
+			mqd->destroy_mqd = destroy_hiq_mqd_v9_4_3;
+		} else {
+			mqd->init_mqd = init_mqd_hiq;
+			mqd->load_mqd = kfd_hiq_load_mqd_kiq;
+			mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		}
 		break;
 	case KFD_MQD_TYPE_DIQ:
 		mqd->allocate_mqd = allocate_mqd;
@@ -553,6 +784,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
 		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v9_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index f6b4a5686dcb..8736a3cdbe1e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -486,6 +486,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct vi_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -500,6 +501,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct vi_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -515,6 +517,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
 		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct vi_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5602498e713f..b1fb017b2ef8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -927,7 +927,9 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 	struct queue *q;
 	enum KFD_MQD_TYPE mqd_type;
 	struct mqd_manager *mqd_mgr;
-	int r = 0;
+	int r = 0, xcc, num_xccs = 1;
+	void *mqd;
+	uint64_t size = 0;
 
 	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
 		if (pqn->q) {
@@ -943,6 +945,7 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 				seq_printf(m, "  Compute queue on device %x\n",
 					   q->device->id);
 				mqd_type = KFD_MQD_TYPE_CP;
+				num_xccs = q->device->num_xcc_per_node;
 				break;
 			default:
 				seq_printf(m,
@@ -951,6 +954,8 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 				continue;
 			}
 			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
+			size = mqd_mgr->mqd_stride(mqd_mgr,
+							&q->properties);
 		} else if (pqn->kq) {
 			q = pqn->kq->queue;
 			mqd_mgr = pqn->kq->mqd_mgr;
@@ -972,9 +977,12 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 			continue;
 		}
 
-		r = mqd_mgr->debugfs_show_mqd(m, q->mqd);
-		if (r != 0)
-			break;
+		for (xcc = 0; xcc < num_xccs; xcc++) {
+			mqd = q->mqd + size * xcc;
+			r = mqd_mgr->debugfs_show_mqd(m, mqd);
+			if (r != 0)
+				break;
+		}
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
index a0c672889fe4..a2f81b9c38af 100644
--- a/drivers/gpu/drm/amd/include/v9_structs.h
+++ b/drivers/gpu/drm/amd/include/v9_structs.h
@@ -196,10 +196,20 @@ struct v9_mqd {
 	uint32_t compute_wave_restore_addr_lo;
 	uint32_t compute_wave_restore_addr_hi;
 	uint32_t compute_wave_restore_control;
-	uint32_t compute_static_thread_mgmt_se4;
-	uint32_t compute_static_thread_mgmt_se5;
-	uint32_t compute_static_thread_mgmt_se6;
-	uint32_t compute_static_thread_mgmt_se7;
+	union {
+		struct {
+			uint32_t compute_static_thread_mgmt_se4;
+			uint32_t compute_static_thread_mgmt_se5;
+			uint32_t compute_static_thread_mgmt_se6;
+			uint32_t compute_static_thread_mgmt_se7;
+		};
+		struct {
+			uint32_t compute_current_logic_xcc_id; // offset: 39  (0x27)
+			uint32_t compute_restart_cg_tg_id; // offset: 40  (0x28)
+			uint32_t compute_tg_chunk_size; // offset: 41  (0x29)
+			uint32_t compute_restore_tg_chunk_size; // offset: 42  (0x2A)
+		};
+	};
 	uint32_t reserved_43;
 	uint32_t reserved_44;
 	uint32_t reserved_45;
@@ -382,8 +392,16 @@ struct v9_mqd {
 	uint32_t iqtimer_pkt_dw29;
 	uint32_t iqtimer_pkt_dw30;
 	uint32_t iqtimer_pkt_dw31;
-	uint32_t reserved_225;
-	uint32_t reserved_226;
+	union {
+		struct {
+			uint32_t reserved_225;
+			uint32_t reserved_226;
+		};
+		struct {
+			uint32_t pm4_target_xcc_in_xcp; // offset: 225  (0xE1)
+			uint32_t cp_mqd_stride_size; // offset: 226  (0xE2)
+		};
+	};
 	uint32_t reserved_227;
 	uint32_t set_resources_header;
 	uint32_t set_resources_dw1;
-- 
2.39.2

