Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B515FE77198
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 18:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6088110E1A4;
	Tue,  7 Jan 2025 18:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wi6O8IlN";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4525610E1A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 18:06:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6B309A41B39
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 18:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE227C4CEE5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736273205;
 bh=qH3iaPc3xYhUIjEj3FoNIbTteiXJFoRC28nJ8gnXI1c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Wi6O8IlNYQeCFyJktjQZVYtTtJxXTTxBB3LXil5RqleDoI72sHzpKceDQfDTHIDnf
 0mMAzT6ndgjSBRxkKMLWU+8DTiivsF+sFGcItW8aSd2MpIfgv0eYtqOJ+XoumSCPSV
 UYWQb4lDIGOpfhxJl+tCNNGgR1GbLBXk6b6B/16biLFmfHYkp75im+q05Alibb1bk5
 xmbj0lf1iFP54QI3ado2fjm5mZxCsVoD+0MBBKDBXDIKQVMeJVkQOlUFbzQ6RA9Iij
 5xl58bYrqzI0V1HgjTWBmiFR2BGpufg5ahZ1kPidvwG9oa3+xxTmEJDBgjxGRK8IWh
 oLcsf+O9Cd0NQ==
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-29f87f1152cso7548791fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2025 10:06:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWAbedQrtvufAe0/iHW3QY26+B5tMBG5KW/mwVfPQI/fALIoC1AC+3e6tob1R3BnhDvX5TyIeZf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCeJsV/5Evq88EApnLfEbGYU8rDFmsqa4ZiEQnTcS/zSx1pYNf
 X3TCRF9PYnqlc7O9+nmuvC4AUFvnJGylgzBJnmt3h6/nkWZBd5J+vB/knNslx0eh2nPJPi+94ws
 cx97YSxj/gKZiSQ0Uv7mc5zXzjdw=
X-Google-Smtp-Source: AGHT+IG1NHJhEJz1E0ET76oxQrww1eXON879XyPLOolOWfKwB31uUDyaOy8XXeIOxtzd5NgCo8HnCddLN+jryBZWSsw=
X-Received: by 2002:a05:6871:5e10:b0:29e:32f2:cd4d with SMTP id
 586e51a60fabf-2a7fafda73fmr35789737fac.2.1736273204981; Tue, 07 Jan 2025
 10:06:44 -0800 (PST)
MIME-Version: 1.0
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
In-Reply-To: <Z2yw_eJwR5ih1Npr@debian.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 19:06:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
X-Gm-Features: AbW1kvbSjSNE-bEgLl-tfpxMU20u1L2jkdssynIbWEcaoblc3eEMeR8l-j1XXf0
Message-ID: <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 alex.hung@amd.com, regressions@lists.linux.dev, lenb@kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>
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

CC Hans who's been dealing with the acpi_video code for some time.

On Thu, Dec 26, 2024 at 2:27=E2=80=AFAM Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> On Thu, Dec 26, 2024 at 12:19:02AM +0100, Tobias Jakobi wrote:
> > Hi Chris!
> >
> > On 12/26/24 00:09, Chris Bainbridge wrote:
> >
> > > Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> > > available for eDP") added function dm_helpers_probe_acpi_edid, which
> > > fetches the EDID from the BIOS by calling acpi_video_get_edid.
> > > acpi_video_get_edid returns a pointer to the EDID, but this pointer d=
oes
> > > not originate from kmalloc - it is actually the internal "pointer" fi=
eld
> > > from an acpi_buffer struct (which did come from kmalloc).
> > > dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> > > resulting in memory corruption which leads to random, intermittent
> > > crashes (e.g. 4% of boots will fail with some Oops).
> > >
> > > Fix this by allocating a new array (which can be safely freed) for th=
e
> > > EDID data in acpi_video_get_edid, and correctly freeing the acpi_buff=
er.
> >
> > Hmm, maybe I'm missing something here. But shouldn't it suffice to just
> > remove the kfree call in dm_helpers_probe_acpi_edid()?
>
> Yes, that would work to fix the bad kfree, but there would be a small
> memory leak of the acpi_buffer struct. It's not a huge problem since
> this code is rarely run, and the Nouveau code has never tried to free
> the edid buffer and apparently nobody noticed, but it would be better to
> do the correct thing.
>
> One other curiosity is this comment in the code that allocates the
> memory:
>
> case ACPI_ALLOCATE_BUFFER:
>         /*
>          * Allocate a new buffer. We directectly call acpi_os_allocate he=
re to
>          * purposefully bypass the (optionally enabled) internal allocati=
on
>          * tracking mechanism since we only want to track internal
>          * allocations. Note: The caller should use acpi_os_free to free =
this
>          * buffer created via ACPI_ALLOCATE_BUFFER.
>          */
>
> Which makes me wonder if all the calls to kfree on acpi_buffer structs
> with ACPI_ALLOCATE_BUFFER in acpi_video.c should actually be calls to
> acpi_os_free instead? I used kfree just for consistency with the
> existing code.

In Linux, acpi_os_free() is a wrapper around kfree(), so it doesn't
matter in practice which one is used, although in principle you are
right.

So Hans points out that you should check the kmemdup() return value
against NULL because returning a nonzero length along with a NULL
buffer pointer is confusing at best.

But if you want to kmemdup() the buffer, it is better to additionally
check if the length of it really equals to the 'length' value.

And I would put the entire buffer management into
acpi_video_device_EDID() including the kmemdup() and make it return
the actual length of the buffer on success.
