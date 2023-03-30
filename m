Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C2C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E3710EE71;
	Thu, 30 Mar 2023 14:19:58 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AC510EE71
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:19:57 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-177b78067ffso19875170fac.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680185997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebbyHfZVIIY9FwzOvwZpm+MWXVt/q3eiVTp4wZxS5Jw=;
 b=fUOUFHne7T/q9Box5WZ6Rzau8kT9A/UYpWWFx7K0tTExmvJwalog/d7m3GmqWhh+TG
 Sa3ZBVvoYl3OEBBkpWRQKXN0s1M7L3r26eIsJGCvgPKp9yuvwS1dfyFzMYUpuHsV2Nty
 Nmn7iEiZxNB76ZRWJoraRR0clHPBoDge3PNh10soGID3KqDD6YUD0ZlR3YrVAFu9qx4L
 zRTZ4lWrk38WVE8+GZejJgRpwmZl4UsYQzlxIqd6UiH7fXGu8wCRwy2ha2ssbrCBA3br
 3F/vfIIFl8wWu/TPS/lEzvhA/EkJLrVUPCa6qW1TiYXH7y8BE9r4kGnTPzHr+6qIPm4M
 9yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680185997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebbyHfZVIIY9FwzOvwZpm+MWXVt/q3eiVTp4wZxS5Jw=;
 b=wiTxMd9xrQXky3emrHSY37eb4QQlVSVK1OTtFVIGb1qag2Qaj21bPNm6DIF19tSdKm
 3zHkaQiLFsAQOkjBDCNUijSncutbT1aUg1ghf+uRCfupHIlKYOxGZk110L678Cx11KG3
 AQhigHiZ4/YdDbSKsWyFDWXlLzr6Sc8llniJsCphbfcDQOUgKP5JbJo0usueCOiLlBoQ
 m+98ubzAxniEvh/PDjL2+qxuAgRYdkNoAzNTtdXkr+ZmkjdLJKRanTvThYTFTzuRdUUd
 V9dc+flbTRUBBZDVRnHcnd39e1gHFiWE05s262JJmNyfyWCBeqskDjJKajvEE21yRwy5
 pPFg==
X-Gm-Message-State: AAQBX9dAl5ogin5PWpquebBMWjPVXTop60zP+nxOrK33I2RRI+B++Dli
 K/qJ2A0jNwlTL5xh8jy0lz0A1ps6ZGEo8kZMXaI=
X-Google-Smtp-Source: AKy350aOyxIWjXzdfLNKtOojrSSDVa4DLPhW/eg5Ne0a+UwNI0UZmAR1IXvXTTW5FMYLQcxtlHH4S64V+Fmpc5eZ4P0=
X-Received: by 2002:a05:6870:58:b0:17e:1970:e5d9 with SMTP id
 24-20020a056870005800b0017e1970e5d9mr2367013oaz.4.1680185996908; Thu, 30 Mar
 2023 07:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-2-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-2-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:19:45 -0400
Message-ID: <CADnq5_MqqTz5Z2QVvLtyHkwUyZbW+sX=4NCcEPBqrouFEvs5Vw@mail.gmail.com>
Subject: Re: [PATCH 01/16] drm/amdgpu: rename num_doorbells
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> Rename doorbell.num_doorbells to doorbell.num_kernel_doorbells to
> make it more readable.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 +++-
>  3 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index f99d4873bf22..0385f7f69278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -96,7 +96,7 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_=
device *adev,
>                                          size_t *start_offset)
>  {
>         /*
> -        * The first num_doorbells are used by amdgpu.
> +        * The first num_kernel_doorbells are used by amdgpu.
>          * amdkfd takes whatever's left in the aperture.
>          */
>         if (adev->enable_mes) {
> @@ -109,11 +109,11 @@ static void amdgpu_doorbell_get_kfd_info(struct amd=
gpu_device *adev,
>                 *aperture_base =3D adev->doorbell.base;
>                 *aperture_size =3D 0;
>                 *start_offset =3D 0;
> -       } else if (adev->doorbell.size > adev->doorbell.num_doorbells *
> +       } else if (adev->doorbell.size > adev->doorbell.num_kernel_doorbe=
lls *
>                                                 sizeof(u32)) {
>                 *aperture_base =3D adev->doorbell.base;
>                 *aperture_size =3D adev->doorbell.size;
> -               *start_offset =3D adev->doorbell.num_doorbells * sizeof(u=
32);
> +               *start_offset =3D adev->doorbell.num_kernel_doorbells * s=
izeof(u32);
>         } else {
>                 *aperture_base =3D 0;
>                 *aperture_size =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index afe6af9c0138..57ee1c4a81e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -593,7 +593,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u=
32 index)
>         if (amdgpu_device_skip_hw_access(adev))
>                 return 0;
>
> -       if (index < adev->doorbell.num_doorbells) {
> +       if (index < adev->doorbell.num_kernel_doorbells) {
>                 return readl(adev->doorbell.ptr + index);
>         } else {
>                 DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", =
index);
> @@ -616,7 +616,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, =
u32 index, u32 v)
>         if (amdgpu_device_skip_hw_access(adev))
>                 return;
>
> -       if (index < adev->doorbell.num_doorbells) {
> +       if (index < adev->doorbell.num_kernel_doorbells) {
>                 writel(v, adev->doorbell.ptr + index);
>         } else {
>                 DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", =
index);
> @@ -637,7 +637,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev,=
 u32 index)
>         if (amdgpu_device_skip_hw_access(adev))
>                 return 0;
>
> -       if (index < adev->doorbell.num_doorbells) {
> +       if (index < adev->doorbell.num_kernel_doorbells) {
>                 return atomic64_read((atomic64_t *)(adev->doorbell.ptr + =
index));
>         } else {
>                 DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", =
index);
> @@ -660,7 +660,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev=
, u32 index, u64 v)
>         if (amdgpu_device_skip_hw_access(adev))
>                 return;
>
> -       if (index < adev->doorbell.num_doorbells) {
> +       if (index < adev->doorbell.num_kernel_doorbells) {
>                 atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), =
v);
>         } else {
>                 DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", =
index);
> @@ -1034,7 +1034,7 @@ static int amdgpu_device_doorbell_init(struct amdgp=
u_device *adev)
>         if (adev->asic_type < CHIP_BONAIRE) {
>                 adev->doorbell.base =3D 0;
>                 adev->doorbell.size =3D 0;
> -               adev->doorbell.num_doorbells =3D 0;
> +               adev->doorbell.num_kernel_doorbells =3D 0;
>                 adev->doorbell.ptr =3D NULL;
>                 return 0;
>         }
> @@ -1049,27 +1049,27 @@ static int amdgpu_device_doorbell_init(struct amd=
gpu_device *adev)
>         adev->doorbell.size =3D pci_resource_len(adev->pdev, 2);
>
>         if (adev->enable_mes) {
> -               adev->doorbell.num_doorbells =3D
> +               adev->doorbell.num_kernel_doorbells =3D
>                         adev->doorbell.size / sizeof(u32);
>         } else {
> -               adev->doorbell.num_doorbells =3D
> +               adev->doorbell.num_kernel_doorbells =3D
>                         min_t(u32, adev->doorbell.size / sizeof(u32),
>                               adev->doorbell_index.max_assignment+1);
> -               if (adev->doorbell.num_doorbells =3D=3D 0)
> +               if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
>                         return -EINVAL;
>
>                 /* For Vega, reserve and map two pages on doorbell BAR si=
nce SDMA
>                  * paging queue doorbell use the second page. The
>                  * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes al=
l the
>                  * doorbells are in the first page. So with paging queue =
enabled,
> -                * the max num_doorbells should + 1 page (0x400 in dword)
> +                * the max num_kernel_doorbells should + 1 page (0x400 in=
 dword)
>                  */
>                 if (adev->asic_type >=3D CHIP_VEGA10)
> -                       adev->doorbell.num_doorbells +=3D 0x400;
> +                       adev->doorbell.num_kernel_doorbells +=3D 0x400;
>         }
>
>         adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> -                                    adev->doorbell.num_doorbells *
> +                                    adev->doorbell.num_kernel_doorbells =
*
>                                      sizeof(u32));
>         if (adev->doorbell.ptr =3D=3D NULL)
>                 return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_doorbell.h
> index 7199b6b0be81..12263986f889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -29,7 +29,9 @@ struct amdgpu_doorbell {
>         resource_size_t         base;
>         resource_size_t         size;
>         u32 __iomem             *ptr;
> -       u32                     num_doorbells;  /* Number of doorbells ac=
tually reserved for amdgpu. */
> +
> +       /* Number of doorbells reserved for amdgpu kernel driver */
> +       u32 num_kernel_doorbells;
>  };
>
>  /* Reserved doorbells for amdgpu (including multimedia).
> --
> 2.40.0
>
