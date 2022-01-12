Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943F2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 19:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C3B10E734;
	Wed, 12 Jan 2022 19:20:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E491510E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 19:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBzJ5NU8eR6C/37OkvjnmtaZqbFrkQhoOOR92cF508hQ93trGjXqjlmLZZXIrHKI3ivugr9ktnQLxUkL+hsEIwAiNIODRoqOkxBhAgdaBzs+BBCCVVpMvJ2aTmZk5AQSuc7rZuIj/UjpZ7yRJ5qIvSmkl7EbzmbWtnw3spGM4bKKB5/r5xmWgy5vqz+ZKDgtw6iE70eplYUgBbUknUoIcE9laIYTfIDEiRa0a5h8eojGzv2bjH2LoNMiJuwPVhfUqWajtEgJQDG2XBiOKzp8TBaxiPJl2b/bBcbgJm1RA8bT8Hokm2ZnsWnF820Ya6WoDGsdglB6aDevXcXMwQIgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOX9U4ndw1abEKycpcRShC7mX8YCNPtAIyms/OS+wQU=;
 b=Mu4va8SHwCNOxWx5PIVxdbmtjHmSCl827T0AfOPbQVHNfMHLdKuzoeLR166enES7Y8ZND6Lc24SdWD5xxQ7+/a9lCS3jhQgDTPqilzUn6ZftUNEbTsvs0J4Y1HRnhvM/hnSk4DIY7f91TelMH5JLwc5AzqOpxdWdOc6kCe3yjGiw03kWmGBVK3EKUrunW+Vh4UsWLs+z90Rv2DasTOjXGIjSbejcaWFyFQf48i1P14fiZty3I3kfUU9EeyrTpW7ZnjPAYSlKdVZXKGdXLHWHsyeyQtgVC6INVi05x/LD7amAnCYeF1qo7aAcFUaDzisxvwDgJHPY734LQmnGuF4hzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOX9U4ndw1abEKycpcRShC7mX8YCNPtAIyms/OS+wQU=;
 b=ZDEbvngE2GdaNygIvvWl6CwCJiMpmU3d/bCDmS93tlwcK94Iv7u+zlSpbUhkUbMbwoqxfj4LD/JKHipQK1XRWr9k/z2oDciB/IuEFlHAb79H5oOgQ1hOhPIMHEMP2YNregQsIWdYKFI8dXKjr77c0c5v8Z7y6jE2eMY61PfjwaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 19:20:16 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7%7]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 19:20:16 +0000
Message-ID: <d0580793-a0d0-1c11-ea43-31186aa8b502@amd.com>
Date: Wed, 12 Jan 2022 20:20:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/amdgpu: cleanup ttm debug sdma vram access function
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20220112185218.2648420-1-jonathan.kim@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <20220112185218.2648420-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0076.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::17) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52deaf53-6ddf-4dee-fa66-08d9d6009079
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB529423CA6D9D87210C37A2C98B529@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0e8o99QAYZv0StClEzIVtapMdfz3AicWuWJcC6EgRXpdcMqewaoEsUsm3cDEc1KgDEeCgeFGU1ABBLHXhavftKhFIuOf/lIfmdZoss30cYWLEDhfwAhUhYQ4qJjc+gbtGCop3Zu2JB7MROTdw9vpUBbnNKwrvGZuhyS2n/zG03exQo0hyuUmy+K3OYDwiPlkg8PQH7lK7ZRP2WKtp7hP2EezPN9LaK9w548pxyassWXc3j6AZAs7fpWpf/jlad4ItqZFEPyw41b2+amnz2XckWR4dagS+Kx3fsN1X5cLWeLrcpqsxZlRdaC8+PX8kEshk8VngRBMr3zUeZwl58q0xV+Zj/8kqmE0qmdaPWAgYKjJ89T762RaCRUZPScBppgCQS7dPLkDUN5qRZp2yAuxogubfzSubKG84GJP0DdQrq9SqF1iR1DVww7GJ0Dzw1nqVWORhMWdZ87a5316NK/f8k1dTe2V4XjjNK+EYQmOI6cGRB9kyshRaK3rY2BH37Fc52ZaH5NUuCPdby/Tf4Xv9uveQu/jCQIaC1lvpq5U16dzVagohSG6lmkHAN1C6I0id0L+KoPJJnA7UeuzAQqKZ5EHExYtA1ydASUnJUkgwZPIBUczwAobaveB+51DSVM/GX2EZwNa8tm3nkEzeUJ7Md1bPCgh8xP/ptFxOBiSO7AtB7u4IJOfz/SQv7gOqJO+iNFqifRYieD+PECoy4i/X32WupGoXEtUMzVznAJKSr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(36756003)(31696002)(31686004)(316002)(86362001)(2616005)(2906002)(6916009)(66946007)(38100700002)(66556008)(6486002)(6512007)(26005)(508600001)(186003)(5660300002)(53546011)(6666004)(6506007)(8676002)(8936002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5tRlZidlJIZFdDdXRxeUNIaUUzVGVQTXdHaEg0MVJLWjdaNTFvdnhKZlBw?=
 =?utf-8?B?SVhXU0UxeHBxYTdRODEyaVZBUVhScWtZaVUxWWdGZXIyQUZCdnBCcUhJOXcx?=
 =?utf-8?B?YURtQ1NROXBwcStvMWRQYis1cWxTQ1dRYkRHY3Rya2krLzlicDg0dDlvak4w?=
 =?utf-8?B?eVBtMko1Tk8xd1N0RFJyampsS2F4VGwxdlZ5YTJ4MStNdWxuUU1hYmNqaXFM?=
 =?utf-8?B?amk0S255U1FxR0ViSmx0bmlKYmF4RTl5bzNBRjI5SW04L1BMLy9pRndjalpN?=
 =?utf-8?B?eW9iMmZqNUMvNHoyMlJmRzBubi9hOHQyQnBoNnppZHlPbkZ0cHVKYmJqTG00?=
 =?utf-8?B?QUdBMSt3L2ZuTGwxam5hR1FRWE93QVFaQm9seXZhaFYxd3JqcVVOK21BVWdV?=
 =?utf-8?B?WlU1MGdHNmVsdXEyYlh1RVg3SHErcXIzYytuUExpTmJlMW84b080NDd2Z2lU?=
 =?utf-8?B?bEp4WWNzZ0F5bzdub1c0MGVtWVdhL0grZUQ2WmNXZjlqNktIdXlRZEkzd0dF?=
 =?utf-8?B?dFQvQlkxb3cvbDBvQmVGdVpOc2NxcW5aY2J2SEgwdkdrazJuc3FFOXpvSE5K?=
 =?utf-8?B?MFlNOTVBbmM3Lzk2L2ZKc2MxVkZFeUNOZ3RNN3ZIV0VNTUxvL1BzUUJCZEhs?=
 =?utf-8?B?Z0x3L2Z6WUNjb09UTUtJaE1PWEVSeWFBTUxISEkybXhLQS9UVThTZ254bWpa?=
 =?utf-8?B?cGVyTWxGdTdNYjVJcG9sV2JzQnZGQjVSTkk2R2ZUOTczYWlyc0w0M0xmUHhz?=
 =?utf-8?B?eVlwUDVYUXFwWSt5QVR3aU5WdVFaL2diZ0M5djZlM2ZveTZ0d2lIQ0dXK1hw?=
 =?utf-8?B?MDFCeUlwdm5mNlY1QXI0cW9NWFliNTJFOWJTdDlLZW9aL0pKRFJKSnZzZkxZ?=
 =?utf-8?B?UEhsRFN5aEI1UEhLYWp2Q2k3cUQxY3Q3ejNnMUt5TlZxbVNaVjR3T2hXRTZQ?=
 =?utf-8?B?bDE0bHhLeHNISGE4ZTZWMmZCTkw1ZFRrZnY0UGFjVlg5K3p6dHFvY3lHTjZs?=
 =?utf-8?B?SnNnczVGYkw0ZmpvNWFudkVDdXV5bk5yN3NnSGVRVWdjMURQM0FHaUVGMGlU?=
 =?utf-8?B?bmNIbmVRdUdPSWl0b051Zm5mUExZY1Z6NldCOVB1Nm5tczR2UXpLV2ZXUmQr?=
 =?utf-8?B?SnczbDNmRHFtVE8ycGtJOGtFRHR0UDlKcEdGRUZ4MGtmWC9UM1ZOY2FuazFO?=
 =?utf-8?B?NVZMeDdjMUE3UzdBZEN4dmtGckV6eUFQQ0NrQWpVTmxFb3pOMVRQTjVWUGZE?=
 =?utf-8?B?Zko0SmZXLzc2SXhrd3lrZytySmRnanJHeUpkKzVzclYxWmpGWG1ONzk1cTV5?=
 =?utf-8?B?Q0dyUnVKM0RBTDk2NURuVktET0hUWXpCTVlSekNuUm9BRUJZcnpnZTBwSTJD?=
 =?utf-8?B?dlVDL0M3WTgxVzJZWDFUbzUxeGhFWXl2ekFnM0wxOWpMWmNPZWZCNXVwQVdX?=
 =?utf-8?B?VnhLbkU2NkVvLy9vWFJzaFpmWEdCY2xmUy9rRjNGM2ZHRHBzUWcyK2dXNkha?=
 =?utf-8?B?c2wrQ3RjL0hxVkE2Y05admQ4bmRwOE5MR3dIWEJhSVJqMG1ub2dqM3NLZ25x?=
 =?utf-8?B?Y1h4bGR1b2ZnSEprMFNBVjB1dWkwVmtrTDdCWHMzVWlNaGp0NnFwblNBd0Rn?=
 =?utf-8?B?S1RWMjA3WVRRY2xXQmNndlAvTkUwODRra0NVNTZRN2VDZEFkU2lSV0hWeUVE?=
 =?utf-8?B?NE5xeFB5c2FRbWZqUmMwSkFrWXMwdVVUbk1vVFh6OVFQcGpucExmV1pYMEo1?=
 =?utf-8?B?eEpob0RxK0ZoblBOaWYzZ0NRY21sdjUzZjhFQ0tFQVp3Q1ZhclB5TUFNaXpy?=
 =?utf-8?B?LzhYZnE4cmw5NndpRnBYU25UbkJQRlM3ZEdmTWM1SFRFRXRqczdCTXJFeFFN?=
 =?utf-8?B?L1FoSW16V2l0UDlZQ1A4bWlwV2ZDUzZKcnl6N1o4amhGWDJxeVJzVXFCQU93?=
 =?utf-8?B?OVdqekdpYlVkQXQvOWR6cEp4MzVsNW85RzlDS0kwT3BPczZLeGFpV2xobFUz?=
 =?utf-8?B?cmkwYkF4NDFaOHZURXU4RnlUL1pSRXl2dmgzWVozR2tvUDJLUUk2WGowY1Np?=
 =?utf-8?B?QVJDS3Q3TDFPUUx0TFAva2ZvVzZ0N0MybU9WaVNSUDZMT2pnNUE2NmNUbEo1?=
 =?utf-8?B?MjRBc1BSL1diTy9MRkl6dkFwOVZteWVNNldGWDM5TGxWOVp2K2pPRnJrektS?=
 =?utf-8?Q?Hq90h8Sev1PqiW8Kli9r8Gw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52deaf53-6ddf-4dee-fa66-08d9d6009079
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 19:20:16.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQqhwRTKwIMMZcX0opGciKHAaH0+ssiggP7S6p+u/VlJ/iaCKptlgPqWJ9p/qy01YRwc4ndfTIkkPpkcc16p7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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

LGTM acked-by: Nirmoy Das <nirmoy.das@amd.com>


On 1/12/2022 7:52 PM, Jonathan Kim wrote:
> Some suggested cleanups to declutter ttm when doing debug VRAM access over
> SDMA.
>
> v2: rename post_mortem_allowed func to has_timeouts_enable.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++++++----------------
>   2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a675dde81ce0..747d310aa72f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1448,6 +1448,15 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>   int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>   			       enum amd_powergating_state state);
>   
> +static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
> +{
> +	return amdgpu_gpu_recovery != 0 &&
> +		adev->gfx_timeout != MAX_SCHEDULE_TIMEOUT &&
> +		adev->compute_timeout != MAX_SCHEDULE_TIMEOUT &&
> +		adev->sdma_timeout != MAX_SCHEDULE_TIMEOUT &&
> +		adev->video_timeout != MAX_SCHEDULE_TIMEOUT;
> +}
> +
>   #include "amdgpu_object.h"
>   
>   static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 33781509838c..b489cd8abe31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1460,10 +1460,11 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	if (r)
>   		goto out;
>   
> -	src_addr = write ? amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) :
> -			amdgpu_bo_gpu_offset(abo);
> -	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
> -			amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
> +	src_addr = amdgpu_bo_gpu_offset(abo);
> +	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
> +	if (write)
> +		swap(src_addr, dst_addr);
> +
>   	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr, PAGE_SIZE, false);
>   
>   	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
> @@ -1486,15 +1487,6 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	return r;
>   }
>   
> -static inline bool amdgpu_ttm_allow_post_mortem_debug(struct amdgpu_device *adev)
> -{
> -	return amdgpu_gpu_recovery == 0 ||
> -		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
> -		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
> -		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
> -		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
> -}
> -
>   /**
>    * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
>    *
> @@ -1519,7 +1511,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	if (bo->resource->mem_type != TTM_PL_VRAM)
>   		return -EIO;
>   
> -	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
> +	if (amdgpu_device_has_timeouts_enabled(adev) &&
>   			!amdgpu_ttm_access_memory_sdma(bo, offset, buf, len, write))
>   		return len;
>   
> @@ -1909,8 +1901,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>   	ttm_device_fini(&adev->mman.bdev);
>   	adev->mman.initialized = false;
> -	if (adev->mman.sdma_access_ptr)
> -		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
>   	DRM_INFO("amdgpu: ttm finalized\n");
>   }
