Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E2C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 07:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A543F20760
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 07:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cSGwAavK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A543F20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3066E0C2;
	Wed,  8 Jul 2020 07:48:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246056E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 07:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JISGkP7L1TWs/vvhXleX6OHgFwAdyeIhvxaEfJ2SZgGab0t+EzfUlaMaov0KbCmgF/B7tQJP3OxWyZMgLSN5SHf7hCiW+JsiV+gWh+sDyW/vtl4992QXQe5cnmmZtYOtun2dRK7mBMmM/5pU/ymbGlYAe10ccJGv2PEYaKpNtG/Y1cq0KAeHRQuEO/E0/eF4g/1SIPhGJxAi/tEJ4EumZTnWUt0ufEUwiXvZBMqhm3f8AWaozYP657jGyLhnHvbx0Zqb9hA+cGoXE1o5CRi0H5gyQJytioZ7IUE6HV+xMQ9/NXWfks2ICR9U1Yz7qwWMH7VYRYtOegJXHhcUc2KJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKqyNLlxbLhWP1+WR0w1sCtXTtM6Sj19gTjCeElYmuo=;
 b=bl1G1dr+qFKZWaV7hruvJcXaGLGLvfe5Y167TSN9MYkhoaD4mA1bZibcYDNnM6UGETTqYrkKK6D0NNe3C7dTcj/9GXjRLV9qiroJmKMUexCEgdFQeoF5vl4yqgtYQ4JX7t21SD/rqw7e+f0XXwQzxwa/Tq2Ks1Qw27O0F4aYwsihpn2CHYlGmGTlCCZeq5T7CmYwnS12hScjU1HFtdvaHyuAXrqdNO+gHQmLTXQkkAHqHg8Kl9sYmlHgfD3Bg9y6oh0Af3Q1onz4h9npetrvbhHtuT0eCfgAFIQK6XQQp8KXjsZ+wjRQSY9iPemWIm39jlqhL/dtEAdwq2xslDp57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKqyNLlxbLhWP1+WR0w1sCtXTtM6Sj19gTjCeElYmuo=;
 b=cSGwAavKecCel4vrlXnhmv1/ytm6YHPRt7v2zY2Nc3Q/BcxJMV8I171SLQkhAeHrLy+nOTGz6QfvYhdmxSpSX6S56XLi8EKxwbfgyc7zd5Pms3YPHIVrbd+IghlryVmmO+UaUSl4tQjVqiUevHAau5AsFQ5DGfhiKfebjd53Fqs=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 8 Jul 2020 07:48:44 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::75) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Wed, 8 Jul 2020 07:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3153.24 via Frontend Transport; Wed, 8 Jul 2020 07:48:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jul 2020
 02:48:44 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jul 2020
 02:48:42 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 8 Jul 2020 02:48:40 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix system hang issue during GPU reset
Date: Wed, 8 Jul 2020 15:48:00 +0800
Message-ID: <20200708074800.10093-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(1076003)(336012)(30864003)(86362001)(82740400003)(47076004)(82310400002)(26005)(6666004)(5660300002)(70206006)(316002)(70586007)(478600001)(110136005)(4326008)(36756003)(8676002)(8936002)(356005)(83380400001)(186003)(426003)(6636002)(2906002)(7696005)(81166007)(2616005)(2101003)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05c17d6d-b458-4585-3b17-08d823135731
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00277F151098C708886D7C8AED670@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VeLs6WWjrr85Tg+5TzZmL6IAK8Y6b13hSTtMduT/2n4Ap5dBk7jr5C5wR0fMZPopz/OS570w9QiZR71e1JLzU0rTX70leBeoZ5J9OgLO63F8BGhE/ba8MI11UJ6Go61r1iYw/ICqwA8FNCmsjusSYAKtc/H/lZGPuJT2eM0ZHAZI/700A6vktLYnli6ho9VdxAMgnsnAMH8dBO8IwdGjvNb89jsZVwh7HgXyr8kpAFMlZA6b+JUE/p7Lahy0kEG9lIJZ4dGOfmgnJY0WgmnTrhTRjXGAEK6KGsYYbY1bnSm9RSaijCjvCI+s585SB33jnn95c6Jf+L+/rfirSXOQf3IqgyadF9JhNneb34qQiP4ZyZXdElls6fpAlH/Bsn+DjlqGeXWu5ZLh1/EFvtDVT4ync253dQ7EETZ3VdLhfH8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 07:48:44.6270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c17d6d-b458-4585-3b17-08d823135731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During GPU reset, driver should hold on all external access to
GPU, otherwise psp will randomly fail to do post, and then cause
system hang.

v2:
1. add rwlock for some ioctls, debugfs and file-close function.
2. change to use dqm->is_resetting and dqm_lock for protection in kfd
driver.
3. remove try_lock and change adev->in_gpu_reset as atomic, to avoid
re-enter GPU recovery for the same GPU hang.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I7f77a72795462587ed7d5f51fe53a594a0f1f708

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 80f32b3beb88..f235492799d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -963,9 +963,9 @@ struct amdgpu_device {
 	bool                            in_suspend;
 	bool				in_hibernate;
 
-	bool                            in_gpu_reset;
+	atomic_t                        in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
-	struct mutex  lock_reset;
+	struct rw_semaphore	reset_sem;
 	struct amdgpu_doorbell_index doorbell_index;
 
 	struct mutex			notifier_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 691c89705bcd..af71d8e93081 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,7 +543,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EIO;
 
 #if 0
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 0b7e78748540..750a8308c868 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -425,7 +425,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	unsigned long flags, end_jiffies;
 	int retry;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EIO;
 
 	acquire_queue(kgd, pipe_id, queue_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index ccd635b812b5..027793e0c1ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -421,7 +421,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	int retry;
 	struct vi_mqd *m = get_mqd(mqd);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EIO;
 
 	acquire_queue(kgd, pipe_id, queue_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2ac5e7..e4a77f7a4c2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -541,7 +541,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EIO;
 
 	acquire_queue(kgd, pipe_id, queue_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ffbcaf4bfb8b..a94b3f862fc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1292,6 +1292,8 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	parser.adev = adev;
 	parser.filp = filp;
 
+	down_read(&adev->reset_sem);
+
 	r = amdgpu_cs_parser_init(&parser, data);
 	if (r) {
 		DRM_ERROR("Failed to initialize parser %d!\n", r);
@@ -1331,6 +1333,8 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 out:
 	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
 
+	up_read(&adev->reset_sem);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8842c55d4490..d85d13f7a043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -358,6 +358,8 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
+	down_read(&adev->reset_sem);
+
 	/*query ue count*/
 	ras_counter = amdgpu_ras_query_error_count(adev, false);
 	/*ras counter is monotonic increasing*/
@@ -373,6 +375,8 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 		ctx->ras_counter_ce = ras_counter;
 	}
 
+	up_read(&adev->reset_sem);
+
 	mutex_unlock(&mgr->lock);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeada7c9fbea..ecbff532a21b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -100,14 +100,14 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
 
 	file->private_data = adev;
 
-	mutex_lock(&adev->lock_reset);
+	down_read(&adev->reset_sem);
 	if (adev->autodump.dumping.done) {
 		reinit_completion(&adev->autodump.dumping);
 		ret = 0;
 	} else {
 		ret = -EBUSY;
 	}
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	return ret;
 }
@@ -126,7 +126,7 @@ static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_
 
 	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return POLLIN | POLLRDNORM | POLLWRNORM;
 
 	return 0;
@@ -1188,7 +1188,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	down_read(&adev->reset_sem);
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
@@ -1215,7 +1215,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1395,7 +1395,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -ENOMEM;
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	down_read(&adev->reset_sem);
 
 	/* stop the scheduler */
 	kthread_park(ring->sched.thread);
@@ -1436,7 +1436,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* restart the scheduler */
 	kthread_unpark(ring->sched.thread);
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2913e41f63a5..4f3ec9746d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1929,7 +1929,7 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
 
-			if (adev->in_gpu_reset || adev->in_suspend) {
+			if (atomic_read(&adev->in_gpu_reset) || adev->in_suspend) {
 				r = adev->ip_blocks[i].version->funcs->resume(adev);
 				if (r) {
 					DRM_ERROR("resume of IP block <%s> failed %d\n",
@@ -2100,7 +2100,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 			AMDGPU_RESET_MAGIC_NUM))
 		return true;
 
-	if (!adev->in_gpu_reset)
+	if (!atomic_read(&adev->in_gpu_reset))
 		return false;
 
 	/*
@@ -3026,7 +3026,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
-	mutex_init(&adev->lock_reset);
+	init_rwsem(&adev->reset_sem);
+	atomic_set(&adev->in_gpu_reset, 0);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 
@@ -4131,16 +4132,14 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	return r;
 }
 
-static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool trylock)
+static bool amdgpu_device_lock_adev(struct amdgpu_device *adev)
 {
-	if (trylock) {
-		if (!mutex_trylock(&adev->lock_reset))
-			return false;
-	} else
-		mutex_lock(&adev->lock_reset);
+	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
+		return false;
+
+	down_write(&adev->reset_sem);
 
 	atomic_inc(&adev->gpu_reset_counter);
-	adev->in_gpu_reset = true;
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_MODE1:
 		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
@@ -4160,8 +4159,8 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 {
 	amdgpu_vf_error_trans_all(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
-	adev->in_gpu_reset = false;
-	mutex_unlock(&adev->lock_reset);
+	atomic_set(&adev->in_gpu_reset, 0);
+	up_write(&adev->reset_sem);
 }
 
 static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
@@ -4297,7 +4296,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		if (!amdgpu_device_lock_adev(tmp_adev, !hive)) {
+		if (!amdgpu_device_lock_adev(tmp_adev)) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
 			mutex_unlock(&hive->hive_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 77d988a0033f..96df3669a9d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -670,6 +670,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	down_read(&adev->reset_sem);
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -699,6 +701,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
 					args->operation);
 
+	up_read(&adev->reset_sem);
+
 error_backoff:
 	ttm_eu_backoff_reservation(&ticket, &list);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d612033a23ac..c9f13f836a7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -710,7 +710,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	 *
 	 * also don't wait anymore for IRQ context
 	 * */
-	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+	if (r < 1 && (atomic_read(&adev->in_gpu_reset) || in_interrupt()))
 		goto failed_kiq_read;
 
 	might_sleep();
@@ -768,7 +768,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	 *
 	 * also don't wait anymore for IRQ context
 	 * */
-	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+	if (r < 1 && (atomic_read(&adev->in_gpu_reset) || in_interrupt()))
 		goto failed_kiq_write;
 
 	might_sleep();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 937029ad5271..367528de1658 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -226,8 +226,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	if (finished->error < 0) {
 		DRM_INFO("Skip scheduling IBs!\n");
 	} else {
+		down_read(&ring->adev->reset_sem);
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
 				       &fence);
+		up_read(&ring->adev->reset_sem);
 		if (r)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9c2c5e4ed1eb..eebbe2103e32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1084,6 +1084,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	down_read(&adev->reset_sem);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
@@ -1122,6 +1124,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
+
+	up_read(&adev->reset_sem);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index d2401379bd33..61b23ae906d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -163,7 +163,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -172,6 +172,8 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		if (adev->smu.ppt_funcs->get_current_power_state)
 			pm = smu_get_current_power_state(&adev->smu);
@@ -183,6 +185,8 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 		pm = adev->pm.dpm.user_state;
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -201,7 +205,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (strncmp("battery", buf, strlen("battery")) == 0)
@@ -219,6 +223,8 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		mutex_lock(&adev->pm.mutex);
 		adev->pm.dpm.user_state = state;
@@ -232,6 +238,9 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 
 		amdgpu_pm_compute_clocks(adev);
 	}
+
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -307,7 +316,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -316,6 +325,8 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		level = smu_get_performance_level(&adev->smu);
 	else if (adev->powerplay.pp_funcs->get_performance_level)
@@ -323,6 +334,8 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	else
 		level = adev->pm.dpm.forced_level;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -349,7 +362,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (strncmp("low", buf, strlen("low")) == 0) {
@@ -380,6 +393,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		current_level = smu_get_performance_level(&adev->smu);
 	else if (adev->powerplay.pp_funcs->get_performance_level)
@@ -388,7 +403,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	if (current_level == level) {
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
-		return count;
+		ret = count;
+		goto pro_end;
 	}
 
 	if (adev->asic_type == CHIP_RAVEN) {
@@ -409,7 +425,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		pr_err("Currently not in any profile mode!\n");
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto pro_end;
 	}
 
 	if (is_support_sw_smu(adev)) {
@@ -417,7 +434,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto pro_end;
 		}
 	} else if (adev->powerplay.pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
@@ -425,14 +443,16 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 			mutex_unlock(&adev->pm.mutex);
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto pro_end;
 		}
 		ret = amdgpu_dpm_force_performance_level(adev, level);
 		if (ret) {
 			mutex_unlock(&adev->pm.mutex);
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto pro_end;
 		} else {
 			adev->pm.dpm.forced_level = level;
 		}
@@ -441,7 +461,9 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
-	return count;
+pro_end:
+	up_read(&adev->reset_sem);
+	return ret;
 }
 
 static ssize_t amdgpu_get_pp_num_states(struct device *dev,
@@ -453,7 +475,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	struct pp_states_info data;
 	int i, buf_len, ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -497,7 +519,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -538,7 +560,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (adev->pp_force_state_enabled)
@@ -558,7 +580,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (strlen(buf) == 1)
@@ -584,6 +606,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 			return ret;
 		}
 
+		down_read(&adev->reset_sem);
 		/* only set user selected power states */
 		if (state != POWER_STATE_TYPE_INTERNAL_BOOT &&
 		    state != POWER_STATE_TYPE_DEFAULT) {
@@ -591,6 +614,8 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 					AMD_PP_TASK_ENABLE_USER_STATE, &state);
 			adev->pp_force_state_enabled = true;
 		}
+		up_read(&adev->reset_sem);
+
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
 	}
@@ -618,7 +643,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -662,7 +687,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -671,16 +696,21 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		ret = smu_sys_set_pp_table(&adev->smu, (void *)buf, count);
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
+			up_read(&adev->reset_sem);
 			return ret;
 		}
 	} else if (adev->powerplay.pp_funcs->set_pp_table)
 		amdgpu_dpm_set_pp_table(adev, buf, count);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -769,7 +799,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (count > 127)
@@ -813,6 +843,10 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
+	ret = count;
+
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		ret = smu_od_edit_dpm_table(&adev->smu, type,
 					    parameter, parameter_size);
@@ -820,7 +854,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto pro_end;
 		}
 	} else {
 		if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
@@ -829,7 +864,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			if (ret) {
 				pm_runtime_mark_last_busy(ddev->dev);
 				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto pro_end;
 			}
 		}
 
@@ -840,18 +876,22 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 						NULL);
 				pm_runtime_mark_last_busy(ddev->dev);
 				pm_runtime_put_autosuspend(ddev->dev);
-				return count;
+				ret = count;
+				goto pro_end;
 			} else {
 				pm_runtime_mark_last_busy(ddev->dev);
 				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto pro_end;
 			}
 		}
 	}
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
-	return count;
+pro_end:
+	up_read(&adev->reset_sem);
+	return ret;
 }
 
 static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
@@ -863,7 +903,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -917,7 +957,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = kstrtou64(buf, 0, &featuremask);
@@ -932,11 +972,13 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
 	if (is_support_sw_smu(adev)) {
 		ret = smu_sys_set_pp_feature_mask(&adev->smu, featuremask);
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
+			up_read(&adev->reset_sem);
 			return -EINVAL;
 		}
 	} else if (adev->powerplay.pp_funcs->set_ppfeature_status) {
@@ -944,9 +986,12 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
+			up_read(&adev->reset_sem);
 			return -EINVAL;
 		}
 	}
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -962,7 +1007,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -971,6 +1016,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_sys_get_pp_feature_mask(&adev->smu, buf);
 	else if (adev->powerplay.pp_funcs->get_ppfeature_status)
@@ -978,6 +1025,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1023,7 +1072,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1032,6 +1081,8 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_SCLK, buf);
 	else if (adev->powerplay.pp_funcs->print_clock_levels)
@@ -1039,6 +1090,8 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1091,7 +1144,7 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1104,11 +1157,15 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask, true);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1127,7 +1184,7 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1136,6 +1193,8 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_MCLK, buf);
 	else if (adev->powerplay.pp_funcs->print_clock_levels)
@@ -1143,6 +1202,8 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1159,7 +1220,7 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	uint32_t mask = 0;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1172,11 +1233,15 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask, true);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1195,7 +1260,7 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1204,6 +1269,8 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_SOCCLK, buf);
 	else if (adev->powerplay.pp_funcs->print_clock_levels)
@@ -1211,6 +1278,8 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1227,7 +1296,7 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1240,6 +1309,8 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask, true);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
@@ -1247,6 +1318,8 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	else
 		ret = 0;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1265,7 +1338,7 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1274,6 +1347,8 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_FCLK, buf);
 	else if (adev->powerplay.pp_funcs->print_clock_levels)
@@ -1281,6 +1356,8 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1297,7 +1374,7 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1310,6 +1387,8 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask, true);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
@@ -1317,6 +1396,8 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	else
 		ret = 0;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1335,7 +1416,7 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1344,6 +1425,8 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_DCEFCLK, buf);
 	else if (adev->powerplay.pp_funcs->print_clock_levels)
@@ -1351,6 +1434,8 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1367,7 +1452,7 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1380,6 +1465,8 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask, true);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
@@ -1387,6 +1474,8 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	else
 		ret = 0;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1405,7 +1494,7 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1414,6 +1503,8 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_PCIE, buf);
 	else if (adev->powerplay.pp_funcs->print_clock_levels)
@@ -1421,6 +1512,8 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1437,7 +1530,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1450,6 +1543,8 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask, true);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
@@ -1457,6 +1552,8 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	else
 		ret = 0;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1475,7 +1572,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1484,11 +1581,15 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		value = smu_get_od_percentage(&(adev->smu), SMU_OD_SCLK);
 	else if (adev->powerplay.pp_funcs->get_sclk_od)
 		value = amdgpu_dpm_get_sclk_od(adev);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1505,7 +1606,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1519,6 +1620,8 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		value = smu_set_od_percentage(&(adev->smu), SMU_OD_SCLK, (uint32_t)value);
 	} else {
@@ -1533,6 +1636,8 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 		}
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1548,7 +1653,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1557,11 +1662,15 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		value = smu_get_od_percentage(&(adev->smu), SMU_OD_MCLK);
 	else if (adev->powerplay.pp_funcs->get_mclk_od)
 		value = amdgpu_dpm_get_mclk_od(adev);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1578,7 +1687,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1592,6 +1701,8 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		value = smu_set_od_percentage(&(adev->smu), SMU_OD_MCLK, (uint32_t)value);
 	} else {
@@ -1606,6 +1717,8 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 		}
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1641,7 +1754,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1650,6 +1763,8 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		size = smu_get_power_profile_mode(&adev->smu, buf);
 	else if (adev->powerplay.pp_funcs->get_power_profile_mode)
@@ -1657,6 +1772,8 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1681,7 +1798,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	tmp[0] = *(buf);
@@ -1715,11 +1832,15 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		ret = smu_set_power_profile_mode(&adev->smu, parameter, parameter_size, true);
 	else if (adev->powerplay.pp_funcs->set_power_profile_mode)
 		ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1745,7 +1866,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
@@ -1754,9 +1875,11 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
 	/* read the IP busy sensor */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_LOAD,
 				   (void *)&value, &size);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1783,7 +1906,7 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
@@ -1792,10 +1915,14 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
+
 	/* read the IP busy sensor */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD,
 				   (void *)&value, &size);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1826,7 +1953,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (adev->flags & AMD_IS_APU)
@@ -1841,8 +1968,12 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1867,7 +1998,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (adev->unique_id)
@@ -2134,7 +2265,7 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 	int channel = to_sensor_dev_attr(attr)->index;
 	int r, temp = 0, size = sizeof(temp);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (channel >= PP_TEMP_MAX)
@@ -2146,6 +2277,8 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
+
 	switch (channel) {
 	case PP_TEMP_JUNCTION:
 		/* get current junction temperature */
@@ -2167,6 +2300,8 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 		break;
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2270,7 +2405,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
@@ -2279,18 +2414,23 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
 	} else {
 		if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			up_read(&adev->reset_sem);
 			return -EINVAL;
 		}
 
 		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2306,7 +2446,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	int err, ret;
 	int value;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -2319,18 +2459,23 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		smu_set_fan_control_mode(&adev->smu, value);
 	} else {
 		if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			up_read(&adev->reset_sem);
 			return -EINVAL;
 		}
 
 		amdgpu_dpm_set_fan_control_mode(adev, value);
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2360,7 +2505,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2369,11 +2514,15 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
 	else
 		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 
+	up_read(&adev->reset_sem);
+
 	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
 		pr_info("manual fan speed control should be enabled first\n");
 		pm_runtime_mark_last_busy(adev->ddev->dev);
@@ -2414,7 +2563,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2423,6 +2572,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		err = smu_get_fan_speed_percent(&adev->smu, &speed);
 	else if (adev->powerplay.pp_funcs->get_fan_speed_percent)
@@ -2430,6 +2581,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	else
 		err = -EINVAL;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2449,7 +2602,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2458,6 +2611,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		err = smu_get_fan_speed_rpm(&adev->smu, &speed);
 	else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
@@ -2465,6 +2620,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	else
 		err = -EINVAL;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2483,7 +2640,7 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 	u32 size = sizeof(min_rpm);
 	int r;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2492,9 +2649,13 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
+
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MIN_FAN_RPM,
 				   (void *)&min_rpm, &size);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2513,7 +2674,7 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 	u32 size = sizeof(max_rpm);
 	int r;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2522,9 +2683,13 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
+
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MAX_FAN_RPM,
 				   (void *)&max_rpm, &size);
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2542,7 +2707,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	int err;
 	u32 rpm = 0;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2551,6 +2716,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		err = smu_get_fan_speed_rpm(&adev->smu, &rpm);
 	else if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
@@ -2558,6 +2725,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	else
 		err = -EINVAL;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2576,7 +2745,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2585,11 +2754,15 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
 	else
 		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 
+	up_read(&adev->reset_sem);
+
 	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
 		pm_runtime_mark_last_busy(adev->ddev->dev);
 		pm_runtime_put_autosuspend(adev->ddev->dev);
@@ -2603,6 +2776,8 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		err = smu_set_fan_speed_rpm(&adev->smu, value);
 	else if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
@@ -2610,6 +2785,8 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	else
 		err = -EINVAL;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2627,7 +2804,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
@@ -2636,18 +2813,23 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 		return ret;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
 	} else {
 		if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			up_read(&adev->reset_sem);
 			return -EINVAL;
 		}
 
 		pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2664,7 +2846,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	int value;
 	u32 pwm_mode;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -2684,17 +2866,22 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		smu_set_fan_control_mode(&adev->smu, pwm_mode);
 	} else {
 		if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			up_read(&adev->reset_sem);
 			return -EINVAL;
 		}
 		amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2709,7 +2896,7 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 	u32 vddgfx;
 	int r, size = sizeof(vddgfx);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2718,9 +2905,11 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
 	/* get the voltage */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX,
 				   (void *)&vddgfx, &size);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
@@ -2746,7 +2935,7 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 	u32 vddnb;
 	int r, size = sizeof(vddnb);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	/* only APUs have vddnb */
@@ -2759,9 +2948,11 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
 	/* get the voltage */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB,
 				   (void *)&vddnb, &size);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
@@ -2788,7 +2979,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 	int r, size = sizeof(u32);
 	unsigned uw;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2797,9 +2988,11 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
 	/* get the voltage */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWER,
 				   (void *)&query, &size);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
@@ -2829,7 +3022,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	ssize_t size;
 	int r;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2838,6 +3031,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		smu_get_power_limit(&adev->smu, &limit, true);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
@@ -2848,6 +3043,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2863,7 +3060,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	ssize_t size;
 	int r;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2872,6 +3069,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev)) {
 		smu_get_power_limit(&adev->smu, &limit, false);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
@@ -2882,6 +3081,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2898,7 +3099,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	int err;
 	u32 value;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	if (amdgpu_sriov_vf(adev))
@@ -2917,6 +3118,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		return err;
 	}
 
+	down_read(&adev->reset_sem);
+
 	if (is_support_sw_smu(adev))
 		err = smu_set_power_limit(&adev->smu, value);
 	else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->set_power_limit)
@@ -2924,6 +3127,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	else
 		err = -EINVAL;
 
+	up_read(&adev->reset_sem);
+
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
@@ -2941,7 +3146,7 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 	uint32_t sclk;
 	int r, size = sizeof(sclk);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2950,9 +3155,11 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
 	/* get the sclk */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
 				   (void *)&sclk, &size);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
@@ -2978,7 +3185,7 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 	uint32_t mclk;
 	int r, size = sizeof(mclk);
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2987,9 +3194,11 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
 	/* get the sclk */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK,
 				   (void *)&mclk, &size);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
@@ -3870,7 +4079,7 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 	u32 flags = 0;
 	int r;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EPERM;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -3879,7 +4088,10 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 		return r;
 	}
 
+	down_read(&adev->reset_sem);
 	amdgpu_device_ip_get_clockgating_state(adev, &flags);
+	up_read(&adev->reset_sem);
+
 	seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
 	amdgpu_parse_cg_state(m, flags);
 	seq_printf(m, "\n");
@@ -3891,6 +4103,7 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 		return 0;
 	}
 
+	down_read(&adev->reset_sem);
 	if (!is_support_sw_smu(adev) &&
 	    adev->powerplay.pp_funcs->debugfs_print_current_performance_level) {
 		mutex_lock(&adev->pm.mutex);
@@ -3903,6 +4116,7 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 	} else {
 		r = amdgpu_debugfs_pm_info_pp(m, adev);
 	}
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e20695b44dbe..ab0883eeadb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1682,7 +1682,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		return 0;
 
 
-	if (adev->in_gpu_reset && ras && ras->supported) {
+	if (atomic_read(&adev->in_gpu_reset) && ras && ras->supported) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
@@ -1796,7 +1796,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	int ret;
 	struct psp_context *psp = &adev->psp;
 
-	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset) {
+	if (amdgpu_sriov_vf(adev) && atomic_read(&adev->in_gpu_reset)) {
 		psp_ring_stop(psp, PSP_RING_TYPE__KM); /* should not destroy ring, only stop */
 		goto skip_memalloc;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ab8e7c91c645..3e534262e381 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1975,7 +1975,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 			amdgpu_ras_request_reset_on_boot(adev,
 					ras_block->block);
 			return 0;
-		} else if (adev->in_suspend || adev->in_gpu_reset) {
+		} else if (adev->in_suspend || atomic_read(&adev->in_gpu_reset)) {
 			/* in resume phase, if fail to enable ras,
 			 * clean up all ras fs nodes, and disable ras */
 			goto cleanup;
@@ -1984,7 +1984,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	}
 
 	/* in resume phase, no need to create ras fs node */
-	if (adev->in_suspend || adev->in_gpu_reset)
+	if (adev->in_suspend || atomic_read(&adev->in_gpu_reset))
 		return 0;
 
 	if (ih_info->cb) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 56beafbd3ab9..2e670aa68758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2093,7 +2093,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 	uint64_t size;
 	int r;
 
-	if (!adev->mman.initialized || adev->in_gpu_reset ||
+	if (!adev->mman.initialized || atomic_read(&adev->in_gpu_reset) ||
 	    adev->mman.buffer_funcs_enabled == enable)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 744404a05fee..da6fa28b1b5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -628,7 +628,7 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *ucode = NULL;
 
  /* for baremetal, the ucode is allocated in gtt, so don't need to fill the bo when reset/suspend */
-	if (!amdgpu_sriov_vf(adev) && (adev->in_gpu_reset || adev->in_suspend))
+	if (!amdgpu_sriov_vf(adev) && (atomic_read(&adev->in_gpu_reset) || adev->in_suspend))
 		return 0;
 	/*
 	 * if SMU loaded firmware, it needn't add SMC, UVD, and VCE
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f826945989c7..336fa8ba2465 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -325,9 +325,9 @@ static inline bool is_virtual_machine(void)
 #define amdgpu_sriov_is_pp_one_vf(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
 #define amdgpu_sriov_is_debug(adev) \
-	((!adev->in_gpu_reset) && adev->virt.tdr_debug)
+	((!atomic_read(&adev->in_gpu_reset)) && adev->virt.tdr_debug)
 #define amdgpu_sriov_is_normal(adev) \
-	((!adev->in_gpu_reset) && (!adev->virt.tdr_debug))
+	((!atomic_read(&adev->in_gpu_reset)) && (!adev->virt.tdr_debug))
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a6170a346b39..b3c1e05da45e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6102,7 +6102,7 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 	struct v10_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!adev->in_gpu_reset && !adev->in_suspend) {
+	if (!atomic_read(&adev->in_gpu_reset) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -6114,7 +6114,7 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (adev->in_gpu_reset) {
+	} else if (atomic_read(&adev->in_gpu_reset)) {
 		/* reset mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
@@ -6463,7 +6463,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 
 	gfx_v10_0_kiq_setting(ring);
 
-	if (adev->in_gpu_reset) { /* for GPU_RESET case */
+	if (atomic_read(&adev->in_gpu_reset)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
@@ -6499,7 +6499,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!adev->in_gpu_reset && !adev->in_suspend) {
+	if (!atomic_read(&adev->in_gpu_reset) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -6509,7 +6509,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (adev->in_gpu_reset) { /* for GPU_RESET case */
+	} else if (atomic_read(&adev->in_gpu_reset)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 33f1c4a46ebe..c70f3bc5cea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4632,7 +4632,7 @@ static int gfx_v8_0_kiq_init_queue(struct amdgpu_ring *ring)
 
 	gfx_v8_0_kiq_setting(ring);
 
-	if (adev->in_gpu_reset) { /* for GPU_RESET case */
+	if (atomic_read(&adev->in_gpu_reset)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
@@ -4669,7 +4669,7 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
 	struct vi_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!adev->in_gpu_reset && !adev->in_suspend) {
+	if (!atomic_read(&adev->in_gpu_reset) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(struct vi_mqd_allocation));
 		((struct vi_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct vi_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
@@ -4681,7 +4681,7 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct vi_mqd_allocation));
-	} else if (adev->in_gpu_reset) { /* for GPU_RESET case */
+	} else if (atomic_read(&adev->in_gpu_reset)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index cb9d60a4e05e..9020a0f40e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3684,7 +3684,7 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 
 	gfx_v9_0_kiq_setting(ring);
 
-	if (adev->in_gpu_reset) { /* for GPU_RESET case */
+	if (atomic_read(&adev->in_gpu_reset)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
@@ -3722,7 +3722,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!adev->in_gpu_reset && !adev->in_suspend) {
+	if (!atomic_read(&adev->in_gpu_reset) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
@@ -3734,7 +3734,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
-	} else if (adev->in_gpu_reset) { /* for GPU_RESET case */
+	} else if (atomic_read(&adev->in_gpu_reset)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
@@ -3928,7 +3928,7 @@ static int gfx_v9_0_hw_fini(void *handle)
 	/* Use deinitialize sequence from CAIL when unbinding device from driver,
 	 * otherwise KIQ is hanging when binding back
 	 */
-	if (!adev->in_gpu_reset && !adev->in_suspend) {
+	if (!atomic_read(&adev->in_gpu_reset) && !adev->in_suspend) {
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, adev->gfx.kiq.ring.me,
 				adev->gfx.kiq.ring.pipe,
@@ -4086,7 +4086,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	 *
 	 * also don't wait anymore for IRQ context
 	 * */
-	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+	if (r < 1 && (atomic_read(&adev->in_gpu_reset) || in_interrupt()))
 		goto failed_kiq_read;
 
 	might_sleep();
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8f29f79f820d..b761bf59ed11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -356,7 +356,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    !adev->in_gpu_reset) {
+	    !atomic_read(&adev->in_gpu_reset)) {
 
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
@@ -381,7 +381,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	if (!adev->mman.buffer_funcs_enabled ||
 	    !adev->ib_pool_ready ||
-	    adev->in_gpu_reset ||
+	    atomic_read(&adev->in_gpu_reset) ||
 	    ring->sched.ready == false) {
 		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
 		mutex_unlock(&adev->mman.gtt_window_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index e18296dc1386..d83b83459ba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -434,7 +434,7 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	int vmid;
 	unsigned int tmp;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EIO;
 
 	for (vmid = 1; vmid < 16; vmid++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index a9e722b8a458..5854df6dcc32 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -635,7 +635,7 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	int vmid;
 	unsigned int tmp;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EIO;
 
 	for (vmid = 1; vmid < 16; vmid++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6e4f3ff4810f..b82a1af86f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -501,7 +501,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
 			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-			!adev->in_gpu_reset) {
+			!atomic_read(&adev->in_gpu_reset)) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
@@ -596,7 +596,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
-	if (adev->in_gpu_reset)
+	if (atomic_read(&adev->in_gpu_reset))
 		return -EIO;
 
 	if (ring->sched.ready) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 5fd67e1cc2a0..fe31cbeccfe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -238,20 +238,16 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
-	int locked;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 *
-	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
+	 * we can unlock the reset_sem to allow "amdgpu_job_timedout"
 	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
 	 * which means host side had finished this VF's FLR.
 	 */
-	locked = mutex_trylock(&adev->lock_reset);
-	if (locked)
-		adev->in_gpu_reset = true;
-
+	down_read(&adev->reset_sem);
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
 			goto flr_done;
@@ -261,10 +257,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	} while (timeout > 1);
 
 flr_done:
-	if (locked) {
-		adev->in_gpu_reset = false;
-		mutex_unlock(&adev->lock_reset);
-	}
+	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index ce2bf1fb79ed..6f55172e8337 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -259,20 +259,16 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
-	int locked;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 *
-	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
+	 * we can unlock the reset_sem to allow "amdgpu_job_timedout"
 	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
 	 * which means host side had finished this VF's FLR.
 	 */
-	locked = mutex_trylock(&adev->lock_reset);
-	if (locked)
-		adev->in_gpu_reset = true;
-
+	down_read(&adev->reset_sem);
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
 			goto flr_done;
@@ -282,10 +278,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	} while (timeout > 1);
 
 flr_done:
-	if (locked) {
-		adev->in_gpu_reset = false;
-		mutex_unlock(&adev->lock_reset);
-	}
+	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e9b96ad3d9a5..393642c32387 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1482,13 +1482,20 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 
 	/* Flush TLBs after waiting for the page table updates to complete */
 	for (i = 0; i < args->n_devices; i++) {
+		struct device_queue_manager *dqm;
+
 		peer = kfd_device_by_id(devices_arr[i]);
 		if (WARN_ON_ONCE(!peer))
 			continue;
 		peer_pdd = kfd_get_process_device_data(peer, p);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
+
+		dqm = peer_pdd->dev->dqm;
+
+		dqm_lock(dqm);
 		kfd_flush_tlb(peer_pdd);
+		dqm_unlock(dqm);
 	}
 
 	kfree(devices_arr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index dd550025d1c1..0b5409cede52 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -304,15 +304,17 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
 {
-	/* On GFX v7, CP doesn't flush TC at dequeue */
-	if (q->device->device_info->asic_family == CHIP_HAWAII)
-		if (flush_texture_cache_nocpsch(q->device, qpd))
-			pr_err("Failed to flush TC\n");
+	if (!dqm->is_resetting) {
+		/* On GFX v7, CP doesn't flush TC at dequeue */
+		if (q->device->device_info->asic_family == CHIP_HAWAII)
+			if (flush_texture_cache_nocpsch(q->device, qpd))
+				pr_err("Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+		kfd_flush_tlb(qpd_to_pdd(qpd));
 
-	/* Release the vmid mapping */
-	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
+		/* Release the vmid mapping */
+		set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
+	}
 	dqm->vmid_pasid[qpd->vmid] = 0;
 
 	qpd->vmid = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 013c2b018edc..71be897d4c2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1551,6 +1551,10 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 void kfd_flush_tlb(struct kfd_process_device *pdd)
 {
 	struct kfd_dev *dev = pdd->dev;
+	struct device_queue_manager *dqm = dev->dqm;
+
+	if (dqm->is_resetting)
+		return;
 
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		/* Nothing to flush until a VMID is assigned, which
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b4e120e95438..db332282c01e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1640,7 +1640,7 @@ static int dm_suspend(void *handle)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	int ret = 0;
 
-	if (adev->in_gpu_reset) {
+	if (atomic_read(&adev->in_gpu_reset)) {
 		mutex_lock(&dm->dc_lock);
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
@@ -1826,7 +1826,7 @@ static int dm_resume(void *handle)
 	struct dc_state *dc_state;
 	int i, r, j;
 
-	if (adev->in_gpu_reset) {
+	if (atomic_read(&adev->in_gpu_reset)) {
 		dc_state = dm->cached_dc_state;
 
 		r = dm_dmub_hw_init(adev);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fe4948aa662f..69134a0d660c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1341,7 +1341,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	uint64_t features_to_disable;
 	int ret = 0;
 	bool use_baco = !smu->is_apu &&
-		((adev->in_gpu_reset &&
+		((atomic_read(&adev->in_gpu_reset) &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
 		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 3b8839641770..13e304066d94 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -484,7 +484,7 @@ static int vega20_setup_asic_task(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	int ret = 0;
-	bool use_baco = (adev->in_gpu_reset &&
+	bool use_baco = (atomic_read(&adev->in_gpu_reset) &&
 			 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
 		(adev->in_runpm && amdgpu_asic_supports_baco(adev));
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
