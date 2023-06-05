Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9598EC7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 15:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E8110E2D7;
	Mon,  5 Jun 2023 15:19:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2023110E2D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 15:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAf+AyxIExU5dCoRK1xX/dXbz55tIYcLnyMGsWwOnpDRv6uvUZFvsGnDdPmLQWbf+i2oAfZ0L6YbBFe/bV/T2PebjzLff+fGJ5hAuaixeU5ZVrLpBRVydDsEThPwfMBfAwoa6BgKsMUxJulL7FykQ2U3JPm7F6VSgVgGJ49odRnyPU+x9QabuuompCe5wlyFh9WYYVmHiOxx1aqj0yHLRmWZgjJHF0WoLLYFLhvjNpL9SQZtX5mB/pW/n9Wn4VvwgVOha7RvsQTPXAms2GHNZTNsGlcFoKZAV5Lt+Wdcv/43of0JH7LswJ/Zcd2OaX5E3/Fa96DRX2tk+VB+Rp+IRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTZ9bAQJVZ0yrVZE5Zg5i77oTiD/jq+Au3gaGCyi0P0=;
 b=PXfZI6FZqTjGX3/5sI22kzC2EsuEppWvCAWWHQR3tE7bBfzp6a+YlV+WAPQLkP47RS/0d6jmZ3UIDL1NKrV9kcY9sM0jAt477RMV3u5dld/m1XoSY4F65H+tENEwUeRCox8L44iEKTB8CMvB0EI/ZZ+9Z3Yrtn+lS3FhCHF3oAaYeWTynK9l8/IkLZlE5Eg6VYF4u4lVT+uVohg0U2sW9BHGlsM628Z9O6qATC2FmVsbR0VkXRs3h21A5wjkYydhg2EeKT3e5tdu0dgJKMvAR/oHZJzExmA7KUldmxVWI8qp6lIZE7wIxaaIt0O38dAB6ycyVp9BEX1LKqnELIJyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTZ9bAQJVZ0yrVZE5Zg5i77oTiD/jq+Au3gaGCyi0P0=;
 b=u8DJbDjassvUeTWMM563u2TNox3qnpInYkPMrA51WuB4iSq/Lwpt1YALNhzlIQndO0CnTh9To2EfgMAGcHK+blCfjEkfvR4ykC5opHopVxVj+8kP56jQJl8l2VYkAaRPvx4kAhwtytax5Cw8x3f/KbegQKe57OcjNG0BU3d0fEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 15:19:02 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff%4]) with mapi id 15.20.6455.024; Mon, 5 Jun 2023
 15:19:02 +0000
Message-ID: <9dfb0942-b731-16f3-6792-a0ae1ac60ce4@amd.com>
Date: Mon, 5 Jun 2023 17:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
 <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
 <a521c410-787c-d235-f911-e34a9cd01640@amd.com>
 <4e390c3e-b63a-8fbf-8988-2d8bed0688b8@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <4e390c3e-b63a-8fbf-8988-2d8bed0688b8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf3d474-1d29-4be5-e57b-08db65d83192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQWE3MQwRMWTZHudvl4FKWP+/EUqX1IpjgxsQNNbCzU/XW4QWtuzuwnshzJVToNMZc7Xjzr26nriJoI7UyyE50CyX35SVaeP97CdefAWkfvsgkiK/yKAN3xQzcXCGJKJJMcLPIVyABSCoEOplpgCNno8zpTf1jlH9JxMW6MtYD1mAU92CPXxwOhYAgAOaEl7dGAUEHySCezY1E9AUQk93SB8Y4MM6zGD1DzJyA1Sf9kSdkxZzu0FwxhgSYwK7pzS25wUrZN7SAIh8qu0s5DP2JGGWggdueiLO3IMlm9mXHTpg/TqC8XlFCB/iKs21bND3cJ2g0y55YLmviA7AjE6JAuYZFHh2TkGgjDg0cMr/ZEpFeJvLZEPb6C/9Fz9REhPceTf74PwtkXYODUSWFNuIgh5qNvYsP1SCEXJJOBIy2WRFgsmH3Unvl8PyT5MIJwlcVrL9Lx+RTNHc+qiPy4gbvDhXVgejQIzQNNGjXzznfjmfNpx4jgeg5k7k1cA3irlFH/wPmrebsrUv3P8fINj8pY+HMTNd8SsNoSBQ1Yj4JmM3i5M5dFxafJhOXXTEhtc2fwbKwngS18j8mntkeIdcaJAw0Wekgr6AKLpYZTjpboDRhq2vDOQ1s36npVWSuvzcIQWLYDrFty+oy2i6wiBHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(110136005)(478600001)(8936002)(8676002)(6636002)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(66574015)(6666004)(6486002)(53546011)(6512007)(6506007)(31696002)(86362001)(5660300002)(2906002)(36756003)(66899021)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJ5Q2R5NThQVERBSEhLSVhUUnNIK3FDOXBZTUk2WG92Ung0cW9iK1h2SlNW?=
 =?utf-8?B?TXRDTDRjSFg1QitEZHZvT3FzS2orVys1aDZnSTE5V2FWWXZCZVBtWUdjcmtJ?=
 =?utf-8?B?d1pHVmN6KzNGaEgwSmRlUUdud2NtRmlOa09mbStIaTd5RzdSdERyK1o0cTBL?=
 =?utf-8?B?QzIyUS92YmpIQXZDdnZxY0l6QStVY0F0Z0F3OWIrK1N2VHBKc3NkeDhkcHov?=
 =?utf-8?B?VXJ5b1NBb3FvMm81UW9PeTVVM3N6MzJwNWhlL2pDNWRXOVNZaldqNTAvMnkx?=
 =?utf-8?B?aVppWEIwUE9sQ212blByNFJmblJHZHRrVkxEblc5OTNMc3VtcFlkdVZncnB0?=
 =?utf-8?B?TVF3UU4rU2VJVEFlN2UzQU00cXloUEdwNDJUYnpvNFY2RWo0RkRYcDg5MDY4?=
 =?utf-8?B?cXZ4c1VVVm1NTmNmWE5LcDN5Qm9zbitSMUM5Zi9xaStiOGtGWlJjTE9SQTg1?=
 =?utf-8?B?RlRUQW1IRUdqaDNNbEdZQkFBSHU0WElqTk9GUFRZcytHaVN4RWJqT3ZJQjYv?=
 =?utf-8?B?K0NWWUNGc080M3RWSjU3NklreTBxRUlEdzkzOWIzNjRNYndxSjNldG51bWNP?=
 =?utf-8?B?TzkrTUU1QzduTk9EUVk0RU1kVWRCYis4Z1FvL09vdFhhY2RGcDFCSWw5aDgv?=
 =?utf-8?B?VGMycExHRkZ3elJDYlEvK3JsRlJIOWFpbTUvQm0zdE0wdkhPYVR0S08ybXV2?=
 =?utf-8?B?TVBGZW80aDJuazBpdlNlMW5TRzBjUmRlVzNSYnhXd2ZkallGYk1NbENwUldD?=
 =?utf-8?B?VzNYVDU3V1dUci9EejFZYlVqK3JpZDJFRmdaaVlvNXQ3V0FqSk9DOEJaYk55?=
 =?utf-8?B?ekNncFVQUjNkOTR1Um9pdmdxRmFXakNrR3poSWIwTkNnbCtiOG9aYVJ1RnBr?=
 =?utf-8?B?MkUrUGVIS3JuMGFNbUtGQm9iVjVmbGluajlKVnZwY1R5R0FINUp0a2t6ckdM?=
 =?utf-8?B?UmVtZ1dMR0pOVkkrdS9POUN6Lzhialp6emhDWlpKOHBlcjlyZVZRUHZWSHhC?=
 =?utf-8?B?R202VWVnNnhRajRnRGZwRWZaMFpGVzMrNkNBRkkvTUIrRUdzZjVMRDZyRHJ2?=
 =?utf-8?B?QmhRZXcwU09jUlVaYUVVMDNJSXNwbys2VDhpUXBHTTFuSGJ5Rm1vRkFQN1Vn?=
 =?utf-8?B?YklOdHFWNVVYRG1HU1M4aUZIZ1E1V0VlYmdnUnRyUjdCUUtoeTk0M1R1MlRl?=
 =?utf-8?B?S3ZwdzJMQVQxSytpbkVhVXFyYUs5V2xjcTJCYTQrczlsdk4vNWZnTjJ2NFhY?=
 =?utf-8?B?WC96TldHZk14bS84Y2lyV3IyWG1uSzZNOUlDSS9LNWNMdDZPZmxpM0p3bVFJ?=
 =?utf-8?B?K1ExYVRvR3ZEZmd2YXZ0MUdvMVNtN1czek1vQ1ZWMFcxN2g1ckdWaENpdElR?=
 =?utf-8?B?bmJaQmxTY0RlcS9RYTdhMytuR3NkdXd6cmJuemxPRm9sZlg3T0IvQnFseCtl?=
 =?utf-8?B?S2ZIdElPQTNlOGl4WVNua0VOOTgzTkhxd2RaU0NQWlZBeG0xWVlXZGpuNzUr?=
 =?utf-8?B?MERNTE0zY1ZTZUZEenJFRm4xM2xlZmg1TDJPcGJBOHZtWmZjSGc5U09EL1NH?=
 =?utf-8?B?S1UvWWE3UXA1a0FKMFVndjVIMzltdDNtcTZqVVlBcDVHdlJJKys3c3NrcERP?=
 =?utf-8?B?QndodnZQUXZxY29velZUcDgzYW9OR0M3Tk9Gd2ZvRDlYa3NMTnBna0s1ek9K?=
 =?utf-8?B?TGRROTNzYUJ3L0xxU1h5UFQ0UlhLaGxjK2NwcVBpb1FjUDhOcVhSWC8zem1r?=
 =?utf-8?B?VDlhRXMwaVc4ZEJ5T0xKdnJYZ2lFUktraWhJU3FINCttQTlLVENuOTBDUXdl?=
 =?utf-8?B?VjM3VWZqWitFeUtHckR3MUJQOWFISzN1M1VJV212eHhWWTZXQWhrV0FUZTA1?=
 =?utf-8?B?Z1JtcVdJU01FeVhmNStDLzM1MjNCSWRmWXBqeCtRUG5XWWFqb0FaaTNFd2VC?=
 =?utf-8?B?Z2RIQXpHbjhSa0FFS09DNk00bzhRdnlieC9rcE9hdXZLRGJjSlZldDlOckU5?=
 =?utf-8?B?bTNQenFwVGxoOUd0NDJySG5PcmZhMU5ETmUyZkY1Z0ZQRnQrQmR3b1RWeW01?=
 =?utf-8?B?bFpSeXpaUkpucnNzMk5SWXROQ3FTV3ZuQUo0U0ExYzgzRERwa2paQUdzNmZa?=
 =?utf-8?B?UGtUbGdSbHd4cWVEQnl5SXRXSWdHZGxwTXpqZG1zbllrdWlSQU84aEdFLzRy?=
 =?utf-8?Q?W5cxDcTD6b6QaqTH0NZbwf9/7v36YUtq9dzYB7a1FJzp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf3d474-1d29-4be5-e57b-08db65d83192
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:19:02.4914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/kqRRj2A6CCIx+dx6c8OZq/fDpIsX2huRCOb9T+kZyoBC6LDg74u+zRHBmYbdwJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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

Am 05.06.23 um 17:13 schrieb Shashank Sharma:
>
> On 02/06/2023 16:54, Felix Kuehling wrote:
>> Am 2023-06-02 um 07:57 schrieb Christian König:
>>> Am 01.06.23 um 21:31 schrieb Philip Yang:
>>>> To free page table BOs which are freed when updating page table, for
>>>> example PTE BOs when PDE0 used as PTE.
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index af0a4b5257cc..0ff007a74d03 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct kfd_process_device 
>>>> *pdd, enum TLB_FLUSH_TYPE type)
>>>>               amdgpu_amdkfd_flush_gpu_tlb_pasid(
>>>>                   dev->adev, pdd->process->pasid, type, xcc);
>>>>       }
>>>> +
>>>> +    /* Signal page table fence to free page table BOs */
>>>> +    dma_fence_signal(vm->pt_fence);
>>>
>>> That's not something you can do here.
>>>
>>> Signaling a fence can never depend on anything except for hardware 
>>> work. In other words dma_fence_signal() is supposed to be called 
>>> only from interrupt context!
>>
>> We are signaling eviction fences from normal user context, too. There 
>> is no practical way to put this into an interrupt handler when the 
>> TLB flush is being done synchronously on a user thread. We have to do 
>> this in such a context for user mode queues.
>
>
> We are currently working on adding a provide a high level kernel API 
> which can be called directly to perform a TLB flush. Internally this 
> API will add a deferred work to use the SDMA engine to perform a GPU 
> TLB flush work (to compensate for a HW bug in Navi Chips). If my 
> understanding is right, by interrupt context Christian means to 
> perform this flush and signal from that differed work, is that so 
> @Christian ?

Well more or less. Ideally you put the TLB flush in a work item (or use 
the SDMA for the hw bug workaround on Navi 1x).

The point is that you shouldn't have it in the same execution thread as 
the VM page table updates, because any memory allocation or grabbing a 
lock could potentially depend on the TLB flush as soon as you have 
published the dma_fence (by adding it to the VM page table BOs for example).

Christian.

>
> - Shashank
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> What we can to is to put the TLB flushing into an irq worker or work 
>>> item and let the signaling happen from there.
>>>
>>> Amar and Shashank are already working on this, I strongly suggest to 
>>> sync up with them.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +    dma_fence_put(vm->pt_fence);
>>>> +    vm->pt_fence = amdgpu_pt_fence_create();
>>>>   }
>>>>     struct kfd_process_device *kfd_process_device_data_by_id(struct 
>>>> kfd_process *p, uint32_t gpu_id)
>>>

