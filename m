Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54D8C43602
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 13:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4A710EC9B;
	Tue, 30 Jun 2026 13:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yYi2rb4/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A25A10EC9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beaK63LVfv34ELHSsQK+c8QUZvy/enVlAbSS31hBHOZyoZI+Wr4UQ3Kn3G16tExlqYJ8/zjD9kRdONqymmwBjyHZy8j/ILZ+el0Mq0PQasCOTXhTCeQKI8OTJHX5Q5kPWG+3UYcPAn658fFtlrilHORs9v3z6hyBLfQF/t+XMWf4J5BgoFg/mkB/7/PBNwcIG7xXMbFVeJ+6QwGHKDSyTbpHXmuSeAduyIGPKelxMVvl9tXcz5LQRH068W2S3okrz1mWshI5t5SdWwG2RLcEsBMfKCy8rhwBMbefdNGHnMTZrQPgQIe9+KOOlrJ3JFyB+fTAKW0rULW9qBS76lxbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2VOqvW/lYrxPENft77d+4biO6Qk5JtTF04FJy/GhyU=;
 b=Vd8eraAhKw5CjHl6NcK1iFLn0WjYJgLcZidU8TPbzhS6cRxuA9JW/gsdlLiQkm/kgDNbbk2nH8DIM0s5lZpbj3t5POE2Bxo3vlj7ZtlqKGCpMDu9GpdFgpFU3f9EyjE4/CrZdJCGyFRNOW0lSDrAouIqnJadjde62CA7ZUQdDyug3FxMFtbiCFYaUAoiT/5V0RPbdP7bJJmECUeqY0B489sxO3aCPKW/oP4w9zoY5ECg4oYIbxJFZ2yiotq4AcP2PJ5JNGbtHByuL0DDTRHxh9EsqGS+8ZiU1edTnHRQf0joyL8VYsZ7DmFgypEuH+GyfYqddPabBFYOc7ZyBQfeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2VOqvW/lYrxPENft77d+4biO6Qk5JtTF04FJy/GhyU=;
 b=yYi2rb4/quWzztu56oDQcUsw5Epe7+s2tTknmWmAboPTzYQkmaaM614wAM9ELAAVawsaZbDRYDKk56q59IYJDC9OSrT9bZAECRVC2gpAVo//mmcsigS2X4Ghf4/mMTuEUuT07qGBL2OoLew0UvVSy7ePkq75numwGCrAxkkjgvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:18:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:18:28 +0000
Message-ID: <67d1e917-9c35-4161-893c-51d3490a4e04@amd.com>
Date: Tue, 30 Jun 2026 15:18:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/4] drm/amdgpu: Add driver managed buffer copy
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
 <20260623141257.66086-5-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260623141257.66086-5-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:408:f4::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0ff87d-f69b-420b-e979-08ded6aa12e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|11063799006|4143699003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3sKUoOXNl8XFyxFhfJaj19jDnuVjGkLY3GaeNd+uNSkHvJzODypzbAcuS8KZdJVZdnnfNP60PdDnLrmc/WcG2QZFY7RJ5L8HqcJb0OPZB5KHLNIkMXkfpU2qlXY4+JzQYuBq7Zsk/KSbFb4fFa+G4wENihO87mc2ZsuMGY5CXpLdPc7A8PaBRlYrj32D4DwKAhDTzfpoPdVEXt84hxTVZjNRr4lnBizfQ2BWRmOst9f+6bUND5YAGfV/UFMK11xqWP43ZvFjwNkLPYzFBh4fn5cEVodcOy++QUKl7ZKzz+W1w3rglzOxKI1XbbiQOTkvisfyA87wUFLYYfvO1v7qaob83wMM7oQzjsw6MuBc5B7bhrz46iZqj6eO32xIPT7ZcSf/vc6VDW6HvElVAi0dpmB3MbV9FZE/v7gWfLjiOsD/+wNutwInvsYzszFbe6GeZXSgbznK9jKslD1Par5qfG3MaN2Yb9qFpSZMt/Ok/m/Achfd/TqWR71WvmhXGuT81okLReEe71AU2wjv5F5PZ6QYwKw8WaxO2KGvoV3aBbWu0TsBw8iGTHr4oZQzxkv70CR1TZ+H5hunpM/XQcBWsONoJugZNTXo/3AvqXteJxmy8NwDjWbbYACE9y0CsjRF/LdeH/Qqp0GmMYOIaf3JF1tthdpdevpQrETpVEDnnYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(11063799006)(4143699003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDUvYjMrb1h4aE95VkQrb3Bmcm1uTXNCQXh6Yk9vY3gwVDNyUkdwV3cwcFVP?=
 =?utf-8?B?aHR4dy8wVy8vMXB1ZWEwTGJBbk1tamxPdDdUZFZqTEtqQmdYRkRtWVgvZnVE?=
 =?utf-8?B?RXVHK2RkZ1JYSVg1eXVhdURrUFNSdjI2cGNOYnRjQjNHY3RCbXgzNk9sMkY3?=
 =?utf-8?B?WmZlQ2dJVXVRdEJFQkxYV2o2UXBLL1Jzc01ZT1dTMmpMRDZucTZDSGJrZWFq?=
 =?utf-8?B?TDdLS1pTdjM2TTIvLzRGcFBISWJqKzY0NFZsZk03aEZpWlN5OEpVZVNUZFlQ?=
 =?utf-8?B?cDFKNmphNE9wQmhBVHo1RDVDUVFWUkhhWkIxaC9YVU5MU1ZFOTFPdmNYVm9z?=
 =?utf-8?B?WXhRRWZ4NDZ3eTRyL21WaU5rbDROMm82aTJxKzQ1M1BlMVh0dWQ5QzB6U2pY?=
 =?utf-8?B?TlNRcU92UXV6WFdWdUdpRzI2Unc2dHhBMno2bEpDQWgyYStkTnpHY2hWZGUv?=
 =?utf-8?B?RUlBRUFxK2VkSktUYktCZXhSZ3Q4TVhxN2dQeENuZE44M3JoYWxWTy9aY3Vz?=
 =?utf-8?B?QkRmQW9QWVg1UGd4MDZzN1JKTGp1Qi9IQTRmbHQrZThiLy8zcGd6SlIwRHY3?=
 =?utf-8?B?SWVJangxT1MyYmtNTXg2YlhRL01EZmNDN0lCazNTNTl0WGJtd3EzVzdlOCsy?=
 =?utf-8?B?NFdYSEhBVFN0T0VFU0ovdHViUjdMQ2tLbEdSdmFZRG1FMW1ralZxS0xyOWt3?=
 =?utf-8?B?K1JXWDNzaGpGY1BtaEtuY01WQWNLTDd1TTBRU29QMWl6WnlacWpDZStqakYr?=
 =?utf-8?B?dnRWdW1hNEVXOWt1M05KNGk3RWRHY2M4dVBPdW81Ni9lUFZ2VDlUK1p1WUwx?=
 =?utf-8?B?QWRtaUlzaU85NVdIQ3lBL3N5N1ZlSW9XeUZTZHpZQW9xRWRMVFNTdnp2SDBy?=
 =?utf-8?B?ZWlVSGJmSHhVR0FLU0MyQVloYkViT2N0QlZZOUZMUE9Jd2t2SkQzWHdPQlhP?=
 =?utf-8?B?V29mRFZZQktTNkxKWE1rRElscmxkVTd2Yk40T0VTbHFPN0hndG9NODZUZWJN?=
 =?utf-8?B?cUxMK1Z1UmJuN011QW9FNExUMzNPVURxNTlHVGlDdUJ6eXIvZHd2QnlnSC9t?=
 =?utf-8?B?amJZYmcyWGNrSXo5NUU3cVNCZGY5Y1lETHFqcWRUZ1NaYVhQNUNYNzFBNFVQ?=
 =?utf-8?B?Y0JVbGZBazFPbThEdTZCNE5hKytzYWF0OC9GeW1jeEl0NnQrZmxZeXRDZjJX?=
 =?utf-8?B?cmNPTTZ5QThueGwrVEg0c0Z1cVR2NklYKzdpbDRUZ1d4b1BHMDVNazNzZXdk?=
 =?utf-8?B?aGtuSlRWcHZNbzBlanlqQ2ZCN0Z4LzJETXNEa0Qvbm00NGM0YlZqVTJrZkYw?=
 =?utf-8?B?VHJZclhlN3I2dW9aNDUzc2I4alJMUHEyTUNQSWZkYml3Z0ppTnI2d0x2ZGJ5?=
 =?utf-8?B?OEdzbWR1QkdaODFYMVlnRzNmTHQrWUlnZXZua0NpZElyd00wTGtiQno2Ykhs?=
 =?utf-8?B?bHZpTkZYbWlkQkl3VFFDRkN0L1g2Qm9kNC9tbVJZZmJlTzB2andySXFJU0dB?=
 =?utf-8?B?YXA0bjQ4WVRJV0NUU2UvZzRNdk5DdkpndFpSR1U1N29Na2VRbmZEcmN2d2ls?=
 =?utf-8?B?M3dLdjM3ZFIweXZreHhqTldRZDlFNVhJVVh3QWwzYjJ5eWZvOGF4U2prbmM0?=
 =?utf-8?B?VjRTZGVLMkZOQUNaUHZZa3pZUm9nNVdubFVadzBFR21ESnlicUY2MHdyKzht?=
 =?utf-8?B?bjJPNU5sSjNnajRBeGt0eVVTWGlZK2RnWUUxblhMK2ZaQ3YrYWo5VGJoajNn?=
 =?utf-8?B?emJIcGpQZENwT1hYSzVmanVXcEFsUEwzWDZYcUFkYm90Sk4rcEUxYUUycFB2?=
 =?utf-8?B?Q3FQSVJwK0Y1dlRVNS9McEZGdFZBSmozcG1CYkFFK0Rtd3dya0dma2tUejZa?=
 =?utf-8?B?N0xqR0NjSVVMOStBbDRXc1ZlS2ErREhnODNsRHFUVUk2elNGd05Pdm9XRG5J?=
 =?utf-8?B?QkVxOE1KdUdkcVp5QWprSmlJOExSV0ZKeTIrSXFid3laNWFMU09jb3FjMldH?=
 =?utf-8?B?dnBsY0FkMm10aUttUlNKMkhTdW5yUzB0dk4yZ3Y4ejlVOW8wOFJIbEhvcU5W?=
 =?utf-8?B?VWlFc25GR0VOMllQYUQrTkpwZjRMdVp6K0pVbmEwd1I1VjBaT2Z1MzVHVm9G?=
 =?utf-8?B?THFTN2ZIMm5OU1NoUVErSVhkdkxrU0wxaHlPODZPeHNoNm1YTnBmdjFUZ2F0?=
 =?utf-8?B?OW0wOFF2elJ2TVFYTDhrbDBtV0NCMGxveFEwdHVoTnA0SkYvSVVrdHIxMk5B?=
 =?utf-8?B?T09OdmN6dDduMW9IQU12MzVnZHZpTmVqZWhhYmU3Tm1LeklGVEdlQnF0clNK?=
 =?utf-8?Q?uzYXZZrTx8LvysHz/e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0ff87d-f69b-420b-e979-08ded6aa12e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:18:28.4928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwoVuOvscMwgpvt+8qwoeYLXX53bflp7LILI241yxB3ieAdBRmSLJL/Fdj91n00c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
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

On 6/23/26 16:12, Tvrtko Ursulin wrote:
> Saving and restoring buffer object content poses a challenge for the
> checkpoint and restore process for at least two reasons.
> 
> For example not all objects can be exported as dma-buf to enable copying
> from a separate client context, neither can any objects be easily copied
> from the same context since the injected CRIU code is unaware of the GPU
> virtual memory free and allocated ranges.
> 
> Lets bypass both problems by simply exposing access to the alrady present

Typo "already".

> fast kernel copy via a new DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER ioctl.
> 
> By giving the kernel simply the source and destination handles it is able
> to copy them without the need for objects to be mapped, or shared with a
> separate client.
> 


> For now this is implemented fully synchronous but can easily be extended
> for more parallelsim.

I think that sentence can be dropped now.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 104 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  14 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   7 ++
>  include/uapi/drm/amdgpu_drm.h           |  16 ++++
>  6 files changed, 137 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index f61f0ddd3ccf..993f38d70086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3077,6 +3077,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_COPY_BUFFER, amdgpu_gem_copy_buffer_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e75026aba874..ccc0ecfe6603 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -32,6 +32,7 @@
>  #include <linux/pci.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-unwrap.h>
> +#include <linux/sync_file.h>
>  #include <linux/uaccess.h>
>  
>  #include <drm/amdgpu_drm.h>
> @@ -1234,6 +1235,109 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  	return ret;
>  }
>  
> +/**
> + * amdgpu_gem_copy_buffer_ioctl - copy buffer object content
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_copy_buffer
> + * @filp: drm file pointer
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *filp)
> +{
> +	struct amdgpu_copy_mem src_mem = {}, dst_mem = {};
> +	union drm_amdgpu_gem_copy_buffer *args = data;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct drm_gem_object *src_gobj, *dst_gobj;
> +	struct amdgpu_bo *src_bo, *dst_bo;
> +	struct dma_fence *fence = NULL;
> +	struct sync_file *sync_file;
> +	struct drm_exec exec;
> +	unsigned int e;
> +	int r;
> +
> +	src_gobj = drm_gem_object_lookup(filp, args->in.src_handle);
> +	if (!src_gobj)
> +		return -ENOENT;
> +
> +	dst_gobj = drm_gem_object_lookup(filp, args->in.dst_handle);
> +	if (!dst_gobj) {
> +		r = -ENOENT;
> +		goto err_dst;
> +	}
> +
> +	src_bo = gem_to_amdgpu_bo(src_gobj);
> +	dst_bo = gem_to_amdgpu_bo(dst_gobj);
> +
> +	if (amdgpu_bo_size(src_bo) < amdgpu_bo_size(dst_bo)) {
> +		r = -E2BIG;
> +		goto err_sizes;
> +	}

No sub range copy? I would expect something like a ~8MiB transfer buffer to copy a 1GiB buffer in chunks of 2MiB.

> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_obj(&exec, &src_bo->tbo.base, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto err_unlock;
> +
> +		r = drm_exec_prepare_obj(&exec, &dst_bo->tbo.base, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto err_unlock;
> +	}
> +
> +	src_mem.bo = &src_bo->tbo;
> +	src_mem.mem = src_bo->tbo.resource;
> +	dst_mem.bo = &dst_bo->tbo;
> +	dst_mem.mem = dst_bo->tbo.resource;
> +	e = atomic_inc_return(&adev->mman.next_move_entity) %
> +			      adev->mman.num_move_entities;
> +	r = amdgpu_ttm_copy_mem_to_mem(adev, &adev->mman.move_entities[e],
> +				       &src_mem, &dst_mem,
> +				       amdgpu_bo_size(src_bo),
> +				       amdgpu_bo_encrypted(src_bo),
> +				       dst_bo->tbo.base.resv, &fence);
> +	if (r) {
> +		goto err_unlock;
> +	} else if (!fence) {
> +		r = -ENXIO;
> +		goto err_unlock;
> +	}
> +
> +	dma_resv_add_fence(src_bo->tbo.base.resv, fence, DMA_RESV_USAGE_READ);
> +	dma_resv_add_fence(dst_bo->tbo.base.resv, fence, DMA_RESV_USAGE_WRITE);

That should be DMA_RESV_USAGE_BOOKKEEP. READ/WRITE are only for implicit sync here and we clearly don't want that here.

> +
> +	r = get_unused_fd_flags(O_CLOEXEC);
> +	if (r < 0)
> +		goto err_put_fence;
> +
> +	sync_file = sync_file_create(fence);

Oh, please no sync_file!

Use a drm_syncobj, e.g. drm_syncobj_find() + dma_fence_chain_alloc() before the copy and then drm_syncobj_add_point() when it is done.

Regards,
Christian.

> +	if (!sync_file) {
> +		put_unused_fd(r);
> +		r = -ENOMEM;
> +		goto err_put_fence;
> +	}
> +
> +	fd_install(r, sync_file->file);
> +	args->out.fence_fd = r;
> +	r = 0;
> +
> +err_put_fence:
> +	dma_fence_put(fence);
> +err_unlock:
> +	drm_exec_fini(&exec);
> +err_sizes:
> +	drm_gem_object_put(dst_gobj);
> +err_dst:
> +	drm_gem_object_put(src_gobj);
> +	return r;
> +}
> +
>  static unsigned int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  					   unsigned int width,
>  					   unsigned int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index 0e17d9fc665f..64529680fdad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -71,6 +71,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  				  struct drm_file *filp);
>  int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
>  				   struct drm_file *filp);
> +int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7ce9e0e194c3..fb1e4d7a87ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -294,13 +294,13 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   *
>   */
>  __attribute__((nonnull))
> -static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> -				      struct amdgpu_ttm_buffer_entity *entity,
> -				      const struct amdgpu_copy_mem *src,
> -				      const struct amdgpu_copy_mem *dst,
> -				      uint64_t size, bool tmz,
> -				      struct dma_resv *resv,
> -				      struct dma_fence **f)
> +int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> +			       struct amdgpu_ttm_buffer_entity *entity,
> +			       const struct amdgpu_copy_mem *src,
> +			       const struct amdgpu_copy_mem *dst,
> +			       uint64_t size, bool tmz,
> +			       struct dma_resv *resv,
> +			       struct dma_fence **f)
>  {
>  	struct amdgpu_res_cursor src_mm, dst_mm;
>  	struct dma_fence *fence = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index e1b3495b902f..0c3aefaca085 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -284,4 +284,11 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
>  				    enum dma_data_direction dir,
>  				    struct sg_table *sgt);
>  
> +int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
> +			       struct amdgpu_ttm_buffer_entity *entity,
> +			       const struct amdgpu_copy_mem *src,
> +			       const struct amdgpu_copy_mem *dst,
> +			       uint64_t size, bool tmz,
> +			       struct dma_resv *resv,
> +			       struct dma_fence **f);
>  #endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 7f5c4de7f9a5..b79c3d4c2ec2 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,6 +59,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x20
> +#define DRM_AMDGPU_GEM_COPY_BUFFER	0x21
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -81,6 +82,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
> +#define DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_COPY_BUFFER, union drm_amdgpu_gem_copy_buffer)
>  
>  /**
>   * DOC: memory domains
> @@ -206,6 +208,20 @@ union drm_amdgpu_gem_create {
>  	struct drm_amdgpu_gem_create_out	out;
>  };
>  
> +struct drm_amdgpu_gem_copy_buffer_in {
> +	__u32	src_handle;
> +	__u32	dst_handle;
> +};
> +
> +struct drm_amdgpu_gem_copy_buffer_out {
> +	__u32	fence_fd;
> +};
> +
> +union drm_amdgpu_gem_copy_buffer {
> +	struct drm_amdgpu_gem_copy_buffer_in	in;
> +	struct drm_amdgpu_gem_copy_buffer_out	out;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE	0
>  /** Opcode to destroy previously created residency list */

