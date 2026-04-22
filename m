Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652DDFA1FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6FD10E0AA;
	Wed, 22 Apr 2026 21:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jdu84wI1";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6D610E097
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:14:34 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12c8ed67dccso331997c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 14:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776892474; cv=none;
 d=google.com; s=arc-20240605;
 b=C1eH+mvIPRR6axibNm7cFgYfHJMssCfrSJf1XR2yjlreXkqF505qK/LibVvTkLg2pM
 jFoSv4zHvqi4tnVQJfcbTrw30RRTwvz70G+0T3VbkbHNJS5zX1vEDFVyzfrdrTs6YCeA
 cGhDgNavUuBb3tCV7GzxPiK7Uihv3eiSLF+bjEiMZaUbuKFGp4QxMP5i2PGSudkqbt+X
 EC/RERRyKdFQ+LEYDAZwU95GHeR0j5Mt3mdk9Qhoe+km3LjIVnWD8yJHfvfedrnh0m4F
 ujhKS9G1/qMjUs1tjNmdvOTy+sT5LkWZP3I1iLZDF7IGGAS4ay4qX5O1bIDREg4RexDU
 Eb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=djwb1PByaTQ5JHTQ0MugKJ3pAoBUXuZckSepTgVond0=;
 fh=q79erz+LYRjWqw08ZhVGwK3VbiUe+72MSYGxQoxKG8I=;
 b=Bc9fo2xaTpCvzjlq8W9UclpdA/mlqohQUGoE1vxKUx5ypadoRV7P4fs0XT39Nz+/Ty
 0XYEGqqcXYpTM17p4TJ7DZKW5xb1/ve+D7L/Q84QhcajFKXmxLyaEgxVqHhAlLMz0Y43
 OgwKuxPjMJlJ/W56J+E2P47G9N7Kexv4hnnObMnHD4rI7C+ts82b3XVzGB6b+2oxkznG
 /qjJK4asdyaudYW1US3lF4PmI9Dhv3IiAEmiqaXfaYoA7QRgwHb1pT5WZijWI8iTOHQK
 0I6R9TAObUbhXIblb576b6osOhdfoAus0Z6j+KHL/fLv2levsMhk5y96XZBce284eK9H
 MGeA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776892474; x=1777497274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djwb1PByaTQ5JHTQ0MugKJ3pAoBUXuZckSepTgVond0=;
 b=jdu84wI1El49AUCq7McPQoV2z37CeBnPS5MMaUSCVny3KD1APGGiRWGJJ5CZJ0d0oa
 YrJweSQ2eSj/pNC76wp2x8EKrGE8CA+LaWqSRNLcF+t6UD3zB9LylCXkTZ/NmClQr4an
 gnJL4VcjD9feFGxjWx9DuJ9RRxBA3adlfN8Trw5tnYGEt1Yz5AbyHQIUu8V0ONzICkFi
 i0OscHE4YJL7Qfms+rTDQFRfqF66RB1b1XwsUhxAvvFOOpcbesMLB3BjD9Rv6v1hC9He
 T1nwgWarLTg4K9g2YBqr9lKcBnibRhLty5A4IpLkIL7w5DxWh08M7OcYsnPptsO+RssK
 1FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776892474; x=1777497274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=djwb1PByaTQ5JHTQ0MugKJ3pAoBUXuZckSepTgVond0=;
 b=Bey+HqST1C9a5fhiBgQNZo2F26nxcooTqJwBZULJKD7X+FQz73MDvazEe5HU7GvUuJ
 NpMHg+AGJGb1sqwipe8jdAeA73sQ+K1oFgvvWFKSAa2pZZRsQOtTROKSNuruRoO38Fp2
 OO5G7oHCfgukCIhbx/LNfqxYciahB/Of1Q2TJiRBPbCfjeScYLSAV8xx7GIXwOk51knW
 X7f5cnMp8xH3k82Qmb4txv8SEUioq7LLGZxCpuLLB88J1/wx6MNBqMSuGbGNOL54CZrs
 u2af/FJ9OmPKAQ3/7idItdk3YRjhbZU0QFEi88T1DO9K6/cUj569BNWJsoAW9tQsAEaO
 qcXQ==
X-Gm-Message-State: AOJu0Yzdi6hiOTC2V9L18NGN7zo+CmqivtKR5LWGY0Vn1hWxAt4KCX5E
 49VPZ5782vlCdBbP9bXJiOF0oPnB7Ue6wZdBYI1a00Mw7OEuXKbK/kCIWGjXeJ1xIDaco1Hg7gE
 s+geEF9KtUXfuL7PlzwbUCAZd61H9Irk=
X-Gm-Gg: AeBDiesdBB4VrKHSZaXI043BGKnL7pg0h408Ap4viv2FAJah02xk8gDt/2OOPR77lVP
 I3MNoeO2m17pOphDjVJC9Q7ulyBt95MBSGdk7M4DMok8I1abP6IqqvaZ82wsdaefDYGA/kHpDPi
 zQgBzkfLKvGeciUJtSWqsYcacLi/5s4cVhFy/lF+MLwpor4rC4LS2prtCp4Sk8Ix5JPwrWkUixj
 7sfDTFqgqXzX0mTOKw3k7Ko5Izdzks3J+tux8NcRnOuHYPei6pvMWCBu9h/IJH3KoSmn1o2BOlQ
 SVVfc9OlTfbu/3IuIa0ySlBvYiUeRqD038Ep8KKhAyq1AR5R+s083+19/TMNsNWYZHQ7qP9fmKO
 1ExDY
X-Received: by 2002:a05:7022:6988:b0:12b:f899:7178 with SMTP id
 a92af1059eb24-12c73fac164mr4651299c88.7.1776892473955; Wed, 22 Apr 2026
 14:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260418214933.230912-1-timur.kristof@gmail.com>
 <20260418214933.230912-5-timur.kristof@gmail.com>
In-Reply-To: <20260418214933.230912-5-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 17:14:22 -0400
X-Gm-Features: AQROBzDXpbxQyRj2_qTWHkRue7GMoLiLBbCt6WMRIrgTrgr1Qe_xpVYint2_sh0
Message-ID: <CADnq5_Mh6TgU6uRJF_ie5DJxoXxWA08tzC9qzv4aS4=f8hmDzA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/gfx6: Support harvested SI chips with
 disabled TCCs (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

Applied the series.  Thanks!

On Sat, Apr 18, 2026 at 6:09=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> This commit fixes amdgpu to work on the Radeon HD 7870 XT
> which has never worked with the Linux open source drivers before.
>
> Some boards have "harvested" chips, meaning that some parts of
> the chip are disabled and fused, and it's sold for cheaper and
> under a different marketing name.
> On a harvested chip, any of the following can be disabled:
> - CUs (Compute Units)
> - RBs (Render Backend, aka. ROP)
> - Memory channels (ie. the chip has a lower bandwidth)
> - TCCs (ie. less L2 cache)
>
> Handle chips with harvested TCCs by patching the registers
> that configure how TCCs are mapped.
>
> If some TCCs are disabled, we need to make sure that
> the disabled TCCs are not used, and the remaining TCCs
> are used optimally.
>
> TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
> TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.
>
> Note that the TCC configuration is highly relevant to performance.
> Suboptimal configuration (eg. CHAN_STEER=3D0) can significantly
> reduce gaming performance.
>
> For optimal performance:
> - Rely on the CHAN_STEER from the golden registers table,
>   only skip disabled TCCs but keep the mapping order.
> - Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
>   which performs better than using the same TCC twice.
>
> v2:
> - Also consider CGTS_USER_TCC_DISABLE for disabled TCCs.
>
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=3D60879
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/2664
> Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for=
 si v8")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 66 +++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 73223d97a87f5..ac90d8e9d86a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1571,6 +1571,71 @@ static void gfx_v6_0_setup_spi(struct amdgpu_devic=
e *adev)
>         mutex_unlock(&adev->grbm_idx_mutex);
>  }
>
> +/**
> + * gfx_v6_0_setup_tcc() - setup which TCCs are used
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Verify whether the current GPU has any TCCs disabled,
> + * which can happen when the GPU is harvested and some
> + * memory channels are disabled, reducing the memory bus width.
> + * For example, on the Radeon HD 7870 XT (Tahiti LE).
> + *
> + * If some TCCs are disabled, we need to make sure that
> + * the disabled TCCs are not used, and the remaining TCCs
> + * are used optimally.
> + *
> + * TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
> + * TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.
> + *
> + * For optimal performance:
> + * - Rely on the CHAN_STEER from the golden registers table,
> + *   only skip disabled TCCs but keep the mapping order.
> + * - Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
> + *   which performs better than using the same TCC twice.
> + */
> +static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
> +{
> +       u32 i, tcc, tcp_addr_config, num_active_tcc =3D 0;
> +       u64 chan_steer, patched_chan_steer =3D 0;
> +       const u32 num_max_tcc =3D adev->gfx.config.max_texture_channel_ca=
ches;
> +       const u32 dis_tcc_mask =3D
> +               amdgpu_gfx_create_bitmask(num_max_tcc) &
> +               (REG_GET_FIELD(RREG32(mmCGTS_TCC_DISABLE),
> +                              CGTS_TCC_DISABLE, TCC_DISABLE) |
> +                REG_GET_FIELD(RREG32(mmCGTS_USER_TCC_DISABLE),
> +                              CGTS_USER_TCC_DISABLE, TCC_DISABLE));
> +
> +       /* When no TCC is disabled, the golden registers table already ha=
s optimal TCC setup */
> +       if (!dis_tcc_mask)
> +               return;
> +
> +       /* Each 4-bit nibble contains the index of a TCC used by all TCPs=
 */
> +       chan_steer =3D RREG32(mmTCP_CHAN_STEER_LO) | ((u64)RREG32(mmTCP_C=
HAN_STEER_HI) << 32ull);
> +
> +       /* Patch the TCP to TCC mapping to skip disabled TCCs */
> +       for (i =3D 0; i < num_max_tcc; ++i) {
> +               tcc =3D (chan_steer >> (u64)(4 * i)) & 0xf;
> +
> +               if (!((1 << tcc) & dis_tcc_mask)) {
> +                       /* Copy enabled TCC indices to the patched regist=
er value. */
> +                       patched_chan_steer |=3D (u64)tcc << (u64)(4 * num=
_active_tcc);
> +                       ++num_active_tcc;
> +               }
> +       }
> +
> +       WARN_ON(num_active_tcc !=3D num_max_tcc - hweight32(dis_tcc_mask)=
);
> +
> +       /* Patch number of TCCs used by TCPs */
> +       tcp_addr_config =3D REG_SET_FIELD(RREG32(mmTCP_ADDR_CONFIG),
> +                                       TCP_ADDR_CONFIG, NUM_TCC_BANKS,
> +                                       num_active_tcc - 1);
> +
> +       WREG32(mmTCP_ADDR_CONFIG, tcp_addr_config);
> +       WREG32(mmTCP_CHAN_STEER_HI, upper_32_bits(patched_chan_steer));
> +       WREG32(mmTCP_CHAN_STEER_LO, lower_32_bits(patched_chan_steer));
> +}
> +
>  static void gfx_v6_0_config_init(struct amdgpu_device *adev)
>  {
>         adev->gfx.config.double_offchip_lds_buf =3D 0;
> @@ -1729,6 +1794,7 @@ static void gfx_v6_0_constants_init(struct amdgpu_d=
evice *adev)
>         gfx_v6_0_tiling_mode_table_init(adev);
>
>         gfx_v6_0_setup_rb(adev);
> +       gfx_v6_0_setup_tcc(adev);
>
>         gfx_v6_0_setup_spi(adev);
>
> --
> 2.53.0
>
