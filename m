Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CFDC352A3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF13D20838
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="njibcV22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF13D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A836E506;
	Fri,  7 Feb 2020 00:09:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F6E6E4AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 00:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4DJYk+VzYFEuzzJeRBPaiPlvNuo3xVohCHr7uVaJWH+WGU84Xe5+W1L4BnEfH4L+LJrKJ1vK5Y170tFkJ1fS5E5AAVfU71xulN9DcRnw3usD5+RCfbgqu2C57DplyrN7E6ITthU9FjQE7USH5pbYcOdPWfU7a0BQU7FL3XgG6+CoJ4nWVHxFlU6feeXT++jSjvn09WmaXg/REWgeYm09coVDH/z4d/Fh02dI7Ko6qmSkKTQ/eR63WlEvlaH2B/LoV3uBKmWAk77zba0zt10Qwn/5RwRDpLC7Mpyt0eq69/jOBA6KExUsumzlvEZTqu3waPwb2KfjG0U9oK3TqxadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzm9V8UxGd06ded6U2kOAkS1BbEdX/E8KLYZkbSwNhc=;
 b=DPvInPvJIVtXDtAytiWR9H6wh1kTc7ruej4CGXdjeJZ7GVjQ5f3UjtF4v7455Y19bsHau9VHXR+7abYfjYOotstNX9A0hBRNc83UPzDq4lNSTc+c0FfZVe4NE9l5GHe051f9JqvyCqmUilZY+f74ZACb6KaIHg/GUFvJO1BMW58+mo4SS383xvrSgZhiRILq8mUd77fkFM4AGrZS2sdDD0B78CbN4rGlfPl19/saEOIsynnghhxZ9/yx0gwhg/o/E/2U5D4Kpmq+4NJzB+SbtNFCo3FWU4tXirxpyf5leP4APzaSP2JhNEvIlOwdlhWsCdQJeCYpSE+zsOxfs/vf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzm9V8UxGd06ded6U2kOAkS1BbEdX/E8KLYZkbSwNhc=;
 b=njibcV22xAvoYqV+wxyUtXO8wb7Q4GbWJpAaT+Od2cp2nOBizl85l38WNFoqmj/OpEohLldcBQcat1gYA1dP8UIt89EvpPoNrD4hC+cJCWDNBwSrEI75hqrUSTxkivCzuKA+arS01QLn8wTf6aKogQo7rhxuin3RteYt4yhjd1A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1530.namprd12.prod.outlook.com (10.172.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Fri, 7 Feb 2020 00:09:28 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 00:09:28 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v3 3/4] drm/amdkfd: refactor runtime pm for baco
Date: Thu,  6 Feb 2020 19:09:10 -0500
Message-Id: <20200207000911.19166-4-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
References: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 00:09:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94fd2c8b-54be-487f-5628-08d7ab61ff80
X-MS-TrafficTypeDiagnostic: DM5PR12MB1530:|DM5PR12MB1530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1530869942BC7487C23021E3FE1C0@DM5PR12MB1530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(26005)(66946007)(44832011)(66476007)(5660300002)(956004)(66556008)(478600001)(6486002)(7696005)(6666004)(186003)(16526019)(2906002)(52116002)(36756003)(316002)(86362001)(8676002)(2616005)(6916009)(81166006)(1076003)(4326008)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1530;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDWKfxd/VH8lk70ZS6O1w75/Hcr3vu5BeE6yVH3oVhzT9LJhczLXviCoWGU+5LYMRu1rg7febJwWBlpq4RRrJyzKrkcL4HwiZTP0lN6SKKNRlclIoi0WepB6CJaOzcQxurn2aC67zMIfLPZrudX48bWZZdHQMarU/4/OB/LVyRSsqepOSGu+brP6RKN8e7ndR8MIWqJ8Nw87L0U5P+FTISkjD9K87t5frnms6tQ25+fdZtTh0hPWkwTlPPE9obKEkbQShLLDVSZI/EDsnrv9fpI4S0g9f/AxpNlxg6lIHwLA6ZWhgEpPmmyOaqMmpDrTmO0ecOMBuyDBFjTQj/VOfLICLQGsrgmB6fPoxKEYnoJS0Yp2Y0aPcdhHi7iSqpJ0qkTRl1nkIOE9Gg+GDlFjYK2HCAkTQH9StzG/L1RTT6GU2CZY73va/F55oGraROw7
X-MS-Exchange-AntiSpam-MessageData: 226Yi5YFu9C73y7g6zdPaceoANpyRiGeq7bs7yRLQ7ZTZHWqMgjN/9VcyGScANjzj4AqLuFDIbUj3LdGmslCyjycDnxTWreBGCIv1Ubi8FSAVIErcGw8Mkl2zYGg2FC11yrXXpoF7K9wSVi3BKp4Qg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fd2c8b-54be-487f-5628-08d7ab61ff80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 00:09:28.5431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGUz7e3apHNLUVS2IMiTLIcuSyIH22QSxwSNLpBwYlEkan3Vs92QHsUeq6pb7FVMHbuhwuy7xNuEcMaqH4ZW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1530
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
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 +++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 40 ++++++++++++++++++++--
 6 files changed, 68 insertions(+), 26 deletions(-)

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
index f33c49ed4f94..18fa78806317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3312,7 +3312,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
-	amdgpu_amdkfd_suspend(adev);
+	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	amdgpu_ras_suspend(adev);
 
@@ -3396,7 +3396,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
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
index 98dcbb96b2e2..6d6c25fe2677 100644
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
@@ -933,15 +945,39 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
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
+	if (!err)
+		/*
+		 * make sure that runtime_usage counter is incremented
+		 * just once per pdd
+		 */
+		pdd->runtime_inuse = true;
 
 	return pdd;
+
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
