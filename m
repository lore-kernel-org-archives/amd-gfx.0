Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B6EC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 13:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E99A10E110;
	Tue, 14 May 2024 13:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cETJmJ86";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0E110E110
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 13:33:44 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so3749697a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715693624; x=1716298424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SuQAw6ZdPjFJk5B+zekPkr80k9aPH9wgV2V8lOnbG7o=;
 b=cETJmJ86tfKU/Tx/MfN7JbFPTsHq/jYG4HGmyhZ1puGZKq+aqlIlTCPV8At1fqujvZ
 6P7jgyLE6esI+ndM//drZQyKjOPiKPu2Ch72+1hm89BOEfupu3Xl8XotirBA2vZBKeHk
 Xw33DsQYhC81GMJW9o7CXodxacOYnrz8o7ICwhOgIGiyfTYXdG0bo9SqYyQfUxF2to8F
 AKGVuz3tsM0lQwvzhK32Zrr8vtXR8MHo9NAjEZkyKSlkj0dSq3OHzh1nxRcwoXwZXQ/3
 TY+UZ/hROxWjdpnudKJhl4Cgu5yh4CEvLOmTTXWsyuT2Qtx54T5dwMAARpilWSzeiGye
 VI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715693624; x=1716298424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuQAw6ZdPjFJk5B+zekPkr80k9aPH9wgV2V8lOnbG7o=;
 b=FC7zd2b1/9KZifBHLomH5uKFQi2qLepDVnG3zP6aBwAr3x7vArfX85njEScxYT7G+P
 mfqjFVgDmeOIJnQejbTkQajxmCbwURkJ5CVWqzvRvgOPVK4PJwBOKQghEO8X5NVlHxpr
 aXr5reJc5R2vXJAD0ZCwzJzlEy9bh+1hyML05WvT+owR0rotqZD6FcwL7bZKZySqP8Mo
 toKz1Os/y19rfFFVSKmNJRqHZpnK/3T2hebPfVPSNRRy5mLcFrMtfQUbfe5zdXJ5cFgW
 r8eY3Owp8iH0/Bra2CSRiCA8BS2PTM/fImoFI8hqgQG6kmU+L0u6+HM3FAPfp7UB4BxT
 oiiQ==
X-Gm-Message-State: AOJu0YyTcTEJdjwF7a3jAuVg/nQETYStl6jmiHqzY6YDkSpS1LhRCQBt
 1WH5I7OLIpryiAkbE6KuIQd1skxguux4NbQ2xgX88xqQjWGCtitToCswG4K9zXhrZmo0nByP8Oz
 ryw3Jw5hNdGJQXQQj9zNukErxdmXGgA==
X-Google-Smtp-Source: AGHT+IEshDT2cN+tzYoOY0Zsv5NxireON8Dbu7ywm6W/8UcZ0Xc0RmotVor0V0/AD2/nStTb+dUEUnpQciIe7PCKUB8=
X-Received: by 2002:a17:90b:1051:b0:2b4:35a9:65fc with SMTP id
 98e67ed59e1d1-2b6c75dce41mr19002669a91.17.1715693624240; Tue, 14 May 2024
 06:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240514083440.15519-1-Frank.Min@amd.com>
 <SA1PR12MB565945AB698B03BCE837A1F5E9E32@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB565945AB698B03BCE837A1F5E9E32@SA1PR12MB5659.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 May 2024 09:33:31 -0400
Message-ID: <CADnq5_ObWbRQqYpMKZ0DAg3khhLKRufruWjeLpEqboqzqKcx6A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: use mc address for wptr in add queue
 packet
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 14, 2024 at 5:07=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>
>
> use mc address for wptr in add queue packet
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 5519655fd70a..6256b21884ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -267,11 +267,7 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes =
*mes,
>         mes_add_queue_pkt.doorbell_offset =3D input->doorbell_offset;
>         mes_add_queue_pkt.mqd_addr =3D input->mqd_addr;
>
> -       if (((adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK) >>
> -                       AMDGPU_MES_API_VERSION_SHIFT) >=3D 2)
> -               mes_add_queue_pkt.wptr_addr =3D input->wptr_mc_addr;
> -       else
> -               mes_add_queue_pkt.wptr_addr =3D input->wptr_addr;
> +       mes_add_queue_pkt.wptr_addr =3D input->wptr_mc_addr;
>
>         mes_add_queue_pkt.queue_type =3D
>                 convert_to_mes_queue_type(input->queue_type);
> --
> 2.34.1
>
