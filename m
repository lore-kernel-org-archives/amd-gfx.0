Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4342C67861
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 13:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4FB112589;
	Mon,  8 Apr 2024 13:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXmLBitr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F446112589
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 13:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is5dMJWeNy0omrpSdhuwwJpHkZua2AFCd/82RBsXxzQojSyMV8TaoGx9hp1cFa4nX85S6dRO4t3TXWeBjOInHDj4dLBuQgr1bUCZlrIDh1As6O4P3ToF6wFcJQbHkV3pCp8qIhwUl4cqKM+s9wnqgPcddI1QTvO8ciYNpglVl+HEiq5AggXaoU6q4GjL/Z5I4QDYTOVhwR04eak+uMIKd+ZIRUC7lGFLdsXfQjNdCrxCrQxQSqNHvqrWQbTHfvwPeOZ9mPM+7W5+/aZvdvlNKdPO60rWBYhywtSKf5wNprz1JvYGrdyKTkzOeeqQwCIkl5LKxjmETc1BkfIO8pBGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WARKdObYb3Wi/z+hJghFLnvEgOL9zlpg7LL+4Zaa4Jo=;
 b=WMBSnVjUlL0vHlbPHOqR0OFxNULaHhACNgGv/z24tAvtWhyHjd4mrqROev1mKLocTct+ZX2bb2/pi+VWvsIUpI4c8ggzcHOM8tkfDAjxnjGwP0pcTrkCM02VzjJGxv5XsA+OuhPz1U5s7KFQWJDd0mONMrLiKsUzCXEEfFCiSTR83NgwlHvUn2nfNK6Otrkm3Is16jmVWdf5A64N1jLyaAQJUlnSCk6BPB3oqoXSC9CqrW+eJ7IIZ9UsZMXbKMDadNntQm6/7NokaN4cVImwj8839N474eIVO5mszQZmoGgtIXv7ZFSAfGAjnJdMQwrDFAIqkCVXBPDOxYq3Scjxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WARKdObYb3Wi/z+hJghFLnvEgOL9zlpg7LL+4Zaa4Jo=;
 b=LXmLBitr31Mo1TjVhg4sZvflFqgbVuJ0H0cElQ4ryXxHnOpWsHI4/6k9MImH2diZc05gULCp3MxsJj21lPM1pFrSMcV9fmaa/pfvqZ7YRv0GVqYBsZa47F7CiH4NWCrpCNon0Ta2mkyuAwcF85ThPwQf6/urYoIuSm1ou9N5HeU=
Received: from BYAPR11CA0100.namprd11.prod.outlook.com (2603:10b6:a03:f4::41)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 13:07:22 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:f4:cafe::7d) by BYAPR11CA0100.outlook.office365.com
 (2603:10b6:a03:f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.34 via Frontend
 Transport; Mon, 8 Apr 2024 13:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 13:07:21 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 08:07:20 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <shashank.sharma@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix tlb_cb memory leaking
Date: Mon, 8 Apr 2024 09:06:56 -0400
Message-ID: <20240408130656.14897-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 15117380-8c92-49bc-9826-08dc57ccd3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzPZH2v5MMw8iCHkX4mG8q6e+99QcYBmiQEZ/b8bNAgSKdR/RqYJqMFkWt+AQ7vgO3HR9ZeJVorbMdYSfjw2M5FKnKO+ZJUAtKHUOLWDs97nOl6tIYcrEEA8OC3dnblR2zlhzx3SV39NhPVcvnXgoVjgo6k8PwfRvXw/wt8n4YXu3ZmiZ/tLfB9LPPd4eOuiQ2ZY45wMxq9nOFnTnAyVYTMsOq90fKZt4I7ypVnjhr9yUA3bWx3+bAT8UUsiiZliDeo1YuWvMqZacMVy88/2kPXvkOOlm7lUsUHkvfJY/3rqyEPXg6ZPKez/1nQjpuxF2PjrY5ZKRtFvemKmg7NHB7LSpfYkz2U6VkJL+yIdU+kfB3Eo8H2khXu+2r5YWC+0ridJSOEEC4+reAD4FOV+y7NCrkTGZxN7xM+rdkHY0JxoEoPYMDrX4bnuAsL1KjhNVpi0lYuUPoQxTNYQ1kf8c5ibp9pZxXCDZsJtUQKeuNnZdmi78YSFbrpm0+4l9GGq2FhnDY2YNATQaEUyKmLtUJluqSJUaFlaApamAwD5DyheUdyII1pe62oQWlNU12Y272xsEkyRWsKx8PduFgyavsaE4mnJyRmXkroCI5T8BJyjDDESAf062GS8UmF0LoteaEWXEjrPVSibSFvHS41cz/t/uykdrABONr9IdUou2mDjQKamT1PExYPrerF40uPLAxdnj7qWS3E9pAibJmVSI8o8PUKZKx79NuQ12udwviw0AIuQGqhd6P6ZGO+uIhmw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 13:07:21.8673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15117380-8c92-49bc-9826-08dc57ccd3ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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

After updating GPU page table via CPU on large bar system, no fence
callback, call amdgpu_vm_tlb_seq_cb directly after command committed
to free tlb_cb.

memory leaking backtrace from kmemleakd:
  unreferenced object 0xffffa036816b00c0 (size 32):
  backtrace:
     __kmem_cache_alloc_node+0x3fe/0x4d0
     kmalloc_trace+0x2a/0xb0
     amdgpu_vm_update_range+0x9b/0x8d0 [amdgpu]
     amdgpu_vm_clear_freed+0xc1/0x210 [amdgpu]
     unmap_bo_from_gpuvm.isra.36+0x37/0x50 [amdgpu]
     amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x118/0x1b0 [amdgpu]
     kfd_process_device_free_bos+0x7c/0xe0 [amdgpu]
     kfd_process_wq_release+0x273/0x3c0 [amdgpu]
     process_scheduled_works+0x2a7/0x500
     worker_thread+0x186/0x340

Fixes: 220ecde84bc8 ("drm/amdgpu: implement TLB flush fence")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8af3f0fd3073..d0ef727cd7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -901,12 +901,9 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 {
 	struct amdgpu_vm *vm = params->vm;
 
-	if (!fence || !*fence)
-		return;
-
 	tlb_cb->vm = vm;
-	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
-				    amdgpu_vm_tlb_seq_cb)) {
+	if (fence && *fence &&
+	    !dma_fence_add_callback(*fence, &tlb_cb->cb, amdgpu_vm_tlb_seq_cb)) {
 		dma_fence_put(vm->last_tlb_flush);
 		vm->last_tlb_flush = dma_fence_get(*fence);
 	} else {
-- 
2.43.2

