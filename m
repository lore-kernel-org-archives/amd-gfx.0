Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45740C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C325710EEEC;
	Mon,  9 May 2022 14:50:26 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F83C10EEEC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:50:25 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 l9-20020a4abe09000000b0035eb3d4a2aeso2617549oop.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 May 2022 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l8GVQ6AWSjvYXNMikMsGU4XP+3VFDIhtmfbdHby1tIU=;
 b=MAH4/W/EnlsZReUhYlXq7IPFuzRWwZ+GgYW4b/HfcBIMcrlKobSxWTUlvxGfAiC15G
 h0kP/9J6s0OoKyhcRmKB941IevBiWNj8EqLlOhNkSQkcjto8uvFYEdAJ3yV3+2kx3a4M
 fEuJrWvmc6KfneN54ZuAPDwvYbqNDlhuqd7c+LfknkI0IVi9Px1CaCRjS7CaQagyiuZc
 /y/S6zHQxNxMoW4FD3RSW6iVV7miezmXFfkK9eTiqR6SIztxXAIvl22/ACPXsXcnrPYK
 abGOFEIywkytA3+ZeA9PI+osobX9dTVVtPR3BiA2FTqtiWZi9qFKR7Rxj+s0hxaX7/gu
 PWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l8GVQ6AWSjvYXNMikMsGU4XP+3VFDIhtmfbdHby1tIU=;
 b=Lo7M4SZD0/I+bC3ty8SxVOdFN14jotsNLJ4y070haxoofTk57ptAduIWQqQyJci4S5
 Y4XgpMkEJj7hUd1LBToChwUD4MFWo4vq7pZe12+CtBkg/SgefP2Dcrdl30z6HV6UuQ6S
 o/9UEC+jYuddKV8qQhuo/vL0m2Qn/sB+Crxbw83F1GKVBnaK/WxPEhxTmi1m8Bp4YzPS
 7+UCe6e1ku3/npO71K2wBVbsdteuzEn4KiehqqmWrW/3mR3afbXT4Qm04nA0CLQNPkzn
 K1mu5TyUkIRnzldv0gdcmfs7IUkBgtle/J39KiGXoMdjerIm3ezBjwtPA7LWVgCtSgjL
 buHw==
X-Gm-Message-State: AOAM531+hg9q0vYPq+XcXdf4UhtqvvkuZX2QEob8IfW+dYZKPQPJRH8F
 Tsksk2ZRpNpCQyitec0wdGNK9d9po3E7CXLzu0E=
X-Google-Smtp-Source: ABdhPJzVFKnY+vaV0aAQObkc8q5Qx9D28UM0iNcDxV/+JtlTF+4SLXiYvwkyg9gmeEQESIqBWioY2axN1f/mrOeKRVo=
X-Received: by 2002:a4a:4a86:0:b0:35e:a2d3:763b with SMTP id
 k128-20020a4a4a86000000b0035ea2d3763bmr6024003oob.23.1652107824577; Mon, 09
 May 2022 07:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <YnjaIZN/Wj+QvVGP@kili>
In-Reply-To: <YnjaIZN/Wj+QvVGP@kili>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 May 2022 10:50:13 -0400
Message-ID: <CADnq5_NjvWfOq6i0unf1SmfBc_tdE=V5_AEn-ak0C4+4H24cTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx11: unlock on error in
 gfx_v11_0_kiq_resume()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 Wenhui Sheng <Wenhui.Sheng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, May 9, 2022 at 5:09 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Add a missing amdgpu_bo_unreserve(ring->mqd_obj) to an error path in
> gfx_v11_0_kiq_resume().
>
> Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 184bf554acca..92312f7c7f29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4312,8 +4312,10 @@ static int gfx_v11_0_kiq_resume(struct amdgpu_device *adev)
>                 return r;
>
>         r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r != 0))
> +       if (unlikely(r != 0)) {
> +               amdgpu_bo_unreserve(ring->mqd_obj);
>                 return r;
> +       }
>
>         gfx_v11_0_kiq_init_queue(ring);
>         amdgpu_bo_kunmap(ring->mqd_obj);
> --
> 2.35.1
>
