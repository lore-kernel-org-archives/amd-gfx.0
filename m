Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658CDC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D1F22242
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dckn1utd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D1F22242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E69389D7F;
	Mon, 26 Oct 2020 13:54:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C2089D7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 13:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyGwYlJj1OKrJcLZkBCKd55R3cjJ15jTfEDK1Jdk6pL8L8+aUrxBzpoiu7dLDTjPvLd9VDEcKBJm0R08pH0CIR3Wy92CTiTzszRgBxH9Jz1YvN3B5lk2krVXV3qKyfiO8HGyW3uYoNU3CW96E+zMKo7CvfsUhs8Lv4QR8HD2Dye0+z0+L6M5l75AWA8ghLXxgCAC4MXM8Av7JjSx1PSMFAABsZ6wK3QyHcVBQ+MHaNk2lbAmROnQQlSQYVtaWmPAsOitp/K7AsmU3I9Knyo9z97x8Fom5QeHLdQ96I+7XcNgE8TEkFygItgQmGgRUxzZ/j4LC4JQuznfftFD6cp2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kccO+OWTSiLqf7iGTzb0LatQhbRn8Y/+dqdDz/xv+dE=;
 b=Wkgu/RQ2MigEBVz/pk0xfukkAxANt2feKbtMW2hymEQgHsIYnTchzDsCLc1xkr2xd8Ey+g8wanmo2+vJxKf0qYl87yJV3yB10NXewiOKNDFu1tBddOJ8qW9O+RwmPHtJy5gX3zrA+8RHqRmK+W9iv+m1qY3loF0QxLQmJHdf24sRlPqpDBZrauxbF8rl7I9KUqCzmISt5vQpI2cXgjUFZVY1CDEFIttmao3JLjTckw/Rt8/C6itXfRzhfFihOe1RmYVF4/AgsX0aOMb3n0GZCw7tGXWK19rpH4UDjVsw9BzEJtVYzuaLw6wixes27/FVDBhWwRofVbFsAACBzKIb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kccO+OWTSiLqf7iGTzb0LatQhbRn8Y/+dqdDz/xv+dE=;
 b=dckn1utdpm+/KKPmavs8ldjbvHGrCNLgB6dgRpSqnnAIR60D5Xg1UHamoN9nIflS5QA+BDVTXW+f0F+RG8usCleerhxreayJDLOZtxxVeSCeeKgYNnbgP7/FCXA+rmu7V91s3VH+ScWqyjGf80h3qieJ725XxFnCLJfbmB/SZxE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3239.namprd12.prod.outlook.com (2603:10b6:a03:137::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 26 Oct
 2020 13:54:30 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 13:54:30 +0000
Subject: Re: [PATCH v3 05/11] drm/amd/display: Store tiling_flags in the
 framebuffer.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
 <20201021233130.874615-6-bas@basnieuwenhuizen.nl>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <cb79481c-9c3b-2a36-1503-6149eb49daf6@amd.com>
Date: Mon, 26 Oct 2020 09:54:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201021233130.874615-6-bas@basnieuwenhuizen.nl>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::14) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 13:54:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d122cce8-a4cc-4aab-4427-08d879b6a92b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3239A31A6D89CA629246ED7BEC190@BYAPR12MB3239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iXsJfhFjj7zezvwAv9cM+EiZDCdz4wCHqN5tAZCOCUGB98v5N4d6L/NITvrNPi9dEljxVWwZ9QL027o6ne0SXZwWNOYOOiyHfGHVrmNhUm4Hq+iSKaGmpRqe7Ol0swboOYz4AMlTjfJ3N9RhmiDEL2pJU5mXFFmpxRyPi0Z3nr9SzppTL7m81Y6tPKLk/0kEYqawd4/GeaSJ2acqafz7LXEee/mkWmizoljEHwSvD2//Zv5D7OTZMT8p9/RYuLNxr7dP8Z4njsJrjVWAthVRN31IGE19V70ZzKNHq0Ta+yJbRXKnfyXalIJIQrwYtuuVAfROxHcGuOtSVE4OVDwSt3aOW71sq+4jtXtWb2g7fFNZjPES9MKEvoVrloihhub
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(5660300002)(2906002)(66946007)(16526019)(52116002)(66476007)(4326008)(186003)(31696002)(316002)(8676002)(6666004)(66556008)(31686004)(6486002)(8936002)(16576012)(53546011)(478600001)(26005)(2616005)(36756003)(83380400001)(4001150100001)(956004)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1XRMsaoJrSYRkMDTtT3tA5RnY0rubmIZTf8xKqC7SDBepu/MEAjajaDEHgpRsbjmQbUexDm1VWZiPfy1d4eP8HqRc6Fj6X0d1KhdwoYeQRpNWtbkPE9i+G7qYicJMVvbpktHS8okt9UHOhn1ezpETI3YP6bZOw9RuQiog8Y2KZhM3S5LqF5JUya17bL6+bOBH2n+CCbxc9W8kpNVquGUWJTIEd7/YQjvIN1nqklcUwstFeImbGax/A+Ov0CmEnnxKMFS3QY6K3AbfZnHxe64HizxxTLhhgdfbwiOlPFC4V52S9HPTrMyjwGgHdnBJSGT+Q0Tasiwb1n+clpcUSfiZRhgdswXzByUDYbeKrvx6GwMMvyyWNX7NKWR0L/5euv6lP7zWRtXRw4q8vhri9GtdKgy/3758QTb10fvBbAQsOy1LDOXO4/UJq3iRSEKp1hhJYse8hjyE+tDiV+tKSDwKgmXvWjYytFKpfWZ+aWAf/xfm1LPzpimSK6PrCk8hnaEWSmI+nxjYazJ1ZGV7uA7z39JVod2YSey7/v4wYJbZCN61FJynIj6fLt3NH8cicAGZ4LWaVC2PszhRrr15lQCr5pTGyos5yJrl/Yk2xVvLIBbYTbX7MSL+iREWJdZyOTQBhNINSssdZ7AoHx44IfblA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d122cce8-a4cc-4aab-4427-08d879b6a92b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 13:54:30.4837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPIhcpurDHMj71FJJxPpcQfJabFOq6cQlNOR0YfaGznGaCU3XuuAl55XiFsN1/e/r83y8aOJR7MPQhgtVSnOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
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
Cc: alexdeucher@gmail.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 maraeo@gmail.com, daniel@ffwll.ch
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-21 7:31 p.m., Bas Nieuwenhuizen wrote:
> This moves the tiling_flags to the framebuffer creation.
> This way the time of the "tiling" decision is the same as it
> would be with modifiers.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 48 +++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  3 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 +++----------------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 -
>   4 files changed, 59 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 9e92d2a070ac..1a2664c3fc26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -541,6 +541,39 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>   	return domain;
>   }
>   
> +static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
> +				      uint64_t *tiling_flags, bool *tmz_surface)
> +{
> +	struct amdgpu_bo *rbo;
> +	int r;
> +
> +	if (!amdgpu_fb) {
> +		*tiling_flags = 0;
> +		*tmz_surface = false;
> +		return 0;
> +	}
> +
> +	rbo = gem_to_amdgpu_bo(amdgpu_fb->base.obj[0]);
> +	r = amdgpu_bo_reserve(rbo, false);
> +
> +	if (unlikely(r)) {
> +		/* Don't show error message when returning -ERESTARTSYS */
> +		if (r != -ERESTARTSYS)
> +			DRM_ERROR("Unable to reserve buffer: %d\n", r);
> +		return r;
> +	}
> +
> +	if (tiling_flags)
> +		amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
> +
> +	if (tmz_surface)
> +		*tmz_surface = amdgpu_bo_encrypted(rbo);
> +
> +	amdgpu_bo_unreserve(rbo);
> +
> +	return r;
> +}
> +
>   int amdgpu_display_framebuffer_init(struct drm_device *dev,
>   				    struct amdgpu_framebuffer *rfb,
>   				    const struct drm_mode_fb_cmd2 *mode_cmd,
> @@ -550,11 +583,18 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
>   	rfb->base.obj[0] = obj;
>   	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
>   	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> -	if (ret) {
> -		rfb->base.obj[0] = NULL;
> -		return ret;
> -	}
> +	if (ret)
> +		goto fail;
> +
> +	ret = amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb->tmz_surface);
> +	if (ret)
> +		goto fail;
> +
>   	return 0;
> +
> +fail:
> +	rfb->base.obj[0] = NULL;
> +	return ret;
>   }
>   
>   struct drm_framebuffer *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 345cb0464370..39866ed81c16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -304,6 +304,9 @@ struct amdgpu_display_funcs {
>   struct amdgpu_framebuffer {
>   	struct drm_framebuffer base;
>   
> +	uint64_t tiling_flags;
> +	bool tmz_surface;
> +
>   	/* caching for later use */
>   	uint64_t address;
>   };
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 833887b9b0ad..5a0efaefbd7f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3839,39 +3839,6 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
>   	return 0;
>   }
>   
> -static int get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
> -		       uint64_t *tiling_flags, bool *tmz_surface)
> -{
> -	struct amdgpu_bo *rbo;
> -	int r;
> -
> -	if (!amdgpu_fb) {
> -		*tiling_flags = 0;
> -		*tmz_surface = false;
> -		return 0;
> -	}
> -
> -	rbo = gem_to_amdgpu_bo(amdgpu_fb->base.obj[0]);
> -	r = amdgpu_bo_reserve(rbo, false);
> -
> -	if (unlikely(r)) {
> -		/* Don't show error message when returning -ERESTARTSYS */
> -		if (r != -ERESTARTSYS)
> -			DRM_ERROR("Unable to reserve buffer: %d\n", r);
> -		return r;
> -	}
> -
> -	if (tiling_flags)
> -		amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
> -
> -	if (tmz_surface)
> -		*tmz_surface = amdgpu_bo_encrypted(rbo);
> -
> -	amdgpu_bo_unreserve(rbo);
> -
> -	return r;
> -}
> -
>   static inline uint64_t get_dcc_address(uint64_t address, uint64_t tiling_flags)
>   {
>   	uint32_t offset = AMDGPU_TILING_GET(tiling_flags, DCC_OFFSET_256B);
> @@ -4287,7 +4254,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   				    struct drm_crtc_state *crtc_state)
>   {
>   	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
> -	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
> +	struct amdgpu_framebuffer *afb = (struct amdgpu_framebuffer *)plane_state->fb;
>   	struct dc_scaling_info scaling_info;
>   	struct dc_plane_info plane_info;
>   	int ret;
> @@ -4304,10 +4271,10 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   
>   	force_disable_dcc = adev->asic_type == CHIP_RAVEN && adev->in_suspend;
>   	ret = fill_dc_plane_info_and_addr(adev, plane_state,
> -					  dm_plane_state->tiling_flags,
> +					  afb->tiling_flags,
>   					  &plane_info,
>   					  &dc_plane_state->address,
> -					  dm_plane_state->tmz_surface,
> +					  afb->tmz_surface,
>   					  force_disable_dcc);
>   	if (ret)
>   		return ret;
> @@ -5913,10 +5880,6 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
>   		dc_plane_state_retain(dm_plane_state->dc_state);
>   	}
>   
> -	/* Framebuffer hasn't been updated yet, so retain old flags. */
> -	dm_plane_state->tiling_flags = old_dm_plane_state->tiling_flags;
> -	dm_plane_state->tmz_surface = old_dm_plane_state->tmz_surface;
> -
>   	return &dm_plane_state->base;
>   }
>   
> @@ -6021,10 +5984,10 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   
>   		fill_plane_buffer_attributes(
>   			adev, afb, plane_state->format, plane_state->rotation,
> -			dm_plane_state_new->tiling_flags,
> +			afb->tiling_flags,
>   			&plane_state->tiling_info, &plane_state->plane_size,
>   			&plane_state->dcc, &plane_state->address,
> -			dm_plane_state_new->tmz_surface, force_disable_dcc);
> +			afb->tmz_surface, force_disable_dcc);
>   	}
>   
>   	return 0;
> @@ -7287,6 +7250,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   		struct drm_crtc *crtc = new_plane_state->crtc;
>   		struct drm_crtc_state *new_crtc_state;
>   		struct drm_framebuffer *fb = new_plane_state->fb;
> +		struct amdgpu_framebuffer *afb = (struct amdgpu_framebuffer *)fb;
>   		bool plane_needs_flip;
>   		struct dc_plane_state *dc_plane;
>   		struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
> @@ -7341,10 +7305,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   
>   		fill_dc_plane_info_and_addr(
>   			dm->adev, new_plane_state,
> -			dm_new_plane_state->tiling_flags,
> +			afb->tiling_flags,
>   			&bundle->plane_infos[planes_count],
>   			&bundle->flip_addrs[planes_count].address,
> -			dm_new_plane_state->tmz_surface, false);
> +			afb->tmz_surface, false);
>   
>   		DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
>   				 new_plane_state->plane->index,
> @@ -8483,8 +8447,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>   	 * TODO: Come up with a more elegant solution for this.
>   	 */
>   	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
> -		struct dm_plane_state *old_dm_plane_state, *new_dm_plane_state;
> -
> +		struct amdgpu_framebuffer *old_afb, *new_afb;
>   		if (other->type == DRM_PLANE_TYPE_CURSOR)
>   			continue;
>   
> @@ -8528,12 +8491,11 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>   		if (old_other_state->fb->format != new_other_state->fb->format)
>   			return true;
>   
> -		old_dm_plane_state = to_dm_plane_state(old_other_state);
> -		new_dm_plane_state = to_dm_plane_state(new_other_state);
> +		old_afb = (struct amdgpu_framebuffer *)old_other_state->fb;
> +		new_afb = (struct amdgpu_framebuffer *)new_other_state->fb;
>   
>   		/* Tiling and DCC changes also require bandwidth updates. */
> -		if (old_dm_plane_state->tiling_flags !=
> -		    new_dm_plane_state->tiling_flags)
> +		if (old_afb->tiling_flags != new_afb->tiling_flags)
>   			return true;
>   	}
>   
> @@ -8859,17 +8821,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   		}
>   	}
>   
> -	/* Prepass for updating tiling flags on new planes. */
> -	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
> -		struct dm_plane_state *new_dm_plane_state = to_dm_plane_state(new_plane_state);
> -		struct amdgpu_framebuffer *new_afb = to_amdgpu_framebuffer(new_plane_state->fb);
> -
> -		ret = get_fb_info(new_afb, &new_dm_plane_state->tiling_flags,
> -				  &new_dm_plane_state->tmz_surface);
> -		if (ret)
> -			goto fail;
> -	}
> -
>   	/* Remove exiting planes if they are modified */
>   	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
>   		ret = dm_update_plane_state(dc, state, plane,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index a46338410ddd..9308bed3c4fe 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -420,8 +420,6 @@ struct dc_plane_state;
>   struct dm_plane_state {
>   	struct drm_plane_state base;
>   	struct dc_plane_state *dc_state;
> -	uint64_t tiling_flags;
> -	bool tmz_surface;
>   };
>   
>   struct dm_crtc_state {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
