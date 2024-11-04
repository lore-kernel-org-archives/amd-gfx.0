Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAA7D132DC
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 15:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2188110E45A;
	Mon,  4 Nov 2024 15:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P7aMCVzz";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C4910E45A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 15:08:49 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2e2e31aacbbso443222a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Nov 2024 07:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730732929; x=1731337729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIjFhPfYlWuVkk0g+SyHD++KtsGpwzmWQq31owW8pTQ=;
 b=P7aMCVzzzrj29R309EYfxbsOPeQ8dqO6qCVayH5a0mOJfV+Z/K5bwEcggC4FqymGJN
 c5BE7pWsWgcziPpqC4BLciftuNBW6wRhHZVfoTWuFQQcWK5teuooDVbX2oEOjYUoNPwH
 qOtOdTCIsYmaWWlXzlX3X5NOwU7Qovlcckm+fQpAWra1qCnuiRysfxEAk6BzjiziyfzL
 ZHe7k9fK0AO3PgyH2C0BuMy/mLQook29fwD7i5IjhnGrjoPitMkoUM0w6lOdApHbRroa
 CE1tdsjbn1KYvs462EMwyRFPqYRTHzlDbmoQ9BvLGStPeNyypqgGLjTnZZNVCB0SI3nj
 iEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730732929; x=1731337729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIjFhPfYlWuVkk0g+SyHD++KtsGpwzmWQq31owW8pTQ=;
 b=N1OR6M1MylLOsBdFip2AF2V43kLlCthZj848aLA2ec+zLWkyJQ1/KjUJkr9//7ZA2v
 KjLbys8Ce+pVFBhRtfhawPhzjcvBZrpB76CZBtcIOlRy30JkRtb9T1H4fRvHS27+vads
 PaiKRU8dcHT88xdNSqF7XdQcPVbwBqXKOiaa4m1qzrnvZxi8fWo/iENXjfL3+qIK3aiW
 zQnIixGmu6xcSNfm4/rK2DKXWDx+RDeY4gIQrqPBkEAcYh6t7KZHCsvMNhvLbcwc1Te/
 od7Aa7i4D5ZaUwDpeL3ZVa1bmE5LsPfJiCIla4m+Pb6Rsq00kAaj0eh9UIxvpympTXnM
 9WNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu4LNpXOLMTqKGcc4lHBQ5hLTNJhPJcTAjgB19RhqYVZHVFsW45SrNbhUjh04iLVHLs3K5kYNJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtvGXkYsIpSg1NVNjmzl16c2BNgYP6sJUmxNSKusAHp8tnMRer
 mjDuXxk/2XcvrnOpvJyX+Wzq4ZysR5rfBay192X9JkelYrcak1ymP3bJouYW4usf2LCJwKljG/Z
 hnZnUGTlSG7Va+oZe1TwYsuoDAMk=
X-Google-Smtp-Source: AGHT+IG/7wrAw/jBYD22pBYnzYCFPYyDtxwi8kBQ8q9cRpV7i8c8YC3UXWIYgU/Q3wTGyabtcuKYHJoBV3XOdKvgapA=
X-Received: by 2002:a17:90b:4a90:b0:2e2:a70a:f107 with SMTP id
 98e67ed59e1d1-2e8f0f4f79cmr16112665a91.1.1730732929354; Mon, 04 Nov 2024
 07:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20241031180430.3993389-5-alexander.deucher@amd.com>
 <20241104012127.21561-1-yaolu@kylinos.cn>
In-Reply-To: <20241104012127.21561-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Nov 2024 10:08:37 -0500
Message-ID: <CADnq5_M4rS5C_6329ZE2cyFWLMkVE+qj5VLDEqmNWZVsJZK0Xg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/display: add non-DC drm_panic support
To: Lu Yao <yaolu@kylinos.cn>
Cc: alexander.deucher@amd.com, jfalempe@redhat.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 4, 2024 at 4:05=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote:
>
> on 2024/11/1 02:04, Alex Deucher wrote:
> > Add support for the drm_panic module, which displays a pretty user
> > friendly message on the screen when a Linux kernel panic occurs.
> >
> > Adapt Lu Yao's code to use common helpers derived from
> > Jocelyn's patch.  This extends the non-DC code to enable
> > access to non-CPU accessible VRAM and adds support for
> > other DCE versions.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Lu Yao <yaolu@kylinos.cn>
> > Cc: Jocelyn Falempe <jfalempe@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 27 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 27 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 27 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 26 +++++++++++++++++++++++++
> >  4 files changed, 107 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v10_0.c
> > index 5098c50d54c8..a26f2381504b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > @@ -2687,6 +2687,32 @@ static const struct drm_crtc_helper_funcs dce_v1=
0_0_crtc_helper_funcs =3D {
> >       .get_scanout_position =3D amdgpu_crtc_get_scanout_position,
> >  };
> >
> > +static void dce_v10_0_panic_flush(struct drm_plane *plane)
> > +{
> > +     struct drm_framebuffer *fb;
> > +     struct amdgpu_crtc *amdgpu_crtc;
> > +     struct amdgpu_device *adev;
> > +     uint32_t fb_format;
> > +
> > +     if (!plane->fb)
> > +             return;
> > +
> > +     fb =3D plane->fb;
> > +     amdgpu_crtc =3D to_amdgpu_crtc(plane->crtc);
> > +     adev =3D drm_to_adev(fb->dev);
> > +
> > +     /* Disable DC tiling */
> > +     fb_format =3D RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
> > +     fb_format &=3D ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
> > +     WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
> > +
> > +}
> > +
> For non-DC ip, 'mmGRPH_CONTROL' and 'GRPH_CONTROL__GRPH_ARRAY_MODE_MASK' =
val are same, so whether the panic_flush function can also be made same?

It could, but I didn't want to imply that this should be used for all
IPs because the tiling controls are different on newer GPUs.

> >
> > +static const struct drm_plane_helper_funcs dce_v10_0_drm_primary_plane=
_helper_funcs =3D {
> > +     .get_scanout_buffer =3D amdgpu_display_get_scanout_buffer,
> The definition of 'amdgpu_display_get_scanout_buffer' seems to be missing=
.

It was added in patch 1.

Alex
