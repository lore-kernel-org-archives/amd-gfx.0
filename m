Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06821C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 19:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9D410EC68;
	Fri, 11 Apr 2025 19:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HvlFnR6J";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D99110EC68
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 19:01:11 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-3f6dccdcadaso1428572b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744398070; x=1745002870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xC6PacJPpRGYWGqR4nOqLKVqgGUbFrNiAZhii7ts20=;
 b=HvlFnR6JQUTFbRDPxEkQS99i6e+DlsrGNB1ygbUgBBEDvwNN+NUlG0K4eeEQzkat/Y
 eoaJTeC1mNi5IQEl6NlO4sEfVh6osZP2/iUEZ2diTGzSfmxsabilCqSdGdoYmf13ugXU
 0Szf73RWfCC5keUF8DLm0mij011t+K4c9Qd9m4MANNqDYaFeN0rZiDHuw4vEmvcXWSx/
 4G6b0dsMKM4tAqKfjfFGkVedVrEoz4dLnDvubiIVVFQgilEMhKZsBrbpVZAhrMjDeLpG
 bpyiR2wKxPbAZwPglgj9jfuKzOhBQZHBpLlBsfIyDy95zveQIossBK2WlFwUsOa2REB/
 ykPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744398070; x=1745002870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xC6PacJPpRGYWGqR4nOqLKVqgGUbFrNiAZhii7ts20=;
 b=O1KeIp+U5UU/ZbRlX6RBlRopfovWrp5lsCvcnOIhYHOhNjKgk35o4/FUeCKKW1bj5A
 Jc7y9/YOUWclIla03C0DZnKeBSK8oQqPFkostKX7H9XoBEqzsCPckAOqdMnEmFxn7Ysd
 AtjWmw7C0PP7cxTM8mTI4mwl0vhVE9pSbvgm+rJbhN+jPaYquxfDMe0+W05WMisLxtR6
 M95g8hl+qNod/1bRRyeAC1tCtmq5MuR9bn52pck7qmSV3jhU4wXLOIfzetG1o8czOKu7
 sef0WSm/iS4kUOnDRyl2Ocicu+aI4Szcahq68hELJf6sxTbgBZ2AOuBd0NKzIp8UQLl8
 hEdQ==
X-Gm-Message-State: AOJu0YzmuOZSYM3MeELzhPVioIyB1dLN2xUZTHTyDj3HLlMixRrryH3E
 i3n9FfP5MFfB2Qh3dfoDUrIZ2fbx0dr4b3h65izkc4XtyJywSnoNTaYo/5jJ4knSKNBjz3X5hvn
 ZFF1zCHQt/TdSsX9mmhvWjdhxJ4pvqA==
X-Gm-Gg: ASbGnct9QjtqpCa9SxnytfMrBcO1SJ5T3mblBXu968tvFqgA1rk/GhHYtYlcIp9BbPS
 mF/Oj3GjyxOXwKxLGy3+b/4iQ8dHbbuGd2kuVYtEcJeyhfN+dAj9fUyfCTqNlTN11AXem2Q5MWY
 eQLyzIT1FeHTQWvyHbv9l7Eg==
X-Google-Smtp-Source: AGHT+IGH83bzgKQpBwfkHYeMftBqWBxYffXYwViyjLpTaSj+eUQDfEh+r+9JlpC4uGamQPu0oJrPdINF6FLwDuyq9u4=
X-Received: by 2002:a05:6808:3849:b0:3fe:f41d:463a with SMTP id
 5614622812f47-4008503da73mr2551248b6e.10.1744398070402; Fri, 11 Apr 2025
 12:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Fri, 11 Apr 2025 15:00:59 -0400
X-Gm-Features: ATxdqUFmxQGbaxdC9-xrDaG7zTsG3jYON78eMu7viLQU8VmF2gY8tvOMhpaPgAw
Message-ID: <CAPEhTTEnJO0wLvuHG=mJb2_kgr=guPY4Wetd1Z-c2nhYFTp=sA@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/amdgpu and drm/radeon: a slew of small fixes
To: amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
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

I should get used to add Alex Deucher's email in CC.

On Mon, Apr 7, 2025 at 10:11=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> This series goes from fixing typos in amdgpu and radeon to renaming funct=
ions
> in DCE11.0 so it follows the convention of using a DCE/DCN version prefix=
 for
> naming functions.
>
> Alexandre Demers (6):
>   drm/amdgpu: rename function to follow naming convention in dce110
>   drm/amdgpu: add missing parameter name in dce110_clk_src_construct()
>     declaration
>   drm/amdgpu: fix typo in atombios.h
>   drm/radeon: fix typo in atombios.h
>   drm/amdgpu: fix duplicated value setting in
>     dce100_resource_construct()
>   drm/amdgpu: fix typo in bios_parser.c
>
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c         | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h     | 2 +-
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 8 ++++----
>  .../drm/amd/display/dc/resource/dce100/dce100_resource.c  | 2 +-
>  drivers/gpu/drm/amd/include/atombios.h                    | 2 +-
>  drivers/gpu/drm/radeon/atombios.h                         | 5 ++---
>  6 files changed, 11 insertions(+), 12 deletions(-)
>
> --
> 2.49.0
>
