Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279E8C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 23:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB25A20708
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 23:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M8xJ7GMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB25A20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7EB6E0D4;
	Thu, 30 Jan 2020 23:23:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34D06E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 23:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlDY+izis0LXlwPysCGd/4QWhQDYvovQgrVzQ5M14Z9gjx4clV5xNMyfJ9xYnxgaeYenUXoHjxzgT01PlCOWZ7G35Xy7FrvkdO4ydJww0NJD3mHasTEKi8XL19VkztGoqzzfncrkjP2cJgMCttNhxrZMvoMjA9msKhXsbVJjb6BBIVM3oWmV46NzSxWz3mcCmuHCWxAv+h0DCt9r2OXn2MVOsTxTSi5tEFHleCZWB6asFTYGlD4B3OorcNNEFY19VTtlqLCo9Xux+RmT8Y+fNCJsOuORK0wS0ub+n226BLDpkFImxr1dG0vdi5jR9Xc0S56e3bVonZEkoF4/C32eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTQToKEh+M74li9m0OKFvK1ne7M7gSyYuwuEv8WZ7g8=;
 b=hOq32VvMrf1NNBZs2zWTgY+KSXPG0vUFb9cvoyl1NdiOdNtRjS+K0VG+qHAtUS1VErCsybHwBeerbt64xaTTQm5j7FkHRGxVMURRHS4g0wYmViXswE0zkmbEk9s17XykifIN+8vAI1ojj5Ipr/kAnht3CS2SPbc5qfpvBXm3rwAUdW3Ec7eHDwKgQPVPDsiGM74np1rKe73yjOVhNPwwRECGtAQ92GYs6SqpqdovxQb+iuOWDMyBjhZMqvaDze58xpPm7LZ7+LtnaKwbTxXZudlEW+Oy+IWqt7NlHGznsHlFLqtPqea2bwOxH3f0IViX0NGWObbw+By5knBqGNGEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTQToKEh+M74li9m0OKFvK1ne7M7gSyYuwuEv8WZ7g8=;
 b=M8xJ7GMzWPM2ucvZ6SNXh8vL+oyjH0MfnmmmmeVn2mJzGm8rVx3Lk9/i+dd4xrulkhDOSEMyNai8hDk4LKZtV5JEVMMXDjNC9huKxMZQLGrPlTTGfSLgLZq4r6b4pD8l+hxW8jzf8jJgfZhxWX5gfRG+MHezdwG9poqzB3zERoc=
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (10.174.109.137) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Thu, 30 Jan 2020 23:22:58 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::bd97:2661:434a:65fe]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::bd97:2661:434a:65fe%4]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 23:22:58 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Add queue information to sysfs
Thread-Topic: [PATCH] drm/amdkfd: Add queue information to sysfs
Thread-Index: AQHV1zC934Xl9a1Nd0eDb6otCdxBIKgD1KfQ
Date: Thu, 30 Jan 2020 23:22:58 +0000
Message-ID: <DM5PR1201MB0187BC565C484FC27AB693D88C040@DM5PR1201MB0187.namprd12.prod.outlook.com>
References: <1580363174-31854-1-git-send-email-Amber.Lin@amd.com>
In-Reply-To: <1580363174-31854-1-git-send-email-Amber.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-30T23:22:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=63076ec0-cf5e-423b-a9e9-000085bb131b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-30T23:22:57Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a7409896-758f-47ad-9461-00009a0d27b6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7cb9e4a-9943-41ac-8a1c-08d7a5db57be
x-ms-traffictypediagnostic: DM5PR1201MB2472:|DM5PR1201MB2472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB24729419842C44CA506289998C040@DM5PR1201MB2472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(76116006)(66476007)(4326008)(66946007)(66556008)(45080400002)(966005)(7696005)(8936002)(316002)(186003)(66446008)(81156014)(81166006)(8676002)(110136005)(64756008)(33656002)(26005)(53546011)(6506007)(5660300002)(71200400001)(478600001)(9686003)(55016002)(2906002)(52536014)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2472;
 H:DM5PR1201MB0187.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8zufDjsgh8STPBcN8ytlrUXjZAa3s1cUZv5M7kV4s64FEyVX3Z06+7eys1lPzTk1U9AIqZnODjCBkTrWCUvn+H2CqV22ixbz5N7QH9PNMbPoHMff301qcjRPnF2dnY7dFZ/n6s6pHvTm/OMhQ528n87AkKvTxExx8homrRgxr5xoUZi+08GUpmqTrXu+7oMMsk5TRMhWGoSEMO80gvNlufR6ahC6r/JXG0CJeBUp8q1VwLhPmCBI5/IbddWh7gZd0G8Kd00tGwJRmoizyIU4a9lknxJlg13BtfmV87wo/QMgAQf9rDckJ0axaF0FV1/WTWeoNh9Z2B1zXyp0oR8RGQQv5l8TpBegfxC/cG52f4QgpsLVYI83wMlPJ+wkL3uZOV6ETT1z7OEZ8AUxKvfBK3pvKL8YXIV+tPIoNW4cgHIJrkkWTOiWJanAQF5dJEPD121BPoTzCAv/6XUbxRb3s7qm5Ui2t5vr6T3sJ3EcGGQeDASkWXIog4iHE/JAQzv0EOEOtIMwT2tONYhbkC5jw==
x-ms-exchange-antispam-messagedata: 07vlykFkfHYxqUs0SPw0CKuXwwFr25u/EA7sJPdGshJCcYRFi2q/71aaIDxZpMPY89Vmupn9DZRZFa17qTY8fX3A/udzWYDn9sDrHvk4c01NJltFO/RCdWrjeF2kmzNdo9dcPVYwqXpEyQegvp2Jqg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cb9e4a-9943-41ac-8a1c-08d7a5db57be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 23:22:58.3710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjGN3/MfoGBPamAE2UAII04WekBO8Utl3nG62mkEAaWYFF4rtf8EdQ5U9OYjSOeHfEK/DqKnekENh03cjzpsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

One minor comment.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Amber Lin
Sent: Thursday, January 30, 2020 12:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Add queue information to sysfs

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

[HK] : proc is not used

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Charish.kasiviswanathan%40amd.com%7C496ec14c22b84457329608d7a547c2ed%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637159600420395549&amp;sdata=h6eKxRwq4kPv7z7qHuiPvhb7UoR0QKlRWK8OAdBEyqk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
