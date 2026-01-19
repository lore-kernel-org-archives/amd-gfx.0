Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF3CD29C2E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 16:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD8F10E4D7;
	Mon, 19 Jan 2026 16:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSls20lK";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A7910E4D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:19:28 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12336c0ae91so394434c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768839568; cv=none;
 d=google.com; s=arc-20240605;
 b=VEmEEfd0crdt+Gd4SGWk2YzAxQ7BgM85Lf1znFjBqMTQz0sxW+N1HikRrhpPMa7VIW
 uosSp7jTjDcNKwP8tHd1Hyf2sJBSJqTJpPSaZF3wkvto16gsvk4cLlmOClrbnGnSL3pO
 MRT0rRRjKivCOz2Be8yJRNF4709bJ9q05EobAtnw9ovUH70oETNg2IqFOBGj4AvsFrck
 RJwU7qfL3LEY3T2Cos2SLJ6VwYPCHARBuvBMDfPLEdMgIhYU7MsF7xM4cTunqKr8WP6c
 nZQ2FcUIPaATg4erYhAupTldAZe1TbMEsmFUxVV2iwZq6gMM7EEOVbopBA5ftoROUMLx
 1eZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7FP5c2W+1ytMOks6DGqqqi5SmJHr6btTh5fuQGjSLU0=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=F6hzjQAfeXo8ZiQgTWvq1+RvumB+uXl5BRF9I9rjc1fNV2IVAjTXwAR/J/kUtDHRHf
 flTdYjzjE9icu3hLQHvpm8UnHO9krT6+VX9xywcHgg+t57n49aMCk0f+5Hsy7cnZR8k6
 hdvpzaVRpMQR7k50shahbNcgFt3MWPpOxdFak/0UmluuQGTN+GdQcKD6eqx/8mEuSj4E
 z1W9R1CSM2fJYqrxZVfwvT1lf1gzI0Yd3xkAjVZB3bcSvf5hzlZF6VJ1ECM8Ju53ep7h
 d1E/58f37xumQjxpgPxV9K+1y6LxIoyor0GqEfWXUUIkPWYzvEr/hoCmGIsF+FeLiDh1
 lFfA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768839568; x=1769444368; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FP5c2W+1ytMOks6DGqqqi5SmJHr6btTh5fuQGjSLU0=;
 b=cSls20lKKDMgdmJse7Cr0CULcgx1mSYDnZb+pSrU0+cLz+Lgps9fHKGFogBLXe81BV
 nL6eUjJegEbXRmDGMQ3IncG3IU7rBr+U5Io9ttgjI3D6Vnz7z/Ks2SvQj1LCS+Ju/8mi
 MXd5HiKln9SjZToDvE8ent9QeWtWBgFpnPq285dubshiA5P3qYeieioi3FKyIlsp+BZt
 gO3YU8/Ys+F6Nfkkzxa6C7+bMPeI1GfvrfWee29nsIUSy4XYlCCl5kB4x6vyeu63ToYX
 lxw+fDouNi70XFPcr6yOJ1vmHJq0ocgR0QmguEDz03g9v9UAc/Q/bDTnANZeZ2AqUCCL
 SyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768839568; x=1769444368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7FP5c2W+1ytMOks6DGqqqi5SmJHr6btTh5fuQGjSLU0=;
 b=m10aKre7Z4I4AH82RU8oOlymURgP1B5Km++q4FNpz0NfgT5kywD+hRbVvFe4171XyQ
 fE2cjCBqvecVRcD+Of+naVWQuHwSB4xnGieuYTo0DBZj/piUm2rewL5fVb51a0AigjZH
 zIIICLWfnJDWo9ijcPZidO0HxdGPMGy1xzPl8ndugHoBmo8XG/6MEA4allqBxa5iif7z
 R5DkIyAghY5o5imzGNrR9rmbGlXc33TgSto3qaOkEvSqaVGt5VOOQPyGM4VW97jYQ0TT
 oDBD/OEAXKvz1uvhsv2bs4cc9No13NCNnlHZbDqn4cieVv9R5pfIRxl69mEMydp50THQ
 Dpkw==
X-Gm-Message-State: AOJu0YxyH0Yh8Wc8SqmJTVDLuhGFD9AS614LbKsD7InIoXpVnJfjiPhu
 ARUiA2rvZCEmZg6vZY9VHLOqsbMt1kWC94kjEB4sJkCX7B2MsnLI8jSZymX1V8l4e74rtUaT4c8
 bn9635jIrOePjp/nRxn/k5xWDgGCWxwo=
X-Gm-Gg: AY/fxX6HmGqPSFtAwrMSiuVoA1j73opN2DRvEunRt+eP8Att8Y3sSA1+bP7JGtuIuGr
 mnegmri370VSmSSRTwtxDeof5QwntoJoXCBvJ32Y6yTpW28YJzg5s3hwvjNQYDNDgoAVge72tR6
 9UmEqNQxBafmce5eqv7HXEbEbqV+Wz2D/X3sFw6wtqrae48q4m2s/nm6AVjY2EwjrmiK7eKguGE
 Ae6DUFpFyXYzWY3HwPx6WdX+wmPmwb85KqBtmYYxcGiFq3+ET3dXbUcOFe/myEQUM5bUfqANlPh
 a4DITmg=
X-Received: by 2002:a05:7022:a89:b0:123:308f:667b with SMTP id
 a92af1059eb24-12469342e6bmr45647c88.2.1768839567642; Mon, 19 Jan 2026
 08:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20260119053515.893663-1-Jesse.Zhang@amd.com>
 <20260119053515.893663-3-Jesse.Zhang@amd.com>
In-Reply-To: <20260119053515.893663-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Jan 2026 11:19:16 -0500
X-Gm-Features: AZwV_QhrrZXR7-Xp8OvIaQkkOjoRAZd72praxriy4-Nd0f2e4EA1q8cPZcdrvjU
Message-ID: <CADnq5_N9HjdZDZMjo_rWx3XXKHp-RNScY_ia9JJivM3WcytqGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/amdgpu/vcn4.0.3: implement DPG pause mode
 handling for VCN 4.0.3
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Mon, Jan 19, 2026 at 12:52=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> For MI projects, when Dynamic Power Gating (DPG) is enabled,
> VCN reset operations should be performed with DPG in pause mode.
> Otherwise, the hardware may perform undesirable reset operations
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

This patch should probably come first in the series.  You could also
merge patches 1 and 2 into one patch.  Same with 4 and 5.  Either way,
the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 41 +++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 78c13724a7ba..dd247abce1ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -847,6 +847,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vc=
n_inst *vinst,
>         int inst_idx =3D vinst->inst;
>         struct amdgpu_vcn4_fw_shared *fw_shared =3D
>                                                 adev->vcn.inst[inst_idx].=
fw_shared.cpu_addr;
> +       struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__PA=
USE};
>         struct amdgpu_ring *ring;
>         int vcn_inst, ret;
>         uint32_t tmp;
> @@ -951,6 +952,9 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vc=
n_inst *vinst,
>
>         ring =3D &adev->vcn.inst[inst_idx].ring_enc[0];
>
> +       /* Pause dpg */
> +       vcn_v4_0_3_pause_dpg_mode(vinst, &state);
> +
>         /* program the RB_BASE for ring buffer */
>         WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
>                      lower_32_bits(ring->gpu_addr));
> @@ -1360,9 +1364,13 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_=
vcn_inst *vinst)
>         int inst_idx =3D vinst->inst;
>         uint32_t tmp;
>         int vcn_inst;
> +       struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UN=
PAUSE};
>
>         vcn_inst =3D GET_INST(VCN, inst_idx);
>
> +       /* Unpause dpg */
> +       vcn_v4_0_3_pause_dpg_mode(vinst, &state);
> +
>         /* Wait for power status to be 1 */
>         SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
>                            UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> @@ -1486,6 +1494,39 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst =
*vinst)
>  static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
>                                      struct dpg_pause_state *new_state)
>  {
> +       struct amdgpu_device *adev =3D vinst->adev;
> +       int inst_idx =3D vinst->inst;
> +       uint32_t reg_data =3D 0;
> +       int ret_code;
> +
> +       /* pause/unpause if state is changed */
> +       if (adev->vcn.inst[inst_idx].pause_state.fw_based !=3D new_state-=
>fw_based) {
> +               DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %=
d",
> +                       adev->vcn.inst[inst_idx].pause_state.fw_based,  n=
ew_state->fw_based);
> +               reg_data =3D RREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE=
) &
> +                       (~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
> +
> +               if (new_state->fw_based =3D=3D VCN_DPG_STATE__PAUSE) {
> +                       ret_code =3D SOC15_WAIT_ON_RREG(VCN, inst_idx, re=
gUVD_POWER_STATUS, 0x1,
> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +
> +                       if (!ret_code) {
> +                               /* pause DPG */
> +                               reg_data |=3D UVD_DPG_PAUSE__NJ_PAUSE_DPG=
_REQ_MASK;
> +                               WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PA=
USE, reg_data);
> +
> +                               /* wait for ACK */
> +                               SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_=
DPG_PAUSE,
> +                                       UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_M=
ASK,
> +                                       UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_M=
ASK);
> +                       }
> +               } else {
> +                       /* unpause dpg, no need to wait */
> +                       reg_data &=3D ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MA=
SK;
> +                       WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg=
_data);
> +               }
> +               adev->vcn.inst[inst_idx].pause_state.fw_based =3D new_sta=
te->fw_based;
> +       }
>
>         return 0;
>  }
> --
> 2.49.0
>
