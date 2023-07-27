Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3699C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C61010E5E5;
	Thu, 27 Jul 2023 18:22:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D9810E5E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQsBW94Fw+Ie6Qnj7ObAvNlokgKfS0lS+tkbL2qUKdxjw+01dwBm1gFjNgFRiUmseaWMB5IEJVE0wNhe0hVgCbk37M6OY6yUYWdNJSv2eLtfdIJeVGdyDyAA3RhuD7ntL6Pj0l+kZay/Xt7BEe9rKY6UH1dyj9YJArdX+NGvcLbeArmkiQwWJbdc1txm4PPD7qxZDnp9HcOi/WuTV3TCiSVP684w0Utp1sJp1ZjgSXLlOoy3GxArW6ZoUPsT2+d4p2Ku/48azBOYq9lc8y7E8A2anbuemxVSieX678N/JD15d+Kekc+mmWVkm+MZ17CFLeZjdzoJU6AcREWeNqoe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB117TelyRRZ52iiQN799T0Oz3rM5KnY4QTYc5tUqh4=;
 b=nWjfPJZl9iJqBSghCp1MYS/qH/vtOVan5RMiK1lXJ6GOQtwtmSFCBUPq03U1tuvYqVSgFpUFIgbIxHnl7B0ajB1Jo3U5UGrQqVMJv6NArO7jArYxHpOd58Jn7LNVRXXzVMhLHRlD0OxlhyP7yWiKoJ350kF0sz85oF1y4V4QrkRUwtKhq8jcME0psu8l9ZUVXmkv8vcuDZ6nAJ6lEpKx3Vo/tNpmFlG1AozxxqXCdhXQGs6TsqhhO++HqZeJo9WcnBEhY2MSels2/hQtqb9he1T/Nths8bCzBt18ououTcC7ALs9gnRple5zIJHv/md/PCwqoalu80oYYBTCVFFoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB117TelyRRZ52iiQN799T0Oz3rM5KnY4QTYc5tUqh4=;
 b=XhC8ZTXQ1Dm5itiynaM1fj9e9u2xbSAkPsSxhsq99DIEWHe1N1yeV+ez3j0dYNJckQ3PxensZb6tR23tHZpasRNuARDFIxozMPuRChI5gwn1DHBNRLK5jya9hfwnqL0/cK/kHI6iXF585pXy3Mpm1mF7uT64zskQkOZAM6TgZAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:22:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 18:22:40 +0000
Message-ID: <36b9537d-ce9e-1560-94fa-7bdb4d1b99d1@amd.com>
Date: Thu, 27 Jul 2023 13:22:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Move vram, gtt & flash defines to amdgpu_ ttm
 & _psp.h
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
 <20230727163144.2626054-1-srinivasan.shanmugam@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230727163144.2626054-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:4:ae::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f7f332-4fc5-4f45-efbf-08db8ece760e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXtD5eoV4x82XJf0qSk1Xj67WrkA/TZ4LpWGDsA3MNVzxhYgWGYb922vDf+GGvXi0n1pZo288A4tHyhhzhSwyDJGnkwNMM3L+ezV6EAN44KL5FXbCwUF2QnKnnHBNettcgyyHcG9QtUD86je+FfDxv2Pmk1IEZtee++iUi58er/1RpfYMBXZdXv8qp+QpVCh53ifo91aIZafiwYg6smuy2zJ9f1YXYeHpaV3rLH0OsFzfLNlPtYJPVyC4j6tlWxGtmBr8DuIqsEmuD8jSblCvcW0+zrW07f+kK2D8UGCj5uabY4yuS0HxLGRmsQqve90RtTu4Nns9GBTBMFRcDkAEijQuLjfXB2J13M+Rg0eRKEHuaFv77iLy2t5+++3NDxDUkdA76Uw+uulLMndsNQuc/+QIvDhfpGf1Gwlrn8mQdkugMvpbJdk2010xgExeVF+HtPUquaLj5DulCen4zkwU7ybdcEE0GXneoZpzmp7YPCbvH7NvDgx47l8kJJ92FF3a0r8N1XWvoA1O7JOwc5H+qy5Ph+zu8AFWeP1UKYtj1j0/ijghW4XJwcbkZIoVfwMKUGPt1xILRCjcLRU1U4+ljSZcOizxC2f83ylRw9FuCYzlX7st3P2N8x2EfyvyKfZK9yzvod/bvyn3hig2nh5aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(86362001)(31696002)(36756003)(31686004)(2906002)(110136005)(478600001)(38100700002)(26005)(186003)(2616005)(53546011)(6506007)(41300700001)(6636002)(44832011)(316002)(66946007)(8676002)(6512007)(6486002)(66556008)(83380400001)(4326008)(66476007)(5660300002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dFUy9tM294N0xNMUMwYk9XeHZEUzJ0S1V6V1Z5VWJKSGhTWVlXTGVybk1T?=
 =?utf-8?B?blIwdkVDTnEvTTNBaDVTNjM5dVhUUzZ6bTdmaHlGWmhjb2svbS8zTmhSR0Ez?=
 =?utf-8?B?dFQ1SHBzck5odlVFaVc2WDhUYVBrOFl2MjBxN1RFb2RYQzRiZkxMcllNQzgy?=
 =?utf-8?B?NkVQcmFjdnhkUG9SYmJUeXdRbnVyY3o2WGx5bnA3MnFQVjUrRnNibWtrTkEv?=
 =?utf-8?B?dkNOUU9vTEFCY0F4OTY3ZitsK3hNdjhvdHptMC9iMC92NDN5VnBLVG5zUzVZ?=
 =?utf-8?B?cHdwdGxBL2dEMnhNTWh3a2hFeElWYzRUQnhqUFQ3NUhGdVg3bDM1MW1MWEpu?=
 =?utf-8?B?UHdna2R1NytPeDRMNitFUUlTSURjRUJOY0RodUdvK3JWWUt3ejZrVFpCZjRM?=
 =?utf-8?B?TXl3YzBnWGF1emEyQlJSQStlMzhsQkJ0Qm5YdVc4M2IrYkgxNmhRY3Zwa1k2?=
 =?utf-8?B?QlRkcGFtUDNzSFRKWThEOUNSVnJqR084azY3ZzBqWk1BV1lNdmhQek1VOWRD?=
 =?utf-8?B?OE9hNElEcHhYNXV2U25HUmpIakl0WVhtOGhrMXRJSFZzNjN1TTB6RnA1V2Ry?=
 =?utf-8?B?WFVrZUo2SnUxeVdvNHIzUEtpaWRBS2kwRVVZR1pIOHNVZFRPV3FFdjlJRzdR?=
 =?utf-8?B?eHVBYWY3dCt3a3NTT2VlelIvbkJrVHlVYmZIbDd2THo5RFVNTlFhakRHRTFH?=
 =?utf-8?B?Vmo5MEN1UDZRZ25KcmFjYmRJaklHZERaUFZKTmpTNDM3aEc5RHNxR1JseWdY?=
 =?utf-8?B?UUNkMTcrRVEzYm1HRDdMcjRWeWdTMUdZYjh4OE05MEViTkNsUnhJOVNHaGZW?=
 =?utf-8?B?MFo4eDlnbW9RZTdOd05jamYyN3pWYXpVaGF4Z3BmaGNRMzZoWGJ0Wk0vSmdj?=
 =?utf-8?B?dTZPODQwNVVhSVJDREYvTWlQM2FKL3ppL3VtNEJPWmtzVk9icjhVL1lLUlNa?=
 =?utf-8?B?cStoSGJOc1FQZ1E0UHFjM3F2aXFzSUdHZUxmM00yRDdweVF5dGRZbS8rbC8z?=
 =?utf-8?B?ZUJtT2FUejdSMkcwS2YxVW9wS2FVdnY4NmF4QlorWXRJSDlXbHFOZkZzRlJz?=
 =?utf-8?B?Sk1Xek5KaUR3Szk0S3o3UHF1UlU5LzJzYkJBSWpxZlplbDl3Y1hybWcrM2Z1?=
 =?utf-8?B?dkMxa2RYYk1vWWFHZGptZ1lqbWlpekh0WUhDMVZnd2RjYldpSVZRZ3gybUxF?=
 =?utf-8?B?YlVEcUlGUjVwa3RXdVpraVo0MVFXem9NLytpMnNBZll0Y1N1bjRnTnM3NnVk?=
 =?utf-8?B?UTY5Z0RmVkh3YmJFTWE1djNNSHBpV3l1UTNKblorSnlBQWF6ZUdBRm1DWXk1?=
 =?utf-8?B?RncwbEFoY0tyc2lBSkJIRlFHL2VkM3hyekM0TGk2cHk4c1VFa1ZZMUNJMXVS?=
 =?utf-8?B?UE8vWGxoOE4zMm8wT0txNUd5ZXZQbDJrbU53SDBBc0crUEpqd2ZlQzlvU0p0?=
 =?utf-8?B?V01lRjg0d1NVeHV0cFY1ZllzVitKSWN3ZFpSdG5jd3VMMno3bExiYWdwSE5E?=
 =?utf-8?B?MCtlMUwyNXBIY3hpTW84U2tPbVo2UnA4Y2FBNGxUcWVmYkhKMFpyVnVlTWRD?=
 =?utf-8?B?cWxldW9sWjc5ekpGNEloVWd2MzBhV3FmdVE4SXRnVzVhQStvQ1prMkV4dUFI?=
 =?utf-8?B?UElYb3lxbEdsait6QUVWaTlOTGNmZm5PajFJU0xmUTNhQkhoVnlnRFlGNjRS?=
 =?utf-8?B?QktSNjNGVENYcVlmaW0zL2JQZnl5dW40WDRYTWxuNEN6V09aSlNpM0w3OTZp?=
 =?utf-8?B?RGxCKzVrb2NXMDJXZmZFNFgyWkE3M2lCdTEyZExqQ3kwM2xtb3NhZFcwYjhI?=
 =?utf-8?B?UVNwUENHWkIwdFI4WkQ4NVpRYUhTcUZSMGZUbVdndVNEUFJvUVlkbXRMMXdK?=
 =?utf-8?B?dXpZdWlxS3lDZVowbnV0K3g1TVRzOVplcEI4K3NXTVY4dDMvL0pkbzJLQVNj?=
 =?utf-8?B?VThjbE9jVlRJcnNzOXNCY3NLckE0VzExUHhaZkxtZmpJVkdXT1gyZ1QvNG4r?=
 =?utf-8?B?ZGpqYmx6OVA1L3ZIY3Yvei9wZElEUUErMG96d0NpZGVCNDdxV0R0bWZlOTQ1?=
 =?utf-8?B?QWd6c09tKzNYWlJFcW52U01iR3Zmeng3WnY4WVZkQVArZC9FVlRFc1l2V2JO?=
 =?utf-8?Q?PkOMFDJe+U6eSBbc4fSDXZ5yD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f7f332-4fc5-4f45-efbf-08db8ece760e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:22:39.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lom5TSP4aOxDp5SjlYcv7sfD4Q65V3SewLEdVgtfcjbnQrUCZyeAP8Mzy78+kDJe66CIlmADyuWv2XOtzzu78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/27/2023 11:31, Srinivasan Shanmugam wrote:
> As amdgpu.h is getting decomposed, move vram and gtt extern defines into
> amdgpu_ttm.h & flash extern to amdgpu_psp.h
> 
> 'Fixes: 35488e44ed48 ("drm/amdgpu: Move externs to amdgpu.h file from
> amdgpu_drv.c")'
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 4 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 +++
>   4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 93d0f4c7b560..a046160b6a0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1524,8 +1524,4 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
>   
>   int amdgpu_in_reset(struct amdgpu_device *adev);
>   
> -extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> -extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> -extern const struct attribute_group amdgpu_flash_attr_group;
> -
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 900be3a62cdc..ea4951c08a7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -51,6 +51,7 @@
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_reset.h"
>   #include "../amdxcp/amdgpu_xcp_drv.h"
> +#include "amdgpu_psp.h"
>   

IMO, if you're adding new headers here we may as well sort them 
alphabetically first in a prerequisite patch and put this one in the 
correct place.

>   /*
>    * KMS wrapper.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index c3203de4a007..e8cbfacb5ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -39,6 +39,8 @@
>   #define PSP_TMR_ALIGNMENT	0x100000
>   #define PSP_FW_NAME_LEN		0x24
>   
> +extern const struct attribute_group amdgpu_flash_attr_group;
> +
>   enum psp_shared_mem_size {
>   	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
>   	PSP_XGMI_SHARED_MEM_SIZE			= 0x4000,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6d0d66e40db9..96732897f87a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -39,6 +39,9 @@
>   
>   #define AMDGPU_POISON	0xd0bed0be
>   
> +extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> +extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> +
>   struct hmm_range;
>   
>   struct amdgpu_gtt_mgr {

