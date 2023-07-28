Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23581C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 07:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9675B10E058;
	Fri, 28 Jul 2023 07:00:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2863810E058
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 07:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7SMLUZeIAaHwCtF/G//B53YKG3sqStCT941pLu0ZRNgQtANEBqGphX4L139LoGcDmEeOGSt3gp2PMD9MCvUr/FzZsN9LMf+OjEGsNhee3VJthF/FJxpYV0hd2ZjbA5YREt7jRTRZmBNa8GtaYCXbjHVuTyeM4Dco0BNwFbwVnhleMWmXKHnIu9jpcZE8Krt5yqc6ARIV4fwpRlesIg35XxgjA3jNFpQo1RzxQDOzK4sWRX2pu2robT10xkLtmYxgTsC39edeblQOnenFB+sHDj6QaPjHrw7SBN17DFmQbDcNDCYNoOdhpRtpb05NlLvsO6avYHvf6ZRps5JJLt9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEqKGLpLFCIsVgqMWTjAMIyG9V2teOS89/8ullbsZpU=;
 b=l6U/iqDQuQ2LmPr5lBVoHkJk5ZwoSnyuXm4yQQAkmzDZSe5ystIrwxIbjCzY2cRTCnpmrjOJHwbXLrp+yDz8OCO8lZuRiFsQzpXnk1MvAADD9P8dWMfW2Shfs2KkhyaBQUZB9xQa7mCbq5yf0oAU1GjsO2kaTTLQcVzhkOxHGlxtHxeDbrIBde1sYUoQsK1V3iEgF5//b4/YJWW52FUoF58iIrPO63VRqONobXnMTEZ95xbK19QizSQoxtOuAJR6xT44n0PgOItDbhNm3GGAzsR6J3JyaRViHsTQ21QE/QixHIQ07ICm+hzpirAc3HzuiSnaNtz4G+BVsFmxx+46WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEqKGLpLFCIsVgqMWTjAMIyG9V2teOS89/8ullbsZpU=;
 b=4KhmtNoVSBGcJA1Kk+K6SxxKU/uNTf9wbS1xw/fRNte5+LpOY7A6CPMP1VipKsW5mcxmhPN2mTEsLw4xjcEGN1RSriApTEKy6+sAFkgBnW/ZDSRSA9xACfQzUFuPE8A/wcmKcPu2qh3s4qrtQLneNE9IJTbnXaNFi0V+Adlacfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 07:00:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:00:47 +0000
Message-ID: <b824e5ec-e383-b656-b1ef-543f31628092@amd.com>
Date: Fri, 28 Jul 2023 12:30:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230728060405.939785-1-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230728060405.939785-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: cebfbc49-bdaa-465f-3484-08db8f385e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrbX2o3SGolTkpgMunFuE2sN0IL9vsRBsELRxmC0oHyxepKO7B084zWicqB55g2NQXartXXedO0LUaEX6X25k5Sq7lBFC4RUU5p6tDRKGkiwoJYvaerA8UlBfdOaA0caOAdYmyvTNvLYlwMOoUArMiOsQVs5d9jk8BdH0op/KLhLgGUmXYDsoZd/A9U6XYtinVCbl2yqZ9uHG+dC1psKGm9k1+05khA5dOFIG9f1+EyGwcUdfAa4WZok2GypqtCvDxwZCZcSvv9psi4aCu/i7J7VIrB58V4l5znpmfyzNPnhuC4Hr7LHRjeCYP/55XaOmDLOPf4LarW+JMC+0RBtf1sQ116rjKGVytaofm0SqmSxsvEE0y1t/78UAmNkPaZ63guaFU6t+n88wcy6xpgIjyZfQmraWJxbfz9EUvDh+5DjHKIjqI20gJ2dDfbIGxFZRy9mTvku5HD5/eMsW/pM0O0S2U9uDFZbD3dy8tRNF6LsnyFuKcn5NdPWf/vzufJTXYt7+l/jd+thc68HT4la5AjRpGiE7i//aHjdpKw+NDQZQDt4WT8HiIKogduKqiCPbI+6jjRkasxfUl+5s2rxER8L8+bdF7KFvdTO0iMiYAPugwRSwih/KS6SJt/iFR0R//i0HRaD1z8dzfUnYZM95w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(5660300002)(41300700001)(26005)(53546011)(38100700002)(86362001)(478600001)(6512007)(36756003)(4326008)(8676002)(8936002)(31696002)(66946007)(66556008)(316002)(31686004)(186003)(66476007)(6506007)(2906002)(2616005)(83380400001)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FXZTFnUWZUQjZwRElHYjkzaUFnNFB2RlFDSDdOakZOVWlROCtRZjdybVU0?=
 =?utf-8?B?Zlp2Z2ZvaExLQ3pEZEwyUzQxa2o4UG9QUGF4U1JkcUtFSGFJNmNXQUpRYUF4?=
 =?utf-8?B?RnNWUVhjbjdZdnhOM1VyTjdDa1MyVVV2YXVDR0hnNjVEYVk0aHR5Wi90SGZH?=
 =?utf-8?B?QWJ4aGJnYUdud1BVR3BhSktlMjYrWU0weGkxV3Y5NWU5ek5CR0xFOXpnUVhz?=
 =?utf-8?B?dGNWTkcyS0Nndm5NQkFqVGNHbG9DajlHR2NObmVFc1dOeUFsYTNHb285dHFi?=
 =?utf-8?B?T2tYR1IxYStmNDVzdlBFWjAwVDZmY1UwREdONE1scldkOWhHWWc4S21HTFR6?=
 =?utf-8?B?S3RpV3d5SS9RT3FYR21uWjlGZjU0UlFtaWd2ZDIxaUw2eWJlYUdiMTRPdk9O?=
 =?utf-8?B?TUxPdzVFUG1WSDIwbStMR0h5K1ZuWkpXb0F6OFRPYitsRWQxYkNsVVNrelBR?=
 =?utf-8?B?M2JtbTMwTEhVRE1WU3hZeTREa3RrQXBkdkZqOEhnRTFDdUVFMm5LTHZsTndW?=
 =?utf-8?B?WDFqOTlDQTlMQUpueU5sc2RtSjgzL3dQbUpPTkZKem9PRmRCalZCS0s3WWNM?=
 =?utf-8?B?dW1CbXBiVUxBNUFnRUhNaXpiLzJKcFFHOVlCVnhWMjdRRjhJYks4OFZpdnlV?=
 =?utf-8?B?TFk2NDRZK0Z3d09kUTNIK2ZUREVvOEtBa0llaUJnNUF0aHZ6N25LOWY5MEU5?=
 =?utf-8?B?eVNuTldVWEp2emJiZUFXV3NrWi9QN0dkbFBsVkFjV2IzUUdIZFlRaHArcTht?=
 =?utf-8?B?Q053a0E4eGNJQmw4N1Z4SDI5QmxoZzBKQlJva3F0U2I0NzBNK291N2RhVndz?=
 =?utf-8?B?ay83R3FiL1BEM2hNM2VScVdJQWRXT0FUR0VNaHZRdmwwY3Rzd1NxSWhhcTVJ?=
 =?utf-8?B?dHdwb2FrZ002RHphcEw1SjdWWkFLdWd1Ym5TLytjZjFhdDNLdjZPWHl1OSty?=
 =?utf-8?B?TFkwRGtXRUZ0ZmllWk1XWW5XRmRnL3MrdUJGejVuYllaaEFkRUNVVHNnM1R0?=
 =?utf-8?B?ZDdlSDV6WjR1MGd0RVc2SzN2L1o3bzVHajFQZjFHM2dCSUdOZUZBdElmdWlz?=
 =?utf-8?B?ZE42MzVBdkdYTHpqczV3Vk5vU29ySWhqR0JNbEg4Zk02WUI4OGRrUG9nYmhX?=
 =?utf-8?B?amI0dnpjK1ZqWTVaWG1oV3lKZnJQdUVzYVdaejhPSG5KMTNJd1orWnM5bXow?=
 =?utf-8?B?OXplcjlmN2Nrd25LMzJFazM0aGdhUFo4OU1SL2JLK2NGOTVVeXEzTEQ1MGEz?=
 =?utf-8?B?bTBzS0czRnVERTZLeit0LzE1MkIyMVZBWGxYVG5YckdNZmRvN3VGcktPbU1p?=
 =?utf-8?B?bzdrL0JkMWJJY3lwK3BBTHMwYnA0Z0p1TXRoYjZacVN0Mmd4ZG10WnE3amNM?=
 =?utf-8?B?NGZUN3MyK3EzRTl0VjlJNW9PeDVQK1UwOFhzVWNMa21UN0ZlZVRRMzYyRnNw?=
 =?utf-8?B?Q0x5cUR2aWE5YURXZ1ZXbWdSUVhVUlhDYWZ6M1pTRjB6eXdqUGVKdStIWUpq?=
 =?utf-8?B?SXF3NXdxRUErUmpUUXgybG5QTHlCUXBiZ2RIL1pHWjJDNXZ5bk9XMW9yelZH?=
 =?utf-8?B?OTZUUldpcnF5b2pVRGxneGJmTzQ5M0R3ekRZTnNuem4xcnRrU0JFaEQzQ0tD?=
 =?utf-8?B?cnBDTFo1VzhXUkxmbmw2TWJaazM2bE4vQ2dUR3BGZGNZVHl6MURPVmRFMXFt?=
 =?utf-8?B?Vy95TjVObXB1ODMxb2sxRUNrMGJjYXZOQmd2ZWdkSmltWGxNcENhNHh2SDdD?=
 =?utf-8?B?TXNLR1VZVWFHalJDczFxV014bnpmNWN0VGpvUkZUZzh6N1ErM0toYmpjNW9U?=
 =?utf-8?B?ckQrU01ZaFJRNDJRTWV5Qkp0dklnVjJ3WWwyZFhKSk9PUmxtdkUzRDNLT0Iy?=
 =?utf-8?B?bzZmTkZya3N6MTU4eVJTZm5LZWZyRFNNaDQrWFNCOEthTmtKMkdTTVFiSytM?=
 =?utf-8?B?VFdOOEpCM0lCMFprZWc0NjB2ZE1SVTFPVk9sa013WnZuRnYvbG9XdVBqRVc2?=
 =?utf-8?B?azJqQ3pUb0VlQUZaeFd0Q0NQUXpjVi9DcFF6WWhQMmExR3EvUmt2bUxLeWps?=
 =?utf-8?B?UGhEZWd5RklLbzlUU1VaRDNsZXZ4WEhRKytPMHZlZGo3VmkxcytYelB0MlRs?=
 =?utf-8?Q?iwliwUn4q7G28DVhpWqmNr4nS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebfbc49-bdaa-465f-3484-08db8f385e9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 07:00:47.4672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txzaAovoi0j2oiszGaYLihFm9Iz6JnVJq3/cVDAkbolFRb7cI3ZwEknxmu5FMtXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
Cc: Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/28/2023 11:34 AM, Lang Yu wrote:
> Use amdgpu_bo_create_reserved() to create a BO in VRAM
> domain would fail if requested VRAM size is large(>128MB)
> on APU which usually has a default 512MB VRAM.
> 
> That's because VRAM is framgented after several allocations.
> 
> The approach is using amdgpu_bo_create_reserved() to
> create a BO in CPU domain first, it will always succeed.
> 
> v2: Don't overwrite the contents at specific offset.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 24 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
>   4 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ff73cc11d47e..fa30e96f27d0 100644
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
> @@ -367,7 +368,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>    */
>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   			       uint64_t offset, uint64_t size,
> -			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
> +			       struct amdgpu_bo **bo_ptr,
> +			       u64 *gpu_addr, void **cpu_addr)

A generic question (not considering other details in this patch) - this 
API is literally asking to create BO at a particular GPU VRAM offset. 
The offset goes in as the input, so why does it need to return a GPU offset?

Thanks,
Lijo

>   {
>   	struct ttm_operation_ctx ctx = { false, false };
>   	unsigned int i;
> @@ -377,32 +379,42 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   	size = ALIGN(size, PAGE_SIZE);
>   
>   	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> -				      cpu_addr);
> +				      AMDGPU_GEM_DOMAIN_CPU,
> +				      bo_ptr, NULL, NULL);
>   	if (r)
>   		return r;
>   
>   	if ((*bo_ptr) == NULL)
>   		return 0;
>   
> +	(*bo_ptr)->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +	(*bo_ptr)->flags |= cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
> +		: AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> +
>   	/*
>   	 * Remove the original mem node and create a new one at the request
>   	 * position.
>   	 */
> -	if (cpu_addr)
> -		amdgpu_bo_kunmap(*bo_ptr);
> -
>   	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
>   
>   	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
>   		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
>   		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
> +		(*bo_ptr)->placements[i].mem_type = TTM_PL_VRAM;
> +		(*bo_ptr)->placements[i].flags = TTM_PL_FLAG_CONTIGUOUS;
> +
> +		if (!((*bo_ptr)->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
> +			(*bo_ptr)->placements[i].flags |= TTM_PL_FLAG_TOPDOWN;
>   	}
> +
>   	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
>   			     &(*bo_ptr)->tbo.resource, &ctx);
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
