Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6185C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7617B10EAC6;
	Tue, 30 Jun 2026 04:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NeaNom5C";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9D410EAC6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZvrzExf4hiyzL08bS52mbAVxFzXAWPdNNGSwlbRyfmqjuOt14UYnncdZ4w2sOSFOxfwhWrjpUAngpDVmT3QEZlcn+RCBr3r/otSJl/Ppq9AGuQvOwUGTqdwq04CxW9PJbGR1BNFT0hpECeBOCzGzCXNoAC9rOtYl1LpWG1J0cRlTpKKCrxBHZSiuSO+B97vYBiMDuS4Z7wUQ4xDlbvkqMq6UsZO6bf+0pL4X9MleBhvj0xcNVB9onNXTqdINhBNEkG6n9gP+7UBLDew9PMbrLhRgkFdSuTP/8fhyWFdRlZIWu0wrJacr4Z0TRhYjsAQYI1eecEaj4ksfBZ3qp6hXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEpGrcI11LDwXuJzwHUcVDO6CZ9bUDLqROIFFfUeo4w=;
 b=BW/BoRxeCMrjIcTlStue+1GXF1r5XCt9i189SBTqzIq7ToW6eRJfm+48syn5UuQCfDdhJJeouUNsBF/RCahy8vET/cz/jzmSMkVVOr4b9tGxPY2xttGufAN4ckaMHSdVTDZSUfR+Oo94NTK8xEYyRYwu35Adqgy1YHnSPl3rTYzpXV7zU9zkGcd4NNYx9gj3IZSjZscopjoi1KrL4btGeAaVu1d/4z4tI1Ljn2MYR0sVwZ1HFU98dr+qupS8sENyXSBL/bw5Y/iXP24g7D9WLdzzVbkp7AKinZZLIXzOCsfNYN17C3DQfFJGoTdzE7EbYR3PCKBecRyHPWH6P4zsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEpGrcI11LDwXuJzwHUcVDO6CZ9bUDLqROIFFfUeo4w=;
 b=NeaNom5C/bvcoK+jfgHtVXLMPK8mBQ3HE4XqmVB2hs2AFlwZn5gd938HHrMRNJha0i2PsNXSF9bqa50VV7CwVxuFh2Dr5RplPdV4z6lv9zEl5AsqQ2+F1rng0oq472jmtouhBzv1wgLHvZFPh8djW1RmAGKH2XztEoUhqhvnnkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:54:03 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:54:03 +0000
Message-ID: <f18d67af-1451-4827-a943-d891e20a1157@amd.com>
Date: Mon, 29 Jun 2026 23:54:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm/amdgpu: add support for GC IP version 11.7.1
Content-Language: en-US
To: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com, Suresh.Guttula@amd.com
Cc: Kanala.RamalingeswaraReddy@amd.com
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
 <20260630043655.1284069-2-Granthali.VinodkumarDhandar@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260630043655.1284069-2-Granthali.VinodkumarDhandar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:806:127::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fd2605-2b6d-4752-6ba6-08ded6639b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: WBbEH5B8JK/l/4erBmu465rA7KJzKwfkdPK7fxInhtdZR0fVyGZz8emIETLVLJisO8uRNB085ONFAnQPQE/4/f+GEZWc4bzW8v5z+TgTUH1OcOFnaoW4c+hWCGTIhL2NKUqVKYOouwgfQdygtZqHTOXdGGbm8mABZUdp6TORg4UkIuHJe3ASfX4eExhczGpkTU1qCb7kFljP5ziyXvXtEbmhgrJaLYvQ7/uQA/LJ8Krky4aBdrrX6tFwRLl6feQW5CSjQVukc3jCs0uCswcTH4jyHaBgJYoP7tK0Hdt474j76rw0xZ/XElxDXVbDuFe/a+pll+6C189BvV8e9c9vinvBcOczyUvJTcGpgEvL3YSYwtdqB0J2AWUEKdeuKN+/RAI0iZ/PITwQG77lEUtO9j8gQrAzBHd4wZ4Y9oqmlAL1vLGqCBPB2Ct3v6GEgFqtFuY66xV8ZVht8FqNixKijB+ryNb9YxJH48Q19Xma5pMBbuKAnB0noU9zeGmSw3JQsBoXJgTiHA7kjmMbbGeBPXeuP3IRT6R1GI3CdzPwVjQxVF4LoXJZ6OdZ1dx7Dq+ZA++v35UVOeyB3NZiDmp2stkvPFSHtrxAsswdfrO7Ze01qSyqhW4BDboi4CxiDs+rOqQRY30HL5Xpm+d3n5SLaIaMIyY9rjc/hm7Is5QguOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpjZEkwUC9VMG9vYS9SYUdjb1BlOEhaUjdUNUtQeTNFcWtGT2pBa0w2NHBS?=
 =?utf-8?B?VlhmcHlEOVloWE4xb1I0d25hQXEwK3QxS0FxS1BabzV5akVUVHFvb0ZNZFBP?=
 =?utf-8?B?ZzVha2hxSGwyUDVrb0kzUVhSZmNqWHhTeEVxdnhGMi92N2o4VStpcHpMZE9D?=
 =?utf-8?B?ajRUVEMrSm1wbWdlM0w3dGtUMzIvOS9kQkduVnlNeUp4TUZacTZ1THJnTTVs?=
 =?utf-8?B?T2hML0hLa2o5RXRQUmZoeWVXNm5sdEQrODZsQXFsdlRJZ3R6b3dqSUN2ZUNV?=
 =?utf-8?B?Q3JNU3NvWG5KbjlycjFwOUhrQ3IyOGNPQ001WFhyZ3BJbGFVaDE4bUFCNCtL?=
 =?utf-8?B?aEpXOTV5d1EwRWNMUFA5bml0V0xNWThvTmE5Wi9DbTBIM2gwUlRaczFGdElW?=
 =?utf-8?B?ZG9kaXpjNi9XSjZNTmxwVk9hVzdoSzhoREorZ2RManZwZDF4QTB3eE5EK0tw?=
 =?utf-8?B?SEdvRzRYTnFTVXBXT0Z5OUF6bllqb3NOVVRCMGQwUXpqUVJkU3V5cCs4K2JF?=
 =?utf-8?B?VXIyOWFTUlhndGV6UnZYVjM5WHNUR0FrTVVERnZxSFZLRW5oWHFodGhUYnlM?=
 =?utf-8?B?N2l4MHVIc1FsUmF1bDRjWmQrMHQzUDRDajhoRlpkNUlYZGdKYmE0alRoNjQ0?=
 =?utf-8?B?L2NWVy9Kd1hjTmtobzV3SURoTGJMelRnQjJNNUE3MCtHOEl3STJSUGc3ZDND?=
 =?utf-8?B?VmFzMm9zcTQyNG9wN1JMVFlaNHgyR0EwQWJrN25jd2tYcmNPZThuRnJBdTJI?=
 =?utf-8?B?NWdYQTR4cUFiM1NYNnc1a0k3MitZNXZrUk9Jc2lKOFZqM2FrVC9rZTJpbmFN?=
 =?utf-8?B?Umdva1I2cTZvTTlKaWs3T1FBOEtGLzNIdGxQYkovdUZETGJHN2tTeGN5SDhB?=
 =?utf-8?B?c3FhSnVHM2phdVJKZ0gvRkJrTFJSMFQrbzYwUHU5ckl2WUZhT2FEM3RGdmRK?=
 =?utf-8?B?aWxLeU9RcG1GVUNOUlc5MnRuNm5IN1NVNmRoMGJXMkxaVzNPNCt0Ymtyb01j?=
 =?utf-8?B?aTBxRkJOK01uM3B1dUN3dWYxUEQ1cFM0cy93N1lKWnliT1pZZHczQzdROXkz?=
 =?utf-8?B?S1o1cEQ5UlhpMEtGd1NISHNKVWpNVVpHUWY2bFBNM2cyWjF3SXNkNFBuekFC?=
 =?utf-8?B?QW1Xd0dkWXA3VWZ5K0p4bE1LY25Ocm9GNkQyZDROSnFzdkJVMFFQRjN1R3du?=
 =?utf-8?B?ejQ4SjRIRFp6aHlWVnJBUDF6bXl4N1Iva0c2eXdwR3BVR3Q1WElPZXJ2aEJq?=
 =?utf-8?B?UE9JQWNJSGRoT0Z3RDNSWGo1bWM4NU1Wek9VUVRzU1lnbmZYTkZrd09hTGJ2?=
 =?utf-8?B?dG9CNnFzVjJBZmg1L3ROMUpVekdyU0QwV3F0YUJ1bTlzcXZvQ29IUExWaTNL?=
 =?utf-8?B?TmpSYlhTdjNtWHp4bU40cUVQNXVMSnh0VEU3S3ZIMHd3MGtZVVlmYUR1ckRu?=
 =?utf-8?B?b0JYTm1lZHZpbStPSTlZUUZuVVF5TG1jQnZvUU1zcm9MV2tjbEhRWGViL2h2?=
 =?utf-8?B?d3ErYmVlcUxna010clE5VTRISkdjaFhpZjB4aW9oNDhiZnBDL0prdUx0ZlRE?=
 =?utf-8?B?Mmx1NlAxWHYyWUMyaGJuTzZ5TUkyY1R0T1plS0hab2cxdm5sTXdZV0NlMU1t?=
 =?utf-8?B?aVdmcU9hcTZjaDZXdFZ4dmhhMzdnTmx0R0hxL0p3RHg4Vk9VSmV3UG9ONkR0?=
 =?utf-8?B?cFNMYUNxOSszRm9ZTDVMd25tWFRwODhxZWc0NkhvT1lRTmlPbWNZclgvajhM?=
 =?utf-8?B?T3ZvUDRUMjUvaWd5a3B4bVNYMEtFbXZJbVhRR2VhVm1mcXl2bVZNU0tmeUZC?=
 =?utf-8?B?MlJWZVp0R2lnZXh2Wm43Zk90TWhJbDV3TVg0NU5vTWVjWlQ5bXNWbmhLN0da?=
 =?utf-8?B?dm5raW9yOXlLVFZBM04zcTE4MWU2MGV0ZEdXMVZPSUdLQWQzYU9JSUw0N29h?=
 =?utf-8?B?QTVqbmtJN1FyL3NKMVdqWkZPUmR1VU0wb0ZpSEZqUTRQbWgwemN5VHFTWHp0?=
 =?utf-8?B?aE9odGRYc0JqVnRFMnF4Q0E1NjAvMEV4ak9JbXRzMm82TG9NczNwak9iV2hY?=
 =?utf-8?B?ODNyOVFPeFBVQncxNXpYZXphUkVLakt1UVNXaFIwYXA3SUR2VVpEbzdKd3NX?=
 =?utf-8?B?QkZqcHJ1azNpeHdxenk3T0tsQmEzTnE2TjlBNllVQUM0cFU5ckNWeHdra0ZI?=
 =?utf-8?B?VitjMXJZbDZ6ZVZjcS82Zm9OREM0N0JWNytNMmlNQy9XMDRTNWtRNVZqb2U5?=
 =?utf-8?B?U1p2amRGV3djNDQ5RzR4TGtkaWlGV2NucU9PMnRycWEyWVhxclF2TUQ0dTc1?=
 =?utf-8?B?OWs3eGRZWGc0TDZtN09NNlVoZEcvZC90aVNvUzcyU3NZbWw0T3RiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fd2605-2b6d-4752-6ba6-08ded6639b41
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:54:02.9281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9mnJc42IcVlQb1/4IEnsYtluW7+5ndCf0h2lfzhfKGe8xAPulp/v2sXS6QQi6goUlV5xdt6OZgtws7HH5c7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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



On 6/29/26 23:36, Granthali Vinodkumar Dhandar wrote:
> From: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
> 
> Initialize GC IP 11_7_1
> 
> Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/soc21.c            | 28 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++++
>   10 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 249b2d556bb3..d345bea4f390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2337,6 +2337,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2399,6 +2400,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2726,6 +2728,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2945,6 +2948,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
>   		adev->enable_mes = true;
>   		adev->enable_mes_kiq = true;
> @@ -3354,6 +3358,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->family = AMDGPU_FAMILY_GC_11_5_0;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -3384,6 +3389,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->flags |= AMD_IS_APU;
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 46b9a477fb42..61c528c5db5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -978,6 +978,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		/* Don't enable it by default yet.
>   		 */
>   		if (amdgpu_tmz < 1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 26c02bcb05fa..64e58cf15c1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -137,6 +137,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> @@ -1133,6 +1137,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->gfx.config.max_hw_contexts = 8;
>   		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
>   		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
> @@ -1618,6 +1623,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->gfx.me.num_me = 1;
>   		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 2;
> @@ -3097,7 +3103,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6) ||
> -		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0))
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0) ||
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
>   			bootload_status = RREG32_SOC15(GC, 0,
>   					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
>   		else
> @@ -5773,6 +5780,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>   	        case IP_VERSION(11, 5, 4):
>   		case IP_VERSION(11, 5, 6):
>   		case IP_VERSION(11, 7, 0):
> +		case IP_VERSION(11, 7, 1):
>   			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
>   			break;
>   		default:
> @@ -5814,6 +5822,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		if (!enable)
>   			amdgpu_gfx_off_ctrl(adev, false);
>   
> @@ -5851,6 +5860,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   	        gfx_v11_0_update_gfx_clock_gating(adev,
>   	                        state ==  AMD_CG_STATE_GATE);
>   	        break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 8a0a88551461..c40d9c467204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -607,6 +607,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
>   		break;
>   	default:
> @@ -783,6 +784,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>   		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
>   		/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index 177d702e612a..05b164f38c97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 3ee0c9ee262b..73c1525ad289 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -62,6 +62,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
>   
>   static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index 2a8582e87f2b..2a4d91368ac6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -33,6 +33,8 @@
>   
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
>   
>   static int psp_v15_0_0_init_microcode(struct psp_context *psp)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 9b9b13e327d8..1677e88a4e36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -866,6 +866,34 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   			AMD_PG_SUPPORT_GFX_PG;
>   		adev->external_rev_id = adev->rev_id + 0xF;
>   		break;
> +	case IP_VERSION(11, 7, 1):
> +		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
> +			AMD_CG_SUPPORT_JPEG_MGCG |
> +			AMD_CG_SUPPORT_GFX_CGCG |
> +			AMD_CG_SUPPORT_GFX_CGLS |
> +			AMD_CG_SUPPORT_GFX_MGCG |
> +			AMD_CG_SUPPORT_GFX_FGCG |
> +			AMD_CG_SUPPORT_REPEATER_FGCG |
> +			AMD_CG_SUPPORT_GFX_PERF_CLK |
> +			AMD_CG_SUPPORT_GFX_3D_CGCG |
> +			AMD_CG_SUPPORT_GFX_3D_CGLS |
> +			AMD_CG_SUPPORT_MC_MGCG |
> +			AMD_CG_SUPPORT_MC_LS |
> +			AMD_CG_SUPPORT_HDP_LS |
> +			AMD_CG_SUPPORT_HDP_DS |
> +			AMD_CG_SUPPORT_HDP_SD |
> +			AMD_CG_SUPPORT_ATHUB_MGCG |
> +			AMD_CG_SUPPORT_ATHUB_LS |
> +			AMD_CG_SUPPORT_IH_CG |
> +			AMD_CG_SUPPORT_BIF_MGCG |
> +			AMD_CG_SUPPORT_BIF_LS;
> +		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
> +			AMD_PG_SUPPORT_VCN |
> +			AMD_PG_SUPPORT_JPEG_DPG |
> +			AMD_PG_SUPPORT_JPEG |
> +			AMD_PG_SUPPORT_GFX_PG;
> +		adev->external_rev_id = adev->rev_id + 0x40;
> +		break;
>   	default:
>   		/* FIXME: not supported yet */
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index a6a7888c7a8d..2a239f45fc24 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1716,6 +1716,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   		case IP_VERSION(11, 5, 4):
>   		case IP_VERSION(11, 5, 6):
>   		case IP_VERSION(11, 7, 0):
> +		case IP_VERSION(11, 7, 1):
>   			/* Cacheline size not available in IP discovery for gc11.
>   			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
>   			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bc05ae15c1cc..1c3e8b61d4f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -170,6 +170,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -456,6 +457,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   			gfx_target_version = 110700;
>   			f2g = &gfx_v11_kfd2kgd;
>   			break;
> +		case IP_VERSION(11, 7, 1):
> +			gfx_target_version = 110701;
> +			f2g = &gfx_v11_kfd2kgd;
> +			break;
>   		case IP_VERSION(12, 0, 0):
>   			gfx_target_version = 120000;
>   			f2g = &gfx_v12_kfd2kgd;

