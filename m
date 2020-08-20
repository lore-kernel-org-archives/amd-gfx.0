Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5B3C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00112075E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZXLSUY6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00112075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2C86E930;
	Thu, 20 Aug 2020 09:35:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143B56E92E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 09:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q33UOZlPdzuC8jZeSA6cfPG6L62UeKW9bpv8aDN2z/Jvv0e9Jrm+3DZUj9oAncPr+yPmpS3l/Af8gvOppXfTqRw8YC9MmgEgIUPlI3btq0hrU6+0NtdCKUh5qnBdAdjBXqb0GZPl5/ezbs3t7HNfh7TxVbYBS3y1V4G2X6Uuh2j7ifls3VFKh4Yq4fhkSlvz5id2U2NUxO0F37Dc1kfpDmrsAddUarRiEcjHEQ8aaIIMfVy10zPjpNg5mw7ONPl9Mkv2QqV/MB2as8wzrLl7fVgeoX9TQzOjyxwCtfCSiUbCEIfyOxdokvNxE5Sa/6m4IbPtsXHf6eDb5NaMr2TxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58kliQzlDtDv0RWIDOzKWE/5BOdt+XgZJLov0dshOe4=;
 b=d1bdOX8uDBzcluxw39CI7R9SDgVUQILGJ94PR47RuPf5uyNpugO3bgN8V50l3ZD5J12p6N9TV5e6kFgjMJq7eGv/3O6v2fG0ys26pUXGjRzzftrA+nkCnzDlfaAWvMaPiFG5dAg9R0LKvPERdKDwlkaDhBrPtN5/NR8jX7mxZ1nVHYzpzN417fPJk43GBoGfx1nX+d9M5zvMj2yKMiDasUCEpdhiOGoaTJ2OO4bKWkFekTia7oeiHBLFRInGPNX/JRoryTJxFiHH+8tMSViYF4+gBW5DDb22k+ylIoH2kF3FW+vIa+brJFa3Bg/Moqzcn62QBZi5OBrnuK+KNmUG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58kliQzlDtDv0RWIDOzKWE/5BOdt+XgZJLov0dshOe4=;
 b=ZXLSUY6YRX3rBCLQ6bM6y+kdCZ2cyg+u6O9F/AFHYWO8XAL90ukDxNnQk6vB1r0fil2d6l7dvMigtU0hZWsS7IAF0x6Cl4T5RvVpw9Bg+O9sa9QHiIb/Bt9+FqtzwXi8aVb2ScecYztTJCgz9ijE1YK/nOVa03yfVhNeiPAY2HQ=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 09:35:50 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 09:35:50 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: change reset lock from mutex to
 rw_semaphore
Thread-Topic: [PATCH v2] drm/amdgpu: change reset lock from mutex to
 rw_semaphore
Thread-Index: AQHWdtThz6ypY7lLXkGLpkZF9cD8nqlAvE5Q
Date: Thu, 20 Aug 2020 09:35:50 +0000
Message-ID: <DM5PR12MB253398E6035DA819CCB4CB04ED5A0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200820093238.14013-1-Dennis.Li@amd.com>
In-Reply-To: <20200820093238.14013-1-Dennis.Li@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-20T09:35:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2a5f30f1-6e6c-4ce7-8528-860611270ef9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19264d3b-2a04-441e-cc58-08d844ec6d07
x-ms-traffictypediagnostic: DM6PR12MB3001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30016F643BAF71D80C856030ED5A0@DM6PR12MB3001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVG+SNEN5DyCby12wU2fvMd8agC9h/S45MjcGW3BxQOwVbjsdNAymT9KvEppSKCuYVvcM3IJlu1yrEapGYEE9SNsmM22JLvJ8HBjbBoQred6Zni7u4gWfuwfoHkb8dKBYkgI92kFj8whMbTi/zShTpApxDxp2Ci5PMw39zQN+ZihZMZTxNYk7cwbFqjQqGmmTtFdMaATvCGfq+TofMwAuhvBPQWezdzSkMJjhZMLhEpjpKJZTjIiiI5G8ZP/xz+dE3nOelm0tFXdzlloBqzU0Gza6pG+xxnylh+vM75PlaAGSVox4YsGgUyR1dTi7DFOWfgeruR6yIg/+Z3hm9GVLx5JN/LRbvIkbGQU6TiVxyi2bOBzD2VSdbmMJ1mzCp60
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(186003)(6636002)(71200400001)(7696005)(83380400001)(54906003)(4326008)(110136005)(86362001)(316002)(9686003)(55016002)(2906002)(6506007)(66476007)(52536014)(26005)(66946007)(53546011)(76116006)(33656002)(8676002)(5660300002)(64756008)(66446008)(8936002)(478600001)(66556008)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /q6Bs4QR9YTDrxbUsmZuYtsjEV7/5rMoLv3HIQ3JXpWelmrhOWvyVse1iFFdxpFKLQ64aSGc2craK24iK9gL2RUPK0opPjHDo5v+qfrb+ps4PD7Gjg/LmE2giBUOa3Qse/tU+yi8VlCHxncffYMglxHIZrAaklT1xR6JQAsvxEshF5thHTB65PecZy6hjvKZv/xIX8ErbgviBS9TK7RV+jpZNkC11OSkULnePZoCTWo8rqltUD+5pMjPmXCzho6VEYPi5g80rp+hoPWO6ehCtUir0EkwVi10Mmzd+sdYYuaY30+ZQJ5L0U5jtNrwSY/9mUnUAjdM3sWMMRds8xqUIMoQ88YFlopUkht7ZiVwdBzvroquxHrANr9BdiisLiQzb3o//dmAX50fDq5l+Cq3xeq4AtAmBltf4xG2o31Q8mx0KnKhUVg4VkxkFqSL+kNdvunOKJPYz7r41AIkIuYoAdaSf0vNdHqY+aqhdXdVP+a6AwdkAUsvF1G2vlQv6SmpabXztOxGUOD/KJcHVcW8LtU7JlOzAiK1ySO6mBNohLfRLo7q+3DTme5Yfkfz5EBW3/kFriTeTxGF6BEWGCTU5nWMybC55iDPx45LJ5smmPLWh6CTbCHfoZy3Lim4lYcUvdiE8PCMWoNuFmP3+hRnZg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19264d3b-2a04-441e-cc58-08d844ec6d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 09:35:50.1015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NawL5jDbJ++DUkmFT458SZlohewNAzc/mn8RAt3UjZlJboyB8Dikq0ql1JEvs+4a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
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
Cc: "Min, Frank" <Frank.Min@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Frank and Monk,

Can you help review this patch? Because it also changes some virtualization related codes.

Best Regards
Dennis Li
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Thursday, August 20, 2020 5:33 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: change reset lock from mutex to rw_semaphore

clients don't need reset-lock for synchronization when no GPU recovery.

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
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) { @@ -1269,7 +1275,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
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
 
 static int amdgpu_debugfs_sclk_set(void *data, u64 val) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
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
 	switch (amdgpu_asic_reset_method(adev)) { @@ -4229,7 +4229,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 	amdgpu_vf_error_trans_all(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
 	atomic_set(&adev->in_gpu_reset, 0);
-	mutex_unlock(&adev->lock_reset);
+	up_write(&adev->reset_sem);
 }
 
 static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
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
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) @@ -261,10 +254,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
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
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) @@ -282,10 +275,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
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
