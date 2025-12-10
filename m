Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD66D3E77A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 20:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB3210E283;
	Wed, 10 Dec 2025 20:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m7N9EIrN";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0292B10E283
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:29:00 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-297ea4c2933so289595ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 12:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765398540; x=1766003340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JD3/GyxizWgVRlM1G6PCC/LaWGWZQhIR4OVFShkpNqY=;
 b=m7N9EIrNJe7Y+JoMlWahiYLZJDJiCyocq3gz3pGRhef3cZciIkjjMBewYycNYF4Pai
 MiHClhs4YfYftPGR1nxcWqEDnx9NunRTGkmNziGkaHkYACYpkEGDKOc0W/yOrAqWzW/Q
 IAIbBDWaitc6iSYFC7hrkvVOj+UtPicmVBDoPzw6Ys5oQbyLdAzyLH7Gd3Qk3FOJX/Rm
 t/+CMWUNpmS2bFesPSyJJxQUVyLC7Y8Nwy428bIWe1Y9E3YCLsCrkbpO78B6DjD8VPV/
 rijnj2CnESTmK4rya1Qs7RZ9HNdjfDY2WG1OvkCiT6XWHelFuy429WeEK+KeyueLlL6q
 amOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765398540; x=1766003340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JD3/GyxizWgVRlM1G6PCC/LaWGWZQhIR4OVFShkpNqY=;
 b=DK9FqMMCxpOM1BijJE45o23CucU9C0UrSkC7Oj33AKAWhaBiZprXERGt1RVb4EHgNV
 4tkAjBzfn7hOlhzZ3Bd099eoP+Fy8DFAQo3KXqr13jgpCZCSX2ZSHljMqRmOSt/Q0uaV
 OY4xkqA1fC9USjvRJGmwKpWKnko1niVwIzSWMxsyEozKa0HZubDSZPMZaS0SSduoR0Ld
 EKcOjUAv7J8AyTFrHzNWyDJzG7CGfKmvIxB7INWcbMYsLrMtqspxoPAvFK91oZqjLVGC
 yvHkWDDXQZ2u4C7xjL7DzJTRy7ueM/OTzN+PC4whcH2OCt/5gdaJzC1xdH/koIovAwoR
 O2Lg==
X-Gm-Message-State: AOJu0YxKi/VbYshwY+PS00saSV+fiGrUx65qHlVTwqgebzHKdCnLoFMU
 cwE2W/2Yic32kCVL4GOiAyL84uCfcLuq2tUKJ6QU7ZotGZZ3CnZCnTGcepR98Jqg33irnnmdHQ/
 Mzp0hnjuo9jCdy44RTChl10dhTRu39dc=
X-Gm-Gg: ASbGncsxZhLVm0B7kbTbPFzPp3hzRLmGTrFviU4kNtRefA4MZAWvkTMHYHMwlEy9/1f
 gOc0PH3xZEI3JeaZ93arP8ZEaBMUCLGO77SUsqJsfYXvq35NwBepQL/5irwcxxBDjxHLbljmJdy
 WkJ/WQez1fQHtyMl3BIYcEx+O8AmZhco+Xi74ABb9wYgohxn0b4+GE6228EJFswNAYc4DfNQgLX
 bVQqhPtLVrkGfHQAZxM5C5SL2K6iJiwzLguNu5Z4hg02oH13bTM8nJ4aG029xRK4oUN7S0=
X-Google-Smtp-Source: AGHT+IGWYl3bDJTyG1q7mGYcAfs4m1pQYHynMgTz2aDbobFVC45SjVAgKej3pMNsrkJw5qK3+XWIEpSJdg5IrWMxUBY=
X-Received: by 2002:a05:7022:60e:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-11f296edc1fmr1556247c88.7.1765398540342; Wed, 10 Dec 2025
 12:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20251208073336.1381340-1-lijo.lazar@amd.com>
 <20251208073336.1381340-3-lijo.lazar@amd.com>
In-Reply-To: <20251208073336.1381340-3-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Dec 2025 15:28:49 -0500
X-Gm-Features: AQt7F2oxdNCIW08M15Azst38ZJmGQTYslhXmjq86IIApOgpJBPu8ytjfxDijtJk
Message-ID: <CADnq5_MT-cg60fiOacf8OA=Bf4dE7PqtLASoLVmp0jBCZg8TiQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Change set ip clock/power gating param
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

On Mon, Dec 8, 2025 at 2:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> It's not required to use generic void *, change to struct amdgpu_device *=
.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h |  4 ++--
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.c
> index 677f730e2654..6aa54156bbc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -254,7 +254,7 @@ int amdgpu_device_ip_block_add(
>  /**
>   * amdgpu_device_ip_set_clockgating_state - set the CG state
>   *
> - * @dev: amdgpu_device pointer
> + * @adev: amdgpu_device pointer
>   * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
>   * @state: clockgating state (gate or ungate)
>   *
> @@ -262,11 +262,10 @@ int amdgpu_device_ip_block_add(
>   * the hardware IP specified.
>   * Returns the error code from the last instance.
>   */
> -int amdgpu_device_ip_set_clockgating_state(void *dev,
> +int amdgpu_device_ip_set_clockgating_state(struct amdgpu_device *adev,
>                                            enum amd_ip_block_type block_t=
ype,
>                                            enum amd_clockgating_state sta=
te)
>  {
> -       struct amdgpu_device *adev =3D dev;
>         int i, r =3D 0;
>
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
> @@ -289,7 +288,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>  /**
>   * amdgpu_device_ip_set_powergating_state - set the PG state
>   *
> - * @dev: amdgpu_device pointer
> + * @adev: amdgpu_device pointer
>   * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
>   * @state: powergating state (gate or ungate)
>   *
> @@ -297,11 +296,10 @@ int amdgpu_device_ip_set_clockgating_state(void *de=
v,
>   * the hardware IP specified.
>   * Returns the error code from the last instance.
>   */
> -int amdgpu_device_ip_set_powergating_state(void *dev,
> +int amdgpu_device_ip_set_powergating_state(struct amdgpu_device *adev,
>                                            enum amd_ip_block_type block_t=
ype,
>                                            enum amd_powergating_state sta=
te)
>  {
> -       struct amdgpu_device *adev =3D dev;
>         int i, r =3D 0;
>
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.h
> index 77d1c642953c..1d0df6d93957 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -136,10 +136,10 @@ int amdgpu_device_ip_block_add(
>         struct amdgpu_device *adev,
>         const struct amdgpu_ip_block_version *ip_block_version);
>
> -int amdgpu_device_ip_set_clockgating_state(void *dev,
> +int amdgpu_device_ip_set_clockgating_state(struct amdgpu_device *adev,
>                                            enum amd_ip_block_type block_t=
ype,
>                                            enum amd_clockgating_state sta=
te);
> -int amdgpu_device_ip_set_powergating_state(void *dev,
> +int amdgpu_device_ip_set_powergating_state(struct amdgpu_device *adev,
>                                            enum amd_ip_block_type block_t=
ype,
>                                            enum amd_powergating_state sta=
te);
>  void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
> --
> 2.49.0
>
