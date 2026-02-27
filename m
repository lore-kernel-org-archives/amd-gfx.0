Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62A5FD7F91
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 10:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCE210EAF4;
	Fri, 27 Feb 2026 10:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HNJB9twM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F073510EAF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 10:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj04LDFSVspfrBMNrtd47rNc1wc7BX4pCJkkMF3KFKzwaO5lsuvoRTPlIgpP7m/n++dqtrUhCGFftL1lr4v/E54M5Q4avd8Y4vpAROBK9+ADvk/zlZsb3A124cXPUtXNwHpVUXH+BBUUECmTRuDI/ZkNic8kSHH+qsqj9DFf6mnRNrLny7fpBkAaZ3uk2L7rONT14fAK083hRL/eAv4yqMUhz5/NDFPR87zvL5AriqazkS8CJ6gV57FiZj0O5VCI4Bmmc78r0yTxwi01uulfznZ6Y9vg1lcAcNBq11C9jvkS6Xw3M9GNYaEVBfuBrsHlHSoE/Hl0A4GxDDMqVoXx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bfV/zaDB0G/MAIGiGN469pGKaxGZqMGGYzYt02q8Us=;
 b=DUePnNCVIRHnhgxnOPvPnTyPkhNyHZBfTQw5JJo6ydCbAkXZoZMx5qfz3zQw9HdTjeNQ0PkUa9xvFDxHdmn/+J3EXp29EqzoNf9PfXkgmCXoBIDNF6K1KdpnVevfe1/IlmqiHqTQZicw1jHHX5Wu/kDwia4PhZL04CrZ90aCUw7cEC5rM5zA5DKWfoZazFsBG79q5DY/aRbXBsqKHrliD25H7oQWOQLyijsRMqvS6FhR/IvJQtOiXue3FcdrWHKAqe9dzf6BC+91EqroEca1xQ5lZ6H5fpV+LuPkTd1/u+iM9ONwhHij+GneV70Mnc1htV4wILMlKSh2eTq764fquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bfV/zaDB0G/MAIGiGN469pGKaxGZqMGGYzYt02q8Us=;
 b=HNJB9twMz63pIc63hoNIBjMv5JnA01soxDqiWG6PR6b2+aobFfykAt8352tcbLSYR+iHHMuZto8F3veFrpqMyCB4mBr31d3fwcOQf6hLw/L1TLGLR8vEhP+QYmquCZDbVI5AndheJ0weqbGJij8g0my89r6imjOgchjocsd8eF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 10:34:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 10:34:23 +0000
Message-ID: <fd20336b-7c82-4b8c-a7e0-af5711402611@amd.com>
Date: Fri, 27 Feb 2026 11:34:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: Remove impossible NULL check from
 amdgpu_userq_signal_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
References: <20260226154918.84354-1-tvrtko.ursulin@igalia.com>
 <20260227094530.99833-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260227094530.99833-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0058.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: a4646073-d354-49cf-6f4d-08de75ebc5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 1WLA8YQePxb1GIxO2RJMe2FlAbBny6t71zUsrfbcE2gdAmSzGZTPlPFS7kyWBYbaXYBK9r3XEV1yk15RiaE394AYCME3NwjRPzN7FsKprTsF5qY6gPFKT98xphSm6wP0oFyZbbSWIr2LYRhrkRFBtRWJrG7YAgayo1SJuIAUoqYQR9LUCsfYQd6UGgwW7NVi7MkX8PptMFteJ3Mmeeb8rWrsL9Sw1stdasjGu4ntG+zCggQkM3l5URzccPf0HsL3kujXhzvPwKvrXmu9X2uHByioZ9nQUfzmOisTcuvhNoftCuKPuNCUukB0R8ZGBcoYgNE4UjOKub43rImKlHlhS4foTraLRVwA6FKedUYJpH+M/tWZjXffLdJx0q8b4jY4EgmMzlhDJVYU0K1YQdoGqWHMDovWrA7GOuof1ZjItwILYPmvOFjZsXVU0+0f4LPEPhdCsG5RWYbMaB8Gs7sqsn7GRgCnneKzW2lKCe57+0fkKpP0KIzLnzK2KS3ziK6FJ75NhxbUNh7m8awXv0d2b0Ombx3dvclglFpT35qWseBF/VH5DsthdNKnqLNDbT3jLN8QxnLSqUmzSMI4ny7TxnwbPC1JhxDgu8Q8OaIvDHDV/rq7De70jh7cR0nI3snVYGZVg2lQQhQaRjwG63ctPb0j7knJjKyH3gDmEM5jYvFGaH/LDbaR04k2pU32oTrJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25JWkJnTGh2Z254M2VBU3JyQVdRUkdDQXlKS1lhMjQwZk1COHpYSlRjeCtM?=
 =?utf-8?B?RWZ6dVBpVzVScWZLdFF4ckVmZHNWVTJHdmtqWUQ3YkY1Sm9yTnVNbnFzbVJo?=
 =?utf-8?B?ZVZHQkpnV1V3V1NESE1hZVdFVXVycjJCM0hOa0JXeWJKRCtyWVFacS9RejY0?=
 =?utf-8?B?OG43djdJVDZMcFVnT3dUWVFLcGw2M2VXMDl1aHJZSCtUS3h4MXBra1Jad3RE?=
 =?utf-8?B?YXBNL3hTL0hlUlVZaXRoNXBudXBENTY3TXBZcUU3bzJFcVZubTdtZ1JxcTBW?=
 =?utf-8?B?TEtwKzd1OWljRGlMbnJVdjI1K00vR2tEUlZaQ3NyU3RGcGJwM3B1dkRXR05R?=
 =?utf-8?B?VVdKTlZ2aTFyQXRvWWoyd0JOUjhkOGN6QnZ6eEFqRlpsSUdyRHVtbktUV0N3?=
 =?utf-8?B?dUZuOFFqR0dlM3BkZm4wVTdWV1lSdk02aEpjSEVHTG5UVzgyYXJ1Z0hLRk9z?=
 =?utf-8?B?MjdIV09kUXRHRWQ2aFp5bWV6d3l0VUtjU3BxVmVwU3dscGxhT210b3ZXQ1Va?=
 =?utf-8?B?bkFTR0IyTzFNYmZueDRHSEp3a0dib2JCdzVRbGpheENkNWs5VU9tcmZ3K0o5?=
 =?utf-8?B?alJvWGh6VDVybUl0d3FkNFNvU0lTSHV0NUN3ZXEyS3pmWkNvWFhvNlRGZ1dG?=
 =?utf-8?B?bHlVYk9Kc29uSGR3NVBMcW44bEM5bmNMSTVKc2ErcDQySERpRHo2ZkhSem53?=
 =?utf-8?B?bytRM29Oc0FiQU5adWNkME5PYnV4RXBrb05Ubm92YStBUzczemQxR0ZvVFhE?=
 =?utf-8?B?REVTeUJsTFlqL0VlZjlTUC9WY0dDeVJoRmRreXI4WklUcjFwdUIrYmF3eXRh?=
 =?utf-8?B?Z0Z4dWxDWC9GekU3TjBRT2l2UEwwU0haSnNKZ2VRVmVFSmJDYXFxVUptY25o?=
 =?utf-8?B?T1NyUnRyaE52VWZwWXZ4alRMUmRxT1BKM2dLYSttN1Q0ejNMZ2NlSDRCVnN5?=
 =?utf-8?B?b0FvLytSZHp6cU4xdlhhVmcyeU91dHJLMEhDZjFFbDF1cU5LL3NrckRUNHRn?=
 =?utf-8?B?YzNnSGJMdVlOQjlnZWJuT1pna2UvNVR5MmlxbmdicWFma3FCY2FJNEpXWTY2?=
 =?utf-8?B?YXJDM3Rmc1B4ZDhvek9yM3pwdnM2bjR5anZSNEVCUmw1UzQyWjBDTmx1WC9M?=
 =?utf-8?B?OUNpRjZqS3ptU1BOeUR3UEFVYm9FQUxPckszUnh6bjh6bEM4ZjJQUlc3Z3Jj?=
 =?utf-8?B?L0MxVEZSU0tMY1ZHU2VkbUhja2xsYTAzOU9EbVR4SmY1RGZlVXdZWXQ4QXlk?=
 =?utf-8?B?U0x3dXZaaGRQaGt5TXdYMTlaN2g3WkJOVmlYZmIrVXRMU2d5dkN2Vjkraisr?=
 =?utf-8?B?dXFzT3NIT1JQd3FZRzJDbTE4dGFmM3NVU0FCRndtODZvdlFFRFdJV2MvejVv?=
 =?utf-8?B?cWxyYUJJSEdoYTEyYTRPcmJyRmo4S0JuTmc4bG5aNG1uWkorcjJJUnhzYVBD?=
 =?utf-8?B?WUZWL0cxYzczSkFxYkhiSzlVQUFHYndLNjk5MzEyVTBCS0pEYXo3UU5CckV0?=
 =?utf-8?B?cmtBSDBKZHRXVHVUcWZSZ1pRTjZkU3NwTzBFM1RmSEdqcm91YVl5NkxzbzFU?=
 =?utf-8?B?ZEtQL3dlUkJ2dzR1bHdlME5kM3VuN0ZkNnR4R2Z6aWFEYmZqZFBQK1k4Zi8y?=
 =?utf-8?B?U1JwdEVRdFZ1WnNyanBCS1hqczVWMFRoSVNZZEptWEpJakNyQ1FnRDhCdmsy?=
 =?utf-8?B?Um1ZOTk3NENoOUhHRjdlVzJmUWMvblIwYjBMYWZUZERDenJUeGZKNlpNWjJt?=
 =?utf-8?B?WGtVMU55M3l1U1FBRTlrZHUrSUhOQkpaOHUyK3Y1ODdWQUhZN01pcnFaeXlE?=
 =?utf-8?B?eHh4ZFV4RkIyaURHN3hnTENPUEp1MmcxWllEbDgzeXBINzdudTk1TS9FMFBU?=
 =?utf-8?B?dHpqRjZ0VW5nWGdSVi9MWHYwUzdqa0ZnRE9yTGo2cUhQQXJSeWo3M2VKV0Zv?=
 =?utf-8?B?TWd3anpRck1DejBLczJUUmNHeTlHSFMySXFqekVOekF6Rkl5ekNocGxHRUZn?=
 =?utf-8?B?NGNKN2VtK0hEZHJyV1hKZGRqNGlsQ0p6eFpOblJ0V21wKyt3NTl6eDRPOGZZ?=
 =?utf-8?B?L2VjNUxMUGpwdUVWOGovem1BbmhvZ3VsaWJXWnJnMVkrMXhtWm5nVW5zSDk3?=
 =?utf-8?B?VkROZkJMaklHeVAyQTU5QVlVdWZZYzk0Q2Uxem1Hbkt6ZjFxS2VCVXpRTkVw?=
 =?utf-8?B?cmFoZXd3WHdVVWhDOHdvT2l1OS9zRCtEeUdPN3l3RWxzVnplWDBUQUIzWWc3?=
 =?utf-8?B?Vkc2dlFmR1FBaWhReDY1cWJ1T2NjMzlHVXdoSVloQmZ2ajJsQ0NGbWlUSGw0?=
 =?utf-8?B?SWtUV3VmdUhaYkZzSVFEZ2s1L3o5QlRnbnJacnVQdVV6UlplY3h0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4646073-d354-49cf-6f4d-08de75ebc5aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:34:22.9754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYl3kGUcil2Ymok1E/UFUBd/JVQLngU55gcZoEN2KcrFgX/RxKqZ3FuBcrvhgrLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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

On 2/27/26 10:45, Tvrtko Ursulin wrote:
> LKP reports two suspicious NULL pointer checks, triggered by
> 4ca06f6fb45d ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
> but these checks were redundant even before. Remove them.
> 
> While doing this we notice the obj->resv NULL checks are redundant too,
> since they have already been dereferenced in the drm_exec locking pass.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202602262219.UY2pqzl2-lkp@intel.com/
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
>  * Drop the obj->resv checks too. (Christian)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index ba128b2a2d49..f54e0e2c0dbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -547,21 +547,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		}
>  	}
>  
> -	for (i = 0; i < num_read_bo_handles; i++) {
> -		if (!gobj_read || !gobj_read[i]->resv)
> -			continue;
> -
> +	for (i = 0; i < num_read_bo_handles; i++)
>  		dma_resv_add_fence(gobj_read[i]->resv, fence,
>  				   DMA_RESV_USAGE_READ);
> -	}
> -
> -	for (i = 0; i < num_write_bo_handles; i++) {
> -		if (!gobj_write || !gobj_write[i]->resv)
> -			continue;
>  
> +	for (i = 0; i < num_write_bo_handles; i++)
>  		dma_resv_add_fence(gobj_write[i]->resv, fence,
>  				   DMA_RESV_USAGE_WRITE);
> -	}
>  
>  	/* Add the created fence to syncobj/BO's */
>  	for (i = 0; i < num_syncobj_handles; i++)

