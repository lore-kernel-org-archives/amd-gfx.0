Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E986C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 16:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1051F10ED3C;
	Wed, 23 Sep 2026 16:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l9lNOnLb";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D2F10ED3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 16:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kad4LRvSM/z6sZ3PFSfCyiaX9l+dWsdaRNBkhC+WbIr687Vwx/qAZCAkpRA05qUBOLGgcmF/507IEjFV/sORDIuqf+DrWgR0i3xGJUbrq7P9XIcJGnI7Nx3wp8fy/rNRBwKbm25Pg6f+oVOLfsciISTJgxHHoc5/CQdUI+fH2HIwFR5A5ZZWafIf+WfP002YNJzzUW+Dk/+yxAAGjsfrUF1cMtJRAH17FLHU/765YXO4Q+wfn7lqtQQenBjdAoZNwL39Y6dfVaNHrqJZghOyuW3I4uWIZwsb3qMZjA+casOSySFPK2AYidoa3aNSPup8jYyZaoYyy2KbLNSWvCHLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xSEeF8xcAeTSc5hJy/QnPtvjq88yDOcq2p1WjeJVB4=;
 b=bc5OAvH4gsxDDGzYRhnoAYpFC4og51bc19RvuangV/3QKFc+GyvOx93VayIMMkPayNR/RHLL/Wms0R0/05k07gHAXuykcsvXouqHM1gACkdTOEwPVtTglFW9N7WVz+quOGDtSv+9oXTyk9vjNOmSLwAO2zCBrhcM7b8pVQaNHMyOPQp70aMFM9pWF7c8w/P5Rb2qp58q7WwW9gkNwyi1dVIdjBfQ4uhVdpu86B8f1Fgl6lfoeQwEXNW4bD+/2Oy13c6nhP6pVaLEX0YSJijaJOP6B1SxzL9htejDZZVIeLjS3tbg3eiysiaBmg59cNIxUrZ+q39ut3G6EBncVTmBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xSEeF8xcAeTSc5hJy/QnPtvjq88yDOcq2p1WjeJVB4=;
 b=l9lNOnLbTsX1i8GAZxhPnWRyhRJcffhEPiIjZl0neNJdXpqPPjL68Fr9rv5jPJWAucBKvGZCtyt1jDwoc0lt3TAKMh/RV1O66S8wp7pC/CcCCLoMat7By8q02XpMRhY9mIbDQS2N9OKAR7kd5qLtx3Z+kkW/B1SIHsAH6SpKUHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:02:27 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:02:26 +0000
Content-Type: multipart/alternative;
 boundary="------------Ai0ahwQh77BKmP8adzAbRLci"
Message-ID: <9b3636a8-3748-4000-a18a-9609115e65a0@amd.com>
Date: Wed, 23 Sep 2026 12:02:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix race on ualink_handle_lo in UALink
 handle export
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 philip.yang@amd.com, Sashiko-bot <sashiko-bot@kernel.org>
References: <20260922145653.1207241-1-mukul.joshi@amd.com>
 <20260922145653.1207241-3-mukul.joshi@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260922145653.1207241-3-mukul.joshi@amd.com>
X-ClientProxiedBy: YT4PR01CA0187.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::27) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ef3ce5-43b9-488a-9b18-08df198c0f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|5023799004|11063799006|4143699003|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QaQyWUBhj7OEkiaoR5EU1K83x7kcCFuN5hGnLj3dXx6r3YLuAs4+p/CGD40W0C+X+Z8WuomHl+yVERUJhJ1m3Qu8Y44l14ms0XEX8YdqwO9XP5lV5HLrdYDfHwdPiYyLJt8hboQ19p9Lcr5cz0Vu0Y42QU0aMkl0B+uTEkjcQd1MuLsQZj85SEtFFgP+MbhdRB4Y1bkUm65QmmGlMZEeVi2ksuvoG8q5YgDpkmjgeZIvMaec4lHUynq/8OO7QkkldwgBfr4geRl5rv16iuHwRdwrjHjRqlkvTjPMVghu7fYzOH9+/Dg7xUAZBA4bcbvLBNY7JQgfSjfZBhwgjvJgdwtuR8fzaA+InfBnQRVSNU3uHibhiBVVBBUzpc5XVeIebmJ0fQt00a4WZ+im5zpwEpwhmJjlssBLn8z5j3rtUeub6QksD10vvrMzZ8yolw8XScqmzYbwdUFs4NJ0rktLnOutlshFR00+cWa+fCjUU6W8edz1yh1DMo/wPdpgiSMjawpn4yoCQkWucQGXkbvE5ZtybWY7B6F+7B8jNa9Zj/a6TUE5qGzOfz48AP2m9wHvyrzqahdlveXetRGTo/c1leRmjYuys6oK9ui2tUy4ydFl6o1FySz2ZIF6yP44WUftxfc6nbfMbMc/LEDy7CJBQvqn1FBH4qStN6tDGsN4/Bs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBRVjhkS2hCdHNmSGZTekoxRWZrVGJlb0VJS0NKYTBYYyt2SDNNUDQ0aStO?=
 =?utf-8?B?YlMwTDNqMGYyK3FmVndjWDMwQkJTRnlnTnNLZFRXOHlEU1oxUjl0MTlOZkFi?=
 =?utf-8?B?c3RLd1VDNlRqZHJ5OUdsT3ZETUg3ZmJJMmh1aER3VEl0VUQybFUrZ0t5dDVZ?=
 =?utf-8?B?cGpYS3R6ZHllZytnN1VYWmhCUFVMaHJWWkZ1MGQ1RC9ZVVVWOW1iVURWM25l?=
 =?utf-8?B?VUNGTUxrZnNPVnVqbm5yVlVKMjdmUU9BaFdoZjRIeG54RUtMeUlNU0RVMjNi?=
 =?utf-8?B?M2dmZFpMM3ZlczRiZU51b3BvdlFWNVRwSDh0dGpmMGpaelhpR1orM3czTWpT?=
 =?utf-8?B?UFhZN0V6eTJrblhzQ0IrQWRyUWxOZEh0TjN3cXpOY3U2WGpuOG1qdTNYQVVv?=
 =?utf-8?B?eTFnZlVlS0Z3WEhGNjE0ai9WaHRYR0tXNkxReVBzUXd4NnpCR0ZNNGZwUDhJ?=
 =?utf-8?B?UjhHSEZCTTlEYW1uQjFBQm42SWRqTzA4L0dKYUcyLzNJVDFMeWZGTURtQlY2?=
 =?utf-8?B?dEl3YmdpUDZCOE5PSk00dzhPSlVjcm1zZEtTWDRNUWFqNDZyNUc3YlptdUJv?=
 =?utf-8?B?QnJvU3ZHYVlvdlE4MkFjdHowcUZKMk01MlI5T1g5QmF6b3ptcUs1SXljZ2tF?=
 =?utf-8?B?MjE2UUxlajBReU9nUU5BSWxWS3QrWmMyUWJIa1dSbnFFSnB1alNqSEhLRFBP?=
 =?utf-8?B?R21Yb3d2c08rK1hyckNSdjU4YUxwVVVDYkR1b0RIWmU1VktieWpyQjFBV1RG?=
 =?utf-8?B?UWVWaThKdTBod1hKZFlJbE1SRmdqODNpRGxMMVZBVFN4NEM5WUw1Wkt1Vm5N?=
 =?utf-8?B?Z0RPNXFVVkhlVlVOcHRqbUUzYXV2Y2doTE1xQzZac3BNY2NDd2dqVkVGN21O?=
 =?utf-8?B?em5DWXk5eHlXVXNDbDJDOENqRXgzRVdSb2hDSEhQS0l0WC9OeGZCRWxFdFVC?=
 =?utf-8?B?Mjgrb1VHdG5Majl2ckRMTm82OXJxSUNWK0hWOVhkbk4xZFkxcjhmbVcyUWx0?=
 =?utf-8?B?MExlU0xpa09FYWZUWkNOR3ZDT3dPVktlcDcxUEZuUjBWSTduOVJQSmFJRDFq?=
 =?utf-8?B?YlFNblRvaEYwbzdLTDRNUXE3WlBZN2tRalozM2x4VTMwUlpwOGxVRkY5eHlP?=
 =?utf-8?B?cmpJWFdhSFBOVndhL25mWmkrVFUwWmhFUXpRS3puLzU5NGlhR25Nb2hUUjE2?=
 =?utf-8?B?WDJIc1ZFZEVGV1B1djdMUGluZGJuZVVJQmZkV0VFY0dDZjhWQTVsVFUxVHZs?=
 =?utf-8?B?UjNSRFNESmdjTW5yTGdoZTdhUVJSU1lGaXVxSERnSlZ2VWNjSm16QU15dkgv?=
 =?utf-8?B?S0J2eFJRcEVJbTdicmY3TGtPM1lqR3BWUTVrWk81bC9nOUc3dFM0eEN6V0xD?=
 =?utf-8?B?eXVIZHA5NUZaTGdkNGJxQXNUUFVFUDJXamdHV21QTGlLTkt6eks3eXE2Mjlr?=
 =?utf-8?B?V2ozeCtBcnFMN25kaHE4MDFJazZaa0V6VTNQSXJDUVhUK2c4eC9PdEhtbjhC?=
 =?utf-8?B?MjhGQTRLVXpOZ3E4UHduNWdUTVRzSmFRaUhob0pCQmhya05Ca0dTcVZ6T3Az?=
 =?utf-8?B?dWJwZmh4SGNRWUE2VjEvT3Urejl1QWovbTVZb0FmQmIvbFVDQWNiODF6cUxl?=
 =?utf-8?B?TWhpRTNUZXBFc0NFMTUwV2JBV0xzNlZnejNicVR6QWJvVnIvd3NObHpGM2Ni?=
 =?utf-8?B?S0QrY0lCNnZSbUx0c2ljNEhkZFA2ZjMwZXNnT1lBeWc2OGRRQjFOaHdwMHJF?=
 =?utf-8?B?NnlXcmQ3UkRCMjNkaG0xQmpoRTZpclc2Q2tkMDR3Vkc3dkFZRkV4Ykp4dWYr?=
 =?utf-8?B?c21JOEUzT0QvWlhmVWJsb3pWSEdvZ3NtT2paVUVDWFZuL3pLYkJURkh5ZGZ2?=
 =?utf-8?B?dWU2Mlh5dU0xa293alpsdTJnVzJGdGJiYTBMaDZtcW1QVzgzNDdud2UvanFs?=
 =?utf-8?B?eFFINCs3MmsyOTc0REtybUE4eDFIV2p4eTdUMGdFQmY1RGs3MFV5UkxzTnla?=
 =?utf-8?B?UlpYMmd1UTlPRWU3KzdlNzRGelhmTU1KbmkwUFlZTDZrNHlOZm8vSEhIVGFx?=
 =?utf-8?B?R0J2ZTh4M3Y0ckdJck1CaHNGbHhxbTZiVXlyanZVZE5jQ0drYVhXSzJXWFVl?=
 =?utf-8?B?bjZ2WXhiMCtvM2dha2lic2d1bTRocW03R0orRUV5Wk5COTFXK2ZZWkphbVNM?=
 =?utf-8?B?NEZMS0UrNjYwMHlSVjAwNGNtc09kRitQWFdZNEhrb0RzSWQySXlOREkwb3lX?=
 =?utf-8?B?cVpPK3BHVTUwVzZjT3p6RUFXZDIwVG9TTkF6SDR6NUwwK2MrY0c3S2pITzB2?=
 =?utf-8?Q?kdthRAbyuO4zrOaalb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ef3ce5-43b9-488a-9b18-08df198c0f79
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:02:26.0653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LRxnp39OlBag5CZmNYjTpDvlu5tUPRWaxo2Q81bqG2mLQXeWyrrh4veLAyvJdE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
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

--------------Ai0ahwQh77BKmP8adzAbRLci
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-09-22 10:56, Mukul Joshi wrote:
> amdgpu_ualink_export_handle() tests robj->ualink_handle_lo and stores
> the generated handle into it without any lock; xa_lock only covers
> handle generation and the xarray insert.
>
> Two threads can therefore both observe a zero handle for the same BO and
> both allocate an exporter node, take an amdgpu_bo_ref() and insert into
> exp_xa, with the last store to ualink_handle_lo winning. Teardown only
> erases the handle recorded in the BO, so the losing node keeps its BO
> reference and pinned VRAM until device teardown.
>
> Serialize the check-generate-store sequence on a new per-device mutex.
> The BO reservation lock cannot be used, since
> drm_gem_prime_handle_to_dmabuf() reserves the BO itself via
> ttm_bo_setup_export().
>
> Fixes: 6b1a5ad90778 ("drm/amdgpu: Implement UALink handle export")
> Reported-by: Sashiko-bot<sashiko-bot@kernel.org>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  5 +++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index a7ae9ffde1b5..32443bdfc594 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3991,6 +3991,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   		goto out;
>   	}
>   
> +	mutex_lock(&adev->ualink.exp_lock);
> +
The import path solves the same multi-thread race using xa_lock plus 
node_state. Export could follow the same approach by adding a node_state 
to the exp_xa node, but that requires refactoring 
amdgpu_ualink_export_handle(). Adding a per-adev mutex, 
adev->ualink.exp_lock, is simpler, at the cost of serializing all export 
ioctls.

Regards,
Philip


>   	if (!robj->ualink_handle_lo) {
>   		/* If no ualink handle generated for BO, then generate one and
>   		 * add it to the exporter Xarray.
> @@ -3999,7 +4001,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   		if (!exp_xa_node) {
>   			dev_err(adev->dev, "Failed to allocate exp_xa_node\n");
>   			r = -ENOMEM;
> -			goto out;
> +			goto unlock;
>   		}
>   
>   		amdgpu_bo_ref(robj);
> @@ -4025,7 +4027,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
>   			amdgpu_bo_unref(&robj);
>   			kfree(exp_xa_node);
> -			goto out;
> +			goto unlock;
>   		}
>   
>   		xa_lock(&adev->ualink.exp_xa);
> @@ -4039,7 +4041,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   			dma_buf_put(exp_xa_node->dmabuf);
>   			amdgpu_bo_unref(&robj);
>   			kfree(exp_xa_node);
> -			goto out;
> +			goto unlock;
>   		}
>   
>   		robj->ualink_handle_lo = handle.handle_lo;
> @@ -4059,6 +4061,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   			handle_out->handle_hi = exp_xa_node->handle.handle_hi;
>   	}
>   
> +unlock:
> +	mutex_unlock(&adev->ualink.exp_lock);
>   out:
>   	drm_gem_object_put(gobj);
>   	return r;
> @@ -4139,6 +4143,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
>   	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
>   			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
>   
> +	mutex_init(&adev->ualink.exp_lock);
>   	xa_init(&adev->ualink.exp_xa);
>   	xa_init(&adev->ualink.imp_xa);
>   	xa_init(&adev->ualink.handle_invalid_xa);
> @@ -4272,6 +4277,7 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
>   	xa_destroy(&adev->ualink.exp_xa);
>   	xa_destroy(&adev->ualink.imp_xa);
>   	xa_destroy(&adev->ualink.handle_invalid_xa);
> +	mutex_destroy(&adev->ualink.exp_lock);
>   
>   	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++)
>   		mutex_destroy(&adev->ualink.conn_state[i].lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 85c9a9634a4b..2a6be8b9d5b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -336,6 +336,11 @@ struct amdgpu_ualink_mgr {
>   	/* handle irq from ualink client of remote GPUs */
>   	struct amdgpu_irq_src irq;
>   
> +	/* Serializes handle allocation in amdgpu_ualink_export_handle() so
> +	 * that a BO gets at most one exporter xarray node.
> +	 */
> +	struct mutex	exp_lock;
> +
>   	/* Xarray to store info about exported BOs */
>   	struct xarray	exp_xa;
>   

--------------Ai0ahwQh77BKmP8adzAbRLci
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-09-22 10:56, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260922145653.1207241-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">amdgpu_ualink_export_handle() tests robj-&gt;ualink_handle_lo and stores
the generated handle into it without any lock; xa_lock only covers
handle generation and the xarray insert.

Two threads can therefore both observe a zero handle for the same BO and
both allocate an exporter node, take an amdgpu_bo_ref() and insert into
exp_xa, with the last store to ualink_handle_lo winning. Teardown only
erases the handle recorded in the BO, so the losing node keeps its BO
reference and pinned VRAM until device teardown.

Serialize the check-generate-store sequence on a new per-device mutex.
The BO reservation lock cannot be used, since
drm_gem_prime_handle_to_dmabuf() reserves the BO itself via
ttm_bo_setup_export().

Fixes: 6b1a5ad90778 (&quot;drm/amdgpu: Implement UALink handle export&quot;)
Reported-by: Sashiko-bot <a class="moz-txt-link-rfc2396E" href="mailto:sashiko-bot@kernel.org">&lt;sashiko-bot@kernel.org&gt;</a>
Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a7ae9ffde1b5..32443bdfc594 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3991,6 +3991,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		goto out;
 	}
 
+	mutex_lock(&amp;adev-&gt;ualink.exp_lock);
+</pre>
    </blockquote>
    The import path solves the same multi-thread race using xa_lock plus
    node_state. Export could follow the same approach by adding a
    node_state to the exp_xa node, but that requires refactoring
    amdgpu_ualink_export_handle(). Adding a per-adev mutex,
    adev-&gt;ualink.exp_lock, is simpler, at the cost of serializing all
    export ioctls.<br>
    <br>
    Regards,<br>
    Philip<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:20260922145653.1207241-3-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	if (!robj-&gt;ualink_handle_lo) {
 		/* If no ualink handle generated for BO, then generate one and
 		 * add it to the exporter Xarray.
@@ -3999,7 +4001,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		if (!exp_xa_node) {
 			dev_err(adev-&gt;dev, &quot;Failed to allocate exp_xa_node\n&quot;);
 			r = -ENOMEM;
-			goto out;
+			goto unlock;
 		}
 
 		amdgpu_bo_ref(robj);
@@ -4025,7 +4027,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 			dev_err(adev-&gt;dev, &quot;Failed to generate DMABuf for the BO\n&quot;);
 			amdgpu_bo_unref(&amp;robj);
 			kfree(exp_xa_node);
-			goto out;
+			goto unlock;
 		}
 
 		xa_lock(&amp;adev-&gt;ualink.exp_xa);
@@ -4039,7 +4041,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 			dma_buf_put(exp_xa_node-&gt;dmabuf);
 			amdgpu_bo_unref(&amp;robj);
 			kfree(exp_xa_node);
-			goto out;
+			goto unlock;
 		}
 
 		robj-&gt;ualink_handle_lo = handle.handle_lo;
@@ -4059,6 +4061,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 			handle_out-&gt;handle_hi = exp_xa_node-&gt;handle.handle_hi;
 	}
 
+unlock:
+	mutex_unlock(&amp;adev-&gt;ualink.exp_lock);
 out:
 	drm_gem_object_put(gobj);
 	return r;
@@ -4139,6 +4143,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	adev-&gt;mmhub.funcs-&gt;setup_vm_pt_regs(adev, adev-&gt;vm_manager.npa_vmid,
 			amdgpu_gmc_pd_addr(adev-&gt;ualink.npa_vm.root.bo));
 
+	mutex_init(&amp;adev-&gt;ualink.exp_lock);
 	xa_init(&amp;adev-&gt;ualink.exp_xa);
 	xa_init(&amp;adev-&gt;ualink.imp_xa);
 	xa_init(&amp;adev-&gt;ualink.handle_invalid_xa);
@@ -4272,6 +4277,7 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 	xa_destroy(&amp;adev-&gt;ualink.exp_xa);
 	xa_destroy(&amp;adev-&gt;ualink.imp_xa);
 	xa_destroy(&amp;adev-&gt;ualink.handle_invalid_xa);
+	mutex_destroy(&amp;adev-&gt;ualink.exp_lock);
 
 	for (i = 0; i &lt; AMDGPU_UALINK_ACCEL_MAX; i++)
 		mutex_destroy(&amp;adev-&gt;ualink.conn_state[i].lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..2a6be8b9d5b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -336,6 +336,11 @@ struct amdgpu_ualink_mgr {
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
+	/* Serializes handle allocation in amdgpu_ualink_export_handle() so
+	 * that a BO gets at most one exporter xarray node.
+	 */
+	struct mutex	exp_lock;
+
 	/* Xarray to store info about exported BOs */
 	struct xarray	exp_xa;
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------Ai0ahwQh77BKmP8adzAbRLci--
