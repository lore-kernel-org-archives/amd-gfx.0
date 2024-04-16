Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F10C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 13:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4308010F0EA;
	Tue, 16 Apr 2024 13:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dtG9yZYD";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE9810F0EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 13:59:44 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso2963534a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713275984; x=1713880784; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGbju25MWC1l1/IKdJdA0d+qBvghIJ3vLGcRjHEGHSc=;
 b=dtG9yZYD6auuLN0v4ys47qfUI+M1zXYtXtG/MQJbq0assjrghL6KU+VWmzq6BEXQ+y
 s7yGP6oSETKXMBGC5Cz1N/lvRzI8xkAUECQntoxeVo3aBj69wLD9qSvnuOqViBFAJ/L6
 d+WU91RM5jUFgT0OC1IH9hGTZ8k3OIQFImdyz5hUfb5Dxjs2LIf0oWXcbH72N5Y9eSDR
 FA85eolUcFyt+9ZKGeO1rydgUEHyu520qO165erTNnW0LhBx161cxd2ve4X5ApgBYEfx
 vpz78iXQU1bmuOGaZaXhKKZ4yJ9my47YXJ3xI1yb91gJLWueVLXddYqTKWg30nEAKrMi
 T/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275984; x=1713880784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGbju25MWC1l1/IKdJdA0d+qBvghIJ3vLGcRjHEGHSc=;
 b=EzsA8wYNjrDs3gqGIoM06IFCcUU1n9YV8kMG0rf8hQM3Rhofx2jcR/sXtmZDv0q6AK
 kY9d4jODA2OalWNaomRS9FsMPtjkC+MMrdsN55rgwh4bia7yBkW43iggLP3yEbnoEAzn
 L2wCfray4F0BAkEnlLQoxNSW34qw4b+/VWEMb1VJE3hV4eMQxHGGE+VFEGr9iL0ZbWfs
 wKb6mtm1EnvV2kmd1wknR5XAMJvJKCxnCPmOm0jg9nlg5ErODyLjasMs5J9J7Ezuwx9a
 e6WSlUVe1Mz/PXd7hEDObJDLkFH0OVHVf7eAbRSmpVqRFS4uprG/V00cV83C77ePximx
 TxuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBeEIQPRA0ccwoZVpnQBL/jW9eFETk/P5js50Af5MSOoPEnUoyWGui+vSJqd3ZsQ1mCMotYrJjR/UsjRwtAVucXZ6Qld7fulmB93ADqg==
X-Gm-Message-State: AOJu0YySTNj0IkJ9TIfM2pbEMaSiyB7mGomCs7hvsPGomL0rr9rcqDXS
 7DI9T6FFJJDb1r7uH2g2rq96r46tGrHYjGO1z6YqOsgclaxNvW/Gi/wFYlCubJmiTz2Yz7QnDJG
 adbwBXYlJjdUqPqag1JH208dhhTy24zRl
X-Google-Smtp-Source: AGHT+IG7XUx8mQbuWJgDYG4+DSmY+2/vb1IDQtJ08RUkdyrEu+7Uxmsub/YPvPIESHn7WS4Ln0YVOoT3kJpIEJeQ7Ow=
X-Received: by 2002:a17:90b:3c3:b0:2a6:db3:1aa5 with SMTP id
 go3-20020a17090b03c300b002a60db31aa5mr12951284pjb.18.1713275983932; Tue, 16
 Apr 2024 06:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-7-sunil.khatri@amd.com>
In-Reply-To: <20240416120804.607272-7-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Apr 2024 09:59:32 -0400
Message-ID: <CADnq5_O=TWub8iPkGWNiADT4J5JX3ExQdn+vTs5x8VsZQaiOFA@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: add ip dump for each ip in devcoredump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Apr 16, 2024 at 8:08=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add ip dump for each ip of the asic in the
> devcoredump for all the ips where a callback
> is registered for register dump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 64fe564b8036..70167f63b4f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -262,6 +262,21 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>         drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fa=
ult_info->addr);
>         drm_printf(&p, "Protection fault status register: 0x%x\n\n", faul=
t_info->status);
>
> +       /* dump the ip state for each ip */
> +       drm_printf(&p, "Register Dump\n");
> +       for (int i =3D 0; i < coredump->adev->num_ip_blocks; i++) {
> +               if (coredump->adev->ip_blocks[i].version->funcs->print_ip=
_state) {
> +                       drm_printf(&p, "IP: %s\n",
> +                                  coredump->adev->ip_blocks[i]
> +                                          .version->funcs->name);
> +                       drm_printf(&p, "Offset \t Value\n");

I think we can drop the drm_printf line above if we use register names
rather than offsets in the print functions.  This also allows IPs to
dump stuff besides registers if they want.

Alex

> +                       coredump->adev->ip_blocks[i]
> +                               .version->funcs->print_ip_state(
> +                                       (void *)coredump->adev, &p);
> +                       drm_printf(&p, "\n");
> +               }
> +       }
> +
>         /* Add ring buffer information */
>         drm_printf(&p, "Ring buffer information\n");
>         for (int i =3D 0; i < coredump->adev->num_rings; i++) {
> --
> 2.34.1
>
