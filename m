Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A36BC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 21:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2648EF53;
	Mon, 25 Jul 2022 21:17:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96508EF53
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 21:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLXMeGtGQgw1lOc0jw6iOYQic1wECgTFeNOQ5h7F+I+RaxVEGK1/igiuDFUB8PAx5HtWpLipAH9uKAInxHOkgvmjwFFf9j00IzBQ4bTNBKcbWQdcM49qRM3t4dq9tvk1295rdzPZWMJVmblsjr05YfTheIsYsfruTxmhuHJMfrqrnD57FBe8efgaHigM81q2706YlmXbZwwPJGt4hUyA/n/Vk5Q7QPxQZy6g37/lLc4OgKHRr/jXEvqjD7o7lyPy9W8uQ7/13IVss34CjeHqtwrqM/hunY/+edXTXotXXjEF/udRMgA8gz+vsyKVfiwhEwC/2peIv83eZRx494ABCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR5ujMXNnXLoSNIQ0MIyeLcoQMiT+KugrLFk0Xi7QT4=;
 b=dROQnXPfE7nRDbe1cyDrYIa+P4gz2/6RvFP9r8H1C9Tlwm3IaHAin/ZBjn+spQawXAEQrVPR2pU+gjEDdn01sJBGqDCfGjXKRW3hPc9N+xokWMUAWJgD0PmwEKavLF+/Td3guSYFtysgkHp7Ms9y2AQbjgmWfXnbca5oaALI2R6Lpd4k5Ed8lSwl1UsKSveryaNp1XN+VWfXsuyHdTrTpPfR/gCGuT71Rn58PHNgQIlvdt1a6I6WqrcTrhAYkomNjnB8+FpSABL8Mituw0VdnB0jugpk/qbPojODqjJuRElhTqXhczvYXB7l6NSbgY8RMmyYREHYNn7B6/PqkT8lFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR5ujMXNnXLoSNIQ0MIyeLcoQMiT+KugrLFk0Xi7QT4=;
 b=kTHpz3YmfbNaEf/9llv/v2jf92cBwnZc5xHX8JBZhTzkxN1KNuj2+AJIfj9ZZHuq6pdKLcNC1GEM1NPEsabIJS1OPLp8hqTpGrB3oLDCBRtsV0kLwf9Wp5F7M6TiJilP/qGu1jfRGG9T1RJq/rGMQTbpHyL2douZL9hItih8gUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 21:17:45 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:17:45 +0000
Message-ID: <85e76646-4b14-2d33-8143-0fe0095afa25@amd.com>
Date: Mon, 25 Jul 2022 17:17:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] drm/amdgpu: reduce reset time
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-5-Victor.Zhao@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220722073403.5171-5-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20466936-60a2-4c8a-42a0-08da6e831e29
X-MS-TrafficTypeDiagnostic: DM5PR12MB1164:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3uDa+Slu+7dAScVpUX165jOXyj4eaydYCM+Dv/gT30b3QXn5hVQfHcHPo4rza91+lDCVcYFgeEEIwIbs6eKQLUe7YevuVipxMtG7TyAOSzoI3UFI070xlycaJc1XnarOLw912HrKNhxKxJX8EfAWYA3hseh9xRMJ/9QdM9/YU1eV5m5cWQKlXX6o9+UsXikLBNKMJyMZ4qgCV2sJpmHghhlboEYE2mL/6CTEcKnmKFKKbQi5fKNXC+jPfsGQusWbR0mfkoJEH6CC/OA4YMo97alEUzXShtnBBIrlBUGiQIeVaSlghi9HVqYJT2eAl//n3kGwVSN4FgWyvs+VG7SfFnm8ZrtTr5g/eHxV5Rhy16QG8U7C3/wVU7A30CZ/uajltu4yrXVThhKyHreLhTOjq2XJ7vzjxr9wdsm4BnDK7/EsWfLuKlUf4PLc1MuFif+w4Kw7i+u3lIf4O1yd55HdX6xfG65CrWLMx5ndcbjImvNSRS0gPZpyuiX8fFyqczRNINpImsOC4tIoK7PwfyNY7XpBakj5A+1x6e99cQzR1nQzqManr26xfzu7GM+oZjr7Qt0PnLfhAF53Q5V4RyK8DHaP3aj6AkA4K4AFBK37Zy2j4gkYmn6XnI4KeoWHL4hNk1D3PAyj+5AAfW7vcdjpVyhydX9vZfoDs7g/UM3AuxYjIptRj/5j8MKsFO1hUjvQjz17PGGa94OD6C14KwhTIYVFoypVpwQ2PiyNyd7DtlxF5NAU1WYL/IbuSlqdNJT2AWu45aSIoUmg8LJjUcs+0vUxGbHp00o9Bh6ND68vm92OkvdJHxIHBdh5bDCQmSFPVypFA4Bf1jfNBm+EKO0Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(31686004)(8936002)(83380400001)(36756003)(6512007)(86362001)(31696002)(38100700002)(186003)(6506007)(53546011)(2616005)(41300700001)(6486002)(478600001)(66946007)(5660300002)(4326008)(44832011)(8676002)(66556008)(66476007)(316002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxzdzUyZVA1dGtyazZXZ3VUdWh5NXN6cmpyWG9wM0lQNGI3cXJ5Ykl5WkZ4?=
 =?utf-8?B?eHM2RnNzN2x1NzlpK2UzTW5zTzlwS0hSaDQvWk1wOCtVZVJGK214QXo3UENV?=
 =?utf-8?B?VWF1d0hQZEZWcWhFZUZsUzJHNnppMGlnd2RGNFlFbTQvWUMyZHFlbm5SRVA2?=
 =?utf-8?B?aTVYOXdicDFmSzRaWjZwZTRWd1ZvV0JMdXRJbit0QXRPRFMwcjZ2UjVJbU41?=
 =?utf-8?B?dGVRKzc2Lyt5aTYrMXFRemhkT0JPYi9kL2w4NUo2RmRyUEVqTHFFYXpmc01M?=
 =?utf-8?B?T3o0OGxXdzYzdkZLV3ZnQ1BQU0VKaERyNVZwRlp6V2paaklPbk82RGJjTWx1?=
 =?utf-8?B?NUpQSkxJRUVPenYzRzIrVGc3MUJpcCtGR0JSMXpsS2NxYWVVZVdVS09RQkVE?=
 =?utf-8?B?cU9oTHNheExqUVlFQ2JLVmR4SmdLQjhaRnMvOTlvT1MxZzRISU1IL3ZvSVhJ?=
 =?utf-8?B?VXRQd0lnVDRaS21BZXZ1N05MRC9OSExGQlF3RXRZTWJKL2lkSkpFU3llSHhI?=
 =?utf-8?B?NXl2eHc4aUZoUGxPdi9mazg5ZmxLSU9JSXFmT2d4U0p3ckxoVzhld3Q4TlNY?=
 =?utf-8?B?WjVXT1EyVENVZnhldDZMRGpEays2WGoxYkJ1MGZ3ellTR2lJRGVTSUhPdmJD?=
 =?utf-8?B?eENlUGVvL2V5c2hmNEd0eXpjK0Z0c3Z2TEpRc0VXb3plaHU2Wlova1FObmhU?=
 =?utf-8?B?bnBXcTZHMlQ4V1lVRDJpVkJiNnpNeUhmek1uaFY2YzJScFRCVm9Xa0JQR1pO?=
 =?utf-8?B?QWxWK2ZkM095a0xrNllISk5oTmw1SWF1M2duTnl0eU16REUrVWloMUR3UXFz?=
 =?utf-8?B?VHZhZC9id3UvY2RGTmtvOXdVNmRXcnRLVU8yU3NZZGhyQzZ5SlMvREVPRWxt?=
 =?utf-8?B?ZEdvUGNHYm9UL0VxU0hVOEtSOHU5anIveVN1VmxZSnF5bnpTY2FUYytUYURM?=
 =?utf-8?B?ODlhcUtWbjhOaTBackJRM1Q5d0krUTBtd01rL3g0KzNRdUVLaEpvV1o3RGFp?=
 =?utf-8?B?dk9XcEZQWHVsYUZhWTRyenV1REUvOEFtaHFzRk5LWHpnZ29NSDl2cjdEcVd5?=
 =?utf-8?B?ZWEzTHg1NXZ5d1F0cW1ycTVYdnRTZUlPeWJxNk9zN1dMbloxeVRVTDRJT0lj?=
 =?utf-8?B?OHNHTVdHQ1AzeTdaa3RGTHdqRDdKMUJkZUI1RTV4VEFsZnNDY3ovb1NENjNt?=
 =?utf-8?B?My9QczZxb1UzSmRiWlBIeEFyU0xFRGI3TkNyN0t5UWVia2s3NksyRTd2aUd4?=
 =?utf-8?B?UUZlZWszRUlxQTRHTTRxdlZlemF5MHRDMlZBTWU4M0srdE13ZjhjamppbDls?=
 =?utf-8?B?WmszRWRHdkd1YXd2R0kwb3EwMEZRNUVONTNIQ1lab3RPT1lsTk1UeFFQbUQ3?=
 =?utf-8?B?NGk3ckRzK0xEMGpmNFQra0hpNWxldExqa0JBdHhEalorMml0VkVEOHdaNWxu?=
 =?utf-8?B?UmJKWnFSdi9KM0FSSGEvbHNwbklFUmpKdmUzTjN4UjhSRGN0YXVkYURGa0FT?=
 =?utf-8?B?bzZQZlBoR1Y3ZHYrVkhLTW1DYTVhZ2dZcHp3dmdKUUdxaCtEWTBNOGxMQVhp?=
 =?utf-8?B?Y3ZvaGg4c1dKSEFyVG9hVXJQUlFhbTZKUUd4aklzNG5PY3M5RnM2OXdvZHNa?=
 =?utf-8?B?R29PU1ZyVUZCVzdsb3d5Tnp3ZFNuQnJ6QzlPM0FTb1JVazJQRFR4M3dmMTkx?=
 =?utf-8?B?RGtlUFBYTWVYVTdUWDRQdCsxbEtJNEVBSFFKMGgwMTZ6ZjRSNjB0YmN2WlpL?=
 =?utf-8?B?ekQ5VlhlV2hJVk9EdXJLRHBiOXVYOHIreEFZbkFteUpubDViUWNLcnZhOGdC?=
 =?utf-8?B?ak1DS1NuRHpRV0ZDZjYyMWZmK2RMd3JPbm5GK21BWkEyYU1HdHlyTXJDZzFw?=
 =?utf-8?B?OC9tak02aW9IWW9UVGRzQ2R6ZE5IOGZCN0ZqWG5xWXVhS2ljVHJ4M1JGSngv?=
 =?utf-8?B?ZHB2Q0M5aURWd3doUWNPRXh3Q2tFdk5CM29pYU1oT1pZRnZ6UEFkT0ZrQXhC?=
 =?utf-8?B?a1lFNW12Njc4WUI0dkZWOFo5dGh4aEpXbWJXcGRMWFExN3ZiU2loSlhVdWRP?=
 =?utf-8?B?Z0NJQ1h1K2hqNGw4aFBDdVQrV1M4dWxmV2ZLVytobVE5Y2tkV0EwWlFrRElF?=
 =?utf-8?B?eERlYXFoOUpMYjZ3VXBjaStGN2Q2c3dsVTlCeEJHZEZuUlcvWE01QTlhOFBv?=
 =?utf-8?Q?fBRCd4z2vBhwKuKZdkIy5LjmfcVIr2Dvg/5+7S9iZ5+o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20466936-60a2-4c8a-42a0-08da6e831e29
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 21:17:45.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHpGeN7xJEc1HgzmhXlgaMPP0T8RScJHG1OU9rq+VY9kiQSeuVLuJ01UAjSTf+HLBKWYK9R19MgA2HaZcbQfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-22 03:34, Victor Zhao wrote:
> In multi container use case, reset time is important, so skip ring
> tests and cp halt wait during ip suspending for reset as they are
> going to fail and cost more time on reset


Why are they failing in this case ? Skipping ring tests is not the best 
idea as you
loose important indicator of system's sanity. Is there any way to make 
them work ?


>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 26 +++++++++++++++----------
>   2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 222d3d7ea076..f872495ccc3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -477,7 +477,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
>   		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
>   					   RESET_QUEUES, 0, 0);
>   
> -	if (adev->gfx.kiq.ring.sched.ready)
> +	if (adev->gfx.kiq.ring.sched.ready && !amdgpu_in_reset(adev))
>   		r = amdgpu_ring_test_helper(kiq_ring);
>   	spin_unlock(&adev->gfx.kiq.ring_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index fafbad3cf08d..9ae29023e38f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5971,16 +5971,19 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
>   	}
>   
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i >= adev->usec_timeout)
> -		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
> +	if (!amdgpu_in_reset(adev)) {
> +		for (i = 0; i < adev->usec_timeout; i++) {
> +			if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
> +				break;
> +			udelay(1);
> +		}
>   
> +		if (i >= adev->usec_timeout)
> +			DRM_ERROR("failed to %s cp gfx\n",
> +				  enable ? "unhalt" : "halt");
> +	}
>   	return 0;
> +
>   }


This change has impact beyond container case no ? We had no issue
with this code during regular reset cases so why we would give up on 
this code
which confirms CP is idle ? What is the side effect of skipping this 
during all GPU resets ?

Andrey


>   
>   static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
> @@ -7569,8 +7572,10 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
>   					   PREEMPT_QUEUES, 0, 0);
> -
> -	return amdgpu_ring_test_helper(kiq_ring);
> +	if (!amdgpu_in_reset(adev))
> +		return amdgpu_ring_test_helper(kiq_ring);
> +	else
> +		return 0;
>   }
>   #endif
>   
> @@ -7610,6 +7615,7 @@ static int gfx_v10_0_hw_fini(void *handle)
>   
>   		return 0;
>   	}
> +
>   	gfx_v10_0_cp_enable(adev, false);
>   	gfx_v10_0_enable_gui_idle_interrupt(adev, false);
>   
