Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C0CD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D220210E509;
	Mon, 15 Jun 2026 15:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eg0ww2dl";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073B210E505
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:28:16 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-59eb417a0f6so163621e0c.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537295; cv=none;
 d=google.com; s=arc-20240605;
 b=HpgFaD7r/yqhTUncFzXcnHp55OGafL8OESIl8ZRrv2TYoSUUlxjZWYs9tFq7Rz7mNR
 UFX/DracCMETsf8twyMZZNdqE6syd/ZNP19ilU62wbf0PVdI66x70JNvGfA/OYbuUEdT
 6pff0vCD2sJ6ecK8IdZNRMDDB9GXy1eAsyO7Gniq4W3YOuaVV3akoanSAXJJHOlfJC7a
 3mdgEwywYqYyWvuej3NDMN+cZ9a6tuLtsdX10+OoBd5ZYJlbzMzw0c/QvOXm3pyxXd5g
 mX5n97cgglplU5eBZrtQgAbaMJrOYzA0cn2sDTyjQilW8RXJmEI8kUolI2XaXVCP60VR
 FMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AHpgnn0AVGAtpMrU5jHz2lbnGUAy89HHfAvoIjv6uok=;
 fh=hu6edWbrNIbeIZ0Tkzb9Dvke4+sCsh4tKagiLtEFVz0=;
 b=UKPqpPN4RVRlC3vENV7vcQpZSq2NR9b+GNAhwZYtx3BRgnXVWlW5GqNFYK8sKg2gwr
 QD4Ur8flpLlc4/Ges1rpCzr7l0dmQCNdLCbmb+h8QkoQSJSjWReRAyzOhVJ8pW2zPt+E
 oCo4QEX7gRj3e148VC4InkjhVgJW8c1q9GPy6EIG5and1svaH/wu0jjWy3Ko3SbymJnV
 tvwj/lVqN5oFIi+MWhrrIShyvLsShRdwLIAv2TBUsyHdzOly1mfwB2d4tnrwfoSKCW0n
 DHdzaSbNfYdcWU3aWjeAci+AJny03dFSt0G/br3Kw77qbAn9agHKeptzshYLLmcBcG3h
 QJhQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781537295; x=1782142095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHpgnn0AVGAtpMrU5jHz2lbnGUAy89HHfAvoIjv6uok=;
 b=Eg0ww2dlyGqe1M8IDiv/UFT7sRHkvSv27WICK0Qxf4T1oVRBMvIewG/CpP9CxhRPMV
 2UKKjSU/ZiJQUzDXrDC7JJuGD+n7yybNQmI1KolC/EpabPamlaXoLN1dPONzvQNgYbJx
 mGQEydWRM8XDDFULxbhRO5+lYet6qgMSqBBgV1r+PRmvz1kLk9ZWN5uLN5Ags4RnWfr6
 oZ3DlbEFlAWJlWgAd7fXBW0/GA4BKgxAhQP/q1uTA+4xG8I/8WabpFzrcwANfe/mfpAC
 WbDe5YlWHbnsOx58i3IM8/3CbMzNM9UtDHsmeXrRZZ2L4FHrJYQxX3ly89UEFqcSyjOb
 Qmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781537295; x=1782142095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AHpgnn0AVGAtpMrU5jHz2lbnGUAy89HHfAvoIjv6uok=;
 b=EmO88JjcPLqI3l6hUSi/o12MWoOsMBoJfXTgsPg+j88tVv9ARbsfeJq4lmsXOIIYmP
 p75zb1jEg7gBLtam3gwaPwVV3Yj9xSVFtPsdO9CWw+Jqxoz5zVBqHd9S4SNP+e3on3JC
 Bw0iHuXifAlRTpff9Zzk8lt0JoBAy6KDzpYkgdGesk1LTttdDpbwAM626WEi4jhqZgfc
 ykKK3IfCSEAG9zhjTvy9Ocl9s+2RtxC7PtZH2oEKJ8iT9E9YUD9sYH29I0tmA1EjeqGd
 R7CcS45hfUNUa3DQ2qANXmIog2O5gA0KAW2TojRYhP00+Js/62XkQSFOoN5hK/ThKWy0
 roAg==
X-Gm-Message-State: AOJu0YzwGAPTjol55HeQyWwBwNdBdE38wV0gRfDdKgehLkWGzZcDY8Nc
 ND2MjLzCIu+1ywd1ixqw2gWg1JhK9MbTujrHTQX8VqgwabCuYPbRWRUXakqPGqZlSV5r1QGZfXK
 L7TOHDAiLuVct2Zpl4OsENZk8LqLqslk=
X-Gm-Gg: Acq92OE94i9DZEG/O3bBe/nfqoIBWd10AOKEA/CaZWUYBlPmyI0072hO4PQXzGykje+
 4rbfufTs0RdQGdLXb+3qloeIEfMa/2badZTvlDAh0k+UDTsthP84Jup0K/dB3eUEUKUyue+akFx
 0LQVDXwRyMV+9/hJnDLP4m7h4L2UNCjlgOAm2+eNfLKlDiX72A2i1KuCMT2uZJs50YqKDac0J+b
 7JLhAsn4tgTCUnF8RhtzHpvtcp/PHNjNeqQjHebYqaFNI8/zrifqD7e8XcVw/rZ54bNlYgvd7yS
 2kOsodd2jLq3Mv6cTFofmur3uXFbuMZ98Hnn6i5Z3FaINEaLC9YoDyV3uu9hiyQRA0JGFQ==
X-Received: by 2002:a05:6122:1908:b0:56f:4a47:6c9e with SMTP id
 71dfb90a1353d-5bb6c11e1d7mr2384607e0c.2.1781537295068; Mon, 15 Jun 2026
 08:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260615053911.59876-1-lijo.lazar@amd.com>
In-Reply-To: <20260615053911.59876-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:28:02 -0400
X-Gm-Features: AVVi8CfGF5XvbFt3yFrDxuwAlSNCAldsN10kWrC5WKKc5K8XfYb2Uq9KYqNx2Ck
Message-ID: <CADnq5_Mk3iVk9WTsyXQwfxqjBuv_ANG=74eT7jMd_Htt_HivXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add checks to vbios fetch through ATRM
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

On Mon, Jun 15, 2026 at 2:04=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Check if a valid buffer object is returned after ATRM call. Also, match
> the buffer length against requested size before copying.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index aa039e148a5e..3ebdd792feec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -296,8 +296,14 @@ static int amdgpu_atrm_call(acpi_handle atrm_handle,=
 uint8_t *bios,
>         }
>
>         obj =3D (union acpi_object *)buffer.pointer;
> -       memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
> -       len =3D obj->buffer.length;
> +       if (!obj || obj->type !=3D ACPI_TYPE_BUFFER) {
> +               DRM_ERROR("ATRM returned an invalid object\n");
> +               kfree(buffer.pointer);
> +               return -EINVAL;
> +       }
> +
> +       len =3D min_t(size_t, obj->buffer.length, len);
> +       memcpy(bios+offset, obj->buffer.pointer, len);
>         kfree(buffer.pointer);
>         return len;
>  }
> --
> 2.49.0
>
