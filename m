Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B74C00A94
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 08:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BF811201E;
	Mon, 15 Apr 2024 08:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ealxVQk/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA1111201E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 08:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvtQ5qRia579GliYsBtYViiA3WTHSC0u0BpnmxyacYceuY/FSO4DVCbxdqGAEfbXWPOwuHOHG9q4BQfTMl6vjJ/AA0VU8CC1BxwpBiQdue5K0gx3BeEp+EzPCR0jRGRGNEbM8Hf+svuBwX1Bvab2MlA3zu7lPVW0gRDYbjFd3IgalZ860KgPF9heDdLqp3NArAdExugkHVwc+hLfuvsmS4GcPJ0y2uEEHBp6+EATilWpuH/AWT3SD7Kbgxc8oS16w3KYPNZbpbGQtR3dWAF9tmM22cc2bSUH/mlTjp6taNsYD/YF8qUcyTqW2+38U8wKqYpr4Z2ptxkAdEeD5EqsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YQk03lD6nuiCnriCbfrRmnSdF4hXINVsyGuijrIwNI=;
 b=XJcTPQhpCKClb903jO9QNER06xson9EuHRJMav7/y19fllMRrKTv0H1Ry2p9fFQ78CzQ/s2c7YBQp8qHAvfCrcofoofGpln9pocEXv860c/EmixsWF34tdwVZgXpM7hByHzgfcj3FSPvvogjUzcTFhWcpcQR6N3/0UjhfCj+JOeTm6UOQNLQWYODpMuC/Do5i8dYYDNtwHPI80nL5mqMP+iNTa258F06yWJCX3NFI5RFUFexs77cyy0maFSqvLwi/pNKTc2C/uj5/cezXY1tWUMXjTtRibk8CYXr6s0lF3gCEMvA5flSjMQIDLxq7xWLzRKyKktssRms5+pb9tvFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YQk03lD6nuiCnriCbfrRmnSdF4hXINVsyGuijrIwNI=;
 b=ealxVQk/QJQWxKnTXPn0PLkM2BGU4P9cyH1941WkzarMb3RD57CGJ5azdSXC/YTbsi0B25uclEwVE8AUZRNcW4Xt5XwulH7oJ6r1pExp2WNpS2VO2oHfEohTefYeyZ00wDYkDqvSvBJY4zHReeuGbSQgn6rf4aEEgNmcGhe1ExY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.43; Mon, 15 Apr 2024 08:56:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:56:43 +0000
Message-ID: <00caf6ce-e610-42f9-bb75-023982dd4b16@amd.com>
Date: Mon, 15 Apr 2024 14:26:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: refactoring the runtime pm mode detection
 code
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240403025726.3198006-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240403025726.3198006-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6d83e5-4def-4be1-5352-08dc5d29f91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bF3G4M7lLgNRJOJdfPuWcLE+XUmGGqmrK+xAUDtrMgnfQmmKEzJgOk6gH2m1XhoRe15RblUG/L4X5ZVXiDe2TLFeVm0fCrNAcrsSMP+XZQdDW2zUswdX8pkTYcvxlw3old/IyWwKEVC31ahemR9FWxG0cbqeeJ1EliJtu/l2ECIqH6gBe2RDtan1GTSkslwURuAy68JFoiz6to6X+m2Ll1vK9Tf43o2Z0KIRWHBaWpxZ90Dy/GBMDdrfI3oxYw0ev6LjoFAla+FCqhLnWRoUqFbf9DBEyQyoFLS0n6TpP+i2zAyfztsJkqUzw1jYS6VT+x8EvN2gIXKTfT8fGMxidzVqecbwG795xJem2NH2qBCLLWtJqsJGE6UddAyXMWQ5208uZUMiwdak1w6Cww6VRnWJdpkGclwPHedwD4WAt9QQ7f4h4tCXI4FS5LsnRG8O5w2CqiauNlAwea2VK7/8oW9b1v088YkHV4P3JhvXyGYlYtxo24RqYW0ElHs3DsAwZEd34AtzLYQ6jE1ZOWYD57p00DkeOYmxTXZAOyZ6lYepjlwcUr8T6xDw4075JmeQZ+Z2K64SwVzioImcwPi2DnOtLlXsJdcnVw7HIbUbmDPNLSQgzUjiParvtDKYsj4FNKUm+3RwxD6jgU3ZfzVzdaUDCBMPmgFI4LOFsestpEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRtdnczeVFzVTVFKzhDQ0IvOWZjeTB1WFhudlJXOFdSR29RMzh6U3JoWTQv?=
 =?utf-8?B?bmtKcTEweDJ3NDNFN0tEbjhmcmJqdVRLRUVxdEZvY1c5Sm5EbEpGeG16WFJT?=
 =?utf-8?B?VHgyVEp1Z3MxdTA5VkhYeE50YkFIQ1ZQekZjaGN2UktIL2U1S1plTnI3QnYz?=
 =?utf-8?B?YnU1akpvOXdldUF2dUxrOUJDTUE5aXFXK1p0d3lWbUVtdWpPbm9UZHlOaVNI?=
 =?utf-8?B?aHNTWDg3bXh0bTdaV2puUTlWbG9wTTh6SXorRTNEanAwMEwyWDdMN1Mzeklv?=
 =?utf-8?B?SW1UZ2xBcW1GeEE2Tjc3YTFsK2NRVWpkb3dFSjhOc3dkbEVPK0I2NDBJRjJH?=
 =?utf-8?B?R28rS0JjVVltZlhaODR1VlNNN3kya1JPWmVDaURmY1YvTllLdHlEYWxLaWEz?=
 =?utf-8?B?empRWHJldG5Sbk84cU5USW9JTGtMUnJHYXRhV3VyVHhuTW4zWHdFU2RMaGhE?=
 =?utf-8?B?Z1M1ZlZzYkxhWWp2K1FhdEZQSElhd0puNnBSZGl0QmtCZEZUa1F5UFNzVFFl?=
 =?utf-8?B?M1BZSmF4azArTlQ3Z28yZlVBR2hLc0tiWlc4QXNra1NzbjMxNDhBeGxYa1BH?=
 =?utf-8?B?SDdPY0FOVHNWbkQ0R1B6Y1BZMTV3NWMrZjZzZDB6WDYzUkZBWWtCTmRxL3p0?=
 =?utf-8?B?WlFBL0hWMmlra1JlWlcxSk04YktXZzdYcmJCY3dja3R3aWtnT3NUeXNPa1NX?=
 =?utf-8?B?WEVKcGZRNUxKeGZOWlRsbDhpYUNMVmI3WXNIUVlMSWNFd1BDZTFqeEZCUnBn?=
 =?utf-8?B?MHlpL2ZhdTdWUnB2SlVSLzYvMnExTlVIZW5lMjk5SlY1ck9iYnluaW9aY2V5?=
 =?utf-8?B?Z1czUU5Eb3NDS0NXZmxmaE9ZLzNpUDY3U1NOeGRDNUF2bzliOTM1S0kzNTJn?=
 =?utf-8?B?cE1TWFRMNWpiYnhpUG5OMUw4bzZ0T0pRVU1wbng4eXA5Q293UnZrYTJ6dGtU?=
 =?utf-8?B?dnRURVRmL1hNdkVNbW1LWmR2K25wQTl1cWxvT0RteU1IZm5ybkpTUHNCY21Y?=
 =?utf-8?B?YmlXZ3A2Qk1YT2RCcnRQdTYzS1gwcUN2MUwvM3BMMmZVM0tSYlBhdjgrNlNB?=
 =?utf-8?B?REFOWXh4RXZaeUxzRzFLUCt3QnExY1pPREZJUzBZaUpVcjdmUDRaTWltUmFS?=
 =?utf-8?B?Q1RlNmpHOFRUSWxKUzRZd2ljenVSRHBuSDhHNlFRTS85VXg5bkZxNjFkcHZY?=
 =?utf-8?B?cmlQY3dHOUp3K2c1eU9mZGFLR0hSdElmeElURm1OcGRkRmR2R21XWld0L0VX?=
 =?utf-8?B?RWVwbjRzNkp6dTRUSkY1NGcxT0JQVHhWb1d6ak5jZTVPT2ZrcWlhUTNtRGlI?=
 =?utf-8?B?ZlJ6VWJBSFZUdjh0dkJKU1g4RU1PUjdPOSttc29VV1grK0tETHNZbldFRHVu?=
 =?utf-8?B?dzNSd1k4c1dzU3I0SDh4MnUzWlYydDUzcDNYTnhMSy9TeXdMNDY4QmYreUpR?=
 =?utf-8?B?KzZjZ29RSUU0clFWb0ZKc1cxVEdPUSs2NzZGaHcvRVlhUEtZNmljZlhGdGFG?=
 =?utf-8?B?S3hYQVgrVXo3MTFVZHVKN0ZNVm1CT0NoSkVQT0JpdVdEd3hSWmFmcWNWcVhH?=
 =?utf-8?B?L1NLSWc4M1dnMDNCdzVYVGlzcDBJSjBId1JqUmpqWndxVjZucnNBekxxTFdL?=
 =?utf-8?B?WVI0alBnZ0dIUjVJRGlBOThOcitVSlhoVWY5QzFuejVwbXM4M2pUbS9KYUxm?=
 =?utf-8?B?V2xTbWJ5T25OZ2o2YjNzc3R4cTlKNzhGMnlHZWxGRzI4WWRZQUhsU0ZXMjlG?=
 =?utf-8?B?Z2QxWlVpVkUxb2NuYktDbG5na3RXUUNZZFVxNjBYb1pXaTZBVzhGOFh4aG9n?=
 =?utf-8?B?LytUbWt6V2J0Z0lUTUdNK1Fkdjc4aFpXQ09OZXRqeHN1Wk9aSW5VdlJXd0k2?=
 =?utf-8?B?bitIbXJJTkdOK0hoa3JEbTAxTEtGd0hrRDJoVWppbFhYQjlTbi9DaVFkWWw5?=
 =?utf-8?B?eGxLNGtZUlRvWFk2Mnk4WmFoaVN4a2hZeDRwSmhRak1SdWVJWXhabWZRSitP?=
 =?utf-8?B?aVY2U2ZBUXRWMVkyVFpNdmlKeHRVM2FrSUZ0SVpESjNhSFhkNmFhb21kTmlo?=
 =?utf-8?B?MjhaOWUycVU0ekQ0M3h2N084bkVydzRhUDVFWUEwNmVKeXhucHJIL3AwR1BS?=
 =?utf-8?Q?ymlVjRYYj+T7xvTQuY+2yts8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6d83e5-4def-4be1-5352-08dc5d29f91f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:56:43.8105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATDL7rA35VDkfnML965v8Ny7u31ZzjYvs8FM57LWe/scDedAgvyJ7WLfsEUQQ/s4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
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



On 4/3/2024 8:27 AM, Ma Jun wrote:
> refactor the code of runtime pm mode detection to support
> amdgpu_runtime_pm =2 and 1 two cases
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v1->v2:
> - Fix logic and output info (Lijo)
> - Fix code style (Kevin)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 75 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 48 +-------------
>  3 files changed, 77 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 65c17c59c152..e0d7f4ee7e16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1409,6 +1409,7 @@ bool amdgpu_device_supports_px(struct drm_device *dev);
>  bool amdgpu_device_supports_boco(struct drm_device *dev);
>  bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
>  int amdgpu_device_supports_baco(struct drm_device *dev);
> +void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  				      struct amdgpu_device *peer_adev);
>  int amdgpu_device_baco_enter(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f830024cffca..2ea1f47df79c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -350,6 +350,81 @@ int amdgpu_device_supports_baco(struct drm_device *dev)
>  	return amdgpu_asic_supports_baco(adev);
>  }
>  
> +void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev;
> +	int bamaco_support;
> +
> +	dev = adev_to_drm(adev);
> +
> +	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> +	bamaco_support = amdgpu_device_supports_baco(dev);
> +
> +	switch (amdgpu_runtime_pm) {
> +	case 2:
> +		if (bamaco_support & MACO_SUPPORT) {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +			dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
> +		} else if (bamaco_support == BACO_SUPPORT) {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			dev_info(adev->dev, "Requested mode BAMACO not available,fallback to use BACO\n");
> +		}
> +		break;
> +	case 1:
> +		if (bamaco_support & BACO_SUPPORT) {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> +		}
> +		break;
> +	case -1:
> +	case -2:
> +		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> +			dev_info(adev->dev, "Using ATPX for runtime pm\n");
> +		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> +			dev_info(adev->dev, "Using BOCO for runtime pm\n");
> +		} else {
> +			if (!bamaco_support)
> +				goto no_runtime_pm;
> +
> +			switch (adev->asic_type) {
> +			case CHIP_VEGA20:
> +			case CHIP_ARCTURUS:
> +				/* BACO are not supported on vega20 and arctrus */
> +				break;
> +			case CHIP_VEGA10:
> +				/* enable BACO as runpm mode if noretry=0 */
> +				if (!adev->gmc.noretry)
> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +				break;
> +			default:
> +				/* enable BACO as runpm mode on CI+ */
> +				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +				break;
> +			}
> +
> +			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> +				if (bamaco_support & MACO_SUPPORT) {
> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
> +				} else {
> +					dev_info(adev->dev, "Using BACO for runtime pm\n");
> +				}
> +			}
> +		}
> +		break;
> +	case 0:
> +		dev_info(adev->dev, "runtime pm is manually disabled\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +no_runtime_pm:
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
> +		dev_info(adev->dev, "Runtime PM not available\n");
> +}
>  /**
>   * amdgpu_device_supports_smart_shift - Is the device dGPU with
>   * smart shift support
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 5d1b084eb631..924baf58e322 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -133,7 +133,6 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>  int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  {
>  	struct drm_device *dev;
> -	int bamaco_support = 0;
>  	int r, acpi_status;
>  
>  	dev = adev_to_drm(adev);
> @@ -150,52 +149,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  		goto out;
>  	}
>  
> -	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> -	if (amdgpu_device_supports_px(dev) &&
> -	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> -		dev_info(adev->dev, "Using ATPX for runtime pm\n");
> -	} else if (amdgpu_device_supports_boco(dev) &&
> -		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> -		dev_info(adev->dev, "Using BOCO for runtime pm\n");
> -	} else if (amdgpu_runtime_pm != 0) {
> -		bamaco_support = amdgpu_device_supports_baco(dev);
> -
> -		if (!bamaco_support)
> -			goto no_runtime_pm;
> -
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
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		default:
> -			/* enable BACO as runpm mode on CI+ */
> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		}
> -
> -		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> -			if (bamaco_support & MACO_SUPPORT) {
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> -				dev_info(adev->dev, "Using BAMACO for runtime pm\n");
> -			} else {
> -				dev_info(adev->dev, "Using BACO for runtime pm\n");
> -			}
> -		}
> -	}
> -
> -no_runtime_pm:
> -	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
> -		dev_info(adev->dev, "NO pm mode for runtime pm\n");
> +	amdgpu_device_detect_runtime_pm_mode(adev);
>  
>  	/* Call ACPI methods: require modeset init
>  	 * but failure is not fatal
