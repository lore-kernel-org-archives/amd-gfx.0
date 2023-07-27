Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A0EEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 23:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B693110E632;
	Thu, 27 Jul 2023 23:43:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28AD10E632
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 23:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSFZNu2wyI1wc8D8U8fYZ9MTUcqLhazsFfsF8PIScLxlRd0cTO94jaQouxQMrWsaqPxqClT+uXoUlRn6OeSB6+8wuckRLrj9C+CNuaUatTlEYl4pbAo8xbDcxTHt9xAHPtWG8AyqzvOf/H0nUEw8J/Wa7ZKTMk/ZbkD7wKXJiYQ0cgjLcM0R5iPxt9j6Vbqcf8IsmjnZhSyA2e55vTu/PwHPqa8nohUxcHkamEfRXZyPKjCIF5fEY0XMgngHD9NclXG7tadIM8tAI+fa92RNH3Vkx/CowyhYH8cyeNqKOwMkwaO4KBKWEOgRwy4a8+kBLxsjSBtzKPIOjXUvTNpjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfAvrzEwgKaswgIK+sAz27XeUWkTNt2Jqneyo31194o=;
 b=O7VLgxWSPOPLS8NVLdTdCwE+WmWLJCZwGsfvxP5jn0I1deWCnbL3jR59CXgIShdxrHZTVntQe9yHSS8zV+Ae1mzTuPFO7zk61OpiLSDBDSs2EYrON6xg1WLzxmMMcwt8KcGyK7kCyThxVMwkUhAZLxYIz3uw/FfxiRD3wKO1OA/46euzSwQPL0GlImnPMvnNEjvskesNb069HN+qKt+lXr0PamJefbosYx+H1toEMldODqvS/TTBOmgYIS2vu1gJdV0ySfk5nOEQT4ygBL4yHXr5eGnre6Vbg8nGLGzbT49MG6p+G4yt1AXLNyLCDvYNNR2HYZ9Mq0PZutJxnoGiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfAvrzEwgKaswgIK+sAz27XeUWkTNt2Jqneyo31194o=;
 b=eI2M9awKKHShKzsRNF7N88eiH5kKD8BQhhtyGXwu/Pm9QsVF3NefCzB6FyVokQgCPLyQJACHbgOpk/KoSQBF8woKRRdqbsIZtHJeHGdeA0hClAieSeCQ5iNyAPPa7IIEeAVIT2S1BwW4ThlDqRQ879Aty8BNmVg8yjHduJWvwhA=
Received: from CY5PR22CA0012.namprd22.prod.outlook.com (2603:10b6:930:16::32)
 by DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 23:43:22 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::ee) by CY5PR22CA0012.outlook.office365.com
 (2603:10b6:930:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 23:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Thu, 27 Jul 2023 23:43:22 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 18:43:18 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: avoid unmap dma address when svm_ranges are split
Date: Thu, 27 Jul 2023 18:43:06 -0500
Message-ID: <20230727234306.15862-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM6PR12MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 491261d5-d203-458e-9b61-08db8efb437f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s93Y2cHKEqlvpLhZwruLks9te8VdGd+fKxuqUZ4tXPiiTo7YQVB3wqpoxd/5qIOwzWLDpKy9UcgNbizp0E/wVOiEZU7ZHpWRF59MFYsjGFlUPuioWW8bBzFK9PF7t0gPb7aYu7SKR7MBEYB7tlpaJ4vkHuLIbrwcMw6HbfEAlXyGtOl7TrI24jnYqoY7g+X9HG5QIhVkQNFh4pZDBkC7ksniqA4WPV8TP5+KRiQaTRV4jyCH2LrIMVUFCQ6uKh/jNoNmAt+3XA/+mG6fwmInH+sdw4W8ertQ/IT7GOQaOgSZD2Lk9yR4NbGYNvQR6ibx08mQ5cnBu7NhUprs6P5Zo1YvYjp1Rq4Z12P4DUZRbiUkD5qcO0OSmAFlExtLQHmgtu7zUStO+0LQGhw/UqXSO4dahGurgizsgqaLXAtUjCbSEbkI86FybR6WgM9d6FKGIX4rBftloTHh7F1DWEPKaxtkWclsEgu2Ls5vGptQFQss5yJx7A4dD9gbtpQ0RfmCmBhGX6IUtBumd0NMZkMPBsGTaq9pzzyF3YpyYZcDX/wqkQa/1p0QR+vmjfoXzIcrljHU+3pQBqR8sLrWhLAgO+XkDercZOP7aHZ1GAQPCKYNLPKvK1Oe1voa+6CT6inSlRanEazZxar89DNfWn/iVLrtI1x+8r+AZkYgIqJVyxwqKzJ/RL4+BsOYSAVGX5MK+r5C2TEnGJI8lW6qu/9xbgPIhZYnNrJ/9nLws7V1L7mQeNQeqtMM6EQZL6Vy3mPI1ZI8Gkkh4Q8jDKajDj0iUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(2906002)(316002)(8936002)(8676002)(40460700003)(5660300002)(44832011)(41300700001)(36756003)(86362001)(40480700001)(7696005)(6666004)(426003)(81166007)(54906003)(82740400003)(478600001)(356005)(26005)(1076003)(186003)(16526019)(336012)(110136005)(2616005)(83380400001)(70206006)(70586007)(36860700001)(47076005)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 23:43:22.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491261d5-d203-458e-9b61-08db8efb437f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 67 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
 3 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 709ac885ca6d..2586ac070190 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -461,7 +461,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 				    0, node->id, trigger);
 
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
-	svm_range_free_dma_mappings(prange);
+	svm_range_free_dma_mappings(prange, true);
 
 out_free:
 	kvfree(buf);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1b50eae051a4..d1ff1c7e96d0 100644
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
@@ -262,7 +262,8 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 			continue;
 		}
 		dev = &pdd->dev->adev->pdev->dev;
-		svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
+		if (unmap_dma)
+			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
 		kvfree(dma_addr);
 		prange->dma_addr[gpuidx] = NULL;
 	}
@@ -277,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
 		 prange->start, prange->last);
 
 	svm_range_vram_node_free(prange);
-	svm_range_free_dma_mappings(prange);
+	svm_range_free_dma_mappings(prange, update_mem_usage);
 
 	if (update_mem_usage && !p->xnack_enabled) {
 		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
@@ -851,12 +852,46 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 	}
 }
 
+static int
+svm_range_copy_array(void *ppdst, void *ppsrc, size_t size,
+		     uint64_t num_elements, uint64_t offset)
+{
+	unsigned char *dst, *psrc;
+
+	psrc = *(unsigned char **)ppsrc;
+	dst = kvmalloc_array(num_elements, size, GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+	memcpy(dst, psrc + offset, num_elements * size);
+	*(void **)ppdst = dst;
+
+	return 0;
+}
+
+static int
+svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
+{
+	int i, r;
+
+	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
+		if (!src->dma_addr[i])
+			continue;
+		r = svm_range_copy_array(&dst->dma_addr[i], &src->dma_addr[i],
+					 sizeof(*src->dma_addr[i]), src->npages, 0);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
 		      uint64_t new_start, uint64_t new_n)
 {
 	unsigned char *new, *old, *pold;
+	int r;
 	uint64_t d;
 
 	if (!ppold)
@@ -865,22 +900,16 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
 	if (!pold)
 		return 0;
 
-	new = kvmalloc_array(new_n, size, GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
 	d = (new_start - old_start) * size;
-	memcpy(new, pold + d, new_n * size);
-
-	old = kvmalloc_array(old_n, size, GFP_KERNEL);
-	if (!old) {
+	r = svm_range_copy_array(&new, ppold, size, new_n, d);
+	if (r)
+		return r;
+	d = (new_start == old_start) ? new_n * size : 0;
+	r = svm_range_copy_array(&old, ppold, size, old_n, d);
+	if (r) {
 		kvfree(new);
-		return -ENOMEM;
+		return r;
 	}
-
-	d = (new_start == old_start) ? new_n * size : 0;
-	memcpy(old, pold + d, old_n * size);
-
 	kvfree(pold);
 	*(void **)ppold = old;
 	*(void **)ppnew = new;
@@ -2075,7 +2104,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 				r = -ENOMEM;
 				goto out;
 			}
-
+			r = svm_range_copy_dma_addrs(prange, old);
+			if (r) {
+				svm_range_free(prange, false);
+				goto out;
+			}
 			list_add(&old->update_list, remove_list);
 			list_add(&prange->list, insert_list);
 			list_add(&prange->update_list, update_list);
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

