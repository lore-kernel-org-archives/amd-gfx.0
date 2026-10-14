Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5179DCC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D109510E472;
	Wed, 14 Oct 2026 15:56:00 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB18110E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:55:54 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-7ca805eff73so116859137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 08:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791993354; cv=none;
 d=google.com; s=arc-20260327;
 b=r9wwCVsAy3q/vgh/F7KWI2qENDR3u7Vuj6fDNcipzOxgJ6dfW3nMtPusMA33LY1BIq
 9l3w4nYhqhWBQs6lNkpZm5DKv8nO5NcGIOboi19vwPJmEzU0F9FtKSRclMxPN8nZEidv
 76IPSX4aeqlTZd+AqgY2VyzVAq7ueWEGItUFfH8zR1lx+33t/HXoetrneGEA/bLDE8c8
 ymG1ioJ5K3odVaadpRXLMJ8bhS/sgnnyIpaHrntUzrRFaVAF3ultl6UrTcgtY2onpYaB
 X5WF0ztCRxasV+YF/GmerxHXYHZvaHx1m01gw7jnvthiFHeTg0djvHBuFy+ocpwUXQVK
 AwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0uZSbjpPvDtrSRHp4pkWVV2GBc7afJEeJ5cwB5l6Pcc=;
 fh=vZ497aaMIZfJJD2nT54U5GrNu0SGcL5Yo4Gj1bpztYc=;
 b=KxFsTbR5TDDrhRMsobYdvqwkAws0Ukn3FGA+VIc6SlIlHh2NVMx62ggEUrVWLBrhcU
 QxOQUtoyJ/84WDIwex0OE+j0wC3Iqd2GgwSGfScuBcmNHVPZJc3pdokpwlqSgXQq8ul0
 bKAcK3WUVPa1VqzdLPQUo/pGPGMyEepAemUHotp58GMClr7DwPoAqAFATBDEcR+DGcB1
 Hms9n+aLiDhk2ppksn8b6gW3MTPycwXpucDEADdJJnv5AIMSLu5u9zw99jtZUdt79WwZ
 oZfQIuLe5aKfrSjOEwjZ0Kh0UogkuwT9uz6z2OL4U5I0wcG6pZuvJ7zyivP0Zf3y24zl
 bW6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791993354; x=1792598154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0uZSbjpPvDtrSRHp4pkWVV2GBc7afJEeJ5cwB5l6Pcc=;
 b=LR2DMWjMObCR01ezIbY09QKz3ohehE7H5M7U93sL2eaGTbOJscUmoYzRBpEkqJgWh1
 fjGkguYSmXQuff0rRIFMBT4KQFNWJ2Te6v1aKslZkwDf7Lz8Go0H0Jn6K24cxdvNCEI/
 BoQChf8M9Mn4GJn+b/4Buv4zc6no/HMgZbKhoxmKaT62syTtPWr72eqnmV8wfW4nBJoW
 jiD/eRd7Mwl8LKwqHynzKONbz0RsN16xifvZi1rLx5WsEHQminncDfrM5ovsbBPmqaPo
 vH3fYwWn9KZXdCr+AJn0PPJICHwO0M3vPEhcC4H2sV4R4atEwTNYIwuTgPdlzJK6ebfr
 7smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791993354; x=1792598154;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0uZSbjpPvDtrSRHp4pkWVV2GBc7afJEeJ5cwB5l6Pcc=;
 b=CIhA8cRLFwY9Qkw8B2jMHglg4ZGiw/2PFP+shg+9wRvhi39UQIZXYpxvFfVCl32FFK
 0iPBf1ysSq0akPBn0d0wbq0BiDQ+kjot+qcouTc8zQQOrQEvIGbxYsiSNR1q0LOL/UKl
 POqfAs0S3daFwpXllaGblD3qDanHObCPkf7dw28EH4hjdlvV7rDeik+UJIFs4r9xOasL
 Ni+vIGu+95XS6/qKRnfZJNfpiL+ZYixhxf7nEblKSQuGD9OErjsFeXyvbl5nQzmP91xx
 rSp0v/KHbDffR/iDyHpTHb8REnaJV5sA4ZtrEXcs7Kq2tDR0/GANDddancdBXKGt8IG8
 BnXA==
X-Gm-Message-State: AFq9FYKe1g3Id/Eg/ZevMvhTGFeBESAYa55o2hFEdaUF0hFyuyTvEwsF
 XboNkxbIROpkzNoozXs1lcDkOvfRc/b997X3cEKt0cret78fI7XnVx4ndQlrQVptsqT5HGKZTIz
 W7hp79Xh5fXs//m0IcAFC2MJWVTv3gAc=
X-Gm-Gg: AYBFou3E528h7n5JIiSmo2tA1P6A5Iy2GbCInuN9clYWzq9TiLSydun1aIvL17grEpB
 HpTiSxXZ6HCrR/esA2X0a9cfNIOP6OgEDkNnUan68/M3eUDEBsKhcz3IVYzbgGENu13AkhbU3Pp
 6jFpXi+UJyc6ZawiUy1hJNx9sB0nJxEn3W1sJitAQUnN8wxULu41IQpWtomqAMmEx9+opZXwrae
 yxPos+YfVwkWmD5+K0roStJ9jOzSmTchSeAPkFYZ24Mu++jazlc0b7XrKBnRxkyzoV8NPv7KTtI
 wKKbgUsf3jyqnbUNNcFQFaCre63ba5wH7iZX30qEFM3Hy3HzBNpcQ9pL4kpFa5V9JChcUtQrLW0
 9RIufNlTSSwyd7Ma9OtwJTR7NaQXwSju080G+9k4UpQ==
X-Received: by 2002:a05:6102:a4f:b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7cb367883bdmr4069227137.1.1791993353634; Wed, 14 Oct 2026
 08:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261013202034.76226-1-olivier.kaloudoff@gmail.com>
In-Reply-To: <20261013202034.76226-1-olivier.kaloudoff@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 11:55:41 -0400
X-Gm-Features: AclHuK_aB3ngBAn6OOMO8MeodbSEO0KHwImAwOdq763-jhXUf4zPzk62K-s4TEA
Message-ID: <CADnq5_M67FA+T4g3qhxyGTp7UrhCmHaPaC=0tirx647hb5gFYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: guard VCE/UVD sched entity teardown on failed
 probe
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Oct 14, 2026 at 8:56=E2=80=AFAM Olivier Kaloudoff
<olivier.kaloudoff@gmail.com> wrote:
>
> Since commit 037b98a2312e ("drm/amdgpu: move UVD and VCE sched entity
> init after sched init"), drm_sched_entity_init() for the VCE and UVD
> kernel entities runs in the scheduler-init phase, well after the
> IP-block sw_init phase has allocated the vcpu_bos.
>
> If probe fails between the two phases, amdgpu_device_fini_sw() still
> runs the per-IP sw_fini callbacks for blocks that did complete
> sw_init. Both amdgpu_vce_sw_fini() and amdgpu_uvd_sw_fini() then call
> drm_sched_entity_destroy() on an entity that was never initialized:
> entity->rq is NULL and drm_sched_entity_flush() dereferences it,
> oopsing in whatever context drove the failed probe.
>
> Observed on real hardware: MI50 (Vega20, VCE 4.0 / UVD 7.2) behind a
> Thunderbolt link =E2=80=94 a pciehp presence/link-change event re-probes =
the
> device; when the re-probe fails (-EINVAL here), the cleanup path
> NULL-derefs inside drm_sched_entity_flush() in the pciehp IRQ thread
> and takes the whole machine down (panic_on_oops, EFI pstore capture).
> Reproduced twice on 7.3-rc5, 2026-10-06 and 2026-10-09, identical
> signature:
>
>   BUG: kernel NULL pointer dereference
>   RIP: drm_sched_entity_flush+0x34/0x2d0 [gpu_sched]
>   drm_sched_entity_destroy
>   amdgpu_vce_sw_fini
>   vce_v4_0_sw_fini
>   amdgpu_device_fini_sw

Shouldn't this already be handled by commit 1decbf6bb0b4 ("drm/sched:
Fix entities with 0 rqs.")?  That commit adds a entity->rq NULL check
in drm_sched_entity_flush() and other places as well.

Alex

>   ...
>   pciehp_configure_device
>   pciehp_handle_presence_or_link_change
>
> Guard the entity teardown on entity->rq, which is set only by
> drm_sched_entity_init(). amdgpu_ring_fini() already self-guards via
> the rings[] registration, and the vcpu_bo/firmware cleanup still runs
> as before.
>
> Fixes: 037b98a2312e ("drm/amdgpu: move UVD and VCE sched entity init afte=
r sched init")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index ecd7caa95..cd35ff7ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -377,7 +377,8 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>         void *addr =3D amdgpu_bo_kptr(adev->uvd.ib_bo);
>         int i, j;
>
> -       drm_sched_entity_destroy(&adev->uvd.entity);
> +       if (adev->uvd.entity.rq)
> +               drm_sched_entity_destroy(&adev->uvd.entity);
>
>         for (j =3D 0; j < adev->uvd.num_uvd_inst; ++j) {
>                 if (adev->uvd.harvest_config & (1 << j))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 1f7a98cdc..3952af9ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>         if (adev->vce.vcpu_bo =3D=3D NULL)
>                 return 0;
>
> -       drm_sched_entity_destroy(&adev->vce.entity);
> +       if (adev->vce.entity.rq)
> +               drm_sched_entity_destroy(&adev->vce.entity);
>
>         for (i =3D 0; i < adev->vce.num_rings; i++)
>                 amdgpu_ring_fini(&adev->vce.ring[i]);
> --
> 2.39.5
