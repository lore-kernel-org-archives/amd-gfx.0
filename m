Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772D0CA9ED0
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 10:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EA410E584;
	Mon, 12 Oct 2026 10:09:59 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6691E10EFA4
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 10:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZYx2gG5Jo5ZZN9NA+cuRBFuv26gsWBDHVp5lYmZR9o9JYJD0YU0JiGpHav9FIL4KSPR2nXtQSdupjyTMTztt/nf8S5yu6DTP+IGGHkbh3wvsRWSqQWns39XQrWh11qWiN/rNN3u56cLEf8e3lF9v8Nq0MowZG6DCOO3ZG1O2YBDOBWlNQRDtzAXLf0+pJQdvmv55KmdsRm6BMwRlGypVWY0wgWMGB19wri1PrqhqtUuvNg0yBdsmh3665OS7uwxTOQq6TjDD0vVRvlHM1Gj/LkSkM0484hLnJk5hHdemqLNO1VqpoMkjSylgD0PmEoSVjmdyAxew6xb0nGbePHKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkJeytG+NXyKyxq+ygnTPdvdvA+CDY6BIXzFoSoNNWE=;
 b=jNFtDkt7qiqyuLOo1wlmBEVJ6vJY98yRIhoj3j69hMnQnmYd16Ylcl7yDK0nj54ksr2iezddkzZ4PUXmu6+GJ/Wy1tj4zVV9eeibzZOa5UeCL08asNruwa/Qd+UaekBNySMag0CAL832aCGjlyNq0WBQ5p90UJ4v9Gs48kya6t4TcHv+x6vi+oDzwpiXNmY9aPuo3j6NVIxsUiV5faWjOiZKH7BOQNSdVPMOy7lJSi7h1MRGvRhmUaaWmX1/Arfr+EZYbF0Zy36Zrh9zJ3kpyUIZkIreFozuz3WYW4ujFMJkXzEcMW7DL/8IOJAFYOPlWq1a/FR2029zAn1PvfCkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkJeytG+NXyKyxq+ygnTPdvdvA+CDY6BIXzFoSoNNWE=;
 b=4tF63fxwwIGcXC4tEwbMKXNnVMfkilENImkgSGkwXqZrzYPTXZsQvPN83AKvzlG1+wNsBNQfve/Bzd1izRREmZbZmWjTfuvNqmTgr/v37AiWtfnTzY8o0t9NZ5lchQvL+8TFr7aXJk6cbbPtltZmIifKBTf0suyVvJOB6rlztiY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:09:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 10:09:50 +0000
Message-ID: <3f8ff169-6a69-47f8-a289-e6e2239bf8cb@amd.com>
Date: Mon, 12 Oct 2026 12:09:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: reject unknown GEM_METADATA ops
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
 <20261012094754.1685828-4-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012094754.1685828-4-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: efc52b5d-30ca-4611-049a-08df2848f417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|261009223027099003|261009221227099003|10067099003;
X-Microsoft-Antispam-Message-Info: /KGicVtuLVmSwbw2PjP0SI0VWWHztw9zIyizbzciwSA30mf0b+ADwGcvT4CvQFYvOgoZqvyTVwnvigJGan0N7LJeocscPbqkzRmi1D9oCvRUxcSTz1hoLi861vANNdfZEXeZjbpigzEMK3SOi/xueuyFLJNxFwcFzqLwW7LoaZYk1SMNyY5SwIn5PcrTaGScDOUeJeLK5V3okSQUsqtkdBPTJ+Si2c/ifQwJHruGJqoejM13uH2ksvYNtcacmn0zqcKYopeApqJkv2PsXy+O2HMQ+cXxi5Hw25uMH1ro6eQh0d7Nw6285r5IKVh+P4RSU2rIAloAKT7xiTbyjLohEX4FWkCg6AZffx6LnHoDBnqAJzAsTCrx2EpYyfe15IfEYzbDYVznMbdx3/cV3hszwTlWdu8eMcCvBbIKB8OssAMzYMZMpfzdO+N94rphFfujl7OrJ46eYiBzjHz8qkdz0qgrJg/d+ZsNn6Yfq8Sz1YIz4tSzh/TBtwBIGWYQPzLCDaJgr/KyaI5xX+229dHoO7vnjnXsJ6CFOjx3Koy5u2SMokhlB0IBQzMCnGLhFJVEQVOmk324rNHSxP60VltJLg5yfXC1bX79uflfE5PivRmti3hQFBFtw6i2E6k6EXerXIdc9ujVopF0ioiPcvYxyGVJK0s55L9rzJiRtaZFZCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(261009221227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpYY2d2MGlSN3F2eWNNVDl6SDVKbzFRT0VKaWZiczdkTG82eTVVSU5HNTBF?=
 =?utf-8?B?MTBKRzllUitRZmJWenROeHloUFZPWmJUTFBzbHpmSE1OeUptZy9VditrdDU3?=
 =?utf-8?B?Y0hNWU51WUFoY2NiRzNTdTRIbDkxOWo4TXZPSnZhRjFKRG9BcFViT3c4dENa?=
 =?utf-8?B?b2w2VEZXUHNvL01DVklVbGdRbzcrdFgvVE0rRXpvVU05aU5CdnZoU0RyZHQ0?=
 =?utf-8?B?NGs0OEZpVUJqeUpjRTdOR0JPLy9SVDZGUS9mQ3JqYStsc1RKVDRXaHdGT3lw?=
 =?utf-8?B?dHppeFg4SlkwS1ZvNmR1SEpYY0JrL3NlcW5Sd2VCYUE3ZUt4RFdOTWhPS08w?=
 =?utf-8?B?VFlCTEZISm40Z2Nqcm1ReElUTm5SSlNlTC9ka0JBTkZoOU8xSityQ05rTGto?=
 =?utf-8?B?anRXdnArZUhlV0NzYmlza2UyaXR6S1Z4WHRxTThnR0ZOaHh3b016TmFnbEZk?=
 =?utf-8?B?eFM2RW8wdFdnNVE5angySWtiWTBFRlFwRytvRHVSc0hGZXFyMmxyMnJKK25s?=
 =?utf-8?B?THFvMnlHTy8vYjdBVWVjd0ZUZ0xnY25PWTExQlUzUDhzSEdhd2h2Z1ZNVElM?=
 =?utf-8?B?dko5dEZJMkwrREdFdi9lelNCWkJHVVp5OTRrUkptaUQ5RElhUXUrUTJtdXg0?=
 =?utf-8?B?d1lqUFFSb1h4VkRrcCt3U0tVcXVBdE51RmR4T2MwT1VJdVVLdDY4MnlmbU4w?=
 =?utf-8?B?a2xqWlNZR0RuSVFzZllZeU56VnQzeVBQODZuMjEwVlZXSWc1aE0yVTViMVZX?=
 =?utf-8?B?THQybmtxdC9uUDJla0FNNW5tZDhEMU1HTjhpemZia3lLQWNiVGRGUVNzbnFC?=
 =?utf-8?B?UGlOM2lYQzFPb2tBUzdsVTFES0tkRm9kcldIaytGM21LV096WnRZZ0o3VzZY?=
 =?utf-8?B?UGd0T0FQUW1Zc2xJMXhXdVo4alJIQkJtV2xxUG9TY1lxZDVrcmlHZDdMdVJQ?=
 =?utf-8?B?M1FhMCs5UXRQbzlsTTJkZG9Zdk4zS2dmY09XdFlaVWNteVVtUmpxWDVab2gy?=
 =?utf-8?B?K0JweGtzdmJubm5VRTdxSDQ3UXRYbTA3di9zd1FkWURZdEhndUhHYmVzOFRH?=
 =?utf-8?B?MW83ZUd0bHV2T1hoY3RFOTNqWkZzcjA2aU5nTmZvYVdYRE1SYXc2UjVVYVN4?=
 =?utf-8?B?TCtkN0ZnZEdvcjgyRllCQ04xVHlaeVVMZWIzYXNWRkJtcCtFUUgzbWI4bHh6?=
 =?utf-8?B?eXlQV0svbEtrYWxsNDBsaHVEUjBHTFNHMmpyOTNkK2w0dHFlRnRJY3ZFeTdE?=
 =?utf-8?B?Z3RqOU1FRElseGlvWG1ZSVJrc2dMYWw3WTVXZ0hxaklsVklCQk5vVm1QUmhY?=
 =?utf-8?B?QmRQejhYanp2eTJWVzF5cXhWOU5uS2g3bytVblhJSGxuVVhvd00yZi9yUjND?=
 =?utf-8?B?R3ZlanYyWkhOY0VKTklUNS8wOXlTNXRGa1dJU1c4Z20vSSs3VkoxWG5IS2NT?=
 =?utf-8?B?OWoySkNUWXNlWG83bzBaOEhaZG9TNlA3bVRneUg2VzF6d1JOQmRTaS9NVWF4?=
 =?utf-8?B?TTJqQUFIZXg5SllHNzVSWGxtZ0l0elhPU3Y4eUhSRjlmM0RQRENWYWxpdnho?=
 =?utf-8?B?YXByTE9ETHVkRWRiQnMrK2ZVVDNLek1IZHhmVWd6YTZRcVdCQnplVFdnblFU?=
 =?utf-8?B?ODZ5TkFPb2xJT0ZBRlFuVEVHaDJLL3BYb2czSDlqa2FOYnE3YU4vVzBBTC9n?=
 =?utf-8?B?eENXWCswZWlVeGQ0cFBhMmd0TXI3R2JoUjRZVUp5Y1lSUTF5bjFaNFFSSGtj?=
 =?utf-8?B?VW1LTjc0VVY2c0ZBM3FyTFNZcjl2SGtSRkRNUWJnbm0zM3Nab25EcDUvTmNC?=
 =?utf-8?B?WFNLWUVZUVlkL2JJS0Ryc2ZSVTUwdUNlVFZRdU5lN3VJNlA4MnZoRTQ2OGt5?=
 =?utf-8?B?RlM5SlNQb29DWmNkWExSbHZ4ZHVPY2MrQmFoSTQvUGUzWmlJaDhnUVdWYzJQ?=
 =?utf-8?B?TE45aUtYUmN3eFg2MUtIQjJjc0hrQ0ZrSFpvb05KRjBneDJEZTloOGpET0tt?=
 =?utf-8?B?dEFoR1o0T0RadUpaSzY3VHluMStWTW85eHZWb3YvRkt2dVBlVWhKc2NuS0pK?=
 =?utf-8?B?WWh3N2VYY0VtNTJWVG5sa1ZzYTEwRkJTQkxEUjNQNnh2V3hqR3JLMFdmRTJj?=
 =?utf-8?B?SDRqMVVOWklwRnJSMnhQWWpZTzNIb3lLWmZndVhTUC9DVjlKT0NIU0F0dTN5?=
 =?utf-8?B?cVUvYjA2ZGEvbzJUODgxWVlEb1dDdUxQNzIvc0MwaUFXZFRrZStBbGEzUTU0?=
 =?utf-8?B?OGczeUJ0dElyZmg5c05GKzFmT3AzaHo1Z3lHekpTM2VWakNhSzBWaHZPZWp2?=
 =?utf-8?Q?hOtF7okVcSVOMM5R6W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc52b5d-30ca-4611-049a-08df2848f417
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:09:50.9454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRMC1x019aDJ67pfUAAGcEd1dL7D0nb6AzVIMh+dAb/Cd/uRgbOUjg0W60h2eLov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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



On 10/12/26 11:47, Jesse Zhang wrote:
> amdgpu_gem_metadata_ioctl() handles AMDGPU_GEM_METADATA_OP_GET_METADATA
> and AMDGPU_GEM_METADATA_OP_SET_METADATA and returns r otherwise, which
> is 0 from the successful amdgpu_bo_reserve(). Any other op therefore
> succeeds without doing anything.
> 
> Return -EINVAL for unknown ops.
> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0552b17d9aa8..012daaefa315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -780,6 +780,8 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  			r = amdgpu_bo_set_metadata(robj, args->data.data,
>  						   args->data.data_size_bytes,
>  						   args->data.flags);
> +	} else {
> +		r = -EINVAL;
>  	}

We should probably switch the if/else if/else into a switch case, but apart from that looks reasonable to me.

Regards,
Christian.

>  
>  unreserve:

