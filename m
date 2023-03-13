Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B6BC6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 07:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A058610E47E;
	Mon, 13 Mar 2023 07:37:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66BF10E47E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 07:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZtGApuadveajNvRs8+WX5Jk+4ueBlRA1/OuQjCIEK8he8MbDsDWhg+AMPeUrCZl82DW6B4fsFcTpMDTEEh7vkREuoumJmHAY2JbS9bA2KvBHmyfsOMLX5joMHJsBOvb8ETi4HOO47h81OH6IXBidXg3qB+gmCAvDmZzARvxzMsZ8ybNFiaFOW3XNhK7x0Rm3v5V4SJeSnvQhBT+NS7h9M9isKSlzqyc9h+85Y3mhhtMuX91B1Xgd6OQmO8+pAHJFi+/zmSRZD3heGlnw8CLak2pvEWlCtI/+VSOt2vbs5IzpHPLrPtyyBi95EGRxa+1lUi7kgRAJbv0uoJlHT+nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeF9anZBIj2nssEwes/QRNEtqTsuHoQiLc1k/0lttq8=;
 b=UAWnycYzg4l5RubYcnbfPD1083BaYey6OlhYd4514WqHkPiqasUDjg+ckqiWtV2N1nukID1h+mJkGJLyrafN8LXRPsHNLc39cESNdoMmtaY9XSYlkZYRnmg5q36uas/cgb58L0oDsk4p4Ku9djQMyfvxtus4u8V7ywnw1HZySHoCTZTE25ceUv1u+8ODPvZ//DzaKHe8sQNLbc/ZlI66aWoRFCklXXWP2JT7o1iBymNY2cYIH/5oPIFWhA6y5ULEmNHSBfKyC38n5XuDlel7KHZf4w7gwFGtRYdc02m8HL4GH17Gya0CNH7YaigHILZXijmSWvC0dNYJWORoTupsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeF9anZBIj2nssEwes/QRNEtqTsuHoQiLc1k/0lttq8=;
 b=dpvxESymV5WE9YmkmzlTJWmqjx8df9O6YM9TW3xkAUC6D8lpSrSmKHpdUkUl/P0roq3lTHFXXAt3j+MwIHs/1/J2PIWpO03bn7uWeVSD3zrQJta3uvdrjNwr0rRIT/STl1wNZGgfGiHabtD8BHIxyMoIFmgbo+hosndElpJvLdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 07:36:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 07:36:57 +0000
Message-ID: <e4173da3-5868-3b21-f2c5-20d1645106f5@amd.com>
Date: Mon, 13 Mar 2023 08:36:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/2] drm/amdkfd: Move TLB flushing logic into amdgpu
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: ab56c26f-8006-4cb0-be0c-08db2395b9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wUyqeUYs0R2bI2/YutI2VbHiYeon9IMxm4vbSI/oOiq5BXNgLwL89yw1g/cMIyxRYftDNM4RHW5Q/Y0DwLBHNsiZhMAtUrCq4wopPzW5OQqMakybpu/LDDpY8Bl/hdRV52c12DkIWeI5bJMp79ifDA1fnWU99bmZ5NPxe5Zqcy3nStRsHZMnFAiUN6PW0oBTjfhyrBkbKCrWccMDu4z6eU+C7Xy3QeaTIbJGs/vXKCn6dUOT0IjATW4xhGASqC5VGAA4z+Y5ksDzYdcNoi/0g1bjPLll+zOx/Bk+ZThZZsXvLVPsF1s9A/dN+VVweipbSApBsiwmgdfe80LptyiB0N2R7tUE/sykpThQhDICwe5v2OMDt2h/M57hZ6T0hNBajHkcstB8iR5MwFAwOOnJrC8A44nZ6+ilna76GxEtICNQpicTRSVDdW2iNYCMYy9W2R46voyKCTvbwjbNijKI96F5T5Fhi4lXJofJ/HZk0y5fqWE/Fa3zJjDm5USrpgTBEZy56WI9SQJ7e5aZPkrgagWeDIO96doWW/aHN84wLEOsgJ31oeEL2DCsuDkT/hvyAAHN38eR32mKDE9prgTwlR3KH3yc5y6nDjRG/YYA14rAwoIiuUPgOsYGOEMycaxXc+SgECtkUkFTBbkGL7pBEnrbudfN+tfxjI90PRYoNNpQPzIAHOusFPmAy7O/zw+8IlCWtrAQhls6W1TbSgxrG7fsvfPCN2eZoX0IaXnH94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(31686004)(5660300002)(8936002)(2616005)(41300700001)(186003)(26005)(6506007)(31696002)(36756003)(86362001)(6512007)(83380400001)(2906002)(66946007)(6666004)(66556008)(66476007)(8676002)(6486002)(316002)(478600001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2pEV1NlZ1o0WGc2eVhwWTVlVjZkM1BxVEs0MnJWYXJsNkk3Q1hQS2tucFJY?=
 =?utf-8?B?L1BnVmxEUTBYMWdQZHFiU3YrejdWNHlSYTZRb0UxMWt5YlBBM21GSWg1MVMy?=
 =?utf-8?B?eEd6V0JURnIrbFhkd0JkVHc0VldWUWpOODZMbm14bTNjVTRiZnAvNE52QWo0?=
 =?utf-8?B?Zkl3eG5oUE5zL2NzWVpRVVNiQU1RNWxQSjFtM0tKenN4S2hRYjRKVHdLQi9O?=
 =?utf-8?B?R1VjZHZkZVprd0lWTlNLZENpVlB6dHdCd0p5MWF3R3ZEOVZDbEhmdjVGcXJm?=
 =?utf-8?B?SHJtQTJhNmh0NDl0WDZna0tnUndNVEY5dDgrUEU4VmhCc0JKdzJ1bXFQbGdS?=
 =?utf-8?B?cUhESFVHeW0rMFowczJ5bEhvY1FnaG9FRU1yZjI2dzNZcVJabGVMSk9nZElz?=
 =?utf-8?B?TnJHNnRRbTJ3UzhqemdlT09PdE1hWHBBMEJyUEkxZHhHWmVIK2FJZnpraFMz?=
 =?utf-8?B?bTVmWlFNZTQ4eUlkTzFCM0J4SnpMbWhpN2N0VWVyRVhrNkdQbGVtYTdMUlRj?=
 =?utf-8?B?SElBUTFnMHZ2V2ErTUpqRGJDdkVxZFA0UkZMR3BtNEtsS0hSN0tPSDYrazI2?=
 =?utf-8?B?Z3lmRmNjNERFYytXR1YrcElSbHhNTDZ3ZFJua2ZURWVuUU4zZ2ZWeVYwKyti?=
 =?utf-8?B?TFZZYWNUdTIvYUkyVWtBdjJHc1Z0UmJmb3lSMC8rK09sRmxRckNsRTE4MTg5?=
 =?utf-8?B?MXQza09ZalpnSElRemhiWVdQZjdMeVNaTXVUalVhVTZLM1RmSWJwWk82bi95?=
 =?utf-8?B?YjBsK2phMnpWekhlZnQ2c2tIdE1zckdJWGVyWlhCOXg2YmtLSlJ5YzZVVUwv?=
 =?utf-8?B?ZlpvTjJ0YkRYTHdkbFVNRHU0dmlYcDNZL1k2VVRKNkhsNUl4WXdKR2FJTW5t?=
 =?utf-8?B?YjBWR3lUd01kb2l5Z2MvUFYxZnF2WlNRZVJIOFZwenI0SVJDUWp0cHhPUXZH?=
 =?utf-8?B?aXYxVExJckplWVpJRlVrMktpUGhDSHhpTm92SVNwanJjRllTdjFDVS9ZRU9u?=
 =?utf-8?B?UjF4dTUrckJ1YmlrSkZKaFNlOUJVanpxSkxnVElQMXZOSExWa3AyK0k5OTNh?=
 =?utf-8?B?RDJJUGE0dVBzWXBJM2c5RHptb2x1V1lEOG5KNG9KSjg1SE9tNk9vcUZWNWdn?=
 =?utf-8?B?Q3JGZGxiWjQzSVZoL3kxc2ZxMU42ekdnMS9SQWN0ak56UmVFRnk5NitsRk0r?=
 =?utf-8?B?YW52T1JPM2RVOXFVYnFIcHpMdC9OcnFQbkxvQ2lWaVJiWEoyZW50VXBFb2dE?=
 =?utf-8?B?UUFiR3ptVCtPaVk1dUxhYWUxUlpMS0JMeHdCcUFkdm5lYUFMcFVPZkJlWEJN?=
 =?utf-8?B?Q3BpOXVReFFtTzF3eW1DdmMxZnhHLzdmNHBJZ0ZlM3FpOGF3R1RJcktSMjRW?=
 =?utf-8?B?VTV4ZksvdFpwYnJtc2IwdE5qeXpuREZlcnE5UVFNditISUFtRVg5YkF3eHF6?=
 =?utf-8?B?K1ZqbUpaVkhiM25UOTV6Z1RrNnIwc3hsYi8vMFZBUWtGR2ZFZWx0T1dhZzYx?=
 =?utf-8?B?SVZKWFI5Z2ZJSWF1Q3ZvRkZidzVTSHVKRVFPMFV3SVJHNmIwcXRwS1ErNmM1?=
 =?utf-8?B?bUJDdVdxUWdJWFVMWEFSdWlzWGRhWmJSSHcyU2lLRVRHcVlTbm9MY3ZrcXRq?=
 =?utf-8?B?YkhmRWZDVC9MSkpDY3hpeTBDd0dyV3pJeWY2a2hTT0ZaVURsbmhEUyt1NHpz?=
 =?utf-8?B?dUUvN3g3SUlibTRBY0sxVFFqSDBJWWJXZzBlNXhpbjV4UG1lc2V6a1BQQ0ZU?=
 =?utf-8?B?TVZkYzZKci8vUzNrcFhaS1dIcDhabHVqR1lzbCtSbEducnltRkVlY3N5Yk5x?=
 =?utf-8?B?MUkxQVZvRU5XQks0SHYzUzg5YVRBS01RTmVobWxFd0RCZmNTd0hNdEdyQXRl?=
 =?utf-8?B?OVRaWFdYeEZ3bklMZW9PblNGN2Y1dXpEYWFRVGEwRUt1VllmZ2FZV0p4NWpK?=
 =?utf-8?B?NVEyNG1SNFFsZVpHNGEwZzVLQkpoek1IczFVZW1PSXdmOGllUno2MlphdDRR?=
 =?utf-8?B?dzM1S0xUdUMxQmtVWkprTkpjWGgyVEJQZGJKMDJPU3FsZkNxcktEY0VBS0NP?=
 =?utf-8?B?cXBldnc3R2svcUZnQ1ZsRHEwOFRoSTNHR1AwbGJuYi9xLzFxcGVvcXgxWER1?=
 =?utf-8?Q?THd7dTrrgJN4UT6lRRz2J1PMs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab56c26f-8006-4cb0-be0c-08db2395b9b5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 07:36:57.8039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYlCXFLEwBDFhPpm/jZbAAFvfCfrjP8u7fF0g2m4Rw/BVPnbDXkhaFC5eI6LVXMx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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

Am 10.03.23 um 23:16 schrieb Felix Kuehling:
> This will make it possible for amdgpu GEM ioctls to flush TLBs on compute
> VMs.
>
> This removes VMID-based TLB flushing and always uses PASID-based
> flushing. This still works because it scans the VMID-PASID mapping
> registers to find the right VMID. It's only slightly less efficient. This
> is not a production use case.

On the one hand it looks nice that we can now flush based on the pasid 
without having the NO_HWS dependency (I hope that this was intentional).

On the other hand I really don't like to have any variables in the 
amdgpu_vm structure which are not worked with by the VM code itself.

That already backfired with the pd_phys_addr before.

Regards,
Christian.

>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 30 +++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  9 +++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 28 --------------------
>   5 files changed, 22 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 8816853e50c0..dcbd28e99b5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -726,31 +726,25 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>   	return false;
>   }
>   
> -int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
> -				     uint16_t vmid)
> -{
> -	if (adev->family == AMDGPU_FAMILY_AI) {
> -		int i;
> -
> -		for (i = 0; i < adev->num_vmhubs; i++)
> -			amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
> -	} else {
> -		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
> -	}
> -
> -	return 0;
> -}
> -
> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> -				      uint16_t pasid, enum TLB_FLUSH_TYPE flush_type)
> +int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			    enum TLB_FLUSH_TYPE type)
>   {
> +	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>   	bool all_hub = false;
>   
> +	/*
> +	 * It can be that we race and lose here, but that is extremely unlikely
> +	 * and the worst thing which could happen is that we flush the changes
> +	 * into the TLB once more which is harmless.
> +	 */
> +	if (atomic64_xchg(&vm->kfd_last_flushed_seq, tlb_seq) == tlb_seq)
> +		return 0;
> +
>   	if (adev->family == AMDGPU_FAMILY_AI ||
>   	    adev->family == AMDGPU_FAMILY_RV)
>   		all_hub = true;
>   
> -	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
> +	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, type, all_hub);
>   }
>   
>   bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 01ba3589b60a..dcaf69fd833c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -157,10 +157,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
>   				uint32_t *ib_cmd, uint32_t ib_len);
>   void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle);
>   bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
> -int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
> -				uint16_t vmid);
> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> -				uint16_t pasid, enum TLB_FLUSH_TYPE flush_type);
> +int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			    enum TLB_FLUSH_TYPE type);
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 03a3314e5b43..171de7da2959 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -290,6 +290,7 @@ struct amdgpu_vm {
>   	/* Last finished delayed update */
>   	atomic64_t		tlb_seq;
>   	struct dma_fence	*last_tlb_flush;
> +	atomic64_t		kfd_last_flushed_seq;
>   
>   	/* Last unlocked submission to the scheduler entities */
>   	struct dma_fence	*last_unlocked;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index bfa30d12406b..e029129308e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -715,7 +715,6 @@ struct kfd_process_device {
>   	/* VM context for GPUVM allocations */
>   	struct file *drm_file;
>   	void *drm_priv;
> -	atomic64_t tlb_seq;
>   
>   	/* GPUVM allocations storage */
>   	struct idr alloc_idr;
> @@ -1344,7 +1343,13 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
>   
>   void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
>   
> -void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
> +static inline void kfd_flush_tlb(struct kfd_process_device *pdd,							 enum TLB_FLUSH_TYPE type)
> +{
> +	struct amdgpu_device *adev = pdd->dev->adev;
> +	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
> +
> +	amdgpu_amdkfd_flush_tlb(adev, vm, type);
> +}
>   
>   static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ebabe92f7edb..48d7d30eeb24 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1591,7 +1591,6 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   		return ret;
>   	}
>   	pdd->drm_priv = drm_file->private_data;
> -	atomic64_set(&pdd->tlb_seq, 0);
>   
>   	ret = kfd_process_device_reserve_ib_mem(pdd);
>   	if (ret)
> @@ -1994,33 +1993,6 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
>   			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
>   }
>   
> -void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
> -{
> -	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
> -	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
> -	struct kfd_dev *dev = pdd->dev;
> -
> -	/*
> -	 * It can be that we race and lose here, but that is extremely unlikely
> -	 * and the worst thing which could happen is that we flush the changes
> -	 * into the TLB once more which is harmless.
> -	 */
> -	if (atomic64_xchg(&pdd->tlb_seq, tlb_seq) == tlb_seq)
> -		return;
> -
> -	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> -		/* Nothing to flush until a VMID is assigned, which
> -		 * only happens when the first queue is created.
> -		 */
> -		if (pdd->qpd.vmid)
> -			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->adev,
> -							pdd->qpd.vmid);
> -	} else {
> -		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
> -					pdd->process->pasid, type);
> -	}
> -}
> -
>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)
>   {
>   	int i;

