Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA17CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 22:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCA410E03B;
	Wed, 18 Oct 2023 22:26:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAFD10E03B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 22:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9zqELZGb2sKOdYIowHD0Gx1FQ9OdH6U8pfH8VN1fmPwIe4QCIDUtMxv51PQZlhAIm40yJ21LADOQtpPbqTruH9boey3gJXFH+IT+Zm6a5aCJsB2JpdcDapUPxrVJCUlmuja/n7JQEnxfucPZe0J14zgOyG95uUb65NwYbtx/0vkn9JOfhfm+kaUo3ag8tuDzJD9hhWyZ3no9iRC4aXKjXoVR0jqO2Pe7RBJYEi+BnteP4FzVb0/aoRifxDls+cC+SpXN/6i/jTL4WwRQaleJXzKeirqY6tq6UQ2cj7uOHlu/KsJ65hJ3rk1hWnXxHxaNxOiqiX6Ogy/haxPkdUPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHN27TtRVdXOTfLHSYo/0txSkQhxMcl/YWiiJ34Tdn4=;
 b=cirzD5jF0GAPKEcQi7HacpB0vTHRXPlJRDrlst7dpVCKDmc4/t9JSu7EQuFjrWY5+r6ZjjANksdmsrpfxP3xKb+GIaZh0ugQjthQFOBG0yK9Pz3ZdN7u/e6tLNCzoBBnNAPvgY0MzCZYXtAkCDIHWEgfxP2HhvjtPzsGcsFrva3xeEI8pzoGOiHAP3JBtls/XvL5Td9DFhQLBdBR8r5HmwTADsSRQKMS8EF5Ca7xjxtE5DXrf3DdwTlQs40A8dM9sf2C2HBY2tcYdgPlEXkkAWDDkoebFTjeZrqc3fv2yabT3hrmqAUuxQkKtomamDmAJhQxd/89g1cs0XL09J28MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHN27TtRVdXOTfLHSYo/0txSkQhxMcl/YWiiJ34Tdn4=;
 b=qsyxIN4wOR1JxZm7K3GXwFi56nZ1wZ4/6pbvukp05SUdnjxtFdE/OCpdJCpKVAWarxnpZNLrY1Nw5ykBj5EzBphR/YAZtlm2qNHcxvDe7pCtcul8iWdtK/xiVUqIHIvsdCOQJo6CqMWJlfclZyHg0fg1qLv0lz7Yjx5L6BhIbe4=
Received: from SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Wed, 18 Oct 2023 22:26:20 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::a5) by SA9PR13CA0026.outlook.office365.com
 (2603:10b6:806:21::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Wed, 18 Oct 2023 22:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 22:26:20 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 17:26:19 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: remap unaligned svm ranges that have split
Date: Wed, 18 Oct 2023 17:26:07 -0500
Message-ID: <20231018222607.9872-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: a3675550-b774-4572-498d-08dbd02940c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rf6ln3ZWOGfL0MaAFncLiGL4XXQcWC0ue2RpJn0QrsUB2U/ZWSGA+U94l8xE2ZZ5DIibdeQdXrg4ZMDG+XKltqLFPCQUoluiFnVMqBpdcSS2ZWhcdYabc5OZL6rz5ODbxtsA0IiCs6/E06xsm3J1Mc3Ux6/sCzJl801JKszdW8s5F7U8uXcWlhfe+sNA/AQ6e0LNceaKL5s2A5lwUEuNXVYW9NPpbw5N4S5KNTQRb5AVje9efn9qBvrLL7tJ25BJHu/paKYbpw6MAlWVtN71qXVk3ynFg5+azuUOqqL52IHDU0I8kck+bVM2r3BrEak2l1Ar9jGz9lYNyFpH2mXHoHiB0fpkaXc7pGBuNywd9ZkcqCfivHW0SAGaxVfu4972G2SK0itPkw7ZAsdn8eutJXoStZL6+lLp2WjbD7OhEkyiAEoPr7mQg3I/6A5rotN16DJBTI4FW9Z9gvNWsyj3Oaf7qxiURcMOGNllWiVPVUZdrJNerLsczxARcKSG9vZ+HljFwTgNKZmQTloKOfi0zSBoOs5xD8mYD/KWJGr9Vo9xU331qw1Z5XnPHxL7dJ/nss3qJFvbTtm3VYCiTxSXSCC75jB/sZMKah6LhdjLJi+V3nG6E1p3Cfa8tO8ZPeTaiEX6WgZVl0baCnoCLzm2gIMvazAVkQeHJQK6mXGxjnygJghXVj9PtM1CP9uHX+Fk0Cjnqp+cKAscU6eoplNAWmy9VcAZa2PS0a2QitW9PVTGNm/W2o8cP2Jm8Rrp9n3NlSOvAG8b0ykpY9oKRIAmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(54906003)(478600001)(70586007)(70206006)(110136005)(82740400003)(47076005)(7696005)(6666004)(86362001)(316002)(6636002)(5660300002)(8676002)(1076003)(16526019)(426003)(8936002)(26005)(44832011)(336012)(2616005)(4326008)(40460700003)(40480700001)(2906002)(83380400001)(36756003)(36860700001)(81166007)(356005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 22:26:20.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3675550-b774-4572-498d-08dbd02940c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
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
Cc: xiaogang.chen@amd.com, philip.yang@amd.com, james.zhu@amd.com, Alex
 Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Split SVM ranges that have been mapped into 2MB page table entries,
require to be remap in case the split has happened in a non-aligned
VA.
[WHY]:
This condition causes the 2MB page table entries be split into 4KB
PTEs.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 45 +++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7b81233bc9ae..1dd9a1cf2358 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1104,26 +1104,34 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 }
 
 static int
-svm_range_split_tail(struct svm_range *prange,
-		     uint64_t new_last, struct list_head *insert_list)
+svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
+		     struct list_head *insert_list, struct list_head *remap_list)
 {
 	struct svm_range *tail;
 	int r = svm_range_split(prange, prange->start, new_last, &tail);
 
-	if (!r)
+	if (!r) {
 		list_add(&tail->list, insert_list);
+		if (!IS_ALIGNED(tail->last + 1 - tail->start,
+				1UL << tail->granularity))
+			list_add(&tail->update_list, remap_list);
+	}
 	return r;
 }
 
 static int
-svm_range_split_head(struct svm_range *prange,
-		     uint64_t new_start, struct list_head *insert_list)
+svm_range_split_head(struct svm_range *prange, uint64_t new_start,
+		     struct list_head *insert_list, struct list_head *remap_list)
 {
 	struct svm_range *head;
 	int r = svm_range_split(prange, new_start, prange->last, &head);
 
-	if (!r)
+	if (!r) {
 		list_add(&head->list, insert_list);
+		if (!IS_ALIGNED(head->last + 1 - head->start,
+				1UL << head->granularity))
+			list_add(&head->update_list, remap_list);
+	}
 	return r;
 }
 
@@ -2113,7 +2121,7 @@ static int
 svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
 	      struct list_head *update_list, struct list_head *insert_list,
-	      struct list_head *remove_list)
+	      struct list_head *remove_list, struct list_head *remap_list)
 {
 	unsigned long last = start + size - 1UL;
 	struct svm_range_list *svms = &p->svms;
@@ -2129,6 +2137,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
 	INIT_LIST_HEAD(&new_list);
+	INIT_LIST_HEAD(remap_list);
 
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
@@ -2153,6 +2162,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			struct svm_range *old = prange;
 
 			prange = svm_range_clone(old);
+
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
@@ -2161,18 +2171,17 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			list_add(&old->update_list, remove_list);
 			list_add(&prange->list, insert_list);
 			list_add(&prange->update_list, update_list);
-
 			if (node->start < start) {
 				pr_debug("change old range start\n");
 				r = svm_range_split_head(prange, start,
-							 insert_list);
+							 insert_list, remap_list);
 				if (r)
 					goto out;
 			}
 			if (node->last > last) {
 				pr_debug("change old range last\n");
 				r = svm_range_split_tail(prange, last,
-							 insert_list);
+							 insert_list, remap_list);
 				if (r)
 					goto out;
 			}
@@ -3565,6 +3574,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct list_head update_list;
 	struct list_head insert_list;
 	struct list_head remove_list;
+	struct list_head remap_list;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct svm_range *next;
@@ -3596,7 +3606,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	/* Add new range and split existing ranges as needed */
 	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
-			  &insert_list, &remove_list);
+			  &insert_list, &remove_list, &remap_list);
 	if (r) {
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
@@ -3661,6 +3671,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			ret = r;
 	}
 
+	list_for_each_entry(prange, &remap_list, update_list) {
+		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
+			 prange, prange->start, prange->last);
+		mutex_lock(&prange->migrate_mutex);
+		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+					       true, true, prange->mapped_to_gpu);
+		if (r)
+			pr_debug("failed %d on remap svm range\n", r);
+		mutex_unlock(&prange->migrate_mutex);
+		if (r)
+			ret = r;
+	}
+
 	dynamic_svm_range_dump(svms);
 
 	mutex_unlock(&svms->lock);
-- 
2.32.0

