Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA44C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 05:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB342067C
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 05:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TYTXzxbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB342067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8A16E08A;
	Thu, 30 Jan 2020 05:46:30 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700086.outbound.protection.outlook.com [40.107.70.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8766E08A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 05:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq1L73wMJe7giYqf3czm6FnIJ9bVt32uO1jOoZtff09jWc4aIpwc3BQOyIb143S6c1nbiWAQAYLyy8koG27/w/PcmyIBTqVSeM+OL0Xa0lyrGuc2AVtjXKQ/RQVwHABuDbCLNEP2/F/nhXlcRIZjdI5GsE6cTj9Lm8jYHrRClHHkl3veyKInNoPLT+iVqDjqKNPQm1nupoClOlXWNEZOGIrvfDzbO8OrPTcLW4LfU+y5+vPRLs0qS/cOPSCVc/0YlvVBFDWF1pUzWJNNH7/weoYjdaZ7lMKvAPToO17vGeW5Jd/EYH1Wp1YdFH+OoBxnqHs8Zt/Kqn/RIJa02qtz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj6FvRrAGkJMKYNRmewCa16m7F+XY50YXVoXkTNr+zQ=;
 b=aXr89UleHG5Ayh+l3yhlImooxc1PdfE5HEhSqwiYnYjoii4Ig1iwdPF+vEGuz39s4vMFLb28SrYe3DXAGxyGZ3Ccsi7fbcGEzPwDmIDnZcd84svuptGbRoFDK+glgCiV8QDmHnFbqy+aU7FZKttmlrpLwMrH4AKkkXh1CGw1WUlJFJisfwSaCp/9CiZa2DdbRe8pRvzbTa0zMWKWNlVQEe04r0Dpg4bZSJET4xfJv630XC4Oi52QKiu5i6IhzvAUrY7EQT75TPI9qSKHVtZIjXe5kdCAQmKJUajrVlLZ9o3+zzvRZK45sUQh06PbtEhY7KprLNJ42+H95gbd7vKGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj6FvRrAGkJMKYNRmewCa16m7F+XY50YXVoXkTNr+zQ=;
 b=TYTXzxbX6L4ZYUBYWe7TQp1v3FAu8PIjqHL3wIn0/nRNl849H/jolFnx1Wi6hU4J/YWsCUYqQGd9HRrb0OhqporN6t0lkliAIIkmE638CnMPxBKzvyMJ+67tSnGk3BpM3L3dcEwnWOxKzeUs4h+myL1KSSIFeu1BUq2ltJooXbo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (20.178.211.139) by
 BN8PR12MB2852.namprd12.prod.outlook.com (20.179.64.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 30 Jan 2020 05:46:26 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::6d92:5a9:ed80:1e42]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::6d92:5a9:ed80:1e42%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 05:46:26 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add queue information to sysfs
Date: Thu, 30 Jan 2020 00:46:14 -0500
Message-Id: <1580363174-31854-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To BN8PR12MB3041.namprd12.prod.outlook.com
 (2603:10b6:408:46::11)
MIME-Version: 1.0
Received: from alin.amd.com (165.204.55.251) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.21 via Frontend
 Transport; Thu, 30 Jan 2020 05:46:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e93d2992-e67d-4222-7eb2-08d7a547bf02
X-MS-TrafficTypeDiagnostic: BN8PR12MB2852:|BN8PR12MB2852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2852210FFE6623006A18BD0DE1040@BN8PR12MB2852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(81156014)(6916009)(8676002)(5660300002)(186003)(16526019)(8936002)(81166006)(478600001)(86362001)(6486002)(7696005)(26005)(4326008)(6666004)(2616005)(36756003)(2906002)(956004)(52116002)(66946007)(66476007)(66556008)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB2852;
 H:BN8PR12MB3041.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbzOiDen+t1foC7jePE1cpd5/vjQviJFCZ6QEyitF1EeCXnNi5WVOgtgf4lDvwPyntBBSdYWvQSe/IKWR7vrVHPv+5wGpWFkErNC71dHD9LYqBCSvy+1Pc1nWZarG2eaJMwiviUPojTamfhLlJrQvQhUJt8IqixfKnF5oDQz0ba+HLnfbRme0YUk9FHk/3AVSLRYwseSv/v9iOlZDowp2NQ0s5CmYpW6RMgUujU6c4D3uaS/6qMjaKbcUvbWI4rxUJUFJr6vnArFNdfE6F+JN597z0ZD1LE4Ru+u1odTcT/e49vb9f2EmiH27oRo/LkTaw/+BtQkP9HVOYHKZTi8sP6kS7pVK88EICpyRHjLQQTvLlFxvvNSTM4HpiJRNsaW3VqYmiN2mriy7JePUYumw9dVkl1WrbACRZh/XAaVR3hT28XPlIvuhF2d2K/Km+hQ
X-MS-Exchange-AntiSpam-MessageData: wjVG8+ZDXtZ1v/3JUjG4/cIX6dYWbjMf04PlHAmiYx9IXwSYMegfqEEwYg7t0I1W303QHrnBSGDIe6M4/96DAioivpr/Jsq2NoAkSTlX0phL0Xfr0Ia/ZFCNrQ5m1XULuLg1blDUH7DDTAZ6B5hRJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93d2992-e67d-4222-7eb2-08d7a547bf02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 05:46:26.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z56CqiM/Y6mtpBwfiZH59uLnfsFR+TQuDRxhvHt+5pu5kxTEo7s1J2AJrWQGgyAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2852
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
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 99 ++++++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  2 +
 3 files changed, 110 insertions(+)

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
index 25b90f7..0220651 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -132,6 +132,97 @@ void kfd_procfs_shutdown(void)
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
+	struct kfd_process *proc;
+
+	if (!q || !q->process)
+		return;
+	proc = q->process;
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
@@ -323,6 +414,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
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
@@ -457,6 +553,9 @@ static void kfd_process_wq_release(struct work_struct *work)
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
