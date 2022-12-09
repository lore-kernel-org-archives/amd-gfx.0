Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC7BC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 21:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E514B10E588;
	Fri,  9 Dec 2022 21:37:58 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4859210E588
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 21:37:55 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 cn2-20020a056830658200b0066c74617e3dso3597841otb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Dec 2022 13:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SdX+Xkaid3K3opnIzNBxFYaWUC6uYJXZykEsliaMSwI=;
 b=OtVCo1J9DZrKioB1swHKiXvT8/kqXbHefUEntTrT17+LDdu4BMZclMw7ve0wbFBnj0
 uMIPmcs2gBDVMOlEZBCW8SlfiHrIeDTRN4+6vSzY8yoU+12+kO8zHjzWNejQtiiKrBHk
 bA7fR8d+5utgTbzt8pVBgTKJM+C0HfG1HfaCXPp1uhUApPfJmbaZtE22T3DWVBVI12V3
 B2jc7ysQavRIJzeOLyraTEmvhIX0bznzjITg4eu797QQ6ZbrS8nVBXLHltUjQ0wB7wir
 cj6W+3Dh8KW9S1KOFUuYfgDGUqFiMlJ3cdZKmTvIgWKTPlK8GqdwMGU4Q2IKLgdqqg3Y
 vFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdX+Xkaid3K3opnIzNBxFYaWUC6uYJXZykEsliaMSwI=;
 b=K+EGug28n4s/6l+NWxhhCFiSL+4q4asr2GTaIN/5wR59wP9K92VtPEHdfLae3J4gWX
 ds8J/QS0HaxTz2/b03BqCUlJBCJ9QhEH5x96HqmTw/GN5hd7Q/LRciMzXWPQBznDLc1J
 YnqUPn1fgufLXCLFIIM0Z4zH8h1UCo36CV09Ch9zAmEIjYYNERmUj0g1Bd0Qr28i7haV
 BO7+2JC1dPdbOq8nkp2Ts0tualNmEX2qkeq9pDJKLeF3fqY6p4pXG+wecgJb88if0t7F
 FFFwML+O7CT4oRdX5FK8+W2ZJJgddYLX2c0P1fjampBXdGpF59TOM9DGH+yAr3K5n+FT
 RlOA==
X-Gm-Message-State: ANoB5pmQDykhaQfv8EIepDiEvCMB/+6qlOZXOSBsqVKuCWCiSAe60d/k
 tp8bqMJihqPWUS06tBUIiG4jz/4YFJh0Vp4xcIQ=
X-Google-Smtp-Source: AA0mqf4HlODI6jAczQQvLwo40zYLmio5EJnK9Sdqpf4yCMEezFhehMwmRQRDjdWG3BFW8baRkjBfrUs+b/olVIGTQDw=
X-Received: by 2002:a05:6830:1b62:b0:66c:7982:2d45 with SMTP id
 d2-20020a0568301b6200b0066c79822d45mr37544494ote.123.1670621874429; Fri, 09
 Dec 2022 13:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20221209163647.25704-1-jdhillon@amd.com>
 <20221209163647.25704-12-jdhillon@amd.com>
In-Reply-To: <20221209163647.25704-12-jdhillon@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Dec 2022 16:37:43 -0500
Message-ID: <CADnq5_MPvhf-u14zUEqOtwKeFZEuHNqrks=gJfT9FrVZXbHpqw@mail.gmail.com>
Subject: Re: [PATCH 11/23] drm/amd/display: Check for PSR in no memory request
 case
To: jdhillon <jdhillon@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Samson Tam <Samson.Tam@amd.com>, wayne.lin@amd.com, pavle.kotarac@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 9, 2022 at 11:38 AM jdhillon <jdhillon@amd.com> wrote:
>
> From: Samson Tam <Samson.Tam@amd.com>
>
> [Why]
> When we have a PSR display, we will not be requesting data from memory anymore.
> So we report back true for no memory request case.
>
> [How]
> Check for PSR by checking PSR version in link settings
>
> Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
> Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
> Signed-off-by: Samson Tam <Samson.Tam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 9 +--------
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dc23801de071..6a6e4c844316 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8359,10 +8359,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
>                         old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
>                 }
> -<<<<<<< HEAD
> -=======
> -
> ->>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)
> +

Please squash these in with the patch that added them.

>                 if (old_crtc_state)
>                         pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
>                         old_crtc_state->enable,
> @@ -8425,10 +8422,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                                 DRM_MODE_CONTENT_PROTECTION_DESIRED)
>                                 enable_encryption = true;
>
> -<<<<<<< HEAD
> -
> -=======
> ->>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)

same here.

Alex

>                         if (aconnector->dc_link && aconnector->dc_sink &&
>                                 aconnector->dc_link->type == dc_connection_mst_branch) {
>                                 struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index b8767be1e4c5..2f0ebe1f6c45 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -188,7 +188,8 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
>
>      /* First, check no-memory-request case */
>         for (i = 0; i < dc->current_state->stream_count; i++) {
> -               if (dc->current_state->stream_status[i].plane_count)
> +               if ((dc->current_state->stream_status[i].plane_count) &&
> +                       (dc->current_state->streams[i]->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED))
>                         /* Fail eligibility on a visible stream */
>                         break;
>         }
> --
> 2.34.1
>
