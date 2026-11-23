Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352A606A31F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SYDnN2PM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAE110EBD3;
	Mon, 23 Nov 2026 10:21:21 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4413E10EBD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 10:21:15 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a358881793so1533117f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795429273; x=1796034073; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ok5NIjAIJoXiZ63hOdyaf6H7QbVJQBpQUGkqcuW/Hpw=;
 b=SYDnN2PMixfr1xWgEBORjmT8bDgUXiKW+V+qRF+fFh7Nm8qSJdgXpGwfcRfJr8lFG7
 6HCXxnBHvsKaiwuH4YMeERHKrg02wXnj2hSYf7cLMXR8hYIlT5ArPFjRSgfDncUXDToK
 0Ou2+noTu/vdWvI36VSBjvi/UuyAYgnsTNfCbDu673AlXhKNrsLEQ+5OGM7WaOLUVw4r
 paaqFk3FhCrCGHnIw6G9/nh3fIVEPYep8VbpZ8TyJ41MVt6tUq5mAImrpdppnzqB4qwn
 pXPvxBmhhdteCkdNN2vJBODPVDHwpfFmE6zQVGUZGjNVMz2cYXZR2CzjeUbHP0LR1q5Q
 nmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429273; x=1796034073;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ok5NIjAIJoXiZ63hOdyaf6H7QbVJQBpQUGkqcuW/Hpw=;
 b=E9YeovW0piHew4aqeSdo4NKUTUQyraKaTH11aw5oQIFfq1y+T4R5DoE5ADmoySmzC2
 LZMQqDQHyKd29IpwuGhJjhDBc6vgRrgrY+F7f+EPt94ncP/wkJieD7JwOXHqDJ3zPgBJ
 NtfCiVQJG2VJvkCDuCZOXL9arBsDvZurzQlhgtn4mRZUvLuin4rKs4SBDVEgCXOnBmN5
 uoWGGTSk9C9XfwkCCNKgcAz8npRlFq+UcisUk/CP1Lz0tiPGhP9IHA4+lQdXHJ+1HN5M
 u7YWQOoNdmhsdog6jlFEYGH1w6w5RgOZkMoSI8L0a9my243fabsLW4wCJ1yXf7Cp0CH2
 lF7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErE/RzHzg8A8AlbK1nbvxNTQMAoRs6H6pJ/kMC33VQTbGwrqczQ0GzSpl6a3exlCdw4FlsexVMUV@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/qQMK/yooVfN1EMMlePuPY58E3bDROVEglTR4ukm4ts2dVT8JJ
 8LXRmFOUou/2eoyP3qHmCe7dH30Zfvva/gofxo/pYr+lC77LZcC/RXq+
X-Gm-Gg: AZFdTZchu8ZMRalM06/pId3AHtBZiKUQf6BZl3Cqk/AGjq6KhC1D7WtLjBKvknR265s
 HWcTF9GPyMJU8HV2rloKlLVwFW4EUoN4aa8T33pnLhvD9chuokBNM19le0GMwD4bKW0iOe+ybGS
 rAxJTdTeuQNW3ryBJFhsODhXMznJmzAtMA/GdOvpCejKEkvh3PcnAJjx2AnmeNiujScgJGzeC2l
 RFDWjvI94dFlVtY6+mjOKH15rDOnJi9bpaw7pGaI8cjQj5Lz1SftTdsVOueL/SMSx2jxFPBIH3w
 j54FeemX4GHeu7M+iUTorietNL2Q2FFXzTJJGg2/8zkCxBHgRnuZ8kuzukEsRjYZcy8p42Yzbqs
 QPyegvYPHzRJwcaBtxfFQ2heTMM1fKIWZ580AM6fqjzv29NUjMuUuUBEM4Eu9aUEG5ZwTB1WWh1
 M/D5RSV+/mlsRPHaBq+gtTcShxP66RHxGTzDfzMjO4V34Ap5UJskb7L96r6iw5viWTsiWyBuCm6
 j/f/5u2x13m1LMrllopBgIR/wyWCb2ydOMY5tgynjmklFFOuHpIVEdWRcyWSexdaOklJSWaPf0U
 cLIYBNpqMgPmZBjvkRZe8xVb0gCH7HQnyMDMiYg492W6uCxlAwVvCFjajsvNN/yl+EzZ9NMpVWg
 FDQlS
X-Received: by 2002:a5d:5e85:0:b0:492:b5d9:f627 with SMTP id
 ffacd0b85a97d-4abb6eed70bmr18793107f8f.46.1795429273361; 
 Mon, 23 Nov 2026 02:21:13 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm22060518f8f.16.2026.11.23.02.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:21:12 -0800 (PST)
Message-ID: <48673ced2da373e8b123c4504fc941c6205203dd.camel@gmail.com>
Subject: Re: [PATCH v4 10/13] drm/amdgpu/gfx11: add a gfx engine soft reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Mon, 23 Nov 2026 11:21:11 +0100
In-Reply-To: <DM4PR12MB5152AE15AF19DBD51A6E1F77E3452@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-10-Jesse.Zhang@amd.com>
 <22d20d88c1d6a8284f5945dd33102af9150a5d1a.camel@gmail.com>
 <DM4PR12MB5152AE15AF19DBD51A6E1F77E3452@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-23 at 05:54 +0000, Zhang, Jesse(Jie) wrote:
> AMD General
>=20
> > -----Original Message-----
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Sent: Thursday, November 19, 2026 7:47 PM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Mario
> > Sopena-Novales <Mario.Novales@amd.com>; Rastogi, Manu
> > <Manu.Rastogi@amd.com>; Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>
> > Subject: Re: [PATCH v4 10/13] drm/amdgpu/gfx11: add a gfx engine
> > soft reset
> >=20
> > On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> > > Implement soft_reset_engine() for the graphics engine of gfx11,
> > > as for
> > > gfx12, with two differences:
> > > - clear CP_VMID_RESET: a VMID reset the hung PFP didn't handle
> > > survives
> > > =C2=A0 the CPF/CPG reset;
> > > - boot PFP/ME with CP_PFP_IB_CONTROL cleared and restore it
> > > afterwards:
> > > =C2=A0 set, it makes the F32 PFP of the APUs resume from power gating
> > > and
> > > wait
> > > =C2=A0 for a clear state that never comes.
> > >=20
> > > The CPF/CPG reset already puts PFP/ME back at their firmware
> > > start
> > > address, so unhalting them restarts the RS64 and F32 firmware
> > > alike.
> > >=20
> > > v4: Implement soft_reset_engine() directly instead of a
> > > reset_engine
> > > gfx
> > > =C2=A0=C2=A0=C2=A0 callback, drop gfx_v11_0_restart_gfx_rs64(), and b=
oot with
> > > =C2=A0=C2=A0=C2=A0 CP_PFP_IB_CONTROL cleared for the F32 firmware (Ti=
mur).
> > >=20
> > > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 134
> > > +++++++++++++++++++++++++
> > > =C2=A01 file changed, 134 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > index 798015689f0c..80b91459f5b0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > @@ -6777,6 +6777,139 @@ static void
> > > gfx_v11_0_emit_mem_sync(struct
> > > amdgpu_ring *ring)
> > > =C2=A0=C2=A0=C2=A0 amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> > > =C2=A0}
> > >=20
> > > +/* The CP DMA and the interfaces its memory requests go through
> > > */
> > > +#define GFX11_CP_STAT_MEM_BUSY
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (CP_STAT__DMA_BUSY_MASK | \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CP_STAT__TCIU_BUSY_MASK | \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CP_STAT__RCIU_BUSY_MASK | \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CP_STAT__UTCL2IU_BUSY_MASK)
> > > +
> > > +/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME
> > > again.
> > > */
> > > +static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device
> > > *adev) {
> > > +=C2=A0=C2=A0 u32 tmp, cntl, me_cntl, ib_control;
> > > +=C2=A0=C2=A0 int i;
> > > +
> > > +=C2=A0=C2=A0 amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> > > +=C2=A0=C2=A0 /* MES fetches its queues through CPF: keep it out of t=
he
> > > reset. */
> > > +=C2=A0=C2=A0 amdgpu_mes_lock(&adev->mes);
> >=20
> > I wonder if we should lock the SRBM mutex here. What do you think?
> I don't think it's needed: none of the registers written here are
> banked
> by GRBM_GFX_CNTL (CP_ME_CNTL, CP_SOFT_RESET_CNTL, GRBM_SOFT_RESET,
> CP_STAT, CP_VMID_RESET). If we take it anyway, it must come after the
> MES
> lock, as mes_v11_0_reset_queue_mmio() takes srbm_mutex with the MES
> lock
> held.

I see. That sounds OK to me, then.

>=20
>=20
> >=20
> > > +
> > > +=C2=A0=C2=A0 me_cntl =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> > > +=C2=A0=C2=A0 ib_control =3D RREG32_SOC15(GC, 0,
> > > regCP_PFP_IB_CONTROL);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* cleared by th=
e reset */
> > > +
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> > > +=C2=A0=C2=A0 udelay(50);
> > > +
> > > +=C2=A0=C2=A0 /* A CP DMA in flight during the reset leaves the ME bu=
sy
> > > after it. */
> > > +=C2=A0=C2=A0 for (i =3D 0; i < adev->usec_timeout; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(R=
REG32_SOC15(GC, 0, regCP_STAT) &
> > > GFX11_CP_STAT_MEM_BUSY))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 udelay(=
1);
> > > +=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0 /* GFX_ONLY keeps compute and MES out; CPF alone leaves=
 the
> > > stream stuck. */
> > > +=C2=A0=C2=A0 cntl =3D RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL,
> > > GFX_ONLY_SOFT_RESET, 1);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL,
> > > GFX_HQD_REG_RESET, 1);
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
> > > +
> > > +=C2=A0=C2=A0 tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_=
CPF,
> > > 1);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_=
CPG,
> > > 1);
> >=20
> > I just tested this on Strix Halo (GFX11.5).
> > We need to set the SOFT_RESET_GFX bit here in order to reset the
> > fixed-
> > function graphics pipeline. Otherwise this can't recover from cases
> > when the
> > fixed-function pipeline hangs, for example a buggy NGG shader.
>=20
> The case I tested was a bad-length (oversize) packet hang in the CP.
> CPF/CPG reset
> alone recovers it. Adding SOFT_RESET_GFX also brings the gfx CP back,
> but then SDMA times out and recovery escalates to MODE1.


I tested this on Strix Halo, and I didn't see an issue with SDMA.
Which GPU did you test on and how did you reproduce this?

I don't see any reason why SOFT_RESET_GFX would affect the SDMA.
As far as I know the SDMA would be the SOFT_RESET_SDMA0/1 bits.
Could you explain more what is happening?

Is there a different alternative besides SOFT_RESET_GFX to reset the
fixed-function graphics pipeline?

> This suggests that the current sequence needs additional recovery
> work
> when SOFT_RESET_GFX is included. It doesn't establish how your NGG
> case
> should be handled. Could we keep the CP-only reset or gpu reset for
> the buggy NGG
> recovers, and use a broader reset if that recovery fails?

The GFX engine reset should be able to recover from any errors that can
happen on graphics. If that is not possible, we can discuss what is a
good alternative.

I think first we need to understand why the SDMA was affected in your
testing (and see we can fix it), then we can come back to this
question.

>=20
> >=20
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> > > +=C2=A0=C2=A0 tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> >=20
> > This line should be moved below the delay.
> >=20
> > > +=C2=A0=C2=A0 udelay(50);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_=
CPF,
> > > 0);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_=
CPG,
> > > 0);
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> > > +=C2=A0=C2=A0 tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> > > +
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
> > > +
> > > +=C2=A0=C2=A0 /* The halted PFP stays busy: only wait for the memory
> > > requests. */
> > > +=C2=A0=C2=A0 for (i =3D 0; i < adev->usec_timeout; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(R=
REG32_SOC15(GC, 0, regCP_STAT) &
> > > GFX11_CP_STAT_MEM_BUSY))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 udelay(=
1);
> > > +=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0 /* A VMID reset the hung PFP didn't handle survives the
> > > reset. */
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);
> >=20
> > Does this introduce a race condition between per-queue resets and
> > the soft
> > reset? I mean, what happens if we are doing a queue reset on a
> > compute
> > queue at the same time while this function is resetting the GFX
> > engine?
>=20
> They don't run at the same time: the engine reset holds
> gfx.mec.reset_mutex, like amdgpu_gfx_reset_mes_compute() and
> amdgpu_gfx_reset_mes_gfx() do, and the single MES/MMIO queue resets
> (amdgpu_mes_reset_legacy_queue(), amdgpu_mes_reset_queue_mmio()) take
> the
> MES lock, which is held across the pulse. GFX_ONLY_SOFT_RESET also
> keeps
> the compute HQDs out of the pulse.

Sounds good. Thanks for the explanation.

>=20
> Jesse
> >=20
> > > +=C2=A0=C2=A0 amdgpu_mes_unlock(&adev->mes);
> > > +
> > > +=C2=A0=C2=A0 tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REG_GET_=
FIELD(me_cntl, CP_ME_CNTL,
> > > CE_HALT));
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> > > +=C2=A0=C2=A0 amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > > +
> > > +=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0 * Boot with CP_PFP_IB_CONTROL cleared: set, it ma=
kes the
> > > F32 PFP resume
> > > +=C2=A0=C2=A0=C2=A0 * from power gating and wait for a clear state th=
at never
> > > comes.
> > > +=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0 tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
> > > +=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> > > +=C2=A0=C2=A0 for (i =3D 0; i < adev->usec_timeout; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!RR=
EG32_SOC15(GC, 0, regCP_STAT))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 udelay(=
1);
> > > +=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0 WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
> > > +
> > > +=C2=A0=C2=A0 return i < adev->usec_timeout ? 0 : -ETIMEDOUT; }
> > > +
> > > +static int gfx_v11_0_soft_reset_engine(struct amdgpu_ip_block
> > > *ip_block,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amdgpu_ring_=
type
> > > ring_type,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_use=
rmode_queue
> > > *guilty_queue)
> > > +{
> > > +=C2=A0=C2=A0 struct amdgpu_device *adev =3D ip_block->adev;
> > > +=C2=A0=C2=A0 int i, r;
> > > +
> > > +=C2=A0=C2=A0 if (ring_type !=3D AMDGPU_RING_TYPE_GFX)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
-EOPNOTSUPP;
> > > +
> > > +=C2=A0=C2=A0 mutex_lock(&adev->gfx.mec.reset_mutex);
> > > +=C2=A0=C2=A0 amdgpu_gfx_off_ctrl(adev, false);
> > > +
> > > +=C2=A0=C2=A0 /* A hung gfx stream can keep MES from suspending: rese=
t
> > > anyway. */
> > > +=C2=A0=C2=A0 amdgpu_mes_suspend(adev, 0);
> > > +=C2=A0=C2=A0 amdgpu_userq_save_hqds(adev, AMDGPU_HW_IP_GFX);
> > > +
> > > +=C2=A0=C2=A0 r =3D gfx_v11_0_soft_reset_gfx_cp(adev);
> > > +=C2=A0=C2=A0 if (r) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err=
(adev->dev, "gfx CP still busy after reset,
> > > CP_STAT 0x%08x\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RREG32_SOC15(GC, 0, regCP_STAT))=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fa=
il;
> > > +=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0 /* The reset cleared the HQD of the kernel gfx queue: m=
ap it
> > > again. */
> > > +=C2=A0=C2=A0 r =3D amdgpu_gfx_disable_kgq(adev, 0);
> > > +=C2=A0=C2=A0 if (r)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fa=
il;
> > > +=C2=A0=C2=A0 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_=
gfx_mqd_reset_restore(&adev-
> > > > gfx.gfx_ring[i]);
> > > +=C2=A0=C2=A0 r =3D amdgpu_gfx_enable_kgq(adev, 0);
> > > +=C2=A0=C2=A0 if (!r)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D g=
fx_v11_0_cp_gfx_start(adev);
> > > +=C2=A0=C2=A0 if (r)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fa=
il;
> > > +
> > > +=C2=A0=C2=A0 amdgpu_userq_restore_hqds(adev, AMDGPU_HW_IP_GFX,
> > > guilty_queue);
> > > +=C2=A0=C2=A0 r =3D amdgpu_mes_resume(adev, 0);
> > > +=C2=A0=C2=A0 goto out;
> > > +
> > > +fail:
> > > +=C2=A0=C2=A0 amdgpu_userq_clear_hqds(adev, AMDGPU_HW_IP_GFX);
> > > +=C2=A0=C2=A0 amdgpu_mes_resume(adev, 0);
> > > +out:
> > > +=C2=A0=C2=A0 amdgpu_gfx_off_ctrl(adev, true);
> > > +=C2=A0=C2=A0 mutex_unlock(&adev->gfx.mec.reset_mutex);
> > > +=C2=A0=C2=A0 return r;
> > > +}
> > > +
> > > =C2=A0#define GFX11_HPD_QUEUE_STATE_CONNECTED_MIN=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3
> > > =C2=A0#define GFX11_HPD_QUEUE_STATE_CONNECTED_MAX=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 15
> > >=20
> > > @@ -7045,6 +7178,7 @@ static const struct amd_ip_funcs
> > > gfx_v11_0_ip_funcs =3D {
> > > =C2=A0=C2=A0=C2=A0 .suspend =3D gfx_v11_0_suspend,
> > > =C2=A0=C2=A0=C2=A0 .resume =3D gfx_v11_0_resume,
> > > =C2=A0=C2=A0=C2=A0 .wait_for_idle =3D gfx_v11_0_wait_for_idle,
> > > +=C2=A0=C2=A0 .soft_reset_engine =3D gfx_v11_0_soft_reset_engine,
> > > =C2=A0=C2=A0=C2=A0 .soft_reset =3D gfx_v11_0_soft_reset,
> > > =C2=A0=C2=A0=C2=A0 .set_clockgating_state =3D gfx_v11_0_set_clockgati=
ng_state,
> > > =C2=A0=C2=A0=C2=A0 .set_powergating_state =3D gfx_v11_0_set_powergati=
ng_state,
