Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB45C35254
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBD820715
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dJPA5gZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBD820715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123BA6ED16;
	Mon, 10 Feb 2020 18:48:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B356ED15
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 18:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEKoBpYzRAY0e7dOeckNYMiSUWzGbVQN0BLq/yIs4V0+hJnN+sFqcp6If4jzkATeeDav4S+eFALCNbwvWut1mDr0wMMrEkCKQVF05CLx1ayaN9MzSP5BsfHLBpMOtgdq+S4d+m7aBC+Bwbfvmy/rxE7KZHp7VX5fFklTulMgKcTp/iOkl0vQ27E3exiS+x1K88qpKWw7Y5f9k9Nzvhx80U8l0Dv8A1lkllIbPv0s541NgNnCH2rmjnhB/i5kYMbQgxdctfnJjPMdWwcCj8B+NVpV2k4DfC14YKAHRpETnHSwHdRh0KU+FZEA1xj1a2giHqWMQWyddn5XIRhzX24glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dpm2XT7bRiZNGp9zD0/ozZpK6pDHXfgzzKkpI4xglnA=;
 b=dPBqa0VYp0gJCrp9FkNFvhx+87eF/s2fcBQKb6ETzCRgEHR8rVVsLmFQ85oFC4M0ytxltOtPhs+miX5Vb+I/bVCgjh7F/MhqtKEHmYZ/iLiBxLJJ6qvaU9BnmTRFYSN6m+lgSo0O7Q66IF9iNzyenjWCY2nptZtVOUy6ADb9nSGRjZDBGHW6ZSNuB0XpDKKxBfjX2dbwsSbRPLAyPG+2oJRFEAT0WD0H3a7vwd3dcQUh50md2SU5LaWNoUUKxn9A8xSxNMKwZo5dh2jQOnaebyZWFarRPzJZH6JuTdYdHfYoYSeO18bGg1m/JsxN0SmQdGq+Zotc4tubH8Ds1bKVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dpm2XT7bRiZNGp9zD0/ozZpK6pDHXfgzzKkpI4xglnA=;
 b=dJPA5gZQwxXnsa5OJ/slphX/II68K2tl1ElWjVCvZy90KcizcHWsxDOLLP5mnmhppMFhCWkAZb2icY05/eWv7nBPviHvlI8JXXn2N/EYalI2PNBWP/52cn3F8hR28w2506zo/hl+LRjBK5ndHJENXCcwrkAB4t5v2SYs254AWp4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Mon, 10 Feb 2020 18:48:24 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:48:23 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v4 3/4] drm/amdkfd: refactor runtime pm for baco
Date: Mon, 10 Feb 2020 13:48:06 -0500
Message-Id: <20200210184807.6271-4-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
References: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 18:48:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4c52503-f1ff-4ff0-a8f1-08d7ae59ce91
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:|SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384200A501FBB4605032206FE190@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(6666004)(4326008)(16526019)(186003)(26005)(316002)(5660300002)(956004)(2616005)(36756003)(66556008)(66476007)(66946007)(478600001)(8936002)(1076003)(8676002)(81156014)(81166006)(2906002)(44832011)(86362001)(6916009)(7696005)(52116002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2384;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbXS+QrP/RqqMGy8pqijgLyxtJElcYRlvloApHG2H6yo3L3IVpH125caiYqWNhZNIgd9Us8HhWp4h8cdScWR04y4qDOIbr5K1PLJ0LgXXeJoJ/50+zU0AeFqG+9SNYX1xFGBQj06ZSS7X6OW8IcBM01WhoPiK9ehIFl8Iy9ZSa5RubGQ5shtiVcg9MkibyLoe19d2SJGVjlqTZ116ZS6pkwhpN3IhpE+rZTKSqiPPvTEFgI6hsXAMLp5TTbXJS8I8AKI4UfKISnFB4EyRgkn0u/EFnubJoMd/Zk+GQNcduIdZyGvAfl4i68WSGjyf79SMmS3A6G3q/ASeA6xglWrWVgNuUTtLNkTiwHvl2Kc0uUFF0yPIgYFMMJ3lS3NY7bPnmKgA0+CedJawR10ZNPyzd4RAXNXMZITq4vHYifQat5kdev2+TrryGfc7PfiQfJM
X-MS-Exchange-AntiSpam-MessageData: NKq/G2MQWkncVzPPL0RjSsVbRyBl04nsWiHBYXmv9VS+1aU36deexdzVY1GCiN3cNftC9SpTNFal1fln0Hkfuw2A6TWrUPKWzKouBSmypQIplqxt0p1yJguI65ehCFlfEk264KVg/2AKq3RDk4sSug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c52503-f1ff-4ff0-a8f1-08d7ae59ce91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 18:48:23.9008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKFcka4k5E4Hol+B/HlDNqyodKmDu1UYfaZSuUYNJonX7IR/I4VXVaMSOv/s9RNbozvnKQ8z8bKC+yRKZA66Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So far the kfd driver implemented same routines for runtime and system
wide suspend and resume (s2idle or mem). During system wide suspend the
kfd aquires an atomic lock that prevents any more user processes to
create queues and interact with kfd driver and amd gpu. This mechanism
created problem when amdgpu device is runtime suspended with BACO
enabled. Any application that relies on kfd driver fails to load because
the driver reports a locked kfd device since gpu is runtime suspended.

However, in an ideal case, when gpu is runtime  suspended the kfd driver
should be able to:

 - auto resume amdgpu driver whenever a client requests compute service
 - prevent runtime suspend for amdgpu  while kfd is in use

This change refactors the amdgpu and amdkfd drivers to support BACO and
runtime power management.

Reviewed-by: Oak Zeng <oak.zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 ++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 42 ++++++++++++++++++++--
 6 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 8609287620ea..314c4a2a0354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -178,18 +178,18 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
 }
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev)
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
 {
 	if (adev->kfd.dev)
-		kgd2kfd_suspend(adev->kfd.dev);
+		kgd2kfd_suspend(adev->kfd.dev, run_pm);
 }
 
-int amdgpu_amdkfd_resume(struct amdgpu_device *adev)
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 {
 	int r = 0;
 
 	if (adev->kfd.dev)
-		r = kgd2kfd_resume(adev->kfd.dev);
+		r = kgd2kfd_resume(adev->kfd.dev, run_pm);
 
 	return r;
 }
@@ -713,11 +713,11 @@ void kgd2kfd_exit(void)
 {
 }
 
-void kgd2kfd_suspend(struct kfd_dev *kfd)
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 }
 
-int kgd2kfd_resume(struct kfd_dev *kfd)
+int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 47b0f2957d1f..9e8db702d878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -122,8 +122,8 @@ struct amdkfd_process_info {
 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev);
-int amdgpu_amdkfd_resume(struct amdgpu_device *adev);
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
@@ -249,8 +249,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
-void kgd2kfd_suspend(struct kfd_dev *kfd);
-int kgd2kfd_resume(struct kfd_dev *kfd);
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
+int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8f4849f94fb0..9a7229c94b8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3343,7 +3343,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
-	amdgpu_amdkfd_suspend(adev);
+	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	amdgpu_ras_suspend(adev);
 
@@ -3427,7 +3427,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 			}
 		}
 	}
-	r = amdgpu_amdkfd_resume(adev);
+	r = amdgpu_amdkfd_resume(adev, !fbcon);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 798ad1c8f799..42ee9ea5c45a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -732,7 +732,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 	if (kfd->init_complete) {
-		kgd2kfd_suspend(kfd);
+		kgd2kfd_suspend(kfd, false);
 		device_queue_manager_uninit(kfd->dqm);
 		kfd_interrupt_exit(kfd);
 		kfd_topology_remove_device(kfd);
@@ -753,7 +753,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
-	kgd2kfd_suspend(kfd);
+	kgd2kfd_suspend(kfd, false);
 
 	kfd_signal_reset_event(kfd);
 	return 0;
@@ -787,21 +787,23 @@ bool kfd_is_locked(void)
 	return  (atomic_read(&kfd_locked) > 0);
 }
 
-void kgd2kfd_suspend(struct kfd_dev *kfd)
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 	if (!kfd->init_complete)
 		return;
 
-	/* For first KFD device suspend all the KFD processes */
-	if (atomic_inc_return(&kfd_locked) == 1)
-		kfd_suspend_all_processes();
+	/* for runtime suspend, skip locking kfd */
+	if (!run_pm) {
+		/* For first KFD device suspend all the KFD processes */
+		if (atomic_inc_return(&kfd_locked) == 1)
+			kfd_suspend_all_processes();
+	}
 
 	kfd->dqm->ops.stop(kfd->dqm);
-
 	kfd_iommu_suspend(kfd);
 }
 
-int kgd2kfd_resume(struct kfd_dev *kfd)
+int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	int ret, count;
 
@@ -812,10 +814,13 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
 	if (ret)
 		return ret;
 
-	count = atomic_dec_return(&kfd_locked);
-	WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
-	if (count == 0)
-		ret = kfd_resume_all_processes();
+	/* for runtime resume, skip unlocking kfd */
+	if (!run_pm) {
+		count = atomic_dec_return(&kfd_locked);
+		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
+		if (count == 0)
+			ret = kfd_resume_all_processes();
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f805f557c3c4..063096ec832d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -651,6 +651,7 @@ struct kfd_process_device {
 	 * function.
 	 */
 	bool already_dequeued;
+	bool runtime_inuse;
 
 	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
 	enum kfd_pdd_bound bound;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 98dcbb96b2e2..22abdbc6dfd7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -31,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/mman.h>
 #include <linux/file.h>
+#include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
 
@@ -527,6 +528,16 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfree(pdd->qpd.doorbell_bitmap);
 		idr_destroy(&pdd->alloc_idr);
 
+		/*
+		 * before destroying pdd, make sure to report availability
+		 * for auto suspend
+		 */
+		if (pdd->runtime_inuse) {
+			pm_runtime_mark_last_busy(pdd->dev->ddev->dev);
+			pm_runtime_put_autosuspend(pdd->dev->ddev->dev);
+			pdd->runtime_inuse = false;
+		}
+
 		kfree(pdd);
 	}
 }
@@ -844,6 +855,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->process = p;
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
+	pdd->runtime_inuse = false;
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */
@@ -933,15 +945,41 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	/*
+	 * signal runtime-pm system to auto resume and prevent
+	 * further runtime suspend once device pdd is created until
+	 * pdd is destroyed.
+	 */
+	if (!pdd->runtime_inuse) {
+		err = pm_runtime_get_sync(dev->ddev->dev);
+		if (err < 0)
+			return ERR_PTR(err);
+	}
+
 	err = kfd_iommu_bind_process_to_device(pdd);
 	if (err)
-		return ERR_PTR(err);
+		goto out;
 
 	err = kfd_process_device_init_vm(pdd, NULL);
 	if (err)
-		return ERR_PTR(err);
+		goto out;
+
+	/*
+	 * make sure that runtime_usage counter is incremented just once
+	 * per pdd
+	 */
+	pdd->runtime_inuse = true;
 
 	return pdd;
+
+out:
+	/* balance runpm reference count and exit with error */
+	if (!pdd->runtime_inuse) {
+		pm_runtime_mark_last_busy(dev->ddev->dev);
+		pm_runtime_put_autosuspend(dev->ddev->dev);
+	}
+
+	return ERR_PTR(err);
 }
 
 struct kfd_process_device *kfd_get_first_process_device_data(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
