Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDFEC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB09227BF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N9kf4Gkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB09227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF87489C0D;
	Fri, 20 Dec 2019 08:30:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B18B89C0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 08:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTNYX4SljWzeuJBCJB9OWjS1nbBhCh5kOEAxb9Dl3TU6QtSJ1VW7lPuep3MqenG2PB1NGAomSodJpMCCrVR6dN2EQxgRV4D0GM3Uf6NcjAcUZUK8TEyq15p4PZKjJn+ZFfPGHsNnh/tLrk8wI/DQmd9hv2M2pSciUIB+LTY5I6/b7CSNLP4bU1ymFAN4KCcnAhBkEiuLmLaNM6tS3xgpQctMHGwPOM2/fUnk+sFEmf9Iv/aJ2KFhBOi66neXsMnqnAp2c4mvOe9jRGDwGT9lWSNFTHFGhFg3vudBFWahO2E01Cy1sngOpCcg0X4GvlvNUD7yFFXTzEdWTyQdCuI4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuwUW5kua1MrPG/SeocutNnKPNqmSFy5bL3eYrMm1jM=;
 b=i1h8cxxpMnaBhO2+5sAtSGtcVGII8DYLEJXCpYZTmNNHA+quqVGzKvDOKZT0MnkIpe3aN/Q46njcydR0japzv926Q/D9R6xHpViaaUav2CEroI6AZD/vilHbdUJYTpMIVL70R1wySL+uNEm8qma9i8Hva78zfu/eL4scOazMFBUXB9oZ1qw5BT9jrkzuG4pF/5nwWXlFG8gxAumCAHaUJicPd8zNhCLU5iBfiyfCKW3eAX5tjZ7W+drV13xVdyopoiGuZEZ5cYhuxJxXuyqO8XxBuCfdiM9a/RW9Nva6BuvWlZKeRvBPQ/kkMFqi2ZDeTrEXnap+LstMGBXybzoDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuwUW5kua1MrPG/SeocutNnKPNqmSFy5bL3eYrMm1jM=;
 b=N9kf4GkdUJcACRD2KcJJdDRI2R3wyRoiTgbgyHJhts2mpCajuHwd6WOr21jBIlsr4XR4l7iiRVd5tiWZMT2sY+xJtAJHBoRv9fB1OuzBv5+adWLQCNygQtNEiih3mIVoJYiP7KnnTlrfwZtSc5JF/jdrfhD2FdhRDYQtHqDF9SU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3215.namprd12.prod.outlook.com (20.179.82.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 08:30:22 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 08:30:22 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdkfd: Avoid hanging hardware in stop_cpsch
Date: Fri, 20 Dec 2019 03:30:01 -0500
Message-Id: <20191220083001.30607-4-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220083001.30607-1-Felix.Kuehling@amd.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 08:30:21 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4db117bf-5f36-481b-6f2c-08d78526daa0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32155B5A6C494E47738A46F9922D0@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(1076003)(52116002)(6666004)(5660300002)(36756003)(186003)(16526019)(2906002)(7696005)(6486002)(316002)(66556008)(66476007)(478600001)(6916009)(956004)(26005)(66946007)(2616005)(81156014)(8676002)(86362001)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3215;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxVe0y2KHfNCqiWHbpZKdvVoUJFvCHPRLPNMAmu4FKm+LqqsFB5+++7hR49RsEEU4t2PyUF8zKuP19UcI0Gk1p9Vau5nFbywSYTgiUvccP7zXO0heAVkmZpxhGIzzIK+7/Q7uv8E5aJiE2GxwJ6Urxg1nuFJ4q3uq0NMfIQDGcaUttv9FseQ3mI0/45w1C5Ar+0OBG9FhjMCQ2P9MBg9jqAdv9bfmTWHWhpNV3L9JaRrJJ6CfwHTbqaYOJ+EoHLkWB/MKFzq2SkpJ9dzDTNx2nDDcq072A79dCzSkGP7AGTu1CPt1BtUKiJk6NwuMYSgS9DFg0qcu8t1PsHtNpjeNKP4bWfODvabLUiyw5/eGNNd3jO2MW8YUSu7BlqoeHPi34COM5B0xpQSWmLYw5DYA2igHXTfRbi8kE8/6afC0RPxviUnWgVggi5xmq69AqB3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db117bf-5f36-481b-6f2c-08d78526daa0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 08:30:22.1592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gk9xpG+Y276TMKO+TPjHX40FJG8khN+DQON8b0dyz+4gEFsHd07DmUEQiyp13jO9u2Pbr23GO1gHEv0G2amBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
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

Don't use the HWS if it's known to be hanging. In a reset also
don't try to destroy the HIQ because that may hang on SRIOV if the
KIQ is unresponsive.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c        |  8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c      |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  2 +-
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a7e9ec1b3ce3..d7eb6ac37f62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -946,7 +946,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 static int stop_nocpsch(struct device_queue_manager *dqm)
 {
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
-		pm_uninit(&dqm->packets);
+		pm_uninit(&dqm->packets, false);
 	dqm->sched_running = false;
 
 	return 0;
@@ -1114,20 +1114,24 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	return 0;
 fail_allocate_vidmem:
 fail_set_sched_resources:
-	pm_uninit(&dqm->packets);
+	pm_uninit(&dqm->packets, false);
 fail_packet_manager_init:
 	return retval;
 }
 
 static int stop_cpsch(struct device_queue_manager *dqm)
 {
+	bool hanging;
+
 	dqm_lock(dqm);
-	unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+	if (!dqm->is_hws_hang)
+		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+	hanging = dqm->is_hws_hang || dqm->is_resetting;
 	dqm->sched_running = false;
 	dqm_unlock(dqm);
 
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
-	pm_uninit(&dqm->packets);
+	pm_uninit(&dqm->packets, hanging);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2d56dc534459..bae706462f96 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -195,9 +195,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
 }
 
 /* Uninitialize a kernel queue and free all its memory usages. */
-static void kq_uninitialize(struct kernel_queue *kq)
+static void kq_uninitialize(struct kernel_queue *kq, bool hanging)
 {
-	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ)
+	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && !hanging)
 		kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
 					kq->queue->mqd,
 					KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
@@ -337,9 +337,9 @@ struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 	return NULL;
 }
 
-void kernel_queue_uninit(struct kernel_queue *kq)
+void kernel_queue_uninit(struct kernel_queue *kq, bool hanging)
 {
-	kq_uninitialize(kq);
+	kq_uninitialize(kq, hanging);
 	kfree(kq);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 6cabed06ef5d..dc406e6dee23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -264,10 +264,10 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	return 0;
 }
 
-void pm_uninit(struct packet_manager *pm)
+void pm_uninit(struct packet_manager *pm, bool hanging)
 {
 	mutex_destroy(&pm->lock);
-	kernel_queue_uninit(pm->priv_queue);
+	kernel_queue_uninit(pm->priv_queue, hanging);
 }
 
 int pm_send_set_resources(struct packet_manager *pm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 087e96838997..8ac680dc90f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -883,7 +883,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev);
 void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 					enum kfd_queue_type type);
-void kernel_queue_uninit(struct kernel_queue *kq);
+void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
 int kfd_process_vm_fault(struct device_queue_manager *dqm, unsigned int pasid);
 
 /* Process Queue Manager */
@@ -974,7 +974,7 @@ extern const struct packet_manager_funcs kfd_vi_pm_funcs;
 extern const struct packet_manager_funcs kfd_v9_pm_funcs;
 
 int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
-void pm_uninit(struct packet_manager *pm);
+void pm_uninit(struct packet_manager *pm, bool hanging);
 int pm_send_set_resources(struct packet_manager *pm,
 				struct scheduling_resources *res);
 int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
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
