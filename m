Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF51C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 20:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DBC310E0FB;
	Wed, 15 Jan 2025 20:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JOk9ZxGP";
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD9710E0FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 20:27:13 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2162f968cd7so206455ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736972833; x=1737577633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1ThH2Z3QkfYpRXR8SnLP75ysoopcMSk42tpNp+gIqM=;
 b=JOk9ZxGPUJ5Uuuc1CkHCsOcpTbNbisO7DJpRcp8MSJxksXLnckdbmHed04ey0X/3fz
 E3qFSEejA85vKEGA5n9GjTVoGgiKHx0TMWlGJO6gxjduEdGnAvAq2gYORIIm0RZe4me1
 fVLjgADh2VbvJXimvTak2vru+hDLR/lTkH4AePr4RbENUJCDCj/XdQINdseHLJWUNhUP
 XTifj4RpGtx6GFtNlgJMWYCD0f1TJRxEqToAGyCJqwoj+Dl4dqjsbqVJmfaXVZqrVMTo
 tJN+UgOoTkiuMsvQEClJAvEt4QOKP9rA/bre2OUEPULxSqgiIsZTPy79a3q3Mdp+znNJ
 ft3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736972833; x=1737577633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1ThH2Z3QkfYpRXR8SnLP75ysoopcMSk42tpNp+gIqM=;
 b=Um5yQ0HJ3MyhCvEm2HTR22+NLKqLBg1/eYgvmNDc5i2mVTDAUk8ZVD8oiqjNMrxy/s
 s2FF5VUs8NSBPhURX+N37xZSnitWc2SzNAWq2rjJqVe+A3heFEAGkgN7c+WRAfqca2g5
 4b3rUOX1tjc9vQ2TLZUPDoN7UmJKvDDnySjYcojS79TogVy0EuG6WZ8CGK+AYimrZaaR
 +6KeYfBYibMWfSkV1QbhHfwK2XbBJKsFA/OzwIUUr0kx4r2AD5NKo7I+MeWVt5M/DfmE
 rl5Yklt7XixTMYrisWqtAnfXuQitmkMUkuUgLJmJOQaTHh+q4cBN6pb6kayXbRz5KLc/
 arQw==
X-Gm-Message-State: AOJu0Yy7EszrYJE3tN7XXvhGbiVWN0Mckww9wZdn1EHEy8vhfwoS5dNI
 G3tkMBvNyTAy2r1rvCZUWcT+baSPnUOIqdUNGot9UV1RByABc2c6rZM0IP3CIMYITohws/6R9KC
 vvI62OZQ7MJyTDQDKXei0QQ4qnXwekA==
X-Gm-Gg: ASbGncv+0C4rg0Yffq1SKFysuH+RyRIaAso/pSifeu5lsU/8FZNVEdvoiPgLjYQleiB
 QCsP4m4P90xbLK60aMC2cq+cLo4hKCneCjHF/Ig==
X-Google-Smtp-Source: AGHT+IGNAK/Tbyvu7T7Bzaz2VpNIcQ1bXxZzSkuG6qFCaiWvxfHqT8h+otCiMWrEwgzm3agZ8JBNtvS0T9Ty9JLNwZs=
X-Received: by 2002:a17:903:32ce:b0:216:30f9:93c5 with SMTP id
 d9443c01a7336-21a83f4c434mr173665875ad.6.1736972832577; Wed, 15 Jan 2025
 12:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de> <20250115211039.09e6e69e@zbook>
In-Reply-To: <20250115211039.09e6e69e@zbook>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2025 15:27:00 -0500
X-Gm-Features: AbW1kvZ5zJiVH-zWf-OzUPYtMfwHxgy4iotAbYapd7BBj7wHhmkR-dVHf925ZXs
Message-ID: <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
To: Marco Moock <mm@dorfdsl.de>
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

On Wed, Jan 15, 2025 at 3:22=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wrote:
>
> Am Wed, 15 Jan 2025 16:08:34 +0100
> schrieb Marco Moock <mm@dorfdsl.de>:
>
> > I assume it was 6.12.6, but Debian doesn't have the old packages
> > anymore and it has been purged from my system already.
>
> I've now tried 6.12.6, same situation.
>
> Any further ideas what could cause this?

Can you provide more details about what you are seeing?  What does `ps
aux` or `top` show as using all of the CPU time?

Alex
