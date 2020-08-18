Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBDEC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 02:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DA32075E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 02:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QdJI/wzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DA32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830CC89CB2;
	Tue, 18 Aug 2020 02:49:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943FD89CB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 02:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e81NCbcHki4jZFRC32t0mYqZPLGutlL0mqyNYlEPpqPPCSkgjBSvBVMu6PlBo/p1XM99XFEsjZHjab27XioEMI23JZGC8AwgX75fNpEoR0Kzk7qSQ0f/4KXSqdr6UIPS9uI0mILItvVxvOBuNXj8PHKfS7RZcGUTDoOXigOnijDMynrZJ0HICQ8/qQ99J+OpOc2znYlAtma95oT9XZHEhc6arMR12jM4bR9Nb+WYA5XFhQdEr5HOh2WU9/NaBP48ok7gzJIPFIx2zSdCpkzwSv7QfvLXQTr3oc+tCZwMmhv5KVIu1fWXZrAZ3ni0xhDcNAh+aR98orAukq94/BgwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEyufyFCQV8B18V/djcGxsx29Z/O8zeCZDmvlvdz8JE=;
 b=g2+wDDCGx1gjinP3kp/+YgwhcIRi8YIRflCXoOaUnQLnOviJMUBFhVDM3gvfewfLHebgaXmp42LGTaPcVlfWVkmDD4Ki89KNYyZMwPjroxs1/fa98e0mRh7LveKtEBGgQhcvQHeY5tXbcaSUyZz8AuKyB+KzqmwzTIaRaffCR3wnYApPl2MOevKItRb0ZcLGoHaUue2tk3XnkC92usJKisT7sW7aFb8sXVYdNZatpBy0ia7VjDI3a/YaXTZEmzQGXm+5yLHVw6taiGelV8B+Jy2AU86zGtY4dvsdejyZdZrBVFAHB3Hf+m6h4rEayZsuo16QqpwVBWbHsrw38xk1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEyufyFCQV8B18V/djcGxsx29Z/O8zeCZDmvlvdz8JE=;
 b=QdJI/wzWDePHuc9zjO83XFzhPKAO03Gn29gWnaXFJ6ymxBnANrfdeNDCsDBeo2bfPT0hFiRX35FX+EznhqnP++wU/6nWXhotsPRSG9Q9RvCE/Gv3pNyBKcDtYUMslbQSYB0zVmbN4KdVRlmnSYPrZ9KWajxFlsv9yP9K/6RZYAY=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Tue, 18 Aug
 2020 02:48:55 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%8]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 02:48:55 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix repeatly flr issue
Thread-Topic: [PATCH] drm/amdgpu: Fix repeatly flr issue
Thread-Index: AQHWcInAiazTtQfKHE6yg/8HiShlpqk0ZDoAgAjOwmA=
Date: Tue, 18 Aug 2020 02:48:55 +0000
Message-ID: <BY5PR12MB411548B0210D9C173431A7A78F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200812091943.438905-1-Emily.Deng@amd.com>
 <71d5893c-453f-7c3e-7a20-e1234920dbba@amd.com>
In-Reply-To: <71d5893c-453f-7c3e-7a20-e1234920dbba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e09be918-9c75-48be-b11f-6b74bba406f8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-18T02:48:21Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1db7602d-6325-4588-d9c9-08d843213fed
x-ms-traffictypediagnostic: BYAPR12MB3126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3126E63AB3C4E15E06C096C48F5C0@BYAPR12MB3126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKM3o3Yup5vi3xno9CawnXLXYYXFyO2rZaB/O6cCfF1qTFGL/Clkzhv/op7GLCxcmX079oS6xvVEwwrTmhrFaVHPbPH4xvXljn8V9q3LDFjVQB/6rGaebYyGXZEZQF2bc9FOyS8kSx8ix9r0m04k2w9bylz47z3pDhMOZ3ZlXi6Oi47VVbAnXvX7GfEqaf8ktRE82Dq0cXT78XJH+nAYhe9bTGpw/o30pC8QMGwQ+2cAdhsgM18fHLRnWWk78B554SItbuIzsoHJRGcadDmTe9iTEUcas8/Vf/PrQwURYb+4Eu6BvucQ/uX9RAygi6nE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(26005)(66446008)(110136005)(66476007)(64756008)(66556008)(71200400001)(8676002)(2906002)(66946007)(55016002)(186003)(86362001)(8936002)(76116006)(5660300002)(316002)(52536014)(6506007)(478600001)(7696005)(9686003)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gkD3iL3a3jp28EcEdukHAWnZabU/AJxVwp31y2o3yI81GEJIyA0VwYQBMcuqqbG2qP8/FXcBB/wrSAq+6gEG1rFDfp8ZVLx5wu28ARLGeY56lCqCwbJtxejWQDaojH8cBeGwBCTbvRX3bQ+uGuMBVuQ5EvpxPQtvIc5QXhJu0aNgXVo342hXXZM33BZiONGDt6uofJYYeJ2jOZXtQECrou5SEWhQl92Z1PR9FVcQSLzMKvjRcAjuap6/r7eagXhGZcCQkybI7c+JibZpDBrHu+ELm71pRV33H8ANqjZtWpkSqVl5rfAF0iHByCOsNskjxxtUm3RkjJSn32ClTC1luGshvKCtT6H/L0u5XIH4BAQHmvTTdo3olSGgOSLPIZg/6GnhoEVsmyAX+Y4jIgu0K+iOPu9jZuFJm4hLaeiXTGMYamscgeW4DIgWbYddGisv+jNqdiZld/xnBTv0mAcyX43+0OaM5FP/FvbazRbD4YMWEXwwPlPAudkGCr38CwG26JReFjBpWzJM3Oun2KXnmvyyYl0g+KWab/hEaJkErSYRX6ElgcKuyF6wisXNHQwnGeV4ThaNVEXxIL3TP4jfn6BbTjauPFSBp0gCaUqpn0ad8J/evgxHyd24iP0IDdcjW+tE+gacH5sbw2OJ5r5StQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db7602d-6325-4588-d9c9-08d843213fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 02:48:55.7344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TR2hLW+0b8tTu8gBvszQlDvW1e/2FuvxCpSefnjow7n5Qzx/9HpRJWnY2s58gJuP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
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

>-----Original Message-----
>From: Das, Nirmoy <Nirmoy.Das@amd.com>
>Sent: Wednesday, August 12, 2020 8:18 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: Fix repeatly flr issue
>
>
>On 8/12/20 11:19 AM, Emily.Deng wrote:
>> From: jqdeng <Emily.Deng@amd.com>
>>
>> Only for no job running test case need to do recover in flr
>> notification.
>> For having job in mirror list, then let guest driver to hit job
>> timeout, and then do recover.
>>
>> Signed-off-by: jqdeng <Emily.Deng@amd.com>
>> Change-Id: Ic6234fce46fa1655ba81c4149235eeac75e75868
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 20 +++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 22 ++++++++++++++++++++-
>-
>>   2 files changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> index fe31cbeccfe9..12fe5164aaf3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> @@ -238,6 +238,9 @@ static void xgpu_ai_mailbox_flr_work(struct
>work_struct *work)
>>   struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt,
>flr_work);
>>   struct amdgpu_device *adev = container_of(virt, struct
>amdgpu_device, virt);
>>   int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>> +int i;
>> +bool need_do_recover = true;
>
>
>We should find a better name for "need_do_recover", may be
>"need_to_recover" ?
Thanks, will modify later.
>
>
>> +struct drm_sched_job *job;
>>
>>   /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>>    * otherwise the mailbox msg will be ruined/reseted by
>> @@ -258,10 +261,25 @@ static void xgpu_ai_mailbox_flr_work(struct
>work_struct *work)
>>
>>   flr_done:
>>   up_read(&adev->reset_sem);
>> +for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +struct amdgpu_ring *ring = adev->rings[i];
>> +
>> +if (!ring || !ring->sched.thread)
>> +continue;
>> +
>> +spin_lock(&ring->sched.job_list_lock);
>> +job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
>> +struct drm_sched_job, node);
>> +spin_unlock(&ring->sched.job_list_lock);
>> +if (job) {
>> +need_do_recover = false;
>> +break;
>> +}
>> +}
>
>
>This 1st job retrieval logic can move to a function as there are two
>instance of it.
>Sorry, I didn't get your point.
>
>>
>>   /* Trigger recovery for world switch failure if no TDR */
>>   if (amdgpu_device_should_recover_gpu(adev)
>> -&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
>> +&& (need_do_recover || adev->sdma_timeout ==
>MAX_SCHEDULE_TIMEOUT))
>>   amdgpu_device_gpu_recover(adev, NULL);
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>> index 6f55172e8337..fc92c494df0b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>> @@ -259,6 +259,9 @@ static void xgpu_nv_mailbox_flr_work(struct
>work_struct *work)
>>   struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt,
>flr_work);
>>   struct amdgpu_device *adev = container_of(virt, struct
>amdgpu_device, virt);
>>   int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>> +int i;
>> +bool need_do_recover = true;
>> +struct drm_sched_job *job;
>>
>>   /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>>    * otherwise the mailbox msg will be ruined/reseted by
>> @@ -279,10 +282,25 @@ static void xgpu_nv_mailbox_flr_work(struct
>work_struct *work)
>>
>>   flr_done:
>>   up_read(&adev->reset_sem);
>> +for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +struct amdgpu_ring *ring = adev->rings[i];
>> +
>> +if (!ring || !ring->sched.thread)
>> +continue;
>> +
>> +spin_lock(&ring->sched.job_list_lock);
>> +job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
>> +struct drm_sched_job, node);
>> +spin_unlock(&ring->sched.job_list_lock);
>> +if (job) {
>> +need_do_recover = false;
>> +break;
>> +}
>> +}
>>
>>   /* Trigger recovery for world switch failure if no TDR */
>> -if (amdgpu_device_should_recover_gpu(adev)
>> -&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>> +if (amdgpu_device_should_recover_gpu(adev) && (need_do_recover
>||
>> +adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>>   adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>>   adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>>   adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
