Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2BDC83F37
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 21:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A252B10E09C;
	Thu, 31 Aug 2023 21:29:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC10710E09C
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 21:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo8MRrTttJEzAabS3JsPTjE5bExRZzhH89R0gnAO3SdcQSE74L03k01CVD6Da7LlmyN05uf47ylqbkoG5HLgjXaAMgLgwLQULELSQuI3s9da5dOJiwYJr7JOq0K8dhHYGIRZDRUAkNGQrDgdY1cZZCn6m+HGV9Eyp0bFH/c5esws9DsUI6GVHv/AJAD6sL1I6TYgGPUXcAtWkUeGZOa3+HJGzk/33dKmUChyi6ajWoAdztOq3wVvCZzmzNnmulpzQASQzy5fKqu3deUtKmzzHDRQntWg737mdakA+MlnelqXR2hOs1IzcIV9ei9rCyEEYDqEq5yk0Bb3tXPeezrNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oyw0+VHWoq/95xS1t986HmPGuoeYtlqL8mWWSf8czhE=;
 b=ldZEN3D9idh3UVgdRtPkZZgA3Zt+Poz4qw3KCVogWuD0ogdsEinbBIZZ42kI4xfpi8GAkMtxpIwF/rWQYO+ZSlUjKZFo/5i4YFaUYtLx0qSb94v7STnppBRb79CK/u9HcWcrJDc/9uytX9Dgvz6JgvoOjJIFx8Q3EwvpXSOdt/jCQFQGaR4ho8bEMY8F/8C71+eodEkzjFA2gcuT4Zt4Ow4+epjWZLgJZr2DQ414+U4HGLoTIn3kGESZbf1NJh6kSywZpYle/K8JZ5ZE+zpR3CzAXFZGdxoGPkBkiCRC7tiPoEpZSWMIMNccGoKAJGpZfFkeRxI81qm1doZRlDVUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyw0+VHWoq/95xS1t986HmPGuoeYtlqL8mWWSf8czhE=;
 b=1rtqY7jLimoZ2GV1WVNiARXPFlV+95dsAeoHSUvLz2uN/7IokuKF7onvrmoSRFXSOhi4mua4dMnjmCuGWwzeSpyKnfQ78EGuNaI2IdHgp7E5ckVMeiMWvKAD8VByFqfizZtg9C2k4/2Cp21Rnil333wbLtNwfzTmVOtlKS3tHRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.22; Thu, 31 Aug 2023 21:29:13 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 21:29:13 +0000
Message-ID: <a83c2317-932b-3a7d-2a54-0ccda4dd77be@amd.com>
Date: Thu, 31 Aug 2023 16:29:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230824220834.362948-1-xiaogang.chen@amd.com>
 <d31985b2-74d9-2536-2995-7b693928d443@amd.com>
 <f744c06c-284f-de8b-8ed2-05d0512823a1@amd.com>
 <ed0dd323-bd99-d2f7-8cbf-6a92e5201f8e@amd.com>
 <8670e751-9a76-b9d9-47f6-05461c279f09@amd.com>
 <fef7aadd-fb8f-f5c2-10e6-b5ebdcf4be56@amd.com>
 <347c4bba-cd60-29a5-6fc0-8f445fd31300@amd.com>
 <85f4c2da-2d8d-4c73-a540-f714ebe6b2e6@amd.com>
 <f57a1e42-52af-0d67-0049-9ed6c58fe0ee@amd.com>
 <0da257e5-85a6-4843-4f49-5666d049110e@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <0da257e5-85a6-4843-4f49-5666d049110e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:805:de::33) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dd7728-2767-4d93-f4de-08dbaa695266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAcmHYEqn1NMdO1yBISDs2xBPULxA5yQyUrrKX1m01mNgoYoeFv4tf6sCIL0hZ2NnzFfABGnohVMXE/xoNSpcgCeDFfhifBkY9sWbbSE5VwdvJev1Vdwu1XQTAAwKi0K9rLosBRJerbDd9TPdM6imqy4yGHksd3Ix1jD5LIztA2PftbC8XvAx78Y129vxtrtI5xWPHGO3fZGdf8p3SXxoct9q30p0IYXQn94fngB9NOaGiKQVNgXf0uwR8Lwfy/+12gCLSd9v5Ca8E7dVFbuPMNVdt+zCs77hVbUr17AzUctIA/A+ggaMem4u5Bxzx9OLH7oJJrH5s1gN1IIgCivIDxGY1TsiwZincuNnuEUMKR1NCankdatkdT0x1RS7NsGlEBfL5A7PWGkw14hi6XpzguaGnsTGGwwzRZmEtiy6ZDnDuj91E1KrCxn0Cmd0c7R5OqDc8YpTe+xOAnsKeuL1iriNC7ETEFqQI5eqFgQafZbFSJm8G7pP5uTUmXNn9pJ2Kwg+EW4/XPHr9wlnjFOEcOGa6phmwomWS27cb0M9x8pXr7W2mRIXcO814iodz9fUF1T1ghe395BXOVJcykRR6ekoimwOAzT6Hr8/+0nSBDbEQDzHjQd+I2AiivDc806b2xrz6mm9zF6+0Ga1lAQdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199024)(1800799009)(186009)(2906002)(5660300002)(86362001)(53546011)(316002)(478600001)(31696002)(2616005)(4326008)(8676002)(31686004)(6506007)(6486002)(6512007)(8936002)(26005)(38100700002)(41300700001)(36756003)(66946007)(66556008)(66476007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdxbDU4dHkxVzdpY0gzaUp4V0NDQ0QwZ1Z2a0ptZmNrczI3ZEhwTUtZMXNi?=
 =?utf-8?B?b3dQbWlFd3FITWMrMjdyTCtjdWNFallRRzZ4U04rVkFtdUVnOVM2VThKMXFT?=
 =?utf-8?B?Um1SSGcxZ0p4YTJXa1QwSTJvZysvdkdOM2RSOHMrN2QvOWlqb2FUbnFFdzRI?=
 =?utf-8?B?Ulh4Q2RLZjgrUDRoT09sZzZSSTg5cU14a00rWWlpNnFCOVBHZklmY1AxOEd6?=
 =?utf-8?B?UkF5ZjNtUmdOY3h3bWZlT09zMEdhZENISjA0SGpOa1RNSXUweTFzbFBtYUVM?=
 =?utf-8?B?K296U0NxT2JvV3ZrYkgzaGwrUGtBZWJBT21NNHZwWHpVWjJlZ005Q1lpNnVz?=
 =?utf-8?B?ZGczeWNLMGM3MERvWVpCeWF4VHkzUk9uUmdqVEphUGV0MCtKV25WUEZxYWp3?=
 =?utf-8?B?U0hObnJjc3I2dFZsL3EzNC8xOXhQVmRnaTJaSzJBRFRaWHcwV1orUjNjaXdX?=
 =?utf-8?B?YWx3UUdqY1p3ZFdJaE54R1V4eWczak1iVnZrU1VycGluMjhTT09oc2VlYk93?=
 =?utf-8?B?MTNBVkRXZmgyb1M4RUFtOS9mUW16Njk0cHBOa205b1hNblI2ZVlUME5yaGtE?=
 =?utf-8?B?S085ZTlRSWxTdkdwaEdZZXUrcGFHTitiU3BQUVN6UmFUb2tiMG9XUUpuTVpt?=
 =?utf-8?B?UFhFN3l4dlJ2aHRsRFRVOU9iVWo2QXFSVzdxOFlkMm02NzRCekFERi9yUGVK?=
 =?utf-8?B?UkFWbjdaQXVqT3RLQTMyMXkrZlMwV1NqVm9QdlZqbXhzZ1RaMTlicFdjS3BD?=
 =?utf-8?B?cXZWSkVXOWdBRTY0NW1FMlRPeEpJMnprSlRDc0swTkwvSFFZNW5aTi92R0pt?=
 =?utf-8?B?aVYzbHRqUjJ1TXFlSi8wbFFNa0RmQTRCZVl3cFIvWWNYQmZOamxXc2xQNWp1?=
 =?utf-8?B?WTduV2wxcEdmem9lUVRvZWsrem5Ed09HWG1aNUZ1ZTArNzdNVlVReUhzTDNS?=
 =?utf-8?B?bVViUUdNejhqR3laV0JDb1h6R1FIN01ycncxWXIxRnJvV3ZRTmlNRk9XUFZp?=
 =?utf-8?B?WEtxL3NPSno3dllyRDVNWk01NFl6NXgrbUhBSmVRS2lKV1RtT3hEK1VaRHB5?=
 =?utf-8?B?U1k4S2V1MzhiZlpUYUN5aWF0YkZac21VcVdWOTM0TzJSZmFhcHVzMm1RelRm?=
 =?utf-8?B?R1preE9tdDJ2dk5pNkRRZm4vMzJaQ2QvbnVRc2VNT25Ua2oxWFNwRDVpTkd2?=
 =?utf-8?B?c2ZobGloWXN6TlVmZE9mVVpXNWc1MlhUVFdsSmUvU3hlWlVzVmVqeTdjdnZi?=
 =?utf-8?B?T2ZaNVFxWS94cmFXSGV5UUNnMno2MEJmYS9GMFNiUVNFTjlGLysxZXBVWmRW?=
 =?utf-8?B?dmUzNDhhRWdZeWdiczVZaHk3RC9rdW5zZE52RmxCV2NqWU9PVllqMTVrdVBP?=
 =?utf-8?B?Q3VjYzZxZi9KaHM4eG5NN0d0QkdNS1pmY1EwYU5KTW9UWGRxZFFzdzZ2OWl1?=
 =?utf-8?B?cUdQbTFhQW5EY285VTEvT0RlZTk4MVVTU2R6QkNtUjVYWGxWUjlKRUF6YmpJ?=
 =?utf-8?B?NnFxUFpCWmhNdUxFUEIySEhaa0k4Y1ROOTJwS0VSc0o2ejJkemlrK0F4Wm14?=
 =?utf-8?B?UXJQM1JCdTFtWklJT1VFSVc0ZjJhWEg3MDQ2Rk1sbzloUlRMTGRUbjdIcDlr?=
 =?utf-8?B?WTNBY2d2MGRXN29nRklRSlQya3k0aVl2QjFRa0RVemR2enF6YkhkQkl5TDFl?=
 =?utf-8?B?clB3VWM5QlB5VmdzMC9rOW1jQVNyS0pPZjJ4N0xmcG1PaEkvKzBRcCttSnBO?=
 =?utf-8?B?VTRjY1dybWNROS96WFJDaGhUN0lkTzNqdVBnU05qK0gwTnI1a3VLa1dJZWhP?=
 =?utf-8?B?bTd4VkFDNTNEY2VDenVTaFFVL05VRVF3TzFXZjN6R1MvZ3NWRFNSQXE3WVBS?=
 =?utf-8?B?cWZnbzFEWmVEclBRYmtjTVFaRisyL24rbWJrYm9uWW1odVBIMDIyUlpVT3pm?=
 =?utf-8?B?ZmNVRy9iYkNTVjhjZHB0UWY5UWxrcXhlYkFvTVZhSGFjZlBIZDJhQllyU2h2?=
 =?utf-8?B?Tnd1bHpWWkxyMll3KzQ0UVdMaWFoV3doU3owUXdvR0UwNkk2VTNsY1U4ZStR?=
 =?utf-8?B?Nk9sZWJVa3N2L3BscXUvczZYNmNKSjh3NjFsVllYbnRsM3NmQ0xhOHpyWWJT?=
 =?utf-8?Q?qAfM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dd7728-2767-4d93-f4de-08dbaa695266
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:29:13.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwGrxucWQQWCOcVlRC8ifWpbnbsIjzy4SYWpoPi38deIIT3i9SkoF5eqsjlXhOPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/31/2023 3:59 PM, Felix Kuehling wrote:
> On 2023-08-31 16:33, Chen, Xiaogang wrote:
>>>>>>> That said, I'm not actually sure why we're freeing the DMA 
>>>>>>> address array after migration to RAM at all. I think we still 
>>>>>>> need it even when we're using VRAM. We call svm_range_dma_map in 
>>>>>>> svm_range_validate_and_map regardless of whether the range is in 
>>>>>>> VRAM or system memory. So it will just allocate a new array the 
>>>>>>> next time the range is validated anyway. VRAM pages use a 
>>>>>>> special address encoding to indicate VRAM pages to the GPUVM code.
>>>>>>
>>>>>> I think we do not need free DMA address array as you said, it is 
>>>>>> another thing though.
>>>>>>
>>>>>> We need unmap dma address(dma_unmap_page) after migrate from ram 
>>>>>> to vram because we always do dma_map_page at 
>>>>>> svm_range_validate_and_map. If not we would have multiple dma 
>>>>>> maps for same sys ram page.
>>>>>
>>>>> svm_range_dma_map_dev calls dma_unmap_page before overwriting an 
>>>>> existing valid entry in the dma_addr array. Anyway, dma unmapping 
>>>>> the old pages in bulk may still be cleaner. And it avoids delays 
>>>>> in cleaning up DMA mappings after migrations.
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>> then we may not need do dma_unmap after migrate from ram to vram 
>>>> since svm_range_dma_map_dev always do dma_unmap_page if the address 
>>>> is valid dma address for sys ram, and after migrate from ram to 
>>>> vram we always do gpu mapping?
>>>
>>> I think with XNACK enabled, the DMA mapping may be delayed until a 
>>> page fault. For example on a multi-GPU system, GPU1 page faults and 
>>> migrates data from system memory to its VRAM. Immediately 
>>> afterwards, the page fault handler should use svm_validate_and_map 
>>> to update GPU1 page tables. But GPU2 page tables are not updated 
>>> immediately. So the now stale DMA mappings for GPU2 would continue 
>>> to exist until the next page fault on GPU2.
>>>
>>> Regards,
>>>   Felix
>>>
>> If I understand correctly: when user call svm_range_set_attr, if 
>> p->xnack_enabled is true, we can skip call 
>> svm_range_validate_and_map. We postpone the buffer validating and gpu 
>> mapping until page fault or the time the buffer really got used by a 
>> GPU, and only dma map and gpu map for this GPU.
>
> The current implementation of svm_range_set_attr skips the validation 
> after migration if XNACK is off, because it is handled by 
> svm_range_restore_work that gets scheduled by the MMU notifier 
> triggered by the migration.
>
> With XNACK on, svm_range_set_attr currently validates and maps after 
> migration assuming that the data will be used by the GPU(s) soon. That 
> is something we could change and let page faults take care of the 
> mappings as needed.
>
Yes, with xnack on, my understanding is we can skip 
svm_range_validate_and_map at svm_range_set_attr after migration, then 
page fault handler will do dma and gpu mapping. That would save the 
first time dma and gpu mapping which apply to all GPUs that user ask for 
access. Then current gpu page fault handler just does dma and gpu 
mapping for the GPU that triggered page fault. Is that ok?

Regards

Xiaogang

> Regards,
>   Felix
>
>

>>
>> Regards
>>
>> Xiaogang 
