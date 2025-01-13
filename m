Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C640C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 20:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D650810E26B;
	Mon, 13 Jan 2025 20:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EJ7dPa49";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE73B10E26B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 20:12:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 29F375C57B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 20:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A572BC4CEE8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736799169;
 bh=VO71TFfgjbrSIr+nIvPjvtiNtN2bS1Ejb31IvQuMFAE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EJ7dPa49b1O9B8dg8wg+GUJLNOMr3Mq41AUFMX0KJzwGuf0+MdelqsQChhgIh3cgI
 eBLI3iIL1FCdKLSFxZi2YEk05pduXPCM5azvGQuApTIVzJAmFOcz0ru+EID/akFR8w
 KqvyGWnJsEjBuenI5YK54XUXVs6UlMoHEl6lgh9zlZGyfxxZzGDaoaT1GmN7wWjtnZ
 fGhfJl9QiwGhyk8FU1fC9NDVRpRJPr+wj8K9RZIJZ/GGgLe12K9AJKWPPScFIpDtHo
 CGPBehOWZBoFvML3dFpXMHF5CEY6ofuTZrDCpUJitsrXl8UBc+YJnRP/+X5uDrNSmr
 S98h7WNC8++jQ==
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-3eba50d6da7so1166091b6e.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 12:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXHfuBxDnVZP+cKTHm9zEm03kNAfST/4RwtHFHDgTC0e6JVDMy/c8yDk/e2YuxugSIoQxkLmsCT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE5szyUQDyizRi/+3JsQdWCTTbLqWiqVHJEdtC+ZG59tGx1klo
 221AIetYKM41oDqB0VkWceNZuYgMZ+JFGQCE9tGJONoRd+3NBZ7ry+2DGp+0J5G9uw0XNR0ofwZ
 VywnkLW2VyD+cnMPFVD9IWhMRbqQ=
X-Google-Smtp-Source: AGHT+IFDg16HTytPYaVRyH/8xx6u66EXlnnAVIt9DAQCoXWFaXHoTaenWY5JbLpFyrCHF6H+M9XGT/5CBd32kBtLvSA=
X-Received: by 2002:a05:6808:14c3:b0:3eb:4137:53bb with SMTP id
 5614622812f47-3ef2ed64538mr15530049b6e.31.1736799168905; Mon, 13 Jan 2025
 12:12:48 -0800 (PST)
MIME-Version: 1.0
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
 <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
 <Z4K_oQL7eA9Owkbs@debian.local> <c6e622b2-64e4-41cf-acfb-31ae493571d2@amd.com>
 <ed72f369-bc74-44d8-9cce-34aa125176fa@amd.com>
In-Reply-To: <ed72f369-bc74-44d8-9cce-34aa125176fa@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jan 2025 21:12:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gwS72w6byCpRqRmzJO_u_fK_f9cmRZiEyd5Dj4N+FTvg@mail.gmail.com>
X-Gm-Features: AbW1kvZxA99UjPRblh6jzrEs3eL3h3OldUrIIIJvmVyRjY0jVsu8_oUgWNLXqlQ
Message-ID: <CAJZ5v0gwS72w6byCpRqRmzJO_u_fK_f9cmRZiEyd5Dj4N+FTvg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
To: Mario Limonciello <mario.limonciello@amd.com>, 
 Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, 
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com, regressions@lists.linux.dev, 
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>, Borislav Petkov <bp@alien8.de>
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

On Mon, Jan 13, 2025 at 4:59=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 1/13/2025 08:19, Mario Limonciello wrote:
> > On 1/11/2025 12:59, Chris Bainbridge wrote:
> >> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> >> available for eDP") added function dm_helpers_probe_acpi_edid, which
> >> fetches the EDID from the BIOS by calling acpi_video_get_edid.
> >> acpi_video_get_edid returns a pointer to the EDID, but this pointer do=
es
> >> not originate from kmalloc - it is actually the internal "pointer" fie=
ld
> >> from an acpi_buffer struct (which did come from kmalloc).
> >> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> >> resulting in memory corruption which leads to random, intermittent
> >> crashes (e.g. 4% of boots will fail with some Oops).
> >>
> >> Fix this by allocating a new array (which can be safely freed) for the
> >> EDID data, and correctly freeing the acpi_buffer pointer.
> >>
> >> The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
> >> remove the extraneous kmemdup here as the EDID data is now copied in
> >> acpi_video_device_EDID.
> >>
> >> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> >> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> >> available for eDP")
> >
> > Two minor documentation related comments to consider, otherwise I think
> > the code change looks good.  Feel free to include:
> >
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> A few more tags to collate from another thread:
>
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Closes:
> https://lore.kernel.org/amd-gfx/20250110175252.GBZ4FedNKqmBRaY4T3@fat_cra=
te.local/T/#m324a23eb4c4c32fa7e89e31f8ba96c781e496fb1
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Applied as a fix for 6.13, thanks everyone!
