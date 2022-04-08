Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7A5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 02:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C7B10E3A6;
	Fri,  8 Apr 2022 02:41:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3D210E39C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 02:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1yidli+9HKEXYZNZkKugw4x0/d+5RCsuJ2biqxAPCo9f89GOD4Iz1LRRs+D7Rhu3QWckPL32Al+T+iYPTZTj7EGDTbA8JGKqAPSudHDJ6k2qpEQ2j9UeNMOozbso/vhsKwfvkUWt9BBz38h7A6nkIOP0A+d194C4N7jt1EDktVhMODSzLz1B/Dx/nNvTloZQYQYbNYH+2tdZJypNlMOuSzCER/7R4M2FfJbJ/MVlpMXEYxXkSfgTx+fOG9So9bhFd87a88gGAuwtej4DsGFcXuu2UbRPni1MMiNVMTpJuSU8E0yQPGofrPACB7u+YbAaTxRI7yc08mHG//z1vPgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjNeaXoJJ9EzwQRP7ZR9ew2lh4CqeZIWUPlYL6itMd4=;
 b=a/UdcBNauSguIhutpOdeo2LSlwCMZRGDEwrI7FBsmOPQPvpyyB9iHY5SC/MFQjf5FmJt5CAjZ2YDaouJhGOoPTGO3T6tPcr/XVHMJOzhNGR0FgsyeAG3oayxokp7sg7Kpp6FOGvZD9bH3qdH7/X+CWksXKv3i7vu7o32jyDH9MaF2rxN+w3Uf3geJDp4lNvN6laYAAwpiDD4ZogdT8EF3PQCFi4i5ZsYI0Ic4TCSEKAiiKvxgi8MWc7xG+nDaLVQG93oaG9b87aNXkk3pDZ05w78SBsLA4VvD45MdzSCb2Er5VhO1+KiH6oRkRkB84EGD3L3G0CSioim7qGPDOB0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjNeaXoJJ9EzwQRP7ZR9ew2lh4CqeZIWUPlYL6itMd4=;
 b=iLlJDOrd0Kc78rZgbhcbSyEr8cHFhalP0WlcVRDfy1x4SdGhVflIX572wcEIJHgBrVQMiU2wy1FVfFApa+8dBhi3ujct0eFxrIccyl3J65tcuCEdSzfWtDJHdN8ye4dqJRTx3YzjIxICqFUuHB7PNRxvP7hIN4sE/GMU+kadlno=
Received: from BN6PR2001CA0028.namprd20.prod.outlook.com
 (2603:10b6:405:16::14) by BN6PR12MB1492.namprd12.prod.outlook.com
 (2603:10b6:405:11::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25; Fri, 8 Apr
 2022 02:40:53 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::37) by BN6PR2001CA0028.outlook.office365.com
 (2603:10b6:405:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Fri, 8 Apr 2022 02:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 02:40:52 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 21:40:51 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Ignore bogus signals from MEC efficiently
Date: Thu, 7 Apr 2022 22:40:38 -0400
Message-ID: <20220408024038.320357-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5049358-6414-438d-6aa7-08da190932dd
X-MS-TrafficTypeDiagnostic: BN6PR12MB1492:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1492D83BED4E40DE82C14B5792E99@BN6PR12MB1492.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HL+TfkFoRyUPI47o+T23WjJt13lUQLTbbf1PUTCsBERK22Dd9Xnfdyfw4AsabijzVA6rGvgIW5jZzaI5mvu6r+KDK4a89IM7zKeNY4tFthESjkII5ImAaNKvKDl5eQ/5/nohcb3d0Fe9h14QMaM0jbCxbrcxzDxo58haDPRbwlAAJrPXRtbyazwC80uoXhz40strevGgBHtYnHg9V7L5kBDR5aDVu8NDG0G+8B+itcIZgZarCinU7J0uyVk319Q+5XdkhJtZZ4Z8KBXOgVKTJQ89zKyplel3emL1GJNMm+FRbzM1Q+HNDChEuZh19OhTLffhLX+11Sl/5umpRyViMZJocHSBB2yMJ7lzLqRggrViJJY/0MoiSZRY8ZOrRJRzFuVmD1qzqNzjb3MOfTsWsGb6O9tWOuUvwg2Cu3+UGtrnKPHynlbjuDthsnrqadOfsCyMdXBYKLY92vK75Tt64nqzCEO8vTfWGYlw5H90bpS8QB/zAiArfvn6BK6olGx3TlFUA1N/wD3prhC12+QOMf1EI7j+7Tk2dTteYo9fKDJNzz6CR+69kbtcwtIyb3b7ukKN0nHVhJnZgzHeDMI/t/FK5u5jIpLJP9no+bbUezk94EarBc2dteO5Od1bIj7RaDQm9xDO3qaR37q92Ga4FCf1MUet5B4GzFeamrVYBwE56DH0byXwMG0vxiDr1PqSO+9hdhHJsoRGHAhBvybIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(2906002)(36756003)(356005)(40460700003)(508600001)(4326008)(8676002)(5660300002)(70586007)(70206006)(81166007)(316002)(82310400005)(6916009)(36860700001)(6666004)(47076005)(86362001)(1076003)(426003)(7696005)(16526019)(186003)(26005)(83380400001)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:40:52.4493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5049358-6414-438d-6aa7-08da190932dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1492
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
Cc: sean.keely@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MEC firmware sometimes sends signal interrupts without a valid context ID
on end of pipe events that don't intend to signal any HSA signals.
This triggers the slow path in kfd_signal_event_interrupt that scans the
entire event page for signaled events. Detect these signals in the top
half interrupt handler to stop processing them as early as possible.

Because we now always treat event ID 0 as invalid, reserve that ID during
process initialization.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 22 +++++++++++---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 10 +++++--
 4 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 75847c5d5957..e43bb14adfca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -238,12 +238,24 @@ static int create_other_event(struct kfd_process *p, struct kfd_event *ev, const
 	return 0;
 }
 
-void kfd_event_init_process(struct kfd_process *p)
+int kfd_event_init_process(struct kfd_process *p)
 {
+	int id;
+
 	mutex_init(&p->event_mutex);
 	idr_init(&p->event_idr);
 	p->signal_page = NULL;
-	p->signal_event_count = 0;
+	p->signal_event_count = 1;
+	/* Allocate event ID 0. It is used for a fast path to ignore bogus events
+	 * that are sent by the CP without a context ID
+	 */
+	id = idr_alloc(&p->event_idr, NULL, 0, 1, GFP_KERNEL);
+	if (id < 0) {
+		idr_destroy(&p->event_idr);
+		mutex_destroy(&p->event_mutex);
+		return id;
+	}
+	return 0;
 }
 
 static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
@@ -271,8 +283,10 @@ static void destroy_events(struct kfd_process *p)
 	uint32_t id;
 
 	idr_for_each_entry(&p->event_idr, ev, id)
-		destroy_event(p, ev);
+		if (ev)
+			destroy_event(p, ev);
 	idr_destroy(&p->event_idr);
+	mutex_destroy(&p->event_mutex);
 }
 
 /*
@@ -739,7 +753,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 			 * iterate over the signal slots and lookup
 			 * only signaled events from the IDR.
 			 */
-			for (id = 0; id < KFD_SIGNAL_EVENT_LIMIT; id++)
+			for (id = 1; id < KFD_SIGNAL_EVENT_LIMIT; id++)
 				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT) {
 					ev = lookup_event_by_id(p, id);
 					set_event_from_interrupt(p, ev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 03c29bdd89a1..7d0111c197c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -141,6 +141,21 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	}
 }
 
+static bool context_id_expected(struct kfd_dev *dev)
+{
+	/* Borrowing firmware versions for GWS support because they were known
+	 * to send context_ids on legitimate signals.
+	 */
+	switch (KFD_GC_VERSION(dev)) {
+	case IP_VERSION(9, 0, 1): return dev->mec_fw_version >= 0x81b3;
+	case IP_VERSION(9, 4, 0): return dev->mec_fw_version >= 0x1b3;
+	case IP_VERSION(9, 4, 1): return dev->mec_fw_version >= 0x30;
+	case IP_VERSION(9, 4, 2): return true; /* was never broken */
+	default:
+		return false;
+	}
+}
+
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
 					uint32_t *patched_ihre,
@@ -206,6 +221,20 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
 		return false;
 
+	/* Workaround CP firmware sending bogus signals with 0 context_id.
+	 * Those can be safely ignored on hardware and firmware versions that
+	 * include a valid context_id on legitimate signals. This avoids the
+	 * slow path in kfd_signal_event_interrupt that scans all event slots
+	 * for signaled events.
+	 */
+	if (source_id == SOC15_INTSRC_CP_END_OF_PIPE) {
+		uint32_t context_id =
+			SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+
+		if (context_id == 0 && context_id_expected(dev))
+			return false;
+	}
+
 	/* Interrupt types we care about: various signals and faults.
 	 * They will be forwarded to a work queue (see below).
 	 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e1b7e6afa920..3761655ab0a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1292,7 +1292,7 @@ extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
 
 extern const struct kfd_device_global_init_class device_global_init_class_cik;
 
-void kfd_event_init_process(struct kfd_process *p);
+int kfd_event_init_process(struct kfd_process *p);
 void kfd_event_free_process(struct kfd_process *p);
 int kfd_event_mmap(struct kfd_process *process, struct vm_area_struct *vma);
 int kfd_wait_on_events(struct kfd_process *p,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9e82d7aa67fa..cb8f4a459add 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1370,12 +1370,16 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
-	kfd_event_init_process(process);
+	err = kfd_event_init_process(process);
+	if (err)
+		goto err_event_init;
 	process->is_32bit_user_mode = in_compat_syscall();
 
 	process->pasid = kfd_pasid_alloc();
-	if (process->pasid == 0)
+	if (process->pasid == 0) {
+		err = -ENOSPC;
 		goto err_alloc_pasid;
+	}
 
 	err = pqm_init(&process->pqm, process);
 	if (err != 0)
@@ -1424,6 +1428,8 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 err_process_pqm_init:
 	kfd_pasid_free(process->pasid);
 err_alloc_pasid:
+	kfd_event_free_process(process);
+err_event_init:
 	mutex_destroy(&process->mutex);
 	kfree(process);
 err_alloc_process:
-- 
2.32.0

