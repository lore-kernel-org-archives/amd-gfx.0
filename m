Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291F0C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 18:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA21A10E162;
	Tue, 10 Jan 2023 18:33:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C44010E632
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 18:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPKaqMssD9RBZOzehvoMzw9w0Kk5hSplKDtc/aYUwZuYWpCG8SxNDFGtN7b2lcdRThA2qgtt9WGqB+JtdpRFFNrzL0qghzPjxTDNs5eAoLkhJAHTcOyUvNha7mqHJAtnddUk8NNot44JRZMqH5ffgb9TTSIg2BgvAU8q6z1E/cTkQ6NjnvlJ9wGp/+NxC6fCLbjnfI+vFhMnHtq28rJ5gwAeN5qOsGmfP8s8OxtQzbaTz5dcrvaWx6UFwuSLcjGAYiUetuUgfK5zi4Xst91nmVdpJ8wOy08x0XcSqtlIunIBD9GSSY9oMKby8cpTLVcW6SGsHITI2e3OM5TG4RfySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35zLiUZGRsKNj+C8AzIU/RdSiL+Ps7QuDIf+6B3y3Nc=;
 b=A6o/sSllWmGGPL7OSDi/mSnE3qpA6XzANKp5+uz/7XrsmuVuCDH7Xh64ylSwdytdvSaD64WckLfKQANd9JQY+/TeAjjsSKxuZKbomjqyq57rRwfBOadSbeea6dGBZCDd42lJ7I+QUD9nDrjlFrnAZ7fwYkW2sRt5hWQBzAZB5iIIfo2w3N9NgV7azybuH2cRc0X5tVSTbHpu1jhqRCmniL4vIo01r8B+TbNsnFra1+Qo4yzRLxZcwdsrQy0CY0C+KanWc/+oxE3ZjOwsdlzorfpbmnrXra/sLCp7+UJNpECQZ7Gu/k78T7IvE6WHt4iNJGQGiWn6SHTK1OyJypZ7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35zLiUZGRsKNj+C8AzIU/RdSiL+Ps7QuDIf+6B3y3Nc=;
 b=dnTtpfdlAyrNvvzzP8djgt0TgLV3Ew1Yy+BFkVjWnoYcladIGm50/Og6VNqpxuFrOkXyB0ORI0DuDHaMisdzDkvRcHD9BicBEyYvURuICXV/CljoNBzzEJ8QaUpF6m3Xexi6x6KDEA/QV8I2iiPig1gAVFvAY+egKs+vJv+ze9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 18:33:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 18:33:08 +0000
Message-ID: <d5d4c442-e7d2-5319-56b5-6d41edb9f375@amd.com>
Date: Tue, 10 Jan 2023 13:33:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Page aligned memory reserve size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230110000112.29730-1-Philip.Yang@amd.com>
 <20230110171122.10380-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230110171122.10380-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7eb535-f58c-435c-e31c-08daf3391ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kxvlyr0rNQBVKUZs3hNQDPAXxvPGz+IJ0NetCVJsoDuNNO3fVmcNsNT9nrV9uWzGL0UgUu4Y0L6Ksbg9EeTncFeygPfLZxaAeBnMbITW9oowJi4EWaE3i6xGk/7m/1TK9m2Aii7TEC7njp8TssyAabhzBTNC1Fu3uFG2UMoP2HKexjj5mtNPpLLNr2Mg7lSMwUKtzBAswzicinZQjqhryFoPabdeEPhuuCjFMbyaKdbRemS+EgS+UmpmG5n3IKqItbuRmYw5LFvd/SzyFK339rliAyFueoqTAZgbKBPaGEWiRVDBUKXDPYS0j8IcrpQ44Pfvwl7r8yhrOnmhdYn3cNobIoYAL1IjtQZS9Knm/3Ll9xkd/OkySegCoEDe4Yk36Sn6RbitntzUcg/LkFpsquJbK9U1yfKD/RLC2X5V6VJkxp/CyrQOQH2eOLvLLmaZKUPntvSAyIGWHaEh9dNYQMTlOKuS93QkE6Z9bqMCzZCY3MV1vQoLnKMqjRO592MLYcdtGVBr1mX7yF3VxT+FxZUR0bK2bEi2LSPZaEd0w0ctHh4LDrNqiTEb4OCO2t322KuJeCiwhSVnvLp/IJsvIaHuOfitsWN3UwnsvShaPhtHFPKo2e7BQmeJ8FxkJRdTCT5fac6pjiSfy3vKV7eoHDtCgUeS5tpq4jeswi4ZaxWAtgj29k678zxF7k0+uZ9FG1fvBwaZeQSGJ4cpMA8VXRMq9uIhTrqHJA6yfkPaCW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(36756003)(66946007)(2906002)(66556008)(8676002)(316002)(83380400001)(66476007)(38100700002)(478600001)(6486002)(26005)(6666004)(186003)(86362001)(6506007)(6512007)(31696002)(2616005)(8936002)(44832011)(5660300002)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3puSmJKV2VuUGpzYnpnckFvZ2lSQkFSNFZtbGxZVUVEbzdVTHVtdjVTYkQ2?=
 =?utf-8?B?aDdXdC9wUVJicWpaYWlsa2VOeVEremVnZWwwOWQrWTFpUllSM3VFYU5VZndC?=
 =?utf-8?B?VG54MmpmdnQ4a0UyanlkcDAyWFhKR2NyK0ZNa05HZ0FTNTlHenNxalRkZUNi?=
 =?utf-8?B?Ty9GVE9xbXJzTzFvTjg4YmRGdDA0U3NYMFNDUC9UWmFrdExxWkpRVU1wNTFU?=
 =?utf-8?B?UjU4Zk4rSnRKMzM3M0k1S0hDbmVHdkh4U05pT0EzYTlrWXVqeWZ6L010NWdy?=
 =?utf-8?B?L1RTNmxIOWRRa2J4aVdnR1lSV3lPWGlVL3J4L0ovOEY1ZHlFanFrRHNTL2lT?=
 =?utf-8?B?VUVKNnRnZUV6RG1kTkJWd0ovR21mNDFRTkgvcE5waWpxbzR4K0VwWEFZcWJU?=
 =?utf-8?B?NkJpdG1WSUliUGhDY0gzejdLWWM1S3BFaGI3V1dDVXVIK0NQMW9mcEphU0tz?=
 =?utf-8?B?TDNUcEljRVZPWlRtV25ldzZlRi8zRFpPRDJhNTI2dEdZazdjeGt1T2M2OFR0?=
 =?utf-8?B?UDlmOXBlRnJyZ0lNYjNoZDBNaUJzZXlEbldWcGRxbzlYQlNuTm45V0p6ellp?=
 =?utf-8?B?MFB1WXB1bXZVU25qM3FZRkFodkVrMU9lcGwzSnpnblptZjBVek5XLzR4em1t?=
 =?utf-8?B?Tk4zV1I0Y3RlelArQ1duOGtaSnpZUGcwTGpkbUdHVmI2WDE0ZlVrNndOeVNN?=
 =?utf-8?B?aTV0cmlqOFpCcGUrWWF2a3h1d3MxU0tvZmZPeEUxZkJKOUE5R0tPRUpONDNu?=
 =?utf-8?B?V1NkdDh3TExvY1h2VWFvenZabEhrS0dnZkVLVlVocTZ4blk3c0J1cmQyNFU4?=
 =?utf-8?B?ekdHSms3QmEyanFCb2svdnpsMmIvMXcwRHAzWFFhUzJ0VnM0aUUraER0WGpi?=
 =?utf-8?B?bEhEcGxsWWlMZlhWVXpNcjlrUm5JdHRxQ05CNkNkelJZaTYxbkgwVmpGUE1t?=
 =?utf-8?B?VmdhalUxemhGS2F2WmJSOEJBSHV3WE9GUlQ4bzlzQkdjNmdqeFZ5RG5yVkRX?=
 =?utf-8?B?bERWRVVqcE9zNEhNdUhkK3hpa0R0U1o2R2VkQjVHcWMzL0Z0Z1hzZnU1VjZr?=
 =?utf-8?B?Rk9KaytvQ0xaUEx5Z3hQUDBkWklrYmlyWStKS1RNbGFUREhVOGJBNGFwQlI4?=
 =?utf-8?B?NVBmZlovNmtZZGtCcDgyaXp5SmhseGhkQVZsY3JWZ1A3N3gwQ2dXWGZXSHVp?=
 =?utf-8?B?U0QxajZ0Z2pTVTRYV1BvVWdwdmVyUTcrVW5Hb2htRFhFMTNYa0prcmhZSldx?=
 =?utf-8?B?UmRJRGY3LzZJd2FNMjFXcjRUWHlMM3hvVFJad0cvNzJNSUl2OVFWV1FXRHEz?=
 =?utf-8?B?c3BEd3FMVURRejY4eWVFeE15Mi8reEF3djNsd3BkOUJHY3FLZ2hzVklwdHhl?=
 =?utf-8?B?cnllVEZURDJOdjU5NGZuSTFYODJqSGg1UTNHejh3SHh1dFNnbytrUFZQMXpQ?=
 =?utf-8?B?WTJSeTA4TE55YzRxbmxHQ1Z5d0toQWZJc2dXMGY0cDVEdDNoUnlFRUFIL1hR?=
 =?utf-8?B?S21UdkU0aVZkWGdvNmFUMzBYL0hNSXFkeVYvNnNqcXhwVUJBVTQ5NW93NVJr?=
 =?utf-8?B?dUJJS2UxdFFLckpEem1ZOEtrT1hGS1Z1bS82RmNLOGRCb3RIeTBEMHkwMHpu?=
 =?utf-8?B?RlE4QWFLWmpTZ0p1TEI1SThzdDF6cmQ0SWhKS2d2aVVZZ1dxd0FHMElBOCtw?=
 =?utf-8?B?dTRMQzhTK0FkTDZZWktramxUeVNoQ2FBemE3SHZiRGVidDcwVmdMZkh1UjNm?=
 =?utf-8?B?TEc2SzdMTmREdWRtajM2Ky83Zm9yUDRJWkVVb0lHZlpzY1ZERnRyZVJleG1W?=
 =?utf-8?B?ZVpuS0cweTJrZDZlbERYTHZVenN4Tk9BcjkvSTN1WnNaRmx6NEIremNzZTZl?=
 =?utf-8?B?RnlMdUlvM01lUXRrbmJ6VXhsSDUxT2N4N1NJeTZvMmp2cmp4WWNITUZpRkxM?=
 =?utf-8?B?SUVCejBNUDJEZW0zL1F6aE9pQXE2djdjUjFIZDZFVk0wTmxPbXBYOHp5ejdW?=
 =?utf-8?B?MEVQcWdsWjZqeFZZcnovS1dVTEFzeWRuSjcrK0tyOGxIcVJONjM3QXFFVUNt?=
 =?utf-8?B?LzJ3QUhlUG1tcHo5MSt1N0NFRk1YdnhrajMyQitZKytNaHJHRkpxTjFhUFdQ?=
 =?utf-8?Q?OcK5mqDEfGjrU9IGaJz64xJMT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7eb535-f58c-435c-e31c-08daf3391ecd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 18:33:08.3403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOI2f88weNFYWu2lvU0E+Y+X5klsPhxBtEzS8lPDsPrbBo4UGtyNgPJ7FpJOpYOadmEATVs+8Yp01ANNrZw/QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

Am 2023-01-10 um 12:11 schrieb Philip Yang:
> Use page aligned size to reserve memory usage because page aligned TTM
> BO size is used to unreserve memory usage, otherwise no page aligned
> size causes memory usage accounting unbalanced.
>
> Change vram_used definition type to int64_t to be able to trigger
> WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
> accouting issue with warning and backtrace.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 7 +++++--
>   3 files changed, 12 insertions(+), 6 deletions(-)
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
> index 2a118669d0e3..7efee672bc41 100644
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
> @@ -1653,13 +1654,15 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	 * the memory.
>   	 */
>   	if ((*mem)->aql_queue)
> -		size = size >> 1;
> +		size >>= 1;
> +
> +	aligned_size = PAGE_ALIGN(size);

Why do you need a new variable for this? Can't you just update size to 
be page-aligned here? Is the unaligned size still needed anywhere?


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
> @@ -1725,7 +1728,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
> -	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
> +	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
>   err_reserve_limit:
>   	mutex_destroy(&(*mem)->lock);
>   	if (gobj)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6d291aa6386b..e11451100a20 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1127,8 +1127,11 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   	}
>   
>   	/* Update the VRAM usage count */
> -	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
> -		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> +		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
> +			args->size >>= 1;

This will return the updated size to user mode. That's probably not what 
you want. It may be harmless, but technically it breaks the ABI. It 
would be better to use a local variable for the updated size.

Regards,
   Felix


> +		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(args->size));
> +	}
>   
>   	mutex_unlock(&p->mutex);
>   
