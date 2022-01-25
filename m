Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75716C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 17:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8FF10E3A5;
	Tue, 25 Jan 2022 17:53:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D63B10E3A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 17:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsMXOi4JsYDF297TJSl4dEJBvrjryRNApmdXVD8ZoeUj/5nEJChjn3PJPTioGEpf8wFqn3aQjA5/sqN2ZXFJ3gh0t95cNr366jPGZdPcMQndV8L0QO+CrMR8y98Yfwp6Q0MJZmyKm1k7/FNx/J0kGpvaWWWBOyI7mIJaDMlXYu6r8U7Liz8OprBKwGMByoM0DnFJxq0v4q1nyQReHjI+1LPvD1T6zV2KfmLC9cyENwBM37WbmOmArdxhl6HKvOVOEGTAapzcbt0M2SHkylxEu6iG/qJAXFzJLxnksB7JnIe4OVk+6YCVTRjljh25iuQ/I7z5Hu+vkIkTLoZ4o4/gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g73UILvxTscVRBF7Sjlkph+eJt5L4C2L4Ly6sXKbhZ8=;
 b=KjabjAQYVHfhP/Ib+kBSZTBzlalcllDUsKE0JE9h9I2phPFZve8z1PDIeSln/z73DTjSV7wUICczyviCu9vgkfSVVaw5eOMz/NjqF+7mMAuTHjsmUOxBdptPxg9sMWWS9Y6+sApFk6uwyn0wTCP7+KozuyKtkHE76FXbGlRKHqEackoTlw8/6zvnxBbvjLq3/VbRQoeirNAIe9o8i7d2Q3kiBt3oV24qrZEqn229r4kcqxnLQmd+IdXzXdon5VvyNVgHEc8fsMNpRFqPIXamWwhHAEFuId65mNZ1i7wBQa34anshMb/u+CSF2EpFNOCtxl/1IhdJxmoB+xyvGpPWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g73UILvxTscVRBF7Sjlkph+eJt5L4C2L4Ly6sXKbhZ8=;
 b=YG+zayLV29KOY2qSFiMr6QO5S8zk4XzilZdNIHIl5xlRKUizdIOqHxTMRlSCzGB4lwonj38vTsYjhFXN9qJ4MOWo++V8JzfcJLBnv7M8hKLWnQKnNGKbc382pyqNwpcWtGuhUGFiXXnAhGzgibCtEfaxQDv2KNCeLnhbg6Bu5zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 17:53:34 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 17:53:34 +0000
Message-ID: <91db873b-ed16-54a7-70cc-062f943d2df7@amd.com>
Date: Tue, 25 Jan 2022 12:53:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu/display: Remove t_srx_delay_us.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20220123023828.1443906-1-bas@basnieuwenhuizen.nl>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220123023828.1443906-1-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d362f4ee-4325-4552-c366-08d9e02b9aeb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1870F7847D21E088D5DE600A8C5F9@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0f1j4OpAjhIzRhOyXFOIl6FjFc4Sp/dyfNZ0CC8fVDQZvAq5uGEjyoBOTUt8cy3zLevfsw3ZgpbksGdB/feAYYBZHzpcfCR/laMBCDecTPKWTzF4uPSROo0gQRYMJ60WvniewLbjxDi89o8ddP3ZYeSXr2JtQ5K+aZh/bHnSo7nqgUKZcQMi027pp6vqCcFYqw8DY+YfLv1C/ho/29PBjHL10wk3uZLrUlCrfIZDCuqrlzB6sw/rYtgy4rUwmj2sHsei3Vk/TP7XAArRzF7UQHzo6PckfQiThfFOCWDS7EY07/eoU/6lavXkw8N6ew74Yggt9FZ6D2OZstm6kMFO9SzdIey3i3vQ4Zkb+O7m0493BCY56ioB9GudCttleH0b1kjgEw7KPTQnoe5Vi4y626kN3jGTSx+wiLN8AiBOltOkU0jgqzYXacABZjF7qeoO0yKZ9Y5s1UNOIIoGSSt2TGnNWtTf/eqyYSIMZUjHJHsAxBexZYQ/Qs1YDiXUow9th7qcDoDqnB/pOpIkBjSa5jovepDvNNVOYyQS0wX9VSQKzCeslxXvtuhf6iLQHV0e863Ery3iaaEYSvDIW32dI+XhFV78CCTfraVpDYUDlMyH8GZ8lGAu70UbYhfr6OG5kfho3rukFEPYb5NKrsFTsuULW+z+iWuzOmRsbMqNGglV/PUm00Vaowcjbcw+HuPhDRRu3LaTmjEN5l0O7plnDNz83uyXdH4YchNDE8s+zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(186003)(83380400001)(316002)(2616005)(2906002)(508600001)(44832011)(38100700002)(6666004)(6486002)(86362001)(8676002)(6512007)(66476007)(31696002)(53546011)(6506007)(26005)(8936002)(66946007)(5660300002)(31686004)(36756003)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZFTmcvdjA4M2REcUhQbkhyb3RaNVpmL3h4ZTI4Rnp2dzc4bUNZN3drTGJv?=
 =?utf-8?B?b3hnTjB3Ni9NcXdabXRCYWhTaW1GUmNqc2gzQ1E2RTNKZHBsajlFZmYvVE5s?=
 =?utf-8?B?dVRmRlgzNXZsNkRpQnlIaTdDRnEwK201MGc5aHUyTXJmZ3pHaTk5bGVDeFYw?=
 =?utf-8?B?a092Zlk0QjBrSkwyQ0dmdHV4cTBBOFpYNHA4c0U4R01PdVI5RHgvN3ZYQlg0?=
 =?utf-8?B?QjFXMkU2UFV5L0xwZFBHMWh6bmN2bWlxYi9rRHBKZ0xWK0t6KzlOTXhqcmJQ?=
 =?utf-8?B?LzkyaVlaLzR2TU5rdlQ3VE1ZNmdRenBuaVdsMEtnNjJNaUJFZUxrVXpWL3Fi?=
 =?utf-8?B?S2pxRk5pRkNqSllHTUIwTlZjK0FYK3BPQkQ4UWVucHUrcVdBNVV1Si8xZUto?=
 =?utf-8?B?dGNOV2ZEMEhlSDJtYWNMaTVhNTI4cmF6bVBwSXFxNG1RU2hlYkJxWDZpNktK?=
 =?utf-8?B?M3pOTnZxZERXN3U3bDR6Vm1Za0NqNDlGeVg1UDRVYU1TUXVmWmxvT05NU1pX?=
 =?utf-8?B?NW51Z1JzN3BnUDdSZUJtcmxXcmNMb2dlM3pMUVRYWks3aXdBdXpOVkpKM3ZG?=
 =?utf-8?B?ZDFlY0lZVVNZeGc1aUtoMjd2SllwckpQWmUyNnJLWjFKM2FveWRkOXZiU3RF?=
 =?utf-8?B?UitVTmN6aUhrTEJOZ3RIMUZyc2YrbTdpVW96cnJ1UnBVUjJFd1VtQkppMTVt?=
 =?utf-8?B?UzdZSGZYS2gveC9vcE1rOER5cEdjNWlqS2RlK0FxVFNVb250M1hWUkM3RFhP?=
 =?utf-8?B?TjgxaVh2ZHJuQVY0WFVzZWVpTVQ3ZTZjd3prWjNFUTVjdklpc3VFdzZmRjdZ?=
 =?utf-8?B?ajZUdkx4NTZNY2U2bmtDbmRKZlNNa3QxSVFOb254UTdGRUpNRy9WYXFkQ0Jk?=
 =?utf-8?B?M29EQW52elFLYVUwZGcrbFpDdmg5VE90dk1oQUJyeHF6b0tveDcxRW5OT1la?=
 =?utf-8?B?ZVh5UUlDanM5WXhnREo3RkVQTG14S3l5emp6R2I2Mzc2ekNjYkZYK25lQnpT?=
 =?utf-8?B?Y0xOUnRMVDI4UTYyTjFXMG5ZM0tJazdCei9kTEVhbE9XWXhwcHlQZW9HbnVh?=
 =?utf-8?B?RjhjR3BLeEpFYUdnUkVhbFhEZWVPVVJta29NSFEwY2d5ZU1CM3J5Z2RXT1JS?=
 =?utf-8?B?cUx3dWxSWFlFaVI1ZzhlcjFsM082RmI2NEZsUHBMZ3RvbGREZjAyclJyUDVQ?=
 =?utf-8?B?K1Z4elF2RXdxamFXd0lxM2tZc0NURTJUcTNXb2pxRFh1bWJoM0xGMElxcU8x?=
 =?utf-8?B?dEpOTXpIeGNyZWN5V3gyVHRIMHozV0JxTllnRzZFUm9SRjA1WlhBN3V3Q284?=
 =?utf-8?B?OHBUMlY2NlRSRW9NOERFTVZoZmRvTkxJa0cvNVBmT1RkTnYyUVhkaWhnNHVp?=
 =?utf-8?B?SktJMDVxMUNHQjN6WmFGTGRrYTZucVh2ZFYxdFlyN0hvNVJVYzI0eWZSZEMv?=
 =?utf-8?B?NkU5OVdhNlp3SXY2YnRDQkNoc0tMTy9BS0J0YWFqTE9zcmxvd1kyeTlBMGxI?=
 =?utf-8?B?NW1xblRlbEI5WUdEYkNPNUpGK1J4TW00ODFCVnZLbDhWamdYTDI4Y0tLKzdC?=
 =?utf-8?B?cXFENzhTQXFEWC96S2xEUkFiY1BwNUFzeHdjMTV3ZEpXaGRVN3dNL2FiTVQ1?=
 =?utf-8?B?ekg4VXpKWFZ2WUhqM0tVYTVtY0JwTnV4UHlqOEdmenlKZUpTakllaVZsQTJP?=
 =?utf-8?B?S3ZYbEp4S0pZZnQ0cFBiWFFGekx6bFByZEhLNDhvN28zdklBSGFLN2FtQkts?=
 =?utf-8?B?dXh2ZkJhNUtEVnRKK1d6UEZINnpwTFNiTmlMOWdkVzZYRUVzNXlBSGRTSVpn?=
 =?utf-8?B?bHpKaThaeWF3cmlxWWZYY3JwY0RVVkVTRXFiVlBpbUNvdlgwZ1JOOGVqUXJ1?=
 =?utf-8?B?L1IxMXdHN3JKN3lKWVY0bFd5UGY1OXgreGtidzNZMzFpYVhLOC9NZ3ZhUjlz?=
 =?utf-8?B?eHFyNGxEWnIvZytNdVI2R3dxVmRNMnFQY3EzbjZKMXpod3hKbEJuUVlHMGl0?=
 =?utf-8?B?bFMxNnhyU0FyVG9mTjVxQVdkbDJzMDRFeXRMbUVOYnBhRlJJaWk4VVFvZUp0?=
 =?utf-8?B?MTRtd1RmZG9FMzJBclhhaTZ1T3dTL3E4OXNnNTdST2d1cUw0Mi9EYVZ6YzVi?=
 =?utf-8?B?RGhMZU1MM0FNT21ZdkQzNGt0RFlmS3FVZ1p2U1NQU21MM1BrME9iaWplOFhv?=
 =?utf-8?Q?3xG3G0oN4ie2YjUqkSl/ClQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d362f4ee-4325-4552-c366-08d9e02b9aeb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 17:53:34.1836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82wjpTleP6bAyw+DVyWOR96NA+zVFnY75Eq4IonWiK+dhYeNuC23jBJKOxPOiyU0N456oatWL28n0T02iD8bag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Zhan.Liu@amd.com,
 pgriffais@valvesoftware.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-22 21:38, Bas Nieuwenhuizen wrote:
> Unused. Convert the divisions into asserts on the divisor, to
> debug why it is zero. The divide by zero is suspected of causing
> kernel panics.
> 
> While I have no idea where the zero is coming from I think this
> patch is a positive either way.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c          | 1 -
>  .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 2 --
>  .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 2 --
>  .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c | 2 --
>  .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c | 2 --
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h     | 1 -
>  drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c   | 3 ---
>  drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 4 ----
>  8 files changed, 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> index ec19678a0702..e447c74be713 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> @@ -503,7 +503,6 @@ static void dcn_bw_calc_rq_dlg_ttu(
>  	//input[in_idx].dout.output_standard;
>  
>  	/*todo: soc->sr_enter_plus_exit_time??*/
> -	dlg_sys_param->t_srx_delay_us = dc->dcn_ip->dcfclk_cstate_latency / v->dcf_clk_deep_sleep;
>  
>  	dml1_rq_dlg_get_rq_params(dml, rq_param, &input->pipe.src);
>  	dml1_extract_rq_regs(dml, rq_regs, rq_param);
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> index 246071c72f6b..548cdef8a8ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> @@ -1576,8 +1576,6 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
>  	dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
>  			e2e_pipe_param,
>  			num_pipes);
> -	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> -			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
>  
>  	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> index 015e7f2c0b16..0fc9f3e3ffae 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
> @@ -1577,8 +1577,6 @@ void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
>  	dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
>  			e2e_pipe_param,
>  			num_pipes);
> -	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> -			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
>  
>  	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> index 8bc27de4c104..618f4b682ab1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
> @@ -1688,8 +1688,6 @@ void dml21_rq_dlg_get_dlg_reg(
>  			mode_lib,
>  			e2e_pipe_param,
>  			num_pipes);
> -	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> -			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
>  
>  	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> index aef854270054..747167083dea 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> @@ -1858,8 +1858,6 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
>  	dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
>  		e2e_pipe_param,
>  		num_pipes);
> -	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
> -		/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
>  
>  	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> index d46a2733024c..8f9f1d607f7c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
> @@ -546,7 +546,6 @@ struct _vcs_dpi_display_dlg_sys_params_st {
>  	double t_sr_wm_us;
>  	double t_extra_us;
>  	double mem_trip_us;
> -	double t_srx_delay_us;
>  	double deepsleep_dcfclk_mhz;
>  	double total_flip_bw;
>  	unsigned int total_flip_bytes;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> index 71ea503cb32f..412e75eb4704 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
> @@ -141,9 +141,6 @@ void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _v
>  	dml_print("DML_RQ_DLG_CALC:    t_urg_wm_us          = %3.2f\n", dlg_sys_param->t_urg_wm_us);
>  	dml_print("DML_RQ_DLG_CALC:    t_sr_wm_us           = %3.2f\n", dlg_sys_param->t_sr_wm_us);
>  	dml_print("DML_RQ_DLG_CALC:    t_extra_us           = %3.2f\n", dlg_sys_param->t_extra_us);
> -	dml_print(
> -			"DML_RQ_DLG_CALC:    t_srx_delay_us       = %3.2f\n",
> -			dlg_sys_param->t_srx_delay_us);
>  	dml_print(
>  			"DML_RQ_DLG_CALC:    deepsleep_dcfclk_mhz = %3.2f\n",
>  			dlg_sys_param->deepsleep_dcfclk_mhz);
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
> index 59dc2c5b58dd..3df559c591f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
> @@ -1331,10 +1331,6 @@ void dml1_rq_dlg_get_dlg_params(
>  	if (dual_plane)
>  		DTRACE("DLG: %s: swath_height_c     = %d", __func__, swath_height_c);
>  
> -	DTRACE(
> -			"DLG: %s: t_srx_delay_us     = %3.2f",
> -			__func__,
> -			(double) dlg_sys_param->t_srx_delay_us);
>  	DTRACE("DLG: %s: line_time_in_us    = %3.2f", __func__, (double) line_time_in_us);
>  	DTRACE("DLG: %s: vupdate_offset     = %d", __func__, vupdate_offset);
>  	DTRACE("DLG: %s: vupdate_width      = %d", __func__, vupdate_width);

