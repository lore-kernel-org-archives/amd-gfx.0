Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F7DC10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 15:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E49112115;
	Mon,  6 May 2024 15:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ACrEr++W";
	dkim-atps=neutral
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714F8112135
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 15:11:05 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id
 3f1490d57ef6-de5e74939fdso1518950276.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 May 2024 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715008264; x=1715613064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDJIKh0/L8Q/ep8AgK7lAiT+FPURZQz+Nr2ode8usdI=;
 b=ACrEr++Wz7KtG3tU9DnEu+CVL5O6vVdDkp8TNH2YRLteuVb3g2OYHJC4ptirED47CL
 /PgpD1UuShsY8NeyW8d+r/ax6MsS9iSDWXcfSnpKl2Du1JbuwBwnPyOehVPAzYJU/gKR
 mfHbgVSUlpx8KTo/w4XU9e6dzPEdJ2C8+6LXGvdUawhJxdLOZgAAcsB2Ly5XrBrNDmvE
 8bIeQvZIJ2jI4Z9uwSJr8O8+YYftnYQyLX4EU3XLJca0vr1wfbFIB1CXahGmUphLFcmC
 MDQKVUKJz4BsvQk4EaJl/SNi46A/RZfkxy+Rt81kQdyBu4pzaOaxaEJdjXNZcR6khCqR
 kdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715008264; x=1715613064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDJIKh0/L8Q/ep8AgK7lAiT+FPURZQz+Nr2ode8usdI=;
 b=leGa/4hb9Y8VMPjYfkwXX8P5MMJkslCcW6ds6n2UIaAGUGjdjQ6Zj4EBwEvz1oCRpz
 XHSzvhbI8Y05E59TrMYDXKgkTmskKg/g+wZpDryOGDeVgpi5CUwneiRxyC0lsPhsYcVu
 TOdhljZTfVokwlNftjaBjOmOgM17lWvlEu/ck7l8lPWAULVBPk+njKA8YZ0TNcIeSTMK
 hqHti8Z+8BRkD4WgKATez+I60gWkURXkyWtBBCsD5Tdal/1cM5QsOe0pXZBuIy4r3yRL
 KJywJQEJOrAYDaw9L6jSB/BYaroPJ+HDGPT0fcyf3PLnoLcGlAfDt9TD4OSX2zVF03kY
 gKHw==
X-Gm-Message-State: AOJu0YwrtVCUnJ0Decbx1WX5b14yJOtArvzBuBsOgAuKTtaveRCP2Cur
 spfYSiVtY28VfqUsAbV16T5toFhBhJyGao1Lr0eJBaJU+Pke62QSibw2Vq5mxYo44TObupq+EGw
 JpoBovjpIrjH7TOklzOBrPioRuWU=
X-Google-Smtp-Source: AGHT+IEidylQ62YH5swMKrhjjiMIpblNDsoaD6YrAnAiwALAG1NUmOi6BAeErswQ1wGdcOqPU0CzMm9FmgS7cH3KaSQ=
X-Received: by 2002:a05:6902:c0f:b0:dd0:bb34:1e77 with SMTP id
 fs15-20020a0569020c0f00b00dd0bb341e77mr12116196ybb.53.1715008264124; Mon, 06
 May 2024 08:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240506092515.2027655-1-Tim.Huang@amd.com>
In-Reply-To: <20240506092515.2027655-1-Tim.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 May 2024 11:10:51 -0400
Message-ID: <CADnq5_OpCXZc99BpOnaH7frSKkEt4WrjJipjcfBtTNKK3b7gDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix ucode out-of-bounds read warning
To: Tim Huang <Tim.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Mon, May 6, 2024 at 5:26=E2=80=AFAM Tim Huang <Tim.Huang@amd.com> wrote:
>
> Clear warning that read ucode[] may out-of-bounds.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_cgs.c
> index b8280be6225d..c3d89088123d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -213,6 +213,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_de=
vice *cgs_device,
>                 struct amdgpu_firmware_info *ucode;
>
>                 id =3D fw_type_convert(cgs_device, type);
> +               if (id >=3D AMDGPU_UCODE_ID_MAXIMUM)
> +                       return -EINVAL;
> +
>                 ucode =3D &adev->firmware.ucode[id];
>                 if (ucode->fw =3D=3D NULL)
>                         return -EINVAL;
> --
> 2.39.2
>
