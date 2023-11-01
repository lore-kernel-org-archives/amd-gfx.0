Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C41C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 19:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF6A10E062;
	Wed,  1 Nov 2023 19:13:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EC010E062
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 19:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs7jSJXY6lIeqaSLU3UrIw4OmVosE4NmbHmVuq2YUnVtjP5fj4mOR2MRqqGrrvkQj1n7Qlp9DyZkBFygNhk8Wv/pelFmCEHgdmZzriT/si8zZHESwi7h+0vlhofgkeJymyx62aWCLWVulJUBfHq9Fz1RTA5EA4Lkpf7Qj/hOVPM6Y6ggoSP12iq1rgelD59FwwGi0uI1BOE8uKTL81RBKAm2wlsN/p/upbEMOEHOJ966s8FB7pIsNhAtQRnPWMO2KjdMJJ5NZSXMI8d4KwQ9Yp14eWMv5nP4Eypehd/nuxZb6vAIQN6iFPPTdAirEzlTDy/2Ljx8J+CScTz4JXZNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7Ybj5Movu3xRqOgzySTgwd0U38qq62E9lcx+MAQzSA=;
 b=mxcvB26LNmcz+ebN63xLY8sOIuFnbSYjoineD9nmU/i7v0FIm3gYk5zBH7VhcFF2hIy1ORcSQwT7ASD7icr0BHQLvJe+t6cXfko1YwA7qW4t4A6cwP3wtnxYbYVbSPDuM6ZyxmY3+iF18+6DBwNvH86uS/mGXQFuQH00nQTbhBNyhdfg37p/KJtK/z5RVqbOdq6d6x6ckgQJ2LRbKSFa8B2T40bvjn5ywxQN2fpJJTA9oy4eW7Z718FZfD13GAT7tDWa3ocQ5Dg9PSGMoyMGwFFbmnXOggDgvf+jq2At/8Y/CbmzH6k1ZX/j7r8p7kOOjL7urqnELW/8Iii+/9xIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7Ybj5Movu3xRqOgzySTgwd0U38qq62E9lcx+MAQzSA=;
 b=TZ8nBXILRJwPvapW/IhWcyJvP956v+zaXy7t+D2wrCHrEck5GR/ANYRZg8gryLjRfLZF1xlIsrnOnZZ3PIQnaNYpWvdrbIZ4ljhMzKHM+qLfX22qWXTS67i8TbCxfDmQ6YelTvdUS2cNwVya5zTLeRuGQc69daWV2bb7BDRh0SQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Wed, 1 Nov
 2023 19:13:44 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::c1f1:4f:7e5b:5523]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::c1f1:4f:7e5b:5523%7]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 19:13:44 +0000
Message-ID: <838a8374-5499-478e-3439-3000b32bc7e4@amd.com>
Date: Thu, 2 Nov 2023 00:43:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Fix the vram base start address
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231030122205.24805-1-Arunpravin.PaneerSelvam@amd.com>
 <f691b236-e5da-4f4e-aaf1-bd74f2f9db56@gmail.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <f691b236-e5da-4f4e-aaf1-bd74f2f9db56@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: c40ed6df-a82f-4b45-f179-08dbdb0eaa55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGYhhtqmiQgM4xvGYt5DqJieYr5HnGbLfGSXQ9RUzoNrBh4hoiHg2Gx0BrBZWabeISspeuOGEvb0WbqE8UdwsQi0ot7xPj+pODjIUbkbbWCLVvwQnalZUlug9Cl49aopKGh6BsCL4FrAa17ooDw2ZR6rHRFbRPqW0s6++RTREOxhvzGpBm6X0ZOEal3OWz6/bzhEXer2kpjdQyGLoH5ltwVZmPTf7/rGZqlTjGDOn4bl7urpWC4nxeFCHQXEv9m+4Kfrcd8XXA4mHu0Rhl5FK70lGvmArwRzb93kGIVcXPZjYIws1ZfRjlSkO9B/Kc/IVfRIibGH+x8AajtZ1tBCZP2O7kTNDPZcS1aah/2XXnkAyBzMUodW2SIvR4wg2RqISBDeqSNmKbJ5IviefHZUFfVgixyyZ+np+xljAideZfG/Q0nAOZpLey9M7+zuaNNXzgV6M7wxc4WJPJ+V7U0NuOQ/rYz/0my+rgHusIAAdPQHpd34U4niteQA2P0qTeINsJRDoNVHte0xmpfIqjbwXEUvAls/90zTvBUBCXJQaKETH6pwT9iM5r/7iyQ01QQz7W6jBOnIm7un0uoHvkip0F0TrqOWnA/2nl9/+M2Xy2khyZnplnrBt5kK5pyejdSj+GJWRU5ZGzfJKpHszYbpJySbT0XqQSRIIyHrenwje0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(4326008)(66476007)(66556008)(66946007)(316002)(8936002)(31686004)(966005)(6666004)(2906002)(478600001)(6512007)(6506007)(6486002)(31696002)(86362001)(36756003)(53546011)(2616005)(41300700001)(26005)(66574015)(5660300002)(83380400001)(8676002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDBVWHl6MTZUMkRyTEZWcFg2RSs0cStFY0JlRW5YL3EvVzZ0bW1RQlJhaG5Q?=
 =?utf-8?B?dmYvbEVkcXJJNXpLd0x5bkNvYUMvZjloRVNydGJvalZ2a3pZMXZlRUk3V1Vs?=
 =?utf-8?B?MnhUdHh1R1U4VEZvVE15bHR5OWJEdWcvMzkvUmYxeWVyTlBzVVJ2R2V0aVRy?=
 =?utf-8?B?MTdjUlpsejd6L1doN2RSNCtmTmhRTmlkSGVkbThKWkdDRjFoMXhVaFFIOHo1?=
 =?utf-8?B?ZVRnSjIwN3lEM0VBYWVDMGZWRXhEekZQdXBidVNEQnlJcmZGNVZSaDNWRFJC?=
 =?utf-8?B?UmVwUkZmSnNWR3hVR3dnbFY0bkI3c3lYTVpYOS91bXN1a2l2cmpXZHNzR2F5?=
 =?utf-8?B?cVFHMkp5NHg4dzF4ck5VbzFmNEVCTzR5OERVNngvU1MyVThqSHp5R3NUbnhl?=
 =?utf-8?B?LzlpYnZuR2lDVVZEQitIVDM5Nk5EYXBSNlhpclg5ZTdwSDFrSHduSWJ6cE1F?=
 =?utf-8?B?L2dFOUh0QmQ4MTJQMnM0elpwUUpiS0NTemlGV3JjcXpYVHg5N0o3SWxuL3Az?=
 =?utf-8?B?bnpzaXV1YTlrd25CNTBBMEh0S0dvdGtrSmdWK0p3UzIvQk84dHRDVnNTeGtV?=
 =?utf-8?B?Z2lPekwvR3NsWEVpdlJkOHdzZGZtMGJ0YVN6SjY0bHFMQm5lR0c3ZE5CMmtD?=
 =?utf-8?B?R0FDVUJKYzF4THFrNG1SaXJOUnBSMElXMGh1dFlqSUpBTzBheXBpR2ZrZEF4?=
 =?utf-8?B?cm5zRzNOL0tYbFBqMzUrRndRM3FGQ1J5ekgzWjduaURkcEVGRkt5WEp1ZUVC?=
 =?utf-8?B?R3lmTDhOdnZsMGs3U1B5dE1zSWkrVlpvSFozWnliQWsxMm4zcVN0LzQzQU9T?=
 =?utf-8?B?V1RtRjA2bnduV3RTUDJnOTJTUjJUUjd1SkFVc0h2WTBLcmVTZkxBLytJKzlT?=
 =?utf-8?B?WmllazZBdVNYNTBxU0pYa1NKL2oyaVNFZ2dFN2hKMFpMSC8yK2h6NFdkL240?=
 =?utf-8?B?OXRDQTFrcU9tYThLdFd3KzJLaFM1RTN2THBBNE9ycmluWEhHVHNEc1lPWGVt?=
 =?utf-8?B?cGJuVnVwclpsT3I2K0I1VlcxNTFtdzA3ZlpBOGNwM09OZVZlb2JyV0dBMFRu?=
 =?utf-8?B?c0NwWjQzU3lhbzdmOGZrR2VSeWdWTVhvMmhtc1dmNituaGVzRUYvUE0rTVVQ?=
 =?utf-8?B?S3dQYUlLU1ZLRDVmL1NrcE5EM1BoVkZZRjU2TEdCSDFLSUdNV3VzQnVzUGZr?=
 =?utf-8?B?TmFFV3QwRllyV201K0F0MG5STlptY05LL0JXd0l3SE0vVlFvSS8wMVdldnJv?=
 =?utf-8?B?VFlEOWNaQ1JlaTR1UERvWnhnSTlrdGgxUWxWSXJSS2VXWmhpODV2NnUwV2l5?=
 =?utf-8?B?SURVUUY5cmpCSTJhd3FSWU1iM0ZhZ1ZmV0J4OW9rL0Qya0xDL0ltNlY2M0Zw?=
 =?utf-8?B?bTVBTWtVOURXS0QwcHMrZVJlTXUvZTg5ekV1RjA4S3dCU3FaUTZZRUNremZr?=
 =?utf-8?B?bENqL3VpaXhHcksrYWRwQittZUdnYmwwVU5WcnpyWjhPRVg3R2ZaRGdnTXht?=
 =?utf-8?B?M0w0aGc1RENkWTdTTDRua1VVYlIyaUpQczA1Yk04WUdJTEZUQWEzZkVNUVdj?=
 =?utf-8?B?ZkJFbzcydnhyakhFeUQwVTNESjhkN0h4SUYwZFZpSnJYQ3kzdWFJTUlPMHFT?=
 =?utf-8?B?NVVWSk9mdlhrSjArdHBIVDlQQm1pL2ZpUkhzUDA2ZWlHR2VZUVdSdi9DQkJC?=
 =?utf-8?B?WFFMQTZsOXhsUG45aklMWUhUaWJ4Z0pHNjhlZjRVeEFtb1oyWUE1anhYakV4?=
 =?utf-8?B?ZHU0NkF2S2dzNmkvbTNDMHJqWU1pVzNnQ3hDdjVTVXFTdEtLVEVYSEVBWnNX?=
 =?utf-8?B?TXU5ckljV0wybTNWM2xGVnhXbk9ZVjBkemF4L2M0YzlIRW5tVlM5YzBOMlZV?=
 =?utf-8?B?QVM2Y0NOS1hQbUc5bmU1enNIOWZab1lzc2t0dnZ6YnlCb0ozZFdyTWJDQSt3?=
 =?utf-8?B?WDVMY0VXd3BhQUdDN0l4NGh0WVRwZ29NeFNTU1hJSnprZzBUVlR2eStWa0Nl?=
 =?utf-8?B?VTRmUW41ZWNVRVNhVHVpV2lHYkcxeE11eFNxVUc2a0hyOWd2b2Q0MUUzTENB?=
 =?utf-8?B?VVJQVTdqTU5LTTFlRXhiUWI0aGN5a21YR0FEVmdxS3ZJZlI3QjBFWFRTK2Vq?=
 =?utf-8?Q?xlvRs76yrIlNTulTt1eioOD8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40ed6df-a82f-4b45-f179-08dbdb0eaa55
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 19:13:44.0447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJmVkF+SVEjIRAvSy+SdsGTDJug9prxzKV/lpM5WHO9gVr6rmjc8VPfId0jGjJEAdOJbYeC/yeWR4WiwOPj5Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

On 10/30/2023 9:34 PM, Christian König wrote:
>
>
> Am 30.10.23 um 13:22 schrieb Arunpravin Paneer Selvam:
>> If the size returned by drm buddy allocator is higher than
>> the required size, we take the higher size to calculate
>> the buffer start address. This is required if we couldn't
>> trim the buffer to the requested size. This will fix the
>> display corruption issue on APU's which has limited VRAM
>> size.
>>
>> gitlab issue link: https://gitlab.freedesktop.org/drm/amd/-/issues/2859
>> JIRA ticket link: https://ontrack-internal.amd.com/browse/SWDEV-425461
>>
>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Acked-by: Christian König <christian.koenig@amd.com>
>
> IIRC that hack with the start address is actually not needed any more, 
> but we need to double check this.
okay, can we just remove this hack and keep the vres->base.start value 
as the start address of the first block from the
allocated list.

Thanks,
Arun
>
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 18f58efc9dc7..08916538a615 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -77,7 +77,16 @@ static inline bool 
>> amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
>>       return true;
>>   }
>>   +static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
>> +{
>> +    struct drm_buddy_block *block;
>> +    u64 size = 0;
>>   +    list_for_each_entry(block, head, link)
>> +        size += amdgpu_vram_mgr_block_size(block);
>> +
>> +    return size;
>> +}
>>     /**
>>    * DOC: mem_info_vram_total
>> @@ -516,6 +525,8 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       mutex_unlock(&mgr->lock);
>>         vres->base.start = 0;
>> +    size = max_t(u64, amdgpu_vram_mgr_blocks_size(&vres->blocks),
>> +             vres->base.size);
>>       list_for_each_entry(block, &vres->blocks, link) {
>>           unsigned long start;
>>   @@ -523,8 +534,8 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>               amdgpu_vram_mgr_block_size(block);
>>           start >>= PAGE_SHIFT;
>>   -        if (start > PFN_UP(vres->base.size))
>> -            start -= PFN_UP(vres->base.size);
>> +        if (start > PFN_UP(size))
>> +            start -= PFN_UP(size);
>>           else
>>               start = 0;
>>           vres->base.start = max(vres->base.start, start);
>

