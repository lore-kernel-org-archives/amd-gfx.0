Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A421BC7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 20:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A65F10E25E;
	Wed,  5 Apr 2023 20:28:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F0810E25E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 20:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrkliqNwM1FBryGcMkqcLu7/B9Y5gpwGU4mLEe0JxMw8tTr08lmnjkDkFpcHvlL6TQ5kFRV+kfk0df96adB00f84jDSExM00xNYlMXZeA264KvqJH64AHmy9D78r5dj0y57eHsrCd+SGjWRJoFz+Od097OgfUgekBHSxE0qu7eTgVMndJMxFu2vt5/+qvWXK3mEqjb86h0hXbMFmRU4rK2Hx+ewdsSwx76mjiYdoWHSSS58do5b28HS1wV8ciRIMaLDTvr8VaHh0HJKjMpKGR9HeHd8jMQETjRYY+9eikYiR82LOXeaQbRq/NSHa+YoUO92AXWh1I5iVBK52iLwMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNoD5SR9Lm0O2UA22p+mq9GbTgtLKwOEPLQa7COrPyQ=;
 b=jSxZ+lx5ttFJdGgvk/zffGDLw4gkP9iNhj4wBnUJ4c18f0Uiijf3ECLb6NUHeQWmkWl1BPqezq/DtaZgXyl0W4Px21ILYuQ5jPRciSCDELRLnF+OMp9frvAnzTSEfktJBf4duE6NX3C4NMzN7GRXc0XYbW3Lx7Xb2UjQ+VzDlkdGcZNXZVLjnqEN0ql7WDKCFrgIVpIRX5U8+wqlp6fDh5dUfckNErHlvGKZqswTjA2cVmQbUAkY73iB7Eph+Ti+MkurD4FOjfTgKjVhyabo8/TuFspi3KGkkinfqPccdQdOgxVD9RjTCq9f72Ib5L3YZ0BZvZj+SIGhO4Tjt3OciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNoD5SR9Lm0O2UA22p+mq9GbTgtLKwOEPLQa7COrPyQ=;
 b=U34VYJHbMbXWd7U8Tw3IIN6RHlh5UWmzrZLKXPQA/okKNhGPP+hoXhlRuYK4CaNSdKHZDUVZ8S5FgMSxu9vTg3ohVyILU1fEVlLU67TrDO3oSdUebrLrpaVa8MVKKgjG+Mk5dlpoUa8lfXKJp0yNKRahKUu3xDfji6V9MOa2eRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 20:28:13 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 20:28:13 +0000
Message-ID: <fe10f05a-d76a-f62a-3a6f-91478d0d2682@amd.com>
Date: Wed, 5 Apr 2023 16:28:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] amd/amdgpu: Inherit coherence flags base on original
 BO flags
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Philip.Yang@amd.com
References: <20230405153121.3324620-1-shane.xiao@amd.com>
 <20230405153121.3324620-2-shane.xiao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230405153121.3324620-2-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::38)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d1d918-dcad-466f-4935-08db361447b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4N13jBZebdeCHhTxvUBqwtyaA2nD7Rcg8idgpn1Xn6yW9pnUlozX7IXFIngCoybwpiwrTfJ2jRe8hMGzgN9xGPHC1VdLw/A/idfUK7BAECGu+7XWRVDqbdvqUdk9WskTuOvBHOPJaN0SS9IHSFdlFraBB7O+2OTDipsbePd2RdGEuba6akElLLGAAFlhrkAKAS2D37sXIx/UKpiGfY+XJUrTwgDczrxLphAmDOU4vVPYc7hBuThdHP3hEdEEUvYTjYmh69kyPdKvtBiAVYmXesoXw5UFcoJd0hFeerduanzPJGK1mP6/jwsUx3BMRzYP0IL0lKuSGvT484bgrwtEfdrc4mv9dc3+pncI//zFvZJXvYf9ujOIzuq0o41Gz/ieln4GKmRndKRDBYjfS2L9BuADDSsTOUc6YRd63m0tmeY3IuK1Hwtnzn0v85E9WcHzMsAR+zenGKBBV490kGDIle1xQ2zMaV8u7WnNP+vg0VSyncYfzcjcigTgVmAqADj+wQX8EmrgH6IYdaILJb9ny1cxdYAzggWArspmbXOALoAoCI8+VZ09A9CYw0AqPMWjLyUvLG0pbro2bfL2Rx/uEQ7TCYyiU7X/KfBjK03KAIr07ZZ8VaaEnbJkNH4dnGHO/xgOXw0tlEztSN/QeXdrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(2616005)(6512007)(83380400001)(36916002)(478600001)(316002)(26005)(186003)(6636002)(53546011)(6506007)(6486002)(44832011)(38100700002)(5660300002)(4326008)(36756003)(2906002)(66476007)(41300700001)(31696002)(86362001)(8936002)(8676002)(66946007)(66556008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkxXQlpRNjFyQ0RUUWFna3lTVHlLYWNIdUFuZWpmRTM4Z0lIRlRhb01BSG4r?=
 =?utf-8?B?cHlIc3gxckVQZ3RweDRVYjk0R0VkdlhXZVpBczd2VkhwZWNnN1RDRGp6eUFv?=
 =?utf-8?B?U2VCWkhyTDloWGR4T3ovdDRCc3FjL1VEaElOT2ZKTkMxRW8rbWE4d0JXMzhr?=
 =?utf-8?B?U2pKSEliUi93S0RGcFZadFhuVVlLNkp5cy9FS0x1b2pYS002TmliOW5uRWI3?=
 =?utf-8?B?KzVxK1BwODJpZmQyRVFHUFFRb2NYREU4aGd3T2s3ZVB1YVE0eEpjMFlYNWpn?=
 =?utf-8?B?Ukxlek5CZnQ3T2VJaXVwV3JWUTN2SUp0UllnSFdGWlFVNmZhZWtsUG1EZzBi?=
 =?utf-8?B?UE93UkV4REM4RkZCQ3hkemVJdGtLZTFjZzJHbHg3S2NONXJjS05hWTNjbERV?=
 =?utf-8?B?MzBQa1pBNGxWYUhIL0dCb0lkU3FNaXBZaWNKazdRdFVOZHBoOXREcXBFLzNw?=
 =?utf-8?B?a09weDdVa2VEMldKQXNtTWNqME9jVEJvZmN3T2h1aXJOcVZobHJCOG0rMCtk?=
 =?utf-8?B?dU5GUWROQ09VS285RktCTmUxV3RtRThlZysvRW1VVk1mbWlLeGRvcHAzV2lW?=
 =?utf-8?B?eXhSSmJrQ2pqT0x1UFNTQStYT2U4RDBLWTl0R0gyVElZa2Jjc1Rvd2dkRFd0?=
 =?utf-8?B?NGVBR09kZUQyQzdZKzNXY0htbUVuWjBGRlI5SG1RR2xYeU5zTGpLQVZ3c0Vi?=
 =?utf-8?B?dGFBMm1tN3ROWmt5bkEwUUdBc2hQbEQ3VGhjNkltaVJLUHJ3T3QyZlIvNzFU?=
 =?utf-8?B?NlRyOVJJWmlhbFhzRWczMzR6MUhCZ3lhRUFvRW1tZWhCUVR4TWpKV3dVL0hE?=
 =?utf-8?B?M2wzM2F5L1NOQTZsWkJ3U0tvdDJWd2t1dWI2UG91aDNUTEF4S3RsK3I2cUJY?=
 =?utf-8?B?Z3F2aXJHVjY1WUpkcFBQSmpHeGlIVFZRU3JlZ0Rzelo1bUZScWdYQVNDNEcv?=
 =?utf-8?B?dGtZdmtqY0NsWXYvaEpWVVJhcmJydlczamNQVXYxR0NkekN4ZnZDZ29YQ1BB?=
 =?utf-8?B?MkJlUDRFL1RmUjJNTk9Za2oxNzA1RkpJVTB1TG1oeHhwSXB0ZEl1OTYvcGhE?=
 =?utf-8?B?YU1kaVh2d1hGeGZ3TnZMSjNJNGwreElCeGNOM3JoMFZTWHoxNXZJOFJ2ZDY1?=
 =?utf-8?B?ZmVBNEJ3cjVNWnRtanJ5MjhGSERoOEpHUDhMK2JBRVQ0S2cyaG1NNVFSN2pM?=
 =?utf-8?B?Z2Y4SWR5bFp1WkwrbnFvbXpNb3I3a1lsaisxeDhhVGhuZ3dYcXJnOGFTbis0?=
 =?utf-8?B?dU1iNU9GeFZlN2kvckgxL1BOVEhxcTJLdlBNZWRLSUlxcERzRmZtb2ZNeHly?=
 =?utf-8?B?VEd2a1VIT1JvNTgyYWpCOWlDOXkrd0phY1BaVnJjTEluZi85ellBREYybnNZ?=
 =?utf-8?B?SzdRUC90WTFRK0dORk1kUFhJRXhkS0NMSCs3UXRYZTRXSkVKSGwvUmQvQW1N?=
 =?utf-8?B?VEM3SS9IK2l2WnE0UDVTNEpaWUE3TGVNaERhTSt5dGsyN0I0OG56QmlUOW93?=
 =?utf-8?B?NGhkMnFLVFl3S0V5SlFjdmJLNE5weGhzQWtvbkx2MWlqMGM1WmpGZWNJVko1?=
 =?utf-8?B?R0EzN0JmaTJ5OXgzbmltVUtrSTRpL1BGWGk3OURTc3NoTGdjRFlMSjJTbTJV?=
 =?utf-8?B?VnlJNUs3bDQ5MytmR3I2WHd5enF6SUJxM0lJOEY1TXRUTjBIOFJvbitlenE1?=
 =?utf-8?B?amFDYkRDZlFZeU5PRUcvdzNMNTFFQTBySk9qTGlPNWRTV0laOUZMVzVjT1ZK?=
 =?utf-8?B?NXIycXFkTjRXMkJHNDJYaHJhSitiZndVc2ovWUlYNkFSUE84cFk4UTA0YXFS?=
 =?utf-8?B?N3drbDFpQTFyYzV4WlJuYnRobXBrUnR5YjY4OURldjZtYTZRWEd6R0xDMFBD?=
 =?utf-8?B?WjhBeklVRXdXdjcwQlFDTE9iNG1QVk5VaFVKL1Vuajl1RUJBQmt1UmpzMy9V?=
 =?utf-8?B?dUhqQTNOVFZ4M0JLSXdmSVY2clBPSjV4YWNCV2QwcXlOYml4blJhbkNHZDJK?=
 =?utf-8?B?Nm9LY010SHJEOUZPVDNUK0Q4WmxiY3JFZFZvM1YxZjlMYkhEbzVMNjE3S2t6?=
 =?utf-8?B?d2M2emNsRkdZZk9Tc1VrcCtCSTBuNzYwNUNFR3hJcjhJUVhON0NaY3lta3RB?=
 =?utf-8?Q?5LGnIjhPAfODubY1Xzh3nAJ1b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d1d918-dcad-466f-4935-08db361447b8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 20:28:13.5820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcBq0FpFqnCuLl7ULFF1CX/nVfoNhzy1cP+qvlhFaCv0aHH9Ez0kUJS3vAGEY5wJiJ0NI7GOoWsncC+MEsSB2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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
Cc: aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-05 11:31, Shane Xiao wrote:
> For SG BO to DMA-map userptrs on other GPUs, the SG BO need inherit
> MTYPEs in PTEs from original BO.
>
> If we set the flags, the device can be coherent with the CPUs and other GPUs.
>
> v2:
>    1. Drop unnecessary flags check
>    2. Remove local variable align
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2fbb9db64ad5..b181bb373783 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -271,15 +271,19 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
>   		 struct kgd_mem *mem, struct amdgpu_bo **bo_out)
>   {
>   	struct drm_gem_object *gem_obj;
> -	int ret, align;
> +	int ret;
> +	uint64_t flags = 0;
>   
>   	ret = amdgpu_bo_reserve(mem->bo, false);
>   	if (ret)
>   		return ret;
>   
> -	align = 1;
> -	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, align,
> -			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE,
> +	if(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)
> +		flags |= mem->bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +					AMDGPU_GEM_CREATE_UNCACHED);
> +
> +	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
> +			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
>   			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
>   
>   	amdgpu_bo_unreserve(mem->bo);
