Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7530C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA169214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1vx3vHn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA169214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5046EC4B;
	Tue, 28 Jan 2020 01:30:13 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F076EC4C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 01:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhvrdRkDCvEOcBLHYa9hEUSI5mJzgguKZOu4HJLjA3spA1KRiescLNwyHIoNEwj1f1gWGBr5EcbQhZCHORgp3nOtpRiMnH8ZTVrule5r4jYuef9UTEi7VqXB7DaebsC9GwVv4z7gKAy1L2CxlaQAX+7LVycM//WF7L8duQ0dE/GJvM0lXmpQgRipfbeeggS9C1y0Ib/Gy5TmYwINxp17HcaFHoqEnULY4fq4dPVMZ1gY57sW10XrJos4QLnL8X21hQ6ZNjmLUeaaMCwilUf1kdTQztnxtNa+TDU5epWP0iBuIupoxk7ejWBvr65NeDgCw/ELzEzpD7X9Ba9rDyiAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdFi+DaDG+wj7E8LJ0JxSj4WC1qTel8YWZcQlDlP+eg=;
 b=RA0iZbtYXpAgNM9xLZkjsQ4dofgxKLMtjQWDJui9Dbp03ThkTerjwJoOiS6UXRhzxvRiVJr/iJpIN+3WjZ3YWRe8/U7p+qSmpnXmaoi6NCT6xYSp3/mL0f+/zChdJ118nl1zeUfkjtfWk2qvQK+FMR1voNEiVpnhHLF26ofW5WPUoHP53A00eq1vE8Qa5gsh/SZILDCaPHDIPX6yxLOdSidpOCNGxJ+EW6DZeyf9G+SXRlT9YBTxLQV7DF5RJVXrZHXvJI6L7xTUV9G/XA1Mddz9SrewY27xe8NbH+g3++zjlkrohvLxS7QuXSACAb8RE/cAI78ozbUMyptJ40zPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdFi+DaDG+wj7E8LJ0JxSj4WC1qTel8YWZcQlDlP+eg=;
 b=1vx3vHn0NYuHPd5ovu+sx0S+vKYcwkgmMtBSvS7DHpRgPKDhd6NzlB3Nvd0lJiEioGOMic7MVSCGp5Nn3Trx46/oc0UCNtyobzF9L7ki0qa11fZN6VrVC5utgE/FJqoaVKVw63zMZuU6syXQtKnYn5qu5J5alTaqB2wF0ZnTbeE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2416.namprd12.prod.outlook.com (52.132.199.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 01:30:08 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:30:08 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v1 5/5] drm/amdkfd: refactor runtime pm for baco
Date: Mon, 27 Jan 2020 20:29:23 -0500
Message-Id: <20200128012923.25536-6-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Tue, 28 Jan 2020 01:30:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f54e8726-9af4-4a20-e4fc-08d7a3919bc8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:|SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2416E7ED04F4412CA2FD3A6CFE0A0@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(26005)(186003)(16526019)(6486002)(956004)(2616005)(44832011)(6916009)(36756003)(86362001)(8936002)(8676002)(81156014)(81166006)(2906002)(6666004)(66946007)(478600001)(4326008)(66476007)(1076003)(66556008)(316002)(7696005)(52116002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2416;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHBHMadE/9hS3x4qCubsinifVMYinSBRdGnCVOZd3Tt1aI0LHDhRnQ2ypLmLuzO7ADLBPaIDMwUkADsbqScGAWUKtsaI7tIXvpwH8r6VFtxNgk/FkpqN6lqToKJSCqLSybD0zLGTyN8RZhxnj5A/JYxSupyc/fgCnVle3E9F4R1DNyv5OhcONBvsnR0aofZebkB/eRIrwF0T9M48TsKczv3jwaOMYq3NSHrwpMVZV47FWTZyh6otq/V3fzDcOW6RLizvkqt9icLXcvnoW5Y04LrWbh+3WN0b+a9j1hvrx8kdIHeH9yi4fodUHYA5d2AHWe8trkhG8/S2DsQybv35EZcsNE3lRNAyKI2xpdgo8Zr0F/NYzYtqWXgtm1Lqi4J/3asHQYJ7rvsf+i2IJXHkaznpKkg9Aadpi+CPO+AGXhvt7MMMkKZ6b0QNKKOcgvG9
X-MS-Exchange-AntiSpam-MessageData: 9jtoij7Wo3woBUSEoLvqeHZdidnlQsUe3E0LwK4TlZDucUIePO6crICOx+s4YnmvYDBl10V9YRSKWBOTiRM7C5yKfhJ4b4Vf5X/bkWQYXtwKcAd8lsC4txzypEeB1o/5jhVxYmzinzK7+YqIsyYFlQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54e8726-9af4-4a20-e4fc-08d7a3919bc8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 01:30:07.7163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +APiOYbss0OwIHdqnr4fTk94jRRR+oqyfgcdxIS9ATgZtPrVarLTyCxIEKx8ZBDbhQ/vQVKkTz9rQLDMngrP2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
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
runtime runtime power management.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 31 +++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     |  5 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 19 ++++++++++---
 6 files changed, 51 insertions(+), 28 deletions(-)

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
index 0fa898d30207..3dce4a51e522 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -123,8 +123,8 @@ struct amdkfd_process_info {
 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev);
-int amdgpu_amdkfd_resume(struct amdgpu_device *adev);
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
@@ -250,8 +250,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
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
index d9e5eac182d3..787d49e9f4de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3314,7 +3314,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
-	amdgpu_amdkfd_suspend(adev);
+	amdgpu_amdkfd_suspend(adev, fbcon);
 
 	amdgpu_ras_suspend(adev);
 
@@ -3398,7 +3398,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 			}
 		}
 	}
-	r = amdgpu_amdkfd_resume(adev);
+	r = amdgpu_amdkfd_resume(adev, fbcon);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2a9e40131735..e9f00c3a067a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -23,6 +23,7 @@
 #include <linux/bsearch.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers_vi.h"
@@ -710,7 +711,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 	if (kfd->init_complete) {
-		kgd2kfd_suspend(kfd);
+		kgd2kfd_suspend(kfd, true);
 		device_queue_manager_uninit(kfd->dqm);
 		kfd_interrupt_exit(kfd);
 		kfd_topology_remove_device(kfd);
@@ -731,7 +732,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
-	kgd2kfd_suspend(kfd);
+	kgd2kfd_suspend(kfd, true);
 
 	kfd_signal_reset_event(kfd);
 	return 0;
@@ -765,21 +766,24 @@ bool kfd_is_locked(void)
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
+	if (run_pm) {
+		/* For first KFD device suspend all the KFD processes */
+		if (atomic_inc_return(&kfd_locked) == 1)
+			kfd_suspend_all_processes();
+	}
 
+	pm_runtime_set_autosuspend_delay(kfd->ddev->dev, 5000);
 	kfd->dqm->ops.stop(kfd->dqm);
-
 	kfd_iommu_suspend(kfd);
 }
 
-int kgd2kfd_resume(struct kfd_dev *kfd)
+int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	int ret, count;
 
@@ -790,10 +794,13 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
 	if (ret)
 		return ret;
 
-	count = atomic_dec_return(&kfd_locked);
-	WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
-	if (count == 0)
-		ret = kfd_resume_all_processes();
+	/* for runtime resume, skip unlocking kfd */
+	if (run_pm) {
+		count = atomic_dec_return(&kfd_locked);
+		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
+		if (count == 0)
+			ret = kfd_resume_all_processes();
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 8d871514671e..6301d77ed3d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/amd-iommu.h>
+#include <linux/pm_runtime.h>
 #include "kfd_priv.h"
 #include "kfd_dbgmgr.h"
 #include "kfd_topology.h"
@@ -134,8 +135,10 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
 	struct kfd_process_device *pdd;
 
 	list_for_each_entry(pdd, &p->per_device_data, per_device_list)
-		if (pdd->bound == PDD_BOUND)
+		if (pdd->bound == PDD_BOUND) {
 			amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
+			pm_runtime_set_autosuspend_delay(pdd->dev->ddev->dev, 5000);
+		}
 }
 
 /* Callback for process shutdown invoked by the IOMMU driver */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 25b90f70aecd..d19d5e97405c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -31,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/mman.h>
 #include <linux/file.h>
+#include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
 
@@ -843,15 +844,27 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	err = pm_runtime_get_sync(dev->ddev->dev);
+	pm_runtime_set_autosuspend_delay(dev->ddev->dev, 60000);
+	if (err < 0)
+		return ERR_PTR(err);
+
 	err = kfd_iommu_bind_process_to_device(pdd);
 	if (err)
-		return ERR_PTR(err);
+		goto out;
 
 	err = kfd_process_device_init_vm(pdd, NULL);
 	if (err)
-		return ERR_PTR(err);
+		goto out;
 
-	return pdd;
+out:
+	pm_runtime_mark_last_busy(dev->ddev->dev);
+	pm_runtime_put_autosuspend(dev->ddev->dev);
+
+	if (!err)
+		return pdd;
+	else
+		return ERR_PTR(err);
 }
 
 struct kfd_process_device *kfd_get_first_process_device_data(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
