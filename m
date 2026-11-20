Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7D606A692
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t/XrZv1T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E2B112D3A;
	Fri, 20 Nov 2026 21:28:38 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833B210E348
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 21:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ7hMkU1EES5ua/SlyxKWoHVMCCrW5Y1Wr/0fBqiZzwEs+QcJ9gUGPHuNpe19hQxSUuhzdpLh8hprvw8tn1tp5KBQieSZqpYW4GNDIhizwBoAkyV+5unr6g6+uYDHs8oNSc50DFcNZ1kBcI6oL31i1fCO9+QpyrY1xua9MHyxO1ylE8RC1tl7d8LJVB3vPZ9KFXHKGU2DVCMsvZ7gXf2p3g4WNlmg3Zu3tIg8N+kzuZBstgt/GsZYtumteOjlllarVaVni4PWuyJy1IsHlN4PxBYyqaHkCMyl+uQwWRCaPQjQpiiO8/KYcmRNZtrbnRTC1Lv2JCAZU0AyoyQ3hGHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIVg+KmdOULtyvX9w3Gpe54fRoI87SNPOeN+si2A+Ek=;
 b=M2K4LTZxumdH7RNjDlrddoZuggddKqlaUN70jQy4Zx0WYD+wdKNxjQbcVpHEZBep9xcLpzQfW7dI7Adzzs4l3Qs5741VtdPneYmtvWiy5mxLXpb6rX5JGnDn5DdjujLIlBcJH6U/9ExPsQJ2GIZJAN349feZj+pcXkZPzFVBzZ74uUCctDnL7wIZnUmqkq760W812CA7/KPWz7MKu8nK1F7KYrHSovm2jSL0G1v/vBnsH+RLcy0EJuElVO9C39AB76v0ftG3weHgQPgc7m82oaFXYAPfaIiiPOLDVBUu/NKjXnXoQvubaW7fIzpJIBEJ5tGckm2Z4VFrziaICD5DRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIVg+KmdOULtyvX9w3Gpe54fRoI87SNPOeN+si2A+Ek=;
 b=t/XrZv1TiXZpNoEt4D0k/KJg/eDss19p3qFvDbwCFeHxXjUN/5JaYS+lGQJYQB+HYgcx8XCGaSWhniPI4wJ4qDVIdE/Ql7hpX4MFIFHUTRLdcE4qujaQYIXB4nEhh7GBwHT7dYqpu+BCwyiRyK1fTo8aO/Mck9rWHxRWy9jro5A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8SPRMB0063.namprd12.prod.outlook.com (2603:10b6:408:242::10)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 21:28:27 +0000
Received: from LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0]) by LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 21:28:27 +0000
Message-ID: <9dacfc65-7554-466e-bb71-63b853386278@amd.com>
Date: Fri, 20 Nov 2026 16:28:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: limit userptr sg segments to half of
 sg->length
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, christian.koenig@amd.com,
 philip.yang@amd.com
References: <cover.1795014593.git.William.Palacek@amd.com>
 <5a6eb18599b44e0457abdc9d54a00dbb0060f10c.1795014593.git.William.Palacek@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <5a6eb18599b44e0457abdc9d54a00dbb0060f10c.1795014593.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::18) To LV8SPRMB0063.namprd12.prod.outlook.com
 (2603:10b6:408:242::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0063:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ad4965-04ac-48c4-47d8-08df474d36bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|261022105027099003|4143699003|56012099006|11063799006|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: anBIu0hK9R17rI/bMmsZ8/QgNgiPHWu061UHSXEP8HxrZNtvu3Pa2eYA1XcA83few+ZqiSqrrkSptsLKl5nSEN0hGUbHYkGR5qbDywbGXNaztUJAZbGYM+dv9NzjOSlU61RQm206gzfcvNL62XnGktyx+gLrTUbeaGRjenfpYnnFDnS/l7Aramq7XdFObBuMm+7qnpw7bj7WTG7G68nWAOqIlLxSuEHPKyfmkj8b506YSPQACnITofE+y68M8qbgX98siLvP8brtv1xREUvGsYFnn1PNsGSllW6gOHboVJvqW0FleHfM9m9DvcdAtzG3htbq62GgLKlf2rszqT2WdoEPOqK9mmgvHUhaLL4IGSeUn0Ds8vGB2U2rMzBWdQ4dvAtBwsu8wJ4ZUU437/qjiiKzvi3n5NEadsitGEVK+SQJgcNjPO9Dmi4dzc6vK8dfxk0AWwPvCMCI2aPopvzqnQ5jrTpSQJmIPCLcA0OiUNXWeTarRTdULe58/KSv/HD0rRHtFOlRzqK2V6qEWw/KPTeXk6EZ2rc8tTeJLwXxYVzPbDfJsqtQ2QYS1ME1+WEFkixrc3ZtyDGikvUN2OEnVVrSQdFGg3c39gmTFn404oFx4wEupwCiAylWN3RuxJHj9NLHHP/4kVq6H9i7dU53+6rhvUDmamq8bKL3pG3XsaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(261022105027099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXduZTh1YzluSU5VQVYrejk0ZEt0NmFNU2E1YnU4VE55VXpPck83eVVlZC9h?=
 =?utf-8?B?cWY0Wm9VdU9qak8xMGV3MWduZnFkZTlkS1FMNkxVbENTWEEwdEc2U2EzQXRk?=
 =?utf-8?B?NDVRbU1kdEVuaUpPemJxMnVGcDFTdEFMcTM5eTBUSnlXVWVwczR2SkxvNVNh?=
 =?utf-8?B?Q1N1dHFrRFNyZFFNRU5oSWF3M0pHS0tJKy9mTEFXYzRhcEZIWWlDaHU5Nm1J?=
 =?utf-8?B?MzB5MytUeE5mcFFSejhPZVJ2dXV1TmEyM0ViaDhlamVzUHNGL3B0K2hVSkRR?=
 =?utf-8?B?SlVlZ0lrSU9oZk9RY24yNmpLNUdVMTI5MmhWb0FwbXRMeG96N1hDRU43UHZ5?=
 =?utf-8?B?YXR0TWI3dlpLVnFmMitVOGs4UW5WajRnY25wMFl6cHdUeXQvNFFtQ0ZlSERi?=
 =?utf-8?B?LzJZZ2xqbUx5YUFMRmxQZld0eUk0ZWxPVVY5d3JXalg2d1JTL0pCMGRNRmgy?=
 =?utf-8?B?Qyt5b0ZuWVhVeVc0OUtnNms5WVE3U0h0WXZRRzMybG9mUy9JUVhhbHlmVzNy?=
 =?utf-8?B?RjIvcWJMS3lGQ3pjNHpnZW8zdGFXQ1dMUkl5MnFEcUREVjFQd09RQlN6SnNX?=
 =?utf-8?B?SThya0tJN2wrUHpQcWdjSGJFcTZ4KzUyalJ6MG45L1Z3bzhaL3ZIZm1sQmVE?=
 =?utf-8?B?d3Rkci9tTzI2cFhRMjZwd01KQ2RrWkZpNFBrbGthVDhuMzQ1M1BLT2hJZG1L?=
 =?utf-8?B?a2wza1puT2ROWW5jb3pKaTEyblBZWUZYdUs4emFRMnFzYnQwMFpISnBiOXBo?=
 =?utf-8?B?QUsyamhYTzdNZkRlaVNJcG9oK1I4aGg4V3BFeFZVYk1iQWlwbVM0aFRFNzhR?=
 =?utf-8?B?Y3NJa0s2TStWWXg0S2lhdURuKzdaVXE1SDlWVFpuL1FHQmp1Q1RVeDN6Sys2?=
 =?utf-8?B?L3J2NEpUSDd4MDJOL1hoM040aFl1blNHSlNXYXhhYjBlQ2tDRE1NMU9BYWs1?=
 =?utf-8?B?V0hXQXJzVXZZN2NYWDdLcGdZeDVBa2JoclRoN25zV1luSHQvaHUwbHI4eU1C?=
 =?utf-8?B?UEdBMU9CUjN3L3dnR3U1ZVZ2NFhrVUNCaHFXbEhJQ3h6WTJKeWxPdUwrMFNh?=
 =?utf-8?B?WXlDa1lUOWVpV2RuWVpNWC9WY2draDliYkFrbHdjRTFvME10b3lDSlAxWXYw?=
 =?utf-8?B?Vk9XbkJ1MnY2a1B5SGJwQjd5bUNRd3NOc2FPQXAyWGtsNkhrN0Y4Z1lPNVh0?=
 =?utf-8?B?R2tsUlorNGhNUEpuVHVSVFQxSWo1dHFkSWlKTHFjQnprRDZaTGVjUXBMNU9P?=
 =?utf-8?B?U0dhemZQS2hFd2s2aFRaeVZXdDc4SGY5dExBaHd4Nk5wRkErdThjcHRkcFVh?=
 =?utf-8?B?YVFoSTJOeFZjcUFLaUFFM2dxQk1hYm9tQmd6TE8wemtFTGE5ejJpdFg1a3U4?=
 =?utf-8?B?blIrdVBtWnRoZ3krM0dNcCtPSFBOcjFLOWcxZU1RUTdPSmxORXFtcHlmSlF3?=
 =?utf-8?B?VVdjVk16SjQ1U0FLaTBXS2l0MEUxTjRJR2J1SHkrOVVmaS9jd1M2Rk5JVmsz?=
 =?utf-8?B?ZXViZ3FESEVWVUo1cGxyK2loZVZ5Yk0zTVhCM3lPTW5TVzVOcnhsVGlpZDdK?=
 =?utf-8?B?MllvZERucElhUUZUb1BiQ1M3dS9VU2VFejBiSDUrT2pIYTRodVFqMHZORExo?=
 =?utf-8?B?WjQ0MzFNYjdpWnYycE5IRW51bWJWWWhBWFNSb3RkRVpLcVJwU3FvU1ZKeGtt?=
 =?utf-8?B?T0Zpd1RRVUcwT1Vra1JSNXBHbi9RUEphN2lWcDlPVEFMSHkrb2M2NTJnUFIz?=
 =?utf-8?B?UWFMd01CcXMvY3hhdkNzZmtOZGxvT1cxMzhBNzJ4YzA2NGRyUlhhRzZ5NGlI?=
 =?utf-8?B?QkZuMHJhaURMTWFmNTNybXNrT2JmNWlwV2wwYThBcXQ4d3JXMkkxaXZmajJI?=
 =?utf-8?B?MmRqTjRDRGhCNlMzWm9ZUGxQN2d2cFoxbXczdEk0SmI1MHFZeW9nWmcybDRp?=
 =?utf-8?B?TUV2Yk5DVTdxQ2R4ZkVxRjc5cTQyRmNoajhGNFBjMmQxYjhyaGhaR1NLc0FG?=
 =?utf-8?B?OXVzVm9RT3paaVdvbFBXV29pbCtWd3g1QzlzNnB3UjFIcTg4bmJKNkFCb2Rh?=
 =?utf-8?B?WnlkTXF1aG1LRTZQNXlIenIwNFBSNisvNk5PUDR0YktMekxIelk3QzdaU3F4?=
 =?utf-8?B?d1o3WDZKVE5PbnhiL3JhSnRmRXlheC8reG9vY3BsZzBFWkliWmlaWjB0aDYz?=
 =?utf-8?B?d2hiUUFQWGN6WHpQWEVnRGtXMU5pNEhpQlVDaWR5L0hGbDF4QlMyQzJ2WHE0?=
 =?utf-8?B?NjE1Y0RqRkgzTDRubjNGc1dpLzBCYm51NHU4L3Q3Mk5JM3hWT1ZwYWlyeWVW?=
 =?utf-8?B?enRub2U3dDR0Uk1JbkRsL3ZNa0txelF0K29GYzd6TzJibTBmNm1ldz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ad4965-04ac-48c4-47d8-08df474d36bf
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 21:28:27.2675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOYuWumhtr1IucfFSQaRItIvk4IRLF1Iz943rDhN3qLD8kZFhHaF1eOBwRsDUkVFBEd/9IvMJqdh53J21UbCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-18 10:10, William Palacek wrote:
> Userptr sg tables are built with sg_alloc_table_from_pages(), which
> merges physically contiguous pages into segments of up to
> 0xfffff000 bytes. iommu_dma_map_sg() pads a segment so that the next
> one does not cross the DMA segment boundary, and adds the padding to
> the 32-bit sg->length. With two large contiguous segments the padded
> length reaches 4 GiB and wraps to 0.
>
> On kernels without commit 1c8f6308e557 ("iommu/dma: Catch scatterlist
> length overflows") the wrapped length makes iommu_map_sg() map less

I recommend you don't mention upstream bugs that are already fixed, 
since this commit is meant for upstream. Your patch seems to be 
applicable regardless.


> than the allocated IOVA range. The IOVA is then freed without
> unmapping it, and a later map at that address fails with -EADDRINUSE.
> On kernels with that commit, iommu_dma_map_sg() returns -EOVERFLOW
> instead. In both cases a large userptr allocation fails to pin. On
> MI300X with the default DMA-FQ IOMMU domain, the first 32 GiB
> hipHostMalloc after boot built 16 segments of up to 3.7 GiB, mapped
> only 15.7 GiB and failed.
>
> The padding is shorter than the next segment, so a padded segment
> still fits sg->length when no segment exceeds half of it.

This statement doesn't make sense. sg->length is per scatterlist entry. 
Do you mean "no unpadded segment exceeds half of the 4GB maximum size"?

The commit headline is equally confusing and should probably also be 
reworded.


>   Limit both
> userptr sg tables to that, as xe does in commit 1b1d3710380d
> ("drm/xe: Apply upper limit to sg element size").

The XE commit also change a call to dma_set_max_seg_size. You're leaving 
the call in amdgpu_ttm_init unchanged with UINT_MAX. Is that an oversight?

Regards,
   Felix


>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          | 7 +++++++
>   3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f060b206c255..565ecd7e012a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -589,10 +589,10 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
>   		return -ENOMEM;
>   
>   	/* Same sequence as in amdgpu_ttm_tt_pin_userptr */
> -	ret = sg_alloc_table_from_pages(ttm->sg, src_ttm->pages,
> -					ttm->num_pages, 0,
> -					(u64)ttm->num_pages << PAGE_SHIFT,
> -					GFP_KERNEL);
> +	ret = sg_alloc_table_from_pages_segment(ttm->sg, src_ttm->pages,
> +						ttm->num_pages, 0,
> +						(u64)ttm->num_pages << PAGE_SHIFT,
> +						AMDGPU_SG_MAX_SEGMENT, GFP_KERNEL);
>   	if (unlikely(ret))
>   		goto free_sg;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8dfa92967b63..b0672f1747ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -837,9 +837,10 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
>   	int r;
>   
>   	/* Allocate an SG array and squash pages into it */
> -	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
> -				      (u64)ttm->num_pages << PAGE_SHIFT,
> -				      GFP_KERNEL);
> +	r = sg_alloc_table_from_pages_segment(ttm->sg, ttm->pages,
> +					      ttm->num_pages, 0,
> +					      (u64)ttm->num_pages << PAGE_SHIFT,
> +					      AMDGPU_SG_MAX_SEGMENT, GFP_KERNEL);
>   	if (r)
>   		goto release_sg;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9856a2fc2d08..da7d7621aad1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -44,6 +44,13 @@
>   
>   #define AMDGPU_GTT_MAX_TRANSFER_SIZE	(1ULL << 22)
>   
> +/*
> + * iommu_dma_map_sg() pads a segment so that the next one does not cross the
> + * DMA segment boundary. The padding is shorter than the next segment, so the
> + * padded length still fits sg->length if no segment exceeds half of it.
> + */
> +#define AMDGPU_SG_MAX_SEGMENT	round_down(UINT_MAX / 2, PAGE_SIZE)
> +
>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>   extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>   
