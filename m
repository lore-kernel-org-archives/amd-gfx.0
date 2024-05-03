Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E216C10F16
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 06:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84E910F073;
	Fri,  3 May 2024 06:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lr+REclv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8C411284A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 06:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l22XtsfI4aYNqcWB+MGF1ouFv3DdlCMdK63MI93olGfLooUkk0p7SkWpALmBOEiczpcV5V7Ooq0wmr/XH1RzgBWx24034rNgJBrNxs9EPm6Jf6T/zOunKt7vtw/CekeDRS03o/zOGVXJEDXBAGuJ3C6za3zw0r1SRF5Y3owMFyLqvb9wkNVM/vEuGk33AjBYMmk5vMMVS2bvYW9pt4aTFurs/HIe1WijtRThhP8W1mFhN0TXcJrpYdTwXycEuqnxpP22ABX8PH+Rep4ELxInPGG48MwVHzCzejGndkrz7K9p6Wu2ulETX2/FY5B2UhNxAFB8ouCDbZalVyDWJjvj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYRq4XIsKnPDVR/EVAsr5R+Q9LWr8i8M9s+oNzXtoJg=;
 b=L+dU05SuIcmSSYXbSKP3ynzA19HxS/kncMGCYPWl4BxG/BaTx4oDcYoP5rnGTaoCiAE5RlHt01DaAi58wvghIBxyhiuD5HykKp4F7auDkE0RbGP3XB/41IV7oo0bgETDhOBt+RFJr74Xxv0zqwHbR4mHHRuqR7WyjTC5i75tS9h82c3nJiv5rmZa5+etDk+6V6KtzYqBbc1LAm0oedeSNh5HTPbtcyiP6hD1qhV+Q685hYG3IfQNIqeRjlg9IiR+BgnVSX/6Hw2dLgopf7eCL0iGquOiJLMypALtoguY4hxi2YDEwmyNCTVPeZkslGiBCOFoaszAmnc6bJaVYOS2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYRq4XIsKnPDVR/EVAsr5R+Q9LWr8i8M9s+oNzXtoJg=;
 b=Lr+REclvQkjA+BOQ6RoClsFKcOQ7h+Em4uecstvgfYQifR66e2SVsKkfl9f0Thebytdn2bE/ifDQ461OQQXKFXGoOXEMxqglHhlNgW3b+BEjaQoCpOjOdOWUxi4bZrKHUcquUKJwnijohql3Oki42QyPivn8aDmovVX6+vzaPCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 06:52:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:52:22 +0000
Message-ID: <a6529de0-d241-4fa5-81ab-a88330b53f17@amd.com>
Date: Fri, 3 May 2024 08:52:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/14] drm/amdgpu: enable compute/gfx usermode queue
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
 <20240502163152.1382-14-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240502163152.1382-14-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b14e0f1-382d-4f97-2e9b-08dc6b3d9554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2UzOWFXVEpHS2xHSzM0dnE4a05mZmQ3U3N5SkV1SGw0MGtNZUtRaTJZcVpG?=
 =?utf-8?B?TkdLT2FIZE5yZ3hsN25JWHpRUU5vOGIxK3paWlVwdW9ZRGdIY3RoL2xCUk9H?=
 =?utf-8?B?RlVaNmFPZ2daeHJqRHhpVUw0dUpyb2J2cjBVbkp2T3VnU2o1MmhpRTBrVUxm?=
 =?utf-8?B?dHlvbm1UT09PZW5SeU16eWxObzR1MDBjTmE3L29vSTMxNGxQUzBpSHJlYTVi?=
 =?utf-8?B?SHF6ZTVmUXo5Z2daNi9aU0dyUnVaQ3NML1Bna1RVQ0cyUGE1SGxmejh2TzZO?=
 =?utf-8?B?NmJGVXNCYUVSdEt6cDdteG0vVGVNYzZvTS9xVEs5dmRnejlmVTI0YjB5N2hC?=
 =?utf-8?B?d05hVTgvTmFSWWtsSXhITlJEL3pRd3JtNy9ST3hjbnNGWXV6Qm9oMEVUY2N2?=
 =?utf-8?B?ZG9sMndZMGlWaGxtTjVpaFRHa2NZRWVQLzFHR0FMOUNNNWl6ZFlOMEMvSFpM?=
 =?utf-8?B?MzQwNlJRcGh5S2JkMmIwb2FzUkRFRy9CRGFFTUMwZGhjM2ZSSk9uS0JSL1Fo?=
 =?utf-8?B?amhtWXF4OStIZERxRWE3M3RnZHhjbkFsYXl5eW54SkhFcXFWV0JkVFl1WHhX?=
 =?utf-8?B?WTNZdTUvMmkraitSSkFQS0FwczdWdVhkU2ZEbnhUT1NPNU1wUjVUMVNLL285?=
 =?utf-8?B?MkVOWXcxSkh0T3NZV1NDYXhwTzBRNktRSmdXNTlSUGNiQkF3eGJKakZTL0Q0?=
 =?utf-8?B?T3A5dWJSOWpKWWlLYk1vMjV2dTZLdjZncFFxUk5Qd1VCS1VFT3RlaGNFS1J3?=
 =?utf-8?B?aURkWnhnUWZIZEJFRHFyT3VUWHFQYWIyN0FFSDVIaDA2cHRGaFlBV1Z3Vnhr?=
 =?utf-8?B?TzZpbGdnSWR3czUzenZiRnViQ3dlSDNRdHY2blU2WEI5OFZIdm5rTFVZem8w?=
 =?utf-8?B?RW9XQ3pjeWkzQVBoNktPay9VYkdQRUV3cEpLL1h0eTJxZkk3VTBueWJlK1pE?=
 =?utf-8?B?TWN6ZExVdXBKKzNoQkM4RzRSWWhnczBYa1BTdFVUY1FUY3ViYWM2c3Q4SERQ?=
 =?utf-8?B?b04zN1FQUmZNZWNkUWo2N1h0UFhrbUxVdHdGOUIzSmZ2eUFaK1JiRFNZY2pH?=
 =?utf-8?B?d2kxdzFqOVBtRk5KaHdhbGpFL3l4OE85TFZJUHd0dkdxakt3MGcrUE5OSEMy?=
 =?utf-8?B?TXBiUFBqZ2dxVUlHZFpiZXNxdFVyL1N1aXZJNXpONXlyMS9DVEZ4aVFXbWFt?=
 =?utf-8?B?dCtTUUkrT3E5Y3VwY1BudytMR0Yra09kOHlEUFRVemxHa0Nldm9GWjI3UElJ?=
 =?utf-8?B?alJWRkZjcFo5UXdtTUF4c21XTHZheENjN081N0ZSTjRlZ0dKK1o0VEFzbTBB?=
 =?utf-8?B?VU9Pc1E4WGF1amdzTmhMMmxDeExRblVDeVhKazNieVIxR05lVU5wY0xKanhO?=
 =?utf-8?B?bXFOeWJzSGtEOEoxMmJIV21RUGJPVlk0QlBETXVJaG9wQXh4QmthR1RaL2hE?=
 =?utf-8?B?d29McmJCZzUyMHVmV2E5cDZLYlpCczl6QWQ5SURwOUtRWTlWS0VWaTZPQVJN?=
 =?utf-8?B?SUZwV3VkTTdUd1NxNTgxTVdqMXAzbXU1SjRhTWQydExpSnVjeXRjeE9yWjVt?=
 =?utf-8?B?QjZvZVlTWFdFNnVFRXp1WjV6UGM0WDc4Y2JYYVg3em1EQkx3emc0dkJLSjBv?=
 =?utf-8?B?bHYreXdicE1vTlhBdGZXL2tKa0o4U3FPVlI4TzUwTFUwNnk5MkM3S08rc09S?=
 =?utf-8?B?Yy9STHJBWDV1M3Y0am94MXVyVElmSUkxQ3UraW1sQmxtb0FzWC8vZHBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytoaTV1TjJydHQ1Ym5iOGN0V1RYcE5oYko4MTlnbFlUUjAxYlZRQ0JMUG5I?=
 =?utf-8?B?QmdFUFpqL2lTQTIxMTBqNmRiaXRGc003SWhvSTc0UkU1S2s2RlBWYWVwNmc4?=
 =?utf-8?B?aDQxYjNsYjIyTlorTkIzakFuY0lhR2lXMzZHRCtreFVYRi9jeGd4UUlNREhr?=
 =?utf-8?B?NzAzbmplQUtqbHlMQlU0ZnptMStWcFJNRW43SmRSYllrLzl6VzVTVkZGaGUz?=
 =?utf-8?B?d3U5d3REdXp4cThLelQ4eVZtOXZrdHNTQjJYcWxmbmdzN3AzaHJZQlI2TmtO?=
 =?utf-8?B?V29FZzFUWi9Dc3BKbHJzS3FXNjNnZkRzKzN2d3F6WXZ3Z2VJZ0dxdTRwWDE1?=
 =?utf-8?B?bnRZR2Q5K1BQMjUrNVNTaG5WeStXRCtsRjhjOEszR3R5Z1ZKODZmbVNuWWEy?=
 =?utf-8?B?TVk0enYrcjdoalk2U21FM2wrS25IQkgyVE9ZZnF4YjZ2SVlLZmMxV2pFS2p4?=
 =?utf-8?B?UnNjUEVXSU5tNHBvR1hwVUltbWlnV3hXSlFHSk54SmdmKzJySFQ3RmNtaktO?=
 =?utf-8?B?R0dvcXE2b1g4NUxMclpCYW5yWWVLS3o2dWFielloMlUzdmRBSGljNGZGTzV4?=
 =?utf-8?B?MG5Peml1a0xWUVpOVGJnSUNORllKWU1kMjVabG1hVkNndmFCdTBoTzdBMloy?=
 =?utf-8?B?dWVISG5mdkdXb0N1Vit1bjBtVWZOaUd5UGhWUDNSaC9sMkNpSTRNRXk2REg5?=
 =?utf-8?B?QkZIb29ySmszYkxVU1JMRWV2Rm1SMmx1ZXhvSVpxaXBrUzVxa3MwVTNVQVNH?=
 =?utf-8?B?Q3UrRVF0Qm9tRlVwb2VPTUllMjJHbTl6azBNTmFHajJ3TXRPSXlReVAyOEZp?=
 =?utf-8?B?d0lLTEpMZDN5dHZUR1Z6bWdLcElVVmJqdUhyWWpnT1FHRkM2WnhpUlYxM3k1?=
 =?utf-8?B?RjNxUEJlaUI4RHRseDBJS3JKU1NjbmxLL1kxRWF1OHNuZlludFJhazFWM0ts?=
 =?utf-8?B?QnhhR1hYSm5YZ29aaTU1bXhKRWdTeHpVVThsRzZ4TTJiN0pUSDB1d0R5ckxl?=
 =?utf-8?B?czFkV1ZUQ2o0eWVhZnBtWHp2dFpYWWlaT29jUHRNTGVwOW5VYVNwY3hreTlX?=
 =?utf-8?B?TVYybnVpVkJPSjh1REl0QnNHYUNBdG5mb2tYSituYzRLU2E0TkdNUmJUU2RX?=
 =?utf-8?B?d0ozQlJzTzVFRWs4MjVzS3FTRmoxR3NBUDdFdjlmcmpKTE03K25sMGd5VTMr?=
 =?utf-8?B?WWRLV1hXRDdxWkI4dThmVEt0M20ySHoxUW5ybithUG95QzVyT0tlK0RjcWdS?=
 =?utf-8?B?SnY1aWQ2bUN0cEJZaW9xcXRmUWpJQ1pyTUFFMjhnS3ByZ2NUUkhLRklqNFN2?=
 =?utf-8?B?SkVaVXA0bCtyN2lTTTZyVlgvbUVpMG9YSGUrNy94aS9pZnU4dXl6b0NjTW9S?=
 =?utf-8?B?Z2c2Q0ZWam1uTlBXWHIzd2MyWmwyQkxmSnhqRDJWTm80TDBTY3BOTDUrd25D?=
 =?utf-8?B?SnRKd3BMWnZ2cnFHMFcwSFN3ZE9HdjRQeXJCd1NFT28wSVVNcitVajQyUVF0?=
 =?utf-8?B?ZW44QkN6MDlFQjVCeUgvRTVpb0ZTTWF2K2NTU25MVTdqdi9rNHA3bGRQbThv?=
 =?utf-8?B?NVYvbmZaaVVnTWpYOHNWSGg5ZmhXTEE3OXplekIvbHYyY3ljVHFxNXMxZC9Y?=
 =?utf-8?B?VTE2OE9hbllTN0ZMZTBmMDRKcGs2ajBlK2tiNnMrc3FBNGdndllSY0kwRzJB?=
 =?utf-8?B?MnM5QzdLeVNEY29IWm1EUDNTUUZjcHN1b2NKeUxOb2dkZmlYQ2JTdE16MkRi?=
 =?utf-8?B?V1h4T3NmWkg5ZHRvbHVDemo4MHdrdkFTZmYyZ3BuUkp0SmZRdVJ3QWpBTlpa?=
 =?utf-8?B?d0Z4S2xPbVZ2bHpsdUtwYXU2a2ZBYTZVZ2lHUTBZY2EvLy9NbTNJVy9XdkhG?=
 =?utf-8?B?NlhWMXYvSktKekVRUVVXNzR0Z01vUGZjZHMrS01ERFdxcW4rbkszUHFUMU9i?=
 =?utf-8?B?VEExY29uUThqdGp0YmdJRy92OW43cmlWT1RTNnN2R3FVbE1pdnBtS0ViL0FI?=
 =?utf-8?B?cnlOYnF2YkJnWklGcjB6Sy9HTStUTGRTdk13SVFnZmtkUTRIRTgyNHZlTGxv?=
 =?utf-8?B?WnE4cU45eW9Rb2RhUWNkNnF0R1oyR1dPL1JQWW9uK0VGS0FNM1dyWkdCZ3hH?=
 =?utf-8?Q?x+fzrQhI7zyGQhgAeRb3laMha?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b14e0f1-382d-4f97-2e9b-08dc6b3d9554
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:52:22.4501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNdCEEsCZZk4COsFjLo5rZ7jSiUN83z2wLv2loWbCFcpSsWVUGGVGUu73FPMDBLD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

Am 02.05.24 um 18:31 schrieb Shashank Sharma:
> This patch does the necessary changes required to
> enable compute workload support using the existing
> usermode queues infrastructure.
>
> V9:  Patch introduced
> V10: Add custom IP specific mqd strcuture for compute (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  2 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 15 +++++++++++++++
>   include/uapi/drm/amdgpu_drm.h                    | 10 ++++++++++
>   4 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index f7ece0b31ff9..84bce9434102 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -189,7 +189,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	int qid, r = 0;
>   
>   	/* Usermode queues are only supported for GFX/SDMA engines as of now */
> -	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
> +	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA
> +			&& args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
>   		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 888edc2b4769..46304d09c4bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1349,6 +1349,7 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
>   		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
> +		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
>   		break;
>   	case IP_VERSION(11, 0, 1):
>   	case IP_VERSION(11, 0, 4):
> @@ -1361,6 +1362,7 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
>   		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
> +		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
>   		break;
>   	default:
>   		adev->gfx.me.num_me = 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index 80375894c4f3..2ae6f720dc66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -260,6 +260,21 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   	userq_props->use_doorbell = true;
>   	userq_props->doorbell_index = queue->doorbell_index;
>   
> +	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
> +		struct drm_amdgpu_userq_mqd_compute_gfx_v11 *compute_mqd;
> +
> +		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
> +			DRM_ERROR("Invalid compute IP MQD size\n");
> +			goto free_mqd_user;
> +		}
> +		compute_mqd = (struct drm_amdgpu_userq_mqd_compute_gfx_v11 *)mqd_user->mqd;
> +
> +		userq_props->eop_gpu_addr = compute_mqd->eop_va;
> +		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> +		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> +		userq_props->hqd_active = false;
> +	}
> +
>   	queue->userq_prop = userq_props;
>   
>   	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 6798139036a1..7ffa9ee885e6 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -429,6 +429,16 @@ struct drm_amdgpu_userq_mqd_gfx_v11 {
>   	__u64   csa_va;
>   };
>   
> +/* GFX V11 Compute IP specific MQD parameters */
> +struct drm_amdgpu_userq_mqd_compute_gfx_v11 {
> +	/**
> +	 * @eop_va: Virtual address of the GPU memory to hold the EOP buffer.
> +	 * This must be a from a separate GPU object, and must be at least 1 page
> +	 * sized.
> +	 */
> +	__u64   eop_va;
> +};
> +
>   /* vm ioctl */
>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2

