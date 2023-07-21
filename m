Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A82BEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 15:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A684710E6A9;
	Fri, 21 Jul 2023 15:43:59 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5288710E6A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 15:43:58 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5658573b1faso1300811eaf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689954237; x=1690559037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wm5VRmztcaAU0Qli+flx0D/geIglYUwXxMrlLyRshFA=;
 b=DTtK2sxMTSYmOagHwKHZBoBaN/xPt5qCD/fkytJAu45CTzz0cLHkFzIkuuJn/dk46v
 iAwK8Ed9/LaiwKkIVKcSjxfWuM3A7ice00Qi0Om3TwuJFEfhZNpHIarLUuYnCC7daB/x
 AyXrP2JXyo35KFIMuOfFu2zsERc1PXdSKekMPEFxGQM4UEogvowlYDvdK16vVb+F/CaJ
 wFuhRYhwYn4CEz5XYdbGrqTYF2A4As0ZgV/9UiGFINnrftGXAEERQD6y4le1kZjXrpXK
 Pq1gEDQlWYIgFtUFEtNextqd0sL+f4XLEbEw503N6AjJiFYp/lAGYNRWzyzx1sVbOvKG
 8zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954237; x=1690559037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm5VRmztcaAU0Qli+flx0D/geIglYUwXxMrlLyRshFA=;
 b=WcLKp/fjIDNK7CH5J1glo5ivBDncswNkgjQbTSqNxI5RzwvA9a9mHs82Y2pi0W0Qje
 gRcgmYCzKb0G1EBLPFwIUp9m486o/pOfOGoJKAw+Kr2DJtYYPS3B+Irl79XAwv0tKLxq
 vATC2KxnMgHQdLo6x8isvZ2SxmG/Zys2a/cpfm/yXFP8wQ3Jt4VqqJmRn0hWKSM6p1kG
 KpyNUSFrT33RT8ILQ1Ir3cVQVQG90+a/V9NKbCjfE5MpJ9qBFWgXSdfjDzUP+dQ5wwgT
 kMpWgHiIRP3phhJOYCJNKLPxdoENorP7EdYZC8E3Nrjq2jV3EnD3/+XZ8eQRwyOmxEBC
 PgAg==
X-Gm-Message-State: ABy/qLahvE1o/ZEKto7cct/myC1WTBRXVQKsdAAChlgzrTFIQWAOc6KR
 2QUkZ1jW/De0TtK6r78lU3VcmpBqKJO9gQIm2jW99eVjINY=
X-Google-Smtp-Source: APBJJlEiHdg3RxoyiF+SroIT6xJvIvEXb80k0Dg/oi4RdVxsKo1WSErOV49qUQHWvhmSSaXlS6kF9myvewM1Up4AKAA=
X-Received: by 2002:a4a:255e:0:b0:567:867e:8702 with SMTP id
 v30-20020a4a255e000000b00567867e8702mr1833015ooe.7.1689954237502; Fri, 21 Jul
 2023 08:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230719051939.811520-3-srinivasan.shanmugam@amd.com>
 <20230720102912.3511-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230720102912.3511-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Jul 2023 11:43:46 -0400
Message-ID: <CADnq5_NjbasHmTA-i5Ok2f8H0dfQwgrM==wPa3OQr3_yeZyEvg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: Prefer dev_* variant over printk
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 20, 2023 at 6:29=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Changed from pr_err/info to dev_* variants so that
> we get better debug info when there are multiple GPUs
> in the system.
>
> 'Fixes: 8e2503972912c ("drm/radeon: Prefer pr_err/_info over printk")'
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/d=
rm/radeon/radeon_atpx_handler.c
> index 595354e3ce0b..fb4d931fdf18 100644
> --- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> +++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> @@ -94,6 +94,8 @@ static union acpi_object *radeon_atpx_call(acpi_handle =
handle, int function,
>         union acpi_object atpx_arg_elements[2];
>         struct acpi_object_list atpx_arg;
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +       struct acpi_device *adev =3D container_of(handle, struct acpi_dev=
ice, handle);
> +       struct device *dev =3D &adev->dev;
>
>         atpx_arg.count =3D 2;
>         atpx_arg.pointer =3D &atpx_arg_elements[0];
> @@ -115,8 +117,8 @@ static union acpi_object *radeon_atpx_call(acpi_handl=
e handle, int function,
>
>         /* Fail only if calling the method fails and ATPX is supported */
>         if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
> -               pr_err("failed to evaluate ATPX got %s\n",
> -                      acpi_format_exception(status));
> +               dev_err(dev, "failed to evaluate ATPX got %s\n",
> +                       acpi_format_exception(status));
>                 kfree(buffer.pointer);
>                 return NULL;
>         }
> @@ -157,6 +159,8 @@ static void radeon_atpx_parse_functions(struct radeon=
_atpx_functions *f, u32 mas
>  static int radeon_atpx_validate(struct radeon_atpx *atpx)
>  {
>         u32 valid_bits =3D 0;
> +       struct acpi_device *adev =3D container_of(atpx->handle, struct ac=
pi_device, handle);
> +       struct device *dev =3D &adev->dev;
>
>         if (atpx->functions.px_params) {
>                 union acpi_object *info;
> @@ -171,7 +175,7 @@ static int radeon_atpx_validate(struct radeon_atpx *a=
tpx)
>
>                 size =3D *(u16 *) info->buffer.pointer;
>                 if (size < 10) {
> -                       pr_err("ATPX buffer is too small: %zu\n", size);
> +                       dev_err(dev, "ATPX buffer is too small: %zu\n", s=
ize);
>                         kfree(info);
>                         return -EINVAL;
>                 }
> @@ -202,7 +206,7 @@ static int radeon_atpx_validate(struct radeon_atpx *a=
tpx)
>
>         atpx->is_hybrid =3D false;
>         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> -               pr_info("ATPX Hybrid Graphics\n");
> +               dev_info(dev, "ATPX Hybrid Graphics\n");
>                 /*
>                  * Disable legacy PM methods only when pcie port PM is us=
able,
>                  * otherwise the device might fail to power off or power =
on.
> --
> 2.25.1
>
