Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBDBC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 01:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04A610FC01;
	Mon, 15 Apr 2024 01:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CyldAvf5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF92A10FC00
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 01:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoGDMLWdSTXttuMMF0zLsotcsAeS35xbRUTT7dmXY6nLfopAgkLEbknwNb75RnVKJysvYAu/EYuo/FXVPxibBJrfj/CtQZgPoWbxGW0doBBUmTsnBcymqu9wwQdY+sIwjAJQCV1aPn9j9KCSP8ebDqu00dMa/GGkw00DEqWv/Gjbhnxp9lokveb5JO6NhUAkIv7CK3VPCF1xDnoQFOphI5NZzfSmi/R2QnH53Xcw6PemJw69x///9qxjgUO+8Bt8wPvkJjRLGSf+LUlz1B3yKH4zyUAQB2jUXdqR/xrHDY41XxKuvzfstBG9qPmvREYXthn5OUCu01vz9NRemg4yag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7NC4APWE0drtT+1X1r8XBwOfj/I0NZ7dhTLCccJTg4=;
 b=Q81eyssYcBAPeiMKo+B9H3Mk9HHdZuc8Nv04TdzdNhdk6AmuHcrnlvwkGWY+sA0RZigx19Acmt7Hf0v56b2/nLoa0/KHJ/QUI7JJBd0YGi0tR1nZsMRgfgkC4Xw++VS5R15OPap+btEXzB/wCpvyf5zUAPtMaZMxtRmCzdEI+UPvdBRmwB0KUhbFZJKb1WjPqeRDdBT9t9yoEP9KnojRNxiS3XfXiWNCYJKwvrS++zrYp+hQZch9AOi19jqghOOg1xfui4/+TeZ2vo9xpx9avDxMknZSSczo4Yeo50iiwxMSHWPG2s0P9KVEDS92P6LUNxumfNn9G24RC4fKEtDUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7NC4APWE0drtT+1X1r8XBwOfj/I0NZ7dhTLCccJTg4=;
 b=CyldAvf5BBHyf4WH4VtLt6lb6d4TmOJeXfWwvLjvGIz3NIFA9jZxx0tB7dT8Z+SgDF2qt5l8MkkBdA2EVihQH5KHCRuOfAEl7CJ6GHMKR8d4Rl+IRSeDzshJtTKjZUED1/NonvR2tkrENu8Hx1iXOETbLiom+6VrvmCs4IhZoO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 01:48:56 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 01:48:56 +0000
Message-ID: <1f5baec3-1c1f-490b-8b76-2890447ad1eb@amd.com>
Date: Mon, 15 Apr 2024 09:48:49 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com, lijo.lazar@amd.com
Subject: Re: [PATCH v2] drm/amdgpu: refactoring the runtime pm mode detection
 code
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240403025726.3198006-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20240403025726.3198006-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0331.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::10) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 3938e89f-b17e-4c4a-0644-08dc5cee3651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCmPCeJdE2VxGgjwONd2s3Pxh+JtzjH/uGk7y/eAcUWMotJCnACfkfbL/YmLP0RsKRYsnoJSXAZq+VNuGXHkpUys1JENLU95vv1FXwVnvvQDoIx9d1incCYr5oMADiBk/WFrGmeaIFKHtToYGgfdw78Q9W8qg8GzfdyhNuDpcMOD4O0HcCjv8+q4Jd7oZ8Ol1SX2WwDuNCAZx4KeyduCvq/qkyInCKpxYoqsHvZ1EyfRSepl/KgC5TayLEka4D1uvMRo0b0ezX2+va5y2g0ui45L49p32rYr7641ggWLcUlw8gK5+BmCHEozOv1354wu/ioaYAEfOWDbZcHf3GReWdbd7NfZX0qEuH4EKKC9VqSV0mihO9NS5iqsW+p+8hA3rRmI9mHc49rLzXvmKjLsTqMlo7imQZvnFcwMPQPl5TNiCJsolP94AdNQM1LAQJQa2Rth/dc+AMdzKcp02fc9Ckq46s2WcfhHefDiWLQ7MYIOClYMG6Hw5TVRTvIvcPO2a6qqRJMRTMgbFGf1MrynVOREd9ZOiP+jc+Xqzw81ZFx58qWg1aElsfDRTENaw6PXdLpopczEqLJmjeAbqYqA/5/ZwITo1n9DB1BQYOO43HRVSQYZqCkfPoJN4JXvrJQ1dNnX5bbqdOolG53K/FtgtxVB//J8nUqKk1rD6oH1RMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1g5SzNOZ3BKczNwc1dqVWZSYmZ3Y2o2dXhTbmsrdWkrSzVKK2crUGJVQnBO?=
 =?utf-8?B?VTN1blJoS296LzBpQVZSbjlIajViUTcreTM5N2tmM2JRTGwzSCtuZ0daMy96?=
 =?utf-8?B?MkNHU0V3M2hRNW5MaEo2Z2lrem9peXdYSlhNWFoxVVNmUEhLNTQ3VkFObE5O?=
 =?utf-8?B?dlk3NUJyNlVtQ2JZbUlzQ3Q4V29CY00rbTFET3VsY2RQbUU2VDg2eEZ1eWQ1?=
 =?utf-8?B?eU1HVGFkdmdsSFVNLzlhMURkT3lzSDAvRytHbGVFQTQ1bnpqdHlJZWJzeEh6?=
 =?utf-8?B?bFRJSmliMFc5R0dBQW9kUlVCNnNFakdxM0N2T0tlK2JuRGtkMFZLM01nWUtW?=
 =?utf-8?B?OVNxZ1puUG1yVzh3YVV3ejZsZGQ3VFlVaGNqZTJRT3VXa0FWcndQRWZiY2tn?=
 =?utf-8?B?d3JlQ2JtUEhjV1BlV0ZVWjVRY0U0YlQyWnd0L05MN2VuYXk3L2Uzem5zVVo0?=
 =?utf-8?B?dlZ3c1VCc0VtR3B2SmlvR0NYN01keTFpcnhDL1NIcVRGSUhmUFhsSXY1c2tH?=
 =?utf-8?B?SjFEOGVGbTlYRVNyRVpmcnluOVhhMk9EUXR5NFVDRjZIMTRFbk1UWnRSSWFE?=
 =?utf-8?B?SWxKeklPeVlsZ25LZGdqcGE3WHluLzJVbjRXbUR4VFRBalZ4SUVNK29CenV6?=
 =?utf-8?B?REU3Qzh4TjV6RWlialltM1V6ekFPMnRFLzREZHkrRWhIaGZIQzN3ekpabjFB?=
 =?utf-8?B?bDhibmZBUVFTZmJabHEvODJ3T1NwTk9COCtkNERHZ2Q3ZHJTRWtPcEFReUN6?=
 =?utf-8?B?UWZoTk41Qm0wckMxT3QrS2FXRHYvd1h2a1pwTDZPYTRZQ1JHbDI3TnJKbVpU?=
 =?utf-8?B?ZHZ3bVFPSnRURnM3ZGVFYlJ6bDlibTVVampQTk5OSGlsTjUrV1AvRURXSlZ5?=
 =?utf-8?B?Z0YwSGxsdE1aLzkrUVExNExjM2ZoNFJtWkJHakt0eVZBeWNOVHJkUG1wK0I2?=
 =?utf-8?B?a1I2ZDBwSDE0UTdPUU9ldkxQZlJvQXhYNWV0Y0Z2U2ZTS3RaZ3I2SDNjVmdH?=
 =?utf-8?B?ZTh5WFRKeEx2Q0VnaGFOQXU3ZXJpRDFDaGdwZ09jS3ZmNUJIZ00xc2t1ekZz?=
 =?utf-8?B?ODBSZWN0aEVUNkJaZkFHOXFMNFRMNlBtc0M1RHhCSzJKWWttMHZ1YUlNYkxw?=
 =?utf-8?B?ZE9yWVRDOFV1My9GaUtlbHFJWGVmanRKSXJvQVNNS1BLM0JJSzVaOGw4VU05?=
 =?utf-8?B?UmpKWjlFVGtlTGxJZ1JNVkpNUXBxMDBuSThPbk9JTFZvMk8ySG1HUkwyQ3lr?=
 =?utf-8?B?aUtPai9GejFNS2EzMm1XWEdtckI5RmpObEdPekZ3RUF0NjFSajB6RWluNEUx?=
 =?utf-8?B?TUx0aDRzS3FWRHhpdjdBbmVDTGpYdW1xdzZ5U3ZNZmt6Slh4Q0VQeUtpWjUv?=
 =?utf-8?B?czJ4VWdGb25LTUNtR2lqR0MwODV2dTdpYW5IOEdsS1hQaEdvbm1sYkNHWFlT?=
 =?utf-8?B?NTdsMnEwVUY4STZMVi9odGdkU1lXL2ROUnI5WVh0V0NYV0FlS0k1MmVyb2hR?=
 =?utf-8?B?Z05ZTWpKQmgvM3N1bFpSR2RYaHNKMzc4RnErSUNCanhIZmIxbXYreUNhQU5Z?=
 =?utf-8?B?SFlyakdZRDZ5Rm90U1J0UlkzbWE5WnhOTFEvZzkzN1ZzeTJWdzgyYXFybHp6?=
 =?utf-8?B?K2VxUVZIb3VJODJ4cUFwY3dVZ2dKVmRHc3JqRmJQN1N2ZjBxM05VVjhDWno0?=
 =?utf-8?B?dXZBNzg2bEs1bGRCMjZHNTVQVUo1aURobElUT2hsbHlBVlp0ZmUzNUMwemNP?=
 =?utf-8?B?N2tCS2VBRHpiVkJIQ0FLZ1EramJWMVZMelhUMmNST3JFNWdERnNSVEJYTlpW?=
 =?utf-8?B?SHBHSkdFM3dHcnZicW9DeXdrd3lsV0ZTei9LVWJ4TGtiRG1Yd0I3RUxwQ0VL?=
 =?utf-8?B?NnZ5OGJoQ1VGTFQ5WHdLU0xkbzBNc3Z6RTBZeFl3a01qSWFQVXV2OFkySkpG?=
 =?utf-8?B?UG9jNWVyVFMrM29WdGt2N0FDRDlPbDc5SlZFZUVGMHFLVk1mN1NqWVpSSmZq?=
 =?utf-8?B?TWhQTStsdCtBZlpUSnNrVnN4NjZmdUhzWUg4QnphK0ZwY092ZGRKMkcxZ0Fu?=
 =?utf-8?B?TFBZSHZPbm44UWNnNndmSlY0ME45Y2FWUnVZMDZyYTUyMWhhc296UFNOR3p3?=
 =?utf-8?Q?L6iOMhj9op2SxKc57Y4GVdZnf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3938e89f-b17e-4c4a-0644-08dc5cee3651
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 01:48:56.5856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UwKOk7Bj32T9qyPWt7HarLqUQNRsBQBdUJnQX5ZDSSp1dUvGGSKMJVIacVSJ7mT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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

ping...

Regards,
Ma Jun

On 4/3/2024 10:57 AM, Ma Jun wrote:
> refactor the code of runtime pm mode detection to support
> amdgpu_runtime_pm =2 and 1 two cases
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
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
