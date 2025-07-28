Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C27C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D767C10E551;
	Mon, 28 Jul 2025 17:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eIjml94W";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEBE10E551
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:19:11 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-31306794b30so865550a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753723151; x=1754327951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvXWM3tLLRG6S09A6+FIyiwvZOeQ4fg3jr/MUEM5w+M=;
 b=eIjml94WE2zk4Ns9WMURsEMeFBvJXYLgZbbmNrGkMNkHBpXzRWSiod83TUwujk2dmJ
 vslP8FB/NFAoxX2RbR4zSPG0je7jOxiHPt5bAfsUblk7eS4URjJmAf8NFtK6XzLwfO0g
 gJ0lLfjqtv+KfyuMSKL24jgY8sM1LF24MjF+DLHrKkJTSPWNrASmBjCPUoETQj1Dy6Mi
 iI4MGfj+0rzuaUxwC57OflVVVKe4X/xGl3ToATHyvgxDkRGdLMXipYzOb4SEhY4p1nBt
 i8iKlfETcO5ZsIYaKhO4QGYxeUUgJshqSpvMQ4x5+DM+kTF0Z5jAu5JHsvOcKNVdDdui
 pA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753723151; x=1754327951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvXWM3tLLRG6S09A6+FIyiwvZOeQ4fg3jr/MUEM5w+M=;
 b=GYGLtTiM1ImX6DDdlR8XAik/aoU4EOzZLsS1f/z2A6BgVLThfnFtyLMdxDGR0SYBBj
 o8LDJOCW8PjGYZBt0DlhmNMlpELMTxXUo1i0AyGnmWqY/hYntcjmAOekHMlXV6oX7fmJ
 P41J1E9TjRY+K7SJeXYAqxKbZEE0XRgdJtbNPAyrQGzUKvjZZRSVE3DDsu95gSbwCxKb
 CHF49EyWwWWUlenp83uCzMppS72QrDxmv/rRlkaaI6/INCRZ6ntmUpt7db9jDgtDOxQh
 ELWSLP/H+1nXhYmuDszfb6vph2Jo5VUVzD9QkF/yH7PuoFMCQEzuJF39pvJQKPSIOOp0
 U/Ww==
X-Gm-Message-State: AOJu0Ywu0fUSyYLfDVUhGHeYAJrtqbvniO+HA56/CUp/RYaDNCDjJF4B
 olqOZz7teajlBj4fePIwbOakJiYYVIKLDQGNqY02Vn72+nHIAI0PeXKpSyOmSGEfEPlCRgG7Trw
 +OTLxeuwVoSwJCMxj8oP6uKxakH9749c=
X-Gm-Gg: ASbGncurwApRP8TE71d3cD+BpseKa6H1FZQRsX9F6QsxPVN0tSHsYq+0dT7M9/pyWJT
 6eqiLXkm5+SjGNv3ORRe1GVaXYrYmSN23T1DmKngz1rg4322cgE2jtJ2wU33iG0j+GWMQkSnYSt
 de3j0+bo2h78TwCoCSs1YPrHDT0CpsKdTyZkJ7e0CHLAQqMC/crpGb/RU11mfGYWxK+zLJ90jzU
 EVPCISk
X-Google-Smtp-Source: AGHT+IEEUDcsmnUyZPzzsO4N8dKuFAD4UF5PiV1JGPZnj64eX7jti9L/vit2IaqC6ugwxRz5LRgeoNWCOy5F29y3is8=
X-Received: by 2002:a17:90b:52cd:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-31f03d66f70mr1590372a91.5.1753723150878; Mon, 28 Jul 2025
 10:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <20250720141318.4845-1-ydirson@free.fr>
 <20250720141318.4845-4-ydirson@free.fr>
In-Reply-To: <20250720141318.4845-4-ydirson@free.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:18:59 -0400
X-Gm-Features: Ac12FXxZ08milG5s88IPcpVNFDmu3qTUdhUrKdXpQ5UVOFkTK6m1DS8Ed8i2DFc
Message-ID: <CADnq5_MM5knDXoQ7WSX5_+xOH7FoG=gk1A5XLGBiJWXfcnWEsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation/amdgpu: add a few acronyms to glossary
To: Yann Dirson <ydirson@free.fr>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Sun, Jul 20, 2025 at 10:23=E2=80=AFAM Yann Dirson <ydirson@free.fr> wrot=
e:
>
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>
> Notes (patch):
>     test patch note
>
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst     | 3 +++
>  Documentation/gpu/amdgpu/display/dc-glossary.rst | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index 30812d9d53c6..ad9e6f0f91ba 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
>        The number of CUs that are active on the system.  The number of ac=
tive
>        CUs may be less than SE * SH * CU depending on the board configura=
tion.
>
> +    ACA
> +      Accelerator Check Architecture
> +
>      BACO
>        Bus Alive, Chip Off
>
> diff --git a/Documentation/gpu/amdgpu/display/dc-glossary.rst b/Documenta=
tion/gpu/amdgpu/display/dc-glossary.rst
> index 3205f80ad471..d6a6ed4e6374 100644
> --- a/Documentation/gpu/amdgpu/display/dc-glossary.rst
> +++ b/Documentation/gpu/amdgpu/display/dc-glossary.rst
> @@ -88,6 +88,9 @@ consider asking in the amd-gfx mailing list and update =
this page.
>      DIO
>        Display IO
>
> +    DPIA
> +      DisplayPort Input Adapter
> +

Harry, Leo,

Is that the correct expansion of the acronym?

Alex


>      DPP
>        Display Pipes and Planes
>
> --
> 2.39.5
>
