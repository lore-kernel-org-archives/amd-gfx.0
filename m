Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010E4C282CD
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 21:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB9710E02D;
	Sat,  1 Mar 2025 21:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtFbmkie";
	dkim-atps=neutral
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD4810E02D
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 21:36:09 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-86712bc0508so1349789241.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 01 Mar 2025 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740864968; x=1741469768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0wyg54uk58CbSu7UQqMv9goa65Dh3bE01Io3nCxjFo=;
 b=KtFbmkiezr4RZwROn0WM8pAHE468xTrutNmp6Wz4g/McAIxCYsI2Y+jB7yrpBpgIf8
 bc5AqUkar0upf8Q+P1608RQ4KB2QX2eJzG/8YJ4lRTQd1xxYtUN5RmkQU5XNKQd7aeuR
 9dHgUgt+Xe3+wgXXyB3s2fVFwbSv/Q5kze3YqCgcwMbTl6/bCYMQVPofFd9oeGE6Qxdf
 2iouGm8tr5sr3n8WwqJAOXueF5wiJG7lxcBpjVTzuvDakTRSuBuOlgthvgs0RMI7qChg
 kN6Z8ZnCrCPv+d3lPaGA0MldVtL58Tq3mMyaJy2GkIhXXZkZ7RyCfvboJd3CBgLzRnKm
 ZFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740864968; x=1741469768;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0wyg54uk58CbSu7UQqMv9goa65Dh3bE01Io3nCxjFo=;
 b=DIHnZd8sl7OSvbkJoi8vmw6uX3VlkqkW7bK1fSraFw4O1nJNpGiki6fz2S9Up7NhiG
 3bdvUX17j8bnub9G7PRv9rJ4njwq1ytkwzIUxLQtMwdUNp14d6bevqOxjND56a1y/EMw
 0h2gpFCm/Sz+xoeXaSI0SMofV5OTXF329kFtOIUHSBFAGMYfW8BwO8QmE/5GqQVBryC4
 HUJtDiafjGrkZrKyuk7EZK9YVw7GZOaTn4nOEWT22KRlFAoQZkXAzJT5iR+988iWzWHN
 G2CPXALpyiKn8hT8+e1KrVZUgWiNsuNmg3ttlKAgM+tqeDQn0bIKIiGwUEJt+E3z92+R
 r/dg==
X-Gm-Message-State: AOJu0Yz+Y/GOFsFvZCUQdP6vOEWs+YW/ihrg4qFEasjmJNsXdENZ0/SN
 EANcx0ra0/CQHhrbr9dXGY2yiwM4WrFVZQ0XfBz07HRifzjqZzC9FIBBPnn713twqCdLVKI3Yaw
 WbW60xhdr4EEokEibDlsUD7q3/HBCsw==
X-Gm-Gg: ASbGncvYrP19WViF4IAACFe2Uttbb1gkpGyACW1tqvVwERGbTvtUCSj8NqvA6WKXZFL
 nhKltFIvSzll7zLF513eo8un9kQ1GuUsyMg9rWsVYvCbt2XYqbEf53mJcTTxlRATlGGW2Vt7ie5
 tobFZz42HLaruwdq2ZoS96ikQi
X-Google-Smtp-Source: AGHT+IHePSdVBKCKFWBkltKEE5LVbOuzjL3YQuV3GlgESCYlDc3NYIuT54zXoGOkUg2WXo8Pjctr6v1YfYNTG5k0kBs=
X-Received: by 2002:a05:6102:3752:b0:4bb:dc3c:1b42 with SMTP id
 ada2fe7eead31-4c044d36f4fmr6450388137.12.1740864968389; Sat, 01 Mar 2025
 13:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20250301023130.31277-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250301023130.31277-1-alexandre.f.demers@gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 1 Mar 2025 16:35:57 -0500
X-Gm-Features: AQ5f1JrS-7hrAdSac_iWcVGgAuYsnn4SWY05wF2NTjE9FqOyzQ72JzsEX7soFTo
Message-ID: <CAPEhTTFAy=+SXPNk4vEeYo0bpFuBPb+yvBE9QVCMZnML7PMmQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Uniformize defines between DCE6, DCE8 and DCE10
To: amd-gfx@lists.freedesktop.org
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

On Fri, Feb 28, 2025 at 9:31=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Keep a uniform way of where and how variables are defined between
> DCE6, DCE8 and DCE10. It is easier to understand the code, their
> similarities and their modifications.
>
> Alexandre Demers (2):
>   drm/amdgpu: add or move defines for DCE6 in sid.h
>   drm/amdgpu: add defines for pin_offsets in DCE8
>
>  drivers/gpu/drm/amd/amdgpu/cikd.h     |  9 ++++
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++---
>  drivers/gpu/drm/amd/amdgpu/si_enums.h |  7 ---
>  drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
>  5 files changed, 71 insertions(+), 51 deletions(-)
>
> --
> 2.48.1
>

Please, don't consider this series. Adding sid.h throws out a lot of
redefinition. This needs to be
fixed first. I'll send a v3 once done.

Alexandre
