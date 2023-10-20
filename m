Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E220C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 19:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9794F10E5DF;
	Fri, 20 Oct 2023 19:47:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666B210E5DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 19:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2iCLv+nhfLfN+5W8ukcZqRRnHWq1ZEjMQ4B5hHUjA3mFinHL16Z6oj95dXBxMGWUYqHsxzDgj6laLWTI94iMd6wY73ZF4z1f5bH6ETXUzrXONuc90yES7I1LKQVpVxYZUyoeGM/UcUAvw//vTfvom5ddRIFWuWcqz1KANnFe5xSMVjQXUZZgqImt9xw6mEijByX22l9BPA1Rw6ubX/1dF+3RuF09WpPYjiF9bIh0RYzzrB0ETGrxHEqB5K0CjrnakeR7D03+c6Fe7zIKhOXALOf2gxdy84qgCG3KbNPvARUXONuwd+0rJjZxeS33aGBLAz7YCFHrzIJY79NQlesuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oN7heRjvEQ84HxVv9XcccZsoFczl72+FBmEyxXTa2w=;
 b=jwzGiSJazecqAn9anjnUfwOOpO0B69upqQ+6frZFMH12YrnITNmHdgVD9woMCxNt478B+PN0G5F6mcZdCYJCPvZJx3IcgBN8laHclNv+XbQJrn26lP5oM9YKSgRFoQqnuWTDkVTpTyFcCzV0JpWNm/vYXMhmZfuDR6ugoExNlO0mOoUFyRkvqF7/mE+1maG8NGkca2ZPSMiNUA9LZ+ekolLkE4XPWIqeviQ7NtzVnHaPouZt+FmgYqSreyiHGumAnDRkGiM/FBwk0Eoo54+UWa0+eSSVjfTb6PfFF4h1wBQfA89mkYdDkzsqEcnRCE1Vpax84IXAd5aczKXTIqRKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oN7heRjvEQ84HxVv9XcccZsoFczl72+FBmEyxXTa2w=;
 b=zgx7MCtQz5Mxn/P5nrUjphQs++Ywr84f5IMI3NvEt2RnOqinloCt2zhKU5p4Ko5AOi/4b7sclljY/rmDgpD3LHxNaQ6mvpWkUzw2OTAaqi3KdMmVwPZitdF2IFE2N+T/T/ACItImi6gzeS5BjmyptHXPWw+qD0UObyhVQeOuwo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 19:47:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 19:47:09 +0000
Message-ID: <21f7ca52-2060-48ce-8b1c-119fb0717d00@amd.com>
Date: Fri, 20 Oct 2023 15:47:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231020061307.588900-1-Emily.Deng@amd.com>
 <fbf6e76a-547d-423d-987b-9d1260437322@gmail.com>
 <PH0PR12MB5417863B213789488F00ADC98FDBA@PH0PR12MB5417.namprd12.prod.outlook.com>
 <f833c27f-eb11-4191-a3c0-dd81c34fcecf@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f833c27f-eb11-4191-a3c0-dd81c34fcecf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f40bd70-b6a0-4c5b-9268-08dbd1a55918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+K0+E8uSSZfwQPmW6OF5y5uVP1vcF174SsYNWLxSUgqW2ezuYijwKeGw0O9S7yQSJaPRu++DGXf/Z/QWgQhciJ6LrvtwCUk/Uj8x2GvGpYeTu8SQqRb5ZxJnBeSXo5rQoxfG8YLNGdH9knyCJ9Ym3eTwu0by9PbwWz4/Py3CXOm+LCm9TEY36cx3eOxbDJ8sAix/zjiDTEYe5nsplbT7zlJjqvpAwIq03OHq9eskT2OhMQYWLMDMr3NgZeKW1txrXNm/5l8si1jUhNEbKD84eAv5v/Fdeg4p/lE5LsEu4pqzm4Enc9mAA0RrN/Gppcq7xGbQQnEHRBPqAbliRj9/EoW1EXHVcJBYZjmJCa9FBQL2nSamRWX5A8jY6TpxkwBnzvdosRrq7Q3jRL7BAezIPvkHzBXXo+n2VWa1dB+HR2rfzI2nfUJrBOWj1bZRc2QIWp/njNFcoxM4qb7yAbwdM1bZOmB7w1B+fVP18nzSGyGH6iG65CbhfRvmsljxqr/vPURTk9zhB5m6ePMQAb4L01ta3HmXytMFF43hpbmZiPjh1cTM10yl6jrmQxFty6V0Ao3lWN255WBRAgEawC2HzxGl2jOIVJKApz9xApAoEDFqUMfutxBzOUGFWF2CLIGt/py5Z3sbbjd3OY9yuZk6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(2616005)(66574015)(478600001)(66556008)(38100700002)(66476007)(66946007)(36916002)(53546011)(26005)(316002)(110136005)(83380400001)(31686004)(6512007)(6506007)(31696002)(8676002)(44832011)(2906002)(4001150100001)(5660300002)(86362001)(8936002)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHV6SXl1L3RiRkliMnJ1WXp2M3M4dEZYQzNrSGhKRzJ6OCtXc0hKZkFZQ05T?=
 =?utf-8?B?eWo5WVcwVVVNYzlIYjhmNUNFcFNSVFZvaVg0YmJJZmt5cG1kbjFZM3krVTJC?=
 =?utf-8?B?ZGxpM3ZrK1BXT09ROGYvNTlRTjB2OGZweTR5UkZBbkZLV1BadXRGenEwS2RH?=
 =?utf-8?B?dnkwWndDQyswSE5NRy9OeTFDNlBCeFMxUnhvVGRNYll1QjdENTNGYW5GeVMv?=
 =?utf-8?B?RVNDZzZCQS80cmpTQ24xb3cwNHhFTlBiYXFieEdvQzJDN3dWVGtjRzMzc0lh?=
 =?utf-8?B?VGNOR1hZaGtEa0FncnhLLzlVcDFHWGszbjBkaGU3NGx2aTRSeWhhZEJaMFJj?=
 =?utf-8?B?QXN3bFhlRWNPcUZXNUJIcE9BV2luK3A4eU5pV25HMVdmN1lqdHNMYVVGMDhS?=
 =?utf-8?B?UDJYS2ZLZUdmYW94Qi9hcURFVlkyUzJEZENkcFJMa1dQTE9PZnRjZloxZzJH?=
 =?utf-8?B?L0c0NUpWL2VraG1QR3F5alVQTU9CSEJkMm1QTTVXRUlXcytQRENWRlA4bFFN?=
 =?utf-8?B?MFhDVHdwVFhoNzR0TVFleVZoMndLQVJBcERQWHorZ2VERVJybExSSnl4cm5z?=
 =?utf-8?B?RDVmc0xEMVA2R01JS1JYb05yblFUTHprdVBaamRrRFh3ZHZxT3JjaVRlNzhM?=
 =?utf-8?B?NTh0T3BROVlNSTczL3U4bEE3ZUt3TFRYbW5WVEpzNmJiMHZTWmNwc2tzU0Zu?=
 =?utf-8?B?Q1FzUkJ2S05EMVI3OSt4NTNmSkZPVTBMb21NbGxEV3F0alpJbXNjYU0wSGR2?=
 =?utf-8?B?NEZuWW1JM05pZnhuU0RrSDdGV1pXSW5CMVErSC9VWTBkNmZSZDBrYWFTSUN3?=
 =?utf-8?B?RnVWUXpaR2VDQ2R1QVlCYTJxYVNHRzB2OHkrWXVOUVVNRXZjdTVjS01VY2FE?=
 =?utf-8?B?L2F2SnV6TGJaWDdCWHU0djU4eFNOQVBLYUVuMUxMY01UbGVPcUFlbDVYSHZO?=
 =?utf-8?B?cVlmY1U0Z0RWa3hoUnNVb2tXZzlvU0FmclBDdHV0d3dWVFlrY2VKR1hQSXNZ?=
 =?utf-8?B?UGFjcFdZZXFXejVkSDd2b1Nvcnl0VXBQUWNPbmpTN1lPZ3ZvTWxwWFFUMi9G?=
 =?utf-8?B?RCtIVGdxb1U2YW4ydWVYUE15S2dHR0ZYVjUzWGt6N0ZJbEwrSXJSVGswbnBq?=
 =?utf-8?B?R3hwUFA2Mm8yZDZtYnMzaDdPOGk1KzNUTGpPTUY2Q2l4M3lvSkRRSmlwMVRO?=
 =?utf-8?B?SnIvY0xMUFpxeEs3UUo4UktoV01VTVVENHhrZE5VVFlIN3dGZ3VDRUk0MHZ4?=
 =?utf-8?B?NTFaSEpiOUw5Tmp6SmpJQUVQVjNoKzJwemxJTkFIMnovUDlhVW1RMWlBZVlF?=
 =?utf-8?B?elkyZy9ZSlFKTVcxUE1NNmx6Rm0yejREeXc5WUdTYnVFNW8vYmtyd1dvc2Jn?=
 =?utf-8?B?bGtLZTFZSTlFR1J6YmJLbEhTeHdhUXp5Y2lCOXkvbERIL01rTkxWK0xHOTFU?=
 =?utf-8?B?a0FGUTQ1UHJGcFdJZm1qdzlZSnFiUlhRMjlSZFE3NVdUN0grYzhnUzB2anhJ?=
 =?utf-8?B?dnhyZEpscjY1ZkFVMTZ4VUQ3UFZzbUxpTUZFYTdXUnMzM0RveUdGZkFicTdF?=
 =?utf-8?B?TlV5RFkzUWFIcFdFWlNuK1FmWHNMVDhXSXlRZkVLQ3E1Z09vRThYSWFkN3BF?=
 =?utf-8?B?alVMN3kwc2JGNENLM1ZMU1NGM0RjTWRKMkxnVEJmbzk3NERwOFBRdmhWSVJX?=
 =?utf-8?B?MFlLNzQ5NFJFUkZXUUJvby9nakZrZFE2TFYvczhQMTRRQVU1bDRZMjc3cWF3?=
 =?utf-8?B?NTVlM3UybkU4Wm53VWJ0VEJuQXFVQlZpNTZkbzh2Vyttb1AwVE9lVnZNVGxE?=
 =?utf-8?B?a1hYaDE4RnBrY0VUcXhkM1kzOEdCTkZycnFhL1hudUJQTnFuQXdEdmo4dXVB?=
 =?utf-8?B?cjVhbHpNczVONUx4TkxRbVlCd3gyRzVEK054dkNmb3JpbkJYbnlERmZNektx?=
 =?utf-8?B?R1hDRFRBQlR5NHYrVXZmYTdMUkhvd0wxZ0dXc0VsSHNqMTM0ZTNqV2QxanBY?=
 =?utf-8?B?NU5KYWJQRERJcmxiSnRXOEtkNGszNUU5ZFZDbFNLRFhTNTVmQS8vajIxZ1ZM?=
 =?utf-8?B?NnhwcjY2WEQ3RDFVbDVSWCs1WEplUEpjRkl6RVZHandjWWZQVzVzeXg1eFNl?=
 =?utf-8?Q?V3bCrWhXVadYxgnlGSQk5gzUn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f40bd70-b6a0-4c5b-9268-08dbd1a55918
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 19:47:09.9037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hZ3QoOtzfyrsBX0B2gjIOn8CGs9UzHzxgMmarAZumViyBdfXtBRFlJqc5eAHZDZojAW6riIzO0UQElK7jqXJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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


On 2023-10-20 09:10, Christian König wrote:
> No, the wait forever is what is expected and perfectly valid user 
> experience.
>
> Waiting with a timeout on the other hand sounds like a really bad idea 
> to me.
>
> Every wait with a timeout needs a justification, e.g. for example that 
> userspace explicitly specified it. And I absolutely don't see that here.
In this case the wait is in a kernel worker thread, and the wait is not 
interruptible. Not having a timeout means, you can have a kernel worker 
stuck forever. The restore worker also has retry logic already, so it 
can handle a timeout perfectly well. But maybe this shouldn't be done 
automatically for all callers of amdgpu_sync_wait, but only for this 
particular caller in the restore_process_worker. So we'd need to add a 
timeout parameter to amdgpu_sync_wait.

Regards,
   Felix


>
> Regards,
> Christian.
>
> Am 20.10.23 um 10:52 schrieb Deng, Emily:
>> [AMD Official Use Only - General]
>>
>> Hi Christian,
>>       The issue is running a compute hang with a quark and trigger a 
>> compute job timeout. For compute, the timeout setting is 60s, but for 
>> gfx and sdma, it is 10s.
>> So, get the timeout from the sched is reasonable for different sched.
>>      And if wait timeout, it will print error, so won't hint real 
>> issues. And even it has real issue, the wait forever is bad user 
>> experience, and driver couldn't work anymore.
>>
>> Emily Deng
>> Best Wishes
>>
>>
>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Friday, October 20, 2023 3:29 PM
>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
>>>
>>> Am 20.10.23 um 08:13 schrieb Emily Deng:
>>>> Issue: Dead heappen during gpu recover, the call sequence as below:
>>>>
>>>> amdgpu_device_gpu_recover->amdgpu_amdkfd_pre_reset-
>>>> flush_delayed_work
>>>> -> amdgpu_amdkfd_gpuvm_restore_process_bos->amdgpu_sync_wait
>>>>
>>>> It is because the amdgpu_sync_wait is waiting for the bad job's fence,
>>>> and never return, so the recover couldn't continue.
>>>>
>>>>
>>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 11 +++++++++--
>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> index dcd8c066bc1f..6253d6aab7f8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> @@ -406,8 +406,15 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync,
>>> bool intr)
>>>>       int i, r;
>>>>
>>>>       hash_for_each_safe(sync->fences, i, tmp, e, node) {
>>>> -            r = dma_fence_wait(e->fence, intr);
>>>> -            if (r)
>>>> +            struct drm_sched_fence *s_fence = to_drm_sched_fence(e-
>>>> fence);
>>>> +            long timeout = msecs_to_jiffies(10000);
>>> That handling doesn't make much sense. If you need a timeout then 
>>> you need
>>> a timeout for the whole function.
>>>
>>> Additional to that timeouts often just hide real problems which 
>>> needs fixing.
>>>
>>> So this here needs a much better justification otherwise it's a 
>>> pretty clear NAK.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +
>>>> +            if (s_fence)
>>>> +                    timeout = s_fence->sched->timeout;
>>>> +
>>>> +            if (r == 0)
>>>> +                    r = -ETIMEDOUT;
>>>> +            if (r < 0)
>>>>                       return r;
>>>>
>>>>               amdgpu_sync_entry_free(e);
>
