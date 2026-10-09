Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C173ACA6015
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 04:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238B010EA74;
	Fri,  9 Oct 2026 04:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="06ZokIVq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6729310EA74
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 04:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtfmZM7y+Mp+pic6RcJ4Mkdv/2l7DI31kLvjienwp2mURfHPBp/wBys+/duSpywKDnaH7pmRpAovY7+tQ5GCTDnN4ZEr5zA7bPXK3dDLGEKGa7vrMGDXkPxbGRuw6z/ShVqSMc+EoV1mcIvK77eZPg9n2tBzmI1PkaRaQ1qoQ5/qTsvgAq/R3lRS+leWyKystDmtCDzS+Q/4NpjgEszAW/9HKwMOQvbfDe5Qd7KL0KjuGBxn4rKCPYkHiUjoqqFmds5ezBa6JG/yINC1Me2Q6HLDKbIAwvLcAqj4d6mBXeijzH/H4AwAEv07WsQeRpASSSdD68Q3rJ5SVHIynt9wOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkCJtE62bc892Uw3JHx+3VJl6XR62BcjlM5N2re3jgw=;
 b=rK0Oe/841O2CJppoLD4JmQ78S4/I6690OcNZF2wSXga/5M9dxiscLCkBFHfK8hrE+FbOLeUNHp7FDmXBQqOSBZQfr9oSraZ1bMv+azetGrkyKY+xGU46la78uhmljhQ5KmqEejoB2ySFNVazqm/0pHG+DT1ao5xY54UqsjPkKkJ0nOWU6DAuishubNBLMVxvCMSfYLU8lLRcjC3Gu7LnWocytnC8zmLHi3nFDYlxo1jHfnTquA0IygJSvuzU2r+xmQNcPldtk19yvVWBrduWWLLAjvGFOjNNXjNiW02yscFAyV1IuQxOLHcUWxsVXWLztTbCc8HfBHbI7OALd0rPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkCJtE62bc892Uw3JHx+3VJl6XR62BcjlM5N2re3jgw=;
 b=06ZokIVqQ9F6ejrAURZaJ62Yxsi/K3Tfipk1fnRr0Wkt2IMpzAG1Gvyp8DdTm8vboyuzhksVxdp+ka7F97XNox0YaFZDYdsrysa4zjfGnqOHPfrKSB3B9xbOgq880ki1oMb4SxsT2dKAdvTBJBqiHlzusZDW6GnKMFhUCOh3dso=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 04:50:12 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Fri, 9 Oct 2026
 04:50:12 +0000
Message-ID: <7f51bd62-7a74-4cbc-95d1-5c31d52fde31@amd.com>
Date: Fri, 9 Oct 2026 10:20:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
 <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
 <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB600066077324CFC6B1BAA16FFB922@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB600066077324CFC6B1BAA16FFB922@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0298.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: c19285a1-2c5a-4048-78a2-08df25c0cd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: oajP4C9NmWQuTO32zyHoTTzlyGja3AFFFmb+4y6vvEhWnK2d2MmZl2ffUs/Ed00hCWYWlOAjP+bGCmlzxIUFzK/+CyeftUhmfpjYmo1+qaevP9nozqYCqNWTXT1AU8xxHRp8RXHtZjHWhm4CvGFFLTI+MA74qRpmRuI9xBavHeuCMCBGpaZzf3a4SpeEgxOQFUGG2Vo8M6PsNtpphBN3Keye7dw2Pn4H5ALrO+7pUgA7AkkeqEzwzDFTpYO/E4MFYlUYvYEeODlyg/0S4qRRpXkzXri7UXRVcb5Ycf8OSB0KZjTjyfxtBtVhzgn6mgvIhhpYWYpFxgmRadMwtzGQIw0pEJdIlB9ll7mSQ9LUyG+fq3k4lEar9smkknpFQT3CMb3zFxgLrgrJBJs5qsaop4OdSuZ+OXz8jCn+RN8uvHixZJIBIZppfkZabRmkUJLCC3DWLzE0swWIcoJ3PiViLhLQKGJcugLti12rMsGYgZCkc6eTLFnt3UTaddDZaiakhiENQjZ3LEsP7VGtnPUR1oETrqzoZNqAU0FM3U/mvapMgvUev2/7JwISMpp3Dip+jPlJ5VUKF6kyTi2XFFAL9jAgYrawkrDtXmjxtm0r9XcK16Mis5YubkC8Gz4+9GlTK5u2IaSNwDl9mcZOggX35wGTnag57x7ncpBOu6WUyWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkpxVVJMVDZNQVU5MmpYLzhDcmJvZWV2MFIrd05NQk5mS0JxS0NTKzBLMFNl?=
 =?utf-8?B?OC9WbDQzcFYyeCtsTVEzb1duWEtyWnVuM2xDTmtpWkNWRDl6Zmk4eU1BdWtZ?=
 =?utf-8?B?SmNDTnZUQXlFU1hLdTJhcGZnZmhhOFRrbWRycEpjZDg1aGQ2cm01QjNiR1Fs?=
 =?utf-8?B?Zm5mY29qN0JIVnFqZURGZHpGR1BLUjMwYUlUMGJja0twOURJcm9UR1hUeWp5?=
 =?utf-8?B?cENWN3lKamVWMXpUcEJhT3RVaWRUQXNRcTNueWsrSkNNMlp4YmFqaVRKc3Fp?=
 =?utf-8?B?WnlLRVVMdjg4TjY0Ykgrc00rdTVYUnRiaTZvUlVYQnpjSW5ldjBOVTVBT0gr?=
 =?utf-8?B?d3dTSGRZWFMxbTRVejhOYmhZazBkeUxtVVVmY2l4TWc0VElHYjBicEQ4aytr?=
 =?utf-8?B?U3AwVjV0b2NWQmE1NTlrN2hjUHBjdUlTei9aRGJKeE5hYy9hcTJRL3laNzBQ?=
 =?utf-8?B?cXZLZ2RrSDZFc2ZoSldqdmxoWHY3THFnQ09UMWw2SE0yNFM4N2FqdWJxMjUy?=
 =?utf-8?B?SmRQOXE4NmVtL1JRYmMyczVkQ0hrRzFMcWRnZk1URlBvUXJBSGpRNEFrV0FF?=
 =?utf-8?B?NTNuenU0K3pOdUdvZ2E3UUlpK29Ia0x2aURXUXNSWHNyRTducUxpL3N1Y1lT?=
 =?utf-8?B?ZmJHZURxUVI4a0padXk4ZmV0NFRwSXh3UTFRSWs3L1RHdE5KZGU2UHNNcUpa?=
 =?utf-8?B?bFpNNjU2bzRIc3YwVVNOQXVtUnpJYjFxUjN5T2ZnSXR5UDVwSkUrTmV0blBR?=
 =?utf-8?B?MzVnc0RzNlgybFNPSElFeEYyMTNUdVhFRVhjSFRqZGczSVNoRkw1VTYzQmRo?=
 =?utf-8?B?SzJ4WlNGRVdudnBlVTNJemQvN2dIWkdpczlUUXZWNG1SOEJSTXJKMzdFMXB5?=
 =?utf-8?B?d2hSd29id1BNK25HbVRmN0swNlpKNzRDV2hUcXRXTy9FZU9PaHR0TXlGRHdX?=
 =?utf-8?B?RDl2SlpiUVVpT0hFVGRZQzhwUkwzTFh4Y1lGSkVYeUsxQVdwS1FyaTFuYStx?=
 =?utf-8?B?bVJpU2hJV25JOSs5VENBc01DZ2tyYy9LeEpld2kycHg2OXJrMGwwWStnOFlr?=
 =?utf-8?B?T3QxRTNHOTJjbm1wMUNWN2xRcjZpaEViQW1FTms1L1FQREhBNlhKZlk3MEtT?=
 =?utf-8?B?aHAzNEwvcHVIVks5UmF5dnN6cjhld1VGMDMwQlQzUm9qM0Q3Z0JEb2Z4ZE15?=
 =?utf-8?B?ckpldDhJLzJScGdhSlZOdjhIU0p5dlJBZ2JobXFwaXIySndyR3JUK0tRNVZC?=
 =?utf-8?B?dzRDSVB3WmNBOEVWenFqbjh4MGdBME5ZcEMydHp5ODh5dHA5NkpRYUp5cUZJ?=
 =?utf-8?B?UWV5OXh3WnpIZTh0bjBNRHNtckcxVGo0bmc1dUxlUzBzeis5clc2NnRzdFJ0?=
 =?utf-8?B?S3dybW9DeUMweUdvbVZIMFVzcFY4bytYcEp0TDFoVFMrams4WmVmNUs1RmQz?=
 =?utf-8?B?MFVOSU1WRmxmcFh6RlNhcnJZR2dNMGcyNGlxdUZydGMxQVJ1SkZlajlhWEF0?=
 =?utf-8?B?U3YxUkFRZURwY1NxTUMrbVliK1JZMDF2Ly8rc2JGTEVNc0pxdng1djRlalFB?=
 =?utf-8?B?TjVhb0drZG9MODBxSzYrdmZJdDUxWllaUndLZkVQMitreVJTSDFzQ00rdmV5?=
 =?utf-8?B?dkNMZHM1RVZFS3EzSXJDcTMyYmZzcU9sSkQzNGR1bzNFQTlWUmVCa0d3K29m?=
 =?utf-8?B?WW1JWSt3Tlh0eDRTRlJ0MFZlZDZTaGlvTmQrNUQ3THExQTBIb0VvOEZBWjAy?=
 =?utf-8?B?L0luYzd4SGtXREltc2FxQ0RhbWFlMkJGNzZhZk9CdWVDZi92V1h3SnFISGV3?=
 =?utf-8?B?T0ZiTlI0WURBaklVaXRxVmRmTHhMcmU0cEhVTndPZ1VmN3cvcEJabHA0UUY2?=
 =?utf-8?B?UXVXc1VESWprNExOQWVPWHFYV3FDdGhoTlJFYS93M3BXRWtHRjc2OWcybEww?=
 =?utf-8?B?OUY5cWswRjhpcXQ3d0JpUjlXenRHQVY4VnFzVml0L3BTT2lxbEZVekR5aE0r?=
 =?utf-8?B?bU5KUS80cWV6TzF4U29YL0ZLWXM4b211Wkc2OTJHd3lGa25lRFpXL0xaeVBo?=
 =?utf-8?B?TW5rMUpZeDBPMXJZVUdiajEyZXJBZUNGRmtsZ0pubnpYWFpYdjJpV0tkU1Bx?=
 =?utf-8?B?NCtVMC9KbVNyU0c2cHBtK05mejRBU25wdWNpL3hjOEFUS0NoNFQyem9hQ0lT?=
 =?utf-8?B?eDBpc3RDc1o3N050ZnA2enliWnNZUnJIQnFXVEFFNHNKNG5XZzNjVVRtWW14?=
 =?utf-8?B?UERVUDlCcVZ0Zy81K2Qza01TamExeE1RR1ErbGkvTG1OVmZmRzVJQk5WUTB1?=
 =?utf-8?Q?lqGG/iM1dO4KYr5i9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19285a1-2c5a-4048-78a2-08df25c0cd24
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:50:11.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0W6fDhX80hYo586jkXWFEF0RyR3vVCjk2J4hp77K7QIBRVQx3L5kXlacogQlHrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 09-Oct-26 9:13 AM, Liang, Prike wrote:
> AMD General
> 
> Regards,
>        Prike
> 
>> -----Original Message-----
>> From: Liang, Prike
>> Sent: Thursday, October 8, 2026 8:42 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>> <Vitaly.Prosyak@amd.com>
>> Subject: RE: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
>> GPU reset
>>
>>
>>
>> Regards,
>>        Prike
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Thursday, October 8, 2026 8:34 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Liang, Prike
>>> <Prike.Liang@amd.com>; amd- gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>>> <Vitaly.Prosyak@amd.com>
>>> Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work
>>> across GPU reset
>>>
>>> On 10/8/26 14:17, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 29-Sep-26 9:16 AM, Prike Liang wrote:
>>>>> Protect media idle workers with a reset-domain read trylock. On
>>>>> contention, requeue the idle timeout and return without hardware
>>>>> access. Keep the ordinary end-use scheduling event, including from
>>>>> reset-time ring tests, so otherwise idle engines eventually power
>>>>> down and VCN
>>> drops its profile.
>>>>>
>>>>> A blocking read acquisition would deadlock with reset-time
>>>>> synchronous cancellation of these workers, so the workers must only try the
>> lock.
>>>>>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 7 +++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 7 +++++++
>>>>>    2 files changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>> index 9887a4f99aed..7b10260ad0d4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>> @@ -114,6 +114,12 @@ static void
>>>>> amdgpu_jpeg_idle_work_handler(struct
>>>>> work_struct *work)
>>>>>        unsigned int fences = 0;
>>>>>        unsigned int i, j;
>>>>>    +    /* Reset may cancel this worker synchronously while holding
>>>>> the writer. */
>>>>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>>>>> +        schedule_delayed_work(&adev->jpeg.idle_work,
>>>>> +JPEG_IDLE_TIMEOUT);
>>>>
>>>> Is there any need to schedule this work here? Being not able to get
>>>> the lock
>>> indicates that a reset is in progress already.
>>>
>>> Yeah agree. We should just block for the GPU reset to finish.
>>>
>>> So a simple down_read(&adev->reset_domain->sem) should do it.
>>
>> This patch wants to schedule a delay idle work during processing a gpu reset
>> process, and then retry to run the VCN idle at the next scheduled loop.
> 
> A potential deadlock can occur if the VCN/JPEG idle worker runs during a GPU reset while performing a blocking wait for the reset to complete. This patch resolves the issue by using a retry-based wait on the GPU reset semaphore within the idle worker callback.
> 

VCN is going to be idle after a reset. The next idle worker will be 
scheduled after a fresh job submission is complete. Why we need to 
reschedule idle work here?

Thanks,
Lijo

> Thanks,
>   Prike
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>        for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>>>>            if (adev->jpeg.harvest_config & (1U << i))
>>>>>                continue;
>>>>> @@ -129,6 +135,7 @@ static void
>>>>> amdgpu_jpeg_idle_work_handler(struct
>>>>> work_struct *work)
>>>>>            mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>>>>>        } else
>>>>>            schedule_delayed_work(&adev->jpeg.idle_work,
>>>>> JPEG_IDLE_TIMEOUT);
>>>>> +    up_read(&adev->reset_domain->sem);
>>>>>    }
>>>>>      void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring) diff
>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> index 17db7264269e..f851a6ecea1b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> @@ -470,6 +470,12 @@ static void
>>>>> amdgpu_vcn_idle_work_handler(struct
>>>>> work_struct *work)
>>>>>        if (adev->vcn.harvest_config & (1 << i))
>>>>>            return;
>>>>>    +    /* Reset may cancel this worker synchronously while holding
>>>>> the writer. */
>>>>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>>>>> +        schedule_delayed_work(&vcn_inst->idle_work,
>>>>> +VCN_IDLE_TIMEOUT);
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>        for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>            fence[i] +=
>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>    @@ -499,6 +505,7 @@ static void
>>>>> amdgpu_vcn_idle_work_handler(struct
>>>>> work_struct *work)
>>>>>        } else {
>>>>>            schedule_delayed_work(&vcn_inst->idle_work,
>>>>> VCN_IDLE_TIMEOUT);
>>>>>        }
>>>>> +    up_read(&adev->reset_domain->sem);
>>>>>    }
>>>>>      void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>
> 

