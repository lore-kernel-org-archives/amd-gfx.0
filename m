Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB7DC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 19:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A30B10E0BA;
	Fri, 28 Mar 2025 19:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jb3Mxj3B";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFC910E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 19:01:20 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so596243a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743188480; x=1743793280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diP8zSmtwSIIfMy8xJAGqsFmzHBdP/Z7cmP5hbOKQDw=;
 b=Jb3Mxj3BpezxE6U6uGq862MUcdvaVGuwL8DXgMCPOwR2hYk6K+E9mrcyNg/Dy6Amdn
 zdjZnQocIzeWhyOz8mcCuJ5ZbeOYzboz1d1y0zxFsCehIvg7O8IYS2mgmxHY6s+ztcsT
 NUn+Afy2uXsGqI+Wc2epByWUIgd2UrJwkrV1jJemahPQmrFAg6iUWObE+Q1igFYRV9OE
 fxwFdmDRtM93hu0C3NvIM7U1oGV5KqGwoZf7s9CO0veMHUW1UW8NWV702dyJG2AFSEEm
 176FkYvLmnokRB/sn2WdvE0819Dkelw5RBsbjw7y3JykomUXRY+Wo+K+pdmuy4MZ29YL
 K2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743188480; x=1743793280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diP8zSmtwSIIfMy8xJAGqsFmzHBdP/Z7cmP5hbOKQDw=;
 b=hbKBDDANt5QTfUGzUxLeIsdDD2o0L1i2bVvLFH/jhW1c18US8bW8qEVBScbo5seocx
 ahVGTN9Fr8cKr4laMc/edR2WbNVWy/oROYvKVZPwIVrNOEU30bROFGq+mZoNTXyAEkoj
 cJwzf4L24neyeK2+yJArWDhnwzZMM9zvS5xk3lyyz3Yo368p6zrEwcnOldFA9sv0B8ao
 Dr8ROQwQ6Ad+l5s9KdrIvtLQfBxA69+9KYlfLUqMoHriOhpDyJO43TmhDbd7uEL8pHzu
 u8/YmC9LoYe3nusjchkzfDNlvSfllYludR+R/WYu7EdkXB0xMBAphCgFSPVCmTsOakIg
 OM4w==
X-Gm-Message-State: AOJu0Yxv1CsOsLdEgRex/h63ZbU/m79EgDga4TGHV+yy468A7ok4chdK
 hsERBFGootFC+YqMlLslcNYcEBCzYuRJANNZknHhR5maEcV2HrNgXSq9pYPqYUxn22b621SrhEN
 WLleu68ehqrJb1LSZc6gAxbDAWUCgzw==
X-Gm-Gg: ASbGncvVxQPf1TfrGdbP0tQR7JFD1+Axujo/Rt+bV30cVhwGe8h6oIBI2oxMlah8WDK
 sHUg5aJMrRxjpJz/myKrNsxboQemYWhYmToNTdGJynVreJSp1qYHxXi5N1uHhLN8TxfBfJVdV+H
 haFK62wa92CyTu+HbHz/Q1p8oS2g==
X-Google-Smtp-Source: AGHT+IGAeeD0ZyjQeIziHJsjUtePLmALcdjeIQlPF4SFkQVjHSz9sMyey1nJ0r0ZF6kM3CFnpWFDXjO587YF7VfFBP0=
X-Received: by 2002:a17:90b:1c91:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30531f795a1mr196109a91.1.1743188479992; Fri, 28 Mar 2025
 12:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250327203858.3796086-1-superm1@kernel.org>
 <20250327203858.3796086-2-superm1@kernel.org>
In-Reply-To: <20250327203858.3796086-2-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Mar 2025 15:01:06 -0400
X-Gm-Features: AQ5f1JpdDq6hqAiTNQCi9wlCeZilvYNh8gpS262XyqACY8JghdTz5dmTbwwCA2U
Message-ID: <CADnq5_NYeVmt8iGX6WGmNc+AOn4e4cMJT=_DRBy4k2wXbjbC4Q@mail.gmail.com>
Subject: Re: [PATCH 01/14] drm/amd: Use ACPI macros for amdgpu_acpi
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Mar 27, 2025 at 4:39=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Messages emitted from amdgpu_acpi are not device specific nor DRM
> specific, but rather operate on ACPI handles.  Adjust the messages
> to use ACPI macros instead.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index b7f8f2ff143dd..1c5994de5a723 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -256,7 +256,7 @@ static int amdgpu_atif_verify_interface(struct amdgpu=
_atif *atif)
>
>         size =3D *(u16 *) info->buffer.pointer;
>         if (size < 12) {
> -               DRM_INFO("ATIF buffer is too small: %zu\n", size);
> +               acpi_handle_info(atif->handle, "ATIF buffer is too small:=
 %zu\n", size);
>                 err =3D -EINVAL;
>                 goto out;
>         }
> @@ -265,7 +265,7 @@ static int amdgpu_atif_verify_interface(struct amdgpu=
_atif *atif)
>         memcpy(&output, info->buffer.pointer, size);
>
>         /* TODO: check version? */
> -       DRM_DEBUG_DRIVER("ATIF version %u\n", output.version);
> +       acpi_handle_debug(atif->handle, "ATIF version %u\n", output.versi=
on);
>
>         amdgpu_atif_parse_notification(&atif->notifications, output.notif=
ication_mask);
>         amdgpu_atif_parse_functions(&atif->functions, output.function_bit=
s);
> @@ -616,7 +616,7 @@ static int amdgpu_atcs_verify_interface(struct amdgpu=
_atcs *atcs)
>
>         size =3D *(u16 *) info->buffer.pointer;
>         if (size < 8) {
> -               DRM_INFO("ATCS buffer is too small: %zu\n", size);
> +               acpi_handle_info(atcs->handle, "ATCS buffer is too small:=
 %zu\n", size);
>                 err =3D -EINVAL;
>                 goto out;
>         }
> @@ -625,7 +625,7 @@ static int amdgpu_atcs_verify_interface(struct amdgpu=
_atcs *atcs)
>         memcpy(&output, info->buffer.pointer, size);
>
>         /* TODO: check version? */
> -       DRM_DEBUG_DRIVER("ATCS version %u\n", output.version);
> +       acpi_handle_debug(atcs->handle, "ATCS version %u\n", output.versi=
on);
>
>         amdgpu_atcs_parse_functions(&atcs->functions, output.function_bit=
s);
>
> @@ -741,7 +741,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgp=
u_device *adev,
>
>                 size =3D *(u16 *) info->buffer.pointer;
>                 if (size < 3) {
> -                       DRM_INFO("ATCS buffer is too small: %zu\n", size)=
;
> +                       acpi_handle_info(atcs->handle, "ATCS buffer is to=
o small: %zu\n", size);
>                         kfree(info);
>                         return -EINVAL;
>                 }
> @@ -800,7 +800,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_dev=
ice *adev,
>
>         info =3D amdgpu_atcs_call(atcs, ATCS_FUNCTION_POWER_SHIFT_CONTROL=
, &params);
>         if (!info) {
> -               DRM_ERROR("ATCS PSC update failed\n");
> +               acpi_handle_err(atcs->handle, "ATCS PSC update failed\n")=
;
>                 return -EIO;
>         }
>
> @@ -1429,8 +1429,9 @@ void amdgpu_acpi_detect(void)
>         if (atif->functions.system_params) {
>                 ret =3D amdgpu_atif_get_notification_params(atif);
>                 if (ret) {
> -                       DRM_DEBUG_DRIVER("Call to GET_SYSTEM_PARAMS faile=
d: %d\n",
> -                                       ret);
> +                       acpi_handle_debug(atif->handle,
> +                                         "GET_SYSTEM_PARAMS evaluation f=
ailed: %d\n",
> +                                         ret);
>                         /* Disable notification */
>                         atif->notification_cfg.enabled =3D false;
>                 }
> @@ -1439,8 +1440,9 @@ void amdgpu_acpi_detect(void)
>         if (atif->functions.query_backlight_transfer_characteristics) {
>                 ret =3D amdgpu_atif_query_backlight_caps(atif);
>                 if (ret) {
> -                       DRM_DEBUG_DRIVER("Call to QUERY_BACKLIGHT_TRANSFE=
R_CHARACTERISTICS failed: %d\n",
> -                                       ret);
> +                       acpi_handle_debug(atif->handle,
> +                                         "QUERY_BACKLIGHT_TRANSFER_CHARA=
CTERISTICS evaluation failed: %d\n",
> +                                         ret);
>                         atif->backlight_caps.caps_valid =3D false;
>                 }
>         } else {
> --
> 2.43.0
>
