Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970ACC36010
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 18:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D43F10E256;
	Tue,  8 Apr 2025 18:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="Lc2LL1Sn";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A3310E2C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 18:29:08 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-47662449055so31461111cf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1744136947; x=1744741747;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wnJMeGeygiELK5KDa7MNHpgLu+a1Tj2VkGwfQxzOg0c=;
 b=Lc2LL1SnyXYdy/vHuRDuUHvIuGEjG4uiB4m8ci1zPpVVTB7gqh73th6vWlP4srJAwr
 G3Y520ehI1apEOeXhE5Lo4TuUXT/Y0IuoojuM94KUZBbPjcIIggPU4pxTvNVclPwha8p
 0opxj3qouUy67CzhZgCAf3jmQkibwCND3bc5r1gSQIas+/APg4hvA8f47i+5fDmZQlnv
 LylcdtSx2DRS4R28NWAy4vzv7REJkjGYSyaKLL/IdnIrdgPCep3r7oB1zyiELiY2NOO+
 9Bw5VZQZGidhgUS7bCivkwRR74w6kABQNqsvUUuZA4+32MealgvbiZ3JT/cha5F7Agyk
 RSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744136947; x=1744741747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnJMeGeygiELK5KDa7MNHpgLu+a1Tj2VkGwfQxzOg0c=;
 b=vfa8wW196EZqawo86/o43bcbcykYaNHNN3CeAzupViMWO6tgGofkgzzRIZyM32YFMo
 IpNJi+myw04NQk00eXr9Ca7p+ggOZ3jGEErD59/F4UxtzG/fK3yqSgDar2p+tyjpqGC+
 KAtkvp3ZBVX2rMEfiT+AObAbF1t0WkQCxTi+0aP7KexQ3NuMtRbcC4lGorvIbrSZ47O4
 3XmWKsFy1YLgU8Jiv9nv+l4ZlyouC6PrgJCiSSsy/dnoFT/5enVKMTfNZqxGnb070TNb
 GSRbUoYqg/TatAW7vyQEQsNdh7N3p6qAnCBpVJmlSZu01sbFUa1FIZOJND65s8q7lgo1
 ld4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7wXG51rf8ohFYA9VHNIn7yONpurl4t8MMkepSvx+LJ/ygGMD2BXTe8pIASQ0Jvmxb3vgoi/Aq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzffJ6LFOlEBx4u7uJ9YiLKhmNtXXZ9WDEtkG3dsW9VvDYQxJwx
 R5UOwvbl9bFNnwM98FqPOVk80qKKpC5T1gC+t1OWvgWoaxnwYGz6To8xp2EHtA9e6cOrnNdL/wJ
 V2wiSfQ1l7vA7d9p8f5CvK/9sg2BiZyeReJkN+g==
X-Gm-Gg: ASbGncsoYZBCxBTGZxN6QcsKAorl08m6qQkhivZO5NdptOglimsQN0OPIPUSGZ/FcVb
 qEuYjlVJBbIUl80BcgOZGWf09+DkVOQe+rLhLvwX406V6MPg6ERgU7hqVYLwT9Rw/dsPpF0ggpU
 upyWTcjNbtOyN1mf6u2N6VY2ox
X-Google-Smtp-Source: AGHT+IHkiKiOx8zEwytj2F0hfHHlmvcz1w1J+CXVq3PVa8+Gcjwc4AyeAV9KFzIa2DI74k8Y1rRE2pPUzoblEz2hsT0=
X-Received: by 2002:ac8:5843:0:b0:476:87dd:16f9 with SMTP id
 d75a77b69052e-47925957f3emr300079321cf.18.1744136947096; Tue, 08 Apr 2025
 11:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250326234748.2982010-1-alex.hung@amd.com>
 <20250326234748.2982010-7-alex.hung@amd.com>
 <CAPj87rOh=1OuASau+fjL_z+XBs-P=jUiQgjJjWXQZt1FYFC==w@mail.gmail.com>
 <46R4JuwCeyu56R2FsAN-j6n0Pu5VSeLdju8KUycQ3PF5cVQrlUO3C5SX8CgpRJ-QL5_-XS2ds94pPjhzEl6hOo3iyLl0y_d0Syzinn7BxSY=@emersion.fr>
 <CAPj87rOpp8CE_kmcJmp69pM5NhxBkLOGp-BKdALX4F8GL5-29Q@mail.gmail.com>
 <87fd7840-b021-4d3a-9d0b-2724e941c5dc@amd.com>
In-Reply-To: <87fd7840-b021-4d3a-9d0b-2724e941c5dc@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 8 Apr 2025 19:28:55 +0100
X-Gm-Features: ATxdqUFEF4Q9mAfrumzSuc7g5ifgiQqNhjSqadOYsGxpNal9icnc5V1X2xA53Q0
Message-ID: <CAPj87rPhc1L7gGW9WY0SDdG5SN12wvxhbbz=mt_2SmuoRwv9wA@mail.gmail.com>
Subject: Re: [PATCH V8 06/43] drm/colorop: Add 1D Curve subtype
To: Harry Wentland <harry.wentland@amd.com>
Cc: Simon Ser <contact@emersion.fr>, Alex Hung <alex.hung@amd.com>, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, leo.liu@amd.com, 
 ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, mwen@igalia.com, 
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com, 
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 xaver.hugl@gmail.com, victoria@system76.com, daniel@ffwll.ch, 
 uma.shankar@intel.com, quic_naseer@quicinc.com, quic_cbraga@quicinc.com, 
 quic_abhinavk@quicinc.com, marcan@marcan.st, Liviu.Dudau@arm.com, 
 sashamcintosh@google.com, chaitanya.kumar.borah@intel.com, 
 louis.chauvet@bootlin.com
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

Hi Harry,

On Tue, 8 Apr 2025 at 18:30, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2025-04-08 12:40, Daniel Stone wrote:
> > OK, Harry's reply cleared that up perfectly - the flexibility that's
> > there at the moment is about being able to reuse colorops for CRTCs in
> > post-blend ops (great!), not shared between planes.
>
> Just to make sure we're talking about the same thing:
>
> The design intent is to allow drm_colorops on a crtc (once we implement
> that), not to be able to share the same drm_colorop between a plane and
> crtc.

Right, that's my understanding here.

Cheers,
Daniel
