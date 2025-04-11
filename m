Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E68DC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FEE10EC07;
	Fri, 11 Apr 2025 15:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bFx1EFmI";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B5C10EC17
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:52:16 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-af53997ad28so70694a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744386736; x=1744991536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3kWQVdLtjd/iX6tvI+Z1jAfgsWZYiDfUQyGcilLgKk=;
 b=bFx1EFmIzUddPgrzJMCiMG7Pcax5s0+ZkZ7zS5/24JW7m13KlzNKH3u//wR0jcU5HA
 uOmT/C+Y/u6g6oGbjru4spy5RHTtiim9bqPBmVOAVR4gXfCKL0MzhKmSi4F9dUiZvtSm
 UoS1DRkNS1wOILJUgizFQmwsEtYpHizfDCL1ARVnct6MarZyMNqMyX1zgVYfW23t45Pe
 kQLYRk6P/8ChMeD+RKRTH2EdOBEaehQOPRRq/hovTseEXIVRZbAVCR2VMQNcKfsR2CLt
 Bdu5wdkE3goz9QvVMtg4fW0MdWWJ0bEeEl57G6pVYNy+6ZRQO7eM/z2WdPSWbVafLIHe
 sJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744386736; x=1744991536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3kWQVdLtjd/iX6tvI+Z1jAfgsWZYiDfUQyGcilLgKk=;
 b=OyEroichfLuX8tNkH/hkR7hJ/BSzaPVev/oUQWEeAHyJkN0U7PbqbzE6w28seHIvX5
 zur2NkJwJgp9y46+sPUqIcltPOFLTbjaws4mJ85gsICp6LveR0HrdGoZkde4JQPXfN4/
 ACR8A/G66xPM0MiWWjFT8x+/ILHffA7mhlJ/pzMC16C/czx9KVL99M9WcCQcdLJRHYTI
 H69mBzvRoXHHmVKWGjOyHzGcG0BVyYKbKiU88pp30Fpb7xBXuK/4GTmfNUaGlEBH5Uv9
 Kau5Q2rgKF08cnOIehgha6qiEK2DEkw5VYz97b9vEa5okvESchkcUDYGndPWPc3UmE0z
 YTHw==
X-Gm-Message-State: AOJu0YwX2E8uQu2YpogBnKtPTLBI/xz2/iusZ5oCYpOIc1M0y0/mNl3+
 xpJn3HivFKBiva5T9u+gLbZioWdBJ6p7mCS1WWxiEAZHcjKq5kHtw/j9OLY4yqIIJ55HdQXKgiC
 XQ9Q4YYEl1tmX1+TK1Y7zrG5jRl0=
X-Gm-Gg: ASbGncuilgDJVaPfjRD5wWOokq5rU2Uu+cv/JZ+2x7D6oUlBLVyAh5SZox8WA5+8/O1
 gwctmNRhrYkrk6zF5zEoa/kdkvhYXzf6qJHOxkhWRsDX+1FgahawojCTJml0Qq7QDXv1C5vH9Hb
 A+wmXFaXXN5qIJ2AAxsiTfmg==
X-Google-Smtp-Source: AGHT+IFhiGzshlR97q5ebC/0XKzSAZuus73tUUhn+XsxRkjkRFz0i1ipynlfsNiojzKcW74Z9PnqyZ1S1vGI3o0L5OY=
X-Received: by 2002:a17:90b:4b01:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-30823628775mr2323375a91.1.1744386735779; Fri, 11 Apr 2025
 08:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
 <20250411082921.3228498-3-jesse.zhang@amd.com>
In-Reply-To: <20250411082921.3228498-3-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 11:52:04 -0400
X-Gm-Features: ATxdqUFnOwTFzdcmyUQdDsmPf7AWz9TAunjbzS6mUKYhjvGextA6rnFXW3QrfvA
Message-ID: <CADnq5_O8ncMsoS-ciQUh3upi8TZ-p3phooxshjGwcQnFL7hXvg@mail.gmail.com>
Subject: Re: [v5 3/6] drm/amdgpu: switch amdgpu_sdma_reset_engine to use the
 new sdma function pointers
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, jonathan.kim@amd.com,
 jiadong.zhu@amd.com
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

On Fri, Apr 11, 2025 at 4:30=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Replace old callback mechanism with direct calls to stop/start functions.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
>  1 file changed, 4 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index c3c6f03190c8..7139d574c23e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -559,16 +559,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct=
 amdgpu_device *adev, struct
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
>   *
> - * This function performs the following steps:
> - * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their state.
> - * 2. Resets the specified SDMA engine instance.
> - * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU =
to restore their state.
> - *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id)
>  {
> -       struct sdma_on_reset_funcs *funcs;
>         int ret =3D 0;
>         struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instan=
ce[instance_id];
>         struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
> @@ -590,18 +584,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id)
>                 page_sched_stopped =3D true;
>         }
>
> -       /* Invoke all registered pre_reset callbacks */
> -       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> -               if (funcs->pre_reset) {
> -                       ret =3D funcs->pre_reset(adev, instance_id);
> -                       if (ret) {
> -                               dev_err(adev->dev,
> -                               "beforeReset callback failed for instance=
 %u: %d\n",
> -                                       instance_id, ret);
> -                               goto exit;
> -                       }
> -               }
> -       }
> +       if (sdma_instance->funcs->stop_kernel_queue)
> +               sdma_instance->funcs->stop_kernel_queue(gfx_ring);
>
>         /* Perform the SDMA reset for the specified instance */
>         ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> @@ -610,18 +594,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id)
>                 goto exit;
>         }
>
> -       /* Invoke all registered post_reset callbacks */
> -       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> -               if (funcs->post_reset) {
> -                       ret =3D funcs->post_reset(adev, instance_id);
> -                       if (ret) {
> -                               dev_err(adev->dev,
> -                               "afterReset callback failed for instance =
%u: %d\n",
> -                                       instance_id, ret);
> -                               goto exit;
> -                       }
> -               }
> -       }
> +       if (sdma_instance->funcs->start_kernel_queue)
> +               sdma_instance->funcs->start_kernel_queue(gfx_ring);
>
>  exit:
>         /* Restart the scheduler's work queue for the GFX and page rings
> --
> 2.25.1
>
