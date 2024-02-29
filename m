Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACAAC54798
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 07:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDC810E142;
	Thu, 29 Feb 2024 07:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIE2de2B";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5818C10E142
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 07:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd2wsLqI9hTKuqS8xrcCxgOd5/X6Jc8+YIgxcWhIqDdEl7flq1WOxPu+dURdbUe9gWgFRuCaOwlPXRdKL7Z+4+mC2oWInJG99/Rsc1rUj36jMtE4wdudjeVwLmq/NriDm76KtnNMR3ePOeGpMhFnIWcHntNwB2zZxrU4/ARoaY0nLBRPPtSt907xC9muR9n6ji4NB0vJzF9rhMchXS+LRH4on6obKcX4BViHk17OVSSJZMgfyFkakMZyYg+YzGXiQOtIAqJnYEr1nFYmQvMUUXoYXv4vDCC020vWC88W8bVfEjZWM0WgX4WVCzlkOLK4NxzxUc5ZlP1cJf9Yw5vY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcdo317kLCU/tdRV+ajdcSP4sWfSSsaNfxlXaH+y3P0=;
 b=WqBSyGDnP9NaXep8WzsSxuootJhrUSpLMO5LCt6qugaI1AdTsqjxvQbvcm9Oih7HU1b1Er9YtUHKOnDb1DEv9mJ5ds2hyLXvp3uGf1q1aNMCIm2TQtTj8wJvfbCplzfLTWbXBwYrFIgp6yfmHDCc5ta3Yvz2m4dUFVEKX0aq8eXBI13WEG2JK5eQOdBvANhCOYMkoj5/xHfXUdw2VLEbgJdLZ26uE50k+gAByHDuKjCf/zfQ//Tz4t9es/LmwbV2e1yOEmPHKEW/fOir2bEz053qjZbfppVJ8yyIAdmjBs8Z7mia+D8l6irCmFf34eOKL7LuVCKkIbEZJBr5vv5dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcdo317kLCU/tdRV+ajdcSP4sWfSSsaNfxlXaH+y3P0=;
 b=dIE2de2BuOiERJm73r3pK+5NRlbBqHGy+YgnkqTE1VuxBiNTWiiI6TYH3mCsiAPgLww6pFWSZZ2fPMb5FApN/aD0LatX28Jzs4Uvw9jtyI6w3WrFQZw2h5V1VLEezuPFv39hx60ncSomdN4wEKEpVFQU2plBkWcyBF3p+s1pkgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Thu, 29 Feb 2024 07:33:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:33:30 +0000
Message-ID: <383ebb6c-b50f-4fa8-9555-e9b77c5a9778@amd.com>
Date: Thu, 29 Feb 2024 13:03:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amgpu: Check return value of
 amdgpu_device_baco_enter/exit
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240229061941.1970301-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240229061941.1970301-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3a4557-db81-4917-dc78-08dc38f8b9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kkvrMV34h896mi1+rSSKcoPn/EDU1p9e0GIYktfbUyDHFN+DtT8oEeBMjdA3TfQtpZBMl+4y4tYU1DFB/rE0Y0CeY/KWZko7Jc8SfMMusUnr9KK1X2N2ouDYkYyPebh+zDscXvnTrRLxTuRUPathBKn2IT+RQfNn7yYcK4hm6Et92B1CqvDywFLNSRCaFnOOhgf8NO6fliGmVLBzmW4pyw6EBpNFWwgrfOc+RWcXqWlFsFf5K2ztCXbL/rOdeh2jXBv8cOJm3rt146EReZ+10Ayn8DSfMUbCaquc4KCWjuWvrRy7bq5ZcmHAn91Vd4tu8+lSwVbvXUiPKP2jn6mJJUcdx2hKtB3PAB9/D5VrUHRHGEaHMq0lPkMSvTzj9le36LUAUKsl4lk6y+srCDkzK8EyaaDVhr7pNbP7epi6BG0BsfKNoYMz2OKGM/mo3+CXLHGMD3/yGFITrKKgru+znTE7L5eTouPl1eUEhqlFHfzmjnCmO8yG3IgujdMYT7LH2I5br5Aawo06wbojs0ag4AwKVD1vm4zgTvABGUEP3oD/27bqnPL++52VdU9rfuOWS6Cs+ouTde2zt1Il/hVQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU00K2RjYXlHeXQrbUlvYTFkaEZVSitxK2VJQzludlcxOHRJSzhjcDNYSnY5?=
 =?utf-8?B?dVZuZUhqYnh2UVNIcEFzRFhNbEJpNGJMamR5RUk2MDZEdmdQQ3lFQ1NnaVh1?=
 =?utf-8?B?ZnN3UCs2YlRuRmszenQrM3pwaXVIQnBINHpKNmYrSk1xdGRwS0gzdGNkdkht?=
 =?utf-8?B?WitiWWcrVzU2QWFTa2hUN0JQOVhGdlZQbS84aStxNUdtMlR5aGVtcDhMN3Jm?=
 =?utf-8?B?ejB6cUtINzhHMCtkTm9NSThJR1p6UDE0am9nWGUwRDMxZklkc1JEaWh0ZVN4?=
 =?utf-8?B?c0NVeTI2Mnd3MndSWk1WYlRrSzNhVGJ2YmdqZmE4VjBadmpCUTdYM2xTNXZj?=
 =?utf-8?B?ZGVWZWRITWN4dW5EOW9lbisvd1M0UHlSOUpYcHE2MHR6TTFNVU5OODBiclU1?=
 =?utf-8?B?VXZaK3hvK1hEZ01CVktucVVJSEhlN1p1VTRuSGxzaGdNdzg1NnBxTFZhUmNJ?=
 =?utf-8?B?Z0tYbHJQeVMzbUpjYVB1Z01wZlIxWU1ZU0w0Y1kvL2ZGYzg1RnVaR1l4Nklm?=
 =?utf-8?B?dHB0aVNibFNMV0JrOUpKS3Z1RFVpZ2Z6OXM4alRCdzRGTGdoMGVFZ3RhK3ZP?=
 =?utf-8?B?WWI5dEo1aFNsdmg4RVo1VnB0dFBLZzRIRTJMVmFqOEY2NDNZTWdWNEJSaHdX?=
 =?utf-8?B?U0kyektCQ29vZy9WcUVMSDdzWHFyZ1IyVDB5Z05sQnN0allYazl0d1JlR0kv?=
 =?utf-8?B?NElnL25wdlpQYkhndWhlK0NIdkF0enZMdnJBdDRIM3BHdmhQUTRFem5UWXhh?=
 =?utf-8?B?S1l1dndScnY1RktaMGliMGxGOTZ6VGlSWklDeGRXRTd0K3ZpYU5zT2k2ZGZR?=
 =?utf-8?B?MUZTWnpMNEhkbzNaaENuczNTK2hiUGgxNVVOSHhUNjQyR3VPbTczcE8wVkNn?=
 =?utf-8?B?WVNIZUtRQllwb01yKzJ1WjNHQzQrU3FvVDZsQzRpdkM1RTNYeCtsUlZYbWVQ?=
 =?utf-8?B?cEZwQS9BNTNXRjJ0cjZCWEJOQjU3bVZBWlhjVndEdzVDdVZ2cUF3UzF2ZjZl?=
 =?utf-8?B?NDdTWmFmN3FIbHM1NExOc3ZIdUl2VEFtL1lIS1VuNXViOHkwTlphTVF4eWxE?=
 =?utf-8?B?enFzQ05sUlM2Y1pTWCs5dTk3UXlmVFNSamNpdDM5R1hoNFJlRzgrRFNFaXB5?=
 =?utf-8?B?NkVMMGZ5b09YWWR0dHlrZm1ZN0pTME9VaUVPNlFkQmJrUWt6VFVqeVhhdWNz?=
 =?utf-8?B?eGNWRGdoUXRzK3FZRVNSeFpBbDRHdDlsMDh5OHZNZGxQNS9lKzREcUxzNExu?=
 =?utf-8?B?ZHNLc0pnT3o3OFN2ZVpLT25VbVczU2dTblhYOEhidTN2OXJVZFAxY3ZJWUln?=
 =?utf-8?B?UlBCU0NCbkxraXhCRW15b091eStqU2xWWXJnZFVhUlFjZTcvMlE5bGJOT3Vk?=
 =?utf-8?B?SXNHRVNVdGN1K2dYWkdmLzBCYk5FcEw4WThjaGU0aWRDb2Q0NjJmRUJCSXZF?=
 =?utf-8?B?VXNPOU9DTjNhYXVYNmE2czltMms4MmdOdG1yOWl5a3ZINzFOWkkzRVoxMVR4?=
 =?utf-8?B?MHk2bUxVNHVhNUxRSzk2ZW8xaFI5akRlbm1SWlRFZXJlM3YxRWU2a3R6QVQ3?=
 =?utf-8?B?bDdJNzRtYVVXeWc2WVZ1OXh6eWl3ZmhRWlMvd2RsYXNiS3JsTWdQVU5RWVZx?=
 =?utf-8?B?azhuY3R2UXZIWXl4N3QzL3Q2RmhhNEd0UjBFa2ZCdUJ3TkNMZ2wzekdSRk16?=
 =?utf-8?B?aEViZk80RlQ1bzl4MW40TTRjaVlFeUFpZ2RPbjdWdnZQTDBJNVR1b09hcXc2?=
 =?utf-8?B?eWkwZnh6bldVbGcwRWxNRVJ6alRhbjBJQ0FpSXZrYTZCRU1NSnhiR050MnAx?=
 =?utf-8?B?cXhQL2VSVXNzTE1XVGhOTEJJTnhRUTBjbE5OV2p6QVhZbGJtM3pMWDJtQkp1?=
 =?utf-8?B?Rk5LRkVQOTBUdlprZnlTYUJGZ1VNVk5lZDVmVVpYeXhMY0VpOWxKUThQR2Ur?=
 =?utf-8?B?d1BjZE1Xa3BZek51WUZpSmZvWTJsU3Rub0lWMndKQlRBT2ZBVCszZGVDQVpi?=
 =?utf-8?B?aDI0UzV1S2tyNXN3am5WY2tRSHJnYyt1NlZnQkhDYzJITEFTWTloL2Zsd3JO?=
 =?utf-8?B?eXg3VU92YmU0L2RIR1AvenZDTWwxRTkwOWxiZXNnaWZFNkpRbit0SThHS0x1?=
 =?utf-8?Q?bdVB3nObx6LWb0j54qlQvE2CD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3a4557-db81-4917-dc78-08dc38f8b9a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 07:33:30.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg1r7/vmITdZY0teFrR6qklwXVZ7SGYfU+CRzF6WlaQVEA3gKvLkpU3kHcj34dtv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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



On 2/29/2024 11:49 AM, Ma Jun wrote:
> Check return value of amdgpu_device_baco_enter/exit and print
> warning message because these errors may cause runtime resume failure
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e68bd6f8a6a4..4928b588cd12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6000,15 +6000,24 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>  {
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +	int ret = 0;
>  
> -	if (!amdgpu_device_supports_baco(dev))
> -		return -ENOTSUPP;
> +	if (!amdgpu_device_supports_baco(dev)) {
> +		ret = -ENOTSUPP;
> +		goto baco_error;
> +	}
>  
>  	if (ras && adev->ras_enabled &&
>  	    adev->nbio.funcs->enable_doorbell_interrupt)
>  		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
>  
> -	return amdgpu_dpm_baco_enter(adev);
> +	ret = amdgpu_dpm_baco_enter(adev);
> +
> +baco_error:
> +	if (ret)
> +		dev_warn(adev->dev, "warning: device fails to enter baco. ret=%d\n", ret);
> +

This doesn't look like a real case, moreover the warning message is
misleading. If the device doesn't support baco, driver is not supposed
to call it for runpm purpose -
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L2664

Thanks,
Lijo

> +	return ret;
>  }
>  
>  int amdgpu_device_baco_exit(struct drm_device *dev)
> @@ -6017,12 +6026,14 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>  	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>  	int ret = 0;
>  
> -	if (!amdgpu_device_supports_baco(dev))
> -		return -ENOTSUPP;
> +	if (!amdgpu_device_supports_baco(dev)) {
> +		ret = -ENOTSUPP;
> +		goto baco_error;
> +	}
>  
>  	ret = amdgpu_dpm_baco_exit(adev);
>  	if (ret)
> -		return ret;
> +		goto baco_error;
>  
>  	if (ras && adev->ras_enabled &&
>  	    adev->nbio.funcs->enable_doorbell_interrupt)
> @@ -6032,7 +6043,11 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>  	    adev->nbio.funcs->clear_doorbell_interrupt)
>  		adev->nbio.funcs->clear_doorbell_interrupt(adev);
>  
> -	return 0;
> +baco_error:
> +	if (ret)
> +		dev_warn(adev->dev, "warning: device fails to exit from baco. ret=%d\n", ret);
> +
> +	return ret;
>  }
>  
>  /**
