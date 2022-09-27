Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CD8C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 15:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275C310E96C;
	Tue, 27 Sep 2022 15:38:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2786610E971
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 15:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx/af9r/zPu3xU9VCqPLUdWuPq24OP5PKXh3huRtwwoiyGduTZEefejEugpfgPf60vbNwU6EqbQBQzyE7XbTbM6UBIKqzIdD4aBQnqyKNCwkVor2IVRYZYXX3N3i546V7FwJ5mUtYD5ZdO1NBfvO+IJn2juB7YBeGTugbNHNNipFcbJ/j9fOhIKhMapyHuiOoL4lyiidZiH0BQEbF4mrmrJJala+y/jRAXcU0dBh5nqZ3dibLGmWFZ6aQxxppFyn6AUugi/guHVavF5gPiSxT4KsmOZ1RxD7LhWClBxwXwdu/sZuEWUYJo53BiNxw8RfK9VMg8I8Q3tIyEfwE1Mlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A21rxqWDzGP67XX5a2QWivJnvJMg362Pom8kbzZ9lgQ=;
 b=RgRC9yIADGxt38M0eLYMdC3HMvRxoLs05Ga6vecHR2FQRQYfwIQ+J9gggutRMdH31fdL8VW8yj1YkHpUT3CdY2UBcR8KsyIZ++iaJ21oNwEZ2PopsmwZM89nk9kPXGrSk14WkndStiiouZxvtZsQ2lO8vBlgBtzKZn7DIomqhnHxHqNoN7Wwgo20n/LcvCeDGZlktc3OB+J+kU161uYKfNR9y3UK1OCwQK54mCN4YuXw7ksOcHo5UqbTDfgtw5GSjE14AN/c6/7du4Rg3/3WV3nhP/iojpJOdAdVVXNCobnZxiofFI76P5PeeJOur6kS5VjCKUzT62UI5jX9UmH6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A21rxqWDzGP67XX5a2QWivJnvJMg362Pom8kbzZ9lgQ=;
 b=3pd3rtBjq7/UKaPg92ghUhr8kvHvNLExk5XYwpZzOUufwNqCx6FENyDv7jgwes/nlf9mLvFV/jEbJDLouo9JJx3M41Ammn4pBjkNkx1TvuVBdMuDS4iEuwrfUx9ol7Cip9LQ4dS6Ufchp03pXmOig0UWnr1b/doxarCGdo0nLDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 15:38:18 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 15:38:18 +0000
Message-ID: <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
Date: Tue, 27 Sep 2022 17:38:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM6PR12MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: bf93e448-7432-4369-9218-08daa09e4cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpLfz6L2gXr52deFmLe4jv7liQfpuUIdTvaax0YUYwLqjIgL67/1CT4txFhp3OCWIUTLX3S0eiWX1qjvghbNto6QGe8x5VTRqgbt10tCzeEBXUkbgBRftSQk7jLjEzfvJ0dG/Qy2RLkqQ5nXIzHdt1O0W6CVsFhmjD5Yk0xR8aRpUmnwwRJ6mg6sF281QTRmmv6E0DOg9c8yPIrW0CP2YcxIxK+bgIsAWXQ357PRaAIT6h1DjD36jewR1sPVW6IsFrKlW6iFqnR0YlmRJ5UFEFSSAfXSpEGX2JPn7SR34urM2MlIjK/4gkRwkE7CMzrHvfDJOEmDz+/fhm7yVFACnYVn+gmhJg+bbPq1ErXn6DMowkTtbrxuHiVJJBulhyH7YqAVz3/kzKlpw6/pkvVPjRrDqD0AHAEXCbDGZ0MbywA1snYUBXUm7v3/Ari0lHG8RLa73ih+X+IslGxRPnl3qYyQGe4qjhi4kKWdbBEah7XnTXdPhsX7weIPcaDrbMJX6AjrOQLGyEt1FKdjIeNfVAyG0ybeeYyvdclB2iBIlzZsEEPEGOj/ILPOqIOb3vzYs0iN+u3KeBdYczEnWOlQ4bEF07tf4iih2jGvoy37dBUnlvNXEpn2qZ2KcIRvU75vA+/gJXm7x343MqvEd+irXkrR3wBQJeDZeWJX8weIoMKmnJe5vz8Bi8M8UsAe5lAXEKC4qPHEt1bxflJBiU7aq6kFY6DkhmVfZnzc/ny56b/cd6/HXWzTp2mqkOSCFEdKke4ODztf2T3L9vy8OfxeUiTpYlfMREBPpe0NoiojPiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(110136005)(316002)(478600001)(6486002)(83380400001)(31686004)(66556008)(66946007)(66476007)(4326008)(8676002)(6506007)(41300700001)(53546011)(6666004)(36756003)(26005)(6512007)(5660300002)(2906002)(2616005)(8936002)(186003)(66574015)(38100700002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEk0cTA5ZW14QjR1L0RPNHFUTkJlajJFNlZGcmxUb0tLYVFLbGttV1N6QS9R?=
 =?utf-8?B?clNwa0tqR0lUWGpTM3ZEZmVwU1M3N3ZjMngzOFRyK2NsdVF0ZEF1ODlFNTNq?=
 =?utf-8?B?eVFBWTB3MktCbmdieUVkM2xvMi9Fb2dOYTNML0dzUzJIZ1RaS3R2V3FUeHBJ?=
 =?utf-8?B?WXJ3QXBYaU1pNXJjMWdJZW5MMHpvRVg5MDFTVVN6Y3hrSW15NFVoTjMrZ1cv?=
 =?utf-8?B?cHk2bFhmNmt1L2lTS2JhVm0zRG1acDBHMTJXclU3NTUvenBUNHJwTXdPblVr?=
 =?utf-8?B?Q09iRGhtZ1RRTjFJQ2YvU25WNXRMUHBZUWJTWFBwbFNFVzQ3QTJ4b2ZMbXVN?=
 =?utf-8?B?T0JQZ3kzdXBzbW5tWGdDdkRpTEhlWDRHU3dNZ3cxUjE3MlIvSTFSYkxoeXpZ?=
 =?utf-8?B?cVRVK3ZMQVgzNEo0U0xqaHFrdkx1aUtXcHFqejlYOSt6K0Vyd2t4WFZWells?=
 =?utf-8?B?KzJ5R2pNUFBBOXd6cGZPazVGempvK1E2TTQ2cnU4dWo3WERrL1cvcGNuQXNR?=
 =?utf-8?B?Y1FQR3E1U0QwSFhSZ3lKdWZPeEJ5aXJuck9qWHlHcjlTU1piMkV1eDJSdGRk?=
 =?utf-8?B?V2d5b2llUHJuaGtJanpDTEtkczBDZC9ubHVLMmhPZVpSOEtBbERJVWFqTE56?=
 =?utf-8?B?Yy96RFUxdVMxbHBXMDd3YUIrcXVQZ0NYRXZQY2RTRkhzYy9ZVElNcDZ0Zmpm?=
 =?utf-8?B?em1xdUZUR01HdVk4MlNJWjRYV0V2d25CMDhBaW45YUhxaGpFYTRpNjFCUVdl?=
 =?utf-8?B?elpiUVo3VDVvVDFsbGd3dXBkSFFHRTFhVjh6RzllRXkwUlptZitrdnZKNFdG?=
 =?utf-8?B?QXkyUVZTNmNObTIxVCtKbFl4UWV2Q2JEaHVCSHJaV3RMK2Uvc2dweGNnTnky?=
 =?utf-8?B?VTNBUTI5SGhGOUdSUStHdjFnRnNxNmdCQ2d2TUVhQkc0bjhtampuVWg5YWtL?=
 =?utf-8?B?VlZRbWJNVVQxSHdCR1d3SHhuVUlEL3dLM0FlUkJzNkl5RFlBYTVDTi9KQXJq?=
 =?utf-8?B?WlRmc2ovMmVPVVZUN29iemx3QUYwNGc5bGVzcWlPOXJjRUN1R2ZRS01Zb3NH?=
 =?utf-8?B?QldNbFZqQ2V2ODJyYldBdWh1T3ZuelE4SFFrYktIRDFkWFo2MnFjclRjRFJz?=
 =?utf-8?B?U1RnYmpDQzNpRFk4eVBVckp4T1BFL1owMXdHYnhiUWZ2QUMvK1ZhMGJWK1Zp?=
 =?utf-8?B?ZU9Mb2VlRGM4akE5Ykg4SnlMNGZ0MVY3MnE1NXJOUXZGVGxXMjBUTW9ZNHZQ?=
 =?utf-8?B?U0JUbEFlN0k4OE1WcUZPN0UzRDJsNmUxQVhFUHZxaWVPdXpJRjd2TlZWOWha?=
 =?utf-8?B?NHJENEFtWVpQWVJhaXNxNFpOb3JBdEdJOUhmeGJhdVplWnArK1Q2TUVBL3Br?=
 =?utf-8?B?aGlqa1pPYThpcXMvOFc0eWhZbHR0aVRYNWRXZFdCaERYbWNkZEI0RmZmQTJO?=
 =?utf-8?B?SUZmQlZmVHM5ZzMrMW11WmxDOEJjdjIwN014bE04VDBrN0E5emo5dStUZmN2?=
 =?utf-8?B?YTRZQnE2MU1uWE5BbVpNQitrR2R3M3RWeXc2WXlmSkhWNUJzMS9CRmZMZkVX?=
 =?utf-8?B?Y1J4RVlwaC92NERER3FSSkZWS0luYUQ0dzQ5Yldkb2F4VzBvQlZLdGdJWXJk?=
 =?utf-8?B?L2Qza3M1YURHcUdTWCtjV1pRb3krMWV4dDc1bkZTeUNiVUpDS1U2Wnl2ckp6?=
 =?utf-8?B?b01DQU9iazZORUxMYjZJYTZVYnZGd2Y3OVo2RWhSNXZaT0FIVlRQZkFNVkJY?=
 =?utf-8?B?eDQ5Q1hxaU4wWXNxNkllY00xZ0tybzlIcG5wZFE5MHBkVExTaGttdzRqV0Rv?=
 =?utf-8?B?aXpWblViUmVPek9EcXhBNlhBM0ZHOUtNU0hPOHlQeks0WEpabllnTFNudWVB?=
 =?utf-8?B?aFRqQmJpd2hoNzRFYXpHWDdubW1pdEtXenYvUUFxLzV6d3BuSXhBNS9kb3Rx?=
 =?utf-8?B?bHVxR21nMzBiZ1JuQ1FFQ0FHY1NMMFZGb1FoUXRwTE9aOHQ1WHJzOFFzRXF5?=
 =?utf-8?B?NnRZMUFyUHFjQlJOV2ZUVjJYU0hjNnhWdTRjZmh0NkszYWVaN3dIVElweGZn?=
 =?utf-8?B?bHNtTXBPckc4Z29YNEh2SDBOaHZZVUI3ckpMNnZodFgyRnF6bklzSXhUUFRK?=
 =?utf-8?Q?/TeKWlzJUt/alXFQ4q8kkx4dt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf93e448-7432-4369-9218-08daa09e4cac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:38:17.9407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXomYsCZ4wVnkh1bcai2IX1oJQz2P52Jclspg2xZdF0uFYazaJhHp93cF3bCJsiL4HFiNXriOyyCuZylP8oPEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 5:23 PM, Felix Kuehling wrote:
> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>> Hello Felix,
>>
>> Thank for the review comments.
>>
>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>> This patch switches the GPU workload mode to/from
>>>>> compute mode, while submitting compute workload.
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>
>>>> Feel free to add my acked-by, but Felix should probably take a look 
>>>> as well.
>>>
>>> This look OK purely from a compute perspective. But I'm concerned 
>>> about the interaction of compute with graphics or multiple graphics 
>>> contexts submitting work concurrently. They would constantly override 
>>> or disable each other's workload hints.
>>>
>>> For example, you have an amdgpu_ctx with 
>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD 
>>> process that also wants the compute profile. Those could be different 
>>> processes belonging to different users. Say, KFD enables the compute 
>>> profile first. Then the graphics context submits a job. At the start 
>>> of the job, the compute profile is enabled. That's a no-op because 
>>> KFD already enabled the compute profile. When the job finishes, it 
>>> disables the compute profile for everyone, including KFD. That's 
>>> unexpected.
>>>
>>
>> In this case, it will not disable the compute profile, as the 
>> reference counter will not be zero. The reset_profile() will only act 
>> if the reference counter is 0.
> 
> OK, I missed the reference counter.
> 
> 
>>
>> But I would be happy to get any inputs about a policy which can be 
>> more sustainable and gets better outputs, for example:
>> - should we not allow a profile change, if a PP mode is already 
>> applied and keep it Early bird basis ?
>>
>> For example: Policy A
>> - Job A sets the profile to compute
>> - Job B tries to set profile to 3D, but we do not allow it as job A is 
>> not finished it yet.
>>
>> Or Policy B: Current one
>> - Job A sets the profile to compute
>> - Job B tries to set profile to 3D, and we allow it. Job A also runs 
>> in PP 3D
>> - Job B finishes, but does not reset PP as reference count is not zero 
>> due to compute
>> - Job  A finishes, profile reset to NONE
> 
> I think this won't work. As I understand it, the 
> amdgpu_dpm_switch_power_profile enables and disables individual 
> profiles. Disabling the 3D profile doesn't disable the compute profile 
> at the same time. I think you'll need one refcount per profile.
> 
> Regards,
>    Felix

Thanks, This is exactly what I was looking for, I think Alex's initial 
idea was around it, but I was under the assumption that there is only 
one HW profile in SMU which keeps on getting overwritten. This can solve 
our problems, as I can create an array of reference counters, and will 
disable only the profile whose reference counter goes 0.

- Shashank

> 
> 
>>
>>
>> Or anything else ?
>>
>> REgards
>> Shashank
>>
>>
>>> Or you have multiple VCN contexts. When context1 finishes a job, it 
>>> disables the VIDEO profile. But context2 still has a job on the other 
>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>>
>>>> Christian.
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> index 5e53a5293935..1caed319a448 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> @@ -34,6 +34,7 @@
>>>>>   #include "amdgpu_ras.h"
>>>>>   #include "amdgpu_umc.h"
>>>>>   #include "amdgpu_reset.h"
>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>     /* Total memory size in system memory and all GPU VRAM. Used to
>>>>>    * estimate worst case amount of memory to reserve for page tables
>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct 
>>>>> amdgpu_device *adev,
>>>>>     void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, 
>>>>> bool idle)
>>>>>   {
>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>> -                    !idle);
>>>>> +    int ret;
>>>>> +
>>>>> +    if (idle)
>>>>> +        ret = amdgpu_clear_workload_profile(adev, 
>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>> +    else
>>>>> +        ret = amdgpu_set_workload_profile(adev, 
>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>> +
>>>>> +    if (ret)
>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to 
>>>>> compute mode\n",
>>>>> +             idle ? "reset" : "set");
>>>>>   }
>>>>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 
>>>>> vmid)
>>>>
