Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E541C3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 11:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BEF10E3D7;
	Mon, 31 Mar 2025 11:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fEYtBSlO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9152010E3D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 11:46:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 62D9B440A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 11:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A537EC4CEE5
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743421581;
 bh=u9p15OXm9QZMTai0Gqz2IJw0gWsmXXWW9BWXZRpKvQs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fEYtBSlOFmnS9FWcnFnLjzCgnlu7b2kKqKIw2MwC6epbB64lpGjYpJAzNDcFNB64d
 HUL8cagWLDUpWkuXxeFhxZLJpgfy2SCg/zth7Wwh2VcSiUj40U1h224UBYOcH/Vo0r
 G+i3rMyfJePmIQ8SNvkS17L8STUl8Akw+9AI7u9PDNbXdYCX2+yTkuH0xOww4qffQ8
 DfkhtlfzOSqW7Bku5XGtGFvPaPQ6qON/iKiiWDGqN8VU7KVxEvGzxEx95NSGmjXFoB
 8S/nWukTs0YkAMte1jcgd+H2GXgvA4X0vFOPs7alu9LjcHt3eWFFJRNU0QoJpOmpaZ
 EeeJT6Af9u53g==
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-2c76a1b574cso1305910fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 04:46:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVsfBF3Dv2MC1wa9Un9EGQtW/aIxvUSedVbAjR6UHGxLioqVcUaZrJN1eZF4BaGkoFRNFrrpjBQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLFqlmaJP+o1XVRVkG+YZhjdIksRlsLMtNwTnFycJrfmCA+3n/
 qCDU/CK/4UjO0Gj0mXsOBcCVgXzTtRcNi1e+8OaH3C304p+L9BlfZEkli3V8ww0B5ae9OEvgZm9
 fRWxqR1umm0nnfQnvnO6VWg63XJQ=
X-Google-Smtp-Source: AGHT+IGLHSPjnj0ONYF56bwe4e8CV95FtIHFoYEUDj6FI0sTgHCoDe9OUqqcTrF3/hupBFyV4rvUitZaUVoNtiZpj4k=
X-Received: by 2002:a05:6870:418d:b0:29e:255e:9551 with SMTP id
 586e51a60fabf-2cbcf474c3cmr4598743fac.2.1743421580976; Mon, 31 Mar 2025
 04:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
In-Reply-To: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 13:46:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
X-Gm-Features: AQ5f1JpzlMUyTy2jsegu95KUagJIz4NmCHKhw5-yyzojW0dsktwnVlH68O3aG4M
Message-ID: <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 28, 2025 at 10:09=E2=80=AFPM Gergo Koteles <soyer@irl.hu> wrote=
:
>
> The _DDC method should return a buffer, or an integer in case of an error=
.
> But some Lenovo laptops incorrectly return EDID as buffer in ACPI package=
.
>
> Calling _DDC generates this ACPI Warning:
> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
> found Package, expected Integer/Buffer (20240827/nspredef-254)
>
> Use the first element of the package to get the EDID buffer.
>
> The DSDT:
>
> Name (AUOP, Package (0x01)
> {
>         Buffer (0x80)
>         {
>         ...
>         }
> })
>
> ...
>
> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
> {
>         If ((PAID =3D=3D AUID))
>         {
>                 Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
>         }
>         ElseIf ((PAID =3D=3D IVID))
>         {
>                 Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
>         }
>         ElseIf ((PAID =3D=3D BOID))
>         {
>                 Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
>         }
>         ElseIf ((PAID =3D=3D SAID))
>         {
>                 Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
>         }
>
>         Return (Zero)
> }
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extension=
s/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
> Cc: stable@vger.kernel.org
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if availa=
ble for eDP")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
> Changes in v2:
>  - Added comment
>  - Improved commit message
>  - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc95ee=
8be28aa811.1743129387.git.soyer@irl.hu/

Hans, any concerns here?

>  drivers/acpi/acpi_video.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index efdadc74e3f4..103f29661576 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -649,6 +649,13 @@ acpi_video_device_EDID(struct acpi_video_device *dev=
ice, void **edid, int length
>
>         obj =3D buffer.pointer;
>
> +       /*
> +        * Some buggy implementations incorrectly return the EDID buffer =
in an ACPI package.
> +        * In this case, extract the buffer from the package.
> +        */
> +       if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package.cou=
nt =3D=3D 1)
> +               obj =3D &obj->package.elements[0];
> +
>         if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
>                 *edid =3D kmemdup(obj->buffer.pointer, obj->buffer.length=
, GFP_KERNEL);
>                 ret =3D *edid ? obj->buffer.length : -ENOMEM;
> @@ -658,7 +665,7 @@ acpi_video_device_EDID(struct acpi_video_device *devi=
ce, void **edid, int length
>                 ret =3D -EFAULT;
>         }
>
> -       kfree(obj);
> +       kfree(buffer.pointer);
>         return ret;
>  }
>
> --
> 2.49.0
>
