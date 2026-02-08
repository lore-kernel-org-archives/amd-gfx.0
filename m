Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842DCE78D4B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 08:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A0610E352;
	Mon,  9 Feb 2026 08:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="Cxf+zPwR";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A6510E02B
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1770567183; x=1770826383;
 bh=OmwWr9q9ti2A7wNbYibF1nwp+q5Fh+4P2leIJfwVAqY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Cxf+zPwRa3FtbCiyP8+hO7FMMZjsOQTY7jZPaob8IUJzO9L6HNNoV/A8P5q1WUyUW
 RjZ6JREdvfUw4KFYsDbUCwjBswJ9WxRPqCuuB++Ssiig8+wS9b3vpHEvw0h2bfjIJX
 pE4xn1HhP82dDXwCULWBsdZZUEpVqtdo6HtYPgyCtwgRymwhgpp17Njhpfw2L7VFlu
 RXpyfkNohHvOXoB+sPwcSxVlFx7ow2JWcEhChXUM9pTjOg9QXwQUpbsS/6UDKUm3Gj
 eoOuJrbPcUnRAXyJa/pV/G3E7q4gS6tT5XPiVNnknr2jmoVyvkayHUu8TeOAEcY5KF
 0p52p1x/q5nyg==
Date: Sun, 08 Feb 2026 16:12:57 +0000
To: =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: Umio-Yasuno - coelacanth_dream <coelacanth_dream@protonmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>, Alex Deucher <alexdeucher@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 David Francis <David.Francis@amd.com>, maxime.schmitt91@gmail.com
Subject: Re: Accelerator/GPU top
Message-ID: <OjQ_uKCrG7FykSRAFuh9-Y2HxOhwxRhMUCgUktpBBBbz5RW7xvCBdS2zkPnOIYOXluvpq0O_zZ-ecpyGWHvtDCoIDk6GtxfgpTy3epLjZKE=@protonmail.com>
In-Reply-To: <3be1ec57-d078-40f3-8eb6-d25496fb7297@amd.com>
References: <CADnq5_MTX8CifP25UvE5kdMbCYxgK+A+KGdd-_Ef1m4VYv+WRQ@mail.gmail.com>
 <4c5c0981-fa21-4d8c-b5ed-45ebaf4d713f@gmx.de>
 <3be1ec57-d078-40f3-8eb6-d25496fb7297@amd.com>
Feedback-ID: 19510729:user:proton
X-Pm-Message-ID: cebc5f99d90db41b10b6ef04f21103fd147bfe87
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Feb 2026 08:41:30 +0000
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

Hello,

Regarding the proposed interface for gathering GPU driver statistics, I wou=
ld like to provide feedback based on the following points:

=E2=80=8B1.
Providing per-process GPU information through an interface other than /proc=
 would significantly improve the developer experience for Flatpak-based app=
lications and tools. Since Flatpak containers have a restricted view of the=
 host's /proc, it is currently very difficult for sandboxed monitoring tool=
s to gather cross-process GPU metrics.

=E2=80=8B2.
The current reliance on /proc/<pid>/{fd,fdinfo} requires root privileges to=
 access info for other users' processes. This is a major hurdle for non-roo=
t users when attempting to detect system-critical issues, such as VRAM leak=
s in a compositor.=20

=E2=80=8B3.
While ROCm/amdkfd currently provides per-process VRAM usage, it lacks an in=
terface to report the utilization of hardware engines such as Compute or SD=
MA. It would be highly beneficial if the new interface could address this g=
ap, ensuring that hardware IP utilization is consistently trackable across =
both KFD and DRM nodes.
=E2=80=8B
=E2=80=8BNote: I've used Gemini to help structure my thoughts and refine th=
e English in this mail.

Best regards,
Umio Yasuno

>
>
> On 2/5/26 20:25, Natalie Vock wrote:
>
> > On 2/5/26 19:58, Alex Deucher wrote:
> >
> > > Has anyone given any thought on how to support something like top for
> > > accelerators or GPUs?
> >
> > top for accelerators/GPUs kind of exists already, see [1] or [2].
> > Clearly, this problem has some kind of solution (looking through the co=
de, it seems like they check every fd if it has a DRM fdinfo file associate=
d (which is indeed not particularly efficient)).
> >
> > Maybe it's worth asking the authors of the respective tools for their o=
pinions here?
>
>
> That is a really good point. Adding Maxime Schmitt and Umio Yasuno on CC.
>
> Let's hope I've picked the correct mail addresses.
>
> Christian.
>
> > Natalie
> >
> > [1] https://github.com/Umio-Yasuno/amdgpu_top
> > [2] https://github.com/Syllo/nvtop
> >
> > > We have fdinfo, but using fdinfo requires extra
> > > privileges (CAP_SYS_PTRACE) and there is not a particularly efficient
> > > way to even discover what processes are using the GPU. There is the
> > > clients list in debugfs, but that is also admin only. Tools like ps
> > > and top use /proc/<pid>/stat and statm. Do you think there would be
> > > an appetite for something like /proc/<pid>/drm/stat, statm, etc.?
> > > This would duplicate much of what is in fdinfo, but would be availabl=
e
> > > to regular users.
> > >
> > > Thanks,
> > >
> > > Alex
