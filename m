Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00995C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 15:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9F210E112;
	Tue,  1 Apr 2025 15:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="mF3pMUUW";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F180A10E112
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 15:14:43 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6e8efefec89so48825886d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Apr 2025 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1743520483; x=1744125283;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kF5PXIoeMjDQGNj6HtCBg+FijPQ8aiEElhntbyKpmQU=;
 b=mF3pMUUWjNIcDO3LgIHlmvJKoeek/XhbfN6xAZARdEGF+Ohy7pHf8t+aNobCFUud+E
 jOd540F/mRvL62mY2ymngMQUpQ06GI1d5brPdHhJVw381xh0R2+KYbaK7G4qJu32zt1A
 ZR5KnwT08+NJ92BMGPt9JY+EXNChw9R3BaspVMrJpGTa8/2aQYfD2R0bYWK41jHSaDLw
 2/2oujT+WCcf6AgjSP/ujg8pV1kO0msnP0/4Gm9ffysGqjopMaWa09I8jIGe+O0bP+Nq
 m1rdwlESYoCtLF/7N69IdUfVu0U5qaavaBFkcQ4uhUreF+QCYE1HgQXBT3OFzql198xW
 n8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743520483; x=1744125283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kF5PXIoeMjDQGNj6HtCBg+FijPQ8aiEElhntbyKpmQU=;
 b=NLn2ElQJUY4Tuz6VhP7nnC2crwaI4RkTt0TojCyT1aNDtwEgOddW1CQrWU1yoZQBnv
 eK/VJP9g0xFTjKPkEU0kZqV3y+cmybCRbbeMy+J+Y7AnHl4YP7Mq5QdUS0lrANbyJM/J
 yAkKiP5Sxn5FV1udfiA7Tn16NaBaHP79dN9SLtznYeI5K0oxTfrVIwMnpldsypSiZ9BI
 dqibgMNAC9dLxRd2bzqIytmCS+4RLDej0UH+4L7Cg5acKip+XW4IgEFJockJ/uBlIjnd
 8aGSRcNYhAmXIIUFvJbgZmIyzNDBDhzJml/D7tfxWRLJscu2JlLL1l6JIE34o8BFlpU9
 Dy0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX06kmlRfGS7FMIftww8O3EEHnEQXS0g/apeQqAQlq1wABn1apYZ5Ie8Ern2XE4Uar5jbm0Rz7s@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYr67UhBsbxYxjcIajm5atLs8j4hmKUV72rdzdJrzF8aYW7D7O
 K+4ID1IBiuwR7Hl2sKeOrE7TwHOm64SG/+GDbB6reJEfL9P5jeST6Wn1oUyJmS5LIASiFYyJTn4
 yysFgFgvMfruJYmEl7ilzbEVWSK5GnauoXD8Jtw==
X-Gm-Gg: ASbGnctKNe61MlGoXzNvY6jAr8c9Z+JdZkjAYZ9UufkuflddAYbwjZNcx+IWeeOHQZO
 YU31E9j8r9XcsIvmayViLs46c/pp4Bao1uc5d0Hm6XIs0As1/qPMBt21u1oY02egWXLLPY3hOkB
 CAkfHTH034PfrmZfYL7NsqO88=
X-Google-Smtp-Source: AGHT+IG/6o22bgLO8gypopmq93KMhQXUD2ouGdW3beT+zn6GpJZioeneAByX4hRsQ5M6CJAW9PYHbQYESkoa1FYhXQo=
X-Received: by 2002:a05:6214:300b:b0:6e8:f949:38c6 with SMTP id
 6a1803df08f44-6eef5ed4831mr51479786d6.33.1743520483018; Tue, 01 Apr 2025
 08:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250326234748.2982010-1-alex.hung@amd.com>
 <20250326234748.2982010-7-alex.hung@amd.com>
In-Reply-To: <20250326234748.2982010-7-alex.hung@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 1 Apr 2025 16:14:31 +0100
X-Gm-Features: AQ5f1Jq83jhYE5DeMNdtCJBK9LdwSzxVMKHurDwEQvQ5LjhNo6OcNPPflV6X384
Message-ID: <CAPj87rOh=1OuASau+fjL_z+XBs-P=jUiQgjJjWXQZt1FYFC==w@mail.gmail.com>
Subject: Re: [PATCH V8 06/43] drm/colorop: Add 1D Curve subtype
To: Alex Hung <alex.hung@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com, leo.liu@amd.com, 
 ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, 
 contact@emersion.fr, mwen@igalia.com, jadahl@redhat.com, 
 sebastian.wick@redhat.com, shashank.sharma@amd.com, agoins@nvidia.com, 
 joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, xaver.hugl@gmail.com, 
 victoria@system76.com, daniel@ffwll.ch, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Wed, 26 Mar 2025 at 23:50, Alex Hung <alex.hung@amd.com> wrote:
> +static int drm_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
> +                           struct drm_plane *plane, enum drm_colorop_type type)
> +{
> +       struct drm_mode_config *config = &dev->mode_config;
> +       struct drm_property *prop;
> +       int ret = 0;
> +
> +       ret = drm_mode_object_add(dev, &colorop->base, DRM_MODE_OBJECT_COLOROP);
> +       if (ret)
> +               return ret;
> +
> +       colorop->base.properties = &colorop->properties;
> +       colorop->dev = dev;
> +       colorop->type = type;
> +       colorop->plane = plane;

'plane' seems really incongruous here. The colorop can be created for
any number of planes, but we're setting it to always be bound to a
single plane at init, and that can only be changed later.

I can see the sense in allowing different pipelines to move between
different planes, but then it shouldn't be set at init time. I think
you want to just drop the 'plane' argument here, and only set the
plane during an atomic commit when actually switching the state.

It would also be helpful for userspace to know how color pipelines
could be used, and to back that up with igt. Questions I have whilst
reading this:

1. Is it guaranteed that, if any plane on a device supports the
COLOR_PIPELINE property, all planes will support COLOR_PIPELINE?
(Given the amdgpu cursor-plane discussion, it looks like no, which is
unfortunate but oh well.)

2. Is it guaranteed that, if a COLOR_PIPELINE property exists on a
plane, that BYPASS will be one of the supported values? (The current
implementation does this, which seems sensible, but if the plan is to
not make this a uAPI invariant, e.g. to support planes with mandatory
CM steps, this should probably be explicitly documented.)

3. Can a given color pipeline potentially be used on different planes,
i.e. a colorop used to represent a separate hardware processing block
which may be used on any plane but only one plane at a time? (This
should be documented either way, and if they are unique per plane, igt
should enforce this.)

3. Can a given color pipeline be active on multiple planes at a time?
(If so, the implementation definitely needs rethinking: the colorop
would need to have a list of planes.)

4. Can a given color pipeline be active on multiple planes on multiple
CRTCs at a time?

5. For a given colorop property, is it an invariant that the colorop
will only appear in one color pipeline at a time? (I believe so, but
this probably needs documenting and/or igt.)

Either way, I suspect that clorop->plane is the wrong thing to do, and
that it maybe wants to be a list of planes in the drm_colorop_state?

Cheers,
Daniel
