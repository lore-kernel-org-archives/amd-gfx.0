Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D76C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 21:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E583310E2E3;
	Tue, 15 Sep 2026 21:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X7ZcJYXR";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E3510E2E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 21:37:23 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39666bed441so12455a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 14:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789508243; cv=none;
 d=google.com; s=arc-20260327;
 b=C3bQfgQHXgzA1tRXZyaupofQyCyCPl9aR2bqIjRYMwGfEzNi5hFKV9LPNMIjj//84e
 6bY2YEC8It7iP7uJIWSvPyfYOKiu5Hcb5tdwyOHkjsYSL3OHrLvn6GVhUlftFFfqb9M0
 mf6pCdHGFjRPWzqtz1bi/a8/3YGSxtHxkR053iuShgG+xdwGeR0xVt1wjxB1rKDQECf6
 qo+RCHachOOhktIn8+Sz4wsxGgWylCDQ3EsnQFRG2pY5J1XnXlBIcsRnQSb7koue8hZg
 R29DSNofNGeQ0EFNB2tjgn/PHGzSXvcjvmYPoD5gL/XtHjYlnBFlDieu/ik+eAnNa+l9
 O7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZpobX/6TbiIpM2JxKI5xMxoH6DPdVaxPOUW9ecbL2Uc=;
 fh=v0PxrfHfgrw3RzSb3y+0n2ax/DWmvYTbeMw54RURFlQ=;
 b=sTr4LaoHvW65mcAabCM9+vQe+XL1qFuF9n6Vv1vrpNgyRXkjR2QgO7XxKQJ8YEuJ12
 vAreD/OvaVKrY18Oa7jUFNh8FcJUISTlTQodrv29YamBwJxydrbEjL6q9nK/Br7VBqHk
 RrQWZIZSZU8UcoAI9TeYD+s95Txfn/zB9PJwvwkDKpM2QsJsGdxTaPT2WSmC0eVT8tAJ
 6v+Xumdhl/TJ3Ah/2jiDAC76FVbjI665kLV/2Mo5tRxd/pJKZxVL7L4j41DDgk6sVoIb
 Qmxt4GH9C8EwZNLPdjwAolfSPbeZFijhYRkeJHv+DXRlEFxH/lgg/KVjwq3OpAwW73AB
 YXAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789508242; x=1790113042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZpobX/6TbiIpM2JxKI5xMxoH6DPdVaxPOUW9ecbL2Uc=;
 b=X7ZcJYXRln6Iqu8mOR1joIi5NTpZSv2ADdqhskzLnGSx5HZXQSCWhojvlKjTJc53QW
 DrOWi25DwgBfYetAUM6RiVei8ujWs6T1eocBkveFMrUMU0xLxu8DNIMR5Cdp5nG7Y4+O
 h6RE63/kjijVT5j6/rwsNWbdxSyUKYOkPPOo67GtPE3PPJgyBSkgrkB8AELZ7eN7QE4q
 cpYg+RSyBR+CcAxUWWjJzTK3NSXKiCRlnqCK/HrHDPkQte/mtkGq7TIea257/dtgrhPp
 hdsdT/8KBG3qMFzWF8+Bi+bK3nXGnp2r3zf1lDPr+nYimSRPYy/7z8UR9EdZOpi00HOM
 ONwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789508242; x=1790113042;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZpobX/6TbiIpM2JxKI5xMxoH6DPdVaxPOUW9ecbL2Uc=;
 b=pVj8SKxakRuMVY80ZXgpcwFfSarbGtePXDByO5n0xiWqgq+txHuBrnTScQarl18E1u
 uV77t0iQqVBWdAymRff3AcxsqCMPTuKQFbZt9oowQJFryOYQJy08rmXESCwo6K/tDs76
 AkoHEtfYQQF8gsMXwXnpl5XClG86+cXmElogIGPQa3nFdx2DC2qqt24OJszKWSQezvv/
 NpiYj04G+Z+Uo83SSfElD+PsBhTHv89P6i+32SPQIYxY0IA0Yay3oAKDSz7lr+/c90ud
 624dCvxDgrDI6BW6c2zlyaj3CkiUgEb3nco2m2UiCEVPbLGjLfPu9QdCdpWGqPiqPZPh
 Dxew==
X-Gm-Message-State: AFuF++m3wtkPI5azUluxWDQqBG4peU9WI8SMBUlgWSw5OMyqP4BdCxny
 psVAabHYeX3dp7RUONW3GvRweEQKU0lFeoywG5E5OQ4JLQqL3cZS78/TorL2oMxH1f/y6YQoryw
 jCIVExuGEIu2e9Zfl/IaXRf4K0fn0c5Q=
X-Gm-Gg: AYBFou2BvYQDgAh59idxbTcGhs7zrEOFpptkpP+9yARBiFHDxnUWQ0xEqbKBYTMXgNj
 grBb+Cr8/lVwfaMObs3z21HuCPJ+N47uA5trPYkiv0cOsw1NRbTkJB4yjfr4Swi00TIR6rrVqsc
 oE/bvcTFiQTqBo0fHCpfAiA8ynAhhApSkGFumIluGmGAF33RhZmuaZkydJnKq1FBpNNt/e76snL
 0c93UCCYGaZ0+IbpvXzHTzwqVu3mZanw2khLtGJcaVWMBSAZ18sB6Md7O1g4XcbHNqu+ULpMDjw
 RUR+SLz17o8tQdJgVAhwrl95pK9KdG1ESoF+SKMX2RqECXvPA0nLCuZeb7EgBgTU5GeJwxkZawr
 6yXbCpOoQofAUCwylsW5ZOzg1N+2dV155SObHKV4wUQ==
X-Received: by 2002:a17:90b:2552:b0:390:af7c:fe5e with SMTP id
 98e67ed59e1d1-39e1e2f43dfmr316113a91.2.1789508242469; Tue, 15 Sep 2026
 14:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260915212539.2197287-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20260915212539.2197287-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 17:37:10 -0400
X-Gm-Features: AcwNN1X08Rmlxjy8-PEejsr0zvPtU7QMlEvdXPYkaSfXbVzJm-tp7AHHXyWQccg
Message-ID: <CADnq5_MzH3POadBHYDFnBnET=yt=10Lj24+ptcDR2n6=Y6MB7w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Drop csb for gfx12.1
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
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

On Tue, Sep 15, 2026 at 5:36=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> It's not required for compute only part
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 94 +-------------------------
>  1 file changed, 2 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index d7effa43c0fa..9677f91ef20c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -41,7 +41,6 @@
>  #include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
>
>  #include "soc15.h"
> -#include "clearstate_gfx12.h"
>  #include "v12_structs.h"
>  #include "gfx_v12_1.h"
>  #include "mes_v12_1.h"
> @@ -447,62 +446,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_de=
vice *adev)
>         return err;
>  }
>
> -static u32 gfx_v12_1_get_csb_size(struct amdgpu_device *adev)
> -{
> -       u32 count =3D 0;
> -       const struct cs_section_def *sect =3D NULL;
> -       const struct cs_extent_def *ext =3D NULL;
> -
> -       count +=3D 1;
> -
> -       for (sect =3D gfx12_cs_data; sect->section !=3D NULL; ++sect) {
> -               if (sect->id =3D=3D SECT_CONTEXT) {
> -                       for (ext =3D sect->section; ext->extent !=3D NULL=
; ++ext)
> -                               count +=3D 2 + ext->reg_count;
> -               } else
> -                       return 0;
> -       }
> -
> -       return count;
> -}
> -
> -static void gfx_v12_1_get_csb_buffer(struct amdgpu_device *adev, u32 *bu=
ffer)
> -{
> -       u32 count =3D 0, clustercount =3D 0, i;
> -       const struct cs_section_def *sect =3D NULL;
> -       const struct cs_extent_def *ext =3D NULL;
> -
> -       if (adev->gfx.rlc.cs_data =3D=3D NULL)
> -               return;
> -       if (buffer =3D=3D NULL)
> -               return;
> -
> -       count +=3D 1;
> -
> -       for (sect =3D adev->gfx.rlc.cs_data; sect->section !=3D NULL; ++s=
ect) {
> -               if (sect->id =3D=3D SECT_CONTEXT) {
> -                       for (ext =3D sect->section; ext->extent !=3D NULL=
; ++ext) {
> -                               clustercount++;
> -                               buffer[count++] =3D ext->reg_count;
> -                               buffer[count++] =3D ext->reg_index;
> -
> -                               for (i =3D 0; i < ext->reg_count; i++)
> -                                       buffer[count++] =3D cpu_to_le32(e=
xt->extent[i]);
> -                       }
> -               } else
> -                       return;
> -       }
> -
> -       buffer[0] =3D clustercount;
> -}
> -
>  static void gfx_v12_1_rlc_fini(struct amdgpu_device *adev)
>  {
> -       /* clear state block */
> -       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> -                       &adev->gfx.rlc.clear_state_gpu_addr,
> -                       (void **)&adev->gfx.rlc.cs_ptr);
> -
>         /* jump table block */
>         amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
>                         &adev->gfx.rlc.cp_table_gpu_addr,
> @@ -543,19 +488,7 @@ static void gfx_v12_1_init_rlcg_reg_access_ctrl(stru=
ct amdgpu_device *adev)
>
>  static int gfx_v12_1_rlc_init(struct amdgpu_device *adev)
>  {
> -       const struct cs_section_def *cs_data;
> -       int r, i, num_xcc;
> -
> -       adev->gfx.rlc.cs_data =3D gfx12_cs_data;
> -
> -       cs_data =3D adev->gfx.rlc.cs_data;
> -
> -       if (cs_data) {
> -               /* init clear state block */
> -               r =3D amdgpu_gfx_rlc_init_csb(adev);
> -               if (r)
> -                       return r;
> -       }
> +       int i, num_xcc;
>
>         /* init spm vmid with 0xf */
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> @@ -1618,21 +1551,6 @@ static void gfx_v12_1_xcc_enable_gui_idle_interrup=
t(struct amdgpu_device *adev,
>         WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_INT_CNTL_RING0, tmp)=
;
>  }
>
> -static int gfx_v12_1_xcc_init_csb(struct amdgpu_device *adev,
> -                                 int xcc_id)
> -{
> -       adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
> -
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_HI,
> -                       adev->gfx.rlc.clear_state_gpu_addr >> 32);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_LO,
> -                       adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> -                    regRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
> -
> -       return 0;
> -}
> -
>  static void gfx_v12_1_xcc_rlc_stop(struct amdgpu_device *adev,
>                                    int xcc_id)
>  {
> @@ -1837,15 +1755,11 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu=
_device *adev,
>         int r;
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> -               gfx_v12_1_xcc_init_csb(adev, xcc_id);
> -
>                 if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>                         gfx_v12_1_xcc_rlc_enable_srm(adev, xcc_id);
>         } else {
> -               if (amdgpu_sriov_vf(adev)) {
> -                       gfx_v12_1_xcc_init_csb(adev, xcc_id);
> +               if (amdgpu_sriov_vf(adev))
>                         return 0;
> -               }
>
>                 gfx_v12_1_xcc_rlc_stop(adev, xcc_id);
>
> @@ -1862,8 +1776,6 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_d=
evice *adev,
>                                 return r;
>                 }
>
> -               gfx_v12_1_xcc_init_csb(adev, xcc_id);
> -
>                 gfx_v12_1_xcc_rlc_start(adev, xcc_id);
>         }
>
> @@ -2919,8 +2831,6 @@ static const struct amdgpu_rlc_funcs gfx_v12_1_rlc_=
funcs =3D {
>         .set_safe_mode =3D gfx_v12_1_xcc_set_safe_mode,
>         .unset_safe_mode =3D gfx_v12_1_xcc_unset_safe_mode,
>         .init =3D gfx_v12_1_rlc_init,
> -       .get_csb_size =3D gfx_v12_1_get_csb_size,
> -       .get_csb_buffer =3D gfx_v12_1_get_csb_buffer,
>         .resume =3D gfx_v12_1_rlc_resume,
>         .stop =3D gfx_v12_1_rlc_stop,
>         .reset =3D gfx_v12_1_rlc_reset,
> --
> 2.43.0
>
