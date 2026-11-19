Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D05606A33E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s5ebnDSX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C037F1123BF;
	Thu, 19 Nov 2026 13:28:07 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD921123BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2ZBdCr4frvwwXWJ4ERZEBhJuPHz5+hRhq7fIlUiQKzyUklWU3QK5dgCuPiQ9bYxheZ1fFfY9Rq8WlwAXnkduFu5CS0iUPTH8KfkRw1bNW8qLGmObfWJtkSo24PrfiMnVEmTtizpWBRkrVjbGugYc9Tf7xuP1lrlXp4xZQ12/cTFIOpwVvQ79zUl3Hwgn1EHUef3VEXzQXhe+Hh8Y4MipPmpFZTtjshukh7S+waZ+WdY7y0Sv824maSem5UHKaAdtF6h2OjrRgpjy4XXm+i/4JKME/YylvcgH51ctCB+HeqdoU8FhPnAYwMuGbhGn+VEZO6l1OpnTw8d+SWC38CJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gL82UWovbrrNLA+kUul9UoRwB0Hr/ylkZJelDPYpsZg=;
 b=TQN93FhyUHnt9shpNAx3pP6gZUqHeQEu4sAaMO0B3gUc0+Z82TfiKfk1jaGfx/4V67XqERXFfXqdKQsFaEu8zSi1zU899D4vD/NHKpSwBLly2A0w/JAAY9f/xViz155VHX5p2kTBbjCkGdHHbiKRqPaSw226rBIiaGOurlzhxJu7ht+Pum8kRiAXqIYh2A/ZhoWw8qyikck4Nj9AMb+WbjGoGYXlk43GGb3LXxAv/lZHxXsJuSfgQrRrS9740BcETFt5mpaogFTFATrW6tNDkUfRIVGmyCXy1jxdo9j3eujsgAkNDyjTU4iF9oBNSY5rsjEYVIghbAxbTAdCC+NkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL82UWovbrrNLA+kUul9UoRwB0Hr/ylkZJelDPYpsZg=;
 b=s5ebnDSX1Hfp4Et1k0w4wgowIrvQZgXQaV/2stvhVi09OxTI2q97WeTz5KBlOd4UWigO1UVDBMCRUa91qTEKv3eDyOPjhqd4k6ncDnMpY0loAw9ugJ/QhNdR84ux0kfsC1Ha+7fEBAlGEtiIPZTFau7t/MunCU+zA4Iw9iOqhpM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 13:27:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:27:53 +0000
Message-ID: <d6894d7d-0c59-4a3a-8ef7-5fee8e9c88f8@amd.com>
Date: Thu, 19 Nov 2026 14:27:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/amdgpu: reserve only what the caller asks for in
 lock_pd
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-5-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-5-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: a598999a-fb83-41a6-cdd4-08df4640ea71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KKl39z1zYD1ukeCY7Yt56tV+b2x/JWFu9gVRmcTynwNvx+XuCqnPzZfUuODomQ+ulc5B1VWinFOoR9ieUN0ij5YL2rBtsNYnb6FNqsjxrSVH/g2BA4RHqb9SF0EnY0aZO3PetVoIexhL2DRHhK1uLj6AqMCKraus3ch0PT0LMsiXOStoDW3LSYQSlAylFq1tlveYXvlyxrFyYLuiMweJfRcHKPDtbaMHRM67VSgTLlXC17kkNMqTYVaRH1DZR22TOZx4NojJm1Pz1FD09k6SNSv7YytE3vqlDZ3NgnjlSyVWtlySoXiEz3vnNmsi1L2lYN0pNQiQQNXYGf1t7hFPbz07xQAmn9+xpQD5IKvt8jsRgi0jSOgc8tm9Bf+Lhx73TymOwg5gusU2TVjefP9WF5QgCXJa6xe1ujqh7TN46ZfCumBk3BfhQ6p2NWKGsSxMzxu9dJKD4cKEoxjxvp4lI1kccq5/L/5fIhl+PyPU4c1VP6gefZbhKySI9nx0gMrZznL+TIRJspoEwfS3DEnnGJb1oBWWr85QxXz+ZGEE3J55E89laTph1OVb9ZRmYGN3GE6IcUdq+vCUHceD5yf72weCgjXYNpym9Wg144BStrAjb528aLdnqQrEupPeqiieISq42Q95omGvydeeWyuIktkM/zu6Q91cD/I649foT0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHBGSWh4d3Z1OWJYdjFabTRMS0ZSM0hQcTd1U0NQUURCQlNSWFpNaFdKLzFZ?=
 =?utf-8?B?QkJwVTM2YWwxWi9ldkk4cnFqamt6bXF6dHN0cFNEdThDaHk5eE5mWk41SERN?=
 =?utf-8?B?OXJ6YmNlaTNvR2pEaG5MOGhDV2JGZFVQYVorbnZJcm11Sm1LWVFqanFzd0Nx?=
 =?utf-8?B?REVXVTFyMlhKY2JIN0loTnlwQzRDdmIxNnRDOGx6amhLZVd1NjA4WHFJUVJQ?=
 =?utf-8?B?S2NBSHVINzNUVVo2ZVNETDlNUjFleERqY3hWTm9yV3VpMUlhYkpEaTQ3N0du?=
 =?utf-8?B?Q1FBMVVITG5SMVE4ajViRWJpVTNwTHdCN1dpMkFBTU16ZmY0blhQRkloelFw?=
 =?utf-8?B?Yi8xM3ZkbEEwRyt5WWorZFZxbmh3VUcxZXl1ZzgwbEVya1VKZmZOV0piR1cx?=
 =?utf-8?B?bVZVSmxQcC9kb0JzbnBFRzhWeFdYN0FOclB1VkJGVmx6NXYrbjdvZjM2b3I4?=
 =?utf-8?B?ZnNhc1U0c2djRHVXbVFqMjUxeVlYQWp5aW5CTXEweG1aZi9sdXU3Ums2d0Z4?=
 =?utf-8?B?MEJJWHYzYVpWSmMyeUpkZ3d5cmRlc0xjZ1lGYTlwYURxbFp4RjdtM3RaQlZ5?=
 =?utf-8?B?SDFRY1J3eEp3bDd2NHJmK1dNdllQOUtMTTNvYXFKYnRwaFMxdnhYWldWcjR0?=
 =?utf-8?B?MEI4VDBsQzlqWlNRQ1VYZEl1bnI1M1VnY2twVzBDRWN4cE1JYUFNZnBOcVhX?=
 =?utf-8?B?UDV2dXhvWWhHdkhuVm8vVmZqcUpsTGpOd0kya2xJazRob2RFNEpONDRUZ1Nt?=
 =?utf-8?B?dzZCaWxwVDJFNTdyZ2FOWUdyQVZIbU9lY3FVTHJSc2Y0ZHltc2pTaEFJUmc0?=
 =?utf-8?B?RmdmR1E3dDVvUlJ3dENYeml0QWtBam9uRFNIbTh4S0hHUkVnQzdES25NY2RH?=
 =?utf-8?B?VTVTVEhYQm5BV3FlY0p2QUt1ZWFqamUwWTdFM0N3cUk0ck50RGJVVXRHUXp3?=
 =?utf-8?B?djBsVE92ZWIzTGQ2WVREeHJKMEp0dERDYWtBbzVreFNLUmI4d0dvTWd2OXNS?=
 =?utf-8?B?eGVCN3AyVjhDbnN4d2lCTkVTNFRrNDFDNTJaVkdyVXRxQVNDYk5CWjdDMFFX?=
 =?utf-8?B?MHY5K0RYZ1R5NzIxcmlmUGRhRkF6S0NOUmN4V0FucjFENmlsUXNhK0VBU3FU?=
 =?utf-8?B?L1RGazFiYitkMHg3UmNWWklqcUl3ZHAvbTFoanh3NkdwZGtycFc4clE3Tlov?=
 =?utf-8?B?bGFKb3dlakx1c1REVXZONkRqcTByYlBwOGVsYlZHam8zekt3NjJDbXhoQ1hR?=
 =?utf-8?B?RVRJSVpnVm1HaXlWVVNxbVdobDM0MW1Fb2VIaFRseDFmQk5mNkxOTTBLMU9D?=
 =?utf-8?B?dWlBTzFrcHNhWnhRYTNpNExvckxtWWJrNjhlcko1RjFya1pmY2hsb2M4SDVv?=
 =?utf-8?B?THJ4Y2Q1eXNrSkVEWWduQXJkUUpCaEhRNjBGakhvRzFBVVU1blpQU3lHSVBL?=
 =?utf-8?B?K3IvK2NnenNWVmNUQXZwa0oydDdNY2t1dEpFN0F3UFJNcWZEREtEcTV3OGs3?=
 =?utf-8?B?ZDVXOW02clFEenU1UVRQQVFYbTB2Yzd4cVJVTC96SXpwNmdUdGtUN2Mxekxj?=
 =?utf-8?B?NUk3OC9XTjhUSU5EK0N5a2tTVjg4ZlpkbmluZDk1TDJETldEc2hSRGp0Y2FB?=
 =?utf-8?B?RThOVnpBZXVyYTdLeitvOUpTUmVvbzBKWGFKcWRyTXZxbS93OVpZd29IelZM?=
 =?utf-8?B?QlIzZ01WU0hHZGhkbTlDbnhlUTlXckxPSEQrSmpXN1dzWmdQd05VSUpsZUlj?=
 =?utf-8?B?bGlJMkc0N0t6L09kZE1YeFZpVGpOaXBmN2QxSnUwS096N2dSUXR6MWhhSTBY?=
 =?utf-8?B?Q3gwQ2Z6Wnk2Slp3TEo1M2FuclV1WFNoRjVreE1semkvL3UxcXhFTzRGWHBS?=
 =?utf-8?B?SnByV3hnMGM3VGRpK0huck95ZkNtQVQzcFFxSHhGZXFxZDlQeXZMYVNzKzRO?=
 =?utf-8?B?QUtvQ0NOUXJrbU9QeXozY1lyTUxEOVJsUDUxNnYyczNhNU02OWN4cVBwZC9a?=
 =?utf-8?B?VVZPV2VSUFV3cGdVSTRxbnVEU3NOVC9lR1VXSGJkS2o3eTFvRlZkaDFrUGNn?=
 =?utf-8?B?U3FIQzJoVU8vcWRmbmhnSFEzVktKYmhOMHBKYmRFak9zN051NlErMzhiRjZy?=
 =?utf-8?B?WnlzSS9kWXJnOHF4Qk1MQ1VwdG1HRis0VXNiUUFObDlXZGx2UjU0aHNrcHRx?=
 =?utf-8?B?SXZqWWE2OWlLWWNlZC9SeGh2YjF0bU1HVHVGTU9mNkFIeHJjQ2lUK3FRV2F6?=
 =?utf-8?B?WFhQWVREd1UyQS9OSFd6amllVWErMmFhMWE1eVV6S0RpOS9CZ3JVM2R3ZUpJ?=
 =?utf-8?Q?dLPGjz1Rac0Hk7VyZN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a598999a-fb83-41a6-cdd4-08df4640ea71
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:27:53.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYS2x+0lu5pTTG9fjjwoYCtAIDPyCHVuZG1uq2oPwD6YbiQEYbBaq+At5AbPwmty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 19:52, Benjamin Cheng wrote:
> amdgpu_vm_lock_pd() reserved AMDGPU_VM_UPDATE_FENCES for every caller,
> including ones that only lock the root PD to add or remove a mapping and
> never update the page tables.

Yeah clear NAK.

First of all reserving fences is cheap there is no need to avoid that.

Then that completely defines the purpose of the amdgpu_vm_lock_pd() function.

Regards,
Christian.

> 
> Address this by making it only reserve what the caller asks for, so that
> such callers have the option to not over-reserve. The only touched
> call-sites in this change are the ones that do require fences.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c       |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  8 +++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  3 ++-
>  7 files changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a6616447abc8..56f761089b87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1188,7 +1188,8 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
>  	ctx->sync = &mem->sync;
>  	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>  	drm_exec_until_all_locked(&ctx->exec) {
> -		ret = amdgpu_vm_lock_pd(vm, &ctx->exec, 2);
> +		ret = amdgpu_vm_lock_pd(vm, &ctx->exec,
> +					AMDGPU_VM_UPDATE_FENCES + 2);
>  		drm_exec_retry_on_contention(&ctx->exec);
>  		if (unlikely(ret))
>  			goto error;
> @@ -1235,8 +1236,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
>  				&& map_type != BO_VM_ALL))
>  				continue;
>  
> -			ret = amdgpu_vm_lock_pd(entry->bo_va->base.vm,
> -						&ctx->exec, 2);
> +			ret = amdgpu_vm_lock_pd(entry->bo_va->base.vm, &ctx->exec,
> +						AMDGPU_VM_UPDATE_FENCES + 2);
>  			drm_exec_retry_on_contention(&ctx->exec);
>  			if (unlikely(ret))
>  				goto error;
> @@ -2729,7 +2730,8 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>  		/* Reserve all the page directories */
>  		list_for_each_entry(peer_vm, &process_info->vm_list_head,
>  				    vm_list_node) {
> -			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
> +			ret = amdgpu_vm_lock_pd(peer_vm, &exec,
> +						AMDGPU_VM_UPDATE_FENCES + 2);
>  			drm_exec_retry_on_contention(&exec);
>  			if (unlikely(ret))
>  				goto unreserve_out;
> @@ -2993,7 +2995,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  	drm_exec_until_all_locked(&exec) {
>  		list_for_each_entry(peer_vm, &process_info->vm_list_head,
>  				    vm_list_node) {
> -			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
> +			ret = amdgpu_vm_lock_pd(peer_vm, &exec,
> +						AMDGPU_VM_UPDATE_FENCES + 2);
>  			drm_exec_retry_on_contention(&exec);
>  			if (unlikely(ret)) {
>  				pr_err("Locking VM PD failed, ret: %d\n", ret);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 71e2b83faa12..771ab4388eb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -940,7 +940,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	}
>  
>  	drm_exec_until_all_locked(&p->exec) {
> -		r = amdgpu_vm_lock_pd(&fpriv->vm, &p->exec, 1 + p->gang_size);
> +		r = amdgpu_vm_lock_pd(&fpriv->vm, &p->exec,
> +				      AMDGPU_VM_UPDATE_FENCES + 1 + p->gang_size);
>  		drm_exec_retry_on_contention(&p->exec);
>  		if (unlikely(r))
>  			goto out_free_user_pages;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index eb7473ed9e0e..dfb44426b1e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -345,7 +345,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  		if (unlikely(r))
>  			goto out_unlock;
>  
> -		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		r = amdgpu_vm_lock_pd(vm, &exec, AMDGPU_VM_UPDATE_FENCES);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(r))
>  			goto out_unlock;
> @@ -1002,7 +1002,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  				goto error;
>  		}
>  
> -		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
> +		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec,
> +				      AMDGPU_VM_UPDATE_FENCES + 2);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(r))
>  			goto error;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 2403cd911058..8a613d83ed53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3053,7 +3053,8 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
>  			goto fini;
>  
>  		for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
> -			r = amdgpu_vm_lock_pd(bo_base->vm, &exec, 0);
> +			r = amdgpu_vm_lock_pd(bo_base->vm, &exec,
> +					      AMDGPU_VM_UPDATE_FENCES);
>  			drm_exec_retry_on_contention(&exec);
>  			if (unlikely(r))
>  				goto fini;
> @@ -4788,7 +4789,8 @@ static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
>  				goto out;
>  		}
>  
> -		r = amdgpu_vm_lock_pd(&adev->ualink.npa_vm, exec, 0);
> +		r = amdgpu_vm_lock_pd(&adev->ualink.npa_vm, exec,
> +				      AMDGPU_VM_UPDATE_FENCES);
>  		drm_exec_retry_on_contention(exec);
>  		if (unlikely(r))
>  			goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ed6f3b67e872..73e58d1a32ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1054,10 +1054,10 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		/*
> -		 * Rearm adds one BOOKKEEP fence and validation may queue move fences
> -		 * on the root PD BO, so reserve caller-side slots accordingly.
> +		 * Rearm adds one BOOKKEEP fence and validation requires
> +		 * AMDGPU_VM_UPDATE_FENCES.
>  		 */
> -		ret = amdgpu_vm_lock_pd(vm, &exec, TTM_NUM_MOVE_FENCES + 1);
> +		ret = amdgpu_vm_lock_pd(vm, &exec, AMDGPU_VM_UPDATE_FENCES + 1);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto unlock_all;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f4a836594e7c..daf0e75d0bb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -455,15 +455,17 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   *
>   * @vm: vm providing the BOs
>   * @exec: drm execution context
> - * @num_fences: number of extra fences to reserve
> + * @num_fences: number of fence slots to reserve, 0 to only lock the PD
>   *
>   * Lock the VM root PD in the DRM execution context.
>   */
>  int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>  		      unsigned int num_fences)
>  {
> -	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base,
> -				    AMDGPU_VM_UPDATE_FENCES + num_fences);
> +	if (!num_fences)
> +		return drm_exec_lock_obj(exec, &vm->root.bo->tbo.base);
> +
> +	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base, num_fences);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3f32507e2aae..6dcc12289e92 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1686,7 +1686,8 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
>  			}
>  			vm = drm_priv_to_vm(pdd->drm_priv);
>  
> -			r = amdgpu_vm_lock_pd(vm, &ctx->exec, 2);
> +			r = amdgpu_vm_lock_pd(vm, &ctx->exec,
> +					      AMDGPU_VM_UPDATE_FENCES + 2);
>  			drm_exec_retry_on_contention(&ctx->exec);
>  			if (unlikely(r)) {
>  				pr_debug("failed %d to reserve bo\n", r);

