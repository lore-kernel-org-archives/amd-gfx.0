Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A62C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 19:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A501310EB31;
	Fri, 11 Feb 2022 19:52:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE04710EB31
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 19:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv6cworRVmHlCj1TgyhxzVhTgKp1nRRXJdbbunDDlT2sJgFSpHHJqTIgMnhvXEm8ABsxpo1fPJNuVuMl6tI3OFC5GSbN+Kftiwe6U28YvHB5zKJFfwnCGjOl5WIpDdA+fvXJlhxAfEximOemB4KkE7PXXLVrZiXbGfiw6qCvT5MwGDK6Wtsgb7y80l8NQmou2UAzHaSGSqUleRGDNW8F2IwdlHe0KqxAErQdBLNHd7Cs7ZU2HoEs7QpMD760zzM0GFvL3v6a2cDXBUpz9JD9d3ovQGtSkCwT9PSo7qyqYTbA4Pa51ew3uX6kuUUN5zVct8K0t4kujNAIDtmK0sd3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihQCRgd+JuzQBNGIyYwpKQTcwFj6vX15dn+0a48MxBU=;
 b=Pc+PVulwibtFv8D+WDudTcYkleEKKM8GGWtq0NIJcc0rZMH1Z58UjY21UM7pju7fz7ESkRZn4E1U701Vn9dVVRy7Uh4UsMWdPmpf47NOWg3ibyLzchJ86NfTcGtcr7e8xzQ6NOdEd0MC+2oXPCOo9/McDsa3ME9nRRECzlaKtcgS8pWxSKAH/aOUN5W7m+QNoMlXs6c5vVvx9qlz/AyW9iwrVdKlwylL7Aaj65Rai8+uVl0i4vw9lKowxVKITiS2uWo/SeqnTW4UXC5f5uUBufrVm2vJC2SySA9ndBeaD2o2wwp3E9XX1bwHGhiomsjemNHWKjJwha49f3L2ZO5AqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihQCRgd+JuzQBNGIyYwpKQTcwFj6vX15dn+0a48MxBU=;
 b=RUPxsR/uGRj1yNRTHmFMSjsAxyPMDSjYmjzxEkpBCoIcVbWHDAY95IvaZbT/ZHiZWNfJLHwvm3p+EHdibfCDqd5ko+mBP5i2sja2/Q98DJU2tdkLNZ2iqapV+UeYNm4fjTKKJedTeh+QosUmmEQrAkB1E16gsY8VqqiHi/bKHIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:143::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 19:52:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 19:52:35 +0000
Message-ID: <7c207228-ae6e-8f3a-d7ce-3c65b3f97bc1@amd.com>
Date: Fri, 11 Feb 2022 14:52:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220211161758.29610-1-alex.sierra@amd.com>
 <20220211194510.24186-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220211194510.24186-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 110ecb72-fd34-4025-2dc9-08d9ed980c53
X-MS-TrafficTypeDiagnostic: PH0PR12MB5630:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5630873D00D69F0E1879732E92309@PH0PR12MB5630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Khx9IjmzmEg0laAq2w5cN1KSFDw2a/Paj8TBjXHi0XeWhWuc3vVm4chR1TNObe7jsCNPurHS9mTv5BmBGaCUW1VPEdGoIRv9ICSXsbniEBbSkBdrEzXDa5E9zKSwevv8Wp5ZXZCD7UOaaA52+qR440bjd2O7shXCG7xbXHHmqu7m2nIv609Q9X6vkBYG3w0AwzXZ8EM8NE1UqdMI2KbqpkMVAVwlhGJbZxHlVcj7wQzH4z2WvhMutv80W7e6+sJxCWU9MnHl9zQxUwx9hkbMgspcPt1bL76YQslCbt9aqxtchPRrJJv0gJXFzL+5IdGFchdMzIgTxdxMOlajTNAwfwWjseQ4T0tJ8775mrVjXUUZPyh3PghI8J/17slYq+d7GuNvpjDBn8zMZwqlpsVDIRVxGaQY0tVMZ96ChjsMegQ5elFwFbx0XIjIvjsP3MWG/IB7foLvR9s0DNZq7Nko82AOKtw9F1I32tFG6q9qjCLiOy1c1o5ssHUCevsAlX99KJ65syJViJbjuFCRiYOYqQpuuIx2YzWbFqyAuu9lLtBCi77qUQLuH4gJ/9FhKc4unSBoP8aMp9K/TESkPenlCGlWM3PO5FLRiPAqRQ8wE+UxyIgqXDT8AxCPOkSCEeo4AcfOHNipeUfGpIvSd0vgk3oRs5gqLnfdIu6kqPSwpMVCz1iYimBLrjt93AMjzbdW/s3o0wT2zRyB8Yn2IqOvQm9SbDhOs4VucEptANwoqapsmVOGyOU+2yWU5DKo3S9F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(31686004)(8676002)(38100700002)(26005)(2616005)(31696002)(5660300002)(186003)(83380400001)(4326008)(2906002)(36756003)(44832011)(6506007)(6512007)(8936002)(86362001)(508600001)(316002)(66946007)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdYQnBmSkQwaVkzUUZRMnpDTHJyR1dmazV0aytMUUhsVXZua25YR01xR004?=
 =?utf-8?B?d0lIQlFMWHRLaXFWRFc5MGdQVzFQVnJ5Q1J5S0xCSEhvSnl1a0h6aFNuSGho?=
 =?utf-8?B?eVRjc0lYaHUzd1pRclo2clo1MnpnWHFEK0psbXdpMmkrQzNuVGN4SmpoYzYz?=
 =?utf-8?B?ektwakt4YnpWT012cHlwdGJWQTRkbmcyRTdzTkJFcmZpMlhObW43SENPWkd2?=
 =?utf-8?B?ZjZieDdjUENreU1pUkdFQ1hPUG8wUVFVYktVNmd1UDdHMTNHNUNka0lMZDcz?=
 =?utf-8?B?WU1iSUtrQ1lDNGJCVUR4bkhGR3VSNXRxYjFNTXArRHVkRmdxR3dLeXVxSFJw?=
 =?utf-8?B?ZkZRbTNyemNwM0U5OU54aEtPT0hSSHdNdXY3RnduNi9qNHQ4VzlmWnZaN3dS?=
 =?utf-8?B?VEV5QitjdFhmaEpRdTFDZjR6RWx3aTR3WDE3amZZa0oxK2F6cGJqZW9HSmNX?=
 =?utf-8?B?bCtlbXN1dCtEQ1BNL3dBeXdDOEY1VmVVcUZ2Mld3REFXb3lvSFV2M3ZJN3hE?=
 =?utf-8?B?emliWHJFemp3QnlBRVJtN0N3TUdVT016anFxdm9ZQVdhZ01ITmNJTmtPejd2?=
 =?utf-8?B?K3c1YU5ZeFNncUp1VVR3QTB2bGNDT3F0MDAwMTBYdmVLMXpiNVRUYkJPZmd0?=
 =?utf-8?B?UnNNY3plTFdDaHU5K0M4L0JpNE8waTBVWTJyellxaC9ieHZyMS9Xc3FxcVkv?=
 =?utf-8?B?VUg2OWZsRHMwbjcvaUFmNTdjMS9pOXAyY3JJd2txTTVGSUhGMjJmWUxXNVlE?=
 =?utf-8?B?UndEdUVNSHpQaFBvV2w1WElCaXg3RjRHMVpSOVBYa3NoamFNVnpKdFE5dlc4?=
 =?utf-8?B?Q093R2UzU2tNY2dIejhWamRQY2Y3YU5NbWFOeU9jZU1iWmdhQWZHc3VxWmtR?=
 =?utf-8?B?RkVCMFdFcW1PaDlsaGpsTFRlNktKNEE0QWtzUUk5aHpod0ZaTTBEaVpSUnBm?=
 =?utf-8?B?L21nbU9LNkFTTHpPT0NtT3cyZ1NmeXBUZnl3WEcyY1EzbWVWbmRmWmZONEw3?=
 =?utf-8?B?dDVNTlBSbEkvT0F1Qi9wSEM2RFI0dElQS2VOT3pESFpwazRMYmNqcDQ5aWRx?=
 =?utf-8?B?cVhKNFQ1SzZLK2FyZmF1Rkx3KzViRFVlZ3ZLSkdQRHdoMER6UGJraktQemdu?=
 =?utf-8?B?U29vekFRQWFFN3B1TGNqTVZUY3hhM0RVSzRoZDAvZ1JjSkpQSTg5dy9WTCtr?=
 =?utf-8?B?V2h0c2ZlVHdoZkdsd3o3TGJvSTZ5QzZHeHkxdFUrRnhEczFFZnNhV1RUQkxh?=
 =?utf-8?B?MmQrYkp4WHhKbnFyWjZMRlNwRGlQLzhzKzlyY1NCdXBMYnJEa0o3eExHZkZy?=
 =?utf-8?B?bU8zQzRqaDRXZURVQnlkS3h2NEozK3ZjZEY2bDVpVlkvQ0paeTcxOTNyOTZT?=
 =?utf-8?B?bk9MNko2cmtKZ1ptV1VRb0FSRmFZMDJwUkY3NVVWT0ZMVUFvQ3Buc0ljZ29Y?=
 =?utf-8?B?b3VKNkNWTXY4a1BMb0VCSTV0bFJGZTc0VUdaSnlucGUyam5NRzRzQ09TRHVa?=
 =?utf-8?B?VUxJOVdJTmFvMVB6cWJnTkgzWUV0Q3d5cXBrZGJlcWFUdlQyWEYvN2JwanU1?=
 =?utf-8?B?cCs3OVJzRkl5Y1p0SWpVUUQwQUN5NXREc2ZjNWFuZVJ3NHp5YXJKQy9WOEpp?=
 =?utf-8?B?LzNBaDJJQzNWRUg1Z0tmTVdLa0VkTTIrSzBobE13ZGhpWDQyWGlMbExtZHhL?=
 =?utf-8?B?allTeXdYZ0xBVi96SjlHSVczSHVUalg4ejh3b3dFd092UVgrakF6K0g5SnJz?=
 =?utf-8?B?NHI3eFh5LzhobGlLM2lveW1qZU1KcktpS2ljUlZ3cDlQbXVvdUFxRmJzS2Vp?=
 =?utf-8?B?Q2hUSXZ3aGxOaUo1cTk5eDNpdFBqNHdOQWZ3TGZzMEdCeEppZ1BqTXVhYVNm?=
 =?utf-8?B?TTc4K1MrZHhJU1BoZW9VRGtEMk05c3FQN1JzdlhmcEFpcmhVbHRaaTZkNDZ4?=
 =?utf-8?B?NENVOGZpellnSEpqNFFhOGZCZWlZODFKaHNqUjFiT1hERmNDUE1xMkMrU1lR?=
 =?utf-8?B?QW9kM0ZhQk9aWnhJL3Z3UEFaU29TYnpNZFI1REwzNjZaWFR5UUg3TjZDejNE?=
 =?utf-8?B?SmttN0hSdU90aVQ5Z2Z0THVRN09INnJxV3JxTDRyYzIydmgyaENrZjN4VjZz?=
 =?utf-8?B?ZFdzNSsvNFdlMDRjRlp6RFhKb2ZKYUZDVW1BR3EyaTNhaWd5TEhSMy90VlV1?=
 =?utf-8?Q?TgB14hZ0eO7pCIkaCjqsRNc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ecb72-fd34-4025-2dc9-08d9ed980c53
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:52:34.8475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN6x8p7z4OTk4gEo2NPXH6uGTt/zdcVcHNecNpriOtzpRlk8yZv7uZ9uw3SL7+WxF28ljzS2uqFn9VSVAN9hxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-02-11 um 14:45 schrieb Alex Sierra:
> Avoid spam the kernel log on application memory allocation failures.
> __func__ argument was also removed from dev_fmt macro due to
> parameter conflicts with dynamic_dev_dbg.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 88db82b3d443..8ce0b169b976 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -36,7 +36,7 @@
>   #ifdef dev_fmt
>   #undef dev_fmt
>   #endif
> -#define dev_fmt(fmt) "kfd_migrate: %s: " fmt, __func__
> +#define dev_fmt(fmt) "kfd_migrate: " fmt
>   
>   static uint64_t
>   svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
> @@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	r = svm_range_vram_node_new(adev, prange, true);
>   	if (r) {
> -		dev_err(adev->dev, "fail %d to alloc vram\n", r);
> +		dev_dbg(adev->dev, "fail %d dma_map_page\n", r);

This is still the wrong message (s/dma_map_page/to alloc vram/). Other 
than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   		goto out;
>   	}
>   
> @@ -332,7 +332,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   					      DMA_TO_DEVICE);
>   			r = dma_mapping_error(dev, src[i]);
>   			if (r) {
> -				dev_err(adev->dev, "fail %d dma_map_page\n", r);
> +				dev_err(adev->dev, "%s: fail %d dma_map_page\n",
> +					__func__, r);
>   				goto out_free_vram_pages;
>   			}
>   		} else {
> @@ -433,8 +434,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	r = migrate_vma_setup(&migrate);
>   	if (r) {
> -		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
> -			prange->start, prange->last);
> +		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
> +			__func__, r, prange->start, prange->last);
>   		goto out_free;
>   	}
>   
> @@ -612,7 +613,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
>   		r = dma_mapping_error(dev, dst[i]);
>   		if (r) {
> -			dev_err(adev->dev, "fail %d dma_map_page\n", r);
> +			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
>   			goto out_oom;
>   		}
>   
> @@ -673,8 +674,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	r = migrate_vma_setup(&migrate);
>   	if (r) {
> -		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
> -			prange->start, prange->last);
> +		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
> +			__func__, r, prange->start, prange->last);
>   		goto out_free;
>   	}
>   
