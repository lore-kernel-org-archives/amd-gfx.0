Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55319C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA7410FB3A;
	Fri, 26 Jan 2024 15:00:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20EC10FB3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isEr2a2oaToilZAtQ1ktHdMgQHWDZ1aTtRPseEv4/77fd0En0uG9SoiqqUhMHnibYplQ900Ud9HSQcq/DGHTf/6i+fV5lYCXdyr33RZBFf/uth/jw1Wma4xMMDt7TW7tvGb4r3GPrWULvnoEf4NoZ3GqfxlcUJu2QEYpBEpVXi5RX9BiiwcVMxQLJi2S2xOrqaGz/I7SSR4npd68bJWJDUMyD4v0c/j1gYa8WegBx+8mUot0j/lxTa6+bkuBiS6jgByOEpptJJMD23Fvnkwamn8ugWhZVsT0Vvd9p5P1FPG2nS3oRO4/CY4KSbeVRi/7F3LEJ61y5jC1x8GMXJpdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzRYfdiWd6Sl0p1fupPsAps/+XhDpiub4JCbnPE1JlM=;
 b=BCN+911WVaUuZN8UDTjccrMmxZ+vATCAFPSGN+6UEOsRqwzjyr+lt/17tDtl2dSUwI8xka2oTbGCk30W6KeWxjvfTITM44D0aXrP3naolZoPwlB9F4uGQ1vb/aUf89Pifk+eFKH1222VMtXUIZdSwypwtjjC6kfHiuknOegPuF1rZebC4NVzyqOlW5W+NJuhH3y7kdV+xVGkv5JipvH8qPKy1qbGrminpMln+wxtxp9fJm1IDhNY6RRcaBHKP35zm4ko8sgd/IVpmSUPUeuV5viPLR/uR7qrep3ZCKJ226CKcL7//crha/olo2+tAIWSuyQ4yXGYAv4FOp+Dsp+WSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzRYfdiWd6Sl0p1fupPsAps/+XhDpiub4JCbnPE1JlM=;
 b=2/MQuKzPAMCbIJgiJJqpD/Mtwm58zRNh/WPNifZGBxmfJaTv5cc1ZJK8XgjRqRRngwO0byVrmQy6QKsuXK0E20ARHm8X79h6a50Le4LWyjdlYBolKCtUceI6t3XVOXs5JkvQJzSNSGzXOo1jpgZvNXrDnpyTw8UsR4ws6wuRws4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 15:00:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 15:00:01 +0000
Message-ID: <9c59557b-f6e3-45a9-bd4d-bddea9339e92@amd.com>
Date: Fri, 26 Jan 2024 15:59:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Limit the maximum fragment to granularity size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240126143830.30586-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240126143830.30586-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 699bd4c0-a014-4f1a-c669-08dc1e7f7863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TydIoMTy25BYO8FKzLipMIhkUrEneWnQYOCUZediUnVT1U8cytsvFpXvToSePBZbZDBCbZqXR1FmabjVQ49ujj/pQjP2tgl0Mhw0O2quHJcMqj1nTpvEXsGqIdGAe1+pil3rlD0G2ywDS8swDxzvNBAhyPjAExHSCsnQtJu9t2viYWY2Tq+aTH5YYKo5Z2Pydp2zUxcLQmTwqj0PTW/M0ORNo2bztDMsCG9IgS/WcZALyD7Z29dbaysA7otDnn+zV9V8rm77sOqcfEVS5p7c9SYkMAgtOZohwFCiQrrOJ8Kt4MAHzVeBfGUuh/cmXFfPeFruMuU2iRUNQ4FBaHrErVANRp4QJcYArashogvX64qBYH5txkLk48dtxxaY4sjpZfO39AJyHNt8KDkq32bM7OBySJ6cPUljCgEe2Jym3ntZZ/efrYKaBXS3Z1JQyzx/O0JIeqU9cr31iNCm5fdQFUchLMJqlZT3gD6lelC/fiveglSG2vtkaomHLRNfqIzbh4kn+6i7KJVCyhMi4xoXDrHP8BQagU7aNOyZ5RRYeaUgtXw1NBTgSUddHD49REzl7/NIVpqS/banBbLo0Yead4Bp4JB9/VUW3n8aAWrE9SxOr96VfUp0fCuns9NeW40RKkUNa7bP2wzm8X0KbhkGfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(83380400001)(31696002)(36756003)(86362001)(6486002)(2616005)(38100700002)(6512007)(26005)(2906002)(6506007)(478600001)(316002)(66476007)(66556008)(66946007)(6666004)(8936002)(5660300002)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZmUUZFKzhpeHJ5U0g0UkdSRUptbCs1c2hPOEs3cWxBeExzYkxwR3pycUt3?=
 =?utf-8?B?UlpWRDRzY1ArSmJ4ZjB3OW5SZTNmS1ZDWC9OZ0VpMFZzck9sNlpHb0hYZUJZ?=
 =?utf-8?B?ck9MMEhOUzZZTXhicFVNNkt1bXo0dml5VVJRZjVUcW01MHJ0UkoxWnh3OXR5?=
 =?utf-8?B?aGpmUDk2elBRUzBScDRadklmQ3pmREdEZ1RYcklMTFN2THo2Ry9XRVBmYkxw?=
 =?utf-8?B?UFBOQUR5dnpqdEZUZmVOSTdRaEpXRGlUMnowNTJXL3NCVVlyd3ZEODVQTmhT?=
 =?utf-8?B?bUxDOTVYd2FheXlseDB3WXpZMmhhSmNBb2Z4eGZscnVWMEM5d1JmQ25SOWhz?=
 =?utf-8?B?UFpEdis4MjJORlpDVTNSOTVFWG5rcTJIOHpaV1hCcVpVMytyWHJuN2ZGcEZ2?=
 =?utf-8?B?OWxuZU1TcFpjR1BnRklnQzF3U05jV3VwT3I1VlJFUjY3S2dMcnVLQTdTdHZ5?=
 =?utf-8?B?RG1LTjQ5TEhpVit0Y2pvMU56L3ZlYTZLRmFIbStnSWZYckFFVHRsdzdTU2xw?=
 =?utf-8?B?d2g3MTd1djd3a2hCd0xlSHdkVWpmMlZjQTE3QkxPS0VxSWVNb3gyYndvNEZD?=
 =?utf-8?B?Mi9WWTVHZTRsNGQ5NUVaZjYvVnlWaXkwV1YzUmR0cTBkK3RyRkpUdlQzNWhm?=
 =?utf-8?B?dytLa0RBTStpOFhSOENNRGN6aUJQRVJ3MTdXQjYrMUJlaGdiVkw4U2hkMFlz?=
 =?utf-8?B?VVl6K0N4OGlvNVdMcXVOUHhuL1VwcmhPd0lab3RNRFFYTmhGSnZQYWViclAv?=
 =?utf-8?B?cWJEUVppWis5NHNTY01aTStiUWlZTW1CMndqRHMyQ0cvNmNka0xGT2tvVTJQ?=
 =?utf-8?B?WWsxUkJHQU1zVWJNRkcvaUpuZzd1WlRsR0dac3NaTk1GY1dHR1VSblVkNlFO?=
 =?utf-8?B?VUZsWGs3eEg2T2M1dE5BS2NTL05zajVtRnVzVndFMThYZjgrN09WMlpBelN5?=
 =?utf-8?B?SkxqZkNZYVBYK2tXQ0JqNG55ODBGZ084SjhNR3djakNsNEI1dVkrbDU4RG5I?=
 =?utf-8?B?TDhHUXVGRWRHU0ZpbmxESkdvcDhyUjNVWmppN3hVaTBRY3AzeHFkZTAzZlB2?=
 =?utf-8?B?OXlrMW9aQ1lYZzJEamlXOERVU3puSTdNbTY5UVNpejVpcmc5ZVdrZEk5MFlJ?=
 =?utf-8?B?Vk55Rjk0Y3lzc1oxQWF6VnRjSitNNXhLeHdpbERlSFh5Q2o5bHlLc1hiSnVv?=
 =?utf-8?B?Rk1Qc1g2ckVDSmh6enk3ZHdZcWt1OVdGd0U2TWVUZlZmVnh1VHJDZlJyWWFs?=
 =?utf-8?B?b0NnUVlpQWRydFNycEVtS08zRGhZckpSYmJhOHZCUkNuejUwV1czQ3RrcHJU?=
 =?utf-8?B?QkVxQWdtZUlPNkpPQ1plY1dRTU9ud1FtWE8xTkVNcXZMeE9GSjR0VG5nQ2N3?=
 =?utf-8?B?eGFnWGI4VC9JTzQ3YXFGSjVrOUIrYTBuVXFsVUY0WUQ0SVVFZnhzaFBuZmxY?=
 =?utf-8?B?RmFVVVh2eURzWG95S2o1d0hldnk1N1A4MWZhaWJsTjhZZUFlMlpXeGtNeGMy?=
 =?utf-8?B?NXZTMm8xVnovVnhEN09GOHF6SzdEa05ZMTl6MkhlTHRrNTdwWlAvRTZOV2ZP?=
 =?utf-8?B?VDNFdDI2TUxrckRGUG5KMkN2WlhxcHpyYmRhQjJ1d0NCZEdTOURyUXF1aVpH?=
 =?utf-8?B?MUZUa3haa2RFWFk3RW8vWlBYaFhYQmg1OTZHZERwWmZmOTVrczZNTFAvOEJq?=
 =?utf-8?B?RmJnd08wcGV5aHBsdkc4ekFxZUFwSDlYMjhvcGp2TlhZOGtKNnVqOENwNmpy?=
 =?utf-8?B?MElsdjVTYTlxUjJJcGpBUk03VTRqdXlNY3RhYk1WTXNST3A3SmVCNHJzbWti?=
 =?utf-8?B?RjdGL2UrM0xMd0FaMDNTNy81djl5QXRCLzVkb1d6M2lqbjd4MG1VMmp0RG92?=
 =?utf-8?B?eTh2TXRmcG1ITEVFS1BnY0RTKys1VlBFYzVYQkw2OWFKS3ZUS0c4UU01Sktq?=
 =?utf-8?B?SE1Ybk9USDlhQWVKMVc4blFwVmxyRWRVcjJwN3J2M0k3dWF1eFZ4ZFZDRXdU?=
 =?utf-8?B?cHNJTkVzLzdzcmZNalF1eVlVWFc3VXJNdC9PWWVPbjVJTW9uanlPckFIcTdn?=
 =?utf-8?B?Y01SYlp1eUNLQW01eUhmcnZtWkNXZzY4b1M4cXMwanhBUWwrbldYV3l1QlFF?=
 =?utf-8?Q?pePm++8SHdRCR75/LixhQ/Hw1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699bd4c0-a014-4f1a-c669-08dc1e7f7863
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:00:01.0646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de2hDMANmisc8iAuLzChF2Jj5zzndHqAZhAxb+rUUdRC9OTGydzj/ofLiV0u31av
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.01.24 um 15:38 schrieb Philip Yang:
> svm range support partial migration and mapping update, for size 4MB
> virtual address 4MB alignment and physical address continuous range, if
> mapping to GPU with fs=10, after updating mapping of the first 2MB,
> if the second 2MB mapping fs=10 in cache TLB, this causes the first 2MB
> access to the stale mapping.

Well that sounds fishy. When that happens with (for example) 4MiB and 
2MiB, why doesn't it happen with 8KiB and 4KiB as well?

Christian.

>
> Limit the maximum fragment size to granularity size, 2MB by default,
> with the mapping and unmapping based on gramularity size, to solve this
> issue.
>
> The change is only for SVM map/unmap range, no change for gfx and legacy
> API path.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 12 +++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 22 ++++++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  9 +++++----
>   4 files changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ed4a8c5d26d7..a2bef94cb959 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -897,6 +897,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>    * @res: ttm_resource to map
>    * @pages_addr: DMA addresses to use for mapping
>    * @fence: optional resulting fence
> + * @frag_size: max map fragment size
>    *
>    * Fill in the page table entries between @start and @last.
>    *
> @@ -908,7 +909,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> -			   struct dma_fence **fence)
> +			   struct dma_fence **fence, unsigned int frag_size)
>   {
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> @@ -1016,7 +1017,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   
>   		tmp = start + num_entries;
> -		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
> +		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags, frag_size);
>   		if (r)
>   			goto error_free;
>   
> @@ -1197,7 +1198,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   					   !uncached, resv, mapping->start, mapping->last,
>   					   update_flags, mapping->offset,
>   					   vram_base, mem, pages_addr,
> -					   last_update);
> +					   last_update, 0);
>   		if (r)
>   			return r;
>   	}
> @@ -1392,7 +1393,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>   					   resv, mapping->start, mapping->last,
>   					   init_pte_value, 0, 0, NULL, NULL,
> -					   &f);
> +					   &f, 0);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> @@ -2733,7 +2734,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	}
>   
>   	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
> -				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
> +				   NULL, addr, addr, flags, value, 0, NULL, NULL,
> +				   NULL, 0);
>   	if (r)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 666698a57192..b34466b5086f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -465,7 +465,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> -			   struct dma_fence **fence);
> +			   struct dma_fence **fence, unsigned int frag_size);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> @@ -531,7 +531,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   			 struct amdgpu_vm_bo_base *entry);
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
> -			  uint64_t dst, uint64_t flags);
> +			  uint64_t dst, uint64_t flags, unsigned int frag_size);
>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>   
>   #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..4647f700f1c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -860,12 +860,14 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>    * @flags: hw mapping flags
>    * @frag: resulting fragment size
>    * @frag_end: end of this fragment
> + * @frag_size: max map fragment size
>    *
>    * Returns the first possible fragment for the start and end address.
>    */
>   static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
>   				   uint64_t start, uint64_t end, uint64_t flags,
> -				   unsigned int *frag, uint64_t *frag_end)
> +				   unsigned int *frag, uint64_t *frag_end,
> +				   unsigned int frag_size)
>   {
>   	/**
>   	 * The MC L1 TLB supports variable sized pages, based on a fragment
> @@ -893,7 +895,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
>   	if (params->adev->asic_type < CHIP_VEGA10)
>   		max_frag = params->adev->vm_manager.fragment_size;
>   	else
> -		max_frag = 31;
> +		max_frag = frag_size ? frag_size : 31;
>   
>   	/* system pages are non continuously */
>   	if (params->pages_addr) {
> @@ -904,12 +906,10 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
>   
>   	/* This intentionally wraps around if no bit is set */
>   	*frag = min_t(unsigned int, ffs(start) - 1, fls64(end - start) - 1);
> -	if (*frag >= max_frag) {
> +	if (*frag >= max_frag)
>   		*frag = max_frag;
> -		*frag_end = end & ~((1ULL << max_frag) - 1);
> -	} else {
> -		*frag_end = start + (1 << *frag);
> -	}
> +
> +	*frag_end = start + (1 << *frag);
>   }
>   
>   /**
> @@ -920,6 +920,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
>    * @end: end of GPU address range
>    * @dst: destination address to map to, the next dst inside the function
>    * @flags: mapping flags
> + * @frag_size: max map fragment size
>    *
>    * Update the page tables in the range @start - @end.
>    *
> @@ -928,7 +929,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
>    */
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
> -			  uint64_t dst, uint64_t flags)
> +			  uint64_t dst, uint64_t flags, unsigned int frag_size)
>   {
>   	struct amdgpu_device *adev = params->adev;
>   	struct amdgpu_vm_pt_cursor cursor;
> @@ -938,7 +939,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   
>   	/* figure out the initial fragment */
>   	amdgpu_vm_pte_fragment(params, frag_start, end, flags, &frag,
> -			       &frag_end);
> +			       &frag_end, frag_size);
>   
>   	/* walk over the address space and update the PTs */
>   	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
> @@ -1040,7 +1041,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			if (frag_start >= frag_end) {
>   				/* figure out the next fragment */
>   				amdgpu_vm_pte_fragment(params, frag_start, end,
> -						       flags, &frag, &frag_end);
> +						       flags, &frag, &frag_end,
> +						       frag_size);
>   				if (frag < shift)
>   					break;
>   			}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ed35a490fd9e..d71b2c8bf51a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1488,7 +1488,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   static int
>   svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			 uint64_t start, uint64_t last,
> -			 struct dma_fence **fence)
> +			 struct dma_fence **fence, unsigned int frag_size)
>   {
>   	uint64_t init_pte_value = 0;
>   
> @@ -1496,7 +1496,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
>   				      last, init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +				      fence, frag_size);
>   }
>   
>   /**
> @@ -1579,7 +1579,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   
>   		r = svm_range_unmap_from_gpu(pdd->dev->adev,
>   					     drm_priv_to_vm(pdd->drm_priv),
> -					     start, last, &fence);
> +					     start, last, &fence, prange->granularity);
>   		if (r)
>   			break;
>   
> @@ -1647,7 +1647,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   					   pte_flags,
>   					   (last_start - prange->start) << PAGE_SHIFT,
>   					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr, &vm->last_update);
> +					   NULL, dma_addr, &vm->last_update,
> +					   prange->granularity);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;

