Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32FEC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 22:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61ABA10E7DB;
	Tue, 18 Jun 2024 22:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Quga+WqQ";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045A010E7DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 22:07:13 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2c3051aee3fso4924732a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718748433; x=1719353233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GR7zXs0PHqzWuzN8g6oyR90A4T87/JZIy8yCqH66Pu4=;
 b=Quga+WqQ+KEjt9YVYhGT1/O51HRHYy6nZL2j08zXOUQ5ewmlGDjnuWzHOvDwsemiWg
 aTEywHkXe/Yzh+3ZPlKzxH1HYk1lm9Yk3IoomsqE9R7EAck4BtoHPXCwOc6x0Fb+p60w
 0bO+BGRMM9C4UIMbiL0dlKz9feRFfWfVvI3NxjN/5rS0GoqtwOlH5cdiPza0ZErifdZA
 n3Gq5i3d/KSshhTNKW1Xou8GK5dkmS2+Qqa//Z0w9+B9bEcMBbTWBmpDXsbouJU3AgMB
 E/oQdjvgUxWFNeqrg4W3/AC01TjN7sLl0ltNeXD3dQz1Awtih71T0zVtGJvlpQ1N5z4I
 LunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718748433; x=1719353233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GR7zXs0PHqzWuzN8g6oyR90A4T87/JZIy8yCqH66Pu4=;
 b=Axgt9jcLec0Ro4htOc6/AA3IofLQPtQSXRt42xn5SElD/hRK3GDLpCcp/fSblDbCRA
 g9sixo7b/yS7ygGARzvivEH2dZCmPwp6lDRxK4TrctVO+CVKtyedHBrXyXb4+rDB76Hl
 QHIAj+bRHW9nXzZHlGpcJUTz7kHg4NhAn2dhx5w7JRh1YP3ybqYamMbuIc51PgHBDw8k
 OBjIWQHis+ZOgImmoUNPjx8Ye6wNdf6sSUt9h61AFVNpy5tpxQyUvo2wWJSh9oGstdMb
 82+WaZ6URElyvjY+SSS2aeSTX2n/w2H8EG3JB06CXmtZX1vGDbjlwdKKVtXstLcrGmpr
 p5vQ==
X-Gm-Message-State: AOJu0Yz7vUQUDn+em48aK2HVqq/sLlsxPERtbCwsM5ZtM+SOngX4N1M3
 e2wNbQq3mgmmM8FrHxw4v6RIYkom1Z9fAdYj3w6XR/av1HNFewj0NSATEWoHCfBA1n3HvcIE/Nh
 BP1NOgCwni/y8R3ZlRQEvuFM6iK7u8A==
X-Google-Smtp-Source: AGHT+IELZdU+AitsOd+pvip8GLUgNWGcdrNDWWzMiCb+t4uHpH5UHA+JZL3C8W0LcXy93Y6lmSZ4IWsghZ59ZiqqcTQ=
X-Received: by 2002:a17:90a:db43:b0:2c7:6305:990b with SMTP id
 98e67ed59e1d1-2c7b59fa96amr1057531a91.9.1718748433358; Tue, 18 Jun 2024
 15:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240614175458.459062-1-alexander.deucher@amd.com>
In-Reply-To: <20240614175458.459062-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jun 2024 18:07:01 -0400
Message-ID: <CADnq5_NBA0M=xdDHgZ_g5n+-WRu2rxx-mGm_HAo9+aHJVunnvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: fix parsing of vram_info
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

Alex

On Fri, Jun 14, 2024 at 2:12=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> v3.x changed the how vram width was encoded.  The previous
> implementation actually worked correctly for most boards.
> Fix the implementation to work correctly everywhere.
>
> This fixes the vram width reported in the kernel log on
> some boards.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index f932bec6e534..f873dd3cae16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -433,7 +433,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,
>                                                 mem_channel_number =3D vr=
am_info->v30.channel_num;
>                                                 mem_channel_width =3D vra=
m_info->v30.channel_width;
>                                                 if (vram_width)
> -                                                       *vram_width =3D m=
em_channel_number * (1 << mem_channel_width);
> +                                                       *vram_width =3D m=
em_channel_number * 16;
>                                                 break;
>                                         default:
>                                                 return -EINVAL;
> --
> 2.45.1
>
