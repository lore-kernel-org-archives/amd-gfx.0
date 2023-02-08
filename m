Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31785C05027
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 14:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE11110E793;
	Wed,  8 Feb 2023 14:27:08 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEB210E793
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 14:27:07 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id bd6so6612370oib.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Feb 2023 06:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=21o+YQOfHINSR7K/UMHgSkPWDb915ld6L1Sa3XQ8rTA=;
 b=ms7M3t53dMZQZL7Vl3z3EEM/I0OPgj9rbB22qrsLjnXV5rYVzJgKtbDY4CTo+urr2h
 Ef36HTxo1XU/DMgt7LbzlUBt0avB1wTjoPJt2E58hHCVKqQS7tTWNCghv8RXPVVYycF9
 0LZdSA51ez5mhIfz2Y5QmMvA9tqP//f3Nk0SUXiaHdpiZVWPsby7Van4pOMuOMxKHL1l
 DxJh3PrRLLNywsP+zAfSb1pbwHj8uDVOAGKH6Nuo6b9i9PTO6A7TbnK0izwkUFE+CP9D
 2mewyE68PdYvI15fXlN4cDO/XgE7HTQ3DX+M6ysGjgnxF27rDumWGPBDHes/LXhnzsCS
 Hg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=21o+YQOfHINSR7K/UMHgSkPWDb915ld6L1Sa3XQ8rTA=;
 b=XgJZj+XTo6eabNwrcODgG+PGTTHvpXdWelHUpwijMIbzoSTtQi11eNMPMxeN/3gVIq
 TWh3t4DggDLc08YfK2IWQHShNfwA/rPs712/j92fmTO7EOVpeHVd3Vep3kEl/drnKKpD
 j/YeAzkqq+gVt66+JmBl7zlOf+Tj5Gm9fWcOX7JPxSnjshxXc6IRdb4nga3QXcnyXJp+
 Z0vfAy+52oztfDXzUCniaBKwOiPnRQYFCJnmcyvhrP9ZEwBWOCucjlhF3Zd+vawt2D5h
 DzitS27PmOhM8JGAHLCLbfsA8zFK4MNf172tfVBaU9meODtRmcN6t3Dke3KAl0AQVgP9
 +pWw==
X-Gm-Message-State: AO0yUKVgZbJHmCthlHoV/cWSZCvNF1ez//sfdBHtN7+x9+zFjoU+m2BG
 pfbiWiZuASrWhhnwM+B+jQxAotsKwJJveCl1ma+IV2H9
X-Google-Smtp-Source: AK7set9mNiyA4qH3JLkBAqA7VK4vm9/eWnuAbFW2Y+1tM/oIafomNtmHDO6aVFt7s1qATNZlSSzM20p+fNxX4ubnYPY=
X-Received: by 2002:aca:3dd4:0:b0:378:4edd:a89c with SMTP id
 k203-20020aca3dd4000000b003784edda89cmr238117oia.46.1675866425606; Wed, 08
 Feb 2023 06:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20230208072539.4150546-1-tianci.yin@amd.com>
In-Reply-To: <20230208072539.4150546-1-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Feb 2023 09:26:53 -0500
Message-ID: <CADnq5_OERUOt8okNf+=UjL+zAMWzwsFaWaaZTbGaarSH0mv74Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix dm irq error message in gpu recover
To: Tianci Yin <tianci.yin@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 8, 2023 at 2:26 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: tiancyin <tianci.yin@amd.com>
>
> [Why]
> Variable adev->crtc_irq.num_types was initialized as the value of
> adev->mode_info.num_crtc at early_init stage, later at hw_init stage,
> the num_crtc changed due to the display pipe harvest on some SKUs,
> but the num_types was not updated accordingly, that cause below error
> in gpu recover.
>
>   *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>   *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>
> [How]
> Defer the initialization of num_types to eliminate the error logs.
>
> Signed-off-by: tiancyin <tianci.yin@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b31cfda30ff9..506699c0d316 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4226,6 +4226,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>         /* Update the actual used number of crtc */
>         adev->mode_info.num_crtc = adev->dm.display_indexes_num;
>
> +       amdgpu_dm_set_irq_funcs(adev);
> +
>         link_cnt = dm->dc->caps.max_links;
>         if (amdgpu_dm_mode_config_init(dm->adev)) {
>                 DRM_ERROR("DM: Failed to initialize mode config\n");
> @@ -4714,8 +4716,6 @@ static int dm_early_init(void *handle)
>                 break;
>         }
>
> -       amdgpu_dm_set_irq_funcs(adev);
> -
>         if (adev->mode_info.funcs == NULL)
>                 adev->mode_info.funcs = &dm_display_funcs;
>
> --
> 2.34.1
>
