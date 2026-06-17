Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F379FCD98EE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 05:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457F410E08E;
	Wed, 17 Jun 2026 05:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgCm14CM";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3952E10E08E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 05:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDPupZJR4j9YdAK8mGFlsx8bPCxkMFU7CCdo8Q9ZrGq1QnaYh/XR2wUFQXkZmcfOYM/ZtVH/LhxYPipOQsFue2ypr9iwIJ0CgiJ5zyrFK4v6QIaekDzbAaPF64ZO3k6qVQMTQHlZWwvcsWZvnNOs7XqlxDF/RnZfXcDWkz/dj4ONlON1DbxC89LcXtopU8Dvv/ObsJHGNuyNP34iVDzrwzzxPI3zOMefqn20tp7pjumG78plfms02/uuaOdy49dy5P3VymNV1B4CKEvG6VsXoK/IGep68mV8KM4TZc04b4hSbLrgnnQAWAYxKTNMFZQuJviz8gPqtg8C6rV/qtjDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srT0a+OYO7sQ4jbUQOcISvEeaIIodNzI3U3eD0H/I0E=;
 b=Z7ABK80KerzypWZnra/Hz2wP/wlVHLNDgNBxHHRSOs54AFoEGgEtJliShFvXe3MBICL5rqc8GA1HVQuJJ8vMPPpqpAnZjd/7/xpHZAJzRlfYy/vRbT++qOnoqc+ZSG9SFppiyuGAtHPxtuIF00AAx0rhQYwWBshWrey25Py6zdBPRRdQl91xBqAYWb96XB+zCRNrt057CzppaGJs1Yk9crkpHmn+zg5d5HBC39IuOdvi7SeH1npcGs9osAjgoLVjhgLB+Yi9dfx0aVdzMxmgJJowkC6TJJEBYFdb1EUUU/Y4el/GN7UPedQrB82qliojtBNCtbAUT1NLH1n73LTmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srT0a+OYO7sQ4jbUQOcISvEeaIIodNzI3U3eD0H/I0E=;
 b=GgCm14CMTcNEMWr3U/odcShBJ1imsVs/fRUD+m/IJ/zlmHX2w4Krh+duEUnRuCjIg5vPfsSQnb1OLFiVPL17nlKapAHYHSiUw5oyX9JYGO4rAcR4gEty/WoeLKC1+GSDRgOfvtx+GSti3Egk7kjZaUmLPPWUM1K6vG+QDSooWXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 05:08:28 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 05:08:28 +0000
Message-ID: <4872460d-f5bc-4031-93e3-63650ec04479@amd.com>
Date: Wed, 17 Jun 2026 10:38:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0255.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: afe35bc8-8027-462c-5bba-08decc2e77b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: FZw1YhvjExGstlM+es8F1x/c8jPWUMBlrkPVvP9d0zLwNBzPvPjF2kWRIelJBOLDGtv6BW8g1FadOmbNWeix+yzqdB0ejH+Gp1rl5jqvJAH3rBHexEBoZNH1KKlJvBcwLb2jWQDewPvaF9JYux9gQAiyJWbjxozeabiHA41CL2vlnLiBC/nwonPnxLlmlpMeUF0Lo7s6mFfDNOeyGzWrd6r4U3kqrQ71g6/KjXYgARqI0dIicr5Zzj8grL4LfdjPNBewqwTAXnMuU0kICS1LS7fINZHdC9ml18VJjMX++yjnINceefCTag4cVQAS6vKDpHpHQ+0D9+TtiaS+T5KBEDQH+aSTGmAx0sspOu96FIH+GqSQvkjC8wMd2omBiz+DJJM9Zw+Iv//cGrAhiwZ1DfjQYI2hLxlas9LRCXMHO/ewF3f9CyHTDy83kGxqFWAoiNBkiyd9lTPeS303fQlsMMyF7zGuAt+ThrF1ilgyunTFLDQgRKBNPF3Vz2rupt/C9NnThzkBKEEYpP+UaMjPpGi0t/gv86AIPYkYjwR1xyUCkN1sMq3bDH57khCA7yBJRt3bJeuz/vtJfkUj8+lvvF+oIxgQLQ5OViu0MjoxNAF5XN+WHyZyhBHsHCDP6nY1UYMtwQwnGyhXjDNW2i6o1u3YHpMD9E72Dnld8JnNtdfZPbnIk/7JmiOH0ojhw2Wy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEtFMlNncTZXRzBEV290UGt0VVM4VmREQUZoSWlUVVozM2w5K2l2Z0VrdEYr?=
 =?utf-8?B?bUcwY0pvaU5DL3R3ZGRrQ3B4d1ZXVDA2WG5heWJpRUIzeXJJMDc3RUZYbkN2?=
 =?utf-8?B?RTJBNmFDUnNYYkJkQ2R3QVRrd28yNEd5eXJITVFjVzVoSDM0YXRlMG9jQnN4?=
 =?utf-8?B?VWpGSmFTaEdGNkN1SENKcTJZOXVWcjl6U2Zod25meUs2S0MvcTlWTlczSWky?=
 =?utf-8?B?aFVVRlBOcVF2QzJBd21ScUw2YlhiVjlCTEhuRUhrYmc5UXp0eDhiNXNjbWZo?=
 =?utf-8?B?NUU0UHNySWhqUzErZUlUendteVFJU3Z2K1RmbWVsR1hNRkNtcTdoVFdjNjZO?=
 =?utf-8?B?dGRHY0J6V0w2S09iQ1Q3ZnZnQmVERkMreEE5cXpUTFd4K3pBQlRkVTdqSmdD?=
 =?utf-8?B?eENpVTFjMktJTlBTdEJBa3N3bnVxS1JzZVp5STU3Znd5MnNVQS9qbFdQK3k2?=
 =?utf-8?B?ZjcrRjljZUVqcURESmhTRERHWVpzUTlENytWb09kcStVOUZtY3lqQzMxUStN?=
 =?utf-8?B?TmVVQXQxNGNIM1IxM3pkNU1xSjBCQmF2S2xlYXhNc09YVVJmVVFqVjMyYjJD?=
 =?utf-8?B?anlNMlZibVArQmp1cUFtc2dwU0FEN3RpRFRwdkpjeWJIb1l3elpXQWdrYWpr?=
 =?utf-8?B?ZjMzZUVJYXlsMkpaa1FwR09SS0FJOHVxaGVsdFl3UTJYTXFEdEt1MjVvZmI2?=
 =?utf-8?B?ZmtjS3d4bkpTRXg4MlkvSEY1djFQZFdkd05FZGcyQ3dLMzV5T3lDNGdrbEQz?=
 =?utf-8?B?SWdoSzVML2tiTmtla3U1dmZMZWgyeUpkcktxdHVNQnJTSDJpTnNEVzJoS1N2?=
 =?utf-8?B?ZGpmcFgrR0xaVUF1M0VIVVBnREQ0OXVFUExhRFhIbnNnTVpPb1FNendldEVq?=
 =?utf-8?B?Nis2MGYvZ214YS8yRjlnMFVBcUxhc3FqTjJQTG9iUEtVK3NtZUN6VGMwbkFE?=
 =?utf-8?B?ZHByZ0FKNVcwb2pINnBwRGlRZTJnNjFzYWhvUjEyeWhYVnZRRzIzczJKZ2J4?=
 =?utf-8?B?RXZJZUF3TWM5eEU1eXhnT1Jwb1lheUNTbXFGdnBmbU1kQkdTZU9xZUU5VER4?=
 =?utf-8?B?Wm5aSTFWT21Vc2UwV0loMmkrZHUyeDg5Y25uR0h2eVlMUUJFM2dTTEFreUts?=
 =?utf-8?B?aEwxRTJtdXVrc3ZGTlhtRjhnd092dlgwYkptZkhNa3VpZWJHL0VuTEpjNkJN?=
 =?utf-8?B?T3UvNlhsejBLRS9wdnY2eDlzb3ZIUmpvWjJndzViYnd0REplSWJYK0gwMXRm?=
 =?utf-8?B?Nms0blYxY2RaeGpIY2xVNFBMWEc5VUVSK01DNjRJNEE4cHlhcWwyclNBQmdP?=
 =?utf-8?B?dm5KbDhDd0s1ZXZYcEFKNDRHdHFzSTNrMzVQVkFoSUowZ3pEcTR5dEdSNlAv?=
 =?utf-8?B?NlpjbWs4Ti9xdW5CejN3NGxMaXJkWXgvNUw0ZjVqeldMcnEwcDVVUndPSUE0?=
 =?utf-8?B?ZDFMMXVSYkZrVDAyUTg3RWw0ZGFLM3FPYWZpNDQ1M1ZMeVJRWTZmTEhKYnhi?=
 =?utf-8?B?VlBLcnZnTzZnbFV3a2pIUC9POEdObmhqQWRrOEZPOE5OYW1WOG1kWm5pRnZ0?=
 =?utf-8?B?eTlGVmxWTkVGZ3U4NzVEN0o1OFczT2FpRDZvT1AwMUVMYUxocFZwOGtsUnV5?=
 =?utf-8?B?Qk9NSWtNZXlicHFWOGROQWgxYkZ0S25OdmFEeGU4Mm9qSUVqVVpDYlc4bFJr?=
 =?utf-8?B?QkZYNXFGcXNQSWU1TWZqaVRmMENxWW1XcGtsWnVvVXpIL1ZaMFc2K0FpTXVi?=
 =?utf-8?B?dW5vbDZwSCtXdkVNd2IxSkJIU0RwdXFNZFYxMkRKVXpGN2IrRFdUclJXMHdq?=
 =?utf-8?B?NEhGUmRKUHh3N2R2UE9Md1ZQNUNlcjBQQkZrRlRRS1BZZ1lZZzdQeHc4d1dM?=
 =?utf-8?B?TlUvZ0VPOU00NmZzdUdLQiszcUZ4VnI1YS9IQkI5TXlyRlZBbzh3MVVtU3Zh?=
 =?utf-8?B?R2gvdjNBemN2RDdma2dCejdBeGZoUlVpdUhUNjZmVDREWHVhQlR5aFBYWWt1?=
 =?utf-8?B?NFJ6dFRzTmxpOVpuRUxRc0NEL2UxRGwrTWxxTm5pRDJPUFJ4WTJ4SjNOZDhn?=
 =?utf-8?B?R29mQzFSbUF2emR3TzNxN081Wk8xNHpEM1dpak81alFpaUxMVm9weWc0Ykpo?=
 =?utf-8?B?aUdQSnljVFZvRkZqUzVuRWJjbjdyempRZ2ovREN4VlZQbk4xWStZNC85bXpp?=
 =?utf-8?B?QXJ6bTc5VUZLeklGYnV1N3hPRmtpQm9VOGNRNDJITHFjY0FSQlRjOXBLVDJL?=
 =?utf-8?B?V0dwVC9sMSs3UjFkVUxDMkNyS3U3VVJ1MytRdnZWZzJYZ0xJQ2VnYXlnYVMz?=
 =?utf-8?B?ZmtsTGhWVk5weVZwY3NlOFlESmhGWnRJSk45TElDT0xwbmZ2bmUrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe35bc8-8027-462c-5bba-08decc2e77b8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:08:28.4355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rviBKNtb+M+9CPcXV7vBK1WKSnKyqMGAYNtzGoSChKqgKjgG7oXfAaEBmn8ZWeI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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



On 12-Jun-26 11:22 AM, Srinivasan Shanmugam wrote:
> Signal GPU_RESET EVENTFD subscriptions from the GPU recovery path.
> 
> The GPU recovery flow already determines when a device reset has
> completed successfully. Use that point to wake up matching EVENTFD
> subscribers.
> 

It seems beneficial to send an event before and after the reset, rather 
than only on successful completion of a reset.

> GPU_RESET is a device-scoped event, so no queue object is used.  All
> processes that subscribed to GPU_RESET on the device are notified.
> 
> EVENTFD remains notification-only.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e46cdd6ecd42..8f28716912c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5694,6 +5694,32 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
>   	return r;
>   }
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
>   static int amdgpu_device_sched_resume(struct list_head *device_list,
>   			      struct amdgpu_reset_context *reset_context,
>   			      bool   job_signaled)
> @@ -5738,6 +5764,9 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>   		} else {
>   			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n",
>   				 atomic_read(&tmp_adev->gpu_reset_counter));
> +
> +			amdgpu_device_eventfd_signal_gpu_reset(tmp_adev);
> +

This is actually a misleading place. This is also taken for reset-skip 
path where there is no real reset. The logic to not show reset related 
messages with skip flag passed in reset_context is a TODO.

Thanks,
Lijo

>   			if (amdgpu_acpi_smart_shift_update(tmp_adev,
>   							   AMDGPU_SS_DEV_D0))
>   				dev_warn(tmp_adev->dev,
> @@ -5775,7 +5804,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>   	}
>   }
>   
> -
>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>    *

