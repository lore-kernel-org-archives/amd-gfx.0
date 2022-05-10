Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622F6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 14:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D9C10EAC0;
	Tue, 10 May 2022 14:42:58 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F20010F080
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:42:58 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id v66so18751404oib.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rcAUBEzKdRwKsf/J7127bTpT0plvCMsJqAAQNdOc9sU=;
 b=Fk7nEs/JhUkvXHqM5du/LXSCe5f2TRMz0zU8Ks7KS4PUS5UcV78kAZ6NYaNLNzYZlc
 +cz4LX27kWPycKXW8855AJFjcB+ALT+GD+6xJUrgixuCh4LZJnHOssft4Tyl+hlfI2do
 v1sxe+kI+aBVtzCNa0ZFjvV/u8kGB+4jcSjqrE7sa+ajpvnbwyD1bGvH9F8xCZV2cvtP
 B4yicYgwxSKq7p7Amc9WatGWn2GejCV80++waNiglRB9fQLoCqSjoRASVQmWrO+4WCPk
 tkyycN8D3cVkXTCwd4vZuR3SZfSeKy06NHJw8oYe6bKitmCSHvkIeh44M35GNgd5z5z9
 h6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rcAUBEzKdRwKsf/J7127bTpT0plvCMsJqAAQNdOc9sU=;
 b=PyUR/IoE98rhC+NoaR9osMgwfdQJdKUkrgFDdElZen4HrmzrBOvehJDD8vYPMwgKa5
 subSuQ2WaQqmlnKTwnp5Dmi1Fdi3GTwDLUBNyxzSRJG+rOD9No488mid+Pwm04qtTWNZ
 qeFYkNLW78SAoYLXEMS36N6BVmVBM1vT5s3qmoLrcYU706W6QlQhsPSH0gk3wpLIDGKp
 REvQd/UrpomzYUD4ltkS5IRc39pUXNWjRW84GQMTZ5KQyAb2NPU7m00xygkgg/Tuwd1m
 9keuP2pjD4h3ZlZz1g50gwmDi2NDdCb+v70YqAHATop8LcHguqJTBFguDPErVS8XdYh3
 PyDQ==
X-Gm-Message-State: AOAM531WkSTiL8OMJ2+ki+ixeL4KmKuhO4Yn8gD0SwijbRzsU6iGBl43
 1AjExvV0zWwh1ajOF3HqlHyO4/W0oDwRVrzrIQc=
X-Google-Smtp-Source: ABdhPJybqbO6khZDdugfs3OHxwGEATJpSjmMtkg8ndLUBGBb3VtEPezsYFnS61vuZid+yX5OigatdqYc67W4p3xg3Mk=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr185532oiw.253.1652193777595; Tue, 10
 May 2022 07:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220510113649.879821-1-christian.koenig@amd.com>
In-Reply-To: <20220510113649.879821-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 May 2022 10:42:46 -0400
Message-ID: <CADnq5_OkTfJO0KWRpfeoTZpXxU5Doi4Uw0xaHGVLxRVgdCKT2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix start calculation in
 amdgpu_vram_mgr_new
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <arunpravin.paneerselvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 10, 2022 at 7:36 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> We still need to calculate a virtual start address for the resource to
> aid checking of it is visible or not.

Does this fix a known issue or is it just something you noticed?

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 49e4092f447f..51d9d3a4456c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_=
manager *man,
>                         list_splice_tail(trim_list, &vres->blocks);
>         }
>
> -       list_for_each_entry(block, &vres->blocks, link)
> -               vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> +       vres->base.start =3D 0;
> +       list_for_each_entry(block, &vres->blocks, link) {
> +               unsigned long start;
>
> -       block =3D amdgpu_vram_mgr_first_block(&vres->blocks);
> -       if (!block) {
> -               r =3D -EINVAL;
> -               goto error_fini;
> -       }
> +               start =3D amdgpu_vram_mgr_block_start(block) +
> +                       amdgpu_vram_mgr_block_size(block);
> +               start >>=3D PAGE_SHIFT;
>
> -       vres->base.start =3D amdgpu_vram_mgr_block_start(block) >> PAGE_S=
HIFT;
> +               if (start > vres->base.num_pages)
> +                       start -=3D vres->base.num_pages;
> +               else
> +                       start =3D 0;
> +               vres->base.start =3D max(vres->base.start, start);
> +
> +               vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> +       }
>
>         if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>                 vres->base.placement |=3D TTM_PL_FLAG_CONTIGUOUS;
> --
> 2.25.1
>
