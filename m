Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E229DC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 19:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5740E10E271;
	Tue, 14 Feb 2023 19:24:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB2C10E271
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 19:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpUl8cydWdQKIWZPeUvP9+YYUOMdIKPQr0ON8yUVbASw17eV521XMAnV/ALFqEvAHe+FNlFW99qNh6I7E3ZhxTai9NK3Nmr3udCKFoh5Hy3b4QXBVOdabnlVJZ5yzD254+E96p9u43C7RfxnNJMX+eCN7hv8qw4qabjkklacarayrCDF0yZ4+Pc9/AllemwQM9FeBI8tGR7bbxnQlYC17zCvlmvfn+XDrGluD0ap2R5g/iBuDXX3Mnfy80dmiLzpRlFpwyN0SuOALyHlZZVGN71wasl96G++Qa16B7qWQXax3VGSDWcQFbECBB0kO2L9+FF1peXJsei54xKWpnco2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9TL86rYHuumJi5LFJPN66hywZUKA+KSjrmajvbjPek=;
 b=X435lliZRHjOLTu/mX8O6GKksvuIX//IwSHyoDD91ZRBcju07QEpwEomry3CwKit6ovh+7wGPsB6z931SejBc6TG0ek1eOUCtA0QPiW7vPE1xwOqdn+4sD8HumgRL1HVjkFhls9/J7GHABzSq/xByaKAVECCpWZnA2Nl2wnSRsJTETIcO8FOVVrgAWWUI+6vfqUJRlVEMSjlyStAD8McSSAAaRxUZnoB0fJedt76/ooh5fBUJNWyqGxO7FtuobyMW/XyHWE5zeeqCUV71aD+lYF0+z7CzoCEOTgjNZkJ2kHT8rfYvCmOWUZN99XUX7uc5BAUTQH2JVpe2HOYcefJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9TL86rYHuumJi5LFJPN66hywZUKA+KSjrmajvbjPek=;
 b=BVlm1/iv+eWeALjvrbQRTTYVrhevBzlrwgKT/bB0JE2pB3E3GPsVGri67I8LcutWjKvG/M7j8hWMRMB8ZLVKtw/+WuHz2oSvWXYgGHrHOPXiiMFtSQvaveM4Vql/knvK8kqZXXAcnjPQPMhrDJqSPUkDVxWGz+yTM3d3oEQ57Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 19:24:54 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 19:24:54 +0000
Message-ID: <447afcd9-719a-bf86-64ee-af8e8a7c67dd@amd.com>
Date: Tue, 14 Feb 2023 20:24:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/8] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-6-shashank.sharma@amd.com>
 <7cfbd8c6-7865-2fe3-ac93-d3b264f2b4ab@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <7cfbd8c6-7865-2fe3-ac93-d3b264f2b4ab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f95007-1a48-44f4-6f13-08db0ec1266c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuLp809Lbjc/kf37jpcAs1WzLa+NdBXRhToRHjqVBiH4hMMgGK5WjsZ8CZG+xMpceBOTAlLIfoPyFFeJ0AtIzc2cVVSlZirBU74vzn86//jSnu3MqMAapHuvZUFLNyhV8MBJx5GPMmNJeo9kzDZBTO0Wr335/SspBwcDsnPjmll6DSsxnJ1hviuWIL4PaYkWjI8ZaGhvkRHpIGPkxoVhHg6WJ4+q3Bs/fPpRQ4biuWRQA9Uh5qcG4IKxdgoAyqItE+ywVQjDuKPcT8dm0DwHFvdR4obWm1CxxZfFSjMNr/gOaHgrPPioCv7IQUwy7nOo5Brs+mCTg6VQDdTUG4xaG9RhQD3hpg6VtbYPlZctEXF66VZbgmsg1S840CGQ7SfCyLb5Fo6ASzKTrhalUNGEy2pPF5UKBcA/AcmWowd8I4Nq+ROPpa5R1aw64c3p3j8O3eah6g45PXIDiL51el13Kse1udq6ayzPdzeTaEBbjLuup9rKLeRih99UYQyLk2NjjklTHljkmrnDIUurlTEUytKC6LFD4BeRTelegTnqsGgr2cJe0yGJJwQI5JFZco8tu5+ZsZpJ5iQKnpud6kek67w2V3Cxw1OuJ29iWwfOQeGNtcuHcqQybkjSrgfBYt8BDIZafb2oRNNUyh3KBhuA9T7jZcGwEezLy+RQDfQlsTa9JcAZI4ULS1MvXP5zIEQ/0tC9J1+PHFM51kv4ZJX8/V8wq25COlkX2ZW/eJBbWeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199018)(316002)(31696002)(86362001)(83380400001)(8936002)(38100700002)(66574015)(5660300002)(36756003)(41300700001)(2616005)(44832011)(8676002)(31686004)(6666004)(66946007)(66556008)(6486002)(478600001)(66476007)(6512007)(2906002)(26005)(186003)(53546011)(6506007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDhzdEh0U1AxdWwxeldRc2p4bWJFV3BQaVFFU3JtRFdhMm1rUUo1ZWJ4SEJr?=
 =?utf-8?B?dW5NVXc1RGQrUHZMR3dBd00yVGxmekVUZndISTVkdko5MWhmMlRwMjRJQlhy?=
 =?utf-8?B?TTBHRFBldENYNzJEN3Z6dVhXQldyVll5b2tybkRXdEY2QmFOTTYrd0xmOHlV?=
 =?utf-8?B?aUpNZGhiUjdMVlNiRzhyMnlab3BhWmh3NUdOM2JKcHQ5R1BKOXlSeUJUbDJK?=
 =?utf-8?B?Z2w3ZFlzem95SStIempEb0NqYjQwVkMxdm1PcjlZaU9scU5Tc0xNQTRRL1F5?=
 =?utf-8?B?Y2ZubDVKbFdScUF6cVlvaUJUWW52dGorTWZNdWdXRlp3QlYrYUJIUnEwSkVx?=
 =?utf-8?B?U2Z0K05ISkJFakowY0xFcURNblE2UmUyVjhTcDdxS2RKU2JaNlJhNXdnclNt?=
 =?utf-8?B?OXZVS0poYlV0Q1MzVkx2SUN1S3Q1aFZpdnJVc1lqRzZ2d3k0OEIwQ1BxRTJm?=
 =?utf-8?B?YWJzRGNORHRmNHh1OHZBSSt1K2h1ZGtvNTk4MnBGdXdHaGJwMGx2cDAvelY1?=
 =?utf-8?B?bWZEQ2lISHFiYk12cldXbFYxVTNEcllOMXdZaDJxSmhHNEhVMVI0d2MrMGFE?=
 =?utf-8?B?aUZIcTBwczNod09ueE9Qd29RUUFsYjNLdGllY0tJTUVDKytHMklIQmxnV1hB?=
 =?utf-8?B?VFM3ciszVVpyQWJ6MC8wSlRHU2l0UFF2R1FQMUtwd0tBTm8xMzhjRkQyVDZz?=
 =?utf-8?B?OWpKaExZQWwycUdrRzZ6dXZQcmQ5RjRnL0R2RUYxV2FObkNuZnZjdERJVG5W?=
 =?utf-8?B?UnQxUi9iVnZtbFhRV0VTankyWkd2dWxPY25oZkVzNEt6NkV2S1hwVjIyWTR6?=
 =?utf-8?B?TTkwMFVTUWFWaFJNTER3KzZVRHkvS0RHcC9lYlFocEgyN3B3OVFjalZVZElp?=
 =?utf-8?B?bk5ibWtZcUdLVHhCeTY5eWtZTFZtVjFIL2FjREI0RlZTUUVvRDBSZGkyU1B0?=
 =?utf-8?B?UDRYT2J3c09Wb3FreTAxVzNDSnlzMkluSnBleUYvN3M5cVNSa1l1TEhsam5X?=
 =?utf-8?B?MnRtdk4zejB4K2FCRkZBMlR0c2p2bFR4UTY0WWZQSVJZeDdiM3VaTUNTU0h1?=
 =?utf-8?B?WlQya09wK1R2cng3RlRhaWlqSGR4Y2xUYUQwa1pMeitMMCtWckJnanQ2UWRh?=
 =?utf-8?B?NUV0TUZmUTNxZjl3eHZ4SDhHSHR1R3B5RGFqNVUzMk4yTE95YVN6UG1neGcy?=
 =?utf-8?B?YnVwMitPeGh6SjQzVWQzZm9LOXdvcm1yRFkxNGh4YWxPK043L0NTQlZHSmdk?=
 =?utf-8?B?Y3YyZE13YVh5OTVMd1pRQjdJeVhCV1ZBOWdJNTAzWHl4L1U0S0NxYlZSM2pK?=
 =?utf-8?B?U0d5NGZpR3g0VUxNZUYvaHNCeWkxNWJ4QmNLZXFpdGZIQ05aQ3habzVaZVZP?=
 =?utf-8?B?OFhYYVNZV0lmV0pzZDV6UDlZVDZhQUNqaWM5SG90Ty9wbE5ja1VLdk1WL2tR?=
 =?utf-8?B?bjQxRFl4TExmM1FnZjZtS3hBcmFJVzV5OWQ5NGxOSThvN2cwWTFMZGFWWjd4?=
 =?utf-8?B?bzdkYVB5bHgxdndBMFVpK21MK09hWXJOaG5Kc1pOYjJHZnRqb0RqUE5kek11?=
 =?utf-8?B?b2hHTTJ0SFF2N2pOMzdabTI3Nnl4SnBSS2dGZDl5bm9XU2I1cXRpN1lFVkVJ?=
 =?utf-8?B?VWZQWWQyYWVkejJRVGlBeFBFK2lxUzEvam5WZ2Q5L0UvK3dPTmxETDQya0RS?=
 =?utf-8?B?ZUdoK0ljQkVBOUpFNmx6OFJCS3FNRDRkVG4xajJ4aFF2d1g1Y2IzT2dyeTBO?=
 =?utf-8?B?eXVUcVZSMVNjRXczeEc3MnA5T2JzcHZxdnFRTk8ydG5TdytsMDZYUnJLb2Rl?=
 =?utf-8?B?dVZRenBLZjVsYURqcWc3SkZncDRKbElwbklJekpnNXM3VU5qcDhINXQ2R1hr?=
 =?utf-8?B?L0U5Y0FSTWpPQnFXaDc4QnNqSlR5UEVBcEp6MWJBc3JsdWhqRkZXSVdzQXJW?=
 =?utf-8?B?bVh6UWNHV0w5NGNrRFA0TjR5U1hMZGtycVZlU1lPKy9QYlllaGlXdUdkdFVZ?=
 =?utf-8?B?MGRNZ01CanJxcFZDUzVDY2tjWUN0bk9VK3lQYVNRd0lIY1Fpd1JSUHZKeG5Q?=
 =?utf-8?B?eGRMNm5RZmNYazRBQmJHeTBBbjVwcnJHU1RvNEVFUnBXcFM1SWh5OHE1NFF4?=
 =?utf-8?Q?TjB638axwPaHFQYTUfA7T8ST7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f95007-1a48-44f4-6f13-08db0ec1266c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:24:54.0268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae2mnnZus30hKrJxjSzromlhi1KEWS6SIXM/4gtTQk9ZjEaqEIWv0WH24c8oTOPqhHMICTxhbvfcPumBHLg+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/02/2023 19:31, Christian König wrote:
> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch adds changes:
>> - to accommodate the new GEM domain DOORBELL
>> - to accommodate the new TTM PL DOORBELL
>>
>> to manage doorbell allocations as GEM Objects.
>>
>> V2: Addressed reviwe comments from Christian
>>      - drop the doorbell changes for pinning/unpinning
>>      - drop the doorbell changes for dma-buf map
>>      - drop the doorbell changes for sgt
>>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 ++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
>>   3 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index b48c9fd60c43..ff9979fecfd2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct 
>> amdgpu_bo *abo, u32 domain)
>>           c++;
>>       }
>>   +    if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>> +        places[c].fpfn = 0;
>> +        places[c].lpfn = 0;
>> +        places[c].mem_type = AMDGPU_PL_DOORBELL;
>> +        places[c].flags = 0;
>> +        c++;
>> +    }
>> +
>
> Mhm, do we need to increase AMDGPU_BO_MAX_PLACEMENTS?
>
> I think the answer is *no* since mixing DOORBELL with CPU, GTT or VRAM 
> placement doesn't make sense, but do we enforce that somewhere?
I am not sure why do we need that ?
>
>>       if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>           places[c].fpfn = 0;
>>           places[c].lpfn = 0;
>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct 
>> amdgpu_device *adev,
>>           goto fail;
>>       }
>>   -    /* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>> +    /* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  
>> AMDGPU_GEM_DOMAIN_DOORBELL */
>
> Should we enforce that user space can only allocate 1 page doorbells?
>
Should we add a per-PID basis check ?

- Shashank

>>       return true;
>>     fail:
>> @@ -1014,6 +1022,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>       } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>       }
>> +
>
> Unrelated change.

Noted

- Shashank

>
> Regards,
> Christian.
>
>>   }
>>     static const char *amdgpu_vram_names[] = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 0e8f580769ab..e9dc24191fc8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct 
>> ttm_buffer_object *bo,
>>       case AMDGPU_PL_GDS:
>>       case AMDGPU_PL_GWS:
>>       case AMDGPU_PL_OA:
>> +    case AMDGPU_PL_DOORBELL:
>>           placement->num_placement = 0;
>>           placement->num_busy_placement = 0;
>>           return;
>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>       if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>           old_mem->mem_type == AMDGPU_PL_GWS ||
>>           old_mem->mem_type == AMDGPU_PL_OA ||
>> +        old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>           new_mem->mem_type == AMDGPU_PL_GDS ||
>>           new_mem->mem_type == AMDGPU_PL_GWS ||
>> -        new_mem->mem_type == AMDGPU_PL_OA) {
>> +        new_mem->mem_type == AMDGPU_PL_OA ||
>> +        new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>           /* Nothing to save here */
>>           ttm_bo_move_null(bo, new_mem);
>>           goto out;
>> @@ -586,6 +589,11 @@ static int amdgpu_ttm_io_mem_reserve(struct 
>> ttm_device *bdev,
>>           mem->bus.offset += adev->gmc.vram_aper_base;
>>           mem->bus.is_iomem = true;
>>           break;
>> +    case AMDGPU_PL_DOORBELL:
>> +        mem->bus.offset = mem->start << PAGE_SHIFT;
>> +        mem->bus.offset += adev->doorbell.doorbell_aper_base;
>> +        mem->bus.is_iomem = true;
>> +        break;
>>       default:
>>           return -EINVAL;
>>       }
>> @@ -1267,6 +1275,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt 
>> *ttm, struct ttm_resource *mem)
>>           flags |= AMDGPU_PTE_VALID;
>>         if (mem && (mem->mem_type == TTM_PL_TT ||
>> +            mem->mem_type == AMDGPU_PL_DOORBELL ||
>>               mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>           flags |= AMDGPU_PTE_SYSTEM;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 967b265dbfa1..9cf5d8419965 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -33,6 +33,7 @@
>>   #define AMDGPU_PL_GWS        (TTM_PL_PRIV + 1)
>>   #define AMDGPU_PL_OA        (TTM_PL_PRIV + 2)
>>   #define AMDGPU_PL_PREEMPT    (TTM_PL_PRIV + 3)
>> +#define AMDGPU_PL_DOORBELL    (TTM_PL_PRIV + 4)
>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE    512
>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS    2
>
