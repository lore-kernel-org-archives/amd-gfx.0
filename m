Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D11CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5662D22BF5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zVnbb2ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5662D22BF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CBF26E92E;
	Thu, 20 Aug 2020 09:32:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1276E92A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 09:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO8JrsC4T8zpbqWTF4LqtkECUurWHBwjA/gIGhK18MGL8QDXTO0Ea8T+b2YrejbdIwWzgan/Qkz/lZkJn0z4gdMiNwHxioyhD7H3q9Fcd/3Jpwqxh1/WTTHEfJU1M0+aOxrYzoLnaMRuiJcnzu9sbHDJHVnwWdJ12Coe6vC0zNIHnzCUPVdnjXd9l4iaa990If7t1vvk7BdJA4J3hUSjXIT7Mrk3z5Jx0qeWKsiyKxLdTy/di6W3Mynn1AF3Yc3LflWrjATwuyGdYhWlhZLRWAwaBE2oePkfajCXRCyh78qLQWy8Zc42VYbgOo+89qrFJk4Tpl7Fz6NBIoO62ATapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fZcsz5I9SOXwV3aQbOePUl6t9y9DLSHjcbmIxBqM3k=;
 b=iYr7muFBpkWFPmQrk5O0vJ/BzqYVBMso9CiSpcsnSSXRBxPdeumKRE0n2HZc1zKJP12biYjF0GQdMifYSTB3SKPotZcGnqBvHV8U/DQiVJ4WcdjAPKMglqpCVvKv1ACxuI383qSM/sgIkuc8d+G/TJ0qc9/OEvOKhaFBZY1qX/z+HR3lU9Ga0JWamfFBEqZMuNXyTNtNGWlNKTQnqroVBflrbFAHaSbg2h8ts65FGd8idTSMbrVqT64L62zXGq1ZfSDNHQPsGlZE7pnu6CaCNYE5LgQ+wBXenNn+cDI29oMAuGar+DSeZAKIwnk+L8jbCUVdeCiSuYBPVRTqRPU0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fZcsz5I9SOXwV3aQbOePUl6t9y9DLSHjcbmIxBqM3k=;
 b=zVnbb2olsvZ09SiZCnyJ10ROlwUvlD8peTz/+eaEXOPdFWVO/iRUJ52U7uG8cRu0I3bhf0PFMgCRGneXY85/mGwdcs+1uQRkBgsVLraCvs4nI+nzK9B+RrPG8tXkIyeC+FBCr0whQ0++jswjMNWpkpC8tW0D8c7cZ7ao3STezmg=
Received: from BN6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:405:2::17)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 09:32:51 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::2) by BN6PR11CA0007.outlook.office365.com
 (2603:10b6:405:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 09:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 09:32:48 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 04:32:48 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 20 Aug 2020 04:32:46 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: change reset lock from mutex to rw_semaphore
Date: Thu, 20 Aug 2020 17:32:38 +0800
Message-ID: <20200820093238.14013-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cd0554d-6aa1-495f-4c9b-08d844ec00af
X-MS-TrafficTypeDiagnostic: CH2PR12MB4056:
X-Microsoft-Antispam-PRVS: <CH2PR12MB405693CEA6FB7351AD2D3997ED5A0@CH2PR12MB4056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TZ/8XGpopxBPwQz/d8QbzRoGUWWkhdIJGoMQIbFszbFlBPZ1y9+bA/cWrasNFivQfLkW+HKeGPIX7wwS7IBOI8FNfNm8HdKgvqcXHH/vOoLKhdnTSIGeF6mJHHMWz3CUOCZKOEY7AUK6/vNwukY6goEKjgXls2fDtYEWlI6S2Zslfn3LNFA197CuK/uIWW9IUIN2kvHSQWc9OHgYBdlS5VXw89pzeaAR99qxfR5yPz2Qvi6pTJRS0YlxBmJtfNLdxDYTw4dei2zGI/xEC8/xW1LhycIobp33gcs4bdbJ+yeSTAub7FgzTpK871/plFN6J4B2aMppP0BuQEi+GTYVuJAcSLmDv9z5yFgQYo3Od7R1ydoepCmE76OpcvPVUi9WMhQ7TN57ZfkZNxnj+7D5tDio2z+oW/dKjeBU24nT7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(36756003)(82310400002)(6636002)(6666004)(8676002)(86362001)(47076004)(186003)(83380400001)(4326008)(26005)(316002)(356005)(2616005)(5660300002)(81166007)(478600001)(426003)(110136005)(336012)(82740400003)(70586007)(1076003)(7696005)(2906002)(8936002)(70206006)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:32:48.6954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd0554d-6aa1-495f-4c9b-08d844ec00af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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
