Return-Path: <SRS0=W31V=3Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D23DC33CB7
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55BE2467B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhMz/7MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55BE2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F0D6E987;
	Mon, 27 Jan 2020 19:58:57 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD806E987
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 19:58:56 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id f129so8462885wmf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 11:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NjWH5hq6JOVGc8DtlGVaAUzKTFE7kCZSGUKwFEb4+oE=;
 b=UhMz/7MY18F0hGdePd6lNR+cm3IMw+AbNUlYpkwwxPBZFvkG0MnPDjCO8sejM15k4H
 uF94cG1a7ac9w90hheUYaSAUCJMhUROFBU+Ovp3KHpYa2c3DfNHCnn2Dqv9TIiHe3ZOt
 R+SU1jE9eYNNUC3idlnoCd6SEW275cYX63ty1PLhk3EuYRrQCWdH+Aa9+J2o+utruM9Q
 bQgz+bx83v5BNR5ASGhtxsWdL7tHbzrVozc2HjNv+f5PwM0nmWRpAZHBRKIXkgtiYqVI
 15aPVq8av6fTC/orv4X0jwMxhRwd27VSE9RKv5ESC2qPByp5nT75OcQh0NkNx1ckCsP6
 d5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NjWH5hq6JOVGc8DtlGVaAUzKTFE7kCZSGUKwFEb4+oE=;
 b=IygoTuGWl8GUZZOKFl/AAUHH5UIcDngXX+mHslJfDeoUWCHdT4H0dkgj65jenJC3bS
 JW2owegOYcPSxnGuu9tUc6/YdcdGpvXQcPHhelCzPRcJNNvIsXVZ5CJaK5133vnwKFUH
 HBv5OqTNjbIZbwlTYFI+CpIbUjzAKYnt7voEk5kryoFssNFopCF/UGw5DawnnwKGFel3
 /m3vx8i3w7ZlRIV1fdUUg4U7XSI2IRoVIDSJVLTgEP5/UHwFNeujEP7o7PAchZ2+hPI0
 7c4OwbyaT4DRTWPlUxdHbALSeLJTaOXJlwXLP2X+WvGgkOPZ26XHqR0qDGuUkfdTz6e2
 ++bg==
X-Gm-Message-State: APjAAAV+1e/5iKjXyYLsPu8mhPXTEQuertHy/QdA21dR8Wa3SuU4SWvu
 +dQJ2yhr9l/qNdMHA1T1CQ8T0RgwKt+8f39GTwc=
X-Google-Smtp-Source: APXvYqzSJ4yyeECv+2kLzTliNZRLy+OPAVYReep+n1Fu+lioWSk+6VGtA93kTBKWU3V6V/BGm429NVr4nbzXx9d58Bo=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr300738wmb.73.1580155135137;
 Mon, 27 Jan 2020 11:58:55 -0800 (PST)
MIME-Version: 1.0
References: <d4fb24b4-bc95-4684-bb09-3cf4df8b3c2c@canonical.com>
 <20200124192343.12540-1-harry.wentland@amd.com>
In-Reply-To: <20200124192343.12540-1-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jan 2020 14:58:41 -0500
Message-ID: <CADnq5_Nz-RD6+Or0qS2SWf-r8dxcz1BwJjrjNS7tuSJqu+-odQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix psr static frames calculation
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Colin Ian King <colin.king@canonical.com>,
 "for 3.8" <stable@vger.kernel.org>, Zhan Liu <Zhan.Liu@amd.com>,
 Roman Li <roman.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 24, 2020 at 2:23 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> [Why]
> Driver crash with psr feature enabled due to divide-by-zero error.
> This is a regression after rework to calculate static screen frame
> number entry time.
>
> [How]
> Correct order of operations to avoid divide-by-zero.
>
> Cc: Colin Ian King <colin.king@canonical.com>
> Fixes: 5b5abe952607 drm/amd/display: make PSR static screen entry within 30 ms
> Cc: stable@vger.kernel.org
> Signed-off-by: Roman Li <roman.li@amd.com>
> Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index eed3ed7180fd..61c36c1520c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8491,7 +8491,6 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
>         /* Calculate number of static frames before generating interrupt to
>          * enter PSR.
>          */
> -       unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
>         // Init fail safe of 2 frames static
>         unsigned int num_frames_static = 2;
>
> @@ -8506,8 +8505,10 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
>          * Calculate number of frames such that at least 30 ms of time has
>          * passed.
>          */
> -       if (vsync_rate_hz != 0)
> +       if (vsync_rate_hz != 0) {
> +               unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
>                 num_frames_static = (30000 / frame_time_microsec) + 1;
> +       }
>
>         params.triggers.cursor_update = true;
>         params.triggers.overlay_update = true;
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
