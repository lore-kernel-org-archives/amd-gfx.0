Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C8C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04996204EA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NOSpxleq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04996204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9251C6E0BC;
	Thu, 20 Aug 2020 11:36:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F5E6E0BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 11:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3jfAzCN1MtYecuAWrSzN/sKTNdyePqfbwfBxeDeQyTOA03gE2gXoKLWslKTk17gA8g94AtXCqyZCf7dmfZWD/vFwGBab9LorkmZem8b49fcV1R3cY4wZ72Gck/c8StvC0dFfVzGQcSrK1QDYl2534Pio3rC7aZnOw98DLeX1rCyG9JXcslrSlCGaC6VTQIRkX4vhwmAJPzsPi2M3TTDbzr/k5ROeWJwLPFQlpSi+xB9n9PpK8jQ02LjFBWHM6k0qOUrYKfi74VJyHRBol3jMoQEmHT9Pwkmpq1kyh//Rtg2YQUfky4jYEPvAj2u4sAQC61qc52g9jdHLaECW3mLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp1q5ix9qOA9FjGzsMOB9jYtvVfYLdXFNsoXj73Wz98=;
 b=HN0emDA6z/hzHIr1PE+vrJffwpoLKMtucXUovSAM/ipWt/tHMYZAgPDKX5eG9p63yzGJpt87qQcah1cz4HlN/7vyxXbfi/IvtPGhOGqLKmTJdj1iwxxUdgg0ad6I0fJTTC7gzOXwhSKCGjkMHPWr+w2q138i/dlMrG8rd8ih5bzy0R4XI3CTuwEXwYq5v8Hnc/S3OSwV/8UXpIAv1lKTho3EoUOaCkmd+X/JBf8wNkDS96KZXku6TvW1zB0rGzc+fqvMqaj4cJ5VwqV/9MMV82eoG4MciWmXGNSOFw8IS4UMRM2xdLzPGm5WE9qzND8e0Qa9MMzysiSU/1/UspQQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp1q5ix9qOA9FjGzsMOB9jYtvVfYLdXFNsoXj73Wz98=;
 b=NOSpxleqWOA5r3Bf1IoNsOvi+bb7Ske3o66UklTdE7JD8qT8WpcUaCTvv9CA0jKSf5i2oM9Dj+QLdBv8EQ2uRpv81yWPlGiZpV024A/CVCmz1hnSnPGIR3PjwzDa4rtouQ3vd4dc61My7VGwEXg0GHJkn/E+0OOwAbLr3HM8eQU=
Received: from SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 11:36:05 +0000
Received: from SN1PR12MB2544.namprd12.prod.outlook.com
 ([fe80::1c8e:35ad:4f66:c15c]) by SN1PR12MB2544.namprd12.prod.outlook.com
 ([fe80::1c8e:35ad:4f66:c15c%6]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 11:36:05 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: change reset lock from mutex to
 rw_semaphore
Thread-Topic: [PATCH v2] drm/amdgpu: change reset lock from mutex to
 rw_semaphore
Thread-Index: AQHWdtThz6ypY7lLXkGLpkZF9cD8nqlAwLOAgAAYk/A=
Date: Thu, 20 Aug 2020 11:36:05 +0000
Message-ID: <SN1PR12MB2544DE175F15FDF8A34C4327ED5A0@SN1PR12MB2544.namprd12.prod.outlook.com>
References: <20200820093238.14013-1-Dennis.Li@amd.com>
 <DM5PR12MB1708E4D824182A2050C9986E845A0@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1708E4D824182A2050C9986E845A0@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=11276e1f-0147-43cf-8412-000032098035;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-20T09:43:37Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e3e3331-31e7-496e-a9bc-08d844fd399c
x-ms-traffictypediagnostic: SA0PR12MB4509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4509F96C9536CB6992DE304BED5A0@SA0PR12MB4509.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OUT9PPqonOwfq974kJW7wjES6HVj5+jUeAmvJHOxMDoOQo5nyzuxurhdWQZ13+X17egsVWx6YToZ7WQlt2QFULgmQFlINhaofMp8Z7S/fpcGFwvLpRWWkBw87B/W/jZuBh2toabrHIwwJ/c5wCFoIpRC2Cg4mPKnY6jCkFOopz13gq/Abr6+wfpArJj7z+onfnEHBnoISMm31JACkQBqZmVkurf8U+w6yHKZFAE+lZ1CFoxzBSr2aUI/77eJLR4KWL8xyOoq3akXWAOAZYTprZUEaKohAvLiWIG6aOjc8HcKW+If21+RsESrxgTFPaz/JsNA0nkCSMxbbCV02SvSg1YUc8Cvo1Wo+6P+Z9aS/WRREU/NfU6jLkndg7rm1f/QM8iNkSj3ZV6oH722/hcuFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(110136005)(478600001)(52536014)(71200400001)(5660300002)(33656002)(6636002)(9686003)(45080400002)(2906002)(55016002)(53546011)(316002)(26005)(83380400001)(186003)(8676002)(66446008)(7696005)(76116006)(66476007)(8936002)(66556008)(66946007)(6506007)(86362001)(966005)(64756008)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8p+VlD7BUUjt5gy1ofN3B1ExAlg+Bb/sRUyaK8DVRkfUe2W48fNhWEXJ01XfoaNy0S0b309NBE0OFJDf9XzjL62Fx8zxmKC/5dFfo5WtzQhbqNPZLfPF1HQmf/cmWuNlPndQioQ26Vj6OIqTJznrzdcc/lXe7eXpq7oem8RIlt3fbi5ou0+Nc57+1BCBsWkiZO+qc2FHqZE6OAYez/NohKCliNX1KK7GJITeSrd0K9eOftTsZjOa1vxnoB/Bvk9GxKcSxRO1IcoX7WfefoHhl7LEapmr5C6uCzo1yforgU6NtAibD4ak3a9kTGdjPZsudvVZn7g4b7jRQ9EKBxO1W1YFYIMzl4yxYR7e47WqCfhVPi+tnpJF+Jy+6vkcVhccAILNTjDabgq/nOkVQUhWKyzlLXPaOHLrLZCBJQCDiWm9lMoGi5Ffmr6O1m7X0CDqhEb9o76iLnZg0TG/x2iEbGt9IOZIhRxgX9C0ZuSUZmSDto+FzlDQBm+qgB9ACoVe5mrCEOfMnMYhWCc+HE8ONf1xj0aYVGtLbOekOlOt8UgK7L/7ar4Tlnah0jKVkDkenw574BBSF7mA64uAwA8beUyYniu4rDSWK76YF1v51gwc76d0NHYrLgvJofwk/W1DgN9c3Yzih2MJL1uRjGkBjA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3e3331-31e7-496e-a9bc-08d844fd399c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 11:36:05.6208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQfJZ8h9yXQMq4LyfrkEKlpHZbduSHkcI8bNEUysFEoZFleQ2tVmFs+OwLWbajMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Hi, Monk,
      See my below comments.

Best Regards
Dennis Li

[AMD Official Use Only - Internal Distribution Only]

--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -238,19 +238,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)  struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);  struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);  int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT; -int locked;

 /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
  * otherwise the mailbox msg will be ruined/reseted by
  * the VF FLR.
- *
- * we can unlock the lock_reset to allow "amdgpu_job_timedout"
- * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
- * which means host side had finished this VF's FLR.
  */
-locked = mutex_trylock(&adev->lock_reset); -if (locked) -atomic_set(&adev->in_gpu_reset, 1);
+down_read(&adev->reset_sem);

>> Above piece looks suspicious :

>> The original logic (before this patch and your another patch) is :

>> 260     locked = mutex_trylock(&adev->lock_reset);
>> 261     if (!locked)
>> 262         return;
>> 263
>> 264     adev->in_gpu_reset = true;

>> So we only continue after the trylock success, and we "return" immediately upon the trylock fail,

>> With your change the code path continue anyway (did you change the logic in your another patch recently ??)

[Dennis Li] I didn't change the logic before, I guess that your local branch is different from drm-next.  In drm-next, the logic is:
locked = mutex_trylock(&adev->lock_reset);
if (locked)
atomic_set(&adev->in_gpu_reset, 1);
According to the comments before these codes,  it wanted to block amdgpu_gpu_recover till msg FLR COMPLETE received, so I changed it in this patch.

>>Please modify it as:

>>Locked = down_read_trylock(&adev->reset_sem);
>>If (!locked)
>>Return;
>>atomic_set(&adev->in_gpu_reset, 1);

[Dennis Li] why need we set adev->in_gpu_reset as 1 here?  It should be set when do GPU recovery.

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dennis Li
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
@@ -1242,7 +1246,9 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)  }

 /* Avoid accidently unparking the sched thread during GPU reset */ -mutex_lock(&adev->lock_reset);
+r = down_read_killable(&adev->reset_sem);
+if (r)
+return r;

 /* hold on the scheduler */
 for (i = 0; i < AMDGPU_MAX_RINGS; i++) { @@ -1269,7 +1275,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)  kthread_unpark(ring->sched.thread);
 }

-mutex_unlock(&adev->lock_reset);
+up_read(&adev->reset_sem);

 pm_runtime_mark_last_busy(dev->dev);
 pm_runtime_put_autosuspend(dev->dev);
@@ -1459,7 +1465,9 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)  return -ENOMEM;

 /* Avoid accidently unparking the sched thread during GPU reset */ -mutex_lock(&adev->lock_reset);
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
@@ -3054,7 +3054,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,  mutex_init(&adev->virt.vf_errors.lock);
 hash_init(adev->mn_hash);
 atomic_set(&adev->in_gpu_reset, 0);
-mutex_init(&adev->lock_reset);
+init_rwsem(&adev->reset_sem);
 mutex_init(&adev->psp.mutex);
 mutex_init(&adev->notifier_lock);

@@ -4206,7 +4206,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev)  if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)  return false;

-mutex_lock(&adev->lock_reset);
+down_write(&adev->reset_sem);

 atomic_inc(&adev->gpu_reset_counter);
 switch (amdgpu_asic_reset_method(adev)) { @@ -4229,7 +4229,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)  amdgpu_vf_error_trans_all(adev);  adev->mp1_state = PP_MP1_STATE_NONE;  atomic_set(&adev->in_gpu_reset, 0); -mutex_unlock(&adev->lock_reset);
+up_write(&adev->reset_sem);
 }

 static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f27d83f2de78..8ac63f13fc6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -238,19 +238,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)  struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);  struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);  int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT; -int locked;

 /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
  * otherwise the mailbox msg will be ruined/reseted by
  * the VF FLR.
- *
- * we can unlock the lock_reset to allow "amdgpu_job_timedout"
- * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
- * which means host side had finished this VF's FLR.
  */
-locked = mutex_trylock(&adev->lock_reset); -if (locked) -atomic_set(&adev->in_gpu_reset, 1);
+down_read(&adev->reset_sem);

 do {
 if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) @@ -261,10 +254,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)  } while (timeout > 1);
 flr_done:
-if (locked) {
-atomic_set(&adev->in_gpu_reset, 0);
-mutex_unlock(&adev->lock_reset);
-}
+up_read(&adev->reset_sem);

 /* Trigger recovery for world switch failure if no TDR */  if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 3cb10ab943a6..bcc583f087e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -259,19 +259,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)  struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);  struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);  int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT; -int locked;

 /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
  * otherwise the mailbox msg will be ruined/reseted by
  * the VF FLR.
- *
- * we can unlock the lock_reset to allow "amdgpu_job_timedout"
- * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
- * which means host side had finished this VF's FLR.
  */
-locked = mutex_trylock(&adev->lock_reset); -if (locked) -atomic_set(&adev->in_gpu_reset, 1);
+down_read(&adev->reset_sem);

 do {
 if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) @@ -282,10 +275,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)  } while (timeout > 1);

 flr_done:
-if (locked) {
-atomic_set(&adev->in_gpu_reset, 0);
-mutex_unlock(&adev->lock_reset);
-}
+up_read(&adev->reset_sem);

 /* Trigger recovery for world switch failure if no TDR */  if (amdgpu_device_should_recover_gpu(adev)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C83ea9660ce0749dbc2c208d844ec062c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637335127818823207&amp;sdata=LR%2BvbRaX1Jonb%2F9wIvoK8gV%2FoTBLPeornTaQe9qS5xE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
