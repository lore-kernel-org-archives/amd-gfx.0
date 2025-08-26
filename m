Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6485BCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 21:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0395A10E3BA;
	Tue, 26 Aug 2025 21:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gjK9CDyi";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD4410E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 21:03:00 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2489359cc48so495525ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756242180; x=1756846980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6X7Rbbxsiq+Gm0o9RIO3UTxLNGg/iAh1dO92sAU/CBo=;
 b=gjK9CDyinX+hcwPJfX9V0/B36gybpUUA/fFXCknBIKTU9MxjeBSKstB8m4Rjqpdarq
 Yzqt3Vi4wtp+PiQ4HYtVcIej0MUsJTPukUkHDA3xf2Dr51qjaKDpbV0gbYrUDAw5v57y
 Fo1U3l0nUn5+gN92S5Kr7T8bF5yqli+gLPegHNLu9pAkVLtR2OrFwNq+q5jfvJl80S2J
 I9jb0hXtz9AN6tNZCxRdSlLeDuFZr6cXskP6M0htqDFOiGm7OmBq7Yt1rqSuqxGyzJvn
 GXor879imT2BlZ59PhH2RD5QYmD8q5Re0LvPsRgiCS2STCOaLPX3H6dHhRwZU9mZs7iz
 XnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756242180; x=1756846980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6X7Rbbxsiq+Gm0o9RIO3UTxLNGg/iAh1dO92sAU/CBo=;
 b=hxjIZX8ejJwy4njLrL7UY6/HgYlCyxZHOklZs7bfEQsGyShiixXHAeqqdnog4Gm/0g
 7jLrwB8FgAGOVV/0HsFBS70Gw7GbqdvuJflF6QzOWAGSNk9QgdLMy9TykCu+yHZQJvxy
 bsvRvaow7AJoXYql5AF0G43LX1oIR8Ii1a91LXB42cHY2Aor35kfkroKWK0w7JNUulFJ
 z5Jtmf+G+3AIjZOl2LhBnoyQHkSHGb1lvgpv8Uui165YFtpQU+NaKcjBhd3wF8DYPUp0
 8HIjI/Mu2RFa3J7apjeRDNVPVWqJKny77M/WfCndH9CNKrl08pd2V4JyxY/XEBm8KhkI
 B2xA==
X-Gm-Message-State: AOJu0YyU6ESmnupK2gp1ILOE4akHcDujlJ/Sf3RbnhlrK7fGsPeAj/rO
 gv+Dn0TdjvBK6sxGUsBevIRc6nnNWHb/v3qSdJ5+I+X295JxnN64Lw7RdbZ7gb9Lz9pWWxJKRNy
 uzfq4rB2q4IeuH0uixhW2RVwLv0TLfadje3ST
X-Gm-Gg: ASbGncuzE+QEuh6FBEIcPI4MeIelftvJjoH5QfA1BzHhcR/q+rUM0CLxCILo9ZdWrdg
 wb2r9KVhO9N6eFqBcrExwtBfrenYRq/0itjnBbS8w4maxnFqLrR55AJTw6tdI3nsuRPwLgUyh+P
 LVX/Ih8dwaiZTymuvrTif/KLh5rXIy5lxa8Yj7ZWCQkshZc5EpVFT5W2l0Kf1qJnmWuJy82Yq7A
 9uvZdM=
X-Google-Smtp-Source: AGHT+IEgyfuNfWknOQntSIxRv0KyW/JP83R/kDXhLImF9aj4yoUa3VU5ZZt/e8frMnEPNzNPBSb5aumUGJup2K4rx6g=
X-Received: by 2002:a17:903:22c8:b0:246:a93c:aa0d with SMTP id
 d9443c01a7336-246a93cacc7mr85186295ad.11.1756242179599; Tue, 26 Aug 2025
 14:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250826193821.869445-1-David.Wu3@amd.com>
 <20250826193821.869445-2-David.Wu3@amd.com>
In-Reply-To: <20250826193821.869445-2-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 17:02:47 -0400
X-Gm-Features: Ac12FXyn-aeeblJcYYBxd7Jyy_WqrMdMESe9BlBIi5e3FDYT3nHiFpF5UbxZfiU
Message-ID: <CADnq5_NY7+j803zjx67OjB4D8z-o4m_y7omOK64Zw8jpb=QH3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: protect potential NULL pointer
 dereferencing
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Aug 26, 2025 at 3:38=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> to_amdgpu_userq_fence() could return NULL which should be
> protected.

Same thing here.  The amdgpu_userq_fence is a container for the dma_fence.

Alex

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a86616c6deeff..01d30544c30d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -297,15 +297,18 @@ static const char *amdgpu_userq_fence_get_timeline_=
name(struct dma_fence *f)
>  {
>         struct amdgpu_userq_fence *fence =3D to_amdgpu_userq_fence(f);
>
> -       return fence->fence_drv->timeline_name;
> +       return fence ? fence->fence_drv->timeline_name : "";
>  }
>
>  static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>  {
>         struct amdgpu_userq_fence *fence =3D to_amdgpu_userq_fence(f);
> -       struct amdgpu_userq_fence_driver *fence_drv =3D fence->fence_drv;
> +       struct amdgpu_userq_fence_driver *fence_drv;
>         u64 rptr, wptr;
>
> +       if (!fence)
> +               return false;
> +       fence_drv =3D fence->fence_drv;
>         rptr =3D amdgpu_userq_fence_read(fence_drv);
>         wptr =3D fence->base.seqno;
>
> @@ -319,8 +322,11 @@ static void amdgpu_userq_fence_free(struct rcu_head =
*rcu)
>  {
>         struct dma_fence *fence =3D container_of(rcu, struct dma_fence, r=
cu);
>         struct amdgpu_userq_fence *userq_fence =3D to_amdgpu_userq_fence(=
fence);
> -       struct amdgpu_userq_fence_driver *fence_drv =3D userq_fence->fenc=
e_drv;
> +       struct amdgpu_userq_fence_driver *fence_drv;
>
> +       if (!userq_fence)
> +               return;
> +       fence_drv =3D userq_fence->fence_drv;
>         /* Release the fence driver reference */
>         amdgpu_userq_fence_driver_put(fence_drv);
>
> --
> 2.43.0
>
