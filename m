Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7010C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 10:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654F72465E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 10:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vc3U0jN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654F72465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED5C6E092;
	Fri, 20 Dec 2019 10:03:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141E86E092
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 10:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ4uBkCFEIyB7ORM61b+DXLh83FP59OjkKEfPnhYLsZd0eGO7J7JlFRSsWSrX6BFEAfT+8FwoNekF4yR0EcJF0Deo5Evr7c9lW7lW6bG479nRj4h73K0pGHIKCw/AHP+P6hXjalvZ/B/5iFyy8w4CxGLnljhGS3Po1DgItAzJGXsgUgX6O1h8emTZzf/qE8fyevySMKQ8RSUeshYvq1utdtK5cMl0+2lvT60YWZwQYQGcMQypFTh4kqW794th6wrvE6Y7tKjoUHtA2Be0M9kvZTnwDUQUJRQbC2xZi87hp3yznzIG4tj8uea7lgobkxVzKaYG5+KafX9S6zGWsSpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ueARAdtC4sPnN62FpdxQgfkpFQU7d8b1Bd+8dF2/9U=;
 b=Mded3Kd3yLtQF8u3f/dWrvSWsiyHa5lPKVcAoY0VG7jPswTS0l6OGtKSPnOTgjsnVKMssjzcQVlvPfMJRYh9RbqAAjkVp8Y6PNPHNo7aZ2d6gwQcn+VpJ1u/2l8lXjQ9953nlppaO3LE+p8nic0qTz6YzGgQ0NFZaene0MafAV6QFNGtTdUd0awjOJwTMtmoQlvtnbxLSgulcQEHLgBWwVGV0NV1WdHFVaDlTvSnOMHsqY4ts7pXER2tT8+4/T3LRw+BJI+AkjF3vIaZjigW3/AI4YXGMg6Q73/xA2+kyzRy5W0WraQa9cyBx17kp3cJtNTAiB8YaK/oE5d/kOwE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ueARAdtC4sPnN62FpdxQgfkpFQU7d8b1Bd+8dF2/9U=;
 b=vc3U0jN9N/V6b4e6+WtvLdBOp6S4oCyL6VTvDgoooKl2aSv80+hDjCftGoQfwPg2TcH6D40dfl9SfMEbxHNpd6eZXeqIhEh9iko35rCQwIRdqDSM2jntntYFh2gaw7tdlIHLJuJuSpwHOe7y8+DMJNF/6dOhJlHGrcq/iFvqdF4=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB4142.namprd12.prod.outlook.com (52.135.51.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 10:03:25 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd%4]) with mapi id 15.20.2538.019; Fri, 20 Dec 2019
 10:03:25 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdkfd: Avoid hanging hardware in stop_cpsch
Thread-Topic: [PATCH 4/4] drm/amdkfd: Avoid hanging hardware in stop_cpsch
Thread-Index: AQHVtw/anP8tSgKMGUC7k0b25g4FwqfCyqQg
Date: Fri, 20 Dec 2019 10:03:24 +0000
Message-ID: <MN2PR12MB2975E492BB6CD4674CE208EB8F2D0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
 <20191220083001.30607-4-Felix.Kuehling@amd.com>
In-Reply-To: <20191220083001.30607-4-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-20T10:03:22Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=46b7df3d-78bd-4d78-afd4-0000d0dc4f1e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-20T10:03:22Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c699972d-222f-42c3-8e1c-00006d59d67f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 298e01e6-4835-4fdc-a858-08d78533da78
x-ms-traffictypediagnostic: MN2PR12MB4142:|MN2PR12MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4142A31BAA4E5F2F75B934768F2D0@MN2PR12MB4142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(13464003)(33656002)(55016002)(52536014)(8676002)(81156014)(110136005)(71200400001)(81166006)(66476007)(66556008)(66446008)(64756008)(76116006)(478600001)(5660300002)(316002)(45080400002)(66946007)(26005)(7696005)(9686003)(86362001)(186003)(2906002)(8936002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4142;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQmNVh7k5cHX1yxSz0ILyePRCIDF5Td4b/E3pmjuLI5Qx0wgV4gBxZL/N4NHgf9JUqPlHt7GCxspOoWoqNNlSxObg4grEw1RXFIfQOv0Wvt6ZkiZR2kLXqYu5xt/TWfazEd5XqPnBMWha/pODj8v4jflVfkVtwoMCT50somM0593XSBxcQgDfc9tGAgH+RtFLa7ARK5pMOPnyYAU8wPJn2Qt+LNf1zzlvrRhpjOqAvZYEUR3FJEj3IaObu9vKMBJhiw9dHvafhDKxhL3ffj5swynKU4bvV2fsZAK28rpcUxhXgwVZA7VKFXg2qXu1o9pQTXocG5t95llsSa6jdvToKUQJrIUKWsDWLIKfMNS4izoteoZ8ZQtrlgcLtqQSqZ0grh6RzM8Hmk31knlS0nvIHlwyWiHq2EOrol50Md2NHbB1wL0CSFzQ/KmOHqzrwoHj16rQWgLZyrOVHFVhAy1/tVXmNiZDZXjl2cs2uFJcgXSnqlyomAFiYezDWFjpvw6rjpS+0PjI9j0SGSfxj3vIb5DYJ8UWcFBYy4OmTRZmUI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298e01e6-4835-4fdc-a858-08d78533da78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 10:03:24.9732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lp0gI6Rony4p9fcZSRhn7KxCtIKY8lPBL6egNX+6dNjRHnU7ZzlhYDen1vrIDHVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series Tested-by:  Emily Deng <Emily.Deng@amd.com> on sriov environment with vege10 about TDR-1, TDR-2 and TDR-3 test cases.

Best wishes
Emily Deng



>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
>Kuehling
>Sent: Friday, December 20, 2019 4:30 PM
>To: amd-gfx@lists.freedesktop.org
>Subject: [PATCH 4/4] drm/amdkfd: Avoid hanging hardware in stop_cpsch
>
>Don't use the HWS if it's known to be hanging. In a reset also don't try to
>destroy the HIQ because that may hang on SRIOV if the KIQ is unresponsive.
>
>Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>---
> .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++++----
> drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c        |  8 ++++----
> drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c      |  4 ++--
> drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  4 ++--
> .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  2 +-
> 5 files changed, 17 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>index a7e9ec1b3ce3..d7eb6ac37f62 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>@@ -946,7 +946,7 @@ static int start_nocpsch(struct device_queue_manager
>*dqm)  static int stop_nocpsch(struct device_queue_manager *dqm)  {
> 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
>-		pm_uninit(&dqm->packets);
>+		pm_uninit(&dqm->packets, false);
> 	dqm->sched_running = false;
>
> 	return 0;
>@@ -1114,20 +1114,24 @@ static int start_cpsch(struct
>device_queue_manager *dqm)
> 	return 0;
> fail_allocate_vidmem:
> fail_set_sched_resources:
>-	pm_uninit(&dqm->packets);
>+	pm_uninit(&dqm->packets, false);
> fail_packet_manager_init:
> 	return retval;
> }
>
> static int stop_cpsch(struct device_queue_manager *dqm)  {
>+	bool hanging;
>+
> 	dqm_lock(dqm);
>-	unmap_queues_cpsch(dqm,
>KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>+	if (!dqm->is_hws_hang)
>+		unmap_queues_cpsch(dqm,
>KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>+	hanging = dqm->is_hws_hang || dqm->is_resetting;
> 	dqm->sched_running = false;
> 	dqm_unlock(dqm);
>
> 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>-	pm_uninit(&dqm->packets);
>+	pm_uninit(&dqm->packets, hanging);
>
> 	return 0;
> }
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>index 2d56dc534459..bae706462f96 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>@@ -195,9 +195,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct
>kfd_dev *dev,  }
>
> /* Uninitialize a kernel queue and free all its memory usages. */ -static void
>kq_uninitialize(struct kernel_queue *kq)
>+static void kq_uninitialize(struct kernel_queue *kq, bool hanging)
> {
>-	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ)
>+	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && !hanging)
> 		kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
> 					kq->queue->mqd,
>
>	KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
>@@ -337,9 +337,9 @@ struct kernel_queue *kernel_queue_init(struct kfd_dev
>*dev,
> 	return NULL;
> }
>
>-void kernel_queue_uninit(struct kernel_queue *kq)
>+void kernel_queue_uninit(struct kernel_queue *kq, bool hanging)
> {
>-	kq_uninitialize(kq);
>+	kq_uninitialize(kq, hanging);
> 	kfree(kq);
> }
>
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>index 6cabed06ef5d..dc406e6dee23 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>@@ -264,10 +264,10 @@ int pm_init(struct packet_manager *pm, struct
>device_queue_manager *dqm)
> 	return 0;
> }
>
>-void pm_uninit(struct packet_manager *pm)
>+void pm_uninit(struct packet_manager *pm, bool hanging)
> {
> 	mutex_destroy(&pm->lock);
>-	kernel_queue_uninit(pm->priv_queue);
>+	kernel_queue_uninit(pm->priv_queue, hanging);
> }
>
> int pm_send_set_resources(struct packet_manager *pm, diff --git
>a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>index 087e96838997..8ac680dc90f1 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>@@ -883,7 +883,7 @@ struct device_queue_manager
>*device_queue_manager_init(struct kfd_dev *dev);  void
>device_queue_manager_uninit(struct device_queue_manager *dqm);  struct
>kernel_queue *kernel_queue_init(struct kfd_dev *dev,
> 					enum kfd_queue_type type);
>-void kernel_queue_uninit(struct kernel_queue *kq);
>+void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
> int kfd_process_vm_fault(struct device_queue_manager *dqm, unsigned int
>pasid);
>
> /* Process Queue Manager */
>@@ -974,7 +974,7 @@ extern const struct packet_manager_funcs
>kfd_vi_pm_funcs;  extern const struct packet_manager_funcs kfd_v9_pm_funcs;
>
> int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
>-void pm_uninit(struct packet_manager *pm);
>+void pm_uninit(struct packet_manager *pm, bool hanging);
> int pm_send_set_resources(struct packet_manager *pm,
> 				struct scheduling_resources *res);
> int pm_send_runlist(struct packet_manager *pm, struct list_head
>*dqm_queues); diff --git
>a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>index d3eacf72e8db..8fa856e6a03f 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>@@ -374,7 +374,7 @@ int pqm_destroy_queue(struct
>process_queue_manager *pqm, unsigned int qid)
> 		/* destroy kernel queue (DIQ) */
> 		dqm = pqn->kq->dev->dqm;
> 		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
>-		kernel_queue_uninit(pqn->kq);
>+		kernel_queue_uninit(pqn->kq, false);
> 	}
>
> 	if (pqn->q) {
>--
>2.24.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C3c77bba4d40d4bc6b
>e8508d78526dd45%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
>637124274794842900&amp;sdata=vHNAs2FTkSpHYZ2TTux%2F66attN4lf5qSiP
>jnlBOM5y0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
