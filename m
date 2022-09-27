Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4809AC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 12:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA8110E904;
	Tue, 27 Sep 2022 12:20:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA5910E900
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 12:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz3TjIoo5BmplwF1Kq3RCq3FjRYsyiK2bxWh0pkejF5mOHzvTv9RMX1M1TgyVoSKr/Rg2uN+bETue4Q0jQCnCfQrKmCDHfOb7qqt4wgf63d/mPGyzG4slBlV6Ecqxh6Bn75gSYRW3hiIjtCwfVRloRk0UhVNKr9zC+UUdQovHy+XfuCxGE7PxSWCKliafWCm+lv6nDIwWvFjHDrich07ft2FpA6rILda5qQ4MVjurwJisA7Zy2PyxhIvkOLWJMwjSwEdoATrnTrwUgUdTNpcGhl0w7c0iteQwM3DttdHhtQM6FPTO8Zb//Zu7wiQ7PDgH4M16i9yLvXL8+yIJ7u59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeE17Vm9QQ0kahn2W291YJYo1yGkAmUJowJNvGmcfDk=;
 b=XBkqREay3XHW5LvQaZQhntZX0RfOr7nh8UiSvYhNohVp9vyyXl0fpAPVzmQNq2apjpH6gIz+mzH8dXkGCDTRgK3qrCXspJtLKWomwPrW2y+8x0gZq+K3ZbQjohh6FIZMl2r9QZ9zK24AsaxONFQsxhyfzAUdtFybps9aQ04zfPQ8fUKpb+cNUoTfS872/Eb/kR/R5RiXP9r7/OuJVaLCwCQg8dp6+/e6S7W4RqkMxmWvF2f2F6362KqeE5Bbtky3gWMGByuQc6iiiCMV3N+v/OXOVbXNbEgbcS/K1/lZCo4w3YXLyQtcY8kntgF3UXP7cVpZVkw1WaVFayFZ7JCX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeE17Vm9QQ0kahn2W291YJYo1yGkAmUJowJNvGmcfDk=;
 b=5Yi8+35xYvIw/cSnmiwQ8otRxw0pFMv1mBna9Qq3HMGVqU7g/414RS06NuFOL2uQDXtHKtMcVbqEDeAwCkJ8cPdNGr1frA/Sq5R6JhVmGjqjdlRpglExkp4ZDB9xl/Kom0cI2Sm75FZGydCorV4Th2wMfqkRs3M0M0ztAZ3QqkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5293.namprd12.prod.outlook.com (2603:10b6:5:390::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 12:20:46 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 12:20:46 +0000
Message-ID: <60d98c36-165d-8e59-d110-a4f2ea2977f5@amd.com>
Date: Tue, 27 Sep 2022 17:50:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
 <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
 <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc53ff9-99f5-4256-f31c-08daa082b468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qG9JCle6PatByNRB22lw4NBOU/NL1/MPyChyargd+ujonc7XutqkmCrWxQaEYYYYDJ/HxryUn0OrBdfPzNJ94wsqPeJg/qVADYmmrha+Vp/PhhoeLPZ9Yo7JcxO7B73D7z1OZFGnbS9t2l9aUaIFOXhJEb1ldv4WHh5SUyTvkozmdYYGFFqko0KeRE0Ta75W2e6edkAVSe+QRddUSHgkT/MxziaZc6R0bqcpSLrsY++fTDK8wXkyeNyweSO93lsupRqU0/MOARmHA48NtCzZBsWFZZAjh6wiNFHvVa1pTDwm4wjbQfAPcHSmJYwy3EAFn1Vvee+a06u94AISbby/mP/m4knv6JtJy26zvTHg4hkOzkdDqP1ybLR9mkO4TywP2bIVhd+mA6RaR89oZ1V8LeJ2sYTUXg2P5x+/r+aH6mUgBccaEabU1yGEvUUH1A6J/GLzVUxYMf5ZcPBxFgPYbIf4meoyPhmZ6DsKGEIVMOeSulgdF3h4p5uMik4mrddAVHk5xbnQLZni48G5TQbmf6DeIY+VgblCPq+p87ltC7DEfXTErcn73htRg9ZIiVS3X5gi6zh8HQxGr4pZHZTY7++UFwAu1SwCJMVzGt0hG5x9OZEEECyfWMtletc/MZ3uc2lm45s4shLh4mkpPZdZOGk8KNXdcg7nBxPf0lkDDqd4rtQK9Ttj7kgUUs07/TZ7E24v5MWCTP0+q9LHtuW2y5ReCwZwYSH6ogjEwQF6SeA+5jqMCKxfEeXdZNNaEVk16hF7/PeBwcnpKgYPjQ4cWt5RIL1uAb50Rf+K+U4oF34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(36756003)(316002)(31696002)(86362001)(31686004)(6512007)(83380400001)(186003)(38100700002)(2616005)(2906002)(53546011)(26005)(6506007)(6486002)(6666004)(66556008)(66476007)(8676002)(4326008)(66946007)(478600001)(8936002)(5660300002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhvUm5saTFVamwvc3huYXFIVEVTa09USkdWSnNmYUJiU045aUFaU01iRTdx?=
 =?utf-8?B?K09wQW9BR1Z3L0c3bTlMOGNNNEdNQzBCSUFWQzdUc3JQTEVNK3RqMlFzcHJz?=
 =?utf-8?B?UnBlS2J5TjBlS0ErejdadHpzd0M4NkljYURlREZ4TFZzMEI4SStBV2NTY2o0?=
 =?utf-8?B?Z3BlOXc5KzJsdFhWcTB0eTZmQzlVb1VkcENScXBjRE5KY1ZoTXNOUXpxSDFw?=
 =?utf-8?B?aEgyTXBoZE1HaGFFbm4wQXgxcUZPYW1FdjdFWnZ3RzNMTHRDcm0vRmlNNnpa?=
 =?utf-8?B?cEc5bGNnNE5CN0haT3ZLaG51eVBXMzNhU1pjMDF0UUtJQmFGQ1pLRlZod3VJ?=
 =?utf-8?B?WEUvakZ6QW9VMnZLTnIrTkNiaWk5UzNwQWgwMlRSTko0Q1hIbm50a2huVEpa?=
 =?utf-8?B?OHZ4ZEZ6ZWJqdnJpL0JhYzdoL3c4OXU2REVYMzdMQVRjMmROQTlWT2pjY2R3?=
 =?utf-8?B?aTVxMWdabEZsWHFWTVcxNkZTb2NVWDlqUU5BUUhiRktBRmZoNktIY3IzcElU?=
 =?utf-8?B?d0FMbGpmdXFhbnFRZzkwN0p0dXhoQjBtdWJPZTdkWEo5VUdTQUpMZXM5bGN0?=
 =?utf-8?B?RXZ5dkxFWEtubWdKbmxBWTByaGNXdEx0b0s3OWZzRWhLR2ZUTzR1ajRwcUll?=
 =?utf-8?B?bDRzKytsNHJucjRKNlc2YVhNT2VyM2hNc2psRXBlaktJWGYxeElEZGtjMGZ0?=
 =?utf-8?B?R0R4QTlnN1ZjZHlyRFQyMCtoRVVMRDJHaWc2WXJqZE42K3RZc2U3RmpVcHN2?=
 =?utf-8?B?UC83dkhqa3poYktHSmdsdksxamZRbTFBN1ZCTEZMamVHaG9RTk50VnoxRklV?=
 =?utf-8?B?Rml6U0lEQU5XRk1ZcTZLeGMrN0doWnhUOHNLbHhHY3JDalBMUGU4a1Q5Vkpq?=
 =?utf-8?B?SXBLRWFIdFRJSlYvL1JiUWx1VlZndUNwOUloZkhHVHNwZkJtaEZvbEVmWVE0?=
 =?utf-8?B?UWEyR2RkWThLU2l4WVZPL2VDbnc3bTJ0RGNQU0lQVnJxNXF5cmpsNTRLT3k5?=
 =?utf-8?B?cXppWmExVlhrT29jeWpIem03a0RaZ25yM3hhK25oQ2l0WGFWYnFzMUtZSkFB?=
 =?utf-8?B?c2xrTWdML2Z5eGFueU1PUGNUMkQvSkxXbzgrQ0VrQ2VHdTFPU20vVGFlQ1JW?=
 =?utf-8?B?QVNrc21kV0ZWNWltU21lUW5tOUthVFhVWW9wbldNWUt1Ylh1S1pEMXBKUlJ2?=
 =?utf-8?B?c3RiNnl1TXh4Zkd4N053ZnFIemwxempRclhUMm1LSkh2OVZ4R3QrYUZEOEtZ?=
 =?utf-8?B?ZEQzcHpIV3BVRG5GVVJ6cFlQd3BmLzBLWHU5eFFKSm03SzdMYU16TVBBV2ln?=
 =?utf-8?B?NWpyeFdNV1pEWlJ4cXh4Q1BWd21ZNUVJcTE5cGR1ejhnbVJqRlQ4RmNYWXhZ?=
 =?utf-8?B?RGROTmZMZWFFa0JEWlhzWU14UXdsVFp5Q2Y2ckxRWTFlSVYwTHB0VUNMTzJX?=
 =?utf-8?B?cVhZZWJwNkNvaWN2V3JEMEl6VWhjYjlVaUFoL2J5S2NndDNuR2VpRmdUdk1v?=
 =?utf-8?B?ZW9GWkE5aWpBdHE4U29RTGpIemUxWE1HN29SVU91V25kU0ZlWGRiNDY1UHZ6?=
 =?utf-8?B?SXNuU3ZIRThBR0xZa0FMcXhTcDBTNEhGTGk2UGVqQ1lQNU5PRDZPNmFOdEZ3?=
 =?utf-8?B?SDUyZUFOVGg5K0tHZ3kzdzQrTkQ4bDVvbGlaNmF4Y3NSbTk4dkk1KzdXUmZ5?=
 =?utf-8?B?cHljNms1U1prb3Zvd0VoWGdINmh0VjVhVjFQRzF6bkpnTzFTRXdaN2tvOFMr?=
 =?utf-8?B?L1c0WWY3aUJxZ0V2dk83NGVrWC9iS2RIMm1NSXBGc3h6TEpacXpKOTdCOEwz?=
 =?utf-8?B?dnRPZ0lnSENlZTlTeUdJZDBOMzZpdmRzVFpWRW85cnI5RUhzQXlSNy9kR1N2?=
 =?utf-8?B?cmkvZFNkWHRMblM5UWhTdU9iVWtBSlJ2K2NsbVRBS3FYUGkxb201bTYyQlVk?=
 =?utf-8?B?MGZpUVBVV2s2cGVUWFFsY2tiVlVTa0F0aFlsYXV6ellLditJOFlaTzlEYkNl?=
 =?utf-8?B?dFZuNW5md2hoS0pPaG5UOUxVL0JQcm5CWnBhWjFIMDNjSTBreW5DMnF3NGUv?=
 =?utf-8?B?eVhKR2xkb3Q4ZGJuZHUyTUpRSUxMUEkwN1ZWU3VJd1dTWTlscUk2STBvdnZS?=
 =?utf-8?Q?NTnhOvomfJnJIJ7JjEdOYfNG2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc53ff9-99f5-4256-f31c-08daa082b468
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:20:46.2909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1owdBnaALa8SqWdqedv/sRZuxaAMQC5C/c+64gFGj4B6XkkUhRtNavbDhGc6MGWD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5293
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



On 9/27/2022 5:17 PM, Sharma, Shashank wrote:
> 
> 
> On 9/27/2022 12:03 PM, Lazar, Lijo wrote:
>>
>>
>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>> This patch and switches the GPU workload based profile based
>>> on the workload hint information saved in the workload context.
>>> The workload profile is reset to NONE when the job is done.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>>>   4 files changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index b7bae833c804..de906a42144f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct 
>>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>>>           goto free_all_kdata;
>>>       }
>>> +    p->job->workload_mode = p->ctx->workload_mode;
>>> +
>>>       if (p->uf_entry.tv.bo)
>>>           p->job->uf_addr = uf_offset;
>>>       kvfree(chunk_array);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> index a11cf29bc388..625114804121 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct 
>>> amdgpu_device *adev,
>>>       mutex_lock(&adev->pm.smu_workload_lock);
>>> -    if (adev->pm.workload_mode == hint)
>>> -        goto unlock;
>>> -
>>
>> What is the expectation when a GFX job + VCN job together (or in 
>> general two jobs running in separate schedulers) and each prefers a 
>> different workload type? FW will switch as requested.
> 
> Well, I guess the last switched mode will take over. Do note that like 
> most of the PM features, the real benefit of power profiles can be seen 
> with consistant and similar workloads running for some time (Like 
> gaming, video playback etc).
> 

Yes, so the extra protection layer wrapping around this is really not 
helping (user doesn't know if the job is really run in the requested 
mode). I would suggest to avoid that and document the usage of this API 
as exclusive mode usage for some profiling use cases.

Thanks,
Lijo

> - Shashank
> 
>>
>> Thanks,
>> Lijo
>>
>>>       ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>       if (!ret)
>>>           adev->pm.workload_mode = hint;
>>>       atomic_inc(&adev->pm.workload_switch_ref);
>>> -unlock:
>>>       mutex_unlock(&adev->pm.smu_workload_lock);
>>>       return ret;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index c2fd6f3076a6..9300e86ee7c5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -30,6 +30,7 @@
>>>   #include "amdgpu.h"
>>>   #include "amdgpu_trace.h"
>>>   #include "amdgpu_reset.h"
>>> +#include "amdgpu_ctx_workload.h"
>>>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct 
>>> drm_sched_job *s_job)
>>>   {
>>> @@ -144,6 +145,14 @@ void amdgpu_job_free_resources(struct amdgpu_job 
>>> *job)
>>>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>   {
>>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>>> +    struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>>> +
>>> +    if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
>>> +        if (amdgpu_clear_workload_profile(ring->adev, 
>>> job->workload_mode))
>>> +            DRM_WARN("Failed to come out of workload profile %s\n",
>>> +                amdgpu_workload_profile_name(job->workload_mode));
>>> +        job->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>> +    }
>>>       drm_sched_job_cleanup(s_job);
>>> @@ -256,6 +265,12 @@ static struct dma_fence *amdgpu_job_run(struct 
>>> drm_sched_job *sched_job)
>>>               DRM_ERROR("Error scheduling IBs (%d)\n", r);
>>>       }
>>> +    if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
>>> +        if (amdgpu_set_workload_profile(ring->adev, 
>>> job->workload_mode))
>>> +            DRM_WARN("Failed to set workload profile to %s\n",
>>> +                  amdgpu_workload_profile_name(job->workload_mode));
>>> +    }
>>> +
>>>       job->job_run_counter++;
>>>       amdgpu_job_free_resources(job);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index babc0af751c2..573e8692c814 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -68,6 +68,9 @@ struct amdgpu_job {
>>>       /* job_run_counter >= 1 means a resubmit job */
>>>       uint32_t        job_run_counter;
>>> +    /* workload mode hint for pm */
>>> +    uint32_t        workload_mode;
>>> +
>>>       uint32_t        num_ibs;
>>>       struct amdgpu_ib    ibs[];
>>>   };
>>>
