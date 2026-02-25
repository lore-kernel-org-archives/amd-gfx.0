Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E283FFD45E4
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 19:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A44A10E7DE;
	Wed, 25 Feb 2026 19:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJAwl+HT";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BB010E7DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 19:37:25 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12736a0147cso3617c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 11:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772048245; cv=none;
 d=google.com; s=arc-20240605;
 b=G7ZsFdV1BROkJsBh6Q6sYFbIdmqm4cPhMIgAuHMQhVpgWitbQ5ELBvpwUGiugD1AfJ
 dZ12hVlCMsXfBeU7zXuX0HfyFV3lGZFxE4vVVJ2pQFuuKSeAYxmbpHtEjVWlBv/e1Son
 Kb4Na+tlDKQkc/qoLZMlIOmTzs20XV9iC8DpOBqCqFt/ofxsGDMtUrn8lSXargudTMDL
 byvpfJEqpX1zWc7Ejb17U+xI7HQn7PoO2WxKKIlNdw2FWskSx3vKdho0cvQ6YGfHNMAK
 I4B4ilEIRpXTcOVVV5B6XKmWs6ZEvvXy3dgg26PIQ++dZP8E9KyPjSGYDOZH5rK1iUks
 hZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2JUVh5W/M1rUZAXUYe3MHcUmZP+P0I7PmSFwmhIiz0M=;
 fh=/E9ORGZVUSt9y+V1Y1LkLQHcLz0S1/RYg7Ps4iam1GE=;
 b=YfXj1bHSSMUgVzkgbUmYlC9DMGumro/EEJ27POZVILw0/CXq0NHvgR2nue2zlbY2ip
 syXfF5o+vT5SS2FLN/BUfqJX1CnDEieFThDjOB3+K+NYzkoayzQm8zbYlNRD31iiBUym
 YLDcEX1JQj0Je6X7Lxg4ZWheYvgrygJ8MMyoowTFWijTEcqvkpOYeZFWC70RtPNt7L7O
 7YSMNP2vY5mVPDD4ExoOwUETvIPNGh26mw24d7nRPK/PSSjQfXhQBut7rpZYdnoC9v7E
 Ei1UUvxVUelAeiZQqt2XOuATskmvYdui/krjhKAu2BDptMk115FVddI9hR8kgULOqdG7
 QwyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772048245; x=1772653045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JUVh5W/M1rUZAXUYe3MHcUmZP+P0I7PmSFwmhIiz0M=;
 b=BJAwl+HTeLcEe84x8Jv73J+DxZFK789iJc231j9kisBDuNXwnEpAow+t+hzYQkl98H
 gQKpA9WCOfIM3X+YzX5tssTaRuIsCXQ3A8S7qipBIW+cQI+x+0vGyj0gsMht+GY29Pxd
 r4KrC3WdNMx+pl3YDXW5V+GbMcoA5QnTUHlEavsUd9rpgdIsZKZfTwMcGA8z9XdnBWd/
 7suTFTGeqNC0ZMA4aqpAnGZIti2er+n74qKS5NyUe8FaG0UxL0qWx7+xVy4MHrJE7w2r
 bvuPcTaTYtoceM1pZbyoYjUOSKVdZwmq7xN2beDTgqUybogxI/elArdytOo42BAKUAwp
 m/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772048245; x=1772653045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2JUVh5W/M1rUZAXUYe3MHcUmZP+P0I7PmSFwmhIiz0M=;
 b=AzBWjaSk/ZLyFBEEFpsC7UO7A7r6vUKDt0CCqShFLlx+MhBdV2Hf4ucwU4jx8ZPwtM
 kFXQniTEuRencSgGNwxiiv1tb2lzEAW2GOPIDyhWyy3tEVnHufiXNz494P8SDLzpY3e2
 VpjSngyBVc1XdjpXK8stUkQlec1foRpXITOUtQ7nGmPgjaAASHb18Hnb0inXJi44R/MO
 QebBBgAC28flxZdDzdbOGmHZ6/EQ5F4jeiLj0wFiPO43GLav099EaImwOkpB3pdEAsaL
 Lu8Uwh+HEpEUa7f++vlaB/Hcs48ABDH2AClqc+kudCMRWqJoiBKuJx93uY6WehA3AeuP
 89pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgkIUz5VA5ts3nVPwmO8JrC3Z7LoGhJ3pFyVdF1mYFXg/JO+kt/ZJH7slW0ayPDnWiZNmKw+wa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWu38lgGhte60eLPBvSVLkWZFc131AVjvtOaL+rUdk2bPMKayu
 XGkgJq+PeHrJXnpGM07rHshHHIacy0BdIfCHEoOsIh/kXgW6kK1qMFeGq/CBirotL8X6IBqbFly
 Vd+LBAaZHUYG/tqDmE66WujopqqZFAbU=
X-Gm-Gg: ATEYQzwiJO0qhNwcrbbmKNRLCBxBL2/jH9BbZXdwwqFQ5o9pgL9qirwOU24tPiZjwPX
 qBvGR/thVoo14EOS6Keb98IMz+MIXrmAedKC7Fv6azTI/L/opKybitcr+8Tmrcquq9yldtr4MVD
 YhH9fCse9lt7fPJlBbkVFlLW0l2xBDmkwHMEDfSh1fC/DCNuPUOVXqcDroWvDd7Iw9welxT3hsR
 2F7PRIL0OymufWJu+oEqEsPgnM7vzypvxQ504uyDe3AiEDzxsweMD5LVVR8a59PDlIT/FwPss8Z
 TsRYD8bk5VyflNuGP9RY0DA790isFgRUpXlkhtiQn98DdyNeyXjzPGUQ2P15tMJCFFqb0g==
X-Received: by 2002:a05:7022:ecc:b0:127:332d:63e with SMTP id
 a92af1059eb24-1276ad1a7d8mr3574767c88.5.1772048245032; Wed, 25 Feb 2026
 11:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20260225093734.481140-1-suresh.guttula@amd.com>
In-Reply-To: <20260225093734.481140-1-suresh.guttula@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Feb 2026 14:37:13 -0500
X-Gm-Features: AaiRm50_T2BQWk8ShKykJyfxraToHrZr3t91pQgKreFdMlAc7o-ucl7GExc9FsI
Message-ID: <CADnq5_NqFwde1xbc9j-_hdroYooaFRNZOAC_uqXYePhHFsDfRA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/psp: Use AXI address for GFX to PSP mailbox
To: sguttula <suresh.guttula@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Wed, Feb 25, 2026 at 4:54=E2=80=AFAM sguttula <suresh.guttula@amd.com> w=
rote:
>
> This change will update GFX to ASP mailbox registers to AXI
> address space macros instead of SMN address space.
>
> This will help to fix PSP TOC load failure during secureboot.
> PSP allowed RSMU security policy for R/W on AXI address space not
> for SMN address space, GFX Driver Need to use AXI address reg.
>
> Signed-off-by: sguttula <suresh.guttula@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v15_0.c
> index 723ddae17644..73a709773e85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -69,12 +69,12 @@ static int psp_v15_0_0_ring_stop(struct psp_context *=
psp,
>                                    0x80000000, 0x80000000, false);
>         } else {
>                 /* Write the ring destroy command*/
> -               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
> +               WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
>                              GFX_CTRL_CMD_ID_DESTROY_RINGS);
>                 /* there might be handshake issue with hardware which nee=
ds delay */
>                 mdelay(20);
>                 /* Wait for response flag (bit 31) */
> -               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_SMN_C2PMSG_64),
> +               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_PCRU1_MPASP_C2PMSG_64),
>                                    0x80000000, 0x80000000, false);
>         }
>
> @@ -116,7 +116,7 @@ static int psp_v15_0_0_ring_create(struct psp_context=
 *psp,
>
>         } else {
>                 /* Wait for sOS ready for ring creation */
> -               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_SMN_C2PMSG_64),
> +               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_PCRU1_MPASP_C2PMSG_64),
>                                    0x80000000, 0x80000000, false);
>                 if (ret) {
>                         DRM_ERROR("Failed to wait for trust OS ready for =
ring creation\n");
> @@ -125,23 +125,23 @@ static int psp_v15_0_0_ring_create(struct psp_conte=
xt *psp,
>
>                 /* Write low address of the ring to C2PMSG_69 */
>                 psp_ring_reg =3D lower_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_69, psp_ring_reg=
);
> +               WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_69, psp_=
ring_reg);
>                 /* Write high address of the ring to C2PMSG_70 */
>                 psp_ring_reg =3D upper_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_70, psp_ring_reg=
);
> +               WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_70, psp_=
ring_reg);
>                 /* Write size of ring to C2PMSG_71 */
>                 psp_ring_reg =3D ring->ring_size;
> -               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_71, psp_ring_reg=
);
> +               WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_71, psp_=
ring_reg);
>                 /* Write the ring initialization command to C2PMSG_64 */
>                 psp_ring_reg =3D ring_type;
>                 psp_ring_reg =3D psp_ring_reg << 16;
> -               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, psp_ring_reg=
);
> +               WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64, psp_=
ring_reg);
>
>                 /* there might be handshake issue with hardware which nee=
ds delay */
>                 mdelay(20);
>
>                 /* Wait for response flag (bit 31) in C2PMSG_64 */
> -               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_SMN_C2PMSG_64),
> +               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_PCRU1_MPASP_C2PMSG_64),
>                                    0x80000000, 0x8000FFFF, false);
>         }
>
> @@ -174,7 +174,7 @@ static uint32_t psp_v15_0_0_ring_get_wptr(struct psp_=
context *psp)
>         if (amdgpu_sriov_vf(adev))
>                 data =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
>         else
> -               data =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67);
> +               data =3D RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG=
_67);
>
>         return data;
>  }
> @@ -188,7 +188,7 @@ static void psp_v15_0_0_ring_set_wptr(struct psp_cont=
ext *psp, uint32_t value)
>                 WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
>                              GFX_CTRL_CMD_ID_CONSUME_CMD);
>         } else
> -               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
> +               WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, valu=
e);
>  }
>
>  static const struct psp_funcs psp_v15_0_0_funcs =3D {
> --
> 2.43.0
>
