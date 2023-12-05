Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA6FC4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Dec 2023 22:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02F910E04E;
	Tue,  5 Dec 2023 22:20:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A4C10E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Dec 2023 22:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpKhTPCJzkFUpLwBFpkzP0oqA52HqQtNPu1bH+PSBhZ2Eb/erKn0zgjRuk9CgUlEVSbQ1OeAm8GkTOZSIYcxe18sN0qFY4eqF4QlwK69gERNPJEUKJ2CG7iEXixstjTaYr/8BnwrhIKtjJGbCDQ7+A+fYFFBUIJCuOiF4ZHJSwBplCiE8eSp8BlJTZtPz5PTfUt/QUWogzlZ506awE3dTVvCLLh4JjQA4riQEVr5vji8vj6UyGOpFF1DkZEQIcgggSZVU3Z+PFcw88B0DYCusgMvqYN8y9R1/DRg9rusA5/2K71d2//7SUDsa7gdbNBgeLY2ma9gxIdudcI1RIUJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hni+wQw+xgtOYqP0+omhETQcZqZZoGE5FKXHQsK/sFc=;
 b=ZuyFhyJ7zBEoIecO+TverxfFal9WOD5XGV0cu4tlJY+MIbVKCm7ecEgCLW2vmRU/uDSW/UuQCl/F/WDckf5xVcqtApRBOPPrwKfGM38XyoyR3rqnV1Y+te7wNmKf13D/PcmQmf60G4PzljNTRzhZOOa95MpxLUz/qqBDZvQ6Dc/ba0ZuYmiIKwCcE6+38f9gQTVeXvct1qh//agwRs8ohj5sB6plnJv14ocM9n7eRcf0ssvgvc98Bnw5iL53T+QfC3zgzLzhGE14UjqD3QbR7DzYHHqRa25uk4zCibP8DQ2Gx/fkW1oNcQHHL1jAF03jGghm+ZFts44GjXKPkI6Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hni+wQw+xgtOYqP0+omhETQcZqZZoGE5FKXHQsK/sFc=;
 b=hJRml8ubF5rrBiI/6tEo7Mku1eiinDQaqt7nw3lta7QOK6EjqBmlotA6gWl4VKwxqn+Vt3MeE9w5ulXnoHhsLkZf38nCgXVeg488u3WLHAOcxN+Kwq5J1g6Ju9WZdzZi6vQZBTEXw2qEcUXc42mFOvlr4kgJR54SgP8z+fxdRqk=
Received: from SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 22:20:43 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::9e) by SA0PR11CA0076.outlook.office365.com
 (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 22:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 22:20:43 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 16:20:42 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix sparse __rcu annotation warnings
Date: Tue, 5 Dec 2023 17:20:26 -0500
Message-ID: <20231205222026.2108094-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BL0PR12MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0d1fc6-1a0e-4193-d63f-08dbf5e06bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69+zWkAwInQHpPjX8S3wfhD/39Ilx3zw9hl7GMsUeja0h//48NEDEPNQbc8F5K+eyguXjpjOA8EUJQtDuCrJ9zDgYO9Er+kj1zn9ytYZFz0iFR8f4mJHKKWZb4FdAAYtWaHookVCiDey42zAP/kHY+vlwsOACNyJDbP4REg5Y5UfgnsPTlWAsfuRXtdv8Vt/eECSxs9qRyPjT3S/mpglwMUaocmXhkPKToi88xV4X0ogb+hsjO/gULmqXqZgeQfIKHsrVwhnJ8qphHuXcdmOedcSW0fObY/91fK0Zi3iin4HdY1YMzVzXxD5BqJ5LbsuD/O4/jJ1t2uiuTZiS9AJX2EQfhXyWkj+UDpkdvsCOGocHx5EQiBzJBvDWn5KRfFCXUScAEqQSae1nPYe7ci0VXWmoAiyJo6yvl7GyugV+gAJF8WQw7aawv2iw/EXI5loW5klx0JpAS4DSmERMnM5URIKjuqpYxRNQ07ktIw+xyGsOp/LABSot5nsKdmCEKnYGnyjKwEXpgSNbdKcmqB1EDzFQhEzw0uexqxzgSKWReQ6rACXwTLHKnDSsVs6q+kjZxn76WQ8cjSQQWHoPiQ8pf2FBGO3rrWEFvPvdr5SUkQp8oeKxyCrWMKVKoDcIQ6rVlLNh0SagnsM7Gl2Fmyc5VB0k1LoZa1WcBIXdUSW76iguvS+Y+/+VuIMnrWSTrqRZOwXp5xxqJKZp7pWsUN9oYO7yLo54G+NFK4yvFEtC9n/vh9XUGHILGVAG8ZCqb1pEORLp12YCk6xLtuE9BjVaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(2616005)(8676002)(4326008)(8936002)(7696005)(81166007)(47076005)(83380400001)(40480700001)(356005)(36860700001)(16526019)(426003)(336012)(82740400003)(26005)(966005)(478600001)(40460700003)(6666004)(54906003)(70586007)(70206006)(316002)(6916009)(2906002)(41300700001)(36756003)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 22:20:43.1681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0d1fc6-1a0e-4193-d63f-08dbf5e06bd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
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
Cc: linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly mark kfd_process->ef as __rcu and consistently access it with
rcu_dereference_protected.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 6 ++++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f2e920734c98..20cb266dcedd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -314,7 +314,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
-					    struct dma_fence **ef);
+					    struct dma_fence __rcu **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					      struct kfd_vm_fault_info *info);
 int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7d91f99acb59..8ba6f6c8363d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2806,7 +2806,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	put_task_struct(usertask);
 }
 
-static void replace_eviction_fence(struct dma_fence **ef,
+static void replace_eviction_fence(struct dma_fence __rcu **ef,
 				   struct dma_fence *new_ef)
 {
 	struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
@@ -2841,7 +2841,7 @@ static void replace_eviction_fence(struct dma_fence **ef,
  * 7.  Add fence to all PD and PT BOs.
  * 8.  Unreserve all BOs
  */
-int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
+int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu **ef)
 {
 	struct amdkfd_process_info *process_info = info;
 	struct amdgpu_vm *peer_vm;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 45366b4ca976..5a24097a9f28 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -917,7 +917,7 @@ struct kfd_process {
 	 * fence will be triggered during eviction and new one will be created
 	 * during restore
 	 */
-	struct dma_fence *ef;
+	struct dma_fence __rcu *ef;
 
 	/* Work items for evicting and restoring BOs */
 	struct delayed_work eviction_work;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 71df51fcc1b0..14b11d61f8dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1110,6 +1110,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
+	struct dma_fence *ef = rcu_dereference_protected(p->ef,
+		kref_read(&p->ref) == 0);
 
 	kfd_process_dequeue_from_all_devices(p);
 	pqm_uninit(&p->pqm);
@@ -1118,7 +1120,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 * destroyed. This allows any BOs to be freed without
 	 * triggering pointless evictions or waiting for fences.
 	 */
-	dma_fence_signal(p->ef);
+	dma_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
 
@@ -1127,7 +1129,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 	svm_range_list_fini(p);
 
 	kfd_process_destroy_pdds(p);
-	dma_fence_put(p->ef);
+	dma_fence_put(ef);
 
 	kfd_event_free_process(p);
 
-- 
2.34.1

