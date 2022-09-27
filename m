Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1588C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 11:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51AF10E2AC;
	Tue, 27 Sep 2022 11:48:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E811A10E2AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 11:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiZZONg1r2UxOy9zHJzBON2LhXS7sofGgZAPC3nou1axy0+iUiHpNaOdcQ4xFrvuKasQDQwBdyqjnnNXne5CWKlh9z4e8lO/bt8MBTG0LxSKhJNONuuckgltETMTNJrVN2qK5vahChESZEb0pYV9mNMqydEkKE3FkzvmBl+y0tSuv2klWRZ+go/QYS0qv5ktkTNYhfQKClxL0eY6qGBtOsQZGvnnajp3tnwMT0WjbCgxks+dE+KRjCp5e0Sg0bbNl5u4TC78PeSC3QwgmHWUL1HT0sW2aPdeEh8zf8EvFOMlDFhq13FIvfzt7Si0mm5rpJteJsepPb4BP/HroDge6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bpqDLNFM2bZDcnIPRVvWR5F/hjQaLCz8nXKIsqXGJM=;
 b=iqI89KPvOr/wck0tzhzui8c7hgH41ixJdhLIu6Bs5qgwncTWAcW4pmQWG0QL1/kDao5pHhkVLA59bWeRmfzCAU7106fRb5E/28LCe0KttlrSxCEwCkY6Kr85gVOLK1YH1r2qCwlS5fjp+u+vM4vcKZ4Ib86gwXoAegf6Geieb/yt9W2KX8cSy1yvZcVC0ItTGV22YtypONwjKUM+WzXiSAVIeRP6o452BzhBRR1t2rMIBdMPxF6iG9hSyndVvUslW4nukwJAZ4k4IfAXsOB8h9oTJwTbNZWavtEKaHn2qv2jX5dHVA+RDOtMuSSP8yRCBwIHyu0GSLIhvjf0NeWebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bpqDLNFM2bZDcnIPRVvWR5F/hjQaLCz8nXKIsqXGJM=;
 b=1MjuxpvbMfs8wfNRruPXuI/RGYF4IPhoSH9hrvjTofauQBPNYyMAlM+boQ7LuuQcLH+ycu02a2Q7ltN73N3SpuH1Ww1KPRhQ1BNkuUNakOms+n8EDeZeGmS3TGexneq8Fc87hf930Vwu/VvhEOYidEE9FDoL08pG2RLglxJMxTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 11:47:58 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c%9]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 11:47:58 +0000
Message-ID: <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
Date: Tue, 27 Sep 2022 13:47:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
 <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::23) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ba94bc-b60e-4e6e-7c55-08daa07e1f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cxkHBywz4rRmq26lUXt4ai0j0q5c2zC+jdeUk/G93fN8S0yIIqEaDMWegS2fJLpoSF7ocHZbw24eD82Ca5qiTSDXnNs5bL4kksoqnqR9AP7lkTly0wLABTP0AbqyBxLpc1lHQ6WuxoK0pEiOogF4vfqSDFne0wAwOuoMJc6xYlj9G01L99GizWMahlU+0wwULIHqw3hzIiM4rphDsUhMKnCeq1XFCCbV+iDDFFVGOFdMgxFqoK+qg382bTzRPRwL2FtDvLmTSOBn78XIhfoiTPTe4cHXS+FKJAaZ7Okw9ioG3LxIuUnpE0sFod9r1JxgSqM8vtTqXCNFWTNsgGgI3/5MDNG2e20bPe8hBdHDitGS/rl2Me9F5DkE4yEeXFFZUye8ycBftXPPU3jWQhPfpBbufPKSUBxxFfwdqZnAu4nwPR8h+2SJuy5224enSUxDFxGvNH/ffFR8uKP3lBuV5K/qQVd4Qwv8MbNPts8pkV8O1htM/j4xeA492/uh/oX+f6EJl/SszLb02ih8G5Cc9RPLxrL9opSFe810PCEQ7kVXhr8cZB7+WOyYXL8VNRI03JOqvjH+Kagux9p6gZkUkskZMd7GtQz6/65q0AzDZfXJuZXMHLAnlXF6LdjmU0kfjjgXSGVV2uwLE5VE0OmQ9eyGsS4q6OD+Xrhes5EVnAKTQo0MdZVGBAHGaEH13gVyXGCSTyV8Iq3tBv1qA6bkVmmgXEJep1aPBCNbQ26lbQ74eeleUiLylQHCcAcQtcyzXA0Ap8oYG6dLv9G4MCY2gUngSArMSHhn2PYjSwHJ9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(478600001)(6486002)(66556008)(316002)(86362001)(31696002)(4326008)(31686004)(66476007)(8676002)(66946007)(8936002)(5660300002)(41300700001)(38100700002)(6666004)(26005)(6506007)(6512007)(2616005)(83380400001)(53546011)(36756003)(186003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpEOHZjZmtMRHJwQXZhUTAyN2pWRm5nQWZyTkp4ZlFxV0xZK3JhWmRYbXFO?=
 =?utf-8?B?WFlLMHhYNGNIdXgzMktEejRPZTVlVmlwWTlKQk8wMlkrc1Z6YjU2RCt5TEM3?=
 =?utf-8?B?bkhCZC9NbFRXaGd0UkNweStjSFNhWm11c09RL2xnRStaeDdzTDgvL1BQc2Fo?=
 =?utf-8?B?MzRlTmh3a0ZJL2hNeWk3dHBOODhNT0JMTHF3MExKbnNYeTg3eDR4c1Z4UFFy?=
 =?utf-8?B?aHpld3dHS29XcGZZaTBNSjZOLzFPMDgwSWd4ZUU1M3VXdnVmemtUOFRJYTdG?=
 =?utf-8?B?Ynd1YUVHUldqcmpyNzh3MWhIUTNPWitveHFKaWFhUmlmWXVOcFlHbDYxU0Ex?=
 =?utf-8?B?YitpaDhkZHN4M0gyY3ZvWE1hbnZxYlJLRGsrMlVDaC9hMC9DUmFDRkRQQ2kv?=
 =?utf-8?B?Q1g1VENGZkRNeDZjajdmQ0dEazIvelcrVVA5YWozZDlod3MzRC9uSG1IVWVq?=
 =?utf-8?B?Ykk5RlpPRGVRbTNQMm16Rm4yN1l6QncxMHppTDJPWFdZenlISnZ4R0hoYk1M?=
 =?utf-8?B?OUF3Y04wWnBGZWNudDN3UkMxbjJiMDRRYTM4Q3JCMkF0cU9WbTEyVHFBcjll?=
 =?utf-8?B?d3l5c0F1aFUvazhsVkhJWksxdjFDRGlUVjgxUzNGY2lqanBaNEpOMk42T3Ju?=
 =?utf-8?B?MWpvcG1qeWpPcE1KeFpJekxnZmFWZkNkUndmS1RmK0xBc0VieXh5aHpGays3?=
 =?utf-8?B?VjVOY3NGejNxZFp4TWFqeXNCT3NXQW5NQlloRE5qOTdoOWJSbHJYMGVjY09U?=
 =?utf-8?B?czRPdU1GNXZNVGRpQllROUdUc0dCdnRySHFuOHA4aGpiRVVUa3doSzF6alpU?=
 =?utf-8?B?Mm9DWnJ3T1BMVm0zRjBaTGpSalVHL2N0bFRIY0E1bWVUNy9lVEFxTGd5cE1n?=
 =?utf-8?B?aWJYenpwTjMwL2RVWk1MMkd3LzN4T3pYU285RE5hMVFpaWp6SHFGTTBTc0hi?=
 =?utf-8?B?YStQZnkxeXBlK1FDTkk3bU04ZXUwYUJjVTd1S0JCeVFrZjQwUWFpVDFlNnl4?=
 =?utf-8?B?MkhuOHVGNFhjN21uWkFGQXBMUnROd2dEM2trQjJWemIrTktzMnhKMEVkZWVS?=
 =?utf-8?B?ZVR6TFpKaXZscGh0bEZPT05ESHh0bm9zbHRmT2ZtOXd3OVhKdisvRnBuQUhv?=
 =?utf-8?B?Ry9Qa2VKaXl5VWpFVGNjS1RmaFNMUFdnK0NiMmZqNGlQSmg4aHBhMEpOSnZu?=
 =?utf-8?B?ZW9zTG1SSmJXYXcvQmV2b2FNMklhV3kvVW9EUXVWbUxDZzlWTlllQ2tXTExU?=
 =?utf-8?B?MEIvdkJHcml6Q3JTUVdUY090WjczUkdwMEhSekxOUC9IU0h1bUlXdE9tdjJB?=
 =?utf-8?B?cDAzbTN4OVJjak5nYnhvTnFzamFPSnZHRmQzbXhqYSs5RVBHUC9Dcms2WFRa?=
 =?utf-8?B?dTJpelV5QldYQk4xVWtnUGwycEtOYk9KRW96UUZuTkE4T25Iajhxa3R4TFdI?=
 =?utf-8?B?ZGVvcCs3Ukc2N0VycUZ0NHdrVllJN1dRL1pqSEUxZk9kY0VDNmFSVWQvbC9J?=
 =?utf-8?B?dHVYalhjbzZWMU5NTU9OQk5GSklTdWF6T1ZOdWEyK3hjbDRpN1FzNmhvdkEr?=
 =?utf-8?B?cjZRWXMwcWdGdkRBTy9nK1F3OEpzd2ZwUHdaemhkSXZHWlpJRUlJVG5UVkIy?=
 =?utf-8?B?N2J3NndvR0Y3bzY4azRmL1pFb2ZndC9LRFoyRGZqWmE0M09qdkVDenFIbUg0?=
 =?utf-8?B?Z2syL1VBb3dUaXYwNEhXMEVqOTRTdXM3RkhJdm1qT0lqbXo2SzB3bXRjWlN2?=
 =?utf-8?B?Qk5laHpodml1UU1NTkZPZDRPc0hsclUyN0Q3dG5OUUtDbnJYNEZzQW81WkYr?=
 =?utf-8?B?ZWo3aUQ1UXZBU2FOUGVDMzFmSXcyY3RxWnI4TWxwdi9SQ1BwL3MrVFhpeXdH?=
 =?utf-8?B?b1E5ZE0zcExmSndQemxoWHBIRFBpb3JKalVMeEQ4RWFxbHEwdmVGYkhqS29x?=
 =?utf-8?B?ZTVKbFREVXRDZ0paTlhKb0gwOFZjck5ybUtoSDVVK1dPcEVxaHpRYTJWdG1i?=
 =?utf-8?B?ZGRJUmJBTzFIU3RrN1ZOQ3QyTnB2TUN4ZWxZNGNQZEpXUENjdEloTUdGS0Nk?=
 =?utf-8?B?UDlvRUpxNkNYMlpSMDZZblg5aTlRUEZlZGdBbDNzWGRGc1FJeFN5NnRHcUdP?=
 =?utf-8?Q?OgnzUxRLE5recfMAj0PI+fMaG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ba94bc-b60e-4e6e-7c55-08daa07e1f47
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:47:57.8855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDT6oFjPe1n3Uk6PIM32GCQOvcN04gTfZCHurW4XuwRV15J3VA4lpzSYPeXu99u0rY3eeoJlG2rQMNKInAFb0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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



On 9/27/2022 12:03 PM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>> This patch and switches the GPU workload based profile based
>> on the workload hint information saved in the workload context.
>> The workload profile is reset to NONE when the job is done.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>>   4 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index b7bae833c804..de906a42144f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct 
>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>>           goto free_all_kdata;
>>       }
>> +    p->job->workload_mode = p->ctx->workload_mode;
>> +
>>       if (p->uf_entry.tv.bo)
>>           p->job->uf_addr = uf_offset;
>>       kvfree(chunk_array);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>> index a11cf29bc388..625114804121 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct 
>> amdgpu_device *adev,
>>       mutex_lock(&adev->pm.smu_workload_lock);
>> -    if (adev->pm.workload_mode == hint)
>> -        goto unlock;
>> -
> 
> What is the expectation when a GFX job + VCN job together (or in general 
> two jobs running in separate schedulers) and each prefers a different 
> workload type? FW will switch as requested.

Well, I guess the last switched mode will take over. Do note that like 
most of the PM features, the real benefit of power profiles can be seen 
with consistant and similar workloads running for some time (Like 
gaming, video playback etc).

- Shashank

> 
> Thanks,
> Lijo
> 
>>       ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>       if (!ret)
>>           adev->pm.workload_mode = hint;
>>       atomic_inc(&adev->pm.workload_switch_ref);
>> -unlock:
>>       mutex_unlock(&adev->pm.smu_workload_lock);
>>       return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index c2fd6f3076a6..9300e86ee7c5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -30,6 +30,7 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_trace.h"
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_ctx_workload.h"
>>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct 
>> drm_sched_job *s_job)
>>   {
>> @@ -144,6 +145,14 @@ void amdgpu_job_free_resources(struct amdgpu_job 
>> *job)
>>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>   {
>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>> +    struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>> +
>> +    if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
>> +        if (amdgpu_clear_workload_profile(ring->adev, 
>> job->workload_mode))
>> +            DRM_WARN("Failed to come out of workload profile %s\n",
>> +                amdgpu_workload_profile_name(job->workload_mode));
>> +        job->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>> +    }
>>       drm_sched_job_cleanup(s_job);
>> @@ -256,6 +265,12 @@ static struct dma_fence *amdgpu_job_run(struct 
>> drm_sched_job *sched_job)
>>               DRM_ERROR("Error scheduling IBs (%d)\n", r);
>>       }
>> +    if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
>> +        if (amdgpu_set_workload_profile(ring->adev, job->workload_mode))
>> +            DRM_WARN("Failed to set workload profile to %s\n",
>> +                  amdgpu_workload_profile_name(job->workload_mode));
>> +    }
>> +
>>       job->job_run_counter++;
>>       amdgpu_job_free_resources(job);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index babc0af751c2..573e8692c814 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -68,6 +68,9 @@ struct amdgpu_job {
>>       /* job_run_counter >= 1 means a resubmit job */
>>       uint32_t        job_run_counter;
>> +    /* workload mode hint for pm */
>> +    uint32_t        workload_mode;
>> +
>>       uint32_t        num_ibs;
>>       struct amdgpu_ib    ibs[];
>>   };
>>
