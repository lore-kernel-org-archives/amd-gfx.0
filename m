Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC45BEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 15:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705AD10E6A3;
	Fri, 21 Jul 2023 15:32:50 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0233410E6A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 15:32:47 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a43cbb4326so1357487b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689953567; x=1690558367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1UQHbPW47FmjouoRaw08n37uU4/F7dEkce3aqdEMyk=;
 b=VdTac2vQu+mgowOXVdWL/QCZ1Fwb7tVi/y3i7tgxuLj/6IdkkwNKkbd1RQKDk48Jr4
 j0yS0iuf+Emrqun0+bCyAAJ1d+B8zD4lRj+5cLKuiSPf2gho3Y9KYOp35SFgpTVmSTJY
 SPmv0fXZl6mxPa8pnA/ed+vBX3dYBuA6Iq64djnq6OP1E9qYWc6EBZkpvV4VLTpQhZoP
 VBOfXjkVIZMRDYsWE5I/h0UM156s8UIrOS9uM9j9ZK7kyAUfH3DlqPorxzRbo5MFxrjU
 RRKmIfYDcWzICJqAZ8udEg/qBKNoVUiCCYsojHnQUYZEge5qe9HYfEcjusjo/Zd8/216
 /xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689953567; x=1690558367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1UQHbPW47FmjouoRaw08n37uU4/F7dEkce3aqdEMyk=;
 b=CT4EUbkz/jYzuAW2AtVbKLIvV8smWwcAooY/0pNKsQQ9FOCcFQgZ9QvUkS7n6ndBhi
 pGETMv7FzxkXI6jEOkcIxBynwrTpPUjQjB+lj8ilHLxcGzNKqGbxGoz1/N4UMmwBCttD
 9yeSYO/8fq+Giv3x7EgAQCEwr1V5rLjN9QDikSvEveYNlgfaMFOd+CEF3lTWpyz7jQYg
 k5jCuXR38Qciwd5OXCIr2zScX3OmL9qSz5NK8KdvjePgKz3H1jjR1quXcBL9YBGS6eK+
 IPVSDr8s97b2TXBctCS+jkSD3D9SJ85dEKxttyW9cvFETqyghPY9KjLUYe6t0Ovlbegr
 d+VA==
X-Gm-Message-State: ABy/qLbUKXNLjtRSasAdLFCvWCuSNJ4Jsz4w7juWcNEuEQxvTkQ/l5r0
 e4F950Mg3pF++7NM6LiT5c+k0Tf7tMUjZdNFxfDGqFESPnw=
X-Google-Smtp-Source: APBJJlGOHpCzxvXpVLpn72qvNCNwjpnfs0r06NukNk3mJgr2u9iN7k9uTB7CiVlfajcsfEeRic3C6oWJZlWwkefLo/8=
X-Received: by 2002:a05:6808:30a2:b0:3a3:f45b:aa48 with SMTP id
 bl34-20020a05680830a200b003a3f45baa48mr2907879oib.6.1689953567134; Fri, 21
 Jul 2023 08:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230721092135.1484616-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230721092135.1484616-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Jul 2023 11:32:36 -0400
Message-ID: <CADnq5_PnLxhoccjKSKzYocAFMUdExFSXb5WLW2eYgbZsxb482A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Return -ENOMEM when there is no memory in
 'amdgpu_gfx_mqd_sw_init'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 21, 2023 at 5:22=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Return -ENOMEM, when there is no sufficient dynamically allocated memory
> to create MQD backup for ring
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a33d4bc34cee..6639fde5dd5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -407,8 +407,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ade=
v,
>
>                 /* prepare MQD backup */
>                 kiq->mqd_backup =3D kmalloc(mqd_size, GFP_KERNEL);
> -               if (!kiq->mqd_backup)
> -                               dev_warn(adev->dev, "no memory to create =
MQD backup for ring %s\n", ring->name);
> +               if (!kiq->mqd_backup) {
> +                       dev_warn(adev->dev,
> +                                "no memory to create MQD backup for ring=
 %s\n", ring->name);
> +                       return -ENOMEM;
> +               }
>         }
>
>         if (adev->asic_type >=3D CHIP_NAVI10 && amdgpu_async_gfx_ring) {
> @@ -427,8 +430,10 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ade=
v,
>                                 ring->mqd_size =3D mqd_size;
>                                 /* prepare MQD backup */
>                                 adev->gfx.me.mqd_backup[i] =3D kmalloc(mq=
d_size, GFP_KERNEL);
> -                               if (!adev->gfx.me.mqd_backup[i])
> +                               if (!adev->gfx.me.mqd_backup[i]) {
>                                         dev_warn(adev->dev, "no memory to=
 create MQD backup for ring %s\n", ring->name);
> +                                       return -ENOMEM;
> +                               }
>                         }
>                 }
>         }
> --
> 2.25.1
>
