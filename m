Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A704DE6BF17
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 14:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD7E10E11C;
	Fri, 30 Jan 2026 14:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5LCfFMk";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D316910E11C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 14:31:24 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2b6aa67a792so351891eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 06:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769783484; cv=none;
 d=google.com; s=arc-20240605;
 b=QPMDnABGt3UKpfSZO5oFCvDhxUKSiCXZO0GW5mbidGieowQP5tNGPV9mqKHolASJ7g
 lzkvJaeOV5wtyyVVlV8cfvXQhQ8l0Wv7B+4A+oDeqC667liipoPrEwhjStA48t2tQN5Z
 qCNXO4+v4ASgY9iIDGeOxIRvXvkZmzkpWsmh8hidk2AsR49pD7OqKMzv0tmZFlZRPZ29
 w++c3tqZzJICz6gStLAYJfQRJj3B8jlFUjEJYOYs1YEYHxcUGQP/g8X8fo6fEimz06KC
 6WdafWu2NiaiI4kOD15PeeYdjIsdJSYdJQQfV7jO+H2C4OO8Om9CtNYjqogJZcOIrFke
 illQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VKoVBpHvy8Ov4xwgQ/ZJuXE/Mt18buqjPgaIEBVu5bc=;
 fh=oBASCySbZP2j5XnniTBVaDx8vqyYI8qWFFRINszqKUI=;
 b=fZpthsGKu8BnnQynCBByJ6j3fRrTi/pBd39A8vrAhQgyAH/4ZSlB27ylLbK8reJ3ml
 XV4HDvUCj6WOujWLlZjOYbPvck1vfHJQIn5GSbLRv6atq9b8qXyGfqUBP8c9xQ7vqVa/
 9VZYBn1Tq77zuqtNZLS2P1qmsRvt3ie39I/AN7JwC2oMVKOz0NWuoOVE4ZAxssiFhqri
 TRf5k4PZDg3xHh5XsdAysjZlqbYvM4UGuZ7XhlMblzA7WFwXwW3sF6Z3RJ7kw3963hBK
 U1YQ+A3R4NoW3v+cNgfuekt89Vgdd/TUf2f75VVbo+yxoffYv5HOrvXL2Tzyu5whut03
 gnQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769783484; x=1770388284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKoVBpHvy8Ov4xwgQ/ZJuXE/Mt18buqjPgaIEBVu5bc=;
 b=X5LCfFMkoZc38BVBjWG4zjOwb1nug82BN4lokA6rTrvp/yhtJ7RnLfD1YO5LU/I9JD
 8JZNXKY3v34b5Yu4oVENI4MdypaKw1LeEvggajxBBjrGqy4RblZv3+YZRlS4QAC7WPNE
 zpKxCI7Otyqps3J3UE7dSf+C79pQAV0XO2unWECCOLFXgagauh27YttqLxKpTkKWsKeT
 aDxJvsw++KWzzWir41K29re9x807xq1NVOa5APOQgXsiOKugrrhZEwwxkbk9OHY+DI9h
 P211aWEiZ/+hAV6qWOMwjonlTdAes67e0TZA9vOCvHuV0jAq3iy7+bzgD7BK3Ui/raiw
 dX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769783484; x=1770388284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VKoVBpHvy8Ov4xwgQ/ZJuXE/Mt18buqjPgaIEBVu5bc=;
 b=TNv2UV/7rTVjuWAx1d17LLwC3M1Rj0A+ERAsyjaXOGx9Zj0R7bA08Mktk/5HN2+3vP
 IrP7YVvZOi/od1KTFa+Yp4/gygzl6HenvCzNDJjU5q9fDU6zCLOPsFpJs6CQlcuLrtp7
 Ar3Kuqaekj+tInR/8F0Duxa+7gwJw4ZP/GTIuf+U8BczyF1JaiFmMWmHv3rLDHd8bk/c
 B9phGUJlMpYu3ZfLvM65kKbSy2GZktggnfapvQMYOxO6Go2qLasYWlTCtheMUhmeKez0
 NUTA+IoyVL7rOs8CpbUDh5dzo2qFjrp8WasNgcNHoT+yugiUwkfwdwV3MYCK/qNkEadk
 TRsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU9naNtV4L5OJrYw14meU+iaxIOnh+oq7pxyZjfYmqs3jGN5p6qYUkRcHIneIjbNAtdhcezlPi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2dNPXVUbjXx9g8G/kVGuENWZaedvm9CPXkSQ0APorK1W/s9EF
 qoUOg6O9spwuo0jWuLk89QSC5pjTfj0o3RXTbFUoK3D3lMTzTjCCsbnOqAdIsxCBfR0qPl0fID2
 hInw3l3EVJ8eUQ5rVuz/aViqrbbUXU6c=
X-Gm-Gg: AZuq6aJudgkiHjj3FHdSjaLalB2c3DZzu/PgkWJ2PPDNetSz6TlYJNUVzaKhFMeBc0H
 g85CT6nlZZkF7nYesisF1s0s6fNWI3nDhod9j9/HLJkRdIuPFem7jIG/51SwszW67NdeDIEa0cw
 Y3gA6eaV4brpDz5f49MgtpgYPvYn7cvisQhUhWnwsD37Cm7nTt68glt4gcN7CMn4dh8ZhpsOA7w
 LpEGRtQ9b8nHiLlPUYswG7Hgj279ezIUkTizqo7gpxcAaMzSGsxmE+NKDLJDujJkfv7avph
X-Received: by 2002:a05:7300:a50a:b0:2b7:7a6:e984 with SMTP id
 5a478bee46e88-2b7c86de216mr775486eec.4.1769783483614; Fri, 30 Jan 2026
 06:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20260129043446.33377-1-alexander.deucher@amd.com>
 <6fbe8046-cb00-49ca-8bc0-c1f3b747767f@ursulin.net>
 <CADnq5_O-Nq8Y+9enz11gqbFOnJsL9Xmf4F2hxJ3vx4k5OOD1FA@mail.gmail.com>
 <f9f1f2cc-861f-47e5-b95a-cf48da430fcc@ursulin.net>
In-Reply-To: <f9f1f2cc-861f-47e5-b95a-cf48da430fcc@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jan 2026 09:31:12 -0500
X-Gm-Features: AZwV_QgcbUuw0hQ3GgPnMehy-__ozVZ8bEo6LXiu8ZSEb4t-2i-1oc2x-F3eMuI
Message-ID: <CADnq5_NzRbo=_a1fGmjUBHMWVdvbHnuEwWpytUbMCqBXQvB7cA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx10: fix wptr reset in KGQ init
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Jan 30, 2026 at 5:28=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.ne=
t> wrote:
>
>
> On 29/01/2026 16:39, Alex Deucher wrote:
> > On Thu, Jan 29, 2026 at 11:27=E2=80=AFAM Tvrtko Ursulin <tursulin@ursul=
in.net> wrote:
> >>
> >>
> >> On 29/01/2026 04:34, Alex Deucher wrote:
> >>> wptr is a 64 bit value and we need to update the
> >>> full value, not just 32 bits. Align with what we
> >>> already do for KCQs.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v10_0.c
> >>> index e9254ec3b6417..ef7d91a4437ec 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> @@ -6883,7 +6883,7 @@ static int gfx_v10_0_kgq_init_queue(struct amdg=
pu_ring *ring, bool reset)
> >>>                        memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_i=
dx], sizeof(*mqd));
> >>>                /* reset the ring */
> >>>                ring->wptr =3D 0;
> >>> -             *ring->wptr_cpu_addr =3D 0;
> >>> +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> >>
> >> For my education could I ask if this just about writing the 64-bit val=
ue
> >> or the atomic part is also important?
> >
> > Just the 64 bit value in this case.
>
> Thank you, it was a bit confusing for me. Even in the context of what
> you explained to Timur that pre-gfx9 wptr is 32-bit, becauase when I
> looked into for example the gfx8 code, I saw it doing a mix of 64- and
> 32-bit writes.
>
> I guess the layout of the write back info block thingy is fully
> software/driver defined which is why this is not an issue?

The buffer is 64 bits because we support a mix of GPUs, some of which
support 64 bit write pointers and some of which support 32 bit write
pointers, even on the same GPU (e.g., different IPs may have different
sizes).

>
> Would it be worth getting rid of the atomics to lessen the confusion and
> attempt to somehow make this area more self-documenting?

Yeah, I suspect the 64 bit updates came back to the older IPs as part
of code unification and cleanups from newer chips.  Each ring has a
ptr_mask in its ring data structure which defines its write pointer
size.

Alex

>
> Regards,
>
> Tvrtko
