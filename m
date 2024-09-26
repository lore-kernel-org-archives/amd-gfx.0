Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEB8CEBF7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 07:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8772D10EC3C;
	Fri, 27 Sep 2024 07:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nfqw8VxT";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A20610E08A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 20:12:07 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-718ef6a26dbso83532b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727381527; x=1727986327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLjykJsQ4x+5Lb+HzZJC+oFplo4HI/PY7cWne//Og58=;
 b=nfqw8VxT4pbikcF/X3kYsuhhYBZh9VCNtWlKp4gkMmQI4jKIEQC1Tk70GMM1NXtP1X
 S9MNJqEVG00Ubw7a9/rVKwscIRYzKYo9oA5Qf90waMklDCSGfsJy6EkyfmWqoA6D2e4C
 hE4MTvF8cUjfg/B0Pg+Ceq+QBDF9Lc0i4m3m2aLj+Q0Tov1p8/H1ryxWwqMWoI459cgw
 uQ1BiLLhu/Uw0XUetzGi/jjGWA6T9tbqKYWW6pmQjUyEy4MaMImcKAELhHbc7wLffkhL
 J0IsPiS361fsliYpPfwxm9E8GP8uq2LU5mXjT75pgX9/5meuIcWEdeK+QGMwjpsmlFz7
 7jJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727381527; x=1727986327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLjykJsQ4x+5Lb+HzZJC+oFplo4HI/PY7cWne//Og58=;
 b=uTj4fXuNcr1LhPU422VaWPdZMB52zKrH7ml0cPhKCMI5bfB/UtqCX1yP2zTm0Jhvie
 fuoOREEtlIc8QNuqH/gCtzJ53qebvIQes6m7ryGxMAtzuYe2WT6e27Z0Gl1xRsW+OmqJ
 0TW6EUj9BfsiGTj+XDeKXpt5x3B4Z7lIpss/DzGYt4PRIj93sjKJkDtvpBDmsiJLgpjW
 w3uV4FZ8y5Mh8fhWBrouPZWdZ7tWLbmu4LS2dmHFWbe9iU7xzQOYgdwEEnCZIr0vhwyp
 z4/JRNXc1n9qyFtA3vKdhCYMMj/QToBgigj9KH+60+ptAY5Zn0Ejp9GP0pp15obYItro
 iXHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbjUjmKsWoWNXCAxC0AKbkMaoJoxj+mwesA4B+JOXmn0nCxzQzLB8aGjSeZXG8qhVIBxWAtV0z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyucFLoxAbW/OZka0IXI6iM5OxtD3Oiopo8j9wDSNkBRLuo8xud
 sT3jxEnBSFZNRZuy5JQxzBnnXcEGO0q5vasNS5GP2b55PrPd6ythNRrUFtg9r7YTl/QfVUYKCx3
 WrL0m9vgpbPZE3DTpQ89IQHDEiZFcFA==
X-Google-Smtp-Source: AGHT+IE/IJfwDQ93njiEdLb9vY4qoADGRjIha8sywi6gaMWQbv/J78aOv+nqNxTQRSv6vgWN8h76GwJhFBJw+8PE3Oo=
X-Received: by 2002:a05:6a20:918c:b0:1cf:35db:2c3c with SMTP id
 adf61e73a8af0-1d4fa60e601mr530568637.3.1727381526564; Thu, 26 Sep 2024
 13:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240925075607.420409-1-Frank.Min@amd.com>
 <SN7PR12MB6932EB1636FC06F28B4E133BE9692@SN7PR12MB6932.namprd12.prod.outlook.com>
 <SN7PR12MB6932ED618E4FF7B1FBB6A5ECE96A2@SN7PR12MB6932.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB6932ED618E4FF7B1FBB6A5ECE96A2@SN7PR12MB6932.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Sep 2024 16:11:54 -0400
Message-ID: <CADnq5_NhUS+P6oMGfRBJ-K2U6vGgprtzr9ycrZ1E6B_h2qmtSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix PTE copy corruption for sdma 7
To: "Min, Frank" <Frank.Min@amd.com>
Cc: brahma_sw_dev <brahma_sw_dev@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Sep 2024 07:38:42 +0000
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

On Thu, Sep 26, 2024 at 4:43=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>
>
> Without setting dcc bit, there is ramdon PTE copy corruption on sdma 7.
>
> so add this bit and update the packet format accordingly.
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index cfd8e183ad50..a8763496aed3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1080,13 +1080,16 @@ static void sdma_v7_0_vm_copy_pte(struct amdgpu_i=
b *ib,
>         unsigned bytes =3D count * 8;
>
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_=
OP_COPY) |
> -               SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR=
);
> +               SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR=
) |
> +               SDMA_PKT_COPY_LINEAR_HEADER_CPV(1);
> +
>         ib->ptr[ib->length_dw++] =3D bytes - 1;
>         ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(src);
>         ib->ptr[ib->length_dw++] =3D upper_32_bits(src);
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(pe);
>         ib->ptr[ib->length_dw++] =3D upper_32_bits(pe);
> +       ib->ptr[ib->length_dw++] =3D 0;
>
>  }
>
> @@ -1744,7 +1747,7 @@ static void sdma_v7_0_set_buffer_funcs(struct amdgp=
u_device *adev)  }
>
>  static const struct amdgpu_vm_pte_funcs sdma_v7_0_vm_pte_funcs =3D {
> -       .copy_pte_num_dw =3D 7,
> +       .copy_pte_num_dw =3D 8,
>         .copy_pte =3D sdma_v7_0_vm_copy_pte,
>         .write_pte =3D sdma_v7_0_vm_write_pte,
>         .set_pte_pde =3D sdma_v7_0_vm_set_pte_pde,
> --
> 2.43.0
>
>
