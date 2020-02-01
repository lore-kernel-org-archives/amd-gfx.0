Return-Path: <SRS0=aySl=3V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73037C33C9E
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A65620663
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q5DbNk64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A65620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26F66FC79;
	Sat,  1 Feb 2020 03:37:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF306FC77
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 03:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4tWIMO07p1ZK6kGgOzi4RkhlHumiEFWU2pMy0EkmJ8NPx8065ZbRlRdvn0nEwPjf/Z/SoowuJhBid2e5hsuv63qpXGZmsUn5VPFFclTCVgzzVhGTLxt96xyVCCHkvKsnSwaHJoszmvRhCF+erNDR9cU2GpI1SSp9VT4hY3Yn2or8iVTqfAMxJ198BCmmd8ItVQxZ65zfPEBpfSeDNQ/qTae7KKbXxtWC9xyzODQ0CPUxeen3fPBvsZCcxfnOqI6PSbVlLNhVehm+OFED5ed5eIl26x3syFaC/kgZ5ttkssDSziea2FsP+0WBZIsEtFrNvq8uoxjqfgFivASB/q28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GzKBkqpt4CM7quZOK5nfaslUWFdn7qXolvCcc9W2y0=;
 b=dkan5sFJ+KkrVsbW+yerf0cbxLsTA4oNt5IXgwOnsHifCDOWtIjpB0C2+7Vf58BNqn1+b5LEpSUAe6Gl60SIaoMnMWPowIYC55g60iowTDLI5b4wNTtuImz1xI0IDLAcaZaeo1YSSWKRdn0CjD964qM7tjD6OqEIdSSjLxin9sG6nMaeddVKC4PKpCqCoFVP6H0lb6FBPqULiuLD6rzZTI7bcHF0BoxUuQVx9R0OmH6MlNEK82a6FzuWjVJAONPMeyvNHg6a1VTeExXEW/M0qkWw8A60Cfak5c822hvRM8tTIrDP7Z4hzA+aTvJn5bbhFAPXEPAXvGmofpLqk5sKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GzKBkqpt4CM7quZOK5nfaslUWFdn7qXolvCcc9W2y0=;
 b=q5DbNk64EcODNmwWo5nJIrp61ua6El63MdXM60eMmHJbNOPOVEDGrjA8XMe918+Lw4KXrmAIA8rMlWE6Kp1Oq5Hxm/wfac3xRwRsfgRZclG/hsZt8tBW9nnTPqqqHA69MyMWns6d7CrIghU+f3yNztvERg4SG6Q4p59wHYyVr7k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1849.namprd12.prod.outlook.com (10.175.85.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Sat, 1 Feb 2020 03:37:28 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2686.031; Sat, 1 Feb 2020
 03:37:28 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco
Date: Fri, 31 Jan 2020 22:37:06 -0500
Message-Id: <20200201033707.16351-4-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
References: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 03:37:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65e5a94f-bba5-4cf7-098b-08d7a6c80fa9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1849:|DM5PR12MB1849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB184960D8A2F0953F6DAFAEE9FE060@DM5PR12MB1849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(478600001)(81156014)(8676002)(44832011)(4326008)(36756003)(81166006)(52116002)(7696005)(6916009)(8936002)(16526019)(6666004)(186003)(26005)(86362001)(2906002)(6486002)(2616005)(956004)(66946007)(66476007)(66556008)(5660300002)(1076003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1849;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R10qveHomOlJcE+5rYF1SmhimDF0YimZkNaqAqJYXlVm/pKreEg3UwtWOeUa/EC6BUvHPpRgMA80LFsv8oE5EFWaeyq4ZlDyChxcUsQteI0m4JVGEj9AuBV+6pfVg0LLrokXgwRg3plwLkMbEk7KFyE8D3mHz45YuR4iBbcXwvyxtKF9rf3EN4d7qvhzPsrArAYzClAUWUi479+oD8VcsbOMz37vtskgJC4hL34Fwac3gttGy0/tL05hFONNN9kKcAKBagD9O/unpd1ktHu59js+eN4vC9ZiLoBKVugeqhicdzjC/rFmv2scpQTaeGMuFHo9MZCDW++wzUvrK0QLPE09yf8OGfKBxJOrcc7kPJNgaJcE1ENEO5C94XcVZTVwgJxSxxbA6iFbUsJOu5N4k44fvCZoRPZpQoD16bnjR0t7ZVWNorJIV0+pH7zJHne6
X-MS-Exchange-AntiSpam-MessageData: gV9Yj+11turJtlIpuXKbvSlXate0Acb2bonMVIJcfB5Hb1Jcebviabzvwn29xqBIMu1/stiSMY9xyKxHJC3wwae/AumiVPd6GrjRjN7BL7NeLz1a+PAJZBh028qyWv3sLxJwby4xR8l/RHOWtj8BrQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e5a94f-bba5-4cf7-098b-08d7a6c80fa9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 03:37:28.4879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC7l4JeaO13y99hp4jXY47l5p52qXwsHV7e0SxfEV/ejNb1CrTlqSHuq3ULV6f9hzpZudeJ/AMG9PFYWRxL7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1849
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
runtime power management.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 +++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 43 ++++++++++++++++++++--
 6 files changed, 70 insertions(+), 27 deletions(-)

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
index 5030a09babb8..43843e6c4bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3311,7 +3311,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
-	amdgpu_amdkfd_suspend(adev);
+	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	amdgpu_ras_suspend(adev);
 
@@ -3395,7 +3395,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
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
index c0b0defc8f7a..20dd4747250d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -647,6 +647,7 @@ struct kfd_process_device {
 	 * function.
 	 */
 	bool already_dequeued;
+	bool runtime_inuse;
 
 	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
 	enum kfd_pdd_bound bound;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 25b90f70aecd..6907a5a2cbc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -31,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/mman.h>
 #include <linux/file.h>
+#include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
 
@@ -440,6 +441,16 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
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
@@ -754,6 +765,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->process = p;
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
+	pdd->runtime_inuse = false;
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */
@@ -843,15 +855,40 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
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
 
-	return pdd;
+	if (!err) {
+		/*
+		 * make sure that runtime_usage counter is incremented
+		 * just once per pdd
+		 */
+		if (!pdd->runtime_inuse)
+			pdd->runtime_inuse = true;
+
+		return pdd;
+	}
+out:
+	/* balance runpm reference count and exit with error */
+	pm_runtime_mark_last_busy(dev->ddev->dev);
+	pm_runtime_put_autosuspend(dev->ddev->dev);
+	return ERR_PTR(err);
 }
 
 struct kfd_process_device *kfd_get_first_process_device_data(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
