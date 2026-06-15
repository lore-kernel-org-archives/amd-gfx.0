Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7F7CD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673D910E47A;
	Mon, 15 Jun 2026 15:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HY7OpTEb";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4524310E47A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:29:21 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-59eb57ea1e1so156835e0c.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537360; cv=none;
 d=google.com; s=arc-20240605;
 b=Jte4QCPTZB54a+rQapqS5E9G5EqB1sAHGA0MFIdaxS2+PJ2HrM7EQbXto5XrJ8xSF5
 36T13Ibg6O4OyKFbGAyDKQPyt1F6yDupgoHsDnuI85WiJ3uNLDbjgoL5bYHgzBAmSyFI
 kzDebB3QkAZwFky859seTuEA49lYi2l+LjCqQl5LE8Tcz5amVXD9rIj2kvGA2stxTv3t
 hPzjaD11pg1rkjFEVY8/bLH8Eu2oiGq7SoIrJU8kJHuw9oHw4mj520yg8AUjasWDoQSl
 0/sGz7GlgOgVGFM8m0035DsuqZV+R4V/Um7Rm33MU3nCFkbYuDmDdU11HzPFN6D+6REF
 qr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aoN6lWYItBl+43B0yTS4jTgRv55fC8x5RmVOzgTJg5A=;
 fh=hu6edWbrNIbeIZ0Tkzb9Dvke4+sCsh4tKagiLtEFVz0=;
 b=kqPSQUs/ghlKJ/xiFRB68Dvi16IwFrnfHp4Hk4vNue3eA9EFFMVib5ZP8OrblSJSgn
 uzYAVj/6385D2UJntvMaTIOnV9f44bkrG7as+1xmSqGcpcZfrqJ/ng1+15Zm2DaofNdz
 3a4RI2p5jsDUbjrkB2NPUjrnYOivO39UBSfEbJpOhwSQ8JCcuETD7rogtN4+JSc2VbRm
 CL005aLX88wVHby0K9gZMnxcJ0MUe7nWezAWd3gfbMP5jDv5+jgwerqtVOIBaDZ5kTvV
 oA5xGLLcyBLoYR/TFoFK0CTZXE6+Brot3RPEvUi83q0FirybhphdOLZ9wQxMfvVhVkMv
 yqXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781537360; x=1782142160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoN6lWYItBl+43B0yTS4jTgRv55fC8x5RmVOzgTJg5A=;
 b=HY7OpTEbS9d9KJ2QKzz27ZEMUAPmiznd3nstMlyWcYFmFZC0oNZ1Anm7oOSjZXJAkN
 jbnh4gFze9jWmDk+zdk0wv0Wuwe4VtQpgAjtuUTOybTE1ym39fJt91nASE5VlvYiWgm3
 cjeJrNFxyypeQWATfVD8e96gcOUqJlB3Qymrn0C+AeUvdigY4MiV92Mo6USVQpEhNUjg
 G5LrQu4+A8LlXjFhW45kwckQBUkNM9Yi5uuR05VzBbiVLA1Wxk+DNQeUhBqcXkUzqSro
 eaJ1QCwMer7A6MKWsenJEFl0HlcRMgX+K8d1wOqv0o1G/b6s+NpGWTqQqnndvte2Srue
 C1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781537360; x=1782142160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aoN6lWYItBl+43B0yTS4jTgRv55fC8x5RmVOzgTJg5A=;
 b=p8Fzqc4d96uB0if5hHI2Fz4e355MkfoLS/JfZrKUtsKvnzMFjMxsdKqW9AChX0PYOT
 bLR26HDyMu/m5h0FsKGd30LQxQYv/raXNzdeM5BVyYYiFhKRrOh30YMLX3UMm1dDTELW
 r0KzRjczPIWoU1lsXOwkT2sj61p4y4dy+U4+V/3GaIEPwvEc06PIiPhm3LDDIp5805bL
 GFssdzDNpnZnqI47bydDs2wRlvXHrDCGgVRzISwCm67tgqeV4g28FlOiLU+brTQPrT77
 uY0eaUVUPlePcnhBYrupgANUsm4Nu686yEUDthDCibDjv9gJvqeA9ADMHpdOzTPxt04+
 KRyA==
X-Gm-Message-State: AOJu0Yx73FNgKrPx9O6tNYphnJKovjP8MfcVzoHF3671IVTH/nE1EU1C
 H1jyqUTp7P/029m7wAKaxxA2J96D8aqviJvNaxFLub3+gv3qIuw63assMMD8qugXcnOOG6SMrJQ
 FrfB5x9OvQIN1ja1Inxg+f3EpDadqQNA=
X-Gm-Gg: Acq92OHIwTbyn28shN9f3jhrRxidJAmJ9jjLQw9Y1b0V+bnMIfa/xoZ/XMxrT8Yh6nn
 SeReYH3vsrmn41HDhcl4ZDT9kGNoCcFzit3RfLpH0gmBGS26hZT8jO7V7NXltTRGI0yJap2PTol
 K3He6j7LltTlUopLq+C4finJBYszVaQ+xIWCToA73mH2BslxeXnPlvBXiilgTluxIGtrH9N3RwA
 xMwMOxn4u64uIKmhCPBqFshFEHSvjYfDZMqk5pORBFfiUGf3tAq0Mq9D7inonrw0Oq6ZrEXNgCF
 mBmqiFBAxkD2xZdgfIgniZh6abckrk2PjAAMAIazhKBxA2/4SkiBQQnHnqhyL+3aATggKQ==
X-Received: by 2002:a05:6102:9d2:b0:6d1:8f7:18a5 with SMTP id
 ada2fe7eead31-71e88ba198emr2368169137.1.1781537360239; Mon, 15 Jun 2026
 08:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260615052030.42134-1-lijo.lazar@amd.com>
 <20260615052030.42134-2-lijo.lazar@amd.com>
In-Reply-To: <20260615052030.42134-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:29:06 -0400
X-Gm-Features: AVVi8CdzD-KkK9MiPC_WNxVlQnq-VonVSpRtEOiC4XQ5Y7azKxIgoAwSaGg-YOQ
Message-ID: <CADnq5_NJqw6bL=XNc+0B9JdHriYOfmJ-AYQObN7HanP=DXxSSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Validate ATPX buffer length before use
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, candice.li@amd.com
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

On Mon, Jun 15, 2026 at 1:21=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add amdgpu_atpx_buffer_validate() to check that the returned ACPI
> buffer is of type ACPI_TYPE_BUFFER, is large enough to hold the u16
> size field, and that the BIOS-reported size does not exceed the actual
> allocation length or fall below the minimum required by the caller.
> Use it in VERIFY_INTERFACE and GET_PX_PARAMETERS callers.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Assisted-by: Claude Sonnet (Cursor AI)

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 33 ++++++++++++-------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index 3893e6fc2f03..e2a4644896ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -89,6 +89,15 @@ bool amdgpu_is_atpx_hybrid(void)
>         return amdgpu_atpx_priv.atpx.is_hybrid;
>  }
>
> +static bool amdgpu_atpx_buffer_validate(const union acpi_object *obj,
> +                                       size_t min_size)
> +{
> +       return obj && obj->type =3D=3D ACPI_TYPE_BUFFER &&
> +              obj->buffer.length >=3D sizeof(u16) &&
> +              obj->buffer.length >=3D *(u16 *)obj->buffer.pointer &&
> +              *(u16 *)obj->buffer.pointer >=3D min_size;
> +}
> +
>  /**
>   * amdgpu_atpx_call - call an ATPX method
>   *
> @@ -179,15 +188,15 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx =
*atpx)
>                 if (!info)
>                         return -EIO;
>
> -               memset(&output, 0, sizeof(output));
> -
> -               size =3D *(u16 *) info->buffer.pointer;
> -               if (size < 10) {
> -                       pr_err("ATPX buffer is too small: %zu\n", size);
> +               if (!amdgpu_atpx_buffer_validate(info, sizeof(output))) {
> +                       pr_err("Invalid ATPX GET_PX_PARAMETERS response\n=
");
>                         kfree(info);
>                         return -EINVAL;
>                 }
> -               size =3D min(sizeof(output), size);
> +
> +               memset(&output, 0, sizeof(output));
> +
> +               size =3D min(sizeof(output), (size_t)*(u16 *)info->buffer=
.pointer);
>
>                 memcpy(&output, info->buffer.pointer, size);
>
> @@ -258,15 +267,15 @@ static int amdgpu_atpx_verify_interface(struct amdg=
pu_atpx *atpx)
>         if (!info)
>                 return -EIO;
>
> -       memset(&output, 0, sizeof(output));
> -
> -       size =3D *(u16 *) info->buffer.pointer;
> -       if (size < 8) {
> -               pr_err("ATPX buffer is too small: %zu\n", size);
> +       if (!amdgpu_atpx_buffer_validate(info, sizeof(output))) {
> +               pr_err("Invalid ATPX VERIFY_INTERFACE response\n");
>                 err =3D -EINVAL;
>                 goto out;
>         }
> -       size =3D min(sizeof(output), size);
> +
> +       memset(&output, 0, sizeof(output));
> +
> +       size =3D min(sizeof(output), (size_t)*(u16 *)info->buffer.pointer=
);
>
>         memcpy(&output, info->buffer.pointer, size);
>
> --
> 2.49.0
>
