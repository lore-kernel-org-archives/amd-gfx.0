Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E0DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 02:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7532078D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 02:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7532078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3D96E88E;
	Thu, 20 Aug 2020 02:09:57 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB60B6E88E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 02:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYFpR2tyh1oyARMwdQbYeGunqIBjOiHWPstLHyb+awXaCuvXTNVHZq5Jqr3ndQkm/Mbvjre7l0EbcRACJrg9IF5RMcE8lFMv7uc3amcnNE7Hs88d2570HeBJHv45UWEAw9N0WdY1YAkXh/wm1bxWWswBPHfItKK0G6kcarFnk4BvRPXWwFJ/eFBXzUY/e5yz6R34fbNEQ0GEIhpOYoa2kU9+gh21PjwFNTPOu46ribHbHD4GaNw9e0nLb4g7Hkhgc00x+Hkh/DRM9JQSnCGQyYOLdML7MzdtFU0zn3xZm3JJsOK44OgGtFavtWfAoicRk8HsiDEH0hcBhExqSirxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZCSTyxP3sIaCwojz6OtOhD4N3NrYxU6oQa5UNOYYzE=;
 b=CU7Sgn8DvBTdYFWslY9JInYnNrNeUDFNMEVtMnK+oFEx28r6ORY9l+SYv5862uAaILvsNjEUgN80rl6oMYUAcVVKVxUY902QRxL5ipSqnNLcm4torBCV4E65Nixds+c1j3WbNShzvk7nlELqnRrQJ0rdPNj+q3JSX4Z6kas89a0X7uf0tvfNsd1cD9qjCRPCC7rb0nICrU22LbcO73oHezUnHKizJFtwVtqKh4NW3zXvMcOMYrNLkrO0CMfJFGHwpplTXaLMueQgoIqIfqs0JuVT5mr9Xu/DY5AlULPyx4FS19dV5AZaMe13j43wbdQlvCX4n99YJ+DxmIqj7a6PjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZCSTyxP3sIaCwojz6OtOhD4N3NrYxU6oQa5UNOYYzE=;
 b=q1YI/F2g9jji04EOpjbIvTrUrvbRRPxJRZ86WmD/LrtsOgQLDXmqmz8WAMQapRItXj+RZg+IilljriEc1CJDMIJhDpXh5u4mxeR8ibZmrn6duraCSzI0U4zaEkDxSeG3FcdpOPyoWgg318de5BoAy1/1MPuL66RBY0rcs4tVZHo=
Received: from BN6PR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:405:4b::17) by SN1PR12MB2431.namprd12.prod.outlook.com
 (2603:10b6:802:27::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 02:09:54 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::bf) by BN6PR1401CA0007.outlook.office365.com
 (2603:10b6:405:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 02:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 02:09:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 21:09:52 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 21:09:51 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 19 Aug 2020 21:09:50 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: change reset lock from mutex to rw_semaphore
Date: Thu, 20 Aug 2020 10:09:41 +0800
Message-ID: <20200820020941.10988-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75355f48-64f2-49a0-a02f-08d844ae2011
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2431D4D57EB4DAC02BC142C2ED5A0@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIYOM3E3oa/S6jOEJz6djKs5ap101oHesIs9ppW1oqGOjg0b0WbsXn6zWHbqY33MohdOPoxq2dnP1il28tsi29TzAsKrYBpRGH+vHrscV5dHX7hKcHhYyIjSH95JhOytuHGAEXyUkgIaLpD2WSNA6QEy5WaZ3SVUtSWfU7ZUR3Vs9SFh/xk9TeZ/m1+HVrchpAsjzMAnhNpB/lh9HJmNJskyTfFzye0hAt2ZN6mM89xuJUqbTELu0GwKaoam+ScdG1ZlEeZz/GxoLRqMeXgi5+56dhY7Vi6DqXwgdBB57HXVT2Kh+O/HdfdaY1kT6rx6T+irhq2RC0tGwYJ4cNcTm8PbYrktqE2JL2BmLC0oCyeuozjsybeEtZ9pr1SvZeMSWVEF170HuTRKhVagqm491dDZ5mkG1ib6ahxFQlWBSZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(2906002)(26005)(186003)(86362001)(7696005)(316002)(426003)(5660300002)(1076003)(36756003)(110136005)(8676002)(2616005)(6636002)(47076004)(70206006)(82310400002)(70586007)(478600001)(82740400003)(8936002)(81166007)(4326008)(356005)(83380400001)(6666004)(336012)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 02:09:52.5519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75355f48-64f2-49a0-a02f-08d844ae2011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
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
index 79b397800cbc..0090e850eab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -101,14 +101,17 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
 
 	file->private_data = adev;
 
-	mutex_lock(&adev->lock_reset);
+	if (down_read_killable(&adev->reset_sem))
+		return -EINTR;
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
@@ -1242,7 +1245,8 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	if (down_read_killable(&adev->reset_sem))
+		return -EINTR;
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
@@ -1269,7 +1273,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1459,7 +1463,10 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -ENOMEM;
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	if (down_read_killable(&adev->reset_sem)) {
+		kfree(fences);
+		return -EINTR;
+	}
 
 	/* stop the scheduler */
 	kthread_park(ring->sched.thread);
@@ -1500,7 +1507,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* restart the scheduler */
 	kthread_unpark(ring->sched.thread);
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
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
index f27d83f2de78..8ac63f13fc6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -238,19 +238,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
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
+	down_read(&adev->reset_sem);
 
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
@@ -261,10 +254,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	} while (timeout > 1);
 
 flr_done:
-	if (locked) {
-		atomic_set(&adev->in_gpu_reset, 0);
-		mutex_unlock(&adev->lock_reset);
-	}
+	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 3cb10ab943a6..bcc583f087e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -259,19 +259,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
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
+	down_read(&adev->reset_sem);
 
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
@@ -282,10 +275,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	} while (timeout > 1);
 
 flr_done:
-	if (locked) {
-		atomic_set(&adev->in_gpu_reset, 0);
-		mutex_unlock(&adev->lock_reset);
-	}
+	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
