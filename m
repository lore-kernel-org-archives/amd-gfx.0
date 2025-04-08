Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0000AC369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 16:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899E610E717;
	Tue,  8 Apr 2025 16:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="XbDT8+va";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F0410E297
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 16:40:43 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6eb16dfa988so57819236d6.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1744130442; x=1744735242;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbSb5CymH8E4Hpn7ItBOcsJfR8XQYjy3MQAsc9OxjLU=;
 b=XbDT8+vaHL51rdDGLxENB/Mm/wLD9UFzYlug5BSXh7FmGGEb/OC+jDbI5fyZhuPx5n
 LwbyF2T+Qr/z/NsJMQ0lKHt9JDdN/sL/ZZ/2XnJmP5idmduc/u23a9aaXyW2hNr5eCBD
 JmWr7hGaZR0DfOPDemTWn1Hy6EIwFSscj4TuTQrk5ZpI07QqlA/3qK4GpiyyjCTM+vep
 sv5KiINSNyDFWxkUyJiidxrQZ0sdszLdk8CAn25GnTqEtWqexugKBE8HnEUfKSzyEjde
 Rw2x84W/4d6CZtweFeiIBV3CKXlDczbXTNx4iSpGXGbv/MkXkM6eHXf5u00IlpwfW75D
 ZMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744130442; x=1744735242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbSb5CymH8E4Hpn7ItBOcsJfR8XQYjy3MQAsc9OxjLU=;
 b=ZOoeT5o0QMJou1XDHeqSOCqTuO4anpJrM5LrXZIUTUR5Q1do6WpRPkAtNP9kZ0dcKo
 JrwX7e80Gff6uNiV3EayAKAeNUZxBAXuZccbFUGGOOykA6GuDqpXLcOBuTgQOQsMwKq4
 hLqBDh7/gDijLnnZbBmtYKFNes2HcyIDe0aoKTJVLqRDgVbqRd/IaWmXSO/M/cangru8
 L5o/6KmQCvztniQGaBHBnZ83nS9YCBwfb58W7o+fD2eK39QjxsruouU/Tw1QQ3SPPpRL
 xFGP1DVLStDk1m3/fo9ASPvHnjsH9zmcOMGzTN6+qpLNqnNEhz1ZfYOpIXKhElJpVrre
 I2SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt/uHQHc1qyadUcu+qyWKLgjXm7WRH8M+3J0jYyeNmuE+mnUGEfVs7olgsvxcRNA5tVOQsBY9a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEFq4kDToq4fsWtWUo66JtSOFF6HfLJDXpBh4bDBP2czicL2dx
 ZEnw+AOJuDm2EJr0KDxjJBibHjJ4kxQtwcadvNnyPtEWtOsfHs1djyg3AqGg/vnZlE3ALAYsr+t
 Mk9jcf23Pb94dwJHz4Ov0mD8+HrYf4N//oJ9yzQ==
X-Gm-Gg: ASbGncup+XLvlvr/1mKnTnOGkFh0xwrEXSZarBaq++WHuVmJjtosHb5wRMj4EnvWDFx
 I0sVk7CIl6ed1G1q4meN2wQAOWqpii5gSzTxwakZfala20cTwJHkTM7L7YFDJmyLoAxyOLg70bO
 vsNqO5lqaHBOBAYhNCOjGp+Iuv
X-Google-Smtp-Source: AGHT+IEZJ1gi1HhFeUERy3nzKZXUHEFu7F/gbG9CvWLGGfUEdV7xeDOQ7tAoIQlqPuH496zIWESrIPHhgKRjjh49cSs=
X-Received: by 2002:a05:6214:519d:b0:6e8:9d00:3d71 with SMTP id
 6a1803df08f44-6f058473612mr215899546d6.21.1744130442408; Tue, 08 Apr 2025
 09:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250326234748.2982010-1-alex.hung@amd.com>
 <20250326234748.2982010-7-alex.hung@amd.com>
 <CAPj87rOh=1OuASau+fjL_z+XBs-P=jUiQgjJjWXQZt1FYFC==w@mail.gmail.com>
 <46R4JuwCeyu56R2FsAN-j6n0Pu5VSeLdju8KUycQ3PF5cVQrlUO3C5SX8CgpRJ-QL5_-XS2ds94pPjhzEl6hOo3iyLl0y_d0Syzinn7BxSY=@emersion.fr>
In-Reply-To: <46R4JuwCeyu56R2FsAN-j6n0Pu5VSeLdju8KUycQ3PF5cVQrlUO3C5SX8CgpRJ-QL5_-XS2ds94pPjhzEl6hOo3iyLl0y_d0Syzinn7BxSY=@emersion.fr>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 8 Apr 2025 17:40:31 +0100
X-Gm-Features: ATxdqUGbqw73VrNuoJO5NXqIHri5e7fIaKR2oGXjDHZSJVHS6JSXyEVV_-XJi-Q
Message-ID: <CAPj87rOpp8CE_kmcJmp69pM5NhxBkLOGp-BKdALX4F8GL5-29Q@mail.gmail.com>
Subject: Re: [PATCH V8 06/43] drm/colorop: Add 1D Curve subtype
To: Simon Ser <contact@emersion.fr>
Cc: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, leo.liu@amd.com, ville.syrjala@linux.intel.com, 
 pekka.paalanen@collabora.com, mwen@igalia.com, jadahl@redhat.com, 
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

Hi there,

On Tue, 1 Apr 2025 at 20:53, Simon Ser <contact@emersion.fr> wrote:
> On Tuesday, April 1st, 2025 at 17:14, Daniel Stone <daniel@fooishbar.org> wrote:
> > 'plane' seems really incongruous here. The colorop can be created for
> > any number of planes, but we're setting it to always be bound to a
> > single plane at init, and that can only be changed later.
>
> I don't think the current design allows a single colorop to be re-used
> between planes? I think as-is, drivers create one set of colorops per
> plane and never share them between different planes?

OK, Harry's reply cleared that up perfectly - the flexibility that's
there at the moment is about being able to reuse colorops for CRTCs in
post-blend ops (great!), not shared between planes.

> > 1. Is it guaranteed that, if any plane on a device supports the
> > COLOR_PIPELINE property, all planes will support COLOR_PIPELINE?
> > (Given the amdgpu cursor-plane discussion, it looks like no, which is
> > unfortunate but oh well.)
>
> I don't think so. (They could all expose a COLOR_PIPELINE with the only
> choice as the zero bypass pipeline, but that sounds silly.)

Works for me: so any planes could not have colour pipelines, and the
result would be undefined (well, less defined) colour.

> > 2. Is it guaranteed that, if a COLOR_PIPELINE property exists on a
> > plane, that BYPASS will be one of the supported values? (The current
> > implementation does this, which seems sensible, but if the plan is to
> > not make this a uAPI invariant, e.g. to support planes with mandatory
> > CM steps, this should probably be explicitly documented.)
>
> Yes. This is a hard requirement, mentioned in the design doc IIRC.

Nice. I guess that's kind of implicit given pre-colorop behaviour
expectations. We'd probably need a client cap analogous to universal
planes to expose planes with mandatory colorop steps. This should
probably be enforced with igt.

> > 3. Can a given color pipeline potentially be used on different planes,
> > i.e. a colorop used to represent a separate hardware processing block
> > which may be used on any plane but only one plane at a time? (This
> > should be documented either way, and if they are unique per plane, igt
> > should enforce this.)
>
> Right now, I don't think so. Could be a future extension I suppose, but
> I think we need to properly sit down and think about all of the possible
> consequences. Maybe using the same pipeline ID isn't the best uAPI here.

I'm with you on this. I think if we were trying to express a single
color-transformation block which was shared between multiple planes
(MTK is probably the closest to this conceptually from what I've
seen), having an immutable COLOR_PIPELINE_SHARED = { ids... } property
would be the best way to achieve this.

> > 3. Can a given color pipeline be active on multiple planes at a time?
> > (If so, the implementation definitely needs rethinking: the colorop
> > would need to have a list of planes.)
>
> I don't think so.

Great. But probably needs igt.

> > 4. Can a given color pipeline be active on multiple planes on multiple
> > CRTCs at a time?
>
> Ditto.

Ditto.

> > 5. For a given colorop property, is it an invariant that the colorop
> > will only appear in one color pipeline at a time? (I believe so, but
> > this probably needs documenting and/or igt.)
>
> I don't really understand why that would matter to user-space.

Plane A: COLOR_PIPELINE@123 = { 1D_CURVE@456 }
Plane B: COLOR_PIPELINE@789 = { 1D_CURVE@456 }

If userspace wasn't defensive about this, it would program the curve
for 456 twice, and unless they were the same you'd get undesirable
results.

The existing implementation is fine here, I think it just needs better
igt to codify the expectations we all have.

> > Either way, I suspect that clorop->plane is the wrong thing to do, and
> > that it maybe wants to be a list of planes in the drm_colorop_state?
>
> I don't think so, for a given plane, there can only be a single pipeline
> active at a time.

Yeah, again that was just not having grasped that the colorop not
being derived from the plane was actually about allowing for it to be
attached to a single CRTC instead, rather than potentially multiple
planes. I have no concerns around this.

As it stands, I've gone through the implementation pretty thoroughly,
as well as our use of it in Weston. I'm happy with how it looks for
pre-blend, and I'm even happier that the implementation is written to
apply easily to apply to post-blend CRTC pipelines.

With the suggested uAPI doc fixes and igt additions, this series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Thanks everyone for the immense amount of work that's gone into this. :)

Cheers,
Daniel
