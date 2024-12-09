Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50A7E7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 17:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCC910E4B6;
	Mon,  9 Dec 2024 17:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fcuPSAnx";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C311D10E4B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 17:00:49 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ee8ecb721dso812346a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Dec 2024 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733763649; x=1734368449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnviIwoZjJSLw4/ASOq/X4mD/qXkB2NxJsaYqkYxRuk=;
 b=fcuPSAnx4UWT+uvnkArPgefk779JfYIhrQRm90NJfeAdLCbAj5umc8s0R6bjohGqov
 +Mhr0hg848IokNLdLJEOkZTthoRH57KSohUW0p83cu3STawbg776ToT8Ewtge8chyYnU
 DeACf+i1dAQqoQSSW7cRi27AI6PJlF4gn3I3qOwLBw3SBJnOWm2ljeLgxKbIPtnYYL0/
 Fn5S0630cN8glCi5T4W7EfYT9fT7DRIKyBXEkwqen07u4OS46ka1P1zzO6cD9MsH5+0u
 3qqwAYmXi9DFwp+PFDeDn51t3FXFpVEZTIu6+B6xptNEtj6g7U8OyC3rscr3EeLG83DM
 +agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733763649; x=1734368449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnviIwoZjJSLw4/ASOq/X4mD/qXkB2NxJsaYqkYxRuk=;
 b=Qca7VPhxg9TIqXhp0Z7yrPCF5R5rAEUVpD5FGxs8P6UOQ/rMjVFV9mjx8coWDXETcs
 guP/e5ePgbud9MysrhIz9DlfeqA8t8pcGfYEbGR9Zn28iSEmqKMv2/e4uR32hpkzlp9l
 bN3ZJ8DlJF5V13FG2qcA4wsaiC1f4go4GOTfvWpPE8Gt4TCc1+mG8dTdtozCsay9cRJL
 Q4L4XNguq0avf04BS0MQ0R+lpYCzyTdS0OGFlOcHqP1Da715fKojJbm/LzOmV8KacjWM
 UW8aIwvj6thfBVYkBk1/wwyiH6OgzDIzygci/53RYC3ntKjI2e/CC0KAO8+WN+XnXWYS
 dZbQ==
X-Gm-Message-State: AOJu0YxeuxJgdaQ3844NyiBH0OHRIwHOz/Z0XkBulSSe1fmINWz+iQXw
 HbtK3XRd9iPcOu3PUwHPRJvi2ZhDx5n2AAVLW3BP7/wre7RYvVIk+CSpJpoVuO2OIDWaYdRjQUw
 C4tWaQ6atiYtMu5bh/QF+gngNgkBHzg==
X-Gm-Gg: ASbGncsShT84kd4dkOFeof3o0k3NqtVynouvVn/SEbi6+2aGeFbAZquHLsld0/jH41n
 CZAb3T8qW2na8IgvpPzblvnAKVdPGZDE=
X-Google-Smtp-Source: AGHT+IHFKabn+Sq2iKS4Pq8Fle4f4sPniKPMAzDQSJkjAvFXsHffsRXboRW8gdeSY5JfcsMR4vrzpDzTPOq96QPVtm8=
X-Received: by 2002:a17:90a:e7cf:b0:2ee:3fa7:ef23 with SMTP id
 98e67ed59e1d1-2efd4a5fe7emr117159a91.8.1733763649198; Mon, 09 Dec 2024
 09:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20241112213716.49355-1-alexander.deucher@amd.com>
In-Reply-To: <20241112213716.49355-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Dec 2024 12:00:37 -0500
Message-ID: <CADnq5_OLnCs6snWFiTwuHwHJL44WC8NjVxz7WSA1wu8CRiOLjA@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] Add panic support for all DCE/DCN
To: Alex Deucher <alexander.deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, yaolu@kylinos.cn, jfalempe@redhat.com
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

+ Harry

Ping on this series.

On Tue, Nov 12, 2024 at 4:37=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This builds on the patches from Lu and Jocelyn to fill in
> panic support for all DCE/DCN variants and code pathes.
>
> v2: refactor to provide cleaner history and share more
> code to provide a more consistent experience across
> DC and non-DC.
>
> v3: resend with the missing first patch
>
> v4: move hubp and mi code into a dc helper function
>
> Alex Deucher (5):
>   drm/amdgpu: add generic display panic helper code
>   drm/amd/display: add clear_tiling hubp callbacks
>   drm/amd/display: add clear_tiling mi callbacks
>   drm/amd/display/dc: add helper for panic updates
>   drm/amd/display: add non-DC drm_panic support
>
> Jocelyn Falempe (1):
>   drm/amd/display: add DC drm_panic support
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 80 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  5 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 27 +++++++
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 27 +++++++
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 27 +++++++
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 26 ++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 ++++++-
>  .../gpu/drm/amd/display/dc/core/dc_surface.c  | 46 +++++++++++
>  drivers/gpu/drm/amd/display/dc/dc_plane.h     |  3 +
>  .../drm/amd/display/dc/dce/dce_mem_input.c    | 34 ++++++--
>  .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 15 ++++
>  .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  2 +
>  .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 15 ++++
>  .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  2 +
>  .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |  1 +
>  .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  1 +
>  .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 17 ++++
>  .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  2 +
>  .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  1 +
>  .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  3 +-
>  .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  1 +
>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 15 +++-
>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 +
>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
>  .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  2 +
>  25 files changed, 377 insertions(+), 8 deletions(-)
>
> --
> 2.47.0
>
