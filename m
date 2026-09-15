Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C5BC88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED50010E26A;
	Tue, 15 Sep 2026 13:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e8HEGwr8";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8021510E26A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 13:31:17 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-781d5f20ed1so146823137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 06:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789479076; cv=none;
 d=google.com; s=arc-20260327;
 b=k+iodTxrvfEdGiVM41o23amiwJx0xjoeO3JcIcjDQm6CX3uF015nRRz5D6xfaS+Ga7
 KseII53g/vpwiUhIuPJvz1lBmkeYtjl7FySQ/6+QNji4E6Muw23MgZjcixvf5cNtJtyM
 DZllUA7c8zpxfPdMA2TLx8dG99A25IFcWreVcRr5bCg2GW2AkaPmpSSHm9nxG5j2JjN0
 Ul6uLQDogYlOnL/StaK32m7VrVaAYL+7s5dfo9C3RX2CAvYExMiqdVxphZvK3PjuufY7
 4qneU47TpKf+es+uUk5oVy9/WYRXDOb8hGtymKhbRc/Zjh6c23uTFDZiRPOr5av+bPuX
 8Uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iOhLotLws5HBy6YtNhub6hYD1X/2/+P6I0AzSOTEdrA=;
 fh=4UJ76InYkn4ZUBByGZye+U96VlXO28IZpTj6g+q1zYg=;
 b=fG5MSjaidZYfednWCxrQcGU93vRbj9wifcNKrZ6JzANKOY36Gk6YGZlSQS1FlmrIQp
 YGI/WUSB8sQPgoof5+Y9et5ze9q8GX/+qYeTRd1ZwKDPRlbZh6rXjG0Xq8Ioi2Ly0fcH
 hv9FzG7P82Rh1s68v+iJ5vmibpgTx58WwINdVqSM7ox/GKTdFzQrE1PnOGJ2t4CsQmv/
 PgGz+ALTQAxmZG7/ClLHfSeSnnVaVt+W9WfrZcVRcZvAqVrrhjIZ0cp5R2fzVyh25Dna
 gG7P54tfD89fzQQoFCURTJtzrwtVhALAHNyih71kM1fMzHPIMGgFks/YrFvlZDHegPPk
 iKjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789479076; x=1790083876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iOhLotLws5HBy6YtNhub6hYD1X/2/+P6I0AzSOTEdrA=;
 b=e8HEGwr8GFWW8LmR737CXxxeDbxKySi6yWl7Pd3Ya5qkdtRm47Uh/0X385V1S82jXr
 IeCZ6EgAspg4ROY2t1920sqvCUvy+efn9pEW3cE4bhmm3hAjzw1eFDjaXpWKoQcSCevP
 XAqb1s0wtskx/pKGEIeI/DOomtMdVjS7PH+WBUxlDXOIHFoVSIbmiqR8eMfHIgx0VsC0
 FeYFMrGJAkF1/aw3AXfmHXK6/5LTDQ++GtgaVTmieAlu1BmZ94W1+XIaJYhLWpJBqZeR
 xDzyUHmUj8UxtwuNBSCssZ52TikLJ+Gt3o5QEUMZZy3AY75w+bzV3gcIYv0KFlzOOJia
 bdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789479076; x=1790083876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iOhLotLws5HBy6YtNhub6hYD1X/2/+P6I0AzSOTEdrA=;
 b=gD9nkr3DuxAs7bHyqG+HcgMS2ZGrnrX6YKf7ppx3icUfjGDVdaL1VvRHCaZo6FMjCY
 +o5A5o2RgafkaoHr0wuETfdsfvVJgbBaTRkdzCo2S7stSlQg45ZGoLKVhVtuie38/XIG
 Dh4t04QknPBEdvfCCdPPIu3ZV33sQg8Ur/V9nm7EXsPJPMTgYfI7H3iuXEDQbmkuSmEx
 SuAgGh3A3blKcixBggQwrLzcEPKz0hg3sXxOq2rFF70JwwHXRBLIrP/Schm/lRK96z9b
 t8kAobZ2sf47oYDhXrc8eLrXhOgUujE3iZ0SgP/gbQHL0b5uIisyVocPV3lL3Cz8gdsB
 Q4qA==
X-Gm-Message-State: AFuF++l2+FJ/BKarVTqF8g2QTqTCckGF4w+Uh6BsW0qR4fHy9cN2o+ni
 LAzehaKd+2sYLw/zq+UMFubbSe6rdS/jRENjHjymex2svtZqwY9GEzoPgoeZocS0Hh2Gh4T+IvA
 +bXhLO+e3+d7kuuNFH8xDApvIZUmsCtfLdw==
X-Gm-Gg: AYBFou0ojBQGgiaDuX/EeFA1z0C7GZngQD9QRc6tBfgiEHDlGj0ZcosVTJpkKF0delc
 dUDxbN5n567AUt7qd3nxjllCtT86cIPv5dIAtus2cnTwqIeLMKDE6FuJUpHCX/qR8R9HbHbzFB4
 u5esavHyh1lUc7im19P0o6JwjJpCq6hQzjHNzXmn05hej3W/ny0+kPLqOatAdqCSGuHdp84/nCk
 5gfsPDOHGXD1rQGmGPwOtzBqov7pbXlwTMCZmghaabd1bgdeomz0GgfT5AGOjM8eAw1iCjEKzFv
 O8WtrLS//gtiSoK+4KMWT6rSrmQvNusBL0znGFSdHqVcR624Pg9+mQ3es9kLq/cVed9SOifQaZt
 2l5qlNQh3tsJXdf/tfJzN52o8/9e5LcSgJoTklXxO+Q==
X-Received: by 2002:a05:6102:160b:b0:78f:c6f5:27c9 with SMTP id
 ada2fe7eead31-79b509df7c8mr2245534137.0.1789479076268; Tue, 15 Sep 2026
 06:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260915124105.14623-1-Hawking.Zhang@amd.com>
In-Reply-To: <20260915124105.14623-1-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 09:31:04 -0400
X-Gm-Features: AcwNN1UduAwf9qEShCD_bJs3BjzB-76gI3-3Blpb2wrYlzsTzL0vlp73wjRZuRk
Message-ID: <CADnq5_MweV=-U5VZkd64hNxBGn9C3+dU5MP=DTdH6LpWxMqN3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx_v12_1: Remove redundant CP resume
 programming
To: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Likun Gao <Likun.Gao@amd.com>, 
 Horatio Zhang <hongkun.zhang@amd.com>
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

On Tue, Sep 15, 2026 at 8:51=E2=80=AFAM Hawking Zhang <Hawking.Zhang@amd.co=
m> wrote:
>
> This programming is unnecessary and can be removed.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index d7effa43c0fa..a2f73a71f11f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -2377,9 +2377,6 @@ static int gfx_v12_1_xcc_kcq_resume(struct amdgpu_d=
evice *adev,
>         struct amdgpu_ring *ring =3D NULL;
>         int r =3D 0, i;
>
> -       if (!amdgpu_async_gfx_ring)
> -               gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
> -
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 ring =3D &adev->gfx.compute_ring[i + xcc_id * adev->gfx.n=
um_compute_rings];
>
> --
> 2.17.1
>
