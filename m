Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AE0C0502C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 14:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5B510E413;
	Wed, 31 Aug 2022 14:56:26 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78E910E413
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 14:56:21 +0000 (UTC)
Date: Wed, 31 Aug 2022 14:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1661957779; x=1662216979;
 bh=Qra7sfzlyFSrPLPAucwGFMvDPD4go5KG4w+hkvWi+D4=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=W4u8eLsxQBAP6RqWpZ1vTUaDBch7tXKWJLSJUe8vX8gPuS1d+HtjpetzMtgXP3Oef
 8lr/f4qjADAl5FPzC7fS06no3X5qtoF70ewQdpCol82XuY8zRRQ8xn1Zm0u6fWre8h
 PsL+vruRQrVPZiOBlYoFtyQ3SEX1bCdEVLeZcw2zkY94ZljWC7603LD8Pn7Ukz046Z
 ICCnhinulgNq7OePMlrdaJqjh9DSBeXNpg5fyOIIPVJ2jYQIVbXvyRjuWVac9fkIuO
 u0OaCHgofhziLDcfxXDEsDrDJ/0l3JQxVlO9fUwmu4fFS+bf6jV96lN4wLM3prDcvI
 pxZEH79+nlMrQ==
To: Pekka Paalanen <ppaalanen@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 4/6] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic
 commits
Message-ID: <Z4_OkSeCcfjYtgQvRf-w3-_YSFzvSJvy0s9p2VyP5GDMcRp8Gsw9drHctcYOM0aJgXXUKqWL5cB4TEunPlw6d9kktuLVt2ZnwaGkM2u9GCc=@emersion.fr>
In-Reply-To: <20220831105007.69e4c3e0@eldfell>
References: <20220830172851.269402-1-contact@emersion.fr>
 <20220830172851.269402-5-contact@emersion.fr>
 <20220831105007.69e4c3e0@eldfell>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: andrealmeid@igalia.com, daniel.vetter@ffwll.ch,
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 mwen@igalia.com, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 joshua@froggi.es, hwentlan@amd.com, nicholas.kazlauskas@amd.com,
 ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wednesday, August 31st, 2022 at 09:50, Pekka Paalanen <ppaalanen@gmail.c=
om> wrote:

> > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > index 86a292c3185a..cce1a1bea645 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -942,6 +942,10 @@ struct hdr_output_metadata {
> > * Request that the page-flip is performed as soon as possible, ie. with=
 no
> > * delay due to waiting for vblank. This may cause tearing to be visible=
 on
> > * the screen.
> > + *
> > + * When used with atomic uAPI, the driver will return an error if the =
hardware
> > + * doesn't support performing an asynchronous page-flip for this updat=
e.
> > + * User-space should handle this, e.g. by falling back to a regular pa=
ge-flip.
> > */
> > #define DRM_MODE_PAGE_FLIP_ASYNC 0x02
> > #define DRM_MODE_PAGE_FLIP_TARGET_ABSOLUTE 0x4
>=20
> Hi Simon,
>=20
> recalling what Ville explained that enabling async flips might require
> one more sync flip first, how is that supposed to work?
>=20
> A TEST_ONLY commit is not allowed to change hardware state, and a
> failing real commit is not allowed to change hardware state either
> (right?), therefore a failing async flip cannot prepare the next flip
> to be async, meaning async will never work.

I'd blame it on bad hw, and make it one special quirk in the driver,
just like it does now.

Ville, thoughts?
