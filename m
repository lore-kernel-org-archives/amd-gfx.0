Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D1FC3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 20:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BAC10E518;
	Mon, 15 Jul 2024 20:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHNwATwW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8663610E518
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 20:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW2hWk1m391drCgqrS0gljArQKfPeeDSNvOzbB/5V/xyTcHMbPbrXrwVODfC/r+eYXqZdBEJJ0lTW2FpuBVd/29CSNgV+GsQ9cj1ra80J5cUZUdgft58UNVJ5DNyca4wX50zwnZG0aN1cXJW52IokqSlEqIyAa4M4hL9bOHKB0j7Ljkvpmo1dObXUx2dGgKOp+GuKUZbw6e5ggJoTowYnwfQFioFTYZq2/80EmcG2XUQ/63FOwnpbEyZIoRwwP6XIPc3aC3eG25uPzi9NIxZmob7oRL/PZsWms3RP32gd8UbPV9tF5RucT890cpJfV7XNyJNmCvJ1ovW4rr7OjsDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tINvGPsM8sOGdMiqJseMeNdxsCI/RIwPvGJShlTnrA=;
 b=zQlRLPT1pCopu1rjVcoDd+wETmqo3Qi58xOWcakh/vcUopUg1vK9eko34TRO36ybvCa3Y9BQ+16i6owHTSkivfGriMMAf0dFdhPMbfomCrqMRjkrZAlkxYVxNGvyXhY7SAS6IFGunA4msIoWe633dOmQ0fsHMr630eWpmqdTmECBioSY2/d9BTtD3hqdhSeolpkOnRxe7LRkG8WMkpEaOVgz/t3uqGWI8ghInlP3shUNkAkI6OxCERImhKF7dvFaMtpi8ZIldzLgeQwyHf5Ny22eze1sEyMjF1emfvfUXQo6YEdQKCKG9TuBPLgbH9c8f3jKq3ey3Mnf1t0GTCLbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tINvGPsM8sOGdMiqJseMeNdxsCI/RIwPvGJShlTnrA=;
 b=fHNwATwWD0SCOuFpKlvXCrhaP2e9Fs15hRSM2ZM4QcPrG6ywFg8I7DWp9klNBKAvr94r9lKsiJIvgZCVB1BX6w8pIgteMc60Cbvm03HN/5KLBoY+BSZQ10yq6NTVDw4XcwZcCvO5jiJx/rsE6K8yMDML3dbaGmNu9HCYbpE146A=
Received: from SA9PR10CA0007.namprd10.prod.outlook.com (2603:10b6:806:a7::12)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 20:17:37 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::c2) by SA9PR10CA0007.outlook.office365.com
 (2603:10b6:806:a7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 20:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 20:17:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 15:17:36 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 15 Jul 2024 15:17:31 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>, "Xiaogang
 . Chen" <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: change kfd/svm page fault drain handling
Date: Mon, 15 Jul 2024 15:19:35 -0500
Message-ID: <20240715201935.20165-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1deb0c3f-28d8-4f0a-3ab3-08dca50b2b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h//4WZpc+dlNJnNoYIuFXVn5G026uCU5KcrmE6AkCKvf6ICT/92yFyrWn+Vg?=
 =?us-ascii?Q?cGDKjkOMKnPwn1+ImnQlb0nMUzkWk7yiCA7qyTSpHKL6/8WUER9barzscuW0?=
 =?us-ascii?Q?9cJXv6ID9lgqaCm+Pph+6fAQfsIvoguDSpE7zI41Wv/Rn4uBVbmiAjW8SzE8?=
 =?us-ascii?Q?RagWO6iR7a28Q4Wz6IrNZhFFKBIihuz85qOujCrL5zsb9KFYQ3A3J3WbltDX?=
 =?us-ascii?Q?sF5ocQwj9yi036MTcSRz9PwTH9YiRBAPRaUjdaqfI1Df4dFUz4RI3h5upRpu?=
 =?us-ascii?Q?hyz+htsfusK4zSNPiklztXkxpGFsp0RQWIPRh+4Piemco6AAUN3qJPTia7ih?=
 =?us-ascii?Q?bvP23VuCIp4KsKmKpoPb234yamh6oewCMWysXjaz9OHJqxrMUG8Al4EAPwSs?=
 =?us-ascii?Q?RjUfoBY4cVlh69c36ciDk2pOEsvcG4YhcsUgwrlZy5QRPqnWGNVBde/53Jv9?=
 =?us-ascii?Q?6hKvtELP/Rndlprdlt7it0/o9tbvkEWxw1LnAioeMlTQ62BhWb27M+aeZDCl?=
 =?us-ascii?Q?PwWlvFhzOyt7xLVOTUwKqEzHbC3333hZ4urJ1X9pUOhwDiGeugP1BJOQvxzA?=
 =?us-ascii?Q?qg9mHkC5H2TQx3PREze8/q6p/k/wepyoPaBlhqur/yPIomqnWqajb+cuqweA?=
 =?us-ascii?Q?Z1995JoOnQQ6ap9YyBRiOKsXjRRscxwaWEEzJJIWa7TZ5LImCy0HaQ4Pvjwv?=
 =?us-ascii?Q?M2yZyHEDmmvMkhgbkscDEzn2grC2mUkw+x4d9w6z/LFKMJzmreqkUcqzm744?=
 =?us-ascii?Q?psewwLiwJLlBQlcYt6TMOvjJNv6ajlys+rv5N8FIZjLETDlbz/wbDIwBl3Nk?=
 =?us-ascii?Q?xxNsGOFv8c10gHlg1+YP+GUXTXWWXgpbaioCUMkGMtljkmQFuZ0Lp49Ppo2l?=
 =?us-ascii?Q?QpUPDBs1GIo0W3M6amlW2cVBrEpVB/gdx8u+Cy5NSz1mLrYuJ8BuXnsfI4+y?=
 =?us-ascii?Q?0fAmRY27VzNu4i06TLN6mhlTnqMybaLJsdQ5Pn0KcX0nJ09r8j+0VRzJP/dp?=
 =?us-ascii?Q?QxpIUHgZ+whl3BaLCV29VA3v3yN8YCYy7asqrcz8wZNi7YpQ4vs23fQCaNhs?=
 =?us-ascii?Q?jvCu9DDdHsp5nrALf7x4GhOH8e7LlNu6Ydm05NuI4s35GgbhYhVrn5yy1flY?=
 =?us-ascii?Q?AKhv7XUvQYg9MrXG1VATEgE083HOODrhiyJgVyRTY/VyE1qz4Tmw31U9X0QM?=
 =?us-ascii?Q?DrHXBRntAsplFaINp6quHpss+P+8grOIj7DjVtXzCjbwEIuv6DDgSYG8DPTl?=
 =?us-ascii?Q?y3ddq0jiFO71Og3jgeR5pSpTiHU9PPez7IZAVn7ov4qpB6z2AFyZLKKgi86P?=
 =?us-ascii?Q?Dih+bDzHvJFrOKyaae+SRrQo4R/K0YGis8E8fmn/G96LRRjvrujo0GC0sjso?=
 =?us-ascii?Q?6febCBlLjKx0/+UZ64scnOjrU2yDj5E7AoMsuOpOvRo1+p2oo/CPwhskL5Jp?=
 =?us-ascii?Q?F0HP23blyMIfokJJ9rsBlEWASVg7oPKS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:17:37.0264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deb0c3f-28d8-4f0a-3ab3-08dca50b2b65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of "no page fault handling"
is unpredicable. That adveser kfd performance on page faults recovery.

This patch drain pending page faults just before gpu vm range unmap from app,
so reduce the time period that kfd not handle page fault.

Any page fault happens on unmapped ranges after drain pending page pault is app
bug that it accesses vm range after unmap. It is not driver work to cover that.

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 36 ++++++++++------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..83e694be143d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
-restart:
-	drain = atomic_read(&svms->drain_pagefaults);
-	if (!drain)
-		return;
-
 	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
 		pdd = p->pdds[i];
 		if (!pdd)
@@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
-	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange->start, prange->last, prange->work_item.op);
 
 		mm = prange->work_item.mm;
-retry:
-		mmap_write_lock(mm);
 
-		/* Checking for the need to drain retry faults must be inside
-		 * mmap write lock to serialize with munmap notifiers.
-		 */
-		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
+		mmap_write_lock(mm);
 
 		/* Remove from deferred_list must be inside mmap write lock, for
 		 * two race cases:
@@ -2455,11 +2438,17 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing "phantom faults".
+	/* before unmap pages from gpu drain pending page faults to avoid straggler
+	 * interrupts on will-be unmapped memory causing "phantom faults"
+	 * set drain_pagefaults to have page fault handler drop incoming
+	 * page faults and svm_range_drain_retry_fault drain page fault enties
+	 * untill current ts
+	 * page faults on these unmapped pages after current ts are not faults that
+	 * driver needs to drop, they are app bug that "access after unmap"
 	 */
-	atomic_inc(&svms->drain_pagefaults);
+	atomic_set(&svms->drain_pagefaults, 1);
+	svm_range_drain_retry_fault(svms);
+	atomic_set(&svms->drain_pagefaults, 0);
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -3174,8 +3163,9 @@ void svm_range_list_fini(struct kfd_process *p)
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
 	 */
-	atomic_inc(&p->svms.drain_pagefaults);
+	atomic_set(&p->svms.drain_pagefaults, 1);
 	svm_range_drain_retry_fault(&p->svms);
+	atomic_set(&p->svms.drain_pagefaults, 0);
 
 	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
 		svm_range_unlink(prange);
-- 
2.25.1

