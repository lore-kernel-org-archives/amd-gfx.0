Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1B8CCF2C1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A93110E05D;
	Fri, 16 Oct 2026 13:24:31 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8C510E023
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:24:24 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-34c522572bfso782784eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 06:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792157064; cv=none;
 d=google.com; s=arc-20260327;
 b=JZ6EmLa40OiTBBtI/GTGyxJPOxFFAwGdkfD9eyOq1WoyqEGOVdXg1YgL/kRugQHtUm
 FYbjbow8f87GaJY38Ix8YTvTVJ4FDmez3ygKjmaiRoVpuCnz9oiwd/9eMgFoVZXnqxxw
 AblnnIOh3XTCM2cAkL7KiB/WrC/9EGB47njJvxFcvYo1eYaKx/9bIFjt8C4x9hoRm+oz
 JEKealMam8/Tosyjh7CxgRT1iC+MJzFTsj1JWsJaN+gSYvdkgiz4tv6CjbmE+6DvHUXc
 2p/ShRyRpI/KkvT3up9nVMXVZ1HlryTo7RuBD83EVL6+1RT/k46sgAQtH8L02XeBz3Aj
 7KEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=etjHy4fum0i8WAme8h9h0et8vgwdAeTJp0rH+VxnDEM=;
 fh=I+9AfXZpwjzmmFEKAqU8ufa0Dkh/CnseoLKPAXkyuTE=;
 b=O+iIkTmvyl4Osy79dyVQLNFW4VpebiEs2kF7piGxvFaJtKN+7Rhj2CBVL9k9UL2ZeV
 5CZJXmyXQMum/u74jniz+5nv+vlh2puKjTefzeZ3p41vFIwfE1OqybXp7OYlT9j6oUIJ
 m1LPRo/qeyqNOVA1B4epQ2TbxqEqutKeZJgFYQxmtXJGluhbtPG9rixdmr3Dxvkanqj5
 PvW0iAxKBmwl9VF/c8t4iWx2NFdtRJn4VCEEoyzvLNHE5mbKS4BJD7/n2mlCbayHXG5n
 7wehlx5qlV1zaETbSv7dNdIUH3P5RJraHKpwoOrQvg52qEYKsDJySrLyFY5+GD5mve2R
 x9Qg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792157064; x=1792761864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=etjHy4fum0i8WAme8h9h0et8vgwdAeTJp0rH+VxnDEM=;
 b=g1DJxVmTqISFpCuzXXLIlltif97Wux5Upv7/vOT4qBRTpS38MhSSVShFnrhp7fc8Sn
 E5/4VQRH3ptH5zJTHxN4/gnJkji2tKYdgil3my0oKTSZ2OySX/hAqNy4GrA+FNE3Eyi5
 3pOlckhqgWy1HGt/b/qNVh9QoBLoQfgxkbwEN4Ce65l9YJftjVKPK9xQqKENK1GEamoC
 QYnfsNr6ke7wIvqazcI8Okb7AQGdItah4An1+0Z2KON6YFpLKN/hFGhzVGsGlEmTN/WL
 jv+JFl/ga1pk9KpaltKyyng80n31SYwRE82BpO35lbWTDCk9s9R0jGCX65Y7Zkhk2sDL
 FaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792157064; x=1792761864;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=etjHy4fum0i8WAme8h9h0et8vgwdAeTJp0rH+VxnDEM=;
 b=cbiqSEXRt/cEu8Yh+W8wKMBVDMQ3vwZ7gYJ/EmHxVhv4IXJlddCb+9iUFGyS4IyAiz
 OIpsQfQXBEiEYXMvPHS9mdU+8sVvzHUDnasf7Fq3KQYYCc5NFiYuS8stV4ERzuxkPjus
 f9lCdBZWZP6kwVudc2gVtoktxPVuGO9Bp9fsZSKbjctyGez3Na3rFIcs8TRMOta8Ozh7
 3tn3vNsOOjL0WTbs7uQ3X3y69BP5NLPUAe6HKVucT8RJQ5sG8SuvwFQtaWoZpoAC2+c9
 2jbGxAiyaTMZCCGKEi5I8nx+KWd5qcoWK5ErXOZsrHhFPemIy9Rt2EL8QB56k+lYxxgV
 GbLg==
X-Gm-Message-State: AFq9FYKHO7PDmIBtyLKGC8HQlMx9S/rWjSvN/W1hHUv68Tp90fynfVCB
 SYT+zOz/OJaF7mQX5gF1vWA5gFW+PKIZjkDvgx0/N0gPgsyG3RC9DJv+yaXUDsiYitsyH8I3xU5
 Cz+TzSkB10I+YU+UT+0NrmuDb0NU9RG8=
X-Gm-Gg: AYBFou1cJoN1QJgXsO8JbpFc7rl30+oS0Qg59jWsjPvf3/j1msmLmC6txgMJEQIU4jv
 Fq6Y3xOa2MyaBw0bbe3xY8HbbaD9VGhPpqAylsneB91Lwi57iqqLx7RFeGim2fincFvhZLLnnG7
 NmT23LomljzFmQXPVmW+j1lafia/tyb7sWawlXnFiEZ+8C/dGh/+QY4XTFVMqNGcUbzt8wF3oUv
 yEJaLfA9EaxrNKNT4AxFdNBZXjCMm2SwOMoYHSDX9spEevdkFmi894l2EaCU7rj8QpPez28UJPB
 hSPd0I2JQALKZCbH6t8vG5p+Qlw+/LfGzz/7gHHId9FlNdsSzUcNI0r63k2J0j0Mko2wRsZnstl
 f8CwlVfrVZVJ+XkMzQUwz1pj58VV4DBulRCCaHHeRVQ==
X-Received: by 2002:a05:701b:455c:20b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-18506e5ac63mr12332c88.0.1792157064048; Fri, 16 Oct 2026
 06:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261016095224.461911-1-Victor.Zhao@amd.com>
 <20261016095224.461911-2-Victor.Zhao@amd.com>
In-Reply-To: <20261016095224.461911-2-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2026 09:24:12 -0400
X-Gm-Features: AclHuK8oZH7Y89gNuBM9yxSiYNLiLWoKZYnWVSBRvvXMEtRysN0FQ6MmJKPGLo0
Message-ID: <CADnq5_MKWAwEZJTH8-9ssPjxBi5VewAQdcPyqgaCyhgt8fa3Rw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Read SMUIO GPU clock on GFX12.1 VF
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo.Lazar@amd.com, 
 Alexander.Deucher@amd.com, Davis.Ming@amd.com, Gavin.Wan@amd.com
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

On Fri, Oct 16, 2026 at 6:11=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com> w=
rote:
>
> [why]
> GFX12.1 VF timestamp queries need a SMUIO Golden TSC sample, but
> direct SMUIO MMIO access is restricted on VF.
>
> [how]
> Read the consecutive SMUIO Golden TSC upper and lower registers with
> amdgpu_mes_rreg64() on GFX12.1 VF. Swap the returned dwords to
> reconstruct the counter value.
>
> v4: use SMUIO Golden TSC for GFX12.1 VF timestamp queries
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index d6f70d33201a0..93c8f8e449bf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -37,6 +37,7 @@
>
>  #include "gc/gc_12_1_0_offset.h"
>  #include "gc/gc_12_1_0_sh_mask.h"
> +#include "smuio/smuio_15_0_0_offset.h"
>  #include "soc24_enum.h"
>  #include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
>
> @@ -3168,10 +3169,35 @@ static int gfx_v12_1_wait_for_idle(struct amdgpu_=
ip_block *ip_block)
>         return -ETIMEDOUT;
>  }
>
> +static uint64_t gfx_v12_1_get_smuio_gpu_clock_counter(struct amdgpu_devi=
ce *adev)
> +{
> +       uint64_t clock =3D 0;
> +       uint32_t reg;
> +
> +       if (!down_read_trylock(&adev->reset_domain->sem))
> +               return 0;
> +       if (amdgpu_device_skip_hw_access(adev) ||
> +           !adev->mes.ring[0].sched.ready)
> +               goto unlock_reset;
> +
> +       reg =3D SOC15_REG_OFFSET(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
> +       if (amdgpu_mes_rreg64(adev, reg, 0, &clock))

I don't see this function in the current tree.  Are you missing a patch?

Alex

> +               goto unlock_reset;
> +
> +       clock =3D (clock << 32) | (clock >> 32);
> +
> +unlock_reset:
> +       up_read(&adev->reset_domain->sem);
> +       return clock;
> +}
> +
>  static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *ad=
ev)
>  {
>         uint64_t clock =3D 0;
>
> +       if (amdgpu_sriov_vf(adev))
> +               return gfx_v12_1_get_smuio_gpu_clock_counter(adev);
> +
>         if (adev->smuio.funcs &&
>             adev->smuio.funcs->get_gpu_clock_counter)
>                 clock =3D adev->smuio.funcs->get_gpu_clock_counter(adev);
> --
> 2.50.1
>
