Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A65C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 22:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7517F22E01
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 22:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7517F22E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F1E6E10D;
	Tue, 19 Jan 2021 22:10:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1FD6E10D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 22:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3fcDonxqlh2mZnCLMRR3BisgVlvoWHcokdnPNnyByFdt/r2tekuf/OFtc+5eRIEeqnebekDalyYAgKaO2q3Y9TIzgr1dInTMx+j5YcYGuIEUIeinivWFMwtt20jfjKTA1jJSTw5iKeg5htypSGgcNaLs1nCF8Yp+jAqk+GdF1dZGAthS4fEFnKdyAEdWVhoO1GG9vLmW1Bc37U4AC9FIUzSyksSGsICQqDANZVXkYROPiCzwL+SNrBUZNUWx/ixlJPkcU8gyW+AIeHtSpeXak6/prUi0vNvPQ50aWwQ1WaoQI2/tckqtoYrIxU+BY39hMNxBjc/I3nsHR+7gzYJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md6vF4HNoBuThnz0xm/u5k1O+EO8u2/rpb0LVsq5oN8=;
 b=NGTyvCYrWseOmuGqutEBFyNhRwiFxKGGDxeLPP4Kz+GAl28vI9m3ZOUlmy123XndnDov8alDOxx3XBjNCvJ2uZgGjlDA3fLVH9TkZJEBb4WBxmDCGrViYlmSz9V9WgQ1+dBUQlqZsZyx29gSMP+y/rUBCzG0CADt0jCa/OjC5ehA408iHQIGQkhlZglFveA/gz/IbS0Cj4J4s1CVmmeIt9NZXtn0u7Sva093qP9ltwQIAW/IX1XcG7sB0xxDmAeyDliOS53wFo6rA8WGXrSGP0dRfBDOJEYhdk1USKQfayjcgzJF9XfulBvnQPcZa9jV8BSq9OwIOrvBI+xW+jQpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md6vF4HNoBuThnz0xm/u5k1O+EO8u2/rpb0LVsq5oN8=;
 b=rT0T3H0QjVvm6zXMnXTHpwAwb2PXUBdSe6rehFCOPQAx+M7jDC0VbirP8UkHOAOeqgSPLLNp4Ye+VnjfXdTK9/Jl/vb9piCbZ5LUkQzKHS5294FFuz0ns0s6RaKFO079SyeiB9yrr6NRKuy645+KOclNSShhdpEnRaTM43dz1fA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 22:10:06 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471%3]) with mapi id 15.20.3742.014; Tue, 19 Jan 2021
 22:10:06 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: Update
 dcn30_apply_idle_power_optimizations() code
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
 <20210119203810.2667860-4-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <2ba0cd1c-4204-0e76-377a-4b3ba6fca899@amd.com>
Date: Tue, 19 Jan 2021 17:10:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210119203810.2667860-4-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::35) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 22:10:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3fc094b-0db9-4793-910c-08d8bcc6fa25
X-MS-TrafficTypeDiagnostic: BY5PR12MB4997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4997F86B64BAE4F677959308ECA30@BY5PR12MB4997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLLkzb10UZAyfSrOw2YKNk/buHohnRgAhs+fMf4EXvx34AAT73F+IFok6INC5Yq5ziiLuXPiojI8Wv0V2sg4i2/gOssPgeYJZtTKNVNU/j7efaRnXC6GFZXhxzFuL2oZBhdfr8zPbk4Tx0jZu18S3C/kG6W97+aShSeyPyyF2RwvYfXds9zzvl6Q0rmPz5Qk3B6FXG2kM6vmWYZdBxuuKJf23qbQGK/jevpHDC+mJJGZTdIBC8fKY04sT4mRzfHMzPawkFJdIoHh2UxmoalNKcrLcmyuZ3xFAFz8WmOey/ykHyVPfGXdB8ZnezM0P3uIHilXR8NoKrxbfTgse8SLUTtqy1wwlDaLqiTCt1/7YDI+8pUXA/yCPeevePAFpoI+zGIonheANfMRyNivGP9hb9e2Pyt+wajT2zZoLnCLaW02BjxJ7ZAeR0KwDrBjv9EuNT9lOu4auNc6NCpChiARj/yByqDXIawcyhlJLTziVrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39850400004)(396003)(136003)(346002)(16576012)(316002)(6666004)(2616005)(6636002)(6486002)(8676002)(478600001)(53546011)(30864003)(956004)(4326008)(66476007)(52116002)(83380400001)(15650500001)(2906002)(66946007)(86362001)(26005)(8936002)(5660300002)(31686004)(66556008)(16526019)(186003)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?enVpUGI5S0JnZWI4Tnhja1dpeWc5WXpFaUprZGdhT091cXN5eElKbzg2N0kz?=
 =?utf-8?B?YW1GSlIwRmtYMVJmZ0RESU92K3MvMndhUHlzdDFRZDd0UDJsZzBPenJGU1Ba?=
 =?utf-8?B?VjBtdm9jZ2hGNThydSt3TnJCaUhwUnZGUGtycHZOQjBWcVdaQTFuNjF4NENz?=
 =?utf-8?B?NVIyREpxWW5NRW14S1ZJaFdnNm9RcnRxRTI1M3N0bWZ1cnV6NUsrTEpNNDZa?=
 =?utf-8?B?d1VGQnNLZU1pTUVQVjhBRUcrZi9yRmNSNzVhaUdtbEpBeTJRM21KNlk3MnFY?=
 =?utf-8?B?R2VwMWk4OVJqZ0RETzNDVVRNeWd6R2drRDh6L2QyN3NhODc3UmhqWXd6K1FL?=
 =?utf-8?B?ZnUrRVhsZjhlbm9vZVBDNU1KUG0zUlhSN2NXc3FJZVR5eVJ5MEVmbWhGUXl1?=
 =?utf-8?B?TDlQbzRWbnpFam90V3pMOW1JbkREdXhOMkRKTzZ2WVp5QjVZYm5qQ2RKS0gr?=
 =?utf-8?B?OGliQ1dWNjFlSWFwemJnOUNMLzN0NGQ2amFWYW5zUlY3Uk1PUVRXRlVlSitv?=
 =?utf-8?B?Tm1QUUFqOFZIeDdFSmlZcXk0eTFBTnJVWDlwc1lSdldibUN2cS9MSmpkeVhO?=
 =?utf-8?B?TzJmcDMvK0V4THdoR1pVaHgzYkRDMG54T2pRV2ZBYXBwVmxNMFhmalJIbFBj?=
 =?utf-8?B?Y3Z5eU5YcXFKWnQ1YnNkUytZLy9KbVhEUWR6VDRWc2ZXUDMyT21ocGFwMFNh?=
 =?utf-8?B?TG8wUitVME9reXpjNGtxaUJReDhHVEVRUEtGODhuRXV5dDgxRVd2TEU2aDUw?=
 =?utf-8?B?TUU1a3ZQWGU2aUpyMkt2c2liNWFvS0VPOXdFblAxdllHaUNtS1Uwa1NRb0Fy?=
 =?utf-8?B?OEgzbk9nWVJpQkdNTy9sNXRReEpXVmQ1SmZXZDBxbnlmN1hsR3lJMWRrc0RF?=
 =?utf-8?B?eFQrRFVtSDJ0M0VjTHBEYXpCaVJXOStWMHFaS2hLQnE1REJXaVpvNmFWWkwy?=
 =?utf-8?B?UmJpeGVmSUdFZzNtYllyaUowak95MnpkNGxSWjE3YUliOVQ0NVJjUnVSaWNv?=
 =?utf-8?B?NTFhTEwydldmeitMR29RalVpYnZrbHFCYVg3MmpBU3lwMUpoT3JldVNMYnZ1?=
 =?utf-8?B?NnltRUpLVjlqMWpNOEpDR1IwVXJzaTh6bEwyYlhQLzlzdDl4ZUhkV0xpTTRW?=
 =?utf-8?B?WUx0ZmdDVm9tdysreFZDQWR3ZlpUS1NDSURLczU0YVh6YUVtb1NBQ1BhczZJ?=
 =?utf-8?B?dmdmVFE3czlPN3FtQnZQWmNUUUZGWHhrRXdsMG0rZTcvMUNIVkl4MzRlTmVw?=
 =?utf-8?B?VTVHUDZGVTBRandzbmVkclZjZVBUdXFnZmcvdTZDbVE3Qnl3bDJ5ZlNnS2FV?=
 =?utf-8?Q?or3BBzh4cdstyjcmsXyIiY4PTrNMGjicNr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fc094b-0db9-4793-910c-08d8bcc6fa25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 22:10:06.2295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yyyr1yAyhPW/JImnWk9D2HOXDJc1G9qpOWwufjLi5yRpPTWwz7nCwMuLfRmDDHxmhV0mk8505b1Z3uCRbb3cdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-01-19 3:38 p.m., Bhawanpreet Lakha wrote:
> Update the function for idle optimizations
> -remove hardcoded size
> -enable no memory-request case
> -add cursor copy
> -update mall eligibility check case
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>

Series is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Though you might want to update patch 1's commit message to explain a 
little more detail about watermark set D.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 157 +++++++++++++-----
>   .../amd/display/dc/dcn302/dcn302_resource.c   |   4 +-
>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +
>   4 files changed, 129 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index e21d4602e427..71d46ade24e5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -502,6 +502,8 @@ struct dc_debug_options {
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	bool disable_idle_power_optimizations;
>   	unsigned int mall_size_override;
> +	unsigned int mall_additional_timer_percent;
> +	bool mall_error_as_fatal;
>   #endif
>   	bool dmub_command_table; /* for testing only */
>   	struct dc_bw_validation_profile bw_val_profile;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index 5c546b06f551..dff83c6a142a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -710,8 +710,11 @@ void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
>   bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>   {
>   	union dmub_rb_cmd cmd;
> -	unsigned int surface_size, refresh_hz, denom;
>   	uint32_t tmr_delay = 0, tmr_scale = 0;
> +	struct dc_cursor_attributes cursor_attr;
> +	bool cursor_cache_enable = false;
> +	struct dc_stream_state *stream = NULL;
> +	struct dc_plane_state *plane = NULL;
>   
>   	if (!dc->ctx->dmub_srv)
>   		return false;
> @@ -722,72 +725,150 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>   
>   			/* First, check no-memory-requests case */
>   			for (i = 0; i < dc->current_state->stream_count; i++) {
> -				if (dc->current_state->stream_status[i]
> -					    .plane_count)
> +				if (dc->current_state->stream_status[i].plane_count)
>   					/* Fail eligibility on a visible stream */
>   					break;
>   			}
>   
> -			if (dc->current_state->stream_count == 1 // single display only
> -			    && dc->current_state->stream_status[0].plane_count == 1 // single surface only
> -			    && dc->current_state->stream_status[0].plane_states[0]->address.page_table_base.quad_part == 0 // no VM
> -			    // Only 8 and 16 bit formats
> -			    && dc->current_state->stream_status[0].plane_states[0]->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F
> -			    && dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888) {
> -				surface_size = dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_pitch *
> -					dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_size.height *
> -					(dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ?
> -					 8 : 4);
> -			} else {
> -				// TODO: remove hard code size
> -				surface_size = 128 * 1024 * 1024;
> +			if (i == dc->current_state->stream_count) {
> +				/* Enable no-memory-requests case */
> +				memset(&cmd, 0, sizeof(cmd));
> +				cmd.mall.header.type = DMUB_CMD__MALL;
> +				cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_NO_DF_REQ;
> +				cmd.mall.header.payload_bytes = sizeof(cmd.mall) - sizeof(cmd.mall.header);
> +
> +				dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
> +				dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
> +
> +				return true;
>   			}
>   
> -			// TODO: remove hard code size
> -			if (surface_size < 128 * 1024 * 1024) {
> -				refresh_hz = div_u64((unsigned long long) dc->current_state->streams[0]->timing.pix_clk_100hz *
> -						     100LL,
> -						     (dc->current_state->streams[0]->timing.v_total *
> -						      dc->current_state->streams[0]->timing.h_total));
> +			stream = dc->current_state->streams[0];
> +			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
> +
> +			if (stream && plane) {
> +				cursor_cache_enable = stream->cursor_position.enable &&
> +						plane->address.grph.cursor_cache_addr.quad_part;
> +				cursor_attr = stream->cursor_attributes;
> +			}
> +
> +			/*
> +			 * Second, check MALL eligibility
> +			 *
> +			 * single display only, single surface only, 8 and 16 bit formats only, no VM,
> +			 * do not use MALL for displays that support PSR as they use D0i3.2 in DMCUB FW
> +			 *
> +			 * TODO: When we implement multi-display, PSR displays will be allowed if there is
> +			 * a non-PSR display present, since in that case we can't do D0i3.2
> +			 */
> +			if (dc->current_state->stream_count == 1 &&
> +					stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED &&
> +					dc->current_state->stream_status[0].plane_count == 1 &&
> +					plane->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F &&
> +					plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888 &&
> +					plane->address.page_table_base.quad_part == 0 &&
> +					dc->hwss.does_plane_fit_in_mall &&
> +					dc->hwss.does_plane_fit_in_mall(dc, plane,
> +							cursor_cache_enable ? &cursor_attr : NULL)) {
> +				unsigned int v_total = stream->adjust.v_total_max ?
> +						stream->adjust.v_total_max : stream->timing.v_total;
> +				unsigned int refresh_hz = (unsigned long long) stream->timing.pix_clk_100hz *
> +						100LL /	(v_total * stream->timing.h_total);
>   
>   				/*
> -				 * Delay_Us = 65.28 * (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
> -				 * Delay_Us / 65.28 = (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
> -				 * (Delay_Us / 65.28) / 2^MallFrameCacheTmrScale = 64 + MallFrameCacheTmrDly
> -				 * MallFrameCacheTmrDly = ((Delay_Us / 65.28) / 2^MallFrameCacheTmrScale) - 64
> -				 *                      = (1000000 / refresh) / 65.28 / 2^MallFrameCacheTmrScale - 64
> -				 *                      = 1000000 / (refresh * 65.28 * 2^MallFrameCacheTmrScale) - 64
> -				 *                      = (1000000 * 100) / (refresh * 6528 * 2^MallFrameCacheTmrScale) - 64
> +				 * one frame time in microsec:
> +				 * Delay_Us = 1000000 / refresh
> +				 * dynamic_delay_us = 1000000 / refresh + 2 * stutter_period
> +				 *
> +				 * one frame time modified by 'additional timer percent' (p):
> +				 * Delay_Us_modified = dynamic_delay_us + dynamic_delay_us * p / 100
> +				 *                   = dynamic_delay_us * (1 + p / 100)
> +				 *                   = (1000000 / refresh + 2 * stutter_period) * (100 + p) / 100
> +				 *                   = (1000000 + 2 * stutter_period * refresh) * (100 + p) / (100 * refresh)
> +				 *
> +				 * formula for timer duration based on parameters, from regspec:
> +				 * dynamic_delay_us = 65.28 * (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
> +				 *
> +				 * dynamic_delay_us / 65.28 = (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
> +				 * (dynamic_delay_us / 65.28) / 2^MallFrameCacheTmrScale = 64 + MallFrameCacheTmrDly
> +				 * MallFrameCacheTmrDly = ((dynamic_delay_us / 65.28) / 2^MallFrameCacheTmrScale) - 64
> +				 *                      = (1000000 + 2 * stutter_period * refresh) * (100 + p) / (100 * refresh) / 65.28 / 2^MallFrameCacheTmrScale - 64
> +				 *                      = (1000000 + 2 * stutter_period * refresh) * (100 + p) / (refresh * 6528 * 2^MallFrameCacheTmrScale) - 64
>   				 *
>   				 * need to round up the result of the division before the subtraction
>   				 */
> -				denom = refresh_hz * 6528;
> -				tmr_delay = div_u64((100000000LL + denom - 1), denom) - 64LL;
> +				unsigned int denom = refresh_hz * 6528;
> +				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
> +
> +				tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
> +						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
> +						denom) - 64LL;
>   
>   				/* scale should be increased until it fits into 6 bits */
>   				while (tmr_delay & ~0x3F) {
>   					tmr_scale++;
>   
>   					if (tmr_scale > 3) {
> -						/* The delay exceeds the range of the hystersis timer */
> +						/* Delay exceeds range of hysteresis timer */
>   						ASSERT(false);
>   						return false;
>   					}
>   
>   					denom *= 2;
> -					tmr_delay = div_u64((100000000LL + denom - 1), denom) - 64LL;
> +					tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
> +							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
> +							denom) - 64LL;
> +				}
> +
> +				/* Copy HW cursor */
> +				if (cursor_cache_enable) {
> +					memset(&cmd, 0, sizeof(cmd));
> +					cmd.mall.header.type = DMUB_CMD__MALL;
> +					cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_COPY_CURSOR;
> +					cmd.mall.header.payload_bytes =
> +							sizeof(cmd.mall) - sizeof(cmd.mall.header);
> +
> +					switch (cursor_attr.color_format) {
> +					case CURSOR_MODE_MONO:
> +						cmd.mall.cursor_bpp = 2;
> +						break;
> +					case CURSOR_MODE_COLOR_1BIT_AND:
> +					case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
> +					case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
> +						cmd.mall.cursor_bpp = 32;
> +						break;
> +
> +					case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
> +					case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
> +						cmd.mall.cursor_bpp = 64;
> +						break;
> +					}
> +
> +					cmd.mall.cursor_copy_src.quad_part = cursor_attr.address.quad_part;
> +					cmd.mall.cursor_copy_dst.quad_part =
> +							plane->address.grph.cursor_cache_addr.quad_part;
> +					cmd.mall.cursor_width = cursor_attr.width;
> +					cmd.mall.cursor_height = cursor_attr.height;
> +					cmd.mall.cursor_pitch = cursor_attr.pitch;
> +
> +					dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
> +					dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
> +					dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
> +
> +					/* Use copied cursor, and it's okay to not switch back */
> +					cursor_attr.address.quad_part =
> +							plane->address.grph.cursor_cache_addr.quad_part;
> +					dc_stream_set_cursor_attributes(stream, &cursor_attr);
>   				}
>   
>   				/* Enable MALL */
>   				memset(&cmd, 0, sizeof(cmd));
>   				cmd.mall.header.type = DMUB_CMD__MALL;
> -				cmd.mall.header.sub_type =
> -					DMUB_CMD__MALL_ACTION_ALLOW;
> -				cmd.mall.header.payload_bytes =
> -					sizeof(cmd.mall) -
> -					sizeof(cmd.mall.header);
> +				cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_ALLOW;
> +				cmd.mall.header.payload_bytes = sizeof(cmd.mall) - sizeof(cmd.mall.header);
>   				cmd.mall.tmr_delay = tmr_delay;
>   				cmd.mall.tmr_scale = tmr_scale;
> +				cmd.mall.debug_bits = dc->debug.mall_error_as_fatal;
>   
>   				dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
>   				dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index b96b32a37178..b4ff73e32279 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -1316,7 +1316,9 @@ static bool dcn302_resource_construct(
>   	dc->caps.max_cursor_size = 256;
>   	dc->caps.min_horizontal_blanking_period = 80;
>   	dc->caps.dmdata_alloc_size = 2048;
> -
> +	dc->caps.mall_size_per_mem_channel = 4;
> +	/* total size = mall per channel * num channels * 1024 * 1024 */
> +	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
>   	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
>   	dc->caps.max_slave_planes = 1;
>   	dc->caps.post_blend_color_processing = true;
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index a50bdd6c7131..98dd8b5f463c 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -458,6 +458,10 @@ struct dmub_rb_cmd_mall {
>   	uint16_t cursor_pitch;
>   	uint16_t cursor_height;
>   	uint8_t cursor_bpp;
> +	uint8_t debug_bits;
> +
> +	uint8_t reserved1;
> +	uint8_t reserved2;
>   };
>   
>   struct dmub_cmd_digx_encoder_control_data {
> @@ -624,6 +628,7 @@ enum dmub_cmd_mall_type {
>   	DMUB_CMD__MALL_ACTION_ALLOW = 0,
>   	DMUB_CMD__MALL_ACTION_DISALLOW = 1,
>   	DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
> +	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
>   };
>   
>   struct dmub_cmd_psr_copy_settings_data {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
