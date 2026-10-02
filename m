Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1C4CA5FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E78C10F9A5;
	Fri,  2 Oct 2026 19:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtiA6iRa";
	dkim-atps=neutral
Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com
 [74.125.229.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB45710F9A4
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:14:45 +0000 (UTC)
Received: by mail-dl2-f43.google.com with SMTP id
 a92af1059eb24-1431a73fa1eso710781c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 12:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790968485; cv=none;
 d=google.com; s=arc-20260327;
 b=T89ZmoNZwvVKQYd7Pn6odHvQkLNJvMUNX4VeEtefzFAOYJdUx57nmU+t9dO8se0KEJ
 4dRTaldeFLxo7/DuTOqwWxr/yGclywRyIo5GpR/cTYu8uH5K3PJiC4GVRh9pk5eeGROl
 bJrbjrbAdjqJqZeh6wG0ub3iaapclxXUEg/b7gczkGSDh4Wi7U4Q+HBbZaaJgru9pEE+
 7oS9y09YCpfd+qcxgz7p4GCvtEQQ77FhnKYvC/EyNI3Giltprruw/UDFKEJsWECQHGSq
 /G2QCO5H9mzhFmEdmsk6arcABVVTXSCSWM0j+GbHRZiUJFJf7stLtM09LZvqZ45myEEl
 wZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=voU7OB+CZXi4ZHgSiPxmOqD4lJvre4cV7SUx/WB01Kg=;
 fh=WQdKFJunoRjhZzMFAzs3hpTV/2CM9ifF3tDx/DUtCRw=;
 b=fo5Z2/2Vfkwx4F/yjDMvm+4/MLxKQfGmR73ACFKbQb5S8FWzeISDEWuqTRVbZwHr0/
 +EvC8Jb1RDcXMAJBUm7SdsKoaebRgAdDhq8dxvIIK6CpluhDv5D2V5sc0BxQzgIPltP/
 J/ryOjdGoimkQhOVxa/SQzSrBRbJ//fBgruQKWg165giHIQRDbr4AP8CcWu+LSDdxqCz
 y3R2xLNBOFCIJRglgemnuuSoT+yFUP+5W76CESLUbf9KL4vh9tUviBxErumRBxwkc54M
 cUHrY/icMNmwBRBEsGE6E0/Po7mGWk9JV7XQx812nAWDgf88Fn13drjRiE000DRupLCO
 RsUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790968485; x=1791573285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=voU7OB+CZXi4ZHgSiPxmOqD4lJvre4cV7SUx/WB01Kg=;
 b=OtiA6iRaiomODLYz6uSG/KFfrdbEMwJbOvX/Ml9R81lMjQWQ+sXaCrTubFs60PY//0
 likTvYbTKkINo6Bg8x2wE4sBOZyCNOQUV3k85q8PHq6UkTolL+Yt08hlql08Cc2veCxf
 DzXKZl9BwQhvE5YN7A0hYFXFoEcwOl6TfJ5Sfl2IwkuDMmJ2YVAHfAhXVGMV0lCZI+mo
 AWlFRByKNLWh/qwyc8ecFVLHi71Occy6+qs5x2UhjOxgNyTaARtCFBs3YafXHGA5FUXK
 ZrG5mT4xP2RC0zGqxDx2fXyQCbrZw7QvfPqaYXBSLKjMGuCM1ka+yHgNoJgZkQN8/lUz
 VqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790968485; x=1791573285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=voU7OB+CZXi4ZHgSiPxmOqD4lJvre4cV7SUx/WB01Kg=;
 b=FGHEsWOQf9HpXGkHPjFiVKxkvTnaAjaKPENdEPAlprkc/h0/noNVCDOS6PuNb6OUKB
 NDs4rKMaZAcKKY++2fKFZFGK+fwUM4lK75+QuQ9udsLuGjeWUOAwhvwp0NssTMCNYAhI
 vwLxZCIl+QcT8+BhCuexRQFbtUBYVY/LPfcjFIcyJ3E9C57K4/S4sabQKbtJMRLxQpbX
 UFGcMw+RVV9yydc9ecaMf0UFWp3V/bhXQ3XvEF84c3jcadTlTK8KNjRQPPWNjNSPdCla
 l0VykRAouUiJ3nsTW/ZNUFZ2F1ITNfSSniC9deTe7Hev9jW5l/0SQ4P15+ljESgb4Kqz
 PFEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWBqlw3k0W+DI98UeKcxAoJdNa8yWZ6Ud2ydcBByTuMNVb95T8294bHkowNfTWawfHaQTq+DbW@lists.freedesktop.org
X-Gm-Message-State: AFuF++mSeOKRhoQA2xDg25KIH4Xo6xgMNdnQHhNbmY0RCywXUIPn0IdJ
 A4Y8azPNTasAXi20A/WPu8OB2CjWb8+73Z1hVa6QxlDSyCq1rNBMYtZwOOwF6dtBPMXLvYW/Rkb
 eB7vV5lmG4iyVS72FiZSU36XAr6BAYPo=
X-Gm-Gg: AYBFou0zT+NUeavUyeoK+MBPTJReUsuw56xSONEGAOpqRj0Dc9NF4JvL7iN7INa06/7
 BS2C2QmhgHva9Tm2zVu9PpWXMw/oW1z2jDv2gY1Klken5HfSRQaHiboGKfMLLAxXAL9yserN9+S
 vxtqnfi/Bo+6xaZYrHk6jqVJP+DG9p+uCUYlhJbnmOEQl8y/lKrPuNpUKSshPV3encAPYo/jU6P
 xliU+w0DWrc5UCR4vfMJyYlN08PjYiLloMSbvCnoPr21N+J1mPoPuP02pD8vDj7RIVZe5AMGUNH
 WObcmVEFInr1eFXCfR4WxqAmbq7hWdJ0ubE77wdRUXX+m/jPpGzqgC4YqsHj72gS1PiqClT30ia
 FGTfuAo4TNdjHHsoxxzL0v2F8Tnun8zTp0cXuv59IYQ==
X-Received: by 2002:a05:7022:b04b:20b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-14f56063178mr6211422c88.0.1790968484825; Fri, 02 Oct 2026
 12:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261002022927.2023779-1-lihaojie@kylinos.cn>
In-Reply-To: <20261002022927.2023779-1-lihaojie@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 15:14:33 -0400
X-Gm-Features: AclHuK8PKQQPk1kESOt7OcPB_kJ58FIVMzXW3sN4fHbG7TXMREHm7ha7Ma1-Ouk
Message-ID: <CADnq5_NQBVuejzH_NbejF9TMvGOawFiVX1hfgz0CETfAfjvqHg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info
To: Haojie Li <lihaojie@kylinos.cn>
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, 
 christian.koenig@amd.com, xiaogang.chen@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Fri, Oct 2, 2026 at 8:52=E2=80=AFAM Haojie Li <lihaojie@kylinos.cn> wrot=
e:
>
> When kzalloc fails for metadata_buffer in
> amdgpu_amdkfd_get_dmabuf_info(), the function returns -ENOMEM directly
> without calling dma_buf_put(), leaking the dma_buf reference obtained
> earlier via dma_buf_get().
>
> Fix both issues by:
> - Adding an error check after the first amdgpu_bo_get_metadata() call
> - Replacing the direct return with r =3D -ENOMEM and goto out_put to
>   ensure dma_buf_put() is called on all error paths
>
> Fixes: f54ce9e8cbd3 ("drm/amdkfd: Let driver decide buffer size at AMDKFD=
_IOC_GET_DMABUF_INFO ioctl")
> Signed-off-by: Haojie Li <lihaojie@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 054870e9078d..ca5860e493a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -598,14 +598,18 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_dev=
ice *adev, int dma_buf_fd,
>                 /* first get metadata_size by buffer =3D NULL */
>                 r =3D amdgpu_bo_get_metadata(bo, NULL, 0,
>                                            metadata_size, NULL);
> +               if (r)
> +                       goto out_put;
>
>                 /* user buf_size is bigger than bo metadata_size
>                  * allocate a buf at kernel space and copy */
>                 if (*metadata_size <=3D buffer_size) {
>                         *metadata_buffer =3D kzalloc(*metadata_size, GFP_=
KERNEL);
>
> -                       if (!*metadata_buffer)
> -                               return -ENOMEM;
> +                       if (!*metadata_buffer) {
> +                               r =3D -ENOMEM;
> +                               goto out_put;
> +                       }
>
>                         r =3D amdgpu_bo_get_metadata(bo, *metadata_buffer=
, *metadata_size,
>                                                    NULL, &metadata_flags)=
;
> --
> 2.25.1
>
