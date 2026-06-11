Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39239CD8C9D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 20:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C145D10E846;
	Thu, 11 Jun 2026 20:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="macVSr62";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B31410E846
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 20:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kipu/naVx6KSycpiPoEZPpLcJtKGGwMrcAXU93Dmo0S4t8msW7kwfxffj2AiK69MooilUonfbjYqkTy4XJHqk3uzMRvJoBap5NLlixnd/KxessXXIZTtewssSUSqfGRJPJkamo7TfjDS6DO4uqgCMyGZQ1mYbi0bCHYpOEGkAaFdMWzK00pmTYWfrRfll6LTiAm9Xkojz26NeZmtRb3d+6nb/Gj3w1GgA6765+yUj6WxPTQ7SWXIn/HTFdNwfIC0SEaqRfwZTVz8GoQJVTX7108vtUmI6ufBexkRC88obUtg9VEc/9ky8RDW7YfDUOFXoKuTjnCZw+hoXLZO8pMBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVolnJ/muBYVOQksSm9mkS5Dm9fNQlkIRc0bMbzumRo=;
 b=SlaNpPaERohiep7u8RQiAUN92tHae2tKQdsbGo89QY7jzhLNMofTf4Iwdo1Y4Ar7BV/0LDzn/+sMqUPIAMfb4ZNRSRHIykPYB+1F/+edV7uZ52JrWbsw9TT13BNmZNSyCWYwkxdt3IQ0rwsRgsrMZTyf8FbYNlC8SzisHhL6TYRwqhjJKQr/Jor3+6m6UCMeZl0kejhQq1yFQwBdELn1R3Wh9ze4WwUttKNDjxXmvC5J4o6I/qKlxJnLT36+gB39kU5jEsHIlc7ukGWpnCux6Alg/iwqwbO6s0NGrg4MZJhts6HBXG/j2eQR5b/EenV2NuOJWdPGzEsHOhy49dy+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVolnJ/muBYVOQksSm9mkS5Dm9fNQlkIRc0bMbzumRo=;
 b=macVSr62n+6ijRYJHxjPOfRApQJ/SUc43mhPF/S++yNQIILM7YxcTtUlRsIERlbA/TehfKaiIwUmBA/XyYw2eQTTq7wlt6bexwub7KpaLV/NhG2cCfF3H3EVLlgytlSykW+ec6FabinddnAxSeagaX1qU2UyBdIRW9QNAYDKsxM=
Received: from DS1PR07CA0024.namprd07.prod.outlook.com (2603:10b6:8:44d::6) by
 CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.13; Thu, 11 Jun 2026 20:08:00 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:44d:cafe::1a) by DS1PR07CA0024.outlook.office365.com
 (2603:10b6:8:44d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 20:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 20:07:59 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 15:07:58 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: remove dead kernel-allocated signal page code
Date: Thu, 11 Jun 2026 16:07:46 -0400
Message-ID: <20260611200746.320513-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 85172fc2-4369-4c6d-1e8c-08dec7f5229a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: kamqiP6uo8nMklkBmBZZ6Z1Qju0btzEm8NBOze0Z6B0peRCiPXhUEqaj2D8G+UbiqjtjmLNKOCVjgukhwMqzeHcnihei3NV0yeVWhY+aOemzuZYgAsxYZs9D29LIdU+mmnj0D2ZLfWTD8rYj1KhJLqG07yC23P8kgXpU5Pn242plpubuHsdckyqUBof40+O1k28oBnzUdvXmfxR8c6xVAwHM7KBNZ2WLTOYlYWL65cd8CU8fM3Tita4G9ySTGnMV+9+VyZdJ33q+u/iuw4HNtULMSxxYahyw/I8ad1bjK4SblqxNY7bpx4ZuvvfX7sXsx5QPUDWfiok1cUbIaIhlJxmGPYOQueZWm1udBj2acOEL4NOG0mpuvgaU/1qOdwtDHloAMzRwdPCdiwhkd6WIU9KTeRIjFOhtT8BWnNmzshEigvoDwCG/SZPIR4nUOcImfDJw5SpD05kyPiHdK1yxazZQUWZ/cX8BgS7iGxCSlgLLBYxl/Z3ghzU5c4PSyCnNY9Z35CQ4zebKiTbZQFORZnf+iAjGdxhjHrgMZOsuKuYtZnKi62TMC6XXIrl0Vvrd3aYCutEuD5oKlz5nHOFueNxKJ36S8wBksaump61z5Nqhsyo8sJLZ4LcXjXsofphzW+fIECfAlNBsWIuHCcKI/GKIst4j9rvYdjyV89JM7p2tPA+rAarkaS98ibPxkx8wz71qZCgPXTAI964bkh+3sz14xff9ko2MvqzKBVG04gI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u9Ov+G+q/Y7gHiMifYooIDtUcRInpToWJENKSDjxqhpoEsplhPbmdzQc9nsubeS23BXwE+ekcgSrH/3SvikFsIzaGuBTPe/Mm7cTcSYtmq2wxaTZQ+ZQ9uTyIA0m9+TEFGKZsWxqfZ6EGybsclpd5zb6LD8YKEZp0XT5pesnvtTglQfYa9Qt0u8wLq7BPzUCzSJIEdmRwXCNzspjWfsKFymGfclkqrtCOMYrEsbQKCsfzX0fcMgGAZqJWgX7ZePaIxXibSlbGrTRqA/c8rI5r/Pbwvd3CCLHTxMGp/1UbM9VjLmToIFj3fh7quqzMM8fS47OtfYt0Y2Qu0WfvbnyCcHVXsphH3F9fpRT2RrpH8+tjvw0N6GILZVKGaQPsLrxMuujXd0nBImzlbHCUQJNQ4Lwv1SOOG2HqsvvM0jWj+VMAx7aIHryZIUlDvJE11wm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 20:07:59.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85172fc2-4369-4c6d-1e8c-08dec7f5229a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

With the KFD_MMAP_TYPE_EVENTS mmap path gone, a kernel-allocated signal
page can no longer be exposed to user space, so allocate_signal_page()
and the related bookkeeping are dead code. The only remaining way to set
up a signal page is kfd_kmap_event_page()/kfd_event_page_set(), where
user space allocates the events page as a BO and passes it via the
event_page_offset of the create event IOCTL.

Remove allocate_signal_page() and require the signal page to be provided
by user space. Drop the now unused kfd_signal_page user mapping
bookkeeping (user_address/need_to_free_pages) and
kfd_event::user_signal_address.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 59 +++++--------------------
 drivers/gpu/drm/amd/amdkfd/kfd_events.h |  3 --
 2 files changed, 10 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e44f1d1bc516..85e4ad10d619 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -55,8 +55,6 @@ struct kfd_event_waiter {
  */
 struct kfd_signal_page {
 	uint64_t *kernel_address;
-	uint64_t __user *user_address;
-	bool need_to_free_pages;
 };
 
 static uint64_t *page_slots(struct kfd_signal_page *page)
@@ -64,49 +62,19 @@ static uint64_t *page_slots(struct kfd_signal_page *page)
 	return page->kernel_address;
 }
 
-static struct kfd_signal_page *allocate_signal_page(struct kfd_process *p)
-{
-	void *backing_store;
-	struct kfd_signal_page *page;
-
-	page = kzalloc(sizeof(*page), GFP_KERNEL);
-	if (!page)
-		return NULL;
-
-	backing_store = (void *) __get_free_pages(GFP_KERNEL,
-					get_order(KFD_SIGNAL_EVENT_LIMIT * 8));
-	if (!backing_store)
-		goto fail_alloc_signal_store;
-
-	/* Initialize all events to unsignaled */
-	memset(backing_store, (uint8_t) UNSIGNALED_EVENT_SLOT,
-	       KFD_SIGNAL_EVENT_LIMIT * 8);
-
-	page->kernel_address = backing_store;
-	page->need_to_free_pages = true;
-	pr_debug("Allocated new event signal page at %p, for process %p\n",
-			page, p);
-
-	return page;
-
-fail_alloc_signal_store:
-	kfree(page);
-	return NULL;
-}
-
 static int allocate_event_notification_slot(struct kfd_process *p,
 					    struct kfd_event *ev,
 					    const int *restore_id)
 {
 	int id;
 
-	if (!p->signal_page) {
-		p->signal_page = allocate_signal_page(p);
-		if (!p->signal_page)
-			return -ENOMEM;
-		/* Oldest user mode expects 256 event slots */
-		p->signal_mapped_size = 256*8;
-	}
+	/*
+	 * The signal page is allocated in user mode and mapped to the kernel
+	 * via the event_page_offset of the create event IOCTL. Without it no
+	 * signal events can be created.
+	 */
+	if (!p->signal_page)
+		return -ENOMEM;
 
 	if (restore_id) {
 		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
@@ -212,10 +180,8 @@ static int create_signal_event(struct file *devkfd, struct kfd_process *p,
 
 	p->signal_event_count++;
 
-	ev->user_signal_address = &p->signal_page->user_address[ev->event_id];
-	pr_debug("Signal event number %zu created with id %d, address %p\n",
-			p->signal_event_count, ev->event_id,
-			ev->user_signal_address);
+	pr_debug("Signal event number %zu created with id %d\n",
+			p->signal_event_count, ev->event_id);
 
 	return 0;
 }
@@ -303,12 +269,7 @@ static void shutdown_signal_page(struct kfd_process *p)
 {
 	struct kfd_signal_page *page = p->signal_page;
 
-	if (page) {
-		if (page->need_to_free_pages)
-			free_pages((unsigned long)page->kernel_address,
-				   get_order(KFD_SIGNAL_EVENT_LIMIT * 8));
-		kfree(page);
-	}
+	kfree(page);
 }
 
 void kfd_event_free_process(struct kfd_process *p)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 1dc21c13833b..88e3797bfc42 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -63,9 +63,6 @@ struct kfd_event {
 	spinlock_t lock;
 	wait_queue_head_t wq; /* List of event waiters. */
 
-	/* Only for signal events. */
-	uint64_t __user *user_signal_address;
-
 	/* type specific data */
 	union {
 		struct kfd_hsa_memory_exception_data memory_exception_data;
-- 
2.43.0

