Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6397EC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B94B10E27B;
	Wed,  1 Jun 2022 17:19:20 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C2210E27B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:19:19 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 v33-20020a4a9764000000b0035f814bb06eso460870ooi.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gCXnT7Mk/enAdKvz/7lCRJtJ8ZWmSGVF0KTQBdhaIJw=;
 b=n8I1WwIJab8PxuBp1TCubWdBfDqFhrcuzhLVprKWC8mupTuPU8LxECg8fhBdsKtuaH
 6QbmZLpOjyGComxdO+Kix4KiNUxQMKmdt63RGj612X4Mis8fc9UOut31Q9cP+1r/La5z
 tnVXguNTlJ5YJUeMcwXR6MQeqxvbBtoIbrAHAidfMlP84xZLhoHdn/tZ4ItTxSXbBaar
 XzVrnYXsHVKwflhPa7vWOBRqRf9Ga2AVcZVtAHqimZI+5zuzketKNAmg3I0emfuj1wmh
 FVohbq+UsRQ3A7dZHRjgdXC0Emt81JEI5Emn2Sj3t+cBcDa8JZIlD7BnXVH7Xv33kHGi
 4kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gCXnT7Mk/enAdKvz/7lCRJtJ8ZWmSGVF0KTQBdhaIJw=;
 b=eWQpROMDwzaD2PubqgMfVCDMRKeR/eB84dyYgRVvZ+BcptSqlkJ2/U8zQrtTlflxfd
 v/+FjiLLhESbAsxA/hVaGKZKobDHy6GPy8cqqMNUpJK7719rxjGEelD9o5QwcrrDOKuE
 CNu3N5oRRCxjllay7Umzs1DNgsTm0qlWkVIycYM2cv1I9ymw1IfeM60KDaEtPq6TJ/Wn
 2+d7pHyimcK86sYUyiXQePMD9MF3H0Jy6VUZz52yVTfk58I+oMkoiO/iEKoB2yTlH8Db
 iclARU8zPWAOGTD+GtQD0k1N+1OOuxfLrg92gfcHUeGokXUPqVI5J371EUSgJ+lhiWBB
 P84Q==
X-Gm-Message-State: AOAM532buSXk0jVZQfQoutyKFOCdLeCYwu8/R7vdlnb3O//6jv3eTins
 BDm5zgRvGi0gXSny2hboWBBt0Afvwx9p23ZBrAA=
X-Google-Smtp-Source: ABdhPJwwVsxCjdydbLTqOdK5pvDHQq7eEKoeX6a+3Ak2l209cIwgk2T0/NzdKE0c5YBYZI0j0gJ//6vZnkZ46XGxVzs=
X-Received: by 2002:a4a:d858:0:b0:40e:7d54:1b98 with SMTP id
 g24-20020a4ad858000000b0040e7d541b98mr321542oov.68.1654103958387; Wed, 01 Jun
 2022 10:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220601171005.27106-1-candice.li@amd.com>
In-Reply-To: <20220601171005.27106-1-candice.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 13:19:07 -0400
Message-ID: <CADnq5_O5kGgiK2tRKNLE7YGB-OAGjt9ud4A=13JkVO2_kLObaA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue v2
To: Candice Li <candice.li@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 1, 2022 at 1:10 PM Candice Li <candice.li@amd.com> wrote:
>
> Fix misleading indentation
>

Might want to split this into two patches, one to fix the indentation
and one to fix the missing function call.  Also you should mention the
missing function call in the else case.

> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 99c1a2d3dae84d..424990e1bec10c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -599,14 +599,15 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>                 if (!amdgpu_persistent_edc_harvesting_supported(adev))
>                         amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
>
> -       r = amdgpu_ras_block_late_init(adev, ras_block);
> -       if (r)
> -               return r;
> +               r = amdgpu_ras_block_late_init(adev, ras_block);
> +               if (r)
> +                       return r;
>
>                 r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
>                 if (r)
>                         goto late_fini;
> -       }
> +       } else
> +               amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);

Coding style.  The else case needs { } as well to match kernel coding
style guidelines.

Alex


>
>         return 0;
>  late_fini:
> --
> 2.17.1
>
