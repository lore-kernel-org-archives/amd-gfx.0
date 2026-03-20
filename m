Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4D810987A5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 16:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768EB10E2A6;
	Fri, 20 Mar 2026 16:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EY7vv1ps";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD93710E2A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 16:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKQ8XQG0rZFRiJtXulMZ5E/E8jF15XJG10PF1eJhL99diV/6x5nLscXIYgMIgPVVv8v41nNJQXrVfPe6Pu+dOxL3ey4waP36M06KaBLeFeAIy/LNlGSMKkHG1IhPpgT6z9h7obol2jWG4y4R5qKefNbmW1S7vmh/w6Us3LDohF9i+FRwhaPdz3XLS6Rv8zXUfGm0v7OrctbLwHvgwdKlg4uknzSGq10vsyxygdOKH5/wVVqoyIC7fENkGrxbQZxqyBUOdZPXBsuy4ijRQoqJ6U4EL78fh5qyIc7VvqObC7wPTsxEFpiUhE+bx9cvXajEMwJDpuUoWhD+LLBwFtVUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO29mr7AnoT2TkEkMZWHNF57RSV3SarpGRTe2ycL9ZA=;
 b=etULaTZm+Nr5TioPf2YBzeo2ldciynLV0ZiTCVzL9QA/jcFA5ZD/lD2j8yJ9cWJ1Ss93NC5TvliE19UmNtvMTssSWn3YGw/U7Dt4R54zgc49uRntLG5sOn8UA0SytLHqQwQUc3uOs3pIUxMh2MudPcGQ+s9uoGMyNU42KONnknqyTGBBRLJj1DFMKKTStpv1n7EPku4DLhghc2TPq0e1WuLGSOZngxeQG81wYF9SoBQh89Bc2YxWLdlWbeOrYZVVu3ZMl36Cg1rBEsXNLFGfg71vIc10iYKh4RA1ZFLCeQg/fmv/SitTW+Y+IaS+DM3GzLPGxNwnKJs804UuM+PD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO29mr7AnoT2TkEkMZWHNF57RSV3SarpGRTe2ycL9ZA=;
 b=EY7vv1ps+IcmxGyVNeYV6HXNdDmyPQ3ZeksiMM95PJ8BOVIEmV6LS2oMhdc+GQVGxiRlL7LL8FDBSeRHJKjH3jIEP0goigpRGqPs4QIwkILFvb/ZdznU4ujCnf6ncm30xaoc2c9XmmQd2ZEEvUutj5oNUIjP53SX6Y/X1A32txs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 16:41:18 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 16:41:18 +0000
Message-ID: <92dae9b7-2549-4341-a01c-98a5c6c937d4@amd.com>
Date: Fri, 20 Mar 2026 10:41:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer assumptions in
 dcn42_init_hw()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20260317030838.1943783-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260317030838.1943783-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: c75f6e97-feef-4549-4c2e-08de869f824a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: T1S1j9fUCmyFRXUaQzw+eR48EECSxKXkJzIbSoBRrKwnnvhaPHUKALgSbC+IPoQ/EmCENXyU39EQysy7l8tgCT32jvTxNjKWTkmsA+ea8u8d1/YtGTP/8tKIW9415XFIzzq2qLOQy9GsQGHRUYxO5Kroau4plL2bdpdWotbn/SLdtwz9Nn9ffCXxMgdIydyCPDB/3Wky4jolAtIuRtCAXaZJRD/JykzPMrwSgFbNM7ku9QgzXfrBNKAuxJcMwnAVnyNBGuBjKLVUhuexXtrUmyb2RU5MccQ+WkelOb9FbdIFMU0cBfqYsETkFawTVIQfsGx5fVPIqchO7J3krDsuoIsOy/7csWqWVTpjCNYeB3dB6iEG19aWxhOqrE3345YyLFT4sWlD9wY77nKHNrz4PJEGYOeeuqHjNAZCjnJi5uLZau92jf1/W7JTiHKFkQ2gH/NMz5aHkON6SSspxieC9bBBDvOb6omnC6eAwN+stnzXHh4gvT2WoGR3+EYWn3LETK80MzVbWSGEYsHySDPcZnBqUr6YU5VlXPycCyJWc4JZ2duLJjF6YBhJdrp7pqPQMpQrRWG3qEB6nSSN0D0JGgo+8sJHNP3t1dX8BHCAGo+0huQTUrkooLpdjStd5bWy2guTrCmOtr0NMREMr1DIC4MyqIyrum0qkSLGwimv9yTeespgdwssafpK9u5bHBFNZ9RyOGlnp3O7/I9NnoPf66QVnOr84wkTXJnVmxcz6sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRNUWpFVW0yYzdZcnoyTjhCL2dIUi9zVVhLZkxoU0cvMVBUdVl0SG84cURY?=
 =?utf-8?B?Rldxa0MycERnM2dWMzBwcFVGN0NYeWJpbnBnYXhORjdYSmx0UlBabHVYaGNq?=
 =?utf-8?B?VXl6UVpJZWoxbTBkdDRWOTBLYWp6emRNbldBd1UvS01nVzZoQWk0b3ZVbXNG?=
 =?utf-8?B?UDVvTnpqT1ROOGV4M3cxZHZvTkFobll1SkpzdFdhYVJibEJrWHJQZDlGN3J6?=
 =?utf-8?B?MVBjZmdQZVB1M0VwaTIzaWpXYi8yTWJRWHJkbjdWTWM3bXhXUkNWRTVycEJT?=
 =?utf-8?B?Z1U4WkZ2SW9DQ1J0TmZXRSt2c3ZQTklOT3d5R3p0dzAyelk5THJGVkdpbGoz?=
 =?utf-8?B?OU13MFRZeXQyQm5RVVlBdTQveHNkdjlOQWQvdzVWeWpqeElaUGFKb0QrYlJo?=
 =?utf-8?B?a0tEZ3YwRi9Bd3BMNzVRMVJUR3ExQmRyVHcyeVA1UEttYVUwekpvMUhPclhv?=
 =?utf-8?B?RE9YSk5rRXRsckFvUi9sWEN3VGFlUjdyMzk2Q1JJbnI2YUJhbFA1Y3lhN3JP?=
 =?utf-8?B?UFYxNXhNaTR0NTdYZHA5bFdKT2taMXBMeTE5a282MW1MTEhabUNhL0FzdW5a?=
 =?utf-8?B?TGs0YlVBRzJCNEMzeG83Qm50Nkl2SVJmdW5aTVpEWmJ5RWFjK3oxZFRHMFFx?=
 =?utf-8?B?RWM0MU53ZXltbE1KRXN4Wi83T1FuNDhWVkRMcHBEdHpJaytrTTErYWNXOHBr?=
 =?utf-8?B?MDhpc210VnRNalBqV3NLRGpYVFlJODY1NzgwYnlhT0h0Yzc3WWlGNVBhL3pk?=
 =?utf-8?B?cWh3dW9MSTJJQjc1Y21mQUVLUUk3c1I1QkV4TWFPRjFOQ1pRNTBrRnkyM0Vp?=
 =?utf-8?B?VzBCNUNxenR0ZE5XZ2t3dURzWHR6OGtaQTFQZHZLeDkxV1FpZFpwWDdoS3M4?=
 =?utf-8?B?ZjVreG9aS2tvaTltT2JEV3JEVDA1MHJpeG5LVUNmRVF6VEVlSDYwLzAzWjAr?=
 =?utf-8?B?cDRlNXlEdjZmbHg2NkdLZ3FLU0ZTSzFGenJ2RkMvTDlCalhWRi9KQ2docmsy?=
 =?utf-8?B?alh4VDFCcERFWDE5UzRiRGlHWjc1ellSVFk0cnQ3dm90NXJZQTFDc09KdnU4?=
 =?utf-8?B?ak1VWDBnY3NPdm9HNXBoZkQ1WkEySWdwZlUxYU9va0ZJeDBCb3Q0YTZQZk4x?=
 =?utf-8?B?TTI0TnBiLzdpSi9VL2NGby9EMmpIRnV3eVpka3g1bWZEMmkycWt5M2s3dFlB?=
 =?utf-8?B?WEhCN2I5K3RERUhPU1V4aFhPTzBoRlZMMlZ3bm5aL25aWU5hT2lQajZXR1pG?=
 =?utf-8?B?dkJFaFVsbnhDN2hGSS96Z1lkNktjSCs1U0hpbmlKT1FVL1hEd3Q0cDlydWpz?=
 =?utf-8?B?OTBEb2UrS1BKQ1lIK3ZXUnlhK2pwNEU4cU9XZktmMjZsNWtnWklGKzhlZzZN?=
 =?utf-8?B?VU9jYTRhckpRSGNPY3MxcHZxcnZpZkJXMnJ0cXNKa1g4WW4xdm1NemtGMHdU?=
 =?utf-8?B?MTN3OCtJQjcrUE1SbmFQN3V5K25QVnNHMHBNVDdzaVdrVnpWeUFYTGhzU2xU?=
 =?utf-8?B?VGZUakowQTQ1TVE1VHRGUHpRQ291bVVDUnFiWW1vQzRWVStMQmJlM2JYYTMv?=
 =?utf-8?B?ZmpNbkJBUE5uOWVTK2tBTWY1eXMzWi9VTWhKVTJ1alRTa2JrMmlaWDZsUWpk?=
 =?utf-8?B?bTQvOE9RUlRqaFBQMzEvN1N4V082OTFPVXZweGFBRDBHTVdtODZuZGdKUkNY?=
 =?utf-8?B?UDZKM1RMdFNZT2FPV1F0Vm9YODVudzVDSGswL2lxYlBYTitFNk52V1pTckVG?=
 =?utf-8?B?bTZLQnlFQk9TU1hkRm9WZmQvYnpzY0VjUFA0WnRkVWJYTkluWXRzTTF5TklE?=
 =?utf-8?B?TGg0NEVjT1R5S0NpQXQvemZuVWlhWG5CY2Nvck9rR1JzcUYya09kL05oMGN2?=
 =?utf-8?B?bzlhTFBka0c3MkVIam91U25TRXVIeVM0M21Qd200WnBUMnNkZy81NXFTRnQ3?=
 =?utf-8?B?R0pyTmY5dnBrM09sQllLWXZpMmtuZGp0WjZ1UDAvbDJFUTNYV1BVZHNzR01p?=
 =?utf-8?B?Y3ZVaHczQUptTEdJSWNybFk1SlR4SVRJdGxSSXhTeGF3eFo4UlU0RmNlakhB?=
 =?utf-8?B?eTJlMHhSVFNrVndqUnNpKzhncWlURjZ3dzA1UnlaeGllN2xtMEhibCtoYUZ6?=
 =?utf-8?B?OFdHTWxGdllLSEwrY013UGY3SHZ1ZjkwaC8yU0hqNldKRzFGMVBHdEN5QU91?=
 =?utf-8?B?Q0xqdlluaU9aNG85RDRpTWV2TjJWbTBqTEkvVml6UU1rQWtmN3BXN0o3K3RQ?=
 =?utf-8?B?L0xFMUZhMkpxa1gyVGRxSDVldUtsckNadTRybTdjY0ZrT1hXaSt6YU42RFo4?=
 =?utf-8?Q?jKpwTHE4Ex6WgGJsaF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75f6e97-feef-4549-4c2e-08de869f824a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:41:17.9502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0u8XGeigoCo1FhvrRzFIp/USyOj03EY8vfQwSsb4XCamGwZa0CvBxBEB8FnR2Hn9Ug+0eM27IkhoUk8NL/LjEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

On 3/16/26 21:08, Srinivasan Shanmugam wrote:
> dcn42_init_hw() calls update_bw_bounding_box() when FAMS2 is disabled or
> when the dchub reference clock changes. However the existing condition
> mixes the callback pointer check with only one side of the || expression:
> 
>    ((!fams2_enable && update_bw_bounding_box) || freq_changed)
> 
> This allows the block to be entered through the freq_changed path even
> when update_bw_bounding_box() is NULL. The function is then called
> unconditionally inside the block, which can lead to a NULL pointer
> dereference.
> 
> Additionally, the code dereferences dc->clk_mgr->bw_params without
> verifying that dc->clk_mgr and bw_params are valid.
> 
> Restructure the condition so that the update trigger remains the same
> (FAMS2 disabled or dchub ref clock changed), but guard the call with
> explicit checks for:
> 
>    - update_bw_bounding_box callback
>    - dc->clk_mgr
>    - dc->clk_mgr->bw_params
> 
> Also introduce a helper boolean (dchub_ref_freq_changed) to improve
> readability of the clock-change condition.
> 
> This fixes Smatch warnings about inconsistent NULL assumptions in
> dcn42_init_hw().
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:264 dcn42_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 253)
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:278 dcn42_init_hw() error: we previously assumed 'dc->res_pool->funcs->update_bw_bounding_box' could be null (see line 274)
> 
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: Sun peng Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> index 8e12dc1297c4..e307cc6363dd 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> @@ -69,6 +69,7 @@ void dcn42_init_hw(struct dc *dc)
>   	int edp_num;
>   	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
>   	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
> +	bool dchub_ref_freq_changed;
>   	int current_dchub_ref_freq = 0;
>   
>   	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
> @@ -260,8 +261,12 @@ void dcn42_init_hw(struct dc *dc)
>   	if (dc->res_pool->hubbub->funcs->init_crb)
>   		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
>   
> -	if (dc->res_pool->hubbub->funcs->set_request_limit && dc->config.sdpif_request_limit_words_per_umc > 0)
> -		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub, dc->clk_mgr->bw_params->num_channels, dc->config.sdpif_request_limit_words_per_umc);
> +	if (dc->res_pool->hubbub->funcs->set_request_limit &&
> +	    dc->clk_mgr && dc->clk_mgr->bw_params &&
> +	    dc->config.sdpif_request_limit_words_per_umc > 0)
> +		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub,
> +							       dc->clk_mgr->bw_params->num_channels,
> +							       dc->config.sdpif_request_limit_words_per_umc);
>   
>   	// Get DMCUB capabilities
>   	if (dc->ctx->dmub_srv) {
> @@ -269,13 +274,18 @@ void dcn42_init_hw(struct dc *dc)
>   		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
>   		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
>   		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
> +
> +		/* sw and fw FAMS versions must match for support */
>   		dc->debug.fams2_config.bits.enable &=
> -				dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver; // sw & fw fams versions must match for support
> -		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
> -			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
> +			dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver;
> +		dchub_ref_freq_changed =
> +			res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq;
> +
> +		if ((!dc->debug.fams2_config.bits.enable || dchub_ref_freq_changed) &&
> +		    dc->res_pool->funcs->update_bw_bounding_box &&
> +		    dc->clk_mgr && dc->clk_mgr->bw_params) {
>   			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
> -			if (dc->clk_mgr)
> -				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
> +			dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
>   		}
>   	}
>   	if (dc->res_pool->pg_cntl) {

