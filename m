Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961F120734
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j/V+CUXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961F120734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1A26E04A;
	Mon, 10 Aug 2020 05:14:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A280B6E04A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 05:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFSjO5xx9qW44uBG5JuSS/WHVehlYp5iaoNDQVnq2gKpQGqCby07biOBkyp22beH7hY1gus69KpCyCtIRABJXelHIhHuCdNbQqd7JyXDMSdLzUwAo9PT/n257b7NnSjCqp4XHiXSwVMB0z0mefsC4d4nMRO7fukBTgYH8szo0J1WCvYYPS2PauIAASYCPGvTvGKe4Na0Zv0xhNQGic2cCMxfgoDCyOxzHnLzVeN4mwoEmJ5AOBp+sKip/6CXghrMtgewSv7edjFMScJtDJK5Hgu0LqPTguanKZCTMA4szcOf6H0hoPSV+7QKlZpWw1+hnO7kqGJzh0Z1hcpYvcz+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLxQ8M3O6hG3f4v5epkmqqG0tkATYzPAsFZNa0fyHTU=;
 b=MAZCvQIMA4ryKKZSsv9mvWXMc42x/+kw+aWumhCY86bJOrcYh8kjdtFhQ8QzOFSyWbDkF1jFrKlhnV9Z1qry9d1chSDLMUD9+TK6Wc1rldtbalDDy+Tv9c2W0UqKJJxNsSUy3/+/y1mszzuQy5Ofuu/zd+zNiwImjlaJ5W7jO3fSvwR1FgzmNMXoC7MJuQdCmCg9Uark0Kr5YA2waY44p3Sbk9eZZ4X+JU6EgGzPErXY5EuQIDetzxWbgaqpChijKPw1q/SK0hK4rf4P+ZkfcE/VWooVeorBrmokpzGvlwkTZS9LMT7FichKDT5Z+2jqmpezsannl3fPWsyKjnxMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLxQ8M3O6hG3f4v5epkmqqG0tkATYzPAsFZNa0fyHTU=;
 b=j/V+CUXkJylXOwPfQvYTCosF1pxNbP4ceiSBbNF839HwgzONbXZaA/bepWkpoEKQKWs/RTF99Daoe/GXOWVaYUP29oYCkj+kkV/6+3ex0xokQLszN6otcU96btqaTR1uarOMcfVh+GzPfuQeC8cZl6eLC0SbFd5Jjhu51C6UPYI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18; Mon, 10 Aug 2020 05:14:32 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3261.023; Mon, 10 Aug 2020
 05:14:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: annotate a false positive recursive locking
Thread-Topic: [PATCH v2] drm/amdgpu: annotate a false positive recursive
 locking
Thread-Index: AQHWbI/aQTDHiAJDxUO5iIHf1qrVOakw0QPA
Date: Mon, 10 Aug 2020 05:14:32 +0000
Message-ID: <DM6PR12MB40751EA9D7F883667C30BFB0FC440@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200807075322.17254-1-Dennis.Li@amd.com>
In-Reply-To: <20200807075322.17254-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-10T05:14:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=699ea782-7510-46ef-9e48-0000721eafc4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-10T05:14:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f40fc230-3e5e-49ed-9258-00005fb590cd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-10T05:14:28Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a6859772-1392-44ce-a331-0000faf318ca
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f8463d4-86d9-4f9a-75aa-08d83cec43f8
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28918057D0E12F9A238FFAD3FC440@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9TBnTgYEyuBtwEqopSURsU2I7f5a4PTEvEBK1UbMLann+esIPjJ4OIXY3/+CoeaVLsghXsoTjjfayT61n1bVn8MclTpKpuWivpRf1QnYILgdUfr3ZWiSf1aGJ9mKhIbuMlws8GuzSCs4LQdp92R3CWxHRnybV1N5tBgszDYY5pTVzPqwSMsso5D1NxLmacQrbtjX+DQZfep8htGqri7sIUFvOBSDyKwC14Ybp1BwmYkCBjcyI1baeyQh8BwaRb0bqU9CBCkLocKGQsiIL10P9agb47/y1er8yheEWVEC7kZ3klUQbXnq3fSywEhRObD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(2906002)(26005)(71200400001)(186003)(7696005)(64756008)(66446008)(66556008)(66476007)(478600001)(4326008)(66946007)(53546011)(5660300002)(6506007)(55016002)(76116006)(9686003)(8936002)(83380400001)(52536014)(33656002)(8676002)(110136005)(6636002)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EcChz4KcPkNHxpOpyZKROyEANasjq7+S+VbH9jzNEYgnOYaz2WZLP3NZGxRa0AzQs+7UcOXjEiFFaC2vzXxwYYNFPJDTH93X7hFg4iJIMpvVPJQCeRlCfxClMmMrfufxIDK1Pat88xC/A9sutUWUcC66Nv4i2vGa+9pC6O69AJOLc7pIwAV44aj8v8Letf7MjijmY5SdJsFLgw9azw++1d3lEI5mQUFmHVLgwT0R+GGn6CsXYticf+rbWtPOhcL/aLJwClZKApeuNeMP0KgTO5bERS9K9NextQ6MMuq76YTl0qowz02EEjtMxMSQWiGSlXr9Yze+UZ6As6G6n4lJU5LCExmTKCatd/sLuvUbZoennPUbNJPqrthVbPD505MNz829g0o6nv2MOgrCOAm2XbiF4XnMVyHCy675/2Z7rrnpj7wRQgMZQVAYwMOdvAcaCzw2YAe8GYlGO7ixtOPTzFteo6d3AR1ngZ9iqgEU3OZnFztgNl191KQI0kDfAnpEaGeRbLsVHW7zmILxzkEf8BIQJh67ninclARiXq8+Bn5yeLrf1fwD48XWuGu7+861ZIYjuHzNbpOs2Wl8VUqRB6BxryfVkY62dABWtoyJ9h0apbwu6SMB82WxtXBfORdHfFtHqqZ2v1RQJDAQ/ISvgQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8463d4-86d9-4f9a-75aa-08d83cec43f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 05:14:32.2184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKszT9uF4JFOMY5mc8X8+aGqAJ9GVeeIMJ0hbDgiisVQnI+FAUwLJwqIOSUP8yBX1jJEhRqeaQrpPNGS+IkylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, August 7, 2020 15:53
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: annotate a false positive recursive locking

[  584.110304] ============================================
[  584.110590] WARNING: possible recursive locking detected
[  584.110876] 5.6.0-deli-v5.6-2848-g3f3109b0e75f #1 Tainted: G           OE
[  584.111164] --------------------------------------------
[  584.111456] kworker/38:1/553 is trying to acquire lock:
[  584.111721] ffff9b15ff0a47a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu] [  584.112112]
               but task is already holding lock:
[  584.112673] ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu] [  584.113068]
               other info that might help us debug this:
[  584.113689]  Possible unsafe locking scenario:

[  584.114350]        CPU0
[  584.114685]        ----
[  584.115014]   lock(&adev->reset_sem);
[  584.115349]   lock(&adev->reset_sem);
[  584.115678]
                *** DEADLOCK ***

[  584.116624]  May be due to missing lock nesting notation

[  584.117284] 4 locks held by kworker/38:1/553:
[  584.117616]  #0: ffff9ad635c1d348 ((wq_completion)events){+.+.}, at: process_one_work+0x21f/0x630 [  584.117967]  #1: ffffac708e1c3e58 ((work_completion)(&con->recovery_work)){+.+.}, at: process_one_work+0x21f/0x630 [  584.118358]  #2: ffffffffc1c2a5d0 (&tmp->hive_lock){+.+.}, at: amdgpu_device_gpu_recover+0xae/0x1030 [amdgpu] [  584.118786]  #3: ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu] [  584.119222]
               stack backtrace:
[  584.119990] CPU: 38 PID: 553 Comm: kworker/38:1 Kdump: loaded Tainted: G           OE     5.6.0-deli-v5.6-2848-g3f3109b0e75f #1
[  584.120782] Hardware name: Supermicro SYS-7049GP-TRT/X11DPG-QT, BIOS 3.1 05/23/2019 [  584.121223] Workqueue: events amdgpu_ras_do_recovery [amdgpu] [  584.121638] Call Trace:
[  584.122050]  dump_stack+0x98/0xd5
[  584.122499]  __lock_acquire+0x1139/0x16e0 [  584.122931]  ? trace_hardirqs_on+0x3b/0xf0 [  584.123358]  ? cancel_delayed_work+0xa6/0xc0 [  584.123771]  lock_acquire+0xb8/0x1c0 [  584.124197]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu] [  584.124599]  down_write+0x49/0x120 [  584.125032]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu] [  584.125472]  amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu] [  584.125910]  ? amdgpu_ras_error_query+0x1b8/0x2a0 [amdgpu] [  584.126367]  amdgpu_ras_do_recovery+0x159/0x190 [amdgpu] [  584.126789]  process_one_work+0x29e/0x630 [  584.127208]  worker_thread+0x3c/0x3f0 [  584.127621]  ? __kthread_parkme+0x61/0x90 [  584.128014]  kthread+0x12f/0x150 [  584.128402]  ? process_one_work+0x630/0x630 [  584.128790]  ? kthread_park+0x90/0x90 [  584.129174]  ret_from_fork+0x3a/0x50

Each adev has owned lock_class_key to avoid false positive recursive locking.

v2:
1. register adev->lock_key into lockdep, otherwise lockdep will report the below warning

[ 1216.705820] BUG: key ffff890183b647d0 has not been registered!
[ 1216.705924] ------------[ cut here ]------------ [ 1216.705972] DEBUG_LOCKS_WARN_ON(1) [ 1216.705997] WARNING: CPU: 20 PID: 541 at kernel/locking/lockdep.c:3743 lockdep_init_map+0x150/0x210

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I7571efeccbf15483982031d00504a353031a854a

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e97c088d03b3..766dc8f8c8a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -967,6 +967,7 @@ struct amdgpu_device {
 	atomic_t                        in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct rw_semaphore	reset_sem;
+	struct lock_class_key lock_key;
 	struct amdgpu_doorbell_index doorbell_index;
 
 	struct mutex			notifier_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..ae0a576f9895 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3037,6 +3037,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	init_rwsem(&adev->reset_sem);
+	lockdep_register_key(&adev->lock_key);
+	lockdep_set_class(&adev->reset_sem, &adev->lock_key);
 	atomic_set(&adev->in_gpu_reset, 0);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
@@ -3411,6 +3413,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 		amdgpu_pmu_fini(adev);
 	if (adev->discovery_bin)
 		amdgpu_discovery_fini(adev);
+
+	lockdep_unregister_key(&adev->lock_key);
 }
 
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
