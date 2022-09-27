Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D38C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 17:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A89A10E125;
	Tue, 27 Sep 2022 17:06:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B463A10E125
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 17:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aagJmb5UeNMvV0qLVndJI70qh9zs4R9I9+chHaQIwNYeMy0fhWqiUFjWgey7A2FmVkbmrwkFCMBTFIOA8YQGqruHjYYhqf4dQOFjENfsMnsBXQSDrX6pdozabFtmJ/QZZc1guFLwMy/xEvud4KJTFRy6m9XED6Z93rZrs7NiE9e5MIPfUjHPe9I6Oy3OvO7+eqUhqH6LrQmctm/fxOOTmZdV53u8irvlR2/94D3U4+jryBkuhJeEpgkHRSMYWEiXYfvl41u9xm+ztDVrTsZXvQU5QuWbkQOR8XNnrCUS0xOBko7gBYxBvQDwnYzvlL8yWPA73qB9QkrtCOHHuQt3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiNPfiNc2BZOBuhpLTi2/jogaxmyARQfDx/CXUTKfpU=;
 b=WOsGxzivN0igzLcutivImpBp4KhQ0B4v04VZl0X6ujWzticLa6B3AGDx+7SNGBzMf1DCWpEol6EX5WiuoHTfqcZPBf1BYoc8hFNgppCm/tHUbiAbXOrs7gw0MmGYUVN1zEgOOIk5jDVUznsrpIYcXe0s4IjvYdtAzUCL+5EOYXzoK9c8us3ST4CIjp66eyID8I6Jefv0HEgZAT/TNSrmC/PawNwyE6TXgptlreoQP+nCQgkaFEkk4QiYSHNKIX85lgaBzd8ALlMhnvdDhvkkFiF+lwaRW/3erPA66PbFGIKSkCympWOkWs8Z0dIPZK09je1Tn0HCje+hmPVC+p50tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiNPfiNc2BZOBuhpLTi2/jogaxmyARQfDx/CXUTKfpU=;
 b=fi1zunRd1ECRnIRp7TH095OWaA5eDNMVruKQ2Lmta2sQHmm5xuxRGluBA+8I3+58KZil8Q9NPOTayI29i7tY2A4oN2FeFkMzN6/2BnE3unTxHMlvPK+x1dKmIXdEqhhCUaRNkVpwBtLkV7Z1l8IUlMz27fUFXCq6JRYXUN1NW24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 17:06:20 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 17:06:20 +0000
Message-ID: <525fc540-bec4-339b-6b77-4dd938c502a2@amd.com>
Date: Tue, 27 Sep 2022 19:06:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
 <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
 <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
 <6ae60041-6db3-450f-2ac7-2f4415779818@mailbox.org>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <6ae60041-6db3-450f-2ac7-2f4415779818@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: a520de6f-3e13-4bb5-8dcf-08daa0aa9922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyfSmIJGIwyc84zyRYBJKmjM1Uz52aC1jdTgkgLJz2UPeCdExph1hFm+WvW3GNGZ35WWx5fUAf395sL6snwLTQd+AzuNK9zbvjnszm/WPpu0TeD/J6zYbuR6mG3IE0jZp3TdzSTIn9DFEtoC1xXciTEhSfZ3qn67TixRfQR/9pwTAlt4mWo/ANmHMOqq8kIovxIzqCa0UtP9DduirLl1rubytQHtxb1ZjI4gDN36ig0fXlPR8F2/NLvsNDkznG9jRRtmzS6YNgktIBrt+Tq6XAY9svGR/yDe8u1WpaxXIxXeHD040W7fhWZvT5vqyDuQkUyB6JGhhWTGc/rs/ikrVxh7L04WDAd/6L66+sxu93H+C5sMxeEdIZwavpKG7Qp50nadD76IevDhCYa9lGXlz6eHHpCUicSi3s1l5Ja2RPx7sKhsU7VSP/QAFqRgUsy7gTP0f6qFSsag3WPJnL8a0yvlwIcKGx3NCRhgJUnrEInRIHsOdtJyTy558RpAuHb77zLsiolUQ/bmwR40mZh9PbhZktH5p1eNUF8k7W9kKkH9Waiy80ri8knAUmbz3lZhAY7hSdPQUb9BvGOTzS59Om8Z1SWBGKre4uRDem9cV0lMFKjrwxZSbOV9Il1II5UU9svcvAIJJ4VbZfNoFh2oUkYhQWmC3JbylcSASiuTMhoZKq9epCCe090Qm/M90bummbgzAcZ2eOjw4LFPudegAHErp0nWmsEZwnqYv1SUR+/8XztQM++fgTHLdFcEEe0JDgh8JrsJMt/cWBZh0AAXfhOmjOcaTMV8qK1IgD9HBY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(6512007)(6506007)(6666004)(31686004)(53546011)(26005)(36756003)(66476007)(66946007)(38100700002)(110136005)(4326008)(8676002)(66556008)(41300700001)(31696002)(86362001)(2616005)(186003)(6486002)(83380400001)(478600001)(6636002)(316002)(8936002)(5660300002)(2906002)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eml1bzBSTC8venpYdFVaanc1R1lyOHVpQjBQeFhrREZ0elVsR3RZYnZva1E5?=
 =?utf-8?B?REgxNUFUVmcxU3JGM0hZd1duVDhGUjNFVDFBMVgxU1dwN2pETDl0WmhYVGpx?=
 =?utf-8?B?djBiRE5SaEtyTTFwL2R0NEVINXBqNWdxODgrSDB0RjJ0MGVFTFJnb2Jmd3BG?=
 =?utf-8?B?ZGU4YmUyRStsNFVOS3R2UDdRMnhuSjg3ajdzM0tDbjNTdXdUUElSblVWRUgw?=
 =?utf-8?B?cmRSdjZia0tEWGNEYy8rNkl0Sk1iZjMxUTkxbWlxcDZsOGwvM3pnaHEwRHg2?=
 =?utf-8?B?UEI3R3Y4czZwVnVNZ2N1Rjc5d0x5L0xmTE1HS0gzTVFIOEU4ZnpnMmQvUml3?=
 =?utf-8?B?MlBJbDVidnFWcE5RaVZaSXBmd2tTRTQyWGJja0J6K1NFN3JYQzdRaHJ1Zisz?=
 =?utf-8?B?VTE3TzUxNUhxc3Bud0pmL1BXbDJzdGQ2Y0h4ckYrczc5eEV5YzFucXNLckk1?=
 =?utf-8?B?WkxIV0tDTDhrSU9LODFWbkdwejFEUi9CZEpXekFXVWVONFI4dVRybm1teEZ2?=
 =?utf-8?B?Zyt1NkhRdWNWakdVeGFHY2wrMHVueWhiTzg4Zkp0TXZOLzZyRjEyakZsRUR3?=
 =?utf-8?B?TmJxS3BTajc1WXBSQnFJR3h2cUV6MEF1Rk96TkM4YStCeU1wQVBUM0k4UlEz?=
 =?utf-8?B?UU5oa3NNWVJ2NHZJbWVuK0lKRHNGcktHeXVhMGZNNzU0U2p3bVN4Q3F5QTNI?=
 =?utf-8?B?NzdrT0xVM3BKaVBjenlvVUw3TEtyMlFGT21FYkkwajBjdllvVVFsOUQwVGgx?=
 =?utf-8?B?V2QrZk9OOTV5ejFETzNYR0tvdk5hRUo0TXpJRHhZUHMxVkhvVjhmL01RR081?=
 =?utf-8?B?RFZOZCsvNGlURThYUHRjZGZ5Q2J4WkFrbTR0OVNVdTFNcm1WNnN4RnptRkxR?=
 =?utf-8?B?RmVZYklTMkZRMUk4ejlFMmZTS0RGT3c0em93M0hIemdmT2FsdUNqZCtRZFdV?=
 =?utf-8?B?YUQ1R2dVa29WMkltcTJWazV1S0p4Um4xTkZHVVdyWWd0cG8vajFQKzZrVm5p?=
 =?utf-8?B?VzNqWlhTbTFmOEpXSjVUT25sVFU4aHlNNDEwazRIUDlpT2prNTVNSVIxNmRS?=
 =?utf-8?B?N01zbzJRRlcyQ2RqdnZXa2dSWGtVZmQ4NXZ6VlhHRmJnTEtDSjYzWGFmdlhM?=
 =?utf-8?B?SHpwRysxUG41SUk5ZG96YkU3WkVwU2hOaWxEZWY2Yk1CQ3M0MkNPa00rSWNP?=
 =?utf-8?B?VkRMNk90ZUFnc0RjWUlXZGJnMm1LUVJpQVN4MkhhK25nU1BWVllvUUtBdyty?=
 =?utf-8?B?WnZMMGg4QzRHTFhRbCszbkpnNi9lQWI0UGxKM3pPNjFuMis3bmxYWmtYMFAw?=
 =?utf-8?B?ajJkMWVacTlsUjNiWmpmSEZKZE9ZL25NV1Z3SU1wbDBGaTE1YmVuRzI2RVFu?=
 =?utf-8?B?MlY5VGRzSDcwNm1hdk8rOXU4N3g5UFMyd3FxMVlOMUF2ZFl5ZE1tZFNVUUJU?=
 =?utf-8?B?eHRrRFlhdlp6ZUpHY0NsRi9nbUVrenFIUXdvV2xFV3Zpcmxqckloak8wbUVD?=
 =?utf-8?B?WVAwMjlQcklvZzhYMG5BR3ZmZDBLeldqU3kvOHlWZVR3Q1ZCajUxSkw2VXVk?=
 =?utf-8?B?NFZDUUlVaEx4cUdUWnRBUUFjR2RYbDVoWEtYTzdPbGNaM1N6U0NkSGpOSzFv?=
 =?utf-8?B?RHpCVXFWOW0yemIrUDd0dnRmMTBnNkVlaTZHMXdvL0ZabnlDNHNsT2JGdllT?=
 =?utf-8?B?T0M2VC9Cc2pMTWNKOGJHVlp6ZGJTUjNwOWd0ZTJ1Y0ZZSlZNWjd6SVdBQ2hv?=
 =?utf-8?B?SUdxUHUxcDdnM0xaSGxBR3JrdDgybWZ5R3hEbVVLcS9pSzRacWwrNUxDM2xI?=
 =?utf-8?B?MmI5TnBEejBDMndDUWdqbTB2NGVYbnU0ckhCQ0puRFdCZy9CZVFVd1E0UlZM?=
 =?utf-8?B?V0lxWnpnd1ZHb1RIV2ZpU0ROaWcvUWJoTHJ2Wm5IbS93bEtCUzJKR295eGpF?=
 =?utf-8?B?cnBZYVF2UTRyZGh1VE42aDk2TWtRZE1QLys0S1ZsNjNvOVZ6Rk9YcDg2aGla?=
 =?utf-8?B?TE9WVTl3amh2U1d5TFk1N3NSY1RZcG15VktMcDhhNDV1a2VNRk1UemFpTE1F?=
 =?utf-8?B?ckVoL29hM0xldDdsdlJyRHdmbGtxb2Z0OFVIQUFJOEhBTk5ZanpienFBSC9Q?=
 =?utf-8?Q?8ckrpJTU99ZxI1dp7fB6iYxdU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a520de6f-3e13-4bb5-8dcf-08daa0aa9922
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:06:20.3389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WB+o2z3uwaOgSNoVHCvyVenQXfhd33Ck5VU3or0a1znbTsnRkizHyeE2XY2hxSyI1OtTcccSpbB6WX0727uQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 6:33 PM, Michel Dänzer wrote:
> On 2022-09-27 13:47, Sharma, Shashank wrote:
>> On 9/27/2022 12:03 PM, Lazar, Lijo wrote:
>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>> This patch and switches the GPU workload based profile based
>>>> on the workload hint information saved in the workload context.
>>>> The workload profile is reset to NONE when the job is done.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>>>>    4 files changed, 20 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index b7bae833c804..de906a42144f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>>>>            goto free_all_kdata;
>>>>        }
>>>> +    p->job->workload_mode = p->ctx->workload_mode;
>>>> +
>>>>        if (p->uf_entry.tv.bo)
>>>>            p->job->uf_addr = uf_offset;
>>>>        kvfree(chunk_array);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> index a11cf29bc388..625114804121 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>        mutex_lock(&adev->pm.smu_workload_lock);
>>>> -    if (adev->pm.workload_mode == hint)
>>>> -        goto unlock;
>>>> -
>>>
>>> What is the expectation when a GFX job + VCN job together (or in general two jobs running in separate schedulers) and each prefers a different workload type? FW will switch as requested.
>>
>> Well, I guess the last switched mode will take over. Do note that like most of the PM features, the real benefit of power profiles can be seen with consistant and similar workloads running for some time (Like gaming, video playback etc).
> 
> Not sure how that's supposed to work on a general purpose system, where there are always expected to be multiple processes (one of which being the display server) using the GPU for different workloads.
> 
> Even in special cases there may be multiple different kinds of workloads constantly being used at the same time, e.g. a fullscreen game with live streaming / recording using VCN.
>
It looks like we can accommodate that now, see the recent discussion 
with Felix in the patch 5, where we see that 
"amdgpu_dpm_switch_power_profile enables and disables individual 
profiles,  Disabling the 3D profile doesn't disable the compute profile 
at the same time"

So I think we won't be overwriting but would be enabling/disabling 
individual profiles for compute/3D/MM etc. Of course I will have to 
update the patch series accordingly.

> 
> Have you guys considered letting the display server (DRM master) choose the profile instead?
> 
This seems to be very good input, in case of a further conflict in 
decision making, we might

as well add this intelligence in DRM master. Would you mind explaining 
this a bit more on how do you think it should be done ?

- Shashank
