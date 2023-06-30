Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E1FEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 06:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA9D10E10F;
	Fri, 30 Jun 2023 06:58:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990BA10E10F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 06:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFCk5382F5FXt6OHXhY/YK8dhf+mXMdrh1br+s91/QVN9OdouG8f6ZjrHkI9RnlxpuGUj/PpthN/FerGE8x8sK0a/q59ZVrbt1AH1R+IzR+qiZZ0fVS9/pzV3jYinC3xEKzYUjZ7LVEVhc6HY+fcOp2bPCAmHA7E2GaSN5M+kyyMmio5UBQEAGWH7m8q/6WmwckuKyMMUuuwDtb4zR+KTVy5/YRQ4FaIGnvPVCp/H2y8c2+IOJMQXU00qJGfVUU2S1PuRJ5ins7xiDwmU8mGzd29NRDj1jL3pk6JkLvmpRlWCkrNqsOj5u3revy/WnRya5w8B6GrgDIJd/zCcUrM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BShfber/djISuLITep9/27T/1t6juGNyxvn6/7iK0w=;
 b=c+67DUnFZ2ArOjRarg4rl/5Uo3GLBSluesEGSNStAdUR5xqrq3SLsxBI3GN7GNVqnQaHw+byhLPYnGscL6hfKTnW1Px0iinkgGxE7i0AM8tXQhJAwjE9H2ncopiVyb6KDS9yaPDUn/B5ggKlvPrZwrjeJ5wFYZZPrwC3F6jQArNUJ2sdw9ZjY8RpCz5i25ahGibuMnDS25f7JyhE/1Ao+/bQBzyh8gbjYpQ4GSZi11TpnCd+sLbZo4TCNj+EMyqDCMk27/X/bcUem8UPzs+brukZMocQo4/lMYS0cB52MS9EJguZOrto6sl0xAz0qhPJFFzRYq7fy8tbvMwtqXBEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BShfber/djISuLITep9/27T/1t6juGNyxvn6/7iK0w=;
 b=tXDiu42Z3VI7c1scuPj48qAPN17owt9mLeHjcuXOFU+j0oSBnPSnV+Wivnf/fHqpHTtlD6BUN18mNUq3YOESs7JPRmH7Bmjcyi143P6mdZnxI/xoGXxn/U2dDoSaVcknyuE2vmrJ0IFIgJLEQW4JRfD3xZ8XVV1pap7SQKb/Fro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 06:58:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 06:58:49 +0000
Message-ID: <3ce1264b-dd02-f553-01b6-e6eb404dfdb5@amd.com>
Date: Fri, 30 Jun 2023 08:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: have bos for PDs/PTS cpu accessible when kfd
 uses cpu to update vm
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230629160927.1044392-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230629160927.1044392-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: e0864265-0334-4348-03b6-08db793774a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4g72P1rjxmq3tNyhJ9KEIZr8gNzafFeD3MksoKHIL70SdOUugmn31KQrdopDXInyA28tu05jsZImZI5Pzp7gW030pqVVAsQ+N1XCjem4HSwa5fpMGlYWomfCGSq2JXNAgCrhifXUbjTRHkz+hfRa+tXZTl5ouWof2vWgspP61DHknUrTLWRnpVjPdiw1rLUFvgks3R95uF4THR/rfDDpF1oosTVoH5fmhfDP+VRapx6GBLu21GMGea0T5y80vk4aoiWbpiQYdHy6gao8prO3G0crpdkFeimBZtN5bZeLf2V/uc+8ZFQfs94EAVl/6OD0sC7yOz+uzvz/HfXZU4hH6U/gShZLZ1Qsi9Xmq8JrqPhwgHFgWfk1J905+PI69sEsBw+LLXjNhC7R4BjhlckUDJOKVUBFW1N6sG1ENfOz7HTDFKC9W80LJNXzalcYiQbL+6zlE4lPEPEE75qkw7YMASg/kZEseaVvELquEg4KqS3YFrW2kpLcUBX1ih1S4jVZzvndJsAx910dkMAbZMfqmNW9cDXMTH37Ta6qGFfrGaD8kA7F0ZrQI3W0UXkQGhvdNv025bTsBQubjr3BDn6NDkmg/xq5r/FYwH4L/ObUBINSkvY5mcP8bVLtHh3DxHjLRQRuuFfAaHy0+FG5kQUbmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(8676002)(66476007)(66556008)(41300700001)(66946007)(8936002)(316002)(6506007)(186003)(6512007)(478600001)(6666004)(4326008)(2616005)(6486002)(15650500001)(2906002)(5660300002)(38100700002)(31696002)(36756003)(31686004)(86362001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01RK29nVTNNWEZaZ2V0VGFJdHA4NEg4ak9reWJVZEhleEVIMTZOS09PK0Jl?=
 =?utf-8?B?SlV3STZ5UHJCeHFCQXdlYWlXNFdWdDV0WW5HalBQdmRpbmErdXVZa3VUUHZq?=
 =?utf-8?B?N0hkUmhSajhJUkJzTjlFQ0FYelV3RmpCOWpKUXR6azd1WCtqenRISDdhbUlV?=
 =?utf-8?B?Z0p4dHNjakplUDlOV3VQZkZmR0V1c0JYOVRFSmdSazdwelRDeGE4T2RMd2ZL?=
 =?utf-8?B?S05uSHVYSXBNcmwwMTlaaGZ3a0prdkFLY2dXOWNra2tmQUc3UGM2SWRlbW80?=
 =?utf-8?B?bCtWZ3ZiSzRwTU94Ni9KV3RWWERFZkg2ektTVzA5Q0lxNEQzdnpaZFp6YmdE?=
 =?utf-8?B?MDJ2WDVLMkhvNCs0YkdkejZ1ZnJGN1M3MFp2NC9WTFl0enJlOEt2dUFmWjdh?=
 =?utf-8?B?UkNGbjhzdDY0cHFadkUyR1ZhV1lWcFlMUExpK3hScjVjbVJMcXU4UjBkV1hw?=
 =?utf-8?B?OHBnaE1QL1dxK3hsZTUxMHRlMmQ1ZlNudmhWS0kybWFsdWtjY3E4cmxtSnow?=
 =?utf-8?B?NC91M3BFUmlxOTZrTXpoRG5ubStQcXJRdW1HaGFjUTJ2TGpGMnp0U3E2eWI1?=
 =?utf-8?B?K3QrbXZUMjNrdHlJekdTcURjWjE5SjZPWk9lK1hGckFoRGUrNzEvd0hTQk5J?=
 =?utf-8?B?N1QrekdNY0ZrZkwxOFA5bGtsbnZQVVpkVjNnS0FmSlhRQVh1eFhPNFcyWmh0?=
 =?utf-8?B?bW5ET29IRm1Ya2N2ZVIwKzMxbjNCK2dETGUzY3gxN2JGZnhTemg2dzcxK0Vr?=
 =?utf-8?B?bTJoNGRYREdwN3MzUDE4VmswSFpuVkhmWDQvQTFzVmdaRk9NTDRrQ204REV4?=
 =?utf-8?B?TU04bXpEL2d5VmRUdS9sc3ozaERvUzM2L3FHRjJlL01wOWxzbjlBaVVVYWVj?=
 =?utf-8?B?WE1CNEZxb0o5Y0VBWE4zTSt0NlNYNVNRd3o4anRpMTlDeVRIZXBWWW1ySmxE?=
 =?utf-8?B?dWsrWFJWSlFNZFdLdkNUUWhrN0hBdWM5ckpHaTFNT3JMd0VQbUQxbUs4Y05P?=
 =?utf-8?B?ZS9DR1pWNE1MYWRBR3J2OG1pOGg4eVBiT1pXRndLMjNuWVdETWo2OFZHWFhm?=
 =?utf-8?B?Q1pjZUUvRm9KeWhMaDJVem12d0FaRGRLL0c4NG10aVpJQWphNkUxSGtNTDBL?=
 =?utf-8?B?djI4VFE4ai9KWXR5RWtXVllzSG1Nc1l0aW5KZkdJbW0yWGRxTEVMcSt5Nmw0?=
 =?utf-8?B?dWhHdGxOZVpjeXREUHE1NG0ydGxSRWdVSmpWb25veS9uU2UwRkhpaDArVS9k?=
 =?utf-8?B?Zk80TXVOYVVJbkIySFNXTmJQaktTMktVL1J3eFJFaWVrRDYwNGhqWU9lQ2hp?=
 =?utf-8?B?YkpBdjRPMk5aOHBMRkJJdTBjT2xnU3BCZWd1dVZnRmsyRDdpS0E4WkQ5QWU3?=
 =?utf-8?B?UFIrNGZKUjNPK3VhU2czMHcxaFZKRGdaSGRhYXZCT3BhRUxhaEJ2cVZwbG5s?=
 =?utf-8?B?dUVXK25jUUhUSjVWNjhKK3VUUkV5STFQY21rWW45NnFtNmpvR0xBcXhWR01X?=
 =?utf-8?B?ZEwvc1RjZW1YNlJqT1hvUHdoRGdkYkNzaXE1alNsUi9CbG1XcHJsby9vSUFw?=
 =?utf-8?B?K1h6TlVBNjhjUUJBd1BHazhFelB4YzhIREVtdkN4T01oVW82WHFnK1VHM3RG?=
 =?utf-8?B?MTkzbnNDT3NoZWNpVlBYS3YwNUlnWUoweGVOajQvS3k1Q2haYnpqSGVEUlVL?=
 =?utf-8?B?SXNnVHBpNkgxcHhSaHVzQTA4WVg0ZHlzYzNuTlg1ekJ5MWJ3RW44OEFJbVR5?=
 =?utf-8?B?R2NuZHZqQzhzUlRHSXZyZHVKb0tYT1pyeGd0S2hzWjBMZVB3YjJPdlJWOGZu?=
 =?utf-8?B?cVdJVVhaYlNqRDMvZTErQkRNVFBlVENBZzNrS3FReWxKWDZRQ3poLzN2Qkd0?=
 =?utf-8?B?K09SK1piQWxFamdSUXQ2NlNWMGQ4YXhwQlc2V3E1dTlHN0dDdXI0Y05yTVFC?=
 =?utf-8?B?Ry8vRTRuTUkvcm1JVUZoakducWpjMzh0U3BFK0xGOUU3RFd1WHE0L0NVbFFh?=
 =?utf-8?B?bGx0SzBhaGNwM2NTV2FJSFhyTXpMN1BCQy9PakREWElCR2Y0bXlyZmNwMTQr?=
 =?utf-8?B?U2RjYXpoaFBzcjY3b0hMOHFjZmdZQktsbGRvaGtvQ0FMTFFldDAzMXlhUUdq?=
 =?utf-8?B?TVl3Y0ZRVW1MNi96R0F2Uyt2clNmK25SNUVRa05mSVRqa0ppTVAvdWE4eUFv?=
 =?utf-8?Q?Qt9O6L0N7AbwTV7lJFgFBNK3L5kCmcj/csmvrbVOIytB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0864265-0334-4348-03b6-08db793774a4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 06:58:49.2055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I2LjT2/ykeLoybBxNieRgXEFdYvVl5sMzaL/ZNAy10+jD2WaNlAXemQ7KInOIIr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.06.23 um 18:09 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When kfd uses cpu to update vm iterates all current PDs/PTs bos, adds
> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED flag and kmap them to kernel virtual
> address space before kfd updates the vm that was created by gfx.
>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 ++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 28 +++++++++++++++++++++++
>   3 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 291977b93b1d..dedf1bf44dc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2278,17 +2278,14 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		if (r)
>   			goto unreserve_bo;
>   
> +		r = amdgpu_vm_pt_cpu_access_root(adev, vm);
> +		if (r)
> +			goto unreserve_bo;
> +

Please call that after setting vm->update_funcs.

>   		vm->update_funcs = &amdgpu_vm_cpu_funcs;
>   	} else {
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>   	}
> -	/*
> -	 * Make sure root PD gets mapped. As vm_update_mode could be changed
> -	 * when turning a GFX VM into a compute VM.
> -	 */
> -	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
> -	if (r)
> -		goto unreserve_bo;
>   
>   	dma_fence_put(vm->last_update);
>   	vm->last_update = dma_fence_get_stub();
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9c85d494f2a2..9b3e75de7c5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -491,6 +491,8 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>   #endif
>   
> +int amdgpu_vm_pt_cpu_access_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +
>   /**
>    * amdgpu_vm_tlb_seq - return tlb flush sequence number
>    * @vm: the amdgpu_vm structure to query
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index dea1a64be44d..a08742191b7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -1044,3 +1044,31 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   
>   	return 0;
>   }
> +
> +/**
> + * amdgpu_vm_pt_cpu_access_root - have bo of root PD cpu accessible
> + * @adev: amdgpu device structure
> + * @vm: amdgpu vm structure
> + *
> + * make root page directory and everything below it cpu accessible.
> + */
> +int amdgpu_vm_pt_cpu_access_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)

Rename that to amdgpu_vm_pt_map_tables.

> +{
> +	struct amdgpu_vm_pt_cursor cursor;
> +	struct amdgpu_vm_bo_base *entry;
> +	int r;
> +	struct amdgpu_bo_vm *bo;

Please use reverse xmas tree for declarations and declare variables 
local to the block they are used in if possible.

> +
> +	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
> +
> +		if (entry->bo) {
> +			bo = to_amdgpu_bo_vm(entry->bo);
> +			entry->bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

Probably best to move this into amdgpu_vm_cpu_map_table(). This should 
allow us to remove setting the flag while creating page tables as well.

> +			r = amdgpu_vm_cpu_funcs.map_table(bo);


Please use vm->update_funcs->map_table here.

Apart from those minor cleanups the patch looks good from the technical 
side.

Regards,
Christian.

> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	return 0;
> +}

