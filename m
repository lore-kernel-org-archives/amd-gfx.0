Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226D5FEFB56
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 14:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55CF10EB9C;
	Fri, 27 Feb 2026 14:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kx4IUDxd";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9667F10EB9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 14:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIhVGS4GZ7Yg8+Iwp7KbC40jtcExOt6/X2lu1Fl+7i/IY1xGAqS8QlVg5wzn4J12I7ihduy7KkmfKUESKgjpmZGD/JIceascbum9RRjC+O00c+lNhgtzbrslatNiNvkh9GF37IO8BWbe6QVZVGPZneNASVXBSu1AED0+TGLlKtjgoe8ChkmrSQ2SRM5b+V8vRaOL4+9In54DQlj039fe4j19TTU8Y3igWBvdsUOjat18u2MML+LP+z21xHiCYPkVvJHHhexP40K4fkdRNIttQi8ceIfCXb+np2uAiXF1hsGQQGIw8Vu9cwGdO/S8ifPWIc5cA10Q92fi1BoRm9PfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpnYL1TTkBxgy8fCoy8rTmHyefKmm6xwfTiPvP61MwM=;
 b=vMgXm4kriPv+wx8LHRY6STssGrkj/PdaWuYQBXqRiBY5kPSsVv1mlE58x+WbKIiXTVxwAUQ88NGvIGyUs44EVl6/0xVLW9PxDWhvf31B+bh9ZiSHnah+3seGkhGBsof0LDuiNDw0R/7wIL7WXh6oU2Az4SlvW8p2vZeeqY6UfoCXKXTUk551lrWbc9w8+ja293o8KUTwZV4ZuQqc72YixD8bQwmQrsKDYxwpOACkRQYScUUzDrB8BYPtMpETPUbhfvXi+d3T/sBXUBR+K2Qu1JslHgKCCXKe3OYsIxuMSHf0VWrg2U9fG8lxK3gonOtsL0AsT7JastEez5bIBmGgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpnYL1TTkBxgy8fCoy8rTmHyefKmm6xwfTiPvP61MwM=;
 b=Kx4IUDxdyv7fd+cD3Nob4TXQETuM0Y9w0xtte6Vc7I2hOo9hYzdDrV31g3Wc8U3A8xwcg2ghbGhqk5kL167sE4fHehnbviHRgU/Ozdxs19fksglkYV8ZkG/lmgNGbUvbRQEZyVC8rbN0hYUdhru67N/83h4mFRuQP9s4yO4r9tM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 14:29:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 14:29:41 +0000
Message-ID: <d142fdec-de62-4d44-8f87-007a6b5a0ac4@amd.com>
Date: Fri, 27 Feb 2026 15:29:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] drm/amdgpu: Add per-drm_file eventfd registry for
 render node
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
 <20260216154943.1582412-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260216154943.1582412-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 2266d734-2720-4fce-ad68-08de760ca4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: oDX1zjBKikY6RzZ6g765ET93cgba5e/hOsmHNh+g8ZlA8sxSvAexx+MezlTaHaKUCgYffjSYE1D9+huAQJG+5a1qUIwQpk8zr51gs1roUXOrrlLEabYsvxXrssdGjQQaBYjftFJIyncuwSDg1f8+DG5mvCgup3WaytDQXopQFRfNy1s/c4UOsVEMJGw/9HdGuZl0ssWzncQDQ8Ci7tuZ6U1z/njrIahrYNSS34/MyCTu2R7gKX/lNPkN/5bbiuyv8JBTjeLzQAa4BoeliBNHMJfAkiLaNvTvFk8/C/vAzSS6J8H/NpmVo7tubIHGK9QdlkJLLPC7V+jk7fP32vI4vH5oUpQdkgKqB9++8RZlEy5zQlI6NvqrKj/qvUedDpSoarv7WixtZGQPvhi69NuwbYjqu0fs/6UXvKUtWS8jv+EmtfVCWv8MdHDV9tjqSVkgFl0PyvQrQGyloox5KpKEMKTZP1bzNJhq+5p6ivR6w7ASDJosBiv8rI64ZKNm1r3jkB1Rn7Z/KrGu0rU5MTH8McIRRvNHbYuQJHCr+BZNEQ0A/HVcMhcjSbcqzqw54M2/rO4Y9/xGJ4e8xGEvlFQBfxrqWu3+FZoyY7pCdUfNYfP1FuT63sRsW8dt7OL0iB4r9MJTl/1tNrRqx7fqjv1YWcBzhsv3WK0jRePs6PjyxrqWbfLo87eg/Yo9bJwcNT6yPdFLhLKv/wqSyNcQ46ixxG3p8Dx4MkdTgyl6mkQzwzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG5wUEFWcUtYaWcyL05PSXNhVzdpRHgxOVlpaHYwM1BWOEtkb2xZUXAyWlp0?=
 =?utf-8?B?Mk00dVMvaXJNV2IzNDQ0MldhMzl2VWlXMkNyUThaeHl4eE5aaUVBbUwvVXBx?=
 =?utf-8?B?ZGorblpERnd1SFgwdDAyRnVIQzRVUGplRXRGQS9BY0RkTkFyY2xEWlcyQm5l?=
 =?utf-8?B?Uy9aREt5eUdHM2hiejRqQUxwcHloa3ZLdmNieHNReDhRNm5FeVdsOGN4R3NT?=
 =?utf-8?B?Z3Z3cXUwbVAyYncxQjYveGZQaDFzOVlVQ1dzUFVhZTJDV2JkY3BubXBKSGFs?=
 =?utf-8?B?MzIvcU1SRjJMNFNXVjUvbnk3Zm9GbDVLb2xJaTdBTHc5S2dGd3pzWEdVdklr?=
 =?utf-8?B?WFF4YjZ3L3QwUnhvdTZFMEIwaFhFVCtHaHdISmtzYVRKemI5bE9DdnY0Rk56?=
 =?utf-8?B?RmxIZCtlakdtNjBiUHFMMFJIZ21MRkI0bjgxL1JzODhYRU1ZektsQmEzVzQ0?=
 =?utf-8?B?YkpnWGxvd3NQbUNqMDFxcUdIYjVuZ1JXSWhMS3NNaWhldWplRnFGZm01N05M?=
 =?utf-8?B?cUR3cUV6QXNROHBCZmhxMnRtS09lNEJCb3hGQ3JNUlZqOE4vK1p6WUxPYnBk?=
 =?utf-8?B?SlNVQWtNbHp0aHRNVzAxY0RtZjBUWDRudTV1elJ6L3IrMDZRaCtLMDZUb1BN?=
 =?utf-8?B?TEVaSFMwWHVlRmMvV0VUam00Y09MQmNIQ0dBRmxMSHkrcVl2bkxEc3AxOXE2?=
 =?utf-8?B?b3Q5WjhYWnZyYVdiVHpWREtwUEVOMVNMQUZLbnc3RVdlMkI3Qk5EK0hQcHJM?=
 =?utf-8?B?Y0w5T2I2OHNtRjVaNWcrbU1wc3BkNFIxYVMwbm1SZlhUR05Gemt6R0tDRGNz?=
 =?utf-8?B?NmdGcDdBNzhiWUd1SmRLclU3ZzdvU1FXMzNKWmt0alZ5ajN1ZnlQMDI3OHlQ?=
 =?utf-8?B?WVBrck1nVWRtTHk5d1ViWGNZUHJsSG9aWEt6R3lhd1FsTHRIZUxJTm9wVjla?=
 =?utf-8?B?eCt2NlcxNlJMejhNSFpveURQTG1VV0hEdFlXMy9TN1UvVEhHSFBndFB0Si9n?=
 =?utf-8?B?NFVKNEVSMEVHcTdMUTQ0VkUrc2tuSTFvYWo2VWdJamhGayt5bytpWkNsMDdq?=
 =?utf-8?B?UXV6eTVZdWI3azRYcUxHTW0wNmoxd3pYTFp1cHRIZFlDYWpzdFB5VHJ3b2Zi?=
 =?utf-8?B?MlRzcHczM005SWpLalcwUldneENRM1Q1RXlaejlzVmhJZWN3S2p4aXk4cG1y?=
 =?utf-8?B?N212b3dxT2FadUV0SDFzMm9BQ3NGcTJkQk1HdXQwdzZKaGw5Wnd1OGxzWnk2?=
 =?utf-8?B?Rmp5eEhUcmpRRVpzNy9PajBEVU15MHcrMkUvUTE4cUYvVzg0RXhtcVJnM2py?=
 =?utf-8?B?akczemJPc0J2bWlIaC9NNWhaVVZqZ1BVbmQyNWp1ZGlLZjh3dmdiM1BOUnJw?=
 =?utf-8?B?QWI4eGxFeTJhUkllczVTc2VXd2RiWm54TW1uUlBxM2ZNMnV1T094enZHODJ0?=
 =?utf-8?B?dmkxTXR5VFUyTXNzNXVQU3pmSFdVM25Vd0tPOUV5aHB1aGtud0s2SzFqRitU?=
 =?utf-8?B?c1J3bWd5RFVhL2dKb2c0KzdrV0ozWXRIZzFXajZza240WjVwWFY4RWNSaHN2?=
 =?utf-8?B?dHlwV0xnUGhNY2NnTHFnUWdUeDJJam5LSkFHelBBeWh2Mjc3YWdhcnd4b3Jm?=
 =?utf-8?B?R2Z6SWFRWmRmMXYxck1OZGV3R3BYc3RScVc4bGVkY1cwQlJwR3J6V3hObVBJ?=
 =?utf-8?B?bXI2SVJNWFBwQXV6Z2dEWEplNTRURVptVmN3aFRaN1l6TE1aZU93R0FpMHFV?=
 =?utf-8?B?UTYzcy8zSy9JNjkzMTlDcDBINndLd0lWeW1Tb1NobTRpNnA1bEh4aEJNL2VP?=
 =?utf-8?B?b29WeEIwSnJrUlQ2U3hkR2VScXNTNW1NTmJIVEpjWTkvNndjaWdUZ3E4NUN6?=
 =?utf-8?B?MU1ZR3VTUkUxb2NCbzZkZkJ0OG9LTTVaZGIzQXVCOVdVM1ZWWXZHaHQyaUJq?=
 =?utf-8?B?YVNnUHZaRXFQTlNWSENTUWh6N1M5OTJiZDJiOFR5dWVyQXI1TmE1OFF1MGRO?=
 =?utf-8?B?OVVzWndjQVBIYTAyNzVmNUxubTVLMGg4T3FnNHJNY2UybS9HY2x6RUg2dmNT?=
 =?utf-8?B?V0FlWmJNQ3FFS2lMY0Z2bnJwN3dpY3dZNGNHb3l0R01ieUEzNVQyWENMYXJK?=
 =?utf-8?B?dlI2NXlZRHJiZkVOL1M3K1lIVXlXaFhSNWZXaUFPUE5NNVNxNmJJeHdMalFP?=
 =?utf-8?B?NnNONzhDY0d5dyt4QnRXd1prMGlHdHdZQ21JU0JmUEllSmZTZmZpa2Vibmpz?=
 =?utf-8?B?VW94MGhlcm9oZGk2YmNOTFdXUFpWZGZmNkRsK0I5NUlNTnRWblZrWDJNT2dx?=
 =?utf-8?Q?oiG1qugBJrDByAp5r5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2266d734-2720-4fce-ad68-08de760ca4ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:29:41.5984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQNhP734oPXZVedxID+ETGq9BDeMQMVjCSgPJvns5aluF/vjGB4drWbW2zPXJ+qZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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



On 2/16/26 16:49, Srinivasan Shanmugam wrote:
> Add a per-drm_file eventfd registry to amdgpu and wire up the new
> render-node IOCTLs:
> 
>   DRM_IOCTL_AMDGPU_EVENTFD_BIND
>   DRM_IOCTL_AMDGPU_EVENTFD_UNBIND
> 
> This allows userspace to bind an eventfd to an event_id on a per-file
> basis. The mapping is stored in an xarray protected by a mutex inside
> amdgpu_fpriv.
> 
> Each event_id maps to a struct amdgpu_eventfd_entry containing the
> associated eventfd_ctx. Bind replaces any existing binding for the same
> event_id. Unbind removes the mapping and drops the eventfd reference.
> 
> The registry is initialized during driver open and fully cleaned up
> during DRM release to ensure proper lifetime handling and to avoid
> leaking eventfd references. Entries are freed via RCU so future IRQ-side
> users can do lockless lookups.


You should probably encapsulate all this in an eventfd_mgr object and not put so much code into amdgpu_kms.c

I suggest to just put the full eventfd handling into amdgpu_eventfd.[ch] and then have both event_mgr as well as event_id object in there.

RCU sounds good, but is probably not necessary at all. Just use the IRQ safe xarray lock variants.

Regards,
Christian. 

> 
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I78635bba4772843138a51a6152a3fa621cb07353
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  20 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 116 ++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0f6e9cdbe7d8..2baeb0b20df1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -44,6 +44,8 @@
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
>  #include <linux/pci.h>
> +#include <linux/xarray.h>
> +#include <linux/rcupdate.h>
>  
>  #include <drm/ttm/ttm_bo.h>
>  #include <drm/ttm/ttm_placement.h>
> @@ -452,8 +454,26 @@ struct amdgpu_fpriv {
>  
>  	/** GPU partition selection */
>  	uint32_t		xcp_id;
> +
> +	/* eventfd registry for KFD-event unification (per drm_file) */
> +	struct mutex eventfd_lock;
> +	struct xarray eventfd_xa; /* key: event_id (u32) -> struct amdgpu_eventfd_entry* */
> +};
> +
> +struct amdgpu_eventfd_entry {
> +	struct rcu_head rcu;
> +	struct eventfd_ctx *ctx;
>  };
>  
> +struct drm_device;
> +struct drm_file;
> +
> +int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *file_priv);
> +int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv);
> +void amdgpu_eventfd_registry_fini(struct amdgpu_fpriv *fpriv);
> +
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 03814a23eb54..98e2fa78c787 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2955,6 +2955,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  		fpriv->evf_mgr.fd_closing = true;
>  		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>  		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +		amdgpu_eventfd_registry_fini(fpriv);
>  		drm_dev_exit(idx);
>  	}
>  
> @@ -3062,6 +3063,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_BIND, amdgpu_eventfd_bind_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_UNBIND, amdgpu_eventfd_unbind_ioctl, DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f69332eed051..43da5bc36b7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -39,6 +39,10 @@
>  #include <linux/uaccess.h>
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/eventfd.h>
> +#include <linux/rcupdate.h>
> +#include <linux/eventfd.h>
> +#include <linux/slab.h>
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gem.h"
>  #include "amdgpu_display.h"
> @@ -634,6 +638,113 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +static void amdgpu_eventfd_entry_free_rcu(struct rcu_head *rcu)
> +{
> +	struct amdgpu_eventfd_entry *e =
> +		container_of(rcu, struct amdgpu_eventfd_entry, rcu);
> +
> +	if (e->ctx)
> +		eventfd_ctx_put(e->ctx);
> +	kfree(e);
> +}
> +
> +void amdgpu_eventfd_registry_fini(struct amdgpu_fpriv *fpriv)
> +{
> +	unsigned long index;
> +	struct amdgpu_eventfd_entry *e;
> +
> +	if (!fpriv)
> +		return;
> +
> +	/*
> +	 * Serialize with bind/unbind via eventfd_lock,
> +	 * and use xa_lock to safely erase while iterating.
> +	 */
> +	mutex_lock(&fpriv->eventfd_lock);
> +
> +	xa_lock(&fpriv->eventfd_xa);
> +	xa_for_each(&fpriv->eventfd_xa, index, e) {
> +		__xa_erase(&fpriv->eventfd_xa, index);
> +		call_rcu(&e->rcu, amdgpu_eventfd_entry_free_rcu);
> +	}
> +	xa_unlock(&fpriv->eventfd_xa);
> +
> +	mutex_unlock(&fpriv->eventfd_lock);
> +
> +	/* Wait for any RCU readers before destroying the xarray. */
> +	synchronize_rcu();
> +	xa_destroy(&fpriv->eventfd_xa);
> +}
> +
> +int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *file_priv)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_amdgpu_eventfd_bind *args = data;
> +	struct amdgpu_eventfd_entry *e, *old;
> +	struct eventfd_ctx *ctx;
> +
> +	if (!fpriv || !adev)
> +		return -ENODEV;
> +	if (args->flags)
> +		return -EINVAL;
> +	if (args->eventfd < 0)
> +		return -EINVAL;
> +
> +	ctx = eventfd_ctx_fdget(args->eventfd);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	e = kzalloc(sizeof(*e), GFP_KERNEL);
> +	if (!e) {
> +		eventfd_ctx_put(ctx);
> +		return -ENOMEM;
> +	}
> +	e->ctx = ctx;
> +
> +	mutex_lock(&fpriv->eventfd_lock);
> +	old = xa_store(&fpriv->eventfd_xa, args->event_id, e, GFP_KERNEL);
> +	mutex_unlock(&fpriv->eventfd_lock);
> +
> +	if (xa_is_err(old)) {
> +		int ret = xa_err(old);
> +
> +		eventfd_ctx_put(ctx);
> +		kfree(e);
> +		return ret;
> +	}
> +
> +	/* Replace existing binding for same event_id. */
> +	if (old)
> +		call_rcu(&old->rcu, amdgpu_eventfd_entry_free_rcu);
> +
> +	return 0;
> +}
> +
> +int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv)
> +{
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_amdgpu_eventfd_unbind *args = data;
> +	struct amdgpu_eventfd_entry *e;
> +
> +	if (!fpriv)
> +		return -ENODEV;
> +	if (args->flags)
> +		return -EINVAL;
> +
> +	mutex_lock(&fpriv->eventfd_lock);
> +	e = xa_erase(&fpriv->eventfd_xa, args->event_id);
> +	mutex_unlock(&fpriv->eventfd_lock);
> +
> +	if (!e)
> +		return -ENOENT;
> +
> +	call_rcu(&e->rcu, amdgpu_eventfd_entry_free_rcu);
> +	return 0;
> +}
> +
>  /*
>   * Userspace get information ioctl
>   */
> @@ -1469,6 +1580,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		goto out_suspend;
>  	}
>  
> +	mutex_init(&fpriv->eventfd_lock);
> +	xa_init(&fpriv->eventfd_xa);
>  	pasid = amdgpu_pasid_alloc(16);
>  	if (pasid < 0) {
>  		dev_warn(adev->dev, "No more PASIDs available!");
> @@ -1538,6 +1651,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (pasid)
>  		amdgpu_pasid_free(pasid);
>  
> +	xa_destroy(&fpriv->eventfd_xa);
>  	kfree(fpriv);
>  
>  out_suspend:
> @@ -1568,6 +1682,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (!fpriv)
>  		return;
>  
> +	amdgpu_eventfd_registry_fini(fpriv);
> +
>  	pm_runtime_get_sync(dev->dev);
>  
>  	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)

