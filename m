Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8BCF436A3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 13:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64DA910EA0C;
	Fri, 17 Apr 2026 13:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="btApDhEe";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30DB10EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 13:36:33 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12736a0147cso32536c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 06:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776432993; cv=none;
 d=google.com; s=arc-20240605;
 b=T2PCmVHzxY4gXWeV6P1wtaw165MF9gLMnS9MkwRTCHAK3NOVmZ9Ppz8Nub0AvUtDdW
 MFjXVvw47l7KO/zKCmGeynhYVCK7fZHIPvCKXvpiHnD//eXIsBiUowglHV8hepBn+Vpx
 bOafeQrj7+1MpcS3xZjvvXybY5HAxhbsxVeHNJNxiRr4ZQq706py0K8lhms3wvS0c22H
 IRJSjClLTSN9LvvS9hiaWWIveiXOLYisKEX7dhTmDswb7AG43Tk5YFmZwhsNXK6iC/Co
 MYlnOWqeA3cMBE+LtEVko4CKCPCeLEp5Zqe9fl3sThvRP2BCJ9nq0YVWRBXF4HzdZCAY
 99xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1sYiQeOo0FTQbMgLepH0Rf6O4LSziP+xNOutWeDH1WA=;
 fh=0MOuNrHd20WxR6qcaguK9s+Epp45VcbzFdDtmNqmbrE=;
 b=Qk8jE6C3J71Sl8+3ODuiEuJqTaGMMmrOESnx9zCqdL5wysphb3ZqUEhdhCD0IG/Yyy
 m2jALD8bpbquja8LT5vZtHQg5H+4iWkwD1TY84sKn3K6wo/zOQfvP8tuu7F8jAD+r0tb
 bdUdBGrKaX4nmWapzM9qUi9AhFHhNccCAKsDIgVusclt4Dxl7m8wCjFDRjUYLoPBJpMD
 WKQrVkz3bnbH6otkQGNeXAjxMNxW/5ypsyG/K04OUXSjhJSj/z3gdUGJAXKqoGjxlJ5Y
 hpPktdDTsg1WsXLikp/RTq5R2SkMVUnPlRt3STPZtDvea0XV0IZfNgq+O5kii/G0a8p3
 HrZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776432993; x=1777037793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sYiQeOo0FTQbMgLepH0Rf6O4LSziP+xNOutWeDH1WA=;
 b=btApDhEeKoU3WviJtIiMcCFrejtfPE7tBim/tmGBxVMQiikUtloWPnEd0VpyLU/Z/y
 MW8sDMtdGPGiGksNzE3lUFupkqHMjeW6ZJYMFltqyad4Q5FgVelB15Qc6qU1QMiSpMrC
 dwmKDWwDa4uyjvPDZ/pp22T/vK419z94V033VEL94GI7/OQZGaunbLcW0xvzltVUwbAU
 uYApbZnvU1hkgyDxNSjzet6FPePk0Df+U2XgtKMG/1L/2GS9LUUNYDMXJZXDm4+4aF6R
 3RFVXAcs2sQ33ZD2JcUNWhzveErNYgia3DXI4DhW+6XnBXsZJ3LE6kXabDBtp/YjoK/d
 1Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432993; x=1777037793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1sYiQeOo0FTQbMgLepH0Rf6O4LSziP+xNOutWeDH1WA=;
 b=dPhKDX07lhZsNTtlf7izKcAmw0SrlcwiCtm+QBam3D0qUZ0Lu61VRHctp79L74aRhU
 gJ2xtVBT+ING3qh9kcHiGe5VR3Ti0FYpjazPr0sTdLD3jKpX3mBFu+UsqSvxAEJ374Y/
 XHex5VShiSAszFfQoSF61icYDM8TrhaaeRVleD5L036IC2lXvf5DZat/tHMHfU2+XldG
 7sRx7Hm1HOvV4mOC/dk8QHDpNwc+PFZjwT4EPWnxEy7p4F0h/HDOeHzLoqCCAVwn8VHR
 CGd9HWKuEG/L6b2QwLDLQ1IOOtGycTHZseGXxADRoTdn0tjQ8rbw3xOk2EoSI8/BTAY+
 3alA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ec+1G8LsGBwiarhjBDX8ThEMS/b2MFlVFsDDv6GGN1gp6W+IS7gddjx4f1DWlknlMHQsEYyLl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRZdgyTaViaBGhaE+XO/sP50ffF2Iaqyaw/dT+mpfmy1MLpT92
 lXz6fjKjfdPrs8qfhtVqSi6UJiDTHtTMb0t8OWR1yXTxFwOxThgI6lLJhh6lryQLL22i+ZtQURD
 fly5mL1ZkI+GHBjnlWIYufUEhfMSB5j0=
X-Gm-Gg: AeBDieuJXlDfoZBBKWf2VR3sqp37m7S7N7/CiM1TmplI+i5aUf1N2CfAMZnEsyaK1Ym
 jc0jkesZLeS7XXaz58xdV/5RN8JIa1FDtYL7sHkU4fY/b67T9MC+pKW4VfoVc6/1dc20PXOGmGM
 Yw5gR9XhtlB4vH7jjDwc379mSVdM6Po1gY2sqxtCHqnhQWvdEVHzUqoEsVAIHj9QhM4UY7F59+j
 JzpftovEBq3bxt9Hry/F2HMI990yFCjknU61fW6T81XYN/4y48cc545WMIPsDsfIPdni7Zbd0NR
 DbWKuvyZR1l1xt3ivOzJUU4fJ6BBI3pyqUOVktp6cVgQcAN3yX4B/CNkH1F84Ss4uCDAJO/f1bD
 tJKxr
X-Received: by 2002:a05:7022:928:b0:12c:33dd:fa0b with SMTP id
 a92af1059eb24-12c73f69c12mr562884c88.2.1776432993128; Fri, 17 Apr 2026
 06:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-8-timur.kristof@gmail.com>
 <89ea2f13-57aa-4a9d-98b3-f5693e33c13a@amd.com>
In-Reply-To: <89ea2f13-57aa-4a9d-98b3-f5693e33c13a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 09:36:20 -0400
X-Gm-Features: AQROBzCvoSH0_LOcwsMW0dsD-d1DLXM3WrXB4uMycKTC1ZO5eZuROPzavaz00xo
Message-ID: <CADnq5_My527aN+SHpv5YvDCU5u3og8PwPoW7OuzXdc-ZvGRX9A@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amdgpu/gfx6: Support harvested SI chips with
 disabled TCCs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Fri, Apr 17, 2026 at 9:04=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/16/26 22:26, Timur Krist=C3=B3f wrote:
> > This commit fixes amdgpu to work on the Radeon HD 7870 XT
> > which has never worked with the Linux open source drivers before.
> >
> > Some boards have "harvested" chips, meaning that some parts of
> > the chip are disabled and fused, and it's sold for cheaper and
> > under a different marketing name.
> > On a harvested chip, any of the following can be disabled:
> > - CUs (Compute Units)
> > - RBs (Render Backend, aka. ROP)
> > - Memory channels (ie. the chip has a lower bandwidth)
> > - TCCs (ie. less L2 cache)
> >
> > Handle chips with harvested TCCs by patching the registers
> > that configure how TCCs are mapped.
> >
> > If some TCCs are disabled, we need to make sure that
> > the disabled TCCs are not used, and the remaining TCCs
> > are used optimally.
> >
> > TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
> > TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.
> >
> > Note that the TCC configuration is highly relevant to performance.
> > Suboptimal configuration (eg. CHAN_STEER=3D0) can significantly
> > reduce gaming performance.
> >
> > For optimal performance:
> > - Rely on the CHAN_STEER from the golden registers table,
> >   only skip disabled TCCs but keep the mapping order.
> > - Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
> >   which performs better than using the same TCC twice.
> >
> > Link: https://bugs.freedesktop.org/show_bug.cgi?id=3D60879
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/2664
> > Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation f=
or si v8")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 63 +++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> > index 73223d97a87f5..baddb3aa7fa3c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > @@ -1571,6 +1571,68 @@ static void gfx_v6_0_setup_spi(struct amdgpu_dev=
ice *adev)
> >       mutex_unlock(&adev->grbm_idx_mutex);
> >  }
> >
> > +/**
> > + * gfx_v6_0_setup_tcc() - setup which TCCs are used
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * Verify whether the current GPU has any TCCs disabled,
> > + * which can happen when the GPU is harvested and some
> > + * memory channels are disabled, reducing the memory bus width.
> > + * For example, on the Radeon HD 7870 XT (Tahiti LE).
> > + *
> > + * If some TCCs are disabled, we need to make sure that
> > + * the disabled TCCs are not used, and the remaining TCCs
> > + * are used optimally.
> > + *
> > + * TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
> > + * TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.
> > + *
> > + * For optimal performance:
> > + * - Rely on the CHAN_STEER from the golden registers table,
> > + *   only skip disabled TCCs but keep the mapping order.
> > + * - Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
> > + *   which performs better than using the same TCC twice.
> > + */
> > +static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
> > +{
> > +     u32 i, tcc, tcp_addr_config, num_active_tcc =3D 0;
> > +     u64 chan_steer, patched_chan_steer =3D 0;
> > +     const u32 num_max_tcc =3D adev->gfx.config.max_texture_channel_ca=
ches;
> > +     const u32 dis_tcc_mask =3D amdgpu_gfx_create_bitmask(num_max_tcc)=
 &
> > +                              REG_GET_FIELD(RREG32(mmCGTS_TCC_DISABLE)=
,
> > +                                            CGTS_TCC_DISABLE, TCC_DISA=
BLE);

I would OR dis_tcc_mask with mmCGTS_USER_TCC_DISABLE as well in case
someone has set additional TCCs to disable as well.  Other than that,
looks good to me.

Alex

> > +
> > +     /* When no TCC is disabled, the golden registers table already ha=
s optimal TCC setup */
> > +     if (!dis_tcc_mask)
> > +             return;
> > +
> > +     /* Each 4-bit nibble contains the index of a TCC used by all TCPs=
 */
> > +     chan_steer =3D RREG32(mmTCP_CHAN_STEER_LO) | ((u64)RREG32(mmTCP_C=
HAN_STEER_HI) << 32ull);
> > +
> > +     /* Patch the TCP to TCC mapping to skip disabled TCCs */
> > +     for (i =3D 0; i < num_max_tcc; ++i) {
> > +             tcc =3D (chan_steer >> (u64)(4 * i)) & 0xf;
> > +
> > +             if (!((1 << tcc) & dis_tcc_mask)) {
> > +                     /* Copy enabled TCC indices to the patched regist=
er value. */
> > +                     patched_chan_steer |=3D (u64)tcc << (u64)(4 * num=
_active_tcc);
> > +                     ++num_active_tcc;
> > +             }
> > +     }
> > +
> > +     WARN_ON(num_active_tcc !=3D num_max_tcc - hweight32(dis_tcc_mask)=
);
> > +
> > +     /* Patch number of TCCs used by TCPs */
> > +     tcp_addr_config =3D REG_SET_FIELD(RREG32(mmTCP_ADDR_CONFIG),
> > +                                     TCP_ADDR_CONFIG, NUM_TCC_BANKS,
> > +                                     num_active_tcc - 1);
> > +
> > +     WREG32(mmTCP_ADDR_CONFIG, tcp_addr_config);
> > +     WREG32(mmTCP_CHAN_STEER_HI, upper_32_bits(patched_chan_steer));
> > +     WREG32(mmTCP_CHAN_STEER_LO, lower_32_bits(patched_chan_steer));
> > +}
> > +
> >  static void gfx_v6_0_config_init(struct amdgpu_device *adev)
> >  {
> >       adev->gfx.config.double_offchip_lds_buf =3D 0;
> > @@ -1729,6 +1791,7 @@ static void gfx_v6_0_constants_init(struct amdgpu=
_device *adev)
> >       gfx_v6_0_tiling_mode_table_init(adev);
> >
> >       gfx_v6_0_setup_rb(adev);
> > +     gfx_v6_0_setup_tcc(adev);
> >
> >       gfx_v6_0_setup_spi(adev);
> >
>
