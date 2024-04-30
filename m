Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4353C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 13:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA4110EF19;
	Tue, 30 Apr 2024 13:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3lL0QrV";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C44210EF19
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 13:05:49 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso4764260a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714482349; x=1715087149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLHHNytemGKB33dEf9QXY+ZrheNL+WjimZhZLddyJJc=;
 b=T3lL0QrVcUwCR4zxwv+GBSPzReXWjuhTR9CFYJ4XxVaKwiA44Bc4d+0osbD0dn8jUu
 jCsqwqQmzHgXLs8LIukHo5JOWbVymjtE6kZB6dvpaBuZKg/umJ8LIQA6rvlfyXo4sZmj
 R9TYcxuXzuTN8dz//+oYBF8KxNkWbghBG76KxMPbX00/7hqhQ9XJ6U2Lc4ubWvWsnIdY
 F6WNux3hp6Y8pEacAz8+JuMxWguAQ7gA5pgg3LT4sjSBc24KVW7tX9eZr7wZoVYM6pxy
 oXgRwLNQuZ/LRsgGiodkQMJnkIqp74Pmu3qkSlwfLqclaRmKrvXFhFp9JZVXzVyOwWx8
 eASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714482349; x=1715087149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLHHNytemGKB33dEf9QXY+ZrheNL+WjimZhZLddyJJc=;
 b=OycIFbhHkLl/oXvA5HwIapC3rGonONAAL4vazs4FQ5bT3PfbLY27UI0rW5VrsUxE3j
 UzO0FsvfZArhSE/kNqq4PVj/t3/JUxQpewbYxkm7uXkQ9n9KX+eeSZksaPXs7DlgskSf
 znX1SjTRz1ovgvBqTVTODP1WNfJd9+YCXVsPJbkfQshIQUpIqpunFBqFM7VQ5KWPaYEV
 CPLUmZFPbjhy76eOLpx4h1wvRqJwhsRxpMjo8GuR4aqupePf9UA4i36uy3VLJ4carn+u
 4bHuEum8TJnNEJ0F2jmxDa2733NhqASEB4xxiDrbd7SM/8VmG0PFORmFxS0ll4+nohCC
 Laig==
X-Gm-Message-State: AOJu0YxqNkwp176G7Ij7uWUiB9bPBa182mL7H54ku7EWiYtpz6gf7g75
 w/Ed15SamPJDSgdkLqsK3yqF8MZ45Xui72TFI3xVRZCGbXzYyq0uCn0EbtCMOFo9FmFqaMDw8DC
 qvxlzCG/MzrUZ/SYU3yZktsjsFBE=
X-Google-Smtp-Source: AGHT+IEdcvSUzDrv66VcjwBd62xAKwPsqRZHo3TrGR2/mfqGh/gx8PlE5jdawXE58cSb24oFgPpe91IAJiaer2g35i4=
X-Received: by 2002:a17:903:234e:b0:1e7:d482:9d96 with SMTP id
 c14-20020a170903234e00b001e7d4829d96mr19726368plh.10.1714482348906; Tue, 30
 Apr 2024 06:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240430113620.322882-1-lijo.lazar@amd.com>
In-Reply-To: <20240430113620.322882-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Apr 2024 09:05:37 -0400
Message-ID: <CADnq5_OzHnKEq8455dnzi3R7SAHN+h1Z6TwNM9GG1rDfemJv5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdxcp: Use unique name for partition dev
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, james.zhu@amd.com
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

On Tue, Apr 30, 2024 at 8:32=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> amdxcp is a platform driver for creating partition devices. libdrm
> library identifies a platform device based on 'OF_FULLNAME' or
> 'MODALIAS'. If two or more devices have the same platform name, drm
> library only picks the first device. Platform driver core uses name of
> the device to populate 'MODALIAS'. When 'amdxcp' is used as the base
> name, only first partition device gets identified. Assign unique name so
> that drm library identifies partition devices separately.
>
> amdxcp doesn't support probe of partitions, it doesn't bother about
> modaliases.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/dr=
m/amd/amdxcp/amdgpu_xcp_drv.c
> index 90ddd8371176..b4131053b31b 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -50,12 +50,14 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev=
)
>  {
>         struct platform_device *pdev;
>         struct xcp_device *pxcp_dev;
> +       char dev_name[20];
>         int ret;
>
>         if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE)
>                 return -ENODEV;
>
> -       pdev =3D platform_device_register_simple("amdgpu_xcp", pdev_num, =
NULL, 0);
> +       snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +       pdev =3D platform_device_register_simple(dev_name, -1, NULL, 0);
>         if (IS_ERR(pdev))
>                 return PTR_ERR(pdev);
>
> --
> 2.25.1
>
