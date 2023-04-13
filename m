Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B4C77B6C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 11:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A6010E128;
	Thu, 13 Apr 2023 11:03:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F5B10E128
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 11:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYyf33Q2PDu32X/L7F0joF4JStvf5BjjJQrolKX9jfSRRI/bOcQu4Btb1/pG6S87lRrl2d60q00LUdyj6z5l5tCmc/CYmMmFaukOPS0Y66SFQrHgUMkmsTkd3cNGzNE0cNupZjqkg66Ys6gre2XcuNaxaoH9xQTvP7E4sVhzoiq8jpZYPI5tEuGDOsHrgoV7dEPOxHotZ4qevCvbJSVY302zYYCjaj/PrTPNgNUH04VczTKThzmPMp0jsc3Ii5cKZvIKHltKI/Jvqx1sYvv+ORkwzPkkpEENnOx4vVMW1nA6cg/+2SRVRJx2WLwzdfSHKI38SfCIjV0RwG/F6QjO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KU1WjV1xKcAKsG9psN4iWcC171ZhSiAXC6fDWOZUjg=;
 b=EHrob/jqVW6HdEb95mukbs+nSMdXadgscUIYZ5+cXf2bLSGQIYY7kFnJkzo7wlxJD+cTZtsJ2SDegy8tbvb6jnZGxJhce/YGDKEiaUv7Kf2FbJ2N9l1/WkbkImllmzzjsmqLSoaiH1kZNLWwMVFQvn9Z1t1RifKHstptYXh0eqO/kQ7cc+E2BwOAezwA+AXAa17Ac84dawfRsi2KLHSrihhwp65HuXf4RaVvEu71zvT43XfCfeV6EAScGPCQ/9WZme/nXUkvUaY1YbiD4XkyW2GoOfB118g+DDwmNbt6BxSOEsKu1QX0gv3pjadsKs2HDmehP/1aTLevyn47A/18Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KU1WjV1xKcAKsG9psN4iWcC171ZhSiAXC6fDWOZUjg=;
 b=j6hlId6f6neIBv96KbEZtsMwRKQEtR6Mou+nYUKls2Pnpz6OAgXNpS4baQguCYoHJcUnDoa/VUIkhg4UthbBHEcSRbxuyIdezNxbvppJrvyVFm57E2xCrm9VenqxpzMp78WulrZ64/MKmUzkuQEhqI9GDL2HamUJcWGvf9ovdQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 11:02:59 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e208:1fec:a14e:eadb]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e208:1fec:a14e:eadb%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 11:02:59 +0000
Message-ID: <7b580294-bcf7-2107-5851-2b09bd519e86@amd.com>
Date: Thu, 13 Apr 2023 13:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-9-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230412162537.1357-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:208:be::18) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7d8a77-146a-4929-bd0c-08db3c0ea484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAqIuo8DFQyMUXGq4/PaU5fWecj0Cw8c8PqTOnn+IH9YFOjMxf1Eu/vkN8M+VB9VSTZwj9Jpu3YC69yp8Lk2vSsP7fjSJFUvNyF4zr99CjwBHDxsElQgG8J4mI0zW5OI33YILURFE8nDMMxhPkYgUZHcf+aV6u8+tRg3yNzU7nUUaaGaAMN44CujP6HdjepEXp+0CbCtA81CANHggz/rFJVJOc6zON2IrZNtHiHvlJW5+9qfC69TqHyxtBQdDe+YoFIFo52mjCuA+NtOpjcItCA72dblM+1kUYD47eDgAFji5zd+nwhcHiciBOtGhElDvPbxf8UJUceHsz8g9ubsOcO01bWi0OaS8VxV3bnOTCr/qdLE/yFAgweLYLiKhrzdasCm/XadKSoMEY/Ky6xZ7y7w+Ffj195o3wKvc43LzBdXqVYF00uH5s2EmMA8ODVbcQGBRDHJDx97boXI1wHKXw94KZdhkKLGgWt8rweVhSIAwd1V7L47Qo2vu/Uw41cm8hQ1wPX+uu0mnWYbqTmlJg+bQfXQTrI1RSGi7rWFoI+AUU3OCDoVvnHPxTGv2+ejyNfbYyw+2TU4cOV9clB5YXZZThc/KFuuw5/l8ftMa7g7+qyhlw4Necagut0HSLfcmcRlOBy1PDf6No9UPkIIRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(31686004)(4326008)(66556008)(66476007)(66946007)(316002)(2906002)(36756003)(41300700001)(8676002)(8936002)(5660300002)(54906003)(31696002)(478600001)(86362001)(6486002)(6666004)(6512007)(6506007)(38100700002)(26005)(186003)(83380400001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdMZnNmd2phZzZEOTM0WWQzTGtPYzBKaXpZMXBLVzZNRlIvZFNCemRyYTdX?=
 =?utf-8?B?cHZOQmF6dmpmRU5HcEFVc0w3WnFadjMyVEdDdU5yMEppT2VQYlJpMGVXRXpx?=
 =?utf-8?B?SHBiRnJodStILzlpancvdkRsN0hkSVVRbWxzT2QyTDJyQzhVZkYzRWhiaENX?=
 =?utf-8?B?NUZiUmNjNDR4R2FPRzVOQitHT0J2QmJPVXZoSkxDSEZwNVBPOFFtYW8zbTh4?=
 =?utf-8?B?UHlSSFBURFRlWGlFVXlHR2J5NDY0U0JZcnZIdTMxL0NZQTRkdDM5S2EwTnMx?=
 =?utf-8?B?ZEp1bjVFV0N4MDJWMFN4MVpDNE1XQnBiSm50RlVGb29wMHdZSGhObHB3YURK?=
 =?utf-8?B?OGw0MU5mYXFnbXpYSStEdlc2aUpQSUdYdTNzTzJPNHpmSUMvcjFEVGdwVm9i?=
 =?utf-8?B?SVNHRDlWT21HaVFZRzlNalZxZE5rZHRiTlhtY0RHNEFIVVlmOENQbmlzenNJ?=
 =?utf-8?B?Y253ODA2bllRdzQxMWVPemJBTkJWVnJFS3pzZHpDYksxZDJOQWczb2F0SGZI?=
 =?utf-8?B?cUpmRVlBTVR4VEcxSmtObDB2U2tCVjgyUzlhNVpKcElvdXRLdHJySjQwYjJq?=
 =?utf-8?B?NkpkYXVmdm9vK2hPRkpYZ2lQNENqNitxM2ZVb1k5eDRLd1pmQ1BNVnNVUlVX?=
 =?utf-8?B?bUgvMGFXSUdhcEx5Q3h6L1ZCcXhOc3dKU3BsM1FrTWY3d0ozNXpEVFBBMk51?=
 =?utf-8?B?ZFpWRStSVEQzUlpDaS82dEQ1LzZETlFrQ1ZoS2dUTkJ2dytxNFBCdGxsUHNh?=
 =?utf-8?B?aytCSU1Ud1FodGpNQW1xZlY2SjBub1NCTVU5bGg3cGQ5MENUWUFVZTdic01F?=
 =?utf-8?B?Z041dFp1QXBlM2kzMU5SUGM2Sk9CWXA0Z25ncTFlcm9WNkdhYlpadHdmUkZm?=
 =?utf-8?B?T1Y3ZDBIZjVkUTU4d3ZwK0xvVHhBZjJyWGM1VjBSSFJHeWJ4RmNEd0NJUDJD?=
 =?utf-8?B?clhuc1JGTjZ2S3p5MWhJcjcyZHNtNElJdlRYbks4TEYwcFhXdWxHRWhOM09l?=
 =?utf-8?B?RzZsM3p0d2xnbi9OeWRGSkU5Z2M5ZExRa2tkYmhxYjcrOUxGenkzOGhFMGQ1?=
 =?utf-8?B?VVlrOCtheUNQV2IrV25iK2VPNDVzckJDT0RuZS90dWtvdTRXOWtTeC9oTEpW?=
 =?utf-8?B?VHo0dDlOcDBXR3lNQ29TMnpxWVVIc2tjMUNrTmlJazR5d1dxcXlGaEYxZFhO?=
 =?utf-8?B?cUVBOEZsaWxNSXh1aEFuT3pTUHlVUHNjWGJLVE9hRlYyVllIRXd2aWxzVUtz?=
 =?utf-8?B?VE9pOTFNUUZFQy8rSFFzaTVqYVM2aTVKNERlb283Z1cyUDU3T3dIa01JVW5Z?=
 =?utf-8?B?VnlnNWl0MzNNOGRZWTA1K1lzR0gwVUo3dFVoMGRPaWNmeTk5Z1lDUHU4SzRa?=
 =?utf-8?B?Y1QwWjBlTEtWdDh1YllNMW1XVzFEVlBqSENnL3dLd2ZqT1MvT2dwUDRwcWQ4?=
 =?utf-8?B?K0ZaTkdJZW4wd0IxK28zd3ZWRitMSk5hYWRTTTNGMkxYVmh3TGRrRGtWOFA1?=
 =?utf-8?B?QWEwRDJSUWxjS0k2cGpyREU0TUFIUVdKZHpsbUZkTnJ0VEtXUVhlckNkQmVo?=
 =?utf-8?B?bWxZUlJPYy91dTJJR2tXaDBWVjZPVDQ1bStMeWdPYzNHU3czeWl3bUJZR2k4?=
 =?utf-8?B?SXRaYkVzUW1lNkRWSFlYblhna0dkZjFpbXViWmMxSm1XZlB6aDBuSWJaQzFO?=
 =?utf-8?B?eldaYlRyTW15blowWkNJemcrTzVPczkrWWwzVzhxTjB1dWE4bExPVEZxYmpT?=
 =?utf-8?B?MzNVUHZ4K3V6UCtDSEpkRmVjd0xVN3pzZk9lU0lkbkh5eFVuYzY5VTlUNGRD?=
 =?utf-8?B?VVJDTE15akRPM2p2Y3A5dWRld0dKVGVQM2NOblRpUG8wV2p6V3I4Z3FaTTZM?=
 =?utf-8?B?aGFqY0xCdHJUWlBMVGxBcUlFL1RQK1NrNW40LzlHY0pPS2x4ZGZiM0dRY2dw?=
 =?utf-8?B?Y0k0YmdQZmF4UkJPV1RDMHZHdXlRMVg0RndBMVUzbWFSSm9jSWFaaVlZU1hl?=
 =?utf-8?B?RzgyTDJGb2V2TWNDTWV0cjZLRG5lc2lYYTVib1JjbzRlaDZnQndadjF0eHVH?=
 =?utf-8?B?Qk5wU21CTUExUUFLcDBUb3ZXSW94bWh6MER0bzhKYk5LTEd6Vy9MRUUwNTFn?=
 =?utf-8?Q?ySAQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7d8a77-146a-4929-bd0c-08db3c0ea484
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 11:02:59.3472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpgp+gdFLpSaLYWXspCKP9LiQu17atkN3IFRgHKyzN0rv1enpelSM/2fnvB7vXsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 Felix Kuehling <Felix.Kuehling@amd.com>, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 18:25 schrieb Shashank Sharma:
> This patch:
> - adds a doorbell bo in kfd device structure.
> - creates doorbell page for kfd kernel usages.
> - updates the get_kernel_doorbell and free_kernel_doorbell functions
>    accordingly
>
> V2: Do not use wrapper API, use direct amdgpu_create_kernel(Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   2 -
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 110 ++++++----------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   6 ++
>   3 files changed, 36 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b8936340742b..49e3c4e021af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -435,8 +435,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   	atomic_set(&kfd->compute_profile, 0);
>   
>   	mutex_init(&kfd->doorbell_mutex);
> -	memset(&kfd->doorbell_available_index, 0,
> -		sizeof(kfd->doorbell_available_index));
>   
>   	atomic_set(&kfd->sram_ecc_flag, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index cd4e61bf0493..82b4a56b0afc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -61,81 +61,39 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
>   /* Doorbell calculations for device init. */
>   int kfd_doorbell_init(struct kfd_dev *kfd)
>   {
> -	size_t doorbell_start_offset;
> -	size_t doorbell_aperture_size;
> -	size_t doorbell_process_limit;
> +	int r;
> +	int size = PAGE_SIZE;

It's usually good practice to declare variables like "r" and "i" last. 
Some upstream maintainers even require reverse xmas tree here.

>   
> -	/*
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
> -	 */
> -
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
> @@ -188,22 +146,15 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
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
> @@ -217,11 +168,10 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
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
> @@ -280,7 +230,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   	if (!pdd->doorbell_index) {
>   		int r = kfd_alloc_process_doorbells(pdd->dev,
>   						    &pdd->doorbell_index);
> -		if (r)
> +		if (r < 0)
>   			return 0;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 552c3ac85a13..0b199eb6dc88 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -346,6 +346,12 @@ struct kfd_dev {
>   
>   	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>   	struct dev_pagemap pgmap;
> +
> +	/* Kernel doorbells for KFD device */
> +	struct amdgpu_bo *doorbells;
> +
> +	/* bitmap for dynamic doorbell allocation from this object */
> +	unsigned long *doorbell_bitmap;

When doorbell_available_index is now not longer used you should probably 
remove it as well.

Christian.

>   };
>   
>   enum kfd_mempool {

