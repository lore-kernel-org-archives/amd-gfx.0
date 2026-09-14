Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878E4C88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 10:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E931410E81F;
	Mon, 14 Sep 2026 10:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DnVNYu0k";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E7510E81F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 10:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX2lfY7Qgm6Y8AWOiNRdsCFsscVeCn6te058OLDF9o1kLq3EX8DRV6iWf5gkxZ9lIUcTblAV19tw/QDmUlofUMKMsMNqm39DRwbQlF2bsc+QFVMJPQD1eN0SGWfbd0Y6JIFAAB/ZVZOg2Z0Ynu1iDTIGKoSU2UYMoURFulxNTAQqFSbsDVMVf1x3DcuAoDpLze02jTQ7IO4O5tV5ePmvOSSS5eT0OWr6SREwKF3u4rOooRN3+rFmGXp6ExyXGdJZeb1MHmXPaGSmqiGXX7n9zbrFIOfhAsGGEld4R2s1O0DD9cimdi34zeqJnFO5EfcRGARCgV2QcWPLJDo0TST2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idcYb1bEO4SCgYGUsDCWJPLMUwxw0YFBV9zXr6rbEYc=;
 b=Wu7rXNgov7sY38E8sULeDWbIpLeoM3JWYZMBMKyebo1S7FMOtj7DLh6Hn6jXZ8bHQXNvd2MldheWg9bKxNhJD2cZTM6usO4gie9LPHslx85VlF3o3R/cj8wBnEVGb0Z9ojpfEblZZlYNjoMu/jE+1wGVeUVr3zQN806mendSN4sPa/h7UI/XhAoKDQe+IqJ0S1pxccNDFzHOh3sLmevsxdrbMxNE0+wXs6N/TU89gGncWSQJvM3jzp/ZqmypmmTworMbQPGp1+BbKnhuDBa7rdbRsQh+6jzx6BxjPKXufPzb+Xeq5ouB8F5vHd2XFkXcKl/6RdIUhwl6w4C7S4hWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idcYb1bEO4SCgYGUsDCWJPLMUwxw0YFBV9zXr6rbEYc=;
 b=DnVNYu0kOrpMlv7oAeXlVkfHvHPUL12i0GFhNNqejEHe5GFZQvPm8s7RZD9Pk/1fODSuN7LveDOmhW2ZszRAdDlXSFZSoOeYrSOi7gGn4NoHb/G2NPwLz4F0aAkikk535XPYFBZtoGuS/qJWgQHa4/oM8crZlQRf1KOjxZtAD1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:25:17 +0000
Received: from DS0PR12MB7747.namprd12.prod.outlook.com
 ([fe80::2ef2:e88:4708:b589]) by DS0PR12MB7747.namprd12.prod.outlook.com
 ([fe80::2ef2:e88:4708:b589%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:25:16 +0000
Message-ID: <69ea21f6-f2d4-492b-bb65-efc34167871e@amd.com>
Date: Mon, 14 Sep 2026 18:25:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/isp: don't fail suspend/resume when hw
 callbacks are absent
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Pratap Nirujogi <pratap.nirujogi@amd.com>, 
 Gjorgji Rosikopulos <grosikop@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20260910071526.419494-1-Jiqian.Chen@amd.com>
Content-Language: en-US
From: Bin Du <Bin.Du@amd.com>
In-Reply-To: <20260910071526.419494-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To DS0PR12MB7747.namprd12.prod.outlook.com
 (2603:10b6:8:138::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7747:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 702d88dc-59ef-44ec-86d9-08df124a77fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rqMDzLC8+yiyuw7w3FZAQu3ANqh4MpI5Bq57T5JkyomI30TPCtwUglkcQPQTwXeXhW151RFXUMv201UELiv7ZTF8KwqO80Njwg0xAKn6XMX76yzaS/1MZZg4utEzo6LQJv+I1vi4l+qpyu9TyAqWZA8KNCt7h+u/MgPSgSwUb6ePA0n94omJXlB2stMu48npxgnl/qlFUaF/xP7bhJVackuxqJmNywmNHuDHFxKGqnv/yRGwoEKZ4wY3pK9sYn3arWnGuCd5nCptqIV0HZQ2rYuXB1gjJnL/qbdevfiVsL5ZKo5Z2UBzuOjihMLrRqm58iLFKjXqpV6MHuaT1Ijn9GLNIHagUQ+es7SWZK49ZrunCiYpS/geC7bWKof6PCVEDgHjOZ2e2sA3CA/CvxGkQuOeSBQMNxBYDkfYtH/WA0axqEmFXhF4+23Hrzvacc1Y2wvEEuyOnShYS4gXi28DRq3JOStHSlUosqNgN34UdAMaMxqJLi3oTSkFj0RB6XXrrUt9YHzN76/L+UbFLCtlq+XzWg1Fj5h1PnNtFzW8NoYdfXsUW01EDGDl9Bj+Od7NswiTzA1w+MyXntK+DYXyWEDnJkRH2yj3wHQDyI6oluvUgtWcI00rJSrN2fzi5pB1shqIF6zPoQ1z+VwaGWtIXRH6x3odHv7Pv0TmB/SlIVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7747.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1Nd3FkdU5rM2JCKy9sZk9mZ2dlSEVwL2JacW1FT0JPY1NUWlAyWVhiQUxL?=
 =?utf-8?B?Znl3cVVPRGJIVUdqektEYTVOQitDbEQ1NDJ4Z3kxVERLYUV4QUkwSHVQUFIr?=
 =?utf-8?B?TzM1ZXVFeTM5ZkJjK2ZXcktSZW1MQVhmd0hRYWJGVU9WTUVUeVRYdVZ6NG1D?=
 =?utf-8?B?U2wvYnRlR212aFRWb2xFL1FhSExUbkFDZUMrT1cyUVZubUJBd1FDSmwra25J?=
 =?utf-8?B?VGlYdzJhOTV4M1J4NTRvT1pwdmlPMnB1R3JTVnB2NXpOU295ZXNDalVjcFhz?=
 =?utf-8?B?NG1zRmRZWi9EKzVRNDk0QjlUMmNyOEk1Tjg0S3ZMcjNMR1lQNlVQbkZHOG41?=
 =?utf-8?B?OGxnK3NtUFI3VGFtdSt1ODRHbVo1SjMrdXl2VGl5UWMzZkU2akxTTENzamUy?=
 =?utf-8?B?NVc5NFdQeEZ5VUIrS3k0QXV6bm9QVUZLNS9uQmkwRzBzbC92d3FhV0VUSzdo?=
 =?utf-8?B?VUJva1pYY3JvMkJ1Z2VONDJyNXZhVHRwaHAzdmtQcklMQzhIaWdwK1FDRHRU?=
 =?utf-8?B?OUZ5ZVpDcHdMWmg1WmRNc1JhckV2bzV2anpFNldRQlNlLzFZc0YwYzh3ZDJ1?=
 =?utf-8?B?UGFPRzM1c2p5YWNZd1UyWGw0dVpmZzI1VGxEeTlRUWJLa2c5bkcwMURpYnN1?=
 =?utf-8?B?amt0VGcxL21iN0t6TUY2MlF4YVJJOXo4M1g1NW1PMlR2TjhSSW0zYmQzaWUy?=
 =?utf-8?B?N21Da0ZDNW03VHFtUHJPdDBMSGwrUTVJWnFqcG9FNFBNejgrTXFwWUJFTUlM?=
 =?utf-8?B?ckNkZWNvR25ucXNNT2UxRVIzd1JpYjMwZG5pZmZ3OUZ5eHZlS2pWa3RmM0F0?=
 =?utf-8?B?c2JiUUpHSzdYL2I2U3NUZnNxdnZSZW90VHFIZkIvUGxFUXJIMHV0KzY1Uk8v?=
 =?utf-8?B?emwwQkxsU2FvbGVlcGRsai8rVzdZUFgxdWRoeHBMdGZyZjJVb2xiODJ6eVQv?=
 =?utf-8?B?SXk0YmxLTTJteTZaMCtvTUhCYmJVNVV3R1lCTGI2TDBXT0lQZEthSFozUHpn?=
 =?utf-8?B?WmdabEU1VjBaVjM0bXliWGc1R0lGK2dic0dqM1BWNVRLL3ArOFRKaSs1b3FH?=
 =?utf-8?B?NFI1ZS9XS3dpYzFGVDJsTGhKenhpY29DQ1RVUEhFOWUyYWlKcGd3OUtiUndt?=
 =?utf-8?B?VllrWlFQQWpWWUZ3OW0zaEpQZlZhVWNMY1BVeHpoM3g4U1g0d3JYZk1PYUVs?=
 =?utf-8?B?aVljVm1SSFg2cXllVy9DVW9rTjVZWmMzdWNYeG9COTVIZ2h3bkQyUUxYRk4y?=
 =?utf-8?B?cG5GZElIOUVmVUl5OHREdkhwVHdtaTJvWnhST0xxcVhjaGdGbmtHT0UrL0VS?=
 =?utf-8?B?dnpNR3ZDWVMzRjhLRkZCdWVDUGZESEVVUkZ3bWxRTmFjZDBmWk1qV0p0SGhH?=
 =?utf-8?B?cXp2RlNMcS9nSkg2U0htaURMdURRV1lPV0ExdUtEd1BYTDZoc1J2aEQzd3Z6?=
 =?utf-8?B?RVZiVllnQ3BLSklYelZDOEZWcUFvV1hwOFY5YllxenU4Skh6d3BqdjlyN3c1?=
 =?utf-8?B?WHBYc0RMa09yZ0lnTm5tdFduYmh6Zkl0bnE2Q3kydDhvUDQxSVhnbDBwa1Yy?=
 =?utf-8?B?VHlSbjhkTVJlbmVwbDl2R3UyMytkUi8wRk54WHlnMzA4VEJKSEtYRmtnS2dC?=
 =?utf-8?B?QXFtSGNiUUxGcVMxSFNlQjFlQWdMTkk2c2FlV1ZkcDNLcjdHUEhyeE5DNjgr?=
 =?utf-8?B?eHVVUjJqcFVZdjhpOVltZko1NTJFdXNCd1dMYmNqOFA0b09Lb09FazVzdURK?=
 =?utf-8?B?QUhua1Bwa0RYZm90UGh0U0dudmt3RVRyaDhYTTNoUkM0KzhwYUlHNGFDWUNZ?=
 =?utf-8?B?YXJUNWxkMmtPRkgrTVBOTmdGZ3ZXbVNRa095RnBLUFpQK2JTdVoydE9zWC9U?=
 =?utf-8?B?ZTB0anNxTDAyb1AyWUZ6TEtLQk81V0M0THVHMi9VelNnTEFFWGlGM2twbkpM?=
 =?utf-8?B?aERLT1J6VGtyY002NCthTURJYXAzdWJucURWYTRLd3dpQVpyRU92QjcvdU1G?=
 =?utf-8?B?bWVEL2R2bzZtcmt1QU5IRWFLd09WK0lmK05EV2czTDZRam83UUdTQitZTm5I?=
 =?utf-8?B?SnV5OElURS9CVk0zdVhONFNKbThEYTdEV3V1bUxsM2ZhVEdVVmRSU215c2wy?=
 =?utf-8?B?cTRGeVY0elpnUmdFYXJvYksxQWhkL1ZpK2lpUjE1ZDdTdHVLNE1JSFZLbldu?=
 =?utf-8?B?WXVhZ1p4d010a1g0SUkxQUxlOUE3WVNPdEM5M1NEanAvM1JjbUowWFdINWFF?=
 =?utf-8?B?MTZ3WTVIekUzUGJuVDNSMi8zNHFBU2xGNGt0Rm1VWDJ4SWNaSXlIbFhCV1hX?=
 =?utf-8?Q?q9JkEvZ8uLA6rzvp62?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702d88dc-59ef-44ec-86d9-08df124a77fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:25:16.2490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2AfB5wRbXhcBbfEE+SqnUM0uxe3RW6IG+iBcgu2u07tY9yd29DfO1kbUH83KPS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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



On 9/10/2026 3:15 PM, Jiqian Chen wrote:
> isp_suspend() and isp_resume() return -ENODEV when the ISP version does
> not implement the optional hw_suspend()/hw_resume() callbacks. Only
> isp_v4_1_1_funcs provides them, isp_v4_1_0_funcs defines just hw_init and
> hw_fini, so on ISP v4.1.0 both callbacks are NULL and every system
> suspend and resume fails.
> 
> amdgpu_ip_block_suspend() and amdgpu_ip_block_resume() treat an error
> returned by the IP block as fatal, so this aborts the whole amdgpu
> suspend/resume, for example:
> 
>   amdgpu 0000:c5:00.0: amdgpu: resume of IP block <isp_ip> failed -19
> 
> Because amdgpu_ip_block_resume() bails out before updating the state,
> ip_block->status.hw is left stale and the GPU is only partially resumed,
> which also breaks subsequent suspend cycles.
> 
> An absent callback means there is nothing to do, not an error. This is
> how the IP block core itself treats a NULL amd_ip_funcs entry, it skips
> the call and reports success. Return 0 in that case so ISP versions
> without suspend/resume callbacks no longer break device suspend/resume.
> 
> Fixes: 7ed51e3a1381 ("drm/amd/amdgpu: Fix SMU warning during isp suspend-resume")
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

Reviewed-by: Bin Du <Bin.Du@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 976b65f90bc1..ad667b9fde84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -321,7 +321,7 @@ static int isp_resume(struct amdgpu_ip_block *ip_block)
>  	if (isp->funcs->hw_resume)
>  		return isp->funcs->hw_resume(isp);
>  
> -	return -ENODEV;
> +	return 0;
>  }
>  
>  static int isp_suspend(struct amdgpu_ip_block *ip_block)
> @@ -332,7 +332,7 @@ static int isp_suspend(struct amdgpu_ip_block *ip_block)
>  	if (isp->funcs->hw_suspend)
>  		return isp->funcs->hw_suspend(isp);
>  
> -	return -ENODEV;
> +	return 0;
>  }
>  
>  static const struct amd_ip_funcs isp_ip_funcs = {

