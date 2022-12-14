Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE67C001B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 09:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D48B10E39B;
	Wed, 14 Dec 2022 09:55:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D249910E39B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 09:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqWKUTIGokpCvTwAwztgqjrrQixphxRZU8+q8MScPlL/JH8+tWIORD8+yoeGcF1Wyxse/ywG/FpBeEIWcbmsqV/B6RpioKUuscr117UUMiA8NgcKUglKrB4c04QRxZiTMf2otGj5XsLXSeDsNgWFeNxqC7JEBcKMUgu+hRGWMM8a6NNHCYaAjL7B30acxsXMh8alJX71/w0EjGQk582/nREQbAkEo3PeAbWQKPda7i0OCxXc4F4nysaNFeoI50GSD16U6IL+Pq6bPeskUzdo4cWEWgdWEWaHgVyVE5gPtfzlm2HreD+7kj4VSZVl38P3oAeLy391ovDNGAAtTPe8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRXacI1uSmkl6CJIuZPXWbuIzooTry0Gzy/4N4JMeJA=;
 b=Susd0eBTr+3BVcfYPwgmmF/yT5Po5E7DSW+00VWVNgB8XvOS8uPQBJN9BfYEEPv6pZXVzV9V+IkpLewXIpigw2lrqIfLdXxAHj4zTbIvfsoiyYGwxLdmIVbOoubqHtW+u0StdoQjrG6ed6QrZEFIP/3HW8K0rnHf0yXer7elYe3CmU72+LmRolbtmKGSVNFexC30FS2niZcJy3Pwa5Alx7yp8DsKdms3+7n9gguC8qN2RJc5A2t114KYKuyHUf8A/Q9mRHPxa8KqUmAcn5H8g6wIsq34SVYKdUIOh11G+yFSiZrgYRAQdVtKwVqIcZePtaayYKxNoRZuaXLtbZJ3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRXacI1uSmkl6CJIuZPXWbuIzooTry0Gzy/4N4JMeJA=;
 b=b/Xr6xFFVdBOmoHEjJsN2mALwbKxuPgOFsVfsH3zwTD3coB1sed8lduTYAU72xqreM0P13aethM2uCndkYBwbycrzTh49OalzC1TNpP33jy/RysDHS+bbU5L5geOVkqK/kyFn1VeYVwO83D2F9f8a4yOzHOsstVZkhd9yJAcrEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 09:55:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 09:55:19 +0000
Message-ID: <1baad3a7-9dbf-79d7-cf6a-4a3cd57399c7@amd.com>
Date: Wed, 14 Dec 2022 10:55:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Remove unnecessary domain argument
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221214090524.126956-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221214090524.126956-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a37d4d-18b0-4661-0149-08daddb94eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGbo7bcC4DPXhl2dtpmXtyOrkXCdqMCZls8sN0HtTFGhBCEUIEpGUOJRZ7k7D9NL4xbwWodd8XYiZCVNI5zIyTB/bIHkO8oBt6DnAZdRylndCP0e2tIx67JB+rE2qbzsVVVUKQmJEdqlL/VqzApo+sggcMlUqKhc3AgcdUI5qlwzCz65MU3QZZNU8TMDIfyVIWED2MoGcWicAlAQPEUHIMqTKJPFxxBZ7B/V4ySKPLQUP60zkgK8riz5EWR+JM0YJFhCu4MBjXsAqlHBJp0ldKW/ERU7PCxpusf1PI57YVMhl7UEmrhWst3Z7UCMF8NaYi7QereY3V3/1isr+TmDyqeEnw1/Ox5bQRDkpTwkgz2ySwqUVySVTI2dxnDJJpKaTK1LQXGRLCLUj5EN2RZ5voeC0A4bFZxDnIBxYYES0DEdwFyXTSXOcIwrBNRV0/Jdbd61c+BE1rDn9dktZHPF+qgdBVVSj+5olU3v4KtSpdkOG4Lgy8ILdJFa5yAQEZdZNF/MmghEkqEA9+omieHk+C5dGS8ejIZsPLyfhRkhoATv6VyVDSLafUVrJ76XLD0z75epdnyHsKTAQ9kQTJwjwDXUjRc8V9LzuMN/LroLyORcxRdQ6rUR156QeKVcxKOvt6llBSVfNwXYYJ7sUJ/vG8VYFGtftw1/m05E/zrT1kMmqtJt7ZTJMfMRh3WZHJjj1e3Q3F/g5nkVVnAr25G385Ks7uIe+YNOi7WzaIl110E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(6512007)(6506007)(6666004)(31686004)(478600001)(186003)(110136005)(36756003)(66556008)(2616005)(41300700001)(66946007)(8676002)(66476007)(83380400001)(4326008)(8936002)(31696002)(38100700002)(5660300002)(2906002)(316002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtBa1BPLys3dDJGbTVhSjdCYXVwaGRpeWx1QzNkMjFNYUpGekNwRWRiczJP?=
 =?utf-8?B?WVU5djBuTU1OSWRTekJyMUZzbjFWTTZ3Sll3akd6Qk0rZkx5TlhtT3d0ZFJ0?=
 =?utf-8?B?RXFpN0p3UFZta1REM3dTT1Nnc3RMYzNUUlpUbWFtVU13NzFRYW9QTGY5dFdx?=
 =?utf-8?B?MVBDU3BhbnhSZERncXhISmtiYTByQVBiM1N4c01FWE4yQ3ZNMEVmYWRtajNC?=
 =?utf-8?B?WjhWaExoVDkzdUlvTGdYTkdVWURNRFc5Qk9MdUtuZHBoUm5RZEgrVlVOMjMr?=
 =?utf-8?B?Yi94TUZnYU1zL0pkZXFWZnYyaXRWZGRPcEltZGNzVGxXSWtmMnQyTTlDd2NX?=
 =?utf-8?B?aG5tWFQ1N2tRb0JmRFNnOTNNekZRRG9mSkVvMDRtMkJhaTRZZDYzbUlzaW53?=
 =?utf-8?B?SGd4dk5oaHZZelpKZ3QzY2xZQlg5ZkF2ZjEyOFV5d1FJdFdTQU45YlhMRXQy?=
 =?utf-8?B?R2RxM3Q1V1FUZStldjNlYXdXZTJJU1hkVmg5K1hwaVNDUDJKaElXSE5UT2Z5?=
 =?utf-8?B?TnZLR2NHUmxUYWhiMnB6c09wUGMyWXRrSEo3b3NDeTI0RW1lWlV5SENJY092?=
 =?utf-8?B?eWxTdlF0UHllWC9lVHM5U1JPdU9RK0w5bmZsdDYvcVZ5QlZPUXRiRW55QjB1?=
 =?utf-8?B?TGdiT1cvVWtpQ1VjLzFBb0phN0NpWXhMU3lXcnRGOUlpejVkUU96SmR3T3BE?=
 =?utf-8?B?Tm40VHFmYkowcC9pQjNueDJPVjZsRkUrNUZCRzN1aytGY0FMVnhZbStubWx6?=
 =?utf-8?B?d0N0dTg0d2I2QVhlV0loV2FOTStUa1h1WktTcnJPaU4xMDN1a3g0RUd2UVJi?=
 =?utf-8?B?TXJjSkVmeWRMWWZKL09icnRGNFJsanp1VURwTzNYbXBRR3pyNHYwOEFhSTNF?=
 =?utf-8?B?K1RqeEplWGhWTi9UK2NxT25DL1M2ZFg5UjVqblpqUjZjd3JINlRnV3hRVjhG?=
 =?utf-8?B?djBPZzY4M3NSeCtnQVFIa3BSSC85a3BQK1o1R0wzQlp6aUhKM29yZ0loSlhn?=
 =?utf-8?B?ZWxIY0NibVZvZ0NKOXEyNVdsRVJOa0hqTEFCeUNEU2dhV0RQSjBRNW14Ky8z?=
 =?utf-8?B?cWNpaFBQUlk0TGptVm9ONGp0NnFqbTlmOVlxTGQ3RWltVVg2TlptdFRFbmY1?=
 =?utf-8?B?MTkxbUw2QlRJS3Ivd3NkQldLZmYvcFRUOTdvTGs0OFhsQWMxTXNvQnh1UzFC?=
 =?utf-8?B?a0Z3NmNRL2RwN2FtaG05K2RBYk1sakNYeGZNUWdWWEhFeU9HTGtTVHZLZ3E2?=
 =?utf-8?B?bC9RNm9TQW1NdUZWekV3SG1jS2R4NlJFN04xVlJsSk1PODUxelJ3OEhCYklK?=
 =?utf-8?B?eVM2elVZVVZPS29mZURMZExzRnBnZXdCc1VDM3JDWlFaZXZsSGRhUXJZWm1K?=
 =?utf-8?B?KzljblI2QUJva0ZqWjFsS0ZIa29PRklFeURER05qbGx6aGFFZXE3M05zalhE?=
 =?utf-8?B?SHErRzF2QVZ3dkNtdElWR1oxcnF4U2x3cDlvQlYrbUZma09FanZmcVFzTjh5?=
 =?utf-8?B?NUtsaDBiL2JJU1cyV25uYUI0bkkxclU5Ris2aUZtSmU1T2k5TE5YVm9lV0t5?=
 =?utf-8?B?b1dwTVpyaG1QVFhoMHNQaWNSS1VnV1NMejZEUzdjRDFaTmxsYXdMS2RXS1Zm?=
 =?utf-8?B?WUlkK1RRQVhoOFRITFdBTzZrYklCaEZSZVlKbWRMQmcwSXdzTkJPNmQyczdU?=
 =?utf-8?B?NnF4QWxjWGw3cDlBYlJDdnZ6aXg5TjBHRFFrZjBna01ZQWNMR0VIMVBqM3d6?=
 =?utf-8?B?VEJuTTlXditjYWZhWm16Vk9Sam15R09VbnZUMUtpMEhSbHNEZkpvUEZlQlU5?=
 =?utf-8?B?cmZ1Sldmc3YrSE9PekkzeWhyTkVpalFJdDJPc28xOW8rS2hXenp5elBHZmUx?=
 =?utf-8?B?U1ZaU0lWaDFDNTdUb3NrckRXQkdYTW85cXVyN2dEWU5Kc2FLdDQ1U0lvZ1ov?=
 =?utf-8?B?UFlLYVRySStEZnZ2VFlqdFE5YUhVZFJrcitPVUFUcjAxSnpSOHh3dkEzRUFs?=
 =?utf-8?B?ODYxSHQ2SHRnWXorTXJkK1lHcUExTlVpR3RmaGwwZ0k1eTBoelhyWVFkRUUr?=
 =?utf-8?B?OE9hMkNpVXE1Smp1OXM1M1BlaDdkbE5xSXRzQ09mc0tzK3MyQXJFYVgvM0Nz?=
 =?utf-8?B?cUt1dDN4cE9MUTk0NG1lZ0VDckVtcmVJaFBVQUp4QTFCV01jNjRVd0VLbVg0?=
 =?utf-8?Q?MusjjTYWcjL01pZjSgfHtXU6Z8kDt43Vddog/oAsCAoi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a37d4d-18b0-4661-0149-08daddb94eee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 09:55:19.1286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuqdCyyn4EMP9nYRK/9712p3bkHmsK5Xw2YlHStgPKMsQ+2hx1COP64odEf/T4Tn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.12.22 um 10:05 schrieb Luben Tuikov:
> Remove the "domain" argument to amdgpu_bo_create_kernel_at() since this
> function takes an "offset" argument which is the offset off of VRAM, and as
> such allocation always takes place in VRAM. Thus, the "domain" argument is
> unnecessary.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  7 -------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  1 -
>   4 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fd3ab4b5e5bb1f..72b7429e63ab20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -346,17 +346,16 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>    * @adev: amdgpu device object
>    * @offset: offset of the BO
>    * @size: size of the BO
> - * @domain: where to place it
>    * @bo_ptr:  used to initialize BOs in structures
>    * @cpu_addr: optional CPU address mapping
>    *
> - * Creates a kernel BO at a specific offset in the address space of the domain.
> + * Creates a kernel BO at a specific offset in VRAM.
>    *
>    * Returns:
>    * 0 on success, negative error code otherwise.
>    */
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> -			       uint64_t offset, uint64_t size, uint32_t domain,
> +			       uint64_t offset, uint64_t size,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
>   {
>   	struct ttm_operation_ctx ctx = { false, false };
> @@ -366,8 +365,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   	offset &= PAGE_MASK;
>   	size = ALIGN(size, PAGE_SIZE);
>   
> -	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE, domain, bo_ptr,
> -				      NULL, cpu_addr);
> +	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> +				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> +				      cpu_addr);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 147b79c10cbb6b..93207badf83f39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   			    u32 domain, struct amdgpu_bo **bo_ptr,
>   			    u64 *gpu_addr, void **cpu_addr);
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> -			       uint64_t offset, uint64_t size, uint32_t domain,
> +			       uint64_t offset, uint64_t size,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
>   int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   			  struct amdgpu_bo_param *bp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5c6fabaa444494..74b3e824807f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1601,7 +1601,6 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   	return amdgpu_bo_create_kernel_at(adev,
>   					  adev->mman.fw_vram_usage_start_offset,
>   					  adev->mman.fw_vram_usage_size,
> -					  AMDGPU_GEM_DOMAIN_VRAM,
>   					  &adev->mman.fw_vram_usage_reserved_bo,
>   					  &adev->mman.fw_vram_usage_va);
>   }
> @@ -1627,7 +1626,6 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>   	return amdgpu_bo_create_kernel_at(adev,
>   					  adev->mman.drv_vram_usage_start_offset,
>   					  adev->mman.drv_vram_usage_size,
> -					  AMDGPU_GEM_DOMAIN_VRAM,
>   					  &adev->mman.drv_vram_usage_reserved_bo,
>   					  &adev->mman.drv_vram_usage_va);
>   }
> @@ -1708,7 +1706,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>   		ret = amdgpu_bo_create_kernel_at(adev,
>   					 ctx->c2p_train_data_offset,
>   					 ctx->train_data_size,
> -					 AMDGPU_GEM_DOMAIN_VRAM,
>   					 &ctx->c2p_bo,
>   					 NULL);
>   		if (ret) {
> @@ -1722,7 +1719,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>   	ret = amdgpu_bo_create_kernel_at(adev,
>   				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
>   				adev->mman.discovery_tmr_size,
> -				AMDGPU_GEM_DOMAIN_VRAM,
>   				&adev->mman.discovery_memory,
>   				NULL);
>   	if (ret) {
> @@ -1823,21 +1819,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 * avoid display artifacts while transitioning between pre-OS
>   	 * and driver.  */
>   	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
> -				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_vga_memory,
>   				       NULL);
>   	if (r)
>   		return r;
>   	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
>   				       adev->mman.stolen_extended_size,
> -				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_extended_memory,
>   				       NULL);
>   	if (r)
>   		return r;
>   	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
>   				       adev->mman.stolen_reserved_size,
> -				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_reserved_memory,
>   				       NULL);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 15544f262ec15b..2994b9db196ffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -395,7 +395,6 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>   		 */
>   		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
>   					       AMDGPU_GPU_PAGE_SIZE,
> -					       AMDGPU_GEM_DOMAIN_VRAM,
>   					       &bo, NULL))
>   			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
>   
>
> base-commit: 84abaa3a855571ebd4e57a7249b867a2fa3763da

