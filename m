Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831A8CD98D4
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 08:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F8610E72F;
	Thu, 11 Jun 2026 08:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nK0TU/yD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF8710E72F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 08:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wF3wIe7/fHS5+sNJXHFQJRHQjUP/pA2wZ1fCEuKO22M5KmHHfBd8KjYczihdcFsoX2q1hfYpuEz/LoFzqLAYnuKboiZ0MdL/Mtera5vi4v2lwwrDRJAgEB1O/bFNlsat8KgUQF/xHnveNcOhEnGma62/ThQzqhJ9GupVX0yQ7K+sdL//bh6ZVCXcfCtWPdEU5Iviij7oAyZ79YDLng8pHRyg5N14ncGerpspncN1Ort7VMQ+I1YQM/WGhxgrMWPLP/19kgl0UItz9Weld1Knaa9ROmJAVNI7ZT0NnQwKtc8Yp37CZB5FzcMqXa9v/lwKze2+O0+bELOfKKWVg12qAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNEHZgPJjTAj0lJJd4abCZL8d7n4bnbrGB6zugjllg0=;
 b=KAyybuyvjfIDOd0gV45SzZhih9pQt/YorLfrUacrcVILSeuJy/K9wLcBgfurs6c+ddkboZuPC3DoLQnslonVqjvx9zeJg/H8pkYE/gMbZep9RU4OXzDQ92t3XoWj8er1xH4JCEXu1Th/dhJnO8s1eadK1Z7292o1auoAzziWaLYyeUn5v06BCaRBJLUS2cHTgp6CctjjnF2XDL3rQpNGPcNRVX4iIFra+j3kPRJD4gupP0FLiB08FTNnCq+7xhd04DBtsazK+YgLw496E3XFo28cfhrn8roKsqAhgD+NekFUdd0XnmySp71XsoJoKcw28uScjgAwYSkunOxWAu6u8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNEHZgPJjTAj0lJJd4abCZL8d7n4bnbrGB6zugjllg0=;
 b=nK0TU/yDHpPyN/sNwN+SNxkW5DQ3aBe0jBQvpdSFCytwazLXGJFhwVKaPARedaG1VQprxJQfnC7XS1YfJcCASDcYo0NJHlGC2mvzQUxio5uRc1YW2JZdTTYcU5/+8Do0LjoQ4sJmjBixRyzwOC3ZP3lLyMIMPCfvCfgISZ5cb14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 08:10:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 08:10:27 +0000
Message-ID: <547f42cd-d402-4fc4-9b43-c59846b4baef@amd.com>
Date: Thu, 11 Jun 2026 10:10:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: report GUILTY/INNOCENT reset from
 amdgpu_ctx_query()
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260611073344.927931-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611073344.927931-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0041.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: a41abcc4-6548-434d-d377-08dec790e54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ua3bwACJmysnLFxiGpugcymS3UumkBkyPbiOvJ1dIISoNKktqtb/i/QOnwccyfdFw3L93QkC2gMZo1K7ccTM5fjVBVHa+YGV7uzk1oX/kKucu2lZV1My4a73951JLwUHtyu33nru1NlbJmoAX1BQ1+KHwMkotuHft6IydfYFlRtXlMrLckr5sY8EqkhDZL250jwcgHwicN7Bt1LnEsaTXSERmj/1zl4bWem81Rooxp4kVHhPmALSVZaO/BPtOVchSPdWzgLa3i4Rjn9cequt8F2TpRaFkFMwbaculE5j7Bx+wlNZ24WFkel5I+hx1yk1fwV5PPs2Gf8KvT+kjKA456GZNfKjDnat769BZZVBBvsX4aJOdPqsg0JYubWj7KYA2Ca4EFGU5k8BUNwQyWskqQCc0XOzbMqzlz1YlIpBKZAro98DxxhW35UFk9INFuFTZaIqF1vg35Vro+pgaIHTwxU6imWfORxocEOswgkaSCI+yPJk1AcPmp3iGf7n/MtqlQecq4F7JX05Bx1/NvEqz2E9z4Z9kMsEXPvAM4Cwy/iP0+Tt1Xvi7NEyqD5YBX61HvS4cw0sRTwOpcFul8tc4TVG+tNmeA8ax5G7bqXEWJzSMyzrOCftGXrO9bmaPeuxTRg1Mlk+hr99eV9PQdq5EgnqN3LZBJdnsttOdMhbLguAEnwNHr1/oEeL2SBZpTV/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWcvSVplYjI3Y2pmQ09BZ1NSbGxZR055MVlST0FkdDBsWmlRd1FHL1puT3E3?=
 =?utf-8?B?ZTJTOGh6Y2h6STFxay9EcFlnU2ErV29pUG5GVVk5bm95Q242SW9NTXZVR043?=
 =?utf-8?B?QmhzbzRrRnVxdkdGSXNKR2JtaGtTSlQ5ZHlMRWZNRC9vb3dxYXFnd296dVMy?=
 =?utf-8?B?UEFlZ0h6elFsQnF1WW1KR3dpZlE0V2xveGwvMzRNNk5LaUhiZXFDOVNxaGhV?=
 =?utf-8?B?ZGdiWTBYYWFzK2Q2aHdackEvVW94WUprYnV6Y2NzWEIybDMzOHlmRXZuT3JZ?=
 =?utf-8?B?YWxvT05zdjRJUzFPcjc5M1dvYm5sS1hBTjh2S3FQVmg5U3BkZU9TOW5JeVM2?=
 =?utf-8?B?WUpkMmlLWngrTFZENGYzRUQzNFhxUzdON2dQM3F2TS9KRmhNY0UzZ2FKMzVE?=
 =?utf-8?B?TktkUUxZQXNrNWQxV1hVVktVNVlESGVOcytHYzMyK1lrWUZNTGh2eGZRTlBa?=
 =?utf-8?B?dHZHT1B2V1kwVXVCekpSanBaL0tNVVBxL2dTckhzOTBYaDZaaG9NZjE1aWNL?=
 =?utf-8?B?Qmd0VzFUcEpWNFFDVExJODFqNjcxV2hnakVLdGZ0MjhSKzRkSFVNUVQ5clh2?=
 =?utf-8?B?cG5PK1oyYWVnUzgvSy83VzA3aHRqTEdzQ2I3aWs5TXBvVHo0d3ZiczlNMDBo?=
 =?utf-8?B?b1htblppTTUvcjdNS0FBaGFXNXlNbGU3R1FZc1hCanYreDV3dndqSmp2Nk9B?=
 =?utf-8?B?N3pwbktEWmJVdG1idUlZRmRKL2hQUzlmSzBVZlM2TG1HaGhlSituL1Q3TXI0?=
 =?utf-8?B?OWZSSW4yOGN3U2l0Y2JYY2FWMEVDMytnK2pTek1jUVhOLzNLa3FGWjhXanpB?=
 =?utf-8?B?OEFNczlncDgzNU1zUVQ4bG8zb0k5Y1Z6YlZvM2x3K3ZtdVE1TTM5TjFkbHJp?=
 =?utf-8?B?Z2taV1lwVjdTK0NObEdZMEdqOTFqRXA3ZjFiVmdKZklkOEZocW1JQWlzWjFR?=
 =?utf-8?B?NEtBYlZwb0tiUlUzYTM4TXNaNHd5TzBhV0tya0ljVXd1RFVwMGZNaTZCSnNV?=
 =?utf-8?B?Qlh4L3pEZUV3UlFDVEVpS2NTS0o2NTdhVG10dHVSZmM2SGo1YVczYVU0MXJK?=
 =?utf-8?B?RmZvaHR5TVJkZC9jckozNjBwU25aTUcvSlZrcUJVWjh5SDhnS29qT0Y1ZUFO?=
 =?utf-8?B?Q212OERrNHo0VFZNTTZRcWYzbVBzRmQyTkNCMWIzM0xvRG44Z0xkKy9XT0tZ?=
 =?utf-8?B?SVZOb3phTVV1NVc5MzVwM3hSbXRHUVZ3NVJnck1Fdjg1UXhsMEJmZkJOVWVy?=
 =?utf-8?B?dXlWWDJ0NDZ6dWx0SWxsa1VVK3RidUhwN010WHpNNlA4dzI3UkVLd0p5N1I2?=
 =?utf-8?B?ZWs3YkJOOEFrWExQRlVDYXR2TmJTWkl3Ky9ROUtEVDVzT2hIaDFBQUpqc3Uz?=
 =?utf-8?B?UktMU1JGb0dMSitlQlo0MVF0VnhUUnBwTnBVRFNNL2xLMVVkZmFmd29MRjZq?=
 =?utf-8?B?T0hNODkwYzJpZDBhbTZxcmtsL1FNbUtnMEVFMzVUUVUwQXMwaTNONGZqYlRG?=
 =?utf-8?B?QlA1cGV2T3RzZlNCaFlQM1pLQXFabGlPTmFlaWZtbmIxbmgyNklER2d6Y3Bw?=
 =?utf-8?B?YURvT0tzbjBDTWRON2hLOXhTTkJqWHp6M09FbmFVdmRzZjdJd3NVc1FPTzE3?=
 =?utf-8?B?K1RmMEtNUjBaNjY1WHprVm9GREp6b09wRmdjQXM0cGdPQXFwcjB1VXp6R1Ni?=
 =?utf-8?B?aDlyUjRNYStRZjVZVTZLTFh0UXl5OW9KNThGVWFTYUdGbDJBUWVOV2d6M2la?=
 =?utf-8?B?WklGeDloL2M1SXNsYkJqWlowTzRPQ3NjaDczVXdNaTdXZytBMS9IWWt6S04y?=
 =?utf-8?B?SnBJOVYzM1VoN2lXdXRrMDhKN2t5dmNLWnkySWFabFVFOVlrcWRXL3NWdUQ1?=
 =?utf-8?B?Vk1lMWFQYlpjMTArQ3JXMnJQVTNvVjB1ZjZ0VTZ6ZjdrVEhtNVFHeU1md0pu?=
 =?utf-8?B?NHdPMmtOSWhVdnFFd2N6aG5weDJaS3NnajBneU5EaE5mMndCQUtwUmFYUnZo?=
 =?utf-8?B?cWJXM3dnUGoraklJV1ZFdFFXZzh5dTdKdXg2NlNveXZWbjhnK3ZiSnNWYUhS?=
 =?utf-8?B?ay9ZekNmSFNBdkZzMC9Zbml3WmJmTkd6UnQ1elkreEtwNS9MazRWZUdlRTZv?=
 =?utf-8?B?SGVtMVdYb3VwdWF1QUVOZ2RQUmVWQmVkYlpKSW1vOUxtUmtwcmx1bVZaem5U?=
 =?utf-8?B?VWdlZTNDNmlTWWRxWHdydVJoK0tGMDMxaEJkT2hRWGZvbGVQbmNwUldaVTdM?=
 =?utf-8?B?cXIvUkk0YWVaUGVlVjRFVE1RdEVzZ2d3UG5pMkpPZXQ5cXJ3OUl3QnBPL2hs?=
 =?utf-8?Q?OphABt8VdZivKNFUEu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41abcc4-6548-434d-d377-08dec790e54c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:10:27.0491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 579eyiuqp5j86KX5iGdh6Uv1k2vm99OuZN1Twojgjp0VpMyU2ICwWyWONqXqHiEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

On 6/11/26 09:33, Jesse Zhang wrote:
> drm/amdgpu: report guilty/innocent context reset status in ctx query
> 
> amdgpu_ctx_query() currently reports AMDGPU_CTX_UNKNOWN_RESET whenever
> the device reset counter changes, even if the context can be identified
> as guilty or unaffected.
> 
> Use amdgpu_ctx_guilty() in the ctx query path and return:
> - AMDGPU_CTX_GUILTY_RESET for guilty contexts,
> - AMDGPU_CTX_INNOCENT_RESET for non-guilty contexts after a reset,
> - AMDGPU_CTX_NO_RESET only when no reset occurred and context is not guilty.
> 
> This provides accurate per-context reset attribution to userspace instead
> of collapsing all reset cases into UNKNOWN.

I think I have to reject that.

The amdgpu_ctx_query() function is deprecated and replaced by the amdgpu_ctx_query2() function exactly because we couldn't extend the interface with such information.

IIRC the last time we tried to change it something broke in userspace and we had to revert that.

Just using the amdgpu_ctx_query2() should work as well.

Regards,
Christian.

> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index d54cec3e4a53..a88443e0254c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -542,6 +542,8 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  	return ctx ? 0 : -EINVAL;
>  }
>  
> +static bool amdgpu_ctx_guilty(struct amdgpu_ctx *ctx);
> +
>  static int amdgpu_ctx_query(struct amdgpu_device *adev,
>  			    struct amdgpu_fpriv *fpriv, uint32_t id,
>  			    union drm_amdgpu_ctx_out *out)
> @@ -549,6 +551,7 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>  	struct amdgpu_ctx *ctx;
>  	struct amdgpu_ctx_mgr *mgr;
>  	unsigned reset_counter;
> +	bool guilty;
>  
>  	if (!fpriv)
>  		return -EINVAL;
> @@ -567,11 +570,13 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>  
>  	/* determine if a GPU reset has occured since the last call */
>  	reset_counter = atomic_read(&adev->gpu_reset_counter);
> -	/* TODO: this should ideally return NO, GUILTY, or INNOCENT. */
> -	if (ctx->reset_counter_query == reset_counter)
> +	guilty = amdgpu_ctx_guilty(ctx);
> +	if (ctx->reset_counter_query == reset_counter && !guilty)
>  		out->state.reset_status = AMDGPU_CTX_NO_RESET;
> +	else if (guilty)
> +		out->state.reset_status = AMDGPU_CTX_GUILTY_RESET;
>  	else
> -		out->state.reset_status = AMDGPU_CTX_UNKNOWN_RESET;
> +		out->state.reset_status = AMDGPU_CTX_INNOCENT_RESET;
>  	ctx->reset_counter_query = reset_counter;
>  
>  	mutex_unlock(&mgr->lock);

