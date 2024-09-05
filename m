Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675EFCD4F4E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 00:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF95C10E637;
	Thu,  5 Sep 2024 00:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQ4aOI5w";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0852010E637
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 00:43:02 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2d871bd95ffso22768a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Sep 2024 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725496981; x=1726101781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6/0+hvw0/ahUckaICSNQ1GNecGI5hv668gSN6Otm1o=;
 b=mQ4aOI5wJ0s52wyJgpr/SmBo7BiCTfpEHaUb5iA37pDidPOPv0lLg+emNTRKPXr4nB
 kYfYZAAk6edzNQj1RqYF0HnnkF4VzL5bIR5kdZUT4V0i6eHLbP0L8pmcI+HkYn/AYCCR
 eI7CAf1MUUASqD/W1rJ2qqyA01r+J89u+IK3Yz5/lQHC1SesGgPFZexry0nzVDwirs0L
 Z1T9du474yL2EroO0ateF209BMxdoR6CZcQSzcdZb8m2v/vTLil9ScgCMeooWhVNl4MG
 1ukpRAU+3Cr2n6BJXatAFN++1UWWmTuchdAkk6kGwfXQ6qvXJ8HnOC2/Ps96k7viNu3b
 /UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725496981; x=1726101781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6/0+hvw0/ahUckaICSNQ1GNecGI5hv668gSN6Otm1o=;
 b=p03UQEJN58TTae3IB/U4CbEgQPoEOTsQ+8P+yUVNaj5ntx/nG3zWlVz6ynfx8UVKDY
 O3QpysWyjqQEu89kpfdj2bnrjBkJrOiVQN++Xop/bIG3FbFceYAGtMKUIqtoe1NV1mEd
 aVB7NI37qC8JIYpbi+Crn7/SwJ3YnUdnaZUexJ7y25/Vy53LDL6zMq5gy2ArJ0qN7xMV
 NVYqZWvEiGdv9F36Kd1PPRncKbiRSVf+7LiKSkCY2eJY7ToRv6wqBaxHqgU+fex/4YKD
 4mfdouUdiHQyFDy6WhwrN13H6SAH9HYa80oyuk03FWF1/vbCWxi+/llmgv73M8aL6q5K
 MjkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR1/t4Q0n5dQkPQ0oUnSSFM4NHkXIruFNjnktW703eD+dMxysgketJIb2kxSnxD1SeLCOp9Rzq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3wZsSApP2qZc90Q3ILSOQIf9a+sv2ak5PmgQr2Uth3I2Jlf/W
 ANXs34dGpWB5pJSF6IH2IoF0nxzu5gfHA9g0ADZNwR04wAD19Ms5NgGD21xvqBMe5QYEVTUKNpM
 3WB+0jP3esCCe7t2rMaZzwbAGhzEKwmNM
X-Google-Smtp-Source: AGHT+IHVppyT5FrhQy1VmEFCaXt0lZkFvc3AKYJd/EaBytIVcUUAlNNhZ3x0bdsRCcDKQfW0vM0x9JHhjJfnQebVHW4=
X-Received: by 2002:a05:6a20:a125:b0:1be:c3fc:1ccf with SMTP id
 adf61e73a8af0-1ccee3aa41emr12010074637.2.1725496981502; Wed, 04 Sep 2024
 17:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
 <20240904132729.1948224-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240904132729.1948224-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Sep 2024 20:42:49 -0400
Message-ID: <CADnq5_Pt2EAmBYgc4Pb1GnjOw6TBE_ouJ+ArxJ-n+1uAwZRZOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/gfx9: Refactor cleaner shader
 initialization for GFX9.4.3
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

On Wed, Sep 4, 2024 at 9:38=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit modifies the initialization only if the cleaner shader
> object has been allocated. This is done by adding checks for
> adev->gfx.cleaner_shader_obj before calling
> amdgpu_gfx_cleaner_shader_init
>
> The changes are made in the gfx_v9_4_3_sw_init, gfx_v9_4_3_sw_fini, and
> gfx_v9_4_3_hw_init functions. These functions are responsible for
> initializing software components of the GFX v9.4.3 engines.
>
> This change prevents unnecessary function calls and makes the control
> flow of the program clearer. It also ensures that the cleaner shader is
> only initialized when it has been properly allocated.
>
> Fixes: 1b66421d29b7 ("drm/amdgpu/gfx9: Implement cleaner shader support f=
or GFX9.4.3 hardware")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 408e5600bb61..abf934863421 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1061,10 +1061,12 @@ static int gfx_v9_4_3_sw_init(void *handle)
>                 adev->gfx.cleaner_shader_size =3D sizeof(gfx_9_4_3_cleane=
r_shader_hex);
>                 if (adev->gfx.mec_fw_version >=3D 153) {
>                         adev->gfx.enable_cleaner_shader =3D true;
> -                       r =3D amdgpu_gfx_cleaner_shader_sw_init(adev, ade=
v->gfx.cleaner_shader_size);
> -                       if (r) {
> -                               adev->gfx.enable_cleaner_shader =3D false=
;
> -                               dev_err(adev->dev, "Failed to initialize =
cleaner shader\n");
> +                       if (adev->gfx.cleaner_shader_obj) {

This check doesn't make any sense. This function is where we allocate
the cleaner shader object.

> +                               r =3D amdgpu_gfx_cleaner_shader_sw_init(a=
dev);
> +                               if (r) {
> +                                       adev->gfx.enable_cleaner_shader =
=3D false;
> +                                       dev_err(adev->dev, "Failed to ini=
tialize cleaner shader\n");
> +                               }
>                         }
>                 }
>                 break;
> @@ -1196,7 +1198,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>                 amdgpu_gfx_kiq_fini(adev, i);
>         }
>
> -       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +       if (adev->gfx.cleaner_shader_obj)
> +               amdgpu_gfx_cleaner_shader_sw_fini(adev);

Is this check actually needed?  I think amdgpu_bo_free_kernel() can
deal with a NULL pointer.


>
>         gfx_v9_4_3_mec_fini(adev);
>         amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
> @@ -2344,8 +2347,8 @@ static int gfx_v9_4_3_hw_init(void *handle)
>         int r;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_siz=
e,
> -                                      adev->gfx.cleaner_shader_ptr);
> +       if (adev->gfx.cleaner_shader_obj)
> +               amdgpu_gfx_cleaner_shader_init(adev);

Same comment as patch 2.


>
>         if (!amdgpu_sriov_vf(adev))
>                 gfx_v9_4_3_init_golden_registers(adev);
> --
> 2.34.1
>
