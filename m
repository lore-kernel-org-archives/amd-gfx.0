Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A5DC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 11:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DF210E9EA;
	Fri, 28 Mar 2025 11:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VKqaQGLT";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9FA10E9E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 11:12:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 53418A41823
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 11:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81DCC4CEEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743160350;
 bh=tdiV8jooMBZ2aJx8rltIZQeVkN+R4v7ZLa2bFv4yEZw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VKqaQGLT1sE2zrKWsK47WyNvfmV3rJ7w5C+ROk+hwFC72tfMhhIReseO8eIlQHske
 i9xJ5/n3bAJhxEkLldtvxqaHGxwX+Efzor7UOALiQwd6DoMBUH8H0Z/3oORTGPsFk3
 d0SXD3cmRP4tS83uQtqtys7T0HkwrrR4e9hEM1pbMfyiOQ28j5lSfrqx7ja0eBionB
 Ww+P/LbaOhbJUFQAi6lqcwjPMxUwKOQiTHEBp/f9GSv4RUbPcLoA+K+FPMJGGXBxbW
 yIfIviHX68jqX/xjRBYaraHOqqS1a9nl9LaTVgrBZV5drYrBJBj+yHkbYlG+EYbk2v
 2KwM7v7+D8ZZg==
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-3fefbbc7dd4so1129032b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 04:12:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVlH6kCO/1tD2DZWNnAHNKn02GzC45fVaQMpndlp/3paOKi6nRXdMBJGfj69+TRgM6CH2MHkk20@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTgmU0uHY2vXqOjNe+CA9nU8uwIT2g5joOP3h0O9mJoTY/PeII
 Pp8boM+BlJfSZ7ibBCLJSyufzYttkXdktr8t5d7DBrEsFVvgusf2kV0tmXuvtQdvjhx9dCbqCv8
 1oUx71IrLCkkEc83v1PtdwcP0o2A=
X-Google-Smtp-Source: AGHT+IEBc+PzLf7kQyxJxN660tXPVD8Ng9hOTrCSQoAZZFYeWPUf39m1FWqMoEkTz6Jp39FXpjE7W9d+1x3MNw5s7Jg=
X-Received: by 2002:a05:6808:1524:b0:3fa:3d63:ac58 with SMTP id
 5614622812f47-3fefa54d450mr4877883b6e.17.1743160350106; Fri, 28 Mar 2025
 04:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
In-Reply-To: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Mar 2025 12:12:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
X-Gm-Features: AQ5f1JoH6FMgp2NUlC4f-9Wruph1kv2VPl-kjHMMoGcMuzoeBNdH473Vgx71Wpo
Message-ID: <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Alex Hung <alex.hung@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>
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

CC: Hans

On Fri, Mar 28, 2025 at 3:51=E2=80=AFAM Gergo Koteles <soyer@irl.hu> wrote:
>
> Some Lenovo laptops incorrectly return EDID as
> buffer in ACPI package (instead of just a buffer)
> when calling _DDC.
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
> Cc: stable@vger.kernel.org
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if availa=
ble for eDP")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  drivers/acpi/acpi_video.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index efdadc74e3f4..65cf36796506 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -649,6 +649,9 @@ acpi_video_device_EDID(struct acpi_video_device *devi=
ce, void **edid, int length
>
>         obj =3D buffer.pointer;
>
> +       if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package.cou=
nt =3D=3D 1)
> +               obj =3D &obj->package.elements[0];
> +
>         if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
>                 *edid =3D kmemdup(obj->buffer.pointer, obj->buffer.length=
, GFP_KERNEL);
>                 ret =3D *edid ? obj->buffer.length : -ENOMEM;
> @@ -658,7 +661,7 @@ acpi_video_device_EDID(struct acpi_video_device *devi=
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
