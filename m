Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D024B103A9A0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 02:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C23C10E6BE;
	Wed, 25 Mar 2026 02:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PJrr5TmU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1F110E6BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 02:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy3FeTOcUYn/2GNV5seO5ncO5rUblbqY12DZ0wNY4Nc7dr/wtHs6BeDT4++241qfudXLSljKu4mlnKyfqB542hJx43qrpPte6xW2SJFrvo4xRC6usJNHt9n+C+laANT9SyTsdTd1s3PAKJJNfde6v0nandlSFHI7fdWVSSHSqCxM3WTTk5NqTcHr433Gja68nP+nB6BPEF18QMVWoM9Aa+RQiuaGIlu8BA5lnNL6iaw3/7lVH/+XZeGWWIq8ZF2mxXfMiZ0SjArcj7DHqGHadfdR/ZEJGO8O3OICwiwBGnkK0MYPRFHz1CPyYkHEOjiyirklJlP9U/ZvK2+mdkaZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG58vLiYiAZ4yK+nyjeG4tuknG+r2MqsUkrAZ6BxD+k=;
 b=SAPKC9YxBPjrVoRjcrM54vkVdD3FyGC3vO8zAHMKpsYTEVQVqEroK1JU9XWboXcu/7Ps2VkNqtl68UzOWcc2yACNqg2RUNBBhTgVORCblCJABuOLtC1PWT8TJ6sSjJ4c7oKhXZtXUmeMPKA7Llmhh/cyWKDP8tMriPiwThPf+UFC8Zn9stwH5iz+wfpg1JgwsfvcbuGEQT7/Z8cUYhBPlnpt4CzscigXc9MzY1bLqDhJRJHxOcijV28CA4O1HCtmSk0ZgbfYfFzcAkrCVTU+mNZzxv6324XIgdKxOQ/NJYYSN26b9Ctc4mgVJ3/yxqASdoWrqvWorVE1WxBwX1fwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG58vLiYiAZ4yK+nyjeG4tuknG+r2MqsUkrAZ6BxD+k=;
 b=PJrr5TmUJRP/8rpNPsBDaA0ccBM8oBsH6JOa+p5Eq0a7WPUYmZPwdVQ+afZ3DPsc+QdXcnilREqanrG0nj0es0ceo9xrEaAWav5dCII8DlWkEZnALSkp4El0eJtd44qJy7BZnjze/3O3+uYdSPvdxBf1TEpyA52x4qa3+yx1xxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:58:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:58:33 +0000
Message-ID: <8f8d5d6b-ce50-42a7-a556-b878ca4a1fc3@amd.com>
Date: Tue, 24 Mar 2026 22:58:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 5/6] drm/amd: Fix MQD and control stack
 alignment for non-4K
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d4b7297891badff6bc6030c71e51dddc27c54451.1774239489.git.donettom@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <d4b7297891badff6bc6030c71e51dddc27c54451.1774239489.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 6624bbeb-cf6c-44ae-894d-08de8a1a66e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: DOQmjs93PCjxSwHqr41SLhtiW7QPJhFYGA+FXUKyVUo1NsU65QOM/dMIE09Q9fsHIQFi79eGYshVQgq5eo3/YL/2/4VKHAJkuJWIniZHVHH68MXgAlqeh1oYVFTYnadEczDAooYrbAXOPkcbGpuJhxh4LBzj1vvf0s7Pt9evgny5fFcHnAmVrgMVhKLxKfMD+ga35AlvnU7RjrXTbUy/tag6DPmx8v9ZMOhiH12yxUoy9EoK42ydbR/x0rvKL2350uqZxrCQ/iMDr4HLsJGaPD2p/ACj6fzO3RBtAnn7ORAoEubdrObxIBO0BK/txr9+ty+KrYRFCPIVkikIkwmV1dKF7+puBTjMY3IM9Pm9YnIRQJmEJKomW2QQUybWESmXBo+p5NiLVwWoOJXqBZvDIsiRD6CvGp0GM0eUUBxsMs5vplqARiNhwnhyn2Dke8Hx+HvfxmfnNwyqNBpkAO8R+EibXF0KjHTnE92VN/fViSUlBVaNoZJtXIgO/zwjyj/6/NRUw2IRKjxOppGAQcCBepvJjPgk87kRDqTc5d1DrctDs2Sk70wLskMxNTbq2qVLPmSIwsEyzNIfmjJPDEt3sNIyGPLyyi2v7xCIMLXJPJ/VI4MAc/qdRNWNEC6qXYzqgbWf3dxTOdisXoZJA/ZorsIT7K6oQ+ygFKIBCNjYnbU7D2/OOlEA8WUPwqfd/tnD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBub3dkdGU1ek5FempBV0tmd2pNTG1aSjUrSUlSTStuZUk2aktrSFJKK1R4?=
 =?utf-8?B?YmdYaE9DbnBpeDd6N1NSUThxclVwQm04QktXYkovTTdYdHhzNlFhd29aVmkw?=
 =?utf-8?B?eXlBRVREZ1JGSGFORGlxN042bkRHeWc4T3J2aE5iTFEwazhQdjhpaDgwMktp?=
 =?utf-8?B?QVFPYmdvdyszUmJBVzF1Sk9Cb0Z1UEM3Wm56REtuRDlad2FXRSsvYjRkcEhT?=
 =?utf-8?B?NXFWOGxkNkRsdm5lQmhueU91Qk8rU3oyUXlVVEhYSlIxNE5UMnhHVGlKREt0?=
 =?utf-8?B?RHIrNVJIOC8yYlM2Qk10SnBybTB5QW4yeHd5VE5CU1U1MXFHNGpqaGNubm0x?=
 =?utf-8?B?Q2dPQ0IxY2VsNk45emthanIrVU1IUWRIbVRhTEhxR1lQc096ak5xeE1LMzha?=
 =?utf-8?B?cXFjVHNPeGkrNjZ4SllDZGNMbnJFUXp3WGhhcVJCMEIzY3FUL3lHWjdBL2dv?=
 =?utf-8?B?U29hUFRZMndKcmpMZ3Frak9memxNbnA1YmYyVXd2VGgzS3lGbHUxL1o1dXlB?=
 =?utf-8?B?cUorY0ZRS1p0TnVGR3hGczFHUlE4aHNsZU95QWlXRm9rN3ZpVENMdTBvQU9O?=
 =?utf-8?B?NDNkUFhqQml5K3YxZTlUVG14WUpFbmJwbnIyRGQvZmtPenlRb2h0L3VVREs5?=
 =?utf-8?B?U1gyRy9FSmpBa3dDMUlxZ1JrRXFBYm53R2tSWjhqYkVxUG5WYzNySTNRUXpR?=
 =?utf-8?B?cFg3UG5PbXJsaUE5blNuY0NmZ29zR2g4WXJpVk1vY1BBTjF5d2o5cmNXQlI2?=
 =?utf-8?B?aSt3VUtEOUNSWnZGVC9LZXVnZzlZbXYyTWw2dGRnVGYwWCtBeDd1TjFib1FT?=
 =?utf-8?B?S0pJTkhjU2RVVEF6UmhWNzh3dWFxSnl5Wmx4ZWJWQlJUeW5oeit6Rk1rVnNi?=
 =?utf-8?B?RnVRNGVvYUtQUWRBZUJpL1lBR050L09nd3BFeFBoY2lxOVVUdUVMZVdZNjhw?=
 =?utf-8?B?YVQyN2lMTFRKRC9OakZGcDg0ZlpZNS9aZlVhNDN5aTBpNXBLQk5yN1FQc0Jp?=
 =?utf-8?B?d0dpRDh0VHJJNnd4dGlJQUZrdEhNbFZGQjFXcU9naXpCWkh0MTRUYm51YWNX?=
 =?utf-8?B?OE9YenQ4Vi9QYkpXMDlwa2NJT3laczBpakpqWHlNeDk2RUFNOThDU0RERE5E?=
 =?utf-8?B?bmVDQjU0NG5lQmRqK21CWUtjZWtxbU4vbDBDcW1KRXpnb0t5YUh4Qk9VN1lm?=
 =?utf-8?B?aXBVRnd6Q2p3dE5xTUZYQWhBSVN4aDcvRHFjdm90SW1sOHRBWk5qTXB6Mzcx?=
 =?utf-8?B?bkxNb1BNRXd2b2RheFdsdEpjNEN3NHRCcUdDVUdnd3JGc3dmWmR0UGlxTURJ?=
 =?utf-8?B?L2hqc0dZMWNuRkgvYlYvUFh4V3l2VjFuNnYyU016eFd5VTMzZDlRZ2ZIaWtI?=
 =?utf-8?B?MGltZnZEVWlkUiswaEFvTHVha1kwNEFXVXZ5WWFVaGlnSm5vbVZQQjN6L3Ix?=
 =?utf-8?B?NHVhRnNsR1lHQVJiK09oRVVZUk5RYzFvRkt3eFJ1UzE3QUl4WWxXaXJGd0x3?=
 =?utf-8?B?a3g0WWl2REFHamt3dkkxOExEOE5jVHNSUDJKVEJQenBBcCtWMko2VFVpUTdk?=
 =?utf-8?B?R1J2enc3Uk9xM0k1K3JkTURJMHdMSVZ5VzUrdWNwS01uckdGTzZCemMrQUk1?=
 =?utf-8?B?Z1B5SE5VdytFWjlqUlpHVkZ4bURJcE1VM056Z2tGY2pDYldwOGlyWlNGZ1Jy?=
 =?utf-8?B?V1lOZFlPclk0d3k1M1c0cFA4ai9ETmlZdlZVak9ERHlRUmtQNDVUNmx3K09W?=
 =?utf-8?B?WjZqTFRZclBIUHFFb0w0c21mYVoybFM0N1BMQ01ic05sOXBWQXpncTkrZGV4?=
 =?utf-8?B?ZFJMc294OWZZaWpnWXZWVUhSN0ZabVdXQjdaTkcwbVgwcTFMT3REVDBSc2Zy?=
 =?utf-8?B?cFQyRGxoZEl4dldDMzBXWjg3MWtrZEg3UjlwVXE3bmpVR0JzeFNKZDAwWlhn?=
 =?utf-8?B?M01aNVlUVG1HMnp6N2U1WTMrc0I4WGwrd08xRDdGZlk5RzJTK2taWHJrMlNh?=
 =?utf-8?B?MHd1cngyRGhMQkFtZEhjaW5sUDBzWW5kWWU4YW1VRmNPb1Y3eVhLODZ2c1RC?=
 =?utf-8?B?TjEveHNERmttYlVzeEN1M0xjSUxYNGR0NG5tUlR3aWt5QnRuajZyR0FzQThu?=
 =?utf-8?B?bGhkVCtMdDMrRzhzazd1bzVwa1F0RTRUVy9sV0JER3NCQk9wSkptRmZtd3JM?=
 =?utf-8?B?V0h2cWlGL24zOHpBbVd2Zllab1BCZGVybUkrZWpRQ3VSaXFMTm8zeURRQ3Q3?=
 =?utf-8?B?N1k1RTVjOG9UOUtyWDVzNXFUL0k2VVpkT1dkSTVjeWx2dXhISGFrSlB3V1k5?=
 =?utf-8?B?cERsUnFYeHlkZUhMdHNvUHFmdUozbnZSOFRPL0Z4diszRENPSUtHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6624bbeb-cf6c-44ae-894d-08de8a1a66e8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:58:33.4814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Oqe/DS2FmDhmj61ew6x3IadtnaEvdsQAKxvycuwv29qPrFfhJmjRZigkenwPGshgOMGWtUnLPHuZHmpmS9moA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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


On 2026-03-23 00:28, Donet Tom wrote:
> For gfxV9, due to a hardware bug ("based on the comments in the code
> here [1]"), the control stack of a user-mode compute queue must be
> allocated immediately after the page boundary of its regular MQD buffer.
> To handle this, we allocate an enlarged MQD buffer where the first page
> is used as the MQD and the remaining pages store the control stack.
> Although these regions share the same BO, they require different memory
> types: the MQD must be UC (uncached), while the control stack must be
> NC (non-coherent), matching the behavior when the control stack is
> allocated in user space.
>
> This logic works correctly on systems where the CPU page size matches
> the GPU page size (4K). However, the current implementation aligns both
> the MQD and the control stack to the CPU PAGE_SIZE. On systems with a
> larger CPU page size, the entire first CPU page is marked UC—even though
> that page may contain multiple GPU pages. The GPU treats the second 4K
> GPU page inside that CPU page as part of the control stack, but it is
> incorrectly mapped as UC.
>
> This patch fixes the issue by aligning both the MQD and control stack
> sizes to the GPU page size (4K). The first 4K page is correctly marked
> as UC for the MQD, and the remaining GPU pages are marked NC for the
> control stack. This ensures proper memory type assignment on systems
> with larger CPU page sizes.
>
> [1]: https://elixir.bootlin.com/linux/v6.18/source/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c#L118
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 16 ++-----
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
>   4 files changed, 64 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index ec911dce345f..4d884180cf61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -403,6 +403,50 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>   	drm_dev_exit(idx);
>   }
>   
> +/**
> + * amdgpu_gart_map_gfx9_mqd - map mqd and ctrl_stack dma_addresses into GART entries
> + *
> + * @adev: amdgpu_device pointer
> + * @offset: offset into the GPU's gart aperture
> + * @pages: number of pages to bind
> + * @dma_addr: DMA addresses of pages
> + * @flags: page table entry flags
> + *
> + * Map the MQD and control stack addresses into GART entries with the correct
> + * memory types on gfxv9. The MQD occupies the first 4KB and is followed by
> + * the control stack. The MQD uses UC (uncached) memory, while the control stack
> + * uses NC (non-coherent) memory.
> + */
> +void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
> +			int pages, dma_addr_t *dma_addr, uint64_t flags)
> +{
> +	uint64_t page_base;
> +	unsigned int i, j, t;
> +	int idx;
> +	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
> +	void *dst;
> +
> +	if (!adev->gart.ptr)
> +		return;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return;
> +
> +	t = offset / AMDGPU_GPU_PAGE_SIZE;
> +	dst = adev->gart.ptr;
> +	for (i = 0; i < pages; i++) {
> +		page_base = dma_addr[i];
> +		for (j = 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++) {
> +			if ((i == 0) && (j == 0))
> +				amdgpu_gmc_set_pte_pde(adev, dst, t, page_base, flags);
> +			else
> +				amdgpu_gmc_set_pte_pde(adev, dst, t, page_base, ctrl_flags);
> +			page_base += AMDGPU_GPU_PAGE_SIZE;
> +		}
> +	}
> +	drm_dev_exit(idx);
> +}
> +
>   /**
>    * amdgpu_gart_bind - bind pages into the gart page table
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index d3118275ddae..6ebd2da32ea6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -62,6 +62,8 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   		     int pages, dma_addr_t *dma_addr, uint64_t flags,
>   		     void *dst);
> +void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
> +			int pages, dma_addr_t *dma_addr, uint64_t flags);
>   void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   		      int pages, dma_addr_t *dma_addr, uint64_t flags);
>   void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 67983955a124..e086eb1d2b24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -855,25 +855,15 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>   	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>   	uint64_t page_idx, pages_per_xcc;
>   	int i;
> -	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
>   
>   	pages_per_xcc = total_pages;
>   	do_div(pages_per_xcc, num_xcc);
>   
>   	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> -		/* MQD page: use default flags */
> -		amdgpu_gart_bind(adev,
> +		amdgpu_gart_map_gfx9_mqd(adev,
>   				gtt->offset + (page_idx << PAGE_SHIFT),
> -				1, &gtt->ttm.dma_address[page_idx], flags);
> -		/*
> -		 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
> -		 * the second page of the BO onward.
> -		 */
> -		amdgpu_gart_bind(adev,
> -				gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
> -				pages_per_xcc - 1,
> -				&gtt->ttm.dma_address[page_idx + 1],
> -				ctrl_flags);
> +				pages_per_xcc, &gtt->ttm.dma_address[page_idx],
> +				flags);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index dcf4bbfa641b..ff0e483514da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -42,9 +42,16 @@ static uint64_t mqd_stride_v9(struct mqd_manager *mm,
>   				struct queue_properties *q)
>   {
>   	if (mm->dev->kfd->cwsr_enabled &&
> -	    q->type == KFD_QUEUE_TYPE_COMPUTE)
> -		return ALIGN(q->ctl_stack_size, PAGE_SIZE) +
> -			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE);
> +	    q->type == KFD_QUEUE_TYPE_COMPUTE) {
> +
> +		/* On gfxv9, the MQD resides in the first 4K page,
> +		 * followed by the control stack. Align both to
> +		 * AMDGPU_GPU_PAGE_SIZE to maintain the required 4K boundary.
> +		 */
> +
> +		return ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_SIZE) +
> +			ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE), PAGE_SIZE);
> +	}
>   
>   	return mm->mqd_size;
>   }
> @@ -148,8 +155,8 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
>   		if (!mqd_mem_obj)
>   			return NULL;
>   		retval = amdgpu_amdkfd_alloc_kernel_mem(node->adev,
> -			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
> -			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
> +			(ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_SIZE) +
> +			ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE), PAGE_SIZE)) *
>   			NUM_XCC(node->xcc_mask),
>   			mqd_on_vram(node->adev) ? AMDGPU_GEM_DOMAIN_VRAM :
>   						  AMDGPU_GEM_DOMAIN_GTT,
> @@ -357,7 +364,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   	struct kfd_context_save_area_header header;
>   
>   	/* Control stack is located one page after MQD. */
> -	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
> +	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
>   
>   	m = get_mqd(mqd);
>   
> @@ -394,7 +401,7 @@ static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, voi
>   {
>   	struct v9_mqd *m;
>   	/* Control stack is located one page after MQD. */
> -	void *ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
> +	void *ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
>   
>   	m = get_mqd(mqd);
>   
> @@ -440,7 +447,7 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
>   		*gart_addr = addr;
>   
>   	/* Control stack is located one page after MQD. */
> -	ctl_stack = (void *)((uintptr_t)*mqd + PAGE_SIZE);
> +	ctl_stack = (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
>   	memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
>   
>   	m->cp_hqd_pq_doorbell_control =
