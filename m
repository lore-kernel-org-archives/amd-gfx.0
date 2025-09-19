Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196B7CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 20:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE0A10EA93;
	Fri, 19 Sep 2025 20:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hcBM2zdR";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4311310EA93
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 20:29:46 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-24498e93b8fso3248625ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758313786; x=1758918586; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEZ/iF442LdjmNeiPCTSjX/2HXeqzLM+EHeOy4tUP5M=;
 b=hcBM2zdR7dVNNvRY6VD7/CuGAkU+OOiLl7CAKkvoa0XJKnq3JPnkpMgHX0eW54RmHz
 R9aPQ3s8f/xBVCWewy9lA54/5rt47Vf8x7EMge2gztr9+soMe1fqZdXQ4rfv/wPyILra
 0nfY/FskpIMVa+nhr7dYrZLB4Hl72BDZtDw2fEw6kvoa5RoGG2R8z6WDl6DSfJn21vOr
 iVtIgCcWbgpTWfR+RtCD6iMtzxMuNuMGfSdHFPDq16QtnOZomH+E/kQSZzu5abahdxwV
 Y8pOXdvji4TruoRkQSjVdWd/xlV/ZL7ii0M7/b8VIoipmUC26l3zTN7+aukxu622EnVo
 mzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758313786; x=1758918586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEZ/iF442LdjmNeiPCTSjX/2HXeqzLM+EHeOy4tUP5M=;
 b=W2JB4PjTe6d1np5I72JfKozD+75pEpKHhoGva65Ifct0C/MgBt0ZF7yqQaS9ilDqyB
 kArx2ZJUcVxi+XxUQ3DgrZi7xyLknIsBTqMDLTQWJNfST95ybBXIvqzq0fNAOq3Yaqu/
 a7bPjD6g9n7PmRauV7IkZqwIg2Ia2OicodqNKYEyWo6rnpUtgDTVxMxzopnCsQ62kot4
 Ki0TRshy3mggPDH1oscKtG2O5OaEq5o81ySB0Ydf3qMMFbX9Qdv1yNicxxEKHWkahyj3
 p4kZgURPhgFUN7bR0w38bUCcJbB24Ugz0RjPmqaxuHm1k0Rj5eGNmh19gXXYzb1PlxTA
 y14g==
X-Gm-Message-State: AOJu0YxCZGaClTQegakJFLOfx9hClePiFEJMo+w4mJD5sbHAl1AnCHhC
 d925SO424oq+6n99QbN6jCtzzrSKoW2gKFYCUx3ScvbCTJoz1req4o7DiodyB7jum+fczAQA9DO
 vgq06VriEfMYk+1mSobdsvfh/NbB8vB4=
X-Gm-Gg: ASbGncsw5DZVIoFXI1u5NK6eAQTp3/Jy57j8gFD4NsHYfE3sZnrKygLxm7tFVcjeagX
 kHSvHejikeEA0btHLWM6UNcjK4Dg1BAJW9nQ+Jl3eTn3i3G0Nly1GsE8QRmo2JscnKwKLTMb+zV
 rPWcVONc7b17gmN0ij2w3Tlz9x/IUczV0jj4dZbce7DZVW+NcUnVck5ballQgPhEFiMScJvy6Hf
 +GkVis=
X-Google-Smtp-Source: AGHT+IHTFgyu4kGkaHXiK2ViaV1JxDVfd9A/g9oUFbRAusN6f4p9GBFasNjv6NSmklsiE0EsrVYWIZ3oiKuVQOP2x4U=
X-Received: by 2002:a17:903:187:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-269ba517782mr38967195ad.6.1758313785748; Fri, 19 Sep 2025
 13:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
 <20250919081113.2797985-5-Prike.Liang@amd.com>
In-Reply-To: <20250919081113.2797985-5-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 16:29:33 -0400
X-Gm-Features: AS18NWCeqiJc1_H8-4QB0KYuyhlaups_6czvTcMqrnS-CGxtsuPuf_qVDrAWk-I
Message-ID: <CADnq5_Mf4oXonfrigtEe4hbwYSoPndGctg6tqWxCnBC4qsS4Ng@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] drm/amdgpu: validate the queue va for resuming
 the queue
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Fri, Sep 19, 2025 at 4:19=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It requires validating the userq VA whether is mapped before
> trying to resume the queue.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 29 ++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 9cdb82c13a34..402145d64714 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -116,8 +116,27 @@ static bool amdgpu_userq_buffer_va_mapped(struct amd=
gpu_vm *vm, u64 addr)
>         return r;
>  }
>
> +static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue =
*queue)
> +{
> +       struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> +       int r;
> +
> +       list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, l=
ist) {
> +               r +=3D amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor=
->gpu_addr);
> +               dev_dbg(queue->userq_mgr->adev->dev,
> +                       "validate the userq mapping:%p va:%llx r:%d\n",
> +                       queue, va_cursor->gpu_addr, r);
> +       }
> +
> +       if (r !=3D 0)
> +               return true;
> +
> +       return false;
> +}
> +
>  static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping =
*mapping,
>                                            struct amdgpu_userq_va_cursor =
*va_cursor)
> +
>  {
>         atomic_set(&mapping->bo_va->userq_va_mapped, 0);
>         list_del(&va_cursor->list);
> @@ -778,7 +797,15 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq=
_mgr)
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_restore_helper(uq_mgr, queue);
> +
> +               if (!amdgpu_userq_buffer_vas_mapped(queue)) {
> +                       drm_file_err(uq_mgr->file,
> +                                    "trying restore queue without va map=
ping\n");
> +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
> +                       continue;
> +               }
> +
> +               r =3D amdgpu_userq_map_helper(uq_mgr, queue);

Looks like a rebasing issue here.  This should be
amdgpu_userq_restore_helper().  WIth that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


Alex

>                 if (r)
>                         ret =3D r;
>         }
> --
> 2.34.1
>
