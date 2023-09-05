Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102FECA0FFA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A992910E3F7;
	Tue,  5 Sep 2023 18:48:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AD010E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6IGI46d/QOur66+lKz4e/NwM3bHjRlFPItu4Arf+87REd7GDama5hIDZSe2M3qQlxFpeTMDRs27OrsLNIibXEdz0R9L16waAL/uerqlxmhojN3rW5iT5ix1EuUMAWiNRdlN3BgG0fqfsMqSAply7irGMj3d4YzUTi6d+fE6s8EK/AYp3NmfclTkkp33xU/utDyEwmpRpE6tvCSmLsus9jhzIfm2jL/qnH6RFYPfJwjNLCcJIuY9ZzcQYNwynC82+wSI/bIEEAfnKkeMeEEpPSB7sW+JJUHLwxiOr2/+mnKFPM3F58oRCT4y0Sqo2clAA5kBpRT2lpjk0CCJwv6IcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrT3H4PBX0Stl+KaR3l2QcuoMV9/mrriHqaWGoaoTpQ=;
 b=WZCmd03nscnoSQ1+SQHuFIbRyrmt4Fve1ZLmx86O2TxHkZ5n0jUNkBhZZzSkNgOUfVjVSxCbILILhJxAeAxcusNJpfGKzpS9jiTqkvQX+uuikZ71SiijVpp0uwnEk3th8KHppQOZMsPWqtsqnAFuNZ0FZNhKcN2QxTICaqJEjRXQwP7cdENJ1NDQHcFGYSbldGVKI87nhA/emzNei40SIaZEeZAKvHZPSlfKxkS4tq88SGWWsv5M2r70bRRoLPSCxQvDDY31oitbmWzFltf4UB0+VB7ZORj0xkpGP0dKu7wZOyocA3lJ1TnwCR6aAO/CLEKrqi4z/+eJPXxnshkKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrT3H4PBX0Stl+KaR3l2QcuoMV9/mrriHqaWGoaoTpQ=;
 b=w/xFB9TpU4HJdu2wcYLWFiuMXWaCkFtM7EI2q1zc2bfznotAMlhRJlzFBCxRmY3mmoHmTudYw57vvXQ9Ayc8F081JWLgCbJRxX4Vryltgn3c6hZnkq6RNoRGsNoHW6s+AcuPqZaVvWn+6alZ7AViHquRY4KLKYbLlQigxKgPuW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:48:09 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:48:09 +0000
Message-ID: <d5cc92b8-7b65-85aa-38ee-d303235649b3@amd.com>
Date: Tue, 5 Sep 2023 12:48:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 06/18] drm/amd/display: Use drm_connector in
 create_stream_for_sink
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-7-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-7-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:303:6a::28) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7e0a14-8780-4156-1c6b-08dbae40a607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJfAvuUOhP1IXlC8fwcmvWyeaPulX0HRSDkDPxhLF3VDgl3I1Gxjp0Cpf0vHL35vOCZHvStgpRKirukMG1fVp0Ze1b+ltaZqDQLEE09E0eGKvIVPTneY6BCk0Cdi6BRSDyGjoK6x9sJZVfrytTz5HtTog4NrD3JWMn+yXz91yqswRLs8MdnBKxW+LAneavZYgBI4mmrHlVp2hk7NcsnR6GlK1UrA6gXrGBxAHiZHzFWnChpxM+HDTsyeMXQdg/GOZ1Eb+040OOAayKYxjuQ1iJ3AaAfhT8IUuxcmLa8Bg0RDTgTdCK+PwvskmIy91EUJ3L2Y8kp+kDHsez2OhrN5SZeNddTvvOiRuIp0LSYehN6RQ2VY67F5OPPt8IEoDR+u8JuDYRkjzC8Qu8A2kq2XSHmvU8sTwUNDa/E/m/m9OZTPBEXl3s0w3mfQor/39WVpeyWP7inr4Ae54tm2YmGpmWe53/FdJMV+wrTkimGSRDoCVxs0HxKp/wh/vN2+gZyUObJIfqwHnzSEM8H3at6LwdeHuN6FEPi6+JMvkBa2QnVjw9aG2hhwInHYrxB7oowl3YyByS0NMvOQhmMvYRAZy9ldGyy1fSIUkbjWRFNgkgUbw3InHC1OybsLBe2kShLBCt5ez27FPG4AdWZIjMPFPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(53546011)(83380400001)(8936002)(31696002)(5660300002)(4326008)(44832011)(8676002)(6506007)(2616005)(6666004)(26005)(86362001)(41300700001)(6512007)(6486002)(478600001)(38100700002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWFwdCtMWnY2SDdCWGJZaUpxWlVFTndjc1VOZWdtUm9JYUlWRzdIK1BjYUNJ?=
 =?utf-8?B?UW9Cb3NoVURDRVNaT2RPckVoaWFYVmowVzlEYW4zUDIrQUFVbktYUW56S0VO?=
 =?utf-8?B?Ums0NmgxZng2UGdiWTZ2Z2pFZWt0Ujk0ZXQzaytSdzBHbTkwcTdMZ2lsVmFo?=
 =?utf-8?B?Q0JiVmRYSmp1bDA3UTBJRHEvUHJjcnY0OEFNMnhPN3NvQlp1K2lwcWNLWk1m?=
 =?utf-8?B?MEVFUFlTQzgwLzJYYWNoaXVpVWd5dFBtd2Q2cGpMWWdwRG9yQlJ1QjNWQzFR?=
 =?utf-8?B?U0JVQVB1OGl0MjY4STkxdjJKa1Bkd0JOdHVsdDJKb2UwSWZkeVdsSHJRTVRx?=
 =?utf-8?B?VEtRdC9XRFZUZGxvQmJMcHFlVFlLcm0zbmlxQ1JiQXJXdDI2bVhXTlBoazI5?=
 =?utf-8?B?dkJRMTNlV08vTG5qZmhZZC9KZkh0Wjg3a0g3NVBiSWZBUEtpUzgraTMxOWY1?=
 =?utf-8?B?ejhZT3B6bEpWd25kZUR2MGFLb3VpRm83YlM1Y0lyMjRCL3ZpWlRFeE5zRGoy?=
 =?utf-8?B?V3lnVDI3ekZZRkxQYy8vQ2pVankrVEI1UHhGMmdpOUZXallGR2tMMXFTaE5Z?=
 =?utf-8?B?SXR3K016aW0rUW1ZSnNqVnhaeHM0YTJJWFg5bThYWkIxOVlXNnpYZmFER0tu?=
 =?utf-8?B?eFRtalo3NWdaWjJMelZNVnpkcWZRaU1vTUVTQkwyS3BtT3ZqZnVreXFqelU4?=
 =?utf-8?B?eGY5Q3cwem03Mm80Y3p3ZzdUWlcrNHE3Y21iZFFmSVcwM2s1Ti8xbUVQdmFN?=
 =?utf-8?B?dFF2anVITFBDdFIyM0wzQjM5QStWNXB2RWlVdHhWOVN3dUtPM1ZUL0dTUDBz?=
 =?utf-8?B?VmRRZ2k0a3NNa2FFWWNBaWw0WElrNFdLUExqTkh4dVhOeE94b3NYT0h2c3Q4?=
 =?utf-8?B?VE01bzQ5SUx2MDVTOVpJb1F6ejhOMmE4eklTZVBxNFJvQmpUb2dhdzdZNjNy?=
 =?utf-8?B?T2F1c2RKK2J6bnVYSWo2b2JRd25Hc1ZDTDBjU0tuZUpmNlgrTUQvQjYyOFc4?=
 =?utf-8?B?dFJERU1JSFlJbUhyeDFkYTVuOUg0NGtZMThZbWRLcXp3eGZyNzdMcFN0a0RG?=
 =?utf-8?B?NERlY0ZxVUpJbjlPVnhiWks2aWxjM2VkQVd6Y1g2QkV5RjMxeXNIbFdpWEF4?=
 =?utf-8?B?a29iVGlQb3VtbUd0UVVtWWJvdG45RExSR0NJdVZiMHR1bmFka3ZuUjZDSkNM?=
 =?utf-8?B?QTBzTkxSWjg2RzZXOHFwMnFkb1JxWVliYjFwTER4RnVQck91ckR0UHNzNmdI?=
 =?utf-8?B?TnBLRVNNUmFGcnB6blNUdCs1M3pPU1RENWhXMnUreWhZbTVHRDE4QVM1UkZI?=
 =?utf-8?B?bklmRFhzWmREVHBUWGZOZzJhdTRjc2hneFBlRDRYRjkrczlraXpIMytXUERR?=
 =?utf-8?B?ZElRNVpiUjMxdlA4dEl1Lzd6ZTRMYUVHbzRYWlc1WjJTTm1mdSttV2dCS09J?=
 =?utf-8?B?Tk9xL1hCRlJBbDhQU01EZXVmRWxxelRQUHRMdUJqUUwya1RWZXFyTHNGeXRP?=
 =?utf-8?B?a0VTS3VaL1pHbWN6RTdWaUxmL2MvR2xNVHZzbmlMcWk0NFBYdUtTck81UVBv?=
 =?utf-8?B?M0U5aFprOWdjdkpNLzBTVGxMSzBuOXlhZUo1MFNwUlREeUExWUduU0JKb3lI?=
 =?utf-8?B?NjJxb0FRdjVlREN3eVJTeVNVWG5JNHRGMHJZWTVCdUtLR2s4cGdCOHZ2b0VQ?=
 =?utf-8?B?UWpiYVcxMisxS0lSNFdVS0NLSHVRYTB3UXZXaGxDYlhFdzYvUHlsUHpqNmtJ?=
 =?utf-8?B?WGJzRkpXcHo5U0NMTklxVzNOdUJFVFRtZm9XZ2s4WStncUN0bkVudFR5TjUr?=
 =?utf-8?B?ejAxRXc4YWdhMGYxUUh1cHhPcTVFLzM4c3hoaHd2SEFXeEFhKzdrc1hSZ0VK?=
 =?utf-8?B?Yk85QXZmRy9lNUY4RzZxYzdvNUZGRHo5VEZYTzhRNHRLOU85cmRuWmpNNHBh?=
 =?utf-8?B?SU96YVQ0RERuSDNac3lGMVg3RlNsRHgvbXFUdDdKdyt5NEErZy83ZjVaMDBu?=
 =?utf-8?B?OU1mdEdVM2VVSVBhbE9mYWVXYU5QeDJXSitqSzBsZzAwWW5iTXNEWWdsTWY2?=
 =?utf-8?B?bDJWQi9RYXFVRFJJUFZsczFBV3VPTEJoWm1ua0RVUG1xa2RueUcxUzg3UzJr?=
 =?utf-8?Q?KvF3uv8HpdWfL55bzQVPrymOH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7e0a14-8780-4156-1c6b-08dbae40a607
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:48:09.0755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moAcgX9KWJFzOxQUb/HeV/4+gd75PWoqF+uTvfalHpi3r/Wl2act1U0gNA/1YcFiBrl3MZOnP631iHkU7cWi0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHAT]
> We need to use this function for both amdgpu_dm_connectors
> and drm_writeback_connectors. Modify it to operate on
> a drm_connector as a common base.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 65 +++++++++++--------
>   1 file changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7bd3ec84ff2e..a7d2a3f35f74 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5455,6 +5455,7 @@ static void fill_stream_properties_from_drm_display_mode(
>   			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>   		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
>   	else if (drm_mode_is_420_also(info, mode_in)
> +			&& aconnector
>   			&& aconnector->force_yuv420_output)
>   		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
>   	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
> @@ -5490,7 +5491,7 @@ static void fill_stream_properties_from_drm_display_mode(
>   		timing_out->hdmi_vic = hv_frame.vic;
>   	}
>   
> -	if (is_freesync_video_mode(mode_in, aconnector)) {
> +	if (aconnector && is_freesync_video_mode(mode_in, aconnector)) {
>   		timing_out->h_addressable = mode_in->hdisplay;
>   		timing_out->h_total = mode_in->htotal;
>   		timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
> @@ -5966,14 +5967,14 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>   }
>   
>   static struct dc_stream_state *
> -create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
> +create_stream_for_sink(struct drm_connector *connector,
>   		       const struct drm_display_mode *drm_mode,
>   		       const struct dm_connector_state *dm_state,
>   		       const struct dc_stream_state *old_stream,
>   		       int requested_bpc)
>   {
> +	struct amdgpu_dm_connector *aconnector = NULL;
>   	struct drm_display_mode *preferred_mode = NULL;
> -	struct drm_connector *drm_connector;
>   	const struct drm_connector_state *con_state = &dm_state->base;
>   	struct dc_stream_state *stream = NULL;
>   	struct drm_display_mode mode;
> @@ -5992,20 +5993,22 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	drm_mode_init(&mode, drm_mode);
>   	memset(&saved_mode, 0, sizeof(saved_mode));
>   
> -	if (aconnector == NULL) {
> -		DRM_ERROR("aconnector is NULL!\n");
> +	if (connector == NULL) {
> +		DRM_ERROR("connector is NULL!\n");
>   		return stream;
>   	}
>   
> -	drm_connector = &aconnector->base;
> -
> -	if (!aconnector->dc_sink) {
> -		sink = create_fake_sink(aconnector);
> -		if (!sink)
> -			return stream;
> -	} else {
> -		sink = aconnector->dc_sink;
> -		dc_sink_retain(sink);
> +	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) {
> +		aconnector = NULL;
> +		aconnector = to_amdgpu_dm_connector(connector);
> +		if (!aconnector->dc_sink) {
> +			sink = create_fake_sink(aconnector);
> +			if (!sink)
> +				return stream;
> +		} else {
> +			sink = aconnector->dc_sink;
> +			dc_sink_retain(sink);
> +		}
>   	}
>   
>   	stream = dc_create_stream_for_sink(sink);
> @@ -6015,12 +6018,13 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		goto finish;
>   	}
>   
> +	/* We leave this NULL for writeback connectors */
>   	stream->dm_stream_context = aconnector;
>   
>   	stream->timing.flags.LTE_340MCSC_SCRAMBLE =
> -		drm_connector->display_info.hdmi.scdc.scrambling.low_rates;
> +		connector->display_info.hdmi.scdc.scrambling.low_rates;
>   
> -	list_for_each_entry(preferred_mode, &aconnector->base.modes, head) {
> +	list_for_each_entry(preferred_mode, &connector->modes, head) {
>   		/* Search for preferred mode */
>   		if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
>   			native_mode_found = true;
> @@ -6029,7 +6033,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	}
>   	if (!native_mode_found)
>   		preferred_mode = list_first_entry_or_null(
> -				&aconnector->base.modes,
> +				&connector->modes,
>   				struct drm_display_mode,
>   				head);
>   
> @@ -6043,7 +6047,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		 * and the modelist may not be filled in time.
>   		 */
>   		DRM_DEBUG_DRIVER("No preferred mode found\n");
> -	} else {
> +	} else if (aconnector) {
>   		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
>   		if (recalculate_timing) {
>   			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
> @@ -6068,13 +6072,17 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	 */
>   	if (!scale || mode_refresh != preferred_refresh)
>   		fill_stream_properties_from_drm_display_mode(
> -			stream, &mode, &aconnector->base, con_state, NULL,
> +			stream, &mode, connector, con_state, NULL,
>   			requested_bpc);
>   	else
>   		fill_stream_properties_from_drm_display_mode(
> -			stream, &mode, &aconnector->base, con_state, old_stream,
> +			stream, &mode, connector, con_state, old_stream,
>   			requested_bpc);
>   
> +	/* The rest isn't needed for writeback connectors */
> +	if (!aconnector)
> +		goto finish;
> +
>   	if (aconnector->timing_changed) {
>   		DC_LOG_DEBUG("%s: overriding timing for automated test, bpc %d, changing to %d\n",
>   				__func__,
> @@ -6092,7 +6100,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   
>   	fill_audio_info(
>   		&stream->audio_info,
> -		drm_connector,
> +		connector,
>   		sink);
>   
>   	update_stream_signal(stream, sink);
> @@ -6551,7 +6559,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	enum dc_status dc_result = DC_OK;
>   
>   	do {
> -		stream = create_stream_for_sink(aconnector, drm_mode,
> +		stream = create_stream_for_sink(connector, drm_mode,
>   						dm_state, old_stream,
>   						requested_bpc);
>   		if (stream == NULL) {
> @@ -9274,15 +9282,16 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>   	acrtc = to_amdgpu_crtc(crtc);
>   	connector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
> -	aconnector = to_amdgpu_dm_connector(connector);
> +	if (connector && connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
> +		aconnector = to_amdgpu_dm_connector(connector);
>   
>   	/* TODO This hack should go away */
> -	if (aconnector && enable) {
> +	if (connector && enable) {
>   		/* Make sure fake sink is created in plug-in scenario */
>   		drm_new_conn_state = drm_atomic_get_new_connector_state(state,
> -							    &aconnector->base);
> +									connector);
>   		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
> -							    &aconnector->base);
> +									connector);
>   
>   		if (IS_ERR(drm_new_conn_state)) {
>   			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
> @@ -9429,7 +9438,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		 * added MST connectors not found in existing crtc_state in the chained mode
>   		 * TODO: need to dig out the root cause of that
>   		 */
> -		if (!aconnector)
> +		if (!connector)
>   			goto skip_modeset;
>   
>   		if (modereset_required(new_crtc_state))
> @@ -9472,7 +9481,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	 * We want to do dc stream updates that do not require a
>   	 * full modeset below.
>   	 */
> -	if (!(enable && aconnector && new_crtc_state->active))
> +	if (!(enable && connector && new_crtc_state->active))
>   		return 0;
>   	/*
>   	 * Given above conditions, the dc state cannot be NULL because:
