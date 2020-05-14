Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFEAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 20:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A5320675
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 20:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2NRDDtld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A5320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7966E39B;
	Thu, 14 May 2020 20:33:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B9D6E39B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 20:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETr6cJvd4U+m2HN5+Fm2xKMmekantZ1/YQ7UEXm0iBNlAYTBJxnJtuqJc8E11P9lboC++QqhXym8IKjL9Axx8RaFLUIfNqCNBkvho4BEFG1KOGvfJlWCdVx0exdBeXGpvTwID0ZJCXUC9kQxQyKkLOldO+3CVTxYxXWvitJDGdyBW2vtVuRQNfP84R5w5i9M7OdwMqe5uFzagN4GhO7j+WrqU59f/xW4JEDOPM0xOcnR3x4B9v4SSj/G5Q4Jz1zPLj+wezFULKzEIWdJjXM8Tdc2K/85buEfgRxWtRJcgFM+j6wo6wOjgRPQCbWt9md8ax5vL45CR1bhZ5yhDj2uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exMSFyS2b+P5kDiOLlVA5XIG/O9MsKpyiZ4xHAfsjbY=;
 b=FhTiosqOOpUF5IPWmJRfxucRQkwfkWszPdS4hjwm4byUs7aYD2FEHlsFWEnYNG4IANRNLqz3du7vUKLncxf57ZV+9CQ+ylHCEBrrgaevI6SEVLtjcHJXgjld0itUqkB2RZqAopFVxQsL9j2OhORapP6EDG46sygP3JpgoMIt/7CP/ROdyXRu3hl6AjS5DqczwFRz4EwRsGA8/6uFgq6JizyWKRsYjAKX2v2P0HWz5y6M+AUTJDYusVVKsnlwC1j+m1lB5nDFwKRaFubdUdOttpklIfppRXS5rK2Ywj34vDPEHhpb69isYUXg3D33WYmtnZMc91oD+N4sv0foSm7UXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exMSFyS2b+P5kDiOLlVA5XIG/O9MsKpyiZ4xHAfsjbY=;
 b=2NRDDtldTum0nNAo+RO686v047+n81H3BXKwc6jynwO2hqNmyQwZzOl/glJTIwPN5NTsX764gI3SHttmRZFU3o26VVZJDESQZPd4hsP3dMAYPQIcDDwj+r3KpWCPCy6AX0//U7/+Lk2ETwPR8i8KVjcwPHMF9D9bbYIj4utVZ0Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 by BN7PR12MB2803.namprd12.prod.outlook.com (2603:10b6:408:32::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 20:33:45 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::14f2:9ef9:beed:ad1]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::14f2:9ef9:beed:ad1%7]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 20:33:44 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Track SDMA utilization per process
Date: Thu, 14 May 2020 16:33:16 -0400
Message-Id: <20200514203316.1621-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::10) To BN7PR12MB2836.namprd12.prod.outlook.com
 (2603:10b6:408:32::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.24 via Frontend Transport; Thu, 14 May 2020 20:33:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d1da53b-52c7-4788-7e4b-08d7f84618c1
X-MS-TrafficTypeDiagnostic: BN7PR12MB2803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28039443D6E0E009D215816AEEBC0@BN7PR12MB2803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcT5kTR/n9GNNsbHBnFWDEA6ArzGIkXc5qwGKARf3QuDDv2agEix5P0Izm8GJPDj1qGs0JFZyiylsELIeE1ir+CJH8Ne3IAhaMJklw9N2dGaopVsX/ooD3b6s1C2+cCuRWOZOCGJ42YZlPGXYqNNpYiqzfOA6RVUmvPFjmgpn5ZDw/KVzbx3l+ECy+5JbbtVXqUF5C7VwpvvH2PsL2Cm8YQgNnmjGZSytVsfHpb7xwwdWQl7gclioUmvsYmUR3YJrNUqmE93farWCT7UGQ7XDXH+Qg/ezvyGKd5ZnuOntqIAVOemNLAjbPnmqh0ZlZ+EFQ1+LjDtj+j+Ee2SPR19dJQGSFvuttfRgIF5RAPVcO9Q/mQskw/Bzv3nOc1wF1XmU9dS6mqC2jgrfF4+6eAkWqu+FNOa6G/Bi4Ui3tH9DZQ7feyDcaRqtzoWucwifOQA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2836.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(2906002)(6916009)(6666004)(1076003)(36756003)(4326008)(5660300002)(316002)(30864003)(8676002)(7696005)(52116002)(6486002)(8936002)(478600001)(186003)(956004)(26005)(2616005)(16526019)(66476007)(66946007)(66556008)(44832011)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U8GlKkkSoLmt7H8l+kW7owGBY4Hyq/q/ADgdTk/oP/yhaZYTdBLSdKYfmel5MZnmdO/q97a+Mjv2Bu8+pDJEmo5PhB/F+hJk3ZStGPN2uxIn+n1fZfkiNu+hyygk9D2O5qfnpytznMC6FgKEW3JY6JcAmVo5hlmReEF46GrZYalVy2WoTpVC0T+f9KxHGGsRvfDHTh3pCnFBCIgRjuXFR75vTI/1zmNsqk57SfshekiiodskVboNnNknQGE5sENsyvGyn0yGJ/m8B8xFUUTZgaSoLv6rQvt/60qkNQsioyiP1EoAJg1pPUcSTVAt3C2YF00OVf8AxA2tbqLX8AGr3gIVX+U2RROjrkktA8dAkec5zIRrBq8xwWiEdoaII1V/fHcNGv3P1zFgqQX654xv60vI/IXt0W+aUphf+qnlZTxPX6W6zxY9r86SyQblMTwsyvAyYKEXzWNS9D9+FfbEgIuweXEvoa6jmvmeCPy0OlWNkKOkQ2JE6Z0SxZo8guLp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1da53b-52c7-4788-7e4b-08d7f84618c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:33:44.6145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQMykp4SE++8g50TZWXMT/SnE7YTvZavYOxxacdhWeZKmAmjhjecOUa8H2QaJ1CxDOcQFYrg9915MKTi6kINJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2803
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Track SDMA usage on a per process basis and report it through sysfs.
The value in the sysfs file indicates the amount of time SDMA has
been in-use by this process since the creation of the process.
This value is in microsecond granularity.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  57 ++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  16 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 130 ++++++++++++++++--
 4 files changed, 193 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e9c4867abeff..49f72d0f7be7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -153,6 +153,52 @@ void decrement_queue_count(struct device_queue_manager *dqm,
 		dqm->active_cp_queue_count--;
 }
 
+int read_sdma_queue_counter(struct queue *q, uint64_t *val)
+{
+	int ret;
+	uint64_t tmp = 0;
+
+	if (!q || !val)
+		return -EINVAL;
+	/*
+	 * SDMA activity counter is stored at queue's RPTR + 0x8 location.
+	 */
+	if (!access_ok((const void __user *)((uint64_t)q->properties.read_ptr +
+					sizeof(uint64_t)), sizeof(uint64_t))) {
+		pr_err("Can't access sdma queue activity counter\n");
+		return -EFAULT;
+	}
+
+	ret = get_user(tmp, (uint64_t *)((uint64_t)(q->properties.read_ptr) +
+						    sizeof(uint64_t)));
+	if (!ret) {
+		*val = tmp;
+	}
+
+	return ret;
+}
+
+static int update_sdma_queue_past_activity_stats(struct kfd_process_device *pdd,
+						 struct queue *q)
+{
+	int ret;
+	uint64_t val = 0;
+
+	if (!pdd)
+		return -ENODEV;
+
+	ret = read_sdma_queue_counter(q, &val);
+	if (ret) {
+		pr_err("Failed to read SDMA queue counter for queue: %d\n",
+				q->properties.queue_id);
+		return ret;
+	}
+
+	WRITE_ONCE(pdd->sdma_past_activity_counter, pdd->sdma_past_activity_counter + val);
+
+	return ret;
+}
+
 static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 {
 	struct kfd_dev *dev = qpd->dqm->dev;
@@ -487,6 +533,12 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	if (retval == -ETIME)
 		qpd->reset_wavefronts = true;
 
+	/* Get the SDMA queue stats */
+        if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
+            (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
+                update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
+        }
+
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 
 	list_del(&q->list);
@@ -1468,6 +1520,11 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		}
 	}
 
+	/* Get the SDMA queue stats */
+	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
+	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
+		update_sdma_queue_past_activity_stats(qpd_to_pdd(qpd), q);
+	}
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
 	 * type
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 4afa015c69b1..894bcf877f9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -251,4 +251,6 @@ static inline void dqm_unlock(struct device_queue_manager *dqm)
 	mutex_unlock(&dqm->lock_hidden);
 }
 
+int read_sdma_queue_counter(struct queue *q, uint64_t *val);
+
 #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f70f789c3cb3..fae139b77c0a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -633,7 +633,14 @@ enum kfd_pdd_bound {
 	PDD_BOUND_SUSPENDED,
 };
 
-#define MAX_VRAM_FILENAME_LEN 11
+#define MAX_SYSFS_FILENAME_LEN 11
+
+/*
+ * SDMA counter runs at 100MHz frequency.
+ * We display SDMA activity in microsecond granularity in sysfs.
+ * As a result, the divisor is 100.
+ */
+#define SDMA_ACTIVITY_DIVISOR  100
 
 /* Data that is per-process-per device. */
 struct kfd_process_device {
@@ -681,7 +688,12 @@ struct kfd_process_device {
 	/* VRAM usage */
 	uint64_t vram_usage;
 	struct attribute attr_vram;
-	char vram_filename[MAX_VRAM_FILENAME_LEN];
+	char vram_filename[MAX_SYSFS_FILENAME_LEN];
+
+	/* SDMA activity tracking */
+	uint64_t sdma_past_activity_counter;
+	struct attribute attr_sdma;
+	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d27221ddcdeb..a20053a32949 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
+#include <linux/mmu_context.h>
 #include <linux/slab.h>
 #include <linux/amd-iommu.h>
 #include <linux/notifier.h>
@@ -76,6 +77,67 @@ struct kfd_procfs_tree {
 
 static struct kfd_procfs_tree procfs;
 
+/*
+ * Structure for SDMA activity tracking
+ */
+struct kfd_sdma_activity_handler_workarea {
+	struct work_struct sdma_activity_work;
+	struct kfd_process_device *pdd;
+	uint64_t *sdma_current_activity_counter;
+};
+
+static void kfd_sdma_activity_worker(struct work_struct *work)
+{
+	struct kfd_sdma_activity_handler_workarea *workarea;
+	struct kfd_process_device *pdd;
+	uint64_t val;
+	struct mm_struct *mm;
+	struct queue *q;
+	struct qcm_process_device *qpd;
+	struct device_queue_manager *dqm;
+	int ret = 0;
+
+	workarea = container_of(work, struct kfd_sdma_activity_handler_workarea,
+				sdma_activity_work);
+	if (!workarea)
+		return;
+
+	pdd = workarea->pdd;
+	dqm = pdd->dev->dqm;
+	qpd = &pdd->qpd;
+
+	if (!pdd || !dqm || !qpd)
+		return;
+
+	mm = get_task_mm(pdd->process->lead_thread);
+	if (!mm) {
+		pr_err("Failed to get task mm\n");
+		return;
+	}
+
+	use_mm(mm);
+
+	dqm_lock(dqm);
+
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
+		    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
+			val = 0;
+			ret = read_sdma_queue_counter(q, &val);
+			if (ret)
+				pr_debug("Failed to read SDMA queue active "
+					 "counter for queue id: %d",
+					 q->properties.queue_id);
+			else
+				*(workarea->sdma_current_activity_counter) += val;
+		}
+	}
+
+	dqm_unlock(dqm);
+	unuse_mm(mm);
+	mmput(mm);
+}
+
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
@@ -89,6 +151,26 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 							      attr_vram);
 		if (pdd)
 			return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
+	} else if (strncmp(attr->name, "sdma_", 5) == 0) {
+		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
+							      attr_sdma);
+		if (pdd) {
+			struct kfd_sdma_activity_handler_workarea sdma_activity_work_handler;
+			uint64_t val = 0;
+
+			INIT_WORK(&sdma_activity_work_handler.sdma_activity_work,
+					kfd_sdma_activity_worker);
+
+			sdma_activity_work_handler.pdd = pdd;
+			sdma_activity_work_handler.sdma_current_activity_counter = &val;
+
+			schedule_work(&sdma_activity_work_handler.sdma_activity_work);
+
+			flush_work(&sdma_activity_work_handler.sdma_activity_work);
+
+			return snprintf(buffer, PAGE_SIZE, "%llu\n",
+			        (READ_ONCE(pdd->sdma_past_activity_counter) + val)/SDMA_ACTIVITY_DIVISOR);
+		}
 	} else {
 		pr_err("Invalid attribute");
 		return -EINVAL;
@@ -210,7 +292,24 @@ int kfd_procfs_add_queue(struct queue *q)
 	return 0;
 }
 
-int kfd_procfs_add_vram_usage(struct kfd_process *p)
+static int kfd_sysfs_create_file(struct kfd_process *p, struct attribute *attr,
+				 char *name)
+{
+	int ret = 0;
+
+	if (!p || !attr || !name)
+		return -EINVAL;
+
+	attr->name = name;
+	attr->mode = KFD_SYSFS_FILE_MODE;
+	sysfs_attr_init(attr);
+
+	ret = sysfs_create_file(p->kobj, attr);
+
+	return ret;
+}
+
+int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 {
 	int ret = 0;
 	struct kfd_process_device *pdd;
@@ -221,17 +320,25 @@ int kfd_procfs_add_vram_usage(struct kfd_process *p)
 	if (!p->kobj)
 		return -EFAULT;
 
-	/* Create proc/<pid>/vram_<gpuid> file for each GPU */
+	/*
+	 * Create sysfs files for each GPU:
+	 * - proc/<pid>/vram_<gpuid>
+	 * - proc/<pid>/sdma_<gpuid>
+	 */
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
-		snprintf(pdd->vram_filename, MAX_VRAM_FILENAME_LEN, "vram_%u",
+		snprintf(pdd->vram_filename, MAX_SYSFS_FILENAME_LEN, "vram_%u",
 			 pdd->dev->id);
-		pdd->attr_vram.name = pdd->vram_filename;
-		pdd->attr_vram.mode = KFD_SYSFS_FILE_MODE;
-		sysfs_attr_init(&pdd->attr_vram);
-		ret = sysfs_create_file(p->kobj, &pdd->attr_vram);
+		ret = kfd_sysfs_create_file(p, &pdd->attr_vram, pdd->vram_filename);
 		if (ret)
 			pr_warn("Creating vram usage for gpu id %d failed",
 				(int)pdd->dev->id);
+
+		snprintf(pdd->sdma_filename, MAX_SYSFS_FILENAME_LEN, "sdma_%u",
+			 pdd->dev->id);
+		ret = kfd_sysfs_create_file(p, &pdd->attr_sdma, pdd->sdma_filename);
+		if (ret)
+			pr_warn("Creating sdma usage for gpu id %d failed",
+				(int)pdd->dev->id);
 	}
 
 	return ret;
@@ -444,9 +551,9 @@ struct kfd_process *kfd_create_process(struct file *filep)
 		if (!process->kobj_queues)
 			pr_warn("Creating KFD proc/queues folder failed");
 
-		ret = kfd_procfs_add_vram_usage(process);
+		ret = kfd_procfs_add_sysfs_files(process);
 		if (ret)
-			pr_warn("Creating vram usage file for pid %d failed",
+			pr_warn("Creating sysfs usage file for pid %d failed",
 				(int)process->lead_thread->pid);
 	}
 out:
@@ -597,8 +704,10 @@ static void kfd_process_wq_release(struct work_struct *work)
 		kobject_put(p->kobj_queues);
 		p->kobj_queues = NULL;
 
-		list_for_each_entry(pdd, &p->per_device_data, per_device_list)
+		list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 			sysfs_remove_file(p->kobj, &pdd->attr_vram);
+			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
+		}
 
 		kobject_del(p->kobj);
 		kobject_put(p->kobj);
@@ -906,6 +1015,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->already_dequeued = false;
 	pdd->runtime_inuse = false;
 	pdd->vram_usage = 0;
+	pdd->sdma_past_activity_counter = 0;
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
