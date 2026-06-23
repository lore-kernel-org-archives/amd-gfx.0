Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9980CDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 12:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F29310E0AC;
	Tue, 23 Jun 2026 12:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fw9hfL3O";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011031.outbound.protection.outlook.com
 [40.93.194.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86E510E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 12:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veAAn5sCjDmddZCZHFm1H3Zu+tw6LF6k/YCNYk6uJjMciy6zG89HHor28PlLo7k4hX8OwVdzGAOo8tsnVtBh6iCH2DGRvo/aIPsAV3Ek1Y45496laXE7oKDStziuxjMS5Jbg4npFWQF4YetDHRkeEeziw9d4LDRbtWrTCLUN96dwPnX/sE0VWivviSqAFZuLQRIGl6F/JLalnTtHYwzIzqVitBiyd+8zRDxeDLwiEtw7PzSuyCpUj4PiuHxB/LcMlyg5b/kc+JNfenmWcrVI6sdwEs82EcTw/iiEfL11/LSU8pSmGBRuLc2UdPXTNhfj2RBOjF/wYVWn/zu0kAWGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+37Z4e2VDVbigiuu09kQQ+Suo2PjhTjkNDVSS1ONQ60=;
 b=sGCmM2JjD33XT0sgDo57gvivtGQ9QHDIWXDFLGxci9FZzyLAZhRlOzbjhwQQcrkLiki6tu8am/N2+99xxU7XVR1CKDfHZQI22aenVCTEUDsmtJit5f71JQ6bH1xVFX1LifHoUGJbgyQsz/oWNkecimNi+Vt2GhcLTnHE/t+1apI7RM9mzA9HlIR7nZFtJH8HSIuydSRsq1RZjicCAO51O0N9XHsGsQU+TXCYPnSvhKLNudX+UngrW87LVZEOkfEtQbpCjvkQVL6uWMdjGPFr1Q5IgAoIBTe7KfjdEuMKzw5vxt4L8/nJ77xytfQYZjGVm1018nghAEiRp5Y/WVp7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+37Z4e2VDVbigiuu09kQQ+Suo2PjhTjkNDVSS1ONQ60=;
 b=Fw9hfL3OvBbp8PU2suRxIWTTAaJWUY4KpqcFGarv7d1btxL03Jrif1dfaw4aMZOU8A5NIVWID9oej00nPUaEkg0BZVc9FrQlA96QEPFoEvMaRl9K3Tr3xeZboFdCp3SfPm+59RECn+carxX4YZHOX0m+Z7PlUuig4aIXcE+NP7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:34:14 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 12:34:13 +0000
Message-ID: <01a91893-bad3-4687-9627-f4c68690e810@amd.com>
Date: Tue, 23 Jun 2026 18:04:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix aperture mapping leak
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260623034617.3946617-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260623034617.3946617-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: af14e68e-b2d5-4734-9bd1-08ded123ba3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Mwci2Vqc5g/U6jcJ45YQkLAWnEAcEKM/q8mWK8JXS2UpSglWaqcRyiNTiwsy3jJc4LKsNRosJa2aKSiitAcrvtmv34OQI8Jt2QqBk3KkZFo/b6zlLQvjXlQWx6oHlfg5ZE5xESbfTzNeijvKuwPoVCDmS2lD1EN34PNPHa5KmMCLQX1wWYAcHYJgAGnPKOkz86n+NVLXc/NZQpzfZiOVileTB99kFxhfpJhZqxxHe/B0BN74BVo1R+3RCYWcKxb2SUWwemEAolONNB/Xh78Wnskp90kWpo8hwXc/5nvjRoQAr4OItNMJ2g+sF1E7RUsIYWSj37RDbUf/xSacMABM8p5DJA3ju2ybTIdrF8WVZRFbJChbwF2uyGi28pNbq+b2iUOikMHfOaOHzK6w1aSm+6VLJbrbVDSZz0i2y4XL3q+68J/E+UA86m0XJZxrcByFWd37a5UbfHnucEaLuV7KIUtO/GfkmXVS05APJroFWdHpu6qRq8ZDWjLsiRphwjlU5FVBSgRsXBqpBAtCcm8vExSGp+bGKbj8kG2RRwxq+FKpPlp1Ov70IMqhrqvsuvt4/63XesApzVQXQHj7jOpFHvUvabtlm/NGQfMfF9xA+2AIQciaD/hUamFdGf2Avx+63CDcAzb1Bk5nxF7ESmxQ+AwW9OrRwHEQwsziIQrra+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZIUFpkMWl3VzZsalA3dWl6RmxPZmdOMExtVUlwakUvVlM4Tkd3WHN4WGF4?=
 =?utf-8?B?MDVBMW9mMWJlaEZGWE5wNVVIVFFMK2VPbkNDby9kb2JHdERnVDZ4YlZZTzBJ?=
 =?utf-8?B?eVVyWWxMOFA3b2R3bG5kcTVDcm5zZ3dNVVBzMmdZYjVDN3cvU2VYUTlSTG5D?=
 =?utf-8?B?bVB3aFZXSGZzZHVUaDA1cmxuMjlMWVE5SWJPVHlZWi9zNUlQV2xvbjRhU3FM?=
 =?utf-8?B?Y0FPS1lzV0ZnOGU3cDg5MktYRGh2aXpUd0ZzVmovbXVaK2V4M1MyRHhhMXdl?=
 =?utf-8?B?S0RGam5RYndRUXVuOElsbUJha0pqczlNdzYreG9YL3dwc3lUV3oybEhPMFhP?=
 =?utf-8?B?VksrUlMvT0I0UmFnZlFrWnRneEFJb3BMTDRZTzBGTjRhS1ZrTXlCR2NXTTRT?=
 =?utf-8?B?OUxGVTJSWXFHdDA0dGxTRTZaQnhoSklac1JYemU5djYvMmErKzIwN1BFR2pI?=
 =?utf-8?B?UjhkekQxKzlsVkxBbzF6NTRuN1VHNDVpbUM2SVNLMEJ4ZHFnNFl5cHlPSFpo?=
 =?utf-8?B?d0ZPVWI0YmM2UEhSNnprb2MzN3RnQVV6K3hNU3JZVldNUGE4LzBVSys1OWdF?=
 =?utf-8?B?R3RxY1JCOGMrRU9mS3ErTmxtT2VXczFMMUNGbnVGaXNyc1RnNjRoRytaaW9W?=
 =?utf-8?B?U3JZSWc5VUJBQ3lud1BxbVBRY001OHk0RktjT25EQm5tcXlDd0w5U3J0K1Bn?=
 =?utf-8?B?eVBvRjJmTHlyTU1ack54cnVDc252TThkMkZDNXFIbys3UkhhVEU4UENxNGhu?=
 =?utf-8?B?dTJYa1VnOG5nSE4xM0JRL1MzdXpFWllweGszVWhNeHVvOTNRallYakNpZER4?=
 =?utf-8?B?OUV3eENWOWpHcnBMamlhSGxPQmtUNzd3eUVxS2pPb0tQeWQ3YUtFeTJUbHR0?=
 =?utf-8?B?Y0Y3ekhJRjg2LzVXUFlxYTd3QUJSMi85by92UnFnR3dyRWpuY0E4ZTg3THp2?=
 =?utf-8?B?YlBkTjBuYjBZZGtHOThvT2YrK0dqTnd5MFFFTFBJVnBtdkRNcldndGc2eHh0?=
 =?utf-8?B?eEtzQlZJT3BOOUpmanVPQ2xQbEh2bTBRb00zSk0rckQ5TmVNZHJRTG9uc3JZ?=
 =?utf-8?B?TlRqM1dydUMrN3IzL3B3aHBjbTdGRGZtQVNIZ04wMWxLN1YwQW92TEt3Qmpm?=
 =?utf-8?B?dFV4RCtMSkNZUFpiYjl2OUJudFVsZHlBZVAxaCtZVUs4czNFUHJKWWFGUEhU?=
 =?utf-8?B?cXM1YmFkdUNDT1NrSnZNeCtOSjdNM20yVjdDcy80ZnhHU3RRRXNYUzZkNkpq?=
 =?utf-8?B?Qkg1VkIxMVdCYlB5ci9GZjJnMTY4djlVOVoyaFBKWkREQXNmZkdhR2QvWmpG?=
 =?utf-8?B?aEFad2NnMkFPU24vZUt5MG1iQnR4TWFvTUZnWkFnVVNBQk5XYmROZWUvZWJR?=
 =?utf-8?B?a3l0OWY2NjhEMUxqSGVuUUVCOXFOQkNDMlBOQTBDdDNLYkNtVXdwdmNyYXNv?=
 =?utf-8?B?a2huNmt3UGV5ck9rbnFCTjY4N3R2Q3JvbitVSE1HNVd6QjVXSUFYZFF0K1B1?=
 =?utf-8?B?S3p5bHd2ZnhRdkFhRTh3NnkxYm56Yi9tVWxKc3hZRUcyS3lBZzJydXhXUmt1?=
 =?utf-8?B?WUN6WDdHaTRHeUFaWmJ4aXpjeG1CZG1vUlpObjVXQ092dXYrNXJlOVBUNFVu?=
 =?utf-8?B?aDdTL2MrNkprd2RQbysrNkxyWU94MURmeDNycGtuenQxZ0g5dGRnLzRCaUZL?=
 =?utf-8?B?NzFNME5HYWlzMDdTTzEyYXNoeHlrbXJDaENuLzU5d3RvN1ZaMGJYUHRhUXcx?=
 =?utf-8?B?TjNWcS84UjZsMmxsVXJlNHlSQlJlWXlPRGtWM244aEZZYi9GTkFaSzM2d3dS?=
 =?utf-8?B?ejkyVmh0c3lvNVNkanpsRHczNE9kcGFSaitNcTdjMjR0NmM0ZEF0Q1h6RHdU?=
 =?utf-8?B?NEFvWVczNTFIcW04WUcxK1U4dUsxdlJUMWpPcFptcW1Ub1F4WjZiQzRLQVdE?=
 =?utf-8?B?ZDZCVndmVlU2T2RmZDRaY1ZSUFpiWjU5Y3lDaW9rYXAyUXpURkRsMXA2QUNw?=
 =?utf-8?B?dWMyemFWR004Sm16YXZNRDRKUFBhOXY2S29LTEs3ZGsyZmllU281YkZUbFZF?=
 =?utf-8?B?Um1URzNramlxYyt4bys5d2VobFhkaXVpeXU5b3lMQ2hVYXJteGtvNVRPL1NY?=
 =?utf-8?B?OElwTUdiSlpYSUZ3ZnpDdUlYVllWam55OEVwWXBhZWo5RklSVmtydUlqWlJZ?=
 =?utf-8?B?emRUcXZqZzlJQkMyemxMTVhhckxqSTNqeWI5UDFsLzY5VDJhTTUzR1VhS0J3?=
 =?utf-8?B?eWlkQnVDRW5WVk5ETnRlMWRPV2RWcGxxei9ua3k0S3BSMngrdnlMb2pXdHZM?=
 =?utf-8?B?a01PWVFNQll5REhlblFpcFhDUFFHQVpiUjNGSFNDMmdTQVY3Tzg1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af14e68e-b2d5-4734-9bd1-08ded123ba3f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:34:12.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYV1RCU0y765tWLC6kunKp9I+1BZ9V1+tG5QQQCREoNQZCONIfw7sOgak2gH2BY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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



On 23-Jun-26 9:16 AM, Asad Kamal wrote:
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
> Fixes: 9d0af8b4def0 ("drm/amdgpu: pre-map device buffer as cached for A+A config")
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 39 +++++++++-------------
>   2 files changed, 15 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 42fff6ee106d..dbe229459f10 100644
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
> index f80371bc74d7..ddf657484f45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2118,20 +2118,20 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   
>   	/* Change the size here instead of the init above so only lpfn is affected */
>   	amdgpu_ttm_disable_buffer_funcs(adev);
> -#ifdef CONFIG_64BIT
> -#ifdef CONFIG_X86
> -	if (adev->gmc.xgmi.connected_to_cpu)
> -		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> -				adev->gmc.visible_vram_size);
> -
> -	else if (adev->gmc.is_app_apu)
> -		DRM_DEBUG_DRIVER(
> -			"No need to ioremap when real vram size is 0\n");
> -	else
> -#endif
> -		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
> -				adev->gmc.visible_vram_size);
> -#endif
> +	if (IS_ENABLED(CONFIG_X86_64) && adev->gmc.xgmi.connected_to_cpu) {
> +		void *kaddr = devm_memremap(adev->dev, adev->gmc.aper_base,
> +					    adev->gmc.visible_vram_size,
> +					    MEMREMAP_WB);
> +		if (IS_ERR(kaddr))
> +			return PTR_ERR(kaddr);
> +		adev->mman.aper_base_kaddr = (__force void __iomem *)kaddr;
> +	} else if (IS_ENABLED(CONFIG_64BIT) && !adev->gmc.is_app_apu) {
> +		adev->mman.aper_base_kaddr = devm_ioremap_wc(adev->dev,
> +							     adev->gmc.aper_base,
> +							     adev->gmc.visible_vram_size);
> +		if (!adev->mman.aper_base_kaddr)
> +			return -ENOMEM;
> +	}

Both app_apu and xgmi.connected_to_cpu will be set on specific hardware 
platforms only. For that it doesn't require CONFIG_X86 check.

Thanks,
Lijo>
>   	amdgpu_ttm_init_vram_resv_regions(adev);
>   
> @@ -2247,8 +2247,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   {
> -	int idx;
> -
>   	if (!adev->mman.initialized)
>   		return;
>   
> @@ -2271,14 +2269,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
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

