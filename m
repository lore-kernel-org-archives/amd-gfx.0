Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C09EC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 16:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C3010E97C;
	Mon, 31 Aug 2026 16:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YkbJEuLk";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42FA10E524
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 16:46:38 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-398b21b02f3so271834a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 09:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788194798; cv=none;
 d=google.com; s=arc-20260327;
 b=Ll4b0NzOilq4pa4+9QgYtoO1o2Ds5+pptjOqn0bDKqTGtCgBPnqLr04S5UL56aXaA9
 T92MtOlZ2Hu0fLAhCdoZfWIkvwAov0+qQRGyCzDNn9zwNm06Q4zdmmNxLRptEWA0LWo6
 c7J78KI7JSWkx/Q/6neu3FkekiQnN76cg2EIBrEyGcxyAehdfwygS/fYK/BImhGzQsSO
 XOrhxsP0cvR0n6Bn9NePNGbELXOSAu8a20m1fBZ+yGDAAfBTjwghahm4p0W0slkzpfYA
 /N/X35us+16mYbA9E7WnmQZcl5s0uczCz7uX7xcG9upn89ofdv9XnxBd9WCxTRTXfKS3
 0Nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WhKS116u8a0coSCjZGvWRgCuLKokEuiaoboLkN6qb2Q=;
 fh=6ARugZob5dVWS4jFAam5WCCPWSM5YVH8Dk3gTysC/1I=;
 b=AIraSQCJIOVr14RsTkPRA43fxRKKlFkYkXIGNWVIkHMKpuhdarktTicLXg+vny1LiS
 SddJ8ykEGCeyu5W2wAM4PmmqJRWPajZK1wpIw3kolsFTnv4O7XlYZB2aiA/HHwlGLrTA
 c636jcEZ9foY6MfbTDJ2YrsewI85YmIK+hxdMejmtF12N72CylWaGrNxvqTJ5McrsLjZ
 S5WqJnzAHkVc8T0j+BB/rzJQT5EUeYLZXMaGagmNePPFWPzSgbOSABexr+fohkpohog9
 Da9ptMWGRK00mt8QKcSAXX9KKxI0EvyFUU1JSQFPVP6bKW1MslTeSmuwkNEK38Vnw8mX
 rcKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788194798; x=1788799598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WhKS116u8a0coSCjZGvWRgCuLKokEuiaoboLkN6qb2Q=;
 b=YkbJEuLkXSO2F+ubhIXVC0VsES/7f6iL4SbomnM/9c+Ucx8eEnhnkT0rOqIQX7kwFh
 u42AmtUtmgUkbWJUZQ/rHTb4wMoiYrr0V0bRLP0crlXHLFDOF1+ImkLZ94cA6qGow6FV
 ipgABfHclrREyLAwQalmBxLpohBCUeqbjCwjNnvffz48Dh58tzPWlgpNRBR/Zc28esqQ
 5JgPzBqOXIYUO3kf/8JgRkGXfsHq9PIVN3VJDMMAkc4sfiP+kkU5sn9Sorrr/aMjEByO
 QLlySaaHSw1/JrZFQgwFXx8IxmdrApGLI0w1z7B6MQdF211ftBq7Z1FDt84RPCN67/rF
 9+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194798; x=1788799598;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WhKS116u8a0coSCjZGvWRgCuLKokEuiaoboLkN6qb2Q=;
 b=CiEujGqm3zkKRCbnNi0CMXCsiLnmYOZWAIG/bpJ/p+bVtdKwMz9bvbToGENnDH6TTm
 Y/cZx9SWyJHFKStdpigLIPTQikXufunsLyUVBdwKLlb/Aq3euKEdOGSwER8cWtupG1ZA
 ZVWVY9iChpzPLL2lhcx0nJykE6QBN2HvwlicI+egQzwg9UEH6psmy4I8DoMIuZRMgBa6
 IxSupLsZu4VqZNG25niN/vgdM4XrB/lVLsG7HUT3+WI5ZrGZ6pxWKAUsdQfL7779ppGb
 LZZnlCXiBqLYGLWff3zZDW1gXnQwiLWgP091u+qpEt0gIWUmPu3UA3bhGZn8MZAaeBC1
 Ri5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB3yZX0mODShvwGJ4aeYGrVJF1K3z+B509b4zDBRtL6D9SyvvwoUPet1cwrsTF5NP33os9L464@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5xJxbx4yhCF7/2OVzrO376sIvdCcg3TDAGbrjLyD+hzK9Dblq
 73uktmGVcaccvlt5HTeGc1gBTEGk2pxObgWnL/gunqTHZHtVfxLE2jBcxLW3vSVz0Jfw/wFKbtK
 nwOaHpbhNtdCgoQZuQmeNWYJ7AkVP2ow=
X-Gm-Gg: AYBFou0WMSxm04KI4B13H4RaaZTC+f5mN5L3b1QZrXHI2lMtwSUSWpa8K69jKp29xLC
 huyKOQ2otWGS6vX8g6ah3CZ+HfSX4XAVyidma1SfxduMTCtYgPJpCuOcK/2CKc1Ep35lSuOnhRr
 h/B6JChdPg8+6X6pPNY2YN5KzllQ+6zMqxFmP0E1wlRe6AQKVa1zaskY43LLpC1SIFfQkuD6S4l
 nwa3eKqlcqL2YVTfswGDEtLjLJAYeNliPREipeqB2kNYT4treNWLlBHYvUwzHUGrFuY//a+ysTo
 h+rQPqFZM3+R3FWuA1yJfWf6V3pYezsIA7QtrN5pXB7O99AfD01vodDcmokKGe3ZvozqSSxWPCd
 snfNqQ787BmtYjUJ2qhd1ZH3e0A3VjX7N
X-Received: by 2002:a17:90b:3c82:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-398ba95da1bmr15054710a91.1.1788194797865; Mon, 31 Aug 2026
 09:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260831161724.1559858-1-sunil.khatri@amd.com>
In-Reply-To: <20260831161724.1559858-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2026 12:46:25 -0400
X-Gm-Features: AcwNN1WHaRQqETFvn6sItbqsK-LCkw37yXZ4kUGbG4rfNvYSS3sjJUeusqTcG8M
Message-ID: <CADnq5_OHkm6oK0-ZWNTG26=ag1MfqxdLabiCFxJYFKQSg05LMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: add a warning if fw does not support
 userqueues
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Mon, Aug 31, 2026 at 12:17=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com=
> wrote:
>
> Creating a queue could fail due to various reasons and returning
> -EINVAL does not suffice in case where fw does not support the uq's
>
> It's better to add a one time log that saves unnecessary debug effort.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 4c6e080671a7..f16af852725a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -659,6 +659,24 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>
>         uq_funcs =3D adev->userq_funcs[args->in.ip_type];
>         if (!uq_funcs) {
> +               switch (args->in.ip_type) {
> +               case AMDGPU_HW_IP_GFX:
> +               case AMDGPU_HW_IP_COMPUTE:
> +                       dev_warn_once(adev->dev,
> +                                     "Usermode queues for GFX/COMPUTE is=
 not supported by the fw "
> +                                     "on this ASIC (me: %u, pfp: %u, mec=
: %u, mes: %u)\n",
> +                                     adev->gfx.me_fw_version, adev->gfx.=
pfp_fw_version,
> +                                     adev->gfx.mec_fw_version, adev->mes=
.fw_version[0]);
> +                       break;
> +               case AMDGPU_HW_IP_DMA:
> +                       dev_warn_once(adev->dev,
> +                                     "Usermode queues for SDMA is not su=
pported by the fw "
> +                                     "on this ASIC (sdma: %u)\n",
> +                                     adev->sdma.instance[0].fw_version);
> +                       break;
> +               default:
> +                       break;
> +               }
>                 r =3D -EINVAL;
>                 goto err_pm_runtime;
>         }
> --
> 2.34.1
>
