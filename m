Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7EEC6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 04:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4058910F8FA;
	Tue,  2 Apr 2024 04:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/OzqYgb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2133.outbound.protection.outlook.com [40.107.94.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3995010F8FA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 04:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgKcwNJrnwprkmBHSIR/YUhcpiNsN3Pi9G9VW1/6ceCyiRoSKvGVchHX5MbVes9aTjYPzrWUXVo+jjg0sEc8edxIdX1YdaPYhkGNt/ZOI27arNKRiui71neExWbgr81e9T1JEbbO+v60QCJarMKJMk8C+IlUe6y6yotytFYwHnuAu2dwzqJ2sLjSWJQASPXyoZWdrgA1U7HHsI4OAkhxvddcWYsIrE+Rz8yJJa/8/wBx0GzeNF6C6/ojZIV180YHrlSqKr80TB5OtcqhU2mGd6NcfZM2G8X2K+lh7Zdw0QdEIOuEauqcaSi0h985NoEUUdXL6PLhKYA5cljW8E2PGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjJaJjWPgovN8Js+lxP66pwebBjVN/jxpdQLaqErR5g=;
 b=atSmkSaNDMmZZ24vAyGhuS8DWQ0a3V+mt4IbFz/KjI5KbfiyeKCjShEC6nPobNo4wd608BET8W8SUUhxp1PIxg++oncyz99bQzDbrkMZ3rYTwT//o6mpyj8agAQha75c0fpnyJZBXcSQLg4JCzkStRFJ35n1xodBWTDqAe3TiQ7ygpT/605M/SSfsZfGSzdjAUqo4yxYo10HJ0B2svUuAtv6OW2mwvq5A6IAc0k18s4BnoSrHeHuZOBO0EHeRhxHu8elq37cBt+3joqbk4IUALdD/W96S3xbFyqdIxiC0GZ78dIwFAgbPlU8MZNX7eAkqcdqWdL3fCcd3/xo6EpwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjJaJjWPgovN8Js+lxP66pwebBjVN/jxpdQLaqErR5g=;
 b=g/OzqYgb369bHPUI0MPeJG8Ki7+0coH5NaAyTeTrBGxjH+HOJGXZ1QJy1YB/3N714ecQNZWd1bt56gmi2/EByP1rcGVRujYx5QHi2dl8FvT8XqupMhkpICSyKsVi5gPPFLSLT0bCnUKBcw6oDT+/UNYObew7T4JQ8oET3PmjMkQ=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 04:16:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 04:16:29 +0000
Message-ID: <c59ab813-a630-4c25-ac63-5edca838873b@amd.com>
Date: Tue, 2 Apr 2024 09:46:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: refactoring the runtime pm mode detection code
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240329082857.3082844-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240329082857.3082844-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5977:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbtPTYhcr92JeIrElQzqwsQf0VmqcNhhOz5gx3mQKenYeyDO4x9JEXMA47WAjmIZMCDNtyZwgbK7pUrAxG02/3vqgCwTVmc6i1Fg2yidOW/0talnMygAQLktnHyT8EsfX/UdR4Zx80aAWGLxB+HWT9rPSA+CN6sk3kgmPS4FEkazlsr1ejosytvJPk07PE8WbykdC313QVOxmD+sqKmawToVbQzPKD61UizSF9+SFzauJkez5SRSKV06p7kbLsE0BXfXRl+aigmwU/ddkOmjGLsOBwCh6SWDOQOtw+nXj/GF2mVus2fduIFD+Ee1wVpxwxdW1/h+tPCmr8pjGoxRKTKkgXVW3GaI1fRZI+CNirIKmnAjAdaYd/BuGSJw0JJilckKQcbNNwF5tv1W97J/JbDmwKeYxXEW5Mx/vxVLMLXIBdRqgWJKArgoFYTivXMKFu24EHcgLqyByS7L9kO3EdiJ3Y1t4ueF/05gsrwabDm6UnM4exs8T8+JwOraJxYwqAWJ0Gh8zsgRyW5g9Z05VLRE8Z3qJK+6ylQQhTOsXlw6UKkpg+ojKE3CSRFvgrV4AGUKc9R3c2fflD7uT15VhmfWtw9LrQQIeqhMcrdfhr1PiPGEAcA14TkaunJukSnqrsEIo0NwBXujWs9yIloml1NEWc8ZKzY8ZCNgkApUKGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWIrWXFpcEFqem9uWGF5Snh0dFcrV25uRW9yQXdCUjJoMk9zL0svUU9XM1VV?=
 =?utf-8?B?aWt0UUMzMGpmU0MxYTlwazNnSzVZRUNnZlpiUUhHVDE3ejNyZmJPRHF2OTJm?=
 =?utf-8?B?SW9Kenp2SmVhcFJxYnk2bzRoZDlkdkc2OHNxR1VBZGJoWi8wbEhsSDlZVVVU?=
 =?utf-8?B?YTdOZFhRVTRmRkEzdnpJNXE2WmN1NUx3SGg2M2x3WFJGRVFjMEgrell0Tnd6?=
 =?utf-8?B?Ti84MmhMbGhqSUZRa2ZING15OXNZRUp0UG82UEFUR2t3NmtFNXFnbUt1RGds?=
 =?utf-8?B?UUl2REFVZnM1cEVsd2Zyc3JXMzdvdlM0K0tTZjdjaVo5SEtnQmJURXVJYzBx?=
 =?utf-8?B?Q1Jhc3VXOEN4bHJpcTZBVUJpMElBYmFKa2JaYjdUcnV6dnVCVVpoTnRnOTlT?=
 =?utf-8?B?SW0rdkswYTZ5QlpvMVQvaFppZ0x5dTR3VVc4SUJ4ZHhMR04vN3Jja3Z6L3JJ?=
 =?utf-8?B?TzJNNk9nWU5mMnhSOHJqeFpLa2VHUXhpMFB1NXNZTURPSnVBbnZxTjNYSkhD?=
 =?utf-8?B?c2NORHhmSGJBRzBvaDQ4bTRYelp5ZUpLVFZJd0QxVlVEeUVpcmJqZGZ2RTNh?=
 =?utf-8?B?a2ZqaExRRVU1QXFWUy92d1luYmJtZzFKZEp6YUxzSWo1TXpQcHIrTkdSbk9Y?=
 =?utf-8?B?SUhJd3VuV055RWJiOXNub3BOdVB5akhLd1lVUlRydGlQZHl3VEJFTXAwaU0z?=
 =?utf-8?B?cU4wdk81VkQ0TnR5dUVqaWlNUzdOUlR3SW9kbnl1SnFyK0N0UHczZmU4YlNy?=
 =?utf-8?B?cXl2OXIzdVJYQTFPNmtBMVQxSEg3NldxbHJGRU0zQjFLbzBNWlVnbkdOTnN0?=
 =?utf-8?B?Y1pBaVNGRlZ5ZFc2MUpTKzVDM3lRKzVNbTM4OERIQkFTUnYwU1FxQzFMYnE3?=
 =?utf-8?B?TEREUElsMkRqNDh4SmVSd0pYdms4Y1dlcWx3aDhiSzJqdTJKM2tUbmR0b05V?=
 =?utf-8?B?OTFOMkdXYzRGMG9VTjE5V3QyaUNUVVZocldhRDhWUHM0OVJoeFJIczlvVHF1?=
 =?utf-8?B?ZHp5L0ZjRGdLTTViTHJacW9LSCtseDdqTGp3bVlDamx4d2daOFNwSFZqTFJG?=
 =?utf-8?B?WWpCWlFMUmdkWEdhZ1g0SExIR0taaVdrWEhQVDQyaTJYODNsTWtYbnN5Vkt2?=
 =?utf-8?B?NFF1TGxnc2t0MjFDY1NzdnVHYlpySkNxQllXQi9nSm9rT0dZY2Jqa0hIYldk?=
 =?utf-8?B?cHlDamFqTTI0bUtLNnpTYnlOTThkQS9jSCtQZEE4OEszTWQ4L2JBajZBQXNB?=
 =?utf-8?B?TGwxWU9Ub0JCT2FuY1RFY2NNb2E3WXE5N0czd0s3eXlseHUwU2w3K0dEeUwy?=
 =?utf-8?B?VURVZTU1cnoya0N5MHY5WWFRNVVxT2czYVZQRm90Rm42S3dTbkwwTDdrVU9L?=
 =?utf-8?B?a28yRlNlVG9Kdi9kNDd3bmdjU0I4UnNqR1JxelJPNlM1eGZ2NlFlSnkyeFJX?=
 =?utf-8?B?cWs4NDlYeWQ4Uk0vN0dNNlloM0ljQWU2TU9TcHVUN0NkM1Z2TFhWMElCN2FX?=
 =?utf-8?B?dk95cTlXanBDNVU4UWtUb2hiMzJWK05CaDAvekRRcHVsUnZoQURYR1JqcDlz?=
 =?utf-8?B?Smp4cTdFa3pYOGtFNGlEV1V3MDNTbnFwb2t0eEtUKy93SCtvdGNENU1DREhP?=
 =?utf-8?B?V3U2dTlYckdZV3dvajdhYm1jSG9PdDBDYi9CeFZtRFJTYmExTHpySGs0YUZI?=
 =?utf-8?B?M04vVkdKK0VVWGFyVkgzWk1kWllSY3NqS0owV3BGTFJTdktLV1ZCcXZQVFdl?=
 =?utf-8?B?UmdvRXZTRHAvc0ZDNTI4U05DZTNSVDhTLy9rNzRtcE9CT0JUK0pKdTA5dVgx?=
 =?utf-8?B?NkNZV0NyN3lNS1ZKZ05CbzFDTWJQZ2w4MkZ1SE5rRFdvbVUyNnA0UHk2KzFk?=
 =?utf-8?B?aXI4a0Vkd3Jxc3llT0dCSWJLdGk5elEvaHJkSDNXUFJoQ3NicmxIcmxRR3B0?=
 =?utf-8?B?TXNMMkNHdmJBY3lzeDhsa3dzQ3FCVmZjRzZLeUtnRmxaNENGTzFIUU5sOHkz?=
 =?utf-8?B?ZTlqZWVPR0QvRlB4NUxEY0FvRk1IOWlJS1d5czVvY053Tk8rZzVheHk0TlBE?=
 =?utf-8?B?WWhiWEpOUUE0TzBqM1FuZTNsTlhQckJpY1VOeUVmOFZpTlhsOTY3aEdEUWtR?=
 =?utf-8?Q?0lEkx9zPRNXYiuKhoNgfcmMxh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3491bcb-6908-488e-6904-08dc52cbabcb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 04:16:29.8212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQMa/M4Nl6fn2ca8xWDkdxdZmF7XfSonBMo6SG1eFUkLSx2wJpKQMiTVyaSm5OnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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



On 3/29/2024 1:58 PM, Ma Jun wrote:
> refactor the code of runtime pm mode detection to support
> amdgpu_runtime_pm =2 and 1 two cases
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 68 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 48 +--------------
>  3 files changed, 70 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3723235f5818..4358d8c630b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1408,6 +1408,7 @@ bool amdgpu_device_supports_px(struct drm_device *dev);
>  bool amdgpu_device_supports_boco(struct drm_device *dev);
>  bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
>  int amdgpu_device_supports_baco(struct drm_device *dev);
> +void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  				      struct amdgpu_device *peer_adev);
>  int amdgpu_device_baco_enter(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 410f878462bc..ca117f2666bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -350,6 +350,74 @@ int amdgpu_device_supports_baco(struct drm_device *dev)
>  	return amdgpu_asic_supports_baco(adev);
>  }
>  
> +void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev;
> +	int bamaco_support = 0;

This initialization is not required.
> +
> +	dev = adev_to_drm(adev);
> +
> +	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> +	bamaco_support = amdgpu_device_supports_baco(dev);
> +
> +	if (amdgpu_runtime_pm == 2) {
> +		if (bamaco_support == (BACO_SUPPORT | MACO_SUPPORT)) {

Better to check only if MACO is supported as that's the user preference.

> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +			dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
> +		} else if (bamaco_support == BACO_SUPPORT) {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			dev_info(adev->dev, "Forcing BACO for runtime pm\n");

Maybe change this so that user doesn't get confused - "Requested mode
BAMACO not available, fallback to use BACO"

> +		}
> +	} else if (amdgpu_runtime_pm == 1) {
> +		if (bamaco_support == BACO_SUPPORT) {

Use & instead of ==. This could also mean SOC supports both MACO and
BACO, but user prefers BACO for runpm.

> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> +		}
> +	} else if (amdgpu_runtime_pm == -1 || amdgpu_runtime_pm == -2) {
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
> +
> +	} else {
> +		dev_info(adev->dev, "runtime pm is manually disabled\n");
> +	}
> +
> +no_runtime_pm:
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
> +		dev_info(adev->dev, "NO pm mode for runtime pm\n");

Maybe put this differently - "Runtime PM not available"

Thanks,
Lijo

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
