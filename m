Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDA4C54E60
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 19:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCFC10F856;
	Wed, 13 Mar 2024 19:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HWvdHbnw";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3779B10F856
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 19:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw2HdVHafUfus+dAClMs2geT5Kj+zwFV/UPyz0QnQx2UU9J9Y/5BO00KkVK5RPPyUVY8cVcm7sS6QSy2xj3BJ0X/mb2Udko9qEYP6Sf46ph5P/W27padwaCHHOOmdaONafMNnqjUYgwTraKN9g1kXA5iqVePNheKQ2q9nn6ICs0lBfmgYu8LeJXaMQuymLW0UAGiMy2oyen5PkCj6VXEVAdAC78vDPYiynv+G1mOw9k3SUIPUeUwCpBT/deu2wK153rnSsHGBf7mfTxQJ4cUHAzokTGYSl+S0pGCrLM4OT4lRpcvNEHLGyJZpNErf2XcqmNDwpRk6sJrJiSpEepWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0UMyHO2yeFcukHkwN8mbVPddaOtrSECyeb9bSK5ESw=;
 b=cXFrMoTkKE5OltYe9oXuPYyP1kv1f5RDaZVOEj7i8WxxTeHPT8zniyLiT7/opZp2lc9TQny3+ty6eTkELc66wDKDegQoYUiJ0LE+w/LqNIZAfWnZN6H+Ur8JKV14hdu6vUUsrF4aUj5Jo+vLd3l5bl9IQV63MmxTVJ9LPv8PBjqfd+4D+YfKRhdf5umpYnrPxYJi/n2cNitwKz3vJG0am4xFRM//PxLaMNfLzLma+27FjEpBPaGs6HAGxjv5noiSkaRyODg3/YHGWhmcJ/XiQRf0GQSe5bqLAuWmTpag/93UtGufn3iq/lEjgHkc9Yj2CgDhQFT9s67p5Hx52U0DRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0UMyHO2yeFcukHkwN8mbVPddaOtrSECyeb9bSK5ESw=;
 b=HWvdHbnw+YPR7xYpuo1ddVPRthVkvJq9CLP92ajZrodbCZvqNGRE1WQG9gxzhrdOzNxq+oBtpUg6xHPzP4tt32yur1rzgGfRJHDnxPgRZkmcYYJLKMM16erI6JAnhs9lE4QZvExGwxug6Ak3vFsWvTHFdACHlWMFSKP3s0fUNQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 19:49:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 19:49:18 +0000
Message-ID: <aec029aa-8ceb-4450-9139-27c7dda43f98@amd.com>
Date: Wed, 13 Mar 2024 15:49:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Do a basic health check before reset
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20240313094132.668370-1-lijo.lazar@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240313094132.668370-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcf9196-caeb-4ad5-c4a7-08dc4396abdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGxAh8slBHarYpuhJyVegdx9U86mbqEsgqjme2P6dQBBdjFqJ0HWycyq84N4KbYXMjL10MgJn74ytI0o4hokHswEHgWayIBI+SNbiyYTFxQSpSGLd/hfJo7kgg1XJRToOhgW/uCj8dglBds+BG+4Klzv8t29Ry+iTYcHpE+6yXoYt39IFVxNFXHjd4anSyfReS1SwSiibw1OTeswVTNN5ugL3OM3NZzWct77LgYX8fjWXfUaCiCvzPuxgRH7ZtojWj3KKPiBrwMxxHjFHZ3yBTQWPc4D0PCxh49Atw2aTErKMcRkR1ypN56CkFR7GkjTilXySjYk5exgdHtg6ELwlXZubKLlnsj9jAX5htNhlZGDGBH4cZ50TpaVCkt5s94Zm5IYjfG5LO+B5k4IWK8kYCbRPj80wKoBnYaBRNPmWMB0GizHEqHhOkhV0YX/BQp9VAesIfAXwlDIhGo3IJTIX2WWzpJVyZS81AWJlOCZJnYeVdlyIEF3QxTFqkL99RXWe/rOIpdHdooHW3K+58rvgjg2FQ5V3E8W+CfdrrIPvSWH/oW8MdACDBHtKMjAomiQuQxgkpColMd8SXZBckZVFmL31/rEgYXYmyOKqmImdaGn+ZIbt4/ggqfEUsgAc805wTBrCxzkkVuXq4dAlv42vXtLCCzSTS+LvbosALq4FEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWVIU2E1Nm85cEVpZWxKdm9wNDlORWd0NjM1dUx6VWZNVUJZOCt3am1reGJY?=
 =?utf-8?B?MVZrdVJHeFk1YUJJWWVYLytFWVprbFRRY2VWUzFyNWNBZGZOMzZRY2MrZzlu?=
 =?utf-8?B?OGtpaGorY3RuLy90b2k5TW9IVkxkeTM3UERmWmtyRDhNVEpNYTFBNy9sLzlI?=
 =?utf-8?B?RnI1RUUzU0ZpcHcvU0ZTNEVhMjJtcEd2UXJ5blQ4Y1dMUDhBMXI5eTJaQVJx?=
 =?utf-8?B?UUNCT01SUVN6YVdPMGhkQ3RsejJSY21oWGUrenFQZE5Dd3o5bFNETGNaZGV4?=
 =?utf-8?B?Z09HLzY4R0tEUjBrU0JkcHFuWHpmTzNWaFF1c2ZHNE1wRzlLRWs5R0hxeFdh?=
 =?utf-8?B?TGpmb0xnZlV5YlhrV1c2eVVzTXJ0YlNNUkcvODBhckREd3BkN09MTFlJbnUz?=
 =?utf-8?B?SFFOeThWaEs4NDhVMVNuOENPdnBGaGxZZjlzamFrdVBJOHVUcTJuUEtDaDhN?=
 =?utf-8?B?OGZORXVzTGk5Z25TZ3J2Wm5RNFZGNFdxQUpYRTcvRlpMMm9rMW5EUnRjcUVq?=
 =?utf-8?B?bm5aekdXNVR4Y2VVUFJ3WHZQTXlVRkxZZFJxOFN6Rnk4SXRqZ2tHbTZET3BY?=
 =?utf-8?B?M0tLM0ZzdVhNSmF2OE5vRFFmUDN6MnEyMU0wN3VFRTcvNE5sVlo3SE4yYkFG?=
 =?utf-8?B?MWZpbEY2b0pSOUdSZXNZVzZiK1d0akw4ejBQY244eTRhTWMwakEvQk52bk5w?=
 =?utf-8?B?bCtaZjQ4NmR6VjhJd0tlTE9IcTFBOVJ1enVKem9hUHVFanJ0dU8vcDZuWHhh?=
 =?utf-8?B?QzBVT1loOWFpWHN6TzRmdkZoVC9NQTlCZFJiV1draUUrVE82bGhTaW05Mnp4?=
 =?utf-8?B?SWtCeFYrWHAxRi9mNW9NQ0NQck5xbUsrV2s1aldIMzRoelRvVlNHSG00WDRs?=
 =?utf-8?B?ckRFOEpQUklFaWZObWFVNFI1NGp5M1M3YzQ0QXpZcHA5VElRbFgvbVd1NU1y?=
 =?utf-8?B?NXRNaVhZNVlld3VNOEszVld2L1VlSHk1aUtYWmVmY0craXBDclNwbEltcFZC?=
 =?utf-8?B?QVo0ejJSeUJlUzMwbjNBdzE1V2p4QTZ4VWNvaHh2dmF6ODZHQUlSUlMranlv?=
 =?utf-8?B?cG4zUU8rWW1JcWZiMzZ5U2x2VW9WNjJORDRydjZNR0xTNWkxSnZjTUlRY3Ax?=
 =?utf-8?B?MHJaQ0JaNFE5YjE0R2NBbUdGK0w0bDJmcDdydXNqdFF6S3FUR1hETS9vTm5Q?=
 =?utf-8?B?dFRXa3BkU25rQVpYT3JmQUJndzF4NWdYTG4zd3pUczd3YzZvWW95ak1QZ0dn?=
 =?utf-8?B?OFZtVEZ4b2xtK0l5NnV3enJhZSsrMXlRQ05iUER6elgzRTNiT0ZQN0szNSty?=
 =?utf-8?B?VE1vLzJpV2dhSkpOT0JGSU11Y0M1ek5iUGY5MjJlL2FkTHRWRklNMzBoUzVu?=
 =?utf-8?B?eWlHUGF4YTRhVkpSaEN5bmNHRUZCQ0NrZFJEVkg3a3AxampLZnplWGMxenJ6?=
 =?utf-8?B?Qml2UjBnd0RYcFpWdDIwcTFNVDFweUFrVUdkSVZRRzhXV0k3bkVtenF6bUQy?=
 =?utf-8?B?RG95aDRWVXE1L2JjalYwbzNzTWZaa2Z5eFcyWDJWMjV6QnJiYy9YY1pjMHJL?=
 =?utf-8?B?UmtydEVQekc1NUFUdjBtZHZ0WkVSeG1FbzdWajhqMEZqWkR4L0psTGdXMS82?=
 =?utf-8?B?OHNhR2N0YUxmb0VSRHFPcHplOUJJSjRYWmttK3VHT2ZMK2lZRVF1Q203UjJQ?=
 =?utf-8?B?QVBOMUtWb3A4bTZ1S0xzdjkydU9tVXZiZW5mUC80ZUp0cjdvcG5qdG9ySVRW?=
 =?utf-8?B?K3h4NEk3cjU1czNyNHEvT2JoNWlYUGh0VjdPT3BpOHg2Mk5kZmZzVURUWjlG?=
 =?utf-8?B?T2Fxbm10b2k1c1BxSEJ4SjFDaVNWSmZ3SW80TWp5dFRhYWplYm1xZlpadVhS?=
 =?utf-8?B?RGMxbmh5Y1Z4MVc5a3o5aUZMcm9hcUNHcWtBT3R6QkdKTm04NlB0bHU5ZXBi?=
 =?utf-8?B?dzFudFJESFVqZGg4VWV5WEF0RFN1OTVIWEMyVENTMzVVVWhQZlk4OWZLMHhM?=
 =?utf-8?B?bkRZTjdZQmhESFpFdnJEcDMvbmV4b2tmUHZjWkVqOWUwcW5FZGNUR2l1enRW?=
 =?utf-8?B?MXhieEc1aWI0cGU3ZUh0bzk2RGp5eHI0bUJ0L0xBM3ZlYWdRdDF5T3J2cmdy?=
 =?utf-8?Q?dJqjr2vG9Aw4PwYPKHlqXzsAU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcf9196-caeb-4ad5-c4a7-08dc4396abdb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:49:18.8384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9emD7cIkg4+xUAOFR9YWcDL5ZhwBhh29zUDraDBcCL2YCH+81rdcbe7Xiz8uvcwvwNomcHUQGUCiDC8TEf/fLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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


On 2024-03-13 5:41, Lijo Lazar wrote:
> Check if the device is present in the bus before trying to recover. It
> could be that device itself is lost from the bus in some hang
> situations.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e9454e6e4cb..b37113b79483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5536,6 +5536,23 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>   
>   }
>   
> +static int amdgpu_device_health_check(struct list_head *device_list_handle)
> +{
> +	struct amdgpu_device *tmp_adev;
> +	int ret = 0;
> +	u32 status;
> +
> +	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> +		pci_read_config_dword(tmp_adev->pdev, PCI_COMMAND, &status);
> +		if (PCI_POSSIBLE_ERROR(status)) {
> +			dev_err(tmp_adev->dev, "device lost from bus!");
> +			ret = -ENODEV;

You could just return here. What's the point of looking for other 
devices if you're going to return an error anyway?

Regards,
   Felix


> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>    *
> @@ -5607,6 +5624,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		device_list_handle = &device_list;
>   	}
>   
> +	if (!amdgpu_sriov_vf(adev)) {
> +		r = amdgpu_device_health_check(device_list_handle);
> +		if (r)
> +			goto end_reset;
> +	}
> +
>   	/* We need to lock reset domain only once both for XGMI and single device */
>   	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>   				    reset_list);
> @@ -5772,6 +5795,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   					    reset_list);
>   	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
>   
> +end_reset:
>   	if (hive) {
>   		mutex_unlock(&hive->hive_lock);
>   		amdgpu_put_xgmi_hive(hive);
