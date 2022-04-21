Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA61CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 20:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B5710E010;
	Thu, 21 Apr 2022 20:50:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6491B10E010
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 20:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQAZGihG2ruUHbW73D0OtubpAxEQT2iJfKcx6K9d8qgguXeBVR1JOs8n9TuXrVqfdMsEKbB/KlHyo9xGrmM1cGvSk2lKy+1khrngf/pwP1njq4mCmB3bz6uJD2kIGH4n/u/Ux+CMjJ2XWSG1lAr64PIf+CQ/q75UzybBSP2XkJpCEldNoe1Wc8GSE4DKbo3ID+wf0Z+fDkbfaBJM/z85yVqlowE8RbRSr3J0J2dLTKPaQCgJtBgjRlGrLmYXYmqJSG8OT2J3q19ghCIvaOPFDO/PfXbQgPm7hQ5FUFVHy7ZFnQgBHmotPoALHZTyU2NcVLKX9oBAoTcr78kwjMhkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjGsC6P6tc/KZ3jklghhcNKa1O2jcD/z0WAAxw2uYhw=;
 b=kkZ/FRN/QX/uUCIRK+MrEW5MLuXmA8G2YxocnS5TVWzt486c9JKT7HVyfI/ZZkoCzjO7V7RM/zSE/DWP2CNwFcsw79U+hGXjafQEUwpSR7cx6tFchPYS8N3QDooGuGOWKAvNdHvWu9FFsBALDZcP+Z0iESJYPGWYNJALIFvu0w/teJbsvl7XTpu4q6eK7Okpgd6apfWu9ixeJL1Xs7YyjYJldq98fZtt2Z2TZBRtVBCP8o2On+6HbN6c/GOYPa9oCIwkR3TbMM2SpSzjxZtLhhQzl+lRjJhV4C8feJU0KFy0XgFfJUeeq6ORMo6y+sUBPvMxpq+Hnzetusktj/SnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjGsC6P6tc/KZ3jklghhcNKa1O2jcD/z0WAAxw2uYhw=;
 b=qw2nUvJGBYPEj4BYGcNutpOI7rCyL7zTEuXOLI9IB4yAieRa7Ta8z6jv0xww8cHfb84wUre5ns2sRMHmH8TvyQUDaONBausGAVUJexXAkOupWzYpQAYNJXM6x14kWyCyOsWYi9J9fMlrKmowvmsYlvON9AmIOf2vVa812Tedbyc=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by BN6PR1201MB2531.namprd12.prod.outlook.com (2603:10b6:404:b2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 20:50:35 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::81) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 20:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 20:50:34 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 15:50:33 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Ignore bogus signals from MEC efficiently
Date: Thu, 21 Apr 2022 16:49:56 -0400
Message-ID: <20220421204956.806057-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c913344-c763-4093-9577-08da23d8954f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2531:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2531B9723A030C7D125AEA3A92F49@BN6PR1201MB2531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DG4X19Nn4TawO9Fx6sMJCXyGRHGBQqXyZcZwp09Atvp0e0tWXpq31vfZL1q/LVyYteDfwvRJjbQcjH7zJ4ix/YDOd8aicOg53rDKSeuTDxM3T68xodBTF7c5IJgmbaIc8ZhTaT3jwAgGE2Ogy6Oe5YsAJ27UTXV52jNQFOrXq6hPII+HgZdzV4OFMlpBdamM/5GKdqhMs2MmJw6q7oi09AVYUDE2qZn2bArWNlhNY4AO+uZNeK9ClYq3IIEsYGouy247Hw+5RxOm4O2oYSgyNaP2P3tM1JAhWwOiZUVU4/WN4oMTxqydOEq//OEeSTDYeKbyhnEZ7LBbBGLJrgRiTIud+UZTYHRJUBaaQq0++/2t05taCgpnMwV6ynZXTjTPI+QtLi4B4cybDUPyH9KzQrpsMlpQOE4rQXoZm3LLdUxFuaP9mjlqBJlkhYYFPBhhGtjuwyd8u+K+rVqRQr2S1EsqvnrnsyHt29l+VlFgjqoEwRUEk5ssU4bwgxkLbIIn8pNdAu/Ox1dA+JljJovrApPsnaUhVv6RtU9luOexHhJjgwNhSdLKEi77EgabYCRc0sCQH2+CPraOYu81SCRRDBMeWKVrX2KMnGCQwshWcKZoDtenwmuOE1F2PsBU+llHaWp4Ngi7gGth+WfxX4cCHjW4/CGOwsbFau2FwcMs7lVyPR4tI2VIux2szPwEwfxFyxmSf+Nb3k6Y5rBc5NzaNRXN8jBVWcbRAXGcid041u72+SsJs3a++VifyYXQAjR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(356005)(8936002)(86362001)(336012)(186003)(2906002)(426003)(70206006)(70586007)(16526019)(6916009)(316002)(83380400001)(81166007)(2616005)(1076003)(6666004)(36756003)(26005)(40460700003)(7696005)(36860700001)(8676002)(47076005)(4326008)(82310400005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 20:50:34.9556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c913344-c763-4093-9577-08da23d8954f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2531
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MEC firmware sometimes sends signal interrupts without a valid context ID
on end of pipe events that don't intend to signal any HSA signals.
This triggers the slow path in kfd_signal_event_interrupt that scans the
entire event page for signaled events. Detect these signals in the top
half interrupt handler to stop processing them as early as possible.

Because we now always treat event ID 0 as invalid, reserve that ID during
process initialization.

v2: Update firmware version checks to support more GPUs

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 22 ++++++++++---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 33 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 10 ++++--
 4 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 6e5e8d637f48..4df9c36146ba 100644
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
@@ -749,7 +763,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 			 * iterate over the signal slots and lookup
 			 * only signaled events from the IDR.
 			 */
-			for (id = 0; id < KFD_SIGNAL_EVENT_LIMIT; id++)
+			for (id = 1; id < KFD_SIGNAL_EVENT_LIMIT; id++)
 				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT) {
 					ev = lookup_event_by_id(p, id);
 					set_event_from_interrupt(p, ev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 03c29bdd89a1..f27fe022ef6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -141,6 +141,25 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	}
 }
 
+static bool context_id_expected(struct kfd_dev *dev)
+{
+	switch (KFD_GC_VERSION(dev)) {
+	case IP_VERSION(9, 0, 1):
+		return dev->mec_fw_version >= 0x817a;
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+		return dev->mec_fw_version >= 0x17a;
+	default:
+		/* Other GFXv9 and later GPUs always sent valid context IDs
+		 * on legitimate events
+		 */
+		return KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 1);
+	}
+}
+
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
 					uint32_t *patched_ihre,
@@ -206,6 +225,20 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
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
index 33e7ffd8e3b5..19c8b3f56129 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1294,7 +1294,7 @@ extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
 
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

