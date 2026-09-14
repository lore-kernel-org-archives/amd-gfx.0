Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D7FC88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 08:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D7D897FF;
	Mon, 14 Sep 2026 08:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ewxej3Uh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318A2892F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 08:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goHjBkq6TLYlDaG4mSVPSwpUFK3JmMKvCIzkRJC+TUPTW4XyW7wCwDpKP+R1hBJEiv99pO41GsZ/xlwh9gDAjHTEMYwY2j1YSbyQ+39Ozz+o8uU2gspI6nhYRf4s6B0EmlvAd8/YAZjj/hekeQozI3nwbSlDmNks77a+AeAFIVN/MB0qoU3313LhN+uqvV10ixHm1/nuP2k/MUpaGJLf5V1EWx67BJ6KJvNxp/QlR7K6Vf2sxlJFq5liimARZgmtPC54g2O3J5y8Kt6/LwrZSXveDRamuQe2DX+Zgx+8EtNWQoKjMyX8x9/9urvH8XuH9hYC2fgWD40tskNYa3Fo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxpLI1x6SPvSAl0PHrhF5ZWhF+GQ2oHPr/3TV8GW4IY=;
 b=V1pXkjyCFTfEsX2oo7Zd+d3qtIV5jwi5LmxzbvTDt2ErWgXfPIeM4uafdTRI0JbVn4KkkmvR64JyPUeCfa+gIHvxd1D5vt1mbPa+5mvcwgKlQGYMgynDETnE6vp5jbBkL7FKX2s6v0zn8XCBcQ/VAULiqKpQ9+fzAvKVfSJoAfAgG0AdcV2sjQdWN2FJLgD07ERjcpU7+2hVO8u+Nf0a6SvAxl4bVLlCcaDK8bQPtemoYtQM06P5rO4ZyIlaPj4QxKhydQecjdkKL70PTcVGEwZYfVhKp5fheS8mfAt8d9UlWwIZyxV/7z2IbBruXfsf9E0WAbqBU+xQAF/0LeeymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxpLI1x6SPvSAl0PHrhF5ZWhF+GQ2oHPr/3TV8GW4IY=;
 b=Ewxej3UhU9V+FTEa0iVu3hjcn9m+7V9wuLODzeBbbtRrhgwmpGWuFEk79H9UKrGJz/rWcEopZuGeLIIv3FWBTXgizGw52ltFfzDmfgcanfxzrHpIhKa6xXMRPWrS+95jyOrFoDEZvrP3B4s5MUcW862FA7d9tGE/QNhE+B38SgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:56:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 08:56:53 +0000
Message-ID: <0bf5a38d-d4f8-4691-9992-040b6dede31f@amd.com>
Date: Mon, 14 Sep 2026 10:56:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: use pm_runtime_resume_and_get
 amdgpu_gem_create_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
 <20260911154212.591213-2-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260911154212.591213-2-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4eccd9-1608-4695-f63c-08df123e1f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: BBaTsbwA8OVg677VNzwkx2wN+6E0sr9d2Cwk2eI2EN+/e8NyRlbDvkkuXo1B85gPeTfTHNzZ/qGVi7guGqbk8oYgoX20f7cFq18HiIHEXmwdwbY9SQy30oaB+w5seCLG+XYulIx/mDVKwWsqNJOWs9UPH07qKEcgGMDHhMPohJ2Rv7tD2vgwWz5lks/m6jW8bx+KFGBGFKU7+888eE899GTVti1xzoQUA6Z7Igh6vr4HlsqNvMGYOloq9sjP0Gm6L5NZsS+f0qnRQivqtehzqqkagAt+Pi/GBhVlwPlll7NV6KljndgtWCWHXtc9xdkhgnHsWRBlegbun9b54vjHl/m3nLE3Y8QyLVVJ6VFWBL0rRBM1xtBUe1UJdnGIIsZcEMIHXpv3xqbkpbmgWkOfdH3YeaYGA+/apyaCNbHqBpGjm04bwPc+Cycre7O6n2DdFSd7TrhFhjuROOfzQPfPSfm8EcpRfFgm2z4fjW28skUsnaw/ZUaSdXY5qn/TCCs200jwBn/4CBGFQhHcnIywqZahqIkUBr74paclx6pNeS51q650xgGaE6nNAzefK0zpsM0l7FhU8o+fyCodY8MsJpUmZmRSDjiFQN9IK6/SgxeZpyZjqpN8nzeB8mMrfXFcWMqUtc/hxNGRJZ6UkxooExBNA0StcN405fjvjKgXpUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVB2c0NHR1QyNllJczZselpNNm1LTFM0K1FNZkk2YklZUmhSMzZ0VjVXL3Fp?=
 =?utf-8?B?VGFUbDdKUWcvYTRsNWpjT2ZKVHVHZlIwRUNGU1ByMFo4dXU4bzYwUGZObjFv?=
 =?utf-8?B?RnNDaDQvVDFlbmhYa1pUSTZ5aVR0MnZ6VlArNjhCK2JTWkZkZURvS1lDSzRq?=
 =?utf-8?B?OHFjL0FRcWZYR2t5d1lIcU93ejNCakxEV1pTZ3dwLzlOUWlGQkFkUXNmanR1?=
 =?utf-8?B?MFUrM0RVU05iWDRmL0xCd2NVR3ppbGNmQ29zOFJtb29zTlFDS2tzdmdJT0xT?=
 =?utf-8?B?dXhUSXdKWTVNOUw1M0VFNGFiR2RMM0wrWDNCTHFTbU5WNno3WUVHYVBEczlI?=
 =?utf-8?B?MVdMZVQyNU82OFZLUGh4VmVvK2c1ZzM2a1RYSEJlbmZZQTRlbEN5Z0JXbHMr?=
 =?utf-8?B?bmZ2UEpobVVUS3ZjcGdMbXNRa0k1Q001VnN1SGRqTWJwL216UEpvcXdXeTlF?=
 =?utf-8?B?a2gwYnl2RzRxUDd6RnhyRE1YWkpJampXMll2Nk42ZDUrT3NjTkx1S2xTSkNJ?=
 =?utf-8?B?dUhiOStHcGREN0gyc282b1FCQVRXSkIySjRmRmZrK1V1QnpTcGh3MXVpN2du?=
 =?utf-8?B?azRjcUNVSDVtSFZMclFJMEtzc2xtY1M4NExLbTFpUytyVGhBeVhMeWpySXNw?=
 =?utf-8?B?akozMmw2QzYyRDdBNTE4Y0FKUlczNWgzKzlJMkdmbkhzMldXKzhDT2tidHdx?=
 =?utf-8?B?MTMrZllVYW9CZ1NzcmhJbGkrdzN6L0lDdXdSVm5FZWdqWUFSTjBXeEdGTVUx?=
 =?utf-8?B?MjZJODhaSVF4c0hrSW1uSml0N0VvUlFXRk80aVRvSEZ5aDJObmt5TG5sa1Zw?=
 =?utf-8?B?WUF1eEsyQTM1M0N0aGdiWUpLeU41aXZCM1NFTHhkQmhBNGwvY1VST2pqU0wr?=
 =?utf-8?B?emdZSUQ4eVArQU91MUNqZ01IVWg3VnludDdDR1RrMzVXYjZQelhpNXlqRjhv?=
 =?utf-8?B?RkwwSzh5cmIrWDhWbnoyMndEck9URlIwd2ZJZTZaVkNGcGoyRWxUakc1cits?=
 =?utf-8?B?TlNZSllQL3JZR2RkOGxVZy8xdW8zYXRha0lUTkh1R05PRFZYTlFPekZsQUla?=
 =?utf-8?B?dlJJTEZLbE9abUQ0d0I0NTgyTEVVTTlZWC9wV0NVRC9uVVUvMHhBV2RwU3h0?=
 =?utf-8?B?SVpKK0wzNno3VjUxanViY2dUVitZdExIeUo3OURLTSswSVlMQlJGczVXaUEz?=
 =?utf-8?B?Qm96aFlOQnhpNS8zajNSbkFmT01EMm4wOEUwQVU1MzByK2NVS2E2alJkT2tr?=
 =?utf-8?B?UkVPbXZqdEViOHY2ZnhIRURETE9TUUVTc2doamVBY2g1c3FlM0o3L2tvVUty?=
 =?utf-8?B?T2U4T3ZwMGdHVVltajBVMDE2MTVoa3FrNFVLcFBzdzBLeU1YK2Evcmovb1lU?=
 =?utf-8?B?Rmg3TVoyY25ic2lwQ29zcWsyNExDOTRHTDJjeFVSOUI3TWdsblJqeU55QTNx?=
 =?utf-8?B?Tnl0dUNQN3ZIZFFWeDVkcXkwUGR1TkdRODdlQVZLd0M1dkdla1dIZ3JZNVlu?=
 =?utf-8?B?N0dhc1l1dVowTUh5cGpjbHF5em44Y1Y4c01hS0lmYkpWYWlJaHhHUTRMaHVj?=
 =?utf-8?B?WEcxN3pjcStxaVlITlVVZHExRFFkUitrenJXZzNnQ0NheExaOUxITSt0UzRn?=
 =?utf-8?B?eThwTmlqQWZ2NkZWY29UcW5ET05FeEkrdFBod294UmtHRXlNSjJiclk4Nysx?=
 =?utf-8?B?dGxoT1VHdXpocVhCMjdFOS9zZ1M2dEIzT0xhRHFzeUJ3ZW5Wamt3V1Z6Q3R6?=
 =?utf-8?B?M1pTSThXTTUxWVBTWVUvR1JpNGMvM0tRUmpROGVWL0FDSHRaaGF6Uis2UVh4?=
 =?utf-8?B?VzRkd3ZJYldsWGFCV3Jkdit3bEVWTG1KMDhvTnJPYnM4TFZoTHI5VjFMNGVq?=
 =?utf-8?B?aEFRS3NTdWs5UVdXR2RkSmd6SGFST0JkU3VUU1VSTHV3NENmdnpPeXQzaEww?=
 =?utf-8?B?M0hwQ3FxdkNQYlBtRjZrZ1FnK1M2Mit1VVYyVFJoWVNYcU53U2hXdXZ2V0RK?=
 =?utf-8?B?dFZuUHB2WlFkbnFmaWducUFNY21BQzhvZWVVTU5EZ0MrSiswMndtdFkxelEx?=
 =?utf-8?B?aEx0eFZQUHk0bXBZOXMyWGRxem1kN3kxUUZldkpHQTNlWVo2Q2FEYUwvbXJK?=
 =?utf-8?B?NVFUMVZZdHBXSStuUkdlU2NmLzFJSFRYUmJIbzlYQ1dGcXVRZ3R6d2JONWE1?=
 =?utf-8?B?dDRGM3VqYU1xZjdvNzNSaE0xdFR4LzhIL3JFS0R1Ynoyd29adGdOSTgyWFk0?=
 =?utf-8?B?TkNNanVnMytwN0xGODlOQ2t2YW00SkdLNVFrcTRKclQvKzYrN0NaRHNLMlRv?=
 =?utf-8?Q?NFyQ60dxg4oGO2Xu5j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4eccd9-1608-4695-f63c-08df123e1f56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:56:53.5546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7znh6eg3fH1OW3+wleEVnQPq6oPd3VofVtoY9KqRq8IjrHniwOGAsqary99nVxGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

On 9/11/26 17:42, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> This ioctl might trigger GPU work through ttm so make sure the GPU
> is awake.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> [shahyan.soltani@amd.com: Applied the same logic to
> !amdgpu_gem_are_domains_valid(args->in.domains)]
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 43 ++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0d579517c03c..7b92e7b9fbb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -33,6 +33,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-unwrap.h>
>  #include <linux/uaccess.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_drv.h>
> @@ -442,19 +443,31 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	uint32_t handle, initial_domain;
>  	int r;
>  
> +	r = pm_runtime_resume_and_get(dev->dev);
> +	if (r < 0)
> +		return r;

You might be able to replace this with a much simpler guard based approach, e.g. something like this:

guard(pm_runtime_active)(dev->dev);

A guard automatically calls pm_runtime_put()/pm_runtime_put_autosuspend() when it run out of scope (e.g. on the closing } or when return is used).

That saves you all the error handling which makes this patch so complicated.

See the DEFINE_GUARD() lines in include/linux/pm_runtime.h as well.

Regards,
Christian.

> +
>  	/* reject invalid gem flags */
> -	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
> -		return -EINVAL;
> +	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK) {
> +		r = -EINVAL;
> +		goto pm_out;
> +	}
>  
>  	/* reject invalid gem domains */
> -	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
> -		return -EINVAL;
> -	if (!amdgpu_gem_are_domains_valid(args->in.domains))
> -		return -EINVAL;
> +	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK) {
> +		r = -EINVAL;
> +		goto pm_out;
> +	}
> +
> +	if (!amdgpu_gem_are_domains_valid(args->in.domains)) {
> +		r = -EINVAL;
> +		goto pm_out;
> +	}
>  
>  	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
>  		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto pm_out;
>  	}
>  
>  	/* always clear VRAM */
> @@ -468,7 +481,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  			 * passed to bo list
>  			 */
>  			DRM_ERROR("GDS bo cannot be per-vm-bo\n");
> -			return -EINVAL;
> +			r = -EINVAL;
> +			goto pm_out;
>  		}
>  		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>  	}
> @@ -476,7 +490,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>  		r = amdgpu_bo_reserve(vm->root.bo, false);
>  		if (r)
> -			return r;
> +			goto pm_out;
>  
>  		resv = vm->root.bo->tbo.base.resv;
>  	}
> @@ -509,17 +523,22 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  		amdgpu_bo_unreserve(vm->root.bo);
>  	}
>  	if (r)
> -		return r;
> +		goto pm_out;
>  
>  	r = drm_gem_handle_create(filp, gobj, &handle);
>  	/* drop reference from allocate - handle holds it now */
>  	drm_gem_object_put(gobj);
>  	if (r)
> -		return r;
> +		goto pm_out;
>  
> +	r = 0;
>  	memset(args, 0, sizeof(*args));
>  	args->out.handle = handle;
> -	return 0;
> +
> +pm_out:
> +	pm_runtime_put_autosuspend(dev->dev);
> +
> +	return r;
>  }
>  
>  int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,

