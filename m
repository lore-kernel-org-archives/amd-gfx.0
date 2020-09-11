Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36807C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 20:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720822054F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 20:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zPe5fV+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720822054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB6FD6E0AC;
	Fri, 11 Sep 2020 20:10:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D88B6E0AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 20:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfUGWnQUfNfmWnTl1jL3WlShoq/666XTuH8kqb648ehQD4103cuAqQ+hFcILCA+rrhD0yXrwukMbzc5aG/YoBqqA52ufxw8D6mlZ1QoNgbM5c3wUs+i1FaAJOXZjPyXIJYsjl9O0X/1uujA9d5h2SIg9R28BbLeb4YbZsO7c3LFRdL9bkC2coCI7MF2w3rPZPvY/awEKyj6oyFlRphLFa499N3oa4cShdIt+ivaOKU85iVTN5VwllKKEOUdOoSQUNugY1xWZ0Rv5iySdDt7yCC2Hp2ZvWGyByx3hbWMus2rluV2qtzzV8umkyUUamTWOh+axPbtjp7k/urFx/7zedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq3PCNB1SYxkglNiWhlP21JO62ZI326HnJfI27/W+2Q=;
 b=J+SnXNPGnVs14pZhkLHI208yshtDAciqj51mNkvg4268OC/3wmAidgBaWEyIxSJKBrlvvgcuJzcdktUhCyz0z1BP0Q4upe1oQ2yUTUEzuKRBU5tTD0AESrW8y2+c83HfLyTPMs7rhVRHseXdZO57k9RkRvj9XS/xUNJZIAupoMh0Ih9H3frcfLGMgRyn3gbfF9itoa56PWAukRqcG/XJ0tz9noJhFOnbxVewYKz/tlUlsykw5YIn2npU7Sx40M79A7GzwDpcR3ULrs/umeCA5FcFSX8slD4lLNRxg5GnqPTDVnSzLPl90ZyW0QjaA3+mx90iOwV6XAsmhkN2mMN5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq3PCNB1SYxkglNiWhlP21JO62ZI326HnJfI27/W+2Q=;
 b=zPe5fV+lYkMuOkPntNJr/Orkrn4u0kbiX8xxEK6BbhPuoBZDjQMs9fy15/Bhu7C30iDSpTztpuKNnOy+pVxn3/T8mpmoXXupTp0Dm9hrGHBAgJ12cXkmIU9LaTZruvxQjoJ0v7RF9IYR+a5iBHi0b45zVVH5iAHloY/5G8u2Y+A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) by
 DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 11 Sep 2020 20:10:29 +0000
Received: from DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b]) by DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b%2]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 20:10:29 +0000
From: Philip Cox <Philip.Cox@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/amdkfd: Add process eviction counters to sysfs
Date: Fri, 11 Sep 2020 16:10:00 -0400
Message-Id: <20200911201001.31710-2-Philip.Cox@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To DM6PR12MB3404.namprd12.prod.outlook.com
 (2603:10b6:5:3a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pscox.amd.com (165.204.55.251) by
 YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 20:10:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5a4e940-d019-4691-9e0f-08d8568ebab4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3211F6B227999F87743A4CDE83240@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3kdhH4xV7TtP2TVLh+8Es0Pd7nzAUIbShD4fyojIryXNxXqYuwaTBLTHghXxwoz+TWQp4ApZbV/qm9tvwMTVyWC/kclAkFtZHPnDR+lasvOw4lG4QjpMAQ+SOAPWTlP5F/T6cbtmDkNusDk4ow8H9IbhACQfJpWfmJ26GMBZX7tyS3vbx9WQsNbkSftTsOGGtZfyf/oMsiy+gG2j5f4VX1Fnt3X8IB18kvc39wmjEsptDDuIDiMEgumffZoyRhzMWZ/tJTqUyIxT6wHNQAN1ZtTOfHiBanoD8nrrnVYBIfTzCGoBd1tiGtPsrneIFi1GPv+SGy273i6VNeT0I1JdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(186003)(36756003)(66946007)(2616005)(52116002)(956004)(5660300002)(8676002)(16526019)(2906002)(7696005)(6666004)(478600001)(83380400001)(316002)(6916009)(66476007)(66556008)(1076003)(86362001)(8936002)(4326008)(26005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V0+ZBJde661v3VjcIoMGMATHfmX5EXrcCzQTlNlmOKk4hP3jDCVObAmDqxMWcZYehYdku53vMUZJZHK87xMJtLg9UJLbj1MOJEia8DQsw3uiohFyfZjKl4R1pZcCu0+ue52jfXyOWacQ2FL6izizYqHLDsyOLFTbE9l/iFLNCZ2W67Qb5aC3eQezYZXg9hOaCBZQJmo8G8N7D/uuegiGTIph0zqqBn5H8r+dyEllMD/5QttEX75KFyqCjbp8ZMpIdrWNyfM/C2sdSFcKpw6eOxONAbhb3zQsJHM+wUiftVMv1iBXhrdAMP+3M3CY+JNViLbJeKtqA7e38MLHuUOJOF38LDlthhwAlxPulOYQi5rBlbw4GA7SZkluRoQfY6gMoQnfxQzWv7hIIGAw19OX7vW2gdQQAcILeNDCTgjggJMF8Tx/Aj4rUtLy0d5RXJHW1upKuMX/L9jyJjMaYmfht2golvFQpaPA5O/huK4ciBHBlh2zCIxCXbXZxDZJKN/Gm5tySgBEQf055u6ZtyBBG8KmJRwFZdUtnYoIE6u2oLxM3sctFJrNIzODuVc/zdObtHB4LZVqlVmDYz/xITXS69F/eg6ORykkVd8pWgQA0uDNt+hW4Sp8QOsOsv/WE8x4aIT4UiiRMsHHxp6t4HNiZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a4e940-d019-4691-9e0f-08d8568ebab4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 20:10:29.2668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5Ooymb80IiXTLjASq1gAxPM0W3GfYifDjGWJh+1OyVVeVaRU/mdUDxWuRBJZTgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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

v2: rename the stats dir, and track all evictions per process, per device.

Signed-off-by: Philip Cox <Philip.Cox@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  15 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 109 ++++++++++++++++++
 3 files changed, 131 insertions(+), 2 deletions(-)

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
index 023629f28495..468c69d22117 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -631,7 +631,7 @@ enum kfd_pdd_bound {
 	PDD_BOUND_SUSPENDED,
 };
 
-#define MAX_SYSFS_FILENAME_LEN 11
+#define MAX_SYSFS_FILENAME_LEN 15
 
 /*
  * SDMA counter runs at 100MHz frequency.
@@ -692,10 +692,20 @@ struct kfd_process_device {
 	uint64_t sdma_past_activity_counter;
 	struct attribute attr_sdma;
 	char sdma_filename[MAX_SYSFS_FILENAME_LEN];
+
+	/* Eviction activity tracking */
+	unsigned long last_restore_timestamp;
+	unsigned long last_evict_timestamp;
+	atomic64_t evict_duration_counter;
+	struct attribute attr_evict;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
 
+struct kobj_stats_list {
+	struct list_head stats_list;
+	struct kobject *kobj;
+};
 /* Process data */
 struct kfd_process {
 	/*
@@ -766,13 +776,14 @@ struct kfd_process {
 	/* seqno of the last scheduled eviction */
 	unsigned int last_eviction_seqno;
 	/* Approx. the last timestamp (in jiffies) when the process was
-	 * restored after an eviction
+	 * restored or evicted.
 	 */
 	unsigned long last_restore_timestamp;
 
 	/* Kobj for our procfs */
 	struct kobject *kobj;
 	struct kobject *kobj_queues;
+	struct kobj_stats_list stats;
 	struct attribute attr_pasid;
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1e15aa7d8ae8..d786ba80d656 100644
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
@@ -417,6 +450,67 @@ static int kfd_sysfs_create_file(struct kfd_process *p, struct attribute *attr,
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
+	INIT_LIST_HEAD(&p->stats.stats_list);
+	/*
+	 * Create sysfs files for each GPU:
+	 * - proc/<pid>/stats_<gpuid>/
+	 * - proc/<pid>/stats_<gpuid>/evicted_ms
+	 */
+	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
+		struct kobj_stats_list *kobj_stats;
+
+		kobj_stats = kzalloc(sizeof(*kobj_stats),
+				GFP_KERNEL);
+		if (!kobj_stats)
+			return -ENOMEM;
+
+		snprintf(stats_dir_filename, MAX_SYSFS_FILENAME_LEN,
+				"stats_%u", pdd->dev->id);
+		kobj_stats->kobj = kfd_alloc_struct(kobj_stats->kobj);
+		if (!kobj_stats->kobj) {
+			kfree(kobj_stats);
+			return -ENOMEM;
+		}
+
+		ret = kobject_init_and_add(kobj_stats->kobj,
+						&procfs_stats_type,
+						p->kobj,
+						stats_dir_filename);
+
+		if (ret) {
+			pr_warn("Creating KFD proc/stats_%s folder failed",
+					stats_dir_filename);
+			kobject_put(kobj_stats->kobj);
+			kfree(kobj_stats);
+			goto err;
+		}
+
+		list_add(&kobj_stats->stats_list,
+				&p->stats.stats_list);
+		pdd->attr_evict.name = "evicted_ms";
+		pdd->attr_evict.mode = KFD_SYSFS_FILE_MODE;
+		sysfs_attr_init(&pdd->attr_evict);
+		ret = sysfs_create_file(kobj_stats->kobj, &pdd->attr_evict);
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
@@ -660,6 +754,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
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
@@ -806,6 +905,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 					     release_work);
 	struct kfd_process_device *pdd;
 
+	struct kobj_stats_list *stats;
 	/* Remove the procfs files */
 	if (p->kobj) {
 		sysfs_remove_file(p->kobj, &p->attr_pasid);
@@ -818,6 +918,14 @@ static void kfd_process_wq_release(struct work_struct *work)
 			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
 		}
 
+		list_for_each_entry(stats,
+				&p->stats.stats_list,
+				stats_list) {
+			sysfs_remove_file(p->kobj, &pdd->attr_evict);
+			kobject_del(stats->kobj);
+			kobject_put(stats->kobj);
+		}
+
 		kobject_del(p->kobj);
 		kobject_put(p->kobj);
 		p->kobj = NULL;
@@ -1125,6 +1233,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
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
