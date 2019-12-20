Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411C8C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 04:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE880206EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 04:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rrTZPMrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE880206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D776EBCA;
	Fri, 20 Dec 2019 04:23:07 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760059.outbound.protection.outlook.com [40.107.76.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1BE6EBCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 04:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M09AUySouw7zzZhJ5yQVH+Zd4Kxe1Gqi1jDemPhAlacZgGnAJ5N2wsgrHgkvCFLl2sRS7mCrVm1sfw2tHRUOXaeDtQoRfN9RbAOMMq9Cqy65xXk0WrxmkZK5YXzx1I6AN5PdLD2OB02EOG0pmyYjHX9fO2fNX67JUNN8pOnBa9U9hEBs0ZcEWzx5zvaXjSNeHVBZCUQAUxJWm9bxXa3MMaJS30SBnW8/IIhflUfSTu3sd4PWNL6YdRR++5EjnUguULBK+PsuG8udVbs5lsGC0FHla8SOdhgC1BPoRef+xrR3VBIZQwbQiYPVgso19j1wkHF2IeCg5iBtopU8ktJe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jqrxg2dqUlYXnc09T0BuxglLY5Q83EsMtD0rStFhgk=;
 b=PVfS0H++bETiQpvbskzDTab48M8m3iQcqyjo94A9pLJkNMHErPyQfFrG3yhyNhl/z9GiAuRSDmNKLw6GfQn6RcA3pyH2sxanMoytaDHOEQy4FsNj8MJYqRVYSnRwHpEE0Ld4XwCSni9wuIz0e3rTSy/ip3yrK/zkcsmpn6ztoWn6hPrSaRgo87JQz4AW1w0bvmvY/qLqrbkSjtl7TS2m5+gX0Yr0xXJ9/6yqaJKXb51+VahGNK2vNx//WyXJm/TWCBaud36CcUjOGAfSZ1zNH8HnwBJQ+mCBtisM/R1V19ZOCK7TENmbGNARcXFFNkEADRaLEJi/demy61vSUsU0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jqrxg2dqUlYXnc09T0BuxglLY5Q83EsMtD0rStFhgk=;
 b=rrTZPMrYRPDdgiheWikNxl9VOj3VRMfan2Zv1DEoR5WLDQOUEVOee638Yw5v5NW77lQbzoI8jzUemtA1xXZobLImfItU8La5Nr4ADryQn1gHSs07zPH/b9kZ5IrfFCCMduY3ghMA56blZ67Jswq//xW1mZ5h4O/bRyiL9E4gKHw=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3742.namprd12.prod.outlook.com (10.255.238.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 04:23:04 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2559.012; Fri, 20 Dec 2019
 04:23:04 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Don't touch the hardware in pre_reset
 callback
Thread-Topic: [PATCH 1/1] drm/amdkfd: Don't touch the hardware in pre_reset
 callback
Thread-Index: AQHVttqPyuIQ01tnlE2U6dahQJGyx6fCbIjw
Date: Fri, 20 Dec 2019 04:23:04 +0000
Message-ID: <MN2PR12MB3933A2FD92E97ED743C66ABA842D0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20191220020907.6896-1-Felix.Kuehling@amd.com>
In-Reply-To: <20191220020907.6896-1-Felix.Kuehling@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d031cf08-2f50-48f4-9866-08d785044edc
x-ms-traffictypediagnostic: MN2PR12MB3742:|MN2PR12MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3742013A6C3A02B7C549190F842D0@MN2PR12MB3742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(43544003)(189003)(13464003)(52536014)(8936002)(71200400001)(186003)(55016002)(110136005)(81156014)(4326008)(7696005)(26005)(81166006)(9686003)(8676002)(66446008)(53546011)(33656002)(66556008)(5660300002)(2906002)(66946007)(66476007)(76116006)(64756008)(478600001)(6506007)(30864003)(316002)(86362001)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3742;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tblqbPtPZ7Jp96TKufh3UJ1bL9YTLiKRvW+r0tY/6EOLOECayX7ioiqm5ypqYXFBh1+xHTXY/X5rDdy6B7WtKybyj/FieyO0XW/RQduu3/A+e4XKSwWDCs/bR2FT/xWLP+GwLaRaGDo7Vdp6ea0RLWbP7hIbwE98CZ2EDdNxumg19YqSjFW/u675LbRsO7Eutu//gVUAq1Nyk1NxM3txK8QZruhlvVefTPS7SSnXkrSfGQBJJlm8/biliMVVHT1gDPcQOnLUoWqYy9J+MDZL//FI/mzkXNTmiCbg/oqG1M6yOJKrCcwsAJnpl6uqSvTmFR5Ahxl1jMj7rNXWjv08jlcju1fCDjC1XM2oK8PLhQMpY08sumt0JAS/ex01GDALIISCVLCWdIoNNjxtyZ//fG1TA8H4Qm7IPifah4nvi1cfMC2k+74zqqPJI8yucmFFVTx4I6OgHA3wxXk6RB0SeUEW8bRTejLhTA7Mzy0vKB+0nSL6ut+MoH+iiFVDNEj8srmk3tlgtTReHtPBpgPhGViSJPdF6si9UM0HZshHhI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d031cf08-2f50-48f4-9866-08d785044edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 04:23:04.4108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dP87HDQEMxi7IhqE4ww08IDh9r3DGGVOybnoR+LXOebM0DM8WoQHdOdbI3Qud1/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix

Do you know how I can get a "xxx.patch" file from the email from you ??

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com> 
Sent: Friday, December 20, 2019 10:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 1/1] drm/amdkfd: Don't touch the hardware in pre_reset callback

The intention of the pre_reset callback is to update the driver state to reflect that all user mode queues are preempted and the HIQ is destroyed. However we should not actually preempt any queues or otherwise touch the hardware because it is presumably hanging.
The impending reset will take care of actually stopping all queues.

This should prevent KIQ register access hanging on SRIOV function level reset (FLR). It should also speed up the reset by avoiding unnecessary timeouts from a potentially hanging GPU scheduler.

CC: shaoyunl <shaoyun.liu@amd.com>
CC: Liu Monk <Monk.Liu@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 24 ++++++++++-------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++++++++-------  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  5 ++--  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  8 +++---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  8 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 11 ++++----
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 8 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c6b6901bbda3..796996a0d926 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -486,6 +486,7 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
+static void kfd_suspend(struct kfd_dev *kfd, bool pre_reset);
 static int kfd_resume(struct kfd_dev *kfd);
 
 struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, @@ -728,7 +729,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)  {
 	if (!kfd->init_complete)
 		return 0;
-	kgd2kfd_suspend(kfd);
+	kfd_suspend(kfd, true);
 
 	kfd_signal_reset_event(kfd);
 	return 0;
@@ -767,13 +768,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return;
 
-	/* For first KFD device suspend all the KFD processes */
-	if (atomic_inc_return(&kfd_locked) == 1)
-		kfd_suspend_all_processes();
-
-	kfd->dqm->ops.stop(kfd->dqm);
-
-	kfd_iommu_suspend(kfd);
+	kfd_suspend(kfd, false);
 }
 
 int kgd2kfd_resume(struct kfd_dev *kfd) @@ -795,6 +790,17 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
 	return ret;
 }
 
+static void kfd_suspend(struct kfd_dev *kfd, bool pre_reset) {
+	/* For first KFD device suspend all the KFD processes */
+	if (atomic_inc_return(&kfd_locked) == 1)
+		kfd_suspend_all_processes(pre_reset);
+
+	kfd->dqm->ops.stop(kfd->dqm, pre_reset);
+
+	kfd_iommu_suspend(kfd);
+}
+
 static int kfd_resume(struct kfd_dev *kfd)  {
 	int err = 0;
@@ -877,7 +883,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
 	if (!p)
 		return -ESRCH;
 
-	r = kfd_process_evict_queues(p);
+	r = kfd_process_evict_queues(p, false);
 
 	kfd_unref_process(p);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f7f6df40875e..3a49944164da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -592,7 +592,8 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)  }
 
 static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
-					struct qcm_process_device *qpd)
+					struct qcm_process_device *qpd,
+					bool pre_reset)
 {
 	struct queue *q;
 	struct mqd_manager *mqd_mgr;
@@ -622,6 +623,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 
 		if (WARN_ONCE(!dqm->sched_running, "Evict when stopped\n"))
 			continue;
+		if (pre_reset)
+			continue;
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
 				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
@@ -639,7 +642,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,  }
 
 static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
-				      struct qcm_process_device *qpd)
+				      struct qcm_process_device *qpd,
+				      bool pre_reset)
 {
 	struct queue *q;
 	struct kfd_process_device *pdd;
@@ -664,6 +668,10 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		q->properties.is_active = false;
 		dqm->queue_count--;
 	}
+
+	if (pre_reset)
+		goto out;
+
 	retval = execute_queues_cpsch(dqm,
 				qpd->is_debug ?
 				KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
@@ -944,10 +952,10 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 	return 0;
 }
 
-static int stop_nocpsch(struct device_queue_manager *dqm)
+static int stop_nocpsch(struct device_queue_manager *dqm, bool 
+pre_reset)
 {
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
-		pm_uninit(&dqm->packets);
+		pm_uninit(&dqm->packets, pre_reset);
 	dqm->sched_running = false;
 
 	return 0;
@@ -1107,20 +1115,21 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	return 0;
 fail_allocate_vidmem:
 fail_set_sched_resources:
-	pm_uninit(&dqm->packets);
+	pm_uninit(&dqm->packets, false);
 fail_packet_manager_init:
 	return retval;
 }
 
-static int stop_cpsch(struct device_queue_manager *dqm)
+static int stop_cpsch(struct device_queue_manager *dqm, bool pre_reset)
 {
 	dqm_lock(dqm);
-	unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+	if (!pre_reset)
+		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	dqm->sched_running = false;
 	dqm_unlock(dqm);
 
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
-	pm_uninit(&dqm->packets);
+	pm_uninit(&dqm->packets, pre_reset);
 
 	return 0;
 }
@@ -1891,7 +1900,7 @@ int kfd_process_vm_fault(struct device_queue_manager *dqm,
 		return -EINVAL;
 	pdd = kfd_get_process_device_data(dqm->dev, p);
 	if (pdd)
-		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd, false);
 	kfd_unref_process(p);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index a8c37e6da027..9f82f95f6a92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -103,7 +103,7 @@ struct device_queue_manager_ops {
 
 	int	(*initialize)(struct device_queue_manager *dqm);
 	int	(*start)(struct device_queue_manager *dqm);
-	int	(*stop)(struct device_queue_manager *dqm);
+	int	(*stop)(struct device_queue_manager *dqm, bool pre_reset);
 	void	(*uninitialize)(struct device_queue_manager *dqm);
 	int	(*create_kernel_queue)(struct device_queue_manager *dqm,
 					struct kernel_queue *kq,
@@ -129,7 +129,8 @@ struct device_queue_manager_ops {
 			struct qcm_process_device *qpd);
 
 	int (*evict_process_queues)(struct device_queue_manager *dqm,
-				    struct qcm_process_device *qpd);
+				    struct qcm_process_device *qpd,
+				    bool pre_reset);
 	int (*restore_process_queues)(struct device_queue_manager *dqm,
 				      struct qcm_process_device *qpd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2d56dc534459..dbd2e8e9ae69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -195,9 +195,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,  }
 
 /* Uninitialize a kernel queue and free all its memory usages. */ -static void kq_uninitialize(struct kernel_queue *kq)
+static void kq_uninitialize(struct kernel_queue *kq, bool pre_reset)
 {
-	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ)
+	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && !pre_reset)
 		kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
 					kq->queue->mqd,
 					KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
@@ -337,9 +337,9 @@ struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 	return NULL;
 }
 
-void kernel_queue_uninit(struct kernel_queue *kq)
+void kernel_queue_uninit(struct kernel_queue *kq, bool pre_reset)
 {
-	kq_uninitialize(kq);
+	kq_uninitialize(kq, pre_reset);
 	kfree(kq);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 6cabed06ef5d..7732a3bbebd6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -264,10 +264,10 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	return 0;
 }
 
-void pm_uninit(struct packet_manager *pm)
+void pm_uninit(struct packet_manager *pm, bool pre_reset)
 {
 	mutex_destroy(&pm->lock);
-	kernel_queue_uninit(pm->priv_queue);
+	kernel_queue_uninit(pm->priv_queue, pre_reset);
 }
 
 int pm_send_set_resources(struct packet_manager *pm, diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 087e96838997..9bc4ced4acba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -762,9 +762,9 @@ struct kfd_process *kfd_get_process(const struct task_struct *);  struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid);  struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);  void kfd_unref_process(struct kfd_process *p); -int kfd_process_evict_queues(struct kfd_process *p);
+int kfd_process_evict_queues(struct kfd_process *p, bool pre_reset);
 int kfd_process_restore_queues(struct kfd_process *p); -void kfd_suspend_all_processes(void);
+void kfd_suspend_all_processes(bool pre_reset);
 int kfd_resume_all_processes(void);
 
 int kfd_process_device_init_vm(struct kfd_process_device *pdd, @@ -883,7 +883,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev);  void device_queue_manager_uninit(struct device_queue_manager *dqm);  struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 					enum kfd_queue_type type);
-void kernel_queue_uninit(struct kernel_queue *kq);
+void kernel_queue_uninit(struct kernel_queue *kq, bool pre_reset);
 int kfd_process_vm_fault(struct device_queue_manager *dqm, unsigned int pasid);
 
 /* Process Queue Manager */
@@ -974,7 +974,7 @@ extern const struct packet_manager_funcs kfd_vi_pm_funcs;  extern const struct packet_manager_funcs kfd_v9_pm_funcs;
 
 int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm); -void pm_uninit(struct packet_manager *pm);
+void pm_uninit(struct packet_manager *pm, bool pre_reset);
 int pm_send_set_resources(struct packet_manager *pm,
 				struct scheduling_resources *res);
 int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 536a153ac9a4..7bcadd3a1e3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -948,7 +948,7 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
  * Eviction is reference-counted per process-device. This means multiple
  * evictions from different sources can be nested safely.
  */
-int kfd_process_evict_queues(struct kfd_process *p)
+int kfd_process_evict_queues(struct kfd_process *p, bool pre_reset)
 {
 	struct kfd_process_device *pdd;
 	int r = 0;
@@ -956,7 +956,8 @@ int kfd_process_evict_queues(struct kfd_process *p)
 
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
-							    &pdd->qpd);
+							    &pdd->qpd,
+							    pre_reset);
 		if (r) {
 			pr_err("Failed to evict process queues\n");
 			goto fail;
@@ -1026,7 +1027,7 @@ static void evict_process_worker(struct work_struct *work)
 	flush_delayed_work(&p->restore_work);
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, false);
 	if (!ret) {
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
@@ -1082,7 +1083,7 @@ static void restore_process_worker(struct work_struct *work)
 		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);  }
 
-void kfd_suspend_all_processes(void)
+void kfd_suspend_all_processes(bool pre_reset)
 {
 	struct kfd_process *p;
 	unsigned int temp;
@@ -1092,7 +1093,7 @@ void kfd_suspend_all_processes(void)
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
 
-		if (kfd_process_evict_queues(p))
+		if (kfd_process_evict_queues(p, pre_reset))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index d3eacf72e8db..8fa856e6a03f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -374,7 +374,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		/* destroy kernel queue (DIQ) */
 		dqm = pqn->kq->dev->dqm;
 		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
-		kernel_queue_uninit(pqn->kq);
+		kernel_queue_uninit(pqn->kq, false);
 	}
 
 	if (pqn->q) {
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
