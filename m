Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B43BFCD0C1
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 07:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D152B10E2E9;
	Wed, 18 Mar 2026 07:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zOwN0HvF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A44510E2E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDh04do8qoVOmEuxJuSw053FZcAKE1wgAopAJR4E33MRv3kX03n3vDtfpCnmlhK/PQ4IU+1PqhV1GUhwLN4zkjmdQjOzwdayWsZLB6f/oiAW8GdoTEf2OnWCXa1lUMq1FSzKdw5E48TKr+rvEYUIdTJm6/noDmU1py1O752MUr9s0H5+ayVBsCgkK3xzHKNyUo7QaXa0OnFISqLwU3mDnmnlk3t160RrPm48xjB03MXZqQY2GX36mUjrVFaiCUfTBeWyFaiqkig5FjznUZ2L9dKJzjQM08W+kYosZHMrjQVhJo2YMQQdi9uIARQDBmyNpCl6NHiScVx5agtGsCDOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYVOLfFvLhkdxBwrQ/r/Tld9vCnR3tw54DLalGs8ixI=;
 b=sS90QLONKW9J8BYMbCM8UXTn3bq6+uDjJN2utsE39vSDabYXt2ONB+uR9GzgP71v+dqVgwf+1I0rgLlQxMqsIiY1C1zMSqIuFWvgvQqG6F9N5NpSh9TA9mRyRKT0OXIk+Y3Qsn0slC8js5ubReZxwvgTRdb5nYjSSiIRo0zT+vDb1HzFKKM/qQjdUVNJoWqAoW6Mwp90/exCWnI5nFQSHUazvFFqSOW5fvHL6POD6RGnZjbVFgyWtKz/xLtvs3lzJPZoGU1DOYhEG0chBtFrFJ+EcaECwuXCbRaMo9h79zXrK+QnDwh0isnUOyg1ra8UsKJjRxlvcSdszhd44TaIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYVOLfFvLhkdxBwrQ/r/Tld9vCnR3tw54DLalGs8ixI=;
 b=zOwN0HvF1btvuEJRmci+R9jMKhlUxNQjLLmLOX3p7VdvHmxPuepjGLGEdFmpXt8wzwp/2uthwa6ez9Q9yO7BwEABlkjtluSkdHDDu3Dl85bDAaSCIz1AHysOBbPk/leJwk4s8c4srXLIXyBrO0WHZeRz4lL/GtGwOkLHSiD5jQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:30:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:30:56 +0000
Message-ID: <70c5a048-7dfc-4024-8031-aae0d7b4dfb3@amd.com>
Date: Wed, 18 Mar 2026 08:30:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix strsep() corrupting lockup_timeout module
 parameter on multi-GPU
To: Ruijing Dong <ruijing.dong@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com
References: <20260317181759.34331-1-ruijing.dong@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317181759.34331-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 20066032-3c85-4689-371c-08de84c04ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: t5SVipsO+h29XlKrLAvGWdCfhTw9XG0Fi8ZaVzjZfhMLljMAhDDVucK8ZPLDv7JTL3CXlTbIOpcLBnG8SQk0ZnKFxep4YZ2UTPpP8gkMLG2Vb99Krjl/N9J24ph2lfQBNQ5HFAdkg1Ttk6AOpzLXQnhIhTVVY/SFYZoe9uVxvGtaKo7mnM/RLMMC5caZyl839jd09fiDDdq0/Yg01QOCQOJy+7GzIHm0A0RpsGv23VoPF2Hu5HZSQyF+NzuO0OtQBOwmZfw7FwJCZxK+lCDpCm050Wy1spT/oNaG34LWHWaT/XyUATp+E3Xw9+xMhnSkm86Y3XcoQakf5b+8MJs3OXOhhkuTByCmg++GHfeWzStgyy5MkP6D7RrPXQI4mZ07c/3ReZnrHHXnYwzzQ3qwSSHLHdEEliTaoXWLMiq1KQXzzg6FCckxoHWJDsAarCE18dEkLR0TZxd5Nsc+Kvf+3KV/0UTU71ZexZuEPK2NpDooL2KKgnubYLIVMOOP6pOQ9Y0jirteK/hgeiRuRSVclpBHGIn3lERwTVkFk966wS8yO98zoqYbOYrWmR+NDcfT2x0ZEgon6GxwgI3VjGc4qF9bro5SATYn12gnen/v1CigzlD6SSAlwF4ODOIFONBYDTBnuJOClps81Y26qUg66fOmv615R3LSctwjwzcnYU3P3UYrSBD5vzCTAmL56ro8CCL/16C2PwJwQcbE4QgiVgc9tXyp2/Jjb+496VJyYTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0xiT0JzRDdjZmlteVVJSHBzTEFKZkNDMUxDdGU4Y0kwYjVZcWtmTy8wSndF?=
 =?utf-8?B?WHEyWUVXR2ZXYWNoZGtFeVZzK1o3VmpQWWgvOHl2MjYxT3JTaS9pSzJ1cUZN?=
 =?utf-8?B?UFlibzZ0aHIwZlVqb0dNNW8zb1FldlZMS21qajR4QUEzK1B4VE54SHdZYkM2?=
 =?utf-8?B?T2pCdCtjMTFJWDVXaEx2bjZSSjh3Z205b0JaM3FRaWkwVmJrSlJ3d0FyMXA4?=
 =?utf-8?B?a1pEdlBJV3ZXNEhFa2FlRjgyR01mSDM5T3Rlc3M4Yk9SM1RKTGV1MUhrajMv?=
 =?utf-8?B?b1ZqWlBaU2pjMDZSWk9NZ0ZabzFVVDBROVc3YThGSVJMeHZoZ0ZBdDFDTlhw?=
 =?utf-8?B?ZVZoeXhsem8ycmUyQWYwRGkxb2JydlNTdlZLTXZRbkN6ejRtTHNjWXkxd0g3?=
 =?utf-8?B?bUo1dGthNkRwcWxCWFhPcTdoa2cwUzB2UUlad1Q0TDlpU3NSbjBXV2IvUjR5?=
 =?utf-8?B?WWM3TWhNSGpRNnY0T0ZVYzFycWpjMHBwVTRONHFmbllReFZmNW1kWDF4ckpw?=
 =?utf-8?B?OEVlU3dmZGZOK1FVZlNhWmtuUWlZcHJ2MFMrZWZhdzEvQk5tUFNubVlQS2Fy?=
 =?utf-8?B?aVI2SE1rRGY2Q1Y2U2U2RWFhYWdYL01JRlYya1owL3R6YnRSaEtPV3JjTzln?=
 =?utf-8?B?RWJOS2wvV09YNkZJQzdTdWpYcjJIdVBMMUlDMUNuMEJ6TjNGY0ZGekRDTXhP?=
 =?utf-8?B?T0VUNGlZSTFSUjd1RFJEUVFWMWVaZk1ETDVuU2FpaTdHbjZ6aHYvckZuMzBE?=
 =?utf-8?B?eDZrczlGWVhoRkVzZ1pZME9rV253Z1pHUlV3SDNxejdwTlY5VmpOWGwvNmtJ?=
 =?utf-8?B?d0R6bTRGaVNIUm01TzV5ekYzVFI3a1Zjem9HZmxJS1BZYlNYSkFhY3BGQlpM?=
 =?utf-8?B?SDFxaEVQWlYyZSt4NEtLczdlVSs0OEJRNUZSOFh2K00xVXR6K2JWTXUwakk4?=
 =?utf-8?B?U0VJR0JkVFBjOW1wcDBXbWwzbmtrZDhGSVVQa05aZVI1M1J6b2ZGazRuaGJB?=
 =?utf-8?B?V2h5MnMzTUlad1ZoWXVDcHNtQWVpUzg4dDFpSjdrSm1JcDF1eS9KZFVoZTFK?=
 =?utf-8?B?Undvdk9sRUNrR2kwcWF6WFhIejJIY3I3bStPa1lhaExEWTg3VHd4VC8yZlZ4?=
 =?utf-8?B?NTU3cHAySlpqTHVlMjRXQjk3bUx1ZXJXNHZnUENxbi9HaGhyU1NNd1hLVVFq?=
 =?utf-8?B?a2lSUXRKajRmK2xRbERueTdNOUNUV1h2VkdFYkE4UlAxNnB0L3RwV0dRWU53?=
 =?utf-8?B?eVRTdzJmOVFUaHNGUDJuRVF5Rk0xVU1hVjg0bmpOcTBqOTczYkRzN2FLWWpY?=
 =?utf-8?B?c1dGeS9nR2hzYVdYajkySjRySXV0eVB1YkFQM01QVGxDZVo4eDkwVk9MOVNE?=
 =?utf-8?B?aXljQUw0emZ6NDRuZ2ZadnowUFdOZjA2MHdkUnpJVTBMcU82dWNkN2ZFT3Qw?=
 =?utf-8?B?ZU83ckgyR0VmVC9XQXpRM3prcUZlbUZ6Y3FuRDhnTVBzVVpsSzRnaUMzMzNN?=
 =?utf-8?B?dVd2MWQ5VkRmVndZYmxhQURmcXpkRHhYN0labnlWd1h6eTdKbGd5STJUOWJ6?=
 =?utf-8?B?Q2RPZWFYMFk5am5kVjVCeUF5RjA3N1BVWHFEbldoRG1EbXJvOWgwNkF6ZThK?=
 =?utf-8?B?Ym16MVJ5VWlQc2gxREhKaVkrYW1nNGQrSDYwTWZaV3JnczFBTjBISVRwMlVx?=
 =?utf-8?B?SUF1cUUzMEZLZWhYdi91S0pJODY3WFJRTGNFODYxbktUZU15bCs5M2dGY3BV?=
 =?utf-8?B?N0RzY2FxZnpUcGovNWVNSWVTZ3BFQlZ1Z2NvNUVWSCtoZVdTdUhqM2ZyTW9t?=
 =?utf-8?B?Y3p0cUk0czQvbzhBcG0xWGZIWFd5VmhUNnNBK1RadjBRNkN1ajEzbHJFTmtx?=
 =?utf-8?B?c2VlaE9WemF2aFdwcFUvUzQwUjJXUzh1NWtSb2ZJY2RUdXc5dlo4Nm4rOThI?=
 =?utf-8?B?NG5lMFcxc3p2U2ZIajVMNnVpdnlmR0hLQlZ5cDBVM3RjR0I4bDBVSmNRN1Rz?=
 =?utf-8?B?TDV6R1BxU204ZC8vVVcrMlJ5YUNndEZVbTc4OW5IZjk3bWVodGRyN2Ira2JB?=
 =?utf-8?B?SVhJUmFaUnFDeGt2VnBFQkllcE1IM2I3YWJpT2JmcGh1UjhtT2gxaXltczBy?=
 =?utf-8?B?YlZ4RHhFamtHa0pUYkdNOXZPKzhTdnM2ZXQxZ1VDS3MwQzNjMXlQMFh0N1ls?=
 =?utf-8?B?akZ6bXhVMkNMRHFJeStUT21vU3FOYjdNME1FTXZGTmlZUEVIdkFndTVzSjNn?=
 =?utf-8?B?MFV2UWtPKzVFSDhpWFBxczB0ZTR1N2drbklMS2l1dURpemxmL3N1UTBVeXo0?=
 =?utf-8?Q?3bPUklXyNFB8g6/oR9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20066032-3c85-4689-371c-08de84c04ae3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:30:56.1068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73+I7xdWSkJk/Npmo80RkE/jEdiqq3cWAi6FEELFLqR8N8JGK+zen0EDyY2zB1zL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

On 3/17/26 19:17, Ruijing Dong wrote:
> amdgpu_device_get_job_timeout_settings() passes a pointer directly to
> the global amdgpu_lockup_timeout[] buffer into strsep(). strsep()
> destructively replaces delimiter characters with '\0' in-place.
> 
> On multi-GPU systems, this function is called once per device. When a
> multi-value setting like "0,0,0,-1" is used, the first GPU's call
> transforms the global buffer into "0\00\00\0-1". The second GPU then
> sees only "0" (terminated at the first '\0'), parses a single value,
> hits the single-value fallthrough (index == 1), and applies timeout=0
> to all rings — causing immediate false job timeouts.
> 
> Fix this by using kstrdup() to make a local copy before calling strsep(),
> so the global module parameter buffer remains intact across calls. A
> separate pointer is kept to the allocation start since strsep() advances
> the working pointer to NULL by the end of parsing.
> 
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dcae77b6c272..97ebcc5bb763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3498,7 +3498,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>  
>  static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  {
> -	char *input = amdgpu_lockup_timeout;
> +	char *input, *input_copy;
>  	char *timeout_setting = NULL;
>  	int index = 0;
>  	long timeout;
> @@ -3508,14 +3508,25 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
>  		adev->video_timeout = msecs_to_jiffies(2000);
>  
> -	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
> +	if (!strnlen(amdgpu_lockup_timeout, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>  		return 0;
>  
> +	/*
> +	 * strsep() destructively modifies its input by replacing delimiters
> +	 * with '\0'. Make a local copy so the global module parameter buffer
> +	 * remains intact for multi-GPU systems where this function is called
> +	 * once per device.
> +	 */
> +	input = kstrdup(amdgpu_lockup_timeout, GFP_KERNEL);

I think it is save to copy the parameter to the stack instead of using kmalloc() here.

Apart from that it's a pretty good catch.

Regards,
Christian.

> +	if (!input)
> +		return -ENOMEM;
> +	input_copy = input;
> +
>  	while ((timeout_setting = strsep(&input, ",")) &&
>  	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
>  		ret = kstrtol(timeout_setting, 0, &timeout);
>  		if (ret)
> -			return ret;
> +			goto out_free;
>  
>  		if (timeout == 0) {
>  			index++;
> @@ -3551,6 +3562,8 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  		adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
>  			adev->video_timeout = timeout;
>  
> +out_free:
> +	kfree(input_copy);
>  	return ret;
>  }
>  

