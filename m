Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C12EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 15:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A96310E0A8;
	Wed, 28 Jun 2023 15:02:15 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD27310E0A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 15:02:13 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a0423ea74eso4305709b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687964532; x=1690556532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGzW8FzN/KASNhpXZHFTqNFjY/TB+0mnfKeWBJKHX6k=;
 b=T8VTZTQzO/AC4qmqjTpO0TST/wuScCJtddN+mSsxDZzlGYC5DM0oIDW6vHv+fDq2HR
 xNSXVMpM4/Ru3z4KOZtKBe91soyV8AGQ+QFwYNONi9BweuNXKeP6jc0c/QnbcRhPNbXS
 jX+58Zjdlfqtwz2kVtFW59jb8HWH+4wdSdgWyAqi/ZOiP97SQDmaw8nm4/3RCIOHAU68
 PWqrYqxcdjurBh4xyE02zEynmzrBg67XWV0b+oD8vt2AF/yyrxusiHqyc0FU0Ut+W4Lw
 5kDA+2Q51aiopjPcqGSxSrgzpbAgkZrCodMd7egXBUeQGDMzosZDFTAWWxhvkDjn/GKS
 rNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687964532; x=1690556532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGzW8FzN/KASNhpXZHFTqNFjY/TB+0mnfKeWBJKHX6k=;
 b=OeFZGDnlCbt5eUJEGQN1fDAm1ze/1ZdjgiDYZDqre/OMmNws8xi/8VCVxY0M1HTlQc
 WYXdLvxY0MzoxauGfq8sS1MBjUdbmUcTo0HTZ8kJutClujJAtrTGfYI1Jf/9ArgpkF55
 ibforNyqS4+wPM57vV+0oci56afXRXA8BcPCEN7FokAr+LYykP/zGzrhCGciT0tk1xHD
 Dg6qT5ZaI7DRqe9+32b2lCReocW1By+9KJuBabipkBLKc9WcX+L94z20MPOdfOpQTWMj
 fPZKfJmp4ir7p5/KszniwiPr2tqDoaNRAg9DTwRIwfc/wBMg4lZUf/v54S/TCdzKzCMC
 R90Q==
X-Gm-Message-State: AC+VfDxj7EHQPdXmGWCShvEdjcMKXT6FSP+iHrWa3oGx745IPQGxAJC6
 MRnrDyI/zAcpL90Re5qE9ZMKEsgHqAf7dey1ZkA=
X-Google-Smtp-Source: ACHHUZ6IsDK41NHuE3CDL09/7S/hAxHea9nCsuQALxpXBQEXbn4XNg33UNHFOX+QK/WPIgfyFlNPa3vl4O6ibSwBKpk=
X-Received: by 2002:aca:1306:0:b0:3a1:ed52:300a with SMTP id
 e6-20020aca1306000000b003a1ed52300amr6948628oii.14.1687964532273; Wed, 28 Jun
 2023 08:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230628134500.24444-1-christian.koenig@amd.com>
In-Reply-To: <20230628134500.24444-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Jun 2023 11:02:00 -0400
Message-ID: <CADnq5_O3EZ3ucoTxo4m_ADaoMehzUd1Yp-wLikJWMDjo=V6Ygw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix potential fence use-after-free v2
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
Cc: shanzhulig <shanzhulig@email.com>, shanzhulig <shanzhulig@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 28, 2023 at 9:45=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> From: shanzhulig <shanzhulig@gmail.com>
>
> fence Decrements the reference count before exiting.
> Avoid Race Vulnerabilities for fence use-after-free.
>
> v2 (chk): actually fix the use after free and not just move it.
>
> Signed-off-by: shanzhulig <shanzhulig@email.com>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 2eb2c66843a8..71a9c4ab905f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1624,15 +1624,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgp=
u_device *adev,
>                         continue;
>
>                 r =3D dma_fence_wait_timeout(fence, true, timeout);
> +               if (r > 0 && fence->error)
> +                       r =3D fence->error;
> +
>                 dma_fence_put(fence);
>                 if (r < 0)
>                         return r;
>
>                 if (r =3D=3D 0)
>                         break;
> -
> -               if (fence->error)
> -                       return fence->error;
>         }
>
>         memset(wait, 0, sizeof(*wait));
> --
> 2.34.1
>
