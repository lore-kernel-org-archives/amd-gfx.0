Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC04C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 21:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5494810E152;
	Fri, 28 Jul 2023 21:42:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D118510E152
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 21:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE+KP1SB/6UJ/GatDyC7EmQ23KkAQDM+M1/fL9AQk6XN4igpGMCkdiqa5MUXphtYS5Z6h1IijUXT+gv43i+b1U0tfKtg/FyLsPHlvOgYRVZ7BEFWgBbMyX8dACp/DyQlRNRcBToMDV0s1pT5TlZhmdABP8sj5mUNP9T1oYLUx05ZAWzGR7yzI3cmQI27PCvXMUlcLWmBtnDJE1vfQwXOk/J4QGXu3omsbdEjU0rH0L3yAlJehxiGWOEHPXWHAzKmDJKh3Sm3GD+3cPT7S1TajLL/FjV8J/4KnAxUqalCfO79whJb8cMJe7D0cKPG3k3obEVlnhWmo5zi+W5k6R9+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSC0DHW5F5iF718HVkkCFBpOODVb4beRcMqJ9oWu0MU=;
 b=KtRr5NPJiPc4doBFZVQUkN/az7jlwTwBsxbMJ93aQjVJMOQYyqsdLwDtcH4Jc1PmU4ZA3nzGzifoqy5YpABgHN+Mamd46sqjh3yCETxf7IAUJMBe+lIc8ugTGch+PN5qv9TbPcRmrghwwOjif0x2ewILtTBNFy9U9u5wwF2BH9NJo+rErMkdSS9ZJGeJ/hZ7sAmG2aTaXJteGQASVtzMDQPXAvJKP5vAioa9tU3EFPRvYOyDmyc0hU17gU74kEtDDBOcCjkWKpLtm7SipkHuZMomKCmxdVGl1y1ef1GDnStjow4/ijKz92wksL/tTQZ4B6bcdWf/kdgEEOhgJ9zLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSC0DHW5F5iF718HVkkCFBpOODVb4beRcMqJ9oWu0MU=;
 b=f76xcfejcT3diZvWAPhEruV8CNJd9D3C/nGKfSg6DjmAN/Sa1jgTcfbfX6zhcGEEM/fIxJq38ZnNCt1immO/f5h6RVBBI+joxcdIgxujb/pH5L3fRx099L1iMUr+obWutUdf8AJ33Vd+XP/S3fdQieH6LlJiEV9GB/UQyZGYdww=
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 21:42:13 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::c1) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 21:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.0 via Frontend Transport; Fri, 28 Jul 2023 21:42:12 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 16:42:11 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: avoid unmap dma address when svm_ranges are split
Date: Fri, 28 Jul 2023 16:41:57 -0500
Message-ID: <20230728214157.17697-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: ac09ef44-a6f2-47d3-886e-08db8fb380aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2x/D0utQsSodjX+zVmLf+xbMQ4s9shIvVbinAiaouAhY8APHF+e9/psTPjvqB5WuEzCXxBnuL2yim/zXG0G2Ot+IPzeLmpz/I/6Y/XqgS8ZOQSs091x7gBIJS3Vt7Mx3ke/kaQWViBScGhIX1JXfzbYD9uCnG7N2GcBXfFFjsYzUjAhRecFMQuIgNbiUQdlob1u4XDARDOvUI5CGe03fhmR6vvh//++5RcHSSe0C0YNZAvxe6II6eER54Ic1oX6t7LHXquj3X5oVueWrKdVKCcVL75wPH4LeT4KrAqYhQslExOf9KgNjr8UlD2dl7wgBoQKDX38RjlJZRJmc4UZ9Hr+SLJlHXgmcW28MURpGukb4mckxfBIuwKTFESrPp24VIGcdP/zf5qtiOPiARmvrFJBbnG+QD/6y47USqsi1ke/vBuUHjIClws47pUistAPX4wR+6qdqZeVFj9l3hulu4jbNeOiyipNikNB1PN2sHJ0US/7qb5+/2U6QKZSskORWgRfQe9DSKaSBCfMVDDpdN4HRWkY0C3H0kmGQWXwsL+53jzs0vbxtiV2WI6445xL2KqWycqYk+HZBXsYQYDCHLIa0gom2/JW4eMjW8wu9P4kNisekj4ycHgMcA9OkpHtT0yoCYlS51x8JwQczUsIy3+bQm5K4tFEjF02UEg4bwuy0zcIphIsnxbLA0ejpS7WEYcG8z1QPoYdbAXlqZL/GIb2OJt1mrvnXj5tWPVzw8SBCZjJ/OWDLDrSbKuBKvsGGkfdpxnapqJNsn+iBuYC8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(1076003)(356005)(54906003)(26005)(478600001)(82740400003)(110136005)(70586007)(186003)(336012)(16526019)(81166007)(426003)(7696005)(6666004)(47076005)(4326008)(6636002)(83380400001)(2616005)(36860700001)(70206006)(5660300002)(44832011)(41300700001)(40460700003)(2906002)(316002)(8936002)(8676002)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 21:42:12.2072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac09ef44-a6f2-47d3-886e-08db8fb380aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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
Cc: xiaogang.chen@amd.com, Philip.Yang@amd.com,
 Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DMA address reference within svm_ranges should be unmapped only after
the memory has been released from the system. In case of range
splitting, the DMA address information should be copied to the
corresponding range after this has split. But leaving dma mapping
intact.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  7 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 61 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
 3 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 709ac885ca6d..7d82c7da223a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -461,7 +461,6 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 				    0, node->id, trigger);
 
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
-	svm_range_free_dma_mappings(prange);
 
 out_free:
 	kvfree(buf);
@@ -543,10 +542,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		addr = next;
 	}
 
-	if (cpages)
+	if (cpages) {
 		prange->actual_loc = best_loc;
-	else
+		svm_range_free_dma_mappings(prange, true);
+	} else {
 		svm_range_vram_node_free(prange);
+	}
 
 	return r < 0 ? r : 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1b50eae051a4..a69994ff1c2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -241,7 +241,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 	}
 }
 
-void svm_range_free_dma_mappings(struct svm_range *prange)
+void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
 {
 	struct kfd_process_device *pdd;
 	dma_addr_t *dma_addr;
@@ -262,13 +262,14 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 			continue;
 		}
 		dev = &pdd->dev->adev->pdev->dev;
-		svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
+		if (unmap_dma)
+			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
 		kvfree(dma_addr);
 		prange->dma_addr[gpuidx] = NULL;
 	}
 }
 
-static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
+static void svm_range_free(struct svm_range *prange, bool do_unmap)
 {
 	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
@@ -277,9 +278,9 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
 		 prange->start, prange->last);
 
 	svm_range_vram_node_free(prange);
-	svm_range_free_dma_mappings(prange);
+	svm_range_free_dma_mappings(prange, do_unmap);
 
-	if (update_mem_usage && !p->xnack_enabled) {
+	if (do_unmap && !p->xnack_enabled) {
 		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
@@ -851,6 +852,37 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 	}
 }
 
+static void *
+svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
+		     uint64_t offset)
+{
+	unsigned char *dst;
+
+	dst = kvmalloc_array(num_elements, size, GFP_KERNEL);
+	if (!dst)
+		return NULL;
+	memcpy(dst, (unsigned char *)psrc + offset, num_elements * size);
+
+	return (void *)dst;
+}
+
+static int
+svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
+{
+	int i;
+
+	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
+		if (!src->dma_addr[i])
+			continue;
+		dst->dma_addr[i] = svm_range_copy_array(src->dma_addr[i],
+					sizeof(*src->dma_addr[i]), src->npages, 0);
+		if (!dst->dma_addr[i])
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
@@ -865,22 +897,16 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
 	if (!pold)
 		return 0;
 
-	new = kvmalloc_array(new_n, size, GFP_KERNEL);
+	d = (new_start - old_start) * size;
+	new = svm_range_copy_array(pold, size, new_n, d);
 	if (!new)
 		return -ENOMEM;
-
-	d = (new_start - old_start) * size;
-	memcpy(new, pold + d, new_n * size);
-
-	old = kvmalloc_array(old_n, size, GFP_KERNEL);
+	d = (new_start == old_start) ? new_n * size : 0;
+	old = svm_range_copy_array(pold, size, old_n, d);
 	if (!old) {
 		kvfree(new);
 		return -ENOMEM;
 	}
-
-	d = (new_start == old_start) ? new_n * size : 0;
-	memcpy(old, pold + d, old_n * size);
-
 	kvfree(pold);
 	*(void **)ppold = old;
 	*(void **)ppnew = new;
@@ -1929,7 +1955,10 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new = svm_range_new(old->svms, old->start, old->last, false);
 	if (!new)
 		return NULL;
-
+	if (svm_range_copy_dma_addrs(new, old)) {
+		svm_range_free(new, false);
+		return NULL;
+	}
 	if (old->svm_bo) {
 		new->ttm_res = old->ttm_res;
 		new->offset = old->offset;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 21b14510882b..9e668eeefb32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -183,7 +183,7 @@ void svm_range_add_list_work(struct svm_range_list *svms,
 void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
-void svm_range_free_dma_mappings(struct svm_range *prange);
+void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma);
 int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
 		       uint64_t *svm_priv_data_size);
 int kfd_criu_checkpoint_svm(struct kfd_process *p,
-- 
2.32.0

