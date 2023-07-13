Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C570EC001DD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 16:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B4F10E060;
	Thu, 13 Jul 2023 16:52:18 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72CC10E060
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 16:52:16 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1b0156a1c4bso624547fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689267134; x=1691859134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0l4aFbs6x1KrEqxzH84MPXoMHlx5s5DolZ4+ZjYbEns=;
 b=qmmL1eyTHEa0kVJY/K9S1cpGVrvr0VfA9kp2uIhaUqpOxChFEJtNp1f5BgLeyJAgrW
 PNcrCoAUm9vpW6WYVOS0QqTnmzNlWTiNccV3OUS1T0ZLG3lMVy1bU5BpPSa0QXdPBrwj
 bVa8/Ea9ybDWUw68UgIGgC4a7LrMAUXazA2rPrf+qLKlnhjgFidtzBBOB6wKIKssLtat
 W4Z32DahO9wBzMVOMt9XilwfdmTXhVLPCkMSo6ga/2azsUEPm1m7IAjlUVztQ6Evps8r
 FNAh8reRj1ZPcE3wCAC5ZT390clUgxESoZdD5vBpJ56LtvcLzpmXXAr47d4A/BOF7QVX
 tr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689267134; x=1691859134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0l4aFbs6x1KrEqxzH84MPXoMHlx5s5DolZ4+ZjYbEns=;
 b=K1NWtEXAtGEjLBtmpi6N7hBVDXlXYaPS7KkL5gpi7W117YtdN9CtK6b0pRrPKu5EyA
 sipKA12CGB11IvkMKzDOtfuIG/HBL0yDBr/yPD6+z6dXgZ/5eC/QY4ceSuAY+CPpgHcI
 zH4NxsRhWXt8GR8vtKr29cf7vHDvqLDSkllYx2zEHKRAA8zqKPTsyXnP40ShjEkx7iEE
 oepfOPXQe8ZcJFtOmwkcTClLLMlKyYjAE4Yutp9rZ4kiCse1evH1VJzpDvA9HK3Nn825
 0iqV7SVgMHCESdipqafU4N4elS74uFmB9mQMUpmOonQcFlKR1e+SoPKZktB7fpjxJs09
 PpWQ==
X-Gm-Message-State: ABy/qLaQoaMEOWEUkL4kcmYTyugTWRucp5wXzzyYTlFQbk3zYUNra5mQ
 83L82hI/tLlK2zCYxCDgUhTGoWZZek5eYeAVjRQ=
X-Google-Smtp-Source: APBJJlHt+VWn4LIc45IIgI8afUWrMfrikYT1cnOw1aM33a0zt1Tuda62YMuA0fQm9KoeT6f020DzPWppPcLgtJ3N+M4=
X-Received: by 2002:a05:6870:2197:b0:195:f0bb:959e with SMTP id
 l23-20020a056870219700b00195f0bb959emr2360737oae.50.1689267133597; Thu, 13
 Jul 2023 09:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230713051948.3952921-1-saleemkhan.jamadar@amd.com>
In-Reply-To: <20230713051948.3952921-1-saleemkhan.jamadar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jul 2023 12:52:02 -0400
Message-ID: <CADnq5_OHhOzXz2y2V9zvQgRDoJdMnxPDf95iPQ7RjujYHFMnOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: update kernel vcn ring test"
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
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
Cc: sathishkumar.sundararaju@amd.com, veerabadhran.gopalakrishnan@amd.com,
 marek.olsak@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 13, 2023 at 1:20=E2=80=AFAM Saleemkhan Jamadar
<saleemkhan.jamadar@amd.com> wrote:
>
> VCN FW depncencies revert it to unblock others

Alternatively, you could fix it by adding the appropriate firmware
version checks if that is the underlying issue.

Alex


>
> This reverts commit d0edfbe8bc2d18ede8f805c6eb71c63e0b40c1da.
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 5c2aa925dd79..8966ffb2f4a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -539,7 +539,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring=
 *ring,
>                                    struct dma_fence **fence)
>  {
>         u64 addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> -       uint64_t session_ctx_buf_gaddr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->=
gpu_addr + 8192);
>         struct amdgpu_device *adev =3D ring->adev;
>         struct dma_fence *f =3D NULL;
>         struct amdgpu_job *job;
> @@ -553,23 +552,13 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ri=
ng *ring,
>                 goto err;
>
>         ib =3D &job->ibs[0];
> -       ib->length_dw =3D 0;
> -       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data0, 0)=
;
> -       ib->ptr[ib->length_dw++] =3D lower_32_bits(session_ctx_buf_gaddr)=
;
> -       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data1, 0)=
;
> -       ib->ptr[ib->length_dw++] =3D upper_32_bits(session_ctx_buf_gaddr)=
;
> -       /* session ctx buffer cmd */
> -       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.cmd, 0);
> -       ib->ptr[ib->length_dw++] =3D 0xa;
> -
> -       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data0, 0)=
;
> -       ib->ptr[ib->length_dw++] =3D lower_32_bits(addr);
> -       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data1, 0)=
;
> -       ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
> -       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.cmd, 0);
> -       ib->ptr[ib->length_dw++] =3D 0;
> -
> -       for (i =3D ib->length_dw; i < 16; i +=3D 2) {
> +       ib->ptr[0] =3D PACKET0(adev->vcn.internal.data0, 0);
> +       ib->ptr[1] =3D addr;
> +       ib->ptr[2] =3D PACKET0(adev->vcn.internal.data1, 0);
> +       ib->ptr[3] =3D addr >> 32;
> +       ib->ptr[4] =3D PACKET0(adev->vcn.internal.cmd, 0);
> +       ib->ptr[5] =3D 0;
> +       for (i =3D 6; i < 16; i +=3D 2) {
>                 ib->ptr[i] =3D PACKET0(adev->vcn.internal.nop, 0);
>                 ib->ptr[i+1] =3D 0;
>         }
> --
> 2.25.1
>
