Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB620C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 15:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D69210E2E9;
	Tue, 27 Sep 2022 15:23:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A77110E957
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 15:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gml5bmO+CdlVuEHgf6ifEfhXRvXgBRvjzsYDhhTL19xW7DZncqV+5xRchPwG08oBQW92BRUEycWh/R3xee2N3YhiQTM7OqqhgdODhdBb9HJ17RmuK9UZlWMHn9n353UgO297qSHEKS+pTlJGp/6xWPBAw8X9atuub1Y4SKGq6fbs0jbwWD54VekBF6CNafqznKwArdOUqoXD/SeoIHIFY6udFVWaqbv9MSGq91DjoPKr/8LpoVfTUsWGw/NXIt0DL4Pb4jqV2bI/Fx704smj05agZpeD9ia+abeb2beKuiXczACcq09VJpXK4GFbjjJhlUqo6WfWQu4r48P0lgnQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5P23ze5KIA/M6yMk1hSpn8TjBF5CnCJkay0usK9Rbk=;
 b=aCUwjCJ2vWkw+FqM1rnBRzn22xVYnvvaek+DXQEvinq3QgVwxQsEPwNj8cE2YC2NCOqTW6lPdH+9HBwyd6vM4zBq9GZvIOA7Wf0P4UCdz3NnL3+ngEhWfIhvDjIp3sfj9oLdY+srqU2zGp5X3JSu5ph3bBVEq9HHmdRwZmxroeSk0JnMozBkfWmPOiBCL4NEF0c7+glThavjmhkd0EPq0HjSSP5fcC8cabw1kD+J8Wy82lgrAmnqdE8q6/x26sa/AiHwHj6zfK3LY0fl4zwGvd58ERV1octuNTpw+MMPkekFkQK5Wl2khdVQ+MnnGbw8IT6MeK+YjcGSMNXMB374DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5P23ze5KIA/M6yMk1hSpn8TjBF5CnCJkay0usK9Rbk=;
 b=FwDfDFNPGX9sfFcU+GknL5ypQzF9yO9BbOXFvr4eKgwNdOe4n/7u0kx+Xcbd4FEfUKpooCGN6trMq4KU1cmY8gMu9xn0HJr33nxoAkm1izF5wLyJVUpZIIY/T4MIvC0+akFJtmi14V9scfThrbx5S05M72SBpwiuVAgeKpcTYfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:23:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 15:23:09 +0000
Message-ID: <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
Date: Tue, 27 Sep 2022 11:23:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 78698442-7ad1-45d4-909d-08daa09c2f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuO1rZBDSp9LjNaSyr7moWStqh1nNKDs15Zi/ODl4xptcfr5ggIcOtUqNAeL0SNQM3miU4uUKnjZsYfcT99yiTz2tgF9CfKZ3BH1SKCcn54avgtjNnddv0Rt1NBm+4C3tO405VKxHkq/r8ZXSWI303utnQUzkzpgEvZs+Et9/shvmmL4/73UGWVYOAjEBM+Mlmgz/JG2YUZxwUHOfbtBD+XzX4cejYdiV/R9aJVPUyZThlrrqaZQNC4QQjmyZT5dLulsx0rbhesZYdBflJD14WBAISKDo58Tp3h+lBaFTETQ1NPa7vV5/gSNsusO4lqdsgBhrcWISR8yPg+pYya9bZcNqI9P9DnJUvVFXMFTvbiyobgVTv4F51t6sIEPbMcA3vOGuPYt25aexZ9T+hVejQLdwood83Bx48/dtLbssAVyuIG5eG2PDYr/KtEiP/gs6CmuBhv+5ke8LlKGtQy8cYsXR42OT3awOF3Uboxd0X1Yal5OZrtkl6fJ+lUy+YG7LdKyHcCblC5IW4tV7VAYPekg7pz52zBqna1ab6WiPN/jL+A5JpeWUJa6S1x3BEjnMN0dsYeJDQ6JOoHGZUuGrX5RvqLmfLsZ8abEIsWZyAQii0xmyd6tTsut7wQAjMaUAX2n2gFINMHeeiq7cm4/TxRrwGw5P1rTKq/Zz/nANYbAvFwR0ons+TbJKK0k32DZ4Xw+KGJFfSCmDPzxU2Y3kCNMIg33XIQ7rJ/QpZNfiWZjddZreGs3UauqKggPE/GvPFnlj7jIOJUxthFv2ZiRaaghlesslLHAYXjaCacOU+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(66476007)(66946007)(66556008)(6486002)(110136005)(478600001)(316002)(5660300002)(26005)(31696002)(8936002)(86362001)(2616005)(44832011)(41300700001)(6512007)(53546011)(186003)(2906002)(83380400001)(36756003)(4326008)(8676002)(6506007)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRCa1FSbFM4TXFMcjY0VTN6bWJmUzhtamp3bkdOaHRTMUpPRVZrTnBOZkVI?=
 =?utf-8?B?RWlzMCtmYVhhN0xhdmtUdGxlR0NnRkozM055bElISG5MRlZNYndBU3RIaytH?=
 =?utf-8?B?eHlKOW5pZTZLdXo0T2hJc2RqdWVwRzhIY3hjanU2ZHZFQUhoV29mWjY0RWpG?=
 =?utf-8?B?aEMyUDdCMDh5UHR6TEFrTjRlQ1hzMWJHZWlNM1BVZGRkN08vakVmVWdMVngw?=
 =?utf-8?B?cnNHczY2NnppL3FTajhxRnAvMUlFUnFlYkhwRzVUajhnMDJMdGM5ckVjSzB6?=
 =?utf-8?B?ajZVOXRlTFZiYVlJQlZIM3hJSXNESGhhWmpWeldIbWx5WWVuNWN2bTMyWld1?=
 =?utf-8?B?Rmp2WVBBQTRIVjBZajB5WVhwSGtyMTI2RHl2bVdoNTdxVDBtOFA4dmhBRmpN?=
 =?utf-8?B?blpnTGxGa0JDYlU4am5pUWhwb3RiMktucnd4TjNEZy9kT2pDdUpwcnJrNjdL?=
 =?utf-8?B?OVhmcUh0NWs1Mys4RzNjZ2hQamh4QWdYQXNkZXRYOEpiQWhCckRKdUM4Nngw?=
 =?utf-8?B?WW1sc1l4UCtkZHhJc1lDNkNqdkNqQWJJRDVWamxDb2FBdEswTE1IWGlKU3Iv?=
 =?utf-8?B?YjRzVVpCU3JnZ1BzVzVoOThoSTUxcGVta1ZDQ3N1bkkzczdBMXhLbWY0cE91?=
 =?utf-8?B?UitqdlgybUx1UnRDMDFqOHhEa0p5MWRxczdCTVg4c0wxNGlmd1NlS3N6dlFN?=
 =?utf-8?B?cVNoM3hPVUZjQ1hnczdLRFE3akJvcHNzTEZBdEZoQ2w5TlZ6NGpNeTlOZ1Zu?=
 =?utf-8?B?VnpwVzZwVXVhWWFGK0c3SUNaUzl0UXg2clB5RExhWEd6STVsMXdVcjBMWnJP?=
 =?utf-8?B?NzZtd0xqUTlpdG5JTUxrTXRUcUw2V255c3pNNkh6WWQralVhOERUWTlkdGJk?=
 =?utf-8?B?N1pnankxQUlVSktJYUpyd1VOcno4VDVqVWpld1Fha3R2QVhidE1ycTJFMk9B?=
 =?utf-8?B?WTFvMWVSVG1nNDlZeE1GNlkrcDdxWCtSRGM1cDUwRzczWHJwZHpjdmpzcXZE?=
 =?utf-8?B?ZVFtV0daZTU5SmFwcUoxU1l0aGdOYTdCdmh1VjNaSU1ld3ZZUm5GYjFlOXlG?=
 =?utf-8?B?UksyeFlSL244ZVFTUkRUcmpuYlBscnRyYXBpUE1OQ1B0R1ZRYmljVW9SS2V1?=
 =?utf-8?B?U1FUUHplRzYvL0hBczRqVFVCbVozNEZxSFZra1c5K0FGZHdKZURtcmRjTUJJ?=
 =?utf-8?B?SUt3dGlDZkFQZ1pOR3pIelJkbzlTbE56SCs3OUxWM2Z1NG11blVzL1JRY3Nu?=
 =?utf-8?B?UkVqbDVPZVVXT1VYVTBnSWJsczRsczBIRjZOZ29NaWw3QWZPN2pHd3ZJSU1J?=
 =?utf-8?B?QnhtSmorNy9xOUs5K2laalA2NXVERTd1WFNQS2hEdEQ1aDlaQVFzdDliSkFp?=
 =?utf-8?B?ZHlHM3k1UklNTlVtWXdoa0lWRW1YWm5TZzU0MTFjN2oyeWRiaG9LVktPWEZ6?=
 =?utf-8?B?akhiYWRCZmJpaG9HeDlTSWxJcm53TENSUTJuNDYxSWxJWmFSaW5NUXZCcE8z?=
 =?utf-8?B?a3Y5MS9McnlGanNjL3pNc0dvZ2JZWG1tWGZWWi9HOXlvb1NqSDlHcC8rK1JG?=
 =?utf-8?B?MEVOYktVQUNzdTduNGN5b2ZYTFJSQW9pRDd0TDRxV0NsaHhVK0tCODBheWRF?=
 =?utf-8?B?OXdCYTd2REY2NzVMUk50NXloZDJrOFlhcEdLZEl1NStWOUhzNm54ZnMrL0hR?=
 =?utf-8?B?Qld2Y2RDMWhTaUFGSkV0QkZhbkhZSXFqc0R5VnovcHRkWFJaeG5aUWs2a0Va?=
 =?utf-8?B?ZEgvSm5SNlBiVU9panNpTUJVTnZnUmFSMWtGSm03WVFEWGxlUTJscTJCaStV?=
 =?utf-8?B?QUtzY1pqcGRBS284WlRiNjcvNlhpMGQxTmJHSlFySnVsNWJzaGJkb3MrVFlQ?=
 =?utf-8?B?aTZ3cGNkRkdvdHMxQmRrNjNzWDhSYk56Y2dwRkZiUnd0WkVnOUtiRW5vNEdt?=
 =?utf-8?B?Ti9wREtQUjAvb3BJVHgxVWFTTXFRdEphZnNPa2o4ZjRwdTUybXY0SGR1d3Fm?=
 =?utf-8?B?clZKSXVCSFdBdm02OFAvcU1MNE9ld1l0aWw4a1QrZ1pXcWhlRlNiUlZtb1lV?=
 =?utf-8?B?NjVScVJwWmJPcHk4V2xjWkZtd3ViMENVVlJwMnB1TU9PNXcxZmJ3bnB2Um54?=
 =?utf-8?Q?Ymc0sAOMxrSfXD5palDvziBIA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78698442-7ad1-45d4-909d-08daa09c2f01
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:23:09.5151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXgnSaoc8diBQ9xEYQ/au2K+sQnl77ccwL3bym5b7stBZRrtyJEHEv+LTq/MjsR+H1+phgu91kzAn01EyPu06Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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

Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
> Hello Felix,
>
> Thank for the review comments.
>
> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>> This patch switches the GPU workload mode to/from
>>>> compute mode, while submitting compute workload.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>
>>> Feel free to add my acked-by, but Felix should probably take a look 
>>> as well.
>>
>> This look OK purely from a compute perspective. But I'm concerned 
>> about the interaction of compute with graphics or multiple graphics 
>> contexts submitting work concurrently. They would constantly override 
>> or disable each other's workload hints.
>>
>> For example, you have an amdgpu_ctx with 
>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD 
>> process that also wants the compute profile. Those could be different 
>> processes belonging to different users. Say, KFD enables the compute 
>> profile first. Then the graphics context submits a job. At the start 
>> of the job, the compute profile is enabled. That's a no-op because 
>> KFD already enabled the compute profile. When the job finishes, it 
>> disables the compute profile for everyone, including KFD. That's 
>> unexpected.
>>
>
> In this case, it will not disable the compute profile, as the 
> reference counter will not be zero. The reset_profile() will only act 
> if the reference counter is 0.

OK, I missed the reference counter.


>
> But I would be happy to get any inputs about a policy which can be 
> more sustainable and gets better outputs, for example:
> - should we not allow a profile change, if a PP mode is already 
> applied and keep it Early bird basis ?
>
> For example: Policy A
> - Job A sets the profile to compute
> - Job B tries to set profile to 3D, but we do not allow it as job A is 
> not finished it yet.
>
> Or Policy B: Current one
> - Job A sets the profile to compute
> - Job B tries to set profile to 3D, and we allow it. Job A also runs 
> in PP 3D
> - Job B finishes, but does not reset PP as reference count is not zero 
> due to compute
> - Job  A finishes, profile reset to NONE

I think this won't work. As I understand it, the 
amdgpu_dpm_switch_power_profile enables and disables individual 
profiles. Disabling the 3D profile doesn't disable the compute profile 
at the same time. I think you'll need one refcount per profile.

Regards,
   Felix


>
>
> Or anything else ?
>
> REgards
> Shashank
>
>
>> Or you have multiple VCN contexts. When context1 finishes a job, it 
>> disables the VIDEO profile. But context2 still has a job on the other 
>> VCN engine and wants the VIDEO profile to still be enabled.
>>
>> Regards,
>>    Felix
>>
>>
>>>
>>> Christian.
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> index 5e53a5293935..1caed319a448 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> @@ -34,6 +34,7 @@
>>>>   #include "amdgpu_ras.h"
>>>>   #include "amdgpu_umc.h"
>>>>   #include "amdgpu_reset.h"
>>>> +#include "amdgpu_ctx_workload.h"
>>>>     /* Total memory size in system memory and all GPU VRAM. Used to
>>>>    * estimate worst case amount of memory to reserve for page tables
>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct 
>>>> amdgpu_device *adev,
>>>>     void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, 
>>>> bool idle)
>>>>   {
>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>> -                    !idle);
>>>> +    int ret;
>>>> +
>>>> +    if (idle)
>>>> +        ret = amdgpu_clear_workload_profile(adev, 
>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>> +    else
>>>> +        ret = amdgpu_set_workload_profile(adev, 
>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>> +
>>>> +    if (ret)
>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to 
>>>> compute mode\n",
>>>> +             idle ? "reset" : "set");
>>>>   }
>>>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 
>>>> vmid)
>>>
