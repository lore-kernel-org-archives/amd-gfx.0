Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F20AD3F06E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 14:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F5A10E704;
	Wed, 28 Jan 2026 14:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h5BGSeaL";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FF710E706
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 14:23:56 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b884d5c787bso1271330966b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769610235; x=1770215035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuRBJsDCSrwFtqMVKXPOBvEwtKqngmn1pY31nw2tKng=;
 b=h5BGSeaLGNpcixdBkJyxSPwLhQh5u+fAs3JIznpczHt/WHYAdcblDKchvLFb8oYXCs
 rWb/yLwx2tjBkpjzhBRzu+Lou4tUfDI6AW4aQk1C6/SXjF6KXq3wA59TSwUSm49EaokN
 WGRhbQdBFwWXBxs30w7ehfYfz+raNazCTJStWolrOXV0sAjgRd/U9axCVjfgU0YcmXbW
 JBTlE3wo0i6utQAYbwNgOoOonVAFugYLMX3WUQil6CQY8ZHsooFj5eUH53IXUrfmAza+
 NmCgukV7EjEMNfXxC6Bmu0san87mOfJEa3Pb2AL7Da2kUFMeTPg6vqGq+g2oSYa3lCrC
 CTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769610235; x=1770215035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QuRBJsDCSrwFtqMVKXPOBvEwtKqngmn1pY31nw2tKng=;
 b=gVdzFbuMfumV1ncy41Ieajzrn1qn3osPV1p7DO3iMxKfh+6nKZwJ3uLp3wtnspg8vE
 Tk1pVbhg88SXcg0HvI454t1kA/4z3O/rB7fQZkIhB1EipZdJ+NNXaTAC4AshUvKKzy9K
 4TbLLwyX47EPy4j8qfsXD0jBlpK09WP8jVXAyBSdXNeDkl4k2u1VlKvw65BAR+6CJWON
 8Q/kdflMsAzC9xuFbMaPOsEwByOy2LXzrVShG+oCGYwi5eBCSIOjaP7a+KYAo8f3blG7
 x0nLfO36Ukp1pGfq0fZZLwkt94fxPoqme8Pv+5rcU16/XkSA/7cS+Iq4ymHnezjKmpXs
 EMZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN7MHeh6lIFoDS3PqtUwevu/IOKICONTbp1MXC/9Er1oLD5txBxhPf3E2vmcSzbJeQa0HYVIOX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxG0GCTBWQPQqOAVFUwtDDsteuRGg8tV21M5fXgTjEk3Vx315S
 Z2hp5ngiWCip41z8bZnIxa7Ntf47yhfw0eUiAlK5cNPQbDpw4Ar9XP9IXMjE/w==
X-Gm-Gg: AZuq6aKmCmiAOhPrJjFfcIXfXxc7T6mGzSgO79cpETVrtDOuxje0MMwT4Sx9cTEA1Cl
 F6gx79itdnqx7XcM94erFoJ5+kmcn78TFTOplbofBUV3j+l8zndlYAp1z5ajbaLBJg8oC1A1vUD
 HJSj1lfPEKE1Ee+jtmlgRpyJVSTd97in/vlSjUOp9dtfqv12fp4hGzcMUT7fU/i6Pe755u1Gt1y
 Rs2DpoHtJ3yj6tw1x15V2dWklkGgoVtCW14cZijUB9MUFdQFIRjMaudYcaZE284ZLKkNyZMyIGz
 ZdfjQrR0/hC+ckVqjLQaiIPbNiQW9qSW/1Ig7NRMxgxci/xFZ9xfvN0+05WR5TFwy/H45IVIBT/
 yE7MkuP+TajTBrFpLJixd8jY2nRfgg7AN2e5sQuDoyhUny1L3ATWBfmn9Wp+JyW9j+cAU3OlVjt
 StKiXnPqe0UhQr2XxRCKhBCgEFe98MPsWByJgf2m2DLw/ZqjHr+VwZn8Gh36HvCbXhvznYLg==
X-Received: by 2002:a05:600c:1994:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-48069c788c5mr66971155e9.21.1769602974756; 
 Wed, 28 Jan 2026 04:22:54 -0800 (PST)
Received: from timur-hyperion.localnet (5401DF8B.dsl.pool.telekom.hu.
 [84.1.223.139]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm119139985e9.7.2026.01.28.04.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 04:22:54 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Hamza Mahfooz <someguy@effective-light.com>, dri-devel@lists.freedesktop.org, 
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
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Date: Wed, 28 Jan 2026 13:22:53 +0100
Message-ID: <2770547.lGaqSPkdTl@timur-hyperion>
In-Reply-To: <a2fe8187-9271-4cbf-8b7e-37ffda0799de@amd.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <5173841.OV4Wx5bFTl@timur-max> <a2fe8187-9271-4cbf-8b7e-37ffda0799de@amd.com>
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

On Wednesday, January 28, 2026 12:25:31=E2=80=AFPM Central European Standar=
d Time=20
Christian K=C3=B6nig wrote:
> On 1/28/26 10:19, Timur Krist=C3=B3f wrote:
> > On 2026. janu=C3=A1r 26., h=C3=A9tf=C5=91 14:00:59 k=C3=B6z=C3=A9p-eur=
=C3=B3pai t=C3=A9li id=C5=91 Christian K=C3=B6nig
> >=20
> > wrote:
> >> On 1/26/26 11:27, Michel D=C3=A4nzer wrote:
> >>> On 1/26/26 11:14, Christian K=C3=B6nig wrote:
> >>>> On 1/23/26 15:44, Timur Krist=C3=B3f wrote:
> >>>>> On Friday, January 23, 2026 2:52:44=E2=80=AFPM Central European Sta=
ndard Time
> >>>>>=20
> >>>>> Christian K=C3=B6nig wrote:
> >>>>>> So as far as I can see the whole approach doesn't make any sense at
> >>>>>> all.
> >>>>>=20
> >>>>> Actually this approach was proposed as a solution at XDC 2025 in
> >>>>> Harry's
> >>>>> presentation, "DRM calls driver callback to attempt recovery", see
> >>>>> page
> >>>>> 9 in this slide deck:
> >>>>>=20
> >>>>> https://indico.freedesktop.org/event/10/contributions/431/attachmen=
ts/
> >>>>> 267/355/2025%20XDC%20Hackfest%20Update%20v1.2.pdf
> >>>>>=20
> >>>>> If you disagree with Harry, please make a counter-proposal.
> >>>>=20
> >>>> Well I must have missed that detail otherwise I would have objected.
> >>>>=20
> >>>> But looking at the slide Harry actually pointed out what immediately
> >>>> came
> >>>> to my mind as well, e.g. that the Compositor needs to issue a full
> >>>> modeset to re-program the CRTC.>
> >>>=20
> >>> In principle, the kernel driver has all the information it needs to
> >>> reprogram the HW by itself. Not sure why the compositor would need to=
 be
> >>> actively involved.
> >>=20
> >> Well first of all I'm not sure if we can reprogram the HW even if all
> >> information are available.
> >>=20
> >> Please keep in mind that we are in a dma_fence timeout handler here wi=
th
> >> the usual rat tail of consequences. So no allocation of memory or taki=
ng
> >> locks under which memory is allocated or are part of preparing the page
> >> flip etc... I'm not so deep in the atomic code, so Alex, Sima and
> >> probably you as well can answer that much better than I do, but of hand
> >> it sounds questionable.
> >>=20
> >> On the other hand we could of course postpone reprogramming the CRTC i=
nto
> >> an async work item, but that might created more problems then it solve=
s.
> >>=20
> >> Then second even if the kernel can do it I'm not sure if it should do =
it.
> >>=20
> >> I mean userspace asked for a quick page flip and not some expensive
> >> CRTC/PLL reprogramming. Stuff like that usually takes some time and by
> >> then the frame which should be displayed by the page flip might already
> >> be stale and it would be better to tell userspace that we couldn't
> >> display it on time and wait for a new frame to be generated.
> >=20
> > I agree with Michel here. It's a kernel bug, it should be solved by the
> > kernel. I don't like the tendency of pushing userspace to handle kernel
> > bugs, especially if this is just needed for one vendor's buggy driver.
> > (No offence.)
> Well I strongly disagree. The kernel is not here to serve userspace, but =
to
> give userspace access to the HW in a generalized manner.

Isn't this why kernel mode setting was invented in favour of the mess that =
we=20
used to have in the DDX drivers?

> If this is caused by a HW failure then reporting back to userspace is the
> most reasonable thing to do.

Nothing wrong with reporting the problem back to userspace. But it isn't wo=
rth=20
much, because userspace is extremely unlikely to be able to fix it. How wou=
ld=20
userspace fix a missed or broken interrupt, a firmware hang, or buggy=20
programming of display engine registers?

Also, even if it were possible, expecting userspace to fix it would just pl=
ace=20
extra burden on compositor maintainers, which in turn would put us in a=20
similar situation where were with GPU recovery before queue reset was=20
implemented. Only a small handful of compositors can handle it (only one of=
=20
the major players and maybe a few smaller ones). That gives all other users=
 a=20
bad experience by default.




