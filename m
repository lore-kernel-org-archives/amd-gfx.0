Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28429C369A2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 15:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2ED310E4CC;
	Mon,  7 Apr 2025 15:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dsXEHU4H";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF38D10E4CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 15:03:40 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-301a8b7398cso618212a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744038217; x=1744643017; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yojZax267NXAe7Fkl9Xv7AYU2Jn49mc8qIt9ACEv9g=;
 b=dsXEHU4HVkDz26PxSvdtCrtAZSd1P1jZQEP5qHSHlEv/eFVB4tOq+CXTeRs/UGZqqW
 rdxfgZ3zZdStWpJxM438htowE3G7+gIJBjsKX+5bOHWCbnHp/EgZnp8omk/wxu9vxIGc
 q5LIuO/RY6vUiXa6JggB34IxYRdUUgBW7GSHjyklKLSCc0/qPFBY7h9kF0zLiwoc/Zf5
 /R0eqkdpuY9HlmgegTtY3AVMzFtXbbgOFPJmzYWeDWAuPvVAwpjNk9DRK+fKYTMk0WPg
 s7LJlYfU1U/GnPXHCtxzBuG+MIZQUlV3GqsYhpA8gJmPEqjb0vSqxK8wbFngI6WEfrUj
 EjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038217; x=1744643017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yojZax267NXAe7Fkl9Xv7AYU2Jn49mc8qIt9ACEv9g=;
 b=N6R5iBZAPxOYTLLY6Gg38FPdorwWfeF883UQeKZfeq7RuZQoEPHpNV8mNncCWunv//
 rScoio3f9N0xcxT8ItXXt2+T/EeO9PYz5jpxqsTbCn1250eLESyvART0Qj3Z8JpIrjtk
 v+dQ4Aw0TD2D5mzDoI6oxMNbHWO0PGpkXtpMODpE3jboplD2TQQN8xbPUawl0XgnnSh1
 A7GzxCQh1iDgYOevG+trh+CbloQ6T5IBggJ54foq8P15ZYxT9ZLqaqSEEC1maLno9INP
 QmOaWc0yvP1PNdhjisaWASlEIWInrpGLZNfC1NUPx4qUiE6oCCTybKY9GTO64bTOcyye
 m+5Q==
X-Gm-Message-State: AOJu0Yzva75AQVYVNgLyADmDxerjo0mxYkuv9IBaxlk1C8TUZjoZEDHk
 EVRQPQcLiaN2B4MDX/t4zHnfalHI98I0ssobFZrRp2MLKLOCCtpsyv1/GhE8tOXqETQp8KW8LCu
 llf+Pbrbc+GvMunQXdOf/tmglZX5a/A==
X-Gm-Gg: ASbGncv4sEAnv4ZOK0s+g1ui/WuEeL0H8GyqlLO2XPAXA4gxy3mgTLYEk833Ky412Z1
 ys7Mdua6QgkJFtXq9A2mv2WvtowF9a8w0v66qHNmCHuGo97v5xKRWADCwWD4UbSVf87R0bdWNSR
 O1W3XUovBeQR7mQ3qgkHziZCAl9w==
X-Google-Smtp-Source: AGHT+IHhc7T+bVQYDUFiJ+tAwIH4MyNHk94SJygF5iwl5X3Oq3g073uGg9YKrojrBGJI4BpWyZ+mLMgpR7U8qVKYK+8=
X-Received: by 2002:a17:90b:3a90:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-306a48301a4mr7062195a91.1.1744038216587; Mon, 07 Apr 2025
 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250404054225.101791-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250404054225.101791-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 11:03:24 -0400
X-Gm-Features: ATxdqUHwWw9E0RP5cAGwlJ51C7HDRIp6v8zFCilBGG7y7KTNOOEVomYiNwt_7R4
Message-ID: <CADnq5_ONjgJWEep79yLf25R09jcO3xmB9SvnGfgGQnijNeoH6A@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amdgpu: better complete DCE6 and GMC6
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Fri, Apr 4, 2025 at 1:43=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> First patch moves some DCE files around so they are distributed as are
> other DCE files
>
> Second patch implements gmc_v6_0_set_clockgating_state(), which was mostl=
y
> there, but commented out. A few tweeks were needed to make it work under
> amdgpu.
>
> Alexandre Demers (2):
>   drm/amd/display/dc: reclassify DCE6 resources and hw sequencer
>   drm/amdgpu: fill in gmc_v6_0_set_clockgating_state()
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 44 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dce60/Makefile |  3 +-
>  drivers/gpu/drm/amd/display/dc/hwss/Makefile  | 24 ++++++----
>  .../dce60/dce60_hwseq.c}                      |  2 +-
>  .../dce60/dce60_hwseq.h}                      |  0
>  .../gpu/drm/amd/display/dc/resource/Makefile  | 24 ++++++----
>  .../dc/{ =3D> resource}/dce60/dce60_resource.c  |  2 +-
>  .../dc/{ =3D> resource}/dce60/dce60_resource.h  |  0
>  8 files changed, 63 insertions(+), 36 deletions(-)
>  rename drivers/gpu/drm/amd/display/dc/{dce60/dce60_hw_sequencer.c =3D> h=
wss/dce60/dce60_hwseq.c} (99%)
>  rename drivers/gpu/drm/amd/display/dc/{dce60/dce60_hw_sequencer.h =3D> h=
wss/dce60/dce60_hwseq.h} (100%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce60/dce60_resou=
rce.c (99%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce60/dce60_resou=
rce.h (100%)
>
> --
> 2.49.0
>
