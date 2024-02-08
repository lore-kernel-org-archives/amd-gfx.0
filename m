Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EAAC48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 22:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E7510EF17;
	Thu,  8 Feb 2024 22:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwkS0Yza";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4686610EF17
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 22:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETThu2WLgcXNlw9bKxcIORCbeNpvuNtegA1m8iAq+zqIkkJ8jHxxgJ/rKpTRWVSAXbKyVwZDoCVI43wOIuuUsywQwtim+lTHLsEk7+DeRgBCqA8Yw8YR9fGFaR8fI5mZo3eBrHQVo98oJPcLdHPejosal7EP+DzfFM11q5CkDMdkmPjenqcd3+t116AdIxwmW5X4Z7BDxukdGdd9Gi2sAUo5LRT4ZqdowaaadIWu7hv/dpcj7SK0Xfkd9f/oghLfiy8bXInIb3x2vafPYgEz0OWLVspSHBJraWLxqHnkFUNFhmHdJt4fL/qdN+u+jpqhy9yh7m7ztU5SCQ/iZBHEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BULlriW8CRl97913HxenuDw8oH+n1cJXvu9YPMR8EbE=;
 b=ZByPbVHYJ72um/bNT28LiFqseb9RqTCqL6i6t+fKs1iyCoSVHgGdwFhGGxEWa0RDI5ekQppWrPYLy64BCEZX8bBds2apJg3c/2Pl8fYfJhTIXPj6m8RnaRBg0UUuOQ2sWex5l7MOGjbsR1hcXhqp2o+NQOshKzr0scI6aPiJWqRm04HKdIA/vCSjwHXB+S8PGqGEP43dgO1UVtGlcfw5zeox+vtErF0wp0YrbGZ2NuNKgNcHUiHVKY6ro2qgVPTTHPvAOeR2dGSbkjBkpmXOBLJ+O+OfpuMZEdxgJUyQxqkfrL/okGhnBY4XDB2Y31WxK2HmEi3SyNSihu2C+mhwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BULlriW8CRl97913HxenuDw8oH+n1cJXvu9YPMR8EbE=;
 b=lwkS0YzaeXFhBqUPOSol2/PhiLNPI1gC9vbGk/xlLQmVVqAKggyjKX/ZcRyAuq4YUPVGJ3GIqghsN2zPQ62bKKhlFRFnIW6TbSkdc8WoTnBlupVpXu1WJgYcqwJBooLAeYS9VUPnaINMv+xzhmPMmSX4EF+/Jq6JpTvU92RTwrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 22:16:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 22:16:00 +0000
Message-ID: <885339dc-272f-47c1-9e6f-f563c1f04ee1@amd.com>
Date: Thu, 8 Feb 2024 16:15:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: make damage clips support configurable
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
References: <20240208221152.34944-1-hamza.mahfooz@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240208221152.34944-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: 33646c92-768a-4282-71a1-08dc28f387a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+FZk9uo6VtEQxLJTmurVELAYJUAVEcB37BWg/poqZMeR+Udfv5qEePtkzX7Nv0Pwik9EB2NzWgnWVe7ER/TMglyeYczzhXJk1Wlg25vCZK6G3UOa5wj7zyV1l0QGTnLpDpkjZO1WDBD/NrtPI2xAH4swLYK0dyTc9fiDtc1y/MTLamcrMvs7fJWp24cVKcBvlcnIBOHDQXVKxjA6okhw5YUBzCmVA57RHLVrFCl7OqSCtw7KthjQtNnVoFqhnWbEcviKLR88LzKdZiKiTxqFOc+pePsJUOgudmIFP51eGsuILY1ZLaxDQXzHmDIIpegxUMeAgDl+AgMaXhfOnpfmX2KA7ahL+aJBbZoHm4uOd+3c7ycwHRWBcHMfPpiaWP/+hC+vNtcQtlN4fU/2cgyBBcrEYHsy8UJuyGE1ddEvjGun3ViAunEUPsERT4HOgU2lamxwwPtUSmvWqJIiDhgSrz/k197R6y35gqe13KdCFCyFHQZpgYykIci/ygLpB0QpDZAZoZ36+uY+wIwpByn5VZA91++3tigUTnM572BH7mugOa+DqabMHkcs6nKzART
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(36756003)(5660300002)(44832011)(4326008)(8676002)(8936002)(2906002)(41300700001)(6506007)(478600001)(86362001)(2616005)(31696002)(6486002)(38100700002)(53546011)(66476007)(66556008)(6512007)(83380400001)(54906003)(66946007)(316002)(26005)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUg1Y2t6Q1NsbzgxNWZvUHF1Um1Tdmc1U1pvRVFaakpOME0xSHM0MjRQMWdV?=
 =?utf-8?B?WlBwU05DQzBHMGlDSGhtUGFaVjdZak9nRW9rZzc3aEVtMmRhcTZnNWVDa2FL?=
 =?utf-8?B?cCtNY1Ywa2pzamgwUTM4cnpVZFJrNjVsU1ZPdmdUelI1WklkVm45NFJrbnd6?=
 =?utf-8?B?MURYODdySUNqZU45WnR2TGNJS01XeUZxcFJkSVdMc08zZlRyQVgzQXYzNzJL?=
 =?utf-8?B?cFBvTDVVamVoMkR3dDE1NWdKWmJUc0thckZxakpQQ0hUUjg2dmplTzVPR2lM?=
 =?utf-8?B?bnRCc0M0dzJUcHFLRzRNWHBOeCtoTjI0TmFoTG1MY2wvYml1bmRXbm9kTUsv?=
 =?utf-8?B?TFFKdGR2SjJRQm92aVdVT3JVNThNK3NqWFArQW05RnUzTERqamJwTlhMSTRz?=
 =?utf-8?B?Y2NoNmVBNEx4N1hKUXAxSG1iWmtYZUFxQ2hOQXBOb0ZGdGdXNjVPd0hwZS9i?=
 =?utf-8?B?N202a1ZOVHJEOE81STlGQyt2S1YxZm84a1NGeVcydUF3WmN0UFU3V1BEemdO?=
 =?utf-8?B?UVZQeGR4a2svOE9lak1uYUpCUnFJS2UwL1NRZ1pHNUk0VHZVMlZQTDJza1JT?=
 =?utf-8?B?QmhuZVJTeUlQczFabjBTcWpjZlQ3cEhRM2ZUYTFoT01vdEJ3emdldzloTE41?=
 =?utf-8?B?cFNWOWVZM3R5K2swSkhwaUVack96TWlwWExqTTQzWHorZXFBL1JhN2xBSU92?=
 =?utf-8?B?a29ta0hPQmpVWHJla3RwVGMwOGU3c3REMVFWaUFDaU5aeTg2ZXI0clVMZzZM?=
 =?utf-8?B?cjcvZUNTeGlGUjZ0QzVDTlJOeHdEeDVXYjFaMnRCUWFjL3lHMDRMVWRsVnl4?=
 =?utf-8?B?Nks0Q0hNeXVzVDBiUGtRU3hRcjlqWGJJZk1IMC9RRnNYUEFBT0YrZW9hT2dn?=
 =?utf-8?B?cE9BU2NLNkVDempuZmh4TE1PT0g5L3pMaWNLbitqV0pJOVhLYTBmVE9KTVF0?=
 =?utf-8?B?RW9QVVdlODVobmk4d1RzR096aUpIeTNiZXVoNGlSb29oNDgzSklzRXVOeUp0?=
 =?utf-8?B?Qjl4YS9aNWxVeFZqRm82VHFyUVhZMTNhcVlSdytOaVpwSXE1WkI0YzNDK1da?=
 =?utf-8?B?UG9sb0tNMEJ5RGNCL1E1QTYydzI3OWc3STRjc0VWRTI0OWNvQXMwUTFqd2h3?=
 =?utf-8?B?YUlYY0dQZUdmYWlYcENmeG9sbnNvcXpaL0w0SXM0UjlMVXI5Y25TM2diSXN0?=
 =?utf-8?B?S1kzbS9qMFJ0RGg1akl1Z3l1ZHVyQktHc0FLTzVRTjBUNEYram9uL0YxYzRC?=
 =?utf-8?B?M2tDeFhoc3hJWVRZWmJCR1h3Ny9MbDBTWXVhblhDMEMxQXY2c1pBVXd0S1Zo?=
 =?utf-8?B?cVF5WkhvWXhsU0ZLeE5PNWVyZDhGbUlwU0puTGRwRUlDNmZqamU1RzUvVzFI?=
 =?utf-8?B?THJYaVFET0V0RzFDY2Y0TUZmdC9Cei82K0hydGRjWGF5ZFNoWmNnT1AvWHBY?=
 =?utf-8?B?dTJSNTA2NTBIemNoalVlV2lwQUFwZWJUY3hlQW9ORlltZEdlNFVpYXBaRzZi?=
 =?utf-8?B?WTQ3OXJYTFFMT2I4UGVxV2VKOFVBdUdMTGVBcnRmVDh1SldWcEtVNnhKOUtL?=
 =?utf-8?B?RTlEYllEaitucDJ4aHU0dzFMVDNabmN5cUIyaE4vWW1vOGgra09IdVdycXgy?=
 =?utf-8?B?MDNQdzR2SzQyTGc2WDcveFlpWDhjbWpHRjk1REpYMlJscXhFazVFOXdiVS8y?=
 =?utf-8?B?K3ltRmhRYnpCVm9WbllENmduNEtxTERyZWJma3Z5clRPTmRSUzg5OXpLMVhk?=
 =?utf-8?B?ZHNXUG5UL2hhdTYvT081K01RUjVGazBoOTF3T3NCV2w5b2JXY0xNODYvSlhN?=
 =?utf-8?B?MGowVHk0Zmt1a0lJaGFIVERCV2VuM1pnQkszTkNPSGZYNExhY0xReXZwdmts?=
 =?utf-8?B?bU0rVjd0UXUzUjNZUWhhb2Z0RmJxTlBOMjREOU5uSlFSSEZhNUZ0TkIxTVI2?=
 =?utf-8?B?MWtzQ3luQmhpNjA1a2Z6d0NxVVgxcnJ3ZzNNWGxIc0d1NjJOUnA0VkJlcjRK?=
 =?utf-8?B?MjRncE1RR1AwdEpjdi8wYkROTzlyYW9UdFFZc1RMd2dNSW5CcGh3TW0rN3ZJ?=
 =?utf-8?B?YzcrenJpN05aMTNPZzZLQWlEOGZDMVJjaG5HdFlMdFlRWlVjd1dLN2xNa1pk?=
 =?utf-8?Q?ZjMuaNTUQTJA8P5wZmrcLom5M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33646c92-768a-4282-71a1-08dc28f387a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 22:15:59.9420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCFSjLIkTYNWwSiskHOIsgv83b0o0xZm0S0rpXznuqRlKnvK4y4+Qz93dikeFXXBH1uDpwZLaxIMW4FXRcjyjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
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

On 2/8/2024 16:11, Hamza Mahfooz wrote:
> We have observed that there are quite a number of PSR-SU panels on the
> market that are unable to keep up with what user space throws at them,
> resulting in hangs and random black screens. So, make damage clips
> support configurable and disable it by default for PSR-SU displays.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

I think this with this patch in place you could also revert

571c2fa26aa6 ("drm/amd/display: Disable PSR-SU on Parade 0803 TCON again")

One minor nit below otherwise LGTM.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 13 +++++++++++++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 312dfaec7b4a..1291b8eb9dff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -198,6 +198,7 @@ extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dc_visual_confirm;
>   extern uint amdgpu_dm_abm_level;
>   extern int amdgpu_backlight;
> +extern int amdgpu_damage_clips;
>   extern struct amdgpu_mgpu_info mgpu_info;
>   extern int amdgpu_ras_enable;
>   extern uint amdgpu_ras_mask;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 161ecf9b4174..2b75aeb8280f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -211,6 +211,7 @@ int amdgpu_seamless = -1; /* auto */
>   uint amdgpu_debug_mask;
>   int amdgpu_agp = -1; /* auto */
>   int amdgpu_wbrf = -1;
> +int amdgpu_damage_clips = -1; /* auto */
>   
>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>   
> @@ -859,6 +860,18 @@ int amdgpu_backlight = -1;
>   MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
>   module_param_named(backlight, amdgpu_backlight, bint, 0444);
>   
> +/**
> + * DOC: damageclips (int)
> + * Enable or disable damage clips support. If damage clips support is disabled,
> + * we will force full frame updates, irrespective of what user space sends to
> + * us.
> + *
> + * Defaults to -1.

I think it would be better if this documentation explained what the 
values are (IE what -1 really means).

> + */
> +MODULE_PARM_DESC(damageclips,
> +		 "Damage clips support (0 = disable, 1 = enable, -1 auto (default))");
> +module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
> +
>   /**
>    * DOC: tmz (int)
>    * Trusted Memory Zone (TMZ) is a method to protect data being written
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3a5e730be24..fbe2aa40c21a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5253,6 +5253,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>   				struct drm_plane_state *new_plane_state,
>   				struct drm_crtc_state *crtc_state,
>   				struct dc_flip_addrs *flip_addrs,
> +				bool is_psr_su,
>   				bool *dirty_regions_changed)
>   {
>   	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
> @@ -5277,6 +5278,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>   	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
>   	clips = drm_plane_get_damage_clips(new_plane_state);
>   
> +	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
> +						   is_psr_su)))
> +		goto ffu;
> +
>   	if (!dm_crtc_state->mpo_requested) {
>   		if (!num_clips || num_clips > DC_MAX_DIRTY_RECTS)
>   			goto ffu;
> @@ -8411,6 +8416,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			fill_dc_dirty_rects(plane, old_plane_state,
>   					    new_plane_state, new_crtc_state,
>   					    &bundle->flip_addrs[planes_count],
> +					    acrtc_state->stream->link->psr_settings.psr_version ==
> +					    DC_PSR_VERSION_SU_1,
>   					    &dirty_rects_changed);
>   
>   			/*

