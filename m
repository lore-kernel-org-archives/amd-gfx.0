Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF8C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 16:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1F2221F1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 16:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1F2221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688BD89FFD;
	Mon,  4 Jan 2021 16:16:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4848889FFD
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 16:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYQGIGudbJMPclR4ga3KO5CsXrLNarcuiRSoCJQiVvj7xY9s6moJVimsgfx1awiIcJFaOAFrdwXN9Kb00uuzSxPcfM1lVtrI0eOTY3BPh4RsacwybiqZPQ9F0Hx8xmiTmNcfcjBWPbQAJ9vd/Ka/BdSCjssG8GfWAOHK40x1mpfacsJYcCPoUK8vetD2CAS+aymyZz6zzdltptiCo9ra3ng8T+jYJxNVDzH93gk3mwqp9dJYmlUhmhi88UaASj8qlAwrM8zdX/3AMYU4HHVic1S8li0s+jr8wc3HinjbfZ06yD1f7t1HzkzBTFH/0GoxVip5i4UdhZ/v/LGki+K+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpMovhTkbsDKhazXFFLKC1S1p8EA7N+zP6zFV5Cf5K8=;
 b=Ro2nePGNg5mkkGSXPYJubnMQabR60B/nFNbATuDswxXEwPydSscuusHP2TsjfvgJyMwBKVh0xW7kq89jPx+xa+IDNhc56ArgdlWYDaXxrpGIgRKfoVignIBAC/mafZKJlxe5ARZ0yRxdUEUEaASippmseyw/v+4JGaLiDZWJ1JYXk9pwTJ2OCuFq7tAt795Kl+bnrAeQe5Zo4cpphLPrjFEEYNa9ieZD6xwJJZlmB24pES7eu7iMRs1C2Rye+2UwpWkjotGkLgKVRL69MuSw4zs2upUzhgjbAQFYLrrfYc7JClF/Jb1G6U61l/WAw5UW80thtwgswc2FzJbEbLxekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpMovhTkbsDKhazXFFLKC1S1p8EA7N+zP6zFV5Cf5K8=;
 b=uBZGbnqnBAT/DOJ2cuVT4iA7vdvypn4jq1EYGsLEAOaPIVRrH2uIw/0MNq9OdwSryDiKqJ9PENlmyhZa7k7Du3Gl8GmRlTl4qCXdEwGAOU2JEC61ijrbirV+6FtjqC7BYR5x6Ov6rwFEpjd/I1WLIPtawP/1mHMlwpFKsUgBOPg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 16:16:33 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::c415:a6:f78f:82f5]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::c415:a6:f78f:82f5%6]) with mapi id 15.20.3676.035; Mon, 4 Jan 2021
 16:16:32 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: Skip modeset for front porch change
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-4-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <bd9b0cdf-4886-dfac-39d2-f1440d50ec39@amd.com>
Date: Mon, 4 Jan 2021 11:16:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201210024526.1151447-4-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.19 via Frontend Transport; Mon, 4 Jan 2021 16:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 628641c6-19a7-4fec-e685-08d8b0cc1a0d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB42891313F16BDADA709D5571ECD20@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AtsXpqbAhv3Ubdruem2SmSNg90yGIRn6vfgwBTz8zleVhVbHY0oy4QCmrkH9VSqfCJ69G7vAq4a3eXRM7MAM+J5fN9jU93iiolVCkF58Q0zO4zIRoC7i0RS65GRrSNMkwzK2PS1yBBn9fKVKzKwjL7qmwoYLgONh3066LBJBHvk3GAGVlQkYKCNzKJLZVYGUXTlWJV6Pou+C1BaM8G4yb4kp0Ck6iOLXA2YVnspZ+N3PruOxObj3w3iZtewZkm09K61wo0Hd5vgyKbFXDZ9xDmo48GY99RHmVvWd5DvLVYdUEsP1hAGacSdayubNp7qe3+EBpAQnOpCVOEBSh1uKTkTz9OJXiGTKGJNxLTELkgnKltUNCJfoxcqiE45qeWaV/LZGDyy+qy1Cwunf4cIzHcajBKKz76Q/fyxcAqlvZ+J2ibhLhnxFxV2K6vp412zDDSxyBaOjt6xco9cUiXOauqgQaC/ErUez+9LHxAETQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(8676002)(83380400001)(2906002)(16576012)(316002)(30864003)(478600001)(31686004)(52116002)(5660300002)(6486002)(26005)(66556008)(31696002)(66946007)(86362001)(186003)(16526019)(8936002)(66476007)(53546011)(2616005)(36756003)(956004)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bnZZa0hObmc4SGxpWGdJWW9ZekxxY0hKWnJ2bzRjOWJSNFovSk9CclV1SCtW?=
 =?utf-8?B?TGkvVHJBa1NlWGVWcVhrK2RoL2w0bDJwWCtNaXM3R2NHSTJEUHpnU2QxeHpw?=
 =?utf-8?B?bGZkMFRTVEVpbFA3dU12U1NtRkFKakZ3TG43VU5JVTVrd3VwK1IwRGJ2QVhj?=
 =?utf-8?B?M2pmZ3hMSVFHTHoyWFBSM0pLQk4zZmM5bmg2ako2WHlWM1hFNnhCVmJldnVr?=
 =?utf-8?B?MGxPMCtQSGlFM01RN1daYVFtZVM0cVF0eVdTWWFWM0QxbTlselRBUUVkU01t?=
 =?utf-8?B?TzB4TmNtQVFhYU9HbTlmOHpNcHc3TEs4dXJ6OW9BVURLeHFtdVh3bEdsTEU4?=
 =?utf-8?B?MmJsczVSdzVTSy9WcXE0NzRqcnRRVDg4M21MRVRvUEgwRWtWNDFXQTZzMFRp?=
 =?utf-8?B?K1B6b0I1YjU0M3lIK1NMb3NlQkZUT0JiWGtsUmF0NE1DRHd3Z0hORWZMN3l5?=
 =?utf-8?B?czZDOXEzZ2ZPVWg2Zm1odXoxalJQMms4TG04dE0wY0VvVmxydGdnZjFWeGdY?=
 =?utf-8?B?b1UxZnpLWmJsd2lpZEdaald5Njlmd1NyS1lFYllSRHdyZUxUSHpZUmN0cThm?=
 =?utf-8?B?a3U2UUhmVGxkMnVIYU5FSXNjVXU0bmgrTTlZcTU5Z1dNVUQ4UWxFdUhjS1Uy?=
 =?utf-8?B?emRUa2g5REExTWEwbzdQSnI2TXMxakRzd2V2M1pndm5QVi9PaVE3dVVlckdY?=
 =?utf-8?B?QUF2Y3ZrWURyL1lzTjczbk1neVZpTllwSWYxZkx1N0hMUzY0SG1tZVh0K2hk?=
 =?utf-8?B?Ui9wUFptNnBLYXFtY2MxMzkrSmlKYUVpcUk3OUhGOER5UmRQdWlEeFUyUlhz?=
 =?utf-8?B?ZStoY1RMcTF1eEZUa0hCd3B5USs2d1BtV0Zucyt1dm9heER2WFd6a2RYQ05W?=
 =?utf-8?B?MWFRa1FPYktSb3NmUEFLZGpKU2wvbjRZQmlSd0VUM20ycnJmd2xzNTY0YTRV?=
 =?utf-8?B?N1lRK1pTdHViMkNDRUFOWGljMFJrTUJVV0czY0h5VGJDM2h0TVNZYmlSN20v?=
 =?utf-8?B?NzNkWGNmTHpIZTdHd05ta2poN2l1V3FqK05QTElyT0dsWmdha3ltZW9YM1ZN?=
 =?utf-8?B?dEtsQ0ZoV2ZsNklOOTZ3MDI1NGMrU2Q0cFpVQnh0OGtTdjFrKzB2Yi9HVit3?=
 =?utf-8?B?VWk1N056R0tYRXF0NUIxaVQ0bUYrOXM1WlhGVHo3anpUTzF4NWdzMlhqbG1y?=
 =?utf-8?B?TzJ4Y3JxMUJ0WFdEcmgvbVdDTFc4WGtKQVR5VnFycEE1LzJmK29wcEpKOXN0?=
 =?utf-8?B?Si8wWXhvNFlqS0dyeEcxTWdoY29ZeER0bUVCeWxpdHBwTmJkQUpEZHNFZmYr?=
 =?utf-8?Q?Zu1/Qkt2SW7H1Y3skS2e1IxG346tUJJk21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 16:16:32.8421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 628641c6-19a7-4fec-e685-08d8b0cc1a0d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2CgAw/Qwk2hQIHy+l8pki1TqBU21GB+DmblClxbgzj72KKLftrsWelP95iWrAFROTbad8QlxT5Z00pjqber4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, shashank.sharma@amd.com,
 wayne.lin@amd.com, alexander.deucher@amd.com, Harry.Wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-12-09 9:45 p.m., Aurabindo Pillai wrote:
> [Why&How]
> Inorder to enable freesync video mode, driver adds extra
> modes based on preferred modes for common freesync frame rates.
> When commiting these mode changes, a full modeset is not needed.
> If the change in only in the front porch timing value, skip full
> modeset and continue using the same stream.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 169 ++++++++++++++++--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>   2 files changed, 153 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f699a3d41cad..c8c72887906a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -217,6 +217,9 @@ static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
>   static const struct drm_format_info *
>   amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
>   
> +static bool
> +is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
> +				 struct drm_crtc_state *new_crtc_state);
>   /*
>    * dm_vblank_get_counter
>    *
> @@ -5096,8 +5099,11 @@ copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
>   static void
>   decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
>   					const struct drm_display_mode *native_mode,
> -					bool scale_enabled)
> +					bool scale_enabled, bool fs_mode)
>   {
> +	if (fs_mode)
> +		return;
> +
>   	if (scale_enabled) {
>   		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
>   	} else if (native_mode->clock == drm_mode->clock &&
> @@ -5241,6 +5247,24 @@ get_highest_freesync_mode(struct amdgpu_dm_connector *aconnector,
>   	return m_high;
>   }
>   
> +static bool is_freesync_video_mode(struct drm_display_mode *mode,
> +				   struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_display_mode *high_mode;
> +
> +	high_mode = get_highest_freesync_mode(aconnector, false);
> +	if (!high_mode)
> +		return false;
> +
> +	if (high_mode->clock == 0 ||
> +	    high_mode->hdisplay != mode->hdisplay ||
> +	    high_mode->clock != mode->clock ||
> +	    !mode)
> +		return false;
> +	else
> +		return true;
> +}
> +

Need to check that the other parameters are the same:
- hsync_start
- hsync_end
- htotal
- hskew
- vdisplay
- vscan

etc.

>   static struct dc_stream_state *
>   create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		       const struct drm_display_mode *drm_mode,
> @@ -5253,17 +5277,21 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	const struct drm_connector_state *con_state =
>   		dm_state ? &dm_state->base : NULL;
>   	struct dc_stream_state *stream = NULL;
> -	struct drm_display_mode mode = *drm_mode;
> +	struct drm_display_mode saved_mode, mode = *drm_mode;
> +	struct drm_display_mode *freesync_mode = NULL;
>   	bool native_mode_found = false;
>   	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
>   	int mode_refresh;
>   	int preferred_refresh = 0;
> +	bool is_fs_vid_mode = 0;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	struct dsc_dec_dpcd_caps dsc_caps;
>   #endif
>   	uint32_t link_bandwidth_kbps;
> -
>   	struct dc_sink *sink = NULL;
> +
> +	memset(&saved_mode, 0, sizeof(struct drm_display_mode));
> +
>   	if (aconnector == NULL) {
>   		DRM_ERROR("aconnector is NULL!\n");
>   		return stream;
> @@ -5316,20 +5344,33 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		 */
>   		DRM_DEBUG_DRIVER("No preferred mode found\n");
>   	} else {
> +		is_fs_vid_mode = is_freesync_video_mode(&mode, aconnector);
> +		if (is_fs_vid_mode) {
> +			freesync_mode = get_highest_freesync_mode(aconnector, false);
> +			if (freesync_mode) {
> +				saved_mode = mode;
> +				mode = *freesync_mode;
> +			}
> +		}
> +
>   		decide_crtc_timing_for_drm_display_mode(
>   				&mode, preferred_mode,
> -				dm_state ? (dm_state->scaling != RMX_OFF) : false);
> +				dm_state ? (dm_state->scaling != RMX_OFF) : false,
> +				freesync_mode ? true : false);

I don't think we need an additional flag here - scaling/freesync behave 
the same, maybe just rename the variable in the function.

Regards,
Nicholas Kazlauskas

>   		preferred_refresh = drm_mode_vrefresh(preferred_mode);
>   	}
>   
>   	if (!dm_state)
>   		drm_mode_set_crtcinfo(&mode, 0);
>   
> -	/*
> +	if (dm_state && is_fs_vid_mode && freesync_mode)
> +		drm_mode_set_crtcinfo(&saved_mode, 0);
> +
> +       /*
>   	* If scaling is enabled and refresh rate didn't change
>   	* we copy the vic and polarities of the old timings
>   	*/
> -	if (!scale || mode_refresh != preferred_refresh)
> +	if (!(scale && freesync_mode) || mode_refresh != preferred_refresh)
>   		fill_stream_properties_from_drm_display_mode(stream,
>   			&mode, &aconnector->base, con_state, NULL, requested_bpc);
>   	else
> @@ -7881,13 +7922,29 @@ static void update_stream_irq_parameters(
>   	if (new_crtc_state->vrr_supported &&
>   	    config.min_refresh_in_uhz &&
>   	    config.max_refresh_in_uhz) {
> +		/*
> +		 * if freesync compatible mode was set, config.state will be set
> +		 * in atomic check
> +		 */
> +		if (config.state == VRR_STATE_ACTIVE_FIXED &&
> +		    config.fixed_refresh_in_uhz && config.max_refresh_in_uhz &&
> +		    config.min_refresh_in_uhz &&
> +		    (!drm_atomic_crtc_needs_modeset(&new_crtc_state->base) ||
> +		     new_crtc_state->freesync_video_mode)) {
> +			vrr_params.max_refresh_in_uhz = config.max_refresh_in_uhz;
> +			vrr_params.min_refresh_in_uhz = config.min_refresh_in_uhz;
> +			vrr_params.fixed_refresh_in_uhz = config.fixed_refresh_in_uhz;
> +			vrr_params.state = VRR_STATE_ACTIVE_FIXED;
> +			goto out;
> +		}
> +
>   		config.state = new_crtc_state->base.vrr_enabled ?
>   			VRR_STATE_ACTIVE_VARIABLE :
>   			VRR_STATE_INACTIVE;
> -	} else {
> +	} else
>   		config.state = VRR_STATE_UNSUPPORTED;
> -	}
>   
> +out:
>   	mod_freesync_build_vrr_params(dm->freesync_module,
>   				      new_stream,
>   				      &config, &vrr_params);
> @@ -8205,7 +8262,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   		 * as part of commit.
>   		 */
>   		if (amdgpu_dm_vrr_active(dm_old_crtc_state) !=
> -		    amdgpu_dm_vrr_active(acrtc_state)) {
> +		    amdgpu_dm_vrr_active(acrtc_state) ||
> +		    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED ||
> +		    acrtc_state->freesync_video_mode) {
>   			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>   			dc_stream_adjust_vmin_vmax(
>   				dm->dc, acrtc_state->stream,
> @@ -8896,6 +8955,7 @@ static void get_freesync_config_for_crtc(
>   			to_amdgpu_dm_connector(new_con_state->base.connector);
>   	struct drm_display_mode *mode = &new_crtc_state->base.mode;
>   	int vrefresh = drm_mode_vrefresh(mode);
> +	bool fs_vid_mode = false;
>   
>   	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
>   					vrefresh >= aconnector->min_vfreq &&
> @@ -8903,17 +8963,26 @@ static void get_freesync_config_for_crtc(
>   
>   	if (new_crtc_state->vrr_supported) {
>   		new_crtc_state->stream->ignore_msa_timing_param = true;
> -		config.state = new_crtc_state->base.vrr_enabled ?
> -				VRR_STATE_ACTIVE_VARIABLE :
> -				VRR_STATE_INACTIVE;
> -		config.min_refresh_in_uhz =
> -				aconnector->min_vfreq * 1000000;
> -		config.max_refresh_in_uhz =
> -				aconnector->max_vfreq * 1000000;
> +		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED ||
> +			new_crtc_state->freesync_video_mode;
> +
> +		config.min_refresh_in_uhz = aconnector->min_vfreq * 1000000;
> +		config.max_refresh_in_uhz = aconnector->max_vfreq * 1000000;
>   		config.vsif_supported = true;
>   		config.btr = true;
> -	}
>   
> +		if (fs_vid_mode) {
> +			config.state = VRR_STATE_ACTIVE_FIXED;
> +			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
> +			goto out;
> +		}
> +		else if (new_crtc_state->base.vrr_enabled && !fs_vid_mode)
> +			config.state = VRR_STATE_ACTIVE_VARIABLE;
> +		else
> +			config.state = VRR_STATE_INACTIVE;
> +
> +	}
> +out:
>   	new_crtc_state->freesync_config = config;
>   }
>   
> @@ -8926,6 +8995,51 @@ static void reset_freesync_config_for_crtc(
>   	       sizeof(new_crtc_state->vrr_infopacket));
>   }
>   
> +static bool
> +is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
> +				 struct drm_crtc_state *new_crtc_state)
> +{
> +	struct drm_display_mode old_mode, new_mode;
> +
> +	if (!old_crtc_state || !new_crtc_state)
> +		return false;
> +
> +	old_mode = old_crtc_state->mode;
> +	new_mode = new_crtc_state->mode;
> +
> +	if (old_mode.clock       == new_mode.clock &&
> +	    old_mode.hdisplay    == new_mode.hdisplay &&
> +	    old_mode.vdisplay    == new_mode.vdisplay &&
> +	    old_mode.htotal      == new_mode.htotal &&
> +	    old_mode.vtotal      != new_mode.vtotal &&
> +	    old_mode.hsync_start == new_mode.hsync_start &&
> +	    old_mode.vsync_start != new_mode.vsync_start &&
> +	    old_mode.hsync_end   == new_mode.hsync_end &&
> +	    old_mode.vsync_end   != new_mode.vsync_end &&
> +	    old_mode.hskew       == new_mode.hskew &&
> +	    old_mode.vscan       == new_mode.vscan &&
> +	    (old_mode.vsync_end - old_mode.vsync_start) ==
> +	    (new_mode.vsync_end - new_mode.vsync_start))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
> +	uint64_t num, den, res;
> +	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
> +
> +	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
> +
> +	num = (unsigned long long)new_crtc_state->mode.clock * 1000 * 1000000;
> +	den = (unsigned long long)new_crtc_state->mode.htotal *
> +	      (unsigned long long)new_crtc_state->mode.vtotal;
> +
> +	res = div_u64(num, den);
> +	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
> +	dm_new_crtc_state->freesync_video_mode = true;
> +}
> +
>   static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   				struct drm_atomic_state *state,
>   				struct drm_crtc *crtc,
> @@ -9016,6 +9130,11 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		 * TODO: Refactor this function to allow this check to work
>   		 * in all conditions.
>   		 */
> +		if (dm_new_crtc_state->stream &&
> +		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state) &&
> +		    amdgpu_exp_freesync_vid_mode)
> +			goto skip_modeset;
> +
>   		if (dm_new_crtc_state->stream &&
>   		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
>   		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream)) {
> @@ -9047,6 +9166,22 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		if (!dm_old_crtc_state->stream)
>   			goto skip_modeset;
>   
> +		if (dm_new_crtc_state->stream &&
> +		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state) &&
> +		    amdgpu_exp_freesync_vid_mode) {
> +			new_crtc_state->mode_changed = false;
> +			DRM_DEBUG_DRIVER(
> +				"Mode change not required for front porch change, "
> +				"setting mode_changed to %d",
> +				new_crtc_state->mode_changed);
> +
> +			set_freesync_fixed_config(dm_new_crtc_state);
> +
> +			goto skip_modeset;
> +		} else if (aconnector &&
> +			   is_freesync_video_mode(&new_crtc_state->mode, aconnector))
> +			set_freesync_fixed_config(dm_new_crtc_state);
> +
>   		ret = dm_atomic_get_state(state, &dm_state);
>   		if (ret)
>   			goto fail;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 251af783f6b1..28f2d8c9b260 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -453,6 +453,7 @@ struct dm_crtc_state {
>   
>   	bool freesync_timing_changed;
>   	bool freesync_vrr_info_changed;
> +	bool freesync_video_mode;
>   
>   	bool dsc_force_changed;
>   	bool vrr_supported;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
