Return-Path: <SRS0=NM/7=3Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356BEC35247
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 21:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07F32082E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 21:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sZLIWUKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07F32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9643C6E8F6;
	Tue,  4 Feb 2020 21:13:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3126E8F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2020 21:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE9f04pqbCdZKQZTjPCcJyMlE0OjpU9uWZhBdtLbEJJnfFgdviHRLHqZXGqWrU95lwf2C0DEF6mmbjxnw2eg9yzKOIgM5XHM0SRJs0LQ7Tep7MJ9kElejOZVgJMDH+MdLlt9vDtT0pnpHt1ySQP9rDX+7iDJf36E05uVxa716O4URklWwM6HhrKuP42RSeCWs0ZOz5ExAfbWI8cZpyTX55M6YYqon9KbQP3C2FzB+eTkZufiqnewsVDXR5LQ/Zwl1zvNA83PhBzMj/SVRh4C7X7agUwa9nS9pB9b3tZCTbGJD9lvOJdv16b26o9PrwA0aXQIIwJ3azEGAHfPQr1Veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDenn1/FtGaqiSEKvF4xOYS7VbFoW9xxpHq4wtmsmRk=;
 b=EUz/HaCc7VQMzQaHcKfn92/enYlSJu/1/NjjDvgY9c4/VMRiMx0yxOwgtmQApHFEsjP5dYe1hrH1N5nWPi0mk3f6bv3xmDgOLpg35vpB6x3BiY59pDhrYKUNBa3hyVAxixNUvra8aU9USqACkVrCfqz9Gb95i7XBDiyuRvgplvGyniahVimIpnQe+2ve/wme6D+gXC3d4uPv0IhhgL9jPtcCbnLmcM7ci3NE5uMaXYs6pAEI8htrw77zBQBHtEPykY98/VWRw/v2PptYnN/Yv1BQ3AOMHEp2b/5tQ2oMGlkCI7geBuvzPR/WoRswS2nhzKNxGtW3ISJem3kMNV8Q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDenn1/FtGaqiSEKvF4xOYS7VbFoW9xxpHq4wtmsmRk=;
 b=sZLIWUKx7pKd7ggg5BlntkmGWZMzfXOiztLuL7UDMHww0Dp1qeTthAb5tF5MDgN9hY7Mfbo3ahxCCE1/RnjmngnlylADKqmHqBcKmhEcqMgDDtzOYiV83/OE0PYAqYY1tcscRDdrbkd7Vt1qBnXhBWlF+Y1wC6oVSHMvWso1ieU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0172.namprd12.prod.outlook.com (10.174.104.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 21:13:48 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 21:13:48 +0000
Subject: Re: [PATCH v3] drm/amdkfd: Add queue information to sysfs
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <1580751448-3759-1-git-send-email-Amber.Lin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <0492fc83-2d69-ab3f-ab4d-18a7bd9d4ac4@amd.com>
Date: Tue, 4 Feb 2020 16:13:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1580751448-3759-1-git-send-email-Amber.Lin@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::34) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30 via Frontend Transport; Tue, 4 Feb 2020 21:13:47 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9297ce38-b793-40ca-41ec-08d7a9b7202b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0172:|DM5PR1201MB0172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01729D2E4A7D4189016C04F592030@DM5PR1201MB0172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(86362001)(31696002)(26005)(8936002)(66476007)(81156014)(8676002)(16576012)(16526019)(186003)(81166006)(316002)(53546011)(478600001)(2906002)(5660300002)(66946007)(956004)(2616005)(6486002)(66556008)(52116002)(36916002)(36756003)(31686004)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0172;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7al4WK7cWAhsobD37aaNWMPvURP2bMK3XHznDTcQ24IsDEp244GVM/mXm2aT0GOkv+S8HO9ot7lrcn9gihDF/KFWzDVt1N9bI5IbtEVY6WdDna5yE5wkCe92oh/6V1E1Ut0Mz/o4Ax36l5glLvbKV7uwVQQ1lSe2hLrYE6KgDrKWy7YIuhaG0uMlJF3JJBgPr0AfH4IKx0qcvATcA3GCdg1uvQ9njm7Rm66swXPBxh64/GHekF4VfbgwPLNR0WTIveSZrM5fN91u4IOMMy8WwX9+H2nLhop7za6GrAi2WOocaIKPSkLHGxkbDQN4GJ4jhwuboXAvXxvXuJoHE6tiUhpUFGsqsZ4X3bRPQl7+T1bNHO4b5z4OcV4pdjTe/aRNXrGo0IeQGudWhHMYiU5Vv37cFDjShzRCBtGsTzWaQFJi709sloXrtj0ILFUstYiy
X-MS-Exchange-AntiSpam-MessageData: ViF9Q1ipVnxTPn7zDtXR3UNyOrMakFeXRoustMhYkWnqBgz0UBTjoszUPKzCha4rK0tyEbcnBxreMxAfom1xnc8mJ/stPmvcmv87H2RiQZ8q1RcuBRU/VYQz+6bmJMh5gWe+MRdT/VPRmeBEbL5MsA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9297ce38-b793-40ca-41ec-08d7a9b7202b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 21:13:48.3118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkNe5IUsMvCyU/+V74QmxT/VoJMk+4KdhOPZ6rHipBuGB/6rpe+cbA5BzT8teNYbypHsgn/myP1Ia5Jg9YTJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0172
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-03 12:37 p.m., Amber Lin wrote:
> Provide compute queues information in sysfs under /sys/class/kfd/kfd/proc.
> The format is /sys/class/kfd/kfd/proc/<pid>/queues/<queue id>/XX where
> XX are size, type, and gpuid three files to represent queue size, queue
> type, and the GPU this queue uses. <queue id> folder and files underneath
> are generated when a queue is created. They are removed when the queue is
> destroyed.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  7 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 90 ++++++++++++++++++++++
>   .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  2 +
>   3 files changed, 99 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index c0b0def..f805f55 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -41,6 +41,7 @@
>   #include <drm/drm_drv.h>
>   #include <drm/drm_device.h>
>   #include <kgd_kfd_interface.h>
> +#include <linux/swap.h>
>   
>   #include "amd_shared.h"
>   
> @@ -503,6 +504,9 @@ struct queue {
>   	struct kfd_process	*process;
>   	struct kfd_dev		*device;
>   	void *gws;
> +
> +	/* procfs */
> +	struct kobject kobj;
>   };
>   
>   /*
> @@ -730,6 +734,7 @@ struct kfd_process {
>   
>   	/* Kobj for our procfs */
>   	struct kobject *kobj;
> +	struct kobject *kobj_queues;
>   	struct attribute attr_pasid;
>   };
>   
> @@ -836,6 +841,8 @@ extern struct device *kfd_device;
>   /* KFD's procfs */
>   void kfd_procfs_init(void);
>   void kfd_procfs_shutdown(void);
> +int kfd_procfs_add_queue(struct queue *q);
> +void kfd_procfs_del_queue(struct queue *q);
>   
>   /* Topology */
>   int kfd_topology_init(void);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 25b90f7..98dcbb9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -132,6 +132,88 @@ void kfd_procfs_shutdown(void)
>   	}
>   }
>   
> +static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
> +				     struct attribute *attr, char *buffer)
> +{
> +	struct queue *q = container_of(kobj, struct queue, kobj);
> +
> +	if (!strcmp(attr->name, "size"))
> +		return snprintf(buffer, PAGE_SIZE, "%llu",
> +				q->properties.queue_size);
> +	else if (!strcmp(attr->name, "type"))
> +		return snprintf(buffer, PAGE_SIZE, "%d", q->properties.type);
> +	else if (!strcmp(attr->name, "gpuid"))
> +		return snprintf(buffer, PAGE_SIZE, "%u", q->device->id);
> +	else
> +		pr_err("Invalid attribute");
> +
> +	return 0;
> +}
> +
> +static struct attribute attr_queue_size = {
> +	.name = "size",
> +	.mode = KFD_SYSFS_FILE_MODE
> +};
> +
> +static struct attribute attr_queue_type = {
> +	.name = "type",
> +	.mode = KFD_SYSFS_FILE_MODE
> +};
> +
> +static struct attribute attr_queue_gpuid = {
> +	.name = "gpuid",
> +	.mode = KFD_SYSFS_FILE_MODE
> +};
> +
> +static struct attribute *procfs_queue_attrs[] = {
> +	&attr_queue_size,
> +	&attr_queue_type,
> +	&attr_queue_gpuid,
> +	NULL
> +};
> +
> +static const struct sysfs_ops procfs_queue_ops = {
> +	.show = kfd_procfs_queue_show,
> +};
> +
> +static struct kobj_type procfs_queue_type = {
> +	.sysfs_ops = &procfs_queue_ops,
> +	.default_attrs = procfs_queue_attrs,
> +};
> +
> +int kfd_procfs_add_queue(struct queue *q)
> +{
> +	struct kfd_process *proc;
> +	int ret;
> +
> +	if (!q || !q->process)
> +		return -EINVAL;
> +	proc = q->process;
> +
> +	/* Create proc/<pid>/queues/<queue id> folder */
> +	if (!proc->kobj_queues)
> +		return -EFAULT;
> +	ret = kobject_init_and_add(&q->kobj, &procfs_queue_type,
> +			proc->kobj_queues, "%u", q->properties.queue_id);
> +	if (ret < 0) {
> +		pr_warn("Creating proc/<pid>/queues/%u failed",
> +			q->properties.queue_id);
> +		kobject_put(&q->kobj);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void kfd_procfs_del_queue(struct queue *q)
> +{
> +	if (!q)
> +		return;
> +
> +	kobject_del(&q->kobj);
> +	kobject_put(&q->kobj);
> +}
> +
>   int kfd_process_create_wq(void)
>   {
>   	if (!kfd_process_wq)
> @@ -323,6 +405,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
>   		if (ret)
>   			pr_warn("Creating pasid for pid %d failed",
>   					(int)process->lead_thread->pid);
> +
> +		process->kobj_queues = kobject_create_and_add("queues",
> +							process->kobj);
> +		if (!process->kobj_queues)
> +			pr_warn("Creating KFD proc/queues folder failed");
>   	}
>   out:
>   	if (!IS_ERR(process))
> @@ -457,6 +544,9 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	/* Remove the procfs files */
>   	if (p->kobj) {
>   		sysfs_remove_file(p->kobj, &p->attr_pasid);
> +		kobject_del(p->kobj_queues);
> +		kobject_put(p->kobj_queues);
> +		p->kobj_queues = NULL;
>   		kobject_del(p->kobj);
>   		kobject_put(p->kobj);
>   		p->kobj = NULL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 8fa856e..cb1ca11 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -322,6 +322,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   
>   	if (q) {
>   		pr_debug("PQM done creating queue\n");
> +		kfd_procfs_add_queue(q);
>   		print_queue_properties(&q->properties);
>   	}
>   
> @@ -378,6 +379,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   	}
>   
>   	if (pqn->q) {
> +		kfd_procfs_del_queue(pqn->q);
>   		dqm = pqn->q->device->dqm;
>   		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>   		if (retval) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
