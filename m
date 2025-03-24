Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A341BC36008
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4539110E4E3;
	Mon, 24 Mar 2025 19:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SV6VcxFu";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC2110E4CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:49:10 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so1280986a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742845750; x=1743450550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TizjC89BrQ6UrX7gUaUz3W4/yPZTSretLwAxoPAx2HU=;
 b=SV6VcxFumVsccTWv8TgAONjR0TU2vXreEiwaEuw4FVyQjXTz0m8sgAj+DTOHwFsbTw
 LtSYgZu+jTCOC1EAdt3+CgQoaSKLo6gm3XO4EoUal+F+5OLCylFeVJGCy/sB5fKo/m6a
 uJbsyelAGxF0ZJR/MbOhE+Nfa4Ui9oKN4n/gKbeNbecA1kofyWBsxCJoY1bFCBc3p4LB
 CuONzHexGR3XAWhGEqkrIfqqdV4xKMohmwUfGuKTIVHH+lwpo3E/iuSGeS9L3jOaaPoj
 ur27jyvThN4GEKdNCP4Ln5G1SxX2kxLrGXN7g2bvEPC+J15yRnVcU6o1RtaWIrrvrWqC
 sHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845750; x=1743450550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TizjC89BrQ6UrX7gUaUz3W4/yPZTSretLwAxoPAx2HU=;
 b=Tcemc0/6SETnxOwhecxs5WEBxe3KUeKVBjzPnGbXMm+xJLZPoBKdhK02ZcPls4bzw6
 lhL6Gu0//DtYyIAlkU6FVWLKOcxMeLy/IPXzeH9G2P6vskEYUgsMu1WXkwvMeOGMN4Pc
 j6IiQVD6EBB/nUVYC2M0kGjyc0cUAl4rHc+//NBEUhXWFsAsSuIWNL4SqKnlHSmlu/3a
 5WAsq0t1oOPgoYdWi8heUgaz6AwiBHiZmFNiTRQ63TOxbgkF5uYBNibGkYqd7fca3Y//
 oUjCz/5mxOQzcxEk23HjyYCIYc5HUnhGrUCZgi0pr4Ws7LbX5TtyS8yHNWPrgq8YEKJc
 RlOw==
X-Gm-Message-State: AOJu0YwKbeA+I5j4FsvrsTpc/fU9j6jeaZMIdNsqLnWN0ZLyW1CcrH4I
 UfW7QnV9BuhyreSljpSVVO1XlZHIf+2OF+CAV1/N1vX4SMlvUpmwXTsjR745JWjsiYr0AMeP/bH
 A5Ihci1PnqveuNTLIEmSuGgyp8eftRg==
X-Gm-Gg: ASbGncuAsNtKQX2PLiJNHQkjoN6uFiIoxB0mXw+nniO652IJVfcBk8C7Qj4JMr+4s76
 n/jW95C3YSs2KFGuMSMFTZppjl45mlJ+33fdfmsh+zxrZIjII20+R1M7amcbA1bPKO3NRZed4tW
 l4suFNtHwZ2juXwM4yWYAW066aIg==
X-Google-Smtp-Source: AGHT+IHN7qv4VYsDY7CIvUebWfxqqkO6qpj6m8Tt9ZDCP3b/CX9aievenby2tTABtJBm6fgvW8leIg/jcBQh9sCwtGE=
X-Received: by 2002:a17:90b:1b49:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-3036b4d6c5bmr97438a91.7.1742845749525; Mon, 24 Mar 2025
 12:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
In-Reply-To: <20250319162225.3775315-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:48:58 -0400
X-Gm-Features: AQ5f1Jr_DscnB64vDQ7nYHQtrl97P6ZKNe1BuQRVu7AVqFFK2V0xsNJquIV-E_I
Message-ID: <CADnq5_Pgng=x=0ywu_a0pfyDR_mhDB8=05skfoMS=pgo9y5aUA@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu/gfx6: fix CSIB handling
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

ping on this series?

Alex

On Wed, Mar 19, 2025 at 12:23=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> We shouldn't return after the last section.
> We need to update the rest of the CSIB.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 13fbee46417af..cee2cf47112c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -2874,8 +2874,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu_d=
evice *adev,
>                                 buffer[count++] =3D cpu_to_le32(ext->reg_=
index - 0xa000);
>                                 for (i =3D 0; i < ext->reg_count; i++)
>                                         buffer[count++] =3D cpu_to_le32(e=
xt->extent[i]);
> -                       } else {
> -                               return;
>                         }
>                 }
>         }
> --
> 2.48.1
>
