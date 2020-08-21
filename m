Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90006C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D53B20758
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3YgnW/9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D53B20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B526E0E4;
	Fri, 21 Aug 2020 03:47:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B2F6E0E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 03:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiLaqMqt3+DLHZZP0lNKw5dcH8U86sYSQ1oqYERybAF7a5g0WC5UNYiqx0uSRXR5xGP+Vu6Y3YLdkhoXo5fcze0Y2HDWSvVEkCGbl6ezU31bfRUqIW3qoVAE+AdLb4o1OZFQP9GVxphAGZROmIMOne6EbouTG8KN3pI3btn3t5uXtWrFLKxTnzxAo3cRz+TQL6qrFIFND+xMVu+hsmJg8YSIJXoy3x9fn+MNobPxsnGvfeMMakNlY0wio92RWB+FxOH3/vQjWaGFItveaVo9FaQ0pTi8A/3lhyKy/+5a3x6xbqIfviR4FhrKgNCVGZEm8LPmAuPbVTiT0NavTv4LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ3lQwQlzIWj/APnp4PbE3SwvAKS9kd1DzWlpGZNXv0=;
 b=C6/ibnEOO6X64rkvVAu5pVR33bHiBh8r0JtYHGcq9xYAhR9BbO5rYEsHVn6Pm2z9UN9LNOaBc+7bJ0HC3Qva55NHhMrlENoUtnNe4mMx2fOH/zlzFqu5eH/1VW0rxVazVGgEIVNxmCyVFGAP9xmWvcJ3OiBwFGKSNldEqa5j0M67lMAYPlFWjLIkJWjsLG/9JEho5IBXdmsX2nwU3ot+KQJweuFP2VA5bAkzrn3z6PYulBmGIJ8iazAwft8Smd8+IjbTBncsbZrE6Dkd1ggDUFEky4g4L4dNdj9flJKrjOOw6By4cQNp5Hsnh6qekObVSxar8lWqmMZ0f5hUujI4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ3lQwQlzIWj/APnp4PbE3SwvAKS9kd1DzWlpGZNXv0=;
 b=3YgnW/9ZC3vLTqD2dW4XatkBzKi/1ncWLf9OU2BdH+vPjJjv9jGZEpjuSpAs9NCYrnPwFRCFD4gUxUFq4X4UxW2/dcnLAEg8DTE8ZCA5qZD8PM6r5Nt48kNvbe87XKjieLBJt8KRj5QMeHah5OCUnccYwqtz84hmYe9TrwXZqoM=
Received: from MWHPR11CA0025.namprd11.prod.outlook.com (2603:10b6:300:115::11)
 by BN8PR12MB3060.namprd12.prod.outlook.com (2603:10b6:408:4a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 03:47:49 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::9f) by MWHPR11CA0025.outlook.office365.com
 (2603:10b6:300:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 03:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 03:47:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 22:47:48 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 22:47:47 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 20 Aug 2020 22:47:46 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>,
 <christian.koenig@amd.com>, <monk.liu@amd.com>
Subject: [PATCH v3] drm/amdgpu: change reset lock from mutex to rw_semaphore
Date: Fri, 21 Aug 2020 11:47:36 +0800
Message-ID: <20200821034736.27106-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ec4187-72d9-45c8-7ebe-08d84584f94b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3060:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3060855592CD1BC219980A64ED5B0@BN8PR12MB3060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9umpFEnolNZUxX88BqFDyW/Jx2do79L2FSj8+JOybzwcVGt2ZL2O7mewuKuc+1tN1gR6qGgDk01U61QdAMrWptjwUtcSU9Pi1ZJqx58I/jlrKnBnamvNyss0oJ5P/5xXL27FM/FOKGwGDKorgkOlD//vFgSMMUzVYobqEz7J/HKh7XLge8BOhxbsqIJfKy+6u9FfxgkLTon0ZSKSPfKPJhvws94WnSWyiY4S3eIUUkfzTW6pZogkB6oI0J5CFg08nATxEXQLQFdJYCG6yZWCOfF5g1CAfknGYinfII3UBNHh9iqjLyVzAUqLN+wmckno49KtTED8KA5RKapeoCnFh+Q/b2xdiXC5mhiKCi93Ua8V6rwCusthVmIeXb9yKFB/Z/mWhj79g3aK1o5IZ64hAN/JNmPhgaATcu+aRkZy/t8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(1076003)(336012)(8676002)(86362001)(36756003)(2616005)(426003)(5660300002)(70586007)(70206006)(8936002)(478600001)(4326008)(2906002)(316002)(110136005)(82310400002)(81166007)(6666004)(356005)(82740400003)(47076004)(186003)(7696005)(83380400001)(26005)(6636002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 03:47:49.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ec4187-72d9-45c8-7ebe-08d84584f94b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3060
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

clients don't need reset-lock for synchronization when no
GPU recovery.

v2:
change to return the return value of down_read_killable.

v3:
if GPU recovery begin, VF ignore FLR notification.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c8aec832b244..ec11ed2a9ca4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -954,7 +954,7 @@ struct amdgpu_device {
 
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
-	struct mutex  lock_reset;
+	struct rw_semaphore reset_sem;
 	struct amdgpu_doorbell_index doorbell_index;
 
 	struct mutex			notifier_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 79b397800cbc..cc5c7f81c540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -101,14 +101,18 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
 
 	file->private_data = adev;
 
-	mutex_lock(&adev->lock_reset);
+	ret = down_read_killable(&adev->reset_sem);
+	if (ret)
+		return ret;
+
 	if (adev->autodump.dumping.done) {
 		reinit_completion(&adev->autodump.dumping);
 		ret = 0;
 	} else {
 		ret = -EBUSY;
 	}
-	mutex_unlock(&adev->lock_reset);
+
+	up_read(&adev->reset_sem);
 
 	return ret;
 }
@@ -1242,7 +1246,9 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	r = down_read_killable(&adev->reset_sem);
+	if (r)
+		return r;
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
@@ -1269,7 +1275,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1459,7 +1465,9 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -ENOMEM;
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	r = down_read_killable(&adev->reset_sem);
+	if (r)
+		goto pro_end;
 
 	/* stop the scheduler */
 	kthread_park(ring->sched.thread);
@@ -1500,13 +1508,14 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* restart the scheduler */
 	kthread_unpark(ring->sched.thread);
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
+pro_end:
 	kfree(fences);
 
-	return 0;
+	return r;
 }
 
 static int amdgpu_debugfs_sclk_set(void *data, u64 val)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 78fd2c9a7b7d..82242e2f5658 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3054,7 +3054,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	atomic_set(&adev->in_gpu_reset, 0);
-	mutex_init(&adev->lock_reset);
+	init_rwsem(&adev->reset_sem);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 
@@ -4206,7 +4206,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev)
 	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
 		return false;
 
-	mutex_lock(&adev->lock_reset);
+	down_write(&adev->reset_sem);
 
 	atomic_inc(&adev->gpu_reset_counter);
 	switch (amdgpu_asic_reset_method(adev)) {
@@ -4229,7 +4229,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 	amdgpu_vf_error_trans_all(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
 	atomic_set(&adev->in_gpu_reset, 0);
-	mutex_unlock(&adev->lock_reset);
+	up_write(&adev->reset_sem);
 }
 
 static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f27d83f2de78..9c07014d9bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -238,19 +238,15 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
-	int locked;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
-	 *
-	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
-	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
-	 * which means host side had finished this VF's FLR.
 	 */
-	locked = mutex_trylock(&adev->lock_reset);
-	if (locked)
-		atomic_set(&adev->in_gpu_reset, 1);
+	if (!down_read_trylock(&adev->reset_sem))
+		return;
+
+	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
@@ -261,10 +257,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	} while (timeout > 1);
 
 flr_done:
-	if (locked) {
-		atomic_set(&adev->in_gpu_reset, 0);
-		mutex_unlock(&adev->lock_reset);
-	}
+	atomic_set(&adev->in_gpu_reset, 0);
+	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 3cb10ab943a6..9c23abf9b140 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -259,19 +259,15 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
-	int locked;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
-	 *
-	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
-	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
-	 * which means host side had finished this VF's FLR.
 	 */
-	locked = mutex_trylock(&adev->lock_reset);
-	if (locked)
-		atomic_set(&adev->in_gpu_reset, 1);
+	if (!down_read_trylock(&adev->reset_sem))
+		return;
+
+	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
@@ -282,10 +278,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	} while (timeout > 1);
 
 flr_done:
-	if (locked) {
-		atomic_set(&adev->in_gpu_reset, 0);
-		mutex_unlock(&adev->lock_reset);
-	}
+	atomic_set(&adev->in_gpu_reset, 0);
+	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
