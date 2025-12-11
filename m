Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699A6D41D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 18:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0713810E86E;
	Thu, 11 Dec 2025 18:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RENeVNYJ";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C65F10E86E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 18:22:41 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b9a2e3c4afcso36584a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765477361; x=1766082161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGDg24e8SnZdsnphbQI2Mlf6HrSVxd4yhNLEwoECs78=;
 b=RENeVNYJY1sLcO8AgaDQYueXRDE1RnacFmJPxYmqbFySzlblQp34e0KzGv8+Ox7E6R
 dFkLE4Ls71p57xRP3Ro3FYkl7jZeaRHoP/xFJ/bZ9dhMHPRExjOf2YOkBiF50GBAj+ik
 XZZadvQmoGzaG+SEI+6e5/PTzuvy8mQBSgolcbr7mrsiut/gA7OWmzSx6rNkzFYmUkzq
 Ry7xeYgn9aMMCQIJn/DKgWxcXPgwkRozteCzfpJsfkqO+8uB/iQTi5fZA5AHe8n55XSc
 dkhXaRwqXodsShwcBfqVnJiLQTCswv8Y7SpCcze2BhlmL/GrTqdCXa4fDt5KEOsQphTo
 tM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765477361; x=1766082161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kGDg24e8SnZdsnphbQI2Mlf6HrSVxd4yhNLEwoECs78=;
 b=MRD9GhB/p7BI4v4atzTxP8GcCDh54El9iG+ThJyta/6YPyf4A07rC7sjLq4wZqCAk2
 5YXWj140s2Sj6RUIzEvY82U1Fcpj6tRnAvQfquwm7aYVtyL+yp6OpYDzJQPmpX/VyRT9
 BPyhEcuYcIXKzyi/ivN0Lm41XO/LK/WPgeKnSdu3KfsRbgeDPoU8NJIe2PQNm9iwWjp9
 vduFpvHY3o+ceXcUqCfzk6Q8nV8WgkAu3RZH5A4tvkRPicb1+4y91z5JZ2aIjiC33Hfz
 kB9AecjHusQEDRh2/8KvbTofwX8t9feDoGXXcZ0Vzmj51IdqNTTWeHaK1DlsseO5cbXz
 sJyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQf7dsTe1hTXr1OkyIUttRcjFV3ZmOZ9Cn+8VaaBzI3aiOyGZcCfS2oAknEaZ3kZucXiuRrgzl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUk59ANzJ8D5OyTBXEunSe2ZIcRyYrYKPwLSG6K3xtmneJI/os
 dnU292x/Csyhkm4iL2cx5qwDDqCHUYrxm7P2/CMtaJuecIHBzerVIlHjJ8ToAz1edIjgv6lbmX3
 sJOYkcSoct7/YxvDDNFqEA2x1O/oPnjY=
X-Gm-Gg: AY/fxX7cB9qqacI/hEF3j0NWyjQhNznHPbCppo3yzQREXlUlAZiXuh/CR0UY5brlSND
 L22cBzh53dv1CLS/w/1cZBGMLn6lS81zaj14dvXSjAZUefNqO29jQvQbdfkVJumYJKXD5bE9RHF
 cgLG1h8TgowtZpwCvhAIkyLombqvULlhDFpGApT0+Z8jf6u9qD9lA6hZxmKKDYW4CJQf1iMPov/
 ksNafNAzIjOiN8Ts+op+3wPUJ8GMNhv+Cq9CMsqxA+34fc4rPQJiufKqFgKeocl6r9oWy96Hp7d
 +Cb1qQ==
X-Google-Smtp-Source: AGHT+IHN3R5RlK+Lc6yjzdAZHnB+Rh7m2wWR1mNx2oFdB/iu0EUHHZAU+Fn0ByVQntCsqvqyI/IL75Ku/myVU8pHI9o=
X-Received: by 2002:a05:7022:ea56:10b0:11e:3e9:3e97 with SMTP id
 a92af1059eb24-11f296d73d7mr2145259c88.6.1765477360637; Thu, 11 Dec 2025
 10:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20251211173723.82165-1-saleemkhan083@gmail.com>
In-Reply-To: <20251211173723.82165-1-saleemkhan083@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Dec 2025 13:22:29 -0500
X-Gm-Features: AQt7F2r5k1f3UTH21R3jkeiXmd5CyUikk8d1GF5QSny_VGzUWq-cGStQlDL047E
Message-ID: <CADnq5_PR6Hge-LqcypgL=qy5Z=Zp+Le9EmY1mu3G3_haYVdsCA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
To: Saleemkhan Jamadar <saleemkhan083@gmail.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Thu, Dec 11, 2025 at 12:44=E2=80=AFPM Saleemkhan Jamadar
<saleemkhan083@gmail.com> wrote:
>
> This should not be used indiviually, use amdgpu_bo_gpu_offset
> with bo reserved.
>
> v3 - unpin bo in queue destroy (Christian)
> v2 - pin bo so that offset returned won't change after unlock (Christian)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  8 +++++++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 22 ++++++++++++++++++-
>  3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 3040437d99c2..bc7858567321 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_d=
evice *adev,
>  {
>         int db_bo_offset;
>
> -       db_bo_offset =3D amdgpu_bo_gpu_offset_no_check(db_bo);
> +       db_bo_offset =3D amdgpu_bo_gpu_offset(db_bo);
>
>         /* doorbell index is 32 bit but doorbell's size can be 32 bit
>          * or 64 bit, so *db_size(in byte)/4 for alignment.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index bff39dcb4068..f8e66f6e8c09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -586,6 +586,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> +
> +       r =3D amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> +       if (!r) {
> +               amdgpu_bo_unpin(queue->wptr_obj.obj);
> +               amdgpu_bo_unreserve(queue->wptr_obj.obj);
> +       }
> +       amdgpu_bo_unref(&queue->wptr_obj.obj);
> +
>         atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  #if defined(CONFIG_DEBUG_FS)
>         debugfs_remove_recursive(queue->debugfs_queue);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 8b0aeb89025a..f2309d72bbe6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -94,8 +94,28 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *ad=
ev,
>                 return ret;
>         }
>
> -       queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset_no_check(wptr_o=
bj->obj);
> +       ret =3D amdgpu_bo_reserve(wptr_obj->obj, true);
> +       if (ret) {
> +               DRM_ERROR("Failed to reserve wptr bo\n");
> +               return ret;
> +       }
> +
> +       /* TODO use eviction fence instead of pinning. */
> +       ret =3D amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
> +       if (ret) {
> +               drm_file_err(uq_mgr->file, "[Usermode queues] Failed to p=
in wptr bo\n");
> +               goto unresv_bo;
> +       }
> +
> +       queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset(wptr_obj->obj);
> +       amdgpu_bo_unreserve(wptr_obj->obj);
> +
>         return 0;
> +
> +unresv_bo:
> +       amdgpu_bo_unreserve(wptr_obj->obj);
> +       return ret;
> +
>  }
>
>  static int convert_to_mes_priority(int priority)
> --
> 2.43.0
>
