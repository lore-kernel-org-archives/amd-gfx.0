Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3C7C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 13:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D78710E09B;
	Mon, 12 Aug 2024 13:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ecdwE1ME";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8A810E09B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 13:34:05 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2d1bb65e906so2751867a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723469644; x=1724074444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpzGcF3VcM1RMsHVKXfNtG+/es7XANmhptzMTyjGEQA=;
 b=ecdwE1MEfAhYf+HvMdPIB5p5+1fUlq9qf8o8wIcHs4nu7AX17IOo6yUi7orZyR9HfT
 17oSZB+dbiqmQ0VfULJ1TrnvuL0hvcae4Pj9yrBRh5jngNp10uOZ7HvC06nEAL8TB18U
 FI7MN5eJhCPzJusL/7k5dCLhK7e/W/q9rjlgsB/sHOhbLfpwEqDm5npwNrtKSjAdeHnk
 q2XK0mgaXV+Ege5EgYMYImSseJz7ADdBJikdhd7Y1UXpckHBMX1LLZJ1eEznsJBKzKza
 buK+vnLnB/P/LlnciNpPVCxDJ5V9xEbK76Aa4e/L20bxTerrrtm+FuFpL4qPPm4QMtL3
 ITIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723469644; x=1724074444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpzGcF3VcM1RMsHVKXfNtG+/es7XANmhptzMTyjGEQA=;
 b=DfrSDsA/i0cD8YJB5904zY3K9e7od0RSRy2mER0OstJSDhTVKtsUBRmzddocwk8SkV
 HTk3kxpcIErKA+pY64TdAO2t6Me+Mt3Skwu8ahRDYz0Piz9yGOkugmAkrlVPcYb9zfu8
 ciMgK+JkCPo0ixadQZ9iiQgdqPTcj4OGvBUHpGrxIpDt1rFllj3u/f1+Qi3N9GpihBbI
 5BsBRa4gL99giNjN7M33GAuk2gQmh+SMbLYKwddXND49+nnet9Y1KXQCtnPkePz4Dc6m
 95OWNA9s0duzKVJ7wHR32enqlfbsvpm8yepX2FJ77M9zrBH0F5cOEqOQ/EKks5JlzM9+
 MAlw==
X-Gm-Message-State: AOJu0YyA5q29QbxifddZFjGyms6HNptfDA48IOSTK5lsGzU5gyIN4GFq
 mRByxXsraUJ7JzfcDRM4BD/gTCmQ/7MEMADwmeGcFKo+dlFr74YcPvC8klloYWgubJp1Vm24SYY
 PWMsxsR+BATiFFsp/KHmXfuzRQfM=
X-Google-Smtp-Source: AGHT+IGFJSP1FL/oZzEh6VfUhKjb0T0HpmfRx1aPTjzsA6HVunHnlTWF707Xa45j6asFaF7IHbHvZKkUq7Z/pLohD80=
X-Received: by 2002:a17:90a:2e85:b0:2c9:7e6e:3578 with SMTP id
 98e67ed59e1d1-2d3924dc884mr242281a91.7.1723469644441; Mon, 12 Aug 2024
 06:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240812044942.1670218-1-lijo.lazar@amd.com>
In-Reply-To: <20240812044942.1670218-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Aug 2024 09:33:52 -0400
Message-ID: <CADnq5_PRTVmA58YStiX8vnDw2vdfS=rr48wOkfJLr9rZs2joKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Reorder to read EFI exported ROM first
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Mon, Aug 12, 2024 at 12:50=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> On EFI BIOSes, PCI ROM may be exported through EFI_PCI_IO_PROTOCOL and
> expansion ROM BARs may not be enabled. Choose to read from EFI exported
> ROM data before reading PCI Expansion ROM BAR.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 618e469e3622..42e64bce661e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -431,6 +431,11 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>                 goto success;
>         }
>
> +       if (amdgpu_read_platform_bios(adev)) {
> +               dev_info(adev->dev, "Fetched VBIOS from platform\n");
> +               goto success;
> +       }
> +
>         if (amdgpu_read_bios(adev)) {
>                 dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
>                 goto success;
> @@ -446,11 +451,6 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>                 goto success;
>         }
>
> -       if (amdgpu_read_platform_bios(adev)) {
> -               dev_info(adev->dev, "Fetched VBIOS from platform\n");
> -               goto success;
> -       }
> -
>         dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>         return false;
>
> --
> 2.25.1
>
