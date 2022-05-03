Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6787C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 13:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2FD10FA7A;
	Tue,  3 May 2022 13:03:16 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578BC10F9FE;
 Tue,  3 May 2022 13:03:15 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-e9027efe6aso17049401fac.10; 
 Tue, 03 May 2022 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vZlbwGnaXn6oAOYWqGESYTF6tN7rIghms2IiqrKYN+I=;
 b=Ix1ow94w6UZgM4l+P8oo4tW/SR5UB3joE8cKwSicKirKwWsl/BAj4xqDazgzZvH6a/
 EKDJRTnrrO36mWlmjDAKYbeQpJmBlClwMVXYoRD+le8lOf7m9pA9EwM4lXQELTzYUz4x
 NHqE7MqK9KgXvtpsiW+KqV9NrUcHM8210ivnuq32PSAyKGJPwQTyUTn0K/UijG1BuY40
 8ZjG3bG6A8t9BGyhGqBN7+IHaUu2SRprxCxMgG5SOo7ibgkmUEf5FuJo+4rN/g+rAxZd
 OFsw/UCHbTbx3OjbE7PuyD6HSSr6wH/VAkPP1MVBTfM7IJVsMoQWkecKvAQoChVwRd6/
 DYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vZlbwGnaXn6oAOYWqGESYTF6tN7rIghms2IiqrKYN+I=;
 b=uuFI3MNpi3nCLB8q9Y3facgfI8z5Nq44LtP0aeuH8HETFVKoFHuiyLzVTotGygE3kZ
 e6//sXtkInDkcMBqICBxtgJhmLcFf+H75xGyniYZhaNc57Spsh5yh/IPZXT4VnDov5Dr
 s9M79XBFat/SirM7exgOBW8FH81mk2z6YDbhFz9sv5MKnR/cPuiNANSHVxjk2AmS6LHG
 2uu9R+Qf1hEVZRVRt5+DQXsgXfRDfbOsFNjaFCVFpz/Z+BybN3p5Q3sZ4LWv8uTp4HKH
 Geg2PrKgK/tGOv4/Onyw1CIiZyFOCmVAKK6jKjmuTz+VtciDzFXryC++B2/Dl9TC8yQ+
 Hpfw==
X-Gm-Message-State: AOAM532kXwsOe97DI9iZdLmb6uqbIrLU7MY+Z0oOfDhTU7m/HwFKBs1s
 6PRkHrfvpQ2wAl9RWuLzOq4V1UI2Ind8a5rJUg0=
X-Google-Smtp-Source: ABdhPJxI6Zzt5gh+hyLCY9CEx7L+7WRwQrX8nQyhf3vVNDEHXqPG9m16oH+WSKDEscBywy+YBKqXyV20EWA1t2RJ5OM=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1554880oaa.200.1651582994590; Tue, 03
 May 2022 06:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220503063613.46925-1-christian.koenig@amd.com>
In-Reply-To: <20220503063613.46925-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 May 2022 09:03:03 -0400
Message-ID: <CADnq5_PX91474D=DRxB0VQ3uHY1sGCS_40w9AjCvXSCHgm9Ozg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix drm-next merge fallout
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: tomeu.vizoso@collabora.com, Dave Airlie <airlied@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 3, 2022 at 2:36 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That hunk somehow got missing while solving the conflict between the TTM
> and AMDGPU changes for drm-next.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index 7761a3ea172e..88de9f0d4728 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -631,9 +631,13 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_ba=
se *entry)
>         if (!entry->bo)
>                 return;
>         shadow =3D amdgpu_bo_shadowed(entry->bo);
> +       if (shadow) {
> +               ttm_bo_set_bulk_move(&shadow->tbo, NULL);
> +               amdgpu_bo_unref(&shadow);
> +       }
> +       ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>         entry->bo->vm_bo =3D NULL;
>         list_del(&entry->vm_status);
> -       amdgpu_bo_unref(&shadow);
>         amdgpu_bo_unref(&entry->bo);
>  }
>
> --
> 2.25.1
>
