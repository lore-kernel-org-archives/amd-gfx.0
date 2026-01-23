Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE34D6CFA7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 16:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA2E10EB5E;
	Fri, 23 Jan 2026 16:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WVx79B57";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8639D10EB5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 16:34:01 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so2127200f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769186040; x=1769790840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb7u39V+EWrAiLj+yjS6kM65VvsRc96IK2z8zgH3Va8=;
 b=WVx79B57oYDqibMFxRoNDHgquAt5F94277V1//+4Sb2yB+7wMDrxY1EzJkTYMQ1GPj
 B8p71o9P1h0kllyHPCmHZSz6GDZplUTEceQLw7Z6ms6P0osAuFjjvBMixE9axT01Rs63
 sVyyVnaLVswcTsHZJAZ2MFjciSutuYG6/sJD9kmQml7w+Oj0kg9sizdU6OqnbDMRrh6v
 9mH9ZyEPwvjBX7YWX8ohQJwOBQCCCTOnsQqZsLcdWFMFUlXdpGzI7qdRYevIt6wR/T1C
 10td02/cBv6cKDLE9MXI3WM7KlPqNzX1r8IxWq7h6BCaq28eVhp2jw9aewdBsJq7f5oF
 +97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769186040; x=1769790840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rb7u39V+EWrAiLj+yjS6kM65VvsRc96IK2z8zgH3Va8=;
 b=n4jXMzp8lMxbuaan9izBptJvlng++s8/EvUrQ4adBQHopZdAunv1fwD/5uwqnEVhrS
 nVSUWuohi0qj/5+9ufLnzwi8WOhAIjt4cs227h3Mbksr/H4o0KZSbo3JZhItJHqIPiHD
 IhiH4dMnovuDx0wvYwi1PqEi5m6tIX/B4nKXt5L+mxXInLkIZD+2cBv39XOFd6/kkI+5
 Ihw54QQh7dlNB1H2DrS0UqkM7oLBYt18YHTQdTgDiCnQcSUt3RiPqSgEa0LZZv7DLXDq
 hX534vcenx+94uYJ++iZA2/Q2uGMghInnioB1IgZzHT7SLszupekuYvUqKdAOGWLRZNW
 CrFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa5IpTJP1FcWxgo3kh86l0OJ1/AqNEtizM2vlrcmJjmY1XnyLWxWROctSlVlQHkZG04rvEg1Kt@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0bP5QjZ4t8ArSjD96EeDYLFibz4m/7Gg7uMCSiJHgBA3byGYR
 syXCboN97syKb+MyDVYR0cGFUSNiO9RuswrD1EDQYvDxwLNYCCjRa6+Y7X5UI1Qj
X-Gm-Gg: AZuq6aLvRmNP74J7T10EYqCr2ATBafWxmnzIGkJnOdb9YOlSUz68glsul4br+OC5ms2
 jfxMIftcH8aQrhrDSo5AIbWLU9FClxZJ8sNtNRUq3Jqwrp44ff+348eQogbOm/DMW+tJdj0S0n+
 uL3e9zblRdnNCW+pj/2ISghai3+bHxElBS3KSXdwQv1Stwu6qSYc9rglKodxINsozlC9Fi0CcRR
 5hOJLMpwgO0vbujls3SRO3FBGhgyXzxbhkHe03R5N1SUynxsbXczLrNGDyH/6ano8lNRywWdUjD
 mv8RqnaGJQnsWTXBUULNGNNevUvSFLAr8BAvWQxEB7BDXJWJ7x4T1qKAoZDZYKR+ozhhy6ej3GO
 I31FSjclRD1HOctd4NQAMrwRZ6rPKPAhBpPUTlt3nbGu4iWgW9T2C/hf3EJ7TRWVf5FSpFX8LY4
 CJOL5g74lIGtqoCqxmG9aXbnZvthnf15NdOGV6rXgzd4VtjM/7zs1GoTLicg==
X-Received: by 2002:a05:600c:1c1f:b0:47e:e5c5:f3a3 with SMTP id
 5b1f17b1804b1-4804c9b24e5mr58013925e9.24.1769179492597; 
 Fri, 23 Jan 2026 06:44:52 -0800 (PST)
Received: from timur-hyperion.localnet (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbb6939sm23700435e9.5.2026.01.23.06.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:44:52 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Hamza Mahfooz <someguy@effective-light.com>,
 dri-devel@lists.freedesktop.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Date: Fri, 23 Jan 2026 15:44:50 +0100
Message-ID: <2349754.vFx2qVVIhK@timur-hyperion>
In-Reply-To: <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, January 23, 2026 2:52:44=E2=80=AFPM Central European Standard Ti=
me=20
Christian K=C3=B6nig wrote:
> On 1/23/26 01:05, Hamza Mahfooz wrote:
> > There should be a mechanism for drivers to respond to flip_done
> > time outs.
>=20

I am adding Harry and Mario to this email as they are more familiar with th=
is.

> I can only see two reasons why you could run into a timeout:
>=20
> 1. A dma_fence never signals.
> 	How that should be handled is already well documented and doesn't=20
require
> any of this.

Page flip timeouts have nothing to do with fence timeouts.
A page flip timeout can occur even when all fences of all job submissions=20
complete correctly and on time.

>=20
> 2. A coding error in the vblank or page flip handler leading to waiting
> forever. In that case calling back into the driver doesn't help either.

At the moment, a page flip timeout will leave the whole system in a hung st=
ate=20
and the driver does not even attempt to recover it in any way, it just stop=
s=20
doing anything, which is unacceptable and I'm pretty surprised that it was=
=20
left like that for so long.

Note that we have approximately a hundred bug reports open on the drm/amd b=
ug=20
tracker about "random" page flip timeouts. It affects a lot of users.

>=20
> So as far as I can see the whole approach doesn't make any sense at all.

Actually this approach was proposed as a solution at XDC 2025 in Harry's=20
presentation, "DRM calls driver callback to attempt recovery", see page 9 i=
n=20
this slide deck:

https://indico.freedesktop.org/event/10/contributions/431/attachments/
267/355/2025%20XDC%20Hackfest%20Update%20v1.2.pdf

If you disagree with Harry, please make a counter-proposal.

Thanks,
Timur



>=20
> > Since, as it stands it is possible for the display
> > to stall indefinitely, necessitating a hard reset. So, introduce
> > a new crtc callback that is called by
> > drm_atomic_helper_wait_for_flip_done() to give drivers a shot
> > at recovering from page flip timeouts.
> >=20
> > Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> > ---
> >=20
> >  drivers/gpu/drm/drm_atomic_helper.c | 6 +++++-
> >  include/drm/drm_crtc.h              | 9 +++++++++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> > b/drivers/gpu/drm/drm_atomic_helper.c index 5840e9cc6f66..3a144c324b19
> > 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1881,9 +1881,13 @@ void drm_atomic_helper_wait_for_flip_done(struct
> > drm_device *dev,>=20
> >  			continue;
> >  	=09
> >  		ret =3D wait_for_completion_timeout(&commit->flip_done, 10=20
* HZ);
> >=20
> > -		if (ret =3D=3D 0)
> > +		if (!ret) {
> >=20
> >  			drm_err(dev, "[CRTC:%d:%s] flip_done timed=20
out\n",
> >  		=09
> >  				crtc->base.id, crtc->name);
> >=20
> > +
> > +			if (crtc->funcs->page_flip_timeout)
> > +				crtc->funcs-
>page_flip_timeout(crtc);
> > +		}
> >=20
> >  	}
> >  =09
> >  	if (state->fake_commit)
> >=20
> > diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> > index 66278ffeebd6..45dc5a76e915 100644
> > --- a/include/drm/drm_crtc.h
> > +++ b/include/drm/drm_crtc.h
> > @@ -609,6 +609,15 @@ struct drm_crtc_funcs {
> >=20
> >  				uint32_t flags, uint32_t target,
> >  				struct drm_modeset_acquire_ctx=20
*ctx);
> >=20
> > +	/**
> > +	 * @page_flip_timeout:
> > +	 *
> > +	 * This optional hook is called if &drm_crtc_commit.flip_done times=20
out,
> > +	 * and can be used by drivers to attempt to recover from a page=20
flip
> > +	 * timeout.
> > +	 */
> > +	void (*page_flip_timeout)(struct drm_crtc *crtc);
> > +
> >=20
> >  	/**
> >  =09
> >  	 * @set_property:
> >  	 *




