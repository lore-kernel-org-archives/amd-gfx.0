Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C25CE7B1C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 14:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E0D10E19C;
	Fri,  6 Sep 2024 14:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BSbD4ytl";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB5910E19C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 14:25:06 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-714481eca0cso151273b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725632706; x=1726237506; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOjxjW0E7mrhCHOj00DUfJG7I+XVl5lMKnSmx2DxXqs=;
 b=BSbD4ytlzXzx/CwyfE3WCk2jSbHXUcVruHhBMJ3o7vdVEgW9pPP9G5Zdl5mKtTpuF9
 pI8wh6qDRGUG+R5sPFM/IXxgVLNh7yecObMx22Na6mkjaOLpqzJLQDG+gzE5XJadME/x
 nNXnlAt11/U1+lJtM3b52Y31vu5F7PKuYJoUUmH/BCMHeanTp9uVjZiN5K1j+J7t/diA
 eMDGrCI4OoxrkqAknz8SU39dIdDlzmkH64QP9OWwT6H9lYA5uwFKySz2RePnAE7UdOw2
 VcVfRp7seQuEmT7M6F1xdmSAQ/UWtRmgeUoqycwVUqI4naU7NsbMSyAbtn9UPb94y3zc
 v26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725632706; x=1726237506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOjxjW0E7mrhCHOj00DUfJG7I+XVl5lMKnSmx2DxXqs=;
 b=tnTn8aWrOfte/vGCY3gOmk4hB99Pn+bMBW44mSt4cGpUxH/O99uQEndQUp/dyxTC3C
 1THQQUvNgPLzITTB9XcGmjOAKDxThFeQp7SwYk3RmKDTZE5zZol9vGRCxfr0YWpeieAm
 8U5ucepF1ixCH+qzhDkrJlasqp8sVvxtKHxhAEJjeOBJbcfPCHIlDX0rD3i9IAjbW4q6
 97zm4dgaWIbSdx7O+P/wmzg0SyOArzOk1i5A0rW0nptDObxjtWtj2YW/miwlkqc1mRdl
 rnCIvO/HPCCnbNQtH87Z0mcILHT03B37gNpqNoKbjVmrOw6UsIpNgG2YW+Lx/zknuLTi
 B3Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGvAzvUwa0+d0f9Q8el0DNfzJW6c8JjZ6irz/00iIzsCFDdZKzGy4vui4/sa04HRfIWgrOGCqb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz6jvq5m6CK9xCbAHFt/0G2JQG0kbtQ66JLTIXwX/xPC+R76w3
 tn+TjcjBcES1c9cBVrT7nHy8ZJ1BvLSx0k0kgrN3oRut+QD33nb6eFkELyw/u5vkxd8y54xYsvp
 fcckyowlHWxM0atu6hdD9dqvG1Bs=
X-Google-Smtp-Source: AGHT+IEy5rWOKJ5Gz5F3bS2JgBwgff8Yo6Ip762+uWZOvxTJEfguBwNyFf9HUm99vRoGB/LuqXbNra//CoFdpiMhQDY=
X-Received: by 2002:a05:6a20:914b:b0:1c4:f30e:97ff with SMTP id
 adf61e73a8af0-1cf1d25f025mr1615569637.9.1725632706146; Fri, 06 Sep 2024
 07:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <4152e10c-2ec5-4ac3-be47-c97fcafdb35f@stanley.mountain>
In-Reply-To: <4152e10c-2ec5-4ac3-be47-c97fcafdb35f@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Sep 2024 10:24:53 -0400
Message-ID: <CADnq5_PfCeCA4ZZtHBB1KfM5NmFoYh8eFxXH3r2nSJ7XMSOKhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes11: Indent an if statment
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, 
 Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Yifan Zhang <yifan1.zhang@amd.com>, shaoyunl <shaoyun.liu@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 chongli2 <chongli2@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org
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

Applied.  Thanks!

Alex

On Thu, Sep 5, 2024 at 3:08=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Indent the "break" statement one more tab.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 0f055d1b1da6..ee91ff9e52a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -415,7 +415,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_m=
es *mes, uint32_t queue_typ
>                 /* wait till dequeue take effects */
>                 for (i =3D 0; i < adev->usec_timeout; i++) {
>                         if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> -                       break;
> +                               break;
>                         udelay(1);
>                 }
>                 if (i >=3D adev->usec_timeout) {
> --
> 2.45.2
>
