Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9E9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 10:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DE410E1D6;
	Mon, 17 Jan 2022 10:19:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B6510E1B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 10:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIHwKwbA8wZzhUzpZ5hOtp6PiXqmurPzUhQjeEFaQyJ0JdjVa2kMBvCFNJudWWKA4lYAdKrArbr0dc+qWgJJNjkhhPRE+iGxMnwrrC44ndZz/3vbNUXR4rcE3yjgA0zLf0QkdaWy88fpvAvJw8OFYsqf3wSJrs6yM9Bx0HBc8BOFflFf6mLhkAZWQy5PWgpH1hM2yKgR1OrjdwvU7aUhUIPs5lC9t4q1BYTtI8U6fvTnO35qGY7DRFYxmTitu9c9VRqZ6b6oMkV8R7L3lBsG6H25TSTa1TAe4Umv/Ud3CwMWSEP9tyYDDkl58YCyqBJJNzSq4D6bigz3sUkehSWIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEmuNr40aGqI/8KRyAQD7F494h7tguGe/kOci2SUZfM=;
 b=BXZHFuzA66/doOCgCAKsEoIaM/LmrOPpyCx+WnpiIkib2vEkJAyYM17L9xhjIb93zhgq0tFtPnakJpTImwKKJ24pCrbFjw6+HiEQUT5NlQmJXBs5UaESDAynHHox2rKuWdPCEvhg4DH/Hagnxw4TwXeAQEBVNCCqDmALJ8OuFiGcSU4xO83Dw4elBA0EemPIBTRTHur3d3bxcHnPWjeuNEaQ3XRPEoenl4AybzL9PDmv/SHOp8O0m9AGtrx2rX/KIGzVrOoj3rEctJuG++5lCYjYavYy9DsJsWWHUsTbOsWtLAGZnvDWq1mLa49rSpPXmL6WSl0pwjuVolonncXM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEmuNr40aGqI/8KRyAQD7F494h7tguGe/kOci2SUZfM=;
 b=VxCzL5yQiO4SH+um5/Cme7fqlYDJ0R+70oOtQnt5yHa0TrV3mXbwcrnwxvX4cID+M5FpizL4kcfQ6cvKGsGMJdXyCOUIRRVxXW23MOH2auCTDE5576RIdtMjOkkv2C5sUd3nqDXjjvasRj9YxwbShs3O88nKJf7T9GB5v2Xlhjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com (10.174.101.14) by
 DM6PR12MB4810.namprd12.prod.outlook.com (10.141.164.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Mon, 17 Jan 2022 10:19:49 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 10:19:48 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
 <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
Date: Mon, 17 Jan 2022 11:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48)
 To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b90c6f4-4e1b-49ca-3730-08d9d9a2e3e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48100DEF7DC80D1C7469886383579@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lusVqdSvU0AtaK6U/tHCDhk92m5XMBNBg0/Fulop9oe/z6e7He05hrI9gupGQgTn9Xgpu8kXNTIt/amOOHH/NDCq79QTrUpyODTyhGVYtAGG3pg2Exqd9HbfaY/c0BAJLoDfbTMzsef8nL4/RILopx2z7+ipcuA/3STZrmYjxA0hrUTsBaQs1Jhaskyb7tyBx3YmhBuTOZBfcXUxs8eP+VI7r1UGYsklnjL0tKZhh87NYb1DIRoy+Z7OOtvhsVi6n2J4fIfHBSiSgIOvqIm41mxqtHou/3U2pTYRzqF9g4AX4/M/2WUDd+0Z0dupXsPEAhHz1M2NePWdq2lcKj4rS2d62DRXMFAvLXBRsEHxf74kMdCmD+nrwhD1DtBLpKJvWIusNmhq9kZOldUEQT26sKZQJVslMSfsBfZC3HxvinWOnjJ/Mej+1Icht6A4RrrN+zUJfEPU919+NlR37hMzkSfjxlltkYr0O5ZsIoSxq6qSSpAkuHJwuK/h/TpGfzdYJ5hOsGYFcTXeSMix4/LLbuvtR7w4qkCa3nVflD8YJJr1LobnfKLhMUoneUbkgoeqCndpuEsHKg4kjpaYuev9FHUcM67LRrS6oUMvmUPCiWiMq61aPX7azDqJmesKfrI8gqIrepVkvcw5QyLtPDsmQEHzvK0KfeVOMh4biPZNkmfq5SwCOg4KEoUlj19ao0CtdKKZvfBxKEhG2ApkMSk4hlt60jQMwL9m5xQDTnjO2wb7iIS2LolmU2iQJw7ldTat
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(8936002)(6486002)(54906003)(110136005)(36756003)(186003)(86362001)(83380400001)(38100700002)(66946007)(508600001)(6666004)(2906002)(5660300002)(66556008)(316002)(53546011)(66476007)(8676002)(6512007)(6506007)(31696002)(26005)(4326008)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUhqT2wyQ3Zkd05VendoRkdscEpTalJhM3UxY3JiM3pWM0NYM3g1a2VsUWI0?=
 =?utf-8?B?cWRSK1VhVWZubXgrVlBqKzNmMm5sQzlPQmtOWDZMbXc4UW5qN3RicndoeEsx?=
 =?utf-8?B?RndGNmE4Q1FSTEdrK0xiU09ac1RBdmlHRXZsVjR2Wk9xQ25IL1ZqV0NqWjdx?=
 =?utf-8?B?OTNBM1BTRGlONXp4bENGTG1BNy9lY2lmNTFYV3ZuUEV6elhnb2xaaG4vK3BY?=
 =?utf-8?B?WlBuaENiZ0ZmNDdxNlVkcXgwdWVLRkl5UjhJTXRaeG9ESlhlcllKbk00dzdT?=
 =?utf-8?B?L0YrY2R2bkJsZmxaR3dUYjlzWlR4UjlmQmxIbTRlZDZzekR3Q1RCL2hxYW1j?=
 =?utf-8?B?dHZLSE5iU2FOVENGbk4zNGIyNXRTelV5VGU5UFBDWUhvWEh0cUN6RksyWFRG?=
 =?utf-8?B?UTJyRk1YU3BMbi9uYWszTjZQZndmT3RXTUgwKzBFbEliakpmNGxncnhUOVdW?=
 =?utf-8?B?Z1dHUDQzeEtOUW03V1FqWHdkYTVpdk12WVVPeC9LMFFJOHpjVVNsbE9iVlZq?=
 =?utf-8?B?ck8rdExZWmRQYVVYM2NvVkh3Rlo2RG9XVDVNaDI4Z05QTUcyRTdYTkNVcVpQ?=
 =?utf-8?B?TFNUZm5ETitYRGt1ZUpJM21nZ0dUaHFNMzc5TkRPaDRzd2x2emluWHpMNysv?=
 =?utf-8?B?ZEYzQkxtcWNpRjFpcXpwTGE3ZWQwUzdOREdDK2kzbzFoYkc2cmU5d0VJOU82?=
 =?utf-8?B?c2VPWVhXMHVCRzhPOWd2V0V5N0lvNG5maExtUVBCNVJ6TWpvc0kvRkhENzJ2?=
 =?utf-8?B?SUNUbmpTWG9mWmo1d2p5NDBmL2pXVXpHd2l2eUNzbjVRR0Q5bE1aWUU0MnRH?=
 =?utf-8?B?a3NTOU95MWo3WEV0bFAvVE94S3lxT3VuaWY4c1BMVUM4Syt1MGtpRjNNV1R6?=
 =?utf-8?B?UWhMTzQzOGd2b2c5N1M1RVV2c0pFVlNLOVo4ZXRuTlRTYW1TMWYzZDdSeld0?=
 =?utf-8?B?NkxWQ2hyT0NjaU5NVllZYVhCR0Zyb1UzWlJnSnEyWkhvRTFvM0xocHFncEZj?=
 =?utf-8?B?aENmUzRoandtZHBMek40MDNVcGZ1V1ZxNzVvV3ZyZXVwdm5UWWtBSmZHZkdn?=
 =?utf-8?B?cHAvL2M5ai9zd3lrR0dUSDc4UUs2L2tDcEdTNkZBZDVxOXM4dVhaNVdELzRq?=
 =?utf-8?B?cmVlc040ZVJoKzVYOTJ2RWdVclBXd0VCcTZlVCsvOU14cEtRcUNXWlZEZFVU?=
 =?utf-8?B?YzIrcjByb2k0dytuTFNnRmRJRHQrNmZibTZSYytNWDBuc29oMWRwN3ZENHFr?=
 =?utf-8?B?M2tRSmNBOExnd3g2eUNFaEx0ZTk4UkxEbnJjTDJDaWRSMGdtbzArUVFONG9Q?=
 =?utf-8?B?enZLb1dGYkM2L2lmV1VUMUpDUjFmbmJ4c3hvbW10aUN5NVNObHhFNEZnbFEz?=
 =?utf-8?B?S3pvd2paeUFIRVdGQ2JmelVzYmM1T3F6Q0pNTkdwVC9LTVVCT2NKYldENGNP?=
 =?utf-8?B?OVdLOW13bUkyQlVmeGR5V2JiTDdIMzJxdDNlbi85UCtZY08ybWdOUWlGaWEz?=
 =?utf-8?B?SWx1VUhyOEdCSkZZa29FcWgvTVpPajhwNjZTSk9CSTcvRml6ZXBGSkRMRUdG?=
 =?utf-8?B?MXpJNlhSS1gwL2tmNEIyUUg5cGpNdG5aa0pRelZHc1NQMGFVa3h0ejk2RlZz?=
 =?utf-8?B?c3lPaWFyeCtrRWRKSnA4Z25MbTNKOEk0S3pVeEp1UG9TVlRUSnVNbXg0NlJl?=
 =?utf-8?B?MnRHOWUyczFZQjB2SnQ4anZTalZZVUF5dVA0d1o5RXF2d1hrM1FDSUNCUGR5?=
 =?utf-8?B?K1BiYUZ0aXhUVjZTRmZKT09heDVVTXZram1tTVdpTjZIdWJXbDd6ellFbjd3?=
 =?utf-8?B?K3EreUJHdWN5enplVFByZktZNlRLNmM3bkJWdXhGR2hlOHNGTEZMNGhGbitp?=
 =?utf-8?B?SjdFRWlTKzRhQTRlK29DU2V3WHVyOVU3M1pwK0gzQkk0WkdmOGRxdWNsWEFM?=
 =?utf-8?B?Q1NqenRsalZuV3NHVTZxTTZ5emNsbUJuUk1VSWRTY2M4RW5GYlBHREIzL2Nw?=
 =?utf-8?B?SEpvbEZQZXd3Rjg4RHNROXYyZkVkKzRLdmFLTmhOOWEwNDE4UTZ4eEcrWHRi?=
 =?utf-8?B?UVo1OTgvRy8xYktCZjdjdlBPMFQ2cU1tNzJKZ05UbG9ZM1dnT2dmeHRQWGxX?=
 =?utf-8?Q?n8os=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b90c6f4-4e1b-49ca-3730-08d9d9a2e3e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 10:19:48.5495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTVl6WGQ7KwmY/rcL1OQAbV9s4xXiBnB8CtCKzwle7pTMLsgRp5usciK9Ua/VHvA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.01.22 um 11:09 schrieb Somalapuram, Amaranath:
> [AMD Official Use Only]
>
>
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, January 17, 2022 3:33 PM
> To: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
>
> Am 17.01.22 um 11:01 schrieb Somalapuram, Amaranath:
>> [AMD Official Use Only]
>>
>>
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, January 17, 2022 12:57 PM
>> To: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank
>> <Shashank.Sharma@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU
>> reset
>>
>> Am 17.01.22 um 07:33 schrieb Somalapuram Amaranath:
>>> AMDGPURESET uevent added to notify userspace, collect dump_stack and
>>> trace
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/nv.c | 45 +++++++++++++++++++++++++++++++++
>>>     1 file changed, 45 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> b/drivers/gpu/drm/amd/amdgpu/nv.c index 2ec1ffb36b1f..b73147ae41fb
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> @@ -529,10 +529,55 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>>     	}
>>>     }
>>>     
>>> +/**
>>> + * drm_sysfs_reset_event - generate a DRM uevent
>>> + * @dev: DRM device
>>> + *
>>> + * Send a uevent for the DRM device specified by @dev.  Currently we
>>> +only
>>> + * set AMDGPURESET=1 in the uevent environment, but this could be
>>> +expanded to
>>> + * deal with other types of events.
>>> + *
>>> + * Any new uapi should be using the
>>> +drm_sysfs_connector_status_event()
>>> + * for uevents on connector status change.
>>> + */
>>> +void drm_sysfs_reset_event(struct drm_device *dev)
>> This should probably go directly into the DRM subsystem.
>>
>>> +{
>>> +	char *event_string = "AMDGPURESET=1";
>>> +	char *envp[2] = { event_string, NULL };
>>> +
>>> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>> As I said this approach is a clear NAK. We can't allocate any memory when we do a reset.
>>
>> Regards,
>> Christian.
>>
>> Can I do something like this:
>>
>> void drm_sysfs_reset_event(struct drm_device *dev)
>>    {
>> -       char *event_string = "AMDGPURESET=1";
>> -       char *envp[2] = { event_string, NULL };
>> +       char **envp;
>> +
>> +       envp = kcalloc(2,sizeof(char *), GFP_ATOMIC);
>> +       envp[0] = kcalloc(30, sizeof(char), GFP_ATOMIC);
>> +       envp[1] = kcalloc(30, sizeof(char), GFP_ATOMIC);
> No, not really. kobject_uevent_env() will still allocate memory without GFP_ATOMIC.
>
> I think the whole approach of using udev won't work for this.
>
> Regards,
> Christian.
>
> I have tested it with sample applications:
> Gpu reset:
> sudo cat /sys/kernel/debug/dri/0/amdgpu_gpu_recover
>
> And I never missed the AMDGPURESET=1 event in user space,

That's not the problem. Allocating memory when we need to do a reset can 
cause a *HARD* kernel deadlock.

This is absolutely not something we can do and Daniel even tried to add 
a few lockdep annotations for this.

So automated testing scripts will complain that this won't work.

Regards,
Christian.

> even with continues resets with sudo cat /sys/kernel/debug/dri/0/amdgpu_gpu_recover .


>
> Regards,
> S.Amarnath
>> +
>> +       strcpy(envp[0], "AMDGPURESET=1");
>> +       strcpy(envp[1], "");
>> +
>>
>>           kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE,
>> envp);
>> +
>> +       kfree(envp[0]);
>> +       kfree(envp[1]);
>> +       kfree(envp);
>>    }
>>
>> Regards,
>> S.Amarnath
>>
>>> +}
>>> +
>>> +void amdgpu_reset_dumps(struct amdgpu_device *adev) {
>>> +	struct drm_device *ddev = adev_to_drm(adev);
>>> +	int r = 0, i;
>>> +
>>> +	/* original raven doesn't have full asic reset */
>>> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>> +		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>> +		return;
>>> +	for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +		if (!adev->ip_blocks[i].status.valid)
>>> +			continue;
>>> +		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>>> +			continue;
>>> +		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>>> +
>>> +		if (r)
>>> +			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>>> +					adev->ip_blocks[i].version->funcs->name, r);
>>> +	}
>>> +
>>> +	drm_sysfs_reset_event(ddev);
>>> +	dump_stack();
>>> +}
>>> +
>>>     static int nv_asic_reset(struct amdgpu_device *adev)
>>>     {
>>>     	int ret = 0;
>>>     
>>> +	amdgpu_reset_dumps(adev);
>>>     	switch (nv_asic_reset_method(adev)) {
>>>     	case AMD_RESET_METHOD_PCI:
>>>     		dev_info(adev->dev, "PCI reset\n");

