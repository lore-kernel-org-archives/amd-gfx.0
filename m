Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3A9C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624AC10E123;
	Tue, 10 Jan 2023 16:53:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638E410E607
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0t9pGtWTJUJJLz46ezb6Rk6TPYBw1+EfWMKkelN8MsLCNa51ski1QoD/953rkvtKd8Jlz7P9ZZmCaKeXZBxotO3EvY/Z+6fCZv9ZiUlu4CyUDhCzrt5ErqecpM+hEXuExkVF6ePMG3Wrd+x17fLT9LxvcI46rMXloB1v3rmlhwUO7aZP1O81z3+tT/m7cAgWmWktLZqWe4na+4SF4bgSy+QfjzLbtSpt9OqxA4zNirHYtdCNR9GzApct9ntxWGfbvIm4oYYV2Y4Jw1G9RS01hvn7qK99P6jXaUcDEdjGUnTkqkZILhHiPz3EgIU/5laZ1B+yzVYDN1qlMlBYMCnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWdtF03WKr8Kv0sq/Qwxgkh9CgMKR9gm6PkcURIUahE=;
 b=dzgKumAwswbap7+IMgq/JxH5e4Vi7iGaELAwTm9u9j4MekD/BgekhXqYlKqbuSqoTp1f6mxvHr4tg+DxkENlqH8c+jHI1zSy2fBiohh05ujwLc1+3NYKP8qlZyxT12ptMEKZCEKEzSRDNx1qNhxyAeGLq3A/bgBmxkjmjFgH1kcoic9kj9did00E8IpccHcfm6j03LEt6Mv5CpWaYiIMyDdPHGTuGtSohLOzIo7S8r65Su8a0xOaOz8O+vVFFACs89yelNMOwy6U2iNUK8eDZQ5cHkDrHfSNMPav0zUCBSqQ0k+dDMc7b2c5ti3IBXYvk7NFUAXSyIgHGWq6IphE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWdtF03WKr8Kv0sq/Qwxgkh9CgMKR9gm6PkcURIUahE=;
 b=4gkbJ3z2WSpg/j5mf0ta+OsD4FHDJL/HSlvbC9R7IvS81HORkOciV0w+Fn/M2lUFAIK4PtzTCCZNQLZJ/iIH4mNKfGA+k26ucG+BDBryATtOlyEeeKg5QD1czxYSldEVPjLq7YsxB3NsZgqLpF/2SlT5wUrld5Sk2HnCDt/UMgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:52:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1%9]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 16:52:58 +0000
Message-ID: <98bca993-ca3e-217a-8965-93d67eb41b55@amd.com>
Date: Tue, 10 Jan 2023 11:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Page aligned VRAM reserve size
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230110000112.29730-1-Philip.Yang@amd.com>
 <05f0daea-2e7c-78b2-29f8-7b7301b8df84@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <05f0daea-2e7c-78b2-29f8-7b7301b8df84@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::41) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: a61496e9-6fb9-4f7e-3200-08daf32b207e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZirMySvhFGXUuahMJwhcByOq9Rj+KyauTWw7et2SfoWl+u/ED2R/E5f3Zc6mG7gdSbf8hzGrB6PSyTBlrDs5P0vteIOTypts4NUeBtg6M6zpY9owaZGlyMUSlzzOvsr58R1H8nfimkaEAc7/0S+AZiu/2l3DybVLVN5NV8NrkZ0sF7Lpj/KgYc5u76nCY3NJIZBbFWRRY70UWG+fNYMUA0BnGvu0ZGdaV7FUc23fC+BTe5Uau1tKLoQYaHiM5P8FUUeSNgTcciHWsJHKg674la3VV8NygnaQcl02r4MjQr/2O+q4iO8POZt2hDLa/420qwNHm/eVAUv+EkJOkU/xEAnXbdbssEH4I4GtiULAoI6Zrpx2xyCdozi/Aw0Fem+xyFkSU7emrAGWAhfHWI04qnXjRdEV1b5VXQcSQ9nf1ExVaIEDC3CtI0Bjro5ZZ9oq7Yd1nA3g5BEEPvOAms9FW0zr4ALXWCzI4zxhVrb14QLCGRujILuVGlAPk+TaFPRqtVLdM9OSu917j3Wzx2COiNi0F7Jw/4EfvHibI+Dt3bYmyoHK9b0VPdE1tZQ+r5BQEUBCsB6xmAWWQAuUMMULz1EumB+xDM4I5HqJcqkujNIloWfKxiq/gOOav7WhCHJ5lf3lDEwLr2SimonYOK4MYjqYTfoKkSaM13LSlV9BfeWwoHmNgTdqFpCw/dNFrffDTIWCylE/JpogskmOPa0TkFYDJNkYnQAFhOWTV67mhrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(38100700002)(83380400001)(41300700001)(66946007)(8676002)(31696002)(66476007)(66556008)(110136005)(8936002)(2906002)(5660300002)(316002)(6512007)(2616005)(186003)(6506007)(26005)(53546011)(478600001)(6486002)(6666004)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0svd2J3MFJhWWtBTE9wK3luV2dVYnZ5MUlwQ0w4cDdrbGY0WW01L0dFTDNR?=
 =?utf-8?B?QnlJRHo2a29Cdmxqd0dIS3NOcnE5ajc1VjUyVk9XeHZIaC85bHVEYit4cEt4?=
 =?utf-8?B?aWg0eUpMU1NsVy9vdEJuUDhBNm1MWG1NeUQ2bEpmaWhmcG0xNVNHN0JmZk5U?=
 =?utf-8?B?RnFRMThPWVlQUjRWdjVJNURVQ2JkQUg0Q0VvQy8xQWNFbGV5TWhlMVdWNlJQ?=
 =?utf-8?B?V0FOTUN1Q0VTYzJldDZpeUNxdklERCtIWjc5Zk5QTkZmZVpqK2xTVW9Pam1t?=
 =?utf-8?B?aTV4RnVzYkFhL01vRE9NTWtCckVsWm5oR0pLUW44cUZ5b0licWM3b2lxNlh4?=
 =?utf-8?B?WHI5R0I5UUNzYU5acHoxY3RZV3ViNzdoaU95NUg2dENIMDhySGNpUWFNeWpo?=
 =?utf-8?B?Ui9Kak0xTXRHOUxxVGFxbjhFUldOWjZHZEIwa0Z0WGZ5MGNzRDN0TmVzaG0z?=
 =?utf-8?B?dzk2UnQvamt2b2x0MVBjYXZrSUljbTVqaUprcC9TU2pPYmJWN3c1bnpaT3N5?=
 =?utf-8?B?dGVGV25nTHQvRWI5VTc0UXhza2J5NlJZSlFEQzNoMW9xemEyU2lrMWNFank0?=
 =?utf-8?B?S0FYdEt3UTBSVURyeVRJSVhCK09Yanp4M0twem1QcURNYzUyeUdsbjdoci8r?=
 =?utf-8?B?U3p0R3FIY1dpN2lDQ2J1Z0oyMWVRTVlPdldpdXNGWHgrUUhFQTJiaUZxRG1S?=
 =?utf-8?B?MlR4aWFVUWdDODFvcTlEUTJ6bHpwcnVsMUdBdGs1SDREcWhZOVNPSHNXRnJJ?=
 =?utf-8?B?OE81bW1DNWFVZGRLUmJqVVFiQ09VVzlVbHBUWlpCb1ppRWREMFA0RDRYRzlM?=
 =?utf-8?B?WUNsMEN2THpPa1ljTGNiOFlUNFl5UjI0OGlLYmJWYTFCUFVZVHFJU1VtUTNo?=
 =?utf-8?B?bjROWGE4Rk11NHI5SmNOTjJUTnJVaVdQYmNJcUE1eDFZKzdrWk5FYXN3cUxv?=
 =?utf-8?B?VWFlV0dNYmJwaHpwdE1QcXgra0dFYThUdll4TWd6c0pBbEp0RU1wdjlTQTY4?=
 =?utf-8?B?cjFna1FScldtbXYrQ2hma2ZkM3NvZnBwVGtremxUVDcwU3Z5aXlrbkhaYVo4?=
 =?utf-8?B?dmJDRFh0NTNtRmRzcEdhUlNNdEpONnZtNEYwYms3dk50alIyNlphNWJUTHAw?=
 =?utf-8?B?UkU5MlB2VE9qNTlkQVJlMnJSMit3SEttU0dqL0J6cml2TjFZNzdDVzNjN0l6?=
 =?utf-8?B?M2lhYXN6MmE3OUk4SVB0OHJlVzRWYUw2WVdaUEdkOEdiMDBzaWh3NHNzZ2Fr?=
 =?utf-8?B?OEhjZDJNcklaTHFQNm5LNWk3U09ZV3NNd2RCZzNWRjJkU05IRWYzd2EwTG45?=
 =?utf-8?B?c0RKaStSd3pyY2NaRjN5WWdDdkRybHczWVFqSzhVQlJGcnpTdTd6bkc2b29T?=
 =?utf-8?B?bTg2S255YTM2U2hMeEE2eWxFcW1HeEI5ZDdwSkUyR0lqR0N1NlQwYXdNQ0s3?=
 =?utf-8?B?VjhuY0JpTThPdnhHeEhiNGlocktPVzd2NXBENzRnVm1VNnlKQjVJcmM4cHRP?=
 =?utf-8?B?OWtQRHBxdFJPa3dwMThWQTl3QndNUHB3d0lXeTk3dkU4QzRRVnhuZHFhY3Vl?=
 =?utf-8?B?WFhzcXlxaDhGS0NmN3dkeVYvdzZXMDJaU2VWeXNKcVE4d1Z4VEdTNGhrVmVv?=
 =?utf-8?B?RVdYUlpyNlVSRk40SDJobGc2czFCcTJOeXJMWGQ1ZUpIU0RQTHUxWGF0M29h?=
 =?utf-8?B?UjBXNDRTZHdEb3UxRndBUFlmY0RrRU1YMnVKUENrZ20yMkxqdm11SDA3S0dz?=
 =?utf-8?B?MUU1SWxoVVljL0NlV1huanR5UkxkQzd3WHQxUXlQTHdKZlRBNGZ6OE5EQlBL?=
 =?utf-8?B?ekNaYTVSSXN5ak1XWUdJQ3dHK0JMdzBGWUh4ckJIQWcyYzhvTG1GSkJGWGlI?=
 =?utf-8?B?VnFiWG1JNXRyTkhyZUlNeEg2Q3JMZDZJUUxObW5Xc0phVk56aC9HQmpTWllR?=
 =?utf-8?B?S0tKa2hRYTJjZE1SZ29Gcm1pcStYK0UxSU94U1MvUVVLUmtpaEZlL1ptV2wv?=
 =?utf-8?B?NjE3Z0Y1R3RxT2UvVGpYV2xHSHkyQzZSRGNwSE9UdEhHUmpRNm5Xb1NvTTlL?=
 =?utf-8?B?TzBwTGp2UFE2MGpiSkJzYXBBSXVQL280WnNlQjZRb2IvNEVSbjR5SUR3ZmRO?=
 =?utf-8?Q?jdSU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61496e9-6fb9-4f7e-3200-08daf32b207e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:52:58.1568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6Md9a3lTMag66stmrpiMSSXzLoHJbLfZy+yIN74gCezA9IB0V3URr/9GFBg3yK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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


On 2023-01-09 22:14, Felix Kuehling wrote:
> Am 2023-01-09 um 19:01 schrieb Philip Yang:
>> Use page aligned size to reserve VRAM usage because page aligned TTM BO
>> size is used to unreserve VRAM usage, otherwise this cause vram_used
>> accounting unbalanced.
>>
>> Change vram_used definition type to int64_t to be able to trigger
>> WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
>> accouting issue with warning and backtrace.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index fb41869e357a..333780491867 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
>>     struct amdgpu_kfd_dev {
>>       struct kfd_dev *dev;
>> -    uint64_t vram_used;
>> +    int64_t vram_used;
>>       uint64_t vram_used_aligned;
>>       bool init_complete;
>>       struct work_struct reset_work;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 2a118669d0e3..f23d94e57762 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -151,7 +151,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct 
>> amdgpu_device *adev,
>>            * to avoid fragmentation caused by 4K allocations in the tail
>>            * 2M BO chunk.
>>            */
>> -        vram_needed = size;
>> +        vram_needed = PAGE_ALIGN(size);
>
> This only solves part of the problem. size is used in other places in 
> this function that should all use the page-aligned size. I think we 
> should do the page-alignment at a much higher level, in 
> kfd_ioctl_alloc_memory_of_gpu. That way all the kernel code can safely 
> assume that buffer sizes are page aligned, and we avoid future surprises.

yes, the error handling unreserve should use aligned_size too, and size 
is also used as number of pages in amdgpu_bo_create for DOMAIN_GWS etc, 
we can not pass aligned size at higher level, I will send v2 patch for 
review.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>>       } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>           system_mem_needed = size;
>>       } else if (!(alloc_flag &
