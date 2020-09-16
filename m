Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59967C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 18:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D726220732
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 18:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UT7WnkIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D726220732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720396EABD;
	Wed, 16 Sep 2020 18:43:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E476EABD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 18:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+SoaEfrsxR5G7uLmWmTiD5Mn28KVD+KtW7m8vqlZSM3B0n7qGfKMhQkEHX82wofxI1oLnh2Kw5YndXb1/fLAelSaSB2RiwPKcZbxu8y9UTks7VJ7c2Clq6mrmXTZ4mgKZkFR5pcWiiyC2hPFff/beolnGQsbaCBhPKRNQADDERepfvZMj7Tj2rBSK8yoEk0DTGOTF199ooQvMjoSF2MYJoG0jj6heggInPyQNw3iKjIOZddKfJASNZS4Y53kC93AOgFUgHJkkRuVq+zaq8qCOi5Q9rLTf7VzVQ0GAYTpJzD5o0kXa+CsXcmtpx2SHJzSHwb1sOOMabdgGA7iT29lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNdcWuo/wns3WTStMFZfxbVi/OKZSrXhkYnBNDdezM4=;
 b=Mql7yIFc9ZMKH9CklD4MRdrqb1CGqQPJ1vUcUxp+PSjWKy5uDzNuQTOcOCsOHNv0NsVkikTWl30XYlNg7B1esgzPUCSPhaXzNIoRvi5iHo2vflZpqTc0O0jCEGgkNevRJg+b2sQZnu8Q8NTCJkN/ek5caIwBp56muqkavR4Xl4bkBY00ywJsgMOq/NwZ5ZxTSzkp9NopSZpfn102LENqPDu6KdYilX3SES4Gq/oV+TwVjxxkPnKzM067aJi3oyQUhcsLcWonngnTsH+uFy7XL3YTvAG124kKMzUohxTNe4pELW+cmnxtKsPLOwvPp3W/7Mu09eRyQ/ufNR5QjMsDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNdcWuo/wns3WTStMFZfxbVi/OKZSrXhkYnBNDdezM4=;
 b=UT7WnkIhWeGRVuyvzmVtQB4jq4dEzhVUdBYANF2WIUP/TxgMJ22Mghkv09jxTao3CE3FvWitG7Zgiq5mf0FTKpF8iJOSnf7kEPnrQlwYL7GiM3rgGu5AP6D3e7PxI1A7s7fGA6Xg3VD/kv+KkiJuyDNKOe8Id7Vf+yLoXszbdZU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) by
 DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 16 Sep 2020 18:43:20 +0000
Received: from DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b]) by DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b%2]) with mapi id 15.20.3391.014; Wed, 16 Sep 2020
 18:43:20 +0000
From: Philip Cox <Philip.Cox@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/3] drm/amdkfd: Add process eviction counters to sysfs
Date: Wed, 16 Sep 2020 14:42:46 -0400
Message-Id: <20200916184247.32475-2-Philip.Cox@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::25) To DM6PR12MB3404.namprd12.prod.outlook.com
 (2603:10b6:5:3a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pscox.amd.com (165.204.55.251) by
 YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 16 Sep 2020 18:43:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9b4bec7-7562-46cc-5fcc-08d85a7061eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37383F766CD96B15B0AEAAA783210@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSCRXJC0oy519Q957p1pqu2A3mmqRmR3K0eSRQJ9vlMQMN73OegWiav+800WT1uLT0iHerCx8ihv9N4kOR1NkJB1XeLYmZtPzcxJnaeIplwLYQ1hJ4RKa9NBfDrqU3flMIsoJTqyUCnA09PKUvAT18YQqvSWs5s9b68vbjZNSFAhYJwWhHjvfdh4Hx2uvrlBoWN0X/O6w6knUIkt3p6b4EdmwCE3+cqkpBk2UtGX4PuA/FJAFMgQyaGIiep/5U57B/ZAT2s2zdF5f8+GxN8u+3qQQRgak0K2IFYNx97Nt487bUhJe/s2m0Y4oi1N5xv924pQSKD2eekUkoENjVB/EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(86362001)(5660300002)(8676002)(316002)(4326008)(8936002)(6666004)(36756003)(186003)(2616005)(16526019)(956004)(26005)(7696005)(478600001)(83380400001)(52116002)(2906002)(6486002)(6916009)(66556008)(66946007)(1076003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: b6BhP5tI45EAcsD43tSnTr88KtYpYguqdln3+LKMfKrjslUyXyr+lSggmRJSGD9qvrqsGZYvPgXZWRxVQwFumWfFmXkcKo21JuPhpIybPyGdB98YLVe5rq9dAo5Rimn+oXce1D/M4PpDPNWftC8YJaqoiGvWDbnMtd7QR8Utq57ie6+TLI/eSRcUrP78GJ0pa+g83fIg1jEzF29hm36VEytPSLGzyNAItGQQbkeoLCc6UH0v7eBuntYXAwBqo62lkMKunj/AoiVvDN8KzG8pGcPnwa8s/PSnk7s2JHZBtHmXloQrcaqJyTqVuZCcXBMmtYftpSyoDZHApL3CgKoxKSP0gyPmkKSjUc19jGy3NHHpK6sR98JL4URQ8qhBCqvHAHdV3gMOENCxwFjD8WpITaeUJMVL6A5pcxW5P4Vpc7gh4Mo8qXzpxZiMtNnzP1CfdgSUNsQdL0EA78k112OMWuRNQVT/gcTITxr/Q9wzAlq5uG6XtacB2Acb96fGt1s2b6hH4zlKDk0vyq7qGCITgXtp9YIMNHkipJ7/pN9GIyvfp4/AxBwAwdJuq0i51A5A/BEzf/IQedBusc3jYzy/ZFEOhJYy+Xtwt3J4kDM0WUi7hY5gapJO2PNxUryV12/3o4kAOL1WRoKfQ3ua0wegzg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b4bec7-7562-46cc-5fcc-08d85a7061eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:43:20.0476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1oITwtW7kLyUMoMgW7wNXl09BClxfBYjaCiQnHMJqEedPTNiVqUuoPgVpqzJt/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
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
Cc: Jonathan.Kim@amd.com, Felix.Kuehling@amd.com, Ramesh.Errabolu@amd.com,
 Laurent.Morichetti@amd.com, Philip Cox <Philip.Cox@amd.com>, Tony.Tye@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add per-process eviction counters to sysfs to keep track of
how many eviction events have happened for each process.

v2: rename the stats dir, and track all evictions per process, per device.
v3: Simplify the stats kobject handling and cleanup.

Signed-off-by: Philip Cox <Philip.Cox@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 97 +++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index cafbc3aa980a..5b9e0df2a90e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -653,6 +653,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
 			    pdd->process->pasid);
 
+	pdd->last_evict_timestamp = get_jiffies_64();
 	/* Mark all queues as evicted. Deactivate all active queues on
 	 * the qpd.
 	 */
@@ -714,6 +715,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		q->properties.is_active = false;
 		decrement_queue_count(dqm, q->properties.type);
 	}
+	pdd->last_evict_timestamp = get_jiffies_64();
 	retval = execute_queues_cpsch(dqm,
 				qpd->is_debug ?
 				KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
@@ -732,6 +734,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 	struct mqd_manager *mqd_mgr;
 	struct kfd_process_device *pdd;
 	uint64_t pd_base;
+	uint64_t eviction_duration;
 	int retval, ret = 0;
 
 	pdd = qpd_to_pdd(qpd);
@@ -799,6 +802,8 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 			ret = retval;
 	}
 	qpd->evicted = 0;
+	eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
+	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
 out:
 	if (mm)
 		mmput(mm);
@@ -812,6 +817,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	struct queue *q;
 	struct kfd_process_device *pdd;
 	uint64_t pd_base;
+	uint64_t eviction_duration;
 	int retval = 0;
 
 	pdd = qpd_to_pdd(qpd);
@@ -845,6 +851,9 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	qpd->evicted = 0;
+	eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
+	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
+
 out:
 	dqm_unlock(dqm);
 	return retval;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 023629f28495..a500fe611b43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -631,7 +631,7 @@ enum kfd_pdd_bound {
 	PDD_BOUND_SUSPENDED,
 };
 
-#define MAX_SYSFS_FILENAME_LEN 11
+#define MAX_SYSFS_FILENAME_LEN 15
 
 /*
  * SDMA counter runs at 100MHz frequency.
@@ -692,6 +692,13 @@ struct kfd_process_device {
 	uint64_t sdma_past_activity_counter;
 	struct attribute attr_sdma;
 	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
+
+	/* Eviction activity tracking */
+	unsigned long last_evict_timestamp;
+	atomic64_t evict_duration_counter;
+	struct attribute attr_evict;
+
+	struct kobject *kobj_stats;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1e15aa7d8ae8..b4ba394ad599 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -344,6 +344,26 @@ static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
 
 	return 0;
 }
+static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
+				     struct attribute *attr, char *buffer)
+{
+	if (strcmp(attr->name, "evicted_ms") == 0) {
+		struct kfd_process_device *pdd = container_of(attr,
+				struct kfd_process_device,
+				attr_evict);
+		uint64_t evict_jiffies;
+
+		evict_jiffies = atomic64_read(&pdd->evict_duration_counter);
+
+		return snprintf(buffer,
+				PAGE_SIZE,
+				"%llu\n",
+				jiffies64_to_msecs(evict_jiffies));
+	} else
+		pr_err("Invalid attribute");
+
+	return 0;
+}
 
 static struct attribute attr_queue_size = {
 	.name = "size",
@@ -376,6 +396,19 @@ static struct kobj_type procfs_queue_type = {
 	.default_attrs = procfs_queue_attrs,
 };
 
+static const struct sysfs_ops procfs_stats_ops = {
+	.show = kfd_procfs_stats_show,
+};
+
+static struct attribute *procfs_stats_attrs[] = {
+	NULL
+};
+
+static struct kobj_type procfs_stats_type = {
+	.sysfs_ops = &procfs_stats_ops,
+	.default_attrs = procfs_stats_attrs,
+};
+
 int kfd_procfs_add_queue(struct queue *q)
 {
 	struct kfd_process *proc;
@@ -417,6 +450,60 @@ static int kfd_sysfs_create_file(struct kfd_process *p, struct attribute *attr,
 	return ret;
 }
 
+static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
+{
+	int ret = 0;
+	struct kfd_process_device *pdd;
+	char stats_dir_filename[MAX_SYSFS_FILENAME_LEN];
+
+	if (!p)
+		return -EINVAL;
+
+	if (!p->kobj)
+		return -EFAULT;
+
+	/*
+	 * Create sysfs files for each GPU:
+	 * - proc/<pid>/stats_<gpuid>/
+	 * - proc/<pid>/stats_<gpuid>/evicted_ms
+	 */
+	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
+		struct kobject *kobj_stats;
+
+
+		snprintf(stats_dir_filename, MAX_SYSFS_FILENAME_LEN,
+				"stats_%u", pdd->dev->id);
+		kobj_stats = kfd_alloc_struct(kobj_stats);
+		if (!kobj_stats) {
+			kfree(kobj_stats);
+			return -ENOMEM;
+		}
+
+		ret = kobject_init_and_add(kobj_stats,
+						&procfs_stats_type,
+						p->kobj,
+						stats_dir_filename);
+
+		if (ret) {
+			pr_warn("Creating KFD proc/stats_%s folder failed",
+					stats_dir_filename);
+			kobject_put(kobj_stats);
+			goto err;
+		}
+
+		pdd->kobj_stats = kobj_stats;
+		pdd->attr_evict.name = "evicted_ms";
+		pdd->attr_evict.mode = KFD_SYSFS_FILE_MODE;
+		sysfs_attr_init(&pdd->attr_evict);
+		ret = sysfs_create_file(kobj_stats, &pdd->attr_evict);
+		if (ret)
+			pr_warn("Creating eviction stats for gpuid %d failed",
+				(int)pdd->dev->id);
+	}
+err:
+	return ret;
+}
+
 static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 {
 	int ret = 0;
@@ -660,6 +747,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
 		if (!process->kobj_queues)
 			pr_warn("Creating KFD proc/queues folder failed");
 
+		ret = kfd_procfs_add_sysfs_stats(process);
+		if (ret)
+			pr_warn("Creating sysfs stats dir for pid %d failed",
+				(int)process->lead_thread->pid);
+
 		ret = kfd_procfs_add_sysfs_files(process);
 		if (ret)
 			pr_warn("Creating sysfs usage file for pid %d failed",
@@ -816,6 +908,10 @@ static void kfd_process_wq_release(struct work_struct *work)
 		list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 			sysfs_remove_file(p->kobj, &pdd->attr_vram);
 			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
+			sysfs_remove_file(p->kobj, &pdd->attr_evict);
+			kobject_del(pdd->kobj_stats);
+			kobject_put(pdd->kobj_stats);
+			pdd->kobj_stats = NULL;
 		}
 
 		kobject_del(p->kobj);
@@ -1125,6 +1221,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->runtime_inuse = false;
 	pdd->vram_usage = 0;
 	pdd->sdma_past_activity_counter = 0;
+	atomic64_set(&pdd->evict_duration_counter, 0);
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
