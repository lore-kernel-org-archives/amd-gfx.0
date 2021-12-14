Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B23FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 06:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B7F10E9A7;
	Tue, 14 Dec 2021 06:13:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1483510E9A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 06:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaVfqLoSCnmno3HA/0NMYop7h7vRHMm+H0jFpmLPm1l08YPEbHIgea+rFzy+iC/lXQ6HZo1PEs3t8keX4i41wG1T6dIE0nGm/Qxev4K5GIUyhObUbw38xraUiRQ4uv4jCjZve6SfMjNJ2LAYJJDQf+0T53LWuszrrGCW+eWzKVkBD5lW6BSc4l0ASPjaHCo/E5AZ3aYdfHchCmoYXpoT/KQySOowY5VEq3GxRdiy1aTWYlog3cRpcBp8lZBywrIgFbggk6lv0uJwi5Gj+rY7jYbh3DSBaxnW9fej87jef4HOBEMI6LxGzZNFDcxh7QUhUOUGEeCbGJEYocJYU2dbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD6k4pjq6t6WAPUYTYPhPOPDAfBKDm9BQdA/VHMOjCA=;
 b=lG/p0cvj4ValnfjohrbSV4XLG8vHIdEzzVajnlT74Le8JL5ROpIz1DotC13kl7INQSERwE1ZtqKR+Xlsb2bJI9nSBg/ZVI2Jwu4qJ8w2V8btroGwwcc8bXyF9k/5qjowQH3lq0FeeKdbjNKvylmi4/EW4YSbyiKp2cOgqjC+4AGDJQy/B91yWitYtGU9/+/V267M9jIOLo616HmFgEsgJHK5u1A7H8g9yht1i1cWImov39xPy8OupCgeq+MlVmzwVDhVYXAnH60XtRoUdniJ6qzrV7SJ/DpHDSEDnWdLhyzZ95cP1V3PwphkyEFZbAXhoz6i36rnmhDYPt7AWdUP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD6k4pjq6t6WAPUYTYPhPOPDAfBKDm9BQdA/VHMOjCA=;
 b=RGXrm7wzHT6+4Z0xPuLw2yVl4CixkpOEocs09ZNUpp3SeO7zJMirdsmraEuzefDwzyY6GX4O+dowf0g+ZuJnSMBa2szmfTv+P8Zv5352ilR00TqJfTygw0Ry/f59HGatW9oGhzr7BBuMa5ox7QHuV/U4DcaNyF89+YcA5l4nUMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Tue, 14 Dec 2021 06:13:04 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 06:13:04 +0000
Message-ID: <c3d79f6c-b0f1-bc2b-ab80-30a8db11f140@amd.com>
Date: Tue, 14 Dec 2021 11:42:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211214013423.801735-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211214013423.801735-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f18e4760-23ce-4418-7000-08d9bec8ca0e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1516059D86C13B7D81E3369097759@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odc71Ae0u5MQGh8rBw0jU/CvtT65BEVB3WPCqftEuZ0qRfKSb+V61s2eGVhDG0t7qb19zF9BFSgAQtn8XgSfd9boinKMirZYYFPuchYt//lD8gWbKlhCCx11Wm2IsVcoIT3oSMTsy2ZMd+JSNFdg3PDvqlzrF99hriAhA0zsraM63YMGHW2IG4puHdkrmFU706OkPznEOHX5jNO+C4gb8vXCZbAC+Bb2ZDuenaB/jICKvPPdRPN+eSwpD4qCq2+iXGHswL4g54BdVDzxF3cK9FL15PrBgO3zOuCXGMt8J/OMwFp3oPZzcodFCvydq57MhQHuDAl5cPGLpnGCrFeBJtwxjzBhuEi2mpuKCqqWj9jlONFA1twDQfXjagOiy4MMqpADkPPKWM9Nc953BTKmxi/0QeBEg6SF/mLct6v4MVgPhPpVcL27Cm8Z8LtXbkoPydSeu0USS6oek92VJkA7rcowMaQtb7+xfyjFinHmh72zkJiLfuAoJGopQsX/31l7qUIYX5mn08kDaqUwGc0V7q+9sGgIk8KFVuvOQYWReyq0ehvcvdlcM0Z87dW8BWy0oMA86h3jys1+/XuqRkdikavrCVhcDArvGLoQQOH3B4B6MEPVaJ/1gsOLSQhU6g5iuxJaYPJImyboXmBxkmTNB4byhQh8JzNrMaIxVNaQSiqXTZU83gYAIqppZOz2ewCPAcJozFwQtu5K5Ww5PLqSP8+KxqrYTbmnyYXxe4ekV10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(5660300002)(31696002)(8676002)(186003)(966005)(6486002)(508600001)(4326008)(6512007)(66946007)(2906002)(6506007)(83380400001)(86362001)(8936002)(66556008)(53546011)(36756003)(66476007)(38100700002)(316002)(2616005)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZ4aHRFdll4SnhKdDFtT2h2MmlEaDVPWlkzdWVEemNhTUhPb2w5ZU9mUnFK?=
 =?utf-8?B?Nk1UVmRaRWEyTE5ZVW8xamw5WFNUd1EvSXpsbW1Bdnp1a0hxOHBHeEVUV0Z1?=
 =?utf-8?B?d1dLZk5icWxGK1NkdlhLdkFWMElkMTFsQ0cwT1A2eGV4YWF2KzlmMzVUeXR4?=
 =?utf-8?B?SWMwOHJSNkhoTXpaeVhHOUxmRTRGeXNOWUlEdFRsTWdacTFpbkFxemdjK0V1?=
 =?utf-8?B?U2lLMlFxMzhRSzk4M2tRc3UxQlBDRWc5RDgxRlZhMHpCTzVpOHFWSHBjTytv?=
 =?utf-8?B?Y0t2TzUwRHRTbVJCL2FIZlV5UURCSHZ0QVpxZkFSZGVyNFI4ZllGQzUrY0xY?=
 =?utf-8?B?cUppUUNaQ2FkYzg2bGNOWlJoVGF5SEFnV2l5bTF1cHFBSzNSUUlmUlgvNEYr?=
 =?utf-8?B?UVBUQjBQS0NDU1UxWnVPNHNsUkZTem5EM0paQ0VYRjJOUVU4bWtzU05qUHpw?=
 =?utf-8?B?bVQ3WmE4OW11c1hNVjVGMGQ5Y3dobDhjamN6Zlh3N1hGTitSdGIyakhSYjJZ?=
 =?utf-8?B?KzhjdlJ0MjNFem83U25CN0t6U3BNaFAyOVhWWlFEQzY0VGk1NWE0cnNIMWZP?=
 =?utf-8?B?SnlYUGZNV01WZmJadjFpNkY3WHdkVkJTeFFOYi94R2JGL2FVaTltcXhCZkZi?=
 =?utf-8?B?MU43TmtWMnFlYkNTWTlESk4zR3A4OVFVeUJPNHpGcGozQWVaZHFBUEx2VGpF?=
 =?utf-8?B?bUM0eEZwSDBoZ25XY25VMVdFVVdlUzBVbFlOTXFBVVhWNWhVL1pYWFhsTyto?=
 =?utf-8?B?TmlCSm9kUWV4eTFGekdNVmdkS0FORmc0TVVsSXA3YWhPNm5xNmxOZzhPSWRY?=
 =?utf-8?B?MEdFRU5idkVsSnoyVTFhMUVyandUV1M1MGFheVlrSmxvajVuYjc0U0cyTjhw?=
 =?utf-8?B?YVk4TVYwSXQ1MWZaa21HeUttWVBKb3l6V2hTcEkrSTliWHZZdlYrLzJUajFj?=
 =?utf-8?B?NVplSTk2K3R0cmFHTU5uamV4OVBxVUtzWWY3UXFJUE8xbXU1ODVaQXAyVTFU?=
 =?utf-8?B?cjZoZzF5SEI2dWswV2JCVFJPVHlzTXVIajVlQnVNRVh1NzgxaTBxU3hGbGYr?=
 =?utf-8?B?RGpNM2dYalhPcXdyNmYrdHJBcnZ4QWJsd1Q4VXlwdHRjQS9Cd2ZXVGpQWXdG?=
 =?utf-8?B?b2k1N1pJaU5yOG16WWIyVkNGVzFncVZhaGRZQWZ6cEU5RDQxMmN2dVlNUTJh?=
 =?utf-8?B?N3Q0aEJpeEtucDJrblFPUTJxYWlJc21qMWVNWmk4cnVBZUI1OS90V3UrYmpL?=
 =?utf-8?B?U25HTXhDVkd2Qmh6cURTUE5vSHgvb1AwS2Vma0N2YVpYNjBqeU5GS2kxUnF0?=
 =?utf-8?B?ZHJBLzJCYmhhckY0TzBoNms3QXQyU3I2d1l1S2ZQbWNvMVRlWWhnNEN4ZUtF?=
 =?utf-8?B?eVA4YXYyTEppZGQ1SERLdFVxQ2J4RGlGSklhTE9lR0t5TW5VWGRxL2lWQVBS?=
 =?utf-8?B?ejUzQlVlM0RsaWZGOTZpMURXa3c2OWZLeVNqUTdmRHhXbmFPNnF5UFJHcW5Z?=
 =?utf-8?B?Qk5NU0kwTzh4YTRDeW1yQ2M3NTBjL2lIeXEwOXhNb25MVTJ5cXVCZFNLUUZk?=
 =?utf-8?B?RkVwK1UvZEtEa2RLcU1DQTk4T1UwQmlOZllScGxaSmhmSWtHMU11c1VoYkpB?=
 =?utf-8?B?NE00L0xrOFZ6OEdBUURhTytwaUNRaTNUZ2N0aUtRbSswa2pWZTJvVm8wU244?=
 =?utf-8?B?N2NjZHR2MjQxN0d0UGd3Zm44S01BeTBuY0VOWFB0RVFsSDJEMGtCWW8rMjRV?=
 =?utf-8?B?UE9MdXZORXlnUWF4ZWVkMFdOV0xYOE9Md2t2RnRuSjc1YmxrTkszcG11U0Iv?=
 =?utf-8?B?eTdZUWRvT2dmTUVxZTN6UzM4ZlVpMlZhR3pOd3orNlhZQThON2tXdFczK21l?=
 =?utf-8?B?MmJyNW1OM21LUmt6YlNtSDZXZndWcGo1N3U3aVBGcXRrWTZYemZ3MWxPTWZI?=
 =?utf-8?B?d1oxOFFZUmgzQXpOd0NUbENRSnp0QnF0eFJ5ODB1WnBhZTl3cW5oRmxvWG1a?=
 =?utf-8?B?ZHhtcWE1UTBaeWExbnRjWlNnWmtQMGdnbTNxR0RHTGprZVM5Q1NDc0k1c2ZU?=
 =?utf-8?B?endMOGhwTWg1NHNIdkxhclIzRnVaZ205M1paaTVHenZVbUNkOFc3akhYeEU0?=
 =?utf-8?Q?qN70=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18e4760-23ce-4418-7000-08d9bec8ca0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 06:13:04.6433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwd1SeJQb9ajvRExw2nlral3k/bl5n5Jo3bvFHPOYdeRICeuUUJmAA1DSEJaf3SA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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
Cc: Alexander.Deucher@amd.com, Mario.Limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/14/2021 7:04 AM, Evan Quan wrote:
> Pair the operations did in GMC ->hw_init and ->hw_fini. That
> can help to maintain correct cached state for GMC and avoid
> unintention gate operation dropping due to wrong cached state.
> 
> BUG: https://gitlab.freedesktop.org/drm/amd/-/issues/1828
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I9976672a64464b86bb45eed0c25c9599d3bb4c06
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          | 8 ++++----
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 7 ++++++-
>   3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index db2ec84f7237..c7492db3e189 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1809,6 +1809,14 @@ static int gmc_v9_0_hw_fini(void *handle)
>   		return 0;
>   	}
>   
> +	/*
> +	 * Pair the operations did in gmc_v9_0_hw_init and thus maintain
> +	 * a correct cached state for GMC. Otherwise, the "gate" again
> +	 * operation on S3 resuming will fail due to wrong cached state.
> +	 */
> +	if (adev->mmhub.funcs->update_power_gating)
> +		adev->mmhub.funcs->update_power_gating(adev, false);
> +
>   	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index b3bede1dc41d..1da2ec692057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -301,10 +301,10 @@ static void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
>   	if (amdgpu_sriov_vf(adev))
>   		return;
>   
> -	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
> -		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GMC, true);
> -
> -	}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
> +		amdgpu_dpm_set_powergating_by_smu(adev,
> +						  AMD_IP_BLOCK_TYPE_GMC,
> +						  enable);
>   }
>   
>   static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 3656a77baea4..9953a77cb987 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1167,7 +1167,12 @@ static int pp_set_powergating_by_smu(void *handle,
>   		pp_dpm_powergate_vce(handle, gate);
>   		break;
>   	case AMD_IP_BLOCK_TYPE_GMC:
> -		pp_dpm_powergate_mmhub(handle);
> +		/*
> +		 * For now, this is only used on PICASSO.
> +		 * And only "gate" operation is supported.
> +		 */
> +		if (gate)
> +			pp_dpm_powergate_mmhub(handle);

This is a generic entry point. Would rather keep PG enable or disable 
supported in mmhub_v1_0 rather than than here. And this comment also 
should be in mmhub_v1_0.

Thanks,
Lijo

>   		break;
>   	case AMD_IP_BLOCK_TYPE_GFX:
>   		ret = pp_dpm_powergate_gfx(handle, gate);
> 
