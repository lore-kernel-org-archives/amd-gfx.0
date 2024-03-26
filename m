Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758B8C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 09:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEF110E40E;
	Tue, 26 Mar 2024 09:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwPdHf+f";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2102.outbound.protection.outlook.com [40.107.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0B510E40E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 09:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4SKoPWderCBQpuSbRcbJUQ1nRG3Jp5F3aeBOnE6x2jN9FB9VSO8S/K5oGiK5RW47mGvNUCK3ojGwBBcR4DZbUGOZoXqeTIy2GWzO3qbq9ZN6GrrxLlQPCxb30+96/oRRigaJMbEJJgXmPH+x/f5fzXvKWKFTja2NYmLqJ+McyWE6Lm/aLG53rri/NWj4o9VPg2XLu+2pA0yfPosq8vXE63TY2B1lRnwmfl5+Rys8ZUerAmvIklG1JiUGuOs59WzC1+5CHZ8NA4/CC1sVcXbJHKm4ZoPHoWufpn7Ue+fCo7jA/i/7t5kQHMtfJKn8mUf1vf3X3oqY3fikVFzUi8wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhJyr4DeDXOPTBx/lZ7ylegElpZWGZ2RKm82KdVsuUQ=;
 b=ia+YggsbBRaoUfJSSvPqTWwZbLN08Gtlzy+LIzrUusT7JN0TINcDe9TctA2qC5gk0uVlCDWd/l26SVoZJ70mZqPAt3UvtnL/1+V7wtjhCDHPFguCvjzcYwebF8OYuVorJCffV6Nxv0fGZ0nU3ML7t7SHiFW5sHPbPBA5ML3F46UrCCgcGaEoPAAadD2sCd+nZ1/zmgaXXlozVvzAXUWJnIad+zaCkY+myKObwNQhMd2yHcraONP2ZHYcx/CRMp4nnEP9R87IbosQYopjAP1hPBmj5odNljyphGeoAgu8kyAoLQSxt8OhJCWOu9o3mtGMXOzKFGumWsYYsalFf066/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhJyr4DeDXOPTBx/lZ7ylegElpZWGZ2RKm82KdVsuUQ=;
 b=zwPdHf+fuqIaSk5TIBnhsUEu3SD3PDGrMlgLQMEhJtk17w6cTG0KEMFSqyb3XNIbFmSObbmR8DQAuUG+9XHCDJgztENX9As529y3HZXSCjly+71AZKAMs290joLYBH8bJ879Jy1rYfgpwoCl4OLzskeRXs8cVah5eilsT2U8lx0=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 09:29:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 09:29:13 +0000
Message-ID: <2456ff9c-8e83-4b16-98bb-fb2f366dbd73@amd.com>
Date: Tue, 26 Mar 2024 14:59:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: Add support for BAMACO mode checking
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
 <20240325101559.2807629-4-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240325101559.2807629-4-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4291:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9236uJ+qUQGllzbDPVm/9QbcrHp8kFoormvWDRw2ymn+zY+Y2yW9uA3gYtQzAvfiXYDto/yLdgncKgTfX3hYR2gqjXIN9kAsWfQ7wQNQqfSfWqfsReStq3dy+5BZ0feU9QQYOePwqnQYJzC4zmW1wMTyWMkRIqbGP2fNP82TP5NeT4e73pBKg8q3u3T4h3AinReoCrb1RokIz+QcLNnkR8orulveY0cm2P5i628UdVR5MsmlcnhBvhdOXgD7oVUiEDqPgeUcJiHKzcVyRRvv690o5NOrgu3UU0lodAOXoTP/7Vd4TunX3v8acW2Sp+uh3Nc9JDUcKaJ2mHHHN529npQyteIx9KMkU28epJR3kyEMDkSMb60FZSyd+rKQ8yVhQovCRwBOwiJErkR9CpuQEr9/vxoy5P7QIIVjnuUxdBMaPoaA7jur8u73wiedf1d8eUKtfXdIaBARjVsGMjUpbOEbQVuJRwIw73ulxgJrcxDy0qmS6Ek/v5AigGH8JT/OYn97mC4dO6q0k4N055F++pY4xWtrFmYBiVQoUR17BS9A0V6d2FXkjO+2EkeFjTCT2EQ3g2Op8/KLhAHZlc4W3VcHkktNLhZo+930DR5AIgkTgmL2Id4WJ4Lz9ejNRe8BfiEIreiDJrprqq/sy0DYmx1ERzI/u0Kdt8g3aTO/xXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxFRW45andvR21rVjFqUW9idzlBaXlqL1d4YkxnV3VQUy83NjBiTFQ4cHJG?=
 =?utf-8?B?NDgxT3hkdnpWdWFIQnhHckRTSzVEQlcxalNQUFdqYU5jcHhTdEMraGlmVzF0?=
 =?utf-8?B?eDY0VTFrWXVhMHhGV2trREZtczNGcnowSHBXMXFGUDg3NzdrYkJCUy9MSmRE?=
 =?utf-8?B?UDIyeGVlL0ttbEhpekJJV3RyMDRUWDA4dUQ1SXFXcldmTjlXQkZJVkZ0WTNI?=
 =?utf-8?B?WDNuQTEvMnBESTk4WmVLNUZaUzBxVGJURjI1YnZkVGZhcUg5N0t1VXpJa0E4?=
 =?utf-8?B?RVA2VnhjaENCcFNoZTI1TTJxcjJxL015cXZPaWxITWNZWGlmTU5Jb1p3eXgw?=
 =?utf-8?B?M2JXZE1tR3RpbUY2SE5GQXNjQkhpRU1ITHZlSHdmV1B2RHhaQzBBLzZJdnVx?=
 =?utf-8?B?VVhCdTJRODVIbDJoQkRBN2s4RjZMRENkazA3L21XQzlkTUZPVHVXc3NWSmhD?=
 =?utf-8?B?bGpaaUlMVWJwRnFNZkJVNFpkclZmekdzL0ZYZTFKQU9UMmVqVFE3VThtcThk?=
 =?utf-8?B?b0x2RkE3Z1FlSDBzNEtabWVsbml3d3FMVHFUN2xKaURJR0pidlkzL01IQzA0?=
 =?utf-8?B?azRlZ1BQdHVGYXplMzFCRGd3NXBMRFdZS2tRMEJhcnRkS05ZNXoxbENFWndN?=
 =?utf-8?B?REJQWmFicTVUdExFeUdSQkhPamFwbVV3RS9OdUZRSDh4MGFWRGhPdllENHdk?=
 =?utf-8?B?eitUZWZTTFVOZmhEVkVXMUdnUFZtMEpzbVQ2MWUwU2loUVV5cDlWK0EyUU1E?=
 =?utf-8?B?aTIxMmRXRXR1SEYxRXk4TzUvRE5aa0dVak9GSHJVQlF5RGlCYmpLcXZqUFN3?=
 =?utf-8?B?YUV2SWd5Y1V3eXE3a1VvOURKMkFnWHJ2TCs1Q3VHUFZvVWZWaUdUc1p4eVdp?=
 =?utf-8?B?R005Wmg0a3RmcmtsdGFpT25leTlDZnNuSGpSQzBFVFlNUVlwTDF0T0lTUWll?=
 =?utf-8?B?WXR0S2l3d0QrSTZod2dyWjQvSW1aRldPZEs0anhTbkVkL1hPckpmdWNGeTlQ?=
 =?utf-8?B?aWd1dzAxNkJWWHk0SGVWbzh5cHRMNnpDN2p5a0MzSXd5aHpkbTJ0dENyU3ls?=
 =?utf-8?B?dzd0cEZucWpUZjJDZGpsZTdsSVlVa0FPWXJTRmNieHVodjEzNUZ3NmpzSk9h?=
 =?utf-8?B?UkdwdVplOG9HZ2RWUHNrQk82QS9JdU1CNXFoNzg1cE1uU1hiOUlXYzlyOUxY?=
 =?utf-8?B?MWcyTktuYVAvL1R3YTRoaW5OeVNqZTlmMXRkME0rTjdFRHZCTERqOFFVMHJp?=
 =?utf-8?B?NzJGeC83SWZiYWIzUjZLekV0WWtna002L3R1aEx6NWxhYkNIcTR5YUwwK1Ju?=
 =?utf-8?B?eWNnbVozaFUvUnN1Q3NlNGZJb1VkUWVKYW5MUnRldUFZNXZLWTNmT0V3dlhW?=
 =?utf-8?B?cDlrbXhpYlFKMEtOME5ycDNpYU1ybHR1bDRhTVZrZHkzcUMrY24zNjMrMDE4?=
 =?utf-8?B?N2N1L2dIUnR0Z013dkJLc2ltY3gwNU5WLzZCMldROWR4N3VtV2V0OHJwRXlR?=
 =?utf-8?B?WXcza3ozNFJYL0hwTCtaUjY5MmpwUFVmSUNOeTN0c2RSaThaL2dTclJNUHZ0?=
 =?utf-8?B?K3FueXUvaFlobWhXSFArcnZWWFNoT3A3WkZKY3lRS0hLMXl1Smg1SnR0T0Nr?=
 =?utf-8?B?WjFjWkR0bHJpdjlGa0xOazd0NVZRUjBYVlNHT296MWxyeG5zeGY0Q2RoaGFY?=
 =?utf-8?B?N080UnY1ZlR3S3MzQWN3Wm5WM0JONzgvdkJ3Y2JNd0oycHNYQXJEcmxyMGFD?=
 =?utf-8?B?UDVlYTdNN1ZpQjZDYXk0VVpiWlk3S2puM21YS1J3eW92Tld6L2pTZzFuODlZ?=
 =?utf-8?B?R2w1Vlc2UEF5M29jZXY0ZERlMHZhYmlGVzZoSjZLZXAzd3ZNdGUrM2RNMmU5?=
 =?utf-8?B?aU40N2UycmhDWlBmOFprLzFwZW5KQXI5N2pDalNibVNCKzFsMHBTelIzVWkz?=
 =?utf-8?B?V1Q3ZCtuQkt3bTBPNUV4Rmp4WDc1OC9kUEkxVXZtWmpEeWNiN0pXRHJrU2Ra?=
 =?utf-8?B?MmVRTW9HZnpQUzdyWDI4dlRUcUNDSk4yQ3MxQlpWWExneWt2UlgzQU5VV05P?=
 =?utf-8?B?SU5Ga3JFUExwTGl5amNPdjNLOEl2c0NYQUttcmt3NmZaUzBnTy8rME5KUVh6?=
 =?utf-8?Q?J/YC9MzOsikdv8gGDpP1GaoC1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e71b55-7166-452a-6fa0-08dc4d773320
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:29:13.7555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6KLKDP+B66+ysMv12LGxsVrRZ6+FiemHhQ1yJYLiprULh1kyRL0Pom0JkCX7B0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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



On 3/25/2024 3:45 PM, Ma Jun wrote:
> Optimize the code to add support for BAMACO mode checking
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 74 +++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 +-
>  3 files changed, 50 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 80b9642f2bc4..e267ac032a1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2734,7 +2734,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>  		/* nothing to do */
> -	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> +	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {

This kind of checking doesn't work well if we have to add new RPM modes.
Instead use || or a wrapper.

Thanks,
Lijo

>  		amdgpu_device_baco_enter(drm_dev);
>  	}
>  
> @@ -2774,7 +2774,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>  		 * PCI core handles it for _PR3.
>  		 */
>  		pci_set_master(pdev);
> -	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> +	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {
>  		amdgpu_device_baco_exit(drm_dev);
>  	}
>  	ret = amdgpu_device_resume(drm_dev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a66d47865e3b..81bb0a2c8227 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -133,6 +133,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>  int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  {
>  	struct drm_device *dev;
> +	int bamaco_support = 0;
>  	int r, acpi_status;
>  
>  	dev = adev_to_drm(adev);
> @@ -150,38 +151,55 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  	}
>  
>  	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> -	if (amdgpu_device_supports_px(dev) &&
> -	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> -		dev_info(adev->dev, "Using ATPX for runtime pm\n");
> -	} else if (amdgpu_device_supports_boco(dev) &&
> -		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> -		dev_info(adev->dev, "Using BOCO for runtime pm\n");
> -	} else if (amdgpu_device_supports_baco(dev) &&
> -		   (amdgpu_runtime_pm != 0)) {
> -		switch (adev->asic_type) {
> -		case CHIP_VEGA20:
> -		case CHIP_ARCTURUS:
> -			/* enable BACO as runpm mode if runpm=1 */
> -			if (amdgpu_runtime_pm > 0)
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		case CHIP_VEGA10:
> -			/* enable BACO as runpm mode if noretry=0 */
> -			if (!adev->gmc.noretry)
> +	if (amdgpu_runtime_pm == 2) {
> +		adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +		dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
> +	} else if (amdgpu_runtime_pm == 1) {
> +		adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +		dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> +	} else if (amdgpu_runtime_pm != 0) {
> +		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> +			dev_info(adev->dev, "Using ATPX for runtime pm\n");
> +		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> +			dev_info(adev->dev, "Using BOCO for runtime pm\n");
> +		} else {
> +			bamaco_support = amdgpu_device_supports_baco(dev);
> +
> +			if (!bamaco_support)
> +				goto no_runtime_pm;
> +
> +			switch (adev->asic_type) {
> +			case CHIP_VEGA20:
> +			case CHIP_ARCTURUS:
> +				/* vega20 and arcturus don't support runtime pm */
> +				break;
> +			case CHIP_VEGA10:
> +				/* enable BACO as runpm mode if noretry=0 */
> +				if (!adev->gmc.noretry)
> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +				break;
> +			default:
> +				/* enable BACO as runpm mode on CI+ */
>  				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		default:
> -			/* enable BACO as runpm mode on CI+ */
> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> +				break;
> +			}
> +			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> +				if (bamaco_support & MACO_SUPPORT) {
> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
> +				} else {
> +					dev_info(adev->dev, "Using BACO for runtime pm\n");
> +				}
> +			}
>  		}
> -
> -		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
> -			dev_info(adev->dev, "Using BACO for runtime pm\n");
>  	}
>  
> +no_runtime_pm:
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
> +		dev_info(adev->dev, "NO pm mode for runtime pm\n");
> +
>  	/* Call ACPI methods: require modeset init
>  	 * but failure is not fatal
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 94b310fdb719..b4702a7961ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2617,7 +2617,7 @@ static int psp_load_p2s_table(struct psp_context *psp)
>  	struct amdgpu_firmware_info *ucode =
>  		&adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
>  
> -	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
> +	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
>  		return 0;
>  
>  	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
> @@ -2647,7 +2647,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
>  	 * Skip SMU FW reloading in case of using BACO for runpm only,
>  	 * as SMU is always alive.
>  	 */
> -	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
> +	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
>  		return 0;
>  
>  	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
