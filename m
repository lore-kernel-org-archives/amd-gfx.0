Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD939C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 19:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BF810E19E;
	Mon, 12 Dec 2022 19:20:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E348610E19E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 19:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5QJVYUGa9DuD0rflR+g70lShS4u/5bVFYOSUJTY3L3r5ejzEVz7eGkAOaQBUTwJX9tUEsv0T8b5DSK71h5ZofcUXfeEDCwe4HTIQtO4FnYyRzcN/p2/JBM34jJztDImvfaTZNGNiYcVVJXZ8ebIPb1KP7Sr0Y3sycI424WYZLcB3U6NTrbUc2qkR/cQI6+sBVaA87zrDOQ0bTy/5hFk+TLkQjJiEMW+S9UjSgqUtxKQO1g9psB1tnc7KRZW0+QZli74PkfiGsKzUMssf5nwPR/KSg3io21jsXKsFT92n/2Y0QpA3Ddp4VYN5r61+TZyuPMzA/Z9QMPQARlS8ZcYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH3HWthgXyDK9X+wyQt14ER9UgW0c8ulUjUHVbxE1Cg=;
 b=ALmUlH8cz5i8Mm8UImHaiWAu80aMCSACRFICMBjw0+PY20DMDULuYJMknI/MNoBWNnNAuqXj+3yuFcJv36I9eJ1ljGHpTfIFvEZ5gPG7/WOQ3Vewu+6LSusjIg/ethmbJFXPuCS63wv/EFkhqGNha6cuaJNQJsU/hZJn1oc7p+hBLhgKGdhwIjUSedXllMWtOthX7x1bRtiAW4WJup3v0RdyCLw+8WxYqRStI9+o1G7IbOTXNvHLDRNHAMhEMVtlY66me0eO8azWzwKjoxJDM/njjniO3Xb57SvEou6UK8MwWRx1n9DkoVGQ93QQPMIHhvJeYjXXlzicisuNC6PICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH3HWthgXyDK9X+wyQt14ER9UgW0c8ulUjUHVbxE1Cg=;
 b=sHRnWEc/ccBUQWXZEEo9uVDwPREi3jRuLei7Wh7Uo/u/Xq5W6sYjs6vGCSqFEIsSZtVEMwK2NvOHRUO6h9mHMg4DR6HxbGs7DRO7lmPOr1xuhF39IvJaN4SQLauVMIEpKX1esZc91lLrGn3Rr8ZD6VaoCYHfUbed0LUkuXzU6DA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:19:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:19:57 +0000
Message-ID: <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
Date: Mon, 12 Dec 2022 20:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221212174834.36544-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f94821-a7ff-4669-5075-08dadc75dad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZqADNfwDTSPNyQ6DV03NJzdKLy8Bt1sgsHnKDogHyMfRz7WzT8ublXrch3rAzffiJRm09QhW3RBQWdfcE/9Npd08sczh946g3L1LCgmTG8rxhIYYzkpjMqiRAOeSfaN++izBlgZ5xVAZf8LJ+k/TSsdWvDgv8AoeegNaUxO87RKMVZgIQjh7PLnpAdFdGeTblv4lKassmVf9Q3TMRSEJKPnqG6VLuXVNa0kADQR7+toj4Hv4eppwWoEF9lfRgucy+kVRiSJI5DxMn/NfnC0URsd2EzdlA5aSMHIih9zXzcRmdZmVF5YeWKRw4oLVLXPCshS6gkSDRJrLcRPpRtB/g0ZSKdRYbP4NeW1KYNXxzyIGKKfiQx3Cr9IG5b+LeqjIZ+OqqgYuEquCpgyLy4WCTFv438s/RIFDKVClBJRmXnt0GZdSvThvu+JdhVTOVhVepZtx1X524QaqFHDBF0P9tY3TI8jqwZF1K0l9AgBY5bgd4cjdU+w4fVTJJ5hApoUaXLmv6u/KsKbQoFy2KZE/bTTVB5E6jk7Us2o/FEV1zfA0CP3mWYwuLclIO7ulN6zUQGOxUzTjjvBXHicmLwMUqRe+u1dGn47abs2A6+a3AEbFGzFK2Kk+t2GdEcfZjcAlXUvhu4xhrejIShFN5lSLGK1z1P32C7TeHIcxVo6uNy7rme2uHVHcIwZHqb3a3rlxFQ68QZ+EjUMW/Hsl7KP5yhBIsqs5KWuxHkYQ5EABmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(31686004)(31696002)(2906002)(83380400001)(2616005)(86362001)(66946007)(36756003)(5660300002)(8936002)(38100700002)(41300700001)(316002)(66556008)(4326008)(66476007)(8676002)(66574015)(6666004)(110136005)(186003)(6506007)(478600001)(6512007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9iQWluMHJmcG9SempYeitSL3NMQlhvald1d0dGRjAyWWJmeU9tUmlkd2dx?=
 =?utf-8?B?ekptZkNabU4zMVp1VVZwbUh5RHdMTVZhZHhYRDVwS240V3NlcVQ2TWsxb0dP?=
 =?utf-8?B?R3MzZk54bVlzcDc3cEhqbVkrZVI4UUJoVVdCTHJrdzc3S1RSODB4VElxN3Rz?=
 =?utf-8?B?bllMOTc5NnYzMDdvNjdPbzI2c2JLZmhTbWlHR1VwNk0vLzBzYTV1NEErUFFO?=
 =?utf-8?B?bXdkV2huNnprZ0dZa09LR0pDWW9XM3VNNE4zbnVnTVNPUS9Qb3Z1aHJZTksv?=
 =?utf-8?B?akJJQXU0ak5ZRVFzQXZmbSs2QVBIbURIN0NtcU55YStmNUZJNDFabjIyT05J?=
 =?utf-8?B?SXlBUE5VNGlRajFGVjloNTFKQ2dWRE5sSm9laG8rb2g4UUhGVHM1OUhYRHNy?=
 =?utf-8?B?OXVsTWhiWGZPNWlRb1V3dVoxSDY0ckozalBMRTdYRGRFUWV6NVAxdStXU3ZD?=
 =?utf-8?B?aXRPNGQzOGZUck5neTlPc1ZFMmFCaUhPalNUUDNnUUJWTlUwVFlEMG5UMU9H?=
 =?utf-8?B?R0lqcW9rcDRkWmVjczdpZDVGU20xVE04S24xN2czTXhOMC9HN1dsaHlzdGdr?=
 =?utf-8?B?eEVDZUJiQlhqcmI5alpNMjBZaFk2NERqcE95ZHVwRkUydWFpZVhMNGY1QVBx?=
 =?utf-8?B?Q3Z2SW5XZ0FoMnczTXdtL3pjUXdaWUVtcHM1bVFSUURTUTcvc1I0TmJOZDdt?=
 =?utf-8?B?NkhONGRSdGV3ZWJzOGtyUkVva1Q3UnNTSGRhZnEycmtWMVhHL3ZjakpPTmRI?=
 =?utf-8?B?NjhsTFp5NDM1VStJaUhyN0pVY0JDbzFzbkFIYW55cFN6OVloQ2dqWVd5Y3FQ?=
 =?utf-8?B?aVM1K3BRN08wZHJoeXVYSzFsWm5BTmd2MnFpWUd4VDduYW1LRktOSmsxREEv?=
 =?utf-8?B?amRTb1d4Ry9aOVhYRU84Qkg3VHY2OHc4QjZzbFErSUJQcHRhbndKT0tUYy9y?=
 =?utf-8?B?UGh1VFl4ZlFBK1JzTFNnbjNOczZLMlo0OG1ENlMvTzUwWUtDSVZzSlBiRCs4?=
 =?utf-8?B?MzVlV2FHZXlLdDJQN1A2dUpreE4vcHc4WHNGbkN1bmtlTXhoYVllQVc0MW1U?=
 =?utf-8?B?OXNWcE9Ia3R5VndiQmF6eHJoQmhDZkNzSXRJdkpuTG5DS1g3bXhUV2h1SWor?=
 =?utf-8?B?OVR3Qjcza2VKSTFCRm1KMGUyUjY0NHFVRDNJaUxkUmppSHpFdTU4UzVwZzJK?=
 =?utf-8?B?RHFMazJUdlA2clVvNlU5U3RpbXlvbHI4aUZSZUNHdUk4VVV3ZGNYQ3JQOUZW?=
 =?utf-8?B?NFN1b1MvZTREWVBiNis5cXJnY0NNL2NOdWhFRisyK2FreW03OVg3cDVxOFVv?=
 =?utf-8?B?elBvNnhkaUVqbExneGxFL1ZDdWJHSzUrdXliNWFvSHpGakxVMHZmSXZVS3Iw?=
 =?utf-8?B?UGUyZzlsa0dBc2V3TXl1LzJ3YWhZdUI1d0xROHhLOVpoRnBuMXBnMWp5L0Vl?=
 =?utf-8?B?WWdDaG92dGJtSkllWS93YkFxb2JabDdZQUtmMmYrY3U1M2xqNkxaWFJTbENP?=
 =?utf-8?B?UEUxRDhBS3ZUNnJVTCtjUVNQMU1VNlFmTCtrRjcvUG9WdHA4S1dTajJUSUpu?=
 =?utf-8?B?OUtHWisxb2NrelF6NGJvM2FjYWFMWHBvK1hWRXdFNHIzUlJ2QmthS1JKVFda?=
 =?utf-8?B?RFgxWlplWXI3eXRaQ2VnUnUrQlFDdGo2cU45SUlQQXFzcGZXZFpxd3d6cW54?=
 =?utf-8?B?R2E2MzNkVTBhWE9zVk1tSnpLdmxqbXgvQWRCUmRVR1NZSUhTQ3dYelpTVjJi?=
 =?utf-8?B?dVVtQTE4dTNMSmNOQ1JRUCtabWVwbTIzbkxyRHpYelRqdG1ReFg0SFpud0Ez?=
 =?utf-8?B?QWhOaml1eHYwcDZYMkptSmRvaVZ4TExFYjAyN2ErRTgrNWZ0d1diS01kRnFq?=
 =?utf-8?B?TmgvZjNabG01bXUxZ0pIb1F0RXVzWjBkRFZsRzQrOTBJTTRobXVaRE5zWHli?=
 =?utf-8?B?QTJvMzMyb3FCRVJVWUducVpZMG1VZGZVRUtWVWN0SDR6Qm9JejVzdWpxMHNq?=
 =?utf-8?B?YkRORGU1Nlp6WDBxbktiZWlUaHowczVHWGEzOTZiUHo5dzR2M0JLYmdHRUF4?=
 =?utf-8?B?bThPQWtvOXlPZlA1T2FPYkJOdWlmQnVlRFdPWDVMdmZ2OXo3dDhvS0x5Zm9G?=
 =?utf-8?B?cHdvNERHYVExVVlEbzFJa09YL0cyOVoyczc4UDBMWWRoeGMwcXpueUNHREdK?=
 =?utf-8?Q?QoFq3m0rPgm2lRsR6HZMw/YuR9cybH45dYAtgkt3chME?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f94821-a7ff-4669-5075-08dadc75dad4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 19:19:56.9165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tULzR8U/6++C53v8giQsI7KFF18LXjTQpMVINtjneWXzPCkTqBbBZ9B7YPmjEYnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.12.22 um 18:48 schrieb Luben Tuikov:
> Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
> requested memory exists, and to allow for non-exclusive domain allocations, as
> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
> AMDGPU_GEM_DOMAIN_GTT.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   
>   	/*
>   	 * If GTT is part of requested domains the check must succeed to
> -	 * allow fall back to GTT
> +	 * allow fall back to GTT.
> +	 *
> +	 * Note that allocations can request from either domain. For
> +	 * this reason, check either in non-exclusive way, and if
> +	 * neither satisfies, fail the validation.

That's not correct, the original logic was completely intentional.

If both VRAM and GTT are specified it's valid if the size fits only into 
GTT.

Regards,
Christian.

>   	 */
>   	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -
> -		if (size < man->size)
> +		if (man && size < man->size)
>   			return true;
> -		else
> -			goto fail;
>   	}
>   
>   	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -
> -		if (size < man->size)
> +		if (man && size < man->size)
>   			return true;
> -		else
> -			goto fail;
>   	}
>   
> -
>   	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
> -	return true;
>   
> -fail:
>   	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
>   		  man->size);
>   	return false;
>
> base-commit: 20e03e7f6e8efd42168db6d3fe044b804e0ede8f

