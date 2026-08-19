Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD95C5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 15:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0F010E57B;
	Wed, 19 Aug 2026 15:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cwpUS1MU";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E1010E57B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 15:32:26 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so200034a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 08:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787153546; cv=none;
 d=google.com; s=arc-20260327;
 b=cLYw6YS4RruuvGqA13uLR02BUEuWmf3qOlOpysfX2YdaIHw2IIiYpttuMpOK+k6mZD
 LHOqKIORE7BEoQeh77HkwxMdBChSzFHsCQ57XtevBO7LkVcmDzdopU0cyIQc+H33AlHY
 az/5M9JBu8V5hDyfhJETL6cTK80q2L27v8dgPmALy90tD4W9lGSuWp3hggQkR7DNX39f
 nI/dw2xAkH7/cUx1EXBJY6ossqXrD5Oj6ulYevQJjtmJU5okomWZLpNq82RavoUQ+1Dw
 vf3mK5BcndOE6talMA/Cl4dPNFqOjPyu1DLemk2H5pOtKHYd21sZ6tyXNTeRCO6Dfgrk
 Qh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gFiLuwPOf9KbwAW1Nsk27CfvT+gWuzKy8TLR8DK7mEg=;
 fh=pR+xxbQkz/85rkrkRrB3UrflyQIzReje0SPuoaurlKc=;
 b=JwXeYdTYZcp2EUIWTa/X4Olt+5NnCIx9qDTF9Fvl/flN0crvFgwDwtFt+5BgT1dNiJ
 xdwxDk+nUYgolCzCsxkDhoQb+IiKp4XDSK2ovEN4v9viX14ECzesWiw2z3ngQ7aYhj5e
 vcaTb4+2pcBidGwr/5XMM+kfrKGQz8bFk2X3xYQ3xxlAPsEa6vhW877fGYlcc2K7H7gz
 lseoZFZPLiShoV3S28a3mOkNM/guj+olpz8S3bDjESvLnpYKa4bqJKHglnWQ/hOtBXuG
 P8VU3J21MYLXjcwXIQNsIBm8R1NPwlj7MfOSWfxVPrOppsXHbJkx1SbPD0KJbvPZ8fe4
 Lblg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787153546; x=1787758346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gFiLuwPOf9KbwAW1Nsk27CfvT+gWuzKy8TLR8DK7mEg=;
 b=cwpUS1MU0eDhEo3mCgLMmjRLOqjigbMRd4g2fSHhFGdI2/fjeKAWUHpyeMaUxy7EBe
 Ya0QG/vor4PT8Z7kKkqbGe21YPYiMQ7B8BsoKt3waeV/NkeR2F6JI2q6qJtWzMM/9fPb
 aUIhJ+wxoUFXDjtMs3qYff/3ssliBVdl8hShfjlaZWk1vxoipRF4sBogmJ8b11VHZZkT
 AABduH79pchYSInhQ+d6NakD5Ocoqh6LQWN7SUOeuu8IdtJdj6JH4MmYLlsMkvBrnfcF
 B6FypCVsKMW79ixykq7Sk+pDL3AX09kaeuL9hhh9wl9n9bUtev5xKkr25veCGyV/7iqa
 g5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153546; x=1787758346;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gFiLuwPOf9KbwAW1Nsk27CfvT+gWuzKy8TLR8DK7mEg=;
 b=AVG4OtMiS1UqvWwW0jIE3DGA5eXU76L/LQSs61XmebOBOcd5F2AD1/lN/0gCuLjRAK
 MMGn7dMSbBIQQ8OCKQ3cTRrF3nDKnv4F2uI7fg9CSzuV8nIirAijkirS8jiBU1yIgHPG
 8rIOsxpC/sCOpL2Vb7/O96KUDQVArCV9Y6GSyDa+EfiPISRFE+nq4pTp98GGP29DNPmd
 e1vVPLc4JaV4rkEGgSoHJa0U6RyDMWmRVYcleB3tZkOza/91fCA03hkc17aE35RgkH2I
 woDYtv7NfJib0L4iV3O0fd1yEbCnBAm1emadslVSZmPudR6mPuouJ0VV866cTrBp7sQA
 LeMA==
X-Gm-Message-State: AFuF++n6YeX7zzDnast8USttFzoFyqKUHYeXO8xUN8L0o5uTw3ZxWd6p
 Z0V3dYD71ucxPqAawz9ehDU5ViJuqPthQfNHAHWOsRjmkgA22hxL6Al/OAe5mPJxKHgWBkUnrar
 j8Ze4THBsPOW9JpQ6tQugD8hzDoJmGQA=
X-Gm-Gg: AR+sD12OEHC9NNan2wd1BY+/azmj1p4gEjh+gmYlDOcogPWfbwUsGSdXPQbauyCrDc9
 peehJ8FLhOrk9P4mVtjYXUQ7rqggjE8HxraWjwMuAdwqhMIhMheUssn+oPAvsj2KabQ53S5cAU4
 yIZQHmtZ6vI/NDMdAHvRH/CNOUoD20ZA3qgvvCrK3L7ArCibIKQrovrWWiWmi/D9c+v5HrlwjhG
 hpUzp2cRpxe0ZzgrQ3B5nZyh0y+MZjRSC5dmuK1mzb6wa6WaFGmgeosQCoEQNpborubn11GI1n8
 7ptbdNyUpxRywHfA20SPefDoRGkZo8Ns6eRJY2QBUDQVAyU2uTqZ5tZTM5U9XMRgvvinYuUqhpg
 gFjpectw6X//hHGe5nG2+J9B7S0zOhbI=
X-Received: by 2002:a17:90b:1e53:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-3958123d18dmr4729690a91.2.1787153546095; Wed, 19 Aug 2026
 08:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260819073257.428030-1-Prike.Liang@amd.com>
In-Reply-To: <20260819073257.428030-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Aug 2026 11:32:13 -0400
X-Gm-Features: AcwNN1Va9dilXm_5XRv4fP2D6IMKbqvo2xBu3AU2xiuhS9Zj9UypdRqkrGOQMgo
Message-ID: <CADnq5_P=hQtiwh4TzRu-J0Si6hXKuj5Jyt5UZMGpkH7e17XrDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix the inconsistent indenting for
 mes_userq_map()
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Michael.Chen@amd.com, 
 kernel test robot <lkp@intel.com>
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

On Wed, Aug 19, 2026 at 3:50=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Fix the inconsistent indenting warning for mes_userq_map().
>
> Fixes: d0827dda8fa7 ("drm/amdgpu/mes: refactor the amdgpu_mes_alloc/free_=
proc|gang()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608190252.8XCa0HqR-lkp@i=
ntel.com/
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 80f84bc56664..cfee0a8a4b1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -146,7 +146,7 @@ static int mes_userq_map(struct amdgpu_usermode_queue=
 *queue)
>         queue_input.wptr_mc_addr =3D queue->wptr_obj.gpu_addr;
>
>         if (mes->use_rs64mem) {
> -                if (!uq_mgr->proc_ctx_allocated) {
> +               if (!uq_mgr->proc_ctx_allocated) {
>                         r =3D amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mg=
r->proc_ctx_array_index);
>                         if (r) {
>                                 DRM_ERROR("Failed to allocate userq proce=
ss index err:%d\n", r);
> --
> 2.34.1
>
