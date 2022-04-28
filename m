Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2098C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 17:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388E610E7AD;
	Thu, 28 Apr 2022 17:44:19 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282AE10E7AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 17:44:18 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id 12so6062129oix.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GRM4rt5wVUfSX9dP5diTDQgF5WsCUDTxWZBbzUu0Ue0=;
 b=cmO79FoETpBzHASfeNxS2KFcP8V/tMM+UPHwwXF+DGke+ujkQSnynTNxqUibJPMddB
 BCL4YMC/2jat3cMLrHnE3pmswTdIeGFhCaOBXn1KvpnUqKVEyLOjSZyK/6q3Y/0hRaDQ
 pow65iudKXx65zrGZhVNFQlOF/YEIurVLsRnG0pfVajIPteclvsqvDncgODino3ICwYg
 lf9NtFxH2R9Ykv8P/pX6HZhxqXYTmj4H2b7dsEActBottngPBQNaMDHDNjlk5LQOWnZo
 DP4E9SmjjffTiXdXvOkvVTrqadNNChQNQn81mUryWaw6Bbdrm+oomGSL3RgjoryYapG1
 g5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GRM4rt5wVUfSX9dP5diTDQgF5WsCUDTxWZBbzUu0Ue0=;
 b=5kckJ2NngVRIivtV1N+FJb0Il3A0t7l7BvdegzJc43dzw6TdClPI86qn9pQmJyuvHG
 yI8VV2NAk+axK+MD1rbPzpGVYXGyVT97N/lnvMxsJnSq6bGEeytLIO4knqb1DBVlLxns
 2mTtItg0Rggy+j9AW/0CBOfpkz6IOlvm+7kxTf4fqZaQKF0lywqUvDOjp4yPBstTELqr
 inBAvkpnm9MvGBljC9oJ+Cdgtea+kToP0t8/q1fvq7iEewbPhbaXtVELumQ2iNWhbuT2
 QNoIaqgfqvBfyoqwJNadYHcHv+4WQs+hlYaRTWaGifyMvxu/VDmL20DJbLQKHfknjjo2
 pNSA==
X-Gm-Message-State: AOAM530Qrz0eY1PX//MGXpcRcoDYKe/fBD0KexzZDSsZL5nHYRhKBH+i
 c+vNonVzYliyYjXDckmqrm44QR716jmAaDtXS0M=
X-Google-Smtp-Source: ABdhPJxaVgKNv9Z3i7Y7m2Yd+C5108zxH++ownFcWClCVQ/oqDeYpcJDBV0yoN1XSRkot8uT/tb2YflgBFLFFBdTn2I=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr11954915oiw.253.1651167857280; Thu, 28
 Apr 2022 10:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220428174118.131226-1-harry.wentland@amd.com>
In-Reply-To: <20220428174118.131226-1-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Apr 2022 13:44:06 -0400
Message-ID: <CADnq5_PuvUcUUUXs80x8A87pkVV718U-mYbHnkuOTaNXs40Edw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Avoid reading audio pattern past
 AUDIO_CHANNELS_COUNT
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 28, 2022 at 1:41 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> A faulty receiver might report an erroneous channel count. We
> should guard against reading beyond AUDIO_CHANNELS_COUNT as
> that would overflow the dpcd_pattern_period array.
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index c15c46b81111..55a5a6a49fe2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4464,7 +4464,7 @@ static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video
>                 &dpcd_pattern_type.value,
>                 sizeof(dpcd_pattern_type));
>
> -       channel_count = dpcd_test_mode.bits.channel_count + 1;
> +       channel_count = min(dpcd_test_mode.bits.channel_count + 1, AUDIO_CHANNELS_COUNT);
>
>         // read pattern periods for requested channels when sawTooth pattern is requested
>         if (dpcd_pattern_type.value == AUDIO_TEST_PATTERN_SAWTOOTH ||
> --
> 2.35.1
>
