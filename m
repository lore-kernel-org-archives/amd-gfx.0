Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D954CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F41BB10E944;
	Tue, 16 Jun 2026 09:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiTnloLS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB6410E944
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMYlVSorNKaeb3pieAtLtC4We11fwXyL6dIY9+R4EPUtllLxJK1Bpih8Aa2xxcIqR9ENv0gd2pFiquvWXoCuIZVws9ow1ENuALvmsSupeW/7/7Z0dI3w+uGOGPe+bTfc1HNPxuscc0gQXgER/aYyDFUb4giiXmCv0k5CbOcccZakDUvD+ABheGpPW8K48wRBaFEW1h7GNym8oePvAV3wgPYxP8LNzZE1R1kCZ+9s0Bevn1l/6SrpidTHLarfV2BzScXH1NOfD6Hd4zFBYkE0O05NNrs69/5holLVbFUdDsVKhFsF43OpU6VRRQl1Y3y8Nrvpk0cDv3ErLAfnzrl+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROuZW8SR5/1DXTTSeJD0yLgG9kVRPBtJiyh2YC7sQv0=;
 b=xxaMFL1dvpgUBVyauxOkM6fWtfIKLN3tVKGFZodpEmh3R1yQyuPIui0fJbhZuZegVMZP5hEhb5aVYyRnoIuiMPn86MMBeLv8xdfJIuoUdTVSkyjasZW7ujAOFg2Hi24MDmzXgktcy5nbWXSfFJO7Rdww9bUsFp6ofPGiX5GUYPxbHs1angEbwvjjH2g7CkOcZEwQ5/DGtWvauez9wdFzicqyCxZpTg92Kf9dsIL3gkF0fhzKMqXD5xbH78t8YGxxrVW0MJ72Svcnku2DrmMpO7fkqX3EEVh0FRwZK5Bt2luRM3GJuTuiwu/yma74mUr76F7ruMoPJJ7lUH1bAJzmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROuZW8SR5/1DXTTSeJD0yLgG9kVRPBtJiyh2YC7sQv0=;
 b=jiTnloLSgb2eC9dveHuHDB3rFW64Z9mTD/dRwdl9G9xUKBiqusv0V30S3mb/kqMbtOqzgrNE9puvo3jStQb12dAKXnEfmrzgjkRNdy1ztwYKTWC0CexujWA+nBUlYpUg4QPhCTdmiI5HXAbYf8LIn3PtXrhHaQ8Jw0jX/KfmRlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:09:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 09:09:41 +0000
Message-ID: <7efa87f8-1b82-426b-9570-84012b1fb660@amd.com>
Date: Tue, 16 Jun 2026 11:09:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0349.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a394b28-b1aa-4b2f-1756-08decb86ffb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: +ch4zxG8QEEHiaNFTq71ZrUSUuh+HMrX+EdoLmmozwHq7N5br+frfbdzSEPHH5/sAZKcPCM2eSlt+dCXjzW2fLoVwsRucoBcYX1BxTD3YP1mszYhLwQ3bghMbXBh5yVpH6Xb+9joLzYxVdO8bFsGBlQgYofdXP+TyqM5UhzX964+EQ4/IaUXjGmWGpsHhqF/fUyuX2O5h3KPTCbgBaZ4tG/GTAS6OJdNs+YcbAWE5Pp08oon4E5am4NQ7VFgG4T3HgS4DJS0cnEgiNGHaBWX6NH87+/TQ8k5DUlTqIJ8rlclf7l6MxblL1DezXaC/FxEKT3YU92JQbFLWV0WNVuSMe6oVYUkAVk/5ZbeL1Xa/MmJKdeVXj63iItm/hb4pCTqObsIwXyFXBi+Ud16IM1T1CvzfHDs94RU2UgtHHtFFCoUkrNwpPBWhm37PyRFjflBf99BBafTO5ESVlM6LICjX84Uc3jSJiBWwBoW3PwjdkpR7JZdM3UBigTAQOmArvlPqiXdVG4TB7ykwefBsRUuOEh6pD31vC68WJYpa49OQAfeduIsMQJ9Vi6mMQSv38/l6haHAjo2hFNVD+496+6fQbJ5tHEzVJGEeRxHxzA4FT1d+t0ZW/deo6BGet0bAkcRwVDsv3RBCNMlBcHX2V49RsP5to0Fl15/ld71A1usqUwGU0rSNV6ODvmMF7Askald
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldzaENqa2pDUEc5RGY5a01GRHdXZVJma1NhUVJ2MW9BYjIwUnhsNnhjQURI?=
 =?utf-8?B?Y2VwcFkvSHh0akJQdzJnenRQUUg1RHRsSDk4ZlcwcDZTMW5tRmNPMFhqYnZD?=
 =?utf-8?B?UmEvNVBoNmtYWlRyY0g2TVFsQndVVjBqWnpYR2RTS3ozTVp3Z29Yc3dUQllX?=
 =?utf-8?B?eTRva3hjandaSFAxQzJMdmhBM2tqVE54YkxramExOEVMOU1MM1QycEwxanhO?=
 =?utf-8?B?cDRLYUdiVmIyenNZa09MbGNNMk5KSjE0RERvd1hjV3hJbXRuemlMT3VFRVJo?=
 =?utf-8?B?RHhuRUIrSFRiMldkdWczbWlxOEd4WXh4bW5lcE55VTNkVmx3TWpKVGN2Tmo5?=
 =?utf-8?B?bndUcDAwYVQ1ai9VUkIvVDMxMHFVUFFVUUN2OEdWVjkxdkY4U1MvL2J6b1c3?=
 =?utf-8?B?cEVRQnR2eUMybG5Db0hIY3FvNnVkZFgyVWxucG9FRzNiQWplOTQwTzFBeitY?=
 =?utf-8?B?dk84aVl0ZzdmV2FzUGtnRk81eU1UQU5PQklaekt0RGYxNUtVNFdhUWRpZUxt?=
 =?utf-8?B?VllDMTQ0cFNXVFFIdkRMRFA5WGxKY2tLTS9EektZeEE5d0llQ2JTb2Y2YWo1?=
 =?utf-8?B?RCtKS3I5NktkK2FYcnk3YlNSTmU0TjFaS0ExSmxuYVVoYlAzTDA2UFlQNGhJ?=
 =?utf-8?B?MFdzTmwzSlYxQ21PWEtETlJrS3RHbEd4d3RKYzNjcjVsWUpvVitpL1oyVlJo?=
 =?utf-8?B?NGhqN040ZkJ1SzhxMTdsQkRoR1FjRndyOFFvbm5nMVE0ZGx0cWNVWFdJczdE?=
 =?utf-8?B?MVNrdFNMMXNoelA5cExCTkZ1azZLZ0lxL1VpM0JzRmJna1dBQWZqSFZFZ2g2?=
 =?utf-8?B?Mmwrc2pNaWhqWVRQcS9Vb3hYZmRPZGJ0OUg0NU9qMGc3OEtIMkx1TW5CN2hy?=
 =?utf-8?B?TXRhOGZaV2RYODMycEY4US82ZU9aNENKcGNWUzhSR2tUeUJ4WjVvQTNMZDdm?=
 =?utf-8?B?YitDaUlvK1dYVEhiVTdIamJ3Y1JTc1RIK1JPdUFiV21CemNnaHY5OFhpbVQx?=
 =?utf-8?B?VENJRHRuRWI4bHp3Zm9FY3duckJ3S1lVWlpjU2k2Y0lzWFZHUFpXNEZyRjEx?=
 =?utf-8?B?VTgwVnp1UllMZmRIM05nanphUWhEc1pQbHRLRWc2WXNJc1U5bDQxMis1Rkpx?=
 =?utf-8?B?WTI4SmU1Vk0rRllXNSthaXd3ZmZwRXRQNWtrelR6ZFFidWtRRDVyem5yQ3lK?=
 =?utf-8?B?c3ZLK3NxUzJrc0ZPL0QzYUVRdUx1NGdZU3NOd2dRWGwvQU0vZi9kYWFqbTVO?=
 =?utf-8?B?eWwxTXZXdUdOYlEwL1haR2JoQkorRXFsMUZMRGh6cElHd2lLNCtDQk1ZblJW?=
 =?utf-8?B?TXBPWHBmQlM4K3JWbTRNQ1l5cWtuWmFWK0hiLzhxN2Q0aWp2WXl1cWNHMzBM?=
 =?utf-8?B?YjViWm5nWGVPdHZESGFucnZlTTczYmNxRFpHSUFud1Vxb3MxUE5jN0ZCU2Qw?=
 =?utf-8?B?Z1M2ZFhqcXdLSFFDM2lQamQxNWp3UHd2akFKdDRLbVB3LzhtU3FLbk1EODhS?=
 =?utf-8?B?d3Jvb0dNU3FDcFBOcU1YcmlLbTBPaTIvajhlWGxwTEp2K3NXaFlHcFIrdlFH?=
 =?utf-8?B?NENxSm4xQytFWEsvZHVlQmNhYmNPNm1uUHhia1NSYzluNWFmdlNyWWlPQVZ0?=
 =?utf-8?B?UWFVdWNDd1NxeWdjVFFFRWR4YjQ1RUlVUmNGMDNBaHV0YUlsd2lMMzZ3V0hC?=
 =?utf-8?B?N0lHbE1sRkx1N2V3VXhVdzJBS3JRK3FnbWUwRXZvdlBzSkxjU1ByM0NCSmtO?=
 =?utf-8?B?SmpNOFhPVElKUjFVYng3OGJKakp4OVZEWDQxZThCbXFoS2diSmRPSjl0ODZZ?=
 =?utf-8?B?WElZRk9mNUovL043VEFaekxjSGZRb3pYRzNtN0UzK2F5WmI5dzJDd2xZWFp5?=
 =?utf-8?B?aEhiM3ZhUEtoZHE4MWdtOFlXVmQzWWlZWUNNYklSL1NVaHJQaWF5eUk4amhC?=
 =?utf-8?B?azlEMjcyaTRLNXZMUUZkaWFKTU9oQndqL2xWTW95TnZlK1BUQjZ2bkRoNEpp?=
 =?utf-8?B?OWc1c1pYS0JaT2dIaWtBZ3luMWxKU3BIQWk4ZkVsRzAyc2IrcG5xRXJuUTA2?=
 =?utf-8?B?YlptS0hZOWsvQks2NWlCL0ZmRmZWdnZPcnI1Q1ZtNmhjdjBYVTdpcjJhUGhQ?=
 =?utf-8?B?RHFtTjVLMmVSMCtyVVFmU2FaWW4ydE5BbUJIeXd2NUxXTlh3ZnlaSmVKc0Js?=
 =?utf-8?B?OHBXTVBTZ0lhUWlaSzloY1h3eTNrcjFKdHh3VDlTQkNLUjVWQ2JJOFdBeUN0?=
 =?utf-8?B?OHlLN3hBcDNxZEJQSUZYcWt0WTRpcTA0eWk0NnA4cDZyYzlNUXFUQnJBTmR6?=
 =?utf-8?Q?MJzLcTj5yvNqa1VplH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a394b28-b1aa-4b2f-1756-08decb86ffb0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:09:41.1292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTATtH9Fi9d6UfNqkBNJGvmwvN8BuY/1UPrxVXpy36NlJwDjObJGDDoVlaX3H09I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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



On 6/12/26 07:52, Srinivasan Shanmugam wrote:
> Signal GPU_RESET EVENTFD subscriptions from the GPU recovery path.
> 
> The GPU recovery flow already determines when a device reset has
> completed successfully. Use that point to wake up matching EVENTFD
> subscribers.
> 
> GPU_RESET is a device-scoped event, so no queue object is used.  All
> processes that subscribed to GPU_RESET on the device are notified.
> 
> EVENTFD remains notification-only.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e46cdd6ecd42..8f28716912c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5694,6 +5694,32 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> +/*
> + * Signal GPU_RESET EVENTFD subscriptions for all open DRM files.
> + *
> + * GPU reset is a device-wide event rather than being associated with a
> + * specific user queue. Notify every process that subscribed to the
> + * GPU_RESET event on this device.
> + */
> +static void amdgpu_device_eventfd_signal_gpu_reset(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	struct drm_file *file;
> +
> +	mutex_lock(&ddev->filelist_mutex);

Please double check what other locks can be held under the ddev->filelist_mutex.

@Vitaly do we have ddev->filelist_mutex in our lockdep handling already? I don't think so, if no could we add it?

Thanks in advance,
Christian.

> +
> +	list_for_each_entry(file, &ddev->filelist, lhead) {
> +		struct amdgpu_fpriv *fpriv = file->driver_priv;
> +
> +		if (fpriv)
> +			amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
> +					      DRM_AMDGPU_EVENT_TYPE_GPU_RESET,
> +					      NULL);
> +	}
> +
> +	mutex_unlock(&ddev->filelist_mutex);
> +}
> +
>  static int amdgpu_device_sched_resume(struct list_head *device_list,
>  			      struct amdgpu_reset_context *reset_context,
>  			      bool   job_signaled)
> @@ -5738,6 +5764,9 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>  		} else {
>  			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n",
>  				 atomic_read(&tmp_adev->gpu_reset_counter));
> +
> +			amdgpu_device_eventfd_signal_gpu_reset(tmp_adev);
> +
>  			if (amdgpu_acpi_smart_shift_update(tmp_adev,
>  							   AMDGPU_SS_DEV_D0))
>  				dev_warn(tmp_adev->dev,
> @@ -5775,7 +5804,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>  	}
>  }
>  
> -
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *

