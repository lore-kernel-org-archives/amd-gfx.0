Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960D4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 09:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287A810EE04;
	Wed, 11 May 2022 09:10:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7323410EE04
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 09:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvXaypAYGkh4WsxzTIL4OhQKOQzUYPNxdD5TPlgAa+vQEbIHrnvhoVJpkgrewcghTjQ0zJ9qC9MlWsvZff1x9l+BhxYNkuTSFG1aAH07P3UesgYD0dQx/k2mBZYoCXoGVRjO+kt0TLfjTRKLNXoWViaxlCjMOeSrEAZ2nwaiY5TTgK8TPd21RwsJsGcoRFOKeI/n86Ngn4J2HzywEVIheJC9eQ+52c/gRiw1cKDC6IRykdvZEvzArzd49aCDN/4xTIm8Aa+mHpF2Ux0On047nW6/Oq8cuCFs6bwurYVaoreNHCy8lbu4Yzo8AYidKwAZ3uExb7XSFimF7XVWOkOSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy+3pYDvFcE70vceL9/Cch9MugEgXMUqf+fNkNGTfao=;
 b=ji3l6XPaiOvNbPNZcIofSqFG/iFWwR/iushNK2qIEZzjv2vJPRqU88DteCcF+8BrlSIC81pYj68JwpemZaZ1oXEAMmGgug6rpSOZOoNGOwO4FgCb/+PEMdE8eZLrA7Aoiw7kl3g/TwTs4r5tbZEOiBJFUWTAMKrRlBxPrDGU52jGqmlaqQIRdNLkPUsXfzw6pcLCe8CMkVcLFaoztyt7jFhLPZxf52MXRcNrAh+R3QlQhI5LwL1+pWAsmQsDk50E7nsImclaU6p+eFTgdP5b6cpYxAHV1OKmGwSrRAA9NoM2jXCytjwfMUSRcaL93pngC38n6rfT6/GTwXAt5EgaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy+3pYDvFcE70vceL9/Cch9MugEgXMUqf+fNkNGTfao=;
 b=TxtgnlLXu+V4FmFrdldgp93O4mDsd7+YdmIsXeh1SfTegOQlIV18t390jkiuxVFUwLzHJ8suKMsleDL1/+MlBQ1IW5kCljLUzEz6FE5ZQ80vfSU919TzcdirbTV0LK5lYZzbObeTV2X6UKboA9IIt4y5fPCbBFn+jke2qeAU2TU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 09:10:45 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:10:45 +0000
Message-ID: <af6dcd57-0621-ccef-b06f-25644bbafe74@amd.com>
Date: Wed, 11 May 2022 14:40:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: consistent approach for smartshift
Content-Language: en-US
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220511084814.2077848-1-sathishkumar.sundararaju@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220511084814.2077848-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7688415-74a2-4de8-cecb-08da332e2156
X-MS-TrafficTypeDiagnostic: DM4PR12MB6277:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB62771DE0ACE595E3A6FBD9FD97C89@DM4PR12MB6277.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qq+yfg/mvL1PjZzh3GRhjX6QHeQRRnmdHEm1g8CCx35ljAcu8gN3x4TQNEopaI0bT8AiqOyYTs7oHafHbU3PEGFoEXPo7P3a93WTZkTejkYHurYsAmPfrYEzGp6eipRjp1Wq4Fmw/xiLIBqSKkuoriQqqCCGnSHNgWYLEeNBsm096c+7xwBJ4uBOKRSsW1RXvEeg13LDLclMhAi/jFRwEDvHeXhDsd8Bv8iq/m6gHNjKMTMkwzK+kRQBaMoYOf2Kc55kdXHSPprhh5kNLhb2rzTe1vUtL14ctp2oDbIbjpQ1syF9SJrfk2Ar3+ypr8xjJV1Fyuny+bDBkMKHs98Fh0FUnmAY8LHLD8RwZXewHKmIGI9D8yqrrxM4BicatrZdJPMMZ47EAxXPnYql4cNZWdKgt7BEO5uPkcsQfG42ZmKmthQgM2yzdb6tUOs5mRcvtmrG+Xk7ER6KniIxKcqM3v4W1gZtK8kJhqIUOz9i+OnnkEomf2t2ksT/xafRvRh0dRK1W0lC+Eqb5cfgeCFjUXlLGDqG+7JGH3sudeuFEkw81pOl8TA3Odj+Rll56jTsrWrHOBkTIA1dfMRLeoCe0BSVwofSAbPqH7m1RUSTA4gDA1atCoLjpsxDwhVAo/FShufzrONC+xBt2ne3+lRBEEVtoeT1RD9hq3N03M8lDeelQPbPNf1oDoJqbrpqbztYbd2HkkKgGpw8wMzi0yzQQit6HSnZQqs4mOPPA3SgWqXdbJPLpVHhpmS2qHPO7Suz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(66946007)(36756003)(66476007)(8936002)(66556008)(38100700002)(4326008)(6512007)(5660300002)(26005)(83380400001)(2616005)(8676002)(30864003)(6666004)(6506007)(31686004)(53546011)(31696002)(86362001)(508600001)(6486002)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNhUlRGMzNLeVJZUHgyVW44VVU5SXJvbG8xaWh6em1PSnQreExLMzlhMHIx?=
 =?utf-8?B?QjFoNUt5NXA1WllZMXlqMDRVYWwzQzZ6TURoTVY4d0ZKU1ZRUXVnMFdUUjEy?=
 =?utf-8?B?eWNNWUJTbnZtODFENmsvTGV5RmF3MEMrZlVwTmcvZjJ2S1U0a2QwaUR0c3BO?=
 =?utf-8?B?eUhRbmlxcHJRd0ZoUWZTM3dmb1dZMWtUT0RmU29aZ0JQcDlNV21kRmtFSkIv?=
 =?utf-8?B?N1RvNHJBa1o5ZUgzbjhYdzJNeFdZY3lxN0JCTjUzckMxSGUyTVRWSlkzbHFB?=
 =?utf-8?B?cUNobXpBU0ZuenNUT2F5SFVEeEQ5U2YwSWhQQ25hT3BMUE04KzNPWFliRmhH?=
 =?utf-8?B?YXdVb2I3dVEwcWIycjVndUozNDF6aFZablczbk9YWUZQakJDR3JXRUxXc0R5?=
 =?utf-8?B?bGVwdHM5MkJwSXpCbVFmUFRPcFV1dWhXRnYzV3F4YkFoaVRhOXQyZ2V5U2g3?=
 =?utf-8?B?VWdUUUlhWk45eG15VVVYdEJWQVRWTHB1VjZSbGJBSm0zRW01bUdhRm0yY09R?=
 =?utf-8?B?VE1ZL0FRdzNLWS9tQWdJUkZxVkRqVVZEYTZLeDU2NFFrblI2MHRJd1JTbmhK?=
 =?utf-8?B?RmFwQ055a3pPNSt0NjB4emNDN0VSRVpweE9EN0RUWHk0TndHbVd4MmFIUTl6?=
 =?utf-8?B?cnNnVnZHdHFnOHBBWURjUThPdXpRRzlhcTdJYUtSSEJ5VzdOOG1LYnF0UHJp?=
 =?utf-8?B?Q2tuVWRKQ2pSdFl1ZXRYbUFkeG9MdUlHblZMb29ZQnhyM012OHo3ci9KS3Uv?=
 =?utf-8?B?RGxSS2lFcDdscjJEekdPc2tndFZ4VGppdFFHUGtubVl4Y09YMHNhdWZ1UHhX?=
 =?utf-8?B?WmRlOEhUNTBJOW5EdTIxZUdjQjUxSXQ4bmRaNlFSb0wvOGc5WWFnT0xRS2Va?=
 =?utf-8?B?QzNsVDFta3lENnpaYnFDUFVHVlYweHprRDNWOTd2b3o0bG5ReWhlcGVhUzZy?=
 =?utf-8?B?WmZOaitCY0NTYXcrV2NST1c1Mlk4TjFBQ1MwUS81c1dFNkM3VXZSRjFpb3NY?=
 =?utf-8?B?NGtucDN0UUh1SXBvTklzb1dranBuRnB0dEt6Y2NYK3Q2c1YwN2NidGJVTzV1?=
 =?utf-8?B?Z0o0UkQyQ2NjQjdJTUdSVXY2bjVXeXg2UFQ1T0lXZVNjWWdrZDhkbUEvb2R3?=
 =?utf-8?B?ZENudmFPd0pvVTlhSlBqUEt4WExUWUZ2aFZucmtPdmJ0NUtFRW45V0c4MHBs?=
 =?utf-8?B?aHBKL3MwQ2ZQUXJCaEY3UFc1SlA5blh3NzhPOUJGTDNZZ3p5QThFRGRRU2xy?=
 =?utf-8?B?dTdPM2dSVmFtc29yV3NlaDZ2V0ZYU3JtYkdaZ0NEeXppQUFlektaSEk5REdR?=
 =?utf-8?B?QmRTWjBGSmxpNVdvRnVGNFh6cW5Vc1Q3OXBNbk9kNkhpNGMzbnAzbkhEOGti?=
 =?utf-8?B?TFc1eHlIbWlML1pYbklPNktmbXNlRkJsaWpKVGZTNllhS3l2VEdUcldtN2Y0?=
 =?utf-8?B?SWpqRWg2bm9aL1FHaTNrZ25RdThXM1IyQ0tyWnJkNW9CT2svNWc3VmQvVjlo?=
 =?utf-8?B?ZnFHNWNUdlM2U0ZGOFcrdGJIRlpIeWRjdTM0eWJZY1VRT2J4bFRReERPbEF4?=
 =?utf-8?B?SHFzVkwrZlVWblVmK2FJZTFsVHRERmxYTXVLSHBDN3RpQWFyN2NrK3BxZnVL?=
 =?utf-8?B?WDBZSHVzcEUwbDlKSmg3a3lsaHJPVFFqbzQ2WDRnMVJHeDl5aVBTVU5uVVVy?=
 =?utf-8?B?SkowVnNzM3VxaE1EenY4ajJIWVJtandWZkNyaGVPNjd3M2IxdldibVUyTDhK?=
 =?utf-8?B?WXNzbzBKTldoK0MxUHhHQ2xnQmJ2YXA1VnZSYmxGaDBJRWNwbmZER2tkbVFY?=
 =?utf-8?B?eGJkRWk5bm1ISUx2U3JSWFBFWmsvM1NqbGsyZ3F6MlM2OWpwWjFoUmE0TEJz?=
 =?utf-8?B?WXZpUzFwRUVJVTZySllSbXQveU5DYnBBMlp5OUpyeVZaR0xZeDQxWVRUbkgv?=
 =?utf-8?B?UVRGQUNYdWcxWlVlb2F4NFE1enZEZHl0ZThWZnNKSUg1MkZBT2ZpSUJuSWFG?=
 =?utf-8?B?UWhvZm5BT2V6Q2cwZnNNL0xmT1dMMUg3bnAyR0NRMFRyeDE1NjYrZUtjaHRp?=
 =?utf-8?B?UnExbml3cDlEQTZidk50bUxEMUV1cE5JTUtScFY0dEh3aStvYkdWclNVM3RT?=
 =?utf-8?B?UWZNczVrMzJ5RHB3WEJPYzV2MXV6WGlMM2RJamUwaWdLSnlUb2VxNmNMdVJY?=
 =?utf-8?B?OWl5R1ZhNWZTK1ptMjJJZDhHSzZFVW9RSFdhM1poZ0dPam52VzRjNG1ESEZp?=
 =?utf-8?B?aVVXTTV4R0VQVUVqbHJrMUE5amQrRWl2Q2R2SGZtTEQ5TzZqa1MzSXVpU3Nu?=
 =?utf-8?B?akNuSjRWbDNqczQ1ZTFJTlh0ZzVHcDI2c2RFWlN2d1ViOVJIYlNZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7688415-74a2-4de8-cecb-08da332e2156
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:10:45.0476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: civzdiXp6yaAEC1pJqhyIBh+yPoyfUYwSONGweAHW7oOL9wr1uRYetOX294HsDPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/2022 2:18 PM, Sathishkumar S wrote:
> always create smartshift attributes from dgpu device even on SS1.0.
> consider units of power in metrics table and convert if necessary.
> powershift value is in percentage and values to range between 0-100.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Can you split the RN, YC and generic changes to 3 separate patches? 
Would be easier to review and revert specifically for an ASIC.

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 146 +++++++++++-------
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  54 +++++--
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  54 +++++--
>   3 files changed, 166 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d3228216b2da..c2406baeef93 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1734,22 +1734,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   	return size;
>   }
>   
> -/**
> - * DOC: smartshift_apu_power
> - *
> - * The amdgpu driver provides a sysfs API for reporting APU power
> - * share if it supports smartshift. The value is expressed as
> - * the proportion of stapm limit where stapm limit is the total APU
> - * power limit. The result is in percentage. If APU power is 130% of
> - * STAPM, then APU is using 30% of the dGPU's headroom.
> - */
> -
> -static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
> -					       char *buf)
> +static int amdgpu_read_powershift_percent(struct amdgpu_device *adev,
> +						uint32_t *ss_power, bool dgpu_share)
>   {
> -	struct drm_device *ddev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	uint32_t ss_power, size;
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	uint32_t size;
>   	int r = 0;
>   
>   	if (amdgpu_in_reset(adev))
> @@ -1763,28 +1752,64 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
>   		return r;
>   	}
>   
> -	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
> -				   (void *)&ss_power, &size);
> -	if (r)
> -		goto out;
> -
> -	r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	if (dgpu_share)
> +		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> +				   (void *)ss_power, &size);
> +	else
> +		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
> +				   (void *)ss_power, &size);
>   
> -out:
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   	return r;
>   }
> +/**
> + * DOC: smartshift_apu_power
> + *
> + * The amdgpu driver provides a sysfs API for reporting APU power
> + * shift in percentage if platform supports smartshift. Value 0 means that
> + * there is no powershift and values between [1-100] means that the power
> + * is shifted to APU, the percentage of boost is with respect to APU power
> + * limit on the platform.
> + */
> +
> +static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	uint32_t ss_power = 0;
> +	int r = 0, i;
> +
> +	r = amdgpu_read_powershift_percent(adev, &ss_power, false);
> +	if (!r)
> +		r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	else if (r == -EOPNOTSUPP) {
> +		/* sensor not available on dGPU, try to read from APU */
> +		adev = NULL;
> +		mutex_lock(&mgpu_info.mutex);
> +		for (i = 0; i < mgpu_info.num_gpu; i++) {
> +			if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
> +				adev = mgpu_info.gpu_ins[i].adev;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&mgpu_info.mutex);
> +		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, false))
> +			r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	}
> +
> +	return r;
> +}
>   
>   /**
>    * DOC: smartshift_dgpu_power
>    *
> - * The amdgpu driver provides a sysfs API for reporting the dGPU power
> - * share if the device is in HG and supports smartshift. The value
> - * is expressed as the proportion of stapm limit where stapm limit
> - * is the total APU power limit. The value is in percentage. If dGPU
> - * power is 20% higher than STAPM power(120%), it's using 20% of the
> - * APU's power headroom.
> + * The amdgpu driver provides a sysfs API for reporting dGPU power
> + * shift in percentage if platform supports smartshift. Value 0 means that
> + * there is no powershift and values between [1-100] means that the power is
> + * shifted to dGPU, the percentage of boost is with respect to dGPU power
> + * limit on the platform.
>    */
>   
>   static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
> @@ -1792,31 +1817,27 @@ static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	uint32_t ss_power, size;
> -	int r = 0;
> +	uint32_t ss_power = 0;
> +	int r = 0, i;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_get_sync(ddev->dev);
> -	if (r < 0) {
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		return r;
> +	r = amdgpu_read_powershift_percent(adev, &ss_power, true);
> +	if (!r)
> +		r = sysfs_emit(buf, "%u%%\n", ss_power);
> +	else if (r == -EOPNOTSUPP) {
> +		/* sensor not available on dGPU, try to read from APU */
> +		adev = NULL;
> +		mutex_lock(&mgpu_info.mutex);
> +		for (i = 0; i < mgpu_info.num_gpu; i++) {
> +			if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
> +				adev = mgpu_info.gpu_ins[i].adev;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&mgpu_info.mutex);
> +		if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, true))
> +			r = sysfs_emit(buf, "%u%%\n", ss_power);
>   	}
>   
> -	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> -				   (void *)&ss_power, &size);
> -
> -	if (r)
> -		goto out;
> -
> -	r = sysfs_emit(buf, "%u%%\n", ss_power);
> -
> -out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
>   	return r;
>   }
>   
> @@ -1884,18 +1905,23 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>   static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
>   				uint32_t mask, enum amdgpu_device_attr_states *states)
>   {
> -	uint32_t ss_power, size;
> +	struct pci_dev *pdev = NULL;
> +	unsigned short devices = 0;
>   
> -	if (!amdgpu_acpi_is_power_shift_control_supported())
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if ((adev->flags & AMD_IS_PX) &&
> -		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
> -		*states = ATTR_STATE_UNSUPPORTED;
> -	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
> -		 (void *)&ss_power, &size))
> +	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>   		*states = ATTR_STATE_UNSUPPORTED;
> -	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
> -		 (void *)&ss_power, &size))
> +
> +	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
> +		if (pdev->vendor == 0x1002)
> +			devices++;
> +	}
> +	pdev = NULL;
> +	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
> +		if (pdev->vendor == 0x1002)
> +			devices++;
> +	}
> +
> +	if (devices < 2)
>   		*states = ATTR_STATE_UNSUPPORTED;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index fd6c44ece168..a781c63b10aa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1119,6 +1119,39 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
>   	return size;
>   }
>   
> +static void renoir_get_ss_power_percent(SmuMetrics_t *metrics,
> +					uint32_t *apu_percent, uint32_t *dgpu_percent)
> +{
> +	uint32_t apu_boost = 0;
> +	uint32_t dgpu_boost = 0;
> +	uint16_t apu_limit = 0;
> +	uint16_t dgpu_limit = 0;
> +	uint16_t apu_power = 0;
> +	uint16_t dgpu_power = 0;
> +
> +	apu_power = metrics->ApuPower;
> +	apu_limit = metrics->StapmOriginalLimit;
> +	if (apu_power > apu_limit && apu_limit != 0)
> +		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
> +	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
> +
> +	dgpu_power = metrics->dGpuPower;
> +	if (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit)
> +		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOriginalLimit;
> +	if (dgpu_power > dgpu_limit && dgpu_limit != 0)
> +		dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
> +	dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
> +
> +	if (dgpu_boost >= apu_boost)
> +		apu_boost = 0;
> +	else
> +		dgpu_boost = 0;
> +
> +	*apu_percent = apu_boost;
> +	*dgpu_percent = dgpu_boost;
> +}
> +
> +
>   static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   				       MetricsMember_t member,
>   				       uint32_t *value)
> @@ -1127,6 +1160,9 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
> +	uint32_t apu_percent = 0;
> +	uint32_t dgpu_percent = 0;
> +
>   
>   	ret = smu_cmn_get_metrics_table(smu,
>   					NULL,
> @@ -1172,25 +1208,15 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	case METRICS_SS_APU_SHARE:
>   		/* return the percentage of APU power with respect to APU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
>   		 */
> -		if (metrics->StapmOriginalLimit > 0)
> -			*value =  (metrics->ApuPower * 100) / metrics->StapmOriginalLimit;
> -		else
> -			*value = 0;
> +		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = apu_percent;
>   		break;
>   	case METRICS_SS_DGPU_SHARE:
>   		/* return the percentage of dGPU power with respect to dGPU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
>   		 */
> -		if ((metrics->dGpuPower > 0) &&
> -		    (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit))
> -			*value = (metrics->dGpuPower * 100) /
> -				  (metrics->StapmCurrentLimit - metrics->StapmOriginalLimit);
> -		else
> -			*value = 0;
> +		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = dgpu_percent;
>   		break;
>   	default:
>   		*value = UINT_MAX;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index e2d099409123..ac3d4b0863d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -276,6 +276,40 @@ static int yellow_carp_mode2_reset(struct smu_context *smu)
>   	return yellow_carp_mode_reset(smu, SMU_RESET_MODE_2);
>   }
>   
> +
> +static void yellow_carp_get_ss_power_percent(SmuMetrics_t *metrics,
> +					uint32_t *apu_percent, uint32_t *dgpu_percent)
> +{
> +	uint32_t apu_boost = 0;
> +	uint32_t dgpu_boost = 0;
> +	uint16_t apu_limit = 0;
> +	uint16_t dgpu_limit = 0;
> +	uint16_t apu_power = 0;
> +	uint16_t dgpu_power = 0;
> +
> +	apu_power = metrics->ApuPower/1000;
> +	apu_limit = metrics->StapmOpnLimit;
> +	if (apu_power > apu_limit && apu_limit != 0)
> +		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
> +	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
> +
> +	dgpu_power = metrics->dGpuPower/1000;
> +	if (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)
> +		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOpnLimit;
> +	if (dgpu_power > dgpu_limit && dgpu_limit != 0)
> +		dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
> +	dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
> +
> +	if (dgpu_boost >= apu_boost)
> +		apu_boost = 0;
> +	else
> +		dgpu_boost = 0;
> +
> +	*apu_percent = apu_boost;
> +	*dgpu_percent = dgpu_boost;
> +
> +}
> +
>   static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   							MetricsMember_t member,
>   							uint32_t *value)
> @@ -284,6 +318,8 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
> +	uint32_t apu_percent = 0;
> +	uint32_t dgpu_percent = 0;
>   
>   	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>   	if (ret)
> @@ -333,25 +369,15 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>   		break;
>   	case METRICS_SS_APU_SHARE:
>   		/* return the percentage of APU power with respect to APU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
>   		 */
> -		if (metrics->StapmOpnLimit > 0)
> -			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
> -		else
> -			*value = 0;
> +		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = apu_percent;
>   		break;
>   	case METRICS_SS_DGPU_SHARE:
>   		/* return the percentage of dGPU power with respect to dGPU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
>   		 */
> -		if ((metrics->dGpuPower > 0) &&
> -		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
> -			*value = (metrics->dGpuPower * 100) /
> -				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
> -		else
> -			*value = 0;
> +		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
> +		*value = dgpu_percent;
>   		break;
>   	default:
>   		*value = UINT_MAX;
> 
