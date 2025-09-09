Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADD7CAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 13:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC27310E705;
	Tue,  9 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnIZyyT9";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999B010E707
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 13:06:33 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-24498e93b8fso11005315ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757423193; x=1758027993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCRhKSwPG7CAUIvZCPIlLSCZ3YprR/xiUPz/bvHEoWk=;
 b=nnIZyyT9Ce657fehbZ8fCiyYSe0EVoSMwlDo36kvqafnNhRFpdfcRWMHSqbHowGilf
 D84M0z011aRLuODgWDsuFjkP7K38lJyIKet/zgw+cit0uJKL2gJ13AIRZTWTg4VJAD9L
 WWnD1SWtmD6GogZFrdWP5ls0fWy0v7SmvEpvF1EMumIpqnhV0z0GouSDAWodyY/KFt3w
 uaJf4jCSRw2mR00yQtan+CBaZxNJOf4HxDheJRgS42ct9Ygb2iXgYr2lCLlK/BiW5kZy
 70bgs9n08kCodzdpDcUVPAWAd4LhDZzDOkiv8oVQe3xn7B03dOT8cmugMkSNuSHcYj93
 LwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757423193; x=1758027993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCRhKSwPG7CAUIvZCPIlLSCZ3YprR/xiUPz/bvHEoWk=;
 b=Z0wC5mWrbZGtiXGRfUf7Z0uD7orvdFoizhTRIO0dEDO7C5i/De5PD3EidmVfj97CX3
 rAQIvxJ+Jh+C7X0Wst4kKZPIhch3XcEZBUQqZt8Zx2mJJlLQY3r0rRDFV6w2X1gsy7+K
 vTcm7DUsO+H/MCzcDfwFySdIUHuqLuGZQ2/S188G+5Gwk49X7nwMujcLUF7TF58QSjlw
 z/VGTxE7NWhubYogCfStV0JTBGn6rr6HnAFlvvDUVXYG0NFhjIdOwe2HbTa3+YqKuPUY
 lISawESNsiyD3gBhDpoPkGOlgWeXrZLImyzQeHi5HIisPsrovG0eOSmSA+sK0uZl87KE
 Hz2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNlWOem9cs7TJeT6pr/lFo2VBgCCME9smCPC6Xg6uDKMyWMras0iwuMufHXqCIGFaHa67GryEu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG+8J1+V0bPni0z2OoCD4Zmm+ceH3eTsYz4Imr0iYZeki2Fp/g
 HePv728+7y8HEkPxqRPZbshpvns/QD53QiSCEEvAxwqD5Cqr/16Lmxb9SSMeML0AZ3XiUat2FsG
 Hshj8AWEDHaVKoLMkJdkIRZ4vWGOHTWE=
X-Gm-Gg: ASbGncsQbH68GFvd6dwG/0+vsLoBA2sxgnutmEymDoNQ7ESveJONSeJW84iraKAGT0B
 ZknTFjkp725Tnzb0gZlk7lZpZasE7wNV/fyIkBC4XQr4K3nWfDciJsNTEP8ecdPqdXgPxT+WSt3
 ZAuJu2cF7fSAIJNChvwWYUGA0IORBGZytf96/swz69b/pf2Nst3SlpssMuJK7bj2YDNQWHleZbD
 I5TPtU=
X-Google-Smtp-Source: AGHT+IHa8baY6Pl1flgTs6pP2dTZu9WNTAlY3N3JvHJNZ3zkp6rEoHwCNUfHmb5TxMZbd3mIXJZz9XbwZBZNyfQuoI8=
X-Received: by 2002:a17:902:8ec5:b0:24d:5f38:ab67 with SMTP id
 d9443c01a7336-2517653b8f5mr64653695ad.11.1757423192955; Tue, 09 Sep 2025
 06:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250908213156.565861-2-thorsten.blum@linux.dev>
In-Reply-To: <20250908213156.565861-2-thorsten.blum@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 09:06:21 -0400
X-Gm-Features: Ac12FXwSeHW2KQ319aeqOCaDVZwYWCXWouptpaWLQeAEdAJOVtD4BE9k9jsqKMo
Message-ID: <CADnq5_PwxJ5ErFrMzAo1ocK=rQi81G9iLMPpPM9T51_txrp3yg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Replace kzalloc + copy_from_user with
 memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  thanks!

Alex

On Mon, Sep 8, 2025 at 5:49=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify kfd_ioctl_set_cu_mask().
>
> Return early if an error occurs and remove the obsolete 'out' label.
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 828a9ceef1e7..5d58a7bf309a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -521,15 +521,10 @@ static int kfd_ioctl_set_cu_mask(struct file *filp,=
 struct kfd_process *p,
>                 cu_mask_size =3D sizeof(uint32_t) * (max_num_cus/32);
>         }
>
> -       minfo.cu_mask.ptr =3D kzalloc(cu_mask_size, GFP_KERNEL);
> -       if (!minfo.cu_mask.ptr)
> -               return -ENOMEM;
> -
> -       retval =3D copy_from_user(minfo.cu_mask.ptr, cu_mask_ptr, cu_mask=
_size);
> -       if (retval) {
> +       minfo.cu_mask.ptr =3D memdup_user(cu_mask_ptr, cu_mask_size);
> +       if (IS_ERR(minfo.cu_mask.ptr)) {
>                 pr_debug("Could not copy CU mask from userspace");
> -               retval =3D -EFAULT;
> -               goto out;
> +               return PTR_ERR(minfo.cu_mask.ptr);
>         }
>
>         mutex_lock(&p->mutex);
> @@ -538,7 +533,6 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, s=
truct kfd_process *p,
>
>         mutex_unlock(&p->mutex);
>
> -out:
>         kfree(minfo.cu_mask.ptr);
>         return retval;
>  }
> --
> 2.51.0
>
