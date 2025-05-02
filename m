Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C31BC3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FC810E95D;
	Fri,  2 May 2025 16:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d2kbVe0X";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6529310E95D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:51:28 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff53b26af2so221843a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746204688; x=1746809488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wz7DSu7GabkxS2eMKZ0fsTT614lyRMBDPrGC89v6T7M=;
 b=d2kbVe0XeO7Qq/q6KchN5nzZY/0dZMA0C625F+TKrk8mA9rC9HIa3G21xzhpGGHqxk
 mJrmyE6eL3t6uwDD4os9FvzN1V23LbpWO3baT8qHq9k/Qiu55uNtaTZGQZnmv5QNG4TL
 P0qB3HEnW4u3zct603YIB5CuQXF3bam6mGfSpZu7n8ZTqzYDRH5OHyxGeA3cEpVcSpnu
 MhSiTURyNl7lJVd7/eesb1zOthUIB6E/Oob5WztsHC2SNaK0IxUPwWgjQLkimXPLt1dM
 uQ69GYXWn7cKq1kPgay+OEQ9n+gg77wECYAIw4hFrSm7FZufd2kAktgT/lxqjFYhIHH6
 aFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204688; x=1746809488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wz7DSu7GabkxS2eMKZ0fsTT614lyRMBDPrGC89v6T7M=;
 b=eLYqK4WxCnChgOKMcvbLacCgSNMa5b/IuZSJWAFUEhOEz8VYU94+INx5e7+GGLtZ0/
 6TFRQDaenBZjDgd94brlmTOUvFEmKDCQe3XE8xrkVVPwrdBjG8kpZrzwhvSSA7UbEE5+
 BiBk+4WmeE7NAyknwM9BAI1n/odrhTzFO3x7aGykTR5eHcsxaHywLJ0IDmcR+F6jCugN
 rSYt0hx7tNz+JNKqkGD0jjUOY+knNJrTVt2V4E2Rt9n20ZpcwLiLonviZ8qas1X4LPBd
 YSxqDN8J1asytY2m8TR5WXHbatNy6q5KN+uZwGuWr9Y2kXJIj0+359E5Q1z1SClCbq9Z
 9npg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyxlhaQTbBGPwNCcH0MhzmsNdtxTOrnRT6lfem+pZhPNpJ5u+yqMWAKNAduIx35/sJv1TshcpR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwiRPft+FmkHc5vXRZqnI+cjSqDRMrbzDtmbVGeuP26xWCFppV
 rjpcZ0O3z1i8oKsmD7J0Si8Qmc9ekTTl0dI8c745lw58nqmMYNKzQOqulMZTAsJAdy+h0POpOzE
 yGAj5dUoIpK093PRNL94VR6oJlosesG06
X-Gm-Gg: ASbGncvkYdlSBJZbTDbozCCotN61ZyI7KvSF2x+USPt85uQE6aeRIipudUDiXnu4g3x
 Re86Qus6mp5cHmjRBBAw3J1x8hhUFNrMt26C5s9aGjlIXbmOE1DVd4Geap9uFYRyC0KH2DBXoTZ
 ++pTPvqW7SA+yx8VqHVzVg2KpFWAemLu7o
X-Google-Smtp-Source: AGHT+IGe9ALqZTyzAbO/D6XjVDzsGnqabmATv2bLhMQfAgIWJZBg43H9VpGNKYpksXmSmp1IzrmzYYI1+zavsKU2nSQ=
X-Received: by 2002:a17:90b:1642:b0:30a:28e2:a003 with SMTP id
 98e67ed59e1d1-30a4e621a86mr1942070a91.3.1746204687782; Fri, 02 May 2025
 09:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250428105031.1147636-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250428105031.1147636-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 12:51:14 -0400
X-Gm-Features: ATxdqUFiG5s7I4Mre1_odPMhEH8EBWQTMyu3A_BOaocGwlrntu2nzYc5B2BCGsU
Message-ID: <CADnq5_OrQu9TnCxaFqaNnHFMzVcmh8QmYzN=iv81PgabvY+jMw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add Support for enforcing isolation without
 Cleaner Shader
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

On Mon, Apr 28, 2025 at 7:28=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Adjusted the enforce isolation setting handling to include the ability
> to disable the cleaner shader without affecting isolation between tasks.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Please update the module parameter documentation in amdgpu_drv.c as
well.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 7 ++++++-
>  4 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index cc26cf1bd843..7e5ae8f1f0a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -878,6 +878,7 @@ enum amdgpu_enforce_isolation_mode {
>         AMDGPU_ENFORCE_ISOLATION_DISABLE =3D 0,
>         AMDGPU_ENFORCE_ISOLATION_ENABLE =3D 1,
>         AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY =3D 2,
> +       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER =3D 3,
>  };
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 0941b3495b2c..9ea0d9b71f48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -310,6 +310,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *=
p,
>                         p->jobs[i]->enforce_isolation =3D true;
>                         p->jobs[i]->run_cleaner_shader =3D false;
>                         break;
> +               case AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER:
> +                       p->jobs[i]->enforce_isolation =3D true;
> +                       p->jobs[i]->run_cleaner_shader =3D false;
> +                       break;
>                 }
>         }
>         p->gang_leader =3D p->jobs[p->gang_leader_idx];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index fe68ba9997ae..8330e30f0caf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2163,6 +2163,11 @@ static int amdgpu_device_check_arguments(struct am=
dgpu_device *adev)
>                         adev->enforce_isolation[i] =3D
>                                 AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
>                         break;
> +               case 3:
> +                       /* enable only process isolation without submitti=
ng cleaner shader */
> +                       adev->enforce_isolation[i] =3D
> +                               AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADE=
R;
> +                       break;
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 8f1a2f7b03c1..9d4396ca52ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1689,7 +1689,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(str=
uct device *dev,
>         for (i =3D 0; i < num_partitions; i++) {
>                 if (partition_values[i] !=3D 0 &&
>                     partition_values[i] !=3D 1 &&
> -                   partition_values[i] !=3D 2)
> +                   partition_values[i] !=3D 2 &&
> +                   partition_values[i] !=3D 3)
>                         return -EINVAL;
>         }
>
> @@ -1708,6 +1709,10 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(st=
ruct device *dev,
>                         adev->enforce_isolation[i] =3D
>                                 AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
>                         break;
> +               case 3:
> +                       adev->enforce_isolation[i] =3D
> +                               AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADE=
R;
> +                       break;
>                 }
>         }
>         mutex_unlock(&adev->enforce_isolation_mutex);
> --
> 2.34.1
>
