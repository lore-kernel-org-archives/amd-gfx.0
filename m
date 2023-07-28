Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A657C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 20:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF438876A;
	Fri, 28 Jul 2023 20:00:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9EF10E78C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 20:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7ph3OXfYj83Lwh0pRwoujL82kYeA+UmHXttSe5WMMdZFg8u2yOxrt10fXo5UYYQ0y70Z0KKI9BW/zYEXMQFoKeKiO10ShnGqsG5tOXib2EHCKCyc9nyK5AB1B0ECxD0+aPWXGnz6mDyzl9GDG35BNrjEIPM8k2kkRf32mB33HHffxhx/CQJP7AThBJEidOnrJxwYdjxs2lwZGUhfSHc2EOX+F9PiYUMxzu/N9MlhgozKXD3Cz/LOTeB/MzYtmgr0le74ZvvdAovR3bVcdIRn5jwcDLzOTkAEZrkrXw6tSuZ37FhSJ29wKoTH208Q297x7G448qYyPURUXprWGMNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtHO8FtIcY0fBPOMkOm+v6gAB6b9R0NisEY/Kuljrt8=;
 b=HgubKsrabZAeX30OVQfMduG2D27Qt0Miybw+VvEbPNdDm0pOIiXvQnWQIOVcGLX+RkLj5dmI2SFFe+RKPCiGy9m1z1mdqsppES3y7Sxbf+4X1WsvPtgeFagPqANYBMNvruMQ8JGsnqGtKN2U7GQbXBRbrnzbaNc06Csda83wWGANnjxLkBN8Rm1SsWaToO/C9tFvMCSsC6e5bUH54/3KDZ2tTXsrKQys8uTHdZLnxJ2g0JPczrfIqW+EHObPq47A5WOEEu9PX2HBNHbK7Cdhjum1pw4zXYczPC/DI9B7cbamhUywSNwd2p5zRDZJs6PeZ6jnAaWxihDFBDkuUC6BgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtHO8FtIcY0fBPOMkOm+v6gAB6b9R0NisEY/Kuljrt8=;
 b=YqhuvwqcJr75sGM9X+MwYE5zI8hOtpnRQVdGXWqa8tLQRLIhJsUnrI2tGkqdGBp1qxKhAUtPD7bYTCcAhwQS9IjUwZgN8Slix4yToBk6frpNOWz7x6XIZxHGHWHRP/n69XnhUCh2FSIlP7UZGzNXIIXLHhreyIypyNo7gxMco9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 19:59:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 19:59:58 +0000
Message-ID: <c689de95-ee76-ef2d-508d-76fff7e76d1e@amd.com>
Date: Fri, 28 Jul 2023 15:59:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/amdgpu: Add EXT_COHERENT memory allocation flags
Content-Language: en-US
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yat Sin, David" <David.YatSin@amd.com>
References: <20230728193955.2607848-1-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230728193955.2607848-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7efc58-f146-4caf-33f0-08db8fa53834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRFEV3hTC8YtFza+sj/7KE+Hj8h7Uu8ytIw6DHCimxx/7SbdN7O6MtMfb7ADjvoS1ho9SRfiwnbYXqGYkeWpZcSN3Z4Rm/DwedBsW97XVbxcDPfWsNX0FS3jRjb60OgsUcWDAOzrisMiW7f8jakTCwpeE6PuLM2mPkb8xh4X7XBrSz1VWL7BKVpAeHqXgcUmvdoFZXCKFLkLxZev8+5Hu9c3j5z+fAv+R7/V6pIxTN3gYmV8D2QZhcNOFtCMZk0YYIpT51OBptpEG1+lxCRR2IAhHyYsKDjqaptuIAaDMIgrdBWE30TIB3nIEUphRxk7oCWt3MCM8AsNnpDh0AcnnsV6vveTtsGOj+YrVlqJ+FZrZ28HxXbkIsoXe2HR5ob5u1M000fzeSiX8fnQtDMXDrBxJrOWkVJ1LYvgfaSAMeCA9366vhOWEQ3h6jSx5LGhy2erapAKO0uT8x1EWCrnCcEKAVn+doWhq/H7W2yVdRntRJUU7kKfoCXCdAy3vyKW34lpqOKpfh+VpOPpr1/XImNXvDEvez27k0WpOiZMcq0FsbIM2NZAIXyvDRXC3E4Axtn2K5gRpx2yANDAtS+4GlQI5JFfDwZDeWquLOJLIft9JW9zHCyOOg0/PKsZoTIJkTYmcV+HNEN61WJvXTeq2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(478600001)(6666004)(6486002)(6512007)(966005)(6636002)(316002)(66476007)(66946007)(66556008)(110136005)(41300700001)(38100700002)(83380400001)(36916002)(31686004)(36756003)(8676002)(8936002)(6506007)(26005)(186003)(44832011)(53546011)(5660300002)(31696002)(86362001)(2906002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNVdmVKSDkzMjJ4cHFGZHVxUmI0WGZ5eDdhemdtMmtJN0U3TXVQM3hBNWxm?=
 =?utf-8?B?eFdrbmtvZnBVZ0lrS1pzSkJyaGZXMnBOWlAwNGNhQU1XTzcvdWlXZG5Qdmxy?=
 =?utf-8?B?UHJreFVndXd1bzBTMUswUkRMaXlRUlp3OWFJMlMwa3FLdklVL0tSeXYwZTV6?=
 =?utf-8?B?allPTHZ1RFNPZ2x2QXQySDJlNGFUNGdmRk95OEcvODkxUk80VkNOT0t1Z2Yr?=
 =?utf-8?B?WmRvbEgzNDF6R1Y2MDRadWhwcWVkckI3KzVTdWRXVXUrckFNK0RJWEdvMjdv?=
 =?utf-8?B?aVpQbXRsVlZjZlkxUTBzejdCTFhaY1RjYTJDdU1RcjVKcTZUNWZwMUwvMDhP?=
 =?utf-8?B?Y0tmaWNKU2w1Y2o0SUFVSlB3QllQTWJRaFA5cWoxeE83dm05VW90djVWenlX?=
 =?utf-8?B?aHBZcDB4ZEZVZHlxUGI2NWRhRWhtWEFzR25KcTF4ZXhxdXRBVnFwblE2enNy?=
 =?utf-8?B?ZWZqTERZTzA5UmIvbW9PSjJyV013d2ZJdFlyNGRtdEF4TUMrTmxpM1ZOMmI5?=
 =?utf-8?B?S20xeFVxOE1rNndTcUdIY09uRXJOS3pFV2FBcXBpclhYa2VtRk1vVExKc0Qw?=
 =?utf-8?B?OWc5QmdsT3Vjc2psUDBZV2RZQ1RSUWpJdnFBbmpOWDJiTGkydndod2JVdDUz?=
 =?utf-8?B?elh5NlFod1ZTS1hlYm5ZKzhtTUEyQkpLMUtic1RVdGg0d1k1NHZFd1ZPV202?=
 =?utf-8?B?c1EyVk80bUVNK2p3akM3ZHVscFgzdUEzUExBeEg3OHNFRkVTb2h0V2t5MWE1?=
 =?utf-8?B?N3Y0aEV1bndHeVhHUk5xdGhQcWFDV3V6MXhHU3JRaHVmS1VDRXdOSGdod29j?=
 =?utf-8?B?OWY2ZmlTVStBT1FCUWlFY29yeVAvTS9WdzA3WEFDcUhldndhd09sR2hTZlVt?=
 =?utf-8?B?NlA0QzMyT2V1UTVpMlBMc0FEV0Q0d0pXK2gwZnhkSmJ3eXgwaXB4a2kyMU5X?=
 =?utf-8?B?dEFCRXhpN2xRbTV3QVpHTEV5eW9aV2JmRWYzYVc5eUdXT2EyNlFWSUVFb0c3?=
 =?utf-8?B?SmNHbUsxekZTUWszeHZDVmt2d3VuMXhIclJkbHZNV1B1d0dZbDdhQlQzaGU3?=
 =?utf-8?B?Q0cxdlZvYUIvc1pha0pOUnlYNlZUVGlWZDZ3WEJFYW1NRmtrVXY0Mk5lcWZI?=
 =?utf-8?B?ZmV6b0V2bkcybDFYOWJRWWxIbmQ4UnFlYzNIVGwzSTRYWGptZlRBNFlpNHFT?=
 =?utf-8?B?dVNmRXpiRDE1SHpBQTgwWXcvMEFWUy9zLzFnYk1yVEYrQ2UxTjBrZFEvNW5H?=
 =?utf-8?B?TmlXM1l2dlZ5emk1NmVQT2ZodTl3eUR6WVhuZWQ1MWdZZ09OYkg0eFd0RFhM?=
 =?utf-8?B?MngxYlZ1Yks2eVo5TTg5NTNVcDB0UHkxWHd3MVh4cXRBWm5zMFZTaW9YeHFJ?=
 =?utf-8?B?UHdDbmVBenhVSFlQUy9RNi90bG5NSVM2dHdFaTB6K1k2d08xMFBsYXlZM0Fi?=
 =?utf-8?B?bVRkekE0YWEwTHh6dWp6U0ZNSzBET2t6MGhSVFlnV3puNUhyYlN5b3FlRStv?=
 =?utf-8?B?aWVKb0Mvd29NNjdRRTFuT1U5b0wyTVdtaG5aWXI3U09uOUFqR0Z6ZSszb3Y3?=
 =?utf-8?B?elI3S1k4UG5pWU5JMWhvNlRQNytBWXNvYWlob2pCUWg3Ykc1VlY3TEdid2NE?=
 =?utf-8?B?K3NHc3NDNk9ybTY2NW5rRGJNZVVJOGVGaG1pMDAyc3ZTQ2xXMWJxWEJMYUJs?=
 =?utf-8?B?bUR5VGE1Qnl0YUxQL0xrZS9STElXUnVZcXRLMnlFVnNsZ2t3NGpZTkttSVYv?=
 =?utf-8?B?VnArMHNTZ1F0cktuUWNMVWoyTGh3amFXSVZWaGRQOWRnTGFKWU9yZVBDUUpO?=
 =?utf-8?B?Y3d3VDZoTlFEMVA2bjNHbFZHcWZmM3Rxa0NtSEFSZTJqMHBoUUJHb3NlNGw2?=
 =?utf-8?B?aGFJNjdCNjg0ZHBtdGZheGRpeUdHT0RxMUcvcnlNbHh5M0RwUkNBNHN1WWov?=
 =?utf-8?B?T0w2Y3RUUHBEZ0hCUDQ5aUFGQWZ0SHhwOW5PdHd2NUNEVEhEZTN4YXlYTkpU?=
 =?utf-8?B?RCtTUElpN0g4TnRkNEVwblVGNVIvVnpFTzFKZ1d2RUFNYzdodXVwTkg4OXcw?=
 =?utf-8?B?VTdNbWdvTUJoTEcrTUpYOVFraU9DbFlyMUl0RmpNZmxqVFBSMWVZZjVWZHNr?=
 =?utf-8?Q?UoBvoe+1slWNIX/wRvrAGpHO3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7efc58-f146-4caf-33f0-08db8fa53834
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:59:57.9688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeYN/WGQv8vz2X7gTSCgfh5edQJa8C3vmgYtIUCKfKC8Sj+HzRSOgVMMyvVANjxTsM+1duASzYXEnmqGWJFZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
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

On 2023-07-28 15:39, David Francis wrote:
> These flags (for GEM and SVM allocations) allocate
> memory that allows for system-scope atomic semantics.
>
> On GFX943 these flags cause caches to be avoided on
> non-local memory.
>
> On all other ASICs they are identical in functionality to the
> equivalent COHERENT flags.
>
> Corresponding Thunk patch is at
> https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/pull/88
>
> v3: changed name of flag
>
> Signed-off-by: David Francis <David.Francis@amd.com>

I made one comment on the user mode patch regarding the explicit 
handling of invalid combinations of Uncached, Coherent, ExtCoherent 
flags. I'm not sure what we agreed on any more. But I don't think we 
want to just leave it up to chance. Other than that, this patch looks 
good to me.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
>   include/uapi/drm/amdgpu_drm.h                    | 10 +++++++++-
>   include/uapi/linux/kfd_ioctl.h                   |  3 +++
>   8 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d34c3ef8f3ed..a1ce261f2d06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1738,6 +1738,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
>   		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT)
> +		alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENT;
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
>   		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 12210598e5b8..76b618735dc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -331,6 +331,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>   
>   		flags |= other->flags & (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>   					 AMDGPU_GEM_CREATE_COHERENT |
> +					 AMDGPU_GEM_CREATE_EXT_COHERENT |
>   					 AMDGPU_GEM_CREATE_UNCACHED);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 6b430e10d38e..301ffe30824f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -632,6 +632,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENT |
>   			       AMDGPU_GEM_CREATE_UNCACHED))
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>   			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index a6ee0220db56..846894e212e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -540,6 +540,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENT |
>   			       AMDGPU_GEM_CREATE_UNCACHED))
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>   			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 880460cd3239..92a623e130d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1183,7 +1183,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
> -	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> +	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENT);
> +	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
>   	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
>   	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
>   	unsigned int mtype_local, mtype;
> @@ -1251,6 +1252,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   		snoop = true;
>   		if (uncached) {
>   			mtype = MTYPE_UC;
> +		} else if (ext_coherent) {
> +			mtype = is_local ? MTYPE_CC : MTYPE_UC;
>   		} else if (adev->flags & AMD_IS_APU) {
>   			mtype = is_local ? mtype_local : MTYPE_NC;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 1b50eae051a4..e9ffcfc5dedc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1155,7 +1155,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	uint32_t mapping_flags = 0;
>   	uint64_t pte_flags;
>   	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
> -	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
> +	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
> +	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
>   	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
>   	unsigned int mtype_local;
>   
> @@ -1203,6 +1204,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   		snoop = true;
>   		if (uncached) {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +		} else if (ext_coherent) {
> +			/* local HBM region close to partition */
> +			if (bo_node->adev == node->adev &&
> +			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
> +				mapping_flags |= AMDGPU_VM_MTYPE_CC;
> +			else
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			/* local HBM region close to partition */
>   			if (bo_node->adev == node->adev &&
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 79b14828d542..629860dbc9ec 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -145,7 +145,7 @@ extern "C" {
>    */
>   #define AMDGPU_GEM_CREATE_DISCARDABLE		(1 << 12)
>   /* Flag that BO is shared coherently between multiple devices or CPU threads.
> - * May depend on GPU instructions to flush caches explicitly
> + * May depend on GPU instructions to flush caches to system scope explicitly.
>    *
>    * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
>    * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
> @@ -158,6 +158,14 @@ extern "C" {
>    * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>    */
>   #define AMDGPU_GEM_CREATE_UNCACHED		(1 << 14)
> +/* Flag that BO should be coherent across devices when using device-level
> + * atomics. May depend on GPU instructions to flush caches to device scope
> + * explicitly, promoting them to system scope automatically.
> + *
> + * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
> + * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
> + */
> +#define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
>   
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index eeb2fdcbdcb7..f0ed68974c54 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -405,6 +405,7 @@ struct kfd_ioctl_acquire_vm_args {
>   #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
>   
>   /* Allocate memory for later SVM (shared virtual memory) mapping.
>    *
> @@ -659,6 +660,8 @@ enum kfd_mmio_remap {
>   #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>   /* Keep GPU memory mapping always valid as if XNACK is disable */
>   #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> +/* Fine grained coherency between all devices using device-scope atomics */
> +#define KFD_IOCTL_SVM_FLAG_EXT_COHERENT        0x00000080
>   
>   /**
>    * kfd_ioctl_svm_op - SVM ioctl operations
