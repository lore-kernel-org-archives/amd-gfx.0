Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD55E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C0410F126;
	Fri, 10 Jan 2025 16:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LO7WNA0f";
	dkim-atps=neutral
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB3010F126
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:20:37 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-4afdcfbcb0aso54077137.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736525976; x=1737130776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiN/Y9kyFm3Vya+b5pZnveGTdj2J1fg/3mDLpNWneZU=;
 b=LO7WNA0fe7Hp9tZRKIllmsVzTP5ZJYRShOI3d5qkx0yHvGf9qwyzR+e8X/HvXpsVIi
 bT2vnRVymQ8jambLXzD/aZ91sqnE4BmssTGz72KFMlfSJ7AJFwH6PEMnTFMOMp7JQwp7
 4CM7k4egkJ+Z6tfJsYZCUObSdt2mC2geD5ZvDOhBbdGk/ke2KJAX3Zf8bJu0996XTDOW
 3wD08DGGVLjGKnrh4k85cxaL+wqFfMasneW/B1WT22/rR3Aq0ZhsaSfCD74tu6Qf501n
 MNFObzRz3qHT9C/n5StLsgHkXOYd06uU3N99iACfYLPKJoY746BZAzJGZ4GC02Y5b3fJ
 YqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525976; x=1737130776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AiN/Y9kyFm3Vya+b5pZnveGTdj2J1fg/3mDLpNWneZU=;
 b=peJbNdliRAPH/rrOw61zYpDgBIj1rZkwwffaeKST315PE16GrKcxY724tRklOnUy+W
 F/9u3B1+Zj8dUU/vSExxZlmpxwRW1fMYfOn9g6M1mgr83znpksa+tQ2uwNiyQJvENRBj
 kCWASWB9sUZI+Ang9OndL4QptM4VUm+SD4RnzGWn73Tg9PfOlOzSN9EoiOSJDh9BRacO
 4ns2oIaalm8xQwQedcqJA77vOhrRtKiU8UvGBsXkG90CKZKqMWLYMIAdatHNWVqfv2YK
 /hWaG49QiMLs3F5WRkRwv0QsKwc338x47Jzhl8ABgc0vq4XXXjWtZquGsBmxJRlDYVys
 P6Wg==
X-Gm-Message-State: AOJu0YwE6CEGZkpNi0WfimoYAaPr8Y7UVxImpP/ya6jw5NbYebZuoD0h
 LVnDzzh5OZW1fKgLuP7WjmYPyIR9pK6NsVwjHsrhhiRjl4CAKsj8wZ0dtrcdEkJG0BsuiV5lmQP
 kO3DA2x1U5nH3ev+dU/vXbYsHYy4=
X-Gm-Gg: ASbGncuCzMJ73idnAh9fsWjCI1QrCtSyHRPJsGZjTy6oqG+BXvKnUkBJw6mcew69h6b
 yN3llWyZ4bbdb/hQ2VpAqckuGdepZKspRIOiRfw==
X-Google-Smtp-Source: AGHT+IFib8HX5CeNF0urfR+EvwRt5hizUiVuCnpZmCzZDsSzDZKk+MYOeU79bDWPOMsuNNu/tQqxmf4yE7gn9PN/Afk=
X-Received: by 2002:a05:6102:3911:b0:4b2:5c0b:779e with SMTP id
 ada2fe7eead31-4b3d0ec1d17mr3324437137.5.1736525976560; Fri, 10 Jan 2025
 08:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20250110023938.13375-1-kenneth.feng@amd.com>
In-Reply-To: <20250110023938.13375-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jan 2025 11:19:21 -0500
X-Gm-Features: AbW1kvanK6T8PT8xhSReQi9ncyUEz6w98hX4_2k5za6ilBP13HaC8oa16eIEGqA
Message-ID: <CADnq5_Mcza_8n169g8Dc9m++iYSV3wrY08GzTgsNcbhEbiunwg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on
 gfx12
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com
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

On Thu, Jan 9, 2025 at 9:39=E2=80=AFPM Kenneth Feng <kenneth.feng@amd.com> =
wrote:
>
> Disable gfxoff with the compute workload on gfx12. This is a
> workaround for the opencl test failure.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 2e5732dfd425..2c1b38c5cfc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -715,8 +715,9 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *ade=
v,
>  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idl=
e)
>  {
>         enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE : A=
MD_PG_STATE_UNGATE;
> -       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11=
 &&
> -           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) =
{
> +       if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 1=
1 &&
> +           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) =
||
> +               (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=
=3D 12)) {
>                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled")=
;
>                 amdgpu_gfx_off_ctrl(adev, idle);
>         } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =
=3D=3D 9) &&
> --
> 2.34.1
>
