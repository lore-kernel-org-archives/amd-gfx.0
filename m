Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719FC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 12:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE8823D50
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 12:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE8823D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7010A6E0C6;
	Thu, 10 Dec 2020 12:59:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12F76E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 12:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUsLWDFe1LhTj0blI5369hs1HNWketvYg+I3m3j7RBp66pDwiSHd6D55uASLoCmQhyS9ICPNLiSI8Q6jdcfylEStNh6Cr4gF7FX76yuMxG+2KgU+TZRUA9u8sZMRkWY9shjPphbun3QQwNOUIkD72dLhsNHnzIqz4yG75ReiA+4eS6ESdBEui16FPeakhHhpsx3Gkd2eyL60RlKN/aDmIH++yP/lqG20bhLNaBWQCVroBKsUkp/trvjvgjKpEIgFWMefs67T1I5IJsBUZ1iGSWggWenBrYMLEjTdK81HWbkhw1CQYO5nYv50Odbr5N2e3EIshXBLuj6I3NpohpwRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNA5aRqMABIv33jjJSTFShY5hqtnR2mM4AUt7eDVkK0=;
 b=XaEWsr8ccXdPgzqT4SZ1H1DoVdCxpBOWLgnvrC2rUVAQWl9OWZ2x1NMf3jc01FGp8VEvzcQlFVHJzTMY2wWxJXFge2XkH/fFjXlNJmpe4qsLdzCnGBIg9GTHSkFeqUwyqRjNQO2TRD8pPrtWjtBbiJsJJAEHFqT/31jtFPrWr4rx73y/HUeFAKqZZZh6sg/ROw9QOmW3fxGfmL4hO7rE87uxLdZyggz9aBcn1qBxdAz/NMxZP4116XQiQGdU5xbU3dZYtFdsDcj7niwxb7jllhEslwTUmm6UwOHOvZXHOiaAEc83ARZEb7+ZL2VHvpMZADSSGfqxUvEkvn/aEsmWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNA5aRqMABIv33jjJSTFShY5hqtnR2mM4AUt7eDVkK0=;
 b=doSQ8oxsb3RIZaSfBc6yZHLgSqzMk9FoZ5LMXKClJHuN8UofDu75ytakwiyRsTB4WFPpLnIAOvq8vSEnPR7JdCnLnQ8oxwL31Ko4ANosYTMNgO46kdxq+iHLVieC7w0l1TfUAlIFNP92dIPyVTt85Wlqaliptfxtk9DoZ2NoRVU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3133.namprd12.prod.outlook.com (2603:10b6:208:c7::16)
 by MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 10 Dec
 2020 12:59:23 +0000
Received: from MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135]) by MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 12:59:22 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: Skip modeset for front porch change
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-4-aurabindo.pillai@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <9cc10157-d533-95fd-0f20-8bbc2db75a79@amd.com>
Date: Thu, 10 Dec 2020 18:29:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201210024526.1151447-4-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [106.51.105.40]
X-ClientProxiedBy: MA1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::23) To MN2PR12MB3133.namprd12.prod.outlook.com
 (2603:10b6:208:c7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.105.40) by
 MA1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 12:59:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57855b04-ad39-4072-8b0c-08d89d0b6a77
X-MS-TrafficTypeDiagnostic: MN2PR12MB3087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3087C241AB1835BC7DEE2595F2CB0@MN2PR12MB3087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8q37C08G98HHFnL/sA9xY6uqtAwtZFnkCU+OMw2H1tUqOVRVv92IgoRhfSsLmA/qrRjCTET6ltkMBhNLpC8a7fS8qEl8ADkYDUPb2sMZCAuQ/ofBJvKMw6SlSRDC/r2Ah8CrlTbsEMiLTwZZbderCaaZv+k6mszesJzANkFBT+qQ9Dkhi/WMRtYuBj/YF7WqXDrBJB2olM7nR7dJPQv5Jucue5MmOO7s8LrvJLZH6KMLv0GOTexeNqek1R0UfxuydtoVNQAG+Y3tCB4gkWr+UyDlejFpU93iMXA1zKFY0zueRivBRFP5J6JiBQZ0vPyx0IcH96aOrrYobqQblFzjVWm9hWINGwZuqcgDsW/9zxEhX4v9tQV1ThzdwO1xevYBNhc7bV0lIRK45NDkvOmBql8ox2DrdMW312mq4m1C3zEcAAYiV72G28tnK4+wa1g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(31686004)(30864003)(86362001)(31696002)(6486002)(83380400001)(956004)(34490700003)(8936002)(2906002)(53546011)(5660300002)(8676002)(66946007)(16576012)(26005)(1006002)(6666004)(66476007)(52116002)(2616005)(66556008)(44832011)(186003)(4326008)(508600001)(55236004)(16526019)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TnpoVWtSdm5kZWlLeUhaSDFGYy8rb05qd3lLU1BsNkwrbFlXcHhFa0dpN3hM?=
 =?utf-8?B?b2F5SkhvT0MwZ3p3RkUwN0tLbG80WE5wbkF5cGgzaTMwUTIrOE96SktPcVo5?=
 =?utf-8?B?cURxaHF0VVJSZUhPQk5oOUdWdG12TFRaSW01dDBYZ1lsRXhDcEU1Ym5ROEJ5?=
 =?utf-8?B?VXh5eDRJRmhSOXRIcmQyS3RCbnN1WVh0MlBNSzVkTnpETDFEbHRycHFwVHJo?=
 =?utf-8?B?U2JGN0EvTVBJelAzQTczWWdueFoxdGtqKzN4SFIza0hBajdTZWxHdDFJVW1E?=
 =?utf-8?B?bVlhTlJoUGNwU001MXRuK2MzUW8vUUUwV1U1L0dENmk4b1RGazlQcUxiWGhx?=
 =?utf-8?B?a3R0anE0cTJWT29PSk9VYWV0VWtFald5MzNIQXBPYkFaM0NqeGozR3duSXcx?=
 =?utf-8?B?NUJqVWR2NDlHRGdqM1JMRjRZTTJFMGxZQ3VoZ0ZoN256QkphM05aS0cxbXNQ?=
 =?utf-8?B?UEFlSXN6K2NrWmpDQTAvUHJkTlJxVlBSa3hQdlBzNG5HQ2hpT2VuZ3VESWRp?=
 =?utf-8?B?ZHdRTCt4TmxzS2Z0OUdwcWJIMVNLUm1MWndRN2xsNUFxbEpuWDZlOVh5RlBR?=
 =?utf-8?B?SXpsNXBTZjNFa3JXSGhYQjYvanZsS3gxMThFWG8wMlhGSWtucG9VOWdIUmt2?=
 =?utf-8?B?TG03a0d1YU1PdTdLZGE3SmtvRER1V3dHRnY4eFBpS091TFIrckpWVTRLVEtQ?=
 =?utf-8?B?WWtlb1pEaXk4M1JOUlhVS2phRThGK0tMdllqWGpQYk8xeUZvK1NFNG5qRUQz?=
 =?utf-8?B?eG9ySzlLbDFTaTZ5aEhVWkUrOWtZdmJ4MGpZeFJlQkpmT2thYmM3UlZMRUVO?=
 =?utf-8?B?MWh4NE0zWnZ3WE9oTXJZMGpSNlc4STF2OVJDYnFWL0JXYVBjaFlUZmRZcDBQ?=
 =?utf-8?B?Y1JoNmJYcWJKWXBFQXN2U3pub2dodHM0eFNaRTNSYTZSWlNtSUlLdEg5R3Az?=
 =?utf-8?B?akpIWkVRbFI4WHN1YWxRajFkTlVaNWNaT3EzUC8vM3NtendBeUsrUyttTGZD?=
 =?utf-8?B?aG1zSDF4YlJQbnFWYm9YK09SbHlPVnlNemk3UE84UHhhTysyWkZCYVhCOVBh?=
 =?utf-8?B?c0ZlNUJ5RnozeW5OcGtrSkxEZjJaT3A2WC9QbEV0Nzd4cWoyRkc0VFJtVm9I?=
 =?utf-8?B?cFN4Tkg2cmtwZm93VFo1M214eXp5c1pGaTU1ZnBtSm9MUWROaWs2TVRhLyth?=
 =?utf-8?B?aEpnTGJpYVhrNVh1VTlmM3lzOTBwRUl4UHVDZW04Qk5CTWRubXBrTHdVanVt?=
 =?utf-8?B?WDJYbzV1dE80YXdIanhuajIwU05pM3I5R1FIMUNzMWE1ZWF2Y3NkUlNEMHNi?=
 =?utf-8?Q?L3rTq1ZlcLhI8QdYho6oumpVvoua3RQ5vc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 12:59:22.7786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 57855b04-ad39-4072-8b0c-08d89d0b6a77
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvPB6wYePcNiscMi72MW9ge8ik3GOCd4qXgyetAFZmz9syKXpFGTnqvoJQg1INKHu5CsU1SMQo8fHzQXCmllVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3087
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, wayne.lin@amd.com,
 alexander.deucher@amd.com, Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/12/20 8:15 am, Aurabindo Pillai wrote:
> [Why&How]
> Inorder to enable freesync video mode, driver adds extra
> modes based on preferred modes for common freesync frame rates.
> When commiting these mode changes, a full modeset is not needed.
> If the change in only in the front porch timing value, skip full
> modeset and continue using the same stream.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 169 ++++++++++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>  2 files changed, 153 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f699a3d41cad..c8c72887906a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -217,6 +217,9 @@ static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
>  static const struct drm_format_info *
>  amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
>  
> +static bool
> +is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
> +				 struct drm_crtc_state *new_crtc_state);
>  /*
>   * dm_vblank_get_counter
>   *
> @@ -5096,8 +5099,11 @@ copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
>  static void
>  decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
>  					const struct drm_display_mode *native_mode,
> -					bool scale_enabled)
> +					bool scale_enabled, bool fs_mode)
>  {
> +	if (fs_mode)
> +		return;
so we are adding an input flag just so that we can return from the function at top ? How about adding this check at the caller without changing the function parameters ?
> +
>  	if (scale_enabled) {
>  		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
>  	} else if (native_mode->clock == drm_mode->clock &&
> @@ -5241,6 +5247,24 @@ get_highest_freesync_mode(struct amdgpu_dm_connector *aconnector,
>  	return m_high;
>  }
>  
> +static bool is_freesync_video_mode(struct drm_display_mode *mode,
> +				   struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_display_mode *high_mode;
> +
I thought we were adding a string "_FSV" in the end for the mode->name, why can't we check that instead of going through the whole list of modes again ?
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
>  static struct dc_stream_state *
>  create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>  		       const struct drm_display_mode *drm_mode,
> @@ -5253,17 +5277,21 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>  	const struct drm_connector_state *con_state =
>  		dm_state ? &dm_state->base : NULL;
>  	struct dc_stream_state *stream = NULL;
> -	struct drm_display_mode mode = *drm_mode;
> +	struct drm_display_mode saved_mode, mode = *drm_mode;
How about shifting this definition to new line to follow the existing convention ?
> +	struct drm_display_mode *freesync_mode = NULL;
>  	bool native_mode_found = false;
>  	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
>  	int mode_refresh;
>  	int preferred_refresh = 0;
> +	bool is_fs_vid_mode = 0;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	struct dsc_dec_dpcd_caps dsc_caps;
>  #endif
>  	uint32_t link_bandwidth_kbps;
> -
>  	struct dc_sink *sink = NULL;
> +
> +	memset(&saved_mode, 0, sizeof(struct drm_display_mode));
> +
>  	if (aconnector == NULL) {
>  		DRM_ERROR("aconnector is NULL!\n");
>  		return stream;
> @@ -5316,20 +5344,33 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>  		 */
>  		DRM_DEBUG_DRIVER("No preferred mode found\n");
>  	} else {
> +		is_fs_vid_mode = is_freesync_video_mode(&mode, aconnector);
> +		if (is_fs_vid_mode) {
> +			freesync_mode = get_highest_freesync_mode(aconnector, false);
> +			if (freesync_mode) {
As the freesync modes are being added by the driver, and we have passed one check which says is_fs_vid_mode, will it ever be the case where freesync_mode == NULL ? Ideally we should get atleast one mode equal to this isn't it ? in that case we can drop one if () check.
> +				saved_mode = mode;
> +				mode = *freesync_mode;
> +			}
> +		}
> +
>  		decide_crtc_timing_for_drm_display_mode(
>  				&mode, preferred_mode,
> -				dm_state ? (dm_state->scaling != RMX_OFF) : false);
> +				dm_state ? (dm_state->scaling != RMX_OFF) : false,
> +				freesync_mode ? true : false);
>  		preferred_refresh = drm_mode_vrefresh(preferred_mode);
>  	}
>  
>  	if (!dm_state)
>  		drm_mode_set_crtcinfo(&mode, 0);
>  
> -	/*
> +	if (dm_state && is_fs_vid_mode && freesync_mode)

Same here, I guess if is_fs_vide_mode == true, freesync_mode must never be NULL

- Shashank

> +		drm_mode_set_crtcinfo(&saved_mode, 0);
> +
> +       /*
>  	* If scaling is enabled and refresh rate didn't change
>  	* we copy the vic and polarities of the old timings
>  	*/
> -	if (!scale || mode_refresh != preferred_refresh)
> +	if (!(scale && freesync_mode) || mode_refresh != preferred_refresh)
>  		fill_stream_properties_from_drm_display_mode(stream,
>  			&mode, &aconnector->base, con_state, NULL, requested_bpc);
>  	else
> @@ -7881,13 +7922,29 @@ static void update_stream_irq_parameters(
>  	if (new_crtc_state->vrr_supported &&
>  	    config.min_refresh_in_uhz &&
>  	    config.max_refresh_in_uhz) {
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
>  		config.state = new_crtc_state->base.vrr_enabled ?
>  			VRR_STATE_ACTIVE_VARIABLE :
>  			VRR_STATE_INACTIVE;
> -	} else {
> +	} else
>  		config.state = VRR_STATE_UNSUPPORTED;
> -	}
>  
> +out:
>  	mod_freesync_build_vrr_params(dm->freesync_module,
>  				      new_stream,
>  				      &config, &vrr_params);
> @@ -8205,7 +8262,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  		 * as part of commit.
>  		 */
>  		if (amdgpu_dm_vrr_active(dm_old_crtc_state) !=
> -		    amdgpu_dm_vrr_active(acrtc_state)) {
> +		    amdgpu_dm_vrr_active(acrtc_state) ||
> +		    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED ||
> +		    acrtc_state->freesync_video_mode) {
>  			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>  			dc_stream_adjust_vmin_vmax(
>  				dm->dc, acrtc_state->stream,
> @@ -8896,6 +8955,7 @@ static void get_freesync_config_for_crtc(
>  			to_amdgpu_dm_connector(new_con_state->base.connector);
>  	struct drm_display_mode *mode = &new_crtc_state->base.mode;
>  	int vrefresh = drm_mode_vrefresh(mode);
> +	bool fs_vid_mode = false;
>  
>  	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
>  					vrefresh >= aconnector->min_vfreq &&
> @@ -8903,17 +8963,26 @@ static void get_freesync_config_for_crtc(
>  
>  	if (new_crtc_state->vrr_supported) {
>  		new_crtc_state->stream->ignore_msa_timing_param = true;
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
>  		config.vsif_supported = true;
>  		config.btr = true;
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
>  	new_crtc_state->freesync_config = config;
>  }
>  
> @@ -8926,6 +8995,51 @@ static void reset_freesync_config_for_crtc(
>  	       sizeof(new_crtc_state->vrr_infopacket));
>  }
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
>  static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  				struct drm_atomic_state *state,
>  				struct drm_crtc *crtc,
> @@ -9016,6 +9130,11 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  		 * TODO: Refactor this function to allow this check to work
>  		 * in all conditions.
>  		 */
> +		if (dm_new_crtc_state->stream &&
> +		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state) &&
> +		    amdgpu_exp_freesync_vid_mode)
> +			goto skip_modeset;
> +
>  		if (dm_new_crtc_state->stream &&
>  		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
>  		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream)) {
> @@ -9047,6 +9166,22 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  		if (!dm_old_crtc_state->stream)
>  			goto skip_modeset;
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
>  		ret = dm_atomic_get_state(state, &dm_state);
>  		if (ret)
>  			goto fail;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 251af783f6b1..28f2d8c9b260 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -453,6 +453,7 @@ struct dm_crtc_state {
>  
>  	bool freesync_timing_changed;
>  	bool freesync_vrr_info_changed;
> +	bool freesync_video_mode;
>  
>  	bool dsc_force_changed;
>  	bool vrr_supported;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
