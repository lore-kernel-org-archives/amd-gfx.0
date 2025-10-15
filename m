Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE32ECCD192
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 14:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6278610E0BA;
	Wed, 15 Oct 2025 14:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VaN8xFLx";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0953510E0BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 14:30:48 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b63117fb83dso263572a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760538647; x=1761143447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PALhWaPSZygfP0jpssrnxsGvz1wv+NOobz979Wa9agQ=;
 b=VaN8xFLxnqKOib4BygkGz5UwZeVZDxQAoCx8M1w5OJzor+XnDlAwr2krWWAxL4d4W+
 MCeHFiYJ22faeQkx3908Aopd7yFIZwxl0rkrIH8PzXZ2DTMYQk5+kWaK8HXQLIXcYxIe
 7TGETQp40Mtg5/7t0DcMjnU3jZysBmBct05Xa76NGlCzfzMyhlLrSAF9i/eg0/yQ1X0I
 QK7mXpRjpgM1QVZ6HD/xmf9OUg6ES1wdm7GNZPO+QpVOWgW0oqRBGv10tOFmR/eN8XZf
 0WQWI+VebBSUw7ntq3k5ezLcgm40E+gP45LqRPEZmFhJ9PNOUPSOhU3b1zsYZKzElP36
 b8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538647; x=1761143447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PALhWaPSZygfP0jpssrnxsGvz1wv+NOobz979Wa9agQ=;
 b=URn/ULbLRLMef56LEGY8xXatMlbnXRI8b9GngYlYEVE2cHDHpbstMvEfIg5IrXj6j2
 P+Xm1yDbIK/5/+wj3J0G/YMB+Dj+gRSkQI7TrM2ADK3ZRimwlOJjkg64iS30NYmmVsRG
 cDMM+ftM3k/qzqn+Scf/vvB5bdzRlcmwzpzGylglPDdu24EV7fq9DanCpF3FNll4HzRS
 dZ+bw7AgvxAq/rN4UJQzfUZ0R2nHS2sDczFv9JGaU2wnf2aXtG74cpQwWpOBxVWz181Z
 SqwnssSXPBJPEW9SpmWs9esYzSMKLI2zPYYlAZzq1xVfTIAVu8xuQ8zISwS0yIzTC5L3
 +Zfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqn++qIfSzgK8hdQpkpW/5Qz3LfCbvAghK1wIwNTL9BxBeL4NaZcQMIJx9tFxA7Xo6HVdooAG1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6StkP4NEDKbNruOVaJuFOXc1cEphT0PcUydLbFqxEwXW9zNaO
 LMZXMElTODkdJYV5lNvv07uj873HtGg9tJ5JleKrGYznDYnZtUUJ9wRheU03QArjVbuIuHTyfJt
 kOEtbEqIeJ1RiYc+vtvoCg/tfkU5JBbqDXA==
X-Gm-Gg: ASbGncuOf/qZJ/aMlrKEZqKIBl5tSGRmTnx2Ri8wCebt3sIwDaVT1QFVqVsT9710sGe
 g1hpQwsHk9aXOCANuLFKMTnAwncEPg3aKMTZTZRH96fBZC2Z6sd8VBeSUoAQ9hOLKIiAQD7jDSx
 83HWN9FMKfkLWNXlY5fz60QrPmuFfFOKKMsb7QrC4UrDe+MN08PpNxshX6qlD04fRAVR0btRYTT
 j5hqRaS1e1zld7JQu8rHj1OKw==
X-Google-Smtp-Source: AGHT+IFoE5cLl1HynwWi0VjqEehsMd6bORUJ/kMe3GCMcxNhJSM8ZntBmc1j3oEosi0XSUhX/hoGXy3c8QKeRpZVGeo=
X-Received: by 2002:a17:902:f54e:b0:269:78b1:6307 with SMTP id
 d9443c01a7336-290272ff546mr229161135ad.8.1760538647195; Wed, 15 Oct 2025
 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
 <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
 <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
 <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
In-Reply-To: <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Oct 2025 10:30:34 -0400
X-Gm-Features: AS18NWCHffjEU4bMrYhZMSxAvxeQTq_5p0d-Ua5ETR3Xo-Lbw1eX8J13RbDOX9Q
Message-ID: <CADnq5_PuRs-kuP=dnvmazwgZhf0TkvBcvBxjm0iPxn3C=v3q9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
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

On Wed, Oct 15, 2025 at 10:19=E2=80=AFAM Harry Wentland <harry.wentland@amd=
.com> wrote:
>
>
>
> On 2025-10-14 17:38, Mario Limonciello wrote:
> >
> >
> > On 10/14/2025 4:27 PM, Alex Deucher wrote:
> >> On Tue, Oct 14, 2025 at 3:46=E2=80=AFPM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>> [Why]
> >>> If userspace hasn't frozen user processes (like systemd does with
> >>> user.slice) then an aborted hibernate could give control back to
> >>> userspace before display hardware is resumed.  IoW an atomic commit c=
ould
> >>> be done while the hardware is in D3, which could hang a system.
> >>
> >> Is there any way to prevent this altogether?
> >
> > The obvious way is that userspace should be freezing user processes. Th=
at's what systemd does.
> >
> >> This seems like a recipe
> >> for trouble for any driver.
> >
> > If we want to uplevel this kind of check I think we would need some hel=
per to report hardware status into drm and drm would have to call that.
> >
> > Most distros use systemd, and this only happened in an aborted hibernat=
e.  I guess I'd like to see how much this warning actually comes up before =
deciding if all that plumbing is worth it.
>
> I was briefly thinking about a generic solution as well and don't
> think it's worth it at this point. This is mostly about internal
> driver/HW state.

Allowing userspace to be running while the kernel is either entering
or exiting suspend or hibernation is a recipe for problems.  It seems
to me that the kernel should stop userspace before it tries to do any
of this and only restores it when everything has resumed.  Having
userspace stop itself seems broken by design.  Applications can
allocate memory or call IOCTLs into any driver which may not be
functional at that point in time, or depending on the timing, the
user's state is lost because they did something to it after the kernel
already created the hibernation image.  Fixes like this seem like
playing wack-a-mole.  It might be the GPU driver today, but it might
be a usb driver tomorrow.

Alex

>
> Harry
>
> >>
> >> Alex
> >>
> >>>
> >>> [How]
> >>> Add a check whether the IP block hardware is ready to the atomic chec=
k
> >>> handler and return a failure. Userspace shouldn't do an atomic commit=
 if
> >>> the atomic check fails.
> >>>
> >>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> ---
> >>> Cc: Harry Wentland <harry.wentland@amd.com>
> >>> v2:
> >>>   * Return -EBUSY instead (Harry)
> >>> ---
> >>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> index 6446ec6c21d4..f5cd9982af99 100644
> >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm=
_device *dev,
> >>>
> >>>          trace_amdgpu_dm_atomic_check_begin(state);
> >>>
> >>> +       if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLO=
CK_TYPE_DCE)))) {
> >>> +               ret =3D -EBUSY;
> >>> +               goto fail;
> >>> +       }
> >>> +
> >>>          ret =3D drm_atomic_helper_check_modeset(dev, state);
> >>>          if (ret) {
> >>>                  drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset=
() failed\n");
> >>> --
> >>> 2.49.0
> >>>
> >
>
