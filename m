Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951EDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 13:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BAB10E0D2;
	Wed,  1 Nov 2023 13:20:50 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4159B10E0D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 13:20:48 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1dcfb2a3282so4517927fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Nov 2023 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698844847; x=1699449647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIoVZZExMOM8DUFU6LqHvxnG8R0o07LXaWVCfHLtBsU=;
 b=ey+CayoEHbsd7JrAfs9A1Q8tXXlK1YQS6Gmnff0UsT/LRWuMTfi7CWGYyL8RCJgvy7
 A2wQYb47mAgY3ZimOvF2V/ke9nXY9oPrEGvsUzXDiY1ts66zLVJFwlJi6IkUOux31ApK
 z1XMKLNakWxw2EJmOKOPKGdZP6PjDY94lQcTD09VzE+Onsb4RedEwJ38hPIvA02r6Agj
 v2h5NqDv6wNYT+aYEhnmwQ7Jsj/NRevpY/lRmuXEBkIi3OVWx0TReO3ODVa4XeOZOieW
 z5FXMLick97lwspIUQ/N/ZKWmXwsB7HeW9kgMz1gvO8V1n0mS55MpHx/k0B/swfUjC4f
 jnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698844847; x=1699449647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIoVZZExMOM8DUFU6LqHvxnG8R0o07LXaWVCfHLtBsU=;
 b=sdWFQXP56ZuCTr59ovhZkw9WVWU+GhXgAA7/BLjZ7mX26le9AM+pzxWdKPeWchlt8o
 4Ucp1yEBUsAKkTu+9BiARHti5RbxvUO+6x1qQ6rPc2DVQjJIO7mQqyNd9IiGnZDGDLsZ
 U+1luwUKvJrt15m6mGkXMqb8RLjWmb7iH/ad/i/WnempZN4/PvELJQU/nln1Iijp479A
 5TaRy4iJZrtwwCgx7Du3WbOnVNN0d394lfMMJKa1sM8w5F6dbLXXQZm5S2n/+P197Jy2
 dnI6WliCntcq3HGyCx74r5rtOfTET3vc/zB4uMUgbe/H0DtSGLo7LlU6yIxdkgrvugMB
 3Guw==
X-Gm-Message-State: AOJu0Yyb3FeE9FJNTK4vJTtnFb1A8IO6nnyqqr8u1VS7Ab8r7Yc1FmqB
 2HbPJnH6HpRTwe9TNsVmIthS6D28g+4ZCilhpUPp9KT0
X-Google-Smtp-Source: AGHT+IGS+n2eWy9IJgPZBg3bgJAg1Xpu+QATH6jei/BOa63JMa51d2+gFZC7dkmg1eP8G3IxxIw8lIhotbeAQ5G70gc=
X-Received: by 2002:a05:6871:6b15:b0:1ef:c07e:b54c with SMTP id
 zg21-20020a0568716b1500b001efc07eb54cmr9398140oab.57.1698844847462; Wed, 01
 Nov 2023 06:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231101084547.608432-1-Tim.Huang@amd.com>
In-Reply-To: <20231101084547.608432-1-Tim.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Nov 2023 09:20:36 -0400
Message-ID: <CADnq5_OsrxnzZHHX1OJ4T5hHhUBu1qXyv9jGj6nfqdYGRNpKdw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix GRBM read timeout when do mes_self_test
To: Tim Huang <Tim.Huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Jack.Xiao@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 1, 2023 at 5:02=E2=80=AFAM Tim Huang <Tim.Huang@amd.com> wrote:
>
> Use a proper MEID to make sure the CP_HQD_* and CP_GFX_HQD_* registers
> can be touched when initialize the compute and gfx mqd in mes_self_test.
> Otherwise, we expect no response from CP and an GRBM eventual timeout.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 70fe3b39c004..5ff76163ea27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -556,8 +556,20 @@ static void amdgpu_mes_queue_init_mqd(struct amdgpu_=
device *adev,
>         mqd_prop.hqd_queue_priority =3D p->hqd_queue_priority;
>         mqd_prop.hqd_active =3D false;
>
> +       if (p->queue_type =3D=3D AMDGPU_RING_TYPE_GFX ||
> +           p->queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> +               mutex_lock(&adev->srbm_mutex);
> +               amdgpu_gfx_select_me_pipe_q(adev, p->ring->me, p->ring->p=
ipe, 0, 0, 0);
> +       }
> +
>         mqd_mgr->init_mqd(adev, q->mqd_cpu_ptr, &mqd_prop);
>
> +       if (p->queue_type =3D=3D AMDGPU_RING_TYPE_GFX ||
> +           p->queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> +               mutex_unlock(&adev->srbm_mutex);
> +               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +       }
> +
>         amdgpu_bo_unreserve(q->mqd_obj);
>  }
>
> @@ -993,9 +1005,13 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev,=
 int gang_id,
>         switch (queue_type) {
>         case AMDGPU_RING_TYPE_GFX:
>                 ring->funcs =3D adev->gfx.gfx_ring[0].funcs;
> +               ring->me =3D adev->gfx.gfx_ring[0].me;
> +               ring->pipe =3D adev->gfx.gfx_ring[0].pipe;
>                 break;
>         case AMDGPU_RING_TYPE_COMPUTE:
>                 ring->funcs =3D adev->gfx.compute_ring[0].funcs;
> +               ring->me =3D adev->gfx.compute_ring[0].me;
> +               ring->pipe =3D adev->gfx.compute_ring[0].pipe;
>                 break;
>         case AMDGPU_RING_TYPE_SDMA:
>                 ring->funcs =3D adev->sdma.instance[0].ring.funcs;
> --
> 2.39.2
>
