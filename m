Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BA2C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 19:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD9993EAE;
	Tue,  5 Jul 2022 19:53:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574EF93EE8
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 19:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETs3JYmo3IDqHRm4/KP4d5GXJ0VvNoR1OjEfZv7cTQwag/cnJEE1nFRh818rxWGSkk5kV0Fd5QmWlWhlktLJuL8jts7QhBqBnXNWVVu1hE1bpA433qPF5eX4ah2DXdcbcm/SptjyintNqmUmuM00CO/U3GSUVpNznFDckQ25OMZMOqUoJojQrf09SPa5q91ZYWgbnD5EFs7quOAKxFhDVcMyNdU0LKZz+JrZD4ybxJUp5fVwc7DvnyTyYzFYIkTWUGeeRfnhtO+S4qFto4YHvnC4MonGPAkwb/Agu8HCiVpzJv3ESZWgk3ZQ2X2yCBWxzTZ2oQ/6OEdGLY2KsVPAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il4nhDwOKU2FO4dgfcOPu3LFLIo17N5dOi+TKdlOl5s=;
 b=OV+LPXqno31BcLigoGzkUAR3S3DeGGK6PNL2fIj2ICFgah52eBLCmJCMO1N6vgugXxRZWp3fVtRI5bVODef/hZbiVkZpHPHLft1oFlBaCrPyCrQXnW6e6ZrkbwrBgVZJfPRWhJ6kH6IMAMrEwCZIt8LR1jO0RyGJGcOg8d6TD64XEEp72BKE4Y+BghmGfNaIZc7aJr07iMZx6kR/HFaFeAowj5y5LMiFs3/ULuuwA9Y0tTF+t406+8JHgWMnySzUdD+987FSHn5BbQ4FoOV+AalRlB00Vx1xBtYWwOz5MCHS9Y9hd5etZ2moWqY8yzUS1vQAMVbr9anbSjqdCgrFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il4nhDwOKU2FO4dgfcOPu3LFLIo17N5dOi+TKdlOl5s=;
 b=FDA2129B3a8nrMi8OudS4oKuSGBpAtNBy7f4xF2Er76OzLutc1aYJWTwjDrY+dIA6khnCilOGXE9dtSmvU2HRI6Udg6yTKqCab1Wlyrox//y4t+wAYlNGeI4VDvJZukb5fZLqjZUDoGYy97uFKoaaUO5UDdFvLdwzxzaLMZnbU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MWHPR1201MB0094.namprd12.prod.outlook.com (2603:10b6:301:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 19:53:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc%3]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:53:39 +0000
Message-ID: <3c8f371e-bd5c-3df3-cf25-96b2c81868ee@amd.com>
Date: Tue, 5 Jul 2022 15:53:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, alexdeucher@gmail.com,
 amd-gfx@lists.freedesktop.org
References: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9394fb15-1122-4c22-5014-08da5ec00e3e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0094:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Odrp8x9cCVvy3ft6f6OVCtMjN1bd2uF9LhBlNTWmwsGJcq0M3LOb2BDVA1HXPu2ME7Q0sj8e7KaD4Rm97iRzyS7thzLqaDhow3OVapqPYD7PkldDyf4yYsXIHUF1WFU4Fq2KBWuLA05xPDpHgikOMAZvryoGd8O5bkEOdAlCnuRc0+6cf9sFPebYXpoDJNYiq9tBmxuavm8UjQFNSc8IqgxiWzPOJIbyH7bM7Iuh7SVYGMwQIlRH112AgtOMgnLpsqd/Rx4Jk3dL5sZyPrl0TljmWhDf2riEBU9arSgT9j9FHSLPuGvlXWmvTaMZ6J6H1sFA1PcSx6rT+l571bOuGGDYkgvQvmWMPasGFBfTe2FXwI6AxdouUioBBOmuGaodgXbZ0BBlLSAGf1VduHbFN0t3Z88ec1YALHWjah28thoscCj1S2xfQU50MHzzSceJ/OTrtx/GQitDjXLVMapmfUMRWud/TP4sOFP8SuyhjvKQsA2hOOx1XWW4AqcweW29z5J4xQ7fxyhHPVHFN764vlMTuZLmdVcQR6pEm2ZoFzbAr0iiDjJeGAZ8kujv3JkyQsTa5gl8ogTOvxFFlBCkeS0fcb2q0ZvEpmbDm2kF+4WOhE1V7T2oAUc3F1HlGHOfEpd5IAR/7QYbRqhfrGkoCRAVEdv3XUhyLuDfhIJUkZXGdJo8k5THwvEkd9rh8ibkUTtd+uePmndCAAbWyg+d8nua3IygbJwYawoJODWG7tkY7ewIl9IghvuKZ0yUnAT7v3x2p1s8xvNSq+so8DFGtDeKnwXuV75OI+ayuBks3sK4BgC6wsov2SoBMIPuPYuP7J5ZPm+53TEdjzERUEICMs83KaZkQaRrYUuGwIqZtvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(6512007)(53546011)(26005)(31696002)(6506007)(86362001)(38100700002)(8936002)(186003)(41300700001)(2616005)(83380400001)(31686004)(66556008)(66476007)(66946007)(44832011)(316002)(8676002)(36756003)(2906002)(478600001)(5660300002)(6486002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEgvMVJOSjlJSXgzSG52OTBaU28wYUVONUhYUHM5eVNvT2FLeWNmNFJYS251?=
 =?utf-8?B?QnpTaTB4YWMvaHcwVnBMNk1kUng1c3dkMzdiTHlIdDJ5Qjg4cG9LYmlBMU5J?=
 =?utf-8?B?U25tM3JLY3RuVnhPemJDNEErdkdrcGcveHNBWjhmeW5VdjR2Y0I2TWUwS2xn?=
 =?utf-8?B?TFZ4bFl2MkNmNk5lbnRBbEJGMXFRWlBlc0F1YTJ6cVBPWm8zZmdmcU13QnBP?=
 =?utf-8?B?WjRxdEJ5alIrT1ZvSEYxNjNCNDNLNUZURWtiL3pLQk9uSk9GRVQ1d0pyWDF5?=
 =?utf-8?B?cnpOYlZTekVIRmc3Wm0wTkRmZWlQSWdKZlY0cjhpZTBjdDBuaGFGRGJPcFRi?=
 =?utf-8?B?L3hlRzYzMkgzYzNzZGFTRlFkK2U3QVEybXNzamRTTkQySlVxcGR0eEFMR2xs?=
 =?utf-8?B?eEF0Q0tUZ0VCQXpIVnNkeStwc1VTWGw2N3p2U1dDS3YydnJyNXkwZFhRYTV2?=
 =?utf-8?B?MjNZQm5GeDE0ZjJ3Um1SdjBtR1VreXpnS3Rzd3ZpM0YvOWZBL2hKN2NmNkVi?=
 =?utf-8?B?cVBhM1hmM004MVgxcHlWV1ZrMXJDNTgrN29tbFNwdnRMSlZvUDV3TzRsUWNz?=
 =?utf-8?B?NVdzR0pRMUNicTQvSTk1ZlZTNkJKWW1UeFRlSnR6TVBoYTFHdjlVRE5VVnpL?=
 =?utf-8?B?aWdocUZCdy90Q3BBYkZvL2FRcjFsS0dtYVZJTDh2WHdUZitHd3d2aWRvTzdG?=
 =?utf-8?B?VDcwU2NQZ1d4c1V6alFRRFNyK2F2YmVLT2psQ3FNeE44bExSaXdYdnl6OERW?=
 =?utf-8?B?R015Nk1TV3R5UnhxSHBFeGZpQkhDNklSdVh5Y083dVR6K2h4ODZBQjBDRHRL?=
 =?utf-8?B?NDk3bjBGOWdPUm8xTmJDdVFpY1Y3dUE4Q21RMTROb0ovbUREK0ljZ0Z3VjZG?=
 =?utf-8?B?YjBLOWtmUjA1OU1Qc0ovNzJhN1VZTDMyWXFjcUswWWEzTVRsV3RXcjdwMEVZ?=
 =?utf-8?B?TytrTVJVK0UrTUd4NTJoSGxnMzlUU09XU1NUV2c2TXJwbFlORDVscDRzRFcw?=
 =?utf-8?B?N1hKdXJpRURHMFE2NFd3aXRSZWtRUXIrM3pCMDBWRE1sY0grVnNyOWhURGVY?=
 =?utf-8?B?biswSzlrRjdqNE9Fd20ydEZDai9HemFkKzlBbmhKKy8zK0ZNZmhFZzVtWDFZ?=
 =?utf-8?B?UktRbFlNdHZ3MEo1bnFIYnlqYlJNT2Y3bGZseHAvbmVYV1pXa2VkVWE2RGJz?=
 =?utf-8?B?NHAxaysvaGxVdVFqY0thZHNKUyszVW9FQjZ0STZUY3RsM0FuNFlLWWI0Vmha?=
 =?utf-8?B?bWdtM0s1WWNKalVOVnBtOTRzeThXTW14Mk81azFkQzFsQmlUSWE0WGw0L1Jj?=
 =?utf-8?B?VjZrdktBTUdaa3BaSXNKMWx4Ty8wRVRXbURkVGJUaytIVW1nT3hTakJJMklP?=
 =?utf-8?B?eWxDSU1PTklVUjFSNkI3bHgwakJndTUzK2Y2WUhIakk1NUhHRmZhbGdid3VR?=
 =?utf-8?B?c2svNnpUZTlqR1ZHdGJxSG9FaU9VTDlPZEg2SEZ6Mi9DcnlPVmFrbjdUTXMv?=
 =?utf-8?B?bTZtU0RTTVIyL01mTWN2NnlhNXZwem9lOE1idWhYMVZoZVFxSmpvVkJOcnpG?=
 =?utf-8?B?ZUNmR1ZwcVA0Ry8yeTFQL1BCVUROYkJPZDZQakZEQndmVStJV0V3aGhweTZw?=
 =?utf-8?B?UmVaZWN0Rk11c2o4SHZHSHpoRWJjVUZWYy9GT2txNjdVVEZDQmttVmtpbXVQ?=
 =?utf-8?B?VjNydXRteWhTbzVPSGNIVjFwZElXU0V2WmovNW0yT0c1M3RUSE9mSHl6Q2JU?=
 =?utf-8?B?NGVlaU42cE5pbmJxRnBpcDhDdUVjRmg1V3VLdXVXTnJlK0poUjJaMWpqM0FS?=
 =?utf-8?B?UzdZTTJ1a082dGNESGxVTnA4dis1eElxcU9saG5QVllGTElMMDJ4ZVpnMk1W?=
 =?utf-8?B?Zk9Uamd0K1NjUG5WNEtsRmluMHg3Z2ZSNXA5SVhoWFlXREFKRFY3LzA0aEN5?=
 =?utf-8?B?OEdBdGtOWE9ESGpoRXdSMlFsVUdPak9qOGFXYWl1ZEI0VkdRcmZjL2FDS0NI?=
 =?utf-8?B?b3haaVhtRXRMTEJGcHJqQ3NweEVaTlpYU0ExZlo3RlEyclJYSHFrSGJUcXI2?=
 =?utf-8?B?RnlpK0kvNnkvYXRyWEJWelV6bUQ0L1ZHbzFSM0dYbTZnOGpsRCt2eWs2Rnho?=
 =?utf-8?Q?Q0Nb7E2gexaNNx6TcytK5X1cj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394fb15-1122-4c22-5014-08da5ec00e3e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:53:39.5960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rxAyL3le3AhvLaN0y2zzyPAB7biWTr/rgl8Rmj/YsbA74fba02qUu9ClE2bqU+rIO8VDQ9KlcuV5ZtlxQ9uqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0094
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



On 2022-06-28 17:26, Aurabindo Pillai wrote:
> [Why&How]
> Expose a new debugfs enum to force a subviewport memory clock switch
> to facilitate easy testing.
> 

Does this force a single switch? Or at regular intervals?

It would be useful to describe a bit better what it does.

> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Either way, since this is for debug purposes only this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c9145864ed2b..7a034ca95be2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
>  		adev->dm.dc->debug.disable_clock_gate = true;
>  
> +	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
> +		adev->dm.dc->debug.force_subvp_mclk_switch = true;
> +
>  	r = dm_dmub_hw_init(adev);
>  	if (r) {
>  		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index bcdf7453a403..b1c55dd7b498 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
>  	DC_DISABLE_DSC = 0x4,
>  	DC_DISABLE_CLOCK_GATING = 0x8,
>  	DC_DISABLE_PSR = 0x10,
> +	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>  };
>  
>  enum amd_dpm_forced_level;

