Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAECFECE579
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 17:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780AB10E617;
	Mon,  9 Sep 2024 17:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FV9Qhp6S";
	dkim-atps=neutral
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F99D10E616
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 17:20:05 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-49bbc25f49aso202149137.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725902404; x=1726507204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzZYYdOmSYtFA5YeBMtN9oGmezEQtfW/YA4KKrjPNPk=;
 b=FV9Qhp6SAV0v3QrrTtlRBkUaFcgoDFu6GundSr/JByrvvBau+erJAe4m2It7VBWHBu
 /Mugt/N+J3ifdNFDJ4tx1Z7XeoauSiI8UybgvUCWiKZR+nqAE7mh9b6RpNxJ7ZUkp4+z
 DGi72RXWiXYqkSHSsdvJmrrdu6RCBnsZNvjnn8w9hDwkvveA3JBrbC1oiPkjEfOlmsdm
 fuCQLsTrevfO087LeSUJp7j7+8xJzvfHhE5ZSqFgRAc8Bf0YhJv1QtcsfVi+eQ4YY/Uz
 hyO6hFMeSEVyJmsU7ripkYHh2dms1izBHnAu1bANqa8+p3RnijKZ/bDZuB+nxnwghWgY
 Lx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902404; x=1726507204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzZYYdOmSYtFA5YeBMtN9oGmezEQtfW/YA4KKrjPNPk=;
 b=rJbPL+6Y/YXh/bn4vGdDDQoDgOu4dT5Z1BHG5cTW+QTy1/rtzQGEsFLhN2bDSNNh2b
 Wy4cWpDWfmsFLsM3V3rCyNzTt44kQpZATJb+CqvHV6vIXcNPVSo0ob/Nkjyy4teGWdyl
 DZrUIG1PI+ILGLMkIVldL6beaO2lF6aswDa8m+P81zHktuU/ry8cCGpUrmcSdBi+jCRG
 hrBcZc2xO+X8MEgaRM1hS2NDgqbae3JQEu4fUVDlVgHSxgXvAH3gY7NXzSDQawpW1wGw
 qPhw2/cz2eniDmsKK0miyvZZMMJIqwZc+jGYPVFq4Q3fB7pnM0OUlTcjmTnI2/HXgRh3
 sX3g==
X-Gm-Message-State: AOJu0YxyE/1wwLdKh8Bra6sIKmslodJgQC6sUjb3J3GYtS4TfE6G8Th8
 Wc6nB9PByk8H2qOqPQkS1v+s3nqGkp5qLFUy26/iyUYycpB3cDzoITOKzRPVO/GM+7ESttT5sHn
 m/9lmJ8ZwpGSzCPf1v2qHRnpJv7Y=
X-Google-Smtp-Source: AGHT+IGmfXV/QM4ddjruXNKdrsaFbRlQ8y8Dh4vMpSL7xLgEhBgMFDl4Sj1B8GGSZP3IgZbIHNlrZiCI/E6dDSk3S8o=
X-Received: by 2002:a05:6102:2ac6:b0:493:31f9:d14e with SMTP id
 ada2fe7eead31-49bde1ba809mr6382945137.2.1725902403475; Mon, 09 Sep 2024
 10:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240906144638.2464367-1-alexander.deucher@amd.com>
In-Reply-To: <20240906144638.2464367-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 13:19:51 -0400
Message-ID: <CADnq5_No2VCa67Yh8ZdehwOGcfoTE2WsRX4nHmqTHfoPw21H1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: Silence UBSAN warning
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

Alex

On Fri, Sep 6, 2024 at 12:43=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Per the comments, these are variable sized arrays.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3613
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/include/atomfirmware.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index 09cbc3afd6d8..b0fc22383e28 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -1038,7 +1038,7 @@ struct display_object_info_table_v1_4
>    uint16_t  supporteddevices;
>    uint8_t   number_of_path;
>    uint8_t   reserved;
> -  struct    atom_display_object_path_v2 display_path[8];   //the real nu=
mber of this included in the structure is calculated by using the (whole st=
ructure size - the header size- number_of_path)/size of atom_display_object=
_path
> +  struct    atom_display_object_path_v2 display_path[];   //the real num=
ber of this included in the structure is calculated by using the (whole str=
ucture size - the header size- number_of_path)/size of atom_display_object_=
path
>  };
>
>  struct display_object_info_table_v1_5 {
> @@ -1048,7 +1048,7 @@ struct display_object_info_table_v1_5 {
>         uint8_t reserved;
>         // the real number of this included in the structure is calculate=
d by using the
>         // (whole structure size - the header size- number_of_path)/size =
of atom_display_object_path
> -       struct atom_display_object_path_v3 display_path[8];
> +       struct atom_display_object_path_v3 display_path[];
>  };
>
>  /*
> --
> 2.46.0
>
