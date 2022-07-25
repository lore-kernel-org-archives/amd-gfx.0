Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F6CC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 18:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26752C148D;
	Mon, 25 Jul 2022 18:03:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197EBC020B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 18:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAj+99qeWVbQFuxG8ggmTgVmKpWa9TjLXciuaAqjCgzaGiQskQAoiRoNc1YNYLxqFLcP3hpCEBSE96LN/bsag6cBKvNkd0dr4fK9zw45VeKBCeB1WwCrj4i43KxNxcDSzBxpMH1+S0URHamc80CLVfAmQ9xWu0peSun+63xsUdv1AfSjDUxo8OVtekRztJ2ur51oU1gjDbN1yDZ3h+aiSkiIMYQWmJadpPhAUtlQsWDyA3ehAumekiyFna5ZAxa7ZWb8W233BdAt99cWFSh6T9/76E5u+9C1Si+Tkrp3XJ9Jr6pGbotHrdXno5nEkTcb3bexv0pAgyV/Sv8whMs2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMPP2JRxaFI1fa9MWuz7L2a06g/WU7R6tsW6GHiocg8=;
 b=BTdO32+s4HQv1kSPCh9K1I2KUCDGAp81dgvqJPKFqmZZujpCuBJAZB6RUIulDXvLB+LijyxOTNXJRYh6YuorsQNN89/pbXPpjQlcnJHxWdus87pjl8Qgb8nRWbNtJRd8luY7Qt9Ox+EfSqHzpqyYiDcfOJw3EgPtjMlT1xp1yaDd1ZAnoRgfh+8wMmEAeOMCHExgBUWjUnmthud4PDaOtg0HZjh0DwiqqGC/1zVKoGiC+9KdHy2dvxWJ6gLlDkcyT3X/qGLx4Z7OQ6fttfBvYt22en8FUCHVDOTZRkI7jWJDsqXbQYhVjN9M94cAPP8qKsGdJMLXZLOXwQHjYqj32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMPP2JRxaFI1fa9MWuz7L2a06g/WU7R6tsW6GHiocg8=;
 b=KIW2j8Rhnj13eUE3RcSDRfNeLb1738Ht9WdSLejoxbE5pFLlAs/NVgmWNc7gnnZ/LCkliDuawUM1WVfd4K0SKID95eVwQ+OFvg82Gpar/G4swRdBW+18IQQo6aiY7dblhhDtQIUNY/Dr4ZvT+aNSY2gotIV5060gKGHl0RISkJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 18:02:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 18:02:58 +0000
Message-ID: <3d31300f-4f32-1aa2-8c50-c2a4f79a6ca2@amd.com>
Date: Mon, 25 Jul 2022 14:02:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] drm/amdkfd: Set svm range max pages
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725171943.9155-1-Philip.Yang@amd.com>
 <20220725171943.9155-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725171943.9155-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f205e5-cbed-41ff-30ce-08da6e67e871
X-MS-TrafficTypeDiagnostic: SA1PR12MB5658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lYqGZp0p56GARbBwgAfmUE2vJKIi7Sp/OFeStn+t7+xuROMExjLtvyYf6p473F6EBRJ+hKYf/Xz5q0lvDqngFzhPepJszB8lK0ufAfyumw6GnvY1tqdj2UndQVkk3K9WkitV1OjJbE7tbOedYXY20rnlw5bIMdGsXWe7WLbqRdWvHmCD5NGrq0MfWb5eCqJJ2Ix91GCuAdptdiN+D2ZcplLZ5n9v2zKB+I5BTq414mP5iwl6AFj5mq5FS40UdUevM42t/UVvo1gME7oKLGwH/26g04aC1XJetJmXloGs+J/FAyqrM14K5P7lrGU/5Stewmp6Z8JGFqgMupAKoeKA9KIelpcM/zOyZjAfeUhdoY0lHksKZ/IeRej0zeURZpVjkP1Esu+6US0vY2hGCMNd8D2BOgcax9WJbWlxJDXasSjPXlL3xsP/jVxr1BrGp32CJZoJaQeUtAyO6LPVu8jXPrqI5cruwxdt11CMI96ZSB8GpD4ToNmhJvoKCjazjsA1tX/0JnDpkUnkQjk+PlbGekOhYWsNllYLCdVTNTyLkWr/H3C8VI+4c88a51LC3T7gfHn2qDKlXn/ROfsu9g+oSdEin21ySs529ypB0BZ8Qm068+B052KHvl3fcD2CtWNIggqVL//fdH0cOEybJKdxXpEip8Qf0NvJ3ot/maFiX2/0SnlmN4jpEY4WYpfgOgScUqNnW2vu01KvFuH6TUAuHkFgTEBvSkfnNuTzYYTdUCBTzxX0S7+XGKBPvKkxWyjXWqVifsdrE0Fp6Kl4NEBaiouJb6SZ/xN3b0ap3wUBf8BJXtY9fVsMf4vaOBhnEUwWWHjF4Jip/w+H95GNBpe8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(31686004)(83380400001)(31696002)(86362001)(6512007)(26005)(36756003)(38100700002)(8936002)(186003)(2616005)(316002)(6486002)(6506007)(41300700001)(478600001)(44832011)(5660300002)(8676002)(66946007)(66556008)(66476007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eno0NFNJS0pmc0ZuaFZwMDJEYVFIcjNuMVRpRm1uOUFvV0lTK1NVVFZNRzZX?=
 =?utf-8?B?dmY2RFRycW1mMUZ6TThTMHFaNWQyMlpwb1QzRTNiWll1QnI0a0p5eURoNm5W?=
 =?utf-8?B?eEJYZFlLMXhtTDgvaWRWVkZaRnA1TG5VdlZBZmdpRG51RVk3ZXM0ejFlWWVq?=
 =?utf-8?B?dmZDbU9YWjVPRGZBR3BRSjlEZ1dCajAwWUZTdDA3UGlhZmFVcTltYmNUaDM2?=
 =?utf-8?B?SXR5ZkVLY002MFFrNUlvckVTSmY3MG5MNkpRN1Q2WVpiTHdseWF6MXkza2ln?=
 =?utf-8?B?akJ0c1IwNUZvS2xxNksvWjRodjB0OWY4S1ZQMy9sS0tleTVKRFFOUGpMTi9Y?=
 =?utf-8?B?QmNPMlo3alV6QUg4NHVLWVgwOU9rMDEvQ2RmWEdHT3d3T1QyL0tVY3ovVW9w?=
 =?utf-8?B?Mkl6Z29wR2R0V29jOGt4ZDBVSjVsWE5URkRwUjV5V3M1a3dxelAzY21PVUpv?=
 =?utf-8?B?TklEQmVpVUpNT3RWM3l1bmE5V0MzZFcxY0JJNlQwdHNhbUdyK2hWcXZSZXFE?=
 =?utf-8?B?RDlzaktvdW93OEtac0RRZk44cWFvWnhLOThWWE1FZEh1c1hHUHo5TWVERVNS?=
 =?utf-8?B?cnVFMTEzTUpNQStLOTlONWhuVWhIQ1QyV245Y3RtMU5ldzRDeVdORjg3NFhw?=
 =?utf-8?B?N3JvSyt3L0ljSWh6a0ZZRkFaOGM4MlVGM21EZ2NDZHllQzdBTVdqU2FZRW5m?=
 =?utf-8?B?SE4rZ2ZUczJ0TjczS29RSXhiZUIyWEplSjRVWEUzdVlNSFhLUXNFbkJTWCtU?=
 =?utf-8?B?cG92cTI3VXdacVhPKzViUzZNVFAxdkVDV2hpV1VGZmZGVG5hVXFsWEE0b09F?=
 =?utf-8?B?aUZuQ2dDZmg1Q1ZBQXBSd2FRYUE1Q0RPNFNBQm0rc3BEZGNpVTNBdDcwY0No?=
 =?utf-8?B?YTZFQ0FGbXQ2eGxtUThHSjBwODd3MkVJMVM2Qy9CU3lHRGpENHpxYlp3NGlz?=
 =?utf-8?B?MDRZd3A0K3lHc3BWclhkb2RXUlBIc3R6QVVFY0hHd1BMUVBFSlM0UmllUlRL?=
 =?utf-8?B?anVBeEtOWlB6cnh2aVRGSVJiWlJkcGhTTjliVkIrQTdDQytGNjdmZE9zOFNw?=
 =?utf-8?B?N3J2NEgrRGZJTGdXTEtQdkJOREFTalFpdmM3VSswK2FCL25TVUVFenZocUsz?=
 =?utf-8?B?ZkRqYVFXeWZ3TXdMbkZyWnhsamFXbzBxWWxlUzlYMnd0bTFLQkdJY3p2d2tD?=
 =?utf-8?B?Q2pGODh2Q3pCajEyMXdvQ0M2aGZtdWdaMTlja1BocnFXbEtWK0RSMjlIeTZN?=
 =?utf-8?B?cFhhaDNOaHMvRlZhSkNGTmJzRit2MWFRRk4wTUhZMGhIaEwrbzNxV3RtakZL?=
 =?utf-8?B?UXpyQkJoL0N5Z0NMUUQ4QzRuelZrNDdUWDFzZyszWmd3TzZ5SGFDZ0FuRXBt?=
 =?utf-8?B?aWZobjFJUEZ5RFYvUXFzaXpGWXVKZ2tOZi9ac0d0OTNVRHF4Mm5NdnBtMVVO?=
 =?utf-8?B?WkU3UVpIR1N6OG95aHZ0aVg2dEFEczNUc0s5TU4wWDlVWW9vSERxak9FY1dV?=
 =?utf-8?B?WU4zdkZITGxkRUJ4bG5jRk5IaGZKRjdyakVsdVltWlIzNktGOEQyVnM5U29S?=
 =?utf-8?B?N0ZMdm9UNXJqNVV3UWxoWStUQnAyWEF4WFBQV2xHcXlXMGJLanBqdXpWN0kr?=
 =?utf-8?B?eE41TFFhZkFGRTJuN21ER0dCZ1UxK3NZTEtURnlDcWtMMjhaQU1NM1R0Q0hj?=
 =?utf-8?B?RVJmK2Q0dU4wZU9mbFpudlV2NDFwVWxvUjArbUhDM29XK243N0FsdnhhVGZz?=
 =?utf-8?B?bmpuaElRbERDbmlQQkUzV0ZNdGwwZ3RlTFUrcVlhUmp1SDBmME9TY2RQRU9w?=
 =?utf-8?B?OEZLbXpoVUtRQld1MTJjNUxUUUw5anRyMHk3NFc1TjIzN2FUMEFRNC80RlNK?=
 =?utf-8?B?VjVFQm1xUTUzQ0JVLzFCOGVSYW5oYW14OS9VbC9PejZDZGxEeTdBZXRSalBL?=
 =?utf-8?B?U0x4QzNEOTlUdXVSUUM5YUFLa1Y2RDAwUlhPSDlvYnF6VHNFYlRUbFordnc3?=
 =?utf-8?B?ZWVxUW9iMnVsYkxDQnhWSnB4Y1BNdWludzdydkRHMVAvUDhzSlQ0N1NzK0hD?=
 =?utf-8?B?dWlQZFA4WnFnUTBXZGRsN0p0NDdLcGxwaW5aMk5VMUNIaU9FL015ZFNNdmZp?=
 =?utf-8?Q?4K0FGleLEH5DZLP7EN1K1fHxr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f205e5-cbed-41ff-30ce-08da6e67e871
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 18:02:58.8171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00dHYnldGcz9ySnC6A95D3XktkCDUg00r2hPewy8hOjZEiYtag5SMHIx7wbueJ4NpCnmSg865qXIRf8mJ879rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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


Am 2022-07-25 um 13:19 schrieb Philip Yang:
> This will be used to split giant svm range into smaller ranges, to
> support VRAM overcommitment by giant range and improve GPU retry fault
> recover on giant range.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 19 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
>   3 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 9667015a6cbc..b1f87aa6138b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1019,6 +1019,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   
>   	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
>   
> +	svm_range_set_max_pages(adev);
> +
>   	pr_info("HMM registered %ldMB device memory\n", size >> 20);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b592aee6d9d6..098060147de6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -46,6 +46,11 @@
>    */
>   #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
>   
> +/* Giant svm range split into smaller ranges based on this, it is decided using
> + * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and align to 2MB.
> + */
> +uint64_t max_svm_range_pages;
> +
>   struct criu_svm_metadata {
>   	struct list_head list;
>   	struct kfd_criu_svm_range_priv_data data;
> @@ -1870,6 +1875,20 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	return new;
>   }
>   
> +void svm_range_set_max_pages(struct amdgpu_device *adev)
> +{
> +	uint64_t max_pages;
> +	uint64_t pages;
> +
> +	/* 1/32 VRAM size in pages */
> +	pages = adev->gmc.real_vram_size >> 17;
> +	pages = clamp(pages, 1ULL << 9, 1ULL << 18);
> +	max_pages = READ_ONCE(max_svm_range_pages);
> +	max_pages = min_not_zero(max_pages, pages);
> +	max_pages = ALIGN(max_pages, 1ULL << 9);

In the next patch you use max_svm_range_pages as alignment parameter in 
an ALIGN_DOWN macro. The ALIGN... macros assume that the alignment is a 
power of two. Just aligning it with 2MB is not enough.

I also don't understand why you do the alignment after taking the 
min_not_zero. If you assume that max_svm_range_pages was correctly 
aligned before, you can just to the alignment to a power of two before 
the min_not_zero call.

The READ_ONCE ... WRITE_ONCE is not atomic. It should work as long as 
this function can't be called on multiple threads concurrently. That is, 
it should work as long as GPU initialization or hotplug is somehow 
serialized. I'm not sure whether that's the case. If that is not 
assured, the proper way to do this is either with a global or static 
spinlock or with a cmpxchg in a retry loop.

Regards,
   Felix


> +	WRITE_ONCE(max_svm_range_pages, max_pages);
> +}
> +
>   /**
>    * svm_range_add - add svm range and handle overlap
>    * @p: the range add to this process svms
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index eab7f6d3b13c..9156b041ef17 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -204,6 +204,9 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
>   
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
> +
> +void svm_range_set_max_pages(struct amdgpu_device *adev);
> +
>   #else
>   
>   struct kfd_process;
