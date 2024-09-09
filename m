Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F273ECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F9A10E6D2;
	Mon,  9 Sep 2024 21:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m92caypE";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9160810E6D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:38:49 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2056129a6d7so2454995ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725917929; x=1726522729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDeqiYVgIwcqrNBaozN3CWTTM4ZnqQyc1HdCwmTepQA=;
 b=m92caypETHCaylAwiYmBsluA2h8IHi57m0lKK25jVyb0MxKpDxnMJg/vB84Rv9r8q7
 1liu/QGBfeSR4URo0o7VReMSlV6kCclhS2VYotvzqP9yAYPVZFlDVFurQa00+qytZqCP
 NDMlG3SSd1tQphOz0MBSXwID5dTMChSUk1E2pDwkzvmB4oOSXJGaNJMY8NKmxFz7sHeO
 kPPxyi02tqoylruSsU9gxhcf4THvCwcckenm2nQajUzm2FIKohn52rCYww7JRiddTQmr
 cIdkouXukEhjBIqZ5tj0ogsAmq2MN5+SRRIWie097+abP7jt+WHS5oeOhITaMtBz+si5
 8RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917929; x=1726522729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDeqiYVgIwcqrNBaozN3CWTTM4ZnqQyc1HdCwmTepQA=;
 b=hkPB6MkHKzXKzRfkIOrQNWOXWtq1qptHy4SjQ3fwEXqcV0pY7OkkCSVGtXnOJpfKGA
 k00OBJLe6hOtolhupGOWlLP2DGNJj6SXsPrkjEuawqpWyWqrMqpb+PQnbs5j0a0XLmLn
 t6yV5aAtlghNF2WiJo0OA4LQPVEeAGO6Xt0H9JMgxrzNWzr2QB8e69VwkFRTg8EflENp
 PkYP9mYl3P0DygKSaHHCRo7cVIJ2VV3BZWmINBQxCJ4UirWf7PbwyshTWnqWHBjJn/qN
 NDBx3NjrYUu2J0+xktAYXci8eM9mUFh1FNVmIDucxizN2DS69m/9+/y1hJvQjVL3VJYz
 B1Uw==
X-Gm-Message-State: AOJu0Yxl+33Hiwgl24OTIkkpeDj09rR9JZX/ez3WnrORrQKHT9FihAj9
 GN5tO5hkIIPMjwePm2JkxNDCzq9J0QPX9LYkBkNmmq8RMIbQtsdZyoOAsFWqg0kCf3ywUSK50C6
 Ih7Xl4x16Xy1GLaxDpAXXZ38ErRbqYUPS
X-Google-Smtp-Source: AGHT+IEkYdGvp61LOZ5Z+I/rfqDDqaLm43m9TwlqDasTw99IrsPi2eDfkHMYjpzJ1Y6zfxrrgKi8ID+Y/v3FtLwfxZ0=
X-Received: by 2002:a17:902:c611:b0:207:1367:c46d with SMTP id
 d9443c01a7336-2071367c76fmr38016385ad.12.1725917928968; Mon, 09 Sep 2024
 14:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-11-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-11-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:38:37 -0400
Message-ID: <CADnq5_NOwDS3J6vf8MyC4dGSU9HzvkZdceLt2Y+W-GnrK6sxHg@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm/amdgpu: Add PSP reload case to reset-on-init
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Mon, Sep 2, 2024 at 4:03=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> A reset on initialization will be needed if a new PSP TOS needs to be
> loaded than the one currently active on the system. This is possible
> only on SOCs which support a full device reset which results in unload
> of active PSP TOS.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 7901b3fbc127..a1e049bcd4aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -829,6 +829,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_de=
vice *adev)
>         if (adev->asic_type =3D=3D CHIP_RENOIR)
>                 return true;
>
> +       if (amdgpu_psp_tos_reload_needed(adev))
> +               return true;
>         /* Just return false for soc15 GPUs.  Reset does not seem to
>          * be necessary.
>          */
> --
> 2.25.1
>
