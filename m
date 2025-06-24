Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A34C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 16:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDD510E096;
	Tue, 24 Jun 2025 16:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihFgcOu4";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C5510E096
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 16:17:46 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-312a806f002so540374a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750781866; x=1751386666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUbZqnlDZlosDCtDXqW2GMdECIVKzOU4ZRMwYtBtZvs=;
 b=ihFgcOu4rSGChi5jNgeqX2rFTL8dMazLrEMG9mTFeDsMYPERRt/09plXvi9mlPyDGo
 ePL6yUuOHh5zAwjos+Q97hNIjFSPNULPFutWlZO2Q3mq80ij+TgiX2/mOphSQ8T6cMPv
 jK3XGbz3536HTIjXZ1Q8GqMc0PnD0I7KMw6in6mATWEnFI4knX5HhKUIxXYlgfz24IUW
 app7e8vPEdULAYOa7TtM72vMlCQXHbCEY7WL4+oeSURFCFGdwE3W4X8PbrsiZYyX1UlA
 VlZ7xUqx1zh7AXQckte2OhF9vwSUraFmTF0GmTO7c1spHWcgDKc7sgfArmwcRg6v4L3g
 d5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750781866; x=1751386666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUbZqnlDZlosDCtDXqW2GMdECIVKzOU4ZRMwYtBtZvs=;
 b=amf1use9G1+cBmepBqGngsG/2md+unB5Ct/FKs/Q5ooRtdMeRdg87Vjxys6TgpUwDT
 5CzVD5ErtBXOkqX8sT/DmLSq9a/+FvPx/ozdxZ13T/YBOiYRSHV6I88RXYd3e2Eph48O
 YlvWMrM99WfYs6uaYew6JQTuRVCU4DuKIGB6mYEDsqgyCP6Gl56VrrOhTTvJzYEC2DE4
 oKek1FQ87LjMCtMRmCKWj3TuqE2XttimEhWa0+frZ2EAI6QjZay0v0nzXb8ghKECnaas
 zWXkC9CLzbGSw5Twz8YkxX6har+Pv8ecE/ouD0k89eX4HO1LB2bltXhBQCV+co6HUP5l
 YPaA==
X-Gm-Message-State: AOJu0YzkpxLiuE/wORt9VfO5HGFmLpKeEteCwBbaWd+WcbgoOx0bgIh0
 e0ZgreS5xxn+rp4XrJkL90S/ujyHouRjIpoO0LYUSx5zCqkPeOmUR5UAPHLZusKT58viWCP9IP0
 US1DOka8PLkEWfJYeS+vEkzZUq12+JXHXzw==
X-Gm-Gg: ASbGncvlSi/B9HPmiJAFeOAkiV9s9c/4sheHVljWyEQz5QXeL8pHbb/iVx0OV5C5lVY
 JcemG2Kcqp+plDgDS0+cNwiyFzrjvkWZh6ks69xeOCoOY+LvkFC6KojWEanvxwfPvwp4BLNFf8l
 Pos1e4PLp1wZ0ymV+OFGwNxsHF71HbTE0pkXpLjxhGpC/p
X-Google-Smtp-Source: AGHT+IGf4ohEbgt9jtQTQ7mUo9bTmIHRyniDgrw9yMRujzQO1wpT6WnMtmvE5Tr/aLKK2jHICgDV71T+tImg7DeAaaQ=
X-Received: by 2002:a17:90b:6c4:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-3159d8f9d84mr9805276a91.8.1750781866142; Tue, 24 Jun 2025
 09:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250624161637.6375-1-kent.russell@amd.com>
In-Reply-To: <20250624161637.6375-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 12:17:34 -0400
X-Gm-Features: AX0GCFvjmxGcwJyfeg40hti7_w0pOKytZeX7sdZMl3VYORCQ8WPOJQh3elx9UCA
Message-ID: <CADnq5_POqoQSWDUkHQomNmfCDJ=igkhaoye1Hq+hzrf0ehC78w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Include sdma_4_4_4.bin
To: Kent Russell <kent.russell@amd.com>
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

On Tue, Jun 24, 2025 at 12:17=E2=80=AFPM Kent Russell <kent.russell@amd.com=
> wrote:
>
> This got missed during SDMA 4.4.4 support.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 5b7009612190..08ddef027f21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -45,6 +45,7 @@
>  #include "amdgpu_ras.h"
>
>  MODULE_FIRMWARE("amdgpu/sdma_4_4_2.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_4_4_4.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_4_4_5.bin");
>
>  static const struct amdgpu_hwip_reg_entry sdma_reg_list_4_4_2[] =3D {
> --
> 2.43.0
>
