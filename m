Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA603D41D5B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 15:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F0A10E27B;
	Thu, 11 Dec 2025 15:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JT0/Bdhd";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7097F10E27B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 15:36:13 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-29efc031eddso372725ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765467373; x=1766072173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9ZEFaAxN6V0ayFrgZE7LCz3zp/KQ+gbTOmPZ81mNH4=;
 b=JT0/Bdhd3LaTod4olrfp/m56UX82HZ1Nt4YcWzh/GOTI+gUjqKP/rlenifvH4Q6vvf
 pGebfAvpETR5ahsurVQ35BvsXrEZWHf61yWIocRoKzTzzSgTxLoGq513yYiI2Ad5F//v
 +o3i+V8zIGv0v0QVvqFj7xcR/Bc0rWQJ1I/qI8Cn9CVDMPejUrQk90CgHBxOLMAicLLF
 4k7pEwaSlm9lIwVVQWvwdPet7UH7Ri60EHLkKrUlkr2nhX0YG4Ci1alOBvBFVFwI+pB1
 K5qi6yngbV31UMowqe31VnfF2k6rfmo23j3IzLoLTyCWczFMIOYfyDI6ipvmYGBv7io9
 0c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765467373; x=1766072173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9ZEFaAxN6V0ayFrgZE7LCz3zp/KQ+gbTOmPZ81mNH4=;
 b=lOWEsEhyWgdF8atQo+m1SOn10xLh2SpFG8lK2nBCVWLGgRAMGqDArrN+afSxBSm+mo
 h46ljo51LPYcZCeMRFPmx/o677JhNLVwjlE2G+jIe0VI4SSI0wbCtf03oxkussUAOSlk
 7cpyPcQnGVwYuIA6UeHGbSZvkk9jlyjsUL1fKkCu6XBGCehAJtHrU1ZMXdJ6ntDgdmmE
 Lj/vgg4wOrOsSiNBV0K957Urr4/lQ1Q1NTs+6wsGHNKqjAQ4yFdGpafBsudq9Qcxj1oq
 uRlbbz1t6D1k5F5x+CcXXEsBdxI/4Rm4UPEp2c50z6cwczHoy+i9IZGpNweeZpt5E5oT
 M2tg==
X-Gm-Message-State: AOJu0YyeCGvw5nxlZ6I539PfAxsH+gxQb76BvO3W/U3Sof9yJD1ZvX7K
 HM3TqiwuKpGZiQVCsDiNQeq6mGrxLchbWkTZsrTBxsYv68eu/I6p+zqiohyqnv6XjkIiTy30MvY
 +xX+LUGFMSGWQsrmZY3Z+BUkz6Mc3QSk=
X-Gm-Gg: AY/fxX6JR9PIlSqx4pIfAgCVMZUt3o+IKPOLW0/tbxMoJPWSJJnEpbEeTQ4ldB3QTVT
 hb+DgQ522TO5UNQNuqimiQA8sMX23Vvfmb4mVIlFp9G0y20SXBLKAutEuZ0auBm6sht1vwVGpCe
 rPk8wmrkjsreTDALXc3iLWlHJSCIPH4H6Wbb/3bmMacd9Mg/+JGSAwYosWJRs6DPx1vFZu8c61m
 h1iwXS0j8jn5wLeEDIni4yL/cqCla7NfK0vK9gHbbs+hT8sRUC1VZCMf/MllVh3E7LsTkg=
X-Google-Smtp-Source: AGHT+IGH0aJ0CUaxrF0+Pz7smpHms69Tj+xoPaUT27/rY0vFm1YfOKAjImRojpot8kbAN9HqYG1dTfb8ugtw9nH0O6k=
X-Received: by 2002:a05:7022:40b:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-11f2e832b69mr1417544c88.7.1765467372709; Thu, 11 Dec 2025
 07:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20251211152137.2954347-1-mario.limonciello@amd.com>
In-Reply-To: <20251211152137.2954347-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Dec 2025 10:36:01 -0500
X-Gm-Features: AQt7F2orRoAtFDhHFp7KFuiwO8QLurk6W4BAZ7v5_GAmYqrheneMNXUed4VVJPI
Message-ID: <CADnq5_MmEkZivM640qnobm3fOPc-AhpMAGyypcPX6Gc0ihGwng@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Resume the device in thaw() callback when
 console suspend is disabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>
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

On Thu, Dec 11, 2025 at 10:29=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
>
> If console suspend has been disabled using `no_console_suspend` also
> wake up during thaw() so that some messages can be seen for debugging.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4191
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 7333e19291cf..5de79e0df26a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -33,6 +33,7 @@
>  #include <drm/drm_vblank.h>
>
>  #include <linux/cc_platform.h>
> +#include <linux/console.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/module.h>
>  #include <linux/mmu_notifier.h>
> @@ -2685,7 +2686,9 @@ static int amdgpu_pmops_thaw(struct device *dev)
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>
>         /* do not resume device if it's normal hibernation */
> -       if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_susp=
end())
> +       if (console_suspend_enabled &&
> +           !pm_hibernate_is_recovering() &&
> +           !pm_hibernation_mode_is_suspend())
>                 return 0;
>
>         return amdgpu_device_resume(drm_dev, true);
> --
> 2.51.2
>
