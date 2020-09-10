Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56222C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C166C21941
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pLMFHODO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C166C21941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02A86E16F;
	Thu, 10 Sep 2020 18:54:46 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900006E167
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 18:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRzFDFoO0fP197l53+zFdSG9LFrv1k3V4GD02Q5J8TWkx2OIraijaPKHlaXfAhcsShNzhFE222f/4EcaYVAf+cPvvkZTcnjthtFEbM5GgXGzHTxkTdbtXKmtYzdj+iErYmtMJ70D0aqm6y+huRfl3p1gOzcTDorjn3o3livDkEIO0iAiVGTkeT7C05s8lTKfzXPrSlPjc8CN4zObk4NLmfmah58wYMkB/BfnEdAIYM0klMi8ON6ONAqXbHy0h1SW5PBO0Cqemfmk/YtkOoer55b1z9AHsf8cDnAWLY9THuK2w1IY0U1zPyY07kMQLlfV5ikJrFbyI3bVfiKkKFMQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2JkJt32ZbzM407u9ddSTbNgcJ1GWwXZ6L2Vs2B8Xgw=;
 b=iWh7Jhnj+1qmRQRL6aAk79dcWS2e27h/3cSzFiW4hfmE/jKD2bH8OTyH9J2io8xCbOQCOmoEVn77/HilhsTFQXVApmoYZa3qfvUVLSYrB8DdS9ahMHYkAW/mcvycbFCd9+vWhYLumXnEAz4uQ1lRHf0/7/ff+Bgo6JhUWvIYHYFOjpUPm51X19QNrjEBBhKqQ2iKgUVUTExclhzwiHCJCbqWAnURDxlOZBRzsJroshNLcHiYPnM1UtAR2UQYEBu60UFGQY+v6TeAGv2nYRzJZOnYz7I4+KVtdPcJeT6n6zJ0a+/MXK8zq2eZm8mcZlLf/78cKCx55li4PJjPO8mqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2JkJt32ZbzM407u9ddSTbNgcJ1GWwXZ6L2Vs2B8Xgw=;
 b=pLMFHODO8szJalXiN7KNbv72nCG1hgcZc1BuWBvW8GGvBueLUVywzG08z20xw5TTqEFRKMrihM5wxkkabzwzQrr4O78uJ+hwFjY/ixdNYIU2/GpWq3oEYGmnBuRzlQ5KRhhFUfOqAOK2YxEzV7NheFYFOEk6rEN55yWvM23wRU4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) by
 DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 18:54:44 +0000
Received: from DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b]) by DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b%2]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 18:54:44 +0000
From: Philip Cox <Philip.Cox@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdkfd: Add process eviction counters to sysfs
Date: Thu, 10 Sep 2020 14:54:28 -0400
Message-Id: <20200910185429.14011-2-Philip.Cox@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910185429.14011-1-Philip.Cox@amd.com>
References: <20200910185429.14011-1-Philip.Cox@amd.com>
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR12MB3404.namprd12.prod.outlook.com
 (2603:10b6:5:3a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pscox.amd.com (165.204.55.251) by
 YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 18:54:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30bd00ba-97cf-4a72-9ce0-08d855bafb89
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42658506EFAE12797DB240E583270@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0FKlzbqilOoA0JkRaDdfoTTjsGO+SzNZY81UB5eFKD2tQ+7RzlLijuVTyHIZF8M2Kr6nr8zTjtwg6cdgWJx8N2yzh7Aw08MEWjfFMWNs7NJjuAXzCJHAPhT0OtKA5ZHGQ+OD8Oaoj39R18yUb0UfysVtCdKuXFPMDL7yDK2pikLja0YNHcZTyazXB1Iy50YnrNvZJehburZHCU4hPynTpK6M0q5ioLPVtGZlBBPCexF4lnRPYj3hFKOxOJO9BQ7yhGl1TicwkC5mo0r5WjT+iSkThn351jZhh0kk0ZN2qfe3dm/vk/Rq71mTByo58ic5f5c+/T602U0qXhSGQQUfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(7696005)(26005)(8936002)(5660300002)(1076003)(36756003)(66476007)(956004)(66946007)(316002)(6486002)(2616005)(86362001)(6916009)(66556008)(478600001)(6666004)(8676002)(52116002)(16526019)(83380400001)(186003)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kulD62JRhztZnXyV0Xz23Vl+zgBkdJX8jXOFNPSdcwEM8VFzf0ejHvq9iKZfGWQZFLlE5G+Oq5wAd08P5zwVYEmC5hbkdCC/HiC32Cs8k0vJI8vVY7q+p+wegGmwhQSfkM+/I1CxNeZAk8VcNpluDAB2JyPCm26gvgLJTviZzi7MsPPlNuaM6sKXCEwCmemCuKXfY3b+9UrTM2b/tF8uQbHZ4vMHA56KaNfnhgFsiVL3QiW59gQlzlfkw3OIa1eZNmFXWwxBZEUp4o3s//U+eAuHNn+bvqtZTLBm3fX1RMsejdZeEBX0ZFckUM6bRJfRcRryWElVYSXp9ECv6euTKKIjz/urhJegaL3W238+Y0oa+eweaSnngEd6ta8DKvATyrS3PEnpTRalJ+nC5b0sxEt/gzaDIB5P8Khg8jNfm2oPqvj1DGleg54DztZPwgDiJe0tCkJJ7xz5AmDrZ9h60ENMMK8h8Sv89dPVSNpKOZOCWDovu/G99PSiSGpWizlQX4tenbVQEftkkcGp87yNfciYRly9DzxxKE38X2MQEM1+wQOYMtTa6SOU/9LQ9smxzoRANAU7zycwldRhyu8ECv19/FPS2UdwoTzN3wiRt9Z2FwOKVo+1Q3dlDN+b0VN78H6bWsN8OKyJVdgPOsWU2w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bd00ba-97cf-4a72-9ce0-08d855bafb89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 18:54:44.6962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb1zjurCVcHCLgp5mV2p0SGbECd+ELIJoV8x/iR5hazdL6aThvHm2PWGhZrtPT8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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
Cc: Philip Cox <Philip.Cox@amd.com>, Felix.Kuehling@amd.com, Tony.Tye@amd.com,
 Laurent.Morichetti@amd.com, Jonathan.Kim@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add per-process eviction counters to sysfs to keep track of
how many eviction events have happened for each process.

Signed-off-by: Philip Cox <Philip.Cox@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  15 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 117 +++++++++++++++++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 023629f28495..f6902e9c6077 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -631,7 +631,7 @@ enum kfd_pdd_bound {
 	PDD_BOUND_SUSPENDED,
 };
 
-#define MAX_SYSFS_FILENAME_LEN 11
+#define MAX_SYSFS_FILENAME_LEN 15
 
 /*
  * SDMA counter runs at 100MHz frequency.
@@ -692,10 +692,19 @@ struct kfd_process_device {
 	uint64_t sdma_past_activity_counter;
 	struct attribute attr_sdma;
 	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
+
+	/* Eviction activity tracking */
+	atomic64_t evict_duration_counter;
+	struct attribute attr_evict;
+	char evict_filename[MAX_SYSFS_FILENAME_LEN];
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
 
+struct kobj_counters_list {
+	struct list_head counters_list;
+	struct kobject *kobj;
+};
 /* Process data */
 struct kfd_process {
 	/*
@@ -766,13 +775,15 @@ struct kfd_process {
 	/* seqno of the last scheduled eviction */
 	unsigned int last_eviction_seqno;
 	/* Approx. the last timestamp (in jiffies) when the process was
-	 * restored after an eviction
+	 * restored or evicted.
 	 */
 	unsigned long last_restore_timestamp;
+	unsigned long last_evict_timestamp;
 
 	/* Kobj for our procfs */
 	struct kobject *kobj;
 	struct kobject *kobj_queues;
+	struct kobj_counters_list counters;
 	struct attribute attr_pasid;
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1e15aa7d8ae8..2a81d5a790a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -344,6 +344,26 @@ static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
 
 	return 0;
 }
+static ssize_t kfd_procfs_counters_show(struct kobject *kobj,
+				     struct attribute *attr, char *buffer)
+{
+	if (strcmp(attr->name, "evictions") == 0) {
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
 
+static const struct sysfs_ops procfs_counters_ops = {
+	.show = kfd_procfs_counters_show,
+};
+
+static struct attribute *procfs_counters_attrs[] = {
+	NULL
+};
+
+static struct kobj_type procfs_counters_type = {
+	.sysfs_ops = &procfs_counters_ops,
+	.default_attrs = procfs_counters_attrs,
+};
+
 int kfd_procfs_add_queue(struct queue *q)
 {
 	struct kfd_process *proc;
@@ -417,6 +450,70 @@ static int kfd_sysfs_create_file(struct kfd_process *p, struct attribute *attr,
 	return ret;
 }
 
+static int kfd_procfs_add_sysfs_counters(struct kfd_process *p)
+{
+	int ret = 0;
+	struct kfd_process_device *pdd;
+	char counter_dir_filename[MAX_SYSFS_FILENAME_LEN];
+
+	if (!p)
+		return -EINVAL;
+
+	if (!p->kobj)
+		return -EFAULT;
+
+	INIT_LIST_HEAD(&p->counters.counters_list);
+	/*
+	 * Create sysfs files for each GPU:
+	 * - proc/<pid>/counters_<gpuid>/
+	 * - proc/<pid>/counters_<gpuid>/evictions
+	 */
+	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
+		struct kobj_counters_list *kobj_counter;
+
+		kobj_counter = kzalloc(sizeof(*kobj_counter),
+				GFP_KERNEL);
+		if (!kobj_counter)
+			return -ENOMEM;
+
+		snprintf(counter_dir_filename, MAX_SYSFS_FILENAME_LEN,
+				"counters_%u", pdd->dev->id);
+		kobj_counter->kobj = kfd_alloc_struct(kobj_counter->kobj);
+		if (!kobj_counter->kobj) {
+			kfree(kobj_counter);
+			return -ENOMEM;
+		}
+
+		ret = kobject_init_and_add(kobj_counter->kobj,
+						&procfs_counters_type,
+						p->kobj,
+						counter_dir_filename);
+
+		if (ret) {
+			pr_warn("Creating KFD proc/counters_%s folder failed",
+					counter_dir_filename);
+			kobject_put(kobj_counter->kobj);
+			kfree(kobj_counter);
+			goto err;
+		}
+
+		list_add(&kobj_counter->counters_list,
+				&p->counters.counters_list);
+		snprintf(pdd->evict_filename,
+				MAX_SYSFS_FILENAME_LEN,
+				"evictions");
+		pdd->attr_evict.name = pdd->evict_filename;
+		pdd->attr_evict.mode = KFD_SYSFS_FILE_MODE;
+		sysfs_attr_init(&pdd->attr_evict);
+		ret = sysfs_create_file(kobj_counter->kobj, &pdd->attr_evict);
+		if (ret)
+			pr_warn("Creating eviction counter for gpuid %d failed",
+				(int)pdd->dev->id);
+	}
+err:
+	return ret;
+}
+
 static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 {
 	int ret = 0;
@@ -660,6 +757,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
 		if (!process->kobj_queues)
 			pr_warn("Creating KFD proc/queues folder failed");
 
+		ret = kfd_procfs_add_sysfs_counters(process);
+		if (ret)
+			pr_warn("Creating sysfs counter dir for pid %d failed",
+				(int)process->lead_thread->pid);
+
 		ret = kfd_procfs_add_sysfs_files(process);
 		if (ret)
 			pr_warn("Creating sysfs usage file for pid %d failed",
@@ -806,6 +908,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 					     release_work);
 	struct kfd_process_device *pdd;
 
+	struct kobj_counters_list *counters;
 	/* Remove the procfs files */
 	if (p->kobj) {
 		sysfs_remove_file(p->kobj, &p->attr_pasid);
@@ -818,6 +921,14 @@ static void kfd_process_wq_release(struct work_struct *work)
 			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
 		}
 
+		list_for_each_entry(counters,
+				&p->counters.counters_list,
+				counters_list) {
+			sysfs_remove_file(p->kobj, &pdd->attr_evict);
+			kobject_del(counters->kobj);
+			kobject_put(counters->kobj);
+		}
+
 		kobject_del(p->kobj);
 		kobject_put(p->kobj);
 		p->kobj = NULL;
@@ -1125,6 +1236,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->runtime_inuse = false;
 	pdd->vram_usage = 0;
 	pdd->sdma_past_activity_counter = 0;
+	atomic64_set(&pdd->evict_duration_counter, 0);
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */
@@ -1388,7 +1500,9 @@ int kfd_process_restore_queues(struct kfd_process *p)
 {
 	struct kfd_process_device *pdd;
 	int r, ret = 0;
+	uint64_t eviction_duration;
 
+	eviction_duration = p->last_restore_timestamp - p->last_evict_timestamp;
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
@@ -1397,6 +1511,7 @@ int kfd_process_restore_queues(struct kfd_process *p)
 			if (!ret)
 				ret = r;
 		}
+		atomic64_add(eviction_duration, &pdd->evict_duration_counter);
 	}
 
 	return ret;
@@ -1425,6 +1540,8 @@ static void evict_process_worker(struct work_struct *work)
 	 */
 	flush_delayed_work(&p->restore_work);
 
+	p->last_evict_timestamp = get_jiffies_64();
+
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
 	ret = kfd_process_evict_queues(p);
 	if (!ret) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
