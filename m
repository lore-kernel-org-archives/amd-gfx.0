Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC73D216B3
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 14:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4FC10E590;
	Tue, 15 Oct 2024 14:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eCVKFxej";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72CC10E590
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 14:24:50 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2e2af4dca5cso1079596a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729002290; x=1729607090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UD1eOChQ1Sm+6nk15ewP5+5xbjLs15wr+w9awLDgKM0=;
 b=eCVKFxejPpoYIqNv02chHLBLQRzsM1p4kqOPmEX2sTjCZegKiTDtiDdji85pfp/PuW
 67W/tZXCCFbAwkzl128GvcTrjW33/srF4vmZsTtKVR7Yu89j0PYY6fK9QNvhxG16d+fu
 4T6A9GydD8kQuoUEr4Po7/geJsYp03eYINDF2ulaQZ9898+ILmqU4t4JPs8HMtzMLEJi
 shAt6lCobopjEoUSOuVSjE3ZFzir2BZCwORD+5XXDMoKG+6BVAhj2h8IqjQcKyUBzYZw
 HIUV7/A9mQEu32+iQawHkOoZ43P+1Fg48nTJn29tfeBdKEDuhjyleyZXUYXEWZrHc9M0
 0AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729002290; x=1729607090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UD1eOChQ1Sm+6nk15ewP5+5xbjLs15wr+w9awLDgKM0=;
 b=c/O28QlfQKMsIi0QYxEFHmTVg64flCCQc01XiAStI2IJg5JZ2G6umEZvqNrMlJgqta
 NV6B/znm0sSa/JK5HQZ50JVTp2QYh/9gKbmwG3AOpG8hzmcR8zhIGITNAxVMlvizuvip
 e3okaWbryU3L0fHXrbIY/dlSJ6tQvut3K3HRsAFEYDhBCi9e3tgVpO/ya93pPqAed81D
 nKOAj8l9IRlH0vGT1Mwgk8n6fahzAVhVXjgfXXmHBE+usQT9+I+T3xeeWoKXYQ7tqEGe
 zyqfSrcKXxkOCOosdPMEOfwES65ciyD7R6CQ6udENk6K4Tjt2Io0iPdt8rguo2GTZcS5
 /7pQ==
X-Gm-Message-State: AOJu0Yy53Kc7Cy1wUJyRD6gXFitCdMfR5SUnpF37LAACCoeCS3jPDX1A
 TMkPF6Sqa6ue8gqLXfqPljvlwRH0jswHl4dTH6Tk97y6Q5nibw8PDq49MB06aar2b77jqRFUhmz
 nZ8dd8HmIekvZ7+R/CW6KT8y4W3M=
X-Google-Smtp-Source: AGHT+IErSDmR/IQ8+en9PBwKQlINVbxpVWgg3XOsD0GWlJvMC42CI8BGOJ/+qIhPkbZ8KESRXkfyePTbNieOm0xYH+E=
X-Received: by 2002:a17:90a:9a1:b0:2d8:9f4e:1c3d with SMTP id
 98e67ed59e1d1-2e2f0d7750dmr7714156a91.5.1729002290327; Tue, 15 Oct 2024
 07:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241011172315.35231-1-mario.limonciello@amd.com>
In-Reply-To: <20241011172315.35231-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Oct 2024 10:24:38 -0400
Message-ID: <CADnq5_NRu0fm6d0Em=YuyxrJa3jASY7hSWMBS1e9ekHV8N-GvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Guard against bad data for ATIF ACPI method
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Fri, Oct 11, 2024 at 1:33=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If a BIOS provides bad data in response to an ATIF method call
> this causes a NULL pointer dereference in the caller.
>
> ```
> ? show_regs (arch/x86/kernel/dumpstack.c:478 (discriminator 1))
> ? __die (arch/x86/kernel/dumpstack.c:423 arch/x86/kernel/dumpstack.c:434)
> ? page_fault_oops (arch/x86/mm/fault.c:544 (discriminator 2) arch/x86/mm/=
fault.c:705 (discriminator 2))
> ? do_user_addr_fault (arch/x86/mm/fault.c:440 (discriminator 1) arch/x86/=
mm/fault.c:1232 (discriminator 1))
> ? acpi_ut_update_object_reference (drivers/acpi/acpica/utdelete.c:642)
> ? exc_page_fault (arch/x86/mm/fault.c:1542)
> ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
> ? amdgpu_atif_query_backlight_caps.constprop.0 (drivers/gpu/drm/amd/amdgp=
u/amdgpu_acpi.c:387 (discriminator 2)) amdgpu
> ? amdgpu_atif_query_backlight_caps.constprop.0 (drivers/gpu/drm/amd/amdgp=
u/amdgpu_acpi.c:386 (discriminator 1)) amdgpu
> ```
>
> It has been encountered on at least one system, so guard for it.
>
> Cc: stable@vger.kernel.org
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index f85ace0384d2..1f5a296f5ed2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -147,6 +147,7 @@ static union acpi_object *amdgpu_atif_call(struct amd=
gpu_atif *atif,
>                                            struct acpi_buffer *params)
>  {
>         acpi_status status;
> +       union acpi_object *obj;
>         union acpi_object atif_arg_elements[2];
>         struct acpi_object_list atif_arg;
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -169,16 +170,24 @@ static union acpi_object *amdgpu_atif_call(struct a=
mdgpu_atif *atif,
>
>         status =3D acpi_evaluate_object(atif->handle, NULL, &atif_arg,
>                                       &buffer);
> +       obj =3D (union acpi_object *)buffer.pointer;
>
> -       /* Fail only if calling the method fails and ATIF is supported */
> +       /* Fail if calling the method fails and ATIF is supported */
>         if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
>                 DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
>                                  acpi_format_exception(status));
> -               kfree(buffer.pointer);
> +               kfree(obj);
>                 return NULL;
>         }
>
> -       return buffer.pointer;
> +       if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +               DRM_DEBUG_DRIVER("bad object returned from ATIF: %d\n",
> +                                obj->type);
> +               kfree(obj);
> +               return NULL;
> +       }
> +
> +       return obj;
>  }
>
>  /**
> --
> 2.43.0
>
