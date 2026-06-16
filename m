Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3D6CD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9F510E89D;
	Tue, 16 Jun 2026 21:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UxCuikS4";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516C010E89D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:58:41 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304d3d3d8f8so634679eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781647121; cv=none;
 d=google.com; s=arc-20240605;
 b=JRSgq70InY0DlB+f9zde0/AYJks3X0lUiJy8Jf18lUOJ0I1TyFnr+blX6CT8cDLthR
 xmad5g4euuwwPw9Xi76rhbkvzXI2Ic3EkqSmlzt9OCw/BFI0U+1/+KQxgZ8cgA6ijM50
 AhIQnpPMsATUpOWluAqUyukFWyuy7yiHk+TvCKUyzJj+87nZpKemKIuRhMU4Fav2FhAD
 4bLlBzaxKvQLa3F0A8FCfDYbTRhGYKwUgWFG8H83x+Oedng27eDXiZadFk1UCHCAdx4g
 99FquSZvX+fC1Xpq69ba3PWWp4cCPOyQjtZZwiVTAUFaDjWlKZt2IaAXgof6bkB340Lb
 wLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ndtAEfsJHD58tnsDSdArQsoc+D7QiD903i4EMK3NlJk=;
 fh=XzVWXv3p8P1Lr43bDTeBz/bNpjcuLsaYL9GQuk4gQB4=;
 b=Zq+IElkeRsA3AnlgGrZUHsPFDVoN7hG/Vh/2J1LEc0eiiyuCKs8FnBdAFIH4Jprf9e
 bPpVgLIGpu6Pga/01w3+RMK/SXamhDCGFAxQmsYHpcq0SW7yiwMLNlswdCB2UenvbrXz
 tzlM+SZgJcxNCHC7SNG61jqYIDUsF905pzXs3E01YylwQRyE7vIDztMDkW8sjJLLFYMV
 0kTsYDsfyZllT9nENyTjGPAp7qZh1Z31+cfpd++nTi4pmlFztXWaDDjv8jPhQRl0/9a3
 5BUh6ViRwrjmZtZYeqIRYw/Nx2V+9bmbRxVrLhAVeQuP2KPH5CAfnFzSEQw2iO6/zx5W
 q+Tw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781647121; x=1782251921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndtAEfsJHD58tnsDSdArQsoc+D7QiD903i4EMK3NlJk=;
 b=UxCuikS4AfbdAKjvSkBKxU7eGcLX8D/wh9Xtc6R2lNbJcMlOapQhuArbNeCdTIZYwi
 Qxke5GExoRyAbvCMAMjgkdxYUKt1FeAtdusNHMX+Rtgd1bdL2gikK/QBPcm2FxzFV+2/
 aZp5UlhgnFpCPqnk1hGotTrQMrc5S2cxLYCMkytUpkkRbf6ZYCVkW5k6fiikiwtaHkeJ
 dZfxaLBcMFhCyyIAC3gXLOXopEo1ZisorrdgnY4k1O8LqqbKDK8lN2Np3qH6vO1MoBXo
 eMiQV+OM1CZ7hI0Lx2BnT5oAVXbtnRM8KjRSvGRBRHHxulDRKePR3qF9V8tEVG40utS8
 cAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781647121; x=1782251921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ndtAEfsJHD58tnsDSdArQsoc+D7QiD903i4EMK3NlJk=;
 b=pZ5mYoNh785uQ05MRohStbojbWb+2cNRfeLfmQn5DK1Viv6V/sZ0kSqnkPA5K2Gp4O
 P64TlYEZ0rzMKDIWj7xOSTq5eMNq0H++qLpCrtoP98WWatYG/nMUsN9QMLUvj7joI1Eq
 D6XNRW7V/lNhikOIzdymMmJx3uC/slzXv0z/Ot7eJK87ssqJ3PlxSi1Xp2SIv2Ja19RO
 +dWTcpUy3ZJWnYcLf8HBJF0ScFdVgBLgQ8G9cm6q44HAhcKj2tQ0xjPBR+/mXxTEFRI2
 s5kWedosfsr7cdtLxFhT+jGg6X0BtOny2cvIeEiNc/7kJu7yOCmoDJvhWdbbMbg7caXx
 K+Og==
X-Gm-Message-State: AOJu0Ywmn8cpgKfs5+nrqlywE/qsplwwvMlMd+VazOsbc40GC8koJbCx
 Bg1iTfvNrm65+piLrsxLGDVOjuENd/xdWMXcIjcQDzk2QUtNfkYa5CimSBuYX2E1R8S04RVQ6Vo
 fhg9Fh3V80WEWHfkTl5eFlS4QDyJcYqk=
X-Gm-Gg: Acq92OHhR2Dmwstd+y/EFKv/gOdStbqAtA9BxpdCXOGX/JmDR1Dt6QQlTHWsQ2MsGKD
 60gr4iopFXvf0+InRCw3p5rxa5HPBg1xIhK9E1W0HwJM8RVaG436SqXz0h1dhPMG8Gyb87ZPPjr
 2yESTgiv5oLnZstEe5XSBnUS5y4dfNmxdMQzvDzcbcaeecKWfaTPtkSvoRRLjKCcup3jacS87LX
 8M5mo3ME7iVo+YMEppSW4j2Pocc6TwEbeizho7k+f3PlPXpJWE+nEjNNXhRvrhYTrWYCAlGqjZE
 6v/S6Ai+FeUslgkfLbckkNEwHg4/ECD09kkznYSvgdq8P+FivJzBE5AL2F0JxfPSwr8fzQ==
X-Received: by 2002:a05:7300:3254:b0:30b:c8bb:5884 with SMTP id
 5a478bee46e88-30bc9f15a7cmr302912eec.4.1781647120545; Tue, 16 Jun 2026
 14:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260616213325.444949-1-xiaogang.chen@amd.com>
In-Reply-To: <20260616213325.444949-1-xiaogang.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 17:58:28 -0400
X-Gm-Features: AVVi8CefFtNXtV2Fxceo3yaCQO-Cfc305Jk_GBXr1cEFJq-L2hrdjuXwIJRUUlI
Message-ID: <CADnq5_O386GSntZCt8jEPFnoe3cxDUjqinA52DAofV2wsGLntg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Guard m->cp_hqd_eop_control setting by
 q->eop_ring_buffer_size
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>
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

On Tue, Jun 16, 2026 at 5:44=E2=80=AFPM Xiaogang.Chen <xiaogang.chen@amd.co=
m> wrote:
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>

This needs a patch description.

Alex

> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 82f194ea2a21..5f8bf87f475e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -203,8 +203,8 @@ static void update_mqd(struct mqd_manager *mm, void *=
mqd,
>          * more than (EOP entry count - 1) so a queue size of 0x800 dword=
s
>          * is safe, giving a maximum field value of 0xA.
>          */
> -       m->cp_hqd_eop_control =3D min(0xA,
> -               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1);
> +       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> +               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1) : 0;
>         m->cp_hqd_eop_base_addr_lo =3D
>                         lower_32_bits(q->eop_ring_buffer_address >> 8);
>         m->cp_hqd_eop_base_addr_hi =3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index dff016c9c65c..7506a1410385 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -241,8 +241,8 @@ static void update_mqd(struct mqd_manager *mm, void *=
mqd,
>          * more than (EOP entry count - 1) so a queue size of 0x800 dword=
s
>          * is safe, giving a maximum field value of 0xA.
>          */
> -       m->cp_hqd_eop_control =3D min(0xA,
> -               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1);
> +       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> +               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1) : 0;
>         m->cp_hqd_eop_base_addr_lo =3D
>                         lower_32_bits(q->eop_ring_buffer_address >> 8);
>         m->cp_hqd_eop_base_addr_hi =3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 51dde2c86eb3..f1f923eb0ea5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -216,8 +216,8 @@ static void update_mqd(struct mqd_manager *mm, void *=
mqd,
>          * more than (EOP entry count - 1) so a queue size of 0x800 dword=
s
>          * is safe, giving a maximum field value of 0xA.
>          */
> -       m->cp_hqd_eop_control =3D min(0xA,
> -               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1);
> +       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> +               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1) : 0;
>         m->cp_hqd_eop_base_addr_lo =3D
>                         lower_32_bits(q->eop_ring_buffer_address >> 8);
>         m->cp_hqd_eop_base_addr_hi =3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 9014912ed82c..a6fff8032dce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -294,8 +294,8 @@ static void update_mqd(struct mqd_manager *mm, void *=
mqd,
>          * more than (EOP entry count - 1) so a queue size of 0x800 dword=
s
>          * is safe, giving a maximum field value of 0xA.
>          */
> -       m->cp_hqd_eop_control =3D min(0xA,
> -               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1);
> +       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
> +               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 -=
 1) : 0;
>         m->cp_hqd_eop_base_addr_lo =3D
>                         lower_32_bits(q->eop_ring_buffer_address >> 8);
>         m->cp_hqd_eop_base_addr_hi =3D
> --
> 2.34.1
>
