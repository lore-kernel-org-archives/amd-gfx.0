Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140DBC6FD1F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 21:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C9B112135;
	Thu, 21 Mar 2024 21:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AkOoMa1n";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C65211212E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 21:00:38 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1e0411c0a52so11247135ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711054837; x=1711659637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9YVlMNgbJZoCV/cEaIPo5ce6DOi7ImpVzzP5rwySeI=;
 b=AkOoMa1naVtKPeBNtnWmmJ4aduXsqZrMGwz2NuoyZNPFmLct8PtRptlZXrm+gjQhOb
 NMtAC2Vtv/1clImZnuofsvmp3rPWyt1tHqkfEdizRe5kBmCtlCcTb+6KHvMzAk4ZHoVf
 /1J+fYW/BtYd5r/9a74vcIrAyJCZtk1ntNwtIwpm+btUFqGDj4Gl+AnXNB3+To0ueXH9
 tfCBMU1twg6WsUbcKWXv0XBEKM7MK6z5fwKu0FCW3q1bniDz/SAxnowCaKoOEqkb0UcU
 3c6Oayiuo4a1zUnwDdUO8usvNR81o0ui8cG+tkY5k5fYzZqmQux+hZIFCVKmy1/4ZR2J
 2/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711054837; x=1711659637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9YVlMNgbJZoCV/cEaIPo5ce6DOi7ImpVzzP5rwySeI=;
 b=LOASaP9tY4BVcrv6k6U5Co4ZyDQusj+M67YYmIetzR8mvpzPRy3WNBEMN6YCo0UXgI
 KBnTDPnQQf/J6NxUGO0uhsyi2idcHB5pPcPVkcvc6W+PAd9rW7N8zYx5GkNlEnAQHdim
 KEUpPhP+lLAwk02AA8ezpZt6/kJy/MIBD3+4PUAQk8zWarqhfBoU/MZd5C8NnxXf/KDC
 U+WgUBv4AQni63XlMter46I005X+/0TaZ3AZOv6IotJfE+2eo5UUaFIugvfnR12bNr9F
 qQuFF0LPbDd6CYMZ+JePqz8W/YRlsDUJL59KHBouswylrqCE4VRDft7s49yFy9qzL/Bi
 zk7g==
X-Gm-Message-State: AOJu0YyRm/vWWWN5LLNMN8WZBSpv+++4e/6VWT0mhQxsfgthVkzk9XkJ
 2inbYupLSYYio95PeIG/1BViPZidku7maSpxHu8xdenzQw6nvPTtzyonxMw33yT8J00oi6lDAx2
 0NA05I/BQX6vKe29y4EVCYN5J95RWGcKl
X-Google-Smtp-Source: AGHT+IF6wxlt+HUk7EPc0R5J0QDrLr7wwzvudu3PXyTcv4+egl8rEqFyQbPme4bd8FqnuG84YWzNVxHPrZzIIoqpwC0=
X-Received: by 2002:a05:6a21:a5a2:b0:1a3:6a10:fa3e with SMTP id
 gd34-20020a056a21a5a200b001a36a10fa3emr840629pzc.10.1711054372839; Thu, 21
 Mar 2024 13:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240320183221.5689-1-superm1@gmail.com>
In-Reply-To: <20240320183221.5689-1-superm1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Mar 2024 16:52:40 -0400
Message-ID: <CADnq5_OJVPj_8GYq5VZ3kiiVHWHXi-g3aif18j=QBGXu8pE2qQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Flush GFXOFF requests in prepare stage
To: Mario Limonciello <superm1@gmail.com>
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

On Thu, Mar 21, 2024 at 5:37=E2=80=AFAM Mario Limonciello <superm1@gmail.co=
m> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> If the system hasn't entered GFXOFF when suspend starts it can cause
> hangs accessing GC and RLC during the suspend stage.
>
> Cc: <stable@vger.kernel.org> # 6.1.y: 5095d5418193 ("drm/amd: Evict resou=
rces during PM ops prepare() callback")
> Cc: <stable@vger.kernel.org> # 6.1.y: cb11ca3233aa ("drm/amd: Add concept=
 of running prepare_suspend() sequence for IP blocks")
> Cc: <stable@vger.kernel.org> # 6.1.y: 2ceec37b0e3d ("drm/amd: Add missing=
 kernel doc for prepare_suspend()")
> Cc: <stable@vger.kernel.org> # 6.1.y: 3a9626c816db ("drm/amd: Stop evicti=
ng resources on APUs in suspend")
> Cc: <stable@vger.kernel.org> # 6.6.y: 5095d5418193 ("drm/amd: Evict resou=
rces during PM ops prepare() callback")
> Cc: <stable@vger.kernel.org> # 6.6.y: cb11ca3233aa ("drm/amd: Add concept=
 of running prepare_suspend() sequence for IP blocks")
> Cc: <stable@vger.kernel.org> # 6.6.y: 2ceec37b0e3d ("drm/amd: Add missing=
 kernel doc for prepare_suspend()")
> Cc: <stable@vger.kernel.org> # 6.6.y: 3a9626c816db ("drm/amd: Stop evicti=
ng resources on APUs in suspend")
> Cc: <stable@vger.kernel.org> # 6.1+
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132
> Fixes: ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callback=
s")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 94bdb5fa6ebc..1fbaf7b81d69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4524,6 +4524,8 @@ int amdgpu_device_prepare(struct drm_device *dev)
>         if (r)
>                 goto unprepare;
>
> +       flush_delayed_work(&adev->gfx.gfx_off_delay_work);
> +
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
>                 if (!adev->ip_blocks[i].status.valid)
>                         continue;
> --
> 2.34.1
>
