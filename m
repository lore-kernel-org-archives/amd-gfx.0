Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875AACCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 17:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC25C10E0CD;
	Fri, 10 Oct 2025 17:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gEUnS9rU";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAAF10E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 17:28:18 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b631a684a9fso194362a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760117298; x=1760722098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f95mrTUxkVtgI96LUdbvRINUSgalxTfeizsrVLOqE8Y=;
 b=gEUnS9rURRVsXcxnbiGjcSa720EOhWpdOo6IWagmod3Rmy/G6Z7JODBRtfGpUBnJXQ
 1Tq2MXjUDkD1rz6OokLTSLDH+WQ+eFPEgr9owwXM4S4t4w4TELF1kDiADDygfrR/0oSf
 LhJfpS3W+o7pM1ZH+fSHhW06Ef0I2cRae2IP2DKm2PCOdZoxwUsOyu4I981ovS5v9TGI
 mXW7cERGavGjHY/G6UcFgBjB7Q+xvsUyeRAySFn6rB4z6CRrwFrKrVR7Jo2ZHYnFzND/
 4mDvpFWHCKLkjp7WNQKRkc4clQU0UgV5nEZHS2k/9HwFHP063r8TYTXCKtqe0JwplyPx
 sYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760117298; x=1760722098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f95mrTUxkVtgI96LUdbvRINUSgalxTfeizsrVLOqE8Y=;
 b=g7zCvSAUfp9B+ldTZjh3zkt9M0uVcays1j6VIrQhpYwKbieH5Gq7fyBd8Buz4/L92p
 ZZlBzGpBNsO6ahDeDhmW4pRTukc2P81AmA1YYY534yahPGQ/79UFH2X2bLWDQb21e4p/
 U8LOHUsfDVF6TnYlj3YPSzUKp7DwcnK0Ahuo/7usUnRUk9oL8J1W8V9Vx/FJHgwboL3Y
 8ZUtmKt2M4465+FNzzUlxWLUlzhsNKNLmUm5C4SFkNnqT1wwP4xaVLWud4bGGJwepPqx
 t62warRAzUi+FAb6WgXe35aFyGyMz3u+q00EvvrBQN69v+n5pmeuLNjOXrEJk1Me7Zq5
 mojg==
X-Gm-Message-State: AOJu0YwnD91T3YSUmC0azgGJVVYETwXitNEQrvYNLEWjrrzFmJLJuGpd
 Jdra/avUivSABJIpArLWihKQ59CAm8DXmu2SUIUczog479PDsAU7YqKqJWRp6svIvhK9x7SZwnT
 TWRAWgxdbkjVrK6wc/j9Fc9lOb/uVS4Y=
X-Gm-Gg: ASbGncthWhX9/aeGEXiTyGANtvFJqlE5sxNmlFrRmOJ8WHdOuzcW/33Jy3Ig20kS//5
 89RF2T8mizbtL4vrO7o4xaYDxUl5yzBkueCRiFbF/bI5Mj7InZHn97VXlgH/9SwYBNtAYiL+NBG
 xDBxCudLfb/ozr8wk+DbCgFaw2IRkxf+OC6Ml1U/5j1TvLQs04BK+aE8vdAqgPV8wshZArAKJeL
 ADxyWBk36elt59S3ZDiGPRr6KPlmGYjqaTL
X-Google-Smtp-Source: AGHT+IHDPDOL7PKBq24keimU1QY1sexNpJvN7Q1dDMIiKcBPq5ECT9ZX0owXG0ET6Slbi/B+anwP6pKdxTu+zYCGPW8=
X-Received: by 2002:a17:902:c410:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-290272e1cbfmr99466455ad.7.1760117298030; Fri, 10 Oct 2025
 10:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251010163314.1105768-1-jonathan.kim@amd.com>
In-Reply-To: <20251010163314.1105768-1-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 13:28:06 -0400
X-Gm-Features: AS18NWBG8L8wVpGzlcoZ4y-4EsxLMIFtrm7N_bJp32NaPmd2b_oXxowVcZ0LsWA
Message-ID: <CADnq5_PVEEpx4fLerw9NcaaFB4bZNOQXyVK07mW78ccLyvvSgg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix gfx12 mes packet status return check
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Fri, Oct 10, 2025 at 12:33=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com=
> wrote:
>
> GFX12 MES uses low 32 bits of status return for success (1 or 0)
> and high bits for debug information if low bits are 0.
>
> GFX11 MES doesn't do this so checking full 64-bit status return
> for 1 or 0 is still valid.
>
> v2: user lower_32_bits to check status and write some inline comments to
> explain the status pointer value.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index aff06f06aeee..e3149196143e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -228,7 +228,12 @@ static int mes_v12_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>                         pipe, x_pkt->header.opcode);
>
>         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> -       if (r < 1 || !*status_ptr) {
> +
> +       /*
> +        * status_ptr[31:0] =3D=3D 0 (fail) or status_ptr[63:0] =3D=3D 1 =
(success).
> +        * If status_ptr[31:0] =3D=3D 0 then status_ptr[63:32] will have =
debug error information.
> +        */
> +       if (r < 1 || !(lower_32_bits(*status_ptr))) {
>
>                 if (misc_op_str)
>                         dev_err(adev->dev, "MES(%d) failed to respond to =
msg=3D%s (%s)\n",
> --
> 2.34.1
>
