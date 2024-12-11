Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72842E7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 20:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0284010EC2D;
	Wed, 11 Dec 2024 20:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dgLjU6N2";
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD2010EC1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 20:08:51 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21644db9f3cso6188005ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 12:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733947731; x=1734552531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MhP8BW87RLRwafKzik92viifalfTT35Oj4i/pit0Fo=;
 b=dgLjU6N2nJmzAmTZj+MwWc0qzRCc0gZZR0vSD9PYQakmp1luchbh4h074iQY8Ino2h
 qlWkhiE+Gn7G0w6pxe45dOf4u1gCqargyWwcvQtYOK9jTgsR7RvuEOgHWi6b8Dxkn6ox
 1IGDIF66sfxrJKhgwNQ3Oj08XQ3NBmqkr+e4ODFLFIm8N9LPP05DXhs8AlFu9pnQIhLc
 OBv0YDCc/zW6OSbGqR8iBLDm0wWuZlJmk1iuUlp98QoIIw+zZ7De5/G2TnrvXqONII2H
 tGRMo/It1MdKVhvFBATRi9EHLTeCdkKelTuRVVD/wdOPrH8fiMg0vXR/g/Xdbt8lqP3W
 XYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733947731; x=1734552531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MhP8BW87RLRwafKzik92viifalfTT35Oj4i/pit0Fo=;
 b=cnUzZ9JURZLN3j+W5/Xc2OgtYrItHA4QS5qtA1hwj3uaZ2eHAXHmpp6nBxx41hWSKp
 faczbZ1K48L66wRsvNw+EZFR2h6dEJFkbQhNZ9R+w95J9SPBsDIsiw9BtPIomAfWqqvR
 uN/hNhl4AIqJzGv97j5zgj2exV5BrVXtl5QSd6tr+SPkz3pm69pUga5CGeOXqFtx1AyV
 33sD1aId4JqQs8DdEzcjUoOk1T8cUzHlOgA5JttXg63AW878vvlxIjxNhHC/eUmGrzto
 9Nw9L/Hqi+51VnSLnXiaBoX8n/+7we/iNY2U2Ly5k2Kj5+bU8/nm2dEejbXPCLI1HOBr
 10Zg==
X-Gm-Message-State: AOJu0YwQ1Idj5t/lbOqXw0RbLLr/TBT+Uw0D6ma8NUKz8YQBLGDFrA3X
 BzsVx3XcQ08uzTvPok25a08C/VnjYlf5/Yhx+j9EVy8t/IvueWYD+wiqipYtBzH/Y8ShEd2nT+i
 AjbBNHhUS7emAskCNQdlIYeT/OyY=
X-Gm-Gg: ASbGncsUMPSJR8Z8I/7+zhWhENms0+4nyzzxs6lhxmJbLc9SntTfGj4WwgOAgRLKdp1
 lKSwUXRZ7jzbuW+YMSuIANcZyu5oXh9MP6Lw=
X-Google-Smtp-Source: AGHT+IHxDZ8b0zbzGz3Px345GCSZa6CJVogWLLhrkEpe3WBqbBIq7v8vd5TegJmCh7DbVqMQ3T3Au/VZDrvbocXE2dE=
X-Received: by 2002:a17:90b:1a92:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2f127fc732dmr2429404a91.3.1733947731003; Wed, 11 Dec 2024
 12:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20241211155601.3585256-1-superm1@kernel.org>
In-Reply-To: <20241211155601.3585256-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2024 15:08:39 -0500
Message-ID: <CADnq5_PxZP4fgMcuD0xD3m2Y3_kbOV_wK4Qq4GzGHJB_9wxepQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Require CONFIG_HOTPLUG_PCI_PCIE for BOCO
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Gabriel Marcano <gabemarcano@yahoo.com>
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

On Wed, Dec 11, 2024 at 10:56=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> If the kernel hasn't been compiled with PCIe hotplug support this
> can lead to problems with dGPUs that use BOCO because they effectively
> drop off the bus.
>
> To prevent issues, disable BOCO support when compiled without PCIe hotplu=
g.
>
> Reported-by: Gabriel Marcano <gabemarcano@yahoo.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707#note_2696862
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Seems like this should affect any device which supports d3cold.  Maybe
we want something more general as well?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 764d41434a82f..7db796ebb967e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -419,6 +419,9 @@ bool amdgpu_device_supports_boco(struct drm_device *d=
ev)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>
> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +               return false;
> +
>         if (adev->has_pr3 ||
>             ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>                 return true;
> --
> 2.43.0
>
