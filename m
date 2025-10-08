Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5FECCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 15:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3328A10E084;
	Wed,  8 Oct 2025 15:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sp27fYQs";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF26C10E084
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 15:32:37 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b631a684a9fso211016a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759937557; x=1760542357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4XeRBbZe2MRl27Pd1B0NdFEO3d26paZfuGe8WQ8zRY=;
 b=Sp27fYQskNpqjvFMzWzmwnPwamTnj6zkxWDP1i7VSez8IFeG+F4MLEKRXtO9oIsQ+G
 zBV48Sw1SIuBtV8wBHrWht7MNrI0kbQYjn3RBVQ3qQ0KvvRPU0TaWARG+PZTaVJlJ5J2
 dcN6BZIZ91/kVQwx/fcJoUlBAqPO07Kgvg/7LkMh28nn+eqzwHTT96qGhVnQqayaK466
 3c8FrcK7+oDH1a9ohKsmB9SzqDUP+Jlkv4jYlbNnyEkRDdW/kTwocIaTSQIKnlKdcFS1
 phBfvuWDEIi7iyOhw1fpK+DGcvmuqvoLhARX4BB1LVx9NKbJq3OmRn2VCNQ/iDOdGU9Y
 ISZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937557; x=1760542357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4XeRBbZe2MRl27Pd1B0NdFEO3d26paZfuGe8WQ8zRY=;
 b=a7MUtKUAtr0UOYBESLOGOjoPektk+0AH7T7+nGkgxMFWkfhNhtO+LHxf5HDZxK8E2S
 KxQeXBAfEGtBW3q65h1Q+Ty5q0C/zbS17Kk2Jd/gs1K+iHPX7wi/vu0+Mt8O4gohPj7v
 KR63d23YrO9baf1/hWU0da1GJ8I7s1IjUIdkXDqfskB7obC6uPGI1C1kfIbRaz33Y/mZ
 mE7ecEByVmHBk3Fmm91RbSm/Ye4BSktOBWucVoHujk7WJCfuYn6TI6O8xuMzfKvKZ/rH
 CVEt+8AHNULvsRfxiIy6Mq3r3puXn76vvwL1zP3s05Ea47fYflVkGmgNPIbsf/HlrlbU
 Zi3g==
X-Gm-Message-State: AOJu0YyVtJbcYHELT1V9kbTVfeHgGG0t5N/2riNw9DQ7u3vNZeeKNeDf
 ArVkqqcCzZjJq4UXgxjVApdCK8UFYPP9yfFIguNzOOgIjyQcigGhLc5oN3rT3iDEYo30SJ6CX+u
 kbzATJoty/RTswtalM1Pp2DrPCzJozljI+w==
X-Gm-Gg: ASbGncsF7+7CYarSeMt2wpnU3IX0++j03Ln+yyM0sT+T+XvrZbDP+cRV8wwVADVlOKc
 viaNdEi7aZWp1lh9SE8CFxInTuTiA8kSObf089gLSveM9jAK5R4Z+mYGh6VCy5EmUjwQP3pGSXD
 c/R8l5YBOmTq4GGtwPNHX7yujyPG/dcFoNvibgoony1cniKLg5FKnTIWw0y4SBH9MHmD6GmlOfg
 zDcsJZHoFG9ccpzdATcWVNFgnEwCGo=
X-Google-Smtp-Source: AGHT+IGG20eNMrlTC1t8axaeyCnUOrZY4jePjtQglvHTum6Xv2D4zc/8Bg9LSA0BqQCJVywdjCBlR8PBlU0NNADKdRk=
X-Received: by 2002:a17:903:2f83:b0:272:f27d:33bd with SMTP id
 d9443c01a7336-290270f90cemr25490785ad.0.1759937557145; Wed, 08 Oct 2025
 08:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
 <20251002174245.1691343-4-mario.limonciello@amd.com>
In-Reply-To: <20251002174245.1691343-4-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 11:32:25 -0400
X-Gm-Features: AS18NWC9sJrr9cmjbrk6L4KJfPIcniwpChBunf9nQ6zqvphnICqNgqXn7Y7fOQY
Message-ID: <CADnq5_Okxcan=FBj+vE48gvDTFzo_VzQ3SdbxPqtVDT9feuSCA@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd: Remove comment about handling errors in
 amdgpu_device_ip_suspend_phase1()
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Oct 2, 2025 at 1:51=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Error handling was introduced in commit e095026f0066e ("drm/amdgpu:
> validate suspend before function call") so the comment about TODO is no
> longer needed.
>
> Fixes: e095026f0066e ("drm/amdgpu: validate suspend before function call"=
)
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 870969f15735..d8cbfb094920 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3773,7 +3773,6 @@ static int amdgpu_device_ip_suspend_phase1(struct a=
mdgpu_device *adev)
>                 if (adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TY=
PE_DCE)
>                         continue;
>
> -               /* XXX handle errors */
>                 r =3D amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
>                 if (r)
>                         return r;
> --
> 2.51.0
>
