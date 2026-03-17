Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51848F33807
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCEB510E186;
	Tue, 17 Mar 2026 07:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5JwZj/sw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A9410E186
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoFf5ur7UKLl6zIqqYg+W27GI8uTsaeOdyJJTVVpBCmTcR6pUE5PKzx34M7/mt8kHw+yg0G4697eTX1bqQpqrdMqKbbOEIK40QbZXsmdoZTFFW3NVg4l+/brXVPY5PbIt/GUYhOJUjMpvQNKYes6sezL+iZHBjzf1xEPoQbHtcOant15zD49MGnIZv3TpgYpNaZON3fPXBEMj8E0Jb4thDumcdu+xWl7n1kPAGlZJtlZH3QlJs6SbSu8yzFWNorCLqFbWUOPqREXMWO4Lh6zXHN3Ly8BdIQb8Gonx1EzefWQtJpX9MJSmjpE+xVq1Tw7kzfxZKkBrY52+C1Xb3LrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr8TVHxbxazXoBcJVSpQMCNoimE0Rpgl8nJ6F/1CI1k=;
 b=d9VT5LgtwXIZExWSbt3onScM9G5hQg0PqCu8JxiGA+Ar700bEdnEviCQ+op+jBirNUDJZ78jJ7lvUsEjs8oqPP0TYiOueBnOdm8xUosZoraIdPKCCpIC0tdggPuuEEgr/0nF8dS1INPMbiHpkngk4GeE9XJ1ES9iMHDiXb95UwHkCWnVXfI70S+QIpNts0QnBlvTjEIzh9Y+1eyJr+kFMm86C++N1zJcBMz2Fqo3JZB8wU0MaWkV1GoMUbi1smrWO84Hiprs20P5CRKi0mjT8CnBlGxsbJgLIXZPCRvRslc+p9KnIKhc6Mglw0qXd1qS/uXJC+wCPQNSZSwNNCzL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr8TVHxbxazXoBcJVSpQMCNoimE0Rpgl8nJ6F/1CI1k=;
 b=5JwZj/sw632kidH6T9SuFwJfAfKAzWTGlK0zGlwcHx8xAQvUZUrU8fHbvMsSTAsaduF/I824EJ8R8gZXZ5CKwTX1kwI9r+yd80QBAHOsea/wzS6RjKLfHoXkj9mzM8a095zKu5LMceqaGu0sW/lwi4FpxO/hOv2iSYwjUv+cJFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 07:05:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 07:05:28 +0000
Message-ID: <8b986315-3dcf-4fb5-8a0b-96575f0f5302@amd.com>
Date: Tue, 17 Mar 2026 08:05:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: replace WARN with DRM_ERROR for invalid
 sched priority
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
 <20260317011713.1812421-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317011713.1812421-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcb18d5-c9fa-473d-66e2-08de83f3923c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: NmWpDJi66oepMHz/o9vgYretKe7n73M+AKDFBIW8xZndTMjHU2sBoowr9gQjmfh/O2uKSC0+6j6Dd3A2QSwjuJ9pfdgFAOTaI/wAQ/e7fRGvMQjMG0HjyrPYBj5AGB2jNKJ60nCFhx/+eKEzBCN1MSppjEHRcgi0lfkBRw4lElLSYGviZqSwU7UP+e17yIGCOhJkP/Z5VV3/Acap2z1sdDJNkEb9+CxSKsSDAgNKbobWQMX4H2vdcvEi2qVk99ZLiQPPr3q089ijf41/nQK7DALv0TvDt8rQJTsQknnYUZF+pgKr0MM5lObIUJtyyYCppl7+xBJ96wfnY9IPZzkR7v2sHZYkpIVoPB/1A8IEay3VPVebIZTsxkpxESwfQ4f8zn7ddftb7f2+Sr2/60Q7yJVPU9brPc4ytqOE8mQP0j4zplyDfg02w6CihVsjWb/iCJ/tcWMWxPVKKR5EdQ5Yjt52TWSVwFbqmFi279HFVQ2j6UkmsYTCjOUtUGa+FPQ4AHP2SznlewZTeCBhym37da0aC54BEgHZpPOXdTPUAwjDDBEXDfroSc3x6EmPe/Ozw/Jn1z9+thTpGVC58FJELUia7d/0E/2nBTipBHEkCSz6YMVg4CXbfVJFN2IKGxrtpAu70JaIU0aOusNWU/gaO9opfnRYL1LMmr7QXa7MDnYq6n5kII1Wy4TnmUVKXg5J3P101S+Z63MheBjIO33RHCviNO9eAZtfISKB7lepYPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtPZCtzRmxCMXJKRXEyOXQrRXBkemVlK2d5SUJBNmMzQ3NEQU0rTDBMTTYz?=
 =?utf-8?B?WEZYOEhla29PRXcrNUhObUJIZjh2SDN3ZkF0NmphOWpqREpHLytzankyanhJ?=
 =?utf-8?B?NkprMDcyZThaY2JvRFMrQVlyU3BGbUU1MTVISlBlaGxuZXNiOWRuWmNpT0JV?=
 =?utf-8?B?YjA0V0V4cGo3MEYxMWF2cTRtMi9rcnFPYVRKKzJING9BalZoOXdEdk5tNjRI?=
 =?utf-8?B?TVk0alBFV1hQQzN3MCtPSEdFVXd2NW5QSmN3NVU4S0thRE53QkFva0FWVTJy?=
 =?utf-8?B?L1hkUE9PRkJyaGhzVUNNcC9iRWN5bnJmSVBlbU9iYjNRTWM3eUlIc2pPKzBj?=
 =?utf-8?B?MDlsZTlHZFFud0daWGxWdHdzVDd6MW1NaXlxL3l1dEhPcWlpU1gxQVlsWGR3?=
 =?utf-8?B?WTcyeDd3QndNdXUxNDFBanhLWERucEVVVDFkWkxLT0NzZjFTVTZPT3FKa0JX?=
 =?utf-8?B?cjlLUlptZkVBVzlvek4vRHNZMks3OVRwU1lIeGlDVDhUQUxIVVdCY0Z6bTcx?=
 =?utf-8?B?M2NJQnJPQjN2eHpaSllKekJaMGpDWTBDZ0RheVN1d2N2NGgyTmYxOW4wRDV1?=
 =?utf-8?B?K2gvaHF2UTJsOENoeXFDSENUbEk4NjFSMEZodTJ0cjJDTzVHVy91Zkg3MFNk?=
 =?utf-8?B?T0VwSmZDNWxzT3JUcHVMVWxnYzZ5akp1Q2Qya3hrakh0NlpoN1F3OGxRYjUz?=
 =?utf-8?B?RGxLcnFEcTV2bStGRDZ6Q3hoM2w5VkQ1ZW4xbTRRbVAzNHoyNGtQeDRkWXE2?=
 =?utf-8?B?VHJZU1NjOGRQTmxXaGNFallVQ2kyN09KMEhQRFBXUzZsS1QzaFBSTnZPZUJF?=
 =?utf-8?B?MnFGUUhLcm1zVjVpRXF3bFM2UWVFcjFpa1BsdFdhSDBNKzVPWXFUYW8xNFlp?=
 =?utf-8?B?c0xlVWRHbXNFUFNDd0VISHFkOTIzUHo3WDUydjkxMGZSMDdpMkhkQUtqTEtM?=
 =?utf-8?B?MnhJcFdTdE5mMXc3LzR1OHUwamRBQXlBQW9YeGdzQTFmclZDS0Q1cnYyR0Uz?=
 =?utf-8?B?dzFtMFVJUFZ2aWZDdGRRRDhHSmdNSEJYck5zdG92d1Q0N0Y1Rk5aZmI4ZXhq?=
 =?utf-8?B?bWVvSWZZY0dxV3IwcEtteEtmU3AwYjJlUU5KZ24zdVJadlR1SkozM2hpMzdV?=
 =?utf-8?B?eDhlMTdEaUFla0RqVHdMUHpNdG0xUXQ1ZHRGNm81cmEzaVJHRDdDN0JFTzJM?=
 =?utf-8?B?SGY1UUttSEc4WlZBQjRwYnJNMkN4UHUrTi9IWEZiMXFRUk9SVDM1QVpkd3Er?=
 =?utf-8?B?UmFBYzhaZHhEeHFacmtCQ1h5eFdwb05DY1o3ZG1qSDhJSGNLZUtDQmZhcU5K?=
 =?utf-8?B?amE1YVE4VVJiNmtxZ1l0MmIzcWJBSDZmUFJORVBnQTZ4eGpFMmoxSFk0OHkw?=
 =?utf-8?B?WFNPeXdlZFdVczBRMTBIWG1nb1hHRlFNTkNhRU5rZFY0eDk2UXE2TFU3U2I5?=
 =?utf-8?B?a0l4Rmx6RUkrYVR6WHcyb29HLzU1azdZUHNLc1VTSmlDdWttZ1N4cXNwVVVv?=
 =?utf-8?B?RHd6TE9mL1RKc2JYbkhmR0RnL09SL2tLaUhLMVl4b0NvMDJSTVNnLzNDaE5W?=
 =?utf-8?B?R2RxT29OMHlxeHUwWnRQMTIxbDE0V1NnWXREOTNtN0Qvd1ZQRWdTVWJ6dXJT?=
 =?utf-8?B?YmpzeFptRW91TzdwamxBYjNLakhjWjBxYzVmU3p5MllvbW9LV25nZm5QQ0hs?=
 =?utf-8?B?TThETjN2R0kxOCtOQ0VNZldVU0xoQmRLRy9sR2tyelUrMFBtQTZ0QXJIa1pS?=
 =?utf-8?B?MkliRlJ5YVdxK05NRFNmSTUyQmYrM2pTbDVld2xicjhHTm1zTG9HU2VKT3dB?=
 =?utf-8?B?NnRCWDVzbkppMWFWcExYZmZpYkcray9BN3VCaGl2MUU4QTkwK09qQjhuQ1NE?=
 =?utf-8?B?QnZENm9FOWczRCs5NHdYanVRcmxaYTZVZUI3Si94czZla0VqTzBPQnlMOVdP?=
 =?utf-8?B?TitvdVJ3azkydGdCVVh5SEplYVM5YnVWYUFPNFd6d0k4ejB1ZTV5S3Y0djZE?=
 =?utf-8?B?RFFwMzZBVDVMbUg3THJVeDNEU0hYUkF2dlRtTC9NK2k0c2R1ZmxIUy9nVHJk?=
 =?utf-8?B?bWRSMWZEYTFXdjlsTFJKaFFhRkZlSkJ6YXlOOWZKbkVwQWRDTE1GTEVmaTVC?=
 =?utf-8?B?VWxDd1N4QzRnbkNsaitVak42UVRIMFRoekdDNTV0cUVWWFhJNzVsYisrL1Uz?=
 =?utf-8?B?M0lkS2I5VFdNVENSTmRicmRndE9xNDZXNFJ4dS9EdGJmWE1iVzZpVVg1RkN1?=
 =?utf-8?B?dFFPQkhrZFZKRlBidWlET0kzdjR3STZ6cUkxMjBXWnVEV2lyTllMcitGM05z?=
 =?utf-8?Q?AUDP7vxvjVEQE68GN/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcb18d5-c9fa-473d-66e2-08de83f3923c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:05:28.8377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYYD7X5qzv2gFuy+puGo8Mou9LXYyNDhfbIrU4qQkFq09S7c1gKZ3NAeEv8rO+mi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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

On 3/17/26 02:17, Jesse.Zhang wrote:
> amdgpu_sched_ioctl() currently uses WARN(1, ...) when userspace passes
> an out-of-range context priority value. WARN(1, ...) is unconditional
> and produces a full stack trace, which is disproportionate for a simple
> input validation failure -- the invalid value is already rejected with
> -EINVAL on the next line.
> 
> Replace WARN(1, ...) with DRM_ERROR() to log the invalid value at an
> appropriate level without generating a stack dump. The -EINVAL return
> to userspace is unchanged.
> 
> No functional change for well-formed userspace callers.
> 
> v2:
> - Reworked commit message to focus on appropriate log level for
>   parameter validation
> - Clarified that -EINVAL behavior is preserved
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index 341beec59537..4126e5026c20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -104,7 +104,7 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
> -		WARN(1, "Invalid context priority %d\n", args->in.priority);
> +		DRM_ERROR("Invalid context priority %d\n", args->in.priority);

Please completely drop that warning. Invalid parameters should never clutter the system log.

Apart from that looks good to me.

Regards,
Christian

>  		return -EINVAL;
>  	}
>  

