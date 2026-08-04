Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF33C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 20:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3481610E14F;
	Tue,  4 Aug 2026 20:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h0rLiq3G";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B960010E14F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 20:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TB1Og3zjy+MCgszO+SdvVemdxJ6Ais9I0cFrWgZQDMdbluCEwqP+VV9ZfO8idAgpTbiqYH/sIUlrCOvcphAXp8rMg/pj6f7AHvIYK5AV1Ab1bVbt5t9bdqZCztUEqaX4bFQlsrXzNAvlMI7Ix9afN+8tQQOvI9kqXn254Hvv0E1axNl14T3UCKa58BkgIsjhL4ASEbKA2bNtxJhwyY7O6XR2LxI3CfZLVTEAMqVIsu2Z877KfHyZGtdofScfJZsTEY3hbmti+Z/v+FgbwfJxiWOHAd08GPhoRSelsRd4jjYGYm914gGwBDxvJiXX+K3BBD0fG+O8j9/Tv3fxck+epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er7Ne1GntqEET00/Omi/h2xboV3SzdnNcRMJ+Stej6k=;
 b=raMpQiunLcmizy/Edm4xgXit61DvQ4hlr0MyUcxDXuzXp3Jyshi0qdAePtgi7/ZB3yjVYzRLZMoCGfOugJTtJ60blx3fFrutIuWQOXx9jnOlB0ubQSb2tyDF4TolVaktzROnw8chNYpuadFyOwmeU1oKUN8Cnkdo1q3OWzBsVaA2PwgxnS5MOxIGAMuoHutUYYk6nV3sQH65UrZDRHzFfxs61bG97/QzqmMHAZnFukcXmWVlrXhJP2cWy/3DCxaT+BBr/MzFSPxEXLWIbg4BbhvtinaE5geA1jLxL5rkcz5yjHG5kurcOlEKuZ6Alhe8F+bPLBF54+obcOF+D5RC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er7Ne1GntqEET00/Omi/h2xboV3SzdnNcRMJ+Stej6k=;
 b=h0rLiq3GU0SlIVEqvkDudMITo0AKye4vu1b+5s5kFHX1QQtOujs9abU+7pk5WM5ZTyOae8y2t5Y1O+eb7CY9V+D+mjSkubNrAGFXS4u7Y6F+RjTHdnZcMyrVyXCloMLaeFCjD7rJ43rN9ArAQNNmq8KmzSq/s5zlwRcMLoqk9jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 20:05:12 +0000
Received: from IA1PR12MB6114.namprd12.prod.outlook.com
 ([fe80::1273:26cf:eeaa:e2b3]) by IA1PR12MB6114.namprd12.prod.outlook.com
 ([fe80::1273:26cf:eeaa:e2b3%6]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 20:05:12 +0000
Message-ID: <480843ff-5c4d-4e4d-bf20-8675105eb4c7@amd.com>
Date: Tue, 4 Aug 2026 16:05:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Set native cursor mode for disabled
 CRTCs again
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tomasz Siemek <tomasz.siemek@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
References: <20260803124533.19375-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Ivan Lipski <ivlipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260803124533.19375-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0312.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::24) To IA1PR12MB6114.namprd12.prod.outlook.com
 (2603:10b6:208:3ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6114:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 19520f6d-52d3-4ef0-3811-08def263b126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|921020|11063799006|56012099006|22082099003|18092099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Mjre1n8bkR5eYwtJNC6FoYjjXIv69ugYI7MAHaK1/VfMSQrBvm9ZaBblkiBuYwjgPkh5QcrGimyyrCt2JZJXp0ehthMk8JbmteAM252qY33juP4VFCMGIebHErfTiz/30DHegeXXC5NwBJ1Sn4l51bgLHUT8l74Jsp/AUE38Ss1DKLa7VVTKqy+5zuP0MmAQ4ysXlltpGtSSGMxYm/w2gFKBX6yKrdy/3g0XbaNz/pLX/NyzJxiKpJr1NQvqqEKZY7HkNqO6C6J3wqDDuILdzCyYbC08HcuEMssG9bGTdhoRZAxbS7L2eeo5d6jDkD/J+ldSESI11u23qG+Men8t65q29uSHu9Xjn/o409NSA57h1lhbHTiKY+/AdGZh9xk5xyYvVbCSdtOaeAKIwU+n3n9hXiralIM2F4n1cAC+st/RRQc3PuZKC4h3hm5OmDvvAEV3t2AY9mulT10YCxEpU2h8mDWqrVkSsAsGuZA/gfYpWQbbCT0IMPMSo5YMzeVNUnX8a5CvSQl8xuRZcFo2O/OeFHpQO/q3JzMLwc9s+6L32XqXoTiShtobaPImGvKQXKrj84VvFDB0sFzNsRQxPgXBDS2F4Xw1jsu8quYVxaxMCivzMZ+qIevPfbXnm4XkqpUuIVTgBi/cJ7kAlnc1kxFwLXPzQUJxEv0mrnlkhdxMtP3ca9MMSZ4dggSYmTfjQGzcCjuna9GGNpB0cPSV6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6114.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(921020)(11063799006)(56012099006)(22082099003)(18092099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2s4TEgxcTNnTVRPRGJlSjlEa09VMmVCWCtNZzlSQk9DbDNtQzFMeXpHTGpK?=
 =?utf-8?B?QytuVGdUdUUyaytUU01weHdLVDZiOEl0dTlmYThzR3E4WU1vOGorOEtXVDd0?=
 =?utf-8?B?ZVdxZmxuVXlCcTlUTzM5K3V1UDdCVFRBZklsOUJucngyQkFVRGVtRWJZdWpP?=
 =?utf-8?B?UXFKUmdiazBaK3l1Y2x1anowZmt3K3FWM2p0L2FERFpLSklwdXFYWW9lZmdm?=
 =?utf-8?B?UktMVnNueGg2TFVYVGtkVUd0S1VYcGRud3F0S1dCYi9ON0VWOS9FemlOZjJr?=
 =?utf-8?B?bVJPMmluUFNLVHdTakNhcUdYZVo4YTJJeG56ZndFUTlZVzRadHdoenlxWEox?=
 =?utf-8?B?anNKVTV3UEl3RThydFo2UWJpV1lEZ3h5UFl5R3dnNFAxZzBncVlnMFFUakgz?=
 =?utf-8?B?T1QyVC8zNVNGL3dCMzIzaXc0bmQvUk5YNStUZXZ3N3BJeTczdkxvbmFFWUw4?=
 =?utf-8?B?WHBFWmFBcGRXME1EaHBQbzRVMzVWUHl2ek9GWWM1cDJuMkxmUU12Sm93SER2?=
 =?utf-8?B?N3owR0dQUStZd2pYUkhPdXRqSXdWNWNrY0d1cnk3VkthdjBKbnpTeStCS1du?=
 =?utf-8?B?TFBoNU9zUjk3UmVSYndnNTd6Tk0wZzQ3K0VwN3BkNFBVcFZ4SlliQ3p4OG5n?=
 =?utf-8?B?a0phcGNXT2FRTlhjdkhXZHV5Mll3RndtY09oTnNDbjZiTGJ4MVk5ZVFSMmo3?=
 =?utf-8?B?cVIrZmt5bEhubnpmeDJzdDBLcnR3U0QrRXMreFV6K2JlQ1ROcklRYTJ1dk9x?=
 =?utf-8?B?b0UrTVM2UU1KQjk3Qm4zTjN0RzdCaTVvNmNnenNzNUpXeTFFbzNJbnNHc3M0?=
 =?utf-8?B?MkxLSnppVk5xVGo0Rk12MFhPTVhKN296NjNLbVl4NUNUa2RiYlViRS91bDQz?=
 =?utf-8?B?S29abmhTZzg2S2ZsaGxCdkNoeW93ekQ0cXRmT0lHeUs0bjFzVUMyMDNPMVlB?=
 =?utf-8?B?cXNiNWN6RmFLQUFBVVdJVmlTaGhaMEpxbDFiSnJBZ3NLMGFOdzl4K24zMHQw?=
 =?utf-8?B?dThCVm95S0paLzhTd1pVNVA0MjRQelcwRXE2R05NMkhDb3RXOFZzYkdqRmt6?=
 =?utf-8?B?YUUySFE5OTRhT3VWUlpUN3duUlJ0QlUxTU01eXI5dzNLQVNxUnJhQ2VQYVNQ?=
 =?utf-8?B?bzhVbjdQSlIrM1o1UDN6ZXVLSWp3amJRM3ZqOWlZMCszOElSdXFma1dNdENR?=
 =?utf-8?B?YzY0SElUZlRpczNJVjA2ZVpYZlZHTURpK01Icmt6ZVpTVVBNSURNUzMwNmI1?=
 =?utf-8?B?N0hYR3A5NWx1NS84czh4T0h3SGFTTjdOQkQ1MkppT0dEMkFVN0UvV2d5dEln?=
 =?utf-8?B?MFF3eVBGUkVXbTIwSjdjQmhVZUpBYzgxNGd4RittNmtwOGNvM3p4UmRCWDha?=
 =?utf-8?B?cW56aU5CMzg2U05KVUVsS3c3TjBVclU4VVd0MjdCbUc0SEF1c2J5Y0xCTmc3?=
 =?utf-8?B?R2gyK01HV1BTMzhDS2RIL3dZL1FQTFE4d0MrQkpSR05NcVJkUVMxU0ovbE5x?=
 =?utf-8?B?aXJtaHdoWVFMMVR1VHdONWxJNmg1eEVqVCtLVkJlOHhyalJoQlJHZkZEbmRi?=
 =?utf-8?B?TElpZ1lSWGFPNE9obXFvZWZ2Z2cwTjN4TUxtMzRzQXZlWnRHNnM5TWhHV1BQ?=
 =?utf-8?B?SWtTY2pNQzBab0ZWVmRHUTQ1QWl0K0hUT0l3dnppZXBVOElPRVh3dFpUYzRG?=
 =?utf-8?B?ZGI4RWE0M09ueW92RFY3WjNBWWs2ZDhWM0YrcVJ0ak56RTFLS0FMRWoxaFR5?=
 =?utf-8?B?V3p0TnlpWlVBd1BTMUQ4R0doUDN4NE10SGNCbGk5TlJRSUp2T2cxRGRjc04z?=
 =?utf-8?B?WnFDcVErTlRyekoraDhqL3ZsR1NTNjFNWHdIbTRqM0hTTmVIRVdmTnBCaEJK?=
 =?utf-8?B?ckpYV2hxK0dGT045VE9jT2IraXcxdE54c1U0akRpU3hndklzQ3A4WklkVklN?=
 =?utf-8?B?UkxHemJXbUJyaDdXUkVjbHJMRTA0NzVseDBKWGhBMEhUaEZzcHpENlp1aktH?=
 =?utf-8?B?SW0ybmJmVlhiNUF1TjdTMjJvUVRQQXFicUxXWUJ4eDAzTjNreGdOcUZJY3ps?=
 =?utf-8?B?aTVmRm85SFprZk1jSk8zMnpxSmNTZUNoRTJzRm92ZnoxOWhjLzAzNVhOak5o?=
 =?utf-8?B?eGcxOEpvVGdkOU44WEEwUEJNZzdmNlAxbk5WZjdXZlgwYXpZaFRRVXRSQWZZ?=
 =?utf-8?B?cW80WHgycmNNREwzSHc3WUZSVFVGejR4RkVOcnl3ejZyVmR5YTYrcWVvWTVZ?=
 =?utf-8?B?T1R3ZVA1bFJxek5mR2ptdUowVjE5cmg4dVRMRGl4VEpwWVVBQVdtcEhhOXpv?=
 =?utf-8?B?MVFGVGVrZFBBSTlIeFM2UnRmR3RISFBDZGx5QlpaK09KUmN5S2drQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19520f6d-52d3-4ef0-3811-08def263b126
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6114.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 20:05:12.3164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLDQqwDK5imVuYVsp8SZyGZ+7gdOPue+ls4VbYVITjdrBWwHu39iihUOQ1PyjM1R3GkuE7rbeZvyhBtYDFeMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
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


On 8/3/26 08:45, Timur Kristóf wrote:
> It was regressed by a refactor. Let's fix it again.
>
> Always set native cursor mode when the CRTC is disabled,
> to make sure it doesn't cause atomic commits to fail when
> they are trying to disable the CRTC.
Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>
>
> Fixes: 151164f96a4b ("drm/amd/display: add cursor module")
> Cc: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> index ab50d58896ab..d565433ea06d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> @@ -290,15 +290,20 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>   	/* Overlay cursor not supported on HW before DCN
>   	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
>   	 * as previous DCN generations, so enable native mode on DCN401/420
> +	 *
> +	 * Always set native cursor mode when the CRTC is disabled,
> +	 * to make sure it doesn't cause atomic commits to fail when
> +	 * they are trying to disable the CRTC.
>   	 */
>   	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
>   	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
>   #if defined(CONFIG_DRM_AMD_DC_DCN6_0)
>   	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0)) {
> +	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
>   #else
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1)) {
> +	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
>   #endif
> +	    !dm_crtc_state->base.enable) {
>   		*cursor_mode = DM_CURSOR_NATIVE_MODE;
>   		return 0;
>   	}

-- 
Thanks,
Ivan Lipski

