Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DEC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 13:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3875B206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h4s8OKme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3875B206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6656FB48;
	Fri, 31 Jan 2020 13:45:59 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700061.outbound.protection.outlook.com [40.107.70.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF30D6FB48
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 13:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/cUJNb4C1XGFmW3DOb2qUiarB63RVQFFGHUjVkKQuRIFiDmfYXEW1S30yB+UqAtMVKy9v2N9tQUMnbQ/mf7f97kDhrflbrR4xvWOTY6/RdScP7iBguUTbH36i9UynUxvDVOA6xzdbb8910vZgy6BvV7R+mGgre8UIy/wPtJ3qc4eaUH634T5ufAngYsEecNtiibCgkVvPKGYb/brkb/ZZlCL5Wra97gKmhMzn0fJ0MONle9c1xJlA5DH9QeGb9t25+WWr2jk9IUcK9DmICjNjJP/EhwCTtGHTYhted3YRA5XSQolWmBSqpyREdSlhXVhn132ou6DunIHdu3DwVByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmsVgk8iNcFm5bC2BLtKL3XRWIFKBSsYoseXJasa+5U=;
 b=JCsBre63fx/T48K4l1aLGqryKPpPE1en8Cr/6HvOloiK2CCytu2fmdSsnwGsq5FOQyQRCXWzRSexrnGXG3bICUMhINrTcEsCpGgBUzBq6aaCY5d95Sa3b/L2u3THQgDIzdXhPZdn40bbo48on29torHlXddpa2N84uTRDnPy9bP8V2pqMiQfy+JeHeAZUHXXHqflZo/O10gctkcb7CJQAxM9rECzaoQZom4uj8EL/FhgmCFZOhlLJOHFW0SPKK0rPr2XkY2Po9rAvpKyK9eYTMiTOXTSbMYZurbW8YXP0YIUintaRgay2owiqm6o0bxR8WH192cQu9U83iW+mPcl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmsVgk8iNcFm5bC2BLtKL3XRWIFKBSsYoseXJasa+5U=;
 b=h4s8OKmeIzWERyOkrByapXdoB7jDtrcnsSjbgDe0Tc3t1qrlWHQbaLNxjyfgYKz+5vg+Mwn7aUrTkCt1yi5qM79hqfiAGo0tDv8k0KEjP5K6MLKAsAcj0FQ9EpD0kPhgo5dxfqrG+DOTXThTD+OSI3iu3kdjgu2DGSUCBfQhpZk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from DM6PR12MB3050.namprd12.prod.outlook.com (20.178.30.142) by
 DM6PR12MB2794.namprd12.prod.outlook.com (20.176.116.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Fri, 31 Jan 2020 13:45:57 +0000
Received: from DM6PR12MB3050.namprd12.prod.outlook.com
 ([fe80::fd6d:4cf1:218f:b398]) by DM6PR12MB3050.namprd12.prod.outlook.com
 ([fe80::fd6d:4cf1:218f:b398%3]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 13:45:57 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: Add queue information to sysfs
Date: Fri, 31 Jan 2020 08:45:44 -0500
Message-Id: <1580478344-14836-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To DM6PR12MB3050.namprd12.prod.outlook.com
 (2603:10b6:5:11a::14)
MIME-Version: 1.0
Received: from alin.amd.com (165.204.55.251) by
 YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2665.22 via Frontend Transport; Fri, 31 Jan 2020 13:45:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ff061a7-7325-4257-663f-08d7a653e62d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2794:|DM6PR12MB2794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB279447C54A7B7A74F1588DD3E1070@DM6PR12MB2794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(81166006)(478600001)(26005)(8676002)(186003)(81156014)(6486002)(2906002)(66946007)(66476007)(66556008)(36756003)(5660300002)(52116002)(7696005)(4326008)(956004)(2616005)(8936002)(86362001)(6916009)(6666004)(16526019)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2794;
 H:DM6PR12MB3050.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ly4wig1/8DxtmEFNZYElhgvAs3iRxTrZw7PJXti8CGQxgtJOvpoB1u3wtzObFZTWnus/Es2SBeofTLQd6Tair5BW+ddHodLoVMpwey5vyaHjgCZruZ8UKzXR8CGrKqorSELjy4CvwTdbjk9vuwcGqpUGSTdYLePtmjT6ESf/7Bx4fr6Z+/UuX2q8KuSwMfYwTvik1USD3rIoIdFASctlVgI+D/xaIob+JHlQq8P52VHt0CLBnZfw+rSzXjLL/3LKPnJuzr2nXKTAReDsCFmvnjOKm3kwNANnFfLNNrxPG1wm7W1mgnQqIdn6a7jJ4PLPshj2vhBVrJrSBx6ug2WNxjUYjF0X7C5i9Sk2R9bfED7s2oBsTH6sSu2g9GOoIXIDsoTyayDRbwUyLTSPCqwH2JMRU2pxbzLHGhd0JawdrEbi3HPh9eRiy8uyJGbyZAi+
X-MS-Exchange-AntiSpam-MessageData: 3qUL4Fuebt/Yga1zoA5BJ2bVABCC7A1fBMSFmpZ1swhNCcHybsZVLESGT5iFkr7cMbvC4d6p5lsEI5Hd8AB6M6GbW42OlgATkwq8LiRb/JOG06QdSVELDfdVxhmhrer0GcarnSxEkKBkF7/G3lNVYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff061a7-7325-4257-663f-08d7a653e62d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 13:45:57.2134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEOJeyg0LHgJ0dXuTNzN6MeypQBkr47PgrPUkUT0T1Va8T1ZR5LcaG9+wTGw7bv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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
Cc: Amber Lin <Amber.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Provide compute queues information in sysfs under /sys/class/kfd/kfd/proc.
The format is /sys/class/kfd/kfd/proc/<pid>/queues/<queue id>/XX where
XX are size, type, and gpuid three files to represent queue size, queue
type, and the GPU this queue uses. <queue id> folder and files underneath
are generated when a queue is created. They are removed when the queue is
destroyed.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 96 ++++++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  2 +
 3 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c0b0def..cb2d2d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -503,6 +503,12 @@ struct queue {
 	struct kfd_process	*process;
 	struct kfd_dev		*device;
 	void *gws;
+
+	/* procfs */
+	struct kobject *kobj_qid;
+	struct attribute attr_size;
+	struct attribute attr_type;
+	struct attribute attr_gpuid;
 };
 
 /*
@@ -730,6 +736,7 @@ struct kfd_process {
 
 	/* Kobj for our procfs */
 	struct kobject *kobj;
+	struct kobject *kobj_queues;
 	struct attribute attr_pasid;
 };
 
@@ -836,6 +843,8 @@ extern struct device *kfd_device;
 /* KFD's procfs */
 void kfd_procfs_init(void);
 void kfd_procfs_shutdown(void);
+int kfd_procfs_add_queue(struct queue *q);
+void kfd_procfs_del_queue(struct queue *q);
 
 /* Topology */
 int kfd_topology_init(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 25b90f7..78ca037 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -132,6 +132,94 @@ void kfd_procfs_shutdown(void)
 	}
 }
 
+static int kfd_procfs_add_file(const char *name, struct kobject *kobj,
+			       struct attribute *attr)
+{
+	int ret;
+
+	attr->name = name;
+	attr->mode = KFD_SYSFS_FILE_MODE;
+	sysfs_attr_init(attr);
+	ret = sysfs_create_file(kobj, attr);
+	if (ret)
+		pr_warn("Creating %s file failed", name);
+	return ret;
+}
+
+static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
+				     struct attribute *attr, char *buffer)
+{
+	if (!strcmp(attr->name, "size")) {
+		struct queue *q = container_of(attr, struct queue, attr_size);
+		return snprintf(buffer, PAGE_SIZE, "%llu",
+				q->properties.queue_size);
+	} else if (!strcmp(attr->name, "type")) {
+		struct queue *q = container_of(attr, struct queue, attr_type);
+		return snprintf(buffer, PAGE_SIZE, "%d", q->properties.type);
+	} else if (!strcmp(attr->name, "gpuid")) {
+		struct queue *q = container_of(attr, struct queue, attr_gpuid);
+		return snprintf(buffer, PAGE_SIZE, "%u", q->device->id);
+	} else
+		pr_err("Invalid attribute");
+
+	return 0;
+}
+
+static const struct sysfs_ops procfs_queue_ops = {
+	.show = kfd_procfs_queue_show,
+};
+
+static struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_kobj_release,
+	.sysfs_ops = &procfs_queue_ops,
+};
+
+int kfd_procfs_add_queue(struct queue *q)
+{
+	struct kfd_process *proc;
+	int ret;
+
+	if (!q || !q->process)
+		return -EINVAL;
+	proc = q->process;
+
+	/* Create proc/<pid>/queues/<queue id> folder*/
+	if (!proc->kobj_queues)
+		return -EFAULT;
+	if (q->kobj_qid)
+		return -EEXIST;
+	q->kobj_qid = kfd_alloc_struct(q->kobj_qid);
+	if (!q->kobj_qid)
+		return -ENOMEM;
+	ret = kobject_init_and_add(q->kobj_qid, &procfs_queue_type,
+			proc->kobj_queues, "%u", q->properties.queue_id);
+	if (ret < 0) {
+		pr_warn("Creating proc/<pid>/queues/%u failed",
+			q->properties.queue_id);
+		return ret;
+	}
+
+	/* Create proc/<pid>/queues/<queue id>/XX files */
+	kfd_procfs_add_file("size", q->kobj_qid, &q->attr_size);
+	kfd_procfs_add_file("type", q->kobj_qid, &q->attr_type);
+	kfd_procfs_add_file("gpuid", q->kobj_qid, &q->attr_gpuid);
+
+	return 0;
+}
+
+void kfd_procfs_del_queue(struct queue *q)
+{
+	if (!q || !q->process)
+		return;
+
+	sysfs_remove_file(q->kobj_qid, &q->attr_size);
+	sysfs_remove_file(q->kobj_qid, &q->attr_type);
+	sysfs_remove_file(q->kobj_qid, &q->attr_gpuid);
+	kobject_del(q->kobj_qid);
+	kobject_put(q->kobj_qid);
+	q->kobj_qid = NULL;
+}
+
 int kfd_process_create_wq(void)
 {
 	if (!kfd_process_wq)
@@ -323,6 +411,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
 		if (ret)
 			pr_warn("Creating pasid for pid %d failed",
 					(int)process->lead_thread->pid);
+
+		process->kobj_queues = kobject_create_and_add("queues",
+							process->kobj);
+		if (!process->kobj_queues)
+			pr_warn("Creating KFD proc/queues folder failed");
 	}
 out:
 	if (!IS_ERR(process))
@@ -457,6 +550,9 @@ static void kfd_process_wq_release(struct work_struct *work)
 	/* Remove the procfs files */
 	if (p->kobj) {
 		sysfs_remove_file(p->kobj, &p->attr_pasid);
+		kobject_del(p->kobj_queues);
+		kobject_put(p->kobj_queues);
+		p->kobj_queues = NULL;
 		kobject_del(p->kobj);
 		kobject_put(p->kobj);
 		p->kobj = NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8fa856e..cb1ca11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -322,6 +322,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 
 	if (q) {
 		pr_debug("PQM done creating queue\n");
+		kfd_procfs_add_queue(q);
 		print_queue_properties(&q->properties);
 	}
 
@@ -378,6 +379,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
+		kfd_procfs_del_queue(pqn->q);
 		dqm = pqn->q->device->dqm;
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
 		if (retval) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
