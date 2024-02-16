Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A8AC48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B0A10E8FB;
	Fri, 16 Feb 2024 15:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfkS01c1";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E794610E8FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 15:28:14 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso1772303a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 07:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708097294; x=1708702094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIBUqDYrOhc/EuGlC7w0SfUAg1ZAHsT9OZlYy9tn80I=;
 b=VfkS01c1onZU8ANQjsjt6BfihC05WNXchk3zP97N+uNqE/6ov78U+boxutO13MhlgX
 dAXdSXsrPOA7zIrVkyXGkE/XvuzssCC0PaamQGT9q6vZwog/UICS3SlyoLN6pbW4377A
 j/TDEhMBStuG2hRIH+EdVGa9LArCwfy/uSR3yAjZNyJec3KiIAEHiZYKpc0E65vvLDc7
 0fhmhFSgNf25BTXKTgyFaqghsCi1GjL5ucKhHkmmICMA1+THXVv8szXsWsF5tj+oqajs
 3oPKvnPOEApwz2PvU/U2utY8wYbl0T0cTZWjdaqNSjx66D8GbxB85xCgBP24D82D0D2m
 Sdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708097294; x=1708702094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIBUqDYrOhc/EuGlC7w0SfUAg1ZAHsT9OZlYy9tn80I=;
 b=w+SCmUZWyEkdF2KxgxLYXUxJj0xiqxfGjzYvooC5wt+JBkfed4PUEELtiJ2d+mD/zn
 Gc9/8fkrLKA2JxUWf5K6Ouno4MBYq6VQnAq8BH889gcX2FpyzFyjxuPCpqM9RdKypFcp
 0LvT0WV1M3TOkeBk04siO7vKCjR+7jxPznthh93/ZerA7gkixLS75mIZJIC0ojDsIx/q
 fbrYJz02QJ5fP5BOMNaoXxpBqLqtDUYdzLoJLk12F7bDJhWo1VtUK2GidHt0OyVVISxz
 8IcNPcXYx4syGLgM5Cdbh4/PffCtCSR+SVSLQ4LcJ7lgliVEqSInQ9id5Xvm3oEg3mC2
 8uOw==
X-Gm-Message-State: AOJu0Yw4mpAd2kLDE9NDBWqcLnzeRP201T5s8jhAHS9NhRSIQsMOVvMZ
 RvnBexmTXQN75tI0ugDOMheiKogHtjkLlQFNxPWeMiWFNS3oBuUZ5jVfTWF5fWyYayzfq+/WA8r
 N00OOBfs7gLdcQowlrZhCOEH0HrxPktoI
X-Google-Smtp-Source: AGHT+IE6qm5b1h0rjege6je3BP0WuHbZRBLx0v0iqwYzIIMeI6sswStflqub+XS/oLEuMocPxfSNlLm+peifAyNx1as=
X-Received: by 2002:a17:90a:f507:b0:299:2f38:ddd2 with SMTP id
 cs7-20020a17090af50700b002992f38ddd2mr2584773pjb.29.1708097294332; Fri, 16
 Feb 2024 07:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
 <20240213185550.2215-1-victorchengchi.lu@amd.com>
In-Reply-To: <20240213185550.2215-1-victorchengchi.lu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Feb 2024 10:28:03 -0500
Message-ID: <CADnq5_M+y8n84-wV-23dUztPOUyDcNZiPu5faWEAm4hOAR_+Ow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Improve error checking in
 amdgpu_virt_rlcg_reg_rw (v2)
To: Victor Lu <victorchengchi.lu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, samir.dhume@amd.com
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

On Tue, Feb 13, 2024 at 2:03=E2=80=AFPM Victor Lu <victorchengchi.lu@amd.co=
m> wrote:
>
> The current error detection only looks for a timeout.
> This should be changed to also check scratch_reg1 for any errors
> returned from RLCG.
>
> v2: remove new error value
>
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 6ff7d3fb2008..7a4eae36778a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -979,7 +979,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f
>                  * SCRATCH_REG0         =3D read/write value
>                  * SCRATCH_REG1[30:28]  =3D command
>                  * SCRATCH_REG1[19:0]   =3D address in dword
> -                * SCRATCH_REG1[26:24]  =3D Error reporting
> +                * SCRATCH_REG1[27:24]  =3D Error reporting
>                  */
>                 writel(v, scratch_reg0);
>                 writel((offset | flag), scratch_reg1);
> @@ -993,7 +993,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *ade=
v, u32 offset, u32 v, u32 f
>                         udelay(10);
>                 }
>
> -               if (i >=3D timeout) {
> +               tmp =3D readl(scratch_reg1);
> +               if (i >=3D timeout || (tmp & AMDGPU_RLCG_SCRATCH1_ERROR_M=
ASK) !=3D 0) {
>                         if (amdgpu_sriov_rlcg_error_report_enabled(adev))=
 {
>                                 if (tmp & AMDGPU_RLCG_VFGATE_DISABLED) {
>                                         dev_err(adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index fa7be5f277b9..3f59b7b5523f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -45,6 +45,7 @@
>  #define AMDGPU_RLCG_REG_NOT_IN_RANGE           0x1000000
>
>  #define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK      0xFFFFF
> +#define AMDGPU_RLCG_SCRATCH1_ERROR_MASK        0xF000000
>
>  /* all asic after AI use this offset */
>  #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
> --
> 2.34.1
>
