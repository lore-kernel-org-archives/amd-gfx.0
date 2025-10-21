Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834DECCD1AA
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 12:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B7710E0A3;
	Tue, 21 Oct 2025 12:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRDaDCZZ";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFD910E5E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 12:53:01 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-28d18e933a9so8876265ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761051181; x=1761655981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGQMyhu3zhwFGAWDrdD4mDWv642MZrVNiqyC8vCIyYU=;
 b=bRDaDCZZrWr/ULZ2ttRcKxQy3TkC7eC69pcachZz0TaUCZMMCMBzT1S5AC+DlDXl26
 b3o22WFfNuHPHgzwhMbwSCag1L6ViKg8ZkFKTtQVK4UxUFckB9qKcwedPJHghjytxnAA
 YWh9WaJi++9iMSLjE1Q4m7j+VqDYk/pxEHS+uFdjm5cjDjsjCT1N6v4qOFmqLdQhCQ9Y
 pD7H81VZIOoWznUMcFyhbXkC89HoVLkOTdn4NVcPIAjWnqStczacnZADeK/5gsMo8xqW
 grFYTVV7V7oD7hH3NK/bv0jkfdLX6QxYUh1KCAXsqDSrbWxm3IKJc+UuzjW8xaC3EsvW
 qHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761051181; x=1761655981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGQMyhu3zhwFGAWDrdD4mDWv642MZrVNiqyC8vCIyYU=;
 b=mUXatX1J2fD5jHPSUlVLgTwIA4+OPkvcET2MjJCAQ1+K0V3jfYDZ/G5ULbtifoROIO
 GngJf+AMhoUh0U/Fuy5QEDSvSc1uAevso2bVJ3Gtasjb4l8gYc53x0h3ujLbSHfr4bp6
 BywiXGfODDFTUd8yM8Y40C5IZ5Ov93PYIWzsKDXzcH5QXQbsrlqt8zn95H29AlX5pi8o
 YVTPrQW4JJqVEhOzk8AzfKeG5jSQ6cs4UuG2bt3OBZRF2NOOp425c/XEhnz2OR03tOM1
 3cyDoxzEZve0uIFPdtkCgfBaoPcSbwxTrX0gC/fsBN+r9Q2Fzvm2z6H2UQP5oZ5/ZSxK
 MAlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPsStIQwwqkPftTHz6LxH94IeGScVRg7xpPzXhtRBi6UNYtGYGIh00kqPy/GwA3051fqwtT6P6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwG4yhb1QoiV+D9OEa1eV+QfPHsesRc/u3MBWfI32rwHuTkDw7/
 5VahCTSybsPkqtlITrW3xbjn2R+p4jwOLvhCmxwLK80ujPSTNhXUBI0YxpTymmabMKwOPAzv+Cn
 Ti8zcXmuxFpYL8YyPwIcsNhC1rGYq8Dc=
X-Gm-Gg: ASbGncs4OF1rKOvdCYoizkpJZQeMgp3Ub+GJRl8/GDHGOKdWyog5FtZQtFxihkrrwMM
 /NPUaB+OhFxyy7TEItRccvuj+4Yl9Eub/oba1Qud0V52OqeeQvqIqMJvRRtMQSuilsOR0hNN7Wz
 MQX4Azb0SUdwh6lIktWtrn82AZxm+twU92IJR1rOOOiIkxjeskM0aIjhPsRV05ZDCD82wPtAePR
 GIFj87Q4g04VbeKN7m73UxPvX2DplwD01dljxIucHjbkpayI8NolcwXQ9eZYssoaR3qjUk=
X-Google-Smtp-Source: AGHT+IFGs29/LspZmBDajH3ksvGZPBHTBMyINIzXyVspGncGapGpioD7vKLj7Am5xYUz6EhNUrUfTMnZuk1T6ShxjE4=
X-Received: by 2002:a17:903:120b:b0:28e:aacb:e6f7 with SMTP id
 d9443c01a7336-292d3e61e60mr21224085ad.3.1761051180656; Tue, 21 Oct 2025
 05:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
In-Reply-To: <20251020194631.102260-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Oct 2025 08:52:46 -0400
X-Gm-Features: AS18NWAs3Vyrs8AULavdXerC95sfOUQJGMDAOsQN2z6VvQZdWSqcVxS1CJaR7Ro
Message-ID: <CADnq5_OYtHXbB4VY4iLFKps+miFEqjgqQzng-oVOnMYNUj8zug@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Expand kernel-doc with more generic details and
 info about ring buffers
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Mon, Oct 20, 2025 at 3:47=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> Lately, I have been part of multiple discussions around GPU recovery and
> other concepts associated with GFX/Compute. Most of the debate is spread
> around GitLab issues, emails, and some meeting conversations. This
> patchset aims to consolidate all that information into a single
> kernel-doc, which can be collaboratively improved and shared with other
> people.
>
> In this series, you will find new amdgpu glossary entries, more details
> about the IPs' interconnections, and a description of the ring buffer.
> This series includes multiple SVG diagrams; for this reason, it might be
> good to apply this series locally. However, if you want to check all the
> images quickly, check the links below:
>
> - https://people.igalia.com/siqueira/kernel-doc-imgs/v3/amd_overview_bloc=
k.svg

Looks good.  For completeness, maybe add a path from PSP to the UMC on
the right side?
Also, I'm not sure it matters for the sake of the drawing, but the
memory hubs are not really part of the IPs per se.  For example, on
navi and newer, GC and SDMA are both attached to GCHUB.  On pre-Navi,
SDMA goes through MMHUB.  VCN, JPEG, and VPE go through MMHUB.  DCN
goes through DCHUB.

> - https://people.igalia.com/siqueira/kernel-doc-imgs/v3/gfx_pipeline_seq.=
svg
> - https://people.igalia.com/siqueira/kernel-doc-imgs/v3/no_enforce_isolat=
ion.svg
> - https://people.igalia.com/siqueira/kernel-doc-imgs/v3/enforce_isolation=
.svg
> - https://people.igalia.com/siqueira/kernel-doc-imgs/v3/ring_buffers.svg

These look good.

Thanks!

>
> Finally, keep in mind that I tried to fill in some gaps between
> information, and hopefully, my description matches the reality.
>
> Changes since V2:
>  - Remove the unnecessary diagram.
>  - Remove the excessive details about hardware behavior that are not
>    useful for a driver developer.
>  - Remove some wrong information.
>  - Rewrite many parts of the ring buffer description.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> Thanks
>
> Rodrigo Siqueira (5):
>   drm/amdgpu: Expand kernel-doc in amdgpu_ring
>   Documentation/gpu: Add new glossary entries from UMR
>   Documentation/gpu: Expand generic block information
>   Documentation/gpu: Add more information about GC
>   Documentation/gpu: Add documentation about ring buffer
>
>  .../gpu/amdgpu/amd_overview_block.svg         |  674 +++++++
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   24 +
>  Documentation/gpu/amdgpu/driver-core.rst      |   25 +
>  .../gpu/amdgpu/enforce_isolation.svg          |  654 +++++++
>  Documentation/gpu/amdgpu/gc/index.rst         |   24 +-
>  Documentation/gpu/amdgpu/gfx_pipeline_seq.svg |  413 +++++
>  Documentation/gpu/amdgpu/index.rst            |    1 +
>  .../gpu/amdgpu/no_enforce_isolation.svg       |  707 +++++++
>  Documentation/gpu/amdgpu/ring-buffer.rst      |   91 +
>  Documentation/gpu/amdgpu/ring_buffers.svg     | 1633 +++++++++++++++++
>  Documentation/gpu/amdgpu/userq.rst            |    2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   15 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    2 +
>  13 files changed, 4251 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
>  create mode 100644 Documentation/gpu/amdgpu/enforce_isolation.svg
>  create mode 100644 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
>  create mode 100644 Documentation/gpu/amdgpu/no_enforce_isolation.svg
>  create mode 100644 Documentation/gpu/amdgpu/ring-buffer.rst
>  create mode 100644 Documentation/gpu/amdgpu/ring_buffers.svg
>
> --
> 2.51.0
>
