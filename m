Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BED3D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 13:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A342C10E467;
	Mon,  8 Dec 2025 13:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g6KLBh2D";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1B710E455
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 13:55:57 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-bc0d28903c9so333571a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765202156; x=1765806956; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54vNoojfzIXzTKGsgeLwyJPfWRI2E/YXZe/JWv8ns9U=;
 b=g6KLBh2DaMO/yYh5q4lwNPofeNOxLb49jrDok8v8+45l9W3yaGRvti5DAqtUo2Eh+T
 3MIBHN4QchomDfQ2j5digQ8MqWSw+Yh2JWQz8tLcsnwWmKAliLDLL3XuE6pbKgN2BvxK
 SgVIoZXMQbiPwNxHUWqqBzhJo0xFDRjlGrr+8KUCe/MvAjCGmddTnRC8yqrhNckOzM+o
 CjmQCUFTfu7OCZNsrSQfoi2Gwv5Y5RvTWDgpqphSuZ/g30dbklCXpe6b2r0apgLgXMQz
 UZRxfqrVgTV+Xfuv0/UBJC1UdDzI3vY4GfVJ0RIjhdvEwrbXhjnmI1w8WKayoHM+lWj8
 RCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765202156; x=1765806956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=54vNoojfzIXzTKGsgeLwyJPfWRI2E/YXZe/JWv8ns9U=;
 b=AfxjlGNOk4gY2gXrvfa7dnSWfgW8wGSsLGRP86cfkAzxJSzupKESq1sbGH1hoK91La
 1OBY2+SyCBqPMzwLunhhv1wvLb2tnuiC9VmZVOuKtqwYlC192bFsTmwbbGEBuRUBbxKA
 zsSKkJuePQfCeMC5K9D7FPeJCAdB+W052+K+pbWo4MHJ5KH5sa000GXZ0KeZPGVKpUGu
 TgH/vejuF0PD7NYnKdcsMHvV+2BvwhOl88nIq1Usi16EoUFiawJr0G1Rf6QasaUfTKUh
 58zNElD/zWXmA71TIdkLjLy3UXiRvmeM7EhfuCzAFDnplkKMZkgFqgs6ftHMRvu2RGvT
 i5fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5+JBE0jkvZSuDUs1YA3fykNMzqsVEIo3EK1glvnbvJv0hnqgKdRA0KkfoKS6YBsy/tpWOymeA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxETMYcEeU8tmpBQcbyhTTn0BiKRu77fWi6DC0J9zyGbZjcNcLV
 orVkD4bdRiorsl7DiLdMah+0dNdIJeT5SuOh+HXgiDYDxksON+6QWLKsE2c3vVzdQaTtePxPEbL
 /1+cqccUvVWy5zNRmQ5xGRf8QtrYzogeOSA==
X-Gm-Gg: ASbGncsG3yPgpzfFI6odm5eSBIe5hRssEh0vx/v273C6X2QGGmFplccnXBkXuM9p1Fn
 6a35g6kDQJP61YsX0XRKYZ/dGoTvHJNKLNrOM7ylE9G6M+OAf9V00AywMgUge9BklGMq9pIisL4
 EloEhbRuH+jXc28i+jIQmYtHu6OWujuj7/ITeVRUZXq8oTG7jqAHSob7vNi2pjJTv9WPCXVNihm
 SWXo2NORCIEPg9ko9zHZXRGpMaSIcrKvDp3lR67DxOqtk/cIWmpB9Qaa6WoNE6IcgF/xLA=
X-Google-Smtp-Source: AGHT+IEt7xkjDby86sLbsqtLlQeb49knq2VG0f47c9PcagQvTRWeTfTMZDyrLxSfY5OSIiLjiCaiLC11MNgwyAgFeDQ=
X-Received: by 2002:a05:7022:6729:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-11e03160816mr3971131c88.2.1765202156376; Mon, 08 Dec 2025
 05:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20251207194910.122711-1-superm1@kernel.org>
 <CAGwozwFXvHJY_WOZXjBWhoFTt1rcsLX=1n5p49=S2HyF+EvdHQ@mail.gmail.com>
In-Reply-To: <CAGwozwFXvHJY_WOZXjBWhoFTt1rcsLX=1n5p49=S2HyF+EvdHQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 08:55:44 -0500
X-Gm-Features: AQt7F2rWht2ScZk3-NWLDHLC3DNY_SAsbCZKt5xSjEOUvYqEdru1gRIq0Bf-B28
Message-ID: <CADnq5_NUyZYo2arS+eHhRro9HupxcpRZ8mD1RMEHjr7kU5JWXw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Runtime suspend for APUs
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
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

On Mon, Dec 8, 2025 at 3:39=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> On Sun, 7 Dec 2025 at 20:49, Mario Limonciello (AMD) <superm1@kernel.org>=
 wrote:
> >
> > Set up APUs to follow similar policies as dGPUs in that they can
> > potentially runtime suspend.  If an APU is runtime suspended then
> > prepare it for the matching system state (s0ix or s3) so that steps
> > can be skipped when runtime suspended.
> >
> > The thought with this series is that if the compositor has turned
> > off displays and no other work is running an APU's GPU can enter
> > runtime PM. If the system later enters system suspend the GPU steps
> > can be skipped because the GPU is already in the runtime PM state
> > to match the intended system state.
>
> The compositor or a game probably has assets on the GPU. If they are
> frozen, would the amdgpu driver be able to suspend?

Yes.  APUs don't have dedicated VRAM so all assets are in system
memory.  For dGPUs, the assets need to be migrated to system memory if
the low power state results in VRAM getting powered down.  That said,
the assets will be swapped back into VRAM on resume as needed.

Alex

>
> > It's important to note that default runtime PM policy will prevent
> > entering runtime PM when displays are connected. This can be changed
> > by setting amdgpu.runpm=3D-2.
> >
> > This series isn't yet tested, I just share it for feedback on
> > the approach. If anyone wants to test it as well, please feel free.
> >
> > Cc: Antheas Kapenekakis <lkml@antheas.dev>
> >
> > Mario Limonciello (AMD) (1):
> >   drm/amd: Expand runtime suspend to APUs
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 +++++++++++++++--
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
>
