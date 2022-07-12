Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEC3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F73711B97F;
	Tue, 12 Jul 2022 15:43:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD7710F815
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeQ1XIPmZuIxBPXWr0ssYfFYkyvOhitYg0etZaF+xM4gCPL/4m511NkpiM5yaqsHMlFVgVVt7bCvdrK7Rn6Tg3YrmpdZybPVrwo82WH51j4eAHXpDOuyOQOC2ZVPZTj6aluGSw7LXuQKyOmovs77R+BzTV96UwSU6EAAZ0knLdFC1sLRUzm1LW7BUGFkK+Uj3JBNvsxBbk4Y/jIzpovBo+ksaNwhzR2WPW7TAiQGr5cOn4znyPUt1K5q+sYNX4VxbGx8QdptW+0OZJctKm/DhJrN8VnLmFblJjkysBM3RF1pcuxn6o9DYrOMqIqLnfzzJEK4Jwu2zTbqfCUybZCZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT16BU783vqgfUSFpX40u4vSkJkYkwm2txasrQYtWdI=;
 b=W0SZkNeXDQTv2dYmN96NXmahPnEAIZbMvAqdORdoU/J4DYE0XQUsd754y2uk5fJelw/9ssyM/oiyngWqV/0XSIueIyBQJn1oXpVFY0ZlAZE/pP589EIeS0D/bLz3uvuI9wtOeDT7wJgoqRNRCC4EVOoJ8WL3onHYIfXkkkVvq/FbfYaAcqlm6W2MD+I9gCqohJlQt9xsWnjlDk6f/600kN85lvGcDRnFCHjYXfD/0ZjPm4cnavq5PCACUISCpYi9Ege7uNp9Wz0ZFnNif31jXc7MbbFjHHz0B5lnSOG8Hfms5nPnYbuSojLUjTTGhsKycN+m0VGUMLlOyM7tUQB5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT16BU783vqgfUSFpX40u4vSkJkYkwm2txasrQYtWdI=;
 b=02VnMZQB2Wl78w8KdanTlSM05Bdk9IXDi7SwiFdbsBKfixO9DYdTcbWe+HrAqlUfZUZhh7VLZj1e6t6iPON8osb17K0scPuBFgCxcYHnlvftJhgrYCQuTn+Gn8DwKH1RO41QBqyRMhHpi7WMUQA6gTkVXdCwbSvFzYJTDjtmROE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:43:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:43:16 +0000
Message-ID: <8759021d-aed1-49c5-5f71-cf6c2d26cb75@amd.com>
Date: Tue, 12 Jul 2022 11:43:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] drm/amd/display: attempt to fix the logic in
 commit_planes_for_stream()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712151348.3047904-1-alexander.deucher@amd.com>
 <20220712151348.3047904-4-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220712151348.3047904-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13)
 To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5fd7ae0-15c1-4bfb-7e29-08da641d3c87
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvmMC+RHxCFrHvbj46VnCP3ZnukTXuPeng1oK45fdO+sZFcxK3vzCDFXaAaNuQBFTgGVUe2TUyS484lnh4VmZ+LKFCwzI4/G0sXFltAyMzthL29Y4XP4oG7YJzzCPAXASKPToee1u08+VuqFdl2O1I+87XX5MzuqrTVEBoGEXqLvawyIafDmwfjK4SyJ+GSMi000geQNF0q8pF3y3kDu26wT1Q1UxXA+0QmJ42IoNuBZACovISY4YKoEnanpc6a7ajFYfemjCGtDQPzQOFSbEkc0U7GpRPL77b/N5moefv4k8ZyDcI694js26Hgynb7GMltDLLoLxfHuPnwyJaHecNkAUM5vt5PYAo75mAtloMkqD3AmfHRpmfePZ3l+tVpwdYGD5t+7HCzhbrXiZbNJJZsR9WhwerRV3Ll5E0rboBqdIYKDVjA9HKGKI8FAq71vkulWB2aAplw58RJ+D+T+28cYiW5Mbu5JV4b92wDzx9JnS9rzEfE5kZmG4JhkFcyElayhhhHexwu9xxR46v6NBF9ByxfN6SNb9JFp3Wae6XfpYRrNM4uxar1hK4kAbfMWGnS+0eqvQKG0OCYladouS1ZjO/V38JJqHbJdIlWvoJnANgiGxYRn6jCjPLeLtLK1n+Dd3TZ5SjgoJLxmaLH4MrtxD3sK2Xv0niaXrCRrewUYly82k6hdvEXDT0gTa1aoFACpIdqmcsWvQGW3sdwX+wN1mBF/qbKjhLWs3hS7zeLeqsFM3v0BLkvndrVYLDinhu2/MGQ9718xCHUbRKIZcEDVwW0jAuZMKP4XUlTHjBov7uK3/izm48Y7x3IGFvw+5B4/70txHg/4MU3PkGV730yoWaSuK1GYkcxuGtLOURQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(6506007)(6512007)(2906002)(8936002)(38100700002)(5660300002)(44832011)(31686004)(83380400001)(53546011)(66476007)(31696002)(2616005)(66946007)(66556008)(186003)(8676002)(316002)(41300700001)(86362001)(478600001)(6666004)(36756003)(26005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anErTG9XUGs1b0dLdjUrRGt3T20wSFB1RGRwQlNpaVZGejRqRUl1Qk0yUzdo?=
 =?utf-8?B?S0hxdW93NkNObmdadnZQeWx1TFpKSVI3WjkzNVovblBPbkZoWU1NZExZTWNL?=
 =?utf-8?B?d2N0emtMOXlHS25XYjNTekREeGZNcmpsdDEwNTBITnM0Y0ROb05UajZic3FU?=
 =?utf-8?B?R2hQUGl3ZlQ4VXl4c0duMVIwdlhKY3luRE81Y1BjeGJFOWlQTktnL1dobUlY?=
 =?utf-8?B?cFVtbzhJQWZEVXpORHNaZW84d1d0d1NRWnpwWGIyQ0hGbm9IeTlnSk5SVzJt?=
 =?utf-8?B?N09za2RjL0NabThJdWM2YldLdE9jWm1GcDluMjdrajJGa3NiMFl4VVA4QXVY?=
 =?utf-8?B?N1JEQWJhU1N0d3ZLVVkvSjBFZFN6NnFkWGg2T1MxaS81Y1NUL2dvKzE1UklZ?=
 =?utf-8?B?S3Mxb3hBM1F2UVFTY3B2R3hQajhJNTd3QkRPVkZubDI2UGowKytxb0l3QVJz?=
 =?utf-8?B?Q1A4QUZWVEZnbFBJMWtBYUlKNDlYNHNwMGZTUHVJZXlMWUpIYXZuVDZrbWpV?=
 =?utf-8?B?aGUvVi9SaHBxZ3p3NFBEWDIyeTFPL0tKYTNQZ3lYOExtdTI0b0t3eXFEdzZR?=
 =?utf-8?B?NktOL05TVDVuNkYwYVd0NUtIRG5QUW83aXc0T040eEp0QUJ1eVlpUFBmbkgw?=
 =?utf-8?B?VGxQZVI3SGVRWVlMNHowazY4MExFQXN4L3AzSG1nVE1QOW1WcEo0dldVbW8r?=
 =?utf-8?B?NjlkNEZNTkN1TUx1eE44UDh0MmtQemRFRkEwck9GSExtWXh1YVhyL1lUcG1q?=
 =?utf-8?B?eWRRTFVGbVB3QlJXZWpPbkpwQnk0NjF5WmdqRTM1VTUxWFFLalVWY2FsV3h5?=
 =?utf-8?B?ZFNPS0J3NVYya08ra0lvQklmWExKMFJHRjNiS2ZSMWtWSlNTZ1FEVVFFVjVP?=
 =?utf-8?B?Sjk5NVI2WFRCZ2IxSkhtQ2QvcGdXcUZlQTMySkNRaW51OUt2dzYyNjdLelJy?=
 =?utf-8?B?SDBxMWsySEcvQ2w0NjFPYjdGWVcwcXdhZTA3dGU0OVhNNkVha1B5QzNKRzBu?=
 =?utf-8?B?RnkvYWFZSkZzdWNQN2NhRGpzQ2xVSTBVeWRVSnAyTUM4QmRHb1lpN3B3ZG1E?=
 =?utf-8?B?cG8zZko3TnZJNzNFWjE1ekJxeTcreDhPN2tOeEo2V0NkTjgxb0pUOGU4cXJQ?=
 =?utf-8?B?eWJlamFsSDlZc2pNSmMyWkNFZ1VMUUFCc054bHRQT0lGeUFqTkdHTytqS3ZP?=
 =?utf-8?B?ZFNQY1FSYXlpTXlkNnJ2QlNxTkhWdkZRZ2JjMElsTGQvanRIWGpRVENYTXRj?=
 =?utf-8?B?cHoybHVOMFZSMldnWWJZWktBbmtaV3REWDVtSGxDR2tsYUZzbkU3RThLTHho?=
 =?utf-8?B?dHlXdFByZXhFVXlxUmsrM0NsSmFPTEVmTDM2dlpkTm5mTXZkbnhRbER1WFBt?=
 =?utf-8?B?emxpTUMwa3FwT1NaT2x0bjcyT054M2ZiOU9YZHQxNWJOK2FOdXRaSVhlcUI3?=
 =?utf-8?B?TFZsM29OWW8zaCtkZmlvbDVzN3FRWTVRVmw2K21SZktVVEl3bFRRMnJwS3pl?=
 =?utf-8?B?SGNUUzk3dzlWV2RCeTRIT1JieE5PcStUb1JqY2dmdStya0lEYUtEZWZ5eVd2?=
 =?utf-8?B?NHAzbjlRbWdXZkl2L09YUWw0bDdwMkVVMGh3Y0JrVWxuaVlJSWhsV2dWSmxU?=
 =?utf-8?B?Rm9tZmFFdm5EdHhuVy9EaUd3SUtOckdGaEpPTGxXR250T29BL25MeWtITE44?=
 =?utf-8?B?U0dHL2J4SXlIeC90T2lLVXdIWEJwYkt6N1B6dDZKMzVYdysyMFhpRXBTdU5u?=
 =?utf-8?B?VjRrcWlUMEp6aFhvVEtJNXBtUDVMN0hvSE1JMEI5bUZORWJIaVZ0Z2h6UHRp?=
 =?utf-8?B?ajhFemJUNTUwTmw4d1IvdUx3d2xFU1pzMzY3WVN1aytacE5rUDlwSFZJNFU5?=
 =?utf-8?B?cGtjUGpQc3krTHp1UXJKczFsUmJ0L0RXTFVoR3dmWFpkRExzV0JlZWFNMVdS?=
 =?utf-8?B?Q0J3a2RzbEphTVREVWNQK3dMNGlpZDJLWUcyY3NydFVLWU9Bdy91eDI3M0ZQ?=
 =?utf-8?B?MHFWNGR3cHhxTm5ha1o2RW1SMXEwOWpiTFpqVFRlbTNBK1M2RU5MUkhvWHRN?=
 =?utf-8?B?YUkrZ011bUQvU3NudFd5YjZIWUhnWXFRNnRnaWRLa3FTUFpYclB6ZEcxblNX?=
 =?utf-8?Q?iE+19fll1ZV0KCiWkuelbPsbx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fd7ae0-15c1-4bfb-7e29-08da641d3c87
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:43:16.0407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uZ3c8JIf0DnxppUDUaNhE4Xa4u3CCeZmPH3skem5rO7HuqVILQPZzFPS0/KSXhhTMdDsCKL0GxV/ndERmL1JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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

On 2022-07-12 11:13, Alex Deucher wrote:
> The indentation is screwed up.  I'm not sure quite how the logic
> should flow.  Someone more familiar with this code should
> verify this.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 45 +++++++++++++-----------
>  1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 7453ec54420b..efc61a485561 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3229,7 +3229,7 @@ static void commit_planes_for_stream(struct dc *dc,
>  				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
>  	}
>  
> -	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
> +	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
>  		if (top_pipe_to_program &&
>  			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
>  			if (should_use_dmub_lock(stream->link)) {
> @@ -3247,6 +3247,7 @@ static void commit_planes_for_stream(struct dc *dc,
>  				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
>  						top_pipe_to_program->stream_res.tg);
>  		}
> +	}
>  
>  	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
>  		if (dc->hwss.subvp_pipe_control_lock)
> @@ -3455,27 +3456,27 @@ static void commit_planes_for_stream(struct dc *dc,
>  
>  	}
>  
> -		if (update_type != UPDATE_TYPE_FAST)
> -			if (dc->hwss.commit_subvp_config)
> -				dc->hwss.commit_subvp_config(dc, context);
> +	if (update_type != UPDATE_TYPE_FAST)
> +		if (dc->hwss.commit_subvp_config)
> +			dc->hwss.commit_subvp_config(dc, context);
>  
> -		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
> -			dc->hwss.interdependent_update_lock(dc, context, false);
> -		} else {
> -			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
> -		}
> +	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
> +		dc->hwss.interdependent_update_lock(dc, context, false);
> +	} else {
> +		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
> +	}
>  
> -		if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
> -			if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> -				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> -					top_pipe_to_program->stream_res.tg,
> -					CRTC_STATE_VACTIVE);
> -				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> -					top_pipe_to_program->stream_res.tg,
> -					CRTC_STATE_VBLANK);
> -				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> -					top_pipe_to_program->stream_res.tg,
> -					CRTC_STATE_VACTIVE);
> +	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
> +		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> +			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> +				top_pipe_to_program->stream_res.tg,
> +				CRTC_STATE_VACTIVE);
> +			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> +				top_pipe_to_program->stream_res.tg,
> +				CRTC_STATE_VBLANK);
> +			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
> +				top_pipe_to_program->stream_res.tg,
> +				CRTC_STATE_VACTIVE);
>  
>  			if (stream && should_use_dmub_lock(stream->link)) {
>  				union dmub_hw_lock_flags hw_locks = { 0 };
> @@ -3492,8 +3493,9 @@ static void commit_planes_for_stream(struct dc *dc,
>  				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
>  					top_pipe_to_program->stream_res.tg);
>  		}
> +	}
>  
> -	if (update_type != UPDATE_TYPE_FAST)
> +	if (update_type != UPDATE_TYPE_FAST) {
>  		dc->hwss.post_unlock_program_front_end(dc, context);
>  
>  		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
> @@ -3506,6 +3508,7 @@ static void commit_planes_for_stream(struct dc *dc,
>  			if (dc->hwss.subvp_pipe_control_lock)
>  				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
>  		}
> +	}
>  
>  	// Fire manual trigger only when bottom plane is flipped
>  	for (j = 0; j < dc->res_pool->pipe_count; j++) {

