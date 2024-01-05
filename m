Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6E9C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 23:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDE910E6BB;
	Fri,  5 Jan 2024 23:01:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C9B10E6A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 23:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj/d1t0TjFE3YcuRI52K0ZJ5b3I2C8BZLKeyDcIY9vuIzPqx9hkD+Oy3ox8QeYsmSQAODnNgBBJM6OqUd1ihNOrEFkBaDzPC5/MjVBg4SC6jQMO6pXZQ/2SppND3QAHWqaz6leSKLo9VFOHWepSQix+/mDMcT1a17IEIOZY5lw8dPdF4ULhDzyf6/lgLiLUv6p1r3CjLFLeBT5UMXt5MO+MbaVkJFXT1UqwPElz9Hk/XW39rfwc8omqp8wHFAwcWwxlANfbzgXJYl27bkcDWLMJwWjYY9ekola4JJjmqlv4Jij4OfeJZwHEP40RTD4mzmlXnJyQlnHPFpiZPdQ5t4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHo+3qrulvoKWbEo/1kjGZCOLoRYyqWrwmE1xpvbcEM=;
 b=DbT7K8RnO2lXU7wf0gobWWdVHN3zxXoIA+ENc5KlDAj1HDjwCwu0+MyietIoaLxJdvHKm1R2/5ZN3gj6YKqIxmrdx3i+XwZIJ+vIztymAyHeaU3heJfUpAvq968TNemFwzMENchgNkc9/1FO/7fax0MrOfazJdkYIh7APacHEgYYuwCbZnKwd5VXYY1j9I9RxiDyeuy2vkQza9KvIoqzneUEAAic+p/iMpYv6lvUOdxnWO6nNdzr64QEGoF80NV22uf2A19X7Gh7kXYWd23Gx6h+Hvrr/lzaclXrxItkNN7W5cCFxkeULSi6BNz7XuYQjfpgGu1yYTCh4zB5c6iaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHo+3qrulvoKWbEo/1kjGZCOLoRYyqWrwmE1xpvbcEM=;
 b=gd9eAktAqLzcUTMtsIVsspBbRohIq80QxOEO6eVuR7++Sqw4DXGuPoRwEw5C5wqt9ZARqF7qTpdIYjnWf1AIkjy/W5pyXeHNMpbQ3KYvMoRlnNkA61ecZ8Mk1D1IlERHbG1rNVC3PNIU5MtTwChd5Fjo5QKlB6C0qrgkC0HR57A=
Received: from MN2PR19CA0052.namprd19.prod.outlook.com (2603:10b6:208:19b::29)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 23:00:59 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::17) by MN2PR19CA0052.outlook.office365.com
 (2603:10b6:208:19b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Fri, 5 Jan 2024 23:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 23:00:59 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 17:00:56 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Fix sparse __rcu annotation warnings
Date: Fri, 5 Jan 2024 18:00:15 -0500
Message-ID: <20240105230015.492870-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: b743c0e9-f46d-41bf-cf57-08dc0e422ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyPnNv+8bM4Y34bkqgfKIedzePCGZqnkwWT4/371MImVw3tLArKiOM5iz9+Kbap0U7F5V2Qr1TQJ9RMkJLdeqvrdKULdRjFixQ0L6PiAvKqZxK5uUZkBLO5D+bxUhs/0+SM6J6EbSN9hG28mt0leLI+fOFS23D/pTbDxA9gpQhf1gZU8us01Gb6QOjWSQOsyGC/BcylDNex55+iszW+fUXnTtbW5p84OggWwthd0f3GpP5eiHof63/8eJoAitvoXnm78VAs9v961vRQxgTksZw+1JHXsBqnbO7rVlLOpIU1VMkPqAwDyxzC+aeIMLcHgJpihWnpGtg31QA7B+CzZ6ZGx7/0nhLJpIn3wnPI4+zHmPa/j5LGX0+eP7F9xbuS8SMNVdB/e48LNLjpayPMuVQVLEAHz3IJTTxJj8i2hhkfciGurxxCXnxdD4jEfjQ13MM3/aSnUPnB4oaMg8YFjYezrtfe9Bs2JtpanWcUh1wK+IF0DLP5aiKVEVsa+z62Pfkx9p51cUJdIh5c2U8+hTJAuL5kYMkJngeFnbbhF5ISVJO95ZwDbLcil2RrgAJbwBPWD26MBlAGpVFW68TODfrDHEk6J8w6N0kbWg74gjQHrrVb3COcJVKmqklFma935sBUAZjOt1mn/XAuAFmb5w+EZoa0cJjdCaxNsYaF+/DOWnXXIvaAUvcNGKlNinXSeOI2QrS77gXaptbR8uGaSNYx5uDTTljL4rfxfqyrRfT5sA32bhcSnRGhgBDuXm5uNJj+PnojVnc7UVIa3hNiANA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(966005)(478600001)(2616005)(7696005)(6666004)(5660300002)(4326008)(316002)(8936002)(8676002)(6916009)(54906003)(70206006)(70586007)(44832011)(82740400003)(40480700001)(36860700001)(81166007)(356005)(86362001)(336012)(40460700003)(83380400001)(36756003)(41300700001)(47076005)(2906002)(426003)(26005)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 23:00:59.4382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b743c0e9-f46d-41bf-cf57-08dc0e422ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495
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
Cc: linux-mm@kvack.org, christian.koenig@amd.com,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly mark kfd_process->ef as __rcu and consistently use the right
accessor functions.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 7 +++++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index cf6ed5fce291..f262b9d89541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -311,7 +311,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
-					    struct dma_fence **ef);
+					    struct dma_fence __rcu **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					      struct kfd_vm_fault_info *info);
 int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 48697b789342..5f445d856769 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2802,7 +2802,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	put_task_struct(usertask);
 }
 
-static void replace_eviction_fence(struct dma_fence **ef,
+static void replace_eviction_fence(struct dma_fence __rcu **ef,
 				   struct dma_fence *new_ef)
 {
 	struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
@@ -2837,7 +2837,7 @@ static void replace_eviction_fence(struct dma_fence **ef,
  * 7.  Add fence to all PD and PT BOs.
  * 8.  Unreserve all BOs
  */
-int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
+int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu **ef)
 {
 	struct amdkfd_process_info *process_info = info;
 	struct amdgpu_vm *peer_vm;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 745024b31340..17fbedbf3651 100644
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
index 71df51fcc1b0..717a60d7a4ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1110,6 +1110,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
+	struct dma_fence *ef;
 
 	kfd_process_dequeue_from_all_devices(p);
 	pqm_uninit(&p->pqm);
@@ -1118,7 +1119,9 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 * destroyed. This allows any BOs to be freed without
 	 * triggering pointless evictions or waiting for fences.
 	 */
-	dma_fence_signal(p->ef);
+	synchronize_rcu();
+	ef = rcu_access_pointer(p->ef);
+	dma_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
 
@@ -1127,7 +1130,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 	svm_range_list_fini(p);
 
 	kfd_process_destroy_pdds(p);
-	dma_fence_put(p->ef);
+	dma_fence_put(ef);
 
 	kfd_event_free_process(p);
 
-- 
2.34.1

