Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191A4F483D7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCB710E475;
	Mon, 23 Mar 2026 19:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkJPqlwK";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F19910E475
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:25:17 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-127337e3870so396804c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293916; cv=none;
 d=google.com; s=arc-20240605;
 b=gvisUrhGAKUmvHjV6OMCjfqzsG2nzZvSgDrsMpMtK9vkK51cMVUJcK5VhylhVIdeaw
 LiNe/lOqsMWmj3fDMQxaOVEcs9mcLTPP0u51KSdWEk1bQWXa8AdzO5+0U5O990I0Xgck
 GAC7ISsATYhYLBLurWL8uqoXYKlyA5WiGHTyuN9FCeD5+bihYQG3v3DESUzFFqRXsEVt
 Emmsrvlw1KaSU/2quB7gDN8ADxVqrCRCMSxc/7SQDHgs6dq9rQ7MkQ6smKTm20U61wTO
 nK+KOkFR25gJRuvKzYqpijfCed06EdqAkWRa3YZoVjDN0ih4rh+w+kcU1tZUv/lLrb/u
 yEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C8n9UmBteze9sOTf/YqZAo5VJtOsGoJE8XojQAchjto=;
 fh=cetcAmHHBh51xnqqpJTNWjYLNW+VIcZhb4PHCr4NRwM=;
 b=KlRbv2T4BieuASKJbcODKtyhrKP1RNAhv1rnKt2s8BRzbJCBat/HCMqs/BY3O8go5c
 j6/TE49waq3niJc2QZVmICzjBTLxL5v2+hYpjwp+AJ3ZHlkv74QWKaXUKSFhK1qyWhIQ
 928N8uxzeq4Dv77lxsno+9Dvzp8kHxq5DzDkqL7X8AdVm+Asrpi06oITWZPdPtc6ObVU
 MZPtECe9tqdgQSi7DAYAmcr+ypy1eEsDvuvAetT/XuBP1A3L7gIreV9CXxXsoyOdSFV5
 j3wdknAZ08KQUI5OjM0W3rlG3FNyavMVqaC4kFucalPYtk1LDmUNOdt6i+BJRop0IzEN
 tIvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774293916; x=1774898716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8n9UmBteze9sOTf/YqZAo5VJtOsGoJE8XojQAchjto=;
 b=hkJPqlwKF39oL+rpDYptyVETEcJJLgNjY9Wwk9BlxkeJ0W5Era/LtcF5vDBSAvn7Cg
 DNsiAzHYQTQZAWf/+O42elU9M3qmTDYDO7jI3pxJRYTZMGfCbJpmv3tjOfczA/4yfqnq
 z+Y3DfTgLcQPAvVIKV9YBQwPMoDPIzLku8slEn8WL2e8f/frgoKGiP5iWSxyCctOlwvg
 44GjyQGa58ywbwPRXEQVhiN2r78FR+50qSd1/PBahOolv85h5d0bNxuGRgtzFzELwLfV
 liNHyRQSz1bgByUievX2inLbpjP8Lv90zLY7jFOQYG80BXeqOI1v3E7lDqmfTjUynVH8
 ZITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293916; x=1774898716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C8n9UmBteze9sOTf/YqZAo5VJtOsGoJE8XojQAchjto=;
 b=iN0Di/1VoDlD6nC0o9brGN2vURxwgp/SbpERk/HZLh2GIB3fGznUmjn4ibsVf7epKO
 dP5L2qpiCgLfKurN1/xmqpyovHTm6jq7cAIAd3xmz5boQXbVgdSz9rbZ8RP/TWI/TrOd
 RTvelJc55NL9YJhACgnYpTQ2Lqu0Q0VbJa7U9DtZkNDvqYuksaUrGTF4FYMMoIsaYVaq
 QGDhFa4pt2oIBo9kkP4nkgzko6/Dvh+BzrLQDW+leTc6T18eEo4os+a74z5r8XtOWBet
 ozhYSiC7DYLUxMnviqvkaj3Ljyt3kbqXHovH7V5ysI+K5PyNDjc+9lLWm+ZpfU2fDGPA
 k3lw==
X-Gm-Message-State: AOJu0YzAN6kdbf0seQFruynDhwX88pS1OjNqu4VKYZNc9mX5kZiivnm4
 juLwx/7bDafwqF+fMN0Q8k6Lch4WKe5+hLbqRTNSZZMjFmmu2TCbmZLHtv4G39U5p5dDXrB87+g
 NHVzH8OJ7K3YqxiRy19I6helmyu5fq+Fi4w==
X-Gm-Gg: ATEYQzyShX4ckZdPuc5m71Kre7ux+2A7AyPxcawUe8r9uyJfkZtN1swh/FYR0ulytSH
 hbnWz9rDFAFX8ByCD0Nsl0yuNIAZazd8x47Yxk1BPq/xuDLAM5wHFZaULYPxagTywx3CtkX8Meq
 SOL5LN4eQ9iZEL17J8wSWG3rBJUWlZLohFKrsQM3lPjY5tpdV8lD3ZAC4i3FOTnSp3asmppKUvk
 nH74fIVljbeG3NDggHu9UGTSJYJS9CbbCqlM1+i2ZGaETbQwPtcIO+2QwYhWsGfZsscjPtA/+aQ
 WRaCiw3kzgtgvYxqimMNIZCXLFJJU2ojOi4dQt2KNrL+cRop8cdRobTvSbMrjfyBZmkuUA==
X-Received: by 2002:a05:7022:6883:b0:12a:6d14:df9c with SMTP id
 a92af1059eb24-12a7265122amr3027297c88.1.1774293916219; Mon, 23 Mar 2026
 12:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260323184457.1244422-1-Amber.Lin@amd.com>
 <20260323184457.1244422-3-Amber.Lin@amd.com>
In-Reply-To: <20260323184457.1244422-3-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:25:04 -0400
X-Gm-Features: AaiRm53aTUn2WzgEpSGAoP72X5TjZR8BqIw63sozH8LSr_3KEK4zqtRDkwlNse8
Message-ID: <CADnq5_M-ik5E1pRsbi6B-J-J-eqExrFJZw=XjMHx00M-5uWkgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: Enable SDMA queue reset on gfx v12.1
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Michael.Chen@amd.com, Shaoyun.Liu@amd.com
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

On Mon, Mar 23, 2026 at 3:04=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> After suspend/resume sdma_gang is supported on MES 12.1, SDMA queue reset
> is supported too.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 4c52819aef9e..42d52c1f5109 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -514,7 +514,8 @@ static ssize_t node_show(struct kobject *kobj, struct=
 attribute *attr,
>                         dev->node_props.capability |=3D
>                                         HSA_CAP_AQL_QUEUE_DOUBLE_MAP;
>
> -               if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0) &&
> +               if ((KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0) ||
> +                       KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(12, 1,=
 0)) &&

I thought this already worked on other MES-enabled chips.

Alex

>                         (dev->gpu->adev->sdma.supported_reset & AMDGPU_RE=
SET_TYPE_PER_QUEUE))
>                                 dev->node_props.capability2 |=3D HSA_CAP2=
_PER_SDMA_QUEUE_RESET_SUPPORTED;
>
> --
> 2.43.0
>
