Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AB1CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BB810E51A;
	Mon, 22 Jun 2026 08:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0O6MvqNT";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E366010E51A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4gK6c5b8d7qWnUp7h1szvq3GBzpZVg/AdGYUDPBtrFWizLA+2KJtkrexgYQLeYYSoXowsnejOOMTEiIdBc3/Ak+3JpYsCjdkx09fvNh1Ta5pNneE2y9zOqlpr1/TF0zs6GLhey9m+G53BWh10sg3IjkEk2KGtBInM+ZaMvRkirIKm2xagBUL8Snk8/Hb4wq8O62FpL01BRWNE6AB8bHkfSnyqF3CJzECuwL16askPCuc4ocrcImFuNXJropub4fil/V0je2UB5C39V0c+jmY8pH0zuTF4JVo7Rf3OgrNbWK18J0/ry5JUFpXMhxZzHVg785OxT0m0cOJtHTojy25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDSh8fwAlwY8xUZ3YGhDZmFZGgu99RbmuseG3EMBCZ0=;
 b=vZfkriR2s72TCaY7FuOjkcAK/FYo8MzMPUI5saQNIir18aezCMJSB39rqvM0pe9/pDkbPgnsgktbT5qI3Y+kF3vV/En82IBo0hJy/Npnwqe+Zw6RbuGz8KVV5a3EZJ3G2nPMXRQ/qur5p1TdWCJQ6D7adySyeN3cygHyXNWHVoE2SVYrnjwS1DFa1C1EKYJeiM6PLsRidQtSh6oJtCTq2tjlWXEPnEuGmxai+ibGwkNk+h/auQJuBP4yzm15dg8QgH/iPtBbUYZsRezUdcx9pjKfV2eqYkKl01FX1Sn1IvrfqbsXLqeMnsnlOYe5vNEa2FYqDAnozbmxnxvpoSEz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDSh8fwAlwY8xUZ3YGhDZmFZGgu99RbmuseG3EMBCZ0=;
 b=0O6MvqNT7PkXNKZQENc/ZQFa9HFNw6ZG2nPM7nRtnWelVB6LclfiZJDo/VPn5IBGyDBPVD56LoTwctexsCVrj5Z+hIntqsmyZyicxuko5P9Xlslj7Lt725GaRnr6ofA4gcVACYBOZ8gN4jyhv4dQ0xcHXvdCoQBnfkCM3H0GqRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:15:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 08:15:30 +0000
Message-ID: <5eadae57-bc7c-4c22-9e02-04c32d7e6e97@amd.com>
Date: Mon, 22 Jun 2026 10:15:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>
References: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0c9085-d0e1-4f5c-d98f-08ded0366cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EQvujSF+XKR/bFRMdtyfnIE962YtYJ8q1hrnsdRzmRCVvFjotcLbKaI3WVN52xl3Zw1abHg7ecdb7r0s9m72+kx5xieqyHrdssTTN+pPUXoM69+bfnJHTLknG1uLXjEyBaFDmPbqFTnClOm9PiExr7EUnF45vNP5YwN5jGbuj2wPCQRld2j5OqwkfHDaOFkQcyYDmHuiq57aZYbRBfsje8TKBpFWBH5AVUxrwhLIyBPsZehgw1urmLNu0cIoRTFDWY2i2LgFnaQkles08Xe5DBADTyAv9cGn1GHk4Z9FV4lXgmdUr/uiw6ZUoW+vjwm1tQ8ONZ0jJoakd152xc1jRekMuuX+cDly21ECW9j90Uv/DMOe/XFy7Gh0oeiDoSSSumOPdki9T1AR/BK9Kd1+AHuxwjBeGFiH7FYs6K7nLAzpmE5Q68EHAuu2DxFMZxCla1gtTddL5ZgGp9OkiuZKyWKCLMVpU5r27l5fz5gIIMmpp/8KwEMpB2S/FGlaoxmoz8ZCLZZTk4DcZV9tG7bbSt7/CvIaOhQQUU9jWqfpDsGGCm+oDXSuUJaqmSS7p2kr0bKlmYNgBOlCn82Sn6q0U7c0Ez0ABBXhvTZrtQBG+uphrrCFBMgaTMC0iSmY/Yhkozpb5ztm+32Wh1OVTj41xNdi/J8kmtrYpc9Lk67aTNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhBejlEdnBQa1BtQUxjSXVOU2lKNUcwKzZOdFlveXRoRUNmZERpWmRQTVl3?=
 =?utf-8?B?UVJwa2hTUG5oNGZBSy9ncGZWcUYwN1drU2w3b25vZVhIR09WMFFsNUQ4M0JT?=
 =?utf-8?B?aVpLRlFjUXNQN05QZWFYcWprYlQxYlU4bzVhd0VJQkoyT3hyQjFyMW1yQmhD?=
 =?utf-8?B?Qm52THVtYUduZ1JwVDRjTUNLNzd4bUQzVWU1VTQ1R3M3VWZQbVV2MXY2V0Zo?=
 =?utf-8?B?WnluU2RkZUpEYno5VlVGUWlpRUZORGlIdm9UQlVrMTRpRkpRdGlaK2prMjZl?=
 =?utf-8?B?dFc0dU56eFRIL0FuRFhGamF3Vm1jY3ZUSnEzR01mRktkOGFiSVllbC9NZGI1?=
 =?utf-8?B?VjVvYTFZOWk3empFQXZrbERIaFVtbkhyMWd2OWVabWNoNUJYM1BrRkxqQ3Ex?=
 =?utf-8?B?cWVvbzZYeHlQZWxCdFBsdUlNWWpxbDVWOTBsUFVIQXZvZk8wMlhwVks1ek45?=
 =?utf-8?B?dXpseWZDb0tMeDdxNDBLRnZNRXIwSVhnckJTUS9OczZlUkFHYVh2VzF1STU5?=
 =?utf-8?B?YXB0dEh3WUFTYUVoSjdBdGhVWVlBNm4zZEFwZjM5YWNNakpSaEkxZitWYVEx?=
 =?utf-8?B?TFdqMmhYK01SL093a1A4SFg1ZUtDajM5em5EN1hBMHJ0MDJrbEVSZzR4OHZN?=
 =?utf-8?B?cU0yQ3JUaHJKOHRTd3JxcnFaeU5FUEpMNENINlVmdzVUSTRITEMrYTAzYmNN?=
 =?utf-8?B?Y0M4STNDS2JSaDZYcUcyOFhnU21sZ3ltMEhmNlphbFlDRWg0YzRxL0hDc3hO?=
 =?utf-8?B?a1Z2YWduOFIzV3BUMWE1MGRXS3FmZms4WFdQWGcwcEdsQmwySFUrMlA3Nysy?=
 =?utf-8?B?S29nc0tjVjYydTM1S0Y4MWdIQmRQbnVIRWNuTHJSNTV4M2lmQ0hYQWVxSWRL?=
 =?utf-8?B?WlZBdTRzRGlWYWthTFBlOWFJcHdLZEJNYkRXb0VSVEkzaW5SZExNL0NzeE5a?=
 =?utf-8?B?Nm5OVnczQ2hzMXd3dmtmaTMyYUg0UUZ4UzVaRXd6dUI3NStVOWtaOGpSNjR6?=
 =?utf-8?B?aEpyMTR3ZnNubHVFWUlpdkY4ZTF5VlREWExTaUE3bFpmak1OWmVCT01Cdm4v?=
 =?utf-8?B?SXljMFRYQTZ5VVZsaGkwQjZGKzlwbStEYkU4QktpRTVlNE1hQXZ2eEQxMkxj?=
 =?utf-8?B?RVE3VGNCQ291UXExaHd0RmhwaHRaQTlOT2ZSU0RLdEN5cnlDQVNDMlFzQXJ4?=
 =?utf-8?B?QWtjcW9ub05vYmZhbktKajVUMWxFb1lNSVdkOEdkRnRzOEhvUVdVOVZMZXp2?=
 =?utf-8?B?THVCb2QvNkh6ZXRkY0s5Mld5aHFuNjZiSnBCa0ZBU3UrRGVSMWFOOWtXaW9V?=
 =?utf-8?B?TEJwYXh3NFRNOCt1clVBQWtvS1kvMkRERGdUR1BJcWFYUnY3NXJDZnBlc1JQ?=
 =?utf-8?B?eHU4dEp2K3dqS25NS0dwRTlFdHRWQjg4ZTcrU2ZMY3ZDS3YvN3VkRXMzRlha?=
 =?utf-8?B?cW5McWZXWkpVaFQrak5TZTAwaXhnR2VIU1I1OHFXaDRwVm13L2FsVTZER3Iv?=
 =?utf-8?B?NTlOeElOVjRyTzhpb0VwQ3JVdTg2VGxzeWJ1VGpueHA5RmdGcTBQTEluT2hF?=
 =?utf-8?B?RkpydVR1ZTVCWGt4eHp6WGk5eGFwajZNSHkyaFFwS2pQY1VpTzd5MElDNHZ0?=
 =?utf-8?B?cUVBUFozenFkRG5uUWFrYi9FVWhXMU9SYVgzNDJHcS95S2Z2KytVcGhtTnRJ?=
 =?utf-8?B?cUg1L0ZZQUF0bnhHMjhzWm1SYWFnbFEyeDlXM2cvT2h5ei9LRlhVL0xqaExE?=
 =?utf-8?B?a0dkUG9WRFRCUnkvZktzRGNqNEtZT29hOTFtZjhRNWEwWWVDNVlUaEU4MFI2?=
 =?utf-8?B?SE9BNFVBYlowb2VxUXJYSjlwWWIwSEQ5bmdNbXNyTjBhWE95SkJtUURVTW9i?=
 =?utf-8?B?MlVLS2YrRy9TaFhnYlhTU0FjNWgrQWNBYkFWWXVhRGxqdnhQY2J4dm1YZSs5?=
 =?utf-8?B?Y2k2WDB5UDJ0RndmVEEzbEJYa3RjNDZjWkF1VjYzTysvUEZnaksrMnNtMmg0?=
 =?utf-8?B?TnNHWjgvZEJaMFRRV2phWGN2OEwxQzhTWXpOQVZnb0o4M2kxOE9oUC84Lytm?=
 =?utf-8?B?bW9iQ09kZHJrbWRaaXh3L0hVYmtxaXl1NFFIczN1d2gxZXBUbVdCL1pEc2hx?=
 =?utf-8?B?RzM1TWl2QjBjVmZRb1FZNFREREZ5dlU0UGhwVlJEN1IwOUpsVXJ1d0lnOGMw?=
 =?utf-8?B?V3hkSVprTHZ5bmdaTzhDNFRlQWlaWnhjZTBhWDBmaWYyYU5qTFdlSk1kQ2Jj?=
 =?utf-8?B?TTdJZ2VvUTN6cEd6QnptWnAyeG1Xd3pEb1Zybmk0ZGE4RExxczZncENKd05k?=
 =?utf-8?Q?ezyl9x4hH62h6UM1vN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0c9085-d0e1-4f5c-d98f-08ded0366cb4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:15:30.7236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLaCu/JFECrJt0uvfsZwzxow+RptRzBjM405PolBxXuoWDMr+LphL7WCfZCRUfbp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844
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



On 6/19/26 19:17, Srinivasan Shanmugam wrote:
> amdgpu_device_ip_soft_reset() allocates an array of AMDGPU_MAX_RINGS
> ring pointers on the stack. On 64-bit builds this consumes around 1280
> bytes and triggers:
> 
> warning: stack frame size (1304) exceeds limit (1024)
> 
> Move the temporary ring pointer array to heap allocation to reduce stack
> usage.

Clear NAK.

GFP_KERNEL allocations are forbidden in the reset path.

You could use GFP_NOWAIT or GFP_ATOMIC, but that should be avoided as well.

Why is that array necessary in the first place?

Regards,
Christian.

> 
> Fixes: a6319ac34a13 ("drm/amdgpu: Add IP block soft reset as a GPU recovery method")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index 65505bc50399..eeb9383b1010 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -524,7 +524,7 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
>  				struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = guilty_ring->adev;
> -	struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
> +	struct amdgpu_ring **rings;
>  	struct amdgpu_ip_block *ip_block;
>  	enum amd_ip_block_type ip_type;
>  	u32 num_rings, ring_type_mask;
> @@ -539,6 +539,10 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	rings = kcalloc(AMDGPU_MAX_RINGS, sizeof(*rings), GFP_KERNEL);
> +	if (!rings)
> +		return -ENOMEM;
> +
>  	dev_err(adev->dev, "Starting %s IP block soft reset\n",
>  		ip_block->version->funcs->name);
>  
> @@ -546,20 +550,25 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
>  	amdgpu_filter_rings(adev, ring_type_mask, rings, &num_rings);
>  
>  	amdgpu_device_lock_reset_domain(adev->reset_domain);
> -	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring, guilty_fence);
> +	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring,
> +					     guilty_fence);
>  
>  	r = ip_block->version->funcs->soft_reset(ip_block);
>  
> -	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring, r);
> +	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring,
> +					       r);
>  	amdgpu_device_unlock_reset_domain(adev->reset_domain);
>  
>  	if (r) {
>  		dev_err(adev->dev, "Failed %s IP block soft reset: %d\n",
>  			ip_block->version->funcs->name, r);
> -		return r;
> +		goto out_free;
>  	}
>  
>  	dev_err(adev->dev, "Successful %s IP block soft reset\n",
>  		ip_block->version->funcs->name);
> -	return 0;
> +
> +out_free:
> +	kfree(rings);
> +	return r;
>  }

