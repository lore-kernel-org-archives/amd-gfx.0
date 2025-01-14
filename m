Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4784CC02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 14:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E666F10E36E;
	Tue, 14 Jan 2025 14:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bj1Cd5VT";
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE4A10E36D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 14:44:50 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216406238f9so12007055ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736865890; x=1737470690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Afv5PLes9Tw7xeo9cn54rzemWNInp3rceLMpSQBw3Jw=;
 b=bj1Cd5VTK7y7oSgW1O4RBm0aqQJ5sk3tfk9kx3TSKA3LuQD4RKniwRKKqgV/tYEyMv
 JdsEOvXYMz28uAl5ot3pXXBgfYLhP/OxBfrhZrQQ37ghTyoYlPQD2OJxNfUy1qcutmbG
 ayZcSiTaaKm01f/Q2fKaTInvpkXO5y1l+BLWEQwWoLI2Up/3ypRlFLAZig93XcfQ4J5x
 JOby4aEUlR9hKhcCRy1Z4PGRuSjn54usM/dQJSP8/hyzxl91i3Up8Zq9S0HSPXg4RI+6
 4fTpahR1fsIqbk3Co4Nqurv+w9Sf4BnI+BH0aHt1HkzHS0G0xxbpSeLULvP5xzeuHz7c
 xLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736865890; x=1737470690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Afv5PLes9Tw7xeo9cn54rzemWNInp3rceLMpSQBw3Jw=;
 b=HDtte32yKuOUB0JWoDWiupyBFIEEoZhWMt3eurXOjfkR5b/qPsrTzz7IDMK8Z+q8Hl
 6uTor8/d8yChKGvTEKuzeIfG41ZqKoZApV9ES92QwzTR9wlTlaljEFyd2OR/qzrqzYga
 7GXxX72MXV3ka+4G3NM8YpobhJi8aKdQuX0ndVWochBNL9l0kY3rRz2RvNdfb5v1lcxo
 nSDasQ+gw45WBVkbzBjTXCJF/dCMakKx8OsbVZIveKM/eYL8qO9MTmMeserMezXdzXyA
 vuvQudFs9bLHPFuw2SzQ5qr6hUipVf0ZsI+tbxVbfIL6T3pGhdRTYcvODER/J0iLBZ/c
 mLsA==
X-Gm-Message-State: AOJu0YwHyo2WFEWQC8pgoRrlwhmRdjdF9qOOWkI4tJlwIFIcgKJ9Wt1l
 CUynXpfVdn3SRrihmHY+g8KIr7/3NeU+r6Q1JfqniUHYrdRBSeOUK6bZTtUwcxTNEv7OzyHY5xA
 qLj8PQknSfBQNJkzOJcNnnhabZKE=
X-Gm-Gg: ASbGncu4BGT3fjhEX0iq+wYiDQG7Q+ankOzP2EgnpOOymGLxCqgeSi6dm9ljIMU7ucU
 VJqr982UBVc0eFQFlg33mMNcb+YbQfCVIyt8jfw==
X-Google-Smtp-Source: AGHT+IECltCyOqeUuOKIJRY+QJBQ8hlfeHh2JkXgruWe2K1vnee8HF8B2FBCLxRRnl4MBJ2Nx3VuwsW3kJRXvX97zDE=
X-Received: by 2002:a17:902:f548:b0:215:98e7:995 with SMTP id
 d9443c01a7336-21a83facbedmr148406385ad.12.1736865890002; Tue, 14 Jan 2025
 06:44:50 -0800 (PST)
MIME-Version: 1.0
References: <o93Aruut7VI05oqVX7Se1udr5FAyqfyP_TGDutW0p2fXBSkRv7QkhpLmAT-buTpdWIwn8PnC8B2DNSMtaTp5kk00ZtK653PDLuK14uoUI4k=@protonmail.com>
In-Reply-To: <o93Aruut7VI05oqVX7Se1udr5FAyqfyP_TGDutW0p2fXBSkRv7QkhpLmAT-buTpdWIwn8PnC8B2DNSMtaTp5kk00ZtK653PDLuK14uoUI4k=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2025 09:44:38 -0500
X-Gm-Features: AbW1kvZObw3AE2cLDTrf4-lFGWXxlYmurlEMBXOrdz5g9LlK3A8StlgaWj2zdAg
Message-ID: <CADnq5_PatAYdyKGVJpX5TrVJ451Ga9PJjCx85jna+CUxsaFAhA@mail.gmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
To: SyntheticBird <syntheticbirdxmr@protonmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Tue, Jan 14, 2025 at 9:05=E2=80=AFAM SyntheticBird
<syntheticbirdxmr@protonmail.com> wrote:
>
> Hello and happy new year to all members of this list.
>
> I know that mailing lists aren't meant for begging for support, but after=
 discussing this in another distribution channel, it seems to me like it is=
 the only way for me and other users to grab the attention of a maintainer.
>
> Since 6.12.1, several users have reported a kernel freeze issue with AMDG=
PU, including a complete stack trace. It corresponds to the following issue=
s on GitLab:
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/3787https://gitlab.freede=
sktop.org/drm/amd/-/issues/3866
>
> I also suspect this issue may have happened to one user on the Level1Tech=
 forum: https://forum.level1techs.com/t/help-with-troubleshooting-freezing-=
with-linux-kernel-6-12-on-arch/221340/22
>
> Two months have passed since the first report of this bug, and no one in =
either of the two issues has ever reached out to us. I've checked the maili=
ng list archive, and it seems like no maintainer has ever discussed it. We'=
re simply left alone with only hope.
>
> I perfectly understand that maintainers are busy, and I do not blame them=
, but we as users and owners of AMDGPU have no other choice but to try reac=
hing out to you, to at least be sure that this issue hasn't been ignored in=
 the depths of the GitLab issue list.
>
> This issue is impacting versions 6.12.1 to the latest 6.13 rc. Several us=
ers are still stuck on either 6.6 LTS or 6.11.9-10. For users relying on fe=
atures that have been introduced between 6.6 and 6.12, they cannot downgrad=
e to 6.6 and also cannot upgrade to 6.12, leaving them without vulnerabilit=
ies being patched on mainline and LTS.

Per my comments on the bug report, did you also update mesa or GPU
firmware?  If so, can you narrow down if any of those other components
had an impact?  Alternatively, can you bisect the kernel?  If you have
known good and bad kernels, it would be really helpful if you could
bisect to identify what commit caused the regression for you.

Alex
