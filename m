Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D5CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 17:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9267310E174;
	Thu, 12 Oct 2023 17:46:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4ED210E174
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 17:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZC4ZwdD7GyzmpDaE5Omqzyhoiq272CAZdPQXa2dzwGYCifHSuPXIUjmE0WG/6dM+f9WMpSoJJGltqm3QKEr34gbfBgF8b9ShvGfYGgoASFLIvUnc46YFzJ/jwi1xRJKmF1iVo6iotVR/McKAtmuTCmkr0LHKyxokbr9T9+qvob2mk2pdxCmMPypciDbYUQeKNBf8ZciF9KsYaCTtpzciMSP7QM0aFx43oDU7nBqgyqF+mXXiefo6z/kiw0ixCgvFsYaFbB5fbzeexNpTaItt4ajj9wtU84gUxHBToc7z97782vqExRVoNEP+MFiwFkD69iCdsckDhEqYGYXtD1obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToPUBKC3tDwViSUG2aBfOc5cl9kuJe02oJ+S8b8UyGw=;
 b=fZbCH3F21FKRK5Olk9aq1LXV1BWe/J4cjeV9AC0/IXAkneYD/HsqRi4LKGS84AIF6S71xRRqI8sN/69DXkMioZTQFZ+PAwfMj/0k5fpg//Ve1foK534oWCNXFpScSxXMOdQV8S9e0QFG9fUXeODp2nfPGLAgAKBnWTez+ri5hWlWgjFVV8X6sRR0PXOuxbb8DLKOoB26x+bgOUV1ZoJDWAVSd3vXa2DXBAP6ppBDd2gfzQMHwxuPyynA31x+R9BDrIvWes0A5bGM9SL6kHfqa6sfMdmFPa7zCWZWqjV3Rq6eOEKTNfIjjpdl3zAwoyDnKni+IRoAG0TtW6H83Qo/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToPUBKC3tDwViSUG2aBfOc5cl9kuJe02oJ+S8b8UyGw=;
 b=IJHbNBFXrhZGbeU9rOzxeKkYduPDFjddypT+VRRFM+2iBTenc7ZbbIHxsBP5CBbgPraQSPxPk81piRB+d2iRdIG3BGcqqSby1HweDKSqqh/xHHTtmdoN+r4iWIWrQiTviX3Dx94But75yqYFwmhwxwVNF6yQxgqMnX0Dn+znoS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 17:46:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 17:46:13 +0000
Message-ID: <e484a814-e067-4b82-99dc-4e1290aa7c2a@amd.com>
Date: Thu, 12 Oct 2023 13:46:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add EXT_COHERENT override for NUMA local nodes
Content-Language: en-US
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231012163941.553980-1-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231012163941.553980-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffc73af-b7db-4a8d-f604-08dbcb4b20df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28TiR656bHjsAbDhZ3HxHVYmHpMCRErFsRW7jwky9Mm0LgMuBL1uWMACLbP+AqAt+yq2Kgu99Dt3EQ6ctrpq7ffpHry2JjV2KiCYpVqzzZ026XvKmwjFa5SXjN0grqpT3goI4HEe5dWoI0k3zUhYYDnYKuVeyR/HCytUAx+AWqz4BcQdmmRYXlYELcfBS2FN1X4c7TndyahQd7Bx4h/MkSLLIXxxRXZYYwlYTPsVR58fr7T/49jIrhtI7SmiSvinvMcmYoG6kY960wZJyHKkQK5n7neBlw30qILjXVZEaxe4uQsJwbX1cswn0lBKrNiuA1q6VpGNKw9+u5cQy96cpNmvL3KZiLkJMkQsOHbyq7ajO+73AwGv8+zFdXf/XgSAi62bB+/ZhqmtehfxgpSLwm3c82eKsrxbUsWiEg+aHa+wrsXTppy3wxbxIpJIqa0gVRhLZvX0UUU2pzb88tlFZxPPi84gPFPBvz4/l0ForwL18TSMO0/Vu+33TxiV7RYu+Y0n0ABDfTBm6yfAtxTPBvyyQDMbGTTCV/vnmrroIsFwX4vQVDZnd5ZtWT0UwBpZZFDTDatXl8U/bne24eH7oFLctdwsetXm5tlWW4GHWVtuyXI33hBrCQ4Ys2ZbCpJlwn0sAKqigX8PXpX+ZRZW6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(316002)(6636002)(38100700002)(110136005)(8676002)(8936002)(86362001)(31696002)(36756003)(66476007)(66556008)(66946007)(31686004)(44832011)(6506007)(53546011)(2906002)(41300700001)(2616005)(4001150100001)(6512007)(6486002)(5660300002)(26005)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2I1dFBxSjRmeWtTVTdoZzZBMGp1bnNpQWVYdTFvV1FEVFM4dnB0NG51U3FQ?=
 =?utf-8?B?TExMWUxNTjNGeGhkRkZDZWZhV3ppNDFuanJVRTBQVDh0TmZNWnhHd2dzUGVh?=
 =?utf-8?B?SDNqL25nYy9qU3dKbGFCSjV0WUM3ak9LWXdiK2M1UGJWWVZOeGwzcDlQdHYv?=
 =?utf-8?B?b1ZOVWpDSGVDRTZKV1hJRTZoa3pFM2JTTldsVlFmNE01VHQ3b2RqUlpPa2dJ?=
 =?utf-8?B?U2NsYWpqSkJkOHIrUTBseFlXZmRIQUhiMVdaeHIwSjJzaUMvcVZ1RDJyeEkr?=
 =?utf-8?B?UlNCb0FqRmxOa3pYQktNRnJuR3NaTndWVmkxVlB5cGVKRUxxVFhRbGh6Qmhw?=
 =?utf-8?B?dVJYRElzdUZha0xTclVPNDdMZWpSYU9vZ2c1VDdrYmhvLzgyK3FsUC9TcXZZ?=
 =?utf-8?B?R3dFNWUzL08wRjliKzc0RDltVlB5eDZUV29wY0pYK0RBTjF6RTJiVDFGYjRF?=
 =?utf-8?B?MWs0eEVxaVFmUDBJbDdhZ3BUaEFFcHh4c2pxMnQvRkZTS3Q0RlM1ejM3cGh4?=
 =?utf-8?B?dFg1Z1lMNUZnSEpiQWtmZ0tzNXZKK004NWE3dExCNUZCYmkwd3dWV09uUGtm?=
 =?utf-8?B?SFhneHBCMFZCQjMxMzhvd2lhdm93emNKeUxDRjI5Yy93cUNmUFUyQ2o2STZy?=
 =?utf-8?B?YWczbWRkTm1MVW9peE5tSGNONDVKNXlWVXJaNG9hdmN6UjE3N00ySStFVDdv?=
 =?utf-8?B?aVM5RVRiVGg2RTloSzBLSW9FMWxSUDZiWTNmR0hMQzFxVDJRV2JvbW11aEhI?=
 =?utf-8?B?MkNTZGZOTjJLZVk0WUdMZWpraFAwOUV2S0hLeEd1ZlQwY1dlckhKajhJUFNW?=
 =?utf-8?B?ejBFRXkxd0p5SWl3bU5RVjBVdkZqNGVYT3hCa21TcG5JMVlnWFFpVHlYemZM?=
 =?utf-8?B?QkJpcGdNK0x3RUV1dDNreGNudWN0NnZHeXRxdmlISFRYai85cExwdjE0U0M4?=
 =?utf-8?B?TGFhd3NWVnc2OElSUnZTU0hrQXNrTXoxMmpHYjdxbnhnUEZqOWVaVmtDb2x4?=
 =?utf-8?B?bzZQZ1hxdXJjTjI5bmJuTnlKVGhYUkRBNy80WGRHYjlrM09sQjBEYzNOdHhK?=
 =?utf-8?B?RngzMlUrTk42cEUyc1BCM0g2NlhNNEdiT2tXUk1ocDU0ZzJHTUYvalM3ZUp3?=
 =?utf-8?B?eklvRFdFMFEvNWRzMlZQamUrWldyd2xLMTNOOVM4SWxtRU1ZSElRLytxVGht?=
 =?utf-8?B?eWNIb1l5bkt6cVZlRDFvTUc3dzc3WUhVd1hpNmVUbFR6N1NDbVpwZDdTYmM2?=
 =?utf-8?B?RllWZS9CQU9DTTdDZmNtTEhOV3BxYjhCVGN2Zk5JMmpYOEVML3h0OThDc3VX?=
 =?utf-8?B?RWxDQjdPdXV4bTZNWWd2a1Q1b2g3dmQrSVo4ZmttU0IvZE5ZWlpkRnB5Qlgv?=
 =?utf-8?B?RTVaSWM5OWxUZkJlR0JnblVuU25mS0JVd1IvcWpaWjBwZXhDTGZpb3pkblNs?=
 =?utf-8?B?T1htdEVTTmRMK09NUXA2dnMxSnFPNE01U2RVdS9rYzJTWTNPMjZidWw4VVJP?=
 =?utf-8?B?dFVTZDlnQVlXZHZKN2gzdlRoZ3ZEeC9uenU4MnZHNU5oWk96a3REa3F3cE5h?=
 =?utf-8?B?UWN4dG9HZ0RmZUtUaFNRVFVoN3FyTk9LcnVNc2hmNzFFYkpKMWZIZEswL1V4?=
 =?utf-8?B?MzkrbnNPMjRFTVVYZnhGMXdvbnRFN1RtTHJpUmxyMDRDSEI1UkN5WDE4SzI0?=
 =?utf-8?B?d29IcENEb2pKQ3ZURDU0azhVLzBpVU5MYUVVb1hCZ3AvaUE3MXNxNjBpUmhF?=
 =?utf-8?B?U2lKb3Azcnltc0toa2JWbE1VUDQ1R3RCa0g3TFY5NURabXJHUG9VRkZQNi9Q?=
 =?utf-8?B?Wjhha1NaQjVycWpvUkxZT1NVNG54K0N3SWp3ZVpOM3J1VXBVN0wwRzRBMnVN?=
 =?utf-8?B?U0V5a0tadTRNZ0NRZElQaUhkVmJraFhERjBPcEdHZVJVcURMYm90Z1FjUk81?=
 =?utf-8?B?RGxvU3BEVXR4ZnNEaVRXaml2N3poc2JIVXJjOWpIN3dDUlhiMkFOVEVwNG9G?=
 =?utf-8?B?VjNRVExvWW1zQjBIc2M1dG9oZVc4KzhmRzNESCs3VVBZL2RDNFFCZHd2b1h3?=
 =?utf-8?B?d1FucXlVanh2ZWFTYk9kRVRtVDJCS3dUeU53TkZBZXJUYTl6MUQ1eWU0YTRy?=
 =?utf-8?Q?aPVYxflE4QukxzmNpcakS/S/w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffc73af-b7db-4a8d-f604-08dbcb4b20df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 17:46:13.8896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sFCnq54LIDOhyONhx1s4netSk3s3g15dkJSXVNWZhCigNEudQZwKV0FwQzu8wD55KwbhcbqJEKsAWo2KnuQ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

On 2023-10-12 12:39, David Francis wrote:
> On NUMA systems

This is not applicable to all NUMA systems. It's specific to big APU 
systems with multiple NUMA nodes.


> , local memory gets the local mtype, set by an
> override callback. If EXT_COHERENT is set, memory will be set as
> MTYPE_UC by default, with local memory MTYPE_CC.
>
> Add an option in the override function for this case, and
> add a check to ensure it is not used on UNCACHED memory.
>
> Signed-off-by: David Francis <David.Francis@amd.com>

With an update to the description as above, the patch looks good to me. 
Please allow time for Christian to review this as well. Then feel free 
to add my

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 13 +++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  8 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 33 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  6 ++---
>   5 files changed, 41 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 46d27c8ffff7..189341944bf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -761,6 +761,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>    * @immediate: immediate submission in a page fault
>    * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
> + * @allow_override: change MTYPE for local NUMA nodes
>    * @resv: fences we need to sync to
>    * @start: start of mapped range
>    * @last: last mapped entry
> @@ -777,7 +778,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>    * 0 for success, negative erro code for failure.
>    */
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> @@ -815,6 +816,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.immediate = immediate;
>   	params.pages_addr = pages_addr;
>   	params.unlocked = unlocked;
> +	params.allow_override = allow_override;
>   
>   	/* Implicitly sync to command submissions in the same VM before
>   	 * unmapping. Sync to moving fences before mapping.
> @@ -1062,6 +1064,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		trace_amdgpu_vm_bo_update(mapping);
>   
>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
> +					   !(bo->flags & AMDGPU_GEM_CREATE_UNCACHED),
>   					   resv, mapping->start, mapping->last,
>   					   update_flags, mapping->offset,
>   					   vram_base, mem, pages_addr,
> @@ -1257,8 +1260,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		    mapping->start < AMDGPU_GMC_HOLE_START)
>   			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
> -					   mapping->start, mapping->last,
> +		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
> +					   resv, mapping->start, mapping->last,
>   					   init_pte_value, 0, 0, NULL, NULL,
>   					   &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> @@ -2546,8 +2549,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unlock;
>   	}
>   
> -	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
> -				   addr, flags, value, 0, NULL, NULL, NULL);
> +	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
> +				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
>   	if (r)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 6e71978db13f..9ea8b5b644e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -244,6 +244,12 @@ struct amdgpu_vm_update_params {
>   	 * @table_freed: return true if page table is freed when updating
>   	 */
>   	bool table_freed;
> +
> +	/**
> +	 * @allow_override: true for memory that is not uncached: allows MTYPE
> +	 * to be overridden for NUMA local memory.
> +	 */
> +	bool allow_override;
>   };
>   
>   struct amdgpu_vm_update_funcs {
> @@ -436,7 +442,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 9b025fd17b84..80273809c93f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -842,7 +842,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   	 * to be on the same NUMA node.
>   	 */
>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
> -	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
> +	    params->allow_override && adev->gmc.gmc_funcs->override_vm_pte_flags &&
>   	    num_possible_nodes() > 1 && !params->pages_addr)
>   		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3a1050344b59..1456f76b7fb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1251,12 +1251,15 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   		return;
>   	}
>   
> -	/* Only override mappings with MTYPE_NC, which is the safe default for
> -	 * cacheable memory.
> +	/* MTYPE_NC is the same default and can be overridden.
> +	 * MTYPE_UC will be present if the memory is external-coherent
> +	 * and can also be overridden.
>   	 */
>   	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
> -	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
> -		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC\n");
> +	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC) &&
> +	    (*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
> +	    AMDGPU_PTE_MTYPE_VG10(MTYPE_UC)) {
> +		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC or UC\n");
>   		return;
>   	}
>   
> @@ -1283,15 +1286,23 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   			    vm->mem_id, local_node, nid);
>   	if (nid == local_node) {
>   		uint64_t old_flags = *flags;
> -		unsigned int mtype_local = MTYPE_RW;
> +		if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) ==
> +			AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
> +			unsigned int mtype_local = MTYPE_RW;
>   
> -		if (amdgpu_mtype_local == 1)
> -			mtype_local = MTYPE_NC;
> -		else if (amdgpu_mtype_local == 2)
> -			mtype_local = MTYPE_CC;
> +			if (amdgpu_mtype_local == 1)
> +				mtype_local = MTYPE_NC;
> +			else if (amdgpu_mtype_local == 2)
> +				mtype_local = MTYPE_CC;
> +
> +			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> +				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
> +		} else {
> +			/* MTYPE_UC case */
> +			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> +				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
> +		}
>   
> -		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> -			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
>   		dev_dbg_ratelimited(adev->dev, "flags updated from %llx to %llx\n",
>   				    old_flags, *flags);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7b81233bc9ae..bbaec633a806 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1321,7 +1321,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	pr_debug("[0x%llx 0x%llx]\n", start, last);
>   
> -	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
> +	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
>   				      last, init_pte_value, 0, 0, NULL, NULL,
>   				      fence);
>   }
> @@ -1428,8 +1428,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		 * different memory partition based on fpfn/lpfn, we should use
>   		 * same vm_manager.vram_base_offset regardless memory partition.
>   		 */
> -		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
> -					   last_start, prange->start + i,
> +		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
> +					   NULL, last_start, prange->start + i,
>   					   pte_flags,
>   					   (last_start - prange->start) << PAGE_SHIFT,
>   					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
