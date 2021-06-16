Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0264EC48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 17:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BF061057
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 17:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BF061057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7810A6E073;
	Wed, 16 Jun 2021 17:15:16 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727EC6E073
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 17:15:15 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id 93so2431176qtc.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ic8avbduYCVHAX4vh+v77fy0kn2oGuG1MCktUTocBEc=;
 b=SJYvz+FYz63J8Igu5bsfulaHVI2tfns0hbW1t1SRZyYfjQwrVgEoiNWRtIFkCOmObo
 sKTH2CigfDq9T77boqBq8C5jqcQfbWKhrSgn6KeoE4oM/8cQ+Dk93haD7Zos5yjI+g+k
 P5TvyBXg1K3vtTCAa2gOk8qKYTu92HRIh/SxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ic8avbduYCVHAX4vh+v77fy0kn2oGuG1MCktUTocBEc=;
 b=eHsr7cWsHnjCXQpo8Ol7zjyR0RTj777DfMnGhwtEAmZ/PWDY8ySgoGN8hJOi4W5bkM
 lIoxAsCiLr7QlOhjC7vbnjc+KkF+zMR8H6xLM8zQX1/6YrO5uQLU3IW5YZ4TmwDyoqQf
 1kUB8tC9NAzmMK0vNwMrg+rpwz9iMWPOyH1NsqEbA6EfIW0aFadM9JVj7K5cZaPsi7Px
 wmFJgCN5QQWNvbRfRXx0CYpaDhnqyZnPmbmuZ9bK5TzJlOmTBiQ7nL48vGZaDlPzM3qN
 hcEqzRLrZaWZNdgYJTU0YXzqDCKA6UD6XeQU7g8f9Mi5IOyv4Xyw3N8AoDSkb4MDsIdj
 E71g==
X-Gm-Message-State: AOAM531xGCUblJFuPZzlxaBsHYUZOiTliZeSQB1uynSWcj2/3tO8uIQP
 oi3f/twbuf57Gz0Qqqjxe76mAZOzm2QDNw==
X-Google-Smtp-Source: ABdhPJyIBozFi0ZNr1NKe2I1IuH4V7qcOZoi7DJCV6ha/p2elVqs+Ofz1Aa2N+2ceTZ/YWiE/rH7SA==
X-Received: by 2002:ac8:7f4f:: with SMTP id g15mr841005qtk.345.1623863714282; 
 Wed, 16 Jun 2021 10:15:14 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173])
 by smtp.gmail.com with ESMTPSA id y18sm1564508qtj.53.2021.06.16.10.15.13
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 10:15:13 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id f84so4156395ybg.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 10:15:13 -0700 (PDT)
X-Received: by 2002:a25:acdf:: with SMTP id x31mr132027ybd.222.1623863713086; 
 Wed, 16 Jun 2021 10:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210616162130.1430187-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210616162130.1430187-1-Rodrigo.Siqueira@amd.com>
From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 16 Jun 2021 13:14:36 -0400
X-Gmail-Original-Message-ID: <CAOw6vb+xwpVci60zp3QtALAqxBjZEUGx6V=5XvPpY-td2Lx97Q@mail.gmail.com>
Message-ID: <CAOw6vb+xwpVci60zp3QtALAqxBjZEUGx6V=5XvPpY-td2Lx97Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Fix overlay validation by
 considering cursors"
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 16, 2021 at 12:21 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> This reverts commit 04cc17a951f73f9a9092ca572b063e6292aeb085.
>
> The patch that we are reverting here was originally applied because it
> fixes multiple IGT issues and flickering in Android. However, after a
> discussion with Sean Paul and Mark, it looks like that this patch might
> cause problems on ChromeOS. For this reason, we decided to revert this
> patch.

Thanks for sending this, Siqueira!

To be clear for those unfamiliar, the issue extends beyond ChromeOS
(we're not just pushing our compositor problems on the rest of the
community).

Relying on cursor enable/disable for atomic creates non-deterministic
behavior which would be very hard for any compositor to reason out
without knowing the hardware-specific limitations. The case I'm
worried about is that the compositor has an overlay active without the
cursor and at some point the compositor enables the cursor which will
fail because of the overlay.

Reviewed-by: Sean Paul <seanpaul@chromium.org>

>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Mark Yacoub <markyacoub@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8358112b5822..3fd41e098c90 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10200,8 +10200,8 @@ static int validate_overlay(struct drm_atomic_state *state)
>  {
>         int i;
>         struct drm_plane *plane;
> -       struct drm_plane_state *new_plane_state;
> -       struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
> +       struct drm_plane_state *old_plane_state, *new_plane_state;
> +       struct drm_plane_state *primary_state, *overlay_state = NULL;
>
>         /* Check if primary plane is contained inside overlay */
>         for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
> @@ -10231,14 +10231,6 @@ static int validate_overlay(struct drm_atomic_state *state)
>         if (!primary_state->crtc)
>                 return 0;
>
> -       /* check if cursor plane is enabled */
> -       cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
> -       if (IS_ERR(cursor_state))
> -               return PTR_ERR(cursor_state);
> -
> -       if (drm_atomic_plane_disabling(plane->state, cursor_state))
> -               return 0;
> -
>         /* Perform the bounds check to ensure the overlay plane covers the primary */
>         if (primary_state->crtc_x < overlay_state->crtc_x ||
>             primary_state->crtc_y < overlay_state->crtc_y ||
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
