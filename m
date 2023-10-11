Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5B0CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 20:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5164210E1C2;
	Wed, 11 Oct 2023 20:31:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D8010E1C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 20:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifeSd/OtM0CLinAbgD4jJpo3i55G/+006jAQ8bk02GrHB3GcgKpO0I1W8Gdy5fjwBvOP8wnxNwnOZpty+ixAZTgYgLlkFdqfmlKGJP7ORukcYnmBmUHkDBZVuIwLtzOShYVYlAh9l1XqEFmxEBTu7eOerESz16E7aBgZvO6Gj/XvxpRlor7BQeherxwK8AQWgszoIqXwy+1VhlzyGYhaLIiCACQP8cX/eg171ZJAjDs+2ZPuVXpoVT6+ww0moLjNnzBLvXBck/0SH+eAuqvJrLtC5682trnKpJXNfLlCorNew1OVmwk94/s5kzgIToanOVfgxdv34j1REThABReobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7wR+65FEc6es2/lboPMRpQ3qmrLzYr2ESycz4DLn7k=;
 b=j1OMFRJk5BuyuNQoQ/j4un5DugBhqtHfJZy5flfRWeowWQ6Ss0UqnPpR6R199O9OjZnI2Sli/NLUV9r6RymP0HVJQkSiRpl1KzH+WZ0dT8iyvxW16djIYA2kNiYcwAXOfLj4NMOwP2nprt6a12AMiI6zRTU4938XOOGQatnTjbl6Hn/YhiELY0905zhLw73xntAQgDtc9LfZ9SJZonCRSUttxgYDJWPtOmS04K1sDAgWqnCwQDnJHQECbdzgzU8oBOynn5nc6DmXFk/3Cu2dk0+b9IPMHSYbJTSpzPwp8r+e4IF/BvTM1wZDD9XdUq2W3hfm5twvCKiIsyx63zXp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7wR+65FEc6es2/lboPMRpQ3qmrLzYr2ESycz4DLn7k=;
 b=HY/ixBQuWANcXcMc64p6+qDOdmiNUQ6UgFm5/KU3BHk4kBa3RG4IM3xoOTTYohYb+5Bvs/+S9ZJVSZRDCLvHoQ85Flf2L/aTzhbhyi7Gu+WW5ZLU2VGN7tGJCLZcEgPRFR8r565gN7tl5uY0ErO81v0yG3WwyXWjncX52SsD76c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 20:31:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 20:31:52 +0000
Message-ID: <51b90826-77ac-4e50-a5d0-c505b201bc11@amd.com>
Date: Wed, 11 Oct 2023 16:31:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231011182235.569096-1-David.Francis@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231011182235.569096-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 56de22dd-44a0-45b4-bfc3-08dbca991a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WX0QRi8rgQcxsGJRd7mDan1lbGoc1A8qZxCUJukZIbFSeLNMDVRW3r/aGpV2KqvbN3eHOfEZW/8SrlsmmGQZOGjhn8KjYSxuR0eK33m3ArPrIms/fbE4CF1DwvU5ObBM8jfO0MnyXg3ddSWawVwii59I0HINVr8q7fAuw4n/fEx4sKELFx6OtSIePhwZYqCKNOOy95Eb8yayWsFVYmkR2vCA0XetC9y2aean451WTzpsDq5Y+sEeXhHDYtagxn2Bp0VXRz/Dyaekhm270u0Tka4w5S/vBXa6FE0q5qoexQsjHyoUPxWSB77oeAcpyFO+BOQmWS7DSgHVb1ud+d2Av7jy/xGF8nMwm4xlJCQj+HrmD0Nlw5wT3heM47uPLAO+RiaPIFO3ZE2vYfFf0QCtG9/ldee8V9JIUXzWJ+HsNQfGdhYDt2CCJFJJhRwF74TmJATk3Gdb6tkVNLPRuZj+kbPXo0vZANz+zeLuxkZBQ1q62Eh+YWB5/AaxuuXScIurEDy/6n4Wg+xMNGiZsiB52oYQjTv4mifvHfm1b1nLpe8E5vUbOSvpNhJhOL2s08OrbzsjSSKy5ZhhvYr2FYdM7D+QHzPSmaAFQz5tpHRCYn39Z2DS9eO5w8nQE7E+hg6GK+vPiFAQB9Y0kyU2WaD0zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6512007)(478600001)(6486002)(66556008)(2616005)(66946007)(83380400001)(26005)(66476007)(316002)(8676002)(6506007)(53546011)(41300700001)(2906002)(44832011)(4001150100001)(5660300002)(36756003)(86362001)(38100700002)(31696002)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUoyQk9Ic3ZmSk8yeW8rYTVaeFhMM1BxTytIZ1BhY1VTNnVyaGlLQ2szTHBR?=
 =?utf-8?B?YWlwbEwzV2ZZZTRGc1hYK2FteFMvQjFKdVhKOS9ZTjZua29aQnlWaGEwMy9G?=
 =?utf-8?B?cGJ3Zzl5MW9UeER5ck1yT3pqcThRVmFIT3AwZjJVb2ZyYXgzN21CVXJSUmpG?=
 =?utf-8?B?TVhNZjhtdVVFbWhhRDFkY3dkYWszUjcrTTdZMUtkNFd6NjhScnVzMDE1aGhR?=
 =?utf-8?B?V0FjTGJ2T3hXNkw2YTdiNWNWMG1HUUpKaUlNYllOejdoUVNMRENJSTYrb1Fz?=
 =?utf-8?B?aHJvdElOTEtRYWgzOXAySGFVK3VEVklRdFRJcVBYa2FYQlZJakI0b3lKMitK?=
 =?utf-8?B?T3JiYmE2b1REaE5CVXRzMFlHajdFQ2NQb2s4NmhSUWpONU4vdTJmK2FPTDBX?=
 =?utf-8?B?dkgyNURvS2NFWklOeDJJL1gxMGI1M1M4Mmh3dGUvM3pFckIzMHdtMEowb2VD?=
 =?utf-8?B?OVBxSEx1TSsvZFNwQm8vQVhBSXMrV25BNmZrWlcvalhMWWV0SlU5S0J2MG9I?=
 =?utf-8?B?cUZPNFpBQjRVeU1nYW5IRVFRbDdZZWMwaDVId0s1R3IzZ2FHV0lrNlJqSG9O?=
 =?utf-8?B?S2NjZnNLQTlYYW1QRlg1U3IveGFLMmdLdm5BWEdvVS9xcmRScjhjTGdVQ2VI?=
 =?utf-8?B?L21qZkRoaUhVcW5vQWREaEZ5RWVhZ3BrUUhEb09ITzZIUUU5azNKMUtaMHNU?=
 =?utf-8?B?bkVGSGtSVkEvVnR1eDhLWnZjSllRQkNYaEI1dm9DeU5salZUV091NDdkSkFB?=
 =?utf-8?B?NFB6aXpGalMwakR6MTFLemdndll2TTRMM2daWHNxYk1pL2JiQnRzNytDVzM2?=
 =?utf-8?B?K2VidCtZRFV5R2ZBNExZT2ZnS29UUFJyREFrUGErZkJVemRjbWlVOG9mcS9n?=
 =?utf-8?B?UnpjNklueVdzQlFWdGpKUlEvZTNTKzl2QmVDMTY4aFhCTjZVenAxNnMxTENj?=
 =?utf-8?B?Yzl6bzIrNy90K1k1Qm5DU3JYZmttcUJ1MUEzWUk0VnlIWnF0bDFHRFFhY0N0?=
 =?utf-8?B?enRiZW8rc1NBK0s3U2JlVE5vYzJkTVVxU0dwOW4yMGcvWG1nOTYzTTNLZ2x4?=
 =?utf-8?B?b045YVlzbGJuYlhHRXM5K1dMQmcvdXVNS0RocnFMNytPYit0MWpnRFQ2ZzBh?=
 =?utf-8?B?cDJlZS9MWmphZTNCMW5qUkhqTGFaVXNhSVIvZTI0ZHlTNm5wSDZ4Sktzc1pD?=
 =?utf-8?B?a1AxT1Rvd2ExSDhTeFY0NFF3TEVzZ2huNTJwY3hqV1lDWlpoQ0VNR2xLT1U4?=
 =?utf-8?B?aC8yMllTaVNwWkRxWnZEUkUzdWRQV00zdG5JM09pQzNrU3d0WUlrbDhMZkxr?=
 =?utf-8?B?cXc5ODlkQWtBRmZMN1dyUUxMcmdoT0Y5MUxaNm1iaUYvZUpSaDdseU4wUUd3?=
 =?utf-8?B?V2tsekFTV05KT1lBQUE1VDFVOGNLWDczMjFqTVVLTUI5d1VXTGIzNWpkc2tz?=
 =?utf-8?B?aHZkU2JFdS94OVBSTDExK3JpejR5cm5uWjV4RzJjaXRrSmhoQ2lOZlpBZTdM?=
 =?utf-8?B?c0QvWXF1RjIyQzBiYmFnR2hlQ0djYXRyZXFXU2cxNDE2WjNpdnZsRlhtU3lu?=
 =?utf-8?B?V3gzUHdaVmFNZk9GbHFKMjJPZE01QTh1QmVwQll1WXVIV2FJQzc5NHVwb3kx?=
 =?utf-8?B?NUhUWktOWVJqK1ZCRExGL3FTYUxsMndScVg5WU9CZmNCUzJJellBN0xWVk5Y?=
 =?utf-8?B?dW02b0JPRWh6R25BWldSVVpKNnRjeTRXUWFzZnc4eTViN3R1RDFjdjVDajA4?=
 =?utf-8?B?dURXWVR2R1RhaitEQVpFVUFBNXk2YVowVXJxc0tXdlNUaVUrMHgzMlpON05j?=
 =?utf-8?B?Nk5MdlhwSnFvQWl1bnczd3VWZ0gvOHJaUmk1Q3dpMVFLYUlsa0k4MFNsM1cv?=
 =?utf-8?B?M3dmbnNSODNYRVNEUHllK216MGFtQlNvV1JWSzlvc25paHFtV2NMbXBPNUlX?=
 =?utf-8?B?OVVpVnBhVkdFSHdUZTVDRGRJRmFLZHYrNWw3WFdJMWpsZHl0TTRKNWNMb1BL?=
 =?utf-8?B?QVhmUVZZcWZPc2ZTZW4wOC9Sb3lzNmZCZ2FrRjRyc25lK3dRQ1NCSnliNFo3?=
 =?utf-8?B?Ykx3MVVqbktuYjd0QmZPbWxWdmwzVXdmWmRrbmlYVGd4dWtKK1o0WmdNeGZN?=
 =?utf-8?Q?KtIK5ZO/1ONXbSqjsluDPUEI1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56de22dd-44a0-45b4-bfc3-08dbca991a87
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:31:52.8241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2K1ztQPLsHBW+VZdfJrOIf1urVSt9ZDSrsbBBIXdoqexU3FeQTqCWFMsLBVK2okxR45UuzgzrM/BJYZQhAogtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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


On 2023-10-11 14:22, David Francis wrote:
> dmaunmap can call ttm_bo_validate, which expects the
> ttm dma_resv to be held.
>
> Acquire the locks in amdgpu_amdkfd_gpuvm_dmaunmap_mem.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  7 ++++++-
>   3 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 3ad8dc523b42..dba4f6b7a2f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -302,7 +302,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a15e59abe70a..808deec8aa58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2094,21 +2094,31 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
>   {
>   	struct kfd_mem_attachment *entry;
>   	struct amdgpu_vm *vm;
> +	struct bo_vm_reservation_context ctx;
> +	int ret;
>   
>   	vm = drm_priv_to_vm(drm_priv);
>   
>   	mutex_lock(&mem->lock);
>   
> +	ret = reserve_bo_and_cond_vms(mem, vm, BO_VM_MAPPED, &ctx);

Looks like you copied this from somewhere else. Do you really need to 
reserve the VM here, or just the BO? If you only need to reserve the BO, 
just use amdgpu_bo_reserve.


> +	if (ret)
> +		goto out;
> +
>   	list_for_each_entry(entry, &mem->attachments, list) {
>   		if (entry->bo_va->base.vm == vm)
>   			kfd_mem_dmaunmap_attachment(mem, entry);
>   	}
>   
> +	unreserve_bo_and_vms(&ctx, false, false);
> +
> +out:
>   	mutex_unlock(&mem->lock);
> +	return ret;
>   }
>   
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 06988cf1db51..21d4e7d46238 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1442,7 +1442,11 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>   
>   		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> -		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> +		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> +		if (err) {

This is probably not correct. The only failure case I know of is, that 
the reservation is interrupted by a signal and returns -ERESTARTSYS. 
When this happens, the ioctl will automatically get restarted after 
handling the signal. We need to make sure that we handle this restart 
case correctly. When this happens, all the unmapping is already done 
from the first time the function ran. All we need to repeat is the dmaunmap.

We already handled this scenario for amdgpu_amdkfd_gpuvm_sync_memory. 
Make sure it also works correctly for this new dmaunmap case. Basically, 
we don't want to accidentally dmaunmap the same thing twice. And we need 
to make sure that amdgpu_amdkfd_gpuvm_sync_memory is harmless if it's 
called multiple times due to restarts.

There is a test in KFDTest specifically to try to recreate this scenario 
where amdgpu_amdkfd_gpuvm_sync_memory gets interrupted by a signal: 
KFDMemoryTest.SignalHandling. It probably won't be able to trigger a 
signal interrupting an amdgpu_bo_reserve, though, because that's very 
fast if there is no lock contention. So we may just have to rely on code 
review. Or you can try to recreate the scenario manually by returning 
-ERESTARTSYS under some conditions.

Regards,
   Felix


> +			pr_debug("DMA unmapping failed\n");
> +			goto dmaunmap_failed;
> +		}
>   	}
>   
>   	mutex_unlock(&p->mutex);
> @@ -1455,6 +1459,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   get_mem_obj_from_handle_failed:
>   unmap_memory_from_gpu_failed:
>   sync_memory_failed:
> +dmaunmap_failed:
>   	mutex_unlock(&p->mutex);
>   copy_from_user_failed:
>   	kfree(devices_arr);
