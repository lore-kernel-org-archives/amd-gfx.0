Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E152FCEE8A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 12:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D6010E749;
	Wed, 25 Feb 2026 12:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QETfzeYX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010007.outbound.protection.outlook.com
 [40.93.198.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC7510E749
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 12:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LySmABA6yGjHHBwfswioCIfZIUYdMfC4BzgtNySLsk4SJlrJcRmlAC091JEU0aXaPejJDoAEzBxJQ2OxVN8A5gHEnwAk+myaNNOqqaa/6PihnB8LLRLQLt4ZzxCeG63kghinUJZa2zg249G0IIvpoyakU5ZEaBfmy2hjxef6Ylm4CylSBeOnqA3alghcnvs2DL8tgNI5I8W0cnZ54W+EJUNBUXR59RBe3Ok04dYNPA9VsRakfAh522c/lYg4pGgJDVxuWDl74ivr9E1GpJvC0en/ZSfDxXlV2C4tK1CZWKUZldr9AFFAc7mgq8z6dkDJQ/A5zBYKx5ddUS4dhUyhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+aqC8tMg5mfJIkX04PWy/gmT2nA9u3RDpgqHSuvI5w=;
 b=pj16jvV8l51MciDgfayd9lA8Lo2zY7DT0AxpqcrZM5Y6l7zh30FvDKUjqL0ChTyUeaOkEpoJ8nT9b4QWEnXZYmUo7Rk0dP7xMVVeShA/HeYfy0R6P70TBMPctr8NZ01DxUTvW4ZT8z9F9f/miyOROxt54370rt9tyDQvql6ChPXiADeS1aOSg8M1p9+N9nW1L4IiJ0NvuF/MVCezPPwdRaPgGLE9MpYshMm1ZpcUw1TwhXfhgd1mqK/bkqPLNxmWV2t74bD3+2UKzlA31xvhn4fxA/vqS30UQHi1FC1WWxzy1srMcVz5eKTZbKGh2QqnaDDksPA1l/LHK+PxNzbLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+aqC8tMg5mfJIkX04PWy/gmT2nA9u3RDpgqHSuvI5w=;
 b=QETfzeYXOuKvgVnRGrD0R6qLxAXKR1uQh9/Dq1n0i9KRBgET32QFgrrtR46UIYEA2gKs+nPiJE+CUpAxrWVaI6OLmPE5RhS5jQdkXi09ZU1wYX0qF/1BaHfRyyZ7mrskqmxzOd6e04opjLIeEdtShxOx0jIbKgJHuHIytjjRV1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 12:04:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 12:04:17 +0000
Message-ID: <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
Date: Wed, 25 Feb 2026 17:34:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260225093406.498727-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 4767bec0-74b0-4486-5091-08de74660018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: vJZNvKDDrb0K34tP/He5b0x89GNPN/w5OytrGD20xT0Rd8yw1OPtrLmeFOa5WhnS7XKXt3is4hGstzqubJbIvt4OFcLpDcr6jD48hH2g9Ljbcz6SQPopEKf3IQ1aYK6wj1KUEkwACd3T0f/ef3Hiorvgj9v/aHmShVUQxz8JX5efW/lFmusO6LeGnYYNptmHwsQZElJ4tz7OIf2A0ltdSSfdFqR2AfEUvLlmSKGawAM6ZITrMe8pCo0NwfQKuyse3bvUpxkskky5rflLbU8ljb36zqoor9JiZKCMYghiIXChlV73j5xd2IG63B7uQOkXA+h56Jh3oYIDbX+8EZfAxZYWHytQt3qQLTE6mTYI0pywykt7tpEZrudH6CIRYJR0QZK57J4FXl3A3dkd6XF2iTs5Y962smkqyGbLZzdZW7vc14VKPmRBk4OqVeZg4+fryn2V2ZCFcqAHDoG7Yr0Pdwbr9vYzsaMkOnzS3E5jvbjNS8MlTZT0cNH7cf8j6S62yTp/RNyH54ma6fXG73DhI+SCf2G8RZyeHwz5Z99uDICYC/GIQQ5qgQnbRjPSTv900aJyBJBegQtXlMvCsF7PbXVVL+7+jo+zVRyb1tnCKRSBMYIARniIWOLsXZxPwqzTc9c93Znxszmkhhke1ZZmtOXZ3uM4rnJq7g0UOuwcsPOZMAFmzlwTYqXdY/XL9a3BZB4DFY3pxfp8kYksjRoDK7sbfLpQNzhrXmA8V5U3js0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRrWkRod0tPcEhJUE1WQitFcXk0WFlaclBGU2hpeXVIWHhXeEtLbjRxV2Zr?=
 =?utf-8?B?bi9oNEdzMVB4Qks5OUNEaWhwMUhnQmllcE8xZTBPcWdrZVkrOThmNlBtU2I2?=
 =?utf-8?B?S0VwaFZQNE1DN3ZEbVVrOGt6dkNnZEdPcXhZUTE2R2lhbTNab2k0bWMyekt6?=
 =?utf-8?B?bHc0Wm9vWkk2VTk1YnE3VC83eU44T0U1QkJ5d2lrOFJ4UWFzd1Jzd284dGxm?=
 =?utf-8?B?N0FmVDZ1WG83ZG9MUytTZHdVbjFENS9HdXZpMUlBL3JiM2V3a1R0QysvL1Ry?=
 =?utf-8?B?Q1N6cnNnd0pRbXlRSmdXMWZMMnBsV3BGWVZKUUR2ZDVIUkMzelFzYkYyak4x?=
 =?utf-8?B?bGt3dzNsWVM1cWtYeGplWG9vdmI1MzIyVGpjOE95b0NGaXhIanBwL2xVTHVx?=
 =?utf-8?B?ZEdrbGpuOGdHZ1gvVWNGcEVmczRzdGRNS1ptd2pzTE8yWTdKemt5NnpQNjJD?=
 =?utf-8?B?WkE3SkxhQ2xYZHB0S25WcG5FUHQrV2xlTDdRcFlFVUJZRkQ5S2Jud3FVcGxZ?=
 =?utf-8?B?R1cwL29vRU9wMGNrN1VxTXpUbXljM2Q4TTNTejAyVFhvb1Vqc3IvWmVLenFt?=
 =?utf-8?B?Nm9xSUJMR0puN29jVW43MDRZZUFMS09XUi9LTHgvOC8veCtiS05VNUZFYjR1?=
 =?utf-8?B?dnFvL3BDTUZKakx4dkoxKysxeEVkWkNQMnZlTUJDK2l6L3ZEd2lZdEUyNVJM?=
 =?utf-8?B?RUNMZTVSNzZzdlRYZlJsUnlQUU16Rm9lbTArdjVKSWZWTjE2bTloQVNXU1lk?=
 =?utf-8?B?ck5DUGpBNjBEREpISVlwMmVVWGNLaVZzWXNWM2pZNTIyOGlHWGRqYTZLSjdW?=
 =?utf-8?B?eTVMSUtEOUxlcWNTU01lVVRCTVRuTUswanF5b0VvRzE1Z25rRlBYU1lranB5?=
 =?utf-8?B?VmxoT1JTK1RlSDZvYXloRWM5eEpodlVVYU5pV2oweEw3L1YrTFg3VjZUTE5y?=
 =?utf-8?B?RVNCbWVFR1BxN1dxdENFYVNXS2ZMNjRTdmx2eGV0TmNEZTlSaS96Y1B5c04r?=
 =?utf-8?B?eGJVa0gvTXR1TzN5RTRQTFFRWHdqNjk2emw3MU1uZi9yOFlWUmdJM1N6SlNM?=
 =?utf-8?B?Z2pnRlNiOWhjT0VEeTlIQngydE9UR3pFcnFZL3F4STlMS0hqQkJmMTFQZENT?=
 =?utf-8?B?YXM5ZWNQTmVkMHg3U0R1SldJTGh3cXF6WVhjMUtLbVM2bC9NdDl4SVQ0WHph?=
 =?utf-8?B?b1R2elQ0ZHNkV2wvYWNhczNVWHArTGNwWXVRSG96cnNCQXlUMGwxSGNLdStm?=
 =?utf-8?B?eTQvOXJyd0UwUFM5Yk5zbFJVZ3oyc1FMU1prREt1bUVrOEFhZmdoeHNvQkVS?=
 =?utf-8?B?S25aTE16RGppN0JJQndMTlY1NzM2UFVlek5QUmdYc1ZtOEJBUE9iajJXWUVI?=
 =?utf-8?B?U1NyNXpxZXhXZC93d2QrTlJWQzc2cW9uSUEwelVvLzhqTW9acUhaVE1CcFQw?=
 =?utf-8?B?djJuUlZnTk5zSWQ4N3NKQkM1WUVWZm9QbldWblVQclkzckpNVGxsM0l3SUJD?=
 =?utf-8?B?alRWZThJVkxFNmtiY2x6V3c0bklCSmZsbjcrMnB5OGcxUmVoa1E3TitzZUZK?=
 =?utf-8?B?eUxPREIwRE5DYm90Y0dvVWNJbmlNd29mbDRwRlpYZGdPM3ZBV0ltbFIvZHBj?=
 =?utf-8?B?SExrNGZ0VU85Yzc4Y1hSSjJYRWJ1S25PcklzeXdEdi9tdVJibjU0OVBTMXNY?=
 =?utf-8?B?aEk3YVNxOGRqc0R5ejJEc3BibTY2aXhHeFdaeWpXaWlpeVdTM1FWQUowdVBZ?=
 =?utf-8?B?WjdnRkdTVkE2ZkRnVExDWFMrT3ZaWkh3Ni91QS9saUVINVI5dEYvOFpCOERx?=
 =?utf-8?B?M09oaVZjaTNVellDWDk0OG1CMFJlMVR5VmFSOWFzUktuaVMraWQ4bU5nWENi?=
 =?utf-8?B?WmJLN1RIczJqZFZtM3ZpWEJZSG00eXAxK2I2OVdJTzloS3VyOGxyTzhHQmdJ?=
 =?utf-8?B?Qkc2VnRiL3BEUURNQk42c1RDNUVvcU5ZUDFTb2JlRXp6d1VWQUxKOUFSQUs2?=
 =?utf-8?B?RTIzVTVVMHdoNEVnbDNlNG9xZWlpaUtLMHdmenUyQ1lGR05lU0liQ2ovWTMv?=
 =?utf-8?B?eEZqSUYyeVFZRWswK240OFFZRWIxY3dGTFN0aFA5OVVQQmdJbzZsdkhFbSs5?=
 =?utf-8?B?Y2ZIQVlQakJsMUZUU0cvd01YeldHMnlRalliRGRRMHNYUlZ3MklKMG5ZOFZU?=
 =?utf-8?B?aDhSdlhpdTlYaXJRMkwzYlBYUVRvZUE1ZzY0MGtOODZXdHRvNzM4ZU5Na1lq?=
 =?utf-8?B?VHVnZWZlQ3hTVFUrVVdwL1hxK1hqZ2QwS3FxdUE5YlYwM1lPNGhTRkdqazND?=
 =?utf-8?B?dGcxUld1SXdGbXFnMW1QS0gyMXowZzBuaVRvQzExV2hudFdIV1FwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4767bec0-74b0-4486-5091-08de74660018
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:04:17.4414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzlMHj7JqSxAVQZnzIfuj626DSJl5MQ+PZags5baE4p0T9mJfuwZksPGFFsVIrMQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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



On 25-Feb-26 3:04 PM, Yang Wang wrote:
> Limit GPU/MEM/VCN load sensor values to 0-100 range via clamp_t to ensure
> validity.
> 

Is this a workaround? If it's not within range, it indicates some 
underlying issue.

Thanks,
Lijo

> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 938361ecae05..86ef1ffbf1dd 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1414,20 +1414,39 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   
>   static int amdgpu_pm_get_sensor_generic(struct amdgpu_device *adev,
>   					enum amd_pp_sensors sensor,
> -					void *query)
> +					uint32_t *val)
>   {
> -	int r, size = sizeof(uint32_t);
> +	uint32_t tmp = UINT_MAX, size = sizeof(tmp);
> +	int r;
> +
> +	if (!val)
> +		return -EINVAL;
>   
>   	r = amdgpu_pm_get_access_if_active(adev);
>   	if (r)
>   		return r;
>   
>   	/* get the sensor value */
> -	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
> +	r = amdgpu_dpm_read_sensor(adev, sensor, (void *)&tmp, &size);
>   
>   	amdgpu_pm_put_access(adev);
>   
> -	return r;
> +	if (r)
> +		return r;
> +
> +	switch (sensor) {
> +	case AMDGPU_PP_SENSOR_GPU_LOAD:
> +	case AMDGPU_PP_SENSOR_MEM_LOAD:
> +	case AMDGPU_PP_SENSOR_VCN_LOAD:
> +		tmp = clamp_t(uint32_t, tmp, 0, 100);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	*val = tmp;
> +
> +	return 0;
>   }
>   
>   /**

