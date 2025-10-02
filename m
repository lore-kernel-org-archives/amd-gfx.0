Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E5CAC5B8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2620210E823;
	Thu,  2 Oct 2025 17:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WiS5Ut+p";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93B610E824
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfj609UMDOSNF5BmFi00yTQHtk4hoVT6ERPxRQ/f26LaYshtcddeESuwEl++e2suGTMahLjpOLim6t1+c5oQq2zTxES7xeOIsoSZs5HcG/L1wPGyY05qWR4htLxFnzZeFq6eKZ+ot8uUw86WOwEOp5WcHFpd+PtNuKrubKEcu88ZuxYDIjsNga8IiDjDJ6c7w68LBvHNCr+bxC9QWtYyU0oohtp9OUR6cWIC+duVZwalYbbp9RWjAT5iCi4TowGuEtXCSC+n3zR/omW5eSHJ7Bsy+sVPvEAyhoJx1D6KKVdTfrCmu++rvg/7L8WrgB2Q9XQBUHltzyYytGwCvFK+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5er6FI3CkLut0fKu6DlIvd+Wory5/RdIlwlOhgfxyKI=;
 b=c5boGFbEVL6DgtMDpe6F3xtar4pmPH4iuKSlDHyuSKCKqzlyy82qKwzTwDBhXr2KtUDxCjHVsbNjd4WZjrJVSYvjG1FSYRiNg5a342eqQiqxX6Urjw5ykiBNfqF4Ra1cAsKZ11nBzFPW0Rht1U3lkwrNRPSHEZ4+uZ2xaMmHnIkAnEeHwJPYbd5VZKnz3M6Z2YJR0d0u+FJ240+R9MX+eQjge6m/oyvaRs9sqScHTkyOL4OSls5JI9TCmx6P7AyQLSCzsJmxqx2O73WyHiRHP6RSiltFj9FEs76AZWUfm31lIqJ4lUPAQldtOkdZIPyBdq3EU/xnHIEiN0bUuxQkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5er6FI3CkLut0fKu6DlIvd+Wory5/RdIlwlOhgfxyKI=;
 b=WiS5Ut+p2I22eMGE5930I6FPQilt8UvmactxN8jFAUXfOSXBLA7sItFoDwVj88JcxeEOF/qg8Rv8h4044Zqffx8T9CxjLk7uO/WUIyCVllQw+ydKG7rE9wGijRhhDR0ze0fdz0NGY1x4qZ3t7Hmw6b1nIQ5L8yOdLRk7jguMHTg=
Received: from BYAPR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:40::14)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 17:43:39 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::f7) by BYAPR04CA0001.outlook.office365.com
 (2603:10b6:a03:40::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 10:43:32 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <harish.kasiviswanathan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Don't stuck in svm restore worker
Date: Thu, 2 Oct 2025 13:43:07 -0400
Message-ID: <20251002174307.10583-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251002174307.10583-1-Philip.Yang@amd.com>
References: <20251002174307.10583-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c869ca6-ec95-43ae-f6ba-08de01db383b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2CDuaPbLS0j7WT/VVLRRT5dYOu04dQTlsbuUphXJX8BUk+KkqE71GLuv/u/5?=
 =?us-ascii?Q?5NWnoFhoEdYl47oARugXhbTMlGJTeMSY/BwLY3gS9mvN5QcpMAaEJf/+k5Cn?=
 =?us-ascii?Q?59oyYSsomkIAbVJ4TxwYbJOC/tFrY08QBRdjKYBuWdL8IsTELr5oSd9LXt1T?=
 =?us-ascii?Q?TX6K2GA/bIT9gV/wYC6jUyC6gmgWH9s7mEkn2sMX5dybT5RuA4ED30tZju+5?=
 =?us-ascii?Q?zyuCoW0D3ORLEYsbmlBO1ZtUqb7HhG7sLNq26r7/ipYtTtNDEyD2hPZZjtgu?=
 =?us-ascii?Q?9xBJxM72o65mIWORhNHy2nAPmbG59vU3wSmezw/7c6EJuv5GMW4fd3qbjO7j?=
 =?us-ascii?Q?44m2w1WaEYzrd+UmoGxbKcQ9ZZkGq6OiiUi40VaO08G7Y8BlnLGagxPyP/qp?=
 =?us-ascii?Q?Ak+vGI/TnSxRHMsh5uiQGPg6i9CzSC8IsJ00dGZuYM5IoB7/S/upJ+q/3vny?=
 =?us-ascii?Q?GGAFU0nBg/LsKb6bT9r3edDn5S5j4gwFpbuEdvTuk9JTnAnmnCV2bUYax4qm?=
 =?us-ascii?Q?LFKSedIYTND2QhZbE/r4WMHoSqru+fpIqDNHuPKLAFubcsOlA7QpAiRRPsr1?=
 =?us-ascii?Q?LvdU0xk9R+Kv2axseZ5lC9W6A3FLVoi6qr6Ig88h107u+eIoeQNxcJFWag6C?=
 =?us-ascii?Q?XHtHCYVpfgfCTQO7TPckrWMLt/fXap++ukPe6wD8gEaCXscjJ2nwWYB9WQYi?=
 =?us-ascii?Q?97VDrzVnffqKVaPf9nWeK4brucfhnZom9/wIFyTBgsf989QGLr7PCRR6Gr5m?=
 =?us-ascii?Q?WOZSrwtm06+vI2erhdtT3XoNj+9fFKDs/svHMvb36D94/iY5rJj75FRrLAyq?=
 =?us-ascii?Q?8rXsV26AXkd+VEnUnxl8IPlxUWNYzQasHaHbCiS1Be0dU63BXHRT1JTU8hGI?=
 =?us-ascii?Q?TE4v7S7UfJ6e6cJxJ9x2SX0i8WusUhyayTlopAkye5Ftcz6bafUcLcNohY1e?=
 =?us-ascii?Q?wdm0puLzke4R95QztWnPyTkmgkKEQV89vp9UCeRenz+YtkS48uy0021EgETu?=
 =?us-ascii?Q?2nhzb+bPJNZT1uO4SSdicrVHLw0iaBdD5sG6IFMVXB04nzyIe0EpaN6xsPlV?=
 =?us-ascii?Q?VMY6Yjq0pNDmUxj906jqQjshUD+eoGr/7AiQhMaMpmHQ6oUXR8tHNGwWDGT2?=
 =?us-ascii?Q?1yS9sQdE4RA3UJuX4iqUTpdXdZ7+j5mfaozVcZ26VqH6GfZgS/ly48VhzTnr?=
 =?us-ascii?Q?l4RKnWB8SbV+1Q3itIEJP5+3N91e4BzEfm/ywSZGBXf09+N8MBCyrpX0AY4E?=
 =?us-ascii?Q?L8bDkUurQuI97rQyFdk0ZNV/zU0PwFK+zY0WVkuA5mK3Kt7xDWLX8Af806S2?=
 =?us-ascii?Q?JpqeItgo81S9rpc6e0iWX43mqsqMgdNtzBE7IkgjTqdJDoKFcAwS4rz9dWG2?=
 =?us-ascii?Q?5HuH3EZ1ORMS1xYN23ki9oqT6w2054sormKrFpo9fRoeOTSK4APND/cc+rKy?=
 =?us-ascii?Q?2OpnTqHwYBSQ1C9I2GUU1XjcfPC9agopMUwhIYpB7D9Z19Wx4AZkndiZfBh+?=
 =?us-ascii?Q?F9Tw7yAWKRU9jIeuafvR4q54sJJ0/pEuP7A7thfUiNt5nBZuhRZN1RTp9wI4?=
 =?us-ascii?Q?pA2nx/iCYkjtBtmlAT0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:38.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c869ca6-ec95-43ae-f6ba-08de01db383b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 78 ++++++++++++++--------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 742c28833650..608a25c6c865 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1708,51 +1708,53 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bool readonly;
 
 		vma = vma_lookup(mm, addr);
-		if (vma) {
-			readonly = !(vma->vm_flags & VM_WRITE);
+		next = vma ? min(vma->vm_end, end) : end;
 
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
-				s = max(start >> PAGE_SHIFT, prange->start);
-				e = min((end - 1) >> PAGE_SHIFT, prange->last);
-				if (e >= s)
-					r = svm_range_unmap_from_gpus(prange, s, e,
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
+
+			if (!vma)
+				pr_debug("vma not found\n");
+			else if (vma->vm_flags & VM_WRITE)
+				pr_debug("VM_WRITE without VM_READ is not supported");
+
+			s = max(start >> PAGE_SHIFT, prange->start);
+			e = min((end - 1) >> PAGE_SHIFT, prange->last);
+			if (e >= s)
+				r = svm_range_unmap_from_gpus(prange, s, e,
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
+		npages = (next - addr) >> PAGE_SHIFT;
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

