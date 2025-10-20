Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F8CCCD1A2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 20:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC9510E500;
	Mon, 20 Oct 2025 20:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TC/GIYg0";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9456910E500
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 20:30:34 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-27eca7297a7so6146975ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760992234; x=1761597034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jirWv3FklV4nRxms5II+arc1nvj+eH2Zv483BR990WM=;
 b=TC/GIYg040IPJy7Sd/kRXfy5nhZM18jLcJhKKYCkVvPF1gU4NOr9C8taTBeFhQhB2R
 6PprRw+iedMN/REXy+Rxtn+98DxoOvoVT1ubjsp7kuxa2mfH4HRaL7nk/l40ciuaJS0s
 Z4IcK347Cx9JxxwTaPOjmoCqYzO61mu22Gr8J8x/syB/yWTcwd92bQ1/onCTTZM9OmRd
 45/xsj5G2JLhDyJlQ8C3cFRt5ROKHvwNQv+kd2iT3LYnVIibIcAXpjBunbk61sFj+MCf
 rfhInj77irFWKQcyYpyes3/OiR1gfcYSSPapUqfyBVYcKOyO5UQyhA/t3XHc9JF6CNyZ
 QMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760992234; x=1761597034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jirWv3FklV4nRxms5II+arc1nvj+eH2Zv483BR990WM=;
 b=TQX2dSeWjcuFxFFIdU0iYG0e39FsuArQNuICALUChiTNf/phEpZkdykDu5j5TxWQnw
 7YpM5TC+64UJP594CIjE0GXG6io/OJSNZ9Q2I3Zq294+yefOh8ewIMsjjsQmAMd500ej
 yMVQFZdBm9Ub8mf4sIimmqyGks50cluoSVTMKo0Vy82LwwRTFi4R0eIh0A58lMNalXTz
 mytzE01Cs9rH3hSF6Xo5HA6AqmUQsx+cZN8aDZj3/29vALfH2lj3lEGhImBSDxkohRuc
 y7VLCaMEzDGI78M7iC/LIWZnAEvr9TaWKKhPJm/qksshA5/U62VfjwINSUvDK/7srEnD
 Udug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfFX0OVVwchIizvkE/rrLQe82wc4QP4m5gAhtfp1swtJHehcGIwnVZ8UerqrmuqVw36uYTzubl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqXgkfZhbxfwl0jVHSQcxf1Wb5SnMMyATzW/o4N/w/WWS9my0f
 NVBHnKyA8gGqNkcEtwLdW27SI7DSCVlOvnMjx9o1+Glr/KIIMrxWNp2dn+XAZCoBhiiA+j4/p97
 osnroFudwHVBUYBp3vQTb5XebXRpK0RA=
X-Gm-Gg: ASbGnctpfygynXLh5l5IakFYDffos1Z9s2jBY061HKWpp1jpNng84tBgmDAKRtR1Cd1
 3g/r1lgdjfzw2XZN4tUhZRrqhfuZtmS/1pt8f7qzDogauX2mJKjytrpvqk1KX1jOk96I7rCXw9e
 3pZjqovC/wdfcGZkgJxF6lUloNZgDQ2qE+XjPrujxi4M7zFDhYVxSpQ4xVi3Mm1Pyjpq6QAZYkq
 7VFx4c0rLvAS7pxkOle/iWdlwzq0O6VNrDaACIDcyuBU3JsWiJoNlQL5wH9yRVyE0yzm/4=
X-Google-Smtp-Source: AGHT+IF8g8J9cluEPlQAnwPBZy79xmJHf/EIBbW/Y6Nf69ROI6kOYOuqsnNQogU+HU2xihjpRvhEcFYlYCbaBotS3Fs=
X-Received: by 2002:a17:903:46c4:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-292d3e50ee5mr5032565ad.1.1760992233818; Mon, 20 Oct 2025
 13:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-5-siqueira@igalia.com>
In-Reply-To: <20251020194631.102260-5-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 16:30:22 -0400
X-Gm-Features: AS18NWDL_FF-SOeUYZPV8qAcahT5TOK9SUzCRk7mcLkqOvPRkOsX7P9-h787klc
Message-ID: <CADnq5_O5fEYHfu2=OGP8HK1=MbA_LGy865qw9Z_WgNkNyXsCqQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] Documentation/gpu: Add more information about GC
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
> This commit introduces a diagram and a set of information that details
> the different sets of schedulers available in the SE.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu/gc/index.rst | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/gc/index.rst b/Documentation/gpu/am=
dgpu/gc/index.rst
> index ff6e9ef5cbee..b6b583c9dc6a 100644
> --- a/Documentation/gpu/amdgpu/gc/index.rst
> +++ b/Documentation/gpu/amdgpu/gc/index.rst
> @@ -7,19 +7,21 @@
>  The relationship between the CPU and GPU can be described as the
>  producer-consumer problem, where the CPU fills out a buffer with operati=
ons
>  (producer) to be executed by the GPU (consumer). The requested operation=
s in
> -the buffer are called Command Packets, which can be summarized as a comp=
ressed
> -way of transmitting command information to the graphics controller.
> +the buffer are called **Command Packets**, which can be summarized as a
> +compressed way of transmitting command information to the graphics contr=
oller.
>
>  The component that acts as the front end between the CPU and the GPU is =
called
> -the Command Processor (CP). This component is responsible for providing =
greater
> -flexibility to the GC since CP makes it possible to program various aspe=
cts of
> -the GPU pipeline. CP also coordinates the communication between the CPU =
and GPU
> -via a mechanism named **Ring Buffers**, where the CPU appends informatio=
n to
> -the buffer while the GPU removes operations. It is relevant to highlight=
 that a
> -CPU can add a pointer to the Ring Buffer that points to another region o=
f
> -memory outside the Ring Buffer, and CP can handle it; this mechanism is =
called
> -**Indirect Buffer (IB)**. CP receives and parses the Command Streams (CS=
), and
> -writes the operations to the correct hardware blocks.
> +**Command Processor (CP)**. This component is responsible for providing =
greater
> +flexibility to the **Graphics and Compute (GC)** since CP makes it possi=
ble to
> +program various aspects of the GPU pipeline. CP also coordinates the
> +communication between the CPU and GPU via a mechanism named **Ring Buffe=
rs**,
> +where the CPU appends information to the buffer while the GPU removes
> +operations. CP is also responsible for handling **Indirect Buffers (IB)*=
*.
> +
> +For reference, internally the CP consists of several sub-blocks (CPC - C=
P
> +compute, CPG - CP graphics, and CPF - CP fetcher). Some of these acronym=
s
> +appear in register names, but this is more of an implementation detail a=
nd not
> +something that directly impacts driver programming or debugging.
>
>  Graphics (GFX) and Compute Microcontrollers
>  -------------------------------------------
> --
> 2.51.0
>
