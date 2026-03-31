Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4901061B29
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 00:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435AF10E6DE;
	Tue, 31 Mar 2026 00:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VjLyBTFR";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35B610E6DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 00:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq6LzimmERz7Pe7wRRanVVMARwSst2UlKJJ4SuFwMi/9Fr5gBqVpdSZrX2dKdY6l3Qi3DELRnlxDnUt9NUMP+tSXTyYyMyt9a2HxlY+KOzDeCQVWMkxzQYOyeYXH61CptQyS5k8ZDHBPdpfyy1B4jOXnYTI5VYxmvbpxsgJ8N164wGDY/pJqTpOcfMe/HeQUpEHAfLhTqbZViCaD9Q6Sk25mP8T/7nS6xDGMoh9cnpiaD3+I7tge+gVZXN5o9ylinGzPKKbFlRVCrT77LLiEFk01MZNL2fI41cOvqqVjji3fEJ5EgwC3/yZNvmLlrYXN+SQ7hgGB5t4CSzdzMGqomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx/j9zI5BZAM785lmXIvZdbp6eZEpH2kOMAe8AEJmCM=;
 b=yg6C6DOBwm8bRlvhpzwTHx66iWeUjnMrSZbdr9Oh06VW5RPcq0QOUvtwzMKpPt4FONhUFtGAl+1gUvKOimJLVPaTNuZWBeJJDnNhUtaJKMFJHoEZrecdPNLpmERp4fCA8oJ3KY0d7LbfENg49omEM3wdTEkR0iIjvrck3NmffFC8LLPCkcAnOgVoGSJFnHnf/YX9EY8Il6ZL+S/OMBk6W/eUajI5BRVe7c6wDnC3RiVSoKV3ndhKwdKTZS75w1p+eVNbfCniZPhd7IuIDNP5j6ULTK0pNJOvadTNugytmEjFH1d68dbjXlS76EN5nHigiWXHZ9xG0FgHpyhnjlJ68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx/j9zI5BZAM785lmXIvZdbp6eZEpH2kOMAe8AEJmCM=;
 b=VjLyBTFRNBNkO5uRYLvepLFtRNlRs2l+hg7W1BGW8weXUpVGVGicCjgNET4G0z48EzDfiJbhBp36nVRVIhMHGIJe+BUUKJ9bwDKCmXdRDcKpdtvhVWAaY2nVXuEZao3ZewRQy6o11bRH4HAnirGobrVo79Xg4Odzv0JwWXJziNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 00:08:36 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 00:08:36 +0000
Message-ID: <553fe6a6-050f-49cb-bf56-d628b4afaddb@amd.com>
Date: Mon, 30 Mar 2026 18:08:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix parameter mismatch in panel
 self-refresh helper
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ray Wu <ray.wu@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Mario Limonciello <superm1@kernel.org>
References: <20260330031229.2157972-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330031229.2157972-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7fd375-889b-4a51-bbb3-08de8eb9a78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 0Tzwu8q6otLw9iDgOkNvzT3UYRTMDdh9xjDCNGGvJvLSVWgTAvgkQdbKhfSmNQEfvdoaQRyP60NeJWUSB8i+yyzaqImsr1xUW7yM2JI3B8XxgPgNEtWGb6V6rcbi89SqF8ulCLpDUCnrxctuzQOEud0bMQEkOwrl7fRXXYW+2cj07msge2xqJy4lPu9wqvx5R34GJtg8c2UCngHNX+H4BtNVSuBug3UZfoyN6363dAAWwa4RcISu6WcdpAroRSmiRHlri3BqPkyC5O4XoxNbdr1E+qifaQchCYyEUQtLfqnCO6S+ekx5UlX6CPe4q8rQky7hkR6M8rFOw8XNMXCRFct8BSGhzkJq8jfNS5/FGzuv3xjC6SPPY//M6ZK1yqzr2YFgkfRYwP2AulG3/ZSPAEtuzMDwOjh/EKgk3Q2HhXSGyppzv2wlGegmRQDs/2OteovHJp/4+1N/EDkx2kIrxIhvMlCiJDhEivHOr/MpsXlZF4WfG72HzmjkRauCRi4FZfeOruA5SFoQ94si+YxHGeo6U08Q6nvdECTzhlrFqMNJuii5TWG/3ERf0ll07NATjF0sxabKdEDHJdSJ+QAODs6Oz9IsOZEFv+Lk0NsIaCC41JMCPaLlU6hf3dHWqbT7p9gMw2aGyNJgz9KLt5Vl+7pjTEczpAAPM8Rqyssh5MGa6JA6ByfyDERoElAGi7fS9k0gZKgIGachQuGA7yGwAjOPQ1XuUj/DbE7K1S+q0c4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEpiVmFJUlUzRDg1Tm9IT1BhQ2pQTDBBNkxkbEszWWd1R3BOc2UySE14cW05?=
 =?utf-8?B?Q2ZJRGZkWWcvcWc2WjEvZ0N6WkhIV20xZzVtdnhkQWMrcmdHY1RPaWgrdWtm?=
 =?utf-8?B?SjJUMnl4MEhKRmc2Z2UwaUo3dWtzbWtZSHI3MDZWNitsSUpvV3hwSEtQZXZW?=
 =?utf-8?B?ZDdXV2wycnI1MGs2ajg4LzBEZ1prQ090RWdDbitwcXJSVU9jQVkrUER4RndB?=
 =?utf-8?B?OVVUZm5TNFBXTmdTdExmemMvUUVYNTVYVXN4dUw5QTMrRzN1azdjbXZqWEl2?=
 =?utf-8?B?YjBla2lQdHZBalZ3MVY1bXhhNFZwU0VMQkJqQTBFY0dFb2hhdFhhckJKeTFU?=
 =?utf-8?B?cm9uSlRVclJoR1phcExVWXNPbzN2QjNBZDV5NTFRT3dBbVpyWXpyejhhd2Vt?=
 =?utf-8?B?RmhsN01oRkJQcDNqcUZ3aHVWQ3NXRlVVTnJ6MGJtMkNjT2hobmRsZVZNRk1G?=
 =?utf-8?B?eUJsMVZWWEZFYXpWcXN5ODA3endhZTR1ZmJ5bVhYQkxpSTZZTDdWc3dMS25H?=
 =?utf-8?B?L1ZBRWE4QTRTRHVwNWQvZ3pGQjZBVmxMZWdDZnYvWGxMVFBuZWZEMEN6MXFU?=
 =?utf-8?B?SFE2QWFjMFU5aEdtbjVQcFFCenlzZnVNejRtMkh0RW91RFZNOElNM1d5Mmpu?=
 =?utf-8?B?TWZ1QWZHTkI3dXpJTG1EQ0tnZnR6b3E5OUpOOU0xUHBFUk5SMVhOcEpVWS91?=
 =?utf-8?B?ODVOSXNLZHFoc1lFM0FEMWdVQVczcXdmTE5NZW1lb2hmNmxWKzJKWmRiRkwv?=
 =?utf-8?B?VC9rRmJYNitzcEZ4YmE3YjdWS1AxUHlVbkx1R3h4YmlzRlhmdnhoeFVKLytJ?=
 =?utf-8?B?bnJaaGE3bHlQeDVSTWpDYnhYalhaQTNGSVduNGNUK1U0M1BZSlA0dmozNTkw?=
 =?utf-8?B?SExaaGppRy9ZSE8xbWw3STZya1pmTEsydmpuVHVuNXprM2dQeGJWZXJXeFJw?=
 =?utf-8?B?N0puZGVRNDNXeGlCWWdEZ3JnTlcvazRtYWh3UGRWdzBKQ3ZNL1BVcmtwTDRq?=
 =?utf-8?B?NlBWQTZOd0QvTnBjZzVFN1BjVnlaVGttRmtjNmxGWU1iZWtqYkY2ZE5UNWFp?=
 =?utf-8?B?aTVMWHEwbXRtaFNvV2lORDFUcG12QURUTkxlcFBSV3hDZmJFVENVYWRnRzN6?=
 =?utf-8?B?S3lDdFE2cVd4b3UrV0FVN29rOEkrN28xVGVoYjRyNnVtekJ3aG1LenhmN1JM?=
 =?utf-8?B?bDV1K2VrOGZwMXpyRC9ORm1iS1d2bjgrdDB6NEZ6OE5IMlhtZ3Y3WDg4aU9O?=
 =?utf-8?B?akVLSlBHODZlWVpiakdNQUVCcnFOMjRqbEUrTkJNMFlaWEtqVFAvTnRwSTFa?=
 =?utf-8?B?WTBUM2pZa3RyUk1CMWVGOU5BM2hnczJoR3FySWI4WHpmQTdPbDU5MkZNUUhv?=
 =?utf-8?B?QmxZQy9NNHpyTU9uY2l1UWVKV2R6TGVTVncvTExPUTFJeHJRTWc5REU5YU5Y?=
 =?utf-8?B?YVZObXZiay82cGovR2dGR08rNGFrRTJVUFNCRlBKbFE2ZlJtS2dtOFkvMkVX?=
 =?utf-8?B?aEZGN2lITER5N0dQQ2lBWlFLZlliVDhEMWdzTHUyRU42NHMvTFgwRlgwanJC?=
 =?utf-8?B?R2l2L3FKN25VUDBkN0dPanhNa21lUUMzRjZmclBkK003bjJwRGoxUlNRc3ph?=
 =?utf-8?B?RFdUQmU2Y2JMNWhpREpXK3EzYzNBMmZScXd5N1RxMGt6MGg1Rm9SeSt6d1NL?=
 =?utf-8?B?LzVRd0huWnk5RXJUNEN6WjFZU3ZYWGovUFVabFVGeDZ0aENjUWYrc25CSWM4?=
 =?utf-8?B?bmJxSkt0WTVTbmlXNGljWXFxVVczaDNaUkxVeDhwZHJ6Wlc3MzliWDg1cXZF?=
 =?utf-8?B?SU5pcU1kd290TERTc3ozZUhRUXgzL0VjaXkrUmRrQnNCRFEwcmN5UElJaE9M?=
 =?utf-8?B?bU1HU1dvM2gwWlM0cVFaS1ZBaGhzV0lxTWFselpnR0sxQ2RxMkV2cjVWZmo1?=
 =?utf-8?B?bkRvUzBlZWZrY04wUlRJYnYrT2llZXlIb1VKaWFkTStibklHN0dxbGkxRW1l?=
 =?utf-8?B?QkNwSEl4SU1pTWllL0xGcjJvanhwT1h6T1g3UzliYURJbHNQRGlRWWZWVHpy?=
 =?utf-8?B?c0gyeDM5b3BjOGRxaVo4dVhndG5TQzBiK0RiYjM2TEIzaVdXNXRkVnRkZlp1?=
 =?utf-8?B?VEVpZWZtWUovMFZGUDhFUWM5bWJhRkttd0hXYS9TdUlXN3o2QnlTUFl4Unc1?=
 =?utf-8?B?Z01xd1RwSXJQL2J5S0FMQTJ3b2FPc0R6SmlvU1V2T3o5cmp6aDBIaWx3Vk5R?=
 =?utf-8?B?UFNNeUNvcmlQUkx2NVh4MWZvbEIxWnE1MlFRUG5jMHRIUklEMGJCUXkzUkV0?=
 =?utf-8?B?azJvdGFXdHIzUUlUWEo1eHIydWpKM1BRVE8xRXJTZUxvQ3Q2M0hyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7fd375-889b-4a51-bbb3-08de8eb9a78d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 00:08:36.5846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9A8aG08gx2b65hhSl6Omj+0T1Z9ufFJmvZGjw4wqz+5FrF7HGiGRNyXnQn7siU+6ZR+8hapcF0GHErGt679QJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/29/26 21:12, Srinivasan Shanmugam wrote:
> Align parameter names with function arguments.
> 
> The function controls panel self-refresh enable/disable based on vblank
> and VRR state.
> 
> Fixes the below with gcc W=1:
> ../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'dm' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
> ../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'acrtc' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
> ../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'stream' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
> ../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'dm' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
> ../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'acrtc' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
> ../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'stream' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
> 
> Fixes: 0b572a6bf04a6 ("drm/amd/display: Add Idle state manager(ISM)")
> Cc: Ray Wu <ray.wu@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 21 +++++++++----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 08f06342b01e..26f3d513576b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -101,23 +101,22 @@ bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
>   
>   /**
>    * amdgpu_dm_crtc_set_panel_sr_feature() - Manage panel self-refresh features.
> - *
> - * @vblank_work:    is a pointer to a struct vblank_control_work object.
> - * @vblank_enabled: indicates whether the DRM vblank counter is currently
> - *                  enabled (true) or disabled (false).
> - * @allow_sr_entry: represents whether entry into the self-refresh mode is
> - *                  allowed (true) or not allowed (false).
> + * @dm: amdgpu display manager instance.
> + * @acrtc: CRTC whose panel self-refresh state is being updated.
> + * @stream: DC stream associated with @acrtc.
> + * @vblank_enabled: Whether the DRM vblank counter is currently enabled.
> + * @allow_sr_entry: Whether entry into self-refresh mode is allowed.
>    *
>    * The DRM vblank counter enable/disable action is used as the trigger to enable
>    * or disable various panel self-refresh features:
>    *
>    * Panel Replay and PSR SU
>    * - Enable when:
> - *      - VRR is disabled
> - *      - vblank counter is disabled
> - *      - entry is allowed: usermode demonstrates an adequate number of fast
> - *        commits)
> - *     - CRC capture window isn't active
> + *   - VRR is disabled
> + *   - vblank counter is disabled
> + *   - entry is allowed: usermode demonstrates an adequate number of fast
> + *     commits
> + *   - CRC capture window isn't active
>    * - Keep enabled even when vblank counter gets enabled
>    *
>    * PSR1

