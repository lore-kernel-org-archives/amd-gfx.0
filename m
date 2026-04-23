Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98D2F9936C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E33210F0B0;
	Thu, 23 Apr 2026 11:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQhzMEbp";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E438510F0B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh/yPdumH+cJedZNY1I4Unndm2Tf3kRvQGHgIyt5zo/pbrQua7OnBdW/K7pXlDngjqAt94XUzy1+64OzREBWngYEw6MwMgPPnuMHiNhn+hkcaQMhjdd+KAtMSkfknitmwI3wVtTTxEsuIkUhX8SUk6TrkmsY3HMnoiTIRQER8Mdmr/Ik0RJH9aVV9v7vepE37cyES3PxHBJkAasSiQQAokLw2r0qvDVw2UjuOuby/yYKxZ53TOoptjIZFVmj+MhS0Mqe8Q49vEdp71xJge8odKaemHSbtYVUEvoU+ZeEbOEVwdlWOWXa/7RPY0XiqGEtVVH5uKmUYMyHyQQ1ve64gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvQghr+ouvgB/9JNJOldc20EoP3TG+sdlIJLNCkyZa8=;
 b=sB4aw4MBtIza7BOyLiWzDcTEN5g1OgARiZRauFfPpg6EXsW8bYm2ZBe+rzAPme5jwl5ZfVLpVexycpSLvTX4hCYC2TSh/XrqJKVuD4KISfh8xUSgKB+J6GrLrcMDtW2O7mPEHcCt3orVhpweKiJkAa73XwDwzBi2jEDxdPvo3VKooyvAFyYLVH6dTuTy/E9GUX8n4LQOhi/Djo2i3eeE1yVL5mdLPu85NTjsA8sgxp59j/7UBg9KRYdVVYs4TA9WMDQPyRKLsn7VpgkQ9/gV6CWl3DlBkG5jJQWEuytmY577gDBU/8KgvmU78kpXj1PC4eeBYnU1+fJ49zEYzqD0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvQghr+ouvgB/9JNJOldc20EoP3TG+sdlIJLNCkyZa8=;
 b=MQhzMEbp9NitzWVmUbM/9Yv4u2cBMWzBp8h7sn4AvwR8IUid4mzOAmikcPHzm0FdSYhisOBantZ85dREFwH9tmzk/FimlwdyRFArNB4SWbMNeogKKL0YS41U/Q9/ITrJpw/0TLx8WhzVZDbOT5czfGjS8ppliw0BB89LzvYRMKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Thu, 23 Apr
 2026 11:06:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:06:23 +0000
Message-ID: <ed8b7ef1-ff55-429a-bae6-8c07a5edd97f@amd.com>
Date: Thu, 23 Apr 2026 13:06:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu/vce1: Check that the GPU address is <
 128 MiB
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260423011614.309180-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:207:3c::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca5d81b-8110-444a-869d-08dea1285b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: r+86Mva4XPnAGeeSTJ/7oB1P75eMq3nIoLR+3k/F9d2PYV36+xh/mE5nY9GxYvCeUz5URO5cLMZfL7HF90txNCQeKbgwZvWWjat039//WOsAi5Co4aAyYJOEcQN31CPYIHxt6HagHB8KftIaUgQ02TJMGo6O2M3RctLk4OMptiwPlnTAaie4lxVwvt6nykbzBxCZPZ3spAI82HTCJajSR0CaASN/+7Z+fg1oOXwbgGSbJpQZEfgRuMGCoqGkNRe+yxQKeUntoqjBNyIC589TXxw8aTxWyi3/kqNSCxSi09RMDMuj3UBDfp8CK9mlTSSYdJqXKvkW3AJeTrl+YPoVfYcS/T4I+DYVdKKANbxQLZuYjijmWLULeo1kmueTfB2SPaAhjRLt+v4bEcYYA8BXY5haWSD+fq/Ov85YIryQdtbYVQb6wzUPCdJEetQ1RKvkZq+sI1D1qLHNgjBZYl0bpjDXpz+Zk9HN+mHcAQvWRA4hsURqKpJ0H/xwi/naYw9r66nyKUy0m7eUcDCDUfSyvN6IVu/eamxRgjhFWVtgZIyxlIWirKNhu6FnaI7ofzDx815VwyqHd8xoZwmh3fgVhNCTrNNLuOWMYXD1aGf4QRHvGQPGz2z8BebzNGzncpdGc3VZXIBLabOVhZMXSsb4BGkKnNl8hRXAeGG9+KWiZYwjcP7Jh+2VWyY121kbHDI7fVFxI9R29tqpuqofkHGpafz8p7WEdJnsxriTYa4Ycfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tvUnJWNU8yTTZpai9Oblg1NHdJUy9CYjRIcG9PVUV0N2hTZkNjTTYxdFZz?=
 =?utf-8?B?TmZNTzJqemtIVnpXcFQzNlZOcGtIK1NKd0laUjhGb1NKM0NqMmNmQ2hNdnov?=
 =?utf-8?B?UVhPOXdoQjQxZDJqdUEyN0JTemlRMTRYeEVXeUhvdlJtM0NVYW9FZWFwWXFz?=
 =?utf-8?B?aUE2a3RjWEsvUXo0UjdwczBWZjk2dkFwY0dNbDVCOXgwN1h5UmNxdUZYQW5Y?=
 =?utf-8?B?VFJrcW0zSVgzOVpNTEdzc21VQ0xCZnQzV3ZBV1N1R1FxN1h1MTB0anVrVlNr?=
 =?utf-8?B?WHJCazMzZysrbENUR0NISlBZeGRmVzFLTHJZRlVSeGw1VkhlNFliOU14eDNj?=
 =?utf-8?B?MEh6ZlZUNzUzd0hyRmhwakYra0xlYXc3a3dDbktyQ09ldkY4UENOekdhbXd6?=
 =?utf-8?B?Y2FZWjU0bGJSN0M3aXFDS0NsTWlWbjRuZzhHZ3FsL3JZOHJBUmdaL3FFejln?=
 =?utf-8?B?V0x1QkkrRFZyRGdFYndmaEEzeUVrOXhTQmdreVlQOEIyS0FWZldYcTJzKzVl?=
 =?utf-8?B?M0hEMDFWM1Zic0JXOFAzWFlYYTg4RE9YeEVWY0FlZitmTk12NGNjU1lGRDYv?=
 =?utf-8?B?RVYzQlRiR0Q2bFFsazlMeVdhbzRJYzRYbFhkNG5QM0pOc0NFZFhja2ZDcXlu?=
 =?utf-8?B?SWhMNGhGWXA2ck1ZNHdTbWZ2cnVSRjZaRlRYdVlSRHR3SmJCK3VwZ01VT1dM?=
 =?utf-8?B?ZlNaa2pxVTMwaStnbWduRWNVVkxaQ1dvNUVISS9WZTcxOWx1OTJRaldWM04z?=
 =?utf-8?B?RUg2bVUyYm9jam9YRG1tUTFNdERvRGcvZm0xcHkwcmZzZkZRZ2EvcVJrVEJD?=
 =?utf-8?B?aSt2Q28xN0RxWDMwS0UrTGNPcUoxTEZia3MwQTJzWUcrcm52ZlU5eWdlbjYw?=
 =?utf-8?B?RnRiOGFPTjlCTGEyRWt1eDlETFlITjh6L2kwMGhxeFhlcFR3anJlZ2FpTVpC?=
 =?utf-8?B?ZDU5SVM4aFRpNnFZdHlScGFvaWhPMkVpeHNZS28yRzVJd1Q5Rm92Tnk1WWdF?=
 =?utf-8?B?OXY4ZjhGbHFQbWlYWG82bU9ITFoxWkJxUWVibTNXanJVOVFFMHRwWUp4Rkta?=
 =?utf-8?B?YTYycUE4MjhBWGVSOHI3RFRNVktZWEx4TFh1Mmt2ZlkvSStMbGROdE5xY05y?=
 =?utf-8?B?WWZRbTh2MGZ5OVR2MFNnZVRidkN3OUVFU1VDTE1lTHFDanJ1VnJqK1FCMGVl?=
 =?utf-8?B?Y3UxV1lHYm0yWk9sTW9RdktqSjJDVnNSdTFVeFVtVGk4WWN1WlNKK3lhZ29P?=
 =?utf-8?B?R2ppemFyRFRYUUFtWmtmcTZzVnlhZUVxbWRRbk1KQ3dUYTdJaHRYVk1kSHFM?=
 =?utf-8?B?ZFJ5dEJDSlV3ZjluS01IOFhSZm9QcFFNcGROblkyeDNXcXBoVmRaajhGaGIw?=
 =?utf-8?B?TWlCSENzTkJzNTE2NlZTVGRQN0FXa2xUZkpuWkVFK0hCZG1WL3BEcHJyQzJF?=
 =?utf-8?B?d2lPTEtQanpyNmRlaU9uRGVxNUFvOTdwZjc4RDFhN2QrTDE1L3loeWZoZERp?=
 =?utf-8?B?Z1FGbWh3YXdBc0llY2hDMUswdnNqdS9xZFN1bkxCOU9QZ0crZTkvMGZLNkJ1?=
 =?utf-8?B?T1FxK2VQMVk2T3BHT2xWbSt5UGpiRDNGM2NJN3RvTWwrdysrdGY1akxsM2dL?=
 =?utf-8?B?UUFyYTFQSFVYZFVTWUZwR2dMekJsZjFTRnM3NXN2K203bmQwUlgyT0tXRXNP?=
 =?utf-8?B?OEVNMjZPM1hXZUIxSnJSVjIrdlkyZXVOTVBSRks3Ri9RYzg0S0kyYmE3Qk9U?=
 =?utf-8?B?OWdzeUxVb1JyZ1hNQ0VZZVloNDdTT25Qelp5bUhEejBteWpOdWRhQ1lLa1V6?=
 =?utf-8?B?SWdmOG1NaTJmRFpOakhYeWJnN0l6aHF2Wm5zMzN6WkplcnlnWFpMZkl1MkNo?=
 =?utf-8?B?Y0VPdVBNTEhINTNyNDBvT28zNS9ZQ0xWdDl2VWI3ZVQ5U1hDOWNia2sxcU54?=
 =?utf-8?B?SGU3U3pMOWVYUlJXQXMyZFlubE1IQ0hRZVdWWFphS29FdE16c0FQU040QUJP?=
 =?utf-8?B?NHpOQXFLdXgrMEptWjVMRE9YZ012MElHWHhabExlTjR4WmRTQldSWHBGUkV2?=
 =?utf-8?B?YTZkR0h4WnBBOGh3SjlESE8rYU9UOElxbERmZ094ZDNucUJxSyt4Q2Q4bHFU?=
 =?utf-8?B?MGVLK1k5azhtRkpLKzg1KzhQblNwZ3NOb2JwaFZ3eDZOOVl1TVNQWlJBV1Bz?=
 =?utf-8?B?dTdHSmxFanJiUDBOQ29lZzNsVnAwVWpaMmFlNnp6TEJpakNsR3hFRTl5MmlN?=
 =?utf-8?B?SWZYY2QyL1RTMjNCZlFybW5STDNJS0c3QVY2WXdPdGhPaHZINzRjbllQVytZ?=
 =?utf-8?Q?P0lTQ7tBdjdnDG7lin?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca5d81b-8110-444a-869d-08dea1285b38
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:06:23.6663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q87gVEf22IIKEeki+r9qDEsVRX08VXiZjjUdUFTt/kN/rZpepqJtZfgW0GB+smhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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



On 4/23/26 03:16, Timur Kristóf wrote:
> When ensuring the low 32-bit address, make sure it is
> less than 128 MiB, otherwise the VCE seems to fail to initialize.
> This seems to be an undocumented limitation of the firmware
> validation mechanism. Note that in case of VCE1 the BAR
> address is zero and we can't change it also due to the
> firmware validator.
> 
> When programming the mmVCE_VCPU_CACHE_OFFSETn registers,
> don't AND them with a mask. This is incorrect because
> the register mask is actually 0x0fffffff and useless because
> we already ensure the addresses are below the limit.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 5b7b46d242c6d..edabec442cb63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -313,17 +313,17 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
>  
>  	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
>  	size = VCE_V1_0_FW_SIZE;
> -	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
>  
>  	offset += size;
>  	size = VCE_V1_0_STACK_SIZE;
> -	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
>  
>  	offset += size;
>  	size = VCE_V1_0_DATA_SIZE;
> -	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
>  
>  	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> @@ -527,11 +527,15 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   * To accomodate that, we put GART to the LOW address range
>   * and reserve some GART pages where we map the VCPU BO,
>   * so that it gets a 32-bit address.
> + *
> + * The BAR address is zero and we can't change it
> + * due to the firmware validation mechanism.
> + * It seems that it fails to initialize if the address is >= 128 MiB.
>   */
>  static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  {
>  	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
> +	u64 max_vcpu_bo_addr = 0x07ffffff - bo_size;
>  	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
>  	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
>  	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;

