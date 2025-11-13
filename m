Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA0FCD6E71
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCED810E826;
	Thu, 13 Nov 2025 14:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lX+grZRy";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3364610E826
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:28:40 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-bc2c9a771b5so86150a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763044120; x=1763648920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sygCmxChHgkETxUJ9WDsCPxLJdI6Wi/qVDEA+uf3SGQ=;
 b=lX+grZRyoLsUcoQTHvMWOrD7mHmY2paN4naYOJpWM1av8HpKEnF+JnbNe4Oa4qW5lq
 bMaLUWpUaxHbDgGI5ln6nNjOgyO2IM7FWo0Os1iYMdritvXLidMgK4xKU9Qdv/f+MYCm
 Ax1It2cbmMB+bZW3heqlDlCKxCq1tXp9EFJykS4gNdhmGHGw7Dmpu60C6JQzVbe9hbFm
 +WJ4XzL2fh6fRs6E15/n5w2u/3cSPW9hXlYnAR5CKsSI63cgkfAU636Cx/WRWfEz13/O
 WnHXqEnquzDFKeOJcq79u+4HyQMRJCcPo1LYFU4AZ3QTYZgP4uf6mwNiblPCp3NlBLUh
 ajtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763044120; x=1763648920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sygCmxChHgkETxUJ9WDsCPxLJdI6Wi/qVDEA+uf3SGQ=;
 b=XaVQLXqv61xKsONgW2/hW4cR+WOreKd8TYOLHeBfTrlS7SbxtQgGgqGmld9pn9X3Z8
 /wbkHpUTg3acp+etvP9dt3D/UnHoKGRxc2/9cKkIwaCBuIVeo4q53M3CQjDwF+pW5EJl
 9S+o7Mw6VNZnNvgUW3HDT1290x3qwu6nXLSoB5zDJaJiIOcXz69Pti/+f3CFtLbGyv2g
 KmcrWQvrpYSO1Gj9xRQu5c30VgvPLQVYjokVGFErx0knW/Lv3zSnTkC5VG6DpKKg9bgU
 hM2YyjDsX2XwWPsP1BKIPzefXIVoCsk3/7F/Iud4LvYDh0gz0Elhs358YjICBO01xiPW
 yorQ==
X-Gm-Message-State: AOJu0Yz0kMnIn94qDpePAYIbVTMTHmuRrj9aCTk/ajmbQ3c/q7ee/yVX
 /uygqfKBvrIJhZvcNT9R8e06gj/8RcF+trv5R8V1YMvL4sNyPIlisbaeoJpnx1nRKV+N+7sjaRl
 rBlj1AorSNq8joa18l9YbrtnmNGbkaUI=
X-Gm-Gg: ASbGncvCn7aLy8G0fb81vGR7fhogbasJquWLPDrxovQH99lXnc/aE3pRtBrOU0tosku
 UcGvJ+BAcDbSb4zuS9/SIqmrwX0lY3dmbo3GpJXXSxbsmTt9ffi2Mxh0aNn0LdJLkKQpFM/h782
 z+LlGcXe8/dXYrX/vRgB5K5xxmfgnwlioNF3gcrvw1NgXWhlSW5QOv/dWIx0IjWAbrEAB72c5LB
 6m9jBYR25TR9gb+3owFgh8UqrPTn7gTKIBEQVrDoXEQqFh1jyYwy2zcGwAG
X-Google-Smtp-Source: AGHT+IHRd+hTXBaLFUWWW51VSU7h0oNTroPGJP4q2eStOsICp9akdSFsV1agr6xaksqmT3hg9wmSE06oB43kRy5W9vw=
X-Received: by 2002:a17:903:41d0:b0:297:fe6a:d27b with SMTP id
 d9443c01a7336-2985b9e0643mr19396315ad.8.1763044119682; Thu, 13 Nov 2025
 06:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20251113123531.1830492-1-lijo.lazar@amd.com>
In-Reply-To: <20251113123531.1830492-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Nov 2025 09:28:28 -0500
X-Gm-Features: AWmQ_blEeQLwJu9hE7cU7eJ4S3KbTB5nAZbOLhpMbf-bkBeTmN476hicny7UhJI
Message-ID: <CADnq5_OKfwGuKGu58EdhC9xvOwb_-JS-OgdOnCzKeExbDtsZ7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Unregister mce notifier
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, mukul.joshi@amd.com
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

On Thu, Nov 13, 2025 at 8:12=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Unregister mce notifier on unload.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 28 ++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 434a7e057dc9..d5f132f5ae63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -150,6 +150,8 @@ static void amdgpu_ras_critical_region_fini(struct am=
dgpu_device *adev);
>
>  #ifdef CONFIG_X86_MCE_AMD
>  static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device =
*adev);
> +static void
> +amdgpu_unregister_bad_pages_mca_notifier(struct amdgpu_device *adev);
>  struct mce_notifier_adev_list {
>         struct amdgpu_device *devs[MAX_GPU_INSTANCE];
>         int num_gpu;
> @@ -3954,7 +3956,9 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_d=
evice *adev)
>         mutex_unlock(&con->recovery_lock);
>
>         amdgpu_ras_critical_region_init(adev);
> -
> +#ifdef CONFIG_X86_MCE_AMD
> +       amdgpu_unregister_bad_pages_mca_notifier(adev);
> +#endif
>         return 0;
>  }
>  /* recovery end */
> @@ -4989,6 +4993,28 @@ static void amdgpu_register_bad_pages_mca_notifier=
(struct amdgpu_device *adev)
>                 notifier_registered =3D true;
>         }
>  }
> +static void amdgpu_unregister_bad_pages_mca_notifier(struct amdgpu_devic=
e *adev)
> +{
> +       int i, j;
> +
> +       if (!notifier_registered && !mce_adev_list.num_gpu)
> +               return;
> +       for (i =3D 0, j =3D 0; i < mce_adev_list.num_gpu; i++) {
> +               if (mce_adev_list.devs[i] =3D=3D adev)
> +                       mce_adev_list.devs[i] =3D NULL;
> +               if (!mce_adev_list.devs[i])
> +                       ++j;
> +       }
> +
> +       if (j =3D=3D mce_adev_list.num_gpu) {
> +               mce_adev_list.num_gpu =3D 0;
> +               /* Unregister x86 notifier with MCE subsystem. */
> +               if (notifier_registered) {
> +                       mce_unregister_decode_chain(&amdgpu_bad_page_nb);
> +                       notifier_registered =3D false;
> +               }
> +       }
> +}
>  #endif
>
>  struct amdgpu_ras *amdgpu_ras_get_context(struct amdgpu_device *adev)
> --
> 2.49.0
>
