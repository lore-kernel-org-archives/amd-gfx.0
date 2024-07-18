Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9207C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535D510EB28;
	Thu, 18 Jul 2024 21:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a//hHh8x";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B7E10EB27
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgFb0q4c1CEKdtDfJKRowtBHUi6OfOqpAP2F7u7i3h/E63bhI4wwN4vFNJyUI/yJKSDWHSDzn7Xtyr9MmUMoN1LyMB+ArvKfnNmvH31If2thc5n00FOGHO0FhEPywdB9dWeDuG0CIqtdgfRSF2ksZPmsA+HLUiVtO/7KwCo8Mf41dlc14M+ODY0hLWPcunvKE8pvIk7BBRjUWAjzSrxTfo5F9xxd0a3KzNnygEDVCYU/27oMrdQAzaavp5QimUItidZSYhkJLi6FrmNkGziA+SubnhClkOFkP80SzEKhCPYEglscApGzCqwf+BStAF4h4KnluXJC+XPYVZqtzxKy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1F8aYISyTlE7YSXeJPh75VQ9wzlfzvPIqqHPiAxsu8=;
 b=L+juVbJpBK+1AIYuPCpmOztYYyqtaKD8WvM+VcKvb4KZO7weOlYP3l3S5xSzZXb+mmHbDQa/hBkXzrbPwC/yIU8rZix5JGcEfPNPrehvPJgrqu+9N1k+b+AGyvRv+sWY5wpaawBtZD9gClLKRDCY0yWg/6DjrKk5xcxIR12l8vCS0cTH6L74Sn99P7Kt+dPpLSaWRpOiFZFpI7NAE1XvwlKnHCRRW8oTrKd9n/QeKw9Urs2xl9xWjal+Kux5d6kkvcfx1M5XU5KNU3xqVdfUlKVYxjarCdQ33GpBcdEO8YNiCHZ4gFUme7SNML8r6UhlPh52PrskyOtPXeJNEKztug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1F8aYISyTlE7YSXeJPh75VQ9wzlfzvPIqqHPiAxsu8=;
 b=a//hHh8xrmsnnZMTIObT4V7RCUIqRXdB58Webj3oLa5bHtOn7h5ySlcXk1kSel8tP9FHqPr5b2uKA1YNioJwNfAYV2MS95o3nBq551maP2xIJReiEQzu/F9wC3MnlgZJ37Gff2snrMe5tXuPYlUmkOiWCQ03KtPDqXbg7jpFs4c=
Received: from SA0PR11CA0099.namprd11.prod.outlook.com (2603:10b6:806:d1::14)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 21:06:15 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::2) by SA0PR11CA0099.outlook.office365.com
 (2603:10b6:806:d1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:12 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 2/9] drm/amdkfd: amdkfd_free_gtt_mem clear the correct
 pointer
Date: Thu, 18 Jul 2024 17:05:51 -0400
Message-ID: <20240718210558.26340-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0f60d5-6610-40e6-0778-08dca76d75ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T9rZHmGO6GHe80pXtcw0HPfHnzyfQM+cC980RAYB6le5qf+viRK1aZZKiksk?=
 =?us-ascii?Q?MMeXrxwvcvCpvnBMs/jJsu6AGRnCjaTpLqlX0fHQgRxZUNpvVkaGj6sXqFxp?=
 =?us-ascii?Q?nVG3uyw54KaNIASiGyR8N7kKM0SSFjelm2Izf8iK+489LgsmvLTPI+4ZwE6L?=
 =?us-ascii?Q?MW/N/pcDs8eLjHrHbzoERYpNFrfyj1mjQUAIVOUv9mGO5y221qAh6y9X8YJN?=
 =?us-ascii?Q?iwbqZRsZF/jg+upt/jbpTis244iWPkag0+RYsJGDTAd2O8BJC6Dz9NGHw0il?=
 =?us-ascii?Q?qtGEbcYtu3QUHq/2ZeO/Cxn2Nmlf8oQPhjkSh0q+mrrmDWk3aDBGXeQoW+aT?=
 =?us-ascii?Q?VqsoEhMHbS24VhaYkZet1nGwCZfD0aok5HgqlsG4uQxMQTHG57IqFM48MgEx?=
 =?us-ascii?Q?BcDlv4sTfnSz3doLBX3I0JLMnw4+8yXgfltZaLVFnR1dug0u1QzN2ov6VFDl?=
 =?us-ascii?Q?gIg77oIVjun7lw42k+8tC2lOUIjVzblIV6zVcNjifjNjjXp4LL31nmA3mxaJ?=
 =?us-ascii?Q?AJKjw2VGBVIhAy8ROHkkZBnndnUPuYkJDWEdVq2tqVbVBM5/V76Jp9SLGRfv?=
 =?us-ascii?Q?Edj1iEfi69iBoiat0M1dlNOZn1DTX3sjsvn/Pxh9Jtj16N7L3uRgYsStf+HB?=
 =?us-ascii?Q?TLMmxiib7jBgyihS4gKBPHaoJyiBAjjIYGiOCRURE5GFTxxUD3yfUPF+H3yf?=
 =?us-ascii?Q?OT4TOL/CGvFba5K63ULSsI/VzTcoaw0AHW5xGdZCS6Wi3MZSegzqDY51UV9e?=
 =?us-ascii?Q?4cUAuDypeqS8KXkkh3mSiMSioLZyUgG2AvA1trxCvhpWpAteyuyybIstqqW/?=
 =?us-ascii?Q?+mqVb4/FU/lo9FdGbaB4qMw1GNoaflNw5SUIomAyj6KZA1e1+HBQpzsMA6zL?=
 =?us-ascii?Q?0OCKArNnK5fWfxcJG9t7065zUL03ykL/fqaib02U91g+W7r1pg4ChWV3853v?=
 =?us-ascii?Q?BMGKZMiOd/vc80kunyXeMngpmFMALjw1bOkmEh8Mka6+1GAygHC3HnsPGJei?=
 =?us-ascii?Q?okSZDlT/p4sB5kaS9BJDJVNhHr84yb3dah6tbSWXWC8ik6ZIrPCpfptExK5v?=
 =?us-ascii?Q?n+mnS5erXoAY55YPn2SFuSduj4hUbauynQ0gzGfekfhuSRYGF4qsMs4A0Pu0?=
 =?us-ascii?Q?3RfUOA+/jOktfONnBqgFIYJLD+Th0t03app+q9lY+KPPJa0fPlYyNSWEFVWT?=
 =?us-ascii?Q?OxWbttE6UQm9kbapp7eHQIFqugVoWLOcJ4NWU56DeWv8fvfJpLz/csavh45j?=
 =?us-ascii?Q?XH2GuenK5ojCeENMitYyfjk7Of6oZVs5NOMuK/DiXEgRvqlH4fSCSQc53Lcw?=
 =?us-ascii?Q?TiMxo3NMczMUn0Hi3lGd9SFTNUBNc5v830/1PoxqNo4Yp9APKagJCwovhntp?=
 =?us-ascii?Q?G0ekkwwXZpaOz7N7W+Hir748BPexX0QDuTCzL8hthfQwwtcJTX5U7wG4eumh?=
 =?us-ascii?Q?m068FDHUCs5Gx4fQ/KJFllRuB8CeDUGf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:15.0794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0f60d5-6610-40e6-0778-08dca76d75ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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

Pass pointer reference to amdgpu_bo_unref to clear the correct pointer,
otherwise amdgpu_bo_unref clear the local variable, the original pointer
not set to NULL, this could cause use-after-free bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 03205e3c3746..c272461d70a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -364,15 +364,15 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	return r;
 }
 
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj)
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
-	struct amdgpu_bo *bo = (struct amdgpu_bo *) mem_obj;
+	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
-	amdgpu_bo_reserve(bo, true);
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&(bo));
+	amdgpu_bo_reserve(*bo, true);
+	amdgpu_bo_kunmap(*bo);
+	amdgpu_bo_unpin(*bo);
+	amdgpu_bo_unreserve(*bo);
+	amdgpu_bo_unref(bo);
 }
 
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 66b1c72c81e5..6e591280774b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -235,7 +235,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj);
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1d9b21628be7..823f245dc7d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -423,7 +423,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 
 err_create_queue:
 	if (wptr_bo)
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
 err_wptr_map_gart:
 err_bind_process:
 err_pdd:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f4d20adaa068..6619028dd58b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -907,7 +907,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-	amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 alloc_gtt_mem_failure:
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
@@ -925,7 +925,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 	}
 
 	kfree(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f48507418d2..420444eb8e98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2621,7 +2621,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, mqd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
 }
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 50a81da43ce1..d9ae854b6908 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -225,7 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, &mqd_mem_obj->gtt_mem);
 		kfree(mqd_mem_obj);
 	} else {
 		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d65974f3b34d..70d6359bb5a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1048,7 +1048,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		if (pdd->dev->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
-						   pdd->proc_ctx_bo);
+						   &pdd->proc_ctx_bo);
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 21f5a1fb3bf8..36f0460cbffe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -204,9 +204,9 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
 		if (pqn->q->wptr_bo)
-			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
 	}
 }
 
-- 
2.43.2

