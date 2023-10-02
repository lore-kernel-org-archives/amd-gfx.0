Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0CCE784B0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 17:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D0810E2C8;
	Mon,  2 Oct 2023 17:08:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47B710E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 17:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HClGCRjfF/ct5NkU4v8jKUnmwNz4p+av+JDVLhW7P6i2NfXhRvpbbn7dQ3yeHbRoFQWAgErgXpq8jaVyHxzRtBL7wFYoOaBljC+mysSctUH3q8rvVxGzsvXZZ7hFGZZAA1V8YAXS6V1EcInRP2Jrmio6ZHljZjTM5tfjW9zziRQfThpFWBV6wGbJeNDDjMpEktvS3RDMc45C8vBUnceif/0pWMys8/iVPRegcNMAf0ZqK3Vj/EQwU3fGI+WLkQ5/YrhRMG+5N49lBNaQvErmB+rwZ6UkGqEsy6r/FTrjNwrcJYuqzeWbzx/i4No0PVNA4aUJW4A1jPrMoMeWc55arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiMDUrSjzP9xAg5m1cHM9Cm6GcYLCqims/kZ9WqriU4=;
 b=JIA/iOkkNIESC9R6K4mFxTWUs7S0XVaKci3pF/MP/YIEZH5pR+9taQ5R8fGrabauHlIohXV0D3Ym4nn6TfqzwZpK/fmoNey+Y8ZAzDL5jncSCB4cneyjEm6eYPF1AeSbu2kN7MOr578uCg2SYTyErXNyO1nsoUdvayy+niVf38eLjc15drvCseGlaQslX5HNyFguUzWxiWiQxGVFqkQ8w/zDBecDnVkgh4oBts6BUR7IcLLwr14GRq7pNKUq1j6yZXk0f35oDfLuyf149++CkR7FyFHmGJQKrgdp42Vjr7Ic+Pdz8qMqneQ3te1NczPZw61AiMkqnBgVoyBhu22WTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiMDUrSjzP9xAg5m1cHM9Cm6GcYLCqims/kZ9WqriU4=;
 b=So6bhbUTORLubKqVWuoZUVOSCf25IKhA50ZxL/oyKA3yk0pcW1InlNASh5+vbjnXmQ9jV1LAWyn82NfuM0IgiAGqDUFouMRM0lh3lTVGV37/f6mJbRCaYXZGCBQZwPhSh63Iaede5ZBkbqw99v1W739K4J+9d5xtdRilYyV/iio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 17:08:16 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 17:08:15 +0000
Message-ID: <678650fb-8fb1-7f2c-cdb9-6a01d9095a34@amd.com>
Date: Mon, 2 Oct 2023 12:08:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] drm/amdkfd: Check bitmap_mapped flag to skip retry
 fault
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <20230929141115.10016-3-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20230929141115.10016-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::28) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbb7a4a-5cab-4378-88e6-08dbc36a2ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oi1+VhsuwUzqxRRRaTYpuV+5aXiApAZONcZR6hXySRB6ia5iYRwNiOl7mnq/U6QnO1DCNVsmUS9T3UNsWzxZs44Ljdl3aK8ZTugOg6M00JjuLpSmuHXMdSmESCsuhx8O0W6BgxEI2JOSiemZqc7SrWj4sn0kdv8AuIIUU0CGfAI6w65dIZJP6jVjQSQd7QpQ1i7ss+T7lzpPiHZ59SN2+81e4K097QMUDXE7yldQ0fkbmb4orDJuFKoFd5m0oyYJ+H7XC5zzvMJ1lulScNbiI7bUHRTkpsftsmcbBle6ME9Ylrg/zSf4+PoO5Z7Wwj+rE1W8KhiKCYvHgiphyikgi9Q4Zw9AenV6ue3uG27+CJnnkP/gaxVeJ6xO73jDKuk+KnSBE9cVkcnO5ma8mKHVWjWv9FrVTRNriTEiLuVmWPOYxxsSl+9ZV7JklWIsSIbu6PFbhcA+QizV4dZJUzVVadHHxjgoo/LSXtiWhwWw0hlv+xv6SOLiuiX3fKvE04MyXC3Iufm3s/Sih6xi/Oeo92+L1t9ubJKtVVh9QkziyGFmgb3bSTzWW4bbxp0mWIjUdzZ64a9/xgkVU8CEicHe/kFyFbDDmjbZaaZwK2CEtlX6/eQYn3aHWn0SeAplxXdgqVcXQpKaJzuiF0wFLm/y6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(53546011)(478600001)(6486002)(6506007)(38100700002)(86362001)(31696002)(2906002)(41300700001)(83380400001)(26005)(6512007)(2616005)(66946007)(36756003)(316002)(5660300002)(66476007)(66556008)(8676002)(4326008)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWwxejljK1E0UytlOGxtL0Y1VENNU016cFBlLzAvZVVRaFU1WGhMVVE3eUdE?=
 =?utf-8?B?MVE5UmZ3aUF4QTZUanphS0hEWXIrU0x1cWhqaCt1NnJDTVgxMDBLUnBINXpN?=
 =?utf-8?B?TEdEV1BUcU85SGQ2VFlWNlVMTFlQTjgxVzhuNGxMYkZQVmRiN1A5cEhUbGJ0?=
 =?utf-8?B?c2VGNG5KbkI4b0JqeXdOaXZBWmlyTnMydUdHc2FaUW1xbW9GOUlCQzVaaENB?=
 =?utf-8?B?UWlJekVNMm1MV1NzWUhWbllwQ3UwTHg5Z1czL3NFRDZEVUNJOTZ1ZHFvOE41?=
 =?utf-8?B?NTlTeDM3c09DTEdqTk1ScUVvc0FHL0xKRGRxckM1SnFXeXluc1BxMHNBNFIz?=
 =?utf-8?B?Wmw5bVVqbWg3V2ViM01jaWNOVEs5RkVwU2paRFEvS0NlY0djMENjR1JoSDNZ?=
 =?utf-8?B?cldGVjgwaVJEMGdOSFdQNzFxM1pOdUxIbnZ4cGIyaTNWcFhMWVlIbWFWb21O?=
 =?utf-8?B?YXp0cHVWRFhsK1I5cTU4aE1pOWp2NnZQN3JUbW14bVNXalBaWko5T3hTYmEy?=
 =?utf-8?B?UlFjemZDSjVtUG5hMUFXenZLeEVXQ3dRbE9XVUFhREVkZzd3MWd6YTRPVFd1?=
 =?utf-8?B?MnNzUzZsZGwvQ0VBd3l3V0FOOStOa1lmdWVlNDBITmpEQjBSTGxNd0ViM3hy?=
 =?utf-8?B?RW9xM2lGZGR1ZHQ1L2FNNGJ0Z0YvbUpRZjhaVFpDUnpwRjgwU3RueFlCaTUv?=
 =?utf-8?B?ODk5SWw1OG01b0ZpbGFjSXkwMW9rVDZ4blRXV1c3RmY1TU5oL3ArK2VzajNG?=
 =?utf-8?B?QVpFZGpIYUFxeXp4M1lyWmNPWGFTRTBadHNKY3BOOE9BNTJDMDZpUkhtSG9O?=
 =?utf-8?B?dW51UGRoOEFMM3hidW1WMnE3Z2Z0a1F0U01LaU1uOXZrc0ZkMGwwVE1QZW93?=
 =?utf-8?B?MmFPbk1JYjdHRnFPTlFrNjMyTWNqR1hZdGdxRk0vQkxraEh4eTNncXJaazJH?=
 =?utf-8?B?ek9pK2hzVHc3elFxNENEUVFnMXhQbmFvK0dBbzZicXRVTG9Ccm42Rng5ZHVS?=
 =?utf-8?B?all0RHBCT0J6dnJRUVVlM1hrdThQQkZxTzBaOVBUZEVtdVhlRjdCTThsSnJw?=
 =?utf-8?B?RDVVZTk1ZThqTXNuSjNzbE54NzJEZDFzeFI3UVhOZ2FrdzF5NjJGei9EQ3lM?=
 =?utf-8?B?RlNQS3A3VEkyaW1TNk5URURKNlJmN2dpYlZVbFUvbDFnMzZ4MnZFcUcwbW95?=
 =?utf-8?B?RFVHeC8rdDVTR1JnYmV3bXZZVDgraE91dWhiVlpzU01lYzRIbDY1ekhFMzBo?=
 =?utf-8?B?eXRVUXhzUEZvWHR3OFRlR0F4QXRBNlR1ZnJjay8wUHc5R0o2QURZV2N6YS9W?=
 =?utf-8?B?c3JvM3hKNUhIOTZMT3B4Qis4b1NkNFQ3MG1WZFhlRjdWY0drTm5najdSQjlv?=
 =?utf-8?B?WVM4ZTdwNmlnQ2FoWjdMS2t3aTQyNklsT2xSUlNkMmxmMHlrREVTVmZzK0NU?=
 =?utf-8?B?Rlh6L1VzUE11RXRNTFJZdXpsMS9VSWtBRkVLMmluZEtsRVFWK2paNUFUQk5N?=
 =?utf-8?B?ZytyL01YbTZUc1dyLzJjZmtGTDZjWkNWem16TENydGNXdHpBakNydytrTGRo?=
 =?utf-8?B?QVJxVWtvL3B1amwwSHh4bWlua3FiZWRRL0pXUWxQb3RpZEk5SWtyN0I4RDA2?=
 =?utf-8?B?b1lxNHhNMktkYzYwSTRobVpVVkNSZm5WZXFNOTBQdlc0eCttSVV1S0g2RnNO?=
 =?utf-8?B?ODhLb2xHZVZGVzM2bUNhdk5NMVhLWlVWMWxVaWNtZnptTHhidHBUZG45TzF6?=
 =?utf-8?B?TFRreEZpaER5Wk9lMFovV0JXeGlLY2ljZm1VVzBacE9TcUJmTkxsSDY0WWla?=
 =?utf-8?B?LytVSlJTamlMR1Y2NHJackw4ZW15YjVLMTBiWnE3MWVVcmREZU5vVm92dzRI?=
 =?utf-8?B?WVQzc3o0d2J5L08rVjV2Z0xwd00yVzVKZ00vWVdKQVVLZ3JvN005T0VrK1FI?=
 =?utf-8?B?NytXakRremlHZDFWd3N4eFBUOW9tWGYyWVdpaFI2eDMwaks1YTNteW5aQkxN?=
 =?utf-8?B?NkdKZ1hkU0YrWURNQ1V2SFNjelNkVUo5TVpoRFdFL29lQkJ0eStuOU4waWFx?=
 =?utf-8?B?T3lvUUtSdXNJclQ0dGlPUHBUNCtpQWlEd0tsdnNDNU01Z1pmT043aVRpbVdQ?=
 =?utf-8?Q?n2Qw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbb7a4a-5cab-4378-88e6-08dbc36a2ad8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:08:15.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgSxWjclp6dxLkNJWxvHQXIdBUoZPecDbHfeuZNC8L1CULvBqBWUQjfibq97VTRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/29/2023 9:11 AM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Use bitmap_mapped flag to check if range already mapped to the specific
> GPU, to skip the retry fault from different page of the same range.
>
> Remove prange validate_timestamp which is not accurate for multiple
> GPUs.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++----------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>   2 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ac65bf25c685..5e063d902a46 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -43,10 +43,6 @@
>
>   #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
>
> -/* Long enough to ensure no retry fault comes after svm range is restored and
> - * page table is updated.
> - */
> -#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING   (2UL * NSEC_PER_MSEC)
>   #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
>   #define dynamic_svm_range_dump(svms) \
>          _dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
> @@ -365,7 +361,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>          INIT_LIST_HEAD(&prange->deferred_list);
>          INIT_LIST_HEAD(&prange->child_list);
>          atomic_set(&prange->invalid, 0);
> -       prange->validate_timestamp = 0;
>          mutex_init(&prange->migrate_mutex);
>          mutex_init(&prange->lock);
>
> @@ -1876,8 +1871,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>          }
>
>          svm_range_unreserve_bos(ctx);
> -       if (!r)
> -               prange->validate_timestamp = ktime_get_boottime();
>
>   free_ctx:
>          kfree(ctx);
> @@ -3162,15 +3155,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>                  goto out_unlock_range;
>          }
>
> -       /* skip duplicate vm fault on different pages of same range */
> -       if (ktime_before(timestamp, ktime_add_ns(prange->validate_timestamp,
> -                               AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
> -               pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
> -                        svms, prange->start, prange->last);
> -               r = 0;
> -               goto out_unlock_range;
> -       }
> -
>          /* __do_munmap removed VMA, return success as we are handling stale
>           * retry fault.
>           */
> @@ -3196,6 +3180,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>                  goto out_unlock_range;
>          }
>
> +       /* skip duplicate vm fault on different pages of same range */

I think the following call means if the prange->granularity range that 
the addr is in is mapped on gpuidex already, not different pages of same 
range.

Regards

Xiaogang

> +       if (svm_range_partial_mapped_dev(gpuidx, prange, addr, addr)) {
> +               pr_debug("svms 0x%p [0x%lx %lx] already restored on gpu %d\n",
> +                        svms, prange->start, prange->last, gpuidx);
> +               r = 0;
> +               goto out_unlock_range;
> +       }
> +
>          pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
>                   svms, prange->start, prange->last, best_loc,
>                   prange->actual_loc);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 10c92c5e23a7..3afc33a3dd30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -125,7 +125,6 @@ struct svm_range {
>          uint32_t                        actual_loc;
>          uint8_t                         granularity;
>          atomic_t                        invalid;
> -       ktime_t                         validate_timestamp;
>          struct mmu_interval_notifier    notifier;
>          struct svm_work_list_item       work_item;
>          struct list_head                deferred_list;
> --
> 2.35.1
>
