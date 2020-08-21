Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BF8C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15675207DA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k24b4W7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15675207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF666EA92;
	Fri, 21 Aug 2020 06:10:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A26C6EA92
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 06:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIwiP5IztcclUu987rzjQalplkvD53gq/gT5N2lDYSzSfCxiTS3pXo2xYbDu1cpU0T8Pejcy02Y8gPB9Vo8s+7xkbqDk2kUinAMNiFkx5ZEyYFegpLy4lRtD5zfEDzcw6Tyg0erOxmyZs7uS8/iuO4fiS9hPWqx21hDmjJ+kKUiz3PElWssHwxTxkrrOE9s1b0vuVeItrd0TJ4d4fQYEqfzIeNclF43/ioOIKWyTs5SENEZrsd5AEvlLev/7CVP1tT/wXBqA6LMHF3qVGiz8isYFkJxP0ozEB1XGsChF9xj6EFuXSCePyA79rGwbs27Y8XVmf5joRgRBW6NQ22cM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ9LUnliQpCBQDGztzHDghNi+6mb5RukVE1oVriogT8=;
 b=iDT6zWf8vg5TUDW2cHoNPNMb4x/kzaii4nNwRJKY7tRl992fOgiYwsLiZyN/0TNGMgTEPhyTzTvOHumtX1OYxdSxp9HDxmj9eLQjTSfeQhVtJLdwIDfDSIkXgDf5YWGO9GtDfmu5L4AhS4vNeh2zm89NIgh/FS32O/85p/v+n6yV5EXaBfKtgaU2lfjrvYUlXtsZFG/f4/2Prhrz+9u1yLWPD0ni5w2c15A9OC5Y4SgM9qGFmqDnNMl+1IMFTBLzOKwOw7oigUVlXhYJpgMg2cUM2I9tO7w4d1/QM8GlJSgueCY/jXN30tQPbt7o8zDlFDTRoSHYRHpRm1dUglBndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ9LUnliQpCBQDGztzHDghNi+6mb5RukVE1oVriogT8=;
 b=k24b4W7qU4k2FlWPUFqBoDa3++6kRr8C7vpprP87euisURw09Bvdmjsjg/VWvG1wqi79C3AlND9JxQRXi848CSMTksGgJxEUAKxb5/hQM8jjKB+ySBAaApcnDVVQG87U96Lu/gOu3YVTEdwoFUaLe82kPbYbflBbRp7i9SUa0UY=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 21 Aug
 2020 06:10:10 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 06:10:10 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: change reset lock from mutex to
 rw_semaphore
Thread-Topic: [PATCH v3] drm/amdgpu: change reset lock from mutex to
 rw_semaphore
Thread-Index: AQHWd23Z9QxddIk0qkKSQohqV9FhSKlCFILA
Date: Fri, 21 Aug 2020 06:10:09 +0000
Message-ID: <DM5PR12MB17086CF755438F60E31EC603845B0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200821034736.27106-1-Dennis.Li@amd.com>
In-Reply-To: <20200821034736.27106-1-Dennis.Li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f3e3e7a3-204a-42e2-8974-000045e92c5a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-21T06:09:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b633a9b7-84c9-4eb3-0906-08d84598dbee
x-ms-traffictypediagnostic: DM5PR12MB2359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB235923DD053CFFD0C8770B37845B0@DM5PR12MB2359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83Pijre+msL/5BLvYstp0ImtPUKRq2UhSHrBzIgUQU16i0pyNk7VxkZ9YFho9QLprFj5wEYwohemaAEVgUndMNiiyqtWV7bqL8hALYkEosswdi/G7q+ML9Q/KBxj9sGDcXawg0AErXITwvzd+aH7fIykQbto8S6WMn8xTCrScrvyyRhqRYco0id2mwVw8evcw+JwDVLthFjSkgFBqaBR0fMSmsoMc/56IvmiAceWUexm+qphNjqJytd9/Up5zZX/5z3r3PDh8QhW9abiHMhzLosd9dPN79gwWjK1iCvtAVh302+hAY7yQdLWIaiJg9AG5BoRD3wbk2/ZEPemHZAuXcyr5xnx9502xtSJ38LN4HDrEEawOuZMgcMaZec1+e4m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(33656002)(7696005)(55016002)(5660300002)(478600001)(110136005)(8676002)(52536014)(8936002)(6506007)(86362001)(53546011)(4326008)(66946007)(83380400001)(6636002)(26005)(64756008)(76116006)(66476007)(66446008)(2906002)(71200400001)(9686003)(186003)(66556008)(316002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WZ2Hm+MpHD4NNvoZ8hQ0ZP6wRQr5c4mFWxcsuplzIjv1oriu4WYhYwfJ048vzzUscmcaOUxxbcZUv6yBOYmknHWHX0sOP9kkAgBtSe1g82RMjtgo2BTrZxI3Njmw2+aXUxSn9O4cxLRuaNAwF6gTVE3L9ktOOWg868MgXfgnd+fb+Zp/8q9c3PK/eobNlhvl4j+l+lAPqvD16bgqJ6GPYo/GCN81nQ/jhNveSof0lLjQbFR1ZiCuXAbR0YR2N9bkTrYB9vzJoC5rXFiHGieGEIR60s3ylJDmxsmtu5CLdZ2YvIiW1KpYms+UpwW16xR+F7HuYKClBup1f3pWbe+x9yfgNzfdFFQyZtzIhDgddegbfPkgY5Df0E27+fDnxyan2rkDgadOLIJyQgX+QXYYlz0x12hnmH2yaoBWkDPythvFZ+tBcrHtYKzXnD8QqQ2XMRyiIb7V/NOU73WgWyJufPQ7PeF8UYhG0t+miNFZKBi7VN0uLMT2bhSJNrKsZrtehKZ4MPlU0Z3K/2MYaBoBZWhlPEjEBFiAw4wP9FoE5RxqQg3PrHoM+wsvR4J4mys6/GrBEpOjU+O9vZ/qquu0GX9Fg3HIVGRJqy4waqKygoJ+p2Y8oo7r+W5DxlomfDQqucLDzYxeKpLJvM/f6ikPXQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b633a9b7-84c9-4eb3-0906-08d84598dbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 06:10:09.8131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JJBkpK9WkmURnuE2NDcK+n2vSFfG7Kz2Tj6irAd8gJOlbQXU6TRWaLpkfC9CUTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com>
Sent: Friday, August 21, 2020 11:48 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v3] drm/amdgpu: change reset lock from mutex to rw_semaphore

clients don't need reset-lock for synchronization when no GPU recovery.

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

 atomic_t in_gpu_reset;
 enum pp_mp1_state               mp1_state;
-struct mutex  lock_reset;
+struct rw_semaphore reset_sem;
 struct amdgpu_doorbell_index doorbell_index;

 struct mutexnotifier_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 79b397800cbc..cc5c7f81c540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -101,14 +101,18 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)

 file->private_data = adev;

-mutex_lock(&adev->lock_reset);
+ret = down_read_killable(&adev->reset_sem);
+if (ret)
+return ret;
+
 if (adev->autodump.dumping.done) {
 reinit_completion(&adev->autodump.dumping);
 ret = 0;
 } else {
 ret = -EBUSY;
 }
-mutex_unlock(&adev->lock_reset);
+
+up_read(&adev->reset_sem);

 return ret;
 }
@@ -1242,7 +1246,9 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 }

 /* Avoid accidently unparking the sched thread during GPU reset */
-mutex_lock(&adev->lock_reset);
+r = down_read_killable(&adev->reset_sem);
+if (r)
+return r;

 /* hold on the scheduler */
 for (i = 0; i < AMDGPU_MAX_RINGS; i++) { @@ -1269,7 +1275,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 kthread_unpark(ring->sched.thread);
 }

-mutex_unlock(&adev->lock_reset);
+up_read(&adev->reset_sem);

 pm_runtime_mark_last_busy(dev->dev);
 pm_runtime_put_autosuspend(dev->dev);
@@ -1459,7 +1465,9 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 return -ENOMEM;

 /* Avoid accidently unparking the sched thread during GPU reset */
-mutex_lock(&adev->lock_reset);
+r = down_read_killable(&adev->reset_sem);
+if (r)
+goto pro_end;

 /* stop the scheduler */
 kthread_park(ring->sched.thread);
@@ -1500,13 +1508,14 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 /* restart the scheduler */
 kthread_unpark(ring->sched.thread);

-mutex_unlock(&adev->lock_reset);
+up_read(&adev->reset_sem);

 ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);

+pro_end:
 kfree(fences);

-return 0;
+return r;
 }

 static int amdgpu_debugfs_sclk_set(void *data, u64 val) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 78fd2c9a7b7d..82242e2f5658 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3054,7 +3054,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 mutex_init(&adev->virt.vf_errors.lock);
 hash_init(adev->mn_hash);
 atomic_set(&adev->in_gpu_reset, 0);
-mutex_init(&adev->lock_reset);
+init_rwsem(&adev->reset_sem);
 mutex_init(&adev->psp.mutex);
 mutex_init(&adev->notifier_lock);

@@ -4206,7 +4206,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev)
 if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
 return false;

-mutex_lock(&adev->lock_reset);
+down_write(&adev->reset_sem);

 atomic_inc(&adev->gpu_reset_counter);
 switch (amdgpu_asic_reset_method(adev)) { @@ -4229,7 +4229,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 amdgpu_vf_error_trans_all(adev);
 adev->mp1_state = PP_MP1_STATE_NONE;
 atomic_set(&adev->in_gpu_reset, 0);
-mutex_unlock(&adev->lock_reset);
+up_write(&adev->reset_sem);
 }

 static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f27d83f2de78..9c07014d9bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -238,19 +238,15 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
-int locked;

 /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
  * otherwise the mailbox msg will be ruined/reseted by
  * the VF FLR.
- *
- * we can unlock the lock_reset to allow "amdgpu_job_timedout"
- * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
- * which means host side had finished this VF's FLR.
  */
-locked = mutex_trylock(&adev->lock_reset);
-if (locked)
-atomic_set(&adev->in_gpu_reset, 1);
+if (!down_read_trylock(&adev->reset_sem))
+return;
+
+atomic_set(&adev->in_gpu_reset, 1);

 do {
 if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) @@ -261,10 +257,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 } while (timeout > 1);

 flr_done:
-if (locked) {
-atomic_set(&adev->in_gpu_reset, 0);
-mutex_unlock(&adev->lock_reset);
-}
+atomic_set(&adev->in_gpu_reset, 0);
+up_read(&adev->reset_sem);

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
-int locked;

 /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
  * otherwise the mailbox msg will be ruined/reseted by
  * the VF FLR.
- *
- * we can unlock the lock_reset to allow "amdgpu_job_timedout"
- * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
- * which means host side had finished this VF's FLR.
  */
-locked = mutex_trylock(&adev->lock_reset);
-if (locked)
-atomic_set(&adev->in_gpu_reset, 1);
+if (!down_read_trylock(&adev->reset_sem))
+return;
+
+atomic_set(&adev->in_gpu_reset, 1);

 do {
 if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) @@ -282,10 +278,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 } while (timeout > 1);

 flr_done:
-if (locked) {
-atomic_set(&adev->in_gpu_reset, 0);
-mutex_unlock(&adev->lock_reset);
-}
+atomic_set(&adev->in_gpu_reset, 0);
+up_read(&adev->reset_sem);

 /* Trigger recovery for world switch failure if no TDR */
 if (amdgpu_device_should_recover_gpu(adev)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
