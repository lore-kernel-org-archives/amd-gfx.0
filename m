Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFADC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8490364EBD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8490364EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C446E896;
	Thu, 18 Mar 2021 07:24:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B046E896
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erXurFqPA0ERFAJzW/zZtlN9YexRG//lzfNe8jZ16mBWW0U7cYjIm5VZhHfD/I77SDzW56GTFQLNB2o23tkGZ1K4N87WbVpYZUia9GcnujHomZv1qyVz94QNqIg9mvyKf//zUvVd5Es8Dm1EsH6g7wRMDXYzaYZQhkn5AuEEx1aFMklM6ixQViwu6RIWFBbPJp77oqgIC4cUiudyRLGh84Csq7NMkX4xLXfjlOmeK9y1E0CYCB8bLHJuFgjhYAJwPLDSGc4ELnbhtjiPuVvrU1qTCL7K41IYi+tVxyMwm5z7A5F2YWDmt8aH7hqpEEIyke1qHeff4z5g+q7vrm1Emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh7mtpH5IaObAY6s9Tl34GqkQnqvKijYXUNoEPqYsZs=;
 b=hYZKK4U1ViiaGqypPm5lMm+zgIuVWmHic0e2Z1u4X3didBuy5J+zvd34BxZ8UTOwHjozJa0UYCevKmXrIICnzXs2mIcktoSXNuxwTeO/77S4Wzhjgpm2qahTpq/dmbIU82NcjoLUuKDO04bWk0v9Z81ojGgFh7Z26X21mQ/J9OB9GOYlb4aG/3fi6+obv9ZMc85siM1/YTh0/uWMbaYc7qCYA0YS/kDIPX1O64RvQ/n2sUxjMXtdNHCCm854i0bsGxKPIJ0UbZaWI+1sRAeAEs7ZudNCX67HllQq2Cng/mbSS9V9i6ERE1InLk6UKppOvF7iQFH1XVs/plUtrxpo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh7mtpH5IaObAY6s9Tl34GqkQnqvKijYXUNoEPqYsZs=;
 b=b7+a2Cu6cB0++j8YsxtMivCxkTjqgd0ForDjuBsg3EOGvn55IK4TZ05wJVz21rl6A5gfbbUCDmdxAghkBpGlWh6Vsx/JFeQqedDsQE0hM1dmXGEUWYWEybxdVDmvPLrg4ZYKX+WYL4EUwna9jcPzvHldP3lovHtwawojRYczvSU=
Received: from BN6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:405:2::30)
 by MWHPR1201MB2525.namprd12.prod.outlook.com (2603:10b6:300:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:23:57 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::e) by BN6PR11CA0020.outlook.office365.com
 (2603:10b6:405:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 07:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 07:23:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:55 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 18 Mar 2021 02:23:53 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: instead of using down/up_read directly
Date: Thu, 18 Mar 2021 15:23:38 +0800
Message-ID: <20210318072339.28736-4-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318072339.28736-1-Dennis.Li@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4ab6fb-83ec-47e9-557a-08d8e9decaa5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2525:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2525F5EF6B390587237DFF5FED699@MWHPR1201MB2525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qo2/jKWyht2xCvR0mb6WEKEEwnXP3y4FQ50wQUSypY04ag1AjZR4w/CR9Ae3iXeO12ng3tZUneAMI+9pOUJ8v6oT8c8JwHHoQFsbTVrrWwsxrkpp5Vwwr/L5qyiIX4RGplHsNWFry2PN+phgd7/0tHyfoSMKmFWpx+BURuzcn2JGr5tpMHUaCyvrw8Y8wCYbGcTo8cIHzwZA2O/GrzDAIhdi6CuiM6F7oau9xr4R50p4+Tr6Z5lV0ult/xkT+ne+sV3bdszXgELnB8uG/Q929ybT9qFQj+MRjc08AOMNhcLp59GJRIixXPQNgfmiTz8cmZnHxCbBQfrGJDJc1O0p9e9V1WhObmvcfd+BL09MJN/aV6jY6eCLG0kOyhliHsEzmgBXfIK9M3gYhegxZNsPsvrV8kl2hNDEAeRG9baz8J523kggKNl9SmceK7SEaBn52+tVddeHD9GbkrJvhLs4KeH8W3ClBwg2qeDYqgbuDpWcancLuR14SMgIu16ryMcYjHWTuRnYWBOek3rcBAPVHCTEzC0BNi8P00VLrWoLFX+FPNbBL6bwtgkJE9L7lh/mCns1O4f90sRm4hVYfxCqe72M7rFwNnz/x5XcugwSIPLRIzo+DwIw9J8QIYTw6VpEVQ93zowFryh1rsbG7pxU49G850uWUL8pkaQUPzvVOWnLbIvKJnqQaGSq4wGyq7wcylZyfbKpsf2MB2xmL+A6zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(70586007)(8936002)(26005)(5660300002)(186003)(6666004)(70206006)(8676002)(81166007)(1076003)(426003)(356005)(2616005)(336012)(47076005)(82310400003)(86362001)(2906002)(82740400003)(83380400001)(36860700001)(7696005)(36756003)(478600001)(4326008)(316002)(6636002)(110136005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:23:56.4249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4ab6fb-83ec-47e9-557a-08d8e9decaa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2525
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

change to use amdgpu_read_lock/unlock which could handle more cases

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index bcaf271b39bf..66dec0f49c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -59,11 +59,12 @@ int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
 static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
 {
 	struct amdgpu_device *adev = inode->i_private;
+	struct drm_device *dev = adev_to_drm(adev);
 	int ret;
 
 	file->private_data = adev;
 
-	ret = down_read_killable(&adev->reset_sem);
+	ret = amdgpu_read_lock(dev, true);
 	if (ret)
 		return ret;
 
@@ -74,7 +75,7 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
 		ret = -EBUSY;
 	}
 
-	up_read(&adev->reset_sem);
+	amdgpu_read_unlock(dev);
 
 	return ret;
 }
@@ -1206,7 +1207,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_read_killable(&adev->reset_sem);
+	r = amdgpu_read_lock(dev, true);
 	if (r)
 		return r;
 
@@ -1235,7 +1236,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	up_read(&adev->reset_sem);
+	amdgpu_read_unlock(dev);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1427,6 +1428,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	struct amdgpu_ring *ring;
 	struct dma_fence **fences = NULL;
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	struct drm_device *dev = adev_to_drm(adev);
 
 	if (val >= AMDGPU_MAX_RINGS)
 		return -EINVAL;
@@ -1446,7 +1448,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -ENOMEM;
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_read_killable(&adev->reset_sem);
+	r = amdgpu_read_lock(dev, true);
 	if (r)
 		goto pro_end;
 
@@ -1489,7 +1491,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* restart the scheduler */
 	kthread_unpark(ring->sched.thread);
 
-	up_read(&adev->reset_sem);
+	amdgpu_read_unlock(dev);
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 3ee481557fc9..113c63bf187f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -247,12 +247,13 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
+	struct drm_device *dev = adev_to_drm(adev);
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_read_trylock(&adev->reset_sem))
+	if (amdgpu_read_lock(dev, true))
 		return;
 
 	amdgpu_virt_fini_data_exchange(adev);
@@ -268,7 +269,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 flr_done:
 	atomic_set(&adev->in_gpu_reset, 0);
-	up_read(&adev->reset_sem);
+	amdgpu_read_unlock(dev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 48e588d3c409..2cd910e5caa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -268,12 +268,13 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
+	struct drm_device *dev = adev_to_drm(adev);
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_read_trylock(&adev->reset_sem))
+	if (amdgpu_read_lock(dev, true))
 		return;
 
 	amdgpu_virt_fini_data_exchange(adev);
@@ -289,7 +290,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 
 flr_done:
 	atomic_set(&adev->in_gpu_reset, 0);
-	up_read(&adev->reset_sem);
+	amdgpu_read_unlock(dev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
