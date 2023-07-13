Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516FFC001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 19:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8112F10E76C;
	Thu, 13 Jul 2023 19:04:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA2910E76C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 19:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnn2afXwbwcG6dqZbLcUYZeum07vxlTP5wizYaYPTqZ+zgdR95u0g+Zzzp2drabXGafzJCy/yJlGKd0uvsYcTQTdnZYNOK32slE4HP+9Wgf05D586Yh/1fTL2a+D/gOoBJXhNmzFprGYcS5XIlEUjtO6J4L5S875zgHQb1XpwZtmA+PSnKh7nkQouydU+6dZt4Ct2n8jKKy0Or5cBkxGOA79oHkxf/ROIv4mcf4RVI9fV3adx1EdmIJAXNJ1/5gbKEeWfAKkpvQ1N37uDs5STh+mO7dsmeRj5ky1Cy+3dDhXM0HITIJ2rcsFiMYVzHuVqdsXc1H/R2G/cVHQVCv9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b4Hx1BSkGDZEegTCH3iHxcCP93ihVU4fmOeSz0764c=;
 b=N+PsI7qsT5keCU+uWsyDEikcj2I20yHhNOr3sKH0QJD2HHvn/+hnvmxoH0OjKGZ37tIQuCNb5+zwNwwhjAJ7Yfg4uFhxvsamoTH1u+fJxTAZmvwOqOEf4svtNNCkPKPDMlOXgzMe0vOojmv3dd4tf50pdrvHpHgby5xq3Mu+pRmyd+Ea8KKbulDkC7nd3tcL2iOa+beSEfmawU8tZkl9SOyKYT7gG07kAfHQMh2aK81ow3vWR1bJvpTfLRiIqSgKSEKZj3tfrZCvU0J7sXzMHy/oGtM6rflq6i4/bNoiqnGNcH5QLtDLqpfyXzsrsnbjMsCIytqnu3W7Nns2qH0thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b4Hx1BSkGDZEegTCH3iHxcCP93ihVU4fmOeSz0764c=;
 b=3hZxbuiRcQHvcQl51VVMdyzmIS6Jcm/hsHBXt0jTqIQh6069ZIEb/QKNxeX3cgmHxTxvUiFRYSvbwoYZwGb7QnHs+1yDl1cBnfjJMNKS0/cqFsC+P4mxfcswvmpY/jpZnc/nLyzEA/1sXikdt/rKiWVAv5fgyf6464y3XPGIAI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 19:04:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 19:04:28 +0000
Message-ID: <b02ffe70-f640-d77c-f90e-b28111f3824b@amd.com>
Date: Thu, 13 Jul 2023 15:04:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-9-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230620171608.2131-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c83ee2b-79a3-4c1a-3deb-08db83d3fb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmdT6gklsmjh8bG5XhlL0REk0jT5i5HGbNhoVW03DlgGhPNUv7CgIj/iWFJ/fnehjekJ88QD9XLwPNzLk2HPCy5XoToC9P+0fPbw+ykatzw4GnnFueFeDPLU/aGcEVOY8n2InmDIBVBiNq15JcGcN2EhjmKy0twolKY0T1SwZb3MRnRYfDMmb6LPFrgepwyhKzrZcCKSUAyRjFX5efZt9uCvCUqUHmZgUWESro/V6jDlZ/cwR2CqWbrsejAxfPSk5AKCiH5erFOLAREUi+0h0vHqekj2U7bGioIT8rVHAai6cm2fPLDcG6I88QxxDxg0L82cHLGM4rlY+4mi6If7jboWaPIMO4NbmN2TUP7TARa3Z29lX/zEThGkmZS16K+zKtDY8RqBSKc4+UldpnIE96M9oLyqQUiULSXs52AjBHtQ3egbwf8b6sqI+oiVNNIwF34UzGNnuun3v3f9gBL0fUA7fjdh79QnPW6qrltDDWm0Oyxplnr3jI5aYabcHKvzZsrGCxKddeuiIAKrtz7tbTwwuYoo1gic1fzdCdNv5xvAprFSGOIEhElOY9e2A3UJgFfwkP4YZFpx2H38xM5gd7qivbeKWVTZwBtOT4TNxFOtzYqHx5vF3FFWLB4JnTejrNaY9QQgqz8OnRJvci6HNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(54906003)(36916002)(6486002)(478600001)(26005)(53546011)(186003)(6506007)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(44832011)(4326008)(8936002)(5660300002)(66556008)(8676002)(38100700002)(36756003)(31696002)(2616005)(83380400001)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hUeXk3NzBmZTVmMXFDNW03alAydWkvT3BLQzF3ZS9HWjhDaEFPOUtKeExI?=
 =?utf-8?B?QTdwd0pOVEhUZFg4NnJqanY0ZjZMTnp5VjFsS1FyYnJCUnpSd3BwR0hwYThC?=
 =?utf-8?B?Y3VDeVpRNFR1TFRCMGRneHZGUnJGMmhwL1FFZ3UvcFBBNzdrZnVaaU5SaVdo?=
 =?utf-8?B?VFlDdENpc29HNlh4alR1WkU2OVJWRWxodHBOUHJ0VU45NHJCbmZTd0tCS3ZB?=
 =?utf-8?B?ZjFoS2drcFoyWjZYSFM4OVMyeElYeUUrUDU4YVV0cE5qTENRb3REK1p6cTVp?=
 =?utf-8?B?NzNKQ053TW9XL0tNc2FBanE2RTJZVDFYS0IxRERENlM5bXdOUkNLdzliQmNJ?=
 =?utf-8?B?WSszZ2k5cDduZy9ZVkEwVjVuSjhYbkhqM3o3UjB4TEI4eTNmeDVoK0RpQmJp?=
 =?utf-8?B?dW0ydjVqYktSRWdOdHFrUm85bzRjMkJmbU9CYkxQbVNRQ3Y5anZ5OHFLemxh?=
 =?utf-8?B?NGRzTXowbVUxSjlHQ0dnSGthYXNJU1ZmaW1Bb1BDN1hBQmtBNVQxRlBSL0Ez?=
 =?utf-8?B?SXltS2gzeG5hOEVUQVFTdHlvYU0xS2xMOHZIR3VNWTEwME1EOEpKVVJMYVUy?=
 =?utf-8?B?dzVCb2EreG1rMlRzUnZSVkdhdzZpcm15MVA2SWY3VUxNT3JnQXhqZWtxNWJm?=
 =?utf-8?B?WmJRTEtaR0VLTzB2T1g1WUhCdXJ5WTI3VFYrMUFWdUU0RDRVaFZnd1J3Smtz?=
 =?utf-8?B?K2EwazFNSDV4cDRJL0puSnAvb0tvamFlSERhR01oOW9JQ0ZxcmMreHBRcEIz?=
 =?utf-8?B?RllXSVRkUlZhTlYvV2h4djYyejVob21PbUdGOWVLaWdQRnNtMUlLY3lBSkZy?=
 =?utf-8?B?TFZ6NFBuRWVWQWZLOE5QcjRLVERGVEpPRjZVaS9MUG5nMUdXaFE4NUFZN2ky?=
 =?utf-8?B?WTRrNG9DL0F4VUU1ZjA5WjRXWjhoRTRZV2RBbXdwNWRyNTB6WlBJbHAwb29H?=
 =?utf-8?B?S2VKWEUrb2UyYlRTd1ZuMHJiUWJwbEQ4ME9RRU82eCtLREx6bFZQTFQ0NERI?=
 =?utf-8?B?MUpFVGhZS3REWStCM21rZjFka3l4c2NTNjl0YnFjazJtUnE0L2hFS0ZEcWJI?=
 =?utf-8?B?allyRmZQUEYyOWRTOEJaRFJPSDc3QTVhY3N5M2tzYng5bTNQODljeVV5L2lk?=
 =?utf-8?B?bHEwMVN4U2RYTmxPUjNITTBiOHpKM2w2YStVaFhyYjdsL3J2blBpeGQ0ZE9C?=
 =?utf-8?B?NkFrMWxvTnFvZXFNV0NQSVljWDVWRjRGUnJsZUo2SjlGWmpQbnlkUGlTVHpp?=
 =?utf-8?B?VGdMV3ZhNk0yMm16WXpTVktudTBEb2c2SE9TTCtTMmViUUZyM0UzdThQYW9E?=
 =?utf-8?B?TmZIb2lFSFR5V3czWXNGalp3a0RFZkE4bUI0d1p5anJNWVZHZlFtWTlFSk41?=
 =?utf-8?B?WU9BVDFnR293VjVvaTJETjNTeXFsdjR2TVYySnJnaStqbHFQWG8vYlloYXVK?=
 =?utf-8?B?V1dzL3lrWkxPcTg0R3lxK0RmcFpZWjJNbWZJazh6ZmE4ZDJ0Wm9MUmtNWEdC?=
 =?utf-8?B?alE5MTNxL0NRTjhnY3NsTEYzdkpsQ3RNb0I3aG1rek0yMGxDZUpmbVhXNDV3?=
 =?utf-8?B?OXVhNElyUUdMSkhmS2hIMjRRNlhEc0I4UktlbXhCd08zcjlkSTBobXFxM3FF?=
 =?utf-8?B?NXBQTEUxOERaNXcrWDA2ZTZjVVFRUVp3TC9jb0tweGVOZUFrVGtBUzA0SzA5?=
 =?utf-8?B?Y1cyK3JTRzBrNEh2VTdEdUdtS2xmUG9ML3lPWkhsWUNHa3FUTjBUeFczN0l4?=
 =?utf-8?B?NVhIVkw1bFhHMGRpdGxMemw4bzBhMjgvWWNJaThsMVEvTklQYzhQZWdEQk1K?=
 =?utf-8?B?MlNuTFVPU2RXRmN0aVFDRVRCMkxVWWhhZGZSWmRmamdNUlBSU2traFZvVWw3?=
 =?utf-8?B?ZzR0SnNXYVBoK053VUdqbUlNRVZ1NHVKdFluSFhSbW9zZXVMeDN5UTg3WEtt?=
 =?utf-8?B?d0tjejVmQTZza0w5SEYxbUJZU1lPU1VON3hXNWd1UUkzc05pckN5U0RRQ0pX?=
 =?utf-8?B?bnpYd3kyU09lL2RhM00xeEsvbGc2ZmdSL2w0VGxSM1lNSTBRUzhkV2dkUEx0?=
 =?utf-8?B?c1V0bHhKeitDSkt0bk0wcFFhc3J4NWRGeGo5TmprMktoUllWV2l4RkVveTRV?=
 =?utf-8?Q?kxvkJBvndvvDOkufSALn13k5w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c83ee2b-79a3-4c1a-3deb-08db83d3fb6d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:04:28.3943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWdWcNnogdOH4wE47fStp9D/dp9xqvTKG9JNPx6FdrGvVmb3LhcWFyVyuZWbh5tGHIrHPxujDvnZJ3iQmp1q/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-20 13:16, Shashank Sharma wrote:
> This patch:
> - adds a doorbell bo in kfd device structure.
> - creates doorbell page for kfd kernel usages.
> - updates the get_kernel_doorbell and free_kernel_doorbell functions
>    accordingly
>
> V2: Do not use wrapper API, use direct amdgpu_create_kernel(Alex)
> V3:
>   - Move single variable declaration below (Christian)
>   - Add a to-do item to reuse the KGD kernel level doorbells for
>     KFD for non-MES cases, instead of reserving one page (Felix)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   2 -
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 109 +++++++---------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   6 ++
>   3 files changed, 39 insertions(+), 78 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 00f528eb9812..36fbe9c840ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -437,8 +437,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   	atomic_set(&kfd->compute_profile, 0);
>   
>   	mutex_init(&kfd->doorbell_mutex);
> -	memset(&kfd->doorbell_available_index, 0,
> -		sizeof(kfd->doorbell_available_index));
>   
>   	atomic_set(&kfd->sram_ecc_flag, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index 38c9e1ca6691..f7d45057ed32 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -61,81 +61,46 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
>   /* Doorbell calculations for device init. */
>   int kfd_doorbell_init(struct kfd_dev *kfd)
>   {
> -	size_t doorbell_start_offset;
> -	size_t doorbell_aperture_size;
> -	size_t doorbell_process_limit;
> +	int size = PAGE_SIZE;
> +	int r;
>   
>   	/*
> -	 * With MES enabled, just set the doorbell base as it is needed
> -	 * to calculate doorbell physical address.
> -	 */
> -	if (kfd->shared_resources.enable_mes) {
> -		kfd->doorbell_base =
> -			kfd->shared_resources.doorbell_physical_address;
> -		return 0;
> -	}
> -
> -	/*
> -	 * We start with calculations in bytes because the input data might
> -	 * only be byte-aligned.
> -	 * Only after we have done the rounding can we assume any alignment.
> +	 * Todo: KFD kernel level operations need only one doorbell for
> +	 * ring test/HWS. So instead of reserving a whole page here for
> +	 * kernel, reserve and consume a doorbell from existing KGD kernel
> +	 * doorbell page.
>   	 */
>   
> -	doorbell_start_offset =
> -			roundup(kfd->shared_resources.doorbell_start_offset,
> -					kfd_doorbell_process_slice(kfd));
> -
> -	doorbell_aperture_size =
> -			rounddown(kfd->shared_resources.doorbell_aperture_size,
> -					kfd_doorbell_process_slice(kfd));
> -
> -	if (doorbell_aperture_size > doorbell_start_offset)
> -		doorbell_process_limit =
> -			(doorbell_aperture_size - doorbell_start_offset) /
> -						kfd_doorbell_process_slice(kfd);
> -	else
> -		return -ENOSPC;
> -
> -	if (!kfd->max_doorbell_slices ||
> -	    doorbell_process_limit < kfd->max_doorbell_slices)
> -		kfd->max_doorbell_slices = doorbell_process_limit;
> -
> -	kfd->doorbell_base = kfd->shared_resources.doorbell_physical_address +
> -				doorbell_start_offset;
> -
> -	kfd->doorbell_base_dw_offset = doorbell_start_offset / sizeof(u32);
> -
> -	kfd->doorbell_kernel_ptr = ioremap(kfd->doorbell_base,
> -					   kfd_doorbell_process_slice(kfd));
> -
> -	if (!kfd->doorbell_kernel_ptr)
> +	/* Bitmap to dynamically allocate doorbells from kernel page */
> +	kfd->doorbell_bitmap = bitmap_zalloc(size / sizeof(u32), GFP_KERNEL);
> +	if (!kfd->doorbell_bitmap) {
> +		DRM_ERROR("Failed to allocate kernel doorbell bitmap\n");
>   		return -ENOMEM;
> +	}
>   
> -	pr_debug("Doorbell initialization:\n");
> -	pr_debug("doorbell base           == 0x%08lX\n",
> -			(uintptr_t)kfd->doorbell_base);
> -
> -	pr_debug("doorbell_base_dw_offset      == 0x%08lX\n",
> -			kfd->doorbell_base_dw_offset);
> -
> -	pr_debug("doorbell_process_limit  == 0x%08lX\n",
> -			doorbell_process_limit);
> -
> -	pr_debug("doorbell_kernel_offset  == 0x%08lX\n",
> -			(uintptr_t)kfd->doorbell_base);
> -
> -	pr_debug("doorbell aperture size  == 0x%08lX\n",
> -			kfd->shared_resources.doorbell_aperture_size);
> -
> -	pr_debug("doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
> +	/* Alloc a doorbell page for KFD kernel usages */
> +	r = amdgpu_bo_create_kernel(kfd->adev,
> +				    size,
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &kfd->doorbells,
> +				    NULL,
> +				    (void **)&kfd->doorbell_kernel_ptr);
> +	if (r) {
> +		pr_err("failed to allocate kernel doorbells\n");
> +		bitmap_free(kfd->doorbell_bitmap);
> +		return r;
> +	}
>   
> +	pr_debug("Doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
>   	return 0;
>   }
>   
>   void kfd_doorbell_fini(struct kfd_dev *kfd)
>   {
> -	if (kfd->doorbell_kernel_ptr)
> -		iounmap(kfd->doorbell_kernel_ptr);
> +	bitmap_free(kfd->doorbell_bitmap);
> +	amdgpu_bo_free_kernel(&kfd->doorbells, NULL,
> +			     (void **)&kfd->doorbell_kernel_ptr);
>   }
>   
>   int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
> @@ -188,22 +153,15 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>   	u32 inx;
>   
>   	mutex_lock(&kfd->doorbell_mutex);
> -	inx = find_first_zero_bit(kfd->doorbell_available_index,
> -					KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
> +	inx = find_first_zero_bit(kfd->doorbell_bitmap, PAGE_SIZE / sizeof(u32));
>   
> -	__set_bit(inx, kfd->doorbell_available_index);
> +	__set_bit(inx, kfd->doorbell_bitmap);
>   	mutex_unlock(&kfd->doorbell_mutex);
>   
>   	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
>   		return NULL;
>   
> -	inx *= kfd->device_info.doorbell_size / sizeof(u32);
> -
> -	/*
> -	 * Calculating the kernel doorbell offset using the first
> -	 * doorbell page.
> -	 */
> -	*doorbell_off = kfd->doorbell_base_dw_offset + inx;
> +	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
>   
>   	pr_debug("Get kernel queue doorbell\n"
>   			"     doorbell offset   == 0x%08X\n"
> @@ -217,11 +175,10 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>   {
>   	unsigned int inx;
>   
> -	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
> -		* sizeof(u32) / kfd->device_info.doorbell_size;
> +	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
>   
>   	mutex_lock(&kfd->doorbell_mutex);
> -	__clear_bit(inx, kfd->doorbell_available_index);
> +	__clear_bit(inx, kfd->doorbell_bitmap);
>   	mutex_unlock(&kfd->doorbell_mutex);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 94a438956868..42c215782d72 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -349,6 +349,12 @@ struct kfd_dev {
>   
>   	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>   	struct dev_pagemap pgmap;
> +
> +	/* Kernel doorbells for KFD device */
> +	struct amdgpu_bo *doorbells;
> +
> +	/* bitmap for dynamic doorbell allocation from this object */
> +	unsigned long *doorbell_bitmap;
>   };
>   
>   enum kfd_mempool {
