Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D6DC25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 19:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9824510EF6E;
	Mon,  6 May 2024 19:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i88FmHAI";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E43210F172
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 19:30:23 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2b3646494a8so1776118a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 May 2024 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715023823; x=1715628623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zicbnSeRgEP8No3Bkvkkibgfthae+ndoKWu12XrbaAk=;
 b=i88FmHAIXtGArzEnT2rfelHGpaGlawE/q6EocvLwGenq+6J3kPqBCzpLtVGOWamG/n
 NY3ZJ0HDV7bwZLXIj/GEMaGzz9aS1v5y8jv1dwCpaMcOKsCD29UoUpZq0ROrO494EB+b
 nYqtlAPOOML+uXGmMl9V83eEU5yh8xP1ZwqjcniHaKdMK9V/eM6h3pWkRVrEA2C41UAs
 rjL2q54+lDrhTwCOuia5iB2u1CYWQsTAz8Hz3kXz3Noaf9Vh4d72FSQ5Ouq4wK/trHZo
 3m73gg07zsyRjuPhVVfZW+mmi1ByMX94V53Q8GhzTnnQKukMM5bY6+QR8uunrOJaVMhx
 cfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715023823; x=1715628623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zicbnSeRgEP8No3Bkvkkibgfthae+ndoKWu12XrbaAk=;
 b=EH/e8RfEf81ekufv8qBAwdKHTwkfjk1UhIKEanpG8JkOpHtrQXaQzZM6tDDaTg3I59
 1CNcfUOSoyXIVPZeyt5iUZJQVhfmxgXAK5wOfnz1Kr9IbXZ9ZnWTISPix8Uiiz3yz9WX
 QuctC4bEZOnNVsXxaM7asrf1A+Dsm133Abo8ZqfNhgnGhMaJBLtUEurH9wYhwxWhKPCz
 sksoKX+BoNljplG7o+/ELkxqksaJbE4Fl1WcyKS63z8OoDpeKPSP3gd76/VhiijzEW2D
 Yvvr/zXvs1dXPmHBSSo3hVQxnAhQoff8qoVqhQQF0JExdTvqSB9duA3PNi4JAFWVDjYO
 vv3w==
X-Gm-Message-State: AOJu0YyvBLNnVj1sF7Sh08wkG/I1y5Mpj6pDVIuTPxL7micm1ooVBwqV
 2ry0mUXvv1mahQP7v9mML5su3Fz0TSC+MVj2wkeAsN8AJeRqIBYpyNeT3m8Wr8Y2lQoTNFE1QA9
 uqb3zApAR6mdVVvSt+p8iLBLENetCxVwN
X-Google-Smtp-Source: AGHT+IE00xoUft56Zh6uGcwPLMD9MaIZLcwZheWShFozpm//uo56vu4GMgCW1esXCrnRvhQ3hdR7EnPAbOoIkWHsuUI=
X-Received: by 2002:a17:90a:890d:b0:2af:8fa4:40e with SMTP id
 u13-20020a17090a890d00b002af8fa4040emr8885968pjn.1.1715023822713; Mon, 06 May
 2024 12:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240429073132.12611-1-kenneth.feng@amd.com>
 <20240429073132.12611-2-kenneth.feng@amd.com>
In-Reply-To: <20240429073132.12611-2-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 May 2024 15:30:11 -0400
Message-ID: <CADnq5_Opq_TpZ-zszFipB6qdkwm3B7uTiAM2PuaP8qym9xyR9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras recovery
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Owen.Zhang2@amd.com, Maad.Aldabagh@amd.com, 
 Qing.Ma@amd.com
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

On Mon, Apr 29, 2024 at 4:07=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> use the default reset for ras recovery
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index a037e8fba29f..f92b2c4f0d5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2437,6 +2437,7 @@ static void amdgpu_ras_do_recovery(struct work_stru=
ct *work)
>         struct amdgpu_device *adev =3D ras->adev;
>         struct list_head device_list, *device_list_handle =3D  NULL;
>         struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
> +       int save_reset_method =3D amdgpu_reset_method;
>
>         if (hive) {
>                 atomic_set(&hive->ras_recovery, 1);
> @@ -2501,7 +2502,13 @@ static void amdgpu_ras_do_recovery(struct work_str=
uct *work)
>                         }
>                 }
>
> +               if (amdgpu_gpu_recovery =3D=3D 2)
> +                       amdgpu_reset_method =3D -1;
> +
>                 amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context=
);
> +
> +               if (amdgpu_gpu_recovery =3D=3D 2)
> +                       amdgpu_reset_method =3D save_reset_method;

This is racy.  amdgpu_gpu_recovery is a global variable and will be
referenced by all of the AMD GPUs in the system that are using amdgpu.
To handle this properly, we should store the selected reset method in
the adev structure and set that based on the module parameter at
driver bind time.  Then at runtime if we need to change the reset
method, we can change the device specific one in adev.  Maybe it would
be better to have two variable in adev.  E.g., default_reset_method
and override_reset_method.  In cases where have to use the default
method, we can use that.  In other cases, we can use the override
method.

Alex


>         }
>         atomic_set(&ras->in_recovery, 0);
>         if (hive) {
> --
> 2.34.1
>
