Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B459CD4857
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 18:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F5D10E2CB;
	Mon, 25 Sep 2023 18:33:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDA210E2CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 18:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XozaKHORdilcWHpEMioJmiLfZsW5Q/4noFYomFJe1DyZU65RjsTaQ3SB/0rueSPZEt8zIBBFQR8FLfMjKwqhOYi2qMT1KztO8KIqr17wFT4nsuXs90YyXsiLyevDJn3UY4s365L4W899Ko34ocUTPlPiSeaefmXgoE7o3xAjcG+0BVeWUmdMpR/h8jMGATBKCJ1AtNcIDiFnMpQwydVcauERM0gfPsfvPFUi4LNHKPxYOVCks7t4+I50dqk+FIyPjmJrSPI2bGhS905inTr2UtHklaU1l0V4scORtZI4yYLyXbcjHid/3EGuMWTHOKmh2w8zu3Z6eBZkOCGZP+svow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATtJf73cBDIkCkg64nlqZWNDeJm981+2FyHfkdNPRow=;
 b=SYwxsxj/4v5mEI8cO6/86Ta4aPbWwmg/iFxVI2BY5ZkIwX8SRmnS+jzIfQTDjYgZIDY7cHGqUreBpmfUtpTXN0We0DzkAf2WNUT09LcT0XjdCBtEBXapeTREAYO1znX5gqVysptRszVYrRym0ndoAsVgfQWK8I4ZbyXVLebFdfsYpDd+mXYk3MOHRxXPc0dCr4/dtfMQ4TfV5IPBOzur09HRw+FAkp81J/MeE9it0ynYRK+MFMDmHZRlUq8GTliDdwH4ZjdYsZiER2K2Z2uX72sE5l/3eeTs1fXWzPRByRHO9s4cTnS0xcerRy8LoCGbwLC/aalvxjRZxgjSyi/7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATtJf73cBDIkCkg64nlqZWNDeJm981+2FyHfkdNPRow=;
 b=ZX8lkSyKvN6u2nZzL9oTju/8KNoRBqaByTcdQVNpf1qLdRCr13aAlJEcU4oQrcBZFa2VKKRHbld0a9f+RbbsL+VamU4LejkO6KuiE8lo5CViCHx3sRPmbpSDHtmpIkHF8IofzMAd8665n27R7Emnioyj7y3jv+3/DpYYn04W7ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 18:33:07 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 18:33:07 +0000
Message-ID: <856f9216-62cb-425f-9875-322b89b529e6@amd.com>
Date: Mon, 25 Sep 2023 14:33:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Change dc_set_power_state() to bool
 instead of int
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230925182407.109250-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230925182407.109250-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6570c0-39b0-4970-e91d-08dbbdf5dcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGlefKaB1LyHfupVD5IH5/XFSemwPPgR++vM1q2kLoI1khOKc+UMr0y7kZl0MtB3jVgqRgqtw3OPTryU7Cc/f3JnQOXJ2YpB86s6XZoNXFt1wMGWXDQtYYQ1ydANQxDZ7t+Wpk1Cp2WD6ICvp6LgsCLUXbnQ+ybIEmOurpXbd4FTwd1g8DC1xaZ95loAV+o9C8a9yyooaoUso0aNioVeRtaTUml66IBNWHTi/ORFhWGNSzeb0XC1A9O4nW5pJoo/GkKRLDITWub+8QiIVF6iJMqzzv5K1JtzUu2vujwbKIfq4XW2TbfHhKPFyqzDQI2QbRli4SGZSqEq7TOqzs/zbdzrXQ9C84YOBUgl/jiZb8fG2VbqODQzOnIX5+Z+l+gwC28Cc4xrk10Fw3Cu4Eve1S7mBB9Poa/sdBAjXzUR90yVM8zBjsFDF51jLGY25vl7eb8+1m9WxsMXvXMpAEQM0pCzjV/IBCcawTWTNg+eUFLKy6yXp47aLQskgTwi+dJsJecdsJsAbLqPKTLpvPa0ylj0BJWlonVBfvs5pEUaChyIKh95HZNCP11eSekwxwQqYN75Kh7YkHnCECpxHRlc0MmVh4BV/ysi47xydKTmhOmmGR1ue88pKYPJG24lDYwP6/XU3mxfXBfCGH18706kNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(478600001)(86362001)(41300700001)(31696002)(31686004)(6506007)(38100700002)(6512007)(6666004)(6486002)(53546011)(26005)(2616005)(36756003)(83380400001)(66556008)(66946007)(316002)(66476007)(2906002)(44832011)(5660300002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxBQWJYN1NMdDliUmNpOWNFN2NZcVJ5ajhNZ2NCdlhyeU5GTTVXVkVVemZ3?=
 =?utf-8?B?c0NrOUQ1K294NEZqbkNGcWlka0NjTkNTY0NjcWY3M0VLTUpWZGNkREExYXdn?=
 =?utf-8?B?UnVEUkNIYmpwUFNENGVvNnB1elljaURLT2gwK1ZGWGw5Rkx2NEN5UTRuNDh0?=
 =?utf-8?B?M0JGc01UUFBLQ3lDSzMyVzVjRXMxai9mR0tUWGc2aUk2eE5Bd2JTNXlQdzFr?=
 =?utf-8?B?bHhVakRCNEZDd0JDYjJnZVhNNCtaT0IxRGtOWHpaZVFMdUlhNTBDK2pvM2lO?=
 =?utf-8?B?eHpyVnRDdWc4QkliZWRnSlVtSkVJT3RHQ2QxN2VLK0ZOZHc3Sk0wS0plak9s?=
 =?utf-8?B?b1RnOURjYVY4RXo4ZHpFUTBsak9vT0I2UGtpZFFSWnRKNGF5dGJlWmtzR1NX?=
 =?utf-8?B?ZUlCTlBoMi9nemFVd3ppNVZiWitPZXlvL1o1N0hSOHBySXR0dmlKbHIzeVRO?=
 =?utf-8?B?TzBEcWFWQTNJV3Z0TDdma1B5YXZ2UlpGbE1OT2Y1Y0hCVUNFc2hLYlRWQitF?=
 =?utf-8?B?MmcwQ0Rqc1ZOREVuS3NpaGN1cGhHWE9rRWs1bEI4dFdoYzF1c2tHejRHY0hH?=
 =?utf-8?B?OFpaZW52S0JFakxHSTJLMDRjMXYvVGc4bmZUaVdWR1N5dDg2L0wzY1Q4ZFUy?=
 =?utf-8?B?SmtHYkZUZTlNS2U4eXNob2YzTHlNYkkzTHg0N0FpdS9CdDFRUUpzWTFQUXI5?=
 =?utf-8?B?WklGbWI0eWR3bXR0N0RVMGdXeEEyY0l0eXdqY2JIdlVzUXRQSjJIcHVZc21a?=
 =?utf-8?B?eUV0UzFUZy93Yk1lVkJuczdJcHNjcmNFNVFlUlpHSzJ6NTBrOFFCa3pORk80?=
 =?utf-8?B?aXpld01CdUs3b1MvcUIxaW5NZnBCNGpVRGl2QjdpVUhlS2pVM3kyRWtvK0pN?=
 =?utf-8?B?TUhLaUFHL1huRG52T0Q4bkVqQ3M1U2xPcEx0UGlZbm5zaUh5RkxDSkdteXdL?=
 =?utf-8?B?UW1lZmdtbnJRNGZsWkJsZDA0WjdWWTdwbXJ2disxRS9XV1A0YzFJU0VYdnli?=
 =?utf-8?B?Q1BqY3I5NjRVK0Z5TG0wMFF1S0QwdnhTSEMvbFJTcjk3dHBDVUQ0RDF0bEY3?=
 =?utf-8?B?VFk3V05WRkk1cFYrcTRTaE5XcFBqTzlxbkQ2WldVR3NpcmlRQmtjTVlhazZt?=
 =?utf-8?B?WU53dUlheXE4TmRnUmZjNUE2aHFQSlRkeEptbGEyQnhiNVptdTlGZFFwdFhR?=
 =?utf-8?B?RWJIaTNoaWFjZHg1cTl4RHJmRDZGNFkxUTdsTTMwK0RCRnl0MmZDaUhBLzVW?=
 =?utf-8?B?ckt5NHJCQXYvb05nbytQWmJLdWNOdGJsWjZPM2xuTFpsL0NtRW5FVUp6TWNY?=
 =?utf-8?B?ZVFveFhKVmpnMllqR0R6MWlaUGtZRXZxcnlscnhUVEN6Q21aL3FCdWVIM1Fo?=
 =?utf-8?B?S0lnaFpwaWN1cW8xeEU1OEpIWDhxZEYxdTJVY1Y1a1ZPaFFmOGNGdjRZS0ti?=
 =?utf-8?B?RWhNRnhJMkE2dVNBMkcrVERTb0hDbHE1U2QydkdpbXlhZ3hDMnpGR3cvc25B?=
 =?utf-8?B?ZTdua01CMnUvV2NtR0lrZnFIN2Joek1hc3o1UTdFQlhrVnN5ckF4U0NLU0lL?=
 =?utf-8?B?VmZIN29OWnpQNEJHMVBzRi91US9qMzJCZHNDd3d6LzBBcUZ3U3czUnROSnhL?=
 =?utf-8?B?clAyeG1GdnBEeGEzblZkQ2s0eTdUcjNuMFRWM1RyUjJqSDlBM0puSElMZ1lm?=
 =?utf-8?B?NWQ0WFcrRjFTWEJIUDJVZ2ZSSWozZ0s1dm41TjRsdUdXZG5XUGZKU3lObWdo?=
 =?utf-8?B?VVM3V2VKclhTNVhVbFI3VVF0UG1LZ2xQN0Y1VlZNNzlYQ2pSSWs3MVpmOW1a?=
 =?utf-8?B?M1VXaXJsT3NtR2liQjFPSDl0ZUozMXdvZ3F0VHhOZVE3clhzUGI3bGpTTHY0?=
 =?utf-8?B?ejNkbWJsbWpRTU93NXg1YkJkLzNLa2thcFdENWhVQnBxc1RXdFVZVldyN1hC?=
 =?utf-8?B?YW1sYXVRWDlrV2V4Ny9CMUh2Rm5mcWVzdFdkdVh1b0VtN1JtN0JFRWJOQ3pm?=
 =?utf-8?B?bjBzdzVQT0ltM0dKMG5DbllyNnk0Q3Z3bXQ4cFFKMXFNellSd2Y3bVlKbW51?=
 =?utf-8?B?VC9UNFFzRHJuMDZZazdjUkVUbEl2L3kzNlkwQktZOS90WUVRKzdpckNRYkVU?=
 =?utf-8?Q?6bnPUDm9gLhdrA3Rva3RwqjDW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6570c0-39b0-4970-e91d-08dbbdf5dcf7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:33:07.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qfg73ZsZTHqs79uzmZQRVw3Vhz2CyzAgLUETzadENpkIPUz/5kzOy1rWSzX5Y/jVS0J0qAWMEL/1dCwWhFfWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

On 2023-09-25 14:24, Mario Limonciello wrote:
> DC code is reused by other OSes and so Linux return codes don't
> make sense.  Change dc_set_power_state() to boolean and add a wrapper
> dm_set_power_state() to return a Linux error code for the memory
> allocation failure.
> 
> Suggested-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
>  drivers/gpu/drm/amd/display/dc/core/dc.c          |  8 ++++----
>  drivers/gpu/drm/amd/display/dc/dc.h               |  2 +-
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 58609a8cb49d..f06136a0bba9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2638,6 +2638,11 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
>  	}
>  }
>  
> +static int dm_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
> +{
> +	return dc_set_power_state(dc, power_state) ? 0 : -ENOMEM;
> +}
> +
>  static int dm_suspend(void *handle)
>  {
>  	struct amdgpu_device *adev = handle;
> @@ -2671,7 +2676,7 @@ static int dm_suspend(void *handle)
>  
>  	hpd_rx_irq_work_suspend(dm);
>  
> -	return dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> +	return dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>  }
>  
>  struct amdgpu_dm_connector *
> @@ -2865,7 +2870,7 @@ static int dm_resume(void *handle)
>  		if (r)
>  			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
>  
> -		r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +		r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>  		if (r)
>  			return r;
>  
> @@ -2917,7 +2922,7 @@ static int dm_resume(void *handle)
>  	}
>  
>  	/* power on hardware */
> -	r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +	r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 3b060e08707d..cb3cb2db90ee 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4723,7 +4723,7 @@ void dc_power_down_on_boot(struct dc *dc)
>  		dc->hwss.power_down_on_boot(dc);
>  }
>  
> -int dc_set_power_state(
> +bool dc_set_power_state(
>  	struct dc *dc,
>  	enum dc_acpi_cm_power_state power_state)
>  {
> @@ -4731,7 +4731,7 @@ int dc_set_power_state(
>  	struct display_mode_lib *dml;
>  
>  	if (!dc->current_state)
> -		return 0;
> +		return true;
>  
>  	switch (power_state) {
>  	case DC_ACPI_CM_POWER_STATE_D0:
> @@ -4758,7 +4758,7 @@ int dc_set_power_state(
>  
>  		ASSERT(dml);
>  		if (!dml)
> -			return -ENOMEM;
> +			return false;
>  
>  		/* Preserve refcount */
>  		refcount = dc->current_state->refcount;
> @@ -4777,7 +4777,7 @@ int dc_set_power_state(
>  		break;
>  	}
>  
> -	return 0;
> +	return true;
>  }
>  
>  void dc_resume(struct dc *dc)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index d30de81b4779..b140eb240ad7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2330,7 +2330,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
>  
>  /* Power Interfaces */
>  
> -int dc_set_power_state(
> +bool dc_set_power_state(
>  		struct dc *dc,
>  		enum dc_acpi_cm_power_state power_state);
>  void dc_resume(struct dc *dc);

