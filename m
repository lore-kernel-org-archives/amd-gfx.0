Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E30CF0443
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 05:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDF710E0FA;
	Wed,  9 Oct 2024 05:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQh9kUYb";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738F110E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 05:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBcrmh8An+o1jSUuDTVnBzaK2AqIL2NA/xXW/7Y212vJQevU2VrdH5NmbnajFzv7Rp3h+EHbKJK8hrBxMrrvJ/do6HySAWMNRZWTPVJrRvrlHT6fscsT3XWEbZ9d0+qHwSfrjUhts+W/0ODEgzEhrwcYZAuvh06XTZs5EVd7j6eBD0Z55qXCECXsrMXvrFza9kClwzZvbDD+oSAeraaIyB/Ww5u3uSPAOtdWyQqoRzDug5rKNA5OiobhBvDYyewtChAHLOjGBnxTuZ74gAGzVM34GApLaFljWcUfvDARvo/5lKt5tgiS6MSNKSO0ouzyuHNdLuW7sxUKT7sVjox5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFp5cdzo+p+H0rRGJDq5P24oS0th2jPG1p+ngBA+g8E=;
 b=UqcE/tAZ4x7OOYJud8ASB1bzPQT+5cpvGqIJDvFNKfDD5WWkaZDIcGvA26x6eWDRg9wGu4nc92iFiEYHwVJW53rcm2DiycwXW5+UemNDY9JuUuvBR49o5jsgcdtUJfFcvkkJ30Qh9NNytds+iCDUGYDs8Uyz9NN/zN5rfCd/ohVcjFi3FOqZ3Gdk7N9M2hm2XkYxDydbIWZ6hcykJz5f4Kaxty1oSzOjpcv2Bi8z77HHY2QtDDRBYU8H7INJZWeuQA/cJwm+n64iPjptZRZruYhNaCxAVJ9Kn5bTl/Anpgty3B3X+ldP+K/v6d0rEug0ky8FnsemyR1rhLxzsTfIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFp5cdzo+p+H0rRGJDq5P24oS0th2jPG1p+ngBA+g8E=;
 b=pQh9kUYbscFRk8nbKYx0El7emU+wCqowQN/atMpnISltIfETmMcA9qvHxco8iIV9NXEMZAVA43ga4Gmw4P0e/VWrIeTnhaSYhnHZrqhIdqlgTjGupAeeGQkzcYXOhnkY8ZqhuYyuHpXmOKD8giX36wBm782VcHAK8nmNfSphWW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 05:41:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 05:41:35 +0000
Message-ID: <474a59c5-8120-47b3-8e89-723ac782d7ed@amd.com>
Date: Wed, 9 Oct 2024 11:11:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amd/pm: implement dpm sdma reset function
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241009034545.543736-1-jiadong.zhu@amd.com>
 <20241009034545.543736-2-jiadong.zhu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241009034545.543736-2-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 5684a97d-dee0-45c1-290e-08dce825098e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N29Ta3lpRHg0VDlvTU5CbnF4TmREdTlXNG81YWQrNlBMK0JzdTlxUFlXOWhJ?=
 =?utf-8?B?dkg4dlpWNlNRRU12VUQ1RDZ0Q3NDcGJBU1QzdnNHTko2Z3pLV3pLSFFPS3BM?=
 =?utf-8?B?WWloOVVLV3JHT2x1dXN5UEhTdFBVUzA5V0wxV0NkM3FGc25sM3d1RTFkUElU?=
 =?utf-8?B?cEs2azM2NldtOW80ZjlISytOQ2FFajEwelZST005R3htbGNBTDE0RmV1TVpN?=
 =?utf-8?B?OHpTWW5VUmlsamgxdHJ0RUJPR3kxL01jSGNGVlBSdFZzaXZNZ09uZzk5SENr?=
 =?utf-8?B?ZVRueXR0d05VdE5oNFozclBqd3N6R0lYQ1hGTkJJNlJiZ0x5eUtrb0tlSHh4?=
 =?utf-8?B?TVY3ODlmYno5RGpnQ0xva1lZdXpFcGV1REw1SGdpblhwYktLbUhhMkozNXR1?=
 =?utf-8?B?YnFXTWRPc2Z2MGRYOERhNW51S2d2cWIvZlc3QUtZd3dVdUkzYUYxTGNRbzJY?=
 =?utf-8?B?NGpOdHRnV0FJRnB1bXdxSWNqUVQwWE9UUEZJaXNHdGg4RGdqMWNQZjFWcWdD?=
 =?utf-8?B?a2ZYY3UvV2FjMzFYUGM3aFBXbW5RY21vaU5RZEwvdGNhVW53cFRHazZyYnBC?=
 =?utf-8?B?VTA4TTlnSkdQTW9FWVNrVnFuSXNjN0Yvb1pKRXZESW15VFNiQ0duVWJydEVN?=
 =?utf-8?B?TWg3WnJ0R0FyQmFtQkRCc2Njb0dSUG1kTUJ1UE0reEM4OU8zY0V5WDkrcm00?=
 =?utf-8?B?Umk1eDZTWU9jMDdoM3Y0YmVic2hra0JVNUNLMWxPbTFCQ29YQlBIMUxhWWZq?=
 =?utf-8?B?Q2lIZ1RtM1oyVE5MV3FRa0lZNlhDbUpaOWl4SWRyUkNnbWc5bXpFcXg3eWs5?=
 =?utf-8?B?cEh3NkFhQ2hHU1cvem41SlRXQUgwaWM1NlY1Y240cjkxQXhPNDlrVnRrL3BS?=
 =?utf-8?B?ZmRNWlFEbVhlQytjVU9QN0g3VllPZklQU1pRaDZ3L09seCt5cUNVK2wyOGVl?=
 =?utf-8?B?QUJmVE1scnlReEJvc2Jia0RIVThSTFMyT2tzYmo0aW02ZmpQVVMzMUROU1pL?=
 =?utf-8?B?NzF2OGpTbkhlVzFZR1RlNEtJVnFORlFidXMrZ1h6S0RlMHNGcGgwOUordnJp?=
 =?utf-8?B?cHF3WkhzeFFydEFSTGJKaFVxN085Q1FyOWhoRUptc0VUTG43Y3FlcVM4bS9v?=
 =?utf-8?B?TmZIaDB5WmQ1SkNLRVVyQXh3M2ttSi9SdnNkRkhSa0NXY0VjaklacCtJVXNJ?=
 =?utf-8?B?bjJ6QzdqUm9DRW5ybUVMeFBnNG81Rk1uaHcvR0lHYlArWjlBZEw5ZVA3bmxV?=
 =?utf-8?B?dUNXUHhXZVpjSzI4NmYrK255cWp4SEp5L2psbzMrcGdtbS90Ync1NEcrV3gr?=
 =?utf-8?B?U0lXUFYvQnhrUjBkTUxUQVJIWm53OXgwSHROS3doMnA4WjlqQjhwRy9Gekxu?=
 =?utf-8?B?VHkxeXRBcm9ZdWQ0YTI4YUsrVWozWXRhME56bll2azRwcWQ2YTRjeXdidEcz?=
 =?utf-8?B?U0ozNnA3c3pKRkRKam5aakdhUzZZZXVFOTFsRHRKRzZ1U2J0cUlIaUladEZG?=
 =?utf-8?B?SnhxeGZkaGF0QXh4djhLZlpnWWdyTm1VU3dxVXNWcldETWN0MVI3Zmo1UVpa?=
 =?utf-8?B?QkVIYW9zcUZXc2NLekQzSkhtWEZiVHR4MlZ0UEhQR2k2dkRmZFE4OHV2bGpx?=
 =?utf-8?B?VWNJeG05bGVjWmNLLzNDTWJES0VIYzJoWlJscU5IdkpVR0hxTTVNckhxMmlF?=
 =?utf-8?B?S0ZEOEVCSGN1Q0xkOVVrY0ZVSHYycitEOTBoUWZOaEZ5a0lBMXUraEVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNnMjg2UFFiazBQMTFFMndrcHFzbU5Ud2x1bjlyRFE0UndHVDdTRzd3RmZF?=
 =?utf-8?B?TzkxSjhqNk1YK0VuV3pjdHR3dGtQcWhnV1hBb2ZzUk40L0dQdFM3ckJLTW1M?=
 =?utf-8?B?c0lobEZjdVk0V0RzRFJhbnN1WlhpdFFicU8xRTBJUUQ2bkJCckI2VHNJb1hh?=
 =?utf-8?B?T0YxTzJDRGYyZ3RmY0hhNmhJOExhUGdMeU9ncSt1U3hzTWpLYkttY1dPUVlE?=
 =?utf-8?B?Zm9aRy9pRTVQNFN2OEtmWnY1Rzc1SjlUSGZmUzhPUkR2Z2tvcExjREJ0c3V5?=
 =?utf-8?B?Z3owaWlrMWNFc1ZJNFJMano3bVZqa0RPY2FtOHFtOXlCdVNQZzVsVlpLZkww?=
 =?utf-8?B?RVRwbm9rM1BCZWZQbGUvRGVJZUJrVFE3ZmVvREx3YWJ3OUVyazdDOG91ak11?=
 =?utf-8?B?bWI0Z0hVaU44em1vYTdQZEJPSnZ2cmZzZEZEN1hKakdvZHBEZFNnbUtzSnJ2?=
 =?utf-8?B?R0FhTlFwWFY2UXlSSUhJejVZLzRreUw3Q0psMVpZVk5TLzkyVmNhY1N3NjRx?=
 =?utf-8?B?RHh0dzdsb1I1a0IwWjBmWGk5cXJaL1djUGhJMzBkZmZhaitna1ZzMkFGd2J5?=
 =?utf-8?B?ZmxnTWpUa3NhbTZRWE1mTXhhTFk4ZnZXZEZrdSsxSWtWaHYzM3ZvSUlOVGVF?=
 =?utf-8?B?MXdaSFAvVmpXbTlSTXdSSlV0SEZGWW50SVA1bVVETHNjZ25FcVg1UnExL2Jq?=
 =?utf-8?B?eEYycDBBMzRoWnNDeGx3Zm5FaWlDL3lmTWhWM2NVSkRybE1uQ2pSaFZjQkxw?=
 =?utf-8?B?SjdlRXVHTzNhYnhrM01TRGVsMGJXQWVzRHBvdzQ5MFp3bEloN1J5YmU0bFBF?=
 =?utf-8?B?Wk5pd3F1UVZFU1FXRUk4Umwxci8zRUY0Ry9FQzNGMmdqNkgrZzJJTDJEVW9j?=
 =?utf-8?B?TG0raTNteUdwcndBOTBjLzFLYXVBS3NWYlpIWnVBTjU2ay8yUEZLM0hKTG80?=
 =?utf-8?B?ZlViMFhVamxEaFoyVjNOOWp3T1FaVjJwNHVqWHMrSjhMVTRlNC8yQmNvbDl1?=
 =?utf-8?B?aFZYM1pxZUU0U1JTakJqTEs3Uy9LaFhkWmZpdTg4bFZNeXcwaDMyVktIYVRK?=
 =?utf-8?B?K0lwV1hCMGpncTIvYk0vaWpVRlBucDU0dmptcE9RTmxURHJKUHB3RXVIUTND?=
 =?utf-8?B?RUxDc2d5ZXArYSt0TGtHOVlhT2JIcjgzbU5kS05NeGhsL251T0RHbXJUcEJx?=
 =?utf-8?B?RTdBcW5kanpGN2xLMzFidmxoM0RiRXpWelB0SWVlbm1vNVZ6N2VBVi85S2cy?=
 =?utf-8?B?cEp3NThsSUxrR0ExN0JVY1JhYjhOUlYwSUhTbFZCQThEVFFWUHVJbTVqbks1?=
 =?utf-8?B?VVJQVGU3RDA5N0ZuN3N0d1hqV1BUNHlWTDdQaGY4MDNIYzZyc01oZllwYTZq?=
 =?utf-8?B?Z01URDVmSzdncTlxOUJtKzlQSGFLYTBLM2pGdTluc2NvOXZsam0yN0lEOVFY?=
 =?utf-8?B?cnJkbTdvMmtLOThOYmxZOFdHRWFnckZSdDFZM2NWS2M4eXdFVUZ5MUZobERG?=
 =?utf-8?B?WHZQbUxNaUlCM1Q4MC96bXBUMnh0UU9QUDg1ZXlWdUFXcHhlWXZpaEJ0Zm1C?=
 =?utf-8?B?RTJGNVlHRVBXcFdmMjhCbEs3bnZvMmtoejQxOGdjZ3NJckVsUjArU01oS25D?=
 =?utf-8?B?M1p5TWw5ek85b1cwZlUwaUFJa1FvWG1mTFcxd1FMMEowUTdiSUZKOFprVWxx?=
 =?utf-8?B?NFJ4QWVPN29laGRYOEh5TkVieXhZQU45Um9tS3crUm5hMWVxRlYzaXJHNnd2?=
 =?utf-8?B?dFllNXNEU21tLzhYZnM4dVlpMkR2RXBDMnFocDhRU1kwRVJVYTRIazNCRFha?=
 =?utf-8?B?bkE4Y2gydFM1WVhkQWQ5amtPN0JBeWswdWhBN0JXNEFBRWYvVGxvTnN0TXlP?=
 =?utf-8?B?TUZ6a2dCRkZSM051Z00yVmNMV0pJOXNOQjBvajAxWkcrZkhHdkpZeWFDaU4w?=
 =?utf-8?B?RzFRdGZBcEIzNmtGaldHVTdyS2REajhyTTlmNFQyUzVrQ0ticG1nMVo4bHhw?=
 =?utf-8?B?c1FvRGxpMmJUTEpKTzJGb0VZYU84aU53SUNhUHpyZ1ZDSDM1Y1R0ZFkybXVH?=
 =?utf-8?B?dVh0L2E5Rm5uMndaUGVMTk03amdLaXNPSXVQbTBHVk1qcngzR094K1dhdHpI?=
 =?utf-8?Q?Iu3QVqELrntbMZOwBoFsm7d05?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5684a97d-dee0-45c1-290e-08dce825098e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:41:35.4956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zne76Y/mmC4uZVBliJ+BrfiIMR5Gp1XwSmTAK/DKMIqe4fHO9KCMzYg8grWZzLw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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



On 10/9/2024 9:15 AM, jiadong.zhu@amd.com wrote:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
> 
> Implement sdma soft reset by sending MSG_ResetSDMA on smu 13.0.6.
> 
> v2: add firmware version for the reset message.
> 
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 +++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 +++++++++++++++++++
>  6 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 9dc82f4d7c93..9e7a652d119b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -700,6 +700,21 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
>  	return ret;
>  }
>  
> +int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
> +{
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	int ret;
> +
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&adev->pm.mutex);
> +	ret = smu_reset_sdma(smu, inst_mask);
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
> +}
> +
>  int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>  				  enum pp_clock_type type,
>  				  uint32_t *min,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index f5bf41f21c41..41fb6ef984bf 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -597,5 +597,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
>  			     int policy_level);
>  ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
>  				      enum pp_pm_policy p_type, char *buf);
> +int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4a6b4ad97f06..590d004046ef 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3820,3 +3820,13 @@ int smu_send_rma_reason(struct smu_context *smu)
>  
>  	return ret;
>  }
> +
> +int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
> +{
> +	int ret = 0;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma)
> +		ret = smu->ppt_funcs->reset_sdma(smu, inst_mask);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index b44a185d07e8..5487d9d84a4d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1371,6 +1371,11 @@ struct pptable_funcs {
>  	 */
>  	int (*send_rma_reason)(struct smu_context *smu);
>  
> +	/**
> +	 * @reset_sdma: message SMU to soft reset sdma instance.
> +	 */
> +	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
> +
>  	/**
>  	 * @get_ecc_table:  message SMU to get ECC INFO table.
>  	 */
> @@ -1630,6 +1635,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
>  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
>  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
>  int smu_send_rma_reason(struct smu_context *smu);
> +int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
>  int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
>  		      int level);
>  ssize_t smu_get_pm_policy_info(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index e71a721c12b9..855eb57c734d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -275,7 +275,8 @@
>  	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
>  	__SMU_DUMMY_MAP(SelectPstatePolicy), \
>  	__SMU_DUMMY_MAP(MALLPowerController), \
> -	__SMU_DUMMY_MAP(MALLPowerState),
> +	__SMU_DUMMY_MAP(MALLPowerState), \
> +	__SMU_DUMMY_MAP(ResetSDMA),
>  
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 52f3c537bb3f..42c38ced209c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -182,6 +182,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>  	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
>  	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
>  	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
> +	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
>  };
>  
>  // clang-format on
> @@ -2697,6 +2698,25 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
>  	return ret;
>  }
>  
> +static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	int ret = 0;
> +
> +	/* the message is only valid on dGPU with pmfw 85.116.110 and above */
> +	if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x0055746E)

This will need IP version check as this file also supports 13.0.14 which
has a different FW version.

> +		return 0;
> +
> +	ret = smu_cmn_send_smc_msg_with_param(smu,
> +					      SMU_MSG_ResetSDMA, inst_mask, NULL);
> +	if (ret)
> +		dev_err(smu->adev->dev,
> +			"[%s] failed to send ResetSDMA event to SMU\n",
> +			__func__);

Mostly, we will be interested to see the SDMA instance mask for which
the failure happened rather than a function name. That function name is
not necessary.

Thanks,
Lijo

> +
> +	return ret;
> +}
> +
>  static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
>  {
>  	struct smu_context *smu = adev->powerplay.pp_handle;
> @@ -3342,6 +3362,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>  	.i2c_fini = smu_v13_0_6_i2c_control_fini,
>  	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
>  	.send_rma_reason = smu_v13_0_6_send_rma_reason,
> +	.reset_sdma = smu_v13_0_6_reset_sdma,
>  };
>  
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
