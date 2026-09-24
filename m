Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8FCC98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 16:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310A110F69A;
	Thu, 24 Sep 2026 16:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kuj29RLF";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0589110F69A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 16:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3kbyG1or7J/Y4uiyEZdPSMuzIcp9I7z77KbbJUg1/LAjCyoSHXH2VdwwwhWzLsOo4Oq9VQ4kS6HXTRmUJ04NsBrfjJ9CPGBS8EAu0BtEE34Fu0HiACfEYZoIlYqqcWzNlehM6K2eBPRE2lhwZ88VYVUigwxZ5FVMzjIq7B9zyFLTB7+6Y4iVl9191N9EZ4WBu7+e6numI4ngupsahk4HW+U44lLkUGDUWIGeuQypqw+Fk6ZiKSJufyNvM8ithGlvk5KDBwtCECuCAWk9NGUfF9xiI/8FwI95/VTtsngHbvlXVeqxqy7VgVhaEnJNVyIZgyvXaBArcHdSLERgfk9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JJhLPoEv+YlEJdpcpH3CJXf6/xEHZMBV/7XpJ1bB3U=;
 b=murtcv0LDycPWfRV7DMlazu3XpQTA3YOMAV8SHyILWd/MuFHO5lru9mO7m4xizYH/kawzyEbEzoaPq1S42KdfSckeCNN2gR3+SB5BKq3c0Q4ikiy3hdyWSr2Qpjz/64Qt8EfpGTHYVEuS/4NlGVI3GCDbhDjuSQePbyiQCrDvqrGJKxPtFsIvmo+KYkL5iB7HDJJo49gauhqtj632MndDFoynLMqbCBF4A44zOzCz3wiFC+fnHJZQdVz3b5AD/69JKIXuMgjJzomlYwsNBf61DGaepz4OEP8uAHV1HCao9X7qICz7VBvTsoqkzqBwRXUC0IARCXHg6tVU0PHGynwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JJhLPoEv+YlEJdpcpH3CJXf6/xEHZMBV/7XpJ1bB3U=;
 b=kuj29RLFcMMVuk6jMZZiv5oQT7vcde6aAB4lnhfCuQPlRpHgP9AzoFDdNyYXe8r75zQj8ELoVgdHR0QJH5/N/8kxUDvgm2eVcaQ3V0TBGY23JUZktDMGNssAq721jXqtPr3jA4Dp4Vc4wzti2oQqRXbjz0LkDQ3BbIpZbtzRwxE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM4PR12MB5842.namprd12.prod.outlook.com
 (2603:10b6:8:65::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 16:26:38 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 16:26:37 +0000
Message-ID: <55bc6e69-4863-4125-b02e-fff7d0b8f907@amd.com>
Date: Thu, 24 Sep 2026 12:26:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com,
 Christian.Koenig@amd.com
References: <20260924133644.1541887-1-mukul.joshi@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260924133644.1541887-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::11) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5746c9-d174-4ecf-4760-08df1a589af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|10067099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: LMXCU1Fej0igfRGlr4KKZ9LNQd1GgIhNGxt18JC8ZeE34nIoaZTJtZAh9VCA5j+vn0R6EtKLIsx/IjtTK+DeEddDy9tGai4FtZs7X+vWY9bAOxpZAKlZIFDSTcSs1kgJD8x0p9R5h2GLmaALzFoUNPuHqToiimnW2CwrWoEJkVK7JEstOdkjnYLV8HR1M9A+DUZWuTJ8GKur1BDXQzmvigOzbP77G7fXocu8AtvTmEsWPpYsomw1IdhFuyawio+EJD9/8zY15kGMyUqDCquA+tiIlMNZDXPXZs3FXqJJox7uWp2jZCIVwpJfrReOk2Ux9L8GpBiWe1pwFSKgz+dxXBf3/EhphniMSVjMku5SU5UHX4w+J4yfxS7OQwHpUu8XaJq5BcxhzNmP7Nb+JtHarL+yjpGFv0Ie87Latts9KFnlA/nCtsXjgFz/qXH2EqGmfw34GTjhqYHa/kkOsV9Fs1v4X4DV5NNdCqeSblesLBi/IHjJmaRr347kTqDSFq47hz2sdeHpcUpYM2fu38TwIWFFySjepkTXDmBbUsymAl2HxAmAsE5YE3kK0F4kqAcf6dIVsHy48OaYA5ipJN7lXKSOKaqbDEEPnUB8G4vrLAvOyRmj0PyEInHrczsyDTZtX701L72n7obx8Og+QqnGeOp0h65YsCA1Y6q8rOfPI6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djcvWDNqL1plTUdzVXVzai9FeGJ2bVJFNldUQzV4VDA0emhobXZnK1ErMU9Z?=
 =?utf-8?B?eHRrMy9DOVJaaGtFWjlhSmZ5ZzZZMTNSN3h4M1ZRdXhwcmxPMjArempHS25k?=
 =?utf-8?B?aVVMV2pxZVRFc3F3cjYyTUViMUQ2MEw1dWlwOGlNWGtrV1VsNnkyVTdZMmdN?=
 =?utf-8?B?dGVxNHJXZ0MzeUZNc2M1Z1pwWnd2NEZjTm5DNlpaZE11bitEWWVXbW9UR3B2?=
 =?utf-8?B?MlZrb2JkZlBVZm16WlBEdWd6di8rTFA0TDExLysyTmNHcWorSlNLQkx2YzVT?=
 =?utf-8?B?ZnJNcjBubi9uaytQVFc5RUZKaWpQR1NQK3c0Sm5ISUZlSGVlRmdDM0hpU08v?=
 =?utf-8?B?d2xHM003TlhhYXZiZjliSzdZLzdmNTFyNDJ5a01qcE9hRzhBUm9LcTh3Vmt0?=
 =?utf-8?B?a2hYL1RMV1BWdWFQUUlRYXRub0FUZTNTTDAzTHJBNXc2MDNMRFdrSFh4Vm51?=
 =?utf-8?B?ajZib3ZkZjdtTFk2VVlHbEhqRGNkYTNmM1JBT2Q4eFplS2NMaFlrSjY5aTBV?=
 =?utf-8?B?QmlZSGNnMlVlUkxsd0p3eGFuK0dvNlVjWUUxVUhJcmU5bHZMUVZISWN4ejNh?=
 =?utf-8?B?cnZtK0Z6Rng4Sm9jME5IZC9VQmI4VjlrMUtzVFdlTEdkUGNOQlM2QUxHU1I0?=
 =?utf-8?B?Z2trOGRrMFd1dDZoWVNCbkhpUzBvVmk2em5seEQ3akRjQzhoZTJoYk9iRlR4?=
 =?utf-8?B?YSsxUFVtVThNQm12WUFIYXhlMXl2Nnh6NzZnRVV6NEp4c1B3aVUxczJLNFNJ?=
 =?utf-8?B?MDFPL0N0N0dJeUZDYkpOcGtIL1JUclViQW1IcG9nZVNQU2lXZUNac0VsVzQz?=
 =?utf-8?B?N3RUOTF5ajJxS29qN3lEb3hGMms2LzZuMEFWOFdjS1NUNEJacWtvYll3Q2dk?=
 =?utf-8?B?TVFIa3YxZjNjVWpFcUpKZlN6MDZtWGJwZFlYdGFPZlVvSTROQmtMZjR1dlVr?=
 =?utf-8?B?d2ozSjIrNTZad2RGbjNueTl3ZDJRenBEaVJRY0dsU3VOYWdIbWhBVzI3N3lU?=
 =?utf-8?B?cEhlTFA5M0IvL1BWa2ZDNEQ3U0t5NlFkelRicEFUMndDd290T2lwbFliREJo?=
 =?utf-8?B?cGd5b08zT2Rlb2l5Qld3SEZlMk5INUpOTkgwa05LZmlUM094TmRtbzlkNkdp?=
 =?utf-8?B?UFRVOUs2MkducVYwc3VMeXBWcDhzMWpPSlFuZ0RDeldERmdGa2s5L3hpS043?=
 =?utf-8?B?R1g4M0JRUHI0dTc5dWtLckpBOUNQejFtUWZwUFdoUTVVOTF6cFJPZXhEcWRq?=
 =?utf-8?B?ajVSalRjc2VGWjBhUm1NTWdkS3R6czBUWUY2V2tERzljK09mRHlnQ0RUOVdO?=
 =?utf-8?B?NzVxZmtBenRSYjV1aENPeEhuYndiMnJJZEVZNGFPSTNYRm15RE1iNGpDQ0Y1?=
 =?utf-8?B?YVg5TEdMMG9DU21FbWtZQnAwQUl4eFNzUFZqSkNRVHBYY3hkcHE0NkhkNWts?=
 =?utf-8?B?L05paTdSTEoyTG5janBWck41Uzc5RWNxWS9QejQ4cnFyVUhRM2FhQ09HNDVC?=
 =?utf-8?B?RlRHekdFNXhQc3NOQnA1bFZGY0VxdldpU1B3SjExakV0SnZPNTZmQ05ENHE2?=
 =?utf-8?B?dGNHUFBKQjJMU0JKV2NORXdpbDRVRDBmQys2YVU0a1BDS0JVcHUvVmEyVnp5?=
 =?utf-8?B?b2gvRTdNY2tnenh2RWZudXRXNm1CV3YwVmpYdjlhelgrMHBvbDlmZStacFdV?=
 =?utf-8?B?Q29ramp5WWs4OE5RajBLNWFWRzR1QnRaajdMVk5jRkNRcUJ2KzZMTXh3KzEz?=
 =?utf-8?B?UG16NzIvZUFrTnJKUWgrQWQ3cy9taVcwOU9wUk5STWljMWhsTmxrcmFSeCs5?=
 =?utf-8?B?TUhHS3Q4UFJVRDFZODRPd0VyUTZYMy90YkVyejU5UUEwdXJ4V3JsQXJVQ00w?=
 =?utf-8?B?c3BOUlZXQjJYTFg2MXVJdVBEeERHaGFFZHhTcWtPTnZOMmN5SHhkNU9vRkFE?=
 =?utf-8?B?MDM0bGtyMzB2SzllTWJSTnBpMEgvbmhZS3dBeEoyTHpyaXU3aEczNWJ0NGJ3?=
 =?utf-8?B?Y2tsNzF2YmFUSUprV1ExaXorKzQyR3pFRkNUQVhCMFVVcTUyMHJuSEZXVGVH?=
 =?utf-8?B?ZjFCYlA2aGg4SHVjR3NOOC9FMjRjaXJPTHI5VlBwdmtudzExTDNteTVwNjNq?=
 =?utf-8?B?cE4xa1h6RGV1L2NsZk94Y0pRVzdyd1dodGZKWHcvNUcreVBiTzlKemRubktv?=
 =?utf-8?B?VTliWHk0TDJSNmdUcStJeFI2Qm9Fc0hQYkQ5Vyt1SGg5eE5CT3pKMFNnRkVn?=
 =?utf-8?B?Q2VrbzJQRUl0T0RkbE1rNzZSeFZsWTBrR3pNM3IwZlZqaDQ4dHMrVERuZkNz?=
 =?utf-8?Q?kXpAoV9NarEMLp4Mj9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5746c9-d174-4ecf-4760-08df1a589af3
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:26:37.0143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBt8Os57tGzDGurzg2114ikRdqfgf6rDLlnimIyi8HxR/QY4/jeBsX91TyOCxopwI8msjghrOBvNjiFD0emjbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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


On 2026-09-24 09:34, Mukul Joshi wrote:
> An imported dma-buf BO backed by a VRAM-capable exporter holds no host
> pages of its own, yet when validated into TTM_PL_TT it is charged against
> the GTT page budget; importing many such buffers can exhaust that budget
> and fail with -ENOMEM even though no host memory is used. Set
> AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
> domain instead, which is GTT-like and still bound (keeping the exporter
> resident) but carries no host-page limit.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v1->v2:
> - Check if p2p access is allowed. If not, clear the PREEMPT flag since
>    the BO will be put in GTT domain.
> - v1 reviewed by Felix.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 4031ebe075d8..bbe518757907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>   					 AMDGPU_GEM_CREATE_COHERENT |
>   					 AMDGPU_GEM_CREATE_EXT_COHERENT |
>   					 AMDGPU_GEM_CREATE_UNCACHED);
> +
> +		/*
> +		 * A VRAM-capable import is backed by the exporter's device
> +		 * memory, not host pages of its own. Place it in the PREEMPT
> +		 * domain (GTT-like, but with no host-page budget) so many such
> +		 * imports cannot exhaust the GTT limit.
> +		 */
> +		if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
> +			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>   	}
>   
>   	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
> @@ -618,6 +627,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
>   		return ERR_CAST(attach);
>   	}
>   
> +	/*
> +	 * The PREEMPT domain is only correct when the attachment actually
> +	 * resolves to P2P access, in which case the import lives in the
> +	 * exporter's VRAM and consumes no host GTT pages.  Without P2P the
> +	 * import is staged in system memory and must count against the GTT
> +	 * budget normally, so drop AMDGPU_GEM_CREATE_PREEMPTIBLE again.  The
> +	 * BO is not published yet, so clearing the flag here is race-free.
> +	 */
> +	if (!attach->peer2peer)
> +		gem_to_amdgpu_bo(obj)->flags &= ~AMDGPU_GEM_CREATE_PREEMPTIBLE;
> +
>   	get_dma_buf(dma_buf);
>   	obj->import_attach = attach;
>   	return obj;
