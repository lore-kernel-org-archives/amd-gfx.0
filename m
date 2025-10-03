Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC447CCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 18:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E87310E95A;
	Fri,  3 Oct 2025 18:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kY0uJClz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C000110E95A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 18:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj56fGad4IpVq+aas3KcGMJIBg6ykRw1TGEiHQIw8fRgXUwHxFC8aPDqTuyVEPoDX6Q+OZy0LJxg3USVfYCqEeS4KS4SAal/m3nJvQfmb2e/HJ5Qb58XfI3Y5qn1y2t35iI3t5X6I0WjcJaIAZJEc/7LK/xWmnVQBD98Egp/OvADKhC22SKqeaKR9hrbwL318u0veWyM2m5XeEUQqpXV6+WwEvcJiln/8g0Dp+CCgyUL+x0B+5tGjoxQKWci5eP3B3lDE5vikx7EfRwKEcExXP0XMeg4JZELJ3TvYHbdvau4KHg8FnP9QUL3BYRuR8zy0s/0l+qykObY08jrd7LFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaRh03WtVTUjcLPcvhAmbWuebRyZfubh2FkaC+XwC4k=;
 b=MRytYdH0EXVvhVwa4msCi9FTj1j3qmY/q9M7ULAcGbz589xEg7Z3UWHgbpijGQso4IBvzVltcl/jS0c+TLclTwQMkzsOKb4peK9JII+IidpZMQohD4pJDE70gAt6NAOUoI9DCB3SY8+S0yrRFvkOaJYIa8QQ1Y8OZ8KzNjLhCXaaMF2XBIbGgMLEx4GG8XaVxeq9Bquw6rw3+rcCQDjlkOE6SEtQDTXjj6z4t54KwuOGwAt1GeBLEJlrF57Lg0kO4QlggnScFeqjKV1eSfq3UbPAFuOG8ijkdGbMelQnGcmtst2E4hfbhy/NLxLaC/BG0isX1HHR/AhiME1jCUBqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaRh03WtVTUjcLPcvhAmbWuebRyZfubh2FkaC+XwC4k=;
 b=kY0uJClzjxKgFwaBrmt/svjsPud+yPXCKFIU/QzPd+0aPgEKDukkMr/ZkyVCXxxxKeZdBrglYNhqUlYY/5OZtcku9/Vn0OTPhl0Yct1Vx9gWQcCts0SE9FW2GS8knyIQXt5USLjxX/v1gDbOGPwuagJjCAfbkEaBYkAaa2j1bvY=
Received: from PH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:5::15)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 18:15:54 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::98) by PH0PR07CA0010.outlook.office365.com
 (2603:10b6:510:5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Fri,
 3 Oct 2025 18:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 18:15:54 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 11:15:50 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <harish.kasiviswanathan@amd.com>,
 <Xiaogang.Chen@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
Date: Fri, 3 Oct 2025 14:15:17 -0400
Message-ID: <20251003181518.24270-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251003181518.24270-1-Philip.Yang@amd.com>
References: <20251003181518.24270-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 438cc204-bd9a-4b57-d4c8-08de02a8e46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JESZy3JcTMiO85zP8TmsqO7yeK23i7IhczD35gD7wvk7TJoetYWPLSN6xXCq?=
 =?us-ascii?Q?PmExJUvkHzgW0ZzjVJIrlKNSP7IF28aZxLyqDax75Jsv915q/YIdzrCitbow?=
 =?us-ascii?Q?DUfiyACZyQg2lxGnCzqbeBsUo1yvDtXNRvARCEYg6T45RwXakLLy1CHgYZl+?=
 =?us-ascii?Q?NQZwhby3s+hV0L3ulADZaTE6KFiUJubd+I/sZSrxk8PgFPnPucbGoKAtCIhE?=
 =?us-ascii?Q?n05dgdHG7n8caQekazrRiOwjRzBtgz4smIBqFv3YxBKcOpH8o/+JpngCSKEP?=
 =?us-ascii?Q?wBtrtdUzSZe7nXMBVgYAHV/frKXRVeNzZYvKEfRxBmjUixL/EDOiYQG+kV5d?=
 =?us-ascii?Q?tO5TK+leZvauQ73PkGgjEcxTsfFixRg3FcJk/oKwL8kVvjsD+aZvQunsIYqo?=
 =?us-ascii?Q?219DVsMnXduje/rweitv8YL+tFHsCcV5nyHDWiggHp2Pa8ifN1gBjJFYG5Uw?=
 =?us-ascii?Q?BUAxYx3KmieO3FnZVlkjQ2Hf3ptrh+m6PHWjpulhGyhBVxRGSY+7Q+zV6WhG?=
 =?us-ascii?Q?gNsnwPDtkMhxafJUJrpMrLvhX9oaxq6yAt/ztZ9AELngl9o6RDzmw/PmrJZg?=
 =?us-ascii?Q?4YgZcM65JmYN2HdeFYACgo+J5UBGMi/EkytUIKniMG5LiUdZa3tt0nZdGPyD?=
 =?us-ascii?Q?rTHv/98C1jTwuasPSXLPw0+h8TF4I3M9mcrLbG19nW0VXcp4NWHAGn7BqmFo?=
 =?us-ascii?Q?ATPr2to0qBjqiiY2Iy08BygM3jU/CQXk+ORjTCK/dELOtlNssLoraOYuV1Ti?=
 =?us-ascii?Q?xhrGqoa700SLq/8WXESAHXnc8+grYrGX452jchEVjvODYA4phvK1skLaIXmk?=
 =?us-ascii?Q?e713kakbB0tcspmAFE3pLeOhmk7GZFbAvxNQQFhuWQU1FD3GAbxkbiTxjfoV?=
 =?us-ascii?Q?/sbYmm1GmMNFAoaizou0WtFfIJX9JZvHbNaUjGiRVpUYnM/Th1MBJODhqn1C?=
 =?us-ascii?Q?A2c5B4w8ut7iQnB6HwKSseP8gVXEJtt+LKtd5kH44YKaScr7Om+2+5vHbL9T?=
 =?us-ascii?Q?HkbhTZfqw2hHf56tyZy+aT40Ny4RvJylk3pNLGeRbt4EGfK7RlGrWVzotaYj?=
 =?us-ascii?Q?Mv/2wsnL1p5sf3RN9fmpZ2CadV20+f+7V4Yi2mBIC3kDoxYpOcQuNT0nMyU/?=
 =?us-ascii?Q?oRoGnC4+9FNVCzvJcAQlEI8w4urjtoU9i7ly317WYsAqbUX0SQpGnYi5e01C?=
 =?us-ascii?Q?gSAqgpGA4DRkC9IuqLRi0kK3XZmL/IpxZm0T8Rq0RpjKIGByqz06PjoU7wEJ?=
 =?us-ascii?Q?sbncbmtT8oWnkBN4DKTdlz1xK/keUZ0m4DvcOVN11B1HS3yxit30ARXvdob5?=
 =?us-ascii?Q?5h2l37gfoqYoXqYvrnlMVrMlLCx+YTMNBrvDWMukssFr3jQyIzjPTsag/f8j?=
 =?us-ascii?Q?5Bl2ZhvLcOuRM/fU7w9HO/OaqpRtH7nNahCRquUL7hLEPoseBPqwjt0Ny9kJ?=
 =?us-ascii?Q?9BoqbzsDKU5ljJ5BHQ4T13oikmrK2UF2F0aWMe+ctzrA5fjSDkB/TokFsIJ0?=
 =?us-ascii?Q?WV6UjyTgvyOfRfsyE22MnWxCtqUsjMQtcHAQ2zIfpbJGJNFkHpdNAKYJ/kWu?=
 =?us-ascii?Q?tM/VK/vvJqs0bb2zE88=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 18:15:54.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438cc204-bd9a-4b57-d4c8-08de02a8e46d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

If vma is not found, the application has freed the memory using madvise
MADV_FREE, but driver don't receive the unmap from CPU MMU notifier
callback, the memory is still mapped on GPUs. svm restore work will
schedule the work to retry forever. Then user queues not resumed and
cause application hangs to wait for queue finish.

svm restore work should unmap the memory range from GPUs then resume
queues. If GPU page fault happens on the unmapped address, it is
application use-after-free bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 75 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0aadd20be56a..e87c9b3533b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1708,50 +1708,51 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bool readonly;
 
 		vma = vma_lookup(mm, addr);
-		if (vma) {
-			readonly = !(vma->vm_flags & VM_WRITE);
+		next = vma ? min(vma->vm_end, end) : end;
+		npages = (next - addr) >> PAGE_SHIFT;
 
-			next = min(vma->vm_end, end);
-			npages = (next - addr) >> PAGE_SHIFT;
+		if (!vma || !(vma->vm_flags & VM_READ)) {
 			/* HMM requires at least READ permissions. If provided with PROT_NONE,
 			 * unmap the memory. If it's not already mapped, this is a no-op
 			 * If PROT_WRITE is provided without READ, warn first then unmap
+			 * If vma is not found, addr is invalid, unmap from GPUs
 			 */
-			if (!(vma->vm_flags & VM_READ)) {
-				unsigned long e, s;
-
-				svm_range_lock(prange);
-				if (vma->vm_flags & VM_WRITE)
-					pr_debug("VM_WRITE without VM_READ is not supported");
-				s = max(addr >> PAGE_SHIFT, prange->start);
-				e = s + npages - 1;
-				r = svm_range_unmap_from_gpus(prange, s, e,
-						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
-				svm_range_unlock(prange);
-				/* If unmap returns non-zero, we'll bail on the next for loop
-				 * iteration, so just leave r and continue
-				 */
-				addr = next;
-				continue;
-			}
+			unsigned long e, s;
+
+			svm_range_lock(prange);
+			if (!vma)
+				pr_debug("vma not found\n");
+			else if (vma->vm_flags & VM_WRITE)
+				pr_debug("VM_WRITE without VM_READ is not supported");
+
+			s = max(addr >> PAGE_SHIFT, prange->start);
+			e = s + npages - 1;
+			r = svm_range_unmap_from_gpus(prange, s, e,
+					       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
+			svm_range_unlock(prange);
+			/* If unmap returns non-zero, we'll bail on the next for loop
+			 * iteration, so just leave r and continue
+			 */
+			addr = next;
+			continue;
+		}
 
-			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
-			if (unlikely(!hmm_range)) {
-				r = -ENOMEM;
-			} else {
-				WRITE_ONCE(p->svms.faulting_task, current);
-				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
-							       readonly, owner,
-							       hmm_range);
-				WRITE_ONCE(p->svms.faulting_task, NULL);
-				if (r) {
-					kfree(hmm_range);
-					hmm_range = NULL;
-					pr_debug("failed %d to get svm range pages\n", r);
-				}
-			}
+		readonly = !(vma->vm_flags & VM_WRITE);
+
+		hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
+		if (unlikely(!hmm_range)) {
+			r = -ENOMEM;
 		} else {
-			r = -EFAULT;
+			WRITE_ONCE(p->svms.faulting_task, current);
+			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+						       readonly, owner,
+						       hmm_range);
+			WRITE_ONCE(p->svms.faulting_task, NULL);
+			if (r) {
+				kfree(hmm_range);
+				hmm_range = NULL;
+				pr_debug("failed %d to get svm range pages\n", r);
+			}
 		}
 
 		if (!r) {
-- 
2.49.0

