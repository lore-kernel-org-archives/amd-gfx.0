Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC5BC44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 09:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D2710F4A6;
	Fri, 17 Jul 2026 09:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RS7B0xH6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5B410F4A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 09:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqVssUC3z0IIz2fpa6+iKzI7L6slCP98Ke5TTtCYyiHGvUtqpmYCVRUCGhUB0R6LLXCsCb0TM3X/B6vl5PMB/NStyhga3Q6Ov0kqmbvT/keYLX+0cYZci0i0aOLsmGmuGlXV8UG7JXRyF27jLi4E0tzKhkmOliajIcIGzYG+u4XCOiXql4KgVn9ItuiXthhkK2UGG68x//RXfwj2sYAW0/FY7cKjGZMLCnvGpvPtPNnHmLNe0/3AZLBg59qTYZUSe8DPUBk4wSmgwkrbDWhrjdZ7qhRObQPgdo8hrKy4T5PEZlPMBBCzJbeHEl9h6v2i+Xx6Zgz4PJDvhTA3+8FR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nRWdbgV2QYieluE7tct8Ly1nPGjWkG2KVsGYE0ogD0=;
 b=RaLemwZncXprnglLHjvqYuzpHbFYLjLzm24jnu79HG425v4MgV+hv5Q2wGv1MlOL3grBp6XHvyLrt08PoYXZ3CWM6m7P88jAhLK5R0dRfSGRm/y9tu/4JBx285UdiB0708uUiToJeSZ4ZQ6nLFNf51JQAG8/Ko64CPsmmzgmDxqawdvimOFmAgproP+kedy/TMlA6ydFOrrtnYnlVOG0tQMQHwcTmzYjArHZLZHmjXL+2CWTQuUN7DKeuf8TyZhTPdSO6Al8iuiHudcebYMiLVQx4Mf4l9/f7eTLCE/tjt7Id8R67xLSrQSun8CGRdZ3py2LatgPak8SiMNICVLwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nRWdbgV2QYieluE7tct8Ly1nPGjWkG2KVsGYE0ogD0=;
 b=RS7B0xH624dWE6veA0jcMq+O9MUGq5s7CU47JUurynRxhgVh8xiF5VAKQQzeVKTyg0bhzxjEWeD0TvbEr4LADeDVCGoA40pcb+BoV3bcAw0MaZ3Pxx+YsqLim0kYUPeNGJtxNCCWt/rY6rQaiQ+4FLzKYF39/fDO8ufBjf9xtXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:03:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:03:43 +0000
Message-ID: <8c4a6b19-57bc-44d3-b141-0f2eb9973b30@amd.com>
Date: Fri, 17 Jul 2026 11:03:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/amdgpu: Allow PASID allocator to store fpriv
 owner
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
 <20260708152729.3209550-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260708152729.3209550-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 79752d1b-586c-4f64-89b2-08dee3e24d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5Ql6ZTQvrljkWnmwSz1gAuprJkfserrwHxISMQCubsTrDKDpkvS44AhdcE8JxnocKk2OUjFpEwXlES8Tvleee4r4++RsTGLFZkSUDfu/yeouYbSQTHvUjoTY8UwxoJ/RktKBLZcd7E6FfVpb7eHmvfytz/AeckUeiowxeU0jE4F0Xi7lcw2/9NqTSGp+bo+sDdt0HZ+zwHj5Rsmcqd6AdDwO8xDSQA6qPVepofuq/UGIx9FCSCYGJR/xQq7wVovYL02JKxM4yyMTvYJOeJ8BBaBgRBpTfr+oeRXkAvQT2/Rq77B1Zc5TdSqrfWw33kAsHWQCxJ0sWeIl7fn0/XREMZOiJ8lwWKg3a9mzVPwcK5ChQq5qMMfNXO0eWo3dAABgi6EwmbPg/BTW4UAL+qI0K60k1iafNNSXmCCYhHMrWaLhjYkrYeFmrT1iUMQyhmFIwsDFLs8mKlqokAGrpccdGogCMRmxAa2h0Y1jFRhN2CCWOxRQ4tOZxFsVLBx7hMJsaKLD2wiChQDMMOf8Qh3gacE7ovrUQzm5aiFOPEb9sc0r0RifzM6RrBXc1QL+3gf2FHxJLLjrRO1wT8ZrIe/sabytoLdMnVwi9tydoLtEF8XK+W8P7vOijaKGMax1+f4n/Uv7H+xvbY88YKy2l823oJvZ4oJVlnVk5khh0y64vMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2l1ZFR1alpRcnJDL00vOTlWL0hnYUtwcjBLTG1hM0F6UTdCZEFWMXJzTWJ3?=
 =?utf-8?B?YThPcHUyYi9EZWhQRUljTUxEWW5HZEJsTHNFaVpkM3Bhd1QybDZVSEVpalFE?=
 =?utf-8?B?ZkhtTFE0dlp4eUVsbEJjR3REd3lCb1VwaGV6NmF2RldPdjMyWkV2RkFsS1lu?=
 =?utf-8?B?eFIwbEIyUjNlelJHU3J1QzF2anhWWDNFcWhtL3JzU3ByeFBFWXdoVHZTL1c5?=
 =?utf-8?B?Y2Q4dGpnM0Nxa2ZReDZ0bW5SbHZ2M29mVUZlVWI4SkR4M1lta3pKUk1XOVVF?=
 =?utf-8?B?NTRFYnRXR0FsSVl3Z3FZWEovWWNLRzd3blEwRmpGSG9Ob2orUWEwNGhsbGxq?=
 =?utf-8?B?STk0OWxaSnhHUHM0NjJHZUttQzM4UlZCM2Z6SE9TYVo0TXBEakZLTFg3RGh3?=
 =?utf-8?B?bHhvQnZCR1hOTXJHQ0RReWwzMGxaNTNHOEpXcSt4TVJuVFVkSVJCZ3RLSUZj?=
 =?utf-8?B?bVhqcEVOVE5ZSFdJdENGMER5Zld4b2RDU3NST0xzNlRVV21wNE9NdmJFWkJF?=
 =?utf-8?B?VVluQlZxclc1dTlwQjgvUUJMcjNzME9lU29KcEhoQ0xsdXJveG5jRGNoQU1k?=
 =?utf-8?B?RlU2aVpTS0MxbXVhV2M3bTBuZEpDN2lSNGdQT1hreWtuU1VRMHJ5NGVHM2Zz?=
 =?utf-8?B?TVBiWWMyTkpqc3VyR0J3U3RWYzNtUTRVR0kvM3k5NjZDL1kxYVVPbnE0TURL?=
 =?utf-8?B?aWVXbFFEWTRqc0ErMEJ1MTFBSW1sYUs0ZkVyeXVUZ1lWUXFLT3hIMDQxaDJz?=
 =?utf-8?B?NU0xM1k4WTZEckFQRDVZQWczMzNkLzNGQ05KL2VCejQ5QWYxZCs2cmxQdXNV?=
 =?utf-8?B?M0FRVDlZWDZES1l6QWIzVnoxNFg3TkJkdXQxY09NVk4wZkx2QVZFbTFidnNS?=
 =?utf-8?B?ekMxUnQ2dXJuVVhtajFrYThrNHNySVRBekowS2QwaHRpSXRaTEwvdkNnZ21S?=
 =?utf-8?B?NktFUHJkYk10Q2oxakFMQkZhb0wxWXZhS3V3K3RDZlpPVXdvdy9DbUxSQ3NE?=
 =?utf-8?B?NEtkdHJiTnRReEZNUGxpbzZ0UHBTRTl2aVAvV1dTcUhXNEZONHBGRU9zRGFD?=
 =?utf-8?B?RTJ2SXM4SjhGTDlXdHJlb2FwVkhKbVJoYmVuMGVoNHRNY1RKb3NXdmxaaTNZ?=
 =?utf-8?B?TjR1eVJOTWV2aGxLZlNTWklGMEtIdm8xSy9rRkhwWkQxZzJMRHFxZm5KamtF?=
 =?utf-8?B?NEN0ajlBUGFSMTc3NE9tMERUOGJFdXRxYjJHakFNb2ptT21xcjZnQjJzRU42?=
 =?utf-8?B?QnM2TmRrNWswNlg3VWF5NnJzMkcySXZYRTlBR1NMbEpxeW9SWDFOc2NpdkFs?=
 =?utf-8?B?b2pyRmpWcjhtUEpnMmhHUkg3V1BJTkZuSFFTSFNGTTFhdExSUk96NlgwcnNo?=
 =?utf-8?B?Y05aencydlQ4RHNEa3VScEZGa2krZTFyR1FpWWF6aVh3c3BEbkFXalRIdTlS?=
 =?utf-8?B?amJkVGt2TmNsSmtXRWN0WG9vVXFNTjNsYmJ1c2tZN244d3lxTU1LcUU0SzZU?=
 =?utf-8?B?R2ZwZ1haSllwOTEvMUFybG9DTGdiRm13MEpZemhmMFYySnh2Mm9pUHI1czVK?=
 =?utf-8?B?UDRFQ2Q4K1lLRklpUzJkMTMrVnRobHg2aWc0SDN3Rzg0VzJJMytRZDdhNFpW?=
 =?utf-8?B?aStkMHhWdU9aMzNEME1PcXRRdFV3MlZtSzJCVVlVcFR5N0hEVzF0YjFrUWcv?=
 =?utf-8?B?R3VkbG9iTC81SFFMMFBhVndyRjQwOGFZSGdpR25MRC82YnNHZzFZamJTVHlB?=
 =?utf-8?B?c1ArSkhGcHBHTEFUQ1ptNE02SlZDMENzVU1aeFN2QVp1b1Y3bVcyMmczTkZi?=
 =?utf-8?B?ajNKYmd5dndhUHFWbkthSlc1ZXFLR3Jmc09ZamlVaDFUNm83SUg4dXhPbFZn?=
 =?utf-8?B?Wjg3aElsK09KSzZyWHQzWDBESk52dzlZRUlSSk1qMjlXMm45UFNJMjdYb1Zn?=
 =?utf-8?B?WkIwa2JSZXZSVTZYbVJxcGU4YzYvb2ZXWUpGalBhUjU4VENoY2xZMHVpZDJI?=
 =?utf-8?B?SUR0WVMyUllBZGN1MDhHbTZ4OE1ZcUE4TjVzUHYvTDZ2Q09Jd05GWHVLWU5C?=
 =?utf-8?B?bXNZWkR6TFZmUWt6UE5zaVIvSXZraWhNVG9LZmlLODNaYmVaMWR3MkNDYTkz?=
 =?utf-8?B?dHVINzJ1L2liVXVHNFF0bHVUQklXTEVBL1Q1bVY3cXJPM09wZndYS2lsMXZE?=
 =?utf-8?B?N1B1QzR4QkdVMmRncFYrSjQyWkJabkx2b21VL0JjM0QzSHU5NWFjL0o5Q1Fa?=
 =?utf-8?B?b2JSZkdUZVVoYytFK1dHaGhLRWk0b2E5SmpxdnRsbmdjTjk3V3dXN3JBMTFR?=
 =?utf-8?Q?dT7fk5pqLMxvSPLrx2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79752d1b-586c-4f64-89b2-08dee3e24d40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:03:43.4536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5ZymfEGibr3RKzhMg2KRXa16+lnOpk7Mzl4i/f+hnhGYO2Ky3PE6G9AUOeRJpSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

On 7/8/26 17:27, Srinivasan Shanmugam wrote:
> AMDGPU already has a global PASID xarray used for PASID allocation.
> 
> Allow amdgpu_pasid_alloc() to optionally store the owning DRM
> file-private object directly.
> 
> Initial callers pass NULL. A later patch in this series passes the DRM
> file-private object for DRM PASIDs.
> 
> This prepares for using:
> 
> 	PASID -> fpriv -> VM
> 
> instead of:
> 
> 	PASID -> VM
> 
> Clear the stored owner from amdgpu_pasid_free_delayed() before waiting
> for outstanding fences so PASID lookups cannot observe a stale fpriv
> while the PASID itself is pending delayed release.
> 
> v5:
> - Store NULL instead of xa_mk_value(0) for ownerless PASIDs.
> - Simplify owner clearing by unconditionally storing NULL.
> 
> v4:
> - Add fpriv as an optional parameter to amdgpu_pasid_alloc().
> - Drop separate amdgpu_pasid_set_fpriv()/clear_fpriv() helpers.
> - Clear PASID owner from amdgpu_pasid_free_delayed().
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 69 +++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
>  3 files changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 684f40fce73f..d41601aab3c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -52,6 +52,7 @@ struct amdgpu_pasid_cb {
>  /**
>   * amdgpu_pasid_alloc - Allocate a PASID
>   * @bits: Maximum width of the PASID in bits, must be at least 1
> + * @fpriv: optional DRM file-private owner
>   *
>   * Uses kernel's IDR cyclic allocator (same as PID allocation).
>   * Allocates sequentially with automatic wrap-around.
> @@ -60,7 +61,7 @@ struct amdgpu_pasid_cb {
>   * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
>   * memory allocation failure.
>   */
> -int amdgpu_pasid_alloc(unsigned int bits)
> +int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv)
>  {
>  	u32 pasid;
>  	int r;
> @@ -68,9 +69,9 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> -			    XA_LIMIT(1, (1U << bits) - 1),
> -			    &amdgpu_pasid_xa_next, GFP_KERNEL);
> +	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, fpriv,
> +				XA_LIMIT(1, (1U << bits) - 1),
> +				&amdgpu_pasid_xa_next, GFP_KERNEL);
>  	if (r < 0)
>  		return r;
>  
> @@ -106,6 +107,64 @@ static void amdgpu_pasid_free_cb(struct dma_fence *fence,
>  	kfree(cb);
>  }
>  
> +/**
> + * amdgpu_pasid_clear_owner - Clear the owner associated with a PASID
> + * @pasid: PASID whose owner should be cleared
> + *
> + * Replace the stored owner with NULL while keeping the PASID allocated.
> + *
> + * This is used by the delayed PASID free path so that future PASID
> + * lookups cannot resolve a stale DRM file-private object while the PASID
> + * is still waiting for outstanding fences before being released.
> + */
> +static void amdgpu_pasid_clear_owner(u32 pasid)
> +{
> +	unsigned long flags;
> +
> +	if (!pasid)
> +		return;
> +
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	__xa_store(&amdgpu_pasid_xa, pasid, NULL, GFP_ATOMIC);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +}
> +
> +/**
> + * amdgpu_pasid_lock - acquire the global PASID xarray lock
> + * @flags: storage for interrupt state
> + *
> + * Acquire the global PASID xarray lock with interrupts disabled.
> + * The saved interrupt state must be passed to
> + * amdgpu_pasid_unlock().
> + */
> +void amdgpu_pasid_lock(unsigned long *flags)
> +{
> +	xa_lock_irqsave(&amdgpu_pasid_xa, *flags);
> +}
> +
> +/**
> + * amdgpu_pasid_unlock - release the global PASID xarray lock
> + * @flags: interrupt state returned by amdgpu_pasid_lock()
> + *
> + * Release the global PASID xarray lock and restore the previous
> + * interrupt state.
> + */
> +void amdgpu_pasid_unlock(unsigned long flags)
> +{
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +}
> +
> +/**
> + * amdgpu_pasid_get_fpriv_locked - get fpriv from PASID
> + * @pasid: PASID to resolve
> + *
> + * Caller must hold the PASID XA lock.
> + */
> +struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid)
> +{
> +	return xa_load(&amdgpu_pasid_xa, pasid);
> +}
> +
>  /**
>   * amdgpu_pasid_free_delayed - free pasid when fences signal
>   *
> @@ -121,6 +180,8 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  	struct dma_fence *fence;
>  	int r;
>  
> +	amdgpu_pasid_clear_owner(pasid);
> +
>  	r = dma_resv_get_singleton(resv, DMA_RESV_USAGE_BOOKKEEP, &fence);
>  	if (r)
>  		goto fallback;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index a57919478d3b..4b55d0d9703a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -34,6 +34,7 @@
>  #define AMDGPU_NUM_VMID	16
>  
>  struct amdgpu_device;
> +struct amdgpu_fpriv;
>  struct amdgpu_vm;
>  struct amdgpu_ring;
>  struct amdgpu_sync;
> @@ -70,7 +71,10 @@ struct amdgpu_vmid_mgr {
>  	bool			reserved_vmid;
>  };
>  
> -int amdgpu_pasid_alloc(unsigned int bits);
> +int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
> +void amdgpu_pasid_lock(unsigned long *flags);
> +void amdgpu_pasid_unlock(unsigned long flags);
> +struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid);
>  void amdgpu_pasid_free(u32 pasid);
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  			       u32 pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 6b4de2a6c629..0c973a3c73fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1488,7 +1488,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		goto out_suspend;
>  	}
>  
> -	pasid = amdgpu_pasid_alloc(16);
> +	pasid = amdgpu_pasid_alloc(16, NULL);
>  	if (pasid < 0) {
>  		dev_warn(adev->dev, "No more PASIDs available!");
>  		pasid = 0;

