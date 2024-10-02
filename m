Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390BCF6D3C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 16:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F3210E60B;
	Wed,  2 Oct 2024 16:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATnOqUcv";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBCE10E60B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 16:42:10 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2e0b46df34eso5854a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887330; x=1728492130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tNJsW+YhzMhipNEuF07a26gr588mR/zwZwGvHVBPH8=;
 b=ATnOqUcvcKM5bKBzJ6adQ9h1kj0OUUsAFBZVZL1sFdyJcs79JUf1BsiOTsIN7T25b1
 YccoKRPP++VX8e+T/2rgF2kg6nXXv771O5k/NwZ/1K8Avc+TRYtZo4otPeQs5+IkoeZa
 chCp6yeIznLYsokDS/NXRH2Ef6+5din3sYJpCRqkMqRLs6bGfS+0pc2OdhX9WZsFhLse
 foUyHrpWv69N8P3VqHxbmF9/vF2AB+IlANGU4nM49tirCdXHF66Q80+0QKPSe9xb8mVU
 Ndvv8NQFmvGvwxh1D2uQ9K3r0Y1X9o/2RYO68aMKb2RHYTbuscLWDypX9nm9pPzF71su
 LGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887330; x=1728492130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tNJsW+YhzMhipNEuF07a26gr588mR/zwZwGvHVBPH8=;
 b=mSxTpxdzfEXKc8PNPjy0CG2piPtGjAYW8BK7WmydV6DUDbQH7+oqNlMVpChJjNc3NW
 UqH2+VYzbfSjUelgygHU2zjoNTmeAgwpILri71QACk7rViNqHpD++izBKruLoJptKz8H
 IcQEk2s1VubOCdhuoDj3RU9OMyJq4B58pFO24sCbOoUAZvT5zhHEJNFdVJFBaBdhDEBM
 bCa0rkQSJt/Fmxh9q74f4s+myZdyM3dAzrldS2YmkcIjB/3koffCH0vXk1cFGUKWjzVE
 AvYV1mktIgEDvNu4Q3+2AP3uve1jwPmfNYRaeJTjmQb6htf9DnQ0oVoUuwpQms4znS9+
 REGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbt16l0nxY+LbQu+PAZqeUiuOpM4Y5Ytntqe/e51+1tKEQXXdXZ/CM8F9qEzWb1G1H7CeefNsK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOR6EnTS5EGfv++VgWd25WDL2rNRNLn2DWQ8rI+Duw49PssnSW
 VNpXAGt42n0SL9JqH3k+dpi/CFLo44nBw9GxfQ3ogCnctGLpHg1f06EznMOIvWPy0ST39bz67bL
 n9IfLC57yPSbnSn/SQ7m54H+d9lKcVg==
X-Google-Smtp-Source: AGHT+IElYA31G8llY/h9UyReYSuWwmUShYj9WatgYnv3OzDK9xktLXo1w5vRCTArPzTnXasVNG4c3xF+QPryQwnM14w=
X-Received: by 2002:a17:90a:8c3:b0:2d8:9f4e:1c3d with SMTP id
 98e67ed59e1d1-2e1848d7d29mr1855110a91.5.1727887329623; Wed, 02 Oct 2024
 09:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
 <20241002043936.2960921-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241002043936.2960921-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 12:41:58 -0400
Message-ID: <CADnq5_P7fZJ7os0te=m6fzZtbHEvJ0cvMynUuxrp8nTYcMUUUQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu/gfx10: Apply Isolation Enforcement to GFX
 & Compute rings
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Oct 2, 2024 at 12:58=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit applies isolation enforcement to the GFX and Compute rings
> in the gfx_v10_0 module.
>
> The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
> `amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
> called when a ring begins and ends its use, respectively.
>
> `amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
> begins its use. This function cancels any scheduled
> `enforce_isolation_work` and, if necessary, signals the Kernel Fusion
> Driver (KFD) to stop the runqueue.
>
> `amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
> its use. This function schedules `enforce_isolation_work` to be run
> after a delay.
>
> These functions are part of the Enforce Isolation Handler, which
> enforces shader isolation on AMD GPUs to prevent data leakage between
> different processes.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 2b230971c58a..57f28cb40913 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9802,6 +9802,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_gfx =3D {
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kgq,
>         .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> +       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> +       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute =3D {
> @@ -9841,6 +9843,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_compute =3D {
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kcq,
>         .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> +       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> +       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq =3D {
> --
> 2.34.1
>
