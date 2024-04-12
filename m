Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C270C04FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 06:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2C910F24E;
	Fri, 12 Apr 2024 06:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1h4MPeTb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7DF10F24E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 06:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdzWWM0g2LrHQC34UXOV3r4tnLmcJJzvcdOiCUUJ8M4zaSMSIa+AaY7p32gmQbxV+nEg/9qArGflJX0f4YdIyc1IIaHQkp30dj44G0eAaZ2aIhwwADOpQXKea9WNb1RpoZpvd5NgPDqVtmGty/1pUfnLnPxQ6e0BGsqSSDNkNMfYs+hhsqrOGbibKJvodOfM1m7VEFkoz9jZKI50y2anmROliAmwRY+wdf94F7rq1+G2pxAltMhpkWLGp6UFYHj+3flFPugaVqgRUFEUo3uZf+MaN+M//F/07dYlsSU6oMxQ5mu3ic/FZfXeaceWRvAatlXpi46lJSgV3UFVnyECOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ElJB/DjZy6V/M+RawuuSljl6/L75EcgzzTebjf3Slo=;
 b=k00Z7s25j1du9kgulQn2g/iViSMxg9svPW88oBTL1Tk2SwPxq1Rbb3eNxi1+fauMJKAMOIZWFM+29Jldxf9gib4TmXSAnZHhgXjYcTa5G1ygxIh7s7zPxag+e3/OgFGiL5AUKrjfiEBNoPgPVnSYRApTjcOVD/NoUiADw6pSbTg8lyQSomjBKqC/FRVFy86378oa0UbD5hWTN4Pfr/NsZZwMoCCH7TRhGBidriJJTTfV9IQ0emMg/dlEDLiDB86gN4LoeSfFjezL/YFdyXcfczhqn5Try3jrCtKsbbh5d39FqhQvHOwAVB+n2VNn/7xrGVEF+Ya7nyidiDkTFgya3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ElJB/DjZy6V/M+RawuuSljl6/L75EcgzzTebjf3Slo=;
 b=1h4MPeTbSPmmamm+kRTfZTwlBZE6xMtbOQO6Y2YgpMZr6Jw7u4iM1jeGQuaW3ObU1hu6owXbGydQc92u1syNk6bYSfug5Q+hozlQdY6LNN/Fl8cfJqW2YMtMNpW+4Xv4SbYIlNF8rB9aNhZZggykJ5vHyD41y0+VxS+Kk2kDQ0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 06:59:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:59:11 +0000
Message-ID: <8530104b-5857-433a-8bac-a718f1595d3f@amd.com>
Date: Fri, 12 Apr 2024 08:59:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of bo mapping
 operations more clearly
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, jannh@google.com,
 Vlad Stolyarov <hexed@google.com>
References: <20240412064722.5549-1-xinhui.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240412064722.5549-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: a72bbb3a-d03f-48c4-d6a1-08dc5abe0e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNr7fpJoaSSd6o3UxVuLEfxtwzXwd+5XMaMYDHoiC3iMAYoQ2L0mlTUBjtj8QPR8LoaQGxBZDAFimv64iyGLObgZAs13NXBo8wSjjwFOUmTcRLZqp6gw1dsw5eLlDuOAHDIaMcWOs5YhHAstPKmbu4Fmy4eyQa7JOHNgw+k+BLIVQFvuf2xrTI4gEZgTuGZnXmcPZHn0tlMgLf7nCYh7rjyC9ssgbT5kKcGfxDM0gElp0Cbv+HkurH1zvP2IwyhHxVIoC7oW0CBqcJ9ZI51/6VEIgFoAkFnvCv9l6dTgrpqA5d/E03/P/3MXTVdfnMqZpsGdYLLqKu20SLy1l5e9rwTRxTBgx9PdCFyqCY/HQgmch2DKwIWDUhs918wj1vYfwlCqKljjggHEgnJe+zOFDLGgTQ/i5mKSkEjuSd7+zM9XCf57RspgXV5LBHHXzcVY7cH1MZjkcMxRhFF8+6aR4DJ2NVdDOWXHQcGDWAEeamWFugW3DS5ZsRBijNHAZFdPaVVPxNSHsnYjHnsTxoHgEvdWMMwc/sANW8jgFSDTqUjTDwRpm/lB7FfvDKSSnapxYpgH9nMpdtjMMbeNVWTt88EyxiwyZERv19HYYh9rjONir5l27xajzOpoLdgPflINqi/L71sqpeMs7CkWd/E+NLfjm0K57gDwfay7q8qM5a0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlGV3MramZUVXB4OC9lNm9YaUZLdEZNUnB6MkV1bHlYRmlrWTZENW9jUXd4?=
 =?utf-8?B?UWk0bWlJTm1sM0hVbmYwaGpqbDBHSUFEa0w0aG9nTkpjTXBIanJiNlBJL3U1?=
 =?utf-8?B?ZitQT0JlSmpIUXVrMnNXd2lkeTRmL1hmMEdlUFFiK0FhWTJzM3hYYXVUdGh5?=
 =?utf-8?B?T3FEcEtzMHVJTXRPdlR1SzhGTHo3WXRoM3RnQWo4c2dCdkV3V3Nsekx2TGVh?=
 =?utf-8?B?Tm5pcGF1TEJsTzhoL0FVZXcxc3NtQ2VGc0lnVGZURGo4blRtVFYzdkJPc0Zq?=
 =?utf-8?B?dWFtb3BjL2JSZ2RXWmc5TitBMk9Fb3YrT2F6enFkOGxhKzdRTHB2OUwwL254?=
 =?utf-8?B?MkErNUJxM1M3VEU4WlF5QXRkRzkrUmJYMnhwdXZvU3ZaVDVvOWk2VUxMNWxn?=
 =?utf-8?B?d3FIV2dCUnJzQks5T0M4eUN6M1d2TjFXc3FJUG9oeVgySURqdlBmWkl2VHh4?=
 =?utf-8?B?Q1ptbmRuZG5zSkdrUi9IaGZEN3VwNlFIelFaanF0V3Fzd0pDVmhFbUxWZU41?=
 =?utf-8?B?QXdkaFRDeElwVmlqNTJtRUVLT2FKSWlpay9FZXFSK2xWN3dKUW1QMWdjbHU1?=
 =?utf-8?B?b1BoZ1pIUmZLRDBHVVFZd0Vyak9UcUwyeUFGM3NaNFV2VWpKN0dVN1pOSVNr?=
 =?utf-8?B?aG5QOEc0czFqcW12eHpCNE00clV0WkZ4M1dFTGlaVnJBWDJ5N1hZK01NNjZv?=
 =?utf-8?B?bnllR1JIUDRJUnYwenlHZ1doOGJhWWFLZlhnWFhPbEZYaVRKR25adkRJUDR5?=
 =?utf-8?B?Ly9FUVZXOVlSV3dzampTTTErOCtjbXdlNUVYejdJL0VpUEt2QzNodGtUYVlO?=
 =?utf-8?B?ZWR3Wnd4VnJtVS9Bb0czQ09Nb0RPQ2NiR29USWlZbEJkcmFpMHBQR2dPdW1Z?=
 =?utf-8?B?L0Nuc3pmcW1XTVFja3N2bkdQcE9LTWx3dHFqaTQ3SVdodU5QQ1hPaUZSU0g5?=
 =?utf-8?B?c29rcGFDSlloM0IrY0duM2pXRDB3ZnNYdGdYcmxiUmVzOUJ5SG44cjVqSklh?=
 =?utf-8?B?MTdXNGtDVEdMaGlUM1BLTS8wQXZwTzAxK3gxUW9LY1dHY3FYSFBSQmFFK2xq?=
 =?utf-8?B?azU2NWNlcFNFODJodUFLTGs1WHhzTlVMZjVJcWVBWFhqaXVjNnAvSkRHblNG?=
 =?utf-8?B?aE4vSWxUQXRuN1pXVTJDM2dSUjE2TkUrRlo3aFpBZEwyVDRYUlcyZ0tRcVNJ?=
 =?utf-8?B?dC9PeGoxaVFkZFN5dE9BQWx0TVZzbmVWVzhUcDBtNFBPYVVIYnp4dFVhZmRu?=
 =?utf-8?B?Zk1CWkhVVjNBdDM3eFNXTmkycE9EUjhHUWEyRDRrYWxaZ0VBMVNZdnRBemtB?=
 =?utf-8?B?c1VWRmhMMy9mUlNUU0M2bERTNC80UVhTbkJQMERaSjUrY2p3VzVUaXdLUStz?=
 =?utf-8?B?cy95S1IrekRRL3RzTm1ZQjRiV0xlMlZzY1k5UW9CS0RZenM5S1BDY2JxYkdZ?=
 =?utf-8?B?RnBZY0pqRkw4ZlRNL095eXU3czdEM3N1RGdiZCtLZ09ZRlpTc3hqUXNXQWlG?=
 =?utf-8?B?YTQyOXdyaUVvcFFYaGYxS1crczJQQWJ1Q04yZUlhODNmY3BOckYwMnNYbFFq?=
 =?utf-8?B?QUlXbENFYmlUQzZIYkREOVlIMmZFNVVtcktNK0lBU29LZXpTQ1BLeXREcmt1?=
 =?utf-8?B?Nzl2ZTFWOUhBeWF4dGF6S3JyWGtXekEzLy85TldQZTdYaWR5MGtJSS9URWQx?=
 =?utf-8?B?NzB2dG1sV2lMSlRBdEFGYUhUaTJ0a1AwVVdqcytxYS9TSTUvVFBRbXorbi9Y?=
 =?utf-8?B?akhtUFlwZFpWcmV2aUFwclZOSE45V3FQVVJ6UUxrTHZXSkRja3lLb0ZuTFoy?=
 =?utf-8?B?WWMzY1dkMEZDaUdISzA0YWVvSktHclloYUplNkhscUw2dEFvamNmK0RqejA0?=
 =?utf-8?B?MFA3WjJrMFFMbzJ5TDdsblhPL0s4QzdlbGx6azR1ZzNISUlSZTBpOERmdnZ3?=
 =?utf-8?B?bXFYNXQrVFc5ak9qZDU3T3B0dkszQXZub2x4c05ja3VGZkhIdWtCK2tNT0I3?=
 =?utf-8?B?SThleGV3SGN4T0tZc093eWVENTdQNzZmZGhyc1A1VlRVcVVwSElpcHFrNzlY?=
 =?utf-8?B?Snl3OW42dEdiRWkvenVwQlpuRTFWMkZycjlrb0JvV0RZVVh1NmZ2OE1zaUJZ?=
 =?utf-8?Q?rh40ZqegzIExNojS6G6GXYU9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72bbb3a-d03f-48c4-d6a1-08dc5abe0e83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 06:59:11.4564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnubE1Vu/Gpc7JV+IH4gTPQJ7Knl8xgIFtJDFf64392qoGGTeWTfOHL1EbUexpcq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
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

Am 12.04.24 um 08:47 schrieb xinhui pan:
> Verify the parameters of
> amdgpu_vm_bo_(map/replace_map/clearing_mappings) in one common place.
>
> Reported-by: Vlad Stolyarov <hexed@google.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 ++++++++++++++++----------
>   1 file changed, 39 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8af3f0fd3073..ea9721666756 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1647,6 +1647,37 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	trace_amdgpu_vm_bo_map(bo_va, mapping);
>   }

Please add a one line comment here describing why we have the function.

E.g. "validate operation parameters to prevent potential abuse" or 
something like that.
>   
> +static int amdgpu_vm_bo_verify_parameters(struct amdgpu_device *adev,
> +					  struct amdgpu_bo *bo,
> +					  uint64_t saddr,
> +					  uint64_t offset,
> +					  uint64_t size)

Probably better to drop the _bo_ from the name cause this doesn't work 
on bo_va structures.

> +{
> +	size_t tmp, lpfn;

Extremely bad idea, size_t might only be 32bit. Please use uint64_t here 
as well.

> +
> +	if (saddr & AMDGPU_GPU_PAGE_MASK
> +	    || offset & AMDGPU_GPU_PAGE_MASK
> +	    || size & AMDGPU_GPU_PAGE_MASK)
> +		return -EINVAL;
> +
> +	/* Check overflow */

That comment is a bit superfluous when check_add_overflow() is used. 
Maybe drop it.

> +	if (check_add_overflow(saddr, size, &tmp)
> +	    || check_add_overflow(offset, size, &tmp)
> +	    || size == 0 /* which also leads to end < begin */)
> +		return -EINVAL;
> +
> +	/* make sure object fit at this offset */
> +	if (bo && offset + size > amdgpu_bo_size(bo))
> +		return -EINVAL;
> +
> +	/* Ensure last pfn not exceed max_pfn */
> +	lpfn = (saddr + size - 1) >> AMDGPU_GPU_PAGE_SHIFT;
> +	if (lpfn >= adev->vm_manager.max_pfn)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_vm_bo_map - map bo inside a vm
>    *
> @@ -1674,20 +1705,11 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   	struct amdgpu_vm *vm = bo_va->base.vm;
>   	uint64_t eaddr;
>   
> -	/* validate the parameters */
> -	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
> -		return -EINVAL;
> -	if (saddr + size <= saddr || offset + size <= offset)
> -		return -EINVAL;
> -
> -	/* make sure object fit at this offset */
> -	eaddr = saddr + size - 1;
> -	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
> -	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
> +	if (amdgpu_vm_bo_verify_parameters(adev, bo, saddr, offset, size))
>   		return -EINVAL;

Probably better to return the return value of 
amdgpu_vm_bo_verify_parameters().

>   
> +	eaddr = (saddr + size - 1) / AMDGPU_GPU_PAGE_SIZE;
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
> -	eaddr /= AMDGPU_GPU_PAGE_SIZE;

Please keep the saddr, eaddr calculation order.

Apart from those nit picks looks really good to me.

Regards,
Christian.

>   
>   	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
>   	if (tmp) {
> @@ -1740,16 +1762,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   	uint64_t eaddr;
>   	int r;
>   
> -	/* validate the parameters */
> -	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
> -		return -EINVAL;
> -	if (saddr + size <= saddr || offset + size <= offset)
> -		return -EINVAL;
> -
> -	/* make sure object fit at this offset */
> -	eaddr = saddr + size - 1;
> -	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
> -	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
> +	if (amdgpu_vm_bo_verify_parameters(adev, bo, saddr, offset, size))
>   		return -EINVAL;
>   
>   	/* Allocate all the needed memory */
> @@ -1763,8 +1776,8 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   		return r;
>   	}
>   
> +	eaddr = (saddr + size - 1) / AMDGPU_GPU_PAGE_SIZE;
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
> -	eaddr /= AMDGPU_GPU_PAGE_SIZE;
>   
>   	mapping->start = saddr;
>   	mapping->last = eaddr;
> @@ -1852,9 +1865,11 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   	LIST_HEAD(removed);
>   	uint64_t eaddr;
>   
> -	eaddr = saddr + size - 1;
> +	if (amdgpu_vm_bo_verify_parameters(adev, NULL, saddr, 0, size))
> +		return -EINVAL;
> +
> +	eaddr = (saddr + size - 1) / AMDGPU_GPU_PAGE_SIZE;
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
> -	eaddr /= AMDGPU_GPU_PAGE_SIZE;
>   
>   	/* Allocate all the needed memory */
>   	before = kzalloc(sizeof(*before), GFP_KERNEL);

