Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D95AC33CAC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 16:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F4420838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hXBZgxrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F4420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D756E0C6;
	Thu,  6 Feb 2020 16:58:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBFF6E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 16:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrKI0TDmtfjmIbTMA+ml2b9+6EI4cc0dqC/TWFucWMqIua2qRnfBoY6evRjW8oUYAhfRvoeuRkP0NzMYDb5LUvcuOqJVsLi/e2GNuzf9eefA5eLasjqJIdr5i8enD1MD+qImNsxVfp00/5DGb3FLHF1S1EXlf0SiSyDh7mkZvksHDuY8k6M+7HQGvenLxUz2yEfmGsR3Q3il9Twa0rWGrQup2RLGn5XBr88yty2tjI301ZOPwr55QR6WaPlcVPWL02B8dJN3y1jhRtmv9cwAtDWBrBTS1hD7kIHThk3NcUSjaGgtp7zbXBPwTLqmkRm4nC1FIV9kss+30biJ+8SXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL0NfkWE9OPVyaE/3LHS1S1ncoV6qFgy1oNBS7F7ZN8=;
 b=S5CSxPhLvSOmYd4gqpAfPwUxBvcytthu8kRPro4hOqaK8/Es0roNxuxYdEJOR593dKd4wdsM4msftIqywmmE3dLQPuU5FCJalhWTS26e/K6vOfwMejuyH3LnxHvB90ZBbMhdCR3lArzpDYFgwJsGoOIkGD2s1T0ccDpZj2kzqakXcZ4jLS3pTRcUHey2S1nxiwwNKFk77FHcSn7mboytfXK++4CCbjP5XxD36o+awefVv2QSvmsBaKL9bhm7VQgrssHsWKv5zrAsAtCAM5CbEMRTUKAAsOkVAis4VuXTaHuEBy6Nx/WzF6u/D58a1YeuRyiedJfHp2i0V79qePcMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL0NfkWE9OPVyaE/3LHS1S1ncoV6qFgy1oNBS7F7ZN8=;
 b=hXBZgxrcJOvzE9+5u/ogsBEX1LNAkPfX35wj+bRvSbVWH6xO4VPheHYSkw3wpm86cxWvUyrXx5Fx+bpfsxPJH1tRVycnBSVnk6+reHBRrIC8CT6aDu3fC1/1BJZS081ic1vCbDilgYUhihqCs7Vw4eeg9G9Xr830ew1gXPeEVgA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2678.namprd12.prod.outlook.com (20.176.253.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 16:58:46 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5f8:d155:b213:ef50]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5f8:d155:b213:ef50%3]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 16:58:45 +0000
Subject: Re: [PATCH] drm/amd/display: Indicate use of TMZ buffers to DC
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200206165423.18438-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <9501c270-edb9-04a4-bdd4-7cfe822631d7@amd.com>
Date: Thu, 6 Feb 2020 11:58:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200206165423.18438-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
Received: from [172.29.1.94] (165.204.55.250) by
 YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 16:58:45 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1b0eeb8-43e5-4735-6bfe-08d7ab25d420
X-MS-TrafficTypeDiagnostic: BYAPR12MB2678:|BYAPR12MB2678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB267804DB180AD055AF86A547EC1D0@BYAPR12MB2678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(6486002)(31696002)(86362001)(2906002)(5660300002)(31686004)(66946007)(478600001)(4326008)(66556008)(66476007)(8676002)(956004)(2616005)(26005)(8936002)(81166006)(81156014)(52116002)(36756003)(186003)(316002)(16576012)(53546011)(6666004)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2678;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZFfJ0EbMWb3udFj6GXs7rgaMEeHPL+Qg4h6bbOmmq+PBCZOIOwRS500+gju1aRJI/f+lS204C2zUr0qPcMStTAKIhwApyyscKqbnwxAwUmeUuJijcAe1HWkJF9aUTWnWtBHnQ0KjeQIvaEOsuxVccrhckLoSHXkA9tUsimJ8o1QmA8O6CgL2rkKvOtmB8FXFCPAxZZ3KifCAfONXao7kXAbcOI6bXH608uPTT4MMyeY+oWqSyiF9NaD/w52UZnUBRf8FcGtjD8osxFkqhXfBwqgxKirbI5pwm9R+CUbdE7g0+0pRcsVRmtgAfoCmhJvg8sHJJcKwxyWlR+rCANmIdW9jle4ieIuV//N81VlWsXpijW/u4Kt+hCBR4Vd/vQ9Kkf/+T+9qWrSA2IobQy2S0XAR2g0aU5o6AlyqCOeR9A2qrspso4khrc+gOhmwClk
X-MS-Exchange-AntiSpam-MessageData: uUxfKjJC4m+17FhjbCozvIzlmR9WeJgQcTv5DXb3ruo0W5QPTQVD9TolsfHfhdXmoRDJj3t+oxA4SpSi+qJjj1TlsdWuAbEBaJHuKIEiwIur/U3AOFlL65EQpuBM4i43w0HWgbZu7jt6Wb93xOUdhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b0eeb8-43e5-4735-6bfe-08d7ab25d420
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 16:58:45.8408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +e5a2K/rzUqsKY9mN9QHJNd/1V3zvY/Bp1KEtFGwZ6MhWTZ1l6+lNPiRyK+10epZtJ1nYX6V8O0SD4kbOzzrLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2678
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-06 11:54 a.m., Bhawanpreet Lakha wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [Why]
> Hubp needs to know whether a buffer is being scanned out from the trusted
> memory zone or not.
> 
> [How]
> Check for the TMZ flag on the amdgpu_bo and set the tmz_surface flag in
> dc_plane_address accordingly.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++++++++++------
>   1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7f6d3b0f9efc..73000f1e1734 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3166,7 +3166,7 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
>   }
>   
>   static int get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
> -		       uint64_t *tiling_flags)
> +		       uint64_t *tiling_flags, bool *tmz_surface)
>   {
>   	struct amdgpu_bo *rbo = gem_to_amdgpu_bo(amdgpu_fb->base.obj[0]);
>   	int r = amdgpu_bo_reserve(rbo, false);
> @@ -3181,6 +3181,9 @@ static int get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
>   	if (tiling_flags)
>   		amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
>   
> +	if (tmz_surface)
> +		*tmz_surface = amdgpu_bo_encrypted(rbo);
> +
>   	amdgpu_bo_unreserve(rbo);
>   
>   	return r;
> @@ -3263,7 +3266,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>   			     union dc_tiling_info *tiling_info,
>   			     struct plane_size *plane_size,
>   			     struct dc_plane_dcc_param *dcc,
> -			     struct dc_plane_address *address)
> +			     struct dc_plane_address *address,
> +			     bool tmz_surface)
>   {
>   	const struct drm_framebuffer *fb = &afb->base;
>   	int ret;
> @@ -3273,6 +3277,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
>   	memset(dcc, 0, sizeof(*dcc));
>   	memset(address, 0, sizeof(*address));
>   
> +	address->tmz_surface = tmz_surface;
> +
>   	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
>   		plane_size->surface_size.x = 0;
>   		plane_size->surface_size.y = 0;
> @@ -3461,7 +3467,8 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>   			    const struct drm_plane_state *plane_state,
>   			    const uint64_t tiling_flags,
>   			    struct dc_plane_info *plane_info,
> -			    struct dc_plane_address *address)
> +			    struct dc_plane_address *address,
> +			    bool tmz_surface)
>   {
>   	const struct drm_framebuffer *fb = plane_state->fb;
>   	const struct amdgpu_framebuffer *afb =
> @@ -3540,7 +3547,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>   					   plane_info->rotation, tiling_flags,
>   					   &plane_info->tiling_info,
>   					   &plane_info->plane_size,
> -					   &plane_info->dcc, address);
> +					   &plane_info->dcc, address, tmz_surface);
>   	if (ret)
>   		return ret;
>   
> @@ -3563,6 +3570,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   	struct dc_plane_info plane_info;
>   	uint64_t tiling_flags;
>   	int ret;
> +	bool tmz_surface = false;
>   
>   	ret = fill_dc_scaling_info(plane_state, &scaling_info);
>   	if (ret)
> @@ -3573,13 +3581,14 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   	dc_plane_state->clip_rect = scaling_info.clip_rect;
>   	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
>   
> -	ret = get_fb_info(amdgpu_fb, &tiling_flags);
> +	ret = get_fb_info(amdgpu_fb, &tiling_flags, &tmz_surface);
>   	if (ret)
>   		return ret;
>   
>   	ret = fill_dc_plane_info_and_addr(adev, plane_state, tiling_flags,
>   					  &plane_info,
> -					  &dc_plane_state->address);
> +					  &dc_plane_state->address,
> +					  tmz_surface);
>   	if (ret)
>   		return ret;
>   
> @@ -5174,6 +5183,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   	uint64_t tiling_flags;
>   	uint32_t domain;
>   	int r;
> +	bool tmz_surface = false;
>   
>   	dm_plane_state_old = to_dm_plane_state(plane->state);
>   	dm_plane_state_new = to_dm_plane_state(new_state);
> @@ -5222,6 +5232,8 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   
>   	amdgpu_bo_get_tiling_flags(rbo, &tiling_flags);
>   
> +	tmz_surface = amdgpu_bo_encrypted(rbo);
> +
>   	ttm_eu_backoff_reservation(&ticket, &list);
>   
>   	afb->address = amdgpu_bo_gpu_offset(rbo);
> @@ -5236,7 +5248,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   			adev, afb, plane_state->format, plane_state->rotation,
>   			tiling_flags, &plane_state->tiling_info,
>   			&plane_state->plane_size, &plane_state->dcc,
> -			&plane_state->address);
> +			&plane_state->address, tmz_surface);
>   	}
>   
>   	return 0;
> @@ -6417,6 +6429,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   	unsigned long flags;
>   	struct amdgpu_bo *abo;
>   	uint64_t tiling_flags;
> +	bool tmz_surface = false;
>   	uint32_t target_vblank, last_flip_vblank;
>   	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
>   	bool pflip_present = false;
> @@ -6515,12 +6528,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   
>   		amdgpu_bo_get_tiling_flags(abo, &tiling_flags);
>   
> +		tmz_surface = amdgpu_bo_encrypted(abo);
> +
>   		amdgpu_bo_unreserve(abo);
>   
>   		fill_dc_plane_info_and_addr(
>   			dm->adev, new_plane_state, tiling_flags,
>   			&bundle->plane_infos[planes_count],
> -			&bundle->flip_addrs[planes_count].address);
> +			&bundle->flip_addrs[planes_count].address, tmz_surface);
>   
>   		bundle->surface_updates[planes_count].plane_info =
>   			&bundle->plane_infos[planes_count];
> @@ -7889,6 +7904,7 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
>   			struct dc_flip_addrs *flip_addr = &bundle->flip_addrs[num_plane];
>   			struct dc_scaling_info *scaling_info = &bundle->scaling_infos[num_plane];
>   			uint64_t tiling_flags;
> +			bool tmz_surface = false;
>   
>   			new_plane_crtc = new_plane_state->crtc;
>   			new_dm_plane_state = to_dm_plane_state(new_plane_state);
> @@ -7934,14 +7950,14 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
>   			bundle->surface_updates[num_plane].scaling_info = scaling_info;
>   
>   			if (amdgpu_fb) {
> -				ret = get_fb_info(amdgpu_fb, &tiling_flags);
> +				ret = get_fb_info(amdgpu_fb, &tiling_flags, &tmz_surface);
>   				if (ret)
>   					goto cleanup;
>   
>   				ret = fill_dc_plane_info_and_addr(
>   					dm->adev, new_plane_state, tiling_flags,
> -					plane_info,
> -					&flip_addr->address);
> +					&plane_info,
> +					&flip_addr.address, tmz_surface);
>   				if (ret)
>   					goto cleanup;
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
