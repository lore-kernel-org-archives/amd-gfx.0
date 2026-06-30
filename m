Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53830C43602
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A81E10EACD;
	Tue, 30 Jun 2026 04:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zfaZFc7b";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C4C10EAC8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sb6mn4OSy2TeIRs8NC4CHeGN55TKWwoz8TYeO75Br17qFggKJIifwt0TsogWlqIBEqdcgBkXnnsLgE1xAmQ1aMxmcQsqcetXN38ykOUOx7kbY0yvi8AncGGjzIWh9FHfWAp4TFBsWPtcBSg37d7PbTiB2yE5SgqaoMgXZNt5CF5Bj/DrZlfEgB0m6KSOAUw71zaIsuVD6NcqwoKIOs0ExxaTielfXPmRowjALLdKOofyOzQD3lPEmAEKTUjYAr3+AQTzwjXqinIoExcrIVU5yzXbv+YoOdRGnABLptM4SDnU4Bonb540w+FZX3xHDMXfKgMV51joq/uUo7c+qtDItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smcsM5hhE8KBqvHf4VdJa278ihOZ3EmMZCjgZhlkVzU=;
 b=RxoNfJ78GMffoj1gVv1FxkAq4aZF6sqWqQiZeQsFgiQJcwGPKsaOThvRoDXNlSHul079erN9jLaQyvrPGZ0QGsg/OzDQEtuwm3jthYE0IASZSYN9VhnOLdXLPNOpaytX0kgZGmuxteF7KhjccoIFrE/80UhSifjAYa9rrzjukLB+wS3OTVgaxjLXae4JGmHTMjI140v08AVoInAFUdERHzMaaMlxSK8phmntk3QO4PUzKu4wMDPC5QtWiCvFC6JlMPASsISWyzZYFIUCEWahzDI4UOPnZH24Olf7NZwCALquar8W7XXFqB0ab5/vqQy9/xsqtlxVpH6S0wm0Nq4lsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smcsM5hhE8KBqvHf4VdJa278ihOZ3EmMZCjgZhlkVzU=;
 b=zfaZFc7b23qomhyQOZOdC8Dafw5uWvmlfeR7/oJuapmvUQS1IaCHE9mYmtlmZ4uXKK3Ut3EFGiUQasq3G/T4Oa5mqviMaa6hmsWqK2ozHt8Dq/5IRso2/wWXSMYfRTlD/TKXM0tnyiUy5FhJOdOt9/fydO1Qp5OV+bpkLBGWMHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:54:19 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:54:19 +0000
Message-ID: <4091ceea-0ba1-4143-b567-d86763258d4c@amd.com>
Date: Mon, 29 Jun 2026 23:54:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/amdgpu: add support for SMU version 15.0.9
Content-Language: en-US
To: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com, Suresh.Guttula@amd.com
Cc: Kanala.RamalingeswaraReddy@amd.com
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
 <20260630043655.1284069-4-Granthali.VinodkumarDhandar@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260630043655.1284069-4-Granthali.VinodkumarDhandar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: e8033851-09a1-4192-44a8-08ded663a547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ABBlEjH7RVwxcobqV5Kb7If8+nxmLvwG+01ayZylfmtKb8huxNTkOvMbL7gmfZreUCPwwgLKO/uDtrmEzQjymKIARW3Fuz4V39GcUspctId4e+yDQixDooynsfb3ZmXgzm0u2RC7lOqcUSBrS3HtwaaCyhWZdwI+gfVwFui+/cGef1mG7Kl73h+EYoJbPGYIu0ttGO3Wo9RSyJeOZEBWuFUj8Pf8lYq8FtvjzxP04e8zfh3tI5IFl0klGWbScu1Z7lSiCA6bNpSuIkVqSo2pyTvBk/6BRSo10JZ7oMW07lS+b2ysa+z3Q6ipxmnoHispQCTr6MI/hwN3gYERZgtob1tHOh41tcvgDv9A8aJFXDN8kEcLBCFphUM3y9jhZq57TU2GxvBNm4M/2Vwsap8JVDH8QE6f6HHKefl7Hkh6VKa9jJTVGrq9QYXtGigsDWoO/xoo8de3vya9IwbXCtPfuMLN/6J2Y/cr67YLbuKqsx5Lq5HXkd19PXnFdLh3EzyUTpr90VUE3LXXr4HSjyTA1QFV/aOgAZtNv40PBaUVwEdSDqqRES/O5a2XrbYd8kgMjpDaxi0FJ1+XJ1mwmcwgkUrSRIN5eRQR6+PiuoOvcaK+FitQ1M1zoEvkX+rH4Iw0cUYUA+42l+9euYPoSMmUtoTriHPXHYe+/OlFDl0ZkRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxtT21JSDgzcVBCWGlKQktzSkYxbW9mdUlHQlVzUHdsODd0cUI0VjFHSnk1?=
 =?utf-8?B?NVpnam9wUWtMTy9KT2RQU3dlM3V0ZjY4L1pCN3pUOXVVSXZFVG5IenI0RkE0?=
 =?utf-8?B?OTI0dmRxNnd0RXdYeGtneHpEVUtOWUNOVk9ESWRSNDJSTWR3MFB5cVExTjA5?=
 =?utf-8?B?eW55SXhPTTI2Y3lCTkhlazVSMzAyQndkQ2x5Y0NrdVRPQjROU2NxcmRzemdv?=
 =?utf-8?B?aERhOTV2QzBYcUJsT2ZSUE5NOHMxS2JjSlpCQmFEOWJvSnc3dHFXaC8wZTNH?=
 =?utf-8?B?UUFqL2s3ZGYyQlp5a1FqbnZWcDV3OTNPSmhpSER5ZTByeTFrTzVHSjlWY2dG?=
 =?utf-8?B?QVptZFBvS1A5dmRvSDlvMzR3bFJNdzdNakwxdUplZHJFMzFQcVIvUCtUSStT?=
 =?utf-8?B?NzV5QStMM3RYQ3JvTDdRWEhydzJrU3FEUENDUzNPdWczc0ZYRDhVdmtsUVZp?=
 =?utf-8?B?cVhSbkFPM0FSa0ZISEN0ZXFxMFJFUU8zVGtxNnBZcGozb0tBektDeVVud0VE?=
 =?utf-8?B?dWt4V0E1WmZIa05COUlucWIyaUJCYzlYZmp4MExSMU9RUFQ5cHhDQllEUVVR?=
 =?utf-8?B?TFdpcC96bktmSG4zbWt0dDFKQk9Ya0h0aU53ZjJFdS9PNS96aWliV0lBTFFR?=
 =?utf-8?B?RVNxVVZ3L3dVN0wxWTNOaHBDOVlpMGlKUGxLS0ZWM2pSbmwzODc4cE5QeGNI?=
 =?utf-8?B?Q3dhVHZpOWhxbTBIV1Ezc1dBUXFKb2oxUnQ4NHFSUUlQTHJXU3lzSDdvU21i?=
 =?utf-8?B?NTQzT205VG9wSlFPRmpMRWE0QUxUZmZtOURxZExoeTEvSG9KTjNkNnNZZklJ?=
 =?utf-8?B?N3kwZUROdHY4TjVuRllQR211Tm80WWdYZmdTY2pmdy9wa0ZpOXhQVmMzL1ZC?=
 =?utf-8?B?QzlVUFNiMlpmSXNFcjNaSnlCT1pwY2o3NFNtckpYRDlQcVlTakRWR05EL2hr?=
 =?utf-8?B?YmtsQ0hHc2RBMlNsM21UV0szdUE2aDlqNm9DVUpYWXFJR0w1RGNKUndUbkdm?=
 =?utf-8?B?T3RhcERucEY2THJ0UUt2WFRnRFdiQ1JFOWdrVlQwWmUweWZPWHlTT1lETmsz?=
 =?utf-8?B?ZVMvdWx6ajBSenFzVThXZSt5OHgvdG44Z3Rqem9zSmtsNmxUMCt3NXZYQTE5?=
 =?utf-8?B?end0UjBPU1Z5QkE1MXRIa0tHanlSakNQUFhnTkhnQksyR29tdXVROEY1QWY3?=
 =?utf-8?B?bXE0UHNMa0Raa3pqVWdWNmlOQU5KaWVtZTVnVC9OZ0pTaE5YOUp5WDdsTzJD?=
 =?utf-8?B?ZUlwUVgxaHZRVm9PNHdBb3hDV2szK2paVDhLZFA1M0FDT0dIbGwvRHpJVlZX?=
 =?utf-8?B?OWFKTVhpYzltZG0vc2NOL1lRN2I2SnYzTXhIQTJyanZISnB6ek9IUkZ2bXkv?=
 =?utf-8?B?OE5qT1djZElXaHNUTFVIa2V2TGpndkdkNEhTd09LTmg0aDJScXhrNi90c1VG?=
 =?utf-8?B?R0F1dE1WUktvdXdXSitpOFFqWVVPZWN6NUh1Z3pHRzNqNXcwakQrdVBoK0U5?=
 =?utf-8?B?UnJ2K1ZkYTVEYUJ6UTgvSitOck9JeThkS01HcS9hWjVHQlJOcTV5VndQQmlE?=
 =?utf-8?B?Rm4wTmo1QUp4MDI2d3phMVZjdTh3OFBZaWZDdWkxU0owNlhvdzZFd1dUNlJk?=
 =?utf-8?B?bTNmbEJ3aHYzQ3orT3hxSys5b2pYNXBBRFlTN2dsR3FaTXVpdEN0Q0kvTlM0?=
 =?utf-8?B?QWtkcEQ3NnduR2hodDJKZVhLN0x4c2Zka2FaRXBGZmJvd0ErMldNeEZCQ1Nt?=
 =?utf-8?B?am9tMkg2NndLd0hpRnBnNUZHeE9JN2xjSnUrc0dsYlgxWWFHWnBEVXZGQjBh?=
 =?utf-8?B?QXFvZWt1WXFGa0xSRkhtNlR3QkJWMjJJd1E5UlVmQnNOUVFTRnpsRHRUQklj?=
 =?utf-8?B?YXJyWnlUNWJlUXpvVmVTaEQvd0lGSFRTbUxwRG1GbmllNjVydm51ZXpYMTFw?=
 =?utf-8?B?bHRLN0VZdkhjTlM0dGhVOEJKZ2FVRlZpRnQ5Vks3ZHRmdnZJOTFjTmRzSHJu?=
 =?utf-8?B?MTVBN3FIdkpXSlYxcUVLT0Z1NWtNeVQ3SzZJUVRmU3Zxd1FKYWFlT2wrNzEw?=
 =?utf-8?B?bnBvS3pibTZHaFZyZEVmRDEyL1k3RXI5RkVsYmxCQUtHSTJEaC9aNm5vRFcw?=
 =?utf-8?B?akdLOUZKcTVGOEE0RE1peGRBOXdBZjNsbkphNXEzaG9ybXUwbjZEbkZKWWt2?=
 =?utf-8?B?RjJnbW1lclgxUFJvcVY5TWdNdHR3aTcrY01JZG42eEdvcEFQUWs5Rnd4V2p5?=
 =?utf-8?B?Y2FIVkFHNHVYcDJyb0xEamIvdzBtSkZ1TGM1SU1rZTVqbUdqOW1lb2VZYmFG?=
 =?utf-8?B?ZUxtMEJMdnRCK3lFN2lxNGs5TS80NmN6MDdLVnlnL3JuRm9Xa3VpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8033851-09a1-4192-44a8-08ded663a547
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:54:19.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKjzYfhdIRBTpykt0rOpeDJycNXKiSL6OTTy5mVAzvvgDSL1z4nn9aHY31Xr1Ov98CVy78G1jIC2s+zqYRHg1w==
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
> From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> 
> Initialize SMU Version 15_0_9
> 
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        | 1 +
>   drivers/gpu/drm/amd/amdgpu/soc21.c                   | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c       | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 3 ++-
>   5 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 16606155a92e..b309c9fabeaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2593,6 +2593,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(15, 0, 0):
>   	case IP_VERSION(15, 0, 5):
>   	case IP_VERSION(15, 0, 8):
> +	case IP_VERSION(15, 0, 9):
>   		amdgpu_device_ip_block_add(adev, &smu_v15_0_ip_block);
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 1677e88a4e36..a2733d1637f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -406,6 +406,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
>   	case IP_VERSION(14, 0, 4):
>   	case IP_VERSION(14, 0, 5):
>   	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
>   		return AMD_RESET_METHOD_MODE2;
>   	default:
>   		if (amdgpu_dpm_is_baco_supported(adev))
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ae44437af86b..c0699741e711 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -802,6 +802,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>   		break;
>   	case IP_VERSION(15, 0, 0):
>   	case IP_VERSION(15, 0, 5):
> +	case IP_VERSION(15, 0, 9):
>   		smu_v15_0_0_set_ppt_funcs(smu);
>   		break;
>   	case IP_VERSION(15, 0, 8):
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 4a61e900131f..ec7c72983224 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -665,6 +665,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
>   
>   	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>   	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
>   		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>   			return 0;
>   		if (enable)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 3cf47ecdffda..4033012fa39c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -1177,7 +1177,8 @@ static int smu_v15_0_common_get_dpm_profile_freq(struct smu_context *smu,
>   			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
>   		break;
>   	case SMU_FCLK:
> -		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0))
> +		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0) ||
> +			amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 9))
>   			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
>   		else
>   			clk_limit = SMU_15_0_UMD_PSTATE_FCLK;

