Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C09C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 12:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6529110E91F;
	Tue, 27 Sep 2022 12:25:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015A310E91F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 12:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvo94IipUAIxDJcTxDjU7QnYqkFKHr5EpCuHBJJjMKycUNx3sBxtBve56kCsqRtvKHjz2DXjJERlcLZTw2IRQavxJQ8kV+qzo1OE65/EBb8jNX9qODe/0L50TPZsmocIZ8xbtfk12LK3jWJkDnRWweZ70DQkA5xTF5kmegYk7PWJFA6ncXC+6r76E6IrWjLRMdtOUn1d9gaOTIuVbiPIFRPyJ6c1LrcKHDqgXQvjlPeifmIWZO3LI6F9Oi2ijSTCK9ezPXe/SA1zzv7Qak+LJkH3VunYg23nNz3pxnkXPloN+FV5OcCfXev5y2euI3IoG5LfAn7sae6xBfnp8H9Fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFTF5ubHhVUo61fZQN3TthEd2u6ss16xbEd/RsQUD/I=;
 b=KMPA9nYhsiCsvXbaUzx+8DRwzFjgKxuUpTUOjDRV7yWWSm0mv3D9EqT+3Ycuq5ox2tlK7l12d5aZbt+ooqVkrHURbVfqS2jgKRa1FrudJrq8KXyfmKjIywSnsy8zeYTknrGpNSmesL+OjsmHo66cAsO/uRpRnbDhMmf1Xhyi5jeK5K8HjKVv0tLHDLG5mcY8Kvd8bNUtki3ntnbESgXpKMzIg0OyYXFwn1dl+jUgx8NTKc9sVJ5ndCJ4bi/HoVzK2yZJwprQ3WJzVnpTNs5yWBpW3HganHTES4EyOnBYXXzp2sk6ERhSalMMcakmBJ7zixbsfhgZrVtP1t1uk9pLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFTF5ubHhVUo61fZQN3TthEd2u6ss16xbEd/RsQUD/I=;
 b=OT0SQsBwm9CrHSzPzuvgPMNpA4CENTw0/YrBWUlSdCbFDTvA6wRSdj925lXCmfIAS5PBklhsKQR9kRVU+7f6/2nHsESnE55WaFDGO9wQKwFgT8fzyattwSh0YHHuSS62VG0TVY+LmLPEfHYF/U5HuVnM8hQnNRUpEFkriKso0pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Tue, 27 Sep 2022 12:25:46 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 12:25:46 +0000
Message-ID: <92ae3eb3-6a9b-6ad3-7970-dad0b82523fd@amd.com>
Date: Tue, 27 Sep 2022 14:25:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
 <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
 <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
 <60d98c36-165d-8e59-d110-a4f2ea2977f5@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <60d98c36-165d-8e59-d110-a4f2ea2977f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0176.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: cf05a5bc-7774-4db2-5f98-08daa083674c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTnjKQtSAZfN0a1GLjuPLav3WYTptO2kHuhB38/8eNi32U0p5fhCWaOrbbQ9YkX5CZ/P67MJ6CyVBwiWYpbileodJrfcx2Q3WU2Rq4AmfAwokGjqGVETH8ZRFKBLT6EVJ4wi3AKn3LD8O4RdihNkD6rXIQSVtk8FQVe+7HtfjmJMzEZEhqZ7B97N9espEMj2+WNgj4UF4UlS1TmSpPMpjpgdwLjHhrAsZ3BIWVaq35oOd30QisPsTGN5qtas0h2bhxhTuNqKzE3kzO4cgd33NJ6fdVG99A0LrQPY4nGjmdoTkKKiyT0OkMkujdYtroq2MfSMoZXlr743J6Ze23jfghSR5+jFZ5g7R90i+csQYd0D83PlwME/95gN8Rhf1cPbKRZqwsgow20OrM5Obx91oI7aqNkzpgkmnfdxDRJFzGizni9msJFsjwKbuvUBw+uAi2xyGwHIZR4PjVD2mAFmao2yiHO98Jv7S9w3JlcwV5FmbotHs0T/uv29ryjzJ6pjP7F6eAITc7EN04j+FB514nHR7TI1NOVusSLXaOQyla0OicCtcxAk9M4qEkxVNmQJj9w3KICp7D/ngzJFLzCHNFMsJqgdW+L+BNlbuHxkqyMV/e5Z/hAbb2qw4vxKHmK3RbRKwJc1/m/yAsBQm45KpoANkxg4u0q/ywizC+gnaSKTaTd7I043KuPK3qynsB3XzP0jaUyvvosyePCox4v57+NbF729n1dEGNOxGjpQyZUSgY99R1uH1G3psP5Q+ycxVWXWaSSl0UQInBUlgK7ty1vbsIFuC6XVXtPk4EnZYzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(26005)(5660300002)(6512007)(41300700001)(36756003)(53546011)(6666004)(2616005)(8936002)(2906002)(66946007)(66476007)(66556008)(4326008)(6506007)(8676002)(38100700002)(86362001)(31696002)(186003)(316002)(83380400001)(31686004)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVuN3lmRjVsN2t6SXh5MGFiQWNpcDRvMWl2VEg5REFFU0Y1VEdtYXV6Q2hP?=
 =?utf-8?B?eGY2Ym1vdUJwZmoxZUdIZUlPVjV0MzZGTzNTOHhjc1hBSG11RkFJUmVLN2RF?=
 =?utf-8?B?dUg0elJSVG43alhRWk56Zmdmb1RxRlplNHR5eVJEc2RvamFZUWtQdjkxSVU5?=
 =?utf-8?B?dTVTbXAxSWFiUXd0OXhkeTVCUGJRdjFIMkhaY0kzM3h4TllIejNPb1M0dFBU?=
 =?utf-8?B?dmNMVVMrbXpQZmczY0VVelVSbjVMUmViQnZkODhSVHdMRXJMVXBDVXBWZzBs?=
 =?utf-8?B?YTRMczBoeXVDZVQyVVg2SEZ6OEN3OHo5Mk5VZ3B6bDVsd3FXMVVzNUY1SVJJ?=
 =?utf-8?B?UWVKY01mREZsQjlmTUx1TzNCTzdob2VkRDZVOS85SDdBcE92YzJObkdyWWtN?=
 =?utf-8?B?N25uZ3dxaGFkcFNiQWw5UjRYbHZxcEJRY1JDU0hVSzZjRDVFL3pMNnZzdnN3?=
 =?utf-8?B?YWhzTHhHdDZKdWVNblVLRVhFOS9ibm9TOTVnU3hZZ2lSZ2hUWTF4V05PdUNa?=
 =?utf-8?B?a3ZzS1VxdVIxYU9GS3o2ZDd1cURiRUpWU05IOVl1UHdLVjdBOHNENS9jOGdO?=
 =?utf-8?B?OE5QSnN0dFlOV3M1TWMwZjBpeC95RkJrOUdDYzNuVEIrMFdNVkJYZUR3dWFJ?=
 =?utf-8?B?dUdZMW9rWEN6Rk42T2FGWUFnaUNCTGhoUUVTSkYzd05sa243WnlTY2FaZzJV?=
 =?utf-8?B?cndleTcwUnpaZlZkdFNGTEU5dnFOOStWVEJGZXpJUUUvZzNxdHZiSVNWRTNw?=
 =?utf-8?B?VTlJOTBobk5KUnU4WHhXdXRoVkphenNHbHRGOUNMeFJ5UzVMR2llTmpjWTd0?=
 =?utf-8?B?RWlyRG00UWlsSzNTSnRGZW96dStvMWdGSjBudW9MVldQaWxyMC93QWVuMzBY?=
 =?utf-8?B?RGFTRDF4b2RwbGNtSk1HOWNUdVgrdEFtNExFNDRFWEtsWVFrdUZoUUF4YW1F?=
 =?utf-8?B?UmdLb1U2QzYzOERzU2FQamthc2kzeC9VaFVFZ3dGcmk5MGhHUFJLbndNdzlY?=
 =?utf-8?B?WkJjYmM5Q2lZSTRseENZYk5pQkVtb3lDQU1KQUNWR3gvSGh6K2U1S24vaXR1?=
 =?utf-8?B?aEZMdWFjQW9ScmVwNlBLb2toM3d6R3J0UlkxZHA4WDBDdUtjQmwweUwrTk90?=
 =?utf-8?B?emxoYmpHVlN3WEVzTndPNmd6K1p5S0tDZHV5SzFtZWN1eE40ZXJqSWtNQW9m?=
 =?utf-8?B?bGFZT0tLTVNnT1hQNXVmNWJRSVEvbmcyWnhEZ0ExdE02bFhha3lkbVpBMDF0?=
 =?utf-8?B?OEVEQWNQVHdHT1YrWUE1a1F3c0hLQ2s4VktQeGRSbEVKSHFnbytPazdCZFlp?=
 =?utf-8?B?dEVNMnl0RzRvQ0t2cW5FbnpKSzlDV2F5Mmk1NXJiSkVuTGFvNEVPUVhEQnNh?=
 =?utf-8?B?dHhHQjdzT3VuRlNWOU5Mb2ltRkloUWZkcGhVcTFCa3dEYWNENXpYbnFHS3Fi?=
 =?utf-8?B?Qk9jMGhoWlFFbll2VGd4YzVlQUMybCtxK3BqVEFEQ2xnbmFOekRzUWVlWUFR?=
 =?utf-8?B?bUdRa0MybmMzQmJIR0RZTWVYbHZURDhpd0dPTE9FWUd4VzJJNTdKM0Mza0o3?=
 =?utf-8?B?N21YMmFRSnl1S3lDc1dtQTREeS9IN0lsYlp1Y2twdzJZT3NiSDVVaVlUOTVW?=
 =?utf-8?B?YnlnaVBydXhEWFR3NUVMaXBJTEpHZ3kyQy93NERGYjBjU2NPR3dxQ2padTJu?=
 =?utf-8?B?ZXFpU0dVZzBSMmJaUXl1R3FlUUV1WUs5dW0wK1NYeDFOcWVlMWw4MXUzWnQ3?=
 =?utf-8?B?WFRVSmluZHRWeFpZZ016U2RpdllGUjZsL1pFdmw1Z2hqWHpRNmptTHl0QTFh?=
 =?utf-8?B?cm4vWUxNUFBEb1hoOGVBMkM4OHhaWGN4a0x5L05SQ1R6aWFUL0NnVnBpdkRu?=
 =?utf-8?B?Y2hQN1BvUmg2cExmMWZaT2hEM0hpT25vbEdCdEhzaUVCbEFVMFVJSHZQdE1W?=
 =?utf-8?B?S1pYdFFLWG11V2FVVis2bnpMZURvV3ZXa0pTbXptSVBUU3Qvblc4bnNFeVV2?=
 =?utf-8?B?dHdtZnhsUWMwTHJHUi90dEN6N09YV08wQ2tCR1NoVU1lVVFSaU5ObEd1dkFC?=
 =?utf-8?B?Mm1oelkrMFhaQXB6ODIzVTlLQk43cGFRalBGQTM5NUpLRVUzZ2RDT25lUG55?=
 =?utf-8?Q?tbW3BjHPC52UQ9fJOc7aT6pcl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf05a5bc-7774-4db2-5f98-08daa083674c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:25:46.1970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNbVzF3u1+3KeF2ZDvxZLWYxMMKm0mpm7NmOd9N/na5H99TCj8h3LBXUeFbt71C389n8VPYdv4+0IvxpOl/eeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 2:20 PM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 5:17 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/27/2022 12:03 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>> This patch and switches the GPU workload based profile based
>>>> on the workload hint information saved in the workload context.
>>>> The workload profile is reset to NONE when the job is done.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>>>>   4 files changed, 20 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index b7bae833c804..de906a42144f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct 
>>>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>>>>           goto free_all_kdata;
>>>>       }
>>>> +    p->job->workload_mode = p->ctx->workload_mode;
>>>> +
>>>>       if (p->uf_entry.tv.bo)
>>>>           p->job->uf_addr = uf_offset;
>>>>       kvfree(chunk_array);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> index a11cf29bc388..625114804121 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct 
>>>> amdgpu_device *adev,
>>>>       mutex_lock(&adev->pm.smu_workload_lock);
>>>> -    if (adev->pm.workload_mode == hint)
>>>> -        goto unlock;
>>>> -
>>>
>>> What is the expectation when a GFX job + VCN job together (or in 
>>> general two jobs running in separate schedulers) and each prefers a 
>>> different workload type? FW will switch as requested.
>>
>> Well, I guess the last switched mode will take over. Do note that like 
>> most of the PM features, the real benefit of power profiles can be 
>> seen with consistant and similar workloads running for some time (Like 
>> gaming, video playback etc).
>>
> 
> Yes, so the extra protection layer wrapping around this is really not 
> helping (user doesn't know if the job is really run in the requested 
> mode). I would suggest to avoid that and document the usage of this API 
> as exclusive mode usage for some profiling use cases.
> 

As I mentioned in the other comment, this extra protection is not for 
not allowing it to change the mode, but from preventing PM reset from 
job_cleanup thread, while another work is in progress.

- Shashank

> Thanks,
> Lijo
> 
>> - Shashank
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>       ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>       if (!ret)
>>>>           adev->pm.workload_mode = hint;
>>>>       atomic_inc(&adev->pm.workload_switch_ref);
>>>> -unlock:
>>>>       mutex_unlock(&adev->pm.smu_workload_lock);
>>>>       return ret;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> index c2fd6f3076a6..9300e86ee7c5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> @@ -30,6 +30,7 @@
>>>>   #include "amdgpu.h"
>>>>   #include "amdgpu_trace.h"
>>>>   #include "amdgpu_reset.h"
>>>> +#include "amdgpu_ctx_workload.h"
>>>>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct 
>>>> drm_sched_job *s_job)
>>>>   {
>>>> @@ -144,6 +145,14 @@ void amdgpu_job_free_resources(struct 
>>>> amdgpu_job *job)
>>>>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>>   {
>>>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>>>> +    struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>>>> +
>>>> +    if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
>>>> +        if (amdgpu_clear_workload_profile(ring->adev, 
>>>> job->workload_mode))
>>>> +            DRM_WARN("Failed to come out of workload profile %s\n",
>>>> +                amdgpu_workload_profile_name(job->workload_mode));
>>>> +        job->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>> +    }
>>>>       drm_sched_job_cleanup(s_job);
>>>> @@ -256,6 +265,12 @@ static struct dma_fence *amdgpu_job_run(struct 
>>>> drm_sched_job *sched_job)
>>>>               DRM_ERROR("Error scheduling IBs (%d)\n", r);
>>>>       }
>>>> +    if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
>>>> +        if (amdgpu_set_workload_profile(ring->adev, 
>>>> job->workload_mode))
>>>> +            DRM_WARN("Failed to set workload profile to %s\n",
>>>> +                  amdgpu_workload_profile_name(job->workload_mode));
>>>> +    }
>>>> +
>>>>       job->job_run_counter++;
>>>>       amdgpu_job_free_resources(job);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> index babc0af751c2..573e8692c814 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> @@ -68,6 +68,9 @@ struct amdgpu_job {
>>>>       /* job_run_counter >= 1 means a resubmit job */
>>>>       uint32_t        job_run_counter;
>>>> +    /* workload mode hint for pm */
>>>> +    uint32_t        workload_mode;
>>>> +
>>>>       uint32_t        num_ibs;
>>>>       struct amdgpu_ib    ibs[];
>>>>   };
>>>>
