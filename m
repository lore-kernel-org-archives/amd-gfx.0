Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8285C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A293613C4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A293613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0FD6E8C9;
	Tue, 20 Apr 2021 20:21:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B9076E8C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 20:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCnvZ/2pN0+GbLi9BTj+oQWDYBXarpWB1cVFkPOBZw0ocrE33yAYrAGMkZjEWg2gz8HLpuCxyqLqJqv+UO0A7AqucLENNXhTF0LEDEYRHeX8j+7nV57IiWnhcIG1eYVlGU4MJ/9USve3AJd1u1GWyOf4KS0+kSKfMvOKfvBYaVTHUIDyzfiukx1DyAiLvxTR2W6JbgSDHpSWhzkpZky8wj9p4NMmOOcuatKgDUEIs4ZfkoS8qZPRL3+fp4gYQery6giKcx8gHwBU1wy2fkINqZq+L6lfbVEIUmPMmyP0wXMsq5dm8sf+D9J8b51OXm52U+zwcx1AOHhYYOWzOyfQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6RZfwHV059jYedbpgyrhNv+0uj50fzRD9Y7WmwKt6k=;
 b=MB5XmTbgM5eQce4QVfhJ+ztHDPW8FyAktGo1xIyHSyTcmKLTCYHP5NXIzm9ikS2pQI6/OWU+2fJ17unCjWfU4dQkKAa5SDb88ZPvxC00mhpyKopUmChKusO5Ljmlz4u8XeeTECu2lHLE6fs6SSZklSMbN3u6hep5BT0SKFP+b1SkLLleJA0Ozt3a3/hfM2tFFVEaM9jkEu7W8NAqnHbt5+Z8CxmTqasmvIwixdAj4gZOwRzWi7DZEM25gaYGk4wFz3P2fxohEVhwEIgKkIKcoTZlcGY80jBFFidH8RuHt2IW/ouHcezeiog5duwPrX+CdItSAse29Sm9LqJ8Nfzg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6RZfwHV059jYedbpgyrhNv+0uj50fzRD9Y7WmwKt6k=;
 b=VrE/zDjoxgyF4cmAeMxb9vEOwWIdVl53lhsAl+Na7e5aNLRg+Pew+3xwWOApefYMfZaob9E0aa0D1yZcNwRWuECrNlECoIZ+5/5dArn/1Vp09nXejcOT2Xp43SXoLDT6nRM0gri7qhKpj6k+AGjuVh1rYMLmJMVRpML/wXDoC80=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Tue, 20 Apr 2021 20:21:40 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 20:21:40 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdkfd: handle stale retry fault
Date: Tue, 20 Apr 2021 16:21:20 -0400
Message-Id: <20210420202122.4701-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210420202122.4701-1-Philip.Yang@amd.com>
References: <20210420202122.4701-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 20:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f649cfda-fef4-4ef6-3a36-08d90439e83f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488B5A0761FC23FAC2A9AA6E6489@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVC84kt2O4jBk9WvwR1aGZVpGNGbM49D6j3hJR67G/j2JofNm8bI0RUl9XkwpUpJ9eHWF11ImYgMMNLgP6QABxBZGr27lcSYi9d+3qXYkGUb5j6VLeeb7UHvmv1fBKVLNVz7YETVSnUHNI4o/JVfslrzdYDtE39a3kiIiDaML06zzGuES6JS9nm6G+PnfRJl7ZBQ4RI8UhHKxWywyXRg4I8yBrFoz9bDOgpi4oAHkUsrwlTUKGVyY5uFtrLR7WEHkIABFTyfeOWpVPo/HKFvJUm5RgmtbuBbrCJr6t9/vYRyzDRNATSYBeZYDZjay43Ao9/A02A3HB4yOiPTR4elAutaza7STsMfB8ZzQmmTnXtKN3SfcRuMuj2c9yNB7sXarleB7XZgXjtMcxK7lM3FoZG8/b33J8OmewwZjbbHKecoC5u2wexVBqWqBYb8Mgccut0KNQr6sVCPQ2NXijgvkIUh+I0uhZWlBowEAWsqQf8e4uDG7GlOSoJDc8r2ps+SY1RM4XrSR3cnUIB1P5AvrEXoqDk4aV0AtBMk9HEM+OXRkEbAL/YIlKaACud0kLVzl13beFcn9C0o2pmBv+Iapcdav7PZY4SMeDotP7EBGrktodnWNHE5o4jawHSDYgtSL6k64rh4R2LlptCYRkLpCUKzpWq4DO/OefvCfENlePU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(38100700002)(83380400001)(52116002)(66556008)(38350700002)(1076003)(2616005)(956004)(316002)(2906002)(6486002)(6916009)(36756003)(5660300002)(16526019)(7696005)(8676002)(6666004)(26005)(186003)(478600001)(66476007)(8936002)(4326008)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iLcJ1gnjOQjt6mUdkekTwRtfZSVVCtnsTWejkhY/4b6yIFGw/DyEV+AiDjRN?=
 =?us-ascii?Q?enzAFfH8t/xCLLDvei6tM7nni6kciLTpekaXWBMqsh9hhWroD03zZ+qtB6T3?=
 =?us-ascii?Q?sSGt67g/t6yiarEWuL0ZE58Z+kMC6Xgw5cexSsyy9UTmETHo2QULZXLf3o6g?=
 =?us-ascii?Q?2v45YNZsxDQajX9JuzO2CHesFzvULLB3Y7N8awy6s6inM/xeQCqUcHRfimaV?=
 =?us-ascii?Q?/6C3f5mcF4bPMN+cFzZBZgE2jnZb7HfejdMXMa3mwaZoSLt8JZW+qkzwISLw?=
 =?us-ascii?Q?lcGY/fteqPPlnO0jOaKyY24xLjUDQlxf7TJk1wZn4bfB49015PYw2K+Z8j/f?=
 =?us-ascii?Q?jBLaBx1OV7yyuXc4mATZB/0rD9qED9BESzn6FCKfnD9U093gNq1p6GiUH8fb?=
 =?us-ascii?Q?dkprhqTMP7qI+h3yiTT2lTmtQ4u1xJwzg6uHfo5EfnXgEq3qUCtPOpbY1rSp?=
 =?us-ascii?Q?N6FX/Nf4d+wJJcX5v3yWISmslm52PndhFIdWT7MrMyh6xpM4FC0GRlO91kqm?=
 =?us-ascii?Q?19c/gfq2NvEhERQuqY0t/zARnChGpfVZ7u0ctEVzHUkodwlp9JQxzZaf6ZMW?=
 =?us-ascii?Q?py0RZoEuQN9+9rC7yiN6nqsE5cL3+3uZkHwIh/Ovq3vX3XvVHR1GtfmohSpL?=
 =?us-ascii?Q?6YOkQJX6Jw4O+DQC1rLDOQ9UTCCCVe3paHA7DenF0c56qKd9WL+0SQfM5+Zw?=
 =?us-ascii?Q?UZdj9n9Ovyh4c1HyG46UL5+ozCUsF1WMr4dRDmwf4wkqUKrjQWfq3QMCjyul?=
 =?us-ascii?Q?cEChy3I3UgMYEGESZtRFwrKhsbGSRLJIpYy4sIFxE3CyzsVu33wNgFYaetWt?=
 =?us-ascii?Q?7oqDz7hwcwPWLhnR6Ma+V/4BNbZntJ1AAkU8cftrEqIVw5Z25kpug3+i4Y+H?=
 =?us-ascii?Q?MTaksILH5pGq+H1SCz/30a5EuFBc1MZDrsWHrOHWof77CKyJ0C7JhN1OCG3Y?=
 =?us-ascii?Q?QMQrZ0ou4zeCacLkQsA0ctRtMEu1bxlkjO2t5Hc1SvGyOUJ9C3Y7JX1MaCKp?=
 =?us-ascii?Q?BZrrn5eFmqPjhBdQhTDhKm8I1+cJxxy1hHwtd/zY+pPtfCJNzYtt/p3crODJ?=
 =?us-ascii?Q?tY17iUuTqvtcxdl5aYZ+6hkR8QzKVu5G/x2FHrwIfqjzScQb7FDDrwOQXBhP?=
 =?us-ascii?Q?sKWqlREgMZmJdd0MuXMgOOEkUz3WjF7kaPYu7Ud7M1s1rrWBiqTfHct04Jcx?=
 =?us-ascii?Q?B0XfKCXKSaZ5E7g72I83Uqtt9fjOLjXuZwYjUs6WiKIURXie+u/HYw//FQtW?=
 =?us-ascii?Q?A0+jcmFTFxUHN2N4XnwZ9I7y1OEPK3Dzzn4elCrjCbyWNlrxs9wth8vp6fkb?=
 =?us-ascii?Q?a8njzjuEET9p+pc+JqiOA2dV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f649cfda-fef4-4ef6-3a36-08d90439e83f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 20:21:40.7209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyPS9LdicTptRfcusKZkfYU2V0xZY8y10HIP3LxIh9ntj1AyrhgTbcrbqva6gyh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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

Retry fault interrupt maybe pending in IH ring after GPU page table
is updated to recover the vm fault, because each page of the range
generate retry fault interrupt. There is race if application unmap
range to remove and free the range first and then retry fault work
restore_pages handle the retry fault interrupt, because range can not be
found, this vm fault can not be recovered and report incorrect GPU vm
fault to application.

Before unmap to remove and free range, drain retry fault interrupt
from IH ring1 to ensure no retry fault comes after the range is removed.

Drain retry fault interrupt skip the range which is on deferred list
to remove, or the range is child range, which is split by unmap, does
not add to svms and have interval notifier.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 69 +++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 40ef5709d0a7..45dd055118eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1830,6 +1830,28 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
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
@@ -1847,6 +1869,10 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
 			 prange->start, prange->last, prange->work_item.op);
 
+		/* Make sure no stale retry fault coming after range is freed */
+		if (prange->work_item.op == SVM_OP_UNMAP_RANGE)
+			svm_range_drain_retry_fault(prange->svms);
+
 		mm = prange->work_item.mm;
 		mmap_write_lock(mm);
 		mutex_lock(&svms->lock);
@@ -2154,6 +2180,44 @@ svm_range_best_restore_location(struct svm_range *prange,
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
@@ -2189,7 +2253,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 	mutex_lock(&svms->lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
-
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
 			 svms, addr);
@@ -2198,6 +2261,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 
 	mutex_lock(&prange->migrate_mutex);
+
+	if (svm_range_skip_recover(prange))
+		goto out_unlock_range;
+
 	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
 	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
