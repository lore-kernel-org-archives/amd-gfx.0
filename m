Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC7C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 17:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D373D10E2D3;
	Mon,  3 Mar 2025 17:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAJdJRby";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D8D10E2D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 17:05:14 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fe9fd5e7f8so1376885a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741021514; x=1741626314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmBbhO+VTz8luJDLd9fE0iBp07aOQfnXgIfnLeDAjDI=;
 b=aAJdJRbybA9tG/8f4Xlm8efiTUwPfCgF9PCSVi0kYMU3Iwfba9YeimLuuisQdu6vsj
 6fgrOa3uAguzUiYn2Fsgo0iusrfE8DdIBad7CYkoO/F6QvCXgXg9Uiyfq7CNzFhzJD50
 VuXCVG5vykP3zAgHculckI7ogfsI7Ic/nSNlVJDEh+sxUsDEZT8uFk/OkBVOMIAP1WHU
 n2yvOgeR4s+acFWoa20/s24cImhQxEeSl2uzHhTt8PAA/b2xcbDKMJ6bCzp2hS0GZEt5
 o7ZUYY1NevXhnn5sAc8XVNPm9XL3j4CwlC5BY6/sLd6zOEn5dn54nb4mtuNtRbi3k7XX
 7JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741021514; x=1741626314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmBbhO+VTz8luJDLd9fE0iBp07aOQfnXgIfnLeDAjDI=;
 b=Jknpa5J4cdYNEWweK2YBJppPXjLHOVHiGnWQgGuwq57gWFkvhyROu2qK80U4rHo0tW
 aH7RYlmaloybE1cvVl5KcZf1hz+2e8jgWQUxhNKWo/dbIrgTksTGbvobZZnyfMKlGAer
 i2z6bGpbyjV/7ahKcpHjCgR+qPv/WuPkW1NnNhgxZoMEIo0jiiP8d9f0Xh/Qg58B16o+
 KOr4maSZx8uoA2S8lzIRXmT26PXVuFEg6eIN5ZGtICRar5pSsgFTq0EPww96nUoko0Pf
 2+V7LLCWrmlWDzuuWAEvGXdYnJBigDPj7IK2J4UJo/i/LalxNBxVUNVEl7+ba+BoSEZt
 vPGg==
X-Gm-Message-State: AOJu0YyP69/qOmd9DKASJkqXTEsfErpR4ED7RMFua/gXcyMQfARzgSW+
 GoswO8Mf4I7f4NvPUYml1Z6jW44BkfP7gjXwrzvjQkoKeB8L+bwz1XBKQxT9UPVELZLn9wp7q83
 22lKBnr4mLeO5t9QmLAx1YEaFHj0=
X-Gm-Gg: ASbGncs8oYc9E8JF4XXCFsCC3CcL7cE9Va52kHIeH7PxkhIhF5jskr9DsnSrSFXn8ch
 TxYPN6SV5ea1S9RbS4QS/G9A14Ftd3WAeP/9EbvO1SCUXiXBOhTbkP/PdEhq7iQlrt1is/B7Q/8
 5Qj5Yna+pc11q3lCX+3JYbHeq3BA==
X-Google-Smtp-Source: AGHT+IGH/QfYiAnQJPr0GOQNrGhlT5GSjXaobkJKyhyO3Kev1fgyhthPVGZDzJLtd7qs3j9ydBxOXGdwAZmL5YVzP/o=
X-Received: by 2002:a17:90b:1b48:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-2febaa8d1e9mr8709419a91.0.1741021513833; Mon, 03 Mar 2025
 09:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20250301021747.28827-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250301021747.28827-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 12:05:02 -0500
X-Gm-Features: AQ5f1Jqlu95Uhh0C_B1Yo1gd1KxYc0hMN4P8akp7zg0sPNV5-YJR2fDl3cCRRLo
Message-ID: <CADnq5_PPP14D6V62HBoxPK+SDudyBaYG7693hBx5y34TqaXfzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/amdgpu: fix style and comments in DCE6
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

Applied these.  thanks.

Alex

On Fri, Feb 28, 2025 at 9:22=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> While going throught DCE6 code, I took on myself to add some comments
> and to fix style in a few places.
>
> Alexandre Demers (2):
>   drm/amdgpu: add some comments in DCE6
>   dmr/amdgpu: fix style in DCE6
>
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32 ++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> --
> 2.48.1
>
