Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C1606A333
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uqbp2r7z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF321123BA;
	Thu, 19 Nov 2026 13:20:36 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A2A1123BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIuRihYuUgSgqpXUKMUdJPcuuwDg6q9kWjc0bGzoRh3rGLAidRXg+WFD/n926POhOKNU4EzpyuL+LUb7rd2vZaa6QTqOj5exBKe8OmLzNXrnV3Szp1J8lurytVKetFZFH15wIremYf9LUjDT19LgQEW13LHs3bgPjJjxTW+462KY/gfOOU2wo8/L/ZM3+ybQlDdc2IqYKFnGdjn6tP+1wSi+0xbVd5WwfdK3IVkjSrottMilyZLBBVBjYRzF+YLD/4uI0g0lOkK+9fpQ/bIiv/lApg3eAjL+NaVN3sMx8txP2OZXWyGEIa3jPcKUfe9KemOX1mVW/BHVV/wBwKBNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K33bpHVuHClVGJS7MYVJXHQRCiJuKpnEP9NjIbcXy4A=;
 b=dt/GKU0aAu7EqmZVGq4GXN7Ip/cgUP315aKuUNkrF2FND6kTT3VU4/VvSOnhaT/wZDN1QEBG4GpkZ9XvPHmKKbKkjMbHpdqYWpewgJ9yQyAxc5WoBE6Sk6FxU2V1+qo83D5ew1DBPCivTj3Dx/mLek8bQL0IlbGzy7ts53CGtjHsaZwyrDpgsN23c1EJJaAA5Qml3t9guD8f63ddNLimKtpLkSlO4CtBcKvhuO7i9guh+tNIz/vnRI4QO3bLmwX810gRgHjBsbDMvK1KxbEWruQtK6ugNaOz+A+uy9NIE55noJXpN4RTnQOUQI+ie/pcvR5QlKRjwW93ilEOcyd1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K33bpHVuHClVGJS7MYVJXHQRCiJuKpnEP9NjIbcXy4A=;
 b=uqbp2r7zuqWq8VecrdkFWfoixPsYmn10VYADtOhdlPrpSGRvPeysVP0AAP67y8LMI1qSY/0fIzWQx/u9rHY3v+94XfwWqP3D9EqxPN5GOSIWuZZpVHHFG4ePPUg2/SL2Ku8nJ54vts+GX9mTruqzFxVy+XsXa4+n2Cteg1/IbdI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.10; Thu, 19 Nov 2026 13:19:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:19:40 +0000
Message-ID: <3e437ad3-5b89-4a7e-90ed-3889b10a898b@amd.com>
Date: Thu, 19 Nov 2026 14:19:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu/vm: reserve more fences in
 amdgpu_vm_lock_pd
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: afa3eff0-c7db-4360-e4d8-08df463fc406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|4143699003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|56012099006|261022075727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: mClpl05Q4wqHKdQJov2rO9OS1MtvH5yyw2lbXGWQNMaioXW/iADpjCa17l5XBOkz28FbB2cblbxB6LIgiVkJyDNTj5dW/7cvUcwwed4Xop4OeK4nP5wbphv1S5cJSEE6tD6L3Hyib2YV5KZHcaKOloEObIpu3eM+nqckuQl7yWR1HdV5OMfzeWKpfB49M3yto4VnXyTo/mrMCh2qgVbrsDyQBGuBOCWxMgkxu2d7gIyPOiFSks6lkOrM9LgcwhgeuIfDa4Ivaaog/w/JgacpnuM1HUAZ75EPIwHmTwY4dLU4fV0rpisDyCIPwZPdbEjkfk5vqks1i+5BsrzYUN99GvSRZGBIv4n9ezirsPs41pMNsrWQsGR0/zUY+Gc26B7OwemUmagtlbjpcVztSHXL4iqTmv4zcj+3Gf5qgPjl+yVuFAJ6DAN25417ypmNFrn7ss8E6QQ3Ly7KzNaFa59PQWqzUxqfjyXbNd5g7eQ9f+7RdwwbVJOy+BR23vILwcUgH+4h0bu42w28kRr9/TmtckfPipPQm/a4/UCN6xtM1lWxql+qhKAlRRLoTfNMjGBXjkG+8mRcnM2lOLEixXc0fbH1RvCcSuqFhXtenQzXJWfuDZ2rPz7XauM/Iy/FMsCDT6xtH7Emlh2evLbgB/qcjuAIh+/AezCeiy0+ZWWxWko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(56012099006)(261022075727099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzM1aXhDcitBV3RheUJYTHpwcVRoK2QzdWttYmJDaXNmTkY4KzJJdUZNYzdi?=
 =?utf-8?B?U2Y5eElMSEFUTURvYmlxSHF3cWtEWmpuMzVYM2lEbXpnN0dmU3VoZ2tTeEtV?=
 =?utf-8?B?akJNNWdZbmo4dmhKWGFQVW9JbWFBbGlodkFNSStaYzhHYW51dkxkNGhrc0NC?=
 =?utf-8?B?YWJqaXoxOWplOGhYK3loK3dwdGlhYTZ2OXRZOE53M3IzQk1SYmhneGp3cXNl?=
 =?utf-8?B?b3grZ3VkNS9Qa2ZUclpHUGd5YitvS0dKM1dvSldiNDhUeXR6d0RhdUtNRlBp?=
 =?utf-8?B?ZjNKV3d5dkZYOEE3MjlkRVF4T1JHNmk3ZFFuQklQcUd5N0cybEkzbG9zeDAz?=
 =?utf-8?B?TGpiQ0NNTlR3Qmx0eWQyeE5xMDhEazNYQVoxNnE1amhqY2F6eVp1WXlPeHNG?=
 =?utf-8?B?YmhQT29pZUdlQ0p5WFZKTU52YnpvRkVwU01ZbVlPQ2Vocm9VS1NTMUJMWVFS?=
 =?utf-8?B?ZmlJcGxJdzBjYTVucEV2RGhuT1cyejRCTUZycXY0OVJlYUo1MC9Nc1EyMFFi?=
 =?utf-8?B?QlJzMmN5dVVBTlQxUld2eUdETFF2ang5ZlN0MEtzV29WVHRpWjR3QTNacXQz?=
 =?utf-8?B?U3FPNXZDSTdVNnpRWlIvTTh6aVNHSkJqQWlwQkRaaTZERGk4ZUR3d0dFci9n?=
 =?utf-8?B?OStPSFpGeHNZbmhvREt4UHRBWXdlRXArTUZwVjYyMisyYXArcUxLcjdweWhR?=
 =?utf-8?B?LzdPc29BVUR3VWp0Q1R4M01icWZrUXJ0cmo5MjVhVWk1Z1RnQ0tYVlhmZWND?=
 =?utf-8?B?V0FPUzZmVmJ3WmNqd2FrdmluUTJ2UGxINWgrcHhJMTdvckhKcHN4dnh2TWVS?=
 =?utf-8?B?dVVBQS9WOGF2L09xaHB3NktIU0J0bmcvMkxhcDlyUG5SeWdLY2pDUFdGY3Qv?=
 =?utf-8?B?RFJoVFRHbU5nYUQvMVJJVndsRTJXdUtjYlRFblRhZWdWZFZzQll0K2EwSGIz?=
 =?utf-8?B?NkJHSHVmMXJYekdKU2swdGpIQWtnWjJyeHJJajVyVUkzWDU2OFE4R0ZEb1BY?=
 =?utf-8?B?UGNUU1Bzb3dtSC9tS3Iwb2NxaVk1MUZPMysvYU5QRlVwd1NSa0xyK3Zza2Zy?=
 =?utf-8?B?aWNxcEIvWmZicXprcmNCY0syYlpOaEc3bWViMjVMQmxXT2o5Yk9SeVF5SU5P?=
 =?utf-8?B?TG5KakpXMGVTOVNBK0dGK0JpMFROUC9Qck42TjU5ckwwdTROZU44ZjhwdUVE?=
 =?utf-8?B?YjBuTjBJVEJqZDVzTENSZTZQdUxZS0xOTHdlcDA5TzZLVDlpK3hDUTcxa29j?=
 =?utf-8?B?K0FrbjFDTWZKejFoamRkTGhkTGVlallYalJHdUxORHh3Y1RTOE5Dd2JMcFhj?=
 =?utf-8?B?UGUwU21NUWNPcHllS3ZtQXplaDgzOGpyeHg3K1JmZThsdGc4bzF6Y3owNnRT?=
 =?utf-8?B?aldQTHNRYXU1dHBwVnRjdjZMY0pQZ0RJWllTYm1SdVdDT1pkWndDemQ0VCtL?=
 =?utf-8?B?VDVFSjFWTzBZVU92MGtQRGFFRVgyc3Z1c3FJTFJjcGpkcDgwd2Y0a0c2NElC?=
 =?utf-8?B?eEc3TXdOMG8vMXB1ZFZmSDJrUWhQandGclp0U1dDdlkrUG9wdmllSzd4Yjdx?=
 =?utf-8?B?M25qRGl3SnkrT1pBSjNNbXVrTFNtaU1sV1k0aGhjdDZ0L0lWNkIvWWFiM3JE?=
 =?utf-8?B?UGJsOVNTRmdUTTVQdUhHR2RkMm9XM0lYa3NtQys2ZTdnUTFIQ2daM2EvMlB3?=
 =?utf-8?B?dktOa20reXpMbzNCRWpqR2Fycm1iTkJ6YWR0Z0dURmkyNWIxQ3g5RjFsaWpV?=
 =?utf-8?B?am9LVDlOV0wxc3l1cjQyTVRVaEV1VFdyL2hGZ09aRVRVY3cxV3hzcDVIUlh5?=
 =?utf-8?B?cjlYYTFURXhTOWZ4MlB2eE0zc3NQd0NWYm85aEl0UExCYUdMUjN3Q3ZCa2Fy?=
 =?utf-8?B?MGFCUXg5bUtRSWE4QnN2alV2Z0gwOXRUdGthVS94Wnp6enBWajNTZUtBSnE4?=
 =?utf-8?B?d01oclpNZE5TZldQSHIwcnlMUlRHWmpxWkkwV3VBcU8wWGZMdVRJMEx4NWtT?=
 =?utf-8?B?QTNLK3N3Y21vUkhibzE3eis5cHlRYWZJbnNONVdPVmNFSVAyRVZwWVZRV09F?=
 =?utf-8?B?VGtlb1UrYmdKWWhvN1k2U08wZnU2TUFHMXkyenliMjM3K2hvWmdSazBldG41?=
 =?utf-8?B?ZTMrRUhpZFUxRTRsR25WSG45N1Q4dHV0eU5RVlhMK25UZnBkZWdXVHNnc3Fh?=
 =?utf-8?B?dTIyaTFzbitDejRVUkk2L2NXS2tzYnVyRm8vUzR5akZ6OG9INWZwWmRveHdM?=
 =?utf-8?B?aDNhZ0tua3BidXliaXJ0OTFUUEtVMm9IYUduYlBVOFhYejcxaEtpNEFWN09v?=
 =?utf-8?Q?483EzEdEkCbMsj5avK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa3eff0-c7db-4360-e4d8-08df463fc406
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:19:39.8780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYARfqIL3QIUtWfTXKeNQu49anlD86nQ4xsAUOX37aRKUFZ1EHCtyeKCetQvCxaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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
> Any page table update may currently add up to three fences to the root
> PD's resv (last_unlocked, SDMA commit, and TLB flush). In addition if
> any PD/PT BOs need to be allocated, it can add up to TTM_NUM_MOVE_FENCES
> on top.

That is incorrect. The last_unlocked and SDMA commit is on the same timeline, so we only need two.

> Introduce AMDGPU_VM_UPDATE_FENCES for this count and reserve it in
> amdgpu_vm_lock_pd().

The function amdgpu_vm_lock_pd() was introduced to avoid such a define.

Regards,
Christian.

> 
> Fixes: d8a3f0a0348d ("drm/amdgpu: implement TLB flush fence")
> Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
> Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 8 ++++++++
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 2d4a17e11a1f..2403cd911058 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3073,9 +3073,9 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
>  		struct amdgpu_vm *vm = bo_base->vm;
>  
>  		/*
> -		 * Fences for the two SDMA page table updates were already
> -		 * reserved by amdgpu_vm_lock_pd() above (it reserves 2 +
> -		 * num_fences on the same VM root PD dma_resv).
> +		 * Fences for the two page table updates were already
> +		 * reserved by amdgpu_vm_lock_pd() above on the same VM
> +		 * root PD dma_resv.
>  		 */
>  		r = amdgpu_vm_clear_freed(adev, vm, NULL);
>  		if (!r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8cc5964f29c0..6d8d639e5986 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -462,9 +462,8 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>  int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>  		      unsigned int num_fences)
>  {
> -	/* We need at least two fences for the VM PD/PT updates */
>  	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base,
> -				    2 + num_fences);
> +				    AMDGPU_VM_UPDATE_FENCES + num_fences);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f6285a9d9e98..8117bec01e4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -187,6 +187,14 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
>  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
>  
> +/*
> + * The number of fence slots needed on the root PD resv for a page table
> + * update: last_unlocked, the SDMA commit fence, the TLB flush fence, plus
> + * the TTM eviction/move fences of any PD/PT BO that is validated or allocated.
> + * This needs to be bumped whenever a new fence is added.
> + */
> +#define AMDGPU_VM_UPDATE_FENCES (3 + TTM_NUM_MOVE_FENCES)
> +
>  /* VMPT level enumerate, and the hiberachy is:
>   * PDB3->PDB2->PDB1->PDB0->PTB
>   */

