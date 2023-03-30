Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED67AC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B36410EE49;
	Thu, 30 Mar 2023 14:24:43 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79ED10EE49
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:24:42 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id f14so723393oiw.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680186282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqnBkWuukUQFmEl1rsZH4GarsTTw7m++XEbG5rdfl0s=;
 b=QMgHkBADeZSSHEY/hURh55jZBZ3nuapdR6RLx7eXqRqXeFUhgqahfxzSgWL0mN1T1v
 OmAIAoO1lIPH50Fi3IHUiBNHSF5Vu5XkYMJ7V0uXLaCinYaDe3nBLpam2DsX+fUBjVi6
 2D05j9Gvxfc4d27D7UkIeu5RzhltCQLONn3Ao04PVwYXmgLgYOJmu01jxf7djTVi/3Wu
 uR3Xb61G3I4vBjc1jvwirFeiDC2rd+bCNcUP3k4JtXyz9yfASbFwIt0ZAZ8S2tF6+xqm
 yJzrOronW4Xdo9k0zoOBNA6/gOl4Gzkg0i1T5DiT/AwzkZEKo0G/TJK01HPQbw7Q+gpW
 QpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680186282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqnBkWuukUQFmEl1rsZH4GarsTTw7m++XEbG5rdfl0s=;
 b=OOD3f3yGQDkZTgKYpCvzj078kXmZlBBoz/U9k6q4wRPlmTloVlNQ0EKkJJjPPOVwL8
 S2dsxjWFT9kmyRdK5t3vp4cVJA10J5zUhlnNZwDS6qEDqJjKFnFIoFjZVOWAIcH6zJS0
 /aiXUNCAhxe4tgcEie0pYEm/Dv9iswmVts3+ciN5cP5KZ5mfvuljmvDBQFicGff6OiYr
 sr9YFl5blHs7U4eqs5NhAaXQxPMO/apyEakANAgcoUFZ1LD2YoxecEkrP+jFSzHA9Lbk
 WhMSsnW5zucbEr47tlrQed8AqzG2fHaCjff8UzE5NtJW3704VOa6mSUmCifkZSpPrrlC
 I8Uw==
X-Gm-Message-State: AAQBX9e+VaIuKRC6iF0iE+7EB9qYmX6SJWh4D02WP2LMPF9M4jTZ3CPx
 2mAvFfNM0FTZVInwGU+dkXx90PZjwhhW0VwARbl75n6e
X-Google-Smtp-Source: AKy350YLanJro9yiKBDGK7p/r5aiBmq30ZTl3Lv/qbHlQWJfFdKtFzCNP4dm4qKMnvsUxyY5MKQghfmbQwxlRAFdiv0=
X-Received: by 2002:a05:6808:2810:b0:389:8025:aae8 with SMTP id
 et16-20020a056808281000b003898025aae8mr464571oib.3.1680186281941; Thu, 30 Mar
 2023 07:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-5-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-5-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:24:31 -0400
Message-ID: <CADnq5_Os7esNqf4NWFRAchVbYF4jOc69MjmNzB=nWXE20cUuzw@mail.gmail.com>
Subject: Re: [PATCH 04/16] drm/amdgpu: don't modify num_doorbells for mes
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
> This patch removes the check and change in num_kernel_doorbells
> for MES, which is not being used anywhere by MES code.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 34 ++++++++-----------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 2206926ba289..1aea92363fd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -143,25 +143,21 @@ int amdgpu_device_doorbell_init(struct amdgpu_devic=
e *adev)
>         adev->doorbell.base =3D pci_resource_start(adev->pdev, 2);
>         adev->doorbell.size =3D pci_resource_len(adev->pdev, 2);
>
> -       if (adev->enable_mes) {
> -               adev->doorbell.num_kernel_doorbells =3D
> -                       adev->doorbell.size / sizeof(u32);
> -       } else {
> -               adev->doorbell.num_kernel_doorbells =3D
> -                       min_t(u32, adev->doorbell.size / sizeof(u32),
> -                             adev->doorbell_index.max_assignment+1);
> -               if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
> -                       return -EINVAL;
> -
> -               /* For Vega, reserve and map two pages on doorbell BAR si=
nce SDMA
> -                * paging queue doorbell use the second page. The
> -                * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes al=
l the
> -                * doorbells are in the first page. So with paging queue =
enabled,
> -                * the max num_kernel_doorbells should + 1 page (0x400 in=
 dword)
> -                */
> -               if (adev->asic_type >=3D CHIP_VEGA10)
> -                       adev->doorbell.num_kernel_doorbells +=3D 0x400;
> -       }
> +       adev->doorbell.num_kernel_doorbells =3D
> +               min_t(u32, adev->doorbell.size / sizeof(u32),
> +                               adev->doorbell_index.max_assignment+1);
> +       if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
> +               return -EINVAL;
> +
> +       /*
> +        * For Vega, reserve and map two pages on doorbell BAR since SDMA
> +        * paging queue doorbell use the second page. The
> +        * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> +        * doorbells are in the first page. So with paging queue enabled,
> +        * the max num_kernel_doorbells should + 1 page (0x400 in dword)
> +        */
> +       if (adev->asic_type >=3D CHIP_VEGA10)
> +               adev->doorbell.num_kernel_doorbells +=3D 0x400;
>
>         adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
>                                      adev->doorbell.num_kernel_doorbells =
*
> --
> 2.40.0
>
