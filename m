Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6F4C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C33410EB7F;
	Tue, 11 Aug 2026 12:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LZCMRdtz";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74C010EB81
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 12:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATpnhTchwqGPOyvCEgQ6FGPaT7i8CQqQMznq6qvCzIG3rS67vZK3NEaCb2WUlHM+5e/rRI5T7alGH4+EhSTKeniOoiYdSkD4FPV+Nnr8aIeGspAp81RMfNJWLDEz6oqKxS8sqhu34JutpkakA1evU6NyoCr9EgNne0yZyRJ0N/XIw4YA8ZhRcxSf+Pc94BDKnuMbV0zSrmqubr6dWynF+HQJIy/4jc7VKRX/DV5bb8+4iFAWy7hlLDfySUt6e0B/UgoSRmqVdG7DwpPVsRDq5RJLOHx4BF57cfZO6hh9jA2FVx6cM53AEVtiSaRwjEfMTW3ORLPB6DeMVBbj+YQZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7fP8hVZNcLpRuTBbFp406cdfUVX/dL94+hDWj46cko=;
 b=lKjcaWc3/uMZId7+JdMK1UpmjNur5Yk85+FoqcU6T6eBrrlT2q318qg1SNqTQkjGmx3VUwxiaJ38VdH6jc8l+gWyEd6IUQ9wsyi3+w6r+vG9+0lvwNns0gq2Y+7/OpavPOl4XCGSSKmKtRZz9oMGoliVmhEDQIHtU90GXxOIV0LBcRYGcpdTf7j94pvz34ptyTjmA0wnOyhpDd9cSPpd7YPYru5BWAJQ7ojeBSbPqjZB322De2J+1CZ+w32zk/GlcvsMZ5iAl7CiLkBTpG0XoAfMK6vgHuPEetwUpZHgHQSWGjr5oIsQBiSwD+2z6Od/x5Noi4nznIyAJFHq71dABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7fP8hVZNcLpRuTBbFp406cdfUVX/dL94+hDWj46cko=;
 b=LZCMRdtzuxeN8jcBVQ6388LUIvlXlO1u2XWZnrQL739ebaDGVyqHyqwnCCljLB9JwNLGesFQ4skTdu4PFXrT0U39xp+H35uvuRMgpmF6x1pSW0gyISoF01yUfNbTlaMb+mT1KtNZf0KAZVZvS0x5QQb/EUK/hiyggHr4Cf5A18U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 12:28:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 12:28:02 +0000
Message-ID: <d2d08abf-989d-4e88-a69e-a8ab1ffd4cb1@amd.com>
Date: Tue, 11 Aug 2026 14:27:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: bind imported BOs before mapping them into
 a VM
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com,
 Prerona Ghosh <Prerona.Ghosh@amd.com>
References: <20260811080717.547510-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260811080717.547510-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0434.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe5939c-1d2d-4606-7327-08def7a3fc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: i7VLhKTtKdLvtpiSRTHk8jYyPSGcQetMM3eo/wzK6O31fJuJKTGwdbmGWmOhnoW99+41snsRbM5ZsEDnBpgJrhbaKKzVK0WuUbSbc9Lb9rbXP0dtDHENARDNlhFuSBuRN0m2Ky6p3dX6kO+5jbRr5dxFTqPBYSwHEhUrl0qChn89+obu166ytG9UB1mZGuqbmkU31AQt9E1+TBZAI0JFzoFzxaT6AVVWs763iH/eatqJijUR0EDVYAaT9uCBQ+uqXbQ5YVpLhUl11hTQG2NL0OUsGlN/JDd5tAGA+0KoM2uMc7tuPG5RPmxaGvDnl/woppBsELHsZQ+irFGVdxBG7Sz+UHAVlI5nld0OEFBTK0qJbewJJalbdgeThRzhFeJuKwAHWduFY6L/5653FfE3YDThohSbT+t6h8ytPrjEVwxDkufv8HsAOi8FGU1S7By/f1onx+uwf+YG8AhtI/mbJ5UvIIkEmTLwP6wp4Gc50T4kDOuk9G0vA1QxrTs6doa/AqMoufjAfF/fLaqIqEN2cfdysiXZs9/nJLYyjy6qYQYTEHUh8Qxb34HYW1qMRoAon3+2BSKiuGfvwTa3kRXMRURAwLE8AfwI63F2tFrpv8DqSNqeoKfJPN6AqHUMd7791MUy6+tXo5nPeI8iZp6DXJYthpSZz3XWQWbpPA3Razw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlMc25Dc21UcklvMTV5T3dIYW1CdWY0QUdKa1o2TkJ2WU9hRk1RR1huWDVh?=
 =?utf-8?B?WTIwWDdBVzM3QzczWk9sRi9tTHFuTkNXSndWTi91NXcwTEdTM01UUUtvOS9P?=
 =?utf-8?B?ZXFIZmNmQndBSE1XMSsxNHhaVHcwZER4Y0VZRVZUcEZwYjlvTmthMC9zdHNu?=
 =?utf-8?B?bitmUHpCRFZJVXVNMTZKV0V1QW0rSGJITlh1RGpobTE1eDhObWY5dlR2NmdW?=
 =?utf-8?B?WDc1WU93TVk0QSt3TE1HdGdqTEdGQWUzbWdaa1laM2k1OHk4UmdtVkN6Q3o4?=
 =?utf-8?B?dzZlWmJzRUtaeHloODJ5WWxIRkJIU3pONDVhV1FHb3J1a1R2N0hOajlTaXNj?=
 =?utf-8?B?YkhpeDMzVGRVS0tObXY3S2Z1S21RQ1VONlJCbnZIZUxGSFRNUG5zNWtLSm9N?=
 =?utf-8?B?ZjhYaEoxeU9pSTIvek1zUnpaV0wzNHF3cno4bXYyVjJEbUU4NC94WFRFRHVL?=
 =?utf-8?B?SHAwcnlIeGNtR2FwUnhUSDRYSER5Z0xzTWpOQ2ZIQ09BZmtNMGQ5N3dCNyta?=
 =?utf-8?B?cmp5aEVXdG1JVFgyTDZtN3pWbTV0dG12K3NtT2ZpejNpeVdkOWFZOHdUTFBq?=
 =?utf-8?B?OWlLbE9qV1RGRUdTZVRpdmViZ2tDdDRGeGxpOVYwY3UvV3FNRGtRdmtXdWF6?=
 =?utf-8?B?UFRuY2RUVE1CNXRhNWs1dFBYb2RtaGNnRWlRaVE5ejRicTFzd3VIcy93WDJK?=
 =?utf-8?B?aUhpbjFjK0g0OXgvOVp6SnNoRzVWMDJ3V0g4ZzRCTDNHa1NnemlISkxpbEJI?=
 =?utf-8?B?WTZJRzFXVUQ3Skcwai9UcmFmbE5ZZGRlVmFrMkE4UmlWTy8zNkdTSnVhUndw?=
 =?utf-8?B?UmZ1VWR6bFYyRFRXS3duQmNONDJSRUQxbGdpRU02UGFrTmhTdWRwU0FpZGlp?=
 =?utf-8?B?U3dzcDQ5UkxvWFNIVXg1bzRBWlVRc0d5cGcyZ0hIR1J6bzRwem1NTkFac3RZ?=
 =?utf-8?B?a3JLOEtmOHNCV0haSVBFMGYzbGY2S0hRbFY3cWtKVzU4N0pZekkrQnJsdlIv?=
 =?utf-8?B?TGtJVW1QNXQ5bTZ2YzM5T0FTaFZYelZHNVNGam1PSU90TjJJRkxieFprazha?=
 =?utf-8?B?SXVEbWRDaG5zc09Sb1BTTXhvMUhRM3MvRlV4Skptb25xazVmbWxBUzFENlRG?=
 =?utf-8?B?aUQ1R2NaUHNnSWtaSFAxcW40RXJqVmVmWThrVjM2MjY1cFFxZDV4TkZINXpG?=
 =?utf-8?B?ZE5kSnNWYzFTblB4M0N1ODhCbVVDYkdXQTB6SVM5Uk5QYVRGZnlreFJEV1Ev?=
 =?utf-8?B?SUpUdi81VldBQzAxVUxQS3lGSG5LUmUyZkJxajRjdWxDalRGZkJpZkJUdnln?=
 =?utf-8?B?TG9tbWNqaFlIWTIzbU5RQ1hZMDdpeVhuVzV5Snp6dUZDelZibGthaWhJMllp?=
 =?utf-8?B?WGMvbS9kY2lRUG10aW8xOEQxY1VPQnVKQ3ZaY3VvcFBmSVdHTzlzSnJ2YnZV?=
 =?utf-8?B?ajBsWU0vTUQyZ2RPM0VhOWg4ajZjMGVjcjY3S0hZcWRSZHV4OER4eGJIbVhj?=
 =?utf-8?B?eEtKMFpQZllienpoQUJMb3JibmpUOHNDNWZlOE5LNWJIemttRjVQSGhoZkhL?=
 =?utf-8?B?NjM1dkNnNzRxdUUveDlIMGg0R2o2c1NRaExBeXNmS2NYdnVmZkI2ZTcwSm1U?=
 =?utf-8?B?YXZUYzE1UUw4R0xiY1ZVbml6VnNVV1VvUFhOaHJUMlR3SUxqczhNd2FNRmhq?=
 =?utf-8?B?NGQ5YlF4MEgwV0ZNSXNMamV3MUNhZlVrMEZWOGE3OVhEeFB3S2FwYy9UVXR4?=
 =?utf-8?B?bFhOVUZkMGthTnNJd2NBWWhIN1FEVFVNVGNFNVdIQTZaNDBrNGo4R09uRGM2?=
 =?utf-8?B?cDM3UlgzdmRXd1JQUXdYM09nRHJQeGJDTkN0TGRXdkRqczFpandTMitaMVZE?=
 =?utf-8?B?UHpyYnp2S29IUUdoVmMvOWhuMG5qalFqdytyUU53Y1hFWHFvdFFPc3I5NzVL?=
 =?utf-8?B?VWV4YWhXR0pBUUdkdlFsZzlHWEhkY2o2NVNrNlFMQ21aQXJBM1JGWkpCSVpZ?=
 =?utf-8?B?K0ZzR2RDcWJjY3JCY0wrTzJlMXkwWVVWMEN3YzJ2VW9MQWxCTS9PUGhiU0g1?=
 =?utf-8?B?MTFlM1UyV3FicWNscTAzQUFQc083SnNwVjZ6KzRlNVRXN1YvbGFISEp4Y0Vw?=
 =?utf-8?B?bWZnUEg3aThWc1ZmNXRBNitaOTB0MEZCRHltamdvblVabE5xQUk2ZEZNOWZV?=
 =?utf-8?B?VDArKzJBelBNeXIrWUt6NTRmMTVZT20yMzE2cDBOZzN6OHhxSWVOdmhVb09S?=
 =?utf-8?B?K0FjSFV3Y1c5ZEN3TnZyY2s4Q2ovNCszdTN0UWIyN1pSOTFIUjFibTZrRmdV?=
 =?utf-8?Q?+n0X3ssm0sgqZHStTx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe5939c-1d2d-4606-7327-08def7a3fc3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 12:28:01.9331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yKMmIX2mZIjLMATCnfDHJrXvR5UR7Xcg5rXHo4Nwo4nBPxx27zpSMGciFa5a6oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

On 8/11/26 10:07, Yifan Zhang wrote:
> From: Prerona Ghosh <Prerona.Ghosh@amd.com>
> 
> An imported dma-buf with a dynamic attachment is not bound to GTT until
> it is validated. In a VM that is not a KFD compute context nothing does
> that: amdgpu_gem_object_open() only validates and fences imports for
> compute VMs, and clients submitting through HW queues never go through
> amdgpu_cs, so amdgpu_vm_validate() does not run either.

Well that is a good catch, but clear NAK to this hacky workaround.

I suggested a long time ago already to change this behavior and validate inside amdgpu_gem_object_open(), IIRC we even had patches for that on the mailing list.

Did we accidentally dropped those?

Regards,
Christian.

> 
> AMDGPU_GEM_VA then maps the BO while its resource is still
> TTM_PL_SYSTEM. amdgpu_ttm_tt_pde_flags() drops AMDGPU_PTE_VALID and
> AMDGPU_PTE_SYSTEM for that memory type, so the range is programmed with
> PTE flags 0x60 (readable and writeable only) and the first GPU access to
> it faults:
> 
>  amdgpu 0000:26:00.0: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:3 pasid:46)
>  amdgpu 0000:26:00.0:   in page starting at address 0x00007f142d6d8000 from IH client 0x1b (UTCL2)
>  amdgpu 0000:26:00.0: VM_L2_PROTECTION_FAULT_STATUS:0x00301011
>  amdgpu 0000:26:00.0:      Faulty UTCL2 client ID: TCP (0x8)
>  amdgpu 0000:26:00.0:      PERMISSION_FAULTS: 0x1
> 
> Validate imported BOs into their allowed domains before MAP and REPLACE
> so that the mapping is always created from a bound resource.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Assisted-by: Claude:opus-5
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 29 +++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f754a4a3a1c2..214ae2a95da2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -747,6 +747,27 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * amdgpu_gem_va_make_resident - bind an imported BO before it gets mapped
> + *
> + * @bo: the BO about to be mapped into a VM
> + *
> + * Imported dma-bufs with a dynamic attachment stay unbound until they are
> + * validated. Mapping one while it is still in TTM_PL_SYSTEM would program
> + * PTEs without AMDGPU_PTE_VALID and any GPU access to them faults.
> + */
> +static int amdgpu_gem_va_make_resident(struct amdgpu_bo *bo)
> +{
> +	struct ttm_operation_ctx ctx = { true, false };
> +
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type != TTM_PL_SYSTEM)
> +		return 0;
> +
> +	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +}
> +
>  /**
>   * amdgpu_gem_va_update_vm -update the bo_va in its VM
>   *
> @@ -962,6 +983,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	if (r)
>  		goto error;
>  
> +	if (abo && drm_gem_is_imported(&abo->tbo.base) &&
> +	    (args->operation == AMDGPU_VA_OP_MAP ||
> +	     args->operation == AMDGPU_VA_OP_REPLACE)) {
> +		r = amdgpu_gem_va_make_resident(abo);
> +		if (r)
> +			goto error;
> +	}
> +
>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,

