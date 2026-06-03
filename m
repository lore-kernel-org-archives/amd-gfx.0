Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CB0CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 19:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE5D1122CC;
	Wed,  3 Jun 2026 19:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="arQYS1rd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0176E1122CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 19:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9fR+sja3H8tfJxwzaOcOqQnq/W27kY4aZl4EXrNZ0x/e78H/BIYxRj6afQ6TL5Q9pDXou2rGcCE3bJjIJesVpySqdboGjzM0DlvVAoinHWSLTUV2ov0h1gfA24G8dZyJSclT1g2DXpgdS+yS0U0zRjywnq7MKM4f9GtnUFGmBgNn9RQ+E8ohtD4hZQZdKk0QId5t/IGbJaLBDsFEhUxhADW1g9geGcUO2MGQLcjCAUJGDyxpeUrSBPobL7qwh7w0XU5BUlq53nKhcWQZB9Sx7FSFrhkl6z2XFGmF8+UPC8Wbby/wfG97imn+4Jbgv6e3xn41EdJX+IJ+ys8tnDrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4IZ23thYI1DTIYAipC9uC5PQVgGw8eyiUGIbC1n6Hs=;
 b=I4HQUa7ihHciWXcccYPtZwdxb/t/wX1K8NlrQcCr+6l0eqDNHZfyiH8McS3U/VkO1uttniIWPNMEF+lsGI5JynV5SEVMkCrlQAvvDOeJ1BbzaGbI1Bx1szRArNDfI0pJEm943VtHy+Z8UDV/fjnSpk/aTs3FH5MF9BTqI//gqVlWAl7u97MeccW5CsN2NVYCTZWJqGBA5vq8E2QUVCFZUOEKn/T9BrgagAo/ZpDyY4mPdd6PLShhc+KS72UiZfhriv9mWuZO6zVr/Sp0aPzeWguilnVEkrL9cJO4+92UfsBlsvCchonZz80ID4CAXQwGBThD/yFb1i0CNzOOaTgdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4IZ23thYI1DTIYAipC9uC5PQVgGw8eyiUGIbC1n6Hs=;
 b=arQYS1rdfbPHIKrHdDPlrAtosHY/ovn4D3W/vRXaizLl8jWCwdj5KWOiD2ptd4ZOzCzZNLuIuJJZV/XIwkrQnegoygfM8kBg0JQaAx82S7W9KauM6TBPLV/bInYedOSDDsZELqO1sp6VRhQcE6sZvfqsTUoYeIK9RXGoTwLCi2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:23:20 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 19:23:19 +0000
Message-ID: <50c48724-0e77-453c-9168-57ee35972885@amd.com>
Date: Wed, 3 Jun 2026 15:23:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] drm/amdgpu: fix the HMM range handling for KFD SVM
To: christian.koenig@amd.com, natalie.vock@gmx.de, honghuan@amd.com,
 Alexander.Deucher@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-14-christian.koenig@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260529114031.3714-14-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::7) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 4034322f-620f-4aec-b4f1-08dec1a591d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: QUeDTx7J7WPLOxe7Qdy/F7v/9RR9Jclj/Yogphe81+Zd1fLzIYXmHTJvNRunBYFTxUaPzxPXy+VNZqumpeyIOGhuZQVUnMMulZFAeY3BrBr7bz7SYBqo7JoF1Kq1XfBU6BV3q8bT2gRQibCq+20oQEpoCTFluH/451AGggS2qP9bM03DAySFGZE65kw/0Nlm4IEp97U83pOyuUl3EL5R2z1KYXsWXYSCRT8MNs9PHVwcYG63noHE1oy0k42VaKkjZEHaJVF2Aidjd8UL5NQiqTmTW6gi0vWdwcshnu2xVMBSUtZs+McfoV2is0jRogpDJMWyE5jfm655bUObJqOItwtnuDkOJ8Km4Yo9BOF1K6Y2GEnGWEOEyQTi9St/zHOXtnqTdlvjM7vj1VJs0Y74+BkLhitUX7fJLb0QiBJLR1K/zPbQzjv3jIfyf3Cv7IVc8IqGQibRjiigtJv2oC+MTcRoa6eyJz+wtl+dmzQlgmrJxZI2Fiku2sOSdscYkgP2mGfjof6jKYR8MB87ot80I4jB+wVv5JDJcdqUgaPij+xXNP7VsYrJ7GcK42R2pWjksIr5H0bLZRQUlP22E9N5WEVtrp7R6je1t8uJYgjwyMb0JzruRX5RGHZVLY4P1tMs8jLCFE7lUDNuLL5Uas9hAKmCAA5MEpdb+1nWvTKRlapOqhDDPO64BjBsxULTRYTl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRTMVJzbW9MTXRUZ092ZGFPMlBDOWpFZkVrYmZ4cmR6UnNkQXlybDBCWkRt?=
 =?utf-8?B?enNUYmFLdkc3U3Y4WkhabXpaSkVqbVkvSVdpY3NTUjIyN3BaY0hRRnptb1ZN?=
 =?utf-8?B?QUVjeXdKVU9mN1lHUlNPQ1NTNFVuUlZxZzFJdUJhN0dtN2ppaDBrMVVJS2d0?=
 =?utf-8?B?ZGd0MGg5QndBVkFjRHNvSDc0cnFDcWZDUmZqcHI0bmUrTXNmbmpuVlp1akw2?=
 =?utf-8?B?cVJvdk9VOE1qT1FPQm9DL2FLcGY1KzV6dWVoQkpFVlE0MVJzNFBNM1dnaUI3?=
 =?utf-8?B?NDZjYWFURTNlQUVaS1UycDVQcXVzbVdwTjFBK0VSeXdvQTM5UHNMQVljZWpR?=
 =?utf-8?B?SldWdytUc1RLOWpINlJYSy9Lc1B0cEN2RXBJV05mOXhXdlEzaTI3b3Z3c2Uy?=
 =?utf-8?B?Rkl5Z1lqR0habC8vYVFIclQ5OFhCTklVR29oelgvbUJuaFVCc0Rxa3h3NHdV?=
 =?utf-8?B?bDNYMElseXpOTUFJaGw0MTVkWWxSL2Zibm0xeUhNaFVCQk1vd3krVU1xQnRN?=
 =?utf-8?B?QzYrOE1KQ0lsZFpRNU1iNW9ldWhEUGxacmFKa3VXZmQ0Mm5hS1d6cFBFMnJt?=
 =?utf-8?B?cHpDTDhyUC84WVNvQ0dVSERyNUk1YjhQUVpnSGEyM2xvWDFnR21aamlUdWU0?=
 =?utf-8?B?Q2FuN1RoWUE1MUR1NEt5YVU4VGFZQ0tpMmU3eXVQNkZ6ZVN6WlpDSGFvMHoz?=
 =?utf-8?B?WE9TSzZMalplZ0g0dUVXaEhzTThwSWhjYjJtVVh1RFdPcTR5c0RSUHdRdmxM?=
 =?utf-8?B?OWt2d21ZVXdzRDl2T2VjZTBzSmdvUjZiNU05NXZMdTlyQ1JKMTVKOTJLOWFB?=
 =?utf-8?B?cTlwZldlKzVGS053OS9QVVRwYkpHYkUyZnUrbWtHMVVoTDE0TkdYajMxZDJu?=
 =?utf-8?B?M1pVZ09JU1NUSk93NVkxVHNYY0xzSXdlRVQrODc3VWliTU5Qdm50MHI0WWZa?=
 =?utf-8?B?NVBpMENwbDd2UEJSZ1FseU1XdU82T2RrWHNIazZPN3RtSTJLdEl3SkJwVFVx?=
 =?utf-8?B?MGdvcVloL2l3cmtrLzVLOXh1SnREc0pKSEx6MS9YaVIwZXFTOVlpZzJyMGlO?=
 =?utf-8?B?N1ViWWRPWisyZzhVVkNURndLRXYzd0hGdTQ5M2w2NjFqVzRiM3ZxT29wdHFJ?=
 =?utf-8?B?SElmUUF2QXlyWUtVZzFnWStZaXNtMmNWOEVTNmRqblZYUHJUcXczMVZUNEpl?=
 =?utf-8?B?RURNOUNVdC9SNkozS1hkbDZmSEs2ZjFwSkhuNnI2ZFBBVjJ1TCthNnU5M2Rw?=
 =?utf-8?B?d0hTVGxQdzhWZnRxSkZ5ekNaY1J5OXVzbTZxY2xqeWZybE9US01ReUNOWERl?=
 =?utf-8?B?K3Z3cHVRWitIOG5tVWhDbW1vOCtSdk9YaDkvdUVFeGxXcWF6QzVReloyb0sx?=
 =?utf-8?B?SFlyK0ZLbkxXOGU1eFYvcUVzcnpweklxRzEwem4wckhzOUpFUUlvMHIwOVNq?=
 =?utf-8?B?MmpuMHZvckNGV3ZZYUhFc21PNlF5RWNUSXhmb0NqUGFGQnpjbDJiZVNHNnNj?=
 =?utf-8?B?azg1V0ZGcWttaHNHQy9GYXJaMGpQQXU1anVQNk9Gd1d5OHMwcC9qc0kwR2Uv?=
 =?utf-8?B?L0V6VzNlTjNSY2xlNWE1aS96ekQ0RjB3OVIxMDhUQWFTeDRudkZ3djJVenBV?=
 =?utf-8?B?UVl5dVNQU2pLeU9ZS3VtUUtMaW8yZGR5UnhhWmxLTTlGRkp3SitaSnRDWk5J?=
 =?utf-8?B?N0ZmMlFFMWw3V2FveTVydmtucnlBVExpNkdjZEVzS1ptd2RiaVk4M1grMytJ?=
 =?utf-8?B?QnRWS0t5YjY4UlpuMmZsdFN3aTBKZjVCcHJ6TTlOYXpmRC9pRmJOMllmdmtJ?=
 =?utf-8?B?Q215RFI2QkhvRUc5TXFaaWh6ZXhoUC9oN2lTQUY0S2VGbHo5SFpHZ1FLM2kx?=
 =?utf-8?B?eGhRVklpdm8wRGRpTzMyNHhiYTl5QXJTaXNCT040OG05T2J0V1lnNVlaS1NW?=
 =?utf-8?B?eEVsM0lvV0pIL2JtVlJrNG1kTUhhMEdRRjNaa0JITC9lZFRKWHRrN2dXMDdS?=
 =?utf-8?B?U3UzVWtJMGVkVGM0TmI5cTA3eHdZd1lkN0k0VzFhYUs5MDhtZWNmeWhNeVMv?=
 =?utf-8?B?d0RGWm80YTM1aURBTmoyVWNhdmJWRndwakF5RFdyRzJuVnNXaEVsMFFZTGNj?=
 =?utf-8?B?MEYvUTZib21GVXFhQmQyREl1b0t0MEVYekNwYysrYjl4MnhOQ2ptOUxHYVJ2?=
 =?utf-8?B?cWhPMWNtYk9BcElFV041MkxVNGRIVGUvZTFXVWNlUm5QeUl4SXJZb0E2Qndu?=
 =?utf-8?B?TUFLTndWWmFRSlRPZnBxWGhTTExVZUthQTJUQWJPK0ExSEtMWG9kcGZ5Mko5?=
 =?utf-8?B?c3N4MlRsL0FsdDdPdjZMZWRjZW8zMklBODBheWw1UTJlVVc1d29jZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4034322f-620f-4aec-b4f1-08dec1a591d5
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:23:19.5469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulWqko/8QIUomWzLrz0RjvcSJWWCGBi3/OFPgyn0fSzHxmef1wp0S9T/dZLHcTlZwrZTBNW2NYnrxeBB9exSpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

On 2026-05-29 07:24, Christian König wrote:
> It's mandatory that we have this check inside the VM handling or
> otherwise page table allocation and filling PTEs doesn't work correctly.
>
> This allows to remove the buggy SVM range lock, but that's not part of
> this patch set.

FWIW, It looks reasonable to me.

Regards,
   Felix


>
> Only compile tested!
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 10 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 10 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 32 ++++++++-----------
>   4 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index d4e207db83c9..a368327cc025 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1093,6 +1093,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @vram_base: base for vram mappings
>    * @res: ttm_resource to map
>    * @pages_addr: DMA addresses to use for mapping
> + * @hmm_range: to check validity of DMA addresses
>    * @fence: optional resulting fence
>    *
>    * Fill in the page table entries between @start and @last. Allocate and free
> @@ -1106,7 +1107,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			struct amdgpu_sync *sync, uint64_t start,
>   			uint64_t last, uint64_t flags, uint64_t offset,
>   			uint64_t vram_base, struct ttm_resource *res,
> -			dma_addr_t *pages_addr, struct dma_fence **fence)
> +			dma_addr_t *pages_addr,
> +			struct amdgpu_hmm_range *hmm_range,
> +			struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
> @@ -1139,6 +1142,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.pages_addr = pages_addr;
> +	params.hmm_range = hmm_range;
>   	params.needs_flush = flush_tlb;
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1432,7 +1436,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
>   					mapping->start, mapping->last,
>   					update_flags, mapping->offset,
> -					vram_base, mem, pages_addr,
> +					vram_base, mem, pages_addr, NULL,
>   					last_update);
>   		if (r)
>   			goto error_free;
> @@ -1634,7 +1638,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   
>   		r = amdgpu_vm_map_range(adev, vm, true, false,
>   					&sync, mapping->start, mapping->last,
> -					0, 0, 0, NULL, NULL, &f);
> +					0, 0, 0, NULL, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 7db3c3577949..ec1196d390bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -459,7 +459,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			struct amdgpu_sync *sync, uint64_t start,
>   			uint64_t last, uint64_t flags, uint64_t offset,
>   			uint64_t vram_base, struct ttm_resource *res,
> -			dma_addr_t *pages_addr, struct dma_fence **fence);
> +			dma_addr_t *pages_addr,
> +			struct amdgpu_hmm_range *hmm_range,
> +			struct dma_fence **fence);
>   int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct amdgpu_sync *sync, uint64_t start,
>   			   uint64_t last, uint64_t flags,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 29c74920f3b0..d47951437f0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -26,6 +26,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/list.h>
> +#include "amdgpu_hmm.h"
>   #include "amdgpu_vm.h"
>   
>   struct amdgpu_device;
> @@ -72,6 +73,13 @@ struct amdgpu_vm_update_params {
>   	 */
>   	dma_addr_t *pages_addr;
>   
> +	/**
> +	 * @hmm_range:
> +	 *
> +	 * Used to check the validity of pages_addr.
> +	 */
> +	struct amdgpu_hmm_range *hmm_range;
> +
>   	/**
>   	 * @job: job to used for hw submission
>   	 */
> @@ -153,6 +161,8 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
>   	p->saved_flags = memalloc_noreclaim_save();
>   	if (p->vm->evicting)
>   		return -EBUSY;
> +	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
> +		return -EAGAIN;
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d0ea20dea3e1..d506afff684e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1432,7 +1432,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   static int
>   svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		     unsigned long offset, unsigned long npages, bool readonly,
> -		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
> +		     dma_addr_t *dma_addr, struct amdgpu_hmm_range *hmm_range,
> +		     struct amdgpu_device *bo_adev,
>   		     struct dma_fence **fence, bool flush_tlb)
>   {
>   	struct amdgpu_device *adev = pdd->dev->adev;
> @@ -1492,7 +1493,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   					gpu_start, gpu_end, pte_flags,
>   					(last_start - prange->start) << PAGE_SHIFT,
>   					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					NULL, dma_addr, &vm->last_update);
> +					NULL, dma_addr, hmm_range, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;
> @@ -1519,7 +1520,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   }
>   
>   static int
> -svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
> +svm_range_map_to_gpus(struct svm_range *prange,
> +		      struct amdgpu_hmm_range *hmm_range,
> +		      unsigned long offset,
>   		      unsigned long npages, bool readonly,
>   		      unsigned long *bitmap, bool wait, bool flush_tlb)
>   {
> @@ -1553,7 +1556,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		}
>   
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
> -					 prange->dma_addr[gpuidx],
> +					 prange->dma_addr[gpuidx], hmm_range,
>   					 bo_adev, wait ? &fence : NULL,
>   					 flush_tlb);
>   		if (r)
> @@ -1823,18 +1826,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   		svm_range_lock(prange);
>   
> -		/* Free backing memory of hmm_range if it was initialized
> -		 * Override return value to TRY AGAIN only if prior returns
> -		 * were successful
> -		 */
> -		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> -			pr_debug("hmm update the range, need validate again\n");
> -			r = -EAGAIN;
> -		}
> -
> -		/* Free the hmm range */
> -		amdgpu_hmm_range_free(range);
> -
>   		if (!r && !list_empty(&prange->child_list)) {
>   			pr_debug("range split by unmap in parallel, validate again\n");
>   			r = -EAGAIN;
> @@ -1846,11 +1837,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			if (map_start_vma <= map_last_vma) {
>   				offset = map_start_vma - prange->start;
>   				npages = map_last_vma - map_start_vma + 1;
> -				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -							  ctx->bitmap, wait, flush_tlb);
> +				r = svm_range_map_to_gpus(prange, range, offset,
> +							  npages, readonly,
> +							  ctx->bitmap, wait,
> +							  flush_tlb);
>   			}
>   		}
>   
> +		/* Free the hmm range */
> +		amdgpu_hmm_range_free(range);
> +
>   		if (!r && next == end)
>   			prange->mapped_to_gpu = true;
>   
