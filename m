Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2383FC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 11:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946CF10E37F;
	Mon,  6 Feb 2023 11:25:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D263E10E37F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 11:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+LDO40s7vNOHP627oSHmQAIn8owEZlKxR7/FzZRoF5tRkQaE97zdD7pVER5TPTUF1S06CKQ/aBSd0KvR3qbWk86CGTn/qnlnULQqgL9zzN9W4vn9QRJ1kOpIUomM0xXLT+0NlXRjQO1W+jpc2W5v6H2HzCrzefdpwjCjf+DT1K3ma7YwvwjrLdYN3sPFOYql1mgEwUsTJ+8KRxa2JivLg3YTxZR3tahU0pmCebs3xLpDz09uPvHLFZnBFmWq9RwzuRgxQ1zoRoNLQ0/G+rE/RnyWg+cN11onGfaZdpfXn2ghywSWmAiOY88Zqa31p5z65uUJHS6mIt4qeRLSr+5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kygiWUpMfz6gUOmuWoSMT6qVlvSIJIvF4ZFMNNwtw+w=;
 b=dJZmPQEplRED8avT0Rx7NbJplRZdMNkevLXka2WPlodY1od7dQKI28RKWz+r0YAFVN9VBKFja1g2Tj3TjJQu7jRGF8iuYEVnA3mNtlGXm0+zGhtmVwxrLSdYSTSmhTZFunTsCawNaOKW+RLv9kY1y5fnFjjhEvQkdT0+NEBg+jnOqcg9IH+fCuk5VW2DliwF8REkoP+tDjPop1jcn993ESQxybFC4I3F01L0dIo4aMxDsqdtpJibOH3AN6t8NbunirRm83TjynZwMWqs+URM/bYz1ZV4dhTJOBuhWEElD1SoLitFiJFXFdNHOv3tF8ml9ZZTFXzWz93nAKZzrnhlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kygiWUpMfz6gUOmuWoSMT6qVlvSIJIvF4ZFMNNwtw+w=;
 b=pI673bxUfviUByCGRZWoYhA4t7WKvIuqcW5v/zJ4MJ/Zpf/T+xMHh0O/mNsmCLeNVmszu1A+dZg/B4hBWBWLZKNLUn2ACBJ8QNh1xhJ9+5wOSAEZLnW1prANlL/pT9lMeYHxM0iZaC9gEFdp1dRFafAJHPU4zwDWox7ZGvklwiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 11:25:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 11:25:04 +0000
Message-ID: <36f65657-a1c3-e07c-7f86-045de36ceb0d@amd.com>
Date: Mon, 6 Feb 2023 12:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 08/13] drm/amdgpu: move doorbell ptr into mman structure
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-9-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 29015659-adaa-4859-15d2-08db0834cb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyIDpgPus9icrUJZq82Rr5m6EPo3OwC0eHkE7COtLWcN6BfgvSJ1pX66rRdZxyuyUBFVuoV28ygbq4oZnykFWfuFWo/e2pX+tKu1Yr54NMTACLZmKZig+SFCL1nqpxvakn8nQNS4iiKlxvMx4VshB9x7kzQdD0VoQXyht+wFKUeJ+OoZWvlxsSKiUtneGtc8PwamxvnCpdb971RfVwLVJ0gIj8IX4BdBxfjpeio/fLaV4/cZIxh4yw/r41dF9CYJxmBTu27ghyeWWj736JNIwZsKBTx+UBQNeAmhOv/AMdj5F/X/DgDuIsEdvQFam9n3rKKqFNhn+uVn+YhmICG2DJuUPHc0ol9hqhhpWiSsSYLSqhiN6sgx3WWN/lKcoLZvcMYAEkhManUcrVnkklagwGzCYufnMVoL3845ESchoRSnhAW3ccUY5mZQyEtkm45lfEp7EKwB8UBqpbl03VF2pWfKTqoW3tq0rxzUgpixPcwxTQR7vx68kKcco2yc8d16CUpebkb3/D1T8Z73bv4ANz9jw050/lV+mzeCLrWqIrShB75lo/CFH/uWy+DWc4Qc7F+MX8ciljXOXseHpoZ+sWPjWtjk5h79HAhrCfP56Eln7k2nvPeVCkXfemZXUdN2AwRDW5Ds7viL1pwDtsVyG7tY1v8FaeaKfKLWWuhtFTTXNnLn+j3xEjZl439jyNldW9hMHbJMHHNRQ5gW1hKL0SIOt9px+oGXyG+i7SaRaX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(66476007)(66556008)(8676002)(66946007)(8936002)(41300700001)(4326008)(31686004)(316002)(83380400001)(5660300002)(2906002)(36756003)(6666004)(31696002)(6486002)(86362001)(478600001)(26005)(6512007)(6506007)(2616005)(38100700002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjE2VWRTNTZxaS81RTZtQjV1UkNQa2VkMlNNZU84OXZEdzJ4MmpKVTRuL2lW?=
 =?utf-8?B?Tm5QeXlXc3Y1T3NNNUFuY0tTSFFWdjhwUTlrZU10blpueWYzYTRXcGF3bVBh?=
 =?utf-8?B?L1FPMmhYUjBmMzQ1dTVRQkJaTEdTMXM5OTdLdkNSdVZIK2k5OFdUYm4rem0r?=
 =?utf-8?B?N2pmUzl5TmRRL243cVpzd3c3RXpvY0VYbWh2SHZaTlk3RXdhcWVWNnhnSTJ0?=
 =?utf-8?B?NjlhK1NPTVlyVSs5TGNZMm9MTGd4Zy9YZEhnQ3pUS1hGVHNUZk1xMUxQdnVq?=
 =?utf-8?B?R3ZSNi9FTjZqSHZZQjRDbVdCeUF6cnZQOGlWZWJVeUdTOFNtcWpJdXR5aG54?=
 =?utf-8?B?WmhOWHJGSVkzdXV3NkxtdlBpQ3hvQ1crRnlmc3JIUDJUTVJoQ0lGNXpvaGE2?=
 =?utf-8?B?bTVVQ3VvZGFtN0c2amFkbkh0OTBhVWV2TWM2Q01ZTm1JSlNlZ3BBdk94SjA5?=
 =?utf-8?B?NlhtM1ZNY2psWnRSc1RsclhyenBLMi9xNWhKeVNFeHJ5eWNFL2UrSHQwMm9K?=
 =?utf-8?B?OGNKQXpLb2tMZU1YTW1GL0s4SmpaTmx2K21KYmp6UWY5dzcwNXlRcGczbGt3?=
 =?utf-8?B?UnNkYTFUeER4TkMzTDdlak1LVFVTd2JZREJLQXdhYmJvc3RGRnRYZ1V1RklQ?=
 =?utf-8?B?MHIvUkxMUWpmR0ZzUDBYNTRucWI4THNUTkE2S1hyYzBZQTk4V29GZ1k0NjRu?=
 =?utf-8?B?UHJ2cVR4N1ZwS2ZhVkJYSjRGYzZUTEdkd0J1NXN5enMzTWhydFkrSFNuVUFx?=
 =?utf-8?B?bzBFanVHWFZidytrd0x4Y3JRY2o0czM5Q09rRWRMeXZjYndqV3F6SkJralli?=
 =?utf-8?B?eWxvMXMvOGFodS91cStwZnFIMFpDUW01cTVLdmFoaDJaTjhCeDZyUC9ta2VD?=
 =?utf-8?B?ZkNuaW05ZUxna29FbDQxREJZMWgzZS9vYXkzNFV5eE9IMnU3UWJoK3IrdFRN?=
 =?utf-8?B?bk9MVEwzbUJkaFF6NGE4MkJHZVB3Qm12RTNOOC9POXE4eUwrVEpySW1FenRP?=
 =?utf-8?B?bHREQitXelJma2gyS2JoY1haN1BJeDFFQyt0NzFMc015c3VLa3h6QVhXUURZ?=
 =?utf-8?B?WkkzQkFPWDhNY0krQ01jNG9zM0pVUDl2MW9TdEpnNldPOEhwbmZVRnprWWwv?=
 =?utf-8?B?d3FjQzR3MWlrcTFCTzYwL2t3YTRKNFhPelhpN0dwK0k5aHlGc3JBa3lKQlFw?=
 =?utf-8?B?TnU1QzZEaUloTUR3K25kZStmMHZjbmk5aDBSZ1lSb0NBSVFJUXgxY0VWZ0pX?=
 =?utf-8?B?SXYzNGh4ckRIZzB3QVl6SUVFaXNNNUFQbGM5RG5MdFpXQ1FLbEpVei9PTnhG?=
 =?utf-8?B?QTAxWXpxc3QyYkg2TjNDUERRVDBXNmlRemJ5bStOS0g1UGhjQTFOenQyL3BG?=
 =?utf-8?B?LzRBdmp4Qk04VzY0cXpYTkdBaGJiZ3NsTnlLcG9GMWVqTE9vMTY0WXYwc0lQ?=
 =?utf-8?B?TGxzanVwTGRIWkVTRXhkWTVjNXM3SmJnSGgrKzd0SlBDMXRDUFJEeWVxallY?=
 =?utf-8?B?QWJKNExDRnJ6UUY0eHpyN2ZselNjR2pFbDYza1FMWURsdXVGcS9YUmlZZ3pm?=
 =?utf-8?B?cUxXazRDcEE1WHY0eDdhREVPWXVjNDk1SW1UQlg5dmhYZ05CTEhuWnVSc0hK?=
 =?utf-8?B?K3FRVGptOEtmSHVhMEx1cWVFWmlNckpMS21GeEVrTkt1cm1VOURTRVlRZkJv?=
 =?utf-8?B?ZlEraGJMU3hMbUFkNXFVYUxpN2YwQ3ZTU3Ywb1dtcGlIWnZxVUl3Z0kzdE9t?=
 =?utf-8?B?UzRvN3NVdTh2R3duWFUrdVRzS2FQOUw0U0VtSVBRbTBKd2M1YUUwdkl5am5P?=
 =?utf-8?B?elRMaDg4VUdpQWJOOXVETzVpbXdZdy95S1N1NGowNG1oNDdCNGxrLzhwWDhB?=
 =?utf-8?B?QTBiTVZvd2k2eTNraWRsRmFBbVU0ejZzYXVsZDZObXRBRXJIcG1FNE1jdmtM?=
 =?utf-8?B?TWhWb3dzSVpvM3lZbnFoMm8zNFBaRWdyaGRMczVqR0p2dlptTnNPeUhCb0pj?=
 =?utf-8?B?ZDdBUlEvcnNIWXJ1TWJzMmV2K0NPWVd5UWlhVE9HVGh5TmwwUzZJMzdTMDI1?=
 =?utf-8?B?QmVuS0JoYTIvSUVsUytKTlBxV1FVMEE2S3BiWjlNMTU3dmE1aFVmdVFxZksx?=
 =?utf-8?Q?zbc0156uNxFnMzPLsx48BC2iF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29015659-adaa-4859-15d2-08db0834cb40
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 11:25:04.7165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LJeXW/rSPyimCIKNdXCufK0xjPxHFzJ4tKAJy0dO+gUWl0yWcj9ACBFvtF8WuR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch:
> - moves the doorbell.ptr variable to mman structure
> - renames it to doorbell_aper_base_kaddr for better readability;
>
> This change is to make doorbell's ttm management similar to vram's.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Yeah, that seems to make sense. Acked-by: Christian König 
<christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
>   3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 16580d9580d4..cda5387aae50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -597,7 +597,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		return readl(adev->doorbell.ptr + index);
> +		return readl(adev->mman.doorbell_aper_base_kaddr + index);
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -620,7 +620,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		writel(v, adev->doorbell.ptr + index);
> +		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> @@ -641,7 +641,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   		return 0;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> +		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -664,7 +664,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   		return;
>   
>   	if (index < adev->doorbell.num_doorbells) {
> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> +		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> @@ -1038,7 +1038,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   		adev->gmc.doorbell_aper_base = 0;
>   		adev->gmc.doorbell_aper_size = 0;
>   		adev->doorbell.num_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
> +		adev->mman.doorbell_aper_base_kaddr = NULL;
>   		return 0;
>   	}
>   
> @@ -1071,10 +1071,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   			adev->doorbell.num_doorbells += 0x400;
>   	}
>   
> -	adev->doorbell.ptr = ioremap(adev->gmc.doorbell_aper_base,
> -				     adev->doorbell.num_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> +	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->gmc.doorbell_aper_base,
> +						      adev->doorbell.num_doorbells *
> +						      sizeof(u32));
> +	if (adev->mman.doorbell_aper_base_kaddr == NULL)
>   		return -ENOMEM;
>   
>   	return 0;
> @@ -1089,8 +1089,8 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>    */
>   static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>   {
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> +	iounmap(adev->mman.doorbell_aper_base_kaddr);
> +	adev->mman.doorbell_aper_base_kaddr = NULL;
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index c6324970eb79..464be28da4fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -25,7 +25,6 @@
>    * GPU doorbell structures, functions & helpers
>    */
>   struct amdgpu_doorbell {
> -	u32 __iomem		*ptr;
>   	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index ea53aae3ee0b..243deb1ffc54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -52,6 +52,7 @@ struct amdgpu_mman {
>   	struct ttm_device		bdev;
>   	bool				initialized;
>   	void __iomem			*vram_aper_base_kaddr;
> +	u32 __iomem			*doorbell_aper_base_kaddr;
>   
>   	/* buffer handling */
>   	const struct amdgpu_buffer_funcs	*buffer_funcs;

