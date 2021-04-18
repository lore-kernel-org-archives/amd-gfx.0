Return-Path: <SRS0=TlT6=JP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE33C43460
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Apr 2021 17:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256DE6109F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Apr 2021 17:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256DE6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3971C89E69;
	Sun, 18 Apr 2021 17:36:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305CF89E69
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Apr 2021 17:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvAZm4aqhGBGmDU0Uvsun4fPzkGL+lSeM6XapKtDuBNxrJcg7lNGix6bVwv8d5zhPQYTGyDfrP3F6solt+7dVNO2KV8DPjCuHs6MbarQuF7yFFgQ6Xc2RNZuv6o02SMR4TBgGmJc60WsYkaARl6Jle+w2ucrpzyJTgo3QJbAzsM9XbphFcAZ4wPSZ1xoXwEkkFmEem/G8FbQViGxnkgUmHTytiAQJSqyiSurPsKDn+vpUtAeawWIGN9vaXQulWhloiVL4lYqBwqQJ77Zb+xhCiikxPyfg07CbbnGPLNnfodwLU4O9HArx7bQiOJgIw8m+EJc75cs839Hl6SJWb+5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOX5CDYH/BtetFfy/xSnFutk1jMsBea3yCJrShI1LcI=;
 b=mQ9Whw1nBBPL2FnSP7BjZdgq9fz3qpdk36rBUpWBY4631r/xj5tZBXT8VWl+1XHekFrqMXg4cbbG6S+r/Znln0w6glRsqjEUDndL7l9UXA8mM12Wfr/nJY26lheTBJS1YG3ejfCX9xJyITGZ4U5JBAEJAkRH0S3XUSx3qU4TQgKTFxUGJ35m7cVYSqZZ/exW3DDVjfgsIb2570WTb+eKtCDRG/CkPlfYTkHzbXWj5xQn5ub3tyIRFXSiJYd/ayyw7KPbESNDNnV/ILXKKnwKvJmAMQQoOVaNoh5XD/bW/38jZolixBD9Q4ktZiU2r0iMS9GeSNp8opU5OVdyxHMFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOX5CDYH/BtetFfy/xSnFutk1jMsBea3yCJrShI1LcI=;
 b=w3eA75kHtQyn5TuTlW8Ve9vHX8ErTKZhQglpPmiCzdIvN3VnhOvKeq1i41/kk6PG4aP4eIfmCNPfsVsE7kV/bml6W/tjzQTpsp+GkF2I0dMA6EYgr+jFd41OFwXM846Urfk/jkJlVm77R170s34z0Ypp23wZrEh5WC+mpuLauao=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Sun, 18 Apr 2021 17:35:57 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4042.024; Sun, 18 Apr 2021
 17:35:57 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: handle stale retry fault
Date: Sun, 18 Apr 2021 13:35:36 -0400
Message-Id: <20210418173536.5155-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210418173536.5155-1-Philip.Yang@amd.com>
References: <20210418173536.5155-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::34) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Sun, 18 Apr 2021 17:35:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05f4c8be-4831-4d29-393c-08d902906c8f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0108C19BA51189281ED44841E64A9@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppBrC5yBe/JqbJ83T0fqqUW8LH0djXjfGyAylBNmAuxJroSRw5JQPEj8GudBRZ+RGHettxSojbOpq0rbUpi3BxGBwrVuNqfoeMD8uA94OqIdPPxbp+I8weO94uZOJ8voVw+UTB5blhrinLsmBy+zKvEkc59snNsMO4goXWGPrGHM51fpDvO3VTp9unCUZoZTL5A/y7mpxEulANS4ffMAkO3zvOmR7RlV+Gnw6/qJBd+j0Y19VGkijNqBEROJ532NqWXeGV47rWB3rnqpNRtbd9i/vCdxWHiP0CEKKtvFAI2AlUQwbCf2n2i22HM6IDLkj1ClnzcogsCwPM/xjWT0aHYUxTPVkKK0y9XnOX2R5i3FnlD+ExJCxBHhqb4VaXMzeDrbSEVdw4TUQcAQsyXNIIn12VNmR51rDovcASwVF4LOVKwzEljHGtL3dzSMyEAPt69NjBWBveqz6RAQ964vl0aDzI82xE7s2RL2+2k9tjJUN/T7UKBKwjvKAq1gUtliMHO85awcr65RyOU2PCIwhxFOYA/G660xGj2bXoYAsC7RXSa6LPZju9ueu9B8y8hDJCbJpe9gRmrzjLccOTFLoO30ZVbA4h9s4NklgcKIpSXaixJHtul66Sc5bTD7GUSFG9BzZ8JWuWuCGg57SQctC5h/A17QlSZup9xfdwW63zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66476007)(66556008)(66946007)(86362001)(52116002)(7696005)(316002)(83380400001)(1076003)(5660300002)(2616005)(36756003)(16526019)(186003)(8676002)(6666004)(6486002)(38100700002)(26005)(38350700002)(956004)(6916009)(4326008)(8936002)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MUnYcmqR1rqoT/rSmMTJxx6nObAB+uqlj0XUo8j9cvUYkFfI8FnTf8mSgipT?=
 =?us-ascii?Q?66IwoqCV0wesDakt6O246M0uqWbgUaHrSqJZiOW8gDgtdtxq+wxWjg/qc0CJ?=
 =?us-ascii?Q?FzcMvw6L3zwz8wUANkVhygg16DLEkM98vWXJPCYmIXYMaDVxAoFQgPW7iJtU?=
 =?us-ascii?Q?SH0SpBj7JSNc6f8BsbZJt1hbc+16TjBmM5FP8xUrUyqxeauV7Ty7X4C402jW?=
 =?us-ascii?Q?ADfzmluc85DlsrWZQzztMQT+KuyuIYjEcOGquWCE61PvzovdNdz/fza8IR5+?=
 =?us-ascii?Q?85QjR25011VM5Q0EOOk/b70WQKxwJ8AwW2Qp6S8StfDHayQZWOVro/Oi+XGq?=
 =?us-ascii?Q?+tPrlDIlsOCBMGUTfGjExFoLXj+VW32c82aOPDDX1QdChT5U1zvkYVw66hS7?=
 =?us-ascii?Q?Kj3CPWo6XML4B3Hcch5NBoT8RJo206NxkJwW1WOf48UPPmaMHpHnoTdwOu6t?=
 =?us-ascii?Q?RNiMa13uxm+3tN+VHEC8F6jwyx4XlbYbq1Sqhe7A/dH6MFHg2XHBSwJnzWaZ?=
 =?us-ascii?Q?JodON9wMtw7Wq/eviXxKGzs/y5qVdbcAicOmdEFWGelifufOZOR1pPhIpVB0?=
 =?us-ascii?Q?eXf3DnxCNdcJqWqabIRrL6Lj44L7aVEK6AVVCbC/tQL3CKBMCB5/9QtkyKhm?=
 =?us-ascii?Q?3FfMEv+FBml/dIfDqaGheLSeRBFGENTOEpFAYwV7P/HYyVyhfaevu4UA8MpN?=
 =?us-ascii?Q?y6Ik/cZwuOQt96Tv0W2FVaWvxFjgA1E3AYoaFOlhs2ZcvZAdqXcgI4prNVTW?=
 =?us-ascii?Q?U3oBstcH5wgnZw3S2AuM5Q7FOklyORyHBZyw2aRiIqCf+LwtONFk0TkkS8m7?=
 =?us-ascii?Q?eP6FUJjLN+9G/WD7pv6vrdT3BlJiEmwoD9xr649QLhCyq0NMO25O5zitEwB5?=
 =?us-ascii?Q?tnYx9j5q28TcfcDMXSK/Vl6m+msZ+6utTzxvTgiCakZ6VAOkDaOwbfa0a9Vb?=
 =?us-ascii?Q?X76W5s3SGbKx8RosY/TdhvW+i1DfHMjfNyWlvY9ZWxSsJ976bxgsHlmVjWiD?=
 =?us-ascii?Q?GQbHJrPG8dSxDri/dlXCdH1ZHmIvjVsmZ4qI5VoPG0vyJ5SCRwHp6WGjAaSY?=
 =?us-ascii?Q?T3Dy7EVYfnE6aNOTIaC+Ji2yqNsg76oLEbc0fUWsPWRUYXi6P2u/JziKp4K1?=
 =?us-ascii?Q?XZA/esBkyYP/tIY1NkpEWHeCiRCpLOncima4jrnKX8lIS8AZ9OhjkGZzF7VL?=
 =?us-ascii?Q?X555/ogsB3dcUWq2uguNB24p2xiCKzH5PgptWORjPAQVsaREfBufBGyMWSCU?=
 =?us-ascii?Q?ULxAORfKFtVjPFhFrtXeQN7x0/s6BQj5CdTCkbZ0bmHAY8QiVejjRdDZtwpV?=
 =?us-ascii?Q?9pHPW+FnkO7xme/nmw8qxw1Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f4c8be-4831-4d29-393c-08d902906c8f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2021 17:35:57.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1Gdi9dfCIE2J8K1tvMoI90/GToJzZxTD5TZf66hX0uhQYcscgqyoM2QWkcWBsiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Retry fault interrupt maybe pending in IH ring after GPU page table is
updated to recover the vm fault, because each page of the range generate
retry fault interrupt. There is race if application unmap range to
remove and free the range first and then retry fault work restore_pages
handle the retry fault interrupt, because range can not be found, this
vm fault can not be recovered and report incorrect GPU vm fault to
application.

Before unmap to remove and free range, drain retry fault interrupt from
IH ring1 to ensure no retry fault comes after the range is removed.

Drain retry fault interrupt skip the range which is on deferred list to
remove, or the range is child range, which is split by unmap, does not
add to svms and have interval notifier.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 75 +++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0e0b4ffd20ab..45dd055118eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1402,11 +1402,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_lock(prange);
 	if (!prange->actual_loc) {
 		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 			goto unlock_out;
 		}
 	}
 	if (!list_empty(&prange->child_list)) {
+		pr_debug("range split by unmap in parallel, validate again\n");
 		r = -EAGAIN;
 		goto unlock_out;
 	}
@@ -1828,6 +1830,28 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
 	}
 }
 
+static void svm_range_drain_retry_fault(struct svm_range_list *svms)
+{
+	struct kfd_process_device *pdd;
+	struct amdgpu_device *adev;
+	struct kfd_process *p;
+	uint32_t i;
+
+	p = container_of(svms, struct kfd_process, svms);
+
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
+		if (!pdd)
+			continue;
+
+		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
+		adev = (struct amdgpu_device *)pdd->dev->kgd;
+
+		amdgpu_ih_wait_on_checkpoint_process(adev, &adev->irq.ih1);
+		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
+	}
+}
+
 static void svm_range_deferred_list_work(struct work_struct *work)
 {
 	struct svm_range_list *svms;
@@ -1845,6 +1869,10 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
 			 prange->start, prange->last, prange->work_item.op);
 
+		/* Make sure no stale retry fault coming after range is freed */
+		if (prange->work_item.op == SVM_OP_UNMAP_RANGE)
+			svm_range_drain_retry_fault(prange->svms);
+
 		mm = prange->work_item.mm;
 		mmap_write_lock(mm);
 		mutex_lock(&svms->lock);
@@ -2152,6 +2180,44 @@ svm_range_best_restore_location(struct svm_range *prange,
 	return -1;
 }
 
+/* svm_range_skip_recover - decide if prange can be recovered
+ * @prange: svm range structure
+ *
+ * GPU vm retry fault handle skip recover the range for cases:
+ * 1. prange is on deferred list to be removed after unmap, it is stale fault,
+ *    deferred list work will drain the stale fault before free the prange.
+ * 2. prange is on deferred list to add interval notifier after split, or
+ * 3. prange is child range, it is split from parent prange, recover later
+ *    after interval notifier is added.
+ *
+ * Return: true to skip recover, false to recover
+ */
+static bool svm_range_skip_recover(struct svm_range *prange)
+{
+	struct svm_range_list *svms = prange->svms;
+
+	spin_lock(&svms->deferred_list_lock);
+	if (list_empty(&prange->deferred_list) &&
+	    list_empty(&prange->child_list)) {
+		spin_unlock(&svms->deferred_list_lock);
+		return false;
+	}
+	spin_unlock(&svms->deferred_list_lock);
+
+	if (prange->work_item.op == SVM_OP_UNMAP_RANGE) {
+		pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] unmapped\n",
+			 svms, prange, prange->start, prange->last);
+		return true;
+	}
+	if (prange->work_item.op == SVM_OP_ADD_RANGE_AND_MAP ||
+	    prange->work_item.op == SVM_OP_ADD_RANGE) {
+		pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] not added yet\n",
+			 svms, prange, prange->start, prange->last);
+		return true;
+	}
+	return false;
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint64_t addr)
@@ -2187,7 +2253,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 	mutex_lock(&svms->lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
-
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
 			 svms, addr);
@@ -2196,6 +2261,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 
 	mutex_lock(&prange->migrate_mutex);
+
+	if (svm_range_skip_recover(prange))
+		goto out_unlock_range;
+
 	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
 	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
@@ -2254,6 +2323,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 out:
 	kfd_unref_process(p);
 
+	if (r == -EAGAIN) {
+		pr_debug("recover vm fault later\n");
+		r = 0;
+	}
 	return r;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
