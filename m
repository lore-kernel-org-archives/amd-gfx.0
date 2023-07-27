Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A0BC001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 08:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29CE10E507;
	Thu, 27 Jul 2023 08:00:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9488D10E507
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 08:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PitMxw9MSxRbjBF2moLJ0Z6qw/F7wkdnDysqh1LF33bqP5nhEiQAfNm0Ye3o3vI877V7aAvy9RcUQMulrsGl8m6RoW4QmzBuc9lexSA6UwmdzU+S/tON4MJt6mdOLAtK4mhWMmdL5hNBfWThPkK7OdgdDkFZP012hhvMPsVhbb4vDwQM0QponQLIqiwYQJvIoticxWT8rBPWnNvMyqf/EOpIb24NeZ9NjuxaM2+9noqnGn96SaNxk9MCxv391+jhHDMrGr3sONnvt2veq1iP5Yxh9taXQYcRNlD49YvbipsSdUVDmKsEKtPp1xR+bmqAAjGCBvguCj7Kx399zfhTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2SIL4GY/pcB61oweKRJ3PntYYmOpOSeERkbDDX7fFk=;
 b=iELjIoDHJhlSdxkqH1z/vAltXuR8LIQKyPQ8FbCkngoisU9HrDIV4KEtevgT+WrTVOPLReB7wzLBjdsMkpXGcAVk+3oilqTY1FtcCJGkEbeJtPr6Ar8t4Nc2fUUtYxaKT5k8tyJbJL7h6xjSYLkNrF58SqcLdN/vd7TiQ768V87dwd6oQtVp+7moO2xsS8kLJk15/c4k+zzf+fNNFVo+4j6/gMAiezzjvYris2T3WNWIv6CArGP2bE1BealA5Hm6ZahkesRuoPgSjeCoqiKEhU3ckDRwCcF26Geokwj8v0h905dPMapKqGvpuSZ+VbNMWdVWCuIARNxyR5PTSgrmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2SIL4GY/pcB61oweKRJ3PntYYmOpOSeERkbDDX7fFk=;
 b=rQhG7yhGQUB+Ff+2NO5PsZGPLPNmac3ikZ8de/zWXxYZKnZ52CrI7+pl6Wydx/RtEOPcvMUQHIcBdNtR4GDMs02qHPf6RaBJK/hK/3VkINMfuphRSYOt6681L+PfBzkL+ljY9HMO+aBvNruznJB5Rap8DcfssKvrTALuvL1unf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 08:00:44 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:00:44 +0000
Message-ID: <329490e4-22d5-043c-e57d-12b029053e15@amd.com>
Date: Thu, 27 Jul 2023 10:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230727075620.728235-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230727075620.728235-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a7d516-f178-49f9-b5d9-08db8e779444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hw+k7LIrt+aAaDQC0fKmlWZUM3iHjtU52o6661wdw6sfgK6zRMFornX8D0TzWiEaUv/Ta487ZXLGlNrpt3vacUDKhW51HIhOcGikf3QwepotDCuALHYyNzFddrP5cn/u1gSKXOzQJ1EI/tj5Ldvel4kxXJeMQolpcHTaja+jbKLM3Vnd1UgRpOpqYIAfq599g3UDTkRTwyVeCIow0AtvVa0x7+wHhCfBzM4WuvJQTdn+CwzmIPOX0xFhImvWYyEMhYVm00Ffv/KumdZgVroispxOe7ZBJyrFUuFzKWSv9IEPWcfRuFOq41Bip/4U2zRjUKNZgXcMy56EXuaDlwxJdoF7/v6DoSg440AvbOGMRq9tKYiFGqukCusMQdf/UHqVjv9H607u/C7zFAHjEJvSw3k2Jx3S5pNJnl775XV6ZM9mxCpJUTi7ffkjXvZ4jQ0E46nSA1wNvGxmrNUpwBsx9Oqu/3FEEhqIKBjKo+uc3Ih8dth7csMq7Ug62cz4lUaX8oxq4TGdbTcMQEyY5vZNRFytzef1Is1jmywOS9ukVk4QWT4iCj2Ih65Bs2iNgi4wxIApWdwWxeTJuxnU8ZWyEgQt8kGNp2hDj59YsqjO9V1OcigoVjaAo7pjOW3GCV3nWdvPLs2xj9VjFcXP4JptXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(31686004)(8676002)(8936002)(5660300002)(41300700001)(316002)(4326008)(2906002)(54906003)(66556008)(66476007)(66946007)(186003)(6486002)(6512007)(478600001)(6506007)(6666004)(86362001)(31696002)(36756003)(83380400001)(38100700002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBFZU90QktTZ3R2RC9FVGNFUUxVekNLM2ZFeEV4NUszWFlYRDZUQnNhT1ZE?=
 =?utf-8?B?Y2NyM0c2RC9HSndoVDZQMUZUeUt6Vi9jVXpWTGFaaEQrdExwTHVHamJMMXBy?=
 =?utf-8?B?REVHaUFFQVhWbFliUUJSN0puNmNVZnZZMzhEVThPRjFXTitVM1JxQTBOREpq?=
 =?utf-8?B?bTFxanJhcU5UWFdxZ21YVFhlSU5SeXdwNlFuQ2UvVEZYYmFaV1JqNHY2bWx4?=
 =?utf-8?B?RjZxVFpwRVgzNVZxQWN6eTdzV09QTlhaV1J6QmdxeU1LLzFmOHBJTWRsemt0?=
 =?utf-8?B?NTZSam1RaEo2ZDdCK3hsUERBMXd0djhWOW16WEhISnI2NWgreXVhU1h1czNr?=
 =?utf-8?B?VjdMcWZ3bGw5bHJDMncwUGxaTmt4NElXZjg4OC9tMHdxNGVQNEVrYXFuYlps?=
 =?utf-8?B?SlpPNGRPbWtONkpIcXZqMmtTcWI2MWR2TEZ2b3A4a1BqTVdEZHZ0TjZjVjJy?=
 =?utf-8?B?OTBoN25STlFLQ0hib1FCaDJBNTViZzdDZ2ZsWXQ3YW10ZTVxYktIUjg5YTJG?=
 =?utf-8?B?N1U3ZlkxcExSZGFjNlJGRzBhT01GZ01PTC9vMkhhTHpwMUpSOWNGN1FIUGZw?=
 =?utf-8?B?b3FTSEExNzIweXRHOXYvR2tXMS9FcGxoamNPZ09OWktuRlF0SVNWdmFvMUhr?=
 =?utf-8?B?a0pFTTFmZnlXQnRMdTllMHlpQmhlcXd1WGQ2TFFOTWRVanpuZzlpV2RqME5S?=
 =?utf-8?B?NDhueHY1bTlvTitHS2REcDhzajFSWjhadENkVllTNk9qTXFMSmZEMUFGTVhQ?=
 =?utf-8?B?MjFRcHhSMTRabHNXYkdMK0loZFpVSjBGMHV2UmEzYjY4aHYzSUNTdHhzcGJD?=
 =?utf-8?B?VldPM3c4VlZlTVhGMlFaME42UGEwclVZNlpCck5kV0xaZUNPRUgxUjMwSlAr?=
 =?utf-8?B?MkJHNlpzT3NTbVVXSUgvSmRMdUh4RU5KSDUwdTNyY3lieXJNejVHSWhrTDZE?=
 =?utf-8?B?OVpzYXBFa2ZKaDBtU3NUTEdhRVoyVUhaS0VqQm1jMWVQT25kU0w1MW9lbzM5?=
 =?utf-8?B?dFBRNFpXbURoSkJaS0ROMlYwTjdLaW9XTXFIcGE0blJJUHN2dlFlQU1PUFZn?=
 =?utf-8?B?aDA4dlpaNlc4bWRuWEtnSkxNT0FMSjVHZGRXWEtBajFHdFpSYkNnRVRQaVZF?=
 =?utf-8?B?N001WnhmNU5mYUhUOENFWTFLVUM5eGx1SkZZT0h5ay9lRFhLRUVFaDhhWi92?=
 =?utf-8?B?Tk1PSGt5MkJjQ3daZ3BLa1duRkFVeWh4aUVzeWsrSkhHNkYvN2JUZ3ovaERZ?=
 =?utf-8?B?Qms5U2d6eFFVcWtXbTI3OGF5ZWFDbVFJODVSSm9WcE5maHNQLytPeEN3TnZK?=
 =?utf-8?B?dFRGT3d5OUV0MFFrUVAwNHBXTWN1dTZwT3IrblMyMmUxN0dOMWEyOGRSYlpy?=
 =?utf-8?B?YlBJck1MT25TVWRnTGJGcGVMUWd1QndDbzJGcGh3bHpCaDJ6T29pVFZKeHV2?=
 =?utf-8?B?bVpETDFtRFZRUExUaXdhN25lclM1YllpV2l1Rkl2bS9IWVh4SnNrUEN0Mmdh?=
 =?utf-8?B?MUx1RzlPOUpoTGtRdDQzQitRT0xrbE12dTVyd2F3NHpHNDBEVEloUDI1WHBs?=
 =?utf-8?B?MnNXWnZYNm1yNHJZZHBpZ3ZRSWc0Z016UEdiQTZIaU9DYlVBaGNoTGN0bjNp?=
 =?utf-8?B?OGhMOEtEZ2o3dGpOalBjbnQ3aFQ4eDFLdjFHYjlMMUowNVp5bjVNTi9hRGhR?=
 =?utf-8?B?R0hyOWY0S0lXRVoweHE5Z0NBOXdibzFORDk4OC9yRE1BUjlEbVc1NnZRd1h5?=
 =?utf-8?B?NUNBVC9qdHI3NUtyYVFTRTlZRGdkZFFmWmhQeE9CaGpJZU5qbjhUMDZxOGdD?=
 =?utf-8?B?RVNjeGZTUmkzMjg1KzZaVlRDd1Q1a1ViUWdzVGFKY0pTWWdCNmg1MkpCSDZH?=
 =?utf-8?B?Z3NDZ0hIMUdubE9LT05PMWk5L3dEbUpwUThsQ3RKWi9sdGhtRWxqeWRnOG5i?=
 =?utf-8?B?b2RWNi9rdVRlTHQ0Y1N5VWl0ZE1BcUpNRThSdVQyR3FRajRlbkdpZzdwVlpC?=
 =?utf-8?B?eGIwc3hqaWRIWDhQN3Zna0RtUWl3V2dWOFVyVHZWcytmajdRRjVZNklIOXdi?=
 =?utf-8?B?enUyYmIwSXNvcGRXSEtrNzNaemRGWWdqak5YdWlZWW1sWEc1QjhkOHZMWHE3?=
 =?utf-8?B?Q0tlWWNGdXVIZ3hqQlRLeXpXYVpBOWNtdVhTZXZCZXgzUStZUkNXdmdqbDJw?=
 =?utf-8?Q?dPXkyvPnoKuTT/qVmMP97vCVuOClKkZlM6sj/bnVbm43?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7d516-f178-49f9-b5d9-08db8e779444
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:00:44.4919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rl+6SRmVtZFz6oF03vYhWGFBBgn84s5IEtd5IVD7eelMhPiCJKxNbpEyrk917Kmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.07.23 um 09:56 schrieb Lang Yu:
> amdgpu_bo_create_kernel_at() is used to create a physical
> contiguous VRAM BO at the specific offset. It calls
> amdgpu_bo_create_reserved() to create a VRAM BO first,
> then frees its old memory and allocates new memory at
> the specific offset. But amdgpu_bo_create_reserved() would
> fail if requested VRAM BO size is too large(>128MB) on
> APU which usually has a small default VRAM size(512MB).
>
> That is because VRAM fragmentation and DRM_BUDDY_RANGE_ALLOCATION
> is not natively supported by amdgpu_bo_create().
>
> The approach is using amdgpu_bo_create_reserved() to
> create a BO in CPU domain first, it will always succeed.
> Then use amdgpu_bo_pin_restricted() to move the BO to
> requested domain and location.

That won't work like that.

The amdgpu_bo_create_kernel_at() function is used to take over specific 
memory areas from the BIOS and *not* to create a large VRAM BO.

Allocating the initial dummy in the CPU domain is a good idea to avoid 
overlap, but you are messing this up quite a bit here and will probably 
break tons of stuff.

Regards,
Christian.


>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
>   4 files changed, 21 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ff73cc11d47e..331daa47a444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -358,6 +358,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>    * @offset: offset of the BO
>    * @size: size of the BO
>    * @bo_ptr:  used to initialize BOs in structures
> + * @gpu_addr: GPU addr of the pinned BO
>    * @cpu_addr: optional CPU address mapping
>    *
>    * Creates a kernel BO at a specific offset in VRAM.
> @@ -367,42 +368,33 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>    */
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   			       uint64_t offset, uint64_t size,
> -			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
> +			       struct amdgpu_bo **bo_ptr,
> +			       u64 *gpu_addr, void **cpu_addr)
>   {
> -	struct ttm_operation_ctx ctx = { false, false };
> -	unsigned int i;
>   	int r;
>   
>   	offset &= PAGE_MASK;
>   	size = ALIGN(size, PAGE_SIZE);
>   
>   	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> -				      cpu_addr);
> +				      AMDGPU_GEM_DOMAIN_CPU,
> +				      bo_ptr, NULL, cpu_addr);
>   	if (r)
>   		return r;
>   
>   	if ((*bo_ptr) == NULL)
>   		return 0;
>   
> -	/*
> -	 * Remove the original mem node and create a new one at the request
> -	 * position.
> -	 */
> -	if (cpu_addr)
> -		amdgpu_bo_kunmap(*bo_ptr);
> -
> -	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
> +	amdgpu_bo_unpin(*bo_ptr);
>   
> -	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
> -		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
> -		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
> -	}
> -	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
> -			     &(*bo_ptr)->tbo.resource, &ctx);
> +	r = amdgpu_bo_pin_restricted(*bo_ptr, AMDGPU_GEM_DOMAIN_VRAM,
> +				     offset, offset + size);
>   	if (r)
>   		goto error;
>   
> +	if (gpu_addr)
> +		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
> +
>   	if (cpu_addr) {
>   		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
>   		if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 5d3440d719e4..8f5b5664a1b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -315,7 +315,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   			    u64 *gpu_addr, void **cpu_addr);
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   			       uint64_t offset, uint64_t size,
> -			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
> +			       struct amdgpu_bo **bo_ptr,
> +			       u64 *gpu_addr, void **cpu_addr);
>   int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   			  struct amdgpu_bo_param *bp,
>   			  struct amdgpu_bo_user **ubo_ptr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7c6dd3de1867..a210c243dac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1619,7 +1619,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   					  adev->mman.fw_vram_usage_start_offset,
>   					  adev->mman.fw_vram_usage_size,
>   					  &adev->mman.fw_vram_usage_reserved_bo,
> -					  &adev->mman.fw_vram_usage_va);
> +					  NULL, &adev->mman.fw_vram_usage_va);
>   }
>   
>   /**
> @@ -1644,7 +1644,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>   					  adev->mman.drv_vram_usage_start_offset,
>   					  adev->mman.drv_vram_usage_size,
>   					  &adev->mman.drv_vram_usage_reserved_bo,
> -					  &adev->mman.drv_vram_usage_va);
> +					  NULL, &adev->mman.drv_vram_usage_va);
>   }
>   
>   /*
> @@ -1729,8 +1729,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>   		ret = amdgpu_bo_create_kernel_at(adev,
>   						 ctx->c2p_train_data_offset,
>   						 ctx->train_data_size,
> -						 &ctx->c2p_bo,
> -						 NULL);
> +						 &ctx->c2p_bo, NULL, NULL);
>   		if (ret) {
>   			DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
>   			amdgpu_ttm_training_reserve_vram_fini(adev);
> @@ -1742,7 +1741,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>   	if (!adev->gmc.is_app_apu) {
>   		ret = amdgpu_bo_create_kernel_at(
>   			adev, adev->gmc.real_vram_size - reserve_size,
> -			reserve_size, &adev->mman.fw_reserved_memory, NULL);
> +			reserve_size, &adev->mman.fw_reserved_memory, NULL, NULL);
>   		if (ret) {
>   			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
>   			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
> @@ -1885,14 +1884,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		r = amdgpu_bo_create_kernel_at(adev, 0,
>   					       adev->mman.stolen_vga_size,
>   					       &adev->mman.stolen_vga_memory,
> -					       NULL);
> +					       NULL, NULL);
>   		if (r)
>   			return r;
>   
>   		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
>   					       adev->mman.stolen_extended_size,
>   					       &adev->mman.stolen_extended_memory,
> -					       NULL);
> +					       NULL, NULL);
>   
>   		if (r)
>   			return r;
> @@ -1901,7 +1900,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   					       adev->mman.stolen_reserved_offset,
>   					       adev->mman.stolen_reserved_size,
>   					       &adev->mman.stolen_reserved_memory,
> -					       NULL);
> +					       NULL, NULL);
>   		if (r)
>   			return r;
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 41aa853a07d2..b93b42b916ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -397,7 +397,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>   		 */
>   		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
>   					       AMDGPU_GPU_PAGE_SIZE,
> -					       &bo, NULL))
> +					       &bo, NULL, NULL))
>   			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
>   
>   		data->bps_bo[i] = bo;

