Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6CBC35247
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 17:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141692080C
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M1ms2NE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141692080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6566ECA8;
	Mon,  3 Feb 2020 17:37:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171006ECA8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 17:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PW468BwcDvcrwQo1PlHoucURdGDZiCS22tVbf17G0cJ5w0MkkEssssCMCr3d0SWGiAGDKLFW6NDRpRkk6gn1fuGhVIRjS0TO6q0gV9GQoBy3JBQIC2e/gb86fKqk8/nezW4ymdOtsAVh/mKdshKj3gGWSpMJfrjcxjeRcxuKrzLmBhl114vgnpbS4kTtvRg6BLglw7TwCrvsyHe+k6qTyZwQaORk8QNHcfAl6Z5NnwSlCwDqsVyhgkcrvZ//d5HnF1h8S+Xnq39nITGX6hT7mKjRlKgfPkv9qunIVfFsKYrRey+uMCPLsQCsTpHqJmI8ET3tvHUkoFe/UN8H2Wc9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W5IoAmdx78SGQrjL8se4UF22Q88eOKwHN9vc8IpH2w=;
 b=kGYctWi4mYUGv6mZWTcNIm+LCcHVQjZCuYHrZdViLpW541QxbScJQhjylLztv2VFI8bxT0fJwehUmgkqEJhdc7U/TdpIMnOgKBO1ZeJK+E1ZPDGO1MT4OWCJwwBKWaM7czwrIWDSGqrHHgB1y0uO6gLTn591q4JcVwNSaoA6K/eOxoaOR9QsCRDT8gOGxnCoqwSmTq/5wX7PL7t8adsxblksTnDRE8Q40nJRFyg7Aw5EGKjh51/z0u1C1rcKXVzIhMdWKs8y4kexQzUBzEqPJKz/+/NJinA3EYKw+Ie2NAI3Xxhwzvkxe3cRFXqii9eq+X0e558opx2WrI+xMQ90Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W5IoAmdx78SGQrjL8se4UF22Q88eOKwHN9vc8IpH2w=;
 b=M1ms2NE1gQCtI7Y7e+Is/5nJMerLIet8tW9LJKLr/MIrQi0PLxOGgXSDM8sqEp6OGeSgcvwWQJqNse3jJNYT3fqp1YiqWcdJYEpzYE6O4l768kY7sX4EE5qWOfNmdgoQ3aU8VoH+pg/sIZKB9h6hIH2u6k6lQ1PsqVbAfiaSA48=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (20.178.211.139) by
 BN8PR12MB3521.namprd12.prod.outlook.com (20.179.65.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Mon, 3 Feb 2020 17:37:51 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::6d92:5a9:ed80:1e42]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::6d92:5a9:ed80:1e42%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 17:37:51 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdkfd: Add queue information to sysfs
Date: Mon,  3 Feb 2020 12:37:28 -0500
Message-Id: <1580751448-3759-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To BN8PR12MB3041.namprd12.prod.outlook.com
 (2603:10b6:408:46::11)
MIME-Version: 1.0
Received: from alin.amd.com (165.204.55.251) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.28 via Frontend
 Transport; Mon, 3 Feb 2020 17:37:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adf72772-cc56-4031-71cf-08d7a8cfcab6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3521:|BN8PR12MB3521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB352149C6EDB151D72C326888E1000@BN8PR12MB3521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(2616005)(956004)(86362001)(2906002)(8936002)(8676002)(316002)(26005)(6666004)(478600001)(66556008)(66476007)(16526019)(186003)(66946007)(81166006)(81156014)(4326008)(52116002)(5660300002)(7696005)(6486002)(36756003)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3521;
 H:BN8PR12MB3041.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0rDTtaxQq7jGfwAxPtBuzIBa49iBKFV/AfGdYD0mvoGSX4uibCviMdu65VpYXGEEcyFg1/boH88Wi1IaSmxBT5zXR30o5ljy8cuqEj+tcxuqrG9dCdUVGRw0gxXrnBpqS0M9J+3aFgSRp1bUgoB7HdsIfrIZaZr9AdbiaCgv11IQotb7YqVUOBz9g/PKbDVVZIIusT33k/9ZNXYQV8P8x3HrySpueolzhpZ2JzkPTk3/0RcgN5pWmIpWtgXD4m9c5AicObOqdxoYdBzTqQuQvmofvHVed/vFB9uMAzYCan9MhlR4Ziw4oCLwlSt28RU2uYoceWMBuFiMZ1IpnKDtuf6u/rfKiABUgVXe8SqyZp+z7TTdvL3iN/4niOvw1Yn/Wxs0Fa0P3eC9MiboMvMehO1AKrHAN56c8lnVCapUZSqOXqqX114RyT3S+rD1j4l
X-MS-Exchange-AntiSpam-MessageData: /unLNKA+EzPkBvN/d08y5QwWB5e5ADYUpnTlbdXWB5AfLGjSefkZ7h7XDxMrIgDmPqbE9wfTX2n+PEC1OjuaoK+Y68nzovkANGT8sQcXwB5UAJVFkqET1AsIlHzM9ITzoyX5IIRKAjU1WJP0PiXTnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf72772-cc56-4031-71cf-08d7a8cfcab6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 17:37:51.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKZJpNeusHrj8IoXzUdPYae/wXtcDtQA8aIPmwsJU5qHbl/pD1pGK8xzF48iPKww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3521
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
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  7 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 90 ++++++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  2 +
 3 files changed, 99 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c0b0def..f805f55 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -41,6 +41,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_device.h>
 #include <kgd_kfd_interface.h>
+#include <linux/swap.h>
 
 #include "amd_shared.h"
 
@@ -503,6 +504,9 @@ struct queue {
 	struct kfd_process	*process;
 	struct kfd_dev		*device;
 	void *gws;
+
+	/* procfs */
+	struct kobject kobj;
 };
 
 /*
@@ -730,6 +734,7 @@ struct kfd_process {
 
 	/* Kobj for our procfs */
 	struct kobject *kobj;
+	struct kobject *kobj_queues;
 	struct attribute attr_pasid;
 };
 
@@ -836,6 +841,8 @@ extern struct device *kfd_device;
 /* KFD's procfs */
 void kfd_procfs_init(void);
 void kfd_procfs_shutdown(void);
+int kfd_procfs_add_queue(struct queue *q);
+void kfd_procfs_del_queue(struct queue *q);
 
 /* Topology */
 int kfd_topology_init(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 25b90f7..98dcbb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -132,6 +132,88 @@ void kfd_procfs_shutdown(void)
 	}
 }
 
+static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
+				     struct attribute *attr, char *buffer)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	if (!strcmp(attr->name, "size"))
+		return snprintf(buffer, PAGE_SIZE, "%llu",
+				q->properties.queue_size);
+	else if (!strcmp(attr->name, "type"))
+		return snprintf(buffer, PAGE_SIZE, "%d", q->properties.type);
+	else if (!strcmp(attr->name, "gpuid"))
+		return snprintf(buffer, PAGE_SIZE, "%u", q->device->id);
+	else
+		pr_err("Invalid attribute");
+
+	return 0;
+}
+
+static struct attribute attr_queue_size = {
+	.name = "size",
+	.mode = KFD_SYSFS_FILE_MODE
+};
+
+static struct attribute attr_queue_type = {
+	.name = "type",
+	.mode = KFD_SYSFS_FILE_MODE
+};
+
+static struct attribute attr_queue_gpuid = {
+	.name = "gpuid",
+	.mode = KFD_SYSFS_FILE_MODE
+};
+
+static struct attribute *procfs_queue_attrs[] = {
+	&attr_queue_size,
+	&attr_queue_type,
+	&attr_queue_gpuid,
+	NULL
+};
+
+static const struct sysfs_ops procfs_queue_ops = {
+	.show = kfd_procfs_queue_show,
+};
+
+static struct kobj_type procfs_queue_type = {
+	.sysfs_ops = &procfs_queue_ops,
+	.default_attrs = procfs_queue_attrs,
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
+	/* Create proc/<pid>/queues/<queue id> folder */
+	if (!proc->kobj_queues)
+		return -EFAULT;
+	ret = kobject_init_and_add(&q->kobj, &procfs_queue_type,
+			proc->kobj_queues, "%u", q->properties.queue_id);
+	if (ret < 0) {
+		pr_warn("Creating proc/<pid>/queues/%u failed",
+			q->properties.queue_id);
+		kobject_put(&q->kobj);
+		return ret;
+	}
+
+	return 0;
+}
+
+void kfd_procfs_del_queue(struct queue *q)
+{
+	if (!q)
+		return;
+
+	kobject_del(&q->kobj);
+	kobject_put(&q->kobj);
+}
+
 int kfd_process_create_wq(void)
 {
 	if (!kfd_process_wq)
@@ -323,6 +405,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
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
@@ -457,6 +544,9 @@ static void kfd_process_wq_release(struct work_struct *work)
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
