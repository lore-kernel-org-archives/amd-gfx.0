Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1660CD4F49
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF5C10E32F;
	Mon, 18 May 2026 14:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B8B856lW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECB410E32F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT2lOg5dl9da20cwhHLlO9iIkNinWoQTrLCJ8WaDWJhaxEJGbvUD5uVXe7Sqg3VZCs8P2nNChaExBED9ZqNA/d9bZTeT3Y/i4ufcZfTjMdFFNZNeYU1OY7TulPAZPhuPQ79rbk423L6U0BG/ogavHEXKU55/rgATzjkUyey2S3EMzn3Hg+XA2A0UfBSIT2UGPqgCv//eiC0rgr9mxkX/dOFfrI7nBqOFWERxndLBwnmEAiwLpQCxeLFioczLo8jqoKANRLR2c+4YgRrg4+HeCAHX8bhIo2y4MTwo4TtUINecFyRhiqQK4LnkVAqsqCCK/ztF0ulcDh9vGwokynWM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QawLYcQiYt6xggnlDoF++f2twCRLhfk380fs6yZ/GQQ=;
 b=HCxycLpTV4idbNR+m7iOrmFmOTr808f5B6WSQ27og/nQ5PCxvmbrde1GSZAJP9qGqA5n5LWv0OCzc5gGee2qQOXLWEZG7E3T7dwHavHA1arifpiK8T99c/mYH4XbfgQCY6Xl522NRJmPJBcMA6EjBnD3bu+k1owbDlgBJQI1RPjJxZ9GhzWihJ+ie4HMYT/WIVjXBdJs6dvmDU9EAzYED/1kzAh0c2gOHsVDkRO/58RnMec8AiQgW2Clj9uxMtEcTbF2+Nt3oDf5UNS/b4y3b8adiEVNh+A6ku8zpstT/rmHV3MrNud+OmBJzqZiORfnqBFjzRoCqlq4AYqdOxM36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QawLYcQiYt6xggnlDoF++f2twCRLhfk380fs6yZ/GQQ=;
 b=B8B856lWGAGBD6JIZ6M5QY9eBStvAeoljixsiQm1PaLkIbiIaJKvsiT1lb2+Mn4dRcCS0ROqTUDxJn2XUmlBZEGKKlDeKizVzE/YoWNi5BUQo3JH/9rYh4x9/ewVASb0WFNGbGFUsDPBI9Vmai+uNLShHuGwWcU2rWwPeQ9ARfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:44:40 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:44:40 +0000
Message-ID: <04f1af98-4488-4bf4-ba07-5d673c26c1bb@amd.com>
Date: Mon, 18 May 2026 20:14:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Fix some clean up during userq create/destroy
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260518143441.3614571-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260518143441.3614571-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::12) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: a7805fef-8d1f-4895-8f99-08deb4ebfdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: hE8BipLuI0mRiPHEPA79Ips02kqF1G0+keTeExEIL2DZ6lJWkbQtPy2wTGDVmNn6vzgNW0T5i3rhj970IMFMJidzMqmJDOxMK+rD4vjqg4UxXjqQrtwH64a2R3LpU7Iei3EtXm0WUkPJZ7uSVihGHEwL8SWFz9QHRzisSbazMQPOER6WQ4Ut08ZyatAc59gENqoLifNqH1Q8XkbCoKFPL0cINWwtSNOeVYZd2zNCZAvkLZTzSu/BY9+kck8izzZUCW/G+LuqKM+JVcVFiIfskSuA9Bb4QcCMrkiFsHy4Pl8jfgrROYTRU1kDyCqHuFCZpXOWp19hBIoBioZRcJPNcXynEpeObygM3RcaGjFX6+MrrwPpsx1S87pHlDYYI893JpVygzopNDZpnHvymooUVae4HuaMXO+rZ4xbBmANi7hij0HMvhCR1XocYp3V0xQ8a8Kw8u3Yx3SD3HSK4J57WLRBSU6V1J9WtoQjwOEzDl7PcY3MSKUuPY+wmPLyOt5UP26zsFdjarJfCcuI5UXv1sz/KHwG2QQ8qOopZbTWDQnQLkwNXBg83woynl2HCTG+ZJvDb9psU7B6EyyDz10DCW3CecnGzaHcai3uuXiWOpfvYn2AYcx5kB4I4WYumN0EbDy1VVPAfJ+6PHRk+oEfaPZHCGPYcJl17R4oNYVpXfChNwUcVGfnLLvHNvpmbOlh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNsL3Q2TEh1S2ZFaGhvVDdGbWJ1VXcycEVpV2p2a3JkYllNZnlpR2hvdHVa?=
 =?utf-8?B?K1dxc2Q5R3h2WllXOEI0KytNekNoMFZVTXNEbkQ5V0dQdk1Ma0czb084SjU1?=
 =?utf-8?B?VkZmMFBYQ1krWE5QWkNMditlQUZqY1lFTlE4M2NrdGVCTTFObHdZTGpKL0I3?=
 =?utf-8?B?d2FHTG5jWm9GYnRmTGVZOVM2aDBDR1VlSjRhZW5GN1dSVEdZekIvSjdVTE9I?=
 =?utf-8?B?SjdaSUViL21oZWxqdDhWM01lNGZHdWFDenVhNXNjN3JVK3NTN0pISERHbUto?=
 =?utf-8?B?bytEa0Z4clE2QjUxYnluSW0vSTR5dHNEUUwxanBja05iM2NEcStLYUpzY0gr?=
 =?utf-8?B?VHJYWWJYa1B1WU9xbldDdi82QTEvRE16UzJNeTlka2p2QVl5Ri9ZT0dobEZP?=
 =?utf-8?B?VzgyS24rNk5JTlM0Q3Bxa1RId3h0ZVlCY3Blb1kxRlI2dzRhajVPUWtlK09y?=
 =?utf-8?B?bG9mUWNwZTNQS3NVUXIxbEpBSFl3b1ZjbHRUZE40OWlNc21VVGpSbG15TEox?=
 =?utf-8?B?dnpoa1hJZlZiRkhJakJWazgrNGVhempQemQzeUxoV01QN1l1UGFwcFY4ak1Z?=
 =?utf-8?B?VUhSdGJMUldnQ3hLRFRkVlFYSmNvMXBQK1FSSkliTnFqVEpidXZMN3RoTENK?=
 =?utf-8?B?NUljRytmUklwMkpKaDhMZEt2ZVFtZ1VtWGtLMm9FdERKeC9oL1FEa2dFaEk3?=
 =?utf-8?B?L0RXSFdOQmFZb3h3MElnZUVOdzZCdUNKM1JINWZLdVZsNUhCbndhbklhNEw5?=
 =?utf-8?B?Q25aaEV3UWRRTTlUcWFOWTkzbGp5S3dBQml4SmZIOGdjYXdPdUF5Y2Y2R2NN?=
 =?utf-8?B?dkRtWDA1U1dzdzc0VkNtMU80MU5yMWpPSnRVdDcvdlBScVdEWk9yS0ptZmhR?=
 =?utf-8?B?MHI3Mnk3L0ZnNGVxOHZReEtlcEcyMDAwWURNMStka1NGbHM0bDZMcVlHd0xG?=
 =?utf-8?B?WndpVjhheUpvS3B2d1huYVNvTUdZbFlleXRGakNRMHRER2k1TGRoYURyUHR6?=
 =?utf-8?B?S3EvWmN1YkFqblpQdHZNbFlCYkFSQ0FTdldpa0ZyN21iNVBHZTJIOTVLOTQx?=
 =?utf-8?B?M2JUeGp4UG9ubmZuVnJTblR1NmhCVjdIN1hXSE9obGJST2srL29xbkFKSkxz?=
 =?utf-8?B?Z3VlR3BIQWlxQ3JWb29SL2s5MzFQWnBpL3QyeHArbGZkd0VRYmpLQ1BBUjB6?=
 =?utf-8?B?dnJnYzBXTTgzMWJRdjhJbk5WakdSUHB3dUFhenZ3WjRXWmJMK3duTUs0VUM1?=
 =?utf-8?B?bzdaMEh4c013cEx4eG5BUUtTbmdFYnN5TDJvajNLekQyanVTSE56TWFDOStF?=
 =?utf-8?B?WmxyTkFxUktXZmhwMk1LbUFkaWlBT28vaitHSCtzT0NiWnNNalNmVkhwS01j?=
 =?utf-8?B?dWlWRks4a1ZaVGVrQ1FwaVNNd0gwaE5DWG9rUU1kZXRJbWgvZUVOdmZPK3Ru?=
 =?utf-8?B?c1NmbXNVV3hPK3UzaFR5bXpVODk0aXRsYXJQT3JpbDR3QkFpQUp0NGtweUVJ?=
 =?utf-8?B?aFZwYkJaQjY4MVVsNVhaMUNUbXdCQnZJcHF1aHJ3dy9vRXZ3bk5jNlJ5blUv?=
 =?utf-8?B?VWp4dUExWi9iT1BDSzNtWi9FT0U4QW1FOXk1ems4UEJuSVZWQkhCMmtDRDh3?=
 =?utf-8?B?RDk1OGFUeWZpdFF2RVlYaDNwd1cyVldlengxSDdCVm0rN01kMzJkQm9BU08y?=
 =?utf-8?B?VGZOeEpROUs4cTJ3YXdUYVE0cGVpd01KVzhJTTRsTWw4bk91ZHJicFFJRkJu?=
 =?utf-8?B?L204VkdzMXQ4dVFkTk52TVVLbktBZFFjWHVqVTg5c1NpbUduWGxTdENSOGlY?=
 =?utf-8?B?N2pUOGJjbGxLRG5UMkVxcEpFdlNpNUM0TWNVUU83VXJ6K20ybHB1eWlTREtu?=
 =?utf-8?B?OTdYSXZrSnVUUU1FdFlGMXpUMWk1NDVOY29GdjRxUkV2bWQrZzZLMjEwcE1D?=
 =?utf-8?B?RDlsbFhPK05rZEdSdTd6WGhKbzc5dUdlY1F4bEc2b2JGUGJsbWJVVElrd3pG?=
 =?utf-8?B?ckhvSFFGVkxJRUZ6YVlNQ21OYmovQVNOSERzVmhZckVHUDZqbVA5aWgyZkNE?=
 =?utf-8?B?NnFnV3hsQ0IvL09BUlJNU3FNQjdsVTVZb2IzMXBaeEptWEk1QTF1VlBZS3Ix?=
 =?utf-8?B?Y1V6NjNyQnBYQ1dlZnZLWXpuUjJoVHd2Y3hXNlhlNXl4YVlHKy9BQmdzS2gy?=
 =?utf-8?B?WmM0akw4R0hpTmJFNURiVS9zVnVMTllQN2V4NVBkY0pCSGJIaWN4Q3ZRWnlo?=
 =?utf-8?B?SDVYRlZSbjBYbGsrSlcxQ1JtRWx1VGlqTTMyYVU5T2JUb1N1OEdlZWN3K1Vq?=
 =?utf-8?B?QmVTWFh1ZlFDbXYzbVZVTHlGNWdsZWV3UHRHczJiLy9ZNEdwNXFZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7805fef-8d1f-4895-8f99-08deb4ebfdc0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:44:40.2927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oLC0rcpEzBntQhAXY5XDADRIxl2unf3cqcfL6OLXMZeeXQw4SjS02gwm8vxpn4w94IhZvlmmJbRf0fFNlBSmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

Sent again since one of the patches got missing in the email.
Regards
Sunil Khatri

On 18-05-2026 08:04 pm, Sunil Khatri wrote:
> v3: Add two more patches
>
> Sunil Khatri (8):
>    drm/amdgpu/userq: Fix doorbell cleanup on queue creation fail
>    drm/amdgpu/userq: Fix the mutex_init cleanup for fence_drv_lock
>    drm/amdgpu: simplify return value in amdgpu_userq_get_doorbell_index
>    drm/amdgpu/userq: dont override return value of xa_alloc
>    drm/amdgpu/userq: clean up wptr_obj along with mqd_destroy
>    drm/amdgpu/userq: add amdgpu_bo_unpin when amdgpu_ttm_alloc_gart fails
>    drm/amdgpu/userq: reserve root bo without interruption
>    drm/amdgpu/userq: make sure queue is valid in the hang_detect_work
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 49 +++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 --
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  4 +-
>   3 files changed, 32 insertions(+), 24 deletions(-)
>
