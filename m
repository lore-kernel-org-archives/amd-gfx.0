Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3302CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 20:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390A710E53A;
	Thu, 19 Oct 2023 20:51:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B770A10E53A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 20:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GskHhk6ccg6Bim+xqRZTOOdUf3Wt5E3l4EkMWN8dgVjlHVoGrwcZ/RUXde3yzr74zLvc/QHkqsrmJsmZoanWYr64K+smG/dKWg/O2nm9ywhgxvjdhaJkhlxh93dIIqRjKbs2D3/40fuYL01vZUqYKPxNf92Q0AELvoc6Z22zjW2MDjB2E2EYzbwAUuXWpK0goqWYRO81UiiNGW4mN3j9oI4mI4zji/7qumf4z8m3k+RvyZtp70b/LNQ0HUfQzyfIxVJ5VQHqx25vE69nc/7mCbLeO1H6cBVR6AGcEHHZ4zxkME/V0ACNlHPK7AfPczlQaIQjKSYy6TxGxysJCnIUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbmys3BL2jlB1yIJi3PIb25Ecw9m4nK1FNqTh9kArt0=;
 b=XTbGqH+J0BW4ypLx16IcWKwwhxs27bLgIPDaufaKHE/oDws/iVaUM2smwr0QXPJf44sNH5+5T6Lavd+Z7qZ0a3XWwIk9LTb/3iYyB95pvfl2ygHwfJIJqxuHGFYOfOwP5Ree/1Y+QFlCssR6vp4RK+DQa/4qjdDTv987iNxXKMBahZ4MUciqT2WgJjpFf874+IwP41GPWI01F9qZr64ms2FrxFXZaR1oWudTbFu5oanU4U5Hl7MzmXCM5GF7kJZSAxZyZw0fyqz5bstJ87ElrT4PcFnzr+8iTPdXNWViQQD0PU0TZECBIPKpiHEbTT7+ZQ3fF44YbljF9MlGS/CbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbmys3BL2jlB1yIJi3PIb25Ecw9m4nK1FNqTh9kArt0=;
 b=Xm5fWUbM9eeotrdqfiyMEtser9kxDBk1nMHkCVxrR67O2MbPf7IdwPItmR++LbUL9nRKikpNBpYcyra91uWhq9sAu671mw4OlmtCX4jGU462/99blxvtNct5Tw669HRtLJN+uAx0ySvvwSqaoBcmsOYxNb0H5LY9lSCjZZeynIY=
Received: from CYZPR14CA0005.namprd14.prod.outlook.com (2603:10b6:930:8f::24)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 20:51:22 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::66) by CYZPR14CA0005.outlook.office365.com
 (2603:10b6:930:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 20:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 20:51:22 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 15:51:21 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: remap unaligned svm ranges that have split
Date: Thu, 19 Oct 2023 15:51:05 -0500
Message-ID: <20231019205105.22624-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231018222607.9872-1-alex.sierra@amd.com>
References: <20231018222607.9872-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 03563e87-f687-482e-9157-08dbd0e52702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlJ4yPDHVzYIVfRQruZMD1xYTT0vguBVtQrEnveHoZbbJ5jBPz3TNLAUiiJ0lSHmxv3FQ5/hKQcUDY3Vhb+amUURy1AWnHQyvjUm/TvCG8lLUsFDLbOWGif3kuHKTjsO/GXHqrCi7wXBr7CXRXevZOGRw69991HNzuLesAt7Edd5jDQ+SVCcAKNcsUU59zGQDOvJSMeDX0DNU47IE2sWswN97M/9hICwTssD+/MTkfui7IlQ3wu2EKP/Ul6W3PYmuMCwI/i5gOMyW99qc59cDgkuR1gCm2OPWipmIv3yyXfPOJc8DoXykq20K0hFOWFMopVflnduHcN4P+fFsDiZn0sjaD68mPJc6iO1kW+mMCSr57McxfKmQZRZidkwMUv4S3SnMCS6fKLXB/Cj8gdclBYm7qgh/k2o7qGh9oGSKSflV6p8g+gBTTbwJbPwMTuthphR7Ck9D7fX28Et5zGCT0yBbGU3skEjYqbJdtowua62J8cEY2GyNcNR+QcxBy8wFsdQvjQEeRn9rSO8lq4Sd17QlFThOSZsELZd+9oABJ/sfZFXx28RmIZTjr8ro/FFJWLiVvObNXVaQPnCuHkw73PccNAYZvAu0n/+7qUVpla/29/R14d/+reC5Mtqtb3CJkZX7J4VA7BmONeowJo81lImotjC+9v7i793OzBnrt+Vf9IlDfZwqPK6idVAQ7WyiJpG7mG+FUsJKUuUYON69/N25KCZnUTFgSZLAMHs7Dbv7Ja+WzAIPex8iTiF6F4hCoAlWWajNp6h5bMsT2b/qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(5660300002)(36756003)(8676002)(44832011)(8936002)(4326008)(40480700001)(41300700001)(316002)(110136005)(54906003)(70206006)(70586007)(86362001)(6636002)(478600001)(7696005)(6666004)(2616005)(1076003)(426003)(81166007)(356005)(82740400003)(26005)(36860700001)(336012)(16526019)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:51:22.2687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03563e87-f687-482e-9157-08dbd0e52702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 43 +++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7b81233bc9ae..aa2996d6f818 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1104,26 +1104,32 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
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
+		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
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
+		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
+			list_add(&head->update_list, remap_list);
+	}
 	return r;
 }
 
@@ -2113,7 +2119,7 @@ static int
 svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
 	      struct list_head *update_list, struct list_head *insert_list,
-	      struct list_head *remove_list)
+	      struct list_head *remove_list, struct list_head *remap_list)
 {
 	unsigned long last = start + size - 1UL;
 	struct svm_range_list *svms = &p->svms;
@@ -2129,6 +2135,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
 	INIT_LIST_HEAD(&new_list);
+	INIT_LIST_HEAD(remap_list);
 
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
@@ -2153,6 +2160,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			struct svm_range *old = prange;
 
 			prange = svm_range_clone(old);
+
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
@@ -2161,18 +2169,17 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
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
@@ -3565,6 +3572,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct list_head update_list;
 	struct list_head insert_list;
 	struct list_head remove_list;
+	struct list_head remap_list;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct svm_range *next;
@@ -3596,7 +3604,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	/* Add new range and split existing ranges as needed */
 	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
-			  &insert_list, &remove_list);
+			  &insert_list, &remove_list, &remap_list);
 	if (r) {
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
@@ -3661,6 +3669,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
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

