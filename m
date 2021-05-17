Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650B7C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A9D61004
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A9D61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A33E6EA19;
	Mon, 17 May 2021 17:38:27 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E5F6EA19
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 17:38:26 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 u25-20020a0568302319b02902ac3d54c25eso6280897ote.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GdmFdQ8bWc8McFE1po287xEsRMajxJxEh5Y9p5Z8Mv4=;
 b=BssPuEKtTQWCPilVoc+cDr2uUYoo++w1YQk+PBhAIyRe++L7rlCtLb3PNaJg1ZkEiK
 MluOlR5ZSrJ648sUhy2yH9gdQHUXhB8JoiXzFq04EK5aUcjFOHXz1PhmGXZVB2Od8hW5
 1bSkbA4KzJKuYBEf6L6kDrRY31Bfsq6Eaf4FeNEAV1/7P8BSY1Z+ju4AYDsurHcqSs+h
 nyc4/RZFVYYMrqG3XnvdPf0WLy0U+5t+OGQy++CT5v+GVyAbaSfpRJLBl3tipnv1SFrF
 +ekOPLZJsC+yfuz/2HzRMEcpnFf/xDk2MCKl0oYRFYxbQj9orM0DO+8B2z7Yze4/TX3I
 XSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GdmFdQ8bWc8McFE1po287xEsRMajxJxEh5Y9p5Z8Mv4=;
 b=likjf2aMPQbcGH10+r00qFVB3VbVSLXLS54NR7YIsVUMsKDPBWhfuKiGETHM2tkE6o
 1oaiex4mrMm4hof8/zRPQgTxYOyEitP7A0GfSZwdtLDCMqEUXUIC0MMLtABMdsmiloNN
 Z45J7WFRz8n0iB3J8hRG0XhnJsQR/T1GiuiZcX7GRUtd+U/seJffg1jHt7INf4ZVUbFW
 uv4MLERdnIJC0bsIknMIPRe9Hzdrs5Yl2CWszSl8E73rPs5t3kOu2Zg47BVEmkrmSOSo
 BmTHIK9mJIeTBlO4vB86TW/5L5/Mx7VO4/KzELTz+xfDPF2wBy93JQHRhULOXEhKHXrP
 4+0g==
X-Gm-Message-State: AOAM531R8xjio5A/n+5zFw9HNQ5vSMwI+TV0/nKuwC7LmmX9QyO2PX0t
 Joj+6j2b1JKO+cPugP6GeK/QYkfnE+6Gl7QzdvDVRTh1
X-Google-Smtp-Source: ABdhPJy8V2q9sKR2x25H8jdazQL5xL9PRgIuFNJhgom/M0kXG1/vo1mCFsFhqMcRobENAj8EZvSn8OlVq49NW8wCY00=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr598342oti.23.1621273105403;
 Mon, 17 May 2021 10:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210511154411.1281317-1-alexander.deucher@amd.com>
In-Reply-To: <20210511154411.1281317-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 May 2021 13:38:14 -0400
Message-ID: <CADnq5_OTosyeWu_Xs9QW2n=U3_gXCr9H85Pff6etsXq4Az1ydg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: add helper functions to get/set
 backlight (v2)
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series.

Alex

On Tue, May 11, 2021 at 11:44 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> And cache the value.  These can be used by the backlight callbacks
> and modesetting functions.
>
> v2: rebase on latest backlight changes.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1337
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 ++++++++++++++-----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 ++++
>  2 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5df187a6e25f..167c8759fbc9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3467,26 +3467,28 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
>                                  max - min);
>  }
>
> -static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> +static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
> +                                        u32 user_brightness)
>  {
> -       struct amdgpu_display_manager *dm = bl_get_data(bd);
>         struct amdgpu_dm_backlight_caps caps;
>         struct dc_link *link[AMDGPU_DM_MAX_NUM_EDP];
> -       u32 brightness;
> +       u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
>         bool rc;
>         int i;
>
>         amdgpu_dm_update_backlight_caps(dm);
>         caps = dm->backlight_caps;
>
> -       for (i = 0; i < dm->num_of_edps; i++)
> +       for (i = 0; i < dm->num_of_edps; i++) {
> +               dm->brightness[i] = user_brightness;
> +               brightness[i] = convert_brightness_from_user(&caps, dm->brightness[i]);
>                 link[i] = (struct dc_link *)dm->backlight_link[i];
> +       }
>
> -       brightness = convert_brightness_from_user(&caps, bd->props.brightness);
> -       // Change brightness based on AUX property
> +       /* Change brightness based on AUX property */
>         if (caps.aux_support) {
>                 for (i = 0; i < dm->num_of_edps; i++) {
> -                       rc = dc_link_set_backlight_level_nits(link[i], true, brightness,
> +                       rc = dc_link_set_backlight_level_nits(link[i], true, brightness[i],
>                                 AUX_BL_DEFAULT_TRANSITION_TIME_MS);
>                         if (!rc) {
>                                 DRM_ERROR("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
> @@ -3495,7 +3497,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>                 }
>         } else {
>                 for (i = 0; i < dm->num_of_edps; i++) {
> -                       rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness, 0);
> +                       rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness[i], 0);
>                         if (!rc) {
>                                 DRM_ERROR("DM: Failed to update backlight on eDP[%d]\n", i);
>                                 break;
> @@ -3506,9 +3508,17 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>         return rc ? 0 : 1;
>  }
>
> -static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
> +static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>  {
>         struct amdgpu_display_manager *dm = bl_get_data(bd);
> +
> +       amdgpu_dm_backlight_set_level(dm, bd->props.brightness);
> +
> +       return 0;
> +}
> +
> +static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)
> +{
>         struct amdgpu_dm_backlight_caps caps;
>
>         amdgpu_dm_update_backlight_caps(dm);
> @@ -3521,17 +3531,24 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
>
>                 rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
>                 if (!rc)
> -                       return bd->props.brightness;
> +                       return dm->brightness[0];
>                 return convert_brightness_to_user(&caps, avg);
>         } else {
>                 int ret = dc_link_get_backlight_level(dm->backlight_link[0]);
>
>                 if (ret == DC_ERROR_UNEXPECTED)
> -                       return bd->props.brightness;
> +                       return dm->brightness[0];
>                 return convert_brightness_to_user(&caps, ret);
>         }
>  }
>
> +static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
> +{
> +       struct amdgpu_display_manager *dm = bl_get_data(bd);
> +
> +       return amdgpu_dm_backlight_get_level(dm);
> +}
> +
>  static const struct backlight_ops amdgpu_dm_backlight_ops = {
>         .options = BL_CORE_SUSPENDRESUME,
>         .get_brightness = amdgpu_dm_backlight_get_brightness,
> @@ -3543,8 +3560,11 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
>  {
>         char bl_name[16];
>         struct backlight_properties props = { 0 };
> +       int i;
>
>         amdgpu_dm_update_backlight_caps(dm);
> +       for (i = 0; i < dm->num_of_edps; i++)
> +               dm->brightness[i] = AMDGPU_MAX_BL_LEVEL;
>
>         props.max_brightness = AMDGPU_MAX_BL_LEVEL;
>         props.brightness = AMDGPU_MAX_BL_LEVEL;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index c6f79c7dfac4..721c8b49730c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -436,6 +436,13 @@ struct amdgpu_display_manager {
>          */
>         struct list_head da_list;
>         struct completion dmub_aux_transfer_done;
> +
> +       /**
> +        * @brightness:
> +        *
> +        * cached backlight values.
> +        */
> +       u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
>  };
>
>  enum dsc_clock_force_state {
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
