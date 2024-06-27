Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB0C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 03:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA64210E0CD;
	Thu, 27 Jun 2024 03:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0oL+mZcW";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2944C10E0CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 03:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEmcWSNr7mPjCsqahxkvhFFVuTCEhTT1hVc10/aTlwS6+EZd1WS/WJxOuO2n+FGQ9JDDx+KnjdWdJ7NqoOYngwuUA6RxcqNuv2BIWQBegAd/KqCCw62Cn6+efXakaszZYR/oCaLaHESfgzv3CPE5aT4l5Xqetf07cBISXIDidHJnUGbOswFo2xJFRdZsUG3fNEwkz6RAiKkzoDpb94G7XlCeDSWA2eFXMoFcuLFnxT+7CFGsYLSqDbZOH/GIh0mb5QDeMpRwADTnetRMQRt4q1tB4+WTNV6LENwnuqWQzh0doOHYZyIQutS5x2lqQOgC3YDAKJvJQPnHlVjEjHJmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvfTaTCp4f7VgyeqVncyy4hCcgMWTzgl2UC4TrsSM/Y=;
 b=C1mKk0f6EG7AvMs0R43It7PiL+53cnnisLlrnv967kPDM7JEi1tafJh1m06YbmItg80i4vHsZaaXyAFk+xg/pZdLuIu+19Civc3O2QdEpnnA8W14gBnVebZ76saasGT5wADCbtGkPs/mVIU/X+EbkQPW/9SJIKBN30JT/y09HJ5Ia7qfpPOlQHX4raehJYjDPd8bb0SRnl2AKksRavwvmze2FDEx2u1Qj5LpVJjz92251grnWMA/6P2A6FYmXVkSKi1S1dNvD9tbvobT9pfersHd4z1feS9aBcKK2JRgFLF/I4gXH23T5f/Ds5zO4HerZ5MT0dnjsOnzfEKXUERGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvfTaTCp4f7VgyeqVncyy4hCcgMWTzgl2UC4TrsSM/Y=;
 b=0oL+mZcWMfT21f9aUv56QSe1vwEyownfNdIniVT8ZQFvUBLBicFVl4RwEVvxDSJxyANpltdL89WxlKBlEWzxPSyU0YEGPAP6v9gOFjWkDc1T+2AirYCtIT8eEROMzMmbnq9cgKkzWGiRj1J0LEt1C49lT/7yxVAARw3m64ly6dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 03:50:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 03:50:40 +0000
Message-ID: <8c30f2cc-d90c-425a-b4cf-4fe5ec88c784@amd.com>
Date: Wed, 26 Jun 2024 22:50:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use vmalloc for struct dc_state
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240626214530.2008713-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626214530.2008713-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:806:a7::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 270734f4-ec80-4732-2306-08dc965c501c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2pncmdIRkhWcDJVcE50WXQ5bTU0ZE52ZW50OG14RURObHhGTXhnZG1xT0hD?=
 =?utf-8?B?Z0xjZkJrMDJ0d0dXU2U0V0Q0eVhMU29RQ2hnMmlMSVB1TzhLSjhELzJnNTZv?=
 =?utf-8?B?TkV3WnQzdGVlRlZTK2ttTmFYTmErYkVFemxpVjd5a2tFeFVlTlBhdW1mUWkr?=
 =?utf-8?B?Z1pCWko2Ynl1UlpGYkRHNXJmcUZiSDNycU5wTDJpamZHb2QrZjNEKytsckZx?=
 =?utf-8?B?YmIvTHYzcUhjQVBKb0RoYURKMGVyTEZrdnFkWVVsSTB4SGFseVhycm5iclhl?=
 =?utf-8?B?NWkvdDVMWTU0Um5pYm92dEJkRWIzRFg0RXV3a2hSTm93aGUwRUhzdFFsSWM3?=
 =?utf-8?B?RlNMb1Qvbi9OR1FKVTIzMVdQaVkrT1l2aG9GMUxVN0w0WStldStNSVc1L0Vz?=
 =?utf-8?B?d2NRZHArMkw5NFR4dGhkZXAxQ243UUtMaHBmaVVsNnpaZnd0L1R4cTBqUGgv?=
 =?utf-8?B?ZGpGQ0RXeUlROUhJQWF0S0dQaWpnOVdKUkZYdm5ha0pUSWE3L2dwc0VVdkV1?=
 =?utf-8?B?dXJYNWpPT21hZTN0T2JEamN6TFhQT2RaM3FYaEJpNHNTckJKckFrbVJxbFJT?=
 =?utf-8?B?SE41ejlXM2JuS1N4RmxVQnJvVXk0NUpqaDdMeUN1czhud2F3UjhhR2c0ME9l?=
 =?utf-8?B?MW5XN3hWZVYxREpoMTdYVk94eDlPZzFsVG96aDZ6a2FkSUJ0Q2ZaZW5vM0c4?=
 =?utf-8?B?VzVzNXFmRWdFWjNjeGErTHBOV3NmTGZsamVvN1VYbVdOUG0zbUQ2NjdPTGw3?=
 =?utf-8?B?V3kxVmliR3JaUEZQc1YxQkVJUldLZzRDOXNYd3NOVURyUTU1aFM1VGozRzhS?=
 =?utf-8?B?Y3laQ0J3THBlTXhnZjAzSlpvanJoRnMxeHl6Z1VoYzhURWdaTU5hUUhOM2pC?=
 =?utf-8?B?WlBqdWs2VDlmUXlsWmxNMFVqK29yVUhtVjRyWmYzZkdXVGRyNHZNN2JEdnF3?=
 =?utf-8?B?czR1VEZGTmVocjRmQ0E5eEJHb05BeDFIK01kaEU5dEdHV2lQNmFyZTJaOXpZ?=
 =?utf-8?B?Y3d5Vm1vb3ZBeklDNzdTK3VERXk1dUwvWnR6R2lzT3ZwTE90MlYyejdGOHE1?=
 =?utf-8?B?ckw4NThURkxtM1BzYUoxdEpaalJkUkRhVmZKTmsrR0ZIa2JyUFJrWGx5Rlo3?=
 =?utf-8?B?SlROeHd4UWZENHF2bjNYYTdwS2pyZ2p1SlpOQkRXVFYreXBoR0VBZ29sOFNJ?=
 =?utf-8?B?WE5jcWxKNDQyK3pqVUJGbFEvdGIxMWQ5YnplT05CaFB5ZTU1ejNhYTFvdm5K?=
 =?utf-8?B?cEZwdThxUmtSU3piTGU5MGE0UmRpWWRXcGJtSEdwQ2QzQkRVVis0ZXpqZmxz?=
 =?utf-8?B?M3Npdzd0TFBjbmd0UWRnc0EzUzFBZStYV1NZZndMMHhzTjB0VGJJYVpuOXlT?=
 =?utf-8?B?ZE11K3lLejlwTEVIZW10Q2F3TFl2M2thWWRaRDdyMlVRNVJIR0F1c2tZSVVm?=
 =?utf-8?B?bTN0MWhFZVJyek9VbXhNeVZFVC81OGcveXZMOGFzWm5VeGVyK2VZR3VIZUhQ?=
 =?utf-8?B?VjlPRW00c0VEVmJYSEU1eUNwQzN3dHo4UUtUUGd1U2xsZGpSSmF1Yi9qdkpm?=
 =?utf-8?B?ZmVpYklvSUxtYkU2cEMzdFBialU2b3BBYlVzVi9QOW43d3ZZRlZzbVAwMWR5?=
 =?utf-8?B?em5LbzBPZ0JWUllwQjFrZXJPbmFkT2ZUa0F3RW50OVkxalZmWUQ2dWRYQ1dS?=
 =?utf-8?Q?OyYsNmITf3DnwWfIkLbF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRIWTU3aStFOU0xV0lzUTN2SEN1aEtTUHg2U1N4aTVWTTNwTFBLeElITU9a?=
 =?utf-8?B?SDI0YlVEaHVVVU9hT211NE9jVDBsLzZnWlYrbStobCtId3MzT205VHg3R1Bi?=
 =?utf-8?B?T0lraDF1d21HTWtKS205N0Z4bFdkZkRjQlNBYlVOak9FTVpKY3p2RmZlMGFM?=
 =?utf-8?B?eVBSeWR5Qk10MHpvcGcvTDlDQVhxWWZncE9xU0Y4bFhyVnl0ZUl0WXJhcTdz?=
 =?utf-8?B?OUlGa1VwV2M0aVhTWFVkdysyU2JvNysrb2U2MnlRVDdia0NIbGNaa3FJbFRO?=
 =?utf-8?B?bURJRE1BYlFtRkFnR2NqM2YzK29rUkJnWFliQnNiWkZhN245Z0Rreklsd21m?=
 =?utf-8?B?eTN4ZTAram9oVGRsVEhqQ1VrQnN3REFMSi9HYjFFWTBRQ2VyV1N4anlBaUg2?=
 =?utf-8?B?OWlNcS9hMUxtd29sanVxUWdRWk55T1NyWU9JRGZKbE5Td3NKRG9rQ3Q2dmN0?=
 =?utf-8?B?YmMzRXlsbjdCcDhwakZKdE1rbk1XeWxpQW1VUG9xb2FQSm43a042TkhHcEJK?=
 =?utf-8?B?WEpHZVJjVVp5WXdRaTlnV1JscmVpY1RMcDd3azlYWmdud1VZeEp4K3RHQzZ6?=
 =?utf-8?B?UXFDdEppYnV1UmphcUp3dDRnMmlLUFZCS2k4SFZDWU1oa3F2S0pyZGFJWUlu?=
 =?utf-8?B?bVZudkZKRy9zNzhPTCtqQlBHdEZ0V3c5Z3JXSDZaelRUSEpPOVhvaGZ0ZkEr?=
 =?utf-8?B?T05lKzB3NWNxNGpVWkRYZGwzajBYcnhMSGF6bHYrbnVEeW9SM2lWUnpVbGhi?=
 =?utf-8?B?aHZnbW5QekJheEVsUWEvUkM2Sm1OMDByd0lmcmlwTkg3SkZqUUZCZU1UR0NI?=
 =?utf-8?B?REtnM1BSL29xQlBkSHBiamZzRTd1YzZ2aGx4S2pSMnp0OEp5bktPS1NRWGwx?=
 =?utf-8?B?Y3pGeHMzL3lMbVdyZGVUUmRYWGxvR0FMN0hnRHZ2YlR4WC9waWUxMkp0a1pR?=
 =?utf-8?B?OUlOOUdtYnluK1g5alJ2UndUenFLOG4vZ3FRYTZxbE5MTVlqVzNtcU02VUNZ?=
 =?utf-8?B?cWhST0FKOUlsRDM3TjlMTWNQZlI1VmtGTzlxOENUM2xVTWhzYWNxZ09ibXp4?=
 =?utf-8?B?aXhHSHNqeFFTVUptUW90TEVjb3BGSjFQMTdlZ2puanpjOEhHSmdXVDBIZlN0?=
 =?utf-8?B?b2ZlV0drUVU1bnNTRUFLc2JDOVpPSE1tVXgzOEIxTGdMcVU4WU5HVGZJd3hu?=
 =?utf-8?B?K2lkaVM4Q2MrbVd1dnZycmt3RkNiNmdDNjQ0V1lDcFhrVEcybCtxRUFRYjJG?=
 =?utf-8?B?NnVVOUJaV1pLcmZjdnEvbjVFNklRMHh0dk1ad3Z1KzdSSWlHcThldkhoNFhO?=
 =?utf-8?B?TFVMc0RkemM0b0xSNUNxNm1vVm5hYlhtcWQvbzZrdTFFeWY4c1NVZFk0V1Nz?=
 =?utf-8?B?RTlLUk5JL3dmZ09BSEpTV1hrQ1lWQ3lieXhHME8wZE9BUk9uZWhMUGZwMktZ?=
 =?utf-8?B?VkRwQzhhM0ozd2gxczM1VVBLam9Cc2luTUJidVcyWTIzQWpEYW9DM08wbHVz?=
 =?utf-8?B?cGNha1AxN3luZzV6VXByMHI2Wm5VeHZTVHg5QllyYUlnNXAvMlNmMlk5Wm90?=
 =?utf-8?B?RVRVOHVRbGIva2tYMWlwd2tGR08yTEl0K09MTDV2VWx4dVZ2Yyt3eHlLTjd4?=
 =?utf-8?B?L05MWkFmY25FYWJvbGZ0a05WVDhpSFM1RzNmQXQyMUlyZklacWgwV1Y4c1Y4?=
 =?utf-8?B?VlBlLzhuWE50ZWE3R0hZWUo0K2dUaXgrcjZPVEdvMzlmVndHZG9WZXEwb2NY?=
 =?utf-8?B?V3ZWbVF5aVhKWGpZdUhBUE5OcFd1MW1yRnUwOXNnMCt1djFieVlvZVZ0SS9u?=
 =?utf-8?B?cDE3WEF2eXZOK1FDdmxjSzhvT1h6NzNRRFMzUWNWY1RvS2gwMmordkE3VGdl?=
 =?utf-8?B?ZzFmVWpyRmt3ZjEvNllwZEEyT2VyZ2tSeGVmRmpqVXBsR1REamhSbUFXbmlB?=
 =?utf-8?B?M1k2ZnYrcVdSUThlMVpzRitLWEpRcldEczQzWjVWcmxESEpEWlVJNDhtRURJ?=
 =?utf-8?B?TDA5OFFIcUl6RjRWM3cvSTdFTmJjdkkrRExMSmw0QXpYUUVLZFlRMk0wMFVK?=
 =?utf-8?B?Y1FBSGlSeHRWMDB3V0ZWR01vZFgzVjF3Lyt0c3lnbURscis4ZktSOUtDaWtE?=
 =?utf-8?Q?7LUfbzfZJtKW4xiWwbiP4z2bJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270734f4-ec80-4732-2306-08dc965c501c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 03:50:40.7545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOiZtx9FjJX1mNRe5FT/MKg/6iUOk2qYhGP9RZu3nIlPdToVOi24t24/x4gxVRowvgihywApyvr7icB0etg0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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

On 6/26/2024 16:45, Alex Deucher wrote:
> This is a big structure so use vmalloc as malloc can
> fail when there is memory pressure.

vmalloc can be a bit slower, but I think it's fine for this context and 
better to handle memory pressure more nicely.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3454
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 5d4f831b1e55..080c1d5f7412 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1491,9 +1491,10 @@ int pre_validate_dsc(struct drm_atomic_state *state,
>   	 * from dm_state->context.
>   	 */
>   
> -	local_dc_state = kmemdup(dm_state->context, sizeof(struct dc_state), GFP_KERNEL);
> +	local_dc_state = vmalloc(sizeof(struct dc_state));
>   	if (!local_dc_state)
>   		return -ENOMEM;
> +	memcpy(local_dc_state, dm_state->context, sizeof(struct dc_state));
>   
>   	for (i = 0; i < local_dc_state->stream_count; i++) {
>   		struct dc_stream_state *stream = dm_state->context->streams[i];
> @@ -1563,7 +1564,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
>   			dc_stream_release(local_dc_state->streams[i]);
>   	}
>   
> -	kfree(local_dc_state);
> +	vfree(local_dc_state);
>   
>   	return ret;
>   }

