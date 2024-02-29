Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7DBC48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 11:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1C910E03D;
	Thu, 29 Feb 2024 11:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z0ufUwzb";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F1910E34B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 11:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LStNznMKYvyBpLr0F49kHpBqCXS94GL6YAJZLZo7SL85LI1ruCPRb29QjELSSM7jA+5gpKgujMcAkx5MCaBE78SrX82p5e/OD5CF/fWUq7zGBtDgzuE85xZjIL+IZpINm3gRIedjHZ6unZL4RAYW7o6vguVrwBZp4FeMp7BJbYVjkG82IxCfqfnMo76CV+JH0vdfyOh+6zQYvZfoEqslZEQycGUkkuAY8MXbvVg9nlpIjDO1slm/WDMxw4Raggk5obA9fdTY/of0w6CzyqtCZDs5TmLLDcPxmdV6GHlwOE6C5XSNjZEdFuKC9po3CrBCP6PjI+NF1gYScY3woAyHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GufFDABH7cfwbmUwNNbBxIH1RG3HvRxu7OxD1qTOGEg=;
 b=VLBjBM4kaT3dqpQHi5i2IMpK1bCFIRYwTpnhNENrDq8ByS9FfegOI6LZ3eFeZ4zbztzCptFHU1R+20DbeGXuELcbbNe+eb68H92qSNlMQtM5Mg57efxXeHA7977H6wH9bgOUECMCi3nkY9l0xzj6WvB9EW4LkYtzpnbE9K3HoiYcUMPLqsayyIoP/rLuOGDuT4Onuc6HiBbTbf8Rg+PXSBc8vPlQHoFRC04c6IMckXtr0FWlij8cxCrx9POWOUb4sT6wL4yqEZ6cz6zH4VG0WX7Ezp658tdCo8XNziOLoGsfqHvLfKVgJ/9w4ZuIEfpMJbRyIvDkbJUR+CRpu0qkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GufFDABH7cfwbmUwNNbBxIH1RG3HvRxu7OxD1qTOGEg=;
 b=z0ufUwzbhP3gX/RpKo0zeZ7UqzoBPUYMypi6MGRWSuztlNN3dxBe+5d8S/n9eE/sas6EDcYlTwFfqNF27uGKERMx61WFEBKnZhW6oiusYGuoF1saOV5mQ0UmT1aIA5S2V4kuTzQ3TOcysQUOIVVf5u6XevbdKEjl3lHSwRcdOoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 11:31:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7316.031; Thu, 29 Feb 2024
 11:31:19 +0000
Message-ID: <292500b3-6f9e-477a-9ba3-7116da007a91@amd.com>
Date: Thu, 29 Feb 2024 12:31:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Content-Language: en-US
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Yifan1.Zhang@amd.com
References: <20240229055124.2094798-1-Jesse.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240229055124.2094798-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d4b88a-a875-4158-ce1f-08dc3919f325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkWjZ/bjLeit4/b8A51A9AY1OMrifvYE0OGS1pnp+aDA/xlhHtm0Dv3xLfXuAC+iAI9myaXxnnAAG5hJ8atdy7Jm3IWjNtaaNvNKUfcW+hVV/8J7OIh1r2hf7qFAxbNxIYX6R4KnDzMmU7/NLltnKUq2zutiWUOl88v8gL9TKdRESR2f36ML4TNK8gzRuhjA64aGDLTy+sOFU6wbtK4Xq8nMyEsv4COPlXU9bpPh6/YLCknpismQqKb3oQsnBb7nCGDkmZcGgI2iCRR1q9pFME5rIxdTLdamsTJLhlHRhehd6WHhIvKEKRNJm/v1yT5VDGAvjTd+R5YF88q/wZ9KfnwaKNR4gRHvSdXJZ/nvy31HIK4JmOh9k7xnFjzriwveGwLNFG9d/+RxRPLvUfGVMoqYU/XKPbHWbuL3C4yCrjR0Kleu29UaNNZXJxRnGmzIQu57g/Op551utQEc/4P80tQIQbhxenEqMOOyPIEAq0aGjRITUvbZaqJ+02liRLkj43gWJaVtaX2L3A4XP8mIS5DVWQG7O46y6D3NPt4hlA6obeil7c8zdt0fvwJzGPjGpgaKpJF2m1NYKGeyFwYBYB3KCl2il5u8Txm9ERhZ1fr57y4ZQUmCZA1VrkMpXIpE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBHai82eHRPeFloSlRMcWVzUTAwVkJDRkl6QWhoL1VSZDJLY1VxTzFoeUtC?=
 =?utf-8?B?QlB5c0hYK0t3ZjNoU01YLzBzR3JHVlRtbGdPZmIyRndZV2l0QVB1UUZrZGx6?=
 =?utf-8?B?YUZ5bWlZclUvaUIxdEEzT005WDgzUlA5MWZVVVg2NERtOFlUWStrT2tZeGZs?=
 =?utf-8?B?dTZIMHNTMHlNVGt4N0w0TzBvcm9idmZBeENOSXc4anYzbHI2R2h2Wkt2clRL?=
 =?utf-8?B?SkRuVGdsODlXYlZ4eWRhNGlwOThzM3hiQmg1bWNFTXd0YjJ1dTRBd1FWK3o4?=
 =?utf-8?B?ZWxQQXdJNjMvYUhQd1liTGY1VU9oUEhlR055NmtIalpPUk16YzRZMk5OUXBS?=
 =?utf-8?B?QXNXZnhxZVFTTVpON3JpOEVCZDc2Q25VbGJIaUxzKzQ3Ui81bTk0SW84Kys4?=
 =?utf-8?B?SkpsS0J6ekFXTm9ja1RXbzZBMEhHV2tCaFZ1MVRiWC96L0lTN0pscjFPSjZt?=
 =?utf-8?B?a1FSK3g1SXd2VU53K1JsSU9FaVlocUFzMHlwei9JckpCaUFBdzgvUG5xRGdU?=
 =?utf-8?B?NGtPNHhmNWJtNWUza29SKzV0OTZrditTVDVNYU9NR016QWtWK1MxMTBJRHRH?=
 =?utf-8?B?Zm5PY01nd25aV2hVQ2xzOUxVVFlhbW1oMGFFY1VvSTFUY0VzVmZMTTR1WXZE?=
 =?utf-8?B?QkhlTmkrR0lZdU11TkhGQysvN3c0SER0NTNiN1FkMDBGZU5lblEwODlDSU5i?=
 =?utf-8?B?SUIvOHdnSUgwL3cvM1VJMVNJUERaUkx4eTNmV3RBVlZoNGM3c0h2UlgrMWNO?=
 =?utf-8?B?WldXaFMyRmRjVzFNK25UUDRXSlVBQzlVenhrMUIvQUtRWTZsTGhlbENEUENQ?=
 =?utf-8?B?TUY2MEtJdU91UnAvUG9XL3Y2YXhSbWZ4SDFGdjRFY1hUL0hhWUFUdXoxaS9R?=
 =?utf-8?B?SUVRYkNscFBQaEpJeDdxbS81RnpZSm5Td1JpRjlET1RVOUQxZTJoOTNpck5x?=
 =?utf-8?B?ZTFSRkw2bEJveVBJKzBYVHk0MW1hWHBITG5iT3lhWWluaUg1ME96Zk82WnBi?=
 =?utf-8?B?WWJoWDZYbCtkYTZxS2c4QXc1QitZdTlFN2lNS3lPYnhsVlQrZ1JFKzBGallh?=
 =?utf-8?B?YzVHNWhOQ0N3dGxvR0VMUjZjK0pNcEF3SkNYdkkyMmRwOExaWFo5NTZpMWlB?=
 =?utf-8?B?RkhydE55MVduc2plT0RWeHMxL0k1eGpXMlpQbmFBai9FZHd1ekNoTi9yaVZV?=
 =?utf-8?B?NGxla20zSHZmY0hTSTNQOG4zSjk4REdyMnp3SmgvUjVzajFjZ1VzOU1RSU02?=
 =?utf-8?B?OVJQZk1TWkp0VHNwQlJ4cmgrWkJCT1RIc0dBMzZpQWtiR0k0ajk4S2k4M3VW?=
 =?utf-8?B?K0l3b2NQdDd3aGZVdXBBa21xdjRtSW81TUgrVzlkcTZXZXVvRURLUzcrOEJi?=
 =?utf-8?B?NTZndWtaVHRmcmljekM0eldVM080VGVLSWdreHE3dzJaQ3pQbXNzQjdtQ2ZS?=
 =?utf-8?B?OFA1RTk2dk5TUDlHdjRJNGw5WU9YU0tnMFE3U0NjV2xVMFM1cmo1MkFZZTZ5?=
 =?utf-8?B?UGR4VHZ1RXZlUmQyYUdJR1B6SHdWemlhOFVWSS94RUVHVmhKanIvbTFocmhw?=
 =?utf-8?B?dTVqRG1SZ1ZyQ2pKbmdMRHdaY2JKY1pmY0tOc0phb3VGRnNrSlMvVjFVc24x?=
 =?utf-8?B?UGVYcjRQWjNiZVhBbElNUkJlVXltSWpXbDNCZnl6em1RMWU0N1pZbXljQlFw?=
 =?utf-8?B?VjhzaXpPeXd0NHYvd0xjZzJDT25yRlBpeERIN05vWDRJR1puMXBYakVrUnNz?=
 =?utf-8?B?b01ZSGhZMkhhQXlrUFN6clRybVQ5NHNyaElTVFhXVnlnL1k1Wk54dU5oaUlL?=
 =?utf-8?B?ZFl0MkxMdFc2SDFjTTFldmEzVlFKY3J1MDRtOVZDNFdCc1NTb05PcW1DWmZ2?=
 =?utf-8?B?RjRIa1FpYXV5VXE2UzNFRy9pQjRBMkMwanJPS092QkNvaGVFMkhIRG5OaGha?=
 =?utf-8?B?Q0xSZ0FWc2YvRTBKa2dFdHY3TnF2TjNlNXNkZHlqR0lvOTJJUWs0T1VVKzll?=
 =?utf-8?B?elYwS251eDJHc01CbWRLUlovSVA5YjBLTXRaY01Oem0wVU1iakozTVdML2Fo?=
 =?utf-8?B?cy9tS0JIQnd5cVB6N29kZGJOTG8rS1NjVlJzZXZSNm9LZ1VYRzNXcjNYbTQ0?=
 =?utf-8?Q?Fn2/t5owZAkdoqPbAq2pFwOtE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d4b88a-a875-4158-ce1f-08dc3919f325
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:31:19.8134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6+sfFJ1xofE6cDj3wyzrtrkmn6KM5z4UR3u4bBQ0t4MzVKyu/KcSY+dKjRvYkRc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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

Am 29.02.24 um 06:51 schrieb Jesse.Zhang:
> fix the issue:
> "amdgpu: Failed to create process VM object".
>
> [Why]when amdgpu initialized, seq64 do mampping and update bo mapping in vm page table.
> But when clifo run. It also initializes a vm for a process device through the function kfd_process_device_init_vm and ensure the root PD is clean through the function amdgpu_vm_pt_is_root_clean.
> So they have a conflict, and clinfo  always failed.
>
>   v1:
>      - remove all the pte_supports_ats stuff from the amdgpu_vm code (Felix)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 23 ----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 55 +----------------------
>   3 files changed, 1 insertion(+), 80 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ed4a8c5d26d7..d004ace79536 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1385,10 +1385,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
> -		if (vm->pte_support_ats &&
> -		    mapping->start < AMDGPU_GMC_HOLE_START)
> -			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
> -
>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>   					   resv, mapping->start, mapping->last,
>   					   init_pte_value, 0, 0, NULL, NULL,
> @@ -2264,7 +2260,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		return r;
>   
> -	vm->pte_support_ats = false;
>   	vm->is_compute_context = false;
>   
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> @@ -2350,30 +2345,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
>   	int r;
>   
>   	r = amdgpu_bo_reserve(vm->root.bo, true);
>   	if (r)
>   		return r;
>   
> -	/* Check if PD needs to be reinitialized and do it before
> -	 * changing any other state, in case it fails.
> -	 */
> -	if (pte_support_ats != vm->pte_support_ats) {
> -		/* Sanity checks */
> -		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> -			r = -EINVAL;
> -			goto unreserve_bo;
> -		}
> -
> -		vm->pte_support_ats = pte_support_ats;
> -		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
> -				       false);
> -		if (r)
> -			goto unreserve_bo;
> -	}
> -
>   	/* Update VM state */
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>   				    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 42f6ddec50c1..9f6b5e1ccf34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -357,9 +357,6 @@ struct amdgpu_vm {
>   	/* Functions to use for VM table updates */
>   	const struct amdgpu_vm_update_funcs	*update_funcs;
>   
> -	/* Flag to indicate ATS support from PTE for GFX9 */
> -	bool			pte_support_ats;
> -
>   	/* Up to 128 pending retry page faults */
>   	DECLARE_KFIFO(faults, u64, 128);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..f07255532aae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -89,22 +89,6 @@ static unsigned int amdgpu_vm_pt_num_entries(struct amdgpu_device *adev,
>   	return AMDGPU_VM_PTE_COUNT(adev);
>   }
>   
> -/**
> - * amdgpu_vm_pt_num_ats_entries - return the number of ATS entries in the root PD
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Returns:
> - * The number of entries in the root page directory which needs the ATS setting.
> - */
> -static unsigned int amdgpu_vm_pt_num_ats_entries(struct amdgpu_device *adev)
> -{
> -	unsigned int shift;
> -
> -	shift = amdgpu_vm_pt_level_shift(adev, adev->vm_manager.root_level);
> -	return AMDGPU_GMC_HOLE_START >> (shift + AMDGPU_GPU_PAGE_SHIFT);
> -}
> -
>   /**
>    * amdgpu_vm_pt_entries_mask - the mask to get the entry number of a PD/PT
>    *
> @@ -394,27 +378,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	entries = amdgpu_bo_size(bo) / 8;
> -	if (!vm->pte_support_ats) {
> -		ats_entries = 0;
> -
> -	} else if (!bo->parent) {
> -		ats_entries = amdgpu_vm_pt_num_ats_entries(adev);
> -		ats_entries = min(ats_entries, entries);
> -		entries -= ats_entries;
> -
> -	} else {
> -		struct amdgpu_vm_bo_base *pt;
> -
> -		pt = ancestor->vm_bo;
> -		ats_entries = amdgpu_vm_pt_num_ats_entries(adev);
> -		if ((pt - to_amdgpu_bo_vm(vm->root.bo)->entries) >=
> -		    ats_entries) {
> -			ats_entries = 0;
> -		} else {
> -			ats_entries = entries;
> -			entries = 0;
> -		}
> -	}
> +	ats_entries = 0;

You should be able to completely drop the local variable ats_entries as 
well.

Apart from that looks good to me.

Christian.

>   
>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   	if (r)
> @@ -445,23 +409,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto exit;
>   
>   	addr = 0;
> -	if (ats_entries) {
> -		uint64_t value = 0, flags;
> -
> -		flags = AMDGPU_PTE_DEFAULT_ATC;
> -		if (level != AMDGPU_VM_PTB) {
> -			/* Handle leaf PDEs as PTEs */
> -			flags |= AMDGPU_PDE_PTE;
> -			amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
> -		}
> -
> -		r = vm->update_funcs->update(&params, vmbo, addr, 0,
> -					     ats_entries, value, flags);
> -		if (r)
> -			goto exit;
> -
> -		addr += ats_entries * 8;
> -	}
>   
>   	if (entries) {
>   		uint64_t value = 0, flags = 0;

