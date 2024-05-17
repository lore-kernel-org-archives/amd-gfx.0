Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63417C25B79
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 15:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF58B10E004;
	Fri, 17 May 2024 15:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WEodpltJ";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDAB10E004
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 15:51:51 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-1ed835f3c3cso14503425ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715961111; x=1716565911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UH9gIjK4/4P4OsdAPKJGxw2Osj4749AVA1rimL18xg=;
 b=WEodpltJPOqiT9l2Vi2m0MwBf5092rZKKEzPopaW7TySaOuIu0dOyWQ6EoP8H9zJoF
 OdK+YJV7HQYqxNJOVwg3B+Vg1TirWLk7gxQbnp93cyZlc3VcCGmYsMYLhjL5wVdNvP8n
 CrrDlBij1fKVCZJc7Eh8gs/GHUcAj08guCWMKY7M37QWYbF0AbMzntLaQjF/1qPc1GeS
 XXPq2bh+orJGdWy3I5jvrWQavMsNYLv+aJaD51QJm4JxUBG7ILgrZtDsrpdHlNOBoZOf
 C1ix8adZICok85ryQeUTam6tHBcPYQq5O/It87B5ihIr2Ub9B3jsSErGY381OY2/bZys
 qZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715961111; x=1716565911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2UH9gIjK4/4P4OsdAPKJGxw2Osj4749AVA1rimL18xg=;
 b=j0348K3nwW9CgMi7m0obo/SKiOCpH3p5NPSQwLr6G4dWpX2NmW2vTGDwLwmStQDds4
 fPI1XVkaNZkgzmNPyZPkNSgDTiTC1WGdSLKRgeJ5n+eD2EuHgJdgWaVTnjIDnsrACA+9
 6C8QCuYKnv9ZrLmYWL5omMpimuYBMyMgN3KI4cVG3PYLOmKQt01B9Dv0+Qt7DsluV9Rh
 2IQGoWxWgcOJSWoktuE6RWqoyTKpnog5XoaVyg0gfj+vwi7jOHA6wcJMU14I5kbqgKf6
 dQcU89w+YkgO6R4ucB5lfdby2mZ0bH26JgSC3GwIGdi3cNSJZl52qToYKthMWVzKaH89
 WHLw==
X-Gm-Message-State: AOJu0Yxu0E5y+lnmri7rOGp8vTPAhe4Nc268+YlrCyHF4yWDIxnLIb+M
 MfKr0NgRguLqFUbvqLGonS01/tvBjH7VP6t+tj8zEPcAT+FW0sYU0Im9X5ys5NoHvV+B7a/zPby
 0Aiyj9qr5askQCZtkNQSKuW3YuLc=
X-Google-Smtp-Source: AGHT+IF50yXm4qJGJlNUdJUTQVqvhtAuvlS/iJ6umpDWMgz8EC6YRAugF4e0rTcI1RdscDt0gbLh8Wfo48myjwTQLhY=
X-Received: by 2002:a17:90a:7d0e:b0:2a2:ba9:ba61 with SMTP id
 98e67ed59e1d1-2b6ccc72e91mr22916214a91.34.1715961111272; Fri, 17 May 2024
 08:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240517070011.2253488-1-shane.xiao@amd.com>
In-Reply-To: <20240517070011.2253488-1-shane.xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 May 2024 11:51:38 -0400
Message-ID: <CADnq5_PXY+nx-RVjxmjpjEFSjGSTQpCp0MYJB8yRJwJKx=CNwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Correct the GFX12 memory type setting
To: Shane Xiao <shane.xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 sreekant.somasekharan@amd.com, Aaron Liu <aaron.liu@amd.com>, 
 longlyao <Longlong.Yao@amd.com>
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

On Fri, May 17, 2024 at 3:07=E2=80=AFAM Shane Xiao <shane.xiao@amd.com> wro=
te:
>
> This patch fixes the GFX12 memory type to NC. Since
> the Memory type can be overwritten by the previous
> operations, the GFX12 MTYPE bits need to be clear
> before setting to NC.
>
> Signed-off-by: longlyao <Longlong.Yao@amd.com>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index e2c6ec3cc4f3..6246d1dc0d30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -534,7 +534,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device=
 *adev,
>
>         /* WA for HW bug */
>         if (is_system || ((bo_adev !=3D adev) && coherent))
> -               *flags |=3D AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +               *flags |=3D (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
> +                       AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);

Maybe we should make the AMDGPU_PTE_MTYPE_GFX12() macro clear the
current field before setting the new one?  That would align with the
similar register field macros.

Alex

>
>  }
>
> --
> 2.25.1
>
