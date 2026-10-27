Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0936606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i261/Ixj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38AFE10E38E;
	Tue, 27 Oct 2026 15:53:03 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4C710F6B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:52:57 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-990bc7aed3dso2534241.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793116376; cv=none;
 d=google.com; s=arc-20260327;
 b=QU83BAAxzTPbi/5sCGjTPQotVbmDerGZso+3ba3DhQKcy8Ag85lG/rYcbY0+saAzNE
 TrM21Gms9XGECZ5nOOYRTAJr4BQZ2nTy6GqUZWAqMrJA9mCW2ylZyZZx4ieN1GDzxULq
 F03sQN6Ms3NeFNNZV+WbdEde63hSVvbi7to6gSvnR7T90LZ2dq9CVOAHnmav6pafULHL
 AZZ55P57DYtTNQy+fh7gvmOMDja45Smsdz7Wp2DoFcu5oHWl+raTjt5C1l2B+PSnNscG
 7zYHggsUUi6/G3Vy7GtXC8EJ62OjzQ9zAMQKP5T8PHBErs2pJYzdSpPgf5f8BU08oMot
 jzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lu/QeKLU2dWLNzMZRte+u9fozfFXjmX5mkXEeBMb+Hs=;
 fh=L1Zq8pjd/jtaRIXlQv7/blW39adfknSOItCaajOVxU0=;
 b=XXfWgEYgqf0ElqywZRNB5ix/qIDrF7dGO7jZxwASkJ4uuTcltfWt6QrS7ADTjxBulQ
 jiDHLHUn6WlY3aPBkwgi6zcI80inJH/CeDOcoN+HznsT0t+2eoSI9Ku9zUD3+1nVdYlA
 FhBXrPmkAaFDvWdsqU59EGuYJ/U9s1LWk+NMShLWh9mSziirRtZk0eHKV5DLfuB2Y0VZ
 x+hx8xXzrtGHioy2xIMC+jsui2R3hWmcAcO6tECEgsOLrqh5r4s7TAxi39t+R5lPVBYb
 mU8steR5FD4Et8DkOMkEJBwzDfh2FENBIMoJz0di1lghaqDzaqz9oyJawg8P/c2GuFFd
 tK7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793116376; x=1793721176; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lu/QeKLU2dWLNzMZRte+u9fozfFXjmX5mkXEeBMb+Hs=;
 b=i261/IxjMuldi/Ht9vIldYjPrNaAWEn/djiPQBOPvcdBkB08itm6ax00j9B0BncCkf
 QKCwz12rRnASeAF1vC/ol0Bz0wZ2WgrSeBnFVHyjtAHE2MxJkUv9FIiiy+1sX1GHfB1I
 dXpW3bSS5s35IHsHjOsANmfDI5tcE421RIuTJmlwTywjdCCS/lnENJpVoDb4sLfXS1Kx
 2qsTCOxTcqaN6nHvvMOUvCA53Qdx6kE8XJlYuaLgrFDgVjDE2ILkWuq78jKsIRy01Kxp
 dG44bjofi3vpQBiYTHX6Jmsgp6RL5g30m9SXIR2bwc5dfWRfbcUg2RgpQlyeBsXI9myE
 PNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116376; x=1793721176;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lu/QeKLU2dWLNzMZRte+u9fozfFXjmX5mkXEeBMb+Hs=;
 b=xLGVR3ynrav6J25Vs4H36xkZsuUlmRUgILdiLtqektT/tJWG6X+hIajifcQGpArm99
 JKIam/ZiBknQEqn1DG9Bt/HmsY7aIoiatWzix1NYqeS1IitLSg8kw+TYjD4XNY+JLtnH
 i+x38MGtuq0pJNIV9WTQNr2RmU5C8DLUT7NiM051iMQLjxS2xbnP1Sgstu/Uegamwv0U
 JNb9EyZc8ie5cMTxbbGLkXcjfXiBFbdOpJJLrZwfGau+uuJGZQJA/oDgF/slw+2DBI53
 DRV64D7qwfLA+tMNbYTz4TGzMQucXOuamnz1sttqSCK9n7WVJmbQyBx0+oUru/WevJJm
 lTbg==
X-Gm-Message-State: AFq9FYKwIGwg6y4HEDlCSpA+1mtFsxt2e+G8KAvK1vg0KMlgx6r8O7SC
 z8VtWlWtJQ3/UnZeOyotXDWzNXKOjQjmGoY6MGq97SJfQBMgPLsuXs7uxPDbgfBlCnOz+NC2mBn
 k/k7vD7OuqzIYZ/6mG8sdSFukn1xE5O0=
X-Gm-Gg: AYBFou3fHYNSkV/FyXkcVcr9BXRxEkSBz+veS6BYxERGzbzZPRw9v/pyzrazzzHNrTH
 oYpuEVOWyUn8wR5qH2z+gJFZjfxlparsPEoZkIIu1LIV19i37ep8ElNc5OMC9nHaqpVD++IbdoW
 s0lu66avGSHT7qnElQKcuweeQ5YqeELLHHJ4sxSb8+F1mmHMxEDpqGfcsQqSQh1nv9vutbwbssn
 mytKMbodsf4XF7CD70zo/uAYjOUQj/eZYTI6Jbn+1KvHsxYHwNaSMQPMVceGhqNkXubBcv9MXkB
 dhe/NuzIa1JFROTV14InlOqQF7BJXQ9hX0TMyVQU2UpfQGbaht5qoQNs/G33USlSqKrav6RV/7F
 Kmdq1TwdEqwIVVREiRkOYNj2Qv7B5OqQf7s2ZAXAZm7wee0zvhsgmuvU1xJWkO9CwlKYifuNgC0
 FdzayARgNYu+dFoWyHZ0YXsMd3
X-Received: by 2002:a05:6102:8648:10b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7ce5cabd66fmr3806751137.1.1793116376325; Tue, 27 Oct 2026
 08:52:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027135024.1391-1-Milan.Milicevic@amd.com>
In-Reply-To: <20261027135024.1391-1-Milan.Milicevic@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 11:52:43 -0400
X-Gm-Features: AclHuK__GaP1GFu_F73yLT0G0odHd_rg6g_r7s3QBAHFhw3BINquj7ROGHLkTRE
Message-ID: <CADnq5_PV3Hv0DvPgeBRJYquA5sUqHdyMUAES5fLmJAHXE3d+Tg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling
 interrupts for navi10_ih
To: Milan Milicevic <Milan.Milicevic@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Danijel.Slivka@amd.com, 
 Alexander.Deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:02=E2=80=AFAM Milan Milicevic
<Milan.Milicevic@amd.com> wrote:
>
> From: Danijel Slivka <Danijel.Slivka@amd.com>
>
> Port this change to navi10_ih.c:
> commit afbf7955ff01 ("drm/amdgpu: clear RB_OVERFLOW bit when enabling int=
errupts")
>
> Setting IH_RB_WPTR to 0 does not clear RB_OVERFLOW if RB_ENABLE is not
> set. Pulse WPTR_OVERFLOW_CLEAR after RB_ENABLE (and with
> WPTR_OVERFLOW_ENABLE) so overflow is cleared when interrupts are
> enabled.
>
> Signed-off-by: Danijel Slivka <Danijel.Slivka@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd=
/amdgpu/navi10_ih.c
> index 1dae7df9ee17..6edef75846a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -161,6 +161,34 @@ static int navi10_ih_toggle_ring_interrupts(struct a=
mdgpu_device *adev,
>         tmp =3D RREG32(ih_regs->ih_rb_cntl);
>         tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0=
));
>         tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
> +
> +       if (enable) {
> +               /* Unset the CLEAR_OVERFLOW bit to make sure the next ste=
p
> +                * is switching the bit from 0 to 1
> +                */
> +               tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 0);
> +               if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih=
(adev)) {
> +                       if (psp_reg_program(&adev->psp, ih_regs->psp_reg_=
id, tmp))
> +                               return -ETIMEDOUT;
> +               } else {
> +                       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +               }
> +
> +               /* Clear RB_OVERFLOW bit */
> +               tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 1);
> +               if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih=
(adev)) {
> +                       if (psp_reg_program(&adev->psp, ih_regs->psp_reg_=
id, tmp))
> +                               return -ETIMEDOUT;
> +               } else {
> +                       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +               }
> +
> +               /* Unset the CLEAR_OVERFLOW bit immediately so new overfl=
ows
> +                * can be detected.
> +                */
> +               tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R, 0);
> +       }
> +
>         /* enable_intr field is only valid in ring0 */
>         if (ih =3D=3D &adev->irq.ih)
>                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enab=
le ? 1 : 0));
> --
> 2.43.0
>
