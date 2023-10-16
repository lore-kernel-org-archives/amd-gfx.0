Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF23ACDB482
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 22:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7F410E1F3;
	Mon, 16 Oct 2023 22:19:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7BD10E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 22:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvI+fk+6MmikjNQAksxajcEOzgtuKHeMgsnzOjoJqm7Oz/T9YorKRgxPqNznTkkyBM6zCgKkMKY/3gk+8i41GnpYNKd4mMzRratmulo0XU9Z/68C6CsB3RAjJYQfnGEKuwE7OsvZIMBtBGefOu3oZmyuhAuIm1jzZzZoM67BwGblX9qhaCiGL4D1CrFn6CxSaT4e9AxtRRSRB0pfOv3iI3tKo8MSO7q/3vyUqYBLxOCxXDLNJAtrRTULtf5bCaqArpv+HuORQzXzJmKU3xqA0gB2nA3VgA/VUdqhoKBUe4Es5FmtIXJX9FT32ZD7fm4AoZk0IrMt0bYD4XJrRX1d3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKiRySbbXJErE3jZjTfOPIRC9e+7v1AUfHiz7nh0AM4=;
 b=LcVjPhPspb0139h6BXHM1HgqGnvYiHuk6nboNweQKDJdr9OlzNjzw9xccgNO+/aHJ9fTWkLFMzv7sCnSE4fWwDgAUYcwhyc7HV/A/3NnVYTY7EnM8lrsX3Cd45WxuFy1JYWiDy41EiPKBB8HtdWhG+AyHdU5gRajmzPUkngAGmJhmgozHVWPgtkqGfVJoNFcUIozYR+X1htHXkXeh7qaTyrlVr8T/kn7bQYudbW12kNxDMs4/nvX0VC710nl0t41vcz7Fq21sXLinUhwD9kvo/biiK8bxd9cNXp3XrXPL7YsZ/PPwh3P71due5L1sW63H+akFg9ud4RIFlyUmbhMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKiRySbbXJErE3jZjTfOPIRC9e+7v1AUfHiz7nh0AM4=;
 b=DkgGB1x/136w2mDUgqXaXDlaUandodEBO/5uVYAS275hmWHM2Lgs820HhAnoAMvRvqvPSMFSCx6VyRXBGwX31xvjozcnUpHu+DilUjf8iyff9VmozgIpMsN7ecmBRhJCxSyvtJPAYHhLnE3oKyqgZi1OfGJAGJoEty1pRMIsUak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 22:19:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 22:19:30 +0000
Message-ID: <bfcdf325-4684-455b-8d0c-544950b91039@amd.com>
Date: Mon, 16 Oct 2023 18:19:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20231016144929.807268-1-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231016144929.807268-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d1b69e-3f81-4494-cb88-08dbce95f759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlOyxGYUMhnaSapT5Il5i1jqXHmhfArz0mGa0dDZ0VG9tfVED2oiZsZrXPlr8v7HyD47tMVU9D8AGoucRtoAzLTw9ZZSwvhjb991p2MU58LHcpEx2+l0ngRlMODCpaqN6JHE0dnOJKfoqoHhFmlPG0MrrEZyZ2WqB1e6wkn5VZabmJ0mijoAEU6AlJmc0PZZvXGeMWVRGriQ/4oZZ2kaNjh8+BJP4ACbK+R6dq/Z5qUuHRP3ilO/lqgNyzi3OtrBtiLWGy8xvqGwHeaw6s4hAjFEc2MtyRqXo9vF5fM5WkYsABG43TZQ2X1zb51IPXr1/fT5vUfIwLaFnB//2pk8VhCC6cV6FZZo8NNSIqgPVuhFCnVY7qsTx7Uaer1ZcHTTs/PNKYJVdEYBZBHNsPGdNc4V4f0qKQSHMz+gEh6sWvYMwOe9c7/DP4BVrYlwfWbADx7HQIcCJrKMuiwVcqtwJZBQEgZiVducxpCmaj25fOW9igwREhi0oGCGG6M9fuolAZu8QflzK7x1IfIcE9J9culwFz5xhjB7xsNhWTEegNJ95Dg0vgdOi3T6vxKLeDCbrRc375unjYRKTe/DtUk3bjfbnSNmHoSRDC79Yu4FR3wX1QPvT29EhfYditkYMbH6Bh2wpxo8pm0QmwDVZcSnrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(26005)(2616005)(83380400001)(66556008)(66476007)(8676002)(6916009)(66946007)(8936002)(316002)(41300700001)(53546011)(6666004)(6506007)(36916002)(5660300002)(44832011)(478600001)(2906002)(6486002)(38100700002)(4001150100001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdwUjQ2dFhJdHIweUQrSGFwdDNxOEZqNlErYXdPRjl5aklyY1hINUhaQ2p2?=
 =?utf-8?B?WWc4TFI0OUpnaDAyUFdmZ1Vkd1htOWZPUDZTYUNaTXdBbFNOMC9BUk1teEx4?=
 =?utf-8?B?ekpFRVVwT3J1UWZBYmZsTXpOZnJXQng0VmR0SmZYZzRPZURiN1hQQWxtdDFv?=
 =?utf-8?B?dE9MMTY4Z3JwRElmODZzTVN3a2QzZG8rOUd3NU11akU1dnJiTTVXMG1HT1d5?=
 =?utf-8?B?SjZENytEajVxa0h6NG1ZK0xranoySXBzOE9UbkhmalUwR05yaXBCeWEwT2lo?=
 =?utf-8?B?QUdsV1FQMTJhbzRBZDdGZy9jTS9ZT0h0cG9NVEROOThIYUx5RjdKYW0rTEQ0?=
 =?utf-8?B?SFJMVWs4dE5JdG1HeXVIRTk2UFlQZ29OS1dxeW4waE1NUmFPVlhuSkpUemk0?=
 =?utf-8?B?MkI5NmdLeS9MODNGYit1U3RqcGdLNGdVUkNQUk4xUTE3TlhmUlJZa01lenVV?=
 =?utf-8?B?RHJneEM5b0dRcTJPTXFKYTNhMkhzRVhUT1R1d3Z2MUsybXdzaEJURGRyNDVO?=
 =?utf-8?B?QXZFSndwb2hDME1qeURjS1JhVW1mVTBKUEs4R3ZNWEYrYmVnU3dic2x0ZEU5?=
 =?utf-8?B?bHJXVUtSTmtXOE9saFBkTGRjMExqaEU5RTUzRXRESFhvbzdsU3RIQjJpSW9K?=
 =?utf-8?B?anprMDBlZU1iK2p6RzR3bXliS2I5ZnducEJSOVhaZ052dEk5bCt1aE9IK1NR?=
 =?utf-8?B?ZVZpNDVTQnBsTDhkWGxLTlRYdlpCRURmYWI0cjdvN3VkQ0tNMnhmbWlKT01T?=
 =?utf-8?B?dVZ5ZHhuR1ZhcnlGZjlQZERLdzR1RHJ5OE13a05zLzNQa3FaQjBiODdDakND?=
 =?utf-8?B?QnZaRDlHYlo1Z1JDUGM3OFlFWnZBeFhZSjVxWHFzQ2xLMStMWlJtYkV0bk1o?=
 =?utf-8?B?a0FBeW9QTTM4Q2dJRCsxcFp3amk4TmpwMWFYdStXUDZyMHRXelczZUFPV2V6?=
 =?utf-8?B?OVZzZi9jOWIvZ1E0N2M4OEl6SGJXOEZBTE1RMjBJOFJSZUhPTTNmSFdVck1y?=
 =?utf-8?B?MXc2NVFJelgxUElvM1czNUtIWUJHbWJGZEJPNEZVV2pDd2lSemtpb011NVB0?=
 =?utf-8?B?N2Z2MVg5RjBtSTgxYjZTWDJIZndWZkNzNmhmMWp4YXVDcmRMVGQ0dTBFdkR3?=
 =?utf-8?B?YjBFRi9vMzVWS3g1TFVFckhiRXcyV3phVzN4T2tZMkt1T2w3ek82ZVJIcll3?=
 =?utf-8?B?YVc2OXRnazFtUzlIanJTZmNUZXJSVjZXdzlzUjM4RDRZRWVOK21WVi8vNnVY?=
 =?utf-8?B?eGk5RVVxR2h3VHhoZkpDc1hMcENER2ZnelB1K2NEbmlSVjFNNkZDd2dDWkdz?=
 =?utf-8?B?RGg2WUVveVoyRmN1cE9SSjlSWXd2RCt2MW1UaGIrY29KWGlQaFZaQXl6UEc0?=
 =?utf-8?B?VmxBZ3FzaEZ2bnRGSkJtV2s3bVp1bHJZZXRVdEZMMUNBSUhyU0R4UjdDTy9k?=
 =?utf-8?B?RnFMTWNBS2VlTmNZcFhWb2E2Mi91QVcrV3BLVGNoWTQwUzdvaGZNQWdUK2Ni?=
 =?utf-8?B?ZmFNdkt4cktPMDhzeHhneWNsaTdkcmQ4dzg0aDVaU20vSGMvbTRIYi9OL0dP?=
 =?utf-8?B?OStDNjNaV090bTNqSEdISFV1SHJIR2xQMlRnREx6WWhCUTU1bmlHSmZibW5q?=
 =?utf-8?B?dVhpL2s1N2IrTjI5U0RRS2NNSFp4ZUtOcldkWWNqMjRVdS9vV3hkT1I2S1ZL?=
 =?utf-8?B?eGRtdFB3UUYxNG4xd1pqbmg1amhTSWtYd2tFSlhCYzB0eXVWSFVNZXJKWjhh?=
 =?utf-8?B?eWVYeC9TYkpXczNOMjBDZExHbHJDRzg1VStMUjlyakZHWGkxZmhvSDh4UDFJ?=
 =?utf-8?B?SGo3S2k4bmpNWVZ4S2QrR3ZML2NWMDhmQkFEbmZoWTE4Q2FraldSYzExSDlU?=
 =?utf-8?B?YlBsaHQ3YnpSN0VOTUZDeE9UVHkwT2t1VUtUN2lvR3JTSWVSYnhqZXgrYzNp?=
 =?utf-8?B?b1M2TUdUYnA1dE00RStCK1JlVHNlN2FsaXNveExLdEJmM2xWQmdYMTViLzFR?=
 =?utf-8?B?eHNZaGZUUDQyNHF1R29IRkUvWjB6YjZHeFU5TWtBNDRTSUlGRWFmRys1c0hh?=
 =?utf-8?B?cEpOZFpWUCtWVHhPdm1FRVlTKzZVRUxzbjYxcytxSXRVeDJBYUNTMnN1SlFh?=
 =?utf-8?Q?fFXsHnASb3wMlvEUHMq8u72Pa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d1b69e-3f81-4494-cb88-08dbce95f759
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 22:19:29.9567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThziCLSh/jE0LrjwSoPe2wGOvikVEw09UcefHa90ioPqKopcvJuwwC2Frr9/NoCfvYdIHakZrNE1Op5sOhy2fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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


On 2023-10-16 10:49, David Francis wrote:
> dmaunmap can call ttm_bo_validate, which expects the
> ttm dma_resv to be held.
>
> Acquire the locks in amdgpu_amdkfd_gpuvm_dmaunmap_mem.
>
> Because the dmaunmap step can now fail, the unmap ioctl UAPI
> needs two new arguments. n_dmaunmap_success tracks the number
> of devices that have completed dmaunmap. If a device fails
> to dmaunmap due to a signal interrupt, n_dmaunmap_bos tracks
> the number of bos on that device that were successfully
> dmaunmapped.
>
> This failure can also cause the sync_memory step of the ioctl
> to be repeated; it is idempotent, so this should not cause any issues.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 +++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 14 +++++++++--
>   include/uapi/linux/kfd_ioctl.h                |  2 ++
>   4 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 3ad8dc523b42..781642871900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -302,7 +302,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv, uint32_t *num_bos);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a15e59abe70a..cbd6032f3d39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2094,21 +2094,36 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv, uint32_t *num_bos)
>   {
>   	struct kfd_mem_attachment *entry;
>   	struct amdgpu_vm *vm;
> +	int ret;
> +	int i = 0;
>   
>   	vm = drm_priv_to_vm(drm_priv);
>   
>   	mutex_lock(&mem->lock);
>   
>   	list_for_each_entry(entry, &mem->attachments, list) {
> -		if (entry->bo_va->base.vm == vm)
> -			kfd_mem_dmaunmap_attachment(mem, entry);
> -	}
> +		if (i >= *num_bos) {
> +			ret = amdgpu_bo_reserve(entry->bo_va->base.bo, false);
> +			if (ret) {
> +				*num_bos = i;
> +				goto out;
> +			}
> +
> +			if (entry->bo_va->base.vm == vm)
> +				kfd_mem_dmaunmap_attachment(mem, entry);
>   
> +			amdgpu_bo_unreserve(entry->bo_va->base.bo);
> +		}
> +		i++;
> +	}
> +	*num_bos = 0;
> +out:
>   	mutex_unlock(&mem->lock);
> +	return ret;
>   }
>   
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 06988cf1db51..a944e255de4a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1379,6 +1379,10 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   		pr_debug("n_success exceeds n_devices\n");
>   		return -EINVAL;
>   	}
> +	if (args->n_dmaunmap_success > args->n_devices) {
> +		pr_debug("n_dmaunmap_success exceeds n_devices\n");
> +		return -EINVAL;
> +	}
>   
>   	devices_arr = kmalloc_array(args->n_devices, sizeof(*devices_arr),
>   				    GFP_KERNEL);
> @@ -1434,7 +1438,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   	}
>   
>   	/* Flush TLBs after waiting for the page table updates to complete */
> -	for (i = 0; i < args->n_devices; i++) {
> +	for (i = args->n_dmaunmap_success; i < args->n_devices; i++) {
>   		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
>   		if (WARN_ON_ONCE(!peer_pdd))
>   			continue;
> @@ -1442,7 +1446,12 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>   
>   		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> -		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> +		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv, &args->n_dmaunmap_bos);
> +		if (err) {
> +			pr_debug("DMA unmapping failed, acquire interrupted by user signal\n");
> +			goto dmaunmap_failed;
> +		}
> +		args->n_dmaunmap_success = i+1;
>   	}
>   
>   	mutex_unlock(&p->mutex);
> @@ -1455,6 +1464,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   get_mem_obj_from_handle_failed:
>   unmap_memory_from_gpu_failed:
>   sync_memory_failed:
> +dmaunmap_failed:
>   	mutex_unlock(&p->mutex);
>   copy_from_user_failed:
>   	kfree(devices_arr);
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index f0ed68974c54..edeeac370201 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -467,6 +467,8 @@ struct kfd_ioctl_unmap_memory_from_gpu_args {
>   	__u64 device_ids_array_ptr;	/* to KFD */
>   	__u32 n_devices;		/* to KFD */
>   	__u32 n_success;		/* to/from KFD */
> +	__u32 n_dmaunmap_success;	/* to/from KFD */
> +	__u32 n_dmaunmap_bos;		/* to/from KFD */

This breaks the ABI with existing user mode, because this is the 
argument structure being passed back and forth with user mode. You can't 
change this without a very good reason and a strategy for maintaining 
backwards compatibility with existing user mode.

Regards,
   Felix


>   };
>   
>   /* Allocate GWS for specific queue
