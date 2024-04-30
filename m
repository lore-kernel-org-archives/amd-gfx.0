Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AC8C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DE410FCC0;
	Tue, 30 Apr 2024 14:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PB/PTMWF";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E287810FCD0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:14:30 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-6f3f6aa1437so2367066b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714486470; x=1715091270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VJ9PYHCirE/tzImICtOWp6QyLXqeFaZXMJoIo+EVbM=;
 b=PB/PTMWF5djazx5G2RynFq4vWO6M9Vr1TBPDSs3wVE88nfz0L+h8KyNpTUlZjrV29x
 XPrAY2XnZsbl9Zw9wPx6B84Y6jeN1K/7PvJeku+19GxhihTwEQX7bTf99WSRUTeZhQrs
 aOXzlk3FH3T84lo1xR9Tkd6d2bdH64EAUNWdr0pc1xyoipVLUZwhByWQEw80T+MB2lIl
 0tHQPsQV3K5LyarlONkm1ByuOjcpvNiiDXblV0uIfjR4GZAujlQwb2bsfh3bv0jx98v6
 wBXEkhfbxTWe19L5cu+NC4zPXmP7ZrIpNl3E0k+flstIWDFEe3pImR1Tl28dFPHNnieh
 gNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714486470; x=1715091270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VJ9PYHCirE/tzImICtOWp6QyLXqeFaZXMJoIo+EVbM=;
 b=QnR74Sus//S6EuxpGenozhfc4cQ5HHfpvWkxlvjsoB1W8vjssKHHD+ID/haQdOgx/x
 r09tBUwJBu5f29ECYGCv0zihAA3V5Y1vCu5imqXMtEAF293Y3OsXyy1FHqZbIUr8hkNo
 SGUkoW4LGOqigc2UKm2kIO/Xmcv6uemgot9C3/hti9DsJQqFtIXnOwPbIUngJvnGEoDM
 LaxJWZ135tBTq5XOXMaB2uV3fkOZw6uhJDRaFLgPkXTwuuz04jhr8NPoswP/Q/XNxPYT
 1Gtmc4j0y3YQDbOfLGfjygFhI0pGgNup/uv1V6PHO3ycHUeXcAIel9y2R4L4V7MGrF79
 zLzQ==
X-Gm-Message-State: AOJu0YzNVxyLy1jgetlnYuQYmqol62ZEPxNFtMfZLll/Ll+n+TduBPuo
 Gy0Pibo31C/+v6W2yH5Y+lgtVqkXgOdCEaYsapyB3Up+QbKV7Gznwau+I+hkE2bNlHi24oA5oUA
 Z3bYDBanpWcs/fakcKY/vRDRT0H13XA==
X-Google-Smtp-Source: AGHT+IEOB589aC1P3gKwoAAEDEmsk4inn44qj3dr25mS8yD/6JitLesBJueijddgEGgU+DmSSBx9ArmpB8YSRt80qLQ=
X-Received: by 2002:a17:90a:4590:b0:2b2:9a77:3371 with SMTP id
 v16-20020a17090a459000b002b29a773371mr1313925pjg.12.1714486139530; Tue, 30
 Apr 2024 07:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240430061621.1054787-1-Jack.Xiao@amd.com>
In-Reply-To: <20240430061621.1054787-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Apr 2024 10:08:47 -0400
Message-ID: <CADnq5_Ne4Av3=XoY7TZ4nOBfhvBju1ij45saqN7PyAFP9t_L8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes11: fix kiq ring ready flag
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Hawking.Zhang@amd.com, likun.gao@amd.com, candice.li@amd.com
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

On Tue, Apr 30, 2024 at 2:42=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> kiq ring test has overwitten ready flag,
> need disable after gfx hw init.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index d98f6d282ae7..8263b97c4466 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1326,7 +1326,7 @@ static int mes_v11_0_hw_init(void *handle)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>         if (adev->mes.ring.sched.ready)
> -               return 0;
> +               goto out;
>
>         if (!adev->enable_mes_kiq) {
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
) {
> @@ -1363,6 +1363,7 @@ static int mes_v11_0_hw_init(void *handle)
>                 goto failure;
>         }
>
> +out:
>         /*
>          * Disable KIQ ring usage from the driver once MES is enabled.
>          * MES uses KIQ ring exclusively so driver cannot access KIQ ring
> --
> 2.41.0
>
