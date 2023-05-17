Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343B2C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 20:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D3310E483;
	Wed, 17 May 2023 20:44:05 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937A910E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 20:44:03 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-19a2d231ef1so49981fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684356242; x=1686948242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67BYx7yrWdSxqexEs27YEELduTyHCBSENOPoT1qKD54=;
 b=ZchwA7aad+PXGPP1G/S5joxauy63BuLBopfv78go5LpaxdI3Djh9irnUpZjVFiXbmR
 xpop9muEyHpNFyGg44SbaZ8NX93i6N1atA0dX2kw3kyBEcuSTYMM0Bca3ynQSHj8pQdG
 edlCcsXub0EkgWm6cHIy2vsb1aMo1qrrSqKmoAIicJNpBq6uaRXohuTv8cLMw4YNBNhk
 mtYSd4H1ncYzG6JJx+ZPDbD0I8gRrMuSqYIekKmT+rSsV3wY5UXfTDMCZ7YC/WOn0e50
 sJn22pMK6fK4OEr5p0AlpZjUHoWpj4NeM2EUTHMN9+HewBJbwx/uUqBPMvJ38XtuwnEu
 9mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684356242; x=1686948242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67BYx7yrWdSxqexEs27YEELduTyHCBSENOPoT1qKD54=;
 b=MG1dU6coxY+sjMectB0l0TE61TkjDnizYr1qkwmWoM5Nn2itrZDKiXt4Ni0mhexWiK
 z/VB+wDCnfyIanmKXG2iISijfJnlAgx7On/4kbqvH5cB8xYFYade3onpIlQplYVQSshP
 wQIRUXpK3bIFZjg2LinVgZRwK2Giu+MgCBTryq32SvjTt0LKpLOyFwk4HnmDmJvCaN9q
 xvTX5ur4mwKYH2FzFH41Ol/RCXORG0j+qOWBAC6Fy+wibD3YA7QqHJzkUN/ijVWmvM15
 92p1ym6tfc3sTlZPMBD13xYdFIX252c4TqHaD7iflSNlajVbf59h89f+gHEjDbpvdVA/
 qdug==
X-Gm-Message-State: AC+VfDyZYRb2NCk4nv3+tRJBGMxPL0WTNxzDKz5KGk4r3+rFPVNcjuOA
 KlAMhoDhCuYNzMlGinYHK6HS5Wo03mf3QRFvD5I=
X-Google-Smtp-Source: ACHHUZ6ki946+fYwMB++eJQfcQSSi33LURBw7+nZiU4+LpUy0tShiZPVOZU3/fyLgr5l/s0o8X9M63cOKCezj7U54cQ=
X-Received: by 2002:a05:6871:8602:b0:187:98c4:2766 with SMTP id
 sz2-20020a056871860200b0018798c42766mr87658oab.14.1684356242466; Wed, 17 May
 2023 13:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230517161748.358768-1-Graham.Sider@amd.com>
In-Reply-To: <20230517161748.358768-1-Graham.Sider@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 May 2023 16:43:51 -0400
Message-ID: <CADnq5_Pdt7WT_S4Ofn8T=DfNn=d4CF3tvOJbE1Ymh7GGuszPgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add new gfx_target_versions for GC 9.4.3
To: Graham Sider <Graham.Sider@amd.com>
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
Cc: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 17, 2023 at 12:18=E2=80=AFPM Graham Sider <Graham.Sider@amd.com=
> wrote:
>
> For GC 9.4.3, set gfx_target_version to 90402 for rev 1 and later (APU
> or dGPU), 90401 for rev 0 dGPU, and 90400 for rev 0 APU.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 01a970ca2c5d..8e52b04235ab 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -330,7 +330,9 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *a=
dev, bool vf)
>                         f2g =3D &aldebaran_kfd2kgd;
>                         break;
>                 case IP_VERSION(9, 4, 3):
> -                       gfx_target_version =3D 90400;
> +                       gfx_target_version =3D adev->rev_id >=3D 1 ? 9040=
2
> +                                          : adev->flags & AMD_IS_APU ? 9=
0400
> +                                          : 90401;
>                         f2g =3D &aqua_vanjaram_kfd2kgd;
>                         break;
>                 /* Navi10 */
> --
> 2.25.1
>
