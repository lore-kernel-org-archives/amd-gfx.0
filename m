Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCCAE8536F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 13:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438BC10E0E6;
	Fri,  3 Apr 2026 13:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULfyptV9";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9583710E0E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 13:33:16 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2b8095668ebso127127eec.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 06:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775223196; cv=none;
 d=google.com; s=arc-20240605;
 b=dG20d+21Sp6iKDGVN6oIARABsoZOR2kLHqF2pLVvautXwAA99ornJ52WoAF46/ZBs5
 5vwfJGsWamr6Sf+o6oa/UjhoaKcQIIhSHCUqN24XKU5AzPi3Dh3fy7Wcapy5z4uCfvHQ
 HDaEavNoW3/T3198iJ23prTNA5yhxG5MDwLBUHFmjGO126FJKEe0VDK1SzsZsuUrTzqV
 DRiuaUwwBjZeGeqgUg5Q59prUEN06YPlGDj99bzwxwe690YNzCG3cSw7oFe+qIajPNbg
 Q8+dAP6+LpENP+V+UEHfODLIyp2IWD5sL3kpoCz9y4cxOXGX8f9wqD0WNpvUQLaqNens
 Coyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zSVFOmfn0yRRNnlr190AdFFzpQOfVN52Oc/+S5Vku7Q=;
 fh=KtpR5ErRGqziWZWxHPmcomH2RtmV3SeZmbeCdv2Ys/E=;
 b=bmSX1QNr3cXtPobM33nxmoEmRlBqsZGbcTinT8uomfmqMDTKsMhz6vkCHyU03jMPOv
 O/pU7AYa1wJGVu4rVylJF6ltE58kTylTEikDxU95I88jVSXqPR/tmWTw6B0x80od/P5G
 UZAjt4zObI0/pvhL++5ruHHfcAu+H32yDP7f+eoIUe9EnHWW39sT+W6NLIZVMtPHsIuS
 g089MzHFQzkMtxMsga22TdfLUXnQJeZUikZs+aBaYsoiCsxqNzHCNWU41KFGaF3HClk+
 ak35k/rvJpqyL9qePXBGs/n9qHTuzYCU58xq9sYe7FT855d00owNQ+mAVIMCS+x7L61o
 1D7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775223196; x=1775827996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSVFOmfn0yRRNnlr190AdFFzpQOfVN52Oc/+S5Vku7Q=;
 b=ULfyptV9PhhasOMxVC+l46Qi1kCS/r+z6fs8In4GdIm2wYNbugAGG9zbOO0blrDjsL
 zBC7FEkq/OB56/zrd1/bypK7QYjAmrTX8/UuGnQN9IglemqO9TnX4Fyv17005Dpwwo8X
 9Em2J4F/Iz8a6Hwvo9AnJfT2r23F+of8CwvedT+gicz+JfEnuki2xHxxYnWBL1wvNymH
 +ziugAhvPSzQavCnUDz0AgxAT4Oneqr74Q8h7S1yGUZk1P26DtF2aRhVVch6GTrIRMi3
 VKMt5MLNK9X9VseNZvcp24IdtYdn6357iyJAq62k+XWsCwapZTBVqlZP/9oRX4Gp62lr
 8gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775223196; x=1775827996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zSVFOmfn0yRRNnlr190AdFFzpQOfVN52Oc/+S5Vku7Q=;
 b=SeQ9lhUIOmYO7FqExp5+gRwxEPNop28DJDFhqCBcs8d/anUklKP5aiw+VeqoV6e02Z
 bO32Ef2NJS7Fo9N2Ajb/yT66c8oV5TuEwbN+s+Fbap3z9XQTyqQESBHq2RMuLJmDzqKS
 q6etpQVew6o/1P2dFbooJZ62H5dPQHd+BRDHvyOeYjI8R8BcpHEosJVHxMAt+rMePt3u
 OezHH3ok/I/n5m5NwgOUuKJpGDOzybrGhEwBkDSp6he1JqhQ38XEA3XixkJVOZOWvlje
 x9jR95oFramHkoMMXkL+HQ5Gm581yg/R8hiJxuA9EX8WIBvTIZtSEbcMHN+O0m4okcy0
 23dQ==
X-Gm-Message-State: AOJu0Yy5JBmoE89BF0VOeQoZsyc4v/+2dHDcWzcqrN3bEAfr7PCN3e4J
 gcTxBi8G92JOWvYMf5hu3pyEV3bjD4XgHMDpnlQzz+PDaMOMnLn9eHjmM4H+bY2/DtsIZa+ujhl
 7PO8rQF4gsudhrKPJcSfJXO5M5O1IZUM=
X-Gm-Gg: AeBDiet6unf6XSjVGwXzIw+QF/aSKdLEL+vPwuMp+LigKLjw3SlS+9O/4AZaMQbfJzo
 YPrqaTxFhIyGHtSy3csBimQs6Zg3jJOtVje1UwTz1HL3eth4AizrHkqJkJpfgaUmgDjYL5xVl3R
 lBN24kWwTqNymhDI2+JyJ6rpOii5KclavQbXKIEgp/NAFfkBk6Fo7dPKJLdDhiysIzrFqiPh9lg
 hRSn7/d8vZRvS8KF+xe4dJJiJUxGFTOqd0N9gFGT+i6vCYSgyL0Tfs2jAy8PpniqqRULwd9dfKD
 WW29Lj3nTGKkOhFBioM1l5jHVw1ku6KWxf7dPLc/L3E26/C2BLFrLeBhvFTG/YgK3mPHvw==
X-Received: by 2002:a05:7301:d1b:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2cbfcd54f9bmr755552eec.7.1775223195594; Fri, 03 Apr 2026
 06:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 09:33:02 -0400
X-Gm-Features: AQROBzC-PyrI3UkiH3Gn1YeXCCNFiU0qxWebppZrL3PNI29mCN95LiJyrX_I8jY
Message-ID: <CADnq5_OH-pBn_+NTA=dFOM57vi2YLkntit27VpCsKoMOgTbvPA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx_v11_0: fix GFX11 MEC pipe reset
 ordering
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Manu Rastogi <manu.rastogi@amd.com>
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

On Fri, Apr 3, 2026 at 5:49=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Hold MEC pipe reset asserted, walk every queue on that (me, pipe) and tea=
r
> down CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST via gfx_v11_0_clear_hqds_on_m=
ec_pipe(),
> then deassert reset. Avoids releasing pipe reset while HQDs may still be
> active.
>
> Legacy (non-RS64) path: read CP_MEC_CNTL for the reset mask instead of
> reusing CP_MEC_RS64_CNTL state.
>
> Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 148 +++++++++++++++----------
>  1 file changed, 91 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index ae39b9e1f7d6..18b92990179d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6906,11 +6906,39 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring=
 *ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> +/*
> + * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_RE=
QUEST for
> + * every queue on (me, pipe). HQDs must be torn down while pipe reset st=
ays
> + * asserted; only then clear the pipe reset bit.
> + * Caller must hold adev->srbm_mutex.
> + */
> +static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev,=
 u32 me,
> +                                            u32 pipe)
> +{
> +       unsigned int q;
> +       int j;
> +
> +       for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
> +               soc21_grbm_select(adev, me, pipe, q, 0);
> +               /* Start from a clean HQD dequeue state before forcing HQ=
D inactive. */
> +               WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
> +               if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> +                       WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1)=
;
> +                       for (j =3D 0; j < adev->usec_timeout; j++) {
> +                               if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIV=
E) & 1))
> +                                       break;
> +                               udelay(1);
> +                       }
> +               }
> +               WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
> +       }
> +}

Do we have a way to look up which queue was actually on the pipe?
This will lead to all queues on this pipe ultimately timing out the
next time they are used since we never re-enable the queues after the
reset.  I think we need something like amdgpu_vcn_reset_engine() for
each compute or gfx pipe.  We need to stop the schedulers for all
queues on the pipe and then mark the fences with an error and then
make sure to re-enable and test all of the queues after the reset.
Ideally, we could resume any queues that weren't on the pipe after the
reset non-destructively, but I'm not sure if that is possible or not.
If the pipe reset doesn't affect any queues which were not on the pipe
at the time, then we can just loop over all of the queues on the pipe,
and for the non-guilty ones (i.e., the ones not on the pipe), we can
save their entire unprocessed ring state and reemit it.  For the
guilty one, we we already save it's non-guilty state and restore it
after the reset.  We also need to handle KFD queues.  I think we need
to preempt the KFD queues at the start of this function and then
restore them at the end to make sure they are properly handled as
well.

Alex

> +
>  static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
>  {
>
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +       uint32_t reset_val, clean_val;
>         int r;
>
>         if (!gfx_v11_pipe_reset_support(adev))
> @@ -6920,69 +6948,73 @@ static int gfx_v11_0_reset_compute_pipe(struct am=
dgpu_ring *ring)
>         mutex_lock(&adev->srbm_mutex);
>         soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
>
> -       reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> -       clean_pipe =3D reset_pipe;
> -
>         if (adev->gfx.rs64_enable) {
> +               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +               clean_val =3D reset_val;
>
>                 switch (ring->pipe) {
>                 case 0:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE0_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE0_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE0_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE0_RESET, 0);
>                         break;
>                 case 1:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE1_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE1_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE1_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE1_RESET, 0);
>                         break;
>                 case 2:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE2_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE2_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE2_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE2_RESET, 0);
>                         break;
>                 case 3:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE3_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE3_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE3_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE3_RESET, 0);
>                         break;
>                 default:
>                         break;
>                 }
> -               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> -               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
> +               gfx_v11_0_clear_hqds_on_mec_pipe(adev, ring->me, ring->pi=
pe);
> +               soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue=
, 0);
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
>                 r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << =
2) -
>                                         RS64_FW_UC_START_ADDR_LO;
>         } else {
> +               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
> +               clean_val =3D reset_val;
> +
>                 if (ring->me =3D=3D 1) {
>                         switch (ring->pipe) {
>                         case 0:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE0_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE0_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE0_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE0_R=
ESET, 0);
>                                 break;
>                         case 1:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE1_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE1_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE1_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE1_R=
ESET, 0);
>                                 break;
>                         case 2:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE2_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE2_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE2_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE2_R=
ESET, 0);
>                                 break;
>                         case 3:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE3_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE3_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE3_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE3_R=
ESET, 0);
>                                 break;
>                         default:
>                                 break;
> @@ -6991,36 +7023,38 @@ static int gfx_v11_0_reset_compute_pipe(struct am=
dgpu_ring *ring)
>                 } else {
>                         switch (ring->pipe) {
>                         case 0:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE0_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE0_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE0_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE0_R=
ESET, 0);
>                                 break;
>                         case 1:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE1_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE1_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE1_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE1_R=
ESET, 0);
>                                 break;
>                         case 2:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE2_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE2_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE2_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE2_R=
ESET, 0);
>                                 break;
>                         case 3:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE3_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE3_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE3_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE3_R=
ESET, 0);
>                                 break;
>                         default:
>                                 break;
>                         }
>                         /* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
>                 }
> -               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> -               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
> +               gfx_v11_0_clear_hqds_on_mec_pipe(adev, ring->me, ring->pi=
pe);
> +               soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue=
, 0);
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
>                 r =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNT=
R));
>         }
>
> @@ -7028,7 +7062,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdg=
pu_ring *ring)
>         mutex_unlock(&adev->srbm_mutex);
>         gfx_v11_0_unset_safe_mode(adev, 0);
>
> -       dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: =
%s\n", ring->name,
> +       dev_dbg(adev->dev, "The ring %s pipe resets to MEC FW start PC: %=
s\n", ring->name,
>                         r =3D=3D 0 ? "successfully" : "failed");
>         /*FIXME:Sometimes driver can't cache the MEC firmware start PC co=
rrectly, so the pipe
>          * reset status relies on the compute ring test result.
> --
> 2.49.0
>
