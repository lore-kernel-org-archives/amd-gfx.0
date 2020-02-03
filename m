Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9920FC35247
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CBB2084E
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsrFTU4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CBB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6FE6ED0D;
	Mon,  3 Feb 2020 21:08:04 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1EB6ED0D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 21:08:03 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y11so20157392wrt.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2020 13:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vg+RKXLvXi19Y2p4NXyguQMFL80U3pDKEhSnM9bwJGw=;
 b=SsrFTU4QkfJVD39wQlHUiABZWCu7WNHMMFHtbeB/83lpRYJJhv6GXQwsabAE7rqt4X
 hSrzKAZCCdlBaumrsPrw4sv2G47mFf09QHXlFynxCG4Wq4yuxZ5w3NNdhz42WxXRjy0d
 rFHQ/qwJrHKAmzKor0fSHny/T/1QCV1nbv2DIS4zYPqHBG0UJBknceE4AO6us/c6KQ+z
 aHMQoPTHZXOSOvcAaYsxZ6DY3SyV68QpYB2mZlcLvfc97E/yrbc28YMaVNNLH+vUQKId
 pI7EUKzZ1wxeXh8MBGJgI+Ig5c6eVSJ1CbGQvQUXaNSrxoucG7B20fMzE0B2/hHWVKrf
 odgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vg+RKXLvXi19Y2p4NXyguQMFL80U3pDKEhSnM9bwJGw=;
 b=d4U9hWte84lE5i/Vnj+SD8jVNwSF/ERjjaiRMQ23iETdaHrvEO4DQmYv/BZXUkw99Q
 BCskwKwRK/i5bh3d2xmoicE5O9gQtQc+OcBe+8afXLgvSYnxAS6SPOnyA+u8vajloiFa
 buIoBI+9t/csS7sPeANkXSp7XzrtHEv7m9E4csZIIB3BmKQpfpiIx0zR1Vu3DJieW+g2
 7gbvlBcyXCRxUrELULK5Wzt3gIQRpW2lQ2V4LQZ721V7bKIr+codQM5+ihW3Gy8wWXIC
 ax5cWWoEjyA6qRQ8h/4plXWIi1wa7JU9SPoE7mFXcZvkOppyT+33St5gxZgDqKmMxkQg
 BPcg==
X-Gm-Message-State: APjAAAXIJMijxtBBEbv1Ci6LYmnhN2m9VOXW70o6/xPnpniQIimO3UYj
 vkAguA9O0oIRvwx3u55NoC1Qk4hHdgmmWwpGhHFIIA==
X-Google-Smtp-Source: APXvYqxO5qh5pL790dqm0vE+kZvNBN/dJ14FKW84nwlrWbYwA+pwwvkqQiW04VY37FwCOcIR/vG3/RNHRoJF+QHJlAs=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr18567970wrn.124.1580764081882; 
 Mon, 03 Feb 2020 13:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20200110201110.117166-1-alexander.deucher@amd.com>
In-Reply-To: <20200110201110.117166-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Feb 2020 16:07:51 -0500
Message-ID: <CADnq5_PqWGUjn06jvxXfr=qQa45WJCK1aKgJ-b+VJRkVj9z4Yg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix logic inversion in
 program_timing_sync()
To: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Wenjing Liu <Wenjing.Liu@amd.com>, 
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Harry Wentland <hwentlan@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Fri, Jan 10, 2020 at 3:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> It looks like we should be reducing the group size when we don't
> have a plane rather than when we do.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 3d89904003f0..01b27726d9c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1003,9 +1003,9 @@ static void program_timing_sync(
>                                 status->timing_sync_info.master = false;
>
>                 }
> -               /* remove any other pipes with plane as they have already been synced */
> +               /* remove any other pipes without plane as they have already been synced */
>                 for (j = j + 1; j < group_size; j++) {
> -                       if (pipe_set[j]->plane_state) {
> +                       if (!pipe_set[j]->plane_state) {
>                                 group_size--;
>                                 pipe_set[j] = pipe_set[group_size];
>                                 j--;
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
