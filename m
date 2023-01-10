Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91D4C61DB3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 23:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D8410E68D;
	Tue, 10 Jan 2023 23:07:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96D510E68E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 23:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQOAFMctzK1Y33Ny3xWWkr0wj53YyaZQAADki6x/b8J3gSg68aklBXO+kSj+By6uQX5YjygjJM+pYnZskjlBZIavyPvg9GBE8jCWtYjrXshHsLCSKjcH6fABFSjGHEJ6QEjl+JTuArAdYTWny1BHkpvQPOL0mF2+owQryCp2Pg2ZymqAdUgC6FbM9xausEADHbXw/yaCgq8ORP1BUqDXndVTfWfcLHUnnGtpERGJkvOrYDHQold9bfEUKxrkQAV1dc6bk0DpeLxjhP1jHv104ZbPMbAXZMpVMncZQ3kuuMDSrU+geyVO0uWj9MPg1GPX6T1cFkTNhXpROF0uHM7AqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRn9YjhTyBumxJ9JnBcS/9E4JNVM3hGYoKqEmSBBXOw=;
 b=F4nXaxviN5kW7zv5KAna4HVuKXHzBHsHP4XikJohBSHPanblfSKtaEAWJBTuhSkhIFvjRVCDobxZZWxWYYkxCh0vX/Y5bkB4Dd/xI8SP527Kx3OvuB7kt/+AAMGTCYxPo4uTVikJvjdCG0eYomcELhkEWQQ4JDfVakDS57mjZYUiClx220/dDCF5D0TA42LQWuwwbhzQhiPGKJji6nWQvjKM5NtFJkmF4DgCsaMW8dMVJgby0bA9MLwigtM8HbIN3BBogRhwDQGXtxTzmbS9StGMPJlvitaOOP13QntPUV1uxDsmzMQ0A0PaQrG+04CUdF8HAH4WUlk50Z6p32XY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRn9YjhTyBumxJ9JnBcS/9E4JNVM3hGYoKqEmSBBXOw=;
 b=oKTvI4/qW1mx5vfbmRfodXS46NtYYOq+n0Xzx9deliG5Q4CbTbFeyb6pGbCJT38ab33k2NalMov9CgDo3g8rpAO4mic8r2umoVowYvKpI0E2bJ6zqM7eZyZnqwnIkSLxaWhSNIRj1rDCvg64Px0NK9zELXGBSVo38P7ZHNAwwq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 23:07:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 23:07:28 +0000
Message-ID: <5ff6f8c0-3dd2-d753-6d82-fc5ead2c97e8@amd.com>
Date: Tue, 10 Jan 2023 18:07:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4] drm/amdkfd: Page aligned memory reserve size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230110000112.29730-1-Philip.Yang@amd.com>
 <20230110224138.20271-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230110224138.20271-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0343.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5572a896-ca6d-4e16-4c99-08daf35f7194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8X4jmlmrNOboRVlGzSn/AAzgDF5FrxH8dQYjUG1AFRRJWjiDH1/+wQjRFuMPrhh6GmUD2pzn6Med0LZDQKt/7uDevx4Y5enWmYDiaTclOjnzRYegWVX8NRKh+eFFQfSfk+Yp8+zpE+4Uj2D1KnQkqdt/OwBshlp3m5bgcrqi5hkF2FkvAPC+1xO0jg56LZfjU0urJK4mWcoC0jDS0Itqijc3UADafoNfjmGBueJLbtCBGa3LgaFxNrSnd8QqFY2Qp1qvhjS7cn1aMxylggMoamLkrSqqbHqVUFm/Z8TFavuuBV3SyrtFsR1Ns9bO+rnt4u9/tpc8HJcLx3/Xqb5K+ZL5U+3K/tBTup/AcRp3G9iNYw77f+O6nh2QE03dGgSXPnHkOGSUBRp39FU6ufH2nFOzypjP2gTIT0/giWlUmNWyqpUk7+wHaK6bIOtVqtSaNbTj1MJUSE2buEYxdMDZbGrXIXq95k7kJpP2HsA/le3c3BpVymoLic1ArDtjupvGfsF+2ZA/4Egc18CdunqV8qU6203gkO+IYEHEb+5UXleR3vkh2TvaSyJM6WXH+lof6X+OxD5YqegQo/FTXXhWO0NkhjaA20u9c/6tm6EVh2chELrGOqGnv3cGVLR6hSt+tNDE2DKCSKdhxOsPoxLDPKEjKDhn2EzabwBF1csXD9Xe4oyB31b/Bo7LqD2wNB0J1Cc1nCsX/aGgahU4f/ECTKF5y0Y83m/SPEA4FgGYveE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(2906002)(6506007)(26005)(6486002)(186003)(6512007)(478600001)(31686004)(41300700001)(316002)(2616005)(36756003)(66476007)(8676002)(66556008)(66946007)(44832011)(38100700002)(5660300002)(83380400001)(8936002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm92ZGd3SVB5NC9FSzNaWGM5WjZtVEI3M25OQ0pUUysyMyt6Sm1mMlNjWXhI?=
 =?utf-8?B?Rk5ZNm5KQjIzWHdlajYvcHVCWTdvakZqdEhYOStqUnRPRlV3UjdWTHA4N2FU?=
 =?utf-8?B?dWU1MEhuVnFmYmdCVjZGc2I2V1Jtd245VXRyT1dHUmpxNFBwT2RhcWZ2WWto?=
 =?utf-8?B?STJqSW1UTkRNbno1bUZMOU56c2g4SnMxU0ZDSGJGWWczYzlTT1dqRCt1alFL?=
 =?utf-8?B?SHVGd29nMUxXNERuUTdTZWVibURuTTVXS2cvL1V2YzFRMVpxNzF6OW1KTHRU?=
 =?utf-8?B?SHk0akcwZXVORkM0ZXBudlRJbUQrOVpNOEQ1SGtmQkdIYkIxQjJPaDFvU0dm?=
 =?utf-8?B?MUp4M1U2NndJTHMrSjNBZUZpSHhKRGtTaFFwNlhtYUZFN1lZeWViL2tyWTBm?=
 =?utf-8?B?S0JldGpLWWc1NFF1aURMVWlVWFZNRS9uakNFMmwzcTZ1MDRWV1p0NHRwNExZ?=
 =?utf-8?B?Tm1TQnNCTHpZakg2L3hOa2hnN2xFYUVOd3Fkdjc1anhoc1VZalBKQkM3am9I?=
 =?utf-8?B?T1c2ZWVFWWppZjdHV2JUa2NYYlJacW9mNVpvSTJ2ekZiWDNXZ2d0VCtYcFJ5?=
 =?utf-8?B?SUVhcnF5NVRpQmdmMnZma28wVmdHVGpRYVJ2bDJxdWNTSnRPV2kwQXFGenlV?=
 =?utf-8?B?Z3pOeFVvdHJsaFdEYnQvN0hPU3VxVDZlVnhEaHNtQUlqOVh2UTlRdHhHSU8x?=
 =?utf-8?B?QlpoOXBMRUFTR2hYVUh0S3R1RUF6cUpZaU9pbTM2MTFhWkx6Tzg4aElMV0wy?=
 =?utf-8?B?NTQ3UWEzNlpQOUk0TjQ2L25IY3JZNVNsWWg1bnJuYjhscVovQXpmK25rNnNV?=
 =?utf-8?B?bXkwSXV5RlpNeWhLNnVGTHMzbWIrYzlqWHp6WjJlbld4Vk94ekVjTDFwQ0Jy?=
 =?utf-8?B?K01Ebm1IUUZ2WFMvSjdObkhMVXplY01CZkwwMUVacDJYVGJpK01LK1p6bThT?=
 =?utf-8?B?QU11TSs1ZktXdVFCZE5FOVlIYkJzZWozUkhFOUJwS1JvOEJUaE52aFdwOHFp?=
 =?utf-8?B?bkpVbW1aS0ZGaXR2ckdFR3N1T2g4bkUycUhqM3M1ZXV1K1ArMGZqaHZReUZW?=
 =?utf-8?B?U2U1U1VrZFFEWTdNK3RoaGlSZzYzZ05SRTI1cGU2Sk9qT2x4QkpKa1BieVMr?=
 =?utf-8?B?c1ZJQXFDR2FhQmVLczhtdVlEYUgraVM4K2lBQ0xRTjlNV1E0WlNwMkJXRnc0?=
 =?utf-8?B?TjkwT3J5a0UwOVBQTUVJeENkcDBQYWxxK3ZrK3FGSWdsTy9VMUs5aG9GTVo2?=
 =?utf-8?B?KzQvWFVFbFhrMFJGNzZQU3FrcE94WTdqSldyYzBObkxGZGxDSDBXcHVOLzVO?=
 =?utf-8?B?eDFuNDMzaFl1bzJ0ZCs5ZlRlaTdHK3A0RWZWbWlvMFkzRHYrdkZ5MUkzN3da?=
 =?utf-8?B?UnVkMkFlNDZ5aEpnOGpkVkxVWWQzMGJFTTAxT1ZzNmdKTUJpTmNpSkVDUG8y?=
 =?utf-8?B?TzQvOWxhcXBqYjhzbXdpNW8vV3ZiWnNEUnY4MmFFVHJLNXNFS1EyeC9PNlhh?=
 =?utf-8?B?N0RCMnZDQmwwTTdieVpMNzJGdSt5ZnlLY21MM3FRYlY4TURCazJHSzlJbFZP?=
 =?utf-8?B?dDB2ZDVDRy9wNTFKTjZqdG1EN0NDYXdNQjNLNTBia0JlOUF4ZHh4YU53UFVX?=
 =?utf-8?B?dlVsWi9YVmFUT001WDFlNDNJa3B0WUM2RHFBamxCSlY0OSsxSFBySWNybGpq?=
 =?utf-8?B?d1dZekNhNG9janFVb2NQZnhxS0x1ZzU0dDlRd2VZTHFQU1BmcjFndzh4akFK?=
 =?utf-8?B?WTBpSDhiVHBTZXBkc2pEUDNwLzIwWHp3Z3UxakR6dngrOG9XY29FZlpXbHlh?=
 =?utf-8?B?QVZKLzlpOUUrWXlBb0cvcnlidzlLSWNUbUhXbklhdG1JN2t0ZTc0TzRIYVdX?=
 =?utf-8?B?dm9URC9FbERRNWczdkhLUFEyMjZiR2x3eGlZVjRrVXkzTUVLVFZoWWRGUlpO?=
 =?utf-8?B?QnVwVUJvZ0J2dDFMU2lyVmpEcHpKR1ltdkxvTGdjWEF1emlLMzVNdTZNQzlK?=
 =?utf-8?B?alFpZmZ5V1QzcHoxb1ROSml2WW5GVHAwSHdHZmVYM0hMaStOeXA4MlN3a1VE?=
 =?utf-8?B?NllZUjNrQ2lIcVVlRTJLdjNhdnJYRHlpbDlDN3RHZ3IrcHY5UXIwUGlSSGpz?=
 =?utf-8?Q?/xx9x5T63y9e3LSk8pJfXga9t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5572a896-ca6d-4e16-4c99-08daf35f7194
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 23:07:28.1676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvTuSiDTDSFz/ufR6H3T02Ddl1a3FOCteGIWZ/glxLcYcpRfp85YO139wO8aHvrdKfyRxVakfoCBaaYgqc1J1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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

Am 2023-01-10 um 17:41 schrieb Philip Yang:
> Use page aligned size to reserve memory usage because page aligned TTM
> BO size is used to unreserve memory usage, otherwise no page aligned
> size causes memory usage accounting unbalanced.
>
> Change vram_used definition type to int64_t to be able to trigger
> WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
> accounting issue with warning and backtrace.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  9 +++++++--
>   3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index fb41869e357a..333780491867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
>   
>   struct amdgpu_kfd_dev {
>   	struct kfd_dev *dev;
> -	uint64_t vram_used;
> +	int64_t vram_used;
>   	uint64_t vram_used_aligned;
>   	bool init_complete;
>   	struct work_struct reset_work;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cd5de5e08d2f..6f236ded5f12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1598,6 +1598,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	struct amdgpu_bo *bo;
>   	struct drm_gem_object *gobj = NULL;
>   	u32 domain, alloc_domain;
> +	uint64_t aligned_size;
>   	u64 alloc_flags;
>   	int ret;
>   
> @@ -1653,22 +1654,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	 * the memory.
>   	 */
>   	if ((*mem)->aql_queue)
> -		size = size >> 1;
> +		size >>= 1;
> +	aligned_size = PAGE_ALIGN(size);
>   
>   	(*mem)->alloc_flags = flags;
>   
>   	amdgpu_sync_create(&(*mem)->sync);
>   
> -	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
> +	ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags);
>   	if (ret) {
>   		pr_debug("Insufficient memory\n");
>   		goto err_reserve_limit;
>   	}
>   
>   	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s\n",
> -			va, size, domain_string(alloc_domain));
> +			va, (*mem)->aql_queue ? size << 1 : size, domain_string(alloc_domain));
>   
> -	ret = amdgpu_gem_object_create(adev, size, 1, alloc_domain, alloc_flags,
> +	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
>   				       bo_type, NULL, &gobj);
>   	if (ret) {
>   		pr_debug("Failed to create BO on domain %s. ret %d\n",
> @@ -1725,7 +1727,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
> -	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
>   err_reserve_limit:
>   	mutex_destroy(&(*mem)->lock);
>   	if (gobj)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6d291aa6386b..f79b8e964140 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1127,8 +1127,13 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   	}
>   
>   	/* Update the VRAM usage count */
> -	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
> -		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> +		uint64_t size = args->size;
> +
> +		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
> +			size >>= 1;
> +		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
> +	}
>   
>   	mutex_unlock(&p->mutex);
>   
