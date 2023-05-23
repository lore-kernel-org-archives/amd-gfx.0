Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61612C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 18:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C296A10E49B;
	Tue, 23 May 2023 18:56:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5859C10E49B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 18:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m56ywxpkBBy+r8MyqqKZI03gchdnmZBvya0Ec5/WeQGourL+MGkYPeYyhnjcjt/Z6zaxYMfkkwJKgoUJ3qqewCRRXqvbLAUzjIdAU2vUejfjdA93E7mocwcCBKsOfOeUaV/STQDGd7PLPZ3uaCrdQnVgOvSO7hh69Lnwxv+XUl/ZKNTXyd0Bq81zfVl06cpF1YoAw8hpSse+fhwqvKzOd3e1IB8ha/ByEaQIaUgCbsTFK++fCj/mSwYHSW/R3Su9BuLu1RObfPmO1PEgHscvc+Y3QUOC3P9xYQuQTbZ2uRkAIp/nhRXVLu2ouJrlXJVF4bwEFG2a/zWApF4P3rosww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXY7PTLacBXZcNoMfAOfwnqGl1W8zGFsNFQs3W5k6/k=;
 b=mbsbFheQp9dVARCqtaQdTvMLzXGMyMn7pvNBsaE7FxWks2qoGIxubqksUZNunQCZGpcBxsADr9gYXGE7WjXV1o2/mrzBaFZ3EyYjIf2w+yDg/GJqyTSP0SHj2W9s8i9bXoX+4Qjs/yT31+kBFd7yZl+gUw+WP3VcJKc8Y8luXm8ZJu57/Yo6ZCI9awqQ4xuZPyR4Kz/I9pVgnnwCfPn5YxPHL1d7QvAaRJ1+XKboHoCH3R98oQhFedW7gTrh/WZP3hg0yRseDf0zE5pLfuAoW6rk6OChU8tcyLZQuHRfqfQQzr1ZX0uEnSqZAwoSDGvobKd26rJs/wVx739z9M6iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXY7PTLacBXZcNoMfAOfwnqGl1W8zGFsNFQs3W5k6/k=;
 b=kwMq2AS46N9QhwGdDRvSIBRrVgRHVLkbjSNwxKvX0XODUpzqF4W1lYkweJZZtVZqhTGAlYV3nlLVQLIhRP5oQLxuiKjkjiEO5HKvcCZyx1F8E4mTsCuZdX6cAvwR+BvMxepQrcj3sg7XgZFMpHURe8m897BF1Acd52xyZKawl+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 18:56:15 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::3233:d932:d356:3773]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::3233:d932:d356:3773%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 18:56:15 +0000
Message-ID: <d8721882-bc6b-53f1-18de-98469a685115@amd.com>
Date: Wed, 24 May 2023 00:26:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating
 VRAM in large bar system"
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
 <f03a448f-1ba3-5d4a-a2a5-baba97b3ec1f@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <f03a448f-1ba3-5d4a-a2a5-baba97b3ec1f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::15) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: ba09332d-a09e-48fb-4d1b-08db5bbf624c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsnanGk60sl0uBu7vq19CRZ9bj05pgaZnghG2srCGz1nr8k9dFW4ZY+EqUqY4rQY62FQtHkdqu3egKs4F6YD2vFHYKuCLF9ecBtwtlb6gmM1XmYIeLVXT/dZKylcv1WT76EZf/B5bp0RTfcO0up/tD/u2miCwDNl93mNkj36whHmscswPQ+cOrq+Ri4bc7sAWWYrTIM042nZcRNFgqou7f+r82bw240NX9MeNksvBWzIwH8NRHBdNSwb8kJI5rrEeydSiXUTjuYa9VGlFN03E5OlvhW6AHuiiJCwpPIvomI8n8dRLhtTkY6pw3FWfS+6tGI/SqQ9eVcLGvdFRgA0qVvxo60w0yd5RrCiveMHBfIwDVObojYvVPY0d+rWIshpDtMG0RGb8x532dSbr04Bl2PLCACXDQiOLADj+aI9TL0YV13YVR2fJN9RT6TVk935b/9z5+sJ+1Tce/7VVcqCyJnrI+Eo7OBF/Dja9avjZLfNBou1S7+GJw1ylzaumq780cW4yCEXBlwAjh0UUT7EYucTFyG30abkdJ2EiNmyotRjDTkoZGDHBa/1uZSoAe5X4/LsKBf11kp1OoMJFNzJSSOu3I2xtGchr+Rbl7wk5vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(26005)(186003)(53546011)(6512007)(6506007)(2616005)(36756003)(83380400001)(2906002)(41300700001)(6486002)(316002)(966005)(6666004)(38100700002)(31686004)(478600001)(31696002)(66556008)(66476007)(66946007)(4326008)(86362001)(8936002)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0d4VHRIek1JU0dpcGdsd3RWVmEwai9hZWpPeEFlOUJQK0oyY3JHVTM5L1Jz?=
 =?utf-8?B?ZTJ6UnI2VFZyRjJkZUVaRWcyM0J5TDBLMnVkWHQxNnk2ZDltZXVYVTFhZkU1?=
 =?utf-8?B?eVJOMTJaSFE1TS9iN29NOHBNQ2dWTGE3MndsOVpvNmxnRlRObzhSRjV0RkNW?=
 =?utf-8?B?ZWVuaFQ0RTg4UjNPTllwVkVkOFVEYnBoRmFYRTFickJBWnA3K3BtamIrQnR2?=
 =?utf-8?B?REhrL2RsaSt1OFRGL0YvaGZaOGpYQzN4Sit2bXJXSjFHZ1FoSy9aYTRoZm92?=
 =?utf-8?B?QlRwYkR1d1p6QjIyREhWRVdOVTBJc25qU1RhRGFVdklRTnN6WFFwZ29pZFVm?=
 =?utf-8?B?OFpjVE9vSlBudkIzQlBOU1dRdnpXS3AwYWgyUFNMMHNHWktmVVhuUGNjVUpl?=
 =?utf-8?B?eTU5L0VUc1lhVkh4NzZTUWd0UTBJYjR4RjJJS0lSYUNQWmJzTjhNTTdSQXJ6?=
 =?utf-8?B?QzYwYWw5aitYTzZ5Z1RMNmgxdzZEbCtQSndqM0g4c0FhN0FtOVpsSHNhdndE?=
 =?utf-8?B?Ym0wL3IzYkllYUZJcWdxbWNPZmdMWSs5TnJzNzFveEhRWVpOTG1nN0ZYenQy?=
 =?utf-8?B?V0I5NURTaUUva29jQVUvclh6cHVDMGgwTnpuWC9zUXFPVVRuKzZFVFgxNUhY?=
 =?utf-8?B?YjUwUnQ1cWFXNnk0V0V0cnI4bHpEanl4dU9vSExHS0lMQU1mTFBydWdHSWxU?=
 =?utf-8?B?ZVhzZXRQcENINWhvblRpbjROR2tDdWJyMURuNjFSNVhDL2loZ2FOdUJSNzhr?=
 =?utf-8?B?TXJGSHU2cHJ3VVI4VHNpZ3o1L3RQV3BHZGZNcWQwK0pkZzJyZlNKdnA2M2Zj?=
 =?utf-8?B?aGd4dDBPVnh0UEs3alR2K3Y2OGFwUFdiWnRGcVArQm14S05sK3lhZTB6WUlT?=
 =?utf-8?B?SDF3K0xTemVJazJPUE9iUCtwem5oZ1d1TW11Q1JUanpSY05scm03Q1E3RTdk?=
 =?utf-8?B?bDVpcFhwZ0pMZ2g0eTM1WVhtRzlCWDBYNXpqV1pnTmYxd2pCL1dXZlNNTjVi?=
 =?utf-8?B?d3Jodk45Z29hTjYydmVtcGN5OTMzN0VGQ2xaQjJQeTNKaXRoT0l3TjJIbnhh?=
 =?utf-8?B?WVkzd1N3em9EK1hSdkNYVXBIUFM2SGNOSlBkME91S3VDNlhFc0tsSDBEV2px?=
 =?utf-8?B?QXU2cnl5TUlqTU5WT09kbFNQZkRZVnR5NVI1WU0walBqTXdYTHd3ZG5ubUpS?=
 =?utf-8?B?VEMyeUFuV3lZTHNpOC9abTYrcDFid20xdVBKdjF1YzV4VUE5a3YwMmR5UnNk?=
 =?utf-8?B?YTZIUmZlbUNFcDV3T0FIbklCUHhmNTEyYlFQSjlRNWhtWTVldHVBWGFFQ3pV?=
 =?utf-8?B?OTZReDljaWcyY1IxOXlXK0VxNVllWlFERXVaSXFWWE5UQy94OHBzNi9sOFB4?=
 =?utf-8?B?QlBIUVpFZW1yTzdvVHVBQzhWaDF2ZXRXLytaOUxmMFhubUI0cm1IYnU3ejhr?=
 =?utf-8?B?T09oZkxOYlFwRlNKL2ticEpqbXQyUHJZbkdhUmhNYk9wOVorMUlkS1RWZFJN?=
 =?utf-8?B?OCtaVEZTbkU4c0h1eGdBbVY0WW5XWVNNQjBIOEtCTGlRMzRRZVRXM3FtRlph?=
 =?utf-8?B?L1Y5RUQyZHRUTVhRYzFCZnBaUU9INHFhN1lVb1JmQWtxNUtpYjVHdUh6NU8v?=
 =?utf-8?B?K0hVNTc2dnNtUjVCajdaNC9mVVVPNFlGdm55UnBDaEg1TGp3K0VWc1FOUVZD?=
 =?utf-8?B?UWV5NTR0NDNwVHF5S2ZBaC83NWJ6VEhhekdtL0oyQUZJSTBJdXhpNVM1RXNw?=
 =?utf-8?B?eWZ3Yk15dFVQckxYVWNwb2NtUk9CWWFOYVU4ckZQUzVtUTZWTVYyWi9qczFX?=
 =?utf-8?B?bmRMWFI0WXJqZFVlbDg0QTJhcklPektYK0NNc0dBc2tiaS93cVdhS1lNRFIr?=
 =?utf-8?B?cnlmTlVpWWdzR1pCMmVXZHhOdi9oYmxkUU9PSTVlRXpjRFE2dEpOMzF0OEIz?=
 =?utf-8?B?TGVZZmcvT0RKZXpUUlgxeEkzNDBFeE04VXIwMUpPcDhMV1RialJMK1pXaXlE?=
 =?utf-8?B?SGFEMk41S3ZaSndldHRSMXpwK3JqVWd5MHFHYTZWZXh2RHNaOW0vNW93ZDFh?=
 =?utf-8?B?YUlmZ3ZnTHN6dU9BQ2ozZHBJQ0ZDVVYxc01NSmFBTGpsYU5MdmdOWlo0and6?=
 =?utf-8?Q?DW58SjDsRKBGnMvdOgYPLEKyb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba09332d-a09e-48fb-4d1b-08db5bbf624c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 18:56:15.2849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHUKr77SkgBvDd3F/T2b+cu8OJM6uolwS0gIjlGTYYAUxjJehWluaXnmDzLBBNzCvRQcCvO6mQUW5iK71MmENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, shane.xiao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

On 5/21/2023 12:09 AM, Felix Kuehling wrote:
> Am 2023-05-20 um 05:25 schrieb Arunpravin Paneer Selvam:
>> This reverts commit c105518679b6e87232874ffc989ec403bee59664.
>>
>> This patch disables the TOPDOWN flag for APU and few dGPU cards
>> which has the VRAM size equal to the BAR size.
>
> With resizable BARs it's not that rare.
>
>
>>
>> When we enable the TOPDOWN flag, we get the free blocks at
>> the highest available memory region and we don't split the
>> lower order blocks. This change is required to keep off
>> the fragmentation related issues particularly in ASIC
>> which has VRAM space <= 500MiB
>
> If TOPDOWN has these general benefits, then would it make sense to 
> allocate visible memory TOPDOWN as well, on large-BAR GPUs? Without 
> knowing too much about the internals of the allocator, my intuition 
> tells me that using only one allocation strategy has a better chance 
> of minimizing fragmentation than mixing two allocation strategies for 
> no good reason.
We have 2 allocation strategies for visible memory and non-visible 
memory. For visible memory we are going with tree based search as we 
should limit our allocation within a specified range limit. The TOPDOWN 
flag is not applicable for tree based
search allocation. For non-visible memory we pick free blocks from the 
free list and here the TOPDOWN flag is applicable.

For large-BAR GPUs visible memory, we don't go with tree based search 
since the BAR == VRAM size, and if this 
AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED flag is set for every allocation 
on large-BAR GPUs, we don't set TOPDOWN flag and
this could create fragmentation issue in case of heavy load. I will 
check the behavior on large BAR GPUs and set the TOPDOWN flag if not set.

Thanks,
Arun.
>
>
> Regards,
>   Felix
>
>
>>
>> Hence, we are reverting this patch.
>>
>> Gitlab issue link - https://gitlab.freedesktop.org/drm/amd/-/issues/2270
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 2bd1a54ee866..ca5fc07faf6c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct 
>> amdgpu_bo *abo, u32 domain)
>>             if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>>               places[c].lpfn = visible_pfn;
>> -        else if (adev->gmc.real_vram_size != 
>> adev->gmc.visible_vram_size)
>> +        else
>>               places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>             if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)

