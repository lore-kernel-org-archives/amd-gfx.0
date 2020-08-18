Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CAEC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 08:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BAC2067C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 08:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sdX6eh9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BAC2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3100389BAB;
	Tue, 18 Aug 2020 08:31:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732CC89BAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 08:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR4HpJe6JSKuibkczC8HBUap3TkgOAvvNRnqeCCQdehAVIxglaqTbpg4jtn5431g/LF0ohHKWoLCd0zB5lm1tIfqpvuuXhylGps39CjQKuKX3ltDjooQdcJVVfPROtAr4kxNJ4yCocPyt/YhdtgY1VsI8B/8mOeSIutcgeCJ/DDDzCoheFoiw+DSwUtFLXQhj4d7xIkJ2YjHrwfH20n+eJsordvMVSMA17e9DME3XCmXrFcqa1hRo2QIyW8/7yWdds9oCus2pd5vl+TDLBp08s5w2Bk1CXR8PKJCsa1fElRaV2YUaScs1GFxYzNGJ0oP5h4p+LJ8eBFIcn4Ufftn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLoqx7VanZpd+lfUypqK4ZgNCbZlsCjRkN4yR08/Zyk=;
 b=DB1oyYcb828c6tKiyXL8S9Wcr1p3svJ8LZoqbOVv55cQKBqRDrb3Uw0cP2UTCZLVA4bpaNymTfgHIPX2gu73K+yT0sxot7Cs+IYfpYdsSYazy2hzuZPsn/mmL3MN9ol92gDQ2cEAtJaElmNEuTkn5s36LPtV45NzEfe00wXLE3hsUc6U6vc2aXwupc9f2qrzjAgyXZTG9gZXmgemraq1sbTCOt5TlZhAPC/UWUyCXryOikzMrPJQfks6TUZFAxUC8g0OwRFcviQb4/qSR3h3JIxaQOvzk+rgRbbH61ZbSe8fSykFCwEgirZ+s3H94Dlg26BC6wVqtT4htvubMVe/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLoqx7VanZpd+lfUypqK4ZgNCbZlsCjRkN4yR08/Zyk=;
 b=sdX6eh9tvXjq2qqqDEnniICrQQpR5Kb4ZAvjkKu/sKcGVWM4Y94LQWjadFs/83pSbHZinYuPv2SP38827rPJ3jwRdsGn92uLY3gtKi+76OhhrS7MEo8r/d+1oIX2d+fLFbRnA2iX7LBWcT49ZspzAXmwkgijUlKHZygSEQakrZ4=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 08:31:23 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%8]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 08:31:23 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix repeatly flr issue
Thread-Topic: [PATCH] drm/amdgpu: Fix repeatly flr issue
Thread-Index: AQHWcInAiazTtQfKHE6yg/8HiShlpqk0ZDoAgAjOwmCAAF1DAIAAAmkA
Date: Tue, 18 Aug 2020 08:31:23 +0000
Message-ID: <BY5PR12MB41158C3E907E5DA84AFBFA548F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200812091943.438905-1-Emily.Deng@amd.com>
 <71d5893c-453f-7c3e-7a20-e1234920dbba@amd.com>
 <BY5PR12MB411548B0210D9C173431A7A78F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <25565c81-f902-7e1a-7282-e9ef4e34e6ba@amd.com>
In-Reply-To: <25565c81-f902-7e1a-7282-e9ef4e34e6ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c776cb82-95de-4ed8-9928-ec518dcccde3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-18T08:30:46Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 809e0514-1825-4da0-b644-08d84351178b
x-ms-traffictypediagnostic: BYAPR12MB2840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28402D82500110721AE700AD8F5C0@BYAPR12MB2840.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzNOYIN2O03g5bVk3ryd81tUiLVOJw4Zo/BNk/wt0b0Cpk3dVC8xo6ugF2DjyGS06sdg7cM1rqlbMxVeZIVJCfA3sRx3Y2FpJeaqYTjX0hD/QWj3HdxujwbIinuRaUvOlOWbIdKAWMqvl7RkS1+lO+RsGhlDpKaq7yhQOcmb2OybbZocDiIRDTxd1LJ5/e4T/7B2IWQUovX3yw6h2W/Yc4+ALGLG7D3qF29phbAi45gFe+JcjLdBB1CyxySMdJ2uT8d7aV7X6SXpec4nj1j/NhV9RQ6e58ymDsjZSQw1+C3UeLnLxbMK782ezeI70vP8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(52536014)(478600001)(7696005)(9686003)(26005)(53546011)(86362001)(55016002)(6506007)(8676002)(83380400001)(64756008)(66476007)(66446008)(8936002)(2906002)(76116006)(66946007)(66556008)(110136005)(71200400001)(33656002)(5660300002)(316002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: E9f77JFsU8oqVD8i9ilKcC7XHwKb/7cINRXLPZI53ZGnUzym77iT95XKgZqSNnGK0uSk7J9meskNSo5hkzqphM+L+NE7rve2L18gZkWn5a0dEBzWFucfWxajIW/fjQ56zyRjeYbKxq9nubCgiEPABWKVakB3gCBNspI2eVzhP950xpEbTZG8lYDEu0321G1Jn59FMTBroF0h8657EOwZkC7HvEIBMUMbA4SsC4cxjX8TH9zKy9jS5XsV4bb+XeOnrgvOjfh+tWLJUE93xBdss77OqYCKAKZ1NA7gYKBPbFAuDEPlsCaWow0RDZ1O0vUeQXf/kBhjS3L6PmxLZ3i06lKHE0K8ZlYMgZsTMCjNviI4UNWjIY+wmHmBRSM/XgdmBGT1QQ27+zDgQRQOsXIK7mnTuJ1Zl68oXnEe0HAWnbF4sbOw9RO0tJwTcuhQE7q5wMmqLZSZKrwpBp33ahjBr7iekkwNY6rK8nbOBsZvQ/CgckNa6dq28+01aQtCaaVNGWM6K2S6OnXZ8SHbsalscYKTNacYdRcMADidGrqdiNY0/niJ3SyP7mavbEgk3O7oDJB61sqkam+dwROYX/Vi2Y+j9b7JHlT4DC152KuHqhRpYhMgTLeI7p8uzGjDzeJY+ugvdXfD7/1tUKsNURxqAw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809e0514-1825-4da0-b644-08d84351178b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 08:31:23.7786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9YiOUfxauP0kd+J0xLY8OePQumQrYd1jzNsUqjlXqqV7HtC1dDkXnFRST7jNdjD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
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
>Sent: Tuesday, August 18, 2020 4:22 PM
>To: Deng, Emily <Emily.Deng@amd.com>; Das, Nirmoy
><Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: Fix repeatly flr issue
>
>
>On 8/18/20 4:48 AM, Deng, Emily wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: Das, Nirmoy <Nirmoy.Das@amd.com>
>>> Sent: Wednesday, August 12, 2020 8:18 PM
>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu: Fix repeatly flr issue
>>>
>>>
>>> On 8/12/20 11:19 AM, Emily.Deng wrote:
>>>> From: jqdeng <Emily.Deng@amd.com>
>>>>
>>>> Only for no job running test case need to do recover in flr
>>>> notification.
>>>> For having job in mirror list, then let guest driver to hit job
>>>> timeout, and then do recover.
>>>>
>>>> Signed-off-by: jqdeng <Emily.Deng@amd.com>
>>>> Change-Id: Ic6234fce46fa1655ba81c4149235eeac75e75868
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 20
>+++++++++++++++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 22
>++++++++++++++++++++-
>>> -
>>>>    2 files changed, 39 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> index fe31cbeccfe9..12fe5164aaf3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> @@ -238,6 +238,9 @@ static void xgpu_ai_mailbox_flr_work(struct
>>> work_struct *work)
>>>>    struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt,
>>> flr_work);
>>>>    struct amdgpu_device *adev = container_of(virt, struct
>>> amdgpu_device, virt);
>>>>    int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>> +int i;
>>>> +bool need_do_recover = true;
>>>
>>> We should find a better name for "need_do_recover", may be
>>> "need_to_recover" ?
>> Thanks, will modify later.
>>>
>>>> +struct drm_sched_job *job;
>>>>
>>>>    /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>>>>     * otherwise the mailbox msg will be ruined/reseted by @@ -258,10
>>>> +261,25 @@ static void xgpu_ai_mailbox_flr_work(struct
>>> work_struct *work)
>>>>    flr_done:
>>>>    up_read(&adev->reset_sem);
>>>> +for (i = 0; i < AMDGPU_MAX_RINGS; ++i) { struct amdgpu_ring *ring =
>>>> +adev->rings[i];
>>>> +
>>>> +if (!ring || !ring->sched.thread)
>>>> +continue;
>>>> +
>>>> +spin_lock(&ring->sched.job_list_lock);
>>>> +job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
>>>> +struct drm_sched_job, node);
>>>> +spin_unlock(&ring->sched.job_list_lock);
>>>> +if (job) {
>>>> +need_do_recover = false;
>>>> +break;
>>>> +}
>>>> +}
>>>
>>> This 1st job retrieval logic can move to a function as there are two
>>> instance of it.
>>> Sorry, I didn't get your point.
>
>
>xgpu_ai_mailbox_flr_work() and xgpu_nv_mailbox_flr_work() are using same
>logic under "flr_done:"  label trying to retrieve 1st job entry to determine if
>we should do recover or not.
>
>We could move that logic into a function like:
>
>
>bool function_name ()
>{
>for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>struct amdgpu_ring *ring = adev->rings[i];
>
>if (!ring || !ring->sched.thread)
>continue;
>
>spin_lock(&ring->sched.job_list_lock);
>job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
>struct drm_sched_job, node);
>spin_unlock(&ring->sched.job_list_lock);
>if (job)
>return true;
>
>}
>
>return false;
>}
>
>and use that in xgpu_ai_mailbox_flr_work() and
>xgpu_nv_mailbox_flr_work() instead of
>
>having two copy of that logic.
Understand completely now. Thanks.
>
>
>
>Nirmoy
>
>>>
>>>>    /* Trigger recovery for world switch failure if no TDR */
>>>>    if (amdgpu_device_should_recover_gpu(adev)
>>>> -&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
>>>> +&& (need_do_recover || adev->sdma_timeout ==
>>> MAX_SCHEDULE_TIMEOUT))
>>>>    amdgpu_device_gpu_recover(adev, NULL);
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>> index 6f55172e8337..fc92c494df0b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>> @@ -259,6 +259,9 @@ static void xgpu_nv_mailbox_flr_work(struct
>>> work_struct *work)
>>>>    struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt,
>>> flr_work);
>>>>    struct amdgpu_device *adev = container_of(virt, struct
>>> amdgpu_device, virt);
>>>>    int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>> +int i;
>>>> +bool need_do_recover = true;
>>>> +struct drm_sched_job *job;
>>>>
>>>>    /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>>>>     * otherwise the mailbox msg will be ruined/reseted by @@ -279,10
>>>> +282,25 @@ static void xgpu_nv_mailbox_flr_work(struct
>>> work_struct *work)
>>>>    flr_done:
>>>>    up_read(&adev->reset_sem);
>>>> +for (i = 0; i < AMDGPU_MAX_RINGS; ++i) { struct amdgpu_ring *ring =
>>>> +adev->rings[i];
>>>> +
>>>> +if (!ring || !ring->sched.thread)
>>>> +continue;
>>>> +
>>>> +spin_lock(&ring->sched.job_list_lock);
>>>> +job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
>>>> +struct drm_sched_job, node);
>>>> +spin_unlock(&ring->sched.job_list_lock);
>>>> +if (job) {
>>>> +need_do_recover = false;
>>>> +break;
>>>> +}
>>>> +}
>>>>
>>>>    /* Trigger recovery for world switch failure if no TDR */ -if
>>>> (amdgpu_device_should_recover_gpu(adev)
>>>> -&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>> +if (amdgpu_device_should_recover_gpu(adev) && (need_do_recover
>>> ||
>>>> +adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>>    adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>>    adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>>    adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
