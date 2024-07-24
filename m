Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DA5C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 23:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1079D10E0F5;
	Wed, 24 Jul 2024 23:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RkR0AJRj";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA7910E11D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 23:15:31 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-a77ec5d3b0dso41168366b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 16:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721862929; x=1722467729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvkUWWQgb1VffP9luDIO67KOeEP4ozTCgv8J1moSLhE=;
 b=RkR0AJRj4mGCoUu8TPN4h95DAFfjJOOsPqpPkDK0CiiQKSu5NTxaKdp59fni38Xq2I
 j+C3jQSDGXH8jWsJ/BvYtulurm862jLS07cfVSY1P3rTbAsqZ0hUge1e5VVHrSkhP5Y6
 yJb30bTn1s6RA+B1aXNaLfoUUnMMx0xfLfew28wfJvhMqXxwyTbZsuINthURN3QJbtIy
 xjSdGiIQ399EFjncOhFZwlOnTejgW5u3VuEfuDWXoQIwf576RGD7ZyCowzbkd+eE012+
 NpI+cZfOtPwddXMiTSghAhJW++CC0j7o+Rk89PtRIoJ/YYaR2dpIpw3XVMZmclDIU6Vf
 tkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721862929; x=1722467729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvkUWWQgb1VffP9luDIO67KOeEP4ozTCgv8J1moSLhE=;
 b=iU9A47mWmlhBVnPF/1AZKjPSOZXfUecsvDY8WQljHKsVtMty3n+ONbtlMkmPk12bqF
 /lOICP2eFUmIS3Lx/5v7IGEwnwu3C10jY4q3yqPKmauwbKi89yCgJH2sfHAOyUybBOMA
 t6vxmTJm2QVYk6lEgNpb8VW6a8cYg/L6Q8t4J/siwQwfUr7O3fc0RmEiEU+vAMmtNx1Z
 RqSyBe7VEca5s0kOuvBoHVrWV9Ag5taPPq2v6j3ktFrcH9EZz1RLWG3iLO/wLr5Gb8V1
 WAgAJQKKdNVa7YGXk4SxsWsS+vSuRJG5bWy+JeL5Gy21EGNLPrExIEbyyAYdrPLiWQSZ
 jmcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU76+6gXssrYrImG86B/Lzjf/eKwjQVzCPxLkSrfhlqpDuHvcTpslioWq8A1EKakFy/vBzpCXT3hAFz3Bnt2N+pGqnlWlZTNn4jewGnVQ==
X-Gm-Message-State: AOJu0YwSfgmvHDh1VRSIuVSvDTTdDATvfjL57ssVigsY0TCxf/4doaNB
 1rl2GhXFaKzkAjEbkHTRG1XeO7IqSp6LP1EKhGXXTzwlIg7tR6M9obBu1UcL/5e2jsVfE5hvB4j
 /djPjoz1tTEYCsR19kyeDW0nilhGc8phdHFY=
X-Google-Smtp-Source: AGHT+IEqhvtwx9M961kRPhOvXnBEb+hjZNYUQDOUo3ls4Cfa6x4uidxK3AiY4ICuMKn9neXj65EW58XICFPRX2duGs0=
X-Received: by 2002:a17:906:c10b:b0:a7a:9954:1fc1 with SMTP id
 a640c23a62f3a-a7acb4bfff5mr10615066b.24.1721862929011; Wed, 24 Jul 2024
 16:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240724075047.57198-1-christian.koenig@amd.com>
 <CADnq5_PM6kfgYEgJmoCFXD8Rpiy2xqHzgy0Q=VLZejwpJ_ZAJw@mail.gmail.com>
 <CAPM=9tx4UjPBtKWxHmPfHWSNYtW0=y21oseRp4brz4b7EG-zKg@mail.gmail.com>
In-Reply-To: <CAPM=9tx4UjPBtKWxHmPfHWSNYtW0=y21oseRp4brz4b7EG-zKg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 25 Jul 2024 09:15:17 +1000
Message-ID: <CAPM=9tz4wpZ9ZNVbVx-xj1Vwd2W_cojRMZeYbo=U2i6hG5Jrfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix contiguous handling for IB parsing
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
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

On Thu, 25 Jul 2024 at 09:09, Dave Airlie <airlied@gmail.com> wrote:
>
> On Wed, 24 Jul 2024 at 23:32, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 4:00=E2=80=AFAM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >
> > > Otherwise we won't get correct access to the IB.
> > >
> > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3501
> > Fixes: e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour=
")
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> NAK (just capitialising to avoid it getting committed)
>
> This doesn't fix it, I think you also need
> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS set as well.
>

It does work once you set both flags on the bo
(*bo)->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;

need to be added as well.

Dave.
