Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD4CCAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 15:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9115B10E7A9;
	Tue,  9 Sep 2025 15:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHIEMLcr";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B0610E7A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 15:35:28 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b4fb891df86so306621a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757432128; x=1758036928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8GWkB9syykE4BVjFSTAYOdo22xPuq6rOAVZtxlTsOY=;
 b=lHIEMLcrVss/4o5wxBC8zB7vhKAt3W8vWw3qTNYQsFNTI8bVagTurCWiyo7SHlMGFx
 CHq4Lbm5/pok64sZGbpFujSgxrbfb512dA6IM1Q71rQV/knJmIIe9O1phd8PbXtqrc71
 sl/q0SN2qHWWZ6nIM7RrfkRc0XDlJTW8uafeFc0k2FofF9yVfkBX0iY/wH+q+neKhpsM
 x2sIj8Y5P860ntSpXx7qdON1pRumvw1HsSfUIjp5SwCtP0I7UpHsFcvSE7QxfqNgFDMn
 e49HekfGRJCPrY0a+y3g6mVYpmvcP/2piEAe8Zb2iZ6SJyzBdVnZGXPiEMaTeqnAtN9W
 /DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757432128; x=1758036928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8GWkB9syykE4BVjFSTAYOdo22xPuq6rOAVZtxlTsOY=;
 b=CoDRfow3I1l5hcej+cQni0vczF9AD3x2+HG7t8Cc1G66Fr1g77JJHZHmY6qG1dT5vr
 cWenDIrsQIOoGgNQII5xkU1/8zRjz3Cafbvuuhf0PCd0Nhw0/iBrJgNgG8jaReh2dkpB
 IxPl7IenDEwIlZdB71PLCRJzemORCFHKgn4jgPFy+u3TKU0WfZfijqLMlTAeLMqFXR+q
 X+aXRMR5ofPhNSjaAhOQdhuhb31WLNkx4lux1QhfaG73SLVX7EDyUve67r5tX/fVCZJZ
 hskGqUmFMxZd2UY3JrEp1qKG/mqHl5s/z5mi2pJeCZjaQJPXp5efG1pZ5Xy8n+6ChTUj
 0WEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlfcJRBCl9BumpWRsg/TcOGQZ+npNUfQiU+4ZwK7inoHeXfgPGDgGqw68tT3WqDV5cpEHtpqf5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUkMm/erQetJdbp09RR2tGyc1DhVuS0t2B9U40H6lICEePcVgL
 qfhp112nUha2CO1abgdVHVzFFsoTQOmc3wi5u2l5piOrjsWM0nj/48Qow5NIEGiMl4+Xq3n8nBs
 q1w3sPClItGuuhWpD/NhcKcnj59ilXWw=
X-Gm-Gg: ASbGnctkpHagQyBjYm1aNsAYhcJyy8rXOzPZLG76d6yVravCSGQQF43Q/l2BMinDR/8
 zBdxhiPC/7n4giBW7Qqw/0HnRZLmaqGUx6bR8agb7jzikXH4nTkLd0Tr+BOuhjYZP98c3f5pJOd
 qP/yMYmiELB5FtKvp0iVRu0VwR883RUCwlpvRDtX4xsdQI+YVUUfXMMNnkTLnkbsKyrRag5WuBf
 0d6xLI=
X-Google-Smtp-Source: AGHT+IENnQgx9GOpffswO6V15fGtrHaA0nF3KXNRPZySzd62PQEvFKMKh8Wvce7O5KirXBk04iY+MZAgHeWms3DCyOs=
X-Received: by 2002:a17:902:cec3:b0:24c:7bc8:a51c with SMTP id
 d9443c01a7336-25172e31d9cmr94477925ad.9.1757432127744; Tue, 09 Sep 2025
 08:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250909151146.760450-2-thorsten.blum@linux.dev>
In-Reply-To: <20250909151146.760450-2-thorsten.blum@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 11:35:16 -0400
X-Gm-Features: Ac12FXzaPUWMuCN-x-hshy0CTAfSQd8c0YMhaAvVwkLYzaetb5wApp6nywvJXYE
Message-ID: <CADnq5_MFDZdJg3XFFw9+tWB=_LP47PwE3HXgPK=sryOx+_0wGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Replace kmalloc + copy_from_user with
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

Applied.  Thanks!

Alex

On Tue, Sep 9, 2025 at 11:29=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify kfd_criu_restore_queue().
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 22 +++++--------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 7fbb5c274ccc..70c17a12cadf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1004,13 +1004,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>         if (*priv_data_offset + sizeof(*q_data) > max_priv_data_size)
>                 return -EINVAL;
>
> -       q_data =3D kmalloc(sizeof(*q_data), GFP_KERNEL);
> -       if (!q_data)
> -               return -ENOMEM;
> -
> -       ret =3D copy_from_user(q_data, user_priv_ptr + *priv_data_offset,=
 sizeof(*q_data));
> -       if (ret) {
> -               ret =3D -EFAULT;
> +       q_data =3D memdup_user(user_priv_ptr + *priv_data_offset, sizeof(=
*q_data));
> +       if (IS_ERR(q_data)) {
> +               ret =3D PTR_ERR(q_data);
>                 goto exit;
>         }
>
> @@ -1022,15 +1018,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>                 goto exit;
>         }
>
> -       q_extra_data =3D kmalloc(q_extra_data_size, GFP_KERNEL);
> -       if (!q_extra_data) {
> -               ret =3D -ENOMEM;
> -               goto exit;
> -       }
> -
> -       ret =3D copy_from_user(q_extra_data, user_priv_ptr + *priv_data_o=
ffset, q_extra_data_size);
> -       if (ret) {
> -               ret =3D -EFAULT;
> +       q_extra_data =3D memdup_user(user_priv_ptr + *priv_data_offset, q=
_extra_data_size);
> +       if (IS_ERR(q_extra_data)) {
> +               ret =3D PTR_ERR(q_extra_data);
>                 goto exit;
>         }
>
> --
> 2.51.0
>
