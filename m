Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4897DC56205
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 12:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08EB10E08A;
	Thu,  6 Aug 2026 12:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Opl2s5Be";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968D610E08A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 12:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIK7eufylEkyLaKRwPntHTszx227vfbaOuyji0oUugbdda1qn9FVt22wzGYqIjCvrRg7NSYmqbfYVghdQvnYuZYRKlogQSluYKvW1yJReamz1tEN8agSNq/w7xtqXMHSbK1DxxsDFNk6iJsVbbYYG9KDs1ehkgS7mDE4yFh3gqIglbspLfq8/dfz6EJcBuC5pssnVDyLIUfUbnQwwxcoNiPsGZZ3q7Nbg5heSO4m8ximKGsyA6bauez0YandbabrW+YslHbapXAcUE6NOIhD0SIZ1vyJCGvrMC0glMAzct0HsN/hUhLWNP0AkZW/OFOSm07GQATHT54dA53ATfU/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeXaFZOs9I6qDl+kdM5acR4tniocFIYEm+N6k4Ny1SA=;
 b=OZq79l7l4zH3ydGQC9KojZlHzFENmokzwNRen4Qcin7OdbFZImTD4PpfM5uf+GILkzz6dKZU822QYjTt+rOyJw2ccCY/nLEPY93JJA9WX/xfWUow9VgZ3MKXQubo4gEn0yaLSinPPuMxHUkDOadxP9Wy6ecBb+bmopPEgaUngUhdBjH78QKf8GWCwlgxRzJtqy5/IRm7uRs/4AR9Mu2LGWFj2QLGrFREc6V+D+s0epFSeHOtejaoRXvl9EyN7LpSDzlqB07dU1krv2HEm0j+9Yim4F/HX2qn3XUzcwiqtTtVpvm8SNmuI4yOgiRls5hjsO/D51HvaL4Ttoxx5/qokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeXaFZOs9I6qDl+kdM5acR4tniocFIYEm+N6k4Ny1SA=;
 b=Opl2s5BeXikW8i+vNBbIkNMFNhEGq1DKX/DJmT1aGPIUO5UuQImsZCL10JgdVETU7bSjWm2we0koy3RaCcPjhdHoLbRNXK2Ax2YWnSDDvZQk6346fDUM6a6NMpg6rxjQuAb7ISUrdkCN3atlgtrlS4xU9HfWEOVRnywX5Rd+3H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 12:20:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.021; Thu, 6 Aug 2026
 12:20:16 +0000
Message-ID: <315a518f-750b-4ed0-8c9f-c1af41f2090c@amd.com>
Date: Thu, 6 Aug 2026 14:20:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: validate GEM_CREATE domain combinations
To: Candice Li <candice.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260806100010.50587-1-candice.li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260806100010.50587-1-candice.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 3723a64f-9716-407f-4a4a-08def3b512f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ui5UjhsnWBez6siRYrNfWiASnzYNnOhhTwPUGbZOmM73BTXfvyIFmmc+w0XutJuxpqOTovXGW4972+yED2Hj9RhdFFepfA4954spciwaJ9joi8MHxzUmAGjCpfefC7XKZepdIxQL1NmiyCrNcMPUtCGRNkXU86DLG2+lS81zkcAqrPnJj8RwQDPao4UXNVE6U9zMXVmfh+G2R0uNlUYFVBCgwTevfuIvS3h784ykZJDiaWGSEnjc/s7nN6wgxuyydMd1NCkrz0+/OtrYARQb91O8BbmyrgU8vDNMbQQ28cO3wDt+12f1IQTHZGwgI/5aAmYd2RJFDhyT2qrAOfq7XweExxQIHk/L8n30G+AxDDMe6sOIUSSHSv/vP5+fRnfjzGRbaPu4cbA2EgS+arBYaQSwx3Kzkyn7FqeLbhi/BPRPPrwyb3lnrgSY2TwT/BWs/oa0TGISqbZu4hJsDYeGUvwQrnJmBhrwopl3mrqBw+C5+m4UWNof2mJ82hBc8jJYGvYr4fpvOvGT7eSxUlePvJnwTHXVdzI38Oa2M3+AnHpNQSR4uEdy6tP3Og934O459TSLbSaEKolPXgAnmg96jJuPwNgl/hjHeUsmMx4K8W1EVbPzBWnXe3QS/ILdEQXXD545w9b26sBmRSTTuDK1AUthwYP2noOMlyemVeR2TBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJneHZUMk1wNTE0NnZLYkhVaGtQRXNYbzl5ZVJXU1E3dHZCeHRUbml3Z05l?=
 =?utf-8?B?eGFYRDVEYlZud2dzVjNIR1o3Z2Ywcmk5WFhGTE51VHIwM0pMVCt2QmJmMGhk?=
 =?utf-8?B?L0g1dDFHa3IrVzM1bU8yVVhaZFlOY3ZTN2RxZ0N0SmV6MXdKSkFxYUl0aUhy?=
 =?utf-8?B?ZFg3VzNMTDVKQ1RyQ21jSGh0Y1VZNXVvYTFMcW9Xd2cyWmY4dnlaWjFZcUFy?=
 =?utf-8?B?VzUwaXZnY05DYmZCMkhuVXcxMDg1REFJNDRDQjZuSkIzcVVtakJMOTAxSldw?=
 =?utf-8?B?bEZ0NXdBK25LWWJTYzNTWlJzdlR1SkpWRnpUczZ5SHVIMGV2QUhJSE5xR05n?=
 =?utf-8?B?MDNtOXFvbFM2NW0wMWM1Ynp2V01RblQycUJpU1lOdUZEclJFU2NTNVRpcmFD?=
 =?utf-8?B?dVZkMEJiVDdJV3RoRTFtaElWbGJsWXNHbXNPQ3h3b0tVdG1ySVp3TWJoNnZF?=
 =?utf-8?B?MGJ2YWxkTDUrQzhNR1ljUlQ2a1pzalZ1Y0tDUTAzWFdaZ1A4YjArYzBqWnJu?=
 =?utf-8?B?MkZJaXYvWXk4MlFqVTdFbFFINVVaZ21sZlAyOVhhdUdpbFdCOThNbnhGeW5E?=
 =?utf-8?B?QzBLTm0vUVRLMVV1Vko4T1F0Y2daN0lDMTl2MDlyL0NPTTAyZFlRZzdDT2tm?=
 =?utf-8?B?SlFKMDNud2psQlIxelBYRW9IbnJJSTYrYnAwdFY2cis0eWkzVHMvWjRVNUZ3?=
 =?utf-8?B?KzMrMG1LOTBHVlR5TkVQYUZ5aU5JdytOUVBFM05FM3ZFMytNQXY5NW1KQVN5?=
 =?utf-8?B?NWdHY2piaUI3Ujh3TWxTdVkyYkZoWGRnVzNDbmZVNUpNZG1DM0IrdlEycmtL?=
 =?utf-8?B?ejZNYU5rOUdWZ3NwYk5WTHU1UFFvQkpNNWU0YWtYMmxWd09Deks3cCthbE1R?=
 =?utf-8?B?NXJSRjlmSllSMUlEWWtJbDYrU0tTemF0eXdFVU1JWW92dHdzRHAwTWg1TnRq?=
 =?utf-8?B?MHJuSU05K1ZYS3ZzcUlHc0FnTkZHTk8raC9jd285ZDVJV2hXTFZNQS80NFZ2?=
 =?utf-8?B?blZJYjFITFd4Sm4zOTRGVVZkMCtFTG1Beng1UnEzMmtXREUrZVRlZHJrTXVM?=
 =?utf-8?B?c2dOSzlTZnNNYVFFMzV2OENKTlAwYlQxS1hmdlRhdkFzR0tWd0ZaUWswSGhQ?=
 =?utf-8?B?QjN1OCtob1JYVldhb1NJTEdNbVJXbFdmWkJZd2NObUtBY1ZzMFFkckxJTGR1?=
 =?utf-8?B?MzAwcFlxUlNHa1dsNStPc0VuY0QyV3JQV1RTM3NEM0ZPK3VnT2Z6WndoVGpB?=
 =?utf-8?B?M0FVL3V0NGN3NGZUUjVKWWk3NFlSNTB3eWhBc2pEZklpa0JJN2NhcUZEc0Q0?=
 =?utf-8?B?akhGU25LNXhvbzFWWCtMWEtrYk5BbnZSbzE5bW54Y1plZTFabXh4MUNrN2Jv?=
 =?utf-8?B?UEtmR0wwMmJZa1YxdjZMYjJRN0tIdnl4dTMydldjbVVkUUluSGZxczVMcVZj?=
 =?utf-8?B?d1l5VkVLMUhSdnF2a0xVcDFsWXlQQnZ2M2JWbGRkUHZ3RFppVnJQUmNBYlk3?=
 =?utf-8?B?YlU3YjdFa2xUMlYxYitzN2FnRlpXaFdDS3llYWJneTJlMGM4bkVldmVJbDA5?=
 =?utf-8?B?ejhIQTJqS2RhTTJOd1hRd0k3NTh6VkZGNjMzdXh6MmFSM0V4UCtGUVRBQTFW?=
 =?utf-8?B?T1FLTjJoeDdQdG5zdXY3bS9FZGprRDJIRisvU3Q2K1pheXJvTTFRRFR6eVdH?=
 =?utf-8?B?VFlBb2lKUS94cnV0MmRyZFNtd1B2THBHNVpBRzRQd29zSnZyUTlpY3JXN1k0?=
 =?utf-8?B?N2dkZms0cU96Q21VSnBFeVdLQVlacHdSWFhZcXBIZmNtQ0pCdVpaRjR1azVF?=
 =?utf-8?B?anRzN3JVVXR6YUhDdmdyQ2FweWN6NDJEZGtxM3dRcnIrWEZQd2Q3UkY4SWls?=
 =?utf-8?B?dHVtdjdRR0NNWmgxQUNpbEsra2VOWkxWZWRmVXBQKzl0UXNzdG5WMEJ6a3cw?=
 =?utf-8?B?ZVF5OG5xOUVEb3hHeEJWbGxrRXhvb3pDNU9uVEtOMHRjVjF6ZGNHNktISWdo?=
 =?utf-8?B?SUtqQTF2OGIySjR3dUhtZkRIaW85RWdVNzVUWGF6c3RJVTI0Z0NrV1RlRVFi?=
 =?utf-8?B?dm5mcTE5QkNoSjEyTlhnYlNSQjUvUm0wWHc5M2VkQnlKWmdNQ2ZlMmJkUzRY?=
 =?utf-8?B?d2k3RkxseEZMUU0yMndJc1orRE1PNktRZHdKaWEwTWh4cGVRS1BUZXlsRXFv?=
 =?utf-8?B?OC82WFROTEVDbi8wUXJyVS9YS1cwWkxlMFIvcEVmNlNPMkVvcEZsODMycDVR?=
 =?utf-8?B?c24xWnJEV2M5NUljTjFHWWJJWmU2b1JDckF6ODlLS3AzUUZRSXZOdEtCcGNL?=
 =?utf-8?Q?NyuVFwmsnXQhb07lv6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3723a64f-9716-407f-4a4a-08def3b512f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:20:16.7952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N87xGu6nGnGKp8MD1DYDrDiSlQNlD84nFC/AeBGWHv4V0ZzbDcfYcCM84eCYKXqP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
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

On 8/6/26 12:00, Candice Li wrote:
> AMDGPU_GEM_CREATE checked domain bits against AMDGPU_GEM_DOMAIN_MASK,
> but did not validate domain combinations. Userspace could combine
> CPU|GTT|VRAM with DOORBELL, GDS, GWS, or OA, making
> amdgpu_bo_placement_from_domain() exceed AMDGPU_BO_MAX_PLACEMENTS and
> hit BUG_ON().
> 
> Allow combinations only within CPU/GTT/VRAM, and require non-CPU/GTT/
> VRAM domains to be specified one at a time. Return -EINVAL for invalid
> combinations in amdgpu_gem_create_ioctl().
> 
> v2: Rename helper from amdgpu_gem_domain_valid() to
>     amdgpu_gem_are_domains_valid() (Christian)
> 
> Signed-off-by: Candice Li <candice.li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6a0699746fbcd6..f754a4a3a1c22d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -397,6 +397,25 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.vm_ops = &amdgpu_gem_vm_ops,
>  };
>  
> +static bool amdgpu_gem_are_domains_valid(u32 domains)
> +{
> +	u32 normal = AMDGPU_GEM_DOMAIN_CPU |
> +		     AMDGPU_GEM_DOMAIN_GTT |
> +		     AMDGPU_GEM_DOMAIN_VRAM;
> +	/* Treat all non CPU/GTT/VRAM domains as special domains. */
> +	u32 special = AMDGPU_GEM_DOMAIN_MASK & ~normal;
> +	u32 normal_mask = domains & normal;
> +	u32 special_mask = domains & special;
> +
> +	if (!special_mask)
> +		return true;
> +
> +	if (normal_mask)
> +		return false;
> +
> +	return !(special_mask & (special_mask - 1));
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -421,6 +440,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	/* reject invalid gem domains */
>  	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>  		return -EINVAL;
> +	if (!amdgpu_gem_are_domains_valid(args->in.domains))
> +		return -EINVAL;
>  
>  	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
>  		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");

