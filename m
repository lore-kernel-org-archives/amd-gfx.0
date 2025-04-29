Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44214C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF99510E12E;
	Tue, 29 Apr 2025 19:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DOJ+ruEP";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0CC10E12E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:21:48 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so619512a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745954508; x=1746559308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJUZ1w+xGKyIX/87IWxR88iJmYxvi2ZT/gNr9iYBk4U=;
 b=DOJ+ruEP4xjcx8YeURW51WpaokoBcB48PYsyAFSTwpb51+aqJswO0lVqPnbzskSP0r
 ZJ2On/FZaeZRPOF7MjEDOqKwG5XRC1m2dUgHtkJoMVbldUi7KhR9b6vMsW0c9CENcpad
 NixUGGcAZpIoQWpPEErOPXLEwWsLWZOJ+eEpqk4sMXJ0M1z2MHkx68oYjX53sVGJJVkd
 iBCY04+PVYhCloztqz/tcKVmOBmn0qX8Y/kH8WKAxwuubiUSrVt5Ol/mvWHh+kkhNrVc
 93dwlcGXidp7CvtD3j/tJVghLWvE8eC70SBjkjahsfRQtOwQh/fuTHulzhClm3c/GIMt
 llFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745954508; x=1746559308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJUZ1w+xGKyIX/87IWxR88iJmYxvi2ZT/gNr9iYBk4U=;
 b=UEJ2nDFC3Xm7shZ6///YO77WTgZMJtEH4F8vMzk2wtS+vZf8Bzgqpl4q87dSmMRQdq
 BKSQU/iy+1FIRde9S6UAu8gXZBkagIlK8lYGq+LAhOFT+v/KwcjPnjJUMWRUi7uUgkSx
 jP1qpLbtwD1Xr1D+w8HDZROiqpwgi7MIyOlOGuzH7NZD1OKPPKivS6he2aXf9zEnB4r/
 rATMJ0AGvvffk7bEf6zePQ1zrY9GlyIxss/iGOphl9bJgwyotI/TeEiYaXYciaecN3dZ
 cCgbczbtqmMfy0uCL1Vz47PEE9jIVYtlQSeXU4sPWe/WAywyIkh7wlAVX4r+XQuc1QX2
 DFMw==
X-Gm-Message-State: AOJu0YwHyy/NU8QMK0cDRcxTOFJzQRIGLNiJ85hnuk6rIE+sI/8DBAjZ
 sv51sVq/wTATBhPEC0/jBkZQp9zUZiO9cEkHuoKX7UZ7PlBtd+9t+mirduXrslkPeI6lj3672SP
 IV7PgZ760MsFnvT16UKphPogPLLw=
X-Gm-Gg: ASbGncs5+CNwLa17MmwZPgUnhkFB2aR2kiY+O302eqjA0Zn2aJSY3c4JN4a7hqeth7+
 XiFOmCnqFETaRyJ38Zts8Op2YtNdp+f0NW0WrJp9vC1IzuqrQCsyoawfCCJ1cpS03ts4vmZg90d
 RyQly8HtJszXDPQyQqjSkVFQ==
X-Google-Smtp-Source: AGHT+IH8AJF8zg1n0qHM9DHi69pDhq8s3MnPPxH/dC1TOak6jdVKJHK9MkdGjrSkAQ3A7gXy2TMsgxCOfBT8abVCg1A=
X-Received: by 2002:a17:90b:4a02:b0:306:e6ec:dc82 with SMTP id
 98e67ed59e1d1-30a3336f8f5mr152352a91.6.1745954507618; Tue, 29 Apr 2025
 12:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250429190542.1896100-1-alexander.deucher@amd.com>
 <20250429190542.1896100-2-alexander.deucher@amd.com>
In-Reply-To: <20250429190542.1896100-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 15:21:35 -0400
X-Gm-Features: ATxdqUFSigvah31HDa_vUfrwJoNs9sc-LZp-WNcbE7kISo-pUDaFGvtG6SWb-y8
Message-ID: <CADnq5_PSsaaPKz=1DqGupeB7BrVrNMrJmO0=LvgAk9RH9mah2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: use AMDGPU_MES_SCHED_PIPE for reset
 queues
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Michael Chen <Michael.Chen@amd.com>, 
 Shaoyun Liu <Shaoyun.Liu@amd.com>
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

Will rework this patch.

On Tue, Apr 29, 2025 at 3:14=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We should use the MES_SCHED_PIPE for everything queue related.
>
> Cc: Michael Chen <Michael.Chen@amd.com>
> Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 83136fcbd50ff..e0dbce5976d50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -828,7 +828,6 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes=
 *mes,
>                                     struct mes_reset_queue_input *input)
>  {
>         union MESAPI__RESET mes_reset_queue_pkt;
> -       int pipe;
>
>         if (input->use_mmio)
>                 return mes_v12_0_reset_queue_mmio(mes, input->queue_type,
> @@ -857,12 +856,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_me=
s *mes,
>                 mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_o=
ffset;
>         }
>
> -       if (mes->adev->enable_uni_mes)
> -               pipe =3D AMDGPU_MES_KIQ_PIPE;
> -       else
> -               pipe =3D AMDGPU_MES_SCHED_PIPE;
> -
> -       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_S=
CHED_PIPE,
>                         &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt)=
,
>                         offsetof(union MESAPI__RESET, api_status));
>  }
> --
> 2.49.0
>
