Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBA6CD4F26
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 03:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9282A10E011;
	Wed, 24 Jun 2026 03:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XjtDv7oU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23DB10E2A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 03:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOBtJ+HM5s6IbEwSADaPGieksLaxR6R7JYU0Mjg2VlYR4o/N632fEN1QzU9fiD83SCPc++P+rqyD6nWehOrCopSTbFEKmm3qy+Af5OPy1X+C4vazPkNI+2SutXOzkVh4F4/AyNisHdq+jy2sgT8GOfrVpnzS/OdeBT8xY2MMfSI0LW7o8wMukCfcIgxjMBmdb0IZiNaamQ54PCsh/2gvyNt/CzXaKx408griSos7W2RKRqj335Rhi9YoCYKPVFHocC3g56AMLSLiNlu8WEb0FIHzy7lFLsCDT5/Vlt2KS0qejNhx9tjVyEDzyyBqyTAdWDXGNMz+1nS73dQ96EjxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0q8CouWFuqHNYTF8LMwcIiQTclYo8deamBLOgLJBkU=;
 b=rMvElvkPSo9Wmfjs5PTRIzqUc5qoT+k5d0pRuInwyZxGaKLFX6JTyhDfx3EXuPIfB7R1AwskIRqz5bEbUNoEml0pk65yCYVfT2h7JuhK3fWFCuim6tkY1iw+9te75zmJRtBhmY9ZrwmZ4qaLEQTFYmsW3kws7j6pedR6586dQEQz49oYVE2OyYN1dErDLKc2c8V8ulQZnkJEqMttNupztthQd2aiSljV5LQrmhnE+rjhPDI2N5M+LTIADCGS2HG0iFK+QYMc8/7Uoolw+/fOXRH4rn7YEKdBHJgA9AGafg/WRLzi0TG/Su3FjkfoX4/kyCA/HWb20syiY54rq8ugYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0q8CouWFuqHNYTF8LMwcIiQTclYo8deamBLOgLJBkU=;
 b=XjtDv7oUTO2IqWdU8P8FPjnX/FJlI5HEPp/dN+ePIqWRXHQG7T6E2kds7lIZo0yIX3kjtV7EowDsm1g2/ycSxJT2u1CHrW4C1WAFoNXULlOuJ55emfDJsegAn36a/tx/8NwCfBvEEO/m6pdDUMI/oe18pARZvQENLzmFMO+L/7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 03:32:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 03:32:01 +0000
Message-ID: <0a506ab9-b583-4297-adde-207bd8925852@amd.com>
Date: Wed, 24 Jun 2026 09:01:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix aperture mapping leak
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260623160638.4111587-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260623160638.4111587-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0259.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a68679-c124-45bf-a4f9-08ded1a12713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: OhtctDngrcKza7fNBuCqp35YM/DoDgyWJPNAHEBWooCjfLeI+9t6ohQ7tu+YI/gjEw0zkqTq0vpEn5UmIL7/ArbosRpcUVfOTjsrrMmG+yloKRhwoxbEqKWwT9+843st7HRvQXjd8qkUacgyYUYlPJyWpMIqAMMg3gmqD61j9fIHSexdVjVGREuqEK0XiDh1nri6cm1AnZBwikk7rIHp218gqO80R8FFuq4w71DscljkzD1oPwQRDGGEkZQQvP737QfVDfqNOtmVNPmb0pxWO0cCpYkWzvXhfTNQz+aOugz4kLTU/BMoXKxmfnIKFYDPqDeR6vTGa9IL7nZIwechGowq8JyAEUwUVrYVPfwGsNDuOtG36NFrPGJtMDq40Gu9Os3dFdea147CHmiZkpZ4+o/6JKTO8mU11UZK8fSFG4Z6/td44x2cSVYWva+rzTbQ0NW9e9Dm4cNoCteZlIbTRB018I5yozHJS8jL/dQP9+VjsvEanCCRCNbmN1h8yoI/AONPo5F8WIHBhBX6x/QlBMOnft3GJBAbvOotQVeiHSMUuPPSEIPqRfEkmKpPR1iXQeTTLBq3aAA3T9CJax6BOjJOuuM+vMzXUtYr/sIqtP2Vih+OAhf/0bcmi1/3VR7llz5Q0Uir4mDICOMlxb0OrTSK3D9OSKQlw/R5hri59XM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZNb2ZYSkNLTE1xdHp0R2ZocEROdnBva3R5UVYxbmMrcDRJcmVLMzdGb29v?=
 =?utf-8?B?aHREbWRsWVZ4dTI0Tm1yZmZac3BtNXNueVZKQWpjVkNTaVh5S3hxc0o4QTVz?=
 =?utf-8?B?UlFJQlZoTkQwWHJRM29SMityM0RORzFYUGxWQnFrK2g5RytNSmhsbFFaMWVm?=
 =?utf-8?B?cUdJdE53RmNnbWIrZnRTbWlNYmtGNkhjNE9EUTl3c0s1TS9va1F0enpFNUdG?=
 =?utf-8?B?N090NEw4ZEk3QUE4K2JSc0NzZGwvMm83aU5OWUszZjhkOVJUdUwrcEJjR3FV?=
 =?utf-8?B?UlZhUllZWGZrWjFXbDNMREU1OGxxQndZblJ5R3daNFQrK0EvNWZFWFYwcThr?=
 =?utf-8?B?WGhBbHJSMG9hR2xHRFdJc2gyd3dyOXhYUTJ0N3Zlc3lBWkpMRi9CY0QyWDJN?=
 =?utf-8?B?VkkyTVFKMWlVTC9jeE5tZUM4UkZneFk0c3kyaEVQbWVtMEpJZnI5dERVMzB0?=
 =?utf-8?B?aXZXcmcrTVY0MStZcGcrSVVsT1RYUlJWOWZhak0xcXpCM08rN1pWQzFuRUp4?=
 =?utf-8?B?enVGcVpPYUlOUURYbE1ia1gzNk9ZK2FqT3VvYkhBRHgxck0yaGM3SHBnTncr?=
 =?utf-8?B?QnJzbk0xMzBTcHVVTXhLbFBGWEZDZGxIR3NXYmZxZXBLNGtFK0luVHFPNUVv?=
 =?utf-8?B?cEVydmR4ejNmeDB1UlBGUTlIdGIya1crd2VoalAvUWtxelZHZU50RHM4VDZY?=
 =?utf-8?B?a3NGQXdwb1RJc09yZnplZ2Qxa2dIdVBZajViNklVZ0RTSm5RQ25vUENMRHV5?=
 =?utf-8?B?R1k0aE1YN0tEbGlwTHBES0FBNWZiUHQzeVM4TGJ0UHN2U3BkU3JrSW41amV4?=
 =?utf-8?B?azE4UmZRUHZOUUt2dTZaNUFWWGJleCtFVnJ3MUx4d0RCU2VKRU44SGcyd3NU?=
 =?utf-8?B?RTM0Q2ZEV1hsTWh6dlYwMDBFUzZQcGwwNFppMVhvRU1scFhCZm41bGhRL3RS?=
 =?utf-8?B?bXVZditYeHRPdGpOdlZMOWRkQ3NWYy9EVnRyZnJFRjNsRk1YUUlHV2p0V0Z1?=
 =?utf-8?B?aTZuSjVmU0ZPYThkWVJvQ2wwZFo5SlU2NENxQXIrQ2pGamEzMGdDNzNXcGhp?=
 =?utf-8?B?M3R4bmM4M2grVUZDaW9sTGc3QU0wRTdwWk94ZWxPR1BuSFM4RFVqL2dGczRT?=
 =?utf-8?B?cVo4ZnZIRUt3Um1rMlJHb1FYZ3FKMTNpMzBGZU1GR2d4QlZ4UEVieFlpTmxK?=
 =?utf-8?B?STdBMDBCVDVlSXNxc3M4WmJuc3NERHpGN2U0T2VDbW85TU5ReUxxa0h6a3R6?=
 =?utf-8?B?OTdTS2RZWmVlb0xtU1FZYXFFN2NtK3Q5c1ByWnBoK3lGODJNL2JXV3pNV2RE?=
 =?utf-8?B?UklIK3VIdnlCZlVXS2Q1eUNhRkZ6WW8vOTk3dXZhdmQ1Rm5EM3dGSGpJaytG?=
 =?utf-8?B?dy8xWnJjY0tTSTZqZW9FbDNzTWRjdno0K203WWxwNEVETnorYWdpTHl2Z2xT?=
 =?utf-8?B?UXB6QTJ4cTJYQlI5aUg4bW9tSzc3Qm1MZVVPZlZiUkVBcUZ2MDVvamc3UENs?=
 =?utf-8?B?ZW1VVDBNcmx6SG9QMUl4dU0xRW1yQUFtaVNlcGtNTkhnTWUraGtLb2hYakJL?=
 =?utf-8?B?NnJiVFcrdzI4aksyMFEvN0IxMzFsTkYzSm5sUnNvZWZwWTRYZ0hBQWJvOHNI?=
 =?utf-8?B?L21scGZoMzhvT2RxanN2TGQvOTRWaUxSV3JMWHUvbmJHbk1rUDJpd1BHOU9j?=
 =?utf-8?B?VWF3OHh5TTBFRk1uelArTnlBZ1BVajB5RjNRVFU3VzZLMXdkeWE0a2N1NkZ3?=
 =?utf-8?B?c0VOT1JLTWFkU3ZEU1BTUVN1ZEtlSllMMWN4M0hKV3hNZEs5MW01VTZSOWJ6?=
 =?utf-8?B?cEdaOFVraExHUCtGNEtpeGFRcU9BMXM0YnB3ekFOR3NML21nY2tOQ0czTUZq?=
 =?utf-8?B?NCt6anUxQWExL1pOS20zcjJOSDBLeWlKMzBUQWdvUm1YQlhSbFY4eksvQ3hz?=
 =?utf-8?B?djdPQ3ltOThmRk44VUhzd2dwRGt6TEQ2MkxXaG8xdWhxeEdmU0czTG5vYTJr?=
 =?utf-8?B?bkI2em9GQlV0TndMa0w1SHk2SjJzMS9jVnB1UzlGZzBqU0xtQVJHOUI4clZh?=
 =?utf-8?B?S0dQZzRpR1IzTGYrQUNiMlM5R09sNExZd1hPNVR0Yy8vT2NkbGNyUlNDSjlD?=
 =?utf-8?B?d3ptaFkzUVNHUzlYNElqd0E5RUtCUDIxVkZIYTRPYk96clBzdTZBZmFHUFlk?=
 =?utf-8?B?YXlYNFl4WThORXltT2E2eFFGcHkvUXpDamxQd2M1N2xVb21ud1JZSUNudDk1?=
 =?utf-8?B?YlZxWEpLeG9PZUNKMDJVWmR5bGtGNEQyaWRMOVJJWDRlRzJrWHRhVTZrWkFX?=
 =?utf-8?B?TzRyRjBvUTFZU2ZoaDJDMkJHK2loRHRtQUU3Y0RZcDhZckNWdXVIQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a68679-c124-45bf-a4f9-08ded1a12713
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:32:01.0353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrQg1uQR4ocIfvWHKaVjqbxA6ray/D6+I17InPrzlN1QvqRJxbpwK8UITerBspsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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



On 23-Jun-26 9:36 PM, Asad Kamal wrote:
> amdgpu_pci_remove() calls drm_dev_unplug() before invoking the driver
> fini routines. This causes drm_dev_enter() in amdgpu_ttm_fini() to
> always return false, so iounmap(aper_base_kaddr) never runs on normal
> driver unload, leaving an orphaned entry in the x86 PAT interval tree.
> 
> On connected_to_cpu hardware, the aperture is mapped write-back (WB) via
> ioremap_cache(). On reload, IP discovery calls memremap(..., MEMREMAP_WC)
> over the same range. The WC vs WB conflict causes:
> 
>    ioremap error for 0x..., requested 0x1, got 0x0
>    amdgpu: discovery failed: -2
> 
> Fix by switching to devres-managed mappings so cleanup is guaranteed
> regardless of drm_dev_enter() state:
> 
> - connected_to_cpu path: devm_memremap(MEMREMAP_WB). For
>    IORESOURCE_SYSTEM_RAM ranges this takes the try_ram_remap() shortcut,
>    returning __va(offset) from the existing kernel direct map. No new
>    ioremap VA or PAT entry is created, so there is nothing to orphan.
> 
> - dGPU path: devm_ioremap_wc() registers iounmap() as a devres action,
>    guaranteeing cleanup at device_del() time.
> 
> Also remove iounmap(aper_base_kaddr) from amdgpu_device_unmap_mmio()
> since the mapping is now devres-owned.
> 
> v2: Remove redundant x86_64 guard (Lijo)
> 
> Fixes: 9d0af8b4def0 ("drm/amdgpu: pre-map device buffer as cached for A+A config")
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 36 ++++++++++------------
>   2 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5442a1fc1c37..70d07ca187a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4190,8 +4190,6 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   
>   	iounmap(adev->rmmio);
>   	adev->rmmio = NULL;
> -	if (adev->mman.aper_base_kaddr)
> -		iounmap(adev->mman.aper_base_kaddr);
>   	adev->mman.aper_base_kaddr = NULL;
>   
>   	/* Memory manager related */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index f80371bc74d7..1a211f024446 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2119,18 +2119,23 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	/* Change the size here instead of the init above so only lpfn is affected */
>   	amdgpu_ttm_disable_buffer_funcs(adev);
>   #ifdef CONFIG_64BIT
> -#ifdef CONFIG_X86
> -	if (adev->gmc.xgmi.connected_to_cpu)
> -		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> -				adev->gmc.visible_vram_size);
> -
> -	else if (adev->gmc.is_app_apu)
> +	if (adev->gmc.xgmi.connected_to_cpu) {
> +		void *kaddr = devm_memremap(adev->dev, adev->gmc.aper_base,
> +					    adev->gmc.visible_vram_size,
> +					    MEMREMAP_WB);
> +		if (IS_ERR(kaddr))
> +			return PTR_ERR(kaddr);
> +		adev->mman.aper_base_kaddr = (__force void __iomem *)kaddr;
> +	} else if (adev->gmc.is_app_apu) {
>   		DRM_DEBUG_DRIVER(
>   			"No need to ioremap when real vram size is 0\n");
> -	else
> -#endif
> -		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
> -				adev->gmc.visible_vram_size);
> +	} else {
> +		adev->mman.aper_base_kaddr = devm_ioremap_wc(adev->dev,
> +							     adev->gmc.aper_base,
> +							     adev->gmc.visible_vram_size);
> +		if (!adev->mman.aper_base_kaddr)
> +			return -ENOMEM;
> +	}
>   #endif
>   
>   	amdgpu_ttm_init_vram_resv_regions(adev);
> @@ -2247,8 +2252,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   {
> -	int idx;
> -
>   	if (!adev->mman.initialized)
>   		return;
>   
> @@ -2271,14 +2274,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
>   	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
>   
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -
> -		if (adev->mman.aper_base_kaddr)
> -			iounmap(adev->mman.aper_base_kaddr);
> -		adev->mman.aper_base_kaddr = NULL;
> -
> -		drm_dev_exit(idx);
> -	}
> +	adev->mman.aper_base_kaddr = NULL;
>   
>   	if (!adev->gmc.is_app_apu)
>   		amdgpu_vram_mgr_fini(adev);

